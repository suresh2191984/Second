using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Data;
using System.IO;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.InventoryReports.BL;

public partial class Reports_InvestigationStockUsage :Attune_BasePage
{
    List<InventoryProductMapping> lsttotalInvest1 = new List<InventoryProductMapping>();
    List<Locations> lstLocation = new List<Locations>();
    List<InventoryItemsBasket> lstdevices = new List<InventoryItemsBasket>();
    List<ProductCategories> lstCategories = new List<ProductCategories>();
    List<Locations> lstLocations = new List<Locations>();
    long DeviceID=0;
    string DeviceName =string.Empty;
    string ProductName = string.Empty;
    string InvestigationName =string.Empty;
    int Location = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            txtFrom.Text = DateTime.Now.ToString("dd/MM/yyyy");
            txtTo.Text = DateTime.Now.ToString("dd/MM/yyyy");
            txtFrom.Focus();
            LoadLocationName();
            LoadDeviceName();

        }
    }
    private void LoadLocationName()
    {
        try
        {
            int OrgAddid = 0;
            new Master_BL(base.ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocation);
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
            ddlLocation.Items.Insert(0, "--ALL--");
            ddlLocation.Items[0].Value = "0";
            ddlLocation.SelectedValue = InventoryLocationID.ToString();
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }
    }
    public void LoadDeviceName()
    {

        new InventoryCommon_BL(base.ContextInfo).GetDeviceIDS(OrgID, out lstdevices);
        drpDevices.DataSource = lstdevices;
        drpDevices.DataTextField = "Description";
        drpDevices.DataValueField = "Description";
        drpDevices.DataBind();
        drpDevices.Items.Insert(0, "--Select--");
        drpDevices.Items[0].Value = "0"; 

    }



   
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadDeviceUsageProduct();
    }
    public void LoadDeviceUsageProduct()
    {
        DateTime fromdate;
        DateTime todate;

        try
        {
            fromdate = Convert.ToDateTime(txtFrom.Text);
            todate = Convert.ToDateTime(txtTo.Text);
            Location = Convert.ToInt32(ddlLocation.SelectedValue) > 0 ? Convert.ToInt32(ddlLocation.SelectedValue) : 0;
            ProductName = txtProduct.Text;
            DeviceName =  hdnDeviceID.Value ==""? "" :hdnDeviceID.Value;
            DeviceName = drpDevices.SelectedValue;
            InvestigationName = txtInvName.Text.Trim() == "" ? "" : txtInvName.Text.Trim();
            new InventoryReports_BL(ContextInfo).GetProductUsage(OrgID, ILocationID, fromdate, todate, Location, DeviceName, InvestigationName, ProductName, DeviceID, out lsttotalInvest1, out lstCategories, out lstLocations);
            if (lsttotalInvest1.Count > 0)
            {
                grdResult.DataSource = lsttotalInvest1;
                grdResult.DataBind();

                //GridView1.DataSource = lsttotalInvest1;
                //GridView1.DataBind();
                tdExcel.Attributes.Add("style", "block");
            }
            else
            {
                grdResult.DataSource = "";
                grdResult.DataBind();
            }
            txtProduct.Text ="";
            drpDevices.SelectedIndex =-1;
            txtInvName.Text ="";

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Device Using Products Details in investigation test", Ex);
        }
    }
    protected void imgBtnXL_Click(Object sender, EventArgs e)
    {
        try
        {
            grdResult.AllowPaging = false;
            LoadDeviceUsageProduct();
            ExportToExcel();
            grdResult.AllowPaging = true;
            grdResult.DataSource = lsttotalInvest1;
            grdResult.DataBind();
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    public void ExportToExcel()
    {
      
        string prefix = string.Empty;
        prefix = "Reports_";
        string rptDate = prefix + DateTime.Now.ToShortDateString();
        string attachment = "attachment; filename=" + rptDate + ".xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        HttpContext.Current.Response.Write( grdResult.Columns.Count);
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
        grdResult.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();
    }

    //protected void GridView1_DataBound1(object sender, EventArgs e)
    //{ 

    //    for (int rowIndex = GridView1.Rows.Count - 2; rowIndex >= 0; rowIndex--)
    //    {
    //    GridViewRow gvRow = GridView1.Rows[rowIndex];
    //    GridViewRow gvPreviousRow = GridView1.Rows[rowIndex + 1];
    //            for (int cellCount = 0; cellCount < gvRow.Cells.Count; cellCount++)
    //            {
    //                    if (gvRow.Cells[cellCount].Text == gvPreviousRow.Cells[cellCount].Text)
    //                    {
    //                            if (gvPreviousRow.Cells[cellCount].RowSpan < 2)
    //                            {
    //                              gvRow.Cells[cellCount].RowSpan = 2;
    //                            }
    //                            else
    //                            {
    //                              gvRow.Cells[cellCount].RowSpan = gvPreviousRow.Cells[cellCount].RowSpan + 1;
    //                            }
    //                    gvPreviousRow.Cells[cellCount].Visible = false;
    //                    }
    //            }
    //    }

   
    //}


    public override void VerifyRenderingInServerForm(Control control)
    {

    }


    
}
