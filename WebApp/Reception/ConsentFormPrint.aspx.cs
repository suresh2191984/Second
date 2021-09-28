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
using System.Collections.Specialized;
using System.Text;
using Attune.Podium.Common;

public partial class Reception_ConsentFormPrint : BasePage 
{

    long visitID = 0;
    public long VisitID
    {
        get { return visitID; }
        set { visitID = value; }
    }

    long patientID = 0;
    public long PatientID
    {
        get { return patientID; }
        set { patientID = value; }
    }


    long returnCode = -1;
    List<Patient> lstPatient = new List<Patient>();
    Patient_BL patientBL ;
    protected void Page_Load(object sender, EventArgs e)
    {
         patientBL = new Patient_BL(base.ContextInfo);
       Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);

        returnCode = patientBL.GetPatientDemoandAddress(patientID, out lstPatient);
        if (lstPatient.Count > 0)
        {
            lblNameValue.Text = lstPatient[0].Name;
            lblAgeOrSexValue.Text = lstPatient[0].Age + "/" + lstPatient[0].SEX;
            lblPnovalue.Text = lstPatient[0].PatientNumber;
            lbladdressvalue.Text = lstPatient[0].PatientAddress[0].Add1;
            lblcontactNovalue.Text = lstPatient[0].PatientAddress[0].MobileNumber;


        }
        List<ConsentLetters> lstLettres = new List<ConsentLetters>();
        long TypeID =0;
        new Referrals_BL(base.ContextInfo).GetConsentletters(visitID,TypeID,out lstLettres);
        if (lstLettres.Count() > 0)
        {

            lblConsentForm.Text = lstLettres[0].ConsentLetterAfterSign.ToString();
        }


    }
    protected void btnOk_Click(object sender, EventArgs e)
    {

    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {
    //s    ClientScript.RegisterStartupScript(Page.GetType(), "openPopUp", "javascript:popupprint();", true); 
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {

    }
}
