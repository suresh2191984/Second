using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.Quotation.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;

public partial class Quotation_ViewQuotation : Attune_BasePage
{
    public Quotation_ViewQuotation()
        : base("Quotation_ViewQuotation_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<Users> lstUsers = new List<Users>();
    List<Organization> lstOrganization = new List<Organization>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<QuotationMaster> lstQuotationMaster = new List<QuotationMaster>();
    Quotation_BL QuotationBL;
    int SupID = 0;
    int QuotationID = 0;
    string QuotationNo = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        QuotationBL = new Quotation_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            
            if (Request.QueryString["SID"] != null)
            {
                SupID = Convert.ToInt16(Request.QueryString["SID"]);
            }
            if (Request.QueryString["QID"] != null)
            {
                QuotationID = Convert.ToInt16(Request.QueryString["QID"]);
            }
            GetQuotationList();
            if (Request.QueryString["View"] != null)
            {
               // navigation.Style.Add("display", "none");
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadLeftMenu", "Showmenu();", true);
                //btnBack.Attributes.Add("class", "hide");
                btnClose.Visible = true;

            }
        }
    }
    public void GetQuotationList()
    {
        try
        {
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            QuotationBL.GetViewMappedProducts(OrgID, SupID, QuotationID, QuotationNo, out lstInventoryItemsBasket, out lstOrganization, out lstSuppliers, out lstQuotationMaster);
            if (lstInventoryItemsBasket.Count > 0)
            {
                grdResult.DataSource = lstInventoryItemsBasket;
                grdResult.DataBind();
            }

            lblOrgName.Text = lstOrganization[0].Name;
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_TinNo", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                tdTinNo.Attributes.Add("class", "show");
                lblOrgTinno.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
            }
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_LiNo", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                tdDLNo.Attributes.Add("class", "show");
                lblorgDlno.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
            }
            lblStreetAddress.Text = lstOrganization[0].Address;
            lblCity.Text = lstOrganization[0].City;
            lblPhone.Text = lstOrganization[0].PhoneNumber;
            if (lstSuppliers.Count > 0)
            {
                lblVendorName.Text = lstSuppliers[0].SupplierName;
                lblVendorTinno.Text = lstSuppliers[0].TinNo;
                lblVendorAddress.Text = lstSuppliers[0].Address1 + ", " + lstSuppliers[0].Address2;
                lblvendorState.Text = lstSuppliers[0].SupplierCode + ", " + lstSuppliers[0].ServiceTaxNo;

                if (lstSuppliers[0].SupplierCode == "" && lstSuppliers[0].ServiceTaxNo == "")
                {
                    lblvendorState.Text = lstSuppliers[0].SupplierCode;
                }
                else if (lstSuppliers[0].SupplierCode == "" && lstSuppliers[0].ServiceTaxNo != "")
                {
                    lblvendorState.Text = lstSuppliers[0].ServiceTaxNo;
                }
                else if (lstSuppliers[0].SupplierCode != "" && lstSuppliers[0].ServiceTaxNo == "")
                {
                    lblvendorState.Text = lstSuppliers[0].SupplierCode;
                }
                else
                {
                    lblvendorState.Text = lstSuppliers[0].SupplierCode + ", " + lstSuppliers[0].ServiceTaxNo;
                }
                if (lstSuppliers[0].PIN.ToString() != "")
                {
                    lblVendorCity.Text = lstSuppliers[0].City + "- " + lstSuppliers[0].PIN;
                }
                else
                {
                    lblVendorCity.Text = lstSuppliers[0].City;
                }

                lblVendorPhone.Text = lstSuppliers[0].Phone;
            }
            if (lstQuotationMaster.Count > 0)
            {
                lblQuotationNo.Text = lstQuotationMaster[0].QuotationNo;
                lblValFromDate.Text = lstQuotationMaster[0].ValidFrom.ToString("dd/MM/yyyy");
                lblValToDate.Text = lstQuotationMaster[0].ValidTo.ToString("dd/MM/yyyy");
                lblStatus.Text = lstQuotationMaster[0].Status;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in View Quotation :", ex);
        }
    }

    //protected void btnBack_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        if (Request.QueryString["ACN"] != null)
    //        {
    //            string strACN = Request.QueryString["ACN"];
    //            Response.Redirect(@"~/InventoryCommon/InventorySearch.aspx?ACN=" + strACN, true);
    //        }
    //        Response.Redirect("~/InventoryCommon/InventorySearch.aspx");

    //    }
    //    catch (System.Threading.ThreadAbortException tex)
    //    {
    //        string te = tex.ToString();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
    //    }
    //}

    protected void btnClose_Click(object sender, EventArgs e)
    {
        ClientScript.RegisterClientScriptBlock(Page.GetType(), "script", "window.close();", true);
    }

}