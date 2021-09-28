using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using System.Collections.Generic;
using Attune.Kernel.InventoryReports.BL;
using System.IO;

public partial class InventoryReports_SupplierwiseExpiryReport : Attune_BasePage
{
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Attuneheader.IsShowMenu = true;
            txtFDate.Text = DateTimeUtility.GetServerDate().ToExternalDate();
            txtTDate.Text = DateTimeUtility.GetServerDate().ToExternalDate();
            txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
            txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");

            LoadOrgan();

        }
    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            new Master_BL(ContextInfo).GetSharingOrganizations(OrgID, out lstOrgList);
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

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        ExportToXL();
    }

    protected void lnkExportXL_Click(object sender, EventArgs e)
    {
        ExportToXL();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        LoadGrid();
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
    public void ExportToXL()
    {

        //Response.Clear();
        //Response.AddHeader("content-disposition", "attachment;filename=Expesnses Report.xls");
        //Response.Charset = "";
        //Response.ContentType = "application/vnd.xls";
        //System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        //System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename=Suppierwise Expiry Report.xls"));
        HttpContext.Current.Response.ContentType = "application/ms-excel";
        HttpContext.Current.Response.Write(getReportHeader(true, grdsupplier.Columns.Count));
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter htw = new HtmlTextWriter(sw))
            {
                tblgrdDynamic.RenderControl(htw);
                HttpContext.Current.Response.Write(sw.ToString());
                HttpContext.Current.Response.End();
            }
        }
       // tblgrdDynamic.RenderControl(htmlWrite);
        //Response.Write(stringWrite.ToString());
        //Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void ddlTrustedOrg_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    public void LoadGrid()
    {
        long returncode = -1;
        DataTable dt = new DataTable();
        DateTime fDate = txtFDate.Text.ToInternalDate();
        DateTime tDate = txtTDate.Text.ToInternalDate();
        returncode = new InventoryReports_BL(base.ContextInfo).GetSupplierWiseExpiryRpt(fDate, tDate, OrgID, out dt);
        grdsupplier.DataSource = dt;
        grdsupplier.DataBind();
    }
    public string getReportHeader(bool rptFlag, int tdCount)
    {
        string strHeader = string.Empty;
        string rptName = string.Empty;
        List<Organization> lstOrganization = new List<Organization>();
        rptName = "Supplierwise Expiry Report";
        long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
        //strHeader = "<img src='F:/VSSProduct/Application/App/WebApp/PlatForm/Images/Logo/321.jpg' />";
        //strHeader += "<center><h1>" + OrgName.ToString() + "</h1></center>";
        //strHeader += "<center>";
        string path = Request.PhysicalApplicationPath + lstOrganization[0].LogoPath.Replace("..", "").Replace("/", "\\");
        strHeader = "<table style='width:100%;'><tr><td></td><td></td><td></td><td align='center'><img src='" + path + "' /></td><td></td></tr>";
        strHeader += "<tr><td></td></tr><tr><td align='left'><h1>" + OrgName.ToString() + "</h1></td><td></td><td></td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].Address + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'>Report Name : " + rptName + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].City + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'>Report Date : " + DateTime.Now.ToShortDateString() + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].PhoneNumber + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'></td></tr>";
        strHeader += "<tr><td align='left'>From Date:</td><td align='LEFT'>" + txtFDate.Text + "</td></tr>";
        strHeader += "<tr><td align='left'>To Date:</td><td align='LEFT'>" + txtTDate.Text + "</td></tr>";
        strHeader += "<tr><td><br /></td></tr>";
        strHeader += "</table></center>";

        return strHeader;
    }

    public string getBlankTD(int tdCount)
    {
        string strTD = string.Empty;
        if (tdCount > 4)
        {
            tdCount -= 4;
        }
        while (tdCount > 0)
        {
            strTD += "<td></td>";
            tdCount--;
        }
        return strTD;
    }
}