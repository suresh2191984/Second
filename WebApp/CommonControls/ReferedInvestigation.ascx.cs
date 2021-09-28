using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Text;

public partial class CommonControls_ReferedInvestigation : BaseControl
{
    long patientVisitID = -1;
    long returnCode = -1;
    int VisitType = -1;
    StringBuilder txt;
    public long PatientVisitID
    {
        get { return patientVisitID; }
        set { patientVisitID = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            


        }

    }

    public void LoadReferedInvestigation(long  PatientVisitID)
    {
        
            List<Patient> lstPatient = new List<Patient>();
            List<OrderedInvestigations> lstInvestigation = new List<OrderedInvestigations>();
            List<Physician> lstPhysician = new List<Physician>();

            returnCode = new Referrals_BL(base.ContextInfo).GetReferedInvestigation(PatientVisitID, out lstPatient, 
                                                 out lstInvestigation, out lstPhysician);

            if (lstPhysician.Count > 0)
            {
                lblPhysicianName.Text = lstPhysician[0].PhysicianName;
            }

            if (lstPatient.Count > 0)
            {
                lblPatientName.Text = lstPatient[0].Name;
                lblAge.Text = lstPatient[0].Age.ToString();
                if (lstPatient[0].SEX == "M")
                    lblSex.Text = "Male";
                else
                    lblSex.Text = "Female";
            }

            if (lstInvestigation.Count > 0)
            {
                gvReferedInvestigation.DataSource = lstInvestigation;
                gvReferedInvestigation.DataBind();
            }


            //IP_BL oIP_BL = new IP_BL(base.ContextInfo);
            //List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
            //PatientVisit_BL oPatientVisit_BL = new PatientVisit_BL(base.ContextInfo);
            //oPatientVisit_BL.GetVisitDetails(patientVisitID, out lstPatientVisit);

            //VisitType = lstPatientVisit[0].VisitType;
            //if (VisitType == 1)
            //{
            //    oIP_BL.UpdateReferedInv(patientVisitID);
            //}
    }

}
