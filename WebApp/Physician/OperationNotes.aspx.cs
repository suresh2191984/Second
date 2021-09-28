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

public partial class Physician_OperationNotes : BasePage
{
    public Physician_OperationNotes()
        : base("Physician\\OperationNotes.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    #region Decleration
    long patientVisitID = -1;
    long patientID = -1;
    long returnCode = -1;
    long OperationID = -1;
    string RdoValue = string.Empty;

    List<IPTreatmentPlanMaster> lstIPTreatmentPlanMaster = new List<IPTreatmentPlanMaster>();
    List<IPTreatmentPlan> lstIPTreatmentPlan = new List<IPTreatmentPlan>();
    List<Patient> lstPatient = new List<Patient>();

    List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
    List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
    List<SurgeryType> lstSurgeryType = new List<SurgeryType>();
    List<OperationType> lstOperationType = new List<OperationType>();
    List<AnesthesiaType> lstAnesthesiaType = new List<AnesthesiaType>();
    List<Physician> lstChiefOperater = new List<Physician>();
    //List<AHPStaff> lstAnesthisa = new List<AHPStaff>();
    List<Physician> lstAnesthisa = new List<Physician>();
    List<AHPStaff> lstTechnicianName = new List<AHPStaff>();
    List<Nurse> lstNurseName = new List<Nurse>();

    List<OperationNotes> lstOperationNotes = new List<OperationNotes>();
    List<OperationFinding> lstOperationFinding = new List<OperationFinding>();
    List<OperationComplication> lstOperationComplication = new List<OperationComplication>();
    List<OperationStaff> lstOperationStaff = new List<OperationStaff>();

    List<Physician> lstChiefPhysicianOperationStaff = new List<Physician>();
    List<Physician> lstAssistantPhysicianOperationStaff = new List<Physician>();
    //List<AHPStaff> lstAnesthisiaOperationStaff = new List<AHPStaff>();
    List<Physician> lstAnesthisiaOperationStaff = new List<Physician>();
    List<AHPStaff> lstTechnicianOperationStaff = new List<AHPStaff>();
    List<Nurse> lstNurseOperationStaff = new List<Nurse>();
    List<IPTreatmentPlan> lstIPTreatmentPlanByOperationID = new List<IPTreatmentPlan>();
    List<IPTreatmentPlan> lstIPTreatmentPlanFromCaserecord = new List<IPTreatmentPlan>();
    List<IPTreatmentPlan> lstIPTreatmentPlanAndPerformed = new List<IPTreatmentPlan>();
    List<IPTreatmentPlan> lst = new List<IPTreatmentPlan>();
    List<IPTreatmentPlanDetails> lstIPTreatmentPlanDetails = new List<IPTreatmentPlanDetails>();


    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();

    IP_BL ipBL;

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        ipBL = new IP_BL(base.ContextInfo);
        try
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["oid"], out OperationID);

            patientHeader.PatientID = patientID;
            patientHeader.PatientVisitID = patientVisitID;
            patientHeader.ShowVitalsDetails();
            ComplaintICDCode1.ComplaintHeader = "Complication";

            if (!IsPostBack)
            {
                ComplaintICDCode1.ComplaintHeader = "Complication";
                ComplaintICDCode1.SetWidth(500);
                LoadIPTreatmentPlanMaster();
                // LoadIPTreatmentPlanChild();
                LoadAllIPTreatmentPlanChild();
                GetPatientVitalsAndComplaint();
                if (ddlAddEdit.SelectedValue == "1" && OperationID == 0)
                {
                    GetOperationNotes();
                    //tblOperationNotes.Visible = true;
                    tblOperationNotes.Style.Add("display", "block");
                    //tblTreatment.Visible = false;
                    tblTreatment.Style.Add("display", "none");
                }
                else
                {
                    if (OperationID > 0)
                    {
                        tblSelectOption.Visible = false;
                        GetOperationNotes();
                        tblSelectOption.Style.Add("display", "none");
                        GetOperationNotesForUpdate();
                        tblTreatment.Style.Add("display", "none");
                       // GetPatientVitalsAndComplaint();
                        tblOperationNotes.Style.Add("display", "block");
                    }
                }

                #region Investigation
                //List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
                //List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
                //new Investigation_BL(base.ContextInfo).GetInvestigationData(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), out lstgroups, out lstInvestigations);

                //int orgBased = OrgID;
                //InvestigationControl1.OrgSpecific = orgBased;
                //InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);
                #endregion
            }

        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in OperationNotes.aspx:Page_Load", ex);
        }

    }

    public void GetPatientVitalsAndComplaint()
    {
        try
        {
            returnCode = -1;
            returnCode = ipBL.GetPatientVitalsAndComplaint(patientVisitID, OrgID, out lstVitalsUOMJoin, out lstPatientComplaint);
            if (lstVitalsUOMJoin.Count > 0)
            {
                LoadPatientvitals();
            }
            if (lstPatientComplaint.Count > 0)
            {
                LoadPatientComplaint();
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error while loading Operation Notes in OperationNotes.aspx", ex);
        }
    }

    public void GetOperationNotesForUpdate()
    {
        try
        {
            // Int64.TryParse(RdoValue, out OperationID);
            if (Session["OperationID"] != null)
            {
                string tempOperationID = Session["OperationID"].ToString();
                Int64.TryParse(tempOperationID, out OperationID);
            }
           
            returnCode = ipBL.GetOperationNotesForUpdate(patientVisitID, OrgID, OperationID, out lstOperationNotes, out lstOperationFinding, out lstOperationComplication, out lstChiefPhysicianOperationStaff, out lstAssistantPhysicianOperationStaff, out lstAnesthisiaOperationStaff, out lstTechnicianOperationStaff, out lstNurseOperationStaff, out lstIPTreatmentPlanByOperationID);

            if (lstOperationNotes.Count > 0)
            {
                ddlAnesthesiaType.SelectedValue = lstOperationNotes[0].AnesthesiaTypeID.ToString();
                ddlSurgeryType.SelectedValue = lstOperationNotes[0].SurgeryTypeID.ToString();
                ddlOperationType.SelectedValue = lstOperationNotes[0].OperationTypeID.ToString();
                txtFromTime.Text = lstOperationNotes[0].FromTime.ToString();
                txtToTime.Text = lstOperationNotes[0].ToTime.ToString();

            }

            if (lstOperationFinding.Count > 0)
            {

                foreach (OperationFinding objOperationFinding in lstOperationFinding)
                {
                    if (objOperationFinding.Type == "PreOPF")
                    {
                        txtPreOPF.Text = objOperationFinding.OperationFindings;

                    }
                    if (objOperationFinding.Type == "OPT")
                    {
                        txtOPT.Text = objOperationFinding.OperationFindings;

                    }
                    if (objOperationFinding.Type == "OPF")
                    {
                        txtOPF.Text = objOperationFinding.OperationFindings;

                    }
                    if (objOperationFinding.Type == "PostOPF")
                    {
                        txtPostOPF.Text = objOperationFinding.OperationFindings;
                    }
                }
            }

            if (lstOperationComplication.Count > 0)
            {


                ComplaintICDCode1.SetOperationComplication(lstOperationComplication);

                //int i = 220;
                //foreach (OperationComplication objCM in lstOperationComplication)
                //{


                //    hdnDiagnosisItems.Value += i + "~" + objCM.ComplicationName + "^";
                //    i += 1;
                //}

            }

            if (lstChiefPhysicianOperationStaff.Count > 0)
            {
                ddlChiefOperator.SelectedValue = lstChiefPhysicianOperationStaff[0].PhysicianID.ToString();
            }
            if (lstAssistantPhysicianOperationStaff.Count > 0)
            {
                int i = 220;
                foreach (Physician objPhysician in lstAssistantPhysicianOperationStaff)
                {
                    iconHidAssistant.Value += i + "~" + objPhysician.PhysicianID + "~" + objPhysician.PhysicianName + "^";
                    i++;
                }

            }

            if (lstAnesthisiaOperationStaff.Count > 0)
            {
                int i = 420;
                foreach (Physician objAnesthisia in lstAnesthisiaOperationStaff)
                {
                    iconHidAnesthetist.Value += i + "~" + objAnesthisia.PhysicianID + "~" + objAnesthisia.PhysicianName + "^";

                } i++;

            }

            if (lstTechnicianOperationStaff.Count > 0)
            {
                int i = 520;
                foreach (AHPStaff objAHPStaff in lstTechnicianOperationStaff)
                {
                    iconHidTechnician.Value += i + "~" + objAHPStaff.AHPStaffID + "~" + objAHPStaff.StaffName + "^";
                    i++;
                }

            }


            if (lstNurseOperationStaff.Count > 0)
            {
                int i = 620;
                foreach (Nurse objNurse in lstNurseOperationStaff)
                {
                    iconHidNurse.Value += i + "~" + objNurse.NurseID + "~" + objNurse.NurseName + "^";
                    i++;
                }

            }
            if (lstIPTreatmentPlanByOperationID.Count > 0)
            {
                int i = 1;
                foreach (IPTreatmentPlan objIPTP in lstIPTreatmentPlanByOperationID)
                {
                    hdnIPTreatmentPlanItems.Value += i + "~" + objIPTP.ParentID + "~" + objIPTP.TreatmentPlanID + "~" + objIPTP.ParentName + "~" + objIPTP.IPTreatmentPlanName + "~" + objIPTP.Prosthesis + "^";
                    i += 1;
                }
            }

        }
        catch (Exception ex)
        {

            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in OperationNotes.aspx:Page_Load", ex);
        }


    }

    public void GetOperationNotes()
    {

        try
        {

            returnCode = ipBL.GetOperationNotes(patientVisitID, OrgID, out lstSurgeryType, out lstOperationType, out lstAnesthesiaType, out lstChiefOperater, out lstAnesthisa, out lstTechnicianName, out lstNurseName, out lstIPTreatmentPlan, out lstPatient, out lstIPTreatmentPlanFromCaserecord, out lstIPTreatmentPlanDetails);
            if (returnCode == 0)
            {

                if (lstSurgeryType.Count > 0)
                {
                    LoadSurgeryType();
                }
                if (lstOperationType.Count > 0)
                {
                    LoadOperationType();
                }

                if (lstAnesthesiaType.Count > 0)
                {
                    LoadAnesthisiatype();
                }
                if (lstChiefOperater.Count > 0)
                {
                    LoadChiefOperator();
                    LoadAssistentOperator();
                }

                if (lstAnesthisa.Count > 0)
                {
                    LoadAnesthisia();
                }

                if (lstTechnicianName.Count > 0)
                {
                    LoadTechnician();
                }
                if (lstNurseName.Count > 0)
                {
                    LoadNurse();
                }

                if (lstPatient.Count > 0)
                {
                    foreach (var patientItem in lstPatient)
                    {
                        if (patientItem.BloodGroup == "-1")
                        {
                            string lblblood = Resources.ClientSideDisplayTexts.Physician_OperationNotes_aspx_cs_blood;
                            lblBloodgroup.Text = lblblood;

                        }
                        else
                        {
                            lblBloodgroup.Text = patientItem.BloodGroup;
                        }

                    }
                }

                if (ddlAddEdit.SelectedValue != "1")
                {
                  
                    if (lstIPTreatmentPlan.Count > 0)
                    {
                        int i = 1;
                        foreach (IPTreatmentPlan objIPTP in lstIPTreatmentPlan)
                        {
                            hdnIPTreatmentPlanItems.Value += i + "~" + objIPTP.ParentID + "~" + objIPTP.TreatmentPlanID + "~" + objIPTP.ParentName + "~" + objIPTP.IPTreatmentPlanName + "~" + objIPTP.Prosthesis + "^";
                            i += 1;
                        }
                    }
                }


                //if (lstIPTreatmentPlanFromCaserecord.Count > 0)
                //{
                //    string pTreatmentPlanDate;
                
                //    foreach (IPTreatmentPlan objIPTP in lstIPTreatmentPlanFromCaserecord)
                //    {
                //        if (objIPTP.TreatmentPlanDate == DateTime.MinValue)
                //        {
                //            pTreatmentPlanDate = "Will be scheduled later";
                //        }
                //        else
                //        {
                //            pTreatmentPlanDate = objIPTP.TreatmentPlanDate.ToString();
                //        }
                //        hdnIPCaseRecordPlan.Value +=  objIPTP.ParentID + "~" + objIPTP.IPTreatmentPlanID + "~" + objIPTP.ParentName + "~" + objIPTP.IPTreatmentPlanName + "~" + objIPTP.Prosthesis + "~" + pTreatmentPlanDate + "~" + objIPTP.Status + "^";
                       
                //    }
                //}


                 if (lstIPTreatmentPlanFromCaserecord.Count > 0)
                {
                    grdCRCplan.DataSource = lstIPTreatmentPlanFromCaserecord;
                    grdCRCplan.DataBind();
                }


                
               


            }
        }
        catch (Exception ex)
        {


            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in OperationNotes.aspx:Page_Load", ex);
        }


    }

    private void LoadNurse()
    {
        try
        {
            lsNurse.DataSource = lstNurseName;
            lsNurse.DataTextField = "NurseName";
            lsNurse.DataValueField = "NurseID";
            lsNurse.DataBind();
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in OperationNotes.aspx:Page_Load", ex);
        }

    }

    private void LoadTechnician()
    {
        try
        {
            lsTechnician.DataSource = lstTechnicianName;
            lsTechnician.DataTextField = "StaffName";
            lsTechnician.DataValueField = "AHPStaffID";
            lsTechnician.DataBind();
        }
        catch (Exception ex)
        {

            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in OperationNotes.aspx:Page_Load", ex);
        }

    }

    private void LoadAnesthisia()
    {
        lsAnesthetist.DataSource = lstAnesthisa;
        lsAnesthetist.DataTextField = "PhysicianName";
        lsAnesthetist.DataValueField = "PhysicianID";
        lsAnesthetist.DataBind();
    }

    private void LoadAssistentOperator()
    {
        lsAssistingOperator.DataSource = lstChiefOperater;
        lsAssistingOperator.DataTextField = "PhysicianName";
        lsAssistingOperator.DataValueField = "PhysicianID";
        lsAssistingOperator.DataBind();

    }

    private void LoadChiefOperator()
    {
        ddlChiefOperator.DataSource = lstChiefOperater;
        ddlChiefOperator.DataTextField = "PhysicianName";
        ddlChiefOperator.DataValueField = "PhysicianID";
        ddlChiefOperator.DataBind();
        ddlChiefOperator.Items.Insert(0, "-----Select-----");
       ddlChiefOperator.Items[0].Value = "0";
    }

    private void LoadAnesthisiatype()
    {
        ddlAnesthesiaType.DataSource = lstAnesthesiaType;
        ddlAnesthesiaType.DataTextField = "TypeName";
        ddlAnesthesiaType.DataValueField = "AnesthesiaTypeID";
        ddlAnesthesiaType.DataBind();
        //ddlAnesthesiaType.Items.Insert(0, "-----Select-----");
        //ddlAnesthesiaType.Items[0].Value = "0";
    }

    private void LoadOperationType()
    {
        ddlOperationType.DataSource = lstOperationType;
        ddlOperationType.DataTextField = "TypeName";
        ddlOperationType.DataValueField = "OperationTypeID";
        ddlOperationType.DataBind();
        //ddlOperationType.Items.Insert(0, "-----Select-----");
        //ddlOperationType.Items[0].Value = "0";
    }

    private void LoadSurgeryType()
    {
        ddlSurgeryType.DataSource = lstSurgeryType;
        ddlSurgeryType.DataTextField = "TypeName";
        ddlSurgeryType.DataValueField = "SurgeryTypeID";
        ddlSurgeryType.DataBind();
        //ddlSurgeryType.Items.Insert(0, "-----Select-----");
        //ddlSurgeryType.Items[0].Value = "0";
    }

    private void LoadPatientComplaint()
    {
        foreach (var oPatientComplaint in lstPatientComplaint)
        {

            TableRow row1 = new TableRow();
            TableCell cell1 = new TableCell();
            cell1.Attributes.Add("align", "left");
            cell1.Text = oPatientComplaint.ComplaintName;
            row1.Cells.Add(cell1);
            row1.Style.Add("color", "#000");
            tblDiagnosis.Rows.Add(row1);


        }
    }

    private void LoadPatientvitals()
    {
        string Vitalsname = string.Empty;
        string Vitalsvalue = string.Empty;
        string Vitalsunit = string.Empty;

        foreach (var oVitalsUOMJoin in lstVitalsUOMJoin)
        {
            if (Vitalsname == string.Empty)
            {
                Vitalsname = oVitalsUOMJoin.VitalsName;
            }
            else
            {
                Vitalsname += "," + oVitalsUOMJoin.VitalsName;
            }
            if (Vitalsvalue == string.Empty)
            {
                Vitalsvalue = oVitalsUOMJoin.VitalsValue.ToString();
            }
            else
            {
                Vitalsvalue += "," + oVitalsUOMJoin.VitalsValue.ToString();
            }
            if (Vitalsunit == string.Empty)
            {
                Vitalsunit = oVitalsUOMJoin.UOMCode;
            }
            else
            {
                Vitalsunit += "," + oVitalsUOMJoin.UOMCode;
            }
        }

        string[] resVitalsname = Vitalsname.Split(',');
        string[] resVitalsvalue = Vitalsvalue.Split(',');
        string[] resVitalsunit = Vitalsunit.Split(',');

        TableRow rowH = new TableRow();
        TableCell cellH1 = new TableCell();
        TableCell cellH2 = new TableCell();
        TableCell cellH3 = new TableCell();
        TableCell cellH4 = new TableCell();
        TableCell cellH5 = new TableCell();
        TableCell cellH6 = new TableCell();
        TableCell cellH7 = new TableCell();
        TableCell cellH8 = new TableCell();
        cellH1.Attributes.Add("align", "left");
        cellH1.Text = resVitalsname[0];
        cellH2.Attributes.Add("align", "left");
        cellH2.Text = resVitalsname[1];
        cellH3.Attributes.Add("align", "left");
        cellH3.Text = resVitalsname[2];
        cellH4.Attributes.Add("align", "left");
        cellH4.Text = resVitalsname[3];
        cellH5.Attributes.Add("align", "left");
        cellH5.Text = resVitalsname[4];
        cellH6.Attributes.Add("align", "left");
        cellH6.Text = resVitalsname[5];
        cellH7.Attributes.Add("align", "left");
        cellH7.Text = resVitalsname[6];
        cellH8.Attributes.Add("align", "left");
        cellH8.Text = resVitalsname[7];
        rowH.Cells.Add(cellH1);
        rowH.Cells.Add(cellH2);
        rowH.Cells.Add(cellH3);
        rowH.Cells.Add(cellH4);
        rowH.Cells.Add(cellH5);
        rowH.Cells.Add(cellH6);
        rowH.Cells.Add(cellH7);
        rowH.Cells.Add(cellH8);
        rowH.Font.Bold = true;
        rowH.Style.Add("color", "#000");
        tblVitals.Rows.Add(rowH);


        TableRow row1 = new TableRow();
        TableCell cell1 = new TableCell();
        TableCell cell2 = new TableCell();
        TableCell cell3 = new TableCell();
        TableCell cell4 = new TableCell();
        TableCell cell5 = new TableCell();
        TableCell cell6 = new TableCell();
        TableCell cell7 = new TableCell();
        TableCell cell8 = new TableCell();
        if (resVitalsvalue[0] != "0.00")
        {
            cell1.Attributes.Add("align", "left");
            cell1.Text = resVitalsvalue[0] + " " + resVitalsunit[0];
        }
        else
        {
            cell1.Text = "-";
        }
        if (resVitalsvalue[1] != "0.00")
        {
            cell2.Attributes.Add("align", "left");
            string SBP = resVitalsvalue[1];
            string[] resSBP = SBP.Split('.');
            cell2.Text = resSBP[0] + " " + resVitalsunit[1];
        }
        else
        {
            cell2.Text = "-";
        }
        if (resVitalsvalue[2] != "0.00")
        {
            cell3.Attributes.Add("align", "left");
            string DBP = resVitalsvalue[2];
            string[] resDBP = DBP.Split('.');
            cell3.Text = resDBP[0] + " " + resVitalsunit[2];
        }
        else
        {
            cell3.Text = "-";
        }
        if (resVitalsvalue[3] != "0.00")
        {
            cell4.Attributes.Add("align", "left");
            string Pulse = resVitalsvalue[3];
            string[] resPulse = Pulse.Split('.');
            cell4.Text = resPulse[0] + " " + resVitalsunit[3];
        }
        else
        {
            cell4.Text = "-";
        }

        if (resVitalsvalue[4] != "0.00")
        {
            cell5.Attributes.Add("align", "left");
            cell5.Text = resVitalsvalue[4] + " " + resVitalsunit[4];
        }
        else
        {
            cell5.Text = "-";
        }
        if (resVitalsvalue[5] != "0.00")
        {
            cell6.Attributes.Add("align", "left");
            cell6.Text = resVitalsvalue[5] + " " + resVitalsunit[5];
        }
        else
        {
            cell6.Text = "-";
        }

        if (resVitalsvalue[6] != "0.00")
        {
            cell7.Attributes.Add("align", "left");
            cell7.Text = resVitalsvalue[6] + " " + resVitalsunit[6];
        }
        else
        {
            cell7.Text = "-";
        }

        if (resVitalsvalue[7] != "0.00")
        {
            cell8.Attributes.Add("align", "left");
            string RR = resVitalsvalue[7];
            string[] resRR = RR.Split('.');
            cell8.Text = resRR[0] + " " + resVitalsunit[7];
        }
        else
        {
            cell8.Text = "-";
        }

        row1.Cells.Add(cell1);
        row1.Cells.Add(cell2);
        row1.Cells.Add(cell3);
        row1.Cells.Add(cell4);
        row1.Cells.Add(cell5);
        row1.Cells.Add(cell6);
        row1.Cells.Add(cell7);
        row1.Cells.Add(cell8);
        row1.Style.Add("color", "#000");
        tblVitals.Rows.Add(row1);





    }


    protected void LoadIPTreatmentPlanMaster()
    {
        try
        {
            ipBL.GetIPTreatmentPlanMaster(OrgID, out lstIPTreatmentPlanMaster);
            var list = from IPTreatment in lstIPTreatmentPlanMaster
                       where IPTreatment.IPTreatmentPlanParentID == 0
                       select IPTreatment;
            if (list.Count() > 0)
            {
                ddlIPTreatmentPlanMaster.DataSource = lstIPTreatmentPlanMaster;
                ddlIPTreatmentPlanMaster.DataTextField = "IPTreatmentPlanName";
                ddlIPTreatmentPlanMaster.DataValueField = "TreatmentPlanID";
                ddlIPTreatmentPlanMaster.DataBind();
                ddlIPTreatmentPlanMaster.Items.Insert(lstIPTreatmentPlanMaster.Count, "Medical");
                ddlIPTreatmentPlanMaster.Items[lstIPTreatmentPlanMaster.Count].Value = "0";
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error while loading IPTreatmentPlan in Operation Notes.aspx", ex);
        }
    }


    public void LoadAllIPTreatmentPlanChild()
    {
        try
        {
            List<IPTreatmentPlanMaster> lstAllIPTreatmentPlanChild = new List<IPTreatmentPlanMaster>();

            ipBL.GetAllIPTreatmentPlanChild(OrgID, out lstAllIPTreatmentPlanChild);

            string Surgery = 0 + "~" + "Others" + "~" + 1 + "^";
            string Interventional = 0 + "~" + "Others" + "~" + 2 + "^";

            if (lstAllIPTreatmentPlanChild.Count > 0)
            {
                foreach (IPTreatmentPlanMaster objIPTreatmentPlanMaster in lstAllIPTreatmentPlanChild)
                {
                    hdnIPTreatmentPlanChild.Value += objIPTreatmentPlanMaster.TreatmentPlanID + "~" + objIPTreatmentPlanMaster.IPTreatmentPlanName + "~" + objIPTreatmentPlanMaster.IPTreatmentPlanParentID + "^";

                }
                hdnIPTreatmentPlanChild.Value += Surgery + Interventional;
            }

        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error while loading IPTreatmentPlan in opeartion Notes.aspx", ex);
        }
    }


    //public void LoadIPTreatmentPlanChild()
    //{
    //    try
    //    {
    //        List<IPTreatmentPlanMaster> lstIPTreatmentPlanChild = new List<IPTreatmentPlanMaster>();
    //        string SearchText = txtSerachText.Text;
    //        ipBL.GetAllIPTreatmentPlanChild(OrgID,SearchText out lstIPTreatmentPlanChild);
    //        grdIPTreatmentChild.DataSource=lstIPTreatmentPlanChild;
    //        grdIPTreatmentChild.DataBind();

    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorDisplay1.ShowError = true;
    //        ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
    //        CLogger.LogError("Error while loading IPTreatmentPlan in opeartion Notes.aspx", ex);
    //    }
    //}


    protected void ddlIPTreatmentPlanMaster_SelectedIndexChanged(object sender, EventArgs e)
    {
        //LoadIPTreatmentPlanChild();

        GetPatientVitalsAndComplaint();
    }


    protected void btnFinish_Click(object sender, EventArgs e)
    {

        int mode = 0;
        if (ddlAddEdit.SelectedValue == "1" && OperationID==0)
        {
            mode = Convert.ToInt32(ddlAddEdit.SelectedValue);
        }
        else
        {
            if (Session["OperationID"] != null)
            {
                string tempOperationID = Session["OperationID"].ToString();
                Int64.TryParse(tempOperationID, out OperationID);
                mode = 2;
                Session.Remove("OperationID");
            }
             
        }

        try
        {
            OperationNotes objOperationNotes = new OperationNotes();

            if (txtFromTime.Text != string.Empty)
            {
                objOperationNotes.FromTime = Convert.ToDateTime(txtFromTime.Text);
            }
            if (txtToTime.Text != string.Empty)
            {
                objOperationNotes.ToTime = Convert.ToDateTime(txtToTime.Text);
            }

            objOperationNotes.SurgeryTypeID = Convert.ToInt32(ddlSurgeryType.SelectedValue);
            objOperationNotes.AnesthesiaTypeID = Convert.ToInt32(ddlAnesthesiaType.SelectedValue);
            objOperationNotes.OperationTypeID = Convert.ToInt32(ddlOperationType.SelectedValue);
            objOperationNotes.OrgID = OrgID;
            objOperationNotes.CreatedBy = LID;
            objOperationNotes.PatientID = patientID;
            objOperationNotes.PatientVistID = patientVisitID;

            lstOperationNotes.Add(objOperationNotes);

            lstOperationStaff = GetOperationStaff();

            lstOperationFinding = GetOperationFinding();

           // lstOperationComplication = GetOperationComplication();

            lstOperationComplication = ComplaintICDCode1.GetOperationComplication();

            GetIPPlannedAndPerformedTreatment();

            lstIPTreatmentPlan = GetIPTreatmentPlan();

            lstIPTreatmentPlanAndPerformed = GetIPTreatmentPlanAndPerformed();

            #region Investigation
            //List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            //lstPatientInvestigation = InvestigationControl1.GetOrderedList();

            //long returnCodeINV = -1;
            //long createTaskID = -1;
            //Hashtable dText = new Hashtable();
            //Hashtable urlVal = new Hashtable();
            //Tasks task = new Tasks();
            //Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            //List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();
            //if (lstPatientInvestigation.Count > 0)
            //{

            //    foreach (PatientInvestigation inves in lstPatientInvestigation)
            //    {
            //        PatientInvestigation objInvest = new PatientInvestigation();
            //        OperationInvestigation objOperationInvestigation = new OperationInvestigation();
            //        objOperationInvestigation.InvestigationID =Convert.ToInt32(inves.InvestigationID);
            //        objInvest.InvestigationID = inves.InvestigationID;
            //        objInvest.InvestigationName = inves.InvestigationName;
            //        objInvest.PatientVisitID = patientVisitID;
            //        objInvest.GroupID = inves.GroupID;
            //        objInvest.GroupName = inves.GroupName;
            //        objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            //        objInvest.Status = "Paid";
            //        objInvest.CreatedBy = LID;
            //        objInvest.Type = inves.Type;
            //        orderedInves.Add(objInvest);
            //        lstOperationInvestigation.Add(objOperationInvestigation);
            //    }
            //}
            //int pOrderedInvCnt = 0;

            //returnCodeINV = new Investigation_BL(base.ContextInfo).SaveInPatientInvestigation(orderedInves, OrgID, out pOrderedInvCnt);
            //if (pOrderedInvCnt > 0)
            //{
            //    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            //    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
            //    returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), patientVisitID, 0,
            //       patientVisitID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0);
            //    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            //    task.DispTextFiller = dText;
            //    task.URLFiller = urlVal;
            //    task.RoleID = RoleID;
            //    task.OrgID = OrgID;
            //    task.PatientVisitID = patientVisitID;
            //    task.PatientID = patientID;
            //    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            //    task.CreatedBy = LID;
            //    //Create task               
            //    returnCodeINV = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
            //}
            //end ordered investigation
            #endregion


            returnCode = ipBL.SaveOperationNotes(patientID, patientVisitID, OrgID, mode, OperationID, lstOperationNotes, lstOperationStaff, lstOperationFinding, lstOperationComplication, lstIPTreatmentPlan, lstIPTreatmentPlanAndPerformed);

            if (lstOperationComplication.Count > 0)
            {
                Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
                objPatient_BL.UpdatePatientICDStatus(patientVisitID);
            }
            
            if (returnCode != 0)
            {
                try
                {
                    if (Request.QueryString["page"] == "Visit")
                    {
                        OperationID = returnCode;
                        Response.Redirect("../Physician/OperationNotesCaseSheet.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&oid=" + OperationID + "&page=" + "Visit", true);
                    }
                    else
                    {
                        OperationID = returnCode;
                        Response.Redirect("../Physician/OperationNotesCaseSheet.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&oid=" + OperationID + "&page=" + "OPN", true);
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
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string strTae = tae.ToString();
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in Saving Operation Notes Please contact system administrator";
            CLogger.LogError("Error while Saving Operation Notes in OperationNotes.aspx", ex);
        }
        
    }

    #region OperationInvestigation
    //private List<OperationInvestigation> GetOrderedInvestigation()
    //{
    //    List<OperationComplication> lstOperationComplicationTemp = new List<OperationComplication>();
    //    foreach (string listComplication in hdnDiagnosisItems.Value.Split('^'))
    //    {
    //        if (listComplication != "")
    //        {
    //            OperationComplication objOperationComplication = new OperationComplication();
    //            string[] listChildDiagnosis = listComplication.Split('~');
    //            objOperationComplication.ComplicationName = listChildDiagnosis[1];
    //            objOperationComplication.CreatedBy = LID;
    //            //objOperationComplication.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    //            //objOperationComplication.PatientVisitID = patientVisitID;
    //            lstOperationComplicationTemp.Add(objOperationComplication);
    //        }
    //    }
    //    return lstOperationComplicationTemp;
    //}

    #endregion

    private List<OperationStaff> GetOperationStaff()
    {
        List<OperationStaff> lstOperationStaffTemp = new List<OperationStaff>();

        if (Convert.ToInt32(ddlChiefOperator.SelectedValue) != 0)
        {
            OperationStaff objOperationStaff = new OperationStaff();
            objOperationStaff.StaffID = Convert.ToInt32(ddlChiefOperator.SelectedValue);
            objOperationStaff.CreatedBy = LID;
            objOperationStaff.StaffType = "Chief";
            //objOperationStaff.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            lstOperationStaffTemp.Add(objOperationStaff);
        }
        foreach (string listAssistingPhysican in iconHidAssistant.Value.Split('^'))
        {
            if (listAssistingPhysican != "")
            {

                OperationStaff objOperationStaff = new OperationStaff();
                string[] listChildAssistingPhysican = listAssistingPhysican.Split('~');
                objOperationStaff.StaffID = Convert.ToInt32(listChildAssistingPhysican[1]);
                objOperationStaff.CreatedBy = LID;
                objOperationStaff.StaffType = "Phy";
                //objOperationStaff.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                lstOperationStaffTemp.Add(objOperationStaff);
            }
        }
        foreach (string listTechnician in iconHidTechnician.Value.Split('^'))
        {
            if (listTechnician != "")
            {
                OperationStaff objOperationStaff = new OperationStaff();
                string[] listChildTechnician = listTechnician.Split('~');
                objOperationStaff.StaffID = Convert.ToInt32(listChildTechnician[1]);
                objOperationStaff.CreatedBy = LID;
                objOperationStaff.StaffType = "Tech";
                //objOperationStaff.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                lstOperationStaffTemp.Add(objOperationStaff);
            }
        }
        foreach (string listAnesthetist in iconHidAnesthetist.Value.Split('^'))
        {
            if (listAnesthetist != "")
            {
                OperationStaff objOperationStaff = new OperationStaff();
                string[] listChildAnesthetist = listAnesthetist.Split('~');
                objOperationStaff.StaffID = Convert.ToInt32(listChildAnesthetist[1]);
                objOperationStaff.CreatedBy = LID;
                objOperationStaff.StaffType = "Anesthetist";
                lstOperationStaffTemp.Add(objOperationStaff);
            }
        }

        foreach (string listNurse in iconHidNurse.Value.Split('^'))
        {
            if (listNurse != "")
            {
                OperationStaff objOperationStaff = new OperationStaff();
                string[] listChildNurse = listNurse.Split('~');
                objOperationStaff.StaffID = Convert.ToInt32(listChildNurse[1]);
                objOperationStaff.CreatedBy = LID;
                objOperationStaff.StaffType = "Nurse";
                //objOperationStaff.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                lstOperationStaffTemp.Add(objOperationStaff);
            }
        }
        return lstOperationStaffTemp;
    }


    public void GetIPPlannedAndPerformedTreatment()
    {
        hdnIPCaseRecordPlan.Value = "";
        hdnPerformed.Value = "";
        int i = 25;
        foreach (GridViewRow gr in grdCRCplan.Rows)
        {
            Label lblParentID = (Label)gr.FindControl("lblParentName");
            Label lblIPTreatmentPlanID = (Label)gr.FindControl("lblIPTreatmentPlanID");
            Label lblStatus = (Label)gr.FindControl("lblStatus");
            Label lblParentName = (Label)gr.FindControl("lblParentName");
            Label lblIPTreatmentPlanName = (Label)gr.FindControl("lblIPTreatmentPlanName");
            Label lblProsthesis = (Label)gr.FindControl("lblProsthesis");
            Label lblTreatmentPlanDate = (Label)gr.FindControl("lblTreatmentPlanDate");
            CheckBox chkSelect = (CheckBox)gr.FindControl("chkSelect");
            string Status = string.Empty;

            if (chkSelect.Checked == true)
            {
                Status = "Performed";
                hdnPerformed.Value += i + "~" + lblParentID.Text + "~" + lblIPTreatmentPlanID.Text + "~" + lblParentName.Text + "~" + lblIPTreatmentPlanName.Text + "~" + lblProsthesis.Text + "^";              
                i += 1;
            }
            else
            {
                Status = "Planned";
            }
            hdnIPCaseRecordPlan.Value += lblParentID.Text + "~" + lblIPTreatmentPlanID.Text + "~" + lblParentName.Text + "~" + lblIPTreatmentPlanName.Text + "~" + lblProsthesis.Text + "~" + lblTreatmentPlanDate.Text + "~" + Status + "^";
            
        }
    }

    public List<IPTreatmentPlan> GetIPTreatmentPlanAndPerformed()
    {

        List<IPTreatmentPlan> lstIPTreatmentPlanAndPerformedTemp = new List<IPTreatmentPlan>();

        foreach (string listParentTreatmentPlan in hdnIPCaseRecordPlan.Value.Split('^'))
        {
            if (listParentTreatmentPlan != "")
            {
                IPTreatmentPlan objIPTreatmentPlan = new IPTreatmentPlan();
                string[] listChildTreatmentPlan = listParentTreatmentPlan.Split('~');


                objIPTreatmentPlan.PatientID = patientID;
                objIPTreatmentPlan.PatientVisitID = patientVisitID;
                objIPTreatmentPlan.TreatmentPlanID = Convert.ToInt32(listChildTreatmentPlan[1]);
                objIPTreatmentPlan.IPTreatmentPlanName = listChildTreatmentPlan[3];
                objIPTreatmentPlan.Prosthesis = listChildTreatmentPlan[4];
                objIPTreatmentPlan.ParentID = Convert.ToInt32(listChildTreatmentPlan[0]);
                objIPTreatmentPlan.ParentName = listChildTreatmentPlan[2];
                if (listChildTreatmentPlan[5] != "Will be scheduled later")
                {
                    objIPTreatmentPlan.TreatmentPlanDate = Convert.ToDateTime(listChildTreatmentPlan[5]);
                }
                objIPTreatmentPlan.Status = listChildTreatmentPlan[6];
                objIPTreatmentPlan.OrgID = OrgID;
                objIPTreatmentPlan.CreatedBy = LID;
                objIPTreatmentPlan.StagePlanned = "CRC";
                lstIPTreatmentPlanAndPerformedTemp.Add(objIPTreatmentPlan);
               
            }
        }
        return lstIPTreatmentPlanAndPerformedTemp;
    }

    public List<IPTreatmentPlan> GetIPTreatmentPlan()
    {

        List<IPTreatmentPlan> lstIPTreatmentPlanTemp = new List<IPTreatmentPlan>();
        hdnIPTreatmentPlanItems.Value += hdnPerformed.Value;
        foreach (string listParentTreatmentPlan in hdnIPTreatmentPlanItems.Value.Split('^'))
        {
            if (listParentTreatmentPlan != "")
            {
                IPTreatmentPlan objIPTreatmentPlan = new IPTreatmentPlan();
                string[] listChildTreatmentPlan = listParentTreatmentPlan.Split('~');


                objIPTreatmentPlan.PatientID = patientID;
                objIPTreatmentPlan.PatientVisitID = patientVisitID;
                objIPTreatmentPlan.TreatmentPlanID = Convert.ToInt32(listChildTreatmentPlan[2]);
                objIPTreatmentPlan.IPTreatmentPlanName = listChildTreatmentPlan[4];
                objIPTreatmentPlan.Prosthesis = listChildTreatmentPlan[5];
                objIPTreatmentPlan.ParentID = Convert.ToInt32(listChildTreatmentPlan[1]);
                objIPTreatmentPlan.ParentName = listChildTreatmentPlan[3];
                objIPTreatmentPlan.OrgID = OrgID;
                objIPTreatmentPlan.CreatedBy = LID;
                objIPTreatmentPlan.StagePlanned = "OPR";
                lstIPTreatmentPlanTemp.Add(objIPTreatmentPlan);

              
            }
        }
        return lstIPTreatmentPlanTemp;
    }


    //private List<OperationComplication> GetOperationComplication()
    //{
    //    List<OperationComplication> lstOperationComplicationTemp = new List<OperationComplication>();
    //    foreach (string listComplication in hdnDiagnosisItems.Value.Split('^'))
    //    {
    //        if (listComplication != "")
    //        {
    //            OperationComplication objOperationComplication = new OperationComplication();
    //            string[] listChildDiagnosis = listComplication.Split('~');
    //            objOperationComplication.ComplicationName = listChildDiagnosis[1];
    //            objOperationComplication.CreatedBy = LID;
    //            //objOperationComplication.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    //            //objOperationComplication.PatientVisitID = patientVisitID;
    //            lstOperationComplicationTemp.Add(objOperationComplication);
    //        }
    //    }
    //    return lstOperationComplicationTemp;
    //}

    private List<OperationFinding> GetOperationFinding()
    {
        List<OperationFinding> lstOperationFindingTemp = new List<OperationFinding>();

        if (txtPreOPF.Text != string.Empty)
        {
            OperationFinding objOperationFinding = new OperationFinding();
            objOperationFinding.OperationFindings = txtPreOPF.Text;
            objOperationFinding.Type = "PreOPF";
            objOperationFinding.CreatedBy = LID;
            //objOperationFinding.OrgID = OrgID;
            ////objOperationFinding.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            lstOperationFindingTemp.Add(objOperationFinding);
        }

        if (txtOPT.Text != string.Empty)
        {
            OperationFinding objOperationFinding = new OperationFinding();
            objOperationFinding.OperationFindings = txtOPT.Text;
            objOperationFinding.Type = "OPT";
            objOperationFinding.CreatedBy = LID;
            //objOperationFinding.OrgID = OrgID;
            //objOperationFinding.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            lstOperationFindingTemp.Add(objOperationFinding);
        }
        if (txtOPF.Text != string.Empty)
        {
            OperationFinding objOperationFinding = new OperationFinding();
            objOperationFinding.OperationFindings = txtOPF.Text;
            objOperationFinding.Type = "OPF";
            objOperationFinding.CreatedBy = LID;
            //objOperationFinding.OrgID = OrgID;
            //objOperationFinding.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            lstOperationFindingTemp.Add(objOperationFinding);
        }
        if (txtPostOPF.Text != string.Empty)
        {
            OperationFinding objOperationFinding = new OperationFinding();
            objOperationFinding.OperationFindings = txtPostOPF.Text;
            objOperationFinding.Type = "PostOPF";
            objOperationFinding.CreatedBy = LID;
            //objOperationFinding.OrgID = OrgID;
            //objOperationFinding.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            lstOperationFindingTemp.Add(objOperationFinding);

        }
        return lstOperationFindingTemp;
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

    //protected void btnsearch_Click(object sender, EventArgs e)
    //{


    //    mpeTreatmentPlan.Show();
    //}
    protected void ddlAddEdit_SelectedIndexChanged(object sender, EventArgs e)
    {        
        if (ddlAddEdit.SelectedValue == "2")
        {

            //tblTreatment.Visible = true;
            tblTreatment.Style.Add("display", "block");
            List<IPTreatmentPlan> lstIPTreatmentPlanbyPatientVistID = new List<IPTreatmentPlan>();
            ipBL.GetIPTreatmentPlanbyPatientVistID(patientVisitID, out lstIPTreatmentPlanbyPatientVistID);

            gvTreatment.DataSource = lstIPTreatmentPlanbyPatientVistID;
            gvTreatment.DataBind();
            //tblOperationNotes.Visible = false;
            tblOperationNotes.Style.Add("display", "none");
        }
        else
        {
            //tblTreatment.Visible = false;
            tblTreatment.Style.Add("display", "none");
            GetPatientVitalsAndComplaint();
            //tblOperationNotes.Visible = true;
            tblOperationNotes.Style.Add("display", "block");
            Clear();


        }
    }



    public void Clear()
    {
        hdnIPTreatmentPlanItems.Value = "";
        hdnDiagnosisItems.Value = "";
        iconHidAnesthetist.Value = "";
        iconHidAssistant.Value = "";
        iconHidNurse.Value = "";
        iconHidTechnician.Value = "";
        ddlAnesthesiaType.SelectedIndex = 0;
        ddlOperationType.SelectedIndex = 0;
        ddlSurgeryType.SelectedIndex = 0;
        txtFromTime.Text = "";
        txtToTime.Text = "";
        txtOPF.Text = "";
        txtOPT.Text = "";
        txtPostOPF.Text = "";
        txtPreOPF.Text = "";
        ddlChiefOperator.SelectedIndex = 0;

    }
    protected void gvTreatment_RowDataBound(object sender, GridViewRowEventArgs e)
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


    protected void btnEditOperationNotes_Click(object sender, EventArgs e)
    {


        tblSelectOption.Visible = false;
        tblSelectOption.Style.Add("display", "none");

        //string RdoValue = Request.Form["MyRadioButton"];



        if (Request.Form["OPid"] != null && Request.Form["OPid"].ToString() != "")
        {
            RdoValue = Request.Form["OPid"];
        }


        if (RdoValue != "")
        {

            Session["OperationID"] = RdoValue;
            GetOperationNotesForUpdate();
            //tblTreatment.Visible = false;
            tblTreatment.Style.Add("display", "none");
            GetPatientVitalsAndComplaint();

            //tblOperationNotes.Visible = true;
            tblOperationNotes.Style.Add("display", "block");
        }
        else
        {
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "LoginButtonTest", "alert('Select any one');", true);
        }

    }
    protected void btnEditOperationCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
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



    protected void grdCRCplan_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblTreatmentPlanDate = (Label)e.Row.FindControl("lblTreatmentPlanDate");
                CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");
                ((CheckBox)e.Row.FindControl("chkSelect")).Attributes.Add("onclick", "javascript:SelectAll('" +
                    ((CheckBox)e.Row.FindControl("chkSelect")).ClientID + "')");
             
                if (lblTreatmentPlanDate.Text == DateTime.MinValue.ToString())
                {
                    string lblplandate=Resources.ClientSideDisplayTexts.Physician_OperationNotes_aspx_cs_lblplandate;
                    lblTreatmentPlanDate.Text = lblplandate;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdPrescription1_RowDataBound NurseAdvice", ex);
        }
    }

    protected void lnkHome_Click(object sender, EventArgs e)
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
}
