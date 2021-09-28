using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Configuration;
using Attune.Kernel.PlatForm.Base;

public partial class InventoryCommon_InventorySearch : Attune_BasePage
{
    public InventoryCommon_InventorySearch()
        : base("InventoryCommon_InventorySearch_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    //string type;
    protected void Page_Load(object sender, EventArgs e)
    {
    }
}
