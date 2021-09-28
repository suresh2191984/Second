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

public partial class Reports_PhysioComplaintReport : BasePage
{
    List<Patient> lstPatient;
    List<PatientPhysioDetails> lstPatientPhysioDetails;   
    Patient_BL objPatient_BL;
    long retCode = -1;
    int RptType = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindComplaintName();
        }
    }

    private void BindComplaintName()
    {
        lstPatientPhysioDetails = new List<PatientPhysioDetails>();
        objPatient_BL = new Patient_BL(base.ContextInfo);
        retCode = objPatient_BL.GetComplaintName(OrgID, out lstPatientPhysioDetails);

        if (lstPatientPhysioDetails.Count > 0)
        {
            ddlcPhysio.DataSource = lstPatientPhysioDetails;
            ddlcPhysio.DataTextField = "ComplaintName";
            ddlcPhysio.DataValueField = "ComplaintID";
            ddlcPhysio.DataBind();
            ddlcPhysio.Items.Insert(0, "--All--");
            ddlcPhysio.Items[0].Value = "0";
        }
    }
    protected void gvPCReport_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "OView")
        {
            string CName = string.Empty;
            int RowIndex = Convert.ToInt32(e.CommandArgument);
            CName = gvPCReport.DataKeys[RowIndex][0].ToString();

            lstPatient = new List<Patient>();
            objPatient_BL = new Patient_BL(base.ContextInfo);
            retCode = objPatient_BL.GetPhysioCompliantPatient(RptType,CName, Convert.ToDateTime(txtFDate.Text), Convert.ToDateTime(txtTDate.Text), OrgID, out lstPatient);

            if (lstPatient.Count > 0)
            {


                gvPatientDetail.DataSource = lstPatient;
                gvPatientDetail.DataBind();
                ModelPopPatientDetail.Show();
            }

           
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        lstPatientPhysioDetails = new List<PatientPhysioDetails>();
        objPatient_BL = new Patient_BL(base.ContextInfo);
        retCode = objPatient_BL.GetPhysioCompliantReport(ddlcPhysio.SelectedItem.Text, Convert.ToDateTime(txtFDate.Text), Convert.ToDateTime(txtTDate.Text), OrgID, out lstPatientPhysioDetails);
        if (lstPatientPhysioDetails.Count > 0)
        {
            tblgvPCReport.Style.Add("display", "block");
            divPrintPC.Attributes.Add("style", "block");
            gvPCReport.DataSource = lstPatientPhysioDetails;
            gvPCReport.DataBind();
        }
        else
        {
            tblgvPCReport.Style.Add("display", "none");
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
    protected void gvPCReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvPCReport.PageIndex = e.NewPageIndex;
                btnSubmit_Click(sender, e);
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, gvPCReport_PageIndexChanging", ex);
        }
    }
}
