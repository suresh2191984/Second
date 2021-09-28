using System;
using System.Collections.Generic;
using System.Linq;
using System.Globalization;
using System.Web;
using System.Web.UI;

using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;
using OfficeOpenXml;
using OfficeOpenXml.Style;

using Attune.Cryptography;
using System.Data.OleDb;
using System.IO;
//using Microsoft.Office.Tools.Excel;
using System.Text.RegularExpressions;
//using Excels = Microsoft.Office.Interop.Excel;
//using Microsoft.Office.Interop.Access;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Diagnostics;
using Microsoft.VisualBasic.FileIO;
using System.Text;
using System.Net;
public partial class Deployability_InvCreateUpdate : BasePage
{
    #region BulkUpload

    #region Declaration


    Deployability_BL Deployability_BL;
    List<InvCreateUpdate> lsterrorinfo = new List<InvCreateUpdate>();
    string extension = string.Empty;
    string fileNamess = string.Empty;
    string filepath = string.Empty;
    string path = string.Empty;
    //StreamReader s = null;


    #endregion

    #region Events
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            LoadMetadata();

        }



    }
    protected void btnupload_Click(object sender, EventArgs e)
    {
        UploadData();
    }


    protected void btnclear_Click(object sender, EventArgs e)
    {
        fileupload1.Attributes.Clear();
    }


    protected void btndownloadtemplatedata_Click(object sender, EventArgs e)
    {
        DataTable dt = GetTemplateData();////gettable();
        if (ddlfiletype.SelectedValue.Equals("1") || ddlfiletype.SelectedValue.Equals("2"))
        {

            ExportToExcelcheck(dt,ddltype.SelectedValue);

        }

        else if (ddlfiletype.SelectedValue.Equals("3"))
        {


            DownloadCSV(dt);

        }

        else
        {
            // LockExcelCells(GetTemplateData());
        }


    }

    protected void btnloadsheet_Click(object sender, EventArgs e)
    {
        if (ddlfiletype.SelectedValue.Equals("2"))
        {


            string fileNamess = ddltype.SelectedItem.Text;

            if (ddltype.SelectedItem.Text.Equals("Group"))
            {
                fileNamess = "Groupmaster";
            }
            if (ddltype.SelectedItem.Text.Equals("Package"))
            {
                fileNamess = "Packagemaster"; //UserMaster
            }
            if (ddltype.SelectedItem.Text.Equals("Group Content"))
            {
                fileNamess = "Groupcontent";//UserMaster
            }
            if (ddltype.SelectedItem.Text.Equals("Package Content"))
            {
                fileNamess = "Packagecontent";//UserMaster
            }
            if (ddltype.SelectedItem.Text.Equals("InvestigationMaster"))
            {
                fileNamess = "Investigationmaster";//UserMaster
            }
            if (ddltype.SelectedItem.Text.Equals("RateMaster"))
            {
                fileNamess = ddltype.SelectedItem.Text;//UserMaster
            }
            if (ddltype.SelectedItem.Text.Equals("UserMaster"))
            {
                fileNamess = ddltype.SelectedItem.Text;//UserMaster
            }




            Response.ContentType = "Application/x-msexcel";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileNamess + ".xlsx");

            Response.TransmitFile(Server.MapPath("~/BulkDataUploadformat/" + fileNamess + ".xlsx"));



            Response.End();






        }

        ScriptManager.RegisterStartupScript(this, this.GetType(), "SuccessMsg", "check();", true);


    }
    #endregion

    #region Method
    //    <span style="font-size: 9pt;"> </span>
    //Hide   Copy Code



    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]

    public static List<InvCreateUpdate> GetDataFromDB(int orgid, string type, int createdby)
    {

        long returnCode = -1;

        List<InvCreateUpdate> lstloginfo = new List<InvCreateUpdate>();
        Deployability_BL Deployability_BL = new Deployability_BL();
        returnCode = Deployability_BL.GetInvGrpPkgLog(orgid, type, createdby, out lstloginfo);


        return lstloginfo;


    }


    [WebMethod]
    public static String loadRateType(int OrgID, String txtSearchName)
    {

        JavaScriptSerializer js = new JavaScriptSerializer();
        List<RateMaster> lstRateMaster = new List<RateMaster>();
        try
        {
            new Master_BL(new BaseClass().ContextInfo).pGetRateName(OrgID, out lstRateMaster);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in loadRateType", ex);
        }
        if (txtSearchName == "%")
        {
            var query = from c in lstRateMaster
                        select c;

            return js.Serialize(query);
        }
        else
        {
            var lstRateTypes1 = from FilterLst in lstRateMaster
                                where FilterLst.RateName.ToLower().Contains(txtSearchName.ToLower().Replace("%", "").Trim())
                                select FilterLst;
            return js.Serialize(lstRateTypes1);
        }

    }




    private DataTable GetTemplateData()
    {
        DataTable dt = new DataTable();
        long returnCode = -1;
        string type = string.Empty;
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
        //List<TblUserMaster> lstUsers = new List<TblUserMaster>();

       int lid = Convert.ToInt32(LID);
        string fileextension = string.Empty;
        if (ddlfiletype.SelectedValue.Equals("1"))
        {
            fileextension = ".xls";
        }
        else if (ddlfiletype.SelectedValue.Equals("2"))
        {
            fileextension = ".xlsx";
        }
        else { fileextension = ".csv"; }


        Deployability_BL Deployability_BL = new Deployability_BL(base.ContextInfo);

        if (ddltype.SelectedItem.Text.Equals("InvestigationMaster"))
        {
            type = "INV";
        }
        else if (ddltype.SelectedItem.Text.Equals("Group"))
        {
            type = "GRP";
        }

        else if (ddltype.SelectedItem.Text.Equals("Package"))
        {
            type = "PKG";
        }
        else if (ddltype.SelectedItem.Text.Equals("Package Content"))
        {
            type = "PKGCONTENT";
        }

        else if (ddltype.SelectedItem.Text.Equals("RateMaster"))
        {

            type = "RateMaster";
            rateid = Convert.ToInt32(hdnRateTypeVal.Value);
        }
        else
        {
            type = "GRPCONTENT";
        }

        //returnCode = Deployability_BL.GetRefillTestMasters(OrgID, type, lid, out  lstInvestigationMaster, out  lstinvgroupmaster, out lstinvgroupmasterPKG, out lstGroupContent, out lstPackageContent, out lstUsers);
        returnCode = Deployability_BL.GetRefillTestMasters(OrgID, type, lid, rateid, out  lstInvestigationMaster, out  lstinvgroupmaster, out lstinvgroupmasterPKG, out lstGroupContent, out lstPackageContent, out lstRateMaster, out lstDeviceTestMap, out lstStage_Physician, out lstStage_LocationMaster);
        if (type.Equals("INV"))
        {

            // var val = (from Staging in lstInvestigationMaster where Staging.Flag.Equals("I") || Staging.Flag.Equals("U") select Staging).ToList();
            Utilities.ConvertFrom(lstInvestigationMaster, out dt);
        }
        else if (type.Equals("GRP"))
        {
            //var val = (from Staging in lstinvgroupmaster where Staging.Flag.Equals("I") || Staging.Flag.Equals("U") select Staging).ToList();
            Utilities.ConvertFrom(lstinvgroupmaster, out dt);
        }
        else if (type.Equals("PKG"))
        {
            //  var val = (from Staging in lstinvgroupmasterPKG where Staging.Flag.Equals("I") || Staging.Flag.Equals("U") select Staging).ToList();
            Utilities.ConvertFrom(lstinvgroupmasterPKG, out dt);
        }
        else if (ddltype.SelectedItem.Text.Contains("Package Content"))
        {
            //var val = (from Staging in lstPackageContent where Staging.Flag.Equals("I") || Staging.Flag.Equals("U") select Staging).ToList();
            Utilities.ConvertFrom(lstPackageContent, out dt);
        }
        else if (ddltype.SelectedItem.Text.Contains("Group Content"))
        {
            // var val = (from Staging in lstGroupContent where Staging.Flag.Equals("I") || Staging.Flag.Equals("U") select Staging).ToList();
            Utilities.ConvertFrom(lstGroupContent, out dt);
        }
        else if (ddltype.SelectedItem.Text.Contains("ClientRateMapping"))
        {

            Utilities.ConvertFrom(lstinvgroupmaster, out dt);
        }
        else if (ddltype.SelectedItem.Text.Contains("RateCard"))
        {

            Utilities.ConvertFrom(lstinvgroupmaster, out dt);
        }
        else if (ddltype.SelectedItem.Text.Contains("RateMaster"))
        {

            Utilities.ConvertFrom(lstRateMaster, out dt);
        }
        else if (ddltype.SelectedItem.Text.Contains("ReferingHospital"))
        {

            Utilities.ConvertFrom(lstinvgroupmaster, out dt);
        }
        else if (ddltype.SelectedItem.Text.Contains("RefferingPhysician"))
        {

            Utilities.ConvertFrom(lstinvgroupmaster, out dt);
        }
        else if (ddltype.SelectedItem.Text.Contains("RefrenceRange"))
        {

            Utilities.ConvertFrom(lstinvgroupmaster, out dt);
        }


        else
        {
            Utilities.ConvertFrom(lstinvgroupmasterPKG, out dt);
        }


        return dt;
    }
    private string ExportToCSVFiles(System.Data.DataTable dtTable)
    {

        try
        {
            int i = 1;
            System.Text.StringBuilder sbldr = new System.Text.StringBuilder();
            if (dtTable.Columns.Count != 0)
            {
                foreach (DataColumn col in dtTable.Columns)
                {
                    if (i == Convert.ToInt32(dtTable.Columns.Count))
                    {
                        sbldr.Append(col.ColumnName);
                    }
                    else
                    {
                        sbldr.Append(col.ColumnName + ',');
                    }
                    i++;
                }


                sbldr.Append("\r\n");


                foreach (DataRow row in dtTable.Rows)
                {
                    i = 1;
                    foreach (DataColumn column in dtTable.Columns)
                    {
                        if (i == Convert.ToInt32(dtTable.Columns.Count))
                        {
                            sbldr.Append(row[column].ToString());
                        }
                        else { sbldr.Append(row[column].ToString() + ','); }
                        i++;
                    }
                    sbldr.Append("\r\n");
                }
            }
            return sbldr.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("ExportToCSVFiles", ex);
            throw new Exception(ex.Message.ToString() + "csv");
        }
    }


    private System.Data.DataTable ReadExcelxlsformat(string fileName, string fileExt)
    {



        string conn = string.Empty;
        System.Data.DataTable dtexcel = new System.Data.DataTable();

        conn = @"provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileName + ";Extended Properties='Excel 8.0;HRD=Yes;IMEX=1';"; //for below excel 2007  

        String sTableName = string.Empty;
        using (OleDbConnection con = new OleDbConnection(conn))
        {
            try
            {
                //OleDbDataAdapter oleAdpt = new OleDbDataAdapter("select * from [Sheet1$]", con); //here we read data from sheet1  
                //oleAdpt.Fill(dtexcel); //fill excel data into dataTable  

                if (con.State == ConnectionState.Closed)
                    con.Open();
                System.Data.DataTable dtSheet = con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                foreach (DataRow drSheet in dtSheet.Rows)
                {
                    sTableName = drSheet["TABLE_NAME"].ToString();
                    break;
                }


                string cmd = "select * from [" + sTableName + "]";

                OleDbDataAdapter oleAdpt = new OleDbDataAdapter(cmd, con);
                oleAdpt.FillSchema(dtexcel, SchemaType.Source);


                if (ddltype.SelectedItem.Text.Equals("RateMaster"))
                {
                    dtexcel.Columns[0].DataType = typeof(Int32);
                    dtexcel.Columns[1].DataType = typeof(Int32);
                    dtexcel.Columns[2].DataType = typeof(string);
                    dtexcel.Columns[6].DataType = typeof(decimal);
                    dtexcel.AcceptChanges();

                }

                if (ddltype.SelectedItem.Text.Equals("UserMaster"))
                {
                    dtexcel.Columns[3].DataType = typeof(DateTime);
                    dtexcel.AcceptChanges();

                }


                oleAdpt.Fill(dtexcel);
            }
            catch (Exception ex)
            {
                con.Close();
                CLogger.LogError("ReadExcelxlsformat", ex);
            }
        }
        return dtexcel;
    }

    private System.Data.DataTable ReadExcel(string fileName, string fileExt)
    {



        string conn = string.Empty;
        System.Data.DataTable dtexcel = new System.Data.DataTable();


        conn = @"provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileName + ";Extended Properties=HTML Import;Persist Security Info=False;";


        String sTableName = string.Empty;
        using (OleDbConnection con = new OleDbConnection(conn))
        {
            try
            {

                if (con.State == ConnectionState.Closed)
                    con.Open();
                System.Data.DataTable dtSheet = con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                foreach (DataRow drSheet in dtSheet.Rows)
                {
                    sTableName = drSheet["TABLE_NAME"].ToString();
                    break;
                }


                if (string.IsNullOrEmpty(sTableName) && fileExt.CompareTo(".xls") == 0)
                {

                    dtexcel = ReadExcelxlsformat(fileName, fileExt);

                }
                else
                {
                    string cmd = "select * from [" + sTableName + "]";

                    OleDbDataAdapter oleAdpt = new OleDbDataAdapter(cmd, con);
                    oleAdpt.FillSchema(dtexcel, SchemaType.Source);


                    if (ddltype.SelectedItem.Text.Equals("RateMaster"))
                    {
                        dtexcel.Columns[0].DataType = typeof(Int32);
                        dtexcel.Columns[1].DataType = typeof(Int32);

                        dtexcel.Columns[2].DataType = typeof(string);
                        dtexcel.Columns[6].DataType = typeof(decimal);
                        dtexcel.AcceptChanges();

                    }

                    if (ddltype.SelectedItem.Text.Equals("UserMaster"))
                    {
                        dtexcel.Columns[3].DataType = typeof(DateTime);
                        dtexcel.AcceptChanges();

                    }



                    //OleDbCommand cmd = new OleDbCommand(query, conn);


                    oleAdpt.Fill(dtexcel);
                }





            }
            catch (Exception ex)
            {
                con.Close();
                CLogger.LogError("ReadExcel", ex);


                //throw ex;
            }
        }
        return dtexcel;
    }
    private void DeleteDirectoryfiles()
    {
        try
        {
            string Directorypath = Server.MapPath("~/Uploaded/");
            System.IO.DirectoryInfo downloadedMessageInfo = new DirectoryInfo(Directorypath);
            string extension = string.Empty;
            foreach (FileInfo file in downloadedMessageInfo.GetFiles())
            {
                extension = Path.GetExtension(file.Name);
                if (!string.IsNullOrEmpty(file.Name))
                {
                    if (extension == ".xls" || extension == ".xlsx" || extension == ".csv")
                    {
                        file.Delete();
                    }
                }
            }

            string excelDirectorypath = Server.MapPath("~/ExcelTest/");
            System.IO.DirectoryInfo exceldownloadedMessageInfo = new DirectoryInfo(excelDirectorypath);

            foreach (FileInfo fileexcel in exceldownloadedMessageInfo.GetFiles())
            {
                extension = string.Empty;
                extension = Path.GetExtension(fileexcel.Name);
                if (!string.IsNullOrEmpty(fileexcel.Name))
                {
                    if (extension == ".xls" || extension == ".xlsx" || extension == ".csv")
                    {
                        fileexcel.Delete();
                    }
                    if (fileexcel.Name.Equals("Inventory Template.xls"))
                    {
                        fileexcel.Delete();
                    }
                    if (fileexcel.Name.Equals("StockInHand-ES.xls"))
                    {
                        fileexcel.Delete();
                    }
                    if (fileexcel.Name.Equals("vssver2"))
                    {
                        fileexcel.Delete();
                    }
                }
            }
        }
        catch (Exception ex)
        { CLogger.LogError("DeleteDirectoryfiles", ex); }
    }
    private void Deletefiles()
    {
        try
        {
            string Directorypath = Server.MapPath("~/Uploaded/");
            string[] filePaths = Directory.GetFiles(@Directorypath);
            string extension = string.Empty;
            foreach (string filePath in filePaths)
            {
                extension = Path.GetExtension(filePath);

                //if (extension == ".scc")
                if (extension == ".xls" || extension == ".xlsx" || extension == ".csv")
                {
                    if (!string.IsNullOrEmpty(filePath))
                    {
                        File.Delete(filePath);
                    }
                }
            }

            Directorypath = string.Empty;

            Directorypath = Server.MapPath("~/ExcelTest/");

            string[] filePathsname = Directory.GetFiles(@Directorypath);
            foreach (string filePath in filePathsname)
            {
                extension = Path.GetExtension(filePath);

                //if (extension == ".scc")
                if (extension == ".xls" || extension == ".xlsx" || extension == ".csv")
                {
                    if (!string.IsNullOrEmpty(filePath))
                    {
                        File.Delete(filePath);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Deletefiles", ex);

        }
    }
    private System.Data.DataTable GetDataFromExcel()
    {
        try
        {
            System.Data.DataTable dtFilterTable = new System.Data.DataTable();
            string filepath = string.Empty; string path = string.Empty;
            string extension = string.Empty;
            string fileNamess = string.Empty;


            fileNamess = fileupload1.FileName;

            fileupload1.SaveAs(Server.MapPath("~/Uploaded/" + fileNamess));

            filepath = Server.MapPath("~/Uploaded/" + fileNamess);
            path = @filepath;
            extension = Path.GetExtension(fileNamess);
            return ReadExcel(path, extension);

        }
        catch (Exception ex)
        {
            CLogger.LogError("GetDataFromExcel", ex);
            throw ex;
        }
    }

    private string GetMasterType()
    {
        string type = string.Empty;
        if (ddltype.SelectedItem.Text.Equals("InvestigationMaster"))
        {
            type = "INV";
        }
        else if (ddltype.SelectedItem.Text.Equals("Group"))
        {
            type = "GRP";
        }

        else if (ddltype.SelectedItem.Text.Equals("Package"))
        {
            type = "PKG";
        }
        else if (ddltype.SelectedItem.Text.Equals("Package Content"))
        {
            type = "PKGCt";
        }

        else if (ddltype.SelectedItem.Text.Equals("RateMaster"))
        {

            type = "Rate";

        }
        else
        {
            type = "GRPCt";
        }
        return type;
    }
    private void DownloadCSV(DataTable dt)
    {

        try
        {

            DataTable table = dt;
            bool includeHeader = true;
            string delimiter = ",";
            var result = new StringBuilder();

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
                        // Double up all embedded double quotes
                        itemAsString = itemAsString.Replace("\"", "\"\"");

                        // To keep things simple, always delimit with double-quotes
                        // so we don't have to determine in which cases they're necessary
                        // and which cases they're not.
                        itemAsString = "\"" + itemAsString + "\"";

                        result.Append(itemAsString + delimiter);
                    }
                }

                result.Remove(--result.Length, 0);
                result.Append(Environment.NewLine);
            }


            //string csv = string.Empty;

            //foreach (DataColumn column in dt.Columns)
            //{
            //    //Add the Header row for CSV file.
            //    csv += column.ColumnName + ',';
            //}

            ////Add new line.
            //csv += "\r\n";

            //foreach (DataRow row in dt.Rows)
            //{
            //    foreach (DataColumn column in dt.Columns)
            //    {
            //        //Add the Data rows.
            //        csv += row[column.ColumnName].ToString().Replace(",", ";") + ',';
            //    }

            //    //Add new line.
            //    csv += "\r\n";
            //}

            //Download the CSV file.
            Response.Clear();
            Response.Buffer = true;

            string Filedate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("yyyyMMddHHmmss");//Convert.ToDateTime(new BasePage().OrgDateTimeZone).Date.ToShortDateString();
            string filename = string.Empty;
            if (ddltype.SelectedItem.Text.Equals("RateMaster"))
            {

                filename = OrgName + "__" + txtCopyToRate.Text + "__" + Filedate; //Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("D");//dates.Replace("/", ":").ToString(); 
            }
            else
            {
                filename = OrgName + "__" + GetMasterType() + "__" + Filedate; //Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("D");//dates.Replace("/", ":").ToString(); 
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
            // throw new Exception(ex.Message.ToString());
        }
    }


    /// <summary>
    /// Converts the passed in data table to a CSV-style string.
    /// </summary>
    /// <param name="table">Table to convert</param>
    /// <param name="includeHeader">true - include headers<br/>
    /// false - do not include header column</param>
    /// <returns>Resulting CSV-style string</returns>


    /// <summary>
    /// Converts the passed in data table to a CSV-style string.
    /// </summary>
    /// <param name="table">Table to convert</param>
    /// <param name="includeHeader">true - include headers<br/>
    /// false - do not include header column</param>
    /// <returns>Resulting CSV-style string</returns>


    //private void LockExcelCells(DataTable dt)
    //{
    //    try
    //    {
    //        System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");

    //        string data = null;

    //        Excels.Workbook xlWorkBook;
    //        Excels.Worksheet xlWorkSheet;
    //        object misValue = System.Reflection.Missing.Value;
    //        Excels.Range chartRange;


    //        Microsoft.Office.Interop.Excel.Application xlApp = new Microsoft.Office.Interop.Excel.Application();

    //        xlWorkBook = xlApp.Workbooks.Add(misValue);

    //        xlWorkSheet = (Excels.Worksheet)xlWorkBook.Worksheets.get_Item(1);


    //        DataTable dtRisk = new DataTable();

    //        dtRisk = dt;
    //        int cellcount = dtRisk.Rows.Count + 1;
    //        //  cellcount = 1;
    //        int columnscount = dtRisk.Columns.Count;



    //        for (int i = 0; i < dtRisk.Columns.Count; i++)
    //        {

    //            xlWorkSheet.Cells[1, (i + 1)] = dtRisk.Columns[i].ColumnName;

    //        }
    //        Excels.Range rngs = xlWorkSheet.Cells[1, (columnscount)] as Excels.Range;
    //        rngs.EntireRow.Font.Bold = true;


    //        for (int i = 0; i <= dtRisk.Rows.Count - 1; i++)
    //        {
    //            for (int j = 0; j <= dtRisk.Columns.Count - 1; j++)
    //            {

    //                data = dtRisk.Rows[i].ItemArray[j].ToString();
    //                xlWorkSheet.Cells[i + 2, j + 1] = data;
    //            }
    //        }



    //        string cellcolumnvalue1 = string.Empty;
    //        string cellcolumnvalue2 = string.Empty;

    //        string EndHeaderColumnValue = string.Empty;

    //        if (ddltype.SelectedItem.Text.Equals("InvestigationMaster"))
    //        {
    //            EndHeaderColumnValue = "BT1";
    //        }
    //        else if (ddltype.SelectedItem.Text.Equals("Group"))
    //        {
    //            EndHeaderColumnValue = "AH1";
    //        }
    //        else if (ddltype.SelectedItem.Text.Equals("Package"))
    //        {
    //            EndHeaderColumnValue = "AL1";
    //        }
    //        else if (ddltype.SelectedItem.Text.Equals("Package Content"))
    //        {
    //            EndHeaderColumnValue = "K1";
    //        }
    //        else if (ddltype.SelectedItem.Text.Equals("UserMaster"))
    //        {
    //            EndHeaderColumnValue = "AA1";
    //        }
    //        else
    //        {

    //            EndHeaderColumnValue = "J1";
    //        }



    //            cellcolumnvalue1 = "B1";
    //            cellcolumnvalue2 = "B" + cellcount;



    //        chartRange = xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2);
    //        //chartRange = xlWorkSheet.get_Range("A1", " AZ1");
    //        chartRange.Font.Bold = true;

    //        chartRange.BorderAround(Excels.XlLineStyle.xlContinuous, Excels.XlBorderWeight.xlMedium, Excels.XlColorIndex.xlColorIndexAutomatic, Excels.XlColorIndex.xlColorIndexAutomatic);
    //        xlWorkSheet.Cells.Locked = false;
    //        xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2).Locked = true;

    //        if (ddltype.SelectedItem.Text.Equals("RateMaster"))
    //        {


    //            cellcolumnvalue1 = "A1";
    //            cellcolumnvalue2 = "A" + cellcount;

    //            xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2).Locked = true;


    //            cellcolumnvalue1 = "B1";
    //            cellcolumnvalue2 = "B" + cellcount;

    //            xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2).Locked = true;


    //            cellcolumnvalue1 = "C1";
    //            cellcolumnvalue2 = "C" + cellcount;

    //            xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2).Locked = true;

    //            cellcolumnvalue1 = "E1";
    //            cellcolumnvalue2 = "E" + cellcount;

    //            xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2).Locked = true;

    //            cellcolumnvalue1 = "F1";
    //            cellcolumnvalue2 = "F" + cellcount;

    //            xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2).Locked = true;
    //        }
    //        if (ddltype.SelectedItem.Text.Equals("InvestigationMaster"))
    //        {
    //            cellcolumnvalue1 = "D1";
    //            cellcolumnvalue2 = "D" + cellcount;

    //            xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2).Locked = true;


    //            cellcolumnvalue1 = "AT1";
    //            cellcolumnvalue2 = "AT" + cellcount;

    //            xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2).Locked = true;

    //        }

    //        if( (ddltype.SelectedItem.Text.Equals("Group")) || (ddltype.SelectedItem.Text.Equals("Package")))
    //        {
    //            cellcolumnvalue1 = "C1";
    //            cellcolumnvalue2 = "C" + cellcount;

    //            xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2).Locked = true;

    //        }


    //        //if (ddltype.SelectedItem.Text.Equals("Package Content"))
    //        //{
    //        //    cellcolumnvalue1 = "C1";
    //        //    cellcolumnvalue2 = "C" + cellcount;

    //        //    xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2).Locked = true;

    //        //    cellcolumnvalue1 = "D1";
    //        //    cellcolumnvalue2 = "D" + cellcount;

    //        //    xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2).Locked = true;

    //        //    cellcolumnvalue1 = "E1";
    //        //    cellcolumnvalue2 = "E" + cellcount;

    //        //    xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2).Locked = true;

    //        //}
    //        //if (ddltype.SelectedItem.Text.Equals("Group Content"))
    //        //{
    //        //    cellcolumnvalue1 = "C1";
    //        //    cellcolumnvalue2 = "C" + cellcount;

    //        //    xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2).Locked = true;

    //        //    cellcolumnvalue1 = "D1";
    //        //    cellcolumnvalue2 = "D" + cellcount;

    //        //    xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2).Locked = true;

    //        //}

    //        xlWorkSheet.get_Range("A1", EndHeaderColumnValue).Locked = true;

    //        Excels.Range rg = xlWorkSheet.get_Range(cellcolumnvalue1, cellcolumnvalue2);
    //        rg.EntireColumn.AutoFit();
    //        //Set the input range.
    //        var list = new System.Collections.Generic.List<string>();
    //        if (ddltype.SelectedItem.Text.Equals("RateMaster"))
    //        {

    //            list.Add("U");
    //            var flatList = string.Join(",", list.ToArray());
    //            var cell = xlWorkSheet.get_Range("H2", "H" + cellcount);
    //            cell.Validation.Delete();
    //            cell.Validation.Add(
    //               Excels.XlDVType.xlValidateList,
    //               Excels.XlDVAlertStyle.xlValidAlertInformation,
    //               Excels.XlFormatConditionOperator.xlBetween,
    //               flatList,
    //               Type.Missing);

    //            cell.Validation.IgnoreBlank = true;
    //            cell.Validation.InCellDropdown = true;
    //            cell.Validation.InputMessage = "Please Update the Status as U to modify";
    //        }

    //        if (ddltype.SelectedItem.Text.Equals("Package"))
    //        {
    //            list.Add("I");
    //            list.Add("U");
    //            var flatList = string.Join(",", list.ToArray());
    //            var cell = xlWorkSheet.get_Range("AL2", "AL" + cellcount);
    //            cell.Validation.Delete();
    //            cell.Validation.Add(
    //               Excels.XlDVType.xlValidateList,
    //               Excels.XlDVAlertStyle.xlValidAlertInformation,
    //               Excels.XlFormatConditionOperator.xlBetween,
    //               flatList,
    //               Type.Missing);

    //            cell.Validation.IgnoreBlank = true;
    //            cell.Validation.InCellDropdown = true;
    //            cell.Validation.InputMessage = "Please Update the Status as U or I to modify";
    //            //al
    //        }
    //        if (ddltype.SelectedItem.Text.Equals("Group"))
    //        {
    //            list.Add("I");
    //            list.Add("U");
    //            var flatList = string.Join(",", list.ToArray());
    //            var cell = xlWorkSheet.get_Range("AH2", "AH" + cellcount);
    //            cell.Validation.Delete();
    //            cell.Validation.Add(
    //               Excels.XlDVType.xlValidateList,
    //               Excels.XlDVAlertStyle.xlValidAlertInformation,
    //               Excels.XlFormatConditionOperator.xlBetween,
    //               flatList,
    //               Type.Missing);

    //            cell.Validation.IgnoreBlank = true;
    //            cell.Validation.InCellDropdown = true;
    //            cell.Validation.InputMessage = "Please Update the Status as U or I to modify";
    //            //ah
    //        }
    //        if (ddltype.SelectedItem.Text.Equals("InvestigationMaster"))
    //        {
    //            list.Add("I");
    //            list.Add("U");
    //            var flatList = string.Join(",", list.ToArray());
    //            var cell = xlWorkSheet.get_Range("BT2", "BT" + cellcount);
    //            cell.Validation.Delete();
    //            cell.Validation.Add(
    //               Excels.XlDVType.xlValidateList,
    //               Excels.XlDVAlertStyle.xlValidAlertInformation,
    //               Excels.XlFormatConditionOperator.xlBetween,
    //               flatList,
    //               Type.Missing);

    //            cell.Validation.IgnoreBlank = true;
    //            cell.Validation.InCellDropdown = true;
    //            cell.Validation.InputMessage = "Please Update the Status as U or I to modify";
    //            //ah
    //        }
    //        //ah

    //        if ((ddltype.SelectedItem.Text.Equals("Group Content")) || (ddltype.SelectedItem.Text.Equals("Package Content")))
    //        {
    //            list.Add("U");
    //            var flatList = string.Join(",", list.ToArray());
    //            var cell = xlWorkSheet.get_Range("J2", "J" + cellcount);
    //            cell.Validation.Delete();
    //            cell.Validation.Add(
    //               Excels.XlDVType.xlValidateList,
    //               Excels.XlDVAlertStyle.xlValidAlertInformation,
    //               Excels.XlFormatConditionOperator.xlBetween,
    //               flatList,
    //               Type.Missing);

    //            cell.Validation.IgnoreBlank = true;
    //            cell.Validation.InCellDropdown = true;
    //            cell.Validation.InputMessage = "Please Update the Status as U to modify";
    //            //ah
    //        }








    //        xlWorkSheet.Protect(Type.Missing, Type.Missing, true, Type.Missing, Type.Missing, Type.Missing, Type.Missing,
    //  Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, true, Type.Missing);
    //        string filename = string.Empty;
    //        if (ddltype.SelectedItem.Text.Equals("RateMaster"))
    //        {

    //            filename = OrgName + "__" + txtCopyToRate.Text + "__" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("D");//dates.Replace("/", ":").ToString(); 
    //        }
    //        else
    //        { 
    //            filename = OrgName + "__" + ddltype.SelectedItem.Text + "__" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("D");//dates.Replace("/", ":").ToString(); 
    //        }
    //        if (ddlfiletype.SelectedValue.Equals("1"))
    //        {
    //           //

    //            xlWorkSheet.SaveAs(filename , Microsoft.Office.Interop.Excel.XlFileFormat.xlExcel5, Type.Missing, Type.Missing, false, false, Microsoft.Office.Interop.Excel.XlSaveAsAccessMode.xlExclusive, Microsoft.Office.Interop.Excel.XlSaveConflictResolution.xlLocalSessionChanges, false, Type.Missing);

    //        }
    //        else if (ddlfiletype.SelectedValue.Equals("2"))
    //        {
    //            //xlOpenXMLWorkbook

    //           // xlWorkSheet.SaveAs(filename, Microsoft.Office.Interop.Excel.XlFileFormat.xlOpenXMLWorkbook, Type.Missing, Type.Missing, false, false, Microsoft.Office.Interop.Excel.XlSaveAsAccessMode.xlExclusive, Microsoft.Office.Interop.Excel.XlSaveConflictResolution.xlLocalSessionChanges, false, Type.Missing);
    //        }
    //        else {
    //            xlWorkSheet.SaveAs(filename, Microsoft.Office.Interop.Excel.XlFileFormat.xlCSVWindows, Type.Missing, Type.Missing, false, false, Microsoft.Office.Interop.Excel.XlSaveAsAccessMode.xlExclusive, Microsoft.Office.Interop.Excel.XlSaveConflictResolution.xlLocalSessionChanges, false, Type.Missing);
    //        }




    //        xlApp.Quit();
    //        releaseObject(xlApp);
    //        releaseObject(xlWorkBook);
    //        releaseObject(xlWorkSheet);

    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "SuccessMsg", "check();alert('Downloaded Successfully');", true);
    //    }
    //    catch (Exception ex)
    //    {
    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "SuccessMsg", "alert('Invalid Process');", true);
    //        // throw (ex.Message.ToString());
    //    }
    //}

    private void releaseObject(object obj)
    {
        try
        {
            System.Runtime.InteropServices.Marshal.ReleaseComObject(obj);
            obj = null;
        }
        catch
        {
            obj = null;

        }
        finally
        {
            GC.Collect();
        }
    }

    public static Table DataTableToHTMLTable(DataTable dt, bool includeHeaders)
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
    private void ExportToExcelcheck(DataTable dt, string type)
    {
        HttpResponse response = HttpContext.Current.Response;
        string attachment = string.Empty;
        string Filedate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("yyyyMMddHHmmss");//Convert.ToDateTime(new BasePage().OrgDateTimeZone).Date.ToShortDateString();
        string filename = string.Empty;
        if (ddltype.SelectedItem.Text.Equals("RateMaster"))
        {

                filename = OrgName + "__" + txtCopyToRate.Text + "__" + Filedate;//String.Format("{0:d/M/yyyy HH:mm:ss}", Convert.ToDateTime(new BasePage().OrgDateTimeZone));// Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("D");//dates.Replace("/", ":").ToString(); 
            }
            else
            {
                filename = OrgName + "__" + GetMasterType() + "__" + Filedate;//dates.Replace("/", ":").ToString(); 
            }


            if (ddlfiletype.SelectedValue.Equals("1"))
            {
                attachment = "attachment; filename=" + filename + ".xls";
            }
            else
            {
                attachment = "attachment; filename=" + filename + ".xlsx";
            }


            // first let's clean up the response.object
            response.Clear();
            response.Charset = "";

            response.ContentType = "application/ms-excel";
            response.AddHeader("Content-Disposition", attachment);

        //// create a string writer
        using (StringWriter sb = new StringWriter())
        {
            using (HtmlTextWriter htmlWriter = new HtmlTextWriter(sb))
            {
               
                Table table = new Table();
                table = DataTableToHTMLTable(dt, true);
                table.GridLines = GridLines.Horizontal;
                table.BorderWidth = new Unit(1);
              //  table.BackColor = Color.Black;

                if (type.Equals("Group"))
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
                if (type.Equals("Package")) {
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
                if (type.Equals("InvestigationMaster"))
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
                if (type.Equals("Group Content")|| type.Equals("Package Content"))
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
                 //TableHeaderCell cell = new TableHeaderCell();
                 //cell.BackColor = System.Drawing.Color.Red;
                 //cell.ForeColor = System.Drawing.Color.Black;

                table.RenderControl(htmlWriter);

                response.Write(sb.ToString());
                response.End();
            }
        }
    }

    private void UploadData()
    {

        try
        {
            int noofrecords = 0;
            int duplicaterecords = 0;
            int updatedcount = 0;
            long returncode = -1;
            long returnCode = 0;
            bool returnmsg = false;
            Deployability_BL Deployability_BL = new Deployability_BL(base.ContextInfo);
            DataTable dt = new DataTable();




            if (ddlfiletype.SelectedItem.Value.Equals("3"))
            {

                dt = UploadCSV();
            }
            else
            {

                dt = GetDataFromExcel(); //ImportMyDataTableFromExcel();

            }
            DeleteDirectoryfiles();
            // Deletefiles();
            List<Stage2_MHL_T_01_TESTMASTER> lstInvestigationMaster = new List<Stage2_MHL_T_01_TESTMASTER>();
            List<Stage2_MHL_T_02_GROUP_MASTER> lstinvgroupmaster = new List<Stage2_MHL_T_02_GROUP_MASTER>();

            List<Stage2_MHL_T_03_Package_Master> lstinvgroupmasterPKG = new List<Stage2_MHL_T_03_Package_Master>();

            List<Stage2_MHL_T_05_PACKAGE_TESTS> lstpackagecontent = new List<Stage2_MHL_T_05_PACKAGE_TESTS>();

            List<Stage2_MHL_T_04_GROUP_TESTS> lstgroupcontent = new List<Stage2_MHL_T_04_GROUP_TESTS>();
            List<Stage_User_Template> lstUsers = new List<Stage_User_Template>();
            List<RateCardMaster> lstRateCardDetails = new List<RateCardMaster>();
            List<RateCardMaster> lstRateCardDetails_insert = new List<RateCardMaster>();
            if (ddltype.SelectedItem.Text.Equals("InvestigationMaster"))
            {
                Utilities.ConvertTo(dt, out lstInvestigationMaster);


                if (lstInvestigationMaster.Count > 0)
                {
                    var vallstInvestigationMaster = (from Staging in lstInvestigationMaster where !string.IsNullOrEmpty(Staging.Flag) select Staging).ToList();

                    lstInvestigationMaster = vallstInvestigationMaster;
                }
            }
            else if (ddltype.SelectedItem.Text.Equals("Group"))
            {


                Utilities.ConvertTo(dt, out lstinvgroupmaster);

                if (lstinvgroupmaster.Count > 0)
                {

                    var vallstinvgroupmaster = (from Staging in lstinvgroupmaster where !string.IsNullOrEmpty(Staging.Flag) select Staging).ToList();
                    lstinvgroupmaster = vallstinvgroupmaster;

                }
            }
            else if (ddltype.SelectedItem.Text.Equals("Package"))
            {
                Utilities.ConvertTo(dt, out lstinvgroupmasterPKG);
                if (lstinvgroupmasterPKG.Count > 0)
                {
                    var vallstinvgroupmasterPKG = (from Staging in lstinvgroupmasterPKG where !string.IsNullOrEmpty(Staging.Flag) select Staging).ToList();
                    lstinvgroupmasterPKG = vallstinvgroupmasterPKG;

                }
            }
            else if (ddltype.SelectedItem.Text.Equals("Package Content"))
            {
                Utilities.ConvertTo(dt, out lstpackagecontent);
                var vallstpackagecontent = (from Staging in lstpackagecontent where !string.IsNullOrEmpty(Staging.Flag) select Staging).ToList();
                lstpackagecontent = vallstpackagecontent;
            }
            else if (ddltype.SelectedItem.Text.Equals("UserMaster"))
            {

                dt = UpdateUserPassword(dt);
                Utilities.ConvertTo(dt, out lstUsers);


                var usersstaging = (from Staging in lstUsers where !string.IsNullOrEmpty(Staging.LoginName) select Staging).ToList();
                lstUsers = usersstaging;
            }

            else if (ddltype.SelectedItem.Text.Equals("RateMaster"))
            {


                Utilities.ConvertTo(dt, out lstRateCardDetails); //ConvertIntoRateCardList(dt, out returnmsg);
                //var ratemasterstaging = (from Staging in lstRateCardDetails where Staging.Flag.Equals("U") && !string.IsNullOrEmpty(Staging.TestCode) && !string.IsNullOrEmpty(Staging.RateName) && !string.IsNullOrEmpty(Staging.Rate.ToString()) select Staging).ToList();


                var ratemasterstaging_insert = (from Staging in lstRateCardDetails where Staging.Flag == "I" || Staging.Flag == "i" && !string.IsNullOrEmpty(Staging.TestCode) && !string.IsNullOrEmpty(Staging.RateName) && !string.IsNullOrEmpty(Staging.Rate.ToString()) select Staging).ToList();
                lstRateCardDetails_insert = ratemasterstaging_insert;
                var ratemasterstaging = (from Staging in lstRateCardDetails where !string.IsNullOrEmpty(Staging.Flag) && !string.IsNullOrEmpty(Staging.TestCode) && !string.IsNullOrEmpty(Staging.RateName) && !string.IsNullOrEmpty(Staging.Rate.ToString()) select Staging).ToList();


                lstRateCardDetails = ratemasterstaging;
            }
            else
            {
                Utilities.ConvertTo(dt, out lstgroupcontent);
                if (lstgroupcontent.Count > 0)
                {
                    var vallstgroupcontent = (from Staging in lstgroupcontent where !string.IsNullOrEmpty(Staging.Flag) select Staging).ToList();
                    lstgroupcontent = vallstgroupcontent;
                }
            }
            string message = string.Empty;
            bool results = true;

            if (ddltype.SelectedItem.Text.Equals("InvestigationMaster"))
            {

                noofrecords = Convert.ToInt32(lstInvestigationMaster.Count);
            }
            if (ddltype.SelectedItem.Text.Equals("Group"))
            {

                noofrecords = Convert.ToInt32(lstinvgroupmaster.Count);
            }
            if (ddltype.SelectedItem.Text.Equals("Package"))
            {

                noofrecords = Convert.ToInt32(lstinvgroupmasterPKG.Count);
            }
            if (ddltype.SelectedItem.Text.Equals("Group Content"))
            {

                noofrecords = Convert.ToInt32(lstgroupcontent.Count);
            }
            if (ddltype.SelectedItem.Text.Equals("Package Content"))
            {

                noofrecords = Convert.ToInt32(lstpackagecontent.Count);
            }
            if (ddltype.SelectedValue.Equals("RateMaster"))
            {
                noofrecords = Convert.ToInt32(lstRateCardDetails.Count);
            }


            if (ddltype.SelectedItem.Text.Equals("UserMaster"))
            {

                noofrecords = Convert.ToInt32(lstUsers.Count);
            }



            if (noofrecords == 0)
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No records Updated');", true);
            }


            else
            {
                results = CHKHEADER(dt);

                if (results == false)
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid File');", true);
                }
                else
                {
                    if (ddltype.SelectedValue.Equals("RateMaster"))
                    {
                        if (lstRateCardDetails_insert.Count == 0)
                        {
                        List<RateCardMaster> lstInvClientMaster = new List<RateCardMaster>();


                        noofrecords = Convert.ToInt32(lstRateCardDetails.Count);

                        if (noofrecords > 0)
                        {

                            returnCode = Deployability_BL.BulkUpdateRatesDetails(OrgID, lstRateCardDetails, out lstInvClientMaster);
                        }

                        duplicaterecords = Convert.ToInt32(lstInvClientMaster.Count);



                        if (noofrecords == 0)
                        {
                            message = "No records Updated";
                        }
                        else if (duplicaterecords > 0)
                        {
                            updatedcount = noofrecords - duplicaterecords;
                            message = "No of  Records:" + noofrecords + " No of Duplicate Records:" + duplicaterecords + " Updated Records:" + updatedcount;
                        }
                        else
                        {
                            message = "Completed";
                        }

                          }
                        else
                        {
                            message = "RateMaster allows only Update,recorrect the template";
                        }
                    }

                    else if (ddltype.SelectedValue.Equals("UserMaster"))
                    {

                        noofrecords = Convert.ToInt32(lstUsers.Count);


                        if (noofrecords > 0)
                        {

                            returnCode = Deployability_BL.BulkInsertUserMaster(lstUsers, out duplicaterecords, out updatedcount);
                        }





                        if (noofrecords == 0 || (returnCode <= -1) || (returnCode == 1001))
                        {


                            message = "No records Updated";
                        }

                        else if (duplicaterecords > 0)
                        {
                            //  updatedcount = noofrecords - duplicaterecords;
                            message = "No of  Records:" + noofrecords + " No of Duplicate Records:" + duplicaterecords + " Updated Records:" + updatedcount;
                        }
                        else
                        {
                            message = "Completed";
                        }


                        //BulkInsertUserMaster

                    }
                    else
                    {

                        returncode = Deployability_BL.getTestInsertUpdate(OrgID, lstinvgroupmaster, lstinvgroupmasterPKG, lstInvestigationMaster, lstpackagecontent, lstgroupcontent);

                        if (noofrecords == 0 || (returncode <= -1) || (returncode == 1001))
                        {


                            message = "No records Updated";
                        }

                        else
                        {
                            message = "Successfully Uploaded";
                        }

                    }

                    if (message.Equals("Completed"))
                    {
                        message = "Successfully Uploaded";
                    }

                    InsertInvGrpPkgLog(0, fileupload1.FileName, message);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("UploadData()" + ex.Message, ex);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid Process or File Header Format');", true);
        }
    }



    private bool CHKHEADER(DataTable dt)
    {
        bool RESULT = false;
        DataTable dtHeader = new DataTable();
        dtHeader = HeaderCheckingGetDataFromExcel();

        if(ddltype.SelectedItem.Text.Equals("UserMaster"))
        {
        dtHeader.Columns.Add("EncryptedPassword");
        }
        try
        {
            for (int j = 0; j < dtHeader.Columns.Count; j++)
            {


                if (string.Equals(dt.Columns[j].ColumnName, dtHeader.Columns[j].ColumnName, StringComparison.OrdinalIgnoreCase))
                //if (dt.Columns[j].ColumnName.Equals(dtHeader.Columns[j].ColumnName), StringComparison.InvariantCultureIgnoreCase)
                {

                    RESULT = true;
                }
                else
                {
                    RESULT = false;
                    return RESULT;
                }

            }
        }
        catch (Exception ex)
        { CLogger.LogError("CHKHEADER()", ex); }


        return RESULT;
    }


    private void LoadMetadata()
    {
        try
        {
            long returncode = -1;
            string domains = "Inv create/update";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData objmdata;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objmdata = new MetaData();
                objmdata.Domain = Tempdata[i];
                lstmetadataInput.Add(objmdata);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childitems = from child in lstmetadataOutput
                                 where child.Domain == "Inv create/update"
                                 select child;

                //        

                ddltype.DataSource = childitems;
                ddltype.DataTextField = "DisplayText";
                ddltype.DataValueField = "Code";
                ddltype.DataBind();
                ddltype.Items.Insert(0, "--Select--");
                ddltype.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta DataLoadMetadata ", ex);
        }
    }
    private DataTable HeaderCheckingGetDataFromExcel()
    {
        try
        {



            string pathname = string.Empty;


            string fileNamess = "";

            string selectedfileformat = ddlfiletype.SelectedValue;
            DataTable dtupdatedata = new DataTable();



            if (ddltype.SelectedItem.Text.Equals("Group"))
            {
                fileNamess = "Groupmaster";
            }
            if (ddltype.SelectedItem.Text.Equals("Package"))
            {
                fileNamess = "Packagemaster"; //UserMaster
            }
            if (ddltype.SelectedItem.Text.Equals("Group Content"))
            {
                fileNamess = "Groupcontent";//UserMaster
            }
            if (ddltype.SelectedItem.Text.Equals("Package Content"))
            {
                fileNamess = "Packagecontent";//UserMaster
            }
            if (ddltype.SelectedItem.Text.Equals("InvestigationMaster"))
            {
                fileNamess = "Investigationmaster";//UserMaster
            }
            if (ddltype.SelectedItem.Text.Equals("RateMaster"))
            {
                fileNamess = ddltype.SelectedItem.Text;//UserMaster
            }
            if (ddltype.SelectedItem.Text.Equals("UserMaster"))
            {
                fileNamess = ddltype.SelectedItem.Text;//UserMaster
            }

            filepath = Server.MapPath("~/BulkDataUploadformat/") + fileNamess + ".csv";



            dtupdatedata = GetDataTabletFromCSVFile(filepath);// Test(full, "test", ",");

            return dtupdatedata;


        }
        catch (Exception ex)
        {
            CLogger.LogError("HeaderCheckingGetDataFromExcel", ex);
            throw ex;
        }
    }



    private void SuccessMsg(string Status)
    {
        if (Status.Equals("Completed"))
        {
            Status = "Successfully Uploaded the records";
        }

        ScriptManager.RegisterStartupScript(this, this.GetType(), "SuccessMsg", "check();alert('" + Status + "');", true);


        // grderrorinfo.Visible = false;
    }
    private void NotSuccessMsg()
    {
        if (ddltype.SelectedItem.Text.Equals("RateMaster"))
        {

            tdchks.Attributes.Add("display", "block");
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "NotSuccessMsg", "alert('Not Inserted');", true);
    }
    //Insert function for Log Data
    private void InsertInvGrpPkgLog(long insertreturncode, string filename, string Status)
    {
        int lid = Convert.ToInt32(LID);
        Deployability_BL = new Deployability_BL(base.ContextInfo);

        long returnCode = -1;
        string originalfilename = System.IO.Path.GetFileNameWithoutExtension(fileupload1.FileName);
        string type = ddltype.SelectedValue;
        if (insertreturncode == 0)
        {
            SuccessMsg(Status);
        }
        else
        {
            NotSuccessMsg();
        }

        returnCode = Deployability_BL.InsertInvGrpPkgLog(OrgID, type, originalfilename, lid, Status);

    }


    private DataTable UploadCSV()
    {
        string pathname = string.Empty;
        string filenameex = "";

        string filename = "";

        string selectedfileformat = ddlfiletype.SelectedValue;
        DataTable dtupdatedata = new DataTable();

        try
        {
            filename = Server.HtmlEncode(fileupload1.FileName);
            string DatetimeNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("yyyyMMddHHmmssfff");
            filenameex = System.IO.Path.GetExtension(filename);
            filename = filename.Replace(".csv", "") + "_" + DatetimeNow + filenameex;
            string newfilepath = Server.MapPath("~/ExcelTest/" + filename);
            fileupload1.SaveAs(newfilepath);
            string full = System.IO.Path.GetFullPath(newfilepath);
            string tempfull = newfilepath;
            string file = System.IO.Path.GetFileName(full);
            string dir = System.IO.Path.GetDirectoryName(full);
            string temp = newfilepath;



            dtupdatedata = GetDataTabletFromCSVFile(temp);// Test(full, "test", ",");



            if (ddltype.SelectedItem.Text.Equals("UserMaster"))
            {
                dtupdatedata.Columns[0].ColumnName = "LoginName";
                dtupdatedata.Columns[1].ColumnName = "UserName";
                dtupdatedata.Columns[2].ColumnName = "SurName";
                dtupdatedata.AcceptChanges();
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("UploadCSV()", ex);

        }
        return dtupdatedata;


    }

    private DataTable UpdateUserPassword(DataTable dt)
    {
       


        IEnumerable<DataRow> tmpquery = from recOra in dt.AsEnumerable()
                                        where recOra.Field<string>("UserName") != null && recOra.Field<string>("UserName") != string.Empty
                                        select recOra;
                                       

        DataTable dtemp = tmpquery.CopyToDataTable();
        DataColumn Col = dtemp.Columns.Add("EncryptedPassword", System.Type.GetType("System.String"));
        Col.SetOrdinal(11);
        Attune.Cryptography.CCryptography objCryptography = new Attune.Cryptography.CCryptFactory().GetEncryptor();
       string password=string.Empty;
            string encryptedPassword=string.Empty;


            for (int i = 0; i < dtemp.Rows.Count; i++)
            {

            password = dtemp.Rows[i][1].ToString();
           objCryptography.Crypt(password, out encryptedPassword);
           dtemp.Rows[i][11] = encryptedPassword;// encryptedPassword;
           
           
           
        }
            return dtemp;
    }


    private DataTable GetDataTabletFromCSVFile(string csv_file_path)
    {
        DataTable csvData = new DataTable();
        try
        {
            using (TextFieldParser csvReader = new TextFieldParser(csv_file_path))
            {
                csvReader.SetDelimiters(new string[] { "," });
                csvReader.HasFieldsEnclosedInQuotes = true;
                //read column names
                string[] colFields = csvReader.ReadFields();
                foreach (string column in colFields)
                {
                    DataColumn datecolumn = new DataColumn(column);
                    datecolumn.AllowDBNull = true;
                    csvData.Columns.Add(datecolumn);
                }

                if (ddltype.SelectedItem.Text.Equals("RateMaster"))
                {
                    csvData.Columns[0].DataType = typeof(Int32);
                    csvData.Columns[1].DataType = typeof(Int32);
                    csvData.Columns[6].DataType = typeof(decimal);
                    csvData.AcceptChanges();
                }
                if (ddltype.SelectedItem.Text.Equals("UserMaster"))
                {
                    csvData.Columns[3].DataType = typeof(DateTime);
                    csvData.AcceptChanges();

                }

                while (!csvReader.EndOfData)
                {

                    string[] fieldData = csvReader.ReadFields();

                    //Making empty value as null
                    for (int i = 0; i < fieldData.Length; i++)
                    {
                        if (fieldData[i] == "")
                        {
                            fieldData[i] = null;
                        }
                    }
                    csvData.Rows.Add(fieldData);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("GetDataTabletFromCSVFile", ex);
            return csvData;
        }
        return csvData;
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    /// <su
    /// 

    #endregion



    #endregion











}























