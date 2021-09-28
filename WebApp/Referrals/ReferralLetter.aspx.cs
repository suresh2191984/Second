using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;

public partial class Referrals_ReferralLetter : BasePage
{
    long visitID = -1;
    long patientID = -1;
    long complaintID = -1;
    long taskID = -1;
    long returnCode = -1;
    long previousVID = -1;
    long createdBy = -1;
    string feeType = String.Empty;
    string PaymentLogic = String.Empty;
    string others = string.Empty;
    string sQueryPath = string.Empty;
    long refID = -1;
    string sex = string.Empty;
    long specialityid;
    string gUID =string.Empty;
    List<PatientCondition> lstPatientCondition = new List<PatientCondition>();
    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    List<PhysicianSchedule> lstPhysician = new List<PhysicianSchedule>();
    List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
    List<Patient> lstSimilarPatients = new List<Patient>();
    Referrals_BL objReferrals_BL ;  
    PatientVisit_BL visitBL;
    List<Physician> lstPhysicianByOrg = new List<Physician>();
                  
    
    protected void Page_Load(object sender, EventArgs e)
    {
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
        visitBL = new PatientVisit_BL(base.ContextInfo);
        Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
        Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
        Int64.TryParse(Request.QueryString["id"].ToString(), out complaintID);
        Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
        Int64.TryParse(Request.QueryString["pvid"].ToString(), out previousVID);
        gUID = Request.QueryString["gUID"];
        feeType = Convert.ToString(Request.QueryString["ftype"]);
        others = Convert.ToString(Request.QueryString["oC"]);
        sex = "M";
        btnEditRefCf.Visible = true;
        if (!IsPostBack)
        {
          
           
            if (IsTrustedOrg == "Y")
            {
                GetVisitPurposeID();
                hdnIstrustedOrg.Value = "Y";
                TbRefCF.Style.Add("display", "block");
                TbTrustedOrg.Style.Add("display", "block"); 
                GetFCKPathForRefAndCF();
                BindPerformingOrg();
                BindReferralAndMedicalCertificate();
                LoadPhysican();
            }

            #region Referral/Medical Certificate For Normal Flow

            if (IsTrustedOrg == "N")
            {
                GetVisitPurposeID();
                hdnIstrustedOrg.Value = "N";
                TbTrustedOrg.Style.Add("display", "block");
                TbRefCF.Style.Add("display", "block");
                GetFCKPathForRefAndCF();
                BindReferralAndMedicalCertificate();
                LoadPhysican();
            }
            #endregion
        }
    }

    public void GetVisitPurposeID()
    {
        List<VisitPurpose> lstvisitpurpose = new List<VisitPurpose>();
        new PatientVisit_BL(base.ContextInfo).GetVisitPurposeName(OrgID, visitID, out lstvisitpurpose);

        hdnVisitPurposeID.Value = lstvisitpurpose[0].VisitPurposeID.ToString();
    }

    public void LoadPhysican()
    {

        returnCode = visitBL.GetDoctorsForLab(OrgID, out lstPhysicianByOrg);
        ddlRefByPhysican.DataSource = lstPhysicianByOrg;
        ddlRefByPhysican.DataTextField = "PhysicianName";
        ddlRefByPhysican.DataValueField = "PhysicianID";
        ddlRefByPhysican.DataBind();
       // ddlRefByPhysican.Items.Insert(0, new ListItem("--Select--", "0"));
    }

    
    
    #region Trusted Org

    #region Trusted Org DropDowns
    private void BindPerformingOrg()
    {
        try
        {
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lstLocation);
            ddlReferingOrg.DataSource = lstLocation;
            ddlReferingOrg.DataTextField = "Location";
            ddlReferingOrg.DataValueField = "Comments";
            ddlReferingOrg.DataBind();
            ddlReferingOrg.Items.Insert(0, "--Select--");
            ddlReferingOrg.Items[0].Value = "0";


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Org ", ex);
        }

    }

    private void LoadPhysician(int Org)
    {
        try
        {
            List<Physician> lstPhysician = new List<Physician>();
            Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
            PhysicianBL.GetPhysicianListByOrg(Org, out lstPhysician, 0);
            var tempPhysician = from phy in lstPhysician
                                where phy.LoginID != LID
                                select phy;

            ddlReferralphysician.DataSource = tempPhysician;
            ddlReferralphysician.DataTextField = "PhysicianName";
            ddlReferralphysician.DataValueField = "LoginID";
            ddlReferralphysician.DataBind();
            ddlReferralphysician.Items.Insert(0, "--Select--");
            ddlReferralphysician.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load Physician", ex);
        }
    }

    public void LoadConsultingName(int Org)
    {
        try
        {
            if (ddlSpeciality.SelectedItem.Text != "-----Select-----")
            {
                List<Physician> lstPhysician = new List<Physician>();
                new PatientVisit_BL(base.ContextInfo).GetConsultingName(Convert.ToInt64(ddlSpeciality.SelectedItem.Value), Org, out lstPhysician);
                ddlReferralphysician.DataSource = lstPhysician;
                ddlReferralphysician.DataTextField = "PhysicianName";
                ddlReferralphysician.DataValueField = "LoginID";
                ddlReferralphysician.DataBind();
                ddlReferralphysician.Items.Insert(0, "-----Select-----");
                ddlReferralphysician.Items[0].Value = "0";
            }
            else
            {
                ddlReferralphysician.Items.Clear();
                ddlReferralphysician.Items.Insert(0, "-----Select-----");
                ddlReferralphysician.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Load the LoadConsultingName", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }

    public void LoadSpecialityName(int Org)
    {
        try
        {
            List<PhysicianSpeciality> lstPhySpeciality = new List<PhysicianSpeciality>();
            List<Speciality> lstSpeciality = new List<Speciality>();
            new PatientVisit_BL(base.ContextInfo).GetSpecialityAndSpecialityName(OrgID, out lstPhySpeciality, 0, out lstSpeciality);
            ddlSpeciality.DataSource = lstSpeciality;
            ddlSpeciality.DataTextField = "SpecialityName";
            ddlSpeciality.DataValueField = "SpecialityID";
            ddlSpeciality.DataBind();
            ddlSpeciality.Items.Insert(0, "-----Select-----");
            ddlSpeciality.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Load the LoadSpecialityName", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }
    
    protected void ddlReferingOrg_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlReferingOrg.SelectedValue != "0")
            {
                LoadSpecialityName(int.Parse(ddlReferingOrg.SelectedValue.Split('~')[1]));
                divSpeciality.Visible = true;
                divRefPhysician.Visible = false;
                divSpeciality1.Visible = true;
                divRefPhysician1.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Load the LoadSpecialityName", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
       

    }

    protected void ddlSpeciality_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlSpeciality.SelectedItem.Text != "-----Select-----")
            {
                LoadConsultingName(int.Parse(ddlReferingOrg.SelectedValue.Split('~')[1]));
                divRefPhysician.Visible = true;
                divRefPhysician1.Visible = true;
                // divFckRefLetter.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Load the LoadConsultingName", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }

    #endregion

    #region Trusted Org(Get datas for Save and Update) 
    private List<Referral> GetReferralsLetter()
    {

        List<Referral> lstReferrals = new List<Referral>();
        Referral objReferrals = new Referral();
        try
        {
            if (btnSave.Text == "Update And Continue")
            {
                objReferrals.ReferralID = Convert.ToInt64(hdnRefID.Value);
            }                    
            objReferrals.ReferedByOrgID = OrgID;
            objReferrals.ReferedByVisitID = visitID;
            if (ddlTemplateType.SelectedItem.Text == "Referral")
            {
                objReferrals.ReferralStatus = "Open";
                objReferrals.ReferedToOrgID = Int32.Parse(ddlReferingOrg.SelectedValue.Split('~')[1]);
                objReferrals.ReferedToOrgName = ddlReferingOrg.SelectedItem.Text;
                objReferrals.ReferedToLocation = Int64.Parse(ddlReferingOrg.SelectedValue.Split('~')[0]);
                objReferrals.ReferedByLocation = ILocationID;
                objReferrals.ReferralSpecialityID = Int32.Parse(ddlSpeciality.SelectedValue);
                objReferrals.ReferralSpecialityName = ddlSpeciality.SelectedItem.Text;
                objReferrals.ReferedToPhysicianID = Convert.ToInt32(ddlReferralphysician.SelectedValue);
                objReferrals.ReferedToPhysicianName = ddlReferralphysician.SelectedItem.Text;

                if (RoleName != "Physician")
                {
                    objReferrals.ReferedByPhysicianID = Convert.ToInt32(ddlRefByPhysican.SelectedValue);
                    objReferrals.ReferedByPhysicianName = ddlRefByPhysican.SelectedItem.Text;
                }
                else
                {
                    objReferrals.ReferedByPhysicianID = IUserID;
                    objReferrals.ReferedByPhysicianName = Name;
                }
            }
            objReferrals.ReferralVisitPurposeID =Convert.ToInt32(hdnVisitPurposeID.Value);           
            objReferrals.ReferralNotes = fckreferrelNotes.Value;           
            objReferrals.ResultID = Convert.ToInt32(ddlRTemplateName.SelectedValue);
            objReferrals.ResultName = ddlRTemplateName.SelectedItem.Text;
            objReferrals.ResultTemplateType = ddlTemplateType.SelectedItem.Text; 

            if (chkCaseSheet.Checked)
            {
                objReferrals.AllowCaseSheet = "Y";
            }
            else
            {
                objReferrals.AllowCaseSheet = "N";
            }

            //lstReferrals.Remove(lstReferrals.Find(p => p.ReferedToOrgID == objReferrals.ReferedToOrgID && p.ReferedToLocation == objReferrals.ReferedToLocation));
            lstReferrals.Add(objReferrals);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Saving the ReferralsLetter ", ex);
        }
        return lstReferrals;
    }
    #endregion 

    public long SaveTrustedReferral()
    {
        long statusCode = 0;
        if (btnSave.Text != "Update And Continue")
        {
            List<Referral> lstReferrals = new List<Referral>();
            int IsExist = 0;
            //returnCode = new Referrals_BL(base.ContextInfo).CheckReferralsAvailableByTemplate(visitID, Convert.ToInt32(TaskHelper.VisitPurpose.Consultation), ddlRTemplateName.SelectedItem.Text, out pCount, out refID);
            lstReferrals = GetReferralsLetter();
            if (lstReferrals.Count > 0)
            {
                returnCode = new Referrals_BL(base.ContextInfo).SaveTrustedOrgReferrals(lstReferrals, LID, out IsExist);

            }

            if (IsExist > 0)
            {
                if (ddlTemplateType.SelectedItem.Text == "Referral")
                {
                    ReferralTemplate1.LoadReferralTemplate(ddlRTemplateName.SelectedItem.Text, visitID);
                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "referral", "javascript:PrintReferral();", true);
                    //BindReferralAndMedicalCertificate();
                    //ClearTrustedOrg();


                }
                if (ddlTemplateType.SelectedItem.Text == "Fitness")
                {
                    FitnessTemplate1.LoadFitnessTemplate(ddlRTemplateName.SelectedItem.Text, visitID);
                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "referral", "javascript:PrintFitness();", true);
                    //BindReferralAndMedicalCertificate();
                    //ClearTrustedOrg();

                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This Referral/Medical Certificate has Already been Added For This patient');", true);
                statusCode = -1;
            }
        }

        else
        {
            List<Referral> lstReferrals = new List<Referral>();
            lstReferrals = GetReferralsLetter();

            if (lstReferrals.Count > 0)
            {
                returnCode = new Referrals_BL(base.ContextInfo).UpdateReferralsAndMedicalCF(lstReferrals, LID, Convert.ToInt64(hdnRefID.Value));
                btnSave.Text = "More Referral Letter";
            }

            if (returnCode == 0)
            {
                if (ddlTemplateType.SelectedItem.Text == "Referral")
                {
                    ReferralTemplate1.LoadReferralTemplate(ddlRTemplateName.SelectedItem.Text, visitID);
                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "referral", "javascript:PrintReferral();", true);
                    //BindReferralAndMedicalCertificate();
                    //ClearTrustedOrg();
                }
                if (ddlTemplateType.SelectedItem.Text == "Fitness")
                {
                    FitnessTemplate1.LoadFitnessTemplate(ddlRTemplateName.SelectedItem.Text, visitID);

                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "referral", "javascript:PrintFitness();", true);
                    //BindReferralAndMedicalCertificate();
                    //ClearTrustedOrg();

                }
            }
        }
        return statusCode;
    }

    void ClearTrustedOrg()
    {
        
        ddlTemplateType.SelectedValue = "--Select--";       
        ddlReferingOrg.SelectedValue = "0";
        chkCaseSheet.Checked = false;
        divSpeciality.Visible = false;
        divRefPhysician.Visible = false;
        divSpeciality1.Visible = false;
        divRefPhysician1.Visible = false;
        TbTrustedOrg.Style.Add("display", "block");
        divlblTemplateName.Style.Add("display", "none");
        divddlRTemplateName.Style.Add("display", "none");
        TrTrustedReffOrg.Style.Add("display", "none");
        tbfckreferrelNotes.Style.Add("display", "none");
      
    }

    #endregion  

    #region Bind Dropdown Template
    protected void ddlTemplateType_SelectedIndexChanged(object sender, EventArgs e)
    {       
        if (IsTrustedOrg == "N")
        {
            if (ddlTemplateType.SelectedItem.Text != "--Select--")
            {
                divlblTemplateName.Style.Add("display", "block");
                divddlRTemplateName.Style.Add("display", "block");
                BindTemplateName(ddlTemplateType.SelectedItem.Text);
                tbfckreferrelNotes.Style.Add("display", "none");
            }
            else
            {
                tbreferrel.Style.Add("display", "none");
                divlblTemplateName.Style.Add("display", "none");
                divddlRTemplateName.Style.Add("display", "none");
                tbfckreferrelNotes.Style.Add("display", "none");
                divRefByPhysican1.Visible = false;
                divRefByPhysican2.Visible = false;

            }
        }
        else
        {
            if (ddlTemplateType.SelectedItem.Text != "--Select--")
            {
                divSpeciality.Visible = false;
                divRefPhysician.Visible = false;
                divSpeciality1.Visible = false;
                divRefPhysician1.Visible = false;
                TbTrustedOrg.Style.Add("display", "block");
                divlblTemplateName.Style.Add("display", "block");
                divddlRTemplateName.Style.Add("display", "block");
                BindTemplateName(ddlTemplateType.SelectedItem.Text);
                ddlReferingOrg.SelectedValue = "0";
            }
            else
            {
                tbreferrel.Style.Add("display", "none");
                divlblTemplateName.Style.Add("display", "none");
                divddlRTemplateName.Style.Add("display", "none");
                tbfckreferrelNotes.Style.Add("display", "none");
                TrTrustedReffOrg.Style.Add("display", "none");
                divSpeciality.Visible = false;               
                divRefPhysician.Visible = false;
                divSpeciality1.Visible = false;
                divRefPhysician1.Visible = false;
                divRefByPhysican1.Visible = false;
                divRefByPhysican2.Visible = false;


            }


        } 
        
    }
    private void BindTemplateName(string TemplateType)
    {
        try
        {
            
            if (IsTrustedOrg == "N")
            {
                if (TemplateType == "Referral")
                {
                    tbreferrel.Style.Add("display", "block");
                    if (RoleName != "Physician")
                    {
                        divRefByPhysican1.Visible = true;
                        divRefByPhysican2.Visible = true;
                       
                    }
                    else
                    {
                        divRefByPhysican1.Visible = false;
                        divRefByPhysican2.Visible = false;
                    }

                }
                else
                {
                    tbreferrel.Style.Add("display", "none");
                    divRefByPhysican1.Visible = false;
                    divRefByPhysican2.Visible = false;
                }

                List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
                returnCode = new Referrals_BL(base.ContextInfo).GetTemplateNameBytemplateID(TemplateType,OrgID, out lstInvResultTemplate);
                if (lstInvResultTemplate.Count > 0)
                {
                    divlblTemplateName.Visible = true;
                    divddlRTemplateName.Visible = true;
                    ddlRTemplateName.DataSource = lstInvResultTemplate;
                    ddlRTemplateName.DataTextField = "ResultName";
                    ddlRTemplateName.DataValueField = "ResultID";
                    ddlRTemplateName.DataBind();
                    ddlRTemplateName.Items.Insert(0, "--Select--");
                    ddlRTemplateName.Items[0].Value = "0";

                }
            }
            else
            {
                if (TemplateType == "Referral")
                {
                    TrTrustedReffOrg.Style.Add("display", "block");
                    if (RoleName != "Physician")
                    {
                        divRefByPhysican1.Visible = true;
                        divRefByPhysican2.Visible = true;

                    }
                    else
                    {
                        divRefByPhysican1.Visible = false;
                        divRefByPhysican2.Visible = false;
                    }

                }
                else
                {
                    TrTrustedReffOrg.Style.Add("display", "none");
                    divRefByPhysican1.Visible = false;
                    divRefByPhysican2.Visible = false;
                }

                List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
                returnCode = new Referrals_BL(base.ContextInfo).GetTemplateNameBytemplateID(TemplateType,OrgID, out lstInvResultTemplate);
                if (lstInvResultTemplate.Count > 0)
                {
                    divlblTemplateName.Visible = true;
                    divddlRTemplateName.Visible = true;
                    ddlRTemplateName.DataSource = lstInvResultTemplate;
                    ddlRTemplateName.DataTextField = "ResultName";
                    ddlRTemplateName.DataValueField = "ResultID";
                    ddlRTemplateName.DataBind();
                    ddlRTemplateName.Items.Insert(0, "--Select--");
                    ddlRTemplateName.Items[0].Value = "0";
                }
            }
            


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Org ", ex);
        }

    }
    protected void ddlRTemplateName_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        if (IsTrustedOrg == "N")
        {
            List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
            new Referrals_BL(base.ContextInfo).GetInvResultTemplateByResultName(OrgID, ddlRTemplateName.SelectedItem.Text, out lstInvResultTemplate);
            fckreferrelNotes.Focus();
            List<Patient> lstPatient = new List<Patient>();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            patientBL.GetPatientDetailsPassingVisitID(visitID, out lstPatient);
            if (lstInvResultTemplate.Count > 0)
            {
                string PatientName;
                string ReplacedName;
                string PatientAge;
                string ReplacedAge;
                string NricNumber= string.Empty;
                string[] SplitAge = lstPatient[0].Age.Split(' ');
                if (lstPatient[0].SEX == "M")
                {


                    if (int.Parse(SplitAge[0]) > 18 && SplitAge[1] == "Year(s)")
                    {
                        PatientAge = lstPatient[0].Age + "  " + "Man";
                    }
                    else
                    {
                        PatientAge = lstPatient[0].Age + "  " + "old Boy";

                    }
                    PatientName = "Mr." + lstPatient[0].Name;
                    ReplacedName = lstInvResultTemplate[0].ResultValues.Replace("&lt;PatientName&gt;", PatientName);
                    ReplacedAge = ReplacedName.Replace("&lt;PatientAge&gt;", PatientAge);
                    if (lstPatient.Count > 0)
                    {
                        ReplacedAge = ReplacedAge.Replace("&lt;NRIC Number&gt;", lstPatient[0].URNO);
                    }
                }
                else
                {

                    if (int.Parse(SplitAge[0]) > 18 && SplitAge[1] == "Year(s)")
                    {
                        PatientAge = lstPatient[0].Age + "  " + "lady";
                    }
                    else
                    {
                        PatientAge = lstPatient[0].Age + "  " + "old girl";

                    }
                    PatientName = "Ms." + lstPatient[0].Name;
                    ReplacedName = lstInvResultTemplate[0].ResultValues.Replace("&lt;PatientName&gt;", PatientName);
                    ReplacedAge = ReplacedName.Replace("&lt;PatientAge&gt;", PatientAge);
                    if (lstPatient.Count > 0)
                    {
                        ReplacedAge = ReplacedAge.Replace("&lt;NRIC Number&gt;", lstPatient[0].URNO);
                    }
                }

                if (ddlTemplateType.SelectedItem.Text == "Referral")
                {
                    fckreferrelNotes.Value = ReplacedAge;
                }

                if (ddlTemplateType.SelectedItem.Text == "Fitness")
                {

                    string Doctorname = ReplacedAge.Replace("&lt;DoctorName&gt;", Name);
                    string PatientNo = Doctorname.Replace("&lt;PatientID&gt;", lstPatient[0].PatientID.ToString());
                    fckreferrelNotes.Value = PatientNo;
                }


            }
            if (ddlRTemplateName.SelectedValue != "0")
            {
                tbfckreferrelNotes.Style.Add("display", "block");
            }
            else
            {
                tbfckreferrelNotes.Style.Add("display", "none");
            }
        }
        else
        {
            List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
            new Referrals_BL(base.ContextInfo).GetInvResultTemplateByResultName(OrgID, ddlRTemplateName.SelectedItem.Text, out lstInvResultTemplate);
            fckreferrelNotes.Focus();
            List<Patient> lstPatient = new List<Patient>();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            patientBL.GetPatientDetailsPassingVisitID(visitID, out lstPatient);
            if (lstInvResultTemplate.Count > 0)
            {
                string PatientName;
                string ReplacedName;
                string PatientAge;
                string ReplacedAge;
                string NricNumber = string.Empty;
                string[] SplitAge = lstPatient[0].Age.Split(' ');
                if (lstPatient[0].SEX == "M")
                {

                    if (int.Parse(SplitAge[0]) > 18 && SplitAge[1] == "Years")
                    {
                        PatientAge = lstPatient[0].Age + "  " + "Man";
                    }
                    else
                    {
                        PatientAge = lstPatient[0].Age + "  " + "old Boy";

                    }
                    PatientName = "Mr." + lstPatient[0].Name;
                    ReplacedName = lstInvResultTemplate[0].ResultValues.Replace("&lt;PatientName&gt;", PatientName);
                    ReplacedAge = ReplacedName.Replace("&lt;PatientAge&gt;", PatientAge);
                    if (lstPatient.Count > 0)
                    {
                        NricNumber = lstInvResultTemplate[0].ResultValues.Replace("&lt;NRIC Number&gt;", lstPatient[0].URNO);
                    }
                }
                else
                {

                    if (int.Parse(SplitAge[0]) > 18 && SplitAge[1] == "Years")
                    {
                        PatientAge = lstPatient[0].Age + "  " + "lady";
                    }
                    else
                    {
                        PatientAge = lstPatient[0].Age + "  " + "old girl";

                    }
                    PatientName = "Ms." + lstPatient[0].Name;
                    ReplacedName = lstInvResultTemplate[0].ResultValues.Replace("&lt;PatientName&gt;", PatientName);
                    ReplacedAge = ReplacedName.Replace("&lt;PatientAge&gt;", PatientAge);
                    if (lstPatient.Count > 0)
                    {
                        NricNumber = lstInvResultTemplate[0].ResultValues.Replace("&lt;NRIC Number&gt;", lstPatient[0].URNO);
                    }
                }

                if (ddlTemplateType.SelectedItem.Text == "Referral")
                {
                    fckreferrelNotes.Value = ReplacedAge;
                }

                if (ddlTemplateType.SelectedItem.Text == "Fitness")
                {

                    string Doctorname = ReplacedAge.Replace("&lt;DoctorName&gt;", Name);
                    string PatientNo = Doctorname.Replace("&lt;PatientID&gt;", lstPatient[0].PatientID.ToString());
                    fckreferrelNotes.Value = PatientNo;
                }


            }

           
          
            if (ddlRTemplateName.SelectedValue != "0")
            {
                tbfckreferrelNotes.Style.Add("display", "block");
               
            }
            else
            {
                tbfckreferrelNotes.Style.Add("display", "none");
             
            }
        }
    }
    #endregion

    #region FCKPath
    private void GetFCKPathForRefAndCF()
    {
        try
        {
            string sPath = Request.Url.AbsolutePath;
            int iIndex = sPath.LastIndexOf("/");

            sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
            sPath = Request.ApplicationPath;
            sPath = sPath + "/fckeditor/";
            fckreferrelNotes.ToolbarSet = "Attune";
            fckreferrelNotes.BasePath = sPath;
            fckreferrelNotes.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            fckreferrelNotes.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in FCk Editor In Referral Notes aspx", ex);
        }
    }
    #endregion

    #region Normal Flow

    #region (Get data for Save And Update)
    private List<Referral> GetReferralsAndmedicalCertif()
    {
        List<Referral> lstReferrals = new List<Referral>();
        Referral objReferrals = new Referral();
        try
        {
            if (btnSave.Text == "Update And Continue")
            {
                objReferrals.ReferralID = Convert.ToInt64(hdnRefID.Value);
            }            
            objReferrals.ReferedByOrgID = OrgID;
            objReferrals.ReferedByVisitID = visitID;
            objReferrals.ReferralVisitPurposeID = Convert.ToInt32(hdnVisitPurposeID.Value);
            objReferrals.ReferralNotes = fckreferrelNotes.Value;
            if (ddlTemplateType.SelectedItem.Text == "Referral")
            {
                objReferrals.ReferedToOrgName = txtReferingOrg.Text;
                objReferrals.ReferedToPhysicianName = txtRefToPhy.Text;
                objReferrals.ReferralSpecialityName = txtSpeciality.Text;

                if (RoleName != "Physician")
                {
                    objReferrals.ReferedByPhysicianID = Convert.ToInt32(ddlRefByPhysican.SelectedValue);
                    objReferrals.ReferedByPhysicianName = ddlRefByPhysican.SelectedItem.Text;
                }
                else
                {
                    objReferrals.ReferedByPhysicianID = IUserID;
                    objReferrals.ReferedByPhysicianName = Name;
                }

               
            }
			objReferrals.ResultID=Convert.ToInt32(ddlRTemplateName.SelectedValue);
			objReferrals.ResultName=ddlRTemplateName.SelectedItem.Text;
            objReferrals.ResultTemplateType = ddlTemplateType.SelectedItem.Text;
          
            lstReferrals.Add(objReferrals);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Saving the Referral letter", ex);
        }
        return lstReferrals;
    }
    #endregion

    protected void btnOkRefCf_Click(object sender, EventArgs e)
    {
        long statuscode = 1;
        if (IsTrustedOrg == "N")
        {
            statuscode = SaveReferral();
        }
        else
        {
           statuscode= SaveTrustedReferral();
        }
        if (statuscode != -1)
        {
            if (others == "Y")
            {
                string pageSTR = string.Empty; string function = string.Empty;
                string gUID = Request.QueryString["gUID"];
                if (Request.QueryString["pvid"] != null && Request.QueryString["vid"] != null)
                {

                    pageSTR = Request.ApplicationPath + "/CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + previousVID + "&pid=" + patientID + "&ftype=CON" + "&oC=Y" + sQueryPath + "&IsPopup=Y"+"&gUID=" + gUID;

                    if (ddlTemplateType.SelectedItem.Text == "Referral")
                    {
                        function = "javascript:PrintReferral('" + pageSTR + "');";
                    }
                    else if (ddlTemplateType.SelectedItem.Text == "Fitness")
                    {
                        function = "javascript:PrintFitness('" + pageSTR + "');";
                    }
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "referral1", function, true);
                    BindReferralAndMedicalCertificate();
                    ClearData();
                    //Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + previousVID + "&pid=" + patientID + "&ftype=CON" + "&oC=Y" + sQueryPath, true);
                }
                else
                {
                    pageSTR = Request.ApplicationPath + "/CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=Y" + sQueryPath + "&IsPopup=Y"+"&gUID=" + gUID;

                    if (ddlTemplateType.SelectedItem.Text == "Referral")
                    {
                        function = "javascript:PrintReferral('" + pageSTR + "');";
                    }
                    else if (ddlTemplateType.SelectedItem.Text == "Fitness")
                    {
                        function = "javascript:PrintFitness('" + pageSTR + "');";
                    }
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "referral1", function, true);
                    BindReferralAndMedicalCertificate();
                    ClearData();

                    //Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=Y" + sQueryPath, true);
                }

            }
            else if (others == "N")
            {


                string pageSTR = string.Empty; string function = string.Empty;
                if (Request.QueryString["pvid"] != null && Request.QueryString["vid"] != null)
                {

                    //Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + previousVID + "&pid=" + patientID + "&ftype=CON" + "&oC=N" + sQueryPath, true);
                    pageSTR = Request.ApplicationPath + "/CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + previousVID + "&pid=" + patientID + "&ftype=CON" + "&oC=N" + sQueryPath + "&IsPopup=Y"+"&gUID=" + gUID;
                    if (ddlTemplateType.SelectedItem.Text == "Referral")
                    {
                        function = "javascript:PrintReferral('" + pageSTR + "');";
                    }
                    else if (ddlTemplateType.SelectedItem.Text == "Fitness")
                    {
                        function = "javascript:PrintFitness('" + pageSTR + "');";
                    }
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "referral1", function, true);
                    BindReferralAndMedicalCertificate();
                    ClearData();
                }
                else
                {
                    pageSTR = Request.ApplicationPath + "/CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=N" + sQueryPath + "&IsPopup=Y" + "&gUID=" + gUID;
                    if (ddlTemplateType.SelectedItem.Text == "Referral")
                    {
                        function = "javascript:PrintReferral('" + pageSTR + "');";
                    }
                    else if (ddlTemplateType.SelectedItem.Text == "Fitness")
                    {
                        function = "javascript:PrintFitness('" + pageSTR + "');";
                    }
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "referral2", function, true);
                    BindReferralAndMedicalCertificate();
                    ClearData();
                    //Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=N" + sQueryPath, true);
                }

            }
            else if (others == "COUN")
            { 
                string pageSTR = string.Empty; string function = string.Empty;
                if (Request.QueryString["pvid"] != null && Request.QueryString["vid"] != null)
                {
                    Int64.TryParse(Request.QueryString["sid"], out specialityid);
                    
                    pageSTR = Request.ApplicationPath + "/Psychologist/PrintViewCounsellingDetails.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&sid=" + specialityid + "&pSex=" + sex + "&Show=Y" + "";
                    

                    if (ddlTemplateType.SelectedItem.Text == "Referral")
                    {
                        function = "javascript:PrintReferral('" + pageSTR + "');";
                    }
                    else if (ddlTemplateType.SelectedItem.Text == "Fitness")
                    {
                        function = "javascript:PrintFitness('" + pageSTR + "');";
                    }
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "referral1", function, true);
                    BindReferralAndMedicalCertificate();
                    ClearData();
                }
            }
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
            if (others != "COUN")
            {
                sQueryPath = Request.Url.PathAndQuery;
                if (sQueryPath.Contains("RedirectURL"))
                {
                    sQueryPath = sQueryPath.Substring(0, sQueryPath.IndexOf("RedirectURL"));
                }
                sQueryPath = sQueryPath.Replace("&", "^~");
                sQueryPath = "&RedirectURL=" + sQueryPath;


                Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
                Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
                Int64.TryParse(Request.QueryString["id"].ToString(), out complaintID);
                Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
                Int64.TryParse(Request.QueryString["pvid"].ToString(), out previousVID);

                List<PatientComplaint> lstPatientComplaintDetail = new List<PatientComplaint>();
                if (Request.QueryString["vid"] != null && Request.QueryString["pvid"] != null)
                {
                    if (Request.QueryString["vid"].ToString() == Request.QueryString["pvid"].ToString())
                        returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
                    else
                        returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(previousVID, out lstPatientComplaintDetail);
                }
                else
                {
                    returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
                }
                if (lstPatientComplaintDetail.Count > 1)
                {
                    Response.Redirect("../Physician/DisplayPatientComplaint.aspx?vid=" + visitID + "&pid=" + patientID + "&tid=" + taskID + "&pvid=" + previousVID + "&id=" + complaintID + sQueryPath, true);
                }
                else if (lstPatientComplaintDetail.Count == 1)
                {
                    if (lstPatientComplaintDetail[0].ComplaintID != 0)
                    {
                        Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + visitID + "&pid=" + patientID + "&id=" + lstPatientComplaintDetail[0].ComplaintID + "&pvid=" + visitID + "&tid=" + taskID + "" + sQueryPath, true);
                    }
                    else
                    {
                        Response.Redirect(@"../Physician/UnfoundDiagnosis.aspx?vid=" + visitID + "&pid=" + patientID + "&id=" + lstPatientComplaintDetail[0].ComplaintID + "&pvid=" + visitID + "&tid=" + taskID + "" + sQueryPath, true);
                    }
                }
            }
            else
            {
                Int64.TryParse(Request.QueryString["vid"], out visitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                Int64.TryParse(Request.QueryString["sid"], out specialityid);
                if (specialityid == 9 || specialityid == 51)
                {
                    Response.Redirect("../Psychologist/Psychiatry.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&sid=" + specialityid + "&mode=" + "U", true);
                }
                
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void btnEditRefCf_Click(object sender, EventArgs e)
    {
        try
        {
            if (others != "COUN")
            {
                sQueryPath = Request.Url.PathAndQuery;
                if (sQueryPath.Contains("RedirectURL"))
                {
                    sQueryPath = sQueryPath.Substring(0, sQueryPath.IndexOf("RedirectURL"));
                }
                sQueryPath = sQueryPath.Replace("&", "^~");
                sQueryPath = "&RedirectURL=" + sQueryPath;


                Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
                Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
                Int64.TryParse(Request.QueryString["id"].ToString(), out complaintID);
                Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
                Int64.TryParse(Request.QueryString["pvid"].ToString(), out previousVID);

                List<PatientComplaint> lstPatientComplaintDetail = new List<PatientComplaint>();
                if (Request.QueryString["vid"] != null && Request.QueryString["pvid"] != null)
                {
                    if (Request.QueryString["vid"].ToString() == Request.QueryString["pvid"].ToString())
                        returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
                    else
                        returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(previousVID, out lstPatientComplaintDetail);
                }
                else
                {
                    returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
                }
                if (lstPatientComplaintDetail.Count > 1)
                {
                    Response.Redirect("../Physician/DisplayPatientComplaint.aspx?vid=" + visitID + "&pid=" + patientID + "&tid=" + taskID + "&pvid=" + previousVID + "&id=" + complaintID + sQueryPath, true);
                }
                else if (lstPatientComplaintDetail.Count == 1)
                {
                    if (lstPatientComplaintDetail[0].ComplaintID != 0)
                    {
                        Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + visitID + "&pid=" + patientID + "&id=" + lstPatientComplaintDetail[0].ComplaintID + "&pvid=" + visitID + "&tid=" + taskID + "" + sQueryPath, true);
                    }
                    else
                    {
                        Response.Redirect(@"../Physician/UnfoundDiagnosis.aspx?vid=" + visitID + "&pid=" + patientID + "&id=" + lstPatientComplaintDetail[0].ComplaintID + "&pvid=" + visitID + "&tid=" + taskID + "" + sQueryPath, true);
                    }
                }
            }
            else
            {
                Int64.TryParse(Request.QueryString["vid"], out visitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                Int64.TryParse(Request.QueryString["sid"], out specialityid);
                if (specialityid == 9 || specialityid == 51)
                {
                    Response.Redirect("../Psychologist/Psychiatry.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&sid=" + specialityid + "&mode=" + "U", true);
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        long RefID = 0;
        if (Request.Form["RefID"] != null && Request.Form["RefID"].ToString() != "")
        {
            RefID = Convert.ToInt64(Request.Form["RefID"]);
            hdnRefID.Value = RefID.ToString();
        }

        if (RefID != 0)
        {
            GerReferralAndMedicalForEdit(RefID);
        }    
        if (ddlTemplateType.SelectedItem.Text == "Referral")
        {
            ReferralTemplate1.LoadReferralTemplate(ddlRTemplateName.SelectedItem.Text, visitID);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "referral", "javascript:PrintReferral('');", true);
            BindReferralAndMedicalCertificate();
            ClearData();

        }
        if (ddlTemplateType.SelectedItem.Text == "Fitness")
        {
            FitnessTemplate1.LoadFitnessTemplate(ddlRTemplateName.SelectedItem.Text, visitID);

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "referral", "javascript:PrintFitness('');", true);
            BindReferralAndMedicalCertificate();
            ClearData();

        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        long statuscode = 1;
        if (IsTrustedOrg == "N")
        {
            statuscode=SaveReferral();
        }
        else
        {
            statuscode = SaveTrustedReferral();
        }
        if (statuscode != -1)
        {
            string pageSTR = string.Empty;
            string function = string.Empty;
            if (ddlTemplateType.SelectedItem.Text == "Referral")
            {
                function = "javascript:PrintReferral('" + pageSTR + "');";
            }
            else if (ddlTemplateType.SelectedItem.Text == "Fitness")
            {
                function = "javascript:PrintFitness('" + pageSTR + "');";
            }
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "referral1", function, true);
            BindReferralAndMedicalCertificate();
            ClearData();
        }
    }

    public long SaveReferral()
    {
        long statusCode = 0;
        if (btnSave.Text != "Update And Continue")
        {
            int IsExist = 0;
            List<Referral> lstReferrals = new List<Referral>();

            lstReferrals = GetReferralsAndmedicalCertif();
            if (lstReferrals.Count > 0)
            {
                returnCode = new Referrals_BL(base.ContextInfo).SaveReferralsAndMedicalCertificate(lstReferrals, LID, out IsExist);

            }
            if (IsExist > 0)
            {
                if (ddlTemplateType.SelectedItem.Text == "Referral")
                {
                    ReferralTemplate1.LoadReferralTemplate(ddlRTemplateName.SelectedItem.Text, visitID);
                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "referral", "javascript:PrintReferral('');", true);
                    //BindReferralAndMedicalCertificate();
                    //ClearData();

                }
                if (ddlTemplateType.SelectedItem.Text == "Fitness")
                {
                    FitnessTemplate1.LoadFitnessTemplate(ddlRTemplateName.SelectedItem.Text, visitID);

                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "referral", "javascript:PrintFitness('');", true);
                    //BindReferralAndMedicalCertificate();
                    //ClearData();

                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This Referral/Medical Certificate has Already been Added For This patient');", true);
                statusCode = -1;
            }
        }

        else
        {
            List<Referral> lstReferrals = new List<Referral>();
            lstReferrals = GetReferralsAndmedicalCertif();
            if (lstReferrals.Count > 0)
            {
                returnCode = new Referrals_BL(base.ContextInfo).UpdateReferralsAndMedicalCF(lstReferrals, LID, Convert.ToInt64(hdnRefID.Value));
                btnSave.Text = "More Referral Letter";
            }

            if (returnCode == 0)
            {
                if (ddlTemplateType.SelectedItem.Text == "Referral")
                {
                    ReferralTemplate1.LoadReferralTemplate(ddlRTemplateName.SelectedItem.Text, visitID);
                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "referral", "javascript:PrintReferral('');", true);
                    //BindReferralAndMedicalCertificate();
                    //ClearData();
                }
                if (ddlTemplateType.SelectedItem.Text == "Fitness")
                {
                    FitnessTemplate1.LoadFitnessTemplate(ddlRTemplateName.SelectedItem.Text, visitID);

                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "referral", "javascript:PrintFitness('');", true);
                    //BindReferralAndMedicalCertificate();
                    //ClearData();

                }
            }
        }
        return statusCode;
    }

    void ClearData()
    {
        txtReferingOrg.Text = "";
        txtRefToPhy.Text = "";
        txtSpeciality.Text = "";
        ddlTemplateType.SelectedValue = "--Select--";
        tbreferrel.Style.Add("display", "none");
        divlblTemplateName.Style.Add("display", "none");
        divddlRTemplateName.Style.Add("display", "none");
        tbfckreferrelNotes.Style.Add("display", "none");
    }


#endregion   

    #region Edit Referral

    public void BindReferralAndMedicalCertificate()
    {
        List<Referral> lstReferrals = new List<Referral>();
        returnCode = new Referrals_BL(base.ContextInfo).GetReferralAndMedicalDetails(visitID, Convert.ToInt32(hdnVisitPurposeID.Value), out lstReferrals);
        if (lstReferrals.Count > 0)
        {
            tblTreatment.Style.Add("display", "block");
            gvReferral.DataSource = lstReferrals;
            gvReferral.DataBind();

        }
    }

    protected void gvReferral_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            Referral o = (Referral)e.Row.DataItem;
            string strScript = "SelectReferralID('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + o.ReferralID + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);          

          
        }
    }

    protected void btnEditReferral_Click(object sender, EventArgs e)
    {
        long RefID = 0;
        if (Request.Form["RefID"] != null && Request.Form["RefID"].ToString() != "")
        {
            RefID = Convert.ToInt64(Request.Form["RefID"]);
            hdnRefID.Value = RefID.ToString();
        }

        if (RefID != 0)
        {
            GerReferralAndMedicalForEdit(RefID);
        }       

    }

    public void GerReferralAndMedicalForEdit(long RefID)
    {
        if (IsTrustedOrg == "N")
        {
            List<Referral> lstReferrals = new List<Referral>();
            returnCode = new Referrals_BL(base.ContextInfo).GerReferralAndMedicalForEdit(visitID, Convert.ToInt32(hdnVisitPurposeID.Value), RefID, out lstReferrals);
            if (lstReferrals.Count > 0)            {

                if (lstReferrals[0].ResultTemplateType == "Referral")
                {
                    btnSave.Text = "Update And Continue";
                    fckreferrelNotes.Value = lstReferrals[0].ReferralNotes;
                    txtReferingOrg.Text = lstReferrals[0].ReferedToOrgName;
                    txtRefToPhy.Text = lstReferrals[0].ReferedToPhysicianName;
                    txtSpeciality.Text = lstReferrals[0].ReferralSpecialityName;
                    ddlTemplateType.SelectedValue = lstReferrals[0].ResultTemplateType;
                    BindTemplateName(lstReferrals[0].ResultTemplateType);
                    ddlRTemplateName.SelectedValue = lstReferrals[0].ResultID.ToString(); 
                    if (ddlRTemplateName.SelectedValue != "0")
                    {
                        tbfckreferrelNotes.Style.Add("display", "block");
                        divddlRTemplateName.Style.Add("display", "block");
                        divlblTemplateName.Style.Add("display", "block");
                    }
                    else
                    {
                        tbfckreferrelNotes.Style.Add("display", "none");
                    }

                    if (RoleName != "Physician")
                    {
                       ddlRefByPhysican.SelectedValue=lstReferrals[0].ReferedByPhysicianID.ToString();
                      
                    }
                   

                }
                else
                {
                    btnSave.Text = "Update And Continue";
                    ddlTemplateType.SelectedValue = lstReferrals[0].ResultTemplateType;
                    BindTemplateName(lstReferrals[0].ResultTemplateType);
                    ddlRTemplateName.SelectedValue = lstReferrals[0].ResultID.ToString();
                    fckreferrelNotes.Value = lstReferrals[0].ReferralNotes;
                    if (ddlRTemplateName.SelectedValue != "0")
                    {
                        tbfckreferrelNotes.Style.Add("display", "block");
                        divddlRTemplateName.Style.Add("display", "block");
                        divlblTemplateName.Style.Add("display", "block");
                    }
                    else
                    {
                        tbfckreferrelNotes.Style.Add("display", "none");
                    }
                  
                }



            }
        }

        else
        {
            List<Referral> lstReferrals = new List<Referral>();
            returnCode = new Referrals_BL(base.ContextInfo).GerReferralAndMedicalForEdit(visitID, Convert.ToInt32(hdnVisitPurposeID.Value), RefID, out lstReferrals);
            if (lstReferrals.Count > 0)
            {
                if (lstReferrals[0].ResultTemplateType == "Referral")
                {
                    btnSave.Text = "Update And Continue";

                    ddlReferingOrg.SelectedValue = lstReferrals[0].ReferedToLocation.ToString() + "~" + lstReferrals[0].ReferedToOrgID.ToString();
                    if (lstReferrals[0].AllowCaseSheet == "Y")
                    {
                        chkCaseSheet.Checked = true;
                    }
                    ddlTemplateType.SelectedValue = lstReferrals[0].ResultTemplateType;
                    BindTemplateName(lstReferrals[0].ResultTemplateType);
                    ddlRTemplateName.SelectedValue = lstReferrals[0].ResultID.ToString();
                    LoadSpecialityName(int.Parse(ddlReferingOrg.SelectedValue.Split('~')[1]));
                    LoadPhysician(int.Parse(ddlReferingOrg.SelectedValue.Split('~')[1]));
                    ddlReferralphysician.SelectedValue = lstReferrals[0].ReferedToPhysicianID.ToString();
                    ddlSpeciality.SelectedValue = lstReferrals[0].ReferralSpecialityID.ToString();
                    tbfckreferrelNotes.Style.Add("display", "block");
                    fckreferrelNotes.Value = lstReferrals[0].ReferralNotes;
                    divSpeciality.Visible = true;
                    divRefPhysician.Visible = true;
                    divSpeciality1.Visible = true;
                    divRefPhysician1.Visible = true;
                    TrTrustedReffOrg.Style.Add("display", "block");
                    divddlRTemplateName.Style.Add("display", "block");
                    divlblTemplateName.Style.Add("display", "block");

                    if (RoleName != "Physician")
                    {
                        ddlRefByPhysican.SelectedValue = lstReferrals[0].ReferedByPhysicianID.ToString();

                    }
                  
                }
                else
                {
                    btnSave.Text = "Update And Continue";
                    ddlTemplateType.SelectedValue = lstReferrals[0].ResultTemplateType;
                    BindTemplateName(lstReferrals[0].ResultTemplateType);
                    ddlRTemplateName.SelectedValue = lstReferrals[0].ResultID.ToString();
                    fckreferrelNotes.Value = lstReferrals[0].ReferralNotes;
                    tbfckreferrelNotes.Style.Add("display", "block");
                    divddlRTemplateName.Style.Add("display", "block");
                    divSpeciality.Visible = false;
                    divRefPhysician.Visible = false;
                    divSpeciality1.Visible = false;
                    divRefPhysician1.Visible = false;

                  
                  
                }



            }
        }
    }

    #endregion



}
