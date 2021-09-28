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


public partial class Nurse_PrintProgressiveNotes : BasePage
{

    long patientID = -1;
    long patientVisitID = 0;
    long returnCode = -1;
    decimal wt = 0, Ht = 0, bmi = 0;
    public decimal sbp1;
    List<ProgressiveTemplate> lstProgressiveTemplate = new List<ProgressiveTemplate>();
    List<PatientProgressive> lstPatientProgrssive = new List<PatientProgressive>();
    Patient_BL objPatient_BL;
    StringBuilder ProgressiveLabel = new StringBuilder();
    protected void Page_Load(object sender, EventArgs e)
    {
          objPatient_BL = new Patient_BL(base.ContextInfo);
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        patientHeader.PatientID = patientID;
        patientHeader.PatientVisitID = patientVisitID;
        patientHeader.ShowVitalsDetails();

       
        LoadPatientDetails(sender, e);
       
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        List<Patient> lstpatient = new List<Patient>();
        List<VitalsUOMJoin> lstpv = new List<VitalsUOMJoin>();

        patientBL.GetPatientVitals(patientVisitID, patientID, OrgID, out lstpatient, out lstpv);
        decimal sbp, dbp, pulse, weight, Height;

        ProgressiveLabel.Append("<table width='100%'>");
        ProgressiveLabel.Append("<tr>");
        ProgressiveLabel.Append("<td colspan='6'><font size='2';font-names='verdana'><b>Patient Vitals</b></font></td>");
        ProgressiveLabel.Append("</tr><tr><td style='font-weight:normal;'>");

        for (int i = 0; i < lstpv.Count; i++)
        {
            if (lstpv[i].VitalsName == "SBP")
            {
                if (lstpv[i].VitalsValue != 0)
                {
                    sbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                    sbp = Math.Ceiling(sbp);
                    sbp1 = sbp;
                }
            }
            if (lstpv[i].VitalsName == "DBP")
            {
                if (lstpv[i].VitalsValue != 0)
                {
                    dbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                    dbp = Math.Ceiling(dbp);
                    if (sbp1 != 0)
                    {
                        ProgressiveLabel.Append("BP : " + sbp1 + "/" + dbp.ToString() + " " + lstpv[i].UOMCode + ", ");
                    }
                    else
                    {
                        ProgressiveLabel.Append("BP : " + "-/" + dbp.ToString() + " " + lstpv[i].UOMCode + ", ");
                    }
                }
                else if (sbp1 != 0)
                {
                    ProgressiveLabel.Append("BP : " + sbp1 + "/-" + lstpv[i].UOMCode + ", ");
                }
            }
            if (lstpv[i].VitalsName == "Temp")
            {
                if (lstpv[i].VitalsValue != 0)
                {
                    ProgressiveLabel.Append("Temp : " + lstpv[i].VitalsValue.ToString() + " " + lstpv[i].UOMCode + ", ");
                }
            }
            if (lstpv[i].VitalsName == "Weight")
            {
                if (lstpv[i].VitalsValue != 0)
                {
                    weight = decimal.Parse(lstpv[i].VitalsValue.ToString());
                    weight = Math.Ceiling(weight);
                    wt = weight;
                    ProgressiveLabel.Append("Weight : " + weight + " " + lstpv[i].UOMCode + ", ");
                }
            }
            if (lstpv[i].VitalsName == "Height")
            {
                if (lstpv[i].VitalsValue != 0)
                {
                    Height = decimal.Parse(lstpv[i].VitalsValue.ToString());
                    Height = Math.Ceiling(Height);
                    Ht = Height;
                    ProgressiveLabel.Append("Height : " + Height + " " + lstpv[i].UOMCode + ", ");
                }
            }
            if (lstpv[i].VitalsName == "Pulse")
            {
                if (lstpv[i].VitalsValue != 0)
                {
                    pulse = decimal.Parse(lstpv[i].VitalsValue.ToString());
                    pulse = Math.Ceiling(pulse);
                    ProgressiveLabel.Append("Pulse : " + pulse + " " + lstpv[i].UOMCode + ", ");
                }
            }
        }
        if (Ht > 0 && wt > 0)
        {
            decimal HtInMtrs = (Ht / 100);
            bmi = (wt / (HtInMtrs * HtInMtrs));
            ProgressiveLabel.Append("BMI : " + bmi.ToString("#.##") + ", ");

        }
        ProgressiveLabel.Append(".</td></tr>");
        ProgressiveLabel.Append("</table>");

       

        ProgressiveLabel.Append("</td></tr>");
        ProgressiveLabel.Append("</table>");
        lblVitals.Text = ProgressiveLabel.ToString();
        LoadPatientProgrssive(sender, e);



    }




    protected void btnOK_Click(object sender, EventArgs e)
    {

    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {

    }


    public void LoadPatientProgrssive(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        List<PatientProgressive> lstPatientProgrssive = new List<PatientProgressive>();
        Title_BL objtitleBL = new Title_BL(base.ContextInfo);
        objtitleBL.GetProgessiveNotes(patientVisitID, out lstPatientProgrssive);


        for (int i = 0; i < lstPatientProgrssive.Count; i++)
        {

            ProgressiveLabel.Append("<br><table width='100%'>");
            ProgressiveLabel.Append("<tr><td align='Left' style='font-weight: bold;font-names='verdana'>");
            ProgressiveLabel.Append("Case Seen By :" +"</td >");
            ProgressiveLabel.Append("</tr>");
            ProgressiveLabel.Append("<tr>");
            ProgressiveLabel.Append("<td style='font-weight:normal;'>" + lstPatientProgrssive[i].PhysicianName);
            ProgressiveLabel.Append("</tr></td>");
            ProgressiveLabel.Append("</table>");

            ProgressiveLabel.Append("<br><table width='100%'>");
            ProgressiveLabel.Append("<tr><td align='Left' style='font-weight: bold;'>");
            ProgressiveLabel.Append("Subjective:"+"</td >");
            ProgressiveLabel.Append("</tr>");
            ProgressiveLabel.Append("<tr>");
            ProgressiveLabel.Append("<td style='font-weight:normal;' >" + lstPatientProgrssive[i].Subjective);
            ProgressiveLabel.Append("</tr></td>");
            ProgressiveLabel.Append("</table>");

            ProgressiveLabel.Append("<br><table width='100%'>");
            ProgressiveLabel.Append("<tr><td align='Left' style='font-weight: bold;'>");
            ProgressiveLabel.Append("Objective:" +"</td>");
            ProgressiveLabel.Append("</tr>");
            ProgressiveLabel.Append("<tr>");
            ProgressiveLabel.Append("<td style='font-weight:normal;' >" + lstPatientProgrssive[i].Objective);
            ProgressiveLabel.Append("</tr></td>");
            ProgressiveLabel.Append("</table>");

            ProgressiveLabel.Append("<br><table width='100%'>");
            ProgressiveLabel.Append("<tr><td align='Left' style='font-weight: bold;'>");
            ProgressiveLabel.Append("Assesment:"  +"</td>");
            ProgressiveLabel.Append("</tr>");
            ProgressiveLabel.Append("<tr>");
            ProgressiveLabel.Append("<td style='font-weight:normal;' >" + lstPatientProgrssive[i].Assesment);
            ProgressiveLabel.Append("</tr></td>");
            ProgressiveLabel.Append("</table>");

            ProgressiveLabel.Append("<br><table width='100%'>");
            ProgressiveLabel.Append("<tr><td align='Left' style='font-weight: bold;'>");
            ProgressiveLabel.Append("Planning:"+"</td>");
            ProgressiveLabel.Append("</tr>");
            ProgressiveLabel.Append("<tr>");
            ProgressiveLabel.Append("<td style='font-weight:normal;' >" + lstPatientProgrssive[i].Planning);
            ProgressiveLabel.Append("</tr></td>");
            ProgressiveLabel.Append("</table>");
            ProgressiveLabel .Append("<hr>");
        }


        lblVitals.Text = ProgressiveLabel.ToString();
        lblCSB.Text = lstPatientProgrssive[0].PhysicianName;
        lblreviewdate.Text =lstPatientProgrssive[0].DateandTimeofCaseReview.ToString();



    }
    protected void LoadPatientDetails(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Neonatal_BL  objneo = new Neonatal_BL(base.ContextInfo);
        List<Patient> lstPatient = new List<Patient>();
        List<InPatientAdmissionDetails> lstIPAdmissionDetails;

      //bjneo.GetInpatientDetails(patientVisitID, lstPatient, lstIPAdmissionDetails);


        returnCode = new Neonatal_BL(base.ContextInfo).GetInpatientDetails(patientVisitID, out lstPatient, out lstIPAdmissionDetails);
        if (lstPatient.Count > 0)
        {
            lblname.Text = lstPatient[0].Name;
            lblPNo.Text = lstPatient[0].PatientNumber;
            lblAge.Text = lstPatient[0].Age + "/" + lstPatient[0].SEX;
            lbladdress.Text = lstPatient[0].Add1 + "," + lstPatient[0].Add2 + "," + lstPatient[0].Add3;
            lblPrimaryDoctor.Text = lstPatient[0].PrimaryPhysician;
        }
        if(lstIPAdmissionDetails.Count>0)
        {
            lblpurposeadmission.Text = lstIPAdmissionDetails[0].ServiceProviderName;
            lbladmitdoctor.Text = lstIPAdmissionDetails[0].ConsultingSurgeonName;
            lblDOA.Text = lstIPAdmissionDetails[0].AdmissionDate.ToString();
            lblDOD.Text = lstIPAdmissionDetails[0].AdmissionDate.ToString();
        }

       
      
       // lblPatientDetail.Text = "";
        //if (lstPatient.Count > 0)
        //{
        //    ProgressiveLabel.Append("<table width='100%'>");
        //    ProgressiveLabel.Append("<tr>");
        //    ProgressiveLabel.Append("<td colspan='6'><font size='2'><b>Patient Details</b></font></td>");
        //    ProgressiveLabel.Append("</tr><tr><td style='font-weight:normal;'>");
        //    ProgressiveLabel.Append("Patient Name:" + lstPatient[0].Name);
        //    ProgressiveLabel.Append("</td>");
        //    ProgressiveLabel.Append("</tr><tr><td style='font-weight:normal;'>");
        //    ProgressiveLabel.Append("PatientNumber:" + lstPatient[0].PatientNumber);
        //    ProgressiveLabel.Append("</td>");
        //    ProgressiveLabel.Append("</tr><tr><td style='font-weight:normal;'>");
        //    ProgressiveLabel.Append("Age/Sex:" + lstPatient[0].Age + "<br>" + "/" + lstPatient[0].SEX);
        //    ProgressiveLabel.Append("</td>");
        //    ProgressiveLabel.Append("</tr><tr><td style='font-weight:normal;'>");
        //    ProgressiveLabel.Append("</td>");
        //    ProgressiveLabel.Append("</tr><tr><td style='font-weight:normal;'>");
        //    ProgressiveLabel.Append("Address:" + lstPatient[0].Add1 + "," + lstPatient[0].Add2 + "," + lstPatient[0].Add3);
        //    ProgressiveLabel.Append("</td>");
        //    ProgressiveLabel.Append("</tr><tr><td style='font-weight:normal;'>");
        //    ProgressiveLabel.Append("</td>");
        //}

        //if (lstIPAdmissionDetails.Count > 0)
        //{

        //    ProgressiveLabel.Append("<table width='100%'>");
        //    ProgressiveLabel.Append("<tr>");
        //    ProgressiveLabel.Append("<td colspan='6'><font size='2'><b>Patient Details</b></font></td>");
        //    ProgressiveLabel.Append("</tr><tr><td style='font-weight:normal;'>");
        //    ProgressiveLabel.Append("Admission Date:" + lstIPAdmissionDetails[0].AdmissionDate);
        //    ProgressiveLabel.Append("</td>");
        //    ProgressiveLabel.Append("</tr><tr><td style='font-weight:normal;'>");
        //    ProgressiveLabel.Append("Primary Doctor:" + lstIPAdmissionDetails[0].ConsultingSurgeonName);
        //    ProgressiveLabel.Append("</td>");
        //    ProgressiveLabel.Append("</tr><tr><td style='font-weight:normal;'>");
        //    ProgressiveLabel.Append("Purpose Of Admission:" + lstIPAdmissionDetails[0].ServiceProviderName);
        //    ProgressiveLabel.Append("</td>");
        //    ProgressiveLabel.Append("</tr><tr><td style='font-weight:normal;'>");

        //    ProgressiveLabel.Append("</td>");
        //    ProgressiveLabel.Append("</tr><tr><td style='font-weight:normal;'>");
        //    ProgressiveLabel.Append("Date of Discharge" + lstIPAdmissionDetails[0].ConsultingSurgeonName);
        //    ProgressiveLabel.Append("</td>");
        //    ProgressiveLabel.Append("</tr><tr><td style='font-weight:normal;'>");

        //    ProgressiveLabel.Append("</td>");
        //    lblPatientDetail.Text = ProgressiveLabel.ToString();
     

        //}
   

    }
    protected void btnback_Click(object sender, EventArgs e)
    {
        patientID = Convert.ToInt32(Request.QueryString["PID"]);
        patientVisitID = Convert.ToInt32(Request.QueryString["VID"]);
        Response.Redirect("PatientVitals.aspx?pid=" + patientID + "&vid=" + patientVisitID, true);
    }


}
          

              
        

   
      


