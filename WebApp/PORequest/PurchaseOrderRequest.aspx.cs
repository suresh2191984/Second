using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using System.Xml;
using System.Xml.Linq;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PORequest.BL;



public partial class PORequest_PurchaseOrderRequest : Attune_BasePage 
{
    public PORequest_PurchaseOrderRequest()
        : base("PORequest_PurchaseOrderRequest_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    InventoryCommon_BL inventoryBL;
    Products objProducts = new Products();
    List<Organization> lstorgn = new List<Organization>();
    List<Locations> lstloc = new List<Locations>();
    List<Locations> lstTrustOrgFindOrgAddid = new List<Locations>();
    int ReceivedOrgID = -1;
    int ReceivedOrgAddID = -1;
    int ToLocationID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
         if (!IsPostBack)
        {
            try
            {
              
                
               // divSearch.Visible = false;
                txtPurchaseOrderDate.Text = DateTimeNow.ToExternalDate();
                LoadOrgan();
                LoadUnit();
                AutoCompleteExtender2.ContextKey = null;
                if (Request.QueryString["ID"] != null)
                {
                    string poNO = string.Empty;
                    poNO = Request.QueryString["ID"];
                   // btnGeneratePO.PostBackUrl = "PurchaseOrderQuantity.aspx?Edit=Y&ID=" + poNO;
                    if (Request.QueryString["ACN"] != null)
                    {
                       // btnGeneratePO.PostBackUrl = "PurchaseOrderQuantity.aspx?Edit=Y&ID=" + poNO + "&ACN=" + Request.QueryString["ACN"];
                    }
                }
                else
                {
                    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                    new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Display_Inhandqty", OrgID, ILocationID, out lstInventoryConfig);
                    if (lstInventoryConfig.Count > 0)
                    {

                    }

                    if (Request.QueryString["addMore"] == "Y")
                    {
                    }
                }

            }

            catch (Exception ex)
            {
                CLogger.LogError("Error in Page Load - PurchaseOrderRequest.aspx", ex);
                //ErrorDisplay1.ShowError = true;
                //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            }
        }

    }



    private void LoadOrgan()
    {
        
        new TrustedOrg_BL(ContextInfo).GetSharingOrgList(OrgID, out lstorgn, out lstloc);

        ddlTrustedOrg.DataSource = lstorgn;
        ddlTrustedOrg.DataTextField = "Name";
        ddlTrustedOrg.DataValueField = "OrgID";
        ddlTrustedOrg.DataBind();
        ListItem ddlselect = GetMetaData("All", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "All", Value = "0" };
        }
        ddlTrustedOrg.Items.Insert(0, ddlselect);
       // ddlTrustedOrg.Items.Insert(0, GetMetaData("All", "0"));
        ddlTrustedOrg.Items[0].Value = "0";

        //ddlLocation.DataSource = lstloc;
        //ddlLocation.DataTextField = "LocationName";
        //ddlLocation.DataValueField = "LocationID";
        //ddlLocation.DataBind();
        ddlLocation.DataBind();
       
        ddlLocation.Items.Insert(0, ddlselect);
      //  ddlLocation.Items.Insert(0, GetMetaData("Select", "0"));
        //lstloc.RemoveAll(P => P.LocationID == InventoryLocationID);
        foreach (var item in lstloc)
        {
            hdnlocation.Value += item.OrgID + "~" + item.LocationID + "~" + item.LocationName + "^";

        }
        
    }

    public void LoadUnit()
    {
        long returnCode = -1;
        InventoryCommon_BL InventoryBL = new InventoryCommon_BL(base.ContextInfo);
        List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
        returnCode = InventoryBL.GetUnitType(OrgID, InventoryLocationID, out lstInventoryUOM);
        drpUnit.DataSource = lstInventoryUOM;
        drpUnit.DataTextField = "UOMCode";
        drpUnit.DataValueField = "UOMCode";
        drpUnit.DataBind();
        ListItem ddlselect = GetMetaData("Select", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        drpUnit.Items.Insert(0, ddlselect);
       // drpUnit.Items.Insert(0, GetMetaData("Select", "0"));
        drpUnit.Items[0].Selected = true;

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {

      //  ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSrd", "locationdetails();", true);
        long returnCode = -1;
        long PRID = 0;
        PORequest_BL InventoryBL = new PORequest_BL(base.ContextInfo);
        List<InventoryItemsBasket> lstItemBasket = new List<InventoryItemsBasket>();
        try
        {
            foreach (string listParent in hdnProductDetails.Value.Split('^'))
            {
                if (listParent != "")
                {
                    InventoryItemsBasket ItemBasket = new InventoryItemsBasket();
                    string[] listChild = listParent.Split('~');
                    //ItemBasket.CategoryName = txtNewKitName.Text.Trim();
                    ItemBasket.ProductName = listChild[0];
                    ItemBasket.Unit  = listChild[1];
                    ItemBasket.Quantity = Convert.ToDecimal(listChild[2]);
                    ItemBasket.ProductID = Int32.Parse(listChild[3]);
                    ItemBasket.parentProductID  = Int32.Parse(listChild[4]);
                    ItemBasket.Description = txtComments.Text;
                    ItemBasket.receivedOrgID = Int32.Parse(hdnSelectOrgid.Value); //---Raised OrgID 
                    ItemBasket.ExpiryDate = DateTimeNow ;
                    ItemBasket.Manufacture = DateTimeNow;
                    ItemBasket.Providedby = LID;
                    ItemBasket.LocationID = Int32.Parse(hdnFromLocationID.Value); //---Raised locationID 
                    lstItemBasket.Add(ItemBasket);
                    ReceivedOrgID=Int32.Parse(hdnSelectOrgid.Value)>0 ?Int32.Parse(hdnSelectOrgid.Value) :0;
                    ToLocationID= Int32.Parse(hdnFromLocationID.Value)>0 ?Int32.Parse(hdnFromLocationID.Value):0;
                }
            }
            returnCode = InventoryBL.SavePORequest(OrgID, ILocationID, lstItemBasket, ReceivedOrgID, ReceivedOrgAddID, ToLocationID, InventoryLocationID, out PRID);

            if (returnCode > 0 && PRID > 0)
            {
                string Message = Resources.PORequest_AppMsg.PORequest_PurchaseOrderRequest_aspx_12;
                if (Message == null)
                {
                    Message = "Kit Definition Created Successfully";
                }
                string sPath = Resources.PORequest_AppMsg.PORequest_OK;
                if (sPath == null)
                {
                    sPath = "Ok";
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSrd", "javascript:ValidationWindow('" + Message +"','" + sPath +"' );", true);
               Response.Redirect(@"~/PORequest/PO_RequestPrint.aspx?PORID=" + PRID.ToString());
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing Save PO Request Products", ex);
        }
    }


}
