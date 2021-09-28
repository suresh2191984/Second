using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.LabConsumptionInventory.BL;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Utility;
using System.Web.Script.Serialization;

public partial class LabConsumptionInventory_DevicesStockUsage : Attune_BasePage
{
    #region CommonDeclaration
    LabConsumptionInventory_BL objConInvBL;
    #endregion

    public LabConsumptionInventory_DevicesStockUsage()
        : base("LabConsumptionInventory_DevicesStockUsage_aspx")
    { }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindAnalyzerName();
        }
        hdnOrgid.Value = OrgID.ToString();
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

            //ddldevicesName.DataSource = lstDevice;
            //ddldevicesName.DataTextField = "DeviceID";
            //ddldevicesName.DataValueField = "DeviceID";
            //ddldevicesName.DataBind();
            //ddldevicesName.Items.Insert(0, ddlselect);


        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on Loading BindAnalyzerName in LabConsumptionInventory_DevicesStockUsage.aspx.aspx", ex);
        }
    }

    protected void btnLoad_Click(object sender, EventArgs e)
    {       
        try
        {
            BindGridStockLoadedAndStockToLoaded(ddlAnalyzerName.SelectedValue, "StockLoaded");
           // Page.ClientScript.RegisterStartupScript(this.GetType(), "DisplayTab", "DisplayTab('SL');", true);
        }
        catch (Exception ex)
        { 
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on Loading btnLoad_Click in LabConsumptionInventory_DevicesStockUsage.aspx", ex);
        }
        

       
    }

    //protected void btnSTLload_Click(object sender, EventArgs e)
    //{
       
    //    try
    //    {
    //        BindGridStockLoadedAndStockToLoaded(ddlAnalyzerName.SelectedValue, "StockToLoaded");
    //        //Page.ClientScript.RegisterStartupScript(this.GetType(), "DisplayTab", "DisplayTab('STL');", true);     
               
    //    }
    //    catch (Exception ex)
    //    {
    //        Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
    //        CLogger.LogError("Error on Loading btnLoad_Click in LabConsumptionInventory_DevicesStockUsage.aspx", ex);
    //    }
    //}

    protected void btnSLBulkUnload_Click(object sender, EventArgs e)
    {
        try
        {
            DMLStockLoadAndStockToLoad("StockLoaded");
        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on Loading gvStockLoaded_RowCommand in LabConsumptionInventory_DevicesStockUsage.aspx", ex);
        }

    }


    protected void gvStockLoaded_RowCommand(object sender, GridViewCommandEventArgs e)
    {  
        try
        {      
           // int rowRow = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "SLUnload")
            {
                DMLStockLoadAndStockToLoad("StockLoaded"); 
            }
        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on Loading gvStockLoaded_RowCommand in LabConsumptionInventory_DevicesStockUsage.aspx", ex);
        }
    }

    protected void gvStockToLoaded_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "load")
            {
                DMLStockLoadAndStockToLoad("StockToLoaded"); 
            }
        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on Loading gvStockToLoaded_RowCommand in LabConsumptionInventory_DevicesStockUsage.aspx", ex);
        }
    }


    private long BindGridStockLoadedAndStockToLoaded(string strDevicesID, string strSearchType)
    {

        long returnCode = -1;
        objConInvBL = new LabConsumptionInventory_BL(base.ContextInfo);
        List<IVYDeviceStockUsage> lstDSU = new List<IVYDeviceStockUsage>();

        List<IVYDeviceStockUsage> lstStockLoaad = new List<IVYDeviceStockUsage>();

        try
        {
            returnCode = objConInvBL.GetStockloadandStockToloaded(strDevicesID, strSearchType, out lstDSU);

            
            lstStockLoaad = lstDSU.Where(SL => SL.DeviceStockUsageID == 0).ToList();

            gvStockToLoaded.DataSource = lstStockLoaad.Count > 0 ? lstStockLoaad : null;
            gvStockToLoaded.DataBind();

            if (lstStockLoaad.Count > 0)
            {
                tblSTLBarcode.Attributes.Add("class", "displaytbl h-50");
                tdSTL.Attributes.Add("class", "displaytd a-center h-40");
            }
            else {
                tblSTLBarcode.Attributes.Add("class", "hide");
                tdSTL.Attributes.Add("class", "hide");
            }


            lstStockLoaad = lstDSU.Where(SL => SL.DeviceStockUsageID > 0).ToList();
            gvStockLoaded.DataSource = lstStockLoaad.Count > 0 ? lstStockLoaad : null;
            gvStockLoaded.DataBind();

            if (lstStockLoaad.Count > 0)
            {
                tdSLbtn.Attributes.Add("class", "displaytd a-center h-40");
            }
            else {
                tdSLbtn.Attributes.Add("class", "hide");
            }


        }
        catch (Exception ex)
        {
            throw ex;
        }
        return returnCode;
    }

    private void DMLStockLoadAndStockToLoad(string strActionType )
    {
        JavaScriptSerializer JSserializer = new JavaScriptSerializer();
        objConInvBL = new LabConsumptionInventory_BL(base.ContextInfo);
        List<IVYDeviceStockUsage> lstIDSU = new List<IVYDeviceStockUsage>();
        long returncode = -1;

        try
        {
            if (strActionType == "StockLoaded")
            {
                lstIDSU = JSserializer.Deserialize<List<IVYDeviceStockUsage>>(hdnDevicesUnloadData.Value);
                returncode = objConInvBL.DMLStockloadandAndStockToLoad(OrgID, strActionType, lstIDSU);
                BindGridStockLoadedAndStockToLoaded(ddlAnalyzerName.SelectedValue, strActionType);
            }
            else
            {
                lstIDSU = JSserializer.Deserialize<List<IVYDeviceStockUsage>>(hdnSTLloadData.Value);
                returncode = objConInvBL.DMLStockloadandAndStockToLoad(OrgID, strActionType, lstIDSU);
                BindGridStockLoadedAndStockToLoaded(ddlAnalyzerName.SelectedValue, strActionType);

            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally {
            hdnSTLloadData.Value = string.Empty;
            hdnDevicesUnloadData.Value = string.Empty;
        }
    }

    protected void btnBulkLoad_Click(object sender, EventArgs e)
    {
        try
        {
            DMLStockLoadAndStockToLoad("StockToLoaded");
        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on Loading btnBulkLoad_Click in LabConsumptionInventory_DevicesStockUsage.aspx", ex);
        }
    }
}
