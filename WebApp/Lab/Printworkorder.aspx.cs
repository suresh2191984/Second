using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;

public partial class Lab_Printworkorder : BasePage
{
    int vid = 0;
    long returnCode = -1;
    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
    List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
    List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
    List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
    List<PatientVisit> visitList = new List<PatientVisit>();
    List<InvDeptMaster> deptList = new List<InvDeptMaster>();
    List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
    Patient_BL patientBL;
    string gUID = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new Patient_BL(base.ContextInfo);
        Int32.TryParse(Request.QueryString["VID"], out vid);
        if (Request.QueryString["gUID"] != null)
        {
            gUID = Request.QueryString["gUID"].ToString();
        }
        returnCode = patientBL.GetLabVisitDetails(vid, OrgID, out visitList);

        if (visitList.Count > 0)
        {
            DrName.Text = visitList[0].ReferingPhysicianName;
            HospitalName.Text = visitList[0].HospitalName;
            VisitNo.Text = vid.ToString();
            PatientName.Text = visitList[0].PatientName;
            ltAge.Text = visitList[0].PatientAge;
            ltSex.Text = visitList[0].Sex;

            if (visitList[0].CollectionCentreName != null && visitList[0].CollectionCentreName != "")
            {
                trCC.Style.Add("display", "block");
                CollectionCentre.Text = visitList[0].CollectionCentreName;
            }
            else
            {
                trCC.Style.Add("display", "none");
            }


        }

        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
        invbl.GetInvestigationSamplesCollect(vid, OrgID, RoleID, gUID, ILocationID,22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);
        if (lstPatientInvestigation.Count > 0)
        {
            dlInvName.DataSource = lstPatientInvestigation;
            dlInvName.DataBind();
        }
        if (lstOrderedInvSample.Count > 0)
        {
            dtSample.DataSource = lstOrderedInvSample;
            dtSample.DataBind();
            lblStatus.Visible = false;
            deptBlock.Style.Add("display", "block");
        }
        else
        {
            lblStatus.Visible = true;
        }
        if (deptList.Count > 0)
        {
            dlDeptName.DataSource = deptList;
            dlDeptName.DataBind();
        }
        else
        {
            deptBlock.Style.Add("display", "none");
        }
    }
}
