using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BloodBank_Home : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (InventoryLocationID == -1)
            {
                Department1.LoadLocationUserMap();
            }
        }
    }
   
}
