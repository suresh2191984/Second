using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.BL;

public partial class PurchaseOrder_SuplierPurchaseOrder : Attune_BasePage
{
    public PurchaseOrder_SuplierPurchaseOrder()
        : base("PurchaseOrder_SuplierPurchaseOrder_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdnInventoryLocaionID.Value = InventoryLocationID.ToString();
            hdnOrgID.Value = OrgID.ToString();
            hdnILocationID.Value = ILocationID.ToString();
            hdnLID.Value = LID.ToString();
            if (Session["values"] != null && Session["values"] != "")
            {
                hdnProductList.Value = Session["values"].ToString();
            }
            string QuotationReorder = GetConfigValue("QuotationReorderLevel", OrgID);
            hdnQuotationConfig.Value = QuotationReorder.ToString();

        }
    }
}
