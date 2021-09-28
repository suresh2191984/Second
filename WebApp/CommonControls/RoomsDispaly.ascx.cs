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

public partial class CommonControls_RoomsDispaly : BaseControl
{
    static List<RoomBookingDetails> lstRoomDisplay = new List<RoomBookingDetails>();
    List<FloorMaster> lstFloor = new List<FloorMaster>();
    Dictionary<string, int> dictRoomType = new Dictionary<string, int>();
    Dictionary<string, int> dictAvailInfo = new Dictionary<string, int>();
    Dictionary<string, int> dictBookedInfo = new Dictionary<string, int>();
    Dictionary<string, int> dictOccupiedInfo= new Dictionary<string, int>();
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

    int i1=0;
    protected void Page_Load(object sender, EventArgs e)
    {        
       
    }

    public void bindData()
    {
        getRoomType();
        //getFilters();
        hdnCurrentPatientBookedStatus1.Value = "N";
        gvIndentRoomType.DataSource = lstFloor;
        gvIndentRoomType.DataBind();
         

    }

    

    public void getRoomType()
    {
       var arrRoomType = (from list in lstRoomDisplay
                          select list.RoomTypeName).Distinct();
       foreach (var item in arrRoomType)
       {
           dictAvailInfo.Add(item.ToString(), 0);
           dictBookedInfo.Add(item.ToString(), 0);
           dictOccupiedInfo.Add(item.ToString(), 0);
       }
    }

    protected void getRoomStats()
    {
        divBookedInfo.InnerHtml = string.Empty;
        divOccupiedInfo.InnerHtml = string.Empty;
        divAvailInfo.InnerHtml=string.Empty;

        lblOccupiedCount.Text = occupiedCount.ToString();
        lblBookedCount.Text = bookedCount.ToString();
        lblAvailableCount.Text = availableCount.ToString();

        string tblStart = "<table>";
        string tblEnd = "</table>";
        divAvailInfo.InnerHtml = tblStart;
        foreach (KeyValuePair<string,int> item in dictAvailInfo)
        {
            divAvailInfo.InnerHtml += "<tr><td>" + item.Key.ToString() + "</td><td>" + item.Value.ToString() + "</td></tr>";
        }
        divAvailInfo.InnerHtml += tblEnd;
        divBookedInfo.InnerHtml += tblStart;
        foreach (KeyValuePair<string, int> item in dictBookedInfo)
        {
            divBookedInfo.InnerHtml += "<tr><td>" + item.Key.ToString() + "</td><td>" + item.Value.ToString() + "</td></tr>";
        }
        divBookedInfo.InnerHtml += tblEnd;
        divOccupiedInfo.InnerHtml += tblStart;
        foreach (KeyValuePair<string, int> item in dictOccupiedInfo)
        {
            divOccupiedInfo.InnerHtml += "<tr><td>" + item.Key.ToString() + "</td><td>" + item.Value.ToString() + "</td></tr>";
        }
        divOccupiedInfo.InnerHtml += tblEnd;
    }

    protected void gvIndentRoomType_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                FloorMaster flm = (FloorMaster)e.Row.DataItem;

                List<RoomBookingDetails> RoomsDatas = (from bed in LstRoomDisplay
                                                       where bed.FloorID == flm.FloorID
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
                    hdnPrimaryConsultant.Value="";
                    hdnPatientInfo.Value="";
                }

                string sVal = "javascript:getValues('" + LstRoomDisplay[i1].BedID + "','" + LstRoomDisplay[i1].BookingID + "','Book','" + LstRoomDisplay[i1].PatientID + "','" + PatientName + "','" + VisitID + "','" + LstRoomDisplay[i1].AllowSlotBooking + "');";
                string sVal1 = "javascript:getValues('" + LstRoomDisplay[i1].BedID + "','" + LstRoomDisplay[i1].BookingID + "','Occupy','" + LstRoomDisplay[i1].PatientID + "','" + PatientName + "','" + VisitID + "','" + LstRoomDisplay[i1].AllowSlotBooking + "');";
                
                lnkBook.Attributes.Add("onfocus", sVal);
                lnkOccupy.Attributes.Add("onfocus", sVal1);

                sVal = "javascript:getValues('" + LstRoomDisplay[i1].BedID + "','" + LstRoomDisplay[i1].BookingID + "','Cancel','" + LstRoomDisplay[i1].PatientID + "','" + PatientName + "','" + VisitID + "','" + LstRoomDisplay[i1].AllowSlotBooking + "');";
                
                lnkCancel.Attributes.Add("onfocus", sVal);

                sVal = "javascript:getValues('" + LstRoomDisplay[i1].BedID + "','" + LstRoomDisplay[i1].BookingID + "','Transfer','" + LstRoomDisplay[i1].PatientID + "','" + PatientName + "','" + VisitID + "','" + LstRoomDisplay[i1].AllowSlotBooking + "');";
                sVal1 = "javascript:getValues('" + LstRoomDisplay[i1].BedID + "','" + LstRoomDisplay[i1].BookingID + "','Vacate','" + LstRoomDisplay[i1].PatientID + "','" + PatientName + "','" + VisitID + "','" + LstRoomDisplay[i1].AllowSlotBooking + "');";
                
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
                        else
                        {
                            
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
                                               RoomID = g.Count()
                                           }).Distinct().ToList();

        lblAvailableCount.Text = lstRoomBookingDetails.FindAll(p => p.PatientStatus.ToUpper() == "DISCHARGED" || p.PatientStatus.ToUpper() == "").Count().ToString();
        lblOccupiedCount.Text = lstRoomBookingDetails.FindAll(p => p.PatientStatus.ToUpper() == "OCCUPIED").Count().ToString();
        lblBookedCount.Text = lstRoomBookingDetails.FindAll(p => p.PatientStatus.ToUpper() == "BOOKED").Count().ToString();

        string tblStart = "<table>";
        string tblEnd = "</table>";
        divAvailInfo.InnerHtml = tblStart;
        int pCount = 1;

        foreach (var item in lstType)
        {
            if (iChild.Exists(p => p.RoomTypeID == item.RoomTypeID && (p.PatientStatus.ToUpper() == "DISCHARGED" || p.PatientStatus == "")))
            {
                divAvailInfo.InnerHtml += "<tr><td>" + item.RoomTypeName.ToString() + "</td><td>" + iChild.Find(p => p.RoomTypeID == item.RoomTypeID && (p.PatientStatus.ToUpper() == "DISCHARGED" || p.PatientStatus == "")).RoomID.ToString() + "</td></tr>";
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
            }
            else
            {
                divOccupiedInfo.InnerHtml += "<tr><td>" + item.RoomTypeName.ToString() + "</td><td>" + "0" + "</td></tr>";

            }
        }

        divOccupiedInfo.InnerHtml += tblEnd;



    }
}
