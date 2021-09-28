using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Data;
using Attune.Podium.Common;
using System.Xml;
using System.Web.Script.Serialization;

public partial class Lab_ReceiveBatch : BasePage
{
    long returnCode = -1;
    Investigation_BL ObjInvBl = new Investigation_BL();
    static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    public Lab_ReceiveBatch()
        : base("Lab_ReceiveBatch_aspx")
    {
    }

    #region "Common Resource Declare"

    string strAlertType = Resources.Lab_AppMsg.Lab_Header_Alert == null ? "Alert" : Resources.Lab_AppMsg.Lab_Header_Alert;
    string strSelect = Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_01 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_01;

    #endregion

    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            iframeBarcode.Attributes.Remove("src");
            if (!IsPostBack)
            {
                hdnBaseOrgId.Value = OrgID.ToString();
                BindColumnsTogrdBatchSamples();
                BindColumnsTogrdAdditionalBatchSamples();
                txtBatchNo.Focus();
                LoadRegLocation();
                LoadMeatData();
                string sDateTime = OrgDateTimeZone;
                string Date = OrgTimeZone + " 12:00:00 AM";
                txtFrom.Text = Date;
                txtTo.Text = sDateTime;
                GetBatchNumber(0, txtFrom.Text, txtTo.Text, "Transferred");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Lab\\ReceiveBatch.aspx.cs Page_Load()", ex);
        }
    }
    #endregion

    #region "Events"
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        int RegLocid = -1;
        string FromDate = string.Empty;
        string ToDate = string.Empty;
        string BatchStatus = string.Empty;
        try
        {
            if (ddlRegLocation.SelectedValue != "-1" || ddlBatchStatus.SelectedValue != "1")
            {
                RegLocid = Convert.ToInt32(ddlRegLocation.SelectedValue);
                BatchStatus = ddlBatchStatus.SelectedItem.Text;
            }
            else
            {
                RegLocid = 0;
                BatchStatus = "Transferred";
            }
            if (txtFrom.Text != "" && txtTo.Text != "")
            {
                FromDate = txtFrom.Text;
                ToDate = txtTo.Text;
            }
            else
            {
                FromDate = "";
                ToDate = "";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Lab\\ReceiveBatch.aspx.cs btnSearch_Click()", ex);
        }

        GetBatchNumber(RegLocid, FromDate, ToDate, BatchStatus);
    }
    public void GetBatchNumber(long RegLocId, string FromDate, string ToDate, string BatchStatus)
    {
        try
        {
            List<SampleBatchTracker> lstSampleBatchTracker = new List<SampleBatchTracker>();
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetBatchNumbers(RegLocId, FromDate, ToDate, BatchStatus, out lstSampleBatchTracker);
            gvBatchDetails.DataSource = lstSampleBatchTracker;
            gvBatchDetails.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Lab\\ReceiveBatch.aspx.cs btnSearch_Click()", ex);
        }

    }
    protected void gvBatchDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvBatchDetails.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }
    protected void btnReceiveBatch_OnClick(object sender, EventArgs e)
    {
        string strBatchRecived = Resources.Lab_AppMsg.Lab_ReceiveBatch_aspx_06 == null ? "Batch Received Successfully" : Resources.Lab_AppMsg.Lab_ReceiveBatch_aspx_06;

        Investigation_BL ObjInvBl = new Investigation_BL(base.ContextInfo);
        SampleBatchTrackerDetails objSampleBatchTrackerdetails;
        SampleBatchTrackerConflictDetails objSampleBatchConflictDetails;
        List<SampleBatchTrackerDetails> lstSampleBatchTracker = new List<SampleBatchTrackerDetails>();
        List<SampleBatchTrackerConflictDetails> lstSampleBatchConflictDetails = new List<SampleBatchTrackerConflictDetails>();
        string BatchNo = string.Empty;
        long returnCode = -1;
        int newSampleID = 0;
        string[] SampleArray = null;
        string[] AdditonalArray = null;
        try
        {
            if (hdnSampleBatchTrackerDetails.Value != "")
            {
                SampleArray = hdnSampleBatchTrackerDetails.Value.Split(',');
                for (int i = 0; i < SampleArray.Length; i++)
                {
                    objSampleBatchTrackerdetails = new SampleBatchTrackerDetails();
                    Int32.TryParse(SampleArray[i], out newSampleID);
                    objSampleBatchTrackerdetails.SampleID = newSampleID;
                    if (txtBatchNo.Text != "")
                    {
                        objSampleBatchTrackerdetails.BatchNo = txtBatchNo.Text;
                    }
                    lstSampleBatchTracker.Add(objSampleBatchTrackerdetails);
                }
            }
            if (hdnAdditionalSampleBatchTracker.Value != "")
            {
                AdditonalArray = hdnAdditionalSampleBatchTracker.Value.Split(',');
                for (int j = 0; j < AdditonalArray.Length; j++)
                {
                    objSampleBatchConflictDetails = new SampleBatchTrackerConflictDetails();
                    objSampleBatchConflictDetails.BarcodeNumber = AdditonalArray[j];
                    if (txtBatchNo.Text != "")
                    {
                        objSampleBatchConflictDetails.BatchNo = txtBatchNo.Text;
                    }
                    lstSampleBatchConflictDetails.Add(objSampleBatchConflictDetails);
                }
            }
            returnCode = ObjInvBl.UpdateSampleBatchTrackerDetails(lstSampleBatchTracker, lstSampleBatchConflictDetails);
            if (chkBarcodePrint.Checked == true)
            {
                //GetBarcodePrint(txtBatchNo.Text);
                GetBarcodePrint(Convert.ToInt32(hdnBatchId.Value));
                ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "GetSamplesForBatch();", true);
            }
            chkBarcodePrint.Checked = false;
            if (returnCode >= -1)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "javascript:ValidationWindow('" + strBatchRecived.Trim() + "','" + strAlertType.Trim() + "');", true);
                hdnSampleBatchTrackerDetails.Value = "";
                hdnAdditionalSampleBatchTracker.Value = "";
                tblLegends.Style.Add("display", "none");
                txtBatchNo.Text = string.Empty;
                txtSampleBarcode.Text = string.Empty;
                GetBatchNumber(0, txtFrom.Text, txtTo.Text, "Transferred");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Lab\\ReceiveBatch.aspx.cs btnReceiveBatch_OnClick", ex);
        }
    }
    protected void btnReprintBarcode_OnClick(object sender, EventArgs e)
    {
        try
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            string strlstPatientInvSample = hdnLstPatientInvSample.Value;
            //lstPatientInvSample = serializer.Deserialize<List<PatientInvSample>>(strlstPatientInvSample);
            lstPatientInvSample = serializer.Deserialize<List<PatientInvSample>>(strlstPatientInvSample);
            string strPatientVisitId = string.Empty;
            string strSampleId = string.Empty;
            string strGuid = string.Empty;
            string strSampleStatusID = string.Empty;
            string strTaskID = string.Empty;
            string strAccessionNo = string.Empty;
            string strORDStatus = string.Empty;
            string ActionValue = "Reprint_Barcode_SampleSearch";

            if (ActionValue == "Reprint_Barcode_SampleSearch")
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

                foreach (PatientInvSample PIS in lstPatientInvSample)
                {
                    lstVisitID.Add(PIS.PatientVisitID.ToString());
                    lstSampleID.Add(PIS.SampleCode.ToString());
                }
                if (lstVisitID.Count > 0)
                {
                    strPatientVisitId = string.Join(",", lstVisitID.ToArray());
                    strSampleId = string.Join(",", lstSampleID.ToArray());
                    lstBarcodeAttributes = new List<BarcodeAttributes>();
                    objBarcodeHelper.GetBarcodeQueryString(OrgID, strPatientVisitId, strSampleId, 0, BarcodeCategory.ContainerRegular, out lstBarcodeAttributes);
                    if (lstBarcodeAttributes.Count > 0)
                    {
                        int RowID = 1;
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
                            objPrintBarcode.RowID = RowID;
                            objPrintBarcode.TableSeq = 2;
                            lstPrintBarcode.Add(objPrintBarcode);
                            RowID += 1;

                        }
                    }

                    //////objBarcodeHelper.GetBarcodeQueryString(OrgID, strPatientVisitId, strSampleId, 0, BarcodeCategory.TRF, out lstBarcodeAttributes);
                    //////if (lstBarcodeAttributes.Count > 0)
                    //////{
                    //////    List<BarcodeAttributes> lstBarcodeAttributesGroupBy;
                    //////    lstBarcodeAttributesGroupBy = (from S in lstBarcodeAttributes
                    //////                                   group S by new
                    //////                                   {
                    //////                                       S.VisitID,
                    //////                                       S.SampleID,
                    //////                                       S.BarcodeNumber,
                    //////                                       S.HeaderLine1,
                    //////                                       S.HeaderLine2,
                    //////                                       S.FooterLine1,
                    //////                                       S.FooterLine2

                    //////                                   } into g
                    //////                                   select new BarcodeAttributes
                    //////                                   {
                    //////                                       VisitID = g.Key.VisitID,
                    //////                                       SampleID = g.Key.SampleID,
                    //////                                       BarcodeNumber = g.Key.BarcodeNumber,
                    //////                                       HeaderLine1 = g.Key.HeaderLine1,
                    //////                                       HeaderLine2 = g.Key.HeaderLine2,
                    //////                                       FooterLine1 = g.Key.FooterLine1,
                    //////                                       FooterLine2 = g.Key.FooterLine2
                    //////                                   }).Distinct().ToList();

                    //////    foreach (BarcodeAttributes objBarcodeAttributes in lstBarcodeAttributesGroupBy)
                    //////    {
                    //////        objPrintBarcode = new PrintBarcode();
                    //////        objPrintBarcode.VisitID = objBarcodeAttributes.VisitID;
                    //////        objPrintBarcode.SampleID = objBarcodeAttributes.SampleID;
                    //////        objPrintBarcode.BarcodeNumber = objBarcodeAttributes.BarcodeNumber;
                    //////        objPrintBarcode.MachineID = MachineID;
                    //////        objPrintBarcode.HeaderLine1 = objBarcodeAttributes.HeaderLine1;
                    //////        objPrintBarcode.HeaderLine2 = objBarcodeAttributes.HeaderLine2;
                    //////        objPrintBarcode.FooterLine1 = objBarcodeAttributes.FooterLine1;
                    //////        objPrintBarcode.FooterLine2 = objBarcodeAttributes.FooterLine2;
                    //////        objPrintBarcode.RowID = 1;
                    //////        objPrintBarcode.TableSeq = 1;
                    //////        lstPrintBarcode.Add(objPrintBarcode);


                    //////    }
                    //////}


                    List<PrintBarcode> lstPrintBarcodeWithOrder = new List<PrintBarcode>();
                    lstPrintBarcodeWithOrder = (from x in lstPrintBarcode orderby x.VisitID, x.RowID, x.TableSeq select x).ToList();
                    string bulkPrint = "";
                    bulkPrint = GetConfigValue("BarcodePrintJob", OrgID);
                    //if (OrgID == 109)
                    if (bulkPrint == "Y")
                    {
                        GateWay objGateWay = new GateWay(base.ContextInfo);
                        Int32 returnStatus = -1;
                        objGateWay.SaveBarcodePrintDetails(lstPrintBarcodeWithOrder, out returnStatus);
                    }
                    else
                    {
                        if (lstPrintBarcodeWithOrder.Count > 0)
                        {
                            //Changed by Arivalagan kk for cross browser print barcode//
                            //if (Session["RegKeyExists"] != null && Convert.ToString(Session["RegKeyExists"]) == "true")
                            //{
                            String barcode = string.Empty;
                            if (lstPrintBarcodeWithOrder.Count < 10)
                            {
                                foreach (PrintBarcode oPrintBarcode in lstPrintBarcodeWithOrder)
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
                                    iframeBarcode.Attributes["src"] = "attunebarcode:" + barcode;
                                }
                            }
                            else
                            {
                                GateWay objGateWay = new GateWay(base.ContextInfo);
                                Int32 returnStatus = -1;
                                objGateWay.SaveBarcodePrintDetails(lstPrintBarcodeWithOrder, out returnStatus);
                                
                            }
                            //}
                            //else
                            //{
                            GateWay objGateWay1 = new GateWay(base.ContextInfo);
                            Int32 returnStatus1 = -1;
                            objGateWay1.SaveBarcodePrintDetails(lstPrintBarcodeWithOrder, out returnStatus1);
                            CLogger.LogInfo("attunebarcodedone:" + barcode);
                            //}
                            //Changes End by Arivalagan kk for cross browser print baroce//
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Lab\\ReceiveBatch.aspx.cs GetBarcodePrint()", ex);
        }
    }


    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "batchstatus";
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
                                 where child.Domain == "batchstatus"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlBatchStatus.DataSource = childItems;
                    ddlBatchStatus.DataTextField = "DisplayText";
                    ddlBatchStatus.DataValueField = "Code";
                    ddlBatchStatus.DataBind();
                    ddlBatchStatus.Items.Insert(0, strSelect.Trim());
                    ddlBatchStatus.Items[0].Value = "0";

                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    #endregion
    #region "Methods"
    public void LoadRegLocation()
    {
        string strSelect = Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_01 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_01;
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstRegLocation = new List<OrganizationAddress>();
        // Below Current Org Location
        //returnCode = patientBL.GetLocation(OrgID, LID, RoleID, out lstLocation);
        // Below is Trusted Org Location
        returnCode = new Referrals_BL(base.ContextInfo).GetRegisterLocation(OrgID, out lstRegLocation);

        if (lstRegLocation.Count > 0)
        {

            ddlRegLocation.DataSource = lstRegLocation;
            ddlRegLocation.DataTextField = "Location";
            ddlRegLocation.DataValueField = "AddressID";
            ddlRegLocation.DataBind();


            if (lstRegLocation.Count == 1)
            {
                ddlRegLocation.Items.Insert(0, strSelect.Trim());
                ddlRegLocation.Items[0].Value = "-1";
            }
            else if (lstRegLocation.Count == 0 || lstRegLocation.Count > 1)
            {
                ddlRegLocation.Items.Insert(0, strSelect.Trim());
                ddlRegLocation.Items[0].Value = "-1";
            }
        }
    }
    
    private void BindColumnsTogrdBatchSamples()
    {
        string strBatchNo = Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_02 == null ? "Batch No" : Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_02;
        string strVisistNo = Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_03 == null ? "Visit Number" : Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_03;
        string strSampleType = Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_04 == null ? "Sample Type" : Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_04;
        string strPatientName = Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_05 == null ? "Patient Name" : Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_05;
        string strSetOn = Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_06 == null ? "Sent On" : Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_06;
        string strBatchStatus = Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_07 == null ? "BatchStatus" : Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_07;
        string strSampleId = Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_08 == null ? "SampleID" : Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_08;
        string strPaientVisitId = Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_09 == null ? "PatientVisitID" : Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_09;
        string strBarcodeNo = Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_10 == null ? "BarcodeNumber" : Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_10;
        string strCheck = Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_11 == null ? "CheckAll" : Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_11;
        //CheckBox _checkbox = new CheckBox();
        //_checkbox.Attributes.Add("onclick", "SelectAll();");
        //_checkbox.ID = "chkDynamicCheckBox1";
        //DataTable Dt = new DataTable();
        ////Dt.Columns.Add("S.No");
        //Dt.Columns.Add("" + strBatchNo.Trim() + "");
        //Dt.Columns.Add("" + strVisistNo.Trim() + "");
        //Dt.Columns.Add("" + strSampleType.Trim() + "");
        //Dt.Columns.Add("" + strPatientName.Trim() + "");
        //Dt.Columns.Add("" + strSetOn.Trim() + "");
        //Dt.Columns.Add("" + strBatchStatus.Trim() + "");
        //Dt.Columns.Add("" + strSampleId.Trim() + "");
        //Dt.Columns.Add("" + strPaientVisitId.Trim() + "");
        //Dt.Columns.Add("" + strBarcodeNo.Trim() + "");
        //Dt.Columns.Add("" + _checkbox.ToString() + "");
        //Dt.Rows.Add();

        //grdBatchSamples.DataSource = Dt;
        //grdBatchSamples.DataBind();
        //grdBatchSamples.Rows[0].Visible = false;
        grdBatchSamples.Style.Add("visibility", "hidden");
        //grdBatchSamples.Columns[1].Visible=false;
        //grdBatchSamples.Columns[2].Visible = false;
        //grdBatchSamples.Columns[3].Visible = false;
        //grdBatchSamples.Columns[6].Visible = false;
    }

    private void BindColumnsTogrdAdditionalBatchSamples()
    {
        string strBarcodeNumber = Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_10 == null ? "BarcodeNumber" : Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_10;
        string strAddSample = Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_12 == null ? "Add To Sample" : Resources.Lab_ClientDisplay.Lab_ReaciveBatch_aspx_12;

        DataTable Dt = new DataTable();
        Dt.Columns.Add("" + strBarcodeNumber.Trim() + "");
        Dt.Columns.Add("" + strAddSample.Trim() + "");
        Dt.Rows.Add();

        grdAdditionalBatchSamples.DataSource = Dt;
        grdAdditionalBatchSamples.DataBind();
        grdAdditionalBatchSamples.Rows[0].Visible = false;
        grdAdditionalBatchSamples.Style.Add("visibility", "hidden");
    }


    
    
    protected void RedirectBatchNo(object sender, EventArgs e)
    {
        try
        {
            string BatchNo = (sender as LinkButton).CommandArgument;
            txtBatchNo.Text = BatchNo;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallGo", "DisplayTab('RA');", true);
            if (txtBatchNo.Text != "" && txtBatchNo.Text != null)
                ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "GetSamplesForBatch();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Lab\\ReceiveBatch.aspx.cs btnSearch_Click()", ex);
        }

    }
    


    public void GetBarcodePrint(int BatchId)
    {
        try
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            string strlstPatientInvSample = hdnLstPatientInvSample.Value;
            //lstPatientInvSample = serializer.Deserialize<List<PatientInvSample>>(strlstPatientInvSample);
            lstPatientInvSample = serializer.Deserialize<List<PatientInvSample>>(strlstPatientInvSample);
            string strPatientVisitId = string.Empty;
            string strSampleId = string.Empty;
            string strGuid = string.Empty;
            string strSampleStatusID = string.Empty;
            string strTaskID = string.Empty;
            string strAccessionNo = string.Empty;
            string strORDStatus = string.Empty;
            string ActionValue = "Reprint_Barcode_SampleSearch";

            if (ActionValue == "Reprint_Barcode_SampleSearch")
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

                foreach (PatientInvSample PIS in lstPatientInvSample)
                {
                    lstVisitID.Add(PIS.PatientVisitID.ToString());
                    lstSampleID.Add(PIS.SampleCode.ToString());
                }
                if (lstVisitID.Count > 0)
                {
                    strPatientVisitId = string.Join(",", lstVisitID.ToArray());
                    strSampleId = string.Join(",", lstSampleID.ToArray());
                    lstBarcodeAttributes = new List<BarcodeAttributes>();
                    objBarcodeHelper.GetBarcodeQueryString(OrgID, strPatientVisitId, strSampleId, 0, BarcodeCategory.ContainerRegular, out lstBarcodeAttributes);
                    if (lstBarcodeAttributes.Count > 0)
                    {
                        int RowID = 1;
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
                            objPrintBarcode.RowID = RowID;
                            objPrintBarcode.TableSeq = 2;
                            lstPrintBarcode.Add(objPrintBarcode);
                            RowID += 1;

                        }
                    }

                    //////objBarcodeHelper.GetBarcodeQueryString(OrgID, strPatientVisitId, strSampleId, 0, BarcodeCategory.TRF, out lstBarcodeAttributes);
                    //////if (lstBarcodeAttributes.Count > 0)
                    //////{
                    //////    List<BarcodeAttributes> lstBarcodeAttributesGroupBy;
                    //////    lstBarcodeAttributesGroupBy = (from S in lstBarcodeAttributes
                    //////                                   group S by new
                    //////                                   {
                    //////                                       S.VisitID,
                    //////                                       S.SampleID,
                    //////                                       S.BarcodeNumber,
                    //////                                       S.HeaderLine1,
                    //////                                       S.HeaderLine2,
                    //////                                       S.FooterLine1,
                    //////                                       S.FooterLine2

                    //////                                   } into g
                    //////                                   select new BarcodeAttributes
                    //////                                   {
                    //////                                       VisitID = g.Key.VisitID,
                    //////                                       SampleID = g.Key.SampleID,
                    //////                                       BarcodeNumber = g.Key.BarcodeNumber,
                    //////                                       HeaderLine1 = g.Key.HeaderLine1,
                    //////                                       HeaderLine2 = g.Key.HeaderLine2,
                    //////                                       FooterLine1 = g.Key.FooterLine1,
                    //////                                       FooterLine2 = g.Key.FooterLine2
                    //////                                   }).Distinct().ToList();

                    //////    foreach (BarcodeAttributes objBarcodeAttributes in lstBarcodeAttributesGroupBy)
                    //////    {
                    //////        objPrintBarcode = new PrintBarcode();
                    //////        objPrintBarcode.VisitID = objBarcodeAttributes.VisitID;
                    //////        objPrintBarcode.SampleID = objBarcodeAttributes.SampleID;
                    //////        objPrintBarcode.BarcodeNumber = objBarcodeAttributes.BarcodeNumber;
                    //////        objPrintBarcode.MachineID = MachineID;
                    //////        objPrintBarcode.HeaderLine1 = objBarcodeAttributes.HeaderLine1;
                    //////        objPrintBarcode.HeaderLine2 = objBarcodeAttributes.HeaderLine2;
                    //////        objPrintBarcode.FooterLine1 = objBarcodeAttributes.FooterLine1;
                    //////        objPrintBarcode.FooterLine2 = objBarcodeAttributes.FooterLine2;
                    //////        objPrintBarcode.RowID = 1;
                    //////        objPrintBarcode.TableSeq = 1;
                    //////        lstPrintBarcode.Add(objPrintBarcode);


                    //////    }
                    //////}


                    List<PrintBarcode> lstPrintBarcodeWithOrder = new List<PrintBarcode>();
                    lstPrintBarcodeWithOrder = (from x in lstPrintBarcode orderby x.VisitID, x.RowID, x.TableSeq select x).ToList();
                    string bulkPrint = "";
                    bulkPrint = GetConfigValue("BarcodePrintJob", OrgID);
                    //if (OrgID == 109)
                    if(bulkPrint=="Y")
                    {
                        GateWay objGateWay = new GateWay(base.ContextInfo);
                        Int32 returnStatus = -1;
                        objGateWay.SaveBarcodePrintDetails(lstPrintBarcodeWithOrder, out returnStatus);
                    }
                    else
                    {
                    if (lstPrintBarcodeWithOrder.Count > 0)
                    {
                        //Changed by Arivalagan kk for cross browser print barcode//
                        //if (Session["RegKeyExists"] != null && Convert.ToString(Session["RegKeyExists"]) == "true")
                        //{
                        String barcode = string.Empty;
                        if (lstPrintBarcodeWithOrder.Count <10)
                        {
                            foreach (PrintBarcode oPrintBarcode in lstPrintBarcodeWithOrder)
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
								var sbar="attunebarcode:" + barcode;
                                iframeBarcode.Attributes["src"] = "attunebarcode:" + barcode;
								
								 ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_004", "javascript:SetBarcodeSamplesForBatch('"+sbar+"');", true);
                                }
                            }
                            else
                            {
                                GateWay objGateWay = new GateWay(base.ContextInfo);
                                Int32 returnStatus = -1;
                                objGateWay.SaveBarcodePrintDetails(lstPrintBarcodeWithOrder, out returnStatus);
                                if (BatchId != null)
                                {
                                    var sbar="attunebarcode:" + "BATCH" + BatchId;
                                iframeBarcode.Attributes["src"] = "attunebarcode:" + "BATCH" + BatchId;
								ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_004", "javascript:SetBarcodeSamplesForBatch('"+sbar+"');", true);
								}
                            }
                            //}
                            //else
                            //{
                        GateWay objGateWay1 = new GateWay(base.ContextInfo);
                        Int32 returnStatus1 = -1;
                        objGateWay1.SaveBarcodePrintDetails(lstPrintBarcodeWithOrder, out returnStatus1);
                        CLogger.LogInfo("attunebarcodedone:" + barcode);
                            //}
                            //Changes End by Arivalagan kk for cross browser print baroce//
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Lab\\ReceiveBatch.aspx.cs GetBarcodePrint()", ex);
        }
    }
    #endregion

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
}
