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
using System.Xml;

public partial class Psychologist_ViewCounsellingDetails : BasePage
{
    long visitID = -1;
    long patientID = -1;
    long taskID = -1;
    long returnCode = -1;
    string physicianName = String.Empty;
    string counsellingType = string.Empty;
    string History = string.Empty;
    string generalAdvice = string.Empty;
    string nextreviewdate = string.Empty;
    string admission = string.Empty;
    string review = string.Empty;
    string examination = string.Empty;
    string hdnReview = string.Empty;
    string hdnExam = string.Empty;
    string InvDrugData = string.Empty;
    long createTaskID = -1;
    int drugCount = 0;
    string configValue;
    string strConfigKey;
    string sex = "";
    StringBuilder CaseSheetLabel = new StringBuilder();
    StringBuilder CaseSheetReview = new StringBuilder();
    StringBuilder CaseSheetExam = new StringBuilder();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Int64.TryParse(Request.QueryString["vid"], out visitID);
            PrintHistory1.LoadHistoryData(visitID);
            PrintExam1.LoadExamData(visitID);
            LoadCaseSheet();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
        }
             
    }

    public void LoadCaseSheet()
    {

        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
        List<Patient> lstPatient = new List<Patient>();
        List<CounsellingDetails> lstCounsellingDetails = new List<CounsellingDetails>();
        List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        Counselling_BL CounsellingBL = new Counselling_BL(base.ContextInfo);
        List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
        List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
        List<Advice> lstAdvice = new List<Advice>();
        List<PatientPrescription> lstPatientPrescription = new List<PatientPrescription>();
        List<Investigation> lstinv = new List<Investigation>();
        Investigation_BL InvestionBL = new Investigation_BL(base.ContextInfo);
        List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
        List<PatientComplaint> lstPhysiciancomments = new List<PatientComplaint>();
        try
        {
            CounsellingBL.GetCounsellingCaseSheet(visitID, out lstPatientComplaint, out lstPatient, out lstCounsellingDetails, out lstPatientAdvice, out lstPatientVisit, out lstPatientPrescription);
            if (lstPatientComplaint.Count > 0 && lstPatient.Count > 0)
            {
                physicianName = "<b>Prescribed by Dr. " + lstPatientComplaint[0].PhysicianName + "</b>, (Dated: " + lstPatientComplaint[0].CreatedAt + ")";
                CaseSheetLabel.Append("<table align='center' width='100%'>");
                if (physicianName != String.Empty)
                {
                    CaseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                    CaseSheetLabel.Append(physicianName);
                    CaseSheetLabel.Append("</td></tr>");
                    CaseSheetLabel.Append("<tr><td>&nbsp;<tr><td>");
                }
                CaseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");

                CaseSheetLabel.Append("<b>" + "&nbsp" + lstPatient[0].TitleName + " " + lstPatient[0].Name);
                CaseSheetLabel.Append("(Patient No:" + lstPatient[0].PatientNumber.ToString() + ")</b>");
                int page = 0;// Convert.ToInt32();
                Int32.TryParse(lstPatient[0].PatientAge.Split(' ')[0], out page);
                if (page > 0)
                {
                    CaseSheetLabel.Append(", aged " + lstPatient[0].PatientAge.ToString());
                }

                if (page > 12)
                {
                    if (lstPatient[0].SEX == "M")
                        CaseSheetLabel.Append(" Male");
                    else if (lstPatient[0].SEX == "F")
                        CaseSheetLabel.Append(" Female");
                }
                else if ((page <= 12) && (page > 0))
                {
                    CaseSheetLabel.Append(" child,");
                }
                else
                {
                    if (lstPatient[0].SEX == "M")
                        CaseSheetLabel.Append(" Male");
                    else if (lstPatient[0].SEX == "F")
                        CaseSheetLabel.Append(" Female");
                }
                if (lstPatient[0].SEX == "M")
                    sex = "He";
                else if (lstPatient[0].SEX == "F")
                    sex = "She";
                CaseSheetLabel.Append(". " + sex + " has been diagnosed to have " + lstPatientComplaint[0].ComplaintName + "." + sex + "  is prescribed the following course of treatment and advice:");
                if (lstPatientPrescription.Count > 0)
                {
                    CaseSheetLabel.Append("<table width='100%' > ");
                    CaseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                    CaseSheetLabel.Append("<hr />");
                    CaseSheetLabel.Append("<td colspan='6'><font size='2'><b>TREATMENT</b></font></td>");
                    CaseSheetLabel.Append("</tr>");
                    //caseSheetLabel.Append("<tr>");

                    for (int i = 0, j = 1; i < lstPatientPrescription.Count; i++, j++)
                    {
                        PatientPrescription pp = new PatientPrescription();
                        pp = lstPatientPrescription[i];
                        CaseSheetLabel.Append("<tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                        CaseSheetLabel.Append("<td nowrap='nowrap'>" + j.ToString() + ". </td>");
                        CaseSheetLabel.Append("<td nowrap='nowrap'>" + pp.Formulation + "</td>");
                        CaseSheetLabel.Append("<td nowrap='nowrap'>" + pp.BrandName + "</td>");
                        CaseSheetLabel.Append("<td nowrap='nowrap'>" + pp.Dose + "</td>");
                        CaseSheetLabel.Append("<td nowrap='nowrap'>" + pp.DrugFrequency + "</td>");
                        CaseSheetLabel.Append("<td nowrap='nowrap'>" + pp.Duration + "</td>");
                        CaseSheetLabel.Append("<td nowrap='nowrap'>" + pp.Instruction + "</td>");
                        CaseSheetLabel.Append("<td style='overflow:auto' >" + pp.ROA + "</td>");
                        CaseSheetLabel.Append("</tr>");


                    }
                    CaseSheetLabel.Append("</table>");

                }
                if (lstCounsellingDetails.Count > 0)
                {
                    counsellingType = "<br><b>Counseling Type : </b>" + lstCounsellingDetails[0].CounselType + "";
                    CaseSheetLabel.Append("<table align='center' width='100%'>");
                    CaseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                    CaseSheetLabel.Append(counsellingType);
                    CaseSheetLabel.Append("</td></tr>");
                    if (lstCounsellingDetails[0].IsConfidential == "N")
                    {
                        History = "<b>Symptoms / History : </b>" + lstCounsellingDetails[0].Symptoms + "";
                        CaseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                        CaseSheetLabel.Append(History);
                        CaseSheetLabel.Append("</td></tr>");
                        CaseSheetLabel.Append("</table>");
                    }
                    else
                    {
                        CaseSheetLabel.Append("<table><tr style='display:none'><td></td></tr></table>");
                    }
                        review = lstCounsellingDetails[0].ReviewOfSystem;
                        examination = lstCounsellingDetails[0].Examination;

                        if (review != string.Empty)
                        {
                            CaseSheetReview.Append("<table id='tbreview' runat='server'>");
                            CaseSheetReview.Append("<tr>");
                            CaseSheetReview.Append("<td align='center' style='font-family:Tahoma;width:200px;'>");
                            CaseSheetReview.Append("<b><U> REVIEW OF SYSTEM </U></b>");
                            CaseSheetReview.Append("</td>");
                            CaseSheetReview.Append("</tr>");
                            CaseSheetReview.Append("</table>");

                            hdnReview = ReviewString(review);
                            foreach (string O in hdnReview.Split('^'))
                            {
                                if (O != string.Empty)
                                {
                                    string ReviewName = string.Empty;
                                    string Value = string.Empty;
                                    string Confi = string.Empty;
                                    if (O.Split('~')[0] != string.Empty)
                                    {
                                        ReviewName = O.Split('~')[0];
                                    }
                                    if (O.Split('~')[1] != string.Empty)
                                    {
                                        Value = O.Split('~')[1];
                                    }
                                    if (O.Split('~')[2] != string.Empty)
                                    {
                                        Confi = O.Split('~')[2];
                                    }
                                    if (O.Split('~')[2] != string.Empty && O.Split('~')[2] != "Y")
                                    {
                                        if (Confi == "N" && Value != string.Empty)
                                        {
                                            trreivew.Attributes.Add("style", "display:block");
                                            CaseSheetReview.Append("<table>");
                                            CaseSheetReview.Append("<tr>");
                                            CaseSheetReview.Append("<td style='font-family:Tahoma;width:200px;'>");
                                            CaseSheetReview.Append(ReviewName);
                                            CaseSheetReview.Append("</td>");
                                            CaseSheetReview.Append("<td style='font-family:Tahoma;width:200px;'>");
                                            CaseSheetReview.Append(Value);
                                            CaseSheetReview.Append("</td>");
                                            CaseSheetReview.Append("</tr>");
                                            CaseSheetReview.Append("</table>");
                                        }
                                    }

                                }
                            }
                        }

                        if (examination != string.Empty)
                        {
                            hdnExam = ExaminationString(examination);
                            #region Appearance
                            string app = hdnExam.Split('^')[0];
                            if (app != string.Empty)
                            {
                                string confi = string.Empty;
                                string header = string.Empty;
                                string name = string.Empty;
                                string value = string.Empty;

                                if (app.Split('~')[0] != string.Empty)
                                {
                                    header = app.Split('*')[0];
                                    confi = app.Split('~')[0].Split('=')[1];
                                }
                                if (confi == "N")
                                {
                                    tdExam.Attributes.Add("style", "display:block");
                                    string v1, v2, v3, v4;
                                    v1 = app.Split('~')[1].Split('=')[1];
                                    v2 = app.Split('~')[2].Split('=')[1];
                                    v3 = app.Split('~')[3].Split('=')[1];
                                    v4 = app.Split('~')[4].Split('=')[1];
                                    if (v1 != string.Empty || v2 != string.Empty || v3 != string.Empty || v4 != string.Empty)
                                    {
                                        CaseSheetExam.Append("<br><b>" + header + " </b>");
                                    }
                                    name = app.Split('~')[1].Split('=')[0];
                                    value = app.Split('~')[1].Split('=')[1];
                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(name);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }

                                    name = app.Split('~')[2].Split('=')[0];
                                    value = app.Split('~')[2].Split('=')[1];
                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(name);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                    name = app.Split('~')[3].Split('=')[0];
                                    value = app.Split('~')[3].Split('=')[1];
                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(name);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                    name = app.Split('~')[4].Split('=')[0];
                                    value = app.Split('~')[4].Split('=')[1];
                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(name);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                }
                            }
                            #endregion

                            #region Attitude
                            string att = hdnExam.Split('^')[1];
                            if (att != string.Empty)
                            {
                                string confi = string.Empty;
                                string header = string.Empty;
                                string name = string.Empty;
                                string value = string.Empty;

                                if (app.Split('~')[0] != string.Empty)
                                {
                                    header = att.Split('*')[0];
                                    confi = att.Split('~')[0].Split('=')[1];
                                }
                                if (confi == "N")
                                {
                                    tdExam.Attributes.Add("style", "display:block");
                                    name = att.Split('~')[1].Split('=')[0];
                                    value = att.Split('~')[1].Split('=')[1];

                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<br><b>" + header + " </b>");
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append("Attitude Towards Examiner: ");
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                }
                            }
                            #endregion

                            #region Mood
                            string mood = hdnExam.Split('^')[2];
                            if (mood != string.Empty)
                            {
                                string confi = string.Empty;
                                string header = string.Empty;
                                string name = string.Empty;
                                string value = string.Empty;

                                if (mood.Split('~')[0] != string.Empty)
                                {
                                    header = mood.Split('*')[0];
                                    confi = mood.Split('~')[0].Split('=')[1];
                                }
                                if (confi == "N")
                                {
                                    tdExam.Attributes.Add("style", "display:block");
                                    name = mood.Split('~')[1].Split('=')[0];
                                    value = mood.Split('~')[1].Split('=')[1];

                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<br><table><tr><td width='200px'> <b>" + header + " </b></td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                }
                            }
                            #endregion

                            #region Affect
                            string aff = hdnExam.Split('^')[3];
                            if (aff != string.Empty)
                            {
                                string confi = string.Empty;
                                string header = string.Empty;
                                string name = string.Empty;
                                string value = string.Empty;

                                if (aff.Split('~')[0] != string.Empty)
                                {
                                    header = aff.Split('*')[0];
                                    confi = aff.Split('~')[0].Split('=')[1];
                                }
                                if (confi == "N")
                                {
                                    tdExam.Attributes.Add("style", "display:block");
                                    name = aff.Split('~')[1].Split('=')[0];
                                    value = aff.Split('~')[1].Split('=')[1];

                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<br><table><tr><td width='200px'> <b>" + header + " </b></td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                }
                            }
                            #endregion

                            #region Speech
                            string spe = hdnExam.Split('^')[4];
                            if (spe != string.Empty)
                            {
                                string confi = string.Empty;
                                string header = string.Empty;
                                string name = string.Empty;
                                string value = string.Empty;

                                if (spe.Split('~')[0] != string.Empty)
                                {
                                    header = spe.Split('*')[0];
                                    confi = spe.Split('~')[0].Split('=')[1];
                                }
                                if (confi == "N")
                                {
                                    tdExam.Attributes.Add("style", "display:block");
                                    string v1, v2, v3, v4;
                                    v1 = spe.Split('~')[1].Split('=')[1];
                                    v2 = spe.Split('~')[2].Split('=')[1];
                                    v3 = spe.Split('~')[3].Split('=')[1];
                                    v4 = spe.Split('~')[4].Split('=')[1];
                                    if (v1 != string.Empty || v2 != string.Empty || v3 != string.Empty || v4 != string.Empty)
                                    {
                                        CaseSheetExam.Append("<br><b>" + header + " </b>");
                                    }
                                    name = spe.Split('~')[1].Split('=')[0];
                                    value = spe.Split('~')[1].Split('=')[1];

                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(name);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }

                                    name = spe.Split('~')[2].Split('=')[0];
                                    value = spe.Split('~')[2].Split('=')[1];
                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(name);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                    name = spe.Split('~')[3].Split('=')[0];
                                    value = spe.Split('~')[3].Split('=')[1];
                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(name);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                    name = spe.Split('~')[4].Split('=')[0];
                                    value = spe.Split('~')[4].Split('=')[1];
                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(name);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                }
                            }
                            #endregion

                            #region Thought Process
                            string thp = hdnExam.Split('^')[5];
                            if (thp != string.Empty)
                            {
                                string confi = string.Empty;
                                string header = string.Empty;
                                string name = string.Empty;
                                string value = string.Empty;

                                if (thp.Split('~')[0] != string.Empty)
                                {
                                    header = thp.Split('*')[0];
                                    confi = thp.Split('~')[0].Split('=')[1];
                                }
                                if (confi == "N")
                                {
                                    tdExam.Attributes.Add("style", "display:block");
                                    name = thp.Split('~')[1].Split('=')[0];
                                    value = thp.Split('~')[1].Split('=')[1];

                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<br><table><tr><td width='200px'> <b>" + "Thougth Process " + " </b></td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                }
                            }
                            #endregion

                            #region Thought Content
                            string thc = hdnExam.Split('^')[6];
                            if (thc != string.Empty)
                            {
                                string confi = string.Empty;
                                string header = string.Empty;
                                string name = string.Empty;
                                string value = string.Empty;

                                if (thc.Split('~')[0] != string.Empty)
                                {
                                    header = thc.Split('*')[0];
                                    confi = thc.Split('~')[0].Split('=')[1];
                                }
                                if (confi == "N")
                                {
                                    tdExam.Attributes.Add("style", "display:block");
                                    string v1, v2, v3, v4, v5, v6, v7, v8;
                                    v1 = thc.Split('~')[1].Split('=')[1];
                                    v2 = thc.Split('~')[2].Split('=')[1];
                                    v3 = thc.Split('~')[3].Split('=')[1];
                                    v4 = thc.Split('~')[4].Split('=')[1];
                                    v5 = thc.Split('~')[5].Split('=')[1];
                                    v6 = thc.Split('~')[6].Split('=')[1];
                                    v7 = thc.Split('~')[7].Split('=')[1];
                                    v8 = thc.Split('~')[8].Split('=')[1];
                                    if (v1 != string.Empty || v2 != string.Empty || v3 != string.Empty || v4 != string.Empty || v5 != string.Empty ||
                                        v6 != string.Empty || v7 != string.Empty || v8 != string.Empty)
                                    {
                                        CaseSheetExam.Append("<br><b>" + header + " </b>");
                                    }
                                    name = thc.Split('~')[1].Split('=')[0];
                                    value = thc.Split('~')[1].Split('=')[1];

                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append("Obessions/Compultions");
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }

                                    name = thc.Split('~')[2].Split('=')[0];
                                    value = thc.Split('~')[2].Split('=')[1];
                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(name);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                    name = thc.Split('~')[3].Split('=')[0];
                                    value = thc.Split('~')[3].Split('=')[1];
                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append("Level Of Consciousness");
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                    name = thc.Split('~')[4].Split('=')[0];
                                    value = thc.Split('~')[4].Split('=')[1];
                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append("Orientation");
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }

                                    name = thc.Split('~')[5].Split('=')[0];
                                    value = thc.Split('~')[5].Split('=')[1];

                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append("Sensorium & Cognition");
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }

                                    name = thc.Split('~')[6].Split('=')[0];
                                    value = thc.Split('~')[6].Split('=')[1];
                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append("Suicidal/Homicidal ideation");
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                    name = thc.Split('~')[7].Split('=')[0];
                                    value = thc.Split('~')[7].Split('=')[1];
                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append("Memory");
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                    name = thc.Split('~')[8].Split('=')[0];
                                    value = thc.Split('~')[8].Split('=')[1];
                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append("Abstractness/Intelligence");
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                }
                            }
                            #endregion

                            #region Perceptual
                            string per = hdnExam.Split('^')[7];
                            if (per != string.Empty)
                            {
                                string confi = string.Empty;
                                string header = string.Empty;
                                string name = string.Empty;
                                string value = string.Empty;

                                if (per.Split('~')[0] != string.Empty)
                                {
                                    header = per.Split('*')[0];
                                    confi = per.Split('~')[0].Split('=')[1];
                                }
                                if (confi == "N")
                                {
                                    tdExam.Attributes.Add("style", "display:block");
                                    string v1 = per.Split('~')[1].Split('=')[1];
                                    string v2 = per.Split('~')[2].Split('=')[1];
                                    if (v1 != string.Empty || v2 != string.Empty)
                                    {
                                        CaseSheetExam.Append("<br><b>" + "Perceptual Disturbances" + " </b>");
                                    }
                                    name = per.Split('~')[1].Split('=')[0];
                                    value = per.Split('~')[1].Split('=')[1];

                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(name);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }

                                    name = per.Split('~')[2].Split('=')[0];
                                    value = per.Split('~')[2].Split('=')[1];

                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<table>");
                                        CaseSheetExam.Append("<tr>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(name);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                }
                            }
                            #endregion

                            #region Insight
                            string ins = hdnExam.Split('^')[8];
                            if (ins != string.Empty)
                            {
                                string confi = string.Empty;
                                string header = string.Empty;
                                string name = string.Empty;
                                string value = string.Empty;

                                if (ins.Split('~')[0] != string.Empty)
                                {
                                    header = ins.Split('*')[0];
                                    confi = ins.Split('~')[0].Split('=')[1];
                                }
                                if (confi == "N")
                                {
                                    tdExam.Attributes.Add("style", "display:block");
                                    name = ins.Split('~')[1].Split('=')[0];
                                    value = ins.Split('~')[1].Split('=')[1];

                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<br><table><tr><td width='200px'> <b>" + header + " </b></td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                }
                            }
                            #endregion

                            #region Judgement
                            string jud = hdnExam.Split('^')[9];
                            if (jud != string.Empty)
                            {
                                string confi = string.Empty;
                                string header = string.Empty;
                                string name = string.Empty;
                                string value = string.Empty;

                                if (jud.Split('~')[0] != string.Empty)
                                {
                                    header = jud.Split('*')[0];
                                    confi = jud.Split('~')[0].Split('=')[1];
                                }
                                if (confi == "N")
                                {
                                    tdExam.Attributes.Add("style", "display:block");
                                    name = jud.Split('~')[1].Split('=')[0];
                                    value = jud.Split('~')[1].Split('=')[1];

                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<br><table><tr><td width='200px'> <b>" + header + " </b></td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                }
                            }
                            #endregion

                            #region Impulsivity
                            string imp = hdnExam.Split('^')[10];
                            if (imp != string.Empty)
                            {
                                string confi = string.Empty;
                                string header = string.Empty;
                                string name = string.Empty;
                                string value = string.Empty;

                                if (imp.Split('~')[0] != string.Empty)
                                {
                                    header = imp.Split('*')[0];
                                    confi = imp.Split('~')[0].Split('=')[1];
                                }
                                if (confi == "N")
                                {
                                    tdExam.Attributes.Add("style", "display:block");
                                    name = imp.Split('~')[1].Split('=')[0];
                                    value = imp.Split('~')[1].Split('=')[1];

                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<br><table><tr><td width='200px'> <b>" + header + " </b></td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                }
                            }
                            #endregion

                            #region Reliability
                            string rel = hdnExam.Split('^')[11];
                            if (rel != string.Empty)
                            {
                                string confi = string.Empty;
                                string header = string.Empty;
                                string name = string.Empty;
                                string value = string.Empty;

                                if (rel.Split('~')[0] != string.Empty)
                                {
                                    header = rel.Split('*')[0];
                                    confi = rel.Split('~')[0].Split('=')[1];
                                }
                                if (confi == "N")
                                {
                                    tdExam.Attributes.Add("style", "display:block");
                                    name = rel.Split('~')[1].Split('=')[0];
                                    value = rel.Split('~')[1].Split('=')[1];

                                    if (value != string.Empty)
                                    {
                                        CaseSheetExam.Append("<br><table><tr><td width='200px'> <b>" + header + " </b></td>");
                                        CaseSheetExam.Append("<td width='200px'>");
                                        CaseSheetExam.Append(value);
                                        CaseSheetExam.Append("</td>");
                                        CaseSheetExam.Append("</tr>");
                                        CaseSheetExam.Append("</table>");
                                    }
                                }
                            }
                            #endregion
                        }
                    }
                
                if (lstPatientAdvice.Count > 0)
                {
                    int garowcount = 1;
                    string sgeneraladvice = "";
                    foreach (PatientAdvice pa in lstPatientAdvice)
                    {
                        generalAdvice = pa.Description == null ? "" : pa.Description;
                        if (generalAdvice.Split('-')[0] == "G")
                        {
                            sgeneraladvice += +garowcount + ". " + generalAdvice.Split('-')[1] + "&nbsp&nbsp";
                        }
                        garowcount++;
                    }
                    CaseSheetLabel.Append("<table align='center' width='100%'>");
                    CaseSheetLabel.Append("<tr><td width='100%'><b> General Advice: </b>");
                    CaseSheetLabel.Append(sgeneraladvice);
                    CaseSheetLabel.Append("</td></tr>");
                    CaseSheetLabel.Append("</table>");
                }
                else
                {
                    CaseSheetLabel.Append("<table><tr style='display:none'><td></td></tr></table>");
                }
                if (lstPatientVisit.Count > 0)
                {
                    nextreviewdate = "<b>&nbspNext Review Date: </b>" + lstPatientVisit[0].NextReviewDate + "";
                    admission = lstPatientVisit[0].AdmissionSuggested;
                    string admin = string.Empty;
                    if (admission == "Y")
                    {
                        admin = "YES";
                    }
                    else
                    {
                        admin = "NO";
                    }
                    CaseSheetLabel.Append("<tr><td width='25%'>");
                    CaseSheetLabel.Append(nextreviewdate);
                    CaseSheetLabel.Append("</td></tr>");
                    CaseSheetLabel.Append("<tr><td>");
                    CaseSheetLabel.Append("<b>&nbspAdmission Suggested: </b>: " + admin);
                    CaseSheetLabel.Append("</td></tr></table>");
                }
                Table1.Attributes.Add("style", "display:block");

            }

            else
            {
                CaseSheetLabel.Append("<table > ");
                CaseSheetLabel.Append("<tr>");
                CaseSheetLabel.Append("<td><font size='2'><b>No Case Sheet Available for the selected visit</b></font></td>");
                CaseSheetLabel.Append("</tr>");
                CaseSheetLabel.Append("</table>");
                lblPrescription.Text = CaseSheetLabel.ToString();
            }

            lblCounselling.Text = CaseSheetLabel.ToString();
            lblReview.Text = CaseSheetReview.ToString();
            lblExam.Text = CaseSheetExam.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading CaseSheet", ex);
        }
    }

    string ReviewString(string XMLString)
    {
        string HdnText = string.Empty;
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml(XMLString);
        string str = Doc.InnerXml;

        int count = Doc.GetElementsByTagName("Review").Count;
        foreach (XmlNode xmNode in Doc.GetElementsByTagName("Review"))
        {
            HdnText += xmNode["ReviewName"].InnerText + "~" + xmNode["Value"].InnerText + "~" + xmNode["Confi"].InnerText + "^";
        }
        return HdnText;
    }

    string ExaminationString(string XMLString)
    {
        string examstr = string.Empty;
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml(XMLString);
        string str = Doc.InnerXml;

        string Maintxt = string.Empty;
        string Subtxt = string.Empty;
        foreach (XmlNode x in Doc.ChildNodes)
        {
            foreach (XmlNode xs in x.ChildNodes)
            {
                string name = xs.Name;
                foreach (XmlNode xst in xs.ChildNodes)
                {
                    Subtxt += xst.Name + '=' + xst.InnerText + '~';
                }
                Maintxt += xs.Name + '*' + Subtxt + '^';
                Subtxt = string.Empty;
            }
        }
        return Maintxt;  
    }
}
