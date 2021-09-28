using System;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;

public partial class InPatient_SurgeryAdvance:BasePage
{

    public InPatient_SurgeryAdvance()
        : base(" InPatient\\SurgeryAdvance.aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long pVisitID = 0;
    long pPatientID = 0;
    long returncode = -1;
    long taskID = -1;
    string sMessage = "";
    AdvancePaid_BL oAdvancePaid_BL;
    IP_BL oIP_BL;
    string strConfigKey = "IsSurgeryAdvance";
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
   
    
    protected void Page_Load(object sender, EventArgs e)
    {
        oAdvancePaid_BL = new AdvancePaid_BL(base.ContextInfo);
        oIP_BL = new IP_BL(base.ContextInfo);
        long pVisitID = 0;
        if (Request.QueryString["VID"] != null)
        {
            pVisitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        if (Request.QueryString["PID"] != null)
        {
            pPatientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }

        long retid = new PatientVisit_BL(base.ContextInfo).GetInPatientVisitDetails(pPatientID, out lstPatientVisit);
      
        
       
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
        List<VisitClientMapping> lstVisitCLientMapping = new List<VisitClientMapping>();
        if (!IsPostBack)
        {
            if (pVisitID != 0)
            {
                if (Request.QueryString["msg"] != null)
                {
                    sMessage = Request.QueryString["msg"].ToString().ToLower().Trim();

                    if (sMessage == "yes")
                    {

                        trErMsg.Style.Add("display", "block");
                        trFinalSettleMent.Style.Add("display", "none");
                        ModalPopupExtender1.Show();

                    }
                }

       

                //if (Request.QueryString["PID"] != null)
                //{
                //    lblPatientID.Text = Request.QueryString["PID"].ToString() == "" ? "0" : Request.QueryString["PID"].ToString();
                //}
                
                if (lstPatientVisit.Count>0)
                {
                    lblPatientName.Text = lstPatientVisit[0].Name.ToString(); ;
                }
               
                decimal pPreAuthAmount = 0;
                decimal GrossBillAmount = 0;
                decimal DueAmount = 0;
                decimal PaidAmount = 0;
                string IsCreditBill = string.Empty;

                BillingEngine be = new BillingEngine(base.ContextInfo);
                decimal Copercent = -1;
                be.CheckIsCreditBill(pVisitID, out pPreAuthAmount, out PaidAmount, out GrossBillAmount,out IsCreditBill,out lstVisitCLientMapping);
                if (pPreAuthAmount > 0 && IsCreditBill=="Y")
                {
                    Preauth.Style.Add("display", "block");
                    lblPreAuthAmount.Text = pPreAuthAmount.ToString();
                }
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveSurgeryAdvance();
       SurgeryBilling1.ClearControls();
    }
    public void SaveSurgeryAdvance()
    {
        long returnCode = -1;
        long patientID = -1;
        long patientVisitID = -1;
        AdvancePaid_BL oAdvancePaid_BL = new AdvancePaid_BL(base.ContextInfo);
        try
        {
           Int64.TryParse(Request.QueryString["VID"],out patientVisitID);
           Int64.TryParse(Request.QueryString["PID"], out patientID);

            decimal dServiceCharge = 0;
            decimal.TryParse(hdnSurService.Value, out dServiceCharge);

            long pSurgeryBillingID = 0;


            System.Data.DataTable dtAdvancePaidDetails = new System.Data.DataTable();
            dtAdvancePaidDetails = SurgeryBilling1.GetAmountReceivedDetails();
            string sreceiptNo = "";
            long IpIntermediateID = 0;
            string sType = "";
            if (dtAdvancePaidDetails.Rows.Count > 0)
            {
                returnCode = oAdvancePaid_BL.saveSurgeryAdvanceDetail(patientVisitID, patientID,
                    LID, pSurgeryBillingID, dtAdvancePaidDetails, dServiceCharge, out sreceiptNo, out IpIntermediateID,
                    out sType);
                SurgeryBilling1.ClearControls();
                string strName = "";
                


                string sPage = "../InPatient/PrintReceiptPage.aspx?Amount="
                        + hdnSurPayment.Value + "&dDate="
                        + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt")
                        + "&rcptno=" + sreceiptNo.ToString()
                        + "&PID=" + patientID.ToString()
                        + "&VID=" + patientVisitID.ToString()
                        + "&pdid=" + IpIntermediateID.ToString() + "&pDet=" + sType + "&PNAME=" + lblPatientName.Text
                        + "&IsPopup=Y";

                dtAdvancePaidDetails = new System.Data.DataTable();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:GetSurgeryDetailForAdvance('" + patientVisitID + "');openPOPupQuick('" + sPage + "');", true);
            }

            if (Request.QueryString["msg"] != null)
            {
                sMessage = Request.QueryString["msg"].ToString().ToLower().Trim();



                if (sMessage == "yes")
                {

                    decimal pTotSurgeryAdv = 0;
                    decimal pTotSurgeryAmt = 0;


                    new IP_BL(base.ContextInfo).GetSurgeryPayments(patientVisitID, patientID, OrgID,
                                                           out pTotSurgeryAdv,
                                                           out pTotSurgeryAmt
                                                        );


                    string configValue = GetConfigValue(strConfigKey, OrgID);

                    if (configValue == "Y" && (pTotSurgeryAmt - pTotSurgeryAdv) > 0)
                    {
                        trErMsg.Style.Add("display", "block");
                        trFinalSettleMent.Style.Add("display", "none");
                        ModalPopupExtender1.Show();
                      
                    }

                    else
                    {
                        ModalPopupExtender1.Show();
                        trErMsg.Style.Add("display", "none");
                        trFinalSettleMent.Style.Add("display", "block");

                       
                    }
                }
            }
        

  
        }


        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath  + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
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

    protected void btnOk_Click(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();
        trErMsg.Style.Add("display", "block");
        trFinalSettleMent.Style.Add("display", "none");      

    }


    protected void btnFinalSettlement_Click(object sender, EventArgs e)
    {

        string sPatientName = string.Empty;

        if (lstPatientVisit.Count > 0)
        {
            sPatientName = lstPatientVisit[0].Name.ToString();
        }
        pVisitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());

        Response.Redirect("../InPatient/IPBillSettlement.aspx?PID=" + pPatientID.ToString() + "&VID=" + pVisitID + "&PNAME=" + sPatientName + "&vType=" + "IP", true);

    }
}
