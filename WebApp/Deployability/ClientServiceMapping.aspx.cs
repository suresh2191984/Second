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
public partial class Deployability_ClientServiceMapping : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GetClientType();
        LoadMetaData();

    }
    public void GetClientType()
    {
        long returnCode = -1;
        try
        {
            //Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
            //List<InvClientType> lstInvClientType = new List<InvClientType>();
            //returnCode = objPatient_BL.GetInvClientType(out lstInvClientType);

            //if (lstInvClientType.Count > 0)
            //{
            //    ddlClientType.DataSource = lstInvClientType;
            //    ddlClientType.DataValueField = "ClientTypeID";
            //    ddlClientType.DataTextField = "ClientTypeName";
            //    ddlClientType.DataBind();
            //    ddlClientType.Items.Insert(0, "--Select--");
            //    ddlClientType.Items[0].Value = "0";
            //}

            Master_BL obj = new Master_BL(base.ContextInfo);
            List<ClientAttributes> lstclientattrib = new List<ClientAttributes>();
            List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
            List<ActionManagerType> lstactiontype = new List<ActionManagerType>();
            List<InvReportMaster> lstrptmaster = new List<InvReportMaster>();
            returnCode = obj.GetGroupValues(OrgID, out lstmetavalue, out lstactiontype, out lstclientattrib, out lstrptmaster);
            if (lstmetavalue.Count > 0)
            {
                lstmetavalue.RemoveAll(p => p.Code != "BT");

                ddlClientType.DataSource = lstmetavalue;
                ddlClientType.DataTextField = "Value";
                ddlClientType.DataValueField = "MetaValueID";
                ddlClientType.DataBind();
                ddlClientType.Items.Insert(0, "--Select--");
                ddlClientType.Items[0].Value = "0";

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get ClientType", ex);
        }
    }
    private void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "ClientMappingService";
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
                lstmetadataOutput.RemoveAll(p => p.Code == "LAB");
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "ClientMappingService" 
                                 select child;
                ddlServiceType.DataSource = childItems;
                ddlServiceType.DataTextField = "DisplayText";
                ddlServiceType.DataValueField = "Code";
                ddlServiceType.DataBind();
                ddlServiceType.Items.Insert(0, "--Select--");
                ddlServiceType.Items[0].Value = "0";


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);

        }

    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static string GetClientNamebyClientType(string prefixText, string contextKey, int orgID)
    {
        Deployability_BL objBL = new Deployability_BL(new BaseClass().ContextInfo);
        List<ClientMaster> lstclient = new List<ClientMaster>();
        List<string> items = new List<string>();
        int CustomerTypeId=0;
        int ClientTypeId=0;
        if (contextKey != "")
        {
            CustomerTypeId = Convert.ToInt32(contextKey);
        }
        //objBL.GetClientNamebyClientTypeDP(orgID, prefixText, ClientTypeId, CustomerTypeId, out lstclient);
        objBL.GetClientNamebyClientTypeExclusivity(orgID, prefixText, ClientTypeId, CustomerTypeId, out lstclient);

        var query = from c in lstclient
                    where c.ClientName.ToLower().Contains(prefixText.ToLower()) || c.ClientCode.ToLower().Contains(prefixText.ToLower())
                    select new { c.ClientName, c.ClientID };
        JavaScriptSerializer js = new JavaScriptSerializer();
        string strout = js.Serialize(query);
        return strout;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static string GetOrgInvestigationsGroupandPKGs(string prefixText, string contextKey, int orgID, int LocationID)
    {
        Deployability_BL objBL = new Deployability_BL(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        List<BillingFeeDetails> lstBFD = new List<BillingFeeDetails>();
        string ItemsType = contextKey.Split('~')[0];
        long ClientID = Convert.ToInt64(contextKey.Split('~')[1]);
        objBL.GetOrgInvestigationsGroupandPKGs(orgID, LocationID, prefixText, ItemsType, out lstBFD);
        
        var query = from c in lstBFD
                    where c.Descrip.ToLower().Contains(prefixText.ToLower())
                    select new { c.Descrip, c.ID };
        JavaScriptSerializer js = new JavaScriptSerializer();
        string strout = js.Serialize(query);
        return strout;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string GetClientMappingService(string CidAndRefID, int OrgID)
    {
        long returnCode = -1;
        long Client = -1;
        string refType = "";
        string serviceDetails = "";
        try
        {
            Client = Convert.ToInt64(CidAndRefID); 
            refType = "BIL"; 
            Deployability_BL objBL = new Deployability_BL(new BaseClass().ContextInfo);
            List<ClientMappingService> lstClientMappingService = new List<ClientMappingService>();
            returnCode = objBL.GetClientMappingService(OrgID, Client, refType, out lstClientMappingService);
            foreach (ClientMappingService obj in lstClientMappingService)
            {
                serviceDetails += obj.ClientServiceDetails + "^";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting ClientMappingService ", ex);
        }

        return serviceDetails;
    }

    [WebMethod]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.WrappedRequest, UriTemplate = "btnFinalSaveContents")]
    public static string SaveSpecialRateMasters(List<RateMaster> lstRateMaster, int OrgID, long LID, int ClientID)
    {
        long returnCode = -1;
        try
        {
            string MappingType = "Client";
            Deployability_BL objBL = new Deployability_BL(new BaseClass().ContextInfo);
           
                string RateName = "";
                returnCode = objBL.SaveSpecialRateMasters(RateName, OrgID, LID, MappingType, lstRateMaster, ClientID);
                
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save in btnSave_Click() in SpecialRateCard.aspx", ex);
        }
        return returnCode.ToString();
    }
 }

