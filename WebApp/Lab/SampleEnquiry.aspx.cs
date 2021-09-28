using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.PerformingNextAction;
using System.Collections;
using System.Data;
using System.Reflection;
using System.Drawing;

public partial class Lab_SampleEnquiry : BasePage
{
    int deptId = 0;
    bool isScondaryBarcode;
    List<ActionMaster> lstActionMaster = new List<ActionMaster>();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string confirmValue = hdnActionName.Value;
            if (!string.IsNullOrEmpty(confirmValue) && !confirmValue.Equals("--Select--"))
            {
                dReason.Style.Add("display", "none");
                //SampleDetail.Style.Add("display", "none");

            }
            //if (GridView1.SelectedRow != null)
            //{
            //    CheckBox chk = (CheckBox)GridView1.SelectedRow.Cells[0].FindControl("chkPrint");
            //    if (chk.Checked == true)
            //        GridView1.SelectedRow.BackColor = System.Drawing.Color.Coral;
            //}

            if (!IsPostBack)
            {
                loadprinter();
                LoadDepartement();
                LoadReasons();
                //SampleDetail.Style.Add("display", "none");


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Scan In history page at Page Load", ex);
        }
    }
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
                ddlDepartment.DataValueField = "DeptID";
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


    public void loadprinter()
    {
        try
        {
            long returncode = -1;
            string PrinterType = "BarCodePrinter";
            //Referrals_BL referralsbl = new Referrals_BL(base.ContextInfo);
            List<LocationPrintMap> scanEnquiry = new List<LocationPrintMap>();
            Users_BL usersbl = new Users_BL(base.ContextInfo);
            returncode = usersbl.LoadPrinterNameAndPath(OrgID, out scanEnquiry);
            //returncode = referralsbl.GetLocationPrinter(OrgID, ILocationID, PrinterType, out scanEnquiry);
            if (scanEnquiry.Count > 0)
            {
                ddlPrinters.DataTextField = "Name";
                ddlPrinters.DataValueField = "PrinterName";
                ddlPrinters.DataSource = scanEnquiry;
                ddlPrinters.DataBind();
            }
            ddlPrinters.Items.Insert(0, "--Select--");
            ddlPrinters.Items[0].Value = "-1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Printers.", ex);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        ddlAction.SelectedIndex = -1;
        ddlBarcodeType.SelectedIndex = -1;
        ddlReason.SelectedIndex = -1;
        ddlDepartment.SelectedIndex = -1;
        HdnSampleEnquiryCheckBoxId.Value = "";
        GridView1.DataSource = null;
        GridView1.DataBind();
        grouptab.ActiveTabIndex = 0;
        FetchData();
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


            ddlReason.Items.Insert(0, new ListItem("--Select--".Trim(), "-1"));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Sample Enquiery page at Load reason method", ex);
        }
    }

    private void FetchData()
    {
        try
        {
            DataTable dt = new DataTable();
            hdnBarcode.Value = txtBarcodeSample.Text.TrimEnd();
            int deptId = 0;
            int BarcodeType = 0;
            long returncode = -1;
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            deptId = Convert.ToInt32(ddlDepartment.SelectedValue);
            BarcodeType = Convert.ToInt32(ddlBarcodeType.SelectedValue);
            ContextInfo.DepartmentCode = ddlDepartment.SelectedValue;
            List<SampleBatchScanOutDetails> scanhistory = new List<SampleBatchScanOutDetails>();
            returncode = masterbl.ScanInHistory(txtBarcodeSample.Text.Trim(), deptId, BarcodeType, out scanhistory);
            if (scanhistory.Count > 0)
            {
                gv.Style.Add("display", "block");
                ViewState["SampleEnquiery"] = dt = ToDataTable(scanhistory);
                //DataView dv = new DataView(dt);
                //if (ddlBarcodeType.SelectedIndex != 0)
                //{
                //string Filter = "IsSecBarCode=" + (ddlBarcodeType.SelectedIndex == 1 ? "False" : "True");
                //dv.RowFilter = Filter;
                ///if (dv != null)
                //{
                //dt = null;
                //dt = dv.ToTable();
                //}
                //}
                //if (dt != null && dt.Rows.Count > 0)
                //{
                GridView1.DataSource = scanhistory;
                GridView1.DataBind();
                updatePanel1.Update();
                divAction.Style.Add("display", "block");
                ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "hidegrid()", true);
                txtBarcodeSample.Text = string.Empty;
            }
            else
            {
                gv.Style.Add("display", "none");
                divAction.Style.Add("display", "none");
                ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "hidegrid()", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('No Matching Record Found!!');", true);
            }
            //}
            //else
            //{
            //    gv.Style.Add("display", "none");
            //    divAction.Style.Add("display", "none");
            //    ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "hidegrid()", true);
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('No Matching Record Found!!');", true);
            //}
            txtBarcodeSample.Text = string.Empty;
        }
        catch (Exception ex)
        {
            txtBarcodeSample.Text = string.Empty;
            CLogger.LogError("Error in Scan In history page at FetchData method", ex);
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
            CLogger.LogError("Error in Scan In history page at ToDataTable method", ex);
        }
        return dataTable;
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != null)
            {
                ddlAction.SelectedIndex = -1;
                ddlReason.SelectedIndex = -1;
                GridView1.PageIndex = e.NewPageIndex;
                FetchData();
            }
        }
        catch (Exception ex)
        {
            GridView1.PageIndex = 1;
            CLogger.LogError("Error in Scan In history page at GridView1_PageIndexChanging", ex);
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton lnk = (LinkButton)e.Row.FindControl("lnkLabNumber");
                lnk.Attributes.Add("onclick", "javascript:ShowPopUp('" + lnk.Text + "','LabNo');");

                LinkButton lnk1 = (LinkButton)e.Row.FindControl("lnkBarcode");
                lnk1.Attributes.Add("onclick", "javascript:ShowPopUp('" + lnk1.Text + "','BarCode');");

                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.RowIndex);
                e.Row.Attributes["style"] = "cursor:pointer";
                HiddenField s = (HiddenField)e.Row.FindControl("hdIsSecondaryBarcode");
                isScondaryBarcode = Convert.ToBoolean(s.Value); ;
                TableCell statusCell = e.Row.Cells[9];
                if (statusCell.Text == DateTime.MinValue.ToString() || statusCell.Text == DateTime.MaxValue.ToString())
                {
                    statusCell.Text = string.Empty;
                }
                TableCell tatcell = e.Row.Cells[12];
                if (tatcell.Text == DateTime.MinValue.ToString() || tatcell.Text == DateTime.MaxValue.ToString())
                {
                    tatcell.Text = string.Empty;
                }


                if (HdnSampleEnquiryCheckBoxId.Value == "")
                {
                    //if (((CheckBox)e.Row.FindControl("chkPrint")).Enabled == true)
                    //{

                    HdnSampleEnquiryCheckBoxId.Value = ((CheckBox)e.Row.FindControl("chkPrint")).ClientID;


                    //}
                }
                else
                {
                    //if (((CheckBox)e.Row.FindControl("chkPrint")).Enabled == true)
                    //{
                    HdnSampleEnquiryCheckBoxId.Value += '~' + ((CheckBox)e.Row.FindControl("chkPrint")).ClientID;

                    //}
                }

            }

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
        catch (Exception ex)
        {
            CLogger.LogError("Error in Sample Enquiery at GridView1_RowDataBound. ", ex);
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        FetchSampleDetails();
        FetchSampleTrackingDetails();
        ddlAction.SelectedIndex = -1;
        ddlReason.SelectedIndex = -1;
        dReason.Style.Add("display", "none");
        grouptab.ActiveTabIndex = 0;



        ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:highlite('" + GridView1.SelectedIndex + "');", true);
    }

    private void FetchSampleDetails()
    {
        try
        {
            DataTable dt = new DataTable();
            if (GridView1.SelectedRow != null)
            {
                GridView2.DataSource = null;
                GridView2.DataBind();
                int deptId = 0;
                deptId = Convert.ToInt32(ddlDepartment.SelectedValue);
                //if (deptId == -1)
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
                        deptId = 0;
                    }
                    else
                    {
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('No Matching Record Found!!');", true);
                        // GridView2.Attributes.Add("style","display:none");
                        deptId = 0;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Sample Enquiery at FetchSampleDetails", ex);
        }
    }

    private void FetchSampleTrackingDetails()
    {
        try
        {
            if (GridView1.SelectedRow != null)
            {
                int deptId = 0;
                GridView3.DataSource = null;
                GridView3.DataBind();
                //deptId = Convert.ToInt32(((HiddenField)GridView1.SelectedRow.Cells[0].FindControl("hfDepartmentId")).Value.ToString());
                deptId = Convert.ToInt32(ddlDepartment.SelectedValue);
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
                        deptId = 0;
                    }
                    else
                    {
                        // ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('No Matching Record Found!!');", true);
                        // GridView3.Attributes.Add("style","display:none");
                        deptId = 0;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Sample Enquiery at FetchSampleTrackingDetails", ex);
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
            }
        }
        catch (Exception ex)
        {
            GridView3.PageIndex = 1;
            CLogger.LogError("Error in Sample Enquiery page at GridView3_PageIndexChanging", ex);
        }
    }

    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell tatcell = e.Row.Cells[1];
                if (tatcell.Text == DateTime.MinValue.ToString() || tatcell.Text == DateTime.MaxValue.ToString())
                {
                    tatcell.Text = string.Empty;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Sample Enquiery page at GridView2_RowDataBound", ex);
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
            }
        }
        catch (Exception ex)
        {
            GridView2.PageIndex = 0;
            CLogger.LogError("Error in Sample Enquiery at GridView2_PageIndexChanging", ex);
        }
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        int flag = 0;
        SampleDetail.Attributes.Add("style", "display:none");
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
        DataTable dt = new DataTable();

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
                    HiddenField hfDeptName = (HiddenField)item.FindControl("hdnDeptName");
                    HiddenField hfPatientRegisterdType = (HiddenField)item.FindControl("hdnPatientRegisterdType");
                    HiddenField hfScanCount = (HiddenField)item.FindControl("hdnScanCount");
                    HiddenField hfReceivedTime = (HiddenField)item.FindControl("hdnReceivedTime");
                    HiddenField hfSampleStatus = (HiddenField)item.FindControl("hdnSampleStatus");
                    HiddenField hfCollectionCenter = (HiddenField)item.FindControl("hdnCollectionCenter");
                    HiddenField hfReportDateTime = (HiddenField)item.FindControl("hdnReportDateTime");
                    HiddenField hfinvSampleid = (HiddenField)item.FindControl("hdnSampleid");
                    strSampleId = hfinvSampleid.Value;
                    strPatientVisitId = hfVisitId.Value;
                    //if (!String.IsNullOrEmpty(strSampleId) && strSampleId.Length > 0)
                    //{
                    //    flag = flag + 1;
                    //    moresampleid.Add(strSampleId);
                    //    if (flag > 0)
                    //    {
                    //        strSampleId = String.Join(",", moresampleid.ToArray());
                    //    }
                    //}
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
                            //objPrintBarcode.MachineID = MachineID;
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
                            lstPrintBarcode.Add(objPrintBarcode);
                        }
                    }
                }
                else
                {
                    if (isFirstTime == 0)
                    {
                        dt = (DataTable)ViewState["SampleEnquiery"];
                        dt.DefaultView.Sort = "ReceivedTime" + " " + "ASC";
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }

                    HiddenField hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                    HiddenField hfLabNumber = (HiddenField)item.FindControl("hdnLabNumber");
                    HiddenField hfBarcodeNumber = (HiddenField)item.FindControl("hdnBarcodeNumber");
                    HiddenField hfDeptName = (HiddenField)item.FindControl("hdnDeptName");
                    HiddenField hfPatientRegisterdType = (HiddenField)item.FindControl("hdnPatientRegisterdType");
                    HiddenField hfScanCount = (HiddenField)item.FindControl("hdnScanCount");
                    HiddenField hfReceivedTime = (HiddenField)item.FindControl("hdnReceivedTime");
                    HiddenField hfSampleStatus = (HiddenField)item.FindControl("hdnSampleStatus");
                    HiddenField hfCollectionCenter = (HiddenField)item.FindControl("hdnCollectionCenter");
                    HiddenField hfReportDateTime = (HiddenField)item.FindControl("hdnReportDateTime");
                    HiddenField hfinvSampleid = (HiddenField)item.FindControl("hdnSampleid");
                    strSampleId = hfinvSampleid.Value;
                    strPatientVisitId = hfVisitId.Value;


                    //if (!String.IsNullOrEmpty(strSampleId) && strSampleId.Length > 0)
                    //{
                    //    flag = flag + 1;
                    //    moresampleid.Add(strSampleId);
                    //    if (flag > 0)
                    //    {
                    //        strSampleId = String.Join(",", moresampleid.ToArray());
                    //    }
                    //}
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
                    isFirstTime = isFirstTime + 1;
                    ViewState["count"] = isFirstTime;
                }


            }

            if (lstPrintBarcode.Count > 0)
            {
                GateWay objGateWay = new GateWay(base.ContextInfo);
                Int32 returnStatus = -1;
                long returnCode = 0;
                returnCode = objGateWay.SaveBarcodePrintDetails(lstPrintBarcode, out returnStatus);

                if (returnCode > 0)
                {

                    ScriptManager.RegisterClientScriptBlock(updatePanel1, typeof(UpdatePanel), "", "alert('Print request sent successfully')", true);
                    SampleDetail.Style.Add("display", "none");
                    ddlPrinters.SelectedIndex = -1;
                    //LoadGrid();
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(updatePanel1, typeof(UpdatePanel), "", "alert('Unable to send Print request sent successfully.')", true);
                    ddlPrinters.SelectedIndex = -1;
                    SampleDetail.Style.Add("display", "none");
                }
            }

            dt = (DataTable)ViewState["SampleEnquiery"];
            dt.DefaultView.Sort = "ReceivedTime" + " " + "DESC";
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Printing action.", ex);
        }

    }

    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        //FetchSampleDetails();
        //FetchSampleTrackingDetails();
        ddlAction.SelectedIndex = -1;
        ddlReason.SelectedIndex = -1;
        FetchData();
    }

    string strSampleRejectedSuccess = "Sample is Rejected Successfully";
    string strSampleNotGivenSuccess = "Sample status Not given is changed Successfully";
    string strSampleAlredyRejected = "This Sample is already Rejected";
    string strSampleAlredyNotGiven = "This Sample is already in Not given status";
    string strSampleSentProcessing = "This Sample is already sent to processing, Unable to Reject!";
    string strSampleSentProcessingNotGiven = "This Sample is already sent to processing, Unable to change the status!";

    protected void btnOK_Click(object sender, EventArgs e)
    {
        try
        {
            PageContextDetails.ButtonName = ((Button)sender).ID;
            PageContextDetails.ButtonValue = ((Button)sender).Text;
            string samplestatus = ddlAction.SelectedItem.Text;
            string bulksample_print = null;
            BarcodeAttributes barcodeattribute = new BarcodeAttributes();
            // Panel1.Visible = true;
            Panel2.Visible = true;
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
                    HiddenField hdnORDStatus = (HiddenField)item.FindControl("hdnORDStatus");
                    //HiddenField hfsamplename = (HiddenField)item.FindControl("hdnSamplename");
                    //samples = hfsamplename.Value;
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
                    // strAccessionNo = hfAccessionNo.Value;
                    strORDStatus = hdnORDStatus.Value;
                    hdnPatientVisitID.Value = strPatientVisitId;
                }
            }

            if (ddlAction.SelectedValue == "Reject_Sample_SampleSearch")
            {
                if (strSampleStatusID == InvSampleStatus.Rejected.ToString())
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('" + "Sample Already Rejected" + "');", true);
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
                    ApproveTaskCreation();
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
                    ddlAction.SelectedIndex = -1;
                    dReason.Style.Add("display", "none");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('" + strSampleRejectedSuccess.Trim() + "');", true);
                    hdnActionName.Value = string.Empty;
                    txtBarcodeSample.Text = hdnBarcode.Value;
                    FetchData();
                }
                else if (strORDStatus == "Rejected")
                {
                    dReason.Style.Add("display", "none");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('" + strSampleAlredyRejected.Trim() + "');", true);
                    hdnActionName.Value = string.Empty;
                    ddlAction.SelectedIndex = -1;
                    txtBarcodeSample.Text = hdnBarcode.Value;
                    FetchData();
                }
                else if (strORDStatus == "Not given")
                {
                    dReason.Style.Add("display", "none");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('The sample is already in Not given status.');", true);
                    hdnActionName.Value = string.Empty;
                    ddlAction.SelectedIndex = -1;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:highlite('" + GridView1.SelectedIndex + "');", true);
                    //FetchData();
                }
                else
                {
                    dReason.Style.Add("display", "none");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('" + strSampleSentProcessing.Trim() + "');", true);
                    hdnActionName.Value = string.Empty;
                    ddlAction.SelectedIndex = -1;
                    //FetchData();
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
                    ApproveTaskCreation();
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
                    ddlAction.SelectedIndex = -1;
                    dReason.Style.Add("display", "none");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('" + strSampleNotGivenSuccess.Trim() + "');", true);
                    hdnActionName.Value = string.Empty;
                    txtBarcodeSample.Text = hdnBarcode.Value;
                    FetchData();
                }
                else if (strORDStatus == "Not given")
                {
                    dReason.Style.Add("display", "none");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('" + strSampleAlredyNotGiven.Trim() + "');", true);
                    hdnActionName.Value = string.Empty;
                    ddlAction.SelectedIndex = -1;
                    txtBarcodeSample.Text = hdnBarcode.Value;
                    FetchData();
                }
                else if (strORDStatus == "Rejected")
                {
                    dReason.Style.Add("display", "none");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('Sample is already rejected.');", true);
                    hdnActionName.Value = string.Empty;
                    ddlAction.SelectedIndex = -1;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:highlite('" + GridView1.SelectedIndex + "');", true);
                    //FetchData();
                }
                else
                {
                    dReason.Style.Add("display", "none");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('" + strSampleSentProcessingNotGiven.Trim() + "');", true);
                    hdnActionName.Value = string.Empty;
                    ddlAction.SelectedIndex = -1;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:highlite('" + GridView1.SelectedIndex + "');", true);
                    //FetchData();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while sending samples", ex);
        }
    }


    public void ApproveTaskCreation()
    {
        long returnCode;
        try
        {
            Tasks task = new Tasks();
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();

            Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
            returnCode = -1;
            long taskreturncode = -1;
            string gUID = string.Empty;
            long createTaskID = -1;
            Investigation_BL DemoBL;

            long vid = -1;
            long patientID = -1;
            Int64.TryParse(hdnPatientVisitID.Value, out vid);

            DemoBL = new Investigation_BL(base.ContextInfo);

            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(vid, out lstPatientVisitDetails);
            if (lstPatientVisitDetails.Count > 0)
            {
                patientID = lstPatientVisitDetails[0].PatientID;
                List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                returnCode = DemoBL.GetPatientInvestigationStatus(vid, OrgID, out lstPatientInvestigation);
                int validatedCount = 0;
                validatedCount = (from IL in lstPatientInvestigation
                                  where IL.Status != InvStatus.Validate && IL.Status != InvStatus.Approved && IL.Status != InvStatus.Coauthorize
                                  && IL.Status != InvStatus.SecondOpinion && IL.Status != "PartiallyValidated" && IL.Status != InvStatus.Cancel
                                  && IL.Status != InvStatus.Coauthorized && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.WithHeld
                                  && IL.Status != InvStatus.Notgiven && IL.Status != InvStatus.WithholdValidation && IL.Status != "ReflexTest"
                                  && IL.Status != InvStatus.Rejected && IL.Status != "Rejected"
                                  select IL).Count();
                if (validatedCount <= 0)
                {
                    int NeedvalidatedCount = 0;
                    NeedvalidatedCount = (from IL in lstPatientInvestigation
                                          where IL.Status == "PartiallyValidated" || IL.Status == InvStatus.Validate
                                          select IL).Count();
                    if (NeedvalidatedCount > 0)
                    {
                        taskreturncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Validate),
                                vid, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
                                lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                lstPatientInvestigation[0].UID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber, "");
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = vid;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        task.RefernceID = lstPatientInvestigation[0].LabNo;
                        //Create task 

                        taskreturncode = oTasksBL.CreateTask(task, out createTaskID);
                    }
                }
            }
        }
        catch (Exception e)
        {
            CLogger.LogError("Error in while Cancel bill Approve Task Cretaion", e);
        }
    }

    private void LoadGridAction()
    {
        long returnCode;
        try
        {
            ddlAction.Items.Clear();

            int menuType = Convert.ToInt32(TaskHelper.SearchType.SampleSearch);

            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, menuType, out lstActionMaster);
            if (lstActionMaster.Count > 0)
            {
                ddlAction.DataSource = lstActionMaster;
                ddlAction.DataTextField = "ActionName";
                ddlAction.DataValueField = "ActionCode";
                ddlAction.DataBind();
                ddlAction.Items.Insert(0, new ListItem("--Select--", "0"));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save PendingSampleCollection", ex);
        }
    }

    //protected void btnFilter_Click(object sender, EventArgs e)
    //{
    //    FetchData();
    //}
    protected void ddlBarcodeType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlAction.SelectedIndex = -1;
            ddlReason.SelectedIndex = -1;
            HdnSampleEnquiryCheckBoxId.Value = "";
            //DataTable dt = new DataTable();
            //dt = (DataTable)ViewState["SampleEnquiery"];
            //if (dt != null && dt.Rows.Count > 0)
            //{
            //    DataView dv = new DataView(dt);
            //    if (ddlBarcodeType.SelectedIndex != 0)
            //    {
            //        string Filter = "IsSecBarCode=" + (ddlBarcodeType.SelectedIndex == 1 ? "False" : "True");
            //        dv.RowFilter = Filter;
            //        if (dv != null)
            //        {
            //            dt = null;
            //            dt = dv.ToTable();
            //            if (dt != null)
            //            {
            //                dt.DefaultView.Sort = "ReceivedTime" + " " + "DESC";
            //                GridView1.DataSource = dt;
            //                GridView1.DataBind();
            //                gv.Style.Add("display", "block");
            //                divAction.Style.Add("display", "block");
            //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hide", "hidegrid();", true);
            //            }
            //        }
            //    }
            //    else
            //    {
            //        dt.DefaultView.Sort = "ReceivedTime" + " " + "DESC";
            //        GridView1.DataSource = dt;
            //        GridView1.DataBind();
            //        gv.Style.Add("display", "block");
            //        divAction.Style.Add("display", "block");
            //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "hide", "hidegrid();", true);
            //    }
            //}
            //else
            //{
            //    if (dt != null && dt.Rows.Count > 0)
            //    {
            //        dt.DefaultView.Sort = "ReceivedTime" + " " + "DESC";
            //        GridView1.DataSource = dt;
            //        GridView1.DataBind();
            //    }
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hide", "hidegrid();", true);
            //}

            txtBarcodeSample.Text = hdnBarcode.Value;
            FetchData();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save ddlBarcodeType_SelectedIndexChanged event.", ex);
        }
    }
    protected void ddlBarcodeType_SelectedIndexChanged1(object sender, EventArgs e)
    {
        ddlAction.SelectedIndex = -1;
        ddlReason.SelectedIndex = -1;
    }
    //protected void ddlAction_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:validateaction();", true);
    //    //ddlReason.SelectedIndex = -1;
    //    //hdnActionName.Value = "";
    //    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:highlite();", true);
    //    // ScriptManager.RegisterStartupScript(Page, this.GetType(), "trt", "hidegrid();", true);
    //}
    protected void ddlAction_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlReason.SelectedIndex = -1;
        //ddlReason.Style.Add("display", "none");
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "trt", "hidegrid();", true);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:highlite('" + GridView1.SelectedIndex + "');", true);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ty", "javascript:ShowReason();", true);


    }
}
