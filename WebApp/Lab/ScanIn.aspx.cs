using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using System.Data;
using System.Web.Services;
using System.Reflection;
using Attune.Podium.PerformingNextAction;
using System.Text.RegularExpressions;

public partial class Lab_ScanIn : BasePage
{
    int deptId = 0;
    int SampleTypeId = 0;
    bool RejectSample = true;
    List<List<SampleBatchScanOutDetails>> objscanoutAllDetails = null;
    DataTable dt = new DataTable();
    DataTable dtNewTable = new DataTable();
    public Lab_ScanIn()
        : base("Lab_ScanIn_aspx")
    {
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        string confirmValue = hdnActionName.Value;
        if (!string.IsNullOrEmpty(confirmValue) && !confirmValue.Equals("--Select--"))
        {
            dReason.Attributes.Remove("style");
            dReason.Style.Add("display", "none");
        }

        if (!IsPostBack)
        {
            LoadDepartement();
            loadprinter();
            loadSampleType();
            LoadReasons();
        }
        else
        {
            int i = 10;
            ViewState["SampleEnquiery"] = 0;
        }
        // scanoutall = new List<ScanOutDetails>();
        //  ViewState["scanoutall"] = null;
    }
    //List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    //List<Speciality> lstSpeciality = new List<Speciality>();
    //List<TaskActions> lstCategory = new List<TaskActions>();
    //List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
    //List<ClientMaster> lstClient = new List<ClientMaster>();
    //List<MetaData> lstProtocal = new List<MetaData>();
    //TaskProfile taskProfile = new TaskProfile();
    bool isScondaryBarcode;
    private void LoadDepartement()
    {
        ddlDepartment.Items.Clear();
        List<InvDeptMaster> ObjInvDep = new List<InvDeptMaster>();
        List<InvestigationHeader> objHeader = new List<InvestigationHeader>();
        Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
        long returnCode = -1;

        returnCode = investigationBL.getOrgDepartHeadName(OrgID, out ObjInvDep, out objHeader);

        try
        {
            if (ObjInvDep.Count > 0)
            {
                ddlDepartment.DataTextField = "DeptName";
                ddlDepartment.DataValueField = "AutoScanIn";
                ddlDepartment.DataSource = ObjInvDep;
                ddlDepartment.DataBind();
            }
            ddlDepartment.Items.Insert(0, "--Select--");
            ddlDepartment.Items[0].Value = "-1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading departments", ex);
        }
    }

    public void LoadReasons()
    {
        try
        {
            long returnCode;
            List<InvReasonMasters> lstInvReasonMaster = new List<InvReasonMasters>();
            returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(OrgID, out lstInvReasonMaster);

            //lstInvReasonMaster.RemoveAll(P => P.StatusID != 4);
            //lstInvReasonMaster = lstInvReasonMaster.FindAll(P => P.ReasonTypeCode == "SREJ" || P.ReasonTypeCode == "PS");
            ddlReason.DataSource = lstInvReasonMaster;
            ddlReason.DataTextField = "ReasonDesc";
            ddlReason.DataValueField = "ReasonID";
            ddlReason.DataBind();


            ddlReason.Items.Insert(0, new ListItem("--Select--".Trim(), "0"));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Sample Enquiery page at Load reason method", ex);
        }
    }

    public void loadprinter()
    {

        long returncode = -1;
        string PrinterType = "BarCodePrinter";
        //Referrals_BL referralsbl = new Referrals_BL(base.ContextInfo);
        List<LocationPrintMap> scanEnquiry = new List<LocationPrintMap>();
        //returncode = referralsbl.GetLocationPrinter(OrgID, ILocationID, PrinterType, out scanEnquiry);
        Users_BL usersbl = new Users_BL(base.ContextInfo);
        returncode = usersbl.LoadPrinterNameAndPath(OrgID, out scanEnquiry);
        if (scanEnquiry.Count > 0)
        {
            ddlPrinters.DataTextField = "Name";
            ddlPrinters.DataValueField = "AutoID";
            ddlPrinters.DataSource = scanEnquiry;
            ddlPrinters.DataBind();
        }
        ddlPrinters.Items.Insert(0, "--Select--");
        ddlPrinters.Items[0].Value = "-1";

    }

    public void loadSampleType()
    {
        try
        {
            long returncode = -1;
            Investigation_BL objInvestigationBL = new Investigation_BL(base.ContextInfo);
            List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
            returncode = objInvestigationBL.GetInvSampleMaster(OrgID, out lstInvSampleMaster);

            if (lstInvSampleMaster.Count > 0)
            {
                ddlSampleType.DataTextField = "SampleDesc";
                ddlSampleType.DataValueField = "SampleCode";
                ddlSampleType.DataSource = lstInvSampleMaster;
                ddlSampleType.DataBind();
            }
            ddlSampleType.Items.Insert(0, "--Select--");
            ddlSampleType.Items[0].Value = "-1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Sample Enquiery page at loadSampleType method", ex);
        }
    }

    //public void GetBarcodePrint(object sender, EventArgs e)
    //{

    //    if (chkBox.Checked == true)
    //    {
    //        string barcode = string.Empty;
    //        string VisitID = string.Empty;
    //        string SampleID = string.Empty;
    //        int OrgID = 0;
    //        PrintBarcode objPrintBarcode;
    //        List<PrintBarcode> lstPrintBarcode = new List<PrintBarcode>();
    //        string MachineID = string.Empty;
    //        if (HttpContext.Current.Session["MacAddress"] != null)
    //        {
    //            MachineID = (string)HttpContext.Current.Session["MacAddress"];
    //        }
    //        BarcodeHelper objBarcodeHelper = new BarcodeHelper();
    //        List<BarcodeAttributes> lstBarcodeAttributes = new List<BarcodeAttributes>();
    //        // OrgID = Convert.ToInt32(hdnOrgIDSR.Value);
    //        OrgID = Convert.ToInt32(this.OrgID);
    //        VisitID = hdnVisitIDSR.Value;
    //        SampleID = hdnSampleIDSR.Value;
    //        string[] visitarr = VisitID.Split(',');
    //        string[] samplearr = SampleID.Split(',');
    //        //  VisitID = "30806,30805";
    //        // barcode = "0001640";
    //        // barcode = hdnSampleIDSR.Value;
    //        for (int i = 0; i < visitarr.Length - 1; i++)
    //        {
    //            string v1 = visitarr[i].ToString();
    //            string s1 = samplearr[i].ToString();
    //            objBarcodeHelper.GetBarcodeQueryString(OrgID, v1, s1, 0, "ContainerRg", out lstBarcodeAttributes);


    //            if (lstBarcodeAttributes.Count > 0)
    //            {
    //                foreach (BarcodeAttributes objBarcodeAttributes in lstBarcodeAttributes)
    //                {
    //                    objPrintBarcode = new PrintBarcode();
    //                    objPrintBarcode.VisitID = objBarcodeAttributes.VisitID;
    //                    objPrintBarcode.SampleID = objBarcodeAttributes.SampleID;
    //                    objPrintBarcode.BarcodeNumber = objBarcodeAttributes.BarcodeNumber;
    //                    objPrintBarcode.MachineID = MachineID;
    //                    objPrintBarcode.HeaderLine1 = objBarcodeAttributes.HeaderLine1;
    //                    objPrintBarcode.HeaderLine2 = objBarcodeAttributes.HeaderLine2;
    //                    objPrintBarcode.FooterLine1 = objBarcodeAttributes.FooterLine1;
    //                    objPrintBarcode.FooterLine2 = objBarcodeAttributes.FooterLine2;
    //                    lstPrintBarcode.Add(objPrintBarcode);
    //                }
    //            }
    //        }
    //        if (lstPrintBarcode.Count > 0)
    //        {
    //            //if (Session["RegKeyExists"] != null && Convert.ToString(Session["RegKeyExists"]) == "true")
    //            //{

    //            foreach (PrintBarcode oPrintBarcode in lstPrintBarcode)
    //            {
    //                if (barcode == string.Empty)
    //                {
    //                    barcode = oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
    //                }
    //                else
    //                {
    //                    barcode = barcode + "?" + oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
    //                }
    //            }

    //        }


    //        if (barcode != string.Empty)
    //        {
    //            // CLogger.LogInfo("RePrint Barcode :   " + barcode);
    //            iframeBarcode.Attributes["src"] = "attunebarcode:" + barcode;
    //        }
    //        else
    //        {

    //        }
    //        lstPrintBarcode.Clear();
    //    }

    //    hdnVisitIDSR.Value = "";
    //    hdnSampleIDSR.Value = "";
    //    //CheckBox1.Checked = false;
    //    chkBox.Checked = false;
    //    txtBarcodeSample.Text = "";
    //    // txtBatchNo.Text = "";
    //    ddlDepartment.SelectedIndex = 0;

    //}

    //[WebMethod]
    //public static string GetBarcodePrint(int OrgID, string strPatientVisitId, string strSampleId, string barcodeType, string CategoryCode)
    //{

    //    string barcode = string.Empty;
    //    PrintBarcode objPrintBarcode;
    //    List<PrintBarcode> lstPrintBarcode = new List<PrintBarcode>();
    //    string MachineID = string.Empty;
    //    if (HttpContext.Current.Session["MacAddress"] != null)
    //    {
    //        MachineID = (string)HttpContext.Current.Session["MacAddress"];
    //    }
    //    BarcodeHelper objBarcodeHelper = new BarcodeHelper();
    //    List<BarcodeAttributes> lstBarcodeAttributes = new List<BarcodeAttributes>();
    //    objBarcodeHelper.GetBarcodeQueryString(OrgID, strPatientVisitId, strSampleId, 0, CategoryCode, out lstBarcodeAttributes);


    //    if (lstBarcodeAttributes.Count > 0)
    //    {
    //        foreach (BarcodeAttributes objBarcodeAttributes in lstBarcodeAttributes)
    //        {
    //            objPrintBarcode = new PrintBarcode();
    //            objPrintBarcode.VisitID = objBarcodeAttributes.VisitID;
    //            objPrintBarcode.SampleID = objBarcodeAttributes.SampleID;
    //            objPrintBarcode.BarcodeNumber = objBarcodeAttributes.BarcodeNumber;
    //            objPrintBarcode.MachineID = MachineID;
    //            objPrintBarcode.HeaderLine1 = objBarcodeAttributes.HeaderLine1;
    //            objPrintBarcode.HeaderLine2 = objBarcodeAttributes.HeaderLine2;
    //            objPrintBarcode.FooterLine1 = objBarcodeAttributes.FooterLine1;
    //            objPrintBarcode.FooterLine2 = objBarcodeAttributes.FooterLine2;
    //            lstPrintBarcode.Add(objPrintBarcode);
    //        }
    //    }
    //    if (lstPrintBarcode.Count > 0)
    //    {
    //        //if (Session["RegKeyExists"] != null && Convert.ToString(Session["RegKeyExists"]) == "true")
    //        //{

    //        foreach (PrintBarcode oPrintBarcode in lstPrintBarcode)
    //        {
    //            if (barcode == string.Empty)
    //            {
    //                barcode = oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
    //            }
    //            else
    //            {
    //                barcode = barcode + "?" + oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
    //            }
    //        }

    //    }
    //    return barcode;
    //}

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        ddlAction.SelectedIndex = -1;
        ddlBarcodeType.SelectedIndex = -1;
        ddlReason.SelectedIndex = -1;
        HdnSampleEnquiryCheckBoxId.Value = "";
        grouptab.ActiveTabIndex = 0;
        FetchScanInDetails();
    }



    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.RowIndex);
                e.Row.Attributes["style"] = "cursor:pointer";

                TableCell statusCell = e.Row.Cells[12];
                if (statusCell.Text == DateTime.MinValue.ToString() || statusCell.Text == DateTime.MaxValue.ToString())
                {
                    statusCell.Text = string.Empty;
                }
                TableCell tatcell = e.Row.Cells[12];
                if (tatcell.Text == DateTime.MinValue.ToString() || tatcell.Text == DateTime.MaxValue.ToString())
                {
                    tatcell.Text = string.Empty;
                }


                //e.Row.Attributes.Add("onclick", string.Format("ChangeRowColor('{0}','{1}');", e.Row.ClientID, e.Row.RowIndex));  

                HiddenField s = (HiddenField)e.Row.FindControl("hdIsSecondaryBarcode");
                isScondaryBarcode = Convert.ToBoolean(s.Value); ;

                if (GridView1.DataSource != null)
                {
                    if (isScondaryBarcode)
                    {
                        CheckBox chkisdefault = (CheckBox)e.Row.FindControl("chkSecondaryBarcode");
                        if (chkisdefault != null)
                            chkisdefault.Checked = true;
                    }
                    isScondaryBarcode = false;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Scan In View at GridView1_RowDataBound. ", ex);
        }
    }



    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlAction.SelectedIndex = -1;
        ddlReason.SelectedIndex = -1;
        FetchSampleDetails();
        FetchSampleTrackingDetails();

        grouptab.ActiveTabIndex = 0;
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:highlite('" + GridView1.SelectedIndex + "');", true);
    }



    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //DataTable dt = new DataTable();
        //try
        //{
        //    if (e.NewPageIndex != null)
        //    {
        //        GridView1.PageIndex = e.NewPageIndex;
        //        dt = (DataTable)ViewState["ScanedIn"];
        //        dt.DefaultView.Sort = "ReceivedTime" + " " + "DESC";
        //        GridView1.DataSource = dt;
        //        GridView1.DataBind();
        //        //FetchScanInDetails();
        //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:highlite();", true);

        //    }
        //}
        //catch (Exception ex)
        //{
        //    GridView1.PageIndex = 0;
        //    CLogger.LogError("Error in Scan In View at GridView1_PageIndexChanging", ex);
        //}
    }

    private void FetchScanInDetails()
    {
        try
        {
            DataTable dts = new DataTable();
            string labnumber = string.Empty;
            GridView1.DataSource = null;
            GridView1.DataBind();
            long result = -1;
            deptId = Convert.ToInt32(ddlDepartment.SelectedValue.Split('~')[0]);
            SampleTypeId = Convert.ToInt32(ddlSampleType.SelectedValue);
            List<SampleBatchScanOutDetails> ScanIndept = new List<SampleBatchScanOutDetails>();
            string Barcode = txtBarcodeSample.Text.Trim();
            List<SampleBatchScanOutDetails> objscanout = null;
            string ReturnValue = string.Empty;
            Master_BL masterBL = new Master_BL(new BaseClass().ContextInfo);
            result = masterBL.pgetScanIn(deptId, Barcode, SampleTypeId, out objscanout,out ReturnValue);
            if (objscanout.Count > 0)
            {
                if (ViewState["ScanedIn"] == null)
                {
                    dt = ToDataTable(objscanout);
                    ViewState["ScanedIn"] = dt;
                }
                else
                {
                    dt = (DataTable)ViewState["ScanedIn"];
                    foreach (var item in objscanout)
                    {
                        var query = dt.AsEnumerable().Where(r => r.Field<string>("BarcodeNumber") == item.BarcodeNumber && r.Field<string>("LabNumber") == item.LabNumber);
                        foreach (var row in query.ToList())
                        {
                            row.Delete();
                            dt.AcceptChanges();
                        }
                    }
                    dt.Merge(ToDataTable(objscanout), false, MissingSchemaAction.Ignore);
                    ViewState["ScanedIn"] = dt;
                }

                DataView dv = new DataView(dt);
                if (ddlBarcodeType.SelectedIndex != 0)
                {
                    string Filter = "IsSecBarCode=" + (ddlBarcodeType.SelectedIndex == 1 ? "False" : "True");
                    dv.RowFilter = Filter;
                    if (dv != null)
                    {
                        dt = null;
                        dt = dv.ToTable();
                    }
                }

                gv.Style.Add("display", "block");
                dt.DefaultView.Sort = "ReceivedTime" + " " + "DESC";
                GridView1.DataSource = dt;
                GridView1.DataBind();
                updatePanel1.Update();
                GridView1.Visible = true;
                divAction.Style.Add("display", "block");
                ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "hidegrid()", true);
            }
            else if (dt != null && dt.Rows.Count == 0 && objscanout.Count == 0)
            {
                if (dt != null && dt.Rows.Count == 0 && objscanout.Count == 0 && RejectSample)
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + "Sample(s) is not available / Sample type is mismatch / Scanned in department." + "','Alert');", true);
                dt = (DataTable)ViewState["ScanedIn"];
                if (dt != null && dt.Rows.Count > 0)
                {
                    dt.DefaultView.Sort = "ReceivedTime" + " " + "DESC";
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    updatePanel1.Update();
                    divAction.Style.Add("display", "block");
                }
                ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "hidegrid()", true);
            }
            else if (dt != null && objscanout.Count == 0)
            {
                dt = (DataTable)ViewState["ScanedIn"];
                if (dt != null && dt.Rows.Count > 0 && objscanout.Count == 0 && RejectSample)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + "Sample(s) is not available / Sample type is mismatch / Scanned in department." + "','Alert');", true);
                }
                if (dt != null && dt.Rows.Count > 0)
                {
                    dt.DefaultView.Sort = "ReceivedTime" + " " + "DESC";
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    updatePanel1.Update();
                    divAction.Style.Add("display", "block");
                }
                ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "hidegrid()", true);
            }


            else
            {
                //gv.Style.Add("display", "none");
                dt = (DataTable)ViewState["ScanedIn"];
                if (dt != null && dt.Rows.Count > 0)
                {
                    dt.DefaultView.Sort = "ReceivedTime" + " " + "DESC";
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    updatePanel1.Update();
                    //if (dt != null)
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + "Sample(s) is not available / Sample type is mismatch / Scanned in department." + "','Alert');", true);
                    divAction.Style.Add("display", "block");
                }

                ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "hidegrid()", true);
            }
            txtBarcodeSample.Text = string.Empty;
        }
        catch (Exception ex)
        {
            txtBarcodeSample.Text = string.Empty;
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "hidegrid()", true);
            CLogger.LogError("Error in FetchScanInDetails method", ex);
        }
    }

    public DataTable ToDataTable<T>(List<T> items)
    {
        DataTable dataTable = new DataTable(typeof(T).Name);
        try
        {
            //Get all the properties by using reflection   
            PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                //Setting column names as Property names  
                dataTable.Columns.Add(prop.Name);
            }
            foreach (T item in items)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {

                    values[i] = Props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ToDataTable method", ex);
        }
        return dataTable;
    }

    private void FetchSampleDetails()
    {
        try
        {
            if (GridView1.SelectedRow != null)
            {

                //deptId = Convert.ToInt32(((HiddenField)GridView1.SelectedRow.Cells[0].FindControl("hfDepartmentId")).Value.ToString());
                string Barcode = ((HiddenField)GridView1.SelectedRow.Cells[0].FindControl("hfBarcodenumber")).Value.ToString();
                if (!string.IsNullOrEmpty(Barcode))
                {
                    List<PatientInvSample> objscanout = null;
                    Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
                    masterbl.GetSampleDetails(Barcode, deptId, out objscanout);
                    if (objscanout.Count > 0)
                    {
                        GridView2.DataSource = objscanout;
                        GridView2.DataBind();
                        GridView2.Style.Remove("display");
                        deptId = 0;
                    }
                    else
                    {
                        GridView2.Style.Add("display", "none");
                        deptId = 0;
                    }
                }
                else
                {
                    GridView2.Style.Add("display", "none");
                    deptId = 0;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Scan In View at FetchSampleDetails", ex);
        }
    }

    private void FetchSampleTrackingDetails()
    {
        try
        {
            if (GridView1.SelectedRow != null)
            {

                //deptId = Convert.ToInt32(((HiddenField)GridView1.SelectedRow.Cells[0].FindControl("hfDepartmentId")).Value.ToString());
                string Barcode = ((HiddenField)GridView1.SelectedRow.Cells[0].FindControl("hfBarcodenumber")).Value.ToString();
                if (!string.IsNullOrEmpty(Barcode))
                {
                    List<SampleBatchScanOutDetails> objscanout = null;
                    Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
                    masterbl.SRATrackingDetails(Barcode, deptId, out objscanout);
                    if (objscanout.Count > 0)
                    {
                        GridView3.DataSource = objscanout;
                        GridView3.DataBind();
                        GridView3.Style.Remove("display");
                        deptId = 0;
                    }
                    else
                    {
                        GridView3.Style.Add("display", "none");
                        deptId = 0;
                    }
                }
                else
                {
                    GridView3.Style.Add("display", "none");
                    deptId = 0;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Scan In View at FetchSampleTrackingDetails", ex);
        }
    }
    protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != null)
            {
                GridView2.PageIndex = e.NewPageIndex;
                FetchSampleDetails();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:highlite('"+GridView1.SelectedIndex+"');", true);

            }
        }
        catch (Exception ex)
        {
            GridView2.PageIndex = 0;
            CLogger.LogError("Error in Scan In View at GridView2_PageIndexChanging", ex);
        }
    }

    protected void GridView3_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != null)
            {
                GridView3.PageIndex = e.NewPageIndex;
                FetchSampleTrackingDetails();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:highlite('"+GridView1.SelectedIndex+"');", true);
            }
        }
        catch (Exception ex)
        {
            GridView3.PageIndex = 0;
            CLogger.LogError("Error in Scan In View at GridView3_PageIndexChanging", ex);
        }
    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell tatcell = e.Row.Cells[1];
                if (tatcell.Text == DateTime.MinValue.ToString())
                {
                    tatcell.Text = string.Empty;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Scan In page at GridView2_RowDataBound", ex);
        }
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        int flag = 0;
        SampleDetail.Attributes.Add("style", "display:none");
        long returncode = -1;
        string strSampleId = string.Empty;
        string strPatientVisitId = string.Empty;
        List<string> moresampleid = new List<string>();
        List<BarcodeAttributes> lstBarcodeAttributes;
        //List<BarcodeAttributes> lstBarcodeAttributesTRF;
        List<PrintBarcode> lstPrintBarcode = new List<PrintBarcode>();
        BarcodeHelper objBarcodeHelper = new BarcodeHelper();
        PrintBarcode objPrintBarcode;
        int IndexPrinter = ddlPrinters.SelectedIndex;
        string ValPrinter = ddlPrinters.SelectedItem.Text.ToString();

        int isFirstTime = ViewState["count"] != null ? (int)ViewState["count"] : 0;

        try
        {
            foreach (GridViewRow item in GridView1.Rows)
            {
                CheckBox chkboxHeader = (CheckBox)item.FindControl("chkAll");
                CheckBox ChkbxSelect = (CheckBox)item.FindControl("chkPrint");
                if (ChkbxSelect.Checked)
                {
                    HiddenField hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                    HiddenField hfLabNumber = (HiddenField)item.FindControl("hdnLabNumber");
                    HiddenField hfBarcodeNumber = (HiddenField)item.FindControl("hdnBarcodeNumber");
                    //HiddenField hfDeptName = (HiddenField)item.FindControl("hdnDeptName");
                    HiddenField hfPatientRegisterdType = (HiddenField)item.FindControl("hdnPatientRegisterdType");
                    HiddenField hfScanCount = (HiddenField)item.FindControl("hdnScanCount");
                    HiddenField hfReceivedTime = (HiddenField)item.FindControl("hdnReceivedTime");
                    HiddenField hfSampleStatus = (HiddenField)item.FindControl("hdnSampleStatus");
                    HiddenField hfCollectionCenter = (HiddenField)item.FindControl("hdnCollectionCenter");
                    HiddenField hfReportDateTime = (HiddenField)item.FindControl("hdnReportDateTime");

                    //needs to be uncommented

                    HiddenField hfinvSampleid = (HiddenField)item.FindControl("hdnSampleid");
                    strSampleId = hfinvSampleid.Value;
                    strPatientVisitId = hfVisitId.Value;





                    if (!String.IsNullOrEmpty(strSampleId) && strSampleId.Length > 0)
                    {
                        flag = flag + 1;
                        moresampleid.Add(strSampleId);
                        if (flag > 0)
                        {
                            strSampleId = String.Join(",", moresampleid.ToArray());
                        }
                    }
                    string barcodeType = BarcodeCategory.ContainerRegular;
                    objBarcodeHelper.GetBarcodeQueryString(OrgID, strPatientVisitId, strSampleId, 0, barcodeType, out lstBarcodeAttributes);
                    if (lstBarcodeAttributes.Count > 0)
                    {
                        foreach (BarcodeAttributes objBarcodeAttributes in lstBarcodeAttributes)
                        {
                            objPrintBarcode = new PrintBarcode();
                            objPrintBarcode.VisitID = objBarcodeAttributes.VisitID;
                            objPrintBarcode.SampleID = objBarcodeAttributes.SampleID;
                            objPrintBarcode.BarcodeNumber = objBarcodeAttributes.BarcodeNumber;
                            // objPrintBarcode.MachineID = MachineID;
                            objPrintBarcode.HeaderLine1 = objBarcodeAttributes.HeaderLine1;
                            objPrintBarcode.HeaderLine2 = objBarcodeAttributes.HeaderLine2;
                            objPrintBarcode.FooterLine1 = objBarcodeAttributes.FooterLine1;
                            objPrintBarcode.FooterLine2 = objBarcodeAttributes.FooterLine2;
                            objPrintBarcode.RightHeaderLine1 = objBarcodeAttributes.RightHeaderLine1;
                            objPrintBarcode.RightHeaderLine2 = objBarcodeAttributes.RightHeaderLine2;
                            objPrintBarcode.RightHeaderLine3 = objBarcodeAttributes.RightHeaderLine3;
                            objPrintBarcode.RightHeaderLine4 = objBarcodeAttributes.RightHeaderLine4;
                            objPrintBarcode.RightHeaderLine5 = objBarcodeAttributes.RightHeaderLine5;
                            objPrintBarcode.RightHeaderLine6 = objBarcodeAttributes.RightHeaderLine6;
                            objPrintBarcode.RightHeaderLine7 = objBarcodeAttributes.RightHeaderLine7;


                            // objPrintBarcode.PrinterName = ddlPrinters.SelectedItem.Text.ToString();

                            objPrintBarcode.PrinterName = Convert.ToString(ddlPrinters.SelectedValue);
                            if (objPrintBarcode.PrinterName == "-1")
                                objPrintBarcode.PrinterName = "0";
                            //objPrintBarcode.PrinterName = objBarcodeAttributes.PrinterName;

                            lstPrintBarcode.Add(objPrintBarcode);
                        }
                    }


                }
                else
                {
                    if (isFirstTime == 0)
                    {
                        dt = (DataTable)ViewState["ScanedIn"];
                        dt.DefaultView.Sort = "ReceivedTime" + " " + "ASC";
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }

                    HiddenField hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                    HiddenField hfLabNumber = (HiddenField)item.FindControl("hdnLabNumber");
                    HiddenField hfBarcodeNumber = (HiddenField)item.FindControl("hdnBarcodeNumber");
                    //HiddenField hfDeptName = (HiddenField)item.FindControl("hdnDeptName");
                    HiddenField hfPatientRegisterdType = (HiddenField)item.FindControl("hdnPatientRegisterdType");
                    HiddenField hfScanCount = (HiddenField)item.FindControl("hdnScanCount");
                    HiddenField hfReceivedTime = (HiddenField)item.FindControl("hdnReceivedTime");
                    HiddenField hfSampleStatus = (HiddenField)item.FindControl("hdnSampleStatus");
                    HiddenField hfCollectionCenter = (HiddenField)item.FindControl("hdnCollectionCenter");
                    HiddenField hfReportDateTime = (HiddenField)item.FindControl("hdnReportDateTime");
                    HiddenField hfinvSampleid = (HiddenField)item.FindControl("hdnSampleid");
                    strSampleId = hfinvSampleid.Value;
                    strPatientVisitId = hfVisitId.Value;


                    if (!String.IsNullOrEmpty(strSampleId) && strSampleId.Length > 0)
                    {
                        flag = flag + 1;
                        moresampleid.Add(strSampleId);
                        if (flag > 0)
                        {
                            strSampleId = String.Join(",", moresampleid.ToArray());
                        }
                    }
                    string barcodeType = BarcodeCategory.ContainerRegular;
                    objBarcodeHelper.GetBarcodeQueryString(OrgID, strPatientVisitId, strSampleId, 0, barcodeType, out lstBarcodeAttributes);
                    if (lstBarcodeAttributes.Count > 0)
                    {
                        foreach (BarcodeAttributes objBarcodeAttributes in lstBarcodeAttributes)
                        {
                            objPrintBarcode = new PrintBarcode();
                            objPrintBarcode.VisitID = objBarcodeAttributes.VisitID;
                            objPrintBarcode.SampleID = objBarcodeAttributes.SampleID;
                            objPrintBarcode.BarcodeNumber = objBarcodeAttributes.BarcodeNumber;
                            // objPrintBarcode.MachineID = MachineID;
                            objPrintBarcode.HeaderLine1 = objBarcodeAttributes.HeaderLine1;
                            objPrintBarcode.HeaderLine2 = objBarcodeAttributes.HeaderLine2;
                            objPrintBarcode.FooterLine1 = objBarcodeAttributes.FooterLine1;
                            objPrintBarcode.FooterLine2 = objBarcodeAttributes.FooterLine2;
                            objPrintBarcode.RightHeaderLine1 = objBarcodeAttributes.RightHeaderLine1;
                            objPrintBarcode.RightHeaderLine2 = objBarcodeAttributes.RightHeaderLine2;
                            objPrintBarcode.RightHeaderLine3 = objBarcodeAttributes.RightHeaderLine3;
                            objPrintBarcode.RightHeaderLine4 = objBarcodeAttributes.RightHeaderLine4;
                            objPrintBarcode.RightHeaderLine5 = objBarcodeAttributes.RightHeaderLine5;
                            objPrintBarcode.RightHeaderLine6 = objBarcodeAttributes.RightHeaderLine6;
                            objPrintBarcode.RightHeaderLine7 = objBarcodeAttributes.RightHeaderLine7;


                            objPrintBarcode.PrinterName = Convert.ToString(ddlPrinters.SelectedValue);
                            if (objPrintBarcode.PrinterName == "-1")
                                objPrintBarcode.PrinterName = "0";
                            //objPrintBarcode.PrinterName = objBarcodeAttributes.PrinterName;

                            lstPrintBarcode.Add(objPrintBarcode);
                        }
                    }

                }

                isFirstTime = isFirstTime + 1;
                ViewState["count"] = isFirstTime;
            }
            if (lstPrintBarcode.Count > 0)
            {
                //string printername = ddlPrinters.SelectedItem.Text.ToString().Trim();
                GateWay objGateWay = new GateWay(base.ContextInfo);
                Int32 returnStatus = -1;
                returncode = objGateWay.SaveBarcodePrintDetails(lstPrintBarcode, out returnStatus);
                if (returncode > 0)
                {

                    ScriptManager.RegisterClientScriptBlock(updatePanel1, typeof(UpdatePanel), "", "alert('Print request sent successfully')", true);
                    SampleDetail.Style.Add("display", "block");
                    ddlPrinters.SelectedIndex = -1;
                    //LoadGrid();
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(updatePanel1, typeof(UpdatePanel), "", "alert('Unable to send Print request.')", true);
                    SampleDetail.Style.Add("display", "block");
                    ddlPrinters.SelectedIndex = -1;
                }
            }
            dt = (DataTable)ViewState["ScanedIn"];
            dt.DefaultView.Sort = "ReceivedTime" + " " + "DESC";
            GridView1.DataSource = dt;
            GridView1.DataBind();
            ViewState["count"] = 0;

        }
        catch (Exception ex)
        {
            ViewState["SampleEnquiery"] = 0;
            CLogger.LogError("Error while Printing action.", ex);
        }
    }
    string strSampleRejectedSuccess = "Sample is Rejected Successfully";
    string strSampleNotGivenSuccess = "Sample status Not given is changed Successfully";
    string strSampleAlredyRejected = "This Sample is already Rejected";
    string strSampleAlredyNotGiven = "This Sample is already in Not given status";
    string strSampleSentProcessing = "This Sample is already sent to processing, Unable to Reject!";
    string strSampleSentProcessingNotGiven = "This Sample is already sent to processing, Unable to change the status!";

    protected void btnOk_Click(object sender, EventArgs e)
    {
        try
        {
            PageContextDetails.ButtonName = ((Button)sender).ID;
            PageContextDetails.ButtonValue = ((Button)sender).Text;
            string samplestatus = ddlAction.SelectedItem.Text;
            string bulksample_print = null;
            BarcodeAttributes barcodeattribute = new BarcodeAttributes();
            // Panel1.Visible = true;
            //Panel2.Visible = true;
            string strPatientVisitId = string.Empty;
            string strSampleId = string.Empty;
            string strGuid = string.Empty;
            string strSampleStatusID = string.Empty;
            string strTaskID = string.Empty;
            string strAccessionNo = string.Empty;
            string strORDStatus = string.Empty;
            string Barcode_Number = string.Empty;
            string samples = string.Empty;


            //ShowAndHide();
            string SampleStatus = ddlAction.SelectedValue;

            List<PatientInvestigation> lstpatinv = new List<PatientInvestigation>();
            int flag = 0;
            List<string> moresampleid = new List<string>();
            foreach (GridViewRow item in GridView1.Rows)
            {
                CheckBox ChkbxSelect = (CheckBox)item.FindControl("chkPrint");
                if (ChkbxSelect.Checked)
                {
                    HiddenField hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                    HiddenField hfSampleId = (HiddenField)item.FindControl("hdnSampleId");
                    //HiddenField hfGuid = (HiddenField)item.FindControl("hdnGuid");
                    HiddenField hfSampleStatusId = (HiddenField)item.FindControl("hfSampleStatusId");
                    HiddenField hfTaskID = (HiddenField)item.FindControl("hdnTaskID");
                    HiddenField hfAccessionNo = (HiddenField)item.FindControl("hdnAccessionNo");
                    HiddenField hdnORDStatus = (HiddenField)item.FindControl("hdnSampleStatus");
                    HiddenField hdnBarcode = (HiddenField)item.FindControl("hdnBarcodeNumber");
                    //HiddenField hfsamplename = (HiddenField)item.FindControl("hdnSamplename");
                    //samples = hfsamplename.Value;
                    Barcode_Number = hdnBarcode.Value;
                    strPatientVisitId = hfVisitId.Value;
                    strSampleId = hfSampleId.Value;
                    if (!String.IsNullOrEmpty(strSampleId) && strSampleId.Length > 0)
                    {
                        flag = flag + 1;
                        moresampleid.Add(strSampleId);
                        if (flag > 0)
                        {
                            strSampleId = String.Join(",", moresampleid.ToArray());
                        }
                    }
                    //strGuid = hfGuid.Value;
                    strSampleStatusID = hfSampleStatusId.Value;
                    string NotGivenTaskClosed = GetConfigValue("IsNotGivenTaskClosed", OrgID);
                    if ((SampleStatus == InvSampleStatus.Not_Given.ToString() && NotGivenTaskClosed == "Y"))
                    {
                        strTaskID = "0";
                    }
                    else
                    {
                        //strTaskID = hfTaskID.Value;
                    }
                    //strAccessionNo = hfAccessionNo.Value;
                    strORDStatus = hdnORDStatus.Value;
                    hdnPatientVisitID.Value = strPatientVisitId;
                }
            }

            if (ddlAction.SelectedValue == "Reject_Sample_SampleSearch")
            {
                if (strSampleStatusID == InvSampleStatus.Rejected.ToString())
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "err", "javascript:alert('" + "Sample Already Rejected" + "');", true);
                    hdnActionName.Value = string.Empty;
                    ddlAction.SelectedIndex = -1;
                    RejectSample = false;
                    FetchScanInDetails();
                    return;
                }
            }

            if (ddlAction.SelectedValue == "Reject_Sample_SampleSearch")
            {
                //Config Email Notification
                //IsNeedToEmailNotifyForSmplRjct();

                if (strORDStatus == "Paid" || strORDStatus == "Collected" || strORDStatus == "Received" || strORDStatus == "SampleReceived" || strORDStatus == "Pending" || strORDStatus == "SampleCollected")
                {
                    SampleTracker objSampleTracker = new SampleTracker();
                    objSampleTracker.PatientVisitID = Convert.ToInt64(strPatientVisitId);
                    objSampleTracker.SampleID = Convert.ToInt32(strSampleId);
                    objSampleTracker.InvSampleStatusID = 4;
                    //objSampleTracker.Reason = ddlReason.SelectedItem.Text;
                    //objSampleTracker.AccessionNo = Convert.ToInt32(strAccessionNo);

                    Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                    long returncode = -1;
                    base.ContextInfo.AdditionalInfo = "V4ENVIRONMENT";
                    returncode = invbl.InsertRejectedSample(Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), 4, ddlReason.SelectedItem.Text, LID, 0);
                    //ApproveTaskCreation();
                    ActionManager AM = new ActionManager(base.ContextInfo);
                    List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                    PageContextkey PC = new PageContextkey();
                    PC.ID = Convert.ToInt64(ILocationID);
                    PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                    PC.RoleID = Convert.ToInt64(RoleID);
                    PC.OrgID = OrgID;
                    PC.PatientVisitID = Convert.ToInt64(strPatientVisitId);
                    PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
                    PC.ButtonName = PageContextDetails.ButtonName;//"btnOK";
                    PC.ButtonValue = PageContextDetails.ButtonValue;// "OK";
                    PC.SampleID = Convert.ToInt32(strSampleId);

                    lstpagecontextkeys.Add(PC);
                    long res = -1;
                    dReason.Style.Add("display", "none");
                    ddlAction.SelectedIndex = -1;
                    res = AM.PerformingNextStepNotification(PC, "", "");
                    // after rejected a sample sample should go from the grid.
                    dt = (DataTable)ViewState["ScanedIn"];
                    var query = dt.AsEnumerable().Where(r => r.Field<string>("BarcodeNumber") == Barcode_Number);
                    foreach (var row in query.ToList())
                    {
                        row.Delete();
                        dt.AcceptChanges();
                    }
                    ViewState["ScanedIn"] = dt;
                    RejectSample = false;
                    FetchScanInDetails();
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "rtt", "javascript:alert('" + strSampleRejectedSuccess.Trim() + "');", true);
                    hdnActionName.Value = string.Empty;
                }
                else if (strORDStatus == "Rejected")
                {
                    dReason.Style.Add("display", "none");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ert", "javascript:alert('" + strSampleAlredyRejected.Trim() + "');", true);
                    hdnActionName.Value = string.Empty;
                    ddlAction.SelectedIndex = -1;
                    RejectSample = false;
                    FetchScanInDetails();
                }
                else if (strORDStatus == "Not given")
                {
                    dReason.Style.Add("display", "none");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "qwe", "javascript:alert('The sample is already in Not given status.');", true);
                    hdnActionName.Value = string.Empty;
                    ddlAction.SelectedIndex = -1;
                    RejectSample = false;
                    FetchScanInDetails();
                }
                else
                {
                    dReason.Style.Add("display", "none");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "we", "javascript:alert('" + strSampleSentProcessing.Trim() + "');", true);
                    hdnActionName.Value = string.Empty;
                    ddlAction.SelectedIndex = -1;
                    RejectSample = false;
                    FetchScanInDetails();
                }

            }
            else if (ddlAction.SelectedValue == "Not_Given_Sample_Enquiery")
            {
                if (strORDStatus == "Paid" || strORDStatus == "Collected" || strORDStatus == "Received" || strORDStatus == "SampleReceived" || strORDStatus == "Pending" || strORDStatus == "SampleCollected")
                {
                    SampleTracker objSampleTracker = new SampleTracker();
                    objSampleTracker.PatientVisitID = Convert.ToInt64(strPatientVisitId);
                    objSampleTracker.SampleID = Convert.ToInt32(strSampleId);
                    objSampleTracker.InvSampleStatusID = 6;
                    //objSampleTracker.Reason = ddlReason.SelectedItem.Text;
                    //objSampleTracker.AccessionNo = Convert.ToInt32(strAccessionNo);

                    Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                    long returncode = -1;
                    base.ContextInfo.AdditionalInfo = "V4ENVIRONMENT";
                    returncode = invbl.InsertNotGivenSample(Convert.ToInt64(strPatientVisitId), Convert.ToInt32(strSampleId), 6, ddlReason.SelectedItem.Text, LID, 0);
                    //ApproveTaskCreation();
                    ActionManager AM = new ActionManager(base.ContextInfo);
                    List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                    PageContextkey PC = new PageContextkey();
                    PC.ID = Convert.ToInt64(ILocationID);
                    PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                    PC.RoleID = Convert.ToInt64(RoleID);
                    PC.OrgID = OrgID;
                    PC.PatientVisitID = Convert.ToInt64(strPatientVisitId);
                    PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
                    PC.ButtonName = PageContextDetails.ButtonName;//"btnOK";
                    PC.ButtonValue = PageContextDetails.ButtonValue;// "OK";
                    PC.SampleID = Convert.ToInt32(strSampleId);

                    lstpagecontextkeys.Add(PC);
                    long res = -1;
                    res = AM.PerformingNextStepNotification(PC, "", "");

                    // after not given status a sample sample should go from the grid.
                    dt = (DataTable)ViewState["ScanedIn"];
                    var query = dt.AsEnumerable().Where(r => r.Field<string>("BarcodeNumber") == Barcode_Number);
                    foreach (var row in query.ToList())
                    {
                        row.Delete();
                        dt.AcceptChanges();
                    }
                    ViewState["ScanedIn"] = dt;
                    RejectSample = false;
                    FetchScanInDetails();
                    dReason.Style.Add("display", "none");
                    ddlAction.SelectedIndex = -1;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "wq", "javascript:alert('" + strSampleNotGivenSuccess.Trim() + "');", true);
                    hdnActionName.Value = string.Empty;
                }
                else if (strORDStatus == "Not given")
                {
                    dReason.Style.Add("display", "none");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ty", "javascript:alert('" + strSampleAlredyNotGiven.Trim() + "');", true);
                    hdnActionName.Value = string.Empty;
                    ddlAction.SelectedIndex = -1;
                    RejectSample = false;
                    FetchScanInDetails();

                }
                else if (strORDStatus == "Rejected")
                {
                    dReason.Style.Add("display", "none");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tr", "javascript:alert('Sample is already rejected.');", true);
                    hdnActionName.Value = string.Empty;
                    ddlAction.SelectedIndex = -1;
                    RejectSample = false;
                    FetchScanInDetails();
                }
                else
                {
                    dReason.Style.Add("display", "block");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "rt", "javascript:alert('" + strSampleSentProcessingNotGiven.Trim() + "');", true);
                    hdnActionName.Value = string.Empty;
                    ddlAction.SelectedIndex = -1;
                    RejectSample = false;
                    FetchScanInDetails();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Changing the sample status action.", ex);
        }
    }

    protected void ddlBarcodeType_SelectedIndexChanged1(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt = (DataTable)ViewState["ScanedIn"];
        DataView dv = new DataView(dt);
        if (ddlBarcodeType.SelectedIndex != 0)
        {
            string Filter = "IsSecBarCode=" + (ddlBarcodeType.SelectedIndex == 1 ? "False" : "True");
            dv.RowFilter = Filter;
            if (dv != null)
            {
                dt = null;
                dt = dv.ToTable();
                if (dt != null)
                {
                    dt.DefaultView.Sort = "ReceivedTime" + " " + "DESC";
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hide", "hidegrid();", true);
                }
            }
        }
        else
        {
            dt.DefaultView.Sort = "ReceivedTime" + " " + "DESC";
            GridView1.DataSource = dt;
            GridView1.DataBind();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "hide", "hidegrid();", true);
        }
    }
    protected void chkPrint_CheckedChanged(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "hidegrid();", true);

    }
}
