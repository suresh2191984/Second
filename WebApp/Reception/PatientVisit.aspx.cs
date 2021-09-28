using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Security.Cryptography;
using System.Web.Security;
using System.Text;
using System.Runtime.InteropServices;
using System.Drawing;
public partial class Reception_PatientVisit : BasePage
{

    public Reception_PatientVisit()
        : base("Reception\\PatientVisit.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long Returncode = -1;
    bool boolClickStatus = false;
    List<RateMaster> lstRateType = new List<RateMaster>();
  
    List<PatientCondition> lstPatientCondition = new List<PatientCondition>();
    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    List<PhysicianSchedule> lstPhysician = new List<PhysicianSchedule>();
    List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
    List<Patient> lstSimilarPatients = new List<Patient>();
    Referrals_BL objReferrals_BL ;
    AdminReports_BL objBl ;
    KnowledgeOfService_BL objKnowledgeOfService_BL;
    List<KnowledgeOfService> lstKnowledgeOfService = new List<KnowledgeOfService>();
    List<VisitKnowledgeMapping> lstVisitKnowledgeMapping = new List<VisitKnowledgeMapping>();
    List<KnowledgeOfServiceAttributes> lstKnowledgeOfServiceAttributes = new List<KnowledgeOfServiceAttributes>();
    
    
    override protected void OnInit(EventArgs e)
    {
        usrProcedure.selectedIndexProcedure += new EventHandler(Procedure_SelectChanged);
        usrProcedure.selectedIndexPhysicianByProcedure += new EventHandler(PhysicianByProcedure_SelectedChanged);
        usrConsulting.selectedConsulting += new EventHandler(Consulting_SelectChanged);
        usrConsulting.selectedSpeciality += new EventHandler(Speciality_SelectedChanged);
    }
    long patientID = 0;
    string patientName = string.Empty;
    string PaymentLogic = string.Empty;
    long returnCode = -1;
    string sPatientName = string.Empty;
    string RefspecialityName = string.Empty;
    long Rid = 0;
    protected void Procedure_SelectChanged(object sender, EventArgs e)
    { }
    protected void Consulting_SelectChanged(object sender, EventArgs e)
    {
    }
    protected void Speciality_SelectedChanged(object sender, EventArgs e)
    { }
    protected void PhysicianByProcedure_SelectedChanged(object sender, EventArgs e)
    { }

    protected void Page_Load(object sender, EventArgs e)
    {
          objReferrals_BL = new Referrals_BL(base.ContextInfo);
          objBl = new AdminReports_BL(base.ContextInfo);
          objKnowledgeOfService_BL = new KnowledgeOfService_BL(base.ContextInfo);
        long returnCode = -1;
        string patientName = string.Empty;
        dvErrorDisplay.Style.Add("display", "none");
        if (!IsPostBack)
        {
            bsave.Attributes.Add("onblur", "this.disabled=true");
            if (Request.QueryString["PRINT"] == "Y")
            {
                this.Page.RegisterStartupScript("strPrint", "<script type='text/javascript'> popupprint(); </script>");
            }
        }
        Patient patient = new Patient();
        List<Patient> patientList = new List<Patient>();
        List<Bookings> lstBookings = new List<Bookings>();
        List<Complaint> lstSchedules = new List<Complaint>();
        List<Bookings> lstFullSchedules = new List<Bookings>();       
        List<Attune.Podium.BusinessEntities.Login> lstLoginDetails=new List<Attune.Podium.BusinessEntities.Login>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
       // KnowledgeOfService_BL objKnowledgeOfService_BL = new KnowledgeOfService_BL(base.ContextInfo);
        ddlLocatiopn.SelectedValue = ILocationID.ToString();
        //bsave.Attributes.Add("onclick", "return CheckLocation();");
        //btnPrint.Attributes.Add("onclick", "return CheckLocation();");
        dPurpose.Attributes.Add("onChange", "return OnSelectedIndexChange();");
        try
        {
            if (Request.QueryString["PID"] != null)
            {
                Int64.TryParse(Request.QueryString["PID"], out patientID);
                if (!IsPostBack)
                {
                    SecPageCheck.Style.Add("display", "none");
                    
                    hdnPID.Value = patientID.ToString();
                    bsave.Enabled = true; btnPrint.Enabled = true;
                    returnCode = objKnowledgeOfService_BL.GetKnowledgeOfserviceMasterAndChildByOrgID(OrgID, out lstKnowledgeOfService,out lstKnowledgeOfServiceAttributes);                    
                    if (returnCode == 0)
                    {
                        if (lstKnowledgeOfService.Count > 0)
                        {
                            gvKOS.DataSource = lstKnowledgeOfService;
                            gvKOS.DataBind();
                        }
                    }               
                    returnCode = patientBL.GetPatientDemoandAddress(patientID, out patientList);
                    returnCode = patientBL.GetPatientLoginDetails(patientID, out lstLoginDetails);                    
                    if (patientList.Count > 0)
                    {
                                        
                        patient = patientList[0];
                        hdnSex.Value = patientList[0].SEX;
                        if (patient.CompressedName != null)
                        {
                            sPatientName = patient.CompressedName;
                        }
                        else
                        {
                            sPatientName = patient.Name;
                        }
                        patientName = patient.TitleName + " " + sPatientName;
                        lblPatientName.Text = "<h4>Visit entry for " + patient.TitleName + " " + patient.Name + "</h4>";
                        txtBirthWeeks.Text = patientList[0].Age;
                        //string pAgeDWMY = patientList[0].Age.Split(' ')[1];
                        //if (pAgeDWMY == "D")
                        //{
                        //    txtBirthWeeks.Text = patientList[0].Age.Split(' ')[0] + " Days";
                        //}
                        //else if (pAgeDWMY == "W")
                        //{
                        //    txtBirthWeeks.Text = patientList[0].Age.Split(' ')[0] + " Weeks";
                        //}
                        //else if (pAgeDWMY == "M")
                        //{
                        //    txtBirthWeeks.Text = patientList[0].Age.Split(' ')[0] + " Months";
                        //}
                        //else
                        //{
                        //    txtBirthWeeks.Text = patientList[0].Age.Split(' ')[0] + " Years";
                        //}
                        PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo); List<PriorityMaster> lstPriorityMaster = new List<PriorityMaster>();
                        returnCode = patientVisitBL.GetVisitEntryPageData(OrgID, sPatientName, out lstPatientCondition,
                                                                            out lstLocation, out lstPhysician, out lstVisitPurpose,
                                                                            out lstSimilarPatients, out lstBookings,out lstSchedules,
                                                                            out lstFullSchedules, out lstPriorityMaster,ILocationID);
                        if (returnCode == 0)
                        {
                            LoadConditions(lstPatientCondition);
                            LoadPhysicians(lstPhysician);
                            LoadVisitPurpose(lstVisitPurpose);
                            LoadLocation(lstLocation);
                            LoadScheduleTimes(lstSchedules);
                            LoadBookings(lstBookings);
                            LoadAvailabilitySchedules(lstFullSchedules, lstBookings);
                            ddlPriority.DataSource = lstPriorityMaster;
                            ddlPriority.DataTextField = "PriorityName";
                            ddlPriority.DataValueField = "PriorityID";
                            ddlPriority.DataBind();
                            if (Request.QueryString["vType"] != "OP")
                            {
                                if (lstSimilarPatients.Count > 1)
                                {
                                    grdResult.Visible = true;
                                    LoadSimilarPatients(lstSimilarPatients);
                                }
                                else
                                {
                                    grdResult.Visible = false;
                                }
                            }
                            else
                            {
                                grdResult.Visible = false;
                            }
                        }
                        else
                        {
                            dvErrorDisplay.Style.Add("display", "block");

                            ErrorDisplay1.ShowError = true;
                            ErrorDisplay1.Status = "An error occured while trying to load visit entry page. Pl. contact administrator.";
                        }
                    }
                    else
                    {
                        dvErrorDisplay.Style.Add("display", "block");
                        ErrorDisplay1.ShowError = true;
                        ErrorDisplay1.Status = "Patient ID not found in database.Please contact the system administrator";
                    }
                    if (Request.QueryString["Rid"] != null)
                    {
                        GetReferralsInvestigation();
                       //usrConsulting.LoadConsultingName();
                    }
                }
            }
            else
            {
                dvErrorDisplay.Style.Add("display", "block");
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "Patient not found. Please select a patient using PatientSearch";
            }
        }
        catch (Exception ex1)
        {
            dvErrorDisplay.Style.Add("display", "block");

            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "An error occured while trying to load visit entry page. Pl. contact administrator.";
            CLogger.LogError("An error occured while trying to load visit entry page", ex1);
        }

    }

   

    private void GetReferralsInvestigation()
    {
        dicRef.Visible = true;
        Int64.TryParse(Request.QueryString["Rid"], out Rid);
        List<Referral> lstReferral=new List<Referral>();
        returnCode = objReferrals_BL.GetOrgReferrals(OrgID, ILocationID,Rid, out lstReferral);
        gvInvestigations.DataSource = lstReferral;
        gvInvestigations.DataBind();
    }
    private void LoadPhysician(long SpecialityId)
    {
        try
        {
            List<Physician> lPhysician=new List<Physician>();
            DropDownList ddlPhysician = (DropDownList)usrConsulting.FindControl("ddlConsultingName");
            List<Physician> lstPhysician = new List<Physician>();
            new PatientVisit_BL(base.ContextInfo).GetConsultingName(SpecialityId, OrgID, out lstPhysician);
            ddlPhysician.DataSource = lstPhysician;
            ddlPhysician.DataTextField = "PhysicianName";
            ddlPhysician.DataValueField = "LoginID";
            ddlPhysician.DataBind();
            ddlPhysician.Items.Insert(0, "--Select One--");
            ddlPhysician.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load Physician", ex);
        }
    }

    protected void gvInvestigations_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Referral Ref = (Referral)e.Row.DataItem;
            string strURN = Ref.URN == "" ? "-1" : Ref.URN;
            string strScript = "ReferralRowSelect('" + ((RadioButton)e.Row.Cells[1].FindControl("rdoSelect")).ClientID + "','" + Ref.ReferralID + "','" + Ref.ReferralDetailsID + "','" + Ref.ReferralVisitPurposeID + "','" + Ref.ReferedToPhysicianID + "','" + Ref.ReferralSpecialityID + "','" + Ref.ReferralNotes + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdoSelect")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdoSelect")).Attributes.Add("onclick", strScript);
        }

    }

    protected void gvInvestigations_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvInvestigations.PageIndex = e.NewPageIndex;
            GetReferralsInvestigation();
        }
    }

    protected void rdoSelect_CheckedChanged(object sender, EventArgs e)
    {
        try
        {

            if (pPurposeName.Value == "Consultation")
            {
                DropDownList ddlPhysician = (DropDownList)usrConsulting.FindControl("ddlConsultingName");
                DropDownList ddlSpeciality = (DropDownList)usrConsulting.FindControl("ddlSpeciality");
                LoadPhysician(Int64.Parse(pSpecialityID.Value));
                ddlSpeciality.SelectedValue = pSpecialityID.Value;
                ddlPhysician.SelectedValue = pPhysicianID.Value;
            }

            //foreach (GridViewRow oldrow in gvInvestigations.Rows)
            //{
            //    ((RadioButton)oldrow.FindControl("rdoSelect")).Checked = false;
            //}
            //RadioButton rb = (RadioButton)sender;
            //GridViewRow row = (GridViewRow)rb.NamingContainer;
            //((RadioButton)row.FindControl("rdoSelect")).Checked = true;



        }
        catch (Exception ex)
        {

            throw;
        }
    }

    public void LoadConditions(List<PatientCondition> pCond)
    {
        if (pCond.Count > 0)
        {
            dCond.DataSource = pCond;
            dCond.DataTextField = "Condition";
            dCond.DataValueField = "ConditionID";
            dCond.DataBind();
        }
        dCond.Items.Insert(0, "---------Select---------");
    }

    
    public void LoadLocation(List<OrganizationAddress> lstLocation)
    {

        if (lstLocation.Count > 0)
        {
            ddlLocatiopn.DataSource = lstLocation;
            ddlLocatiopn.DataTextField = "Location";
            ddlLocatiopn.DataValueField = "AddressID";
            ddlLocatiopn.DataBind();

            if (lstLocation.Count == 1)
            {
                ddlLocatiopn.Items.Insert(0, "------Select------");
                ddlLocatiopn.Items[1].Selected = true;
            }
            else if (lstLocation.Count == 0 || lstLocation.Count > 1)
            {
                ddlLocatiopn.Items.Insert(0, "------Select------");
            }
        }
        else
        {
            ddlLocatiopn.Items.Insert(0, "------Select------");
        }
    }

    public void LoadPhysicians(List<PhysicianSchedule> phySch)
    {

        if (phySch.Count > 0)
        {
            dDoc.DataSource = phySch;
            dDoc.DataTextField = "PhysicianName";
            dDoc.DataValueField = "PhysicianID";
            dDoc.DataBind();
            ListItem li = new ListItem("None", "-1");
            dDoc.Items.Add(li);
        }
    }

    public void LoadVisitPurpose(List<VisitPurpose> vPurp)
    {
        if (vPurp.Count > 0)
        {
            dPurpose.DataSource = vPurp;
            dPurpose.DataTextField = "VisitPurposeName";
            dPurpose.DataValueField = "VisitPurposeID";
            dPurpose.DataBind();
        }
        dPurpose.Items.Insert(0, "-----Select-----");
    }

    public void LoadSimilarPatients(List<Patient> lstPatients)
    {
        grdResult.Visible = true;
        grdResult.DataSource = lstPatients;
        grdResult.DataBind();

    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Patient p = (Patient)e.Row.DataItem;
                string strScript = "SelectCVisit('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + p.PatientID + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

                long id = Convert.ToInt64(e.Row.Cells[0].Text);
                if (id == patientID)
                {
                    e.Row.BackColor = System.Drawing.Color.Orange;
                    e.Row.CssClass = "patientSearch";
                    e.Row.ToolTip = "Current Patient";
                    ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Checked = true;
                }
            }
            e.Row.Cells[0].Visible = false;
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Patient Search Control", Ex);
        }

    }

   
    protected void bsave_Click(object sender, EventArgs e)
    {
        if (boolClickStatus)
            return;
            
        bsave.Enabled = false;
        boolClickStatus = true;
        PatientVisit_BL pvisitBL = new PatientVisit_BL(base.ContextInfo);
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        PatientVisit pVisit = new PatientVisit();
        int purpID = 0;
        long phyID = -1;
        int otherID = -1;
        long referOrgID = -1;
        int orgAddressID = -1;
        string feeType = String.Empty;
        string otherName = String.Empty;
        string physicianName = String.Empty;
        string RefPhysicianName = String.Empty;
        string referrerName = string.Empty;
        long taskID = -1;
        long ptaskID = -1;
        int ClientID = 0;
        int CorporateID = 0;
        int RateID = 0;


         

       

        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        List<TaskActions> lstTaskAction = new List<TaskActions>();
        List<Patient> lstPatient = new List<Patient>();
        int specialityID = -1;
        int RefphysicianID = -1;
        int RefSpecialtiyID = -1;
        int otherRefID = -1;
        int otherSpecID = -1;
        long RefPhyID = -1;

        RefPhyID = Rfrdoctor.GetRefPhyID();
        RefphysicianID = Convert.ToInt32(RefPhyID);

        if (hdnPID.Value == "")
        {
            Int64.TryParse(Request.QueryString["PID"], out patientID);
        }
        else
        {
            patientID = Convert.ToInt64(hdnPID.Value);
        }

        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        long retid = new PatientVisit_BL(base.ContextInfo).GetInPatientVisitDetails(patientID, out lstPatientVisit);

        if (lstPatientVisit.Count > 0)
        {
            bsave.Enabled = true;
            string sPath = "Reception\\\\PatientVisit.aspx.cs_10";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('"+ sPath +"');", true);
            return;
            
        }

        Int32.TryParse(ddlLocatiopn.SelectedItem.Value, out orgAddressID);

        returnCode = patientBL.GetPatientDemoandAddress(patientID, out lstPatient);
        Patient patient = new Patient();
        patient = lstPatient[0];
        try
        {
            string visitPurposeName = dPurpose.SelectedItem.Text;

            if (visitPurposeName.Contains("Old Notes"))
            {
                Response.Redirect(@"~\Reception\PatientOldNotes.aspx?PID=" + patientID.ToString(), true);
            }
            if (visitPurposeName == "Consultation")
            {
                feeType = "CON";
                DropDownList ddlSpeciality = (DropDownList)usrConsulting.FindControl("ddlSpeciality");
                otherName = ddlSpeciality.SelectedItem.Text;
                Int32.TryParse(ddlSpeciality.SelectedItem.Value, out otherID);
                specialityID = otherID;
                DropDownList ddlPhysician = (DropDownList)usrConsulting.FindControl("ddlConsultingName");
                Int64.TryParse(ddlPhysician.SelectedItem.Value, out phyID);
                if (phyID > 0)
                {
                    physicianName = ddlPhysician.SelectedItem.Text;
                }
                
                if (PaymentLogic == string.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }
                pVisit.PhysicianName = "";
            }
            else if (visitPurposeName == "Follow Up")
            {
                pVisit.PhysicianName = "";
            }
            else if (visitPurposeName == "Lab Investigation")
            {
                feeType = "INV";
                DropDownList ddlDoctor = (DropDownList)ReferDoctor1.FindControl("ddlDoctor");
                referrerName = ddlDoctor.SelectedItem.Text;
                if (ddlDoctor.SelectedItem.Text != "Others")
                {
                    if (ddlDoctor.SelectedItem.Text != "None")
                    {
                        Int64.TryParse(ddlDoctor.SelectedItem.Value, out referOrgID);
                        pVisit.PhysicianName = "";
                    }
                    else
                    {
                        referOrgID = -1;
                        pVisit.PhysicianName = "";
                    }
                }
                else
                {
                    referOrgID = -1;
                    TextBox txtothDr = (TextBox)ReferDoctor1.FindControl("txtOtherDoctors");
                    pVisit.PhysicianName = txtothDr.Text;
                }
                otherID = 0;

                if (PaymentLogic == string.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }

            }
            else if (visitPurposeName == "Health Package")
            {
                feeType = "HEALTHPKG";
                otherID = 0;

                phyID = 0;
                if (PaymentLogic == string.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }
                pVisit.PhysicianName = "";
            }
            else if (visitPurposeName == "Emergency")
            {
                pVisit.PhysicianName = "";
            }
            //else if (visitPurposeName == "Casualty")
            //{
            //    pVisit.PhysicianName = "";
            //}
            else if (visitPurposeName == "Treatment Procedure")
            {
                feeType = "PRO";
                DropDownList ddlProcedure = (DropDownList)usrProcedure.FindControl("ddlProcedureName");
                otherName = ddlProcedure.SelectedItem.Text;
                Int32.TryParse(ddlProcedure.SelectedItem.Value, out otherID);

                DropDownList ddlPhysician = (DropDownList)usrProcedure.FindControl("ddlPhysicianByProcedure");
                Int64.TryParse(ddlPhysician.SelectedItem.Value, out phyID);
                if (phyID > 0)
                {
                    physicianName = ddlPhysician.SelectedItem.Text;
                }

                if (PaymentLogic == string.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }
                pVisit.PhysicianName = "";

            }
            else if (visitPurposeName == "Letter/Certificate")
            {
                pVisit.PhysicianName = "";
            }
            else if (visitPurposeName == "Admission")
            {
                pVisit.VisitType = 1;
                pVisit.PhysicianName = "";
            }
            else if (visitPurposeName == "Immunization")
            {
                feeType = "IMU";
                otherID = 0;
                otherName = "Immunization";
                if (PaymentLogic == string.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }
                pVisit.PhysicianName = "";
            }
            else if (visitPurposeName == "Casualty")
            {
                feeType = "CAS";
                otherID = 0;
                otherName = "Casualty";
                if (PaymentLogic == string.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }
                pVisit.PhysicianName = "";
            }
           
           // int.TryParse(ddlCorporate.SelectedValue.ToString(), out CorporateID);

            pVisit.AccompaniedBy = tAccBy.Text;
            Int32.TryParse(dPurpose.SelectedValue, out purpID);

            if (visitPurposeName == "Lab Investigation")
            {
                //Int64.TryParse(dDoc.SelectedValue, out phyID);
                DropDownList ddlDoctor1 = (DropDownList)ReferDoctor1.FindControl("ddlDoctor");
                if (ddlDoctor1.SelectedItem.Text != "Others")
                {
                    if (ddlDoctor1.SelectedItem.Text != "None")
                    {
                        Int64.TryParse(ddlDoctor1.SelectedValue.ToString(), out phyID);
                        pVisit.PhysicianName = "";
                    }
                    else
                    {
                        referOrgID = -1;
                        pVisit.PhysicianName = "";
                    }
                }
                else
                {
                    phyID = -1;
                    TextBox txtothDr = (TextBox)ReferDoctor1.FindControl("txtOtherDoctors");
                    pVisit.PhysicianName = txtothDr.Text;
                }
            }

             if (visitPurposeName != "Consultation")
            {
                DropDownList ddlReferPhysician = (DropDownList)Rfrdoctor.FindControl("ddlConsultingName");
                Int32.TryParse(ddlReferPhysician.SelectedItem.Value, out otherRefID);
                if (otherRefID > 0)
                {
                    RefPhysicianName = ddlReferPhysician.SelectedItem.Text;

                    RefphysicianID = otherRefID;
                    DropDownList ddlReferSpeciality = (DropDownList)Rfrdoctor.FindControl("ddlSpeciality");
                    RefspecialityName = ddlReferSpeciality.SelectedItem.Text;
                    Int32.TryParse(ddlReferSpeciality.SelectedItem.Value, out otherSpecID);
                    RefSpecialtiyID = otherSpecID;
                }
                else
                {
                    DropDownList ddlDoctor11 = (DropDownList)ReferDoctor1.FindControl("ddlDoctor");
                    if (ddlDoctor11.SelectedItem.Text != "Others")
                    {

                        Int64.TryParse(ddlDoctor11.SelectedValue.ToString(), out phyID);
                        pVisit.PhysicianName = ddlDoctor11.SelectedItem.Text;
                    }
                    else
                    {
                        
                        TextBox txtothDr = (TextBox)ReferDoctor1.FindControl("txtOtherDoctors");
                        pVisit.PhysicianName = txtothDr.Text;
                    }
                }
                
            }
            
            
            
            //*******for Visit**************
            //pVisit.ConditionId = condID;
            pVisit.VisitPurposeID = purpID;
            pVisit.PhysicianID = (int)phyID;
            pVisit.OrgID = OrgID;
            pVisit.PatientID = patientID;
            pVisit.ReferingPhysicianID=RefphysicianID;
            pVisit.ReferingPhysicianName = RefPhysicianName;
            pVisit.ReferingSpecialityID = RefSpecialtiyID;
            pVisit.OrgAddressID = orgAddressID;
            if (visitPurposeName == "Consultation") { pVisit.SpecialityID = otherID; } else { pVisit.SpecialityID = -1; }
            pVisit.ReferOrgID = referOrgID;
            
            pVisit.CreatedBy = LID;
            
            pVisit.ParentVisitId = 0;
            pVisit.PriorityID = Convert.ToInt32(ddlPriority.SelectedValue.ToString());
            if (chkSecPage.Checked == true)
            {
                string secString = string.Empty;
                DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);                

                #region Not to delete this One Way HASH Code Generator
                //secString = patientID.ToString() + "1" + dt + OrgID;

                //SHA1 sha = new SHA1CryptoServiceProvider();
                //string hashedValue = string.Empty;
                ////hash the data
                //byte[] hashedData = sha.ComputeHash(Encoding.Unicode.GetBytes(secString));
                ////loop through each byte in the byte array
                //foreach (byte b in hashedData)
                //{
                //    //convert each byte and append
                //    hashedValue += String.Format("{0,2:X2}", b);
                //}
                #endregion

                string guidResult = System.Guid.NewGuid().ToString();
                pVisit.SecuredCode = guidResult;
                
            }
            else
            {
                pVisit.SecuredCode = "";
            }

            long visitID = -1;
            long enteredPatientID = 0;
            Int64.TryParse(Request.QueryString["PID"], out enteredPatientID);
            int iTokenNo =0;
            long lScheduleNo=0;
            long lResourceTemplateNo=0;
            string sPassedTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToLongTimeString().ToString();
            DateTime dtFromTime = new DateTime();
            DateTime dtToTime = new DateTime();

            DateTime.TryParse(hdnStartTime.Value, out dtFromTime);
            DateTime.TryParse(hdnEndTime.Value, out dtToTime);
            if (dtFromTime.ToString("dd/MM/yyyy") == "01/01/0001")
            {
                dtFromTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            }

            if (dtToTime.ToString("dd/MM/yyyy") == "01/01/0001")
            {
                dtToTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            }

            int  iRetTokenNumber=0;

            Int32.TryParse(hdnTokenNo.Value, out iTokenNo);
            Int64.TryParse(hdnScheduleID.Value, out lScheduleNo);
            Int64.TryParse(hdnResourceTemplateID.Value, out lResourceTemplateNo);
            string needIPNo = string.Empty;
            List<Config> lstCon = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("NeedIPNumber", OrgID, out lstCon);
            if (lstCon.Count > 0)
                needIPNo = lstCon[0].ConfigValue.Trim();

             List<VisitClientMapping> lst = IPClientTpaInsurance1.GetClientValues();
            returnCode = pvisitBL.SaveVisit(pVisit, out visitID, enteredPatientID,
                                            iTokenNo, lScheduleNo, lResourceTemplateNo,
                                            sPassedTime, out iRetTokenNumber, dtFromTime, dtToTime, needIPNo, lst);

            foreach (GridViewRow rows in gvKOS.Rows)
            {
                VisitKnowledgeMapping objVisitKnowledgeMapping = new VisitKnowledgeMapping();
                CheckBox chk = (CheckBox)rows.FindControl("chk");
                DropDownList ddlAttributes = (DropDownList)rows.FindControl("ddlAttributes");
                Label lblKOS = (Label)rows.FindControl("lblKOS");
                Label lblKOSID = (Label)rows.FindControl("lblKOSID");
                TextBox txtOthers = (TextBox)rows.FindControl("txtOthers");

                if (chk.Checked == true && lblKOS.Text=="Others")
                {
                    objVisitKnowledgeMapping.KnowledgeOfServiceID =Convert.ToInt16(lblKOSID.Text);
                    if (txtOthers.Text != string.Empty)
                    {
                        objVisitKnowledgeMapping.Description = txtOthers.Text;
                    }
                    else
                    {
                        objVisitKnowledgeMapping.Description = lblKOS.Text;
                    }                  
                   
                }

                if (chk.Checked == true && lblKOS.Text != "Others")
                {
                    if (ddlAttributes.SelectedItem.Text != "Other")
                    {
                        objVisitKnowledgeMapping.KnowledgeOfServiceID = Convert.ToInt16(lblKOSID.Text);
                        objVisitKnowledgeMapping.AttributeID = Convert.ToInt64(ddlAttributes.SelectedValue);
                    }
                    else
                    {
                        objVisitKnowledgeMapping.KnowledgeOfServiceID = Convert.ToInt16(lblKOSID.Text);
                        objVisitKnowledgeMapping.AttributeID = Convert.ToInt64(ddlAttributes.SelectedValue);
                        if (txtOthers.Text != string.Empty)
                        {
                            objVisitKnowledgeMapping.Description = txtOthers.Text;
                        }
                        else
                        {
                            objVisitKnowledgeMapping.Description = ddlAttributes.SelectedItem.Text;
                        }   
                    }
                }
                lstVisitKnowledgeMapping.Add(objVisitKnowledgeMapping);               
            }
            if (lstVisitKnowledgeMapping.Count > 0)
            {
                returnCode = patientBL.SaveKnowledgeOfServices(visitID, OrgID, LID, lstVisitKnowledgeMapping);
            }            
            returnCode = pvisitBL.GetTaskActionID(OrgID, purpID, otherID, out lstTaskAction);
            
            this.Page.RegisterStartupScript("kyData", "<script type='text/javascript' >alert('" + iRetTokenNumber + "');return false;</script>");


            if (visitPurposeName == "Admission")
            {
                Response.Redirect("InPatientRegistration.aspx?pid=" + Request.QueryString["PID"].ToString() + "&vid=" + visitID, true);
            }
            TaskActions taskAction = new TaskActions();
            if (lstTaskAction.Count > 0)
            {
                taskAction = lstTaskAction[0];
            }
            if (returnCode == 0)
            {
                //*******for Task*******************
                //Created by ashok to add multiple tasks
                if (visitPurposeName != "Health Package")
                {
                    for (int i = 1; i < lstTaskAction.Count; i++)
                    {
                        taskAction = lstTaskAction[i];
                        returnCode = Utilities.GetHashTable(taskAction.TaskActionID, visitID, phyID,
                                                  patientID, patient.TitleName + " " + patient.Name, physicianName,
                                                  otherID, "", 0, "", 0, "", out dText, out urlVal, 0,
                                                  patient.PatientNumber, iTokenNo, ""); // Other Id meand Procedure ID
                        task.TaskActionID = taskAction.TaskActionID;
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.PatientID = pVisit.PatientID;
                        task.AssignedTo = 0;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.SpecialityID = specialityID;
                        task.CreatedBy = LID;
                        returnCode = taskBL.CreateTask(task, out ptaskID);
                    }
                }
                // Code Ends Here 
                if (otherName == "Immunization")
                {
                    taskAction = lstTaskAction[0];
                    returnCode = Utilities.GetHashTable(taskAction.TaskActionID, visitID, phyID,
                                                  patientID, patient.TitleName + " " + patient.Name,
                                                  physicianName, otherID, "", 0, "", 0, "", out dText, 
                                                  out urlVal, 0, patient.PatientNumber, iTokenNo, ""); // Other Id meand Procedure ID
                    task.TaskActionID = taskAction.TaskActionID;
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.PatientID = pVisit.PatientID;
                    task.AssignedTo = 0;
                    task.OrgID = OrgID;
                    task.PatientVisitID = visitID;
                    task.SpecialityID = specialityID;
                    task.CreatedBy = LID;
                }
                if ((otherName != "Physiotherapy") && (otherName != "Immunization"))
                {
                    if (lstTaskAction.Count > 0)
                    {
                        taskAction = lstTaskAction[0];
                        returnCode = Utilities.GetHashTable(taskAction.TaskActionID, visitID, phyID,
                                                      patientID, patient.TitleName + " " + patient.Name, physicianName,
                                                      otherID, "", 0, "", 0, "", out dText, out urlVal, 0,
                                                      patient.PatientNumber, iTokenNo, ""); // Other Id meand Procedure ID

                        task.TaskActionID = taskAction.TaskActionID;
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.PatientID = pVisit.PatientID;
                        task.AssignedTo = phyID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.SpecialityID = specialityID;
                        task.CreatedBy = LID;
                    }
                }
                if (Request.QueryString["Rid"] != null)
                {
                    objReferrals_BL.UpdateReferralStatus(Int64.Parse(hdnRefdetailsId.Value), purpID.ToString(), 1, LID);
                }

                if(IsCorporateOrg == "Y")
                    Response.Redirect(@"~\Corporate\CorporateBilling.aspx?&pid=" + patientID + "&vid=" + visitID);

                if (PaymentLogic == "After")
                {
                    if (otherName == "Others")
                    {
                        Response.Redirect(@"~\Billing\CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&ProcID=" + otherID + "&ABI=Y", true);
                    }
                    if (visitPurposeName == "Lab Investigation")
                    {
                        //returnCode = taskBL.CreateTask(task, out ptaskID);
                        if (Request.QueryString["Rid"] != null)
                        {
                            //objReferrals_BL.UpdateReferralStatus(Int64.Parse(hdnRefId.Value), "In", 1, LID);
                            Response.Redirect(@"~\Billing\InvestigationPayment.aspx?Rid=" + hdnRefId.Value + "&pid=" + patientID + "&vid=" + visitID);
                        }
                        Response.Redirect(@"~\Investigation\InvestigationProfile.aspx?tid=" + 0 + "&vid=" + visitID + "&pid=" + patientID + "&ProcID=" + otherID);

                    }
                    if (visitPurposeName == "Health Package")
                    {
                        Response.Redirect(@"~\EMR\PackageProfile.aspx?vid=" + visitID + "&pid=" + patientID + "&purpID=" + purpID);
                    }

                    if (chkSecPage.Checked != true)
                    {
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        returnCode = taskBL.CreateTask(task, out ptaskID);
                        
                        Response.Redirect("Home.aspx", true);
                    }
                    if (chkSecPage.Checked == true)
                    {
                        if (chkSecPage.Checked == true && task.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.PerformDiagnosis))
                        {
                            task = new Tasks();
                            dText = new Hashtable();
                            urlVal = new Hashtable();

                            returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CheckPayment, visitID, phyID,
                            patientID, patient.TitleName + " " + patient.Name, physicianName, otherID, "", 0, "",
                            ptaskID, feeType, out dText, out urlVal, 0,
                            patient.PatientNumber, iTokenNo, ""); // Other Id meand Procedure ID

                            task.TaskActionID = (int)TaskHelper.TaskAction.CheckPayment;
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.PatientID = pVisit.PatientID;
                            //task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.PatientVisitID = visitID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            returnCode = taskBL.CreateTask(task, out taskID);

                            //string sScrptkey = string.Empty;
                            //string sjScript = string.Empty;
                            //sScrptkey = "Scrpt";
                            //sjScript = "<script>PopupSecPage('" + visitID + "', '" + patientID + "')</Script>";
                            //this.Page.ClientScript.RegisterStartupScript(this.GetType(), sScrptkey, sjScript);
                            //this.Page.ClientScript.RegisterStartupScript(this.GetType(), "secPagePrint", "javascript:PopupSecPage('" + visitID + "', '" + patientID + "');", true);
                            Response.Redirect("PrintSecPage.aspx?vid=" + visitID + "&pid=" + patientID + "", true);
                        }
                        else
                        {
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            returnCode = taskBL.CreateTask(task, out ptaskID);

                            Response.Redirect("Home.aspx", true);
                        }
                    }                    
                }
                else
                {
                    if (Request.QueryString["Rid"] != null)
                    {
                        objReferrals_BL.UpdateReferralStatus(Int64.Parse(hdnRefdetailsId.Value), "In", 1, LID);
                    }

                    if (visitPurposeName == "Lab Investigation")
                    {
                        //returnCode = taskBL.CreateTask(task, out ptaskID);
                        if (Request.QueryString["Rid"] != null)
                        {
                            //objReferrals_BL.UpdateReferralStatus(Int64.Parse(hdnRefId.Value), "In", 1, LID);
                            Response.Redirect(@"~\Billing\InvestigationPayment.aspx?Rid=" + hdnRefId.Value + "&pid=" + patientID + "&vid=" + visitID);
                        }
                        Response.Redirect(@"~\Investigation\InvestigationProfile.aspx?tid=" + ptaskID + "&vid=" + visitID + "&pid=" + patientID + "&ProcID=" + otherID);

                    }
                    if (visitPurposeName == "Casualty")
                    {
                        Response.Redirect(@"~\Billing\CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + "CAS" + "&tid=" + taskID.ToString() + "&ProcID=" + otherID, true);
                    }
                    if (visitPurposeName == "Health Package")
                    {
                        Response.Redirect(@"~\EMR\PackageProfile.aspx?vid=" + visitID + "&pid=" + patientID + "&purpID=" + purpID);
                    }
                    else if (otherName == "Physiotherapy")
                    {
                        Response.Redirect(@"~\Dialysis\TreatmentProcedure.aspx?tid=" + 0 + "&vid=" + visitID + "&pid=" + patientID + "&ProcID=" + otherID + "&type=p");
                    }
                    else if (otherName == "Dialysis")
                    {
                        Response.Redirect(@"~\Dialysis\TreatmentProcedure.aspx?tid=" + 0 + "&vid=" + visitID + "&pid=" + patientID + "&ProcID=" + otherID + "&type=d");
                    }
                    else if (otherName == "Radiation Therapy")
                    {
                        Response.Redirect(@"~\Dialysis\TreatmentProcedure.aspx?tid=" + 0 + "&vid=" + visitID + "&pid=" + patientID + "&ProcID=" + otherID + "&type=d");
                    }
                    else if (otherName == "Others")
                    {
                        Response.Redirect(@"~\Billing\CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&ProcID=" + otherID + "&ABI=Y", true);
                    }
                  
                    else
                    {
                        if (chkSecPage.Checked != true)
                        {
                            //if( 
                            returnCode = taskBL.CreateTask(task, out ptaskID);
                            returnCode = taskBL.UpdateTask(ptaskID, TaskHelper.TaskStatus.YetToCollectPayment, UID);
                        }

                        if (chkSecPage.Checked == true && task.TaskActionID != Convert.ToInt32(TaskHelper.TaskAction.PerformDiagnosis))
                        {
                            returnCode = taskBL.CreateTask(task, out ptaskID);
                            returnCode = taskBL.UpdateTask(ptaskID, TaskHelper.TaskStatus.YetToCollectPayment, UID);
                        }

                        // Collect payment task

                        task = new Tasks();
                        dText = new Hashtable();
                        urlVal = new Hashtable();

                        returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CheckPayment, visitID, phyID,
                        patientID, patient.TitleName + " " + patient.Name, physicianName, otherID, "",
                        0, "", ptaskID, feeType, out dText, out urlVal, 0, patient.PatientNumber, iTokenNo, ""); // Other Id meand Procedure ID

                        task.TaskActionID = (int)TaskHelper.TaskAction.CheckPayment;
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.PatientID = pVisit.PatientID;
                        //task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        returnCode = taskBL.CreateTask(task, out taskID);

                        string pConfigKey = "IsReceptionCashier";
                        string pOutStatus = string.Empty;

                        returnCode = new GateWay(base.ContextInfo).GetIsReceptionCashier(pConfigKey, OrgID, out pOutStatus);

                        if (pOutStatus != "Y")
                        {
                            if (otherName == "Others")
                            {
                                Response.Redirect(@"~\Billing\CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&ProcID=" + otherID + "&ABI=Y", true);
                            }
                            else
                            {
                                Response.Redirect(@"~\Billing\CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&ProcID=" + otherID, true);
                            }
                        }
                        else
                        {
                            List<Role> lstUserRole1 = new List<Role>();
                            string path1 = string.Empty;
                            Role role1 = new Role();
                            role1.RoleID = RoleID;
                            lstUserRole1.Add(role1);
                            returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                            Response.Redirect(Request.ApplicationPath + path1, true);
                        }


                    }
                }
            }
            else
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There was a problem while making visit entry. Please try after some time.";
                CLogger.LogWarning("Exception while calling pvisitBL.SaveVisit. returncode=" + returnCode.ToString());
                bsave.Visible = true;
                bsave.Enabled = true;
                bsave.Attributes.Add("Disabled", "false");
            }

            if (returnCode == 0)
            {
                Response.Redirect("Home.aspx", true);
            }
            else
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There was a problem while making visit entry. Please try after some time.";
                CLogger.LogWarning("Exception while calling taskBL.CreateTask. returncode=" + returnCode.ToString());
                bsave.Visible = true;
                bsave.Enabled = true;
             //   bsave.Attributes.Add("Disabled", "false");
            }
           // bsave.Attributes.Add("Disabled", "false");
            //bsave.Enabled = false;
            
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {

            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem while making visit entry. Please try after some time.";
            CLogger.LogError("Error while executing bsave_Click." + ErrorDisplay1.Status, ex);
            bsave.Visible = true;
            bsave.Enabled = true;
        }

    }

  
    

    protected void gvToken_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[3].Style.Add("display", "none");
        e.Row.Cells[6].Style.Add("display", "none");
    }
    public void LoadBookings(List<Bookings> lstBookings)
    {
        if (lstBookings.Count > 0)
        {
            gvToken.DataSource = lstBookings;
            gvToken.DataBind();
        }
        else
        {
            gvToken.Style.Add("display", "none");
        }
    }

    public void LoadScheduleTimes(List<Complaint> lstScheduleTimes)
    {
        ddlInvisibleSlots.DataSource = lstScheduleTimes;
        ddlInvisibleSlots.DataTextField = "ComplaintName";
        ddlInvisibleSlots.DataValueField = "ComplaintDesc";
        ddlInvisibleSlots.DataBind();
        ddlInvisibleSlots.Items.Insert(0, new ListItem("--Select--", "0"));

        hdnSlotCount.Value = lstScheduleTimes.Count.ToString();
    }

    private void LoadAvailabilitySchedules(List<Bookings> lstFullTimes,List<Bookings> lstBookings)
    {
        try
        {
            if (lstFullTimes.Count > 0)
            {
                gvAvailableSlots.DataSource = lstFullTimes;
                gvAvailableSlots.DataBind();
            }
            else
            {
                gvAvailableSlots.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing the GetSlots", ex);
        }
    }
    //public void LoadCorporateMaster()
    //{
    //    IP_BL invBL = new IP_BL(base.ContextInfo);
    //    List<CorporateMaster> lstCorporateMaster = new List<CorporateMaster>();
    //    invBL.GetCorporateMaster(OrgID, out lstCorporateMaster);
    //    ddlCorporate.DataSource = lstCorporateMaster;
    //    ddlCorporate.DataTextField = "CorporateName";
    //    ddlCorporate.DataValueField = "CorporateID";
    //    ddlCorporate.DataBind();
    //    ddlCorporate.Items.Insert(0, "---Select---");
    //    ddlCorporate.Items[0].Value = "0";
    //}


    protected void gvKOS_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlAttributes = (DropDownList)e.Row.FindControl("ddlAttributes");
            Label lblKOS = (Label)e.Row.FindControl("lblKOS");
            Label lblKOSID = (Label)e.Row.FindControl("lblKOSID");
            TextBox txtOthers = (TextBox)e.Row.FindControl("txtOthers");            
            
             int i=0;
             foreach (KnowledgeOfServiceAttributes objChild in lstKnowledgeOfServiceAttributes)
                {

                    if (lblKOS.Text != "Others" && lblKOSID.Text == objChild.KnowledgeOfServiceID.ToString())
                    {
                        ddlAttributes.Items.Insert(i, objChild.AttributeName);
                        ddlAttributes.Items[i].Value = objChild.AttributeID.ToString();
                        i++;
                    }
                }

             if (lblKOS.Text == "Others")
             {
                 ddlAttributes.Visible = false;
                 txtOthers.Style.Add("display", "block");
             }

             else
             {
                
                 txtOthers.Style.Add("display", "none");
             }
        }
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {
        btnPrint.Enabled = false;

        PatientVisit_BL pvisitBL = new PatientVisit_BL(base.ContextInfo);
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        PatientVisit pVisit = new PatientVisit();
        int purpID = 0;
        long phyID = -1;
        int otherID = -1;
        long referOrgID = -1;
        int orgAddressID = -1;
        string feeType = String.Empty;
        string otherName = String.Empty;
        string physicianName = String.Empty;
        string RefPhysicianName = String.Empty;
        string referrerName = string.Empty;
        long taskID = -1;
        long ptaskID = -1;
        int ClientID = 0;
        int CorporateID = 0;
        int RateID = 0;


        

        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        List<TaskActions> lstTaskAction = new List<TaskActions>();
        List<Patient> lstPatient = new List<Patient>();
        int specialityID = -1;
        int RefphysicianID = -1;
        int RefSpecialtiyID = -1;
        int otherRefID = -1;
        int otherSpecID = -1;
        long RefPhyID = -1;

        RefPhyID = Rfrdoctor.GetRefPhyID();
        RefphysicianID = Convert.ToInt32(RefPhyID);

        if (hdnPID.Value == "")
        {
            Int64.TryParse(Request.QueryString["PID"], out patientID);
        }
        else
        {
            patientID = Convert.ToInt64(hdnPID.Value);
        }

        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        long retid = new PatientVisit_BL(base.ContextInfo).GetInPatientVisitDetails(patientID, out lstPatientVisit);

        if (lstPatientVisit.Count > 0)
        {
            btnPrint.Enabled = true;
            string sPath = "Reception\\\\PatientVisit.aspx.cs_10";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('"+ sPath +"');", true);
            return;

        }
        Int32.TryParse(ddlLocatiopn.SelectedItem.Value, out orgAddressID);

        returnCode = patientBL.GetPatientDemoandAddress(patientID, out lstPatient);
        Patient patient = new Patient();
        patient = lstPatient[0];
        try
        {
            string visitPurposeName = dPurpose.SelectedItem.Text;

            if (visitPurposeName.Contains("Old Notes"))
            {
                Response.Redirect(@"~\Reception\PatientOldNotes.aspx?PID=" + patientID.ToString(), true);

            }

            if (visitPurposeName == "Consultation")
            {
                feeType = "CON";
                DropDownList ddlSpeciality = (DropDownList)usrConsulting.FindControl("ddlSpeciality");
                otherName = ddlSpeciality.SelectedItem.Text;
                Int32.TryParse(ddlSpeciality.SelectedItem.Value, out otherID);
                specialityID = otherID;
                DropDownList ddlPhysician = (DropDownList)usrConsulting.FindControl("ddlConsultingName");
                Int64.TryParse(ddlPhysician.SelectedItem.Value, out phyID);
                if (phyID > 0)
                {
                    physicianName = ddlPhysician.SelectedItem.Text;
                }

                if (PaymentLogic == string.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }
                pVisit.PhysicianName = "";

            }
            else if (visitPurposeName == "Follow Up")
            {
                pVisit.PhysicianName = "";
            }
            else if (visitPurposeName == "Lab Investigation")
            {
                feeType = "INV";
                DropDownList ddlDoctor = (DropDownList)ReferDoctor1.FindControl("ddlDoctor");
                referrerName = ddlDoctor.SelectedItem.Text;
                if (ddlDoctor.SelectedItem.Text != "Others")
                {
                    if (ddlDoctor.SelectedItem.Text != "None")
                    {
                        Int64.TryParse(ddlDoctor.SelectedItem.Value, out referOrgID);
                        pVisit.PhysicianName = "";
                    }
                    else
                    {
                        referOrgID = -1;
                        pVisit.PhysicianName = "";
                    }
                }
                else
                {
                    referOrgID = -1;
                    TextBox txtothDr = (TextBox)ReferDoctor1.FindControl("txtOtherDoctors");
                    pVisit.PhysicianName = txtothDr.Text;
                }
                otherID = 0;

                if (PaymentLogic == string.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }

            }
            else if (visitPurposeName == "Health Package")
            {
                feeType = "HEALTHPKG";
                otherID = 0;

                phyID = 0;
                if (PaymentLogic == string.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }
                pVisit.PhysicianName = "";
            }
            else if (visitPurposeName == "Emergency")
            {
                pVisit.PhysicianName = "";
            }
            //else if (visitPurposeName == "Casualty")
            //{
            //    pVisit.PhysicianName = "";
            //}
            else if (visitPurposeName == "Treatment Procedure")
            {
                feeType = "PRO";
                DropDownList ddlProcedure = (DropDownList)usrProcedure.FindControl("ddlProcedureName");
                otherName = ddlProcedure.SelectedItem.Text;
                Int32.TryParse(ddlProcedure.SelectedItem.Value, out otherID);

                DropDownList ddlPhysician = (DropDownList)usrProcedure.FindControl("ddlPhysicianByProcedure");
                Int64.TryParse(ddlPhysician.SelectedItem.Value, out phyID);
                if (phyID > 0)
                {
                    physicianName = ddlPhysician.SelectedItem.Text;
                }

                if (PaymentLogic == string.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }
                pVisit.PhysicianName = "";

            }
            else if (visitPurposeName == "Letter/Certificate")
            {
                pVisit.PhysicianName = "";
            }
            else if (visitPurposeName == "Admission")
            {
                pVisit.VisitType = 1;
                pVisit.PhysicianName = "";
            }
            else if (visitPurposeName == "Immunization")
            {
                feeType = "IMU";
                otherID = 0;
                otherName = "Immunization";
                if (PaymentLogic == string.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }
                pVisit.PhysicianName = "";
            }
            else if (visitPurposeName == "Casualty")
            {
                feeType = "CAS";
                otherID = 0;
                otherName = "Casualty";
                if (PaymentLogic == string.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }
                pVisit.PhysicianName = "";
            }
            
           // int.TryParse(ddlCorporate.SelectedValue.ToString(), out CorporateID);

            pVisit.AccompaniedBy = tAccBy.Text;
            Int32.TryParse(dPurpose.SelectedValue, out purpID);

            if (visitPurposeName == "Lab Investigation")
            {
                //Int64.TryParse(dDoc.SelectedValue, out phyID);
                DropDownList ddlDoctor1 = (DropDownList)ReferDoctor1.FindControl("ddlDoctor");
                if (ddlDoctor1.SelectedItem.Text != "Others")
                {
                    if (ddlDoctor1.SelectedItem.Text != "None")
                    {
                        Int64.TryParse(ddlDoctor1.SelectedValue.ToString(), out phyID);
                        pVisit.PhysicianName = "";
                    }
                    else
                    {
                        referOrgID = -1;
                        pVisit.PhysicianName = "";
                    }
                }
                else
                {
                    phyID = -1;
                    TextBox txtothDr = (TextBox)ReferDoctor1.FindControl("txtOtherDoctors");
                    pVisit.PhysicianName = txtothDr.Text;
                }

            }


            DropDownList ddlReferPhysician = (DropDownList)Rfrdoctor.FindControl("ddlConsultingName");
            Int32.TryParse(ddlReferPhysician.SelectedItem.Value, out otherRefID);
            if (otherRefID > 0)
            {
                RefPhysicianName = ddlReferPhysician.SelectedItem.Text;
            }
            RefphysicianID = otherRefID;
            DropDownList ddlReferSpeciality = (DropDownList)Rfrdoctor.FindControl("ddlSpeciality");
            RefspecialityName = ddlReferSpeciality.SelectedItem.Text;
            Int32.TryParse(ddlReferSpeciality.SelectedItem.Value, out otherSpecID);
            RefSpecialtiyID = otherSpecID;
            
            //*******for Visit**************
            //pVisit.ConditionId = condID;
            pVisit.VisitPurposeID = purpID;
            pVisit.PhysicianID = (int)phyID;
            pVisit.OrgID = OrgID;
            pVisit.PatientID = patientID;
            pVisit.ReferingPhysicianID = RefphysicianID;
            pVisit.ReferingSpecialityID = RefSpecialtiyID;
            pVisit.OrgAddressID = orgAddressID;
            if (visitPurposeName == "Consultation") { pVisit.SpecialityID = otherID; } else { pVisit.SpecialityID = -1; }
            pVisit.ReferOrgID = referOrgID;
            
            pVisit.ParentVisitId = 0;
            pVisit.PriorityID = Convert.ToInt32(ddlPriority.SelectedValue.ToString());
            if (chkSecPage.Checked == true)
            {
                string secString = string.Empty;
                DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);


                #region Not to delete this One Way HASH Code Generator
                //secString = patientID.ToString() + "1" + dt + OrgID;

                //SHA1 sha = new SHA1CryptoServiceProvider();
                //string hashedValue = string.Empty;
                ////hash the data
                //byte[] hashedData = sha.ComputeHash(Encoding.Unicode.GetBytes(secString));
                ////loop through each byte in the byte array
                //foreach (byte b in hashedData)
                //{
                //    //convert each byte and append
                //    hashedValue += String.Format("{0,2:X2}", b);
                //}
                #endregion

                string guidResult = System.Guid.NewGuid().ToString();
                pVisit.SecuredCode = guidResult;

            }
            else
            {
                pVisit.SecuredCode = "";
            }

            long visitID = -1;
            long enteredPatientID = 0;
            Int64.TryParse(Request.QueryString["PID"], out enteredPatientID);
            int iTokenNo = 0;
            long lScheduleNo = 0;
            long lResourceTemplateNo = 0;
            string sPassedTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToLongTimeString().ToString();
            DateTime dtFromTime = new DateTime();
            DateTime dtToTime = new DateTime();

            DateTime.TryParse(hdnStartTime.Value, out dtFromTime);
            DateTime.TryParse(hdnEndTime.Value, out dtToTime);
            if (dtFromTime.ToString("dd/MM/yyyy") == "01/01/0001")
            {
                dtFromTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            }

            if (dtToTime.ToString("dd/MM/yyyy") == "01/01/0001")
            {
                dtToTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            }

            int iRetTokenNumber = 0;

            Int32.TryParse(hdnTokenNo.Value, out iTokenNo);
            Int64.TryParse(hdnScheduleID.Value, out lScheduleNo);
            Int64.TryParse(hdnResourceTemplateID.Value, out lResourceTemplateNo);
            string needIPNo = string.Empty;
            List<Config> lstCon = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("NeedIPNumber", OrgID, out lstCon);
            if (lstCon.Count > 0)
                needIPNo = lstCon[0].ConfigValue.Trim();
            List<VisitClientMapping> lst = IPClientTpaInsurance1.GetClientValues();
            returnCode = pvisitBL.SaveVisit(pVisit, out visitID, enteredPatientID,
                                            iTokenNo, lScheduleNo, lResourceTemplateNo,
                                            sPassedTime, out iRetTokenNumber, dtFromTime, dtToTime, needIPNo, lst);

            //this.Page.RegisterStartupScript("strPrint", "<script type='text/javascript'> popupprint(); </script>");
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "strPrint", "javascript:popupprint();", true);
            foreach (GridViewRow rows in gvKOS.Rows)
            {
                VisitKnowledgeMapping objVisitKnowledgeMapping = new VisitKnowledgeMapping();
                CheckBox chk = (CheckBox)rows.FindControl("chk");
                DropDownList ddlAttributes = (DropDownList)rows.FindControl("ddlAttributes");
                Label lblKOS = (Label)rows.FindControl("lblKOS");
                Label lblKOSID = (Label)rows.FindControl("lblKOSID");
                TextBox txtOthers = (TextBox)rows.FindControl("txtOthers");

                if (chk.Checked == true && lblKOS.Text == "Others")
                {
                    objVisitKnowledgeMapping.KnowledgeOfServiceID = Convert.ToInt16(lblKOSID.Text);
                    if (txtOthers.Text != string.Empty)
                    {
                        objVisitKnowledgeMapping.Description = txtOthers.Text;
                    }
                    else
                    {
                        objVisitKnowledgeMapping.Description = lblKOS.Text;
                    }

                }

                if (chk.Checked == true && lblKOS.Text != "Others")
                {
                    if (ddlAttributes.SelectedItem.Text != "Other")
                    {
                        objVisitKnowledgeMapping.KnowledgeOfServiceID = Convert.ToInt16(lblKOSID.Text);
                        objVisitKnowledgeMapping.AttributeID = Convert.ToInt64(ddlAttributes.SelectedValue);
                    }
                    else
                    {
                        objVisitKnowledgeMapping.KnowledgeOfServiceID = Convert.ToInt16(lblKOSID.Text);
                        objVisitKnowledgeMapping.AttributeID = Convert.ToInt64(ddlAttributes.SelectedValue);
                        if (txtOthers.Text != string.Empty)
                        {
                            objVisitKnowledgeMapping.Description = txtOthers.Text;
                        }
                        else
                        {
                            objVisitKnowledgeMapping.Description = ddlAttributes.SelectedItem.Text;
                        }
                    }

                }

                lstVisitKnowledgeMapping.Add(objVisitKnowledgeMapping);

            }

            if (lstVisitKnowledgeMapping.Count > 0)
            {
                returnCode = patientBL.SaveKnowledgeOfServices(visitID, OrgID, LID, lstVisitKnowledgeMapping);
            }


            returnCode = pvisitBL.GetTaskActionID(OrgID, purpID, otherID, out lstTaskAction);

            this.Page.RegisterStartupScript("kyData", "<script type='text/javascript' >alert('" + iRetTokenNumber + "');return false;</script>");

            if (visitPurposeName == "Admission")
            {
                hdnURL.Value = Request.ApplicationPath + @"/Reception/InPatientRegistration.aspx?pid=" + Request.QueryString["PID"].ToString() + "&vid=" + visitID;
                //Response.Redirect("InPatientRegistration.aspx?pid=" + Request.QueryString["PID"].ToString() + "&vid=" + visitID, true);
                System.Text.StringBuilder sbb = new System.Text.StringBuilder("");
                {
                    sbb.Append("<script language='JavaScript'>");
                    sbb.Append("var ScreenWidth = window.screen.width;");
                    sbb.Append("var ScreenHeight = window.screen.height;");
                    sbb.Append("var movefromedge = 0;");
                    sbb.Append("var WinPop = window.open('printpopup.aspx?pid=" + patientID + "&OP=Y&IsPopup=Y', '', 'toolbar=0,location=0,directories=0,status=0,scrollbars=1,menubar=1,resizable=1,');");
                    //sb.Append("Show('PrintPatientRegistration.aspx');");
                    //hdnURL.Value = hdnURL.Value + "&OP=Y";
                    sbb.Append("window.location.href='" + hdnURL.Value + "&IsPopup=Y';");
                    sbb.Append("</script>");
                }


                Page.RegisterStartupScript("Print", sbb.ToString());
            }

            TaskActions taskAction = new TaskActions();

            taskAction = lstTaskAction[0];

            if (returnCode == 0)
            {

                //*******for Task*******************
                //Created by ashok to add multiple tasks
                for (int i = 1; i < lstTaskAction.Count; i++)
                {
                    taskAction = lstTaskAction[i];

                    returnCode = Utilities.GetHashTable(taskAction.TaskActionID, visitID, phyID,
                                              patientID, patient.TitleName + " " + patient.Name, 
                                              physicianName, otherID, "", 0, "", 0, "", out dText, out urlVal, 0,
                                              patient.PatientNumber, iTokenNo, ""); // Other Id meand Procedure ID
                    task.TaskActionID = taskAction.TaskActionID;
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.PatientID = pVisit.PatientID;

                    task.AssignedTo = 0;
                    task.OrgID = OrgID;
                    task.PatientVisitID = visitID;
                    task.SpecialityID = specialityID;
                    task.CreatedBy = LID;
                    returnCode = taskBL.CreateTask(task, out ptaskID);
                }
                // Code Ends Here 
                if (otherName == "Immunization")
                {
                    taskAction = lstTaskAction[0];
                    returnCode = Utilities.GetHashTable(taskAction.TaskActionID, visitID, phyID,
                                                  patientID, patient.TitleName + " " + patient.Name, 
                                                  physicianName, otherID, "", 0, "", 0, "", out dText, out urlVal, 0,
                                                  patient.PatientNumber, iTokenNo, ""); // Other Id meand Procedure ID

                    task.TaskActionID = taskAction.TaskActionID;
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.PatientID = pVisit.PatientID;
                    task.AssignedTo = 0;
                    task.OrgID = OrgID;
                    task.PatientVisitID = visitID;
                    task.SpecialityID = specialityID;
                    task.CreatedBy = LID;
                }
                if ((otherName != "Physiotherapy") && (otherName != "Immunization"))
                {
                    taskAction = lstTaskAction[0];
                    returnCode = Utilities.GetHashTable(taskAction.TaskActionID, visitID, phyID,
                                                  patientID, patient.TitleName + " " + patient.Name, 
                                                  physicianName, otherID, "", 0, "", 0, "", out dText, out urlVal, 0, 
                                                  patient.PatientNumber, iTokenNo, ""); // Other Id meand Procedure ID

                    task.TaskActionID = taskAction.TaskActionID;
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.PatientID = pVisit.PatientID;
                    task.AssignedTo = phyID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = visitID;
                    task.SpecialityID = specialityID;
                    task.CreatedBy = LID;
                }
                if (Request.QueryString["Rid"] != null)
                {
                    objReferrals_BL.UpdateReferralStatus(Int64.Parse(hdnRefdetailsId.Value), purpID.ToString(), 1, LID);
                }

                if (PaymentLogic == "After")
                {
                    if (otherName == "Others")
                    {
                        hdnURL.Value = Request.ApplicationPath + @"/Billing/CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&ProcID=" + otherID + "&ABI=Y";
                        //Response.Redirect(@"~\Billing\CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&ProcID=" + otherID + "&ABI=Y", true);
                    }
                    if (visitPurposeName == "Lab Investigation")
                    {
                        //returnCode = taskBL.CreateTask(task, out ptaskID);
                        if (Request.QueryString["Rid"] != null)
                        {
                            //objReferrals_BL.UpdateReferralStatus(Int64.Parse(hdnRefId.Value), "In", 1, LID);
                            hdnURL.Value = Request.ApplicationPath + @"/Billing/InvestigationPayment.aspx?Rid=" + hdnRefId.Value + "&pid=" + patientID + "&vid=" + visitID;
                            //Response.Redirect(@"~\Billing\InvestigationPayment.aspx?Rid=" + hdnRefId.Value + "&pid=" + patientID + "&vid=" + visitID);
                        }
                        hdnURL.Value = Request.ApplicationPath + @"/Investigation/InvestigationProfile.aspx?tid=" + 0 + "&vid=" + visitID + "&pid=" + patientID + "&ProcID=" + otherID;
                        //Response.Redirect(@"~\Investigation\InvestigationProfile.aspx?tid=" + 0 + "&vid=" + visitID + "&pid=" + patientID + "&ProcID=" + otherID);

                    }
                    if (visitPurposeName == "Health Package")
                    {
                        hdnURL.Value = Request.ApplicationPath + @"/EMR/PackageProfile.aspx?vid=" + visitID + "&pid=" + patientID + "&purpID=" + purpID;
                        //Response.Redirect(@"~\EMR\PackageProfile.aspx?vid=" + visitID + "&pid=" + patientID + "&purpID=" + purpID);
                    }

                    if (chkSecPage.Checked != true)
                    {
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        returnCode = taskBL.CreateTask(task, out ptaskID);

                        Response.Redirect("Home.aspx", true);
                    }
                    if (chkSecPage.Checked == true)
                    {
                        if (chkSecPage.Checked == true && task.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.PerformDiagnosis))
                        {
                            task = new Tasks();
                            dText = new Hashtable();
                            urlVal = new Hashtable();

                            returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CheckPayment, visitID, phyID,
                            patientID, patient.TitleName + " " + patient.Name, physicianName, otherID, "", 0, 
                            "", ptaskID, feeType, out dText, out urlVal, 0, patient.PatientNumber, iTokenNo, ""); // Other Id meand Procedure ID

                            task.TaskActionID = (int)TaskHelper.TaskAction.CheckPayment;
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.PatientID = pVisit.PatientID;
                            //task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.PatientVisitID = visitID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            returnCode = taskBL.CreateTask(task, out taskID);

                            //string sScrptkey = string.Empty;
                            //string sjScript = string.Empty;
                            //sScrptkey = "Scrpt";
                            //sjScript = "<script>PopupSecPage('" + visitID + "', '" + patientID + "')</Script>";
                            //this.Page.ClientScript.RegisterStartupScript(this.GetType(), sScrptkey, sjScript);
                            //this.Page.ClientScript.RegisterStartupScript(this.GetType(), "secPagePrint", "javascript:PopupSecPage('" + visitID + "', '" + patientID + "');", true);
                            Response.Redirect("PrintSecPage.aspx?vid=" + visitID + "&pid=" + patientID + "", true);
                        }
                        else
                        {
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            returnCode = taskBL.CreateTask(task, out ptaskID);

                            Response.Redirect("Home.aspx", true);
                        }

                    }
                    System.Text.StringBuilder sba = new System.Text.StringBuilder("");
                    {
                        sba.Append("<script language='JavaScript'>");
                        sba.Append("var ScreenWidth = window.screen.width;");
                        sba.Append("var ScreenHeight = window.screen.height;");
                        sba.Append("var movefromedge = 0;");
                        sba.Append("var WinPop = window.open('printpopup.aspx?pid=" + patientID + "&vid=" + visitID + "&OP=Y&IsPopup=Y', '', 'toolbar=0,location=0,directories=0,status=0,scrollbars=1,menubar=1,resizable=1,');");
                        //sb.Append("Show('PrintPatientRegistration.aspx');");
                        //hdnURL.Value = hdnURL.Value + "&OP=Y";
                        sba.Append("window.location.href='" + hdnURL.Value + "&IsPopup=Y';");
                        sba.Append("</script>");
                    }


                    Page.RegisterStartupScript("Print", sba.ToString());

                }
                else
                {
                    if (Request.QueryString["Rid"] != null)
                    {
                        objReferrals_BL.UpdateReferralStatus(Int64.Parse(hdnRefdetailsId.Value), "In", 1, LID);
                    }

                    if (visitPurposeName == "Lab Investigation")
                    {
                        //returnCode = taskBL.CreateTask(task, out ptaskID);
                        if (Request.QueryString["Rid"] != null)
                        {
                            //objReferrals_BL.UpdateReferralStatus(Int64.Parse(hdnRefId.Value), "In", 1, LID);
                            hdnURL.Value = Request.ApplicationPath + @"/Billing/InvestigationPayment.aspx?Rid=" + hdnRefId.Value + "&pid=" + patientID + "&vid=" + visitID;
                            //Response.Redirect(@"~\Billing\InvestigationPayment.aspx?Rid=" + hdnRefId.Value + "&pid=" + patientID + "&vid=" + visitID);
                        }
                        hdnURL.Value = Request.ApplicationPath + @"/Investigation/InvestigationProfile.aspx?tid=" + 0 + "&vid=" + visitID + "&pid=" + patientID + "&ProcID=" + otherID;
                        //Response.Redirect(@"~\Investigation\InvestigationProfile.aspx?tid=" + 0 + "&vid=" + visitID + "&pid=" + patientID + "&ProcID=" + otherID);
                        System.Text.StringBuilder sblab = new System.Text.StringBuilder("");
                        {
                            sblab.Append("<script language='JavaScript'>");
                            sblab.Append("var ScreenWidth = window.screen.width;");
                            sblab.Append("var ScreenHeight = window.screen.height;");
                            sblab.Append("var movefromedge = 0;");
                            sblab.Append("var WinPop = window.open('printpopup.aspx?pid=" + patientID + "&vid=" + visitID + "&OP=Y&IsPopup=Y', '', 'toolbar=0,location=0,directories=0,status=0,scrollbars=1,menubar=1,resizable=1,');");
                            //sb.Append("Show('PrintPatientRegistration.aspx');");
                            //hdnURL.Value = hdnURL.Value + "&OP=Y";
                            sblab.Append("window.location.href='" + hdnURL.Value + "&IsPopup=Y';");
                            sblab.Append("</script>");
                        }


                        Page.RegisterStartupScript("Print", sblab.ToString());

                    }
                    if (visitPurposeName == "Casualty")
                    {
                        hdnURL.Value = Request.ApplicationPath + @"/Billing/CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + "CAS" + "&tid=" + taskID.ToString() + "&ProcID=" + otherID;
                        //Response.Redirect(@"~\Billing\CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + "CAS" + "&tid=" + taskID.ToString() + "&ProcID=" + otherID, true);
                    }
                    if (visitPurposeName == "Health Package")
                    {
                        hdnURL.Value = Request.ApplicationPath + @"/EMR/PackageProfile.aspx?vid=" + visitID + "&pid=" + patientID + "&purpID=" + purpID;
                        //Response.Redirect(@"~\EMR\PackageProfile.aspx?vid=" + visitID + "&pid=" + patientID + "&purpID=" + purpID);
                    }
                    else if (otherName == "Physiotherapy")
                    {
                        hdnURL.Value = Request.ApplicationPath + @"/Dialysis/TreatmentProcedure.aspx?tid=" + 0 + "&vid=" + visitID + "&pid=" + patientID + "&ProcID=" + otherID + "&type=p";
                        //Response.Redirect(@"~\Dialysis\TreatmentProcedure.aspx?tid=" + 0 + "&vid=" + visitID + "&pid=" + patientID + "&ProcID=" + otherID + "&type=p");
                    }
                    else if (otherName == "Dialysis")
                    {
                        hdnURL.Value = Request.ApplicationPath + @"/Dialysis/TreatmentProcedure.aspx?tid=" + 0 + "&vid=" + visitID + "&pid=" + patientID + "&ProcID=" + otherID + "&type=d";
                        //Response.Redirect(@"~\Dialysis\TreatmentProcedure.aspx?tid=" + 0 + "&vid=" + visitID + "&pid=" + patientID + "&ProcID=" + otherID + "&type=d");
                    }
                    else if (otherName == "Others")
                    {
                        hdnURL.Value = Request.ApplicationPath + @"/Billing/CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&ProcID=" + otherID + "&ABI=Y";
                        //Response.Redirect(@"~\Billing\CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&ProcID=" + otherID + "&ABI=Y", true);
                    }
                    else
                    {
                        if (chkSecPage.Checked != true)
                        {
                            //if( 
                            returnCode = taskBL.CreateTask(task, out ptaskID);
                            returnCode = taskBL.UpdateTask(ptaskID, TaskHelper.TaskStatus.YetToCollectPayment, UID);
                        }

                        if (chkSecPage.Checked == true && task.TaskActionID != Convert.ToInt32(TaskHelper.TaskAction.PerformDiagnosis))
                        {
                            returnCode = taskBL.CreateTask(task, out ptaskID);
                            returnCode = taskBL.UpdateTask(ptaskID, TaskHelper.TaskStatus.YetToCollectPayment, UID);
                        }

                        // Collect payment task

                        task = new Tasks();
                        dText = new Hashtable();
                        urlVal = new Hashtable();

                        returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CheckPayment, visitID, phyID,
                        patientID, patient.TitleName + " " + patient.Name, physicianName, otherID, "", 0, "", 
                        ptaskID, feeType, out dText, out urlVal, 0,patient.PatientNumber, iTokenNo, ""); // Other Id meand Procedure ID

                        task.TaskActionID = (int)TaskHelper.TaskAction.CheckPayment;
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.PatientID = pVisit.PatientID;
                        //task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        returnCode = taskBL.CreateTask(task, out taskID);

                        string pConfigKey = "IsReceptionCashier";
                        string pOutStatus = string.Empty;

                        returnCode = new GateWay(base.ContextInfo).GetIsReceptionCashier(pConfigKey, OrgID, out pOutStatus);

                        if (pOutStatus != "Y")
                        {
                            if (otherName == "Others")
                            {
                                hdnURL.Value = Request.ApplicationPath + @"/Billing/CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&ProcID=" + otherID + "&ABI=Y";
                                //Response.Redirect(@"~\Billing\CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&ProcID=" + otherID + "&ABI=Y", true);
                            }
                            else
                            {
                                hdnURL.Value = Request.ApplicationPath + @"/Billing/CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&ProcID=" + otherID;
                                //Response.Redirect(@"~\Billing\CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&ProcID=" + otherID, true);
                            }
                        }
                        else
                        {
                            List<Role> lstUserRole1 = new List<Role>();
                            string path1 = string.Empty;
                            Role role1 = new Role();
                            role1.RoleID = RoleID;
                            lstUserRole1.Add(role1);
                            returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                            Response.Redirect(Request.ApplicationPath + path1, true);
                        }


                    }
                }
            }
            else
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There was a problem while making visit entry. Please try after some time.";
                CLogger.LogWarning("Exception while calling pvisitBL.SaveVisit. returncode=" + returnCode.ToString());
                btnPrint.Visible = true;
                btnPrint.Enabled = true;
            }

            System.Text.StringBuilder sb = new System.Text.StringBuilder("");
            {
                sb.Append("<script language='JavaScript'>");
                sb.Append("var ScreenWidth = window.screen.width;");
                sb.Append("var ScreenHeight = window.screen.height;");
                sb.Append("var movefromedge = 0;");
                sb.Append("var WinPop = window.open('printpopup.aspx?pid=" + patientID + "&vid=" + visitID + "&OP=Y&IsPopup=Y', '', 'toolbar=0,location=0,directories=0,status=0,scrollbars=1,menubar=1,resizable=1,');");
                //sb.Append("Show('PrintPatientRegistration.aspx');");
                //hdnURL.Value = hdnURL.Value + "&OP=Y";
                sb.Append("window.location.href='" + hdnURL.Value + "&IsPopup=Y';");
                sb.Append("</script>");
            }
            Page.RegisterStartupScript("Print", sb.ToString());
            //if (returnCode == 0)
            //{
            //    Response.Redirect("Home.aspx", true);
            //}
            //else
            //{
            //    ErrorDisplay1.ShowError = true;
            //    ErrorDisplay1.Status = "There was a problem while making visit entry. Please try after some time.";
            //    CLogger.LogWarning("Exception while calling taskBL.CreateTask. returncode=" + returnCode.ToString());
            //    btnPrint.Visible = true;
            //    btnPrint.Enabled = true;
            //}
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem while making visit entry. Please try after some time.";
            CLogger.LogError("Error while executing btnPrint_Click." + ErrorDisplay1.Status, ex);
            btnPrint.Visible = true;
            btnPrint.Enabled = true;
        }
    }
}
