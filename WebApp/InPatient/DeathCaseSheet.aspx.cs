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

public partial class InPatient_DeathCaseSheet : BasePage
{
    long patientID = -1;
    long patientVisitID = 0;
    long returnCode = -1;
    string VistType = string.Empty;
    string IpNumber = string.Empty;
    string strTC = string.Empty, strTS = string.Empty, strAlco = string.Empty, strID = string.Empty;
    int OrthoCount = -1;

    List<RTAMLCDetails> lstRTAMLCDetails = new List<RTAMLCDetails>();
    List<DeathRegistration> lstDeathRegistration = new List<DeathRegistration>();
    List<CauseOfDeath> lstCauseOfDeath = new List<CauseOfDeath>();
    List<OrganRegWithMapping> lstOrgRegWithMapping = new List<OrganRegWithMapping>();

    List<PatientHistory> lstPatientHis = new List<PatientHistory>();
    List<PatientHistoryAttribute> lstPatientHisAttributes = new List<PatientHistoryAttribute>();

    List<InPatientAdmissionDetails> lstIPAdmissionDetails = new List<InPatientAdmissionDetails>();
    List<Patient> lstPatient = new List<Patient>();

    #region to get the patient admission and operation details

    List<Patient> lsPatient = new List<Patient>();
    List<InPatientAdmissionDetails> lstInPatientAdmissionDetails = new List<InPatientAdmissionDetails>();
    List<InPatientAdmissionDetails> lstAdmissionDate = new List<InPatientAdmissionDetails>();
    List<OperationNotes> lstOperationNotes = new List<OperationNotes>();
    List<DischargeSummary> lstDischargeSummary = new List<DischargeSummary>();
    List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
    List<IPTreatmentPlan> lstCaserecordIPTreatmentPlan = new List<IPTreatmentPlan>();
    List<BackgroundProblem> lstBackgroundProblem = new List<BackgroundProblem>();
    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();
    List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
    List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
    List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
    List<IPTreatmentPlan> lstOperationIPTreatmentPlan = new List<IPTreatmentPlan>();
    List<PatientHistory> lstPatientHistory = new List<PatientHistory>();

    List<IPTreatmentPlanMaster> lstIPTreatmentPlanMaster = new List<IPTreatmentPlanMaster>();
    List<IPTreatmentPlan> lstIPTreatmentPlan = new List<IPTreatmentPlan>();
    List<PatientAddress> lstPatientAddress = new List<PatientAddress>();
    List<DischargeSummary> lstDischargeSummaryByPatientID = new List<DischargeSummary>();

    //Newly Added
    List<PatientVitals> lstPatientVitalsCount = new List<PatientVitals>();
    List<VitalsUOMJoin> lstDischargeVitalsUOMJoin = new List<VitalsUOMJoin>();

    List<IPComplaint> lstNegativeIPComplaint = new List<IPComplaint>();
    List<Examination> lstNegativeExamination = new List<Examination>();

    List<PatientHistoryExt> lstPatientHistoryExt = new List<PatientHistoryExt>();

    List<RoomMaster> lstRoomMaster = new List<RoomMaster>();
    List<InPatientNumber> lstInPatientNumber = new List<InPatientNumber>();

    List<DischargeConfig> lstDischargeConfig = new List<DischargeConfig>();
    List<DischargeConfig> lstAllDischargeConfig = new List<DischargeConfig>();

    List<OperationNotes> lstOperationNotesForDS = new List<OperationNotes>();
   
    List<GeneralAdvice> lstGeneralAdvice = new List<GeneralAdvice>();
    List<DischargeInvNotes> lstDischargeInvNotes = new List<DischargeInvNotes>();

    #endregion

    IP_BL objIP_BL ;
    long retCode = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        objIP_BL = new IP_BL(base.ContextInfo);

        if (!IsPostBack)
        {
            VistType = Request.QueryString["vType"];

            if (VistType == "IP")
            {
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);

                //GetMLCDetails();
               // GetIPOrganDonation();
                GetDeathRegForUpdate();
                GetInpatientDetails();
                GetDischargeSummaryCaseSheet();
                GetPatientHistory();
               
            }

            if (Request.QueryString["page"] == "ICD")
            {
                btnPrint.Visible = false;
                btnEdit.Visible = false;
                btnCancel.Visible = false;
               // LeftMenu1.Visible = false;
                MainHeader.Visible = false;

            }
        }
    }
    private void GetInpatientDetails()
    {
        returnCode = -1;
        returnCode = new Neonatal_BL(base.ContextInfo).GetInpatientDetails(patientVisitID, out lstPatient, out lstIPAdmissionDetails);

        if (lstPatient.Count > 0)
        {
            if (OrgID == 26)
            {
                lblPatientDetail.Text = lstPatient[0].TitleName + lstPatient[0].Name + ","  + lstPatient[0].Age + "/"  + lstPatient[0].SEX + "," + "  Patient ID : " + lstPatient[0].PatientNumber.ToString() + "," + "  IP NO : " + lstPatient[0].IPNumber;
            }
            else
            {
                lblPatientDetail.Text = lstPatient[0].TitleName + lstPatient[0].Name + "," + lstPatient[0].Age + "/" + lstPatient[0].SEX + "," + "  Patient ID-" + lstPatient[0].PatientNumber.ToString();
            }

           
        }

    }
    //public void GetIPOrganDonation()
    //{
    //    retCode = -1;
    //    retCode = objIP_BL.GetIPOrganDonation(patientID, out lstOrgRegWithMapping);
    //    if (lstOrgRegWithMapping.Count > 0)
    //    {
    //        trOD.Style.Add("display", "block");           

    //        TableRow rowH = new TableRow();
    //        TableCell cellH1 = new TableCell();
    //        TableCell cellH2 = new TableCell();           
    //        cellH1.Attributes.Add("align", "left");
    //        cellH1.Text = "Organ Name";
    //        cellH2.Attributes.Add("align", "left");
    //        cellH2.Text = "Organ Registred With";          
    //        rowH.Cells.Add(cellH1);
    //        rowH.Cells.Add(cellH2);           
    //        rowH.Font.Bold = true;
    //        rowH.Style.Add("color", "#000");
    //        tblOD.Rows.Add(rowH);

    //        foreach (var oOrgan in lstOrgRegWithMapping)
    //        {

    //            TableRow row1 = new TableRow();
    //            TableCell cell1 = new TableCell();
    //            TableCell cell2 = new TableCell();               
    //            cell1.Attributes.Add("align", "left");
    //            cell1.Text = oOrgan.OrganName;
    //            cell2.Attributes.Add("align", "left");
    //            cell2.Text = oOrgan.OrganRegWith;              
    //            row1.Cells.Add(cell1);
    //            row1.Cells.Add(cell2);  
    //            row1.Style.Add("color", "#000");
    //            tblOD.Rows.Add(row1);


    //        }

    //    }
    //}
    //public void GetMLCDetails()
    //{
    //    retCode = -1;
    //    retCode = objIP_BL.GetMLCDetails(patientVisitID, out lstRTAMLCDetails);
    //    if (lstRTAMLCDetails.Count > 0)
    //    {
    //            trMLC.Style.Add("display", "block");

    //            if (lstRTAMLCDetails[0].RTAMLCDate != null)
    //                {
    //                lblEventDateD.Text =": "+ lstRTAMLCDetails[0].RTAMLCDate.ToString();
    //                }
    //                else
    //                {
    //                    lblEventDateD.Text = ":-";
    //                }
    //                if (lstRTAMLCDetails[0].FIRDate != DateTime.MinValue)
    //                {
    //                    lblFIRNDateD.Text = ": " + lstRTAMLCDetails[0].FIRDate.ToString();
    //                }
    //                else
    //                {
    //                    lblFIRNDateD.Text = ":-";
    //                }
    //                if (lstRTAMLCDetails[0].FIRNo != "")
    //                {
    //                    lblFIRNOD.Text = ": " + lstRTAMLCDetails[0].FIRNo;
    //                }
    //                else
    //                {
    //                    lblFIRNOD.Text = ":-";
    //                }
    //                if (lstRTAMLCDetails[0].Location != "")
    //                {
    //                    lblEventLocationD.Text = ": " + lstRTAMLCDetails[0].Location;
    //                }
    //                else
    //                {
    //                    lblEventLocationD.Text = ":-";
    //                }
    //                if (lstRTAMLCDetails[0].PoliceStation != "")
    //                {
    //                    lblPSD.Text = ": " + lstRTAMLCDetails[0].PoliceStation;
    //                }
    //                else
    //                {
    //                    lblPSD.Text = ":-";
    //                }
    //                if (lstRTAMLCDetails[0].MLCNo != "")
    //                {
    //                    lblPCD.Text = ": " + lstRTAMLCDetails[0].MLCNo;
    //                }
    //                else
    //                {
    //                    lblPCD.Text = ":-";
    //                }
                  
                
    //    }
    //}

    public void GetDeathRegForUpdate()
    {
        retCode = -1;
        retCode = objIP_BL.GetDeathRegForUpdate(patientVisitID, out lstDeathRegistration, out lstCauseOfDeath, out lstPatientHisAttributes);

        if (lstDeathRegistration.Count > 0)
        {
            trDOD.Style.Add("display", "block");
            lblDOD.Text = " : "+lstDeathRegistration[0].DOD.ToString("dd/MM/yyyy hh:mm tt");

            if (lstDeathRegistration[0].PlaceName!=null)
            {
                trPOC.Style.Add("display", "block");
                if (lstDeathRegistration[0].PlaceName == "Others")
                {
                    lblPOC.Text = " : " + lstDeathRegistration[0].PlaceOfDeathDes;
                }
                else
                {
                    lblPOC.Text = " : " + lstDeathRegistration[0].PlaceName;
                }
            }

            if (lstDeathRegistration[0].DeathTypeName !=null)
            {
                trTODS.Style.Add("display", "block");
                if (lstDeathRegistration[0].DeathTypeName == "Others")
                {
                    lblTOD.Text = " : " + lstDeathRegistration[0].DeathTypeDes;
                }
                else
                {
                    lblTOD.Text = " : " + lstDeathRegistration[0].DeathTypeName;
                }
            }

            //if (lstDeathRegistration[0].IsResuscitation.Trim() == "Y")
            //{
            //    trRAS.Style.Add("display", "block");
            //    tr1RAS.Style.Add("display", "block");
            //    if (lstDeathRegistration[0].LifeSupportID != 0)
            //    {
            //        lblRADyes.Text = "Resuscitation And Support  " + "(" + lstDeathRegistration[0].LifeSupportName.ToString() + ")";
            //    }
            //    else
            //    {
            //        lblRADyes.Text = "Resuscitation And Support";
            //    }
            //}

            //if (lstDeathRegistration[0].IsROSC.Trim() == "Y")
            //{
              
            //    trRAS.Style.Add("display", "block");
            //    tr1ROSC.Style.Add("display", "block");
            //    if (lstDeathRegistration[0].RoscDescription != "")
            //    {
            //        lblROSC.Text = "ROSC " + "(" + lstDeathRegistration[0].RoscDescription + " min )";
            //    }
            //    else
            //    {
            //        lblROSC.Text = "ROSC";
            //    }
            //}

            if (lstDeathRegistration[0].IsPregnancy.Trim() == "Y")
            {
                tr1DAP.Style.Add("display", "block");
                trBP.Style.Add("display", "block");
                if (lstDeathRegistration[0].PregnancyStatus == "Delivered" && lstDeathRegistration[0].PregnancyDescription!="")
                {
                    lblType.Text = " : "+lstDeathRegistration[0].PregnancyStatus + "(" + lstDeathRegistration[0].PregnancyDescription + ")";
                }
                else if (lstDeathRegistration[0].PregnancyStatus != "Delivered")
                {
                    lblType.Text = " : " + lstDeathRegistration[0].PregnancyStatus;
                }
                else
                {
                    lblType.Text = " : " + lstDeathRegistration[0].PregnancyStatus;
                }
            }

            string HospitalCourse = lstDeathRegistration[0].HospitalCourse;

            if (HospitalCourse != string.Empty)
            {
                trCourseHospital.Style.Add("display", "block");
                ltrHospitalcourse.Text = lstDeathRegistration[0].HospitalCourse;

            }

            string ProcedureDesc = lstDeathRegistration[0].ProcedureDesc;

            if (ProcedureDesc != string.Empty)
            {
                trProc.Style.Add("display", "block");
                lblProc.Text = lstDeathRegistration[0].ProcedureDesc;
            }
           

        }



        if (lstCauseOfDeath.Count > 0)
        {

            var PCOD = from lstPCOD in lstCauseOfDeath
                       where lstPCOD.CauseOfDeathType == "CODP"
                       select lstPCOD;


            if (PCOD.Count() > 0)
            {
                trPCOD.Style.Add("display", "block");
                foreach (var objCOD in PCOD)
                {

                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    cell1.Attributes.Add("align", "left");
                    cell1.Text = "<li type=a>" + objCOD.ComplaintName;
                    row1.Cells.Add(cell1);
                    row1.Style.Add("color", "#000");
                    tblPCOD.Rows.Add(row1);
                }
            }


            var SCOD = from lstSCOD in lstCauseOfDeath
                       where lstSCOD.CauseOfDeathType == "CODS"
                       select lstSCOD;

            if (SCOD.Count() > 0)
            {
                trSCOD.Style.Add("display", "block");
                foreach (var objCOD in SCOD)
                {

                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    cell1.Attributes.Add("align", "left");
                    cell1.Text = "<li type=a>" + objCOD.ComplaintName;
                    row1.Cells.Add(cell1);
                    row1.Style.Add("color", "#000");
                    tblSCOD.Rows.Add(row1);
                }
            }


            var ACOD = from lstACOD in lstCauseOfDeath
                       where lstACOD.CauseOfDeathType == "CODA"
                       select lstACOD;


            if (ACOD.Count() > 0)
            {
                trACOD.Style.Add("display", "block");
                foreach (var objCOD in ACOD)
                {

                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    cell1.Attributes.Add("align", "left");
                    cell1.Text = "<li type=a>" + objCOD.ComplaintName;
                    row1.Cells.Add(cell1);
                    row1.Style.Add("color", "#000");
                    tblACOD.Rows.Add(row1);
                }
            }



           

        }

        if (lstPatientHisAttributes.Count > 0)
        {
            for (int i = 0; i < lstPatientHisAttributes.Count(); i++)
            {
                #region Tobacco Chewing
               
                if (lstPatientHisAttributes[i].HistoryID == 1068)
                {
                    trtrTC.Style.Add("display", "block");
                    trBP.Style.Add("display", "block");
                    if (lstPatientHisAttributes[i].AttributeID == 25)
                    {
                        if (strTC != string.Empty)
                        {
                            strTC = lstPatientHisAttributes[i].AttributeValueName + strTC;
                        }
                        else
                        {
                            strTC = lstPatientHisAttributes[i].AttributeValueName;
                        }
                       
                        
                    }
                    if (lstPatientHisAttributes[i].AttributeID == 24)
                    {
                        strTC =" for  "+ lstPatientHisAttributes[i].AttributeValueName;
                    }
                }
                #endregion     
         
                #region Tobacco Smoking
                if (lstPatientHisAttributes[i].HistoryID == 476)
                {
                    trSMK.Style.Add("display", "block");
                    trBP.Style.Add("display", "block");
                    if (lstPatientHisAttributes[i].AttributeID == 3)
                    {
                        if (strTS != string.Empty)
                        {
                            strTS = lstPatientHisAttributes[i].AttributeValueName + strTS;
                        }
                        else
                        {
                            strTS = lstPatientHisAttributes[i].AttributeValueName;
                        }


                    }
                    if (lstPatientHisAttributes[i].AttributeID ==2)
                    {
                        strTS = " for  " + lstPatientHisAttributes[i].AttributeValueName;
                    }
                }
                #endregion


                #region Alcohol
                if (lstPatientHisAttributes[i].HistoryID == 369)
                {
                    trAL.Style.Add("display", "block");
                    trBP.Style.Add("display", "block");
                    if (lstPatientHisAttributes[i].AttributeID == 6)
                    {
                        if (strAlco != string.Empty)
                        {
                            strAlco = lstPatientHisAttributes[i].AttributeValueName + strAlco;
                        }
                        else
                        {
                            strAlco = lstPatientHisAttributes[i].AttributeValueName;
                        }


                    }
                    if (lstPatientHisAttributes[i].AttributeID == 5)
                    {
                        strAlco = " for  " + lstPatientHisAttributes[i].AttributeValueName;
                    }
                }


                if (lstPatientHisAttributes[i].HistoryID == 411)
                {
                    trID.Style.Add("display", "block");
                    trBP.Style.Add("display", "block");
                    if (lstPatientHisAttributes[i].AttributeID == 26)
                    {
                        lblIDD.Text =" : "+lstPatientHisAttributes[i].AttributeValueName;
                    }
                }
                #endregion
            }

            lblTCD.Text =" : "+ strTC;
            lblSMKD.Text = " : " + strTS;
            lblALD.Text = " : " + strAlco;
             

        }

    }



    private void GetDischargeSummaryCaseSheet()
    {
        try
        {
            returnCode = objIP_BL.GetDischargeSummaryCaseSheet(patientVisitID, OrgID, out lsPatient, out lstInPatientAdmissionDetails, out lstOperationNotes, out lstDischargeSummary, out lstPatientComplaint, out lstCaserecordIPTreatmentPlan, out lstBackgroundProblem, out lstVitalsUOMJoin, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstOperationIPTreatmentPlan, out lstAdmissionDate, out lstPatientAddress, out lstDischargeVitalsUOMJoin, out lstPatientVitalsCount, out lstNegativeIPComplaint, out lstNegativeExamination, out lstPatientHistoryExt, out lstRoomMaster, out lstInPatientNumber, out lstGeneralAdvice, out lstDischargeInvNotes,out OrthoCount);


            objIP_BL.GetOperationNotesForDS(patientVisitID, OrgID, out lstOperationNotesForDS);

            if (returnCode == 0)
            {
                if (lstPatientHistoryExt.Count > 0)
                {
                    ltrDetailHistory.Text = lstPatientHistoryExt[0].DetailHistory;
                }   

                string primaryConsultant = string.Empty;

             
                    List<PrimaryConsultant> lstPrimaryConsultant = new List<PrimaryConsultant>();
                    returnCode = new Patient_BL(base.ContextInfo).GetPrimaryConsultant(patientVisitID, 1, out lstPrimaryConsultant);

                    if (lstPrimaryConsultant.Count > 0)
                    {
                        foreach (PrimaryConsultant objPC in lstPrimaryConsultant)
                        {
                            if (primaryConsultant == "")
                            {
                                primaryConsultant = objPC.PhysicianName;
                            }
                            else
                            {
                                primaryConsultant += " , " + objPC.PhysicianName;
                            }

                        }
                    }

                    if (primaryConsultant != "")
                    {
                        //trCPhysician.Style.Add("display", "none");
                        //lblCPhysician.Text = "Dr." + lstInPatientAdmissionDetails[0].PrimaryPhysicianName;
                        trPCON.Style.Add("display", "block");
                        lblPCON.Text = primaryConsultant;
                        //lblCI.Text = primaryConsultant;
                    }
                         

               


                if (lstAdmissionDate.Count > 0)
                    {
                        if (lstAdmissionDate[0].AdmissionDate == DateTime.MinValue)
                        {
                            lblDOA.Text = "";
                        }
                        else
                        {
                            trDOA.Style.Add("display", "block");
                            lblDOA.Text = lstAdmissionDate[0].AdmissionDate.ToString("dd/MM/yyyy hh:mm tt");
                        }
                    }
              

              
                    if (lstOperationNotes.Count > 0)
                    {
                        trDOS.Style.Add("display", "block");
                        string OpertionDate = string.Empty;
                        foreach (var objIPitem in lstOperationNotes)
                        {
                            if (OpertionDate == "")
                            {
                                if (objIPitem.FromTime != DateTime.MinValue)
                                {
                                    OpertionDate = objIPitem.FromTime.ToString("dd/MM/yyyy hh:mm tt");
                                }
                            }
                            else
                            {

                                if (objIPitem.FromTime != DateTime.MinValue)
                                {
                                    OpertionDate += ", " + objIPitem.FromTime.ToString("dd/MM/yyyy hh:mm tt");
                                }


                            }

                        }

                        lblDOS.Text = OpertionDate;


                    }
             


                if (lstPatientAddress.Count > 0)
                {

                    var NeedPermenantAddress = from res in lstAllDischargeConfig
                                               where res.DischargeConfigKey == "NeedPermenantAddress"
                                                      && res.DischargeConfigValue == "N"
                                               select res;

                    if (NeedPermenantAddress.Count() == 0)
                    {

                        string ppermenantAddress = string.Empty;

                        foreach (var oPatientAddress in lstPatientAddress)
                        {
                            if (oPatientAddress.AddressType == "P" && oPatientAddress.Add2 != "")
                            {
                                ppermenantAddress = oPatientAddress.Add1 + "," + oPatientAddress.Add2 + "," + oPatientAddress.Add3 + "," + oPatientAddress.City + "," + oPatientAddress.PostalCode + "," + oPatientAddress.StateName + "," + oPatientAddress.CountryName + "," + oPatientAddress.MobileNumber + "," + oPatientAddress.LandLineNumber;


                            }

                        }
                        string[] PAdd = ppermenantAddress.Split(',');
                        string paddress = string.Empty;
                        if (PAdd.Length > 1)
                        {
                            trAddress.Style.Add("display", "block");
                            tdPermenantAddress.Style.Add("display", "block");
                            foreach (string sPAdd in PAdd)
                            {
                                if (sPAdd != "")
                                {
                                    if (paddress == "")
                                    {
                                        paddress = sPAdd;
                                    }
                                    else
                                    {
                                        paddress += " ," + sPAdd;
                                    }
                                }
                            }

                            TableRow row1 = new TableRow();
                            TableCell cell1 = new TableCell();
                            cell1.Attributes.Add("align", "left");
                            cell1.Text = paddress + ".";
                            row1.Cells.Add(cell1);
                            row1.Style.Add("color", "#000");
                            tblPermenantAddress.Rows.Add(row1);
                        }
                    }
                }

                if (lstPatientAddress.Count > 0)
                {


                    string pPresentAddress = string.Empty;
                    foreach (var oPatientAddress in lstPatientAddress)
                    {
                        if (oPatientAddress.AddressType == "C" && oPatientAddress.Add2 != "")
                        {
                            pPresentAddress = oPatientAddress.Add1 + "," + oPatientAddress.Add2 + "," + oPatientAddress.Add3 + "," + oPatientAddress.City + "," + oPatientAddress.PostalCode + "," + oPatientAddress.StateName + "," + oPatientAddress.CountryName + "," + oPatientAddress.MobileNumber + "," + oPatientAddress.LandLineNumber;
                        }

                    }
                    string[] PAdd = pPresentAddress.Split(',');
                    string caddress = string.Empty;

                    if (PAdd.Length > 1)
                    {
                        tdPresentAddress.Style.Add("display", "block");
                        foreach (string sPAdd in PAdd)
                        {
                            if (sPAdd != "")
                            {
                                if (caddress == "")
                                {
                                    caddress = sPAdd;
                                }
                                else
                                {
                                    caddress += " ," + sPAdd;
                                }
                            }
                        }

                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        cell1.Attributes.Add("align", "left");
                        cell1.Text = caddress + ".";
                        row1.Cells.Add(cell1);
                        row1.Style.Add("color", "#000");
                        tblPresentAddress.Rows.Add(row1);
                    }
                }






                if (lstBackgroundProblem.Count > 0)
                {
                    trBackgroundProblem.Style.Add("display", "block");
                    foreach (var oBackgroundProblem in lstBackgroundProblem)
                    {
                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        if (oBackgroundProblem.Description != "")
                        {
                            if (oBackgroundProblem.ComplaintName == "Stroke(CVA)")
                            {
                                string[] PStroke = oBackgroundProblem.Description.Split('^');
                                if (PStroke[0].Contains('/'))
                                {
                                    cell1.Attributes.Add("align", "left");
                                    cell1.Text = "<li type=a>" + oBackgroundProblem.ComplaintName + " - " + PStroke[0] + "," + PStroke[1];
                                }
                                else
                                {
                                    cell1.Attributes.Add("align", "left");
                                    cell1.Text = "<li type=a>" + oBackgroundProblem.ComplaintName + " - " + PStroke[1];
                                }

                            }
                            else
                            {
                                cell1.Attributes.Add("align", "left");
                                cell1.Text = "<li type=a>" + oBackgroundProblem.ComplaintName + " - " + oBackgroundProblem.Description;
                            }
                        }
                        else
                        {
                            cell1.Attributes.Add("align", "left");
                            cell1.Text = "<li type=a>" + oBackgroundProblem.ComplaintName;
                        }
                        row1.Cells.Add(cell1);
                        row1.Style.Add("color", "#000");
                        tblBackgroundProblems.Rows.Add(row1);
                    }
                }




                if (lstVitalsUOMJoin.Count > 0)
                {
                    trgeneralExam.Style.Add("display", "block");




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
                    tblgeneralExamination.Rows.Add(rowH);


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
                        //cell2.Attributes.Add("align", "left");
                        //cell2.Text = resVitalsvalue[1] + " " + resVitalsunit[1];
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
                        //cell3.Attributes.Add("align", "left");
                        //cell3.Text = resVitalsvalue[2] + " " + resVitalsunit[2];

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
                        //cell4.Attributes.Add("align", "left");
                        //cell4.Text = resVitalsvalue[3] + " " + resVitalsunit[3];
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
                        //cell8.Attributes.Add("align", "left");
                        //cell8.Text = resVitalsvalue[7] + " " + resVitalsunit[7];
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
                    tblgeneralExamination.Rows.Add(row1);

                }




                if (lstPatientExamination.Count > 0)
                {
                    TableRow row2 = new TableRow();
                    TableCell cell2 = new TableCell();
                    cell2.Attributes.Add("align", "left");
                    string pSwollen = string.Empty;
                    string resSwollen = string.Empty;
                    foreach (var oPatientExamination in lstPatientExamination)
                    {

                        if (oPatientExamination.Description == "")
                        {
                            if (oPatientExamination.ExaminationName.Contains("Swollen"))
                            {
                                if (pSwollen == string.Empty)
                                {
                                    pSwollen = oPatientExamination.ExaminationName;
                                }
                                else
                                {
                                    pSwollen = pSwollen + "," + oPatientExamination.ExaminationName;
                                }

                            }
                            else
                            {
                                if (oPatientExamination.ExaminationName != "CVS" && oPatientExamination.ExaminationName != "RS" && oPatientExamination.ExaminationName != "ABD" && oPatientExamination.ExaminationName != "CNS" && oPatientExamination.ExaminationName != "P/R" && oPatientExamination.ExaminationName != "Genitalia" && oPatientExamination.ExaminationName != "Others")

                                    cell2.Text = oPatientExamination.ExaminationName + " ," + cell2.Text;
                            }
                        }

                    }

                    string[] splitSwollen = pSwollen.Split(',');
                    if (splitSwollen.Length > 1)
                    {
                        foreach (var pSwollenitems in splitSwollen)
                        {
                            string[] rowSplit = pSwollenitems.Split(' ');
                            if (rowSplit[2] == "Lymph")
                            {
                                if (resSwollen == string.Empty)
                                {
                                    resSwollen = "Swollen Lymph Nodes" + "(" + rowSplit[1];
                                }
                                else
                                {
                                    resSwollen = resSwollen + "," + rowSplit[1];
                                }

                            }
                        }

                        cell2.Text = cell2.Text + resSwollen + ")" + "+";
                    }

                    else
                    {
                        if (splitSwollen.Length == 1)
                        {
                            resSwollen = splitSwollen[0];
                            cell2.Text = cell2.Text + resSwollen;
                        }
                        else if (splitSwollen.Length == 0)
                        {
                            cell2.Text = cell2.Text;
                        }

                    }


                    var NeedGeneralExaminationInDSY = from res in lstAllDischargeConfig
                                                      where res.DischargeConfigKey == "NeedGeneralExaminationInDSY"
                                                            && res.DischargeConfigValue == "N"
                                                      select res;


                    if (NeedGeneralExaminationInDSY.Count() == 0)
                    {

                        if (NeedGeneralExaminationInDSY.Count() == 0)
                        {
                            if (cell2.Text != "")
                            {
                                trGeneralExamination.Style.Add("display", "block");
                                row2.Cells.Add(cell2);
                                row2.Style.Add("color", "#000");
                                tblGeneralExam.Rows.Add(row2);
                            }
                        }



                    }





                    foreach (var oPatientExamination in lstPatientExamination)
                    {
                        trSystemicExam.Style.Add("display", "block");
                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        cell1.Attributes.Add("align", "left");
                        if (oPatientExamination.Description != "")
                        {
                            cell1.Text = oPatientExamination.ExaminationName + " - " + oPatientExamination.Description;

                        }


                        row1.Cells.Add(cell1);
                        row1.Style.Add("color", "#000");
                        tblSystamaticExamination.Rows.Add(row1);
                    }

                }

            }
        }

        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in GetDeathCaseSheeDetailst.aspx", ex);
        }

    }

    private void GetPatientHistory()
    {
        try
        {
            returnCode = objIP_BL.GetPatientHistory(patientVisitID, OrgID, out lstPatientHistory);
                if (lstPatientHistory.Count > 0)
                {
                    trHistory.Style.Add("display", "block");
                    TableRow row2 = new TableRow();
                    TableCell cell2 = new TableCell();
                    cell2.Attributes.Add("align", "left");
                    string PatientHistory = string.Empty;
                    string Age = string.Empty;
                    foreach (var oPatientHistory in lstPatientHistory)
                    {
                        if (PatientHistory == string.Empty)
                        {

                            if (oPatientHistory.HistoryName != string.Empty)
                            {
                                if (oPatientHistory.Description != " ")
                                {
                                    PatientHistory = oPatientHistory.HistoryName + "(" + oPatientHistory.Description + ")";
                                }
                                else
                                {
                                    PatientHistory = oPatientHistory.HistoryName;
                                }
                            }

                        }

                        else
                        {

                            if (oPatientHistory.HistoryName != string.Empty)
                            {
                                if (oPatientHistory.Description != " ")
                                {
                                    PatientHistory = PatientHistory + " , " + oPatientHistory.HistoryName + "(" + oPatientHistory.Description + ")";
                                }
                                else
                                {
                                    PatientHistory = PatientHistory + " , " + oPatientHistory.HistoryName;
                                }
                            }

                        }

                    }

                    if (lsPatient.Count > 0)
                    {

                        string[] Age1 = lsPatient[0].Age.Split(' ');
                        if (lsPatient[0].SEX == "M")
                        {
                            if (int.Parse(Age1[0]) > 18 && Age1[1] == "Year(s)")
                            {
                                Age = lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "Man presented with history of" + " ";
                            }
                            else
                            {
                                Age = lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "old Boy presented with history of" + " ";

                            }

                        }
                        else if (lsPatient[0].SEX == "F")
                        {
                            if (int.Parse(Age1[0]) > 18 && Age1[1] == "Year(s)")
                            {
                                Age = lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "lady presented with history of" + " ";
                            }
                            else
                            {
                                Age = lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "old girl presented with history of" + " ";

                            }
                        }
                    }
                    cell2.Text = Age + PatientHistory + ".";


                    row2.Cells.Add(cell2);
                    row2.Style.Add("color", "#000");
                    tblHistory.Rows.Add(row2);

                }

    

            // Org Header


            //List<Config> lstConfig = new List<Config>();
            //new GateWay(base.ContextInfo).GetConfigDetails("OrgAddress", OrgID, out lstConfig);
            new GateWay(base.ContextInfo).GetDischargeConfigDetails("OrgAddress", OrgID, out lstDischargeConfig);
            if (lstDischargeConfig.Count > 0)
            {

                lblHospitalName.Text = OrgName + "<br/>" + lstDischargeConfig[0].DischargeConfigValue.Trim();
            }

            //new GateWay(base.ContextInfo).GetConfigDetails("BillPrintLogo", OrgID, out lstConfig);

            new GateWay(base.ContextInfo).GetDischargeConfigDetails("DischargeLogo", OrgID, out lstDischargeConfig);

            if (lstDischargeConfig.Count > 0)
            {
                //tbl1.Style.Add("background-image", "url('" + lstConfig[0].ConfigValue.Trim() + "'); ");
                imgBillLogo.ImageUrl = lstDischargeConfig[0].DischargeConfigValue.Trim();
                imgBillLogo.Visible = true;
            }
        }

        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error on Loading DeathCaseheet in DeathCaseSheet.aspx", ex);
        }
    }         

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);

        try
        {
            Response.Redirect("../InPatient/DeathRegistration.aspx?&vid=" + patientVisitID + "&pid=" + patientID, true);

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Displaying DeathRegistration.aspx  page", ex);
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
                Response.Redirect(Request.ApplicationPath  + relPagePath, true);
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
