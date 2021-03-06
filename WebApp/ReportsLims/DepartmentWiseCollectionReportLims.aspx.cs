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
using System.Text;

public partial class ReportsLims_DepartmentWiseCollectionReportLims : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstCash = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lstCredit = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lstTotal = new List<DayWiseCollectionReport>();
    SharedInventory_BL inventoryBL;
    List<Organization> lstorgn = new List<Organization>();
    List<Locations> lstloc = new List<Locations>();
    decimal pTotalDiscount = 0;
    decimal pTotalRefund = 0;
    decimal pTotalDue = 0;
    decimal pTotalGrossAmount = 0;
    decimal pTotalNetAmount = 0;
    decimal pTotalAdvance = 0;
    decimal pCashDiscount = 0;
    decimal pCreditDiscount = 0;
    decimal pTotalDeposit = 0;
    public ReportsLims_DepartmentWiseCollectionReportLims()
        : base("ReportsLims_DepartmentWiseCollectionReportLims_aspx")
    {

    }
   
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new SharedInventory_BL(base.ContextInfo);
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            txtFDate.Text = OrgTimeZone;
            txtTDate.Text = OrgTimeZone;
            List<Config> lstConfig = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("No Need Collection Split up", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
                hdnNeedSplitup.Value = lstConfig[0].ConfigValue.Trim();
            LoadOrgan();
            LoadMetaData();
        }
    }
    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "ReportFormat,VisitType1";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            // string LangCode = string.Empty;
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            //if (returncode == 0)
            //{
            if (lstmetadataOutput.Count > 0)
            {
                //var ReportFormat = from child in lstmetadataOutput
                //                   where child.Domain == "ReportFormat"
                //                   orderby child.DisplayText
                //                   select child;
                //rblReportType.DataSource = ReportFormat;
                //rblReportType.DataTextField = "DisplayText";
                //rblReportType.DataValueField = "Code";
                //rblReportType.DataBind();

                //rblReportType.SelectedValue = "-1";
                
                var VisitType = from child in lstmetadataOutput
                                where child.Domain == "VisitType1"
                                orderby child.DisplayText
                                select child;
                rblVisitType.DataSource = VisitType;
                rblVisitType.DataTextField = "DisplayText";
                rblVisitType.DataValueField = "Code";
                rblVisitType.DataBind();
                rblVisitType.SelectedValue = "2";
            }


        }





        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            objBl.GetSharingOrganizations(OrgID, out lstOrgList);
            if (lstOrgList.Count > 0)
            {
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrgID";
                ddlTrustedOrg.DataBind();
                ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                ddlTrustedOrg.Focus();
            }

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
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            int visitType = 1;
            int Flag = 0;
            lblfromdate.Text = txtFDate.Text;
            lbltodate.Text = txtTDate.Text;
            foreach (ListItem item in rblReportType.Items)
            {
                if (item.Selected)
                {
                    if (Flag == 0)
                    {
                        visitType = Convert.ToInt32(item.Value);
                        Flag = Flag+1;

                    }
                    else
                    {
                        visitType = 101;
                    }
                }
            }
 
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);

            //if (rblReportType.SelectedValue == "0")
            //{
            //    returnCode = new Report_BL(base.ContextInfo).GetDepartmentWiseCollectionReportLims(fDate, tDate, OrgID, visitType, out lstCash, out lstCredit, out lstTotal, out pTotalDiscount, out pTotalRefund, out pTotalDue, out pTotalGrossAmount, out pTotalAdvance, out pCashDiscount, out pCreditDiscount, out pTotalDeposit);
            //   // grdTotal.Columns[0].Visible = false;
            //   // grdTotal.Columns[1].Visible = true;
            //}
            //else
            //{
            if (Flag > 0)
            {
                returnCode = new Report_BL(base.ContextInfo).GetDepartmentWiseDetailReportLims(fDate, tDate, OrgID, visitType, out lstCash, out lstCredit, out lstTotal, out pTotalDiscount, out pTotalRefund, out pTotalDue, out pTotalGrossAmount, out pTotalAdvance, out pCashDiscount, out pCreditDiscount, out pTotalDeposit);

                // grdTotal.Columns[1].Visible = false;
                //  grdTotal.Columns[0].Visible = true;
                // }

                if (visitType == 101)
                {

                    lblreport.Text = "Departmentwise Collection Report";
                    divTotalDue.Visible = true;
                    divTotalRefund.Visible = true;
                    divTotalDeposit.Visible = true;
                    // divTotalAdvance.Visible = true;
                    divTotalGross.Visible = true;
                    divTotalDiscount.Visible = true;
                    divCreditDiscount.Visible = true;
                    divCashDiscount.Visible = true;
                    divTotalAdvance.Visible = true;
                    lblTotalAdvance.Text = "Total General BillAmount(Miscellaneous) :" + pTotalAdvance.ToString("#.00");
                    lblCreditDiscount.Text = "Total Credit NetAmount :" + pCreditDiscount.ToString("#.00");
                    lblCashDiscount.Text = "Total Cash NetAmount :" + pCashDiscount.ToString("#.00");
                    lblTotalDiscount.Text = "Total Discount Amount :" + pTotalDiscount.ToString("#.00");
                    lblTotalGross.Text = "Total Gross Amount (LIS+RIS+PKG) :" + pTotalGrossAmount.ToString("#.00");
                    lblTotalNetAmount.Text = "Total NetAmount :" + pTotalDeposit.ToString("#.00");
                    lblTotalRefund.Text = "Total Cancel/ Refund Amount :" + pTotalRefund.ToString("#.00");
                    lblTotalDue.Text = "Total Due Amount :" + pTotalDue.ToString("#.00");
                    lblTotalDue.Text = "Total Due Amount :" + pTotalDue.ToString("#.00");
                }
                else
                {
                    if (visitType == 0)
                    {
                        lblreport.Text = "RIS Collection Report";
                    }
                    else
                    {
                        lblreport.Text = "LIS Collection Report";
                    }

                    divTotalDue.Visible = false;
                    divTotalRefund.Visible = false;
                    divTotalDeposit.Visible = false;
                    // divTotalAdvance.Visible = true;
                    divTotalGross.Visible = false;
                    divTotalDiscount.Visible = false;
                    divCreditDiscount.Visible = false;
                    divCashDiscount.Visible = false;
                    divTotalAdvance.Visible = false;
                }


                //// Code modified by Vijay TV on Sep 22 2011 begins - for providing Cash, Card, Cheque, Draft split up for various categories
                //// The formatting (#.00) is done when double is converted ot String - To show decimal format for the amount displayd
                //lblTotalGross.Text = "Total Gross Billed Amount: " + pTotalGrossAmount.ToString("#.00");
                //lblTotalDiscount.Text = "Total Discount Amount: " + pTotalDiscount.ToString("#.00");
                //lblTotalNet.Text = "Total Net Billed Amount: " + (pTotalGrossAmount - pTotalDiscount).ToString("#.00");
                //lblTotalReceived.Text = "Total Received Amount: " + ((pTotalGrossAmount - pTotalDiscount) - pTotalDue).ToString("#.00");
                //lblTotalBalance.Text = "Total Balance Amount: " + (((pTotalGrossAmount - pTotalDiscount) - pTotalDue) - pTotalRefund).ToString("#.00");


                //if (visitType == 0 || visitType == -1)
                //{
                //    if (visitType == 0)
                //    {
                //        divTotalAdvance.Visible = false;
                //        lblTotalDue.Text = "Total Due Collection: " + pTotalDue.ToString("#.00");
                //    }
                //    else
                //    {

                //    }
                //}
                //else
                //    lblTotalAdvance.Text = "Total Advance Amount: " + pTotalAdvance.ToString("#.00");
                //lblTotalAmountInHand.Text = "Total Balance On Hand: " + ((((pTotalGrossAmount - pTotalDiscount) - pTotalDue) - pTotalRefund) + pTotalAdvance).ToString("#.00");
                // Code modified by Vijay TV on Sep 22 2011 ends

                if (lstCash.Count > 0)
                {
                    if (hdnNeedSplitup.Value == "N")
                    {
                        grdCash.Visible = true;
                        lblCash.Visible = true;
                        grdCash.DataSource = lstCash;
                        grdCash.DataBind();
                        tblWithSplit.Style.Add("display", "block");
                        tblWithoutSplit.Style.Add("display", "none");
                    }
                    else
                    {
                        tblWithoutSplit.Style.Add("display", "block");
                        tblWithSplit.Style.Add("display", "none");
                        grdCashPatient.DataSource = lstCash;
                        grdCashPatient.DataBind();
                    }

                }
                else
                {
                    lblCash.Visible = false;
                    grdCash.Visible = false;
                }
                if (lstCredit.Count > 0)
                {
                    if (hdnNeedSplitup.Value == "N")
                    {
                        grdCredit.Visible = true;
                        lblCredit.Visible = true;
                        grdCredit.DataSource = lstCredit;
                        grdCredit.DataBind();
                        tblWithSplit.Style.Add("display", "block");
                        tblWithoutSplit.Style.Add("display", "none");
                    }
                    else
                    {
                        tblWithoutSplit.Style.Add("display", "block");
                        tblWithSplit.Style.Add("display", "none");
                        grdCreditPatient.DataSource = lstCredit;
                        grdCreditPatient.DataBind();
                    }

                }
                else
                {
                    grdCredit.Visible = false;
                    lblCredit.Visible = false;
                }
                if (lstTotal.Count > 0)
                {
                    btnPrintAll.Visible = true;
                    if (hdnNeedSplitup.Value == "N")
                    {
                        grdTotal.Visible = true;
                        lblTotal.Visible = true;
                        grdTotal.DataSource = lstTotal;
                        grdTotal.DataBind();
                        tblWithSplit.Style.Add("display", "block");
                        tblWithoutSplit.Style.Add("display", "none");
                    }
                    else
                    {
                        tblWithoutSplit.Style.Add("display", "block");
                        tblWithSplit.Style.Add("display", "none");
                        grdCashCreditPatient.DataSource = lstTotal;
                        grdCashCreditPatient.DataBind();
                    }





                }
                else
                {
                    grdTotal.Visible = false;
                    lblTotal.Visible = false;
                }

                if (lstTotal.Count() > 0)
                {
                    lblMessage.Visible = false;

                }
                else
                {
                    lblMessage.Visible = true;
                }

            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('No Matching Records Found!');", true);
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, GetPatientWiseCombinedReport", ex);
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

    protected void btn_export_Click(object sender, EventArgs e)
    {

        try
        {

            ExportToExcel(lblCash); ExportToExcel(grdCash);
            ExportToExcel(lblCredit); ExportToExcel(grdCredit);
            ExportToExcel(lblTotal); ExportToExcel(grdTotal);
           // ExportToExcel(others);
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Excel Export", ex);

        }

    }
    public void ExportToExcel(Control CTRl)
    {


        Response.Clear();
        Response.AddHeader("content-disposition",
        string.Format("attachment;filename={0}.xls", "Department Wise Collection Report _" + Convert.ToDateTime(new BasePage().OrgDateTimeZone) .ToString()));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";

        StringWriter stringWrite = new StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        lblCash.RenderControl(htmlWrite); grdCash.RenderControl(htmlWrite);
        lblCredit.RenderControl(htmlWrite); grdCredit.RenderControl(htmlWrite);

        lblTotal.RenderControl(htmlWrite); grdTotal.RenderControl(htmlWrite);
        //others.RenderControl(htmlWrite);
        //gvSales.RenderControl(htmlWrite);

        Response.Write(stringWrite.ToString());
        Response.End();
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

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    private void FilterControls(Control gvRst)
    {
        //Removing Hyperlinks and other controls b4 export

        LinkButton lb = new LinkButton();
        HyperLink hl = new HyperLink();
        Literal l = new Literal();
        string name = String.Empty;
        for (int i = 0; i < gvRst.Controls.Count; i++)
        {
            if (gvRst.Controls[i].GetType() == typeof(LinkButton))
            {
                l.Text = (gvRst.Controls[i] as LinkButton).Text;
                gvRst.Controls.Remove(gvRst.Controls[i]);
                gvRst.Controls.AddAt(i, l);
            }
            if (gvRst.Controls[i].GetType() == typeof(HyperLink))
            {
                l.Text = (gvRst.Controls[i] as HyperLink).Text;
                gvRst.Controls.Remove(gvRst.Controls[i]);
                gvRst.Controls.AddAt(i, l);
            }
            if (gvRst.Controls[i].HasControls())
            {
                FilterControls(gvRst.Controls[i]);
            }
        }
    }

    protected void grdTotal_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //  e.Row.BackColor = System.Drawing.Color.PapayaWhip;
                e.Row.Font.Size = 8;

                if (e.Row.Cells[1].Text == "Total Gross Amount")
                {
                    e.Row.Font.Size = 9;
                    e.Row.Font.Bold = true;
                    e.Row.BackColor = System.Drawing.Color.Wheat;
                    e.Row.Cells[0].Text = "";                   
                }


            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading cashgrid Reports", Ex);
        }
    }
   

    protected void  grdTotal_RowCreated1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow && rblReportType.SelectedValue == "1")
        {
                e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='yellow';");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='white';");
        }

    }

    protected void grdCash_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //  e.Row.BackColor = System.Drawing.Color.PapayaWhip;
                e.Row.Font.Size = 8;

                if (e.Row.Cells[1].Text == "Total Gross Amount")
                {
                    e.Row.Font.Size = 9;
                    e.Row.Font.Bold = true;
                    e.Row.BackColor = System.Drawing.Color.Wheat;
                    e.Row.Cells[0].Text = "";
                    
                }


            }





        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading cashgrid Reports", Ex);
        }


    }

    protected void grdCredit_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //  e.Row.BackColor = System.Drawing.Color.PapayaWhip;
                e.Row.Font.Size = 8;

                if (e.Row.Cells[1].Text == "Total Gross Amount")
                {
                    e.Row.Font.Size = 9;
                    e.Row.Font.Bold = true;
                    e.Row.BackColor = System.Drawing.Color.Wheat;
                    e.Row.Cells[0].Text = "";
                   
                }


            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading cashgrid Reports", Ex);
        }


    }



   
}
