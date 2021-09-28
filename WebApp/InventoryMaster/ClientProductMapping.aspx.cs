using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryMaster.BL;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryMaster_ClientProductMapping : Attune_BasePage
{
    List<Products> lstProducts;
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoGname1.ContextKey = "0";
        AutoCompleteExtender1.ContextKey = "-1";
        if (!IsPostBack)
        {
           
           
            GetClientMappingDetails();

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            lstmetadataInput.Add(new MetaData { Domain = "Druglimit" });
            new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            ddlType.DataSource = lstmetadataOutput;
            ddlType.DataTextField = "DisplayText";
            ddlType.DataValueField = "Code";
            ddlType.DataBind();
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlType.Items.Insert(0, ddlselect);
           
        }
    }

    protected void GetClientMappingDetails()
    {
        
        InventoryMaster_BL inventoryBL = new InventoryMaster_BL(base.ContextInfo);
        lstProducts = new List<Products>();
        inventoryBL.GetClientProductMappingDetails(0, 0, 0, string.Empty, string.Empty, 0, OrgID, "GET",0, out lstProducts);
        if (lstProducts != null && lstProducts.Count > 0)
        {
            cError.Attributes.Add("class", "hide");
            rpClientProductMapping.DataSource = lstProducts;
            rpClientProductMapping.DataBind();
        }
        else
        {

            cError.Attributes.Add("class", "show");
        }
    }

    protected void rpClientProductMapping_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemIndex >= 0)
        {
            HtmlControl rbtnClientRow = (HtmlControl)e.Item.FindControl("spanClientRow");
            if (rbtnClientRow != null)
            {
                rbtnClientRow.Attributes.Add("CID", lstProducts[e.Item.ItemIndex].ClientID.ToString());
                rbtnClientRow.Attributes.Add("CName", lstProducts[e.Item.ItemIndex].ClientName);
                rbtnClientRow.Attributes.Add("PID", lstProducts[e.Item.ItemIndex].ProductID.ToString());
                rbtnClientRow.Attributes.Add("PName", lstProducts[e.Item.ItemIndex].ProductName);
                rbtnClientRow.Attributes.Add("QTY", lstProducts[e.Item.ItemIndex].UsageCount.ToString());
                rbtnClientRow.Attributes.Add("IS", lstProducts[e.Item.ItemIndex].HasExpiryDate);
                rbtnClientRow.Attributes.Add("Type", lstProducts[e.Item.ItemIndex].Attributes);
                rbtnClientRow.Attributes.Add("MID", lstProducts[e.Item.ItemIndex].TypeID.ToString());
                rbtnClientRow.Attributes.Add("NoofDays", lstProducts[e.Item.ItemIndex].TaxPercent.ToString());

                
            }
            Literal lisno = (Literal)e.Item.FindControl("lisno");
            if (lisno != null)
            {
                lisno.Text = (e.Item.ItemIndex + 1).ToString();
            }
            Literal liProductName = (Literal)e.Item.FindControl("liProductName");
            if (liProductName != null)
            {
                liProductName.Text = lstProducts[e.Item.ItemIndex].ProductName;
            }
            Literal liClientName = (Literal)e.Item.FindControl("liClientName");
            if (liClientName != null)
            {
                liClientName.Text = lstProducts[e.Item.ItemIndex].ClientName;
            }
            Literal liQty = (Literal)e.Item.FindControl("liQty");
            if (liQty != null)
            {
                liQty.Text = lstProducts[e.Item.ItemIndex].UsageCount.ToString();
            }
            Literal liIsActive = (Literal)e.Item.FindControl("liIsActive");
            if (liIsActive != null)
            {
                if (lstProducts[e.Item.ItemIndex].HasExpiryDate.Equals("Y"))
                {
                    liIsActive.Text = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ClientProductMapping_aspx_1;
                }
                else
                {
                    liIsActive.Text = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ClientProductMapping_aspx_2;
                }
            }
            Literal liRestrictionType = (Literal)e.Item.FindControl("liRestrictionType");
            if (liRestrictionType != null)
            {
                liRestrictionType.Text = GetStatus(lstProducts[e.Item.ItemIndex].Attributes);
            }

            Literal liNoofDrugs = (Literal)e.Item.FindControl("liNoofDrugs");
            if (liNoofDrugs != null)
            {
                liNoofDrugs.Text = lstProducts[e.Item.ItemIndex].TaxPercent.ToString();
            }

        }
    }

    protected string GetStatus(string RestrictionStatus)
    {
        string strStatus = string.Empty;
        switch (RestrictionStatus)
        {
            case "V":
                strStatus = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ClientProductMapping_aspx_3;
                break;
            case "D":
                strStatus = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ClientProductMapping_aspx_4;
                break;
            case "W":
                strStatus = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ClientProductMapping_aspx_5;
                break;
            case "M":
                strStatus = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ClientProductMapping_aspx_6;
                break;
            case "H":
                strStatus = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ClientProductMapping_aspx_7;
                break;
            case "Y":
                strStatus = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ClientProductMapping_aspx_8;
                break;
            default:
                strStatus = string.Empty;
                break;
        }
        return strStatus;
    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        InventoryMaster_BL inventoryBL = new InventoryMaster_BL(base.ContextInfo);
        lstProducts = new List<Products>();
        long productID = 0;
        if (!string.IsNullOrEmpty(hdnProductID.Value))
        {
            productID = Convert.ToInt64(hdnProductID.Value);
        }
        long clientID = 0;
        if (!string.IsNullOrEmpty(hdnClientID.Value))
        {
            clientID = Convert.ToInt64(hdnClientID.Value);
        }
        long qty = 0;
        if (!string.IsNullOrEmpty(txtQty.Text.Trim()))
        {
            qty = Convert.ToInt64(txtQty.Text.Trim());
        }
        int NoofDays = 1;
        if (!string.IsNullOrEmpty(txtNoofDays.Text.Trim()))
        {
            NoofDays = Convert.ToInt32(txtNoofDays.Text.Trim());
        }

        int mappingID = 0;
        if (string.IsNullOrEmpty(hdnMappingID.Value))
        {
            inventoryBL.GetClientProductMappingDetails(productID, clientID, qty, "Y",  ddlType.SelectedValue
                , 0, OrgID, "INSERT", NoofDays, out lstProducts);
        }
        else
        {
            mappingID = Convert.ToInt32(hdnMappingID.Value);
            string isActive = "N";
            if (chkISActive.Checked)
            {
                isActive = "Y";
            }
            inventoryBL.GetClientProductMappingDetails(productID, clientID, qty, isActive, ddlType.SelectedValue
                           , mappingID, OrgID, "UPDATE", NoofDays, out lstProducts);
        }
        txtClientName.Text = string.Empty;
        txtQty.Text = string.Empty;
        ddlType.SelectedValue = "0";
        chkISActive.Checked = false;
        txtNoofDays.Text = string.Empty;
        GetClientMappingDetails();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        long productID = 0;
        if (!string.IsNullOrEmpty(hdnProductID.Value))
        {
            productID = Convert.ToInt64(hdnProductID.Value);
        }
        long clientID = 0;
        if (!string.IsNullOrEmpty(hdnClientID.Value))
        {
            clientID = Convert.ToInt64(hdnClientID.Value);
        }
        InventoryMaster_BL inventoryBL = new InventoryMaster_BL(base.ContextInfo);
        lstProducts = new List<Products>();
        inventoryBL.GetClientProductMappingDetails(productID, clientID, 0, string.Empty, string.Empty, 0, OrgID, "GET",0, out lstProducts);
        txtClientName.Text = string.Empty;
        txtQty.Text = string.Empty;
        ddlType.SelectedValue = "0";
        chkISActive.Checked = false;
        if (lstProducts != null && lstProducts.Count > 0)
        {
          
            cError.Attributes.Add("class", "hide");
            rpClientProductMapping.DataSource = lstProducts;
            rpClientProductMapping.DataBind();
        }
        else
        {

            cError.Attributes.Add("class", "show");
        }
    }

}
