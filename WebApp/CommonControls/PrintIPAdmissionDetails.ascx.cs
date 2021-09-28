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

public partial class CommonControls_PrintIPAdmissionDetails : BaseControl
{
    long patientID = -1;
    long visitID = -1;
    long returnCode = -1;
    IP_BL IPBL;
    Patient_BL PatientBL;
    SharedInventory_BL InventoryBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["vid"], out visitID);
            List<Patient> lstPatient = new List<Patient>();
            try
            {
                IPBL=new IP_BL(base.ContextInfo);
                returnCode = IPBL.GetInPatientRegDetail(patientID, visitID, out lstPatient);
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
                    InventoryBL = new SharedInventory_BL(base.ContextInfo);
                    long lresult = InventoryBL.getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
                    
                    PatientBL=new Patient_BL(base.ContextInfo);
                    lresult = PatientBL.GetPrimaryConsultant(visitID, 1, out lstPrimaryConsultant);

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

                    System.Globalization.TextInfo info = new System.Globalization.CultureInfo("en-US", false).TextInfo;


                    string pAdd = string.Empty;
                    foreach (string Add in info.ToLower(lstPatient[0].Address).Split(','))
                    {
                        if (Add != " ")
                        {
                            if (pAdd == string.Empty)
                            {
                                pAdd = Add;
                            }
                            else
                            {
                                pAdd += ',' + Add;
                            }
                        }
                    }
                    lblAddress.Text = lstPatient[0].Address.Split('~')[0];
                    //lblAddress.Text = info.ToTitleCase(pAdd);
                    lblOrganizationName.Text = OrgName;
                    lblOrgAddress.Text = lstOrganization[0].Address + "<br> " + lstOrganization[0].City + "<br> Phone : " + lstOrganization[0].PhoneNumber + "<br>";// OrgName.ToString();
                    
                    lblVisitType.Text = "IP";

                    lblMedicalDutyOfficer.Text = lstPatient[0].DutyOfficer;
                    //lblRefPhysician.Text = lstPatient[0].PrimaryPhysician;
                    lblRefPhysician.Text = primaryConsultant;                    
                    lblConsultant.Text = lstPatient[0].ConsultingSurgeon;                    
                    lblDateTime.Text = lstPatient[0].AdmissionDate.ToString("dd/MM/yyyy hh:mm tt");
                    lblIPNo.Text = lstPatient[0].IPNumber;

                    lblMobile.Text = (lstPatient[0].ContactNo == "") ? "N.A" : lstPatient[0].ContactNo;
                    lblLLNo.Text = (lstPatient[0].LandLineNumber == "") ? "N.A" : lstPatient[0].LandLineNumber;

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
