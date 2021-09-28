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
using Attune.Kernel.StockIndent.BL;
using Attune.Kernel.InventoryCommon;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PerformingNextAction;
using System.Web.Script.Serialization;

public partial class Inventory_StockIssued : Attune_BasePage
{
    public Inventory_StockIssued()
        : base("Inventory_StockIssued_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    //long TaskID = 0;
    string TrustedOrg = string.Empty;
    InventoryCommon_BL inventoryBL;
    int ReceivedOrgID = -1;
    int ReceivedOrgAddID = -1;
    List<Organization> lstTrustOrg = new List<Organization>();
    List<Organization> lstTrustOrgFindOrgAddid = new List<Organization>();
    List<Organization> lstorgn = new List<Organization>();
    List<Locations> lstloc = new List<Locations>();
    List<Locations> lstparentloc = new List<Locations>();
    string Status = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                ddlLocation.Focus();
                lblDate.Text = DateTimeUtility.GetServerDate().ToExternalDate();
                //Arun
                txtreturnstock.Attributes.Add("ReadOnly", "ReadOnly");
                //End
                int pOrgAddid = ILocationID;
                if (isCorporateOrg == "Y")
                {
                    hdnIsCorpOrg.Value = isCorporateOrg;
                    tdReceivedBy.Attributes.Add("class", "displaytd");
                    tdddlUser.Attributes.Add("class", "displaytd");  
                }
                trTrusted.Attributes.Add("class", "displaytr");
                LoadOrgan();
                BindConsumedBy();
                hdnLocationId.Value = InventoryLocationID.ToString();
                hndPageId.Value = PageID.ToString();
                hdnLoginid.Value = LID.ToString();
                hdnOrgId.Value = OrgID.ToString();
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ExpiryDateLevel", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    if (lstInventoryConfig[0].ConfigValue != null && lstInventoryConfig[0].ConfigValue != "")
                    {
                        string ExpiryDateLevel = lstInventoryConfig[0].ConfigValue;
                        string sExpLevel = Resources.StockIntend_ClientDisplay.StockIntend_StockIssued_aspx_01 != null ? Resources.StockIntend_ClientDisplay.StockIntend_StockIssued_aspx_01 : "Expired With in {0}  Month(s)";
                        string.Format(sExpLevel, ExpiryDateLevel);
                        hdnExpiryDateLevel.Value = ExpiryDateLevel;
                        lblExpLevel.Text = sExpLevel; //"Expired With in " + ExpiryDateLevel + " Month(s)";
                        txtExpiredColor.CssClass = "grdcheck";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - StockIssued.aspx", ex);
            ////ErrorDisplay1.ShowError = true;
            ////ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }


    private void LoadOrgan()
    {
        TrustedOrg_BL lstTrustedOrg = new TrustedOrg_BL(base.ContextInfo);
        lstTrustedOrg.GetSharingOrgList(OrgID, out lstorgn, out lstloc);
        ddlTrustedOrg.DataSource = lstorgn;
        ddlTrustedOrg.DataTextField = "Name";
        ddlTrustedOrg.DataValueField = "OrgID";
        ddlTrustedOrg.DataBind();
        ddlTrustedOrg.Items.Insert(0, GetMetaData("Select", "0"));
        ddlTrustedOrg.Items[0].Value = "0";

        ddlLocation.Items.Insert(0, GetMetaData("Select", "0"));
        ddlLocation.Items[0].Value = "0";

        if (Request.QueryString["IsTransfer"] != null)
        {
            if (Request.QueryString["IsTransfer"] == "Y")
            {
                ddlTrustedOrg.SelectedValue = OrgID.ToString();
                ddlTrustedOrg.Enabled = false;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadlocation", "Javascript:GetLocationlist_new();", true);
            }
        }
        else
        {

            if (lstorgn.Count == 1)
            {
                ddlTrustedOrg.SelectedValue = OrgID.ToString();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadlocation", "Javascript:GetLocationlist_new();", true);
            }

        }

        #region Set Default ParentOrgID (used old config itself)
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedTo_Show_All_VAT_Percentage", OrgID, ILocationID, out lstInventoryConfig);
        if (lstInventoryConfig.Count > 0)
        {
            if (lstInventoryConfig[0].ConfigValue == "Y")
            {
                if (lstorgn != null && lstorgn.Count > 0 && !string.IsNullOrEmpty(lstorgn[0].ParentOrgID.ToString()))
                {
                    ddlTrustedOrg.SelectedValue = lstorgn[0].ParentOrgID.ToString();
                }
            }
        }
        #endregion
        lstloc.RemoveAll(p => p.LocationID == InventoryLocationID);
        foreach (var item in lstloc)
        {
            hdnlocation.Value += item.OrgID + "~" + item.LocationID + "~" + item.LocationName + "^";

        }

    }

    private void BindConsumedBy()
    {
        List<Users> lstUsers = new List<Users>();
        long iOrgID = Int64.Parse(OrgID.ToString());
        int SelectUserOrg = -1;
        long returnCode = -1;

        returnCode = new Master_BL(this.ContextInfo).GetListOfUsers(OrgID, out lstUsers);
        SelectUserOrg = Convert.ToInt32(ddlTrustedOrg.SelectedValue) > 0 ? Convert.ToInt32(ddlTrustedOrg.SelectedValue) : OrgID;

        foreach (var item in lstUsers)
        {
            hdnUserlist.Value += item.Name + "~" + item.UserID + "~" + item.OrgID + "^";

        }
        ddlUser.Items.Insert(0, GetMetaData("Select", "0"));
    }
    protected void btnStockIssued_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        long IndID = -1;
        long pId = -1;
        long intendID = 0;

        try
        {
            StockReceived objLocationStockInHand = new StockReceived();
            List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
            objLocationStockInHand.Comments = txtComments.Text.Trim();
            objLocationStockInHand.CreatedBy = LID;
            objLocationStockInHand.FromLocationID = int.Parse(hdnFromLocationID.Value);
            objLocationStockInHand.IssuedTO = Int64.Parse(hdnUserID.Value);
            objLocationStockInHand.OrgID = OrgID;
            objLocationStockInHand.OrgAddressID = ILocationID;
            objLocationStockInHand.ToLocationID = InventoryLocationID;
            if (Request.QueryString["intID"] != null)
            {
                Int64.TryParse(Request.QueryString["intID"], out intendID);
                objLocationStockInHand.IndentID = intendID;
                hdnIntendID.Value = intendID.ToString();
            }
            else
            {
                objLocationStockInHand.IndentID = intendID;
                hdnIntendID.Value = intendID.ToString();
            }
            lstInventoryItemsBasket = GetCollectedItems();
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_intend_Received", OrgID, ILocationID, out lstInventoryConfig);
            objLocationStockInHand.Status = StockOutFlowStatus.Received;
            StockIndent_BL stockBL = new StockIndent_BL(base.ContextInfo);
            ReceivedOrgID = Convert.ToInt16(ddlTrustedOrg.SelectedItem.Value);
            int StockReceivedTypeID = (int)StockReceivedTypes.FromStore;
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    objLocationStockInHand.Status = StockOutFlowStatus.Issued;
                    returnCode = inventoryBL.SaveStockIssue(objLocationStockInHand, lstInventoryItemsBasket, ReceivedOrgID, ReceivedOrgAddID, out pId, out IndID, out Status);
                }
                else
                {
                    objLocationStockInHand.Status = StockOutFlowStatus.Received;
                    returnCode = stockBL.SaveStockIssueToLocation(objLocationStockInHand, lstInventoryItemsBasket, ReceivedOrgID, ReceivedOrgAddID, StockReceivedTypeID, out pId, out IndID, out Status);

                }
            }
            else
            {

                returnCode = stockBL.SaveStockIssueToLocation(objLocationStockInHand, lstInventoryItemsBasket, ReceivedOrgID, ReceivedOrgAddID, StockReceivedTypeID, out pId, out IndID, out Status);


            }
            if (returnCode > 0)
            {
                RemoveDrafts();
                IndID = returnCode > 0 ? returnCode : IndID;

                if (Request.QueryString["IsTransfer"] != null)
                {
                    Response.Redirect(@"../StockIntend/ViewIssuedIndentdetails.aspx?IsTransfer=Y&ID=" + pId + "&intID=" + IndID + "&Status=" + Status, true);

                }
                else
                {

                    Response.Redirect(@"../StockIntend/ViewIssuedIndentdetails.aspx?ID=" + pId + "&intID=" + IndID + "&Status=" + Status, true);
                }
            }
            else {
                string sError = Resources.StockIntend_ClientDisplay.StockIntend_StockIssued_aspx_04 != null ? Resources.StockIntend_ClientDisplay.StockIntend_StockIssued_aspx_04 : "Error";
                string sMsg = Resources.StockIntend_ClientDisplay.StockIntend_StockIssued_aspx_03 != null ? Resources.StockIntend_ClientDisplay.StockIntend_StockIssued_aspx_03 : "There is no sufficient Qty to Issue stock..!";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ValidationWindow(" + sMsg + "," + sError + ");", true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Stock Return Details.", ex);
            ////ErrorDisplay1.ShowError = true;
            ////ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    private void RemoveDrafts()
    {
        InventoryCommon_BL objDraft = new InventoryCommon_BL();
        string DraftData = ddlTrustedOrg.SelectedItem.Value + "|" + hdnFromLocationID.Value;
        objDraft.DeleteDraft(OrgID, InventoryLocationID, Convert.ToInt32(PageID), LID, "StockIssued", DraftData);
    }

    private List<InventoryItemsBasket> GetCollectedItems()
    {

        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

        var ListItemBasket = new JavaScriptSerializer().Deserialize<List<InventoryItemsBasket>>(hdnProductList.Value);

        lstInventoryItemsBasket = (from c in ListItemBasket
                                         select new InventoryItemsBasket
                                         {
                                             ID = c.ProductReceivedDetailsID,
                                             ProductID = c.ProductID,
                                             ProductName = c.ProductName,
                                             BatchNo = c.BatchNo,
                                             Quantity = c.Quantity,
                                             Unit = c.Unit,
                                             ComplimentQTY = c.InHandQuantity,
                                             Amount = (c.Quantity * c.Rate),
                                             Rate = c.Rate,
                                             Tax = c.Tax,
                                             ExpiryDate = c.ExpiryDate,
                                             Manufacture = DateTimeUtility.GetServerDate(),
                                             Providedby = c.ID,
                                             UnitPrice = c.UnitPrice,
                                             ParentProductID = c.ParentProductID,
                                             MRP = c.MRP,
                                             ProductReceivedDetailsID = c.ProductReceivedDetailsID,
                                             ReceivedUniqueNumber = c.ReceivedUniqueNumber,                                       
                                             StockReceivedBarcodeDetailsID = c.StockReceivedBarcodeDetailsID ,                                   
                                             BarcodeNo = c.BarcodeNo
                                         }).ToList();

        //foreach (string listParent in hdnProductList.Value.Split('^'))
        //{
        //    if (listParent != "")
        //    {
        //        string Isreimbursable = string.Empty;
        //        InventoryItemsBasket newBasket = new InventoryItemsBasket();
        //        string[] listChild = listParent.Split('~');
        //        if (Request.QueryString["IsTransfer"] != null)
        //        {
        //            if (Request.QueryString["IsTransfer"] == "Y")
        //            {
        //                newBasket.CategoryID = Convert.ToInt32(StockOutFlowType.StockTransfer);
        //                newBasket.Description = "Stock Transfer";

        //            }
        //        }
        //        newBasket.ID = Convert.ToInt64(listChild[0]);
        //        newBasket.ProductName = listChild[1];
        //        newBasket.BatchNo = listChild[2];
        //        newBasket.Quantity = Convert.ToDecimal(listChild[3]);
        //        newBasket.Unit = listChild[4];
        //        newBasket.ComplimentQTY = Convert.ToDecimal(listChild[5]);
        //        newBasket.ProductID = Convert.ToInt64(listChild[6]);
        //        newBasket.Amount = Convert.ToDecimal(listChild[3]) * Convert.ToDecimal(listChild[7]);
        //        newBasket.Rate = Convert.ToDecimal(listChild[7]);
        //        newBasket.Tax = Convert.ToDecimal(listChild[8]);
        //        newBasket.ExpiryDate = DateTime.Parse(listChild[9] == "**" ? "01/01/1753" : listChild[9]);
        //        newBasket.Manufacture = DateTimeUtility.GetServerDate();
        //        newBasket.AttributeDetail = "N";
        //        newBasket.UnitPrice = Convert.ToDecimal(listChild[12]);
        //        string ProductKey = string.Empty;
        //        string CurrentCulture = string.Empty;
        //        //CurrentCulture = CultureInfo.CurrentCulture.Name;
        //        //if (CurrentCulture != "en-GB")
        //        //{

        //        //    Attune_InventoryProductKey.GenerateProductKey(newBasket.ProductID, newBasket.BatchNo, newBasket.ExpiryDate, newBasket.UnitPrice, newBasket.Rate, newBasket.Unit, CurrentCulture, out ProductKey);
        //        //    if (ProductKey != "")
        //        //    {
        //        //        newBasket.ProductKey = ProductKey;
        //        //    }
        //        //}
        //        //else
        //        //{
        //        //    newBasket.ProductKey = newBasket.ProductID + "@#$" + newBasket.BatchNo + "@#$" + newBasket.ExpiryDate.ToString("MMM/yyyy")
        //        //                    + "@#$" + String.Format("{0:0.000000}", newBasket.UnitPrice) + "@#$" + String.Format("{0:0.000000}", newBasket.Rate) + "@#$" + newBasket.Unit;
        //        //}
        //        newBasket.ParentProductID = Convert.ToInt64(listChild[13] == null ? "0" : listChild[13]);
        //        //newBasket.ParentProductKey = "";
        //        if (listChild[15] != "")
        //        {
        //            newBasket.ProductReceivedDetailsID = Convert.ToInt64(listChild[15]);
        //        }
        //        lstInventoryItemsBasket.Add(newBasket);
        //    }
        //}
        return lstInventoryItemsBasket;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            hdnlocation.Value = "";
            hdnUserlist.Value = "";
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

    public long SendSMS()
    {
        long retrunCode = -1;
        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
        ActionManager am = new ActionManager(base.ContextInfo);
        List<NotificationAudit> NotifyAudit = new List<NotificationAudit>();
        PageContextkey PC = new PageContextkey();


        PC.RoleID = Convert.ToInt64(RoleID);
        PC.PatientID = Convert.ToInt16(ddlLocation.SelectedItem.Value) == 0 ? Convert.ToInt16(Request.QueryString["LocationID"]) : Convert.ToInt16(ddlLocation.SelectedItem.Value);
        PC.OrgID = OrgID;
        PC.ButtonName = btnSubmit.ID;
        PC.ButtonValue = btnSubmit.Text;
        PC.ID = Convert.ToInt64(hdnIntendID.Value);
        PC.ContextType = "Issue";

        lstpagecontextkeys.Add(PC);
        retrunCode = am.PerformingMultipleNextStep(lstpagecontextkeys);
        return retrunCode;
    }

}

