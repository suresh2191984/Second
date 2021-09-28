#region Namespace Decleration
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Web.UI.HtmlControls;
using System.Drawing;

#endregion

public partial class Patient_EventChart : BaseControl
{

    public event System.EventHandler selectionChanged;
    public event System.EventHandler checkedChanged;
    public event System.EventHandler selectionchecked;
    string vType = string.Empty;
    int option = 0;
    long visitID = 0;
    long patientID = 0;
    int taskID = 0;
    int complaintID = -1;
    bool visible = true;
    List<PatDtlsVPAction> lstChildPatDtlsVPAction = new List<PatDtlsVPAction>();
    string patDetailsOptions = string.Empty;

    public long VisitID
    {
        get { return visitID; }
        set { visitID = value; }
    }
    public long PatientID
    {
        get { return patientID; }
        set { patientID = value; }
    }
    public int TaskID
    {
        get { return taskID; }
        set { taskID = value; }
    }
    public string PatientDetailsOptions
    {
        get { return patDetailsOptions; }
        set { patDetailsOptions = value; }
    }

    public int ComplaintID
    {
        get { return complaintID; }
        set { complaintID = value; }
    }
    public bool Visible
    {
        get { return visible; }
        set { visible = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    string eventsname = string.Empty;
    long tempid;
    List<EventChart> lstchart = new List<EventChart>();
    EventChart chart = new EventChart();
    int j = 0;
    int count = 0;
    int count1 = 0;
    public void loadData(List<EventChart> lstEventChart, List<PatDtlsVPAction> lstPatDtlsVPAction)
    {
        lstChildPatDtlsVPAction = lstPatDtlsVPAction;
        vType = Request.QueryString["vType"];
        //for (int i = 0; i < lstEventChart.Count; i++)
        //{
        long tempvisitid = -1;
        if (lstEventChart.Count > 0)
        {
            for (j = 0; j < lstEventChart.Count; j++)
            {
                if (j > 0)
                {
                    string tempname = lstEventChart[j].Events;
                    tempvisitid = lstEventChart[j - 1].VisitId;
                    if (lstEventChart[j].VisitId == tempvisitid)
                    {

                        if (count == 0)
                        {
                            eventsname = lstEventChart[j].Events;
                            count++;
                        }
                        else
                        {
                            eventsname = eventsname + "<br />" + lstEventChart[j].Events;
                            count1++;
                        }
                    }
                    else
                    {
                        if (lstEventChart.Count == 1)
                        {
                            eventsname = lstEventChart[j].Events;
                            chart.Events = eventsname;
                            chart.VisitId = lstEventChart[j - 1].VisitId;
                            chart.Date = lstEventChart[j - 1].Date;
                            chart.Physician = lstEventChart[j - 1].Physician;
                            chart.VisitNotes = lstEventChart[j - 1].VisitNotes;
                            chart.ShowOptions = lstEventChart[j - 1].ShowOptions;
                            chart.OrganisationName = lstEventChart[j - 1].OrganisationName;
                            chart.OrgID = lstEventChart[j - 1].OrgID;
                            chart.VisitPurposeID = lstEventChart[j - 1].VisitPurposeID;
                            lstchart.Add(chart);
                        }
                        else
                        {
                            chart.Events = eventsname;
                            chart.VisitId = lstEventChart[j - 1].VisitId;
                            chart.Date = lstEventChart[j - 1].Date;
                            chart.Physician = lstEventChart[j - 1].Physician;
                            chart.VisitNotes = lstEventChart[j - 1].VisitNotes;
                            chart.ShowOptions = lstEventChart[j - 1].ShowOptions;
                            chart.OrganisationName = lstEventChart[j - 1].OrganisationName;
                            chart.OrgID = lstEventChart[j - 1].OrgID;
                            chart.VisitPurposeID = lstEventChart[j - 1].VisitPurposeID;
                            lstchart.Add(chart);

                            chart = new EventChart();
                            eventsname = lstEventChart[j].Events;
                            count = 1;
                        }
                    }
                }
                else
                {
                    eventsname = lstEventChart[j].Events;
                    count++;
                }

            }
            if (lstEventChart.Count >= 1)
            {
                chart.Events = eventsname;
                chart.VisitId = lstEventChart[j - 1].VisitId;
                chart.Date = lstEventChart[j - 1].Date;
                chart.Physician = lstEventChart[j - 1].Physician;
                chart.VisitNotes = lstEventChart[j - 1].VisitNotes;
                chart.ShowOptions = lstEventChart[j - 1].ShowOptions;
                chart.OrganisationName = lstEventChart[j - 1].OrganisationName;
                chart.OrgID = lstEventChart[j - 1].OrgID;
                chart.VisitPurposeID = lstEventChart[j - 1].VisitPurposeID;
                lstchart.Add(chart);
            }
            else
            {
                chart.Events = eventsname;
                chart.VisitId = lstEventChart[j].VisitId;
                chart.Date = lstEventChart[j].Date;
                chart.Physician = lstEventChart[j].Physician;
                chart.VisitNotes = lstEventChart[j].VisitNotes;
                chart.ShowOptions = lstEventChart[j].ShowOptions;
                chart.OrganisationName = lstEventChart[j].OrganisationName;
                chart.OrgID = lstEventChart[j - 1].OrgID;
                chart.VisitPurposeID = lstEventChart[j - 1].VisitPurposeID;
                lstchart.Add(chart);
            }

        }
        if (lstchart.Count > 0)
        {
            gvEventChart.DataSource = lstchart;
            gvEventChart.DataBind();
            gvEventChart.SelectedIndex = 0;
            lblEvent.Text = "";
            gvEventChart.HeaderRow.Height = Unit.Pixel(15);

        }
        else
        {
            gvEventChart.DataSource = lstchart;
            gvEventChart.DataBind();
            lblEvent.Text = "No Event Chart";
        }
    }
    protected void gvEventChart_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex >= 0)
        {
            gvEventChart.PageIndex = e.NewPageIndex;
            if (selectionChanged != null)
                selectionChanged(sender, e);
        }
    }

    protected void Checked_Changed(object sender, EventArgs e)
    {
        CheckBox checkPatient = (CheckBox)sender;
        if (checkPatient.Checked)
        {
            GridViewRow row = (GridViewRow)checkPatient.NamingContainer;
            foreach (GridViewRow rows in gvEventChart.Rows)
            {
                CheckBox uncheck = (CheckBox)(rows.FindControl("checkPatient"));
                uncheck.Checked = false;
            }

            checkPatient.Checked = true;
        }

        if (checkedChanged != null)
            checkedChanged(sender, e);
    }
    protected void gvEventChart_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (checkedChanged != null)
            checkedChanged(sender, e);
    }


    protected void gvEventChart_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        int i1;


        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Cells[1].Visible = false;
            e.Row.Cells[0].Visible = false;
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList dd;
            Button bb;
            EventChart eventChart = (EventChart)e.Row.DataItem;
            if (eventChart.Events == null)
            {
                e.Row.Visible = false;
            }
            else
            {

                e.Row.Cells[1].Visible = false;
                Button btn = (Button)e.Row.FindControl("btndrp");
                btn.Visible = Visible;
                //e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");

                //e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                //e.Row.Attributes.Add("onclick", "this.style.font.size='16px';");

                //e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(this.gvEventChart, "Select$" + e.Row.RowIndex);

                for (i1 = 0; i1 <= e.Row.Cells.Count - 3; i1++)
                {
                    //e.Row.Cells[i1].Attributes["onmouseover"] = "this.style.cursor='pointer';this.bgColor='#';this.foreColor='#ffffff'";                                
                    //e.Row.Cells[i1].Attributes["onmouseout"] = "this.style.textDecoration='none';this.bgColor='#d1e5f8'";
                    e.Row.Cells[i1].Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(this.gvEventChart, "Select$" + e.Row.RowIndex);
                }

                dd = (DropDownList)e.Row.Cells[6].FindControl("DropDownList1");
                DropDownList ddlActions = (DropDownList)e.Row.Cells[6].FindControl("DropDownList1");

                var tempActions = from VPA in lstChildPatDtlsVPAction
                                  where VPA.VisitPurposeID == eventChart.VisitPurposeID
                                   select VPA;

                ddlActions.DataSource = tempActions;
                ddlActions.DataValueField = "VPActionID";
                ddlActions.DataTextField = "VPActionName";
                ddlActions.DataBind();

                bb = (Button)e.Row.Cells[6].FindControl("btndrp");
                if (VisitID > 0)
                {
                    if (vType == "IP")
                    {
                        dd.Visible = false;
                        bb.Visible = false;
                    }
                    else
                    {
                        if (eventChart.ShowOptions == "Y")
                        {
                            dd.Visible = true;
                            bb.Visible = true;
                        }
                        else
                        {
                            dd.Visible = false;
                            bb.Visible = false;
                        }
                    }
                }
                else
                {
                    dd.Visible = false;
                    bb.Visible = false;
                }
            }
            if (RoleName.ToString().Trim() == "Dialysis Technician")
            {

            }
        }

    }
    protected void gvEventChart_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Go")
        {

            // GridViewRow row = gvEventChart.SelectedRow;
            GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;

            DropDownList ddl = (DropDownList)row.FindControl("DropDownList1");
            //string ss = gvEventChart.Rows[0].Cells[1].Text;
            VisitID = Convert.ToInt64(((Label)row.FindControl("lblVisitID")).Text);
            ComplaintID = Convert.ToInt32(((Label)row.FindControl("lblComplaintID")).Text);
            if (ddl.SelectedValue == "1")
            {
                patDetailsOptions = Utilities.PatientDetailOptions.ContinueSameTreatment.ToString();
                //Response.Redirect(@"../CaseSheet/CaseSheet.aspx?vid=" + patientVisitId + "&optionid=" + option + "", true);
            }
            if (ddl.SelectedValue == "2")
            {
                patDetailsOptions = Utilities.PatientDetailOptions.AlterPrescription.ToString();
                //Response.Redirect(@"../Physician/PatientDiagnose.aspx?&UID=" + UID + "&PatientVisitID=" + patientVisitId + "&PatientID=" + patientID + "", true);
            }
            //if (ddl.SelectedValue == "3")
            //{
            //    patDetailsOptions = Utilities.PatientDetailOptions.InvestigateFurther.ToString();
            //}
            //if (ddl.SelectedValue == "4")
            //{
            //    patDetailsOptions = Utilities.PatientDetailOptions.ChangeDiagnosis.ToString();
            //    //Response.Redirect(@"../Physician/Diagnose.aspx?&vid=" + visitID + "&tid=" + taskID + "&pid=" + patientID + "", true);

            //}
            if (ddl.SelectedValue == "6")
            {
                patDetailsOptions = Utilities.PatientDetailOptions.AlterHealthInformation.ToString();
            }
            if (ddl.SelectedValue == "7")
            {
                patDetailsOptions = Utilities.PatientDetailOptions.AddRecommendations.ToString();
            }
        }

        if (e.CommandName != "Select")
            if (selectionchecked != null)
                selectionchecked(sender, e);
    }

    protected void Go_Click(object sender, EventArgs e)
    {

    }



}
