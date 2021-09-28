<%@ WebHandler Language="C#" Class="MasterfileuploadHandler" %>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Globalization;
using System.Web;
using System.Web.UI;
using Attune.Cryptography;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Xml;
using System.ComponentModel;
using System.Web.SessionState;
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
using System.Collections;

public class MasterfileuploadHandler : BasePage, IHttpHandler, IReadOnlySessionState
{
    Deployability_BL Deployability_BL;
    List<InvCreateUpdate> lsterrorinfo = new List<InvCreateUpdate>();
    string extension = string.Empty;
    string fileNamess = string.Empty;
    string filepath = string.Empty;
    string path = string.Empty;
    string Resultmsg = string.Empty;
    BasePage objbasepage = new BasePage();
    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.Files.Count > 0)
        {
            string filetype = string.Empty;
            DataTable dtupdatedata = new DataTable();
            string type = string.Empty;
            int OrgID = 0;
            int LID = 0;
            string Filepath = string.Empty;
            string Filename = string.Empty;
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

            
            
            for (int i = 0; i < context.Request.Files.Count; i++)
            {
                string path = context.Server.MapPath("~/Uploaded");
                if (!Directory.Exists(path))
                    Directory.CreateDirectory(path);

                var file = context.Request.Files[i];
                string fileName;
                if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE")
                {
                    string[] files = file.FileName.Split(new char[] { '\\' });
                    fileName = files[files.Length - 1];
                }
                else
                {
                    fileName = file.FileName;
                }
                string strFileName = fileName;
                fileName = Path.Combine(path, fileName);
                file.SaveAs(fileName);
                
                if (filetype.Equals("3"))
                {
                    string full = System.IO.Path.GetFullPath(fileName);
                    string tempfull = fileName;
                    string fileva = System.IO.Path.GetFileName(full);
                    string dir = System.IO.Path.GetDirectoryName(full);
                    string temp = fileName;
                    dtupdatedata = GetDataTabletFromCSVFile(temp, type);// Test(full, "test", ",");
                }
                else
                {
                    //string filepaths = string.Empty;
                    filepath = fileName;// Server.MapPath("~/Uploaded/" + fileNamess);
                    path = @filepath;

                    fileNamess = Path.GetFileName(filepath);
                    extension = Path.GetExtension(fileNamess);
                    
                    
                    dtupdatedata = ReadExcel(path, extension, type);
                }
                if (type.Equals("UserMaster"))
                {
                    dtupdatedata.Columns[0].ColumnName = "LoginName";
                    dtupdatedata.Columns[1].ColumnName = "UserName";
                    dtupdatedata.Columns[2].ColumnName = "SurName";
                    dtupdatedata.AcceptChanges();
                }
                string UploadedPath = context.Server.MapPath("~/Uploaded/");
                string csvfilepath = string.Empty;
                string uploadedcsvfilepath = string.Empty;
                string file_Name = string.Empty;

                if (type.Equals("Group"))
                {
                    file_Name = "Groupmaster";
                }
                if (type.Equals("Package"))
                {
                    file_Name = "Packagemaster"; //UserMaster
                }
                if (type.Equals("Group Content"))
                {
                    file_Name = "Groupcontent";//UserMaster
                }
                if (type.Equals("Package Content"))
                {
                    file_Name = "Packagecontent";//UserMaster
                }
                if (type.Equals("InvestigationMaster"))
                {
                    file_Name = "Investigationmaster";//UserMaster
                }
                if (type.Equals("RateMaster") || type.Equals("UserMaster") || type.Equals("PhysicianMaster") || type.Equals("LocationMaster"))
                {
                    file_Name = type;//UserMaster
                }
                if (type.Equals("DeviceTestMap"))
                {
                    file_Name = "DeviceTestMap";//DeviceTestMap
                }
                if (type.Equals("BillofSupplyNumberInvoiceTemplate"))
                {
                    file_Name = "BillofSupplyNumberInvoiceTemplate";//DeviceTestMap
                }
                csvfilepath = context.Server.MapPath("~/BulkDataUploadformat/") + file_Name + ".csv";
                Resultmsg = UploadData(filetype, type, OrgID, fileName, dtupdatedata, LID, UploadedPath, csvfilepath);
                context.Response.ContentType = "text/plain";
                context.Response.Write(Resultmsg);
            }
        }

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
        string password = string.Empty;
        string encryptedPassword = string.Empty;
        for (int i = 0; i < dtemp.Rows.Count; i++)
        {
            password = dtemp.Rows[i][1].ToString();
            objCryptography.Crypt(password, out encryptedPassword);
            dtemp.Rows[i][11] = encryptedPassword;// encryptedPassword;
        }
        return dtemp;
    }


    private DataTable UpdateEmailId(DataTable dt)
    {
             string result=string.Empty;

         ;
         string search = string.Empty;
        
        IEnumerable<DataRow> tmpquery = from recOra in dt.AsEnumerable()
                                        where recOra.Field<string>("Emailid") != null && recOra.Field<string>("Emailid") != string.Empty


                                        && recOra.Field<string>("PhysicianName") != null && recOra.Field<string>("PhysicianName") != string.Empty
                                        
                                         && recOra.Field<string>("PhysicianCode") != null && recOra.Field<string>("PhysicianCode") != string.Empty
                                        && recOra.Field<string>("Flag") != null && recOra.Field<string>("Flag") != string.Empty
    
                                        select recOra;


        

        DataTable dtemp = tmpquery.CopyToDataTable();
       //14
        for (int i = 0; i < dtemp.Rows.Count; i++)
        {
            search = dtemp.Rows[i][14].ToString();
            if (search.Contains("#"))
            {
                result = RemoveBetween(search, '#', '#');
                dtemp.Rows[i][14] = result;// encryptedPassword;
            }
        }
        return dtemp;
    }

    string RemoveBetween(string s, char begin, char end)
    {
        Regex regex = new Regex(string.Format("\\{0}.*?\\{1}", begin, end));
        return regex.Replace(s, string.Empty);
    }
    private System.Data.DataTable ReadExcelxlsformat(string fileName, string fileExt, string mastertype)
    {
        string conn = string.Empty;
        System.Data.DataTable dtexcel = new System.Data.DataTable();
        conn = @"provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileName + ";Extended Properties='Excel 8.0;HDR=Yes;IMEX=1';"; //for below excel 2007 
         
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
                string cmd = "select * from [" + sTableName + "]";
                OleDbDataAdapter oleAdpt = new OleDbDataAdapter(cmd, con);
                oleAdpt.FillSchema(dtexcel, SchemaType.Source);
                if (mastertype.Equals("RateMaster"))
                {
                    dtexcel.Columns[0].DataType = typeof(Int32);
                    dtexcel.Columns[1].DataType = typeof(Int32);
                    dtexcel.Columns[2].DataType = typeof(string);
                    dtexcel.Columns[6].DataType = typeof(decimal);
                    dtexcel.AcceptChanges();
                }
                if (mastertype.Equals("DeviceTestMap"))
                {
                    dtexcel.Columns[0].DataType = typeof(Int32);
                    dtexcel.Columns[1].DataType = typeof(string);
                    dtexcel.Columns[2].DataType = typeof(string);
                    dtexcel.Columns[4].DataType = typeof(Int64);
                    dtexcel.Columns[10].DataType = typeof(Int32);
                    dtexcel.Columns[11].DataType = typeof(Int64);
                    dtexcel.AcceptChanges();
                }
		  if (mastertype.Equals("PhysicianMaster"))
                {


                 
                    
                    dtexcel.Columns[0].DataType = typeof(Int64);//SERIALNUMBER
                    dtexcel.Columns[1].DataType = typeof(string);//PhysicianName
                    dtexcel.Columns[2].DataType = typeof(string);//PhysicianCode
                    dtexcel.Columns[3].DataType = typeof(DateTime);//DOB
                    dtexcel.Columns[4].DataType = typeof(string);//AGE
                    dtexcel.Columns[5].DataType = typeof(string);//SEX
                    dtexcel.Columns[6].DataType = typeof(string);//QUALIFICATION
                    dtexcel.Columns[7].DataType = typeof(string);//Designation
                    dtexcel.Columns[8].DataType = typeof(string);//Address1
                    dtexcel.Columns[9].DataType = typeof(string);//Address2
                    dtexcel.Columns[10].DataType = typeof(string);//city
                    dtexcel.Columns[11].DataType = typeof(string);//state
                    dtexcel.Columns[12].DataType = typeof(string);//country
                    dtexcel.Columns[13].DataType = typeof(string);//mobilenumber
                    dtexcel.Columns[14].DataType = typeof(string);//eMAILID
                    dtexcel.Columns[15].DataType = typeof(string);//LandLineNo
                    dtexcel.Columns[16].DataType = typeof(string);//FaxNo
                    dtexcel.Columns[17].DataType = typeof(string);//ISCLIENT
                    dtexcel.Columns[18].DataType = typeof(decimal);//DiscountLimit
                    dtexcel.Columns[19].DataType = typeof(DateTime);//DiscountValidFrom
                    dtexcel.Columns[20].DataType = typeof(DateTime);//DiscountValidTo
                    dtexcel.Columns[21].DataType = typeof(string); //HasReportingSms
                    dtexcel.Columns[22].DataType = typeof(string);//HasReportingEmail
                    dtexcel.Columns[23].DataType = typeof(string);//ReferalHospitalName
                    dtexcel.Columns[24].DataType = typeof(string);//ReferalHospitalCode
                    dtexcel.Columns[25].DataType = typeof(string);//FLAG
                    dtexcel.AcceptChanges();

                    
                }
          if (mastertype.Equals("LocationMaster"))
          {
              dtexcel.Columns[8].DataType = typeof(string);
              dtexcel.Columns[10].DataType = typeof(string);
              dtexcel.Columns[11].DataType = typeof(string);
              
              dtexcel.AcceptChanges();
          }
                if (mastertype.Equals("UserMaster"))
                {
                    dtexcel.Columns[3].DataType = typeof(DateTime);
                    dtexcel.AcceptChanges();
                }
                if (mastertype.Equals("BillofSupplyNumberInvoiceTemplate"))
                {
                    dtexcel.Columns[0].DataType = typeof(string);
                    dtexcel.Columns[1].DataType = typeof(string);
                    dtexcel.Columns[2].DataType = typeof(string);
                    dtexcel.Columns[3].DataType = typeof(string);
                    dtexcel.Columns[4].DataType = typeof(decimal);
                    dtexcel.Columns[5].DataType = typeof(string);
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

    private System.Data.DataTable ReadExcel(string fileName, string fileExt, string mastertype)
    {
        string conn = string.Empty;
        System.Data.DataTable dtexcel = new System.Data.DataTable();
        if (fileExt == ".xlsx")
        {
            conn = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fileName + ";Extended Properties=Excel 12.0";
        }
        else
        {
            conn = @"provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileName + ";Extended Properties=HTML Import;Persist Security Info=False;";
        }
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
                    dtexcel = ReadExcelxlsformat(fileName, fileExt, mastertype);
                    //Hashtable toReturn = new Hashtable();
                    //ExcelSheetHelper exhelper = new ExcelSheetHelper();
                    //toReturn = exhelper.FillAllDataFromExcelSheet(fileName);
                }
                else
                {
                    string cmd = "select * from [" + sTableName + "]";
                    OleDbDataAdapter oleAdpt = new OleDbDataAdapter(cmd, con);
                    oleAdpt.FillSchema(dtexcel, SchemaType.Source);
                    if (mastertype.Equals("RateMaster"))
                    {
                        dtexcel.Columns[0].DataType = typeof(Int32);
                        dtexcel.Columns[1].DataType = typeof(Int32);
                        dtexcel.Columns[2].DataType = typeof(string);
                        dtexcel.Columns[6].DataType = typeof(decimal);
                        dtexcel.AcceptChanges();
                    }
                    if (mastertype.Equals("DeviceTestMap"))
                    {
                        dtexcel.Columns[0].DataType = typeof(Int32);
                        dtexcel.Columns[1].DataType = typeof(string);
                        dtexcel.Columns[2].DataType = typeof(string);
                        dtexcel.Columns[4].DataType = typeof(Int64);
                        dtexcel.Columns[10].DataType = typeof(Int32);
                        dtexcel.Columns[11].DataType = typeof(Int64);
                        dtexcel.AcceptChanges();
                    }
		      if (mastertype.Equals("PhysicianMaster"))
                    {



                        dtexcel.Columns[0].DataType = typeof(Int64);//SERIALNUMBER

                        dtexcel.Columns[1].DataType = typeof(string);//PhysicianName
                        dtexcel.Columns[2].DataType = typeof(string);//PhysicianCode
                        dtexcel.Columns[3].DataType = typeof(DateTime);//DOB
                        dtexcel.Columns[4].DataType = typeof(string);//AGE
                        dtexcel.Columns[5].DataType = typeof(string);//SEX
                        dtexcel.Columns[6].DataType = typeof(string);//QUALIFICATION
                        dtexcel.Columns[7].DataType = typeof(string);//Designation
                        dtexcel.Columns[8].DataType = typeof(string);//Address1
                        dtexcel.Columns[9].DataType = typeof(string);//Address2
                        dtexcel.Columns[10].DataType = typeof(string);//city
                        dtexcel.Columns[11].DataType = typeof(string);//state
                        dtexcel.Columns[12].DataType = typeof(string);//country
                        dtexcel.Columns[13].DataType = typeof(string);//mobilenumber
                        dtexcel.Columns[14].DataType = typeof(string);//eMAILID
                        dtexcel.Columns[15].DataType = typeof(string);//LandLineNo
                        dtexcel.Columns[16].DataType = typeof(string);//FaxNo
                        dtexcel.Columns[17].DataType = typeof(string);//ISCLIENT
                        dtexcel.Columns[18].DataType = typeof(decimal);//DiscountLimit
                        dtexcel.Columns[19].DataType = typeof(DateTime);//DiscountValidFrom
                        dtexcel.Columns[20].DataType = typeof(DateTime);//DiscountValidTo
                        dtexcel.Columns[21].DataType = typeof(string); //HasReportingSms
                        dtexcel.Columns[22].DataType = typeof(string);//HasReportingEmail
                        dtexcel.Columns[23].DataType = typeof(string);//ReferalHospitalName
                        dtexcel.Columns[24].DataType = typeof(string);//ReferalHospitalCode
                        dtexcel.Columns[25].DataType = typeof(string);//FLAG
                        dtexcel.AcceptChanges();
                    }
              if (mastertype.Equals("LocationMaster"))
              {
                  dtexcel.Columns[8].DataType = typeof(string);
                  dtexcel.Columns[10].DataType = typeof(string);
                  dtexcel.Columns[11].DataType = typeof(string);

                  dtexcel.AcceptChanges();
              }
                    if (mastertype.Equals("UserMaster"))
                    {
                        dtexcel.Columns[3].DataType = typeof(DateTime);
                        dtexcel.AcceptChanges();
                    }
                    if (mastertype.Equals("BillofSupplyNumberInvoiceTemplate"))
                    {
                        dtexcel.Columns[0].DataType = typeof(string);
                        dtexcel.Columns[1].DataType = typeof(string);
                        dtexcel.Columns[2].DataType = typeof(string);
                        dtexcel.Columns[3].DataType = typeof(string);
                        dtexcel.Columns[4].DataType = typeof(decimal);
                        dtexcel.Columns[5].DataType = typeof(string);
                     
                        dtexcel.AcceptChanges();
                    }
                    oleAdpt.Fill(dtexcel);
                }
            }
            catch (Exception ex)
            {
                con.Close();
                CLogger.LogError("ReadExcel", ex);
            }
        }
        return dtexcel;
    }
    private void DeleteDirectoryfiles(string uploadedpath)
    {
        try
        {
            string Directorypath = uploadedpath;
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
        }
        catch (Exception ex)
        {
            CLogger.LogError("DeleteDirectoryfiles", ex);
        }
    }
    private string UploadData(string filetype, string type, int orgid, string filename, DataTable dt, int LID, string uploadedpath, string Emptycsvfilepath)
    {
        try
        {
            int noofrecords = 0;
            int duplicaterecords = 0;
            int updatedcount = 0;
            long returnCode = 0;
            string message = string.Empty;
            Deployability_BL Deployability_BL = new Deployability_BL(objbasepage.ContextInfo);
            bool results = true;
            results = CHKHEADER(dt, filetype, type, Emptycsvfilepath);

            if (results == false)
            {
                message = "Invalid File";
            }
            else
            {
                DeleteDirectoryfiles(uploadedpath);
                // Deletefiles();
                List<Stage2_MHL_T_01_TESTMASTER> lstInvestigationMaster = new List<Stage2_MHL_T_01_TESTMASTER>();
                List<Stage2_MHL_T_02_GROUP_MASTER> lstinvgroupmaster = new List<Stage2_MHL_T_02_GROUP_MASTER>();
                List<Stage2_MHL_T_03_Package_Master> lstinvgroupmasterPKG = new List<Stage2_MHL_T_03_Package_Master>();
                List<Stage2_MHL_T_05_PACKAGE_TESTS> lstpackagecontent = new List<Stage2_MHL_T_05_PACKAGE_TESTS>();
                List<Stage2_MHL_T_04_GROUP_TESTS> lstgroupcontent = new List<Stage2_MHL_T_04_GROUP_TESTS>();
                List<Stage_User_Template> lstUsers = new List<Stage_User_Template>();
                List<PStage_Physician> lstStagePhysician = new List<PStage_Physician>();
                List<Stage_LocationMaster> lstLocationMaster = new List<Stage_LocationMaster>();

                List<Stage_InvoiceBillSupplyNo_Template> lstInvoicebillsupplyno = new List<Stage_InvoiceBillSupplyNo_Template>();
                
                List<RateCardMaster> lstRateCardDetails = new List<RateCardMaster>();
                List<RateCardMaster> lstRateCardDetails_insert = new List<RateCardMaster>();
                List<DeviceTestOrgMapping> lstDeviceTestMap = new List<DeviceTestOrgMapping>();
                if (type.Equals("InvestigationMaster"))
                {
                    Utilities.ConvertTo(dt, out lstInvestigationMaster);
                    if (lstInvestigationMaster.Count > 0)
                    {
                        var vallstInvestigationMaster = (from Staging in lstInvestigationMaster where !string.IsNullOrEmpty(Staging.Flag) select Staging).ToList();
                        lstInvestigationMaster = vallstInvestigationMaster;
                        noofrecords = Convert.ToInt32(lstInvestigationMaster.Count);
                    }
                }
                else if (type.Equals("Group"))
                {
                    Utilities.ConvertTo(dt, out lstinvgroupmaster);
                    if (lstinvgroupmaster.Count > 0)
                    {
                        var vallstinvgroupmaster = (from Staging in lstinvgroupmaster where !string.IsNullOrEmpty(Staging.Flag) select Staging).ToList();
                        lstinvgroupmaster = vallstinvgroupmaster;
                        noofrecords = Convert.ToInt32(lstinvgroupmaster.Count);
                    }
                }
                else if (type.Equals("Package"))
                {
                    Utilities.ConvertTo(dt, out lstinvgroupmasterPKG);
                    if (lstinvgroupmasterPKG.Count > 0)
                    {
                        var vallstinvgroupmasterPKG = (from Staging in lstinvgroupmasterPKG where !string.IsNullOrEmpty(Staging.Flag) select Staging).ToList();
                        lstinvgroupmasterPKG = vallstinvgroupmasterPKG;
                        noofrecords = Convert.ToInt32(lstinvgroupmasterPKG.Count);
                    }
                }
                else if (type.Equals("Package Content"))
                {
                    Utilities.ConvertTo(dt, out lstpackagecontent);
                    var vallstpackagecontent = (from Staging in lstpackagecontent where !string.IsNullOrEmpty(Staging.Flag) select Staging).ToList();
                    lstpackagecontent = vallstpackagecontent;
                    noofrecords = Convert.ToInt32(lstpackagecontent.Count);
                }
                else if (type.Equals("UserMaster"))
                {
                    dt = UpdateUserPassword(dt);
                    Utilities.ConvertTo(dt, out lstUsers);
                    var usersstaging = (from Staging in lstUsers where !string.IsNullOrEmpty(Staging.LoginName) select Staging).ToList();
                    lstUsers = usersstaging;
                    noofrecords = Convert.ToInt32(lstUsers.Count);
                }
                else if (type.Equals("DeviceTestMap"))
                {
                    Utilities.ConvertTo(dt, out lstDeviceTestMap);
                    var devicestaging = (from Staging in lstDeviceTestMap where !string.IsNullOrEmpty(Staging.Flag) select Staging).ToList();
                    lstDeviceTestMap = devicestaging;
		    noofrecords = Convert.ToInt32(lstDeviceTestMap.Count);
                }
                else if (type.Equals("RateMaster"))
                {
                    Utilities.ConvertTo(dt, out lstRateCardDetails); //ConvertIntoRateCardList(dt, out returnmsg);
                    var ratemasterstaging_insert = (from Staging in lstRateCardDetails where Staging.Flag == "I" || Staging.Flag == "i" && !string.IsNullOrEmpty(Staging.TestCode) && !string.IsNullOrEmpty(Staging.RateName) && !string.IsNullOrEmpty(Staging.Rate.ToString()) select Staging).ToList();
                    lstRateCardDetails_insert = ratemasterstaging_insert;
                    var ratemasterstaging = (from Staging in lstRateCardDetails where !string.IsNullOrEmpty(Staging.Flag) && !string.IsNullOrEmpty(Staging.TestCode) && !string.IsNullOrEmpty(Staging.RateName) && !string.IsNullOrEmpty(Staging.Rate.ToString()) select Staging).ToList();
                    lstRateCardDetails = ratemasterstaging;
		     noofrecords = Convert.ToInt32(lstRateCardDetails.Count);
                }
		  else if (type.Equals("PhysicianMaster"))
                {

                    dt = UpdateEmailId(dt);
                    Utilities.ConvertTo(dt, out lstStagePhysician); //ConvertIntoRateCardList(dt, out returnmsg);

                    //var lstphysicians = (from Staging in lstStagePhysician where !string.IsNullOrEmpty(Staging.PhysicianName) && !string.IsNullOrEmpty(Staging.PhysicianCode) && !string.IsNullOrEmpty(Staging.Flag) select Staging).ToList();
                   // lstStagePhysician = lstphysicians;
                    noofrecords = Convert.ToInt32(lstStagePhysician.Count);
                }
                else if (type.Equals("LocationMaster"))
                {
                    Utilities.ConvertTo(dt, out lstLocationMaster); //ConvertIntoRateCardList(dt, out returnmsg);
                    var lstLocationMasters = (from Staging in lstLocationMaster where !string.IsNullOrEmpty(Staging.LocationName) && !string.IsNullOrEmpty(Staging.LocationCode) && !string.IsNullOrEmpty(Staging.Flag) select Staging).ToList();

                    lstLocationMaster = lstLocationMasters;
                    noofrecords = Convert.ToInt32(lstLocationMaster.Count);
                }
                else if (type.Equals("BillofSupplyNumberInvoiceTemplate"))
                {
                    Utilities.ConvertTo(dt, out lstInvoicebillsupplyno);

                    var lstInvoicebillsupplynumber = (from Staging in lstInvoicebillsupplyno where !string.IsNullOrEmpty(Staging.ClientCode)  select Staging).ToList();

                    lstInvoicebillsupplyno = lstInvoicebillsupplynumber;
                    noofrecords = Convert.ToInt32(lstInvoicebillsupplyno.Count);
                }
                else
                {
                    Utilities.ConvertTo(dt, out lstgroupcontent);
                    if (lstgroupcontent.Count > 0)
                    {
                        var vallstgroupcontent = (from Staging in lstgroupcontent where !string.IsNullOrEmpty(Staging.Flag) select Staging).ToList();
                        lstgroupcontent = vallstgroupcontent;
			 noofrecords = Convert.ToInt32(lstgroupcontent.Count);
                    }
                }

             
                if (noofrecords == 0)
                {
                    message = "No records Updated";
                }
                else
                {
                    if (type.Equals("RateMaster"))
                    {
                        if (lstRateCardDetails_insert.Count == 0)
                        {
                            List<RateCardMaster> lstInvClientMaster = new List<RateCardMaster>();
                            noofrecords = Convert.ToInt32(lstRateCardDetails.Count);
                            if (noofrecords > 0)
                            {
                                returnCode = new Deployability_BL(new BaseClass().ContextInfo).BulkUpdateRatesDetails(orgid, lstRateCardDetails, out lstInvClientMaster);
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
                    else if (type.Equals("DeviceTestMap"))
                    {
                            returnCode = new Deployability_BL(new BaseClass().ContextInfo).BulkInsertUpdateDeviceMapping(orgid,lstDeviceTestMap);

                            if ((returnCode <= -1) || (returnCode == 1001))
                        {
                            message = "No records Updated";
                        }
                        else
                        {
                            message = "Successfully Uploaded";
                        }
                    }
   else if (type.Equals("LocationMaster"))
                    {
                        noofrecords = Convert.ToInt32(lstLocationMaster.Count);
                        if (noofrecords > 0)
                        {
                            returnCode = new Deployability_BL(new BaseClass().ContextInfo).BulkInsertLocationMaster(lstLocationMaster, out duplicaterecords, out updatedcount);
                        }
                        if (noofrecords == 0 || (returnCode <= -1) || (returnCode == 1001))
                        {
                            message = "No records Updated";
                        }
                        else if (duplicaterecords > 0)
                        {
                            message = "No of  Records:" + noofrecords + " No of Duplicate Records:" + duplicaterecords + " Updated Records:" + updatedcount;
                        }
                        else
                        {
                            message = "Completed";
                        }
                    }


                    else if (type.Equals("PhysicianMaster"))
                    {
                        noofrecords = Convert.ToInt32(lstStagePhysician.Count);
                        if (noofrecords > 0)
                        {
                            returnCode = new Deployability_BL(new BaseClass().ContextInfo).BulkInsertPhysician(lstStagePhysician, out duplicaterecords, out updatedcount);
                        }
                        if (noofrecords == 0 || (returnCode <= -1) || (returnCode == 1001))
                        {
                            message = "No records Updated";
                        }
                        else if (duplicaterecords > 0)
                        {
                            message = "No of  Records:" + noofrecords + " No of Duplicate Records:" + duplicaterecords + " Updated Records:" + updatedcount;
                        }
                        else
                        {
                            message = "Completed";
                        }
                    }
                    else if (type.Equals("UserMaster"))
                    {
                        noofrecords = Convert.ToInt32(lstUsers.Count);
                        if (noofrecords > 0)
                        {
                            returnCode = new Deployability_BL(new BaseClass().ContextInfo).BulkInsertUserMaster(lstUsers, out duplicaterecords, out updatedcount);
                        }
                        if (noofrecords == 0 || (returnCode <= -1) || (returnCode == 1001))
                        {
                            message = "No records Updated";
                        }
                        else if (duplicaterecords > 0)
                        {
                            message = "No of  Records:" + noofrecords + " No of Duplicate Records:" + duplicaterecords + " Updated Records:" + updatedcount;
                        }
                        else
                        {
                            message = "Completed";
                        }
                    }

                    else if (type.Equals("BillofSupplyNumberInvoiceTemplate"))
                    {
                        noofrecords = Convert.ToInt32(lstInvoicebillsupplyno.Count);

                        if (noofrecords > 0)
                        {
                            returnCode = new Deployability_BL(new BaseClass().ContextInfo).BulkUpdatebillSupplyNo(lstInvoicebillsupplyno, out duplicaterecords, out updatedcount);
                        }
                        if (noofrecords == 0 || (returnCode <= -1) || (returnCode == 1001))
                        {
                            message = "No records Updated";
                        }
                        else if (duplicaterecords > 0)
                        {
                            message = "No of  Records:" + noofrecords + " No of Duplicate Records:" + duplicaterecords + " Updated Records:" + updatedcount;
                        }
                        else
                        {
                            message = "Completed";
                        }
                       
                    }
                    else
                    {
                        returnCode = new Deployability_BL(new BaseClass().ContextInfo).getTestInsertUpdate(orgid, lstinvgroupmaster, lstinvgroupmasterPKG, lstInvestigationMaster, lstpackagecontent, lstgroupcontent);
                        if (noofrecords == 0 || (returnCode <= -1) || (returnCode == 1001))
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
                    Resultmsg = message;
                    InsertInvGrpPkgLog(0, filename, message, LID, type, orgid);
                }

            }
            Resultmsg = message;
        }
        catch (Exception ex)
        {
            CLogger.LogError("UploadData()" + ex.Message, ex);
        }
        return Resultmsg;
    }

    //Insert function for Log Data
    private void InsertInvGrpPkgLog(long insertreturncode, string filename, string Status, int LID, string mastertype, int orgid)
    {
        int lid = Convert.ToInt32(LID);
        Deployability_BL = new Deployability_BL(objbasepage.ContextInfo);
        long returnCode = -1;
        string originalfilename = System.IO.Path.GetFileNameWithoutExtension(filename); //System.IO.Path.GetFileNameWithoutExtension(fileupload1.FileName);
        string type = mastertype;//ddltype.SelectedValue;
        if (insertreturncode == 0)
        {
            SuccessMsg(Status);
        }
        returnCode = Deployability_BL.InsertInvGrpPkgLog(orgid, type, originalfilename, lid, Status);
    }

    private void SuccessMsg(string Status)
    {
        if (Status.Equals("Completed"))
        {
            Status = "Successfully Uploaded the records";
        }
    }

    private DataTable HeaderCheckingGetDataFromExcel(string filetype, string mastertype, string csvfilepath)
    {
        try
        {
            string pathname = string.Empty;
            string fileNamess = "";
            string selectedfileformat = filetype;//ddlfiletype.SelectedValue;
            DataTable dtupdatedata = new DataTable();

            if (mastertype.Equals("Group"))
            {
                fileNamess = "Groupmaster";
            }
            if (mastertype.Equals("Package"))
            {
                fileNamess = "Packagemaster"; //UserMaster
            }
            if (mastertype.Equals("Group Content"))
            {
                fileNamess = "Groupcontent";//UserMaster
            }
            if (mastertype.Equals("Package Content"))
            {
                fileNamess = "Packagecontent";//UserMaster
            }
            if (mastertype.Equals("InvestigationMaster"))
            {
                fileNamess = "Investigationmaster";//UserMaster
            }
            if (mastertype.Equals("RateMaster"))
            {
                fileNamess = mastertype;//UserMaster
            }
            if (mastertype.Equals("DeviceTestMap"))
            {
                fileNamess = mastertype;//UserMaster
            }
            if (mastertype.Equals("UserMaster"))
            {
                fileNamess = mastertype;//UserMaster
            }
            if (mastertype.Equals("BillofSupplyNumberInvoiceTemplate"))
            {
                fileNamess = mastertype;
            }
            filepath = csvfilepath;// Server.MapPath("~/BulkDataUploadformat/") + fileNamess + ".csv";
            dtupdatedata = GetDataTabletFromCSVFile(filepath, mastertype);// Test(full, "test", ",");
            return dtupdatedata;
        }
        catch (Exception ex)
        {
            CLogger.LogError("HeaderCheckingGetDataFromExcel", ex);
            throw ex;
        }
    }
    private bool CHKHEADER(DataTable dt, string filetype, string type, string csvfilepath)
    {
        bool RESULT = false;
        DataTable dtHeader = new DataTable();
        dtHeader = HeaderCheckingGetDataFromExcel(filetype, type, csvfilepath);
        try
        {
            for (int j = 0; j < dtHeader.Columns.Count; j++)
            {
                if (string.Equals(dt.Columns[j].ColumnName.Trim(), dtHeader.Columns[j].ColumnName.Trim(), StringComparison.OrdinalIgnoreCase))
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
        { 
            CLogger.LogError("CHKHEADER()", ex);
        }
        return RESULT;
    }

    private DataTable UploadCSV(string filevalue, string type, string htmlcodefilename, string uploadcsvnewfilepath, FileUpload fileuploadcontrol)
    {
        string pathname = string.Empty;
        string filenameex = "";
        string filename = "";
        string selectedfileformat = filevalue;//ddlfiletype.SelectedValue;
        DataTable dtupdatedata = new DataTable();
        try
        {
            filename = htmlcodefilename;// Server.HtmlEncode(fileupload1.FileName);
            string DatetimeNow = DateTime.Now.ToString("yyyyMMddHHmmssfff");
            filenameex = System.IO.Path.GetExtension(filename);
            filename = filename.Replace(".csv", "") + "_" + DatetimeNow + filenameex;
            string newfilepath = uploadcsvnewfilepath;//Server.MapPath("~/ExcelTest/" + filename);
            fileuploadcontrol.SaveAs(newfilepath);
            string full = System.IO.Path.GetFullPath(newfilepath);
            string tempfull = newfilepath;
            string file = System.IO.Path.GetFileName(full);
            string dir = System.IO.Path.GetDirectoryName(full);
            string temp = newfilepath;
            dtupdatedata = GetDataTabletFromCSVFile(temp, type);// Test(full, "test", ",");
            if (type.Equals("UserMaster"))
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

    private DataTable GetDataTabletFromCSVFile(string csv_file_path, string type)
    {
        DataTable csvData = new DataTable();
        try
        {
            using (TextFieldParser csvReader = new TextFieldParser(csv_file_path))
            {
                csvReader.SetDelimiters(new string[] { "," });
                csvReader.HasFieldsEnclosedInQuotes = true;
                string[] colFields = csvReader.ReadFields();
                foreach (string column in colFields)
                {
                    DataColumn datecolumn = new DataColumn(column);
                    datecolumn.AllowDBNull = true;
                    csvData.Columns.Add(datecolumn);
                }

                if (type.Equals("RateMaster"))
                {
                    csvData.Columns[0].DataType = typeof(Int32);
                    csvData.Columns[1].DataType = typeof(Int32);
                    csvData.Columns[6].DataType = typeof(decimal);
                    csvData.AcceptChanges();
                }
                if (type.Equals("DeviceTestMap"))
                {
                    csvData.Columns[0].DataType = typeof(Int32);
                    csvData.Columns[1].DataType = typeof(string);
                    csvData.Columns[2].DataType = typeof(string);
                    csvData.Columns[4].DataType = typeof(Int64);
                    csvData.Columns[10].DataType = typeof(Int32);
                    csvData.Columns[11].DataType = typeof(Int64);
                    csvData.AcceptChanges();
                }
                if (type.Equals("UserMaster"))
                {
                    csvData.Columns[3].DataType = typeof(DateTime);
                    csvData.AcceptChanges();
                }
                if (type.Equals("BillofSupplyNumberInvoiceTemplate"))
                {
                   
                    csvData.Columns[4].DataType = typeof(decimal);
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
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}