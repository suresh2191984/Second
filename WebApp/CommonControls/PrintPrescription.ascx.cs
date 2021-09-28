using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Text;
using Attune.Podium.Common;

public partial class CommonControls_PrintPrescription : BaseControl
{
    long visitID = 0;

    public long VisitID
    {
        get { return visitID; }
        set { visitID = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void LoadDetails(long patientVisitID)
    {
        
        StringBuilder caseSheetLabel = new StringBuilder();

        List<Patient> lstPatient = new List<Patient>();
       
        List<PatientPrescription> lstPatientPrescription = new List<PatientPrescription>();
        List<Physician> lstPhysician = new List<Physician>();
        Investigation_BL InvestionBL = new Investigation_BL(base.ContextInfo);

        InvestionBL.getPrintPrescription(patientVisitID,"", out lstPatient, out lstPhysician, out lstPatientPrescription);


        caseSheetLabel.Append("<table align='center' width='70%'>");
        caseSheetLabel.Append("<tr><td>");

        caseSheetLabel.Append("<table align='center' width='100%'>");
        caseSheetLabel.Append("<tr><td>");

        caseSheetLabel.Append(lstPatient[0].TitleName + " " + lstPatient[0].Name + " <br /> Patient No :" + lstPatient[0].PatientNumber + ",<br /> aged " + lstPatient[0].Age.ToString() + " years ");
        if (lstPatient[0].SEX == "M")
            caseSheetLabel.Append(" male,");
        else if (lstPatient[0].SEX == "F")
            caseSheetLabel.Append(" female,");

        caseSheetLabel.Append(" was found to have Diagnosed on ");
        caseSheetLabel.Append(lstPatient[0].DOB.ToLongDateString() + ".");
        if (lstPatient[0].SEX == "M")
            caseSheetLabel.Append("He");
        else if (lstPatient[0].SEX == "F")
            caseSheetLabel.Append("She");

        caseSheetLabel.Append(" is found to be compatible with the current course of treatment and hence, is being advised to continue the same.");
        //caseSheetLabel.Append("Adviced to continue the same treatment");
       
        caseSheetLabel.Append("</td></tr>");
        caseSheetLabel.Append("</table>");
        caseSheetLabel.Append("<hr />");

       
        // Patient Treatment details
        caseSheetLabel.Append("<tr><td>");
        if (lstPatientPrescription.Count > 0)
        {
            caseSheetLabel.Remove(0, caseSheetLabel.Length);

            caseSheetLabel.Append("<br />");
            caseSheetLabel.Append("<table align='center' width='70%'> ");
            caseSheetLabel.Append("<tr>");
            caseSheetLabel.Append("<td colspan='6'><br /> <br />" + "Name : " + lstPatient[0].TitleName + " " + lstPatient[0].Name + " <br /> Patient No :" + lstPatient[0].PatientNumber +  "<br />Date/Time : " + lstPatient[0].DOB  + " <br /></td>");
            //caseSheetLabel.Append("<td colspan='6'><br /> <br />" + "Date/Time : " + lstPatient[0].DOB  + " <br /> Visit Type :" + lstPatient[0].VisitType.ToString() + "</td>");
            caseSheetLabel.Append("</tr>");

            caseSheetLabel.Append("<tr>");
            //int page = Convert.ToInt32(lstPatient[0].PatientAge.Split(' ')[0]);
            //if (page > 0)
            //{
                caseSheetLabel.Append("<td colspan='6'>" + "Age : " + lstPatient[0].PatientAge.ToString() + "</td>");
            //}
            //else
            //{
                //string age = "-";
                //caseSheetLabel.Append("<td colspan='6'>" + "Age : " + age + "</td>");

            //}
            caseSheetLabel.Append("</tr>");
            caseSheetLabel.Append("<tr>");
            caseSheetLabel.Append("<tr>");
            caseSheetLabel.Append("<td colspan='6'>" + "<br />" + "</td>");
            caseSheetLabel.Append("</tr>");
            caseSheetLabel.Append("<tr>");
            if (lstPhysician.Count > 0)
            {
                caseSheetLabel.Append("<td colspan='6'>" + "Prescribed By : " + lstPhysician[0].PhysicianName + "</td>");
            }
            else
            {
                string phyName = "-";
                caseSheetLabel.Append("<td colspan='6'>" + "Prescribed By : " + phyName.ToString() + "</td>");
            }
            caseSheetLabel.Append("</tr>");
            caseSheetLabel.Append("<tr>");
            caseSheetLabel.Append("<td colspan='6'>" + "<br />" + "</td>");
            caseSheetLabel.Append("</tr>");
            caseSheetLabel.Append("<td colspan='6'><font size='2'><br /><ul>Prescription's<ul><br /><br /></font></td>");
            caseSheetLabel.Append("</tr>");
            caseSheetLabel.Append("<tr>");

            for (int i = 0, j = 1; i < lstPatientPrescription.Count; i++, j++)
            {
                PatientPrescription pp = new PatientPrescription();
                pp = lstPatientPrescription[i];
              
                caseSheetLabel.Append("<tr>");
                
                caseSheetLabel.Append("<td width='1%'>" + j.ToString() + ". </td>");
                caseSheetLabel.Append("<td width='3%'>" + pp.Formulation + "</td>");
                caseSheetLabel.Append("<td width='8%'>" + pp.BrandName + "</td>");
                caseSheetLabel.Append("<td width='5%'>" + pp.Dose + "</td>");
                caseSheetLabel.Append("<td width='5%'>" + pp.DrugFrequency + "</td>");
                caseSheetLabel.Append("<td width='4%'>" + pp.Duration + "</td>");
                caseSheetLabel.Append("<td width='5%'>" + pp.ROA + "</td>");
                caseSheetLabel.Append("<td width='5%'>" + pp.Instruction + "</td>");
                caseSheetLabel.Append("</tr>");
                caseSheetLabel.Append("<tr>");
                caseSheetLabel.Append("<td colspan='6'>" + "<br />" + "</td>");
                caseSheetLabel.Append("</tr>");


            }

            caseSheetLabel.Append("</table>");
          
        }
        else
        {
            caseSheetLabel.Remove(0, caseSheetLabel.Length);
            caseSheetLabel.Append("<table > ");
            caseSheetLabel.Append("<tr>");

            caseSheetLabel.Append("<td><font size='2'>" + "<%=Resources.ClientSideDisplayTexts.CommonControls_PrintPrescription_nopresavail %>" + "</font></td>");
            caseSheetLabel.Append("</tr>");
            caseSheetLabel.Append("</table>");
            caseSheetLabel.Append("<hr />");


        }

        caseSheetLabel.Append("</td></tr>");

        caseSheetLabel.Append("</td></tr>");
        caseSheetLabel.Append("</table>");
        caseSheetLabel.Append("</br>");


        lblPrescription.Text = caseSheetLabel.ToString();

       
    }
}
