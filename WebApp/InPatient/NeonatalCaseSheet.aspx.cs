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


public partial class InPatient_NeonatalCaseSheet : BasePage
{
    public InPatient_NeonatalCaseSheet()
        : base("InPatient\\NeonatalCaseSheet.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }






    long patientID = -1;
    long patientVisitID = 0;
    long returnCode = -1;
    string VistType = string.Empty;
    string IpNumber = string.Empty;

    List<PatientHistoryExt> lstPatientHistoryExt = new List<PatientHistoryExt>();
    List<BackgroundProblem> lstRiskFactor = new List<BackgroundProblem>();
    List<PatientVitals> lstPatientVitals = new List<PatientVitals>();   
    List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
    List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
    List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
    List<PatientBabyVaccination> lstPBV = new List<PatientBabyVaccination>();
    List<NeonatalNotes> lstNeonatalNotes = new List<NeonatalNotes>();
    List<InPatientAdmissionDetails> lstIPAdmissionDetails = new List<InPatientAdmissionDetails>();
    List<Patient> lstPatient = new List<Patient>();
    List<NewBornDetails> lstNewBornDetails = new List<NewBornDetails>();
    List<LabourAndDeliveryNotes> lstLabourAndDeliveryNotes = new List<LabourAndDeliveryNotes>();


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            VistType = Request.QueryString["vType"];

            if (VistType == "IP")
            {
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);

                GetNeonatalCaseSheet();
                GetInpatientDetails();
                GetNewBornDetails();
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

    private void GetNewBornDetails()
    {
        returnCode = -1;
        returnCode = new Neonatal_BL(base.ContextInfo).GetNewBornDetails(patientVisitID, OrgID, out lstLabourAndDeliveryNotes, out lstNewBornDetails);

        if (lstLabourAndDeliveryNotes.Count > 0)
        {
            trDeliveryType.Style.Add("display", "block");
            if(lstLabourAndDeliveryNotes[0].TypeOfLabourName!="")
            {
                lblDeliveryType.Text = lstLabourAndDeliveryNotes[0].TypeOfLabourName;
            }
            if (lstLabourAndDeliveryNotes[0].ModeOfDeliveryName != "")
            {
                if (lblDeliveryType.Text != "")
                {
                    lblDeliveryType.Text +=", "+ lstLabourAndDeliveryNotes[0].ModeOfDeliveryName;
                }
                else
                {
                    lblDeliveryType.Text = lstLabourAndDeliveryNotes[0].ModeOfDeliveryName;
                }
            }
            if (lstLabourAndDeliveryNotes[0].DeliveryAssistanceName != "")
            {
                if (lblDeliveryType.Text != "")
                {

                    lblDeliveryType.Text += ", " + lstLabourAndDeliveryNotes[0].DeliveryAssistanceName;
                }
                else
                {
                    lblDeliveryType.Text = lstLabourAndDeliveryNotes[0].DeliveryAssistanceName;

                }
            }

            
            lblDeliveryType.Text += ".";
            

            if (lstLabourAndDeliveryNotes[0].ProcedureType != "")
            {
                trProcedureType.Style.Add("display", "block");
                lblProcedureType.Text = lstLabourAndDeliveryNotes[0].ProcedureType;
            }

            if (lstLabourAndDeliveryNotes[0].DeliveryTerm !="")
            {
                trDeliveryTerm.Style.Add("display", "block");
                lblDeliveryTerm.Text=lstLabourAndDeliveryNotes[0].DeliveryTerm;
            }
        }


        if (lstNewBornDetails.Count > 0)
        {
            if(lstNewBornDetails[0].BirthWeight!="")
            {
                trDeliveryTerm.Style.Add("display", "block");
                lblBirthweight.Text = lstNewBornDetails[0].BirthWeight;
            }

            if (lstNewBornDetails[0].APGARScore != "")
            {
                string[] APGARScore = lstNewBornDetails[0].APGARScore.Split(' ');
                if (APGARScore[0] != "" && APGARScore[1] != "")
                {
                    trAPGAR.Style.Add("display", "block");
                    lblAPGAR.Text = APGARScore[0] + "  at 1 min  " + " , " + APGARScore[1] + "  at 5 min  ";
                }
                if (APGARScore[0] != "" && APGARScore[1] == "")
                {
                    trAPGAR.Style.Add("display", "block");
                    lblAPGAR.Text = APGARScore[0] + "  at 1 min  " ;
                }
                if (APGARScore[0] == "" && APGARScore[1] != "")
                {
                    trAPGAR.Style.Add("display", "block");
                    lblAPGAR.Text = APGARScore[1] + "  at 5 min  ";
                }
            }
        }

        if (lstDrugDetails.Count > 0)
        {
            trPrescription.Style.Add("display", "block");

            TableRow rowH = new TableRow();
            TableCell cellH1 = new TableCell();
            TableCell cellH2 = new TableCell();
            TableCell cellH3 = new TableCell();
            TableCell cellH4 = new TableCell();
            TableCell cellH5 = new TableCell();
            TableCell cellH6 = new TableCell();
            TableCell cellH7 = new TableCell();
            cellH1.Attributes.Add("align", "left");
            cellH1.Text = "Drug Name";
            cellH2.Attributes.Add("align", "left");
            cellH2.Text = "Dose";
            cellH3.Attributes.Add("align", "left");
            cellH3.Text = "Formulation";
            cellH4.Attributes.Add("align", "left");
            cellH4.Text = "ROA";
            cellH5.Attributes.Add("align", "left");
            cellH5.Text = "DrugFrequency";
            cellH6.Attributes.Add("align", "left");
            cellH6.Text = "Duration";
            cellH7.Attributes.Add("align", "left");
            cellH7.Text = "Instruction";
            rowH.Cells.Add(cellH1);
            rowH.Cells.Add(cellH2);
            rowH.Cells.Add(cellH3);
            rowH.Cells.Add(cellH4);
            rowH.Cells.Add(cellH5);
            rowH.Cells.Add(cellH6);
            rowH.Cells.Add(cellH7);
            rowH.Font.Bold = true;
            rowH.Style.Add("color", "#000");
            tblprescription.Rows.Add(rowH);
            foreach (var oDrugDetails in lstDrugDetails)
            {

                TableRow row1 = new TableRow();
                TableCell cell1 = new TableCell();
                TableCell cell2 = new TableCell();
                TableCell cell3 = new TableCell();
                TableCell cell4 = new TableCell();
                TableCell cell5 = new TableCell();
                TableCell cell6 = new TableCell();
                TableCell cell7 = new TableCell();
                cell1.Attributes.Add("align", "left");
                cell1.Text = oDrugDetails.DrugName;
                cell2.Attributes.Add("align", "left");
                cell2.Text = oDrugDetails.Dose;
                cell3.Attributes.Add("align", "left");
                cell3.Text = oDrugDetails.DrugFormulation;
                cell4.Attributes.Add("align", "left");
                cell4.Text = oDrugDetails.ROA;
                cell5.Attributes.Add("align", "left");
                cell5.Text = oDrugDetails.DrugFrequency;
                cell6.Attributes.Add("align", "left");
                cell6.Text = oDrugDetails.Days;
                cell7.Attributes.Add("align", "left");
                cell7.Text = oDrugDetails.Instruction.ToString();
                row1.Cells.Add(cell1);
                row1.Cells.Add(cell2);
                row1.Cells.Add(cell3);
                row1.Cells.Add(cell4);
                row1.Cells.Add(cell5);
                row1.Cells.Add(cell6);
                row1.Cells.Add(cell7);


                row1.Style.Add("color", "#000");
                tblprescription.Rows.Add(row1);
            }
        }






    }

    private void GetInpatientDetails()
    {
        returnCode = -1;
        returnCode = new Neonatal_BL(base.ContextInfo).GetInpatientDetails(patientVisitID, out lstPatient, out lstIPAdmissionDetails);

        if (OrgID == 26)
        {
            lblPatientDetail.Text = "NAME : " + lstPatient[0].Name + "," + "  SEX : " + lstPatient[0].SEX + "," + "  PATIENT ID : " + lstPatient[0].PatientNumber.ToString() + "," + "  IP NO : " + lstPatient[0].IPNumber ;            
        }
        else
        {
            lblPatientDetail.Text = "NAME : " + lstPatient[0].Name + "," + "  SEX : " + lstPatient[0].SEX + "," + "  PATIENT ID-" + lstPatient[0].PatientNumber.ToString();
        }

        if (lstIPAdmissionDetails.Count > 0)
        {
            lblCI.Text = lstIPAdmissionDetails[0].PrimaryPhysicianName;
            
        }

    }

    public void GetNeonatalCaseSheet()
    {
        returnCode = new Neonatal_BL(base.ContextInfo).GetNeonatalNotesForUpdate(patientVisitID, out lstPatientHistoryExt, out lstRiskFactor, out lstPatientVitals, out lstPatientExamination, out lstPatientAdvice, out lstDrugDetails, out lstPBV, out lstNeonatalNotes);


        if (returnCode == 0)
        {
            if (lstPatientHistoryExt.Count > 0)
            {
                
                if(lstPatientHistoryExt[0].DetailHistory!="" )
                {
                trBriefHistory.Style.Add("display", "block");
                lblBriefHistory.Text = lstPatientHistoryExt[0].DetailHistory;
                }
            }

            if (lstRiskFactor.Count > 0)
            {
               
                    trRiskFactor.Style.Add("display", "block");
                    foreach (var objRiskFactor in lstRiskFactor)
                    {

                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        cell1.Attributes.Add("align", "left");
                        cell1.Text = "<li type=a>" + objRiskFactor.ComplaintName;
                        row1.Cells.Add(cell1);
                        row1.Style.Add("color", "#000");
                        tblRiskFactor.Rows.Add(row1);
                    }

            }


            if (lstPatientVitals.Count > 0)
            {
                trDischargeVitals.Style.Add("display", "block");
                string Vitalsname = string.Empty;
                string Vitalsvalue = string.Empty;
                string Vitalsunit = string.Empty;

                foreach (var oVitalsUOMJoin in lstPatientVitals)
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
                tbDischargeVitals.Rows.Add(rowH);


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
                tbDischargeVitals.Rows.Add(row1);
            }
            if (lstNeonatalNotes.Count > 0)
            {
                var lstGE = from Res in lstPatientExamination
                            where Res.ExaminationID == 0
                            select Res;

                
                foreach (PatientExamination GE in lstGE)
                {
                    if (GE.ExaminationName != "")
                    {
                        trGeneralExamination.Style.Add("display", "block");
                        lblGeneralExam.Text = GE.ExaminationName;
                    }

                }
                if (lstNeonatalNotes[0].RespiratorySupport != "" )
                {
                    trResSupport.Style.Add("display", "block");
                    lblResSupport.Text = lstNeonatalNotes[0].RespiratorySupport;
                }
                if (lstNeonatalNotes[0].FluidsandNutrition != "" )
                {
                    trFliuds.Style.Add("display", "block");
                    lblFliuds.Text = lstNeonatalNotes[0].FluidsandNutrition;
                }
                if (lstNeonatalNotes[0].GeneralCourse != "" )
                {
                    trGeneralCourse.Style.Add("display", "block");
                    lblGeneralCourse.Text = lstNeonatalNotes[0].GeneralCourse;
                }

                if (lstNeonatalNotes[0].Plans != "" )
                {
                    trPlan.Style.Add("display", "block");
                    lblPlan.Text = lstNeonatalNotes[0].Plans;
                }
                if (lstNeonatalNotes[0].NextReviewAfter != "" )
                {

                    if (lstNeonatalNotes[0].NextReviewAfter.Contains("/"))
                    {
                        lblNextReview.Text = lstNeonatalNotes[0].NextReviewAfter.ToString();
                    }
                    else
                    {

                        lblNextReview.Text = "After" + lstNeonatalNotes[0].NextReviewAfter.ToString();
                    }
                }

                if (lstPBV.Count > 0)
                {
                    trIMUH.Style.Add("display", "block");
                    trIMUD.Style.Add("display", "block");
                    foreach (var objPBV in lstPBV)
                    {

                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        cell1.Attributes.Add("align", "left");
                        cell1.Text = "<li type=a>" + objPBV.VaccinationName;
                        row1.Cells.Add(cell1);
                        row1.Style.Add("color", "#000");
                        tblIMU.Rows.Add(row1);
                    }
                }

               
            }

            if (lstPatientExamination.Count>0)
            {
                 var lstPE = from Res in lstPatientExamination
                            where Res.ExaminationID !=0
                            select Res;

                 foreach (var oPatientExamination in lstPE)
                 {
                    
                     TableRow row1 = new TableRow();
                     TableCell cell1 = new TableCell();
                     cell1.Attributes.Add("align", "left");
                     if (oPatientExamination.ExaminationDesc != "")
                     {
                         trSystemicExam.Style.Add("display", "block");
                         cell1.Text = oPatientExamination.ExaminationName + " - " + oPatientExamination.ExaminationDesc;

                     }
                     row1.Cells.Add(cell1);
                     row1.Style.Add("color", "#000");
                     tblSystamaticExamination.Rows.Add(row1);
                 }
            }

            if (lstPatientAdvice.Count > 0)
            {

                trAdvice.Style.Add("display", "block");

                foreach (var oPatientAdvice in lstPatientAdvice)
                {
                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    cell1.Attributes.Add("align", "left");
                    cell1.Text = "<li type=a>" + oPatientAdvice.Description;
                    row1.Cells.Add(cell1);
                    row1.Style.Add("color", "#000");
                    tblAdvice.Rows.Add(row1);
                }
            }
        }

    }



    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        
        try
        {
            Response.Redirect("../InPatient/NeonatalNotes.aspx?&vid=" + patientVisitID + "&pid=" + patientID, true);

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Displaying Neonatal Notes  page", ex);
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
