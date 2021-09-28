using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Configuration;
using System.IO;


public partial class Admin_ViewSamples : BasePage
{
    int visitID = 0;
    long returnCode = -1;
    Patient_BL patientBL;
    List<PatientVisit> visitList = new List<PatientVisit>();
    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
    List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
    List<CollectedSample> lstOrderedSamples = new List<CollectedSample>();
    List<InvDeptMaster> deptList = new List<InvDeptMaster>();
    Investigation_BL invBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new Patient_BL(base.ContextInfo);
        invBL = new Investigation_BL(base.ContextInfo);
        Int32.TryParse(Request.QueryString["vid"].ToString(), out visitID);
        
        //Load data for patient Details

        if (!IsPostBack)
        {
            returnCode = patientBL.GetLabVisitDetails(visitID, OrgID, out visitList);

            if (visitList.Count > 0)
            {
                lblVisitNo.Text = Convert.ToString(visitID);
                lblPatientName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;
                lblPatientNo.Text = Convert.ToString(visitList[0].PatientID);

                if (visitList[0].Sex == "M")
                {
                    lblGender.Text = "[Male]";
                }
                else
                {
                    lblGender.Text = "[Female]";
                }
                lblAge.Text = visitList[0].PatientAge.ToString();

            }

            invBL.getSampleCollectionforDepartment(RoleID, OrgID, visitID,ILocationID, out lstPatientInvestigation, out lstInvDeptMaster, out lstPatientInvSample, out lstOrderedSamples, out deptList);

            if (lstOrderedSamples.Count() > 0)
            {
                grdResult.DataSource = lstOrderedSamples;
                grdResult.DataBind();
            }
        }

    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        Response.Redirect("InvestigationSamplesReport.aspx");
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            invBL.getSampleCollectionforDepartment(RoleID, OrgID, visitID,ILocationID, out lstPatientInvestigation, out lstInvDeptMaster, out lstPatientInvSample, out lstOrderedSamples, out deptList);

            if (lstOrderedSamples.Count() > 0)
            {
                grdResult.DataSource = lstOrderedSamples;
                grdResult.DataBind();
            }
        }
    }
}
