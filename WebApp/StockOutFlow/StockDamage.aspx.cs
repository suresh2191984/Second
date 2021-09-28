using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Globalization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.InventoryCommon;
using System.Web.Script.Serialization;

public partial class StockOutFlow_StockDamage :Attune_BasePage 
{
    public StockOutFlow_StockDamage()
        : base("StockOutFlow_StockDamage_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryCommon_BL inventoryBL ;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);

        AutoCompleteProduct.ContextKey = InventoryLocationID.ToString();

        if (!IsPostBack)
        {
            try
            {
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                List<ProductCategories> lstProductCategories = new List<ProductCategories>();
                txtStockDamageDate.Text = DateTimeNow.ToExternalDate();
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ExpiryDateLevel", OrgID, ILocationID, out lstInventoryConfig);
                txtreturnstock.Attributes.Add("ReadOnly", "ReadOnly");
                if (lstInventoryConfig.Count > 0)
                {
                    if (lstInventoryConfig[0].ConfigValue != null && lstInventoryConfig[0].ConfigValue != "")
                    {
                        string ExpiryDateLevel = lstInventoryConfig[0].ConfigValue;
                        hdnExpiryDateLevel.Value = ExpiryDateLevel;
                        string sExpired = Resources.StockOutFlow_ClientDisplay.StockOutFlow_StockDamage_aspx_01;
                        if (sExpired == null)
                        {
                            sExpired = "Expired With in";
                        }
                        string sMonths = Resources.StockOutFlow_ClientDisplay.StockOutFlow_StockDamage_aspx_02;
                        if (sMonths == null)
                        {
                            sMonths = "Month(s)";
                        }
                        lblExpLevel.Text = sExpired + " " + ExpiryDateLevel + " " + sMonths;
                        txtExpiredColor.CssClass = "grdcheck";
                    }
                }
                
               
            }

            catch (Exception ex)
            {
                CLogger.LogError("Error in Page Load - StockDamage.aspx", ex);
            }
        }
    }



    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Attune_Navigation navigation = new Attune_Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    protected void btnReturnStock_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        long pSDNo = -1;
        try
        {
            StockOutFlow objStockOutFlow = new StockOutFlow();
            StockOutFlowDetails objStockOutFlowDetails = new StockOutFlowDetails();
            List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
            objStockOutFlow.CreatedBy = LID;
            objStockOutFlow.Description = txtComments.Text.Trim();
            objStockOutFlow.StockOutFlowTypeID = (int)StockOutFlowType.StockDamage;
            objStockOutFlow.LocationID = InventoryLocationID;

            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Stock_Damage_Approval", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    objStockOutFlow.Status = StockOutFlowStatus.Pending;
                }
                else
                {
                    objStockOutFlow.Status = StockOutFlowStatus.Approved;
                }
            }
            else
            {
                objStockOutFlow.Status = StockOutFlowStatus.Approved;
            }

            objStockOutFlow.OrgAddressID = ILocationID;
            objStockOutFlow.OrgID = OrgID;
            lstInventoryItemsBasket =GetCollectedItems();
            
            if (lstInventoryItemsBasket.Count ==0)
            {
                return;
            }
            returnCode = inventoryBL.SaveStockOutFlow(objStockOutFlow, lstInventoryItemsBasket, out pSDNo);
            if (returnCode == 0)
            {
                Response.Redirect(@"../StockOutFlow/ViewStockDamage.aspx?ID=" + pSDNo + "", true);//kumaresan
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Stock Damage Details.", ex);
        }
    }
    private List<InventoryItemsBasket> GetCollectedItems()
    {

        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

        var ListItemBasket = new JavaScriptSerializer().Deserialize<List<InventoryItemsBasket>>(hdnProductList.Value);

        lstInventoryItemsBasket = (from c in ListItemBasket
                                         select new InventoryItemsBasket
                                         {
                                             ID = c.ID,
                                             ProductID = c.ProductID,
                                             ProductName = c.ProductName,
                                             BatchNo = c.BatchNo,
                                             Quantity = c.Quantity,
                                             Unit = c.Unit,
                                             ComplimentQTY = 0, // c.InHandQuantity,
                                             Amount = (c.Quantity * c.UnitPrice),
                                             Rate = c.Rate,
                                             Tax = c.Tax,
                                             ExpiryDate = c.ExpiryDate,
                                             CategoryID = c.CategoryID,
                                             Manufacture = DateTimeUtility.GetServerDate(),
                                             Providedby = c.ID,
                                             UnitPrice = c.UnitPrice,
                                             ParentProductID = c.ParentProductID,
                                             MRP = c.MRP,
                                             ProductReceivedDetailsID = c.ProductReceivedDetailsID,
                                             ReceivedUniqueNumber=c.ReceivedUniqueNumber,
                                             StockReceivedBarcodeDetailsID =c.StockReceivedBarcodeDetailsID,
                                             BarcodeNo=c.BarcodeNo
                                         }).ToList();
        return lstInventoryItemsBasket;
    }

}
