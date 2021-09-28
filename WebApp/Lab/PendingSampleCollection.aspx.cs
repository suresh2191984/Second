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
using Attune.Podium.ExcelExportManager;
using Attune.Podium.PerformingNextAction;
using System.Web.Script.Serialization;

public partial class Lab_PendingSampleCollection : BasePage
{
    string AlertType = Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_01 == null ? "Alert" : Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_01;
    int startRowIndex = 1;
    int _pageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    int intRegLocation = -1;
    string slidebarcode = string.Empty;
    string samples = string.Empty;
    string slidevalues = string.Empty;
    string ddlactionvalue = string.Empty;
    DateTime NewCollectedDateTime;
    //added by sudha from lal
    string defaultText = string.Empty;
    string ExternalVisitSearch = string.Empty;
	    string IsNeedExternalVisitIdWaterMark = string.Empty;
    //ended by sudha
    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }

    public Lab_PendingSampleCollection()
        : base("Lab_PendingSampleCollection_aspx")
    {
    }
    List<LabReferenceOrg> lstLabRefOrg = new List<LabReferenceOrg>();
    string strSelects = Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_02 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_02;
    String AlertMsg = "";
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<InvSampleStatusmaster> lstInvSampleStatus = new List<InvSampleStatusmaster>();
    long returnCode = -1;
    static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    #region "Initial"
    string strSelect = Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_03 == null ? "--Select--" : Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_03;
    string strAll = Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_01 == null ? "All" : Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_01;

    //added by sudha from lal
    string strLabNo = Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_04 == null ? "Lab Number" : Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_04;
    string strVisitNo = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_11 == null ? "Visit Number" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_11;
    //ended by sudha from lal

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (OrgID == 71)
            {
                _pageSize = 8;
            }
            else
            {
                _pageSize = 10;
            }
            iframeBarcode.Attributes.Remove("src");
            if (!IsPostBack)
            {
                ddlReason.Style.Add("display", "none");
                Label8.Style.Add("display", "none");
                ddloutlocation.Style.Add("display", "none");
                CheckBox_Slide.Style.Add("display", "none");
                returnCode = new Investigation_BL(base.ContextInfo).GetInvStatus(OrgID, "AbberantSample", out lstInvSampleStatus);
                ddlSampleStatus.DataSource = lstInvSampleStatus;
                ddlSampleStatus.DataTextField = "InvSampleStatusDesc";
                ddlSampleStatus.DataValueField = "InvSampleStatusID";
                ddlSampleStatus.DataBind();
                //ddlSampleStatus.Items.Insert(0, "-----Select-----");
                ddlSampleStatus.Items.Insert(0, strSelect.Trim());
                hdnOrgID.Value = OrgID.ToString();

            hdnSampleStatus.Value = "";
            foreach (InvSampleStatusmaster ss in lstInvSampleStatus)
            {
                if (GetConfigValue(RoleID.ToString() + "_IsAbberantFilter", OrgID) == "Y")
                {
                    if (ss.InvSampleStatusID == 12)
                    {
                        hdnSampleStatus.Value += ss.InvSampleStatusDesc.ToString() + '~' + ss.InvSampleStatusID.ToString() + "^";
                    }

                }
                else
                {
                    hdnSampleStatus.Value += ss.InvSampleStatusDesc.ToString() + '~' + ss.InvSampleStatusID.ToString() + "^";
                }
                //hdnSampleStatus.Value += ss.InvSampleStatusDesc.ToString() + '~' + ss.InvSampleStatusID.ToString() + "^";

            }
            hdnSampleStatus.Value += "All" + '~' + "0" + "^";
               
                if (Request.QueryString["SStatus"] != null)
                {
                    LoadSampleFromHomePage();
                }
                else
                {
                    txtFrom.Text = DateTime.Today.AddDays(-1).ToString("dd/MM/yyyy");
                    txtTo.Text = OrgTimeZone;
                    pnlSampleList.Visible = false;
                    pnlFooter.Visible = false;
                }
                RdoSendOutSource.Checked = true;
                LoadInvSampleMaster();
                LoadLocation();
                LoadSourceNameTrustedOrg();
                LoadMeatData();
                AutoCompleteExtender1.ContextKey = OrgID.ToString();
                AutoCompleteExtender2.ContextKey = OrgID.ToString();
                AutoUsers.ContextKey = OrgID.ToString();
                LoadOutSourcedLocations(); 
              
                //Chkpkgout.Checked = true;

            }

            if (chkAberrant.Checked)
            {
                ddlSampleStatus.Enabled = true;
		if (ddlSampleStatus.SelectedValue == "12")
                {
                    ContextInfo.AdditionalInfo = "OutSource";
                }
                else
                {
                    ContextInfo.AdditionalInfo = "";
                }
            }
            else
            {
                ddlSampleStatus.Enabled = false;
            }
            slidebarcode = GetConfigValue("slidebarcode", OrgID);
            if (slidebarcode == "Y")
            {
                hdnslidebarcode.Value = "Y";
                linkBarcodeLayerGenerate.Visible = false;
                //btnOK.Text = "Slide Preparation";

            }
            else
            {
                hdnslidebarcode.Value = "N";

            }
            //added bu sudha from lal
          
                IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitSearch", OrgID);
                if (IsNeedExternalVisitIdWaterMark == "Y")
                {

                    defaultText = strLabNo.Trim();
                    txtVisitID.MaxLength = 12;
                }
                else
                {
                    defaultText = strVisitNo.Trim();
                }
                txtwatermark();

                //VEL | 25-July-2019 | Enble reprint barcode | Start 

                string IsEnableMultipleReprint = GetConfigValue("IsEnableMultipleReprint", OrgID);
                if (IsEnableMultipleReprint == "Y")
                    hdnEnableMultiplereprint.Value = "Y";

            //VEL | 25-July-2019 | Enble multiple reprint TRF | End

            //ended by sudha from lal
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing InvestigationSample page", ex);
        }
    }
    #endregion
    #region "Events"

    //added by sudha from lal
     public void txtwatermark()
	    {
	        if (txtVisitID.Text.Trim() != defaultText.Trim())
	        {
	            txtVisitID.Attributes.Add("style", "color:black");
	        }
	        if (txtVisitID.Text == "")
	        {
	            txtVisitID.Text = defaultText;
	            hdnvidtxt.Value = defaultText;
	            txtVisitID.Attributes.Add("style", "color:gray");
	        }
	        txtVisitID.Attributes.Add("onblur", "WaterMark(this,event,'" + defaultText + "');");
	        txtVisitID.Attributes.Add("onfocus", "WaterMark(this,event,'" + defaultText + "');");
	
	    }
    //ended by sudha from lal
    protected void grdOutSource_RowDataBound(object sender, GridViewRowEventArgs e)
    {
    }
    protected void Gvaliqoutbarcode_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Gvaliqoutbarcode.PageIndex = e.NewPageIndex;
        LoadAliqout(sender, e);


    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string BarcodeNumber = string.Empty;
            long VisitID;
            long SampleId;
            DateTime NewCollectedDateTime;
            SampleId = Convert.ToInt32(hdnsampleid.Value);
            NewCollectedDateTime = Convert.ToDateTime(txtNewCollectTime.Text);
            VisitID = Convert.ToInt32(hdnVisitId1.Value);
            long returncode = -1;
            Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
            foreach (GridViewRow item in grdSample.Rows)
            {
                CheckBox ChkbxSelect = (CheckBox)item.FindControl("ChkbxSelect");
                if (ChkbxSelect.Checked)
                {
                    HiddenField hdnBarcodeNumber = (HiddenField)item.FindControl("hdnBarcodeNumber");
                    BarcodeNumber = hdnBarcodeNumber.Value;
                }
            }

            if (Check_boxslide.SelectedValue == "")
            {

            }
            else
            {
                slidevalues = Check_boxslide.SelectedItem.Text;
            }
            returncode = invbl.SaveCollectedDateTimeDetails(VisitID, SampleId, NewCollectedDateTime, slidevalues, BarcodeNumber);
            lblsamcolldatetxt1.Text = "--";
            hdnsampleid.Value = "";
            hdnVisitId1.Value = "";
            txtNewCollectTime.Text = "";
            Check_boxslide.ClearSelection();
            LoadGrid(e, startRowIndex, PageSize);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while save Pendingsamplecollection", ex);
        }
    }
    protected void btnHiddne_Click(object sender, EventArgs e)
    {
        string strPatientVisitId = string.Empty;
        string strSampleId = string.Empty;
        long VisitID = 0;
        string OldBarCode = string.Empty;
        BarcodeHelper objBarcodeHelper = new BarcodeHelper();
        List<BarcodeAttributes> lstBarcodeAttributes;
        List<PrintBarcode> lstPrintBarcode = new List<PrintBarcode>();
        PrintBarcode objPrintBarcode;
        string MachineID = string.Empty;
        if (Session["MacAddress"] != null)
        {
            MachineID = (string)Session["MacAddress"];
        }
        List<string> lstVisitID = new List<string>();
        List<string> lstSampleID = new List<string>();
        foreach (GridViewRow item in grdSample.Rows)
        {
            CheckBox ChkbxSelect = (CheckBox)item.FindControl("ChkbxSelect");
            if (ChkbxSelect.Checked)
            {
                HiddenField hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                HiddenField hfSampleId = (HiddenField)item.FindControl("hdnSampleId");
                HiddenField hdnBarcodeNumber = (HiddenField)item.FindControl("hdnBarcodeNumber");

                if (!lstVisitID.Contains(hfVisitId.Value))
                {
                    lstVisitID.Add(hfVisitId.Value);
                    VisitID = Convert.ToInt64(hfVisitId.Value);
                }
                if (!lstSampleID.Contains(hfSampleId.Value))
                {
                    lstSampleID.Add(hfSampleId.Value);
                }

                OldBarCode = hdnBarcodeNumber.Value;


            }
        }
        if (lstVisitID.Count > 0)
        {

            long ReturnCode = -1;
            GateWay ObjectGateWay = new GateWay(base.ContextInfo);
            string NewBarcode = txtNewBarcode.Text;
            ReturnCode = ObjectGateWay.UpdateExistingBarcode(VisitID, OldBarCode, NewBarcode);


            string barcodeType = BarcodeCategory.ContainerRegular;
            strPatientVisitId = string.Join(",", lstVisitID.ToArray());
            strSampleId = string.Join(",", lstSampleID.ToArray());
            lstBarcodeAttributes = new List<BarcodeAttributes>();
            objBarcodeHelper.GetBarcodeQueryString(OrgID, strPatientVisitId, strSampleId, 0, barcodeType, out lstBarcodeAttributes);
            if (lstBarcodeAttributes.Count > 0)
            {
                foreach (BarcodeAttributes objBarcodeAttributes in lstBarcodeAttributes)
                {
                    objPrintBarcode = new PrintBarcode();
                    objPrintBarcode.VisitID = objBarcodeAttributes.VisitID;
                    objPrintBarcode.SampleID = objBarcodeAttributes.SampleID;
                    objPrintBarcode.BarcodeNumber = objBarcodeAttributes.BarcodeNumber;
                    objPrintBarcode.MachineID = MachineID;
                    objPrintBarcode.HeaderLine1 = objBarcodeAttributes.HeaderLine1;
                    objPrintBarcode.HeaderLine2 = objBarcodeAttributes.HeaderLine2;
                    objPrintBarcode.FooterLine1 = objBarcodeAttributes.FooterLine1;
                    objPrintBarcode.FooterLine2 = objBarcodeAttributes.FooterLine2;
                    lstPrintBarcode.Add(objPrintBarcode);
                }
            }
            if (lstPrintBarcode.Count > 0)
            {
                GateWay objGateWay = new GateWay(base.ContextInfo);
                Int32 returnStatus = -1;
                objGateWay.SaveBarcodePrintDetails(lstPrintBarcode, out returnStatus);
            }
        }
        txtNewBarcode.Text = "";
        startRowIndex = 1;
        hdnCurrent.Value = startRowIndex.ToString();
        LoadGrid(e, startRowIndex, PageSize);
        if (ddlAction.SelectedValue == "Associate_NewBarcode")
        {

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "setvalue();", true);

        }

    }
    protected void grdOutSourcedDetails_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdOutSourcedDetails.PageIndex = e.NewPageIndex;

        }
        btnOK_Click(sender, e);
    }
    protected void grdOutSource_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdOutSource.PageIndex = e.NewPageIndex;

        }
        LoadGrid(e, startRowIndex, PageSize);
    }

    string strAlertSuccess = Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_27 == null ? "Saved successfully.." : Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_27;
    protected void btnSaveOutsource_Click(object sender, EventArgs e)
    {
        try
        {
            List<OutsourcingDetail> lstOutSourcingDetails = new List<OutsourcingDetail>();
            string strPatientVisitId = string.Empty;
            string strSampleId = string.Empty;
            string strGuid = string.Empty;
            string strSampleStatusID = string.Empty;
            string Status = string.Empty;
            string strInvID = string.Empty;
            string strAccessionNo = string.Empty;
            string strLocID = string.Empty;

            string strOutsourcedTime = string.Empty;
            string strCourierDetails = string.Empty;
            string strAcknowledgement = string.Empty;
            string strSampleTrackerID = string.Empty;
            string strReceivedDateTime = string.Empty;

            if (RdoSendOutSource.Checked == true)
            {
                strOutsourcedTime = txtOutsourcedTime.Text;
                strCourierDetails = txtCourierDetails.Text;

                if (lblOutsourceOrgtxt.Text.Trim() != string.Empty)
                {

                    Status = "OutSource";
                }
                else
                {
                    Status = "Send";
                }

               
            }
            if (RdoReceiveOutSource.Checked == true)
            {
                strReceivedDateTime = txtReceivedDateTime.Text;
                strCourierDetails = txtCourierDetails.Text;
                Status = "Received";
            }
            foreach (GridViewRow item in grdSample.Rows)
            {
                CheckBox ChkbxSelect = (CheckBox)item.FindControl("ChkbxSelect");
                if (ChkbxSelect.Checked)
                {
                    OutsourcingDetail objoutsourcingdtl = new OutsourcingDetail();
                    HiddenField hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                    HiddenField hfSampleId = (HiddenField)item.FindControl("hdnSampleId");
                    HiddenField hfGuid = (HiddenField)item.FindControl("hdnGuid");
                    HiddenField hfSampleStatusId = (HiddenField)item.FindControl("hdnInvSampleStatusID");
                    HiddenField hfSampleTrakerId = (HiddenField)item.FindControl("hdnSampleTrackerID");
                    HiddenField hfInvID = (HiddenField)item.FindControl("hdnInvID");
                    HiddenField hfAccessionNo = (HiddenField)item.FindControl("hdnAccessionNo");
                    DropDownList ddlOutLoc = (DropDownList)item.FindControl("ddlOutSourceLoc");
                    Label lblOutSourceLoc = (Label)item.FindControl("lblOutSourceLoc");
                    HiddenField hdnlblOutSourceLoc = (HiddenField)item.FindControl("hdnlblOutSourceLoc");
                    strPatientVisitId = hfVisitId.Value;
                    strSampleId = hfSampleId.Value;
                    strGuid = hfGuid.Value;
                    strSampleStatusID = hfSampleStatusId.Value;
                    strSampleTrackerID = hfSampleTrakerId.Value;
                    strInvID = hfInvID.Value;
                    strAccessionNo = hfAccessionNo.Value;

                    if (ddloutlocation.SelectedValue != "0")
                    {
                        strLocID = ddloutlocation.SelectedValue;
                    }
                    else
                    {
                        strLocID = ddlOutLoc.SelectedValue;
                    }
                    objoutsourcingdtl.PatientVisitID = Convert.ToInt64(strPatientVisitId);
                    objoutsourcingdtl.SampleID = Convert.ToInt64(strSampleId);
                    objoutsourcingdtl.UID = strGuid.ToString();
                    objoutsourcingdtl.InvSampleStatusID = Convert.ToInt32(strSampleStatusID);
                    objoutsourcingdtl.SampleTrackerID = Convert.ToInt64(strSampleTrackerID);
                    objoutsourcingdtl.InvestigationID = Convert.ToInt64(strInvID);
                    objoutsourcingdtl.AccessionNumber = Convert.ToInt64(strAccessionNo);
                    if (strLocID == "")
                    {
                        strLocID = "0";
                    }
                    objoutsourcingdtl.OutSourcingLocationID = Convert.ToInt64(strLocID);

                    lstOutSourcingDetails.Add(objoutsourcingdtl);
                }
            }
            Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
            long returncode = -1;
            returncode = invbl.SaveOutSourcingDetails(OrgID, LID, lstOutSourcingDetails, strOutsourcedTime, strReceivedDateTime, strCourierDetails, strAcknowledgement, Status);
            //btnOK_Click(sender, e);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "ValidationWindow('" + strAlertSuccess.Trim() + "','" + AlertType + "');", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + strAlertSuccess.Trim() + "','" + AlertType + "');", true);
            pnlSampleList.Visible = false;
            pnlFooter.Visible = false;
            txtCourierDetails.Text = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while save Pendingsamplecollection", ex);
        }
    }
    protected void grdOutSourcedDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblReceivedDate = (Label)e.Row.FindControl("lblReceivedDate");
           Label lblInvestigationID = (Label)e.Row.FindControl("lblInvestigationID"); 
            if (lblReceivedDate.Text == "01-01-0001 12:00:00 AM")
            {
                lblReceivedDate.Text = "--";
            }

            if (hdnInvestigationID.Value == lblInvestigationID.Text && ddlAction.SelectedValue != "Capture_OutSourcing_Details")
            {
                btnSaveOutsource.Attributes.Add("style", "display:none");

            }
            else
            {
                btnSaveOutsource.Attributes.Add("style", "display:block");
            }

        }

    }
    protected void ddlAction_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddlAction.SelectedValue == "Reject_Barcode_SampleSearch")
        //{
        //    ddlReason.Visible = true;
        //}
        //else
        //{
        //    ddlReason.Visible=false;
        //}
    }
    protected void btnConverttoXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //export to excel
            DataTable dt = (DataTable)ViewState["report"];
            string status = ddlSampleStatus.SelectedValue;
            if (status == "12")
            {
                if (RdoSendOutSource.Checked == true)
                {
                    dt.Columns.Remove("Received Date");
                }
                else if (RdoReceiveOutSource.Checked == true)
                {
                    dt.Columns.Remove("OutSourcing Date");
                }

            }
            string prefix = string.Empty;
            prefix = "OutSourcedTest_Reports_";
            string rptDate = prefix + OrgTimeZone + ".xls";
            var ds = new DataSet();
            ds.Tables.Add(dt);
            ExcelHelper.ToExcel(ds, rptDate, Page.Response);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }
    protected void grdSample_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GetOutSourcedLocations();
            if (lstActionsMaster.Count > 0)
            {
                //if (chkAberrant.Checked)
                //{
                //    grdSample.Columns[10].Visible = true;
                //}
                //else
                //{
                //    grdSample.Columns[10].Visible = false;
                //}
                grdSample.Columns[0].Visible = true;
                //if (OrgID == 71)
                //{
                //    grdSample.Columns[14].Visible = true;
                //}
                //else
                //{
                //    grdSample.Columns[14].Visible = false;
                //}
            }
            else
            {
                grdSample.Columns[0].Visible = false;
                //grdSample.Columns[10].Visible = false;
            }
        }
        else if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //if (OrgID == 71)
            //{
            //    grdSample.Columns[14].Visible = true;
            //}
            //else
            //{
            //    grdSample.Columns[14].Visible = false;
            //}
            Label lblCollectDate = (Label)e.Row.FindControl("lblCollectedDate");
              Label lblSampleStatus = (Label)e.Row.FindControl("lblSampleStatus");
            Label lblvisitestatus = (Label)e.Row.FindControl("lblvisitestatus");
            if (lblvisitestatus.Text.Trim() == "OutSource")

            {
                lblSampleStatus.Text = "Force OutSource";
            }
 Label lblBarcode = (Label)e.Row.FindControl("lblBarcode");
            //  lblCollectDate.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdSample, "CollectDate$" + e.Row.RowIndex));
 Label lblsampledesc = (Label)e.Row.FindControl("lblSample");


            CollectedSample lstInvestigationSamples = (CollectedSample)e.Row.DataItem;
            long SampleID = lstInvestigationSamples.SampleID;
            String Barcode = lstInvestigationSamples.BarcodeNumber;
            String PatientName = lstInvestigationSamples.PatientName; 
            long VisitID = lstInvestigationSamples.PatientVisitID;
            lblCollectDate.Attributes.Add("onclick", "ShowCollectSampleDateTimePopUp('" + SampleID + "','" + String.Format("{0:dd-MM-yyyy hh:mm:ss tt}", lstInvestigationSamples.CollectedDate) + "','" + VisitID + "')");
            //lblCollectDate.Attributes.Add("onclick", "javascript:SetCollectedDateTime();");
            lblBarcode.Attributes.Add("onclick", "showBlockandSlidePreparation('" + SampleID + "','" + Barcode + "','" + PatientName + "')");
            Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
            CollectedSample collSample = (CollectedSample)e.Row.DataItem;
            List<OrderedInvestigations> lstInvestigation = new List<OrderedInvestigations>();
                if (lblsampledesc.Text == "Block")
                {
                    lblBarcode.ForeColor = System.Drawing.Color.Black;
                }
                else if (lblsampledesc.Text == "Slide")
                {
                    lblBarcode.ForeColor = System.Drawing.Color.DarkOrange;
                }

            invBL.GetAberrantSampleInvestigations(collSample.PatientVisitID, collSample.SampleID, OrgID, out lstInvestigation);
            if (lstInvestigation.Count > 0)
            {
                string strtemp = GetToolTip(lstInvestigation);
                e.Row.Cells[3].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                //e.Row.Cells[2].Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
                e.Row.Cells[3].Attributes.Add("onmouseout", "hideTooltip();");
                //e.Row.Cells[0].Style.Add("color", "Blue");
            }

            DropDownList ddl = (DropDownList)e.Row.FindControl("ddlOutSourceLoc");
            //List<LabReferenceOrg> lstOutSourceLocation = new List<LabReferenceOrg>();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<LabReferenceOrg> lstOutSourceLocation = serializer.Deserialize<List<LabReferenceOrg>>(Convert.ToString(Session["OutSourceLocations"]));
           // lstOutSourceLocation = (List<LabReferenceOrg>)Session["OutSourceLocations"];
            ddl.DataSource = lstOutSourceLocation;
            ddl.DataTextField = "RefOrgName";
            ddl.DataValueField = "LabRefOrgID";
            ddl.DataBind();
            HiddenField hdnLocationID = (HiddenField)e.Row.FindControl("hdnAddressID");
            if (!String.IsNullOrEmpty(hdnLocationID.Value) && hdnLocationID.Value.Length > 0)
            {
                ddl.SelectedValue = hdnLocationID.Value;
            }
        }
    }
    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            startRowIndex = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        else
        {
            startRowIndex = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            startRowIndex = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        else
        {
            startRowIndex = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnGo1_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
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

    string strURL = Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_28 == null ? "URL Not Found" : Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_28;
    protected void grdSample_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string strPatientVisitId = string.Empty;
        string strSampleId = string.Empty;
        string strGuid = string.Empty;
        string strInvestigationID = string.Empty;

        if (e.CommandName == "CollectNewSample")
        {
            try
            {
                string[] arg = new string[4];
                arg = e.CommandArgument.ToString().Split(';');
                strPatientVisitId = arg[1];
                strSampleId = arg[0];
                strGuid = arg[2];
                strInvestigationID = arg[3];

                QueryMaster objQueryMaster = new QueryMaster();

                string RedirectURL = string.Empty;
                string QueryString = string.Empty;
                if (lstActionsMaster.Exists(p => p.ActionCode == "Collect_Sample_SampleSearch"))
                {
                    QueryString = lstActionsMaster.Find(p => p.ActionCode == "Collect_Sample_SampleSearch").QueryString;
                }
                objQueryMaster.Querystring = QueryString;
                objQueryMaster.PatientVisitID = strPatientVisitId;
                objQueryMaster.GuId = strGuid;
                objQueryMaster.TaskID = "0";
                objQueryMaster.SampleCollectAgain = "Y";
                objQueryMaster.SampleID = strSampleId;

                Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
                if (!String.IsNullOrEmpty(RedirectURL))
                {
                    Response.Redirect(RedirectURL, true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + strURL.Trim() + "','" + AlertType + "');", true);
                }
                //Response.Redirect(@"../Lab/InvestigationSample.aspx?vid=" + strPatientVisitId + "&gUID=" + strGuid + "&tid=0" + "&ColAgn=Y" + "&sid=" + strSampleId, true);
                return;
            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string ta = tae.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Abberant Sample grdSample_RowCommand", ex);
            }
        }

    }

    /// <summary>
    /// btnOK_Click
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    string strSampleRejectedSuccess = Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_30 == null ? "Sample is Rejected Successfully" : Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_30;
    string strSampleAlredyRejected = Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_31 == null ? "This Sample is already Rejected" : Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_31;
    string strSampleSentProcessing = Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_32 == null ? "This Sample is already sent to processing, Unable to Reject!" : Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_32;
    protected void btnOK_Click(object sender, EventArgs e)
    {
        try
        {
            PageContextDetails.ButtonName = ((Button)sender).ID;
            PageContextDetails.ButtonValue = ((Button)sender).Text;
            string samplestatus = ddlSampleStatus.SelectedItem.Text;
            string bulksample_print = null;
            BarcodeAttributes barcodeattribute = new BarcodeAttributes();
            Panel1.Visible = true;
            Panel2.Visible = true;
            string strPatientVisitId = string.Empty;
            string strSampleId = string.Empty;
            string strGuid = string.Empty;
            string strSampleStatusID = string.Empty;
            string strTaskID = string.Empty;
            string strAccessionNo = string.Empty;
            string strORDStatus = string.Empty;
            string Barcode_Number = string.Empty;


            ShowAndHide();
            string SampleStatus = ddlSampleStatus.SelectedValue;
            if (SampleStatus == "12" || SampleStatus == "All")
            {
                tdRdoBtns.Style.Add("display", "table-cell");

                if (RdoSendOutSource.Checked == true)
                {
                    RdoReceiveOutSource.Checked = false;
                }
                else if (RdoReceiveOutSource.Checked == true)
                {
                    RdoSendOutSource.Checked = false;
                }
            }
            List<PatientInvestigation> lstpatinv = new List<PatientInvestigation>();
            //added by sudha from lal
             int flag = 0;
             List<string> moresampleid = new List<string>();
            //ended by sudha from lal
            foreach (GridViewRow item in grdSample.Rows)
            {
                CheckBox ChkbxSelect = (CheckBox)item.FindControl("ChkbxSelect");
                if (ChkbxSelect.Checked)
                {
                    HiddenField hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                    HiddenField hfSampleId = (HiddenField)item.FindControl("hdnSampleId");
                    HiddenField hfGuid = (HiddenField)item.FindControl("hdnGuid");
                    HiddenField hfSampleStatusId = (HiddenField)item.FindControl("hdnInvSampleStatusID");
                    HiddenField hfTaskID = (HiddenField)item.FindControl("hdnTaskID");
                    HiddenField hfAccessionNo = (HiddenField)item.FindControl("hdnAccessionNo");
                    HiddenField hdnORDStatus = (HiddenField)item.FindControl("hdnORDStatus");
                    HiddenField hfsamplename = (HiddenField)item.FindControl("hdnSamplename");
                    samples = hfsamplename.Value;
                    strPatientVisitId = hfVisitId.Value;
                    strSampleId = hfSampleId.Value;
                    //added by sudha from lal
                   
                        if (!String.IsNullOrEmpty(strSampleId) && strSampleId.Length > 0)
                        {
                            flag = flag + 1;
                            moresampleid.Add(strSampleId);
                            if (flag > 0)
                            {
                                strSampleId = String.Join(",", moresampleid.ToArray());
                            }
                        }
                   
                    //ended by sudha from lal

                    strGuid = hfGuid.Value;
                    strSampleStatusID = hfSampleStatusId.Value;
                    string NotGivenTaskClosed = GetConfigValue("IsNotGivenTaskClosed", OrgID);
                    if ((SampleStatus == InvSampleStatus.Not_Given.ToString() && NotGivenTaskClosed == "Y"))
                    {
                        strTaskID = "0";
                    }
                    else
                    {
                        strTaskID = hfTaskID.Value;
                    }
                    strAccessionNo = hfAccessionNo.Value;
                    strORDStatus = hdnORDStatus.Value;
                    hdnPatientVisitID.Value = strPatientVisitId;
                }
            }

            if (ddlAction.SelectedValue == "Reject_Sample_SampleSearch")
            {
                if (strSampleStatusID == InvSampleStatus.Rejected.ToString())
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + strSampleReject.Trim() + "','" + AlertType + "');", true);
                    return;
                }
            }

            QueryMaster objQueryMaster = new QueryMaster();


            string RedirectURL = string.Empty;
            string QueryString = string.Empty;
            if (lstActionsMaster.Exists(p => p.ActionCode == ddlAction.SelectedValue))
            {
                QueryString = lstActionsMaster.Find(p => p.ActionCode == ddlAction.SelectedValue).QueryString;
            }
            objQueryMaster.Querystring = QueryString;
            objQueryMaster.PatientVisitID = strPatientVisitId;
            objQueryMaster.GuId = strGuid;
            if (strTaskID != "" && strTaskID != "0")
            {
                objQueryMaster.TaskID = strTaskID;
            }
            else
            {
                objQueryMaster.TaskID = "0";
            }
            objQueryMaster.SampleCollectAgain = "Y";
            objQueryMaster.SampleID = strSampleId;
            objQueryMaster.OrgID = Convert.ToString(OrgID);
            objQueryMaster.LoginID = Convert.ToString(LID);
            objQueryMaster.LocID = Convert.ToString(ILocationID);
            objQueryMaster.PrintAgain = "Y";
            //Added by Arivalagan.kk for  SlideBarcode Print//
            if (ddlAction.SelectedValue == "Print_SlideBarcode_SampleSearch")
            {
                objQueryMaster.CategoryCode = BarcodeCategory.SlideBarcode;
            }
            else
            {
                objQueryMaster.CategoryCode = BarcodeCategory.ContainerRegular;
            }
            //End by Arivalagan.kk for  SlideBarcode Print//
            objQueryMaster.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);

            string Querystring_ViewType_NotGiven = string.Empty;
            Querystring_ViewType_NotGiven = GetConfigValue("Querystring_ViewType_NotGiven", OrgID);
            if (Querystring_ViewType_NotGiven == "Y")
            {

                objQueryMaster.ViewType = "Y";

            }
            else
            {
                objQueryMaster.ViewType = "N";
            }
            Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);

            if (ddlAction.SelectedValue == "Bulk_Collect_Sample_SampleSearch")
            {
                foreach (GridViewRow item in grdSample.Rows)
                {
                    CheckBox ChkbxSelect = (CheckBox)item.FindControl("ChkbxSelect");
                    if (ChkbxSelect.Checked)
                    {
                        HiddenField hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                        HiddenField hfSampleId = (HiddenField)item.FindControl("hdnSampleId");
                        HiddenField hfGuid = (HiddenField)item.FindControl("hdnGuid");
                        HiddenField hfSampleStatusId = (HiddenField)item.FindControl("hdnInvSampleStatusID");
                        HiddenField hfTaskID = (HiddenField)item.FindControl("hdnTaskID");
                        HiddenField hfAccessionNo = (HiddenField)item.FindControl("hdnAccessionNo");
                        HiddenField hfCollecteddate = (HiddenField)item.FindControl("hdnSamplecollDate");
                        HiddenField hfPatientName = (HiddenField)item.FindControl("hdnPatientName");
                        HiddenField hfsamplename = (HiddenField)item.FindControl("hdnSamplename");
                        HiddenField hfBarcode = (HiddenField)item.FindControl("hdnBarcodeNumber");
                        ///////////////////TextBox hfCollecteddate = (TextBox)item.FindControl("txtcollecteddate");
                        //   HiddenField hfSamplestatusdescc = (HiddenField)item.FindControl("hdnSamplestatusdescc");

                        strPatientVisitId = hfVisitId.Value;
                        strSampleId = hfSampleId.Value;
                        strGuid = hfGuid.Value;
                        strSampleStatusID = hfSampleStatusId.Value;
                        strTaskID = hfTaskID.Value;
                        strAccessionNo = hfAccessionNo.Value;
                        string a = hfsamplename.Value;
                        // string b = hfSamplestatusdescc.Value;

                        PatientInvestigation lstpat = new PatientInvestigation();
                        lstpat.AccessionNumber = Convert.ToInt64(hfAccessionNo.Value);
                        lstpat.PatientVisitID = Convert.ToInt64(hfVisitId.Value);
                        lstpat.SampleID = Convert.ToInt32(hfSampleId.Value);
                        lstpat.UID = Convert.ToString(hfGuid.Value);
			//lstpat.InvSampleStatusID = Convert.ToInt32(LID);//Convert.ToInt32(hfSampleStatusId.Value);
                        // added by sudha  from lal          

            if (!String.IsNullOrEmpty(hfSampleStatusId.Value))
            {
                lstpat.InvSampleStatusID = Convert.ToInt32(hfSampleStatusId.Value);
            }
            else
            {
                lstpat.InvSampleStatusID = Convert.ToInt32(LID);
            }
                        //ended by sudha from lal

                        lstpat.KitName = Convert.ToString(hfTaskID.Value);
                        lstpat.CollectedDateTime = Convert.ToDateTime(hfCollecteddate.Value);
                        lstpat.Name = Convert.ToString(hfPatientName.Value);
                        lstpat.PackageName = hfsamplename.Value.ToString();
                        lstpat.BarcodeNumber = hfBarcode.Value.ToString();
                        //    lstpat.Status = Convert.ToString(hfSamplestatusdescc.Value);
                        lstpatinv.Add(lstpat);


                    }

                }

                Investigation_BL InvBulkBl = new Investigation_BL(base.ContextInfo);

                InvBulkBl.UpdateOrderedInvestigationStatusinLabBulk(lstpatinv);
                bulksample_print = "Y";

                //Response.Redirect("../Phlebotomist/home.aspx", true);

                //--
            }
            if ((ddlAction.SelectedValue == "Reprint_Barcode_SampleSearch"
                || ddlAction.SelectedValue == "Reprint_TRFBarcode_SampleSearch"
                || ddlAction.SelectedValue == "Aliquot_SampleSearch")
                || bulksample_print == "Y"
                || ddlAction.SelectedValue == "Print_SlideBarcode_SampleSearch"
                )
            {
                strPatientVisitId = string.Empty;
                strSampleId = string.Empty;
                BarcodeHelper objBarcodeHelper = new BarcodeHelper();
                List<BarcodeAttributes> lstBarcodeAttributes;
                List<PrintBarcode> lstPrintBarcode = new List<PrintBarcode>();
                PrintBarcode objPrintBarcode;
                string MachineID = string.Empty;
                if (Session["MacAddress"] != null)
                {
                    MachineID = (string)Session["MacAddress"];
                }
                List<string> lstVisitID = new List<string>();
                List<string> lstSampleID = new List<string>();
                foreach (GridViewRow item in grdSample.Rows)
                {
                    CheckBox ChkbxSelect = (CheckBox)item.FindControl("ChkbxSelect");
                    if (ChkbxSelect.Checked)
                    {
                        HiddenField hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                        HiddenField hfSampleId = (HiddenField)item.FindControl("hdnSampleId");
                        HiddenField hdnBarcodeNumber = (HiddenField)item.FindControl("hdnBarcodeNumber");
                        if (ddlAction.SelectedValue == "Print_SlideBarcode_SampleSearch")
                        {
                            if (Barcode_Number == "")
                            {
                                Barcode_Number = hdnBarcodeNumber.Value;
                            }
                            else { Barcode_Number = Barcode_Number + "," + hdnBarcodeNumber.Value; }

                        }
                        else
                        {
                            Barcode_Number = hdnBarcodeNumber.Value;
                        }
                        if (!lstVisitID.Contains(hfVisitId.Value))
                        {
                            lstVisitID.Add(hfVisitId.Value);
                        }
                        if (!lstSampleID.Contains(hfSampleId.Value))
                        {
                            lstSampleID.Add(hfSampleId.Value);
                        }
                    }
                }
                if (lstVisitID.Count > 0)
                {
                    string barcodeType = String.Empty;
                    if (ddlAction.SelectedValue == "Reprint_TRFBarcode_SampleSearch")
                    {
                        barcodeType = BarcodeCategory.TRF;
                    }
                    else if (ddlAction.SelectedValue == "Print_SlideBarcode_SampleSearch")
                    {
                        barcodeType = BarcodeCategory.SlideBarcode;
                    }
                    else
                    {
                        barcodeType = BarcodeCategory.ContainerRegular;
                    }
                    strPatientVisitId = string.Join(",", lstVisitID.ToArray());
                    strSampleId = string.Join(",", lstSampleID.ToArray());
                    lstBarcodeAttributes = new List<BarcodeAttributes>();
                    if (ddlAction.SelectedValue == "Aliquot_SampleSearch")
                    {
                        if (TxtAliquot.Text != "")
                        {
                            int return_status = -1;
                            string Barcodenumber = string.Empty;
                            int AliquotValue = int.Parse(TxtAliquot.Text);
                            Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                            long returncode = -1;

                            if (slidebarcode == "Y")
                            {
                                if (HiddenField1.Value == "Slide")
                                {
                                    if (CheckBox_Slide.SelectedValue == "")
                                    {

                                    }
                                    else
                                    {
                                        slidevalues = CheckBox_Slide.SelectedItem.Text;
                                    }
                                    returncode = invbl.pgetPatientInvSampleAliquot(OrgID, Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), Convert.ToString(Barcode_Number), return_status);
                                    if (returncode == 1)
                                    {
                                        object obj = "";
                                        Secondlayer(obj, e);
                                        TxtAliquot.Text = "0";

                                    }
                                    else
                                    {
                                        returncode = invbl.pgetPatientlayerAliquot(OrgID, Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), Convert.ToString(Barcode_Number), return_status);

                                        if (returncode == 1)
                                        {
                                            ModalPopupExtender1.Hide();
                                            ModalPopupExtender2.Hide();
                                            modalpopupcollectdate.Hide();
                                           AlertMsg = "Slides can be prepared only from Blocks";//"Can not make more slides";
                                            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:alert('Can not make more slides');", true);
                                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('" + AlertMsg.Trim() + "','" + AlertType + "');", true);
                                            TxtAliquot.Text = "0";
                                        }
                                        else
                                        {

                                            for (int i = 0; i < AliquotValue; i++)
                                            {
                                                returncode = invbl.PatientInvSampleAliquot_BlockSlide(OrgID, Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), Barcodenumber, 1, samples, slidevalues);
                                                TxtAliquot.Text = "0";
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    returncode = invbl.pgetPatientlayerAliquot(OrgID, Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), Convert.ToString(Barcode_Number), return_status);

                                    if (returncode == 1)
                                    {
                                        ModalPopupExtender1.Hide();
                                        ModalPopupExtender2.Hide();
                                        modalpopupcollectdate.Hide();
                                        AlertMsg = "Can not make block";
                                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('" + AlertMsg.Trim() + "','" + AlertType + "');", true);
                                        TxtAliquot.Text = "0";

                                    }
                                    else
                                    {
                                        for (int i = 0; i < AliquotValue; i++)
                                        {
                                            returncode = invbl.PatientInvSampleAliquot(OrgID, Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), Barcodenumber, 1, samples, slidevalues);
                                            TxtAliquot.Text = "0";
                                        }
                                    }
                                }
                            }
                            else
                            {
                                for (int i = 0; i < AliquotValue; i++)
                                {

                                    returncode = invbl.PatientInvSampleAliquot(OrgID, Convert.ToInt64(strPatientVisitId),

                                        Convert.ToInt32(strSampleId), Barcodenumber, 1, samples, slidevalues);
                                    TxtAliquot.Text = "0";
                                }
                            }
                            GateWay objGateWay = new GateWay(base.ContextInfo);

                            int AliquotCount = Convert.ToInt32(TxtAliquot.Text);
                            //objBarcodeHelper.GetBarcodeQueryString(OrgID, strPatientVisitId, strSampleId, 0, barcodeType, out lstBarcodeAttributes);
                        }
                    }
                    else
                    {
                        objBarcodeHelper.GetBarcodeQueryString(OrgID, strPatientVisitId, strSampleId, 0, barcodeType, out lstBarcodeAttributes);
                    }
                    //Added By Arivalagan.kk For Slide Barcode Print//
                    if (ddlAction.SelectedValue == "Print_SlideBarcode_SampleSearch")
                    {
                        // lstBarcodeAttributes.Select(x => x.BarcodeNumber == Barcode_Number);
                        lstBarcodeAttributes.RemoveAll(x => x.BarcodeNumber != Barcode_Number);
                    }
                    if (lstBarcodeAttributes.Count > 0)
                    {
                        foreach (BarcodeAttributes objBarcodeAttributes in lstBarcodeAttributes)
                        {
                            objPrintBarcode = new PrintBarcode();
                            objPrintBarcode.VisitID = objBarcodeAttributes.VisitID;
                            objPrintBarcode.SampleID = objBarcodeAttributes.SampleID;
                            objPrintBarcode.BarcodeNumber = objBarcodeAttributes.BarcodeNumber;
                            objPrintBarcode.MachineID = MachineID;
                            objPrintBarcode.HeaderLine1 = objBarcodeAttributes.HeaderLine1;
                            objPrintBarcode.HeaderLine2 = objBarcodeAttributes.HeaderLine2;
                            objPrintBarcode.FooterLine1 = objBarcodeAttributes.FooterLine1;
                            objPrintBarcode.FooterLine2 = objBarcodeAttributes.FooterLine2;
                            //lstPrintBarcode.Add(objPrintBarcode);
                            //VEL | 25-July-2019 | Enble reprint barcode | Start 
                            int reprintcount = hdnEnableMultiplereprint.Value == "Y" ? Convert.ToInt16(txtReprintCount.Text) : 1;
                            //VEL | 25-July-2019 | Enble reprint barcode | End 
                            for (int i = 0; i < reprintcount; i++)
                            {
                                lstPrintBarcode.Add(objPrintBarcode);
                            }
                        }
                    }
                    if (lstPrintBarcode.Count > 0)
                    {
                        //Changed by Arivalagan kk for cross browser print barcode//
                        //if (Session["RegKeyExists"] != null && Convert.ToString(Session["RegKeyExists"]) == "true")
                        //{
                        string barcode = string.Empty;
                        foreach (PrintBarcode oPrintBarcode in lstPrintBarcode)
                        {
                            if (barcode == string.Empty)
                            {
                                barcode = oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
                            }
                            else
                            {
                                barcode = barcode + "?" + oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
                            }
                        }
                        if (barcode != string.Empty)
                        {
                            CLogger.LogInfo("RePrint Barcode :   " + barcode);
                            iframeBarcode.Attributes["src"] = "attunebarcode:" + barcode;
                        }

                        // added by sudha from lal
                        string ConfigVal = GetConfigValue("LAL_Format", OrgID);
                        if (ConfigVal == "y")
                        {
                            if (!String.IsNullOrEmpty(RedirectURL))
                            {
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Window", "window.open('" + RedirectURL + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
                            }
                        }
                        // ended by sudha from lal

                        //}
                        //else
                        //{
                        //GateWay objGateWay = new GateWay(base.ContextInfo);
                        //Int32 returnStatus = -1;
                        //objGateWay.SaveBarcodePrintDetails(lstPrintBarcode, out returnStatus);
                        //}
                        //Changes End by Arivalagan kk for cross browser print baroce//
                    }
                }
            }

            else if (ddlAction.SelectedValue == "Reprint_SRS_SampleSearch")
            {
                if (!String.IsNullOrEmpty(RedirectURL))
                {
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Window", "window.open('../admin/PrintBarcode.aspx?visitId=" + strPatientVisitId + "&sampleId=" + strSampleId + "&guId=" + strGuid + "&orgId=" + OrgID + "&LID=" + LID + "&ILocationID=" + ILocationID + "&IsReprint=Y" + "&categoryCode=" + BarcodeCategory.ContainerRegular + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Window", "window.open('" + RedirectURL + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + strURL.Trim() + "','" + AlertType + "');", true);
                }
            }
            else if (ddlAction.SelectedValue == "Cancel_Sample_SampleSearch")
            {
                Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                long returncode = -1;
                returncode = invbl.CancelInvestigationSample(OrgID, Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), LID);
                btnGo_Click(sender, e);
            }
            else if (ddlAction.SelectedValue == "Aliquot_SampleSearch")
            {
                Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                long returncode = -1;
                string Barcodenumber = string.Empty;
                int AliquotValue = int.Parse(TxtAliquot.Text);


                for (int i = 0; i < AliquotValue; i++)
                {
                    //Karthick///
                    returncode = invbl.PatientInvSampleAliquot(OrgID, Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), Barcodenumber, 1, samples, slidevalues);
                    TxtAliquot.Text = "0";

                }

                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Window", "window.open('../admin/PrintBarcode.aspx?visitId=" + strPatientVisitId + "&sampleId=" + strSampleId + "&guId=" + strGuid + "&orgId=" + OrgID + "&categoryCode=" + BarcodeCategory.ContainerRegular + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
                if (!String.IsNullOrEmpty(RedirectURL))
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Window", "window.open('" + RedirectURL + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + strURL.Trim() + "','" + AlertType + "');", true);
                }
                TxtAliquot.Style.Add("display", "block");
            }
            else if (ddlAction.SelectedValue == "Reject_Sample_SampleSearch")
            {
                //added by sudha from lal
               
                    //Config Email Notification
                    IsNeedToEmailNotifyForSmplRjct();
              
                //ended by sudha from lal

                if (strORDStatus == "Paid" || strORDStatus == "SampleReceived" || strORDStatus == "Pending" || strORDStatus == "SampleCollected")
                {
                    SampleTracker objSampleTracker = new SampleTracker();
                    objSampleTracker.PatientVisitID = Convert.ToInt64(strPatientVisitId);
                    objSampleTracker.SampleID = Convert.ToInt32(strSampleId);
                    objSampleTracker.InvSampleStatusID = 4;
                    objSampleTracker.Reason = ddlReason.SelectedItem.Text;
                    objSampleTracker.AccessionNo = Convert.ToInt32(strAccessionNo);

                    Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                    long returncode = -1;
                    if (ddlAction.SelectedValue == "Inv_Reject_Sample_SampleSearch")
                    {
                        base.ContextInfo.AdditionalInfo = ddlAction.SelectedValue;
                    }
                    else
                    {
                        base.ContextInfo.AdditionalInfo = "V4ENVIRONMENT";
                    }
                    returncode = invbl.InsertRejectedSample(Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), 4, ddlReason.SelectedItem.Text, LID, Convert.ToInt64(strAccessionNo));
                    ApproveTaskCreation();
                    ActionManager AM = new ActionManager(base.ContextInfo);
                    List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                    PageContextkey PC = new PageContextkey();
                    PC.ID = Convert.ToInt64(ILocationID);
                    PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                    PC.RoleID = Convert.ToInt64(RoleID);
                    PC.OrgID = OrgID;
                    PC.PatientVisitID = Convert.ToInt64(strPatientVisitId);
                    PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
                    PC.ButtonName = PageContextDetails.ButtonName;//"btnOK";
                    PC.ButtonValue = PageContextDetails.ButtonValue;// "OK";
                    PC.SampleID = Convert.ToInt32(strSampleId);

                    lstpagecontextkeys.Add(PC);
                    long res = -1;
                    res = AM.PerformingNextStepNotification(PC, "", "");
                    btnGo_Click(sender, e);
                   
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + strSampleRejectedSuccess.Trim() + "','" + AlertType + "');", true);
                    
                   
                }
                else if (strORDStatus == "Rejected")
                {
                    ddlReason.Attributes.Add("style:display", "block");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + strSampleAlredyRejected.Trim() + "','" + AlertType + "');", true);
                }
                else
                {
                    ddlReason.Attributes.Add("style:display", "block");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + strSampleSentProcessing.Trim() + "','" + AlertType + "');", true);
                }

            }


            else if (ddlAction.SelectedValue == "Inv_Reject_Sample_SampleSearch")
            {
                IsNeedToEmailNotifyForSmplRjct();

                //ended by sudha from lal

                if (strORDStatus == "Paid" || strORDStatus == "SampleReceived" || strORDStatus == "Pending" || strORDStatus == "SampleCollected" || strORDStatus == "SampleTransferred")
                {
                    SampleTracker objSampleTracker = new SampleTracker();
                    objSampleTracker.PatientVisitID = Convert.ToInt64(strPatientVisitId);
                    objSampleTracker.SampleID = Convert.ToInt32(strSampleId);
                    objSampleTracker.InvSampleStatusID = 4;
                    objSampleTracker.Reason = ddlReason.SelectedItem.Text;
                    objSampleTracker.AccessionNo = Convert.ToInt32(strAccessionNo);

                    Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                    long returncode = -1;
                    if (ddlAction.SelectedValue == "Inv_Reject_Sample_SampleSearch")
                    {
                        base.ContextInfo.AdditionalInfo = ddlAction.SelectedValue;
                    }
                    else
                    {
                        base.ContextInfo.AdditionalInfo = "V4ENVIRONMENT";
                    }
                    returncode = invbl.InsertRejectedSample(Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), 4, ddlReason.SelectedItem.Text, LID, Convert.ToInt64(strAccessionNo));
                    ApproveTaskCreation();
                    ActionManager AM = new ActionManager(base.ContextInfo);
                    List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                    PageContextkey PC = new PageContextkey();
                    PC.ID = Convert.ToInt64(ILocationID);
                    PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                    PC.RoleID = Convert.ToInt64(RoleID);
                    PC.OrgID = OrgID;
                    PC.PatientVisitID = Convert.ToInt64(strPatientVisitId);
                    PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
                    PC.ButtonName = PageContextDetails.ButtonName;//"btnOK";
                    PC.ButtonValue = PageContextDetails.ButtonValue;// "OK";
                    PC.SampleID = Convert.ToInt32(strSampleId);

                    lstpagecontextkeys.Add(PC);
                    long res = -1;
                    res = AM.PerformingNextStepNotification(PC, "", "");
                   
                    
                   
                    btnGo_Click(sender, e);

                    if (returncode > 0)
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + strSampleRejectedSuccess.Trim() + "','" + AlertType + "');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + strSampleSentProcessing.Trim() + "','" + AlertType + "');", true);
                    }



                }
                else if (strORDStatus == "Rejected")
                {
                    ddlReason.Attributes.Add("style:display", "block");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + strSampleAlredyRejected.Trim() + "','" + AlertType + "');", true);
                }
                else
                {
                    ddlReason.Attributes.Add("style:display", "block");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + strSampleSentProcessing.Trim() + "','" + AlertType + "');", true);
                }

            }

            else if (ddlAction.SelectedValue == "Send_Outsource_Details" || ddlAction.SelectedValue == "Force_Outsource")
            {
                if (RdoSendOutSource.Checked == true)
                {
                    string Ischecked = "No";
                    HiddenField hfOutSourcedOrgName = new HiddenField();
                    HiddenField hfVisitId = new HiddenField();
                    HiddenField hfSampleId = new HiddenField();
                    HiddenField hfGuid = new HiddenField();
                    HiddenField hfSampleStatusId = new HiddenField();
                    HiddenField hfSampleTrakerId = new HiddenField();
                    HiddenField hdnSamplecollDate = new HiddenField();
                    HiddenField hdnInvID = new HiddenField();
                    Label visitstatus = new Label();
                      Label number = new Label();
                    List<OutsourcingDetail> lstOutsourcingDetail = new List<OutsourcingDetail>();
                    ModalPopupExtender1.Show();
                    txtOutsourcedTime.Text = OrgDateTimeZone;
                    trOutsourceDt.Style.Add("display", "table-row");
                    CheckBox ChkbxHeaderSelect = (CheckBox)grdSample.HeaderRow.FindControl("ChkbxHeaderSelect");
                    if (ChkbxHeaderSelect != null)
                    {
                        if (ChkbxHeaderSelect.Checked == true)
                        {
                            Ischecked = "Yes";
                        }
                    }
                    foreach (GridViewRow item in grdSample.Rows)
                    {
                        CheckBox ChkbxSelect = (CheckBox)item.FindControl("ChkbxSelect");
                        if (ChkbxSelect.Checked)
                        {
                            visitstatus = (Label)item.FindControl("lblvisitestatus");
                            number= (Label)item.FindControl("lblPatientNo");
                           string msg = "Already Process  this Visit Number(" + number.Text + ")";
                            
                            if (ddlAction.SelectedValue == "Force_Outsource")

                            {
                                if (visitstatus.Text.Trim() == "SampleReceived" || visitstatus.Text.Trim() == "SampleCollected" || visitstatus.Text.Trim() == "	Pending" )
                                {
                                    hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                                    hfSampleId = (HiddenField)item.FindControl("hdnSampleId");
                                    hfGuid = (HiddenField)item.FindControl("hdnGuid");
                                    hfSampleStatusId = (HiddenField)item.FindControl("hdnInvSampleStatusID");
                                    hfSampleTrakerId = (HiddenField)item.FindControl("hdnSampleTrackerID");
                                    hfOutSourcedOrgName = (HiddenField)item.FindControl("hdnOutSourcedOrgName");
                                    hdnSamplecollDate = (HiddenField)item.FindControl("hdnSamplecollDate");
                                    hdnInvID = (HiddenField)item.FindControl("hdnInvID");
                                    hdnInvestigationID.Value = hdnInvID.Value;
                                }

                                else
                                {
                                    ModalPopupExtender1.Hide();
                                    hdnMessages1.Visible = true;


                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + msg + "');", true);
                                   
                                    break;
                                 
                                }
                            }
                            if (ddlAction.SelectedValue == "Send_Outsource_Details")
                            {

                                hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                                hfSampleId = (HiddenField)item.FindControl("hdnSampleId");
                                hfGuid = (HiddenField)item.FindControl("hdnGuid");
                                hfSampleStatusId = (HiddenField)item.FindControl("hdnInvSampleStatusID");
                                hfSampleTrakerId = (HiddenField)item.FindControl("hdnSampleTrackerID");
                                hfOutSourcedOrgName = (HiddenField)item.FindControl("hdnOutSourcedOrgName");
                                hdnSamplecollDate = (HiddenField)item.FindControl("hdnSamplecollDate");
                                hdnInvID = (HiddenField)item.FindControl("hdnInvID");
                                hdnInvestigationID.Value = hdnInvID.Value;
                            }
                        }
                    }


                    if (ddlAction.SelectedValue == "Force_Outsource")
                    {
                        lblOutsourceOrg.Visible = true;


                        if (samplestatus == "OutSource")
                        {
                            ddloutlocation.SelectedValue = "0";

                            //lblOutsourceOrgtxt.Text = hfOutSourcedOrgName.Value;
                            lblOutsourceOrg.Visible = false;
                            lblOutsourceOrgtxt.Text = string.Empty;
                        }
                        else
                        {
                            lblOutsourceOrgtxt.Text = ddloutlocation.SelectedItem.Text;
                            ddlactionvalue = ddlAction.SelectedValue;
                            ddlAction.SelectedIndex = -1;

                        }
                    }
                    else
                    {

                        if (Ischecked == "Yes")
                        {
                           
                                lblOutsourceOrg.Visible = true;
                                lblOutsourceOrgtxt.Text = "";                            
                           
                        }
                        else
                        {
                            
                                 lblOutsourceOrg.Visible = false;
                                 lblOutsourceOrgtxt.Text = hfOutSourcedOrgName.Value;
                            

                           
                        }
                    }
                    lblsamcolldatetxt.Text = hdnSamplecollDate.Value;
                    Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                    long returncode = -1;
                    returncode = invbl.GetOutSourcingDetails(OrgID, Convert.ToInt64(hfSampleId.Value), Convert.ToInt64(hfVisitId.Value), Convert.ToInt64(hfSampleTrakerId.Value), hfGuid.Value, out lstOutsourcingDetail);
                    grdOutSourcedDetails.DataSource = lstOutsourcingDetail;
                    grdOutSourcedDetails.DataBind();
                    if (lstOutsourcingDetail.Count > 0)
                    {
                        grdOutSourcedDetails.Columns[3].Visible = false;
                        grdOutSourcedDetails.Columns[2].Visible = true;
                        txtOutsourcedTime.Text = lstOutsourcingDetail[0].OutsourcedDate.ToString("dd/MM/yyyy hh:mm:ss tt") == "01/01/0001 12:00:00 AM" ? OrgDateTimeZone : lstOutsourcingDetail[0].OutsourcedDate.ToString("dd/MM/yyyy hh:mm:ss tt");
                        //txtReceivedDateTime.Text = lstOutsourcingDetail[0].ReceivedDate.ToString("dd/MM/yyyy hh:mm:ss tt") == "01/01/0001 12:00:00 AM" ? "" : lstOutsourcingDetail[0].ReceivedDate.ToString("dd/MM/yyyy hh:mm:ss tt");
                        //txtCourierDetails.Text = lstOutsourcingDetail[0].CourierDetails;
                        txtCourierDetails.Text = "";
                        
                        //txtAcknowledgement.Text = lstOutsourcingDetail[0].ReachedDate.ToString("dd/MM/yyyy hh:mm:ss tt") == "01/01/0001 12:00:00 AM" ? "" : lstOutsourcingDetail[0].ReachedDate.ToString("dd/MM/yyyy hh:mm:ss tt");
                    }
                    else
                    {
                       
                        //txtOutsourcedTime.Text = "";
                        // txtReceivedDateTime.Text = "";
                        txtCourierDetails.Text = "";
                        // txtAcknowledgement.Text = "";
                    }

                }

                hdnInvestigationID.Value = "0";
            }
            else if (ddlAction.SelectedValue == "Capture_OutSourcing_Details")
            {
                btnSaveOutsource.Attributes.Add("style", "display:block");
                if (RdoReceiveOutSource.Checked == true)
                {
                    string Ischecked = "No";
                    HiddenField hfOutSourcedOrgName = new HiddenField();
                    HiddenField hfVisitId = new HiddenField();
                    HiddenField hfSampleId = new HiddenField();
                    HiddenField hfGuid = new HiddenField();
                    HiddenField hfSampleStatusId = new HiddenField();
                    HiddenField hfSampleTrakerId = new HiddenField();
                    HiddenField hdnSamplecollDate = new HiddenField();
                    HiddenField hdnSamplename = new HiddenField();
					 HiddenField hdnInvID = new HiddenField();
                    List<OutsourcingDetail> lstOutsourcingDetail = new List<OutsourcingDetail>();
                    ModalPopupExtender1.Show();
                    //txtOutsourcedTime.Text = System.DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt");
                    trOutsourceDt.Style.Add("display", "none");
                    trReceiveDt.Style.Add("display", "table-row");

                    CheckBox ChkbxHeaderSelect = (CheckBox)grdSample.HeaderRow.FindControl("ChkbxHeaderSelect");
                    if (ChkbxHeaderSelect != null)
                    {
                        if (ChkbxHeaderSelect.Checked == true)
                        {
                            Ischecked = "Yes";
                        }
                    }
                    foreach (GridViewRow item in grdSample.Rows)
                    {
                        CheckBox ChkbxSelect = (CheckBox)item.FindControl("ChkbxSelect");
                        if (ChkbxSelect.Checked)
                        {
                            hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                            hfSampleId = (HiddenField)item.FindControl("hdnSampleId");
                            hfGuid = (HiddenField)item.FindControl("hdnGuid");
                            hfSampleStatusId = (HiddenField)item.FindControl("hdnInvSampleStatusID");
                            hfSampleTrakerId = (HiddenField)item.FindControl("hdnSampleTrackerID");
                            hfOutSourcedOrgName = (HiddenField)item.FindControl("hdnOutSourcedOrgName");
                            hdnSamplecollDate = (HiddenField)item.FindControl("hdnSamplecollDate");
                            hdnSamplename  = (HiddenField)item.FindControl("hdnSamplename");
                            hdnInvID = (HiddenField)item.FindControl("hdnInvID");
                            hdnInvestigationID.Value = hdnInvID.Value;
                        }
                    }
                    if (Ischecked == "Yes")
                    {
                        lblOutsourceOrg.Visible = false;
                        lblOutsourceOrgtxt.Text = "";
                    }
                    else
                    {
                        lblOutsourceOrg.Visible = true;
                        lblOutsourceOrgtxt.Text = hfOutSourcedOrgName.Value;
                    }
                    lblsamcolldatetxt.Text = hdnSamplecollDate.Value;
                    Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                    long returncode = -1;
                    returncode = invbl.GetOutSourcingDetails(OrgID, Convert.ToInt64(hfSampleId.Value), Convert.ToInt64(hfVisitId.Value), Convert.ToInt64(hfSampleTrakerId.Value), hfGuid.Value, out lstOutsourcingDetail);
                    grdOutSourcedDetails.DataSource = lstOutsourcingDetail;
                    grdOutSourcedDetails.DataBind();
                    if (lstOutsourcingDetail.Count > 0)
                    {
                        grdOutSourcedDetails.Columns[3].Visible = true;
                        grdOutSourcedDetails.Columns[2].Visible = false;
                        //txtOutsourcedTime.Text = lstOutsourcingDetail[0].OutsourcedDate.ToString("dd/MM/yyyy hh:mm:ss tt") == "01/01/0001 12:00:00 AM" ? System.DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt") : lstOutsourcingDetail[0].OutsourcedDate.ToString("dd/MM/yyyy hh:mm:ss tt");
                        txtReceivedDateTime.Text = OrgDateTimeZone;
                        //  txtCourierDetails.Text = lstOutsourcingDetail[0].CourierDetails;
                        txtCourierDetails.Text = "";
                        // txtAcknowledgement.Text = lstOutsourcingDetail[0].ReachedDate.ToString("dd/MM/yyyy hh:mm:ss tt") == "01/01/0001 12:00:00 AM" ? "" : lstOutsourcingDetail[0].ReachedDate.ToString("dd/MM/yyyy hh:mm:ss tt");
                    }
                    else
                    {
                        //txtOutsourcedTime.Text = "";
                        txtReceivedDateTime.Text = OrgDateTimeZone;
                        txtCourierDetails.Text = "";
                        // txtAcknowledgement.Text = "";
                    }
                }
                      hdnInvestigationID.Value = "0";
            }

            else if (ddlAction.SelectedValue == "Associate_NewBarcode")
            {

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "setvalue();", true);

            }

            else
            {
                //changes by sudhakar for NotGiven Work 
                if (!String.IsNullOrEmpty(RedirectURL))
                {
                    string strStatus = "N";
                    Response.Redirect(RedirectURL + "&SetNG=" + strStatus, true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:alert('URL Not Found');", true);
                }
            }
            if (ddlAction.SelectedValue == "Send_Outsource_Details" || ddlAction.SelectedValue == "Capture_OutSourcing_Details" || ddlactionvalue == "Force_Outsource" || samplestatus == "OutSource")
            {
                //startRowIndex = 1;
                //hdnCurrent.Value = startRowIndex.ToString();
                //LoadGrid(e, startRowIndex, PageSize);
            }
            else
            {
                startRowIndex = 1;
                hdnCurrent.Value = startRowIndex.ToString();
                LoadGrid(e, startRowIndex, PageSize);
                //CheckBox_Slide.ClearSelection();
                ////ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('Record Saved Successfully');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while sending samples", ex);
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        try
        {

            //added by sudha from lal
               if (txtVisitID.Text.Trim() == defaultText.Trim())
	        {
	            txtVisitID.Text = "";
	        }


               hidval.Value = ddlSampleStatus.SelectedIndex.ToString();
            startRowIndex = 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
            ddlSampleStatus.SelectedIndex = Convert.ToInt16(hidval.Value);
            LoadReasons();
            lblCurrent.Text = startRowIndex.ToString();

            string SampleStatus = ddlSampleStatus.SelectedValue.ToString();
            if (SampleStatus == "12")
            {
                tdRdoBtns.Style.Add("display", "table-cell");

                if (RdoSendOutSource.Checked == true)
                {
                    RdoReceiveOutSource.Checked = false;
                }
                else if (RdoReceiveOutSource.Checked == true)
                {
                    RdoSendOutSource.Checked = false;
                }
            }
            if (ddlAction.SelectedValue == "Associate_NewBarcode")
            {

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "setvalue();", true);

            }
         //   ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "SetSampleStatus();", true);


            
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "SetSampleStatus();", true);
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in sample search: ", ex);
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "Error in sample search, Please contact system administrator.";
        }
    }
    protected void grdResult_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item)
        {
            DropDownList ddlSampleStatus = e.Item.FindControl("lblstatusID") as DropDownList;
            ddlSampleStatus.SelectedValue = ((PatientInvSample)e.Item.DataItem).InvSampleStatusID.ToString();
        }
    }


    #endregion


    #region "Methods"



    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = 0;
        try
        {
            totalPages = (int)Math.Ceiling(totalRows / PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while CalculateTotalPages", ex);
        }
        return totalPages;
    }

    private void LoadGrid(EventArgs e, int startRowIndex, int PageSize)
    {
        txtpageNo.Text = "";
        hdnCurrent.Value = "";

        try
        {
            List<CollectedSample> lstInvestigationSamples = new List<CollectedSample>();
            Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
            List<OutsourcingDetail> lstOutSourcingDetails = new List<OutsourcingDetail>();

            //Test

            //long returncode = -1;
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
            int intSampleStatus = -1;
            string preference = string.Empty;
            string BarcodeFrom = string.Empty;
            string BarcodeTo = string.Empty;
            string UserLoginID = string.Empty;
            string SubStatus = string.Empty;
            long OutLocations = 0;
            string pkgout = "N";

            if (chkAberrant.Checked)
            {
                intSampleStatus = Convert.ToInt32(ddlSampleStatus.SelectedItem.Value);
            }
            else
            {
                intSampleStatus = -1;
            }          
          
                if (txtVisitID.Text != "" && txtVisitID.Text != "Visit Number" && txtVisitID.Text != "Lab Number")
                {
                    visitid = txtVisitID.Text.Trim();
                }
                else
                 if (txtVisitID.Text != "")
                {
                    visitid = txtVisitID.Text.Trim();
                }

            //added by sudha
            if (txtVisitID.Text == "Visit Number")
            {
                visitid = "";
            }

            if (txtVisitID.Text == "Lab Number")
            {
                visitid = "";
            }
            // ended by sudha 
            //commented by sudha
            ////if (txtVisitID.Text != "")
            //  {
            //    visitid = txtVisitID.Text.Trim();
            //}

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
                // refPhyOrg = Convert.ToInt32(hdnRefPhyOrg.Value);
            }

            if (ddlLocation.SelectedValue != "-1")
            {
                CollectedLocationID = Convert.ToInt32(ddlLocation.SelectedValue);
            }
            if (ddlPrefrence.SelectedValue != null && ddlPrefrence.SelectedValue != "")
            {
                preference = ddlPrefrence.SelectedValue;
            }

            if (txtUsers.Text != "" && hdnUserLoginID.Value != "0")
            {
                UserLoginID = hdnUserLoginID.Value;
            }
            else UserLoginID = string.Empty;


            if (txtBarCodeFrom.Text != "")
            {
                BarcodeFrom = txtBarCodeFrom.Text;
            }
            else BarcodeFrom = string.Empty;

            if (txtBarcodeTo.Text != "")
            {
                BarcodeTo = txtBarcodeTo.Text;
            }
            else BarcodeTo = string.Empty;

            if (RdoSendOutSource.Checked == true)
            {
                SubStatus = "Send";
            }

            else if (RdoReceiveOutSource.Checked == true)
            {
                SubStatus = "Received";
                // invbl.GetInvSamplesforOutSource(OrgID, SubStatus, out lstOutSourcingDetail, PageSize, startRowIndex, out totalRows);

            }
            if (ddlOutSourcedLocations.SelectedValue != null && ddlOutSourcedLocations.SelectedValue != "" && ddlOutSourcedLocations.SelectedValue != "0")
            {
                OutLocations = Convert.ToInt64(ddlOutSourcedLocations.SelectedValue);
            }
            if (Chkpkgout.Checked == true)
            {
                pkgout = "Y";
            }
            if (chkViewReport.Checked == true)
            {
                invbl.GetInvSamplesforOutSource(OrgID, SubStatus, OutLocations, out lstOutSourcingDetails);
                if (lstOutSourcingDetails.Count > 0)
                {
                    pnlSampleList.Visible = true;
                    divPrintarea.Visible = true;
                    divgrdsample.Visible = false;
                    if (SubStatus == "Send")
                    {
                        grdOutSource.Columns[12].Visible = true;
                        grdOutSource.Columns[13].Visible = false;

                    }
                    else
                    {
                        grdOutSource.Columns[12].Visible = false;
                        grdOutSource.Columns[13].Visible = true;
                    }
                    grdOutSource.DataSource = lstOutSourcingDetails;
                    grdOutSource.DataBind();

                    GrdFooter.Visible = false;
                    lblStatus.Visible = false;
                    pnlFooter.Visible = false;
                    tdXLPrint.Style.Add("display", "table-cell");
                    loaddata(lstOutSourcingDetails);

                }
                else
                {
                    GrdFooter.Visible = false;
                    pnlSampleList.Visible = false;
                    divgrdsample.Visible = false;
                    //tdXLPrint.Style.Add("display", "none");
                    lblStatus.Visible = true;
                }
            }
            else
            {
                if ((visitid != null) && (visitid != ""))
                {
                    //DateTime MinDate = Convert.ToDateTime("01/01/1900 00:00:00");
                    //DateTime MaxDate = Convert.ToDateTime("01/01/2100 00:00:00");
                    //txtFrom.Text = MinDate.ToShortDateString();
                    //txtTo.Text = MaxDate.ToShortDateString();
                }
                //if (txtFromVisitNo.Text != "" && txtFromVisitNo.Text != "0")
                //{
                //    FromVisitNo = txtFromVisitNo.Text;
                //}
                //if (txtToVisitNo.Text != "" && txtToVisitNo.Text != "0")
                //{
                //    ToVisitNo = txtToVisitNo.Text;
                //}
                if (ddlRegLocation.SelectedValue != "-1")
                {
                    intRegLocation = Convert.ToInt32(ddlRegLocation.SelectedItem.Value);
                }
                else
                {
                    intRegLocation = -1;
                }
                /* BEGIN | NA | Sabari | 20190515 | Created | MRNNumberSearch */
                ///For MRN NUMBER SEARCH WE HAVE ADDED Patientnumber to an input for below function call
                /* END | NA | Sabari | 20190515 | Created | MRNNumberSearch */
                invbl.GetInvSamplesForStatus(OrgID, txtFrom.Text, txtTo.Text, intSampleStatus, CollectedLocationID, "", visitid, patientname,
                  visittype, priority, sourcename, InvestigationName, InvestigationID, InvestigationType, refPhyName, refPhyID, refPhyOrg,
                  Convert.ToInt64(ddlSample.SelectedItem.Value), Convert.ToInt32(ddlType.SelectedItem.Value), preference, out lstInvestigationSamples, PageSize, startRowIndex, out totalRows, BarcodeFrom, BarcodeTo, UserLoginID, SubStatus, intRegLocation, OutLocations, pkgout, patientnumber);
                //Test

                //invbl.GetInvSamplesForStatus(OrgID, txtFrom.Text, txtTo.Text, Convert.ToInt32(ddlSampleStatus.SelectedItem.Value), ILocationID,"", out lstInvestigationSamples);//,txtPatientName.Text,txtVisitID.Text);

                LoadGridAction(lstInvestigationSamples);

                if (lstInvestigationSamples.Count > 0)
                {
                    pnlSampleList.Visible = true;
                    divPrintarea.Visible = false;
                    //tdXLPrint.Style.Add("display", "none");
                    grdSample.DataSource = lstInvestigationSamples;
                    grdSample.DataBind();
                    grdSample.Visible = true;
                    GrdFooter.Visible = true;

                    totalpage = totalRows;
                    lblTotal.Text = CalculateTotalPages(totalRows).ToString();

                    if (intSampleStatus == 12)
                    {
                        grdSample.Columns[7].Visible = false;
                        grdSample.Columns[10].Visible = true;
                    }
                    else
                    {
                        grdSample.Columns[7].Visible = true;
                        grdSample.Columns[10].Visible = false;
                    }

                    if (hdnCurrent.Value == "")
                    {
                        lblCurrent.Text = startRowIndex.ToString();
                    }
                    else
                    {
                        lblCurrent.Text = hdnCurrent.Value;
                        startRowIndex = Convert.ToInt32(hdnCurrent.Value);
                    }
                    if (startRowIndex == 1)
                    {
                        Btn_Previous.Enabled = false;

                        if (Int32.Parse(lblTotal.Text) > 1)
                        {
                            Btn_Next.Enabled = true;
                        }
                        else
                            Btn_Next.Enabled = false;
                    }
                    else
                    {
                        Btn_Previous.Enabled = true;

                        if (startRowIndex == Int32.Parse(lblTotal.Text))
                            Btn_Next.Enabled = false;
                        else Btn_Next.Enabled = true;
                    }
                }
                else
                {
                    grdSample.Visible = false;
                    //tdXLPrint.Style.Add("display", "none");
                    pnlFooter.Visible = false;
                    GrdFooter.Visible = false;
                    pnlSampleList.Visible = false;
                }

                if ((txtFrom.Text == "01/01/1900") && (txtTo.Text == "01/01/2100"))
                {
                    txtFrom.Text = DateTime.Today.AddDays(-1).ToString("dd/MM/yyyy");
                    txtTo.Text = OrgTimeZone;
                }
            }
            if (RdoSendOutSource.Checked == true)
            {
                RdoReceiveOutSource.Checked = false;
            }
            else if (RdoReceiveOutSource.Checked == true)
            {
                RdoSendOutSource.Checked = false;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading sample", ex);
        }

    }

    

    

    
    

    
    private void LoadSampleFromHomePage()
    {
        try
        {
            string SampleStatus = string.Empty;
            string FDate = string.Empty;
            string TDate = string.Empty;
            string LocationType = string.Empty;
            string SubStatus = string.Empty;
            long OutLocations = 0;
            string pkgout = "N";
            if (Chkpkgout.Checked == true)
            {
                pkgout = "Y";
            }
            if (Request.QueryString["SStatus"] != null && Request.QueryString["FDate"] != null)
            {
                chkAberrant.Checked = true;
                SampleStatus = Request.QueryString["SStatus"];
                FDate = Request.QueryString["FDate"];
                //TDate = Request.QueryString["SStatus"];
                LocationType = Request.QueryString["Location"];

                FDate = Convert.ToDateTime(FDate).AddDays(-1).AddDays(1).ToString("dd/MM/yyyy");
                TDate = OrgTimeZone;

                // FDate = "01-01-2011 12:00 AM";//Request.QueryString["FDate"];
                // TDate = DateTime.Now.ToString(); //"02-04-2012 05:22 PM";// Request.QueryString["TDate"];
                txtFrom.Text = FDate;
                txtTo.Text = TDate;
                ddlSampleStatus.SelectedValue = SampleStatus;

                //------------------------------------------------------//
                // Modified by Sathish/*
                // FOR OUTSOURCE Flow Like  MEDALL /*
                // Modified date -- 10/09/2013/*
                //  ------  Changes Begin-----------------//

                if (SampleStatus == "12")
                {
                    tdRdoBtns.Style.Add("display", "table-cell");
                    RdoSendOutSource.Checked = true;
                    RdoReceiveOutSource.Checked = false;
                }
                else
                {
                    tdRdoBtns.Style.Add("display", "none");
                }

                if (RdoSendOutSource.Checked == true)
                {
                    SubStatus = "Send";
                }

                else if (RdoReceiveOutSource.Checked == true)
                {
                    SubStatus = "Received";

                }
                ShowAndHide();
                if (ddlOutSourcedLocations.SelectedValue != null && ddlOutSourcedLocations.SelectedValue != "" && ddlOutSourcedLocations.SelectedValue != "0")
                {
                    OutLocations = Convert.ToInt64(ddlOutSourcedLocations.SelectedValue);
                }
                // -------------------END-----------------------------//
                List<CollectedSample> lstInvestigationSamples = new List<CollectedSample>();
                Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                /* BEGIN | NA | Sabari | 20190515 | Created | MRNNumberSearch */
                invbl.GetInvSamplesForStatus(OrgID, FDate, TDate, Convert.ToInt32(SampleStatus), ILocationID, LocationType,
                    "", "", -1, -1, "", "", -1, "", "", -1, -1, -1, 1, "All", out lstInvestigationSamples, PageSize, startRowIndex, out totalRows, "", "", "", SubStatus, -1, OutLocations, pkgout,""); //,txtPatientName.Text,txtVisitID.Text);
                /* END | NA | Sabari | 20190515 | Created | MRNNumberSearch */
                LoadGridAction(lstInvestigationSamples);
                if (lstInvestigationSamples.Count > 0)
                {
                    pnlSampleList.Visible = true;
                    divPrintarea.Visible = false;
                    //tdXLPrint.Style.Add("display", "none");
                    grdSample.DataSource = lstInvestigationSamples;
                    grdSample.DataBind();
                    grdSample.Visible = true;
                    GrdFooter.Visible = true;

                    if (SampleStatus == "12")
                    {
                        grdSample.Columns[7].Visible = false;
                        grdSample.Columns[10].Visible = true;
                    }
                    else
                    {
                        grdSample.Columns[7].Visible = true;
                        grdSample.Columns[10].Visible = false;
                    }

                    totalpage = totalRows;
                    lblTotal.Text = CalculateTotalPages(totalRows).ToString();

                    if (hdnCurrent.Value == "")
                    {
                        lblCurrent.Text = startRowIndex.ToString();
                    }
                    else
                    {
                        lblCurrent.Text = hdnCurrent.Value;
                        startRowIndex = Convert.ToInt32(hdnCurrent.Value);
                    }
                    if (startRowIndex == 1)
                    {
                        Btn_Previous.Enabled = false;

                        if (Int32.Parse(lblTotal.Text) > 1)
                        {
                            Btn_Next.Enabled = true;
                        }
                        else
                            Btn_Next.Enabled = false;
                    }
                    else
                    {
                        Btn_Previous.Enabled = true;

                        if (startRowIndex == Int32.Parse(lblTotal.Text))
                            Btn_Next.Enabled = false;
                        else Btn_Next.Enabled = true;
                    }
                }
                else
                {
                    grdSample.Visible = false;
                    //tdXLPrint.Style.Add("display", "none");
                    pnlFooter.Visible = false;
                    GrdFooter.Visible = false;
                    pnlSampleList.Visible = false;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading sample", ex);
        }
    }


    private void LoadLocation()
    {
        long returnCode_register = -1;
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        List<OrganizationAddress> lstRegisterLocation = new List<OrganizationAddress>();
        // Below Current Org Location
        //returnCode = patientBL.GetLocation(OrgID, LID, RoleID, out lstLocation);
        // Below is Trusted Org Location
        returnCode = new Referrals_BL(base.ContextInfo).GetALLProcessingLocation(OrgID, out lstLocation);

        if (lstLocation.Count > 0)
        {


            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();


            if (lstLocation.Count == 1)
            {
                ddlLocation.Items.Insert(0, strSelects.Trim());
                ddlLocation.Items[0].Value = "-1";
            }
            else if (lstLocation.Count == 0 || lstLocation.Count > 1)
            {
                ddlLocation.Items.Insert(0, strSelects.Trim());
                ddlLocation.Items[0].Value = "-1";
            }
            //ddlLocation.SelectedValue = ILocationID.ToString();
        }
        List<OrganizationAddress> LoginLoc = new List<OrganizationAddress>();
        List<OrganizationAddress> ParentLoc = new List<OrganizationAddress>();
        returnCode_register = new Referrals_BL(base.ContextInfo).GetRegisterLocation(OrgID, out lstRegisterLocation);
        if (lstRegisterLocation.Count > 0)
        {
            if (CID > 0)
            {
                LoginLoc = lstRegisterLocation.FindAll(P => P.AddressID == ILocationID).ToList();
                ParentLoc = (from lst in lstRegisterLocation
                             join lst1 in LoginLoc on lst.AddressID equals lst1.ParentAddressID
                             select lst).ToList();
                LoginLoc = LoginLoc.Concat(ParentLoc).ToList<OrganizationAddress>();
                ddlRegLocation.DataSource = LoginLoc;
                ddlRegLocation.DataValueField = "AddressID";
                ddlRegLocation.DataTextField = "Location";
                ddlRegLocation.DataBind();
                ddlRegLocation.SelectedValue = ILocationID.ToString();

            }
            else
            {

                ddlRegLocation.DataSource = lstRegisterLocation;
                ddlRegLocation.DataTextField = "Location";
                ddlRegLocation.DataValueField = "AddressID";
                ddlRegLocation.DataBind();
                if (lstRegisterLocation.Count == 1)
                {
                    ddlRegLocation.Items.Insert(0, strSelects.Trim());
                    ddlRegLocation.Items[0].Value = "-1";
                }
                else if (lstRegisterLocation.Count == 0 || lstRegisterLocation.Count > 1)
                {
                    ddlRegLocation.Items.Insert(0, strSelects.Trim());
                    ddlRegLocation.Items[0].Value = "-1";
                }
            }

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
                if (CID > 0)
                {
                    ddClientName.DataSource = lstSourceName;
                    ddClientName.DataTextField = "ClientName";
                    ddClientName.DataValueField = "ClientID";
                    ddClientName.DataBind();
                    ddClientName.Items.Insert(0, strSelects.Trim());
                    ddClientName.Items[0].Value = "-1";
                    ddClientName.SelectedValue = CID.ToString();
                    ddClientName.Attributes.Add("disabled", "true");
                }
                else
                {
                    ddClientName.DataSource = lstSourceName;
                    ddClientName.DataTextField = "ClientName";
                    ddClientName.DataValueField = "ClientID";
                    ddClientName.DataBind();
                    ddClientName.Items.Insert(0, strSelects.Trim());
                    ddClientName.Items[0].Value = "-1";
                }
            }
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing LoadSourceName() in Lab_Home_page ", e);
        }
    }

    public void LoadInvSampleMaster()
    {
        try
        {
            long returnCode = -1;
            Investigation_BL objInvestigationBL = new Investigation_BL(base.ContextInfo);
            List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
            returnCode = objInvestigationBL.GetInvSampleMaster(OrgID, out lstInvSampleMaster);
            if (lstInvSampleMaster.Count > 0)
            {
                ddlSample.DataSource = lstInvSampleMaster;
                ddlSample.DataTextField = "SampleDesc";
                ddlSample.DataValueField = "SampleCode";
                ddlSample.DataBind();
                ddlSample.Items.Insert(0, strSelects.Trim());
                ddlSample.Items[0].Value = "-1";
            }
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing LoadInvSampleMaster in PendingSampleCollection_aspx_cs ", e);
        }
    }

    

    private string GetToolTip(List<OrderedInvestigations> InvestigationList)
    {
        string TableHead = "";
        string TableDate = "";
        TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\">"
            //+ "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List For this task</td></tr>"
        + "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation</td><td>Type</td></tr>";
        foreach (var Item in InvestigationList)
        {
            TableDate += "<tr>  <td>" + Item.InvestigationName + "</td>"
                        + "<td>" + Item.Type + "</td></tr>";
        }
        return TableHead + TableDate + "</table> ";
    }

    public void LoadReasons()
    {
        List<InvReasonMasters> lstInvReasonMaster = new List<InvReasonMasters>();
        returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(OrgID, out lstInvReasonMaster);
        hdnReasonList.Value = "";

        //lstInvReasonMaster.RemoveAll(P => P.StatusID != 4);
        lstInvReasonMaster = lstInvReasonMaster.FindAll(P => P.ReasonTypeCode == "SREJ" || P.ReasonTypeCode == "PS");
        ddlReason.DataSource = lstInvReasonMaster;
        ddlReason.DataTextField = "ReasonDesc";
        ddlReason.DataValueField = "ReasonID";
        ddlReason.DataBind();


        ddlReason.Items.Insert(0, new ListItem(strSelect.Trim(), "0"));

    }

    

    private void LoadGridAction(List<CollectedSample> lstInvestigationSamples)
    {
        try
        {
            ddlAction.Items.Clear();

            if (lstInvestigationSamples.Count > 0)
            {
                int menuType = Convert.ToInt32(TaskHelper.SearchType.SampleSearch);
                List<ActionMaster> lstActionMaster = new List<ActionMaster>();

                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, menuType, out lstActionMaster);
                if (lstActionMaster.Count > 0)
                {
                    if (!chkAberrant.Checked)
                    {
                        if (lstActionMaster.Exists(p => p.ActionCode == "Collect_Sample_SampleSearch"))
                        {
                            lstActionMaster.RemoveAt(lstActionMaster.FindIndex(p => p.ActionCode == "Collect_Sample_SampleSearch"));
                        }
                    }
                    else
                    {
                        if (lstActionMaster.Exists(p => p.ActionCode == "Reject_Sample_SampleSearch"))
                        {
                            lstActionMaster.RemoveAt(lstActionMaster.FindIndex(p => p.ActionCode == "Reject_Sample_SampleSearch"));
                        }
                    }
                    if (slidebarcode == "Y")
                    {
                        hdnslidebarcode.Value = "Y";
                        ddlAction.DataSource = lstActionMaster;
                        ddlAction.DataTextField = "ActionName";
                        ddlAction.DataValueField = "ActionCode";
                    }
                    else
                    {
                        ddlAction.DataSource = lstActionMaster;
                        ddlAction.DataTextField = "ActionName";
                        ddlAction.DataValueField = "ActionCode";

                    }
                    ddlAction.DataBind();
                    ddlAction.Items.Insert(0, new ListItem(strSelect.Trim(), "0"));
                    //ddlAction.Visible = true;
                    btnGo.Visible = true;
                    pnlFooter.Visible = true;
                    ShowAndHide();
                }
                else
                {
                    pnlFooter.Visible = false;
                }
                lstActionsMaster = lstActionMaster.ToList();
                grdSample.DataSource = lstInvestigationSamples;
                //if (OrgID == 71)
                //{
                //    grdSample.Columns[14].Visible = true;
                //}
                //else
                //{
                //    grdSample.Columns[14].Visible = false;
                //}
                grdSample.DataBind();
                pnlSampleList.Visible = true;
                lblStatus.Visible = false;
            }
            else
            {
                // pnlSampleList.Visible = false;
                pnlFooter.Visible = false;
                lblStatus.Visible = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save PendingSampleCollection", ex);
        }
    }
    
    
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;

            string domains = "Preference,samplesearchtype,VisitType,Priority,Slides";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "Preference"
                                 orderby child.DisplayText ascending
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlPrefrence.DataSource = childItems;
                    ddlPrefrence.DataTextField = "DisplayText";
                    ddlPrefrence.DataValueField = "Code";
                    ddlPrefrence.DataBind();
                    ddlPrefrence.SelectedValue = "All";
                }
                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "samplesearchtype"
                                  orderby child.DisplayText ascending
                                  select child;
                if (childItems1.Count() > 0)
                {
                    ddlType.DataSource = childItems1;
                    ddlType.DataTextField = "DisplayText";
                    ddlType.DataValueField = "Code";
                    ddlType.DataBind();                    
                }

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "VisitType"
                                  orderby child.DisplayText ascending
                                  select child;
                if (childItems2.Count() > 0)
                {
                    ddVisitType.DataSource = childItems2;
                    ddVisitType.DataTextField = "DisplayText";
                    ddVisitType.DataValueField = "Code";
                    ddVisitType.DataBind();
                    ddVisitType.Items.Remove((ddVisitType.Items.FindByValue("-1")));
                    ListItem li = new ListItem();
                    li.Text = strSelect;
                    li.Value = "-1";
                    ddVisitType.Items.Insert(0, li);
                }
                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "Priority"
                                  orderby child.DisplayText ascending
                                  select child;
                if (childItems3.Count() > 0)
                {
                    ddlPriority.DataSource = childItems3;
                    ddlPriority.DataTextField = "DisplayText";
                    ddlPriority.DataValueField = "Code";
                    ddlPriority.DataBind();
                    ddlPriority.Items.Remove((ddlPriority.Items.FindByValue("1")));
                    ListItem li = new ListItem();
                    li.Text = strSelect;
                    li.Value = "-1";
                    ddlPriority.Items.Insert(0, li);                   
                }
				var child_Items = from child in lstmetadataOutput
                                 where child.Domain == "Slides"
                                 orderby child.DisplayText ascending
                                 select child;
                if (child_Items.Count() > 0)
                {
                    CheckBox_Slide.DataSource = child_Items;
                    CheckBox_Slide.DataTextField = "DisplayText";
                    CheckBox_Slide.DataValueField = "Code";
                    CheckBox_Slide.DataBind();
                    Check_boxslide.DataSource = child_Items;
                    Check_boxslide.DataTextField = "DisplayText";
                    Check_boxslide.DataValueField = "Code";
                    Check_boxslide.DataBind();
                    
                }
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data  ", ex);
        }
    }
    public DataTable loaddata(List<OutsourcingDetail> lstOutSourcingDetails)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("Patient");
        DataColumn dcol2 = new DataColumn("Visit Number");
        DataColumn dcol3 = new DataColumn("Sample");
        DataColumn dcol4 = new DataColumn("Vacutainer/Additive");
        DataColumn dcol5 = new DataColumn("SID");
        DataColumn dcol6 = new DataColumn("Status");
        DataColumn dcol7 = new DataColumn("Processing Location");
        DataColumn dcol8 = new DataColumn("Collected Location");
        DataColumn dcol9 = new DataColumn("OutSourcing Location");
        DataColumn dcol10 = new DataColumn("OutSourcing Date");
        DataColumn dcol11 = new DataColumn("Received Date");


        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);
        dt.Columns.Add(dcol9);
        dt.Columns.Add(dcol10);
        dt.Columns.Add(dcol11);

        foreach (OutsourcingDetail item in lstOutSourcingDetails)
        {
            DataRow dr = dt.NewRow();
            dr["Patient"] = item.PatientName;
            dr["Visit Number"] = item.PatientNumber;
            dr["Sample"] = item.SampleDesc;
            dr["Vacutainer/Additive"] = item.SampleContainerName;
            dr["SID"] = item.BarcodeNumber;
            dr["Status"] = item.InvSampleStatusDesc;
            // dr["Reason"] = item.Reason;
            dr["Processing Location"] = item.LocationName;
            dr["Collected Location"] = item.CollectedLocationName;
            dr["OutSourcing Location"] = item.OutSourcedOrgName;
            dr["OutSourcing Date"] = item.OutsourcedDate.ToString("dd/MMM/yy hh:mm tt");
            dr["Received Date"] = item.ReceivedDate.ToString("dd/MMM/yy hh:mm tt");
            dt.Rows.Add(dr);
        }
        ViewState["report"] = dt;
        return dt;
    }
    

    public void GetOutSourcedLocations()
    {
        try
        {
            long returnCode = -1;
            int orgid = OrgID;
            Investigation_BL InvBL = new Investigation_BL(base.ContextInfo);

            returnCode = InvBL.GetOutSourcedLocations(orgid, out lstLabRefOrg);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetOutSourcedLocations", ex);
        }
    }

    string strAllSelect = Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_04 == null ? "-----ALL-----" : Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_04;
    public void LoadOutSourcedLocations()
    {
        try
        {
            GetOutSourcedLocations();
            ddlOutSourcedLocations.DataSource = lstLabRefOrg;
            ddlOutSourcedLocations.DataTextField = "RefOrgName";
            ddlOutSourcedLocations.DataValueField = "LabRefOrgID";
            ddlOutSourcedLocations.DataBind();
            ddlOutSourcedLocations.Items.Insert(0, strAllSelect.Trim());
            ddlOutSourcedLocations.Items[0].Value = "0";

            ddloutlocation.DataSource = lstLabRefOrg;
            ddloutlocation.DataTextField = "RefOrgName";
            ddloutlocation.DataValueField = "LabRefOrgID";
            ddloutlocation.DataBind();
           
            ddloutlocation.Items.Insert(0, strSelects);
            ddloutlocation.Items[0].Value = "0";


            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string strClientMaster = serializer.Serialize(lstLabRefOrg);
            Session["OutSourceLocations"] = strClientMaster;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadOutSourcedLocations", ex);
        }
    }
    
    public void ShowAndHide()
    {
        string SampleStatus = ddlSampleStatus.SelectedValue.ToString();
        if (SampleStatus == "12")
        {
            if (RdoSendOutSource.Checked == true)
            {
                foreach (ListItem item in ddlAction.Items)
                {
                    item.Attributes.Remove("disabled");
                    if (item.Value == "Capture_OutSourcing_Details")
                    {
                        item.Attributes.Add("disabled", "disabled");
                    }
                }

            }
            else if (RdoReceiveOutSource.Checked == true)
            {
                foreach (ListItem item in ddlAction.Items)
                {
                    item.Attributes.Remove("disabled");
                    if (item.Value == "Send_Outsource_Details")
                    {
                        item.Attributes.Add("disabled", "disabled");
                    }
                    if (item.Value == "Force_Outsource")
                    {
                        item.Attributes.Add("disabled", "disabled");
                    }


                }

            }
        }
        if (SampleStatus == "8")
        {
            foreach (ListItem item in ddlAction.Items)
            {

                if (item.Value == "Send_Outsource_Details" || item.Value == "Capture_OutSourcing_Details" || item.Value == "Collect_Sample_SampleSearch" || item.Value == "Outsource_Upload_Document")
                {
                    item.Attributes.Add("disabled", "disabled");
                }
            }

        }
    }
    
    public void ApproveTaskCreation()
    {
        try
        {
            Tasks task = new Tasks();
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();

            Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
            returnCode = -1;
            long taskreturncode = -1;
            string gUID = string.Empty;
            long createTaskID = -1;
            Investigation_BL DemoBL;

            long vid = -1;
            long patientID = -1;
            Int64.TryParse(hdnPatientVisitID.Value, out vid);

            DemoBL = new Investigation_BL(base.ContextInfo);

            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(vid, out lstPatientVisitDetails);
            if (lstPatientVisitDetails.Count > 0)
            {
                patientID = lstPatientVisitDetails[0].PatientID;
                List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                returnCode = DemoBL.GetPatientInvestigationStatus(vid, OrgID, out lstPatientInvestigation);
                int validatedCount = 0;
                validatedCount = (from IL in lstPatientInvestigation
                                  where IL.Status != InvStatus.Validate && IL.Status != InvStatus.Approved && IL.Status != InvStatus.Coauthorize
                                  && IL.Status != InvStatus.SecondOpinion && IL.Status != "PartiallyValidated" && IL.Status != InvStatus.Cancel
                                  && IL.Status != InvStatus.Coauthorized && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.WithHeld
                                  && IL.Status != InvStatus.Notgiven && IL.Status != InvStatus.WithholdValidation && IL.Status != "ReflexTest"
                                  && IL.Status != InvStatus.Rejected && IL.Status != "Rejected"
                                  select IL).Count();
                if (validatedCount <= 0)
                {
                    int NeedvalidatedCount = 0;
                    NeedvalidatedCount = (from IL in lstPatientInvestigation
                                          where IL.Status == "PartiallyValidated" || IL.Status == InvStatus.Validate
                                          select IL).Count();
                    if (NeedvalidatedCount > 0)
                    {
                        taskreturncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Validate),
                                vid, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
                                lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                lstPatientInvestigation[0].UID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = vid;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        task.RefernceID = lstPatientInvestigation[0].LabNo;
                        //Create task 

                        taskreturncode = oTasksBL.CreateTask(task, out createTaskID);
                    }
                }
            }
        }
        catch (Exception e)
        {
            CLogger.LogError("Error in while Cancel bill Approve Task Cretaion", e);
        }

    }
    //protected void grdOutSourcedDetails_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    if (e.NewPageIndex != -1)
    //    {
    //        grdOutSourcedDetails.PageIndex = e.NewPageIndex;

    //    }
    //    btnOK_Click(sender, e);
    //}
    string strSampleReject = Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_29 == null ? "Sample Already Rejected" : Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_29;
    
    
    

    public void Barcodesecondlayer(object sender, EventArgs e)
    {
        try
        {

            string strPatientVisitId = string.Empty;
            string strSampleId = string.Empty;
            string strGuid = string.Empty;
            string strSampleStatusID = string.Empty;
            string strTaskID = string.Empty;
            string strAccessionNo = string.Empty;
            if (ddlAction.SelectedValue == "Reject_Sample_SampleSearch")
            {

                if (strSampleStatusID == InvSampleStatus.Rejected.ToString())
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + strSampleReject.Trim() + "','" + AlertType + "');", true);
                    return;
                }
            }

            foreach (GridViewRow item in Gvaliqoutbarcode.Rows)
            {
                List<string> lstVisitID = new List<string>();
                List<string> lstSampleID = new List<string>();

                CheckBox ChkbxSelect = (CheckBox)item.FindControl("ChkbxalioutSelect");
                if (ChkbxSelect.Checked)
                {
                    HiddenField hdnalioutVisitId = (HiddenField)item.FindControl("hdnalioutVisitId");
                    HiddenField hdnalioutSampleId = (HiddenField)item.FindControl("hdnalioutSampleId");
                    HiddenField hdnaliqoutbarcode = (HiddenField)item.FindControl("hdnaliqoutbarcode");
                    TextBox txtSpecimenCount = (TextBox)item.FindControl("txtSpecimenCount");
                    strPatientVisitId = hdnalioutVisitId.Value;
                    strSampleId = hdnalioutSampleId.Value;


                    if (!lstVisitID.Contains(hdnalioutVisitId.Value))
                    {
                        lstVisitID.Add(hdnalioutVisitId.Value);
                    }
                    if (!lstSampleID.Contains(hdnalioutSampleId.Value))
                    {
                        lstSampleID.Add(hdnalioutSampleId.Value);
                    }

                    BarcodeAttributes barcodeattribute = new BarcodeAttributes();
                    //plnfileupload.Visible = false;
                    //divfileupload.Style.Add("display", "none");
                    Panel1.Visible = true;
                    //UpdatePanel1.Visible = true;
                    Panel2.Visible = true;
                    //plnoutsourcedetails.Visible = true;
                    //plnfileupload.Visible = true;

                    QueryMaster objQueryMaster = new QueryMaster();
                    string RedirectURL = string.Empty;
                    string QueryString = string.Empty;
                    if (lstActionsMaster.Exists(p => p.ActionCode == ddlAction.SelectedValue))
                    {
                        QueryString = lstActionsMaster.Find(p => p.ActionCode == ddlAction.SelectedValue).QueryString;
                    }
                    objQueryMaster.Querystring = QueryString;
                    objQueryMaster.PatientVisitID = strPatientVisitId;
                    objQueryMaster.GuId = strGuid;
                    if (strTaskID != "" && strTaskID != "0")
                    {
                        objQueryMaster.TaskID = strTaskID;
                    }
                    else
                    {
                        objQueryMaster.TaskID = "0";
                    }
                    objQueryMaster.SampleCollectAgain = "Y";
                    objQueryMaster.SampleID = strSampleId;
                    objQueryMaster.OrgID = Convert.ToString(OrgID);
                    objQueryMaster.LoginID = Convert.ToString(LID);
                    objQueryMaster.LocID = Convert.ToString(ILocationID);
                    objQueryMaster.PrintAgain = "Y";
                    objQueryMaster.CategoryCode = BarcodeCategory.ContainerRegular;
                    objQueryMaster.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);

                    Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);

                    if (ddlAction.SelectedValue == "Aliquot_SampleSearch")
                    {

                        BarcodeHelper objBarcodeHelper = new BarcodeHelper();
                        List<BarcodeAttributes> lstBarcodeAttributes;
                        //List<BarcodeAttributes> lstBarcodeAttributesTRF;
                        List<PrintBarcode> lstPrintBarcode = new List<PrintBarcode>();
                        PrintBarcode objPrintBarcode;
                        string MachineID = string.Empty;
                        if (Session["MacAddress"] != null)
                        {
                            MachineID = (string)Session["MacAddress"];
                        }

                        if (lstVisitID.Count > 0)
                        {
                            string barcodeType = BarcodeCategory.ContainerRegular;


                            lstBarcodeAttributes = new List<BarcodeAttributes>();

                            if (ddlAction.SelectedValue == "Aliquot_SampleSearch")
                            {


                                string Barcodenumber = string.Empty;
                                int AliquotValue = int.Parse(txtSpecimenCount.Text);
                                Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                                long returncode = -1;

                                for (int i = 0; i < AliquotValue; i++)
                                {
                                    returncode = invbl.PatientInvSampleAliquot(OrgID, Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), hdnaliqoutbarcode.Value, 2, samples, slidevalues);
                                    TxtAliquot.Text = "0";

                                }

                                GateWay objGateWay = new GateWay(base.ContextInfo);



                                int AliquotCount = Convert.ToInt32(TxtAliquot.Text);
                                //objBarcodeHelper.GetBarcodeQueryStringAliqout(OrgID, strPatientVisitId, strSampleId, 0, barcodeType, out lstBarcodeAttributes, AliquotCount, returnStatus);
                                objBarcodeHelper.GetBarcodeQueryString(OrgID, strPatientVisitId, strSampleId, 0, barcodeType, out lstBarcodeAttributes);
                                //objGateWay.Getsequenceno(Convert.ToInt64(strPatientVisitId), OrgID, out returnStatus);

                            }

                            if (lstBarcodeAttributes.Count > 0)
                            {
                                foreach (BarcodeAttributes objBarcodeAttributes in lstBarcodeAttributes)
                                {
                                    objPrintBarcode = new PrintBarcode();
                                    objPrintBarcode.VisitID = objBarcodeAttributes.VisitID;
                                    objPrintBarcode.SampleID = objBarcodeAttributes.SampleID;
                                    objPrintBarcode.BarcodeNumber = objBarcodeAttributes.BarcodeNumber;
                                    objPrintBarcode.MachineID = MachineID;
                                    objPrintBarcode.HeaderLine1 = objBarcodeAttributes.HeaderLine1;
                                    objPrintBarcode.HeaderLine2 = objBarcodeAttributes.HeaderLine2;
                                    objPrintBarcode.FooterLine1 = objBarcodeAttributes.FooterLine1;
                                    objPrintBarcode.FooterLine2 = objBarcodeAttributes.FooterLine2;
                                    //objPrintBarcode.squenceno = objBarcodeAttributes.SequenceID;
                                    lstPrintBarcode.Add(objPrintBarcode);
                                }
                                LoadAliqout(sender, e);
                            }
                            if (lstPrintBarcode.Count > 0)
                            {
                                //if (Session["RegKeyExists"] != null && Convert.ToString(Session["RegKeyExists"]) == "true")
                                //{
                                string barcode = string.Empty;
                                foreach (PrintBarcode oPrintBarcode in lstPrintBarcode)
                                {
                                    if (barcode == string.Empty)
                                    {
                                        barcode = oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
                                    }
                                    else
                                    {
                                        barcode = barcode + "?" + oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
                                    }
                                }
                                if (barcode != string.Empty)
                                {
                                    CLogger.LogInfo("RePrint Barcode :   " + barcode);
                                    iframeBarcode.Attributes["src"] = "attunebarcode:" + barcode;
                                }
                                //}
                                //else
                                //{
                                //GateWay objGateWay = new GateWay(base.ContextInfo);
                                //Int32 returnStatus = -1;
                                //objGateWay.SaveBarcodePrintDetails(lstPrintBarcode, out returnStatus);
                                //}
                            }
                        }
                    }

                    else if (ddlAction.SelectedValue == "Aliquot_SampleSearch")
                    {
                        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                        long returncode = -1;
                        string Barcodenumber = string.Empty;
                        int AliquotValue = int.Parse(TxtAliquot.Text);


                        for (int i = 0; i < AliquotValue; i++)
                        {
                            returncode = invbl.PatientInvSampleAliquot(OrgID, Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), Barcodenumber, 1, samples, slidevalues);




                        }

                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Window", "window.open('../admin/PrintBarcode.aspx?visitId=" + strPatientVisitId + "&sampleId=" + strSampleId + "&guId=" + strGuid + "&orgId=" + OrgID + "&categoryCode=" + BarcodeCategory.ContainerRegular + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
                        if (!String.IsNullOrEmpty(RedirectURL))
                        {
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Window", "window.open('" + RedirectURL + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + strURL.Trim() + "','" + AlertType + "');", true);
                        }
                        TxtAliquot.Style.Add("display", "block");
                    }

                }
            }
            ///ddlAction.SelectedIndex = ddlAction.Items.IndexOf(ddlAction.Items.FindByText("--Select--"));

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Specimen Alioutgeneration", ex);

        }


    }
    public void LoadAliqout(object sender, EventArgs e)
    {
        string strPatientVisitId = string.Empty;
        string strSampleId = string.Empty;
        string strGuid = string.Empty;
        string strSampleStatusID = string.Empty;
        string strTaskID = string.Empty;
        string strAccessionNo = string.Empty;

        foreach (GridViewRow item in grdSample.Rows)
        {
            CheckBox ChkbxSelect = (CheckBox)item.FindControl("ChkbxSelect");
            if (ChkbxSelect.Checked)
            {
                HiddenField hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                HiddenField hfSampleId = (HiddenField)item.FindControl("hdnSampleId");
                HiddenField hfGuid = (HiddenField)item.FindControl("hdnGuid");
                HiddenField hfSampleStatusId = (HiddenField)item.FindControl("hdnInvSampleStatusID");
                HiddenField hfTaskID = (HiddenField)item.FindControl("hdnTaskID");
                HiddenField hfAccessionNo = (HiddenField)item.FindControl("hdnAccessionNo");

                strPatientVisitId = hfVisitId.Value;
                strSampleId = hfSampleId.Value;
                strGuid = hfGuid.Value;
                strSampleStatusID = hfSampleStatusId.Value;
                strTaskID = hfTaskID.Value;
                strAccessionNo = hfAccessionNo.Value;
            }
        }

        if (strPatientVisitId != "")
        {


            List<BarcodeLayer> GetBarcodeOption = new List<BarcodeLayer>();
            Investigation_BL oInvestigationBL = new Investigation_BL(new BaseClass().ContextInfo);
            oInvestigationBL.GetBarcodeLayerOption(Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), out GetBarcodeOption);

            if (GetBarcodeOption.Count > 0)
            {
                Gvaliqoutbarcode.DataSource = GetBarcodeOption;
                if (slidebarcode == "Y")
                {

                }
                else
                {
                    //this.Gvaliqoutbarcode.Columns[1].HeaderText = "Specimen Barcode";
                    //this.Gvaliqoutbarcode.Columns[2].HeaderText = "Specimen Count";
                    Gvaliqoutbarcode.DataBind();
                    ModalPopupExtender2.Show();
                }

            }
            else
            {
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Specimen block not available');", true);
                ModalPopupExtender2.Hide();
                return;
            }


        }


    }


    
    protected void Gvaliqoutbarcode_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //////if (e.Row.RowType == DataControlRowType.Header)
        //////{
        //////    for (int i = 0; i < e.Row.Cells.Count; i++)
        //////    {
        //////        this.Gvaliqoutbarcode.Columns[1].HeaderText = "The";

        //////    }
        //////}
    }


    private void Secondlayer(object sender, EventArgs e)
    {
        try
        {
            string strPatientVisitId = string.Empty;
            string strSampleId = string.Empty;
            string strGuid = string.Empty;
            string strSampleStatusID = string.Empty;
            string strTaskID = string.Empty;
            string strAccessionNo = string.Empty;


            foreach (GridViewRow item in grdSample.Rows)
            {
                List<string> lstVisitID = new List<string>();
                List<string> lstSampleID = new List<string>();
                CheckBox ChkbxSelect = (CheckBox)item.FindControl("ChkbxSelect");
                if (ChkbxSelect.Checked)
                {
                    HiddenField hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                    HiddenField hfSampleId = (HiddenField)item.FindControl("hdnSampleId");
                    HiddenField hdnBarcodeNumber = (HiddenField)item.FindControl("hdnBarcodeNumber");
                    string _BarcodeNumber = hdnBarcodeNumber.Value;
                    strSampleId = hfSampleId.Value;


                    if (!lstVisitID.Contains(hfVisitId.Value))
                    {
                        lstVisitID.Add(hfVisitId.Value);
                    }
                    if (!lstSampleID.Contains(hfSampleId.Value))
                    {
                        lstSampleID.Add(hfSampleId.Value);
                    }

                    BarcodeAttributes barcodeattribute = new BarcodeAttributes();
                    Panel1.Visible = true;

                    Panel2.Visible = true;


                    QueryMaster objQueryMaster = new QueryMaster();
                    string RedirectURL = string.Empty;
                    string QueryString = string.Empty;
                    if (lstActionsMaster.Exists(p => p.ActionCode == ddlAction.SelectedValue))
                    {
                        QueryString = lstActionsMaster.Find(p => p.ActionCode == ddlAction.SelectedValue).QueryString;
                    }
                    objQueryMaster.Querystring = QueryString;
                    objQueryMaster.PatientVisitID = strPatientVisitId;
                    objQueryMaster.GuId = strGuid;
                    if (strTaskID != "" && strTaskID != "0")
                    {
                        objQueryMaster.TaskID = strTaskID;
                    }
                    else
                    {
                        objQueryMaster.TaskID = "0";
                    }
                    objQueryMaster.SampleCollectAgain = "Y";
                    objQueryMaster.SampleID = strSampleId;
                    objQueryMaster.OrgID = Convert.ToString(OrgID);
                    objQueryMaster.LoginID = Convert.ToString(LID);
                    objQueryMaster.LocID = Convert.ToString(ILocationID);
                    objQueryMaster.PrintAgain = "Y";
                    objQueryMaster.CategoryCode = BarcodeCategory.ContainerRegular;
                    objQueryMaster.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);

                    Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);

                    if (ddlAction.SelectedValue == "Aliquot_SampleSearch")
                    {

                        BarcodeHelper objBarcodeHelper = new BarcodeHelper();
                        List<BarcodeAttributes> lstBarcodeAttributes;
                        //List<BarcodeAttributes> lstBarcodeAttributesTRF;
                        List<PrintBarcode> lstPrintBarcode = new List<PrintBarcode>();
                        PrintBarcode objPrintBarcode;
                        string MachineID = string.Empty;
                        if (Session["MacAddress"] != null)
                        {
                            MachineID = (string)Session["MacAddress"];
                        }

                        if (lstVisitID.Count > 0)
                        {
                            string barcodeType = BarcodeCategory.ContainerRegular;


                            lstBarcodeAttributes = new List<BarcodeAttributes>();

                            if (ddlAction.SelectedValue == "Aliquot_SampleSearch")
                            {
                                if (CheckBox_Slide.SelectedValue == "")
                                {

                                }
                                else
                                {
                                    slidevalues = CheckBox_Slide.SelectedItem.Text;
                                }

                                string Barcodenumber = string.Empty;
                                int AliquotValue = int.Parse(TxtAliquot.Text);
                                Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                                long returncode = -1;

                                for (int i = 0; i < AliquotValue; i++)
                                {
                                    returncode = invbl.PatientInvSampleAliquot(OrgID, Convert.ToInt64(hfVisitId.Value), Convert.ToInt32(strSampleId), Convert.ToString(_BarcodeNumber), 2, samples, slidevalues);
                                    TxtAliquot.Text = "0";

                                }
                                GateWay objGateWay = new GateWay(base.ContextInfo);

                                int AliquotCount = Convert.ToInt32(TxtAliquot.Text);

                                objBarcodeHelper.GetBarcodeQueryString(OrgID, strPatientVisitId, strSampleId, 0, barcodeType, out lstBarcodeAttributes);
                            }

                            if (lstBarcodeAttributes.Count > 0)
                            {
                                foreach (BarcodeAttributes objBarcodeAttributes in lstBarcodeAttributes)
                                {
                                    objPrintBarcode = new PrintBarcode();
                                    objPrintBarcode.VisitID = objBarcodeAttributes.VisitID;
                                    objPrintBarcode.SampleID = objBarcodeAttributes.SampleID;
                                    objPrintBarcode.BarcodeNumber = objBarcodeAttributes.BarcodeNumber;
                                    objPrintBarcode.MachineID = MachineID;
                                    objPrintBarcode.HeaderLine1 = objBarcodeAttributes.HeaderLine1;
                                    objPrintBarcode.HeaderLine2 = objBarcodeAttributes.HeaderLine2;
                                    objPrintBarcode.FooterLine1 = objBarcodeAttributes.FooterLine1;
                                    objPrintBarcode.FooterLine2 = objBarcodeAttributes.FooterLine2;

                                    lstPrintBarcode.Add(objPrintBarcode);
                                }
                                LoadAliqout(sender, e);
                            }
                        }
                    }

                    else if (ddlAction.SelectedValue == "Aliquot_SampleSearch")
                    {
                        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                        long returncode = -1;
                        string Barcodenumber = string.Empty;
                        int AliquotValue = int.Parse(TxtAliquot.Text);


                        for (int i = 0; i < AliquotValue; i++)
                        {
                            returncode = invbl.PatientInvSampleAliquot(OrgID, Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), Barcodenumber, 1, samples, slidevalues);

                        }
                        if (!String.IsNullOrEmpty(RedirectURL))
                        {
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Window", "window.open('" + RedirectURL + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:alert('URL Not Found');", true);
                        }
                        TxtAliquot.Style.Add("display", "block");
                    }

                }

            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Specimen Alioutgeneration", ex);

        }
    }

    //added by sudha from lal
    private bool IsNeedToEmailNotifyForSmplRjct()
	    {
	        string status = GetConfigValue("Sample_Reject_Notify", OrgID);
	
	        if (!string.IsNullOrEmpty(status) && status.ToUpper() == "Y")
	            return true;
	
	        return false;
	    }	







    #endregion

}
