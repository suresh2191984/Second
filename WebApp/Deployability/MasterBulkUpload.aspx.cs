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
using System.Data.OleDb;
using System.IO;
using System.Text.RegularExpressions;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Diagnostics;
using Microsoft.VisualBasic.FileIO;
using System.Text;
using System.Net;
public partial class Deployability_MasterBulkUpload : BasePage
{
    Deployability_BL Deployability_BL;
    List<InvCreateUpdate> lsterrorinfo = new List<InvCreateUpdate>();
    string extension = string.Empty;
    string fileNamess = string.Empty;
    string filepath = string.Empty;
    string path = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
          //  this.BindDummyRow();
            hdnFilePath.Value = Server.MapPath("~/BulkDataUploadformat/");
            hdnFileUploadPath.Value = Server.MapPath("~/BulkDataUploadformat/").Replace("\\", "~");
            this.BindDummyRow();
        }

    }

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
    [WebMethod(EnableSession = true)]
    public static string LoadMetadata(int OrgID)
    {
        try
        {
            long returncode = -1;
            string domains = "Inv create/update";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData_BL objMetaData_BL = new MetaData_BL(new BaseClass().ContextInfo);

            MetaData objmdata;
            string strout = string.Empty;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objmdata = new MetaData();
                objmdata.Domain = Tempdata[i];
                lstmetadataInput.Add(objmdata);
            }
            returncode = objMetaData_BL.LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            JavaScriptSerializer js = new JavaScriptSerializer();
            if (lstmetadataOutput.Count > 0)
            {
                var childitems = from child in lstmetadataOutput
                                 where child.Domain == "Inv create/update"
                                 select child;
                strout = js.Serialize(childitems);
            }

            return strout;
        }
        catch (Exception ex)
        {
            return "Error:" + ex;
        }
    }

    private void BindDummyRow()
    {
        DataTable dummy = new DataTable();
        dummy.Columns.Add("TestCode");
        dummy.Columns.Add("InvestigationName");
        dummy.Columns.Add("SubCategoryType");
        dummy.Columns.Add("TypeMode");
        dummy.Columns.Add("AgeRangeType");
        dummy.Columns.Add("AgeRange");
        dummy.Columns.Add("ValueTypeMode");
        dummy.Columns.Add("Value");
        dummy.Rows.Add();
        gvReferenceRange.DataSource = dummy;
        gvReferenceRange.DataBind();
    }
    [WebMethod]
    public static string GetRangeDetails(string InputPath, string FileName)
    {
        try
        {
            string fileExten = FileName.Split('.').LastOrDefault();
            if (string.Equals(fileExten, "xls"))
            {
                string strExcelConn = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + InputPath + ";Extended Properties='Excel 8.0;HDR=Yes;IMEX=1';";
                System.Data.OleDb.OleDbConnection connExcel = new System.Data.OleDb.OleDbConnection(strExcelConn);
                System.Data.OleDb.OleDbCommand cmdExcel = new System.Data.OleDb.OleDbCommand();
                cmdExcel.Connection = connExcel;
                connExcel.Open();
                System.Data.DataTable dtExcelSchema;
                dtExcelSchema = connExcel.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, null);
                connExcel.Close();
                connExcel.Open();
                System.Data.OleDb.OleDbDataAdapter da = new System.Data.OleDb.OleDbDataAdapter();
                string sheetName = dtExcelSchema.Rows[0]["Table_Name"].ToString();
                cmdExcel.CommandText = "SELECT * From [" + sheetName + "] order by TestCode,RangeType desc";
                DataSet ds = new DataSet();
                da.SelectCommand = cmdExcel;
                da.Fill(ds); connExcel.Close();
                string gg = ds.GetXml();
                return ds.GetXml();
            }
            else
            {
                DataTable dtCSVSchema = ReadCSVFile(InputPath);
                DataSet dscsv = new DataSet();
                dscsv.Tables.Add(dtCSVSchema);

                string gg = dscsv.GetXml();
                return dscsv.GetXml().Replace("Table1", "Table");
            }
        }
        catch (Exception ex)
        {
            return "Error when file Reading" + ex;
        }
    }
    [WebMethod]
    public static string SaveReferenceRange(List<InvOrgReferenceMapping> InputList, List<BulkReferenceRange> InvBulkRR, String FileName, int OrgId)
    {
        try
        {
            Deployability_BL ObjBL = new Deployability_BL(new BaseClass().ContextInfo);
            ObjBL.UpdateBulkReferenceRanges(InputList, InvBulkRR);
            // Deleting the Uploaded excel.
            string Path = HttpContext.Current.Server.MapPath("~/BulkDataUploadformat/" + FileName + ""); ;
            if ((System.IO.File.Exists(Path)))
            {
                System.IO.File.Delete(Path);
            }
        }
        catch (Exception EX)
        {
            string ff = EX.ToString();
        }
        return "Successfully Updated...!";
    }

    [WebMethod]
    public static List<BulkReferenceRange> GetReferenceRange(int OrgId)
    {
        List<BulkReferenceRange> RtnRR = new List<BulkReferenceRange>();
        try
        {
            Deployability_BL ObjBL = new Deployability_BL();
            ObjBL.GetBulkReferenceRanges(OrgId, out RtnRR);
        }
        catch (Exception EX)
        {
            string errs = EX.ToString();
        }
        return RtnRR;
    }

    private static DataTable ReadCSVFile(string Path)
    {
        DataTable csvData = new DataTable();
        try
        {
            using (TextFieldParser csvReader = new TextFieldParser(Path))
            {
                //csvReader.SetDelimiters(new string[] { "," });
                //csvReader.HasFieldsEnclosedInQuotes = true;
                string strrow = csvReader.ReadLine();
                char[] delime;
                if (strrow.Contains('\t'))
                {
                    delime = "\t".ToCharArray();
                }
                else
                {
                    delime = ",".ToCharArray();
                }

                var colFields = strrow.Split(delime);
                foreach (string column in colFields)
                {
                    DataColumn datecolumn = new DataColumn(column);
                    datecolumn.AllowDBNull = true;
                    csvData.Columns.Add(datecolumn);
                }
                while (!csvReader.EndOfData)
                {
                    string[] fieldData = csvReader.ReadLine().Split(delime);
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
            CLogger.LogError("catch error in read csv", ex);
            return csvData;
        }
        return csvData;
    }
}
