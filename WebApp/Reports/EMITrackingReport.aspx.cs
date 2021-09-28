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

public partial class Reports_EMITrackingReport : BasePage
{
    long ReturnCode = -1;
    string BankName = string.Empty;
    DateTime SDate=DateTime.MinValue;
    DateTime EDate=DateTime.MinValue;

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

    protected void btnView_Click(object sender, EventArgs e)
    {

        try
        {

            if ((txtFDate.Text != "") && (txtTDate.Text != ""))
            {
                SDate = Convert.ToDateTime(txtFDate.Text);
                EDate = Convert.ToDateTime(txtTDate.Text);
            }
            else
            {
                SDate = Convert.ToDateTime(System.DateTime.Today);
                EDate = Convert.ToDateTime(System.DateTime.Today);
            }

            Boolean IsDateValid;
            //IsDateValid = ValidateEnddate();
            //if (IsDateValid)
            //{

            List<AmountReceivedDetails> lstAmountReceivedDetails = new List<AmountReceivedDetails>();
            ReturnCode = new Report_BL(base.ContextInfo).GetEMITrackingReport(SDate, EDate, BankName, out lstAmountReceivedDetails);

            if (lstAmountReceivedDetails.Count() > 0)
            {
                gvParentGrid.DataSource = lstAmountReceivedDetails;
                gvParentGrid.DataBind();
            }

            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
                gvParentGrid.DataSource = null;
                gvParentGrid.DataBind();

            }
        }

        catch (Exception ex)
        {
            //DvMessage.Visible = true;
            //lblMessage.Text = ex.Message;
        }
    }
      
      
    

 

    private bool ValidateEnddate()
    {
        DateTime dtStartdate = Convert.ToDateTime(txtFDate.Text);
        DateTime dtEndDate = Convert.ToDateTime(txtTDate.Text);
        if ((dtStartdate.CompareTo(dtEndDate) < 0) || (dtStartdate.CompareTo(dtEndDate) == 0))
            return true;
        else
            return false;
    }

    protected void gvParentGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            if (((AmountReceivedDetails)e.Row.DataItem).Physician == "")
            {
                e.Row.Cells[0].Text = "";
                e.Row.Cells[2].Text = "";
                e.Row.Cells[3].Text = "";
                e.Row.Cells[4].Text = "";
                e.Row.Cells[5].Text = "";
                e.Row.Cells[6].Text = "Total";
                e.Row.Style.Add("font-weight", "bold");
                e.Row.Style.Add("color", "Black");
            }
            GridView gv = (GridView)e.Row.FindControl("gvChildGrid");
            DateTime CreatedAt = (DateTime)gvParentGrid.DataKeys[e.Row.RowIndex].Value;
            List<AmountReceivedDetails> lstAmountReceivedDetails = new List<AmountReceivedDetails>();
            AmountReceivedDetails items = lstAmountReceivedDetails.Find(p => p.CreatedAt == SDate );
            gv.DataSource = items.CreatedAt;
            gv.DataBind();
        }

        GridView gd = (GridView)e.Row.FindControl("gvChildGrid");
        if (gd != null)
        {
            int cellid = 0;
            for (int rowIndex = gd.Rows.Count - 2;
                                     rowIndex >= 0; rowIndex--)
            {
                GridViewRow gvRow = gd.Rows[rowIndex];
                GridViewRow gvPreviousRow = gd.Rows[rowIndex + 1];
                //for (int cellCount = 0; cellCount < gvRow.Cells.Count;
                //                                              cellCount++)
                //{
                if (gvRow.Cells[cellid].Text == gvPreviousRow.Cells[cellid].Text)
                {
                    if (gvPreviousRow.Cells[cellid].RowSpan < 2)
                    {
                        gvRow.Cells[cellid].RowSpan = 2;
                    }
                    else
                    {
                        gvRow.Cells[cellid].RowSpan =
                            gvPreviousRow.Cells[cellid].RowSpan + 1;
                    }
                    gvPreviousRow.Cells[cellid].Visible = false;
                }
                //}
            }
        }




    }



    protected void btnExcel_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=EMITrackingReport.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";

        StringWriter StringWriter = new System.IO.StringWriter();
        HtmlTextWriter HtmlTextWriter = new HtmlTextWriter(StringWriter);

        gvParentGrid.RenderControl(HtmlTextWriter);
        Response.Write(StringWriter.ToString());
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void gvParentGrid_SelectedIndexChanged(object sender, EventArgs e)
    {

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
}

