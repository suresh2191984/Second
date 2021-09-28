using System;
using System.Collections.Generic;
using System.Linq;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Web.Script.Serialization;

public partial class Admin_RuleMaster : BasePage
{
    public Admin_RuleMaster()
        : base("Admin_RuleMaster_aspx")
    {
    }

    string select = Resources.CommonControls_AppMsg.CommonControls_TestMaster_ascx_40 == null ? "--Select--" : Resources.CommonControls_AppMsg.CommonControls_TestMaster_ascx_40;
    string Useyes = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_065 == null ? "Yes" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_065;
    string UseNo = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_066 == null ? "No" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_066;

    List<MetaData> lstmetadataInput = new List<MetaData>();
    List<MetaData> lstmetadataOutput = new List<MetaData>();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                hdnOrgid.Value = OrgID.ToString();
                AutoCompleteCrossParameter.ContextKey = OrgID.ToString()+"~"+"";  
                LoadMeatData();
            }
        }
        catch (Exception ex)
        {
        }
    }
    public void LoadMeatData()
    {
        try
        {
            long returncode = -1;
            string domains = "RuleMaster,RuleComponent,TGender,DateAttributes,TMasterCtrlOperRange,TMasterCtrlSubCategory,Operator,Btc_Type,ResultType,PostTrigger";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            lstmetadataInput = new List<MetaData>();
            lstmetadataOutput = new List<MetaData>();
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
                                 where child.Domain == "RuleMaster"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlRuleType.DataSource = childItems;
                    ddlRuleType.DataTextField = "DisplayText";
                    ddlRuleType.DataValueField = "MetaDataID";
                    ddlRuleType.DataBind();
                    ddlRuleType.Items.Insert(0, new ListItem(select, "0"));
                    ddlRuleType.Items[0].Value = "0";
                }
                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "RuleComponent"
                                  select child;
                if (childItems1.Count() > 0)
                {
                    chkComponent.DataSource = childItems1;
                    chkComponent.DataTextField = "DisplayText";
                    chkComponent.DataValueField = "MetaDataID";
                    chkComponent.DataBind();
                }


                JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
                List<NameValuePair> lstNameValuePair = new List<NameValuePair>();

                var childItemsG = from child in lstmetadataOutput
                                  where child.Domain == "TGender"
                                  select child;
                lstNameValuePair = (from l in childItemsG
                                    select new NameValuePair { Name = l.DisplayText, Value = l.Code }).ToList<NameValuePair>();
                lstNameValuePair.Insert(0, new NameValuePair { Name = "---Select---", Value = "0" });

                hdnLstGender.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);

                lstNameValuePair = new List<NameValuePair>();
                var childItemsSC = from child in lstmetadataOutput
                                   where child.Domain == "TMasterCtrlSubCategory"
                                   select child;
                lstNameValuePair = (from l in childItemsSC
                                    select new NameValuePair { Name = l.DisplayText, Value = l.Code }).ToList<NameValuePair>();
                lstNameValuePair.Insert(0, new NameValuePair { Name = "---Select---", Value = "0" });
                hdnLstSubCategory.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);

                lstNameValuePair = new List<NameValuePair>();
                var childItemsAT = from child in lstmetadataOutput
                                   where child.Domain == "DateAttributes"
                                   select child;
                lstNameValuePair = (from l in childItemsAT
                                    select new NameValuePair { Name = l.DisplayText, Value = l.Code }).ToList<NameValuePair>();
                lstNameValuePair.Insert(0, new NameValuePair { Name = "---Select---", Value = "0" });
                hdnLstDateAttributes.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);

                lstNameValuePair = new List<NameValuePair>();
                var childItemsOR = from child in lstmetadataOutput
                                   where child.Domain == "TMasterCtrlOperRange"
                                   select child;
                lstNameValuePair = (from l in childItemsOR
                                    select new NameValuePair { Name = l.DisplayText, Value = l.Code }).ToList<NameValuePair>();
                lstNameValuePair.Insert(0, new NameValuePair { Name = "---Select---", Value = "0" });

                hdnLstAgeRangeOpr.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);


                lstNameValuePair = new List<NameValuePair>();
                var childItemsOPR = from child in lstmetadataOutput
                                    where child.Domain == "Operator"
                                    select child;
                lstNameValuePair = (from l in childItemsOPR
                                    select new NameValuePair { Name = l.DisplayText, Value = l.Code }).ToList<NameValuePair>();
                lstNameValuePair.Insert(0, new NameValuePair { Name = "---Select---", Value = "0" });

                hdnLstOperator.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);

                  lstNameValuePair = new List<NameValuePair>();
                var childItemsRT = from child in lstmetadataOutput
                                   where child.Domain == "ResultType"
                                   select child;
                lstNameValuePair = (from l in childItemsRT
                                    select new NameValuePair { Name = l.DisplayText, Value = l.Code }).ToList<NameValuePair>();
                lstNameValuePair.Insert(0, new NameValuePair { Name = "---Select---", Value = "0" });

                hdnResultType.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);


                lstNameValuePair = new List<NameValuePair>();
                var childItemsab = from child in lstmetadataOutput
                                    where child.Domain == "Btc_Type"
                                    select child;
                lstNameValuePair = (from l in childItemsab
                                    select new NameValuePair { Name = l.DisplayText, Value = l.Code }).ToList<NameValuePair>();
                lstNameValuePair.Insert(0, new NameValuePair { Name = "---Select---", Value = "0" });

                hdnAbnormal.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);

                var childItemsPT = from child in lstmetadataOutput
                                   where child.Domain == "PostTrigger"
                                                  select child;
                List<NameValuePair> lstNameValuePairPT = new List<NameValuePair>();
                lstNameValuePairPT = (from l in childItemsPT
                                      select new NameValuePair { Name = l.DisplayText, Value = l.MetaDataID.ToString() }).ToList<NameValuePair>();
                lstNameValuePairPT.Insert(0, new NameValuePair { Name = "---Select---", Value = "0" });
                hdnlstPostTrigger.Value = oJavaScriptSerializer.Serialize(lstNameValuePairPT);
                ddlTrigger.DataSource = childItemsPT;
                ddlTrigger.DataTextField = "DisplayText";
                ddlTrigger.DataValueField = "MetaDataID";
                ddlTrigger.DataBind();
                ddlTrigger.Items.Insert(0, new ListItem(select, "0"));
                ddlTrigger.Items[0].Value = "0";

               MetaData oMetaData = new MetaData();
                oMetaData.Domain = "RemarksType";
                List<MetaData>  lstDomain = new List<MetaData>();
                lstDomain.Add(oMetaData);
                List<MetaData>  lstMetaData = new List<MetaData>();
                returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstDomain, OrgID, LanguageCode, out lstMetaData);

                if (lstMetaData.Count > 0)
                {
                    List<MetaData> lstRemarksType = ((from child in lstMetaData
                                                      where child.Domain == "RemarksType"
                                                      select child).Distinct()).ToList();
                    if (lstRemarksType != null && lstRemarksType.Count > 0)
                    {
                        ddlRtype.DataSource = lstRemarksType;
                        ddlRtype.DataTextField = "DisplayText";
                        ddlRtype.DataValueField = "Code";
                        ddlRtype.DataBind();
                        ddlType.DataSource = lstRemarksType;
                        ddlType.DataTextField = "DisplayText";
                        ddlType.DataValueField = "Code";
                        ddlType.DataBind();

                    }
                }
           

            }
        }
        catch (Exception ex)
        {
        }
    }
    
    protected void btnReset_Click(object sender, EventArgs e)
    {
        try
        {
            txtParameter.Text = string.Empty;
            hdnInvID.Value = "0";
            hdnInvRuleMasterId.Value = "0";
            ddlRuleType.SelectedIndex = 0;
            ddlTrigger.SelectedIndex = 0;
            foreach (ListItem domainItem in chkComponent.Items)
            {
                domainItem.Selected = false;
            }
           
        }
        catch (Exception ex)
        {
            
        }
    }

}
