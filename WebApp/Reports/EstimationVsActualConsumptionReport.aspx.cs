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

public partial class Reports_EstimationVsActualConsumptionReport :BasePage
{
    DateTime SDate = DateTime.MinValue;
    DateTime EDate = DateTime.MinValue;
    long ReturnCode = -1;
    List<BillofMaterialDetails> lstBillofMaterialDetails = new List<BillofMaterialDetails>();
    List<BillofMaterialDetails> lstBillofMaterialDetails1 = new List<BillofMaterialDetails>();

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
            string SearchItem = string.Empty;
           // List<BillofMaterialDetails> lstBillofMaterialDetails = new List<BillofMaterialDetails>();
            ReturnCode = new Report_BL(base.ContextInfo).GetEstimationVsConsumtionReport(SDate, EDate, SearchItem, out lstBillofMaterialDetails);

            if (lstBillofMaterialDetails.Count() > 0)
            {

                var list = (from list1 in lstBillofMaterialDetails
                            select list1.Description
                            ).ToList().Distinct();

                foreach (var obj in list)
                {
                    BillofMaterialDetails pdc = new BillofMaterialDetails();
                    pdc.Description = obj;
                    lstBillofMaterialDetails1.Add(pdc);
                }
            }

            if (lstBillofMaterialDetails.Count() > 0)
            {
                grdResult.DataSource = lstBillofMaterialDetails1;
                grdResult.DataBind();
            }

            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
                grdResult.DataSource = null;
                grdResult.DataBind();

            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("There was a problem in getting Actual Vs Consumption Report ", ex);
        }

    }

    public void ExportToExcel(Control CTR1)
    {
        try
        {
            // form1.Controls.Clear();


            string prefix = string.Empty;
            prefix = "Estimated Vs Actual Consumption Report_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString();
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);
            // CTR1.BorderWidth = 1;
            oHtmlTextWriter.WriteLine("<span style='font-size:14.0pt; color:#538ED5;font-weight:700;'>Purchase Order Reports</span>");
            // CTR1.RenderControl(oHtmlTextWriter);

            grdResult.RenderControl(oHtmlTextWriter);
          

            HttpContext.Current.Response.Write(oStringWriter);
            oHtmlTextWriter.Close();
            oStringWriter.Close();
            Response.End();

        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Purchase Order Reports-ExportToExcel", ioe);
        }


    }

    protected void btnExcel_Click(object sender, EventArgs e)
    {

        ExportToExcel(grdResult);
      

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
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                BillofMaterialDetails BMaster = (BillofMaterialDetails)e.Row.DataItem;                                         
                IEnumerable<BillofMaterialDetails> childItems = (from child in lstBillofMaterialDetails
                                                                 where

                                                                 child.Description == BMaster.Description

                                                                 group child by new
                                                                 {
                                                                     //child.ResourceServiceTypeName,

                                                                     child.BillofMaterialID ,
                                                                     child.Description ,
                                                                     child.LocationID ,
                                                                     child.FeeType ,
                                                                     child.ProductID ,
                                                                     child.ParentProductID 

                                                                 } into g
                                                                 select new BillofMaterialDetails
                                                                 {

                                                                     Description =g.Key.Description ,
                                                                     LocationID =g.Key .LocationID ,
                                                                     FeeType =g.Key .FeeType ,
                                                                     ProductID =g.Key .ProductID ,
                                                                     BillofMaterialID =g.Key .BillofMaterialID ,
                                                                     ParentProductID =g.Key .ParentProductID
                                                                    

                                                                 }).Distinct().ToList();
              
               
                GridView childGrid = (GridView)e.Row.FindControl("grdChildResult");
                childGrid.DataSource = childItems;

                childGrid.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("there was a problem in lodind data", ex);
        }


    }

    protected void grdChildResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        //base.VerifyRenderingInServerForm(control);
    }

}
