using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Configuration;
using System.IO;

public partial class CommonControls_PatientDetails : BaseControl
{
    public CommonControls_PatientDetails()
        : base("CommonControls_PatientDetails_ascx")
    {
    }
    long VisitID = -1;
    long returnCode = -1;
    string LabNo = string.Empty;
    string gUID = string.Empty;
    int SetHistLength = 50;
    //private bool isPatHistNeed = true;
    //public bool IsPatHistNeed
    //{
    //    get { return isPatHistNeed; }
    //    set { isPatHistNeed = value; }
    //}

    #region "Common Resource"

    string strAlert = Resources.CommonControls_AppMsg.CommonControls_PatientDetails_ascx_03 == null ? "Alert" : Resources.CommonControls_AppMsg.CommonControls_PatientDetails_ascx_03;
    string strRemarks = Resources.CommonControls_ClientDisplay.CommonControls_PatientDetails_ascx_02 == null ? "Remarks:" : Resources.CommonControls_ClientDisplay.CommonControls_PatientDetails_ascx_02;
    string strClientName = Resources.CommonControls_ClientDisplay.CommonControls_PatientDetails_ascx_03 == null ? "Client Name:" : Resources.CommonControls_ClientDisplay.CommonControls_PatientDetails_ascx_03;
    string strRefHospital = Resources.CommonControls_ClientDisplay.CommonControls_PatientDetails_ascx_04 == null ? "Ref. Hospital:" : Resources.CommonControls_ClientDisplay.CommonControls_PatientDetails_ascx_04;
    string strRefDoctor = Resources.CommonControls_ClientDisplay.CommonControls_PatientDetails_ascx_05 == null ? "Ref. Doctor:" : Resources.CommonControls_ClientDisplay.CommonControls_PatientDetails_ascx_05;
    string strPatientHistory = Resources.CommonControls_ClientDisplay.CommonControls_PatientDetails_ascx_06 == null ? "Patient History:" : Resources.CommonControls_ClientDisplay.CommonControls_PatientDetails_ascx_06;

    string strMonth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
    string strWeek = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
    string strYear = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
    string strDay = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;
    string strMale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_072 == null ? "M" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_072;
    string strFemale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_073 == null ? "F" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_073;
    string strVet = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_074 == null ? "Vet" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_074;
    string strNa = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_071 == null ? "NA" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_071;
    string strUnknow = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_076 == null ? "U" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_076;
    string strUnknownF = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086 == null ? "UnKnown" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086;
    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        string strLabNo = Resources.CommonControls_ClientDisplay.CommonControls_PatientDetails_ascx_01 == null ? "Lab Number:" : Resources.CommonControls_ClientDisplay.CommonControls_PatientDetails_ascx_01;

        /* Header Patient Details Display Block */
        hdnIsWaters.Value = GetConfigValue("WatersMode", OrgID);

        Int64.TryParse(Request.QueryString["VID"], out VisitID);

        if (VisitID == 0  && (hdnVisitID.Value !="" ))
        {
            VisitID = Convert.ToInt64(hdnVisitID.Value);
        }
        

        if (Request.QueryString["gUID"] != null)
        {
            gUID = Request.QueryString["gUID"].ToString();
        }
        if ((!string.IsNullOrEmpty(Request.QueryString["RNo"])))
        {
            LabNo = Request.QueryString["RNo"].ToString();
        }
        else if ((!string.IsNullOrEmpty(Request.QueryString["LNo"])))
        {
            LabNo = Request.QueryString["LNo"].ToString();
        }
        if (!IsPostBack)
        {
            LoadPatientDetails(VisitID, OrgID, gUID);
            AutoCompleteExtenderRefPhy.ContextKey = "RPH";
            AutoCompleteExtenderReferringHospital.ContextKey = OrgID.ToString();

        }
        string IsNeedExternalVisitIdWaterMark = string.Empty;
        IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitIdWaterMark", OrgID);
        //if (IsNeedExternalVisitIdWaterMark != " ")
        //{
        //    lbexvisitid.Text = IsNeedExternalVisitIdWaterMark;
        //}
        if (IsNeedExternalVisitIdWaterMark == "Y")
        {
            lbexvisitid.Text = strLabNo.Trim();
        }
        else
        {
            lbexvisitid.Text = strLabNo.Trim();
        }
        //  txtwatermark();

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

    public void TocheckHistory(bool val)
    {
        if (val)
        {
            btnOk.Enabled = true;
        }
    }
    public void LoadPatientDetails(long VisitID, int OrgID, string gUID)
    {
        hdnVisitID.Value = VisitID.ToString();

        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
        List<PatientVisit> visitList = new List<PatientVisit>();

        returnCode = patientBL.GetLabVisitDetails(VisitID, OrgID, gUID, out visitList);
        //--Added by vijayalakshmi---//
        if (visitList.Count > 0)
        {
        string str = visitList[0].PatientAge;
        string[] strage = str.Split(' ');
            if (strage.Length > 1)
            {
        if (strage[1] == "Year(s)")
        {
            visitList[0].PatientAge = strage[0] + " " + strYear;

        }
        else if (strage[1] == "Month(s)")
        {
            visitList[0].PatientAge = strage[0] + " " + strMonth;
        }
        else if (strage[1] == "Day(s)")
        {
            visitList[0].PatientAge = strage[0] + " " + strDay;
        }
        else if (strage[1] == "Week(s)")
        {
            visitList[0].PatientAge = strage[0] + " " + strWeek;
        }
        else if (strage[1] == "UnKnown")
        {
            visitList[0].PatientAge = strUnknownF;
        }
        else
        {
            visitList[0].PatientAge = strage[0] + " " + strYear;
            }
        }
        }
        //---- END---//
        if (visitList.Count > 0)
        {
            //-- Purpose : To Show External Visit ID --// 
            //-- Added By : Shobana Raja --// 
            //-- Added At : Sep 11,2013 3.50 P.M --// 
            if (visitList[0].ExternalVisitID != string.Empty)
            {
                lblExVisitId.Text = visitList[0].ExternalVisitID.ToString();
            }
            else
            {
                lblExVisitId.Text = visitList[0].VisitNumber.ToString();
            }
            if (visitList[0].VisitNumber != string.Empty)
            {
                lblVisitNo.Text = visitList[0].VisitNumber.ToString();
            }
            else
            {
                lblVisitNo.Text = "";
            }
            //----------------------------------------------//
            //lblReferingPhysician.Text = visitList[0].ReferingPhysicianName;
            lblPatientName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;
            lblPatientNo.Text = Convert.ToString(visitList[0].PatientNumber);
            lblDate.Text = Convert.ToString(visitList[0].VisitDate.ToString("dd/MM/yyyy HH:mm"));
            lblCollectedDt.Text = Convert.ToString(visitList[0].AdmissionDate.ToString("dd/MM/yyyy HH:mm"));
            lblCollectedDtId.Visible = true;
            lblRefLocation.Text = visitList[0].AccompaniedBy.ToString();
            lblAge.Text = visitList[0].PatientAge.ToString();
            var objaddremarks = from t in visitList
                                where t.RegistrationRemarks != null && t.RegistrationRemarks != string.Empty && t.RegistrationRemarks != ""
                                select new
                                {
                                    t.RegistrationRemarks,
                                    t.IsDayCare,
                                    t.CreatedAt,
                                    t.PatientHistory
                                };
            grdRemarks.DataSource = objaddremarks;
            grdRemarks.DataBind();
            grdRemarks1.DataSource = objaddremarks;
            grdRemarks1.DataBind();
            var objcount = (from t1 in visitList
                            where t1.RegistrationRemarks != null && t1.RegistrationRemarks != string.Empty && t1.RegistrationRemarks != ""
                            select t1.RegistrationRemarks).Count();
            int count = objcount;
            if (count > 1)
            {
                imgchanges2.Visible = true;
            }
            else
            {
                imgchanges2.Visible = false;
            }
            if (visitList[0].PatientVisitId.ToString() != null || visitList[0].PatientVisitId.ToString() != "")
            {
                hdnVID.Value = visitList[0].PatientVisitId.ToString();
            }
            string[] AgeValues;
            string Ageval = string.Empty;
            if (visitList[0].NurseNotes.ToString() != null || visitList[0].NurseNotes.ToString() != "")
            {
                AgeValues = visitList[0].NurseNotes.Split('.');

                if (AgeValues[0] != "")
                {
                    if (AgeValues[0] != "0" && AgeValues[1] != "0")
                    {
                        Ageval = (AgeValues[0] + "." + AgeValues[1] + strYear).ToString();
                        lblAge.Text = Ageval;
                    }
                }
            }
            if (visitList[0].Sex == "M")
            {
                lblGender.Text = strMale + "/" + visitList[0].PatientAge.ToString();
                hdnGender.Value = "Male";
                if (visitList[0].NurseNotes != null)
                {
                    AgeValues = visitList[0].NurseNotes.Split('.');
                    if (AgeValues[0] != "")
                    {
                        lblGender.Text = strMale + "/" + Ageval;
                    }
                }
            }
            else if (visitList[0].Sex == "F")
            {
                lblGender.Text = strFemale + "/" + visitList[0].PatientAge.ToString();
                hdnGender.Value = "Female";
                if (visitList[0].NurseNotes != null)
                {
                    AgeValues = visitList[0].NurseNotes.Split('.');
                    if (AgeValues[0] != "")
                    {
                        lblGender.Text = strFemale+ "/" + Ageval;
                    }
                }
            }
            else if (visitList[0].Sex == "V")
            {
                lblGender.Text = strVet + "/" + visitList[0].PatientAge.ToString();
                hdnGender.Value = "Vet";
                if (visitList[0].NurseNotes != null)
                {
                    AgeValues = visitList[0].NurseNotes.Split('.');
                    if (AgeValues[0] != "")
                    {
                        lblGender.Text = strVet + "/" + Ageval;
                    }
                }
            }
            else if (visitList[0].Sex == "N")
            {
                lblGender.Text = strNa+ "/" + visitList[0].PatientAge.ToString();
                hdnGender.Value = "NA";
                if (visitList[0].NurseNotes != null)
                {
                    AgeValues = visitList[0].NurseNotes.Split('.');
                    if (AgeValues[0] != "")
                    {
                        lblGender.Text = strNa+ "/" + Ageval;
                    }
                }
            }
            else if (visitList[0].Sex == "U") //Added by Babu Mani on 24 Jan 2015 to address reference range issue (i.e. if unknown then ui it is displaying "F")
            {
                lblGender.Text = strUnknow+ "/" + visitList[0].PatientAge.ToString();
                if (visitList[0].PatientAge.ToString().Contains("UnKnown"))
                {
                    lblGender.Text = strUnknownF;
                }
                hdnGender.Value = "Unknown";
            }
            else if (visitList[0].Sex == "0")
            {
                lblGender.Text = visitList[0].PatientAge.ToString();
                if (visitList[0].PatientAge.ToString().Contains("UnKnown"))
                {
                    lblGender.Text = strUnknownF;
                }
                hdnGender.Value = "Unknown";
            }
            else
            {
                lblGender.Text = "";
                hdnGender.Value = "0";
            }
            if (visitList[0].ReferenceRangeAge != null)
            {
                lblReferenceRangeAge.Text = visitList[0].ReferenceRangeAge.ToString();
            }
            if (!String.IsNullOrEmpty(visitList[0].AgeDays))
            {
                hdnAgeDays.Value = visitList[0].AgeDays;
            }
            //lblAge.Text = visitList[0].PatientAge.ToString();
            //Patient History
            if (!string.IsNullOrEmpty(visitList[0].PatientHistory) && IsPatHistNeed)
            {
                trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                tdPatHist.Attributes.Add("style", "display:table-cell");
                // mPatienthistory.Attributes.Add("style", "display:block");
                lblPatHist.Text = SetCountChars(visitList[0].PatientHistory, SetHistLength);
                lbpathist.Visible = true;
                string strtemp = "" + strPatientHistory.Trim() + " " + visitList[0].PatientHistory;
                lblPatHist.ToolTip = strtemp;
                txtpatientHist.Text = "";// visitList[0].PatientHistory;//History changes
                //lblPatHist.Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                //lblPatHist.Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");                 
            }
            else
            {
                lblPatHist.Text = "";
            }
            string ResultValue = string.Empty;
            ResultValue = GetConfigValue("LabNo", OrgID);
            if (ResultValue == "Y")
            {

                if ((!string.IsNullOrEmpty(LabNo)))
                {

                    lblLabNo.Text = LabNo;
                    trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                    tdLabNo1.Attributes.Add("style", "display:table-cell");
                    tdLabNo2.Attributes.Add("style", "display:table-cell");
                }
            }

            string UseWardnoAssrfid = GetConfigValue("UseWardnoAsSRFID", OrgID);
            if (UseWardnoAssrfid == "Y")
            {
                if (visitList[0].ReportMode != "" || visitList[0].PhysicianPhoneNo != "")
                {
                    trsrf.Style.Add("display", "table-row");
					tdsrfid.Style.Add("display", "table-cell");
					tdtrfid.Style.Add("display", "table-cell");
                } 
                if(visitList[0].ReportMode=="")
                {
                    tdsrfid.Style.Add("display", "none");
                }
                if (visitList[0].PhysicianPhoneNo == "")
                {
                    tdtrfid.Style.Add("display", "none");
                }
                txtsrfid.Text = visitList[0].ReportMode;
                txttrfid.Text = visitList[0].PhysicianPhoneNo;
                
            }
            //Remarks
            if (!string.IsNullOrEmpty(visitList[0].RegistrationRemarks))
            {
                if (!string.IsNullOrEmpty(visitList[0].RegistrationRemarks))
                {
                    string txtRemark = string.Empty;
                    string Createdby = string.Empty;
                    Createdby = visitList[0].IsDayCare;
                    //txtRemark = visitList[0].RegistrationRemarks + " By " + Createdby;
                    //lblRemarks.Text = "Remarks by :" + SetCountChars(txtRemark, SetHistLength);
                    txtRemark = visitList[0].RegistrationRemarks;
                    string funtxtRemark = SetCountChars(txtRemark, SetHistLength);
                    lblRemarks.Text = funtxtRemark + " (" + Createdby + ")";
                    lblRemarksId.Visible = true;
                    string strtemp = "" + strRemarks.Trim() + " " + visitList[0].RegistrationRemarks;
                    lblRemarks.ToolTip = strtemp;
                    trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                    tdRemarks.Attributes.Add("style", "display:table-cell");
                    //mremarks.Attributes.Add("style", "display:block");
                    txtRemarks.Text = "";// visitList[0].RegistrationRemarks;//History
                    //History
                }
            }
            else
            {
                lblRemarks.Text = "";
            }

            //Client Name
            if (!string.IsNullOrEmpty(visitList[0].ClientName))
            {
                lblClientName.Text = SetCountChars(visitList[0].ClientName, SetHistLength);
                lblClientNameId.Visible = true;
                string strtemp = "" + strClientName.Trim() + " " + visitList[0].ClientName;
                lblClientName.ToolTip = strtemp;
                trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                tdClientName.Attributes.Add("style", "display:table-cell");
                hdnClientID.Value = visitList[0].ClientID.ToString();
            }
            //Ref Hospital
            if (!string.IsNullOrEmpty(visitList[0].HospitalName))
            {
                lblRefHospital.Text = SetCountChars(visitList[0].HospitalName, SetHistLength);
                lblRefHospitalId.Visible = true;
                string strtemp = "" + strRefHospital.Trim() + " " + visitList[0].HospitalName;
                lblRefHospital.ToolTip = strtemp;
                trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                tdRefHospital.Attributes.Add("style", "display:table-cell");
                // mrefhospitals.Attributes.Add("style", "display:block");
                txtrefhospitals.Text = visitList[0].HospitalName;//History
                hdfReferalHospitalID.Value = visitList[0].HospitalID.ToString();
            }
            else
            {
                lblRefHospital.Text = "";
            }

            //Ref Doctor
            if (!string.IsNullOrEmpty(visitList[0].ReferingPhysicianName))
            {
                lblRefDoctor.Text = SetCountChars(visitList[0].ReferingPhysicianName, SetHistLength);
                lblRefDoctorId.Visible = true;
                string strtemp = "" + strRefDoctor.Trim() + " " + visitList[0].ReferingPhysicianName;
                lblRefDoctor.ToolTip = strtemp;
                trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                tdRefDoctor.Attributes.Add("style", "display:table-cell");
                // mrefdoctors.Attributes.Add("style", "display:block");
                txtRefdoctors.Text = visitList[0].ReferingPhysicianName;//History
                hdnPhysicianValue.Value = visitList[0].ReferingPhysicianID.ToString();
            }
            else
            {
                lblRefDoctor.Text = "";
            }

            if (!String.IsNullOrEmpty(visitList[0].HistoNumber))
            {
                lblHistopathNo.Text = visitList[0].HistoNumber;
               lblhistoID.Visible = true;                
                
            }
            else
            {
                lblHistopathNo.Text = "";
            }




                //if ((!string.IsNullOrEmpty(visitList[0].HospitalName))|| (!string.IsNullOrEmpty(visitList[0].HospitalName)) || (!string.IsNullOrEmpty(visitList[0].RegistrationRemarks)) || (!string.IsNullOrEmpty(visitList[0].PatientHistory)))
                //{
                //    imges.Attributes.Add("style", "display:block");
                //}
                if (hdnIsWaters.Value == "Y")
                {
                    if (!String.IsNullOrEmpty(visitList[0].IsIntegration))
                    {
                        WaterstxtSampleID.Text = visitList[0].IsIntegration;//SampleID
                    }

                    if (!String.IsNullOrEmpty(visitList[0].IsWalkIn))
                    {
                        WaterstxtBarcode.Text = visitList[0].IsWalkIn;//BarcodeNumber
                    }

                    if (!String.IsNullOrEmpty(visitList[0].EmpDeptCode))
                    {
                        WaterstxtSampleDesc.Text = visitList[0].EmpDeptCode;//SampleDescription
                    }

                    if (!String.IsNullOrEmpty(visitList[0].VisitNumber))
                    {
                        WaterstxtVisitNo.Text = visitList[0].VisitNumber;//VisitNumber
                    }


                    WaterstxtRegDate.Text = Convert.ToString(visitList[0].VisitDate.ToString("dd/MM/yyyy HH:mm")); ;//VisitDate
                    lblpatdet.Text = "Sample Details";
                    tbPatientDetails.Visible = false;
                    tbPatientDetails1.Visible = false;



                }
                else {

                    Waters.Visible = false;
                
                }

            }
        //}

    }
    public string SetCountChars(string value, int Length)
    {
        int result = 0;
        bool lastWasSpace = false;
        string NewValue = string.Empty;
        foreach (char c in value)
        {
            if (char.IsWhiteSpace(c))
            {
                // Only count sequential spaces one time.
                if (lastWasSpace == false)
                {
                    result++;
                }
                lastWasSpace = true;
                NewValue += c;
            }
            else
            {
                // Count other characters every time.
                result++;
                lastWasSpace = false;
                NewValue += c;
            }
            if (result == Length)
            {
                NewValue = NewValue + "...";
                break;
            }
        }
        return NewValue;
    }
    private bool isPatHistNeed = true;
    public bool IsPatHistNeed
    {
        get { return isPatHistNeed; }
        set { isPatHistNeed = value; }
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        string strSaveSuccess = Resources.CommonControls_AppMsg.CommonControls_PatientDetails_ascx_01 == null ? "Saved Successfully!" : Resources.CommonControls_AppMsg.CommonControls_PatientDetails_ascx_01;
        string strValidate = Resources.CommonControls_AppMsg.CommonControls_PatientDetails_ascx_02 == null ? "Please enter remark to save" : Resources.CommonControls_AppMsg.CommonControls_PatientDetails_ascx_02;
        try
        {
            if (txtRemarks.Text != "")
            {
                long returncode = -1;
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                PatientVisit Pv = new PatientVisit();
                Pv.PatientHistory = txtpatientHist.Text;
                Pv.Remarks = txtRemarks.Text;
                Pv.ReferingPhysicianName = txtRefdoctors.Text;
                Pv.HospitalName = txtrefhospitals.Text;
                Pv.ReferingPhysicianID = Convert.ToInt32(hdnPhysicianValue.Value);
                Pv.HospitalID = Convert.ToInt32(hdfReferalHospitalID.Value);
                //Pv.ParentVisitId = VisitID;
                Pv.ParentVisitId = VisitID;
                if (!string.IsNullOrEmpty(lblVisitNo.Text))
                {
                    //VisitID=Convert.ToInt64(lblVisitNo.Text);
                    Pv.ParentVisitId = VisitID;
                }


                returncode = patientBL.updatePatientvisitchanges(Pv, OrgID);
                if (returncode > 0)
                {
                    mpePatternSelection.Hide();
                    /*******Modified By arivalagan.kk for  slowly save remarks and histiry********/
                    //LoadPatientDetails(VisitID, OrgID, gUID);
                    LoadRemarksDetails(VisitID, OrgID, gUID);
                    /*******End Modified By arivalagan.kk for  slowly save remarks and histiry********/
                    //hdnPhysicianValue.Value = "0";
                    //hdfReferalHospitalID.Value = "0";
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "ValidationWindow('" + strSaveSuccess.Trim() + "','" + strAlert.Trim() + "');", true);

            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "ValidationWindow('" + strValidate.Trim() + "','" + strAlert.Trim() + "');", true);
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error While update Patientvisit changes", ex);
        }

    }
    
    private void LoadRemarksDetails(long VisitID, int OrgID, string gUID)
    {
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
        List<PatientVisit> visitList = new List<PatientVisit>();

        returnCode = patientBL.GetLabVisitDetails(VisitID, OrgID, gUID, out visitList);

        if (visitList.Count > 0)
        {
            //Modified by Arivalagan.kk For  performance//
            //-- Purpose : To Show External Visit ID --// 
            //-- Added By : Shobana Raja --// 
            //-- Added At : Sep 11,2013 3.50 P.M --// 
            //if (visitList[0].ExternalVisitID != string.Empty)
            //{
            //    lblExVisitId.Text = visitList[0].ExternalVisitID.ToString();
            //}
            //else
            //{
            //    lblExVisitId.Text = visitList[0].VisitNumber.ToString();
            //}
            //if (visitList[0].VisitNumber != string.Empty)
            //{
            //    lblVisitNo.Text = visitList[0].VisitNumber.ToString();
            //}
            //else
            //{
            //    lblVisitNo.Text = "";
            //}
            //----------------------------------------------//
            //lblReferingPhysician.Text = visitList[0].ReferingPhysicianName;
            //lblPatientName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;
            //lblPatientNo.Text = Convert.ToString(visitList[0].PatientNumber);
            //lblDate.Text = Convert.ToString(visitList[0].VisitDate.ToString("dd/MM/yyyy HH:mm"));
            //lblCollectedDt.Text = Convert.ToString(visitList[0].AdmissionDate.ToString("dd/MM/yyyy HH:mm"));
            //lblCollectedDtId.Visible = true;
            //lblRefLocation.Text = visitList[0].AccompaniedBy.ToString();
            //lblAge.Text = visitList[0].PatientAge.ToString();
            var objaddremarks = from t in visitList
                                where t.RegistrationRemarks != null && t.RegistrationRemarks != string.Empty && t.RegistrationRemarks != ""
                                select new
                                {
                                    t.RegistrationRemarks,
                                    t.IsDayCare,
                                    t.CreatedAt,
                                    t.PatientHistory
                                };
            grdRemarks.DataSource = objaddremarks;
            grdRemarks.DataBind();
            grdRemarks1.DataSource = objaddremarks;
            grdRemarks1.DataBind();
            var objcount = (from t1 in visitList
                            where t1.RegistrationRemarks != null && t1.RegistrationRemarks != string.Empty && t1.RegistrationRemarks != ""
                            select t1.RegistrationRemarks).Count();
            int count = objcount;
            if (count > 1)
            {
                imgchanges2.Visible = true;
            }
            else
            {
                imgchanges2.Visible = false;
            }
            //if (visitList[0].PatientVisitId.ToString() != null || visitList[0].PatientVisitId.ToString() != "")
            //{
            //    hdnVID.Value = visitList[0].PatientVisitId.ToString();
            //}
            //string[] AgeValues;
            //string Ageval = string.Empty;
            //if (visitList[0].NurseNotes.ToString() != null || visitList[0].NurseNotes.ToString() != "")
            //{
            //    AgeValues = visitList[0].NurseNotes.Split('.');

            //    if (AgeValues[0] != "")
            //    {
            //        if (AgeValues[0] != "0" && AgeValues[1] != "0")
            //        {
            //            Ageval = (AgeValues[0] + "." + AgeValues[1] + "Year(s)").ToString();
            //            lblAge.Text = Ageval;
            //        }
            //    }
            //}
            //if (visitList[0].Sex == "M")
            //{
            //    lblGender.Text = "M" + "/" + visitList[0].PatientAge.ToString();
            //    hdnGender.Value = "Male";
            //    if (visitList[0].NurseNotes != null)
            //    {
            //        AgeValues = visitList[0].NurseNotes.Split('.');
            //        if (AgeValues[0] != "")
            //        {
            //            lblGender.Text = "M" + "/" + Ageval;
            //        }
            //    }
            //}
            //else if (visitList[0].Sex == "F")
            //{
            //    lblGender.Text = "F" + "/" + visitList[0].PatientAge.ToString();
            //    hdnGender.Value = "Female";
            //    if (visitList[0].NurseNotes != null)
            //    {
            //        AgeValues = visitList[0].NurseNotes.Split('.');
            //        if (AgeValues[0] != "")
            //        {
            //            lblGender.Text = "F" + "/" + Ageval;
            //        }
            //    }
            //}
            //else if (visitList[0].Sex == "V")
            //{
            //    lblGender.Text = "Vet" + "/" + visitList[0].PatientAge.ToString();
            //    hdnGender.Value = "Vet";
            //    if (visitList[0].NurseNotes != null)
            //    {
            //        AgeValues = visitList[0].NurseNotes.Split('.');
            //        if (AgeValues[0] != "")
            //        {
            //            lblGender.Text = "Vet" + "/" + Ageval;
            //        }
            //    }
            //}
            //else if (visitList[0].Sex == "N")
            //{
            //    lblGender.Text = "N" + "/" + visitList[0].PatientAge.ToString();
            //    hdnGender.Value = "NA";
            //    if (visitList[0].NurseNotes != null)
            //    {
            //        AgeValues = visitList[0].NurseNotes.Split('.');
            //        if (AgeValues[0] != "")
            //        {
            //            lblGender.Text = "N" + "/" + Ageval;
            //        }
            //    }
            //}
            //else if (visitList[0].Sex == "U") //Added by Babu Mani on 24 Jan 2015 to address reference range issue (i.e. if unknown then ui it is displaying "F")
            //{
            //    lblGender.Text = "U" + "/" + visitList[0].PatientAge.ToString();
            //    hdnGender.Value = "Unknown";
            //}
            //else
            //{
            //    lblGender.Text = "";
            //    hdnGender.Value = "0";
            //}
            //if (visitList[0].ReferenceRangeAge != null)
            //{
            //    lblReferenceRangeAge.Text = visitList[0].ReferenceRangeAge.ToString();
            //}
            //if (!String.IsNullOrEmpty(visitList[0].AgeDays))
            //{
            //    hdnAgeDays.Value = visitList[0].AgeDays;
            //}
            //lblAge.Text = visitList[0].PatientAge.ToString();
            //Patient History
            if (!string.IsNullOrEmpty(visitList[0].PatientHistory) && IsPatHistNeed)
            {
                trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                tdPatHist.Attributes.Add("style", "display:table-cell");
                // mPatienthistory.Attributes.Add("style", "display:block");
                lblPatHist.Text = SetCountChars(visitList[0].PatientHistory, SetHistLength);
                lbpathist.Visible = true;
                string strtemp = "" + strPatientHistory.Trim() + " " + visitList[0].PatientHistory;
                lblPatHist.ToolTip = strtemp;
                //Changed By Arivalgan.kk To show the History in result entry page.//
                //txtpatientHist.Text = "";
                txtpatientHist.Text = visitList[0].PatientHistory;//History changes
                //Changed By Arivalgan.kk To show the History in result entry page.//

                //lblPatHist.Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                //lblPatHist.Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");                 
            }
            else
            {
                lblPatHist.Text = "";
            }
            //string ResultValue = string.Empty;
            //ResultValue = GetConfigValue("LabNo", OrgID);
            //if (ResultValue == "Y")
            //{

            //    if ((!string.IsNullOrEmpty(LabNo)))
            //    {

            //        lblLabNo.Text = LabNo;
            //        trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
            //        tdLabNo1.Attributes.Add("style", "display:table-cell");
            //        tdLabNo2.Attributes.Add("style", "display:table-cell");
            //    }
            //}

            //Remarks
            if (!string.IsNullOrEmpty(visitList[0].RegistrationRemarks))
            {
                if (!string.IsNullOrEmpty(visitList[0].RegistrationRemarks))
                {
                    string txtRemark = string.Empty;
                    string Createdby = string.Empty;
                    Createdby = visitList[0].IsDayCare;
                    //txtRemark = visitList[0].RegistrationRemarks + " By " + Createdby;
                    //lblRemarks.Text = "Remarks by :" + SetCountChars(txtRemark, SetHistLength);
                    txtRemark = visitList[0].RegistrationRemarks;
                    string funtxtRemark = SetCountChars(txtRemark, SetHistLength);
                    lblRemarks.Text = funtxtRemark + " (" + Createdby + ")";
                    lblRemarksId.Visible = true;
                    string strtemp = "" + strRemarks.Trim() + " " + visitList[0].RegistrationRemarks;
                    lblRemarks.ToolTip = strtemp;
                    trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                    tdRemarks.Attributes.Add("style", "display:table-cell");
                    //mremarks.Attributes.Add("style", "display:block");
                    //Changed By Arivalgan.kk To show the remarks in result entry.//
                    //txtRemarks.Text = "";
                    txtRemarks.Text =  visitList[0].RegistrationRemarks;//History
                    //History
                    //Changed By Arivalgan.kk To show the remarks in result entry.//
                }
            }
            else
            {
                lblRemarks.Text = "";
            }

            //Client Name
            if (!string.IsNullOrEmpty(visitList[0].ClientName))
            {
                lblClientName.Text = SetCountChars(visitList[0].ClientName, SetHistLength);
                lblClientNameId.Visible = true;
                string strtemp = "" + strClientName.Trim() + " " + visitList[0].ClientName;
                lblClientName.ToolTip = strtemp;
                trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                tdClientName.Attributes.Add("style", "display:table-cell");
                hdnClientID.Value = visitList[0].ClientID.ToString();
            }
            //Ref Hospital
            if (!string.IsNullOrEmpty(visitList[0].HospitalName))
            {
                lblRefHospital.Text = SetCountChars(visitList[0].HospitalName, SetHistLength);
                lblRefHospitalId.Visible = true;
                string strtemp = "" + strRefHospital.Trim() + " " + visitList[0].HospitalName;
                lblRefHospital.ToolTip = strtemp;
                trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                tdRefHospital.Attributes.Add("style", "display:table-cell");
                // mrefhospitals.Attributes.Add("style", "display:block");
                txtrefhospitals.Text = visitList[0].HospitalName;//History
                hdfReferalHospitalID.Value = visitList[0].HospitalID.ToString();
            }
            else
            {
                lblRefHospital.Text = "";
            }

            //Ref Doctor
            if (!string.IsNullOrEmpty(visitList[0].ReferingPhysicianName))
            {
                lblRefDoctor.Text = SetCountChars(visitList[0].ReferingPhysicianName, SetHistLength);
                lblRefDoctorId.Visible = true;
                string strtemp = "" + strRefDoctor.Trim() + " " + visitList[0].ReferingPhysicianName;
                lblRefDoctor.ToolTip = strtemp;
                trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                tdRefDoctor.Attributes.Add("style", "display:table-cell");
                // mrefdoctors.Attributes.Add("style", "display:block");
                txtRefdoctors.Text = visitList[0].ReferingPhysicianName;//History
                hdnPhysicianValue.Value = visitList[0].ReferingPhysicianID.ToString();
            }
            else
            {
                lblRefDoctor.Text = "";
            }
        }
    }
    public void LoadPatientDetailsForBarcode(long VisitID, int OrgID, string gUID, string LabNo, out int isEmpty)
    {
        isEmpty = 0;
        base.ContextInfo.AdditionalInfo = LabNo;
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
        List<PatientVisit> visitList = new List<PatientVisit>();

        returnCode = patientBL.GetLabVisitDetails(VisitID, OrgID, gUID, out visitList);

        if (visitList.Count > 0)
        {
            //-- Purpose : To Show External Visit ID --// 
            //-- Added By : Shobana Raja --// 
            //-- Added At : Sep 11,2013 3.50 P.M --// 
            if (visitList[0].ExternalVisitID != string.Empty)
            {
                lblExVisitId.Text = visitList[0].ExternalVisitID.ToString();
            }
            else
            {
                lblExVisitId.Text = visitList[0].VisitNumber.ToString();
            }
            if (visitList[0].VisitNumber != string.Empty)
            {
                lblVisitNo.Text = visitList[0].VisitNumber.ToString();
            }
            else
            {
                lblVisitNo.Text = "";
            }
            //----------------------------------------------//
            //lblReferingPhysician.Text = visitList[0].ReferingPhysicianName;
            lblPatientName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;
            lblPatientNo.Text = Convert.ToString(visitList[0].PatientNumber);
            lblDate.Text = Convert.ToString(visitList[0].VisitDate.ToString("dd/MM/yyyy HH:mm"));
            lblCollectedDt.Text = Convert.ToString(visitList[0].AdmissionDate.ToString("dd/MM/yyyy HH:mm"));
            lblCollectedDtId.Visible = true;
            lblRefLocation.Text = visitList[0].AccompaniedBy.ToString();
            grdRemarks.DataSource = from t in visitList
                                    select new
                                    {
                                        t.RegistrationRemarks,
                                        t.IsDayCare,
                                        t.CreatedAt,
                                        t.PatientHistory
                                    };
            grdRemarks.DataBind();

            //--Added by vijayalakshmi---//
            if (visitList.Count > 0)
            {
            string str = visitList[0].PatientAge;
            string[] strage = str.Split(' ');
            if (strage[1] == "Year(s)")
            {
                visitList[0].PatientAge = strage[0] + " " + strYear;
            }
            else if (strage[1] == "Month(s)")
            {
                visitList[0].PatientAge = strage[0] + " " + strMonth;
            }
            else if (strage[1] == "Day(s)")
            {
                visitList[0].PatientAge = strage[0] + " " + strDay;
            }
            else if (strage[1] == "Week(s)")
            {
                visitList[0].PatientAge = strage[0] + " " + strWeek;
            }
            else if (strage[1] == "Unknown")
            {
                visitList[0].PatientAge = strUnknownF;
            }
            else
            {
                visitList[0].PatientAge = strage[0] + " " + strYear;
            }
            //---- END---//
            if (visitList[0].Sex == "M")
            {
                lblGender.Text = strMale + "/" + visitList[0].PatientAge.ToString();
                hdnGender.Value = "Male";
            }
            else if (visitList[0].Sex == "F") //Added by Babu Mani on 24 Jan 2015 to address reference range issue (i.e. if unknown then ui it is displaying "F")
            {
                lblGender.Text = strFemale + "/" + visitList[0].PatientAge.ToString();
                hdnGender.Value = "Female";
            }
            else if (visitList[0].Sex == "U") //Added by Babu Mani on 24 Jan 2015 to address reference range issue (i.e. if unknown then ui it is displaying "F")
            {
                lblGender.Text = strUnknow + "/" + visitList[0].PatientAge.ToString();
                if (visitList[0].PatientAge.ToString().Contains("Unknown"))
                {
                    lblGender.Text = strUnknownF;
                }
                hdnGender.Value = "Unknown";
                }
            }
            else if (visitList[0].Sex == "N") //Added by Babu Mani on 24 Jan 2015 to address reference range issue (i.e. if unknown then ui it is displaying "F")
            {
                lblGender.Text = strNa + "/" + visitList[0].PatientAge.ToString();
                hdnGender.Value = "NA";
            }
            lblAge.Text = visitList[0].PatientAge.ToString();
            if (visitList[0].ReferenceRangeAge != null)
            {
                lblReferenceRangeAge.Text = visitList[0].ReferenceRangeAge.ToString();
            }
            if (!String.IsNullOrEmpty(visitList[0].AgeDays))
            {
                hdnAgeDays.Value = visitList[0].AgeDays;
            }
            //Patient History
            if (!string.IsNullOrEmpty(visitList[0].PatientHistory) && IsPatHistNeed)
            {
                trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                tdPatHist.Attributes.Add("style", "display:table-cell");
                // mPatienthistory.Attributes.Add("style", "display:block");
                lblPatHist.Text = SetCountChars(visitList[0].PatientHistory, SetHistLength);
                lbpathist.Visible = false;
                string strtemp = "" + strPatientHistory.Trim() + " " + visitList[0].PatientHistory;
                lblPatHist.ToolTip = strtemp;
                txtpatientHist.Text = "";// visitList[0].PatientHistory;//History changes
                //lblPatHist.Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                //lblPatHist.Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");                 
            }
            else
            {
                lblPatHist.Text = "";
            }

            string ResultValue = string.Empty;
            ResultValue = GetConfigValue("LabNo", OrgID);
            if (ResultValue == "Y")
            {

                if ((!string.IsNullOrEmpty(LabNo)))
                {

                    lblLabNo.Text = LabNo;
                    trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                    tdLabNo1.Attributes.Add("style", "display:table-cell");
                    tdLabNo2.Attributes.Add("style", "display:table-cell");
                }
            }

            //Remarks
            if (!string.IsNullOrEmpty(visitList[0].RegistrationRemarks))
            {
                if (!string.IsNullOrEmpty(visitList[0].RegistrationRemarks))
                {
                    string txtRemark = string.Empty;
                    string Createdby = string.Empty;
                    Createdby = visitList[0].IsDayCare;
                    //txtRemark = visitList[0].RegistrationRemarks + " By " + Createdby;

                    //lblRemarks.Text = "Remarks by :" + SetCountChars(txtRemark, SetHistLength);
                    txtRemark = visitList[0].RegistrationRemarks;
                    string funtxtRemark = SetCountChars(txtRemark, SetHistLength);
                    lblRemarks.Text = funtxtRemark + " (" + Createdby + ")";
                    lblRemarksId.Visible = true;

                    string strtemp = "" + strRemarks.Trim() + " " + visitList[0].RegistrationRemarks;
                    lblRemarks.ToolTip = strtemp;
                    trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                    tdRemarks.Attributes.Add("style", "display:table-cell");
                    //mremarks.Attributes.Add("style", "display:block");
                    txtRemarks.Text = "";// visitList[0].RegistrationRemarks;//History
                    //History
                }
            }
            else
            {
                lblRemarks.Text = "";
            }

            //Client Name
            if (!string.IsNullOrEmpty(visitList[0].ClientName))
            {
                lblClientName.Text = SetCountChars(visitList[0].ClientName, SetHistLength);
                lblClientNameId.Visible = true;
                string strtemp = "" + strClientName.Trim() + " " + visitList[0].ClientName;
                lblClientName.ToolTip = strtemp;
                trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                tdClientName.Attributes.Add("style", "display:table-cell");
            }
            //Ref Hospital
            if (!string.IsNullOrEmpty(visitList[0].HospitalName))
            {
                lblRefHospital.Text = SetCountChars(visitList[0].HospitalName, SetHistLength);
                lblRefHospitalId.Visible = true;
                string strtemp = "" + strRefHospital.Trim() + " " + visitList[0].HospitalName;
                lblRefHospital.ToolTip = strtemp;
                trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                tdRefHospital.Attributes.Add("style", "display:table-cell");
                // mrefhospitals.Attributes.Add("style", "display:block");
                txtrefhospitals.Text = visitList[0].HospitalName;//History
                hdfReferalHospitalID.Value = visitList[0].HospitalID.ToString();
            }
            else
            {
                lblRefHospital.Text = "";
            }

            //Ref Doctor
            if (!string.IsNullOrEmpty(visitList[0].ReferingPhysicianName))
            {
                lblRefDoctor.Text = SetCountChars(visitList[0].ReferingPhysicianName, SetHistLength);
                lblRefDoctorId.Visible = true;
                string strtemp = "" + strRefDoctor.Trim() + " " + visitList[0].ReferingPhysicianName;
                lblRefDoctor.ToolTip = strtemp;
                trPatHistAndLabNo.Attributes.Add("style", "display:table-row");
                tdRefDoctor.Attributes.Add("style", "display:table-cell");
                // mrefdoctors.Attributes.Add("style", "display:block");
                txtRefdoctors.Text = visitList[0].ReferingPhysicianName;//History
                hdnPhysicianValue.Value = visitList[0].ReferingPhysicianID.ToString();
            }
            else
            {
                lblRefDoctor.Text = "";
            }

            //if ((!string.IsNullOrEmpty(visitList[0].HospitalName))|| (!string.IsNullOrEmpty(visitList[0].HospitalName)) || (!string.IsNullOrEmpty(visitList[0].RegistrationRemarks)) || (!string.IsNullOrEmpty(visitList[0].PatientHistory)))
            //{
            //    imges.Attributes.Add("style", "display:block");
            //}

            if (visitList[0].PatientVisitId != null)
            {
                Session["Visitid"] = visitList[0].PatientVisitId.ToString();
            }

        }
        else
        {
            isEmpty = 1;
        }
    }

    public string GetSampleID(out string SampleID) {


        if (hdnIsWaters.Value == "Y")
        {
            SampleID = WaterstxtSampleID.Text.ToString();
        }

        else {

            SampleID = "";
        }

        return SampleID;
    
    
    
    }
}