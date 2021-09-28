using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
public partial class Physician_PatientDetails : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PatientVitals_BL patientVitalsBL = new PatientVitals_BL(base.ContextInfo);
            List<VitalsUOMJoin> patientVitals = new List<VitalsUOMJoin>();
            long returnCode = -1;
            returnCode = patientVitalsBL.GetPatientVitals(1, 1, out patientVitals);
            foreach (VitalsUOMJoin vitals in patientVitals)
            {
                ListItem li = new ListItem();
                li.Text = vitals.VitalsName + ": " + vitals.VitalsValue.ToString() + " " + vitals.UOMCode;
                li.Attributes.Add("class", "Reportheader");
                vit.Items.Add(li);
            }


        }
    }
}
