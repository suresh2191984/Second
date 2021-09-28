using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;

public partial class PatientAccess_PatientDetails : BasePage
{

    public PatientAccess_PatientDetails()
        : base("PatientAccess\\PatientDetails.aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            cAdsame.Attributes.Add("onclick", "toggle('CAD','" + cAdsame.ClientID.ToString() + "');");
            LoadURNtype();
            PopulatePatientDetails(LID);

        }
    }
    private void LoadURNtype()
    {
        try
        {
            long returnCode = -1;
            Patient_BL pBL = new Patient_BL(base.ContextInfo);
            List<URNTypes> objURNTypes = new List<URNTypes>();
            List<URNof> objURNof = new List<URNof>();
            returnCode = pBL.GetURNType(out objURNTypes, out objURNof);
            Salutation selectedSalutation = new Salutation();

            if (returnCode == 0)
            {
                ddlUrnType.DataSource = objURNTypes;
                ddlUrnType.DataTextField = "URNType";
                ddlUrnType.DataValueField = "URNTypeId";
                ddlUrnType.DataBind();

                ddlUrnType.Items.Insert(0, "--Select--");
                ddlUrnType.Items[0].Value = "0";

                ddlUrnoOf.DataSource = objURNof;
                ddlUrnoOf.DataTextField = "URNOf";
                ddlUrnoOf.DataValueField = "URNOfId";
                ddlUrnoOf.DataBind();

                ddlUrnoOf.Items.Insert(0, "--Select--");
                ddlUrnoOf.Items[0].Value = "0";
            }

            else
            {
                CLogger.LogWarning("Salutation cannot be retrieved");
                //edisp.Visible = true;
                //ErrorDisplay1.ShowError = true;
                //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in patient registration.Message:", ex);
            //edisp.Visible = true;
            //ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }

    }
    private void PopulatePatientDetails(long LID)
    {
        Patient_BL pBL = new Patient_BL(base.ContextInfo);
        List<Patient> patients = new List<Patient>();
          List<PatientAddress> lstPatientAddress = new List<PatientAddress>();
          List<PatientAllergies> lstPatientAllergies = new List<PatientAllergies>();
        Patient patient = new Patient();
        try
        {

            pBL.GetPatientRegDetails(LID, 0, out patients, out lstPatientAddress, out lstPatientAllergies);
            if (patients.Count > 0)
                patient = patients[0];

            string[] idMarks = patient.PersonalIdentification.Split('~');
            if (idMarks.Length > 0)
            {
                if (idMarks[0] != null)
                    txtIdentification1.Text = idMarks[0];
                lblIdMarks1.Text = idMarks[0];
            }
            if (idMarks.Length > 1)
            {
                if (idMarks[1] != null)
                    txtIdentification2.Text = idMarks[1];
                lblIdMarks2.Text = idMarks[0];
            }


            txtEmail.Text = patient.EMail;


            string temp = patient.DOB.ToShortDateString().ToString();

            txtRelation.Text = patient.RelationName;
            txtOccupation.Text = patient.OCCUPATION;
            ddMarital.SelectedValue = patient.MartialStatus;
            txtReligion.Text = patient.Religion;
            ddSex.SelectedValue = patient.SEX;
            txtPlaceOfBirth.Text = patient.PlaceOfBirth;
            txtURNo.Text = patient.URNO;
            ddlUrnoOf.SelectedValue = patient.URNofId.ToString();
            ddlUrnType.SelectedValue = patient.URNTypeId.ToString();
            ddBloodGrp.SelectedValue = patient.BloodGroup;
            PatientAddress cAddress = new PatientAddress();
            PatientAddress pAddress = new PatientAddress();

            if (patient.PatientAddress[0].AddressType == "C")
            {
                cAddress = patient.PatientAddress[0];
                pAddress = patient.PatientAddress[1];
            }
            else
            {
                cAddress = patient.PatientAddress[1];
                pAddress = patient.PatientAddress[0];
            }
            string add1 = "";
            string add2 = "";

            ucCAdd.SetAddress(cAddress);
            ucPAdd.SetAddress(pAddress);

            add1 = ucPAdd.GetAddressDetails(pAddress);
            add2 = ucPAdd.GetAddressDetails(cAddress);

            lblAddress1.Text = add1;
            lblAddress2.Text = add2;




            #region ViewDetails
            lblEMail.Text = patient.EMail;
            lblFather.Text = patient.RelationName;
            lblOccupation.Text = patient.OCCUPATION;
            lblMaritalStatus.Text = ddMarital.SelectedItem.Text;
            lblSex.Text = ddSex.SelectedItem.Text;
            lblReligion.Text = patient.Religion;
            lblPlaceOfBirth.Text = patient.PlaceOfBirth;
            lblUrNo.Text = patient.URNO;
            lblURNof.Text = ddlUrnoOf.SelectedItem.Text;
            lblURNType.Text = ddlUrnType.SelectedItem.Text;

            if (ddBloodGrp.SelectedValue != "-1")
            {
                lblBloodGroup.Text = ddBloodGrp.Text;
            }
            else
            {
                lblBloodGroup.Text = "--";
            }
            #endregion




        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing PopulatePatientDetails", ex);
        }
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = 0;
            Int16 age = 0;
            DateTime DOB = new DateTime();
            Patient patient = new Patient();
            int cnt = 0;
            List<PatientAddress> pAddresses = new List<PatientAddress>();
            patient.PersonalIdentification = txtIdentification1.Text.Trim();
            patient.PersonalIdentification += "~" + txtIdentification2.Text.Trim();
            patient.AlternateContact = "";
            patient.EMail = txtEmail.Text.Trim();
            patient.Age = age.ToString();
            patient.RelationName = txtRelation.Text.Trim();
            patient.OCCUPATION = txtOccupation.Text.Trim();
            patient.MartialStatus = ddMarital.SelectedValue;
            patient.Religion = txtReligion.Text.Trim();
            patient.SEX = ddSex.SelectedValue;
            patient.PlaceOfBirth = txtPlaceOfBirth.Text.Trim();
            patient.BloodGroup = ddBloodGrp.SelectedValue;
            patient.URNO = txtURNo.Text.Trim();
            pAddresses.Add(ucCAdd.GetAddress());
            pAddresses.Add(ucPAdd.GetAddress());
            patient.PatientAddress = pAddresses;
            long tempaddrid = patient.PatientAddress[0].AddressID;

            Patient_BL patientBL = new Patient_BL(base.ContextInfo);

            returnCode = patientBL.UpdateRegPatient(patient, LID);

            if (returnCode == -1)
            {
               // ErrorDisplay1.ShowError = true;
               // ErrorDisplay1.Status = "Error while Update patient details.Please try after some time.";
            }
            else
            {
                PopulatePatientDetails(LID);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving patient details.", ex);
            //edisp.Visible = true;
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in Update patient details. Please contact system administrator";
        }
    }
}