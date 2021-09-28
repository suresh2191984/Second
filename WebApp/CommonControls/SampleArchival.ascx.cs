using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Drawing;
using System.Web.Script.Serialization;
using System.Web.Services;


public partial class CommonControls_SampleArchival : BaseControl
{
    string select = Resources.CommonControls_AppMsg.CommonControls_SampleArchival_ascx_01 == null ? "--Select--" : Resources.CommonControls_AppMsg.CommonControls_SampleArchival_ascx_01;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                LoadDropDown("BUILDING", ddlBuilding, 0);
                ddlFloor.Items.Insert(0, select);
                ddlFloor.Items[0].Value = "0";
                ddlStorageArea.Items.Insert(0, select);
                ddlStorageArea.Items[0].Value = "0";
                ddlStorageUnit.Items.Insert(0, select);
                ddlStorageUnit.Items[0].Value = "0";
                ddlTray.Items.Insert(0, select);
                ddlTray.Items[0].Value = "0";

                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Sample Archival page load", ex);
        }
    }

    private void LoadDropDown(string pType, DropDownList ddl, int pId)
    {
        long returnCode = -1;
        RoomBooking_BL RoomBL = new RoomBooking_BL();
        List<RoomDetails> lstRoomDetails = new List<RoomDetails>();
        List<RoomDetails> lstFilterlist = new List<RoomDetails>();
        if (pType == "STORAGEUNIT" || pType == "TRAY")
        {
            int pBuildingID = int.Parse(ddlBuilding.SelectedValue);
            int pFloorID = int.Parse(ddlFloor.SelectedValue);
            int pStorageArea = int.Parse(ddlStorageArea.SelectedValue);
            string pStorageUnit = Convert.ToString(ddlStorageUnit.SelectedItem);
            string pTrayType = Convert.ToString(ddlTray.SelectedItem);
            if (pStorageUnit == select)
            {
                pStorageUnit = "";
            }
            if (pTrayType == select)
            {
                pTrayType = "";
            }
            returnCode = RoomBL.GetRoomsDetails(OrgID, ILocationID, pBuildingID, 0, pFloorID, pStorageArea, pStorageUnit, pTrayType, out lstRoomDetails);
            if (pType == "STORAGEUNIT")
            {
                lstFilterlist = (from list in lstRoomDetails
                                 group list by new { list.RoomName, list.RoomID } into gList
                                 select new RoomDetails
                                 {
                                     RoomID = gList.Key.RoomID,//StorageUnitID
                                     RoomName = gList.Key.RoomName//StorageUnitName
                                 }).Distinct().ToList<RoomDetails>();
                ddl.DataSource = lstFilterlist;
                ddl.DataTextField = "RoomName";
                ddl.DataValueField = "RoomID";
                ddl.DataBind();
                ddl.Items.Insert(0, select);
                ddl.Items[0].Value = "0";
            }
            if (pType == "TRAY")
            {
                lstFilterlist = (from list in lstRoomDetails
                                 group list by new { list.WardName, list.ID } into gList
                                 select new RoomDetails
                                 {
                                     WardID = gList.Key.ID,//TrayID
                                     WardName = gList.Key.WardName//TrayName
                                 }).Distinct().ToList<RoomDetails>();
                ddl.DataSource = lstFilterlist;
                ddl.DataTextField = "WardName";
                ddl.DataValueField = "WardID";
                ddl.DataBind();
                ddl.Items.Insert(0, select);
                ddl.Items[0].Value = "0";
            }
        }
        else
        {
            returnCode = RoomBL.LoadRoomMasterDetails(pType, OrgID, ILocationID, pId, out lstRoomDetails);
            ddl.DataSource = lstRoomDetails;
            ddl.DataTextField = "Name";
            ddl.DataValueField = "ID";
            ddl.DataBind();
            ddl.Items.Insert(0, select);
            ddl.Items[0].Value = "0";
        }
    }

    protected void ddlBuilding_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int pId = 0;
            Int32.TryParse(ddlBuilding.SelectedValue, out pId);
            LoadDropDown("FLOOR", ddlFloor, pId);
        }
        catch (Exception Ex)
        {
        }
    }
    protected void ddlFloor_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int pId = 0;
            Int32.TryParse(ddlFloor.SelectedValue, out pId);
            LoadDropDown("STORAGE_AREA", ddlStorageArea, pId);
        }
        catch (Exception Ex)
        {
        }
    }
    protected void ddlStorageArea_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int pId = 0;
            Int32.TryParse(ddlStorageArea.SelectedValue, out pId);
            LoadDropDown("STORAGEUNIT", ddlStorageUnit, pId);
        }
        catch (Exception Ex)
        {
        }
    }
    protected void ddlStorageUnit_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int pId = 0;
            Int32.TryParse(ddlStorageUnit.SelectedValue, out pId);
            LoadDropDown("TRAY", ddlTray, pId);
        }
        catch (Exception Ex)
        {
        }
    }

    protected void ddlTray_SelectedIndexChanged(object sender, EventArgs e)
    {

        try
        {
           // btnSaveSampleArchival.Visible = true;
            Investigation_BL oInvestigation_BL = new Investigation_BL(base.ContextInfo);
            int rackId = 0;
            string barcodeNo = string.Empty;
            Int32.TryParse(ddlTray.SelectedValue, out rackId);
            List<SampleArchival> lstSampleArchival = new List<SampleArchival>();
            oInvestigation_BL.GetSampleArchivalDetails(rackId, barcodeNo, out lstSampleArchival);
            int ColumnCount = (from SA in lstSampleArchival
                               select SA.ColumnNo).Max();
            dlSampleArchival.RepeatColumns = ColumnCount;
            dlSampleArchival.DataSource = lstSampleArchival;
            dlSampleArchival.DataBind();
        }
        catch (Exception Ex)
        {
        }


    }

    public void Search()
    {
        if (ddlBuilding.Items.FindByValue(hdnBuldID.Value) != null)
        {
        ddlBuilding.SelectedValue = hdnBuldID.Value;
        }
        ddlBuilding.Enabled = false;
        int pId = 0;
        Int32.TryParse(ddlBuilding.SelectedValue, out pId);
        LoadDropDown("FLOOR", ddlFloor, pId);
        if (ddlFloor.Items.FindByValue(hdnFloorID.Value) != null)
        {
            ddlFloor.SelectedValue = hdnFloorID.Value;
        }
        ddlFloor.Enabled = false;

        Int32.TryParse(ddlFloor.SelectedValue, out pId);
        LoadDropDown("STORAGE_AREA", ddlStorageArea, pId);
        if (ddlStorageArea.Items.FindByValue(hdnStroageID.Value) != null)
        {
            ddlStorageArea.SelectedValue = hdnStroageID.Value;
        }
        ddlStorageArea.Enabled = false;
        Int32.TryParse(ddlStorageArea.SelectedValue, out pId);
        LoadDropDown("STORAGEUNIT", ddlStorageUnit, pId);
        if (ddlStorageUnit.Items.FindByValue(hdnStorgeUnit.Value) != null)
        {
            ddlStorageUnit.SelectedValue = hdnStorgeUnit.Value;
        }
        ddlStorageUnit.Enabled = false;
        Int32.TryParse(ddlStorageUnit.SelectedValue, out pId);
        LoadDropDown("TRAY", ddlTray, pId);
        if (ddlTray.Items.FindByValue(hdnTryID.Value) != null)
        {
            ddlTray.SelectedValue = hdnTryID.Value;
        }
        ddlTray.Enabled = false;

       // btnSaveSampleArchival.Visible = true;
        Investigation_BL oInvestigation_BL = new Investigation_BL(base.ContextInfo);
        int rackId = 0;
        string barcodeNo = string.Empty;
        Int32.TryParse(ddlTray.SelectedValue, out rackId);             
        List<SampleArchival> lstSampleArchival = new List<SampleArchival>();
        oInvestigation_BL.GetSampleArchivalDetails(rackId, barcodeNo, out lstSampleArchival);
        if (lstSampleArchival.Count > 0)
        {
            int ColumnCount = (from SA in lstSampleArchival
                               select SA.ColumnNo).Max();
            dlSampleArchival.RepeatColumns = ColumnCount;
            dlSampleArchival.DataSource = lstSampleArchival;
            dlSampleArchival.DataBind();
        }
    }
    protected void dlSampleArchival_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType != ListItemType.Header && e.Item.ItemType != ListItemType.Footer)
            {
                Label lblStatus = new Label();
                lblStatus = (Label)e.Item.FindControl("lblStatus");
                HtmlTableCell tdSlot = new HtmlTableCell();
                tdSlot = (HtmlTableCell)e.Item.FindControl("tdSlot");
                TextBox txtBarcodeNo = new TextBox();
                txtBarcodeNo = (TextBox)e.Item.FindControl("txtBarcodeNo");
                LinkButton lnkCheckin = new LinkButton();
                lnkCheckin = (LinkButton)e.Item.FindControl("lnkCheckin");
                 HiddenField hdnDeptID1=new HiddenField ();
                 HiddenField hdnInstrumentID1=new HiddenField ();
                 HiddenField hdnTrayID1=new HiddenField ();
                Label lblBarCodeNo=new Label ();
                Label lblCellIndex = new Label();
                lblCellIndex = (Label)e.Item.FindControl("lblCellIndex");
                 hdnDeptID1=(HiddenField)e.Item.FindControl("hdnDeptID");
                 hdnInstrumentID1=(HiddenField)e.Item.FindControl("hdnInstrumentID");
                 hdnTrayID1=(HiddenField)e.Item.FindControl("hdnTrayID");
                lblBarCodeNo=(Label)e.Item .FindControl("lblBarCodeNo");

                if ((lblStatus.Text == "") || (lblStatus.Text.ToLower().Trim() == "checked-out"))
                {
                    tdSlot.Style.Add("background-color", "#DCFEC6");
                    tdSlot.Style.Add("border-color", "#99CC00");
                    txtBarcodeNo.Style.Add("border-color", "#99CC00");
                    lnkCheckin.Style.Add("display", "block");
                }
                else if (lblStatus.Text.ToLower().Trim() == "checked-in")
                {
                    tdSlot.Style.Add("background-color", "#FFDBDC");
                    tdSlot.Style.Add("border-color", "#CC3300");
                    txtBarcodeNo.Style.Add("border-color", "#CC3300");                  
                }
                else if (lblStatus.Text.ToLower().Trim() == "blocked")
                {
                    tdSlot.Style.Add("background-color", "#B2D9EE");
                    tdSlot.Style.Add("border-color", "#003366");
                    txtBarcodeNo.Style.Add("border-color", "#003366");                   
                    lnkCheckin.Style.Add("display", "block");
                }

                string [] CellInfo=lblCellIndex.Text .Split(',');
                if (hdnTrayID1.Value == hdnTryID.Value && CellInfo[0]==hdnRowNo.Value &&   CellInfo[1]== hdnColNo.Value )
                {
                    lblBarCodeNo.Text = hdnNewBarcode.Value;
                    txtBarcodeNo.Text = hdnNewBarcode.Value;
                    lnkCheckin.Visible = true;
                }
                else if (txtBarcodeNo.Text != "")
                {
                    //lblBarCodeNo.Text = hdnNewBarcode.Value;
                    //txtBarcodeNo.Text = hdnNewBarcode.Value;
                    lblCellIndex.Visible = true ;                   
                    lnkCheckin.Visible = false;
                }
                else
                {
                    lblCellIndex.Visible = false ;                    
                    lnkCheckin.Visible = false;

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in dlSampleArchival_RowDataBound", ex);
        }
    }
    protected void btnSaveSampleArchival_Click(object sender, EventArgs e)
    {
        List<SampleArchival> lstSampleArchival = new List<SampleArchival>();
        JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
        if (!string.IsNullOrEmpty(hdnLstSampleArchival.Value))
        {
            lstSampleArchival = oJavaScriptSerializer.Deserialize<List<SampleArchival>>(hdnLstSampleArchival.Value);
            Investigation_BL oInvestigationBL = new Investigation_BL(base.ContextInfo);
            oInvestigationBL.SaveSampleArchivalMasterDetails(string.Empty, lstSampleArchival);
        }
        ddlTray_SelectedIndexChanged(sender, e);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "saved", "alert('Saved Successfully')", true);
    }

    [WebMethod(EnableSession = true)]
    public static void SaveCheckIn(string sampleArchival)
    {
        try
        {
            List<SampleArchival> lstSampleArchival = new List<SampleArchival>();
            JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
            if (!string.IsNullOrEmpty(sampleArchival))
            {
                lstSampleArchival = oJavaScriptSerializer.Deserialize<List<SampleArchival>>(sampleArchival);
                Investigation_BL oInvestigationBL = new Investigation_BL(new BaseClass().ContextInfo);
                oInvestigationBL.SaveSampleArchivalMasterDetails(string.Empty, lstSampleArchival);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
