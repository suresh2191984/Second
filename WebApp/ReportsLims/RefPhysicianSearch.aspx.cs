using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Text;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Data;
using System.IO;
using Attune.Podium.ExcelExportManager;

public partial class ReportsLims_RefPhysicianSearch : BasePage
{
    public ReportsLims_RefPhysicianSearch()
        : base("ReportsLims_RefPhysicianSearch_aspx")
    {
    }
	
    protected void Page_Load(object sender, EventArgs e)
    {
        //txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
        //txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','txtFDate',1,1);");       
        AutoCompleteExtenderRefPhy.ContextKey = "RPH";
        if (!IsPostBack)
        {
            txtFDate.Text = OrgTimeZone;
            txtTDate.Text = OrgTimeZone;
            LoadMeatData();
        }
        
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string AlrtWin = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_Alrt == null ? "Alert" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_Alrt;
       
        string DispText = Resources.ReportsLims_ClientDisplay.ReportsLims_RefPhysicianSearch_aspx_01 == null ? "No Matching Record Found" : Resources.ReportsLims_ClientDisplay.ReportsLims_RefPhysicianSearch_aspx_01;
        try
        {
            long returncode;
            string Category;
            string ReceiverType = "";
            int flag = 0;

            string fromdate = hdnFromDate.Value.ToString()+" "+"00:00:00";
            string todate = hdnToDate.Value.ToString() + " " + "23:59:59";
            DateTime fDate = Convert.ToDateTime(fromdate);
            DateTime tDate = Convert.ToDateTime(todate);
            long refcode = Convert.ToInt64(hdnReferedPhyID.Value);
            foreach (ListItem item in chkCategory.Items)
            {
                if (item.Selected == true)
                {
                    if (flag == 0)
                    {
                        ReceiverType = item.Value;
                        flag++;
                    }
                    else
                    {
                        ReceiverType = ReceiverType + "," + item.Value;
                    }
                }
            }
            List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
            Master_BL MBL = new Master_BL(base.ContextInfo);
            returncode = MBL.GetrefPhysician(refcode, OrgID, ReceiverType, fDate, tDate, out lstBillingDetails);
            if (lstBillingDetails.Count > 0)
            {
                GridRefPhysician.DataSource = lstBillingDetails;
                GridRefPhysician.DataBind();
                divOPDWCR.Style.Add("display", "block");
                hdnXLFlag.Value = "1";
            }
            else
            {                
               // ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Alt", "alert('No Matching Record Found');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alt", "javascript:ValidationWindow('" + DispText + "','" + AlrtWin + "');", true);
                divOPDWCR.Style.Add("display", "none");
                GridRefPhysician.DataSource = "";
                hdnXLFlag.Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get Details ", ex);
        }
        clear();

    }
    private void clear()
    {
        hdnReferedPhyID.Value = "0";
        txtInternalExternalPhysician.Text = "";
    }
    public void LoadMeatData()
    {
        string DispText1 = Resources.ReportsLims_ClientDisplay.ReportsLims_RefPhysicianSearch_aspx_02 == null ? "TestClassification" : Resources.ReportsLims_ClientDisplay.ReportsLims_RefPhysicianSearch_aspx_02;
        string DispText2 = Resources.ReportsLims_ClientDisplay.ReportsLims_RefPhysicianSearch_aspx_03 == null ? "en-GB" : Resources.ReportsLims_ClientDisplay.ReportsLims_RefPhysicianSearch_aspx_03;
        try
        {

            long returncode = -1;

           // string domains = "TestClassification";
            string domains = DispText1;
            string[] Tempdata = domains.Split(',');
            //string LangCode = "en-GB";
            string LangCode = DispText2;
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
                                 where child.Domain == "TestClassification"
                                 orderby child.DisplayText ascending
                                 select child;
                if (childItems.Count() > 0)
                {
                    chkCategory.DataSource = childItems;
                    chkCategory.DataTextField = "DisplayText";
                    chkCategory.DataValueField = "Code";
                    chkCategory.DataBind();
                    
                }
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data  ", ex);
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
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void lnkExportXL_Click(object sender, EventArgs e)
    {
        try
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "ReferingPhysician.xls"));
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {

                    GridRefPhysician.RenderControl(htw);
                    //gvIPCreditMain.RenderEndTag(htw);
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();


                }
            }
        }
        catch (Exception ex)
        {

        }
    }
}
