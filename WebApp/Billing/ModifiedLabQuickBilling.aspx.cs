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
using System.Web.UI.WebControls.WebParts;

public partial class Billing_ModifiedLabQuickBilling : BasePage, IDisposable
{
    public Billing_ModifiedLabQuickBilling()
        : base("Billing_ModifiedLabQuickBilling_aspx")
    {
    }


    BillingEngine billingEngineBL;
    Physician_BL PhysicianBL;
    List<Salutation> lstTitles = new List<Salutation>();
    List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
    List<Country> lstNationality = new List<Country>();
    List<Country> lstCountries = new List<Country>();
    List<BillingFeeDetails> lstDetails = new List<BillingFeeDetails>();
    Patient objPatient = new Patient();
    FinalBill objFinalBill = new FinalBill();
    string AgeUnit = string.Empty, BillNumber = string.Empty, Labno = string.Empty, pathname = string.Empty;
    long patientID = -1, returnCode = -1;
    int AgeValue = 0, ClientID = 0;
    string Edit = string.Empty;

    string SetDefaultClient = string.Empty;

    #region "Common Resource Property"

    string AlertType = Resources.Billing_AppMsg.Billing_Header_Alert == null ? "Alert" : Resources.Billing_AppMsg.Billing_Header_Alert;
    string strSelect = Resources.Billing_ClientDisplay.Billing_ModifiedLabQuickBilling_aspx_02 == null ? "--Select--" : Resources.Billing_ClientDisplay.Billing_ModifiedLabQuickBilling_aspx_02;

    #endregion

    #region "Initial"

    protected void Page_Load(object sender, EventArgs e)
    {
        Edit = Request.QueryString["CPEDIT"];
        if (hdnEditbillDisable != null)
        {
            hdnEditbillDisable.Value = Edit;
        }
        string BookingNumber = string.Empty;
        string ConfigDisplayField = string.Empty;
        string dateformat = string.Empty;
        PhysicianBL = new Physician_BL(base.ContextInfo);
        hdnOrgID.Value = OrgID.ToString();
        ddSalutation.Focus();
        dateformat = GetConfigValue("Dateformat", OrgID);
        for (int i = chkDespatchMode.Items.Count - 1; i >= 0; i--)
            chkDespatchMode.Items[i].Selected = true;
        //hdnNeedAutoStatFee.Value = GetConfigValue("AutoStatFee", OrgID);
        if (dateformat != "")
        {
            hdnDateFormatConfig.Value = dateformat;
        }
        if (!IsPostBack)
        {
            loadRateSubTypeMapping();
            LoadDefaultClientName();
            AutoCompleteExtenderRefPhy.ContextKey = "RPH";
            AutoCompleteExtenderClientCorp.ContextKey = "CLI";
            AutoCompleteExtenderReferringHospital.ContextKey = OrgID.ToString();
            AutoCompleteExtenderPhlebo.ContextKey = OrgID.ToString();
            AutoCompleteExtenderLogi.ContextKey = OrgID.ToString() + "~" + "LOGI" + "~" + "-1";
            AutoCompleteExtenderPatient.ContextKey = OrgID.ToString() + '~' + patientID.ToString();
            AutoCompleteExtender10.ContextKey = "CODE";
            ddSalutation.Attributes.Add("onchange", "setSexValueQBLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "' ,'" + ddMarital.ClientID.ToString() + "','" + "" + "');");
            //ddlSex.Attributes.Add("onchange", "setSalutationValueQBLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "' ,'" + ddMarital.ClientID.ToString() + "','" + "ddlgender" + "');");
            //tDOB.Attributes.Add("onchange", "ExcedDate('" + tDOB.ClientID.ToString() + "','',0,0);");
            LoadQuickBillLoading();
            LoadURNtype();
            hdnDecimalAgeConfig.Value = GetConfigValue("DecimalAge", OrgID);
            ConfigDisplayField = GetConfigValue("LabQickBillingDisplayField", OrgID);
            if (ConfigDisplayField == "N")
            {

                DisplayNone();
            }

            string strRate = GetConfigValue("ShowRateType", OrgID);

            if (strRate == "Y")
            {
                trRate.Attributes.Add("display", "table-cell");
            }
            else
            {
                trRate.Attributes.Add("display", "none");
            }
            string mindue = GetConfigValue("MinimumDuepayment", OrgID);
            hdnMinimumDue.Value = mindue;
            string mindueper = GetConfigValue("MinimumDuePercent", OrgID);
            hdnMinimumDuePercent.Value = mindueper;
            hdnIsReceptionPhlebotomist.Value = GetConfigValue("IsReceptionPhlebotomist", OrgID);
            if (Request.QueryString["RCP"] == "Y")
                hdnIsReceptionPhlebotomist.Value = "Y";
            if (hdnIsReceptionPhlebotomist.Value == "N")
            {
                trCollectSample.Attributes.Add("display", "none");
                trCollectSampledt.Attributes.Add("display", "none");
            }
            string IsBarCodeNeed = GetConfigValue("PrintSampleBarcode", OrgID);
            if (IsBarCodeNeed == "Y")
            {
                ctlCollectSample.IsBarcodeNeeded = true;
            }

            string isExternalVisitID = GetConfigValue("ExternalVisitID", OrgID);
            if (isExternalVisitID == "Y")
            {
                hdnExternalVisitID.Value = "";
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
            string rval, roundpattern;
            rval = GetConfigValue("roundoffpatamt", OrgID);//Round off is done by config value(orgbased)
            roundpattern = GetConfigValue("patientroundoffpattern", OrgID);
            hdnDefaultRoundoff.Value = rval;
            hdnRoundOffType.Value = roundpattern;


            //txt_DOB_TextBoxWatermarkExtender.WatermarkText = dateformat;
            CalendarExtender1.Format = dateformat;
            tDOB.ToolTip = dateformat;

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

                    string CPEDIT = string.Empty;
                    CPEDIT = Request.QueryString["CPEDIT"];

                    if (CPEDIT == "Y")
                    {
                        if (Request.QueryString["VID"] != null)
                        {
                            hdnVisitID.Value = Request.QueryString["VID"];
                        }
                    }
                    if (Request.QueryString["Exvid"] != null)
                    {
                        hdnExternalVisitID.Value = Request.QueryString["Exvid"].ToString();
                    }
                    ScriptManager.RegisterStartupScript(Page, GetType(), "callEdit", "javascript:SelectedPatientEdit();", true);

                    if (CPEDIT != "Y")
                    {
                        trCollectSample.Style.Add("display", "none");
                        trCollectSampledt.Style.Add("display", "none");
                        trOrderCalcPart.Style.Add("display", "none");
                        tdClientPart.Style.Add("display", "table-cell");
                        //tdClientParttxt.Style.Add("display", "block");
                        //trSampleTRFPart.Style.Add("display", "block");
                        tdRefHosPart.Style.Add("display", "table-cell");
                        tdRefHosParttxt.Style.Add("display", "table-cell");
                        tdRefDrPart.Style.Add("display", "table-cell");
                        tdRefDrParttxt.Style.Add("display", "table-cell");
                        btnGenerate.Text = "Update";
                        hdnIsEditMode.Value = "Y";
                        trPatientPriorityPart.Style.Add("display", "table-row");
                        trUrnType.Style.Add("display", "table-row");
                        ViewTRF.Attributes.Add("style", "display:block");
                        //trEditRemarks.Style.Add("display", "block");
                        //trDispType.Style.Add("display", "block");
                        //trVisitTypePart.Style.Add("display", "block");
                        btnBack.Style.Add("display", "inline");
                        if (Request.QueryString["VS"] != null)
                        {
                            trVisitTypePart.Style.Add("display", "table-row");
                            trDispType.Style.Add("display", "table-row");
                            trSampleTRFPart.Style.Add("display", "table-row");
                        }
                        tdSearchType1.Attributes.Add("style", "display:none");
                        tdSearchType2.Attributes.Add("style", "display:none");
                        //txtClient.Enabled = false;
                    }
                    else
                    {
                        hdnIsEditMode.Value = "N";
                        trEditRemarks.Style.Add("display", "none");
                        trDispType.Style.Add("display", "none");
                        trVisitTypePart.Style.Add("display", "none");
                        tdAdditionalDetails.Style.Add("display", "none");
                        //ScriptManager.RegisterStartupScript(Page, GetType(), "callEditmode", "javascript:RegBillingNonEdit('Y');", true);

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

            string MobileNoCountryCode = GetConfigValue("MobileNoFormat", OrgID);
            if (!string.IsNullOrEmpty(MobileNoCountryCode) && MobileNoCountryCode.Length > 0)
            {
                lblMobile.Text = MobileNoCountryCode.ToString();
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
            string IsContactMndtory = GetConfigValue("IsContactNumbermMndatory", OrgID);
            if (IsContactMndtory == "Y")
            {

                hdnIsContactNumbermMndatory.Value = "Y";
            }
            else
            {
                hdnIsContactNumbermMndatory.Value = "N";
            }
            string AllowSplChar = GetConfigValue("AllowSplChar", OrgID);
            if (AllowSplChar == "Y")
            {
                hdnAllowSplChar.Value = "Y";

            }
            else
            {
                hdnAllowSplChar.Value = "N";

            }
            string HideFields = GetConfigValue("HideFields", OrgID);
            if (HideFields == "Y")
            {
                tdContact.Visible = false;
                lblPatient.Visible = false;
                ddlIsExternalPatient.Visible = false;
                lblWardno.Visible = false;
                txtWardNo.Visible = false;
                trUrnType.Visible = false;
                trSampleTRFPart.Visible = false;
                lblDespatchType.Visible = false;
                lblDespatchmode.Visible = false;
                panelDispatchType.Visible = false;
                panelDispatchMode.Visible = false;
                Label1.Text = "Ref No.";
                Rs_URN.Text = "NRIC/Passport No.";
                txtSuburban.Visible = false;
                lblSuburban.Visible = false;
                Rs_City.Visible = false;
                txtCity.Visible = false;
                lblnotification.Visible = false;
                panelnotification.Visible = false;
            }
        }
        string RenameGenerateBill = string.Empty;
        RenameGenerateBill = GetConfigValue("RenameGenerateBill", OrgID);
        if (RenameGenerateBill != "" && RenameGenerateBill != null)
        {
            btnGenerate.Text = RenameGenerateBill;
        }
        // txtDOBNos.Attributes.Add("onblur", "setDOBYear('" + txtDOBNos.ClientID.ToString() + "');");
    }
  
      protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    
    #endregion
    #region "Events"
protected void btnGenerate_Click(object sender, EventArgs e)
    {
        PageContextDetails.ButtonName = ((Button)sender).ID;
        PageContextDetails.ButtonValue = ((Button)sender).Text;
        SaveData();
        if (hdnHideControls.Value == "Y")
        {
            txtDOBNos.Enabled = false;
            ddlDOBDWMY.Enabled = false;
            ddlSex.Enabled = false;
            txtURNo.Enabled = false;
            ddlUrnoOf.Enabled = false;
            ddlUrnType.Enabled = false;
            tDOB.Enabled = false;
        }
        //ddSalutation.SelectedValue = "7";
        //ddlSex.SelectedValue = "M";
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {

            Response.Redirect("../Billing/ModifiedLabQuickBilling.aspx", true);
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
    #region CollectSample
   
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
  protected void chkDespatchMode_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    protected void txtClient_TextChanged1(object sender, EventArgs e)
    {

    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            int status = -1;
            int upis = -1;
            int upStaus = -1;
            long vid = Convert.ToInt64(hdnVisitID.Value);
            List<SampleTracker> lstSampleTracker = new List<SampleTracker>();
            List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            List<InvDeptSamples> lstDeptSamples = new List<InvDeptSamples>();
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
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
            string strLstPatientInvestigation = hdnLstPatientInvestigation.Value;
            string invStatus = string.Empty;
            string gUID = string.Empty;
            lstPatientInvSample = serializer.Deserialize<List<PatientInvSample>>(strLstPatientInvSample);
            lstSampleTracker = serializer.Deserialize<List<SampleTracker>>(strLstSampleTracker);
            lSampleMapping = serializer.Deserialize<List<PatientInvSampleMapping>>(strLstPatientInvSampleMapping);
            linvValues = serializer.Deserialize<List<InvestigationValues>>(strLstInvestigationValues);
            lstCollectedSampleStatus = serializer.Deserialize<List<string>>(strLstCollectedSampleStatus);
            lstPatientInvestigation = serializer.Deserialize<List<PatientInvestigation>>(strLstPatientInvestigation);

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
                //commented for performance - starts
                //string lstSampleId = string.Empty;
                //returnCode = invBL.SavePatientInvSample(lstPatientInvSample, lstSampleTracker, lstDeptSamples, out status, out lstSampleId);
                //commented for performance - ends
                //new added for performance - starts
                string lstSampleId = string.Empty;

                List<PatientInvSampleMapping> groupByResult = new List<PatientInvSampleMapping>();

                groupByResult = (from lst in lSampleMapping
                                 group lst by
                                 new
                                 {
                                     lst.ID,
                                     lst.SampleID,
                                     lst.Type,
                                     lst.Barcode,
                                     lst.VisitID,
                                     lst.OrgID,
                                     lst.UID
                                 } into grp

                                 select new PatientInvSampleMapping
                                 {
                                     ID = grp.Key.ID,
                                     SampleID = grp.Key.SampleID,
                                     Type = grp.Key.Type
                                     ,
                                     Barcode = grp.Key.Barcode,
                                     VisitID = grp.Key.VisitID,
                                     OrgID = grp.Key.OrgID,
                                     UID = grp.Key.UID
                                 }).Distinct().ToList();

                foreach (PatientInvSample Obj1 in lstPatientInvSample)
                {
                    foreach (SampleTracker Obj2 in lstSampleTracker)
                    {
                        if (Obj2.SampleID == Obj1.SampleCode)
                        {
                            Obj1.Reason = Obj2.Reason;
                            Obj1.InvSampleStatusID = Obj2.InvSampleStatusID;
                            break;
                        }
                    }
                }
                returnCode = invBL.SavePatientInvSample(lstPatientInvSample, lstSampleTracker, lstDeptSamples, groupByResult,
                    lstPatientInvestigation, linvValues, gUID, out status, out lstSampleId);

                //new added for performance - ends

                if (status == 0)
                {
                    int DeptID = 0;

                    if (invStatus == String.Empty)
                    {
                        new Investigation_BL(base.ContextInfo).getInvOrgSampleStatus(OrgID, "Paid", out invStatus);
                    }

                    //commented for performance - starts
                    //invBL.UpdateOrderedInvestigationStatusinLab(linvValues, vid, invStatus, DeptID, "Paid", gUID, out upis);

                    //invBL.InsertPatientSampleMapping(lSampleMapping, vid, OrgID, 0, LID, out status);
                    //ctlCollectSample.ExtractInvestigations(vid, gUID);


                    //if (upis == 0)
                    //{
                    //    invBL.UpdatePatientInvestigationStatusinLab(lstPatientInvestigation, out upStaus);
                    //}
                    //invBL.UpdateOrderedInvestigationStatusinLab(linvValues, vid, invStatus, DeptID, "Paid", gUID, out upis);
                    //commented for performance - ends

                    bool isSampleNotReceived = false;
                    foreach (string strSampleStatus in lstCollectedSampleStatus)
                    {
                        if (strSampleStatus == InvStatus.Notgiven)
                        {
                            isSampleNotReceived = true;

                            break;
                        }
                    }

                    foreach (SampleTracker item in lstSampleTracker)
                    {
                        if (item.InvSampleStatusID == 6 && item.Reason == "ReflexTest")
                        {
                            isSampleNotReceived = false;
                            break;
                        }
                    }

                    if (isSampleNotReceived == true)
                    {
                        TaskOpen();
                    }

                    if (isSampleNotReceived != true)
                    {
                        Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
                        oTasksBL.UpdateTask(Convert.ToInt64(hdntaskID.Value), TaskHelper.TaskStatus.Completed, LID);

                    }
                    string IsBarCodeNeed = GetConfigValue("PrintSampleBarcode", OrgID);
                    if (IsBarCodeNeed == "Y")
                    {
                        ctlCollectSample.IsBarcodeNeeded = true;
                    }
                    if (ctlCollectSample.IsBarcodeNeeded)
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Window", "window.open('../admin/PrintBarcode.aspx?visitId=" + vid + "&sampleId=" + lstSampleId + "&guId=" + gUID + "&orgId=" + OrgID + "&categoryCode=" + BarcodeCategory.ContainerRegular + "&IsPopup=Y" + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
                    }
                    string sPage1 = string.Empty;
                    string IsCreditBill = billPart.IsCreditBill;
                    string NeedBillPrintForClient = GetConfigValue("NeedPrintForClient", OrgID);
                    string NoNeedBillPrint = GetConfigValue("NoNeedBillPrint", OrgID);
                    string BookingNo = hdnBookingNo.Value;
                    if (string.IsNullOrEmpty(NeedBillPrintForClient))
                        NeedBillPrintForClient = "Y";
                    sPage1 = "../Reception/PrintPage.aspx?pid=" + hdnPatientID.Value
                                   + "&vid=" + hdnVisitID.Value
                                   + "&pagetype=BP&quickbill=N&bid=" + hdnFinalBillID.Value + "&visitPur=" + hdnVisitPurposeID.Value + "&ClientName=" + txtClient.Text + "&OrgID=" + OrgID + "&BKNO=" + BookingNo + "&IsPopup=Y";
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
                    //string sPages = string.Empty;
                    //sPages = sPage1 + "&IsNeedInv=Y" + "&RedirectPage=/Billing/LabQuickBilling.aspx";

                    string NeedBillInvestigation = GetConfigValue("NeedBillInvestigationSRS", OrgID);
                    string sPage = "../Reception/PrintPage.aspx?pid=" + pid.ToString()
                              + "&vid=" + vid.ToString()
                              + "&sampleId=" + lstSampleId + "&pagetype=BP&quickbill=N&bid=" + 0 + "&visitPur=" + 0 + "&ClientName=" + 0 + "&OrgID=" + OrgID + "&IsPopup=Y" + "&IsNeedInv=Y";

                    if (NeedBillInvestigation == "Y")
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:OpenBillPrint1('" + sPage1 + "','" + sPage + "');", true);
                    }

                    long DoFrmVisitID = -1;
                    Int64.TryParse(hdnTodayVisitID.Value, out DoFrmVisitID);
                    if (DoFrmVisitID > 0)
                    {
                        UpdateUIDForSameVisit(lstPatientInvSample, DoFrmVisitID);
                    }
                    ClearValues();

                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while generating work order in Lab Quick Billing", ex);

        }
    }
    #endregion

    #region "Methods"
   // #region PageLoadingData
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
            if (ClientValues[22] == "Y")
            {
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
            if (ClientValues[21] == "Y")
            {
                if (txtClient.Text != string.Empty)
                {
                    chkExcludeAutoathz.Checked = true;
                }
            }
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
                txtLocClient.Text = lstClientNames1[0].ClientName;
                hdnClienID.Value = lstClientNames1[0].ClientID.ToString();
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
                var hdnisproc = lstInvSampleStatus.FindAll(p => p.IsDefault == "Y");
                if (hdnisproc.Count > 0)
                {
                    HiddenField hdnIsProsLoc = (HiddenField)ctlCollectSample.FindControl("hdnIsProsLoc");
                    hdnIsProsLoc.Value = "Y";
                }
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
                var DispatchMode = lstactiontype.FindAll(p => p.Type == "DISFAX");
                chkDespatchMode.DataSource = DispatchMode;
                chkDespatchMode.DataTextField = "ActionType";
                chkDespatchMode.DataValueField = "ActionTypeID";
                chkDespatchMode.DataBind();
            }
            // if (lstactiontype.Count > 0)
            // {
            // var Notification = lstactiontype.FindAll(p => p.Type == "Notify");
            // ChkNotification.DataSource = Notification;
            // ChkNotification.DataTextField = "ActionType";
            // ChkNotification.DataValueField = "ActionTypeID";
            // ChkNotification.DataBind();


            // }
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
        string strGeneralClient = Resources.Billing_AppMsg.Billing_ModifiedLabQuickBilling_aspx_01 == null ? "No general Client associated this Organisation" : Resources.Billing_AppMsg.Billing_ModifiedLabQuickBilling_aspx_01;
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
                ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "ValidationWindow(" + strGeneralClient.Trim() + "," + AlertType.Trim() + ");", true);
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
                ddlUrnType.DataTextField = "Displaytext";
                ddlUrnType.DataValueField = "URNTypeId";
                ddlUrnType.DataBind();
                if (ddlUrnType.SelectedValue == "10")
                {
                    txtURNo.MaxLength = 12;
                }

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
            ddState.Value = selectedState.StateID.ToString();
            Int32.TryParse(ddState.Value, out stateID);
            hdnPatientStateID.Value = selectedState.StateID.ToString();
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
            ddSalutation.SelectedValue = selectedSalutation.TitleID.ToString();
            Int32.TryParse(ddSalutation.SelectedItem.Value, out titleID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadTitle() Method in Lab Quick Billing", ex);
        }
    }
    static bool Findsalutation(Salutation s)
    {
        if (s.TitleName.ToUpper().Trim() == "")
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
            string domains = "DateAttributes,Gender,MaritalStatus,PatientType,PatientStatus,DespatchType";
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
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "DateAttributes"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlDOBDWMY.DataSource = childItems;
                    ddlDOBDWMY.DataTextField = "DisplayText";
                    ddlDOBDWMY.DataValueField = "DisplayText";
                    ddlDOBDWMY.DataBind();
                    ddlDOBDWMY.SelectedValue = "Year(s)";
                }

                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "Gender"
                                  select child;

                if (childItems1.Count() > 0)
                {
                    ddlSex.DataSource = childItems1;
                    ddlSex.DataTextField = "DisplayText";
                    ddlSex.DataValueField = "Code";
                    ddlSex.DataBind();
                    ddlSex.Items.Insert(0, "--Select--");
                    ddlSex.Items[0].Value = "0";
                    ddlSex.SelectedValue = "M";
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
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }

    #endregion

    
    public void SaveData()
    {
        string strOrderedList = Resources.Billing_AppMsg.Billing_ModifiedLabQuickBilling_aspx_02 == null ? "Ordered List count is zero so you cannot billed" : Resources.Billing_AppMsg.Billing_ModifiedLabQuickBilling_aspx_02;
        string strUpdated = Resources.Billing_AppMsg.Billing_ModifiedLabQuickBilling_aspx_03 == null ? "Updated Successfully" : Resources.Billing_AppMsg.Billing_ModifiedLabQuickBilling_aspx_03;
        string strExternalVisitID = Resources.Billing_AppMsg.Billing_ModifiedLabQuickBilling_aspx_04 == null ? "ExternalVisitID Already Registered With Another Patient" : Resources.Billing_AppMsg.Billing_ModifiedLabQuickBilling_aspx_04;
        string strError = Resources.Billing_AppMsg.Billing_ModifiedLabQuickBilling_aspx_05 == null ? "Error While Saving Data" : Resources.Billing_AppMsg.Billing_ModifiedLabQuickBilling_aspx_05;
        try
        {
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
            JavaScriptSerializer JSserializer = new JavaScriptSerializer();
            List<OrderedInvestigations> lstPkgandGrps = new List<OrderedInvestigations>();
            int age = 0, needTaskDisplay = -1;
            long vpurpose = -1;
            string sVal;
            string ddlClientName;
            string[] SplitAge;
            string[] tempAge;
            string strCollectAgain = string.Empty, strSampleRelationshipID = string.Empty;
            long taskID = -1;
            string CPEDIT = string.Empty;
            CPEDIT = Request.QueryString["CPEDIT"];
            if (txtDOBNos.Text == "")
            {
                if (hdnEdtPatientAge.Value != "0")
                {
                    objPatient.Age = hdnEdtPatientAge.Value.ToString() + "~" + hdnEditDDlDOB.Value.ToString();
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
            GetPageValues();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);

            int NewOrgID = 0;
            NewOrgID = Convert.ToInt32(hdnNewOrgID.Value.ToString());

            if (hdnOrgID.Value == NewOrgID.ToString())
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
                else
                {
                    objPatient.Age = txtDOBNos.Text.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
                }
            }
            else
            {
                if (CPEDIT == "Y")
                {
                    objPatient.Age = txtDOBNos.Text.ToString() + "~" + hdnEditDDlDOB.Value.ToString();
                }
                else
                {
                    objPatient.Age = txtDOBNos.Text.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
                }
            }
            SplitAge = objPatient.Age.Split('~');
            tempAge = SplitAge[0].Split('.');
            // AgeValue = Convert.ToInt32(tempAge[0]);

            if (hdnCalculateDays.Value != "")
            {
                Int32.TryParse(hdnCalculateDays.Value, out AgeValue);
            }
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
            DataTable dtAmountReceivedDet = null;
            string s = hdnMappingClientID.Value;

            dtAmountReceivedDet = billPart.GetAmountReceivedDetails();
            lstPatientDueChart = billPart.GetBillingItems();
            List<VisitClientMapping> lst = new List<VisitClientMapping>();
            objFinalBill = billPart.GetFinalBillDetails(out lst);
            if (txtClient.Text != "" || hdnClientName.Value != "")
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
            else
            {
                objFinalBill.IsCreditBill = "N";
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
            if (hdnIsReceptionPhlebotomist.Value == "Y")
            {
                hdnIsEditMode.Value = "N";
            }
            //  PageContextDetails.isActionDisabled = !chkMobileNotify.Checked;
            DateTime dtSampleDate = (txtSampleDate.Text.Trim().ToLower() == "dd/mm/yyyy" || txtSampleDate.Text.Trim() == "") ? Convert.ToDateTime("01/01/1753") : Convert.ToDateTime(txtSampleDate.Text.Trim());
            long TodayVisitID = -1;

            if (hdnOrgID.Value == NewOrgID.ToString())
            {
                Int64.TryParse(hdnTodayVisitID.Value, out TodayVisitID);
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
            HiddenField hdnPkgandgrps = (HiddenField)billPart.FindControl("hdnPkgandgrpID");
            if (!string.IsNullOrEmpty(hdnPkgandgrps.Value))
            {
                lstPkgandGrps = JSserializer.Deserialize<List<OrderedInvestigations>>(hdnPkgandgrps.Value);
            }
            if (lstPatientDueChart.Count > 0 || hdnIsEditMode.Value == "Y")
            {
                string ExcludeAutoAuthorization = GetConfigValue("ExcludeAutoAuthorization", OrgID);
                if (ExcludeAutoAuthorization == "Y")
                {
                    if (objPatient.ReferedHospitalName != string.Empty || objPatient.ReferingPhysicianName != string.Empty || objPatient.ClientID != 1)
                    {
                        objPatient.ExAutoAuthorization = "Y";
                    }
                }
                if (Request.QueryString["billNo"] != null)
                {
                    ContextInfo.AdditionalInfo = Request.QueryString["billNo"];
                }
                string pvalue = string.Empty;
                pvalue = FaxNumber.Text;

                string EmailCCAddress = string.Empty;
                if (!String.IsNullOrEmpty(txtCC.Text) && txtCC.Text.Length > 0)
                {
                    EmailCCAddress = txtCC.Text;

                }
                ContextInfo.DepartmentName = hdnBookedID.Value;
                new Patient_BL(base.ContextInfo).InsertPatientBilling_Quantum(objPatient, objFinalBill, Convert.ToInt64(hdnReferedPhyID.Value),
                                                    Convert.ToInt32(hdnRefPhySpecialityID.Value), pSpecialityID, lstPatientDueChart, AgeValue, AgeUnit,
                                                    pSpecialityID, ReferralType, paymentstatus, gUID, dtAmountReceivedDet, lstInv, lstTaxDetails,
                                                    out lstBillingDetails, out returnStatus, SavePicture, sVal, RoleID, LID, PageContextDetails,
                                                    hdnIsReceptionPhlebotomist.Value, Convert.ToInt16(ddlIsExternalPatient.SelectedValue),
                                                    txtWardNo.Text, 0, 0, 0, 0, "", dtSampleDate, "", new List<ControlMappingDetails>(),
                                                    hdnIsEditMode.Value, out needTaskDisplay, lstDispatchDetails, lst, out PatientRoleID,
                                                    Convert.ToInt64(hdnClienID.Value), TodayVisitID, IsSamplePickUP, externalVisitID, approvalNo, lstPkgandGrps, EmailCCAddress, out taskID, pvalue,"","");


                hdntaskID.Value = taskID.ToString();
                string sValMltDis = GetConfigValue("HaveMultipleDiscount", OrgID);
                if (sValMltDis == "Y")
                {
                    FnSavePatientDiscount(lstBillingDetails);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alrUpdateSucess", "ValidationWindow(" + strOrderedList.Trim() + "," + AlertType.Trim() + ");reloadModifiedPage();", true);
            }
            if (lstBillingDetails.Count > 0 && returnStatus >= 0 && hdnIsEditMode.Value == "N")
            {
                long PatientID = -1;
                PatientID = lstBillingDetails[0].PatientID;
                patientVisitID = lstBillingDetails[0].VisitID;

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

                if (ChkTRFImage.Checked == true)
                {
                    SaveTRFPicture(Convert.ToString(PatientID), Convert.ToString(patientVisitID));
                }
                if (lstInvHistoryAttributes.Count > 0)
                {
                    SaveHistory(patientID, patientVisitID, lstInvHistoryAttributes);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ClearHistory", "clearHistoryHiddenvalues();", true);
                    lstInvHistoryAttributes.Clear();
                }
                vpurpose = int.Parse(hdnVisitPurposeID.Value);
                ddlClientName = txtClient.Text;
                try
                {
                    PageContextDetails.PatientID = Convert.ToInt64(patientID);
                    PageContextDetails.PatientVisitID = Convert.ToInt64(patientVisitID);
                    PageContextDetails.RoleID = PatientRoleID;
                    ActionManager am = new ActionManager(base.ContextInfo);
                    // returnCode = am.PerformingNextStep(PageContextDetails);
                    returnCode = am.PerformingNextStepNotification(PageContextDetails, "", "");
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error While Sending Email", ex);
                }
                if (hdnIsReceptionPhlebotomist.Value == "Y" && needTaskDisplay == 1)
                {
                    hdnBillGenerate.Value = "Y";
                    trCollectSample.Attributes.Add("display", "table");
                    trCollectSampledt.Attributes.Add("display", "table");
                    UserControl UC_DatePicker = (UserControl)this.Page.FindControl("DateTimePicker1");
                    TextBox SampleDate = (TextBox)UC_DatePicker.FindControl("txtSampleDateCollect");
                    TextBox SampleTime1 = (TextBox)UC_DatePicker.FindControl("txtSampleTime1");
                    TextBox SampleTime2 = (TextBox)UC_DatePicker.FindControl("txtSampleTime2");
                    DropDownList SampleTimeType = (DropDownList)UC_DatePicker.FindControl("ddlSampleTimeType");
                    SampleDate.Attributes.Add("onblur", "SetDateTimeDetails();");
                    SampleTime1.Attributes.Add("onblur", "ValidateTime(this);SetDateTimeDetails();");
                    SampleTime2.Attributes.Add("onblur", "ValidateTime(this);SetDateTimeDetails();");
                    SampleTimeType.Attributes.Add("onchange", "SetDateTimeDetails();");
                    loadCollectSampleList(patientVisitID, gUID);
                    hdnGuID.Value = gUID;
                    btnFinish.Attributes.Add("onclick", "return GenerateWorkOrder(" + OrgID + "," + LID + "," + ILocationID + "," + patientVisitID + ",'" + gUID + "','" + strCollectAgain + "','" + strSampleRelationshipID + "')");
                }
                else if (Request.QueryString["CPEDIT"] == "Y")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alrUpdateSucess", "ValidationWindow(" + strUpdated.Trim() + "," + AlertType.Trim() + ");javascript:labQuickBilling();", true);
                }
                else
                {
                    PrintBilling(patientID, patientVisitID, FinalBillID, vpurpose, ddlClientName);
                }
                returnCode = patientBL.SavePATAttributes(lstPatHisAttributes, PatientID);
            }
            else if (hdnIsEditMode.Value == "Y")
            {
                if (ChkTRFImage.Checked == true)
                {
                    SaveTRFPicture(Convert.ToString(patientID), Convert.ToString(patientVisitID));
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alrUpdateSucess", "ValidationWindow(" + strUpdated.Trim() + "," + AlertType.Trim() + ");redirectPage();", true);
            }
            else
            {
                if (returnStatus == 101)
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "altSaveFailed", "ValidationWindow(" + strExternalVisitID.Trim() + "," + AlertType.Trim() + ");javascript:labQuickBilling();", true);
                }
                else
                {
                    CLogger.LogWarning("Lab Quick Billing Error Part Start");
                    CLogger.LogWarning(lstBillingDetails.Count.ToString());
                    CLogger.LogWarning(returnStatus.ToString());
                    CLogger.LogWarning(hdnIsEditMode.Value.ToString());
                    CLogger.LogWarning("Lab Quick Billing Error Part End");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "altSaveFailed", "ValidationWindow("+strError.Trim()+","+AlertType.Trim()+");clearPageControlsValue('N');", true);
                }
            }

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error While Saving SaveData() Method Lab Quick Billing", ex);
        }

        FaxNumber.Text = "";
        chkDespatchMode.ClearSelection();
        for (int i = 0; i < chkDespatchMode.Items.Count; i++)
        { chkDespatchMode.Items[i].Selected = false; }
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
        string sPage = string.Empty;
        string IsCreditBill = billPart.IsCreditBill;
        string NeedBillPrintForClient = GetConfigValue("NeedPrintForClient", OrgID);
        string NoNeedBillPrint = GetConfigValue("NoNeedBillPrint", OrgID);
        string BookingNo = hdnBookingNo.Value;
        if (string.IsNullOrEmpty(NeedBillPrintForClient))
            NeedBillPrintForClient = "Y";
        sPage = "../Reception/PrintPage.aspx?pid=" + PatientID.ToString()
                       + "&vid=" + patientVisitID.ToString()
                       + "&pagetype=BP&quickbill=N&bid=" + FinalBillID + "&visitPur=" + vpurpose + "&ClientName=" + ddlClientName + "&OrgID=" + OrgID + "&BKNO=" + BookingNo + "&IsPopup=Y";

        string sPages = string.Empty;
        sPages = sPage + "&IsNeedInv=Y" + "&RedirectPage=/Billing/ModifiedLabQuickBilling.aspx";

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
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:clearPageControlsValue('N');OpenBillPrint('" + sPage + "');ClearControlValues();", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:clearPageControlsValue('N');ClearControlValues();", true);
        }


        ClearValues();



        long BKNO = Convert.ToInt64(Request.QueryString["BKNO"]);

        if (BKNO > 0)
        {
            ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:labQuickBilling();", true);
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
            if (txtDOBNos.Text == "")
            {
                if (hdnEdtPatientAge.Value != "0")
                {
                    objPatient.Age = hdnEdtPatientAge.Value.ToString() + "~" + hdnEditDDlDOB.Value.ToString();
                }
                else
                {
                    objPatient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
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

            string finalPName = txtName.Text.Trim().ToString();

            int NewOrgID = 0;
            NewOrgID = Convert.ToInt32(hdnNewOrgID.Value.ToString());
            if (hdnOrgID.Value == NewOrgID.ToString())
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
            patient.TITLECode = Convert.ToByte(ddSalutation.SelectedValue);
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

            //---Commented by Murali R----


            if (tDOB.Text == "")
            {
                tDOB.Text = hdnPatientDOB.Value;
            }

            DOB = new DateTime(1800, 1, 1);
            string Date = tDOB.Text.Trim() == "" ? "01/01/1800" : tDOB.Text.Trim();


            patient.DOB = DateTime.ParseExact(Date, hdnDateFormatConfig.Value, null);



            //DOB = new DateTime(1800, 1, 1);
            //string Date = tDOB.Text.Trim() == "" ? "01/01/1800" : tDOB.Text.Trim();
            //patient.DOB = Convert.ToDateTime(Date);
            //Int16.TryParse(txtDOBNos.Text.Trim(), out age);

            if (txtDOBNos.Text == "")
            {
                if (hdnEdtPatientAge.Value != "0")
                {
                    objPatient.Age = hdnEdtPatientAge.Value.ToString() + "~" + hdnEditDDlDOB.Value.ToString();
                }
                else
                {
                    objPatient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
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

    private long SaveTRFPicture(string number, string visitid)
    {
        pathname = GetConfigValue("TRF_UploadPath", OrgID);
        long returncode = -1;
        try
        {
            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

            int Year = dt.Year;
            int Month = dt.Month;
            int Day = dt.Day;
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
                        string imagePath = pathname;
                        string picNameWithoutExt = number + '_' + visitid + '_' + OrgID + '_' + fileName;
                        string pictureName = string.Empty;
                        string filePath = string.Empty;
                        Response.OutputStream.Flush();
                        string[] fileNames = Directory.GetFiles(imagePath, picNameWithoutExt + ".*");
                        foreach (string path in fileNames)
                        {
                            File.Delete(path);
                        }
                        string imageExtension = ".GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD";
                        if (imageExtension.Contains(fileExtension.ToUpper()))
                        {
                            pictureName = picNameWithoutExt + ".jpg";
                            filePath = imagePath + pictureName;
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
                            bmp.Save(filePath, ImageFormat.Jpeg);
                            // hpf.SaveAs(filePath,ImageFormat.Jpeg);
                            //hdnPatientImageName.Value = pictureName;
                            gr.Dispose();
                            bmp.Dispose();
                            image.Dispose();
                        }
                        else
                        {
                            pictureName = picNameWithoutExt + fileExtension;
                            filePath = imagePath + pictureName;
                            hpf.SaveAs(filePath);
                        }
                        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                        int pno = int.Parse(number.ToString());
                        int Vid = int.Parse(visitid.ToString());
                        returncode = patientBL.SaveTRFDetails(pictureName, pno, Vid, OrgID, 0, "TRF_Upload", "", 0, dt,"Y",0);
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
        txtCC.Text = "";
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
        //if (SetDefaultClient == "Y")
        //{
        //    if (hdnDefaultClienName != null && hdnDefaultClienID != null)
        //    {
        //        if ((hdnDefaultClienID.Value == "") || ((hdnDefaultClienName.Value != "") && (hdnDefaultClienName.Value != txtClient.Text)))
        //        {
        //            txtClient.Text = "";
        //        }
        //    }
        txtClient.Text = "";
        //}
        txtEmail.Text = "";
        hdnOPIP.Value = "OP";
        hdnPatientID.Value = "-1";
        hdnVisitPurposeID.Value = "-1";
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
        tDOB.Text = "";
        ddSalutation.Focus();
        hdnPatientAlreadyExistsWebCall.Value = "0";
        txt_DOB_TextBoxWatermarkExtender.WatermarkText = hdnDateFormatConfig.Value;
        //txt_DOB_TextBoxWatermarkExtender.WatermarkText = "dd/MM/yyyy";
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
        hdnCalculateDays.Value = "0";
        TxtClientCodeMap.Text = "";
        SetDefaultClient = GetConfigValue("SetDefaultClientForLoc", OrgID);
        if (SetDefaultClient == "Y")
        {
            LoadDefaultClientNameBasedOnOrgLocation();
        }
        FaxNumber.Text = "";
        chkDespatchMode.ClearSelection();


        txtDOBNos.Enabled = true;
        ddlDOBDWMY.Enabled = true;
        ddlSex.Enabled = true;
        txtURNo.Enabled = true;
        ddlUrnoOf.Enabled = true;
        ddlUrnType.Enabled = true;
        tDOB.Enabled = true;
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
    public void DisplayNone()
    {
        tdUrnoOf.Style.Add("display", "none");
        tdlblUrnoOf.Style.Add("display", "none");
        tdlblMarital.Style.Add("display", "none");
        tdddMarital.Style.Add("display", "none");
        lblPinCode.Text = "ZIP";
    }
    private void TaskOpen()
    {
        try
        {
            long taskID = -1;
            if (hdntaskID.Value != "" && hdntaskID.Value != null)
            {
                taskID = Convert.ToInt64(hdntaskID.Value);
            }
            returnCode = new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Pending, LID, "ReleaseTask");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in RaiseCallbackEvent", ex);
            throw ex;
        }
    }

    public void UpdateUIDForSameVisit(List<PatientInvSample> lstPatInvSample, long DoFrmVisitID)
    {
        int SampleCode = -1;
        int sampleContainerID = -1;
        string type = string.Empty;
        string UID = string.Empty;

        string BarcodeNo = "0";
        type = "DoFrmVisitNumber";
        Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);


        foreach (PatientInvSample Pinv in lstPatInvSample)
        {
            //long OrgID = Convert.ToInt64(OrgID);
            sampleContainerID = Pinv.SampleContainerID;
            SampleCode = Pinv.SampleCode;
            returnCode = InvestigationBL.GetBarcodeNumForDoFromVisit(OrgID, DoFrmVisitID, out BarcodeNo, SampleCode, UID, type, sampleContainerID);

        }
    }
  
    #endregion
}
