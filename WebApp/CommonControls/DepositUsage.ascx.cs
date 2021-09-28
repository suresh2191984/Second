using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Linq;


public partial class UserControl_DepositUsage : BaseControl
{
    long pPatientID = 0;
    long pDepositID = 0;
    long returnCode = -1;
    decimal totalDepositAmount = 0;
    decimal totalDepositUsed = 0;
    decimal totalDepositBalance = 0;
    string baseControlID = string.Empty;
    string targetControlID = string.Empty;
    string displayControlID = string.Empty;
    public string OtherCurrencyControlID { get; set; }
    public string BaseControlID
    {
        get
        {
            return baseControlID;
        }
        set
        {
            baseControlID = value;
            hdnBaseControlName.Value = baseControlID;
        }
    }
    public string TargetControlID
    {
        get
        {
            return targetControlID;
        }
        set
        {
            targetControlID = value;
            hdnTargetControlName.Value = targetControlID;
        }
    }
    public string DisplayControlID
    {
        get
        {
            return displayControlID;
        }
        set
        {
            displayControlID = value;
            hdnDisplayControlName.Value = displayControlID;
        }
    }

    public decimal TotalAmountDeposited
    {
        get
        {
            return totalDepositAmount;
        }
        set
        {
            totalDepositAmount = value;
            hdnAmountDeposited.Value = totalDepositAmount.ToString("0.00");
            lblAmountDeposited.Text = totalDepositAmount.ToString("0.00");
            hdnDepositBalance.Value = (Convert.ToDecimal(hdnAmountDeposited.Value) - Convert.ToDecimal(hdnDepositUsed.Value)).ToString("0.00");
            lblDepositBalance.Text = (Convert.ToDecimal(hdnAmountDeposited.Value) - Convert.ToDecimal(hdnDepositUsed.Value)).ToString("0.00");
        }
    }

    public decimal TotalDepositUsed
    {
        get
        {
            return totalDepositUsed;
        }
        set
        {
            totalDepositUsed = value;
            hdnDepositUsed.Value = totalDepositUsed.ToString();
            lblDepositUsed.Text = totalDepositUsed.ToString();
            hdnDepositBalance.Value = (Convert.ToDecimal(hdnAmountDeposited.Value) - Convert.ToDecimal(hdnDepositUsed.Value)).ToString("0.00");
            lblDepositBalance.Text = (Convert.ToDecimal(hdnAmountDeposited.Value) - Convert.ToDecimal(hdnDepositUsed.Value)).ToString("0.00");
        }
    }
    public long PatientID
    {
        get
        {
            return pPatientID;
        }
        set
        {
            pPatientID = value;
            hdnPatientID.Value = pPatientID.ToString();
        }
    }
    public long DepositID
    {
        get
        {
            return pDepositID;
        }
        set
        {
            pDepositID = value;
            hdnDepositID.Value = pDepositID.ToString();
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["PID"] != null)
        {
            pPatientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
            hdnPatientID.Value = pPatientID.ToString();
        }
        AdvancePaid_BL objapdBL = new AdvancePaid_BL(base.ContextInfo);
        List<PatientDepositHistory> lstPDH = new List<PatientDepositHistory>();
        decimal TotalDepositAmount = 0;
        decimal TotalDepositUsed = 0;
        decimal TotalRefundAmount = 0;
        objapdBL.GetPatientDepositDetails(pPatientID, OrgID, out lstPDH, out TotalDepositAmount, out TotalDepositUsed, out TotalRefundAmount);

        if (lstPDH.Count > 0)
        {
            hdnDepositID.Value = lstPDH[0].DepositID.ToString();
        }

        lblAmountDeposited.Text = (Convert.ToDecimal(TotalDepositAmount)).ToString("0.00");
        lblDepositUsed.Text = (Convert.ToDecimal(TotalDepositUsed)).ToString("0.00");
        lblDepositBalance.Text = (Convert.ToDecimal(TotalDepositAmount - TotalDepositUsed)).ToString("0.00");

        if (TotalRefundAmount > 0)
        {
            lblRefundAmt.Text = (Convert.ToDecimal(TotalRefundAmount)).ToString("0.00");
            trRefund.Attributes.Add("display", "block");
        }

        hdnAmountDeposited.Value = (Convert.ToDecimal(TotalDepositAmount)).ToString("0.00");
        hdnDepositUsed.Value = (Convert.ToDecimal(TotalDepositUsed)).ToString("0.00");
        hdnDepositBalance.Value = (Convert.ToDecimal(TotalDepositAmount - TotalDepositUsed)).ToString("0.00");

        if (Convert.ToDecimal(TotalDepositAmount - TotalDepositUsed) > 0)
        {
           // chkUseDeposit.Visible = true;
            tdDeposit.Style.Add("display", "block");
        }
        else{
            //chkUseDeposit.Visible = false;
            tdDeposit.Style.Add("display", "none");
        }
       
    }

    public List<PatientDepositUsage> GetDepositUsage()
    {
        List<PatientDepositUsage> lstDepositUsage = new List<PatientDepositUsage>();
        PatientDepositUsage objPDU = new PatientDepositUsage();
       
        long DepositID = -1, PatientID = -1;
        decimal amountUsed=-1;
        Int64.TryParse(hdnDepositID.Value, out DepositID);
        Int64.TryParse(hdnPatientID.Value, out PatientID); 
        Decimal.TryParse(hdnDepositCurrentUsage.Value, out amountUsed);
        if (DepositID != -1 && amountUsed>0)
        {
          
            //objPDU.DepositID = Int64.Parse(hdnDepositID.Value);
            //objPDU.PatientID = Int64.Parse(hdnPatientID.Value);
            //objPDU.AmountUsed = Convert.ToDecimal(hdnDepositCurrentUsage.Value);
            objPDU.DepositID = DepositID;
            objPDU.PatientID = PatientID;
            objPDU.OrgID = OrgID;
            objPDU.AmountUsed = amountUsed;
            objPDU.CreatedBy = LID;
            lstDepositUsage.Add(objPDU);
        }
        return lstDepositUsage;

    }
    
}
