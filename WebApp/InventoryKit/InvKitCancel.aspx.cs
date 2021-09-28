using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryKit.BL;
using Attune.Kernel.PlatForm.Common;

public partial class InventoryKit_InvKitCancel : Attune_BasePage
{
    public InventoryKit_InvKitCancel()
        : base("InventoryKit\\InvKitCancel.aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    InventoryKit_BL inventoryBL;
    string IsBarcodePrint = "N";
    string Category = "KitCancel";
    string struserMsg = Resources.InventoryKit_ClientDisplay.InventoryKit_InvKitCancel_aspx_01 == null ? "Successfully cancelled !!" : Resources.InventoryKit_ClientDisplay.InventoryKit_InvKitCancel_aspx_01;
    string strerrorMsg = Resources.InventoryKit_ClientDisplay.InventoryKit_InvKitCancel_aspx_02 == null ? "Alert" : Resources.InventoryKit_ClientDisplay.InventoryKit_InvKitCancel_aspx_02;
        
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryKit_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            long pKitID = Convert.ToInt64(Request.QueryString["KitID"] != null && Request.QueryString["KitID"].Trim() == "" ? "-1" : Request.QueryString["KitID"]);
            string pKitBatchNo = Request.QueryString["KitBatchNo"] != null && Request.QueryString["KitBatchNo"].Trim() == "" ? "" : Request.QueryString["KitBatchNo"];
            loadKitCancelDetail(pKitID, pKitBatchNo, "");
            trProductDetail.Attributes.Add("class", "hide");
        }
    }
    public void loadKitCancelDetail(long pKitID, string pKitBatchNo, string Status)
    {

        inventoryBL.GetKitCancelDetails(pKitID, pKitBatchNo, OrgID, ILocationID, LID, InventoryLocationID, Status, Category, IsBarcodePrint, out lstInventoryItemsBasket);
        if (lstInventoryItemsBasket.Count > 0)
        {
            lblDate.Text = DateTimeUtility.GetServerDate().ToExternalDate();
            lblKitID.Text = lstInventoryItemsBasket[0].Name.ToString();
            lblBatchNo.Text = pKitBatchNo.ToString();
            lblComments.Text = lstInventoryItemsBasket[0].CategoryName.ToString();
            lblCanceledBy.Text = lstInventoryItemsBasket[0].SupplierName.ToString();
            gvResult.DataSource = lstInventoryItemsBasket;
            gvResult.DataBind();
            btnCancel.Enabled = Status == "Cancel" ? false : true;
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        long pKitID = Convert.ToInt64(Request.QueryString["KitID"] != null && Request.QueryString["KitID"].Trim() == "" ? "-1" : Request.QueryString["KitID"]);
        string pKitBatchNo = Request.QueryString["KitBatchNo"] != null && Request.QueryString["KitBatchNo"].Trim() == "" ? "" : Request.QueryString["KitBatchNo"];
        string Status = Request.QueryString["Status"] != null && Request.QueryString["Status"].Trim() == "" ? "" : Request.QueryString["Status"];
        loadKitCancelDetail(pKitID, pKitBatchNo,Status);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Cancel alert", "javascript:ValidatationWindow('"+struserMsg+"','"+strerrorMsg+"');", true);
        loadKitCancelDetail(pKitID, pKitBatchNo, "");
        trProductDetail.Attributes.Add("class", "show");
        btnCancel.Enabled = false;
    }
    protected void btnHome_Click(object sender, EventArgs e)
    {
        long returncode = -1;
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returncode = new Attune_Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath  + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void gvResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            string st = string.Empty;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InventoryItemsBasket IOM = (InventoryItemsBasket)e.Row.DataItem;
                lblQty.Text = String.Format("{0:0.00}", (IOM.Quantity + decimal.Parse(lblQty.Text)));
                lblTSellingPrice.Text = String.Format("{0:0.00}", (IOM.TSellingPrice + decimal.Parse(lblTSellingPrice.Text)));
                //  lblSupplierName.Text = String.Format("{0:0.00}", (IOM.SupplierName + decimal.Parse(lblSupplierName.Text)));
            }
        }


        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading gvResult Details.", ex);
            //ErrorDisplay1.ShowError = true;

        }
    }
}