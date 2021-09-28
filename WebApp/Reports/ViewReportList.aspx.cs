using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.XPath;
using System.IO;
using Attune.Podium.ExcelExportManager;
using OfficeOpenXml;
using Excel;
using System.Text;
using System.Data.SqlClient;
using ReportBusinessLogic;

public partial class Reception_ReportSampleDisplay :BasePage
{
    #region Variable Declerations
    List<GetReportDetails> lstGroupItems = new List<GetReportDetails>();
    List<GetReportDetails> lstReportItems = new List<GetReportDetails>();
    long iUserTypeID = 0;
    long iOrgID = 0;
    Report_BL objreportBL;
    ReportBusinessLogic.ReportExcel_BL objreportExcelBL;
    long iReturnID = 0;

    List<OrganizationAddress> lstLcation = new List<OrganizationAddress>();
    List<GetReportDetails> listReportItems = new List<GetReportDetails>();
    int pExcelReportId = 0;
    string pExcelReportName = string.Empty;
    string pToExecute = "N";
    DataSet ds = new DataSet();
    const int rowLimit = 65000;

    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        DateTime fdate = Convert.ToDateTime("1/1/1753 12:00:00 AM");
        DateTime Tdate = Convert.ToDateTime("1/1/1753 12:00:00 AM");
        objreportBL = new Report_BL(base.ContextInfo);
        objreportExcelBL = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo);
        iUserTypeID = RoleID;
        iOrgID = OrgID;
        iReturnID = objreportBL.GetReportItems(iUserTypeID, iOrgID, out lstGroupItems, out lstReportItems);
        BindDynamicDatas(lstGroupItems,lstReportItems);
        iReturnID = objreportExcelBL.GetExportReportItems(fdate, Tdate,pExcelReportId, pExcelReportName, pToExecute, OrgID, out listReportItems, out ds);
        BindDynamicDats(listReportItems);
        if (listReportItems.Count <= 0)
        {
            tblRooms.Attributes.Add("Style", "display:none");
        }
        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            if ((RoleName == RoleHelper.MRO) && (RoleName == RoleHelper.Admin))
            {
                tdMRDSnapShot.Visible = true;
            }
        }
    }
    protected void BindDynamicDatas(List<GetReportDetails> lstGroupItems,List<GetReportDetails> lstReportItems)
    {
        int i = 0;
        foreach (GetReportDetails gGroupItem in lstGroupItems)
        {
            var ReportsDatas = from Reports in lstReportItems
                             where Reports.ReportGroupID == gGroupItem.ReportGroupID
                             select Reports;
            if (ReportsDatas.Count() > 0)
            {
                Control cntrlReport = LoadControl("~/CommonControls/ReportDisplay.ascx");
                UserControl ucntrlReport = (UserControl)cntrlReport;
                ucntrlReport.ID = "uctrlReports" + gGroupItem.ReportGroupID;
                ucntrlReport.Attributes.Add("Runat", "Server");
                divReportControls.Controls.AddAt(i, ucntrlReport);
                i++;
                DataList dlReports = (DataList)ucntrlReport.FindControl("dlReports");
                Label lblGroupName = (Label)ucntrlReport.FindControl("lblGroup");

                lblGroupName.Text = gGroupItem.ReportGroupText;

                foreach (GetReportDetails item in ReportsDatas)
                {
                    item.RedirectURL = Request.ApplicationPath + item.RedirectURL;
                }

                dlReports.DataSource = ReportsDatas;
                dlReports.DataBind();
            }
        }
    }
    protected void BindDynamicDats(List<GetReportDetails> listReportItems)
    {
        foreach (GetReportDetails item in listReportItems)
        {
            dlsReports.DataSource = listReportItems;
            dlsReports.DataBind();
        }
    }

    protected void butn_Click(object sender, EventArgs e)
    {
        try
        {
            string strnodata= Resources.RoomManagement_AppMsg.RoomManagement_RoomAndBedBooking_aspx_24 == null ? "Data Not Found" : Resources.RoomManagement_AppMsg.RoomManagement_RoomAndBedBooking_aspx_24;
            LinkButton button = (LinkButton)sender;
            pExcelReportId = Convert.ToInt16(button.CommandName);
            pExcelReportName = button.Text;
            pToExecute = "Y";
            DateTime fdate = Convert.ToDateTime("1/1/1753 12:00:00 AM");
            DateTime Tdate = Convert.ToDateTime("1/1/1753 12:00:00 AM"); 
            DateTime.TryParse(txtFDate.Text, out fdate);
            DateTime.TryParse(txtTDate.Text, out Tdate); 
            iReturnID = objreportExcelBL.GetExportReportItems(fdate, Tdate,pExcelReportId, pExcelReportName, pToExecute, OrgID, out listReportItems, out ds);
           // string rptDate = "Op_Stat" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            string rptDate = pExcelReportName + ".xls";
            if (ds.Tables.Count >0 && ds.Tables[0].Rows.Count != 0)
            {
            ToExcel(ds, rptDate, Page.Response);
            }
            else
            {
              //  ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:Alert('Data Not Found');", true);

                 ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alt", "alert('" + strnodata + "'); ", true);
            }
            // string path = ConvertToExcel(ds);
            //lblPath.Text = "Successfully saved in the path '" + path + "' ";
            //lblPath.Visible = true;
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, HourlyStatReport", ex);
        }
    }
    public static void ToExcel(DataSet dsInput, string filename, HttpResponse response)
    {
        var excelXml = GetExcelXml(dsInput, filename);
        response.Clear();
       // response.AppendHeader("Content-Type", "application/vnd.ms-excel");
	response.AppendHeader("Content-Type", "application/csv");
        response.AppendHeader("Content-disposition", "attachment; filename=" + filename);
        response.Write(excelXml);
        response.Flush();
        response.End();
    }
    public static string GetExcelXml(DataSet dsInput, string filename)
    {
        var excelTemplate = getWorkbookTemplate();
        var worksheets = getWorksheets(dsInput);
        var excelXml = string.Format(excelTemplate, worksheets);
        return excelXml;
    }

    private static string getWorkbookTemplate()
    {
        var sb = new StringBuilder(818);
        sb.AppendFormat(@"<?xml version=""1.0""?>{0}", Environment.NewLine);
        sb.AppendFormat(@"<?mso-application progid=""Excel.Sheet""?>{0}", Environment.NewLine);
        sb.AppendFormat(@"<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet""{0}", Environment.NewLine);
        sb.AppendFormat(@"xmlns:o=""urn:schemas-microsoft-com:office:office""{0}", Environment.NewLine);
        sb.AppendFormat(@"xmlns:x=""urn:schemas-microsoft-com:office:excel""{0}", Environment.NewLine);
        sb.AppendFormat(@"xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet""{0}", Environment.NewLine);
        sb.AppendFormat(@"xmlns:html=""http://www.w3.org/TR/REC-html40"">{0}", Environment.NewLine);
        sb.AppendFormat(@"<Styles>{0}", Environment.NewLine);
        sb.AppendFormat(@"<Style ss:ID=""Default"" ss:Name=""Normal"">{0}", Environment.NewLine);
        sb.AppendFormat(@"<Alignment ss:Vertical=""Bottom""/>{0}", Environment.NewLine);
        sb.AppendFormat(@"<Borders/>{0}", Environment.NewLine);
        sb.AppendFormat(@"<Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""10"" ss:Color=""#000000""/>{0}", Environment.NewLine);
        sb.AppendFormat(@"<Interior/>{0}", Environment.NewLine);
        sb.AppendFormat(@"<NumberFormat/>{0}", Environment.NewLine);
        sb.AppendFormat(@"<Protection/>{0}", Environment.NewLine);
        sb.AppendFormat(@"</Style>{0}", Environment.NewLine);
        sb.AppendFormat(@"<Style ss:ID=""s62"">{0}", Environment.NewLine);
        sb.AppendFormat(@"<Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""12"" ss:Color=""#000000""{0}", Environment.NewLine);
        sb.AppendFormat(@"ss:Bold=""1""/>{0}", Environment.NewLine);
        sb.AppendFormat(@"</Style>{0}", Environment.NewLine);
        sb.AppendFormat(@"<Style ss:ID=""s64"">{0}", Environment.NewLine);
        sb.AppendFormat(@"<Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""13"" ss:Color=""#000000""{0}", Environment.NewLine);
        sb.AppendFormat(@"/>{0}", Environment.NewLine);
        sb.AppendFormat(@"</Style>{0}", Environment.NewLine);
        sb.AppendFormat(@"<Style ss:ID=""s63"">{0}", Environment.NewLine);
        sb.AppendFormat(@"<NumberFormat ss:Format=""Short Date""/>{0}", Environment.NewLine);
        sb.AppendFormat(@"</Style>{0}", Environment.NewLine);
        sb.AppendFormat(@"</Styles>{0}", Environment.NewLine);
        sb.Append(@"{0}\r\n</Workbook>");
        return sb.ToString();
    }
    private static string getWorksheets(DataSet source)
    {

        var sw = new StringWriter();
        if (source == null || source.Tables.Count == 0)
        {
            sw.Write("<Worksheet ss:Name=\"Sheet1\">\r\n<Table>\r\n<Row><Cell><Data ss:Type=\"String\"></Data></Cell></Row>\r\n</Table>\r\n</Worksheet>");
            return sw.ToString();
        }
        foreach (DataTable dt in source.Tables)
        {
            string SheetName = dt.Rows[0].ItemArray[0].ToString();
            dt.Columns.RemoveAt(0);
            if (dt.Rows.Count == 0)
                sw.Write("<Worksheet ss:Name=\"" + replaceXmlChar(SheetName) + "\">\r\n<Table>\r\n<Row><Cell  ss:StyleID=\"s62\"><Data ss:Type=\"String\"></Data></Cell></Row>\r\n</Table>\r\n</Worksheet>");
            else
            {
                //write each row data                
                var sheetCount = 0;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if ((i % rowLimit) == 0)
                    {
                        //add close tags for previous sheet of the same data table
                        if ((i / rowLimit) > sheetCount)
                        {
                            sw.Write("\r\n</Table>\r\n</Worksheet>");
                            sheetCount = (i / rowLimit);
                        }
                        sw.Write("\r\n<Worksheet ss:Name=\"" + replaceXmlChar(SheetName) +
                                 (((i / rowLimit) == 0) ? "" : Convert.ToString(i / rowLimit)) + "\">\r\n<Table>");
                        //write column name row
                        if (i == 0)
                        {
                            sw.Write("\r\n<Row><Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\"> " + SheetName + " Report Date :" + Convert.ToDateTime(new BasePage().OrgDateTimeZone) + "</Data></Cell></Row>\r\n<Row>");
                        }
                        else
                        {
                            sw.Write("\r\n<Row>");
                        }
                        foreach (DataColumn dc in dt.Columns)
                            sw.Write(string.Format("<Cell ss:StyleID=\"s62\"><Data ss:Type=\"String\">{0}</Data></Cell>", replaceXmlChar(dc.ColumnName)));
                        sw.Write("</Row>");
                    }
                    sw.Write("\r\n<Row>");

                    foreach (DataColumn dc in dt.Columns)
                    {
                        sw.Write(getCell(dc.DataType, dt.Rows[i][dc.ColumnName], dc.ColumnName));

                    }
                    sw.Write("</Row>");
                }
                sw.Write("\r\n</Table>\r\n</Worksheet>");
            }
        }
        return sw.ToString();
    }
    private static string replaceXmlChar(string input)
    {
        input = input.Replace("&", "&amp");
        input = input.Replace("<", "&lt;");
        input = input.Replace(">", "&gt;");
        input = input.Replace("\"", "&quot;");
        input = input.Replace("'", "&apos;");
        return input;
    }

    private static string getCell(Type type, object cellData, string ColumnName)
    {

        var data = (cellData is DBNull) ? "" : cellData;

        if (type.Name.Contains("Int") || type.Name.Contains("Double") || type.Name.Contains("Decimal"))
        {
            if (ColumnName == "EntryHour")
            {
                return string.Format("<Cell><Data ss:Type=\"String\">{0}</Data></Cell>", data + ":00 hr");
            }
            else
            {
                if (data.Equals(0))
                {

                    return string.Format("<Cell><Data ss:Type=\"String\">{0}</Data></Cell>", "-");
                }
                else
                {
                    return string.Format("<Cell><Data ss:Type=\"Number\">{0}</Data></Cell>", data);
                }
            }
        }
        if (type.Name.Contains("Date") && data.ToString() != string.Empty)
        {
            return string.Format("<Cell ss:StyleID=\"s63\"><Data ss:Type=\"DateTime\">{0}</Data></Cell>", Convert.ToDateTime(data).ToString("yyyy-MM-dd"));
        }
        return string.Format("<Cell><Data ss:Type=\"String\">{0}</Data></Cell>", replaceXmlChar(data.ToString()));

    }
    //public string ConvertToExcel(DataSet ds)
    //{
    //    string FilePath;
    //    Microsoft.Office.Interop.Excel.ApplicationClass ExcelApp = new Microsoft.Office.Interop.Excel.ApplicationClass();
    //    ExcelApp.Application.Workbooks.Add(Type.Missing);
    //    Microsoft.Office.Interop.Excel.Worksheet Sheet1 = null;
    //    try
    //    {
    //        for (int k = 1; k <= ds.Tables.Count; k++)
    //        {
    //            DataTable dt = ds.Tables[k - 1];
    //            Sheet1 = (Microsoft.Office.Interop.Excel.Worksheet)ExcelApp.Sheets[k];
    //            Sheet1.Name = dt.Rows[0].ItemArray[0].ToString();
    //            dt.Columns.RemoveAt(0);
    //            Sheet1.Cells[1, 0 + 1] = "" + Sheet1.Name + " Report Date :" + Convert.ToDateTime(new BasePage().OrgDateTimeZone) + "";
    //            // Excel header row
    //            Microsoft.Office.Interop.Excel.Range Top = ExcelApp.get_Range(Sheet1.Cells[1, 0 + 1], Sheet1.Cells[1, 0 + 1]);
    //            Sheet1.Columns.Borders.Value = 0;
    //            Top.Font.Size = 10;
    //            Top.Font.Bold = true;
    //            for (int i = 0; i < dt.Columns.Count; i++)
    //            {
    //                Sheet1.Cells[2, i + 1] = dt.Columns[i].ColumnName; // Sheet name
    //                Microsoft.Office.Interop.Excel.Range headerRange = ExcelApp.get_Range(Sheet1.Cells[2, i + 1], Sheet1.Cells[2, i + 1]);
    //                headerRange.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter;
    //                headerRange.VerticalAlignment = Microsoft.Office.Interop.Excel.XlVAlign.xlVAlignBottom;
    //                headerRange.UseStandardHeight = 10;
    //                headerRange.ShrinkToFit = true;
    //                if (i == 0)
    //                {
    //                    headerRange.Font.Bold = true;
    //                    headerRange.ColumnWidth = 10;
    //                }
    //                if (i != 0)
    //                {
    //                    headerRange.ColumnWidth = 5;
    //                    headerRange.Orientation = 90;
    //                }
    //                headerRange.Font.Size = 12;
    //            }

    //            for (int i = 0; i < dt.Rows.Count; i++)
    //            {
    //                for (int j = 0; j < dt.Columns.Count; j++)
    //                {
    //                    if ((j == 0) && (Convert.ToString(dt.Columns[j]) == "EntryHour"))
    //                    {
    //                        Sheet1.Cells[i + 3, j + 1] = dt.Rows[i][j].ToString() + ":00 hr";
    //                    }
    //                    else
    //                    {
    //                        if (dt.Rows[i][j].ToString() == "0")
    //                        {
    //                            Sheet1.Cells[i + 3, j + 1] = "-";
    //                        }
    //                        else
    //                        {
    //                            Sheet1.Cells[i + 3, j + 1] = dt.Rows[i][j].ToString();
    //                        }
    //                    }
    //                    Microsoft.Office.Interop.Excel.Range bodyRange = ExcelApp.get_Range(Sheet1.Cells[i + 3, j + 1], Sheet1.Cells[i + 3, j + 1]);
    //                    bodyRange.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter;
    //                    bodyRange.Font.Size = 10;
    //                }
    //            }

    //        }
    //    }
    //    catch (System.Threading.ThreadAbortException ex)
    //    {
    //        CLogger.LogError("Error in Convert to XL, HourlyStatReport", ex);
    //    }
    //    FilePath = "d:\\'" + "OP_Stats_" + Guid.NewGuid() + ".xls";
    //    if (FilePath != string.Empty)
    //    {
    //        ExcelApp.ActiveWorkbook.SaveAs(FilePath, Microsoft.Office.Interop.Excel.XlFileFormat.xlExcel5, null, null, false, false, Microsoft.Office.Interop.Excel.XlSaveAsAccessMode.xlNoChange, null, null, null, null, null);
    //        ExcelApp.ActiveWorkbook.Saved = true;
    //        ExcelApp.Quit();
    //    }
    //    return FilePath;
    //}

    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    public void DataTableToExcel(DataTable dt, string Filename)
    {
        MemoryStream ms = DataTableToExcelXlsx(dt, "Sheet1");
        ms.WriteTo(HttpContext.Current.Response.OutputStream);
        HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=" + Filename);
        HttpContext.Current.Response.StatusCode = 200;
        HttpContext.Current.Response.End();
    }

    public static MemoryStream DataTableToExcelXlsx(DataTable table, string sheetName)
    {
        MemoryStream result = new MemoryStream();
        ExcelPackage excelpack = new ExcelPackage();
        ExcelWorksheet worksheet = excelpack.Workbook.Worksheets.Add(sheetName);
        int col = 1;
        int row = 1;
        foreach (DataColumn column in table.Columns)
        {
            worksheet.Cells[row, col].Value = column.ColumnName.ToString();
            col++;
        }
        col = 1;
        row = 2;
        foreach (DataRow rw in table.Rows)
        {
            foreach (DataColumn cl in table.Columns)
            {
                if (rw[cl.ColumnName] != DBNull.Value)
                    worksheet.Cells[row, col].Value = rw[cl.ColumnName].ToString();
                col++;
            }
            row++;
            col = 1;
        }
        excelpack.SaveAs(result);
        return result;
    }

    protected void Item_Bound(Object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            HiddenField objhdnShowDatePopup = (HiddenField)e.Item.FindControl("hdnShowDatePopup");
            if (objhdnShowDatePopup.Value == "ShowDateRangePopup")
            {
                GetReportDetails obj = (GetReportDetails)e.Item.DataItem;
                LinkButton objLinkButton = (LinkButton)e.Item.FindControl("lnkpros");
                objLinkButton.OnClientClick = "javascript:return fnShowPOPup('" + obj.ReportID + "','" + obj.ReportDisplayText + "')";
            }


        }
    }


    protected void btn_Click(object sender, EventArgs e)
    {
        try
        {

            pExcelReportId = Convert.ToInt16(hdnRptID.Value);
            pExcelReportName = hdnRptName.Value;
            pToExecute = "Y";
            DateTime fdate, Tdate;

            //int dOrgid = 0;
            //dOrgid = Int32.Parse(ddlTrustedOrg.SelectedValue);

            DateTime.TryParse(txtFDate.Text, out fdate);
            DateTime.TryParse(txtTDate.Text, out Tdate);

            iReturnID = objreportExcelBL.GetExportReportItems(fdate, Tdate, pExcelReportId, pExcelReportName, pToExecute, OrgID, out listReportItems, out ds);
            string rptDate = pExcelReportName + ".xlsx";
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count != 0)
            {
                //ToExcel(ds, rptDate, Page.Response);
              DataTableToExcel(ds.Tables[0], rptDate);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Data Not Found');", true);
            }

            
             
            hdnRptName.Value = "";
            hdnRptID.Value = "";

        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, HourlyStatReport", ex);
        }
    }

}
