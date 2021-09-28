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
using System.Web.Script.Serialization;

using Attune.Podium.BillingEngine;
using System.Text;
using System.Security.Cryptography;
using System.Web.Caching;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using System.Xml;
using Attune.Podium.EMR;
using Attune.Podium.PerformingNextAction;
using System.Text.RegularExpressions;
public partial class Lab_InvestigationSample_aspx : BasePage, System.Web.UI.ICallbackEventHandler
{
    public Lab_InvestigationSample_aspx()
        : base("Lab_InvestigationSample_aspx")
    {
    }
    long taskID = -1;
    int taskactionID =Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
    long vid = -1;
    long returnCode = -1;
    string gUID = string.Empty;
    string strCollectAgain = string.Empty;
    string strSampleRelationshipID = string.Empty;
    string strCmoreSample = "N";
	int SampleID = 0;
    string MoreSampleID = string.Empty;
    string AlertMesg = Resources.Lab_AppMsg.Lab_InvestigationSample_aspx_01 == null ? "Collect sample for current visit and then click generate work order" : Resources.Lab_AppMsg.Lab_InvestigationSample_aspx_01;
    string AlertMesg1 = Resources.Lab_AppMsg.Lab_InvestigationSample_aspx_02 == null ? "Select department and then click generate work order" : Resources.Lab_AppMsg.Lab_InvestigationSample_aspx_02;
    string AlertType = Resources.Lab_AppMsg.Lab_Pendinglist_aspx_01 == null ? "Alert" : Resources.Lab_AppMsg.Lab_Pendinglist_aspx_01;
    //public string dispDeptBlock
    //{
    //    set { deptBlock.Style.Add("display", value); }
    //}
   
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            ClientScriptManager cs = Page.ClientScript;
            String callBackReference = cs.GetCallbackEventReference("'" + Page.UniqueID + "'", "arg", "TaskOpenJs", "", "ProcessCallBackError", false);
            String callBackScript = "function ValidateUserExit(arg) {" + callBackReference + "; }";
            cs.RegisterClientScriptBlock(this.GetType(), "CallUserNavigateValidation", callBackScript, true);
            if (Request.QueryString["gUID"] != null)
            {
                gUID = Request.QueryString["gUID"].ToString();
            }
			if (Request.QueryString["SID"] != null)
            {
                if (Request.QueryString["SID"].Contains(",") == true)
                {
                    MoreSampleID = Request.QueryString["SID"].ToString();
                }
                else
                {
                    Int32.TryParse(Request.QueryString["SID"], out SampleID);
                }
            }
            strCollectAgain = Request.QueryString["ColAgn"];
            strSampleRelationshipID = Request.QueryString["sid"];
            if (Request.QueryString["cms"] != null)
            {
                strCmoreSample = Request.QueryString["cms"].ToString();
            }
            //if (SampleID == 0)
            //{
            //    strCmoreSample = "Y";
            //}
            PatientDetail.IsPatHistNeed = true;
            if (!IsPostBack)
            {
                hdnSpecimendetails.Value = "Y";
                GateWay gateWay = new GateWay(base.ContextInfo);
                List<Config> lstConfig = new List<Config>();
                returnCode = gateWay.GetConfigDetails("PrintSampleBarcode", OrgID, out lstConfig);
                if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                {
                    ViewTRF.Attributes.Add("style", "display:block");
                    ctlCollectSample.IsBarcodeNeeded = true;
                }
                else
                {
                    ctlCollectSample.IsBarcodeNeeded = false;
                    ViewTRF.Attributes.Add("style", "display:none");
                }

                returnCode = gateWay.GetConfigDetails("PrintSrs", OrgID, out lstConfig);
                if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                {
                    ViewTRF.Attributes.Add("style", "display:block");
                    ctlCollectSample.IsSRSNeeded = true;
                }
                else
                {
                    ctlCollectSample.IsSRSNeeded = false;
                   // ViewTRF.Attributes.Add("style", "display:none");
                }

                if (Request.QueryString["Bool"] == "Y")
                {
                    Label lblVisit = (Label)PreviousPage.FindControl("lblVisitNo");
                    Int64.TryParse(lblVisit.Text, out vid);
                }
                if (Request.QueryString["VID"] != null)
                {
                    Int64.TryParse(Request.QueryString["VID"], out vid);
                    tblReferred.Style.Add("display", "none");
                }
                if (vid != -1)
                {
                    hdnVisitID.Value = Convert.ToString(vid);
                    loadList(vid);
                }
                if (RoleName == RoleHelper.Phlebotomist)
                {
                    PatientDetail.TocheckHistory(true);
                    // LoadSample("1");
                }
                returnCode = gateWay.GetConfigDetails("ShowInstructionForTest", OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    if (lstConfig[0].ConfigValue == "Y")
                    {

                        ScriptManager.RegisterStartupScript(Page, GetType(), "ClinicalEdit", "javascript:GetInstructions("+ vid +","+ OrgID +");", true);
                    }

                }
                btnFinish.Attributes.Add("onclick", "return GenerateWorkOrder(" + OrgID + "," + LID + "," + ILocationID + "," + vid + ",'" + gUID + "','" + strCollectAgain + "','" + strSampleRelationshipID + "')");
            }
            if (Request.QueryString["tid"] != null)
            {
                Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                tbl.isTaskAlreadyPicked(taskID, TaskHelper.TaskStatus.Pending, TaskHelper.TaskStatus.InProgress, LID);
            }
            hdorgid.Value = OrgID.ToString();
            hdnOrgID.Value = OrgID.ToString();
            hdnorgaddressid.Value = ILocationID.ToString();

            UserControl UC_DatePicker = (UserControl)this.Page.FindControl("DateTimePicker1");
            TextBox SampleDate = (TextBox)UC_DatePicker.FindControl("txtSampleDateCollect");
            TextBox SampleTime1 = (TextBox)UC_DatePicker.FindControl("txtSampleTime1");
            TextBox SampleTime2 = (TextBox)UC_DatePicker.FindControl("txtSampleTime2");
            DropDownList SampleTimeType = (DropDownList)UC_DatePicker.FindControl("ddlSampleTimeType");
            SampleDate.Attributes.Add("onblur", "SetDateTimeDetails();");
            SampleTime1.Attributes.Add("onblur", "ValidateTime(this);SetDateTimeDetails();");
            SampleTime2.Attributes.Add("onblur", "ValidateTime(this);SetDateTimeDetails();");
            SampleTimeType.Attributes.Add("onchange", "SetDateTimeDetails();");
            if (OrderedSamples1.isHistoFlagActive.Value!=null)
            {
                HdnFlagforprint.Value = OrderedSamples1.isHistoFlagActive.Value.ToString();
            }
        
        }
        catch (Exception ex)
        {
            //CLogger.LogError("Error in page load", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Error in page load";
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            Session["BarcodeDetails"] = null;
            Session["HistoBarcodeDetails"] = null;
			 Session["AttuneHisto"] = null;
            HdnButtonClicked.Value = "True";
            int status = -1;
            int upis = -1;
			int upStaus = -1;
            vid = Convert.ToInt64(hdnVisitID.Value);
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

            lstPatientInvSample = serializer.Deserialize<List<PatientInvSample>>(strLstPatientInvSample);
            lstSampleTracker = serializer.Deserialize<List<SampleTracker>>(strLstSampleTracker);
            lSampleMapping = serializer.Deserialize<List<PatientInvSampleMapping>>(strLstPatientInvSampleMapping);
            linvValues = serializer.Deserialize<List<InvestigationValues>>(strLstInvestigationValues);
            lstCollectedSampleStatus = serializer.Deserialize<List<string>>(strLstCollectedSampleStatus);
			lstPatientInvestigation = serializer.Deserialize<List<PatientInvestigation>>(strLstPatientInvestigation);
            
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
                                         lst.UID,
					 lst.ExternalBarcode
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
                                         UID = grp.Key.UID,
					 ExternalBarcode=grp.Key.ExternalBarcode
                                     }).Distinct().ToList();
                    //invBL.InsertPatientSampleMapping(groupByResult, vid, OrgID, 0, LID, out status);
                //returnCode = invBL.SavePatientInvSample(lstPatientInvSample,
                //    lstSampleTracker, lstDeptSamples, groupByResult, out status, out lstSampleId);
                // ctlCollectSample.ExtractInvestigations(vid, gUID);

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
                   if (returnCode == 0)
                {
                    long patientVisitID = vid;
                    ActionManager AM = new ActionManager(base.ContextInfo);
                    List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                    PageContextkey PC = new PageContextkey();
                    PC.RoleID = Convert.ToInt64(RoleID);
                    PC.OrgID = OrgID;
                    PC.PageID = Convert.ToInt64(PageID);
                    PC.ButtonName = "btnFinish";
                    PC.ButtonValue = "Generate Work Order";
                    PC.ActionType = "LISOrdered";
                    PC.PatientID = 0;
                    PC.PatientVisitID = patientVisitID;
                    lstpagecontextkeys.Add(PC);
                    long res = -1;
                    res = AM.PerformingNextStepNotification(PC, "", "");
                }
                   bool isSampleRejected = false;
                   foreach (PatientInvSample Obj1 in lstPatientInvSample)
                   {
                       lstTracker = (from ST in lstSampleTracker
                                     where ST.SampleID == Obj1.SampleCode
                                     select ST).ToList();


                       if (lstTracker != null)
                       {
                           if (lstTracker.Exists(P => P.InvSampleStatusID == 4))
                           {
                               sampleTracker = lstTracker.Find(P => P.InvSampleStatusID == 4);
                               Obj1.Reason = sampleTracker.Reason;
                               Obj1.InvSampleStatusID = sampleTracker.InvSampleStatusID;


                               isSampleRejected = true;
                           }
                           if (lstTracker.Exists(P => P.InvSampleStatusID == 6))
                           {
                               sampleTracker = lstTracker.Find(P => P.InvSampleStatusID == 6);
                               Obj1.Reason = sampleTracker.Reason;
                               Obj1.InvSampleStatusID = sampleTracker.InvSampleStatusID;


                               isSampleRejected = true;
                           }
                       }


                   }
                   if (isSampleRejected)
                   {
                       ActionManager AM = new ActionManager(base.ContextInfo);
                       List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                       PageContextkey PC = new PageContextkey();
                       PC.ID = Convert.ToInt64(ILocationID);
                       PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                       PC.RoleID = Convert.ToInt64(RoleID);
                       PC.OrgID = OrgID;
                       PC.PatientVisitID = vid;
                       PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
                       PC.ButtonName = PageContextDetails.ButtonName;
                       PC.ButtonValue = PageContextDetails.ButtonValue;
                       lstpagecontextkeys.Add(PC);
                       long res = -1;
                       res = AM.PerformingNextStepNotification(PC, "", "");
                   }
                   if (status == 0)
					{
                    int DeptID = 0;

                    /**Sample Status inserted in OrderedInvestigaton So below line Commented **/
                    //if (invStatus == String.Empty)
                    //{
                    //    new Investigation_BL(base.ContextInfo).getInvOrgSampleStatus(OrgID, "Paid", out invStatus);
                    //}
                    /********************************************************/

                    //invBL.UpdateOrderedInvestigationStatusinLab(linvValues, vid, invStatus, DeptID, "Paid", gUID, out upis);
                    //invBL.InsertPatientSampleMapping(groupByResult, vid, OrgID, 0, LID, out status);
                    // ctlCollectSample.ExtractInvestigations(vid, gUID);
                    //if (upis == 0)
                    //{
                    //    invBL.UpdatePatientInvestigationStatusinLab(lstPatientInvestigation, out upStaus);
                    //}
                    //invBL.UpdateOrderedInvestigationStatusinLab(linvValues, vid, invStatus, DeptID, "Paid", gUID, out upis);
                    if (status == 0)
					

                        if (  Request.QueryString["IsCT"]!=null || Request.QueryString["tid"] != null )
                        {
                            Int64.TryParse(Request.QueryString["tid"], out taskID);
                            if (strCmoreSample != "Y")
                            {
                                returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
                            }
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

                            List<Role> lstUserRole1 = new List<Role>();
                            string path1 = string.Empty;
                            Role role1 = new Role();
                            role1.RoleID = RoleID;
                            lstUserRole1.Add(role1);
                            returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);

                            if (returnCode == 0)
                            {
                                long pid = 0;
                                if (Request.QueryString["pid"] != null)
                                {
                                    Int64.TryParse(Request.QueryString["pid"], out pid);

                                }
                                if (Request.QueryString["VID"] != null)
                                {
                                    Int64.TryParse(Request.QueryString["VID"], out vid);

                                }
                                string NeedBillInvestigation = GetConfigValue("NeedBillInvestigationSRS", OrgID);
                                string sPage = "../Reception/PrintPage.aspx?pid=" + pid.ToString()
                                          + "&vid=" + vid.ToString()
                                          + "&pagetype=BP&quickbill=N&bid=" + 0 + "&visitPur=" + 0 + "&ClientName=" + 0 + "&OrgID=" + OrgID + "&IsPopup=Y" + "&IsNeedInv=Y";

                                //if (NeedBillInvestigation == "Y")
                                //{
                                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:OpenBillPrint('" + sPage + "');", true);
                                //}



                                if (ctlCollectSample.IsBarcodeNeeded)
                                {
                                    Session.Remove("IsSampleBarcodePrinted");
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
                                    if (GetConfigValue("IsHistoPrintEnable",OrgID) == "Y")
                                    {

                                        if (GetConfigValue(RoleID+"_IsHistoPrintEnable", OrgID) == "Y")
                                    {
                                    if (HdnFlagforprint.Value != null)
                                    {
                                        string[] hdnFlag = HdnFlagforprint.Value.Split('~');
                                        if (hdnFlag.Length > 0)
                                        {
                                            for (int i = 0; i < hdnFlag.Length; i++)
                                            {
                                                if (hdnFlag[i] == "Y")
                                                {
                                                     string containerhisto = BarcodeCategory.ContainerRegular;
                                                            objBarcodeHelper.GetBarcodeQueryString(OrgID, Convert.ToString(vid), lstSampleId, 0, containerhisto + "_HistoPrint", out lstBarcodeAttributes);
                                                    if (lstBarcodeAttributes.Count > 0)
                                                    {
                                                        foreach (BarcodeAttributes objBarcodeAttributes in lstBarcodeAttributes)
                                                        {
                                                            objPrintBarcode = new PrintBarcode();
                                                            objPrintBarcode.VisitID = objBarcodeAttributes.VisitID;
                                                            objPrintBarcode.SampleID = objBarcodeAttributes.SampleID;
                                                            objPrintBarcode.BarcodeNumber = objBarcodeAttributes.BarcodeNumber;
                                                            objPrintBarcode.MachineID = MachineID;
                                                            objPrintBarcode.HeaderLine3 = objBarcodeAttributes.HeaderLine3;
                                                            objPrintBarcode.HeaderLine4 = objBarcodeAttributes.HeaderLine4;
                                                            objPrintBarcode.FooterLine3 = objBarcodeAttributes.FooterLine3;
                                                            objPrintBarcode.FooterLine4 = objBarcodeAttributes.FooterLine4;
                                                            lstPrintBarcode.Add(objPrintBarcode);
                                                        }
                                                    }
                                                    if (lstPrintBarcode.Count > 0)
                                                    {
                                                        string barcode = string.Empty;
                                                        foreach (PrintBarcode oPrintBarcode in lstPrintBarcode)
                                                        {
                                                            if (barcode == string.Empty)
                                                            {
                                                                if (oPrintBarcode.HeaderLine3 != null && oPrintBarcode.HeaderLine4 != null && oPrintBarcode.FooterLine3 != null && oPrintBarcode.FooterLine4 != null)
                                                                {
                                                                    barcode = oPrintBarcode.HeaderLine3.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine4.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine3.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine4.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
                                                                }
                                                                else
                                                                {
                                                                }
                                                            }
                                                            else
                                                            {
                                                                if (oPrintBarcode.HeaderLine3 != null && oPrintBarcode.HeaderLine4 != null && oPrintBarcode.FooterLine3 != null && oPrintBarcode.FooterLine4 != null)
                                                                {
                                                                    barcode = barcode + "?" + oPrintBarcode.HeaderLine3.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine4.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine3.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine4.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
                                                                }
                                                                else
                                                                {
                                                                }
                                                            }
                                                        }
                                                        if (barcode != string.Empty)
                                                        {
                                                            if (Session["HistoBarcodeDetails"] == null)
                                                            {
                                                                Session["HistoBarcodeDetails"] = "attuneHistobarcode:" + barcode;
                                                            }
                                                            else
                                                            {
                                                                Session["HistoBarcodeDetails"] = Session["HistoBarcodeDetails"].ToString().Replace("attuneHistobarcode:", "").ToString() + barcode;

                                                            }

                                                        }
                                                        //}
                                                        //else
                                                        //{
                                                        //   GateWay objGateWay = new GateWay(base.ContextInfo);
                                                        //   Int32 returnStatus = -1;
                                                        //   objGateWay.SaveBarcodePrintDetails(lstPrintBarcode, out returnStatus);
                                                        //}
                                                        //Changes End by Arivalagan kk for cross browser print baroce//
                                                    }
                                                   
                                                }
                                                else  if (hdnFlag[i] == "N")
                                                {
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
                                                        string barcode = string.Empty;
                                                        foreach (PrintBarcode oPrintBarcode in lstPrintBarcode)
                                                        {
                                                            if (barcode == string.Empty)
                                                            {
                                                                if (oPrintBarcode.HeaderLine1 != null && oPrintBarcode.HeaderLine2 != null && oPrintBarcode.FooterLine1 != null && oPrintBarcode.FooterLine2 != null)
                                                                {
                                                                    barcode = oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
                                                                }
                                                            }
                                                            else
                                                            {
                                                                if (oPrintBarcode.HeaderLine1 != null && oPrintBarcode.HeaderLine2 != null && oPrintBarcode.FooterLine1 != null && oPrintBarcode.FooterLine2 != null)
                                                                {
                                                                    barcode = barcode + "?" + oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
                                                                }
                                                            }
                                                        }
                                                        if (barcode != string.Empty)
                                                        {
                                                           if (Session["BarcodeDetails"] == null)
                                                            {
                                                                Session["BarcodeDetails"] = "attunebarcode:" + barcode;
                                                            }
                                                            else
                                                            {
                                                                Session["BarcodeDetails"] = Session["BarcodeDetails"].ToString().Replace("attunebarcode:", "").ToString() + barcode;
                                                            }
                                                        }
                                                        //}
                                                        //else
                                                        //{
                                                        //   GateWay objGateWay = new GateWay(base.ContextInfo);
                                                        //   Int32 returnStatus = -1;
                                                        //   objGateWay.SaveBarcodePrintDetails(lstPrintBarcode, out returnStatus);
                                                        //}
                                                        //Changes End by Arivalagan kk for cross browser print baroce//
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        else
                                        {
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
                                                //Changed by Arivalagan kk for cross browser print barcode//
                                                //if (Session["RegKeyExists"] != null && Convert.ToString(Session["RegKeyExists"]) == "true")
                                                //{
                                                string barcode = string.Empty;
                                                foreach (PrintBarcode oPrintBarcode in lstPrintBarcode)
                                                {
                                                    if (barcode == string.Empty)
                                                    {
                                                        if (oPrintBarcode.HeaderLine1 != null && oPrintBarcode.HeaderLine2 != null && oPrintBarcode.FooterLine1 != null && oPrintBarcode.FooterLine2 != null)
                                                        {
                                                            barcode = oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
                                                        }
                                                    }
                                                    else
                                                    {
                                                        if (oPrintBarcode.HeaderLine1 != null && oPrintBarcode.HeaderLine2 != null && oPrintBarcode.FooterLine1 != null && oPrintBarcode.FooterLine2 != null)
                                                        {
                                                            barcode = barcode + "?" + oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
                                                        }
                                                    }
                                                }
                                                if (barcode != string.Empty)
                                                {
                                                    if (Session["BarcodeDetails"] == null)
                                                    {
                                                        Session["BarcodeDetails"] = "attunebarcode:" + barcode;
                                                    }
                                                    else
                                                    {
                                                        Session["BarcodeDetails"] = Session["BarcodeDetails"].ToString().Replace("attunebarcode:", "").ToString() + barcode;
                                                    }
                                                    // Session["HistoBarcodeDetails"] = null;// "attuneHistobarcode:" + barcode;
                                                }
                                                //}
                                                //else
                                                //{
                                                //   GateWay objGateWay = new GateWay(base.ContextInfo);
                                                //   Int32 returnStatus = -1;
                                                //   objGateWay.SaveBarcodePrintDetails(lstPrintBarcode, out returnStatus);
                                                //}
                                                //Changes End by Arivalagan kk for cross browser print baroce//
                                            }
                                        }
                                    }
                                    else
                                    {
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
                                                for (int K = 0; K < objBarcodeAttributes.BarcodeCount; K++)
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
                                                    if (oPrintBarcode.HeaderLine1 != null && oPrintBarcode.HeaderLine2 != null && oPrintBarcode.FooterLine1 != null && oPrintBarcode.FooterLine2 != null)
                                                    {
                                                        barcode = oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
                                                    }
                                                }
                                                else
                                                {
                                                    if (oPrintBarcode.HeaderLine1 != null && oPrintBarcode.HeaderLine2 != null && oPrintBarcode.FooterLine1 != null && oPrintBarcode.FooterLine2 != null)
                                                    {
                                                        barcode = barcode + "?" + oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
                                                    }
                                                }
                                            }
                                            if (barcode != string.Empty)
                                            {
                                                if (Session["BarcodeDetails"] == null)
                                                {
                                                    Session["BarcodeDetails"] = "attunebarcode:" + barcode;
                                                    CLogger.LogInfo("Print Barcode :   " + barcode);
                                                }
                                                else
                                                {
                                                    Session["BarcodeDetails"] = Session["BarcodeDetails"].ToString().Replace("attunebarcode:", "").ToString() + barcode;
                                                }
                                                // Session["HistoBarcodeDetails"] = null;// "attuneHistobarcode:" + barcode;
                                            }
                                            //}
                                            //else
                                            //{
                                            //   GateWay objGateWay = new GateWay(base.ContextInfo);
                                            //   Int32 returnStatus = -1;
                                            //   objGateWay.SaveBarcodePrintDetails(lstPrintBarcode, out returnStatus);
                                            //}
                                            //Changes End by Arivalagan kk for cross browser print baroce//
                                        }
                                    
                                    
                                    }
                                    if (Request.QueryString["IsCT"] != null)
                                    {
                                        if (GetConfigValue("IsHistoPrintEnable",OrgID) == "Y")
                                        {
                                            if (GetConfigValue(RoleID + "_IsHistoPrintEnable", OrgID) == "Y")
                                            {
                                        string sessionvariable = string.Empty;
                                       // CLogger.LogWarning("attune Barcode:"+ Session["BarcodeDetails"].ToString());
                                       // CLogger.LogWarning("attune Histo Barcode:"+ Session["HistoBarcodeDetails"].ToString());
                                        if (Session["BarcodeDetails"] != null && Session["HistoBarcodeDetails"] != null)
                                        {
                                            sessionvariable =  Session["HistoBarcodeDetails"].ToString() + "_" + Session["BarcodeDetails"].ToString();
                                            sessionvariable = sessionvariable.Replace("attuneHistobarcode", " ").ToString().Replace("attunebarcode", "").ToString(); //+ "_" + Session["BarcodeDetails"].ToString().Replace("attunebarcode", "");
                                            Session["AttuneHisto"] = sessionvariable;
                                        }
                                        else if (Session["BarcodeDetails"] != null && Session["HistoBarcodeDetails"] == null)
                                        {
                                            
                                            Session["HistoBarcodeDetails"] = "";
                                            sessionvariable =  Session["HistoBarcodeDetails"].ToString() + "_" + Session["BarcodeDetails"].ToString();
                                            sessionvariable= sessionvariable.Replace("attunebarcode", " ").ToString(); //+ "_" + Session["BarcodeDetails"].ToString().Replace("attunebarcode", "");
                                            Session["AttuneHisto"] = "AttuneHisto:" + sessionvariable;
                                           
                                        }
                                        else if (Session["BarcodeDetails"] == null && Session["HistoBarcodeDetails"] != null)
                                        {
                                            Session["BarcodeDetails"] = "";
                                            sessionvariable=  Session["HistoBarcodeDetails"].ToString() + "_" + Session["BarcodeDetails"].ToString();
                                            sessionvariable = sessionvariable.Replace("attuneHistobarcode", " ").ToString(); //+ "_" + Session["BarcodeDetails"].ToString().Replace("attunebarcode", "");
                                            Session["AttuneHisto"] = "AttuneHisto:" + sessionvariable;
                                            
                                                }
                                                Response.Redirect("../Phlebotomist/home.aspx" + "?vid=" + vid + "&sampleId=" + lstSampleId + "&gUID=" + gUID + "&categoryCode=" + BarcodeCategory.ContainerRegular + "&INVSRS=" + NeedBillInvestigation, true);
                                            }
                                            else
                                            {
                                                Response.Redirect("../Phlebotomist/home.aspx" + "?vid=" + vid + "&sampleId=" + lstSampleId + "&gUID=" + gUID + "&categoryCode=" + BarcodeCategory.ContainerRegular + "&INVSRS=" + NeedBillInvestigation, true);
                                            }
                                          
                                        }
                                        else
                                        {
                                            Response.Redirect("../Phlebotomist/home.aspx" + "?vid=" + vid + "&sampleId=" + lstSampleId + "&gUID=" + gUID + "&categoryCode=" + BarcodeCategory.ContainerRegular + "&INVSRS=" + NeedBillInvestigation, true);
                                        }
                                      
                                       

                                    }
                                    else
                                    {
                                        if (GetConfigValue("IsHistoPrintEnable",OrgID) == "Y")
                                        {
                                            if (GetConfigValue(RoleID + "_IsHistoPrintEnable",OrgID) == "Y")
                                            {
                                        string sessionvariable = string.Empty;
                                       // CLogger.LogWarning("attune Barcode:"+ Session["BarcodeDetails"].ToString());
                                       // CLogger.LogWarning("attune Histo Barcode:"+ Session["HistoBarcodeDetails"].ToString());
                                        if (Session["BarcodeDetails"] != null && Session["HistoBarcodeDetails"] != null)
                                        {
                                            sessionvariable =  Session["HistoBarcodeDetails"].ToString() + "_" + Session["BarcodeDetails"].ToString();
                                            sessionvariable = sessionvariable.Replace("attuneHistobarcode", " ").ToString().Replace("attunebarcode", "").ToString(); //+ "_" + Session["BarcodeDetails"].ToString().Replace("attunebarcode", "");
                                            Session["AttuneHisto"] = sessionvariable;
                                        }
                                        else if (Session["BarcodeDetails"] != null && Session["HistoBarcodeDetails"] == null)
                                        {
                                            
                                            Session["HistoBarcodeDetails"] = "";
                                            sessionvariable =  Session["HistoBarcodeDetails"].ToString() + "_" + Session["BarcodeDetails"].ToString();
                                            sessionvariable= sessionvariable.Replace("attunebarcode", " ").ToString(); //+ "_" + Session["BarcodeDetails"].ToString().Replace("attunebarcode", "");
                                            Session["AttuneHisto"] = "AttuneHisto:" + sessionvariable;
                                           
                                        }
                                        else if (Session["BarcodeDetails"] == null && Session["HistoBarcodeDetails"] != null)
                                        {
                                            Session["BarcodeDetails"] = "";
                                            sessionvariable=  Session["HistoBarcodeDetails"].ToString() + "_" + Session["BarcodeDetails"].ToString();
                                            sessionvariable = sessionvariable.Replace("attuneHistobarcode", " ").ToString(); //+ "_" + Session["BarcodeDetails"].ToString().Replace("attunebarcode", "");
                                            Session["AttuneHisto"] = "AttuneHisto:" + sessionvariable;
                                            
                                        }

                                        CLogger.LogWarning("AttuneHisto:" + Session["AttuneHisto"].ToString());
                                            Response.Redirect("../Phlebotomist/home.aspx" + "?vid=" + vid + "&sampleId=" + lstSampleId + "&gUID=" + gUID + "&categoryCode=" + BarcodeCategory.ContainerRegular + "&INVSRS=" + NeedBillInvestigation, true);
                                            }
                                            else
                                            {
                                                Response.Redirect("../Phlebotomist/home.aspx" + "?vid=" + vid + "&sampleId=" + lstSampleId + "&gUID=" + gUID + "&categoryCode=" + BarcodeCategory.ContainerRegular + "&INVSRS=" + NeedBillInvestigation, true);
                                            }
                                            

                                           
                                        }
                                        else
                                        {
                                            Response.Redirect("../Phlebotomist/home.aspx" + "?vid=" + vid + "&sampleId=" + lstSampleId + "&gUID=" + gUID + "&categoryCode=" + BarcodeCategory.ContainerRegular + "&INVSRS=" + NeedBillInvestigation, true);
                                        }
                                    }
                                }
                                else if(ctlCollectSample.IsSRSNeeded)
                                {
                                    Session.Remove("IsSampleBarcodePrinted");
                                    if (Request.QueryString["IsCT"] != null || Request.QueryString["IsCT"] != "")
                                    {
                                        Response.Redirect("../Phlebotomist/home.aspx" + "?vid=" + vid + "&sampleId=" + lstSampleId + "&gUID=" + gUID + "&categoryCode=" + BarcodeCategory.ContainerRegular + "&INVSRS=" + NeedBillInvestigation, true);

                                    }
                                    else
                                    {
                                        Response.Redirect(Request.ApplicationPath + path1 + "?vid=" + vid + "&sampleId=" + lstSampleId + "&gUID=" + gUID + "&categoryCode=" + BarcodeCategory.ContainerRegular + "&INVSRS=" + NeedBillInvestigation, true);
                                    }


                                }
                                else
                                {
                                    Response.Redirect(Request.ApplicationPath + path1, true);
                                }
                            }
                        }
                    
                    divPatientDetails.Style.Add("display", "none");
                    dInves.Style.Add("display", "none");
                    btnFinish.Visible = false;
                    Response.Redirect("WorkOrder.aspx?VID=" + vid + "&gUID=" + gUID);
                }
            }
            else
            {
                if (lstSampleTracker.Count == 0)
                {
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Collect sample for current visit and then click generate work order');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('" + AlertMesg + "','" + AlertType + "');", true);
                }
                else if (lstDeptSamples.Count == 0)
                {
                   // ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Select department and then click generate work order');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('" + AlertMesg1 + "','" + AlertType + "');", true);
                }
                //ErrorDisplay1.ShowError = true;
                //ErrorDisplay1.Status = "Collect sample for current visit and then click generate work order";
            }
        }
        catch (Exception ex)
        {
            //CLogger.LogError("Error while generating work order", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Error while generating work order";
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

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {

            HdnButtonClicked.Value = "True";
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                TaskOpen();
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            //CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Error while cancel";
        }
    }
    
    protected void BTNCheck_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["VID"] != null)
        {
            Int64.TryParse(Request.QueryString["VID"], out vid);
            tblReferred.Style.Add("display", "none");
        }
        if (vid != -1)
        {
            hdnVisitID.Value = Convert.ToString(vid);
            loadList(vid);
            Control or = OrderedSamples1;
            
        }
    }
    public void loadList(long VisitID)
    {
        try
        {
            string strInvColNSList = string.Empty;
            string strInvRejected = string.Empty;
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

            if (visitList.Count > 0)
            {
                dInves.Style.Add("display", "block");
                DrName.Text = visitList[0].ReferingPhysicianName;
                HospitalName.Text = visitList[0].HospitalName;
                hdnEmpNo.Value = visitList[0].PatientNumber;

                if (visitList[0].CollectionCentreName != null && visitList[0].CollectionCentreName != "")
                {
                    trCC.Style.Add("display", "block");
                    CollectionCentre.Text = visitList[0].CollectionCentreName;
                }
                else
                {
                    trCC.Style.Add("display", "none");
                }
            }
            if (Request.QueryString["taskactionid"] != null)
            {
                Int32.TryParse(Request.QueryString["taskactionid"], out taskactionID);
            }
            Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
            invbl.GetInvestigationSamplesCollect(VisitID, OrgID, RoleID, gUID, ILocationID, taskactionID, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);

            //Select dept for corresponding Role
            if (lstRoleDept.Count > 0)
                hDept.Value = Convert.ToString(lstRoleDept[0].DeptID);
            if (lstRoleDept.Count == 0)
            {
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Sorry! No Department Associated with Current Role. Please contact system administrator');", true);
                //ErrorDisplay1.ShowError = true;
                //ErrorDisplay1.Status = "Sorry! No Department Associated with Current Role. Please contact system administrator";
            }
            List<PatientInvestigation> PaidItems = new List<PatientInvestigation>();
            //Load list  of samples in OrderSample list user control
            if (lstPatientInvestigation.Count() > 0)
            {
                if (strCollectAgain == "Y" && strCmoreSample != "Y")
                {
                    List<CollectedSample> lstCollectNewSample = new List<CollectedSample>();
                   
                    if (strSampleRelationshipID.Contains(",") == true)
                    {
                        strSampleRelationshipID = "0";
                        lstCollectNewSample = lstOrderedInvSample.FindAll(P => P.TestStatus == "Not given");
                    }
                    else
                    {
                        lstCollectNewSample = lstOrderedInvSample.FindAll(P => P.SampleID == Convert.ToInt32(strSampleRelationshipID));
                    }
                    lstPatientInvestigation = lstPatientInvestigation.FindAll(p => p.Status != "SampleReceived");

                    OrderedSamples1.LoadSamples(lstPatientInvestigation);
                    SampleCollectedVisit1.LoadSamples(lstCollectNewSample,deptList);
                }
                else
                {
                    lstPatientInvestigation = lstPatientInvestigation.FindAll(p => p.Status != "SampleReceived");
                    OrderedSamples1.LoadSamples(lstPatientInvestigation);
                    SampleCollectedVisit1.LoadSamples(lstOrderedInvSample, deptList);
                }
                //Change Sample name into dropdown List
                List<PatientInvestigation> lstInvColNSList = new List<PatientInvestigation>();
                List<PatientInvestigation> lstNotCollectedInvestigation = new List<PatientInvestigation>();
                if (strCollectAgain == "Y")
                {
                    long result;
                    if (strSampleRelationshipID.Contains(",") == true)
                    {
                        strSampleRelationshipID = "0";
                    }
                    result = invbl.GetInvestigationForSampleID(VisitID, OrgID, Convert.ToInt32(strSampleRelationshipID), out lstInvColNSList);

                    foreach (PatientInvestigation i in lstInvColNSList)
                    {
                        if (strInvColNSList == "")
                        {
                            strInvColNSList = i.InvestigationID.ToString() + "~" + i.SampleID.ToString() + "~" + i.ComplaintId;
                        }
                        else
                        {
                            strInvColNSList = strInvColNSList + "," + i.InvestigationID.ToString() + "~" + i.SampleID.ToString() + "~" + i.ComplaintId;
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

                    PaidItems = lstPatientInvestigation.FindAll(P => P.Status == InvStatus.Paid || P.Status == InvStatus.PartialyCollected || P.Status == InvStatus.Notgiven || P.Status == InvStatus.Ordered);
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
                List<PatientInvSample> lsttmpPatInvSample = new List<PatientInvSample>();
                PatientInvSample OPatientInvSample=new PatientInvSample();
                invbl.GetDeptToTrackSamples(VisitID, OrgID, RoleID, gUID, out lstSampleDept, out lsttmpPatInvSample);
                if (lsttmpPatInvSample.Count > 0)
                {
                    if (!String.IsNullOrEmpty(lsttmpPatInvSample[0].VisitNumber) && lsttmpPatInvSample[0].VisitNumber.Length > 0)
                    {
                        hdnvisitnumber.Value = Convert.ToString(lsttmpPatInvSample[0].VisitNumber);
                    }
                }
                if (SampleID == 0 && strCmoreSample == "Y")
                {
                    invbl.GetSampleDetails(SampleID, VisitID, OrgID, gUID, out OPatientInvSample);
                    lstPatInvSample = lsttmpPatInvSample.FindAll(P => P.SampleCode == OPatientInvSample.SampleCode && P.SampleContainerID == OPatientInvSample.SampleContainerID);
               

                }
                if (SampleID > 0)
                {
                    invbl.GetSampleDetails(SampleID, VisitID, OrgID, gUID, out OPatientInvSample);
                    lstPatInvSample = lsttmpPatInvSample.FindAll(P => P.SampleCode == OPatientInvSample.SampleCode && P.SampleContainerID == OPatientInvSample.SampleContainerID);
                }
                else
                {
                    if (lsttmpPatInvSample.Count > 0)
                    {
                        lstPatInvSample = lsttmpPatInvSample;
                    }
                }
                if (strCollectAgain == "Y")
                {
                    foreach (string strInv in strInvColNSList.Split(','))
                    {
                        int intPosition = -1;
                        int intSampleCode = 0;
                        int SID = 0;
                        string strInvestigationID = "";
                        if (strInv.IndexOf("~") != -1)
                        {

                            if (SampleID >0)
                            {

                              //  intPosition = strInv.IndexOf("~");
                              //  strInvestigationID = strInv.Substring(0, intPosition);
                              //  intSampleCode = Convert.ToInt32(strInv.Substring(intPosition + 1));
                                ArrayList Lst = new ArrayList(strInv.Split('~'));
                                strInvestigationID = Convert.ToString(Lst[0]);
                                intSampleCode = Convert.ToInt32(Lst[1]);

                                lstPatInvSample.RemoveAll(P => (P.InvestigationID != strInvestigationID && P.SampleCode != intSampleCode));
                            }
                            else
                            {
                                ArrayList Lst = new ArrayList(strInv.Split('~'));

                                strInvestigationID = Convert.ToString(Lst[0]);
                                intSampleCode = Convert.ToInt32(Lst[1]);
                                SID = Convert.ToInt32(Lst[2]);

                                lstPatInvSample.FindAll(P => (P.SampleID.ToString().Contains(MoreSampleID)));
                                //foreach (string strInv1 in MoreSampleID.Split(','))
                                //{
                                //    if (SID != Convert.ToInt32(strInv1))
                                //    {
                                //        lstPatInvSample.FindAll(P => (P.SampleID.ToString().Contains(MoreSampleID)));
                                //    }
                                //}

                            }
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
                
                divPatientDetails.Style.Add("display", "block");
                lblStatus.Visible = false;
                dInves.Style.Add("display", "block");
                btnFinish.Visible = true;
            }
            else
            {
                lblStatus.Visible = true;
                divPatientDetails.Style.Add("display", "none");
                dInves.Style.Add("display", "none");
            }
           //OrderedSamples1.dispDeptBlock = "none";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while load data investigation sample", ex);
        }
    }
    
    private void TaskOpen()
    {
        try
        {
            long taskID = -1;
            Int64.TryParse(Request.QueryString["tid"], out taskID);
            returnCode = new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Pending, LID, "ReleaseTask");
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
            if (HdnButtonClicked.Value != "True")
            {
                TaskOpen();
            }
        }
        catch (Exception ex)
        {
            //CLogger.LogError("Error in RaiseCallbackEvent", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Error while processing task";
        }
    }
    public string GetCallbackResult()
    {
        return "LockReleased";
    }
}
