using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PORequest.BL;
using Attune.Kernel.PlatForm.BL;

public partial class PORequest_RaisedPurchaseOrder : Attune_BasePage
{
    public PORequest_RaisedPurchaseOrder()
        : base("PORequest_RaisedPurchaseOrder.aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<Suppliers> lstSuppliers;
    List<InventoryUOM> lstInventoryUOM;
    InventoryCommon_BL inventoryBL;

    List<InventoryOrdersMaster> lstOrders = new List<InventoryOrdersMaster>();

    List<InventoryItemsBasket> lstporequestproducts;
    List<InventoryItemsBasket> lstproductssuppliers;
    int sno = 1;
    string ProductsNames = string.Empty;
    string PRequestID = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        lstporequestproducts = new List<InventoryItemsBasket>();
        lstproductssuppliers = new List<InventoryItemsBasket>();
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        hdnunits.Value = "";
        if (!IsPostBack)
        {

            lstInventoryUOM = new List<InventoryUOM>();
            if (lstInventoryUOM.Count == 0)
            {
                inventoryBL = new InventoryCommon_BL(base.ContextInfo);
                inventoryBL.GetInventoryUOM(out lstInventoryUOM);
            }

            lstSuppliers = new List<Suppliers>();
            if (lstSuppliers.Count == 0)
            {
                inventoryBL = new InventoryCommon_BL(base.ContextInfo);
                inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);
            }
           

            if (Request.QueryString["PORID"] != null)
            {
                PRequestID = Request.QueryString["PORID"];
                hdnprid.Value = Request.QueryString["PORID"];
            }

            inventoryBL.GetPORequestproducts(PRequestID, OrgID, InventoryLocationID, out lstporequestproducts, out lstproductssuppliers);
            if (lstporequestproducts.Count > 0)
            {
                btnPO.Visible = true;
                grdResult.DataSource = lstporequestproducts;
                grdResult.DataBind();
                ScriptManager.RegisterStartupScript(this, GetType(), "Bind", "SetSuppliers();", true);

                //To check the products are rate mapping Products are product name in grid view ...
                if (ProductsNames != string.Empty)
                {
                    //lblproductss.Text = "<B>This Products Rate are not mapped : "+ProductsNames;
                    //ModalPopupExtender1.Show(); 
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "altSample", "javascript:alert('This Products Rates are not mapped" + ProductsNames + " .');", true);

                }

            }
            else
            {
                btnPO.Visible = false;
            }




        }

    }

    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblproducts = (Label)e.Row.FindControl("lblproducts");
            DropDownList ddlSuplier = (DropDownList)e.Row.FindControl("ddlSup");
            DropDownList ddlUnits = (DropDownList)e.Row.FindControl("ddlUnits");
            DropDownList ddlLoc = (DropDownList)e.Row.FindControl("ddlloc");
            HiddenField productid = (HiddenField)e.Row.FindControl("hdnproductid");
            HiddenField hdnunits = (HiddenField)e.Row.FindControl("hdnunitss");
            HiddenField hdnsupplierValue = (HiddenField)e.Row.FindControl("hdnconvesrsiondata");

            ddlUnits.DataSource = lstInventoryUOM;
            ddlUnits.DataTextField = "UOMCode";
            ddlUnits.DataValueField = "UOMCode";
            ddlUnits.DataBind();


            //List<InventoryItemsBasket> lstporequestproduct = new List<InventoryItemsBasket>();
            //InventoryItemsBasket po = (InventoryItemsBasket)e.Row.DataItem;
            //e.Row.Cells[2].Attributes.Add("onmouseover", "this.className='colornw';ProductSupplierlist(event,'" + po.Description + "');return false;");

          
            //var templist = lstSuppliers;
            var templist = from s in lstproductssuppliers
                           where s.ProductID == Convert.ToInt64(productid.Value.ToString())
                           select s;
            
            //List<InventoryItemsBasket> lstporequestproduct = new List<InventoryItemsBasket>();
            //InventoryItemsBasket po = (InventoryItemsBasket)e.Row.DataItem;
            
            if (templist.Count() > 0)
            {
                ddlSuplier.DataSource = lstSuppliers;
                ddlSuplier.DataTextField = "SupplierName";
                ddlSuplier.DataValueField = "SupplierId";
                ddlSuplier.DataBind();
                //ddlSuplier.Items.Insert(0, new ListItem("--Select--", "-1"));
                //ddlSuplier.SelectedIndex = 0;
                string strval = "javascript:BindUnits('" +
                                                    ((DropDownList)e.Row.FindControl("ddlUnits")).ClientID + "','" +
                                                    ddlSuplier.ClientID + "','" + hdnsupplierValue.ClientID + "');";
                ddlSuplier.Attributes.Add("onchange", strval);

                foreach (var item in templist)
                {
                    hdnsupplierValue.Value += item.Description;

                    ddlSuplier.SelectedValue = Convert.ToString(item.SupplierId);
                   
                }
                e.Row.Cells[1].Attributes.Add("onmouseover", "ProductSupplierlist('" + hdnsupplierValue.Value.ToString() + "');return false;");
                //ddlSuplier.SelectedValue = DataBinder.Eval(e.Row.DataItem, "IssuedQty").ToString();
                ddlSupListCount.Value += ddlSuplier.ClientID + "^";

            }
            else
            {
                //"\\n" + " [ " + inv.InvestigationName + " ] " + "\\n";

                ProductsNames += sno + "[" + lblproducts.Text + "]" + " \\n ";
                sno++;
                //lstSuppliers = new List<Suppliers>();
                //if (lstSuppliers.Count == 0)
                //{
                //    inventoryBL = new Inventory_BL(base.ContextInfo);
                //    inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);
                //}
                //ddlSuplier.DataSource = lstSuppliers;
                //ddlSuplier.DataTextField = "SupplierName";
                //ddlSuplier.DataValueField = "SupplierId";
                //ddlSuplier.DataBind();
                //ddlSuplier.Items.Insert(0, new ListItem("--Select--", "-1"));
                //ddlSuplier.SelectedIndex = 0;

            
                //ddlSuplier.Enabled = true;
                //ddlUnits.Enabled = true;
            }
            string strvalues = "javascript:Unitschange('" +
                                                    ((DropDownList)e.Row.FindControl("ddlUnits")).ClientID + "','" +
                                                    ((HiddenField)e.Row.FindControl("hdnunitss")).ClientID + "','" +
                                                    ((HiddenField)e.Row.FindControl("hdnunitsvalue")).ClientID + "');";
            ddlUnits.Attributes.Add("onchange", strvalues);

            ddlUnits.SelectedValue = DataBinder.Eval(e.Row.DataItem, "Unit").ToString();
            hdnunits.Value = DataBinder.Eval(e.Row.DataItem, "Unit").ToString();



        }
    }
    

    protected void btnPO_Click(object sender, EventArgs e)
    {
        try
        {
        long returncode = -1;
        List<InventoryItemsBasket> lBasket = new List<InventoryItemsBasket>();
        string Status = "Pending";
        InventoryItemsBasket raisepo;

        foreach (GridViewRow row in grdResult.Rows)
        {
           
            if (row.RowType == DataControlRowType.DataRow)
            {
                
                HiddenField hdnproductid = (HiddenField)row.FindControl("hdnproductid");
                HiddenField Porequestid = (HiddenField)row.FindControl("hdnpoRequestid");
                HiddenField hdnparentproductid = (HiddenField)row.FindControl("hdnParentProductid");
                HiddenField hdnunits = (HiddenField)row.FindControl("hdnunitss");
                Label products = (Label)row.FindControl("lblproducts");
                TextBox txtquantity = (TextBox)row.FindControl("txtQty");
                DropDownList ddlsup = (DropDownList)row.FindControl("ddlSup");
                DropDownList ddlunits = (DropDownList)row.FindControl("ddlUnits");
                foreach (string item in Porequestid.Value.Trim().Split('#'))
                {
                    if (item.Trim() != "")
                    {
                        raisepo = new InventoryItemsBasket();
                        raisepo.ID = Convert.ToInt32(ddlsup.SelectedValue);
                        raisepo.ProductID = Convert.ToInt32(hdnproductid.Value);//Product ID...
                        raisepo.Manufacture = DateTimeUtility.GetServerDate();
                        raisepo.ExpiryDate = DateTimeUtility.GetServerDate();
                        raisepo.Quantity = Convert.ToDecimal(txtquantity.Text);
                        raisepo.Unit = hdnunits.Value.Split('~')[0].ToString();
                        raisepo.Providedby = (Convert.ToInt64(txtquantity.Text) * Convert.ToInt64(1));//saravanan by 
                        //raisepo.Providedby = (Convert.ToInt64(txtquantity.Text) * Convert.ToInt64(hdnunits.Value.Split('~')[1]));
                        raisepo.ParentProductID = Convert.ToInt64(hdnparentproductid.Value);
                        raisepo.AttributeDetail = item;//Purchase order Request id alais name was given data
                        lBasket.Add(raisepo);
                    }
                   
                }
                hdnunits.Value = "";

            }
        }

        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            int OrgAddid = ILocationID;
            int k = Convert.ToInt16(Session["LID"].ToString());
            
            int locid = Convert.ToInt32(InventoryLocationID.ToString());
            returncode = inventoryBL.SaveSupplierProductPurchaseOrder(OrgID, OrgAddid, k, Status, lBasket, locid, false,true, out lstOrders);
            string userMsg = Resources.PORequest_AppMsg.PORequest_RaisedPurchaseOrder_aspx_01;
            userMsg = userMsg == null ? "Purchase Order Added  successfully." : userMsg;
            string informMsg = Resources.PORequest_AppMsg.PORequest_Information;
            informMsg = informMsg == null ? "Information" : informMsg;
            if (returncode >= 0)
            {
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "RaisePO", "alert('Purchase Request are Raised PO..');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "ValidationWindow('" + userMsg + "','" + informMsg + "');", true);

                Response.Redirect("../PlatForm/Home.aspx", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Failed Raise PO", "alert('Purchase Request are Raised PO Failed')", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Purchase request are raised po", ex);
        }

    }

     
    protected void btnClosepn_Click(object sender, ImageClickEventArgs e)
    {

    
      

        inventoryBL.GetPORequestproducts(hdnprid.Value, OrgID, InventoryLocationID, out lstporequestproducts, out lstproductssuppliers);
        if (lstporequestproducts.Count > 0)
        {
            grdResult.DataSource = lstporequestproducts;
            grdResult.DataBind();
            ScriptManager.RegisterStartupScript(this, GetType(), "Bind", "SetSuppliers();", true);
        }

    }
}
