using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.IO;
using Attune.Podium.BillingEngine;
using System.Data;
using System.Text;
using System.Security.Cryptography;
using System.Collections;
using System.Web.Caching;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using System.Xml;
using System.Web.Script.Serialization;
using Attune.Podium.EMR;
using Attune.Podium.PerformingNextAction;
using System.Text.RegularExpressions;

public partial class Billing_WortixLabQuickBilling : BasePage, IDisposable
{
    public Billing_WortixLabQuickBilling()
        : base("Billing_WortixLabQuickBilling_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    BillingEngine billingEngineBL;
    Physician_BL PhysicianBL;
    List<Salutation> lstTitles = new List<Salutation>();
    List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
    List<PatientRedemDetails> lstPatientRedemDetails = new List<PatientRedemDetails>();
    List<Country> lstNationality = new List<Country>();
    List<Country> lstCountries = new List<Country>();
    List<BillingFeeDetails> lstDetails = new List<BillingFeeDetails>();
    Patient objPatient = new Patient();
    FinalBill objFinalBill = new FinalBill();
    PatientRedemDetails PatientRedeem = new PatientRedemDetails();
    string AgeUnit = string.Empty, BillNumber = string.Empty, Labno = string.Empty, pathname = string.Empty;
    long patientID = -1, returnCode = -1;
    int AgeValue = 0, ClientID = 0; long pClientID = -1;
    string SetDefaultClient = string.Empty;
    string strHealthCoupon = string.Empty;
    DateTime dtSampleDate;
    #region "Common Resource Property"

    string strSelect = Resources.Billing_ClientDisplay.Billing_LabQuickBilling_aspx_03 == null ? "--Select--" : Resources.Billing_ClientDisplay.Billing_LabQuickBilling_aspx_03;
    string strAlert = Resources.Billing_AppMsg.Billing_Header_Alert == null ? "Alert" : Resources.Billing_AppMsg.Billing_Header_Alert;

    #endregion
    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        string strSpecimenCount = Resources.Billing_ClientDisplay.Billing_LabQuickBilling_aspx_01 == null ? "Specimen Count" : Resources.Billing_ClientDisplay.Billing_LabQuickBilling_aspx_01;
        string strRoundNo = Resources.Billing_ClientDisplay.Billing_LabQuickBilling_aspx_02 == null ? "Round No" : Resources.Billing_ClientDisplay.Billing_LabQuickBilling_aspx_02;
        string strUpdate = Resources.Billing_ClientDisplay.Billing_LabQuickBilling_aspx_04 == null ? "Update" : Resources.Billing_ClientDisplay.Billing_LabQuickBilling_aspx_04;
        ddlRate.Items.Insert(0, strSelect.Trim());
        iframeBarcode.Attributes.Remove("src");
        string BookingNumber = string.Empty;
        PhysicianBL = new Physician_BL(base.ContextInfo);
        hdnOrgID.Value = OrgID.ToString();
        ddSalutation.Focus();
        string strDiscounthide = GetConfigValue("IsDisabledDiscount", OrgID);
        hdnCheckIsDiscout.Value = strDiscounthide == "Y" ? "Y" : "N";
        string strPatientcapturehistory = GetConfigValue("IsCapturePatientHistory", OrgID);
		 String strIsComReg = GetConfigValue("IsIncompleteRegistration", OrgID);
        if (strIsComReg=="Y")
        {
            chkIncomplete.Attributes.Add("style", "display:block");
        }
        hdnConfigCapturehistory.Value = strPatientcapturehistory == "Y" ? strPatientcapturehistory : "N";
        if (hdnConfigCapturehistory.Value == "Y")
        {
            Patient_BL ObjBL = new Patient_BL(new BaseClass().ContextInfo);
            List<CapturePatientHistory> lstHistoryAttributes = new List<CapturePatientHistory>();
            ObjBL.LoadAndCheckCapturePatientHistory(OrgID, -1, "LoadPHP", out lstHistoryAttributes);
            hdnloadhistory.Value = Newtonsoft.Json.JsonConvert.SerializeObject(lstHistoryAttributes);
        }
        string capturehistoryConfig = GetConfigValue("IsCapturePatientHistory", OrgID);
        if (capturehistoryConfig == "Y")
        {
            tdPatientHistory.Attributes.Add("style", "display:block;");

        }
        else
        {
            tdPatientHistory.Attributes.Add("style", "display:none;");
        }
        if (!IsPostBack)
        {
            loadRateSubTypeMapping();
            // LoadDefaultClientName();
            AutoCompleteExtenderRefPhy.ContextKey = "RPH";
            AutoCompleteExtenderClientCorp.ContextKey = "CLI";
            AutoCompleteExtenderReferringHospital.ContextKey = OrgID.ToString();
            AutoCompleteExtenderPhlebo.ContextKey = OrgID.ToString();
            AutoCompleteExtenderLogi.ContextKey = OrgID.ToString() + "~" + "LOGI" + "~" + "-1";
            AutoCompleteExtenderPatient.ContextKey = OrgID.ToString() + '~' + patientID.ToString();
            AutoCompleteExtenderVisitNo.ContextKey = OrgID.ToString() + "~" + patientID.ToString() + "~" + "8" + "~" + pClientID.ToString();
            ddSalutation.Attributes.Add("onchange", "setSexValueQBLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "' ,'" + ddMarital.ClientID.ToString() + "','" + "" + "');");
            //ddlSex.Attributes.Add("onchange", "setSalutationValueQBLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "' ,'" + ddMarital.ClientID.ToString() + "','" + "ddlgender" + "');");
            ddlSex.Attributes.Add("onchange", "setSalutationValueQBLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
            ddlSex.Attributes.Add("onfocus", "GetGenderValue('" + ddlSex.ClientID.ToString() + "');");
            //tDOB.Attributes.Add("onchange", "ExcedDate('" + tDOB.ClientID.ToString() + "','',0,0);");
            LoadQuickBillLoading();
            hdnDecimalAgeConfig.Value = GetConfigValue("DecimalAge", OrgID);
            ///*****************Added By Arivalagan k************///
            //---Phlebotomist Name set Mandatory for Anjana Org
            String PhleboNameMandatory;
            String DofromVisitfreeze;
            hdncollectcashforcreditclient.Value = GetConfigValue("collectcashforcreditclient", OrgID);
            DofromVisitfreeze = GetConfigValue("DofromVisitfreeze", OrgID);
            if (DofromVisitfreeze == "Y")
            {
                hdnDofromVisitfreeze.Value = "Y";
            }
            else
            {
                hdnDofromVisitfreeze.Value = "N";
            }

            PhleboNameMandatory = GetConfigValue("IsPhleboNameMandatory", OrgID);
            if (PhleboNameMandatory != "" && PhleboNameMandatory != null)
            {
                HdnPhleboNameMandatory.Value = PhleboNameMandatory;
            }
            else
            {
                HdnPhleboNameMandatory.Value = "N";
            }
            if (HdnPhleboNameMandatory.Value != "N")
            {
                hdnPhlebotomist.Value = "Y";
                hideStar.Attributes.Add("style", "display:block;");
            }
            else
            {
                hideStar.Attributes.Add("style", "display:none;");
                hdnPhlebotomist.Value = "N";
            }
            //--End
            String DueBillalertMsg = GetConfigValue("DueBillShowHide", OrgID);
            DueBillalertMsg = GetConfigValue("DueBillShowHide", OrgID);
            if (DueBillalertMsg != "" && DueBillalertMsg != "N")
            {
                HdnDueBillalertMsg.Value = DueBillalertMsg;
            }
            else { HdnDueBillalertMsg.Value = "N"; }
            ///************************End*********************///
            string strRate = GetConfigValue("ShowRateType", OrgID);

            if (strRate == "Y")
            {
                trRate.Attributes.Add("display", "table-row");
            }
            else
            {
                trRate.Attributes.Add("display", "none");
            }
            string SpecimenCount = GetConfigValue("SpecimenCount", OrgID);

            if (SpecimenCount == "Y")
            {
                lblRoundNo.Text = strSpecimenCount.Trim();
                hdnRoundNo.Value = "Y";
            }
            else
            {
                lblRoundNo.Text = strRoundNo.Trim();
                hdnRoundNo.Value = "N";
            }
            string mindue = GetConfigValue("MinimumDuepayment", OrgID);
            hdnMinimumDue.Value = mindue;
            string mindueper = GetConfigValue("MinimumDuePercent", OrgID);
            hdnMinimumDuePercent.Value = mindueper;
            hdnIsReceptionPhlebotomist.Value = GetConfigValue("IsReceptionPhlebotomist", OrgID);
            if (Request.QueryString["RCP"] == "Y")
                hdnIsReceptionPhlebotomist.Value = "Y";
            if (Request.QueryString["RCP"] == "Y")
            {
                TrDoFromVisit.Style.Add("display", "table-row");
            }
            else
            {
                TrDoFromVisit.Style.Add("display", "none");
            }
            if (hdnIsReceptionPhlebotomist.Value == "N")
            {
                trCollectSample.Attributes.Add("display", "none");
            }
            string IsBarCodeNeed = GetConfigValue("PrintSampleBarcode", OrgID);
            if (IsBarCodeNeed == "Y")
            {
                ctlCollectSample.IsBarcodeNeeded = true;
            }

            string isExternalVisitID = ""; // GetConfigValue("ExternalVisitID", OrgID); commented by venky external visitid mantatory default hide from product
            if (isExternalVisitID == "Y")
            {
                trExternalVisitID.Visible = true;
            }
            else
            {
                trExternalVisitID.Visible = false;
            }

            string isApprovalNo = GetConfigValue("ApprovalNo", OrgID);
            if (isApprovalNo == "Y")
            {
                trApprovalNo.Visible = true;
            }
            else
            {
                trApprovalNo.Visible = false;
            }
            string rval, roundpattern, rrval, rroundpattern;
            rval = GetConfigValue("roundoffpatamt", OrgID);//Round off is done by config value(orgbased)
            roundpattern = GetConfigValue("patientroundoffpattern", OrgID);
            rrval = GetConfigValue("RoundOffTPAAmt", OrgID);
            rroundpattern = GetConfigValue("TPARoundOffPattern", OrgID);
            hdnDefaultRoundoff.Value = rval;
            hdnTpaRoundoff.Value = rrval;
            hdnRoundOffType.Value = roundpattern;
            hdnTpaRoundOffType.Value = rroundpattern;

            if (Request.QueryString["PID"] != null)
            {
                if (Request.QueryString["HC"] != null)
                {
                    BookingNumber = Request.QueryString["BKNO"];
                    hdnBookingNo.Value = BookingNumber;
                    Int64.TryParse(Request.QueryString["PID"], out patientID);
                    if (patientID == -1)
                    {
                        List<Bookings> lstHomeCollectionDetails = new List<Bookings>();
                        long BKNo = Convert.ToInt64(Request.QueryString["BKNO"]);
                        string pType = string.Empty;
                        new Investigation_BL(base.ContextInfo).GetHomeCollectionPatientDetails(BKNo, pType, out lstHomeCollectionDetails);
                        if (lstHomeCollectionDetails.Count > 0)
                        {
                            txtName.Text = lstHomeCollectionDetails[0].PatientName;
                            txtDOBNos.Text = lstHomeCollectionDetails[0].Age.Split(' ')[0];
                            ddlDOBDWMY.SelectedValue = lstHomeCollectionDetails[0].Age.Split(' ')[1];
                            ddlSex.SelectedValue = lstHomeCollectionDetails[0].SEX;
                            txtMobileNumber.Text = lstHomeCollectionDetails[0].PhoneNumber;
                            txtAddress.Text = lstHomeCollectionDetails[0].CollectionAddress;
                            txtSuburban.Text = lstHomeCollectionDetails[0].CollectionAddress2;
                            txtCity.Text = lstHomeCollectionDetails[0].City;
                            trDispType.Style.Add("display", "table-row");
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "StatusAlert", "setDOBYear('" + txtDOBNos.ClientID.ToString() + "');", true);
                        }
                    }
                    else
                    {
                        if (Request.QueryString["PNAME"] != null)
                        {
                            hdnPatientName.Value = Request.QueryString["PNAME"].ToString();
                        }
                        hdnPatientID.Value = patientID.ToString();
                        AutoCompleteExtenderPatient.ContextKey = OrgID.ToString() + '~' + patientID.ToString();
                        ScriptManager.RegisterStartupScript(Page, GetType(), "callEdit", "javascript:SelectedPatientEdit();", true);
                    }
                    trSampleTRFPart.Style.Add("display", "table-row");
                }
                else
                {
                    Int64.TryParse(Request.QueryString["PID"], out patientID);
                    if (Request.QueryString["PNAME"] != null)
                    {
                        hdnPatientName.Value = Request.QueryString["PNAME"].ToString();
                    }
                    if (Request.QueryString["VID"] != null)
                    {
                        hdnVisitID.Value = Request.QueryString["VID"].ToString();
                    }
                    hdnPatientID.Value = patientID.ToString();
                    hdnRoleName.Value = RoleName;
                    string RName;
                    RName = GetConfigValue("EditDisable", OrgID);
                    rval = GetConfigValue("roundoffpatamt", OrgID);
                    if (RName == "Y")
                    {
                        hdnRoleName.Value = RoleName;
                    }
                    else
                    {
                        hdnRoleName.Value = "";
                    }
                    AutoCompleteExtenderPatient.ContextKey = OrgID.ToString() + '~' + patientID.ToString();
                    ScriptManager.RegisterStartupScript(Page, GetType(), "callEdit", "javascript:SelectedPatientEdit();", true);
                    string CPEDIT = string.Empty;
                    CPEDIT = Request.QueryString["CPEDIT"];
                    string GR = Request.QueryString["GR"];
                    if (GR == "Y")
                    {
                        ddlSex.Enabled = false;
                    }
                    if (CPEDIT != "Y")
                    {
                        trCollectSample.Style.Add("display", "none");
                        trOrderCalcPart.Style.Add("display", "none");
                        tdClientPart.Style.Add("display", "table-cell");
                        tdClientParttxt.Style.Add("display", "table-cell");
                        //trSampleTRFPart.Style.Add("display", "block");
                        tdRefHosPart.Style.Add("display", "table-cell");
                        tdRefHosParttxt.Style.Add("display", "table-cell");
                        tdRefDrPart.Style.Add("display", "table-cell");
                        tdRefDrParttxt.Style.Add("display", "table-cell");
                        btnGenerate.Text = strUpdate.Trim();
                        hdnIsEditMode.Value = "Y";
                        trPatientPriorityPart.Style.Add("display", "table-row");
                        trUrnType.Style.Add("display", "table-row");
                        ViewTRF.Attributes.Add("style", "display:block");
                        //trEditRemarks.Style.Add("display", "block");
                        //trDispType.Style.Add("display", "block");
                        //trVisitTypePart.Style.Add("display", "block");
                        btnBack.Style.Add("display", "block");
                        if (Request.QueryString["VS"] != null)
                        {
                            trVisitTypePart.Style.Add("display", "table-row");
                            trDispType.Style.Add("display", "table-row");
                            trSampleTRFPart.Style.Add("display", "table-row");
                            trEditRemarks.Style.Add("display", "table-row");
                        }
                        tdSearchType1.Attributes.Add("style", "display:none");
                        tdSearchType2.Attributes.Add("style", "display:none");
                        //InComddl.Attributes.Add("style", "display:none");
                        //InComCheck.Attributes.Add("style", "display:none");
                        txtClient.Enabled = false;
                    }
                    else
                    {
                        hdnIsEditMode.Value = "N";
                        trEditRemarks.Style.Add("display", "none");
                        trDispType.Style.Add("display", "none");
                        trVisitTypePart.Style.Add("display", "none");
                        tdAdditionalDetails.Style.Add("display", "none");
                        hdnBaseClientID.Value = "0";
                        hdnSelectedClientClientID.Value = "0";
                    }
                }
            }
            else
            {
                trSampleTRFPart.Style.Add("display", "table-row");
                //trEditRemarks.Style.Add("display", "block");
                trDispType.Style.Add("display", "table-row");
                trVisitTypePart.Style.Add("display", "table-row");
            }
            if (!IsPostBack)
            {
                if (BookingNumber != "")
                {
                    chkSamplePickup.Checked = true;
                    BillingEngine objBillingengine = new BillingEngine();
                    List<Bookings> lstBookings = new List<Bookings>();
                    long returncode = -1;
                    returncode = objBillingengine.GetBookingOrderDetails(Convert.ToInt64(BookingNumber), OrgID, 0, out lstBookings);
                    hdnPreviousVisitDetails.Value = "";
                    if (lstBookings.Count > 0)
                    {
                        for (int i = 0; i < lstBookings.Count; i++)
                        {
                            hdnPreviousVisitDetails.Value += lstBookings[i].Name + '$' + lstBookings[i].ID + '$' + lstBookings[i].Type + '$' + lstBookings[i].SourceType + '$' + "" + '$' + "" + '$' + "N" + '$' + "0" + '$' + "" + '$' + "" + '$' + "" + '^';
                        }
                    }
                    //hdnDefaultOrgBillingItems.Value += "" + "^" + "" + "^" + "" + "^" + "" + "^" + "" + "^" + "" + "^" + "" + "^" + "" + "^" + "" + "^" + "" + "^" + "" + "^" + "" + "^" + "" + "^" + "" + "^" + "" + "^" + "" + "^" + "" + "^" + "";
                    hdnDefaultOrgBillingItems.Value = "";
                    ScriptManager.RegisterStartupScript(Page, GetType(), "CallEdit", "javascript:SetBookedItems();", true);
                    //txtSampleDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
                }
                else
                {
                    chkSamplePickup.Checked = false;
                }
            }
            string Mobile = Resources.Billing_ClientDisplay.Billing_LabQuickBilling_aspx_13;
            string MobileNoCountryCode = GetConfigValue("MobileNoFormat", OrgID);
            if (!string.IsNullOrEmpty(MobileNoCountryCode) && MobileNoCountryCode.Length > 0)
            {
                lblMobile.Text = Mobile + MobileNoCountryCode.ToString();
            }
            else
            {
                lblMobile.Text = Mobile;
            }
            SetDefaultClient = GetConfigValue("SetDefaultClientForLoc", OrgID);
            if (SetDefaultClient == "Y")
            {
                if (hdnDefaultClienName != null && hdnDefaultClienID != null)
                {
                    hdnDefaultClienID.Value = "0";
                    hdnDefaultClienName.Value = "";
                    hdnIsCashClient.Value = "N";
                }
                LoadDefaultClientNameBasedOnOrgLocation();
            }
        }
        // txtDOBNos.Attributes.Add("onblur", "setDOBYear('" + txtDOBNos.ClientID.ToString() + "');");
    }
    #endregion
   
    #region "Events"
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            int status = -1;
            int upis = -1;
            long vid = Convert.ToInt64(hdnVisitID.Value);
            List<SampleTracker> lstSampleTracker = new List<SampleTracker>();
            List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            List<InvDeptSamples> lstDeptSamples = new List<InvDeptSamples>();
            Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
            List<InvestigationValues> linvValues = new List<InvestigationValues>();
            List<PatientInvSampleMapping> lSampleMapping = new List<PatientInvSampleMapping>();
            List<string> lstCollectedSampleStatus = new List<string>();
            InvDeptSamples eInvDeptSamples = new InvDeptSamples();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string strLstPatientInvSample = hdnLstPatientInvSample.Value;
            string strLstSampleTracker = hdnLstSampleTracker.Value;
            string strLstPatientInvSampleMapping = hdnLstPatientInvSampleMapping.Value;
            string strLstInvestigationValues = hdnLstInvestigationValues.Value;
            string strLstCollectedSampleStatus = hdnLstCollectedSampleStatus.Value;
            string invStatus = string.Empty;
            string gUID = string.Empty;
            lstPatientInvSample = serializer.Deserialize<List<PatientInvSample>>(strLstPatientInvSample);
            lstSampleTracker = serializer.Deserialize<List<SampleTracker>>(strLstSampleTracker);
            lSampleMapping = serializer.Deserialize<List<PatientInvSampleMapping>>(strLstPatientInvSampleMapping);
            linvValues = serializer.Deserialize<List<InvestigationValues>>(strLstInvestigationValues);
            lstCollectedSampleStatus = serializer.Deserialize<List<string>>(strLstCollectedSampleStatus);
            gUID = hdnGuID.Value;
            foreach (DataListItem repDept in this.repDepts.Items)
            {
                CheckBox chkDept = repDept.FindControl("chkDept") as CheckBox;

                if (chkDept.Checked)
                {
                    Label lbDeptID = repDept.FindControl("lblDeptID") as Label;
                    eInvDeptSamples = new InvDeptSamples();
                    eInvDeptSamples.PatientVisitID = vid;
                    eInvDeptSamples.DeptID = Convert.ToInt32(lbDeptID.Text);
                    eInvDeptSamples.OrgID = OrgID;
                    lstDeptSamples.Add(eInvDeptSamples);
                }
            }


            if (lstSampleTracker.Count > 0 && lstDeptSamples.Count > 0)
            {
                List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                string lstSampleId = string.Empty;

                List<SampleTracker> lstTracker = new List<SampleTracker>();
                SampleTracker sampleTracker = new SampleTracker();
                foreach (PatientInvSample Obj1 in lstPatientInvSample)
                {
                    lstTracker = (from ST in lstSampleTracker
                                  where ST.SampleID == Obj1.SampleCode
                                  select ST).ToList();
                    if (lstTracker != null)
                    {
                        if (lstTracker.Exists(P => P.InvSampleStatusID == 3))
                        {
                            sampleTracker = lstTracker.Find(P => P.InvSampleStatusID == 3);
                            Obj1.Reason = sampleTracker.Reason;
                            Obj1.InvSampleStatusID = sampleTracker.InvSampleStatusID;
                        }
                        else
                        {
                            sampleTracker = lstTracker[0];
                            Obj1.Reason = sampleTracker.Reason;
                            Obj1.InvSampleStatusID = sampleTracker.InvSampleStatusID;
                        }
                    }
                    //foreach (SampleTracker Obj2 in lstSampleTracker)
                    //{
                    //    if (Obj2.SampleID == Obj1.SampleCode)
                    //    {
                    //        Obj1.Reason = Obj2.Reason;
                    //        Obj1.InvSampleStatusID = Obj2.InvSampleStatusID;
                    //        break;
                    //    }

                    //}

                }

                // ctlCollectSample.ExtractInvestigations(vid, gUID);
                returnCode = invBL.SavePatientInvSample(lstPatientInvSample, lstSampleTracker, lstDeptSamples, lSampleMapping,
                     lstPatientInvestigation, linvValues, gUID, out status, out lstSampleId);
                //returnCode = invBL.SavePatientInvSample(lstPatientInvSample, lstSampleTracker, lstDeptSamples,lSampleMapping, out status, out lstSampleId);
                if (status == 0)
                {
                    int DeptID = 0;

                    //if (invStatus == String.Empty)
                    //{
                    //    new Investigation_BL(base.ContextInfo).getInvOrgSampleStatus(OrgID, "Paid", out invStatus);
                    //}

                    ////invBL.UpdateOrderedInvestigationStatusinLab(linvValues, vid, invStatus, DeptID, "Paid", gUID, out upis);

                    ////invBL.InsertPatientSampleMapping(lSampleMapping, vid, OrgID, 0, LID, out status);

                    //List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();
                    //List<PatientInvestigation> patInves = new List<PatientInvestigation>();
                    //List<PatientInvestigation> SaveInvestigation = new List<PatientInvestigation>();
                    ////List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                    //List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
                    //List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
                    //List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
                    //List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
                    //List<InvDeptMaster> deptList = new List<InvDeptMaster>();
                    //List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
                    //Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                    //int taskactionID = (int)TaskHelper.TaskAction.CollectSample;
                    //int pOrderedCount = -1;

                    //invbl.GetInvestigationSamplesCollect(vid, OrgID, RoleID, gUID, ILocationID, taskactionID,
                    //out lstPatientInvestigation,
                    //out lstInvSampleMaster,
                    //out lstInvDeptMaster,
                    //out lstRoleDept,
                    //out lstOrderedInvSample,
                    //out deptList,
                    //out lstSampleContainer);

                    //foreach (PatientInvestigation patient in lstPatientInvestigation)
                    //{

                    //    PatientInvestigation objInvest = new PatientInvestigation();
                    //    objInvest.InvestigationID = patient.InvestigationID;
                    //    objInvest.InvestigationName = patient.InvestigationName;
                    //    objInvest.PatientVisitID = patient.PatientVisitID;
                    //    objInvest.GroupID = patient.GroupID;
                    //    objInvest.GroupName = patient.GroupName;
                    //    objInvest.Status = patient.Status;
                    //    objInvest.CollectedDateTime = patient.CreatedAt;
                    //    objInvest.CreatedBy = LID;
                    //    objInvest.Type = patient.Type;
                    //    objInvest.OrgID = OrgID;
                    //    objInvest.InvestigationMethodID = 0;
                    //    objInvest.KitID = 0;
                    //    objInvest.InstrumentID = 0;
                    //    objInvest.UID = patient.UID;
                    //    SaveInvestigation.Add(objInvest);
                    //}
                    //if (lstPatientInvestigation.Count > 0)
                    //{
                    //    if (lstPatientInvestigation[0].UID != null)
                    //    {
                    //        gUID = lstPatientInvestigation[0].UID;
                    //    }
                    //}


                    //if (SaveInvestigation.Count > 0)
                    //{


                    //    returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(SaveInvestigation, OrgID, gUID, out pOrderedCount);
                    //}
                    string IsBarCodeNeed = GetConfigValue("PrintSampleBarcode", OrgID);
                    if (IsBarCodeNeed == "Y")
                    {
                        ctlCollectSample.IsBarcodeNeeded = true;
                    }
                    long DoFrmVisit = -1;
                    if (hdnDoFrmVisit.Value != "-1" || hdnDoFrmVisit.Value != "0")
                    {
                        Int64.TryParse(hdnDoFrmVisit.Value, out DoFrmVisit);
                    }
                    string Barcode = string.Empty;
                    int sampleCode = -1;
                    string type = "DoFrmVisitNumber";
                    int sampleContainerID = -1;
                    if (DoFrmVisit != -1 || DoFrmVisit != 0)
                    {
                        foreach (PatientInvSample PatSample in lstPatientInvSample)
                        {
                            sampleCode = PatSample.SampleCode;
                            sampleContainerID = PatSample.SampleContainerID;
                            string ClientGuid = PatSample.UID;
                            invBL.GetBarcodeNumForDoFromVisit(OrgID, DoFrmVisit, out Barcode, sampleCode, "", type, sampleContainerID);

                        }
                    }
                    if (ctlCollectSample.IsBarcodeNeeded)
                    {
                        BarcodeHelper objBarcodeHelper = new BarcodeHelper();
                        List<BarcodeAttributes> lstBarcodeAttributes = new List<BarcodeAttributes>();
                        List<BarcodeAttributes> lstBarcodeAttributesTRF = new List<BarcodeAttributes>();
                        List<PrintBarcode> lstPrintBarcode = new List<PrintBarcode>();
                        PrintBarcode objPrintBarcode;
                        string MachineID = string.Empty;
                        if (Session["MacAddress"] != null)
                        {
                            MachineID = (string)Session["MacAddress"];
                        }
                        string needTRFBarcode = GetConfigValue("NeedTRFBarcode", OrgID);
                        if (!String.IsNullOrEmpty(needTRFBarcode) && needTRFBarcode == "Y")
                        {
                            objBarcodeHelper.GetBarcodeQueryString(OrgID, Convert.ToString(vid), lstSampleId, 0, BarcodeCategory.TRF, out lstBarcodeAttributesTRF);
                            if (lstBarcodeAttributesTRF.Count > 0)
                            {
                                foreach (BarcodeAttributes objBarcodeAttributes in lstBarcodeAttributesTRF)
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
                        }
                        objBarcodeHelper.GetBarcodeQueryString(OrgID, Convert.ToString(vid), lstSampleId, 0, BarcodeCategory.ContainerRegular, out lstBarcodeAttributes);
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
                            //Modified by Arivalagna.kk Barcode  issue  fix for  cross browser//
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
                                CLogger.LogInfo("Print Barcode :   " + barcode);
                                iframeBarcode.Attributes["src"] = "attunebarcode:" + barcode;
                            }
                            //}
                            //else
                            //{
                            //GateWay objGateWay = new GateWay(base.ContextInfo);
                            //Int32 returnStatus = -1;
                            //objGateWay.SaveBarcodePrintDetails(lstPrintBarcode, out returnStatus);
                            //}
                            //End Modified by Arivalagna.kk Barcode  issue  fix for  cross browser//
                        }
                    }
                    long PID = -1;
                    long PVid = -1;
                    long PFinalBillID = -1;
                    long PVPurposeID = -1;
                    string PClientname = string.Empty;
                    Int64.TryParse(hdnPatientID.Value, out PID);
                    Int64.TryParse(hdnVisitID.Value, out PVid);
                    Int64.TryParse(hdnFinalBillID.Value, out PFinalBillID);
                    Int64.TryParse(hdnVisitPurposeID.Value, out PVPurposeID);

                    Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
                    oTasksBL.UpdateTask(Convert.ToInt64(hdntaskID.Value), TaskHelper.TaskStatus.Completed, LID);
                    string NeedBillInvestigation = GetConfigValue("NeedBillInvestigationSRS", OrgID);

                    string sPagesrs = "../Reception/PrintPage.aspx?pid=" + PID.ToString()
                 + "&vid=" + PVid.ToString()
                 + "&pagetype=BP&quickbill=N&bid=" + 0 + "&visitPur=" + 0 + "&ClientName=" + 0 + "&OrgID=" + OrgID + "&IsPopup=Y" + "&IsNeedInv=Y";
                    string sPagesrs1 = "../Reception/PrintPage.aspx?pid=" + PID.ToString()
                 + "&vid=" + PVid.ToString()
                 + "&pagetype=BP&quickbill=N&bid=" + 0 + "&visitPur=" + 0 + "&ClientName=" + 0 + "&OrgID=" + OrgID + "&IsPopup=Y" + "&IsNeedInv=Y";

                    if (NeedBillInvestigation == "Y")
                    {
                        ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( '" + sPagesrs + "', null, 'height=700,width=760,status=yes,toolbar=no,scrollbars=yes,menubar=no,location=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
                        ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( '" + sPagesrs1 + "', null, 'height=700,width=760,status=yes,toolbar=no,scrollbars=yes,menubar=no,location=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
                    }
                    PrintBilling(PID, PVid, PFinalBillID, PVPurposeID, txtClient.Text);

                    string sPage1 = string.Empty;
                    string sPage11 = string.Empty;
                    string IsCreditBill = billPart.IsCreditBill;
                    string NeedBillPrintForClient = GetConfigValue("NeedPrintForClient", OrgID);
                    string NoNeedBillPrint = GetConfigValue("NoNeedBillPrint", OrgID);
                    string BookingNo = hdnBookingNo.Value;
                    if (string.IsNullOrEmpty(NeedBillPrintForClient))
                        NeedBillPrintForClient = "Y";
                    sPage1 = "../Reception/PrintPage.aspx?pid=" + hdnPatientID.Value
                                   + "&vid=" + hdnVisitID.Value
                    + "&pagetype=BP&quickbill=N&bid=" + hdnFinalBillID.Value + "&visitPur=" + hdnVisitPurposeID.Value
                    + "&ClientName=" + txtClient.Text + "&OrgID=" + OrgID + "&BKNO=" + BookingNo + "&IsPopup=Y";
                    sPage11 = "../Reception/PrintPage.aspx?pid=" + hdnPatientID.Value
                                   + "&vid=" + hdnVisitID.Value
                                   + "&pagetype=BP&quickbill=N&bid=" + hdnFinalBillID.Value + "&visitPur=" + hdnVisitPurposeID.Value
                                   + "&ClientName=" + txtClient.Text + "&OrgID=" + OrgID + "&BKNO=" + BookingNo + "&IsPopup=Y";
                    List<Role> lstUserRole1 = new List<Role>();
                    string path1 = string.Empty;
                    Role role1 = new Role();
                    role1.RoleID = RoleID;
                    lstUserRole1.Add(role1);
                    returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);


                    long pid = 0;
                    if (Request.QueryString["pid"] != null)
                    {
                        Int64.TryParse(Request.QueryString["pid"], out pid);

                    }
                    if (Request.QueryString["VID"] != null)
                    {
                        Int64.TryParse(Request.QueryString["VID"], out vid);

                    }
                    ////string sPages = string.Empty;
                    ////sPages = sPage1 + "&IsNeedInv=Y" + "&RedirectPage=/Billing/LabQuickBilling.aspx";

                    //string NeedBillInvestigation = GetConfigValue("NeedBillInvestigationSRS", OrgID);
                    //string sPage = "../Reception/PrintPage.aspx?pid=" + pid.ToString()
                    //          + "&vid=" + vid.ToString()
                    //          + "&sampleId=" + lstSampleId + "&pagetype=BP&quickbill=N&bid=" + 0 + "&visitPur=" + 0 + "&ClientName=" + 0 + "&OrgID=" + OrgID + "&IsPopup=Y" + "&IsNeedInv=Y";

                    //if (NeedBillInvestigation == "Y")
                    //{
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:OpenBillPrint1('" + sPage1 + "','" + sPage + "');", true);
                    //}
                    ClearValues();
                    ctlCollectSample.ResetData();
                    if (hdnIsReceptionPhlebotomist.Value == "Y")
                    {
                        hdnddlsalutation.Value = "0";
                        hdnEditSex.Value = "0";
                        ddSalutation.SelectedValue = "0";
                        ddlSex.SelectedIndex = -1;
                    }

                   // ddlSex.SelectedItem.Value = "M";
                    hdntaskID.Value = "-1";
                    hdnDoFrmVisit.Value = "";
                    hdnDOFromVisitFlag.Value = "-1";
                    /******************Added By Arivalagan.kk***********************/
                    String DofromVisitfreeze;
                    DofromVisitfreeze = GetConfigValue("DofromVisitfreeze", OrgID);
                    if (DofromVisitfreeze == "Y" && txtDoFrmVisitNumber.Text != "" && txtDoFrmVisitNumber.Text != null && Request.QueryString["RCP"] == "Y")
                    {
                        UnDofreezeCTRL();
                    }
                    /******************End Added By Arivalagan.kk*******************/
                    txtDoFrmVisitNumber.Text = string.Empty;
                    tblDatepicker.Style.Add("display", "none");
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while generating work order in Lab Quick Billing", ex);

        }
    }
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        PageContextDetails.ButtonName = ((Button)sender).ID;
        PageContextDetails.ButtonValue = ((Button)sender).Text;
        SaveData();

         if (hdnIsReceptionPhlebotomist.Value != "Y")
         {
        hdnddlsalutation.Value = "0";
        hdnEditSex.Value = "0";
        ddSalutation.SelectedValue = "0";
        ddlSex.SelectedIndex = -1;
         }

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {

            Response.Redirect("../Billing/LabQuickBilling.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            long returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
            string Lasturl = string.Empty;
            Lasturl = Session["LastPageUrl"].ToString();
            Response.Redirect(Lasturl, false);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While click back button in Lab Quick Billing", ex);
        }

    }
    #endregion

    #region "Methods"

    public void LoadDefaultClientNameBasedOnOrgLocation()
    {
        long lresutl = -1;
        BillingEngine BillingBl = new BillingEngine(new BaseClass().ContextInfo);
        List<InvClientMaster> lstClientNames = new List<InvClientMaster>();
        string prefixText = string.Empty;
        string pType = "CLI";
        long refhospid = -1;
        lresutl = BillingBl.GetRateCardForBilling(prefixText, OrgID, pType, refhospid, out lstClientNames);
        if (lstClientNames.Count > 0)
        {
            string[] ClientValues = lstClientNames[0].Value.Split('^');
            //string[] ClientRateID = ClientValues[4].Split('~');
            if (ClientValues[21] == "Y")
            {
                hdnLocationClient.Value = "Y";
                if (hdnDefaultClienID != null)
                {
                    hdnDefaultClienID.Value = Convert.ToString(lstClientNames[0].ClientID);
                }
                if (hdnDefaultClienName != null)
                {
                    hdnDefaultClienName.Value = lstClientNames[0].ClientName;
                }
                if (txtClient.Text == string.Empty)
                {
                    txtClient.Text = lstClientNames[0].ClientName;
                }
                if ((txtClient.Text == string.Empty) || (txtClient.Text == lstClientNames[0].ClientName))
                {
                    hdnSelectedClientClientID.Value = Convert.ToString(lstClientNames[0].ClientID);
                    hdnIsCashClient.Value = ClientValues[17];
                    //hdnRateID.Value = Convert.ToString(ClientRateID[0]);
                }
            }
            else
                hdnLocationClient.Value = "N";
        }
    }
    public void LoadDefaultClientName()
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<ClientMaster> lstClientNames = new List<ClientMaster>();
        List<OrganizationAddress> lstorgname = new List<OrganizationAddress>();
        List<ClientMaster> lstClientNames1 = new List<ClientMaster>();
        string prefixText = string.Empty;
        long Ret1 = new Master_BL(base.ContextInfo).GetCollectionCentreClients(OrgID, ILocationID, prefixText, out lstClientNames);
        {
            string Location = LocationName.Trim().ToString();
            lstClientNames1 = (from find in lstClientNames
                               where
                               find.ClientName.Contains(Location)
                               orderby find.ClientName.ToUpper()
                               select find).ToList();

            if (lstClientNames1.Count > 0)
            {
                //txtLocClient.Text = lstClientNames1[0].ClientName;
                //hdnClienID.Value = lstClientNames1[0].ClientID.ToString();
                //hdnClienID.Value = lstClientNames[0].ClientID.ToString();
            }

        }
    }
    public void loadCollectSampleList(long VisitID, string gUID)
    {
        try
        {
            string strCollectAgain = string.Empty;
            string strInvColNSList = string.Empty;
            string strInvRejected = string.Empty;
            string strSampleRelationshipID = string.Empty;
            string strCmoreSample = string.Empty;
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
            List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
            List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
            List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
            List<InvDeptMaster> deptList = new List<InvDeptMaster>();
            List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();

            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            List<PatientVisit> visitList = new List<PatientVisit>();
            returnCode = patientBL.GetLabVisitDetails(VisitID, OrgID, gUID, out visitList);


            int taskactionID = (int)TaskHelper.TaskAction.CollectSample;

            Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
            invbl.GetInvestigationSamplesCollect(VisitID, OrgID, RoleID, gUID, ILocationID, taskactionID, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);


            List<PatientInvestigation> PaidItems = new List<PatientInvestigation>();
            //Load list  of samples in OrderSample list user control
            if (lstPatientInvestigation.Count() > 0)
            {

                //Change Sample name into dropdown List
                List<PatientInvestigation> lstInvColNSList = new List<PatientInvestigation>();
                List<PatientInvestigation> lstNotCollectedInvestigation = new List<PatientInvestigation>();
                if (strCollectAgain == "Y")
                {
                    long result;
                    result = invbl.GetInvestigationForSampleID(VisitID, OrgID, Convert.ToInt32(strSampleRelationshipID), out lstInvColNSList);

                    foreach (PatientInvestigation i in lstInvColNSList)
                    {
                        if (strInvColNSList == "")
                        {
                            strInvColNSList = i.InvestigationID.ToString() + "~" + i.SampleID.ToString();
                        }
                        else
                        {
                            strInvColNSList = strInvColNSList + "," + i.InvestigationID.ToString() + "~" + i.SampleID.ToString();
                        }
                    }
                    lstNotCollectedInvestigation = lstInvColNSList;
                }
                else if (strCmoreSample == "Y")
                {
                    lstNotCollectedInvestigation = lstPatientInvestigation;
                }
                else
                {
                    List<PatientInvestigation> lstInvRejected = new List<PatientInvestigation>();
                    long result;
                    result = invbl.GetInvRejected(VisitID, OrgID, out lstInvRejected);

                    foreach (PatientInvestigation i in lstInvRejected)
                    {
                        if (strInvRejected == "")
                        {
                            strInvRejected = i.InvestigationID.ToString();
                        }
                        else
                        {
                            strInvRejected = strInvRejected + "," + i.InvestigationID.ToString();
                        }
                    }
                    if (strInvRejected.Length > 0)
                    {
                        foreach (string strInv in strInvRejected.Split(','))
                        {
                            lstPatientInvestigation.RemoveAll(P => P.InvestigationID == Convert.ToInt64(strInv));
                        }
                    }

                    PaidItems = lstPatientInvestigation.FindAll(P => P.Status == "Paid" || P.Status == "SampleNotGiven" || P.Status == "SampleRejected" || P.Status == "Ordered");
                    lstNotCollectedInvestigation = PaidItems;
                }
                List<InvSampleStatusmaster> lstInvSampleStatus = new List<InvSampleStatusmaster>();
                List<InvReasonMasters> lstInvReasonMaster = new List<InvReasonMasters>();
                List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
                List<LabRefOrgAddress> lstOutsource = new List<LabRefOrgAddress>();
                returnCode = invbl.GetCollectSampleDropDownValues(OrgID, PageType.CollectSample, out lstInvSampleStatus, out lstInvReasonMaster, out lstLocation, out lstOutsource);
                ctlCollectSample.SetValues(lstInvSampleMaster, lstSampleContainer, lstInvSampleStatus, lstInvReasonMaster, lstLocation, lstOutsource, lstNotCollectedInvestigation);

                repDepts.DataSource = lstInvDeptMaster;
                repDepts.DataBind();
                List<PatientInvestigation> lstSampleDept = new List<PatientInvestigation>();
                List<PatientInvSample> lstPatInvSample = new List<PatientInvSample>();
                invbl.GetDeptToTrackSamples(VisitID, OrgID, RoleID, gUID, out lstSampleDept, out lstPatInvSample);
                if (strCollectAgain == "Y")
                {
                    foreach (string strInv in strInvColNSList.Split(','))
                    {
                        int intPosition = -1;
                        int intSampleCode = 0;
                        string strInvestigationID = "";
                        if (strInv.IndexOf("~") != -1)
                        {
                            intPosition = strInv.IndexOf("~");
                            strInvestigationID = strInv.Substring(0, intPosition);
                            intSampleCode = Convert.ToInt32(strInv.Substring(intPosition + 1));
                            lstPatInvSample.RemoveAll(P => (P.InvestigationID != strInvestigationID && P.SampleCode != intSampleCode));
                        }
                    }
                }
                else
                {
                    foreach (string strInv in strInvRejected.Split(','))
                    {
                        lstPatInvSample.RemoveAll(P => P.InvestigationID == strInv);
                    }
                }
                long DoFrmVisitID = -1;
                if (hdnDoFrmVisit.Value != "-1" || hdnDoFrmVisit.Value != "0")
                {

                    Int64.TryParse(hdnDoFrmVisit.Value, out DoFrmVisitID);
                }
                if (lstPatInvSample.Count > 0)
                {
                    ctlCollectSample.LoadCollectSampleList(lstPatInvSample, DoFrmVisitID);
                }
                if (deptList.Count == 0)
                {
                    foreach (DataListItem repDept in this.repDepts.Items)
                    {
                        CheckBox chkDept = repDept.FindControl("chkDept") as CheckBox;
                        Label lbDeptID = repDept.FindControl("lblDeptID") as Label;
                        foreach (PatientInvestigation listInv in lstSampleDept)
                        {
                            if (Convert.ToInt32(lbDeptID.Text) == listInv.DeptID)
                            {
                                chkDept.Checked = true;
                            }
                        }
                    }
                }
                else
                {
                    foreach (DataListItem repDept in this.repDepts.Items)
                    {
                        CheckBox chkDept = repDept.FindControl("chkDept") as CheckBox;
                        Label lbDeptID = repDept.FindControl("lblDeptID") as Label;
                        foreach (InvDeptMaster list in deptList)
                        {
                            if (Convert.ToInt32(lbDeptID.Text) == list.DeptID)
                            {
                                chkDept.Checked = true;
                            }
                        }
                    }
                }

                if (repDepts.Items.Count <= 1)
                {
                    pnlDept.Style.Add("display", "none");
                }
                else
                {
                    pnlDept.Style.Add("display", "block");
                }

            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Setdatetime", "SetDateTimeDetails();", true);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while load data investigation sample", ex);
        }

    }
    private void loadRateSubTypeMapping()
    {
        List<RateSubTypeMapping> lstRateSubTypeMapping = new List<RateSubTypeMapping>();
        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        billingEngineBL.GetRateSubVisitTypeDetails(OrgID, "VST", out lstRateSubTypeMapping);
        ddlVisitDetails.DataSource = lstRateSubTypeMapping;
        ddlVisitDetails.DataTextField = "Description";
        ddlVisitDetails.DataValueField = "TypeOfSubType";
        ddlVisitDetails.DataBind();

        foreach (RateSubTypeMapping item in lstRateSubTypeMapping)
        {
            //hdnVisitSubType.Value += item.Description + "^" + item.TypeOfSubType + "|";
        }

    }
    public void LoadQuickBillLoading()
    {
        try
        {
            List<Salutation> lstTitles = new List<Salutation>();
            List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
            List<Country> lstNationality = new List<Country>();
            List<Country> lstCountries = new List<Country>();
            string LanguageCode = string.Empty;
            LanguageCode = ContextInfo.LanguageCode;
            billingEngineBL = new BillingEngine(base.ContextInfo);
            billingEngineBL.GetQuickBillingDetails(OrgID, LanguageCode, out lstTitles, out lstVisitPurpose, out lstNationality, out lstCountries);
            LoadTitle(lstTitles);
            LoadPriority();
            LoadCountry(lstCountries);
            LoadURNtype();
            LoadNationality(lstNationality);
            LoadMeatData();
            loadRateType();
            loadClient();
            LoadDefaultBillingItemsforWalkins();
            LoadDespatchMode();
            LoadInvestigationHistroyDetail();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Lab Quick Billing LoadQuickBillLoading() Method", ex);
        }

    }
    void LoadDespatchMode()
    {
        try
        {
            long returnCode = -1;
            Master_BL obj = new Master_BL(base.ContextInfo);
            List<ClientAttributes> lstclientattrib = new List<ClientAttributes>();
            List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
            List<ActionManagerType> lstactiontype = new List<ActionManagerType>();
            List<InvReportMaster> lstrptmaster = new List<InvReportMaster>();
            returnCode = obj.GetGroupValues(OrgID, out lstmetavalue, out lstactiontype, out lstclientattrib, out lstrptmaster);
            if (lstactiontype.Count > 0)
            {
                var DispatchMode = lstactiontype.FindAll(p => p.Type == "DisM");
                chkDespatchMode.DataSource = DispatchMode;
                chkDespatchMode.DataTextField = "ActionType";
                chkDespatchMode.DataValueField = "ActionTypeID";
                chkDespatchMode.DataBind();
            }
            if (lstactiontype.Count > 0)
            {
                var Notification = lstactiontype.FindAll(p => p.Type == "Notify");
                ChkNotification.DataSource = Notification;
                ChkNotification.DataTextField = "ActionType";
                ChkNotification.DataValueField = "ActionTypeID";
                ChkNotification.DataBind();


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While LoadDespatchMode() in Lab Quick Billing", ex);
        }
    }
    void LoadDefaultBillingItemsforWalkins()
    {
        try
        {
            string sVal = GetConfigValue("NeedWalkinCharge", OrgID);
            if (!string.IsNullOrEmpty(sVal) && sVal == "Y")
            {
                billingEngineBL = new BillingEngine(base.ContextInfo);
                billingEngineBL.GetQuickBillItems(OrgID, "GEN", "", 0, out lstDetails, Convert.ToInt64(hdnBaseRateID.Value), "OP", -1, "B", "LAB");
                if (lstDetails.Count > 0)
                {
                    for (int i = 0; i < lstDetails.Count; i++)
                    {
                        string[] temp = lstDetails[i].ProcedureName.Split('^');
                        if (temp.Count() > 0)
                        {
                            hdnDefaultOrgBillingItems.Value += temp[0] + "^" + temp[2] + "^" + temp[1] + "^" + temp[3] + "^" + 1 + "^" + "" + "^" + temp[7] + "^" + "N" + "^" + temp[8] + "^" + temp[9] + "^" + temp[10] + "^" + temp[11] + "^" + temp[12] + "^" + temp[13] + "^" + temp[14] + "^" + temp[15] + "^" + temp[16] + "^" + temp[17];
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While LoadDefaultBillingItemsforWalkins() in Lab Quick Billing", ex);
        }
    }
    public void loadClient()
    {
        string strAlert = Resources.Billing_AppMsg.Billing_Header_Alert == null ? "Alert" : Resources.Billing_AppMsg.Billing_Header_Alert;
        string strGenAssOrg = Resources.Billing_AppMsg.Billing_LabQuickBilling_aspx_05 == null ? "No general Client associated this Organisation" : Resources.Billing_AppMsg.Billing_LabQuickBilling_aspx_05;
        try
        {
            SharedInventorySales_BL inventorySalesBL = new SharedInventorySales_BL(base.ContextInfo);
            List<ClientMaster> lstclients = new List<ClientMaster>();
            inventorySalesBL.GetClientNames(OrgID, out lstclients);
            if (lstclients.Count > 0)
            {
                var temp = lstclients.FindAll(p => p.ClientCode == "GENERAL");
                if (lstclients.Count > 0)
                {
                    hdnBaseClientID.Value = temp[0].ClientID.ToString();
                    hdnSelectedClientClientID.Value = temp[0].ClientID.ToString();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "ValidationWindow('" + strGenAssOrg.Trim() + "','" + strAlert.Trim() + "');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While loadClient() in Lab Quick Billing", ex);
        }

    }
    public void loadRateType()
    {
        try
        {
            long Returncode = -1;
            List<RateMaster> lstRateMaster = new List<RateMaster>();
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            Returncode = MasterBL.pGetRateName(OrgID, out lstRateMaster);
            if (lstRateMaster.Count > 0)
            {
                var temp = lstRateMaster.FindAll(p => p.RateCode == "GENERAL");
                if (temp.Count > 0)
                {
                    hdnBaseRateID.Value = temp[0].RateId.ToString();
                    //hdnRateID.Value = temp[0].RateId.ToString();
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load data", ex);
        }
    }
    public void LoadNationality(List<Country> lstNationality)
    {
        try
        {
            Country selectednationality = new Country();
            ddlNationality.DataSource = lstNationality;
            ddlNationality.DataTextField = "Nationality";
            ddlNationality.DataValueField = "NationalityID";
            ddlNationality.DataBind();
            selectednationality = lstNationality.Find(FindNationality);
            ddlNationality.SelectedValue = selectednationality.NationalityID.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Nationality ", ex);

        }
    }
    static bool FindNationality(Country c)
    {

        if (c.IsDefault != null && c.IsDefault == "Y")
        {
            return true;
        }
        return false;
    }
    public string StrUrn = "";
    public void LoadURNtype()
    {
        try
        {
            long returnCode = -1;
            Patient_BL pBL = new Patient_BL(base.ContextInfo);
            List<URNTypes> objURNTypes = new List<URNTypes>();
            List<URNof> objURNof = new List<URNof>();
            returnCode = pBL.GetURNType(out objURNTypes, out objURNof);
            Salutation selectedSalutation = new Salutation();

            if (returnCode == 0)
            {
                ddlUrnType.DataSource = objURNTypes;
                ddlUrnType.DataTextField = "DisplayText";
                ddlUrnType.DataValueField = "URNTypeId";
                ddlUrnType.DataBind();

                ddlUrnType.Items.Insert(0, strSelect.Trim());
                ddlUrnType.Items[0].Value = "0";

                ddlUrnoOf.DataSource = objURNof;
                ddlUrnoOf.DataTextField = "URNOf";
                ddlUrnoOf.DataValueField = "URNOfId";
                ddlUrnoOf.DataBind();

                ddlUrnoOf.Items.Insert(0, strSelect.Trim());
                ddlUrnoOf.Items[0].Value = "0";
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading URNtype", ex);
        }

    }
    public void SetURN(URNTypes objURNTypes)
    {
        if (StrUrn != "")
            hdnUrn.Value = objURNTypes.URN;
        txtURNo.Text = objURNTypes.URN;
        ddlUrnoOf.SelectedValue = objURNTypes.URNof.ToString();
        ddlUrnType.SelectedValue = objURNTypes.URNTypeId.ToString();
    }
    public URNTypes GetURN()
    {
        URNTypes objURNTypes = new URNTypes();
        objURNTypes.URN = txtURNo.Text;
        objURNTypes.URNof = Int64.Parse(ddlUrnoOf.SelectedValue);
        objURNTypes.URNTypeId = Int64.Parse(ddlUrnType.SelectedValue);
        return objURNTypes;
    }
    protected void LoadCountry(List<Country> lstcountries)
    {
        Country selectedCountry = new Country();
        ddCountry.Items.Clear();
        int countryID = 0;
        try
        {
            ddCountry.DataSource = lstcountries;
            ddCountry.DataTextField = "CountryName";
            ddCountry.DataValueField = "CountryID";
            ddCountry.DataBind();
            selectedCountry = lstcountries.Find(FindCountry);
            if (CountryID > 0)
            {
                ddCountry.SelectedValue = CountryID.ToString();
            }
            else
            {
                ddCountry.SelectedValue = selectedCountry.CountryID.ToString();
            }
            //ddCountry.SelectedValue = selectedCountry.CountryID.ToString();
            Int32.TryParse(ddCountry.SelectedItem.Value, out countryID);
            LoadState(countryID);
            var childItems = (from n in lstcountries
                              where n.IsDefault == "Y"
                              select new { n.CountryID, n.ISDCode }).ToList();
            if (childItems.Count() > 0)
            {
                hdnDefaultCountryID.Value = childItems[0].CountryID.ToString();
                lblCountryCode.Text = "+" + childItems[0].ISDCode.ToString();
                hdnDefaultCountryStdCode.Value = "+" + childItems[0].ISDCode.ToString();
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Country", ex);
        }
        finally
        {
        }
    }
    protected void LoadState(int countryID)
    {
        List<State> states = new List<State>();
        State_BL stateBL = new State_BL(base.ContextInfo);
        State selectedState = new State();
        long returnCode = -1;
        ddState.Items.Clear();
        int stateID = 0;
        try
        {

            returnCode = stateBL.GetStateByCountry(countryID, out states);

            foreach (State st in states)
            {
                ddState.Items.Add(new ListItem(st.StateName, st.StateID.ToString()));
            }

            selectedState = states.Find(FindState);
            if (StateID > 0)
            {
                ddState.Value = StateID.ToString();
            }
            else
            {
                ddState.Value = selectedState.StateID.ToString();
            }
            Int32.TryParse(ddState.Value, out stateID);
            hdnPatientStateID.Value = StateID.ToString();
            hdnDefaultStateID.Value = selectedState.StateID.ToString();
            //Int32.TryParse(, out stateID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Sate", ex);
        }
        finally
        {
        }
    }
    static bool FindState(State s)
    {
        if (s.IsDefault == "Y")
        {
            return true;
        }
        return false;
    }
    static bool FindCountry(Country c)
    {
        if (c.IsDefault == "Y")
        {

            return true;
        }
        return false;
    }
    public void LoadPriority()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<PriorityMaster> getPriorityMaster = new List<PriorityMaster>();
            retCode = patBL.GetPriorityMaster(out getPriorityMaster);
            if (retCode == 0)
            {
                ddlPriority.DataSource = getPriorityMaster;
                ddlPriority.DataTextField = "PriorityName";
                ddlPriority.DataValueField = "PriorityID";
                ddlPriority.DataBind();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While LoadPriority() Method in Lab Quick Billing", ex);
        }
    }
    private void LoadTitle(List<Salutation> lstTitles)
    {
        try
        {
            int titleID = 0;
            List<Salutation> titles = new List<Salutation>();
            Salutation selectedSalutation = new Salutation();

            //List<Salutation> childItems = (from child in lstTitles
            //                               where (child.TitleName == "Mr.") || (child.TitleName == "Ms.") || (child.TitleName == "Mrs.")
            //                               || (child.TitleName == "Baby.") || (child.TitleName == "Others.") || (child.TitleName == "Pet.")
            //                               || (child.TitleName == "Undisclosed.")
            //                               select child).ToList();


            ddSalutation.DataSource = lstTitles;
            ddSalutation.DataTextField = "TitleName";
            ddSalutation.DataValueField = "TitleID";
            ddSalutation.DataBind();
            selectedSalutation = lstTitles.Find(Findsalutation);
            ddSalutation.Items.Insert(0, strSelect.Trim());
            ddSalutation.Items[0].Value = "0";

            ///Added By Arivalagan k///
            String DefaultSalutation = GetConfigValue("IsDefaultSalutation", OrgID);
            String[] IsDefaultSalutation = DefaultSalutation.Split('~');
            if (IsDefaultSalutation[0] == "Y") { ddSalutation.SelectedValue = IsDefaultSalutation[1]; } else { ddSalutation.SelectedValue = "0"; }
            //End /Added By Arivalagan k///
            Int32.TryParse(ddSalutation.SelectedItem.Value, out titleID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadTitle() Method in Lab Quick Billing", ex);
        }
    }
    static bool Findsalutation(Salutation s)
    {
        if (s.TitleName.ToUpper().Trim() == "MR.")
        {
            return true;
        }
        return false;
    }
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "DateAttributes,Gender,MaritalStatus,PatientType,PatientStatus,DespatchType,SearchType,VisitType";
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


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "DateAttributes"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlDOBDWMY.DataSource = childItems;
                    ddlDOBDWMY.DataTextField = "DisplayText";
                    ddlDOBDWMY.DataValueField = "Code";
                    ddlDOBDWMY.DataBind();
                    ddlDOBDWMY.SelectedValue = "Year(s)";
                }

                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "Gender" && child.Code !="B"
                                  select child;

                if (childItems1.Count() > 0)
                {
                    ddlSex.DataSource = childItems1;
                    ddlSex.DataTextField = "DisplayText";
                    ddlSex.DataValueField = "Code";
                    ddlSex.DataBind();
                    ddlSex.Items.Insert(0, strSelect.Trim());
                    ddlSex.Items[0].Value = "0";
                  //  ddlSex.SelectedValue = "M";
                }



                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "MaritalStatus"
                                  select child;

                if (childItems2.Count() > 0)
                {
                    ddMarital.DataSource = childItems2;
                    ddMarital.DataTextField = "DisplayText";
                    ddMarital.DataValueField = "Code";
                    ddMarital.DataBind();
                    ddMarital.Items.Insert(0, strSelect.Trim());
                    ddMarital.Items[0].Value = "0";
                    ddMarital.SelectedValue = "0";
                }
                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "PatientType"
                                  select child;

                if (childItems3.Count() > 0)
                {
                    ddlPatientType.DataSource = childItems3;
                    ddlPatientType.DataTextField = "DisplayText";
                    ddlPatientType.DataValueField = "Code";
                    ddlPatientType.DataBind();
                }
                var childItems4 = from child in lstmetadataOutput
                                  where child.Domain == "PatientStatus"
                                  select child;

                if (childItems4.Count() > 0)
                {
                    ddlPatientStatus.DataSource = childItems4;
                    ddlPatientStatus.DataTextField = "DisplayText";
                    ddlPatientStatus.DataValueField = "Code";
                    ddlPatientStatus.DataBind(); ;
                }
                var childItemsDisPatchType = from child in lstmetadataOutput
                                             where child.Domain == "DespatchType"
                                             orderby child.DisplayText descending
                                             select child;
                if (childItemsDisPatchType.Count() > 0)
                {
                    chkDisPatchType.DataSource = childItemsDisPatchType;
                    chkDisPatchType.DataTextField = "DisplayText";
                    chkDisPatchType.DataValueField = "Code";
                    chkDisPatchType.DataBind();
                }
                var childrblSearchType = from child in lstmetadataOutput
                                             where child.Domain == "SearchType"
                                             orderby child.MetaDataID ascending 
                                             select child;
                if (childrblSearchType.Count() > 0)
                {
                    rblSearchType.DataSource = childrblSearchType;
                    rblSearchType.DataTextField = "DisplayText";
                    rblSearchType.DataValueField = "Code";
                    rblSearchType.DataBind();
                    rblSearchType.SelectedValue = "4";
                }
                var childitems6 = from child in lstmetadataOutput
                                  where child.Domain == "VisitType"
                                         orderby child.DisplayText descending
                                         select child;
                if (childitems6.Count() > 0)
                {
                    ddlIsExternalPatient.DataSource = childitems6;
                    ddlIsExternalPatient.DataTextField = "DisplayText";
                    ddlIsExternalPatient.DataValueField = "Code";
                    ddlIsExternalPatient.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    public void SaveData()
    {
        string strOrderedListCannotBilled = Resources.Billing_AppMsg.Billing_LabQuickBilling_aspx_06 == null ? "Ordered List count is zero so you cannot billed" : Resources.Billing_AppMsg.Billing_LabQuickBilling_aspx_06;
        string strUpdatedSuccess = Resources.Billing_AppMsg.Billing_LabQuickBilling_aspx_07 == null ? "Updated Successfully" : Resources.Billing_AppMsg.Billing_LabQuickBilling_aspx_07;
        string strErrorDataSaving = Resources.Billing_AppMsg.Billing_LabQuickBilling_aspx_08 == null ? "Error While Saving Data" : Resources.Billing_AppMsg.Billing_LabQuickBilling_aspx_08;
        try
        {
            if (btnGenerate.Text != "Update" && hdnEditBill.Value == "N")
            {
                hdnNewOrgID.Value = "0";
            }
            if (btnGenerate.Text == "Generate Bill" && hdnEditBill.Value == "N")
            {
                hdnNewOrgID.Value = "0";
            }
            btnGenerate.Style.Add("display", "none");
            btnClose.Style.Add("display", "none");
            long pSpecialityID = 0, FinalBillID = 0, patientVisitID = -1;
            int returnStatus = -1, SavePicture = -1;
            long PatientRoleID = 0;
            FinalBill finalBill = new FinalBill();
            string gUID = string.Empty, paymentstatus = "Paid", ReferralType = "";
            List<InvHistoryAttributes> lstInvHistoryAttributes = new List<InvHistoryAttributes>();
            List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
            List<TaxBillDetails> lstTaxDetails = new List<TaxBillDetails>();
            List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
            List<PatientReferringDetails> lstPatientReferringDetails = new List<PatientReferringDetails>();
            List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
            List<PatientDisPatchDetails> lstDispatchDetails = new List<PatientDisPatchDetails>();
            List<PatientHistoryAttribute> lstPatHisAttributes = new List<PatientHistoryAttribute>();
            List<OrderedInvestigations> lstPkgandGrps = new List<OrderedInvestigations>();
            int age = 0, needTaskDisplay = -1;
            long vpurpose = -1;
            string sVal;
            string ddlClientName;
            string[] SplitAge;
            string[] tempAge;
            string strCollectAgain = string.Empty, strSampleRelationshipID = string.Empty;
            long taskID = -1;
            string strMemebershipcardType = string.Empty;
            string strOTP = string.Empty;
            string strStatus = string.Empty;
            string strHealthCardType = string.Empty;
            string strMyCardActiveDays = string.Empty;
            string strCreditRedeemTye = string.Empty;
            long MembershipCardMappingID = -1;
            string strHasHealthCard = string.Empty;
            long RedeemPatientid = -1;
            long RedeemVisitid = -1;
            long RedeemOrgId = -1;
            decimal RedemPoints = 0;
            decimal RedemValue = 0;
            /******Added by Vijayalakshmi.M***********/
            string StatFlag = string.Empty;
            string ClientFlag = string.Empty;
            long Incompleteflag = 0;

            if (!string.IsNullOrEmpty(hdnCheckFlag.Value))
            {
                StatFlag = hdnCheckFlag.Value;
            }
            if (!string.IsNullOrEmpty(hdnClientFlag.Value))
            {
                ClientFlag = hdnClientFlag.Value;
            }

            if (Request.QueryString["CPEDIT"] == "Y")
            {
                if (!String.IsNullOrEmpty(hdnddlDOBDWMY.Value))
                {
                    ddlDOBDWMY.SelectedValue = hdnddlDOBDWMY.Value;
                }
            }
            if (chkIncomplete.Checked == true && (ddlSex.SelectedValue=="U"||ddlDOBDWMY.SelectedValue=="UnKnown"))
            {
                Incompleteflag=1;
            }
            else
            {
                Incompleteflag = 0;
            }
            
            if (txtDOBNos.Text == "")
            {
                if (hdnEdtPatientAge.Value != "0")
                {
                    objPatient.Age = hdnEdtPatientAge.Value.ToString() + "~" + hdnEditDDlDOB.Value.ToString();
                }
                else
                {
                    if (txtDOBNos.Text == "")
                    {
                        objPatient.Age = "";
                    }
                    else
                    {
                        objPatient.Age = txtDOBNos.Text.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
                    }
                }
            }
            else
            {
                objPatient.Age = txtDOBNos.Text.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
            }
            GetPageValues();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);

            int NewOrgID = 0;
            NewOrgID = Convert.ToInt32(hdnNewOrgID.Value.ToString());

            if (hdnOrgID.Value == NewOrgID.ToString())
            {
                patientID = Convert.ToInt64(hdnPatientID.Value);
            }
            else if (hdnDoFrmVisit.Value != "" && hdnDoFrmVisit.Value != null)
            {
                patientID = Convert.ToInt64(hdnPatientID.Value);
            }
            //else if (hdnOrgID.Value == OrgID.ToString())
            //{
            //    patientID = Convert.ToInt64(hdnPatientID.Value);
            //}
            else
            {
                patientID = -1;
            }

            sVal = GetConfigValue("SampleCollect", OrgID);
            objPatient = GetPatientDetails();

            /******************Added By Arivalagan.kk***********************/
            String DofromVisitfreeze;
            DofromVisitfreeze = GetConfigValue("DofromVisitfreeze", OrgID);
            if (DofromVisitfreeze == "Y" && txtDoFrmVisitNumber.Text != "" && txtDoFrmVisitNumber.Text != null && Request.QueryString["RCP"] == "Y")
            {
                DofreezeCTRL();
            }
            /******************End Added By Arivalagan.kk*******************/

            //if (ddlPatientStatus.SelectedValue == "VIP")
            //{
            //    Utilities objUtilities = new Utilities();
            //    object inputobj = new object();
            //    object Encryptedobj = new object();
            //    inputobj = objPatient;
            //    returnCode = objUtilities.GetEncryptedobj(inputobj, out Encryptedobj);
            //    objPatient = (Patient)Encryptedobj;
            //}
            if (txtDOBNos.Text == "")
            {
                if (hdnEdtPatientAge.Value != "0")
                {
                    objPatient.Age = hdnEdtPatientAge.Value.ToString() + "~" + hdnEditDDlDOB.Value.ToString();
                }
				 else if (chkIncomplete.Checked == true)
                {
                    objPatient.Age = "~" + ddlDOBDWMY.SelectedValue.ToString();
                }
                else if (hdnEdtPatientAge.Value == "0" && txtDOBNos.Text == "")
                {
                    objPatient.Age = "";
                }
                else
                {
                    objPatient.Age = txtDOBNos.Text.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
                }
            }
            else
            {
                objPatient.Age = txtDOBNos.Text.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
            }
            if (hdnEdtPatientAge.Value != "0" && txtDOBNos.Text != "")
            {
                SplitAge = objPatient.Age.Split('~');
                tempAge = SplitAge[0].Split('.');
                AgeValue = Convert.ToInt32(tempAge[0]);
                if (SplitAge[1].Trim() == "Day(s)")
                {
                    AgeUnit = "D";
                }
                else if (SplitAge[1].Trim() == "Week(s)")
                {
                    AgeUnit = "W";
                }
                else if (SplitAge[1].Trim() == "Month(s)")
                {
                    AgeUnit = "M";
                }
                else
                {
                    AgeUnit = "Y";
                }
            }
            else
            {
                AgeUnit = "";
            }
            DataTable dtAmountReceivedDet = null;
            string s = hdnMappingClientID.Value;

            dtAmountReceivedDet = billPart.GetAmountReceivedDetails();
            lstPatientDueChart = billPart.GetBillingItems();
            List<VisitClientMapping> lst = new List<VisitClientMapping>();
            objFinalBill = billPart.GetFinalBillDetails(out lst);
            List<PatientDiscount> lstPatientDiscount = new List<PatientDiscount>();
            lstPatientDiscount = billPart.GetPatientDiscount();
            List<PatientMembershipCardMapping> lstPatientHealthcard = new List<PatientMembershipCardMapping>();
            lstPatientHealthcard = billPart.GetHeatthCardDetails();
            //if (hdnIsMycardChecked.Value == "Y")
            //{
            decimal discountAmount = lstPatientDueChart.Sum(discount => discount.DiscountAmount);
            if (objFinalBill.DiscountAmount != discountAmount)
            {
                decimal finalDisCountAmt = objFinalBill.DiscountAmount - discountAmount;
                lstPatientDueChart[0].DiscountAmount = lstPatientDueChart[0].DiscountAmount + finalDisCountAmt;
            }

            if (lstPatientHealthcard.Count > 0)
            {
                foreach (var lstHealthCard in lstPatientHealthcard)
                {
                    strMyCardActiveDays = lstHealthCard.MyCardActiveDays;
                    strMemebershipcardType = lstHealthCard.MemebershipcardType;
                    strHealthCardType = lstHealthCard.HealthCardType;
                    if (lstHealthCard.OTP != "")
                    {
                        strOTP = lstHealthCard.OTP;
                    }
                    else { strOTP = "0"; }
                    strStatus = lstHealthCard.Status;
                    strCreditRedeemTye = lstHealthCard.CreditRedeemTye;
                    MembershipCardMappingID = lstHealthCard.MembershipCardMappingID;
                    strHasHealthCard = lstHealthCard.HasHealthCard;
                    RedemPoints = lstHealthCard.TotalRedemPoints;
                    RedemValue = lstHealthCard.TotalRedemValue;


                }
            }
            //  }

            if (strHasHealthCard != "")
            {
                objPatient.HasHealthCard = strHasHealthCard;
            }
            else { objPatient.HasHealthCard = "N"; }
            if (txtClient.Text != "")
            {
                if (hdnDefaultClienID.Value != "" && hdnDefaultClienID.Value != "0" && hdnDefaultClienID.Value != "-1")
                {
                    if (hdnIsCashClient.Value.Trim() == "Y")
                    {
                        objFinalBill.IsCreditBill = "N";
                    }
                    else
                    {
                        objFinalBill.IsCreditBill = "Y";
                    }
                }
            }
            lstTaxDetails = billPart.getTaxDetails();
            lstInv = billPart.GetOrderedInvestigations(patientVisitID, out gUID);
            lstInvHistoryAttributes = billPart.GetHistoryItems();
            hdnAttributeList.Value = billPart.PassGetAttributeItems().Trim();
            string[] value = hdnAttributeList.Value.Split('^');
            for (int i = 0; i < (value.Length - 1); i++)
            {
                PatientHistoryAttribute lstPatHisAttribute = new PatientHistoryAttribute();
                lstPatHisAttribute.AttributeName = value[i].ToString();
                lstPatHisAttribute.AttributeValueName = value[i + 1];
                lstPatHisAttributes.Add(lstPatHisAttribute);
                i++;
            }
            patientID = Convert.ToInt64(hdnPatientID.Value);
            if (ChkTRFImage.Checked == true)
            {
                SavePicture = 1;
            }

            lstDispatchDetails = CreateDespatchMode();
            if (hdnIsReceptionPhlebotomist.Value == "")
                hdnIsReceptionPhlebotomist.Value = "N";
            //  PageContextDetails.isActionDisabled = !chkMobileNotify.Checked;
            //DateTime dtSampleDate = (txtSampleDate.Text.Trim().ToLower() == "dd/mm/yyyy" || txtSampleDate.Text.Trim() == "") ? Convert.ToDateTime("01/01/1753") : Convert.ToDateTime(txtSampleDate.Text.Trim());
            dtSampleDate = (txtSampleDate.Text.Trim().ToLower() == "dd/mm/yyyy" || txtSampleDate.Text.Trim() == "") ? Convert.ToDateTime("01/01/1753") : Convert.ToDateTime(txtSampleDate.Text.Trim());
            long TodayVisitID = -1;

            if (hdnOrgID.Value == NewOrgID.ToString())
            {
                Int64.TryParse(hdnTodayVisitID.Value, out TodayVisitID);
            }
            else if (hdnDoFrmVisit.Value != "" && hdnDoFrmVisit.Value != null)
            {
                Int64.TryParse(hdnDoFrmVisit.Value, out TodayVisitID);
            }
            //else if (hdnOrgID.Value == OrgID.ToString())
            //{
            //    Int64.TryParse(hdnTodayVisitID.Value, out TodayVisitID);
            //}
            else
            {

                TodayVisitID = -1;
            }

            string IsSamplePickUP = (chkSamplePickup.Checked) ? "Y" : "N";

            string externalVisitID = string.Empty;
            if (string.IsNullOrEmpty(txtExternalVisitID.Text))
            {
                externalVisitID = "";
            }
            else
            {
                externalVisitID = txtExternalVisitID.Text.Trim();
            }
            string approvalNo = string.Empty;
            if (string.IsNullOrEmpty(txtApprovalNo.Text))
            {
                approvalNo = "";
            }
            else
            {
                approvalNo = txtApprovalNo.Text.Trim();
            }

            lstPatientRedemDetails = billPart.redeemPointsDetails();

            //if (hdnMycarddetailsSave.Value != "")
            //{
            //    string[] strMycardDetails = hdnMycarddetailsSave.Value.TrimEnd('|').Split('|');
            //    for (int i = 0; i <= strMycardDetails.Length - 2; i++)
            //    {

            //        PatientRedeem = new PatientRedemDetails();
            //        PatientRedeem.Finalbillid = 0;
            //        PatientRedeem.MembershipCardMappingID = Convert.ToInt32(strMycardDetails[i].Split('~')[0].ToString());
            //        PatientRedeem.PatientID = Convert.ToInt64(strMycardDetails[i].Split('~')[1].ToString());
            //        PatientRedeem.RedemPoints = Convert.ToDecimal(strMycardDetails[i].Split('~')[2].ToString());
            //        PatientRedeem.RedemValue = Convert.ToDecimal(strMycardDetails[i].Split('~')[3].ToString()); ;
            //        PatientRedeem.VisitID = 0;
            //        lstPatientRedemDetails.Add(PatientRedeem);
            //    }
            //}

            List<VisitTemplate> visittemplate = new List<VisitTemplate>();
            String IsCopay = String.Empty;
            if (HdnCoPay.Value == "Y") { IsCopay = HdnCoPay.Value; } else { IsCopay = ""; }
            List<PatientVisitLanguage> objlang = new List<PatientVisitLanguage>();
            if (lstPatientDueChart.Count > 0 || hdnIsEditMode.Value == "Y")
            {
                if (lst.Count > 0)
                {
                    ContextInfo.AdditionalInfo = lst[0].Remarks;
                }
                hdnDue.Value = objFinalBill.Due.ToString();
                ContextInfo.DepartmentName = hdnBookedID.Value;
                new Patient_BL(base.ContextInfo).InsertPatientBilling(objPatient, objFinalBill, Convert.ToInt64(hdnReferedPhyID.Value),
                                                    Convert.ToInt32(hdnRefPhySpecialityID.Value), pSpecialityID, lstPatientDueChart, AgeValue, AgeUnit,
                                                    pSpecialityID, ReferralType, paymentstatus, gUID, dtAmountReceivedDet, lstInv, lstTaxDetails,
                                                    out lstBillingDetails, out returnStatus, SavePicture, sVal, RoleID, LID, PageContextDetails,
                                                    "N", Convert.ToInt16(ddlIsExternalPatient.SelectedValue),
                                                    txtWardNo.Text, 0, 0, 0, Incompleteflag, "", dtSampleDate, "", new List<ControlMappingDetails>(),
                                                    hdnIsEditMode.Value, out needTaskDisplay, lstDispatchDetails, lst, out PatientRoleID,
                                                    Convert.ToInt64(hdnClienID.Value), TodayVisitID, IsSamplePickUP, externalVisitID, approvalNo,
                                                     out taskID, IsCopay, lstPatientDiscount, strMyCardActiveDays, strMemebershipcardType,
                                                    strHealthCardType, strOTP, strStatus, MembershipCardMappingID, strCreditRedeemTye,
                                                    RedeemPatientid, RedeemVisitid, RedeemOrgId, RedemPoints, RedemValue, lstPatientRedemDetails,
                                                    lstPkgandGrps, StatFlag, ClientFlag, 0, "", "", "", "", visittemplate, objlang,"","","");
                hdnEditBill.Value = "N";

                //Added by Thamilselvan for chcking the MembershipcardNo....on Feb 1 2015
                hdnMemberShipCardNo.Value = lstBillingDetails[0].BatchNo;
                //-------------------------


                //
                if (hdnIsEditDeFlag.Value == "Y")
                {
                    for (int k = 0; k < lstBillingDetails.Count(); k++)
                    {
                        new Patient_BL(base.ContextInfo).RegistrationDeflag(lstBillingDetails[k].VisitID, OrgID);
                    }
                }
                 //PatientHistorySave
                if (hdnConfigCapturehistory.Value == "Y")
                {
                    List<CapturePatientHistory> lstHistoryAttributes = new List<CapturePatientHistory>();
                    List<CapturePatientHistory> lstHA = new List<CapturePatientHistory>();
                    JavaScriptSerializer JSserializer = new JavaScriptSerializer();
                    string[] StrJson = hdnPatientHistory.Value.Split('~');
                    string[] strDisplayTblID = hdnDisplayTblID.Value.Split('^');
                    foreach (var item in StrJson)
                    {
                        if (!string.IsNullOrEmpty(item))
                        {
                            lstHA = JSserializer.Deserialize<List<CapturePatientHistory>>(item).ToList();
                            foreach (var strItem in strDisplayTblID)
                            {
                                string[] strValue = strItem.Split('~');
                                if (strValue[0] != "")
                                {
                                    long SplInvID = strValue[1] == "" ? 0 : Convert.ToInt64(strValue[1]);
                                    if (SplInvID == lstHA[0].InvestigationID)
                                    {
                                        lstHistoryAttributes = lstHistoryAttributes.Concat(lstHA).ToList();
                                    }
                                }
                            }
                        }
                    }
                    if (lstHistoryAttributes.Count > 0)
                    {
                        new Patient_BL(base.ContextInfo).SaveCapturePatientHistory(lstHistoryAttributes, OrgID, lstBillingDetails[0].VisitID);
                    }
                }

                if (hdnIsEditRePush.Value == "Y")
                {
                    for (int k = 0; k < lstBillingDetails.Count(); k++)
                    {
                        PageContextDetails.PatientID = lstBillingDetails[k].PatientID;
                        PageContextDetails.PatientVisitID = lstBillingDetails[k].VisitID;
                        PageContextDetails.FinalBillID = lstBillingDetails[k].FinalBillID;
                        PageContextDetails.BillNumber = lstBillingDetails[k].FinalBillID.ToString();
                        PageContextDetails.ID = LID;// Assign OrgAdressID
                        if (hdnIsEditDeFlag.Value == "Y")
                        {
                            PageContextDetails.isActionDisabled = true;
                        }
                        else
                        {
                            PageContextDetails.isActionDisabled = false;
                        }

                        ActionManager objActionManager = new ActionManager(base.ContextInfo);
                        // objActionManager.PerformingNextStep(PageContextDetails);
                        objActionManager.PerformingNextStepNotification(PageContextDetails, "", "");
                    }
                }
                //
                Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
                if (Request.QueryString["RCP"] == "Y")
                {
                    if (tbl.isTaskAlreadyPicked(taskID, TaskHelper.TaskStatus.Pending, TaskHelper.TaskStatus.InProgress, LID))
                    {

                    }
                }
                hdntaskID.Value = taskID.ToString();
                string sValMltDis = GetConfigValue("HaveMultipleDiscount", OrgID);
                if (sValMltDis == "Y")
                {
                    FnSavePatientDiscount(lstBillingDetails);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alrUpdateSucess", "ValidationWindow('" + strOrderedListCannotBilled.Trim() + "','" + strAlert.Trim() + "');reloadPage();", true);
            }

            String VisitNumber = String.Empty;


            if (lstBillingDetails.Count > 0 && returnStatus >= 0 && hdnIsEditMode.Value == "N")
            {
                long PatientID = -1;
                PatientID = lstBillingDetails[0].PatientID;
                patientVisitID = lstBillingDetails[0].VisitID;
                //Added By Arivalagan.kk for  labNo is borcode byte///
                String ExternalVisitBarcodeImg = String.Empty;
                ExternalVisitBarcodeImg = GetConfigValue("ExternalVisitBarcodeImg", OrgID);
                if (ExternalVisitBarcodeImg == "Y")
                {
                    new BarcodeHelper().SaveReportBarcode(patientVisitID, OrgID, lstBillingDetails[0].LabNo, "PVN");
                }
                else
                {
                    new BarcodeHelper().SaveReportBarcode(patientVisitID, OrgID, lstBillingDetails[0].VersionNo, "PVN");
                }

                //End Added By Arivalagan.kk for  labNo is borcode byte///

                if (!String.IsNullOrEmpty(lstBillingDetails[0].BatchNo) && lstBillingDetails[0].FeeId != 0)
                {
                    new BarcodeHelper().SaveReportBarcode(lstBillingDetails[0].FeeId, OrgID, lstBillingDetails[0].BatchNo, "HCNO");
                }

                if (Request.QueryString["BKNO"] != null)
                {
                    long BKNO = Convert.ToInt64(Request.QueryString["BKNO"]);
                    if (patientVisitID > 0)
                    {
                        string status = string.Empty;
                        status = "R";
                        new Investigation_BL(base.ContextInfo).UpdateHomeCollectiondetails(BKNO, patientVisitID, status, PatientID);
                    }
                }


                Labno = lstBillingDetails[0].LabNo;
                FinalBillID = lstBillingDetails[0].FinalBillID;
                hdnVisitID.Value = lstBillingDetails[0].VisitID.ToString();
                hdnFinalBillID.Value = lstBillingDetails[0].FinalBillID.ToString();
                patientID = lstBillingDetails[0].PatientID;
                patientVisitID = lstBillingDetails[0].VisitID;
                VisitNumber = lstBillingDetails[0].VersionNo;
                hdnvisitnumber.Value = lstBillingDetails[0].VersionNo.ToString();
                if (ChkTRFImage.Checked == true)
                {
                    SaveTRFPicture(Convert.ToString(PatientID), Convert.ToString(patientVisitID), VisitNumber);
                }
                if (lstInvHistoryAttributes.Count > 0)
                {

                    SaveHistory(patientID, patientVisitID, lstInvHistoryAttributes);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ClearHistory", "clearHistoryHiddenvalues();", true);
                    lstInvHistoryAttributes.Clear();
                }
                vpurpose = int.Parse(hdnVisitPurposeID.Value);
                //   SaveTRFPicture(Convert.ToString(PatientID), Convert.ToString(patientVisitID), VisitNumber);
                ddlClientName = txtClient.Text;
                try
                {
                    PageContextDetails.PatientID = Convert.ToInt64(patientID);
                    PageContextDetails.PatientVisitID = Convert.ToInt64(patientVisitID);
                    PageContextDetails.RoleID = PatientRoleID;
                    ActionManager am = new ActionManager(base.ContextInfo);
                    // returnCode = am.PerformingNextStep(PageContextDetails);
                    //   returnCode = am.PerformingNextStepNotification(PageContextDetails, "", "");
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error While Sending Email", ex);
                }
                if (hdnIsReceptionPhlebotomist.Value == "Y" && needTaskDisplay == 1)
                {
                    hdnBillGenerate.Value = "Y";
                    trCollectSample.Attributes.Add("display", "table");
                    tblDatepicker.Style.Add("display", "table");
                    trCollectSample.Attributes.Add("display", "table");
                    UserControl UC_DatePicker = (UserControl)this.Page.FindControl("DateTimePicker1");
                    TextBox SampleDate1 = (TextBox)UC_DatePicker.FindControl("txtSampleDateCollect");
                    TextBox SampleTime11 = (TextBox)UC_DatePicker.FindControl("txtSampleTime1");
                    TextBox SampleTime22 = (TextBox)UC_DatePicker.FindControl("txtSampleTime2");
                    DropDownList SampleTimeType1 = (DropDownList)UC_DatePicker.FindControl("ddlSampleTimeType");
                    DateTime dt = new DateTime();
                    if (chkSamplePickup.Checked == false)
                    {
                        dt = Convert.ToDateTime(OrgDateTimeZone);
                    }
                    else
                    {
                        dt = Convert.ToDateTime(dtSampleDate);
                    }
                    SampleDate1.Text = dt.ToShortDateString();
                    string Time = dt.ToString("hh:mm:tt");
                    string[] SplitTime = Time.Split(':');
                    SampleTime11.Text = SplitTime[0];
                    SampleTime22.Text = SplitTime[1];
                    SampleTimeType1.SelectedValue = SplitTime[2].ToString();

                    SampleDate1.Attributes.Add("onblur", "SetDateTimeDetails();");
                    SampleTime11.Attributes.Add("onblur", "SetDateTimeDetails();");
                    SampleTime22.Attributes.Add("onblur", "SetDateTimeDetails();");
                    SampleTimeType1.Attributes.Add("onchange", "SetDateTimeDetails();");
                    loadCollectSampleList(patientVisitID, gUID);
                    hdnGuID.Value = gUID;
                    btnFinish.Attributes.Add("onclick", "return GenerateWorkOrder(" + OrgID + "," + LID + "," + ILocationID + "," + patientVisitID + ",'" + gUID + "','" + strCollectAgain + "','" + strSampleRelationshipID + "')");
                }
                else if (Request.QueryString["CPEDIT"] == "Y")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alrUpdateSucess", "ValidationWindow('" + strUpdatedSuccess + "','" + strAlert.Trim() + "');javascript:labQuickBilling();", true);
                }
                else
                {
                    PrintBilling(patientID, patientVisitID, FinalBillID, vpurpose, ddlClientName);
                }
                if (lstPatHisAttributes.Count > 0)
                {
                    returnCode = patientBL.SavePATAttributes(lstPatHisAttributes, patientVisitID);
                }
            }
            else if (hdnIsEditMode.Value == "Y")
            {
                if (ChkTRFImage.Checked == true)
                {
                    string VisitID = string.Empty;
                    new Patient_BL(base.ContextInfo).GetPatientVisitNumber(patientID, out VisitID, out VisitNumber);

                    SaveTRFPicture(Convert.ToString(patientID), Convert.ToString(VisitID), VisitNumber);
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alrUpdateSucess", "ValidationWindow('" + strUpdatedSuccess.Trim() + "','" + strAlert.Trim() + "');redirectPage();", true);
            }
            else
            {
                CLogger.LogWarning("Lab Quick Billing Error Part Start");
                CLogger.LogWarning(lstBillingDetails.Count.ToString());
                CLogger.LogWarning(returnStatus.ToString());
                CLogger.LogWarning(hdnIsEditMode.Value.ToString());
                CLogger.LogWarning("Lab Quick Billing Error Part End");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "altSaveFailed", "ValidationWindow('" + strErrorDataSaving.Trim() + "','" + strAlert.Trim() + "');clearPageControlsValue('N');", true);
            }


        }
        catch (Exception ex)
        {

            CLogger.LogError("Error While Saving SaveData() Method Lab Quick Billing", ex);
        }
        finally {
            hdnPatientHistory.Value = string.Empty;
            hdnDisplayTblID.Value = string.Empty;
        }
    }
    void GetPageValues()
    {
        billPart.IsClientSelected = txtClient.Text.Trim() == "" ? "N" : "Y";
        billPart.MappingClientID = Convert.ToInt64(hdnMappingClientID.Value);
        billPart.RateID = Convert.ToInt32(hdnRateID.Value);
        billPart.ClientID = Convert.ToInt64(hdnSelectedClientClientID.Value);
        //billPart.DespatchMode = CreateDespatchMode(); //Convert.ToInt32(ddlDespatchMode.SelectedItem.Value);
        Int64 clientID = 0;
        Int64.TryParse(hdnSelectedClientClientID.Value, out clientID);
        if (clientID == 0)
        {
            Int64.TryParse(hdnBaseClientID.Value, out clientID);
        }
        billPart.ClientID = clientID;
        billPart.getUserControlValue();

    }
    public void PrintBilling(long PatientID, long patientVisitID, long FinalBillID, long vpurpose, string ddlClientName)
    {
        strHealthCoupon = GetConfigValue("HealthcardCoupon", OrgID);
        //if (strHealthCoupon == "Y")
        //{
        //    string BookingNo = hdnBookingNo.Value;
        //    //iframeplaceholderForBillReport.Attributes["src"] = "~/Investigation/BillPrint.aspx.cs" + "&vid=" + patientVisitID.ToString()
        //    //                  + "&pagetype=BP&quickbill=N&bid=" + FinalBillID + "&visitPur=" + vpurpose + "&ClientName=" + ddlClientName + "&OrgID=" + OrgID + "&BKNO=" + BookingNo + "&IsPopup=Y";
        //    //Response.Redirect(iPageUrl + "&POrgID=" + iOrgid, true);

        //    //string iPageUrl = string.Empty;
        //    //iPageUrl = "..\\Investigation\\BillPrint.aspx" + "?vid=" + patientVisitID.ToString()
        //    //                   + "&pagetype=BP&quickbill=N&bid=" + FinalBillID + "&visitPur=" + vpurpose + "&ClientName=" + ddlClientName + "&OrgID=" + OrgID + "&BKNO=" + BookingNo + "&IsPopup=Y";
        //    //     iframeplaceholderForBillReport.Attributes["src"] = iPageUrl;
        //    //    Response.Redirect(iPageUrl, true);
        //    //Response.Redirect(iPageUrl + "&vid=" + patientVisitID.ToString()
        //    //                  + "&pagetype=BP&quickbill=N&bid=" + FinalBillID + "&visitPur=" + vpurpose + "&ClientName=" + ddlClientName + "&OrgID=" + OrgID + "&BKNO=" + BookingNo + "&IsPopup=Y", true);

        //    //hdnUrl.Value = iPageUrl;
        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:OpenIframe('" + FinalBillID.ToString() + "','" + patientVisitID.ToString() + "');", true);
        //    return;

        //}
        //else
        //{
        //Added the hdnMemberShipCardNo by Thamilselvan.R to check the Patient Coopon No....While Generate the Bill to Open the Print Popups....

        //Command by new requirement
        string strSsrsShowReport = string.Empty;
        strSsrsShowReport = GetConfigValue("B2CSSRSFILLFORMAT", OrgID);
        string Dummybill = GetConfigValue("Dummybill", OrgID);
        long lresutl = -1;
        BillingEngine BillingBl = new BillingEngine(new BaseClass().ContextInfo);
        List<InvClientMaster> lstclientforbill = new List<InvClientMaster>();
        if (strSsrsShowReport == "Y")
        {
            string BookingNo = hdnBookingNo.Value;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:clearPageControlsValue('N');ClearControlValues();OpenIframe('" + FinalBillID.ToString() + "','" + patientVisitID.ToString() + "');", true);
        }
        else
        {
            string sPage = string.Empty;
            string sPage1 = string.Empty;
            string IsCreditBill = billPart.IsCreditBill;
            string NeedBillPrintForClient = GetConfigValue("NeedPrintForClient", OrgID);
            string NoNeedBillPrint = GetConfigValue("NoNeedBillPrint", OrgID);
            string BookingNo = hdnBookingNo.Value;

            string prefixText = txtClient.Text;
            string pType = "CLI";
            long refhospid = -1;
            lresutl = BillingBl.GetRateCardForBilling(prefixText, OrgID, pType, refhospid, out lstclientforbill);
            if (string.IsNullOrEmpty(NeedBillPrintForClient) || NeedBillPrintForClient == "Y")
            {
                NeedBillPrintForClient = "Y";
            sPage = "../Reception/PrintPage.aspx?pid=" + PatientID.ToString()
                        + "&vid=" + patientVisitID.ToString()
                               + "&pagetype=BP&quickbill=N&bid=" + FinalBillID + "&visitPur=" + vpurpose + "&ClientName=" + ddlClientName + "&OrgID=" + OrgID + "&BKNO=" + BookingNo + "&IsPopup=Y";

                sPage1 = "../Reception/PrintPage.aspx?pid=" + PatientID.ToString()
                              + "&vid=" + patientVisitID.ToString()
                              + "&pagetype=BP&quickbill=N&bid=" + FinalBillID + "&visitPur=" + vpurpose + "&ClientName=" + ddlClientName + "&OrgID=" + OrgID + "&BKNO=" + BookingNo + "&IsPopup=Y";
            string sPages = string.Empty;
                string sPages1 = string.Empty;
            sPages = sPage + "&IsNeedInv=Y" + "&RedirectPage=/Billing/LabQuickBilling.aspx";
                sPages1 = sPage1 + "&IsNeedInv=Y" + "&RedirectPage=/Billing/LabQuickBilling.aspx";
            sPage = sPage.Replace(" ", "&nbsp;");
            if (NoNeedBillPrint != "Y")
            {
                if (IsCreditBill == "Y")
                {
                    if (NeedBillPrintForClient == "Y")
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:clearPageControlsValue('N');OpenBillPrint('" + sPage + "');ClearControlValues();", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:clearPageControlsValue('N');ClearControlValues();", true);
                    }
                }
                else
                {
                        if (Dummybill == "Y" && txtClient.Text != "" && hdnDefaultClienID.Value != "" && lstclientforbill[0].Value.Split('^')[40] == "MRPBill")
                        {
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:clearPageControlsValue('N');OpenBillPrint('" + sPage + "');OpenBillPrint_Check('" + sPage1 + "');ClearControlValues();", true);
                        }
                        else
                        {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:clearPageControlsValue('N');OpenBillPrint('" + sPage + "');ClearControlValues();", true);
                }
            }
                }
            else
            {
                    string sPage12 = string.Empty;
                    //Response.Redirect(Request.ApplicationPath  + hdnPageUrl.Value, true);
                    string AlertMesg = "Patient VID: " + hdnvisitnumber.Value;

                    sPage12 = "../Reception/PrintPage.aspx?pid=" + patientID.ToString()
                                + "&vid=" + patientVisitID.ToString()
                                + "&pagetype=BP&quickbill=N&bid=" + FinalBillID + "&visitPur=" + vpurpose + "&ClientName=" + ddlClientName + "&OrgID=" + OrgID + "&IsPopup=Y" + "&RedirectPage=/Billing/LabQuickBilling.aspx";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:clearPageControlsValue('N');ClearControlValues();alert('" + AlertMesg + "');", true);
                    string sPages123 = string.Empty;
                    sPages123 = sPage12 + "&IsNeedInv=Y" + "&RedirectPage=/Billing/LabQuickBilling.aspx";
            }
        }

        ClearValues();
        ctlCollectSample.ResetData();


        long BKNO = Convert.ToInt64(Request.QueryString["BKNO"]);

        if (BKNO > 0)
        {
            ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:labQuickBilling();", true);
        }
        }
    }
    public Patient GetPatientDetails()
    {
        Patient patient = new Patient();

        try
        {
            UserAddress useAddress = new UserAddress();
            short CountryID;
            short StateID;
            PatientAddress PA = new PatientAddress();
            Int16 age = 0;
            DateTime DOB = new DateTime();
            if (btnGenerate.Text == "Update" && txtDOBNos.Text == "")
            {
                if (chkIncomplete.Checked)
                {
                    hdnEdtPatientAge.Value = "0";
                }
            }
            if (txtDOBNos.Text == "")
            {
                if (hdnEdtPatientAge.Value != "0")
                {
                    objPatient.Age = hdnEdtPatientAge.Value.ToString() + "~" + hdnEditDDlDOB.Value.ToString();
                }
                else if (hdnEdtPatientAge.Value == "0" && txtDOBNos.Text == "")
                {
                    objPatient.Age = "";
                }
                else
                {
                    objPatient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
                }
                if (chkIncomplete.Checked == true)
                {
                    objPatient.Age = "~" + ddlDOBDWMY.SelectedValue.ToString();
                }
            }
            else
            {
                objPatient.Age = txtDOBNos.Text.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
            }

            List<PatientAddress> pAddresses = new List<PatientAddress>();
            Int32 PhleboId = -1;
            Int32 logisticsId = -1;
            String RoundNo = String.Empty;

            if (hdnEdtPatientAge.Value != "0" && txtDOBNos.Text != "")
            {
                string[] tempAge;

                string[] SplitAge = objPatient.Age.Split('~');
                tempAge = SplitAge[0].Split('.');
                AgeValue = Convert.ToInt32(tempAge[0]);

                if (SplitAge[1].Trim() == "Day(s)")
                {
                    AgeUnit = "D";
                }
                else if (SplitAge[1].Trim() == "Week(s)")
                {
                    AgeUnit = "W";
                }
                else if (SplitAge[1].Trim() == "Month(s)")
                {
                    AgeUnit = "M";
                }
                else
                {
                    AgeUnit = "Y";
                }
            }
            else
            {
                AgeUnit = "";
            }

            string finalPName = txtName.Text.Trim().ToString();
            
            int NewOrgID = 0;
            NewOrgID = Convert.ToInt32(hdnNewOrgID.Value.ToString());
            if (btnGenerate.Text != "Update" && hdnEditBill.Value == "N")
            {
                if (hdnDoFrmVisit.Value == "" && hdnDoFrmVisit.Value != null)
                {
                    NewOrgID = 0;
                }
            }
            if (btnGenerate.Text == "Generate Bill" && hdnEditBill.Value == "N")
            {
                if (hdnDoFrmVisit.Value == "" && hdnDoFrmVisit.Value != null)
                {
                    NewOrgID = 0;
                }
            }
            if (hdnOrgID.Value == NewOrgID.ToString())
            {
                patient.PatientID = Convert.ToInt64(hdnPatientID.Value);
            }
            else if (hdnDoFrmVisit.Value != "" && hdnDoFrmVisit.Value != null)
            {
                patient.PatientID = Convert.ToInt64(hdnPatientID.Value);
            }
            else if (Convert.ToInt64(hdnPatientID.Value) > 0 && hdnPatientID.Value != "" && hdnPatientID.Value != "-1")
            {
                patient.PatientID = Convert.ToInt64(hdnPatientID.Value);
            }
            //else if (hdnOrgID.Value == OrgID.ToString())
            //{
            //    patient.PatientID = Convert.ToInt64(hdnPatientID.Value);
            //}
            else
            {
                patient.PatientID = -1;
            }
            patient.OrgID = OrgID;
            patient.CreatedBy = LID;
            patient.Name = finalPName;
            //patient.TITLECode = Convert.ToByte(ddSalutation.SelectedValue);
            if (hdnddlsalutation.Value != "0")
            {
                patient.TITLECode = Convert.ToByte(hdnddlsalutation.Value);
            }
            else
            {
                patient.TITLECode = Convert.ToByte(ddSalutation.SelectedValue);
            }
            string CPEDIT = string.Empty;
            CPEDIT = Request.QueryString["CPEDIT"];
            if (CPEDIT == "Y")
            {
                patient.SEX = hdnEditSex.Value;
            }
            else
            {
                if (ddlSex.SelectedValue != "0")
                {
                    patient.SEX = ddlSex.SelectedValue;
                }
                else
                {
                    patient.SEX = hdnEditSex.Value;
                }
            }
            if (tDOB.Text == "" && chkIncomplete.Checked == false)
            {
                tDOB.Text = hdnPatientDOB.Value;
            }
            else
            {

            }
            
            DOB = new DateTime(1800, 1, 1);
            string Date = tDOB.Text.Trim() == "" ? "01/01/1800" : tDOB.Text.Trim();
            if (Date != "dd//MM//yyyy")
            {
                patient.DOB = Convert.ToDateTime(Date);
            }
            Int16.TryParse(txtDOBNos.Text.Trim(), out age);
            if (txtDOBNos.Text == "")
            {
                if (hdnEdtPatientAge.Value != "0")
                {
                    objPatient.Age = hdnEdtPatientAge.Value.ToString() + "~" + hdnEditDDlDOB.Value.ToString();
                }
                else if (hdnEdtPatientAge.Value == "0" && txtDOBNos.Text == "")
                {
                    objPatient.Age = "";
                }
                else
                {
                    objPatient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
                }
                if (chkIncomplete.Checked == true)
                {
                    objPatient.Age = "~" + ddlDOBDWMY.SelectedValue.ToString();
                }
            }
            else
            {
                objPatient.Age = txtDOBNos.Text.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
            }

            if (hdnOrgID.Value == NewOrgID.ToString())
            {
                patient.PatientNumber = hdnPatientNumber.Value;
            }
            else if (hdnDoFrmVisit.Value != "" && hdnDoFrmVisit.Value != null)
            {
                patient.PatientNumber = hdnPatientNumber.Value;
            }
            else if (hdnPatientNumber.Value != "" && hdnPatientNumber.Value != null && Convert.ToInt64(hdnPatientID.Value) > 0)
            {
                patient.PatientNumber = hdnPatientNumber.Value;
            }
            //else if (hdnOrgID.Value == OrgID.ToString())
            //{
            //    patient.PatientNumber = hdnPatientNumber.Value;
            //}
            else
            {
                patient.PatientNumber = "0";
            }

            PA.Add1 = txtAddress.Text.Trim();
            PA.Add2 = txtSuburban.Text.Trim();
            PA.City = txtCity.Text.Trim();
            patient.Add3 = "";
            PA.AddressType = "P";
            PA.LandLineNumber = txtPhone.Text.Trim();
            PA.MobileNumber = txtMobileNumber.Text.Trim();
            hdnMobileNumber.Value = txtMobileNumber.Text;
            Int16.TryParse(ddCountry.SelectedValue, out CountryID);
            //Int16.TryParse(ddState.Value, out StateID);
            Int16.TryParse(hdnPatientStateID.Value, out StateID);
            PA.CountryID = CountryID;
            PA.StateID = StateID;
            pAddresses.Add(PA);
            patient.PatientAddress = pAddresses;
            if (CPEDIT == "Y")
            {
                patient.MartialStatus = hdnEditddMarital.Value;
            }
            else
            {
                patient.MartialStatus = ddMarital.SelectedValue.ToString();
            }
            patient.CompressedName = finalPName.ToString();
            patient.Nationality = Convert.ToInt64(ddlNationality.SelectedValue);
            patient.StateID = StateID;
            patient.CountryID = CountryID;
            patient.PostalCode = txtPincode.Text;
            patient.RegistrationFee = 0;
            patient.SmartCardNumber = "0";
            patient.RelationName = "";
            patient.RelationTypeId = 0;
            patient.Race = "";
            patient.EMail = txtEmail.Text;
            //if (chkMobileNotify.Checked)
            //{
            //    patient.NotifyType = 1;

            //}
            //else
            //{
            //    patient.NotifyType = 0;
            //}
            patient.NotifyType = 0;

            if (txtURNo.Text.Trim() != "")
            {
                patient.URNO = txtURNo.Text;
                patient.URNofId = Convert.ToInt64(ddlUrnoOf.SelectedValue);
                patient.URNTypeId = Convert.ToInt64(ddlUrnType.SelectedValue);
            }
            else
            {
                patient.URNO = "";
                patient.URNofId = 0;
                patient.URNTypeId = 0;
            }
            patient.VisitPurposeID = 3;
            //ClientID = hdnClientID.Value == "-1" ? Convert.ToInt32(hdnBaseClientID.Value) : Convert.ToInt32(hdnClientID.Value);
            ClientID = Convert.ToInt32(hdnSelectedClientClientID.Value);
            patient.ClientID = ClientID;
            patient.SecuredCode = System.Guid.NewGuid().ToString();
            patient.RateID = Convert.ToInt32(hdnRateID.Value);
            patient.PriorityID = ddlPriority.SelectedValue;
            patient.ReferingPhysicianName = txtInternalExternalPhysician.Text;
            patient.ReferedHospitalID = Convert.ToInt32(hdfReferalHospitalID.Value);
            patient.ReferedHospitalName = txtReferringHospital.Text;
            patient.TPAID = Convert.ToInt64(hdnTPAID.Value);
            patient.TPAName = "";
            patient.TypeName = hdnClientType.Value;
            patient.TPAAttributes = "";
            patient.PatientVisitID = Convert.ToInt32(HDPatientVisitID.Value);
            if (hdnIsEditMode.Value == "N")
            {
                patient.PatientHistory = billPart.PatientHistory;
                patient.RegistrationRemarks = billPart.Remarks;
            }
            else
            {
                string s = EdittxtRemarks.Text.Trim() == "" ? "" : EdittxtRemarks.Text;
                string S1 = Regex.Replace(s, " {2,}", " ");
                patient.RegistrationRemarks = EdittxtRemarks.Text.Trim() == "" ? "" : EdittxtRemarks.Text;
                patient.PatientHistory = EditPatientHistory.Text.Trim() == "" ? "" : EditPatientHistory.Text;

            }
            patient.PatientType = ddlPatientType.SelectedValue;
            patient.PatientStatus = ddlPatientStatus.SelectedValue;
            patient.ExternalPatientNumber = txtExternalPatientNumber.Text.Trim();
            if (hdnEdtPhleboID.Value == "-1")
            {
                txtPhleboName.Text = "";

            }
            else if (hdnEdtPhleboID.Value != "-1" && txtPhleboName.Text != "")
            {
                if (hdnEdtLogisticsID.Value != "")
                {
                    patient.PhleboID = Convert.ToInt32(hdnEdtPhleboID.Value);
                }
            }
            if (HdnPhleboName.Value != "" && HdnPhleboID.Value != "")
            {
                patient.PhleboID = Convert.ToInt32(HdnPhleboID.Value);
            }
            else
            {
                if (hdnEdtPhleboID.Value == "-1")
                {
                    patient.PhleboID = PhleboId;
                }
            }


            if (txtRoundNo.Text != "")
            {
                patient.RoundNo = txtRoundNo.Text.ToString();
            }
            else
            {
                patient.RoundNo = "";
            }

            if (hdnEdtLogisticsID.Value == "-1")
            {
                txtLogistics.Text = "";

            }
            else if (hdnEdtLogisticsID.Value != "-1" && txtLogistics.Text != "")
            {
                if (hdnEdtLogisticsID.Value != "")
                {
                    patient.LogisticsID = Convert.ToInt32(hdnEdtLogisticsID.Value);
                }
            }
            if (hdnLogisticsName.Value != "" && hdnLogisticsID.Value != "")
            {
                patient.LogisticsID = Convert.ToInt32(hdnLogisticsID.Value);
            }
            else
            {
                if (hdnEdtLogisticsID.Value == "-1")
                {
                    patient.LogisticsID = logisticsId;
                }
            }



            if (chkExcludeAutoathz.Checked == true)
            {
                patient.ExAutoAuthorization = "Y";
            }
            else
            {
                patient.ExAutoAuthorization = "N";
            }
            string CPEDITS = string.Empty;
            if (Request.QueryString["CPEDIT"] != null && Request.QueryString["CPEDIT"] != "")
            {
                CPEDITS = Request.QueryString["CPEDIT"];
            }
            if (CPEDITS == "Y")
            {
                if (Request.QueryString["VID"] != null || Request.QueryString["VID"] != "")
                {
                    patient.ParentPatientID = Convert.ToInt32(Request.QueryString["VID"]);
                }
            }
            else
            {
                patient.ParentPatientID = 0;
            }
            /*Random Password  29/8/2013 */
            int passwordlength = 6;
            string NewPassword = string.Empty;
            GeneratePassword objGeneratePass = new GeneratePassword();
            objGeneratePass.GenerateNewPassword(passwordlength, out NewPassword);
            patient.NewPassword = NewPassword;
            /*Random Password 29/8/2013 */
            return patient;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetPatientDetails() Method in Lab Quick Billing", ex);
            return patient;
        }
    }
    public HttpFileCollection TRFFiles()
    {
        HttpFileCollection hfc = Request.Files;
        return hfc;
    }
    private long SaveTRFPicture(String Pnumber, String visitid, String VisitNumber)
    {
        pathname = GetConfigValue("TRF_UploadPath", OrgID);
        long returncode = -1;
        try
        {
            //Modified / By Arivalagan K//

            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(OrgDateTimeZone);

            int Year = dt.Year;
            int Month = dt.Month;
            int Day = dt.Day;

            //Root Path =D:\ATTUNE_UPLOAD_FILES\TRF_Upload\67\2013\10\9\123456\14_A.pdf

            String Root = String.Empty;
            String RootPath = String.Empty;
            //Root = ATTUNE_UPLOAD_FILES\TRF_Upload\ + OrgID + '\' + Year + '\' + Month + '\' + Day + '/' + Visitnumber ;
            Root = "TRF_Upload-" + OrgID + "-" + Year + "-" + Month + "-" + Day + "-" + VisitNumber + "-";
            Root = Root.Replace("-", "\\\\");
            RootPath = pathname + Root;
            //ENd///


            HttpFileCollection hfc = TRFFiles();

            for (int i = 0; i < hfc.Count; i++)
            {
                if (hfc.AllKeys[i] == "FileUpload1")
                {
                    HttpPostedFile hpf = hfc[i];
                    if (hpf.ContentLength > 0)
                    {
                        string fileName = Path.GetFileNameWithoutExtension(hpf.FileName);
                        string fileExtension = Path.GetExtension(hpf.FileName);
                        //string imagePathname = ConfigurationManager.AppSettings["UploadPath"];
                        //string imagePath = imagePathname + pathname;
                        //string imagePath = pathname;
                        string picNameWithoutExt = Pnumber + '_' + visitid + '_' + OrgID + '_' + fileName;
                        string pictureName = string.Empty;
                        string filePath = string.Empty;
                        Response.OutputStream.Flush();
                        if (!System.IO.Directory.Exists(RootPath))
                        {
                            System.IO.Directory.CreateDirectory(RootPath);
                        }
                        //string[] fileNames = Directory.GetFiles(imagePath, picNameWithoutExt + ".*");
                        string[] fileNames = Directory.GetFiles(RootPath, picNameWithoutExt + ".*");
                        foreach (string path in fileNames)
                        {
                            File.Delete(path);
                        }
                        string imageExtension = ".GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD";
                        if (imageExtension.Contains(fileExtension.ToUpper()))
                        {
                            pictureName = picNameWithoutExt + ".jpg";

                            //filePath = imagePath + pictureName;
                            filePath = RootPath + pictureName;

                            int thumbWidth = 640, thumbHeight = 480;
                            System.Drawing.Image image = System.Drawing.Image.FromStream(hpf.InputStream);
                            int srcWidth = image.Width;
                            int srcHeight = image.Height;
                            if (thumbWidth > srcWidth)
                                thumbWidth = srcWidth;
                            if (thumbHeight > srcHeight)
                                thumbHeight = srcHeight;
                            Bitmap bmp = new Bitmap(thumbWidth, thumbHeight);
                            System.Drawing.Graphics gr = System.Drawing.Graphics.FromImage(bmp);
                            gr.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                            gr.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
                            gr.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
                            gr.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
                            System.Drawing.Rectangle rectDestination = new System.Drawing.Rectangle(0, 0, thumbWidth, thumbHeight);
                            gr.DrawImage(image, rectDestination, 0, 0, srcWidth, srcHeight, GraphicsUnit.Pixel);
                            //bmp.Save(filePath, ImageFormat.Jpeg);

                            if (System.IO.Directory.Exists(RootPath))
                            {
                                bmp.Save(filePath, ImageFormat.Jpeg);
                            }
                            // hpf.SaveAs(filePath,ImageFormat.Jpeg);
                            //hdnPatientImageName.Value = pictureName;
                            gr.Dispose();
                            bmp.Dispose();
                            image.Dispose();
                        }
                        else
                        {
                            pictureName = picNameWithoutExt + fileExtension;
                            //filePath = imagePath + pictureName;
                            filePath = RootPath + pictureName;
                            hpf.SaveAs(filePath);
                        }
                        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                        int pno = int.Parse(Pnumber.ToString());
                        int Vid = int.Parse(visitid.ToString());
                        returncode = patientBL.SaveTRFDetails(pictureName, pno, Vid, OrgID, 0, "TRF_Upload", Root, LID, dt, "Y",0);
                        //hdnPatientImageName.Value = pictureName;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving SaveTRFPicture() in Lab Quick Billing", ex);

        }
        return returncode;

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
    public List<PatientDisPatchDetails> CreateDespatchMode()
    {

        List<PatientDisPatchDetails> lstDispatchDetails = new List<PatientDisPatchDetails>();
        PatientDisPatchDetails PDPD;
        foreach (ListItem li in chkDespatchMode.Items)
        {
            if (li.Selected == true)
            {
                PDPD = new PatientDisPatchDetails();
                PDPD.DispatchType = "M";
                PDPD.DispatchValue = li.Value;
                lstDispatchDetails.Add(PDPD);
            }
        }
        foreach (ListItem li in chkDisPatchType.Items)
        {
            if (li.Selected == true)
            {
                PDPD = new PatientDisPatchDetails();
                PDPD.DispatchType = "T";
                PDPD.DispatchValue = li.Value;
                lstDispatchDetails.Add(PDPD);
            }
        }
        foreach (ListItem li in ChkNotification.Items)
        {
            if (li.Selected == true)
            {
                PDPD = new PatientDisPatchDetails();
                PDPD.DispatchType = "N";
                PDPD.DispatchValue = li.Value;
                lstDispatchDetails.Add(PDPD);
            }
        }
        return lstDispatchDetails;

    }
    void ClearValues()
    {
        txtName.Text = "";
        //txtName.Focus();
        txtMobileNumber.Text = "";
        txtPhone.Text = "";
        txtAddress.Text = "";
        txtPincode.Text = "";
        txtCity.Text = "";
        txtDOBNos.Text = "";
        txtReferringHospital.Text = "";
        ddlDOBDWMY.SelectedIndex = 0;
        txtInternalExternalPhysician.Text = "";
        hdnReferralType.Value = "0";
        txtCollectionCode.Text = "";
        txtClient.Text = "";
        txtEmail.Text = "";
        hdnOPIP.Value = "OP";
        hdnPatientID.Value = "-1";
        hdnPatientNumber.Value = "-1";
        hdnVisitPurposeID.Value = "0";
        hdnClientID.Value = "-1";
        hdnTPAID.Value = "-1";
        hdnClientType.Value = "CRP";
        hdnReferedPhyID.Value = "0";
        lblPatientDetails.Text = "";
        hdnReferedPhyType.Value = "";
        lblCountryCode.Text = "";
        hdnPreviousVisitDetails.Value = "";
        lblPreviousItems.Text = "0.00";
        hdnPatientAlreadyExists.Value = "0";
        btnGenerate.Style.Add("display", "inline");
        btnClose.Style.Add("display", "inline");
        //tDOB.Text = "dd//MM//yyyy";
        ddSalutation.Focus();
        hdnPatientAlreadyExistsWebCall.Value = "0";
        // txt_DOB_TextBoxWatermarkExtender.WatermarkText = "dd/MM/yyyy";
        hdnBillGenerate.Value = "N";
        hdnLstPatientInvSample.Value = "";
        hdnLstSampleTracker.Value = "";
        hdnLstPatientInvSampleMapping.Value = "";
        hdnLstInvestigationValues.Value = "";
        hdnLstCollectedSampleStatus.Value = "";
        hdnVisitID.Value = "-1";
        hdnGuID.Value = "";
        hdnCashClient.Value = "";
        hdnSelectedClientClientID.Value = hdnBaseClientID.Value;
        txtExternalPatientNumber.Text = "";
        hdnIsMappedItem.Value = "N";
        hdfReferalHospitalID.Value = "0";
        hdnClientBalanceAmount.Value = "-1";
        hdnFinalBillID.Value = "-1";
        hdnReferedPhyName.Value = "";
        hdnReferedPhysicianCode.Value = "";
        txtSampleDate.Text = "";
        chkSamplePickup.Checked = false;
        //ddlDespatchMode.SelectedItem.Value = "0";
        txtSuburban.Text = "";
        hdnIsCashClient.Value = "N";
        hdnIsEditMode.Value = "N";
        txtURNo.Text = "";
        for (int i = chkDespatchMode.Items.Count - 1; i >= 0; i--)
            chkDespatchMode.Items[i].Selected = false;
        for (int i = ChkNotification.Items.Count - 1; i >= 0; i--)
            ChkNotification.Items[i].Selected = false;
        billPart.clearControlValues();
        //txtSampleDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
        hdnHistoryList.Value = "";
        HDPatientVisitID.Value = "0";
        txtPhleboName.Text = "";
        txtLogistics.Text = "";
        txtRoundNo.Text = "";
        chkExcludeAutoathz.Checked = false;
        HdnPhleboName.Value = "";
        hdnLogisticsName.Value = "";
        hdnLogisticsID.Value = "";
        HdnPhleboID.Value = "";
        hdnEdtLogisticsID.Value = "";
        hdnEdtPhleboID.Value = "";
        txtExternalVisitID.Text = "";
        txtApprovalNo.Text = "";
        ddMarital.SelectedValue = "0";
        ddlIsExternalPatient.SelectedValue = "0";
        txtLastName.Text = "";
        txtEntitycode.Text = "";
        txtpurposeproc.Text = "";
        txtscopeproce.Text = "";
        SetDefaultClient = GetConfigValue("SetDefaultClientForLoc", OrgID);
        chkIncomplete.Checked = false;
        if (SetDefaultClient == "Y")
        {
            LoadDefaultClientNameBasedOnOrgLocation();
        }

    }
    void LoadInvestigationHistroyDetail()
    {

        long returnCode = -1;
        long InvestigationID = 0;
        List<InvMedicalDetailsMapping> lstInvMedicalDetailsMapping = new List<InvMedicalDetailsMapping>();
        List<InvMedicalDetailsMapping> lstInvMedicalDetailsMapping1 = new List<InvMedicalDetailsMapping>();
        List<InvMedicalDetailsMapping> lstInvestigationMappingList = new List<InvMedicalDetailsMapping>();
        returnCode = PhysicianBL.GetInvestigationHistoryDetail(0, 0, InvestigationID, OrgID, "", out lstInvMedicalDetailsMapping, out lstInvestigationMappingList);



        if (lstInvestigationMappingList.Count > 0)
        {
            foreach (InvMedicalDetailsMapping item1 in lstInvestigationMappingList)
            {
                hdnHistoryList.Value += item1.InvID + "~";
            }
        }

        IEnumerable<InvMedicalDetailsMapping> lstInvHislist = (from H in lstInvMedicalDetailsMapping
                                                               join I in lstInvestigationMappingList on H.InvID equals I.InvID
                                                               select H);




        if (lstInvMedicalDetailsMapping.Count > 0)
        {
            IEnumerable<InvMedicalDetailsMapping> lstInvlist = (from S in lstInvMedicalDetailsMapping
                                                                group S by new
                                                                {
                                                                    S.MedicalDetailType,
                                                                    S.InvID,
                                                                    S.MedicalDetailID

                                                                } into g
                                                                select new InvMedicalDetailsMapping
                                                                {

                                                                    MedicalDetailType = g.Key.MedicalDetailType,
                                                                    InvID = g.Key.InvID,
                                                                    MedicalDetailID = g.Key.MedicalDetailID

                                                                }).Distinct().ToList();

            foreach (InvMedicalDetailsMapping item1 in lstInvlist)
            {
                //hdnHistoryList.Value += item1.InvID + "~";
            }
        }


    }
    public void SaveHistory(long PatientID, long patientVisitID, List<InvHistoryAttributes> lstInvHistoryAttributes)
    {
        long returnCode = -1;
        try
        {
            if (lstInvHistoryAttributes.Count > 0)
            {
                returnCode = new Patient_BL(base.ContextInfo).SaveHistoryQuickBilling(lstInvHistoryAttributes, OrgID, LID, patientVisitID, PatientID);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving SaveHistory() in Lab Quick Billing", ex);

        }
    }
    public void FnSavePatientDiscount(List<BillingDetails> Billing)
    {
        try
        {
            DataTable dtPatientDiscount = new DataTable();
            dtPatientDiscount.Columns.Add("FinalBillID", typeof(int));
            dtPatientDiscount.Columns.Add("DiscountID", typeof(int));
            dtPatientDiscount.AcceptChanges();
            string patientDiscountDtl = billPart.GetPatientDiscountDetails();
            string[] discountID = patientDiscountDtl.Split(',');
            for (int i = 1; i < discountID.Length; i++)
            {
                DataRow dr;
                dr = dtPatientDiscount.NewRow();
                dr["FinalBillID"] = int.Parse(Billing[0].FinalBillID.ToString());
                dr["DiscountID"] = decimal.Parse(discountID[i].ToString());
                dtPatientDiscount.Rows.Add(dr);
                dtPatientDiscount.AcceptChanges();
            }
            new Patient_BL(base.ContextInfo).InsertPatientDiscount(dtPatientDiscount);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While save patient discount in Lab Quick Billing", ex);
        }
    }
    public void DofreezeCTRL()
    {
        //rblSearchType_0
        rblSearchType.Enabled = false;
        //rblSearchType_1
        //rblSearchType_2
        //rblSearchType_3
        //rblSearchType_4
        ddSalutation.Enabled = false;
        txtName.Enabled = false;
        ddlSex.Enabled = false;
        tDOB.Enabled = false;
        txtDOBNos.Enabled = false;
        ddlDOBDWMY.Enabled = false;
        ddMarital.Enabled = false;
        txtMobileNumber.Enabled = false;
        txtPhone.Enabled = false;
        txtEmail.Enabled = false;
        txtAddress.Enabled = false;
        txtSuburban.Enabled = false;
        txtCity.Enabled = false;
        txtPincode.Enabled = false;
        ddCountry.Enabled = false;
        ddState.Disabled = true;
        ddlUrnType.Enabled = false;
        ddlUrnoOf.Enabled = false;
        txtURNo.Enabled = false;
        txtClient.Enabled = false;
        txtReferringHospital.Enabled = false;
        txtInternalExternalPhysician.Enabled = false;
        txtLocClient.Enabled = false;
        ddlIsExternalPatient.Enabled = false;
        txtWardNo.Enabled = false;
        txtExternalPatientNumber.Enabled = false;
        ddlPatientStatus.Enabled = false;
        txtSampleDate.Enabled = false;
        chkSamplePickup.Enabled = false;
        txtPhleboName.Enabled = false;
        txtLogistics.Enabled = false;
        txtRoundNo.Enabled = false;
        chkExcludeAutoathz.Enabled = false;
        ChkTRFImage.Disabled = true;
        FileUpload1.Enabled = false;
        chkDisPatchType.Enabled = false;
        //chkDisPatchType_1
        chkDespatchMode.Enabled = false;
        //chkDespatchMode_1
        //chkDespatchMode_2
        ChkNotification.Enabled = false;
        //ChkNotification_1
        ddlVisitDetails.Enabled = false;

    }
    public void UnDofreezeCTRL()
    {
        //rblSearchType_0
        rblSearchType.Enabled = true;
        //rblSearchType_1
        //rblSearchType_2
        //rblSearchType_3
        //rblSearchType_4
        ddSalutation.Enabled = true;
        txtName.Enabled = true;
        ddlSex.Enabled = true;
        tDOB.Enabled = true;
        txtDOBNos.Enabled = true;
        ddlDOBDWMY.Enabled = true;
        ddMarital.Enabled = true;
        txtMobileNumber.Enabled = true;
        txtPhone.Enabled = true;
        txtEmail.Enabled = true;
        txtAddress.Enabled = true;
        txtSuburban.Enabled = true;
        txtCity.Enabled = true;
        txtPincode.Enabled = true;
        ddCountry.Enabled = true;
        ddState.Disabled = false;
        ddlUrnType.Enabled = true;
        ddlUrnoOf.Enabled = true;
        txtURNo.Enabled = true;
        txtClient.Enabled = true;
        txtReferringHospital.Enabled = true;
        txtInternalExternalPhysician.Enabled = true;
        txtLocClient.Enabled = true;
        ddlIsExternalPatient.Enabled = true;
        txtWardNo.Enabled = true;
        txtExternalPatientNumber.Enabled = true;
        ddlPatientStatus.Enabled = true;
        txtSampleDate.Enabled = true;
        chkSamplePickup.Enabled = true;
        txtPhleboName.Enabled = true;
        txtLogistics.Enabled = true;
        txtRoundNo.Enabled = true;
        chkExcludeAutoathz.Enabled = true;
        ChkTRFImage.Disabled = false;
        FileUpload1.Enabled = true;
        chkDisPatchType.Enabled = true;
        //chkDisPatchType_1
        chkDespatchMode.Enabled = true;
        //chkDespatchMode_1
        //chkDespatchMode_2
        ChkNotification.Enabled = true;
        //ChkNotification_1
        ddlVisitDetails.Enabled = true;

    }
    #endregion
}
