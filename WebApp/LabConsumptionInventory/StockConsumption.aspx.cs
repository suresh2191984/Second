using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.LabConsumptionInventory.BL;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Utility;
using System.Web.Script.Serialization;

public partial class LabConsumptionInventory_StockConsumption : Attune_BasePage
{
    public LabConsumptionInventory_StockConsumption()
        : base("LabConsumptionInventory_StockConsumption_aspx")
    { }
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnOrgid.Value = Convert.ToString(OrgID);
        txtFrom.Text = DateTimeNow.ToExternalDate();
        txtTo.Text = DateTimeNow.ToExternalDate();
        txtFrom.Focus();
    }

    //--------------- GetStockConsumption-------------
    #region GetConsumptionFlex [GetConsumptionFlex]
    [System.Web.Services.WebMethod]
    public static List<ProductConsumption> GetStockConsumption(string ProductID, DateTime fromdate, DateTime todate)
    {
       
        List<ProductConsumption> lstconsumption = new List<ProductConsumption>();
        LabConsumptionReports_BL ObjBAL = new LabConsumptionReports_BL(new Attune_BaseClass().ContextInfo);
        long lProductID;

        try
        {  
            Int64.TryParse(ProductID, out lProductID);
            ObjBAL.GetStockConsumption(lProductID, fromdate, todate, out lstconsumption);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetStockConsumption in WebService", ex);
        }

        return lstconsumption;
    }


    #endregion

}
