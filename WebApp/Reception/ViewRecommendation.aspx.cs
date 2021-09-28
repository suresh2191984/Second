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
public partial class Reception_ViewRecommendation : BasePage
{
    long pid, vid;
    PatientVisit Patient = new PatientVisit();
    long returncode = -1;
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    protected void Page_Load(object sender, EventArgs e)
    {
        phySch.TempOrgID = OrgID;
        phySch.LocationID = ILocationID;
        phySch.RelatedControl = rtschedules;
        //phySch.BtnID = "sliderbtn";
        try
        {
            if (!IsPostBack)
            {

                Int64.TryParse(Request.QueryString["vid"], out vid);
                Int64.TryParse(Request.QueryString["pid"], out pid);
                loadRecommendation();
            }
        }
        catch (Exception ex)
        {

        }
    }
    public override string ToString()
    {

        phySch.TempOrgID = OrgID;
        phySch.LocationID = ILocationID;
        phySch.RelatedControl = rtschedules;
        Int64.TryParse(Request.QueryString["vid"], out vid);
        Int64.TryParse(Request.QueryString["pid"], out pid);
        loadRecommendation();
        object sender = null; EventArgs e = null;
        phySch.lNext_Click(sender, e);
        return "";
    }
    private void loadRecommendation()
    {
        List<PatientRecommendationDtls> rTemplate = new List<PatientRecommendationDtls>();
        List<PhysicianSchedule> lstschedules = new List<PhysicianSchedule>();
        List<Patient> patientList = new List<Patient>();

        try
        {
            new Patient_BL(base.ContextInfo).GetPatientRecommendationDetails(OrgID, vid, pid, out  rTemplate, out lstschedules, 
                out patientList);
            grdResult.DataSource = rTemplate;
            grdResult.DataBind();

            if (lstschedules.Count > 0)
            {
                bookedSlots.Visible = true;
            }
            else
            {
                bookedSlots.Visible = false;
            }
            gvBookedSlots.DataSource = lstschedules;
            gvBookedSlots.DataBind();

            if (patientList.Count > 0)
            {
                rtschedules.PatientNumber = Convert.ToString(patientList[0].PatientNumber);
                rtschedules.Patientname = patientList[0].Name;
                rtschedules.PhoneNumber = patientList[0].MobileNumber;
            }
        }
        catch (Exception ex)
        {
         //   throw;
        }
    }
     
    protected void btnSearch_Click(object sender, EventArgs e)
    {
         long retn=-1;
        try
        {
            hdnValues.Value = "";
            Int64.TryParse(Request.QueryString["vid"], out vid);
            Int64.TryParse(Request.QueryString["pid"], out pid);
            PatientRecommendation objRecommendation = new PatientRecommendation();
            objRecommendation.OrgAddressID = ILocationID;
            objRecommendation.OrgID = OrgID;
            objRecommendation.PatientID = pid;
            objRecommendation.PatientVisitId = vid;
            objRecommendation.Remarks = txt_Remarks.Text;
            objRecommendation.Status = "Informed";
            retn = new Patient_BL(base.ContextInfo).UpdatePatientRecommendation(objRecommendation);
            if (retn > 0)
            {
                hdnValues.Value = "Y";
            }
            else
            {
                hdnValues.Value = "N";
            }
            //Page.ClientScript.RegisterOnSubmitStatement(typeof(Page), "closePage", "window.onunload = closepopup();");

            //this.Page.RegisterClientScriptBlock("ky", "<script language='javascript'>closepopup();</script>");
        }
        catch (Exception ex)
        {
        }
    }
   
}
