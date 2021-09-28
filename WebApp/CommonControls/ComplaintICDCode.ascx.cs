using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using Attune.Podium.BillingEngine;
using System.Security.Cryptography;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Web.Caching;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using System.Configuration;
using Attune.Podium.PerformingNextAction;

public partial class CommonControls_ComplaintICDCode : BaseControl
{
    public string ComplaintHeader { get; set; }
    public string DefaultComplaintID { get; set; }
    public int ComplaintID { get; set; }
    public string ComplaintName { get; set; }
    public string AddBtnVisible { get; set; }
    public long returnCode = -1;
    public string ICDCode { get; set; }

    public string ICDDesc { get; set; }
    List<ICDCodes> lstICDCodes = new List<ICDCodes>();
    ActionManager ObjActionManager;

    protected void Page_Load(object sender, EventArgs e)
   {
        if (isCorporateOrg == "Y")
        {
            tdDesclbl.Style.Add("display", "none");
            tdDescTxt.Style.Add("display", "none");
            tdCodelbl.Style.Add("display", "none");
            tdCodeTxt.Style.Add("display", "none");
        }
        if (!IsPostBack)
        {
            hdnIcdcode.Value = GetConfigValue("NeedICDValidation", OrgID);

            if (Request.QueryString["id"] != "-1" && Request.QueryString["id"] != null)
            {
                hdnComplaintId.Value = Request.QueryString["id"].ToString();
                hdnICDName.Value = txtICDName.Text.ToString() ;
                hdnICDCODE1.Value = txtICDCode.Text.ToString();
                hdnComplaint.Value = txtCpmlaint.Text.ToString();  
            }
        }
        lblComplaint.Text = ComplaintHeader;
        if (lblComplaint.Text == "")
        { lblComplaint.Text = "Diagnosis"; }
    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    #region Get and Set The PhysioCompliant
    public List<PhysioCompliant> GetPhysioCompliant()
    {
        List<PhysioCompliant> lstPhysioCompliantTemp = new List<PhysioCompliant>();
        foreach (string listParentDiagnosis in hdnDiagnosisItems.Value.Split('^'))
        {
            if (listParentDiagnosis != "")
            {
                PhysioCompliant objPhysioCompliant = new PhysioCompliant();
                string[] listChildDiagnosis = listParentDiagnosis.Split('~');
                objPhysioCompliant.ComplaintName = listChildDiagnosis[1];
                objPhysioCompliant.ComplaintID = 0;
                objPhysioCompliant.ICDCode = listChildDiagnosis[3];
                objPhysioCompliant.ICDDescription = listChildDiagnosis[4];
                if (objPhysioCompliant.ICDCode == "")
                {
                    objPhysioCompliant.ICDCodeStatus = "Pending";
                }
                else
                {
                    objPhysioCompliant.ICDCodeStatus = "Completed";
                }
                lstPhysioCompliantTemp.Add(objPhysioCompliant);
            }
        }
        return lstPhysioCompliantTemp;
    }

    public void SetPhysioComplaint(List<PhysioCompliant> lstPhysioCompliant)
    {
        lblComplaint.Text = ComplaintHeader;

        hdnDiagnosisItems.Value = "";
        int i = 110;
        foreach (PhysioCompliant objPC in lstPhysioCompliant)
        {
            hdnDiagnosisItems.Value += i + "~" + objPC.ComplaintName + "~" + objPC.ComplaintID + "~" + objPC.ICDCode + "~" + objPC.ICDDescription + "^";
            i += 1;
        }

        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItems();", true);
    }
    #endregion

    #region Get and Set The PatientComplaint
    public List<PatientComplaint> GetPatientComplaint(string ComplaintType, long VisitID)
    {

          List<ICDCodes> lstICDCODestemp = new List<ICDCodes>();
        Patient_BL objBl = new Patient_BL(base.ContextInfo);
        List<PatientComplaint> lstPatientComplaintTemp = new List<PatientComplaint>();
        ObjActionManager = new ActionManager(base.ContextInfo);
        foreach (string listParentDiagnosis in hdnDiagnosisItems.Value.Split('^'))
        {


            ICDCodes objicdcodes = new ICDCodes();
            string[] listChildDiagnosis = listParentDiagnosis.Split('~');
            if (listParentDiagnosis != "")
            {
                PatientComplaint objPatientComplaint = new PatientComplaint();
            returnCode = new Patient_BL(base.ContextInfo).GetICDCODE(listChildDiagnosis[3], out lstICDCodes);
            if (returnCode != 0)
            {

                objicdcodes.ComplaintName = listChildDiagnosis[1];
                objicdcodes.CreatedBy = LID;
                objicdcodes.ModifiedBy = LID;
                objicdcodes.OrgID = base.OrgID;
                objicdcodes.ICDCode = listChildDiagnosis[3];

                objicdcodes.ICDDescription = listChildDiagnosis[4];
                lstICDCODestemp.Add(objicdcodes);
                // Insert the user defined ICD Codes and Description  into ICD Codes Table  
                new Master_BL(base.ContextInfo).InsertICDCodes(lstICDCODestemp, out lstICDCodes);
                if (lstICDCODestemp.Count() > 0)
                {
                    
                    String URL = string.Empty;
                    ObjActionManager.GetSMSConfig(OrgID, out URL);
                    // Communication.SendSMS("Dear " + lstPatient.Name + ",\nYour test request has been registered successfully with\n" + OrgName + " at " + String.Format("{0:dd-MM-yyyy hh:mm:ss tt}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ". Thank you.", lstPatient.PatientAddress[0].MobileNumber.Trim());  
                    Communication.SendSMS(URL, "Dear Sir/Madam  " + ",\nThis ICD Code \n " + objicdcodes.ICDCode + " has been added for this " + objicdcodes.ICDDescription + " Complaint by " + base.UserName + "  " + OrgName + " at " + String.Format("{0:dd-MM-yyyy hh:mm:ss tt}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ". Thank you.", "9840784964");

                }


            }

          
              
                if (DefaultComplaintID == "NO")
                {
                    objPatientComplaint.ComplaintID = ComplaintID;
                }
                else
                {
                    objPatientComplaint.ComplaintID = 0;

                }
                objPatientComplaint.ComplaintName = listChildDiagnosis[1];
                objPatientComplaint.CreatedBy = LID;
                objPatientComplaint.PatientVisitID = VisitID;
                objPatientComplaint.ComplaintType = ComplaintType;
                objPatientComplaint.ICDCode = listChildDiagnosis[3];

                if (objPatientComplaint.ICDCode == "")
                {
                    objPatientComplaint.ICDCodeStatus = "Pending";
                }
                else
                {
                    objPatientComplaint.ICDCodeStatus = "Completed";
                }
                objPatientComplaint.ICDDescription = listChildDiagnosis[4];
                objPatientComplaint.IsPrimaryDiagnosis = listChildDiagnosis[6];
                lstPatientComplaintTemp.Add(objPatientComplaint);
            }
        }
        return lstPatientComplaintTemp;
    }

    public List<PatientComplaint> GetPatientComplaint(string ComplaintType, long VisitID,long OnBehalf)
    {
        List<PatientComplaint> lstPatientComplaintTemp = new List<PatientComplaint>();
        List<ICDCodes> lstICDCODestemp = new List<ICDCodes>();
        Patient_BL objBl = new Patient_BL(base.ContextInfo);

        foreach (string listParentDiagnosis in hdnDiagnosisItems.Value.Split('^'))
        {
            string[] listChildDiagnosis = listParentDiagnosis.Split('~');

            if (listParentDiagnosis != "")
            {
                PatientComplaint objPatientComplaint = new PatientComplaint();
                ICDCodes objicdcodes = new ICDCodes();
               
                returnCode = new Patient_BL(base.ContextInfo).GetICDCODE(listChildDiagnosis[3], out lstICDCodes);
                if (returnCode != 0)
                {

                    objicdcodes.ComplaintName = listChildDiagnosis[1];
                    objicdcodes.CreatedBy = LID;
                    objicdcodes.ModifiedBy = LID;
                    objicdcodes.OrgID = base.OrgID;
                    objicdcodes.ICDCode = listChildDiagnosis[3];

                    objicdcodes.ICDDescription = listChildDiagnosis[4];
                     lstICDCODestemp.Add(objicdcodes);
                    // Insert the user defined ICD Codes and Description  into ICD Codes Table  
                    new Master_BL(base.ContextInfo).InsertICDCodes(lstICDCODestemp, out lstICDCodes);
                    if (lstICDCODestemp.Count() > 0)
                    {
                        String URL = string.Empty;
                        ObjActionManager.GetSMSConfig(OrgID, out URL);
                        // Communication.SendSMS("Dear " + lstPatient.Name + ",\nYour test request has been registered successfully with\n" + OrgName + " at " + String.Format("{0:dd-MM-yyyy hh:mm:ss tt}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ". Thank you.", lstPatient.PatientAddress[0].MobileNumber.Trim());  
                        Communication.SendSMS(URL, "Dear Sir/Madam  " + ",\nThis ICD Code \n " + objicdcodes.ICDCode + " has been added for this " + objicdcodes.ICDDescription + " Complaint by " + base.UserName + "  " + OrgName + " at " + String.Format("{0:dd-MM-yyyy hh:mm:ss tt}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ". Thank you.", "9840784964");

                    }


                }
                    if (DefaultComplaintID == "NO")
                    {
                        objPatientComplaint.ComplaintID = ComplaintID;
                    }
                    else
                    {
                        objPatientComplaint.ComplaintID = 0;

                    }
                    objPatientComplaint.ComplaintName = listChildDiagnosis[1];
                    objPatientComplaint.CreatedBy = LID;
                    objPatientComplaint.PatientVisitID = VisitID;
                    objPatientComplaint.ComplaintType = ComplaintType;
                    objPatientComplaint.ICDCode = listChildDiagnosis[3];
                    if (objPatientComplaint.ICDCode == "")
                    {
                        objPatientComplaint.ICDCodeStatus = "Pending";
                    }
                    else
                    {
                        objPatientComplaint.ICDCodeStatus = "Completed";
                    }
                    if (listChildDiagnosis[5] == "1")
                    {
                        objPatientComplaint.Query = "1";
                    }
                    objPatientComplaint.ICDDescription = listChildDiagnosis[4];
                    objPatientComplaint.IsPrimaryDiagnosis = listChildDiagnosis[6];
                 
                    objPatientComplaint.OnBehalf = OnBehalf;
                    lstPatientComplaintTemp.Add(objPatientComplaint);
              
              
            }
            if (hdnDiagnosisItems.Value == "")
            {
                PatientComplaint objPatientComplaint = new PatientComplaint();
                objPatientComplaint.ComplaintID = 0;
                objPatientComplaint.ComplaintName = null;
                objPatientComplaint.CreatedBy = LID;
                objPatientComplaint.PatientVisitID = VisitID;
                objPatientComplaint.ComplaintType = ComplaintType;
                objPatientComplaint.ICDCode = null;
                objPatientComplaint.ICDCodeStatus = "Pending";
                objPatientComplaint.ICDDescription = null;
                objPatientComplaint.OnBehalf = OnBehalf;
                lstPatientComplaintTemp.Add(objPatientComplaint);
            }
        }
       
        return lstPatientComplaintTemp;
    }

    #region SavePatientComplaint only For Counselling  
    public List<PatientComplaint> SavePatientComplaint(string ComplaintType, long VisitID, string ckhProvisional)
    {
        List<PatientComplaint> lstPatientComplaintTemp = new List<PatientComplaint>();
        foreach (string listParentDiagnosis in hdnDiagnosisItems.Value.Split('^'))
        {
            if (listParentDiagnosis != "")
            {
                PatientComplaint objPatientComplaint = new PatientComplaint();
                string[] listChildDiagnosis = listParentDiagnosis.Split('~');
                if (DefaultComplaintID == "NO")
                {
                    objPatientComplaint.ComplaintID = ComplaintID;
                }
                else
                {
                    objPatientComplaint.ComplaintID = 0;

                }
                objPatientComplaint.ComplaintName = listChildDiagnosis[1];
                objPatientComplaint.CreatedBy = LID;
                objPatientComplaint.PatientVisitID = VisitID;
                objPatientComplaint.ComplaintType = ComplaintType;
                objPatientComplaint.Query = ckhProvisional;
                objPatientComplaint.ICDCode = listChildDiagnosis[3];
                if (objPatientComplaint.ICDCode == "")
                {
                    objPatientComplaint.ICDCodeStatus = "Pending";
                }
                else
                {
                    objPatientComplaint.ICDCodeStatus = "Completed";
                }
                objPatientComplaint.ICDDescription = listChildDiagnosis[4];
                lstPatientComplaintTemp.Add(objPatientComplaint);
            }
        }
        return lstPatientComplaintTemp;
    }
    #endregion

    public void SetPatientComplaint(List<PatientComplaint> lstPatientComplaint)
    {
        lblComplaint.Text = ComplaintHeader;

        hdnDiagnosisItems.Value = "";
        int i = 110;
        foreach (PatientComplaint objPC in lstPatientComplaint)
        {
            string lsPrimary = objPC.IsPrimaryDiagnosis == "Y" ? "Y" : "N";

            hdnDiagnosisItems.Value += i + "~" + objPC.ComplaintName + "~" + objPC.ComplaintID + "~" + objPC.ICDCode + "~" + objPC.ICDDescription
                + "~" + objPC.IsNewlydiagnosed + '~' + lsPrimary + "^";
            i += 1;
        }


        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItems();", true);
    }

    #endregion

    #region Get and Set The patient DiagnoseComplaint

    public List<PatientComplaint> GetDiagnoseComplaint()
    {
        List<PatientComplaint> lstPatientComplaintTemp = new List<PatientComplaint>();
        PatientComplaint objPatientComplaint = new PatientComplaint();

        objPatientComplaint.ICDCode = txtICDCode.Text;
        if (objPatientComplaint.ICDCode == "")
        {
            objPatientComplaint.ICDCodeStatus = "Pending";
        }
        else
        {
            objPatientComplaint.ICDCodeStatus = "Completed";
        }
        objPatientComplaint.ICDDescription = txtICDName.Text;
        lstPatientComplaintTemp.Add(objPatientComplaint);
        return lstPatientComplaintTemp;
    }

    public void SetDiagnoseComplaint(string CName, string ICDCode, string ICDDesc)
    {
        txtCpmlaint.Text = CName;
        txtICDCode.Text = ICDCode;
        txtICDName.Text = ICDDesc;
        btnHistoryAdd.Visible = true;
        txtCpmlaint.ReadOnly = true;

    }

    #endregion

    #region Get and Set The OperationComplication
    public List<OperationComplication> GetOperationComplication()
    {
        List<OperationComplication> lstOperationComplicationTemp = new List<OperationComplication>();
        foreach (string listComplication in hdnDiagnosisItems.Value.Split('^'))
        {
            if (listComplication != "")
            {
                OperationComplication objOperationComplication = new OperationComplication();
                string[] listChildDiagnosis = listComplication.Split('~');
                objOperationComplication.ComplicationName = listChildDiagnosis[1];
                objOperationComplication.CreatedBy = LID;
                objOperationComplication.ComplaintID = 0;
                objOperationComplication.ICDCode = listChildDiagnosis[3];
                objOperationComplication.ICDDescription = listChildDiagnosis[4];
                if (objOperationComplication.ICDCode == "")
                {
                    objOperationComplication.ICDCodeStatus = "Pending";
                }
                else
                {
                    objOperationComplication.ICDCodeStatus = "Completed";
                }
                lstOperationComplicationTemp.Add(objOperationComplication);
            }
        }
        return lstOperationComplicationTemp;
    }

    public void SetOperationComplication(List<OperationComplication> lstOperationComplication)
    {
        lblComplaint.Text = ComplaintHeader;

        hdnDiagnosisItems.Value = "";
        int i = 110;
        foreach (OperationComplication objPC in lstOperationComplication)
        {
            hdnDiagnosisItems.Value += i + "~" + objPC.ComplicationName + "~" + objPC.ComplaintID + "~" + objPC.ICDCode + "~" + objPC.ICDDescription + "^";
            i += 1;
        }


        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItems();", true);
    }
    #endregion

    #region Get and Set The PatientComplication
    public List<PatientComplication> GetPatientComplication(string ComplicationType)
    {
        List<PatientComplication> lstPatientComplicationTemp = new List<PatientComplication>();
        foreach (string listComplication in hdnDiagnosisItems.Value.Split('^'))
        {
            if (listComplication != "")
            {
                PatientComplication objPatientComplication = new PatientComplication();
                string[] listChildComplication = listComplication.Split('~');
                objPatientComplication.ComplicationID = 0;
                objPatientComplication.ComplaintID = 0;
                objPatientComplication.ComplicationName = listChildComplication[1];
                objPatientComplication.ComplicationType = ComplicationType;
                objPatientComplication.ICDCode = listChildComplication[3];
                objPatientComplication.ICDDescription = listChildComplication[4];

                if (objPatientComplication.ICDCode == "")
                {
                    objPatientComplication.ICDCodeStatus = "Pending";
                }
                else
                {
                    objPatientComplication.ICDCodeStatus = "Completed";
                }

                lstPatientComplicationTemp.Add(objPatientComplication);
            }
        }
        return lstPatientComplicationTemp;
    }

    public void SetPatientComplication(List<PatientComplication> lstPatientComplication)
    {
        lblComplaint.Text = ComplaintHeader;

        hdnDiagnosisItems.Value = "";
        int i = 110;
        foreach (PatientComplication objPC in lstPatientComplication)
        {
            hdnDiagnosisItems.Value += i + "~" + objPC.ComplicationName + "~" + objPC.ComplaintId + "~" + objPC.ICDCode + "~" + objPC.ICDDescription + "^";
            i += 1;
        }


        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItems();", true);
    }

    #endregion


    #region Get and Set The BackgroundProblem
    public List<BackgroundProblem> GetPatientBackgroundProblem(string PreparedAt, long patientID, long patientVisitID)
    {
        List<BackgroundProblem> lstBackgroundProblemTemp = new List<BackgroundProblem>();

        if (hdnDiagnosisItems.Value != "")
        {
            foreach (string lstRiskFactor in hdnDiagnosisItems.Value.Split('^'))
            {

                if (lstRiskFactor != "")
                {
                    string[] listBP = lstRiskFactor.Split('~');
                    BackgroundProblem objBackgroundProblem = new BackgroundProblem();
                    objBackgroundProblem.ComplaintID = 0;
                    objBackgroundProblem.ComplaintName = listBP[1];
                    objBackgroundProblem.Description = "";
                    objBackgroundProblem.CreatedBy = LID;
                    objBackgroundProblem.PatientVisitID = patientVisitID;
                    objBackgroundProblem.PatientID = patientID;
                    objBackgroundProblem.PreparedAt = PreparedAt;
                    objBackgroundProblem.ICDCode = listBP[3];
                    objBackgroundProblem.ICDDescription = listBP[4];

                    if (objBackgroundProblem.ICDCode == "")
                    {
                        objBackgroundProblem.ICDCodeStatus = "Pending";
                    }
                    else
                    {
                        objBackgroundProblem.ICDCodeStatus = "Completed";
                    }
                    lstBackgroundProblemTemp.Add(objBackgroundProblem);
                }
            }
        }
        return lstBackgroundProblemTemp;
    }


    public void SetPatientBackgroundProblem(List<BackgroundProblem> lstBackgroundProblem)
    {
        lblComplaint.Text = ComplaintHeader;

        hdnDiagnosisItems.Value = "";
        int i = 110;
        foreach (BackgroundProblem objPB in lstBackgroundProblem)
        {
            hdnDiagnosisItems.Value += i + "~" + objPB.ComplaintName + "~" + objPB.ComplaintID + "~" + objPB.ICDCode + "~" + objPB.ICDDescription + "^";
            i += 1;
        }


        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItems();", true);
    }
    #endregion

    #region Get and Set The PrimaryCauseOfDeath
    public List<CauseOfDeath> GetCauseOfDeath(string CauseOfDeathType)
    {

        List<CauseOfDeath> lstCauseOfDeathTemp = new List<CauseOfDeath>();

        foreach (string lstCOD in hdnDiagnosisItems.Value.Split('^'))
        {

            if (lstCOD != "")
            {
                CauseOfDeath objCauseOfDeath = new CauseOfDeath();
                string[] lstChildData = lstCOD.Split('~');
                objCauseOfDeath.CauseOfDeathTypeID = 0;
                objCauseOfDeath.CauseOfDeathType = CauseOfDeathType;
                objCauseOfDeath.ComplaintID = 0;
                objCauseOfDeath.ComplaintName = lstChildData[1];
                objCauseOfDeath.ICDCode = lstChildData[3];
                objCauseOfDeath.ICDDescription = lstChildData[4];
                if (objCauseOfDeath.ICDCode == "")
                {
                    objCauseOfDeath.ICDCodeStatus = "Pending";
                }
                else
                {
                    objCauseOfDeath.ICDCodeStatus = "Completed";
                }
                lstCauseOfDeathTemp.Add(objCauseOfDeath);
            }
        }

        return lstCauseOfDeathTemp;
    }

    public void SetCauseOfDeath(List<CauseOfDeath> lstCauseOfDeath)
    {
        lblComplaint.Text = ComplaintHeader;

        hdnDiagnosisItems.Value = "";
        int i = 110;
        foreach (CauseOfDeath objItem in lstCauseOfDeath)
        {
            hdnDiagnosisItems.Value += i + "~" + objItem.ComplaintName + "~" + objItem.ComplaintID + "~" + objItem.ICDCode + "~" + objItem.ICDDescription + "^";
            i += 1;
        }


        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItems();", true);
    }


    #endregion

    #region Get and Set The CommunicableDiseases


    public void setCommunicableDisease(List<CommunicableDiseaseMaster> lstCommunicableDiseases)
    {
        //List<CommunicableDiseaseMaster> lstCommunicableDiseases = new List<CommunicableDiseaseMaster>();
        //long returnCode = -1;
        //Patient_BL patientBL = new Patient_BL(base.ContextInfo);

        //returnCode = patientBL.GetCommunicableDiseases(OrgID, out lstCommunicableDiseases);
        hdnDiagnosisItems.Value = "";
        int i = 110;
        foreach (CommunicableDiseaseMaster objCDM in lstCommunicableDiseases)
        {
            hdnDiagnosisItems.Value += i + "~" + objCDM.ComplaintName + "~" + objCDM.ComplaintId + "~" + objCDM.ICDCode + "~" + objCDM.ICDName + "^";
            i += 1;
        }

    }



    public List<CommunicableDiseaseMaster> GetCommunicableDiseases(int OrgID)
    {
        List<CommunicableDiseaseMaster> lstCommunicableDiseasesTemp = new List<CommunicableDiseaseMaster>();
        foreach (string listCommunicableDiseases in hdnDiagnosisItems.Value.Split('^'))
        {
            if (listCommunicableDiseases != "")
            {
                CommunicableDiseaseMaster objCommunicableDiseases = new CommunicableDiseaseMaster();
                string[] listChildCommunicableDiseases = listCommunicableDiseases.Split('~');
                objCommunicableDiseases.OrgId = OrgID;
                objCommunicableDiseases.OrgAddressId = ILocationID;
                objCommunicableDiseases.ComplaintId = 0;
                objCommunicableDiseases.ComplaintName = listChildCommunicableDiseases[1];
                objCommunicableDiseases.ICDCode = listChildCommunicableDiseases[3];
                objCommunicableDiseases.ICDName = listChildCommunicableDiseases[4];
                objCommunicableDiseases.CreatedBy = LID;

                lstCommunicableDiseasesTemp.Add(objCommunicableDiseases);
            }
        }

        return lstCommunicableDiseasesTemp;
    }


    #endregion

    public void LoadComplaintItems()
    {
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItems();", true);


    }

    public void hdnClear()
    {
        hdnDiagnosisItems.Value = "";
    }

    public void SetComplaint()
    {
        txtCpmlaint.Text = ComplaintName;

        if (ICDCode != "" && ICDDesc != "")
        {
            txtICDCode.Text = ICDCode;
            txtICDName.Text = ICDDesc;
        }
        hdnFlag.Value = "N";

        if (AddBtnVisible == "False")
        {
            btnHistoryAdd.Visible = false;
            txtCpmlaint.ReadOnly = true;
        }
    }

    public void SetWidth(int Width)
    {
        txtCpmlaint.Width = Width;
        txtICDCode.Width = Width;
        txtICDName.Width = Width;

    }


    public void SetHeader()
    {
        lblComplaint.Text = ComplaintHeader;
    }
}
