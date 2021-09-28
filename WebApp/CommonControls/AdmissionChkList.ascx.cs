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

public partial class CommonControls_AdmissionChkList : BaseControl
{
    long patientID = -1;
    long visitID = -1;
    long returnCode = -1;
    string EmergencyContact;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["vid"], out visitID);
            List<Patient> lstPatient = new List<Patient>();
            try
            {
                returnCode = new IP_BL(base.ContextInfo).GetInPatientRegDetail(patientID, visitID, out lstPatient);
                if (lstPatient.Count > 0)
                {
                    #region Existing IP Details

                    //lblOrgName.Text = OrgName.ToString();
                    //lblName.Text = lstPatient[0].Name;
                    //lblDOB.Text = lstPatient[0].DOB.ToShortDateString();
                    //lblPatientNumber.Text = lstPatient[0].PatientNumber;
                    //lblAge.Text = lstPatient[0].Age;
                    //lblSex.Text = (lstPatient[0].SEX == "M") ? "Male" : "Female";
                    //lblBloodGroup.Text = (lstPatient[0].BloodGroup == "-1") ? "-" : lstPatient[0].BloodGroup;

                    //lblAdmissionDate.Text = lstPatient[0].AdmissionDate.ToShortDateString();
                    //lblAccBy.Text = lstPatient[0].AccompaniedBy;

                    //lblRelation.Text = lstPatient[0].RelationshipID;
                    //lblRelContactNo.Text = lstPatient[0].RelationContactNo;

                    //lblEmergencyCNo.Text = lstPatient[0].ContactNo;

                    //lblPOA.Text = lstPatient[0].PurposeOfAdmissionName;
                    //lblCondition.Text = lstPatient[0].Condition;
                    //lblPrimaryPhysician.Text = lstPatient[0].PrimaryPhysician;
                    //lblConsultingSurgeon.Text = lstPatient[0].ConsultingSurgeon;
                    //lblSpecialityName.Text = lstPatient[0].SpecialityName;


                    //lblKnowledgeOfServiceName.Text = lstPatient[0].KnowledgeOfServiceName;
                    //lblServiceProviderName.Text = lstPatient[0].ServiceProviderName;
                    //lblInformationBy.Text = lstPatient[0].InformationBy;

                    //lblIPNo.Text = lstPatient[0].IPNumber;

                    #endregion

                    string primaryConsultant = string.Empty;

                    #region New IP Details
                    List<PrimaryConsultant> lstPrimaryConsultant = new List<PrimaryConsultant>();
                    List<Organization> lstOrganization = new List<Organization>();
                   
                    long lresult = new SharedInventory_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);

                    lresult = new Patient_BL(base.ContextInfo).GetPrimaryConsultant(visitID,1, out lstPrimaryConsultant);

                    if (lstPrimaryConsultant.Count > 0)
                    {
                        foreach (PrimaryConsultant objPC in lstPrimaryConsultant)
                        {
                            if (primaryConsultant == "")
                            {
                                primaryConsultant = objPC.PhysicianName;
                            }
                            else
                            {
                                primaryConsultant += " , " + objPC.PhysicianName;
                            }

                        }
                    }

                    lblPatientNumber.Text = lstPatient[0].PatientNumber;
                    lblName.Text = lstPatient[0].Name;
                    lblAge.Text = lstPatient[0].Age;
                    lblSex.Text = (lstPatient[0].SEX == "M") ? "Male" : "Female";                    
                    lblAddress.Text = lstPatient[0].Address.Split('~')[1];
                    lblTempAdd.Text = lstPatient[0].Address.Split('~')[0];
                    lblOrganizationName.Text = OrgName;
                    lblOrgAddress.Text = lstOrganization[0].Address + lstOrganization[0].City + "<br> Phone : " + lstOrganization[0].PhoneNumber + "<br>";// OrgName.ToString();

                    //lblVisitType.Text = "IP";

                    lblMedicalDutyOfficer.Text = lstPatient[0].DutyOfficer;
                    lblReferringDr.Text = lstPatient[0].PrimaryPhysician;
                    lblRefPhysician.Text = primaryConsultant;
                    //lblConsultant.Text = lstPatient[0].ConsultingSurgeon;
                    lblDateTime.Text = lstPatient[0].AdmissionDate.ToString("dd/MM/yyyy hh:mm tt");
                    lblIPNo.Text = lstPatient[0].IPNumber;
                    lblContactNo.Text = lstPatient[0].ContactNo;
                    lblLLN.Text = lstPatient[0].LandLineNumber;
                    lblRelationName.Text = lstPatient[0].RelationName;


                    if(lstPatient[0].AccompaniedBy!="" && lstPatient[0].RelationContactNo!="")
                    {
                        EmergencyContact = lstPatient[0].AccompaniedBy + " - " + lstPatient[0].RelationContactNo;
                    }

                    if (lstPatient[0].AccompaniedBy == "" && lstPatient[0].RelationContactNo != "")
                    {
                        EmergencyContact = lstPatient[0].RelationContactNo;
                    }

                    if (lstPatient[0].AccompaniedBy != "" && lstPatient[0].RelationContactNo == "")
                    {
                        EmergencyContact = lstPatient[0].AccompaniedBy ;
                    }
                    lblEC.Text=EmergencyContact;
              
                    //lblMobile.Text = (lstPatient[0].RelationContactNo == "") ? "N.A" : lstPatient[0].RelationContactNo;
                    //lblLLNo.Text = (lstPatient[0].ContactNo == "") ? "N.A" : lstPatient[0].ContactNo;

                    #endregion
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Loading PatientRegistrationDetails", ex);
            }
        }
    }
   
}
