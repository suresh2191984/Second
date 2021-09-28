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

public partial class Lab_TriSampleCollection : BasePage
{
    public Lab_TriSampleCollection()
        : base("Lab_TransferSampleCollection_aspx")
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
    long returnCode = -1;
    int CollLocID = -1;
    List<OrganizationAddress> Location;
    List<InvSampleStatusmaster> lstInvSampleStatus = new List<InvSampleStatusmaster>();
    static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    List<PatientInvSample> lstpinvsample;
    List<InvestigationStatus> lstInvestigationStatus;
    List<LabReferenceOrg> lstLabReferenceOrg;
    #region "Initial"

    /// <summary>
    /// Page_Load
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    string strSelect = Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_01 == null ? "---Select---" : Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_01;
    string IsNeedExternalVisitId = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                lstInvestigationStatus = new List<InvestigationStatus>();
                lstLabReferenceOrg = new List<LabReferenceOrg>();
                returnCode = new Investigation_BL(base.ContextInfo).GetTransferInvestionStatus(OrgID, out lstInvestigationStatus, out lstLabReferenceOrg);
               
                ddlSampleStatus.DataSource = lstInvestigationStatus;
                ddlSampleStatus.DataTextField = "DisplayText";
                ddlSampleStatus.DataValueField = "InvestigationStatusID";
                ddlSampleStatus.DataBind();
                ddlSampleStatus.Items.Insert(0, strSelect.Trim());
                ddlSampleStatus.Items[0].Value = "-1";
                ddlSampleStatus.SelectedValue = "0";
                if (Request.QueryString["Flag"] == "Y")
                {
                    ddlSampleStatus.SelectedValue = "0";
                }
                else
                {
                    if (ddlSampleStatus.Items.Contains(ddlSampleStatus.Items.FindByText("SampleReceived")))
                    {
                        ddlSampleStatus.Items.Remove(ddlSampleStatus.Items.FindByText("SampleReceived"));
                    }
                }

                txtFrom.Text = DateTime.Today.AddDays(-1).ToString("dd/MM/yyyy");
                txtTo.Text = OrgTimeZone;
                hdnDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(2).ToString("dd/MM/yyyy hh:mm tt");
                txttranDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(2).ToString("dd/MM/yyyy hh:mm tt");
                pnlSampleList.Visible = false;
                pnlFooter.Visible = false;

                LoadMetaData();
                LoadLocation();
                LoadSourceNameTrustedOrg();
                AutoCompleteExtender1.ContextKey = OrgID.ToString();
                AutoCompleteExtender2.ContextKey = OrgID.ToString();
                AutoCompleteExtender3.ContextKey = OrgID.ToString();
                AutoCompleteExtender5.ContextKey = OrgID.ToString();
                AutoCompleteExtendercon.ContextKey = OrgID.ToString();

                if (CID > 0)
                {
                    hdnClientID.Value = Convert.ToString(CID);
                    txtClientName.Text = UserName;
                    txtClientName.Attributes.Add("disabled", "true");
                }
                else
                {
                    hdnClientID.Value = "";
                    txtClientName.Text = "";
                    txtClientName.Attributes.Remove("disabled");
                }
                hdnLocationID.Value = ILocationID.ToString();
                LoadGrid(e, currentPageNo, PageSize);
                IsNeedExternalVisitId = GetConfigValue("ExternalVisitSearch", OrgID);
                if (IsNeedExternalVisitId == "Y")
                {
                    grdSample.Columns[2].Visible = false;
                }
                else
                {
                    grdSample.Columns[2].Visible = false;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing InvestigationSample page", ex);
        }
    }
    #endregion

    #region "Events"
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnGo1_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
    }
    protected void grdResult_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item)
        {
            DropDownList ddlSampleStatus = e.Item.FindControl("lblstatusID") as DropDownList;
            ddlSampleStatus.SelectedValue = ((PatientInvSample)e.Item.DataItem).InvSampleStatusID.ToString();
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["Flag"] == "Y")
            {
                action.Style.Add("display", "table-row");
                trtransloc.Style.Add("display", "table-row");
            }
            else
            {
                action.Style.Add("display", "none");
                trtransloc.Style.Add("display", "none");
            }

            dInves.Style.Add("display", "block");
            hdnCurrent.Value = "";
            LoadGrid(e, currentPageNo, PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in sample search: ", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Error in sample search, Please contact system administrator.";
        }
    }
    protected void grdSample_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                grdSample.PageIndex = e.NewPageIndex;
                currentPageNo = e.NewPageIndex;
                LoadGrid(e, currentPageNo, PageSize);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in PendingSampleCollection grdSample_PageIndexChanging()", ex);
        }
    }

    /// <summary>
    /// btnOK_Click
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    string alert = Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_alert == null ? "Alert" : Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_alert;
    string strEncounterProblem = Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_02 == null ? "We encounter following problems in sample transfer:" : Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_02;
    string strVid = Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_03 == null ? "VID --" : Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_03;
    string strTestName = Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_04 == null ? "Test Name --" : Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_04;
    string strReason = Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_05 == null ? "Reason --" : Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_05;
    string strSampleTransfer = Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_06 == null ? "Sample Transferred Successfully!" : Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_06;
    protected void btnOK_Click(object sender, EventArgs e)
    {
        string strPatientVisitId = string.Empty;
        string strSampleId = string.Empty;
        string strGuid = string.Empty;
        string strSampleStatusID = string.Empty;
        string strTaskID = string.Empty;
        DateTime Transferdate;
        long InvestigationID = -1;
        long returncode = -1;
        lstpinvsample = new List<PatientInvSample>();
        List<CollectedSample> lstpinvsampleVisits = new List<CollectedSample>();
        foreach (GridViewRow item in grdSample.Rows)
        {
            // RadioButton rbselect1 = (RadioButton)item.FindControl("rbSelect");
            CheckBox chkselect = (CheckBox)item.FindControl("chkselect");
            if (chkselect.Checked)
            {
                HiddenField hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                HiddenField hfSampleId = (HiddenField)item.FindControl("hdnSampleId");
                HiddenField hfGuid = (HiddenField)item.FindControl("hdnGuid");
                HiddenField hfSampleStatusId = (HiddenField)item.FindControl("hdnInvSampleStatusID");
                HiddenField hfTaskID = (HiddenField)item.FindControl("hdnTaskID");
                HiddenField hdnCollocationID = (HiddenField)item.FindControl("hdnCollocationID");
                HiddenField hdninvID = (HiddenField)item.FindControl("hdninvID");
                HiddenField hdntype = (HiddenField)item.FindControl("hdntype");
                //added by sudhakar lbladdrid
                Label lblAddrID = (Label)item.FindControl("sampleAddressID");

                if (txttranDate.Text != null)
                {
                    Transferdate = Convert.ToDateTime(txttranDate.Text);
                }
                else
                {
                    Transferdate = Convert.ToDateTime(txttranDate.Text);
                }

                PatientInvSample pinvs = new PatientInvSample();
                strPatientVisitId = hfVisitId.Value;
                strSampleId = hfSampleId.Value;
                strGuid = hfGuid.Value;
                strSampleStatusID = hfSampleStatusId.Value;
                strTaskID = hfTaskID.Value;

                //added by sudhakar
                if (Request.QueryString["Flag"] == "Y")
                {
                    CollLocID = Convert.ToInt32(ddltransferloc.SelectedItem.Value);
                }
                else
                {
                    CollLocID = Convert.ToInt32(lblAddrID.Text);
                }

                InvestigationID = Convert.ToInt64(hdninvID.Value);
                pinvs.PatientVisitID = Convert.ToInt32(strPatientVisitId);
                pinvs.SampleID = Convert.ToInt32(strSampleId);
                pinvs.RecSampleLocID = CollLocID;
                pinvs.OrgID = OrgID;
                pinvs.ModifiedBy = LID;
                pinvs.CreatedAt = Transferdate;
                pinvs.UID = strGuid;
                pinvs.INVID = InvestigationID;
                pinvs.Type = hdntype.Value;
                pinvs.isinte = 1;
                lstpinvsample.Add(pinvs);
            }
        }
        returncode = new Investigation_BL(base.ContextInfo).CheckIsValidtoTransfer(lstpinvsample, out lstpinvsampleVisits);
        if (lstpinvsampleVisits.Count > 0)
        {
            string errorMessage = string.Empty;
            foreach (CollectedSample collectSample in lstpinvsampleVisits)
            {
                if (errorMessage == string.Empty)
                {
                    errorMessage = "" + strEncounterProblem.Trim() + "\\n\\n";
                }
                errorMessage += "" + strVid.Trim() + " " + collectSample.VisitNumber + "\\n";
                errorMessage += "" + strTestName.Trim() + " " + collectSample.InvestigationName + "\\n";
                errorMessage += "" + strReason.Trim() + " " + collectSample.Reason + "\\n\\n";
            }
            errorMessage = errorMessage.Replace("'", "");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "AlertBlock", "javascript:alert('" + errorMessage + "');", true);
        }
        if (lstpinvsampleVisits.Count == 0)
        {
            returncode = new Investigation_BL(base.ContextInfo).UpdateoneSampleTransfer(lstpinvsample);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "select1", "javascript:ValidationWindow('" + strSampleTransfer.Trim() + "','"+alert+"');", true);
            dInves.Style.Add("display", "none");
            
              ////Pget Performing Action starts

            long patientVisitID = lstpinvsample[0].PatientVisitID;            
                ActionManager AM = new ActionManager(base.ContextInfo);
                List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                PageContextkey PC = new PageContextkey();
                PC.RoleID = Convert.ToInt64(RoleID);
                PC.OrgID = OrgID;
                PC.PageID = 543;
                PC.ButtonName = "btnOK";
                PC.ButtonValue = "Transfer Sample";
                PC.ActionType = "LISOrdered";
                PC.PatientID = 0;
                PC.PatientVisitID = patientVisitID;
                lstpagecontextkeys.Add(PC);
                long res = -1;
                res = AM.PerformingNextStepNotification(PC, "", "");

            ////Pget Performing Action End
        }
    }
    protected void grdSample_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (HdnCheckBoxId.Value == "")
            {
                if (((CheckBox)e.Row.FindControl("chkselect")).Enabled == true)
                {

                    HdnCheckBoxId.Value = ((CheckBox)e.Row.FindControl("chkselect")).ClientID;
                }
            }
            else
            {
                if (((CheckBox)e.Row.FindControl("chkselect")).Enabled == true)
                {
                    HdnCheckBoxId.Value += '~' + ((CheckBox)e.Row.FindControl("chkselect")).ClientID;
                }
            }
            CollectedSample lstCollectedSample = (CollectedSample)e.Row.DataItem;
            if (lstCollectedSample.RefOrgName == "Y")
            {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#EEB4B4");
            }
            e.Row.Cells[12].Text = ddltransferloc.SelectedItem.Text;
        }
    }

    #endregion




    #region "Methods"

    string strSelects = Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_07 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_07;
    private void LoadLocation()
    {

        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        List<OrganizationAddress> ProcessedAt = new List<OrganizationAddress>();
        List<OrganizationAddress> TransferLoc = new List<OrganizationAddress>();
        returnCode = new Referrals_BL(base.ContextInfo).GetoneALLProcessingLocation(OrgID, out lstLocation);

        if (lstLocation.Count > 0)
        {
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();

            ddltransferloc.DataSource = lstLocation;
            ddltransferloc.DataTextField = "Location";
            ddltransferloc.DataValueField = "AddressID";
            ddltransferloc.DataBind();
            //added by sudhakar//
            if (Request.QueryString["Flag"] == "Y")
            {
                ddltransferloc.Items.Insert(0, strSelects.Trim());
                ddltransferloc.Items[0].Value = "-1";
            }

            var s = lstLocation.FindAll(p => p.OrgID == OrgID);

            ddlprocessedlocation.DataSource = lstLocation;
            ddlprocessedlocation.DataTextField = "Location";
            ddlprocessedlocation.DataValueField = "AddressID";
            ddlprocessedlocation.DataBind();
            if (lstLocation.Count == 1)
            {
                ddlLocation.Items.Insert(0, strSelects.Trim());
                ddlLocation.Items[0].Value = "-1";

                //ddltransferloc.Items.Insert(0, "------SELECT------");
                //ddltransferloc.Items[0].Value = "-1";

                ddlprocessedlocation.Items.Insert(0, strSelects.Trim());
                ddlprocessedlocation.Items[0].Value = "-1";
            }
            else if (lstLocation.Count == 0 || lstLocation.Count > 1)
            {
                ddlLocation.Items.Insert(0, strSelects.Trim());
                ddlLocation.Items[0].Value = "-1";

                //ddltransferloc.Items.Insert(0, "------SELECT------");
                //ddltransferloc.Items[0].Value = "-1";


                //added by sudhakar//
                if (Request.QueryString["Flag"] == "Y")
                {
                    ddltransferloc.SelectedValue = "-1";
                }


                //ddltransferloc.SelectedValue = s[0].ToString();

                ddlprocessedlocation.Items.Insert(0, strSelects.Trim());
                ddlprocessedlocation.Items[0].Value = "-1";
            }
        }
    }

    public void LoadSourceNameTrustedOrg()
    {
        try
        {
            string pType = "OUT";
            long returnCode = -1;
            Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
            List<InvClientMaster> lstSourceName = new List<InvClientMaster>();
            returnCode = objPatientBL.GetInvTransferClientMaster(OrgID, string.Empty, out lstSourceName);
            if (lstSourceName.Count > 0)
            {
                ddClientName.DataSource = lstSourceName;
                ddClientName.DataTextField = "ClientName";
                ddClientName.DataValueField = "ClientID";
                ddClientName.DataBind();
                ddClientName.Items.Insert(0, strSelects.Trim());
                ddClientName.Items[0].Value = "-1";
            }
            //List<OrganizationAddress> lstProcessingLocation = new List<OrganizationAddress>();
            //Investigation_BL oInvestigationBL = new Investigation_BL(base.ContextInfo);
            //oInvestigationBL.GetTestProcessingLocation(OrgID, pType, out lstProcessingLocation);
            if (lstLabReferenceOrg.Count > 0)
            {
                ddloutsource.DataSource = lstLabReferenceOrg;
                ddloutsource.DataTextField = "RefOrgName";
                ddloutsource.DataValueField = "LabRefOrgID";
                ddloutsource.DataBind();
                ddloutsource.Items.Insert(0, strSelects.Trim());
                ddloutsource.Items[0].Value = "-1";
            }
            else
            {
                ddloutsource.Items.Insert(0, strSelects.Trim());
                ddloutsource.Items[0].Value = "-1";
            }
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing LoadSourceName() in Lab_Home_page ", e);
        }
    }
    

    private void LoadGrid(EventArgs e, int currentPageNo, int PageSize)
    {
        //added by sudhakar//
        if (Request.QueryString["Flag"] == "Y")
        {
            ddltransferloc.SelectedValue = "-1";
        }


        ddloutsource.Style.Add("display", "none");
        List<CollectedSample> lstInvestigationSamples = new List<CollectedSample>();
        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
        long returnCode = -1;
        string visitid = string.Empty;
        string patientname = string.Empty;
        int visittype = -1;
        int priority = -1;
        string fromdate = string.Empty;
        string todate = string.Empty;
        string sourcename = string.Empty;
        string InvestigationName = string.Empty;
        long InvestigationID = -1;
        string SampleName = string.Empty;
        long SmID = -1;
        string InvestigationType = string.Empty;
        string refPhyName = string.Empty;
        long refPhyID = -1;
        long refPhyOrg = -1;
        int CollectedLocationID = -1;
        int ProcessedLocID = -1;
        int intSampleStatus = -1;
        int smpleID = -1;
        int outsourceID = -1;
        string BarcodeNo = string.Empty;
        int ContainerID = -1;
        int PlocationID = -1;
        //added by sudhakar returncode
        long returncode = -1;

        if (ddlSampleStatus.SelectedItem.Value != "All")
        {
            intSampleStatus = Convert.ToInt32(ddlSampleStatus.SelectedItem.Value);
        }
        else
        {
            intSampleStatus = -1;
        }
        if (ddlType.SelectedItem.Value == "1")
        {
            if (txtVisitID.Text != "")
            {
                visitid = txtVisitID.Text.Trim();
            }
        }
        else if (ddlType.SelectedItem.Value == "2")
        {
            if (txtVisitID.Text != "")
            {
                smpleID = Convert.ToInt32(txtVisitID.Text.Trim());
            }
        }
        else
        {
        }
        if (txtPatientName.Text != "")
        {
            patientname = txtPatientName.Text.Trim();
        }

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
            }
            else
            {
                fromdate = Convert.ToString(Convert.ToDateTime(txtFrom.Text));
                todate = Convert.ToString(Convert.ToDateTime(txtTo.Text));
            }
        }
        else
        {
            fromdate = string.Empty;
            todate = string.Empty;
        }

        //if (ddClientName.SelectedValue != "-1")
        //{
        //    sourcename = ddClientName.SelectedValue.ToString();

        //}
        if (txtClientName.Text != "" && hdnClientID.Value != "0")
        {
            sourcename = hdnClientID.Value;
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

        //if (ddlLocation.SelectedValue != "-1")
        //{
        //     CollectedLocationID = Convert.ToInt32(ddlLocation.SelectedValue);
        // }
        CollectedLocationID = ILocationID;
        // if (ddlprocessedlocation.SelectedItem.Value != "-1")
        // {
        ProcessedLocID = Convert.ToInt32(ddlstat.SelectedItem.Value);
        //  }
        if (ddloutsource.SelectedItem.Value != "-1")
        {
            outsourceID = Convert.ToInt32(ddloutsource.SelectedItem.Value);
        }
        if (TxtSampleName.Text != "" && hdnsampleID.Value != "0")
        {
            SampleName = hdnSampleName.Value;
            SmID = Convert.ToInt64(hdnSmpleID.Value);
        }


        if (txtbarcodeno.Text != "")
        {
            BarcodeNo = txtbarcodeno.Text;
        }

        if (txtcontname.Text != "" && hdncontID.Value != "0")
        {
            ContainerID = Convert.ToInt32(hdncontID.Value);
        }
        if (ddlLocation.SelectedValue != "-1")
        {
            PlocationID = Convert.ToInt32(ddlLocation.SelectedItem.Value);
        }
        //added by sudhakar
        Investigation_BL invbl1 = new Investigation_BL(base.ContextInfo);

        returncode = invbl1.GetInvoneSamplesTransferStatus(OrgID, txtFrom.Text, txtTo.Text, intSampleStatus, CollectedLocationID, "", visitid, patientname,
            visittype, priority, sourcename, InvestigationName, InvestigationID, InvestigationType, refPhyName, refPhyID, refPhyOrg,
           SmID, Convert.ToInt32(ddlType.SelectedItem.Value), out lstInvestigationSamples, PageSize, currentPageNo, out totalRows, smpleID, ProcessedLocID, outsourceID, BarcodeNo, ContainerID, PlocationID);
        if (lstInvestigationSamples.Count > 0)
        {
            GrdFooter.Style.Add("display", "table-row");
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
            GrdFooter.Style.Add("display", "none");
        if (lstInvestigationSamples.Count > 0)
        {
            int menuType = Convert.ToInt32(TaskHelper.SearchType.SampleTransfer);
            List<ActionMaster> lstActionMaster = new List<ActionMaster>();

            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, menuType, out lstActionMaster);
            if (lstActionMaster.Count > 0)
            {
                ddlAction.DataSource = lstActionMaster;
                ddlAction.DataTextField = "ActionName";
                ddlAction.DataValueField = "ActionCode";
                ddlAction.DataBind();
                //ddlAction.Items.Insert(0, new ListItem("--Select--", "0"));
                ddlAction.Visible = true;
                btnGo.Visible = true;
                pnlFooter.Visible = true;
            }
            else
            {
                pnlFooter.Visible = false;
            }
            lstActionsMaster = lstActionMaster.ToList();
            grdSample.DataSource = lstInvestigationSamples;
            grdSample.DataBind();
            pnlSampleList.Visible = true;
            lblStatus.Visible = false;
        }
        else
        {
            pnlSampleList.Visible = false;
            pnlFooter.Visible = false;
            lblStatus.Visible = true;
        }
        if (ddlSampleStatus.SelectedItem.Value == "8")
        {
            //ddloutsource.Style.Add("display", "block");

            ddloutsource.Style.Add("display", "block");
        }
        if (ddlSampleStatus.SelectedItem.Value == "6")
        {
            //ddlprocessedlocation.Style.Add("display", "block");
            ddlprocessedlocation.SelectedItem.Value = "-1";
        }
        //if (ddlLocation.SelectedValue.Equals("-1"))
        //{
        //    ddltransferloc.SelectedValue = "-1";
        //   // trtransloc.Style.Add("display", "block");
        //}
        //else
        //{
        //    ddltransferloc.SelectedValue = ddlLocation.SelectedValue;
        //    trtransloc.Style.Add("display", "none");
        //}
        trtransdate.Style.Add("display", "table-row");
        ddloutsource.SelectedItem.Value = "-1";
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);
        return totalPages;
    }
    
    
    
    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "VisitType,TraType,ISSTAT,Priority";
            string[] Tempdata = domains.Split(',');

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            string LangCode = "en-GB";
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "TraType"
                                 select child;
                ddlType.DataSource = childItems;
                ddlType.DataTextField = "DisplayText";
                ddlType.DataValueField = "Code";
                ddlType.DataBind();
                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "VisitType"
                                  select child;

                ddVisitType.DataSource = childItems2;
                ddVisitType.DataTextField = "DisplayText";
                ddVisitType.DataValueField = "Code";
                ddVisitType.DataBind();
                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "ISSTAT"
                                  select child;
                ddlstat.DataSource = childItems3;
                ddlstat.DataTextField = "DisplayText";
                ddlstat.DataValueField = "Code";
                ddlstat.DataBind();
                ddlstat.SelectedValue = "-1";
                var childItems4 = from child in lstmetadataOutput
                                  where child.Domain == "Priority"
                                  orderby child.DisplayText ascending
                                  select child;
                if (childItems3.Count() > 0)
                {
                    ddlPriority.DataSource = childItems4;
                    ddlPriority.DataTextField = "DisplayText";
                    ddlPriority.DataValueField = "Code";
                    ddlPriority.DataBind();
                    ddlPriority.Items.Remove((ddlPriority.Items.FindByValue("1")));
                    ListItem li = new ListItem();
                    li.Text = strSelect;
                    li.Value = "-1";
                    ddlPriority.Items.Insert(0, li);  
                }
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
            //edisp.Visible = true;
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    #endregion
}

