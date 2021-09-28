using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Web.UI.HtmlControls;
using System.Collections;

public partial class CommonControls_RoomBookingDispaly : System.Web.UI.UserControl
{
    static List<RoomBookingDetails> lstRoomDisplay = new List<RoomBookingDetails>();
    List<FloorMaster> lstFloor = new List<FloorMaster>();
    Dictionary<string, int> dictRoomType = new Dictionary<string, int>();
    Dictionary<string, int> dictAvailInfo = new Dictionary<string, int>();
    Dictionary<string, int> dictBookedInfo = new Dictionary<string, int>();
    Dictionary<string, int> dictOccupiedInfo = new Dictionary<string, int>();
    long exPatientID = -1;

    int availableCount = 0;
    int occupiedCount = 0;
    int bookedCount = 0;

    public string ColoredPatient = "N";
    public int AvailableCount
    {
        get { return availableCount; }
        set { availableCount = value; }
    }

    public int OccupiedCount
    {
        get { return occupiedCount; }
        set { occupiedCount = value; }
    }

    public int BookedCount
    {
        get { return bookedCount; }
        set { bookedCount = value; }
    }

    public long ExPatientID
    {
        get { return exPatientID; }
        set { exPatientID = value; }
    }

    public List<RoomBookingDetails> LstRoomDisplay
    {
        get { return lstRoomDisplay; }
        set { lstRoomDisplay = value; }
    }

    public List<FloorMaster> LstFloor
    {
        get { return lstFloor; }
        set { lstFloor = value; }
    }

    int i1 = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void bindData()
    {
        hdnCurrentPatientBookedStatus1.Value = "N";
        var lstoor = (from floor in lstRoomDisplay
                      select new { floor.FloorID, floor.FloorName }).Distinct();
        gvIndentRoomType.DataSource = lstoor;
        gvIndentRoomType.DataBind();
    }

    protected void gvIndentRoomType_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                int FloorID = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "FloorID"));

                List<RoomBookingDetails> RoomsDatas = (from bed in LstRoomDisplay
                                                       where bed.FloorID == FloorID
                                                       select bed).ToList();
                if (RoomsDatas != null && RoomsDatas.Count > 0)
                {
                    DataList childGrid = (DataList)e.Row.FindControl("dlFloorMaster");
                    childGrid.DataSource = RoomsDatas;
                    childGrid.DataBind();
                }
                else
                {
                    HtmlTableCell tdEmptyList = (HtmlTableCell)e.Row.FindControl("tdEmptyList");
                    HtmlTableCell tdDataList = (HtmlTableCell)e.Row.FindControl("tdDataList");
                    HtmlTableCell tdFloor = (HtmlTableCell)e.Row.FindControl("tdFloor");
                    tdFloor.Visible = false;
                    tdEmptyList.Visible = false;
                    tdDataList.Visible = false;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Room Booking Details.", ex);
        }
    }
    protected void dlFloorMaster_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType != ListItemType.Header && e.Item.ItemType != ListItemType.Footer)
            {
                Label lblStatus = new Label();
                Label lblRoomType = new Label();
                LinkButton lnkBook = new LinkButton();
                LinkButton lnkOccupy = new LinkButton();
                LinkButton lnkCancel = new LinkButton();
                LinkButton lnkTransfer = new LinkButton();
                LinkButton lnkVaccate = new LinkButton();
                LinkButton lnkSchedule = new LinkButton();
                Label lblPatientID = new Label();
                Panel pnlDiv = new Panel();
                HtmlTableCell tdCover = new HtmlTableCell();
                string PatientName = "";
                string VisitID = "0";


                tdCover = (HtmlTableCell)e.Item.FindControl("tdCover");
                pnlDiv = (Panel)e.Item.FindControl("dvFloor");
                lblStatus = (Label)e.Item.FindControl("lblStatus");
                lblRoomType = (Label)e.Item.FindControl("lblRoomType");
                lblPatientID = (Label)e.Item.FindControl("lblPatientID");
                lnkBook = (LinkButton)e.Item.FindControl("lnkBook");
                lnkOccupy = (LinkButton)e.Item.FindControl("lnkOccupy");
                lnkCancel = (LinkButton)e.Item.FindControl("lnkCancel");
                lnkTransfer = (LinkButton)e.Item.FindControl("lnkTransfer");
                lnkVaccate = (LinkButton)e.Item.FindControl("lnkVaccate");
                lnkSchedule = (LinkButton)e.Item.FindControl("lnkSchedule");

                HiddenField hdnPrimaryConsultant = (HiddenField)e.Item.FindControl("hdnPrimaryConsultant");
                HiddenField hdnPatientInfo = (HiddenField)e.Item.FindControl("hdnPatientInfo");
                HiddenField hdnAllowSlotBooking = (HiddenField)e.Item.FindControl("hdnAllowSlotBooking");

                if (Request.QueryString["PID"] == LstRoomDisplay[i1].PatientID.ToString())
                {
                    tdCover.Style.Add("border-width", "2px");
                    tdCover.Style.Add("border-color", "red");
                    ColoredPatient = "Y";
                    hdnCurrentPatientBookedStatus1.Value = ColoredPatient;
                }

                if (lblPatientID.Text.Trim() != "")
                {
                    Label lblPatient = (Label)e.Item.FindControl("lblPatient");
                    HiddenField hdnVisitID = (HiddenField)e.Item.FindControl("hdnVisitID");
                    if (lblPatient.Text != "")
                    {
                        PatientName = lblPatient.Text;
                        lblPatient.Attributes.Add("onmouseover", "javascript:showPopUp('" + lblPatient.ClientID + "','" + hdnPrimaryConsultant.ClientID + "','" + hdnPatientInfo.ClientID + "');");
                        lblPatient.Attributes.Add("onmouseout", "javascript:closePopUp('" + lblPatient.ClientID + "');");
                    }
                    VisitID = hdnVisitID.Value;
                }
                else
                {
                    hdnPrimaryConsultant.Value = "";
                    hdnPatientInfo.Value = "";
                }

                string sVal = "javascript:return getValues('" + LstRoomDisplay[i1].BedID + "','" + LstRoomDisplay[i1].BookingID + "','Book','" + LstRoomDisplay[i1].PatientID + "','" + PatientName + "','" + VisitID + "','" + LstRoomDisplay[i1].AllowSlotBooking + "','" + LstRoomDisplay[i1].ClientID + "');";
                string sVal1 = "javascript:return getValues('" + LstRoomDisplay[i1].BedID + "','" + LstRoomDisplay[i1].BookingID + "','Occupy','" + LstRoomDisplay[i1].PatientID + "','" + PatientName + "','" + VisitID + "','" + LstRoomDisplay[i1].AllowSlotBooking + "','" + LstRoomDisplay[i1].ClientID + "');";

                lnkBook.Attributes.Add("onfocus", sVal);
                lnkOccupy.Attributes.Add("onfocus", sVal1);

                sVal = "javascript:return getValues('" + LstRoomDisplay[i1].BedID + "','" + LstRoomDisplay[i1].BookingID + "','Cancel','" + LstRoomDisplay[i1].PatientID + "','" + PatientName + "','" + VisitID + "','" + LstRoomDisplay[i1].AllowSlotBooking + "','" + LstRoomDisplay[i1].ClientID + "');";

                lnkCancel.Attributes.Add("onfocus", sVal);

                sVal = "javascript:return getValues('" + LstRoomDisplay[i1].BedID + "','" + LstRoomDisplay[i1].BookingID + "','Transfer','" + LstRoomDisplay[i1].PatientID + "','" + PatientName + "','" + VisitID + "','" + LstRoomDisplay[i1].AllowSlotBooking + "','" + LstRoomDisplay[i1].ClientID + "');";
                sVal1 = "javascript:return getValues('" + LstRoomDisplay[i1].BedID + "','" + LstRoomDisplay[i1].BookingID + "','Vacate','" + LstRoomDisplay[i1].PatientID + "','" + PatientName + "','" + VisitID + "','" + LstRoomDisplay[i1].AllowSlotBooking + "','" + LstRoomDisplay[i1].ClientID + "');";

                lnkTransfer.Attributes.Add("onfocus", sVal);
                lnkVaccate.Attributes.Add("onfocus", sVal1);

                if (Request.QueryString["IsOT"] == null)
                {
                    if (Request.QueryString["PID"] != null)
                    {
                        if ((lblStatus.Text == "") || (lblStatus.Text.ToLower().Trim() == "DISCHARGED"))
                        {
                            lnkBook.Visible = true;
                            lnkOccupy.Visible = true;

                        }
                        else if (lblStatus.Text.ToUpper() == "BOOKED")
                        {
                            tdCover.Style.Add("background-color", "#fcf2c3");
                            if (lblPatientID.Text == LstRoomDisplay[i1].PatientID.ToString())
                            {
                                lnkOccupy.Visible = true;
                                lnkCancel.Visible = true;
                            }

                        }
                        else if (lblStatus.Text.ToUpper() == "OCCUPIED")
                        {
                            tdCover.Style.Add("background-color", "#ffdbdc");
                            if (lblPatientID.Text == LstRoomDisplay[i1].PatientID.ToString())
                            {
                                lnkTransfer.Visible = true;
                                lnkVaccate.Visible = true;
                                lnkCancel.Visible = true;
                            }

                        }
                    }
                    else
                    {
                        if (lblStatus.Text.ToUpper() == "BOOKED")
                        {
                            tdCover.Style.Add("background-color", "#fcf2c3");
                        }
                        else if (lblStatus.Text.ToUpper() == "OCCUPIED")
                        {
                            tdCover.Style.Add("background-color", "#ffdbdc");

                        }
                        lnkBook.Visible = false;
                        lnkOccupy.Visible = false;
                        lnkCancel.Visible = false;
                        lnkTransfer.Visible = false;
                        lnkVaccate.Visible = false;
                        lnkSchedule.Visible = false;
                    }
                }
                else
                {
                    lnkBook.Visible = false;
                    lnkOccupy.Visible = false;
                    lnkCancel.Visible = false;
                    lnkTransfer.Visible = false;
                    lnkVaccate.Visible = false;
                    lnkSchedule.Visible = false;
                }
                if (hdnAllowSlotBooking.Value == "Y" && Request.QueryString["PID"] != null)
                {
                    lnkBook.Visible = true;
                }
                lblStatus.Visible = false;
                i1++;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvAdvancePaidDetails_RowDataBound", ex);
        }
    }

    public void loadRooms(List<RoomBookingDetails> lstRoomBookingDetails)
    {
        divBookedInfo.InnerHtml = string.Empty;
        divOccupiedInfo.InnerHtml = string.Empty;
        divAvailInfo.InnerHtml = string.Empty;
        var lstType = (from type in lstRoomBookingDetails
                       select new { type.RoomTypeID, type.RoomTypeName }).Distinct();

        List<RoomBookingDetails> iChild = (from c in lstRoomBookingDetails
                                           group c by new { c.PatientStatus, c.RoomTypeName, c.RoomTypeID } into g
                                           select new RoomBookingDetails
                                           {
                                               PatientStatus = g.Key.PatientStatus,
                                               RoomTypeName = g.Key.RoomTypeName,
                                               RoomTypeID = g.Key.RoomTypeID,
                                               RoomID = g.Sum(c => c.RoomID)
                                           }).Distinct().ToList();

        availableCount = 0;
        occupiedCount = 0;
        bookedCount = 0;

        string tblStart = "<table>";
        string tblEnd = "</table>";
        divAvailInfo.InnerHtml = tblStart;
        int pCount = 1;

        foreach (var item in lstType)
        {
            if (iChild.Exists(p => p.RoomTypeID == item.RoomTypeID && (p.PatientStatus.ToUpper() == "DISCHARGED" || p.PatientStatus == "")))
            {
                divAvailInfo.InnerHtml += "<tr><td>" + item.RoomTypeName.ToString() + "</td><td>" + iChild.Find(p => p.RoomTypeID == item.RoomTypeID && (p.PatientStatus.ToUpper() == "DISCHARGED" || p.PatientStatus == "")).RoomID.ToString() + "</td></tr>";
                availableCount += Convert.ToInt32(iChild.Find(p => p.RoomTypeID == item.RoomTypeID && (p.PatientStatus.ToUpper() == "DISCHARGED" || p.PatientStatus == "")).RoomID.ToString());
            }
            else
            {
                divAvailInfo.InnerHtml += "<tr><td>" + item.RoomTypeName.ToString() + "</td><td>" + "0" + "</td></tr>";

            }
        }
        divAvailInfo.InnerHtml += tblEnd;
        divBookedInfo.InnerHtml += tblStart;
        foreach (var item in lstType)
        {
            if (iChild.Exists(p => p.RoomTypeID == item.RoomTypeID && p.PatientStatus.ToUpper() == "BOOKED"))
            {
                divBookedInfo.InnerHtml += "<tr><td>" + item.RoomTypeName.ToString() + "</td><td>" + iChild.Find(p => p.RoomTypeID == item.RoomTypeID && p.PatientStatus.ToUpper() == "BOOKED").RoomID.ToString() + "</td></tr>";
                bookedCount += Convert.ToInt32(iChild.Find(p => p.RoomTypeID == item.RoomTypeID && p.PatientStatus.ToUpper() == "BOOKED").RoomID.ToString());
            }
            else
            {
                divBookedInfo.InnerHtml += "<tr><td>" + item.RoomTypeName.ToString() + "</td><td>" + "0" + "</td></tr>";
            }
        }
        divBookedInfo.InnerHtml += tblEnd;
        divOccupiedInfo.InnerHtml += tblStart;

        foreach (var item in lstType)
        {
            if (iChild.Exists(p => p.RoomTypeID == item.RoomTypeID && p.PatientStatus.ToUpper() == "OCCUPIED"))
            {
                divOccupiedInfo.InnerHtml += "<tr><td>" + item.RoomTypeName.ToString() + "</td><td>" + iChild.Find(p => p.RoomTypeID == item.RoomTypeID && p.PatientStatus.ToUpper() == "OCCUPIED").RoomID.ToString() + "</td></tr>";

                occupiedCount += Convert.ToInt32(iChild.Find(p => p.RoomTypeID == item.RoomTypeID && p.PatientStatus.ToUpper() == "OCCUPIED").RoomID.ToString());
            }
            else
            {
                divOccupiedInfo.InnerHtml += "<tr><td>" + item.RoomTypeName.ToString() + "</td><td>" + "0" + "</td></tr>";

            }
        }

        divOccupiedInfo.InnerHtml += tblEnd;

        lblAvailableCount.Text = availableCount.ToString();
        lblOccupiedCount.Text = occupiedCount.ToString();
        lblBookedCount.Text = bookedCount.ToString();
    }
}
