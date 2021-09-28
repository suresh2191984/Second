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

public partial class Reports_BillWiseDeptWiseCollectionSummary : BasePage
{
    long returnCode = -1;
    decimal pTotalItemAmt = -1;
    decimal pTotalDiscount = -1;
    decimal pTotalReceivedAmt = -1;
    decimal pTotalDue = -1;
    decimal pTax = -1;
    decimal pServiceCharge = -1;

    DataSet ds = new DataSet();
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    Dictionary<string, decimal> dictFooter = new Dictionary<string, decimal>();
    Dictionary<string, decimal> GrandTotal = new Dictionary<string, decimal>();

    private enum StaticColumns {    BillNumber,
                                    PatientName,
                                    VisitDate,
                                    VisitType   };

    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            getReportColumns();
        }
    }

    private void getReportColumns()
    {
        try
        {
            List<ReportProfile> lstReportProfile = new List<ReportProfile>();
            new Report_BL(base.ContextInfo).GetReportProfile(OrgID, Convert.ToInt64(Request.QueryString["ReportID"]), out lstReportProfile);
            if (lstReportProfile.Count > 0)
            {
                string strXml;
                if (lstReportProfile[0].CurrentConfigValue == null || lstReportProfile[0].CurrentConfigValue == "")
                {
                    strXml = lstReportProfile[0].DefaultConfigValue;
                }
                else
                {
                    strXml = lstReportProfile[0].CurrentConfigValue;
                }
                if (lstReportProfile[0].DefaultConfigValue != null || lstReportProfile[0].DefaultConfigValue.Trim() != string.Empty)
                {
                    BindColumnList(lstReportProfile[0].DefaultConfigValue, strXml);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in getReportColumns, BillWiseDeptWiseCollectionSummary", ex);
        }
    }

    private void BindColumnList(string DefaultColumns, string CurrentColumns)
    {
        try
        {
            StringReader strRdrDefault = new StringReader(DefaultColumns);
            DataSet ds = new DataSet();
            ds.ReadXml(strRdrDefault);
            strRdrDefault.Dispose();
            StringReader strRdrCurrent = new StringReader(CurrentColumns);
            DataSet ds1 = new DataSet();
            ds1.ReadXml(strRdrCurrent);
            strRdrCurrent.Dispose();

            if (ds.Tables.Count > 0)
            {
                chkColumns.DataSource = ds.Tables[0];
                chkColumns.DataTextField = "Column_text";
                chkColumns.DataValueField = "Column_text";
                chkColumns.DataBind();
            }
            if (ds1.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                {
                    chkColumns.Items.FindByText(ds1.Tables[0].Rows[i].ItemArray[0].ToString()).Selected = true;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BindColumnList, BillWiseDeptWiseCollectionSummary", ex);
        }
    }

    #region PrepareTable for XL

    //public DataTable loaddata(List<BillDeptWiseCollections> lstResultToXL)
    //{
    //    DataTable dt = new DataTable();

    //    DataColumn dcol1 = new DataColumn("BillNumber");
    //    DataColumn dcol2 = new DataColumn("PatientName");
    //    DataColumn dcol3 = new DataColumn("VisitDate");
    //    DataColumn dcol4 = new DataColumn("VisitType");
    //    DataColumn dcol5 = new DataColumn("Consultation");
    //    DataColumn dcol6 = new DataColumn("Imaging");
    //    DataColumn dcol7 = new DataColumn("Lab");
    //    DataColumn dcol8 = new DataColumn("Pharmacy");
    //    DataColumn dcol9 = new DataColumn("Procedure");
       
    //    dt.Columns.Add(dcol1);
    //    dt.Columns.Add(dcol2);
    //    dt.Columns.Add(dcol3);
    //    dt.Columns.Add(dcol4);
    //    dt.Columns.Add(dcol5);
    //    dt.Columns.Add(dcol6);
    //    dt.Columns.Add(dcol7);
    //    dt.Columns.Add(dcol8);
    //    dt.Columns.Add(dcol9);

    //    foreach (BillDeptWiseCollections item in lstResultToXL)
    //    {
    //        DataRow dr = dt.NewRow();

    //        dr["BillNumber"] = item.BillNumber;
    //        dr["PatientName"] = item.PatientName;
    //        dr["VisitDate"] = item.VisitDate;
    //        dr["VisitType"] = item.VisitType;
    //        dr["Consultation"] = item.Consultation;
    //        GrandTotal["Consultation"] += item.Consultation;
    //        dr["Others"] = item.Others;
    //        GrandTotal["Others"] += item.Others;
    //        dr["Lab"] = item.Lab;
    //        GrandTotal["LabFee"] += item.Lab;
    //        dr["Pharmacy"] = item.Pharmacy;
    //        GrandTotal["Pharmacy"] += item.Pharmacy;
    //        //dr["Procedure"] = item.Procedure;
    //        //GrandTotal["Procedure"] += item.Procedure;
    //        dt.Rows.Add(dr);
    //    }
    //    ViewState["grandTotal"] = GrandTotal;
    //    return dt;
    //}

    #endregion

    protected void getFooterInitVal(string[] gridColumns)
    {
        foreach (string elt in gridColumns)
        {
            if(!Enum.GetNames(typeof(StaticColumns)).Contains(elt))
            dictFooter.Add(elt,0);
        }
    }

    protected void getGrandTotalInitVal(string[] gridColumns,DataTable Source)
    {
        foreach (string elt in gridColumns)
        {
            if (!Enum.GetNames(typeof(StaticColumns)).Contains(elt))
                GrandTotal.Add(elt, Source.AsEnumerable().Sum(x => x.Field<decimal>(elt)));
        }
        ViewState["grandTotal"] = GrandTotal;
    }

    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell cell;
                for (int i = 1; i < e.Row.Cells.Count; i++)
                {
                    cell = e.Row.Cells[i];
                    if (gvIPReport.HeaderRow.Cells[i].Text == "PatientName")
                    {
                        cell.HorizontalAlign = HorizontalAlign.Left;
                    }
                    else if (gvIPReport.HeaderRow.Cells[i].Text == "VisitDate")
                    {
                        cell.Text = DateTime.Parse(cell.Text).ToString("dd/MMM/yyyy");
                    }
                    else if (gvIPReport.HeaderRow.Cells[i].Text == "VisitType" || gvIPReport.HeaderRow.Cells[i].Text=="BillNumber")
                    {
                        cell.HorizontalAlign = HorizontalAlign.Center;
                    }
                    else
                    {
                        decimal val;
                        if (Decimal.TryParse(cell.Text,out val))
                            dictFooter[gvIPReport.HeaderRow.Cells[i].Text] += val;
                        cell.HorizontalAlign = HorizontalAlign.Right;
                        cell.Text = Decimal.Parse(cell.Text).ToString("0.00");
                    }
                }          
            }

            if(e.Row.RowType == DataControlRowType.Footer)
            {
                TableCell cell;
                bool? flag = false;
                StringBuilder strBld = new StringBuilder();
                for (int i = 0; i < e.Row.Cells.Count; i++)
                {
                    cell = e.Row.Cells[i];
                    if (!Enum.GetNames(typeof(StaticColumns)).Contains(gvIPReport.HeaderRow.Cells[i].Text))
                    {
                        strBld.Remove(0, strBld.Length);
                        strBld.AppendFormat("<font color='#660066'>" + dictFooter[gvIPReport.HeaderRow.Cells[i].Text].ToString("0.00") + "</font>" + "<br/>");
                        strBld.AppendFormat("<font color='#990033'>" + GrandTotal[gvIPReport.HeaderRow.Cells[i].Text].ToString("0.00") + "</font>");
                        cell.Text = strBld.ToString();
                        cell.BackColor = System.Drawing.Color.White;
                        if (flag == false)
                        {
                            flag = true;
                        }
                    }
                    if (flag == true)  
                    {
                        strBld.Remove(0,strBld.Length);
                        strBld.AppendFormat("<font color='#660066'>Page Total{0}", "</font><br/>");
                        strBld.AppendFormat("<font color='#990033'>Grand Total</font>");
                        e.Row.Cells[i - 1].Text = strBld.ToString();
                        e.Row.Cells[i - 1].BackColor = System.Drawing.Color.White;
                        e.Row.Cells[i - 1].HorizontalAlign = HorizontalAlign.Right;

                        flag = null;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound, BillWiseDeptWiseCollectionSummary", ex);
        }
    }
   
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate, tDate;
            DateTime.TryParse(txtFDate.Text,out fDate);
            DateTime.TryParse(txtTDate.Text,out tDate);

            returnCode = new Report_BL(base.ContextInfo).GetBillWiseDeptWiseCollection(fDate, tDate, OrgID, 0, visitType, out lstDWCR, out pTotalItemAmt, out pTotalDiscount, out pTotalReceivedAmt, out pTotalDue, out pTax, out pServiceCharge, "0");
            
            #region Old Snipp

            //List<BillDeptWiseCollections> lstResult = lstDWCR
            //.GroupBy(c => new { c.BillNumber, c.PatientName, c.Age, c.VisitDate, c.VisitType })
            //.Select(g => new BillDeptWiseCollections
            //{
            //    BillNumber = g.Key.BillNumber,
            //    PatientName = g.Key.PatientName + g.Key.Age,
            //    VisitDate = g.Key.VisitDate,
            //    VisitType = g.Key.VisitType,
            //    ConsultationFee = g.Where(c => c.FeeType == "Consultation").Sum(c => c.BilledAmount),
            //    ImagingFee = g.Where(c => c.FeeType == "Imaging").Sum(c => c.BilledAmount),
            //    LabFee = g.Where(c => c.FeeType == "Lab").Sum(c => c.BilledAmount),
            //    PharmacyFee = g.Where(c => c.FeeType == "Pharmacy").Sum(c => c.BilledAmount),
            //    ProcedureFee = g.Where(c => c.FeeType == "Procedure").Sum(c => c.BilledAmount)
            //})
            //.ToList();

            #endregion

            var lstResult = lstDWCR
                            .GroupBy(c => new { c.BillNumber, c.PatientName, c.Age, c.VisitDate, c.VisitType })
                            .Select(g => new 
                            {
                                BillNumber = g.Key.BillNumber,
                                PatientName = g.Key.PatientName + g.Key.Age,
                                VisitDate = g.Key.VisitDate,
                                VisitType = g.Key.VisitType,
                                Consultation = g.Where(c => c.FeeType == "Consultation").Sum(c => c.BilledAmount),
                                XRay = g.Where(c => c.FeeType == "X-Ray").Sum(c => c.BilledAmount),
                                Lab = g.Where(c => c.FeeType == "Lab").Sum(c => c.BilledAmount),
                                Pharmacy = g.Where(c => c.FeeType == "Pharmacy").Sum(c => c.BilledAmount),
                                CT = g.Where(c => c.FeeType == "CT").Sum(c => c.BilledAmount),
                                Physiotherapy = g.Where(c => c.FeeType == "Physiotherapy").Sum(c => c.BilledAmount),
                                Dialysis = g.Where(c => c.FeeType == "Dialysis").Sum(c => c.BilledAmount),
                                USG = g.Where(c => c.FeeType == "USG").Sum(c => c.BilledAmount),
                                Endoscopy = g.Where(c => c.FeeType == "Endoscopy").Sum(c => c.BilledAmount),
                                TMT = g.Where(c => c.FeeType == "TMT").Sum(c => c.BilledAmount),

                                RadiationTherapy = g.Where(c => c.FeeType == "Radiation Therapy").Sum(c => c.BilledAmount),
                              
                                Others = g.Where(c => c.FeeType != "Consultation" && c.FeeType != "X-Ray"
                                                                         && c.FeeType != "Lab"
                                                                         && c.FeeType != "Pharmacy"
                                                                         && c.FeeType != "CT"
                                                                         && c.FeeType != "Physiotherapy"
                                                                         && c.FeeType != "Dialysis"
                                                                         && c.FeeType != "USG"
                                                                         && c.FeeType != "Endoscopy"
                                                                         && c.FeeType != "Indents"
                                                                         && c.FeeType != "General"
                                                                         && c.FeeType != "Room"
                                                                         && c.FeeType != "Endoscopy"
                                                                         && c.FeeType != "Surgery Items"
                                                                         && c.FeeType != "ECG"
                                                                         && c.FeeType != "Radiation Therapy"
                                                                         && c.FeeType != "MRI").Sum(c => c.BilledAmount),
                                Indents = g.Where(c => c.FeeType == "Indents").Sum(c => c.BilledAmount),
                                General = g.Where(c => c.FeeType == "General").Sum(c => c.BilledAmount),
                                Room = g.Where(c => c.FeeType == "Room").Sum(c => c.BilledAmount),
                                SurgeryItems = g.Where(c => c.FeeType == "Surgery Items").Sum(c => c.BilledAmount),
                                ECG = g.Where(c => c.FeeType == "ECG").Sum(c => c.BilledAmount),
                                MRI = g.Where(c => c.FeeType == "MRI").Sum(c => c.BilledAmount)

                               
                            })
                            .ToList();

            DataTable dt; 
            Utilities.ConvertFrom(lstResult, out dt);
            DataView  dv = dt.AsDataView();
            List<string> cusCol = new List<string>();

            foreach (ListItem item in chkColumns.Items)
            {
                if(item.Selected)
                {
                    if (item.Value == "X-Ray")
                    {
                        item.Value = "XRay";
                    }
                    else if (item.Value == "Surgery Items")
                    {
                        item.Value = "SurgeryItems";
                    }

                    //else if (item.Value == "RadiationTherapy")
                    //{
                    //    item.Value = "RadiationTherapy";
                    //}
                    if (dt.Columns.Contains(item.Value))
                    {
                        cusCol.Add(item.Value);
                    }
                }
            }
           
            cusCol.InsertRange(0, Enum.GetNames(typeof(StaticColumns)).ToList());
            DataTable dtnew = dv.ToTable(true, cusCol.ToArray());
            
            if (dtnew.Rows.Count > 0)
            {
                getFooterInitVal(cusCol.ToArray());
                getGrandTotalInitVal(cusCol.ToArray(),dtnew);
                //DataTable dt = loaddata(lstResult);
                ds.Tables.Add(dtnew);
                ViewState["report"] = ds;
                hdnXLFlag.Value = "1";
                gvIPReport.DataSource = dtnew;
                gvIPReport.DataBind();
                gvIPReport.Visible = true;
            }
            else
            {
                gvIPReport.DataSource = null;
                gvIPReport.DataBind();
                ViewState.Remove("report");
                hdnXLFlag.Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, BillWiseDeptWiseCollectionSummary", ex);
        }
    }

    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ViewReportList.aspx", true);
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

    protected void gvIPReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvIPReport.PageIndex = e.NewPageIndex;
            btnSubmit_Click(sender, e);
        }
    }

    protected void lnkExportXL_Click(object sender, EventArgs e)
    {
        try
        {
            //export to excel
            string prefix = string.Empty;
            prefix = "BillWiseDeptWiseCollectionSummary_Reports_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            DataSet dsrpt = (DataSet)ViewState["report"];
            Dictionary<string, decimal> GrandTotalExcel = new Dictionary<string, decimal>();
            DataRow dr = dsrpt.Tables[0].NewRow();

            GrandTotalExcel = (Dictionary<string, decimal>)ViewState["grandTotal"];

            string strTemp = string.Empty;
            bool? flag = true;
            
            foreach (TableCell item in gvIPReport.HeaderRow.Cells)
            {
                if (Enum.GetNames(typeof(StaticColumns)).Contains(item.Text))
                {
                    dr[item.Text] = DBNull.Value;
                    strTemp = item.Text;
                }
                else
                {
                    if (flag==true)
                    {
                        dr[strTemp] = "Grand Total";
                        flag = false;
                    }
                    if (dsrpt.Tables[0].Columns.Contains(item.Text))
                    {
                        dr[item.Text] = GrandTotalExcel[item.Text];
                    }
                }
            }
            dsrpt.Tables[0].Rows.Add(dr);

            if (dsrpt != null)
            {
                ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('Please Generate The Report First');", true);
            }
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, BillWiseDeptWiseCollectionSummary", ex);
        }
    }

    protected void lnkBtnSaveTemplate_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            if (chkColumns != null)
            {
                StringBuilder strBulider = new StringBuilder();
                foreach (ListItem item in chkColumns.Items)
                {
                    if (item.Selected)
                        strBulider.AppendFormat("<Column>{0}</Column>", item.Value);
                }
                
                if (strBulider.Length == 0)
                {
                    returnCode = new Report_BL(base.ContextInfo).SaveReportProfile(OrgID, Convert.ToInt64(Request.QueryString["ReportID"]), string.Empty, "");
                }
                else
                {
                    strBulider.Replace(strBulider.ToString(), "<Reports>" + strBulider.ToString() + "</Reports>");
                    returnCode = new Report_BL(base.ContextInfo).SaveReportProfile(OrgID, Convert.ToInt64(Request.QueryString["ReportID"]), strBulider.ToString(), "");
                }
                if (returnCode != -1)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "TemplateSavedSuccessfully", "javascript:alert('Template Saved Successfully.');", true);
                }
            }
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in SaveTemplate, BillWiseDeptWiseCollectionSummary", ex);
        }
    }

    protected void lnkBtnShowColumns_Click(object sender, EventArgs e)
    {
        #region UnUsed
        //if (pnlColumns.Visible == false)
        //{
        //    pnlColumns.Visible = true;
        //    lnkBtnShowColumns.Text = "Hide";
        //    lnkBtnSaveTemplate.Visible = true;
        //}
        //else
        //{
        //    pnlColumns.Visible = false;
        //    lnkBtnShowColumns.Text = "Show";
        //    lnkBtnSaveTemplate.Visible = false;
        //}
        #endregion
    }

    protected void lnkBtnRefresh_Click(object sender, EventArgs e)
    {
        DataSet dsrpt = new DataSet();
        dsrpt = (DataSet)ViewState["report"];
        divPrintNew.InnerHtml = BuildTable((DataTable)dsrpt.Tables[0]);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "printPopup", "javascript:printPopUp('" + divPrintNew.ClientID + "');", true);
    }

    public string BuildTable(DataTable dt)
    {
        StringBuilder result = new StringBuilder();
        try
        {
            result.AppendLine("<style>" +
                                "table.rptTable   { border-bottom-style:dashed;" +
                                                   "border-top-style:dashed;" +
                                                   "border-left-style:dashed;" +
                                                   "border-color:black;" +
                                                   "border-width:thin;" +
                                                   "cellspacing:5 ;cellpadding:3;}" +
                                "td.rptCell        { border-right-style:dashed;" +
                                                    "border-width:thin;" +
                                                    "border-color:black;} " +
                                "th.rptHead        { border-bottom-style:dashed;" +
                                                    "border-right-style:dashed;" +
                                                    "border-width:thin;" +
                                                    "border-color:black;} " +
                                "tr.rptFoot     { border-top-style:dashed;" +
                                                    "border-right-style:dashed;" +
                                                    "border-width:thin;" +
                                                    "border-color:black;} " +
                                "</style>");
            foreach (DataColumn col in dt.Columns)
            {
                result.AppendFormat("<th class='rptHead'>{0}</th>", col.ColumnName);
            }

            result.Replace(result.ToString(), "<thead><tr>" + result.ToString().Trim() + "</tr></thead>");

            StringBuilder strBuilder = new StringBuilder();
            Dictionary<string, decimal> PrintTotal = new Dictionary<string, decimal>();
            PrintTotal = (Dictionary<string, decimal>)ViewState["grandTotal"];
            string strFooter = string.Empty;
            bool flag = true;
            foreach (DataRow row in dt.Rows)
            {
                string strData = string.Empty;
                foreach (DataColumn col in dt.Columns)
                {
                    strData += "<td class='rptCell'>" + row[col.ColumnName].ToString() + "</td>";
                    if (flag == true)
                    {
                        if (PrintTotal.ContainsKey(col.ColumnName))
                        {
                            strFooter += "<td class='rptCell'>" + PrintTotal[col.ColumnName].ToString() + "</td>";
                        }
                        else
                        {
                            strFooter += "<td class='rptCell'></td>";
                        }
                    }
                }
                flag = false;
                strBuilder.AppendFormat("<tr class='rptRow'>" + strData + "</tr>");
            }
            strBuilder.Replace(strBuilder.ToString(), "<tbody>" + strBuilder.ToString() + "</tbody>");
            result.AppendFormat(strBuilder.ToString());
            result.AppendFormat("<tfoot><tr class='rptFoot'>{0}</tr></tfoot>", strFooter);
            result.Replace(result.ToString(), "<table width='100%' class='rptTable'>" + result.ToString() + "</table>");

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Print report, BillWiseDeptWiseCollectionSummary", ex);
        }
        return result.ToString();
    }
}
