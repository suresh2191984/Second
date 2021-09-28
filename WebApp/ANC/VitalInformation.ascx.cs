using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;

public partial class ANC_VitalInformation : System.Web.UI.UserControl
{
    long PVID = 1;
    decimal sbp, dbp, pulse;

    protected void Page_Load(object sender, EventArgs e)
    {
        List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
        List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
        
        //ANCVitalInformation_BL ANCbl = new ANCVitalInformation_BL(base.ContextInfo);
        //ANCbl.getVitalInformationTrend(PVID, out lstPatientVitals, out lstPatientInvestigation);


    }
    public void loadVitalInformationTrend(string bGroup, List<PatientVitals> lstPatientVitals, List<InvestigationValues> lstInvestigationValues, decimal pWeightGained)
    {
        lblBloodGroup.Text = bGroup.ToString();
        lblWeightGain.Text = pWeightGained.ToString() + " <b>kg</b>";
        for (int i = 0; i < lstPatientVitals.Count; i++)
        {
            if (lstPatientVitals[i].VitalsName == "Pulse")
            {
                if (decimal.Parse(lstPatientVitals[i].VitalsValue.ToString()) != 0)
                {
                    pulse = decimal.Parse(lstPatientVitals[i].VitalsValue.ToString());
                    pulse = Math.Ceiling(pulse);
                    lblPR.Text = pulse.ToString();
                    //lblPR.Text = lstPatientVitals[i].VitalsValue.ToString();
                    lblUOM1.Text = lstPatientVitals[i].UOMCode.ToString();
                }
            }
            if (lstPatientVitals[i].VitalsName == "SBP")
            {
                if (decimal.Parse(lstPatientVitals[i].VitalsValue.ToString()) != 0)
                {
                    sbp = decimal.Parse(lstPatientVitals[i].VitalsValue.ToString());
                    sbp = Math.Ceiling(sbp);
                    lblSystolic.Text = sbp.ToString();
                }
                //lblSystolic.Text = lstPatientVitals[i].VitalsValue.ToString();
                lblUOM2.Text = lstPatientVitals[i].UOMCode.ToString();
            }
            if (lstPatientVitals[i].VitalsName == "DBP")
            {
                if (decimal.Parse(lstPatientVitals[i].VitalsValue.ToString()) != 0)
                {
                    dbp = decimal.Parse(lstPatientVitals[i].VitalsValue.ToString());
                    dbp = Math.Ceiling(dbp);
                    lblDiastolic.Text = dbp.ToString();
                }
                //lblDiastolic.Text = lstPatientVitals[i].VitalsValue.ToString();
                //lblUOM3.Text = lstPatientVitals[i].UOMDescription.ToString();
            }
            if (lstPatientVitals[i].VitalsName == "Weight")
            {
                if (lstPatientVitals[i].VitalsValue.ToString() != "0.00")
                {
                    lblWeight.Text = lstPatientVitals[i].VitalsValue.ToString();
                    lblUOM3.Text = lstPatientVitals[i].UOMCode.ToString();
                }
            }
            if (lstPatientVitals[i].VitalsName == "Temp")
            {
                if (lstPatientVitals[i].VitalsValue.ToString() != "0.00")
                {
                    lblTemp.Text = lstPatientVitals[i].VitalsValue.ToString();
                    lblUOM5.Text = lstPatientVitals[i].UOMCode.ToString();
                }
            }
        }
        for (int j = 0; j < lstInvestigationValues.Count; j++)
        {
            if (lstInvestigationValues[j].Name == "Urine albumin")
            {
                lblUrineAlbumin.Text = lstInvestigationValues[j].Value.ToString();

                if (lstInvestigationValues[j].UOMCode != null)
                {
                    lblUOM9.Text = lstInvestigationValues[j].UOMCode.ToString();
                }
            }
            if (lstInvestigationValues[j].Name == "HIV")
            {
                lblBloodSugar.Text = lstInvestigationValues[j].Value.ToString();
                if (lstInvestigationValues[j].UOMCode != null)
                {
                    lblUOM7.Text = lstInvestigationValues[j].UOMCode.ToString();
                }
            }
            if (lstInvestigationValues[j].Name == "Hemoglobin ")
            {
                lblHB.Text = lstInvestigationValues[j].Value.ToString();
                if (lstInvestigationValues[j].UOMCode != null)
                {
                    lblUOM6.Text = lstInvestigationValues[j].UOMCode.ToString();
                }
            }
            if (lstInvestigationValues[j].Name == "Urine sugar")
            {
                lblUrineSugar.Text = lstInvestigationValues[j].Value.ToString();
                if (lstInvestigationValues[j].UOMCode != null)
                {
                    lblUOM8.Text = lstInvestigationValues[j].UOMCode.ToString();
                }
            }
            if (lstInvestigationValues[j].Name == "BLOOD GROUP AND Rh Typing")
            {
                if ((bGroup == "") || (bGroup == null))
                {
                    lblBloodGroup.Text = lstInvestigationValues[j].Value.ToString();
                }
            }

        }
    }
}
