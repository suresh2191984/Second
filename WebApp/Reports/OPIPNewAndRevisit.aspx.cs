using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
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
using System.IO;

public partial class Reports_OPIPNewAndRevisit : BasePage
{
    long returnCode = -1;
    List<PatientVisitDetails> lstDetails = new List<PatientVisitDetails>();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
            txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");

            if (!IsPostBack)
            {
                txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
                txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIPNewAndRevisit.aspx:Page_Load", ex);
        }
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



    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            tdDate.InnerText = "OP/IP Visit Summary Report for : " + txtFDate.Text + " - " + txtTDate.Text;
            returnCode = new Report_BL(base.ContextInfo).GetOPIPNewAndRevisitSummary(OrgID, fDate, tDate, out lstDetails);
            lblVisit.Style.Add("display", "block");
            lblBill.Style.Add("display", "block");
            if (lstDetails.Count > 0)
            {
                lblVisit.Style.Add("display", "block");
                lblBill.Style.Add("display", "block");
                grdResult.DataSource = lstDetails.FindAll(P => P.NurseNotes == "Visit");
                grdResult.DataBind();
                GrdVisit.DataSource = lstDetails.FindAll(P => P.NurseNotes == "Bill");
                GrdVisit.DataBind();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, OPIPNewAndRevisitReport", ex);
        }
    }
    protected void imgBtnXL_Click(object sender, EventArgs e)
    {
        btnSubmit_Click(sender, e);
        ExportToExcel(grdResult);
    }
    public void ExportToExcel(Control CTRl)
    {
        Response.Clear();
        Response.AddHeader("content-disposition",
        string.Format("attachment;filename={0}.xls", "OPIPNew And Revisit Report"));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        StringWriter stringWrite = new StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        divResult.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}
