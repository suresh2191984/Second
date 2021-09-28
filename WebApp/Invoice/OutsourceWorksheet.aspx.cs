using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.Data.SqlClient;
using System.Configuration;
using iTextSharp.text;
using System.IO;
using System.Collections;


public partial class Invoice_OutsourceWorksheet : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtFDate.Text = OrgTimeZone;
            txtTDate.Text = OrgTimeZone;
            LoadOrganisation();


        }

    }

    private void LoadOrganisation()
    {
        try
        {
            long returnCode = -1;
            BillingEngine billBL = new BillingEngine();

            List<LabReferenceOrg> lstlabreforg = new List<LabReferenceOrg>();
            returnCode = billBL.GetOrganisationDetails(OrgID, out lstlabreforg);
            if (lstlabreforg.Count > 0)
            {
                ddlOrganisation.DataSource = lstlabreforg;
                ddlOrganisation.DataTextField = "RefOrgName";
                ddlOrganisation.DataValueField = "LabRefOrgID";
                ddlOrganisation.DataBind();
                // ddlOrganisation.Items.Insert(0, new ListItem("--Select--", "0"));

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load GetOrganisationDetails", ex);
        }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            long ReturnCode = -1;
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            long LabRefId = Convert.ToInt64(ddlOrganisation.SelectedItem.Value);
            List<InvRateMaster> lstrate = new List<InvRateMaster>();
            List<OutsourcingDetail> lstoutsourcce = new List<OutsourcingDetail>();
            List<LabRefOrgAddress> lstadd = new List<LabRefOrgAddress>();
            List<GeneralBillingItems> lstbill = new List<GeneralBillingItems>();
            BillingEngine billbl = new BillingEngine();
            ReturnCode = billbl.GetOutSourceWorksheet(fDate, tDate, LabRefId, OrgID, out lstoutsourcce, out lstrate, out lstadd, out lstbill);
            if (lstoutsourcce.Count > 0)
            {
                lblResult.Style.Add("display","none");
                tabPrintButton.Style.Add("display", "table");
                tblPrint.Style.Add("display", "table");
                grdInvoice.Style.Add("display", "table");
                lblClientAddress.Text = lstadd[0].Add1;
                lbltotsample.Text = lstrate[0].SamplesTot.ToString();
                lbltotpattients.Text = lstrate[0].PatientsTot.ToString();
                lbltotamount.Text = lstrate[0].Rate.ToString();
                lblcharges.Text = lstbill[0].Rate.ToString();
                lblamtpayable.Text = (Convert.ToDecimal(lbltotamount.Text) + Convert.ToDecimal(lblcharges.Text)).ToString();
                grdInvoice.DataSource = lstoutsourcce;
                grdInvoice.DataBind();
                

            }
            else
            {
                lblResult.Style.Add("display", "table");
                tabPrintButton.Style.Add("display", "none");
                tblPrint.Style.Add("display", "none");
                grdInvoice.Style.Add("display", "none");
               // lblResult.Visible = true;
               
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load GetOrganisationDetails", ex);
        }



    }

    protected void imgpdf_Click(object sender, ImageClickEventArgs e)
    {

        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=OutsourceWorksheet"+ Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter stringWriter = new StringWriter();
        HtmlTextWriter htmlTextWriter = new HtmlTextWriter(stringWriter);
       
        prnReport.RenderControl(htmlTextWriter);
        StringReader stringReader = new StringReader(stringWriter.ToString());
        Document Doc = new Document(PageSize.A4.Rotate(), 10f, 10f, 70f, 0f);
        HTMLWorker htmlparser = new HTMLWorker(Doc);
        PdfWriter.GetInstance(Doc, Response.OutputStream);
        Doc.Open();
        htmlparser.Parse(stringReader);
        Doc.Close();
        Response.Write(Doc);
        Response.End();

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    protected void grdInvoice_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[3].Attributes.Add("style", "word-break:break-all;word-wrap:break-word;");
        }
    }
}
 

    

