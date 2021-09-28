using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;

public partial class Cashier_Home : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (InventoryLocationID == -1)
            {
                Department1.LoadLocationUserMap();
            }
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new GateWay(base.ContextInfo).GetInventoryConfigDetails("IsPharmacisitCashier", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                TaskControl1.ChkBoxServiceNo.Style.Add("display", "block");
            }
            else
            {
                TaskControl1.ChkBoxServiceNo.Style.Add("display", "none");
            }
        }
        
    }
}
