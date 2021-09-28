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
using System.Collections.Generic;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Globalization;
using System.Text;

public partial class Physician_AddDrugs : BasePage
{
    public Physician_AddDrugs()
        : base("Physician\\AddDrugs.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    
    long visitID = -1;
    long patientID = -1;
    long complaintID = -1;
    long taskID = -1;
    long returnCode = -1;
    long previousVID = -1;
    long createdBy = -1;
    Tasks task = new Tasks();
    Tasks_BL taskBL;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    long createTaskID = -1;
    string feeType = String.Empty;
    string PaymentLogic = String.Empty;
    string others = string.Empty;
    string InvDrugData = string.Empty;
    int drugCount = 0;
    string gUID = "";
    long VisitType = 0;
    string AddPay = string.Empty;
    int InvLocationID = 0;
    long vid = 0;
    long pid = 0;
    int specialityid, followup;
   
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    PatientVisit_BL oPatientVisit_BL;
   
    protected void Page_Load(object sender, EventArgs e)
    {
        taskBL = new Tasks_BL(base.ContextInfo);
        oPatientVisit_BL = new PatientVisit_BL(base.ContextInfo);
           
        try
        {
            ErrorDisplay1.ShowError = false;
            Int64.TryParse(Request.QueryString["pid"].ToString(), out pid);
            if (Int64.TryParse(Request.QueryString["vid"].ToString(), out vid))
            {
                if (!IsPostBack)
                {
                    List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
                    Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
                    ANC_BL ancBL = new ANC_BL(base.ContextInfo);
                    List<Config> lstConfigDD = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
                    if (lstConfigDD.Count > 0)
                    {
                        InvDrugData = lstConfigDD[0].ConfigValue.Trim();
                    }
                    if (InvDrugData == "Y")
                    {
                        uAd.Visible = false;
                        uIAdv.Visible = true;
                    }
                    else
                    {
                        uAd.Visible = true;
                        uIAdv.Visible = false;
                    }
                    try
                    {
                        if (vid > 0)
                        {
                            physicianBL.GetPatientPrescription(vid, out lstDrugDetails);
                            ancBL.GetANCSpecilaityID(vid, out specialityid, out followup);
                            oPatientVisit_BL.GetVisitDetails(vid, out lstPatientVisit);
                            LoadPatientPrescription(lstDrugDetails,lstPatientVisit);
                            if (InvDrugData == "Y")
                            {
                                uIAdv.SetPrescription(lstDrugDetails);
                            }
                            else
                            {
                                if (lstDrugDetails.Count > 0)
                                {
                                    uIAdv.SetPrescription(lstDrugDetails);


                                }
                            }
                            if (specialityid != Convert.ToInt32(TaskHelper.speciality.ANC))
                            {
                                OPCaseSheet.LoadPatientDetails(vid, 0);


                            }
                            else
                            {
                                Int64.TryParse(Request.QueryString["pid"].ToString(), out pid);
                                ancCaseSheet.LoadCaseSheetDetails(vid, pid);
                                hdnCasesheetType.Value = "";
                                hdnCasesheetType.Value = "ANC";


                            }

                        }
                    }
                    catch (Exception excp)
                    {
                        CLogger.LogError("Error Loading AddDrugs.aspx", excp);
                        ErrorDisplay1.ShowError = true;
                        ErrorDisplay1.Status = "Error Loading AddDrugs.aspx";
                    }

                }
            }
            else
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "Invalid entry to current page";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load Physician/AddDrugs", ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {


    
        createdBy = LID;
     
        List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
        long returnCode = -1;
        try
        {
            Uri_BL uriBL = new Uri_BL(base.ContextInfo);
            lstDrugDetails = uIAdv.GetPrescription(vid);
            returnCode = uriBL.InsertPatientPrescriptionBulk(lstDrugDetails);
            ///Task For Pharmacy From PatientPrescription 
            List<Config> lstConfigDD = new List<Config>();


            if (returnCode != 0)
            {
                displayError("Unable to save prescription. Pl. contact administrator");
            }
            else
            {
                //Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
                new Physician_BL(base.ContextInfo).GetPatientPrescription(vid, out lstDrugDetails);
                new PatientVisit_BL(base.ContextInfo).GetVisitDetails(vid, out lstPatientVisit);
                LoadPatientPrescription(lstDrugDetails, lstPatientVisit);


            }

            new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
            if (lstConfigDD.Count > 0)
            {
                InvDrugData = lstConfigDD[0].ConfigValue.Trim();
            }
            if (InvDrugData == "Y")
            {
                int ptaskID = 0;
                long PhysicianID = 0;
                DrugDetails pAdvices = new DrugDetails();
                PhysicianSchedule physician = new PhysicianSchedule();
                new GateWay(base.ContextInfo).GetPhysicianDetails(LID, out physician);
                pAdvices.PhysicianID = physician.PhysicianID;
                PhysicianID = pAdvices.PhysicianID;
                string PrescriptionNo = "0";
                string pTaskStatus = "";

                //returnCode = new Inventory_BL(base.ContextInfo).getPatientPrescriptiondrugCount(vid, out drugCount, out ptaskID, PhysicianID, out PrescriptionNo, out pTaskStatus);
                if (ptaskID > 0 && pTaskStatus == "PENDING")
                {
                    if (drugCount > 0)
                    {
                       // returnCode = new Inventory_BL(base.ContextInfo).InsertTaskID("PRM", ptaskID, PrescriptionNo, OrgID, pid, vid);
                    }
                }
                else
                {
                    if (drugCount > 0)
                    {

                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Pharmacy), vid, LID, pid,
                              lstPatientVisit[0].TitleName + " " + lstPatientVisit[0].PatientName, "",
                              0, "", 0, "", 0, "PRM", out dText, out urlVal, 0, "", 0, "");
                        task.TaskActionID = (IsCorporateOrg == "Y" ? Convert.ToInt32(TaskHelper.TaskAction.CorporatePharmacy) : Convert.ToInt32(TaskHelper.TaskAction.Pharmacy));


                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;

                        task.PatientVisitID = vid;
                        task.PatientID = pid;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        task.LocationID = InvLocationID;
                        //task.TaskID = taskID;
                        //Create collection task
                        returnCode = taskBL.CreateTask(task, out createTaskID);

                       // returnCode = new Inventory_BL(base.ContextInfo).InsertTaskID("PRM", createTaskID, PrescriptionNo, OrgID, pid, vid);


                    }
                }
            }
        }
        catch (Exception excp)
        {
            CLogger.LogError("Error saving patient prescription in AddDrugs.aspx", excp);
            displayError("Unable to save prescription. Pl. contact administrator");
        }
    }

    private void displayError(string strError)
    {
        btnSave.Visible = true;
        ErrorDisplay1.ShowError = true;
        ErrorDisplay1.Status = strError;
    }


    private void LoadPatientPrescription(List<DrugDetails> lstDrugDetails, List<PatientVisit> lstPatientVisit)
    {
        StringBuilder PatientPrescription = new StringBuilder();
       // StringBuilder Patientvist = new StringBuilder();
        

        if (lstDrugDetails.Count > 0)
        {
            
            PatientPrescription.Append("<table width='100%' > ");
            PatientPrescription.Append("<tr align='left' style='text-align:left;'>");
            PatientPrescription.Append("<td colspan='2'><font size='2'><b>" + "<%=Resources.ClientSideDisplayTexts.Physician_AddDrugs_PatientName %>" + ":" + lstPatientVisit[0].PatientName + "</b></font></td>");
            PatientPrescription.Append("<td colspan='2'><font size='2'><b>" + "<%=Resources.ClientSideDisplayTexts.Physician_AddDrugs_Age %>" + ":" + lstPatientVisit[0].PatientAge + "</b></font></td>");
            PatientPrescription.Append("</tr>");
            PatientPrescription.Append("<tr>");




            PatientPrescription.Append("<td colspan='2'><font size='2'><b>" + "<%=Resources.ClientSideDisplayTexts.Physician_AddDrugs_PatientNumber %>" + ":" + lstPatientVisit[0].PatientNumber + "</b></font></td>");
            PatientPrescription.Append("<td colspan='1'><font size='2'><b>" + "<%=Resources.ClientSideDisplayTexts.Physician_AddDrugs_PatientID %>" + ":" + lstPatientVisit[0].PatientID + "</b></font></td>");
            PatientPrescription.Append("</tr>");
            PatientPrescription.Append("<tr>");
            PatientPrescription.Append("<td colspan='1'><font size='2'><b>" + "<%=Resources.ClientSideDisplayTexts.Physician_AddDrugs_PrescriptionNumber %>" + ":" + lstDrugDetails[0].PrescriptionNumber + "</b></font></td>");
         
        
            PatientPrescription.Append("<td colspan='6'><font size='2'><b>PrescriptionBy:" + lstPatientVisit[0].PhysicianName + "</b></font></td>");
            //PatientPrescription.Append("<td nowrap='nowrap'>" + lstPatientVisit[0].PatientName + "</td>");
            //PatientPrescription.Append("<td nowrap='nowrap'>" + lstPatientVisit[0].PatientNumber + "</td>");
            PatientPrescription.Append("</tr>");
            PatientPrescription.Append("<tr align='left' style='text-align:left;'>");
            PatientPrescription.Append("<hr />");
            PatientPrescription.Append("<td colspan='6'><font size='2'><b>"+"<%=Resources.ClientSideDisplayTexts.Physician_AddDrugs_TREATMENT %>"+"</b></font></td>");
            PatientPrescription.Append("</tr>");
            //PatientPrescription.Append("<tr>");
            PatientPrescription.Append("<tr> ");
            PatientPrescription.Append("<td> " + "<%=Resources.ClientSideDisplayTexts.Physician_AddDrugs_SNO %>" + " </td>");

            PatientPrescription.Append("<td>" + "<%=Resources.ClientSideDisplayTexts.Physician_AddDrugs_DrugName %>" + "</td>");
            PatientPrescription.Append("<td>" + "<%=Resources.ClientSideDisplayTexts.Physician_AddDrugs_Dose %>" + "</td>");
            PatientPrescription.Append("<td>" + "<%=Resources.ClientSideDisplayTexts.Physician_AddDrugs_Frequency %>" + " </td>");
            PatientPrescription.Append("<td>" + "<%=Resources.ClientSideDisplayTexts.Physician_AddDrugs_Duration %>" + "</td>");
            PatientPrescription.Append("<td>" + "<%=Resources.ClientSideDisplayTexts.Physician_AddDrugs_Instruction %>" + " </td>");
            PatientPrescription.Append("</tr>");
            for (int i = 0, j = 1; i < lstDrugDetails.Count; i++, j++)
            {
                
                PatientPrescription.Append("<tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                
                PatientPrescription.Append("<td nowrap='nowrap'>" + j.ToString() + ". </td>");
           
                PatientPrescription.Append("<td nowrap='nowrap'>" + lstDrugDetails[i].DrugName + "</td>");
                PatientPrescription.Append("<td nowrap='nowrap'>" + lstDrugDetails[i].Dose + "</td>");
                PatientPrescription.Append("<td nowrap='nowrap'>" + lstDrugDetails[i].DrugFrequency + "</td>");
                PatientPrescription.Append("<td nowrap='nowrap'>" + lstDrugDetails[i].Days + "</td>");
                PatientPrescription.Append("<td nowrap='nowrap'>" + lstDrugDetails[i].Instruction + "</td>");
                PatientPrescription.Append("<td style='overflow:auto' >" + lstDrugDetails[i].ROA + "</td>");
                PatientPrescription.Append("</tr>");


            }
            PatientPrescription.Append("</table>");

            lblPrescription.Text = PatientPrescription.ToString();
            //lblpatientname.Text = Patientvist.ToString();

        }
    }
}
