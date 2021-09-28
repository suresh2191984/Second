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
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using System.Text;
using Attune.Podium.Common;
using System.Web.Caching;

public partial class Reception_PatientSampleRegistration : BasePage
{
    long LabRefOrgID = -1;
    long PPatientID = -1;
    int pPriorityID = -1;
    int pCollectionCentreID = 0;
    int pAge = 0;
    string pPriorityName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        long result = -1;
        ddSalutation.Attributes.Add("onchange", "setSexValue('" + ddSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
        ddSex.Attributes.Add("onchange", "setSexValue('" + ddSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
        txtDrName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        txtPatientName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        txtName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        txtAge.Attributes.Add("onblur", "age();");
        txtAge.Attributes.Add("onkeydown", "return ValidateOnlyNumeric(this));");      
        try
        {
            Int64.TryParse(Request.QueryString["pid"], out PPatientID);
            txtMobile.Attributes.Add("onKeyDown", "return ValidateOnlyNumeric(this);");
            if (IsPostBack)
            {
                if (rdoHospital.Checked)
                {
                    CTHospital.Style.Add("display", "block");
                    CTBranch.Style.Add("display", "none");
                    rdoHospital.Checked = true;
                    rdoBranch.Checked = false;
                }
                else if (rdoBranch.Checked)
                {
                    CTHospital.Style.Add("display", "none");
                    CTBranch.Style.Add("display", "block");
                    rdoHospital.Checked = false;
                    rdoBranch.Checked = true;
                }

              
            }
            if (!IsPostBack)
            {
                LoadTitle();
                LoadPublishingMode();
                LoadReferingPhysician();
                LoadInvClientMaster();
                LoadHospitalBranch();
                LoadPriority();
                LoadCollectionCentre();
                
                if (PPatientID != 0)
                {
                    Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                    List<Patient> patientList = new List<Patient>();
                    result = patientBL.GetLabPatientDemoandAddress(PPatientID, out patientList);
                    txtPatientName.Text = patientList[0].Name;
                    ddSalutation.SelectedValue= patientList[0].TITLECode.ToString();
                    ddSex.SelectedValue = patientList[0].SEX.ToString();
                    txtAge.Text = patientList[0].Age.ToString();
                    ddlAgeUnit.SelectedValue = patientList[0].Age;
                    if (patientList[0].PatientAddress.Count != 0)
                    {
                        patientAddressCtrl.SetAddress(patientList[0].PatientAddress[0]);
                       
                    }
                    else
                    {
                       // txtMobile.Text = "";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error in SampleRegistration.aspx:Page_Load", ex);
        }
    }
    private void LoadTitle()
    {
        try
        {
            long returnCode = -1;
            Title_BL titelBL = new Title_BL(base.ContextInfo);
            List<Salutation> titles = new List<Salutation>();
            string LanguageCode = string.Empty;
            LanguageCode = ContextInfo.LanguageCode;
            if (Cache["titles"] == null)
            {
                returnCode = titelBL.GetTitle(OrgID, LanguageCode, out titles);
                if (returnCode == 0)
                {
                    Cache.Add("titles", titles,null,Cache.NoAbsoluteExpiration,Cache.NoSlidingExpiration,CacheItemPriority.Normal,null);
                }
            }
            else
            {
                titles = (List<Salutation>)Cache["titles"];
                returnCode = 0;
            }
            returnCode = titelBL.GetTitle(OrgID, LanguageCode, out titles);
            Salutation selectedSalutation = new Salutation();
            int titleID = 0;
            if (returnCode == 0)
            {
                ddSalutation.DataSource = titles;
                ddSalutation.DataTextField = "TitleName";
                ddSalutation.DataValueField = "TitleID";
                ddSalutation.DataBind();

                selectedSalutation = titles.Find(Findsalutation);
                ddSalutation.SelectedValue = selectedSalutation.TitleID.ToString();
                Int32.TryParse(ddSalutation.SelectedItem.Value, out titleID);
            }
            else
            {
                CLogger.LogWarning("Salutation cannot be retrieved");
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Loading Salutation in Patient Sample Registration.Message:", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }    
    public void LoadPublishingMode()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<PublishingMode> getPublishingMode = new List<PublishingMode>();
            if (Cache["PublishMode"] == null)
            {
                retCode = patBL.GetPublishingMode(out getPublishingMode);
                Cache.Add("PublishMode", getPublishingMode, null, Cache.NoAbsoluteExpiration, new TimeSpan(12, 0, 0), CacheItemPriority.Normal, null);
            }
            else
            {
                //Cache.Remove("PublishMode");
                getPublishingMode = (List<PublishingMode>)Cache["PublishMode"];
            }

            if (getPublishingMode.Count> 0)
            {
                
                ddPublishingMode.DataSource = getPublishingMode;
                ddPublishingMode.DataTextField = "ModeName";
                ddPublishingMode.DataValueField = "ModeID";
                ddPublishingMode.DataBind();
                ddPublishingMode.Items.Insert(0, "-----Select-----");
                ddPublishingMode.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Publishing Mode Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }




    public void LoadPriority()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<PriorityMaster> getPriorityMaster = new List<PriorityMaster>();
            retCode = patBL.GetPriorityMaster(out getPriorityMaster);
            if (retCode==0)
            {
                ddlPriority.DataSource = getPriorityMaster;
                ddlPriority.DataTextField = "PriorityName";
                ddlPriority.DataValueField = "PriorityID";
                ddlPriority.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Priority Master Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    public void LoadReferingPhysician()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<ReferingPhysician> getReferingPhysician = new List<ReferingPhysician>();
            retCode = patBL.GetReferingPhysician(OrgID, "","",out getReferingPhysician);
            if (retCode == 0)
            {
                ddlPhysician.DataSource = getReferingPhysician;
                ddlPhysician.DataTextField = "PhysicianName";
                ddlPhysician.DataValueField = "ReferingPhysicianID";
                ddlPhysician.DataBind();
                ddlPhysician.Items.Insert(0, "-----Select-----");
                ddlPhysician.Items[0].Value = "0";
              
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Refering Physician Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    public void LoadInvClientMaster()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            List<InvClientMaster> getInvClientMaster = new List<InvClientMaster>();           
            retCode = patBL.GetInvClientMaster(OrgID,"D", out getInvClientMaster);          
                   
          
                ddlClients.DataSource = getInvClientMaster;
                ddlClients.DataTextField = "ClientName";
                ddlClients.DataValueField = "ClientID";
                ddlClients.DataBind();
                ddlClients.Items.Insert(0, "-----Select-----");
                ddlClients.Items[0].Value = "0";
          


            List<PatientInvestigation> lstInvestigation = new List<PatientInvestigation>();          
            retCode = investigationBL.GetInvestigationByClientID(OrgID, 0, "INS", out lstInvestigation);
            if (retCode == 0)
            {


                ddlPkg.DataSource = lstInvestigation;
                ddlPkg.DataTextField = "GroupNameRate";
                ddlPkg.DataValueField = "GroupID";
                ddlPkg.DataBind();
                ddlPkg.Items.Insert(0, "-----Select-----");
                ddlPkg.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading InvClientMaster Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    void ddlPkg_DataBinding(object sender, EventArgs e)
    {
        
    }    

    public void LoadHospitalBranch()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<LabReferenceOrg> RefOrg = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Hospital = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Branch = new List<LabReferenceOrg>();
            retCode = patBL.GetLabRefOrg(OrgID, 0,"D", out RefOrg);
            Hospital = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 1; });
            Branch = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 2; });
            if (retCode == 0)
            {
                ddlHospital.DataSource = Hospital;
                ddlHospital.DataTextField = "RefOrgName";
                ddlHospital.DataValueField = "LabRefOrgID";
                ddlHospital.DataBind();
                ddlHospital.Items.Insert(0, "-----Select-----");
                ddlHospital.Items[0].Value = "0";

                ddlBranch.DataSource = Branch;
                ddlBranch.DataTextField = "RefOrgName";
                ddlBranch.DataValueField = "LabRefOrgID";
                ddlBranch.DataBind();
                ddlBranch.Items.Insert(0, "-----Select-----");
                ddlBranch.Items[0].Value = "0";

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Hospital Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    


    static bool Findsalutation(Salutation s)
    {
        if (s.TitleName.ToUpper().Trim() == "MR.")
        {
            return true;
        }
        return false;
    }
    
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
        long returnCode = -1;
        long pVisitID = -1;
        long pPatientID = -1;
        int pClientID = -1;
        int pRefPhyID=-1;
        int PayerTypeID = -1;
        string PayerName = string.Empty;
        try
        {
                PatientVisit pVisit = new PatientVisit();
                PatientVisit labVisit = new PatientVisit();
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
                pPriorityID = Convert.ToInt32(ddlPriority.SelectedValue);
                pPriorityName = ddlPriority.SelectedItem.Text;
                labVisit.PriorityID = pPriorityID;
            if (ddlCollectionCentre.SelectedValue != "0")
            {
                pCollectionCentreID = Convert.ToInt32(ddlCollectionCentre.SelectedValue);
            }
            if (ddlPhysician.SelectedValue != "0" && chkPhyOthers.Checked!=true)
            {
                labVisit.ReferingPhysicianID = Convert.ToInt32(ddlPhysician.SelectedValue);
                labVisit.ReferingPhysicianName = ddlPhysician.SelectedItem.Text;
            }
            else
            {
                ReferingPhysician refPhy = new ReferingPhysician();
                refPhy.OrgID = OrgID;
                refPhy.PhysicianName = txtDrName.Text;
                refPhy.Qualification = txtDrQualification.Text;
                refPhy.OrganizationName = txtDrOrganization.Text;
                patientBL.SaveReferingPhysician(refPhy, out pRefPhyID);
                labVisit.ReferingPhysicianID = pRefPhyID;
                labVisit.ReferingPhysicianName = txtDrName.Text;
            }
            //Setting Hospital and Branch
            if(ddlCollectionCentre.SelectedValue!="0")
            {
                labVisit.CollectionCentreID = Convert.ToInt32(ddlCollectionCentre.SelectedValue);
                labVisit.CollectionCentreName = ddlCollectionCentre.SelectedItem.Text;
            }
            if (rdoHospital.Checked)
            {
                labVisit.HospitalID = Convert.ToInt32(ddlHospital.SelectedValue);
                labVisit.HospitalName = ddlHospital.SelectedItem.Text;
            }
            if (rdoBranch.Checked)
            {
                labVisit.HospitalID = Convert.ToInt32(ddlBranch.SelectedValue);
                labVisit.HospitalName = ddlBranch.SelectedItem.Text;
            }
            
            if (rdPackage.Checked)
            {
                if (ddlPkg.SelectedItem.Text.Contains("-"+CurrencyName+":"))
                {
                    int rIndex = ddlPkg.SelectedItem.Text.IndexOf("-"+CurrencyName+":");
                    labVisit.ClientName = ddlPkg.SelectedItem.Text.Substring(0, rIndex);
                }
                labVisit.ClientMappingDetailsID = Convert.ToInt32(ddlPkg.SelectedValue);
                pClientID = Convert.ToInt32(ddlPkg.SelectedValue);
            }
            else if (rdClient.Checked)
            {
                labVisit.ClientMappingDetailsID = Convert.ToInt32(ddlClients.SelectedValue);
                labVisit.ClientName = ddlClients.SelectedItem.Text;
                pClientID = Convert.ToInt32(ddlClients.SelectedValue);
            }
            
            if (PPatientID == 0)
            {
                Patient patient = new Patient();
                PatientAddress pAddress = new PatientAddress();
                patient.Name = txtPatientName.Text;
                patient.OrgID = OrgID;
                patient.CreatedBy = LID;
                patient.SEX = ddSex.SelectedValue;
                if (txtAge.Text != string.Empty)
                {
                    patient.Age = txtAge.Text + " " + ddlAgeUnit.Text;
                    //patient.AgeUnit = ddlAgeUnit.Text;
                     pAge = Convert.ToInt32(txtAge.Text);
                }
               
                  
               
                patient.TITLECode = Convert.ToByte(ddSalutation.SelectedValue);
                //pAddress.MobileNumber = txtMobile.Text;
                pAddress = patientAddressCtrl.GetAddress();
               
                returnCode = patientBL.SaveSampleRegistrationDetails(patient, pAddress, labVisit, out pVisitID, ILocationID, out pPatientID, pAge,
                    ddlAgeUnit.SelectedValue, PayerTypeID, PayerName, lstVisitClientMapping);

            }
            else if(PPatientID>0)
            {
                pPatientID = PPatientID;
                labVisit.OrgID = OrgID;
                labVisit.PatientID = PPatientID;
                labVisit.CreatedBy = LID;
                returnCode = patientBL.SaveLabVisitDetails(labVisit,out pVisitID);
            }
            if (returnCode == 0)
            {
                ResultPublishing resultPub = new ResultPublishing();
                PatientAddress sadd = shippingAddress.GetAddress();
                resultPub.PatientVisitID = pVisitID;
                resultPub.OrgID = OrgID;
                resultPub.CreatedBy = LID;
                if (txtEmailID.Text != string.Empty)
                {
                    resultPub.Value = txtEmailID.Text;
                    returnCode = patientBL.SaveSamplePublishingDetails(resultPub, sadd);
                }
                if (ddPublishingMode.SelectedValue != "0")
                {
                    resultPub.Value = txtName.Text;
                    resultPub.ModeID = Convert.ToInt32(ddPublishingMode.SelectedValue);
                    returnCode = patientBL.SaveSamplePublishingDetails(resultPub, sadd);
                }
                if (returnCode != 0)
                {
                    ErrorDisplay1.ShowError = true;
                    ErrorDisplay1.Status = "Error while saving Sample Registration Details. Please try after some time.";
                }
                
                if (rdPackage.Checked)
                {
                    Response.Redirect("SampleBillPrint.aspx?vid=" + pVisitID + "&pid=" + pPatientID + "&cid=" + pClientID + "&INS=1&ccid=" + pCollectionCentreID, true);
                    //Response.Redirect("Billgeneration.aspx?vid=" + pVisitID + "&pid=" + pPatientID + "&cid=" + pClientID + "&INS=1", true);
                }
                else
                {
                    Response.Redirect("InvestigationSearch.aspx?vid=" + pVisitID + "&pid=" + pPatientID + "&cid=" + pClientID + "&ccid=" + pCollectionCentreID, true);
                    //Response.Redirect("Billgeneration.aspx?vid=" + pVisitID + "&pid=" + pPatientID + "&cid=" + pClientID, true);
                }
            }
            else
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "Error while saving Sample Registration Details. Please try after some time.";
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Sample Registration Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
   
    protected void ddlHospital_SelectedIndexChanged(object sender, EventArgs e)
    {
        LabRefOrgID = Convert.ToInt64(ddlHospital.SelectedValue);
        GetLabRefOrgAddress(LabRefOrgID);
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        LabRefOrgID = Convert.ToInt64(ddlBranch.SelectedValue);
        GetLabRefOrgAddress(LabRefOrgID);
    }
    public void GetLabRefOrgAddress(long LabRefOrgID)
    {
        try
        {
            //txtHospitalAddress.Text = string.Empty;
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<LabRefOrgAddress> getLabRefOrgAddress = new List<LabRefOrgAddress>();
            retCode = patBL.GetLabRefOrgAddress(LabRefOrgID, out getLabRefOrgAddress);
            if (retCode == 0)
            {
                foreach (LabRefOrgAddress labOrgAddress in getLabRefOrgAddress)
                {
                    txtHospitalAddress.Text = GetAddressFormat(labOrgAddress);
                }
    
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading LabRefOrgAddress Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    public string GetAddressFormat(LabRefOrgAddress labOrgAddress)
    {
        string address = string.Empty;
        StringBuilder addressSB = new StringBuilder("");

        if (labOrgAddress.Add1 != string.Empty && labOrgAddress.Add1!= null)
        {
            addressSB.Append(labOrgAddress.Add1+",\n");
        }
        if (labOrgAddress.Add2 != string.Empty && labOrgAddress.Add2!=null)
        {
            if (addressSB.Length == 0)
            {
                addressSB.Append(labOrgAddress.Add2);
            }
            else
            {
                addressSB.Append(labOrgAddress.Add2 + ",\n");
            }
        }
        
        //addressSB.Append("\n");

        if (labOrgAddress.Add3 != string.Empty && labOrgAddress.Add3 != null)
        {
            if (addressSB.Length == 0)
            {
                addressSB.Append(labOrgAddress.Add3);
            }
            else
            {
                addressSB.Append(labOrgAddress.Add3 + ",\n");
            }
        }
        if (labOrgAddress.City != string.Empty && labOrgAddress.City!=null)
        {
            if (addressSB.Length == 0)
            {
                addressSB.Append(labOrgAddress.City);
            }
            else
            {
                addressSB.Append(labOrgAddress.City );
                if (labOrgAddress.PostalCode != string.Empty && labOrgAddress.PostalCode != null)
                {
                    addressSB.Append("-" + labOrgAddress.PostalCode + ".\n");
                }
            }
        }
        //addressSB.Append("\n");
        if (labOrgAddress.MobileNumber != string.Empty && labOrgAddress.MobileNumber!=null)
        {
            if (addressSB.Length == 0)
            {
                addressSB.Append(labOrgAddress.MobileNumber);
            }
            else
            {
                addressSB.Append(labOrgAddress.MobileNumber + "\n");
            }
        }
        if (labOrgAddress.LandLineNumber != string.Empty && labOrgAddress.LandLineNumber!=null)
        {
            if (addressSB.Length == 0)
            {
                addressSB.Append(labOrgAddress.LandLineNumber);
            }
            else
            {
                addressSB.Append(labOrgAddress.LandLineNumber + "\n");
            }
        }
        //addressSB.Append("\n");
        //if (labOrgAddress.PostalCode != string.Empty)
        //{
        //   addressSB.Append(labOrgAddress.PostalCode+".");
        //}
        address = addressSB.ToString();
        return address;
    }
    protected void addNewHospital_Click(object sender, EventArgs e)
    {
        Response.Redirect("SaveLabRefOrgDetails.aspx",true);
    }
    protected void lnkChangeAddress_Click(object sender, EventArgs e)
    {
        int id = -1;
        if (rdoHospital.Checked)
        {
            id = Convert.ToInt32(ddlHospital.SelectedValue);
        }
        if (rdoBranch.Checked)
        {
            id = Convert.ToInt32(ddlBranch.SelectedValue);
        }
        Response.Redirect("SaveLabRefOrgDetails.aspx?id="+ id ,true);
    }

    public void LoadCollectionCentre()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<CollectionCentreMaster> getCollectionCentre = new List<CollectionCentreMaster>();
            retCode = patBL.GetCollectionCentre(OrgID, out getCollectionCentre);
            if (retCode == 0)
            {
                ddlCollectionCentre.DataSource = getCollectionCentre;
                ddlCollectionCentre.DataTextField = "CollectionCentreName";
                ddlCollectionCentre.DataValueField = "CollectionCentreID";
                ddlCollectionCentre.DataBind();
                ddlCollectionCentre.Items.Insert(0, "-----Select-----");
                ddlCollectionCentre.Items[0].Value = "0";
            }
          
     
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Collection Centre Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            
        }
    }

}
