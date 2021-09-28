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

public partial class Patient_PrintRecommendation : BasePage 
{
    long patientID = -1;
    long patientVisitID = 0;
    long returnCode = -1;
    string Url = string.Empty;
    

    protected void Page_Load(object sender, EventArgs e)
    {
        
        Patient_BL patientBl = new Patient_BL(base.ContextInfo);
        PatientRecommendationDtls precommendation = new PatientRecommendationDtls();
        List<Patient> patientList = new List<Patient>();
        List<PatientRecommendationDtls> lstprecrommendation = new List<PatientRecommendationDtls>();
        List<PhysicianSchedule> lstschedules = new List<PhysicianSchedule>();
        if (!IsPostBack)
        {
            long patientID = -1;
            long patientVisitID = 0;
            long returnCode = -1;

            ViewState["Url"] = Request.UrlReferrer.ToString();

            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        
            Int64.TryParse(Request.QueryString["pid"], out patientID);

            returnCode = patientBl.GetPatientRecommendationDetails(OrgID, patientVisitID, patientID, 
                out  lstprecrommendation,out lstschedules,out patientList);
            if (returnCode == 0)
            {
                LoadRecommendations(lstprecrommendation);
            }
        }
        

    }

    private void LoadRecommendations(List<PatientRecommendationDtls> lstprecrommendation)
    {
        if (lstprecrommendation.Count > 0)
        {
            int i = 1;
            DataTable dt = new DataTable("Reckons");
            dt.Columns.Add("PRecoDtlsID");
            dt.Columns.Add("RecoID");
            dt.Columns.Add("ResultID");
            dt.Columns.Add("ResultValues");
            dt.Columns.Add("SequenceNo");
            
                
            foreach (PatientRecommendationDtls pr in lstprecrommendation)
            {
                DataRow dr = dt.NewRow();

                dr["PRecoDtlsID"] = pr.PRecoDtlsID;
                dr["RecoID"] = pr.RecoID;
                dr["ResultID"] = pr.ResultID;
                dr["ResultValues"] = pr.ResultValues;
                dr["SequenceNo"] = i;
                dt.Rows.Add(dr);
                i += 1;
            }
            ViewState["Reckon"] = dt;
            gvReckon.DataSource = dt;
            gvReckon.DataBind();
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Response.Redirect(@"../Patient/PatientRecommendation.aspx?pid=" + patientID + "&vid=" + patientVisitID, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while btnEdit_Click", ex);
        }
    }
    
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        try
        {
            Patient_BL Patient_BL = new Patient_BL(base.ContextInfo);
            List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
            List<PatientRecommendationDtls> lstprecommendation = new List<PatientRecommendationDtls>();
            
            PatientRecommendation precommendation = new PatientRecommendation();
            precommendation.PatientID = patientID;
            precommendation.PatientVisitId = patientVisitID;
            precommendation.OrgID = OrgID;
            precommendation.OrgAddressID = ILocationID;
            precommendation.CreatedBy = LID;
            precommendation.Status = "Pending";
            DataTable dt = (DataTable)ViewState["Reckon"];
            returnCode = Patient_BL.UpdatePatientRecommendationDetails(precommendation, dt);

            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while btnPrint_Click", ex);
        }
    }

    protected void btnComplete_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        try
        {
            Patient_BL Patient_BL = new Patient_BL(base.ContextInfo);
            List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
            List<PatientRecommendationDtls> lstprecommendation = new List<PatientRecommendationDtls>();

            PatientRecommendation precommendation = new PatientRecommendation();
            precommendation.PatientID = patientID;
            precommendation.PatientVisitId = patientVisitID;
            precommendation.OrgID = OrgID;
            precommendation.OrgAddressID = ILocationID;
            precommendation.CreatedBy = LID;
            precommendation.Status = "Completed";
            DataTable dt = (DataTable)ViewState["Reckon"];
            returnCode = Patient_BL.UpdatePatientRecommendationDetails(precommendation, dt);

            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while btnPrint_Click", ex);
        }
    }

    protected void gvReckon_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        DataTable dt = (DataTable)ViewState["Reckon"];
        int selRow = Convert.ToInt32(e.CommandArgument);
        int swapRow = 0;
        if (dt != null && dt.Rows.Count > 0)
        {
            if (e.CommandName == "UP")
            {
                if(selRow>0)
                {
                    swapRow=selRow - 1;
                    string strTempDtlID = dt.Rows[selRow]["PRecoDtlsID"].ToString();
                    string strTempValue = dt.Rows[selRow]["ResultValues"].ToString();
                    dt.Rows[selRow]["ResultValues"] = dt.Rows[swapRow]["ResultValues"];
                    dt.Rows[selRow]["PRecoDtlsID"] = dt.Rows[swapRow]["PRecoDtlsID"];
                    //PRecoDtlsID
                    dt.Rows[swapRow]["ResultValues"] = strTempValue;
                    dt.Rows[swapRow]["PRecoDtlsID"] = strTempDtlID;
                    gvReckon.DataSource = dt;
                    gvReckon.DataBind();
                }
            }
            else if (e.CommandName == "DOWN")
            {
                if (selRow < dt.Rows.Count - 1)
                {
                    swapRow = selRow + 1;
                    string strTempDtlID = dt.Rows[selRow]["PRecoDtlsID"].ToString();
                    string strTempValue = dt.Rows[selRow]["ResultValues"].ToString();
                    dt.Rows[selRow]["ResultValues"] = dt.Rows[swapRow]["ResultValues"];
                    dt.Rows[selRow]["PRecoDtlsID"] = dt.Rows[swapRow]["PRecoDtlsID"];
                    //PRecoDtlsID
                    dt.Rows[swapRow]["ResultValues"] = strTempValue;
                    dt.Rows[swapRow]["PRecoDtlsID"] = strTempDtlID;
                    gvReckon.DataSource = dt;
                    gvReckon.DataBind();
                }
            }
        }
        ViewState["Reckon"] = dt;
    }


    protected void btnBack_Click(object sender, EventArgs e)
    {
        Url = ViewState["Url"].ToString() + "&BackBtn=Y";
        Response.Redirect(Url, true);
    }


}
