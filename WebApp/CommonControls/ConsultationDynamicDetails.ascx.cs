using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using ReportingService;
using System.Security.Principal;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class CommonControls_ConsultationDynamicDetails : BaseControl
{
    
    List<Physician> physicianList = new List<Physician>();
    

    protected string _Status = "";
    public string Status
    {
        get { return _Status; }
        set { _Status = value; }
    }
    public int VisitRateID
    {
        get;
        set;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
            if (!IsPostBack)
            {
                LoadSpecialityName();
               
            }
            
    }

    public void LoadSpecialityName()
    {
        List<PhysicianSpeciality> lstPhySpeciality = new List<PhysicianSpeciality>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        List<Speciality> lstSpecialitys = new List<Speciality>();
        new PatientVisit_BL(base.ContextInfo).GetSpecialityAndSpecialityName(OrgID, out lstPhySpeciality, VisitRateID, out lstSpeciality);
        string iscor = Session["IsCorporateOrg"].ToString();
        if (iscor == "Y")
        {
            if (lstSpeciality.Count > 0)
            {
                for (int i = 0; i < lstSpeciality.Count; i++)
                {
                    Speciality objSpecialitys = new Speciality();
                    string[] SplitlstSpeciality = lstSpeciality[i].SpecialityName.Split(':');
                    objSpecialitys.SpecialityName = SplitlstSpeciality[0].ToString();
                    objSpecialitys.SpecialityID =Convert.ToInt32(lstSpeciality[i].SpecialityID.ToString());
                    lstSpecialitys.Add(objSpecialitys);
                    
                }
                
            }
            var lstphyAnd = (from lstsp in lstSpecialitys
                             select new { lstsp.SpecialityID, lstsp.SpecialityName }).Distinct();
            var tempSpec = (from lst in lstphyAnd
                            select lst).Distinct();
            ddlSpeciality.DataSource = tempSpec;
            ddlSpeciality.DataTextField = "SpecialityName";
            ddlSpeciality.DataValueField = "SpecialityID";
            ddlSpeciality.DataBind();
            ddlSpeciality.Items.Insert(0, "-----Select-----");

        }
        else
        {
            var lstphyAnd = (from lstsp in lstSpeciality
                             select new { lstsp.SpecialityID, lstsp.SpecialityName }).Distinct();
            var tempSpec = (from lst in lstphyAnd
                            select lst).Distinct();
            ddlSpeciality.DataSource = tempSpec;
            ddlSpeciality.DataTextField = "SpecialityName";
            ddlSpeciality.DataValueField = "SpecialityID";
            ddlSpeciality.DataBind();
            ddlSpeciality.Items.Insert(0, "-----Select-----");

        }

              
        var lstphy = (from lstsp in lstPhySpeciality
                      //where lstsp.SpecialityID == Convert.ToInt32(ddlSpeciality.SelectedValue)
                      select new { lstsp.LoginID, lstsp.PhysicianName }).Distinct();

        var tempphy = (from lst in lstphy
                       select lst).Distinct();

        ddlTempConsultingName.DataSource = tempphy;
        ddlTempConsultingName.DataTextField = "PhysicianName".Split('~')[0];
        ddlTempConsultingName.DataValueField = "LoginID";
        ddlTempConsultingName.DataBind();

        var lstphynSpec = (from lstsp in lstPhySpeciality
                      //where lstsp.SpecialityID == Convert.ToInt32(ddlSpeciality.SelectedValue)
                      select new { lstsp.LoginID, lstsp.SpecialityID }).Distinct();

        var tempphynSpec = (from lst in lstphynSpec
                       select lst).Distinct();

        ddlTempConsultAndSpec.DataSource = tempphynSpec;
        ddlTempConsultAndSpec.DataTextField = "SpecialityID";
        ddlTempConsultAndSpec.DataValueField = "LoginID";
        ddlTempConsultAndSpec.DataBind();
    }


    public void loadDisplay(List<PhysicianSpeciality> lstAllSPeciality)
    {

        var lstphyAnd = (from lstsp in lstAllSPeciality
                         select new { lstsp.SpecialityID, lstsp.SpecialityName }).Distinct();
        var tempSpec = (from lst in lstphyAnd
                        select lst).Distinct();

        ddlSpeciality.DataSource = tempSpec;
        ddlSpeciality.DataTextField = "SpecialityName";
        ddlSpeciality.DataValueField = "SpecialityID";
        ddlSpeciality.DataBind();
        ddlSpeciality.Items.Insert(0, "-----Select-----");

        var lstphy = (from lstsp in lstAllSPeciality
                      //where lstsp.SpecialityID == Convert.ToInt32(ddlSpeciality.SelectedValue)
                      select new { lstsp.LoginID, lstsp.PhysicianName }).Distinct();

        var tempphy = (from lst in lstphy
                       select lst).Distinct();

        ddlTempConsultingName.DataSource = tempphy;
        ddlTempConsultingName.DataTextField = "PhysicianName".Split('~')[0];
        ddlTempConsultingName.DataValueField = "LoginID";
        ddlTempConsultingName.DataBind();

        var lstphynSpec = (from lstsp in lstAllSPeciality
                           //where lstsp.SpecialityID == Convert.ToInt32(ddlSpeciality.SelectedValue)
                           select new { lstsp.LoginID, lstsp.SpecialityID }).Distinct();

        var tempphynSpec = (from lst in lstphynSpec
                            select lst).Distinct();

        ddlTempConsultAndSpec.DataSource = tempphynSpec;
        ddlTempConsultAndSpec.DataTextField = "SpecialityID";
        ddlTempConsultAndSpec.DataValueField = "LoginID";
        ddlTempConsultAndSpec.DataBind();
    }

    public List<PatientDueChart> getPatientConsultationDetails()
    {
        List<PatientDueChart> lstBillingDetails = new List<PatientDueChart>();


        string hidValue = iconHidDelete.Value;
        PatientDueChart objBilling = new PatientDueChart();
        if (ddlSpeciality.SelectedItem.Text != "-----Select-----")
        {
            objBilling.DetailsID = Convert.ToInt64(ddlSpeciality.SelectedValue.ToString());

            if (hdnSelectedPhysician.Value != "0")
            {
                objBilling.FeeID = Convert.ToInt64(hdnSelectedPhysician.Value.Trim());
            }
            lstBillingDetails.Add(objBilling);
        }
       
      
        return lstBillingDetails;
    }
    //protected void ddlPhysicianVis_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    txtUnit.Enabled = true;
    //    string amt = ddlPhysicianVis.SelectedValue.ToString();
        
    //    txtAmount.Text = amt.Split('~')[0].ToString();
    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tcons", "javascript:ConsDisplay('divConsultation');", true);
    //}
}

