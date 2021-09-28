using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_DispensingReport : Attune_BasePage
{
    public InventoryReports_DispensingReport()
        : base("InventoryReports_DispensingReport_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<BillingDetails> lstHeadBillingDetails = new List<BillingDetails>();
    List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
    List<Organization> lstOrganization = new List<Organization>();
    int currentPageNo = 1;
    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    string userMsg = Resources.InventoryReports_AppMsg.InventoryReports_DispensingReport_aspx_11 == null ? "No Matching Records were Found" : Resources.InventoryReports_AppMsg.InventoryReports_DispensingReport_aspx_11;
    string ErrorMsg = Resources.InventoryReports_AppMsg.InventoryReports_Error == null ? "Alert" : Resources.InventoryReports_AppMsg.InventoryReports_Error;
    protected void Page_Load(object sender, EventArgs e)
    {
        btnGo1.Attributes.Add("onclick", "return checkForValues();");
        //txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        //txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
        if (!IsPostBack)
        {
            txtFrom.Text = DateTimeNow.ToExternalDate();
            txtTo.Text = DateTimeNow.ToExternalDate();
            LoadLocationName();
            LoadOrgan();
            LoadVisitType();
        }
       
    }
    public void LoadVisitType()
    {long returncode = -1;
    string domains = "PatientVisitType,";
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

        returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
        if (lstmetadataOutput.Count > 0)
        {
            var childItems = from child in lstmetadataOutput
                             where child.Domain == "PatientVisitType"
                             select child;
            rblVisitType.DataSource = childItems;
            rblVisitType.DataTextField = "DisplayText";
            rblVisitType.DataValueField = "Code";
            rblVisitType.DataBind();
            if (childItems.Count() > 0)
            {
                rblVisitType.SelectedValue = "-1";
            }
        }
    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            InventoryReports_BL objBl = new InventoryReports_BL(base.ContextInfo);
            new Master_BL(base.ContextInfo).GetSharingOrganizations(OrgID, out lstOrgList);
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
    protected void ddlTrustedOrg_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadLocationName();
    }
    private void LoadLocationName()
    {
        try
        {
            List<Locations> lstLocation = new List<Locations>();
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            new Master_BL(ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocation);
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
            ddlLocation.SelectedValue = InventoryLocationID.ToString();
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            txtpageNo.Text = "";
            hdnCurrent.Value = "";
            LoaderDispensingReport(e, currentPageNo, PageSize);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading DispensingReport", ex);
        }
    }
    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoaderDispensingReport(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoaderDispensingReport(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoaderDispensingReport(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoaderDispensingReport(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnGo_Click1(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        LoaderDispensingReport(e, Convert.ToInt32(txtpageNo.Text), PageSize);
    }
    public void LoaderDispensingReport(EventArgs e, int currentPageNo, int PageSize)
    {
        try
        {
            long returnCode = -1;
            DateTime fromDate = DateTimeNow;
            DateTime toDate =DateTimeNow;
            if(!String.IsNullOrEmpty(txtFrom.Text.Trim()))
            {
                fromDate = txtFrom.Text.ToInternalDate();
            }
            if (!String.IsNullOrEmpty(txtFrom.Text.Trim()))
            {
                toDate = txtTo.Text.ToInternalDate();
            }
            /*-------------------------------------*/
            int visitType;

            if (rblVisitType.SelectedItem.Value != "")
            {
                visitType = Convert.ToInt16(rblVisitType.SelectedItem.Value);
            }

            else
            {
                visitType = -1;
            }
            /*--------------------------------------*/
            string Billno = Convert.ToString(txtBillNo.Text.Trim() == "" ? "-1" : txtBillNo.Text);
            string PName = txtPatientName.Text == "" ? "" : txtPatientName.Text;
            string Product = txtProductName.Text == "" ? "" : txtProductName.Text;
            int DepartmentID = int.Parse(ddlLocation.SelectedValue);
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            returnCode = new InventoryReports_BL(base.ContextInfo).GetDispensingReport(fromDate, toDate, OrgID, Billno, PName, ILocationID, Product, PageSize, visitType, currentPageNo, out totalRows, DepartmentID, out lstHeadBillingDetails, out lstBillingDetails);

            lstHeadBillingDetails = (from S in lstBillingDetails
                                     join T in lstHeadBillingDetails on S.FinalBillID equals T.FinalBillID
                                     select T).Distinct().ToList();



            if (lstHeadBillingDetails.Count > 0)
            {
                GrdFooter.Style.Add("display", "block");
                totalpage = totalRows;
                lblTotal.Text = CalculateTotalPages(totalRows).ToString();

                if (hdnCurrent.Value == "")
                {
                    lblCurrent.Text = currentPageNo.ToString();
                }
                else
                {
                    lblCurrent.Text = hdnCurrent.Value;
                    currentPageNo = Convert.ToInt32(hdnCurrent.Value);
                }
                if (currentPageNo == 1)
                {
                    Btn_Previous.Enabled = false;

                    if (Int32.Parse(lblTotal.Text) > 1)
                    {
                        Btn_Next.Enabled = true;
                    }
                    else
                        Btn_Next.Enabled = false;
                }
                else
                {
                    Btn_Previous.Enabled = true;

                    if (currentPageNo == Int32.Parse(lblTotal.Text))
                        Btn_Next.Enabled = false;
                    else Btn_Next.Enabled = true;
                }


                tblTool.Style.Add("display", "block");
                //HyperLink1.NavigateUrl = "PrintDispensingReport.aspx?dFrom=" + txtFrom.Text + "&dTo=" + txtTo.Text + "&Bno=" + txtBillNo.Text + "&pnme=" + txtPatientName.Text + "&pro=" + txtProductName.Text + "&pdeID=" + DepartmentID;
            }
            else
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:ValidationWindow('" + userMsg + "','" + ErrorMsg + "');", true);
            GrdFooter.Style.Add("display", "none");
            gvResult.DataSource = (lstHeadBillingDetails.OrderBy(p => p.CreatedAt)).ToList();
            gvResult.DataBind();
            if (rblVisitType.SelectedItem.Value == "0")
            {
                gvResult.Columns[2].Visible = false;
            }
            else
            {
                gvResult.Columns[2].Visible = true;
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while loading DispensingReport", ex);
        }
    }
    string strOP = Resources.InventoryReports_ClientDisplay.InventoryReports_DispensingReport_aspx_01 == null ? "OP" : Resources.InventoryReports_ClientDisplay.InventoryReports_DispensingReport_aspx_01;
    string strIP = Resources.InventoryReports_ClientDisplay.InventoryReports_DispensingReport_aspx_02 == null ? "IP" : Resources.InventoryReports_ClientDisplay.InventoryReports_DispensingReport_aspx_02;
    string strWalkin = Resources.InventoryReports_ClientDisplay.InventoryReports_DispensingReport_aspx_03 == null ? "Walkin" : Resources.InventoryReports_ClientDisplay.InventoryReports_DispensingReport_aspx_03;

    protected void gvResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            Label l1 = (Label)e.Row.FindControl("lblGrdVisitType");
            switch (l1.Text)
            {
                case "0":
                    l1.Text = strOP;
                    l1.ForeColor = System.Drawing.Color.DarkMagenta;
                    l1.Font.Size = 11;
                    break;
                case "1":
                    l1.Text = strIP;
                    l1.ForeColor = System.Drawing.Color.Brown;
                    l1.Font.Size = 11;
                    break;
                case "-1":
                    l1.Text = strWalkin;
                    l1.ForeColor = System.Drawing.Color.Black;
                    l1.Font.Size = 11;
                    break;


            }

            BillingDetails temp = (BillingDetails)e.Row.DataItem;
            GridView rptChildResult = (GridView)e.Row.FindControl("rptChildResult");
            rptChildResult.DataSource = lstBillingDetails.FindAll(p => p.FinalBillID == temp.FinalBillID && p.CreatedAt == temp.CreatedAt).Distinct();
            rptChildResult.DataBind();
            if (e.Row.Cells[3].Text == "0")
                e.Row.Cells[3].Text = "-";

        }
    }

    protected void gvResult1_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Visible = true;
        }
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }
    protected void gvResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }
    protected void imgBtnXL_Click(Object sender, EventArgs e)
    {
        try
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            gvResult.AllowPaging = false;
            LoaderDispensingReport(e, currentPageNo, PageSize);
            FilterControls(gvResult);
            ExportToExcel();
            gvResult.AllowPaging = true;
            gvResult.DataSource = lstHeadBillingDetails.OrderBy(p => p.CreatedAt).ToList();
            gvResult.DataBind();
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    public void ExportToExcel()
    {
        //export to excel
        string prefix = string.Empty;
        string space = "<br/><br/><br/><br/><br/>";
        prefix = Resources.InventoryReports_ClientDisplay.InventoryReports_DispensingReport_aspx_06;

        string rptDate = prefix + DateTimeNow.ToExternalDate();
        string attachment = "attachment; filename=" + rptDate + ".xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        #region To render Header of report
        HttpContext.Current.Response.Write(getReportHeader(gvResult.Columns.Count));
        #endregion
        #region Render grid control to report
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);

        gvResult.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.Write(space);
        #endregion
        #region To render Footer of report
        HttpContext.Current.Response.Write(getReportFooter(gvResult.Columns.Count));

        #endregion
        Response.End();


    }
    string strReportName = Resources.InventoryReports_ClientDisplay.InventoryReports_DispensingReport_aspx_04 == null ? "Report Name" : Resources.InventoryReports_ClientDisplay.InventoryReports_DispensingReport_aspx_04;
    string strReportdate = Resources.InventoryReports_ClientDisplay.InventoryReports_DispensingReport_aspx_05 == null ? "Report date" : Resources.InventoryReports_ClientDisplay.InventoryReports_DispensingReport_aspx_05;

    public string getReportHeader(int tdCount)
    {
        string strHeader = string.Empty;
        string rptName = string.Empty;
        long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);

        rptName = "<span style='font-size:14.0pt; color:block;font-weight:700;'>" + Resources.InventoryReports_ClientDisplay.InventoryReports_DispensingReport_aspx_07 + "</span>";

        strHeader = "<center><h3>" + OrgName.ToString() + "</h3></center>";
        strHeader += "<center><table>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].Address + "</td>" + getBlankTD(tdCount + 2) + "<td align='LEFT'>" + strReportName + " : " + rptName + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].City + "</td>" + getBlankTD(tdCount + 2) + "<td align='LEFT'>" + strReportdate + " : " + DateTimeNow.ToExternalDate() + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].PhoneNumber + "</td>" + getBlankTD(tdCount + 2) + "<td align='LEFT'></td></tr>";
        strHeader += "<tr><td><br /></td></tr>";
        strHeader += "</table></center>";

        return strHeader;
    }
    public string getReportFooter(int tdCount)
    {
        string Sign = Resources.InventoryReports_ClientDisplay.InventoryReports_DispensingReport_aspx_08 == null ? "Signature" : Resources.InventoryReports_ClientDisplay.InventoryReports_DispensingReport_aspx_08;
        string strHeader = string.Empty;
        strHeader += "<table align='Right'>";
        strHeader += "<tr><td>" + Sign + "</td></tr></table>";
        strHeader += "</table> ";

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
    //public string SetExpDateIn(string input)
    //{
    //    DateTime dt = new DateTime(1901, 1, 1);
    //    if (DateTime.Parse(input) <= dt)
    //    {
    //        return "--";
    //    }
    //    else
    //    {
    //        return input;
    //    }
    //}


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
    protected static string GetDate(object dataItem)
    {
        if (dataItem.ToString() == "Jan/1753")
        {
            return "**";
        }
        return dataItem.ToString();
    }
}
