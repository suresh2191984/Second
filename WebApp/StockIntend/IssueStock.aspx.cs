using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Globalization;
using System.Web.Services;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryCommon;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;
using System.Web.Script.Serialization;



public partial class Inventory_IssueStock : Attune_BasePage
{

    public Inventory_IssueStock()
        : base("StockIntend_IssueStock_aspx")
    {
    }

    string strEnablePackSize = "N";
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    List<Intend> lstIntend = new List<Intend>();
    List<InventoryItemsBasket> lstIntendDetail = new List<InventoryItemsBasket>();
    InventoryCommon_BL inventoryBL;
    int ReceivedOrgID = -1;
    int ReceivedOrgAddID = -1;
    List<Organization> lstTrustOrg = new List<Organization>();
    List<Organization> lstTrustOrgFindOrgAddid = new List<Organization>();
    List<Organization> lstorgn = new List<Organization>();
    List<Locations> lstloc = new List<Locations>();
    public long intNo = 0;
    long tolocation;
    int OrgAdd = 0;
    string Status = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {

            HideOrShowUsageCount();
            ddlTrustedOrg.Focus();
            lblDate.Text = DateTimeUtility.GetServerDate().ToExternalDate();
            LoadOrgan();
            //BindConsumedBy();
            HideOrShowUsageCount();
            tabRecd.Attributes.Add("class", "displaytb w-100p");
            hdnLocationId.Value = InventoryLocationID.ToString();
            hndPageId.Value = PageID.ToString();
            hdnLoginid.Value = LID.ToString();
            hdnOrgId.Value = OrgID.ToString();

            if (Request.QueryString["intID"] != null)
            {
                divsup1.Attributes.Add("class", "show");
                stockIssuedTab.Attributes.Add("class", "show");
                intNo = long.Parse(Request.QueryString["intID"]);
                loadIndentDetail();
                GetDraftDtls();
            }
            if (Request.QueryString["ReceivedOrgID"] != "0" && Request.QueryString["ReceivedOrgID"] != null)
            {
                ddlTrustedOrg.SelectedValue = Request.QueryString["ReceivedOrgID"].ToString();
                ReceivedOrgID = int.Parse(Request.QueryString["ReceivedOrgID"]);

            }

            if (Request.QueryString["LocationID"] != "0" && Request.QueryString["LocationID"] != null)
            {
                ddlLocation.SelectedValue = Request.QueryString["LocationID"].ToString();
            }
            GetLocationAddress();
        }

        if (Convert.ToInt16(ddlTrustedOrg.SelectedItem.Value) > 0)
        {
            lstloc.FindAll(P => P.OrgID == Convert.ToInt16(ddlTrustedOrg.SelectedItem.Value));
            if (lstloc.Count > 0)
            {
                OrgAdd = lstloc[0].OrgAddressID;
                hdnOrgAddid.Value = lstloc[0].OrgAddressID.ToString();
            }

        }


        if (hdnEnablePackSize.Value == "Y")
        {
            strEnablePackSize = "Y";
            gvIndentDetails.Columns[4].Visible = false;
            gvIndentDetails.Columns[6].Visible = false;
        }
        else
        {
            gvIndentDetails.Columns[1].Visible = false;
            gvIndentDetails.Columns[3].Visible = false;
            

        }


        //if (Convert.ToInt16(ddlTrustedOrg.SelectedItem.Value) > 0)
        //{
        //    lstloc.FindAll(P => P.OrgID == Convert.ToInt16(ddlTrustedOrg.SelectedItem.Value));
        //    ddlLocation.DataSource = lstloc;
        //    ddlLocation.DataTextField = "LocationName";
        //    ddlLocation.DataValueField = "LocationID";
        //    ddlLocation.DataBind();
        //    ddlLocation.Items.Insert(0, "----Select----");
        //    ddlLocation.Items[0].Value = "0";
        //    ddlLocation.SelectedValue = Request.QueryString["LocationID"].ToString();
        //}
    }

    private void GetDraftDtls()
    {
        InventoryCommon_BL objDraft = new InventoryCommon_BL();
        List<Drafts> DraftData = new List<Drafts>();
        objDraft.GetDraftDetails(OrgID, InventoryLocationID, Convert.ToInt32(PageID), LID, "IssueIntend", Convert.ToString(intNo), out DraftData);
        if (DraftData != null && DraftData.Count > 0)
        {
            hdnProductList.Value = DraftData[0].Data;
        }
    }
    private void LoadOrgan()
    {
        TrustedOrg_BL lstTrustedOrg = new TrustedOrg_BL(base.ContextInfo);
        lstTrustedOrg.GetSharingOrgList(OrgID, out lstorgn, out lstloc);
        //lstorgn.RemoveAll(P => P.OrgID == OrgID);
        ddlTrustedOrg.DataSource = lstorgn;
        ddlTrustedOrg.DataTextField = "Name";
        ddlTrustedOrg.DataValueField = "OrgID";
        ddlTrustedOrg.DataBind();
        ddlTrustedOrg.Items.Insert(0,GetMetaData("Select","0"));
        ddlTrustedOrg.Items[0].Value = "0";
        int org = Convert.ToInt16(ddlTrustedOrg.SelectedItem.Value) == 0 ? Convert.ToInt16(Request.QueryString["ReceivedOrgID"]) : Convert.ToInt16(ddlTrustedOrg.SelectedItem.Value);

        lstloc.RemoveAll(P => P.OrgID != org);
        lstloc.RemoveAll(P => P.LocationID == InventoryLocationID);

        ddlLocation.DataSource = lstloc;
        ddlLocation.DataTextField = "LocationName";
        ddlLocation.DataValueField = "LocationID";
        ddlLocation.DataBind();
        ddlLocation.Items.Insert(0, GetMetaData("Select", "0"));
        ddlLocation.Items[0].Value = "0";
        foreach (var item in lstloc)
        {
            // hdnlocation.Value += item.LocationTypeID + "~" + item.LocationID + "~" + item.LocationName + "^";
            hdnlocation.Value += item.OrgID + "~" + item.LocationID + "~" + item.LocationName + "^";
        }

        if (Request.QueryString["ReceivedOrgID"] != "0" && Request.QueryString["ReceivedOrgID"] != null)
        {
            ddlTrustedOrg.SelectedValue = Request.QueryString["ReceivedOrgID"].ToString();
            ReceivedOrgID = int.Parse(Request.QueryString["ReceivedOrgID"]);
            lstloc.FindAll(P => P.OrgID == ReceivedOrgID);
            if (lstloc.Count > 0)
            {
                OrgAdd = lstloc[0].OrgAddressID;
                hdnOrgAddid.Value = lstloc[0].OrgAddressID.ToString();
            }

        }
    }

    private void loadIndentDetail()
    {

        if (Request.QueryString["intID"] != null)
        {
            intNo = long.Parse(Request.QueryString["intID"]);
            AutoCompleteProduct.ContextKey = intNo.ToString() + "~Product" ;
        }

        inventoryBL.GetIntendDetail(intNo, InventoryLocationID, OrgID, 0, out lstIntendDetail, out lstIntend);

        if (lstIntendDetail.Count > 0)
        {
            gvIndentDetails.DataSource = lstIntendDetail;
            gvIndentDetails.DataBind();
            hdnRakno.Value = lstIntendDetail[0].RakNo.ToString();
        }
        if (lstIntend.Count > 0)
        {
            lblIndentNo.Text = lstIntend[0].IntendNo.ToString();
            long.TryParse(lstIntend[0].ToLocationID.ToString(), out tolocation);
            long.TryParse(Request.QueryString["LocationID"], out tolocation);
            ddlLocation.SelectedValue = tolocation.ToString();

        }


    }



    private void BindConsumedBy()
    {
        InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        List<Users> lstUsers = new List<Users>();

        long iOrgID = Int64.Parse(OrgID.ToString());
        long returnCode = -1;
        returnCode = new Master_BL(this.ContextInfo).GetListOfUsers(OrgID, out lstUsers);
        foreach (var item in lstUsers)
        {
            hdnUserlist.Value += item.Name + "~" + item.UserID + "~" + item.OrgID + "^";
        }
        //ddlUser.DataSource = lstUsers;
        //ddlUser.DataTextField = "Name";
        //ddlUser.DataValueField = "LoginID";
        //ddlUser.DataBind();
        ddlUser.Items.Insert(0, GetMetaData("Select", "0"));
    }

    private void BindInventoryLocation()
    {
        InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        List<Locations> lstLocationName = new List<Locations>();
        try
        {
            long iOrgID = Int64.Parse(OrgID.ToString());
            long returnCode = -1;
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = ILocationID;
            //new GateWay(base.ContextInfo).GetInventoryConfigDetails("Locations_BasedOn_Org", OrgID, out lstInventoryConfig);
            //if (lstInventoryConfig.Count > 0)
            //{
            //    if (lstInventoryConfig[0].ConfigValue == "Y")
            //    {
            //        OrgAddid = 0;
            //    }
            //    else
            //    {
            //        OrgAddid = ILocationID;
            //    }
            //}

            OrgAddid = ILocationID;
            returnCode = new Master_BL(ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocationName);
            lstLocationName.RemoveAll(P => P.LocationID == InventoryLocationID);
            ddlLocation.DataSource = lstLocationName;
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
            long.TryParse(Request.QueryString["LocationID"], out tolocation);
            ddlLocation.SelectedValue = tolocation.ToString();
            ddlLocation.Items.Insert(0, GetMetaData("Select", "0"));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - StockIssued.aspx", ex);
        }
    }
    string strMsg = Resources.StockIntend_AppMsg.StockIntend_IssueStock_aspx_08 == null ? "There is no sufficient Qty to Issue stock..!" : Resources.StockIntend_AppMsg.StockIntend_IssueStock_aspx_08;
    string strErr = Resources.StockIntend_AppMsg.StockIntend_Error == null ? "alert" : Resources.StockIntend_AppMsg.StockIntend_Error;
    protected void btnStockIssued_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        long IndID = -1;
        long pId = -1;
        long intendID = 0;

        try
        {

            ReceivedOrgID = OrgID;
            ReceivedOrgAddID = ILocationID;
            StockReceived objLocationStockInHand = new StockReceived();
            List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
            List<InventoryItemsBasket> lstInventoryIndentItemsBasket = new List<InventoryItemsBasket>();
            InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);

            //objLocationStockInHand.Comments = txtComments.Text;
            //objLocationStockInHand.CreatedBy = LID;
            //objLocationStockInHand.FromLocationID = InventoryLocationID;
            //objLocationStockInHand.IssuedTO = LID;
            //objLocationStockInHand.OrgID = OrgID;
            //objLocationStockInHand.OrgAddressID = ILocationID;
            //objLocationStockInHand.ToLocationID = Convert.ToInt16(ddlLocation.SelectedItem.Value) == 0 ? Convert.ToInt16(Request.QueryString["LocationID"]) : Convert.ToInt16(ddlLocation.SelectedItem.Value);
            //if (Request.QueryString["intID"] != null)
            //{
            //    Int64.TryParse(Request.QueryString["intID"], out intendID);
            //    objLocationStockInHand.IndentID = intendID;
            //}
            //else
            //{
            //    objLocationStockInHand.IndentID = intendID;
            //}


            objLocationStockInHand.Comments = txtComments.Text;
            objLocationStockInHand.CreatedBy = LID;
            objLocationStockInHand.FromLocationID = Convert.ToInt16(ddlLocation.SelectedItem.Value) == 0 ? Convert.ToInt16(Request.QueryString["LocationID"]) : Convert.ToInt16(ddlLocation.SelectedItem.Value);
            objLocationStockInHand.IssuedTO = LID;
            objLocationStockInHand.OrgID = Convert.ToInt16(ddlTrustedOrg.SelectedItem.Value) == 0 ? Convert.ToInt16(Request.QueryString["ReceivedOrgID"]) : Convert.ToInt16(ddlTrustedOrg.SelectedItem.Value);
            objLocationStockInHand.OrgAddressID = Convert.ToInt16(hdnOrgAddid.Value) > 0 ? Convert.ToInt16(hdnOrgAddid.Value) : -1;
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
            objLocationStockInHand.Status = "Pending";

            //lstInventoryItemsBasket = GetCollectedItems();
            lstInventoryIndentItemsBasket = GetCollectedIndentItems();
            if (lstInventoryIndentItemsBasket.Count > 0)
            {
                returnCode = inventoryBL.SaveStockIssue(objLocationStockInHand, lstInventoryIndentItemsBasket, ReceivedOrgID, ReceivedOrgAddID, out pId, out IndID, out Status);
                //returnCode = inventoryBL.updateIndentIssue(objLocationStockInHand, ref lstInventoryIndentItemsBasket, intendID, OrgID, ILocationID, InventoryLocationID,int.Parse(tolocation.ToString()),ReceivedOrgID,ReceivedOrgAddID , out IndID,out pId );

            }
            if (returnCode > 0)
            {
                RemoveDrafts();
                Response.Redirect(@"../StockIntend/ViewIssuedIndentdetails.aspx?ID=" + pId + "&intID=" + IndID + "&Status=" + Status, true);

            }

            // lstInventoryItemsBasket = GetIssueINVBasket(lstInventoryItemsBasket);
            //returnCode = inventoryBL.getSellingPriceDetails(ref lstInventoryItemsBasket, OrgID, ILocationID, InventoryLocationID);
            //if (lstInventoryItemsBasket.Count == 0)
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "MultipleAdd", "alert('Please ensure that Items Added/Quantity values are entered properly.')", true);
            //    return;
            //}
            //List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            //new GateWay(base.ContextInfo).GetInventoryConfigDetails("Required_intend_Approval", OrgID,ILocationID , out lstInventoryConfig);
            //objLocationStockInHand.Status = StockOutFlowStatus.Approved;
            //if (lstInventoryConfig.Count > 0)
            //{
            //    //if (lstInventoryConfig[0].ConfigValue == "Y")
            //    //{
            //    //    // objLocationStockInHand.Status = StockOutFlowStatus.Pending;
            //    //    returnCode = inventoryBL.SaveStockIssue(objLocationStockInHand, lstInventoryItemsBasket, out pId, out IndID);
            //    //}
            //    //else
            //    {
            //        objLocationStockInHand.Status = StockOutFlowStatus.Approved;
            //        returnCode = inventoryBL.SaveStockIssueToLocation(objLocationStockInHand, lstInventoryItemsBasket, out pId, out IndID);

            //    }
            //    if (returnCode > 0)
            //    {
            //        Response.Redirect(@"../Inventory/ViewIssuedIndentdetails.aspx?ID=" + pId + "&intID=" + IndID + "&Status=Issued", true);
            //        ///ViewIntendDetail.aspx?intID=61
            //    }
            //}
            //else
            //{
            //    returnCode = inventoryBL.SaveStockIssueToLocation(objLocationStockInHand, lstInventoryItemsBasket, out pId, out IndID);

            //    if (returnCode > 0)
            //    {
            //        Response.Redirect(@"../Inventory/ViewIssuedIndentdetails.aspx?ID=" + pId + "&intID=" + IndID + "&Status=Issued", true);
            //        ///ViewIntendDetail.aspx?intID=61
            //    }


            //}

          else
            { ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ValidationWindow(" + strMsg + "," + strErr + ");", true); }


        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Stock Return Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    private void RemoveDrafts()
    {
        InventoryCommon_BL objDraft = new InventoryCommon_BL();

        string _intNo = Convert.ToString(Request.QueryString["intID"]);
        objDraft.DeleteDraft(OrgID, InventoryLocationID, Convert.ToInt32(PageID), LID, "IssueIntend", _intNo);

    }
    private List<InventoryItemsBasket> GetCollectedItems()
    {

        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

        foreach (string listParent in hdnProductList.Value.Split('^'))
        {
            if (listParent != "")
            {
                string Isreimbursable = string.Empty;
                InventoryItemsBasket newBasket = new InventoryItemsBasket();
                string[] listChild = listParent.Split('~');
                newBasket.ID = Convert.ToInt64(listChild[12]);
                newBasket.ProductName = listChild[1];
                newBasket.BatchNo = listChild[2];
                newBasket.Quantity = Convert.ToDecimal(listChild[3]);
                newBasket.Unit = listChild[4];
                newBasket.ComplimentQTY = Convert.ToDecimal(listChild[5]);//InhandQnty
                newBasket.ProductID = Convert.ToInt64(listChild[6]);
                newBasket.Amount = Convert.ToDecimal(listChild[3]) * Convert.ToDecimal(listChild[7]);
                newBasket.Rate = Convert.ToDecimal(listChild[7]);
                newBasket.Tax = Convert.ToDecimal(listChild[8]);
                newBasket.ExpiryDate = DateTime.Parse(listChild[9]);
                newBasket.CategoryID = Convert.ToInt16(listChild[11]);
                newBasket.Manufacture = DateTimeUtility.GetServerDate();
                newBasket.AttributeDetail = "N";
                newBasket.Providedby = Convert.ToInt64(listChild[10]);
                newBasket.UnitPrice = Convert.ToDecimal(listChild[13]);
                newBasket.ProductKey = newBasket.ProductID + "@#$" + newBasket.BatchNo + "@#$" + newBasket.ExpiryDate.ToString("MMM/yyyy")
                              + "@#$" + String.Format("{0:0.000000}", newBasket.UnitPrice) + "@#$" + String.Format("{0:0.000000}", newBasket.Rate) + "@#$" + newBasket.Unit;
                newBasket.parentProductID = Convert.ToInt64(listChild[14]);
                lstInventoryItemsBasket.Add(newBasket);
            }
        }
        return lstInventoryItemsBasket;
    }


    private List<InventoryItemsBasket> GetCollectedIndentItems()
    {

        List<InventoryItemsBasket> lstInventoryIndentItemsBasket = new List<InventoryItemsBasket>();

        var ListItemBasket = new JavaScriptSerializer().Deserialize<List<InventoryItemsBasket>>(hdnProductList.Value);


        lstInventoryIndentItemsBasket = (from c in ListItemBasket
                                         select new InventoryItemsBasket
                           {
                               ID = c.StockInHandID,
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
                               CategoryID = c.CategoryID,
                               Manufacture = DateTimeUtility.GetServerDate(),
                               Providedby = c.ID,
                               UnitPrice = c.UnitPrice,
                               ParentProductID = c.ParentProductID,
                               MRP = c.MRP,
                               Description = "Stock Issued",
                               ProductReceivedDetailsID = c.ProductReceivedDetailsID,
                               ReceivedUniqueNumber =c.ReceivedUniqueNumber,
                               StockReceivedBarcodeDetailsID=c.StockReceivedBarcodeDetailsID,
                               StockReceivedBarcodeID=c.StockReceivedBarcodeID,
                               BarcodeNo = c.BarcodeNo,
                               IsUniqueBarcode=c.IsUniqueBarcode,
                               ReceivedOrgAddID= Convert.ToInt32(c.StockReceivedBarcodeDetailsID),          //Temporary using this variable (Need to Remove)
                               CategoryName = c.BarcodeNo,                                                    //Temporary using this variable (Need to Remove)
                           RakNo = c.RakNo
                           }).ToList();

        //foreach (string listParent in hdnProductList.Value.Split('^'))
        //{
        //    if (listParent != "")
        //    {
        //        string Isreimbursable = string.Empty;
        //        InventoryItemsBasket newBasket = new InventoryItemsBasket();
        //        string[] listChild = listParent.Split('~');
        //        newBasket.ID = Convert.ToInt64(listChild[12]);//STOCKINHANDID  
        //        newBasket.ProductName = listChild[1];
        //        newBasket.BatchNo = listChild[2];
        //        newBasket.Quantity = Convert.ToDecimal(listChild[3]);
        //        newBasket.Unit = listChild[4];
        //        newBasket.ComplimentQTY = Convert.ToDecimal(listChild[5]);
        //        newBasket.ProductID = Convert.ToInt64(listChild[6]);
        //        newBasket.Amount = Convert.ToDecimal(Convert.ToDecimal(listChild[3]) * Convert.ToDecimal(listChild[7]));
        //        newBasket.Rate = Convert.ToDecimal(listChild[7]);
        //        newBasket.Tax = Convert.ToDecimal(listChild[8]);
        //        newBasket.ExpiryDate = DateTime.Parse(listChild[9]);
        //        newBasket.CategoryID = Convert.ToInt16(listChild[11]);
        //        newBasket.Manufacture = DateTimeUtility.GetServerDate();
        //        newBasket.Providedby = Convert.ToInt64(listChild[10]);//intenddetailid
        //        newBasket.UnitPrice = Convert.ToDecimal(listChild[13]);
        //        string ProductKey = string.Empty;
        //        string CurrentCulture = string.Empty;
        //        CurrentCulture = CultureInfo.CurrentCulture.Name;
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
        //        //                 + "@#$" + String.Format("{0:0.000000}", newBasket.UnitPrice) + "@#$" + String.Format("{0:0.000000}", newBasket.Rate) + "@#$" + newBasket.Unit;
        //        //}
        //        newBasket.parentProductID = Convert.ToInt64(listChild[14]);
        //        newBasket.Description = "Stock Issued";
        //        newBasket.MRP = Convert.ToDecimal(listChild[15]);
        //        if (listChild[17] != null && listChild[17] != "")
        //        {
        //            newBasket.ClientFeeTypeRateCustID = Convert.ToInt64(listChild[17]);
        //        }
        //        newBasket.ProductReceivedDetailsID = Convert.ToInt64(listChild[21]);
        //        lstInventoryIndentItemsBasket.Add(newBasket);


        //    }
        //}
        return lstInventoryIndentItemsBasket;
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
    protected void btnBack_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["tid"])) { Response.Redirect(@"../Admin/Home.aspx", true); }
        else
        {
            Response.Redirect("~/StockIntend/Intend.aspx");
        }
    }
    protected void GetLocationAddress()
    {
        List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
        int ReceivedOrgID = Convert.ToInt32(Request.QueryString["ReceivedOrgID"]);
        hdnTaxAddFlag.Value = "1";
        Master_BL objPatientVisit = new Master_BL(base.ContextInfo);
        new Organization_BL(base.ContextInfo).GetLocation(ReceivedOrgID, LID, RoleID, out lstOrganizationAddress);
        //if (!string.IsNullOrEmpty(lstOrganizationAddress[0].StateID.ToString()) && StateID.Equals(lstOrganizationAddress[0].StateID))
        //{
        //    hdnTaxAddFlag.Value = "1";
        //}
    }

    protected void gvIndentDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HiddenField hdnProductName = (HiddenField)e.Row.FindControl("hdnProductName");
                HiddenField hdnPID = (HiddenField)e.Row.FindControl("hdnProductID");
                Button btnAction = (Button)e.Row.FindControl("btnAction");
                string function = "javascript:return GetProductName(escape('" + hdnProductName.Value + "'),'" + hdnPID.Value + "')";
                btnAction.Attributes.Add("Onclick", function);

                Button btnIndCancel = (Button)e.Row.FindControl("btnIndCancel");
                btnIndCancel.Attributes.Add("Onclick", "javascript:return UpdateItemStatusConfirmDialog(this,'" + hdnPID.Value + "')");

              }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvBillingDetail_RowDataBound", ex);
        }
    }

    protected void HideOrShowUsageCount()
    {
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("BarCodeMappingBeforeStockReceiveApproval", OrgID, ILocationID, out lstInventoryConfig);
        hdnEnableBarCode.Value = "N";
        if (lstInventoryConfig.Count > 0)
        {

            hdnEnableBarCode.Value = lstInventoryConfig[0].ConfigValue;          

        }
        List<InventoryConfig> lstInventoryConfigPackSize = new List<InventoryConfig>();
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("EnablePackSize", OrgID, ILocationID, out lstInventoryConfigPackSize);

        hdnEnablePackSize.Value = "N";
        if (lstInventoryConfigPackSize.Count > 0)
        {

            hdnEnablePackSize.Value = lstInventoryConfigPackSize[0].ConfigValue;

        }
    }


}


