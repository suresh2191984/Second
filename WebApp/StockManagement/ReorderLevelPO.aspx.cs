using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using System.Collections.Generic;
using System.Globalization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.StockManagement.BL;
using Attune.Kernel.InventoryCommon;

public partial class StockManagement_ReorderLevelPO : Attune_BasePage
{
    public StockManagement_ReorderLevelPO()
        : base("StockManagement_ReorderLevelPO_aspx")
    {
    }

    InventoryCommon_BL inventoryBL;
    List<Organization> lstorgn = new List<Organization>();
    List<Locations> lstLocationName = new List<Locations>();
    List<Locations> lstloc = new List<Locations>();
    List<InventoryItemsBasket> lstIntendBasket;
    Intend objIntend;
    DateTime DespatchDate;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
           
            hdnOrgID.Value = OrgID.ToString();
            hdnOrgAddressID.Value = ILocationID.ToString();
            hdnLocationID.Value = InventoryLocationID.ToString();
            hdnLoginID.Value = LID.ToString();
            long returnCode = -1;
            InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            returnCode = new Master_BL(ContextInfo).GetInvLocationDetail(OrgID, ILocationID, out lstLocationName);
        //    lsttempLocationName.Add((lstLocationName.Find(P => P.LocationTypeCode == "CS" || P.LocationTypeCode == "CS-POS")));
            List<Locations> CurrentLocation = new List<Locations>();
            CurrentLocation.Add(lstLocationName.Find(P=>P.LocationID==InventoryLocationID));

            if (CurrentLocation.Count > 0)
            {

                if (CurrentLocation[0].LocationTypeCode != "CS")
                {
                    CtConfig.Value = GetConfigValue("CTORG", OrgID);
                   // btnRaiseIntend.Attributes.Add("style", "display:block");
                    //btnClient.Attributes.Add("class", "hide");
                    hdnPOorIndent.Value = "Indent";  
                    LoadOrganization();
                }
                else
                {
                    raiseIndentDiv.Attributes.Add("class", "hide");
                    //btnRaiseIntend.Attributes.Add("style", "display:none");
                    btnSave.PostBackUrl = "ViewPurchaseOrderMedal.aspx";
                    hdnPOorIndent.Value = "PO";
                }
            }
            else
            {
                  CtConfig.Value = GetConfigValue("CTORG", OrgID);
                 //   btnRaiseIntend.Attributes.Add("style", "display:block");
                  //  btnClient.Attributes.Add("class", "hide");
                    hdnPOorIndent.Value = "Indent";    
                     LoadOrganization();
            }
            
        }   

    }


    protected void BtnSave_ButtonClick(object sender, EventArgs e)
    {
        //Server.Transfer("ViewPurchaseOrderMedal.aspx");
    }


    private void LoadOrganization()
    {
        TrustedOrg_BL inventoryBL = new TrustedOrg_BL(base.ContextInfo);        
        inventoryBL.GetSharingOrgList(OrgID, out lstorgn, out lstloc);

        ddlTrustedOrg.DataSource = lstorgn;

        ddlTrustedOrg.DataTextField = "Name";
        ddlTrustedOrg.DataValueField = "OrgID";
        ddlTrustedOrg.DataBind();
        ListItem ddlselect = GetMetaData("Select", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        ddlTrustedOrg.Items.Insert(0, ddlselect);
       // ddlTrustedOrg.Items.Insert(0, GetMetaData("Select", "0"));
        ddlTrustedOrg.Items[0].Value = "0";



        lstloc.RemoveAll(P => P.LocationID == InventoryLocationID);
        if (GetInventoryConfigDetailsValue("DisasbleSubStoreRaiseIndent", OrgID, 0).Equals("Y"))
        {
            lstloc.RemoveAll(P => P.LocationTypeCode != "CS" && P.LocationTypeCode != "CS-POS");
        }
        ddlLocation.DataSource = lstloc;
        ddlLocation.DataTextField = "LocationName";
        ddlLocation.DataValueField = "LocationID";
        ddlLocation.DataBind();
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        ddlLocation.Items.Insert(0, ddlselect);
       // ddlLocation.Items.Insert(0, GetMetaData("Select", "0"));


        foreach (var item in lstloc)
        {
            hdnlocation.Value += item.OrgID + "~" + item.LocationID + "~" + item.LocationName + "~" + Convert.ToString(item.IsDefaults) + "^";

        }

    }

    protected void btnRaiseIntend_Click(object sender, EventArgs e)
    {
        //btnRaiseIntend.Enabled = false;    
        long pIndID = 0;
        objIntend = new Intend();
        lstIntendBasket = new List<InventoryItemsBasket>();
       
        if (CtConfig.Value == "Y")
        {
            int LocationID = 0;
            if (hdnInventoryLocationID.Value != "")
            {
                Int32.TryParse(hdnInventoryLocationID.Value, out LocationID);
            }
            else
            {
                Int32.TryParse(hdnLocationID.Value, out LocationID);
            }
            objIntend.LocationID = LocationID;
            objIntend.ToLocationID = Convert.ToInt32(hdnToLocationID.Value);
            objIntend.RaiseOrgID = Convert.ToInt32(hdnToOrgID.Value);
        }
        else
        {
            objIntend.LocationID = InventoryLocationID;
            objIntend.ToLocationID = Convert.ToInt16(ddlLocation.SelectedItem.Value) == 0 ? 0 : Convert.ToInt16(ddlLocation.SelectedItem.Value);
            objIntend.RaiseOrgID = int.Parse(hdnSelectOrgid.Value);
        }

        objIntend.IntendDate = DateTimeNow;

        //if (GetConfigValue("Required_intend_Approval", OrgID).Equals("Y"))
        if (GetInventoryConfigDetailsValue("Required_intend_Approval", OrgID, 0).Equals("Y"))
        {
            objIntend.Status = StockOutFlowStatus.Pending;
        }
        else
        {
            objIntend.Status = StockOutFlowStatus.Approved;
        }
        objIntend.CreatedBy = LID;
        objIntend.OrgID = OrgID;
        objIntend.OrgAddressID = ILocationID;  
        lstIntendBasket = GetIntendList();
        string[] varDatetime = henExpectedDeliveryDate.Value.Trim().Split('/');

        //DespatchDate = DateTime.ParseExact(txtDate.Text.Trim(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
        DespatchDate = Convert.ToDateTime(varDatetime[2] + "-" + varDatetime[1] + "-" + varDatetime[0]);
        long returnCode = -1;       
        long TaskID = -1;
        if (lstIntendBasket.Count > 0)
        {
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            
            returnCode = inventoryBL.SaveIntend(objIntend, lstIntendBasket, 0, DespatchDate, out pIndID, out TaskID);
            //hdnIndentId.Value = pIndID.ToString();
            //if (lstitemEpiKitDetails.Count > 0)
            //{
            //    returnCode = inventoryBL.SaveKitStudyDetails(pIndID, lstitemEpiKitDetails);
            //}
        }
        if (lstIntendBasket.Count > 0)
        {
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
          
            //returnCode = inventoryBL.SaveIntend(objIntend, lstIntendBasket, "", DespatchDate, out pIndID, out TaskID);
            //hdnIndentId.Value = pIndID.ToString();
            
        }
        else
        {
            string sPath = Resources.StockManagement_AppMsg.StockManagement_ReorderLevelPO_aspx_09;
            sPath = sPath == null ? "Select atleast one product" : sPath;

                string errorMsg = Resources.StockManagement_AppMsg.StockManagement_Error;
                errorMsg = errorMsg == null ? "Alert" : errorMsg;
            
           // string sPath = "Inventory\\\\RaiseIntend.aspx.cs_30";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "CheckProduct", "javascript:ValidationWindow('" + sPath + "','" + errorMsg + "');", true);
            //btnRaiseIntend.Enabled = true;
        }
        if (pIndID > 0)
        {
            Response.Redirect(@"~/StockIntend/ViewIntendDetail.aspx?intID=" + pIndID.ToString());
        }
        else
        {

        }
    }


    public string GetInventoryConfigDetailsValue(string configKey, int orgID, int OrgAddressID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        Configuration_BL objGateway = new Configuration_BL(new Attune_BaseClass().ContextInfo);
        List<InventoryConfig> lstConfig = new List<InventoryConfig>();

        returncode = objGateway.GetInventoryConfigDetails(configKey, orgID, OrgAddressID, out lstConfig);
        if (lstConfig!=null &&lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }

    private List<InventoryItemsBasket> GetIntendList()
    {

        InventoryItemsBasket newBasket;
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        List<InventoryItemsBasket> lstInventoryItemsBasketForKit = new List<InventoryItemsBasket>();
        foreach (string listParent in hdnProductList.Value.Split('^'))
        {
            if (listParent != "")
            {
                string Isreimbursable = string.Empty;
                newBasket = new InventoryItemsBasket();
                string[] listChild = listParent.Split('~');
                newBasket.ProductID = Convert.ToInt64(listChild[0]);
                newBasket.SellingUnit = listChild[1];
                newBasket.ProductName = listChild[2];
                newBasket.Quantity = Convert.ToDecimal(listChild[3]);
                newBasket.ExpiryDate = DateTimeNow;
                newBasket.Manufacture = DateTimeNow;
                newBasket.ParentProductID = Convert.ToInt64(listChild[4]);
                lstInventoryItemsBasket.Add(newBasket);
            }
        }           
        return lstInventoryItemsBasket;
    }


 


}
