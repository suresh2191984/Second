using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;

public partial class Physician_InvestigationReport : BasePage 
{
    string patientName = string.Empty;
    DateTime fromDate,toDate;
    int vid=0;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtPatientName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
        //lblResultStatus.Visible = false;
        btnGo.Visible = false;            
        if (!Page.IsPostBack)
        {
            txtFrom.Text = Convert.ToString(Convert.ToDateTime(new BasePage().OrgDateTimeZone));
            txtTo.Text = Convert.ToString(Convert.ToDateTime(new BasePage().OrgDateTimeZone)); 
        }
    }
   
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if(e.Row.RowType== DataControlRowType.DataRow)
        {
            PatientVisitDetails p = (PatientVisitDetails)e.Row.DataItem;

            e.Row.Cells[0].Attributes["onclick"] = "DisableRadioButton('" + ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).ClientID + "');";
            e.Row.Cells[0].Attributes.Add("onmouseover", "this.style.cursor='pointer'");

//Prasanna Edited Starts

            string strScript = "SelectRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + p.PatientID + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

//Prasanna Edited Ends   
        }
    }



    protected void btnGo_Click(object sender, EventArgs e)
    {
        try
        {
            for (int i = 0; i < grdResult.Rows.Count; i++)
            {
                RadioButton rdobj = (RadioButton)grdResult.Rows[i].Cells[0].FindControl("rdSel");

                if (rdobj.Checked == true)
                {
                    vid = Convert.ToInt32(grdResult.DataKeys[i][0]);
                    //Response.Redirect("~/Investigation/InvestigationDisplay.aspx?vid=" + vid);
                    Response.Redirect("~/Investigation/InvestigationReport.aspx?vid=" + vid);
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        patientName = txtPatientName.Text;        

        fromDate = Convert.ToDateTime(txtFrom.Text);
        toDate = Convert.ToDateTime(txtTo.Text);
        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
        Investigation_BL investigation_Bl = new Investigation_BL(base.ContextInfo);
        investigation_Bl.GetinvestigationReport(patientName, fromDate, toDate, OrgID, out lstPatientVisitDetails);
        if (lstPatientVisitDetails.Count > 0)
        {
            lblResultStatus.Visible = false;
            btnGo.Visible = true;
            grdResult.Visible = true;
            grdResult.DataSource = lstPatientVisitDetails;
            grdResult.DataBind();
        }
        else
        {
            lblResultStatus.Visible = true;
            grdResult.Visible = false;
            btnGo.Visible = false;
            lblResultStatus.Text = "No matching records found";            
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdResult.PageIndex = e.NewPageIndex;
        btnSearch_Click(sender, e);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/Physician/Home.aspx");
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}
