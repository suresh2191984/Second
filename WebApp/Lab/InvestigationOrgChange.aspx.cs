using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Configuration;
using System.IO;
using Attune.Podium.PerformingNextAction;
public partial class Lab_InvestigationOrgChange : BasePage
{
    public Lab_InvestigationOrgChange()
        : base("Lab_InvestigationOrgChange_aspx")
    {
    }

    



    long vid = -1;
    long returnCode = -1;
    List<OrganizationAddress> lAddress = new List<OrganizationAddress>();
    List<OrderedInvestigations> lstOrderinvestication = new List<OrderedInvestigations>();
    List<PatientVisit> lstpatientVisit = new List<PatientVisit>();
    List<MetaValue_Common> lstMetavalue = new List<MetaValue_Common>();
    Patient_BL patientBL;
    string patientnumber = string.Empty;
    string IsNeedExternalVisitIdWaterMark = string.Empty;

    #region "Common Resource Property"

    string strAlert = Resources.Lab_AppMsg.Lab_Header_Alert == null ? "Alert" : Resources.Lab_AppMsg.Lab_Header_Alert;

    #endregion

    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new Patient_BL(base.ContextInfo);
        tdflag.Visible = false;
        if (!IsPostBack)
        {
            AutoAuthorizer.ContextKey = OrgID.ToString();
            Autosearch.ContextKey = OrgID.ToString();
            //txtFromDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
            //TxtToDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();




        }
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    #endregion
    #region "Events"
    protected void btnGo_Click(object sender, EventArgs e)
    {

        hdn.Value = "";

        hdn.Value = txtPatientSearch.Text;

        string Patientname = txtPname.Text;
        string Patientname11 = string.Empty;

        if (Patientname.Contains(':'))
        {
            Patientname11 = Patientname.Split(':')[0];
            patientnumber = Patientname.Split(':')[1];
        }
        else
        {
            Patientname11 = Patientname;
        }
        string fromdate = txtFromDate.Text;

        string todate = TxtToDate.Text;
        string patientvisitno = txtvisitno.Text;


        loadList(txtPatientSearch.Text, fromdate, todate, Patientname11, patientnumber, patientvisitno);
        // loadList(txtPatientSearch.Text);
    }
    public void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string strJuniorDoctor = Resources.Lab_ClientDisplay.Lab_InvestigationOrgChange_aspx_02 == null ? "Junior Doctor" : Resources.Lab_ClientDisplay.Lab_InvestigationOrgChange_aspx_02;
        string strDoctor = Resources.Lab_ClientDisplay.Lab_InvestigationOrgChange_aspx_03 == null ? "Doctor" : Resources.Lab_ClientDisplay.Lab_InvestigationOrgChange_aspx_03;
        string strApprove = Resources.Lab_ClientDisplay.Lab_InvestigationOrgChange_aspx_04 == null ? "Approve" : Resources.Lab_ClientDisplay.Lab_InvestigationOrgChange_aspx_04;
        string strAdminisat = Resources.Lab_ClientDisplay.Lab_InvestigationOrgChange_aspx_05 == null ? "Administrator" : Resources.Lab_ClientDisplay.Lab_InvestigationOrgChange_aspx_05;
        string strCancel = Resources.Lab_ClientDisplay.Lab_InvestigationOrgChange_aspx_06 == null ? "Cancel" : Resources.Lab_ClientDisplay.Lab_InvestigationOrgChange_aspx_06;
        string Cancel = GetConfigValues("Cancel", OrgID);

        string ExternalVisitID = string.Empty;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //function to check header checkbox based on child checkboxes condition START
            CheckBox headerchk = (CheckBox)grdResult.HeaderRow.FindControl("chkheader");
            CheckBox childchk = (CheckBox)e.Row.FindControl("chkSelect");
            childchk.Attributes.Add("onclick", "javascript:Selectchildcheckboxes('" + headerchk.ClientID + "')");
            //function to check header checkbox based on child checkboxes condition END


            DropDownList ddlLocation = (DropDownList)e.Row.FindControl("ddlLocation");
            CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");
            DropDownList ddlstatus = (DropDownList)e.Row.FindControl("ddlstatus");
            DropDownList ddlReason = (DropDownList)e.Row.FindControl("ddlReason");
            OrderedInvestigations OI = (OrderedInvestigations)e.Row.DataItem;
            //returnCode = patientBL.GetInvestigationOrgChange(ExternalVisitID, OrgID, out lstpatientVisit, out lstOrderinvestication);
            //ddlstatus.DataSource = lstOrderinvestication;
            ////ddlstatus.DataTextField = "Status";
            //ddlstatus.DataValueField = "Status";
            //ddlstatus.DataBind();
             string Cancel_check = string.Empty;
            Cancel_check=GetConfigValue("Status_Cancel_Check", OrgID);     
            if (RoleName != strJuniorDoctor.Trim() && RoleName != strDoctor.Trim())
            {
                if (OI.Status == strApprove.Trim())
                {
                    //e.Row.Enabled = true;
                    String Status_check = GetConfigValue("INV_Status_Check", OrgID);

                    if (Status_check == "Y")
                    {
                        chkSelect.Enabled = true;
                        ddlLocation.Enabled = true;
                        ddlstatus.Enabled = true;
                        ddlReason.Enabled = true;
                        tdflag.Visible = true;
                    }
                    else
                    {
                        chkSelect.Enabled = false;
                        ddlLocation.Enabled = false;
                        ddlstatus.Enabled = false;
                        ddlReason.Enabled = false;
                        tdflag.Visible = false;
                    }
                }

            }
               if(Cancel_check !="Y")
            {       
            if (RoleName == strJuniorDoctor.Trim() || RoleName == strDoctor.Trim() || RoleName == strAdminisat.Trim())
            {
                if (OI.Status == strCancel.Trim())
                {
                    //e.Row.Enabled = true;
                    chkSelect.Enabled = false;
                    ddlLocation.Enabled = false;
                    ddlstatus.Enabled = false;
                    ddlReason.Enabled = false;
                    tdflag.Visible = true;
                    }
                    if (Cancel == "Y")
                    {
                        chkSelect.Enabled = true;
                        ddlLocation.Enabled = true;
                        ddlstatus.Enabled = true;
                        ddlReason.Enabled = true;
                        tdflag.Visible = false;
                }

            }
        }
               //changes by arun - disabled the check box if ReferralID is > 0 in orderedinv table
            string DisableCheckBox = string.Empty;
            DisableCheckBox = GetConfigValue("DisabledSelect", OrgID);

            //if (OI.OutSourceFlag && DisableCheckBox == "Y")
            //   {
            //chkSelect.Enabled = (OI.OutSourceFlag && DisableCheckBox == "Y" ? false : chkSelect.Enabled;
             //  }
            //
            returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lAddress);
            ddlLocation.DataSource = lAddress.FindAll(A => A.OrgID == OrgID);
            // ddlLocation.DataSource = lAddress;
            ddlLocation.DataTextField = "City";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();
            ddlLocation.SelectedValue = OI.ResCaptureLoc.ToString();
            ////////////////////////ddlstatus.SelectedValue = OI.Status.ToString();
            ddlLocation.Attributes.Add("onchange", "javascript:DropCheck('" + ddlLocation.ClientID + "','" + chkSelect.ClientID + "');");
            ddlstatus.Attributes.Add("onchange", "javascript:DropCheck('" + ddlstatus.ClientID + "','" + chkSelect.ClientID + "');");

            returnCode = new Master_BL(base.ContextInfo).GetmetaValue(OrgID, "INVSTAUS", out lstMetavalue);
            ddlReason.DataSource = lstMetavalue;
            ddlReason.DataTextField = "Value";
            ddlReason.DataValueField = "Code";
            ddlReason.DataBind();
            ddlReason.SelectedValue = OI.PerformingPhysicain;
            ddlReason.Attributes.Add("onchange", "javascript:DropCheck('" + ddlReason.ClientID + "','" + chkSelect.ClientID + "');");
            long returncode = -1;
            string domains = "statusorg";
            string[] Tempdata = domains.Split(',');
            //string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "statusorg"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlstatus.DataSource = childItems;
                    ddlstatus.DataTextField = "DisplayText";
                    ddlstatus.DataValueField = "Code";
                    ddlstatus.DataBind();
                    Session["OrgId"] = OrgID.ToString();
                    hdnOrgId.Value = Session["OrgId"].ToString();
                    string Revalidate = GetConfigValues("Revalidate", OrgID);
                    if (Revalidate == "Y")
                    {
                        ddlstatus.Items.Add("Revalidate");
                    }
                    if (Cancel == "Y")
                    {
                        ddlstatus.Items.Add("Cancel");
                        ddlstatus.Items.Add("UnCancel");
                        ddlstatus.Items.Add("Delete");
                    }

                }

            }
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
        }
        //string ExternalVisitID = string.Empty;
        loadList(txtPatientSearch.Text, txtFromDate.Text, TxtToDate.Text, txtPname.Text, patientnumber, txtvisitno.Text);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string strSuccess = Resources.Lab_AppMsg.Lab_InvestigationOrgChange_aspx_02 == null ? "Changes saved successfully." : Resources.Lab_AppMsg.Lab_InvestigationOrgChange_aspx_02;
        string strRecordSave = Resources.Lab_AppMsg.Lab_InvestigationOrgChange_aspx_03 == null ? "Please select a record and then Save." : Resources.Lab_AppMsg.Lab_InvestigationOrgChange_aspx_03;

        long returnCode = -1;
        //ErrorDisplay1.ShowError = false;
        Investigation_BL OrdInv = new Investigation_BL(base.ContextInfo);

        List<OrderedInvestigations> lstOrderinvestication = new List<OrderedInvestigations>();
        OrderedInvestigations lstitem;
        foreach (GridViewRow row in grdResult.Rows)
        {
            lstitem = new OrderedInvestigations();
            CheckBox chkBox = (CheckBox)row.FindControl("chkSelect");
            DropDownList ddl1 = (DropDownList)row.FindControl("ddlLocation");
            Label lbl = (Label)row.FindControl("lblInvestigation");
            Label lblname = (Label)row.FindControl("lblName");
            HiddenField hdninv = (HiddenField)row.FindControl("hdnInvestigation");
            Label lblVisitID = (Label)row.FindControl("lblVisitID");
            Label lblAccessionNumber = (Label)row.FindControl("lblAccessionNumber");
            Label lblCreated = (Label)row.FindControl("lblCreated");
            DropDownList ddlstatus = (DropDownList)row.FindControl("ddlstatus");
            Label lbltype = (Label)row.FindControl("lblType");
            Label lblUID = (Label)row.FindControl("lblUID");
            DropDownList ddlReason = (DropDownList)row.FindControl("ddlReason");
            if (chkBox.Checked)
            {
                lstitem.ID = Convert.ToInt64(lbl.Text);
                lstitem.ReferedToLocation = Convert.ToInt16(ddl1.SelectedValue);
                lstitem.VisitID = Convert.ToInt64(lblVisitID.Text);
                lstitem.OrgID = OrgID;
                lstitem.Name = lblname.Text;
                lstitem.ReferralID = Convert.ToInt64(lblAccessionNumber.Text);
                lstitem.ModifiedBy = LID;
                lstitem.CreatedAt = lblCreated.Text == "" ? DateTime.MinValue : Convert.ToDateTime(lblCreated.Text);
                lstitem.Status = ddlstatus.SelectedItem.Text;
                lstitem.Type = lbltype.Text;
                lstitem.UID = lblUID.Text;
                lstitem.CreatedBy = Convert.ToInt64(hdnApprover.Value);
                lstitem.RefPhyName = ddlReason.SelectedItem.Value;
                lstOrderinvestication.Add(lstitem);
                string status = ddlstatus.SelectedItem.Text;
                ViewState["UID1"] = lblUID.Text;
                hdnUID.Value = ViewState["UID1"].ToString();

                if (!string.IsNullOrEmpty(status))
                {
                    System.Data.DataTable dt1 = new DataTable();
                    DataColumn Col1 = new DataColumn("Content");
                    DataColumn col2 = new DataColumn("Status");
                    DataColumn Col3 = new DataColumn("NotificationID");
                    DataColumn Col4 = new DataColumn("ClientID");
                    DataColumn Col5 = new DataColumn("InvoiceID");
                    DataColumn Col6 = new DataColumn("Seq_Num");
                    DataColumn Col7 = new DataColumn("Category");
                    DataColumn Col8 = new DataColumn("FromDate");
                    DataColumn Col9 = new DataColumn("TODate");
                    DataColumn Col10 = new DataColumn("ReportPath");
                    DataColumn Col11 = new DataColumn("OrgID");
                    DataColumn Col12 = new DataColumn("OrgAddressID");
                    //add columns
                    dt1.Columns.Add(Col1);
                    dt1.Columns.Add(col2);
                    dt1.Columns.Add(Col3);
                    dt1.Columns.Add(Col4);
                    dt1.Columns.Add(Col5);
                    dt1.Columns.Add(Col6);
                    dt1.Columns.Add(Col7);
                    dt1.Columns.Add(Col8);
                    dt1.Columns.Add(Col9);
                    dt1.Columns.Add(Col10);
                    dt1.Columns.Add(Col11);
                    dt1.Columns.Add(Col12);

                    byte[] byte1 = new byte[byte.MinValue];
                    Report_BL objReportBL = new Report_BL();
                    System.Data.DataTable dt = new DataTable();
                    DataColumn dbCol1 = new DataColumn("Content");
                    DataColumn dbCol2 = new DataColumn("TemplateID");
                    DataColumn dbCol3 = new DataColumn("Status");
                    DataColumn dbCol4 = new DataColumn("ReportPath");
                    DataColumn dbCol5 = new DataColumn("AccessionNumber");
                    DataColumn dbCol6 = new DataColumn("NotificationID");
                    DataColumn dbCol7 = new DataColumn("VisitID");
                    DataColumn dbCol8 = new DataColumn("Seq_Num");
                    DataColumn dbCol9 = new DataColumn("OrgID");
                    DataColumn dbCol10 = new DataColumn("OrgAddressID");
                    //add columns
                    dt.Columns.Add(dbCol1);
                    dt.Columns.Add(dbCol2);
                    dt.Columns.Add(dbCol3);
                    dt.Columns.Add(dbCol4);
                    dt.Columns.Add(dbCol5);
                    dt.Columns.Add(dbCol6);
                    dt.Columns.Add(dbCol7);
                    dt.Columns.Add(dbCol8);
                    dt.Columns.Add(dbCol9);
                    dt.Columns.Add(dbCol10);
                    DataRow dr;
                    dr = dt.NewRow();
                    dr["Content"] = byte1;
                    dr["TemplateID"] = 0;
                    dr["Status"] = "DIFFERED";
                    dr["ReportPath"] = "";
                    dr["AccessionNumber"] = "";
                    dr["NotificationID"] = "";
                    if (!string.IsNullOrEmpty(lblVisitID.Text))
                    {
                        dr["VisitID"] = Convert.ToInt64(lblVisitID.Text);
                    }
                    else
                    {
                        dr["VisitID"] = 0;
                    }

                    dr["Seq_Num"] = 0;
                    dr["OrgID"] = OrgID;
                    dr["OrgAddressID"] = OrgID;
                    dt.Rows.Add(dr);
                    objReportBL.UpdateNotification(dt, dt1);
                }
            }


        }
        if (lstOrderinvestication.Count > 0)
        {
            //string ExternalVisitID = String.Empty;
            returnCode = OrdInv.SaveOrderLocation(lstOrderinvestication, OrgID);

            if (returnCode == 0)
            {
                //if (hdn.Value != string.Empty)
                //{
                loadList(hdn.Value, txtFromDate.Text, TxtToDate.Text, txtPname.Text, patientnumber, txtvisitno.Text);

                //}
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "aa", "ValidationWindow('" + strSuccess.Trim() + "','" + strAlert.Trim() + "');", true);


            }

            foreach (var lst in lstOrderinvestication)//deep
            {
                if (lst.Status == "Revalidate")
                {
                    Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
                    long createTaskID = -1;
                    Tasks task = new Tasks();
                    long returncode = -1;
                    long refPhysicianID = -1;
                    long PatientID = -1;
                    string gUID = string.Empty;
                    Hashtable dText = new Hashtable();
                    Hashtable urlVal = new Hashtable();
                    vid = lstOrderinvestication[0].VisitID;
                    PatientID = Convert.ToInt32(hdnPatientId.Value);
                    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                    returncode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(vid, out lstPatientVisitDetails);
                    string RId = string.Empty;
                    string ClientID = string.Empty;
                    gUID = hdnUID.Value;
                    returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Revalidate),
                                              vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                              lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                              , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                              gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                 //   task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Revalidate);
                    task.TaskActionID = 95;        
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.RoleID = RoleID;
                    task.OrgID = Convert.ToInt32(OrgID.ToString());
                    task.PatientVisitID = vid;
                    task.PatientID = PatientID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    task.RefernceID = hdnLabNo.Value;
                    task.ActionName = "Y"; 
                    returncode = oTasksBL.CreateTask(task, out createTaskID);
                    break;
                } 
            }

        } 
        else
        {
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "Please select a record and then Save";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "ValidationWindow('" + strRecordSave.Trim() + "','" + strAlert.Trim() + "');", true);
        }


        //Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        //PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
        // string ExternalVisitID = String.Empty;

        //returnCode = patientBL.GetInvestigationOrgChange(ExternalVisitID, OrgID, out lstpatientVisit, out lstOrderinvestication);
        //grdResult.DataSource = lstOrderinvestication;
        //grdResult.DataBind();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            long Returncode = -1;
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            string Showconfidential = string.Empty;
            Returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    #endregion
    #region "Methods"

    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            Int32 orgId = 0;
            if (!String.IsNullOrEmpty(hdnOrgId.Value))
            {
                Int32.TryParse(hdnOrgId.Value, out orgId);
            }
            else
            {
                orgId = OrgID;
            }
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, orgId, out lstConfig);
            if (lstConfig.Count > 0)
                strConfigValue = lstConfig[0].ConfigValue;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }


    public void loadList(string ExternalVisitID, string FromDate, string toDate, string PatientName, string patientnumber, string patientvisitno)
    {
        string strMale = Resources.Lab_ClientDisplay.Lab_InvestigationOrgChange_aspx_07 == null ? "[Male]" : Resources.Lab_ClientDisplay.Lab_InvestigationOrgChange_aspx_07;
        string strFemale = Resources.Lab_ClientDisplay.Lab_InvestigationOrgChange_aspx_08 == null ? "[Female]" : Resources.Lab_ClientDisplay.Lab_InvestigationOrgChange_aspx_08;
string strUnknownF = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086 == null ? "UnKnown" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086;
        try
        {
            long returncode = -1;
            txtPatientSearch.Text = Convert.ToString(ExternalVisitID);

            /* Header Patient Details Display Block */

            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            //PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);


            returncode = patientBL.GetInvestigationOrgChange(ExternalVisitID, OrgID, FromDate, toDate, PatientName, patientnumber, patientvisitno, out lstpatientVisit, out lstOrderinvestication);

            if ((lstpatientVisit.Count > 0 )&& (lstOrderinvestication.Count  > 0))
            {
                dInves.Style.Add("display", "block");
                DrName.Text = lstpatientVisit[0].ReferingPhysicianName;
                HospitalName.Text = lstpatientVisit[0].HospitalName;
                ViewState["PatientID1"] = lstpatientVisit[0].PatientID;
                hdnPatientId.Value = ViewState["PatientID1"].ToString();
                ViewState["LabNo"] = lstOrderinvestication[0].LabNo;
                hdnLabNo.Value = ViewState["LabNo"].ToString();

                if (lstpatientVisit[0].CollectionCentreName != null && lstpatientVisit[0].CollectionCentreName != "")
                {
                    trCC.Style.Add("display", "table-row");
                    CollectionCentre.Text = lstpatientVisit[0].CollectionCentreName;
                }
                else
                {
                    trCC.Style.Add("display", "none");
                }
                //////////////////Vijayalakshmi.M ////////////////////////
                IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitIdWaterMark", OrgID);
                if (IsNeedExternalVisitIdWaterMark == "Y" && (lstpatientVisit[0].ExternalVisitID != string.Empty))
                // if (lstpatientVisit[0].ExternalVisitID != string.Empty)
                {
                    lblVisitNo.Text = lstpatientVisit[0].ExternalVisitID.ToString();
                }
                else
                {
                    lblVisitNo.Text = lstpatientVisit[0].VisitNumber.ToString();
                }
                lblPatientName.Text = lstpatientVisit[0].TitleName + " " + lstpatientVisit[0].PatientName;
                lblPatientNo.Text = Convert.ToString(lstpatientVisit[0].PatientNumber);

                if (lstpatientVisit[0].Sex == "M")
                {
                    lblGender.Text = strMale.Trim();
                }
                else if (lstpatientVisit[0].Sex == "F")
                {
                    lblGender.Text = strFemale.Trim();
                }
                else if (lstpatientVisit[0].Sex == "U")
                {
                    lblGender.Text = strUnknownF;
                }
                else
                {
                    lblGender.Text = "";
                }

                lblAge.Text = lstpatientVisit[0].PatientAge.ToString();
                grdResult.DataSource = lstOrderinvestication;
                grdResult.DataBind();
                lblStatus.Visible = false;
                lblText.Visible = true;
                pnlptDetails.Visible = true;
                grdResult.Visible = true;
                trApprover.Style.Add("display", "table-row");
                btnSubmit.Visible = true;
                btnCancel.Visible = true;

            }

            else
            {
                trApprover.Style.Add("display", "none");
                btnSubmit.Visible = false;
                btnCancel.Visible = false;
                lblStatus.Visible = true;
                lblText.Visible = false;
                pnlptDetails.Visible = false;
                grdResult.Visible = false;

            }
            txtPname.Text = "";
            hdnApprover.Value = "";
            txtAuthorised.Text = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while load data investigation sample", ex);
        }
    }


    #endregion






}


