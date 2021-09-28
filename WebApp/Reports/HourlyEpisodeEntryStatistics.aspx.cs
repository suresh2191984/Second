using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Data;
using System.Globalization;
using System.Linq;
using ReportBusinessLogic;
using System.IO;
using System.Web;
using OfficeOpenXml;
using Excel;
using System.Text;
using Attune.Podium.ExcelExportManager;
using ReportBusinessLogic;

public partial class Reports_HourlyBasedStatsReport : BasePage 
{

    DataSet _dsHourly = new DataSet();
    const int rowLimit = 65000;
    string OrgTimeZone = string.Empty;
   
    protected void Page_Load(object sender, EventArgs e)
    {

    }    
    protected void btnExportXL_Click(object sender, EventArgs e)
    {
        try
        {
          
            DateTime FromDate = Convert.ToDateTime(txtFrom.Text);
            DateTime ToDate = Convert.ToDateTime(txtTo.Text);
            int pOrgID = OrgID;
            long result = -1;
            ReportBusinessLogic.ReportExcel_BL objReportExcel = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo);
            result = objReportExcel.GetHourlyEpisodeStatReport(pOrgID, Convert.ToDateTime(FromDate), Convert.ToDateTime(ToDate), out _dsHourly);
            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

            if (!String.IsNullOrEmpty(OrgDateTimeZone) && OrgTimeZone.Length > 0)
            {
                OrgTimeZone = OrgDateTimeZone;
               
            }

            string rptDate = "Hourly Episode Entry Statistics" + FromDate + "Between" + ToDate + ".xls";
            ToExcel(_dsHourly, rptDate, Page.Response,FromDate ,ToDate );
            
            
            //string prefix = string.Empty;
            //prefix = "Hourly_Episode_Entry_Report";
            //string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xml";
            //ExcelHelper.ToExcel(_dsHourly, rptDate, Page.Response);
      
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, HourlyStatReport", ex);
        }
    }

   
    public static void ToExcel(DataSet dsInput, string filename, HttpResponse response, DateTime FromDate, DateTime ToDate)
    {
        var excelXml = GetExcelXml(dsInput, filename,FromDate ,ToDate );
        response.Clear();
        response.AppendHeader("Content-Type", "application/vnd.ms-excel");
        response.AppendHeader("Content-disposition", "attachment; filename=" + filename);
        response.Write(excelXml);
        response.Flush();
        response.End();
    }
    public static string GetExcelXml(DataSet dsInput,string filename, DateTime FromDate, DateTime ToDate)
    {
        var excelTemplate = getWorkbookTemplate();
        var worksheets = getWorksheets(dsInput,FromDate,ToDate );
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
    public static string getWorksheets(DataSet source,DateTime FromDate, DateTime ToDate)
    {
        
        string OrgTimeZone = string.Empty;
        OrgTimeZone = HttpContext.Current.Session["OrgTimeZone"].ToString();
        OrgTimeZone = (TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, TimeZoneInfo.FindSystemTimeZoneById(OrgTimeZone))).ToString("dd-MM-yyyy HH:mm:ss");
        var sw = new StringWriter();

        if (source == null || source.Tables.Count == 0)
        {
            sw.Write("<Worksheet ss:Name=\"Sheet1\">\r\n<Table>\r\n<Row><Cell><Data ss:Type=\"String\"></Data></Cell></Row>\r\n</Table>\r\n</Worksheet>");
            return sw.ToString();
        }
        foreach (DataTable dt in source.Tables)
        {
            if (dt.Rows.Count > 0)
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
                                sw.Write("\r\n<Row><Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\"> " + SheetName + " Report Date :" + FromDate + "Between" + ToDate + "</Data></Cell></Row>\r\n<Row>");
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
    

    public override void VerifyRenderingInServerForm(Control control)
    {      

    }
   
   
}
