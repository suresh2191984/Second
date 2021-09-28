using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using ReportingService;

public partial class Admin_Reports : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
//            Response.Redirect("ReportDisplay.aspx?rname=TestReport", true);
            ReportingService2005 rptService = new ReportingService2005();
           
            System.Net.NetworkCredential credential = new System.Net.NetworkCredential();
            credential.UserName = System.Configuration.ConfigurationManager.AppSettings["UserName"].ToString();
            credential.Password = System.Configuration.ConfigurationManager.AppSettings["Password"].ToString();
            //rptService.Credentials = System.Net.CredentialCache.DefaultCredentials;
            rptService.Url = System.Configuration.ConfigurationManager.AppSettings["ReportServer"].ToString();
            rptService.Credentials = credential;
            SearchCondition searchCondition = new SearchCondition();
            searchCondition.ConditionSpecified = true;
            searchCondition.Condition = ConditionEnum.Contains;
            searchCondition.Name = "CreatedBy";
            searchCondition.Value = "Administrator";
            CatalogItem[] item = null;
            SearchCondition[] conditions = new SearchCondition[1];
            conditions[0] = searchCondition;
            item = rptService.FindItems("/AdminReports", BooleanOperatorEnum.Or, conditions);
            gvReportName.DataSource = item;
            gvReportName.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while load report Name", ex);
        }
    }
}
