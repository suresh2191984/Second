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
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Web.Script.Serialization;


public partial class Admin_SampleArchivalMaster : BasePage
{
    #region Variable Declaration

    List<RoomDetails> lstRoomDetails = new List<RoomDetails>();
    List<RoomDetails> lstBuildingDetails = new List<RoomDetails>();
    List<RoomDetails> RDFeeList = new List<RoomDetails>();
    List<RoomDetails> RDFeedetList = new List<RoomDetails>();
    RoomBooking_BL RoomBL;

    List<ShippingConditionMaster> lstShippingConditionMaster = new List<ShippingConditionMaster>();
    AdminReports_BL objBl;
    List<RateTypeMaster> lstRateTypeMaster = new List<RateTypeMaster>();
    List<RateMaster> lstRateType = new List<RateMaster>();
    List<MetaData> lstmetadataOutput = new List<MetaData>();
    int flag;
    string StrSelect = Resources.Admin_AppMsg.Admin_SampleArchivalMaster_aspx_26 == null ? "--Select--" : Resources.Admin_AppMsg.Admin_SampleArchivalMaster_aspx_26;

    #endregion

    #region Events

    public Admin_SampleArchivalMaster()
        : base("Admin_SampleArchivalMaster_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        RoomBL = new RoomBooking_BL(base.ContextInfo);
        objBl = new AdminReports_BL(base.ContextInfo);

        if (!IsPostBack)
        {

            BindRoomRate();
            LoadMetaData();
            hdnOrgID.Value = OrgID.ToString();
        }



    }

    protected void ddlMaster_SelectedIndexChanged(object sender, EventArgs e)
    {
        string Venter = Resources.Admin_AppMsg.Admin_SampleArchivalMaster_aspx_27 == null ? "Enter " : Resources.Admin_AppMsg.Admin_SampleArchivalMaster_aspx_27;
        string Vname = Resources.Admin_AppMsg.Admin_SampleArchivalMaster_aspx_28 == null ? " Name" : Resources.Admin_AppMsg.Admin_SampleArchivalMaster_aspx_28;
        try
        {
            tdSaveBed.Style.Add("display", "none");
            tdRoomFinish.Style.Add("display", "none");
            hdnControlValue.Value = "";
            hdnCollectedList.Value = "";
            hdnRoomValues.Value = "";
            txtAmount.Text = "";
            txtBuilding.Text = "";
            txtFloor.Text = "";
            txtRoomType.Text = "";
            lstBedRooms.Items.Clear();
            txtNoofRooms.Text = "";
            gvResult.Visible = false;

            GrdBedDetails.Visible = false;

            btnSaveNOofBed.Style.Add("display", "none");

            switch (ddlMaster.SelectedValue)
            {
                case "BUILDING":
                    string Text = string.Empty;
                    tbBuilding.Visible = true;
                    TbBed.Visible = false;
                    tbFloor.Visible = false;
                    GrdRoomDetails.Visible = false;
                    tbRooms.Visible = false;
                    tdChkSlotable.Style.Add("display", "none");
                    LoadRoomMasterDetails(ddlMaster.SelectedValue, 0);
                    gvResult.Visible = true;
                    GrdBedDetails.Visible = false;
                    grdSampleArchival.Visible = false;
                    DepartNme.Visible = false;
                    btnSaveSampleArchival.Visible = false;
                    Text = System.Threading.Thread.CurrentThread.CurrentCulture.TextInfo.ToTitleCase(ddlMaster.SelectedValue.ToLower());
                    lblbuName.Text = Venter + Text + Vname;
                    break;
                case "FLOOR":
                    Text = System.Threading.Thread.CurrentThread.CurrentCulture.TextInfo.ToTitleCase(ddlMaster.SelectedValue.ToLower());
                    lblName.Text = Venter + Text + Vname;
                    //lblbuName.Text = "Enter" + ddlMaster.SelectedValue +" Name";
                    tbFloor.Visible = true;
                    tbBuilding.Visible = false;
                    tbRooms.Visible = false;
                    GrdRoomDetails.Visible = false;
                    GrdBedDetails.Visible = false;
                    grdSampleArchival.Visible = false;
                    DepartNme.Visible = false;
                    btnSaveSampleArchival.Visible = false;
                    TbBed.Visible = false;
                    tdChkSlotable.Style.Add("display", "none");
                    LoadBuildingDropDown("Building", ddlBuilding);
                    break;
                case "WARD":
                    Text = System.Threading.Thread.CurrentThread.CurrentCulture.TextInfo.ToTitleCase(ddlMaster.SelectedValue.ToLower());
                    lblName.Text = Venter + Text + Vname;
                    tbFloor.Visible = true;
                    tbBuilding.Visible = false;
                    tbRooms.Visible = false;
                    GrdRoomDetails.Visible = false;
                    GrdBedDetails.Visible = false;
                    TbBed.Visible = false;
                    grdSampleArchival.Visible = false;
                    DepartNme.Visible = false;
                    btnSaveSampleArchival.Visible = false;
                    tdChkSlotable.Style.Add("display", "none");
                    LoadBuildingDropDown("Building", ddlBuilding);
                    break;
                case "STORAGE_AREA":
                    hdnddlroomrate.Value = "";
                    tbBuilding.Visible = true;
                    tbFloor.Visible = false;
                    grdSampleArchival.Visible = false;
                    DepartNme.Visible = false;
                    btnSaveSampleArchival.Visible = false;
                    tbRooms.Visible = false;
                    if (Request.QueryString["IsLims"] != null)
                    {
                        if (Request.QueryString["IsLims"] == "Y")
                        {
                            tdChkSlotable.Style.Add("display", "none");
                        }
                    }
                    else
                    {
                        tdChkSlotable.Style.Add("display", "block");
                        LoadRoomFeesType();
                    }
                    gvResult.Visible = true;

                    LoadRoomMasterDetails(ddlMaster.SelectedValue, 0);
                    GrdBedDetails.Visible = false;
                    GrdRoomDetails.Visible = false;
                    TbBed.Visible = false;
                    Text = System.Threading.Thread.CurrentThread.CurrentCulture.TextInfo.ToTitleCase(ddlMaster.SelectedValue.ToLower());
                    lblbuName.Text = Venter + Text + Vname;//Changed by farook
                    break;
                case "ROOMS":
                    tbBuilding.Visible = false;
                    grdSampleArchival.Visible = false;
                    DepartNme.Visible = false;
                    btnSaveSampleArchival.Visible = false;
                    tbFloor.Visible = false;
                    tbRooms.Visible = true;
                    gvResult.Visible = false;

                    // GrdRoomDetails.Visible =true;
                    TbBed.Visible = false;
                    tdChkSlotable.Style.Add("display", "none");
                    GrdBedDetails.Visible = false;
                    LoadRoomDetails();
                    break;
                case "BED":
                    tbBuilding.Visible = false;
                    tbFloor.Visible = false;
                    tbRooms.Visible = false;
                    grdSampleArchival.Visible = false;
                    DepartNme.Visible = false;
                    btnSaveSampleArchival.Visible = false;
                    GrdRoomDetails.Visible = false;
                    TbBed.Visible = true;
                    LoadRoomDetails();
                    LoadBuildingDropDown("Building", ddlBedBuilding);
                    lstBedRooms.Attributes.Add("ondblclick", "lstBedRooms_dblclick();");
                    break;
                case "STORAGE_UNITS":
                    tbBuilding.Visible = false;
                    tbFloor.Visible = false;
                    tbRooms.Visible = true;
                    gvResult.Visible = false;
                    ddlStorageUnit.Visible = false;
                    ddlTrays.Visible = false;
                    Rs_StorageUnit.Visible = false;
                    Rs_Tray.Visible = false;
                    btnAddRooms.Visible = true;
                    Rs_NoofRooms.Visible = true;
                    txtNoofRooms.Visible = true;
                    grdSampleArchival.Visible = false;
                    DepartNme.Visible = false;
                    btnSaveSampleArchival.Visible = false;
                    // GrdRoomDetails.Visible =true;
                    TbBed.Visible = false;
                    tdChkSlotable.Style.Add("display", "none");
                    GrdBedDetails.Visible = false;
                    LoadRoomDetails();
                    break;
                case "TRAY":
                    tbBuilding.Visible = false;
                    tbFloor.Visible = false;
                    tbRooms.Visible = false;
                    grdSampleArchival.Visible = false;
                    DepartNme.Visible = false;
                    btnSaveSampleArchival.Visible = false;
                    GrdRoomDetails.Visible = false;
                    TbBed.Visible = true;
                    LoadRoomDetails();
                    LoadBuildingDropDown("Building", ddlBedBuilding);
                    lstBedRooms.Attributes.Add("ondblclick", "lstBedRooms_dblclick();");
                    break;
                case "SLOT":
                    tbBuilding.Visible = false;
                    tbFloor.Visible = false;
                    tbRooms.Visible = true;
                    gvResult.Visible = false;
                    Rs_StorageUnit.Visible = true;
                    Rs_Tray.Visible = true;
                    Rs_NoofRooms.Visible = false;
                    txtNoofRooms.Visible = false;
                    ddlStorageUnit.Visible = true;
                    ddlTrays.Visible = true;
                    btnAddRooms.Visible = false;
                    //GrdRoomDetails.Visible =true;
                    TbBed.Visible = false;
                    tdChkSlotable.Style.Add("display", "none");
                    LoadRoomDetails();
                    LoadBuildingDropDown("Building", ddlBuilding);
                    GrdBedDetails.Visible = false;
                    GrdRoomDetails.Visible = false;

                    break;
                default:
                    tbBuilding.Visible = false;
                    tbFloor.Visible = false;
                    tbRooms.Visible = false;
                    TbBed.Visible = false;
                    tdChkSlotable.Style.Add("display", "none");

                    break;
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While LoadRoomMasterDetails.", Ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }


    }

    protected void ddlBuilding_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            hdnControlValue.Value = "";
            hdnCollectedList.Value = "";
            hdnRoomValues.Value = "";
            txtAmount.Text = "";
            txtBuilding.Text = "";
            txtFloor.Text = "";
            txtRoomType.Text = "";

            if (ddlBuilding.SelectedValue != "-1")
            {
                LoadRoomMasterDetails(ddlMaster.SelectedValue, int.Parse(ddlBuilding.SelectedValue));
                gvResult.Visible = true;
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While LoadRoomMasterDetails.", Ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType != DataControlRowType.EmptyDataRow)
            {
                if (ddlMaster.SelectedValue == "STORAGE_AREA")
                {

                    //e.Row.Cells[1].Visible = false;
                    e.Row.Cells[3].Visible = false;
                }
                if (ddlMaster.SelectedValue != "STORAGE_AREA")
                {
                    e.Row.Cells[3].Visible = false;
                }
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    RoomDetails IOM = (RoomDetails)e.Row.DataItem;
                    string pRoomType = "";
                    if (ddlMaster.SelectedValue == "STORAGE_AREA")
                    {
                        pRoomType = GetRoomTypeValuees(IOM);
                        hdnddlroomrate.Value += IOM.ID + "~" + IOM.RateID + "~" + ((CheckBox)e.Row.FindControl("chkStatus")).ClientID + "^";
                    }
                    string strScript = "RoomRowCommon('" + ((CheckBox)e.Row.FindControl("chkStatus")).ClientID + "','" + IOM.ID + "','" + IOM.Name + "','" + IOM.BuildingID + "','" + pRoomType + "','" + IOM.RateID + "','" + IOM.IsSlotable + "','" + IOM.IsAnOT + "');";
                    ((CheckBox)e.Row.FindControl("chkStatus")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                    ((CheckBox)e.Row.FindControl("chkStatus")).Attributes.Add("onclick", strScript);


                }
            }

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While Loading Purchase Order Details.", Ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";

        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string WinAlert = Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_Alert == null ? "Alert" : Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_Alert;
        string UsrMsgWin = Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_01 == null ? "Building Already Exists!!!" : Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_01;
        string UsrMsgWin1 = Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_02 == null ? "Floor Already Exists!!!" : Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_02;
        string UsrMsgWin2 = Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_03 == null ? "Storage Area Already Exists!!!" : Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_03;
        List<RoomDetails> lstRoomDetails = new List<RoomDetails>();
        long lResult = -1;
        try
        {
            switch (ddlMaster.SelectedValue)
            {
                case "BUILDING":
                    lstRoomDetails = GetRoomList("Add");
                    lResult = SaveRoomDetails(lstRoomDetails, lResult, (hdnpSta.Value == "Add" ? true : false));
                    if (lResult > -1)
                    {
                        ddlMaster_SelectedIndexChanged(sender, e);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Building Already Exists!!!');", true);
                        txtBuilding.Text = "";

                    }
                    break;
                case "FLOOR":
                    lstRoomDetails = GetRoomList("Add");
                    lResult = SaveRoomDetails(lstRoomDetails, lResult, (hdnpSta.Value == "Add" ? true : false));
                    if (lResult > -1)
                    {
                        ddlBuilding_SelectedIndexChanged(sender, e);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin1 + "','" + WinAlert + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Floor Already Exists!!!');", true);
                        txtFloor.Text = "";

                    }
                    break;
                case "WARD":
                    lstRoomDetails = GetRoomList("Add");
                    lResult = SaveRoomDetails(lstRoomDetails, lResult, (hdnpSta.Value == "Add" ? true : false));
                    ddlBuilding_SelectedIndexChanged(sender, e);
                    break;
                case "STORAGE_AREA":
                    lstRoomDetails = GetRoomFeeList("Add");
                    lResult = SaveRoomDetails(lstRoomDetails, lResult, (hdnpSta.Value == "Add" ? true : false));
                    if (lResult > -1)
                    {
                        ddlMaster_SelectedIndexChanged(sender, e);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin2 + "','" + WinAlert + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Storage Area Already Exists!!!');", true);
                        txtBuilding.Text = "";

                    }
                    if (((Button)sender).CommandArgument == "Continue")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ReloadPOP", "OnControlClick();", true);
                        mpeRoomType.Show();
                    }


                    break;
                case "ROOMS":
                    lstRoomDetails = GetRoomCount();
                    //lResult = SaveRoomDetails(lstRoomDetails, lResult, (hdnpSta.Value == "Add" ? true : false));
                    lResult = FinishRoomDetails(lstRoomDetails, lResult);
                    ddlMaster_SelectedIndexChanged(sender, e);
                    break;
                case "BED":
                    lstRoomDetails = CollectBedDetails("");
                    //lResult = SaveRoomDetails(lstRoomDetails, lResult, (hdnpSta.Value == "Add" ? true : false));
                    ddlMaster_SelectedIndexChanged(sender, e);
                    lResult = FinishBed(lstRoomDetails, lResult);
                    break;
                case "STORAGE_UNITS":
                    lstRoomDetails = GetRoomCount();
                    //lResult = SaveRoomDetails(lstRoomDetails, lResult, (hdnpSta.Value == "Add" ? true : false));
                    lResult = FinishRoomDetails(lstRoomDetails, lResult);
                    ddlMaster_SelectedIndexChanged(sender, e);
                    break;
                case "TRAY":
                    lstRoomDetails = CollectBedDetails("TRAY");
                    //lResult = SaveRoomDetails(lstRoomDetails, lResult, (hdnpSta.Value == "Add" ? true : false));
                    ddlMaster_SelectedIndexChanged(sender, e);
                    lResult = FinishBed(lstRoomDetails, lResult);
                    break;
                default:

                    break;
            }

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Save Room Details.", Ex);
        }

    }

    private List<RoomDetails> GetNoOfRoomList()
    {
        List<RoomDetails> lstRoomDetails = new List<RoomDetails>();
        foreach (GridViewRow row in GrdRoomDetails.Rows)
        {
            RoomDetails objRoomDetails = new RoomDetails();

            objRoomDetails.FloorID = Convert.ToInt32(GrdRoomDetails.DataKeys[row.RowIndex].Values["FloorID"]);
            objRoomDetails.WardID = Convert.ToInt32(GrdRoomDetails.DataKeys[row.RowIndex].Values["WardID"]);
            objRoomDetails.RoomTypeID = Convert.ToInt32(GrdRoomDetails.DataKeys[row.RowIndex].Values["RoomTypeID"]);
            objRoomDetails.RoomID = Convert.ToInt32(GrdRoomDetails.DataKeys[row.RowIndex].Values["RoomID"]);
            objRoomDetails.RoomName = row.FindControl("txtRoomName").ToString();
            objRoomDetails.NoBeds = Convert.ToInt32(row.FindControl("txtBeds"));
            lstRoomDetails.Add(objRoomDetails);

        }
        return lstRoomDetails;
    }


    protected void btnAddRooms_Click(object sender, EventArgs e)
    {
        string StrUnit = Resources.Admin_AppMsg.Admin_SampleArchivalMaster_aspx_31 == null ? "Storage Unit-" : Resources.Admin_AppMsg.Admin_SampleArchivalMaster_aspx_31;
        int RowCount = 0;
        int RowNumber = 0;
        List<RoomDetails> lstRoomDetails = new List<RoomDetails>();
        if (GrdRoomDetails.Rows.Count > 0)
        {
            lstRoomDetails = GetRoomCount();
            RowNumber = GrdRoomDetails.Rows.Count;
        }
        Int32.TryParse(txtNoofRooms.Text, out RowCount);
        for (int i = 1; i <= RowCount; i++)
        {
            RowNumber = RowNumber + 1;
            RoomDetails rd = new RoomDetails();
            rd.BuildingName = ddlRoomBuilding.SelectedItem.Text;
            rd.FloorName = ddlRoomFloor.SelectedItem.Text;
            rd.FloorID = int.Parse(ddlRoomFloor.SelectedValue);
            rd.WardName = ddlRoomWard.SelectedItem.Text;
            rd.WardID = int.Parse(ddlRoomWard.SelectedValue);
            rd.RoomTypeName = ddlRoomRoomType.SelectedItem.Text;
            rd.RoomTypeID = int.Parse(ddlRoomRoomType.SelectedValue);
            rd.RoomName = StrUnit + RowNumber.ToString();
            rd.NoBeds = 0;
            lstRoomDetails.Add(rd);
        }

        LoadRoomMaster(lstRoomDetails);
        tdRoomFinish.Style.Add("display", "block");
    }



    private long SaveRoomDetails(List<RoomDetails> lstRoomDetails, long lResult, bool msgFlag)
    {
        lResult = RoomBL.SaveRoomMasterData(ddlMaster.SelectedValue, OrgID, ILocationID, lstRoomDetails, hdnIsSlotable.Value, hdnIsAnOT.Value);

        if (lResult == 0)
        {
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = " Already Exist";
            string sPath = "Admin\\\\RoomMasterDetails.aspx.cs_31";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ")", true);
            //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Admin\\RoomMasterDetails.aspx.cs_31").ToString();
            //if (sUserMsg != null)
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "alert("+sUserMsg+")",true);
            //}
            //else
            //{

            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Already Exist!');", true);
            //}
            //Page.RegisterStartupScript("key1", "<script language='javascript' >alert('" + ErrorDisplay1.Status + "'); </script>");
        }
        else
        {
            if (msgFlag)
            {
                string sPath = "Admin\\\\RoomMasterDetails.aspx.cs_32";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ")", true);
                //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Admin\\RoomMasterDetails.aspx.cs_32").ToString();
                //if (sUserMsg != null)
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "alert(" + sUserMsg + ")", true);
                //}

                //else
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Saved Successfully!');", true);
                //}
            }
            else
            {
                string sPath = "Admin\\\\RoomMasterDetails.aspx.cs_33";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ")", true);

                //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Admin\\RoomMasterDetails.aspx.cs_33").ToString();
                //if (sUserMsg != null)
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "alert(" + sUserMsg + ")", true);
                //}
                //else
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Changes Saved Successfully!');", true);
                //}
            }
        }
        return lResult;
    }

    #endregion

    #region User Function

    private void LoadRoomMaster(List<RoomDetails> lstRoomDetails)
    {

        GrdRoomDetails.Visible = false;
        var lstRoomDetails1 = from child in lstRoomDetails orderby child.Description select child;
        GrdRoomDetails.DataSource = lstRoomDetails1;
        GrdRoomDetails.DataBind();
        GrdRoomDetails.Visible = true;
        BtnAddRooms();
        for (int i = 0; i <= (lstRoomDetails.Count) - 1; i++)
        {
            DropDownList ddl = (DropDownList)GrdRoomDetails.Rows[i].FindControl("ddlSampleCondition");
            ddl.SelectedIndex = lstRoomDetails[i].WardID;
        }
    }

    private List<RoomDetails> GetRoomCount()
    {
        List<RoomDetails> lstRoomDetails = new List<RoomDetails>();

        foreach (GridViewRow row in GrdRoomDetails.Rows)
        {
            RoomDetails rd = new RoomDetails();
            rd.BuildingName = row.Cells[0].Text;
            rd.FloorName = row.Cells[1].Text;
            rd.FloorID = Convert.ToInt32(GrdRoomDetails.DataKeys[row.RowIndex][0]);
            DropDownList ddl = (DropDownList)row.FindControl("ddlSampleCondition");
            rd.WardName = row.Cells[2].Text;
            rd.WardID = Convert.ToInt32(ddl.SelectedItem.Value);
            rd.RoomTypeName = row.Cells[3].Text.Trim();
            rd.RoomTypeID = Convert.ToInt32(GrdRoomDetails.DataKeys[row.RowIndex][2]);
            TextBox roomname = (TextBox)row.FindControl("txtRoomName");
            TextBox nobeds = (TextBox)row.FindControl("txtBeds");
            TextBox txtRows = (TextBox)row.FindControl("txtRows");
            TextBox txtColumns = (TextBox)row.FindControl("txtColumns");

            rd.NoBeds = Convert.ToInt32(nobeds.Text);
            rd.RoomName = roomname.Text.Trim();
            rd.RoomID = Convert.ToInt32(GrdRoomDetails.DataKeys[row.RowIndex][3]);
            rd.NoRows = Convert.ToInt32(txtRows.Text);
            rd.NoColumns = Convert.ToInt32(txtColumns.Text);
            lstRoomDetails.Add(rd);
        }
        return lstRoomDetails;
    }

    private void LoadRoomDetails()
    {
        long lResult = -1;

        lResult = RoomBL.GetRoomDetails(OrgID, ILocationID, out lstBuildingDetails, out lstRoomDetails, out RDFeeList, out RDFeedetList);
        LoadBuildingDropDown(ddlRoomBuilding, lstBuildingDetails);

        LoadBuildingDropDown(ddlRoomFloor, lstBuildingDetails = new List<RoomDetails>());
        LoadBuildingDropDown(ddlRoomRoomType, RDFeedetList);
        SetHiddenDDLValues(lstRoomDetails, hdnFloor);
        SetHiddenDDLValues(RDFeeList, hdnWard);
        LoadBuildingDropDown(ddlBedBuilding, lstBuildingDetails);//BedBuilding DDL
        LoadBuildingDropDown(ddlBedRoomType, RDFeedetList);//bedroomtype
        LoadBuildingDropDown(ddlStorageUnit, lstBuildingDetails);
        LoadBuildingDropDown(ddlTrays, lstBuildingDetails);
        if (Request.QueryString["IsLims"] != null)
        {
            if (Request.QueryString["IsLims"] == "Y")
            {

                ddlRoomWard.Visible = false;
                Rs_Ward.Visible = false;
            }
        }
        else
        {
            ddlRoomWard.Visible = true;
            LoadBuildingDropDown(ddlRoomWard, lstBuildingDetails = new List<RoomDetails>());
        }
    }

    private void SetHiddenDDLValues(List<RoomDetails> lstDetails, HtmlInputHidden hdnFloor1)
    {
        hdnFloor1.Value = "";
        foreach (RoomDetails item in lstDetails)
        {
            hdnFloor1.Value += item.BuildingID + "~" + item.ID + "~" + item.Name + "^";
        }

    }

    private void LoadBuildingDropDown(DropDownList ddl, List<RoomDetails> lsttempRoomDetails)
    {
        var lsttempRoomDetails1 = from child in lsttempRoomDetails orderby child.Name select child;
        ddl.DataSource = lsttempRoomDetails1;
        ddl.DataTextField = "Name";
        ddl.DataValueField = "ID";
        ddl.DataBind();
        ddl.Items.Insert(0, StrSelect);
        ddl.Items[0].Value = "-1";

    }

    private void LoadRoomMasterDetails(string pType, int pBuildingID)
    {
        long returnCode = -1;
        returnCode = RoomBL.LoadRoomMasterDetails(pType, OrgID, ILocationID, pBuildingID, out lstRoomDetails);
        var lstRoomDetails1 = from child in lstRoomDetails orderby child.Name select child;
        gvResult.DataSource = lstRoomDetails1;
        gvResult.DataBind();

    }
    private void LoadBuildingDropDown(string pType, DropDownList ddl)
    {
        long returnCode = -1;
        returnCode = RoomBL.LoadRoomMasterDetails(pType, OrgID, ILocationID, 0, out lstRoomDetails);
        var lstRoomDetails1 = from child in lstRoomDetails orderby child.Name select child;
        ddl.DataSource = lstRoomDetails1;
        ddl.DataTextField = "Name";
        ddl.DataValueField = "ID";
        ddl.DataBind();
        ddl.Items.Insert(0, StrSelect);
        ddl.Items[0].Value = "-1";

    }
    private List<RoomDetails> GetRoomFeeList(string sType)
    {
        List<RoomDetails> lstRoomDetails = new List<RoomDetails>();
        if (sType == "Add" || sType == "Upd")
        {
            if (Request.QueryString["IsLims"] != null)
            {
                if (Request.QueryString["IsLims"] == "Y")
                {

                    string[] item = hdnCollectedList.Value.Split('~');
                    RoomDetails obj = new RoomDetails();
                    if (item.Count() > 0)
                    {
                        obj.RoomTypeID = item[0] == "" ? 0 : int.Parse(item[0]);
                        obj.RoomTypeName = item[1];
                        obj.BuildingID = item[2] == "" ? 0 : int.Parse(item[2]);

                        lstRoomDetails.Add(obj);
                    }
                }
            }
            else
            {
                foreach (string str in hdnRoomValues.Value.Split('^'))
                {
                    string[] item = str.Split('~');

                    RoomDetails obj = new RoomDetails();
                    if (item.Count() > 0 && str != "" && item[7] == ddlRoomFeeRate.SelectedValue)
                    {
                        obj.RoomTypeID = item[0] == "" ? 0 : int.Parse(item[0]);
                        obj.RoomTypeName = txtRoomType.Text;
                        obj.Name = item[1];
                        obj.ID = item[2] == "" ? 0 : int.Parse(item[2]);
                        obj.FeeID = item[3] == "" ? 0 : int.Parse(item[3]);
                        obj.Amount = item[4] == "" ? 0 : decimal.Parse(item[4]);
                        obj.ISVariable = item[5];
                        obj.ISOptional = item[6];
                        obj.RateID = Convert.ToInt32(ddlRoomFeeRate.SelectedValue);
                        obj.FeelogicID = item[8];
                        obj.FeebasedOn = item[9];

                        lstRoomDetails.Add(obj);
                    }
                }
            }
        }
        return lstRoomDetails;
    }
    private List<RoomDetails> GetRoomList(string sType)
    {
        int sID = 0;
        string sName = "";
        int sBulID = 0;

        List<RoomDetails> lstRoomDetails = new List<RoomDetails>();
        if (sType == "Add" || sType == "Upd")
        {

            string[] item = hdnCollectedList.Value.Split('~');
            RoomDetails obj = new RoomDetails();
            if (item.Count() > 0)
            {
                sID = item[0] == "" ? 0 : int.Parse(item[0]);
                sName = item[1];
                sBulID = item[2] == "" ? 0 : int.Parse(item[2]);

                obj.ID = sID;
                obj.Name = sName;
                obj.BuildingID = sBulID;

                lstRoomDetails.Add(obj);
            }
        }
        return lstRoomDetails;
    }

    protected void LoadRoomFeesType()
    {
        long returnCode = -1;

        try
        {
            returnCode = RoomBL.GetRoomsFeesType(OrgID, ILocationID, out RDFeedetList, out RDFeeList);
            var RDFeedetList1 = from child in RDFeedetList orderby child.Description select child;
            ddlRoomfeestype.DataSource = RDFeedetList1;
            ddlRoomfeestype.DataTextField = "Description";
            ddlRoomfeestype.DataValueField = "FeeID";
            ddlRoomfeestype.DataBind();
            ddlRoomfeestype.Items.Insert(0, StrSelect);
            ddlRoomfeestype.Items[0].Value = "-1";

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While ddlRoomfeestype Details.", Ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    private string GetRoomTypeValuees(RoomDetails IOM)
    {
        string pRoomType = "";

        foreach (RoomDetails item in RDFeeList.FindAll(P => P.RoomTypeID == IOM.ID))
        {
            pRoomType += item.RoomTypeID + "~" + item.Name + "~" + item.RoomTypeFeeMappingID + "~" + item.FeeID + "~" + item.Amount + "~" +
                item.ISVariable + "~" + item.ISOptional + "~" + item.RateID + "~" + item.FeelogicID + "~" + item.FeebasedOn + "^";
        }

        return pRoomType;
    }

    #endregion

    protected void loadRoomMaster_Details(object sender, EventArgs e)
    {
        try
        {
            string dropDown = ddlMaster.SelectedValue;
            long returnCode = -1;
            int pBuildingID = int.Parse(ddlRoomBuilding.SelectedValue);
            int pWardID = int.Parse(ddlRoomWard.SelectedValue);
            int pFloorID = int.Parse(ddlRoomFloor.SelectedValue);
            int pRoomType = int.Parse(ddlRoomRoomType.SelectedValue);
            string pStorageUnit = Convert.ToString(ddlStorageUnit.SelectedItem);
            if (pStorageUnit == StrSelect)
            {
                pStorageUnit = "";
            }
            string pTrayType = Convert.ToString(ddlTrays.SelectedItem);
            if (pTrayType == StrSelect)
            {
                pTrayType = "";
            }
            returnCode = RoomBL.GetRoomsDetails(OrgID, ILocationID, pBuildingID, pWardID, pFloorID, pRoomType, pStorageUnit, pTrayType, out lstRoomDetails);

            List<RoomDetails> lstFilterStorageUnit = (from list in lstRoomDetails
                                                      group list by new { list.RoomName, list.RoomID } into gList
                                                      select new RoomDetails
                                                      {
                                                          RoomID = gList.Key.RoomID,
                                                          RoomName = gList.Key.RoomName
                                                      }).Distinct().ToList<RoomDetails>();


            var lstFilterStorageUnit1 = from child in lstFilterStorageUnit orderby child.RoomName select child;
            ddlStorageUnit.DataSource = lstFilterStorageUnit1;
            ddlStorageUnit.DataTextField = "RoomName";
            ddlStorageUnit.DataValueField = "RoomID";
            ddlStorageUnit.DataBind();
            ddlStorageUnit.Items.Insert(0, StrSelect);
            ddlStorageUnit.Items[0].Value = "-1";

            List<RoomDetails> lstFilteredUnit = (from list in lstRoomDetails
                                                 group list by new { list.BuildingName, list.FloorName, list.RoomTypeName, list.WardID, list.RoomName, list.NoBeds ,list.NoRows ,list.NoColumns }
                                                     into gList
                                                     select new RoomDetails
                                                     {
                                                         BuildingName = gList.Key.BuildingName,
                                                         FloorName = gList.Key.FloorName,
                                                         RoomTypeName = gList.Key.RoomTypeName,
                                                         WardID = gList.Key.WardID,
                                                         RoomName = gList.Key.RoomName,
                                                         NoBeds = gList.Key.NoBeds,
                                                         NoRows =gList .Key.NoRows ,
                                                         NoColumns =gList .Key .NoColumns 
                                                     }).Distinct().ToList<RoomDetails>();

            if (dropDown == "STORAGE_UNITS")
            {
                LoadRoomMaster(lstFilteredUnit);
                tdRoomFinish.Style.Add("display", (lstRoomDetails.Count > 0 ? "block" : "none"));
            }

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While LoadRoomMasterDetails.", Ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void loadMaster_Details(object sender, EventArgs e)
    {
        try
        {
            grdSampleArchival.Visible = false;
            DepartNme.Visible = false;
            btnSaveSampleArchival.Visible = false;
            long returnCode = -1;
            int pBuildingID = int.Parse(ddlRoomBuilding.SelectedValue);
            int pWardID = int.Parse(ddlRoomWard.SelectedValue);
            int pFloorID = int.Parse(ddlRoomFloor.SelectedValue);
            int pRoomType = int.Parse(ddlRoomRoomType.SelectedValue);
            string pStorageUnit = Convert.ToString(ddlStorageUnit.SelectedItem);
            if (pStorageUnit == StrSelect)
            {
                pStorageUnit = "";
            }
            string pTrayType = Convert.ToString(ddlTrays.SelectedItem);
            if (pTrayType == StrSelect)
            {
                pTrayType = "";
            }

            returnCode = RoomBL.GetRoomsDetails(OrgID, ILocationID, pBuildingID, pWardID, pFloorID, pRoomType, pStorageUnit, pTrayType, out lstRoomDetails);

            List<RoomDetails> lstFilterStorageUnit = (from list in lstRoomDetails
                                                      group list by new { list.ID, list.WardName } into gList
                                                      select new RoomDetails
                                                      {
                                                          WardID = gList.Key.ID,
                                                          WardName = gList.Key.WardName

                                                      }).Distinct().ToList<RoomDetails>();
            var lstFilterStorageUnit1 = from child in lstFilterStorageUnit orderby child.WardName select child;
            ddlTrays.DataSource = lstFilterStorageUnit1;
            ddlTrays.DataTextField = "WardName";
            ddlTrays.DataValueField = "WardID";
            ddlTrays.DataBind();
            ddlTrays.Items.Insert(0, StrSelect);
            ddlTrays.Items[0].Value = "-1";
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While LoadRoomMasterDetails.", Ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void LoadRoomBedList(object sender, EventArgs e)
    {
        string StrTrays = Resources.Admin_AppMsg.Admin_SampleArchivalMaster_aspx_32 == null ? "(Trays-" : Resources.Admin_AppMsg.Admin_SampleArchivalMaster_aspx_32;

        int pBuildingID = int.Parse(ddlBedBuilding.SelectedValue);
        int pRoomType = int.Parse(ddlBedRoomType.SelectedValue);

        long returnCode = RoomBL.GetRoomsDetails(OrgID, ILocationID, pBuildingID, 0, 0, pRoomType, "", "", out lstRoomDetails);

        List<RoomDetails> lstFilterbedRooms = (from list in lstRoomDetails
                                               group list by new { list.RoomTypeID, list.RoomID, list.RoomName, list.FloorName, list.NoBeds } into gList
                                               select new RoomDetails
                                               {
                                                   RoomTypeID = gList.Key.RoomTypeID,
                                                   RoomID = gList.Key.RoomID,
                                                   RoomName = gList.Key.RoomName + "," + gList.Key.FloorName
                                                       //+ "," + gList.Key.WardName 
                                                   + StrTrays + gList.Key.NoBeds + ")"
                                               }).Distinct().ToList<RoomDetails>();
        //var lstFilteredRooms = (from list in lstRoomDetails
        //                                      where list.BuildingID == pBuildingID && list.RoomTypeID == pRoomType
        //                                      select new RoomDetails
        //                                      {
        //                                          RoomTypeID = list.RoomTypeID,
        //                                          RoomName = list.RoomName + "(" + list.NoBeds + ")"
        //                                      }).ToList<RoomDetails>();

        int NoOfRooms = lstFilterbedRooms.Count();
        txtNoofRooms.Text = NoOfRooms.ToString();
        var lstFilterbedRooms1 = from child in lstFilterbedRooms orderby child.RoomName select child;
        lstBedRooms.DataSource = lstFilterbedRooms1;
        lstBedRooms.DataTextField = "RoomName";
        lstBedRooms.DataValueField = "RoomID";

        lstBedRooms.DataBind();
    }

    private void GetFloorAndWardDetails(HtmlInputHidden hdnobj, DropDownList ddl)
    {
        List<RoomDetails> lstDetails = new List<RoomDetails>();

        foreach (string str in hdnobj.Value.Split('^'))
        {
            if (str.Trim() != string.Empty)
            {
                string[] item = str.Split('~');
                {
                    RoomDetails obj = new RoomDetails();
                    if (item[0] == ddlRoomBuilding.SelectedValue)
                    {
                        obj.ID = item[1] == "" ? 0 : int.Parse(item[1]);
                        obj.Name = item[2];
                        lstDetails.Add(obj);
                    }
                    //item.BuildingID + "~" + item.ID + "~" + item.Name + "^";

                }
            }
        }
        var lstDetails1 = from child in lstDetails orderby child.Name select child;
        ddl.DataSource = lstDetails1;
        ddl.DataTextField = "Name";
        ddl.DataValueField = "ID";
        ddl.DataBind();
        ddl.Items.Insert(0, StrSelect);
        ddl.Items[0].Value = "-1";

    }


    protected void loadFloorWard_Details(object sender, EventArgs e)
    {
        GetFloorAndWardDetails(hdnFloor, ddlRoomFloor);
        GetFloorAndWardDetails(hdnWard, ddlRoomWard);
    }

    protected void GrdRoomDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (Convert.ToInt32(((TextBox)e.Row.FindControl("txtBeds")).Text) > 0)
            {
                ((TextBox)e.Row.FindControl("txtBeds")).Enabled = false;
                ((TextBox)e.Row.FindControl("txtRows")).Enabled = false;
                ((TextBox)e.Row.FindControl("txtColumns")).Enabled = false;
            }
        }
        if (Request.QueryString["IsLims"] != null)
        {
            if (Request.QueryString["IsLims"] == "Y")
            {
                if (e.Row.RowType == DataControlRowType.Header)
                {
                    e.Row.Cells[2].Visible = false;
                }
                e.Row.Cells[2].Visible = false;
            }
        }
        else
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[5].Visible = false;
            }
            e.Row.Cells[5].Visible = false;
        }
    }
    //protected void LoadFloorDetails(string pType, int pOrgID, int pOrgAddID, int pBuildingID, int pFloorID, List<RoomDetails> lstFloorDetails)
    //{
    //    long returnCode = -1;
    //    returnCode = RoomBL.GetFloorDetails(pType, pOrgID, ILocationID, pBuildingID, pFloorID, out lstFloorDetails);
    //    GrdFloor.DataSource = lstRoomDetails;
    //    GrdFloor.DataBind();
    //    GrdFloor.Visible = true;
    //}

    protected void GetBedDetails(object sender, EventArgs e)
    {
        string StrTrayNo = Resources.Admin_AppMsg.Admin_SampleArchivalMaster_aspx_33 == null ? "Tray No" : Resources.Admin_AppMsg.Admin_SampleArchivalMaster_aspx_33;
        int pBuildingID = int.Parse(ddlBedBuilding.SelectedValue);
        int pRoomType = int.Parse(ddlBedRoomType.SelectedValue);
        //int pWardID = int.Parse(lstBedRooms.SelectedValue);
        //int pFloorID = int.Parse(lstBedRooms.SelectedValue);
        long returncode = -1;
        string domains = "Days,TrayType";
        string[] Tempdata = domains.Split(',');
        string LangCode = "en-GB";
        List<MetaData> lstmetadataInput = new List<MetaData>();


        MetaData objMeta;
        for (int i = 0; i < Tempdata.Length; i++)
        {
            objMeta = new MetaData();
            objMeta.Domain = Tempdata[i];
            lstmetadataInput.Add(objMeta);

        }
        returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
        long returnCode = RoomBL.GetRoomsDetails(OrgID, ILocationID, pBuildingID, 0, 0, pRoomType, "", "", out lstRoomDetails);
        List<RoomDetails> lstRoomDetailsTmp = new List<RoomDetails>();
        lstRoomDetails = lstRoomDetails.FindAll(P => P.RoomID.ToString() == lstBedRooms.SelectedValue).Distinct().ToList();
        foreach (RoomDetails item in lstRoomDetails)
        {
            //for (int i = 0; i < item.RoomID; i++)
            //{
                RoomDetails rd = new RoomDetails();
                rd.BuildingName = item.BuildingName;
                rd.RoomTypeName = item.RoomTypeName;
                rd.RoomName = item.RoomName;
            rd.ID = item.ID;
            //Convert.ToInt32(item.BedName.Split('^')[i].Split('~')[0]);
            rd.BedName = item.WardName;
            //item.BedName.Split('^')[i].Split('~')[1];
                rd.WardID = item.WardID;
                rd.RoomID = item.RoomID;
                rd.FloorID = item.FloorID;
                rd.NoRows  = item.NoRows ;
                rd.NoColumns  = item.NoColumns ;
            rd.RackType = item.RackType;
            rd.DayNames = item.DayNames;
            rd.WardName = item.WardName;
            string[] tempTray = rd.BedName.Split(' ');
            if (tempTray[0] == "Tray" && tempTray[1] == "No")
            {
                rd.BedName = StrTrayNo + " " + tempTray[2];
                rd.WardName = StrTrayNo + " " + tempTray[2];
            }
            rd.SampleGroupID = item.SampleGroupID;
            rd.SampleCode = item.SampleCode;
            //if (lstRoomDetailsTmp.Where(r => r.ID == rd.ID).Count() <= 0)
            //{
            lstRoomDetailsTmp.Add(rd);
            //}
            //}
        }
        var lstRoomDetailsTmp1 = from child in lstRoomDetailsTmp orderby child.Name select child;
        GrdBedDetails.DataSource = lstRoomDetailsTmp1;
            GrdBedDetails.DataBind();
        //if (lstmetadataOutput.Count > 0)
        //{
        //    foreach (GridViewRow row in GrdBedDetails.Rows)
        //    {
        //        var childItems = from child in lstmetadataOutput
        //                         where child.Domain == "Days"
        //                         select child;
        //        CheckBoxList RTCheckBox = (CheckBoxList)row.FindControl("RTCheckBox");
        //        RTCheckBox.DataSource = childItems;
        //        RTCheckBox.DataTextField = "DisplayText";
        //        RTCheckBox.DataValueField = "Code";
        //        RTCheckBox.DataBind();

        //        var childItems1 = from child in lstmetadataOutput
        //                          where child.Domain == "TrayType"
        //                          select child;
        //        DropDownList ddlTrayType = (DropDownList)row.FindControl("ddlTrayType");
        //        ddlTrayType.DataSource = childItems1;
        //        ddlTrayType.DataTextField = "DisplayText";
        //        ddlTrayType.DataValueField = "Code";
        //        ddlTrayType.DataBind(); 

            GrdBedDetails.Visible = true;
            BtnFinishBeddetails();
        tdSaveBed.Style.Add("display", "block");
    }

    protected List<RoomDetails> CollectBedDetails(string flag)
    {
        string StrTrayNo = Resources.Admin_AppMsg.Admin_SampleArchivalMaster_aspx_33 == null ? "Tray No" : Resources.Admin_AppMsg.Admin_SampleArchivalMaster_aspx_33;
        List<RoomDetails> lstBedInfo = new List<RoomDetails>();
        string[] array = null;
        if (!string.IsNullOrEmpty(hdnlstSampleTypeid.Value) && hdnlstSampleTypeid.Value != "0")
        {
            array = hdnlstSampleTypeid.Value.Split(',');
        }

        int j = 0;
        foreach (GridViewRow row in GrdBedDetails.Rows)
        {
            hdnCheckList.Value = "";
            RoomDetails Bed = new RoomDetails();
            Bed.BuildingName = row.Cells[0].Text;
            Bed.BuildingID = Convert.ToInt32(GrdBedDetails.DataKeys[row.RowIndex].Values[0]);
            Bed.RoomTypeID = Convert.ToInt32(GrdBedDetails.DataKeys[row.RowIndex].Values[1]);
            Bed.RoomTypeName = row.Cells[1].Text;
            Bed.RoomID = Convert.ToInt32(GrdBedDetails.DataKeys[row.RowIndex].Values[2]);
            Bed.RoomName = row.Cells[2].Text;
            Bed.ID = Convert.ToInt32(GrdBedDetails.DataKeys[row.RowIndex].Values[3]);
            Bed.BedName = ((TextBox)row.FindControl("txtBedName")).Text;
            Bed.WardName = ((TextBox)row.FindControl("txtBedName")).Text;
            DropDownList DdlTray = ((DropDownList)row.FindControl("ddlTrayType"));
            if (DdlTray.SelectedItem.Text != null)
            {
                Bed.RackType = DdlTray.SelectedItem.Value;
            }
            Bed.NoRows = Convert.ToInt32(((TextBox)row.FindControl("txtRows")).Text);
            Bed.NoColumns = Convert.ToInt32(((TextBox)row.FindControl("txtColumns")).Text);
            DropDownList ddlSampleGroupID = ((DropDownList)row.FindControl("ddlSampleType"));
            if (!string.IsNullOrEmpty(ddlSampleGroupID.SelectedItem.Value) && ddlSampleGroupID.SelectedItem.Value != "0" && ddlSampleGroupID.SelectedItem.Value != StrSelect)
            {
                Bed.SampleGroupID = Convert.ToInt64(ddlSampleGroupID.SelectedItem.Value);
            }
            DropDownList ddlSampleTypeID = ((DropDownList)row.FindControl("ddlSampleSubType"));
            if (!string.IsNullOrEmpty(hdnlstSampleTypeid.Value) && hdnlstSampleTypeid.Value != "0")
            {
                Bed.SampleCode = Convert.ToInt64(array[j]);
            }
            else
            {
                Bed.SampleCode = 0;
            }

            CheckBoxList CheckList = (CheckBoxList)row.FindControl("RTCheckBox");
            for (int i = 1; i < CheckList.Items.Count; i++)
            {
                if (CheckList.Items[i].Selected)
                {
                    if (String.IsNullOrEmpty(hdnCheckList.Value))
                    {
                        hdnCheckList.Value = CheckList.Items[i].Text + ",";
                    }
                    else
                    {
                        hdnCheckList.Value += CheckList.Items[i].Text + ",";
                    }
                }
            }
            if (hdnCheckList.Value != "")
            {
                Bed.DayNames = hdnCheckList.Value;
            }

            if (flag == "TRAY")
            {
                hdnDays.Value = "";
                TextBox txtRows = (TextBox)row.FindControl("txtRows");
                if (txtRows.Text != "")
                {
                    Bed.FeeID = Convert.ToInt64(txtRows.Text);
                }
                TextBox txtcolumns = (TextBox)row.FindControl("txtColumns");

                if (txtcolumns.Text != "")
                {
                    Bed.RateID = Convert.ToInt16(txtcolumns.Text);
                }
                DropDownList ddlTrayType = (DropDownList)row.FindControl("ddlTrayType");
                if (ddlTrayType.SelectedIndex != 0)
                {
                    Bed.WardName = ddlTrayType.SelectedValue.ToString();
                }
                CheckBoxList chList = (CheckBoxList)row.FindControl("RTCheckBox");
                for (int i = 0; i < chList.Items.Count; i++)
                {
                    if (i != 0)
                    {
                        if (chList.Items[i].Selected == true)
                        {
                            if (hdnDays.Value == "")
                            {
                                hdnDays.Value = "Value=" + chList.Items[i].Value + "|Text=" + chList.Items[i].Text;
                            }
                            else
                            {
                                hdnDays.Value += '^' + "Value=" + chList.Items[i].Value + "|Text=" + chList.Items[i].Text;
                            }
                        }
                    }
                }
                if (hdnDays.Value != "")
                {
                    Bed.FloorName = hdnDays.Value;
                }
            }

            lstBedInfo.Add(Bed);
            j++;
        }

        if (flag == "AddMore")
        {
            int RowCount = 0;
            int RowBedNumber = 0;
            if (GrdBedDetails.Rows.Count > 0)
            {
                RowBedNumber = GrdBedDetails.Rows.Count;
            }

            Int32.TryParse(txtNoOfBeds.Text, out RowCount);
            //GridViewRow row = GrdBedDetails.Rows[GrdBedDetails.Rows.Count - 1]; 
            for (int i = 1; i <= RowCount; i++)
            {
                RoomDetails Bed = new RoomDetails();
                //RowBedNumber = 0;
                Bed.BuildingName = ddlBedBuilding.SelectedItem.Text;
                Bed.BuildingID = int.Parse(ddlBedBuilding.SelectedValue);
                Bed.RoomID = int.Parse(lstBedRooms.SelectedValue);

                //string[] arrItem= lstBedRooms.SelectedItem.Text.Split(',')[0];
                Bed.RoomName = lstBedRooms.SelectedItem.Text.Split(',')[0];
                Bed.RoomTypeID = int.Parse(ddlBedRoomType.SelectedValue);
                Bed.RoomTypeName = ddlBedRoomType.SelectedItem.Text;

                #region UnUsed
                //Bed.RoomName = lstBedRooms.SelectedItem.Text.Split(',')[2];
                //Bed.BuildingID = Convert.ToInt32(GrdBedDetails.DataKeys[row.RowIndex].Values[0]);
                //Bed.RoomTypeID = Convert.ToInt32(GrdBedDetails.DataKeys[row.RowIndex].Values[1]);
                //Bed.RoomID = Convert.ToInt32(GrdBedDetails.DataKeys[row.RowIndex].Values[2]);
                //Bed.BuildingName = row.Cells[0].Text;
                //Bed.BuildingID = Convert.ToInt32(GrdBedDetails.DataKeys[row.RowIndex].Values[0]);
                //Bed.RoomTypeID = Convert.ToInt32(GrdBedDetails.DataKeys[row.RowIndex].Values[1]);
                //Bed.RoomTypeName = row.Cells[1].Text;
                //Bed.RoomID = Convert.ToInt32(GrdBedDetails.DataKeys[row.RowIndex].Values[2]);
                //Bed.RoomName = row.Cells[2].Text;
                #endregion

                Bed.ID = 0;
                Bed.BedName = StrTrayNo+" -" + (RowBedNumber + i).ToString();
                Bed.WardName = StrTrayNo + " -" +(RowBedNumber + i).ToString();
                Bed.NoRows = 0;
                Bed.NoColumns = 0;

                lstBedInfo.Add(Bed);

            }
        }
        return lstBedInfo;
    }


    protected void btnAddMore_Click(object sender, EventArgs e)
    {
        long returncode = -1;
        string domains = "Days,TrayType";
        string[] Tempdata = domains.Split(',');
        string LangCode = "en-GB";
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();

        MetaData objMeta;
        for (int i = 0; i < Tempdata.Length; i++)
        {
            objMeta = new MetaData();
            objMeta.Domain = Tempdata[i];
            lstmetadataInput.Add(objMeta);

        }
        returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
        GrdBedDetails.DataSource = CollectBedDetails("AddMore");
        GrdBedDetails.DataBind();
        //foreach (GridViewRow row in GrdBedDetails.Rows)
        //{
        //    if (lstmetadataOutput.Count > 0)
        //    {
        //        var childItems = from child in lstmetadataOutput
        //                         where child.Domain == "Days"
        //                         select child;
        //        CheckBoxList RTCheckBox = (CheckBoxList)row.FindControl("RTCheckBox");
        //        RTCheckBox.DataSource = childItems;
        //        RTCheckBox.DataTextField = "DisplayText";
        //        RTCheckBox.DataValueField = "Code";
        //        RTCheckBox.DataBind();

        //        var childItems1 = from child in lstmetadataOutput
        //                          where child.Domain == "TrayType"
        //                          select child;
        //        DropDownList ddlTrayType = (DropDownList)row.FindControl("ddlTrayType");
        //        ddlTrayType.DataSource = childItems1;
        //        ddlTrayType.DataTextField = "DisplayText";
        //        ddlTrayType.DataValueField = "Code";
        //        ddlTrayType.DataBind();
        //    }
        //}

        GrdBedDetails.Visible = true;
        btnSaveNOofBed.Style.Add("display", (GrdBedDetails.Rows.Count > 0 ? "block" : "none"));
        txtNoOfBeds.Text = "";
    }

    public void BindRoomRate()
    {
        try
        {
            long Returncode = -1;
            string OrgType = "COrg";
            Returncode = objBl.pGetRateTypeMaster(OrgID, OrgType, out lstRateType);
            var lstRateType1 = from child in lstRateType orderby child.RateName select child;
            ddlRoomFeeRate.DataSource = lstRateType;
            ddlRoomFeeRate.DataTextField = "RateName";
            ddlRoomFeeRate.DataValueField = "RateID";
            ddlRoomFeeRate.DataBind();
            ddlRoomFeeRate.Items.Insert(0, StrSelect);
            ddlRoomFeeRate.Items[0].Value = "0";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in load client", ex);
        }
    }
    private long FinishRoomDetails(List<RoomDetails> lstRoomDetails, long lResult)
    {
        string WinAlert = Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_Alert == null ? "Alert" : Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_Alert;
        string UsrMsgWin = Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_04 == null ? "Saved Successfully" : Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_04;
        lResult = RoomBL.SaveRoomMasterData(ddlMaster.SelectedValue, OrgID, ILocationID, lstRoomDetails, hdnIsSlotable.Value, hdnIsAnOT.Value);

        if (lResult != -1)
        {
            //string sPath = "Admin\\\\RoomMasterDetails.aspx.cs_32";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "alert('Saved Successfully')", true);
            //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Admin\\RoomMasterDetails.aspx.cs_32").ToString();
            //if (sUserMsg != null)
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "alert(" + sUserMsg + ")", true);
            //}

            //else
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Saved Successfully!');", true);
            //}
        }

        else
        {
            string sPath = "Admin\\\\RoomMasterDetails.aspx.cs_33";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ")", true);

            //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Admin\\RoomMasterDetails.aspx.cs_33").ToString();
            //if (sUserMsg != null)
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "alert(" + sUserMsg + ")", true);
            //}
            //else
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Changes Saved Successfully!');", true);
            //}
        }

        return lResult;

    }
    private void BtnAddRooms()
    {
        hdnRoomName.Value = "";
        hdnNoofBeds.Value = "";
        hdnNoofRows.Value = "";
        hdnNoOfColumns.Value = "";

        ClinicalTrail_BL CT_BL = new ClinicalTrail_BL(base.ContextInfo);
        CT_BL.GetShippingCondition(OrgID, out lstShippingConditionMaster);
        foreach (GridViewRow row in GrdRoomDetails.Rows)
        {
            TextBox txtRoom = (TextBox)row.FindControl("txtRoomName");
            TextBox txtbNoOfbeds = (TextBox)row.FindControl("txtBeds");
            TextBox txtRows = (TextBox)row.FindControl("txtRows");
            TextBox txtColumns = (TextBox)row.FindControl("txtColumns");

            hdnRoomName.Value += txtRoom.ClientID.ToString() + "~";
            hdnNoofBeds.Value += txtbNoOfbeds.ClientID.ToString() + "~";

            hdnNoofRows.Value += txtRows.ClientID.ToString() + "~";
            hdnNoOfColumns.Value += txtColumns.ClientID.ToString() + "~";

            if (lstShippingConditionMaster.Count > 0)
            {
                DropDownList ddl = (DropDownList)row.FindControl("ddlSampleCondition");
                if (ddl != null)
                {
                    var lstShippingConditionMaster1 = from child in lstShippingConditionMaster orderby child.ConditionDesc select child;
                    ddl.DataSource = lstShippingConditionMaster1;
                    ddl.DataTextField = "ConditionDesc";
                    ddl.DataValueField = "ShippingConditionID";
                    ddl.DataBind();
                    ddl.Items.Insert(0, StrSelect);
                }
            }
        }
    }

    private void BtnFinishBeddetails()
    {
        hdnBedName.Value = "";
        foreach (GridViewRow rows in GrdBedDetails.Rows)
        {
            TextBox txtBedName = (TextBox)rows.FindControl("txtBedName");
            hdnBedName.Value += txtBedName.ClientID.ToString() + "~";

        }
        btnSaveNOofBed.Style.Add("display", (GrdBedDetails.Rows.Count > 0 ? "block" : "none"));
    }
    private long FinishBed(List<RoomDetails> lstRoomDetails, long lResult)
    {
        string WinAlert = Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_Alert == null ? "Alert" : Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_Alert;
        string UsrMsgWin = Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_04 == null ? "Saved Successfully" : Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_04;
        lResult = RoomBL.SaveRoomMasterData(ddlMaster.SelectedValue, OrgID, ILocationID, lstRoomDetails, hdnIsSlotable.Value, hdnIsAnOT.Value);

        if (lResult != 0)
        {
            string sPath = "Admin\\\\RoomMasterDetails.aspx.cs_32";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ")", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Saved Successfully!');", true);
            //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Admin\\RoomMasterDetails.aspx.cs_32").ToString();
            //if (sUserMsg != null)
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "alert(" + sUserMsg + ")", true);
            //}

            //else
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Saved Successfully!');", true);
            //}
        }

        return lResult;
    }

    public void LoadMetaData()
    {
        try
        {
            if (Request.QueryString["IsLims"] != null)
            {
                if (Request.QueryString["IsLims"] == "Y")
                {
                    long returncode = -1;
                    string domains = "SampleStore";
                    string[] Tempdata = domains.Split(',');
                    string LangCode = "en-GB";
                    // string LangCode = string.Empty;
                    List<MetaData> lstmetadataInput = new List<MetaData>();
                    List<MetaData> lstmetadataOutput = new List<MetaData>();

                    MetaData objMeta;

                    for (int i = 0; i < Tempdata.Length; i++)
                    {
                        objMeta = new MetaData();
                        objMeta.Domain = Tempdata[i];
                        lstmetadataInput.Add(objMeta);

                    }

                    // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
                    returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
                    //if (returncode == 0)
                    //{
                    if (lstmetadataOutput.Count > 0)
                    {
                        var childItems = from child in lstmetadataOutput
                                         where child.Domain == "SampleStore" orderby child.DisplayText
                                         select child;
                        ddlMaster.DataSource = childItems;
                        ddlMaster.DataTextField = "DisplayText";
                        ddlMaster.DataValueField = "Code";
                        ddlMaster.DataBind();
                        ddlMaster.Items.Insert(0, StrSelect);
                        ddlMaster.Items[0].Value = "-1";


                    }


                }

            }
            else

            //}
            {

                long returncode = -1;
                string domains = "RoomMaster,LogicType";
                string[] Tempdata = domains.Split(',');
                string LangCode = "en-GB";
                // string LangCode = string.Empty;
                List<MetaData> lstmetadataInput = new List<MetaData>();
                List<MetaData> lstmetadataOutput = new List<MetaData>();

                MetaData objMeta;

                for (int i = 0; i < Tempdata.Length; i++)
                {
                    objMeta = new MetaData();
                    objMeta.Domain = Tempdata[i];
                    lstmetadataInput.Add(objMeta);

                }

                // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
                returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
                //if (returncode == 0)
                //{
                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "RoomMaster" orderby child.DisplayText
                                     select child;
                    ddlMaster.DataSource = childItems;
                    ddlMaster.DataTextField = "DisplayText";
                    ddlMaster.DataValueField = "Code";
                    ddlMaster.DataBind();
                    ddlMaster.Items.Insert(0, StrSelect);
                    ddlMaster.Items[0].Value = "-1";
                    var LogicType = from child in lstmetadataOutput
                                    where child.Domain == "LogicType"
                                    orderby child.DisplayText
                                    select child;
                    ddlFeelogic.DataSource = LogicType;
                    ddlFeelogic.DataTextField = "DisplayText";
                    ddlFeelogic.DataValueField = "Code";
                    ddlFeelogic.DataBind();
                    ddlFeelogic.Items.Insert(0, StrSelect);
                    ddlFeelogic.Items[0].Value = "-1";


                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }

    protected void ddlTrays_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DepartNme.Visible = true;
            getValuesDeptAndAnalyser();
            loadSampleArchival();
        }
        catch (Exception Ex)
        {
        }
    }

    private void loadSampleArchival()
    {
        Investigation_BL oInvestigation_BL = new Investigation_BL(base.ContextInfo);
        int rackId = 0;
        Int32.TryParse(ddlTrays.SelectedValue, out rackId);
        DataTable dtSampleArchival = new DataTable();
        oInvestigation_BL.GetSampleArchival(rackId, out dtSampleArchival);
        grdSampleArchival.DataSource = dtSampleArchival;
        grdSampleArchival.DataBind();
        grdSampleArchival.Visible = true;
        btnSaveSampleArchival.Visible = true;
    }

    public void getValuesDeptAndAnalyser()
    {
        long returnCode = -1;
        Investigation_BL oInvestigation_BL = new Investigation_BL(base.ContextInfo);
         List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
         List<InvInstrumentMaster>   lstAnalyser = new List<InvInstrumentMaster>();
         returnCode = oInvestigation_BL.GetDeptAndAnalyser(out lstInvDeptMaster, out lstAnalyser);

         if (lstInvDeptMaster.Count > 0)
         {
             var lstInvDeptMaster1 = from child in lstInvDeptMaster orderby child.DeptName select child;
             ddlDeptName.DataSource = lstInvDeptMaster1;
             ddlDeptName.DataTextField = "DeptName";
             ddlDeptName.DataValueField = "DeptID";
             ddlDeptName.DataBind();
             ddlDeptName.Items.Insert(0, StrSelect);
             ddlDeptName.Items[0].Value = "0";
         }
         if (lstAnalyser.Count > 0)
         {
             var lstAnalyser1 = from child in lstAnalyser orderby child.InstrumentName select child;
             ddlAnalyName.DataSource = lstAnalyser1;
             ddlAnalyName.DataTextField = "InstrumentName";
             ddlAnalyName.DataValueField = "InstrumentID";
             ddlAnalyName.DataBind();
             ddlAnalyName.Items.Insert(0, StrSelect);
             ddlAnalyName.Items[0].Value = "0";
         }

    }

    protected void grdSampleArchival_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            CheckBox chkGridRow = new CheckBox();
            chkGridRow.ID = "chkGridRow" + (e.Row.RowIndex + 1);
            chkGridRow.Attributes.Add("onclick", "SelectAll();");
            e.Row.Cells[0].Controls.Add(chkGridRow);
            for (int i = 1; i < e.Row.Cells.Count; i++)
            {
                CheckBox chkGridColumn = new CheckBox();
                chkGridColumn.ID = "chkGridColumn" + i;
                chkGridColumn.Attributes.Add("onclick", "SelectColumn(" + i + ");");
                e.Row.Cells[i].Controls.Add(chkGridColumn);
            }
        }
        else if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chkGridRow = new CheckBox();
            chkGridRow.ID = "chkGridRow" + (e.Row.RowIndex + 1);
            chkGridRow.Attributes.Add("onclick", "SelectRow(" + (e.Row.RowIndex + 1) + ");");
            e.Row.Cells[0].Controls.Add(chkGridRow);
            e.Row.Cells[0].CssClass = "dataheader1";
            e.Row.Cells[0].Width = 20;

            for (int i = 1; i < e.Row.Cells.Count; i++)
            {
                string text = e.Row.Cells[i].Text;
                string[] lstData = text.Split('~');
                string cellIndex = string.Empty;
                if (lstData[0] != null && lstData[1] != null)
                {
                    cellIndex = lstData[0] + "," + lstData[1];
                }
                string DeptID = string.Empty;
                string DeviceID = string.Empty;
                string DeptName = string.Empty;
                string DeviceName = string.Empty;
                if (lstData[2] != null && lstData[3] != null)
                {
                    DeptID = lstData[2];
                    DeptName = lstData[3];
                }
                if (lstData[4] != null && lstData[5] != null)
                {
                    DeviceID = lstData[4];
                    DeviceName = lstData[5];
                }
                Label lblGridCellData = new Label();
                lblGridCellData.ID = (e.Row.RowIndex + 1) + "" + i + "lblGridCellData";
                lblGridCellData.Text = cellIndex + (string.IsNullOrEmpty(DeptName) ? "" : "<br/>" + DeptName) + (string.IsNullOrEmpty(DeviceName) ? "" : "<br/>" + DeviceName);

                Label lblGridDeptID = new Label();
                lblGridDeptID.ID = e.Row.RowIndex + 1 + "" + i + "lblGridDeptID";
                lblGridDeptID.Text = DeptID;
                lblGridDeptID.Style.Add("display", "none");

                Label lblGridDeviceID = new Label();
                lblGridDeviceID.ID = e.Row.RowIndex + 1 + "" + i + "lblGridDeviceID";
                lblGridDeviceID.Text = DeviceID;
                lblGridDeviceID.Style.Add("display", "none");

                e.Row.Cells[i].Attributes.Add("onclick", "SelectCell(" + (e.Row.RowIndex + 1) + "," + i + ");");
                e.Row.Cells[i].Controls.Add(lblGridCellData);
                e.Row.Cells[i].Controls.Add(lblGridDeptID);
                e.Row.Cells[i].Controls.Add(lblGridDeviceID);
                e.Row.Cells[i].HorizontalAlign = HorizontalAlign.Center;
            }
        }
    }
    protected void btnSaveSampleArchival_Click(object sender, EventArgs e)
    {
        string WinAlert = Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_Alert == null ? "Alert" : Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_Alert;
        string UsrMsgWin = Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_04 == null ? "Saved Successfully" : Resources.Admin_ClientDisplay.Admin_SampleArchivalMaster_aspx_04;
        List<SampleArchival> lstSampleArchival = new List<SampleArchival>();
        JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
        if (!string.IsNullOrEmpty(hdnLstSampleArchival.Value))
        {
            lstSampleArchival = oJavaScriptSerializer.Deserialize<List<SampleArchival>>(hdnLstSampleArchival.Value);
            Investigation_BL oInvestigationBL = new Investigation_BL(base.ContextInfo);
            oInvestigationBL.SaveSampleArchivalMasterDetails("master", lstSampleArchival);
        }
        loadSampleArchival();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "saved", "alert('Saved Successfully')", true);
    }
   

    protected void GrdBedDetails_OnRowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            RoomDetails IOM = (RoomDetails)e.Row.DataItem;
            long returncode = -1;
            string domains = "Days,TrayType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            var childItems = from child in lstmetadataOutput
                             where child.Domain == "Days"
                             orderby child.Code ascending 
                             select child;
            CheckBoxList RTCheckBox = (CheckBoxList)e.Row.FindControl("RTCheckBox");
           // var newchildItems = from child in childItems orderby child.DisplayText select child;
            RTCheckBox.DataSource = childItems;
            RTCheckBox.DataTextField = "DisplayText";
            RTCheckBox.DataValueField = "Code";
            RTCheckBox.DataBind();

            var childItems1 = from child in lstmetadataOutput
                              where child.Domain == "TrayType" & child.Code !="0"
                              orderby child.DisplayText select child;
            DropDownList ddlTrayType = (DropDownList)e.Row.FindControl("ddlTrayType");
            ddlTrayType.DataSource = childItems1;
            ddlTrayType.DataTextField = "DisplayText";
            ddlTrayType.DataValueField = "Code";
            ddlTrayType.DataBind();
            ddlTrayType.Items.Insert(0, StrSelect);

            ddlTrayType.SelectedIndex = (ddlTrayType.Items.IndexOf(ddlTrayType.Items.FindByText(IOM.RackType)));

            List<InvSampleGroupMaster> lstInvSampleGroupMaster = new List<InvSampleGroupMaster>();
            returncode = new Master_BL(base.ContextInfo).GetSampleType(OrgID, LID, out lstInvSampleGroupMaster);

            DropDownList ddlSampleType = (DropDownList)e.Row.FindControl("ddlSampleType");
            DropDownList ddlSampleSubType = (DropDownList)e.Row.FindControl("ddlSampleSubType");
            if (lstInvSampleGroupMaster.Count > 0)
            {
                var lstInvSampleGroupMaster1 = from child in lstInvSampleGroupMaster orderby child.SampleGroupName select child;
                ddlSampleType.DataSource = lstInvSampleGroupMaster1;
                ddlSampleType.DataTextField = "SampleGroupName";
                ddlSampleType.DataValueField = "SampleGroupID";
                ddlSampleType.DataBind();
                ddlSampleType.Items.Insert(0, StrSelect);
            }
            ddlSampleType.SelectedIndex = (ddlSampleType.Items.IndexOf(ddlSampleType.Items.FindByValue(IOM.SampleGroupID.ToString())));
            int pSampleGroupID = Convert.ToInt32(IOM.SampleGroupID);
            if (!string.IsNullOrEmpty(pSampleGroupID.ToString()) && pSampleGroupID != 0)
            {
                List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
                returncode = new Master_BL(base.ContextInfo).GetSampleSubType(OrgID, pSampleGroupID, out  lstInvSampleMaster);

                if (lstInvSampleMaster.Count > 0)
                {
                    var lstInvSampleMaster1 = from child in lstInvSampleMaster orderby child.SampleDesc select child;
                    ddlSampleSubType.DataSource = lstInvSampleMaster1;
                    ddlSampleSubType.DataTextField = "SampleDesc";
                    ddlSampleSubType.DataValueField = "SampleCode";
                    ddlSampleSubType.DataBind();
                }
            }
            ddlSampleSubType.SelectedIndex = (ddlSampleSubType.Items.IndexOf(ddlSampleSubType.Items.FindByValue(IOM.SampleCode.ToString())));
            if (string.IsNullOrEmpty(hdnlstSampleTypeid.Value))
            {
                hdnlstSampleTypeid.Value = IOM.SampleCode.ToString();
            }
            else
            {
                hdnlstSampleTypeid.Value = hdnlstSampleTypeid.Value + "," + IOM.SampleCode.ToString();
            }

            ddlSampleSubType.Items.Insert(0, StrSelect);

            string[] array = null;
            if (!string.IsNullOrEmpty(IOM.DayNames))
            {
                array = IOM.DayNames.Split(',');
                foreach (ListItem Item in RTCheckBox.Items)
                {
                    for (int i = 0; i < array.Length - 1; i++)
                    {
                        if (!string.IsNullOrEmpty(array[i]))
                            if (Item.Text == array[i].Trim())
                            {
                                Item.Selected = true;
                                // break;
                            }
                    }

                }
            }
            if (IOM.RackType == "Batch")
            {
                RTCheckBox.Attributes.Remove("disabled");

            }
            else
            {

                RTCheckBox.Attributes.Add("disabled", "true");
            }
        }
    }
}
