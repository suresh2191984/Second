using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Attune.Kernel.BusinessEntities;
using System.Text;
using System.IO;
using System.Web.Script.Serialization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.CentralPurchasing.BL;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using System.Web.UI.WebControls;
using Attune.Kernel.PerformingNextAction;

public partial class StockManagement_ViewPurchaseOrderMedal : Attune_BasePage
{
    public StockManagement_ViewPurchaseOrderMedal()
        : base("StockManagement_ViewPurchaseOrderMedal_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
         
        if (!IsPostBack)
        {

            HiddenField hdnPOIDS = (HiddenField)PreviousPage.FindControl("hdnPurchaseOrderIDS");
            string PurchaseOrderID = hdnPOIDS.Value;

            string[] arrayids = PurchaseOrderID.Split('~');
            int arraycount = arrayids.Count();
            for (int i = 0; i < arraycount; i++)
            {
                if (arrayids[i] != "")
                {

                    StockManagement_Controls_ViewMultiplePurchaseOrder usercntrol1 = LoadControl("~/StockManagement/Controls/ViewMultiplePurchaseOrder.ascx") as StockManagement_Controls_ViewMultiplePurchaseOrder;
                    usercntrol1.ID = "viewPurchase" + i.ToString();
                    usercntrol1.OrgID = OrgID;
                    usercntrol1.PrintDetails(Convert.ToInt64(arrayids[i]));

                    ViewOrder.Controls.Add(usercntrol1);
                }
                

            }
        }
    }

}
