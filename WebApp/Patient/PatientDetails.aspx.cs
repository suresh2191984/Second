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
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using Attune.Podium.FileUpload;

public partial class Patient_PatientDetails : BasePage
{

    public Patient_PatientDetails()
        : base(" Patient\\PatientDetails.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }



    Tasks task = new Tasks();
    Tasks_BL taskBL;




    override protected void OnInit(EventArgs e)
    {

        EventChart2.selectionChanged += new EventHandler(Patient1_PageChanged);
        EventChart2.checkedChanged += new EventHandler(Patient1_Selected);
        EventChart2.selectionchecked += new EventHandler(Patient1_SelectedChecked);
    }



    int recordCount = -1;
    long PatientVisitId = 0;
    long PatientId = 0;
    long taskID = 0;
    string vType = string.Empty;
    string sPatientName = string.Empty;
    int SpecialityID = -2;
    string TaskActionName = string.Empty;
    int TaskActionID = -1;
    int OrthoCount = -1;
    string configValue = string.Empty;
    string Flow = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            taskBL = new Tasks_BL(base.ContextInfo);
            string strConfigKey = "EMRcasesheet";
            configValue = GetConfigValue(strConfigKey, OrgID);
            PatientId = Convert.ToInt64(Request.QueryString["pid"]);
            PatientVisitId = Convert.ToInt64(Request.QueryString["vid"]);
            taskID = Convert.ToInt64(Request.QueryString["tid"]);
            vType = Request.QueryString["vType"];
            sPatientName = Request.QueryString["PNAME"];
            string pType = "";
            pType = Request.QueryString["pType"];
            if (pType == "D")
            {
                btnNewOperationNotes.Visible = false;
            }

            if (Request.QueryString["vid"] != null)
                ibtnDiagnose.Visible = true;

            //OPCaseSheet.Visible = false;
            //ANCCaseSheet.Visible = false;
            //    BillPrint.Visible = false;
            //InvestigationReportViewer.Visible = false;
            PrintPrescription.Visible = false;
            Treatment.Visible = false;
            Receipt.Visible = false;
            onFlowDialysis.Visible = false;
            DialysisCaseSheet.Visible = false;

            searchText.ContextKey = Convert.ToString(PatientId);
            if (!Page.IsPostBack)
            {
                //call the method to load the event chart grid
                if (PatientVisitId == 0)
                {
                    ibtnDiagnose.Visible = false;
                    EventChart2.Visible = false;
                }

                Header3.PatientID = PatientId;
                Header3.PatientVisitID = PatientVisitId;
                Header3.ShowVitalsDetails();

                recordCount = loadEventChart();
                OPCaseSheet.Visible = false;
                ANCCaseSheet.Visible = false;
                InvestigationReportViewer.Visible = false;


                #region Newly Added By Suresh

                OPCaseSheet.Visible = true;
                InvestigationReportViewer.ShowInvestigation(PatientVisitId);
                InvestigationReportViewer.Visible = true;
                PatientDischrageDetail.Visible = false;
                DischargeCaseSheetDynamic1.Visible = false;
                DischargeSummaryR1.Visible = false;
                NeonatalCaseSheets1.Visible = false;
                PrintPrescription.Visible = false;
                Treatment.Visible = false;
                Receipt.Visible = false;
                onFlowDialysis.Visible = false;
                DialysisCaseSheet.Visible = false;
                tdVisitDetails.Visible = true;
                viewData.Visible = false;
                //ucHis.Visible = false;
                //ucExam.Visible = false;
                divEMR.Visible = false;
                divFckRefLetter.Style.Add("display", "none");

                #endregion

                //Newly Added By Sami
                if (vType == "IP" && recordCount == 0)
                {

                    Response.Redirect(@"../Physician/IPCaseRecord.aspx?PID=" + PatientId.ToString() + "&VID=" + PatientVisitId + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
                }
                else
                {
                    if (recordCount == 0 && PatientVisitId != 0)
                    {
                        List<VisitPurpose> lstvisitpurpose = new List<VisitPurpose>();
                        new PatientVisit_BL(base.ContextInfo).GetVisitPurposeName(OrgID, PatientVisitId, out lstvisitpurpose);
                        taskBL.GetTaskActionDetail(PatientVisitId, taskID, out SpecialityID, out TaskActionName, out TaskActionID);


                        if (lstvisitpurpose[0].VisitPurposeName == "Health Package" || TaskActionID == 38)
                        {
                            if (Request.QueryString["Flow"] == "HealthScreening")
                            {
                                Flow = "&Flow=HealthScreening";
                            }
                            else
                            {
                                Flow = "";

                            }
                           
                            taskBL.GetTaskActionDetail(PatientVisitId, taskID, out SpecialityID, out TaskActionName, out TaskActionID);
                            if (SpecialityID == -1 || SpecialityID == 0)
                            {
                                Response.Redirect(@"../Patient\PatientEMRPackage.aspx?vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + Flow + "", true);
                            }
                            else if (SpecialityID == 1)
                            {
                                Response.Redirect(@"../Physician/Diagnose.aspx?vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + "", true);
                            }

                        }
                        else if (lstvisitpurpose[0].VisitPurposeName == "Consultation")
                        {
                            if (SpecialityID == 13 || SpecialityID==48)
                            {
                                Response.Redirect(@"../Physician/diabetesEMR.aspx?vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + "", true);

                            }
                            else
                            {
                                Response.Redirect(@"../Physician/Diagnose.aspx?vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + "", true);
                            }
                        }

                        else if (Request.QueryString["Flow"] == "HealthScreening")
                        {
                            if (Request.QueryString["Flow"] == "HealthScreening")
                            {
                                Flow = "&Flow=HealthScreening";
                            }
                            else
                            {
                                Flow = "";

                            }
                            taskBL.GetTaskActionDetail(PatientVisitId, taskID, out SpecialityID, out TaskActionName, out TaskActionID);
                            if (SpecialityID == 0)
                            {
                                Response.Redirect(@"../Patient\PatientEMRPackage.aspx?vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + Flow + "", true);
                            }

                        }
                    }
                    else if (recordCount >= 1)
                    {
                        loadcasesheet();
                    }
                   
                }

                GetFCKPath();

            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing Page Load in PatientDetailsPage.aspx", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = ex.Message;
        }

    }

    public int loadEventChart()
    {

        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        List<EventChart> lstEventChart = new List<EventChart>();
        List<PatientDrug> lstPatientDrug = new List<PatientDrug>();
        List<InvestigationPatient> lstInvestigation = new List<InvestigationPatient>();
        List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
        List<PatientHistory> lstPatientHistory = new List<PatientHistory>(); List<PatDtlsVPAction> lstPatDtlsVPAction = new List<PatDtlsVPAction>();
        int cnt = 0;
        try
        {
            long returnCode = 1;
            string sTreatmentType = "NUL";
            if (RoleName == "Dialysis Technician")
            {
                sTreatmentType = "Dia";
            }
            if (IsTrustedOrg == "Y")
            {
                returnCode = patientBL.GetEventChartIsTrustedOrg(PatientId, PatientVisitId, sTreatmentType, out lstEventChart, out lstPatDtlsVPAction, out lstPatientDrug, out lstInvestigation, out lstPatientExamination, out lstPatientHistory);
            }
            else
            {
                returnCode = patientBL.GetEventChart(PatientId, PatientVisitId, sTreatmentType, out lstEventChart, out lstPatDtlsVPAction, out lstPatientDrug, out lstInvestigation, out lstPatientExamination, out lstPatientHistory);
            }
            EventChart2.VisitID = Convert.ToInt64(Request.QueryString["vid"]);
            EventChart2.PatientID = Convert.ToInt64(Request.QueryString["pid"]);
            EventChart2.TaskID = Convert.ToInt32(Request.QueryString["tid"]);
            EventChart2.loadData(lstEventChart, lstPatDtlsVPAction);

            GridView grd = ((GridView)EventChart2.FindControl("gvEventChart"));
            foreach (GridViewRow row in grd.Rows)
            {
                if (((Label)row.FindControl("lblEvents")).Text.Length > 0)
                {
                    cnt = cnt + 1;
                }
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

        return cnt;
    }

    protected void Patient1_PageChanged(object sender, EventArgs e)
    {
        loadEventChart();
        loadcasesheet();
    }

    protected void Patient1_Selected(object sender, EventArgs e)
    {
        loadcasesheet();
    }

    private void loadcasesheet()
    {
        try
        {

            GridView gv = (GridView)EventChart2.FindControl("gvEventChart");
            GridViewRow row = gv.SelectedRow;
            PatientVisitId = Convert.ToInt64(((Label)row.FindControl("lblVisitID")).Text);
            long returncode = -1;
            List<VisitPurpose> lstvisitpurpose = new List<VisitPurpose>();
            PatientVisit_BL pvBL = new PatientVisit_BL(base.ContextInfo);
            returncode = pvBL.GetVisitPurposeName(OrgID, PatientVisitId, out lstvisitpurpose);

            if (vType == "IP")
            {
                tdNewOperationNotes.Style.Add("display", "block");
                tdnewconsultation.Style.Add("display", "none");

                if (lstvisitpurpose[0].VisitPurposeName == "Treatment Procedure")
                {
                    DialysisCaseSheet.loadDialysisDetails(PatientVisitId);
                    DialysisCaseSheet.LoadPatientPrescription();
                    OPCaseSheet.Visible = false;
                    PatientDischrageDetail.Visible = false;
                    DischargeCaseSheetDynamic1.Visible = false;
                    DischargeSummaryR1.Visible = false;
                    NeonatalCaseSheets1.Visible = false;
                    PrintPrescription.Visible = false;
                    divEMR.Visible = false;
                    Treatment.Visible = false;
                    Receipt.Visible = false;
                    onFlowDialysis.Visible = true;
                    DialysisCaseSheet.Visible = true;
                    tdVisitDetails.Visible = true;
                    viewData.Visible = false;
                    InvestigationReportViewer.Visible = false; divFckRefLetter.Style.Add("display", "none");
                }
                else if (lstvisitpurpose[0].VisitPurposeName == "Admission")
                {

                    long pBornVisitID = -1;
                    long returnCode = -1;
                    returnCode = new Neonatal_BL(base.ContextInfo).CheckIsNewBornBaby(OrgID, PatientVisitId, out pBornVisitID);
                    if (pBornVisitID > 0)
                    {
                        NeonatalCaseSheets1.Visible = true;
                        PatientDischrageDetail.Visible = false;
                        DischargeCaseSheetDynamic1.Visible = false;
                        DischargeSummaryR1.Visible = false;
                        NeonatalCaseSheets1.GetInpatientDetails(PatientVisitId);
                        NeonatalCaseSheets1.GetNeonatalCaseSheet(PatientVisitId);
                        NeonatalCaseSheets1.GetNewBornDetails(PatientVisitId);
                    }
                    else
                    {

                        NeonatalCaseSheets1.Visible = false;
                        PatientDischrageDetail.Visible = false;
                        DischargeCaseSheetDynamic1.Visible = false;

                        if (OrgID == 26)
                        {
                            DischargeSummaryR1.Visible = true;
                            DischargeSummaryR1.GetDischargeSummaryCaseSheet(PatientVisitId);
                        }
                        else
                        {
                            //PatientDischrageDetail.Visible = true;

                            DischargeSummaryR1.Visible = false;
                            //PatientDischrageDetail.LoadPatientDischarge(PatientVisitId);
                            DischargeCaseSheetDynamic1.Visible=true;
                            DischargeCaseSheetDynamic1.LoadPatientDischarge(PatientVisitId);
                        }
                    }


                    OPCaseSheet.Visible = false;
                    PrintPrescription.Visible = false;
                    Treatment.Visible = false;
                    Receipt.Visible = false;
                    onFlowDialysis.Visible = false;
                    DialysisCaseSheet.Visible = false;
                    divEMR.Visible = false;
                    tdVisitDetails.Visible = false;
                    viewData.Visible = false;
                    InvestigationReportViewer.Visible = false; divFckRefLetter.Style.Add("display", "none");
                }
                else if (lstvisitpurpose[0].VisitPurposeName == "Upload Patient Old Notes")
                {
                    viewData.Visible = true;
                    OPCaseSheet.Visible = false;
                    PatientDischrageDetail.Visible = false;
                    DischargeCaseSheetDynamic1.Visible = false;
                    DischargeSummaryR1.Visible = false;
                    NeonatalCaseSheets1.Visible = false;
                    PrintPrescription.Visible = false;
                    Treatment.Visible = false;
                    Receipt.Visible = false;
                    divEMR.Visible = false;
                    onFlowDialysis.Visible = false;
                    DialysisCaseSheet.Visible = false;
                    tdVisitDetails.Visible = false;
                    InvestigationReportViewer.Visible = false;
                    viewData.showOldNotes(PatientVisitId);
                    InvestigationReportViewer.Visible = false; divFckRefLetter.Style.Add("display", "none");
                }
                else if (lstvisitpurpose[0].VisitPurposeName.Contains("Lab Investigation"))
                {
                    //OPCaseSheet.LoadPatientDetails(PatientVisitId, 3);
                    InvestigationReportViewer.Visible = true;
                    InvestigationReportViewer.ShowInvestigation(PatientVisitId);
                    PatientDischrageDetail.Visible = false;
                    DischargeCaseSheetDynamic1.Visible = false;
                    DischargeSummaryR1.Visible = false;
                    NeonatalCaseSheets1.Visible = false;
                    OPCaseSheet.Visible = false;
                    PrintPrescription.Visible = false;
                    divEMR.Visible = false;
                    Treatment.Visible = false;
                    Receipt.Visible = false;
                    onFlowDialysis.Visible = false;
                    DialysisCaseSheet.Visible = false;
                    tdVisitDetails.Visible = true;
                    viewData.Visible = false; divFckRefLetter.Style.Add("display", "none");

                }
                else if (lstvisitpurpose[0].VisitPurposeName.Contains("Health Package"))
                {
                    InvestigationReportViewer.Visible = false;
                    PatientDischrageDetail.Visible = false;
                    DischargeCaseSheetDynamic1.Visible = false;
                    DischargeSummaryR1.Visible = false;
                    NeonatalCaseSheets1.Visible = false;
                    OPCaseSheet.Visible = false;
                    PrintPrescription.Visible = false;
                    Treatment.Visible = false;
                    Receipt.Visible = false;
                    onFlowDialysis.Visible = false;
                    DialysisCaseSheet.Visible = false;
                    tdVisitDetails.Visible = false;
                    viewData.Visible = false;

                    divEMR.Visible = true;
                    //ucHis.Visible = true;
                    //ucExam.Visible = true;
                    ucHis.LoadHistoryData(PatientVisitId);
                    ucExam.LoadExamData(PatientVisitId);
                    ucDiagnostics.LoadDiagnostics(PatientVisitId);
                    EMRinvReport.ShowInvestigation(PatientVisitId);
                    List<PatientRecommendationDtls> rTemplate = new List<PatientRecommendationDtls>();
                    List<PhysicianSchedule> lstschedules = new List<PhysicianSchedule>();
                    List<Patient> patientList = new List<Patient>();

                    try
                    {
                        new Patient_BL(base.ContextInfo).GetPatientRecommendationDetails(OrgID, PatientVisitId, PatientId, out  rTemplate, out lstschedules, out patientList); ;
                        grdResult.DataSource = rTemplate;
                        grdResult.DataBind();
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in PageLoad GetPatientRecommendationDetails", ex);
                    }
                }
                else
                {

                    if (configValue == "Y")
                    {

                        EMRCaseSheet.LoadPatientDetails(PatientVisitId, 3);
                       // OPCaseSheet.LoadPatientDetails(PatientVisitId, 3);
                        InvestigationReportViewer.ShowInvestigation(PatientVisitId);
                        InvestigationReportViewer.Visible = true;
                        PatientDischrageDetail.Visible = false;
                        DischargeCaseSheetDynamic1.Visible = false;
                        DischargeSummaryR1.Visible = false;
                        NeonatalCaseSheets1.Visible = false;
                        OPCaseSheet.Visible = false ;
                        EMRCaseSheet.Visible = true;
                        PrintPrescription.Visible = false;
                        Treatment.Visible = false;
                        Receipt.Visible = false;
                        onFlowDialysis.Visible = false;
                        DialysisCaseSheet.Visible = false;
                        tdVisitDetails.Visible = true;
                        viewData.Visible = false;
                        divEMR.Visible = false;
                    }
                    else
                    {
                        OPCaseSheet.LoadPatientDetails(PatientVisitId, 3);
                        InvestigationReportViewer.ShowInvestigation(PatientVisitId);
                        InvestigationReportViewer.Visible = true;
                        PatientDischrageDetail.Visible = false;
                        DischargeCaseSheetDynamic1.Visible = false;
                        DischargeSummaryR1.Visible = false;
                        NeonatalCaseSheets1.Visible = false;
                        OPCaseSheet.Visible = true;
                        EMRCaseSheet.Visible = false;
                        PrintPrescription.Visible = false;
                        Treatment.Visible = false;
                        Receipt.Visible = false;
                        onFlowDialysis.Visible = false;
                        DialysisCaseSheet.Visible = false;
                        tdVisitDetails.Visible = true;
                        viewData.Visible = false;
                        divEMR.Visible = false;
                    }

                    List<Referral> lstReferrals = new List<Referral>();
                    returncode = new Referrals_BL(base.ContextInfo).GetReferralDetailstoEdit(PatientVisitId, lstvisitpurpose[0].VisitPurposeID, out lstReferrals);
                    if (lstReferrals.Count > 0)
                    {
                        //txtRefLetter.Text = lstReferrals[0].ReferralNotes.ToString();
                        if (lstReferrals[0].AllowCaseSheet == "N")
                        {
                            OPCaseSheet.Visible = false;
                            EMRCaseSheet.Visible = false;
                            InvestigationReportViewer.Visible = false;
                        }
                        else
                        {
                            if (configValue == "Y")
                            {
                                EMRCaseSheet.Visible = true;
                            }
                            else
                            {

                                OPCaseSheet.Visible = true;
                            }
                            InvestigationReportViewer.Visible = true;
                        }
                        divFckRefLetter.Style.Add("display", "block");
                        fckHospitalCourse.Value = lstReferrals[0].ReferralNotes;
                    }
                    else
                    {
                        divFckRefLetter.Style.Add("display", "none");
                        //txtRefLetter.Text = string.Empty;
                    }
                }
            }
            else
            {
                tdNewOperationNotes.Style.Add("display", "none");
                tdnewconsultation.Style.Add("display", "block");
                if (lstvisitpurpose[0].VisitPurposeName == "Treatment Procedure")
                {
                    DialysisCaseSheet.loadDialysisDetails(PatientVisitId);
                    DialysisCaseSheet.LoadPatientPrescription();
                    OPCaseSheet.Visible = false;
                    EMRCaseSheet.Visible = false;
                    PatientDischrageDetail.Visible = false;
                    DischargeCaseSheetDynamic1.Visible = false;
                    DischargeSummaryR1.Visible = false;
                    NeonatalCaseSheets1.Visible = false;
                    PrintPrescription.Visible = false;
                    Treatment.Visible = false;
                    divEMR.Visible = false;
                    Receipt.Visible = false;
                    onFlowDialysis.Visible = true;
                    DialysisCaseSheet.Visible = true;
                    tdVisitDetails.Visible = true;
                    viewData.Visible = false;
                    InvestigationReportViewer.Visible = false; divFckRefLetter.Style.Add("display", "none");
                }
                else if (lstvisitpurpose[0].VisitPurposeName == "Admission")
                {
                    long pBornVisitID = -1;
                    long returnCode = -1;
                    returnCode = new Neonatal_BL(base.ContextInfo).CheckIsNewBornBaby(OrgID, PatientVisitId, out pBornVisitID);
                    if (pBornVisitID > 0)
                    {
                        NeonatalCaseSheets1.Visible = true;
                        PatientDischrageDetail.Visible = false;
                        DischargeCaseSheetDynamic1.Visible = false;
                        DischargeSummaryR1.Visible = false;
                        NeonatalCaseSheets1.GetInpatientDetails(PatientVisitId);
                        NeonatalCaseSheets1.GetNeonatalCaseSheet(PatientVisitId);
                        NeonatalCaseSheets1.GetNewBornDetails(PatientVisitId);
                    }
                    else
                    {

                        NeonatalCaseSheets1.Visible = false;
                        PatientDischrageDetail.Visible = false;
                        DischargeCaseSheetDynamic1.Visible = false;                       

                        if (OrgID == 26)
                        {
                            DischargeSummaryR1.Visible = true;
                            DischargeSummaryR1.GetDischargeSummaryCaseSheet(PatientVisitId);
                        }
                        else
                        {
                            //PatientDischrageDetail.Visible = true;
                            DischargeCaseSheetDynamic1.Visible = true;
                            DischargeSummaryR1.Visible = false;
                           // PatientDischrageDetail.LoadPatientDischarge(PatientVisitId);
                            DischargeCaseSheetDynamic1.LoadPatientDischarge(PatientVisitId);
                        }
                    }

                    OPCaseSheet.Visible = false;
                    EMRCaseSheet.Visible = false;
                    PrintPrescription.Visible = false;
                    Treatment.Visible = false;
                    Receipt.Visible = false;
                    divEMR.Visible = false;
                    onFlowDialysis.Visible = false;
                    DialysisCaseSheet.Visible = false;
                    InvestigationReportViewer.Visible = false;
                    tdVisitDetails.Visible = false;
                    viewData.Visible = false; divFckRefLetter.Style.Add("display", "none");
                }
                else if (lstvisitpurpose[0].VisitPurposeName.Contains("Upload Patient Old Notes"))
                {
                    viewData.Visible = true;
                    PatientDischrageDetail.Visible = false;
                    DischargeCaseSheetDynamic1.Visible = false;
                    DischargeSummaryR1.Visible = false;
                    NeonatalCaseSheets1.Visible = false;
                    OPCaseSheet.Visible = false;
                    EMRCaseSheet.Visible = false;
                    divEMR.Visible = false;
                    PrintPrescription.Visible = false;
                    Treatment.Visible = false;
                    Receipt.Visible = false;
                    onFlowDialysis.Visible = false;
                    DialysisCaseSheet.Visible = false;
                    tdVisitDetails.Visible = false;
                    InvestigationReportViewer.Visible = false;
                    viewData.showOldNotes(PatientVisitId); divFckRefLetter.Style.Add("display", "none");
                }
                else if (lstvisitpurpose[0].VisitPurposeName.Contains("Lab Investigation"))
                {
                    //OPCaseSheet.LoadPatientDetails(PatientVisitId, 3);
                    InvestigationReportViewer.Visible = true;
                    InvestigationReportViewer.ShowInvestigation(PatientVisitId);
                    PatientDischrageDetail.Visible = false;
                    DischargeCaseSheetDynamic1.Visible = false;
                    DischargeSummaryR1.Visible = false;
                    NeonatalCaseSheets1.Visible = false;
                    OPCaseSheet.Visible = false;
                    EMRCaseSheet.Visible = false;
                    PrintPrescription.Visible = false;
                    divEMR.Visible = false;
                    Treatment.Visible = false;
                    Receipt.Visible = false;
                    onFlowDialysis.Visible = false;
                    DialysisCaseSheet.Visible = false;
                    tdVisitDetails.Visible = true;
                    viewData.Visible = false; divFckRefLetter.Style.Add("display", "none");

                }
                else if (lstvisitpurpose[0].VisitPurposeName.Contains("Health Package"))
                {
                    InvestigationReportViewer.Visible = false;
                    PatientDischrageDetail.Visible = false;
                    DischargeCaseSheetDynamic1.Visible = false;
                    DischargeSummaryR1.Visible = false;
                    NeonatalCaseSheets1.Visible = false;
                    OPCaseSheet.Visible = false;
                    EMRCaseSheet.Visible = false;
                    PrintPrescription.Visible = false;
                    Treatment.Visible = false;
                    Receipt.Visible = false;
                    onFlowDialysis.Visible = false;
                    DialysisCaseSheet.Visible = false;
                    tdVisitDetails.Visible = false;
                    viewData.Visible = false;

                    divEMR.Visible = true;
                    //ucHis.Visible = true;
                    //ucExam.Visible = true;
                    ucHis.LoadHistoryData(PatientVisitId);
                    ucExam.LoadExamData(PatientVisitId);
                    ucDiagnostics.LoadDiagnostics(PatientVisitId);
                    EMRinvReport.ShowInvestigation(PatientVisitId);
                    long count = OldNotesViewer1.showOldNotes(PatientVisitId);
                    if (count == 0)
                    {
                        OldNotesViewer1.Visible = false;
                        upLoadViewer.Visible = false;
                    }
                    else
                    {
                        OldNotesViewer1.Visible = true;
                        upLoadViewer.Visible = true;
                    }
                    List<PatientRecommendationDtls> rTemplate = new List<PatientRecommendationDtls>();
                    List<PhysicianSchedule> lstschedules = new List<PhysicianSchedule>();
                    List<Patient> patientList = new List<Patient>();

                    try
                    {
                        new Patient_BL(base.ContextInfo).GetPatientRecommendationDetails(OrgID, PatientVisitId, PatientId, out  rTemplate, out lstschedules, out patientList); ;
                        grdResult.DataSource = rTemplate;
                        grdResult.DataBind();
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in PageLoad GetPatientRecommendationDetails", ex);
                    }
                }
                else
                {

                    
                    List<Referral> lstReferrals = new List<Referral>();
                    returncode = new Referrals_BL(base.ContextInfo).GetReferralDetailstoEdit(PatientVisitId, lstvisitpurpose[0].VisitPurposeID, out lstReferrals);
                    if (configValue == "Y")
                    {
                        EMRCaseSheet.LoadPatientDetails(PatientVisitId, 3);
                        EMRCaseSheet.Visible = true;
                        //OPCaseSheet.LoadPatientDetails(PatientVisitId, 3);
                        OPCaseSheet.Visible = false;
                        InvestigationReportViewer.ShowInvestigation(PatientVisitId);
                        InvestigationReportViewer.Visible = true;
                        PatientDischrageDetail.Visible = false;
                        DischargeCaseSheetDynamic1.Visible = false;
                        DischargeSummaryR1.Visible = false;
                        NeonatalCaseSheets1.Visible = false;
                        PrintPrescription.Visible = false;
                        Treatment.Visible = false;
                        Receipt.Visible = false;
                        onFlowDialysis.Visible = false;
                        DialysisCaseSheet.Visible = false;
                        tdVisitDetails.Visible = true;
                        viewData.Visible = false;
                    }
                    else
                    {
                        OPCaseSheet.LoadPatientDetails(PatientVisitId, 3);
                        OPCaseSheet.Visible = true;
                        EMRCaseSheet.Visible = false;
                        InvestigationReportViewer.ShowInvestigation(PatientVisitId);
                        InvestigationReportViewer.Visible = true;
                        PatientDischrageDetail.Visible = false;
                        DischargeCaseSheetDynamic1.Visible = false;
                        DischargeSummaryR1.Visible = false;
                        NeonatalCaseSheets1.Visible = false;
                        PrintPrescription.Visible = false;
                        Treatment.Visible = false;
                        Receipt.Visible = false;
                        onFlowDialysis.Visible = false;
                        DialysisCaseSheet.Visible = false;
                        tdVisitDetails.Visible = true;
                        viewData.Visible = false;
                    }
                    //ucHis.Visible = false;
                    //ucExam.Visible = false;
                    divEMR.Visible = false;
                    if (lstReferrals.Count > 0)
                    {
                        //txtRefLetter.Text = lstReferrals[0].ReferralNotes.ToString();

                        if (lstReferrals[0].AllowCaseSheet == "N" && lstReferrals[0].ReferedByOrgID != OrgID)
                        {
                            OPCaseSheet.Visible = false;
                            InvestigationReportViewer.Visible = false;
                        }
                        else
                        {

                            if (configValue == "Y")
                            {
                                EMRCaseSheet.LoadPatientDetails(PatientVisitId, 3);
                            }
                            else
                            {
                                EMRCaseSheet.Visible = false;
                                OPCaseSheet.Visible = true;
                            }
                            InvestigationReportViewer.Visible = true;
                        }
                        divFckRefLetter.Style.Add("display", "block");
                        fckHospitalCourse.Value = lstReferrals[0].ReferralNotes;
                    }
                    else
                    {
                        divFckRefLetter.Style.Add("display", "none");
                        //txtRefLetter.Text = string.Empty;
                    }
                }
            }
        }

        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while showing case Sheet details", ex);

        }

    }

    protected void Patient1_SelectedChecked(object sender, EventArgs e)
    {
        try
        {
            List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
            long returncode = -1;
            CaseSheet_BL casesheetBL = new CaseSheet_BL(base.ContextInfo);
            returncode = casesheetBL.GetPatientComplaintDetail(EventChart2.VisitID, out lstPatientComplaint);
            int option = 1;

            //Session commented by Ramki
            //Session.Add("PatientVisitID", PatientVisitId);

            if (EventChart2.PatientDetailsOptions == "ContinueSameTreatment")
            {
                if (configValue == "Y")
                {
                    Response.Redirect(@"../Physician/diadetesEMROPCaseSheet.aspx?vid=" + PatientVisitId + "&pvid=" + EventChart2.VisitID + "&id=" + EventChart2.ComplaintID + "&pid=" + PatientId + "&tid=" + taskID + "&optionid=" + option + "", true);
                }
                else
                {
                    Response.Redirect(@"../CaseSheet/CaseSheet.aspx?vid=" + PatientVisitId + "&pvid=" + EventChart2.VisitID + "&id=" + EventChart2.ComplaintID + "&pid=" + PatientId + "&tid=" + taskID + "&optionid=" + option + "", true);
                }
            }
            else if (EventChart2.PatientDetailsOptions == "AlterPrescription")
            {
                if (returncode == 0)
                {
                    if (lstPatientComplaint.Count == 1)
                    {
                        if (lstPatientComplaint[0].ComplaintID > 0)//Previous Visit Data Entered in PatientDiagnose Page (ComplaintID is always Greater than 0)
                        {
                            Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + PatientVisitId + "&pid=" + PatientId + "&id=" + lstPatientComplaint[0].ComplaintID + "&pvid=" + EventChart2.VisitID + "&tid=" + taskID + "", true);
                        }
                        else if (lstPatientComplaint[0].ComplaintID == 0)//Previous Visit Data Entered in UnfoundDiagnosis Page(ComplaintID is equal to 0)
                        {
                            if (configValue == "Y")
                            {
                                Response.Redirect(@"../Physician/diabetesEMR.aspx?vid=" + PatientVisitId + "&pvid=" + EventChart2.VisitID + "&id=" + EventChart2.ComplaintID + "&pid=" + PatientId + "&tid=" + taskID + "&optionid=" + option + "", true);
                            }
                            else
                            {
                                Response.Redirect(@"../Physician/UnfoundDiagnosis.aspx?vid=" + PatientVisitId + "&pid=" + PatientId + "&id=" + lstPatientComplaint[0].ComplaintID + "&pvid=" + EventChart2.VisitID + "&tid=" + taskID + "", true);
                            }
                        }
                        else if (lstPatientComplaint[0].ComplaintID == -1) //Previous Visit Data Entered in QuickDiagnosis Page(ComplaintID is equal to -1)
                        {
                            Response.Redirect(@"../Physician/QuickDiagnosis.aspx?vid=" + PatientVisitId + "&pid=" + PatientId + "&id=" + lstPatientComplaint[0].ComplaintID + "&pvid=" + EventChart2.VisitID + "&tid=" + taskID + "", true);
                        }
                    }
                    else
                    {
                        Response.Redirect("../Physician/DisplayPatientComplaint.aspx?vid=" + PatientVisitId + "&pid=" + PatientId + "&tid=" + taskID + "&pvid=" + EventChart2.VisitID, true);
                    }
                }
            }
            else if (EventChart2.PatientDetailsOptions == "InvestigateFurther")
            {
                Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + PatientVisitId + "&pid=" + PatientId + "&id=" + lstPatientComplaint[0].ComplaintID + "", true);
            }
            else if (EventChart2.PatientDetailsOptions == "ChangeDiagnosis")
            {
                Response.Redirect(@"../Physician/Diagnose.aspx?vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + "&pvid=" + EventChart2.VisitID + "", true);
            }
            else if (EventChart2.PatientDetailsOptions == "AlterHealthInformation")
            {
                Response.Redirect(@"../Patient/PatientEMRPackage.aspx?pid=" + PatientId + "&vid=" + PatientVisitId + "&pvid=" + EventChart2.VisitID + "&tid=" + taskID + "", true);
            }
            else if (EventChart2.PatientDetailsOptions == "AddRecommendations")
            {
                Response.Redirect(@"../Patient/PatientEMRPackage.aspx?pid=" + PatientId + "&vid=" + PatientVisitId + "&pvid=" + EventChart2.VisitID + "&tid=" + taskID + "", true);
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


    protected void ibtnGo_Click(object sender, EventArgs e)
    {
        lnkView.Visible = true;
        loadEventName();
        loadcasesheet();

    }

    public void loadEventName()
    {
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        List<EventChart> lstEventChart = new List<EventChart>(); List<PatDtlsVPAction> lstPatDtlsVPAction = new List<PatDtlsVPAction>();
        long returnCode = 1;
        returnCode = patientBL.GetEventChartName(PatientId, txtSearchText.Text.Trim(), out lstEventChart, out lstPatDtlsVPAction);
        if (lstEventChart.Count > 0)
        {
            PatientVisitId = lstEventChart[0].VisitId;
        }
        EventChart2.loadData(lstEventChart, lstPatDtlsVPAction);

    }



    protected void lnkView_Click(object sender, EventArgs e)
    {
        loadEventChart();
        txtSearchText.Text = "";
        lnkView.Visible = false;
        loadcasesheet();
    }


    protected void btnDiagnose_Click(object sender, EventArgs e)
    {
        try
        {
            //Response.Redirect(@"../Physician/Diagnose.aspx?&vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + "", true);
            List<VisitPurpose> lstvisitpurpose = new List<VisitPurpose>();
            new PatientVisit_BL(base.ContextInfo).GetVisitPurposeName(OrgID, PatientVisitId, out lstvisitpurpose);
            taskBL.GetTaskActionDetail(PatientVisitId, taskID, out SpecialityID, out TaskActionName, out TaskActionID);
            if (lstvisitpurpose[0].VisitPurposeName == "Health Package")
            {
                if (SpecialityID == -1)
                {
                    Response.Redirect(@"../Patient\PatientEMRPackage.aspx?vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + "", true);
                }
                else if (SpecialityID == 1)
                {
                    Response.Redirect(@"../Physician/Diagnose.aspx?vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + "", true);
                }
            }
            else if (lstvisitpurpose[0].VisitPurposeName == "Consultation")
            {
                Response.Redirect(@"../Physician/Diagnose.aspx?vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + "", true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    protected void ibtnDiagnose_Click(object sender, EventArgs e)
    {
        try
        {
            //Response.Redirect(@"../Physician/Diagnose.aspx?&vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + "", true);
            List<VisitPurpose> lstvisitpurpose = new List<VisitPurpose>();
            new PatientVisit_BL(base.ContextInfo).GetVisitPurposeName(OrgID, PatientVisitId, out lstvisitpurpose);
            taskBL.GetTaskActionDetail(PatientVisitId, taskID, out SpecialityID, out TaskActionName, out TaskActionID);
            if (lstvisitpurpose[0].VisitPurposeName == "Health Package" || TaskActionID == 38)
            {

                if (Request.QueryString["Flow"] == "HealthScreening")
                {
                    Flow = "&Flow=HealthScreening";
                }
                else
                {
                    Flow = "";

                }
                if (SpecialityID == -1)
                {
                    Response.Redirect(@"../Patient\PatientEMRPackage.aspx?vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + Flow + "", true);
                }
                  else if (SpecialityID == 1)
                {
                    Response.Redirect(@"../Physician/Diagnose.aspx?vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + "", true);
                }
            }
            else if (lstvisitpurpose[0].VisitPurposeName == "Consultation")
            {
                if (SpecialityID == 13)
                {
                   // PatientVisitId = 0;
                    Response.Redirect(@"../Patient/PatientEMRPackage.aspx?vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + "", true);
                }
                else
                {
                    Response.Redirect(@"../Physician/Diagnose.aspx?vid=" + PatientVisitId + "&tid=" + taskID + "&pid=" + PatientId + "", true);
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    protected void btnNewOperationNotes_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Physician/IPCaseRecord.aspx?PID=" + PatientId.ToString() + "&VID=" + PatientVisitId + "&PNAME=" + sPatientName + "&vType=" + "IP", true);

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    private void GetFCKPath()
    {
        try
        {
            string sPath = Request.Url.AbsolutePath;
            int iIndex = sPath.LastIndexOf("/");

            sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
            sPath = Request.ApplicationPath;
            sPath = sPath + "/fckeditor/";
            fckHospitalCourse.ToolbarSet = "Attune";
            fckHospitalCourse.BasePath = sPath;
            fckHospitalCourse.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            fckHospitalCourse.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in FCk Editor In DischargeSummary.aspx", ex);
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
