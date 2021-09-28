using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Drawing;
using System.Web.UI.HtmlControls;


public partial class Reports_RoomListRpt : BasePage
{
    #region Declaration
    int Available = 0, Occupied = 0, Booked = 0;   
   
    #endregion

    #region PageLoad
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            try
            {

                GetRoomList();
               
            }

            catch (System.Threading.ThreadAbortException tae)
            {
                string exp = tae.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while RoomListRpt.aspx Page Load", ex);
            }
        }



    }
    #endregion

    #region GetRoomList
    private void GetRoomList()
    {
        List<RoomBookingDetails> lstRoomDetails = new List<RoomBookingDetails>();
        new Report_BL(base.ContextInfo).GetRoomListRpt(OrgID, ILocationID, out lstRoomDetails);
        if (lstRoomDetails.Count > 0)
        {
            divPrintPC.Style.Add("display", "block");
            divTblCount.Style.Add("display", "block");
            divMsg.Style.Add("display", "none");
            trDate.Style.Add("display", "block");

            
            if (ddlRoomStatus.SelectedItem.Text == "All")
            {
                lblDate.Text = "Room Status On : " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy  hh:mm tt");
                gvRoomListReport.DataSource = lstRoomDetails;
                gvRoomListReport.DataBind();

                lblAvailableCount.Text = "Available" + " ( " + Available + " ) ";
                lblOccupiedCount.Text = "Occupied" + " ( " + Occupied + " ) ";
                lblBookedCount.Text = "Booked" + " ( " + Booked + " ) ";
            }
            else
            {
                var RoomListDtls = from res in lstRoomDetails
                                   where res.RoomStatus == ddlRoomStatus.SelectedItem.Text
                                   select res;

                if (RoomListDtls.Count() > 0)
                {
                    divPrintPC.Style.Add("display", "block");

                    divMsg.Style.Add("display", "none");
                    trDate.Style.Add("display", "block");
                    lblDate.Text = "Room Status On : " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy  hh:mm tt");
                    gvRoomListReport.DataSource = RoomListDtls;
                    gvRoomListReport.DataBind();
                }
                else
                {
                    gvRoomListReport.DataSource = null;
                    gvRoomListReport.DataBind();

                    divPrintPC.Style.Add("display", "none");
                    divMsg.Style.Add("display", "block");
                    trDate.Style.Add("display", "none");

                }

               
            }
           
        }
        else
        {
            gvRoomListReport.DataSource = null;
            gvRoomListReport.DataBind();
            divPrintPC.Style.Add("display", "none");
            divMsg.Style.Add("display", "block");
            trDate.Style.Add("display", "none");
            divTblCount.Style.Add("display", "none");
        }
    }
    #endregion

    #region Back Link
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }
    #endregion

    #region RowdataboundEvent
    protected void gvRoomListReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblRoomStatus = (Label)e.Row.FindControl("lblRoomStatus");
                if (lblRoomStatus.Text == "Occupied")
                {
                    e.Row.BackColor = System.Drawing.Color.LightPink;
                    Occupied += 1;

                }
                else if (lblRoomStatus.Text == "Booked")
                {
                    e.Row.BackColor = System.Drawing.Color.PapayaWhip;
                    Booked += 1;

                }
                else
                {
                    e.Row.BackColor = System.Drawing.Color.PaleGreen;
                    Available += 1;

                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while RoomListRpt.aspx gvRoomListReport_RowDataBound", ex);
        }
    }
    #endregion

    #region GetReport
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {

            GetRoomList();

        }

        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while RoomListRpt.aspx Page Load", ex);
        }
    }
    #endregion
}
