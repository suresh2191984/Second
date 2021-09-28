using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;
using Attune.Solution.DAL;
using System.Security.Cryptography;
using System.Text;
using System.IO;

public partial class InvestigationSearch : BasePage
{
    List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
    long pVisitID = 0;
    long pPatientID = 0;
    int pRefPhyID = 0;
    long pRefOrgID = 0;
    int pClientID = 0;//Actully it is RateID
    int pCollectionCentreID = 0;
    int pPayerID = 0;
    long result = -1;
    int type = 0;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
    long returncode = -1;
    string PaymentLogic = String.Empty;
    long Rid = 0;
    string BillType = string.Empty;
    string PictureName = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
           
     
            if (!IsCrossPagePostBack)
            {
                if (PaymentLogic == String.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails("INV", OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }
                if (PaymentLogic.ToLower() == "before")
                {
                    rdoPayNow.Checked = true;
                }
                else
                {
                    rdoPayLater.Checked = true;
                }
                if (Request.QueryString["billtype"] != null)
                {
                    BillType = Request.QueryString["billtype"];
                }
                Int64.TryParse(Request.QueryString["vid"], out pVisitID);
                Int64.TryParse(Request.QueryString["pid"], out pPatientID);
                Int32.TryParse(Request.QueryString["cid"], out pClientID);
                Int32.TryParse(Request.QueryString["ccid"], out pCollectionCentreID);
                Int32.TryParse(Request.QueryString["PayID"], out pPayerID);
                if (BillType == "skip")
                {
                    rdoSkipBill.Checked = true;
                }
                if (pClientID == 0)
                {
                    ErrorDisplay1.ShowError = true;
                    ErrorDisplay1.Status = "There was a problem. Please try again or contact system administrator";
                    CLogger.LogInfo("There was a problem while saving registration details.");
                    pageBlock.Style.Add("display", "none");
                }
                if (Request.QueryString["Rid"] != null)
                {
                    Int64.TryParse(Request.QueryString["Rid"], out Rid);
                    Int64.TryParse(Request.QueryString["vid"], out pVisitID);
                    GetOrgReferralsInvestigations(Rid, pVisitID);

                }
                if (Request.QueryString["addMore"] == "Y")
                {
                    CommonControls_SampleBillPrint BillPrintCtrl = (CommonControls_SampleBillPrint)PreviousPage.FindControl("BillPrintCtrl");
                    InvestigationSearchControl1.HiddenFieldValue = BillPrintCtrl.hdnOrderedItemsList;

                }

                btnBillShow.PostBackUrl = "~/Reception/SampleBillPrint.aspx?vid=" + pVisitID + "&pid=" + pPatientID + "&cid=" + pClientID + "&ccid=" + pCollectionCentreID + "&PayId=" + pPayerID;
                btnBillShow.UseSubmitBehavior = true;
                InvestigationSearchControl1.lblPackageText = "Packages";
                Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                InvestigationSearchControl1.ClientID = pClientID;
                List<PatientInvestigation> lstGroups = new List<PatientInvestigation>();
                List<PatientInvestigation> lstPKG = new List<PatientInvestigation>();
                List<PatientInvestigation> lstInvestigations = new List<PatientInvestigation>();
                List<LabConsumables> lstLabConsumables = new List<LabConsumables>();
                List<PatientInvestigation> lstPhyRates = new List<PatientInvestigation>();
                investigationBL.GetInvestigationByClientID(OrgID, pClientID, "PHY", out lstPhyRates);
                investigationBL.GetLabConsumablesByOrg(OrgID, "LCON",pClientID, out lstLabConsumables);


                lblVisitNo.Text = pVisitID.ToString();
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                List<PatientVisit> visitList = new List<PatientVisit>();
                result = patientBL.GetLabVisitDetails(pVisitID, OrgID, out visitList);
                if (visitList.Count > 0)
                {
                    lblPatientName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;
                    lblPatientNo.Text = visitList[0].PatientNumber;
                    if (visitList[0].Sex == "M")
                    {
                        lblGender.Text = "[Male]";
                    }
                    else
                    {
                        lblGender.Text = "[Female]";
                    }
                    lblAge.Text = visitList[0].PatientAge.ToString();
                    if (visitList[0].PriorityName != "Normal")
                    {
                        trPriority.Style.Add("display", "block");
                        lblPriority.Text = "Priority : " + visitList[0].PriorityName;
                    }
                    pRefOrgID = visitList[0].HospitalID;
                    pRefPhyID = visitList[0].ReferingPhysicianID;
                }
                string RedirectMethod = GetConfigValue("HasPCCClientMapping", OrgID);

                if (RedirectMethod == "Y")
                {
                    investigationBL.GetInvestigationByPCClientID(OrgID, pRefOrgID, pRefPhyID, pClientID, "INV", out lstInvestigations);
                    investigationBL.GetInvestigationByPCClientID(OrgID, pRefOrgID, pRefPhyID, pClientID, "GRP", out lstGroups);
                    investigationBL.GetInvestigationByPCClientID(OrgID, pRefOrgID, pRefPhyID, pClientID, "PKG", out lstPKG);
                }
                else
                {
                    investigationBL.GetInvestigationByClientID(OrgID, pClientID, "GRP", out lstGroups);
                    investigationBL.GetInvestigationByClientID(OrgID, pClientID, "PKG", out lstPKG);
                    investigationBL.GetInvestigationByClientID(OrgID, pClientID, "INV", out lstInvestigations);
                }

                List<Config> ConfigValues = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails("InvestigationFilter", OrgID, out ConfigValues);
                string FilterBy = string.Empty;
                if (ConfigValues.Count > 0)
                {
                    FilterBy = ConfigValues[0].ConfigValue;
                }
                else
                {
                    FilterBy = "All";
                }

                InvestigationSearchControl1.LoadLabData(lstGroups, lstPKG, lstInvestigations, lstLabConsumables, lstPhyRates, FilterBy);
                LoadVisitDetails();

            }
            LnkTRF.Visible = false;
             int patientid = int.Parse(pPatientID.ToString());
              int visitid = int.Parse(pVisitID.ToString());
            loadimage(patientid,visitid);

        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error in InvestigationSearch.aspx:Page_Load", ex);
        }
    }
    public void LoadVisitDetails()
    {
        long returnCode = -1;
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();

        string pPatientName = "";
        string pPatientNo = "";
        returnCode = new PatientVisit_BL(base.ContextInfo).GetPatientVisit(Convert.ToInt32(Request.QueryString["pid"]),Convert.ToInt32(pVisitID), OrgID, 0, out lstPatientVisit, out lstOrderedInv, out pPatientName, out pPatientNo);
        //UpdateProgress UpProgess = (UpdateProgress)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("Progressbar");
        //UpProgess.Visible = true;
        //for (int i = 0; i < ++i; i++)
        //{
        //    int a = i++;
        //}
        
        if (lstPatientVisit.Count != 0)
        {
            VisitDetails.DataSource = lstPatientVisit;
            VisitDetails.DataBind();
        }
    }
    //protected void VisitDetails_RowDataBound(Object sender, GridViewRowEventArgs e)
    //{
    //    try
    //    {
    //        if (e.Row.RowType == DataControlRowType.DataRow)
    //        {
    //            PatientVisit pv = (PatientVisit)e.Row.DataItem;
    //            if (lstOrderedInv.Find(p => p.VisitID == pv.PatientVisitId) != null)
    //            {
    //                Label lblReportingRadiologist = (Label)e.Row.FindControl("lblReportingRadiologist");
    //                lblReportingRadiologist.Text = lstOrderedInv.Find(p => p.VisitID == pv.PatientVisitId).PerformingPhysicain;
    //            }
    //        }
    //    }
    //    catch (Exception Ex)
    //    {
    //        CLogger.LogError("Error while Patient Search Control", Ex);
    //    }

    //}
    protected void VisitDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            VisitDetails.PageIndex = e.NewPageIndex;
            LoadVisitDetails();
        }

    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }

    private void GetOrgReferralsInvestigations(long Rid, long patientVisitID)
    {
        List<BillingFeeDetails> lstInvestigationFeesDetails = new List<BillingFeeDetails>();
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        try
        {
            new Referrals_BL(base.ContextInfo).GetOrgReferralsInvestigations(Rid, OrgID, ILocationID, patientVisitID, out lstInvestigationFeesDetails);

            if (lstInvestigationFeesDetails.Count > 0)
            {
                InvestigationSearchControl1.HiddenFieldValue = GetOrderedItemsList(lstInvestigationFeesDetails);
                //
            }
            else
            {
                returncode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lstLocation);
                OrganizationAddress obj = lstLocation.Find(p => p.Comments == ILocationID.ToString() + "~" + OrgID.ToString());
                ltrMsg.Text = "None of the Referred Investigations are performed in this " + obj.Location;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Investigation Fee ", ex);
        }
    }
    private string GetOrderedItemsList(List<BillingFeeDetails> lstInvestigationFeesDetails)
    {
        string OrderedItems = "";
        string IsGroup = "";
        string Status = "";
        foreach (BillingFeeDetails item in lstInvestigationFeesDetails)
        {
            if (item.IsGroup == "G")
            {
                IsGroup = "GRP";
            }
            else
            {
                IsGroup = "INV";
            }
            if (item.ProcedureType == "paid")
            {
                OrderedItems += item.ID + "~" + item.Descrip + " -" +
                CurrencyName + ": " +
                String.Format("{0:0.00}", item.Amount) + "<img src='../Images/starbutton.png' align='middle' /> ~" +
                IsGroup + "~paid^";
            }
            else
            {
                OrderedItems += item.ID + "~" + item.Descrip + " -" +
                 CurrencyName + ": " +
                 String.Format("{0:0.00}", item.Amount) + "~" +
                 IsGroup + "~Ordered^";
            }



        }

        return OrderedItems;


    }

    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    protected void btnBillShow_Click(object sender, EventArgs e)
    {
        try
        {
            if (rdoSkipBill.Checked != true)
            {
                List<Config> lstConfig = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails("INV", OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    PaymentLogic = lstConfig[0].ConfigValue.Trim();
                if (PaymentLogic.ToLower() == "after")
                {
                    Int64.TryParse(Request.QueryString["vid"], out pVisitID);
                    Int64.TryParse(Request.QueryString["pid"], out pPatientID);
                    Int32.TryParse(Request.QueryString["cid"], out pClientID);
                    Int32.TryParse(Request.QueryString["ccid"], out pCollectionCentreID);
                    Int32.TryParse(Request.QueryString["PayID"], out pPayerID);

                    //long createTaskID = -1;
                    //List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                    //result = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(pVisitID, out lstPatientVisitDetails);
                    //result = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment),
                    //             pVisitID, 0, pPatientID, lstPatientVisitDetails[0].TitleName + " " +
                    //             lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                    //             , out dText, out urlVal, 0, 0, 0);
                    //task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectPayment);
                    //task.DispTextFiller = dText;
                    //task.URLFiller = urlVal;
                    //task.RoleID = RoleID;
                    //task.OrgID = OrgID;
                    //task.PatientVisitID = pVisitID;
                    //task.PatientID = pPatientID;
                    //task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    //task.CreatedBy = LID;
                    ////Create task               
                    //result = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);


                }
            }
            else
            {

                long returnCode = -1;
                List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
                string GUID = System.Guid.NewGuid().ToString();
                Int64.TryParse(Request.QueryString["vid"], out pVisitID);
                Int64.TryParse(Request.QueryString["pid"], out pPatientID);
                Role roleName = new Role();
                List<Role> lRole = new List<Role>();
                new Role_DAL(base.ContextInfo).GetRoleName(OrgID, out lRole);
                if (lRole.Count > 0)
                {
                    roleName = lRole.Find(O => O.RoleName == Attune.Podium.Common.RoleHelper.LabTech);
                }
                Tasks task = new Tasks();
                long createTaskID = -1;
                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(pVisitID, out lstPatientVisitDetails);
                if (returnCode == -1) { throw new Exception("GetVisitDetails"); }
                string sExternalVisitID = lstPatientVisitDetails[0].ExternalVisitID;
                returnCode = Attune.Podium.Common.Utilities.GetHashTable(Convert.ToInt64(Attune.Podium.Common.TaskHelper.TaskAction.CollectSample),
                             pVisitID, 0, pPatientID, lstPatientVisitDetails[0].TitleName + " " +
                             lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                             , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0, GUID, sExternalVisitID,lstPatientVisitDetails[0].VisitNumber,"");
                if (returnCode == -1) { throw new Exception("GetHashTable"); }

                task.TaskActionID = Convert.ToInt32(Attune.Podium.Common.TaskHelper.TaskAction.CollectSample);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = roleName.RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = pVisitID;
                task.PatientID = pPatientID;
                task.TaskStatusID = (int)Attune.Podium.Common.TaskHelper.TaskStatus.Pending;
                returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);

                if (returnCode == -1) { throw new Exception("CreateTask"); }

                ///////////////////////////////////////////////
                OrderedInvestigations objInvest = new OrderedInvestigations();
                String[] Invdetails = InvestigationSearchControl1.HiddenFieldValue.Split('^');
                for (int i = 0; i < Invdetails.Length - 1; i++)
                {

                    objInvest.ID = Convert.ToInt64(Invdetails[i].Split('~')[0]);
                    objInvest.Name = Invdetails[i].Split('~')[1].ToString();
                    objInvest.VisitID = Convert.ToInt64(pVisitID);
                    objInvest.Status = "Paid";
                    objInvest.PaymentStatus = "Paid";
                    objInvest.CreatedBy = LID;
                    objInvest.Type = Invdetails[i].Split('~')[2].ToString();
                    objInvest.OrgID = OrgID;
                    objInvest.UID = GUID;
                    objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                    ordInves.Add(objInvest);
                }
                if (ordInves.Count > 0)
                {
                    returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigation(ordInves, OrgID);
                }


                //////////////////////////////////////////////


                Response.Redirect(Request.ApplicationPath + "/Lab/Home.aspx", true);


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Generating Bill", ex);
        }
    }
    //public void VisitDetails_RowBound(object Obj, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        PatientVisit PV = (PatientVisit)e.Row.DataItem;
    //        var lst = from lstO in lstOrderedInv
    //                  where lstO.VisitID == PV.PatientVisitId
    //                  select lstO;

    //        string invName = string.Empty;
    //        foreach (var O in lst)
    //        {
    //            invName = O.Name + ",";
    //        }

    //    }
    //}
    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }
    private string GetUniqueKey()
    {
        int maxSize = 10;
        char[] chars = new char[62];
        string a;
        //a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        a = "0123456789012345678901234567890123456789012345678901234567890123456789";
        chars = a.ToCharArray();
        int size = maxSize;
        byte[] data = new byte[1];
        RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider();
        crypto.GetNonZeroBytes(data);
        size = maxSize;
        data = new byte[size];
        crypto.GetNonZeroBytes(data);
        StringBuilder result = new StringBuilder(size);
        foreach (byte b in data)
        { result.Append(chars[b % (chars.Length - 1)]); }
        return result.ToString();
    }
    protected void lnkAddnew_Click(object sender, EventArgs e)
    {
        try
        {
            //returncode = new Investigation_BL(base.ContextInfo).getdept
            List<InvDeptMaster> listOfdept = new List<InvDeptMaster>();
            returncode = new Investigation_BL(base.ContextInfo).GetInvforDept(OrgID, out listOfdept);
            ddlDept.DataSource = listOfdept;
            ddlDept.DataTextField = "DeptName";
            ddlDept.DataValueField = "DeptID";
            ddlDept.DataBind();

            List<InvestigationHeader> listHeader = new List<InvestigationHeader>();
            returncode = new Investigation_BL(base.ContextInfo).getOrgHeaderName(out listHeader);
            ddlHeader.DataSource = listHeader;
            ddlHeader.DataTextField = "HeaderName";
            ddlHeader.DataValueField = "HeaderID";
            ddlHeader.DataBind();
            ddlHeader.SelectedValue = "10";
            programmaticModalPopup.Show();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in lnkAddnew_Click", ex);
        }
    }
    protected void Save_Click(object sender, EventArgs e)
    {
        try
        {

            long returncode = -1;
            string InvName = txtInvname.Text;
            int DeptID = -1;
            int HeaderID = -1;
            DeptID = Convert.ToInt32(ddlDept.SelectedItem.Value);
            HeaderID = Convert.ToInt32(ddlHeader.SelectedItem.Value);
            returncode = new Investigation_BL(base.ContextInfo).InsertNewInvestigation(InvName, DeptID, HeaderID, 0, 0, OrgID);
            if (returncode != 0)
            {
                txtInvname.Text = string.Empty;
                lblStatus.Visible = true;
                lblStatus.Text = "Investigation saved Sucessfully...!";
            }
            else
            {
                lblStatus.Visible = true;
                lblStatus.Text = "Error while saving new Investigation...!";
            }
            programmaticModalPopup.Show();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in save new investigation", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        programmaticModalPopup.Hide();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Items", "javascript:LoadOrdItems();", true);
    }
    protected void VisitDetails_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientVisit pv = (PatientVisit)e.Row.DataItem;

                //List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                //List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
                //List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
                //List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
                //List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
                //List<InvDeptMaster> deptList = new List<InvDeptMaster>();
                //List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
                //List<SampleAttributes> lstSampleAttributes = new List<SampleAttributes>();
                //List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
                //List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
                List<OrderedInvestigations> lstorderInv = new List<OrderedInvestigations>();
                List<InvDeptMaster> deptList1 = new List<InvDeptMaster>();

                new Investigation_BL(base.ContextInfo).GetInvestigationForVisit(pv.PatientVisitId,ILocationID, OrgID, out lstOrderedInv);

                if (lstorderInv.Count > 0)
                {
                    string strtemp = GetToolTip(lstorderInv);
                    e.Row.Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                    e.Row.Attributes.Add("onmouseout", "hideTooltip();");
                    //e.Row.Cells[2].Style.Add("color", "Blue");
                    e.Row.Style.Add("Cursor", "Pointer");
                }

            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error in  VisitDetails_RowDataBound in investigation Search", Ex);
        }
    }
    private string GetToolTip(List<OrderedInvestigations> InvestigationList)
    {
        string TableHead = "";
        string TableDate = "";
        TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\">"
            //+ "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List For this task</td></tr>"
                    + "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List</td><td>Reporting Radiologist</td><td>Status</td></tr>";
        foreach (var Item in InvestigationList)
        {
            TableDate += "<tr>  <td>" + Item.InvestigationName + "</td>";
            TableDate += " <td>" + Item.PerformingPhysicain + "</td>";
            TableDate += " <td>" + Item.Status + "</td></tr>";
        }
        return TableHead + TableDate + "</table> ";
    }

    public void loadimage(int patientid, int visitid)
    {
        string pathname = GetConfigValue("TRF_UploadPath", OrgID);
        long returncode = -1;
        List<TRFfilemanager> lstTRF = new List<TRFfilemanager>();

        try
        {

            string Type = "";
            returncode = new Patient_BL(base.ContextInfo).GetTRFimageDetails(patientid, visitid, OrgID, Type, out lstTRF);

            if (lstTRF.Count > 0)
            {
                LnkTRF.Visible = true;


                if (lstTRF.Count > 1)
                {
                    DrpTRF.Visible = true;
                    DrpTRF.DataSource = lstTRF;
                    DrpTRF.DataTextField = "FileName";
                    DrpTRF.DataBind();
                    DrpTRF.Items.Insert(0, "-----Select-----");
                    DrpTRF.Items[0].Value = "0";
                }

                if (lstTRF.Count == 1)
                {

                    DrpTRF.Visible = false;
                    PictureName = Request.QueryString["PictureName"];

                    if (PictureName != "")
                    {

                        bool isPhotoNotExist = true;

                        if (!String.IsNullOrEmpty(PictureName))
                        {
                           // string imagePathname = ConfigurationManager.AppSettings["UploadPath"];
                            //string imagePath = imagePathname + pathname;
                            string imagePath = pathname;
                            if (File.Exists(imagePath + PictureName))
                            {
                                imgPatient.Src = "TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID;

                                isPhotoNotExist = false;
                            }
                        }
                        if (isPhotoNotExist)

                            imgPatient.Visible = false;

                    }

                    else
                    {

                        LnkTRF.Visible = false;

                    }
                }
            }
            else
            {
                LnkTRF.Visible = false;
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadingImage", ex);
        }



    }
}
