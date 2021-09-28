<%@ WebHandler Language="C#" Class="MasteruploadExportToExcelHandler" %>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Xml;
using Attune.Podium.Common;
using System.IO;
using System.Drawing;
using System.ComponentModel;
using System.Web.SessionState;
using System.Data;
using System.Text;
public class MasteruploadExportToExcelHandler : IHttpHandler, IReadOnlySessionState
{
    BasePage Bp = new BasePage();
    public void ProcessRequest(HttpContext context)
    {
        string filetype = string.Empty;
        string ratetext = string.Empty;
        string type = string.Empty;
        int OrgID = 0, Rateids = 0, LID = 0;
        string OrgName = string.Empty;
        if (context.Request.QueryString["FileType"] != null)
        {
            filetype = context.Request.QueryString["FileType"].ToString();
            filetype = filetype.Trim();
        }
        if (context.Request.QueryString["Type"] != null)
        {
            type = context.Request.QueryString["Type"].ToString();
            type = type.Trim();
        }

        if (context.Request.QueryString["OrgID"] != null)
        {
            OrgID = Convert.ToInt32(context.Request.QueryString["OrgID"]);
        }
        if (context.Request.QueryString["LID"] != null)
        {
            LID = Convert.ToInt32(context.Request.QueryString["LID"]);
        }

        if (context.Request.QueryString["RateId"] != null)
        {
            Rateids = Convert.ToInt32(context.Request.QueryString["RateId"]);
        }
        if (context.Request.QueryString["ratetext"] != null)
        {
            ratetext = context.Request.QueryString["ratetext"];
        }
        if (context.Request.QueryString["OrgName"] != null)
        {
            OrgName = context.Request.QueryString["OrgName"];
        }
        DataTable dt = new DataTable();
        long returnCode = -1;
        List<Stage2_MHL_T_01_TESTMASTER> lstInvestigationMaster = new List<Stage2_MHL_T_01_TESTMASTER>();
        List<Stage2_MHL_T_02_GROUP_MASTER> lstinvgroupmaster = new List<Stage2_MHL_T_02_GROUP_MASTER>();
        List<Stage2_MHL_T_03_Package_Master> lstinvgroupmasterPKG = new List<Stage2_MHL_T_03_Package_Master>();
        List<Stage2_MHL_T_04_GROUP_TESTS> lstGroupContent = new List<Stage2_MHL_T_04_GROUP_TESTS>();
        List<Stage2_MHL_T_05_PACKAGE_TESTS> lstPackageContent = new List<Stage2_MHL_T_05_PACKAGE_TESTS>();
        List<Stage2_MHL_T_02_RATE_MASTER> lstRateMaster = new List<Stage2_MHL_T_02_RATE_MASTER>();
        List<PStage_Physician> lstStage_Physician = new List<PStage_Physician>();
        List<Stage_LocationMaster> lstStage_LocationMaster = new List<Stage_LocationMaster>();
        List<DeviceTestOrgMapping> lstDeviceTestMap = new List<DeviceTestOrgMapping>();
        int rateid = 0;
        int lid = Convert.ToInt32(Bp.LID);
        string fileextension = string.Empty;
        if (filetype.Equals("1"))
        {
            fileextension = ".xls";
        }
        else if (filetype.Equals("2"))
        {
            fileextension = ".xlsx";
        }
        else
        {
            fileextension = ".csv";
        }
        Deployability_BL Deployability_BL = new Deployability_BL(new BaseClass().ContextInfo);
        if (type.Equals("InvestigationMaster"))
        {
            type = "INV";
        }
        else if (type.Equals("Group"))
        {
            type = "GRP";
        }
        else if (type.Equals("Package"))
        {
            type = "PKG";
        }
        else if (type.Equals("Package Content"))
        {
            type = "PKGCONTENT";
        }
        else if (type.Equals("RateMaster"))
        {
            type = "RateMaster";
            rateid = Convert.ToInt32(Rateids);
        }
        else if (type.Equals("DeviceTestMap"))
        {
            type = "DeviceTestMap";
        }
	else if (type.Equals("PhysicianMaster"))
        {
            type = "PhysicianMaster";
        }
        else if (type.Equals("LocationMaster"))
        {
            type = "LocationMaster";
        }
        else
        {
            type = "GRPCONTENT";
        }
        returnCode = Deployability_BL.GetRefillTestMasters(OrgID, type, lid, rateid, out  lstInvestigationMaster, out  lstinvgroupmaster, out lstinvgroupmasterPKG, out lstGroupContent, out lstPackageContent, out lstRateMaster, out lstDeviceTestMap, out lstStage_Physician,out lstStage_LocationMaster);
        if (type.Equals("INV"))
        {
            Utilities.ConvertFrom(lstInvestigationMaster, out dt);
        }
        else if (type.Equals("GRP"))
        {
            Utilities.ConvertFrom(lstinvgroupmaster, out dt);
        }
        else if (type.Equals("PKG"))
        {
            Utilities.ConvertFrom(lstinvgroupmasterPKG, out dt);
        }
        else if (type.Contains("PKGCONTENT"))
        {
            Utilities.ConvertFrom(lstPackageContent, out dt);
        }
        else if (type.Contains("GRPCONTENT"))
        {
            Utilities.ConvertFrom(lstGroupContent, out dt);
        }
	 else if (type.Contains("PhysicianMaster"))
        { 
            Utilities.ConvertFrom(lstStage_Physician, out dt);
        }
        else if (type.Contains("LocationMaster"))
        {
            Utilities.ConvertFrom(lstStage_LocationMaster, out dt);
        }
        else if (type.Contains("ClientRateMapping"))
        {
            Utilities.ConvertFrom(lstinvgroupmaster, out dt);
        }
        else if (type.Contains("RateCard"))
        {
            Utilities.ConvertFrom(lstinvgroupmaster, out dt);
        }
        else if (type.Contains("RateMaster"))
        {
            Utilities.ConvertFrom(lstRateMaster, out dt);
        }
        else if (type.Contains("ReferingHospital"))
        {
            Utilities.ConvertFrom(lstinvgroupmaster, out dt);
        }
        else if (type.Contains("RefferingPhysician"))
        {
            Utilities.ConvertFrom(lstinvgroupmaster, out dt);
        }
        else if (type.Contains("DeviceTestMap"))
        {
            Utilities.ConvertFrom(lstDeviceTestMap, out dt);
        }
        else if (type.Contains("RefrenceRange"))
        {
            Utilities.ConvertFrom(lstinvgroupmaster, out dt);
        }
        else
        {
            Utilities.ConvertFrom(lstinvgroupmasterPKG, out dt);
        }

        OrgName = this.GetFirstTenCharacters(OrgName);
        
        if (fileextension.Equals(".csv"))
        { DownloadCSV(dt, type, OrgName, ratetext); }
        else
        {
            ExportToExcel(dt, type, OrgName, ratetext, fileextension);
        }
      
    }
    public string GetFirstTenCharacters(string s)
    {
        // This says "If string s is less than 10 characters, return s.
        // Otherwise, return the first 10 characters of s."
        return (s.Length < 10) ? s : s.Substring(0, 10);
    }
    private void DownloadCSV(DataTable dt, string type, string orgname, string ratename)
    {
        try
        {
            DataTable table = dt;
            bool includeHeader = true;
            string delimiter = ",";
            var result = new StringBuilder();
            HttpResponse Response = HttpContext.Current.Response;
            if (includeHeader)
            {
                foreach (DataColumn column in table.Columns)
                {
                    result.Append(column.ColumnName);
                    result.Append(delimiter);
                }
                result.Remove(--result.Length, 0);
                result.Append(Environment.NewLine);
            }
            foreach (DataRow row in table.Rows)
            {
                foreach (object item in row.ItemArray)
                {
                    if (item is DBNull)
                        result.Append(delimiter);
                    else
                    {
                        string itemAsString = item.ToString();
                        itemAsString = itemAsString.Replace("\"", "\"\"");
                        itemAsString = "\"" + itemAsString + "\"";
                        result.Append(itemAsString + delimiter);
                    }
                }
                result.Remove(--result.Length, 0);
                result.Append(Environment.NewLine);
            }

            //Download the CSV file.
            Response.Clear();
            Response.Buffer = true;
            string Filedate = DateTime.Now.ToString("yyyyMMddHHmmss");//DateTime.Now.Date.ToShortDateString();
            string filename = string.Empty;
            if (type.Equals("RateMaster"))
            {
                filename = orgname + "__" + ratename + "__" + Filedate; //DateTime.Now.ToString("D");//dates.Replace("/", ":").ToString(); 
            }
            else
            {
                filename = orgname + "__" + type + "__" + Filedate; //DateTime.Now.ToString("D");//dates.Replace("/", ":").ToString(); 
            }
            Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".csv");
            Response.Charset = "";
            Response.ContentType = "application/text";
            Response.Output.Write(result);
            Response.Flush();
            Response.End();
        }
        catch (Exception ex)
        {
            CLogger.LogError("DownloadCSV", ex);
        }
    }
  private Table DataTableToHTMLTable(DataTable dt, bool includeHeaders)
    {
        Table tbl = new Table();
        TableRow tr = null;
        TableCell cell = null;

        int rows = dt.Rows.Count;
        int cols = dt.Columns.Count;

        if (includeHeaders)
        {
            TableHeaderRow htr = new TableHeaderRow();
            TableHeaderCell hcell = null;
            for (int i = 0; i < cols; i++)
            {
                hcell = new TableHeaderCell();
                hcell.Text = dt.Columns[i].ColumnName.ToString();
                htr.Cells.Add(hcell);
            }
            tbl.Rows.Add(htr);
        }

        for (int j = 0; j < rows; j++)
        {
            tr = new TableRow();
            for (int k = 0; k < cols; k++)
            {
                cell = new TableCell();
                cell.Text = dt.Rows[j][k].ToString();
                tr.Cells.Add(cell);
            }
            tbl.Rows.Add(tr);
        }
        return tbl;
    }
    private void ExportToExcel(DataTable dt, string type, string orgname, string ratetext, string extension)
    {
        
        
        string Filedate = DateTime.Now.ToString("yyyyMMddHHmmss");
        string filename = string.Empty;
        if (type.Equals("RateMaster"))
        {
            filename = orgname + "__" + ratetext + "__" + Filedate; //DateTime.Now.ToString("D");//dates.Replace("/", ":").ToString(); 
        }
        else
        {
            filename = orgname + "__" + type + "__" + Filedate; //DateTime.Now.ToString("D");//dates.Replace("/", ":").ToString(); 
        }
        
        HttpResponse response = HttpContext.Current.Response;
        BasePage Bp = new BasePage();
        DateTime DTime = new DateTime();
        DTime = Convert.ToDateTime(Bp.OrgDateTimeZone);
        string attachment = "attachment; filename=" + filename + extension;
        response.Clear();
        response.Charset = "";
        response.ContentType = "application/ms-excel";
        response.AddHeader("Content-Disposition", attachment);
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter htmlWriter = new HtmlTextWriter(sw))
            {

                Table table = new Table();
                table = DataTableToHTMLTable(dt, true);
                table.GridLines = GridLines.Horizontal;
                table.BorderWidth = new Unit(1);
                //  table.BackColor = Color.Black;

                if (type.Equals("GRP"))
                {
                    table.Rows[0].Cells[4].ForeColor = Color.Red;
                    table.Rows[0].Cells[6].ForeColor = Color.Red;
                    table.Rows[0].Cells[23].ForeColor = Color.Red;
                    table.Rows[0].Cells[32].ForeColor = Color.Red;
                    table.Rows[0].Cells[33].ForeColor = Color.Red;

                    table.Rows[0].Cells[4].BackColor = Color.Yellow;
                    table.Rows[0].Cells[6].BackColor = Color.Yellow;
                    table.Rows[0].Cells[23].BackColor = Color.Yellow;
                    table.Rows[0].Cells[32].BackColor = Color.Yellow;
                    table.Rows[0].Cells[33].BackColor = Color.Yellow;

                }
                if (type.Equals("PKG"))
                {
                    table.Rows[0].Cells[9].ForeColor = Color.Red;
                    table.Rows[0].Cells[11].ForeColor = Color.Red;
                    table.Rows[0].Cells[26].ForeColor = Color.Red;
                    table.Rows[0].Cells[36].ForeColor = Color.Red;
                    table.Rows[0].Cells[37].ForeColor = Color.Red;

                    table.Rows[0].Cells[9].BackColor = Color.Yellow;
                    table.Rows[0].Cells[11].BackColor = Color.Yellow;
                    table.Rows[0].Cells[26].BackColor = Color.Yellow;
                    table.Rows[0].Cells[36].BackColor = Color.Yellow;
                    table.Rows[0].Cells[37].BackColor = Color.Yellow;

                }
                if (type.Equals("INV"))
                {
                    table.Rows[0].Cells[5].ForeColor = Color.Red;//DISPLAY_NAME
                    table.Rows[0].Cells[6].ForeColor = Color.Red;//DeptName	
                    table.Rows[0].Cells[7].ForeColor = Color.Red;//SECTION_NAME
                    table.Rows[0].Cells[11].ForeColor = Color.Red;//Orderable
                    table.Rows[0].Cells[13].ForeColor = Color.Red;//INPUT_FORMAT
                    table.Rows[0].Cells[14].ForeColor = Color.Red;//Sample_Type
                    table.Rows[0].Cells[16].ForeColor = Color.Red;//Container
                    table.Rows[0].Cells[19].ForeColor = Color.Red;//PROCESSING_LOCATION
                    table.Rows[0].Cells[22].ForeColor = Color.Red;//IS_MACHINE_INTERFACED
                    table.Rows[0].Cells[23].ForeColor = Color.Red;//REPEATABLE
                    table.Rows[0].Cells[25].ForeColor = Color.Red;//IS_NABL
                    table.Rows[0].Cells[26].ForeColor = Color.Red;//IS_CAP
                    table.Rows[0].Cells[27].ForeColor = Color.Red;//IS_STAT
                    table.Rows[0].Cells[28].ForeColor = Color.Red;//IS_SMS
                    table.Rows[0].Cells[29].ForeColor = Color.Red;//IS_STATISTICAL
                    table.Rows[0].Cells[40].ForeColor = Color.Red;//IS_TEST_HISTORY
                    table.Rows[0].Cells[49].ForeColor = Color.Red;//OUTPUT_FORMAt
                    table.Rows[0].Cells[54].ForeColor = Color.Red;//IsActive
                    table.Rows[0].Cells[55].ForeColor = Color.Red;//IsNonReportable
                    table.Rows[0].Cells[56].ForeColor = Color.Red;//PrintSeparately
                    table.Rows[0].Cells[57].ForeColor = Color.Red;//Billing_Name
                    table.Rows[0].Cells[70].ForeColor = Color.Red;//Flag
                    table.Rows[0].Cells[71].ForeColor = Color.Red;//INPUT_FORMAT





                    table.Rows[0].Cells[5].BackColor = Color.Yellow;//DISPLAY_NAME
                    table.Rows[0].Cells[6].BackColor = Color.Yellow;//DeptName	
                    table.Rows[0].Cells[7].BackColor = Color.Yellow;//SECTION_NAME
                    table.Rows[0].Cells[11].BackColor = Color.Yellow;//Orderable
                    table.Rows[0].Cells[13].BackColor = Color.Yellow;//INPUT_FORMAT
                    table.Rows[0].Cells[14].BackColor = Color.Yellow;//Sample_Type
                    table.Rows[0].Cells[16].BackColor = Color.Yellow;//Container
                    table.Rows[0].Cells[19].BackColor = Color.Yellow;//PROCESSING_LOCATION
                    table.Rows[0].Cells[22].BackColor = Color.Yellow;//IS_MACHINE_INTERFACED
                    table.Rows[0].Cells[23].BackColor = Color.Yellow;//REPEATABLE
                    table.Rows[0].Cells[25].BackColor = Color.Yellow;//IS_NABL
                    table.Rows[0].Cells[26].BackColor = Color.Yellow;//IS_CAP
                    table.Rows[0].Cells[27].BackColor = Color.Yellow;//IS_STAT
                    table.Rows[0].Cells[28].BackColor = Color.Yellow;//IS_SMS
                    table.Rows[0].Cells[29].BackColor = Color.Yellow;//IS_STATISTICAL
                    table.Rows[0].Cells[40].BackColor = Color.Yellow;//IS_TEST_HISTORY
                    table.Rows[0].Cells[49].BackColor = Color.Yellow;//OUTPUT_FORMAt
                    table.Rows[0].Cells[54].BackColor = Color.Yellow;//IsActive
                    table.Rows[0].Cells[55].BackColor = Color.Yellow;//IsNonReportable
                    table.Rows[0].Cells[56].BackColor = Color.Yellow;//PrintSeparately
                    table.Rows[0].Cells[57].BackColor = Color.Yellow;//Billing_Name
                    table.Rows[0].Cells[70].BackColor = Color.Yellow;//Flag
                    table.Rows[0].Cells[71].BackColor = Color.Yellow;//INPUT_FORMAT


                }
                if (type.Equals("GRPCONTENT") || type.Equals("PKGCONTENT"))
                {
                    table.Rows[0].Cells[2].ForeColor = Color.Red;//TEST_CODE
                    table.Rows[0].Cells[4].ForeColor = Color.Red;//TEST_SEQUENCE_NO
                    table.Rows[0].Cells[7].ForeColor = Color.Red;//Type
                    table.Rows[0].Cells[9].ForeColor = Color.Red;//Flag
                    table.Rows[0].Cells[2].BackColor = Color.Yellow;
                    table.Rows[0].Cells[4].BackColor = Color.Yellow;
                    table.Rows[0].Cells[7].BackColor = Color.Yellow;
                    table.Rows[0].Cells[9].BackColor = Color.Yellow;


                }

                if (type.Equals("RateMaster"))
                {
                    table.Rows[0].Cells[6].ForeColor = Color.Red;//rate
                    table.Rows[0].Cells[7].ForeColor = Color.Red;//Flag
                    table.Rows[0].Cells[6].BackColor = Color.Yellow;
                    table.Rows[0].Cells[7].BackColor = Color.Yellow;
                }
                if (type.Equals("PhysicianMaster"))
                {
                    table.Rows[0].Cells[3].ForeColor = Color.Red;//DOB

                    table.Rows[0].Cells[4].ForeColor = Color.Red;//Age

                    table.Rows[0].Cells[5].ForeColor = Color.Red;//Sex

                    table.Rows[0].Cells[6].ForeColor = Color.Red;//Qualification

                    table.Rows[0].Cells[7].ForeColor = Color.Red;//Designation

                    table.Rows[0].Cells[8].ForeColor = Color.Red;//Address1

                    table.Rows[0].Cells[9].ForeColor = Color.Red;//Address2

                    table.Rows[0].Cells[10].ForeColor = Color.Red;//city
                    table.Rows[0].Cells[11].ForeColor = Color.Red;//state
                    table.Rows[0].Cells[12].ForeColor = Color.Red;//countrt
                    table.Rows[0].Cells[13].ForeColor = Color.Red;//mobile
                    table.Rows[0].Cells[14].ForeColor = Color.Red;//meilid
                    table.Rows[0].Cells[15].ForeColor = Color.Red;//landline
                    table.Rows[0].Cells[16].ForeColor = Color.Red;//fax
                    table.Rows[0].Cells[17].ForeColor = Color.Red;//isclient
                    table.Rows[0].Cells[18].ForeColor = Color.Red;//discountlimit
                    table.Rows[0].Cells[19].ForeColor = Color.Red;//discount valid from
                    table.Rows[0].Cells[20].ForeColor = Color.Red;//discount valid to
                    table.Rows[0].Cells[21].ForeColor = Color.Red;//HasReportingSms

                    table.Rows[0].Cells[22].ForeColor = Color.Red;//HasReportingemail

                    table.Rows[0].Cells[23].ForeColor = Color.Red;//ReferalHospitalName

                    table.Rows[0].Cells[24].ForeColor = Color.Red;//ReferalHospitalcode
     
               table.Rows[0].Cells[25].ForeColor = Color.Red;//flag



               table.Rows[0].Cells[3].BackColor = Color.Yellow;//DOB
               table.Rows[0].Cells[4].BackColor = Color.Yellow;//Age
               table.Rows[0].Cells[5].BackColor = Color.Yellow;//Sex
               table.Rows[0].Cells[6].BackColor = Color.Yellow;//Qualification
               table.Rows[0].Cells[7].BackColor = Color.Yellow;//Designation
               table.Rows[0].Cells[8].BackColor = Color.Yellow;//Address1
                    table.Rows[0].Cells[9].BackColor = Color.Yellow;
                    table.Rows[0].Cells[10].BackColor = Color.Yellow;
                    table.Rows[0].Cells[11].BackColor = Color.Yellow;
                    table.Rows[0].Cells[12].BackColor = Color.Yellow;
                    table.Rows[0].Cells[13].BackColor = Color.Yellow;
                    table.Rows[0].Cells[14].BackColor = Color.Yellow;
                    table.Rows[0].Cells[15].BackColor = Color.Yellow;
                    table.Rows[0].Cells[16].BackColor = Color.Yellow;
                    table.Rows[0].Cells[17].BackColor = Color.Yellow;
                    table.Rows[0].Cells[18].BackColor = Color.Yellow;
                    table.Rows[0].Cells[19].BackColor = Color.Yellow;
                    table.Rows[0].Cells[20].BackColor = Color.Yellow;
                    table.Rows[0].Cells[21].BackColor = Color.Yellow;
                    table.Rows[0].Cells[22].BackColor = Color.Yellow;
                    table.Rows[0].Cells[23].BackColor = Color.Yellow;
                    table.Rows[0].Cells[24].BackColor = Color.Yellow;
                    table.Rows[0].Cells[25].BackColor = Color.Yellow;
                    
                }
                if (type.Equals("LocationMaster"))
                {
                    table.Rows[0].Cells[1].ForeColor = Color.Red;//Location Name
                    //table.Rows[0].Cells[2].ForeColor = Color.Red;//Location Code
                    table.Rows[0].Cells[3].ForeColor = Color.Red;//Address 1
                    table.Rows[0].Cells[5].ForeColor = Color.Red;//City 
                    table.Rows[0].Cells[10].ForeColor = Color.Red;//Mobile
                    table.Rows[0].Cells[11].ForeColor = Color.Red;//Land Line
                    table.Rows[0].Cells[12].ForeColor = Color.Red;//Location Type
                    table.Rows[0].Cells[13].ForeColor = Color.Red;//Status
                    table.Rows[0].Cells[17].ForeColor = Color.Red;//Is Default

                    table.Rows[0].Cells[1].BackColor = Color.Yellow;
                    //table.Rows[0].Cells[2].BackColor = Color.Yellow;
                    table.Rows[0].Cells[3].BackColor = Color.Yellow;
                    table.Rows[0].Cells[5].BackColor = Color.Yellow;
                    table.Rows[0].Cells[10].BackColor = Color.Yellow;
                    table.Rows[0].Cells[11].BackColor = Color.Yellow;
                    table.Rows[0].Cells[12].BackColor = Color.Yellow;
                    table.Rows[0].Cells[13].BackColor = Color.Yellow;
                    table.Rows[0].Cells[17].BackColor = Color.Yellow;
                    
                    
                }
                //TableHeaderCell cell = new TableHeaderCell();
                //cell.BackColor = System.Drawing.Color.Red;
                //cell.ForeColor = System.Drawing.Color.Black;

                table.RenderControl(htmlWriter);

                response.Write(sw.ToString());
                response.End();
                //DataGrid dg = new DataGrid();
                //dg.DataSource = dt;
                //dg.DataBind();
                //dg.HeaderStyle.Font.Bold = true;
                //dg.RenderControl(htw);
                //response.Write(sw.ToString());
                //response.End();
            }
        }
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}