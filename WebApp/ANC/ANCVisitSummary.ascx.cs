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

public partial class ANC_ANCVisitSummary : BaseControl
{
    long PID = 1;
    List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
    List<BackgroundProblem> lstBackgroundProblem = new List<BackgroundProblem>();
    List<PatientPastVaccinationHistory> lstPatientVaccinationHistory = new List<PatientPastVaccinationHistory>();

    protected void Page_Load(object sender, EventArgs e)
    {
        //ANCVitalInformation_BL ancbl = new ANCVitalInformation_BL(base.ContextInfo);
        //ancbl.pGetANCVisitSummary(PID, out lstANCPatientDetails, out lstBackgroundProblem, out lstPatientVaccinationHistory);
                

    }
    public void LoadVitalSummary(List<ANCPatientDetails> lstANCPatientDetails, List<BackgroundProblem> lstBackgroundProblem, List<PatientPastVaccinationHistory> lstPatientVaccinationHistory, List<PatientUltraSoundData> lstUSD)
    {
        if (lstANCPatientDetails.Count > 0)
        {
            if (lstANCPatientDetails[0].LMPDate != Convert.ToDateTime("01/01/0001"))
            {
                lblLMP.Text = lstANCPatientDetails[0].LMPDate.ToShortDateString();
                //lblGAge.Text = lstANCPatientDetails[0].NoOfWeeks + " Weeks";
            }
            if (Convert.ToInt32(lstANCPatientDetails[0].NoOfWeeks) > 0)
            {
                trGA.Visible = true;
                lblGAge.Text = lstANCPatientDetails[0].NoOfWeeks + " Weeks";
            }
            else
            {
                trGA.Style.Add("display", "none");
            }
            if (lstANCPatientDetails[0].EDD != Convert.ToDateTime("01/01/0001"))
            {
                lblEDD.Text = lstANCPatientDetails[0].EDD.ToShortDateString();
            }

            lblG.Text = lstANCPatientDetails[0].Gravida.ToString();
            lblP.Text = lstANCPatientDetails[0].Para.ToString();
            lblL.Text = lstANCPatientDetails[0].Live.ToString();
            lblA.Text = lstANCPatientDetails[0].Abortus.ToString();

            if ((lstANCPatientDetails[0].GPLAOthers != "") && (lstANCPatientDetails[0].GPLAOthers != null))
            {
                lblGPALOthers.Text = lstANCPatientDetails[0].GPLAOthers.ToString();
            }
            else
            {
                //trOthers.Visible = false;
                trOthers.Style.Add("display", "none");
            }
        }
        if (lstPatientVaccinationHistory.Count > 0)
        {
            repVaccinationStatus.DataSource = lstPatientVaccinationHistory;
            repVaccinationStatus.DataBind();
        }
        else
        {
            lblVacStatus.Visible = false;
        }

        if (lstBackgroundProblem.Count > 0)
        {
            repBackgroundProblem.DataSource = lstBackgroundProblem;
            repBackgroundProblem.DataBind();
        }
        else
        {
            lblBgp.Visible = false;
        }

        if (lstUSD.Count > 0)
        {
            lblNoofFoetus.Text = lstUSD[0].MultipleGestation.ToString();
            List<PatientUltraSoundData> lstUSD1 = new List<PatientUltraSoundData>();
            foreach (PatientUltraSoundData obj in lstUSD)
            {
                PatientUltraSoundData obj1 = new PatientUltraSoundData();
                if (obj.DateOfUltraSound.ToShortDateString() != "01/01/0001")
                {
                    //obj1.DateOfUltraSound = obj.DateOfUltraSound;
                    obj1.USDate = obj.DateOfUltraSound.ToString("dd/MM/yy");
                }
                else
                {
                    obj1.USDate = "";
                }
                obj1.GAge = obj.GAge;
                obj1.PlacentalPosition = obj.PlacentalPosition;
                lstUSD1.Add(obj1);
                
            }
            repScan.DataSource = lstUSD1;
            repScan.DataBind();
        }
        else
        {
            trNoofGes.Visible = false;
            lblScanReport.Visible = false;
        }
    }
}
