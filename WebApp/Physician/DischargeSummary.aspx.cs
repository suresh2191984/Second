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


public partial class Physician_DischargeSummary : BasePage
{

    public Physician_DischargeSummary()
        : base("Physician\\DischargeSummary.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    List<Patient> lstPatient = new List<Patient>();
    List<OperationNotes> lstOperationNotes = new List<OperationNotes>();
    List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
    List<BackgroundProblem> lstBackgroundProblem = new List<BackgroundProblem>();
    List<PatientVitals> lstVitalsCount = new List<PatientVitals>();
    List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
    List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
    List<IPTreatmentPlan> lstIPTreatmentPlan = new List<IPTreatmentPlan>();
    List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
    List<InPatientNumber> lstInPatientNumber = new List<InPatientNumber>();
    
    List<DischargeSummary> lstDischargeSummary = new List<DischargeSummary>();

    List<IPTreatmentPlanMaster> lstIPTreatmentPlanMaster = new List<IPTreatmentPlanMaster>();
    List<IPTreatmentPlan> lstCaseRecordIPTreatmentPlan = new List<IPTreatmentPlan>();

    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();
    List<DischargeConfig> lstAllDischargeConfig = new List<DischargeConfig>();
    List<DischargeInvNotes> lstDischargeInvNotes = new List<DischargeInvNotes>();
    IP_BL oIP_BL;

    List<PatientAdvice> lstGeneralAdvice = new List<PatientAdvice>();
    List<PatientAdvice> lstNutritionAdvice = new List<PatientAdvice>();
    long patientID = -1;
    long patientVisitID = 0;
    string pPatientNo = string.Empty;
    long returnCode = -1;
    string RedirectToADmissionNotes = string.Empty;
    string DischargeConfigs = string.Empty;
    List<DischargeConfig> lstDischargeConfig = new List<DischargeConfig>();
    string CustomIpNo = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        oIP_BL = new IP_BL(base.ContextInfo);
        try
        {

            txtNextReviewDate.Attributes.Add("onChange", "ExcedDate('" + txtNextReviewDate.ClientID.ToString() + "','',0,1);");

            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            patientHeader.PatientID = patientID;
            patientHeader.PatientVisitID = patientVisitID;
            patientHeader.ShowVitalsDetails();
            uAd.RouteDisplay = "block";            
            if (!IsPostBack)
            {
                hdnuGAdv.Value = GetConfigValue("General Advice", OrgID);
                hdnNuAdvc.Value = GetConfigValue("Nutrition Advice", OrgID);
                hdnIcdcode.Value = GetConfigValue("NeedICDValidation", OrgID);
                if (hdnNuAdvc.Value == "Y")
                {
                    tdNutrition.Style.Add("display", "block");
                }
                else
                {
                    tdNutrition.Style.Add("display", "none");
                }
                new GateWay(base.ContextInfo).GetAllDischargeConfig(OrgID, out DischargeConfigs, out lstAllDischargeConfig);
                GetFCKPath();
                LoadDischargeType();
                LoadIPTreatmentPlanMaster();
                LoadAllIPTreatmentPlanChild();
                GetDischargeSummary();
                GetDischargeSummaryDetailsForupdate();
                ComplaintICDCode1.ComplaintHeader = "Clinical Diagnosis";
                ComplaintICDCode1.SetWidth(500);

               // new GateWay(base.ContextInfo).GetDischargeConfigDetails("NeedPrintHistoryCheckBox", OrgID, out lstDischargeConfig);


             

                var NeedPrintHistoryCheckBox = from res in lstAllDischargeConfig
                                               where res.DischargeConfigKey == "NeedPrintHistoryCheckBox"
                                             && res.DischargeConfigValue == "N"
                                               select res;

                if (NeedPrintHistoryCheckBox.Count() > 0)
                {
                    chkPNH.Visible = false;

                }


                var NeeGeneralAdviceCheckBox = from res in lstAllDischargeConfig
                                               where res.DischargeConfigKey == "NeeGeneralAdviceCheckBox"
                                             && res.DischargeConfigValue == "N"
                                               select res;

                if (NeeGeneralAdviceCheckBox.Count() > 0)
                {
                    chkGAdv.Visible = false;

                }



                var NeedCustomIPNOTxtBox = from res in lstAllDischargeConfig
                                               where res.DischargeConfigKey == "NeedCustomIPNOTxtBox"
                                             && res.DischargeConfigValue == "Y"
                                               select res;

                if (NeedCustomIPNOTxtBox.Count() > 0)
                {
                    trCIPNo.Style.Add("display", "block");
                    hdnCIPNo.Value = "Y";

                }

                var NeedDischargeInvNotes = from res in lstAllDischargeConfig
                                           where res.DischargeConfigKey == "NeedDischargeInvNotes"
                                         && res.DischargeConfigValue == "Y"
                                           select res;

                if(NeedDischargeInvNotes.Count()>0)
                {
                    tdDischargeInv.Style.Add("display", "block");
                }

                //if (lstDischargeConfig.Count > 0)
                //{

                //    if (lstDischargeConfig[0].DischargeConfigValue == "N")
                //    {
                //        chkPNH.Visible = false;
                //    }
                //}

                ddlNos.SelectedIndex = 0;
                ddlDMY.SelectedIndex = 0;

            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in DischargeSummary.aspx:Page_Load", ex);
        }

    }

    private void GetDischargeSummaryDetailsForupdate()
    {

        try
        {
            returnCode = oIP_BL.GetDischargeSummaryDetailsForupdate(patientVisitID, out lstDischargeSummary,out lstDischargeInvNotes);

            //var NeedGeneralAdviceInDSY = from res in lstAllDischargeConfig
            //                             where res.DischargeConfigKey == "NeedGeneralAdviceInDSY"
            //                                    && res.DischargeConfigValue == "N"
            //                             select res;

            //if (NeedGeneralAdviceInDSY.Count() > 0)
            //{
            //    chkGAdv.Checked = false;
            //}
            //else
            //{
            //    chkGAdv.Checked = true;
            //}

            if (lstDischargeSummary.Count > 0)
            {
                if (lstDischargeSummary[0].DateOfDischarge != DateTime.MinValue)
                {
                    txtDischargeDate.Text = lstDischargeSummary[0].DateOfDischarge.ToString();
                }

                ddlDischrageType.SelectedValue = lstDischargeSummary[0].TypeOfDischarge.ToString();

                fckHospitalCourse.Value = lstDischargeSummary[0].HospitalCourse;

                txtConditionOnDischarge.Text = lstDischargeSummary[0].ConditionOnDischarge;

                ddlDisStatus.SelectedValue = lstDischargeSummary[0].SummaryStatus;

                txtPreparedBy.Text = lstDischargeSummary[0].PreparedBy;

                txtProcedures.Text = lstDischargeSummary[0].ProcedureDesc;

                if ((lstDischargeSummary[0].NextReviewAfter != "") && (lstDischargeSummary[0].NextReviewAfter != null))
                {
                    if (lstDischargeSummary[0].NextReviewAfter.Contains(":") || lstDischargeSummary[0].NextReviewAfter.Contains("/"))
                    {
                        txtNextReviewDate.Text = lstDischargeSummary[0].NextReviewAfter;
                    }
                    else
                    {
                        string NextReview = string.Empty;
                        string NextReviewNos = string.Empty;
                        string NextReviewDMY = string.Empty;
                        string[] nReview;

                        NextReview = lstDischargeSummary[0].NextReviewAfter;
                        nReview = NextReview.Split('-');
                        if (nReview.Length > 0)
                        {
                            NextReviewNos = nReview[0].ToString();
                            NextReviewDMY = nReview[1].ToString();
                            ddlNos.SelectedValue = NextReviewNos;
                            ddlDMY.SelectedValue = NextReviewDMY;
                        }
                    }
                }

                if (lstDischargeSummary[0].ReviewReason != "")
                {
                    txtReviewReason.Text = lstDischargeSummary[0].ReviewReason;
                }

                if (lstDischargeSummary[0].PrintNegativeExam== "Y")
                {
                    chkPNE.Checked = true;

                }

                if (lstDischargeSummary[0].PrintNegativeHistory == "Y")
                {
                    chkPNH.Checked = true;
                }

                if (lstDischargeSummary[0].PrintGeneralAdvice == "Y")
                {
                    chkGAdv.Checked = true;
                }

              //  new GateWay(base.ContextInfo).GetAllDischargeConfig(OrgID, out DischargeConfigs, out lstAllDischargeConfig);

                var NeedCustomIPNOTxtBox = from res in lstAllDischargeConfig
                                           where res.DischargeConfigKey == "NeedCustomIPNOTxtBox"
                                         && res.DischargeConfigValue == "Y"
                                           select res;

                if (NeedCustomIPNOTxtBox.Count() > 0)
                {
                    trCIPNo.Style.Add("display", "block");
                    if (lstInPatientNumber.Count > 0)
                    {
                        if(lstInPatientNumber[0].CustomIPNo!="")
                        {
                            txtCIPNo.Text = lstInPatientNumber[0].CustomIPNo;
                        }
                    }

                }

                if (lstDischargeInvNotes.Count > 0)
                {
                    foreach (DischargeInvNotes ItemDIN in lstDischargeInvNotes)
                    {
                        if (ItemDIN.Type == "PreOpInv")
                        {
                            chkPreOpInv.Checked = true;
                            txtPreOpInv.Text = ItemDIN.InvestigationDetails;
                            trchkPreOpInv.Style.Add("display", "block");
                        }
                        else if (ItemDIN.Type == "PostOpInv")
                        {
                            chkPostOpInv.Checked = true;
                            txtPostOpInv.Text = ItemDIN.InvestigationDetails;
                            trchkPostOpInv.Style.Add("display", "block");
                        }
                        else if (ItemDIN.Type == "RoutineInv")
                        {
                            chkRoutineInv.Checked = true;
                            txtRoutineInv.Text = ItemDIN.InvestigationDetails;
                            trchkRoutineInv.Style.Add("display", "block");
                        }
                    }
                }


            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in DischargeSummaryDetailsForupdate in DischargeSummary.aspx", ex);
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

    protected void LoadIPTreatmentPlanMaster()
    {
        try
        {
            oIP_BL.GetIPTreatmentPlanMaster(OrgID, out lstIPTreatmentPlanMaster);



          


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
            CLogger.LogError("Error while loading IPTreatmentPlan in DischargeSummary.aspx", ex);
        }
    }
    

    public void LoadAllIPTreatmentPlanChild()
    {
        try
        {
            List<IPTreatmentPlanMaster> lstAllIPTreatmentPlanChild = new List<IPTreatmentPlanMaster>();

            oIP_BL.GetAllIPTreatmentPlanChild(OrgID, out lstAllIPTreatmentPlanChild);

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
            CLogger.LogError("Error while loading IPTreatmentPlan in DischargeSummary.aspx", ex);
        }
    }
    private void GetDischargeSummary()
    {
        try
        {
            long returnCode = -1;
            IP_BL oIP_BL = new IP_BL(base.ContextInfo);
            //   returnCode = oIP_BL.GetIPCaseRecord(patientVisitID, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails, out lstRTAMLCDetails, out lstPatientComplaint, out lstIPTreatmentPlan, out lstBackgroundProblem, out lstPatientVitals, out lstANCPatientDetails, out lstPatientInvestigation);

            returnCode = oIP_BL.GetDischargeSummary(patientVisitID, OrgID, out lstPatient, out lstOperationNotes, out lstPatientHistory, out lstBackgroundProblem, out lstVitalsUOMJoin, out lstPatientComplaint, out lstDrugDetails, out lstIPTreatmentPlan, out lstPatientAdvice, out lstCaseRecordIPTreatmentPlan, out lstVitalsCount,out lstInPatientNumber);



            var NeedGeneralAdviceInDSY = from res in lstAllDischargeConfig
                                         where res.DischargeConfigKey == "NeedGeneralAdviceInDSY"
                                                && res.DischargeConfigValue == "N"
                                         select res;

            if (NeedGeneralAdviceInDSY.Count() > 0)
            {
                chkGAdv.Checked = false;
            }
            else
            {
                chkGAdv.Checked = true;
            }

            if (returnCode == 0)
            {


                if (lstPatient.Count > 0)
                {
                    if (lstPatient[0].BloodGroup != null)
                    {
                        if (lstPatient[0].BloodGroup.ToString() != "-1")
                        {
                            lblBloodgroup.Text = lstPatient[0].BloodGroup.ToString();
                        }
                        else
                        {
                            lblBloodgroup.Text = "Not Yet Tested";
                           
                        }
                    }
                    lblDateOfAdmission.Text = lstPatient[0].CreatedAt.ToString();

                }

                //if (lstOperationNotes.Count > 0)
                //{
                //    if (lstOperationNotes[0].FromTime.ToString() != "")
                //    {
                //        lblDateOfSurgery.Text = lstOperationNotes[0].FromTime.ToString();
                //    }
                //    else
                //    {
                //        lblDateOfSurgery.Text = "-";
                //    }
                //}

                if (lstPatientHistory.Count > 0)
                {
                    foreach (var oPatientHistory in lstPatientHistory)
                    {

                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        cell1.Attributes.Add("align", "left");
                        cell1.Text = oPatientHistory.HistoryName;
                        row1.Cells.Add(cell1);
                        row1.Font.Bold = false;
                        row1.Style.Add("color", "#000");
                        tbPresentHistory.Rows.Add(row1);
                    }
                }

                if (lstBackgroundProblem.Count > 0)
                {
                    foreach (var oBackgroundProblem in lstBackgroundProblem)
                    {
                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        cell1.Attributes.Add("align", "left");
                        cell1.Text = oBackgroundProblem.ComplaintName;
                        row1.Cells.Add(cell1);
                        row1.Font.Bold = false;
                        row1.Style.Add("color", "#000");
                        tbPasthistory.Rows.Add(row1);
                    }
                }
                //if (lstPatientVitals.Count > 0)
                //{
                //    TableRow rowH = new TableRow();
                //    TableCell cellH1 = new TableCell();
                //    TableCell cellH2 = new TableCell();
                //    TableCell cellH3 = new TableCell();
                //    TableCell cellH4 = new TableCell();
                //    cellH1.Attributes.Add("align", "left");
                //    cellH1.Text = "Vitals name";
                //    cellH2.Attributes.Add("align", "right");
                //    cellH2.Text = "Value";
                //    rowH.Cells.Add(cellH1);
                //    rowH.Cells.Add(cellH2);
                //    rowH.Font.Bold = true;
                //    rowH.Font.Underline = true;
                //    rowH.Style.Add("color", "#000");
                //    tbClinicalInfo.Rows.Add(rowH);
                //    foreach (var oPatientVitals in lstPatientVitals)
                //    {

                //        TableRow row1 = new TableRow();
                //        TableCell cell1 = new TableCell();
                //        TableCell cell2 = new TableCell();
                //        cell1.Attributes.Add("align", "left");
                //        cell1.Text = oPatientVitals.VitalsName;
                //        cell2.Attributes.Add("align", "left");
                //        cell2.Text = oPatientVitals.VitalsValue.ToString();
                //        row1.Cells.Add(cell1);
                //        row1.Cells.Add(cell2);

                //        row1.Style.Add("color", "#000");
                //        tbClinicalInfo.Rows.Add(row1);
                //    }
                //}
                if (lstVitalsCount[0].VitalsSetID > 8)
                {
                    if (lstVitalsUOMJoin.Count > 0)
                    {
                        trDischargeVitals.Style.Add("display", "block");
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
                        tbClinicalInfo.Rows.Add(rowH);


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
                        row1.Font.Bold = false;
                        row1.Style.Add("color", "#000");
                        tbClinicalInfo.Rows.Add(row1);
                    }
                }

                if (lstPatientComplaint.Count > 0)
                {
                    ComplaintICDCode1.ComplaintHeader = "Clinical Diagnosis";
                    ComplaintICDCode1.SetPatientComplaint(lstPatientComplaint);
                    //int i = 220;
                    //foreach (PatientComplaint objCMP in lstPatientComplaint)
                    //{
                    //    hdnDiagnosisItems.Value += i + "~" + objCMP.ComplaintName + "^";
                    //    i += 1;
                    //}
                }


                if (lstDrugDetails.Count > 0)
                {
                    uAd.SetPrescription(lstDrugDetails);
                }
                if (lstIPTreatmentPlan.Count > 0)
                {
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
                    cellH4.Attributes.Add("align", "left");
                    cellH4.Text = "Physician Name";
                    cellH5.Attributes.Add("align", "left");
                    cellH5.Text = "Date";
                    rowH.Cells.Add(cellH1);
                    rowH.Cells.Add(cellH2);
                    rowH.Cells.Add(cellH3);
                    rowH.Cells.Add(cellH4);
                    rowH.Cells.Add(cellH5);
                    rowH.Font.Bold = true;

                    rowH.Style.Add("color", "#000");
                    tblSurgeryDetail.Rows.Add(rowH);

                    foreach (var oIPTreatmentPlan in lstIPTreatmentPlan)
                    {

                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        TableCell cell2 = new TableCell();
                        TableCell cell3 = new TableCell();
                        TableCell cell4 = new TableCell();
                        TableCell cell5 = new TableCell();
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


                        cell4.Attributes.Add("align", "left");
                        cell4.Text = oIPTreatmentPlan.PhysicianName;
                        if (oIPTreatmentPlan.FromTime == DateTime.MinValue)
                        {
                            cell5.Attributes.Add("align", "left");
                            cell5.Text = "-";
                        }
                        else
                        {
                            cell5.Attributes.Add("align", "left");
                            cell5.Text = oIPTreatmentPlan.FromTime.ToString();
                        }
                        row1.Cells.Add(cell1);
                        row1.Cells.Add(cell2);
                        row1.Cells.Add(cell3);
                        row1.Cells.Add(cell4);
                        row1.Cells.Add(cell5);

                        row1.Style.Add("color", "#000");
                        tblSurgeryDetail.Rows.Add(row1);
                    }
                }


                if (lstPatientAdvice.Count > 0)
                {
                    uGAdv.setGeneralAdvice(lstPatientAdvice);
                }

                if (lstPatientAdvice.Count > 0)
                {
                    uNAdv.setNutritionAdvice(lstPatientAdvice);
                }

                if (lstCaseRecordIPTreatmentPlan.Count > 0)
                {
                    string pTreatmentPlanDate;
                    int i = 1;
                    foreach (IPTreatmentPlan objIPTP in lstCaseRecordIPTreatmentPlan)
                    {
                        if (objIPTP.TreatmentPlanDate == DateTime.MinValue)
                        {
                            pTreatmentPlanDate = "Will be scheduled later";
                        }
                        else
                        {
                            pTreatmentPlanDate = objIPTP.TreatmentPlanDate.ToString();
                        }
                        hdnIPTreatmentPlanItems.Value += i + "~" + objIPTP.ParentID + "~" + objIPTP.IPTreatmentPlanID + "~" + objIPTP.ParentName + "~" + objIPTP.IPTreatmentPlanName + "~" + objIPTP.Prosthesis + "~" + pTreatmentPlanDate + "~" + objIPTP.Status + "^";
                        i += 1;
                    }
                }

            }

        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error while loading GetDischargeSummary in DischargeSummary.aspx", ex);
        }

    }



    private void LoadDischargeType()
    {
        long retCode = -1;
        IP_BL oIP_BL = new IP_BL(base.ContextInfo);
        List<InPatientDischargeType> oDischargeType = new List<InPatientDischargeType>();
        
       
        retCode = oIP_BL.LoadDischargeType(OrgID, patientVisitID, out oDischargeType);



        if (retCode == 0)
        {

            ddlDischrageType.DataSource = oDischargeType;
            ddlDischrageType.DataTextField = "DischargeTypeName";
            ddlDischrageType.DataValueField = "DischargeTypeID";
            ddlDischrageType.DataBind();

            ddlDischrageType.Items.Insert(0, "--Select--");
            ddlDischrageType.Items[0].Value = "0";
        }
    }

    //private void LoadConditionOnAdmission()
    //{
    //    long retCode = -1;
    //    PatientVisit_BL patBL = new PatientVisit_BL(base.ContextInfo);
    //    List<PatientCondition> vCOA = new List<PatientCondition>();
    //    retCode = patBL.GetConditionOnAdmission(out vCOA);

    //    if (retCode == 0)
    //    {

    //        ddlConditionOnDischarge.DataSource = vCOA;
    //        ddlConditionOnDischarge.DataTextField = "Condition";
    //        ddlConditionOnDischarge.DataValueField = "ConditionID";
    //        ddlConditionOnDischarge.DataBind();
    //        ddlConditionOnDischarge.Items.Insert(0, "-----Select-----");
    //        ddlConditionOnDischarge.Items[0].Value = "0";
    //    }
    //}


    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            lstPatientComplaint = new List<PatientComplaint>();
            //lstPatientComplaint=GetPatientComplaint();
            lstPatientComplaint = ComplaintICDCode1.GetPatientComplaint("DSY", patientVisitID);
            lstDrugDetails = uAd.GetPrescription(patientVisitID);
            if (lstDrugDetails.Count > 0)
            {
                foreach (DrugDetails objDrugDetails in lstDrugDetails)
                {
                    objDrugDetails.PrescriptionType = "DSY";
                }

            }
            lstGeneralAdvice = uGAdv.GetGeneralAdvice(patientVisitID);
            lstNutritionAdvice = uNAdv.GetNutritionAdvice(patientVisitID);

            var addAdvice = lstGeneralAdvice.Concat(lstNutritionAdvice);
            lstPatientAdvice = addAdvice.ToList();

            DischargeSummary oDischargeSummary = new DischargeSummary();
            oDischargeSummary.PatientVistID = patientVisitID;
            oDischargeSummary.PatientID = patientID;
            if (txtDischargeDate.Text != string.Empty)
            {
                oDischargeSummary.DateOfDischarge = Convert.ToDateTime(txtDischargeDate.Text);
            }
            oDischargeSummary.TypeOfDischarge = Convert.ToInt32(ddlDischrageType.SelectedValue);
            oDischargeSummary.ConditionOnDischarge = txtConditionOnDischarge.Text;
            oDischargeSummary.HospitalCourse = fckHospitalCourse.Value;
            oDischargeSummary.CreatedBy = LID;
            if (txtNextReviewDate.Text == "")
            {
                oDischargeSummary.NextReviewAfter = ddlNos.SelectedValue.ToString() + "-" + ddlDMY.SelectedValue.ToString();
            }
            else
            {
                oDischargeSummary.NextReviewAfter = txtNextReviewDate.Text;
            }
            oDischargeSummary.ReviewReason = txtReviewReason.Text;


            if (chkPNE.Checked == true)
            {
                oDischargeSummary.PrintNegativeExam = "Y";
            }
            else
            {
                oDischargeSummary.PrintNegativeExam = "N";
            }


            if (chkPNH.Checked == true)
            {
                oDischargeSummary.PrintNegativeHistory = "Y";
            }
            else
            {
                oDischargeSummary.PrintNegativeHistory = "N";
            }
            if (chkGAdv.Checked == true)
            {
                oDischargeSummary.PrintGeneralAdvice = "Y";
            }
            else
            {
                oDischargeSummary.PrintGeneralAdvice = "N";
            }


            lstDischargeSummary.Add(oDischargeSummary);
            lstCaseRecordIPTreatmentPlan = GetIPTreatmentPlan();



            if (hdnCIPNo.Value == "Y")
            {
                if (txtCIPNo.Text != "")
                {
                    CustomIpNo = txtCIPNo.Text;
                }


            }

            if (chkPreOpInv.Checked)
            {
                DischargeInvNotes objDischargeInvNotes = new DischargeInvNotes();
                if (txtPostOpInv.Text != "")
                {
                    objDischargeInvNotes.InvestigationDetails = txtPreOpInv.Text;
                    objDischargeInvNotes.Type = "PreOpInv";
                    lstDischargeInvNotes.Add(objDischargeInvNotes);
                }
            }

            if (chkPostOpInv.Checked)
            {
                DischargeInvNotes objDischargeInvNotes = new DischargeInvNotes();
                if (txtPostOpInv.Text != "")
                {
                    objDischargeInvNotes.InvestigationDetails = txtPostOpInv.Text;
                    objDischargeInvNotes.Type = "PostOpInv";
                    lstDischargeInvNotes.Add(objDischargeInvNotes);
                }
            }

            if (chkRoutineInv.Checked)
            {
                DischargeInvNotes objDischargeInvNotes = new DischargeInvNotes();
                if (txtRoutineInv.Text != "")
                {
                    objDischargeInvNotes.InvestigationDetails = txtRoutineInv.Text;
                    objDischargeInvNotes.Type = "RoutineInv";
                    lstDischargeInvNotes.Add(objDischargeInvNotes);
                }
            }




            oIP_BL = new IP_BL(base.ContextInfo);
            returnCode = oIP_BL.SaveDischargeSummary(patientVisitID, patientID, ddlDisStatus.SelectedItem.Text, txtProcedures.Text, txtPreparedBy.Text, lstDischargeSummary, lstPatientComplaint, lstDrugDetails, lstPatientAdvice, lstCaseRecordIPTreatmentPlan, lstDischargeInvNotes, LID, CustomIpNo);
            hdnCIPNo.Value = "";
            if (lstPatientComplaint.Count > 0)
            {
                Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
                objPatient_BL.UpdatePatientICDStatus(patientVisitID);
            }
            if (RedirectToADmissionNotes != "Y")
            {
                if (returnCode == 0)
                {
                    try
                    {
                        //  string DischargeConfigs = string.Empty;

                        new GateWay(base.ContextInfo).GetAllDischargeConfig(OrgID, out DischargeConfigs, out lstAllDischargeConfig);

                        //var NeedKDRDSY = from res in lstAllDischargeConfig
                        //                 where res.DischargeConfigKey == "NeedKDRDDischargeSummary"
                        //                             && res.DischargeConfigValue == "Y"
                        //                 select res;

                        var NeedRaksithDSY = from res in lstAllDischargeConfig
                                             where res.DischargeConfigKey == "NeedRaksithDischargeSummary"
                                                     && res.DischargeConfigValue == "Y"
                                             select res;

                        if (NeedRaksithDSY.Count() > 0)
                        {
                            Response.Redirect("../InPatient/RakshithDischargeSummary.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&vType=" + "IP", true);
                        }
                        else
                        {
                            //Commented due to Dynamic DichargeSummmary
                            //Response.Redirect("../Physician/DischargeSummaryCaseSheet.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&vType=" + "IP", true);

                            Response.Redirect("../DischargeSummary/DischargeSummaryDynamic.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&vType=" + "IP", true);


                        }


                    }
                    catch (System.Threading.ThreadAbortException tae)
                    {
                        string thread = tae.ToString();
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error while save DischargeSummary  page", ex);
                    }

                }
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in Saving DischargeSummary. Please contact system administrator";
            CLogger.LogError("Error in DischargeSummary.aspx:btnFinish_Click", ex);
        }
       
              
       
    }

    public List<IPTreatmentPlan> GetIPTreatmentPlan()
    {

        
            List<IPTreatmentPlan> lstIPTreatmentPlanTemp = new List<IPTreatmentPlan>();
            foreach (string listParentTreatmentPlan in hdnIPTreatmentPlanItems.Value.Split('^'))
            {
                if (listParentTreatmentPlan != "")
                {
                    IPTreatmentPlan objIPTreatmentPlan = new IPTreatmentPlan();
                    string[] listChildTreatmentPlan = listParentTreatmentPlan.Split('~');

                    objIPTreatmentPlan.PatientID = patientID;
                    objIPTreatmentPlan.PatientVisitID = patientVisitID;
                    objIPTreatmentPlan.IPTreatmentPlanID = Convert.ToInt32(listChildTreatmentPlan[2]);
                    objIPTreatmentPlan.IPTreatmentPlanName = listChildTreatmentPlan[4];
                    objIPTreatmentPlan.Prosthesis = listChildTreatmentPlan[5];
                    objIPTreatmentPlan.ParentID = Convert.ToInt32(listChildTreatmentPlan[1]);
                    objIPTreatmentPlan.ParentName = listChildTreatmentPlan[3];
                    if (listChildTreatmentPlan[6] != "Will be scheduled later")
                    {
                        objIPTreatmentPlan.TreatmentPlanDate = Convert.ToDateTime(listChildTreatmentPlan[6]);
                    }
                    objIPTreatmentPlan.Status = listChildTreatmentPlan[7];
                    objIPTreatmentPlan.OrgID = OrgID;
                    objIPTreatmentPlan.CreatedBy = LID;
                    objIPTreatmentPlan.StagePlanned = "DSY";
                    lstIPTreatmentPlanTemp.Add(objIPTreatmentPlan);

                }
            }
            return lstIPTreatmentPlanTemp;
       
    }
    
    //public List<PatientComplaint> GetPatientComplaint()
    //{
    //    List<PatientComplaint> lstPatientComplaintTemp = new List<PatientComplaint>();
    //    foreach (string listParentDiagnosis in hdnDiagnosisItems.Value.Split('^'))
    //    {
    //        if (listParentDiagnosis != "")
    //        {
    //            PatientComplaint objPatientComplaint = new PatientComplaint();
    //            string[] listChildDiagnosis = listParentDiagnosis.Split('~');
    //            objPatientComplaint.ComplaintID = 0;
    //            objPatientComplaint.ComplaintName = listChildDiagnosis[1];
    //            objPatientComplaint.CreatedBy = LID;
    //            objPatientComplaint.PatientVisitID = patientVisitID;
    //            objPatientComplaint.ComplaintType = "DSY";
    //            lstPatientComplaintTemp.Add(objPatientComplaint);
    //        }
    //    }
    //    return lstPatientComplaintTemp;
    //}
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
    protected void lbtEditHistory_Click(object sender, EventArgs e)
    {
        RedirectToADmissionNotes = "Y";
        btnFinish_Click(sender, e);
       
        try
        {
            Response.Redirect("../Physician/IPCaseRecord.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&rPage=" + "DSY", true);

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while save DischargeSummary.aspx  page", ex);
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
