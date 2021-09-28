using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.IO;
using System.Drawing;
using Microsoft.Reporting.WebForms;
using Attune.Podium.Common;

public partial class Waters_QuotationDetails : BasePage
{

    public Waters_QuotationDetails()
        : base("Waters_QuotationDetails_aspx")
    {
    }

    string Fromdate = string.Empty;
    string Todate = string.Empty;
    string QuotationNo = string.Empty;
    int ClientName = -1;
    string TestName = string.Empty;
    string SampleType = string.Empty;
    string SalesPerson = string.Empty;
    int _SamColPerson = -1;
    string SampStatus = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

        ScriptManager.RegisterStartupScript(Page, this.GetType(), "TempDateandTime", "TempDateandTime();", true);
        if (!IsPostBack)
        {

            pnlquoDetails.Visible = false;

            txtFrom.Text = OrgTimeZone;
            txtTo.Text= OrgTimeZone;
            LoadDrpstatus();
        }

        btnConverttoXL.Enabled = false;

        AutoCompleteExtenderClientName.ContextKey = OrgID.ToString();

        AutoCompleteExtenderQuotationNo.ContextKey = OrgID.ToString() + "~QD_QNum";
        AutoCompleteSampType.ContextKey = OrgID.ToString() + "~SampType";
       AutoCompleteSalesPerson.ContextKey = OrgID.ToString() + "~SalesPerson";

    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        btnClear.Visible = true;
        btnSave.Visible = true;
        UpdateProgress1.Visible = true;
        SetCtlValuesForSearch();
        GetQuotationForApproval();
        // LoadMeatData();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
        return;
    }


    private void SetCtlValuesForSearch()
    {
        Fromdate = txtFrom.Text.ToString();
        Todate = txtTo.Text.ToString();

        if (txtquotationno.Text.Length > 1)
            QuotationNo = txtquotationno.Text.ToString();
        else
            QuotationNo = "-1";

        if (hdnClientID.Value.Length > 1)
            ClientName = Convert.ToInt32(hdnClientID.Value);
        else
            ClientName = -1;
        if (txtclientname.Text.Length > 1)
            ClientName = Convert.ToInt32(hdnClientID.Value.ToString());
        else
            ClientName = -1;

        if (txtSampType.Text.Length > 1)
            SampleType = txtSampType.Text.ToString();
        else
            SampleType = "-1";

        if (txtSalesPerson.Text.Length > 1)
            SalesPerson = txtSalesPerson.Text.ToString();
        else
            SalesPerson = "-1";

        SampStatus = drpstatus1.SelectedValue.ToString();
        // SampleType = drpSampletype.SelectedValue.ToString();

        //   SalesPerson = drpsalesperson.SelectedValue.ToString();





    }


    private void GetQuotationForApproval()
    {

        long returnCode = -1;
        int NumberOfRows = 0;


        Waters_BL ObjBL = new Waters_BL(base.ContextInfo);
        List<SampleSchedule> lstSampleForApprove = new List<SampleSchedule>();
        returnCode = ObjBL.GetQuotationForApproval(OrgID, Fromdate, Todate, QuotationNo, ClientName, SampleType, SalesPerson,SampStatus,out NumberOfRows, out lstSampleForApprove);

        if (lstSampleForApprove.Count == 0)
        {
            pnlquoDetails.Visible = false;
            GrdResult.Visible = true;


        }
        else
        {
            pnlquoDetails.Visible = true;
            GrdResult.Visible = false;
            grdquoDetails.Visible = true;
            grdquoDetails.DataSource = lstSampleForApprove;
            grdquoDetails.DataBind();
            btnConverttoXL.Enabled = true;
            lblNumberofRecords.Text = Convert.ToString(NumberOfRows);
        }

        // lblTotal.Text = CalculateTotalPages(totalRows).ToString();

    }
    public void LoadDrpstatus()
    {
        long returncode = -1;
        string domains = "WaterApprovalStatus";
        string[] Tempdata = domains.Split(',');
        string LangCode = "en-GB";
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();
        
        try
        {

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
                                 where child.Domain == "WaterApprovalStatus"
                                 select child;
                if (childItems.Count() > 0)
                {
                    drpstatus1.DataSource = childItems;
                    drpstatus1.DataTextField = "DisplayText";
                    drpstatus1.DataValueField = "Code";
                    drpstatus1.DataBind();
                    drpstatus1.Items.Insert(0, "ALL");
                    drpstatus1.Items[0].Value = "-1";
                    
                }

            }



        }
        catch (Exception ex)
        {
            // CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);

        }
    }

    public List<MetaData> LoadMeatData()
    {
        long returncode = -1;
        string domains = "WaterApprovalStatus";
        string[] Tempdata = domains.Split(',');
        string LangCode = "en-GB";
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();
        
        try
        {

            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);


        }
        catch (Exception ex)
        {
            // CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);

        }
        return lstmetadataOutput;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {

        long returnCode = -1;
        long RowID = -1;
        string SampleID = "";
        string ScheduleTime = "";
        string TestingAddress = "";
        string CollectionPerson = "";
        List<SampleSchedule> UpdateList = new List<SampleSchedule>();
        int rowa = grdquoDetails.Rows.Count;

        foreach (GridViewRow grdRows in grdquoDetails.Rows)
        {
            SampleSchedule SampleScheduleEntity = new SampleSchedule();

            string QuotationNo = ((LinkButton)grdRows.FindControl("lblQuotationNo")).Text.ToString();
            String OriginalStatus = ((Label)grdRows.FindControl("SampleOriginalStatus")).Text.ToString();
            DropDownList ddlSelectedStatus = (DropDownList)grdRows.FindControl("drpstatus");

            string SampleStatus = ddlSelectedStatus.SelectedItem.Text.ToString();



            if (SampleStatus != OriginalStatus)
            {


                SampleScheduleEntity.QuotationNO = QuotationNo;
                SampleScheduleEntity.Status = SampleStatus;

                UpdateList.Add(SampleScheduleEntity);

            }



        }

        if (UpdateList.Count > 0)
        {
            Waters_BL objBL = new Waters_BL(base.ContextInfo);
            string save_mesge = Resources.Waters_AppMsg.Waters_QuotationMaster_aspx_26;
            returnCode = objBL.UpdateQuotationApproval_Bulk(UpdateList);

            //  loadsampleschedulepage(Convert.ToInt32(hdnCurrent.Value), Convert.ToInt32(lblTotal.Text));
            //  LoadSampleSchedule();
            SetCtlValuesForSearch();
            GetQuotationForApproval();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Quotation Number has been updated successfully", "alert('" + save_mesge + "');", true);
        }
    }


    protected void grdSampleForApproval_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //  BillSearch bs = (BillSearch)e.Row.DataItem;


                string QuotationID = ((LinkButton)e.Row.FindControl("lblQuotationNo")).Text.ToString();
               
                string SampleOriginalStatus = ((Label)e.Row.FindControl("SampleOriginalStatus")).Text;

                DropDownList ddlSampleStatus = ((DropDownList)e.Row.FindControl("drpstatus"));


                ddlSampleStatus.SelectedIndex = ddlSampleStatus.Items.IndexOf(ddlSampleStatus.Items.FindByValue(SampleOriginalStatus));
                //CollectionPerson.SelectedItem.Value=Convert.ToInt32(AllotedCollector);

                if (ddlSampleStatus.SelectedItem.Value == "Approved" || ddlSampleStatus.SelectedItem.Value == "Expired")
                {
                    ddlSampleStatus.Enabled = false;
                }



                if (ddlSampleStatus.SelectedItem.Value == "Pending" || ddlSampleStatus.SelectedItem.Value == "Rejected")
                {
                    ddlSampleStatus.Items.Remove("Expired");
                }

                if (ddlSampleStatus.SelectedItem.Value == "Rejected")
                {
                    ddlSampleStatus.Items.Remove("Pending");
                    ddlSampleStatus.Items.Remove("Approved");
                
                }


            }

        }
        catch (Exception Ex)
        {
            //report error
        }
    }

    protected void ShowQuotation(Object sender, EventArgs e)
    {
        try
        {

            GridViewRow grdrow = (GridViewRow)((LinkButton)sender).NamingContainer;
            HiddenField Quotationid = grdrow.FindControl("hdnQuotationId") as HiddenField;
            //string sPage12 = string.Empty;
            long QuotationID = Convert.ToInt64(Quotationid.Value);
            //sPage12 = "../Waters/QuotationFormat.aspx?Qid=" + QuotationID.ToString()
            //                 + "&OrgID=" + OrgID + "&IsPopup=Y" + "&RedirectPage=../Waters/QuotationMaster.aspx";

            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:OpenBillPrint('" + sPage12 + "');", true);


            long loginID = Convert.ToInt64(LID);
            int AddressID = Convert.ToInt32(ILocationID);

            //long visitID, int pOrgid, long loginID, int AddressID
            ShowBill(QuotationID, OrgID, loginID, AddressID);
            ModalPopupExtenderBill.Show();
        }
        catch (Exception Ex)
        {
            //report error
        }
    }












    protected void btnConverttoXL_Click(object sender, ImageClickEventArgs e)
    {
        ExportToExcel_1();
    }




    protected void ExportToExcel_1()
    {




        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=QuotationDetails.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";


        Master_BL masterbl = new Master_BL(base.ContextInfo);
        List<ClientMaster> lstinvmasters = new List<ClientMaster>();
        lstinvmasters.Clear();
        long returncode = -1;
        Waters_BL ObjBL = new Waters_BL(base.ContextInfo);
        //uy t  btnFinish.Text = UpdateButton;
        long ClientID = 0;
        //ClientID = clientid;
        List<SampleSchedule> lstSampleForApprovel = new List<SampleSchedule>();
        SetCtlValuesForSearch();
        int NumberofRows;

        ObjBL.GetQuotationForApproval(OrgID, Fromdate, Todate, QuotationNo, ClientName, SampleType, SalesPerson, SampStatus, out NumberofRows, out lstSampleForApprovel);
        //   returncode = ObjBL.GetSampleSchedule(Fromdate, Todate, QuotationNo, ClientID, TestID, SampleType, SamColPerson, SampStatus, 10, currentPageNo, PageSize, out totalRows, out lstOSampleSchedule);
        //     returncode = masterbl.GetInvoiceClientDetails(OrgID, ILocationID, txtClientNameSrch.Text, txtClientCodeSrch.Text, ClientID, out lstinvmasters);
        if (lstSampleForApprovel.Count > 0)
        {
            //DataTable table = ConvertListToDataTable(lstinvmasters);
            grdquoDetails.DataSource = lstSampleForApprovel;
            grdquoDetails.AllowPaging = false;
            grdquoDetails.DataBind();

        }


        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            //To Export all pages
            grdquoDetails.AllowPaging = false;
            //   this.BindGrid();

            grdquoDetails.HeaderRow.BackColor = Color.White;
            foreach (TableCell cell in grdquoDetails.HeaderRow.Cells)
            {
                cell.BackColor = grdquoDetails.HeaderStyle.BackColor;
            }
            foreach (GridViewRow row in grdquoDetails.Rows)
            {
                row.BackColor = Color.White;
                foreach (TableCell cell in row.Cells)
                {
                    if (row.RowIndex % 2 == 0)
                    {
                        cell.BackColor = grdquoDetails.AlternatingRowStyle.BackColor;
                    }
                    else
                    {
                        cell.BackColor = grdquoDetails.RowStyle.BackColor;
                    }
                    cell.CssClass = "textmode";
                    List<Control> controls = new List<Control>();

                    //Add controls to be removed to Generic List
                    foreach (Control control in cell.Controls)
                    {
                        controls.Add(control);
                    }

                    //Loop through the controls to be removed and replace then with Literal
                    foreach (Control control in controls)
                    {
                        switch (control.GetType().Name)
                        {
                            case "HyperLink":
                                cell.Controls.Add(new Literal { Text = (control as HyperLink).Text });
                                break;
                            case "Label":
                                cell.Controls.Add(new Literal { Text = (control as Label).Text });
                                break;

                            case "TextBox":
                                cell.Controls.Add(new Literal { Text = (control as TextBox).Text });
                                break;
                            case "LinkButton":
                                cell.Controls.Add(new Literal { Text = (control as LinkButton).Text });
                                break;
                            case "CheckBox":
                                cell.Controls.Add(new Literal { Text = (control as CheckBox).Text });
                                break;
                            case "RadioButton":
                                cell.Controls.Add(new Literal { Text = (control as RadioButton).Text });
                                break;
                        }
                        cell.Controls.Remove(control);
                    }
                }
            }

            grdquoDetails.RenderControl(hw);

            //style to format numbers to string
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtFrom.Text = "";
        txtTo.Text = "";
        txtquotationno.Text = "";
        txtclientname.Text = "";
        txtSampType.Text = "";
        txtSalesPerson.Text = "";
        grdquoDetails.Visible = false;
        btnClear.Visible = false;
        btnSave.Visible = false;
        lblNumberofrecrdFetched.Visible = false;
        lblNumberofRecords.Visible = false;
    }

    class MyReportServerCredent : IReportServerCredentials
    {
        string CredentialuserName = System.Configuration.ConfigurationManager.AppSettings["ReportUserName"];
        string CredentialpassWord = System.Configuration.ConfigurationManager.AppSettings["ReportPassword"];

        public MyReportServerCredent()
        {
        }

        public System.Security.Principal.WindowsIdentity ImpersonationUser
        {
            get
            {
                return null;  // Use default identity.
            }
        }

        public System.Net.ICredentials NetworkCredentials
        {
            get
            {
                return new System.Net.NetworkCredential(CredentialuserName, CredentialpassWord);
            }
        }

        public bool GetFormsCredentials(out System.Net.Cookie authCookie,
                out string user, out string password, out string authority)
        {
            authCookie = null;
            user = password = authority = null;
            return false;  // Not use forms credentials to authenticate.
        }
    }

    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID,
            out lstConfig);
            if (lstConfig.Count >= 0)
                strConfigValue = lstConfig[0].ConfigValue;
            //else
            //    CLogger.LogWarning("InValid " + strConfigKey);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }

    public void ShowBill(long visitID, int pOrgid, long loginID, int AddressID)
    {
        try
        {

            rReportViewer.Visible = false;
            int PatientId = -1;
            rReportViewer.Visible = true;
            rReportViewer.Attributes.Add("style", "width:100%; height:484px");
            string strURL = string.Empty;
            string connectionString = "";
            connectionString = Utilities.GetConnectionString();
            rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            //rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            strURL = GetConfigValues("ReportServerURL", OrgID);
            rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            rReportViewer.ServerReport.ReportPath = GetConfigValue("WatersReportPath", OrgID); 
            rReportViewer.ShowParameterPrompts = false;
            {
                rReportViewer.ShowPrintButton = true;
            }



            connectionString = Utilities.GetConnectionString();

            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[5];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("pOrgID", Convert.ToString(pOrgid));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("OrgAddressID", Convert.ToString(AddressID));
            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("pLoginID", Convert.ToString(loginID));
            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
            //reportParameterList[5] = new Microsoft.Reporting.WebForms.ReportParameter("ShowReportHeader", "Y");
            //reportParameterList[6] = new Microsoft.Reporting.WebForms.ReportParameter("ShowReportFooter", "Y");
            //reportParameterList[7] = new Microsoft.Reporting.WebForms.ReportParameter("IsServiceRequest", "N");
            ReportParameterInfoCollection lstReportParameterCollection = rReportViewer.ServerReport.GetParameters();

            List<Microsoft.Reporting.WebForms.ReportParameter> lstParameter = (from RPC in lstReportParameterCollection
                                                                               join RP in reportParameterList on RPC.Name equals RP.Name
                                                                               select RP).ToList();

            //rReportViewer.ServerReport.SetParameters(lstParameter);
            rReportViewer.ServerReport.SetParameters(reportParameterList);
            // rReportViewer.AsyncRendering = false;
            //rReportViewer.ServerReport.Refresh();
            rReportViewer.Visible = true;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
    }
}
