using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class Psychologist_Home : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        PatientVisit_BL Patientvisit = new PatientVisit_BL(base.ContextInfo);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        long returncode = -1;
        TaskNew1.isCashDoctor = "Y";
        if (!Page.IsPostBack)
        {
            //Session removed by Ramki
            Session["PatientVisitID"] = null;
            Session["PatientID"] = null;
            Session["TaskID"] = null;

            ReminderDisplay1.LoadData();
            docHeader.Name = Name;

            returncode = Patientvisit.GetRecommendationDetails(OrgID, out lstPatientVisit);
            if (lstPatientVisit.Count > 0)
            {
                if (lstPatientVisit.Count == 1)
                {
                    lbtnPRcount.Visible = false;
                    lbtnPRcount.Text = "There are " + lstPatientVisit.Count + " Health Packages remaining";
                }
                else
                {
                    lbtnPRcount.Visible = false;
                    lbtnPRcount.Text = "There are " + lstPatientVisit.Count + " Health Packages remaining";
                }
            }
            if (InventoryLocationID == -1)
            {
                Department1.LoadLocationUserMap();
            }
        }
    }
}
