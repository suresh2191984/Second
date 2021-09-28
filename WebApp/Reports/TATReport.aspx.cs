
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.ExcelExportManager;
using System.IO;

public partial class Reports_TATReport : BasePage
{


    public Reports_TATReport()
        : base("Reports_TATReport_aspx")
    {
    }

    List<LabTestTATReport> lstTATReport = new List<LabTestTATReport>();
    long returnCode = -1;
    long LocationID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
           if (!IsPostBack)
            {

                //txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
                //txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
                LoadLocations(LID);
                LoadDepartement();
            }
           hdnOrgID.Value =Convert.ToString(OrgID);
           String NeedCoAuth = GetConfigValues("Need_CoAuth_TATReport", OrgID);
           hdnCoAuth.Value = NeedCoAuth;
           String NeedValidateTime = GetConfigValues("Need_ValidateTime_TATReport", OrgID);
           hdnValidateTime.Value = NeedValidateTime;
        }
        catch (Exception ex)
        {
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = ex.Message;
            CLogger.LogError("Error in Page Load: ", ex);
        }
    }

    private void LoadDepartement()
    {
        ddlDepartment.Items.Clear();
        List<InvDeptMaster> ObjInvDep = new List<InvDeptMaster>();
        List<InvestigationHeader> objHeader = new List<InvestigationHeader>();
        Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
        long returnCode = -1;
        
        returnCode = investigationBL.getOrgDepartHeadName(OrgID, out ObjInvDep, out objHeader);
        if (ObjInvDep.Count > 0)
        {
            ddlDepartment.DataTextField = "DeptName";
            ddlDepartment.DataValueField = "DeptID";
            ddlDepartment.DataSource = ObjInvDep;
            ddlDepartment.DataBind();
        }
        ddlDepartment.Items.Insert(0, "--All--");
        ddlDepartment.Items[0].Value = "-1";
    }
    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID, out lstConfig);
            if (lstConfig.Count >= 0)
                strConfigValue = lstConfig[0].ConfigValue;
            else
                CLogger.LogWarning("InValid " + strConfigKey);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetConfigValues" + strConfigKey, ex);
        }
        return strConfigValue;
    }
    


  
    protected void LoadLocations(long uroleID)
    {

        string all = Resources.Reports_ClientDisplay.ReportsTATReport_aspx_02 == null ? "--ALL--" : Resources.Reports_ClientDisplay.ReportsTATReport_aspx_02;
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        returnCode = patientBL.GetLocation(OrgID, LID, uroleID,out lstLocation);
        ddlLocation.DataSource = lstLocation;

        ddlLocation.DataTextField ="Location";
        ddlLocation.DataValueField ="AddressID";
        ddlLocation.DataBind();

        if (lstLocation.Count == 1)
        {

            //ddlLocation.Items.Insert(0,"------SELECT------");
          //  ddlLocation.Items.Insert(0,"--ALL--");   a
            ddlLocation.Items.Insert(0, all);
            ddlLocation.Items[0].Selected =true;
            ddlLocation.Items[0].Value = "-1";
   
        }

        else if (lstLocation.Count == 0 || lstLocation.Count > 1)
        {
            //ddlLocation.Items.Insert(0,"------SELECT------");
            //ddlLocation.Items.Insert(0,"--ALL--");        a
            ddlLocation.Items.Insert(0, all);
            ddlLocation.Items[0].Selected =true;
            ddlLocation.Items[0].Value = "-1";
        }
    }
   
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
   
     
   protected void txtTDate_TextChanged(object sender, EventArgs e)
    {

    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("..//Reports//ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }
}
