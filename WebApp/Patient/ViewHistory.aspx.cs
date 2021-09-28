using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using System.Security.Cryptography;
using Attune.Podium.SmartAccessor;

public partial class Patient_ViewHistory : BasePage
{
    long Vid = -1;
    long InID = -1;
    long patientID = -1;
    long taskID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!IsPostBack)
        {
            btnPrint.Visible=false;
            //if (Request.QueryString["pid"].toString() != "" && Request.QueryString["pid"] !="0")
            {
                Int64.TryParse(Request.QueryString["pid"], out patientID);
            }
            if (Request.QueryString["tid"] != "")
            {
                Int64.TryParse(Request.QueryString["tid"], out taskID);
            }
            if (Request.QueryString["vid"] != "")
            {
                Int64.TryParse(Request.QueryString["vid"], out Vid);
            }
            if (Request.QueryString["invid"] != "")
            {
                Int64.TryParse(Request.QueryString["invid"], out InID);
            }

            
        }
        ViewHistoryData(Vid, InID);

        //////ViewHistoryData(Vid, InID);


    }


    public void ViewHistoryData(long Vid,long InvestigationID)
    {

       
        long returnCode = -1;
        

        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        Int64.TryParse(Request.QueryString["invid"], out InID);
        try
        {



            if (Vid > 0 != null)
            {

                List<PatientHistoryAttribute> lstPatHisAttribute1 = new List<PatientHistoryAttribute>();
                List<PatientHistoryAttribute> lsthisPHA1 = new List<PatientHistoryAttribute>();
                List<DrugDetails> lstDrugDetails1 = new List<DrugDetails>();
                List<GPALDetails> lstGPALDetails1 = new List<GPALDetails>();
                List<ANCPatientDetails> lstANCPatientDetails1 = new List<ANCPatientDetails>();
                List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory1 = new List<PatientPastVaccinationHistory>();
                List<PatientComplaintAttribute> lstPCA1 = new List<PatientComplaintAttribute>();
                List<PatientComplaintAttribute> lsthisPCA1 = new List<PatientComplaintAttribute>();
                List<SurgicalDetail> lstSurgicalDetails1 = new List<SurgicalDetail>();

                returnCode = new SmartAccessor(base.ContextInfo).GetPatientHistoryPKGEdit
                  (Vid, out lstPatHisAttribute1, out lstDrugDetails1, out lstGPALDetails1, out lstANCPatientDetails1,
                  out lstPatientPastVaccinationHistory1, out lstPCA1, out lstSurgicalDetails1, out lsthisPCA1, out lsthisPHA1);


                //if (lstPatHisAttribute1.Count > 0)
                //{
                //    btnPrint.Visible = true;
                //    divViewHeader.Style.Add("display", "block");
                //    for (int i = 0; i < lstPatHisAttribute1.Count; i++)
                //    {

                //        switch (lstPatHisAttribute1[i].HistoryID)
                //        {
                //            case 1097:

                //                tr1.Style.Add("display", "block");

                //                if (lstPatHisAttribute1[i].AttributeID == 123)
                //                {
                //                    lblLMPValue.Text = lstPatHisAttribute1[i].AttributeValueName.ToString();
                //                }
                //                break;

                //            default:
                //                divviewHistory.Style.Add("display", "none");
                //                tblMain.Style.Add("display", "block");
                //                lblMessage.Text = "No History For this Patient";


                //        }
                //    }
                //}
                  if (lstPatHisAttribute1.Count > 0)
                    {
                        btnPrint.Visible = true;
                        divViewHeader.Style.Add("display", "block");
                        for (int i = 0; i < lstPatHisAttribute1.Count; i++)
                        {
                            if (lstPatHisAttribute1[i].HistoryID == 1097)
                            {
                                tr1.Style.Add("display", "block");

                                if (lstPatHisAttribute1[i].AttributeID == 123)
                                {
                                    lblLMPValue.Text = lstPatHisAttribute1[i].AttributeValueName.ToString();
                                }
                            }

                            else if (lstPatHisAttribute1[i].HistoryID == 1098)
                            {
                                tr2.Style.Add("display", "block");

                                if (lstPatHisAttribute1[i].AttributeID == 124)
                                {
                                    lblFasting_DurationValue.Text = lstPatHisAttribute1[i].AttributeValueName.ToString();
                                }
                            }
                            else if (lstPatHisAttribute1[i].HistoryID == 1099)
                            {
                                tr3.Style.Add("display", "block");

                                if (lstPatHisAttribute1[i].AttributeID == 125)
                                {
                                    lblLast_Meal_TimeValue.Text = lstPatHisAttribute1[i].AttributeValueName.ToString();
                                }
                            }

                            else if (lstPatHisAttribute1[i].HistoryID == 1100)
                            {
                                tr4.Style.Add("display", "block");
                                if (lstPatHisAttribute1[i].AttributeID == 126)
                                {
                                    lblReportDateValue.Text = lstPatHisAttribute1[i].AttributeValueName.ToString().Split('~')[0];
                                    lblReportCommentValue.Text = lstPatHisAttribute1[i].AttributeValueName.ToString().Split('~')[1];
                                }
                            }
                            else if (lstPatHisAttribute1[i].HistoryID == 1101)
                            {
                                tr5.Style.Add("display", "block");

                                if (lstPatHisAttribute1[i].AttributeID == 127)
                                {
                                    lblHeightValue.Text = lstPatHisAttribute1[i].AttributeValueName.ToString();
                                }
                                if (lstPatHisAttribute1[i].AttributeID == 128)
                                {
                                    lblWeightValue.Text = lstPatHisAttribute1[i].AttributeValueName.ToString();
                                }
                            }


                            else if (lstPatHisAttribute1[i].HistoryID == 1102)
                            {
                                tr6.Style.Add("display", "block");

                                if (lstPatHisAttribute1[i].AttributeID == 129)
                                {
                                    lblAbstinence_daysValue.Text = lstPatHisAttribute1[i].AttributeValueName.ToString();
                                }
                            }

                            else if (lstPatHisAttribute1[i].HistoryID == 1103)
                            {
                                tr7.Style.Add("display", "block");

                                if (lstPatHisAttribute1[i].AttributeID == 130)
                                {
                                    lblThyroid_Disease_Value.Text = lstPatHisAttribute1[i].AttributeValueName.ToString();
                                }
                            }

                            else if (lstPatHisAttribute1[i].HistoryID == 1104)
                            {
                                tr8.Style.Add("display", "block");

                                if (lstPatHisAttribute1[i].AttributeID == 0)
                                {
                                    lblReading_taken_between_48_72_hrs_Value.Text = lstPatHisAttribute1[i].AttributeValueName.ToString();
                                }
                            }
                            else
                            {

                                //divviewHistory.Style.Add("display", "none");
                                //tblMain.Style.Add("display", "block");
                                lblMessage.Text = "No History For this Patient";

                            }


                        }
                    }

             
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ViewHistoryData ViewHistory aspx page", ex);
        }




    }
}
