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


public partial class Admin_RoomMasterDetails : BasePage
{
    #region Variable Declaration

    List<RoomDetails> lstRoomDetails = new List<RoomDetails>();
    List<RoomDetails> lstBuildingDetails = new List<RoomDetails>();
    List<RoomDetails> RDFeeList = new List<RoomDetails>();
    List<RoomDetails> RDFeedetList = new List<RoomDetails>();
    RoomBooking_BL RoomBL ;


    AdminReports_BL objBl ;
    List<RateTypeMaster> lstRateTypeMaster = new List<RateTypeMaster>();
    List<RateMaster> lstRateType = new List<RateMaster>();
    int flag;


    #endregion

    #region Events

    public Admin_RoomMasterDetails()
        : base("Admin\\RoomMasterDetails.aspx")
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

        }



    }

    protected void ddlMaster_SelectedIndexChanged(object sender, EventArgs e)
    {
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
                    tbBuilding.Visible = true;
                    TbBed.Visible = false;
                    tbFloor.Visible = false;
                    GrdRoomDetails.Visible = false;
                    tbRooms.Visible = false;
                    tdChkSlotable.Style.Add("display", "none");
                    LoadRoomMasterDetails(ddlMaster.SelectedValue, 0);
                    gvResult.Visible = true;
                    GrdBedDetails.Visible = false;
                    lblbuName.Text = "Enter " + ddlMaster.SelectedValue + " Name";
                    break;
                case "FLOOR":
                    lblName.Text = "Enter " + ddlMaster.SelectedValue + " Name";
                    //lblbuName.Text = "Enter" + ddlMaster.SelectedValue +" Name";
                    tbFloor.Visible = true;
                    tbBuilding.Visible = false;
                    tbRooms.Visible = false;
                    GrdRoomDetails.Visible = false;
                    GrdBedDetails.Visible = false;
                    TbBed.Visible = false;
                    tdChkSlotable.Style.Add("display", "none");
                    LoadBuildingDropDown("Building", ddlBuilding);
                    break;
                case "WARD":
                    lblName.Text = "Enter " + ddlMaster.SelectedValue + " Name";
                    tbFloor.Visible = true;
                    tbBuilding.Visible = false;
                    tbRooms.Visible = false;
                    GrdRoomDetails.Visible = false;
                    GrdBedDetails.Visible = false;
                    TbBed.Visible = false;
                    tdChkSlotable.Style.Add("display", "none");
                    LoadBuildingDropDown("Building", ddlBuilding);
                    break;
                case "ROOM_TYPE":
                    hdnddlroomrate.Value = "";
                    tbBuilding.Visible = true;
                    tbFloor.Visible = false;
                    tbRooms.Visible = false;
                    tdChkSlotable.Style.Add("display", "table-cell");
                    LoadRoomFeesType();
                    LoadRoomMasterDetails(ddlMaster.SelectedValue, 0);
                    gvResult.Visible = true;
                    GrdBedDetails.Visible = false;
                    GrdRoomDetails.Visible = false;
                    TbBed.Visible = false;
                    lblbuName.Text = "Enter " + ddlMaster.SelectedItem.Text + " Name";//Changed by farook
                    break;
                case "ROOMS":
                    tbBuilding.Visible = false;
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
                    GrdRoomDetails.Visible = false;
                    TbBed.Visible = true;
                    LoadRoomDetails();
                    LoadBuildingDropDown("Building", ddlBedBuilding);
                    lstBedRooms.Attributes.Add("ondblclick", "lstBedRooms_dblclick();");
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
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
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
                if (ddlMaster.SelectedValue != "ROOM_TYPE")
                {
                    e.Row.Cells[2].Visible = false;
                }
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    RoomDetails IOM = (RoomDetails)e.Row.DataItem;
                    string pRoomType = "";
                    if (ddlMaster.SelectedValue == "ROOM_TYPE")
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
        List<RoomDetails> lstRoomDetails = new List<RoomDetails>();
        long lResult = -1;
        try
        {
            switch (ddlMaster.SelectedValue)
            {
                case "BUILDING":
                    lstRoomDetails = GetRoomList("Add");
                    lResult = SaveRoomDetails(lstRoomDetails, lResult, (hdnpSta.Value == "Add" ? true : false));
                    ddlMaster_SelectedIndexChanged(sender, e);
                    break;
                case "FLOOR":
                    lstRoomDetails = GetRoomList("Add");
                    lResult = SaveRoomDetails(lstRoomDetails, lResult, (hdnpSta.Value == "Add" ? true : false));
                    ddlBuilding_SelectedIndexChanged(sender, e);
                    break;
                case "WARD":
                    lstRoomDetails = GetRoomList("Add");
                    lResult = SaveRoomDetails(lstRoomDetails, lResult, (hdnpSta.Value == "Add" ? true : false));
                    ddlBuilding_SelectedIndexChanged(sender, e);
                    break;
                case "ROOM_TYPE":
                    lstRoomDetails = GetRoomFeeList("Add");
                    lResult = SaveRoomDetails(lstRoomDetails, lResult, (hdnpSta.Value == "Add" ? true : false));
                    ddlMaster_SelectedIndexChanged(sender, e);
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
            rd.RoomName = "Room-" + RowNumber.ToString();
            rd.NoBeds = 0;
            lstRoomDetails.Add(rd);
        }

        LoadRoomMaster(lstRoomDetails);
        tdRoomFinish.Style.Add("display", "block");
    }



    private long SaveRoomDetails(List<RoomDetails> lstRoomDetails, long lResult, bool msgFlag)
    {
        lResult = RoomBL.SaveRoomMasterData(ddlMaster.SelectedValue, OrgID, ILocationID, lstRoomDetails, hdnIsSlotable.Value,hdnIsAnOT.Value);

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
        GrdRoomDetails.DataSource = lstRoomDetails;
        GrdRoomDetails.DataBind();
        GrdRoomDetails.Visible = true;
        BtnAddRooms();


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
            rd.WardName = row.Cells[2].Text;
            rd.WardID = Convert.ToInt32(GrdRoomDetails.DataKeys[row.RowIndex][1]);
            rd.RoomTypeName = row.Cells[3].Text.Trim();
            rd.RoomTypeID = Convert.ToInt32(GrdRoomDetails.DataKeys[row.RowIndex][2]);
            TextBox roomname = (TextBox)row.FindControl("txtRoomName");
            TextBox nobeds = (TextBox)row.FindControl("txtBeds");
            rd.NoBeds = Convert.ToInt32(nobeds.Text);
            rd.RoomName = roomname.Text.Trim();
            rd.RoomID = Convert.ToInt32(GrdRoomDetails.DataKeys[row.RowIndex][3]);
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
        LoadBuildingDropDown(ddlRoomWard, lstBuildingDetails = new List<RoomDetails>());
        LoadBuildingDropDown(ddlRoomRoomType, RDFeedetList);
        SetHiddenDDLValues(lstRoomDetails, hdnFloor);
        SetHiddenDDLValues(RDFeeList, hdnWard);
        LoadBuildingDropDown(ddlBedBuilding, lstBuildingDetails);//BedBuilding DDL
        LoadBuildingDropDown(ddlBedRoomType, RDFeedetList);//bedroomtype


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
        ddl.DataSource = lsttempRoomDetails;
        ddl.DataTextField = "Name";
        ddl.DataValueField = "ID";
        ddl.DataBind();
        ddl.Items.Insert(0, "--Select--");
        ddl.Items[0].Value = "-1";

    }

    private void LoadRoomMasterDetails(string pType, int pBuildingID)
    {
        long returnCode = -1;
        returnCode = RoomBL.LoadRoomMasterDetails(pType, OrgID, ILocationID, pBuildingID, out lstRoomDetails);
        gvResult.DataSource = lstRoomDetails;
        gvResult.DataBind();

    }
    private void LoadBuildingDropDown(string pType, DropDownList ddl)
    {
        long returnCode = -1;
        returnCode = RoomBL.LoadRoomMasterDetails(pType, OrgID, ILocationID, 0, out lstRoomDetails);
        ddl.DataSource = lstRoomDetails;
        ddl.DataTextField = "Name";
        ddl.DataValueField = "ID";
        ddl.DataBind();
        ddl.Items.Insert(0, "--Select--");
        ddl.Items[0].Value = "-1";

    }
    private List<RoomDetails> GetRoomFeeList(string sType)
    {
        List<RoomDetails> lstRoomDetails = new List<RoomDetails>();
        if (sType == "Add" || sType == "Upd")
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
            ddlRoomfeestype.DataSource = RDFeedetList;
            ddlRoomfeestype.DataTextField = "Description";
            ddlRoomfeestype.DataValueField = "FeeID";
            ddlRoomfeestype.DataBind();
            ddlRoomfeestype.Items.Insert(0, "--Select--");
            ddlRoomfeestype.Items[0].Value = "-1";

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While ddlRoomfeestype Details.", Ex);
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    private string GetRoomTypeValuees(RoomDetails IOM)
    {
        string pRoomType = "";

        foreach (RoomDetails item in RDFeeList.FindAll(P => P.RoomTypeID == IOM.ID))
        {
            pRoomType += item.RoomTypeID + "~" + item.Name + "~" + item.RoomTypeFeeMappingID + "~" + item.FeeID + "~" + item.Amount + "~" +
                item.ISVariable + "~" + item.ISOptional + "~" + item.RateID + "~" + item.FeelogicID+"~"+item.FeebasedOn+ "^";
        }

        return pRoomType;
    }

    #endregion

    protected void loadRoomMaster_Details(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            int pBuildingID = int.Parse(ddlRoomBuilding.SelectedValue);
            int pWardID = int.Parse(ddlRoomWard.SelectedValue);
            int pFloorID = int.Parse(ddlRoomFloor.SelectedValue);
            int pRoomType = int.Parse(ddlRoomRoomType.SelectedValue);
            returnCode = RoomBL.GetRoomsDetails(OrgID, ILocationID, pBuildingID, pWardID, pFloorID, pRoomType,string.Empty,string.Empty, out lstRoomDetails);
            LoadRoomMaster(lstRoomDetails);
            tdRoomFinish.Style.Add("display", (lstRoomDetails.Count > 0 ? "block" : "none"));

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While LoadRoomMasterDetails.", Ex);
           // ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    protected void LoadRoomBedList(object sender, EventArgs e)
    {

        int pBuildingID = int.Parse(ddlBedBuilding.SelectedValue);
        int pRoomType = int.Parse(ddlBedRoomType.SelectedValue);

        long returnCode = RoomBL.GetRoomsDetails(OrgID, ILocationID, pBuildingID, 0, 0, pRoomType,string.Empty,string.Empty, out lstRoomDetails);

        List<RoomDetails> lstFilterbedRooms = (from list in lstRoomDetails
                                               where list.BuildingID == pBuildingID && list.RoomTypeID == pRoomType
                                               select new RoomDetails
                                               {
                                                   RoomTypeID = list.RoomTypeID,
                                                   RoomID = list.RoomID,
                                                   RoomName = list.RoomName + "," + list.FloorName + "," + list.WardName + "(Beds-" + list.NoBeds + ")"
                                               }).ToList<RoomDetails>();
        //var lstFilteredRooms = (from list in lstRoomDetails
        //                                      where list.BuildingID == pBuildingID && list.RoomTypeID == pRoomType
        //                                      select new RoomDetails
        //                                      {
        //                                          RoomTypeID = list.RoomTypeID,
        //                                          RoomName = list.RoomName + "(" + list.NoBeds + ")"
        //                                      }).ToList<RoomDetails>();

        int NoOfRooms = lstFilterbedRooms.Count();
        txtNoofRooms.Text = NoOfRooms.ToString();
        lstBedRooms.DataSource = lstFilterbedRooms;
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
        ddl.DataSource = lstDetails;
        ddl.DataTextField = "Name";
        ddl.DataValueField = "ID";
        ddl.DataBind();
        ddl.Items.Insert(0, "--Select--");
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
            }
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
        int pBuildingID = int.Parse(ddlBedBuilding.SelectedValue);
        int pRoomType = int.Parse(ddlBedRoomType.SelectedValue);
        //int pWardID = int.Parse(lstBedRooms.SelectedValue);
        //int pFloorID = int.Parse(lstBedRooms.SelectedValue);
        long returnCode = RoomBL.GetRoomsDetails(OrgID, ILocationID, pBuildingID, 0, 0, pRoomType,string.Empty,string.Empty, out lstRoomDetails);
        List<RoomDetails> lstRoomDetailsTmp = new List<RoomDetails>();
        foreach (RoomDetails item in lstRoomDetails)
        {
            for (int i = 0; i < item.NoBeds; i++)
            {
                RoomDetails rd = new RoomDetails();
                rd.BuildingName = item.BuildingName;
                rd.RoomTypeName = item.RoomTypeName;
                rd.RoomName = item.RoomName;
                rd.ID = Convert.ToInt32(item.BedName.Split('^')[i].Split('~')[0]);
                rd.BedName = item.BedName.Split('^')[i].Split('~')[1];
                rd.WardID = item.WardID;
                rd.RoomID = item.RoomID;
                rd.FloorID = item.FloorID;
                lstRoomDetailsTmp.Add(rd);
            }
            GrdBedDetails.DataSource = lstRoomDetailsTmp.FindAll(P => P.RoomID.ToString() == lstBedRooms.SelectedValue);
            GrdBedDetails.DataBind();
            GrdBedDetails.Visible = true;
            BtnFinishBeddetails();


        }

        tdSaveBed.Style.Add("display", "block");
    }

    protected List<RoomDetails> CollectBedDetails(string flag)
    {
        List<RoomDetails> lstBedInfo = new List<RoomDetails>();


        foreach (GridViewRow row in GrdBedDetails.Rows)
        {
            RoomDetails Bed = new RoomDetails();
            Bed.BuildingName = row.Cells[0].Text;
            Bed.BuildingID = Convert.ToInt32(GrdBedDetails.DataKeys[row.RowIndex].Values[0]);
            Bed.RoomTypeID = Convert.ToInt32(GrdBedDetails.DataKeys[row.RowIndex].Values[1]);
            Bed.RoomTypeName = row.Cells[1].Text;
            Bed.RoomID = Convert.ToInt32(GrdBedDetails.DataKeys[row.RowIndex].Values[2]);
            Bed.RoomName = row.Cells[2].Text;
            Bed.ID = Convert.ToInt32(GrdBedDetails.DataKeys[row.RowIndex].Values[3]);
            Bed.BedName = ((TextBox)row.FindControl("txtBedName")).Text;
            lstBedInfo.Add(Bed);

        }

        if (flag == "AddMore")
        {
            int RowCount = 0;
            int RowBedNumber = 0;
            if (GrdBedDetails.Rows.Count > 0)
            {
                //lstRoomDetails = GetRoomCount();
                RowBedNumber = GrdBedDetails.Rows.Count;
            }

            Int32.TryParse(txtNoOfBeds.Text, out RowCount);
            //GridViewRow row = GrdBedDetails.Rows[GrdBedDetails.Rows.Count - 1]; 
            for (int i = 1; i <= RowCount; i++)
            {
                RoomDetails Bed = new RoomDetails();
                RowBedNumber = RowBedNumber + 1;
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
                Bed.BedName = "Bed-" + RowBedNumber.ToString();
                lstBedInfo.Add(Bed);
            }

        }


        return lstBedInfo;
    }


    protected void btnAddMore_Click(object sender, EventArgs e)
    {
        GrdBedDetails.DataSource = CollectBedDetails("AddMore");
        GrdBedDetails.DataBind();
        GrdBedDetails.Visible = true;
        btnSaveNOofBed.Style.Add("display", (GrdBedDetails.Rows.Count > 0 ? "block" : "none"));
    }

    public void BindRoomRate()
    {
        try
        {
            long Returncode = -1;
            string OrgType = "COrg";
            Returncode = objBl.pGetRateTypeMaster(OrgID, OrgType, out lstRateType);
            ddlRoomFeeRate.DataSource = lstRateType;
            ddlRoomFeeRate.DataTextField = "RateName";
            ddlRoomFeeRate.DataValueField = "RateID";
            ddlRoomFeeRate.DataBind();
            ddlRoomFeeRate.Items.Insert(0, "---Select---");
            ddlRoomFeeRate.Items[0].Value = "0";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in load client", ex);
        }
    }
    private long FinishRoomDetails(List<RoomDetails> lstRoomDetails, long lResult)
    {
        lResult = RoomBL.SaveRoomMasterData(ddlMaster.SelectedValue, OrgID, ILocationID, lstRoomDetails, hdnIsSlotable.Value,hdnIsAnOT.Value);

        if (lResult != -1)

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

        return lResult;

    }
    private void BtnAddRooms()
    {
        hdnRoomName.Value = "";
        hdnNoofBeds.Value = "";
        foreach (GridViewRow row in GrdRoomDetails.Rows)
        {
            TextBox txtRoom = (TextBox)row.FindControl("txtRoomName");
            TextBox txtbNoOfbeds = (TextBox)row.FindControl("txtBeds");
            hdnRoomName.Value += txtRoom.ClientID.ToString() + "~";
            hdnNoofBeds.Value += txtbNoOfbeds.ClientID.ToString() + "~";
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
        btnSaveNOofBed.Style.Add("display",(GrdBedDetails.Rows.Count > 0 ? "block" : "none"));
    }
    private long FinishBed(List<RoomDetails> lstRoomDetails, long lResult)
    {
        lResult = RoomBL.SaveRoomMasterData(ddlMaster.SelectedValue, OrgID, ILocationID, lstRoomDetails, hdnIsSlotable.Value, hdnIsAnOT.Value);

        if (lResult != 0)
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
        
        return lResult;
    }

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "RoomMaster";
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
                                 where child.Domain == "RoomMaster" //orderby child .MetaDataID
                                 select child;
                ddlMaster.DataSource = childItems;
                ddlMaster.DataTextField = "DisplayText";
                ddlMaster.DataValueField = "Code";
                ddlMaster.DataBind();
                ddlMaster.Items.Insert(0, "--Select--");
                ddlMaster.Items[0].Value = "-1";


            }
            //}


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }

}
