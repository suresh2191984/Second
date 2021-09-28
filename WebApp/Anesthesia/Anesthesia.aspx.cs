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
using System.IO;
using System.Linq;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using AjaxControlToolkit;

public partial class Anesthesia_Anesthesia : BasePage 
{

    long patientVisitID = -1;
    long patientID = -1;
    long returnCode = -1;
    long OperationID = -1;
    int OrgID;
    long Count = -1;
    List<AnesthesiaType> lstAnesthesiaType = new List<AnesthesiaType>();
    List<Patient> lstPatient = new List<Patient>();
    List<IPTreatmentPlanMaster> lstIPTreatmentPlanMaster = new List<IPTreatmentPlanMaster>();
    List<IPTreatmentPlan> lstIPTreatmentPlan = new List<IPTreatmentPlan>();
    List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
    List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
    List<SurgeryType> lstSurgeryType = new List<SurgeryType>();
    List<OperationType> lstOperationType = new List<OperationType>();
    List<Physician> lstChiefOperater = new List<Physician>();
    List<Physician> lstAnesthisa = new List<Physician>();
    List<Physician> lstAnesthisiaOperationStaff = new List<Physician>();
    List<Physician> lstChiefPhysicianOperationStaff = new List<Physician>();
    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();
    List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
    List<AHPStaff> lstTechnicianName = new List<AHPStaff>();
    List<IPTreatmentPlan> lstIPTreatmentPlanFromCaserecord = new List<IPTreatmentPlan>();
    List<Nurse> lstNurseName = new List<Nurse>();
    List<Complication> lstComplication = new List<Complication>();
    IP_BL ipBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        ipBL = new IP_BL(base.ContextInfo);
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["oid"], out OperationID);
        OrgID = base.OrgID;
        txtFromTime.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
        patientHeader.PatientID = patientID;
        patientHeader.PatientVisitID = patientVisitID;
        patientHeader.ShowVitalsDetails();
        LoadSurgeryPlanned();
        GetFCKPath();
        
    }

    public void LoadSurgeryPlanned()
    {
        try
        {
            List<IPTreatmentPlan> lstTreatementPlan = new List<IPTreatmentPlan>();
            List<Physician> lstPhysician = new List<Physician>();
            List<AnesthesiaType> lstAnesthesiaType = new List<AnesthesiaType>();
            List<Patient> lstPatient = new List<Patient>();
            List<InPatientAdmissionDetails> lstInpatientAdmissionDetails =new List<InPatientAdmissionDetails>();
            List<RoomMaster> lstRoom = new List<RoomMaster>();
            List<OperationNotes> lstOperationNotes = new List<OperationNotes>();
            List<AnesthesiaModes> lstModes = new List<AnesthesiaModes>();
            List<Complication> lstComplication = new List<Complication>();
            List<Vitals> lstVitals = new List<Vitals>();
            List<Vitals> lstVitalsVentilator = new List<Vitals>();
            List<Vitals> lstVitalsGas = new List<Vitals>();


            ipBL.GetPlannedSurgeryForAnesthesia(patientVisitID, OrgID, out lstPatient, out lstInpatientAdmissionDetails, out lstTreatementPlan, out lstAnesthesiaType, out lstPhysician, out lstRoom, out lstOperationNotes,out lstModes,out lstComplication,out lstVitals,out lstVitalsGas ,out lstVitalsVentilator);
            if (lstPatient.Count() > 0)
            {
                lblname.Text = lstPatient[0].Name;
                lblIPNo.Text = lstPatient[0].IPNumber;
                lblAge.Text = lstPatient[0].Age;
                lblPatientNumber.Text = lstPatient[0].PatientNumber;
            }
            if (lstTreatementPlan.Count() > 0)
            {
                lblsurgeryname.Text = lstTreatementPlan[0].ParentName;
            }
            if (lstRoom.Count() > 0)
            {
                lblRoomNo.Text = lstRoom[0].RoomName;
            }
            if (lstPhysician.Count() > 0)
            {
                lblSurgeon.Text = lstPhysician[0].PhysicianName;
                lblConsultant.Text = lstPhysician[0].PhysicianName;
            }

         
           // lblSurgeon.Text = lstInpatientAdmissionDetails[0].ConsultingSurgeonName;
            if (lstInpatientAdmissionDetails.Count() > 0)
            {

                lblConsultant.Text = lstInpatientAdmissionDetails[0].PrimaryPhysicianName;
            }

            if (lstOperationNotes.Count() > 0)
            {
                lbltimeofsurgery.Text = Convert.ToString(lstOperationNotes[0].FromTime);
            }

       
          
        
         


            if (lstVitals.Count() > 0)
            {
                for (int i = 0; i < lstVitals.Count; i++)
                {

                    Label lbl = (Label)this.FindControl("lblvitals" + (i + 1));
                    lbl.Text = lstVitals[i].VitalsName;
                    Label lblunits = (Label)this.FindControl("lblunits" + (i + 1));
                    lblunits.Text = lstVitals[i].VitalsDescription;

                }


            }
            if (lstVitalsGas.Count() > 0)
            {
                for (int i = 0; i < lstVitalsGas.Count; i++)
                {

                    Label lblGasVitals = (Label)this.FindControl("lblGasvitals" + (i + 1));
                    lblGasVitals.Text = lstVitalsGas[i].VitalsName;
                    Label lblgasunits = (Label)this.FindControl("lblgasunits" + (i + 1));
                    lblgasunits.Text = lstVitalsGas[i].VitalsDescription;

                }
               
            }

            if (lstVitalsVentilator.Count() > 0)
            {
                for (int i = 0; i < lstVitalsVentilator.Count; i++)
                {

                    Label lblVentilatorVitals = (Label)this.FindControl("lblvitalsventilator" + (i + 1));
                    lblVentilatorVitals.Text = lstVitalsVentilator[i].VitalsName;
                    Label lblVentilatorunits = (Label)this.FindControl("lblventilatorunits" + (i + 1));
                    lblVentilatorunits.Text = lstVitalsVentilator[i].VitalsDescription;

                }

            }
          
            if (lstAnesthesiaType.Count() > 0)
            {

                DDLAnesthesiaType.DataSource = lstAnesthesiaType;
                DDLAnesthesiaType.DataTextField = "TypeName";
                DDLAnesthesiaType.DataValueField = "AnesthesiaTypeID";
                DDLAnesthesiaType.DataBind();
            }
            if (lstPhysician.Count() > 0)
            {
                DDLanesthesiologist.DataSource = lstPhysician;
                DDLanesthesiologist.DataTextField = "PhysicianName";
                DDLanesthesiologist.DataValueField = "PhysicianID";
                DDLanesthesiologist.DataBind();
            }


          
          
        }
        catch(Exception ex)
        {
            CLogger.LogError("Error while loading IPTreatmentPlan in Anesthesia Notes.aspx", ex);
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
           
            CLogger.LogError("Error while loading IPTreatmentPlan in opeartion Notes.aspx", ex);
        }
    }
  
  

  

   

 

    protected void OKButton_Click(object sender, EventArgs e)
    {
        mpe.Hide();
    }
    protected void OKButtonGas_Click(object sender, EventArgs e)
    {
        MPEBloodGas.Hide();
    }
    protected void OKButtonVentilator_Click(object sender, EventArgs e)
    {
        MPEVentilator.Hide();
    }



    protected void grdPrescription1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            Uri_BL uiBl = new Uri_BL(base.ContextInfo);
            List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
            DateTime FDate, TDate;
            patientVisitID = Convert.ToInt64(Request.QueryString["vid"]);

        
            List<DrugDetails> lstDurgsAdmined = new List<DrugDetails>();
            List<DrugDetails> lstAdminsteredDrugs = new List<DrugDetails>();
          
            List<DrugDetails> lstDDforReBind = new List<DrugDetails>();
            List<DrugDetails> lstDDtoSTOP = new List<DrugDetails>();
            if (e.CommandName == "Add")
            {
                foreach (GridViewRow gr in grdPrescription1.Rows)
                {


                    TextBox txtFDate = (TextBox)gr.FindControl("txtFDate");
                    TextBox txtTDate = (TextBox)gr.FindControl("txtTDate");
                    Label lbladviceID = (Label)gr.FindControl("lblPrescriptionID");
                    Label lbSno = (Label)gr.FindControl("lblSno");

                    if (txtFDate.Text != "")
                    {
                        FDate = Convert.ToDateTime(txtFDate.Text);
                    }
                    else
                    {
                        FDate = new DateTime(1800, 1, 1);
                    }
                    if (txtTDate.Text != "")
                    {
                        TDate = Convert.ToDateTime(txtTDate.Text);
                    }
                    else
                    {
                        TDate = new DateTime(1800, 1, 1);
                    }


                    DrugDetails DD = new DrugDetails();
                    DD = new DrugDetails();

                    if (((CheckBox)gr.FindControl("chkSelect")).Checked == true)
                    {
                        DD.AdministeredStatus = true;
                    }
                    else
                    {
                        DD.AdministeredStatus = false;
                    }

                    DD.PrescriptionID = Convert.ToInt64(lbladviceID.Text);
                    DD.Sno = Convert.ToInt64(lbSno.Text);
                    //DD.DrugName = gr.Cells[1].Text.ToString();
                    //DD.Dose = gr.Cells[3].Text.ToString();
                    //DD.DrugFormulation = gr.Cells[2].Text.ToString();

                    Label lbDrugFormulation = (Label)gr.FindControl("lblDrugFormulation");
                    Label lbDrugDose = (Label)gr.FindControl("lblDose");
                    Label lbDrugName = (Label)gr.FindControl("lblDrugName");

                    DD.DrugFormulation = lbDrugFormulation.Text.ToString();
                    DD.Dose = lbDrugDose.Text.ToString();
                    DD.DrugName = lbDrugName.Text.ToString();

                    Label lbROA = (Label)gr.FindControl("lblROA");
                    Label lbDrugFrequency = (Label)gr.FindControl("lblDrugFrequency");
                    Label lbDuration = (Label)gr.FindControl("lblDuration");
                    Label lbInstruction = (Label)gr.FindControl("lblInstruction");

                    DD.ROA = lbROA.Text.ToString();
                    DD.DrugFrequency = lbDrugFrequency.Text.ToString();
                    DD.Duration = lbDuration.Text.ToString();
                    DD.Instruction = lbInstruction.Text.ToString();

                    Label lbCreatedBy = (Label)gr.FindControl("lblCreatedBy");
                    DD.CreatedBy = Convert.ToInt64(lbCreatedBy.Text);

                    DD.AdministeredAtFrom = FDate;
                    DD.AdministeredAtTo = TDate;

                    lstDDforReBind.Add(DD);

                }
                int presId = Convert.ToInt32(e.CommandArgument);
                List<DrugDetails> FilterdDD = (from DDRBind in lstDDforReBind
                                               where DDRBind.Sno == presId
                                               select DDRBind).ToList();


                if (FilterdDD.Count > 0)
                {
                    for (int i = 0; i < FilterdDD.Count; i++)
                    {
                        DrugDetails D = new DrugDetails();
                        //D.PrescriptionID = Convert.ToInt32(hdNewID.Value) - 1;
                        D.Sno = Convert.ToInt64(hdNewID.Value) - 1;
                        D.PrescriptionID = FilterdDD[i].PrescriptionID;
                        hdNewID.Value = D.Sno.ToString();
                        D.DrugName = FilterdDD[i].DrugName;
                        D.Dose = FilterdDD[i].Dose;
                        D.DrugFormulation = FilterdDD[i].DrugFormulation;
                        D.ROA = FilterdDD[i].ROA;
                        D.DrugFrequency = FilterdDD[i].DrugFrequency;
                        D.Duration = FilterdDD[i].Duration;
                        D.Instruction = FilterdDD[i].Instruction;
                        D.CreatedBy = FilterdDD[i].CreatedBy;
                        //D.AdministeredAtFrom = FilterdDD[i].AdministeredAtFrom;
                        //D.AdministeredAtTo = FilterdDD[i].AdministeredAtTo;
                        lstDDforReBind.Add(D);
                    }
                }

                grdPrescription1.DataSource = lstDDforReBind;
                grdPrescription1.DataBind();
            }
            if (e.CommandName == "Stop")
            {
                DrugDetails DD = new DrugDetails();
                DD = new DrugDetails();
                DD.PrescriptionID = Convert.ToInt64(e.CommandArgument.ToString());
                DD.DrugStatus = "STOPED";
                DD.AdministeredAtFrom = new DateTime(1800, 1, 1);
                DD.AdministeredAtTo = new DateTime(1800, 1, 1);
                DD.ModifiedBy = LID;
                lstDDtoSTOP.Add(DD);

                returnCode = new Uri_BL(base.ContextInfo).UpdatePrescription(lstDDtoSTOP);
                returnCode = uiBl.GetSearchPatientPrescription(patientVisitID, LID, RoleID, out lstDrugDetails, out lstAdminsteredDrugs);
                if (lstDrugDetails.Count > 0)
                {
                    string rName = string.Empty;
                    //if (RoleName == "Nurse")
                    //{
                    rName = "Physician";
                    //    lblPrescribedBy.Text = "Below Drugs Prescribed By : " + rName;
                    //}
                    //else if (RoleName == "Physician")
                    //{
                    //    rName = "Nurse";
                   // lblPrescribedBy.Text = "Below Drugs Administred By : " + rName;
                    //}

                    //lstDDforAdding = lstDrugDetails;
                    grdPrescription1.DataSource = lstDrugDetails;
                    grdPrescription1.DataBind();
                }
                else
                {
                    grdPrescription1.Visible = false;
                }
                hdNewID.Value = "-1";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdPrescription1_RowCommand NurseAdvice", ex);
        }
    }
    protected void grdPrescription1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DrugDetails D = (DrugDetails)e.Row.DataItem;
                if (D.AdministeredStatus == true)
                {
                    CheckBox chkBox = (CheckBox)e.Row.FindControl("chkSelect");
                    chkBox.Checked = true;
                }
                else
                {
                    CheckBox chkBox = (CheckBox)e.Row.FindControl("chkSelect");
                    chkBox.Checked = false;
                }

                TextBox txtFDate = (TextBox)e.Row.FindControl("txtFDate");
                if ((txtFDate.Text == "01/01/0001 00:00:00") || (txtFDate.Text == "01/01/1800 00:00:00") || (txtFDate.Text == ""))
                {
                    txtFDate.Text = string.Empty;
                }
                else
                {

                }

                TextBox txtTDate = (TextBox)e.Row.FindControl("txtTDate");
                if ((txtTDate.Text == "01/01/0001 00:00:00") || (txtTDate.Text == "01/01/1800 00:00:00") || (txtTDate.Text == ""))
                {
                    txtTDate.Text = string.Empty;
                }
                if (RoleName == "Physician")
                {
                    //grdPrescription1.Columns[0].Visible = false;    //Checkbox
                    grdPrescription1.Columns[5].Visible = false;    //From date
                    grdPrescription1.Columns[6].Visible = false;    //To date
                    grdPrescription1.Columns[7].Visible = false;    //Add
                }
                if (RoleName == "Nurse")
                {
                    grdPrescription1.Columns[8].Visible = false;    //Stop
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdPrescription1_RowDataBound NurseAdvice", ex);
        }
    }
   
    protected void grdDrugChart_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblFDate = (Label)e.Row.FindControl("lblAdministeredAtFrom");
            Label lblTDate = (Label)e.Row.FindControl("lblAdministeredAtTo");

            if ((lblFDate.Text == "01/01/0001 00:00:00") || (lblFDate.Text == "01/01/1800 00:00:00") || (lblFDate.Text == ""))
            {
                lblFDate.Text = string.Empty;
            }
            if ((lblTDate.Text == "01/01/0001 00:00:00") || (lblTDate.Text == "01/01/1800 00:00:00") || (lblTDate.Text == ""))
            {
                lblTDate.Text = string.Empty;
            }

        }
    }





    protected void btnSave_Click(object sender, EventArgs e)
    {
       
        PatientVitals_BL patientVitalBL = new PatientVitals_BL(base.ContextInfo);     
        long patientVisitID = 0;
        long patientID = 0;

        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        LoadSurgeryPlanned();
        long retCode = -1;
      
        string AnesthesiaNotes = string.Empty;
        string AnesthesiaTypes = string.Empty;
        DateTime  start =DateTime.MinValue ;
        DateTime End = DateTime.MinValue;
        string NPODuration = string.Empty;
        string ModeofAnesthesia = string.Empty;
        string ScoringValue = string.Empty;
        string ScoringSystem = string.Empty;
        string Complications = string.Empty;
        IP_BL objBL =new IP_BL(base.ContextInfo);
        start = Convert.ToDateTime(txtFromTime.Text.ToString());
        End = Convert.ToDateTime(txtFromTime.Text.ToString());
        AnesthesiaTypes = DDLAnesthesiaType.SelectedItem.Text;
        NPODuration = txtNPODuration.Text;
        AnesthesiaNotes = fckAnesthesiaNotes.Value.Trim();
        ScoringSystem = DDLScoringSystem.SelectedItem.Text;
        ScoringValue = DDLScoringValue.SelectedItem.Text;
        string OtherComplication = string.Empty;
        int VisitID = 1;
        int NewVitalsSetID = -1;
        List<Complication> lstComplicationTemp = new List<Complication>();

      //  List<Attune.Podium.BusinessEntities.PatientVitals> lstMaxOfVitalsSetID = new List<Attune.Podium.BusinessEntities.PatientVitals>();
      //  IP_BL oIP_BL = new IP_BL(base.ContextInfo);
      //  retCode = oIP_BL.GetMaxOfVitalsSetID(patientVisitID, out lstMaxOfVitalsSetID);

        string[] str = hdnRecords.Value.Split('^');

        // ^HR_bpm_12~Rhythm__52~ABP_mmHg_52~MAP_mmHg_5~CVP_mmHg_2~PCWP_mmHg_52~SaO2_%_52~Temp_°F_5~2
        for(int j=0;j<str.Length;j++)
        {
         
            if (str[j] != "")
            {
              
                string[] items = str[j].Split('~');
                for (int i = 0; i < items.Length; i++)
                {
                    string[] list = items[i].Split('_');
                    //foreach (string s in list)
                    PatientVitals objVitalsCapture = new PatientVitals();
                    if (list.Length >= 3)
                    {

                        //"HR_bpm_1"
                        //PatientVitals objVitalsCapture = new PatientVitals();
                        objVitalsCapture.PatientVitalsID = 0;
                        objVitalsCapture.PatientVisitID = patientVisitID;
                        objVitalsCapture.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objVitalsCapture.VitalsName = Convert.ToString(list[0].ToString());
                        objVitalsCapture.VitalsValue = Convert.ToDecimal(list[2].ToString());
                        objVitalsCapture.PatientID =patientID ;
                        objVitalsCapture.NurseNotes =list[1].ToString();
                        objVitalsCapture.ModifiedAt =Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objVitalsCapture.PatientVitalsID = 0;
                        objVitalsCapture.VitalsDescription = "";
                        objVitalsCapture.VitalsSetID = 0;
                        objVitalsCapture.VitalsType = "Anesthesia" + '~' + Convert.ToString(list[0].ToString()) + '~' + list[1].ToString();
                        objVitalsCapture.VitalsTypeID = 0;
                        objVitalsCapture.ConditionID = 0;
                        objVitalsCapture.VitalsID = 0;
                        objVitalsCapture.ModifiedBy = 0;
                        objVitalsCapture.CreatedBy = 0;
                               
                        if (list[1] != null)
                        {
                            objVitalsCapture.UOMCode = list[1].ToString();
                            objVitalsCapture.UOMDescription = list[1].ToString();
                           // objVitalsCapture.UOMID = Convert.ToInt16(list[1].ToString());
                        }
                        else
                        {
                            objVitalsCapture.UOMCode = "0";
                            objVitalsCapture.UOMDescription = "";
                        }
                    }
                    else
                    {

                        objVitalsCapture.PatientVitalsID = 0;
                        objVitalsCapture.PatientVisitID = patientVisitID;
                        objVitalsCapture.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objVitalsCapture.PatientID = patientID;
                        objVitalsCapture.VitalsName = "";
                        objVitalsCapture.VitalsValue = 0;
                        objVitalsCapture.NurseNotes = ""; 
                        objVitalsCapture.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objVitalsCapture.PatientVitalsID = 0;
                        objVitalsCapture.UOMDescription = "";
                        objVitalsCapture.VitalsDescription = "";
                        objVitalsCapture.VitalsSetID = 0;
                        objVitalsCapture.VitalsType = "Anesthesia";
                        objVitalsCapture.VitalsTypeID = 0;
                        objVitalsCapture.ConditionID = 0;
                        objVitalsCapture.VitalsID = 0;
                        objVitalsCapture.ModifiedBy = 0;
                        objVitalsCapture.CreatedBy = 0;
                        objVitalsCapture.VitalsName = "";
                        objVitalsCapture.UOMCode = "";
                        objVitalsCapture.VitalsValue =0;
                       //objVitalsCapture.UOMID = Convert.ToInt16(list[1].ToString());
                    }
                    
                  
                    lstPatientVitals.Add(objVitalsCapture);

                      
                    }
          
                }

    
      
        }
        //Blood Gas Monitoring Start 

        string[] str1 = hdnRecordsBloodGas.Value.Split('^');
        for (int j = 0; j < str1.Length; j++)
        {

            if (str1[j] != "")
            {

                string[] items = str1[j].Split('~');
                for (int i = 0; i < items.Length; i++)
                {
                    string[] list = items[i].Split('_');
                    //foreach (string s in list)
                    PatientVitals objVitalsCapture = new PatientVitals();
                    if (list.Length >= 3)
                    {
                        //PatientVitals objVitalsCapture = new PatientVitals();
                        objVitalsCapture.PatientVitalsID = 0;
                        objVitalsCapture.PatientVisitID = patientVisitID;
                        objVitalsCapture.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objVitalsCapture.VitalsName = Convert.ToString(list[0].ToString());
                        objVitalsCapture.VitalsValue = Convert.ToDecimal(list[2].ToString());
                        objVitalsCapture.PatientID = patientID;
                        objVitalsCapture.NurseNotes = "";
                        objVitalsCapture.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objVitalsCapture.PatientVitalsID = 0;
                        objVitalsCapture.UOMDescription = "";
                        objVitalsCapture.VitalsDescription = "";
                        objVitalsCapture.VitalsSetID = 0;
                        objVitalsCapture.VitalsType = "AnesthesiaBloodGas" + '~' + Convert.ToString(list[0].ToString()) + '~' + list[1].ToString();
                        objVitalsCapture.VitalsTypeID = 0;
                        objVitalsCapture.ConditionID = 0;
                        objVitalsCapture.VitalsID = 0;
                        objVitalsCapture.ModifiedBy = 0;
                        objVitalsCapture.CreatedBy = 0;



                        if (list[1] != null)
                        {
                            objVitalsCapture.UOMCode = list[1].ToString();
                            objVitalsCapture.UOMDescription = list[1].ToString();
                        }
                        else
                        {
                            objVitalsCapture.UOMCode = "0";
                            objVitalsCapture.UOMDescription = "";
                        }
                    }
                    else
                    {

                        objVitalsCapture.PatientVitalsID = 0;
                        objVitalsCapture.PatientVisitID = patientVisitID;
                        objVitalsCapture.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objVitalsCapture.PatientID = patientID;
                        objVitalsCapture.VitalsName = "";
                        objVitalsCapture.VitalsValue = 0;
                        objVitalsCapture.NurseNotes = "";
                        objVitalsCapture.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objVitalsCapture.PatientVitalsID = 0;
                        objVitalsCapture.UOMDescription = "";
                        objVitalsCapture.VitalsDescription = "";
                        objVitalsCapture.VitalsSetID = 0;
                        objVitalsCapture.VitalsType = "AnesthesiaBloodGas" + '~' + list[1].ToString();
                        objVitalsCapture.VitalsTypeID = 0;
                        objVitalsCapture.ConditionID = 0;
                        objVitalsCapture.VitalsID = 0;
                        objVitalsCapture.ModifiedBy = 0;
                        objVitalsCapture.CreatedBy = 0;
                        objVitalsCapture.VitalsName = "";
                        objVitalsCapture.UOMCode = "";
                        objVitalsCapture.VitalsValue = Convert.ToDecimal(list[0].ToString());
                    }


                    lstPatientVitals.Add(objVitalsCapture);


                }

            }



        }


        //END 

        //Ventilator vitals Start
      //  hdnventilator

        string[] str2 = hdnventilator.Value.Split('^');
        for (int j = 0; j < str2.Length; j++)
        {

            if (str2[j] != "")
            {

                string[] items = str2[j].Split('~');
                for (int i = 0; i < items.Length; i++)
                {
                    string[] list = items[i].Split('_');
                    //foreach (string s in list)
                    PatientVitals objVitalsCapture = new PatientVitals();
                    if (list.Length >= 3)
                    {
                        //PatientVitals objVitalsCapture = new PatientVitals();
                        objVitalsCapture.PatientVitalsID = 0;
                        objVitalsCapture.PatientVisitID = patientVisitID;
                        objVitalsCapture.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objVitalsCapture.VitalsName = Convert.ToString(list[0].ToString());
                        objVitalsCapture.VitalsValue = Convert.ToDecimal(list[2].ToString());
                        objVitalsCapture.PatientID = patientID;
                        objVitalsCapture.NurseNotes = "";
                        objVitalsCapture.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objVitalsCapture.PatientVitalsID = 0;
                        objVitalsCapture.UOMDescription = "";
                        objVitalsCapture.VitalsDescription = "";
                        objVitalsCapture.VitalsSetID = 0;
                        objVitalsCapture.VitalsType = "AnesthesiaVentilator" + '~'+Convert.ToString(list[0].ToString())+'~' + list[1].ToString();
                        objVitalsCapture.VitalsTypeID = 0;
                        objVitalsCapture.ConditionID = 0;
                        objVitalsCapture.VitalsID = 0;
                        objVitalsCapture.ModifiedBy = 0;
                        objVitalsCapture.CreatedBy = 0;



                        if (list[1] != null)
                        {
                            objVitalsCapture.UOMCode = list[1].ToString();
                            objVitalsCapture.UOMDescription = list[1].ToString();
                        }
                        else
                        {
                            objVitalsCapture.UOMCode = "0";
                            objVitalsCapture.UOMDescription = "";
                        }
                    }
                    else
                    {

                        objVitalsCapture.PatientVitalsID = 0;
                        objVitalsCapture.PatientVisitID = patientVisitID;
                        objVitalsCapture.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objVitalsCapture.PatientID = patientID;
                        objVitalsCapture.VitalsName = "";
                        objVitalsCapture.VitalsValue = 0;
                        objVitalsCapture.NurseNotes = "";
                        objVitalsCapture.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objVitalsCapture.PatientVitalsID = 0;
                        objVitalsCapture.UOMDescription = "";
                        objVitalsCapture.VitalsDescription = "";
                        objVitalsCapture.VitalsSetID = 0;
                        objVitalsCapture.VitalsType = "AnesthesiaVentilator" + '~' + Convert.ToString(list[0].ToString()) + '~' + list[1].ToString();
                        objVitalsCapture.VitalsTypeID = 0;
                        objVitalsCapture.ConditionID = 0;
                        objVitalsCapture.VitalsID = 0;
                        objVitalsCapture.ModifiedBy = 0;
                        objVitalsCapture.CreatedBy = 0;
                        objVitalsCapture.VitalsName = "ss";
                        objVitalsCapture.UOMCode = "sss";
                        objVitalsCapture.VitalsValue = Convert.ToDecimal(list[0].ToString());
                    }


                    lstPatientVitals.Add(objVitalsCapture);


                }

            }



        }
        //END

      
        returnCode = patientVitalBL.SavePatientVitals(OrgID, VisitID, lstPatientVitals);

        SaveDrugDetails();

        foreach (ListItem chk in chkModeofAnesthesia.Items)
        {
            if (chk.Selected == true)
                ModeofAnesthesia += chk.Value + '~';

        }
      
        if (ChkOthers.Checked)
        {
            Complications = txtComplicationOthers.Text;
        }
        else
        {
            foreach (ListItem chk in ChkComplications.Items)
            {
                if (chk.Selected == true)
                    Complications += chk.Value  + '~';

            }
        }

        lstPatientAdvice = uGAdv.GetGeneralAdvice(patientVisitID);
        Uri_BL uriBL = new Uri_BL(base.ContextInfo);
        long retval = -1;
        string admitSuggest = string.Empty;
        string physicihancomments = string.Empty;
        string nextReviewDate = string.Empty;
        int pOrderedInvCnt = 0;
        string gUID = string.Empty;
        gUID = Guid.NewGuid().ToString();
        List<DrugDetails> lstdrugs = new List<DrugDetails>();
   
    
            
        List<PatientComplaint> lstdhebDiagnosis = new List<PatientComplaint>();
        List<PatientHistory> lstdhebHistory = new List<PatientHistory>();
        List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>();
        //Get entered Examinations from the control
        List<PatientExamination> lstdhebExamination = new List<PatientExamination>();
        retval = uriBL.SaveUnFoundDiagnosisData(0, admitSuggest, patientID, nextReviewDate, patientVisitID, lstdhebDiagnosis,
                                 lstdhebHistory, lstdhebExamination,
                                 orderedInvesHL, lstdrugs, lstPatientAdvice, lstPatientVitals, OrgID, out pOrderedInvCnt, "pending", gUID, physicihancomments);

        returnCode = objBL.InsertAnesthesiaNotes(patientVisitID, patientID, start, End, AnesthesiaTypes, NPODuration, AnesthesiaNotes, ModeofAnesthesia, ScoringSystem, ScoringValue, Complications,out lstPatientAdvice);
        Response.Redirect("PrintAnesthesiaNotes.aspx?pid=" + patientID + "&vid=" + patientVisitID);

         
    }

  

    private void GetFCKPath()
    {
        try
        {
            string sPath = Request.Url.AbsolutePath;
            int iIndex = sPath.LastIndexOf("/");

            sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
            sPath = Request.ApplicationPath ;
            sPath = sPath + "/fckeditor/";
            fckAnesthesiaNotes.ToolbarSet = "Attune";
            fckAnesthesiaNotes.BasePath = sPath;
            fckAnesthesiaNotes.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            fckAnesthesiaNotes.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
        }
        catch (Exception ex)
        {
            CLogger.LogError("There is a Problem in get FCK Path", ex);
        }
    }

    public  void SaveDrugDetails()
    {
        try
        {

            Uri_BL uiBl = new Uri_BL(base.ContextInfo);
            List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
            DateTime FDate, TDate;
            patientVisitID  = Convert.ToInt64(Request.QueryString["vid"]);

            lstDrugDetails = uAd.GetPrescription(patientVisitID);
            List<DrugDetails> lstDurgsAdmined = new List<DrugDetails>();
            foreach (GridViewRow gr in grdDrugChart.Rows)
            {
                if (((CheckBox)gr.FindControl("chkSelect")).Checked == true)
                {
                    TextBox txtFDate = (TextBox)gr.FindControl("txtFDate");
                    TextBox txtTDate = (TextBox)gr.FindControl("txtTDate");
                    Label lbladviceID = (Label)gr.FindControl("lblPrescriptionID");

                    if (txtFDate.Text != "")
                    {
                        FDate = Convert.ToDateTime(txtFDate.Text);
                    }
                    else
                    {
                        FDate = new DateTime(1800, 1, 1);
                    }
                    if (txtTDate.Text != "")
                    {
                        TDate = Convert.ToDateTime(txtTDate.Text);
                    }
                    else
                    {
                        TDate = new DateTime(1800, 1, 1);
                    }

                    DrugDetails DD = new DrugDetails();
                    DD = new DrugDetails();
                    DD.AdministeredAtFrom = FDate;
                    DD.AdministeredAtTo = TDate;
                    DD.ModifiedBy = LID;
                    if (Convert.ToInt32(lbladviceID.Text) < 0)
                    {
                        DD.PrescriptionID = 0;
                    }
                    else
                    {
                        DD.PrescriptionID = Convert.ToInt64(lbladviceID.Text);
                    }
                    //DD.DrugName = gr.Cells[1].Text.ToString();
                    //DD.Dose = gr.Cells[3].Text.ToString();
                    //DD.DrugFormulation = gr.Cells[2].Text.ToString();

                    Label lbDrugFormulation = (Label)gr.FindControl("lblDrugFormulation");
                    Label lbDrugDose = (Label)gr.FindControl("lblDose");
                    Label lbDrugName = (Label)gr.FindControl("lblDrugName");

                    DD.DrugFormulation = lbDrugFormulation.Text.ToString();
                    DD.Dose = lbDrugDose.Text.ToString();
                    DD.DrugName = lbDrugName.Text.ToString();

                    Label lbROA = (Label)gr.FindControl("lblROA");
                    Label lbDrugFrequency = (Label)gr.FindControl("lblDrugFrequency");
                    Label lbDuration = (Label)gr.FindControl("lblDuration");
                    Label lbInstruction = (Label)gr.FindControl("lblInstruction");

                    //Label lbCreatedBy = (Label)gr.FindControl("lblCreatedBy");
                    //DD.CreatedBy = Convert.ToInt64(lbCreatedBy.Text);
                    DD.CreatedBy = LID;

                    DD.ROA = lbROA.Text.ToString();
                    DD.DrugFrequency = lbDrugFrequency.Text.ToString();
                    DD.Duration = lbDuration.Text.ToString();
                    DD.Instruction = lbInstruction.Text.ToString();
                    DD.PatientVisitID = patientVisitID;
                    DD.DrugStatus = "ADMINISTERED";
                    //lstDrugDetailsUpdate.Add(DD);
                    lstDurgsAdmined.Add(DD);
                }
            }

            returnCode = uiBl.SavePrescription(lstDrugDetails, lstDurgsAdmined);

            //List<Role> lstUserRole1 = new List<Role>();
            //string path1 = string.Empty;
            //Role role1 = new Role();
            //role1.RoleID = RoleID;
            //lstUserRole1.Add(role1);
            //returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
            //if (lstDrugDetails.Count > 0 || lstDurgsAdmined.Count > 0)
            //{
            //    Response.Redirect(Request.ApplicationPath + path1 + "?TS=S", true);
            //}
            //else
            //{
            //    Response.Redirect(Request.ApplicationPath + path1, true);
            //}

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string stae = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("", ex);
        }
    }
    protected void btnSavedrug_Click(object sender, EventArgs e)
    {
        try
        {
            Uri_BL uiBl = new Uri_BL(base.ContextInfo);
            List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
            DateTime FDate, TDate;
            patientVisitID = Convert.ToInt64(Request.QueryString["vid"]);

            lstDrugDetails = uAd.GetPrescription(patientVisitID);
            List<DrugDetails> lstDurgsAdmined = new List<DrugDetails>();
            foreach (GridViewRow gr in grdDrugChart.Rows)
            {
                if (((CheckBox)gr.FindControl("chkSelect")).Checked == true)
                {
                    TextBox txtFDate = (TextBox)gr.FindControl("txtFDate");
                    TextBox txtTDate = (TextBox)gr.FindControl("txtTDate");
                    Label lbladviceID = (Label)gr.FindControl("lblPrescriptionID");

                    if (txtFDate.Text != "")
                    {
                        FDate = Convert.ToDateTime(txtFDate.Text);
                    }
                    else
                    {
                        FDate = new DateTime(1800, 1, 1);
                    }
                    if (txtTDate.Text != "")
                    {
                        TDate = Convert.ToDateTime(txtTDate.Text);
                    }
                    else
                    {
                        TDate = new DateTime(1800, 1, 1);
                    }

                    DrugDetails DD = new DrugDetails();
                    DD = new DrugDetails();
                    DD.AdministeredAtFrom = FDate;
                    DD.AdministeredAtTo = TDate;
                    DD.ModifiedBy = LID;
                    if (Convert.ToInt32(lbladviceID.Text) < 0)
                    {
                        DD.PrescriptionID = 0;
                    }
                    else
                    {
                        DD.PrescriptionID = Convert.ToInt64(lbladviceID.Text);
                    }
                    //DD.DrugName = gr.Cells[1].Text.ToString();
                    //DD.Dose = gr.Cells[3].Text.ToString();
                    //DD.DrugFormulation = gr.Cells[2].Text.ToString();

                    Label lbDrugFormulation = (Label)gr.FindControl("lblDrugFormulation");
                    Label lbDrugDose = (Label)gr.FindControl("lblDose");
                    Label lbDrugName = (Label)gr.FindControl("lblDrugName");

                    DD.DrugFormulation = lbDrugFormulation.Text.ToString();
                    DD.Dose = lbDrugDose.Text.ToString();
                    DD.DrugName = lbDrugName.Text.ToString();

                    Label lbROA = (Label)gr.FindControl("lblROA");
                    Label lbDrugFrequency = (Label)gr.FindControl("lblDrugFrequency");
                    Label lbDuration = (Label)gr.FindControl("lblDuration");
                    Label lbInstruction = (Label)gr.FindControl("lblInstruction");

                    //Label lbCreatedBy = (Label)gr.FindControl("lblCreatedBy");
                    //DD.CreatedBy = Convert.ToInt64(lbCreatedBy.Text);
                    DD.CreatedBy = LID;

                    DD.ROA = lbROA.Text.ToString();
                    DD.DrugFrequency = lbDrugFrequency.Text.ToString();
                    DD.Duration = lbDuration.Text.ToString();
                    DD.Instruction = lbInstruction.Text.ToString();
                    DD.PatientVisitID = patientVisitID;
                    DD.DrugStatus = "ADMINISTERED";
                    //lstDrugDetailsUpdate.Add(DD);
                    lstDurgsAdmined.Add(DD);
                }
            }

            returnCode = uiBl.SavePrescription(lstDrugDetails, lstDurgsAdmined);

            //List<Role> lstUserRole1 = new List<Role>();
            //string path1 = string.Empty;
            //Role role1 = new Role();
            //role1.RoleID = RoleID;
            //lstUserRole1.Add(role1);
            //returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
            //if (lstDrugDetails.Count > 0 || lstDurgsAdmined.Count > 0)
            //{
            //    Response.Redirect(Request.ApplicationPath + path1 + "?TS=S", true);
            //}
            //else
            //{
            //    Response.Redirect(Request.ApplicationPath + path1, true);
            //}

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string stae = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Submit Event Nurse/NurseAdvice", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole1 = new List<Role>();
            string path1 = string.Empty;
            Role role1 = new Role();
            role1.RoleID = RoleID;
            lstUserRole1.Add(role1);
            returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
            Response.Redirect(Request.ApplicationPath + path1, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void btnStopMedicine_Click(object sender, EventArgs e)
    {
        int flag = 0;
        List<DrugDetails> lstDDtoSTOP = new List<DrugDetails>();
        List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
        List<DrugDetails> lstAdminsteredDrugs = new List<DrugDetails>();
        Uri_BL uiBl = new Uri_BL(base.ContextInfo);
        foreach (GridViewRow gr in grdPrescription1.Rows)
        {
            if (((CheckBox)gr.FindControl("chkSelect")).Checked == true)
            {
                flag = flag + 1;
                DrugDetails DD = new DrugDetails();
                DD = new DrugDetails();
                Label lbladviceID = (Label)gr.FindControl("lblPrescriptionID");

                DD.PrescriptionID = Convert.ToInt64(lbladviceID.Text);
                DD.DrugStatus = "STOPED";
                DD.AdministeredAtFrom = new DateTime(1800, 1, 1);
                DD.AdministeredAtTo = new DateTime(1800, 1, 1);
                DD.ModifiedBy = LID;
                lstDDtoSTOP.Add(DD);

                returnCode = new Uri_BL(base.ContextInfo).UpdatePrescription(lstDDtoSTOP);
                returnCode = uiBl.GetSearchPatientPrescription(patientVisitID , LID, RoleID, out lstDrugDetails, out lstAdminsteredDrugs);
                if (lstDrugDetails.Count > 0)
                {
                    string rName = string.Empty;
                    //if (RoleName == "Nurse")
                    //{
                    rName = "Physician";
                    //    lblPrescribedBy.Text = "Below Drugs Prescribed By : " + rName;
                    //}
                    //else if (RoleName == "Physician")
                    //{
                    //    rName = "Nurse";
                 //   lblPrescribedBy.Text = "Below Drugs Administred By : " + rName;
                    //}

                    //lstDDforAdding = lstDrugDetails;
                    grdPrescription1.DataSource = lstDrugDetails;
                    grdPrescription1.DataBind();
                }
                hdNewID.Value = "-1";
            }
        }
        if (flag == 0)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "select1", "javascript:alert('Please Select Any one Medicine');", true);
        }
    }


     

}
