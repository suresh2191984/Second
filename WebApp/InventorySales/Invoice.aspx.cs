using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventorySales.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;
using System.Collections; 
 
public partial class InventorySales_Invoice: Attune_BasePage
{
    public InventorySales_Invoice()
        : base("InventorySales_InventorySales_Invoice_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string s = Request.QueryString["InvoiceNo"];
        if (!IsPostBack)
        {
            GetInvoiceDetails();
        }
    }
    public void GetInvoiceDetails()
    {
        InventorySales_BL inventorySalesBL = new InventorySales_BL(base.ContextInfo); 
        List<SalesItemBasket> lstSalesDcItems = new List<SalesItemBasket>();
        List<Customers> lstCustomers = new List<Customers>();
        long returnCode = -1;
        string InvoiceNumber = string.Empty;
         
        if (Request.QueryString["InvoiceNo"] != null && Request.QueryString["InvoiceNo"] != "")
        {
            InvoiceNumber = Request.QueryString["InvoiceNo"];
        }
        returnCode=inventorySalesBL.GetSalesInvoiceDetail(OrgID,InvoiceNumber,out lstSalesDcItems,out lstCustomers);
        if (lstSalesDcItems.Count > 0)
        {
            grdResult.DataSource = lstSalesDcItems;
            grdResult.DataBind();
        }
        if (lstCustomers.Count > 0)
        {
            lblCustomerName.Text = lstCustomers[0].CustomerName;
            lbladdr1.Text = lstCustomers[0].Address1;
            lblcontactperson.Text = lstCustomers[0].ContactPerson;
            lblFax.Text = lstCustomers[0].FaxNumber;
            lblemails.Text = lstCustomers[0].EmailID;
            lbltinno.Text = lstCustomers[0].TINNo;
            lblcstno.Text = lstCustomers[0].CSTNo;
            lblPhone.Text = lstCustomers[0].Phone;
            lblMobile.Text = lstCustomers[0].Mobile;
            lblinvoceno.Text = InvoiceNumber + " / " + lstCustomers[0].CreatedAt.ToExternalDate();
            lblSalesOrderNo.Text = lstCustomers[0].TermsConditions;
            lblStatus.Text = lstCustomers[0].Address2;
            lblSODate.Text = lstCustomers[0].ModifiedAt.ToExternalDate();
        }
       // http://localhost:12744/WebApp/InventorySales/Invoice.aspx?InvoiceNo=INV1009&ACN=SalesOrder~0~~0~0~0

    }
    protected void grdResult_PreRender(object sender, EventArgs e)
    {
        GridDecorator.MergeRows(grdResult);
    }
    decimal tot = 0;
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType== DataControlRowType.DataRow)
        {
            SalesItemBasket s = (SalesItemBasket)e.Row.DataItem;
            tot = tot + s.TotalCost;
            lbltotal.Text = tot.ToString();
            
        }
    }
}
public class GridDecorator
{
    public static void MergeRows(GridView grdResult)
    {
        for (int rowIndex = grdResult.Rows.Count - 2; rowIndex >= 0; rowIndex--)
        {
            GridViewRow row = grdResult.Rows[rowIndex];
            GridViewRow previousRow = grdResult.Rows[rowIndex + 1];

            for (int i = 0; i < 1; i++)
            {
                if (row.Cells[i].Text == previousRow.Cells[i].Text)
                {
                    row.Cells[i].RowSpan = previousRow.Cells[i].RowSpan < 2 ? 2 :
                                           previousRow.Cells[i].RowSpan + 1;
                    previousRow.Cells[i].Visible = false;
                }
            }
        }
    }
}
