using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Podium.BusinessEntities;
using System.Collections.Generic;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Globalization;
using System.Text;


public partial class Reception_Episode : BasePage  
{
   
    long PatId = 0;
    long EpisodeId = 0;
    long PEpisodeId = 0;
    long patientID = 0;
    long returnCode = -1;

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            string PaID =  Request.QueryString["PID"];
            string pEpisodeName = string.Empty;
            PatId = Convert.ToInt64(PaID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            txtStartDt.Attributes.Add("onchange", "checkStartDateEndDate('" + txtStartDt.ClientID.ToString() + "','',0,0);");
            txtEndDt.Attributes.Add("onchange", "checkStartDateEndDate('" + txtEndDt.ClientID.ToString() + "','',0,0); ExcedDate('" + txtEndDt.ClientID.ToString() + "','txtStartDt',1,1);");
            if (!Page.IsPostBack)
            {
                LoadEpisode(PatId,EpisodeId);
                LoadHospitalBranch();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing AutheticateUser", ex);
        }
        
    }
    protected void LoadEpisode(long PatientID, long EpisodeId)
    {
        List<PatientEpisode> lstEpisode = new List<PatientEpisode>();
        List<PatientEpisode> lstEpisode1 = new List<PatientEpisode>();
        List<Patient> patientList = new List<Patient>();
        Patient patient = new Patient();
        long returnCode = new PatientEpisode_BL(base.ContextInfo).GetPatientEpisodeDet(EpisodeId,patientID,OrgID,out lstEpisode,out lstEpisode1);
        foreach (var item in lstEpisode)
        {
            lstEpisode1.RemoveAll(p => p.EpisodeID == item.EpisodeID);
        }

        lblDayCare.Text = Convert.ToString(lstEpisode.Count);
        LoadEposode(lstEpisode1);
       

        returnCode =  new Patient_BL(base.ContextInfo).GetPatientDemoandAddress(PatId, out patientList);
        if (patientList.Count > 0)
        {
            patient = patientList[0];
        }
        
        lblPatientName.Text = "Patient Name    : " + patient.TitleName + " " + patient.Name + "";
        lblPatientNumber.Text = "Patient Number : " + patient.PatientNumber +"";
        ddlOpenEpisode.DataSource = lstEpisode;
        ddlOpenEpisode.DataTextField = "EpisodeName";
        ddlOpenEpisode.DataValueField = "SelectedEpisode";
        ddlOpenEpisode.DataBind();
        ddlOpenEpisode.Items.Insert(0, "--Select Episode--");
        lblDayCare.Text = Convert.ToString(lstEpisode.Count);
        }

    private void LoadEposode(List<PatientEpisode> lstEpisode1)
    {
        ddlEpisode.DataSource = lstEpisode1;
        ddlEpisode.DataTextField = "EpisodeName";
        ddlEpisode.DataValueField = "SelectedEpisode";
        ddlEpisode.DataBind();
        ddlEpisode.Items.Insert(0, new ListItem("--Select Episode--", "0"));
        ddlEpisode.SelectedValue = "0";
    }
    private void LoadHospitalBranch()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<LabReferenceOrg> RefOrg = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Hospital = new List<LabReferenceOrg>();
            
            retCode = patBL.GetLabRefOrg(OrgID, 0, "D", out RefOrg);
            Hospital = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 1; });
            if (retCode == 0)
            {
                ddlHospital.DataSource = Hospital;
                ddlHospital.DataTextField = "RefOrgNameWithAddress";
                ddlHospital.DataValueField = "LabRefOrgID";
                ddlHospital.DataBind();
                ddlHospital.Items.Insert(0, "-----Select-----");
                ddlHospital.Items[0].Value = "0";
                foreach (ListItem lit in ddlHospital.Items)
                {
                    lit.Attributes.Add("Title", lit.Text);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Hospital Details.", ex);
        }
    }
    protected void ddlHospital_SelectedIndexChanged(object sender, EventArgs e)
    {
        PatVistiRefID.Value = (ddlHospital.SelectedValue).ToString();
    }
     
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        Patient lstPatient = new Patient();
        PatientEpisode lstEpisode = new PatientEpisode();
        int ECount = -1;
        long retCode = -1;
        
        int refPhyID = 0;
        
        int refSpecialityID = 0;
        string refPhyName = "";
        string EpisodeName=string.Empty;
        long PatEpisodeId = 0;
        

        try{
            lstEpisode.EpisodeName = txtNewEpisode.Text.Trim();
            if (ddlEpisode.SelectedValue != "0")
            {
                string strSelEpi = ddlEpisode.SelectedValue;
                string[] strEpi = strSelEpi.Split('~');
                EpisodeId = Convert.ToInt64(strEpi[0]);
            }
            if(ddlOpenEpisode.SelectedIndex >0)
            {
                string strSelEpi = ddlOpenEpisode.SelectedValue;
                string[] strEpi = strSelEpi.Split('~');
                PatEpisodeId = Convert.ToInt64(strEpi[0]);
                lstEpisode.PatientEpisodeID =PatEpisodeId;
            }
            lstEpisode.EpisodeID = EpisodeId;
            lstEpisode.PatientID = PatId;
            lstEpisode.OrgID = OrgID;
             
             
            string strSDt = String.Format("{0:dd/MM/yyyy}", txtStartDt.Text);
            string strEDt = String.Format("{0:dd/MM/yyyy}", txtEndDt.Text);
            lstEpisode.EpisodeStartDt = Convert.ToDateTime(strSDt);
            lstEpisode.EpisodeEndDt = Convert.ToDateTime(strEDt);
            lstEpisode.Status="Open";
            refPhyID =Convert.ToInt32(ReferDoctor1.GetRefPhyID());
            refSpecialityID = ReferDoctor1.GetSpeciality();
            refPhyName = refPhyID == 0 ? string.Empty : ReferDoctor1.GetRefPhyName().ToString();
            if (txtNoOfVisit.Text != "")
            {
                lstEpisode.NoofSitting = Convert.ToInt32(txtNoOfVisit.Text);
            }
            lstEpisode.IsCreditBill = uctlClientTpa.IsCreditBill;
            
             
            lstEpisode.CreatedBy=LID;
            lstEpisode.ReferingPhysicianID = refPhyID;
            lstEpisode.ReferingPhysicianName = refPhyName;
            string RefType =Convert.ToString(ReferDoctor1.GetRefPhyType());
            lstEpisode.OrgAddressID = ILocationID;
            if (RefType  == "E")
            {
                lstEpisode.RefType = "E";
            }
            else if (RefType == "I")
            {
                lstEpisode.RefType = "I";
            }

            List<VisitClientMapping> lstVisitClientMapping = uctlClientTpa.GetClientValues();

            retCode = new PatientEpisode_BL(base.ContextInfo).InsertPatientEpisodeBL(lstEpisode, lstVisitClientMapping);
            if (retCode !=-1)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alt", "javascript:alert('Patient Episodes details are Saved successfully.');Epiclear();", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "skeyShowDuplicate", "javascript:alert('Patient Episodes details are not Saved');Epiclear();", true);
            }
            PatEpisodeId=0;
            LoadEpisode(PatId,PatEpisodeId);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing AutheticateUser", ex);
        }
    }
    
    protected void btnGo_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlOpenEpisode.SelectedIndex > 0)
            {
                string strSelEpi = ddlOpenEpisode.SelectedValue;
                string[] strEpi = strSelEpi.Split('~');
                long PatEpisodeId = Convert.ToInt64(strEpi[0]);
                EpisodeId = Convert.ToInt64(strEpi[1]);
                 
                List<PatientEpisode> lstEpi = new List<PatientEpisode>();
                List<PatientEpisode> lstEpi1 = new List<PatientEpisode>();
                
                long retCode = new PatientEpisode_BL(base.ContextInfo).GetPatientEpisodeDet(PatEpisodeId, patientID, OrgID, out lstEpi,   out lstEpi1);
                LoadEposode(lstEpi1);
                if (lstEpi.Count > 0)
                {
                    hdnEpisodeDet.Value = "";
                    foreach (PatientEpisode PE in lstEpi)
                    {
                        if (PE.PatientEpisodeID == PatEpisodeId)
                        {
                            trEpisode.Attributes.Add("Style", "Display:block");
                            for(int i=1;i<ddlEpisode.Items.Count;i++)
                            {
                                string strSelEpi1 = ddlEpisode.Items[i].Value;
                                string[] strEpi1 = strSelEpi1.Split('~');
                                long EpisodeId1 = Convert.ToInt64(strEpi1[0]);
                                long NoofSitt = Convert.ToInt64(strEpi1[1]);
                                if (EpisodeId == EpisodeId1)
                                {
                                    ddlEpisode.SelectedIndex = i;
                                    break;
                                }
                            }
                            txtStartDt.Text = PE.EpisodeStartDt.ToString();
                            txtEndDt.Text = PE.EpisodeEndDt.ToString();
                            txtNoOfVisit.Text = PE.NoofSitting.ToString();
                            trClient.Attributes.Add("Style", "Display:block");
                            divMore3.Attributes.Add("Style", "Display:block");
                            divMore2.Attributes.Add("Style", "Display:block");
                            divMore1.Attributes.Add("Style", "Display:none");
                            btnFinish.Enabled = true;
                            hdnClientID.Value = PE.ClientID.ToString();
                            hdnRateID.Value = PE.RateID.ToString();
                            hdnTPAID.Value = PE.TPAID.ToString();
                            hdnPreAuthAmount.Value = PE.PreAuthAmount.ToString();
                            hdnPreAuthApprovalNumber.Value =Convert.ToString(PE.PreAuthApprovalNumber);
                            Hidden1.Value = PE.PreAuthAmount.ToString();
                           
                            string refType=ReferDoctor1.GetRefPhyType();
                            ReferDoctor1.ShowSelectedPhysician(PE.PatientVisitId);
                           
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing AutheticateUser", ex);
        }
    }

}
