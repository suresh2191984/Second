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

using Attune.Kernel.PlatForm.BL;

public partial class LabConsumptionInventory_MonthlyWasteageConsumption : Attune_BasePage
{
    public LabConsumptionInventory_MonthlyWasteageConsumption()
        : base("LabConsumptionInventory_MonthlyWasteageConsumption_aspx")
    { }
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnOrgid.Value = Convert.ToString(OrgID);
        txtFrom.Text = DateTimeNow.ToExternalDate();
        txtTo.Text = DateTimeNow.ToExternalDate();
        txtFrom.Focus();
       
    }


    //--------------- Monthly Wastage Report-------------
    #region MonthlyWastageReport [MonthlyWastageReport]
    [System.Web.Services.WebMethod]
    public static List<ProductConsumption> MonthlyWastageReport(string ProductID, DateTime fromdate, DateTime todate)
    {
     
        List<ProductConsumption> lstconsumption = new List<ProductConsumption>();
        LabConsumptionReports_BL ObjBAL = new LabConsumptionReports_BL(new Attune_BaseClass().ContextInfo);
        long lProductID;
        try
        {
            Int64.TryParse(ProductID, out lProductID);
            ObjBAL.GetMonthlyWastageReport(lProductID, fromdate, todate, out lstconsumption);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetStockConsumption in WebService", ex);
        }

        return lstconsumption;
    }


    #endregion
    
}
