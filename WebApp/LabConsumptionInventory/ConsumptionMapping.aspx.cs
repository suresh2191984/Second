using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.LabConsumptionInventory.BL;
using Attune.Kernel.PlatForm.Utility;
using System.Web.Script.Serialization;

public partial class LabConsumptionInventory_ConsumptionMapping : Attune_BasePage
{

    public LabConsumptionInventory_ConsumptionMapping()
        : base("LabConsumptionInventory_ConsumptionMapping_aspx")
    { }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            hdnOrgid.Value = Convert.ToString(OrgID);
            if (!IsPostBack)
            {
                BindAnalyzerName();
                GetMathodName();
                BindInventoryUOM();
            }
        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on ConsumptionMapping in InvestigationConsumptionDetails.aspx", ex);
        }
    }

    #region CommonDeclaration
    LabConsumptionInventory_BL objConInvBL;
    #endregion

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    private void BindAnalyzerName()
    {
        long ReturnCode = -1;
        objConInvBL = new LabConsumptionInventory_BL(base.ContextInfo);
        List<DeviceIntegrationOrgMapping> lstDevice = new List<DeviceIntegrationOrgMapping>();
        try
        {
            ListItem ddlselect = ddlselectValue();

            ReturnCode = objConInvBL.GetOrgwiseAnalyzerName(OrgID, out lstDevice);
            ddlAnalyzerName.DataSource = lstDevice;
            ddlAnalyzerName.DataTextField = "InstrumentName";
            ddlAnalyzerName.DataValueField = "DeviceID";
            ddlAnalyzerName.DataBind();
            ddlAnalyzerName.Items.Insert(0, ddlselect);

            ddlseaAnalyzerName.DataSource = lstDevice;
            ddlseaAnalyzerName.DataTextField = "InstrumentName";
            ddlseaAnalyzerName.DataValueField = "DeviceID";
            ddlseaAnalyzerName.DataBind();
            ddlseaAnalyzerName.Items.Insert(0, ddlselect);


        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on Loading BindAnalyzerName in InvestigationConsumptionDetails.aspx", ex);
        }
    }

    private ListItem ddlselectValue()
    {
        ListItem ddlselect = GetMetaData("Select", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        return ddlselect;
    }

    private void GetMathodName()
    {
        objConInvBL = new LabConsumptionInventory_BL(base.ContextInfo);
        long returnCode = -1;
        List<InvestigationMethod> lstInvMethod = new List<InvestigationMethod>();
        try
        {

            ListItem ddlselect = ddlselectValue();
            returnCode = objConInvBL.GetInvestigationMethod(OrgID, string.Empty, out lstInvMethod);

            if (lstInvMethod.Count > 0)
            {
                ddlMethodName.DataSource = lstInvMethod;
                ddlMethodName.DataTextField = "MethodName";
                ddlMethodName.DataValueField = "MethodID";
                ddlMethodName.DataBind();

                ddlseaMethodName.DataSource = lstInvMethod;
                ddlseaMethodName.DataTextField = "MethodName";
                ddlseaMethodName.DataValueField = "MethodID";
                ddlseaMethodName.DataBind();


            }
            ddlMethodName.Items.Insert(0, ddlselect);
            ddlseaMethodName.Items.Insert(0, ddlselect);
        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on Loading BindAnalyzerName in InvestigationConsumptionDetails.aspx", ex);
        }

    }

    private void BindInventoryUOM()
    {
        long returncode = -1;
        objConInvBL = new LabConsumptionInventory_BL(base.ContextInfo);
        List<InventoryUOM> lstInvUOM = new List<InventoryUOM>();
        try
        {

            ListItem ddlselect = ddlselectValue();
            returncode = objConInvBL.GetInventoryUOMOrgMapping(OrgID, out lstInvUOM);

            if (lstInvUOM.Count > 0)
            {

                ddlUOMID.DataSource = lstInvUOM;
                ddlUOMID.DataTextField = "UOMDescription";
                ddlUOMID.DataValueField = "UOMID";
                ddlUOMID.DataBind();

                ddlCalibrationUOMID.DataSource = lstInvUOM;
                ddlCalibrationUOMID.DataTextField = "UOMDescription";
                ddlCalibrationUOMID.DataValueField = "UOMID";
                ddlCalibrationUOMID.DataBind();
            }
            ddlUOMID.Items.Insert(0, ddlselect);
            ddlCalibrationUOMID.Items.Insert(0, ddlselect);
        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on BindInventoryUOM in InvestigationConsumptionDetails.aspx", ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        JavaScriptSerializer JSserializer = new JavaScriptSerializer();
        objConInvBL = new LabConsumptionInventory_BL(base.ContextInfo);
        List<IVYInvestigationProductMappingDetails> lstInvProductMappingDetails = new List<IVYInvestigationProductMappingDetails>();
        long returncode = -1;

        try
        {


            lstInvProductMappingDetails = JSserializer.Deserialize<List<IVYInvestigationProductMappingDetails>>(hdnlstInvestigationProductMappingDetails.Value);
            returncode = objConInvBL.SaveInvestigationProductMappingDetails(OrgID, lstInvProductMappingDetails);
            if (returncode == 0)
            {
                Clear();
                //string sPath = Resources.LabConsumptionInventory_AppMsg.LabConsumptionInventory_ConsumptionMapping_aspx_10;
                //sPath = sPath == null ? "Product mapped sucessfully !." : sPath;

                //string errorMsg = Resources.LabConsumptionInventory_AppMsg.LabConsumptionInventory_ConsumptionMapping_as;
                //errorMsg = errorMsg == null ? "Alert" : errorMsg;
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "clear", "javascript:ValidationWindow('" + sPath + "','" + errorMsg + "');", true);


                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "ValidationWindow('" + "Product mapped sucessfully !. " + "','" + "Alert" + "');", true);
            }

        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on BindInventoryUOM in InvestigationConsumptionDetails.aspx", ex);
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
    }
    
    protected void btnGo_Click(object sender, EventArgs e)
    {

        try
        {
            BindGrid();
        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on BindInventoryUOM in InvestigationConsumptionDetails.aspx", ex);
        }
    }

    private void BindGrid()
    {
        System.Web.Script.Serialization.JavaScriptSerializer oSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();

        objConInvBL = new LabConsumptionInventory_BL(base.ContextInfo);
        List<IVYInvestigationProductMappingDetails> lstInvProductMappingDetails = new List<IVYInvestigationProductMappingDetails>();

        long returncode = -1;
        returncode = objConInvBL.pgetInvestigationProductMappingDetails(OrgID, Convert.ToInt64(hdnseaInvestigationID.Value), ddlseaAnalyzerName.SelectedValue, Convert.ToInt64(ddlseaMethodName.SelectedValue), out lstInvProductMappingDetails);

        gvInvestigationDevices.DataSource = lstInvProductMappingDetails.Count > 0 ? lstInvProductMappingDetails : null;
        gvInvestigationDevices.DataBind();

        if (lstInvProductMappingDetails.Count > 0)
        {
            trContent.Attributes.Add("class", "trdisplay");
            hdnGVJsonData.Value = oSerializer.Serialize(lstInvProductMappingDetails);         
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "ValidationWindow('" + "No records found !. " + "','" + "Alert" + "');", true);
        }
    }

    private void Clear()
    {
        txtTestName.Text = string.Empty;
        txtseaTestName.Text = string.Empty;
        ddlseaAnalyzerName.SelectedValue = "0";
        ddlseaMethodName.SelectedValue = "0";
        gvInvestigationDevices.DataSource = null;
        gvInvestigationDevices.DataBind();
    }


}
