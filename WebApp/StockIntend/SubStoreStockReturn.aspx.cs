using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Text;
using System.IO;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PerformingNextAction;
using Attune.Kernel.PlatForm.Common;
using System.Web.Script.Serialization;


public partial class StockIntend_SubStoreStockReturn :Attune_BasePage 
{
    public StockIntend_SubStoreStockReturn()
        : base("StockIntend_SubStoreStockReturn_aspx")
    {
    }
    long TaskID = 0;
    string TrustedOrg = string.Empty;
    InventoryCommon_BL inventoryBL;
    int ReceivedOrgID = -1;
    int ReceivedOrgAddID = -1;
    List<Organization> lstTrustOrg = new List<Organization>();
    List<StockOutFlowTypes> lstStockOutFlowTypes = new List<StockOutFlowTypes>();
    List<Organization> lstTrustOrgFindOrgAddid = new List<Organization>();
    List<Organization> lstorgn = new List<Organization>();
    List<Locations> lstloc = new List<Locations>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<InventoryConfig> lstInventoryConfig1 = new List<InventoryConfig>();

    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);

        if (!IsPostBack)
        {
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            ddlLocation.Focus();
            lblDate.Text = DateTimeNow.ToExternalDateTime().ToString();
                    
                int pOrgAddid = ILocationID;
               // hdnTrustedOrg.Value = "Y";
               //trTrusted.Style.Add("display", "block");
                trTrusted.Attributes.Add("class", "displaytr w-100p");
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ExpiryDateLevel", OrgID, ILocationID, out lstInventoryConfig);

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
                                sExpired = "Expires With in";
                            }
                            string sMonths = Resources.StockOutFlow_ClientDisplay.StockOutFlow_StockUsage_aspx_02;
                            if (sMonths == null)
                            {
                                sMonths = "Month(s)";
                            }
                            lblExpLevel.Text = sExpired + " " + ExpiryDateLevel + " " + sMonths;
                            txtExpiredColor.CssClass = "grdcheck w-10";
                        }

                    }
                }
            //Arun
                txtreturnstock.Attributes.Add("ReadOnly", "ReadOnly");
          //end
            LoadOrgan();
            LoadSuppliers();
            BindConsumedBy();
           // LoadReason();
            LoaStockOutFlowType();
           tbSupplier.Visible = false;
            //Arun
           if (!ddlStockReturnType.SelectedItem.Equals(null))
           {
               AutoCompleteProduct.ContextKey = ddlStockReturnType.SelectedItem.Value;
           }
        //end
        }
    }
    public Hashtable GetReasonFORBind(Type StockReturnreason)
    {

        string[] reason = Enum.GetNames(StockReturnreason);
        Array values = Enum.GetValues(StockReturnreason);
        Hashtable ht = new Hashtable();
        
        for (int i = 0; i < reason.Length; i++)
        {
            if (reason[i] != "StockUsage" || reason[i] != "Adhoc" || reason[i] != "Adjustment" || reason[i] != "NonMovement")
            {
                ht.Add(Convert.ToInt32(values.GetValue(i)).ToString(), reason[i]);
            }
        }
        return ht;
    }
    private void LoadReason()
    {

        Hashtable ht = GetReasonFORBind(typeof(StockReturnReason));
        
           ddlStockReturn.DataSource = ht;
           ddlStockReturn.DataTextField="value";
           ddlStockReturn.DataValueField="key";
           ddlStockReturn.DataBind();
           ddlStockReturn.Items.Insert(0, GetMetaData("Select", "0"));
           ddlStockReturn.Items[0].Value = "0";
       
    }

    string strSelect = Resources.StockIntend_ClientDisplay.StockIntend_SubStoreStockReturn_aspx_01 == null ? "Select" : Resources.StockIntend_ClientDisplay.StockIntend_SubStoreStockReturn_aspx_01;

    public Hashtable GetStockOutFlowTyprBind(Type StockOutFlowType)
    {

        string[] reason1 = Enum.GetNames(StockOutFlowType);
        Array values = Enum.GetValues(StockOutFlowType);
        Hashtable ht1 = new Hashtable();
       
        for (int i = 0; i <= reason1.Length; i++)
        {
            StockOutFlowTypes SOFT = new StockOutFlowTypes();

            if (i == 0)
            {
                ht1.Add(0, strSelect);
                SOFT.StockOutFlowTypeId = i;
                SOFT.StockOutFlowType = strSelect;
            }
            else
            {
                
                ht1.Add(Convert.ToInt32(values.GetValue(i-1)).ToString(), reason1[i-1]);
                SOFT.StockOutFlowTypeId = i;
                SOFT.StockOutFlowType = reason1[i-1].ToString();
               
            }
            lstStockOutFlowTypes.Add(SOFT);
            
        }
     
        return ht1;
    }

   


    private void LoaStockOutFlowType()
    {

        Hashtable ht1 = GetStockOutFlowTyprBind(typeof(StockOutFlowType));
        //lstStockOutFlowTypes.RemoveAll(P => (P.StockOutFlowTypeId == 5) || (P.StockOutFlowTypeId == 6) );
        //Arun
        lstStockOutFlowTypes.RemoveAll(P => (P.StockOutFlowTypeId != 0) && (P.StockOutFlowTypeId != 3));
        //end
        ddlStockReturnType.DataSource = lstStockOutFlowTypes;
        ddlStockReturnType.DataTextField = "StockOutFlowType";
        ddlStockReturnType.DataValueField = "StockOutFlowTypeId";
        ddlStockReturnType.DataBind();
        
   
    }
    private void LoadOrgan()
    {

        TrustedOrg_BL lstTrustedOrg = new TrustedOrg_BL(base.ContextInfo);
        lstTrustedOrg.GetSharingOrgList(OrgID, out lstorgn, out lstloc);

        ddlTrustedOrg.DataSource = lstorgn;
        ddlTrustedOrg.DataTextField = "Name";
        ddlTrustedOrg.DataValueField = "OrgID";
        ddlTrustedOrg.DataBind();
        //Arun
        ListItem ddlselect = GetMetaData("All", "0");
               if (ddlselect == null)
               {
                   ddlselect = new ListItem() { Text ="All",Value ="0" };
               }
        ddlTrustedOrg.Items.Insert(0, ddlselect);
        //end
        //ddlTrustedOrg.Items.Insert(0, "--ALL--");
        ddlTrustedOrg.Items[0].Value = "0";
        ddlLocation.DataBind();
        //Arun
        ListItem ddllselect = GetMetaData("Select", "0");
        if (ddllselect == null)
        {
            ddllselect = new ListItem() { Text = "Select", Value = "0" };
        }
        ddlLocation.Items.Insert(0, ddllselect);
        //end
        //ddlLocation.Items.Insert(0, new ListItem("--Select--", "0"));
        lstloc.RemoveAll(P => (P.LocationID == InventoryLocationID));
        foreach (var item in lstloc)
        {
            hdnlocation.Value += item.OrgID + "~" + item.LocationID + "~" + item.LocationName + "^";

        }
    }

    private void BindConsumedBy()
    {
        InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        List<Users> lstUsers = new List<Users>();

        long iOrgID = Int64.Parse(OrgID.ToString());
        int SelectUserOrg = -1;
        long returnCode = -1;

        returnCode = new Master_BL(base.ContextInfo).GetListOfUsers(OrgID, out lstUsers);
        SelectUserOrg = Convert.ToInt32(ddlTrustedOrg.SelectedValue) > 0 ? Convert.ToInt32(ddlTrustedOrg.SelectedValue) : OrgID;

        foreach (var item in lstUsers)
        {
            hdnUserlist.Value += item.Name + "~" + item.UserID + "~" + item.OrgID + "^";

        }

        // lstUsers.FindAll(P => P.OrgID == SelectUserOrg);
        //ddlUser.DataSource = lstUsers;
        //ddlUser.DataTextField = "Name";
        //ddlUser.DataValueField = "LoginID";
        //ddlUser.DataBind();
        //Arun
        ListItem ddllselect = GetMetaData("Select", "0");
        if (ddllselect == null)
        {
            ddllselect = new ListItem() { Text = "Select", Value = "0" };
        } 
        ddlUser.Items.Insert(0, ddllselect);
        //end
    }


   

    private void LoadSuppliers()
    {
        try
        {
            inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);

            ddlSupplierList.DataSource = lstSuppliers;
            ddlSupplierList.DataTextField = "SupplierName";
            ddlSupplierList.DataValueField = "SupplierID";
            ddlSupplierList.DataBind();
            //Arun
            ListItem ddllselect = GetMetaData("Select", "0");
            if (ddllselect == null)
            {
                ddllselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlSupplierList.Items.Insert(0, ddllselect);
            //end    
            ddlSupplierList.Items[0].Value = "0";

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Suppliers Details", Ex);
        }

    }


    private void BindInventoryLocation()
    {
        InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);

        List<Locations> lstLocationName = new List<Locations>();
        try
        {
            long iOrgID = Int64.Parse(OrgID.ToString());
            //long returnCode = -1;
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = ILocationID;

            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Locations_BasedOn_Org", OrgID, ILocationID, out lstInventoryConfig);

            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    OrgAddid = 0;
                }
                else
                {
                    OrgAddid = ILocationID;
                }
            }
            lstLocationName.RemoveAll(P => P.LocationID == InventoryLocationID);
            ddlLocation.DataSource = lstLocationName;
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
            //Arun
            ListItem ddllselect = GetMetaData("Select", "0");
            if (ddllselect == null)
            {
                ddllselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlLocation.Items.Insert(0, ddllselect);
            //End
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - Sub-Store StockReturn.aspx", ex);
            
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        btnSubmit.Enabled = false;
        long returnCode = -1;
        long IndID = -1;
        long pId = -1;
        long intendID = 0;
        long pSDNo = -1;

        try
        {
         

            hdnFromLocationID.Value =hdnFromLocationID.Value ==""?"0":hdnFromLocationID.Value;

            if(int.Parse(hdnFromLocationID.Value)>0)
            {
           
                //StockReturnReason;
                StockReceived objLocationStockInHand = new StockReceived();
                List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
                InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);
                objLocationStockInHand.Comments = txtComments.Text.Trim();
                objLocationStockInHand.CreatedBy = LID;
                // objLocationStockInHand.FromLocationID = int.Parse(ddlLocation.SelectedValue);
                //objLocationStockInHand.IssuedTO = Int64.Parse(ddlUser.SelectedValue);
                objLocationStockInHand.FromLocationID = int.Parse(hdnFromLocationID.Value);
                //Arun
                //objLocationStockInHand.IssuedTO = Int64.Parse(hdnUserID.Value);
                //end
                objLocationStockInHand.OrgID = OrgID;
                objLocationStockInHand.OrgAddressID = ILocationID;
                objLocationStockInHand.ToLocationID = InventoryLocationID;
                if (Request.QueryString["intID"] != null)
                {
                    Int64.TryParse(Request.QueryString["intID"], out intendID);
                    objLocationStockInHand.IndentID = intendID;
                }
                else
                {
                    objLocationStockInHand.IndentID = intendID;
                }
                lstInventoryItemsBasket = GetCollectedItems();


                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();


                if (ddlStockReturnType.SelectedItem.Text == "StockIssued")
                {
                    new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_intend_Approval", OrgID, ILocationID, out lstInventoryConfig);
                }
                else if (ddlStockReturnType.SelectedItem.Text == "StockReturn")
                {
                    new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Stock_Return_Approval", OrgID, ILocationID, out lstInventoryConfig);
                }
                else if (ddlStockReturnType.SelectedItem.Text == "StockDamage")
                {

                    new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Stock_Damage_Approval", OrgID, ILocationID, out lstInventoryConfig);
                }
                else if (ddlStockReturnType.SelectedItem.Text == "ExpiryDate")
                {
                    new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Stock_Expired_Approval", OrgID, ILocationID, out lstInventoryConfig);

                    new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ExpiryDateLevel", OrgID, ILocationID, out lstInventoryConfig1);
                    if (lstInventoryConfig1.Count > 0)
                    {
                        if (lstInventoryConfig1[0].ConfigValue != null && lstInventoryConfig1[0].ConfigValue != "")
                        {
                            if (lstInventoryConfig1[0].ConfigValue.Split('-')[0] != null && lstInventoryConfig1[0].ConfigValue.Split('-')[0] != "")
                            {
                                string ExpiryDateLevel = lstInventoryConfig1[0].ConfigValue.Split('-')[0];
                                hdnExpiryDateLevel.Value = ExpiryDateLevel;
                                lblExpLevel.Text = "Expired With in " + ExpiryDateLevel + " Month(s)";
                                txtExpiredColor.CssClass = "grdcheck";
                            }

                        }
                    }
                
                
                
                }
                //Arun
                if (ddlStockReturnType.SelectedItem.Text == "StockReturn")
                {
                    objLocationStockInHand.Status = StockOutFlowStatus.Pending;
                }
                else
                {
                    objLocationStockInHand.Status = StockOutFlowStatus.Received;
                }
                //end
                ReceivedOrgID = Convert.ToInt16(ddlTrustedOrg.SelectedItem.Value);
                if (lstInventoryConfig.Count > 0)
                {
                    if (lstInventoryConfig[0].ConfigValue == "Y")
                    {
                        objLocationStockInHand.Status = StockOutFlowStatus.Issued;
						returnCode = inventoryBL.SubStoreStockIssue(objLocationStockInHand, lstInventoryItemsBasket, ReceivedOrgID, ReceivedOrgAddID, out pId, out IndID);
                      //  returnCode = inventoryBL.SaveStockIssue(objLocationStockInHand, lstInventoryItemsBasket, ReceivedOrgID, ReceivedOrgAddID, out pId, out IndID);
                    }
                    else
                    {
                        objLocationStockInHand.Status = StockOutFlowStatus.Received;
						returnCode = inventoryBL.SubStoreStockIssueToLocation(objLocationStockInHand, lstInventoryItemsBasket, ReceivedOrgID, ReceivedOrgAddID, out pId, out IndID);
                       // returnCode = inventoryBL.SaveStockIssueToLocation(objLocationStockInHand, lstInventoryItemsBasket, ReceivedOrgID, ReceivedOrgAddID, out pId, out IndID);

                    }
                }
                else
                {
					returnCode = inventoryBL.SubStoreStockIssueToLocation(objLocationStockInHand, lstInventoryItemsBasket, ReceivedOrgID, ReceivedOrgAddID, out pId, out IndID);
                    //returnCode = inventoryBL.SaveStockIssueToLocation(objLocationStockInHand, lstInventoryItemsBasket, ReceivedOrgID, ReceivedOrgAddID, out pId, out IndID);
                }
                if (returnCode > 0)
                {

                    IndID = returnCode > 0 ? returnCode : IndID;

                   // Response.Redirect(@"../Inventory/ViewIssuedIndentdetails.aspx?ID=" + pId + "&intID=" + IndID + "&Status=Issued", true);
                    //Arun
                    Response.Redirect(@"../StockIntend/ViewSubStoreStockdetails.aspx?ID=" + pId + "&intID=" + IndID + "&Status=Issued", true);
                    //end
                }
           
        }
            else
            {

                StockOutFlow objStockOutFlow = new StockOutFlow();
                StockOutFlowDetails objStockOutFlowDetails = new StockOutFlowDetails();
                List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
                objStockOutFlow.CreatedBy = LID;
                objStockOutFlow.ConsumedBy =LID.ToString();
                objStockOutFlow.Description = txtComments.Text.Trim();
                // objStockOutFlow.StockOutFlowTypeID = (int)StockOutFlowType.StockReturn;

                objStockOutFlow.StockOutFlowTypeID = int.Parse(ddlStockReturnType.SelectedItem.Value);
                objStockOutFlow.LocationID = InventoryLocationID; ;
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
             

                if (ddlStockReturnType.SelectedItem.Text == "StockReturn")
                {

                    new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Stock_Return_Approval", OrgID, ILocationID, out lstInventoryConfig);
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
                }

               else if (ddlStockReturnType.SelectedItem.Text == "StockDamage")
                {

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
                    objStockOutFlow.Status = StockOutFlowStatus.Approved;
                }
                else if (ddlStockReturnType.SelectedItem.Text == "ExpiryDate")
                {
                    new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Stock_Expired_Approval", OrgID, ILocationID, out lstInventoryConfig);
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

                    new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ExpiryDateLevel", OrgID, ILocationID, out lstInventoryConfig1);
                    if (lstInventoryConfig1.Count > 0)
                    {
                        if (lstInventoryConfig1[0].ConfigValue != null && lstInventoryConfig1[0].ConfigValue != "")
                        {
                            if (lstInventoryConfig1[0].ConfigValue.Split('-')[0] != null && lstInventoryConfig1[0].ConfigValue.Split('-')[0] != "")
                            {
                                string ExpiryDateLevel = lstInventoryConfig1[0].ConfigValue.Split('-')[0];
                                hdnExpiryDateLevel.Value = ExpiryDateLevel;
                                lblExpLevel.Text = "Expired With in " + ExpiryDateLevel + " Month(s)";
                                txtExpiredColor.CssClass = "grdcheck";
                            }

                        }
                    }
                }
                else if (ddlStockReturnType.SelectedItem.Text == "Disposal")
                {
                    new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Stock_Disposal_Approval", OrgID, ILocationID, out lstInventoryConfig);
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
                    objStockOutFlow.Status = StockOutFlowStatus.Approved;
                }

                objStockOutFlow.OrgAddressID = ILocationID;
                objStockOutFlow.OrgID = OrgID;
               // objStockOutFlow.SupplierID = 0;
               // objStockOutFlow.SupplierID = Convert.ToInt32(ddlSupplierList.SelectedValue)> 0 ? Convert.ToInt32(ddlSupplierList.SelectedValue) :0;
              
                lstInventoryItemsBasket = GetCollectedItems();

                if (lstInventoryItemsBasket.Count > 0)
                {

                    returnCode = inventoryBL.SaveStockOutFlow(objStockOutFlow, lstInventoryItemsBasket, out pSDNo);
                }
               

                if (returnCode == 0)
                {
                    if (ddlStockReturnType.SelectedItem.Text == "StockReturn")
                    {
                        Response.Redirect(@"../Inventory/ViewStockReturn.aspx?ID=" + pSDNo + "&PageName=StockReturn&StockOutFlowTypeID =" + ddlStockReturnType.SelectedItem.Value, true);
                    }

                    else if (ddlStockReturnType.SelectedItem.Text == "StockDamage")
                    {
                        Response.Redirect(@"../Inventory/ViewStockDamage.aspx?ID=" + pSDNo + "", true);
                    }

                    else if (ddlStockReturnType.SelectedItem.Text == "ExpiryDate")
                    {
                        Response.Redirect(@"../Inventory/ViewStockExpired.aspx?ID=" + pSDNo + "", true);
                    }
                    else if (ddlStockReturnType.SelectedItem.Text == "Disposal")
                    {
                        Response.Redirect(@"../Inventory/ViewStockDisposal.aspx?ID=" + pSDNo + "", true);
                    }
                   




                }




            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Stock Return Details.", ex);
            
        }
    }


    private List<InventoryItemsBasket> GetCollectedItems()
    {

        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        var ListItemBasket = new JavaScriptSerializer().Deserialize<List<InventoryItemsBasket>>(hdnProductList.Value);
        try
        {
            foreach (InventoryItemsBasket listParent in ListItemBasket)
            {
                    string Isreimbursable = string.Empty;
                    InventoryItemsBasket newBasket = new InventoryItemsBasket();
                    newBasket.ID = Convert.ToInt64(listParent.ID);
                    newBasket.ProductName = listParent.ProductName;
                    newBasket.BatchNo = listParent.BatchNo;
                    newBasket.Quantity = Convert.ToDecimal(listParent.Quantity);
                    newBasket.Unit = listParent.Unit;
                    newBasket.ComplimentQTY = Convert.ToDecimal(listParent.ComplimentQTY);
                    newBasket.ProductID = Convert.ToInt64(listParent.ProductID);
                    newBasket.Amount = Convert.ToDecimal(listParent.Quantity) * Convert.ToDecimal(listParent.Rate);
                    newBasket.Rate = Convert.ToDecimal(listParent.Rate);
                    newBasket.Tax = Convert.ToDecimal(listParent.Tax);
                    newBasket.ExpiryDate = DateTime.Parse(Convert.ToString(listParent.ExpiryDate) == "**" ? "01/01/1753" : Convert.ToString(listParent.ExpiryDate));
                    newBasket.Manufacture = DateTimeUtility.GetServerDate();
                    newBasket.AttributeDetail = "N";
                    newBasket.UnitPrice = Convert.ToDecimal(listParent.UnitPrice);
                    newBasket.ParentProductID = Convert.ToInt64(listParent.ParentProductID == null ? 0 : listParent.ParentProductID);
                    newBasket.Description = "Stock Return";
                    newBasket.CategoryID = Convert.ToInt32(ddlStockReturnType.SelectedItem.Value);
                    newBasket.Type = ddlStockReturnType.SelectedItem.Text;
                    newBasket.SubstoreReturnqty = Convert.ToDecimal(listParent.SubstoreReturnqty);
                    newBasket.ProductReceivedDetailsID = Convert.ToInt64(listParent.ProductReceivedDetailsID);
                    newBasket.ReceivedUniqueNumber = Convert.ToInt64(listParent.ReceivedUniqueNumber);
                newBasket.StockReceivedBarcodeDetailsID = listParent.StockReceivedBarcodeDetailsID;
                newBasket.BarcodeNo = listParent.BarcodeNo;
                    lstInventoryItemsBasket.Add(newBasket);
                }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at: Inventory GetCollectedItems Message:", ex);
        }
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



}