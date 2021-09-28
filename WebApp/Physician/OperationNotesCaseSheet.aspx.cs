using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Drawing;
using System.Web.UI.HtmlControls;

public partial class Physician_OperationNotesCaseSheet : BasePage
{

    public Physician_OperationNotesCaseSheet()
        : base("Physician\\OperationNotesCaseSheet.aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long patientVisitID = -1;
    long patientID = -1;
    long returnCode = -1;
    long OperationID = -1;
   

    

    List<Patient> lstPatient = new List<Patient>();
    List<OperationNotes> lstOperationNotes = new List<OperationNotes>();
    List<IPTreatmentPlan> lstIPTreatmentPlan = new List<IPTreatmentPlan>();
    List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
    List<OperationStaff> lstOperationTeam = new List<OperationStaff>();
    List<AHPStaff> lstTechnicianName = new List<AHPStaff>();
    List<Nurse> lstNurse = new List<Nurse>();
    List<SurgeryType> lstSurgeryType = new List<SurgeryType>();
    List<OperationType> lstOperationType = new List<OperationType>();
    List<AnesthesiaType> lstAnesthesiaType = new List<AnesthesiaType>();
    List<OperationFinding> lstOperationFinding = new List<OperationFinding>();
    List<OperationComplication> lstOperationComplication = new List<OperationComplication>();

    IP_BL ipBL;

    List<DischargeConfig> lstAllDischargeConfig = new List<DischargeConfig>();
    string DischargeConfigs = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        ipBL = new IP_BL(base.ContextInfo);
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["oid"], out OperationID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        if (patientVisitID != -1)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["page"] != null)
                {
                    if (Request.QueryString["page"] == "Visit" || Request.QueryString["page"] == "ICD")
                    {
                        tblTreatment.Style.Add("display", "block");
                        tblDischrageResult.Style.Add("display", "none");
                        tblSave.Style.Add("display", "none");
                        GetOperationDetailByVisitID();

                    }
                    else
                    {
                        tblTreatment.Style.Add("display", "none");
                        pGetOperationNotesCaseSheet();


                    }

                    if (Request.QueryString["page"] == "ICD")
                    {
                        btnEdit.Visible = false;
                        btnPrint.Visible = false;
                        btnCancel.Visible = false;
                        // LeftMenu1.Visible = false;
                        MainHeader.Visible = false;


                    }
                }
            }
        }
    }

    private void GetOperationDetailByVisitID()
    {
        try
        {
            tblTreatment.Style.Add("display", "block");
            List<IPTreatmentPlan> lstIPTreatmentPlanbyPatientVistID = new List<IPTreatmentPlan>();
            ipBL.GetIPTreatmentPlanbyPatientVistID(patientVisitID, out lstIPTreatmentPlanbyPatientVistID);
            if (lstIPTreatmentPlanbyPatientVistID.Count > 0)
            {

                gvTreatment.DataSource = lstIPTreatmentPlanbyPatientVistID;
                gvTreatment.DataBind();

                btnViewOperationNotes.Visible = true;
                btnAddNew.Visible = false;
            }
            else
            {
                btnViewOperationNotes.Visible = false;
                btnAddNew.Visible = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Displaying DischargeSummary Case Sheet  page", ex);
        }
    }

    private void pGetOperationNotesCaseSheet()
    {
        if (Request.QueryString["page"] == "Visit" || Request.QueryString["page"] == "ICD")
        {
            OperationID = Convert.ToInt64(hdnOPID.Value);
           
        }
       


        returnCode = ipBL.pGetOperationNotesCaseSheet(patientVisitID, OperationID, OrgID, out lstPatient, out lstOperationNotes, out lstIPTreatmentPlan, out lstPatientComplaint, out lstOperationTeam, out lstTechnicianName, out lstNurse, out lstSurgeryType, out lstOperationType, out lstAnesthesiaType, out lstOperationFinding, out lstOperationComplication);
        new GateWay(base.ContextInfo).GetAllDischargeConfig(OrgID, out DischargeConfigs, out lstAllDischargeConfig);

        if (returnCode == 0)
        {
            if (lstPatient.Count > 0)
            {
                if (lstPatient[0].BloodGroup == "-1")
                {
                    BloodGroup = "";
                }
                else
                {
                    BloodGroup = lstPatient[0].BloodGroup;
                }

                if (lstPatient[0].SEX == "M")
                {
                    if (BloodGroup != "")
                    {
                        lblPatientDetail.Text =  lstPatient[0].Name + "," + lstPatient[0].Age + "/" + lstPatient[0].SEX + "," + "(Patient ID-" + lstPatient[0].PatientNumber.ToString() + ")" + "  BloodGroup: " + BloodGroup;
                    }
                    else
                    {
                        lblPatientDetail.Text =  lstPatient[0].Name + "," + lstPatient[0].Age + "/" + lstPatient[0].SEX + "," + "(Patient ID-" + lstPatient[0].PatientNumber.ToString() + ")" + BloodGroup;
                    }

                }
                else if (lstPatient[0].SEX == "F")
                {
                    if (BloodGroup != "")
                    {
                        lblPatientDetail.Text =  lstPatient[0].Name + "," + lstPatient[0].Age + "/" + lstPatient[0].SEX + "," + "(Patient ID-" + lstPatient[0].PatientNumber.ToString() + ")" + "  BloodGroup: " + BloodGroup;
                    }
                    else
                    {
                        lblPatientDetail.Text =  lstPatient[0].Name + "," + lstPatient[0].Age + "/" + lstPatient[0].SEX + "," + "(Patient ID-" + lstPatient[0].PatientNumber.ToString() + ")" + BloodGroup;

                    }
                }
            }

            if (lstOperationNotes.Count > 0)
            {
                trDOS.Style.Add("display", "block");
                lblDTO.Text = lstOperationNotes[0].FromTime.ToString("dd/MM/yyyy hh:mm tt");
            }

            if (lstIPTreatmentPlan.Count > 0)
            {
                trsurgery.Style.Add("display","block");
                TableRow rowH = new TableRow();
                TableCell cellH1 = new TableCell();
                TableCell cellH2 = new TableCell();
                TableCell cellH3 = new TableCell();
                TableCell cellH4 = new TableCell();
                TableCell cellH5 = new TableCell();
                cellH1.Attributes.Add("align", "left");
                cellH1.Text = "Type";
                cellH2.Attributes.Add("align", "left");
                cellH2.Text = "Treatment Name";
                cellH3.Attributes.Add("align", "left");
                cellH3.Text = "Prosthesis";
                rowH.Cells.Add(cellH1);
                rowH.Cells.Add(cellH2);
                rowH.Cells.Add(cellH3);
               
                rowH.Font.Bold = true;

                rowH.Style.Add("color", "#000");
                tblSurgeryDetail.Rows.Add(rowH);

                foreach (var oIPTreatmentPlan in lstIPTreatmentPlan)
                {

                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();
                    TableCell cell3 = new TableCell();
                    cell1.Attributes.Add("align", "left");
                    cell1.Text = oIPTreatmentPlan.ParentName;
                    cell2.Attributes.Add("align", "left");
                    cell2.Text = oIPTreatmentPlan.IPTreatmentPlanName;

                    if (oIPTreatmentPlan.Prosthesis == "")
                    {
                        cell3.Attributes.Add("align", "left");
                        cell3.Text = "-";
                    }
                    else
                    {
                        cell3.Attributes.Add("align", "left");
                        cell3.Text = oIPTreatmentPlan.Prosthesis;
                    }
                      
                    row1.Cells.Add(cell1);
                    row1.Cells.Add(cell2);
                    row1.Cells.Add(cell3);
                    row1.Style.Add("color", "#000");
                    tblSurgeryDetail.Rows.Add(row1);
                }
            }

            var NeedDiagnoseWithICD10InDSY = from res in lstAllDischargeConfig
                                             where res.DischargeConfigKey == "NeedDiagnoseWithICD10InDSY"
                                                    && res.DischargeConfigValue == "Y"
                                             select res;
            if (NeedDiagnoseWithICD10InDSY.Count() == 0)
            {
                if (lstPatientComplaint.Count > 0)
                {
                    trDiagnosis.Style.Add("display", "block");
                    foreach (var oPatientComplaint in lstPatientComplaint)
                    {
                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        cell1.Attributes.Add("align", "left");
                        cell1.Text = "<li type=a>" + oPatientComplaint.ComplaintName;
                        row1.Cells.Add(cell1);
                        row1.Style.Add("color", "#000");
                        tbldiagnosis.Rows.Add(row1);

                    }
                }
            }
            else
            {
                DiagnoseWithICD1.HeaderText = "CLINICAL DIAGNOSIS";
                DiagnoseWithICD1.LoadPatientComplaintWithICD(patientVisitID , "IP", "OPR");
            }


            if (lstOperationTeam.Count > 0)
            {
                string assistingPhysician = string.Empty;
                string Anesthetist = string.Empty;
                foreach (var vChief in lstOperationTeam)
                {
                    if (vChief.StaffType == "Chief")
                    {
                        lblChiefOperator.Text = "Dr."+ vChief.PhysicianName;
                    }
                    if (vChief.StaffType == "Phy")
                    {
                        if (assistingPhysician == string.Empty)
                        {
                            assistingPhysician = "Dr." + vChief.PhysicianName ;
                        }
                        else
                        {
                            assistingPhysician += " ," + "Dr." + vChief.PhysicianName ;
                        }
                    }
                    if (vChief.StaffType == "Anesthetist")
                    {
                        if (Anesthetist == string.Empty)
                        {
                            Anesthetist = "Dr." + vChief.PhysicianName;
                        }
                        else
                        {
                            Anesthetist += " ," + "Dr." + vChief.PhysicianName;
                        }
                    }
                }

                if (assistingPhysician != string.Empty)
                {
                    trAssistingOperator.Style.Add("display", "block");
                    lblAssistingOperator.Text = assistingPhysician+" .";
                }
                if (Anesthetist != string.Empty)
                {
                    trAnesthetist.Style.Add("display", "block");
                    lblAnesthetist.Text = Anesthetist + " .";
                }
            }

            if (lstTechnicianName.Count > 0)
            {
                trTechnician.Style.Add("display", "block");
                string TechnicianName = string.Empty;
                foreach (var vTechnicianName in lstTechnicianName)
                {
                    if (TechnicianName == string.Empty)
                    {
                        TechnicianName = vTechnicianName.StaffName ;
                    }
                    else
                    {
                        TechnicianName += " ," + vTechnicianName.StaffName ;
                    }
                }

                lblTechnician.Text = TechnicianName + " .";
            }

            if (lstNurse.Count > 0)
            {
                trNurse.Style.Add("display", "block");
                string NurseName = string.Empty;
                foreach (var vNurse in lstNurse)
                {
                    if (NurseName == string.Empty)
                    {
                        NurseName = vNurse.NurseName;
                    }
                    else
                    {
                        NurseName +=  " ,"+vNurse.NurseName ;
                    }
                }

                lblNurse.Text = NurseName + " .";
            }

            if (lstSurgeryType.Count > 0)
            {
               
                lblSurgeryType.Text = lstSurgeryType[0].TypeName;
            }
            if (lstOperationType.Count > 0)
            {
               
                lblOperationType.Text = lstOperationType[0].TypeName;
            }
            if (lstAnesthesiaType.Count > 0)
            {               
                lblAnesthesiaType.Text = lstAnesthesiaType[0].TypeName;
            }


            if (lstOperationFinding.Count > 0)
            {

                foreach (OperationFinding objOperationFinding in lstOperationFinding)
                {
                    if (objOperationFinding.Type == "PreOPF")
                    {
                        trPreOF.Style.Add("display", "block");
                        lblPreOF.Text = objOperationFinding.OperationFindings;

                    }
                    if (objOperationFinding.Type == "OPT")
                    {
                        trOPT.Style.Add("display", "block");
                        lblOPT.Text = objOperationFinding.OperationFindings;

                    }
                    if (objOperationFinding.Type == "OPF")
                    {
                        trOPF.Style.Add("display", "block");
                        lblOPF.Text = objOperationFinding.OperationFindings;

                    }
                    if (objOperationFinding.Type == "PostOPF")
                    {
                        trPostOF.Style.Add("display", "block");
                        lblPostOF.Text = objOperationFinding.OperationFindings;
                    }
                }
            }


            if (lstOperationComplication.Count > 0)
            {
                trOperationComplication.Style.Add("display", "block");
                foreach (var oOperationComplication in lstOperationComplication)
                {
                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    cell1.Attributes.Add("align", "left");
                    cell1.Text = "<li type=a>" + oOperationComplication.ComplicationName;
                    row1.Cells.Add(cell1);
                    row1.Style.Add("color", "#000");
                    tblOperationComplication.Rows.Add(row1);

                }
            }



        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
       
        try
        {
            if (Request.QueryString["page"] == "Visit")
            {
                Response.Redirect("../Physician/OperationNotes.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&oid=" + hdnOPID.Value + "&page=" + "Visit", true);

            }

            else
            {
                Response.Redirect("../Physician/OperationNotes.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&oid=" + OperationID + "&page=" + "OPN", true);

            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Displaying DischargeSummary  page", ex);
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


    protected void gvTreatment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                IPTreatmentPlan o = (IPTreatmentPlan)e.Row.DataItem;
                string strScript = "SelectOperationID('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + o.OperationID + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

                Label lblFromTime = (Label)e.Row.FindControl("lblFromTime");

                if (lblFromTime.Text == DateTime.MinValue.ToString())
                {
                    lblFromTime.Text = "-";
                }

                

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Displaying DischargeSummary Case Sheet  page", ex);
        }

    }
    protected void btnViewOperationNotes_Click(object sender, EventArgs e)
    {
        if (Request.Form["OPid"] != null && Request.Form["OPid"].ToString() != "")
        {
            hdnOPID.Value = Request.Form["OPid"];

            pGetOperationNotesCaseSheet();

            tblDischrageResult.Style.Add("display", "block");
            tblSave.Style.Add("display", "block");
        }
    }
    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        try
        {
         
            Response.Redirect("../Physician/OperationNotes.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&oid=" + 0 + "&page=" + "Visit", true);
         
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Displaying DischargeSummary  page", ex);
        }
    }
}
