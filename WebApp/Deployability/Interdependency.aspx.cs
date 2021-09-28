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
        LoadDependentType();
    }

    
    private void LoadDependentType()
    {
        try
        {
            long returncode = -1;
            string domains = "DependentType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "DependentType" && child.Code == "Formula"
                                 select child;
                ddlDependentType.DataSource = childItems;
                ddlDependentType.DataTextField = "DisplayText";
                ddlDependentType.DataValueField = "Code";
                ddlDependentType.DataBind();
                ddlDependentType.Items.Insert(0, "-------Select-------");
                ddlDependentType.Items[0].Value = "0";


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);

        }

    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static string GetGroupName(string prefixText, int orgID)
    {
            long returnCode = -1;    
            List<InvGroupMaster> lstInvGroupMaster = new List<InvGroupMaster>();
            Investigation_BL objInvBL = new Investigation_BL(new BaseClass().ContextInfo);
            returnCode = objInvBL.getInvGroupName(orgID, out lstInvGroupMaster);
            
            var query = from c in lstInvGroupMaster
                    where c.GroupName.ToLower().Contains(prefixText.ToLower())
                    select new { c.GroupName, c.GroupID };
        JavaScriptSerializer js = new JavaScriptSerializer();
        string strout = js.Serialize(query);
        return strout;
    }
    
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static string LoadInvestigationByGroup(Int32 GroupID)
    {
        long returncode = -1;
        List<InvestigationMaster> lstInvMaster = new List<InvestigationMaster>();
        Investigation_BL objInvBL = new Investigation_BL(new BaseClass().ContextInfo);
        returncode = objInvBL.GetInvestigationByGroup(GroupID, out lstInvMaster);

        JavaScriptSerializer js = new JavaScriptSerializer();
        string strout = js.Serialize(lstInvMaster);
        return strout;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static void AddInterdependency(int OrgID, long GroupID, long PrimaryInvID, long DependentInvID, string DependentType, long OldPrimaryInvID, long OldDependentInvID)
    {
        long returncode = -1;
        Deployability_BL Deployability_BL = new Deployability_BL(new BaseClass().ContextInfo);
        
        try
        {
            returncode = Deployability_BL.AddInterdependency(OrgID, GroupID, PrimaryInvID, DependentInvID, DependentType, OldPrimaryInvID, OldDependentInvID);
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in AddInterdependency Save", ex);
        }
    }
    [WebMethod(EnableSession = true)]
    public static string GetInterdependencyDetails(int OrgID, long GroupID)
    {
        try
        {
            long returnCode = -1;
            Deployability_BL DeployabilityBL = new Deployability_BL();
            List<DependentInvestigation> lstDetails = new List<DependentInvestigation>();
            returnCode = DeployabilityBL.GetInterdependencyDetails(OrgID, GroupID, out lstDetails);

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
    public static void RemoveInterdependencyDetails(int OrgId, long GroupID, long PrimaryInvID, long DependentInvID, string DependentType)
    {
        long returnCode = -1;
        try
        {
            Deployability_BL DeployabilityBL = new Deployability_BL();
            returnCode = DeployabilityBL.RemoveInterdependencyDetails(OrgId, GroupID, PrimaryInvID, DependentInvID, DependentType);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in RemoveInterdependencyDetails Event()", ex);
        }
    }
    
 }

