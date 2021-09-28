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
using System.IO;
using Attune.Podium.ExcelExportManager;


public partial class Reports_PatientLedgerReport : BasePage
{

    DataSet ds = new DataSet();
    string status;

    string ViewOption = string.Empty;
    string paymentoption = string.Empty;
    private enum StaticColumns
    {
        PatientID,
        PatientName,
        VisitState,
        DoAdmission,
        DoDischargeDT,
    };
    Report_BL Rbl;
    List<Patient> lstPatient = new List<Patient>();
    List<FinalBill> lstFinalBill = new List<FinalBill>();
    string PatientNumber = string.Empty;
    long returnCode = -1;
    int visitType = -1;
    string pagename = "";
    string sFeetype = string.Empty;
    decimal totGross = 0;
    decimal totDiscount = 0;
    decimal totTax = 0;
    decimal totNet = 0;
    decimal totReceived = 0;
    decimal totDue = 0;
    decimal totDueClear = 0;
    decimal totRefund = 0;
    decimal totdepAmt = 0;
    decimal totdepused = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        Rbl = new Report_BL(base.ContextInfo);
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {


            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");

        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        List<DayWiseCollectionReport> lstDWADR = new List<DayWiseCollectionReport>();
        PatientNumber = Convert.ToString(txtPatientNo.Text);
        visitType = Convert.ToInt32(rblVisitType.SelectedValue);
        try
        {
            returnCode = Rbl.GetPatientLedgerReport(PatientNumber, txtFDate.Text, txtTDate.Text, OrgID, 0, out lstDWADR);
            if (lstDWADR.Count > 0)
            {
                var temp = lstDWADR;
                if (rblVisitType.SelectedItem.Value == "-1")
                {
                    gvIPCreditMain.DataSource = lstDWADR;
                    gvIPCreditMain.DataBind();
                }
                if (rblVisitType.SelectedItem.Value == "0")
                {
                    temp = temp.FindAll(p => p.VisitType == "0").ToList();
                    gvIPCreditMain.DataSource = temp;
                    gvIPCreditMain.DataBind();
                }
                else if (rblVisitType.SelectedItem.Value == "1")
                {
                    temp = temp.FindAll(p => p.VisitType == "1").ToList();
                    gvIPCreditMain.DataSource = temp;
                    gvIPCreditMain.DataBind();
                }
               
                lblPatientName.Text = lstDWADR[0].PatientName;
                lblPatientNumber.Text = lstDWADR[0].PatientNumber;
                lblPatientAge.Text = lstDWADR[0].Age;
                lblPeriodFromTo.Text = txtFDate.Text.ToString() + " To " + txtTDate.Text.ToString();
                divPatientDetail.Style.Add("display", "block");
                tblPatientDetails.Style.Add("display", "block");
                tblPatientDetails.Style.Add("display", "block");
            }
            else
            {
                gvIPCreditMain.DataSource = null;
                gvIPCreditMain.DataBind();
                tblPatientDetails.Style.Add("display", "none");
                tblPatientDetails.Style.Add("display", "none");
                ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('No Matching records found');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on Patient Ledger Report", ex);
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
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                FinalBill Fb = (FinalBill)e.Row.DataItem;

                Label lblBillNumnber = (Label)e.Row.FindControl("lblBillNumber");

                Label lblDue = (Label)e.Row.FindControl("lblDue");
                lblDue.Text = Fb.Due.ToString();
                if (lblDue.Text.Contains('-'))
                    lblDue.Text = "0.00";
                if (Fb.Type == "Hospital Bill")
                {
                    lblBillNumnber.Text = Fb.BillNumber + " (Hospital Bill)";
                    e.Row.Cells[0].ForeColor = System.Drawing.Color.Green;
                    sFeetype = "CON";
                    pagename = "?vid=" + Fb.VisitID + "&pagetype=BP&bid=" + Fb.FinalBillID + "";
                }
                if (Fb.Type == "Pharmacy Bill")
                {
                    lblBillNumnber.Text = Fb.BillNumber + " (Pharmacy Bill)";
                    e.Row.Cells[0].ForeColor = System.Drawing.Color.Red;
                    sFeetype = "PRM";
                    pagename = "?vid=" + Fb.VisitID + "&pagetype=BP&bid=" + Fb.FinalBillID + "";
                }
                if (Fb.Type == "Deposit")
                {
                    sFeetype = "DEP";
                    lblBillNumnber.Text = Fb.BillNumber + " (Deposit Receipt)";
                    e.Row.Cells[0].ForeColor = System.Drawing.Color.Black;

                    pagename = "?Amount=" + Fb.AmountReceived + "&dDate=" + Fb.CreatedAt + "&rcptno=" + Fb.BillNumber + "&RNAME=" + lstPatient[0].Name + "";
                }
                if (Fb.Type == "Due Clearance")
                {
                    sFeetype = "CON";
                    lblBillNumnber.Text = Fb.BillNumber + " (Due Clearance)";
                    e.Row.Cells[0].ForeColor = System.Drawing.Color.BlueViolet;
                    pagename = "?vid=" + Fb.VisitID + "&pagetype=BP&bid=" + Fb.FinalBillID + "";
                }
                e.Row.Attributes.Add("onclick", "openViewBill('" + pagename + "','" + sFeetype + "')");
                e.Row.Style.Add(HtmlTextWriterStyle.Cursor, "Pointer");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on Row Data Bound in Patient Ledger Report", ex);
        }
    }
    
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport Fb = (DayWiseCollectionReport)e.Row.DataItem;
                pagename = "?vid=" + Fb.PatientVisitId + "&pagetype=BP&bid=" + Fb.FinalBillID + "";
                if (Fb.VisitType == "1")
                {
                    sFeetype = "CON";
                    e.Row.Cells[1].ForeColor = System.Drawing.Color.BlueViolet;
                    e.Row.Attributes.Add("onclick", "openViewBill('" + pagename + "','" + sFeetype + "')");
                    e.Row.ToolTip = "IP View Bill";
                }
                else
                {
                    if (Fb.FeeType == "CON")
                    {
                        sFeetype = "CON";
                        e.Row.Cells[1].ForeColor = System.Drawing.Color.BlueViolet;
                        e.Row.Attributes.Add("onclick", "openViewBill('" + pagename + "','" + sFeetype + "')");
                        e.Row.ToolTip = "Hospital Bill";
                    }
                    if (Fb.FeeType == "PRM")
                    {
                        sFeetype = "PRM";
                        e.Row.Cells[1].ForeColor = System.Drawing.Color.Red;
                        e.Row.Attributes.Add("onclick", "openViewBill('" + pagename + "','" + sFeetype + "')");
                        e.Row.ToolTip = "Pharmacy Bill";
                    }
                }
                e.Row.Style.Add(HtmlTextWriterStyle.Cursor, "Pointer");
               
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        if (gvIPCreditMain != null)
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Patient Ledger Report.xls"));
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {
                    gvIPCreditMain.RenderControl(htw);
                    //gvIPCreditMain.RenderEndTag(htw);
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();


                }
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('Get Patient Details then Click Export to Excel');", true);
        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    
}
