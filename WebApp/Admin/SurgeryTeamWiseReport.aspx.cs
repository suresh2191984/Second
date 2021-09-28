using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Data;

public partial class Admin_SurgeryTeamWiseReport : BasePage
{
    List<SurgeryBillingMaster> lstSurgeryBillingMaster = new List<SurgeryBillingMaster>();
    List<Physician> lstSurgeon = new List<Physician>();
    List<Physician> lstAnesthetist = new List<Physician>();
    List<SurgeryBillingMaster> lstTreatmentName = new List<SurgeryBillingMaster>();
    Report_BL objReport_BL;
    string SearchType = "";
    long SurgenID = -1;
    long AnesthetistID = -1;
    string TreatmentName = "";
    decimal Subtotal = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        objReport_BL = new Report_BL(base.ContextInfo);
        txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");

        if (!IsPostBack)
        {
            try
            {
                hdnFrom.Value = "";
                hdnTO.Value = "";
                hdnSurgeon.Value = "-1";
                hdnSOI.Value = "";
                hdnAnes.Value = "-1";
                txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");                
                if (Request.QueryString["status"] == "SOI")
                {
                    btnSearch_Click(sender, e);
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Get Report, SurgeryTeamWiseReport", ex);
            }

        }
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (gvSurgeryReport.Rows.Count > 0)
            {
                string attachment = "attachment; filename=SurgeryTeam_Wise_Report" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
                Response.ClearContent();
                Response.AddHeader("content-disposition", attachment);
                Response.ContentType = "application/ms-excel";
                Response.Charset = "";
                this.EnableViewState = false;
                System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
                gvSurgeryReport.RenderControl(oHtmlTextWriter);
                Response.Write(oStringWriter.ToString());
                Response.End();
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Converting to Excel.", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        List<SurgeryReport> lstaddSurgeon = new List<SurgeryReport>();
        DataTable dt = new DataTable();
        try
        {
            if (hdnFrom.Value == "" && hdnTO.Value == "")
            {
                SearchDateWise();
                lblName.Visible = false;
            }
            else
            {
                if (chksurgeon.Checked)
                {
                    IEnumerable<ListItem> allChecked = (from ListItem item in chklstsurgeon.Items
                                                        where item.Selected
                                                        select item);
                    if (allChecked.Count() != 0)
                    {
                        hdnSurgeon.Value = "1";
                        hdnSOI.Value = "";
                        hdnAnes.Value = "-1";

                        foreach (ListItem item in allChecked)
                        {
                            SurgeryReport SR = new SurgeryReport();
                            SR.ChiefSurgeonID = Int64.Parse(item.Value);
                            SR.Name = "";
                            SR.ID = 0;
                            SR.TreatmentName = "";
                            SR.Type = "";
                            lstaddSurgeon.Add(SR);
                        }
                    }
                }
                if (chksurgery.Checked)
                {

                    IEnumerable<ListItem> allChecked = (from ListItem item in chklstsurgery.Items
                                                        where item.Selected
                                                        select item);
                    if (allChecked.Count() != 0)
                    {
                        hdnSurgeon.Value = "-1";
                        hdnSOI.Value = "1";
                        hdnAnes.Value = "-1";

                        foreach (ListItem item in allChecked)
                        {
                            SurgeryReport SR = new SurgeryReport();
                            SR.ID = Int64.Parse(item.Value);
                            SR.Name = "";
                            SR.Type = "";
                            SR.ChiefSurgeonID = 0;
                            SR.TreatmentName = item.Text;
                            lstaddSurgeon.Add(SR);
                        }
                    }
                }

                if (chkAnesthetist.Checked)
                {
                    IEnumerable<ListItem> allChecked = (from ListItem item in chklstanesthetist.Items
                                                        where item.Selected
                                                        select item);
                    if (allChecked.Count() != 0)
                    {
                        hdnSurgeon.Value = "-1";
                        hdnSOI.Value = "";
                        hdnAnes.Value = "1";
                        foreach (ListItem item in allChecked)
                        {
                            SurgeryReport SR = new SurgeryReport();
                            SR.ID = Int64.Parse(item.Value);
                            SR.Name = "";
                            SR.Type = "ANST";
                            SR.TreatmentName = "";
                            SR.ChiefSurgeonID = 0;
                            lstaddSurgeon.Add(SR);
                        }
                    }
                }               
                if((!chkAnesthetist.Checked)&&(!chksurgeon.Checked)&&(!chksurgery.Checked))
                {
                    SearchType = "Date";
                }
                if ((chksurgeon.Checked) && (chkAnesthetist.Checked) || (chksurgery.Checked) && (chkAnesthetist.Checked) || (chksurgery.Checked) && (chksurgeon.Checked) || (chksurgeon.Checked) && (chkAnesthetist.Checked) && (chksurgery.Checked))
                {
                    SearchType = "All";
                    hdnSurgeon.Value = "-1";
                    hdnSOI.Value = "";
                    hdnAnes.Value = "-1";
                }
                dt = gettable(lstaddSurgeon);
                //SearchType = dt.Rows.Count == 0 ? "Date" : "";
                if (dt.Rows.Count == 0)
                {
                    SearchType = "Date";
                    hdnSurgeon.Value = "-1";
                    hdnSOI.Value = "";
                    hdnAnes.Value = "-1";
                    dt = null;
                }
                objReport_BL.GetSurgeryTeamWiseReport(dt, Convert.ToDateTime(txtFrom.Text), Convert.ToDateTime(txtTo.Text), OrgID, Convert.ToInt64(hdnSurgeon.Value), Convert.ToInt64(hdnAnes.Value), hdnSOI.Value, SearchType, out lstSurgeryBillingMaster, out lstSurgeon, out lstAnesthetist, out lstTreatmentName);
                if (lstSurgeryBillingMaster.Count > 0)
                {
                    tblSurgeryReport.Style.Add("display", "Block");
                    gvSurgeryReport.DataSource = lstSurgeryBillingMaster;
                    gvSurgeryReport.DataBind();
                    trSubTotal.Style.Add("display", "Block");
                    lblSubTotal.Text = "Sub Total :" + Subtotal.ToString();
                    trPrint.Style.Add("display", "Block");
                    tblSurgeryTeam.Style.Add("display", "Block");
                    lblNorecord.Visible = false;
                    lblName.Visible = true;
                    chklstsurgeon.DataSource = lstSurgeon;
                    chklstsurgeon.DataTextField = "PhysicianName";
                    chklstsurgeon.DataValueField = "PhysicianID";
                    chklstsurgeon.DataBind();

                    chklstanesthetist.DataSource = lstAnesthetist;
                    chklstanesthetist.DataTextField = "PhysicianName";
                    chklstanesthetist.DataValueField = "PhysicianID";
                    chklstanesthetist.DataBind();

                    chklstsurgery.DataSource = lstTreatmentName;
                    chklstsurgery.DataTextField = "TreatmentName";
                    chklstsurgery.DataValueField = "SurgeryID";
                    chklstsurgery.DataBind();

                    chksurgery.Checked = false;
                    chksurgeon.Checked = false;
                    chkAnesthetist.Checked = false;
                    if (hdnSurgeon.Value != "-1")
                    {
                        // lblName.Text = "Filter By:""    Name:  ";
                    }
                    if (hdnAnes.Value != "-1")
                    {
                        // lblName.Text = "Filter By:"  "    Name:  " ;
                    }
                    if (hdnSOI.Value != "")
                    {
                        //lblName.Text = "Filter By:"  "   Treatment:  "  ;
                    }
                }
                else
                {
                    lblNorecord.Visible = true;
                    gvSurgeryReport.DataSource = null;
                    gvSurgeryReport.DataBind();
                    lblName.Visible = false;
                    trSubTotal.Style.Add("display", "none");
                    tblSurgeryReport.Style.Add("display", "none");
                    trPrint.Style.Add("display", "none");
                    //divsurgeon.Attributes.Add("style", "display:block");
                    //divanesthetist.Attributes.Add("style", "display:block");
                    //divsurgery.Attributes.Add("style", "display:block");
                }
                //else
                //{
                //    SearchDateWise();
                //    lblName.Visible = false;
                //    ddlSOI.Enabled = true;
                //    ddlSurgenName.Enabled = true;
                //    ddlAnesthetist.Enabled = true;
                //    //tdSOIT.Style.Add("display", "block");
                //    //tdSOIV.Style.Add("display", "block");
                //    //tdAnesthetistT.Style.Add("display", "block");
                //    //tdAnesthetistV.Style.Add("display", "block");
                //    //tdSurgenT.Style.Add("display", "block");
                //    //tdSurgenV.Style.Add("display", "block");
                //}
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, SurgeryTeamWiseReport", ex);
        }
    }
    public DataTable gettable(List<SurgeryReport> lst)
    {
        DataTable dt = new DataTable();
        try
        {
            if (lst.Count != 0)
            {
                DataColumn dc1 = new DataColumn("ID");
                DataColumn dc2 = new DataColumn("Name");
                DataColumn dc3 = new DataColumn("ChiefSurgeonID");
                DataColumn dc4 = new DataColumn("Type");
                DataColumn dc5 = new DataColumn("TreatmentName");
                dt.Columns.Add(dc1);
                dt.Columns.Add(dc2);
                dt.Columns.Add(dc3);
                dt.Columns.Add(dc4);
                dt.Columns.Add(dc5);              

                foreach (SurgeryReport item in lst)
                {
                    DataRow dr = dt.NewRow();

                    dr["ID"] = item.ID;
                    dr["Name"] = item.Name;
                    dr["ChiefSurgeonID"] = item.ChiefSurgeonID;
                    dr["Type"] = item.Type;
                    dr["TreatmentName"] = item.TreatmentName;
                    dt.Rows.Add(dr);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured while converting Datatable", ex);
        }

        return dt;
    }
    public void SearchDateWise()
    {
        DataTable dt = new DataTable();

        try
        {
            hdnSurgeon.Value = "-1";
            hdnSOI.Value = "";
            hdnAnes.Value = "-1";

            hdnFrom.Value = txtFrom.Text;
            hdnTO.Value = txtTo.Text;
            SearchType = "Date";
            dt = null;
            objReport_BL.GetSurgeryTeamWiseReport(dt, Convert.ToDateTime(txtFrom.Text), Convert.ToDateTime(txtTo.Text), OrgID, SurgenID, AnesthetistID, TreatmentName, SearchType, out lstSurgeryBillingMaster, out lstSurgeon, out lstAnesthetist, out lstTreatmentName);

            if (lstSurgeryBillingMaster.Count > 0)
            {
                lblNorecord.Visible = false;
                tblSurgeryReport.Style.Add("display", "Block");

                gvSurgeryReport.DataSource = lstSurgeryBillingMaster;
                gvSurgeryReport.DataBind();

                trSubTotal.Style.Add("display", "Block");
                lblSubTotal.Text = "Sub Total :" + Subtotal.ToString();

                trPrint.Style.Add("display", "Block");
                tblSurgeryTeam.Style.Add("display", "Block");
                if (lstSurgeon.Count > 0)
                {
                    chklstsurgeon.DataSource = null;
                    chklstsurgeon.DataBind();
                    chklstsurgeon.DataSource = lstSurgeon;
                    chklstsurgeon.DataTextField = "PhysicianName";
                    chklstsurgeon.DataValueField = "PhysicianID";
                    chklstsurgeon.DataBind();
                }
                else
                {
                    chklstsurgeon.DataSource = null;
                    chklstsurgeon.DataBind();
                }
                if (lstAnesthetist.Count > 0)
                {
                    chklstanesthetist.DataSource = null;
                    chklstanesthetist.DataBind();
                    chklstanesthetist.DataSource = lstAnesthetist;
                    chklstanesthetist.DataTextField = "PhysicianName";
                    chklstanesthetist.DataValueField = "PhysicianID";
                    chklstanesthetist.DataBind();
                }
                else
                {
                    chklstanesthetist.DataSource = null;
                    chklstanesthetist.DataBind();
                }
                if (lstAnesthetist.Count > 0)
                {
                    chklstsurgery.DataSource = null;
                    chklstsurgery.DataBind();
                    chklstsurgery.DataSource = lstTreatmentName;
                    chklstsurgery.DataTextField = "TreatmentName";
                    chklstsurgery.DataValueField = "SurgeryID";
                    chklstsurgery.DataBind();
                }
                else
                {
                    chklstsurgery.DataSource = null;
                    chklstsurgery.DataBind();
                }
            }
            else
            {
                gvSurgeryReport.DataSource = null;
                gvSurgeryReport.DataBind();
                chklstsurgeon.DataSource = null;
                chklstsurgeon.DataBind();
                chklstsurgery.DataSource = null;
                chklstsurgery.DataBind();
                chklstanesthetist.DataSource = null;
                chklstanesthetist.DataBind();
                tblSurgeryTeam.Style.Add("display", "none");
                lblNorecord.Visible = true;
                trSubTotal.Style.Add("display", "none");
                tblSurgeryReport.Style.Add("display", "none");
                trPrint.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, SurgeryTeamWiseReport", ex);
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        #region Commented
        //txtFrom.Text = "";
        //txtTo.Text = "";
        //gvSurgeryReport.DataSource = null;
        //gvSurgeryReport.DataBind();
        //tblSurgeryTeam.Style.Add("display", "none");
        //hdnSurgeon.Value = "";
        //hdnSOI.Value = "";
        //hdnAnes.Value = "";
        //hdnFrom.Value = "";
        //hdnTO.Value = "";
        //ddlSurgenName.DataSource = null;
        //ddlSurgenName.DataBind();
        //ddlAnesthetist.DataSource = null;
        //ddlAnesthetist.DataBind();
        //ddlSOI.DataSource = null;
        //ddlSOI.DataBind();
        #endregion
        try
        {

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, Reset_Click", ex);
        }
    }
    protected void gvSurgeryReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvSurgeryReport.PageIndex = e.NewPageIndex;
                btnSearch_Click(sender, e);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, gvSurgeryReport_PageIndexChanging", ex);
        }
    }

    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reports/ViewReportList.aspx", true);
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
    protected void gvSurgeryReport_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblSurgicalFee = (Label)e.Row.FindControl("lblSurgicalFee");
            Subtotal += Convert.ToDecimal(lblSurgicalFee.Text);
        }
    }
}
    
