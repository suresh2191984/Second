
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

public partial class Reports_CustomizationReport : BasePage
{


    public Reports_CustomizationReport()
        : base("Reports_CustomizationReport_aspx")
    {
    }

    List<LabTestTATReport> lstTATReport = new List<LabTestTATReport>();
    long returnCode = -1;
    long LocationID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
           

            AutoCompleteExtenderClient.ContextKey = "0^0";
           
            if (!IsPostBack)
            {

                
                LoadSPName();
                LoadMetadata();
                DateTime dt = new DateTime();
                dt = Convert.ToDateTime(new BasePage().OrgDateTimeZoneNew);
                txtFDate.Text = OrgDateTimeZoneNew;
                txtFDate.Text = dt.ToString("dd-MM-yyyy") + " " + "00:00AM";
                txtTDate.Text = dt.ToString("dd-MM-yyyy") + " " + "11:59PM";
            }
           hdnOrgID.Value =Convert.ToString(OrgID);
           
        }
        catch (Exception ex)
        {
            
            CLogger.LogError("Error in Page Load: ", ex);
        }
    }

    private void LoadMetadata()
    {
        ddlVisitType.Items.Clear();

        try
        {
            long returncode = -1;

            string domains = "VisitType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInputs = new List<MetaData>();
            List<MetaData> lstmetadataOutputs = new List<MetaData>();
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInputs.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInputs, OrgID, LangCode, out lstmetadataOutputs);
            if (lstmetadataOutputs.Count > 0)
            {
                var childItems = from child in lstmetadataOutputs
                                 where child.Domain == "VisitType"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlVisitType.DataSource = childItems;
                    ddlVisitType.DataTextField = "DisplayText";
                    ddlVisitType.DataValueField = "Code";
                    ddlVisitType.DataBind();

                }
                /*Making Default as Both*/
               ddlVisitType.SelectedValue = "-1";

                /*Making Default as Both*/
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadMetadata", ex);
        }
        
    }




    protected void LoadSPName()
    {

       
        Report_BL Rpt_BL = new Report_BL(base.ContextInfo);
        List<ReportMaster> lstreport = new List<ReportMaster>();
        returnCode = Rpt_BL.GetCustomizedReportList(OrgID, out lstreport);
        ddlMIS.DataSource = lstreport;

        ddlMIS.DataTextField = "ReportPath";
        ddlMIS.DataValueField = "ReportID";
        ddlMIS.DataBind();

        if (lstreport.Count == 1)
        {

            ddlMIS.Items.Insert(0, "------SELECT------");
         
            ddlMIS.Items[0].Selected = true;
            ddlMIS.Items[0].Value = "-1";
   
        }

        else if (lstreport.Count == 0 || lstreport.Count > 1)
        {
            ddlMIS.Items.Insert(0, "------SELECT------");
            
            ddlMIS.Items[0].Selected = true;
            ddlMIS.Items[0].Value = "-1";
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
