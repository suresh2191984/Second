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
using System.Security.Cryptography;
using System.Text;
using System.Linq;
public partial class SampleBillPrint : BasePage
{
    public SampleBillPrint()
        : base("Reception\\SampleBillPrint.aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    int currentPageNo = 1;
    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    long pVisitID = 0;
    long pPatientID = 0;
    int pClientID = 0;
    long pTPAID = 0;
    int pRateID = 0;
    int pCollectionCentreID = 0;
    int pHospitalID = 0;
    long result = -1;
    int type = 0;
    long ptaskID = -1;
    string billMasterType = string.Empty;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
    long returncode = -1;
    CommonControls_InvestigationSearchControl InvestigationControl1;
    Patient_BL patBL; string GUID = Guid.NewGuid().ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        patBL = new Patient_BL(base.ContextInfo);
        try
        {
            Int64.TryParse(Request.QueryString["pid"], out pPatientID);
            if (Request.QueryString["vid"] == null)
            {
                List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
                List<OrderedInvestigations> lstOrdered = new List<OrderedInvestigations>();
                Int64.TryParse(Request.QueryString["ptid"], out ptaskID);
                new PatientVisit_BL(base.ContextInfo).GetPatientLatestVisit(pPatientID, out lstPatientVisit, out lstOrdered);
                if (lstPatientVisit.Count > 0)
                {
                    pVisitID = lstPatientVisit[0].PatientVisitId;
                    pClientID = Convert.ToInt32(lstPatientVisit[0].ClientMappingDetailsID);
                    pTPAID = lstPatientVisit[0].TPAID;
                    pCollectionCentreID = lstPatientVisit[0].CollectionCentreID;
                    //Int64.TryParse(l, out );.
                    string strval = "";
                    foreach (OrderedInvestigations Ois in lstOrdered)
                    {
                        strval += Ois.Name;
                    }
                    BillPrintCtrl.hdnOrderedItemsList = strval;
                }
            }
            else
            {
                Int64.TryParse(Request.QueryString["vid"], out pVisitID);
                Int32.TryParse(Request.QueryString["cid"], out pRateID);
                Int32.TryParse(Request.QueryString["ccid"], out pCollectionCentreID);
            }
            BillPrintCtrl.AddNewItem += new EventHandler(BillPrintCtrl_AddNewItem);
            BillPrintCtrl.SetCheckHospitalCredit = "0";

            if (BillPrintCtrl.hdnOrderedItemsList == "")
            {
                if ((Request.QueryString["INS"] == null) && (Request.QueryString["vid"] != null))
                {
                    InvestigationControl1 = (CommonControls_InvestigationSearchControl)PreviousPage.FindControl("InvestigationSearchControl1");
                    BillPrintCtrl.hdnOrderedItemsList = InvestigationControl1.HiddenFieldValue;

                    #region Paid Investigation
                    List<OrderedInvestigations> orderedInves = new List<OrderedInvestigations>();
                    List<OrderedInvestigations> TempInves = new List<OrderedInvestigations>();
                    TempInves = GetPaidOrderedList(BillPrintCtrl.hdnOrderedItemsList);


                    BillPrintCtrl.hdnOrderedItemsList = GetOrderedItemsList(TempInves);


                    foreach (OrderedInvestigations invs in TempInves)
                    {
                        OrderedInvestigations objInvest = new OrderedInvestigations();
                        objInvest.ID = invs.ID;
                        objInvest.Name = invs.Name;
                        objInvest.VisitID = pVisitID;
                        objInvest.Status = invs.Status;
                        objInvest.PaymentStatus = invs.PaymentStatus;
                        objInvest.CreatedBy = LID;
                        objInvest.Type = invs.Type;
                        objInvest.OrgID = OrgID;
                        objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                        orderedInves.Add(objInvest);
                    }
                    TempInves = orderedInves.FindAll(P => P.PaymentStatus == "paid");

                    //TempInves.RemoveAll(P => P.PaymentStatus != "paid");
                    if (TempInves.Count > 0)
                    {
                        returncode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigation(TempInves, OrgID);
                        orderedInves.RemoveAll(P => P.PaymentStatus == "paid");
                        if (orderedInves.Count == 0)
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
                    }

                    #endregion

                }
            }


            if (Request.QueryString["INS"] != null)
            {
                long retCode = 0;
                billMasterType = "INS";
                //BillPrintCtrl.LoadBillItems(lineItems[1].Split('-')[0], cid, rate, type);
                Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                List<PatientInvestigation> lstInvestigation = new List<PatientInvestigation>();
                List<PatientInvestigation> lstPkg = new List<PatientInvestigation>();

                retCode = investigationBL.GetInvestigationByClientID(OrgID, pRateID, "INS", out lstInvestigation);
                lstPkg = lstInvestigation.FindAll(delegate(PatientInvestigation h) { return (h.Type == "INS" && h.GroupID == pClientID); });
                if (lstPkg.Count > 0)
                    BillPrintCtrl.hdnOrderedItemsList = lstPkg[0].GroupID + "~" + lstPkg[0].GroupName + " -" + CurrencyName + ": " + lstPkg[0].Rate + "~INS^";
                //BillPrintCtrl.LoadBillItems(lstPkg[0].GroupName, pClientID, lstPkg[0].Rate, "INS");

            }

            BillPrintCtrl.addNewItemLblCaption = "Add Consumables";
            BillPrintCtrl.enableAddConTab = false;
            LoadOrderedItems();

            lblVisitNo.Text = pVisitID.ToString();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            List<PatientVisit> visitList = new List<PatientVisit>();
            result = patientBL.GetLabVisitDetails(pVisitID, OrgID, out visitList);
            lblPatientNo.Text = visitList[0].PatientNumber.ToString();
            lblPatientName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;
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
            if (visitList[0].HospitalID == 0)
            {
                if (!IsPostBack)
                {
                    LoadHospital();
                    BillPrintCtrl.SetCheckHospitalCredit = "1";
                }
            }
            else
            {
                BillPrintCtrl.SetCheckHospitalCredit = "0";
            }
            if ((!IsPostBack) && (Request.QueryString["vid"] != null))
            {
                RadioButton rdoLater = (RadioButton)PreviousPage.FindControl("rdoPayLater");
                if (rdoLater.Checked == true)
                {
                    CreateInvestigationEntry();
                    Response.Redirect("home.aspx");
                }
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error in SampleBillPrint.aspx.cs:Page_Load", ex);
        }
        lnkAddMore.PostBackUrl = "InvestigationSearch.aspx?vid=" + pVisitID + "&pid=" + pPatientID + "&cid=" + pClientID + "&addMore=Y&ccid=" + pCollectionCentreID;
    }

    private string GetOrderedItemsList(List<OrderedInvestigations> lstInvestigationFeesDetails)
    {
        string OrderedItems = "";
        foreach (OrderedInvestigations item in lstInvestigationFeesDetails)
        {
            if (item.Status != "paid")
            {
                OrderedItems += item.ID + "~" + item.Name + " -" +
                 CurrencyName + ": " +
                 String.Format("{0:0.00}", item.InvestigationsType) + "~" +
                 item.Type + "~Ordered^";
            }
        }
        return OrderedItems;


    }


    private List<OrderedInvestigations> GetPaidOrderedList(string InvValues)
    {
        List<OrderedInvestigations> lstpatInves = new List<OrderedInvestigations>();
        OrderedInvestigations PatientInves;
        long id = 0;
        string hidValue = InvValues;
        string strRate = string.Empty;
        string strInvName = string.Empty;
        decimal rate = 0;
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');

                if (lineItems.Length > 2)
                {
                    PatientInves = new OrderedInvestigations();

                    if (lineItems[1].Contains("-" + CurrencyName + ":"))
                    {

                        id = Convert.ToInt64(lineItems[0]);
                        int rIndex = lineItems[1].IndexOf("-" + CurrencyName + ":");
                        strInvName = lineItems[1].Substring(0, rIndex);
                        strRate = lineItems[1].Substring(rIndex + 4);
                        decimal.TryParse(strRate, out rate);
                        string type = lineItems[2];
                        PatientInves.Type = type;
                        PatientInves.ID = id;
                        PatientInves.Name = strInvName;
                        PatientInves.Status = lineItems[3];
                        PatientInves.PaymentStatus = lineItems[3];
                        PatientInves.InvestigationsType = rate.ToString();

                    }
                    else
                    {
                        id = Convert.ToInt64(lineItems[0]);
                        strInvName = lineItems[1];
                        string type = lineItems[2];
                        PatientInves.Type = type;
                        PatientInves.ID = id;
                        PatientInves.Name = strInvName;
                        PatientInves.Status = lineItems[3];
                        PatientInves.PaymentStatus = lineItems[3];

                    }
                    lstpatInves.Add(PatientInves);

                }

            }


        }

        return lstpatInves;
    }



    public void LoadHospital()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<LabReferenceOrg> RefOrg = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Hospital = new List<LabReferenceOrg>();
            retCode = patBL.GetLabRefOrg(OrgID, 0, "D", out RefOrg);
            Hospital = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 1; });
            if (retCode == 0)
            {
                ddlHospital.DataSource = Hospital;
                ddlHospital.DataTextField = "RefOrgName";
                ddlHospital.DataValueField = "LabRefOrgID";
                ddlHospital.DataBind();
                ddlHospital.Items.Insert(0, "-----Select-----");
                ddlHospital.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Hospital Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }


    void BillPrintCtrl_AddNewItem(object sender, EventArgs e)
    {

    }



    protected void lnkAddMore_Click(object sender, EventArgs e)
    {
        //Response.Redirect("InvestigationSearch.aspx?vid=" + pVisitID + "&pid=" + pPatientID + "&cid=" + pClientID+"&addMore=Y", true);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
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
    public List<OrderedInvestigations> GetOrderedList()
    {
        List<OrderedInvestigations> lstpatInves = new List<OrderedInvestigations>();
        OrderedInvestigations PatientInves;
        long id = 0;
        string hidValue = BillPrintCtrl.hdnOrderedItemsList;
        string strRate = string.Empty;
        string strInvName = string.Empty;
        decimal rate = 0;
        //"231~Platelet Rich Concentrate -Rs: 220.00~BLB^1008~Toxoplasma Virus - IgG -Rs: 0.00~INV^"
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');

                if (lineItems.Length > 2)
                {
                    PatientInves = new OrderedInvestigations();

                    if (lineItems[1].Contains("-" + CurrencyName + ":"))
                    {

                        id = Convert.ToInt64(lineItems[0]);
                        int rIndex = lineItems[1].IndexOf("-" + CurrencyName + ":");
                        strInvName = lineItems[1].Substring(0, rIndex);
                        strRate = lineItems[1].Substring(rIndex + 4);
                        decimal.TryParse(strRate, out rate);
                        string type = lineItems[2];
                        PatientInves.Type = type;
                        //if (type.ToUpper() == "INV")
                        // {
                        PatientInves.ID = id;
                        PatientInves.Name = strInvName;
                        // }
                    }
                    else
                    {

                        id = Convert.ToInt64(lineItems[0]);
                        strInvName = lineItems[1];
                        string type = lineItems[2];
                        PatientInves.Type = type;
                        //if (type.ToUpper() == "INV")
                        // {
                        PatientInves.ID = id;
                        PatientInves.Name = strInvName;
                        // }

                    }

                    lstpatInves.Add(PatientInves);

                }

            }


        }

        return lstpatInves;

    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {

        try
        {
            long returnCode = -1;
            string BillNo = string.Empty;
            string LabNo = string.Empty;
            List<OrderedInvestigations> orderedInves = GetOrderedList();
            List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
            List<OrderedInvestigations> ordInv = new List<OrderedInvestigations>();
            PatientVisit PatientVisit = new PatientVisit();
            CheckBox chkBox = (CheckBox)BillPrintCtrl.FindControl("chkUseCredit");
            if (Request.QueryString["vid"] != null)
            {
                foreach (OrderedInvestigations inv in orderedInves)
                {
                    OrderedInvestigations objInves = new OrderedInvestigations();
                    objInves.Type = inv.Type;
                    ordInv.Add(objInves);
                }
                returnCode = new Investigation_BL(base.ContextInfo).GetLabNo(OrgID, ordInv, out LabNo);
            }
            BillMaster billMaster = new BillMaster();
            billMaster = BillPrintCtrl.Getillmaster();
            billMaster.Type = billMasterType;
            billMaster.VisitID = pVisitID;
            billMaster.BillID = Convert.ToInt32(LabNo);
            billMaster.CollectionCentreID = pCollectionCentreID;
            if (chkBox.Checked)
            {
                if (Convert.ToInt32(hdnUpdateHospitalID.Value) > 0)
                {
                    PatientVisit.HospitalID = Convert.ToInt32(ddlHospital.SelectedValue);
                    PatientVisit.HospitalName = ddlHospital.SelectedItem.Text;
                    PatientVisit.OrgID = OrgID;
                    PatientVisit.PatientVisitId = pVisitID;
                    PatientVisit.PatientID = pPatientID;
                    PatientVisit.ModifiedBy = LID;
                    patBL.UpdateLabVisitDetails(PatientVisit);
                }
            }

            if (Request.QueryString["vid"] != null)
            {
                foreach (OrderedInvestigations invs in orderedInves)
                {
                    OrderedInvestigations objInvest = new OrderedInvestigations();
                    objInvest.ID = invs.ID;
                    objInvest.Name = invs.Name;
                    objInvest.VisitID = pVisitID;
                    objInvest.Status = "Paid";
                    objInvest.PaymentStatus = "Paid";
                    objInvest.CreatedBy = LID;
                    objInvest.Type = invs.Type;
                    objInvest.OrgID = OrgID;
                    objInvest.UID = GUID;
                    objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                    objInvest.LabNo = LabNo;
                    ordInves.Add(objInvest);
                }
                returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigation(ordInves, OrgID);
            }
            else
            {
                returnCode = 0;
            }


            if (returnCode == 0)
            {

                returnCode = BillPrintCtrl.GetBillItems(billMaster, pVisitID, pPatientID, out BillNo);
                CreateTask(BillNo, LabNo);
                if (returnCode != 0)
                {
                    ErrorDisplay1.ShowError = true;
                    ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
                }
                Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                List<Tasks> lstTasks = new List<Tasks>();
                if (RoleName != RoleHelper.LabTech)
                {
                    taskBL.GetTasks(RoleID, OrgID, UID, out lstTasks, RoleHelper.Inventory == RoleName ? InventoryLocationID : 0, currentPageNo, PageSize, out totalRows);
                    foreach (Tasks objTasks in lstTasks)
                    {
                        ptaskID = objTasks.TaskID;
                    }
                    returnCode = taskBL.UpdateTask(ptaskID, TaskHelper.TaskStatus.Completed, UID);
                }
                ViewState["TotalLineItems"] = "";
                Response.Redirect("ViewBill.aspx?billNo=" + BillNo + "&ccid=" + pCollectionCentreID, true);
            }
            else
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Billing Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";

        }
    }

    public void LoadOrderedItems()
    {
        string hidValue = BillPrintCtrl.hdnOrderedItemsList;
        string strRate = string.Empty;
        string strInvName = string.Empty;
        decimal rate = 0;
        string Status = "";
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');

                if (lineItems.Length > 2)
                {
                    long id = Convert.ToInt64(lineItems[0]);
                    int rIndex = lineItems[1].IndexOf("-" + CurrencyName + ":");
                    strInvName = lineItems[1].Substring(0, rIndex);
                    strRate = lineItems[1].Substring(rIndex + 4);
                    decimal.TryParse(strRate, out rate);
                    string type = lineItems[2];
                    Status = lineItems[3];
                    BillPrintCtrl.LoadBillItems(strInvName, id, rate, type);
                }

            }

        }
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

    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }

    protected void CreateInvestigationEntry()
    {
        try
        {
            long returnCode = -1;
            string BillNo = "";
            string LabNo = "";
            List<OrderedInvestigations> orderedInves = GetOrderedList();
            List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
            List<OrderedInvestigations> ordInv = new List<OrderedInvestigations>();
            PatientVisit PatientVisit = new PatientVisit();
            CheckBox chkBox = (CheckBox)BillPrintCtrl.FindControl("chkUseCredit");
            if (Request.QueryString["vid"] != null)
            {
                foreach (OrderedInvestigations inv in orderedInves)
                {
                    OrderedInvestigations objInves = new OrderedInvestigations();
                    objInves.Type = inv.Type;
                    ordInv.Add(objInves);
                }
                returnCode = new Investigation_BL(base.ContextInfo).GetLabNo(OrgID, ordInv, out LabNo);
            }
            BillMaster billMaster = new BillMaster();
            billMaster = BillPrintCtrl.Getillmaster();
            billMaster.Type = billMasterType;
            billMaster.VisitID = pVisitID;
            billMaster.BillID = Convert.ToInt32(LabNo);
            billMaster.CollectionCentreID = pCollectionCentreID;
            if (chkBox.Checked)
            {
                if (Convert.ToInt32(hdnUpdateHospitalID.Value) > 0)
                {
                    PatientVisit.HospitalID = Convert.ToInt32(ddlHospital.SelectedValue);
                    PatientVisit.HospitalName = ddlHospital.SelectedItem.Text;
                    PatientVisit.OrgID = OrgID;
                    PatientVisit.PatientVisitId = pVisitID;
                    PatientVisit.PatientID = pPatientID;
                    PatientVisit.ModifiedBy = LID;
                    patBL.UpdateLabVisitDetails(PatientVisit);
                }
            }
            foreach (OrderedInvestigations invs in orderedInves)
            {
                OrderedInvestigations objInvest = new OrderedInvestigations();
                objInvest.ID = invs.ID;
                objInvest.Name = invs.Name;
                objInvest.VisitID = pVisitID;
                objInvest.Status = "Pending";
                objInvest.PaymentStatus = "Pending";
                objInvest.CreatedBy = LID;
                objInvest.Type = invs.Type;
                objInvest.OrgID = OrgID;
                objInvest.UID = GUID;
                objInvest.LabNo = LabNo;
                objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                ordInves.Add(objInvest);
            }
            returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigation(ordInves, OrgID);
            //if (returnCode == 0)
            //{
            //PayLaterCreateTask(LabNo);
            //    returnCode = BillPrintCtrl.GetBillItems(billMaster, pVisitID, pPatientID, out BillNo);

            //    if (returnCode != 0)
            //    {
            //        ErrorDisplay1.ShowError = true;
            //        ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            //    }

            //    ViewState["TotalLineItems"] = "";
            //    Response.Redirect("ViewBill.aspx?billNo=" + BillNo + "&ccid=" + pCollectionCentreID, true);
            //}
            //else
            //{
            //    ErrorDisplay1.ShowError = true;
            //    ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            //}



        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Billing Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";

        }
    }
    public long CreateTask(string BillNo, string LabNo)
    {
        long PatientID = -1;
        long returnCode = -1;
        List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
        List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
        List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
        new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(pVisitID, OrgID, RoleID, GUID, out lstSampleDept1, out lstSampleDept2);

        //var lst = from lstSample in lstSampleDept1
        //          group lstSample by lstSample.Display


        if (lstSampleDept2.Count > 0)
        {
            Int64.TryParse(Request.QueryString["pid"], out PatientID);
            long createTaskID = -1;
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(pVisitID, out lstPatientVisitDetails);
            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                         pVisitID, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                         lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                         , out dText, out urlVal, 0.ToString(), lstPatientVisitDetails[0].PatientNumber.ToString(), 0, GUID, lstPatientVisitDetails[0].ExternalVisitID.ToString(), lstPatientVisitDetails[0].VisitNumber.ToString(),"");
            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            task.RoleID = RoleID;
            task.OrgID = OrgID;
            task.PatientVisitID = pVisitID;
            task.PatientID = PatientID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            task.RefernceID = LabNo.ToString();
            //Create task               
            returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);

        }
        foreach (var item in lstSampleDept1)
        {
            //if (item.Display == "Y")
            //{
            Int64.TryParse(Request.QueryString["pid"], out PatientID);
            long createTaskID = -1;
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(pVisitID, out lstPatientVisitDetails);
            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                         pVisitID, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                         lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                         , out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, 0, GUID);
            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            task.RoleID = RoleID;
            task.OrgID = OrgID;
            task.PatientVisitID = pVisitID;
            task.PatientID = PatientID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            task.RefernceID = LabNo.ToString();
            //Create task               
            returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
            //}
            //else if (item.Display == "N")
            //{
            //    InvestigationValues inValues = new InvestigationValues();
            //    inValues.InvestigationID = item.InvestigationID;
            //    lstInvResult.Add(inValues);
            //}


        }

        returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(pVisitID, "SampleReceived", OrgID, lstInvResult);
        return returnCode;
    }
    public long PayLaterCreateTask(string LabNo)
    {
        long PatientID = -1;
        long returnCode = -1;
        List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
        List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
        List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
        new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(pVisitID, OrgID, RoleID, GUID, out lstSampleDept1, out lstSampleDept2);

        //var lst = from lstSample in lstSampleDept1
        //          group lstSample by lstSample.Display


        if (lstSampleDept2.Count > 0)
        {
            Int64.TryParse(Request.QueryString["pid"], out PatientID);
            long createTaskID = -1;
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(pVisitID, out lstPatientVisitDetails);
            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                         pVisitID, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                         lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                         , out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, 0, GUID);
            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            task.RoleID = RoleID;
            task.OrgID = OrgID;
            task.PatientVisitID = pVisitID;
            task.PatientID = PatientID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            task.RefernceID = LabNo.ToString();
            //Create task               
            returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);

        }
        foreach (var item in lstSampleDept1)
        {
            //if (item.Display == "Y")
            //{
            Int64.TryParse(Request.QueryString["pid"], out PatientID);
            long createTaskID = -1;
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(pVisitID, out lstPatientVisitDetails);
            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                         pVisitID, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                         lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                         , out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, 0, GUID);
            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            task.RoleID = RoleID;
            task.OrgID = OrgID;
            task.PatientVisitID = pVisitID;
            task.PatientID = PatientID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            task.RefernceID = LabNo.ToString();
            //Create task               
            returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
            //}
            //else if (item.Display == "N")
            //{
            //    InvestigationValues inValues = new InvestigationValues();
            //    inValues.InvestigationID = item.InvestigationID;
            //    lstInvResult.Add(inValues);
            //}


        }

        returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(pVisitID, "SampleReceived", OrgID, lstInvResult);
        return returnCode;
    }
    public void LoadBillDetails(string BillNo)
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<BillMaster> billMaster = new List<BillMaster>();
            List<BillLineItems> billLineItems = new List<BillLineItems>();
            List<PatientVisit> pVisitDetails = new List<PatientVisit>();
            string pAge = string.Empty;
            string pSex = string.Empty;
            retCode = patBL.GetBillDetails(BillNo, OrgID, out billMaster, out billLineItems, out pVisitDetails);


        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error While Loading Billing Details.", ex);
        }
    }
}
