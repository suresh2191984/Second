using System;
using System.Collections;
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
using System.Collections.Generic;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class CommonControls_PrintPatientRegistration : BaseControl
{
    long patientID = -1;
    long returnCode = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadData();
        }
    }

    public void LoadData()
    {
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        List<Patient> lstPatient = new List<Patient>();
        List<PatientAddress> lstPatientAddress = new List<PatientAddress>();
        List<PatientAllergies>lstPatientAllergies=new List<PatientAllergies>();
        try
        {
            returnCode = new Patient_BL(base.ContextInfo).GetPatientRegDetails(0, patientID, out lstPatient, out lstPatientAddress, out lstPatientAllergies);
            if (lstPatient.Count > 0 )
            {
                List<Organization> lstOrganization = new List<Organization>();
                long lresult = new SharedInventory_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
                lblOrganizationName.Text = OrgName;
                lblOrgAddress.Text = lstOrganization[0].Address + lstOrganization[0].City + "<br> Phone : " + lstOrganization[0].PhoneNumber;// OrgName.ToString();
                lblName.Text = lstPatient[0].Name;
                //lblAge.Text = lstPatient[0].Age;
                lblSex.Text = (lstPatient[0].SEX == "M") ? "Male" : "Female";
                lblMRDNo.Text = lstPatient[0].URNO;
                //lblDateTime.Text = Convert.ToDateTime(lstPatient[0].CreatedAt).ToString("dd/MM/yyyy hh:mm tt");
                string add = "",tempadd="";
                add = lstPatient[0].Address.Replace(","," ").Trim();
                tempadd = add.ToString().Replace("    ", "");
                tempadd = tempadd.ToString().Replace("  ", ",");

                lblAddress.Text = tempadd.ToString();
                lbladd3.Text = lstPatientAddress[0].Add3.ToString();
                lbladd2.Text = lstPatientAddress[0].Add1.ToString();
                lbladd1.Text = lstPatientAddress[0].Add2.ToString();
                lblCity.Text = lstPatientAddress[0].City.ToString();
                lblProvince.Text = lstPatient[0].StateName;
                lblCitizanorCountry.Text = lstPatient[0].CountryName.ToString();
                lblIDNo.Text = "";
                lblPlaceofbirth.Text = lstPatient[0].PlaceOfBirth.ToString();
                lblDOB.Text = lstPatient[0].DOB.ToString();
                lblReligion.Text = lstPatient[0].Religion;
                lblOccupation.Text = lstPatient[0].OCCUPATION;
                lblALLERGY.Text = "";
                for (int i = 0; i < lstPatientAllergies.Count; i++)
                {
                    lblALLERGY.Text += lstPatientAllergies[i].AllergyName + "<br/>";
                }
                lblPostalCode.Text = lstPatientAddress[0].PostalCode.ToString();

                if (lstPatientAddress[0].LandLineNumber != "")
                {
                    lblTelephone.Text = lstPatientAddress[0].LandLineNumber.ToString();
                }
                else if (lstPatientAddress[0].MobileNumber != "")
                {
                    lblTelephone.Text = lstPatientAddress[0].MobileNumber.ToString();
                }
                else
                {

                    lblTelephone.Text = "";
                }


                //lblTelephone.Text = lstPatientAddress[0].LandLineNumber.ToString() + "/" + lstPatientAddress[0].MobileNumber.ToString();

                //if (lstPatient[0].MartialStatus == "S")
                //{
                //    lblMaritalStatus.Text = "Single";
                //}
                //else if(lstPatient[0].MartialStatus == "M")
                //{
                //    lblMaritalStatus.Text = "Married";
                //}
                //else
                //{
                //    lblMaritalStatus.Text = lstPatient[0].MartialStatus.ToString();
                //}
               // lblMaritalStatus.Text = lstPatient[0].MartialStatus.ToString();

               
                if (lstPatient[0].RelationName != "" && lstPatient[0].RelationName != null)
                {
                    if (lstPatient[0].RelationContactNo != "" && lstPatient[0].RelationContactNo != null)
                    {
                        lblRelativeAddress.Text = lstPatient[0].RelationName.ToString() + "," + lstPatient[0].RelationContactNo.ToString();
                    }
                    else
                    {
                        lblRelativeAddress.Text = lstPatient[0].RelationName.ToString();
                    }
                }
                else if (lstPatient[0].RelationContactNo != "" && lstPatient[0].RelationContactNo != null)
                {
                    lblRelativeAddress.Text = lstPatient[0].RelationContactNo.ToString();
                }
                else
                {
                    lblRelativeAddress.Text = "----";
                }
                

                //lblAddress.Text = lstPatient[0].Address;
                
                //lblMobile.Text = (lstPatient[0].MobileNumber == "") ? "N.A" : lstPatient[0].MobileNumber;
                //lblLLNo.Text = (lstPatient[0].LandLineNumber == "") ? "N.A" : lstPatient[0].LandLineNumber;

                //lblRefDoctor.Text = ((lstPatient[0].ReferingPhysicianName == "") || (lstPatient[0].ReferingPhysicianName == null)) ? "N.A" : lstPatient[0].ReferingPhysicianName;
               // lblRefPhySpeciality.Text = ((lstPatient[0].ReferingSpecialityName == "") || (lstPatient[0].ReferingSpecialityName == null)) ? "N.A" : lstPatient[0].ReferingSpecialityName;

                //lblConsultant.Text = ((lstPatient[0].PhysicianName == "") || (lstPatient[0].PhysicianName == null)) ? "N.A" : lstPatient[0].PhysicianName;
               // lblRefPhySpeciality.Text = ((lstPatient[0].SpecialityName == "") || (lstPatient[0].SpecialityName == null)) ? "N.A" : lstPatient[0].SpecialityName;

                //if (lblConsultant.Text != "N.A")
                //{
                //    lblConsultant.Text = "Dr. " + lblConsultant.Text;
                //}
                //if (lblConsultant.Text == "N.A")
                //{
                //    lblConsultant.Text = "-";
                //}
                //if (lblRefPhySpeciality.Text == "N.A")
                //{
                //    lblRefPhySpeciality.Text = "-";
                //}
                //if (lblRefDoctor.Text != "N.A")
                //{
                //    lblRefDoctor.Text = "Dr. " + lblRefDoctor.Text;
                //}

                lblCitizanorCountry.Text = ((Convert.ToString(lstPatient[0].Nationality) == "") || (Convert.ToString(lstPatient[0].Nationality) == null)) ? "N.A" : Convert.ToString(lstPatient[0].Nationality);

                //lblRelationName.Text = ((lstPatient[0].RelationName == "") || (lstPatient[0].RelationName == null)) ? "N.A" : lstPatient[0].RelationName;
                if (lstPatient[0].MartialStatus == "S")
                {
                    lblMaritalStatus.Text = "Single";
                }
                if (lstPatient[0].MartialStatus == "M")
                {
                    lblMaritalStatus.Text = "Married";
                }
                if (lstPatient[0].MartialStatus == "D")
                {
                    lblMaritalStatus.Text = "Divorced";
                }
                if (lstPatient[0].MartialStatus == "W")
                {
                    lblMaritalStatus.Text = "Widow";
                }

                //lblVisitType.Text = lstPatient[0].VisitType;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Loading PatientRegistrationDetails", ex);
        }
    }
}
