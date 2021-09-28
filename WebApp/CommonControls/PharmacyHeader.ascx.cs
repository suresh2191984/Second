using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class CommonControls_PharmacyHeader : BaseControl
{
    public CommonControls_PharmacyHeader()
        : base("CommonControls_PharmacyHeader_ascx")
    {
    }
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    protected void Page_Load(object sender, EventArgs e)
    {
        lblName.Text = UserName;
        lblRolename.Text = RoleName.Trim();
        lblDepartmentName.Text = DepartmentName.Trim();

        new GateWay(base.ContextInfo).GetInventoryConfigDetails("Quick_Billing", OrgID, ILocationID, out lstInventoryConfig);
        if (lstInventoryConfig.Count > 0)
        {
            if (lstInventoryConfig[0].ConfigValue == "N")
            {
                imgbtnBilling.Visible = false;
            }
        }
        if (isCorporateOrg == "Y")
            imgbtnBilling.Visible = false;
        if (RoleName != "Inventory")
            imgbtnBilling.Visible = false;
        hdnpage.Value = "QuickBilling.aspx";



    }
    protected void ShowDepartment_Click(object sender, EventArgs e)
    {
        Department1.LoadLocationUserMap();
    }
    protected void btngoClick_Clisk(object sender, EventArgs e)
    {
        try
        {
            switch (hdnvalue.Value)
            {
                case "StockReport":
                    Response.Redirect("AdminStockReport.aspx", true);
                    break;
                case "StockIssue":
                    Response.Redirect("StockIssued.aspx", true);
                    break;
                case "QuickStockRec":
                    Response.Redirect("QuickStockReceived.aspx", true);
                    break;
                case "Dispensing":
                    Response.Redirect("DispensingReport.aspx", true);
                    break;
                default:
                    break;
            }


        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }
}
