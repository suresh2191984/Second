using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;


public partial class CommonControls_ProductReminderDisplay : BaseControl
{
    public CommonControls_ProductReminderDisplay()
        : base("CommonControls_ProductReminderDisplay_ascx")
    {
    }
    DateTime CompareDate = ((DateTime.Today).AddDays(1)).AddDays(3);
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void LoadData()
    {

        SharedInventory_BL inventoryBL = new SharedInventory_BL(base.ContextInfo);
        List<Products> lstInventoryProducts = new List<Products>();
        //inventoryBL.GetProductMaintenanceReminderDetail(OrgID, ILocationID, InventoryLocationID, out lstInventoryProducts);
        if (lstInventoryProducts.Count > 0)
        {
            lblRemainderDetail.Visible = true;
            gvRemainder.DataSource = lstInventoryProducts;
            gvRemainder.DataBind();
        }
        else
        {
            lblRemainderDetail.Visible = false;
        }
           

    }
    protected void gvRemainder_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        
    }
    protected void gvRemainder_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Products RM = (Products)e.Row.DataItem;
            if (RM.NextMaintenanceDate <= CompareDate)
            {
                e.Row.BackColor = System.Drawing.Color.MediumPurple;
            }
        }
    }
}
