using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.StockReceive.BL;
using Attune.Kernel.PlatForm.Common;

public partial class StockReceived_InvoiceMapping :Attune_BasePage 
{
    public StockReceived_InvoiceMapping()
        : base("StockReceived_InvoiceMapping_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    StockReceived_BL objinv;
 
    long returnCode = -1;
    List<InventoryOrdersMaster> lstIOM = new List<InventoryOrdersMaster>();

    protected void Page_Load(object sender, EventArgs e)
    {
        objinv = new StockReceived_BL(base.ContextInfo);
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {

            txtFDate.Text = System.DateTime.Today.ToExternalDate();
            txtTDate.Text = System.DateTime.Today.ToExternalDate();
        }


    }


   
    
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        btnCancel.Visible = true;
        btnUpdate.Visible = true;

        binddata();

        

    }

    public void binddata()
    {

        try
        {

            List<InventoryOrdersMaster> lstIOM = new List<InventoryOrdersMaster>();
            List<InventoryOrdersMaster> lstIOMS = new List<InventoryOrdersMaster>();
             string Invoiceno = String.Empty;
            string DCNo = String.Empty;
            string SupName = String.Empty;
            long SupplierID = 0;
            string SRDNO = String.Empty;
            DateTime fdate = DateTime.MinValue;
            DateTime tdate = DateTime.MinValue;
          if (txtSupplierName.Text.Trim() != "")
            {
                SupplierID = Convert.ToInt64(hdnsupllierid.Value);


                SupName = txtSupplierName.Text.Trim().ToString();
            }

            //else
            //{
            //    SupName = txtSupplierName.Text.ToString();

            //}


            if (txtInvoiceNo.Text != "")
            {
                Invoiceno = txtInvoiceNo.Text.Trim().ToString();
            }
            if (txtDCNo.Text != "")
            {
                Invoiceno = txtDCNo.Text.Trim().ToString();
            }
            if (txtStockReceivedNumber.Text != "")
            {
                SRDNO = txtStockReceivedNumber.Text.Trim().ToString();
            }
            if (txtFDate.Text != "")
            {
                //fdate = Convert.ToDateTime(txtFDate.Text);
                fdate = txtFDate.Text.ToInternalDate();
            }
            else fdate = Convert.ToDateTime("01/01/1753 00:00:00");
            if (txtTDate.Text != "")
            {
               // tdate = Convert.ToDateTime(txtTDate.Text);
                tdate = txtTDate.Text.ToInternalDate();
            }
            else tdate = Convert.ToDateTime("01/01/1753 00:00:00");

            
            returnCode = objinv.GetInvoiceMapping(OrgID, fdate, tdate, Invoiceno, SupplierID, SRDNO, out lstIOM, out lstIOMS);


            ViewState["SupplierList"] = lstIOMS;
            grdResult.DataSource = lstIOM;
            grdResult.DataBind();
            if (lstIOM.Count > 0)
            {
                var InvMap = (from lst in lstIOM
                              select new { lst.OrderID, lst.SupplierName, lst.SRDNo, lst.StockReceivedDate, lst.InvoiceNo, lst.DCN0,lst.PurchaseOrderID, }).Distinct();
            }
            else
            {
                string strNoMatch = Resources.StockReceived_ClientDisplay.StockReceived_InvoiceMapping_aspx_01 == null ? "No matching Records Found!" : Resources.StockReceived_ClientDisplay.StockReceived_InvoiceMapping_aspx_01;

                string sPath = strNoMatch;
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Invoice/DCNO", "javascript:ShowAlertMsg('"+sPath+"');", true);
                //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Invoice/DCNO", "javascript:alert('No matching Records Found!');", true);
                btnUpdate.Visible = false;
                btnCancel.Visible = false;
            }
            
            
           
        }
    
      
        catch (Exception ex)
        {
            CLogger.LogError("Error in UPDATE DCNO ", ex);
        }
            
    }
    
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Attune_Navigation navigation = new Attune_Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
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
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        


        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            InventoryOrdersMaster iom = (InventoryOrdersMaster)e.Row.DataItem;
            DropDownList ddlSupplierName = (DropDownList)e.Row.FindControl("ddsn");
            TextBox txtStockDate = (TextBox)e.Row.FindControl("txtStockDate");
            TextBox txtinvoiceno = (TextBox)e.Row.FindControl("txtInvNo");
            TextBox txtInvoiceDate = (TextBox)e.Row.FindControl("txtInvoiceDate");

            if (txtinvoiceno.Text != "")
            {
                txtInvoiceDate.Enabled = true;
            }

            if (txtInvoiceDate.Text == "01/01/0001" || txtInvoiceDate.Text == "31/12/9999")
            {
                txtInvoiceDate.Text = "";
            }


            txtStockDate.Attributes.Add("readOnly", "true");
            ddlSupplierName.DataTextField = "SupplierName";
            ddlSupplierName.DataValueField = "OrderID";
            List<InventoryOrdersMaster> lstIOMS = (List<InventoryOrdersMaster>)ViewState["SupplierList"];
            ddlSupplierName.DataSource = lstIOMS;
            ddlSupplierName.DataBind();
            ddlSupplierName.SelectedValue = iom.SupplierID.ToString();
        }
        

    }
    
    protected void btnsaveDC_Click(object sender, EventArgs e)
    {


        long returnCode = -1;
        long srdno = -1;
        string invoiceno = String.Empty;
        string dcno = String.Empty;
        string supname = String.Empty;
        try
        {
            InventoryItemsBasket IOM ;
            List<InventoryItemsBasket> LSTIOM = new List<InventoryItemsBasket>();
            foreach (GridViewRow gr in grdResult.Rows)
            {
                IOM = new InventoryItemsBasket();
                srdno = Convert.ToInt32(grdResult.DataKeys[gr.RowIndex].Values[0]);
                TextBox txtinvoiceno = (TextBox)gr.FindControl("txtInvNo");
                TextBox DCNo = (TextBox)gr.FindControl("txtDCNo");
                DropDownList sname = (DropDownList)gr.FindControl("ddsn");
                TextBox txtStockreceiveddate = (TextBox)gr.FindControl("txtStockDate");
                TextBox txtInvoiceDate = (TextBox)gr.FindControl("txtInvoiceDate");               
                IOM.InvoiceDate = !string .IsNullOrEmpty (txtInvoiceDate.Text) ? DateTime.ParseExact(txtInvoiceDate.Text, "dd/MM/yyyy", null) : DateTime.MaxValue  ;
                IOM.ID =  srdno ;
                IOM.ProductID = Convert.ToInt64(sname.SelectedValue);
                IOM.Description = txtinvoiceno.Text.Trim();
                IOM.Remarks= DCNo.Text.Trim();
                IOM.ExpiryDate = DateTime.ParseExact(txtStockreceiveddate.Text,"dd/MM/yyyy",null);
                IOM.Manufacture = DateTimeNow;
                Label lblPurchaserNo = (Label)gr.FindControl("lblPurchaseOrder");
                IOM.ParentProductID = Convert.ToInt64(lblPurchaserNo.Text);
                LSTIOM.Add(IOM);
            }
            returnCode = objinv.UpdateDcNumber(OrgID, InventoryLocationID, LSTIOM);
            if (returnCode == 0)
            {
                string strUpdate = Resources.StockReceived_ClientDisplay.StockReceived_InvoiceMapping_aspx_02 == null ? "Supplier/Invoice/DCNO UPDated Suceefully!" : Resources.StockReceived_ClientDisplay.StockReceived_InvoiceMapping_aspx_02;
                string sPath = strUpdate;
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Invoice/DCNO", "javascript:ShowAlertMsg("+sPath+");", true);
                //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Invoice/DCNO", "javascript:alert('Supplier/Invoice/DCNO UPDated Suceefully!');", true);
                btnSearch_Click(sender, e);
            }
            else
            {
                string strFailUpdate = Resources.StockReceived_ClientDisplay.StockReceived_InvoiceMapping_aspx_03 == null ? "Updation failed." : Resources.StockReceived_ClientDisplay.StockReceived_InvoiceMapping_aspx_03;
                string sPath = strFailUpdate;
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "dueChart", "javascript:ShowAlertMsg("+sPath+");", true);
                //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "dueChart", "javascript:alert('Updation failed.');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in UPDATE DCNO ", ex);
        }
    }


   
}




