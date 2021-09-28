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
using System.Xml;
using System.IO;
using System.Xml.Linq;


public partial class DischargeSummary_DischargeSummaryDynamic : BasePage
{
    public DischargeSummary_DischargeSummaryDynamic(): base("DischargeSummary\\DischargeSummaryDynamic.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }



    #region declaration
    long patientID = -1;
    long patientVisitID = 0;
    long returnCode = -1;
    string VistType = string.Empty;
    string IpNumber = string.Empty;
    string primaryConsultant = string.Empty;
    string DischargeConfigs = string.Empty;
    string PreOpInv = string.Empty, PostOpInv = string.Empty, RoutineInv = string.Empty;
    int OrthoCount = -1;

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

    List<DischargeSummarySeq> lstDischargeSummarySeq = new List<DischargeSummarySeq>();

    List<GeneralAdvice> lstGeneralAdvice = new List<GeneralAdvice>();
    List<PrimaryConsultant> lstPrimaryConsultant = new List<PrimaryConsultant>();
    List<DischargeInvNotes> lstDischargeInvNotes = new List<DischargeInvNotes>();



    IP_BL oIP_BL ;

    #endregion


    protected void Page_Load(object sender, EventArgs e)
    {
        oIP_BL = new IP_BL(base.ContextInfo);
        try
        {
            new GateWay(base.ContextInfo).GetAllDischargeConfig(OrgID, out DischargeConfigs, out lstAllDischargeConfig);

            //var NeedKDRDSY = from res in lstAllDischargeConfig
            //                 where res.DischargeConfigKey == "NeedKDRDDischargeSummary"
            //                             && res.DischargeConfigValue == "Y"
            //                                    select res;

            var NeedRaksithDSY = from res in lstAllDischargeConfig
                                 where res.DischargeConfigKey == "NeedRaksithDischargeSummary"
                                         && res.DischargeConfigValue == "Y"
                                 select res;


            if (NeedRaksithDSY.Count() > 0)
            {
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                Response.Redirect("../InPatient/RakshithDischargeSummary.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&vType=" + "IP", true);

            }

            //if (NeedKDRDSY.Count() > 0)
            //{
            //    Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            //    Int64.TryParse(Request.QueryString["pid"], out patientID);
            //    Response.Redirect("../InPatient/KDRDischargeSummary.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&vType=" + "IP", true);

            //}
            VistType = Request.QueryString["vType"];
            if (VistType == "IP")
            {
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                patientHeader.PatientID = patientID;
                patientHeader.PatientVisitID = patientVisitID;
                patientHeader.ShowVitalsDetails();
                returnCode = oIP_BL.GetDischargeSummaryDetailsForupdate(patientVisitID, out lstDischargeSummary,out lstDischargeInvNotes);


                if (lstDischargeSummary.Count > 0)
                {
                    if (lstDischargeSummary[0].SummaryStatus == "Completed" && RoleName != "Administrator")
                    {
                        btnEdit.Visible = false;
                    }
                    else
                    {
                        btnEdit.Visible = true;
                    }

                }
            }
            else
            {
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                oIP_BL.GetPatientDischargeDetailByPatientID(patientID, out lstDischargeSummaryByPatientID);
                //gvDischargeDetail.DataSource = lstDischargeSummaryByPatientID;
                //gvDischargeDetail.DataBind();
                tblSave.Style.Add("display", "none");
                tblDischrageResult.Style.Add("display", "none");           

            }

            if (!IsPostBack)
            {
                if (VistType == "IP")
                {
                    //tblDischargeDetail.Style.Add("display", "none");
                    GetPatientHistory();
                    GetDischargeSummaryCaseSheet();
                   
                }

                if (Request.QueryString["page"] == "ICD")
                {
                    btnPrint.Visible = false;
                    btnEdit.Visible = false;
                    btnCancel.Visible = false;
                    //LeftMenu1.Visible = false;
                    MainHeader.Visible = false;

                }
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in DischargeSummaryCaseSheetDynamic.aspx:Page_Load", ex);
        }
    }


    private void GetPatientHistory()
    {
        try
        {
            returnCode = oIP_BL.GetPatientHistory(patientVisitID, OrgID, out lstPatientHistory);
            new GateWay(base.ContextInfo).GetAllDischargeConfig(OrgID, out DischargeConfigs, out lstAllDischargeConfig);

            var NeedHistoryInDSY = from res in lstAllDischargeConfig
                                   where res.DischargeConfigKey == "NeedHistoryInDSY"
                                            && res.DischargeConfigValue == "N"
                                   select res;

        }

        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error on Loading DischargeSummarySheet in DischargeSummaryCaseSheetDynamic.aspx", ex);
        }
    }

    private void GetDischargeSummaryCaseSheet()
    {
        try
        {
            oIP_BL.GetDischargeSummarySeq(OrgID, out lstDischargeSummarySeq);

            returnCode = oIP_BL.GetDischargeSummaryCaseSheet(patientVisitID, OrgID, out lsPatient, out lstInPatientAdmissionDetails, out lstOperationNotes, out lstDischargeSummary, out lstPatientComplaint, out lstCaserecordIPTreatmentPlan, out lstBackgroundProblem, out lstVitalsUOMJoin, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstOperationIPTreatmentPlan, out lstAdmissionDate, out lstPatientAddress, out lstDischargeVitalsUOMJoin, out lstPatientVitalsCount, out lstNegativeIPComplaint, out lstNegativeExamination, out lstPatientHistoryExt, out lstRoomMaster, out lstInPatientNumber, out lstGeneralAdvice, out lstDischargeInvNotes, out OrthoCount);

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

            if (lstDischargeInvNotes.Count > 0)
            {
                foreach (DischargeInvNotes ItemDIN in lstDischargeInvNotes)
                {
                    if (ItemDIN.Type == "PreOpInv")
                    {

                        PreOpInv = ItemDIN.InvestigationDetails;

                    }
                    else if (ItemDIN.Type == "PostOpInv")
                    {

                        PostOpInv = ItemDIN.InvestigationDetails;

                    }
                    else if (ItemDIN.Type == "RoutineInv")
                    {

                        RoutineInv = ItemDIN.InvestigationDetails;

                    }
                }
            }



            new GateWay(base.ContextInfo).GetAllDischargeConfig(OrgID, out DischargeConfigs, out lstAllDischargeConfig);

            oIP_BL.GetOperationNotesForDS(patientVisitID, OrgID, out lstOperationNotesForDS);

            foreach (DischargeSummarySeq DSS in lstDischargeSummarySeq)
            {
                BindControl(DSS.PlaceHolderID, DSS.ControlName, DSS.HeaderName);

            }

            var NeedDischargeTitle = from res in lstAllDischargeConfig
                                     where res.DischargeConfigKey == "NeedDischargeTitle"
                                            && res.DischargeConfigValue == "N"
                                     select res;


            if (NeedDischargeTitle.Count() == 0)
            {
                if (lstDischargeSummary.Count > 0)
                {
                    trTitle.Style.Add("display", "block");
                    if (lstDischargeSummary[0].DischargeTypeName == "Expired")
                    {
                        string death = Resources.ClientSideDisplayTexts.DischargeSummary_DischargeSummaryDynamic_aspx_cs_death;
                        lblTypeOfDis.Text = death;

                    }
                    else
                    {
                        string discharge = Resources.ClientSideDisplayTexts.DischargeSummary_DischargeSummaryDynamic_aspx_cs_discharge;
                        lblTypeOfDis.Text = discharge;


                    }
                }
            }

            var NeedSeniorMedicalOfficerInDSY = from res in lstAllDischargeConfig
                                                where res.DischargeConfigKey == "NeedSeniorMedicalOfficerInDSY"
                                         && res.DischargeConfigValue == "N"
                                                select res;

            var NeedSeniorMedicalOfficerNameInDSY = from res in lstAllDischargeConfig
                                                    where res.DischargeConfigKey == "NeedSeniorMedicalOfficerNameInDSY"
                                         && res.DischargeConfigValue == "N"
                                                    select res;

            if (NeedSeniorMedicalOfficerInDSY.Count() == 0)
            {

                if (lstInPatientAdmissionDetails.Count > 0)
                {
                    lblSMOT.Visible = true;


                    if (NeedSeniorMedicalOfficerNameInDSY.Count() == 0)
                    {
                        lblSMO.Text = lstInPatientAdmissionDetails[0].DutyOfficer;
                        lblSMO.Visible = true;
                    }

                }
            }


            var NeedConsultantInchargeInDSY = from res in lstAllDischargeConfig
                                              where res.DischargeConfigKey == "NeedConsultantInchargeInDSY"
                                         && res.DischargeConfigValue == "N"
                                              select res;

            var NeedConsultantInchargeNameInDSY = from res in lstAllDischargeConfig
                                                  where res.DischargeConfigKey == "NeedConsultantInchargeNameInDSY"
                                         && res.DischargeConfigValue == "N"
                                                  select res;

            if (NeedConsultantInchargeInDSY.Count() == 0)
            {
                lblCIT.Visible = true;

                if (primaryConsultant != "")
                {
                    if (NeedConsultantInchargeNameInDSY.Count() == 0)
                    {
                        lblCI.Text = primaryConsultant;
                        lblCI.Visible = true;
                    }
                }
            }


            var NeedPreparedByInDSY = from res in lstAllDischargeConfig
                                      where res.DischargeConfigKey == "NeedPreparedByInDSY"
                                             && res.DischargeConfigValue == "N"
                                      select res;

            if (NeedPreparedByInDSY.Count() == 0)
            {
                if (lstDischargeSummary.Count > 0)
                {
                    lblPreparedBy.Visible = true;
                    lblPreparedByT.Visible = true;
                    lblPreparedBy.Text = lstDischargeSummary[0].PreparedBy;
                }

            }

            var NeedTypedByInDSY = from res in lstAllDischargeConfig
                                   where res.DischargeConfigKey == "NeedTypedByInDSY"
                                          && res.DischargeConfigValue == "N"
                                   select res;
            if (NeedTypedByInDSY.Count() == 0)
            {
                if (lstDischargeSummary.Count > 0)
                {
                    lblTypedBy.Visible = true;
                    lblTypedByT.Visible = true;
                    lblTypedBy.Text = lstDischargeSummary[0].Name;
                }

            }



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



            var NeedHeaderLineInDSY = from res in lstAllDischargeConfig
                                   where res.DischargeConfigKey == "NeedHeaderLineInDSY"
                                          && res.DischargeConfigValue == "N"
                                   select res;


            if (NeedHeaderLineInDSY.Count() > 0)
            {
                trHeaderLine.Style.Add("display", "none");
            }
            else
            {
                trHeaderLine.Style.Add("display", "block");

            }

            var NeedNextReviewDSY = from res in lstAllDischargeConfig
                                      where res.DischargeConfigKey == "NeedNextReviewDSY"
                                             && res.DischargeConfigValue == "N"
                                      select res;
            if (NeedNextReviewDSY.Count() == 0)
            {

                if (lstDischargeSummary.Count > 0)
                {
                 
                    if (lstDischargeSummary[0].NextReviewAfter.Contains("/"))
                    {
                        NextReviewDate.Style.Add("display", "block");
                        NextReviewNotes.Style.Add("display", "block");                       
                        lblNextReview.Text = lstDischargeSummary[0].NextReviewAfter.ToString();

                        if (lstDischargeSummary[0].ReviewReason != "")
                        {
                            trReviewreason.Style.Add("display", "block");
                            lblReviewReason.Text = lstDischargeSummary[0].ReviewReason.ToString();
                        }
                    }
                    else
                    {
                        if (lstDischargeSummary[0].NextReviewAfter != "")
                        {
                            string[] NextReview = lstDischargeSummary[0].NextReviewAfter.Split('-');
                            if ((NextReview[0] != "0") &&( NextReview[1] != "0"))
                            {
                                NextReviewDate.Style.Add("display", "block");
                                NextReviewNotes.Style.Add("display", "block");
                                lblNextReview.Text = "After  " + lstDischargeSummary[0].NextReviewAfter.ToString();

                                if (lstDischargeSummary[0].ReviewReason != "")
                                {
                                    trReviewreason.Style.Add("display", "block");
                                    lblReviewReason.Text = lstDischargeSummary[0].ReviewReason.ToString();
                                }

                            }
                        }
                    }
                }
            }

           


        }

        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in GetDischargeSummaryCaseSheeDetailst.aspx", ex);
        }

    }



    public void BindControl(string PlaceHolderID, string ControlName, string HeaderName)
    {

       

        if (ControlName == "~/DischargeSummary/PatientDetails.ascx")
        {
            if (lsPatient.Count > 0)
            {
                string CustomIPNO = "";
                var NeedCustomIPNOInDSY = from res in lstAllDischargeConfig
                                          where res.DischargeConfigKey == "NeedCustomIPNOInDSY"
                                                 && res.DischargeConfigValue == "Y"
                                          select res;
                if (NeedCustomIPNOInDSY.Count() > 0)
                {
                    if (lstInPatientNumber.Count > 0 && lstInPatientNumber[0].CustomIPNo != "")
                    {
                        CustomIPNO = lstInPatientNumber[0].CustomIPNo;
                    }
                }

                PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                tr.Style.Add("display", "block");
                Control uc = LoadControl(ControlName);
                DischargeSummary_PatientDetails uc1 = (DischargeSummary_PatientDetails)uc;
                uc1.BindPatientDetails(lsPatient, CustomIPNO);
                ph.Controls.Add(uc1);
            }

        }
        if (ControlName == "~/DischargeSummary/KMHPatientDetails.ascx")
        {
                PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                tr.Style.Add("display", "block");
                Control uc = LoadControl(ControlName);
                DischargeSummary_KMHPatientDetails uc1 = (DischargeSummary_KMHPatientDetails)uc;
                uc1.BindPatientDetails(lsPatient, lstAdmissionDate, lstInPatientNumber, lstDischargeSummary, primaryConsultant, lstRoomMaster, lstPatientAddress);
                ph.Controls.Add(uc1);

        }
        else if (ControlName == "~/DischargeSummary/DateOfAdmission.ascx")
        {

            var NeedDateOfAdmission = from res in lstAllDischargeConfig
                                      where res.DischargeConfigKey == "NeedDateOfAdmission"
                                             && res.DischargeConfigValue == "N"
                                      select res;

            var NeedDateOfAdmissionWithOutTime = from res in lstAllDischargeConfig
                                                 where res.DischargeConfigKey == "NeedDateOfAdmissionWithOutTime"
                                             && res.DischargeConfigValue == "Y"
                                                 select res;
            string DOA = string.Empty;
            if (NeedDateOfAdmission.Count() == 0)
            {
                if (lstAdmissionDate.Count > 0)
                {
                    if (lstAdmissionDate[0].AdmissionDate != DateTime.MinValue)
                    {
                        if (NeedDateOfAdmissionWithOutTime.Count() > 0)
                        {
                            DOA = lstAdmissionDate[0].AdmissionDate.ToString("dd/MM/yyyy");
                        }
                        else
                        {
                            DOA = lstAdmissionDate[0].AdmissionDate.ToString("dd/MM/yyyy  hh:mm tt");
                        }
                        if (DOA != "")
                        {
                            PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                            HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                            tr.Style.Add("display", "block");
                            Control uc = LoadControl(ControlName);
                            DischargeSummary_DateOfAdmission uc1 = (DischargeSummary_DateOfAdmission)uc;
                            uc1.BindDateOfAdmission(DOA, HeaderName.ToUpper());
                            ph.Controls.Add(uc1);
                        }
                    }

                }
            }

        }

        else if (ControlName == "~/DischargeSummary/DateOfSurgery.ascx")
        {

            var NeedDateOfSurgery = from res in lstAllDischargeConfig
                                    where res.DischargeConfigKey == "NeedDateOfSurgery"
                                             && res.DischargeConfigValue == "N"
                                    select res;
            var DateOfSurgeryWithOutTime = from res in lstAllDischargeConfig
                                           where res.DischargeConfigKey == "DateOfSurgeryWithOutTime"
                                             && res.DischargeConfigValue == "Y"
                                           select res;

            if (NeedDateOfSurgery.Count() == 0)
            {
                if (lstOperationNotes.Count > 0)
                {

                    string OpertionDate = string.Empty;
                    foreach (var objIPitem in lstOperationNotes)
                    {
                        if (DateOfSurgeryWithOutTime.Count() > 0)
                        {
                            if (OpertionDate == "")
                            {
                                if (objIPitem.FromTime != DateTime.MinValue)
                                {
                                    OpertionDate = objIPitem.FromTime.ToString("dd/MM/yyyy");
                                }
                            }
                            else
                            {

                                if (objIPitem.FromTime != DateTime.MinValue)
                                {
                                    OpertionDate += ", " + objIPitem.FromTime.ToString("dd/MM/yyyy");
                                }


                            }
                        }
                        else
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

                    }

                    if (OpertionDate != "")
                    {
                        PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                        HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                        tr.Style.Add("display", "block");
                        Control uc = LoadControl(ControlName);
                        DischargeSummary_DateOfSurgery uc1 = (DischargeSummary_DateOfSurgery)uc;
                        uc1.BindDateOfSurgery(OpertionDate, HeaderName.ToUpper());
                        ph.Controls.Add(uc1);
                    }


                }
            }

        }

        else if (ControlName == "~/DischargeSummary/DateOfDischarge.ascx")
        {
            var NeedDateOfDischarge = from res in lstAllDischargeConfig
                                      where res.DischargeConfigKey == "NeedDateOfDischarge"
                                             && res.DischargeConfigValue == "N"
                                      select res;

            var DateOfDischargeWithOutTime = from res in lstAllDischargeConfig
                                             where res.DischargeConfigKey == "DateOfDischargeWithOutTime"
                                                    && res.DischargeConfigValue == "Y"
                                             select res;
            if (NeedDateOfDischarge.Count() == 0)
            {
                string DOD = string.Empty;
                if (lstDischargeSummary.Count > 0)
                {
                    if (lstDischargeSummary[0].DateOfDischarge != DateTime.MinValue)
                    {
                        if (DateOfDischargeWithOutTime.Count() > 0)
                        {
                            DOD = lstDischargeSummary[0].DateOfDischarge.ToString("dd/MM/yyyy");
                        }
                        else
                        {
                            DOD = lstDischargeSummary[0].DateOfDischarge.ToString("dd/MM/yyyy hh:mm tt");
                        }
                        if (DOD != "")
                        {
                            PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                            HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                            tr.Style.Add("display", "block");
                            Control uc = LoadControl(ControlName);
                            DischargeSummary_DateOfDischarge uc1 = (DischargeSummary_DateOfDischarge)uc;
                            uc1.BindDateOfDischarge(DOD, HeaderName.ToUpper());
                            ph.Controls.Add(uc1);
                        }
                    }
                }
            }
        }

        else if (ControlName == "~/DischargeSummary/TypeOfDischarge.ascx")
        {
            var NeedyTypeOfDischarge = from res in lstAllDischargeConfig
                                       where res.DischargeConfigKey == "NeedyTypeOfDischarge"
                                              && res.DischargeConfigValue == "N"
                                       select res;
            if (NeedyTypeOfDischarge.Count() == 0)
            {
                if (lstDischargeSummary.Count > 0)
                {
                    string TOD = lstDischargeSummary[0].DischargeTypeName;
                    if (TOD != "")
                    {
                        PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                        HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                        tr.Style.Add("display", "block");
                        Control uc = LoadControl(ControlName);
                        DischargeSummary_TypeOfDischarge uc1 = (DischargeSummary_TypeOfDischarge)uc;
                        uc1.BindTypeOfDischarge(TOD, HeaderName.ToUpper());
                        ph.Controls.Add(uc1);
                    }
                }

            }


        }


        else if (ControlName == "~/DischargeSummary/PrimaryConsultant.ascx")
        {


            var NeedPrimaryConsultant = from res in lstAllDischargeConfig
                                        where res.DischargeConfigKey == "NeedPrimaryConsultant"
                                         && res.DischargeConfigValue == "N"
                                        select res;

            if (NeedPrimaryConsultant.Count() == 0)
            {



                if (primaryConsultant != "")
                {

                    PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                    HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                    tr.Style.Add("display", "block");
                    Control uc = LoadControl(ControlName);
                    DischargeSummary_PrimaryConsultant uc1 = (DischargeSummary_PrimaryConsultant)uc;
                    uc1.BindPrimaryConsultant(primaryConsultant, HeaderName.ToUpper());
                    ph.Controls.Add(uc1);

                }
            }
        }
        else if (ControlName == "~/DischargeSummary/PatientAddress.ascx")
        {

            var NeedPatientAddress = from res in lstAllDischargeConfig
                                     where res.DischargeConfigKey == "NeedPatientAddress"
                                            && res.DischargeConfigValue == "N"
                                     select res;

            if (NeedPatientAddress.Count() == 0)
            {

                if (lstPatientAddress.Count > 0)
                {
                    PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                    HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                    tr.Style.Add("display", "block");
                    Control uc = LoadControl(ControlName);
                    DischargeSummary_PatientAddress uc1 = (DischargeSummary_PatientAddress)uc;
                    uc1.BindAddress(lstPatientAddress, lstAllDischargeConfig, HeaderName.ToUpper());
                    ph.Controls.Add(uc1);



                }
            }
        }
        else if (ControlName == "~/DischargeSummary/ConditionOnDischarge.ascx")
        {
            var NeedConditionOnDischarge = from res in lstAllDischargeConfig
                                           where res.DischargeConfigKey == "NeedConditionOnDischarge"
                                                    && res.DischargeConfigValue == "N"
                                           select res;
            if (NeedConditionOnDischarge.Count() == 0)
            {
                if (lstDischargeSummary.Count > 0)
                {
                    if (lstDischargeSummary[0].ConditionOnDischarge != "")
                    {
                        PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                        HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                        tr.Style.Add("display", "block");
                        Control uc = LoadControl(ControlName);
                        DischargeSummary_ConditionOnDischarge uc1 = (DischargeSummary_ConditionOnDischarge)uc;
                        uc1.BindConditionOnDischarge(lstDischargeSummary[0].ConditionOnDischarge, HeaderName.ToUpper());
                        ph.Controls.Add(uc1);

                    }
                }
            }
        }


        else if (ControlName == "~/DischargeSummary/Diagnose.ascx")
        {
            var NeedDiagnoseInDSY = from res in lstAllDischargeConfig
                                    where res.DischargeConfigKey == "NeedDiagnoseInDSY"
                                           && res.DischargeConfigValue == "N"
                                    select res;

            if (NeedDiagnoseInDSY.Count() == 0)
            {
                if (lstPatientComplaint.Count > 0)
                {
                    PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                    HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                    tr.Style.Add("display", "block");
                    Control uc = LoadControl(ControlName);
                    DischargeSummary_Diagnose uc1 = (DischargeSummary_Diagnose)uc;
                    uc1.BindDiagnose(lstPatientComplaint, patientVisitID, "IP", lstAllDischargeConfig, HeaderName.ToUpper());
                    ph.Controls.Add(uc1);
                }
            }
        }


        else if (ControlName == "~/DischargeSummary/History.ascx")
        {
            var NeedHistoryInDSY = from res in lstAllDischargeConfig
                                   where res.DischargeConfigKey == "NeedHistoryInDSY"
                                            && res.DischargeConfigValue == "N"
                                   select res;

            if (NeedHistoryInDSY.Count() == 0)
            {

                if (lstPatientHistory.Count > 0 || lstPatientHistoryExt.Count > 0)
                {
                    PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                    HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                    tr.Style.Add("display", "block");
                    Control uc = LoadControl(ControlName);
                    DischargeSummary_History uc1 = (DischargeSummary_History)uc;
                    uc1.BindHistory(lstPatientHistory, lsPatient, lstPatientHistoryExt, HeaderName.ToUpper());
                    ph.Controls.Add(uc1);
                }
            }
        }


        else if (ControlName == "~/DischargeSummary/TreatmentPlan.ascx")
        {
            var NeedTreatmentPlanInDSY = from res in lstAllDischargeConfig
                                         where res.DischargeConfigKey == "NeedTreatmentPlanInDSY"
                                                    && res.DischargeConfigValue == "N"
                                         select res;

            if (NeedTreatmentPlanInDSY.Count() == 0)
            {
                if (lstOperationIPTreatmentPlan.Count > 0)
                {
                    PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                    HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                    tr.Style.Add("display", "block");
                    Control uc = LoadControl(ControlName);
                    DischargeSummary_TreatmentPlan uc1 = (DischargeSummary_TreatmentPlan)uc;
                    uc1.BindTreatmentPlan(lstOperationIPTreatmentPlan, HeaderName.ToUpper());
                    ph.Controls.Add(uc1);
                }
            }
        }


        else if (ControlName == "~/DischargeSummary/BackrounMedicalProblem.ascx")
        {
            var NeedBackgroundProblemInDSY = from res in lstAllDischargeConfig
                                             where res.DischargeConfigKey == "NeedBackgroundProblemInDSY"
                                                    && res.DischargeConfigValue == "N"
                                             select res;

            if (NeedBackgroundProblemInDSY.Count() == 0)
            {

                if (lstDischargeSummary.Count > 0)
                {
                    if (lstBackgroundProblem.Count > 0 || lstDischargeSummary[0].PrintNegativeHistory == "Y")
                    {
                        PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                        HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                        tr.Style.Add("display", "block");
                        Control uc = LoadControl(ControlName);
                        DischargeSummary_BackrounMedicalProblem uc1 = (DischargeSummary_BackrounMedicalProblem)uc;
                        uc1.BindBackrounMedicalProblem(lstDischargeSummary, lstNegativeIPComplaint, lstBackgroundProblem, HeaderName.ToUpper());
                        ph.Controls.Add(uc1);
                    }
                }
                else
                {
                    if (lstBackgroundProblem.Count > 0)
                    {
                        PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                        HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                        tr.Style.Add("display", "block");
                        Control uc = LoadControl(ControlName);
                        DischargeSummary_BackrounMedicalProblem uc1 = (DischargeSummary_BackrounMedicalProblem)uc;
                        uc1.BindBackrounMedicalProblem(lstDischargeSummary, lstNegativeIPComplaint, lstBackgroundProblem, HeaderName.ToUpper());
                        ph.Controls.Add(uc1);
                    }
                }
            }
        }



        else if (ControlName == "~/DischargeSummary/AdmissionVitals.ascx")
        {
            var NeedAdmissionVitalsInDSY = from res in lstAllDischargeConfig
                                           where res.DischargeConfigKey == "NeedAdmissionVitalsInDSY"
                                                    && res.DischargeConfigValue == "N"
                                           select res;

            if (NeedAdmissionVitalsInDSY.Count() == 0)
            {
                if (lstVitalsUOMJoin.Count > 0)
                {

                    var lstCount = from res in lstVitalsUOMJoin
                                   where res.VitalsValue > 0
                                   select res;
                    if (lstCount.Count() > 0)
                    {
                        PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                        HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                        tr.Style.Add("display", "block");
                        Control uc = LoadControl(ControlName);
                        DischargeSummary_AdmissionVitals uc1 = (DischargeSummary_AdmissionVitals)uc;
                        uc1.BindAdmissionVitals(lstVitalsUOMJoin, HeaderName.ToUpper());
                        ph.Controls.Add(uc1);
                    }
                }
            }
        }
        else if (ControlName == "~/DischargeSummary/KMHAdmissionVitals.ascx")
        {
            var NeedAdmissionVitalsInDSY = from res in lstAllDischargeConfig
                                           where res.DischargeConfigKey == "NeedAdmissionVitalsInDSY"
                                                    && res.DischargeConfigValue == "N"
                                           select res;

            if (NeedAdmissionVitalsInDSY.Count() == 0)
            {
                if (lstVitalsUOMJoin.Count > 0)
                {

                    var lstCount = from res in lstVitalsUOMJoin
                                   where res.VitalsValue > 0
                                   select res;
                    if (lstCount.Count() > 0)
                    {
                        PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                        HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                        tr.Style.Add("display", "block");
                        Control uc = LoadControl(ControlName);
                        DischargeSummary_KMHAdmissionVitals uc1 = (DischargeSummary_KMHAdmissionVitals)uc;
                        uc1.BindAdmissionVitals(lstVitalsUOMJoin, HeaderName.ToUpper());
                        ph.Controls.Add(uc1);
                    }
                }
            }
        }
        else if (ControlName == "~/DischargeSummary/GeneralExamination.ascx")
        {
            var NeedGeneralExaminationInDSY = from res in lstAllDischargeConfig
                                              where res.DischargeConfigKey == "NeedGeneralExaminationInDSY"
                                                    && res.DischargeConfigValue == "N"
                                              select res;
            if (NeedGeneralExaminationInDSY.Count() == 0)
            {
                Control uc = LoadControl(ControlName);
                DischargeSummary_GeneralExamination uc1 = (DischargeSummary_GeneralExamination)uc;
                int Res = uc1.BindGeneralExamination(lstPatientExamination, lstDischargeSummary, lstNegativeExamination, HeaderName.ToUpper());
                if (Res == 1)
                {
                    PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                    HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                    tr.Style.Add("display", "block");
                    ph.Controls.Add(uc1);
                }

            }
        }

        else if (ControlName == "~/DischargeSummary/SystemicExamination.ascx")
        {
            var NeedSystamaticExaminationInDSY = from res in lstAllDischargeConfig
                                                 where res.DischargeConfigKey == "NeedSystamaticExaminationInDSY"
                                                        && res.DischargeConfigValue == "N"
                                                 select res;


            if (NeedSystamaticExaminationInDSY.Count() == 0)
            {
                var lstSYSExam = from res in lstPatientExamination
                                 where res.Description != ""
                                 select res;

                if (lstSYSExam.Count() > 0 || OrthoCount>0)
                {
                    PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                    HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                    tr.Style.Add("display", "block");
                    Control uc = LoadControl(ControlName);
                    DischargeSummary_SystemicExamination uc1 = (DischargeSummary_SystemicExamination)uc;
                    uc1.BindSystemicExamination(lstPatientExamination, HeaderName.ToUpper());
                    uc1.BindMusculoskeletal(patientVisitID,OrgID);
                    ph.Controls.Add(uc1);
                }
            }
        }


        else if (ControlName == "~/DischargeSummary/DischargeVitals.ascx")
        {
            var NeedDischargeVitalsInDSY = from res in lstAllDischargeConfig
                                           where res.DischargeConfigKey == "NeedDischargeVitalsInDSY"
                                                  && res.DischargeConfigValue == "N"
                                           select res;

            if (NeedDischargeVitalsInDSY.Count() == 0)
            {

                if (lstDischargeVitalsUOMJoin.Count > 0)
                {
                    var lstCount = from res in lstDischargeVitalsUOMJoin
                                   where res.VitalsValue > 0
                                   select res;

                    if (lstCount.Count() > 0)
                    {
                        PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                        HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                        tr.Style.Add("display", "block");
                        Control uc = LoadControl(ControlName);
                        DischargeSummary_DischargeVitals uc1 = (DischargeSummary_DischargeVitals)uc;
                        uc1.BindDischargeVitals(lstDischargeVitalsUOMJoin, HeaderName.ToUpper());
                        ph.Controls.Add(uc1);
                    }
                }
            }
        }

        else if (ControlName == "~/DischargeSummary/KMHDischargeVitals.ascx")
        {
            var NeedDischargeVitalsInDSY = from res in lstAllDischargeConfig
                                           where res.DischargeConfigKey == "NeedDischargeVitalsInDSY"
                                                  && res.DischargeConfigValue == "N"
                                           select res;

            if (NeedDischargeVitalsInDSY.Count() == 0)
            {

                if (lstDischargeVitalsUOMJoin.Count > 0)
                {
                    var lstCount = from res in lstDischargeVitalsUOMJoin
                                   where res.VitalsValue > 0
                                   select res;

                    if (lstCount.Count() > 0)
                    {
                        PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                        HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                        tr.Style.Add("display", "block");
                        Control uc = LoadControl(ControlName);
                        DischargeSummary_KMHDischargeVitals uc1 = (DischargeSummary_KMHDischargeVitals)uc;
                        uc1.BindDischargeVitals(lstDischargeVitalsUOMJoin, HeaderName.ToUpper());
                        ph.Controls.Add(uc1);
                    }
                }
            }
        }

        else if (ControlName == "~/DischargeSummary/SurgeryDetails.ascx")
        {

            var NeedSurgeryDetailInDSY = from res in lstAllDischargeConfig
                                         where res.DischargeConfigKey == "NeedSurgeryDetailInDSY"
                                       && res.DischargeConfigValue == "N"
                                         select res;

            new IP_BL(base.ContextInfo).GetOperationNotesForDS(patientVisitID, OrgID, out lstOperationNotesForDS);
            if (NeedSurgeryDetailInDSY.Count() == 0)
            {
                if (lstOperationNotesForDS.Count > 0)
                {
                    PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                    HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                    tr.Style.Add("display", "block");
                    Control uc = LoadControl(ControlName);
                    DischargeSummary_SurgeryDetails uc1 = (DischargeSummary_SurgeryDetails)uc;
                    uc1.BindSurgeryDetails(lstOperationNotesForDS, HeaderName.ToUpper());
                    ph.Controls.Add(uc1);
                }
            }
        }
        else if (ControlName == "~/DischargeSummary/CourseInHospital.ascx")
        {


            var lstCRC = from resCRC in lstDrugDetails
                         where resCRC.PrescriptionType == "CRC"
                         select resCRC;



            var NeedCourseHospitalInDSY = from res in lstAllDischargeConfig
                                          where res.DischargeConfigKey == "NeedCourseHospitalInDSY"
                                                 && res.DischargeConfigValue == "N"
                                          select res;

            if (NeedCourseHospitalInDSY.Count() == 0)
            {
                string HospitalCourse = string.Empty;
                if (lstDischargeSummary.Count > 0)
                {
                    HospitalCourse = lstDischargeSummary[0].HospitalCourse;
                }

                if (HospitalCourse != string.Empty || lstCRC.Count() > 0)
                {
                    PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                    HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                    tr.Style.Add("display", "block");
                    Control uc = LoadControl(ControlName);
                    DischargeSummary_CourseInHospital uc1 = (DischargeSummary_CourseInHospital)uc;
                    uc1.BindCourseInHospital(lstAllDischargeConfig, HospitalCourse, lstCRC, HeaderName.ToUpper());
                    ph.Controls.Add(uc1);
                }




            }
        }

        else if (ControlName == "~/DischargeSummary/Advice.ascx")
        {
            string NeeDGeneralAdvice = "";
            var NeedAdviceInDSY = from res in lstAllDischargeConfig
                                  where res.DischargeConfigKey == "NeedAdviceInDSY"
                                         && res.DischargeConfigValue == "N"
                                  select res;

            //var NeedGeneralAdviceInDSY = from res in lstAllDischargeConfig
            //                             where res.DischargeConfigKey == "NeedGeneralAdviceInDSY"
            //                                    && res.DischargeConfigValue == "N"
            //                             select res;

            if (lstDischargeSummary.Count > 0)
            {

                if (lstDischargeSummary[0].PrintGeneralAdvice == "Y")
                {
                    NeeDGeneralAdvice = "Y";
                }
                else
                {
                    NeeDGeneralAdvice = "N";
                }
            }



            if (NeedAdviceInDSY.Count() == 0)
            {
                if (lstPatientAdvice.Count > 0 || lstGeneralAdvice.Count > 0)
                {
                    if (lstPatientAdvice.Count > 0)
                    {
                        PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                        HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                        tr.Style.Add("display", "block");
                        Control uc = LoadControl(ControlName);
                        DischargeSummary_Advice uc1 = (DischargeSummary_Advice)uc;
                        uc1.BindAdvice(lstPatientAdvice, lstGeneralAdvice, HeaderName.ToUpper(), NeeDGeneralAdvice);
                        ph.Controls.Add(uc1);
                    }
                    else if (lstPatientAdvice.Count == 0 && NeeDGeneralAdvice != "N")
                    {
                        PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                        HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                        tr.Style.Add("display", "block");
                        Control uc = LoadControl(ControlName);
                        DischargeSummary_Advice uc1 = (DischargeSummary_Advice)uc;
                        uc1.BindAdvice(lstPatientAdvice, lstGeneralAdvice, HeaderName.ToUpper(), NeeDGeneralAdvice);
                        ph.Controls.Add(uc1);
                    }

                }
            }

        }

        else if (ControlName == "~/DischargeSummary/DischargePrescription.ascx")
        {
            var NeedDischargePrescriptionInDSY = from res in lstAllDischargeConfig
                                                 where res.DischargeConfigKey == "NeedDischargePrescriptionInDSY"
                                                        && res.DischargeConfigValue == "N"
                                                 select res;


            if (NeedDischargePrescriptionInDSY.Count() == 0)
            {
                if (lstDrugDetails.Count > 0)
                {
                    var lstDsy = from resDsy in lstDrugDetails
                                 where resDsy.PrescriptionType == "DSY"
                                 select resDsy;

                    if (lstDsy.Count() > 0)
                    {
                        PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                        HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                        tr.Style.Add("display", "block");
                        Control uc = LoadControl(ControlName);
                        DischargeSummary_DischargePrescription uc1 = (DischargeSummary_DischargePrescription)uc;
                        uc1.BindDischargePrescription(lstDsy, HeaderName.ToUpper());
                        ph.Controls.Add(uc1);
                    }
                }
            }
        }


        else if (ControlName == "~/DischargeSummary/Procedure.ascx")
        {
            var NeedyTypeOfDischarge = from res in lstAllDischargeConfig
                                       where res.DischargeConfigKey == "NeedyProcedureInDSY"
                                              && res.DischargeConfigValue == "N"
                                       select res;
            if (NeedyTypeOfDischarge.Count() == 0)
            {

                if (lstDischargeSummary.Count > 0)
                {

                    if (lstDischargeSummary[0].ProcedureDesc != "")
                    {

                        PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                        HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                        tr.Style.Add("display", "block");
                        Control uc = LoadControl(ControlName);
                        DischargeSummary_Procedure uc1 = (DischargeSummary_Procedure)uc;
                        uc1.BindProcedure(lstDischargeSummary[0].ProcedureDesc, HeaderName.ToUpper());
                        ph.Controls.Add(uc1);
                    }
                }

            }


        }


        else if (ControlName == "~/DischargeSummary/ChiefSurgeon.ascx")
        {


            if (lstInPatientAdmissionDetails.Count > 0)
            {
                string ConsultingSurgeonName = lstInPatientAdmissionDetails[0].ConsultingSurgeonName == null ? "" : lstInPatientAdmissionDetails[0].ConsultingSurgeonName;

                if (ConsultingSurgeonName != "")
                {

                    PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                    HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                    tr.Style.Add("display", "block");
                    Control uc = LoadControl(ControlName);
                    DischargeSummary_ChiefSurgeon uc1 = (DischargeSummary_ChiefSurgeon)uc;
                    uc1.BindChiefSurgeon(ConsultingSurgeonName, HeaderName.ToUpper());
                    ph.Controls.Add(uc1);
                }
            }

        }

        else if (ControlName == "~/DischargeSummary/PreOpInv.ascx")
        {
                if (PreOpInv != string.Empty)
                {

                    PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                    HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                    tr.Style.Add("display", "block");
                    Control uc = LoadControl(ControlName);
                    DischargeSummary_PreOpInv uc1 = (DischargeSummary_PreOpInv)uc;
                    uc1.BindPreOpInv(PreOpInv, HeaderName.ToUpper());
                    ph.Controls.Add(uc1);
                }
           

        }

        else if (ControlName == "~/DischargeSummary/PostOpInv.ascx")
        {
            if (PostOpInv != string.Empty)
            {

                PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                tr.Style.Add("display", "block");
                Control uc = LoadControl(ControlName);
                DischargeSummary_PostOpInv uc1 = (DischargeSummary_PostOpInv)uc;
                uc1.BindPostOpInv(PostOpInv, HeaderName.ToUpper());
                ph.Controls.Add(uc1);
            }


        }

        else if (ControlName == "~/DischargeSummary/RoutineInv.ascx")
        {

            if (RoutineInv != string.Empty)
            {

                PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                tr.Style.Add("display", "block");
                Control uc = LoadControl(ControlName);
                DischargeSummary_RoutineInv uc1 = (DischargeSummary_RoutineInv)uc;
                uc1.BindRoutineInv(RoutineInv, HeaderName.ToUpper());
                ph.Controls.Add(uc1);
            }


        }
        else if (ControlName == "~/DischargeSummary/RoomSummary.ascx")
        {

            var NeedSurgeryDetailInDSY = from res in lstAllDischargeConfig
                                         where res.DischargeConfigKey == "NeedBedBookingDetailsInDSY"
                                       && res.DischargeConfigValue == "N"
                                         select res;

            //new IP_BL(base.ContextInfo).GetOperationNotesForDS(patientVisitID, OrgID, out lstOperationNotesForDS);
            List<BedBooking> lstBedPooking = new List<BedBooking>();

            RoomBooking_BL ROOMBL = new RoomBooking_BL(base.ContextInfo);

            ROOMBL.GetPatientRoomhistory(patientVisitID, OrgID, out lstBedPooking);

            if (NeedSurgeryDetailInDSY.Count() == 0)
            {
                if (lstBedPooking.Count > 0)
                {
                    PlaceHolder ph = (PlaceHolder)FindControl(PlaceHolderID);
                    HtmlTableRow tr = (HtmlTableRow)FindControl("tr" + PlaceHolderID);
                    tr.Style.Add("display", "block");
                    Control uc = LoadControl(ControlName);
                    DischargeSummary_RoomSummary uc1 = (DischargeSummary_RoomSummary)uc;
                    uc1.BindBedBookingBDetails(lstBedPooking, HeaderName.ToUpper());
                    ph.Controls.Add(uc1);
                }
            }
        }


    }
        

   
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        if (patientVisitID == 0)
        {
            patientVisitID = Convert.ToInt64(Session["VisitID"].ToString());

        }

        try
        {
            Response.Redirect("../Physician/DischargeSummary.aspx?&vid=" + patientVisitID + "&pid=" + patientID, true);

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
 
    protected void btnEditDischrageDetails_Click(object sender, EventArgs e)
    {
        string rdoVisitID;

        if (Request.Form["pid"] != null && Request.Form["pid"].ToString() != "")
        {
            rdoVisitID = Request.Form["pid"];
            Session["VisitID"] = rdoVisitID;
            patientVisitID = Convert.ToInt32(rdoVisitID.ToString());
            GetPatientHistory();         
            GetDischargeSummaryCaseSheet();
            
            tblSave.Style.Add("display", "block");
            tblDischrageResult.Style.Add("display", "block");

        }
    }
}
