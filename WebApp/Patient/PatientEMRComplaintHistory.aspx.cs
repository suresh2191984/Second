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
using System.Web.UI.HtmlControls;
using Attune.Podium.SmartAccessor;

public partial class Patient_PatientEMRComplaintHistory : BasePage
{
    long visitID = -1;
    long patientID = -1;
    long taskID = -1;
    long returnCode = -1;
    long InvestiID = -1;
    bool blDig = true;
    bool blInves = true;
    string RetPage = string.Empty;
    string Type = string.Empty;
    Control myControl = null;
    List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
    List<PatientExaminationAttribute> lstPEA = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lstskin = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lsthair = new List<PatientExaminationAttribute>();
    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();
    List<PatientDiagnosticsAttribute> lstPDA = new List<PatientDiagnosticsAttribute>();
    List<PatientDiagnosticsAttribute> lstDiagonistics = new List<PatientDiagnosticsAttribute>();
    List<PatientExaminationAttribute> lstExam = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lstAttribute = new List<PatientExaminationAttribute>();
    Patient_BL patientBL;

    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new Patient_BL(base.ContextInfo);
        Table tblResult = null;
        TableRow tr = null;
        TableCell tc = null;
        ViewTRF.Attributes.Add("style", "display:block");
        ClientScript.RegisterStartupScript(GetType(), "key", "HideFunction();", true);
        if (Request.QueryString["pvid"] != null)
        {
            Int64.TryParse(Request.QueryString["pvid"], out visitID);
        }
        else
        {
            Int64.TryParse(Request.QueryString["vid"], out visitID);
        }
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        Int64.TryParse(Request.QueryString["invid"], out InvestiID);
        if (Request.QueryString["Type"] != null)
        {
            Type = Request.QueryString["Type"];
        }
        else
        {
            Type = "INV";
        }
        RetPage = Request.QueryString["RePage"];
        
        hdnType.Value = Type;
        if (!IsPostBack)
        {
            try
            {
                #region load Exam

                returnCode = new SmartAccessor(base.ContextInfo).GetPatientExamPackage(visitID, OrgID, out lstPEA, out lstVitalsUOMJoin, out lstExam, out lstAttribute);
                List<Patient> lstPatient = new List<Patient>();
                // patientBL. = new Patient_BL(base.ContextInfo);
                Patient patient = new Patient();
                patientBL.GetPatientDetailsPassingVisitID(visitID, out lstPatient);

                #endregion
                #region Load History

                btnPrint.Visible = false;
                btnUpdate.Visible = false;
                btnSave.Visible = false;

                Hisss.TypeValue = Type;
                Hisss.ReturnPage = RetPage;
                Hisss.LoadHistoryData(visitID, InvestiID);
                Hisss.Clearvalues();
                bool isStatus;
                Hisss.EditHistoryData(visitID, InvestiID);
                isStatus = Hisss.getstatus();
                if (isStatus == true)
                {
                    btnSave.Visible = true;
                }
                else
                {
                    btnSave.Visible = false;
                }
                #endregion




            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Page Load", ex);
            }
        }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        bool isStatus;
        long returncode = -1;
        List<PatientHistoryAttribute> lsthisPHA1 = new List<PatientHistoryAttribute>();
        List<PatientHistory> lstPatientHisPKG1 = new List<PatientHistory>();
        Hisss.SaveData(out lsthisPHA1, out lstPatientHisPKG1);
        if (Request.QueryString["pvid"] != null)
        {
            Int64.TryParse(Request.QueryString["pvid"], out visitID);
        }
        else
        {
            Int64.TryParse(Request.QueryString["vid"], out visitID);
        }
        Int64.TryParse(Request.QueryString["pid"], out patientID);

        if (lstPatientHisPKG1.Count > 0)
        {

            returncode = patientBL.SaveEMRHistory(lstPatientHisPKG1, lsthisPHA1, LID, visitID, patientID);


            if (returncode > 0)
            {
                if (RetPage == "LabReceptionHome")
                {
                    string AlertMesg = "Changes saved successfully.";
                    string PageUrl = Request.ApplicationPath + @"/Reception/Home.aspx?IsPopup=Y";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');window.location ='" + PageUrl + "';", true);
                }
                else if (RetPage == "PatientSearch")
                {
                    string AlertMesg = "Changes saved successfully.";
                    string PageUrl = Request.ApplicationPath + @"/Reception/PatientSearch.aspx?IsPopup=Y";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');window.location ='" + PageUrl + "';", true);
                }
                else if (RetPage == "VisitDetails")
                {
                    string AlertMesg = "Changes saved successfully.";
                    string PageUrl = Request.ApplicationPath + @"/Reception/VisitDetails.aspx?IsPopup=Y";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');window.location ='" + PageUrl + "';", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Changes saved successfully.');", true);
                }
            }
        }
        isStatus = Hisss.getstatus();
        if (isStatus == true)
        {
            btnPrint.Visible = true;
            btnUpdate.Visible = true;
            btnSave.Visible = false;
        }
        else
        {
            btnPrint.Visible = false;
            btnUpdate.Visible = false;
            btnSave.Visible = true;


        }


    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        #region Load History
        btnPrint.Visible = false;
        btnUpdate.Visible = false;
        btnSave.Visible = true;
        Hisss.LoadHistoryData(visitID, InvestiID);
        Hisss.Clearvalues();
        Hisss.EditHistoryData(visitID, InvestiID);
        #endregion

        //    Int64.TryParse(Request.QueryString["pid"], out patientID);
        //    Int64.TryParse(Request.QueryString["tid"], out taskID);
        //    try


    }


    private string GetUniqueKey()
    {
        int maxSize = 10;
        char[] chars = new char[62];
        string a;
        //a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        a = "0123456789012345678901234567890123456789012345678901234567890123456789";
        chars = a.ToCharArray();
        int size = maxSize;
        byte[] data = new byte[1];
        RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider();
        crypto.GetNonZeroBytes(data);
        size = maxSize;
        data = new byte[size];
        crypto.GetNonZeroBytes(data);
        StringBuilder result = new StringBuilder(size);
        foreach (byte b in data)
        { result.Append(chars[b % (chars.Length - 1)]); }
        return result.ToString();
    }

    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }






}
