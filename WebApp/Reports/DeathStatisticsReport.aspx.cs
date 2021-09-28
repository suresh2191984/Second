using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;

public partial class Reports_DeathStatisticsReport : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();

    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            DropDownShow();
            LoadSpecialityName();
        }
    }
    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                var childItems = from child in lstDWCR
                                 where child.VisitDate == RMaster.VisitDate
                                 select child;
                GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound CreditCardStmt", ex);
        }
    }
    public void LoadSpecialityName()
    {
        List<PhysicianSpeciality> lstPhySpeciality = new List<PhysicianSpeciality>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        new PatientVisit_BL(base.ContextInfo).GetSpecialityAndSpecialityName(OrgID, out lstPhySpeciality, 0, out lstSpeciality);

        List<Speciality> lstTempSpeciality = (from tmp in lstSpeciality
                                              select new Speciality
                                              {
                                                  SpecialityID = tmp.SpecialityID,
                                                  SpecialityName = tmp.SpecialityName.Split(':')[0]
                                              }).ToList();
        ddlspeciality.DataSource = lstTempSpeciality;
        ddlspeciality.DataTextField = "SpecialityName";
        ddlspeciality.DataValueField = "SpecialityID";
        ddlspeciality.DataBind();
        //ddlspeciality.Items.Insert(0, "-----Select-----");
        //ddlConsultingName.Items.Insert(0, "-----Select-----");
    }
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    public void DropDownShow()
    {
        Physician_BL ObjPhysician = new Physician_BL(base.ContextInfo);
        List<Physician> physicianList = new List<Physician>();
        ObjPhysician.GetPhysicianList(OrgID, out physicianList);
        ddlprimaryconsultant.DataSource = physicianList;
        ddlprimaryconsultant.DataTextField = "PhysicianName";
        ddlprimaryconsultant.DataValueField = "PhysicianID";
        ddlprimaryconsultant.DataBind();
        //ddlprimaryconsultant.Items.Insert(0, "--All--");
        //ddlprimaryconsultant.Items[0].Value = "0";
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbappend = new StringBuilder();
            int i = 0;
            //string requestType = rblVisitType.SelectedItem.Text;
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            if (chkAnesthetist.Checked)
            {
                sb.Append(" and");
                sb.Append(" PC.PrimaryConsultantID=");
                sb.Append("" + ddlprimaryconsultant.SelectedItem.Value + "");
                hdndivanesthetist.Value = "Y";
            }
            else
            {
                hdndivanesthetist.Value = "N";
            }
            if (chksurgeon.Checked)
            {
                sb.Append(" and");
                sb.Append(" P.SEX=");
                sb.Append("'");
                sb.Append("" + ddlgender.SelectedItem.Value + "");
                sb.Append("'");
                hdndivsurgeon.Value = "Y";
            }
            else
            {
                hdndivsurgeon.Value = "N";
            }
            if (chksurgery.Checked)
            {
                sb.Append(" and");
                sb.Append(" sp.SpecialityID=");                
                sb.Append(""+ ddlspeciality.SelectedItem.Value + "");     
                hdndivsurgery.Value = "Y";
            }
            else
            {
                hdndivsurgery.Value = "N";
            }
            returnCode = new Report_BL(base.ContextInfo).GetDeathStatReport(fDate, tDate, OrgID,sb.ToString(), out lstDWCR);
            if (lstDWCR.Count > 0)
            {
                var cntdwcr = (from dw in lstDWCR
                            select new { dw.VisitDate }).Distinct();                
               
                foreach (var obj in cntdwcr)
                {                   
                    i = i + 1;
                }
                var dwcr = (from s in lstDWCR
                           group s by new { s.PhysicianName, s.PatientID } into info
                           select new
                           {
                               PhysicianName = info.Key.PhysicianName,
                               count = info.Count()
                           });
                sbappend.Append("<table border=" + 1 + ">");
                sbappend.Append("<tr>");
                sbappend.Append("<td>");
                sbappend.Append("<b>");
                sbappend.Append("Statistics");
                sbappend.Append("</b>");
                sbappend.Append("</td>");
                sbappend.Append("<td>");
                sbappend.Append("<b>");
                sbappend.Append("Count");
                sbappend.Append("</b>");
                sbappend.Append("</td>");
                sbappend.Append("</tr>");
                sbappend.Append("<tr>");
                sbappend.Append("<td>");
                sbappend.Append("<b>");
                sbappend.Append("Total Number of Death(s):");
                sbappend.Append("</b>");
                sbappend.Append("</td>");
                sbappend.Append("<td>");
                sbappend.Append(""+i+"");
                sbappend.Append("</td>");
                sbappend.Append("</tr>");
                sbappend.Append("<tr>");
                sbappend.Append("<td>");
                sbappend.Append("<b>");
                sbappend.Append("Physican Wise");
                sbappend.Append("</b>");
                sbappend.Append("</td>");
                sbappend.Append("</tr>");

                foreach (var item in dwcr)
                {
                    sbappend.Append("<tr>");
                    sbappend.Append("<td align=justify>");
                    //sbappend.Append("No. of ");
                    sbappend.Append(item.PhysicianName);
                    //sbappend.Append(" Deaths");
                    sbappend.Append(":");
                    sbappend.Append("</td>");
                    sbappend.Append("<td>");
                    sbappend.Append(item.count);
                    sbappend.Append("<br>");
                    sbappend.Append("</td>");
                    sbappend.Append("</tr>");
                }
                var spdwcr = (from s in lstDWCR
                            group s by new { s.SpecialityName, s.PatientID } into info
                            select new
                            {
                                SpecialityName = info.Key.SpecialityName,
                                count = info.Count()
                            });
                sbappend.Append("<tr>");
                sbappend.Append("<td>");
                sbappend.Append("<b>");
                sbappend.Append("Speciality Wise");
                sbappend.Append("</b>");
                sbappend.Append("</td>");
                sbappend.Append("</tr>");
                foreach (var item in spdwcr)
                {
                    sbappend.Append("<tr>");
                    sbappend.Append("<td align=justify>");
                    //sbappend.Append("No. of ");
                    sbappend.Append(item.SpecialityName);
                    //sbappend.Append(" Deaths");
                    sbappend.Append(":");
                    sbappend.Append("</td>");
                    sbappend.Append("<td>");
                    sbappend.Append(item.count);
                    sbappend.Append("<br>");
                    sbappend.Append("</td>");
                    sbappend.Append("</tr>");
                }
                if (rblReportType.SelectedValue == "0")
                {
                    divOPDWCR.Attributes.Add("style", "block");
                    divPrint.Attributes.Add("style", "block");
                    gvIPCreditMain.Visible = false;
                    tblSurgeryTeam.Attributes.Add("style", "display:none");
                    lbltxt.Attributes.Add("style", "display:block");
                    //tbl.Attributes.Add("Style","Display:none");
                    lbltxt.Text = sbappend.ToString();
                }
                else
                {
                    tblSurgeryTeam.Attributes.Add("style", "display:block");
                    lbltxt.Attributes.Add("style", "display:none"); 
                    divOPDWCR.Attributes.Add("style", "block");
                    divPrint.Attributes.Add("style", "block");
                    divOPDWCR.Visible = true;
                    divPrint.Visible = true;
                    lblTotal.Visible = false;
                    gvIPCreditMain.Visible = true;
                    gvIPCreditMain.DataSource = lstDWCR;
                    gvIPCreditMain.DataBind();
                }
            }
            else
            {
                divOPDWCR.Attributes.Add("style", "none");
                divPrint.Attributes.Add("style", "none");
                divOPDWCR.Visible = false;
                divPrint.Visible = false;
                //CalculationPanelNone();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, CreditCardStmt", ex);
        }
    }

    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (gvIPCreditMain.Rows.Count > 0)
            {
                string attachment = "attachment; filename=DeathStatistics_Report" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
                Response.ClearContent();
                Response.AddHeader("content-disposition", attachment);
                Response.ContentType = "application/ms-excel";
                Response.Charset = "";
                this.EnableViewState = false;
                System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
                gvIPCreditMain.RenderControl(oHtmlTextWriter);
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
}
