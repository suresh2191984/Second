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

public partial class InPatient_NeonatalNotes : BasePage
{
    public InPatient_NeonatalNotes()
        : base("InPatient\\NeonatalNotes.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    #region Declaration_Region
    int NewVitalsSetID = -1;
    long patientVisitID = -1;    
    long patientID = -1;
    long retCode = -1;
    string InvDrugData = string.Empty;
    string pType = string.Empty;
    List<PatientHistoryExt> lstPatientHistoryExt = new List<PatientHistoryExt>();
    List<BackgroundProblem> lstRiskFactor = new List<BackgroundProblem>();
    List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
    List<Examination> lstExamination = new List<Examination>();    
    List<PatientExamination> lstPatientExamination = new List<PatientExamination>(); 
    List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
    List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
    List<PatientBabyVaccination> lstPBV = new List<PatientBabyVaccination>();
    List<NeonatalNotes> lstNeonatalNotes = new List<NeonatalNotes>();
   
    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            ComplaintICDCode1.ComplaintHeader = "Risk Factors";
            ComplaintICDCode1.SetWidth(500);

            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);           
            Int64.TryParse(Request.QueryString["pid"], out patientID);

            patientHeader.PatientID = patientID;
            patientHeader.PatientVisitID = patientVisitID;
            patientHeader.ShowVitalsDetails();

          

            List<Config> lstConfigDD = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
            if (lstConfigDD.Count > 0)
            {
                InvDrugData = lstConfigDD[0].ConfigValue.Trim();
            }
            if (InvDrugData == "Y")
            {
                uAd.Visible = false;
                uIAdv.Visible = true;
            }
            else
            {
                uAd.Visible = true;
                uIAdv.Visible = false;
            }

            if (patientVisitID != 0)
            {
                GetNeonatalNotesForUpade(InvDrugData);
            }

            if(lstNeonatalNotes.Count>0)
            {
                hdnType.Value = "U";
                GetSystemicExaminatiom();
            }
            else
            {
                hdnType.Value = "I";
                GetSystemicExaminatiom();
            }

            if (lstPatientVitals.Count > 0)
            {
                string type = "NNU";
                uctlPatientVitals.VisitID = patientVisitID;
                uctlPatientVitals.LoadControls(type, patientVisitID);
            }
            else
            {
                string type = "I";
                uctlPatientVitals.VisitID = patientVisitID;
                uctlPatientVitals.LoadControls(type, patientID);
            }


           
        }
    }



    public void GetNeonatalNotesForUpade(string strInvDrugData)
    {
        retCode = -1;
        retCode = new Neonatal_BL(base.ContextInfo).GetNeonatalNotesForUpdate(patientVisitID, out lstPatientHistoryExt, out lstRiskFactor, out lstPatientVitals, out lstPatientExamination, out lstPatientAdvice, out lstDrugDetails, out lstPBV, out lstNeonatalNotes);


        if (lstRiskFactor.Count > 0)
        {
            ComplaintICDCode1.SetPatientBackgroundProblem(lstRiskFactor);

            //int i = 220;
            //foreach (BackgroundProblem objBP in lstRiskFactor)
            //{
            //    hdnDiagnosisItems.Value += i + "~" + objBP.ComplaintName + "^";
            //    i += 1;
            //}
        }

        if (lstDrugDetails.Count > 0)
        {
            if (strInvDrugData == "Y")
            {
                uIAdv.SetPrescription(lstDrugDetails);
            }
            else
            {
                uAd.SetPrescription(lstDrugDetails);
            }
        }

        if (lstPatientAdvice.Count > 0)
        {
            uGAdv.setGeneralAdvice(lstPatientAdvice);
        }


        if (lstPatientHistoryExt.Count > 0)
        {
            txtBrfHistory.Text = lstPatientHistoryExt[0].DetailHistory;
        }


        if (lstPBV.Count > 0)
        {
            foreach (var objPBV in lstPBV)
            {
                if (objPBV.VaccinationID == 2)
                {
                    chkHepatitisb.Checked = true;
                }

                if (objPBV.VaccinationID == 13)
                {
                    chkInjectionvitamin.Checked = true;
                }
            }
        }

        if (lstNeonatalNotes.Count > 0)
        {
            var lstGE = from Res in lstPatientExamination
                        where Res.ExaminationID == 0
                        select Res;

            txtGeneralExam.Text = "";
            foreach (PatientExamination GE in lstGE)
            {

                txtGeneralExam.Text = GE.ExaminationName;
              
            }
            txtResSupport.Text = lstNeonatalNotes[0].RespiratorySupport;
            txtFluids.Text = lstNeonatalNotes[0].FluidsandNutrition;
            txtGeneralCourse.Text = lstNeonatalNotes[0].GeneralCourse;
            txtPlan.Text = lstNeonatalNotes[0].Plans;

            if (lstNeonatalNotes[0].ImmunizationSchedule == "Y")
            {
                chkImmunization.Checked = true;
            }

            if ((lstNeonatalNotes[0].NextReviewAfter != "") && (lstNeonatalNotes[0].NextReviewAfter != null))
            {
                if (lstNeonatalNotes[0].NextReviewAfter.Contains("/"))
                {
                    txtNextReviewDate.Text = lstNeonatalNotes[0].NextReviewAfter;
                }
                else
                {
                    string NextReview = string.Empty;
                    string NextReviewNos = string.Empty;
                    string NextReviewDMY = string.Empty;
                    string[] nReview;

                    NextReview = lstNeonatalNotes[0].NextReviewAfter;
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


        }
    }

    public void GetSystemicExaminatiom()
    {
        retCode = new Neonatal_BL(base.ContextInfo).GetSystemicExaminatiom(out lstExamination);

        if (hdnType.Value == "I")
        {
            if (lstExamination.Count > 0)
            {
                grdSysExam.DataSource = lstExamination;
                grdSysExam.DataBind();

            }
        }
        else
        {
            if (hdnType.Value == "U")
            {
                var lstPE = from Res in lstPatientExamination
                            where Res.ExaminationID !=0
                            select Res;

                grdSysExam.DataSource = lstPE;
                grdSysExam.DataBind();
            }
        }
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {

        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);

        #region GetRiskFactor
        //lstRiskFactor = GetRiskFactor();
        lstRiskFactor = ComplaintICDCode1.GetPatientBackgroundProblem("NNN", patientID, patientVisitID);
        #endregion

        #region PatientVitals
        bool blnRetval = false;
        List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
        blnRetval = uctlPatientVitals.GetPageValues(out lstPatientVitals);
        retCode = -1;
        IP_BL oIP_BL = new IP_BL(base.ContextInfo);
        List<PatientVitals> lstMaxOfVitalsSetID = new List<PatientVitals>();
        retCode = oIP_BL.GetMaxOfVitalsSetID(patientVisitID, out lstMaxOfVitalsSetID);

        foreach (var vitalsetid in lstMaxOfVitalsSetID)
        {
            NewVitalsSetID = vitalsetid.VitalsSetID;
        }

        foreach (PatientVitals patientVitals in lstPatientVitals)
        {

            patientVitals.VitalsSetID = NewVitalsSetID;
            patientVitals.PatientVisitID = patientVisitID;
            patientVitals.VitalsType = "Neonatal";
        }
        #endregion

        #region GetPrescription
        List<Config> lstConfigDD = new List<Config>();
        new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
        if (lstConfigDD.Count > 0)
        {
            InvDrugData = lstConfigDD[0].ConfigValue.Trim();
        }
        if (InvDrugData == "Y")
        {
            lstDrugDetails = uIAdv.GetPrescription(patientVisitID);
        }
        else
        {
            lstDrugDetails = uAd.GetPrescription(patientVisitID);
        }

        if (lstDrugDetails.Count > 0)
        {
            foreach (DrugDetails objDrugDetails in lstDrugDetails)
            {
                objDrugDetails.PrescriptionType = "NN";
            }

        }
        #endregion

        #region GetGeneralAdvice
        lstPatientAdvice = uGAdv.GetGeneralAdvice(patientVisitID);
        #endregion

        #region Get General and systemic Examination
        lstPatientExamination = GetPatientExamDetails();
        #endregion

        #region Vaccination
        lstPBV = GetPBV();       
        #endregion

        #region Neonatal Notes
        NeonatalNotes objNeonatalNotes = new NeonatalNotes();
        objNeonatalNotes.RespiratorySupport = txtResSupport.Text;
        objNeonatalNotes.FluidsandNutrition = txtFluids.Text;
        objNeonatalNotes.GeneralCourse = txtGeneralCourse.Text;
        objNeonatalNotes.Plans = txtPlan.Text;
        if (chkImmunization.Checked == true)
        {
            objNeonatalNotes.ImmunizationSchedule = "Y";
        }
        else
        {
            objNeonatalNotes.ImmunizationSchedule = "N";
        }

        if (txtNextReviewDate.Text == "")
        {
            objNeonatalNotes.NextReviewAfter = ddlNos.SelectedValue.ToString() + "-" + ddlDMY.SelectedValue.ToString();
        }
        else
        {
            objNeonatalNotes.NextReviewAfter = txtNextReviewDate.Text;
        }
        #endregion

        retCode =-1;

        if (hdnType.Value == "U")
        {
            pType = "U";
        }
        else
        {
            if (hdnType.Value == "I")
            {
                pType = "I";
            }
        }

        retCode = new Neonatal_BL(base.ContextInfo).SaveNeonatalNotes(OrgID, patientVisitID, patientID, LID, txtBrfHistory.Text, lstRiskFactor, lstPatientVitals, lstPatientExamination, lstPatientAdvice, lstDrugDetails, lstPBV, objNeonatalNotes, pType);

        if (lstRiskFactor.Count > 0)
        {
            Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
            objPatient_BL.UpdatePatientICDStatus(patientVisitID);
        }
        if (retCode == 0)
        {
            try
            {
                Response.Redirect("../InPatient/NeonatalCaseSheet.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&vType=" + "IP", true);

            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while save SaveNeonatalNotes  page", ex);
            }

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


    public List<PatientBabyVaccination> GetPBV()
    {
        

        List<PatientBabyVaccination> lstPBVTemp = new List<PatientBabyVaccination>();
        if (chkHepatitisb.Checked == true && chkHepatitisb.Enabled == true)
        {
            PatientBabyVaccination objPBV = new PatientBabyVaccination();

            objPBV.PatientVisitID = patientVisitID;
            objPBV.PatientID = patientID;
            objPBV.VaccinationID = 2;
            objPBV.VaccinationName = chkHepatitisb.Text;
            objPBV.CreatedBy = LID;
            objPBV.Paymentstatus = "";
            lstPBVTemp.Add(objPBV);
        }

        if (chkInjectionvitamin.Checked == true && chkHepatitisb.Enabled == true)
        {
            PatientBabyVaccination objPBV = new PatientBabyVaccination();
            objPBV.PatientVisitID = patientVisitID;
            objPBV.PatientID = patientID;
            objPBV.VaccinationID = 13;
            objPBV.VaccinationName = chkInjectionvitamin.Text;
            objPBV.CreatedBy = LID;
            objPBV.Paymentstatus = "Paid";
            lstPBVTemp.Add(objPBV);
        }

        return lstPBVTemp;

    }
    public List<PatientExamination> GetPatientExamDetails()
    {
        List<PatientExamination> lstPatientExaminationTemp = new List<PatientExamination>();
        foreach (GridViewRow rows in grdSysExam.Rows)
        {
           
            Label txtExamName = (Label)rows.FindControl("txtExamName");
            Label lblExamID = (Label)rows.FindControl("lblExamID");            
            TextBox txtDescription = (TextBox)rows.FindControl("txtDescription");
            
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.PatientVisitID = patientVisitID;
            objPatientExamination.CreatedBy = LID;
            objPatientExamination.Description = txtDescription.Text;
            objPatientExamination.ExaminationID = Convert.ToInt32(lblExamID.Text);
            objPatientExamination.ExaminationName = txtExamName.Text;
            lstPatientExaminationTemp.Add(objPatientExamination);
        }

        if (txtGeneralExam.Text != "")
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.PatientVisitID = patientVisitID;
            objPatientExamination.CreatedBy = LID;
            objPatientExamination.Description = "";
            objPatientExamination.ExaminationID = 0;
            objPatientExamination.ExaminationName = txtGeneralExam.Text;
            lstPatientExaminationTemp.Add(objPatientExamination);
        }
        return lstPatientExaminationTemp;
    }
    //public List<BackgroundProblem> GetRiskFactor()

    //{
    //    List<BackgroundProblem> lstRiskFactorTemp = new List<BackgroundProblem>();

    //    if (hdnDiagnosisItems.Value != "")
    //    {
    //        foreach (string lstRiskFactor in hdnDiagnosisItems.Value.Split('^'))
    //        {

    //            if (lstRiskFactor != "")
    //            {
    //                string[] listOBP = lstRiskFactor.Split('~');
    //                BackgroundProblem objOtherBackgroundProblem = new BackgroundProblem();
    //                objOtherBackgroundProblem.ComplaintID = 0;
    //                objOtherBackgroundProblem.ComplaintName = listOBP[1];
    //                objOtherBackgroundProblem.Description = "";
    //                objOtherBackgroundProblem.CreatedBy = LID;
    //                objOtherBackgroundProblem.PatientVisitID = patientVisitID;
    //                objOtherBackgroundProblem.PatientID = patientID;
    //                lstRiskFactorTemp.Add(objOtherBackgroundProblem);
    //            }
    //        }
    //    }
    //    return lstRiskFactorTemp;
    //}

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
