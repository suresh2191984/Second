using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections;
using System.Text;
using Attune.Podium.BillingEngine;

public partial class CommonControls_PatientCreditLimt : BaseControl
{




    BillingEngine be;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string NeedCreditLimt = string.Empty;
            NeedCreditLimt = GetConfigValue("CreditLimitForIP", OrgID);
            if (NeedCreditLimt != "" && NeedCreditLimt == "Y")
            {
                hdnOrgCreditLimt.Value = "Y";
            }
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

    public void LoadCreditDetails(long PatientID, long VisitID, int OrgID)
    {
        long returnCode = -1;
        List<FinalBill> lstFinalBill = new List<FinalBill>();
        List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>(); 
        be = new BillingEngine(base.ContextInfo);
        returnCode = be.GetBillSnapShot(PatientID, VisitID, OrgID,out lstFinalBill);
        if (lstFinalBill.Count > 0)
        {
            hdnTotalBilled.Value = lstFinalBill[0].GrossBillValue.ToString("0.00");
            hdnTotalReceived.Value = lstFinalBill[0].AmountReceived.ToString("0.00");
            hdnDifferencebillRece.Value = lstFinalBill[0].ToPay.ToString("0.00");
            hdnCreditLimt.Value = lstFinalBill[0].CreditLimt.ToString("0.00");
            hdnBalCreditLimit.Value = lstFinalBill[0].BalanceCreditLimit.ToString("0.00");
            hdnIsCreditBill.Value = lstFinalBill[0].IsCreditBill;
            hdnPreAuthAmount.Value = lstVisitClientMapping[0].PreAuthAmount.ToString("0.00");
            hdnNonMedicalAmount.Value = lstVisitClientMapping[0].NonMedicalAmount.ToString("0.00");
            hdnCashInHand.Value = (lstFinalBill[0].AmountReceived - lstFinalBill[0].GrossBillValue) > 0 ? (lstFinalBill[0].AmountReceived - lstFinalBill[0].AmountReceived).ToString("0.00") : 0.ToString("0.00");
            hdnIsPatientPortTrust.Value = lstFinalBill[0].Comments;
            hdnClaimAmount.Value = lstFinalBill[0].TPAAmount.ToString("0.00");

            lblTotalBilledText.Text = lstFinalBill[0].GrossBillValue.ToString("0.00");
            lblTotalReceivedText.Text = lstFinalBill[0].AmountReceived.ToString("0.00");
            lblDifferenceText.Text = lstFinalBill[0].ToPay.ToString("0.00");
            lblCreditLimitText.Text = lstFinalBill[0].CreditLimt > 0 ? lstFinalBill[0].CreditLimt.ToString("0.00") : 0.ToString("0.00");
            lblBalCreditLimitText.Text = lstFinalBill[0].BalanceCreditLimit.ToString("0.00");
            lblPreAuttxt.Text = lstVisitClientMapping[0].PreAuthAmount.ToString("0.00");
            lblCashInHandtxt.Text = (lstFinalBill[0].AmountReceived - lstFinalBill[0].GrossBillValue) > 0 ? (lstFinalBill[0].AmountReceived - lstFinalBill[0].AmountReceived).ToString("0.00") : 0.ToString("0.00");

            if (hdnIsPatientPortTrust.Value == "Y")
            {
                tblCreditLimit.Style.Add("display", "none");
            }
            if (hdnIsCreditBill.Value == "Y" && hdnIsPatientPortTrust.Value != "Y")
            {

                if (lstFinalBill[0].CreditLimt > 0)
                {
                    tdCreditLimit.Style.Add("display", "block");
                    lblNowBilledtxt.Text = ((lstVisitClientMapping[0].PreAuthAmount + lstFinalBill[0].CreditLimt + lstFinalBill[0].AmountReceived) - lstFinalBill[0].GrossBillValue) > 0 ? ((lstVisitClientMapping[0].PreAuthAmount + lstFinalBill[0].CreditLimt + lstFinalBill[0].AmountReceived) - lstFinalBill[0].GrossBillValue).ToString("0.00") : 0.ToString("0.00");
                }
                else
                {
                    tdCreditLimit.Style.Add("display", "none");
                    lblNowBilledtxt.Text = ((lstVisitClientMapping[0].PreAuthAmount + lstFinalBill[0].AmountReceived) - lstFinalBill[0].GrossBillValue) > 0 ? ((lstVisitClientMapping[0].PreAuthAmount + lstFinalBill[0].AmountReceived) - lstFinalBill[0].GrossBillValue).ToString("0.00") : 0.ToString("0.00");
                }

                tblCreditLimit.Style.Add("display", "block");
                trPreAuth.Style.Add("display", "block");
                trClaimAmount.Style.Add("display", "none");
                tdDifference.Style.Add("display", "none");
            }
            if (hdnIsCreditBill.Value == "N")
            {
                if (lstFinalBill[0].CreditLimt > 0)
                {
                    tdCreditLimit.Style.Add("display", "block");
                    lblNowBilledtxt.Text = ((lstFinalBill[0].CreditLimt + lstFinalBill[0].AmountReceived) - lstFinalBill[0].GrossBillValue) > 0 ? ((lstFinalBill[0].CreditLimt + lstFinalBill[0].AmountReceived) - lstFinalBill[0].GrossBillValue).ToString("0.00") : 0.ToString("0.00");
                }
                else
                {
                    tdCreditLimit.Style.Add("display", "none");
                    lblNowBilledtxt.Text = (lstFinalBill[0].AmountReceived - lstFinalBill[0].GrossBillValue).ToString("0.00");
                }
                tblCreditLimit.Style.Add("display", "block");
                trPreAuth.Style.Add("display", "none");
                trClaimAmount.Style.Add("display", "none");
                tdDifference.Style.Add("display", "none");
            }
            

            
        }
    }
    public void GetCreditLimitValue(out decimal TotalCashandCreditLimitInHand, out string isPortTrust)
    {

        decimal TotalReceived = 0, TotalPreBilled = 0, CreditLimit = 0, PreAuthAmount = 0;
        TotalCashandCreditLimitInHand = 0;
        isPortTrust = "N";
        CreditLimit = Convert.ToDecimal(hdnCreditLimt.Value);
        PreAuthAmount = Convert.ToDecimal(hdnPreAuthAmount.Value);
        TotalReceived = Convert.ToDecimal(hdnTotalReceived.Value);
        TotalPreBilled = Convert.ToDecimal(hdnTotalBilled.Value);
        if (hdnIsCreditBill.Value == "Y" && hdnIsPatientPortTrust.Value == "Y")
        {
            TotalCashandCreditLimitInHand = 0;
            isPortTrust = "Y";
        }
        else if (hdnIsCreditBill.Value == "Y")
        {
           if (CreditLimit > 0)
            {
                if ((CreditLimit + PreAuthAmount + TotalReceived) > TotalPreBilled)
                    TotalCashandCreditLimitInHand = (CreditLimit + PreAuthAmount + TotalReceived) - TotalPreBilled;
                else
                    TotalCashandCreditLimitInHand = 0;
            }
            else
            {
                if ((PreAuthAmount + TotalReceived) > TotalPreBilled)
                    TotalCashandCreditLimitInHand = (PreAuthAmount + TotalReceived) - TotalPreBilled;
                else
                    TotalCashandCreditLimitInHand = 0;
            }

        }
        else
        {
            if (CreditLimit > 0)
            {
                if ((CreditLimit + TotalReceived) > TotalPreBilled)
                    TotalCashandCreditLimitInHand = (CreditLimit + TotalReceived) - TotalPreBilled;
                else
                    TotalCashandCreditLimitInHand = 0;
            }
            else
            {
                if (TotalReceived > TotalPreBilled)
                    TotalCashandCreditLimitInHand = TotalReceived - TotalPreBilled;
                else
                    TotalCashandCreditLimitInHand = 0;
            }
        }
        
        
        
    }

   
     
}
