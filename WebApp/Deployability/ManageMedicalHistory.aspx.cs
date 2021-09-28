using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data;
using System.Data.SqlClient;
using System.ServiceModel.Web;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.NewInstanceCreation;
public partial class Deployability_Interdependency : BasePage
{
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadTemplate();
    }


    private void LoadTemplate()
    {
        try
        {
            long returncode = -1;

            List<History> lstTemplate = new List<History>();

            returncode = new Deployability_BL(base.ContextInfo).pLoadTemplate(out lstTemplate);

            if (lstTemplate.Count > 0)
            {

                ddlTemplate.DataSource = lstTemplate;
                ddlTemplate.DataTextField = "HistoryName";
                ddlTemplate.DataValueField = "HistoryID";
                ddlTemplate.DataBind();
                ddlTemplate.Items.Insert(0, "-------Select-------");
                ddlTemplate.Items[0].Value = "0";


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Template name", ex);

        }

    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static string GetTestName(string prefixText, int orgID)
    {
            long returnCode = -1;    
            
            List<OrderedInvestigations> lstInvName = new List<OrderedInvestigations>();
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetTestNameForMedicalDetailsMapping(prefixText, orgID, out lstInvName);

            var query = from c in lstInvName
                        where c.Name.ToLower().Contains(prefixText.ToLower())
                        select new { c.ID, c.Name, c.Type };    
        
            JavaScriptSerializer js = new JavaScriptSerializer();
            string strout = js.Serialize(query);
            return strout;
    }
    
    
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static void SaveInvMedicalDetailsMapping(long TestID, int TemplateID, string MedicalDetailType, string IsInternal, string IsMandatory, string InvType, long InvMedMappingID)
    {
        long returncode = -1;
        Deployability_BL Deployability_BL = new Deployability_BL(new BaseClass().ContextInfo);
        if (MedicalDetailType == null) { MedicalDetailType = "H"; }
        try
        {
            returncode = Deployability_BL.SaveInvMedicalDetailsMapping(TestID, TemplateID, MedicalDetailType, IsInternal, IsMandatory, InvType, InvMedMappingID);
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in AddManageMedicalHistory Save", ex);
        }
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static string GetInvMedicalDetailsMapping(string InvType, int OrgID, long TestID)
    {
        try
        {
            long returnCode = -1;
            Deployability_BL DeployabilityBL = new Deployability_BL();
            List<InvMedicalDetailsMapping> lstDetails = new List<InvMedicalDetailsMapping>();
            returnCode = DeployabilityBL.GETInvMedicalDetailsMapping(TestID, InvType, OrgID, out lstDetails);

            JavaScriptSerializer js = new JavaScriptSerializer();
            string strout = js.Serialize(lstDetails);
            return strout;
        }
        catch (Exception ex)
        {
            return "Error:" + ex;
        }
    }
    [WebMethod(EnableSession = true)]
    public static void RemoveInvMedicalDetailsMapping(long InvMedMappingID, long TestID, int TemplateID)
    {
        long returnCode = -1;
        try
        {
            Deployability_BL DeployabilityBL = new Deployability_BL();
            returnCode = DeployabilityBL.RemoveInvMedicalDetailsMapping(InvMedMappingID, TestID, TemplateID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in RemoveInterdependencyDetails Event()", ex);
        }
    }
    
 }

