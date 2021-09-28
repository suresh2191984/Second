using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
public partial class Reports_PrintInsuranceCorporateReport : BasePage
{
    long patientID = 0;
    string PaymentStatus = string.Empty;
    string TPAName = string.Empty;
    long tpaID = 0;

    DateTime fromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    DateTime ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    string PatienName = string.Empty;
    int ClientID = 0;

    decimal PreAuthAmountPT = 0, BillAmountPT = 0,
           RecievedAmountPT = 0, RefundPT = 0,
           ClaimFromTPAPT = 0, PaidByTPAPT = 0,
           TDSPT = 0, WriteOffPT = 0;

    decimal PreAuthAmountGT = 0, BillAmountGT = 0,
           RecievedAmountGT = 0, RefundGT = 0,
           ClaimFromTPAGT = 0, PaidByTPAGT = 0,
           TDSGT = 0, WriteOffGT = 0;
    List<TPADetails> lstTPADetails;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //pid=" + patientID.ToString() + "&pname=" + PatienName + "&ps=" + PaymentStatus 
            //+ "&tpaname=" + TPAName + "&tpaid=" + tpaID.ToString() + "&fdate=" + fromDate 
            //+ "&tdate=" + ToDate + "&client=" + ClientID.ToString();

            DateTime.TryParse(Request.QueryString["fdate"], out fromDate);
            DateTime.TryParse(Request.QueryString["tdate"], out ToDate);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int32.TryParse(Request.QueryString["client"], out ClientID);
            PaymentStatus = Request.QueryString["ps"];
            TPAName = Request.QueryString["tpaname"];
            PatienName = Request.QueryString["pname"];

            lstTPADetails = new List<TPADetails>();

            new IP_BL(base.ContextInfo).GetTPACorporateReport(patientID, PatienName, PaymentStatus, TPAName, tpaID, fromDate, ToDate, OrgID, ClientID, out lstTPADetails);

            if (lstTPADetails.Count > 0)
            {
                grdResult.DataSource = lstTPADetails;
                grdResult.DataBind();
                decimal AmountRefund = 0;
                decimal DiscountAmount = 0;
                lblTPC.Visible = true;

                lblTPC.Text = "Patient Count : " + lstTPADetails.Count.ToString();

                PreAuthAmountGT = lstTPADetails.FindAll(p => p.PreAuthAmount != 0).Sum(p => p.PreAuthAmount);
                BillAmountGT = lstTPADetails.FindAll(p => p.GrossAmount != 0).Sum(p => p.GrossAmount);
                RecievedAmountGT = lstTPADetails.FindAll(p => p.RecievedAmount != 0).Sum(p => p.RecievedAmount);
                AmountRefund = lstTPADetails.FindAll(p => p.AmountRefund != 0).Sum(p => p.AmountRefund);
                DiscountAmount = lstTPADetails.FindAll(p => p.DiscountAmount != 0).Sum(p => p.DiscountAmount);
                RefundGT = AmountRefund + DiscountAmount;
                ClaimFromTPAGT = lstTPADetails.FindAll(p => p.TPABillAmount != 0).Sum(p => p.TPABillAmount);
                PaidByTPAGT = lstTPADetails.FindAll(p => p.PaidByTPA != 0).Sum(p => p.PaidByTPA);
                TDSGT = lstTPADetails.FindAll(p => p.TDSAmount != 0).Sum(p => p.TDSAmount);
                WriteOffGT = lstTPADetails.FindAll(p => p.WriteOff != 0).Sum(p => p.WriteOff);

                grdResult.FooterRow.Cells[7].Text = "Page Total </br> Grand Total";
                grdResult.FooterRow.Cells[8].Text = PreAuthAmountPT.ToString() + "</br>" + PreAuthAmountGT.ToString();
                grdResult.FooterRow.Cells[9].Text = BillAmountPT.ToString() + "</br>" + BillAmountGT.ToString();
                grdResult.FooterRow.Cells[10].Text = RecievedAmountPT.ToString() + "</br>" + RecievedAmountGT.ToString();
                grdResult.FooterRow.Cells[11].Text = RefundPT.ToString() + "</br>" + RefundGT.ToString();
                grdResult.FooterRow.Cells[12].Text = ClaimFromTPAPT.ToString() + "</br>" + ClaimFromTPAGT.ToString();
                grdResult.FooterRow.Cells[13].Text = PaidByTPAPT.ToString() + "</br>" + PaidByTPAGT.ToString();
                grdResult.FooterRow.Cells[14].Text = TDSPT.ToString() + "</br>" + TDSGT.ToString();
                grdResult.FooterRow.Cells[15].Text = WriteOffPT.ToString() + "</br>" + WriteOffPT.ToString();
                grdResult.FooterRow.BackColor = System.Drawing.Color.Gray;
                grdResult.FooterRow.HorizontalAlign = HorizontalAlign.Right;
            }


        }

    }


    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TPADetails tpa = (TPADetails)e.Row.DataItem;

                Label lblRefund = (Label)e.Row.FindControl("lblRefund");

                lblRefund.Text = (tpa.AmountRefund + tpa.DiscountAmount).ToString();

                Label lblDischaredDT = (Label)e.Row.FindControl("lblDischaredDT");
                Label lblAdmissionDate = (Label)e.Row.FindControl("lblAdmissionDate");
                Label lblCliamForwardDate = (Label)e.Row.FindControl("lblCliamForwardDate");
                Label lblTPASettlementDate = (Label)e.Row.FindControl("lblTPASettlementDate");


                if (tpa.DischargedDT != DateTime.MinValue)
                {
                    lblDischaredDT.Text = tpa.DischargedDT.ToShortDateString();
                }

                if (tpa.AdmissionDate != DateTime.MinValue)
                {
                    lblAdmissionDate.Text = tpa.AdmissionDate.ToShortDateString();
                }

                if (tpa.CliamForwardDate != DateTime.MinValue)
                {
                    lblCliamForwardDate.Text = tpa.CliamForwardDate.ToShortDateString();
                }

                if (tpa.SettlementDate != DateTime.MinValue)
                {
                    lblTPASettlementDate.Text = tpa.SettlementDate.ToShortDateString();
                }


                //PreAuthAmountPT = 0; 
                //BillAmountPT = 0;
                //RecievedAmountPT = 0;
                //RefundPT = 0;
                //ClaimFromTPAPT = 0; 
                //PaidByTPAPT = 0;
                //TDSPT = 0; 
                //WriteOffPT = 0;


                PreAuthAmountPT += tpa.PreAuthAmount;
                BillAmountPT += tpa.GrossAmount;
                RecievedAmountPT += tpa.RecievedAmount;
                RefundPT += tpa.AmountRefund + tpa.DiscountAmount;
                ClaimFromTPAPT += tpa.TPABillAmount;
                PaidByTPAPT += tpa.PaidByTPA;
                TDSPT += tpa.TDSAmount;
                WriteOffPT += tpa.WriteOff;



            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound Insurance", ex);
        }
    }
}
