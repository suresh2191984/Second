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
using Attune.Podium.ExcelExportManager;

public partial class Reports_InsuranceCorpReport : BasePage
{
    long returnCode = -1;
    List<TPADetails> lstTPADetails;
    decimal PreAuthAmountPT = 0, BillAmountPT = 0,
            RecievedAmountPT = 0, RefundPT = 0,
            ClaimFromTPAPT = 0, PaidByTPAPT = 0,
            TDSPT = 0, WriteOffPT = 0;

    decimal PreAuthAmountGT = 0, BillAmountGT = 0,
           RecievedAmountGT = 0, RefundGT = 0,
           ClaimFromTPAGT = 0, PaidByTPAGT = 0,
           TDSGT = 0, WriteOffGT = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
            txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
            if (!IsPostBack)
            {
                txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
                txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
                BindTPA();
                BindClient();
                BindTPACorporateReport();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in InsuranceCorpReport Page_Load", ex);
        }
    }

    private void BindClient()
    {
        try
        {
            List<InvClientMaster> Clientmaster = new List<InvClientMaster>();
            new Investigation_BL(base.ContextInfo).getOrgClientName(OrgID, out Clientmaster);
            if (Clientmaster.Count > 0)
            {
                ddlCorporate.DataSource = Clientmaster;
                ddlCorporate.DataTextField = "ClientName";
                ddlCorporate.DataValueField = "ClientID";
                ddlCorporate.DataBind();
                ddlCorporate.Items.Insert(0, "All");
                ddlCorporate.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Binding BindClient() Method", ex);
        }
    }

    private void BindTPA()
    {
        try
        {
            List<TPAMaster> lTpaMaster = new List<TPAMaster>();
            new IP_BL(base.ContextInfo).GetTPAName(OrgID, out lTpaMaster);
            ddlTpaName.DataSource = lTpaMaster;

            ddlTpaName.DataTextField = "TPAName";
            ddlTpaName.DataValueField = "TPAID";
            ddlTpaName.DataBind();
            ddlTpaName.Items.Insert(0, new ListItem("All", "-1"));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Binding BindTPA() Method", ex);
        }
    }

    private void BindTPACorporateReport()
    {
        try
        {
             lstTPADetails = new List<TPADetails>();

             long patientID = txtPatientNo.Text == string.Empty ? 0 : Convert.ToInt64(txtPatientNo.Text);
             string PaymentStatus = ddlPaymentype.SelectedItem.Text;
             string TPAName = ddlType.SelectedItem.Text;
             long tpaID = Convert.ToInt64(ddlTpaName.SelectedItem.Value);

             DateTime fromDate = Convert.ToDateTime(txtFDate.Text);
             DateTime ToDate = Convert.ToDateTime(txtTDate.Text);
             string PatienName = txtPatientName.Text;
             int ClientID = Convert.ToInt32(ddlCorporate.SelectedItem.Value);

             new IP_BL(base.ContextInfo).GetTPACorporateReport(patientID, PatienName, PaymentStatus, TPAName, tpaID, fromDate, ToDate, OrgID, ClientID, out lstTPADetails);

             if (lstTPADetails.Count > 0)
             {
                 grdResult.DataSource = lstTPADetails;
                 grdResult.DataBind();
                 lblTPC.Visible = true;

                 lblTPC.Text ="Patient Count : "+ lstTPADetails.Count.ToString();

                 decimal AmountRefund=0;
                 decimal DiscountAmount=0;

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

                 grdResult.FooterRow.Cells[8].Text = "Page Total </br> Grand Total";
                 grdResult.FooterRow.Cells[9].Text = PreAuthAmountPT.ToString() + "</br>" + PreAuthAmountGT.ToString();
                 grdResult.FooterRow.Cells[10].Text = BillAmountPT.ToString() + "</br>" + BillAmountGT.ToString();
                 grdResult.FooterRow.Cells[11].Text = RecievedAmountPT.ToString() + "</br>" + RecievedAmountGT.ToString();
                 grdResult.FooterRow.Cells[12].Text = RefundPT.ToString() + "</br>" + RefundGT.ToString();
                 grdResult.FooterRow.Cells[13].Text = ClaimFromTPAPT.ToString() + "</br>" + ClaimFromTPAGT.ToString();
                 grdResult.FooterRow.Cells[14].Text = PaidByTPAPT.ToString() + "</br>" + PaidByTPAGT.ToString();
                 grdResult.FooterRow.Cells[15].Text = TDSPT.ToString() + "</br>" + TDSGT.ToString();
                 grdResult.FooterRow.Cells[16].Text = WriteOffPT.ToString() + "</br>" + WriteOffPT.ToString();
                 grdResult.FooterRow.BackColor = System.Drawing.Color.Gray;
                 grdResult.FooterRow.HorizontalAlign = HorizontalAlign.Right;
                 
                
                 lblResult.Visible = false;
                 DataSet ds = new DataSet();
                 DataTable dt = LoadData(lstTPADetails);
                 ds.Tables.Add(dt);
                 ViewState["report"] = ds;
                 imgBtnXL.Visible = true;
                 hypLnkPrint.Visible = true;
                 hypLnkPrint.NavigateUrl = "PrintInsuranceCorporateReport.aspx?pid=" + patientID.ToString() + "&pname=" + PatienName + "&ps=" + PaymentStatus + "&tpaname=" + TPAName + "&tpaid=" + tpaID.ToString() + "&fdate=" + fromDate + "&tdate=" + ToDate + "&client=" + ClientID.ToString();

             }
             else
             {
                 grdResult.DataSource = lstTPADetails;
                 grdResult.DataBind();
                 //lblResult.Visible = true;
                 imgBtnXL.Visible = false;
                 hypLnkPrint.Visible = false;
                 lblTPC.Visible = false;

             }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Binding BindTPACorporateReport() Method", ex);
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {

            BindTPACorporateReport();
         
          
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, btnSubmit_Click", ex);
        }
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
           

            if (e.NewPageIndex != -1)
            {
                grdResult.PageIndex = e.NewPageIndex;
                BindTPACorporateReport();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdResult_PageIndexChanging Event", ex);

        }
    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }
 
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //export to excel
            string prefix = string.Empty;
            prefix = "InsuranceCorpReport_Report_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            DataSet dsrpt = (DataSet)ViewState["report"];
            if (dsrpt != null)
            {
                ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First You have to click d Get report');", true);
            }
            //HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }

    public DataTable LoadData(List<TPADetails> lstTPADetails)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("Name");
        DataColumn dcol3 = new DataColumn("PatientNumber");
        DataColumn dcol4 = new DataColumn("AdmissionDate");
        DataColumn dcol2 = new DataColumn("DischargedDT");
        DataColumn dcol5 = new DataColumn("RefPhysicianName");
        DataColumn dcol6 = new DataColumn("PrimaryConsultant");
        DataColumn dcol7 = new DataColumn("TPAName");
        DataColumn dcol8 = new DataColumn("PreAuthAmount");
        DataColumn dcol9 = new DataColumn("BillAmount");
        DataColumn dcol10 = new DataColumn("RecievedAmount");
        DataColumn dcol11 = new DataColumn("AmountRefund");
        DataColumn dcol12 = new DataColumn("ClaimFromTPA");
        DataColumn dcol13 = new DataColumn("ReceivedFromTPA");
        DataColumn dcol14 = new DataColumn("TDSAmount");
        DataColumn dcol15 = new DataColumn("WriteOff");
        DataColumn dcol16 = new DataColumn("CliamForwardDate");
        DataColumn dcol17 = new DataColumn("SettlementDate");

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);
        dt.Columns.Add(dcol9);
        dt.Columns.Add(dcol10);
        dt.Columns.Add(dcol11);
        dt.Columns.Add(dcol12);
        dt.Columns.Add(dcol13);
        dt.Columns.Add(dcol14);
        dt.Columns.Add(dcol15);
        dt.Columns.Add(dcol16);
        dt.Columns.Add(dcol17);

        foreach (TPADetails item in lstTPADetails)
        {
            DataRow dr = dt.NewRow();
            dr["Name"] = item.Name;
            dr["PatientNumber"] = item.PatientNumber;
            dr["AdmissionDate"] = item.AdmissionDate;
            dr["DischargedDT"] = item.DischargedDT;
            dr["RefPhysicianName"] = item.RefPhysicianName;
            dr["PrimaryConsultant"] = item.PrimaryConsultant;
            dr["TPAName"] = item.TPAName;
            dr["PreAuthAmount"] = item.PreAuthAmount;
            dr["BillAmount"] = item.GrossAmount;
            dr["RecievedAmount"] = item.RecievedAmount;
            dr["AmountRefund"] = item.AmountRefund;
            dr["ClaimFromTPA"] = item.TPABillAmount;
            dr["ReceivedFromTPA"] = item.PaidByTPA;
            dr["TDSAmount"] = item.TDSAmount;
            dr["WriteOff"] = item.WriteOff;
            dr["CliamForwardDate"] = item.CliamForwardDate;
            dr["SettlementDate"] = item.SettlementDate;
            dt.Rows.Add(dr);
        }
        return dt;
    }
}
