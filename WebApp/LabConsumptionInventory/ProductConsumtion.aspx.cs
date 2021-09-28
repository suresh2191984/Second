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
public partial class LabConsumptionInventory_ProductConsumtion : Attune_BasePage
{
    public LabConsumptionInventory_ProductConsumtion()
        : base("LabConsumptionInventory_ProductConsumtion_aspx")
    { }
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnOrgid.Value = Convert.ToString(OrgID);
        if (!IsPostBack)
        {
            txtFrom.Text = DateTimeNow.ToExternalDate();
            txtTo.Text = DateTimeNow.ToExternalDate();
            txtFrom.Focus();
        }
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    //--------------- GetConsumptionFlex-------------
    #region GetConsumptionFlex [GetConsumptionFlex]
    [System.Web.Services.WebMethod]
    public static List<ProductConsumption> GetConsumptionFlexService(string ProductID, string Barcode, DateTime fromdate, DateTime todate)
    {

        List<ProductConsumption> lstconsumption = new List<ProductConsumption>();   
        LabConsumptionReports_BL ObjBAL = new LabConsumptionReports_BL(new Attune_BaseClass().ContextInfo);
        long lProductID;
    

        try
        {
            Int64.TryParse(ProductID, out lProductID);
            ObjBAL.GetConsumptionFlex(lProductID, Barcode, fromdate, todate, out lstconsumption);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetConsumptionFlex in WebService", ex);
        }

        return lstconsumption;
    }


    #endregion


    protected void btnsearch_Click(object sender, EventArgs e)
    {
      
        ScriptManager.RegisterStartupScript(this.Page, GetType(), "Javascript", "javascript:callWebservices(); ", true);
    }
}



 
