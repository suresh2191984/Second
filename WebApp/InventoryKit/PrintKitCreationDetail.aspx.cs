using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryKit.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryCommon.BL;


public partial class Inventory_PrintKitCreationDetail : Attune_BasePage 
{
    public Inventory_PrintKitCreationDetail()
        : base("InventoryKit_PrintKitCreationDetail_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    InventoryKit_BL inventoryBL;
    long pKitID = -1;
    string pKitBatchNo = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryKit_BL(base.ContextInfo);
        if (!IsPostBack)
        {

            pKitID = Convert.ToInt64(Request.QueryString["KitID"] != null && Request.QueryString["KitID"].Trim() == "" ? "-1" : Request.QueryString["KitID"]);
            pKitBatchNo = Request.QueryString["KitBatchNo"] != null && Request.QueryString["KitBatchNo"].Trim() == "" ? "" : Request.QueryString["KitBatchNo"];
           // long pMasterKitID = Convert.ToInt64(Request.QueryString["MasterKitID"] != null && Convert.ToInt32(Request.QueryString["MasterKitID"]) == 0 ? 0 : Convert.ToInt32(Request.QueryString["MasterKitID"]));
           // string Status = Request.QueryString["Status"] != null && Request.QueryString["Status"].Trim() == "" ? "" : Request.QueryString["Status"];
            //int pdeID = Convert.ToInt32(Request.QueryString["pdeID"] != null && Request.QueryString["pdeID"].Trim() == "" ? "0" : Request.QueryString["pdeID"]);

            loadKitCreationDetail(pKitID, pKitBatchNo);
        }

    }

    public void loadKitCreationDetail(long pKitID, string pKitBatchNo)
    {




        new InventoryCommon_BL(base.ContextInfo).GetKitPrepatationDetails(OrgID, pKitBatchNo, pKitID, InventoryLocationID, out lstInventoryItemsBasket);

        if (lstInventoryItemsBasket.Count > 0)
        {
            lblDate.Text = DateTimeNow.ToExternalDate();
            lblKitID.Text = lstInventoryItemsBasket[0].Name.ToString(); ;
            lblBatchNo.Text = pKitBatchNo.ToString();
            lblComments.Text = lstInventoryItemsBasket[0].CategoryName.ToString();
            lblCreatedBy.Text = lstInventoryItemsBasket[0].SupplierName.ToString();

            if ((lstInventoryItemsBasket[0].FeeType  != "") && (lstInventoryItemsBasket[0].Remarks != ""))
            {
                lblPatientNo.Text = lstInventoryItemsBasket[0].FeeType.ToString() + " / " + lstInventoryItemsBasket[0].Remarks.ToString();
            }
            else if (lstInventoryItemsBasket[0].Remarks != "")
            {
                lblPatientNo.Text = lstInventoryItemsBasket[0].Remarks.ToString();
            }
            else
            {
                lblPatientNo.Text = "";
            }

            //gvResult.DataSource = lstInventoryItemsBasket;
            //gvResult.DataBind();
            //gvResult.Visible = false;


            GridViewDetails.DataSource = lstInventoryItemsBasket;
            GridViewDetails.DataBind();
        }
       
    }
    protected void GridViewDetails_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            string st = string.Empty;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InventoryItemsBasket IOM = (InventoryItemsBasket)e.Row.DataItem;
                lblQty.Text = String.Format("{0:0.00}", (IOM.Quantity  + decimal.Parse(lblQty.Text)));
                lblTSellingPrice.Text = String.Format("{0:0.00}", (IOM.TSellingPrice + decimal.Parse(lblTSellingPrice.Text)));
                //  lblSupplierName.Text = String.Format("{0:0.00}", (IOM.SupplierName + decimal.Parse(lblSupplierName.Text)));
            }
        }


        catch (Exception ex)
        {
           CLogger.LogError("Error While Loading GridViewDetails Details.", ex);
          //  ErrorDisplay1.ShowError = true;

        }
    }


    protected void btnBarCode_Click(object sender, EventArgs e)
    {
         pKitID = Convert.ToInt64(Request.QueryString["KitID"] != null && Request.QueryString["KitID"].Trim() == "" ? "-1" : Request.QueryString["KitID"]);
        pKitBatchNo = Request.QueryString["KitBatchNo"] != null && Request.QueryString["KitBatchNo"].Trim() == "" ? "" : Request.QueryString["KitBatchNo"];
        inventoryBL.GetKitCancelDetails(pKitID, pKitBatchNo, OrgID, ILocationID, LID, InventoryLocationID, "", "BarCode", "Y", out lstInventoryItemsBasket);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Window", "window.open('../VisitInfo/PrintBarcode.aspx?visitId=" + pKitID + "&sampleId=" + pKitBatchNo + "&orgId=" + OrgID + "&categoryCode=" + BarcodeCategory.KitBatchNo  + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
       // ScriptManager.RegisterStartupScript(this, GetType(), "Window", "window.open('../Inventory/BarcodePrint.aspx?visitId=" + pKitID + "&sampleId=" + pKitBatchNo + "&orgId=" + OrgID + "&categoryCode=" + BarcodeCategory.KitBatchNo + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
       
    
    }
}
