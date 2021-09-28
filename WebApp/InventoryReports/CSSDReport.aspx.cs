using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Web.UI.HtmlControls;
using System.Web.Script.Serialization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.Common;
using System.Data;
using Attune.Kernel.PlatForm.BL;


public partial class InventoryReports_CSSDReport : Attune_BasePage 
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    DataSet ds = new DataSet();
    //decimal pTotalDiscountAmt = -1;
    public InventoryReports_CSSDReport()
        : base("InventoryReports_CSSDReport_aspx")
   {
   }
    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            LoadOrgan();
            LoadMeta();
            txtFDate.Text = DateTimeNow.ToExternalDate();
            txtTDate.Text = DateTimeNow.ToExternalDate();
        }
    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            new Master_BL(ContextInfo).GetSharingOrganizations(OrgID, out lstOrgList);
            InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            List<Organization> lstorgn = new List<Organization>();
            List<Locations> lstloc = new List<Locations>();
            new TrustedOrg_BL(ContextInfo).GetSharingOrgList(OrgID, out lstorgn, out lstloc);
            if (lstOrgList.Count > 0)
            {
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrgID";
                ddlTrustedOrg.DataBind();
                //ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                if (lstOrgList.Count(p => p.OrgID == OrgID) > 0)
                {
                    ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).OrgID.ToString();
                }
                ddlTrustedOrg.Focus();
            }
            lstloc.RemoveAll(P => P.LocationID == InventoryLocationID);
            ddlFLocation.DataSource = lstloc;
            ddlFLocation.DataTextField = "LocationName";
            ddlFLocation.DataValueField = "LocationID";
            ddlFLocation.DataBind();
            ddlFLocation.Items.Insert(0, GetMetaData("Select","0"));
            ddlTLocation.DataSource = lstloc;
            ddlTLocation.DataTextField = "LocationName";
            ddlTLocation.DataValueField = "LocationID";
            ddlTLocation.DataBind();
            ddlTLocation.Items.Insert(0, GetMetaData("Select", "0"));

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            //int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            List<CSSD> lstcssd = new List<CSSD>();
            int Flocation = -1;
            int Tlocation = -1;
            int Status = -1;
            if (ddlFLocation.Items.Count > 0)
            Flocation = Convert.ToInt32(ddlFLocation.SelectedValue);
            if (ddlTLocation.Items.Count > 0)
            Tlocation = Convert.ToInt32(ddlTLocation.SelectedValue);
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            Status = Convert.ToInt32(rblVisitType.SelectedValue);
            returnCode = new InventoryReports_BL(base.ContextInfo).GetCSSDValues(txtFDate.Text, txtTDate.Text, OrgID, Status, Flocation, Tlocation, "CS-POS", out lstcssd);
            if (lstcssd.Count > 0)
            {
                divOPDWCR.Attributes.Add("style", "block");
                divPrint.Attributes.Add("style", "block");
                grdResult.DataSource = lstcssd;
                grdResult.DataBind();
            }
            else
            {
                divOPDWCR.Attributes.Add("style", "none");
                divPrint.Attributes.Add("style", "none");
                grdResult.DataSource = null;
                grdResult.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, CreditCardStmt", ex);
        }
    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reports/ViewReportList.aspx", true);
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

   protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        ExportToExcel(divOPDWCR);
    }
   public void ExportToExcel(Control ctr)
   {
       try
       {

           string prefix = string.Empty;
           prefix = "CSSD Reports_";
           string rptDate = prefix + DateTimeUtility.GetServerDate().ToExternalDate();
           string attachment = "attachment; filename=" + rptDate + ".xls";
           Response.ClearContent();
           Response.AddHeader("content-disposition", attachment);
           Response.ContentType = "application/ms-excel";
           Response.Charset = "";
           this.EnableViewState = false;
           System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
           HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);

           oHtmlTextWriter.WriteLine("<span style='font-size:14.0pt; color:#538ED5;font-weight:700;'>CSSD Report </span>");
           divOPDWCR.RenderControl(oHtmlTextWriter);
           //ctr.RenderControl(oHtmlTextWriter);
           HttpContext.Current.Response.Write(oStringWriter);
           oHtmlTextWriter.Close();
           oStringWriter.Close();
           Response.End();

       }
       catch (InvalidOperationException ioe)
       {
           CLogger.LogError("Error in Userwise Collection  Report-ExportToExcel", ioe);
       }
   }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    public void LoadMeta()
    {
        string domains = "ReportFormat,";
        string[] Tempdata = domains.Split(',');
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();
        MetaData objMeta;
        for (int i = 0; i < Tempdata.Length; i++)
        {
            objMeta = new MetaData();
            objMeta.Domain = Tempdata[i];
            lstmetadataInput.Add(objMeta);

        }
        returnCode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, languageCode, out lstmetadataOutput);
        if (lstmetadataOutput.Count > 0)
        {
            var childItems = from child in lstmetadataOutput
                             where child.Domain == "ReportFormat"
                             orderby child.DisplayText descending
                             select child;
            if (childItems.Count() > 0)
            {
                rblReportType.DataSource = childItems;
                rblReportType.DataTextField = "DisplayText";
                rblReportType.DataValueField = "Code";
                rblReportType.DataBind();

                rblReportType.SelectedValue = "1";
            }
        }
    }

}
