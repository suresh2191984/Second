using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class Lab_WorkOrderFromVisitToVisit : BasePage
{
    long vid = 0;
    long returnCode = -1;
    string fromVisit = "";
    string toVisit = "";
           string fromDate = string.Empty;
           string toDate = string.Empty;
           string Location = string.Empty;
           string sourceName = string.Empty;
           string visitType = string.Empty;
           string wardNo = string.Empty;
           string investigationName = string.Empty;
           string pHistoryMode = string.Empty;
           string pPageMode= string.Empty;
    List<WorkOrder> lstWorkOrder = new List<WorkOrder>();
    List<WorkOrder> lstWork = new List<WorkOrder>();
    Investigation_BL investigationBL;
    List<OrganizationAddress> lAddress = new List<OrganizationAddress>();
    protected void Page_Load(object sender, EventArgs e)
    {
        investigationBL = new Investigation_BL(base.ContextInfo);
        hdnOrgID.Value = OrgID.ToString();
        if (!IsPostBack)
        {
            returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lAddress);
            ddlocation.DataSource = lAddress;
            ddlocation.DataTextField = "City";
            ddlocation.DataValueField = "AddressID";
            //ddlocation.SelectedValue = ILocationID.ToString();
            ddlocation.DataBind();
            ddlocation.Items.Insert(0, "SELECT");
            ddlocation.Items[0].Value = "-1";

            Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
            List<InvClientMaster> lstSourceName = new List<InvClientMaster>();
            returnCode = objPatientBL.GetInvClientMaster(OrgID, "", out lstSourceName);
            if (lstSourceName.Count > 0)
            {
                ddClientName.DataSource = lstSourceName;
                ddClientName.DataTextField = "ClientName";
                ddClientName.DataValueField = "ClientID";
                ddClientName.DataBind();
                ddClientName.Items.Insert(0, "SELECT");
                ddClientName.Items[0].Value = "-1";
            }
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        bindWorkOrder();
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //e.Row.Cells[2].ColumnSpan = 4;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            WorkOrder Master = (WorkOrder)e.Row.DataItem;

            var childItems = from lst in lstWorkOrder
                             where lst.StrVisitID == Master.StrVisitID
                             select lst;

            GridView childGrid = (GridView)e.Row.FindControl("gvDescription");
            childGrid.DataSource = childItems;
            childGrid.DataBind();




        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            bindWorkOrder();
        }
      
    }

    public void bindWorkOrder()
    {
        try
        {
            if (txtFromVisit.Text != "" && txtToVisit.Text != "")
            {
                fromVisit = txtFromVisit.Text;
                toVisit = txtToVisit.Text;
            }
            else
            {
                fromVisit = "";
                toVisit = "";
            }

            if (txtFrom.Text != "" && txtTo.Text != "")
            {
                if (txtFrom.Text == txtTo.Text)
                {
                    fromDate = Convert.ToString(Convert.ToDateTime(txtFrom.Text));
                    toDate = Convert.ToString(Convert.ToDateTime(txtFrom.Text));  

                    //fromDate = txtFrom.Text; ;
                    //toDate = Convert.ToDateTime(fromDate).AddDays(1).ToString("dd/MM/yyyy");
                }
                else
                {
                    fromDate = Convert.ToString(Convert.ToDateTime(txtFrom.Text));
                    toDate = Convert.ToString(Convert.ToDateTime(txtTo.Text));
                    //fromDate = txtFrom.Text;
                    //toDate = txtTo.Text;
                }
            }
            else
            {
                fromDate = "";
                toDate = "";
            }


            if (ddlocation.SelectedValue != "-1")
            {
                Location = ddlocation.SelectedValue.ToString();
            }
            else
            {
                Location = "-1";
            }
            if (ddClientName.SelectedValue != "-1")
            {
                sourceName = ddClientName.SelectedValue;
            }
            else
            {
                sourceName = "";
            }
            visitType = ddVisitType.SelectedValue;
            if (txtWardName.Text != "")
            {
                wardNo = txtWardName.Text;
            }
            else { wardNo = "-1"; }

            if (txtTestName.Text != "")
            {
                investigationName = txtTestName.Text.ToString().Trim();
            }
            else { investigationName = ""; }

            pHistoryMode = ddlMode.SelectedValue;
            pPageMode = "View";

            returnCode = investigationBL.GetWorkOrderFromVisitToVisit(fromVisit, toVisit, fromDate, toDate, Location, sourceName, Convert.ToInt32(visitType), wardNo, investigationName, OrgID,Convert.ToInt32(pHistoryMode),LID,  pPageMode,  ILocationID,  out lstWorkOrder);
            lstWork = (from lst in lstWorkOrder
                       group lst by new
                       {
                           lst.CollectedOn,
                           lst.PatientNumber,
                           lst.StrVisitID,
                           lst.PatientName,
                           lst.Age,
                           lst.Sex,
                           lst.ReferingPhysicianName
                       } into g
                       select new WorkOrder
                       {
                           CollectedOn = g.Key.CollectedOn,
                           PatientNumber = g.Key.PatientNumber,
                           StrVisitID = g.Key.StrVisitID,
                           PatientName = g.Key.PatientName,
                           Age = g.Key.Age,
                           Sex = g.Key.Sex,
                           ReferingPhysicianName = g.Key.ReferingPhysicianName,

                       }
                    ).Distinct().ToList();
            if (lstWorkOrder.Count > 0)
            {

                grdResult.DataSource = lstWork;
                grdResult.DataBind();
                tabPrintButton.Style.Add("display", "block");
                hypLnkPrint.NavigateUrl = "PrintWorkOrderFromVisitToVisit.aspx?fvid=" + fromVisit + "&tvid=" + toVisit + "&fdate=" + fromDate + "&tdate=" + toDate + "&loc=" + Location + "&src=" + sourceName + "&vtype=" + visitType + "&ward=" + wardNo + "&pagemode=Print" + "&historymode=" + pHistoryMode;
            }
            else
            { //grdResult.Visible = false;
                grdResult.DataSource = null;
                grdResult.DataBind();
                tabPrintButton.Style.Add("display", "none");
            }

            //    TableRow rowh = new TableRow();
            //    TableCell cell1h = new TableCell();
            //    TableCell cell2h = new TableCell();
            //    TableCell cell3h = new TableCell();

            //    cell1h.BorderWidth = Unit.Pixel(1);
            //    cell2h.BorderWidth = Unit.Pixel(1);
            //    cell3h.BorderWidth = Unit.Pixel(1);


            //    cell1h.Attributes.Add("align", "left");
            //    cell1h.Text = "Bill No/PID/VisitID";
            //    cell2h.Attributes.Add("align", "left");
            //    cell2h.Text = "Name/Age/Sex/Ref. Doctor";
            //    cell3h.Attributes.Add("align", "left");
            //    cell3h.Text = "Test Description";

            //    rowh.Cells.Add(cell1h);
            //    rowh.Cells.Add(cell2h);
            //    rowh.Cells.Add(cell3h);

            //    rowh.Font.Bold = true;

            //    rowh.Style.Add("font-size", "12px");
            //    listTab.Rows.Add(rowh);
            //    foreach (WorkOrder objWO in lstWorkOrder)
            //    {
            //        TableRow row = new TableRow();
            //        TableCell cell1 = new TableCell();
            //        TableCell cell2 = new TableCell();
            //        TableCell cell3 = new TableCell();
            //        cell1.BorderWidth = Unit.Pixel(1);
            //        cell1.Width = Unit.Percentage(15);
            //        cell2.BorderWidth = Unit.Pixel(1);
            //        cell2.Width = Unit.Percentage(30);
            //        cell3.BorderWidth = Unit.Pixel(1);
            //        cell3.Width = Unit.Percentage(55);

            //        cell1.Attributes.Add("align", "left");
            //        if (objWO.ExternalVisitID > 0)
            //        {
            //            cell1.Text = objWO.CollectedOn + "<br>" + objWO.PatientNumber + "<br>" + objWO.ExternalVisitID;
            //            //cell1.Text = objWO.BillNumber.ToString() + "<br>" + objWO.CollectedOn + "<br>" + objWO.PatientNumber + "<br>" + objWO.ExternalVisitID;
            //        }
            //        else
            //        {
            //            cell1.Text = objWO.CollectedOn + "<br>" + objWO.PatientNumber + "<br>" + objWO.VisitID;
            //            //cell1.Text = objWO.BillNumber.ToString() + "<br>" + objWO.CollectedOn + "<br>" + objWO.PatientNumber + "<br>" + objWO.VisitID;
            //        }
            //        //cell1.Text = objWO.BillNumber.ToString() + "<br>" + objWO.CollectedOn + "<br>" + objWO.PatientNumber + "<br>" + objWO.PatientNumber;

            //        cell2.Attributes.Add("align", "left");
            //        cell2.Text = objWO.PatientName + "<br>" + objWO.Age + ", " + objWO.Sex + "<br>" + objWO.ReferingPhysicianName;
            //        cell3.Attributes.Add("align", "left");
            //        cell3.Text = objWO.Description;

            //        row.Cells.Add(cell1);
            //        row.Cells.Add(cell2);
            //        row.Cells.Add(cell3);
            //        row.Style.Add("font-size", "12px");
            //        row.Font.Bold = false;
            //        listTab.Rows.Add(row);

            //    }
            //    lblStatus.Visible = false;
            //    tabPrintButton.Style.Add("display", "block");
            //    hypLnkPrint.NavigateUrl = "PrintWorkOrderFromVisitToVisit.aspx?fvid=" + fromVisit + "&tvid=" + toVisit + "&fdate=" + fromDate + "&tdate=" + toDate + "&loc=" + Location + "&src=" + sourceName + "&vtype=" + visitType + "&ward=" + wardNo;
            //}
            //else
            //{
            //    tabPrintButton.Style.Add("display", "none");
            //    lblStatus.Visible = true;
            //}
        }

        catch (Exception ex)
        {

        }
    }
}
