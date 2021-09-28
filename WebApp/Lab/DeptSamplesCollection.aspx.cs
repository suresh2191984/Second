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
using System.Text;
using System.Security.Cryptography;
using Attune.Solution.DAL;
using Attune.Podium.PerformingNextAction;
public partial class Lab_DeptSamplesCollection : BasePage, System.Web.UI.ICallbackEventHandler
{
    public Lab_DeptSamplesCollection()
        : base("Lab_DeptSamplesCollection")
    {
    }

    int currentPageNo = 1;
    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    int DeptID = 0;
    long taskID = -1;
    //    long visitID = -1;
    long patientID = -1;
    long returnCode = -1;

    private long patientVisitID;

    string invStatus = string.Empty;

    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
    List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
    List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
    List<SampleTracker> lstSampleTracker = new List<SampleTracker>();
    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
    List<CollectedSample> lstOrderedSamples = new List<CollectedSample>();
    List<PatientVisitDetails> lPatientVisitDetails = new List<PatientVisitDetails>();
    List<OrganizationAddress> lAddress = new List<OrganizationAddress>();
    //List<PatientVisitDetails> lPatientVisitDetails = new List<PatientVisitDetails>();
    string ExternalVisitID = string.Empty;
    long PatientVisitID = 0;
    string PatientNumber = string.Empty;
    List<InvReasonMasters> lstInvReasonMaster = new List<InvReasonMasters>();
    List<InvSampleStatusmaster> lstInvSampleStatus = new List<InvSampleStatusmaster>();
    string defaultText = string.Empty;
    string IsNeedExternalVisitIdWaterMark = string.Empty;
 #region "Common Resource Property"

    string strSelect = Resources.Lab_ClientDisplay.Lab_DeptSamplesCollection_aspx_05 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_DeptSamplesCollection_aspx_05;

    #endregion
    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        string strLabNo = Resources.Lab_ClientDisplay.Lab_DeptSamplesCollection_aspx_02 == null ? "Lab Number" : Resources.Lab_ClientDisplay.Lab_DeptSamplesCollection_aspx_02;
        string strVisitNo = Resources.Lab_ClientDisplay.Lab_DeptSamplesCollection_aspx_03 == null ? "Visit Number" : Resources.Lab_ClientDisplay.Lab_DeptSamplesCollection_aspx_03;

        try
        {
            hdnTestCheckBoxId.Value = "";
            chkSelectAll.Checked = false;
            LoadReasons();
            returnCode = new Investigation_BL(base.ContextInfo).GetInvStatus(OrgID, "ReceiveSample", out lstInvSampleStatus);
            txtVisitID.Focus();

            ClientScriptManager cs = Page.ClientScript;
            String callBackReference = cs.GetCallbackEventReference("'" + Page.UniqueID + "'", "arg", "TaskOpenJs", "", "ProcessCallBackError", false);
            String callBackScript = "function ValidateUserExit(arg) {" + callBackReference + "; }";
            cs.RegisterClientScriptBlock(this.GetType(), "CallUserNavigateValidation", callBackScript, true);
            HdnBtnClicked.Value = "False";
            if (!IsPostBack)
            {
                //returnCode = new Investigation_BL(base.ContextInfo).GetReceiveSampleList(OrgID, ILocationID,ExternalVisitID, out lPatientVisitDetails);

                //if (lPatientVisitDetails.Count > 0)
                //{
                //    grdRecSampleList.DataSource = lPatientVisitDetails;
                //    grdRecSampleList.DataBind();
                //}

                //int j = 0;
                //for (int i = 2009; i <= 2020; i++)
                //{
                //    ddlSearchYear.Items.Insert(j, Convert.ToString(i));
                //    ddlSearchYear.Items[j].Value = Convert.ToString(i);
                //    j += 1;
                //}
                //ddlSearchYear.SelectedValue = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year.ToString();

                //returnCode = new Investigation_BL(base.ContextInfo).GetReceiveSampleList(OrgID, ILocationID, out lPatientVisitDetails);

                ////if (lPatientVisitDetails.Count > 0)
                ////{
                //grdRecSampleList.DataSource = lPatientVisitDetails;
                //grdRecSampleList.DataBind();

                int j = 0;
                for (int i = 2009; i <= 2020; i++)
                {
                    ddlSearchYear.Items.Insert(j, Convert.ToString(i));
                    ddlSearchYear.Items[j].Value = Convert.ToString(i);
                    j += 1;
                }
                ddlSearchYear.SelectedValue = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year.ToString();
                //LoadReceiveSampleList();
                LoadReceiveSampleList(e, currentPageNo, PageSize);
                LoadLocation();
                LoadSourceNameTrustedOrg();
                LoadMeatData();
                AutoCompleteExtender1.ContextKey = OrgID.ToString();
                AutoCompleteExtender2.ContextKey = OrgID.ToString();

            }
            IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitIdWaterMark", OrgID);
            if (IsNeedExternalVisitIdWaterMark == "Y")
            {
                defaultText = strLabNo.Trim();
                txtVisitID.MaxLength = 9;
            }
            else
            {
                defaultText = strVisitNo.Trim();
            }
            textwatermark();
        }
        catch (Exception ex)
        {
            // CLogger.LogError("Error in page load of Dept Sample Collection", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Error in page load";
        }

        txtbarcodeno.Focus();

    }
    #endregion
    #region "Events"
    protected void grdRecSampleList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "LoadPatientList")
        {
            HdnBtnClicked.Value = "True";
            int RowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow gr = grdRecSampleList.Rows[RowIndex];
            hdnVisit.Value = ((Label)gr.FindControl("lblpvID")).Text;
            string visitno = ((LinkButton)gr.FindControl("LinkButton1")).Text;
            string vnum = string.Empty;
            Investigation_BL invBL = new Investigation_BL(ContextInfo);
            patientVisitID = Convert.ToInt32(((Label)gr.FindControl("lblpvID")).Text);

            Boolean isAlreadyPicked = invBL.UpdateReceiveSamplePickedBy(patientVisitID, LID, "N");

            if (isAlreadyPicked == true)
            {
                divPatientDetails.Style.Add("display", "none");
                dInves.Style.Add("display", "none");
                LoadReceiveSampleList(e, currentPageNo, PageSize);
                string sPath = "CommonControls\\\\Tasks.ascx.cs_2";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "ShowAlertMsg('" + sPath + "');", true);
            }

            else
            {
                if (visitno != "")
                {
                    int length = visitno.Length - 2;
                    string revstr = "";
                    while (length >= 0)
                    {
                        if (visitno[length].ToString() == ":")
                        {
                            length = 0;

                        }
                        if (length != 0)
                        {
                            revstr = revstr + visitno[length];
                        }
                        length--;
                    }
                    char[] VNumber = revstr.ToCharArray();
                    Array.Reverse(VNumber);
                    vnum = new string(VNumber);
                }

                hdnPatientNumber.Value = ((Label)gr.FindControl("lblPnumber")).Text;
                hdnPatID.Value = ((Label)gr.FindControl("lblPID")).Text;
                PatientVisitID = Convert.ToInt64(hdnVisit.Value);
                loadOrederedList(PatientVisitID, vnum);
                txtSearchTxt.Text = Convert.ToString(ExternalVisitID);
                pnlSerch.Enabled = false;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0);", true);
                // ExpectantSampleQueue.Visible = true;
                PatientDetail.LoadPatientDetails(PatientVisitID, OrgID, "");
                divPatientDetails.Style.Add("display", "block");
                dInves.Style.Add("display", "block");
                //btnSubmit.Attributes.Add("onclick", "return GenerateWorkOrder1(" + OrgID + "," + LID + "," + ILocationID + "," + PatientVisitID + ",'" + gUID + "','" + strCollectAgain + "','" + strSampleRelationshipID + "')");
                LoadReceiveSampleList(e, currentPageNo, PageSize);
                GrdFooter.Style.Add("display", "none");
                ACXresponsessmp1.Style.Add("dispaly", "none");
            }
        }
        btnSubmit.Focus();
        btnsave.Focus();
    }
    protected void grdRecSampleList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdRecSampleList.PageIndex = e.NewPageIndex;
            LoadReceiveSampleList(e, currentPageNo, PageSize);
        }
        //string ExternalVisitID = string.Empty;

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string strSuccessAlert = Resources.Lab_ClientDisplay.Lab_DeptSamplesCollection_aspx_04 == null ? "Saved Successfully!" : Resources.Lab_ClientDisplay.Lab_DeptSamplesCollection_aspx_04;
        try
        {
            int patientCount = 0;
            List<Patient> lPatient = new List<Patient>();
            returnCode = new Patient_BL(base.ContextInfo).GetRegistrationStatus(hdnPatientNumber.Value, OrgID, out patientCount, out lPatient);
            if (patientCount == 0)
            {

                PatientVisitID = InsertPatient();
            }
            else
            {
                PatientVisitID = InsertExternalVist(lPatient[0].PatientID);
            }
            long returncode = -1;

            //int upis = -1;           
            //List<PatientVisitDetails> lPatientVisitDetails = new List<PatientVisitDetails>();           
            //returnCode = new Investigation_BL(base.ContextInfo).GetReceiveSampleList(OrgID, ILocationID, out lPatientVisitDetails);
            //visitID = lPatientVisitDetails[0].PatientVisitId; 

            //Int64.TryParse(Request.QueryString["vid"], out visitID);
            //visitID = Convert.ToInt64(Request.QueryString["vid"]);
            //ExternalVisitID  = txtSearchTxt.Text;
            //visitID = Convert.ToInt64(txtSearchTxt.Text);
            //PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);

            //Statement Added to change Search by BillID and VisitID
            //string year = ddlSearchYear.SelectedValue;
            // patientVisitBL.GetVisitIDByBillID(visitID, OrgID, year, out visitID);
            string year = ddlSearchYear.SelectedValue;
            //patientVisitBL.GetVisitIDByBillID(visitID, OrgID, year, out visitID);
            //end of statement
            SampleTracker SampleTracker = null;
            Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
            int Count = 0;


            #region "Comment Code"

            //foreach (RepeaterItem repItem in this.repSampleCollect.Items)
            //{
            //    CheckBox chkSample = repItem.FindControl("chkSampleCollect") as CheckBox;

            //    if (chkSample.Checked)
            //    {
            //        Label lbsid = repItem.FindControl("lsid") as Label;
            //        Label lbSampleID = repItem.FindControl("lblSampleID") as Label;
            //        Label lbSampleCollect = repItem.FindControl("lblSampleCollect") as Label;
            //        TextBox txSampleCollect = repItem.FindControl("txtSampleCollect") as TextBox;
            //        DropDownList ddlSStatus = repItem.FindControl("ddlSampleStatus") as DropDownList;

            //        SampleTracker = new SampleTracker();
            //        SampleTracker.PatientVisitID = visitID;
            //        SampleTracker.SampleID = int.Parse(lbsid.Text);
            //        SampleTracker.InvSampleStatusID = Convert.ToInt32(ddlSStatus.SelectedValue.ToString());
            //        SampleTracker.CurrentOrgID = OrgID;
            //        SampleTracker.DeptID = lstInvDeptMaster[0].DeptID;
            //        SampleTracker.Reason = txSampleCollect.Text;
            //        SampleTracker.CreatedBy = Convert.ToInt32(UID);
            //        SampleTracker.ModifiedBy = Convert.ToInt32(UID);
            //        lstSampleTracker.Add(SampleTracker);

            //        if (lstSampleTracker.Count > 0)
            //        {
            //            returncode = invBL.saveSampleCollectionFromDeptID(lstSampleTracker);
            //            lstSampleTracker.Clear();
            //            Count++;
            //        }

            //    }
            //    else if (Count == 0)
            //    {
            //        ErrorDisplay1.ShowError = true;
            //        ErrorDisplay1.Status = "Must select one depatrment";
            //    }
            //}

            ////Update PatientInvestigation staus to Sample Received
            ////string sts = "SampleReceived";
            ////invBL.updatePatientInvestigationStatus(visitID, sts, DeptID, out upis);

            //if (returncode == 0)
            //{
            //    if (invStatus == String.Empty)
            //    {
            //        new Investigation_BL(base.ContextInfo).getInvOrgSampleStatus(OrgID, "SampleCollected", out invStatus);
            //    }
            //    invBL.updatePatientInvestigationStatus(visitID, invStatus, DeptID, "SampleCollected", out upis);


            //    Int64.TryParse(Request.QueryString["tid"], out taskID);
            //    //Update InvestigationPayment tasks
            //    new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);

            //    //        Response.Redirect("Home.aspx");
            //    List<Role> lstUserRole = new List<Role>();
            //    string path = string.Empty;
            //    Role role = new Role();
            //    role.RoleID = RoleID;
            //    lstUserRole.Add(role);
            //    returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            //    Response.Redirect(Request.ApplicationPath + path, true);
            //}
            #endregion

            foreach (RepeaterItem repItem in this.repSampleCollect.Items)
            {
                CheckBox chkSample = repItem.FindControl("chkSampleCollect") as CheckBox;

                if (chkSample.Checked)
                {
                    Label lbsid = repItem.FindControl("lsid") as Label;
                    Label lbSampleID = repItem.FindControl("lblSampleID") as Label;
                    Label lbSampleCollect = repItem.FindControl("lblSampleCollect") as Label;
                    //TextBox txSampleCollect = repItem.FindControl("txtSampleCollect") as TextBox;
                    DropDownList txSampleCollect = repItem.FindControl("ddlReason") as DropDownList;
                    DropDownList ddlSStatus = repItem.FindControl("ddlSampleStatus") as DropDownList;
                    TextBox txtSrfId = repItem.FindControl("txtSrfId") as TextBox;

                    SampleTracker = new SampleTracker();
                    SampleTracker.PatientVisitID = PatientVisitID;
                    SampleTracker.SampleID = int.Parse(lbsid.Text);
                    SampleTracker.Remarks = txtSrfId.Text;
                    SampleTracker.InvSampleStatusID = Convert.ToInt32(ddlSStatus.SelectedValue.ToString());
                    //SampleTracker.CurrentOrgID = OrgID;
                    ////////////SampleTracker.DeptID = Convert.ToInt32(hDept.Value);
                    //SampleTracker.Reason = txSampleCollect.Text;
                    HiddenField hdnSelectedReason1 = (HiddenField)repItem.FindControl("hdnSelectedReason") as HiddenField;
                    SampleTracker.Reason = hdnSelectedReason1.Value;
                    SampleTracker.CreatedBy = Convert.ToInt32(LID);
                    SampleTracker.CollectedIn = ILocationID;

                    SampleTracker.OrgID = OrgID;
                    lstSampleTracker.Add(SampleTracker);
                    Count++;

                }
                else if (Count == 0)
                {
                    //ErrorDisplay1.ShowError = true;
                    // ErrorDisplay1.Status = "Please Select Atleast One Sample and Click Finish";
                }
            }

            if (lstSampleTracker.Count > 0)
            {
                returncode = invBL.saveSampleCollectionFromDeptID(lstSampleTracker);
                if (returncode != 0)
                {
                    lstSampleTracker.Clear();
                    dInves.Style.Add("display", "none");
                    txtVisitID.Text = string.Empty;
                    txtVisitID.Focus();
                    //ErrorDisplay1.ShowError = false;
                    //pnlSampleList.Visible = false;
                    lblStatus.Visible = true;
                    lblStatus.Text = strSuccessAlert.Trim();
                    LoadReceiveSampleList(e, currentPageNo, PageSize);
                    txtSearchTxt.Text = string.Empty;
                    pnlSerch.Enabled = true;
                    divPatientDetails.Style.Add("display", "none");
                    dInves.Style.Add("display", "none");
                    // code added by karthik for Notifications insert after receive sample **********************/
                        long patientVisitID = PatientVisitID;
                        ActionManager AM = new ActionManager(base.ContextInfo);
                        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                        PageContextkey PC = new PageContextkey();
                        PC.RoleID = Convert.ToInt64(RoleID);
                        PC.OrgID = OrgID;
                        PC.PageID = Convert.ToInt64(PageID);
                        PC.ButtonName = "btnSubmit";
                        PC.ButtonValue = "Submit";
                        PC.ActionType = "LISOrdered";
                        PC.PatientID = patientID;
                        PC.PatientVisitID = patientVisitID;
                        lstpagecontextkeys.Add(PC);
                        long res = -1;
                        res = AM.PerformingNextStepNotification(PC, "", "");
                    // code added by karthik for Notifications insert after receive sample **********************/
                }

                divPatientDetails.Style.Add("display", "none");
                dInves.Style.Add("display", "none");
            }
            tdbutsave2.Style.Add("display", "none");
            txtbarcodeno.Text = "";
            txtbarcodeno.Focus();
        }
        catch (System.Threading.ThreadAbortException th)
        {
            string exep = th.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DeptSample Collection btnSubmit_Click", ex);
        }
        // ExpectantSampleQueue.RefereshRecievedSampleCount();
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {

        try
        {
            Investigation_BL invBL = new Investigation_BL(ContextInfo);
            PatientVisitID = Convert.ToInt64(hdnVisit.Value);
            Boolean isAlreadyPicked = invBL.UpdateReceiveSamplePickedBy(PatientVisitID, LID, "Y");

            lstSampleTracker.Clear();
            dInves.Style.Add("display", "none");
            txtVisitID.Text = string.Empty;
            txtVisitID.Focus();
            //ErrorDisplay1.ShowError = false;
            lblStatus.Visible = true;
            lblStatus.Text = "";
            LoadReceiveSampleList(e, currentPageNo, PageSize);
            txtSearchTxt.Text = string.Empty;
            pnlSerch.Enabled = true;
            divPatientDetails.Style.Add("display", "none");
            dInves.Style.Add("display", "none");
            HdnBtnClicked.Value = "True";
            txtbarcodeno.Text = string.Empty;
            txtbarcodeno.Focus();
            tdbutsave2.Style.Add("display", "none");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on event btnCancel_Click in page DeptSamplesCollection.aspx", ex);
        }
        //long returncode = -1;

        //List<Role> lstUserRole = new List<Role>();
        //string path = string.Empty;
        //Role role = new Role();
        //role.RoleID = RoleID;
        //lstUserRole.Add(role);
        //returncode = new Navigation().GetLandingPage(lstUserRole, out path);
        //Response.Redirect(Request.ApplicationPath + path, true);





    }
    protected void btnGo_Click(object sender, EventArgs e)
    {

        //loadOrederedList(Convert.ToInt32(txtSearchTxt.Text));
        currentPageNo = 1;

        List<PatientVisitDetails> lPatientVisitDetails = new List<PatientVisitDetails>();
        PatientVisitDetails filterList = new PatientVisitDetails();
        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
        //List<PatientVisitDetails> lVisitDetails = new List<PatientVisitDetails>();
        long returnCode = -1;
        string visitid = string.Empty;
        string patientname = string.Empty;
        /* BEGIN | NA | Sabari | 20190515 | Created | MRNNumberSearch */
        string patientnumber = string.Empty;
        /* END | NA | Sabari | 20190515 | Created | MRNNumberSearch */
        int visittype = -1;
        int priority = -1;
        string fromdate = string.Empty;
        string todate = string.Empty;
        string sourcename = string.Empty;
        string InvestigationName = string.Empty;
        long InvestigationID = -1;
        string InvestigationType = string.Empty;
        string refPhyName = string.Empty;
        long refPhyID = -1;
        long refPhyOrg = -1;
        int CollectedLocationID = -1;
        string BarcodeNo = string.Empty;
        //DateTime fDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        //DateTime tDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        //if (txtFrom.Text != "" && txtTo.Text != "")
        //{
        //    fDate = Convert.ToDateTime(txtFrom.Text);
        //    tDate = Convert.ToDateTime(txtTo.Text);
        //}
        Boolean isAlreadyPicked = invbl.UpdateReceiveSamplePickedBy(patientVisitID, LID, "N");
        hdnCurrent.Value = "";
        if (txtVisitID.Text.Trim() == defaultText.Trim())
        {
            txtVisitID.Text = "";
        }
        if (txtVisitID.Text != "")
        {
            visitid = txtVisitID.Text.Trim();
            if (visitid.Contains("-"))
            {
                visitid = visitid.ToString().Split('-')[0];
            }
        }

        if (txtPatientName.Text != "")
        {
            patientname = txtPatientName.Text.Trim();
        }
        /* BEGIN | NA | Sabari | 20190515 | Created | MRNNumberSearch */
        if (txtPatientNumber.Text != "")
        {
            patientnumber = txtPatientNumber.Text.Trim();
        }
        /* END | NA | Sabari | 20190515 | Created | MRNNumberSearch */
        if (ddVisitType.SelectedValue != "-1")
        {
            visittype = Convert.ToInt32(ddVisitType.SelectedValue);
        }

        if (ddlPriority.SelectedValue != "-1")
        {
            priority = Convert.ToInt32(ddlPriority.SelectedValue);
        }

        if (ddlPriority.SelectedValue != "-1")
        {
            priority = Convert.ToInt32(ddlPriority.SelectedValue);
        }

        if (txtFrom.Text != "" && txtTo.Text != "")
        {
            if (txtFrom.Text == txtTo.Text)
            {
                fromdate = Convert.ToString(Convert.ToDateTime(txtFrom.Text));
                todate = Convert.ToString(Convert.ToDateTime(txtFrom.Text));

                //fromDate = txtFrom.Text; ;
                //toDate = Convert.ToDateTime(fromDate).AddDays(1).ToString("dd/MM/yyyy");
            }
            else
            {
                fromdate = Convert.ToString(Convert.ToDateTime(txtFrom.Text));
                todate = Convert.ToString(Convert.ToDateTime(txtTo.Text));
                //fromDate = txtFrom.Text;
                //toDate = txtTo.Text;
            }
        }
        else
        {
            fromdate = string.Empty;
            todate = string.Empty;
        }

        if (ddClientName.SelectedValue != "-1")
        {
            sourcename = ddClientName.SelectedValue.ToString();

        }
        if (txtTestName.Text != "" && hdnTestID.Value != "0")
        {
            InvestigationName = hdnTestName.Value;
            InvestigationID = Convert.ToInt64(hdnTestID.Value);
            InvestigationType = hdnTestType.Value;
        }

        if (txtRefDrName.Text != "" && hdnRefPhyID.Value != "0")
        {
            refPhyName = hdnRefPhyName.Value;
            refPhyID = Convert.ToInt64(hdnRefPhyID.Value);
            refPhyOrg = Convert.ToInt32(hdnRefPhyOrg.Value);
        }

        if (ddlLocation.SelectedValue != "-1")
        {
            CollectedLocationID = Convert.ToInt32(ddlLocation.SelectedValue);
        }

        if (txtbarcodeno.Text != null)
        {
            BarcodeNo = txtbarcodeno.Text.ToString();
        }
        invbl.GetReceiveSampleList(OrgID, ILocationID, CollectedLocationID, visitid, patientname, visittype, priority, fromdate, todate, sourcename, InvestigationName, InvestigationID, InvestigationType, refPhyName, refPhyID, refPhyOrg, BarcodeNo, out lPatientVisitDetails, PageSize, currentPageNo, out totalRows, patientnumber);
        //Below Line is commented by mohan , since we handle the visitid search in the above method
        //if (txtSearchTxt.Text != string.Empty)
        //{
        //    if (lPatientVisitDetails.Count > 0)
        //    {

        //        lPatientVisitDetails = lPatientVisitDetails.Where(O => O.ExternalVisitID == txtSearchTxt.Text).ToList();
        //        //lPatientVisitDetails = new List<PatientVisitDetails>();
        //        //lPatientVisitDetails.Add(filterList);
        //    }
        //}

        if (txtVisitID.Text != "" && lPatientVisitDetails.Count == 0)
        {
            dInves.Style.Add("display", "none");
            //pnlSampleList.Visible = false;
            grdRecSampleList.DataSource = lPatientVisitDetails;
            grdRecSampleList.DataBind();
            txtSearchTxt.Text = string.Empty;
            txtSearchTxt.Focus();

        }
        else
        {
            grdRecSampleList.DataSource = lPatientVisitDetails;
            grdRecSampleList.DataBind();
            dInves.Style.Add("display", "none");
        }
        hdnClickEvent.Value = "Yes";
        lblStatus.Visible = true;
        lblStatus.Text = "";

        if (txtVisitID.Text == "" && lPatientVisitDetails.Count > 0)
        {
            GrdFooter.Style.Add("display", "table-row");
            ACXresponsessmp1.Style.Add("dispaly", "table-row");

            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();

            hdnCurrent.Value = currentPageNo.ToString();
            lblCurrent.Text = currentPageNo.ToString();

            if (currentPageNo == 1)
            {
                btnPrevious.Enabled = false;
                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    btnNext.Enabled = true;
                }
                else
                    btnNext.Enabled = false;
            }
            else
            {
                btnPrevious.Enabled = true;
                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    btnNext.Enabled = false;
                else btnNext.Enabled = true;
            }
        }
        else
        {
            GrdFooter.Style.Add("display", "none");
            ACXresponsessmp1.Style.Add("dispaly", "none");
            //txtbarcodeno.Text = string.Empty;
            //txtbarcodeno.Focus();
        }
        divPatientDetails.Style.Add("display", "none");
        dInves.Style.Add("display", "none");
        HdnBtnClicked.Value = "True";
        if (lPatientVisitDetails.Count == 1)
        {
            chkSelectAll.Checked = true;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "SelectAllSamples('" + chkSelectAll.ClientID + "');", true);
            tdbutsave2.Style.Add("display", "table-cell");
            grdRecSampleList.DataSource = lPatientVisitDetails;
            grdRecSampleList.DataBind();
            loadOrederedList(lPatientVisitDetails[0].PatientVisitId, "");
            hdnVisit.Value = lPatientVisitDetails[0].PatientVisitId.ToString();
            hdnPatientNumber.Value = lPatientVisitDetails[0].PatientNumber.ToString();
            hdnPatID.Value = lPatientVisitDetails[0].PatientID.ToString();
            //          lblVisitNo.Text = lPatientVisitDetails[0].VisitNumber.ToString();
            pnlSerch.Enabled = false;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0);", true);
            GrdFooter.Style.Add("display", "none");
            ACXresponsessmp1.Style.Add("dispaly", "none");
            PatientDetail.LoadPatientDetails(lPatientVisitDetails[0].PatientVisitId, OrgID, "");
            divPatientDetails.Style.Add("display", "block");
            btnSubmit.Focus();
            btnsave.Focus();
        }
        else
        {
            txtbarcodeno.Text = string.Empty;
            txtbarcodeno.Focus();
            tdbutsave2.Style.Add("display", "none");
        }
    }
    protected void repSampleCollect_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        string strSelect = Resources.Lab_ClientDisplay.Lab_DeptSamplesCollection_aspx_01 == null ? "-----Select-----" : Resources.Lab_ClientDisplay.Lab_DeptSamplesCollection_aspx_01;
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DropDownList ddlStatus1 = (DropDownList)e.Item.FindControl("ddlSampleStatus");
            ddlStatus1.DataSource = lstInvSampleStatus;
            ddlStatus1.DataTextField = "InvSampleStatusDesc";
            ddlStatus1.DataValueField = "InvSampleStatusID";
            ddlStatus1.DataBind();
            TextBox txtSrfId = (TextBox)e.Item.FindControl("txtSrfId");
            if (txtSrfId.Text != "")
            {
                txtSrfId.Enabled = false;
            }
            DropDownList ddlReason1 = (DropDownList)e.Item.FindControl("ddlReason");
            ddlStatus1.Attributes.Add("onChange", "fnLoadReasons('" + ddlReason1.ClientID.ToString() + "','" + ddlStatus1.ClientID.ToString() + "');");
            ddlReason1.Items.Insert(0, strSelect.Trim());
            HiddenField hdnSelectedReason1 = (HiddenField)e.Item.FindControl("hdnSelectedReason");
            ddlReason1.Attributes.Add("onChange", "fnSetSelectedReason('" + ddlReason1.ClientID.ToString() + "','" + hdnSelectedReason1.ClientID.ToString() + "');");
            if (hdnStatusCtls.Value == "")
            { hdnStatusCtls.Value = ddlStatus1.ClientID; }
            else { hdnStatusCtls.Value += '~' + ddlStatus1.ClientID; }

            if (hdnReasonCtls.Value == "")
            { hdnReasonCtls.Value = ddlReason1.ClientID; }
            else { hdnReasonCtls.Value += '~' + ddlReason1.ClientID; }

            CheckBox chkSampleCollect1 = (CheckBox)e.Item.FindControl("chkSampleCollect");
            if (hdnTestCheckBoxId.Value == "")
            {
                hdnTestCheckBoxId.Value = chkSampleCollect1.ClientID;
            }
            else
            {
                hdnTestCheckBoxId.Value += "~" + chkSampleCollect1.ClientID;
            }
        }
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = "";
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadReceiveSampleList(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadReceiveSampleList(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
        HdnBtnClicked.Value = "True";
        divPatientDetails.Style.Add("display", "none");
        dInves.Style.Add("display", "none");
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = "";
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadReceiveSampleList(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadReceiveSampleList(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
        HdnBtnClicked.Value = "True";
        divPatientDetails.Style.Add("display", "none");
        dInves.Style.Add("display", "none");
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);
        return totalPages;
    }
    protected void btnGo1_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = "";
        LoadReceiveSampleList(e, Convert.ToInt32(txtpageNo.Text), PageSize);
        txtpageNo.Text = "";
        HdnBtnClicked.Value = "True";
    }
    protected void grdRecSampleList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PatientVisitDetails PVD = (PatientVisitDetails)e.Row.DataItem;

            if (PVD.State == "Y")
            {
               //e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#EEB4B4");
                e.Row.CssClass = "enterresultstatcolor";
              //e.Row.BackColor = System.Drawing.Color.MistyRose;

               
            }
        }
    }

    #endregion


    #region "Methods"
    private void ClearPickedBy()
    {
        try
        {
            Investigation_BL invBL = new Investigation_BL(ContextInfo);
            Int64.TryParse(hdnVisit.Value, out PatientVisitID);
            if (PatientVisitID > 0)
            {
                Boolean isAlreadyPicked = invBL.UpdateReceiveSamplePickedBy(PatientVisitID, LID, "Y");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in RaiseCallbackEvent", ex);
            throw ex;
        }
    }
    public void RaiseCallbackEvent(string eventArgument)
    {
        try
        {
            string o = eventArgument;
            if (HdnBtnClicked.Value != "True")
            {
                ClearPickedBy();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in RaiseCallbackEvent", ex);
            // ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Error while processing task";
        }
    }
    public string GetCallbackResult()
    {
        return "LockReleased";
    }
    public void LoadReasons()
    {
        returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(OrgID, out lstInvReasonMaster);
        hdnReasonList.Value = "";
        if (lstInvReasonMaster.Count > 0)
        {
            foreach (InvReasonMasters oReasonMaster in lstInvReasonMaster)
            {
                hdnReasonList.Value += oReasonMaster.StatusID + "-" + oReasonMaster.ReasonID + "~" + oReasonMaster.ReasonDesc + "^";
            }
        }
    }
    private void LoadLocation()
    {
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        // Below Current Org Location
        //returnCode = patientBL.GetLocation(OrgID, LID, RoleID, out lstLocation);
        // Below is Trusted Org Location
        returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lstLocation);

        if (lstLocation.Count > 0)
        {


            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();


            if (lstLocation.Count == 1)
            {
                ddlLocation.Items.Insert(0, strSelect.Trim());
                ddlLocation.Items[0].Value = "-1";
            }
            else if (lstLocation.Count == 0 || lstLocation.Count > 1)
            {
                ddlLocation.Items.Insert(0, strSelect.Trim());
                ddlLocation.Items[0].Value = "-1";
            }
            //ddlLocation.SelectedValue = ILocationID.ToString();
        }
    }
    public void LoadSourceNameTrustedOrg()
    {
        try
        {
            long returnCode = -1;
            Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
            List<InvClientMaster> lstSourceName = new List<InvClientMaster>();
            returnCode = objPatientBL.GetTrustedOrgInvClientMaster(OrgID, "", out lstSourceName);
            if (lstSourceName.Count > 0)
            {
                ddClientName.DataSource = lstSourceName;
                ddClientName.DataTextField = "ClientName";
                ddClientName.DataValueField = "ClientID";
                ddClientName.DataBind();
                ddClientName.Items.Insert(0, strSelect.Trim());
                ddClientName.Items[0].Value = "-1";
            }
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing LoadSourceName() in Lab_Home_page ", e);
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
    private void textwatermark()
    {
        if (txtVisitID.Text.Trim() != defaultText.Trim())
        {
            txtVisitID.Attributes.Add("style", "color:black");
        }
        if (txtVisitID.Text == "")
        {
            txtVisitID.Text = defaultText;
            txtVisitID.Attributes.Add("style", "color:gray");
        }
        txtVisitID.Attributes.Add("onblur", "WaterMark(this,event,'" + defaultText + "');");
        txtVisitID.Attributes.Add("onfocus", "WaterMark(this,event,'" + defaultText + "');");
    }
    private void LoadReceiveSampleList()
    {
        //loadOrederedList(Convert.ToInt32(txtSearchTxt.Text));

        List<PatientVisitDetails> lPatientVisitDetails = new List<PatientVisitDetails>();
        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
        PatientVisitDetails filterList = new PatientVisitDetails();
        //List<PatientVisitDetails> lVisitDetails = new List<PatientVisitDetails>();
        long returnCode = -1;
        string visitid = string.Empty;
        string patientname = string.Empty;
        /* BEGIN | NA | Sabari | 20190515 | Created | MRNNumberSearch */
        string patientnumber = string.Empty;
        /* END | NA | Sabari | 20190515 | Created | MRNNumberSearch */
        int visittype = -1;
        int priority = -1;
        string fromdate = string.Empty;
        string todate = string.Empty;
        string sourcename = string.Empty;
        string InvestigationName = string.Empty;
        long InvestigationID = -1;
        string InvestigationType = string.Empty;
        string refPhyName = string.Empty;
        long refPhyID = -1;
        long refPhyOrg = -1;
        int CollectedLocationID = -1;
        string BarcodeNo = string.Empty;

        if (hdnClickEvent.Value == "Yes")
        {
            if (txtVisitID.Text.Trim() == defaultText.Trim())
            {
                txtVisitID.Text = "";
            }

            if (txtVisitID.Text != "")
            {
                visitid = txtVisitID.Text.Trim();
            }

            if (txtPatientName.Text != "")
            {
                patientname = txtPatientName.Text.Trim();
            }
            /* BEGIN | NA | Sabari | 20190515 | Created | MRNNumberSearch */
            if (txtPatientNumber.Text != "")
            {
                patientnumber = txtPatientNumber.Text.Trim();
            }
            /* END | NA | Sabari | 20190515 | Created | MRNNumberSearch */
            if (ddVisitType.SelectedValue != "-1")
            {
                visittype = Convert.ToInt32(ddVisitType.SelectedValue);
            }

            if (ddlPriority.SelectedValue != "-1")
            {
                priority = Convert.ToInt32(ddlPriority.SelectedValue);
            }

            if (ddlPriority.SelectedValue != "-1")
            {
                priority = Convert.ToInt32(ddlPriority.SelectedValue);
            }

            if (txtFrom.Text != "" && txtTo.Text != "")
            {
                if (txtFrom.Text == txtTo.Text)
                {
                    fromdate = Convert.ToString(Convert.ToDateTime(txtFrom.Text));
                    todate = Convert.ToString(Convert.ToDateTime(txtFrom.Text));

                    //fromDate = txtFrom.Text; ;
                    //toDate = Convert.ToDateTime(fromDate).AddDays(1).ToString("dd/MM/yyyy");
                }
                else
                {
                    fromdate = Convert.ToString(Convert.ToDateTime(txtFrom.Text));
                    todate = Convert.ToString(Convert.ToDateTime(txtTo.Text));
                    //fromDate = txtFrom.Text;
                    //toDate = txtTo.Text;
                }
            }
            else
            {
                fromdate = string.Empty;
                todate = string.Empty;
            }

            if (ddClientName.SelectedValue != "-1")
            {
                sourcename = ddClientName.SelectedValue.ToString();

            }
            if (txtTestName.Text != "" && hdnTestID.Value != "0")
            {
                InvestigationName = hdnTestName.Value;
                InvestigationID = Convert.ToInt64(hdnTestID.Value);
                InvestigationType = hdnTestType.Value;
            }

            if (txtRefDrName.Text != "" && hdnRefPhyID.Value != "0")
            {
                refPhyName = hdnRefPhyName.Value;
                refPhyID = Convert.ToInt64(hdnRefPhyID.Value);
                refPhyOrg = Convert.ToInt32(hdnRefPhyOrg.Value);
            }

            if (ddlLocation.SelectedValue != "-1")
            {
                CollectedLocationID = Convert.ToInt32(ddlLocation.SelectedValue);
            }

            if (txtbarcodeno.Text != null)
            {
                BarcodeNo = txtbarcodeno.Text.ToString();
            }

        }
        /* BEGIN | NA | Sabari | 20190515 | Created | MRNNumberSearch */
        invbl.GetReceiveSampleList(OrgID, ILocationID, CollectedLocationID, visitid, patientname, visittype, priority, fromdate, todate, sourcename, InvestigationName, InvestigationID, InvestigationType, refPhyName, refPhyID, refPhyOrg, BarcodeNo, out lPatientVisitDetails, PageSize, currentPageNo, out totalRows,patientnumber);
        /* END | NA | Sabari | 20190515 | Created | MRNNumberSearch */
        //Below Line is commented by mohan , since we handle the visitid search in the above method
        //if (txtSearchTxt.Text != string.Empty)
        //{
        //    if (lPatientVisitDetails.Count > 0)
        //    {

        //        lPatientVisitDetails = lPatientVisitDetails.Where(O => O.ExternalVisitID == txtSearchTxt.Text).ToList();
        //        //lPatientVisitDetails = new List<PatientVisitDetails>();
        //        //lPatientVisitDetails.Add(filterList);
        //    }
        //}
        if (lPatientVisitDetails.Count > 0)
        {
            GrdFooter.Style.Add("display", "table-row");
            ACXresponsessmp1.Style.Add("dispaly", "table-row");
            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();
            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = currentPageNo.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                currentPageNo = Convert.ToInt32(hdnCurrent.Value);
            }
            if (currentPageNo == 1)
            {
                btnPrevious.Enabled = false;
                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    btnNext.Enabled = true;
                }
                else
                    btnNext.Enabled = false;
            }
            else
            {
                btnPrevious.Enabled = true;
                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    btnNext.Enabled = false;
                else btnNext.Enabled = true;
            }
        }
        else
        {
            GrdFooter.Style.Add("display", "none");
            ACXresponsessmp1.Style.Add("dispaly", "none");
        }
        grdRecSampleList.DataSource = lPatientVisitDetails;
        grdRecSampleList.DataBind();
        pnlSerch.Enabled = true;
        //}
    }
    void loadOrederedList(long visitID, string VNo)
    {
        // visitID = visitID;
        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);

        //Load data for patient Details
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
        List<PatientVisit> visitList = new List<PatientVisit>();
        List<InvDeptMaster> deptList = new List<InvDeptMaster>();
        //Statement Added to change Search by BillID and VisitID
        //string year = ddlSearchYear.SelectedValue;
        //patientVisitBL.GetVisitIDByBillID(visitID, OrgID, year, out visitID);
        //end of statement
        returnCode = patientBL.GetLabVisitDetails(visitID, OrgID, out visitList);

        if (visitList.Count > 0)
        {
            if (VNo != "")
            {
                // lblVisitNo.Text = VNo;
            }
            else
            {
                if (visitList[0].ExternalVisitID != string.Empty)
                {
                    //   lblVisitNo.Text = visitList[0].ExternalVisitID.ToString();
                }
                else
                {
                    // lblVisitNo.Text = visitID.ToString();
                }
            }
            //lblReferingPhysician.Text = visitList[0].ReferingPhysicianName;
            //lblPatientName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;
            // lblPatientNo.Text = Convert.ToString(visitList[0].PatientNumber);
            // lblDate.Text = Convert.ToString(visitList[0].VisitDate.ToString("dd/MM/yyyy hh:mm tt"));

            if (visitList[0].Sex == "M")
            {
                // lblGender.Text = "M" + "/" + visitList[0].PatientAge.ToString(); 
            }
            else
            {
                // lblGender.Text = "F" + "/" + visitList[0].PatientAge.ToString();
            }
            // lblAge.Text = visitList[0].PatientAge.ToString();

        }


        invbl.getSampleCollectionforDepartment(RoleID, OrgID, visitID, ILocationID, out lstPatientInvestigation, out lstInvDeptMaster, out lstPatientInvSample, out lstOrderedSamples, out deptList);

        if (lstInvDeptMaster.Count > 0)
        {
            hDept.Value = lstInvDeptMaster[0].DeptID.ToString();
        }
        if (lstPatientInvSample.Count() > 0)
        {
            //dlInvName.DataSource = lstPatientInvestigation;
            //dlInvName.DataBind();

            dInves.Style.Add("display", "block");
            chkSelectAll.Checked = true;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "SelectAllSamples('" + chkSelectAll.ClientID + "');", true);
            tdbutsave2.Style.Add("display", "table-cell");
            //Load List of samples for corresponding visit With checkbox
            hdnStatusCtls.Value = "";
            hdnReasonCtls.Value = "";
            if (txtbarcodeno.Text != "")
            {
                var lst1 = from c in lstPatientInvSample
                           where c.BarcodeNumber == txtbarcodeno.Text
                           select c;
                repSampleCollect.DataSource = lst1;
                repSampleCollect.DataBind();
            }
            else
            {
                repSampleCollect.DataSource = lstPatientInvSample;
                repSampleCollect.DataBind();
            }
            int x = repSampleCollect.Items.Count;
            if (x == 0)
            {
                txtbarcodeno.Text = string.Empty;
                txtbarcodeno.Focus();
                tdbutsave2.Style.Add("display", "none");
                dInves.Style.Add("display", "none");
                grdRecSampleList.DataSource = null;
                grdRecSampleList.DataBind();
            }
            lblStatus.Visible = false;
            OrderedSamples1.LoadSamples(lstPatientInvestigation);
            SampleCollectedVisit1.LoadSamples(lstOrderedSamples, deptList);

            //Load list of samples for visit with department details
            //if (lstOrderedSamples.Count() > 0)
            //{
            //    dtSample.DataSource = lstOrderedSamples;
            //    dtSample.DataBind();
            //    pnlSampleList.Visible = true;
            //}

        }
        else
        {
            string strNoRecord = Resources.Lab_ClientDisplay.Lab_DeptSamplesCollection_aspx_06 == null ? "No Matching Records Found!" : Resources.Lab_ClientDisplay.Lab_DeptSamplesCollection_aspx_06;
            dInves.Style.Add("display", "none");
            lblStatus.Visible = true;
            //pnlSampleList.Visible = false;
            lblStatus.Text = strNoRecord.Trim();
            txtSearchTxt.Text = string.Empty;
            txtSearchTxt.Focus();
        }
    }
    long InsertPatient()
    {
        //venkat
        long returnCode;
        Patient patient;
        PatientAddress PatAddressDetails;
        PatientVisit VisitDetails;
        //Suresh
        Patientdetails(out returnCode, out patient, out PatAddressDetails, out VisitDetails);

        long pVisitID = 0;
        long PatientID = 0;

        //PatientVisit ePatientVisit = new PatientVisit();
        List<VisitClientMapping> lst = new List<VisitClientMapping>();
        returnCode = new Patient_BL(base.ContextInfo).SaveSampleRegistrationDetails(patient, PatAddressDetails, VisitDetails,
            out pVisitID, ILocationID, out PatientID, 0, "", 0, "", lst);
        getInvestigationEntry(pVisitID);

        return pVisitID;
    }
    long InsertExternalVist(long PatientIDs)
    {


        long pVisitID = 0;
        Role roleName = new Role();
        long PatientID = -1;
        PatientID = PatientIDs;
        long OrgAddressID = -1;
        List<Role> lRole = new List<Role>();
        long returnCode;
        Patient patient;
        PatientAddress PatAddressDetails;
        PatientVisit VisitDetails;
        List<OrganizationAddress> lAddress = new List<OrganizationAddress>();
        List<Patient> lPatient = new List<Patient>();
        Patientdetails(out returnCode, out patient, out PatAddressDetails, out VisitDetails);
        int OrgID = patient.OrgID;
        long ExVisitCount = -1;
        //returnCode = new Patient_BL(base.ContextInfo).UpdatePatientDetailsForIntegration(patient, PatAddressDetails);

        if (returnCode == -1) { throw new Exception("UpdatePatientDetailsForIntegration"); }

        List<PatientVisit> ExVisitDetails = new List<PatientVisit>();
        returnCode = new IntegrationDAL(base.ContextInfo).GetDetailsForExtVisitID(VisitDetails, out ExVisitDetails, out ExVisitCount);
        if (returnCode == -1) { throw new Exception("GetDetailsForExtVisitID"); }
        //PatientID = lPatient[0].PatientID;
        if (ExVisitDetails.Count == 0)
        {
            //PatientID = lPatient[0].PatientID;
            VisitDetails.PatientID = PatientID;
            VisitDetails.OrgAddressID = ILocationID;
            VisitDetails.OrgID = OrgID;


            returnCode = new Patient_DAL(base.ContextInfo).SaveLabVisitDetails(VisitDetails, out pVisitID);
            if (returnCode == -1) { throw new Exception("SaveLabVisitDetails"); }
            getInvestigationEntry(pVisitID);
          //  returnCode = new Investigation_BL(base.ContextInfo).InsertCommercialsForOrgtransfer(pVisitID, OrgID);

            //List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
            //dtinvs = GetOrdInvDataTable(GetInvManipulatedlist(InvestigationDetails, pVisitID, OrgID, GUID));
            //returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigation(InvestigationDetails, OrgID, pVisitID, GUID);

            //returnCode = new Investigation_DAL().SaveOrderedInvestigation(dtinvs, OrgID);
            //if (returnCode == -1) { throw new Exception("SaveOrderedInvestigation"); }

        }
        else
        {
            //pVisitID = Convert.ToInt64(hdnVisit.Value);
            pVisitID = ExVisitDetails[0].PatientVisitId;
            getInvestigationEntry(pVisitID);
            //returnCode = new Investigation_BL(base.ContextInfo).InsertCommercialsForOrgtransfer(pVisitID, OrgID);
        }
        return pVisitID;

        //else
        //{
        //    //List<PatientInvestigation> InvDetails = new List<PatientInvestigation>();
        //    //returnCode = new IntegrationDAL().UpdateVisitDetails(VisitDetails);
        //    //if (returnCode == -1) { throw new Exception("UpdateVisitDetails"); }
        //    //dtinvs = GetOrdInvDataTable(GetInvManipulatedlist(InvestigationDetails, ExVisitDetails[0].PatientVisitId, OrgID, GUID));

        //    //returnCode = new Investigation_DAL().GetPatInvDetailsForVisit(dtinvs, ExVisitDetails[0].PatientVisitId, OrgID, out InvDetails, out RowsAffected);
        //    //if (returnCode == -1) { throw new Exception("GetPatInvDetailsForVisit"); }
        //    //pVisitID = ExVisitDetails[0].PatientVisitId;
        //    //getInvestigationEntry(pVisitID);
        //}

    }
    private void LoadReceiveSampleList(EventArgs e, int currentPageNo, int PageSize)
    {
        //loadOrederedList(Convert.ToInt32(txtSearchTxt.Text));

        List<PatientVisitDetails> lPatientVisitDetails = new List<PatientVisitDetails>();
        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
        PatientVisitDetails filterList = new PatientVisitDetails();
        //List<PatientVisitDetails> lVisitDetails = new List<PatientVisitDetails>();
        long returnCode = -1;
        string visitid = string.Empty;
        string patientname = string.Empty;
        /* BEGIN | NA | Sabari | 20190515 | Created | MRNNumberSearch */
        string patientnumber = string.Empty;
        /* END | NA | Sabari | 20190515 | Created | MRNNumberSearch */
        int visittype = -1;
        int priority = -1;
        string fromdate = string.Empty;
        string todate = string.Empty;
        string sourcename = string.Empty;
        string InvestigationName = string.Empty;
        long InvestigationID = -1;
        string InvestigationType = string.Empty;
        string refPhyName = string.Empty;
        long refPhyID = -1;
        long refPhyOrg = -1;
        int CollectedLocationID = -1;
        string BarcodeNo = string.Empty;
        //DateTime fDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        //DateTime tDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        //if (txtFrom.Text != "" && txtTo.Text != "")
        //{
        //    fDate = Convert.ToDateTime(txtFrom.Text);
        //    tDate = Convert.ToDateTime(txtTo.Text);
        //}

        if (hdnClickEvent.Value == "Yes")
        {

            if (txtVisitID.Text.Trim() == defaultText.Trim())
            {
                txtVisitID.Text = "";
            }

            if (txtVisitID.Text != "")
            {
                visitid = txtVisitID.Text.Trim();
            }

            if (txtPatientName.Text != "")
            {
                patientname = txtPatientName.Text.Trim();
            }
            /* BEGIN | NA | Sabari | 20190515 | Created | MRNNumberSearch */
            if (txtPatientNumber.Text != "")
            {
                patientnumber = txtPatientNumber.Text.Trim();
            }
            /* END | NA | Sabari | 20190515 | Created | MRNNumberSearch */
            if (ddVisitType.SelectedValue != "-1")
            {
                visittype = Convert.ToInt32(ddVisitType.SelectedValue);
            }

            if (ddlPriority.SelectedValue != "-1")
            {
                priority = Convert.ToInt32(ddlPriority.SelectedValue);
            }

            if (ddlPriority.SelectedValue != "-1")
            {
                priority = Convert.ToInt32(ddlPriority.SelectedValue);
            }

            if (txtFrom.Text != "" && txtTo.Text != "")
            {
                if (txtFrom.Text == txtTo.Text)
                {
                    fromdate = Convert.ToString(Convert.ToDateTime(txtFrom.Text));
                    todate = Convert.ToString(Convert.ToDateTime(txtFrom.Text));

                    //fromDate = txtFrom.Text; ;
                    //toDate = Convert.ToDateTime(fromDate).AddDays(1).ToString("dd/MM/yyyy");
                }
                else
                {
                    fromdate = Convert.ToString(Convert.ToDateTime(txtFrom.Text));
                    todate = Convert.ToString(Convert.ToDateTime(txtTo.Text));
                    //fromDate = txtFrom.Text;
                    //toDate = txtTo.Text;
                }
            }
            else
            {
                fromdate = string.Empty;
                todate = string.Empty;
            }

            if (ddClientName.SelectedValue != "-1")
            {
                sourcename = ddClientName.SelectedValue.ToString();

            }
            if (txtTestName.Text != "" && hdnTestID.Value != "0")
            {
                InvestigationName = hdnTestName.Value;
                InvestigationID = Convert.ToInt64(hdnTestID.Value);
                InvestigationType = hdnTestType.Value;
            }

            if (txtRefDrName.Text != "" && hdnRefPhyID.Value != "0")
            {
                refPhyName = hdnRefPhyName.Value;
                refPhyID = Convert.ToInt64(hdnRefPhyID.Value);
                refPhyOrg = Convert.ToInt32(hdnRefPhyOrg.Value);
            }

            if (ddlLocation.SelectedValue != "-1")
            {
                CollectedLocationID = Convert.ToInt32(ddlLocation.SelectedValue);
            }

            if (txtbarcodeno.Text != "")
            {
                BarcodeNo = txtbarcodeno.Text.ToString();
            }

        }
        /* BEGIN | NA | Sabari | 20190515 | Created | MRNNumberSearch */

        invbl.GetReceiveSampleList(OrgID, ILocationID, CollectedLocationID, visitid, patientname, visittype, priority, fromdate, todate, sourcename, InvestigationName, InvestigationID, InvestigationType, refPhyName, refPhyID, refPhyOrg, BarcodeNo, out lPatientVisitDetails, PageSize, currentPageNo, out totalRows,patientnumber);
        /* END | NA | Sabari | 20190515 | Created | MRNNumberSearch */
        if (lPatientVisitDetails.Count > 0)
        {
            GrdFooter.Style.Add("display", "table-row");
            ACXresponsessmp1.Style.Add("dispaly", "table-row");
            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();
            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = currentPageNo.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                currentPageNo = Convert.ToInt32(hdnCurrent.Value);
            }
            if (currentPageNo == 1)
            {
                btnPrevious.Enabled = false;
                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    btnNext.Enabled = true;
                }
                else
                    btnNext.Enabled = false;
            }
            else
            {
                btnPrevious.Enabled = true;
                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    btnNext.Enabled = false;
                else btnNext.Enabled = true;
            }
        }
        else
        {
            GrdFooter.Style.Add("display", "none");
            ACXresponsessmp1.Style.Add("dispaly", "none");
        }

        //Below Line is commented by mohan , since we handle the visitid search in the above method
        //if (txtSearchTxt.Text != string.Empty)
        //{
        //    if (lPatientVisitDetails.Count > 0)
        //    {

        //        lPatientVisitDetails = lPatientVisitDetails.Where(O => O.ExternalVisitID == txtSearchTxt.Text).ToList();
        //        //lPatientVisitDetails = new List<PatientVisitDetails>();
        //        //lPatientVisitDetails.Add(filterList);
        //    }
        //}
        grdRecSampleList.DataSource = lPatientVisitDetails;
        grdRecSampleList.DataBind();
        pnlSerch.Enabled = true;
        hdnCurrent.Value = "";
        //}
    }
    private void Patientdetails(out long returnCode, out Patient patient, out PatientAddress PatAddressDetails, out PatientVisit VisitDetails)
    {
        returnCode = -1;
        List<Patient> lpat = new List<Patient>();
        returnCode = new Patient_BL(base.ContextInfo).GetLabPatientDemoandAddress(Convert.ToInt64(hdnPatID.Value), out lpat);
        patient = new Patient();
        patient.Name = lpat[0].Name;
        patient.Age = lpat[0].PatientAge;
        patient.OrgID = OrgID;
        patient.SEX = lpat[0].SEX;
        patient.TITLECode = lpat[0].TITLECode;
        patient.Nationality = lpat[0].Nationality;
        patient.DOB = lpat[0].DOB;
        patient.PatientNumber = lpat[0].PatientNumber;
        patient.TPAAttributes = "";
        patient.TPAName = "";
        patient.TypeName = "";
        patient.EMail = lpat[0].EMail;
        PatAddressDetails = new PatientAddress();
        PatAddressDetails.PatientID = lpat[0].PatientAddress[0].PatientID;
        PatAddressDetails.Add1 = lpat[0].PatientAddress[0].Add1;
        PatAddressDetails.Add2 = lpat[0].PatientAddress[0].Add2;
        PatAddressDetails.Add3 = lpat[0].PatientAddress[0].Add3;
        PatAddressDetails.AddressType = lpat[0].PatientAddress[0].AddressType;
        PatAddressDetails.MobileNumber = lpat[0].PatientAddress[0].MobileNumber;
        PatAddressDetails.LandLineNumber = lpat[0].PatientAddress[0].LandLineNumber;
        PatAddressDetails.City = lpat[0].PatientAddress[0].City;
        PatAddressDetails.StateID = lpat[0].PatientAddress[0].StateID;
        PatAddressDetails.StateName = lpat[0].PatientAddress[0].StateName;
        PatAddressDetails.CountryID = lpat[0].PatientAddress[0].CountryID;
        PatAddressDetails.CountryName = lpat[0].PatientAddress[0].CountryName;

        List<PatientVisit> lPatientVisitdet = new List<PatientVisit>();
        returnCode = new Patient_BL(base.ContextInfo).GetLabVisitDetails(Convert.ToInt64(hdnVisit.Value), OrgID, out lPatientVisitdet);

        VisitDetails = new PatientVisit();
        VisitDetails.PriorityID = lPatientVisitdet[0].PriorityID;
        VisitDetails.ClientMappingDetailsID = lPatientVisitdet[0].ClientMappingDetailsID;
        //VisitDetails.ReferingPhysicianID = lPatientVisitdet[0].ReferingPhysicianID;
        VisitDetails.ReferingPhysicianName = lPatientVisitdet[0].ReferingPhysicianName;
        VisitDetails.HospitalID = lPatientVisitdet[0].HospitalID;
        VisitDetails.HospitalName = String.IsNullOrEmpty(lPatientVisitdet[0].HospitalName) ? String.Empty : lPatientVisitdet[0].HospitalName;
        //VisitDetails.ClientMappingDetailsID = -1; //lPatientVisitdet[0].ClientID;
        //VisitDetails.ClientName = lPatientVisitdet[0].ClientName;
        VisitDetails.CollectionCentreID = lPatientVisitdet[0].CollectionCentreID;
        VisitDetails.CollectionCentreName = "";
        VisitDetails.ExternalVisitID = lPatientVisitdet[0].ExternalVisitID;
        VisitDetails.VisitType = lPatientVisitdet[0].VisitType;
        VisitDetails.OrgID = OrgID;
        VisitDetails.OrgAddressID = lPatientVisitdet[0].CollectionCentreID;
        VisitDetails.ReferVisitID = Convert.ToInt64(hdnVisit.Value);
    }
    void getInvestigationEntry(long pVisitID)
    {
        List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();

        List<OrderedInvestigations> ordInvestigation = new List<OrderedInvestigations>();
        List<OrderedInvestigations> orderedInves = new List<OrderedInvestigations>();

        //List<OrderedInvestigations> lstorderInv = new List<OrderedInvestigations>();

        new Investigation_BL(base.ContextInfo).GetInvestigationForVisit(Convert.ToInt64(hdnVisit.Value), OrgID, ILocationID, out orderedInves);
        ordInvestigation = orderedInves.FindAll(P => P.ResCaptureLoc == ILocationID && P.Status == "SampleTransferred" && P.OrgID != OrgID);
        if (ordInvestigation.Count > 0)
        {
            string gUID = System.Guid.NewGuid().ToString();
            foreach (OrderedInvestigations invs in ordInvestigation)
            {
                OrderedInvestigations objInvest = new OrderedInvestigations();
                objInvest.ID = invs.InvestigationID;
                objInvest.Name = invs.InvestigationName;
                objInvest.VisitID = pVisitID;
                objInvest.Status = "SampleTransferred";
                objInvest.PaymentStatus = "paid";
                objInvest.CreatedBy = LID;
                objInvest.Type = invs.Type;
                objInvest.OrgID = OrgID;
                objInvest.UID = gUID;
                objInvest.ReferralID = invs.AccessionNumber;
                objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                objInvest.ReferedToLocation = ILocationID;
                objInvest.ReportDateTime = invs.ReportDateTime;
                objInvest.TatDateTime = invs.TatDateTime;
                objInvest.IsStat = invs.IsStat;
                ordInves.Add(objInvest);
            }
            returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigation(ordInves, OrgID);
            ctlCollectSample.ExtractInvestigations(pVisitID, gUID);
        }
    }
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

    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "VisitType,Labpriority";
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
                                 where child.Domain == "VisitType"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddVisitType.DataSource = childItems;
                    ddVisitType.DataTextField = "DisplayText";
                    ddVisitType.DataValueField = "Code";
                    ddVisitType.DataBind();
                    ddVisitType.Items.Remove((ddVisitType.Items.FindByValue("-1")));
                    ListItem li = new ListItem();
                    li.Text = strSelect;
                    li.Value = "-1";
                    ddVisitType.Items.Insert(0, li);
                }

                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "Labpriority"
                                  select child;

                if (childItems1.Count() > 0)
                {
                    ddlPriority.DataSource = childItems1;
                    ddlPriority.DataTextField = "DisplayText";
                    ddlPriority.DataValueField = "Code";
                    ddlPriority.DataBind();
                    ddlPriority.Items.Remove((ddlPriority.Items.FindByValue("1")));
                    ListItem li = new ListItem();
                    li.Text = strSelect;
                    li.Value = "-1";
                    ddlPriority.Items.Insert(0, li); 
                    //ddlPriority.SelectedValue = "M";
                }

    




            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    #endregion
    
  
    
}
