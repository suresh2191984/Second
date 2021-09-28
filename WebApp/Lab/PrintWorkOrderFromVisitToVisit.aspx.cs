using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;

public partial class Lab_PrintWorkOrderFromVisitToVisit : BasePage
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
    string pHistoryMode = string.Empty;
    long pLoginId = 0;
    string pPageMode = string.Empty;
    int pLoggedLocationId = 0;
    string investigationName = string.Empty;
    List<WorkOrder> lstWorkOrder = new List<WorkOrder>();
    List<WorkOrder> lstWork = new List<WorkOrder>();
    Investigation_BL investigationBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        investigationBL = new Investigation_BL(base.ContextInfo);
        try
        {
            fromVisit =  Convert.ToString(Request.QueryString["fvid"]);
            toVisit =  Convert.ToString(Request.QueryString["tvid"]);
            fromDate = Convert.ToString(Request.QueryString["fdate"]);
            toDate = Convert.ToString(Request.QueryString["tdate"]);
            Location = Convert.ToString(Request.QueryString["loc"]);
            sourceName = Convert.ToString(Request.QueryString["src"]);
            visitType = Convert.ToString(Request.QueryString["vtype"]);
            wardNo = Convert.ToString(Request.QueryString["ward"]);
            pHistoryMode = Convert.ToString(Request.QueryString["historymode"]);
            pPageMode = Convert.ToString(Request.QueryString["pagemode"]);
            pLoginId = LID;
            returnCode = investigationBL.GetWorkOrderFromVisitToVisit(fromVisit, toVisit,fromDate,toDate,Location,sourceName,Convert.ToInt32(visitType),wardNo,investigationName, OrgID,Convert.ToInt32(pHistoryMode),  pLoginId,  pPageMode,  pLoggedLocationId,  out lstWorkOrder);
            lblDateRange.Text = " " + fromDate + " - " + toDate;
           
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

                GateWay gateWay = new GateWay(base.ContextInfo);
                List<Config> lstConfig = new List<Config>();
                returnCode = gateWay.GetConfigDetails("WorkOrderFooter", OrgID, out lstConfig);
                if (lstConfig.Count > 0 && !String.IsNullOrEmpty(lstConfig[0].ConfigValue))
                    lblFooter.Text = lstConfig[0].ConfigValue;
                else
                    lblFooter.Text = string.Empty;
            }
            else
            { //grdResult.Visible = false;
            grdResult.DataSource = null;
            grdResult.DataBind();
            }

        }
        catch (Exception ex)
        {

        }
    }
    protected void grdResult_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        //e.Row.Cells[2].ColumnSpan = 4;
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            WorkOrder Master = (WorkOrder)e.Item.DataItem;

            var childItems = from lst in lstWorkOrder
                             where lst.StrVisitID == Master.StrVisitID
                             select lst;

            GridView childGrid = (GridView)e.Item.FindControl("gvDescription");
            childGrid.DataSource = childItems;
            childGrid.DataBind();




        }
    }

}
