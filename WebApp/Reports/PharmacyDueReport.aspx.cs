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
using System.IO;

public partial class Reports_PharmacyDueReport : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    protected void Page_Load(object sender, EventArgs e)
    {
        
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
        try
        {
             
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate, tDate;
            DateTime.TryParse(txtFDate.Text, out fDate);
            DateTime.TryParse(txtTDate.Text, out tDate);
            string IsCreditBill = "N";
            int VisitType = Convert.ToInt32(rblVisitType.SelectedItem.Value);
            string Feetype = rblFeeType.SelectedItem.Value;
            returnCode = new Report_BL(base.ContextInfo).GetPharmacyDueReport(fDate, tDate, OrgID, ILocationID, IsCreditBill, VisitType, Feetype, out lstDWCR);
            if (lstDWCR.Count > 0)
            {
                var temp = lstDWCR;
                if (Rbltypeofpatient.SelectedItem.Value == "Creditandcash")
                {
                    temp = temp.FindAll(p => p.IsCreditBill == "Y" || p.IsCreditBill == "N" || p.IsCreditBill == "B").ToList();

                }


                else if (Rbltypeofpatient.SelectedItem.Value == "Credit")
                {

                    temp = temp.FindAll(p => p.IsCreditBill == "Y" || p.IsCreditBill == "B").ToList();


                }

                else if (Rbltypeofpatient.SelectedItem.Value == "Cash")
                {

                    temp = temp.FindAll(p => p.IsCreditBill == "N" || p.IsCreditBill == "B").ToList();

                }


                grdResult.DataSource = temp;
                grdResult.DataBind();
                hdnXLFlag.Value = "1";
            }
            else
            {
                grdResult.DataSource = "";
                grdResult.DataBind();
                hdnXLFlag.Value = "0";
            }

             

        }


        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, PharmacyDueReport", ex);
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




    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    protected void lnkExportXL_Click(object sender, EventArgs e)
    {
        try
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "PharmacyDueReport.xls"));
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {

                    grdResult.RenderControl(htw);
                    //gvIPCreditMain.RenderEndTag(htw);
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();


                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Due Report", ex);
        }
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        DayWiseCollectionReport dwcr = (DayWiseCollectionReport)e.Row.DataItem;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (dwcr.IsCreditBill == "Y")
            {
                e.Row.CssClass = "grdrows";
            }
            if (dwcr.PatientName.Trim() == "Total")
            {
                e.Row.Font.Bold = true;
                e.Row.CssClass = "grdcheck";
                e.Row.Cells[0].Text = "";
                e.Row.Cells[11].Text = "";
            }
        }
    }
}