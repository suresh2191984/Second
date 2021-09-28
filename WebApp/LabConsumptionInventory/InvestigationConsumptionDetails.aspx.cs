using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.LabConsumptionInventory.BL;
using System.Web.Script.Serialization;

public partial class LabConsumptionInventory_InvestigationConsumptionDetails : Attune_BasePage
{
    public LabConsumptionInventory_InvestigationConsumptionDetails()
        : base("LabConsumptionInventory_InvestigationConsumptionDetails_aspx")
    { }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    #region CommonDeclaration
    LabConsumptionInventory_BL objConInvBL;
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindConsumptionTypeDropdown();
            BindAnalyzerName();
        }
        txtDate.Text = DateTimeNow.ToExternalDateTime();
    }

    private void BindConsumptionTypeDropdown()
    {
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();
        MetaData objMeta;
        long returncode; string dStrDomains = "ConsumptionType";

        try
        {
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }


            string[] Tempdata = dStrDomains.Split(',');

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }

            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);


            ddlConsumptionType.DataSource = lstmetadataOutput;
            ddlConsumptionType.DataTextField = "DisplayText";
            ddlConsumptionType.DataValueField = "Code";
            ddlConsumptionType.DataBind();
            ddlConsumptionType.Items.Insert(0, ddlselect);
        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on Loading BindConsumptionTypeDropdown in InvestigationConsumptionDetails.aspx", ex);
        }
    }

    private void BindAnalyzerName()
    {
        long ReturnCode = -1;
        objConInvBL = new LabConsumptionInventory_BL(base.ContextInfo);
        List<DeviceIntegrationOrgMapping> lstDevice = new List<DeviceIntegrationOrgMapping>();
        try
        {
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }

            ReturnCode = objConInvBL.GetOrgwiseAnalyzerName(OrgID, out lstDevice);
            ddlAnalyzerName.DataSource = lstDevice;
            ddlAnalyzerName.DataTextField = "InstrumentName";
            ddlAnalyzerName.DataValueField = "DeviceID";
            ddlAnalyzerName.DataBind();
            ddlAnalyzerName.Items.Insert(0, ddlselect);
        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on Loading BindAnalyzerName in InvestigationConsumptionDetails.aspx", ex);
        }
    }

    protected void btnLoad_Click(object sender, EventArgs e)
    {
        long ReturnCode = -1;
        objConInvBL = new LabConsumptionInventory_BL(base.ContextInfo);
        List<IVYInvestigationProductMapping> lstDevicesInvestigation = new List<IVYInvestigationProductMapping>();

        try
        {
            // string strNorecord = Resources.InventoryBillingCommon_ClientDisplay.InventoryBillingCommon_BillSearch_aspx_01 == null ? "No matching records found" : Resources.InventoryBillingCommon_ClientDisplay.InventoryBillingCommon_BillSearch_aspx_01;
            // string errMsg = Resources.InventoryBillingCommon_AppMsg.InventoryBillingCommon_Error == null ? "Alert" : Resources.InventoryBillingCommon_AppMsg.InventoryBillingCommon_Error;


            ReturnCode = objConInvBL.GetOrgBasedDevicesInvestigation(OrgID, ddlAnalyzerName.SelectedValue, out lstDevicesInvestigation);

            if (lstDevicesInvestigation.Count > 0)
            {
                tdConsumption.Attributes.Add("class", "displaytd");
                tdConsumptionTab.Attributes.Add("class", "displaytd");
                gvInvestigationDevices.DataSource = lstDevicesInvestigation;
                gvInvestigationDevices.DataBind();

            }
            else
            {
                tdConsumptionTab.Attributes.Add("class", "hide");
                tdConsumption.Attributes.Add("class", "hide");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "ValidationWindow('" + "No matching records found !. " + "','" + "Alert" + "');", true);
            }
        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on Loading btnLoad_Click in InvestigationConsumptionDetails.aspx", ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        JavaScriptSerializer JSserializer = new JavaScriptSerializer();
        List<IVYAdditionalConsumption> lstAddConsumption = new List<IVYAdditionalConsumption>();
        objConInvBL = new LabConsumptionInventory_BL(base.ContextInfo);
        long ReturnCode = -1;
        try
        {

            lstAddConsumption = JSserializer.Deserialize<List<IVYAdditionalConsumption>>(hdnInvDevicesData.Value);

            ReturnCode = objConInvBL.SaveAdditionalConsumption(lstAddConsumption);

            

            if (ReturnCode == 0)
            {
                ddlAnalyzerName.SelectedValue = "0";
                ddlConsumptionType.SelectedValue = "0";
                txtNoOfTimes.Text = string.Empty;

                tdConsumption.Attributes.Add("class", "hide");
                tdConsumptionTab.Attributes.Add("class", "hide");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "ValidationWindow('" + "Consumption Details saved sucessfully !. " + "','" + "Alert" + "');", true);
            }
        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on Loading btnSave_Click in InvestigationConsumptionDetails.aspx", ex);
        }
    }

}
