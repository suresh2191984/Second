using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using NumberToWord;


public partial class Billing_BillPrinting : BasePage
{
    long visitID = -1;
    long taskID = -1;
    long patientID = -1;
    long returncode = -1;
    List<VisitPurpose> lstvisitpurpose = new List<VisitPurpose>();
    PatientVisit_BL pvBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        pvBL = new PatientVisit_BL(base.ContextInfo);
        string RedirectPage = GetConfigValue("BillPrintControl", OrgID);

           string strConfigKey = "EMRcasesheet";
          
            string configValue = GetConfigValue(strConfigKey, OrgID);
         
        if (!Page.IsPostBack)
        {
            try
            {
                Int64.TryParse(Request.QueryString["vid"], out visitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                long FinalBillID = 0;
                Int64.TryParse(Request.QueryString["bid"], out FinalBillID);

                int specialityid, followup;

                ANC_BL ancBL = new ANC_BL(base.ContextInfo);
                ancBL.GetANCSpecilaityID(visitID, out specialityid, out followup);

                returncode = pvBL.GetVisitPurposeName(OrgID, visitID, out lstvisitpurpose);

                if (specialityid != Convert.ToInt32(TaskHelper.speciality.ANC) && lstvisitpurpose[0].VisitPurposeName != "Health Package")
                {
                    if (configValue == "Y")
                    {
                        PrintHistory1.Visible = false;
                        PrintExam1.Visible = false;
                        grdResult.Visible = false;
                       
                        opCaseSheet.Visible = false;
                        ancCaseSheet.Visible = false;
                        emrcasesheet.Visible = true;
                        emrcasesheet.LoadPatientDetails(visitID, 0);

                    }


                    else
                    {

                        PrintHistory1.Visible = false;
                        PrintExam1.Visible = false;
                        grdResult.Visible = false;

                       if (opCaseSheet.LoadPatientDetails(visitID, 0) == true)
                        {
                            opCaseSheet.Visible = true;
                            ancCaseSheet.Visible = false;
                            opCaseSheet.LoadPatientDetails(visitID, 0);
                            pnlBillPrint.Visible = false;
                        }
                        else
                        {
                            ancCaseSheet.Visible = false;
                        }
                    }
                }

                else
                {
                    if (lstvisitpurpose[0].VisitPurposeName == "Health Package")
                    {
                        List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
                        List<DrugDetails> lstPatientPrescription = new List<DrugDetails>();
                        List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
                        List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
                        List<PatientPastVaccinationHistory> lstPPVH = new List<PatientPastVaccinationHistory>();
                        List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
                        List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();

                        long returnCode = -1;
                        returnCode = new Patient_BL(base.ContextInfo).GetPatientHistoryPackage(visitID, out lstPatHisAttribute, out lstPatientPrescription, out lstGPALDetails, out lstANCPatientDetails, out lstPPVH, out lstPCA, out lstSurgicalDetails);
                        if (lstPatHisAttribute.Count <= 0 && lstPatientPrescription.Count <= 0 && lstGPALDetails.Count <= 0 && lstANCPatientDetails.Count <= 0 && lstPPVH.Count <= 0 && lstPCA.Count <= 0 && lstSurgicalDetails.Count <= 0 && OrgID == 26)
                        {
                            PrintHistory1.Visible = false;
                            PrintExam1.Visible = false;
                            grdResult.Visible = false;
                            opCaseSheet.Visible = false;
                            ancCaseSheet.Visible = false;
                        }
                        else
                        {
                            PrintHistory1.Visible = true;
                            PrintExam1.Visible = true;
                            grdResult.Visible = true;
                            opCaseSheet.Visible = false;
                            ancCaseSheet.Visible = false;
                            opCaseSheet.Visible = true;
                            GetHealthPKGData();
                        }
                    }
                    else
                    {
                        PrintHistory1.Visible = false;
                        PrintExam1.Visible = false;
                        grdResult.Visible = false;
                        opCaseSheet.Visible = false;
                        if (ancCaseSheet.LoadCaseSheetDetails(visitID, patientID) == true)
                        {
                            ancCaseSheet.LoadCaseSheetDetails(visitID, patientID);
                        }
                    }
                }
                int pdp = -1;
                // Dynamically load the bill control instead of loading both bill print by default 
                Control objCtrl;
                if (RedirectPage != string.Empty)
                {
                    objCtrl = LoadControl("../CommonControls/RakshithBillPrint.ascx");
                    if (objCtrl != null)
                    {
                        Billing_RakshithBillPrint rakshithbillPrint = (Billing_RakshithBillPrint)objCtrl;
                        objCtrl.ID = "rakshithbillPrint";
                        rakshithbillPrint.LoadSessionValue();
                        rakshithbillPrint.BillPrinting(visitID, FinalBillID, pdp);
                    }
                    //rakshithbillPrint.Visible = true;
                    //billPrint.Visible = false;
                }
                else
                {
                    objCtrl = LoadControl("../CommonControls/BillPrint.ascx");
                    if (objCtrl != null)
                    {
                        Billing_BillPrint billPrint = (Billing_BillPrint)objCtrl;
                        objCtrl.ID = "BillPrint";
                        billPrint.LoadSessionValue();
                        billPrint.LoadBillConfigMetadata(OrgID, ILocationID);
                        billPrint.BillPrinting(visitID, FinalBillID, pdp);
                    }
                    //billPrint.Visible = true;
                    //rakshithbillPrint.Visible = false;
                }
                pnlBillPrint.Controls.Add(objCtrl);
                //
                Header3.PatientVisitID = visitID;
                Header3.ShowVitalsDetails();
                if (Request.QueryString["tid"] != null)
                {
                    Int64.TryParse(Request.QueryString["tid"], out taskID);
                    new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                }
                string chkheaders = GetConfigValue("PrintCaseSheetWithHeader", OrgID);
                if (chkheaders == 'Y'.ToString())
                {
                    chkheader.Style.Add("display", "block");
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
            }
        }
    }

    public void GetHealthPKGData()
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        PrintHistory1.LoadHistoryData(visitID);
        PrintExam1.LoadExamData(visitID);
        List<PatientRecommendationDtls> rTemplate = new List<PatientRecommendationDtls>();
        List<PhysicianSchedule> lstschedules = new List<PhysicianSchedule>();
        List<Patient> patientList = new List<Patient>();
        try
        {
            new Patient_BL(base.ContextInfo).GetPatientRecommendationDetails(OrgID, visitID, patientID,
                out  rTemplate, out lstschedules, out patientList);
            grdResult.DataSource = rTemplate;
            grdResult.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
        }
    }
    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reception/Home.aspx");
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

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
}
