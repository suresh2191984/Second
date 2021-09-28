using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using System.Collections.Generic;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryMaster.BL;

public partial class Inventory_Customers : Attune_BasePage
{
    public Inventory_Customers()
        : base("InventoryMaster\\Customers.aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<Customers> lstCustomer = new List<Customers>();
    List<CustomerLocations> lstCustomerLocations = new List<CustomerLocations>();
    Customers objCustomer = new Customers();
    CustomerLocations objCustomerLocations;
    List<CustomerType> lstCustomerType = new List<CustomerType>();
    InventoryMaster_BL inventoryMasterBL;
    string CustomerName, TinNumber;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryMasterBL = new InventoryMaster_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                GetCustomerType();
                GetCustomerList(); 
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Hide Address div", "showResponses('Div1','Div2','divLocation',0);", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page_Load", ex);
        }
    }
    public void GetCustomerType()
    {
        long returnCode = -1;
        returnCode = inventoryMasterBL.GetCustomerType(OrgID,out lstCustomerType);
        ddlCustomerType.DataSource = lstCustomerType;
        ddlCustomerType.DataTextField = "CustomerTypeName";
        ddlCustomerType.DataValueField = "CustomerTypeID";
        ddlCustomerType.DataBind();
        ListItem ddlselect = GetMetaData("Select", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }

        ddlCustomerType.Items.Insert(0, ddlselect);
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            lblmsg.Text = "";
            long returnCode = -1;
            objCustomer.CustomerID = int.Parse(hdnId.Value);
            objCustomer.CustomerName = txtCustomerName.Text.Trim();
            objCustomer.Address1 = txtAddress1.Text.Trim();
            objCustomer.Address2 = txtAddress2.Text.Trim();
            objCustomer.City = txtCity.Text.Trim();
            objCustomer.Phone = txtPhoneNumber.Text.Trim();
            objCustomer.Mobile = txtMobileNumber.Text.Trim();
            objCustomer.OrgID = OrgID;
            objCustomer.CreatedBy = LID;
            objCustomer.ContactPerson = txtContactPerson.Text.Trim();
            objCustomer.EmailID = txtEmailID.Text.Trim();
            objCustomer.OrgAddressID = ILocationID;
            objCustomer.TINNo = txtTinNo.Text.Trim();
            objCustomer.FaxNumber = txtFaxNumber.Text.Trim(); 
            objCustomer.TermsConditions = txtTermsCondition.Text.Trim();
            objCustomer.PANNumber = txtPan.Text.Trim();
            objCustomer.CSTNo = txtCSTNumber.Text.Trim();
            objCustomer.DrugLicenceNo = txtDrugLicenceNo.Text.Trim();
            objCustomer.ServiceTaxNo = txtServiceTaxNo.Text.Trim();
            objCustomer.CustomerTypeID = Convert.ToInt32(ddlCustomerType.SelectedValue);
            objCustomer.CreatedAt = DateTimeUtility.GetServerDate();
            objCustomer.ModifiedAt = DateTimeUtility.GetServerDate();
            objCustomer.IsDeleted = "N";
            if (chkDelete.Checked == false)
            {
                objCustomer.IsDeleted = "Y";
            }
            lstCustomer.Add(objCustomer);
            foreach (string listParent in hdnLocationDetails.Value.Split('^'))
            {
                if (listParent != "")
                {
                    objCustomerLocations = new CustomerLocations();
                    string[] listChild = listParent.Split('|');

                    objCustomerLocations.LocationName = listChild[0];
                    objCustomerLocations.Address = listChild[1];
                    objCustomerLocations.LocationID = int.Parse(listChild[2]);
                    objCustomerLocations.CustomerID = int.Parse(hdnId.Value) > 0 ? int.Parse(hdnId.Value) : 0;
                    objCustomerLocations.CustomerName = "";
                    objCustomerLocations.City = "";
                    objCustomerLocations.OrgAddressID = ILocationID;
                    objCustomerLocations.OrgID = OrgID;
                    objCustomerLocations.CreatedAt = DateTimeUtility.GetServerDate();
                    objCustomerLocations.CreatedBy = LID; 
                    objCustomerLocations.ModifiedAt = DateTimeUtility.GetServerDate();
                    objCustomerLocations.ModifiedBy = LID;


                    lstCustomerLocations.Add(objCustomerLocations);
                }
            } 
            returnCode = inventoryMasterBL.SaveCustomer(OrgID, ILocationID, lstCustomer, lstCustomerLocations);
            string strUpdate = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Customers_aspx_02 == null ? "Update" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Customers_aspx_02;
            string strAdd = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Customers_aspx_03 == null ? "Save" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Customers_aspx_03;
            string strSuccessUpdate = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Customers_aspx_12 == null ? "Customer Updated sucessfully" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Customers_aspx_12;
            string strSuccessAdd = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Customers_aspx_13 == null ? "Customer Added sucessfully" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Customers_aspx_13;
            string strFailUpdate = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Customers_aspx_14 == null ? "Customer Updated Failed" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Customers_aspx_14;
            string strFailAdd = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Customers_aspx_15 == null ? "Customer Added Failed" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Customers_aspx_15;

            if (returnCode == 0)
            {
                GetCustomerType();
                ClearFields();
                GetCustomerList();   
                if (hdnStatus.Value == strUpdate)
                {
                    lblmsg.Text = strSuccessUpdate;
                }
                else
                {
                    lblmsg.Text = strSuccessAdd;
                }
                hdnStatus.Value = "";
            }
            else
            { 
                if (hdnStatus.Value == strUpdate)
                {
                    lblmsg.Text = strFailUpdate; 
                }
                else
                {
                    lblmsg.Text = strFailAdd; 
                }
            }
            hdnLocationDetails.Value = "";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving Customer - Customers.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    public void GetCustomerList()
    {
        CustomerName = txtSrchCustomerName.Text;
        TinNumber = txtSrchTinNumber.Text.Trim();
        inventoryMasterBL.GetCustomersDetails(OrgID, ILocationID, CustomerName, TinNumber, out lstCustomer, out lstCustomerLocations); 
        for (int i = 0; i < lstCustomerLocations.Count; i++)
        {
            hdnCustomerLocations.Value += lstCustomerLocations[0].LocationID.ToString() + "~" + lstCustomerLocations[0].CustomerID.ToString() + "~" +
                                          lstCustomerLocations[0].LocationName + "~" + lstCustomerLocations[0].Address + "^";
        }
        grdCustomer.DataSource = lstCustomer;
        grdCustomer.DataBind();
    }
    public void ClearFields()
    {
        txtCustomerName.Text = "";
        txtAddress1.Text = "";
        txtAddress2.Text = "";
        txtCity.Text = "";
        txtPhoneNumber.Text = "";
        txtMobileNumber.Text = "";
        txtContactPerson.Text = "";
        txtEmailID.Text = "";
        txtTinNo.Text = "";
        txtFaxNumber.Text = "";
        txtTermsCondition.Text = "";
        txtPan.Text = "";
        txtCSTNumber.Text = "";
        txtDrugLicenceNo.Text = "";
        txtServiceTaxNo.Text = "";
        ddlCustomerType.SelectedItem.Value = "0";
        chkDelete.Checked = false;
        hdnId.Value = "0"; 
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        CustomerName = txtSrchCustomerName.Text;
        TinNumber = txtSrchTinNumber.Text.Trim();
        inventoryMasterBL.GetCustomersDetails(OrgID, ILocationID, CustomerName, TinNumber, out lstCustomer, out lstCustomerLocations);
        grdCustomer.DataSource = lstCustomer;
        grdCustomer.DataBind(); 
    }
    protected void grdCustomer_RowDataBound(object sender, GridViewRowEventArgs e)
    {  
    }
}