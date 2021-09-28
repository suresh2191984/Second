using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Web.UI.HtmlControls;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.InventoryMaster.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.InventoryCommon.BL;


public partial class Inventory_InventoryLocation :Attune_BasePage
{
    public Inventory_InventoryLocation()
        : base("InventoryMaster_InventoryLocation_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryMaster_BL inventoryBL;
    InventoryMaster_BL AdminBL;
    LocationType objLocationType = new LocationType();
    List<LocationType> lstLocationType = new List<LocationType>();
    Locations objInvLocation = new Locations();
    List<Locations> lstInvLocation = new List<Locations>();
    List<ProductType> lstProductType = new List<ProductType>();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            inventoryBL = new InventoryMaster_BL(base.ContextInfo);
            AdminBL = new InventoryMaster_BL(base.ContextInfo);
            if (!IsPostBack)
            {
                btngetValues.Attributes.Add("class", "hide");
                BindLocationType();
                //BindProductType();
                BindLocationGrid();
                BindorgAddress();
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - InventoryLocation.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    private void BindorgAddress()
    { 
        List<OrganizationAddress> lstOrgLocation=new List<OrganizationAddress>();
        new Organization_BL(ContextInfo).pGetOrganizationLocation(OrgID, 0, 0, out lstOrgLocation);
        drpOrgAddress.DataSource = lstOrgLocation;
        drpOrgAddress.DataTextField = "Location";
        drpOrgAddress.DataValueField = "AddressID";
        drpOrgAddress.DataBind();
        drpOrgAddress.Items.Insert(0, GetMetaData("Select", "0"));
        drpOrgAddress.Items[0].Value = "0";
        drpOrgAddress.SelectedValue = ILocationID.ToString();

    }
    private void BindLocationType()
    {
        List<LocationType> lstTempLocationType = new List<LocationType>();
        List<LocationType> lstLocation = new List<LocationType>();
        try
        {
            new InventoryCommon_BL(ContextInfo).GetLocationType(out lstTempLocationType);
            foreach (LocationType item in lstTempLocationType)
            {
                if (item.LocationTypeCode == "CS")
                {
                    item.LocationTypeCode = item.LocationTypeName + " (" + item.LocationTypeCode + ")";
                    lstLocation.Add(item);
                }
                else if (item.LocationTypeCode == "POS")
                {
                    item.LocationTypeCode = item.LocationTypeName + " (" + item.LocationTypeCode + ")";
                    lstLocation.Add(item);
                }
                else if (item.LocationTypeCode == "POD")
                {
                    item.LocationTypeCode = item.LocationTypeName + " (" + item.LocationTypeCode + ")";
                    lstLocation.Add(item);
                }
                else if (item.LocationTypeCode == "CS-POS")
                {
                    item.LocationTypeCode = item.LocationTypeName + " (" + item.LocationTypeCode + ")";
                    lstLocation.Add(item);
                }
                else if (item.LocationTypeCode == "LY")
                {
                    item.LocationTypeCode = item.LocationTypeName + "(" + item.LocationTypeCode + ")";
                    lstLocation.Add(item);
                }
                      

            }

            ddlLocationType.DataSource = lstLocation;
            ddlLocationType.DataTextField = "LocationTypeCode";
            ddlLocationType.DataValueField = "LocationTypeID";
            ddlLocationType.DataBind();
            ddlLocationType.Items.Insert(0, GetMetaData("Select", "0"));
            ddlLocationType.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - InventoryLocation.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
       
    }
    //private void BindProductType()
    //{
        
    //    inventoryBL.GetProductType(OrgID,out lstProductType);
    //    chklistProductType.DataSource = lstProductType;
    //    chklistProductType.DataTextField = "TypeName";
    //    chklistProductType.DataValueField = "TypeID";
    //    chklistProductType.DataBind();
    //}
    string strSave = Resources.InventoryMaster_ClientDisplay.InventoryMaster_InventoryLocation_aspx_Save == null ? "Save" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_InventoryLocation_aspx_Save;
    string strUpdate = Resources.InventoryMaster_ClientDisplay.InventoryMaster_InventoryLocation_aspx_Update == null ? "Update" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_InventoryLocation_aspx_Update;
    string strSavesuccess = Resources.InventoryMaster_ClientDisplay.InventoryMaster_InventoryLocation_aspx_01 == null ? "Location Saved sucessfully" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_InventoryLocation_aspx_01;
    string strSaveErr = Resources.InventoryMaster_ClientDisplay.InventoryMaster_InventoryLocation_aspx_02 == null ? "Failed to Saving Location" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_InventoryLocation_aspx_02;
    string strUpdateSuccess = Resources.InventoryMaster_ClientDisplay.InventoryMaster_InventoryLocation_aspx_LocationUpdateMsg == null ? "Location Saved sucessfully" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_InventoryLocation_aspx_LocationUpdateMsg;
   string strUpdateErr = Resources.InventoryMaster_ClientDisplay.InventoryMaster_InventoryLocation_aspx_LocationUpdateFail == null ? "Failed to Updating Location" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_InventoryLocation_aspx_LocationUpdateFail;
   string errorMsg = Resources.InventoryMaster_AppMsg.InventoryMaster_Error == null ? "Alert" : Resources.InventoryMaster_AppMsg.InventoryMaster_Error;
    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            objInvLocation.OrgAddressID = ILocationID;
            objInvLocation.OrgID = OrgID;
            Locations objInvLocation1 = new Locations();
            objInvLocation1.ProductTypeID = "0";
            string userMsg = "";
            if (hdnLocationID.Value == "")
            {
                hdnLocationID.Value = "0";
            }
            else
            {
                objInvLocation1.LocationID = int.Parse(hdnLocationID.Value);
            }

            if (chkStatus.Checked == true)
            {
                objInvLocation.IsActive = "Y";
            }
            else
            {
                objInvLocation.IsActive = "N";
            }
            objInvLocation1.LocationName = txtLocation.Text;
            objInvLocation1.LocationTypeID = int.Parse(ddlLocationType.SelectedValue);
            objInvLocation1.OrgID = OrgID;
            objInvLocation1.CreatedBy = LID;
            objInvLocation1.OrgAddressID = int.Parse(drpOrgAddress.SelectedValue);
            objInvLocation1.IsActive = objInvLocation.IsActive;
            if (!string.IsNullOrEmpty(txtDLNO.Text.Trim()))
            {
                objInvLocation1.DLNO = txtDLNO.Text.Trim();
            }
            if (!string.IsNullOrEmpty(txtTinNo.Text.Trim()))
            {
                objInvLocation1.TINNO = txtTinNo.Text.Trim();
            }
            int ParentLocID = Convert.ToInt32(hdnSelLocationID.Value);
            objInvLocation1.ParentLocationID = ParentLocID;
            lstInvLocation.Add(objInvLocation1);

            List<Locations> lstLocat = new List<Locations>();
            returnCode = new Master_BL(base.ContextInfo).SaveInvLocation(lstInvLocation, lstLocat);
            if (returnCode == 0)
            {
                if (btnSave.Text == strSave)
                {
                    userMsg = strSavesuccess;
                }
                else if (btnSave.Text == strUpdate)
                {
                    userMsg = strUpdateSuccess;
                }
                BindLocationGrid();
                txtLocation.Text = "";
                ddlLocationType.SelectedValue = "0";
            }
            else
            {
                if (btnSave.Text == strSave)
                {
                    userMsg = strSaveErr;
                }
                else if (btnSave.Text == strUpdate)
                {
                    userMsg = strUpdateErr;
                }
                BindLocationGrid();
            }
            lblmsg.Visible = true;
            chkStatus.Checked = false;
            btnSave.Text = strSave;
            chkParent.Checked = false;
            hdnSelLocationID.Value = "0";
            txtParentLocation.Text = "";
            txtTinNo.Text = "";
                txtDLNO.Text="";
            ScriptManager.RegisterStartupScript(Page,this.GetType(),"SaveAlert","javascript:ValidationWindow('"+userMsg+"','"+errorMsg+"');",true);
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Saving Inventory Location - InventoryLocation.aspx", Ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    protected void btnGetItems(object sender, EventArgs e)
    {
        BindLocationGrid();
    }

    protected void gvLocation_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lbl = (Label)e.Row.FindControl("lblIsActive");
                HtmlAnchor objBtn = ((HtmlAnchor)e.Row.FindControl("lnk"));
                if (lbl.Text == "Y")
                {
                    objBtn.Disabled = false;
                    Locations RMaster = (Locations)e.Row.DataItem;
                    string Sct = "DeleteValues('" + RMaster.LocationInfo + "')";
                    objBtn.Attributes.Add("onclick", Sct);
                }
                else
                {
                    objBtn.Disabled = true;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DataRowBound in IsACtive", ex);
        }
    }

    public string BindLocationGrid()
    {
        try
        {
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;
            //int OrgAddid = ILocationID;
            //new GateWay(base.ContextInfo).GetInventoryConfigDetails("Locations_BasedOn_Org", OrgID, ILocationID, out lstInventoryConfig);
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
            new Master_BL(ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstInvLocation);
            
            gvLocation.DataSource = lstInvLocation;
            gvLocation.DataBind();            
            gvLocation.Visible = true;
          
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading Location - InventoryLocation.aspx", Ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
        return "";
       
    }   
}
