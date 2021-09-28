using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Data;
using System.Xml;
using System.IO;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.Utility;
using System.Web.Script.Serialization;

public partial class StockOutFlow_StockUsage : Attune_BasePage
{

    public StockOutFlow_StockUsage()
        : base("StockOutFlow_StockUsage_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    InventoryCommon_BL inventoryBL;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            try
            {
                inventoryBL = new InventoryCommon_BL(base.ContextInfo);
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                List<ProductCategories> lstProductCategories = new List<ProductCategories>();
                txtStockDamageDate.Text = DateTimeNow.ToExternalDate();
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ExpiryDateLevel", OrgID,ILocationID, out lstInventoryConfig);
                LoadMetaData();
                txtreturnstock.Attributes.Add("ReadOnly", "ReadOnly");
                
                if (lstInventoryConfig.Count > 0)
                {
                    if (lstInventoryConfig[0].ConfigValue != null && lstInventoryConfig[0].ConfigValue != "")
                    {
                        if (lstInventoryConfig[0].ConfigValue.Split('-')[0] != null && lstInventoryConfig[0].ConfigValue.Split('-')[0] != "")
                        {
                            string ExpiryDateLevel = lstInventoryConfig[0].ConfigValue.Split('-')[0];
                            hdnExpiryDateLevel.Value = ExpiryDateLevel;
                            string sExpired = Resources.StockOutFlow_ClientDisplay.StockOutFlow_StockUsage_aspx_01;
                            if (sExpired == null)
                            {
                                sExpired = "Expired With in";
                            }
                            string sMonths = Resources.StockOutFlow_ClientDisplay.StockOutFlow_StockUsage_aspx_02;
                            if (sMonths == null)
                            {
                                sMonths = "Month(s)";
                            }
                            lblExpLevel.Text = sExpired+" " + ExpiryDateLevel +" "+ sMonths;
                            txtExpiredColor.CssClass = "grdcheck w-10";
                        }

                    }
                }
                LoadSublocation();

            }

            catch (Exception ex)
            {
                CLogger.LogError("Error while  executing Page_Load in StockUsage", ex);
               // CLogger.LogError("Error in Page Load - StockDamage.aspx", ex);
               // ErrorDisplay1.ShowError = true;
               // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            }
        }
    }

    public void LoadMetaData()
    {

        long returncode = -1;
        string LangCode = LanguageCode;

        List<MetaData> lstMetadataInput = new List<MetaData>();
        List<MetaData> lstMetadataOutput = new List<MetaData>();



        try
        {
            lstMetadataInput.Add(new MetaData() { Domain = "StockFrequency" });
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstMetadataInput, OrgID, LangCode, out lstMetadataOutput);

            if (lstMetadataInput.Count > 0)
            {
                var lstStockFrequency = from child in lstMetadataOutput
                                        where child.Domain == "StockFrequency"
                                        select child;
                rblStockTakingFrequency.DataTextField = "DisplayText";
                rblStockTakingFrequency.DataValueField = "Code";

                rblStockTakingFrequency.DataSource = lstStockFrequency;
                rblStockTakingFrequency.DataBind();
                rblStockTakingFrequency.Items.Add("None");
                
                for (int i = 0; i < rblStockTakingFrequency.Items.Count; i++)
                {
                    if (rblStockTakingFrequency.Items.Count == i-1)
                    {
                        rblStockTakingFrequency.Items[i].Selected = true;
                    }
                }
                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While load the value for StockFrequency Item from Metadata", ex);
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
            objStockOutFlow.StockOutFlowTypeID = (int)StockOutFlowType.StockUsage;
            if (rdbtnisDevice.Checked == true)
            {
                objStockOutFlow.LocationID = Convert.ToInt32(ddlSublocation.SelectedValue);
            }
            else
            {
                objStockOutFlow.LocationID = InventoryLocationID;
            }
                    objStockOutFlow.Status = StockOutFlowStatus.Approved;
            objStockOutFlow.OrgAddressID = ILocationID;
            objStockOutFlow.OrgID = OrgID;
            lstInventoryItemsBasket = GetCollectedItems();
            inventoryBL = new InventoryCommon_BL();
            if (lstInventoryItemsBasket.Count == 0)
            {
              //  ErrorDisplay1.ShowError = true;
              //  ErrorDisplay1.Status = "Please Check Items Added/Quantity entered properly.";
                return;
            }
            returnCode = inventoryBL.SaveStockOutFlow(objStockOutFlow, lstInventoryItemsBasket, out pSDNo);
            if (returnCode == 0)
            {
                Response.Redirect(@"../StockOutFlow/ViewStockNonUsage.aspx?ID=" + pSDNo + "", true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  executing btnReturnStock_Click in StockUsage", ex);
            //CLogger.LogError("Error While Saving Stock Damage Details.", ex);
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    private List<InventoryItemsBasket> GetCollectedItems()
    {

        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        try
        {
            if (!string.IsNullOrEmpty(hdnProductList.Value))
            {
                var ListTempQuick = new JavaScriptSerializer().Deserialize<List<TempStockUsage>>(hdnProductList.Value);
                lstInventoryItemsBasket = (from c in ListTempQuick
                                           select new InventoryItemsBasket
                                           {
                                               ProductID = c.ProductID,
                                               ProductName = c.ProductName,
                                               BatchNo = c.BatchNo, 
                                               Manufacture=DateTime.Now,
                                               ExpiryDate = string.IsNullOrEmpty(c.ExpiryDate) ? DateTime.Parse("01/01/1753") : DateTime.Parse(c.ExpiryDate),
                                               Quantity = c.Quantity,
                                               Unit = c.Unit,                                               
                                               ComplimentQTY = 0, 
                                               Amount = c.Quantity * c.Rate,
                                               UnitCostPrice = c.UnitPrice,
                                               Rate = c.Rate,                                           
                                               Tax = c.Tax,
                                               UnitPrice = c.UnitPrice,
                                               AttributeDetail = "N",
                                               ProductReceivedDetailsID=c.ProductReceivedDetailsID,
                                               ID=c.ID,
                                               ReceivedUniqueNumber=c.ReceivedUniqueNumber,
                                               StockReceivedBarcodeDetailsID = c.StockReceivedBarcodeDetailsID,
                                               BarcodeNo = c.BarcodeNo,
                                               Remarks=c.Remarks
                                           }).ToList();
            }
        
    /*    foreach (string listParent in hdnProductList.Value.Split('^'))
        {
            if (listParent != "")
            {
                string Isreimbursable = string.Empty;
                InventoryItemsBasket newBasket = new InventoryItemsBasket();
                string[] listChild = listParent.Split('~');
                newBasket.ID = Convert.ToInt64(listChild[0]);
                newBasket.ProductName = listChild[1];
                newBasket.BatchNo = listChild[2];
                newBasket.Quantity = Convert.ToDecimal(listChild[3]);
                newBasket.Unit = listChild[4];
                newBasket.ComplimentQTY = Convert.ToDecimal(listChild[5]);
                newBasket.ProductID = Convert.ToInt64(listChild[6]);
                newBasket.Amount = Convert.ToDecimal(listChild[3]) * Convert.ToDecimal(listChild[7]);
                newBasket.Rate = Convert.ToDecimal(listChild[7]);
                newBasket.Tax = Convert.ToDecimal(listChild[8]);
                newBasket.ExpiryDate = DateTime.Parse(listChild[9] == "**" ? "01/01/1753" : listChild[9]);
                newBasket.Manufacture = DateTimeNow;
                newBasket.AttributeDetail = "N";
                newBasket.UnitPrice = Convert.ToDecimal(listChild[12]);
                newBasket.ProductKey = newBasket.ProductID + "@#$" + newBasket.BatchNo + "@#$" + newBasket.ExpiryDate.ToString("MMM/yyyy")
                                + "@#$" + String.Format("{0:0.000000}",newBasket.UnitPrice) + "@#$" + String.Format("{0:0.000000}",newBasket.Rate) + "@#$" + newBasket.Unit;

                lstInventoryItemsBasket.Add(newBasket);
            }
        }*/
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at: StockUsage GetCollectedItems Message:", ex);
        }
        return lstInventoryItemsBasket;
    }

    private void LoadSublocation()
    {
        TrustedOrg_BL inventoryBL1 = new TrustedOrg_BL(base.ContextInfo);
        List<Organization> lstorgn = new List<Organization>();
        List<Locations> lstloc = new List<Locations>();
        inventoryBL1.GetSharingOrgList(OrgID, out lstorgn, out lstloc);
        var lstsublocation = lstloc.FindAll(P => P.ParentLocationID == InventoryLocationID);
        ddlSublocation.DataSource = lstsublocation;
        ddlSublocation.DataTextField = "LocationName";
        ddlSublocation.DataValueField = "LocationID";
        ddlSublocation.DataBind();
        ddlSublocation.Items.Insert(0, GetMetaData("Select", "0"));
        if (lstsublocation.Count > 1)
        {
            rdbtns.Attributes.Add("class", "hide");
            trsublocation.Attributes.Add("class", "hide");
            divSubLoc.Attributes.Add("class", "hide");
        }
    }

    public class TempStockUsage
    {
        public long ID
        {
            get;
            set;
        }
        public long ProductID
        {
            get;
            set;
        }
        public string ProductName
        {
            get;
            set;
        }
        public string BatchNo
        {
            get;
            set;
        }

        public decimal Quantity
        {
            get;
            set;
        }

        public string Unit
        {
            get;
            set;
        }
        public decimal ComplimentQTY
        {
            get;
            set;
        }

        public decimal Rate
        {
            get;
            set;
        }

        public decimal Tax
        {
            get;
            set;
        }

        public string ExpiryDate
        {
            get;
            set;
        }
        public string HasBatchNo
        {
            get;
            set;
        }
        public string HasExpiryDate
        {
            get;
            set;
        }

        public decimal UnitPrice
        {
            get;
            set;
        }

        public long ProductReceivedDetailsID
        {
            get;
            set;
        }
        public long ReceivedUniqueNumber
        {
            get;
            set;
        }      
        public long StockReceivedBarcodeDetailsID
        {
            get;
            set;
        }
        public string BarcodeNo
        {
            get;
            set;
        }
        public string Remarks
        {
            get;
            set;
        }
    }

}
