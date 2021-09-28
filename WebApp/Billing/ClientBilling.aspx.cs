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
using System.Web.Script.Serialization;
using System.Xml;
using Attune.Podium.EMR;
using System.Web.UI.HtmlControls;
using Attune.Podium.PerformingNextAction;

public partial class Billing_ClientBilling : BasePage
{
    string strSelect = Resources.Billing_ClientDisplay.Billing_ClientBilling_aspx_06 == null ? "--Select--" : Resources.Billing_ClientDisplay.Billing_ClientBilling_aspx_06;
    public Billing_ClientBilling()
        : base("Billing_ClientBilling_aspx")
    {
    }
    List<Salutation> lstTitles = new List<Salutation>();
    List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
    List<Country> lstNationality = new List<Country>();
    List<Country> lstCountries = new List<Country>();
    List<BillingFeeDetails> lstDetails = new List<BillingFeeDetails>();
    Patient objPatient = new Patient();
    FinalBill objFinalBill = new FinalBill();
    string AgeUnit = string.Empty, BillNumber = string.Empty, Labno = string.Empty, pathname = string.Empty;
    long patientID = -1, patientVisitID = -1, returnCode = -1, taskID = -1;
    int AgeValue = 0, ClientID = 0;
    string SetDefaultClient = string.Empty;
    string strAlert = Resources.Billing_AppMsg.Billing_ClientBilling_aspx_Alert == null ? "Alert" : Resources.Billing_AppMsg.Billing_ClientBilling_aspx_Alert;
    protected void Page_Load(object sender, EventArgs e)
    {
        string strSpecount = Resources.Billing_ClientDisplay.Billing_ClientBilling_aspx_02 == null ? "Specimen Count" : Resources.Billing_ClientDisplay.Billing_ClientBilling_aspx_02;
        string strRoundnos = Resources.Billing_ClientDisplay.Billing_ClientBilling_aspx_03 == null ? "Round No" : Resources.Billing_ClientDisplay.Billing_ClientBilling_aspx_03;
        hdnnotallowlogisticfreetext.Value = GetConfigValue("NotallowfreetextforLogisticName", OrgID);
        ddlRate.Items.Insert(0, strSelect.Trim());
        iframeBarcode.Attributes.Remove("src");
        hdnOrgID.Value = OrgID.ToString();
		//change by arun -- if client not having any Baserate Ratecard then the alert should be changed- RLS
        string strConfigvalue = GetConfigValue("AlrtBaseRateNotMappng", OrgID);
        hdnAlrtBaseRateNotMappng.Value = strConfigvalue;
        //
        //ddSalutation.Focus();
        ddSalutation.Focus();
        billPart.BillingPageType = "Client";
        if (!IsPostBack)
        {
            loadRateSubTypeMapping();
            hdnorgIDCl.Value = OrgID.ToString();
            AutoCompleteExtenderRefPhy.ContextKey = "RPH";
            AutoCompleteExtender2.ContextKey = OrgID.ToString() + "~" + "Zone" + "~" + -1;
            AutoCompleteExtenderClientCorp.ContextKey = OrgID.ToString() + "~" + "CLIENTZONE" + "~" + 0;
            AutoCompleteExtenderPhlebo.ContextKey = OrgID.ToString();
            //AutoCompleteExtenderLogi.ContextKey = OrgID.ToString();
            AutoCompleteExtenderLogi.ContextKey = OrgID.ToString() + "~" + "LOGI" + "~" + "-1";
            AutoCompleteExtenderReferringHospital.ContextKey = OrgID.ToString();
            long pClientID = -1;
            if (CID > 0)
            {
                pClientID = CID;
            }
            AutoCompleteExtenderVisitNo.ContextKey = OrgID.ToString() + "~" + patientID.ToString() + "~" + "8" + "~" + pClientID.ToString();
            AutoCompleteExtenderPatient.ContextKey = OrgID.ToString() + '~' + patientID.ToString();
            ddSalutation.Attributes.Add("onchange", "setSexValueQBLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "' ,'" + ddMarital.ClientID.ToString() + "','" + "" + "');");
            ddlSex.Attributes.Add("onchange", "setSexValueoptLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
            LoadQuickBillLoading();
            string strRate = GetConfigValue("ShowRateType", OrgID);
            hdnCBDecimalAge.Value = GetConfigValue("DecimalAge", OrgID);
            string mindue = GetConfigValue("MinimumDuepayment", OrgID);
            hdnMinimumDue.Value = mindue;
            string mindueper = GetConfigValue("MinimumDuePercent", OrgID);
            hdnMinimumDuePercent.Value = mindueper;
            string AllowSplChar = GetConfigValue("AllowSplChar", OrgID);
            hdncollectcashforcreditclient.Value = GetConfigValue("collectcashforcreditclient", OrgID);
            if (AllowSplChar == "Y")
            {
                hdnAllowSplChar.Value = "Y";

            }
            else
            {
                hdnAllowSplChar.Value = "N";

            }
            string SpecimenCount = GetConfigValue("SpecimenCount", OrgID);

            if (SpecimenCount == "Y")
            {
                // lblRoundNo.Text = "Specimen Count";
                lblRoundNo.Text = strSpecount;
                hdnRoundNo.Value = "Y";

            }
            else
            {
                //lblRoundNo.Text = "Round No";
                lblRoundNo.Text = strRoundnos;
                hdnRoundNo.Value = "N";
                imgnoroundno.Attributes.Add("style", "display:none");
            }
            hdnIsReceptionPhlebotomist.Value = GetConfigValue("IsReceptionPhlebotomist", OrgID);
            if (hdnIsReceptionPhlebotomist.Value == "N")
            {
                trCollectSample.Attributes.Add("display", "none");
            }

            string AllowDiffSampleTestforDFV = GetConfigValue("AllowDiffSampleTestforDFV", OrgID);
            if (AllowDiffSampleTestforDFV == "Y")
            {
                hdnDifferSanpleforDFV.Value = "Y";
            }
            string EditGenderforBABYSalutation = GetConfigValue("EditGenderforBABYSalutation", OrgID);
            if (EditGenderforBABYSalutation == "Y")
            {
                hdnBabysalutationeditgender.Value = "Y";
            }
            string IsBarCodeNeed = GetConfigValue("PrintSampleBarcode", OrgID);
            if (IsBarCodeNeed == "Y")
            {
                ctlCollectSample.IsBarcodeNeeded = true;
            }

            string NeedLabNumber = GetConfigValue("ExternalVisitID", OrgID);
            hdnlabnumber.Value = NeedLabNumber;
            if (NeedLabNumber == "Y")
            {
                tdlblvisitnno.Visible = false;
                tdtxtvisitno.Visible = false;
                tdtxtlabnumber.Visible = true;
                tdlabnumber.Visible=true;
                txtlabnumber.Focus();
            }
            else
            {
                tdtxtlabnumber.Visible = false;
                tdlabnumber.Visible = false;
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
            string LanguageBasedReport = GetConfigValue("LanguageBasedReport", OrgID);
            if (LanguageBasedReport != "Y")
            {
                tdddreplang.Style.Add("display", "none");
                tdreplang.Style.Add("display", "none");
            }
            else
            {
                tdddreplang.Style.Add("display", "table-cell");
                tdreplang.Style.Add("display", "table-cell");
            }
            string UseWarNoAsSRFID = GetConfigValue("UseWardnoAsSRFID", OrgID);
            hdnissrfid.Value = UseWarNoAsSRFID == "Y" ? UseWarNoAsSRFID : "N";
            if (UseWarNoAsSRFID == "Y")
            {
                tdlblsrfid.Style.Add("display", "table-cell");
                tdtxtsrfid.Style.Add("display", "table-cell");
                lblRoundNo.Text = "TRF ID";
                tdlblpassportno.Style.Add("display", "table-cell");
                tdtxtpassportno.Style.Add("display", "table-cell");
            }
            else {
                tdlblsrfid.Style.Add("display", "none");
                tdtxtsrfid.Style.Add("display", "none");
                tdlblpassportno.Style.Add("display", "none");
                tdtxtpassportno.Style.Add("display", "none");
            }
            string AllowGreaterAmtfromMrp = GetConfigValue("AllowGreaterAmtfromMrp", OrgID);
            if (AllowGreaterAmtfromMrp == "Y")
            {
                hdnAllowGreaterAmtfromMrp.Value = "Y";

            }
            else
            {
                hdnAllowGreaterAmtfromMrp.Value = "N";
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
            txtSampleDate.Text = OrgTimeZone;
            //hdnOrgDateTimeZone.Value = OrgDateTimeZone;
            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(OrgDateTimeZone);
            string Time = dt.ToString("hh:mm:tt");
            string[] SplitTime = Time.Split(':');
            txtSampleTime11.Text = SplitTime[0];
            txtSampleTime22.Text = SplitTime[1];
            ddlSampleTimeType1.SelectedValue = SplitTime[2];
            HiddenField hide = (HiddenField)billPart.FindControl("hdnIsClientBilling");
            String ClientBilling;
            ClientBilling = hide.Value;
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "Assign", "AssignClientPage();", true);
            //LoadDefaultClientName();
            //VEL
            if (base.RoleName == "Remote Registration")
            {
                hdnRemotelogin.Value = "Y";
            }
            //VEL
        }
        if (CID > 0)
        {
            hdnClientPortal.Value = "Y";
        }
        else
        {
            hdnClientPortal.Value = "N";
        }
        SetDefaultClient = GetConfigValue("SetDefaultClientForLoc", OrgID);
        //trf upload mandatory
        // string strTRFMandatory = GetConfigValue("IsTRFMandatory", OrgID);
        // hdnConfigTRFMandatory.Value = strTRFMandatory == "Y" ? strTRFMandatory : "N";
        //
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

    #region CollectSample
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

            Patient_BL patientBL = new Patient_BL();
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
                //if (lstPatInvSample.Count > 0)
                //{
                long DoFrmVisit = -1;
                if (hdnDoFrmVisit.Value != "-1" || hdnDoFrmVisit.Value != "0")
                {
                    DoFrmVisit = Convert.ToInt64(hdnDoFrmVisit.Value);
                }
                else
                {
                    DoFrmVisit = -1;
                }
                ctlCollectSample.LoadCollectSampleList(lstPatInvSample, DoFrmVisit);
                //}
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
                    //  pnlDept.Style.Add("display", "block");
                }

            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "SetDateTime", "SetDateTimeDetails();", true);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while load data investigation sample", ex);
        }

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
            Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
            List<InvestigationValues> linvValues = new List<InvestigationValues>();
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
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


            long DoFrmVisit = -1;
            string Barcode = string.Empty;
            int sampleCode = -1;
            //string ClientUID = string.Empty;
            //ClientUID = gUID;
            string type = "DoFrmVisitNumber";
            int sampleContainerID = -1;
            if (hdnDoFrmVisit.Value != "-1" || hdnDoFrmVisit.Value != "0")
            {
                DoFrmVisit = Convert.ToInt64(hdnDoFrmVisit.Value);
            }
            else
            {
                DoFrmVisit = -1;
            }
            if (lstSampleTracker.Count > 0 && lstDeptSamples.Count > 0)
            {
                string lstSampleId = string.Empty;
                /*Code Removed By Jaya*/
                /* returnCode = invBL.SavePatientInvSample(lstPatientInvSample, lstSampleTracker, lstDeptSamples, out status, out lstSampleId);
                 if (status == 0)
                 {
                     int DeptID = 0;

                     if (invStatus == String.Empty)
                     {
                         new Investigation_BL().getInvOrgSampleStatus(OrgID, "Paid", out invStatus);
                     }

                     invBL.UpdateOrderedInvestigationStatusinLab(linvValues, vid, invStatus, DeptID, "Paid", gUID, out upis);

                     bool isSampleNotReceived = false;
                     foreach (string strSampleStatus in lstCollectedSampleStatus)
                     {
                         if (strSampleStatus == InvStatus.Notgiven)
                         {
                             isSampleNotReceived = true;

                             break;
                         }
                     }

                     if (isSampleNotReceived == true)
                     {
                         TaskOpen();
                     }*/
                /*END*/
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
                // invBL.InsertPatientSampleMapping(groupByResult, vid, OrgID, 0, LID, out status);

                if (invStatus == String.Empty)
                {
                    //new Investigation_BL().getInvOrgSampleStatus(OrgID, "Paid", out invStatus);
                    invStatus = "SampleCollected";
                }
                List<SampleTracker> lstTracker = new List<SampleTracker>();
                SampleTracker sampleTracker = new SampleTracker();
                foreach (PatientInvSample Obj1 in lstPatientInvSample)
                {
                    int Statusid = Convert.ToInt32(Obj1.InvSampleStatusID);
                    lstTracker = (from ST in lstSampleTracker
                                  where ST.SampleID == Obj1.SampleCode && ST.InvSampleStatusID == Statusid 
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
                returnCode = invBL.SavePatientInvSample(lstPatientInvSample, lstSampleTracker, lstDeptSamples, groupByResult,
                     lstPatientInvestigation, linvValues, gUID, out status, out lstSampleId);

                ActionManager AM = new ActionManager(base.ContextInfo);
                List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                PageContextkey PC = new PageContextkey();
                PC.RoleID = Convert.ToInt64(RoleID);
                PC.OrgID = OrgID;
                PC.PageID = Convert.ToInt64(PageID);
                PC.ButtonName = "btnFinish";
                PC.ButtonValue = "Generate Work Order";
                PC.ActionType = "Email";
                PC.PatientID = Convert.ToInt64(hdnPatientID.Value);
                PC.PatientVisitID = Convert.ToInt64(hdnVisitID.Value);
                if (PC.ActionType == null)
                {
                    PC.ActionType = "";
                }
                lstpagecontextkeys.Add(PC);
                long res = -1;
                res = AM.PerformingNextStepNotification(PC, "", "");
                

                // ctlCollectSample.ExtractInvestigations(vid, gUID);

                if (status == 0)
                {
                    int DeptID = 0;
                    // invBL.UpdateOrderedInvestigationStatusinLab(linvValues, vid, invStatus, DeptID, "Paid", gUID, out upis);
                    bool isSampleNotReceived = false;
                    foreach (string strSampleStatus in lstCollectedSampleStatus)
                    {
                        if (strSampleStatus == InvStatus.Notgiven)
                        {
                            isSampleNotReceived = true;

                            break;
                        }
                    }

                    if (isSampleNotReceived == true)
                    {
                        TaskOpen();
                    }
                    //  invBL.UpdateOrderedInvestigationStatusinLab(linvValues, vid, invStatus, DeptID, "Paid", gUID, out upis);
                    string IsBarCodeNeed = GetConfigValue("PrintSampleBarcode", OrgID);
                    if (IsBarCodeNeed == "Y")
                    {
                        ctlCollectSample.IsBarcodeNeeded = true;
                    }
                    hdnDoFrmVisit.Value = "0";
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
                            //Changed by Arivalagan kk for cross browser print baroce//
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
                                iframeBarcode.Attributes["src"] = "attunebarcode:" + barcode;
                            }
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
                    if (isSampleNotReceived != true)
                    {
                        Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
                        oTasksBL.UpdateTask(Convert.ToInt64(hdntaskID.Value), TaskHelper.TaskStatus.Completed, LID);

                    }
                    PrintBilling(Convert.ToInt64(hdnPatientID.Value), Convert.ToInt64(hdnVisitID.Value), Convert.ToInt64(hdnFinalBillID.Value), Convert.ToInt64(hdnVisitPurposeID.Value), txtClient.Text);
                }
            }
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
            txtPhleboName.Text = string.Empty;
            txtLogistics.Text = string.Empty;
            HdnPhleboID.Value = "";
            hdnLogisticsID.Value = "";
            txtRoundNo.Text = string.Empty;
            chkExcludeAutoathz.Checked = false;
            chkIncomplete.Checked = false;
            ddlUnknownFlag.SelectedIndex = 0;
            if (hdnClientPortal.Value != "Y")
            {
                txtzone.Text = "";
                hdnZoneID.Value = "";
            }
            hdnSampleforPrevious.Value = "";
            hdnVisitNumber.Value = "";
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "MakeEnable", "ClearReadOnlyPropertys();", true);

            ddSalutation.SelectedItem.Value = "0";
            ddlSex.SelectedItem.Value = "0";
            hdntaskID.Value = "-1";
            hdnTodayVisitID.Value = "0";
            btnFinish.Style.Add("display", "inline");
            ctlCollectSample.ResetData();
            tblDatepicker.Style.Add("display", "none");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while generating work order in Lab Quick Billing", ex);

        }

    }
    #endregion

    #region PageLoadingData

    public void LoadOutSoruceInvestigations()
    {
        Investigation_BL InvestigaionBL = new Investigation_BL(base.ContextInfo);
        List<InvestigationMaster> lstOutSourceInvestigations = new List<InvestigationMaster>();

        long returnCode = InvestigaionBL.GetOutSourceInvestigations(OrgID, ILocationID, out lstOutSourceInvestigations); // .GetLabRefOrg(OrgID, 0, "D", out RefOrg);
        if (lstOutSourceInvestigations != null && lstOutSourceInvestigations.Count > 0)
        {
            foreach (InvestigationMaster lstInvMaster in lstOutSourceInvestigations)
            {
                if (hdnOutSourceInvestigations.Value == "")
                {
                    hdnOutSourceInvestigations.Value = lstInvMaster.InvestigationName;
                }
                else
                {
                    hdnOutSourceInvestigations.Value += "~" + lstInvMaster.InvestigationName;
                }
            }
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
        if (lstRateSubTypeMapping.Count > 0)
        {
            foreach (RateSubTypeMapping Obj in lstRateSubTypeMapping)
            {
                if (Obj.Description == "New Visit")
                {
                    ddlVisitDetails.SelectedItem.Value = "New Visit";
                    break;
                }
            }
        }


        //foreach (RateSubTypeMapping item in lstRateSubTypeMapping)
        //{
        //    //hdnVisitSubType.Value += item.Description + "^" + item.TypeOfSubType + "|";
        //}

    }
    public void LoadQuickBillLoading()
    {
        List<Salutation> lstTitles = new List<Salutation>();
        List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
        List<Country> lstNationality = new List<Country>();
        List<Country> lstCountries = new List<Country>();

        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        string LanguageCode = string.Empty;
        LanguageCode = ContextInfo.LanguageCode;
        billingEngineBL.GetQuickBillingDetails(OrgID, LanguageCode, out lstTitles, out lstVisitPurpose, out lstNationality, out lstCountries);
        LoadTitle(lstTitles);
        LoadCountry(lstCountries);
        LoadURNtype();
        LoadNationality(lstNationality);
        LoadMeatData();
        loadRateType();
        LoadOutSoruceInvestigations();
        loadClient();
        LoadDespatchMode();
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
                var DispatchMode = lstactiontype.FindAll(p => (p.Type == "DisM" || p.ActionCode == "REmail" || p.ActionCode == "RSms"));
                chkDespatchMode.DataSource = DispatchMode;
                chkDespatchMode.DataTextField = "ActionType";
                chkDespatchMode.DataValueField = "ActionTypeID";
                chkDespatchMode.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While LoadDespatchMode() in Lab Quick Billing", ex);
        }
    }



    public void loadClient()
    {
        string strGeneralClient = Resources.Billing_AppMsg.Billing_ClientBilling_aspx_02 == null ? "No general Client associated this Organisation" : Resources.Billing_AppMsg.Billing_ClientBilling_aspx_02;

        SharedInventorySales_BL inventorySalesBL = new SharedInventorySales_BL(base.ContextInfo);
        List<ClientMaster> lstclients = new List<ClientMaster>();
        inventorySalesBL.GetClientNames(OrgID, out lstclients);
        if (lstclients.Count > 0)
        {
            var temp = lstclients.FindAll(p => p.ClientName == "GENERAL");
            if (lstclients.Count > 0)
            {
                hdnBaseClientID.Value = temp.ToString();
                hdnSelectedClientClientID.Value = temp.ToString();
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "ValidationWindow('" + strGeneralClient + "','" + strAlert + "');", true);
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
            ddCountry.SelectedValue = selectedCountry.CountryID.ToString();
            Int32.TryParse(ddCountry.SelectedItem.Value, out countryID);
            LoadState(countryID);
            var childItems = (from n in lstcountries
                              where n.IsDefault == "Y"
                              select new { n.CountryID, n.ISDCode }).ToList();
            if (childItems.Count() > 0)
            {
                hdnDefaultCountryID.Value = childItems[0].CountryID.ToString();
                //lblCountryCode.Text = "+" + childItems[0].ISDCode.ToString();
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
            ddSalutation.Items.Insert(0, strSelect);
            //ddSalutation.Items.Insert(0, "--Select--");
            ddSalutation.Items[0].Value = "0";
            ddSalutation.SelectedValue = "0";
            //ddSalutation.SelectedValue = selectedSalutation.TitleID.ToString();
            Int32.TryParse(ddSalutation.SelectedItem.Value, out titleID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in patient registration.Message:", ex);
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
            string domains = "DateAttributes,Gender,MaritalStatus,PatientType,PatientStatus,UnknownFlag,SearchType,SampleTimeType,VisitType,ReportLanguage";
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
                    ddlDOBDWMY.DataValueField = "Code";
                    ddlDOBDWMY.DataBind();
                    ddlDOBDWMY.SelectedValue = "Year(s)";
                }

                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "Gender" && child.Code != "B"
                                  select child;

                if (childItems1.Count() > 0)
                {
                    ddlSex.DataSource = childItems1;
                    ddlSex.DataTextField = "DisplayText";
                    ddlSex.DataValueField = "Code";
                    ddlSex.DataBind();
                    ddlSex.Items.Insert(0, strSelect);
                    // ddlSex.Items.Insert(0, "--Select--");
                    ddlSex.Items[0].Value = "0";
                    ddlSex.SelectedValue = "0";
                    ddlSex.Items.Remove((ddlSex.Items.FindByText("Both")));

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
                    ddMarital.Items.Insert(0, strSelect);
                    //ddMarital.Items.Insert(0, "--Select--");
                    ddMarital.Items[0].Value = "0";
                    //ddMarital.SelectedValue = "S";
                }
                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "PatientType"
                                  select child;

                var unknownFlag = from child in lstmetadataOutput
                                  where child.Domain == "UnknownFlag"
                                  select child;
                if (unknownFlag.Count() > 0)
                {
                    ddlUnknownFlag.DataSource = unknownFlag;
                    ddlUnknownFlag.DataTextField = "DisplayText";
                    ddlUnknownFlag.DataValueField = "Code";
                    ddlUnknownFlag.DataBind();
                }
                var SearchType = from child in lstmetadataOutput
                                 where child.Domain == "SearchType"
                                 orderby child.MetaDataID ascending
                                 select child;
                if (SearchType.Count() > 0)
                {
                    rblSearchType.DataSource = SearchType;
                    rblSearchType.DataTextField = "DisplayText";
                    rblSearchType.DataValueField = "Code";
                    rblSearchType.DataBind();
                    rblSearchType.Items.Remove((rblSearchType.Items.FindByValue("1")));
                    rblSearchType.Items.Remove((rblSearchType.Items.FindByValue("2")));
                    rblSearchType.Items.Remove((rblSearchType.Items.FindByValue("3")));
                    rblSearchType.SelectedValue = "4";
                }
                var SampleTimeType = from child in lstmetadataOutput
                                     where child.Domain == "SampleTimeType"
                                     select child;
                if (SampleTimeType.Count() > 0)
                {
                    ddlSampleTimeType1.DataSource = SampleTimeType;
                    ddlSampleTimeType1.DataTextField = "DisplayText";
                    ddlSampleTimeType1.DataValueField = "Code";
                    ddlSampleTimeType1.DataBind();
                }
                var VisitType = from child in lstmetadataOutput
                                where child.Domain == "VisitType"
                                select child;
                if (VisitType.Count() > 0)
                {
                    ddlIsExternalPatient.DataSource = VisitType;
                    ddlIsExternalPatient.DataTextField = "DisplayText";
                    ddlIsExternalPatient.DataValueField = "Code";
                    ddlIsExternalPatient.DataBind();
                    ddlIsExternalPatient.Items.Remove((ddlIsExternalPatient.Items.FindByValue("-1")));

                }
                var ReportLanguage = from child in lstmetadataOutput
                                  where child.Domain == "ReportLanguage"
                                  orderby child.MetaDataID ascending
                                  select child;
                ddlreplang.DataSource = ReportLanguage;
                ddlreplang.DataTextField = "DisplayText";
                ddlreplang.DataValueField = "Code";
                ddlreplang.DataBind();
                ddlreplang.Items.Insert(0, "Select");
                ddlreplang.Items[0].Value = "0";
            }
            // }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }

    #endregion

    public void LoadDefaultClientNameBasedOnOrgLocation()
    {
        long lresutl = -1;
        BillingEngine BillingBl = new BillingEngine(new BaseClass().ContextInfo);
        List<InvClientMaster> lstClientNames = new List<InvClientMaster>();
        string prefixText = string.Empty;
        string pType = string.Empty;
        long refhospid = -1;
        if (CID > 0)
        {
            pType = "CLP";
            refhospid = CID;
        }
        else
        {
            pType = "CLI";
            refhospid = -1;
        }
        lresutl = BillingBl.GetRateCardForBilling(prefixText, OrgID, pType, refhospid, out lstClientNames);
        if (lstClientNames.Count > 0)
        {
            string[] ClientValues = lstClientNames[0].Value.Split('^');
            if (pType == "CLI")
            {
                //string[] ClientRateID = ClientValues[4].Split('~');
                if (hdnCollectionID.Value == "undefined")
                {
                    hdnCollectionID.Value = "0";
                }
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
                    }
                }
            }
            else if (pType == "CLP")
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
                txtClient.Attributes.Add("disabled", "true");

                /*Default Zone for Client Portal-- Start*/

                int AdvanceClient = int.Parse(ClientValues[34]);
                if (AdvanceClient == 1)
                {
                    decimal TotalDepositAmount = decimal.Parse(ClientValues[23]);
                    decimal TotalDepositUsed = decimal.Parse(ClientValues[24]);
                    decimal AmtRefund = decimal.Parse(ClientValues[25]);
                    decimal deduction = TotalDepositUsed + AmtRefund;
                    decimal final = TotalDepositAmount - deduction;
                    //HtmlTableRow r = (HtmlTableRow)this.billPart.FindControl("trRollingAdvance");
                    //r.Visible = true;
                    //TableRow r = (TableRow)billPart.FindControl("trRollingAdvance");
                    HtmlTableRow r = (HtmlTableRow)this.billPart.FindControl("trRollingAdvance1");
                    r.Attributes.Add("style", "display:block");
                    Label lblName = (Label)billPart.FindControl("lblRollingBalAmt1");
                    lblName.Text = Convert.ToString(final);
                    hdnAmount.Value = Convert.ToString(final);
                    hdnAdvanceClient.Value = ClientValues[34];
                    hdnTotalDepositAmount.Value = ClientValues[23];
                    hdnTotalDepositUsed.Value = ClientValues[24];
                    hdnAvailDepositAmt.Value = Convert.ToString(final);
                    hdnThresholdType.Value = ClientValues[26];
                    hdnThresholdValue.Value = ClientValues[27];
                    hdnThresholdValue2.Value = ClientValues[28];
                    hdnThresholdValue3.Value = ClientValues[29];
                    hdnCollectionID.Value = ClientValues[22];
                    hdnCLP.Value = "1";

                }

                long preturnCode = -1;
                string Name = string.Empty;
                int orgid = 0;
                string Type = "CLP";
                long ZoneID = CID;
                List<Users> lstUsers = new List<Users>();
                List<EmployeeRegMaster> lstEmployeeRegMaster = new List<EmployeeRegMaster>();
                List<InvClientMaster> lstInvClientMaster = new List<InvClientMaster>();
                List<Localities> lstLocalities = new List<Localities>();
                Investigation_BL INVBL = new Investigation_BL(base.ContextInfo);
                preturnCode = INVBL.GetPhlebotomistName(Name, orgid, Type, ZoneID, out lstUsers, out lstEmployeeRegMaster, out lstInvClientMaster, out lstLocalities);
                if (lstLocalities.Count > 0)
                {
                    if (txtzone.Text == string.Empty)
                    {
                        txtzone.Text = lstLocalities[0].Locality_Value;
                        HidhdnZoneName.Value = lstLocalities[0].Locality_Value;
                    }
                    if ((txtzone.Text == string.Empty) || (txtzone.Text == lstLocalities[0].Locality_Value))
                    {
                        hdnZoneID.Value = lstLocalities[0].Locality_ID.ToString();
                    }
                }
                txtzone.Attributes.Add("disabled", "true");
            }
        }
    }
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        PageContextDetails.ButtonName = ((Button)sender).ID;
        PageContextDetails.ButtonValue = ((Button)sender).Text;
        SaveData();
        txtDoFrmVisitNumber.Text = string.Empty;
        hdnEdtPatientAge.Value = "0";
        hdnEditDDlDOB.Value = "0";
        hdnddlsalutation.Value = "0";
        hdnEditSex.Value = "0";
        hdnEdtSelectedClientClientID.Value = "0";
        btnFinish.Focus();
    }
    public void SaveData()
    {
        btnGenerate.Style.Add("display", "none");
        btnClose.Style.Add("display", "none");
        long pSpecialityID = 0, FinalBillID = 0, patientVisitID = -1;
        long PatientRoleID = 0;
        int returnStatus = -1, SavePicture = -1;
        int LocationID = -1;
        FinalBill finalBill = new FinalBill();
        string gUID = string.Empty, paymentstatus = "Paid", ReferralType = "";
        List<PatientDisPatchDetails> lstDispatchDetails = new List<PatientDisPatchDetails>();
        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
        List<TaxBillDetails> lstTaxDetails = new List<TaxBillDetails>();
        List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
        List<InvHistoryAttributes> lstInvHistoryAttributes = new List<InvHistoryAttributes>();
        List<PatientReferringDetails> lstPatientReferringDetails = new List<PatientReferringDetails>();
        List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
        List<PatientHistoryAttribute> lstPatHisAttributes = new List<PatientHistoryAttribute>();
        List<OrderedInvestigations> lstPkgandGrps = new List<OrderedInvestigations>();
        int age = 0, needTaskDisplay = -1;
        long vpurpose = -1;
        string sVal;
        string ddlClientName;
        string[] SplitAge;
        string[] tempAge;
        string strCollectAgain = string.Empty, strSampleRelationshipID = string.Empty;
        /******Added by Vijayalakshmi.M***********/
        string StatFlag = string.Empty;
        string ClientFlag = string.Empty;

        if (!string.IsNullOrEmpty(hdnCheckFlag.Value))
        {
            StatFlag = hdnCheckFlag.Value;
        }
        if (!string.IsNullOrEmpty(hdnClientFlag.Value))
        {
            ClientFlag = hdnClientFlag.Value;
        }

        if (chkIncomplete.Checked == false)
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
            if (ddlUnknownFlag.SelectedIndex > 0)
            {
                objPatient.UnknownFlag = Convert.ToByte(ddlUnknownFlag.SelectedValue);
            }
            if (age != 0)
            {
                objPatient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
            }
            else
            {
                objPatient.Age = "";
            }

        }
        GetPageValues();
        patientID = Convert.ToInt64(hdnPatientID.Value);

        sVal = GetConfigValue("SampleCollect", OrgID);
        objPatient = GetPatientDetails();
        if (chkIncomplete.Checked == false)
        {
            SplitAge = objPatient.Age.Split('~');
            tempAge = SplitAge[0].Split('.');
            AgeValue = Convert.ToInt32(tempAge[0]);

            //SplitAge = objPatient.Age.Split('~');
            //AgeValue = Convert.ToInt32(SplitAge[0]);
            if (hdnEdtPatientAge.Value != "0")
            {


                if (hdnEditDDlDOB.Value.ToString() == "Day(s)")
                {
                    AgeUnit = "D";
                }
                else if (hdnEditDDlDOB.Value.ToString() == "Week(s)")
                {
                    AgeUnit = "W";
                }
                else if (hdnEditDDlDOB.Value.ToString() == "Month(s)")
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
        }
        else
        {
            if (ddlUnknownFlag.SelectedIndex > 0)
            {
                objPatient.UnknownFlag = Convert.ToByte(ddlUnknownFlag.SelectedValue);
            }
            if (age != 0)
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

        }
        if (txtLocClient.Text.Trim() != "" && hdnClienID.Value != "")
        {
            LocationID = Convert.ToInt32(hdnClienID.Value);
        }
        else
        {

        }
        lstDispatchDetails = CreateDespatchMode1();
        DataTable dtAmountReceivedDet = null;
        string s = hdnMappingClientID.Value;
        List<VisitClientMapping> lst = new List<VisitClientMapping>();
        dtAmountReceivedDet = billPart.GetAmountReceivedDetails();
        lstPatientDueChart = billPart.GetBillingItems();
        objFinalBill = billPart.GetFinalBillDetails(out lst);
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
        lstTaxDetails = billPart.getTaxDetails();
        lstInv = billPart.GetOrderedInvestigations(patientVisitID, out gUID);
        lstInvHistoryAttributes = billPart.GetHistoryItems();
        deptTab.Style.Add("display", "none");
        string hdnAttributeList = string.Empty;
        hdnAttributeList = billPart.PassGetAttributeItems().Trim();
        string[] value = hdnAttributeList.Split('^');
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

        try
        {
            long TodaysVisit = -1;
            int NewOrgID = 0;
            if (hdnNewOrgID.Value != "")
            {
                NewOrgID = Convert.ToInt32(hdnNewOrgID.Value.ToString());
            }
            if (hdnDoFrmVisit.Value != "0" )
            {
                TodaysVisit = Convert.ToInt64(hdnDoFrmVisit.Value);
            }
            else if (hdnOrgID.Value == NewOrgID.ToString())
            {
                TodaysVisit = Convert.ToInt64(hdnTodayVisitID.Value);
            }
            else
            {
                TodaysVisit = -1;
            }
            string ExternalVisitID = string.Empty;
            if (txtlabnumber.Text != "")
            {
                ExternalVisitID = txtlabnumber.Text;
            }
            string approvalNo = string.Empty;
            if (string.IsNullOrEmpty(txtApprovalNo.Text))
                approvalNo = "";
            else
            {
                approvalNo = txtApprovalNo.Text.Trim();
            }

            List<PatientVisitLanguage> objlang = new List<PatientVisitLanguage>();
            foreach (string lstlanguage in hdnreplanguage.Value.Split('^'))
            {
                if (lstlanguage != "")
                {
                    PatientVisitLanguage cl = new PatientVisitLanguage();
                    string[] lstlang = lstlanguage.Split('|');
                    cl.ReportLanguage = lstlang[1];
                    cl.IsActive = "A";
                    cl.CreatedAt = DateTime.Now;
                    cl.CreatedBy = LID;
                    cl.ModifiedAt = DateTime.Now;
                    cl.ModifiedBy = LID;
                    objlang.Add(cl);
                }
            }
            if (hdnissrfid.Value == "Y")
            {
                ContextInfo.AdditionalInfo = "" + "|" + txtsrfid.Text + "~" + txtpassportno.Text;
            }
            if (hdnIsReceptionPhlebotomist.Value == "")
                hdnIsReceptionPhlebotomist.Value = "Y";
            PageContextDetails.isActionDisabled = !chkMobileNotify.Checked;
            List<VisitTemplate> visittemplate = new List<VisitTemplate>();
            //DateTime dtSampleDate = (txtSampleDate.Text.Trim().ToLower() == "dd/mm/yyyy" || txtSampleDate.Text.Trim() == "") ? Convert.ToDateTime("01/01/1753") : Convert.ToDateTime(txtSampleDate.Text.Trim());
            List<PatientDiscount> lstPatientDiscount = new List<PatientDiscount>();
            string SampleDate = (txtSampleDate.Text.Trim().ToLower() == "dd/mm/yyyy" || txtSampleDate.Text.Trim() == "") ? "01/01/1753" : txtSampleDate.Text.Trim();
            string SampleTime1 = (txtSampleTime11.Text.Trim().ToLower() == "hr:mm" || txtSampleTime11.Text.Trim() == "") ? "12:00" : txtSampleTime11.Text.Trim();
            string SampleTime2 = (txtSampleTime22.Text.Trim().ToLower() == "hr:mm" || txtSampleTime22.Text.Trim() == "") ? "12:00" : txtSampleTime22.Text.Trim();
            string SampleTimeType = ddlSampleTimeType1.SelectedValue;
            DateTime dtSampleDate = Convert.ToDateTime(SampleDate + " " + SampleTime1 + ":" + SampleTime2 + " " + SampleTimeType);
            List<PatientRedemDetails> lstPatientRedemDetails = new List<PatientRedemDetails>();
            if (PageContextDetails.ActionType == null)
            {
                PageContextDetails.ActionType = "";
            }
            new Patient_BL(base.ContextInfo).InsertPatientBilling(objPatient, objFinalBill, Convert.ToInt64(hdnReferedPhyID.Value), Convert.ToInt32(hdnRefPhySpecialityID.Value), pSpecialityID,
                lstPatientDueChart, AgeValue, AgeUnit, pSpecialityID, ReferralType,
                paymentstatus, gUID, dtAmountReceivedDet, lstInv, lstTaxDetails,
                out lstBillingDetails, out returnStatus, SavePicture, sVal, RoleID,
                LID, PageContextDetails, "N", Convert.ToInt32(ddlIsExternalPatient.SelectedValue), "",
                0, 0, 0, 0, "",
                dtSampleDate, "", new List<ControlMappingDetails>(), hdnIsEditMode.Value,
                out needTaskDisplay, lstDispatchDetails, lst, out PatientRoleID, Convert.ToInt64(hdnClienID.Value), TodaysVisit, "", ExternalVisitID, approvalNo,
                out taskID, "", lstPatientDiscount, "", "", "", "", "", 0, "", 0, 0, 0, 0, 0, lstPatientRedemDetails, lstPkgandGrps, StatFlag, ClientFlag, Convert.ToInt64(hdnCollectionID.Value), "", "", "", "", visittemplate, objlang,"","","");
            ContextInfo.AdditionalInfo = "";
            Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
            if (tbl.isTaskAlreadyPicked(taskID, TaskHelper.TaskStatus.Pending, TaskHelper.TaskStatus.InProgress, LID))
            {

            }
            var LabConfig = GetConfigValue("LisIntegration", OrgID);
            if (LabConfig=="Y")
            {
               // long patientVisitID = vid;
                ActionManager AM = new ActionManager(base.ContextInfo);
                List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                PageContextkey PC = new PageContextkey();
                PC.RoleID = Convert.ToInt64(RoleID);
                PC.OrgID = OrgID;
                PC.PageID = Convert.ToInt64(PageID);
                PC.ButtonName = "btnGenerate";
                PC.ButtonValue = "Generate Bill";
                PC.ActionType = "LISOrdered";
                PC.PatientID = lstBillingDetails[0].PatientID;
                PC.PatientVisitID = lstBillingDetails[0].VisitID;
                if (PC.ActionType == null)
                {
                    PC.ActionType = "";
                }
                lstpagecontextkeys.Add(PC);
                long res = -1;
                res = AM.PerformingNextStepNotification(PC, "", "");
             }
            
            hdntaskID.Value = taskID.ToString();
            if (lstBillingDetails.Count > 0 && returnStatus >= 0 && hdnIsEditMode.Value == "N")
            {
                patientVisitID = lstBillingDetails[0].VisitID;
                Labno = lstBillingDetails[0].LabNo;
                FinalBillID = lstBillingDetails[0].FinalBillID;
                patientID = lstBillingDetails[0].PatientID;
                hdnVisitID.Value = lstBillingDetails[0].VisitID.ToString();
                hdnFinalBillID.Value = lstBillingDetails[0].FinalBillID.ToString();
                hdnVisitNumber.Value = lstBillingDetails[0].VersionNo;

                //histo path specimen details save added by premanand


                List<HistoSpecimenDetails> lstspec = new List<HistoSpecimenDetails>();

                long Returncode = -1;
                HiddenField hdnSpecimenValues = (HiddenField)billPart.FindControl("hdnSpecimenValues");
                if (!String.IsNullOrEmpty(hdnSpecimenValues.Value) && hdnSpecimenValues.Value.Length > 0)
                {
                    foreach (string str in hdnSpecimenValues.Value.Split('~'))
                    {
                        if (str != "")
                        {

                            HistoSpecimenDetails obj = new HistoSpecimenDetails();
                            string[] list = str.Split(',');
                            obj.ID = Convert.ToInt64(list[0].ToString());
                            obj.PatientVisitID = patientVisitID;
                            obj.Type = list[2].ToString();
                            obj.SampleID = Convert.ToInt32(list[3].ToString());
                            obj.SampleName = list[4].ToString();
                            obj.SampleCount = Convert.ToInt32(list[5].ToString());
                            obj.ClinicalNotes = list[6].ToString();
                            obj.ClinicalDiagnosis = list[7].ToString();
                            lstspec.Add(obj);
                        }
                    }


                    Returncode = new Patient_BL(base.ContextInfo).InsertHistoSpecimenDetails(OrgID, ILocationID, lstspec);

                }



                //end



                new BarcodeHelper().SaveReportBarcode(patientVisitID, OrgID, lstBillingDetails[0].VersionNo, "PVN");
                if (ChkTRFImage.Checked == true)
                {
                    SaveTRFPicture(Convert.ToString(patientID), Convert.ToString(patientVisitID), hdnVisitNumber.Value);
                }
                if (lstInvHistoryAttributes.Count > 0)
                {
                    SaveHistory(patientID, patientVisitID, lstInvHistoryAttributes);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ClearHistory", "clearHistoryHiddenvalues();", true);
                    lstInvHistoryAttributes.Clear();
                }
                if (lstPatHisAttributes.Count > 0)
                {
                    Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                    returnCode = patientBL.SavePATAttributes(lstPatHisAttributes, patientVisitID);
                }
                vpurpose = int.Parse(hdnVisitPurposeID.Value);
                ddlClientName = txtClient.Text;

                hdnBillGenerate.Value = "Y";
                tblDatepicker.Style.Add("display", "table");
                trCollectSample.Attributes.Add("display", "table-row");
                UserControl UC_DatePicker = (UserControl)this.Page.FindControl("DateTimePicker1");
                TextBox SampleDate1 = (TextBox)UC_DatePicker.FindControl("txtSampleDateCollect");
                TextBox SampleTime11 = (TextBox)UC_DatePicker.FindControl("txtSampleTime1");
                TextBox SampleTime22 = (TextBox)UC_DatePicker.FindControl("txtSampleTime2");
                DropDownList SampleTimeType1 = (DropDownList)UC_DatePicker.FindControl("ddlSampleTimeType");
                //Command  By Karthick//////////////////////////
                ////DateTime dt = new DateTime();
                ////dt = Convert.ToDateTime(OrgDateTimeZone);
                ////dt = Convert.ToDateTime(OrgDateTimeZone);
                ////SampleDate1.Text = dt.ToShortDateString();
                ////SampleTime11.Text = "00";
                ////SampleTime22.Text = "00";
                ////SampleTimeType1.SelectedValue = "0";
                ///////////////////////////
                SampleDate1.Attributes.Add("onblur", "SetDateTimeDetails();");
                SampleTime11.Attributes.Add("onblur", "ValidateTime(this);SetDateTimeDetails();");
                SampleTime22.Attributes.Add("onblur", "ValidateTime(this);SetDateTimeDetails();");
                SampleTimeType1.Attributes.Add("onchange", "SetDateTimeDetails();");
                loadCollectSampleList(patientVisitID, gUID);
                hdnGuID.Value = gUID;
                btnFinish.Attributes.Add("onclick", "return GenerateWorkOrder(" + OrgID + "," + LID + "," + ILocationID + "," + patientVisitID + ",'" + gUID + "','" + strCollectAgain + "','" + strSampleRelationshipID + "')");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "HideInformationDetails", "EnabledFalse();", true);
                hdnTodayVisitID.Value = "0";

                List<ClientAttributesKeyFields> lsttempInvestigationVals = new List<ClientAttributesKeyFields>();
                JavaScriptSerializer jss = new JavaScriptSerializer();
                if (hdnClientAttrList.Value != "" && hdnClientAttrList.Value != null)
                {
                    lsttempInvestigationVals = jss.Deserialize<List<ClientAttributesKeyFields>>(hdnClientAttrList.Value);
                    BillingEngine billeng = new BillingEngine();
                    if (lsttempInvestigationVals.Count() > 0)
                    {
                        billeng.InsertClientAttributesFieldDetails(lstBillingDetails[0].VisitID, lsttempInvestigationVals);
                    }
                }
                List<ClientAttributesKeyFields> lsttempTestHistory = new List<ClientAttributesKeyFields>();
                JavaScriptSerializer JSonTestHsitory = new JavaScriptSerializer();
                if (hdnTestHistoryPatient.Value != "" && hdnTestHistoryPatient.Value != null)
                {
                    lsttempTestHistory = JSonTestHsitory.Deserialize<List<ClientAttributesKeyFields>>(hdnTestHistoryPatient.Value);
                    BillingEngine billeng = new BillingEngine(base.ContextInfo);
                    if (lsttempTestHistory.Count() > 0)
                    {
                        billeng.InsertTestHistoryPatientFieldDetails(lstBillingDetails[0].VisitID, lsttempTestHistory,"Insert");
                    }
                    hdnTestHistoryPatient.Value = "";
                }
            }
            else
            {

                string strErrorSave = Resources.Billing_AppMsg.Billing_ClientBilling_aspx_03 == null ? "Error While Saving Data" : Resources.Billing_AppMsg.Billing_ClientBilling_aspx_03;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "altSaveFailed", "ValidationWindow('" + strErrorSave + "','" + strAlert + "');clearPageControlsValue('N');", true);
            }

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error While Save Patient and Billing in Lab Quick Billing", ex);
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
    void GetPageValues()
    {
        billPart.IsClientSelected = txtClient.Text.Trim() == "" ? "N" : "Y";
        billPart.MappingClientID = Convert.ToInt64(hdnMappingClientID.Value);
        billPart.RateID = Convert.ToInt32(hdnRateID.Value);
        if (hdnSelectedClientClientID.Value != "0")
        {
            billPart.ClientID = Convert.ToInt64(hdnSelectedClientClientID.Value);
        }
        else
        {
            billPart.ClientID = Convert.ToInt64(hdnSelectedClientClientID.Value);

        }
        billPart.DespatchMode = CreateDespatchMode();
        //billPart.DespatchMode = Convert.ToInt32(ddlDespatchMode.SelectedItem.Value);
        billPart.getUserControlValue();

    }
    public void PrintBilling(long PatientID, long patientVisitID, long FinalBillID, long vpurpose, string ddlClientName)
    {
        string strPatVid = Resources.Billing_AppMsg.Billing_ClientBilling_aspx_04 == null ? "Patient VID:" : Resources.Billing_AppMsg.Billing_ClientBilling_aspx_04;


        string sPage = string.Empty;
        //hdnPageUrl.Value = "/Reception/ViewPrintPage.aspx?pid=" + patientID.ToString()
        //                    + "&vid=" + patientVisitID.ToString()
        //                    + "&pageid=BP&quickbill=Y&bid=" + FinalBillID + "&visitPur=" + vpurpose + "&ClientName=" + ddlClientName + "&OrgID=" + OrgID + "&IsPopup=Y" + "&RedirectPage=/Billing/LabQuickBilling.aspx";

        //Response.Redirect(Request.ApplicationPath  + hdnPageUrl.Value, true);
        string AlertMesg = strPatVid + " " + hdnVisitNumber.Value;

        sPage = "../Reception/PrintPage.aspx?pid=" + patientID.ToString()
                    + "&vid=" + patientVisitID.ToString()
                    + "&pagetype=BP&quickbill=N&bid=" + FinalBillID + "&visitPur=" + vpurpose + "&ClientName=" + ddlClientName + "&OrgID=" + OrgID + "&IsPopup=Y" + "&RedirectPage=/Billing/LabQuickBilling.aspx";
        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:clearPageControlsValue('N');ClearControlValues();alert('" + AlertMesg + "');", true);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:clearPageControlsValue('N');ClearControlValues();ValidationWindow('" + AlertMesg + "','" + strAlert + "');", true);

        ClearValues();
    }



    //public void SendSms(Patient lstPatient)
    //{
    //    Communication.SendSMS("Dear " + lstPatient.Name + ",\nYour test request has been registered successfully with\n" + OrgName + " at " + String.Format("{0:dd-MM-yyyy hh:mm:ss tt}", DateTime.Now) + ". Thank you.", lstPatient.PatientAddress[0].MobileNumber.Trim());
    //}



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
            long ZoneID = -1;
            DateTime DOB = new DateTime();
            if (chkIncomplete.Checked == false)
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
                if (ddlUnknownFlag.SelectedIndex > 0)
                {
                    objPatient.UnknownFlag = Convert.ToByte(ddlUnknownFlag.SelectedValue);
                }
                if (age != 0)
                {
                    objPatient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
                }
                else
                {
                    objPatient.Age = "";
                }

            }
            int PhleboId = -1;
            int logisticsId = -1;
            List<PatientAddress> pAddresses = new List<PatientAddress>();
            string DecimalAge = string.Empty;
            string DecimalAgeUnit = string.Empty;
            string[] tempAge;
            if (chkIncomplete.Checked == false)
            {
                string[] SplitAge = objPatient.Age.Split('~');
                tempAge = SplitAge[0].Split('.');
                AgeValue = Convert.ToInt32(tempAge[0]);
                DecimalAge = SplitAge[0];

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
                if (ddlUnknownFlag.SelectedIndex > 0)
                {
                    objPatient.UnknownFlag = Convert.ToByte(ddlUnknownFlag.SelectedValue);
                }
                if (age != 0)
                {
                    string[] SplitAge = objPatient.Age.Split('~');
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
            }
            string finalPName = string.Empty;

            if (hdnpatName.Value != "")
            {
                finalPName = hdnpatName.Value.ToString();
            }
            else
            {
                finalPName = txtName.Text.Trim().ToString();
            }




            patient.PatientID = Convert.ToInt64(hdnPatientID.Value);
            patient.OrgID = OrgID;
            patient.CreatedBy = LID;
            patient.Name = finalPName;
            if (hdnddlsalutation.Value != "0")
            {
                patient.TITLECode = Convert.ToByte(hdnddlsalutation.Value);
            }
            else
            {
                patient.TITLECode = Convert.ToByte(ddSalutation.SelectedValue);
            }
            if (chkIncomplete.Checked == false)
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
            else
            {
                patient.SEX = ddlSex.SelectedValue;
            }
            //DOB = new DateTime(1800, 1, 1);
            //string Date = "01/01/1800";
            //patient.DOB = Convert.ToDateTime(Date);
            //Int16.TryParse(txtDOBNos.Text.Trim(), out age);
            if (tDOB.Text == "")
            {
                tDOB.Text = hdnPatientDOB.Value;
            }

            DOB = new DateTime(1800, 1, 1);
            string Date;
            if (tDOB.Text.Trim().ToUpper() == "DD//MM//YYYY")
            {
                tDOB.Text = "";
            }
            if (tDOB.Text.Trim() == "")
            {
                Date = (tDOB.Text.Trim() == "" ? "01/01/1800" : tDOB.Text.Trim());
            }
            else
            {
                Date = (tDOB.Text.Trim() == "0" ? "01/01/1800" : tDOB.Text.Trim());
            }
            if (chkIncomplete.Checked == false)
            {
                patient.DOB = Convert.ToDateTime(Date);
            }
            else
            {
                patient.DOB = Convert.ToDateTime(Date);
            }
            Int16.TryParse(txtDOBNos.Text.Trim(), out age);
            if (chkIncomplete.Checked == false)
            {
                if (hdnDoFrmVisit.Value != "")
                {
                    if (hdnEdtPatientAge.Value != "0")
                    {
                        patient.Age = hdnEdtPatientAge.Value.ToString() + "~" + hdnEditDDlDOB.Value.ToString();
                    }
                    else
                    {
                        patient.Age = txtDOBNos.Text.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
                    }

                }
                else
                {
                    patient.Age = txtDOBNos.Text.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
                }
            }
            else
            {
                if (ddlUnknownFlag.SelectedIndex > 0)
                {
                    objPatient.UnknownFlag = Convert.ToByte(ddlUnknownFlag.SelectedValue);
                }
                if (txtDOBNos.Text.ToString() != null && txtDOBNos.Text.ToString() != "")
                {
                    patient.Age = txtDOBNos.Text.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
                }
                else
                {
                    patient.Age = "";
                }


            }
            patient.PatientNumber = hdnPatientNumber.Value;

            PA.Add1 = "";
            PA.Add2 = "";
            PA.City = "";
            patient.Add3 = "";
            PA.AddressType = "P";
            PA.LandLineNumber = "";
            PA.MobileNumber = txtMobileNumber.Text.Trim();
            hdnMobileNumber.Value = txtMobileNumber.Text;
            Int16.TryParse(ddCountry.SelectedValue, out CountryID);
            //Int16.TryParse(ddState.Value, out StateID);
            Int16.TryParse(hdnPatientStateID.Value, out StateID);
            PA.CountryID = CountryID;
            PA.StateID = StateID;
            pAddresses.Add(PA);
            patient.PatientAddress = pAddresses;
            patient.MartialStatus = ddMarital.SelectedValue.ToString();
            if (hdnpatName.Value != "")
            {
                patient.CompressedName = hdnpatName.Value;
            }
            else
            {
                patient.CompressedName = finalPName.ToString();
            }
            patient.Nationality = Convert.ToInt64(ddlNationality.SelectedValue);
            patient.StateID = StateID;
            patient.CountryID = CountryID;
            patient.PostalCode = "";
            patient.RegistrationFee = 0;
            patient.SmartCardNumber = "0";
            patient.RelationName = "";
            patient.RelationTypeId = 0;
            patient.Race = "";
            patient.EMail = txtEmail.Text;
            if (chkMobileNotify.Checked)
            {
                patient.NotifyType = 1;

            }
            else
            {
                patient.NotifyType = 0;
            }
            //patient.NotifyType = 0;
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
            ClientID = Convert.ToInt32(hdnSelectedClientClientID.Value);
            patient.ClientID = ClientID;
            patient.SecuredCode = System.Guid.NewGuid().ToString();
            patient.RateID = Convert.ToInt32(hdnRateID.Value);
            patient.PriorityID = "0";
            patient.ReferingPhysicianName = txtInternalExternalPhysician.Text;
            patient.ReferedHospitalID = Convert.ToInt32(hdfReferalHospitalID.Value);
            patient.ReferedHospitalName = txtReferringHospital.Text;
            patient.TPAID = Convert.ToInt64(hdnTPAID.Value);
            patient.TPAName = "";
            patient.TypeName = hdnClientType.Value;
            patient.TPAAttributes = "";
            patient.PatientVisitID = 0;
            patient.PatientHistory = billPart.PatientHistory;
            patient.RegistrationRemarks = billPart.Remarks;
            patient.PatientType = "";
            patient.PatientStatus = "";
            // patient.ExternalPatientNumber = "";
            patient.ExternalPatientNumber = txtExternalPatientNumber.Text.Trim();

            if (HdnPhleboName.Value != "" && HdnPhleboID.Value != "")
            {
                patient.PhleboID = Convert.ToInt32(HdnPhleboID.Value);
            }
            else
            {
                patient.PhleboID = PhleboId;
            }


            if (txtRoundNo.Text != "")
            {
                patient.RoundNo = txtRoundNo.Text.ToString();
            }
            else
            {
                patient.RoundNo = "";
            }


            if (hdnLogisticsName.Value != "" && hdnLogisticsID.Value != "")
            {
                patient.LogisticsID = Convert.ToInt32(hdnLogisticsID.Value);
            }
            else
            {
                patient.LogisticsID = logisticsId;
            }

            if (HidhdnZoneName.Value != "" && hdnZoneID.Value != "")
            {
                patient.ZoneID = Convert.ToInt32(hdnZoneID.Value);
            }
            else
            {
                patient.ZoneID = ZoneID;
            }


            if (chkExcludeAutoathz.Checked == true)
            {
                patient.ExAutoAuthorization = "Y";
            }
            else
            {
                patient.ExAutoAuthorization = "N";
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
            CLogger.LogError("Error while saving patient & Billing details in Lab Quick Bill.", ex);
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

            //HttpFileCollection hfc = Request.Files;
            //HttpFileCollection hf1= HttpContext.Current.Request.Files;
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
                        //returncode = patientBL.SaveTRFDetails(pictureName, pno, Vid, OrgID, 0, "TRF_Upload");
                        returncode = patientBL.SaveTRFDetails(pictureName, pno, Vid, OrgID, 0, "TRF_Upload", Root, LID, dt, "Y",0);
                        //hdnPatientImageName.Value = pictureName;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading LabRefOrgAddress Details.", ex);

        }
        return returncode;

    }

    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay();
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
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
    string CreateDespatchMode()
    {

        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml("<DespatchMode></DespatchMode>");
        XmlNode xmlNode;
        foreach (ListItem li in chkDespatchMode.Items)
        {
            if (li.Selected == true)
            {
                string Id = string.Empty;
                string name = string.Empty;
                Id = li.Value;
                name = li.Text;

                XmlElement xmlElement = Doc.CreateElement("DesPatchDetails");
                xmlNode = Doc.CreateNode(XmlNodeType.Element, "ID", "");
                xmlNode.InnerText = Id;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "ModeName", "");
                xmlNode.InnerText = name;
                xmlElement.AppendChild(xmlNode);

                Doc.DocumentElement.AppendChild(xmlElement);
            }
        }
        return Doc.InnerXml;

    }
    void ClearValues()
    {
		txtlabnumber.Text="";
        txtName.Text = "";
        txtMobileNumber.Text = "";
        txtName.Focus();
        txtDOBNos.Text = "";
        txtReferringHospital.Text = "";
        ddlDOBDWMY.SelectedIndex = 0;
        txtInternalExternalPhysician.Text = "";
        txtApprovalNo.Text = "";
        hdnReferralType.Value = "0";
        //txtClient.Text = "";
        txtEmail.Text = "";
        chkMobileNotify.Checked = false;
        txtRoundNo.Text = "";
        txtpassportno.Text = "";
        txtsrfid.Text = "";
        //        txtTestName.Text = "";
        //txtAuthorised.Text = "";
        //txtPatientHistory.Text = "";
        //txtRemarks.Text = "";
        //txtGross.Text = "0.00";
        //hdnGrossValue.Value = "0.00";
        //txtDiscount.Text = "0.00";
        //hdnDiscountAmt.Value = "0.00";
        //txtTax.Text = "0.00";
        //hdnTaxAmount.Value = "0.00";
        //hdfTax.Value = "0.00";
        //txtServiceCharge.Text = "0.00";
        //hdnServiceCharge.Value = "0.00";
        //txtRoundoffAmt.Text = "0.00";
        //hdnRoundOff.Value = "0.00";
        //txtNetAmount.Text = "0.00";
        //hdnNetAmount.Value = "0.00";
        //txtAmtReceived.Text = "0.00";
        //hdnAmountReceived.Value = "0.00";
        //txtDue.Text = "0.00";
        //hdnDue.Value = "0.00";
        //hdnRateID.Value = hdnBaseRateID.Value;
        hdnOPIP.Value = "OP";
        //hdfBillType1.Value = "";
        //        hdnFeeTypeSelected.Value = "COM";
        //hdnName.Value = "";
        //hdnAmt.Value = "0.00";
        // hdnID.Value = "";
        //hdnReportDate.Value = "";
        //hdnRemarks.Value = "";
        //hdnIsRemimbursable.Value = "";
        //hdnPaymentControlReceivedtemp.Value = "";
        txtExternalPatientNumber.Text = "";
        hdnPatientID.Value = "-1";
        hdnVisitPurposeID.Value = "-1";
        hdnClientID.Value = "-1";
        hdnTPAID.Value = "-1";
        hdnClientType.Value = "CRP";
        hdnReferedPhyID.Value = "0";
        hdnReferedPhyType.Value = "";
        //        lblPreviousDueText.Text = "0.00";
        //        hdnPatientStateID.Value = "0";
        hdnPreviousVisitDetails.Value = "";
        hdnPatientAlreadyExists.Value = "0";
        btnGenerate.Style.Add("display", "inline");
        btnClose.Style.Add("display", "block");
        string isExternalVisitID = Convert.ToString(hdnlabnumber.Value);
        if (isExternalVisitID == "Y")
        {
            txtlabnumber.Focus();
        }
        else
        {
            ddSalutation.Focus();
        }
        hdnPatientAlreadyExistsWebCall.Value = "0";
        //txtDiscountReason.Text = "";
        //ddlDiscountReason.SelectedItem.Value = "0";
        //        hdnIsReceptionPhlebotomist.Value = "N";
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
        //        hdnMappingClientID.Value = "-1";
        hdnIsMappedItem.Value = "N";
        // hdnIsDiscount.Value = "N";
        hdfReferalHospitalID.Value = "0";
        //hdnfinduplicate.Value = "";
        hdnClientBalanceAmount.Value = "-1";
        //        hdnActualAmount.Value = "0";
        hdnFinalBillID.Value = "-1";
        hdnReferedPhyName.Value = "";
        hdnReferedPhysicianCode.Value = "";
        //txtSampleDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy hh:mm tt");
        txtSampleDate.Text = OrgTimeZone;
        DateTime dt = new DateTime();
        dt = Convert.ToDateTime(OrgDateTimeZone);
        string Time = dt.ToString("hh:mm:tt");
        string[] SplitTime = Time.Split(':');
        txtSampleTime11.Text = SplitTime[0];
        txtSampleTime22.Text = SplitTime[1];
        ddlSampleTimeType1.SelectedValue = SplitTime[2];

        //txtSampleTime11.Text = System.DateTime.Now.ToString("hh");
        //txtSampleTime22.Text = System.DateTime.Now.ToString("mm");
        //ddlSampleTimeType1.SelectedValue = System.DateTime.Now.ToString("tt");
        //        txtSampleDate.Text = "";
        //hdnIsDiscountableTest.Value = "Y";
        // hdnInvCode.Value = "0";
        hdnIsCashClient.Value = "N";
        //ddlTaxPercent.SelectedItem.Value = "0"; ;
        //txtEDCess.Text = "0.00";
        //hdnEDCess.Value = "0.00";
        //txtSHEDCess.Text = "0.00";
        //hdnSHEDCess.Value = "0.00";
        hdnIsEditMode.Value = "N";
        for (int i = chkDespatchMode.Items.Count - 1; i >= 0; i--)
            chkDespatchMode.Items[i].Selected = false;
        SetDefaultClient = GetConfigValue("SetDefaultClientForLoc", OrgID);
        if (SetDefaultClient == "Y")
        {
            LoadDefaultClientNameBasedOnOrgLocation();
        }
        hdnTodayVisitID.Value = "0";
        rblSearchType.SelectedValue = "4";
        hdnpatName.Value = "";
        ddlUrnType.SelectedIndex = 0;
        ddlUrnoOf.SelectedIndex = 0;
        txtURNo.Text = "";

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
            string Location = string.IsNullOrEmpty(LocationName) ? "" : LocationName.Trim().ToString();
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
    public List<PatientDisPatchDetails> CreateDespatchMode1()
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
        return lstDispatchDetails;
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
    public string StrUrn = "";
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
}
