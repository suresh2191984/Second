using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Data;
using System.Web.Script.Serialization;
using Attune.Podium.Common;
using System.Xml;
using System.Xml.Linq;
using System.IO;
using AjaxControlToolkit;
using System.Web.UI.HtmlControls;
using System.Text;

public partial class Admin_RoundManagement : BasePage
{

    DataTable Dt = new DataTable();
    int i = 0;
    int count = 0;
    bool flag = false;
    bool flag1 = false;
    bool flag2 = false;
    DayOfWeek dow;
    int currentDay;
    DateTime PrevOccur = new DateTime(1900, 01, 01);
    public string Save_Message = Resources.AppMessages.Save_Message;

    protected void Page_Load(object sender, EventArgs e)
    {
        hdnOrgID.Value = OrgID.ToString();
        
        if (!IsPostBack)
        {
            BindGrid();
            DateTime dt = new DateTime();
            //dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            string Time = dt.ToString("hh:mm:tt");
            string[] SplitTime = Time.Split(':');
            txtFromTime1.Text = SplitTime[0];
            txtFromTime2.Text = SplitTime[1];
            ddlFromTime.SelectedValue = SplitTime[2].ToString();

            txtToTime1.Text = SplitTime[0];
            txtToTime2.Text = SplitTime[1];
            ddlToTime.SelectedValue = SplitTime[2].ToString();

            AutoCompleteExtenderRoundName.ContextKey = "Round";
            AutoCompleteExtenderClientCorp.ContextKey = "CLI";
            ScriptManager1.RegisterPostBackControl(this.ImageBtnExport);
        }
        if (!Page.IsPostBack)
        {
            hdnDate.Value = OrgTimeZone;
        }
    }

    private void BindGrid()
    {
        Dt.Columns.Add("ClientName");
        Dt.Columns.Add("EstimatedTime");
        Dt.Columns.Add("ClientId");
        Dt.Columns.Add("ID");
        Dt.Columns.Add("RoundID");
        Dt.Columns.Add("Sequence No");
        Dt.Columns.Add("Delete");
        Dt.Rows.Add();

        
        gvRound.DataSource = Dt;
        gvRound.DataBind();
        gvRound.Rows[0].Visible = false;
        gvRound.Style.Add("visibility", "hidden");
        
    }

    public List<RecurrenceAbsolute> selectedWeek()
    {
        RecurrenceAbsolute recurrenceAbsolute = new RecurrenceAbsolute();
        List<RecurrenceAbsolute> lstRAbsolute = new List<RecurrenceAbsolute>();

        dow = Convert.ToDateTime(hdnDate.Value).DayOfWeek;
        string[] dayNumber = null;

        try
        {
               dayNumber = new string[chkDays.Items.Count];

                for (int i = 0; i < chkDays.Items.Count; i++)
                {
                    if (chkDays.Items[i].Selected)
                    {
                        flag = true;
                        switch (i)
                        {
                            case 0:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Sunday).ToString();
                                break;
                            case 1:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Monday).ToString();
                                break;
                            case 2:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Tuesday).ToString();
                                break;
                            case 3:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Wednesday).ToString();
                                break;
                            case 4:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Thursday).ToString();
                                break;
                            case 5:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Friday).ToString();
                                break;
                            case 6:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Saturday).ToString();
                                break;
                        }
                    }
                }


                if (flag)
                {
                    for (i = 0; i < dayNumber.Length; i++)
                    {

                        if (dayNumber[i] != null)
                        {
                            if (count == 0)
                            {
                                recurrenceAbsolute.Value = dayNumber[i];
                                count++;
                            }
                            else
                            {
                                recurrenceAbsolute.Value = recurrenceAbsolute.Value + "," + dayNumber[i];
                            }
                        }
                    }
                }
                else
                {
                    currentDay = Convert.ToInt32(dow);
                    recurrenceAbsolute.Value = Convert.ToString(currentDay);
                }

            recurrenceAbsolute.Unit = Convert.ToString(TaskHelper.unit.WD);
            lstRAbsolute.Add(recurrenceAbsolute);
           
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while executing selected week", ex);
        }

        return lstRAbsolute;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
                long returncode = -1;
                long roundId = -1;
            long roundId1 = -1;
                //List<RoundMaster> lstRoundMaster = new List<RoundMaster>();
                List<RoundMasterAttributes> lstRoundAttributes = new List<RoundMasterAttributes>();
                Master_BL Master_BL = new Master_BL(base.ContextInfo);

                string roundName = txtRoundName.Text;
                string isActive = chkIsActive.Checked.ToString();
                string startLocation = txtStartLocation.Text;
                string endLocation = txtEndLocation.Text;
                DateTime createdAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                string logisticEmployee = txtLogistics.Text;
            string roundSheetTime = (ddlTiming.SelectedItem.Value+'~'+ddlHrs.SelectedItem.Value);

                string ft1 = txtFromTime1.Text;
                string ft2 = txtFromTime2.Text;
                string ft3 = ddlFromTime.Text;

                string tt1 = txtToTime1.Text;
                string tt2 = txtToTime2.Text;
                string tt3 = ddlToTime.Text;

                string startTime = ft1 + ":" + ft2 + ":" + "00" + " " + ft3;
                string endTime = tt1 + ":" + tt2 + ":" + "00" + " " + tt3;

                //objRoundMaster.RoundRepeatDays = chkDays;
                //objRoundMaster.LogisticEmployeeId=

            string value = "";
            for (int i = 0; i <= chkDays.Items.Count - 1; i++)
            {
                if (chkDays.Items[i].Selected)
                {
                    if (value == "")
                    {
                        value = chkDays.Items[i].Value;
                    }
                    else
                    {
                        value += "," + chkDays.Items[i].Value;
                    }
                }
            }
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string strLstPatientInvSample = hdnRoundValues.Value;
                lstRoundAttributes = serializer.Deserialize<List<RoundMasterAttributes>>(strLstPatientInvSample);

            if (hdnRoundId.Value!="0")
            {
                roundId = Convert.ToInt64(hdnRoundId.Value);
                flag1 = true;
                flag2 = true;

            }
            else
            {
                roundId = -1;
                flag1 = false;
            }

            returncode = Master_BL.SaveRoundManagement(roundName, isActive, startLocation, endLocation, createdAt, startTime, endTime, logisticEmployee, roundSheetTime,value, lstRoundAttributes, OrgID,roundId,out roundId1);

            if (flag2 == true)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('" + Save_Message + "');", true);
                clear();
            }

            if (flag1!=true)
            {
                int stid = 0;
                int rtid = 0;
                List<RecurrenceRelative> lstRR = new List<RecurrenceRelative>();
                List<ScheduleTemplate> lstSchedulreTemp = new List<ScheduleTemplate>();
                List<RecurrenceAbsolute> lstRAbsolute = new List<RecurrenceAbsolute>();
                List<SchedulableResource> lstResource = new List<SchedulableResource>();
                List<Schedules> lstSchedules = new List<Schedules>();

                int RecurrenceID = 0;
                Int32.TryParse(hdnRecurrenceID.Value, out RecurrenceID);

                RecurrenceRelative RRelative = new RecurrenceRelative();
                RRelative.Type = Convert.ToString(TaskHelper.RelativeType.W);
                lstRAbsolute = selectedWeek();
                RRelative.Interval = 1;
                lstRR.Add(RRelative);

                ScheduleTemplate scheduleTemp = new ScheduleTemplate();
                DateTime sTime = Convert.ToDateTime(startTime);
                scheduleTemp.StartTime = TimeSpan.Parse(sTime.ToShortTimeString());
                DateTime eTime = Convert.ToDateTime(endTime);
                scheduleTemp.EndTime = TimeSpan.Parse(eTime.ToShortTimeString());
                scheduleTemp.SlotDuration =Convert.ToInt32(ddlTiming.SelectedValue);
                lstSchedulreTemp.Add(scheduleTemp);

                SchedulableResource sResource = new SchedulableResource();
                sResource.OrgID = OrgID;
                sResource.ResourceID = Convert.ToInt64(roundId1);
                sResource.ResourceType = "RND";
                sResource.CreatedBy = LID;
                sResource.OrgAddressID = -1;
                lstResource.Add(sResource);

                Schedules schedule = new Schedules();
                schedule.NextOccurance = Convert.ToDateTime(hdnDate.Value);
                schedule.Status = "A";
                schedule.PreviousOccurance = PrevOccur;
                lstSchedules.Add(schedule);

                long returnCode = -1;
                Schedule_BL ScheduleBL = new Schedule_BL(base.ContextInfo);
                returnCode = ScheduleBL.InsertSchedules(lstRAbsolute, lstRR, lstSchedulreTemp, lstResource, lstSchedules, stid, rtid, RecurrenceID);

                if (returnCode == 0)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('" + Save_Message + "');", true);
                    clear();
                }

            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void gvRound_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        try
        {

            if (e.Row.RowType == DataControlRowType.Header)
            {
                //e.Row.Cells[1].Visible = false;
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[3].Visible = false;
                e.Row.Cells[4].Visible = false;
            }
        }
        catch (Exception ex)
        {
        }
    }

    public void clear()
    {
        txtRoundName.Text = "";
        chkIsActive.Checked = false;
        txtStartLocation.Text = "";
        txtEndLocation.Text = "";
        txtLogistics.Text = "";
        //gvRound.DataSource = null;
        //gvRound.DataBind();
       
        hdnClientId.Value="";
        hdnID.Value = "";
        hdnRoundValues.Value = "";
        chkDays.ClearSelection();
        //ddlTiming.SelectedItem.Value = "0";
        //ddlHrs.SelectedItem.Value = "0";

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        clear();
    }
    public void ImageBtnExport_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //LoadExporttoExcel();
            DateTime Date = new DateTime();
            Date = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            string prefixText = txtRoundName.Text;
            List<RoundMaster> lstRound = new List<RoundMaster>();
            ContextInfo.AdditionalInfo = "Y";
            int pOrgID = Convert.ToInt32(hdnOrgID.Value);
            string searchType = string.Empty;
            Master_BL Master_BL = new Master_BL(base.ContextInfo);
            Master_BL.GetRoundNameList("", OrgID, "", out lstRound);
            if (lstRound.Count > 0)
            {
                //DataTable table = ConvertListToDataTable(lstRound);
                gvRoundmaster.AllowPaging = false;
                gvRoundmaster.DataSource = lstRound;
                gvRoundmaster.DataBind();


                if (gvRoundmaster.Rows.Count > 0)
                {
                    DataTable dt = new DataTable();
                    Response.ClearContent();
                    gvRoundmaster.AllowPaging = false;
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    if (gvRoundmaster.HeaderRow != null)
                    {

                        for (int i = 0; i < gvRoundmaster.HeaderRow.Cells.Count; i++)
                        {
                            dt.Columns.Add(gvRoundmaster.HeaderRow.Cells[i].Text);
                        }
                    }

                    //  add each of the data rows to the table
                    foreach (GridViewRow row in gvRoundmaster.Rows)
                    {
                        DataRow dr;
                        dr = dt.NewRow();

                        for (int i = 0; i < row.Cells.Count; i++)
                        {
                            dr[i] = row.Cells[i].Text.Replace("&nbsp;", "");
                            dr[i] = row.Cells[i].Text.Replace("&amp;", "&");
                        }
                        dt.Rows.Add(dr);
                    }
                    DataSet ds = new DataSet();
                    dt.Columns.Remove("S.No.");
                    dt.Columns.Remove("RoundRepeatDays");
                    dt.Columns.Remove("Type");
                    dt.Columns.Remove("RoundSheetTime");
                    dt.Columns.Remove("Sequenceno");
                    dt.Columns.Remove("ClientId");
                    string rptDate = "Round Management_" + Date + ".csv";
                    Response.ContentType = "Application/x-msexcel";
                    Response.AddHeader("content-disposition", "attachment;filename=" + rptDate);
                    Response.Write(ExportToCSVFile(dt));
                    Response.End();

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('There is No Datas to Export');", true);
                }
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while ImageBtnExport_Click in RoundManagement.aspx", ex);
        }
    }
    private string ExportToCSVFile(DataTable dtTable)
    {
        StringBuilder sbldr = new StringBuilder();
        if (dtTable.Columns.Count != 0)
        {
            foreach (DataColumn col in dtTable.Columns)
            {
                sbldr.Append(col.ColumnName + ',');
            }
            sbldr.Append("\r\n");
            foreach (DataRow row in dtTable.Rows)
            {
                foreach (DataColumn column in dtTable.Columns)
                {
                    sbldr.Append(row[column].ToString() + ',');
                }
                sbldr.Append("\r\n");
            }
        }
        return sbldr.ToString();
    }
    public void LoadExporttoExcel()
    {
        try
        {
            long returnCode = -1;
            string prefixText = txtRoundName.Text;
            List<RoundMaster> lstRound = new List<RoundMaster>();
            ContextInfo.AdditionalInfo = "Y";
            int pOrgID = Convert.ToInt32(hdnOrgID.Value);
            string searchType = string.Empty;
            Master_BL Master_BL = new Master_BL(base.ContextInfo);
            Master_BL.GetRoundNameList("", OrgID, "", out lstRound);
            //returnCode = Master_BL.GetRoundNameList(prefixText, pOrgID, searchType, out lstRound);
            if (lstRound.Count > 0)
            {
                //DataTable table = ConvertListToDataTable(lstRound);
                gvRoundmaster.AllowPaging = false;
                gvRoundmaster.DataSource = lstRound;
                gvRoundmaster.DataBind();
                ExportToExcel();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    //static DataTable ConvertListToDataTable(List<RoundMaster> lstRound)
    //{
    //    DataTable dt = new DataTable();
    //    DataColumn dcol1 = new DataColumn("RoundName");
    //    DataColumn dcol2 = new DataColumn("EndTime");
    //    DataColumn dcol3 = new DataColumn("LogisticEmployee");
    //    DataColumn dcol4 = new DataColumn("Type1");
    //    DataColumn dcol5 = new DataColumn("Sequenceno1");
    //    dt.Columns.Add(dcol1);
    //    dt.Columns.Add(dcol2);
    //    dt.Columns.Add(dcol3);
    //    dt.Columns.Add(dcol4);
    //    dt.Columns.Add(dcol5);
    //    foreach (var item in lstRound)
    //    {
    //        var row = dt.NewRow();
    //        row["RoundName"] = item.RoundName;
    //        row["RoundName"] = item.EndTime;
    //        row["LogisticEmployee"] = item.LogisticEmployee;
    //        row["Type1"] = item.Type1;
    //        row["Sequenceno1"] = item.Sequenceno1;
    //        dt.Rows.Add(row);
    //    }

    //    return dt;
    //}
    public void ExportToExcel()
    {
        try
        {

            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

            string attachment = "attachment; filename=" + "Round Management" + dt + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            //PrepareExcelSheet();
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            gvRoundmaster.Visible = true;
            gvRoundmaster.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            gvRoundmaster.Visible = false;
            Response.End();


        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Exporting Excel", ioe);
        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
 

}
