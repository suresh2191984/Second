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

public partial class Lab_SampleArchival : BasePage
{


    public Lab_SampleArchival()
        : base("Lab_SampleArchival_aspx")
    {

    }
    string strltHead = Resources.Lab_AppMsg.Lab_SampleArchival_aspx_025 == null ? "--Select--" : Resources.Lab_AppMsg.Lab_SampleArchival_aspx_025;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                LoadDropDown("BUILDING", ddlBuilding, 0);
                ddlFloor.Items.Insert(0, strltHead);
                ddlFloor.Items[0].Value = "0";
                ddlStorageArea.Items.Insert(0, strltHead);
                ddlStorageArea.Items[0].Value = "0";
                ddlStorageUnit.Items.Insert(0, strltHead);
                ddlStorageUnit.Items[0].Value = "0";
                ddlTray.Items.Insert(0, strltHead);
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
            if (pStorageUnit == strltHead)
            {
                pStorageUnit = "";
            }
            if (pTrayType == strltHead)
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
                var lstFilterlist1 = from child in lstFilterlist orderby child.RoomName select child;
                ddl.DataSource = lstFilterlist1;
                ddl.DataTextField = "RoomName";
                ddl.DataValueField = "RoomID";
                ddl.DataBind();
                ddl.Items.Insert(0, strltHead);
            }
            if (pType == "TRAY")
            {
                lstFilterlist = (from list in lstRoomDetails
                                 group list by new { list.WardName,list.ID } into gList
                                 select new RoomDetails
                                 {
                                     WardID = gList.Key.ID,//TrayID
                                     WardName = gList.Key.WardName//TrayName
                                 }).Distinct().ToList<RoomDetails>();
                var lstFilterlist1 = from child in lstFilterlist orderby child.WardName select child;
                ddl.DataSource = lstFilterlist1;
                ddl.DataTextField = "WardName";
                ddl.DataValueField = "WardID";
                ddl.DataBind();
                ddl.Items.Insert(0, strltHead);
            }
        }
        else
        {
            returnCode = RoomBL.LoadRoomMasterDetails(pType, OrgID, ILocationID, pId, out lstRoomDetails);
            var lstRoomDetails1 = from child in lstRoomDetails orderby child.Name select child;
            ddl.DataSource = lstRoomDetails1;
            ddl.DataTextField = "Name";
            ddl.DataValueField = "ID";
            ddl.DataBind();
            ddl.Items.Insert(0, "--Select--");
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
              //  btnSaveSampleArchival.Visible = true;
                Investigation_BL oInvestigation_BL = new Investigation_BL(base.ContextInfo);
                int rackId = 0;
                string barcodeNo =txtSampleBarcodeNo.Text !="" ? txtSampleBarcodeNo.Text  :  string.Empty;
                Int32.TryParse(ddlTray.SelectedValue, out rackId);
                List<SampleArchival> lstSampleArchival = new List<SampleArchival>();
                oInvestigation_BL.GetSampleArchivalDetails(rackId, barcodeNo, out lstSampleArchival);

                if(barcodeNo!="")
                {
                 List<SampleArchival> lstSampleArchival1 = new List<SampleArchival>();
                 lstSampleArchival1=(from child in lstSampleArchival where child.BarcodeNo ==barcodeNo select child  ).ToList ();

                 int ColumnCount = (from SA in lstSampleArchival1
                                   select SA.ColumnNo).Max();
                dlSampleArchival.RepeatColumns = ColumnCount;
                var lstSampleArchival11 = from child in lstSampleArchival1 orderby child.DeptName select child;
                dlSampleArchival.DataSource = lstSampleArchival11;
                dlSampleArchival.DataBind();
                }
                else 
                {
                int ColumnCount = (from SA in lstSampleArchival
                                   select SA.ColumnNo).Max();
                dlSampleArchival.RepeatColumns = ColumnCount;
                var lstSampleArchival1 = from child in lstSampleArchival orderby child.DeptName select child;
                dlSampleArchival.DataSource = lstSampleArchival1;
                dlSampleArchival.DataBind();
                }

            if (lstSampleArchival.Count > 0 && txtSampleBarcodeNo.Text != "")
            {
                int pId = 0;
                LoadDropDown("BUILDING", ddlBuilding, 0);
                if (ddlBuilding.Items.FindByValue(lstSampleArchival[0].BuildingID.ToString()) != null)
                {
                    ddlBuilding.SelectedValue = lstSampleArchival[0].BuildingID.ToString();
                }
                Int32.TryParse(ddlBuilding.SelectedValue, out pId);

                LoadDropDown("FLOOR", ddlFloor, pId);
                if (ddlFloor.Items.FindByValue(lstSampleArchival[0].FloorID.ToString()) != null)
                {
                    ddlFloor.SelectedValue = lstSampleArchival[0].FloorID.ToString();
                }
                Int32.TryParse(ddlFloor.SelectedValue, out pId);

                LoadDropDown("STORAGE_AREA", ddlStorageArea, pId);
                if (ddlStorageArea.Items.FindByValue(lstSampleArchival[0].RoomTypeID.ToString()) != null)
                {
                    ddlStorageArea.SelectedValue = lstSampleArchival[0].RoomTypeID.ToString();
                }
                Int32.TryParse(ddlStorageArea.SelectedValue, out pId);


                LoadDropDown("STORAGEUNIT", ddlStorageUnit, pId);
                if (ddlStorageUnit.Items.FindByValue(lstSampleArchival[0].StorageUnitID.ToString()) != null)
                {
                    ddlStorageUnit.SelectedValue = lstSampleArchival[0].StorageUnitID.ToString();
                }
                Int32.TryParse(ddlStorageUnit.SelectedValue, out pId);


                LoadDropDown("TRAY", ddlTray, pId);
                if (ddlTray.Items.FindByValue(lstSampleArchival[0].StorageRackID.ToString()) != null)
                {
                    ddlTray.SelectedValue = lstSampleArchival[0].StorageRackID.ToString();
                }
                Int32.TryParse(ddlTray.SelectedValue, out pId);


            }
            if (lstSampleArchival.Count > 0)
            {
                tblCheckbox.Style.Add("display", "table");
                //tblLegends.Style.Add("display", "block");
            }
            else
            {
                tblCheckbox.Style.Add("display", "none");
                // tblLegends.Style.Add("display", "none");
            }

        }
            catch (Exception Ex)
            {
                btnSaveSampleArchival.Visible = false ;
                dlSampleArchival.DataSource = null;
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
                LinkButton lnkCheckOut = new LinkButton();
                lnkCheckOut = (LinkButton)e.Item.FindControl("lnkCheckOut");
                Label lblBarcode = new Label();
                lblBarcode = (Label)e.Item.FindControl("lblBarcode");

                if ((lblStatus.Text == "") || (lblStatus.Text.ToLower().Trim() == "checked-out"))
                {
                    tdSlot.Style.Add("background-color", "#DCFEC6");
                    tdSlot.Style.Add("border-color", "#99CC00");
                    txtBarcodeNo.Style.Add("border-color", "#99CC00");
                    lnkCheckin.Style.Add("display", "block");
                    lnkCheckOut.Style.Add("display", "none");
                    lblBarcode.Style.Add("display", "none");
                    txtBarcodeNo.Style.Add("display", "block");
                    lblBarcode.Text = "";
                    txtBarcodeNo .Text ="";                    
                }
                else if (lblStatus.Text.ToLower().Trim() == "checked-in")
                {
                    tdSlot.Style.Add("background-color", "#FFDBDC");
                    tdSlot.Style.Add("border-color", "#CC3300");
                    txtBarcodeNo.Style.Add("border-color", "#CC3300");
                    lnkCheckin.Style.Add("display", "none");
                    lnkCheckOut.Style.Add("display", "block");
                    txtBarcodeNo.Enabled = false;
                    lblBarcode.Style.Add("display", "block");
                    txtBarcodeNo.Style.Add("display", "none");
                }
                else if (lblStatus.Text.ToLower().Trim() == "blocked")
                {
                    tdSlot.Style.Add("background-color", "#B2D9EE");
                    tdSlot.Style.Add("border-color", "#003366");
                    txtBarcodeNo.Style.Add("border-color", "#003366");
                    txtBarcodeNo.Enabled = false;
                    lnkCheckin.Style.Add("display", "block");
                    lnkCheckOut.Style.Add("display", "none");
                    lblBarcode.Style.Add("display", "block");
                    txtBarcodeNo.Style.Add("display", "none");
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
        string Information = Resources.Lab_AppMsg.Lab_SampleArchival_aspx_11 ;
        string aInformation1 = Resources.Lab_AppMsg.Lab_SampleArchival_aspx_10 == null ? "Saved Successfully." : Resources.Lab_AppMsg.Lab_SampleArchival_aspx_10;
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "saved", "javascript:ValidationWindow('" + aInformation1 + "','" + Information + "');", true);

       // ScriptManager.RegisterStartupScript(this, this.GetType(), "saved", "alert('Saved Successfully')", true);
    }

    [WebMethod(EnableSession=true)]
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
    protected void btnOk_Click(object sender, EventArgs e)
    {
        ddlTray_SelectedIndexChanged(sender, e);
    }
}
