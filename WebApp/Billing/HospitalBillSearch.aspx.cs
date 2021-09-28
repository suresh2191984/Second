using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Configuration;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Utilitie.Helper;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using PdfSharp.Pdf.Advanced;
using PdfSharp.Pdf.Security;
using System.Web.UI.HtmlControls;
using Microsoft.Reporting.WebForms;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data;

public partial class Billing_HospitalBillSearch : BasePage
{

    public Billing_HospitalBillSearch()
        : base("Billing_HospitalBillSearch_aspx")
    {
    }
  
    string type;
    long retval = -1;
    long returnCode = -1;
    long visitID = -1;
    long pvisitID = -1;
    string TransPass = string.Empty;
    string strHealthCoupon = string.Empty;
    string AlertMessage = string.Empty;
    string AlertMesg = Resources.Billing_AppMsg.Billing_HospitalBillSearch_aspx_15 == null ? "you cannot cancel the bill for Processed Test! " : Resources.Billing_AppMsg.Billing_HospitalBillSearch_aspx_15;
    string AlertDueMsg = Resources.Billing_AppMsg.Billing_HospitalBillSearch_aspx_16 == null ? "Kindly Collect the Due Amount before Cancel or Refund! " : Resources.Billing_AppMsg.Billing_HospitalBillSearch_aspx_16;
    string AlertParentBillMsg = Resources.Billing_AppMsg.Billing_HospitalBillSearch_aspx_17 == null ? "You are not allowed to Cancel or Refund the Parent Location Bill!" : Resources.Billing_AppMsg.Billing_HospitalBillSearch_aspx_17;
    string Header = Resources.Billing_AppMsg.Billing_Header_Alert == null ? "Alert" : Resources.Billing_AppMsg.Billing_Header_Alert;
   
    #region "Initial"

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        TransPass = GetConfigValue("PasswordAuthentication", OrgID);
        uctrlBillSearch.onSearchComplete += new EventHandler(uctrlBillSearch_onSearchComplete);
        if (!IsPostBack)
        {
            BindDropDownValues();
            //if (RoleID == 1)
            //{
            //    physicianHeader.Visible = true;
            //    userHeader.Visible = false;
            //}
            //else
            //{
            //    physicianHeader.Visible = false;
            //    userHeader.Visible = true;
            //}
            //long returnCode = -1;
            //Patient_BL patBL = new Patient_BL(base.ContextInfo);
            //List<SearchActions> pages = new List<SearchActions>();
            //type = "BillSearch";
            //returnCode = patBL.GetSearchActionsByPage(RoleID, type, out pages);
            //dList.DataSource = pages;
            //dList.DataTextField = "ActionName";
            //dList.DataValueField = "PageURL";
            //dList.DataBind();
        }
    }
 
	
	    #endregion

    #region "Events"

    protected void uctrlBillSearch_onSearchComplete(object sender, EventArgs e)
    {
        if (uctrlBillSearch.HasResult)
        {
            aRow.Visible = true;
        }
        else
        {
            aRow.Visible = false;
        }
    }
    string strLab = Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_01 == null ? "Lab Manager" : Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_01;
   
    protected void bGo_Click(object sender, EventArgs e)
    {
        try
        {
            Patient_BL pbl = new Patient_BL(base.ContextInfo);
            string patientType = string.Empty;
            long vid = Convert.ToInt64(hdnVID.Value);
            long pid = Convert.ToInt64(hdnPID.Value);
            long FinalBillID = 0;
            string BillNo = string.Empty;
            Int64.TryParse(hdnBID.Value, out FinalBillID);
            BillNo = hdnBillNo.Value;
            string CancelBillStatus = "N,0";

            TextBox txtvisitno = (TextBox)uctrlBillSearch.FindControl("txtVisitNo");
            TextBox txtPatientno = (TextBox)uctrlBillSearch.FindControl("txtPatientNumber");
            TextBox txtBillno = (TextBox)uctrlBillSearch.FindControl("txtBillNo");
            TextBox txtPatientName = (TextBox)uctrlBillSearch.FindControl("txtPatientName");
            TextBox txtClientName = (TextBox)uctrlBillSearch.FindControl("txtClientName");
            TextBox txtPhysician = (TextBox)uctrlBillSearch.FindControl("txtInternalExternalPhysician");
            CheckBox chk1 = (CheckBox)uctrlBillSearch.FindControl("chkSplit");
            DropDownList ddldt = (DropDownList)uctrlBillSearch.FindControl("ddlRegisterDate");
            hdnOldSearch.Value = txtvisitno.Text + "^" + txtPatientno.Text + "^" + txtBillno.Text + "^" + txtPatientName.Text + "^" + txtClientName.Text + "^" + txtPhysician.Text + "^" + chk1.Checked + "^" + ddldt.SelectedItem.Value;

            string purpose = hdnVisitDetail.Value;
            ContextInfo.AdditionalInfo = Convert.ToString(FinalBillID);
            pbl.pCheckPatientisIPorOP(vid, pid, OrgID, out patientType);
            if (RoleName != strLab.Trim())
            {
                if (dList.SelectedValue == "Cancel_Bill_RefundtoPatient" || dList.SelectedValue == "Refund_to_Patient_RefundtoPatient")
                {
                    pbl.CheckStatusForCancelBill(vid, pid, OrgID, out CancelBillStatus);
                    string[] s = CancelBillStatus.Split(',');
                    if (s.Length > 0)
                    {
                        if (s[0].ToString() == "Y")
                        {
                            /*add condition in If  for blocking*/
                            
                            //if (s[1].ToString() == "SP" && GetConfigValue("AllowCancelEvenSampleProcessed", OrgID).Equals("Y") == true)
                            if (s[1].ToString() == "PBY")
                            {
                                AlertMessage = "Transfer Order Bill";                              
                            }
                            if (s[2].ToString() == "DY" && GetConfigValue("BlockCancelforDue", OrgID).Equals("Y") == true)
                            {
                                AlertMessage = AlertMessage + "</br> Due Bill";
                            }
                            if (s[3].ToString() == "SPY" && GetConfigValue("BlockCancelforSampleProcessed", OrgID).Equals("Y") == true)
                            {
                                AlertMessage = AlertMessage + "</br> All Samples for this bill are already Processed";
                            }
                            if (AlertMessage.Length>0)
                            {
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('You are not allowed to Cancel or Refund bill for the following reason </br>" + AlertMessage + "','" + Header + "');", true);    
                            }
                            else
                            {
                                CancelBillStatus = "N,0";
                            }
                            
                        }
                        else
                        {
                            CancelBillStatus = "N,0";
                        }

                    }

                }
            }
            if (CancelBillStatus == "N,0" )
            {

            if (patientType != "Admitted" || purpose != "Add Bill Items")
            {
                string[] temp = hdnVisitTypeCredit.Value.Split('~');
                string pagename = string.Empty;
                if (dList.SelectedValue != "Print_Bill_Print_Page")
                {
                    #region Get Redirect URL
                    QueryMaster objQueryMaster = new QueryMaster();

                    string RedirectURL = string.Empty;
                    string QueryString = string.Empty;
                    //if (lstActionsMaster.Exists(p => p.ActionCode == dList.SelectedValue))
                    //{
                    //    QueryString = lstActionsMaster.Find(p => p.ActionCode == dList.SelectedValue).QueryString;
                    //}
                    #region View State Action List
                    string ActCode = dList.SelectedValue;
                    string ActionList = ViewState["ActionList"].ToString();
                    foreach (string CompareList in ActionList.Split('^'))
                    {
                        if (CompareList.Split('~')[0] == ActCode)
                        {
                            QueryString = CompareList.Split('~')[1];
                            break;
                        }
                    }
                    #endregion
                    QueryString = QueryString + "&hdn=" + hdnOldSearch.Value;
                    objQueryMaster.Querystring = QueryString;
                    objQueryMaster.PatientID = hdnPID.Value;
                    objQueryMaster.PatientVisitID = hdnVID.Value;
                    objQueryMaster.FinalBillID = FinalBillID.ToString();
                    objQueryMaster.BillNumber = BillNo.ToString();
                    objQueryMaster.PatientName = hdnPNAME.Value;
                    objQueryMaster.PatientNumber = hdnPNumber.Value;
                    if (temp.Length > 1)
                    {
                        objQueryMaster.ViewType = temp[0].ToString();
                        objQueryMaster.CreditValue = temp[1];
                    }
                    else {
                        objQueryMaster.ViewType = "";
                        objQueryMaster.CreditValue = "";
                    }
                    
                    if (TransPass == "Y")
                    {
                        objQueryMaster.actionCode = dList.SelectedValue;
                        int SearchType = (int)TaskHelper.SearchType.BillSearch;
                        objQueryMaster.searchtype = Convert.ToString(SearchType);
                    }
                    AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);


                    if (!String.IsNullOrEmpty(RedirectURL))
                    {

                        //added by Thamilselvan R...for Changing same as Billing...
                        //   strHealthCoupon = GetConfigValue("HealthcardCoupon", OrgID);
                        string strSsrsShowReport = string.Empty;
                        strSsrsShowReport = GetConfigValue("B2CSSRSFILLFORMAT", OrgID);
                        //BillingEngine bills = new BillingEngine(base.ContextInfo);
 string Showconsentform = string.Empty;
                        Showconsentform = GetConfigValue("Showconsentform", OrgID);
                        string strclientssrsreport = string.Empty;
                        //List<BillingDetails> Istclientbillreport = new List<BillingDetails>();
                        //long returncode = bills.GetClientbasedReportPrima(OrgID, vid, FinalBillID, out Istclientbillreport);
                        //if (Istclientbillreport.Count > 0)
                        //{
                        //    strclientssrsreport = Istclientbillreport[0].ReferenceType.ToString();
                        //}
                        //strclientssrsreport  = hdnChecklist.Value;
                        strclientssrsreport = uctrlBillSearch.CheckType;
                        CheckBox chk = (CheckBox)uctrlBillSearch.FindControl("chkSplit");
                        if (chk.Checked == true)
                        {
                            Response.Redirect(RedirectURL + "&Split=Y", true);
                        }
                        else if (strSsrsShowReport == "Y" && dList.SelectedValue == "Print_Bill_ViewPrintPage")
                        {
                            CouponCardBillFrame.Attributes["src"] = "..\\Investigation\\BillPrint.aspx?vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&actionType=POPUP&isFullBill=Y&type=printreport&invstatus=approve" + "&navpanes=0";//added by Thamilselvan R...for Changing same as Billing...
                            //CouponCardBillFrame.Attributes["src"] = "..\\Reception/MultiPdfView.ashx?OrgID=" + OrgID + "&LocationID=" + ILocationID + "&PrintBill=Y&vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&actionType=POPUP&type=printreport&invstatus=approve" + "&#toolbar=0&navpanes=0&toolbar=1";//added by Thamilselvan R...for Changing same as Billing...
                            hdnTargetCtlMailReport.Value = "test";//added by Thamilselvan R...for Changing same as Billing...
                            modalpopupsendemail.Show();//added by Thamilselvan R...for Changing same as Billing...
                        }
                        else if (strclientssrsreport == "Y" && dList.SelectedValue == "Print_Client_Bill_ViewPrintPage")
                        {
                            objQueryMaster.searchtype = uctrlBillSearch.CheckType;
                            CouponCardBillFrame.Attributes["src"] = "..\\Investigation\\BillPrint.aspx?vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&referenceType=" + strclientssrsreport + "&actionType=POPUP&isFullBill=Y&type=printreport&invstatus=approve" + "&navpanes=0";//added by Thamilselvan R...for Changing same as Billing...

                            //CouponCardBillFrame.Attributes["src"] = "..\\Reception/MultiPdfView.ashx?OrgID=" + OrgID + "&LocationID=" + ILocationID + "&PrintBill=Y&vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&actionType=POPUP&type=printreport&invstatus=approve" + "&#toolbar=0&navpanes=0&toolbar=1";//added by Thamilselvan R...for Changing same as Billing...
                            hdnTargetCtlMailReport.Value = "test";//added by Thamilselvan R...for Changing same as Billing...
                            modalpopupsendemail.Show();//added by Thamilselvan R...for Changing same as Billing...
                        }
						else if (Showconsentform == "Y" && dList.SelectedValue == "Print_Consent_Form")
                        {
                            
                            string CT = string.Empty, MRI = string.Empty;
                            returnCode = new Patient_BL(base.ContextInfo).CheckPatientConsentformAvailability(Convert.ToInt64(hdnVID.Value), out CT, out MRI);
                            hdnisCT.Value = CT;
                            hdnisMRI.Value = MRI;
                            if (CT == "Y" || MRI == "Y")
                            {
                                ConsentformctkFrame.Attributes["src"] = "..\\Investigation\\ConsentFormPrint.aspx?vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&actionType=POPUP&formtype=ConsentFormMainReport&DeptName=CT&type=printreport&invstatus=approve&toolbar=1";
                                modalpopupCTK.Show();
                            }
                            /*if (CT == "Y" && MRI == "Y")
                            {
                                ConsentformctkFrame.Attributes["src"] = "..\\Investigation\\ConsentFormPrint.aspx?vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&actionType=POPUP&formtype=ConsentFromCTKannada&DeptName=CT&type=printreport&invstatus=approve&toolbar=1";
                                modalpopupCTK.Show();
                                ConsentformcteFrame.Attributes["src"] = "..\\Investigation\\ConsentFormPrint.aspx?vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&actionType=POPUP&formtype=ConsentFromCTEnglish&DeptName=CT&type=printreport&invstatus=approve&toolbar=1";
                                // modalpopupCTE.Show();
                                ConsentformMRIKFrame.Attributes["src"] = "..\\Investigation\\ConsentFormPrint.aspx?vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&actionType=POPUP&formtype=ConsentFromMRIKannada&DeptName=MRI&type=printreport&invstatus=approve&toolbar=1";
                                // modalpopupMRIK.Show();
                                ConsentformMRIEFrame.Attributes["src"] = "..\\Investigation\\ConsentFormPrint.aspx?vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&actionType=POPUP&formtype=ConsentFromMRIEnglish&DeptName=MRI&type=printreport&invstatus=approve&toolbar=1";
                                // modalpopupMRIE.Show(); 
                            }
                            else if (CT == "Y" && MRI == "N")
                            {
                                ConsentformctkFrame.Attributes["src"] = "..\\Investigation\\ConsentFormPrint.aspx?vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&actionType=POPUP&formtype=ConsentFromCTKannada&DeptName=CT&type=printreport&invstatus=approve&toolbar=1";
                                modalpopupCTK.Show();
                                ConsentformcteFrame.Attributes["src"] = "..\\Investigation\\ConsentFormPrint.aspx?vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&actionType=POPUP&formtype=ConsentFromCTEnglish&DeptName=CT&type=printreport&invstatus=approve&toolbar=1";
                                //modalpopupCTE.Show();
                            }
                            else if (MRI == "Y" && CT == "N")
                            {
                                ConsentformMRIKFrame.Attributes["src"] = "..\\Investigation\\ConsentFormPrint.aspx?vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&actionType=POPUP&formtype=ConsentFromMRIKannada&DeptName=MRI&type=printreport&invstatus=approve&toolbar=1";
                                modalpopupMRIK.Show();
                                ConsentformMRIEFrame.Attributes["src"] = "..\\Investigation\\ConsentFormPrint.aspx?vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&actionType=POPUP&formtype=ConsentFromMRIEnglish&DeptName=MRI&type=printreport&invstatus=approve&toolbar=1";
                               // modalpopupMRIE.Show();
                            }*/
                            else
                            {
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:consentalert();", true);
                            }

                        }
                        else //if (dList.SelectedValue == "Print_Bill_ViewPrintPage" && strSsrsShowReport != "Y")
                        {
                            Response.Redirect(RedirectURL + "&MembershipCardno=" + hdnMembershipCardno.Value, true);
                        }
                        //else
                        //{
                        //    string sPath = "Billing\\\\HospitalBillSearch.aspx.cs_10";
                        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:return ShowAlertMsg('" + sPath + "');", true);
                        //}
                    }
                    else
                    {
                        string sPath = "Billing\\\\HospitalBillSearch.aspx.cs_10";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:return ShowAlertMsg('" + sPath + "');", true);

                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
                    }
                    #endregion

                    #region Hardcode
                    //if (hdnVisitDetail.Value == "View Bill")
                    //    pagename = "?vid=" + hdnVID.Value + "&pagetype=BP&bid=" + FinalBillID + "&billNo=" + BillNo + "";
                    //else if (hdnVisitDetail.Value == "Add Bill Items")
                    //    pagename = "?vid=" + hdnVID.Value + " &pid=" + hdnPID.Value + "&pagetype=ABI&bid=" + FinalBillID + "";
                    //else if (hdnVisitDetail.Value == "Refund")
                    //    pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&pname=" + hdnPNAME.Value + "&PNumber=" + hdnPNumber.Value + "&bid=" + FinalBillID + "&btype=RFD" + "&billno=" + hdnBillNumber.Value;
                    //else if (hdnVisitDetail.Value == "Cancel Bill")
                    //    pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&pname=" + hdnPNAME.Value + "&bid=" + FinalBillID + "&btype=CAN";
                    //else if (hdnVisitDetail.Value == "Add Service Code")
                    //    pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&pname=" + hdnPNAME.Value + "&bid=" + FinalBillID + "&btype=ASC";

                    //else if (hdnVisitDetail.Value == "Pharmacy Consolidated Bill")
                    //    pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&pname=" + hdnPNAME.Value + "&bid=" + FinalBillID + "&btype=ASC";
                    ////==================================
                    //else if (hdnVisitDetail.Value == "View Pharma Consolidated Bill")
                    //    pagename = "?VID=" + hdnVID.Value + "&PID=" + hdnPID.Value + "&pname=" + hdnPNAME.Value + "&bid=" + FinalBillID + "&btype=ASC";

                    //else if (dList.SelectedItem.ToString() == "EditIPBillSettlement")

                    //    pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&pname=" + hdnPNAME.Value + "&bid=" + FinalBillID + "&vType=" + temp[0] + "&EIPBill=" + "Edit" + "&IsCredit=" + temp[1];

                    ////===================================

                    //Response.Redirect(Request.ApplicationPath  + dList.SelectedItem.Value + pagename, true);
                    #endregion
                }
                else
                {
                    int iBillGroupID = 0;
                    iBillGroupID = (int)ReportType.OPBill;
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Dynamic Print", OrgID, ILocationID, out lstConfig);

                    if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "print", "javascript:PrintDynamic();", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "print", "javascript:PrintReport();", true);
                    }

                }

            }
            else
            {
                string sPath = "Billing\\\\HospitalBillSearch.aspx.cs_11";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:ShowAlertMsg('" + sPath + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action cannot be performed for inpatients');", true);
            }
        }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
 //Added by Thamilselvan R to disable the IFrame source....
    protected void btn_DisableIframSRC(object sender, EventArgs e)
    {
        CouponCardBillFrame.Attributes["src"] = "";
		hdnIsFullBill.Value = "";//Added by Thamilselvan for Full Bill
    }
 	protected void btn_OpenFullBill_Click(object sender, EventArgs e)
    {
        //CouponCardBillFrame.Attributes["src"] = "..\\Investigation\\BillPrint.aspx?vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&actionType=POPUP&isFullBill=Y&type=printreport&invstatus=approve" + "&#toolbar=0&navpanes=0";//added by Thamilselvan R...for Changing same as Billing...
        CouponCardBillFrame.Attributes["src"] = "..\\Reception/MultiPdfView.ashx?OrgID=" + OrgID + "&LocationID=" + ILocationID + "&PrintBill=Y&vid=" + hdnVID.Value + "&finalBillID=" + hdnBID.Value + "&actionType=POPUP&type=printreport&invstatus=approve" + "&#toolbar=0&navpanes=0";//added by Thamilselvan R...for Changing same as Billing...
        hdnTargetCtlMailReport.Value = "test";//added by Thamilselvan R...for Changing same as Billing...
        modalpopupsendemail.Show();//added by Thamilselvan R...for Changing same as Billing...
        hdnIsFullBill.Value = "Y";
    }

    #endregion

    #region "Method"

    protected void BindDropDownValues()
    {
        //List<BillSearchActions> lstVisitSearchAction = new List<BillSearchActions>();
        //retval = new BillingEngine(base.ContextInfo).GetBillSearchActions(RoleID, out lstVisitSearchAction);
        //if (lstVisitSearchAction.Count > 0)
        //{
        //    dList.DataSource = lstVisitSearchAction;
        //    dList.DataTextField = "ActionName";
        //    dList.DataValueField = "PageURL";
        //    dList.DataBind();
        //}

        try
        {
            long returnCode = -1;
            List<ActionMaster> lstActionMaster = new List<ActionMaster>();

            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, (int)TaskHelper.SearchType.BillSearch, out lstActionMaster); //returnCode = patBL.GetSearchActionsByPage(RoleID, type, out pages);
            dList.Items.Clear();
            if (lstActionMaster.Count > 0)
            {
                #region Add View State ActionList
                string temp = string.Empty;
                foreach (ActionMaster objActionMaster in lstActionMaster)
                {
                    temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                }
                ViewState.Add("ActionList", temp);
                #endregion

                #region Load Action Menu to Drop Down List
                //lstActionsMaster = lstActionMaster.ToList();
                dList.DataSource = lstActionMaster;
                dList.DataTextField = "ActionName";
                dList.DataValueField = "ActionCode";
                dList.DataBind();
                #endregion
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - loadActionList", ex);

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

    string strBillSearch = Resources.Billing_AppMsg.Billing_HospitalBillSearch_aspx_01 == null ? "Please Select a Bill" : Resources.Billing_AppMsg.Billing_HospitalBillSearch_aspx_01;
    private bool validatePage(long bid)
    {
        bool retval = true;
        string error = "";
        if (bid <= 0)
        {
            retval = false;
            error = strBillSearch;
        }
        //ErrorDisplay1.ShowError = true;
        //ErrorDisplay1.Status = error;
        return retval;
    }

    #endregion
}
