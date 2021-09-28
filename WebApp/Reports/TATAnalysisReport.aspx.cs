using System;
using System.Collections.Generic;
using System.Web.UI;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Data;
using System.Globalization;
using System.Linq;
using ReportBusinessLogic;

public partial class Reports_TATAnalysisReport :BasePage
{
public Reports_TATAnalysisReport () : base("Reports_TATAnalysisReport_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            AutoCompleteExtenderClient.ContextKey = "CLI";
            if (!IsPostBack)
            {

                LoadMetaData();
                LoadAllValues();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while TATReport PageLoad ", ex);
        }
    }
    public void LoadAllValues()
    {
        string sele = Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_26 == null ? "-----ALL-----" : Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_26;
       
        try
        {
            long returnCode = -1;
            int Orgid = OrgID;
            List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
            List<InvestigationStatus> lstInvestigationStatus = new List<InvestigationStatus>();
            ReportBusinessLogic.ReportExcel_BL objBL = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo);
            returnCode = objBL.GetdropdownValuesforTATReport(Orgid, out lstOrganizationAddress, out lstInvestigationStatus);
            if (lstOrganizationAddress.Count > 0)
            {
                var lstOrganizationAddress1 = from child in lstOrganizationAddress orderby child.Location select child;
                ddlLocation.DataSource = lstOrganizationAddress1;
                ddlLocation.DataTextField = "Location";
                ddlLocation.DataValueField = "AddressID";
                ddlLocation.DataBind();
                //ddlLocation.Items.Insert(0, "--Select--");     a
                ddlLocation.Items.Insert(0, sele);

                ddlLocation.Items[0].Value = "0";

            }
            if (lstInvestigationStatus.Count > 0)
            {
                var lstInvestigationStatus1 = from child in lstInvestigationStatus orderby child.DisplayText select child;
                ddlfromStatus.DataSource = lstInvestigationStatus1;
                ddlfromStatus.DataTextField = "DisplayText";
                ddlfromStatus.DataValueField = "InvestigationStatusID";
                ddlfromStatus.DataBind();


                ddltoStatus.DataSource = lstInvestigationStatus1;
                ddltoStatus.DataTextField = "DisplayText";
                ddltoStatus.DataValueField = "InvestigationStatusID";
                ddltoStatus.DataBind();

            }
        }
        catch (Exception ex)
        {
        }
    }

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "TestRoutineBatch";
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
                                 where child.Domain == "TestRoutineBatch"
                                 select child;
                ddlRoutineStat.DataSource = childItems;
                ddlRoutineStat.DataTextField = "DisplayText";
                ddlRoutineStat.DataValueField = "Code";
                ddlRoutineStat.DataBind();
                ddlRoutineStat.SelectedValue = "3";
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
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
