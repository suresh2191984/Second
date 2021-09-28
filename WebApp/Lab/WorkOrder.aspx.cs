using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class Lab_WorkOrder : BasePage
{
    long vid = 0;
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

    string key = string.Empty;
    string strevent = string.Empty;
    string gUID = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new Patient_BL(base.ContextInfo);
        Int64.TryParse(Request.QueryString["VID"], out vid);
        if (Request.QueryString["gUID"] != null)
        {
            gUID = Request.QueryString["gUID"].ToString();
        }
        returnCode = patientBL.GetLabVisitDetails(vid,OrgID, out visitList);

        if (visitList.Count > 0)
        {
            DrName.Text = visitList[0].ReferingPhysicianName;
            HospitalName.Text = visitList[0].HospitalName;

            if (visitList[0].CollectionCentreName != null && visitList[0].CollectionCentreName != "")
            {
                trCC.Style.Add("display", "block");
                CollectionCentre.Text = visitList[0].CollectionCentreName;
            }
            else
            {
                trCC.Style.Add("display", "none");
            }
            lblVisitNo.Text =  vid.ToString();
            lblPatientName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;
            lblPatientNo.Text = visitList[0].PatientNumber.ToString();

            if (visitList[0].Sex == "M")
            {
                lblGender.Text = "[Male]";
            }
            else
            {
                lblGender.Text = "[Female]";
            }
            lblAge.Text = visitList[0].PatientAge.ToString();
            btnBack.PostBackUrl = "InvestigationSample.aspx?Bool=Y";
        }

        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
        invbl.GetInvestigationSamplesCollect(vid, OrgID, RoleID, gUID,ILocationID,22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);

        //OrderedSamples1.LoadSamples(lstOrderedInvSample, lstPatientInvestigation, deptList);
       
        string windowFeatures = "toolbar=no,status=no,menubar=no,location=no,scrollbars=yes,resizable=yes,height=700,width=1024,left=150,top=250";
        key = "window.open('Printworkorder.aspx?VID=" + vid + "','demo','" + windowFeatures + "','');";
        strevent = "window.open('WorkOrder.aspx?VID=" + vid + "','demo','" + windowFeatures + "','');";
        hypLnkPrint.NavigateUrl = "Printworkorder.aspx?VID=" + vid;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        
    }
}
