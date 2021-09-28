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
using System.IO;


public partial class Anesthesia_PrintAnesthesiaNotes : BasePage
{

     long patientID = -1;
    long patientVisitID = 0;
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadPatientDetails(sender,e);
    }



    protected void LoadPatientDetails(object sender, EventArgs e)
    {

        StringBuilder anesthesiaprescription = new StringBuilder();
        StringBuilder anesthesiaadvice = new StringBuilder();
        StringBuilder strvitals = new StringBuilder();
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        IP_BL objBL = new IP_BL(base.ContextInfo);
        List<AnesthesiaDetails> lstAnesthesiaDetails = new List<AnesthesiaDetails>();
        List<AnesthesiaType> lstAnesthesiaType = new List<AnesthesiaType>();
        List<Patient> lstPatient = new List<Patient>();
        List<Physician> lstPhysician = new List<Physician>();
        List<IPTreatmentPlan> lstIPTreatmentplan = new List<IPTreatmentPlan>();
        List<RoomDetails> lstRoomDetails = new List<RoomDetails>();
        List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
        List<PatientPrescription> lstPatientPrescription = new List<PatientPrescription>();
        List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();

        //bjneo.GetInpatientDetails(patientVisitID, lstPatient, lstIPAdmissionDetails);


        returnCode = objBL.GetAnesthesiaNotes(patientVisitID, out lstAnesthesiaDetails, out lstPatient, out lstIPTreatmentplan, out lstPhysician, out lstPatientVitals, out lstRoomDetails, out lstPatientPrescription, out lstPatientAdvice);
        if (lstAnesthesiaDetails.Count > 0)
        {
            lblAnesthesiaNotes.Text = lstAnesthesiaDetails[0].AnesthesiaNotes;

            string[] M = lstAnesthesiaDetails[0].AnesthesiaModes.ToString().Split('~');
            foreach (string i in M)
            {

                lblModeofanesthesia.Text += i + ",";
            }

            string[] s = lstAnesthesiaDetails[0].Complications.ToString().Split('~');
            foreach (string i in s)
            {
                lblcomplication.Text += i + ",";
            }

            lblNPODuration.Text = lstAnesthesiaDetails[0].NPODuration;
            lblscoringSystem.Text = lstAnesthesiaDetails[0].ScoringSystem;
            lblScoringValue.Text = lstAnesthesiaDetails[0].ScoreValue;
            lblAnesthesiaType.Text = lstAnesthesiaDetails[0].AnesthesiaType;
            lbltimeofanesthesia.Text = Convert.ToString(lstAnesthesiaDetails[0].EndTime);
            lbltimeofsurgery.Text = Convert.ToString(lstAnesthesiaDetails[0].EndTime);
        }
        if (lstPatient.Count > 0)
        {
            lblname.Text = lstPatient[0].Name;
            lblAge.Text = lstPatient[0].Age;
            lblIPNO.Text = lstPatient[0].IPNumber;
            lblPatientNO.Text = lstPatient[0].PatientNumber;

        }

        if (lstPhysician.Count > 0)
        {
            lblConsultant.Text = lstPhysician[0].PhysicianName;
            lblSurgeon.Text = lstPhysician[0].PhysicianName;
        }
        if (lstIPTreatmentplan.Count > 0)
        {

            lblsurgeryname.Text = lstIPTreatmentplan[0].ParentName;
            lbltimeofsurgery.Text = Convert.ToString(lstIPTreatmentplan[0].FromTime);


        }

        if (lstRoomDetails.Count > 0)
        {
            lblRoomNo.Text = lstRoomDetails[0].RoomName;
        }


        anesthesiaprescription.Append("<table align='left' width='90%'>");
        // Prescription details
        anesthesiaprescription.Append("<tr><td>");
        if (lstPatientPrescription.Count > 0)
        {
            anesthesiaprescription.Append("<table width='100%' style='border=1' > ");
            anesthesiaprescription.Append("<tr align='left' style='text-align:left;'>");
            //anesthesiaprescription.Append("<hr />");
            anesthesiaprescription.Append("<td colspan='6'><font size='2'><b>Drug Adminstrered</b></font></td>");
            anesthesiaprescription.Append("</tr>");
            //caseSheetLabel.Append("<tr>");

            for (int i = 0, j = 1; i < lstPatientPrescription.Count; i++, j++)
            {
                PatientPrescription pp = new PatientPrescription();
                pp = lstPatientPrescription[i];
                anesthesiaprescription.Append("<tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                anesthesiaprescription.Append("<td nowrap='nowrap'>" + j.ToString() + ". </td>");
                anesthesiaprescription.Append("<td nowrap='nowrap'>" + pp.Formulation + "</td>");
                anesthesiaprescription.Append("<td nowrap='nowrap'>" + pp.BrandName + "</td>");
                anesthesiaprescription.Append("<td nowrap='nowrap'>" + pp.Dose + "</td>");
                anesthesiaprescription.Append("<td nowrap='nowrap'>" + pp.DrugFrequency + "</td>");
                anesthesiaprescription.Append("<td nowrap='nowrap'>" + pp.Duration + "</td>");
                anesthesiaprescription.Append("<td nowrap='nowrap'>" + pp.Direction + "</td>");
                anesthesiaprescription.Append("<td nowrap='nowrap'>" + pp.Instruction + "</td>");
                anesthesiaprescription.Append("<td style='overflow:auto' >" + pp.ROA + "</td>");
                anesthesiaprescription.Append("</tr>");


            }
            anesthesiaprescription.Append("</table>");

        }

        anesthesiaprescription.Append("</td></tr>");
        anesthesiaprescription.Append("</table>");
        lblPrescription.Text = anesthesiaprescription.ToString();


        //Advice 

        if (lstPatientAdvice.Count > 0)
        {
            anesthesiaadvice.Append("<tr align='left' style='text-align:left;'><td>");
            anesthesiaadvice.Append("<table > ");
            anesthesiaadvice.Append("<tr align='left' style='text-align:left;'>");
            anesthesiaadvice.Append("<td><font size='2'><b>Advice</b></font></td>");
            anesthesiaadvice.Append("</tr>");
            for (int i = 0, j = 1; i < lstPatientAdvice.Count; i++, j++)
            {
                anesthesiaadvice.Append("<tr align='left' style='text-align:left;'><td>");
                //advice desc --G-Avoid Long Travel 
                if (lstPatientAdvice[i].Description.Split('-')[0] == "G")
                {
                    string GenAdv = lstPatientAdvice[i].Description.Split('-')[1];
                    anesthesiaadvice.Append(j.ToString() + "." + GenAdv);
                }
                else
                {
                    anesthesiaadvice.Append(j.ToString() + "." + lstPatientAdvice[i].Description);
                }

                anesthesiaadvice.Append("<tr align='left' style='text-align:left;'><td>");
            }
            anesthesiaadvice.Append("</table>");

            lbladvice.Text = anesthesiaadvice.ToString();

            anesthesiaadvice.Append("<hr />");
            anesthesiaadvice.Append("</td></tr>");
        }
        //Vitals 
        if (lstPatientVitals.Count > 0)
        {

            //"AnesthesiaBloodGas~PH~"--vitals type ---vitalsvalue
        //    strvitals .Append("<table> style ="">;
            strvitals.Append("<tr align='left' style='text-align:left;'><td>");

            //strvitals.Append("<table align='left' width='100%' > ");
            //strvitals.Append("<tr>");
            strvitals.Append("<td> Vitals Type </td> <td> Vital Name</td><td> Value</td>");

            //strvitals.Append("<tr>");
            //strvitals.Append("<tr align='left' style='text-align:left;'>");

          //  strvitals.Append("<td colspan='6'><font size='2'><b>VITALS</b></font></td>");
           // strvitals.Append("</tr><tr><td> ");
            //   strvitals .Append(""
            string[] vitalsvalue = lstPatientVitals[0].VitalsType.ToString().Split('~');

            foreach (var obj in lstPatientVitals)
            {
                strvitals.Append("<tr><td> ");
                var s = obj.VitalsType.Split('~');
                strvitals.Append("</td> ");
                strvitals.Append("<td> ");
                strvitals.Append(s[0].ToString());
                strvitals.Append("</td> ");
                strvitals.Append("<td> ");
                if (s.Length > 1)
                {
                    if (s[1].ToString() != null)
                    {
                        strvitals.Append(s[1].ToString());
                    }
                    else
                    {
                        strvitals.Append("-");
                    }
                }
                strvitals.Append("</td> ");
                strvitals.Append("<td> ");
                strvitals.Append(obj.VitalsValue.ToString());
                strvitals.Append("</td> ");
            }
            strvitals.Append("</tr>");
            strvitals.Append("</table>");
            strvitals.Append("</tr>");
          //   strvitals .Append("</table> );
            lblVitals.Text =strvitals.ToString();


        }
    }   
        
   
    protected void btnOK_Click(object sender, EventArgs e)
    {

    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {

    }
    protected void btnback_Click(object sender, EventArgs e)
    {

    }


    
   
}
