using System;
using System.Collections.Generic;
using System.Linq;
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
using InvBulkDataBusinessLogic;


public partial class InvestigationBulkData_InvCreateUpdate : BasePage
{
    DataTable dtupdatedata;
    InvBulkDataUpload_BL invBulkDataUpload_BL;
    List<InvCreateUpdate> lsterrorinfo = new List<InvCreateUpdate>();
    StreamReader s = null;
    string originalfilename = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadMetadata();           
        }
        BindLogInfo();
        
    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay();
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    protected void btnupload_Click(object sender, EventArgs e)
    {
        string pathname = string.Empty;
        string filenameex = "";
        string filetype = "";
        string filename = "";
        string uploadedFile = string.Empty;

        string CacheTempFull = string.Empty;
        string CacheTempFileName = string.Empty;
        string selectedfileformat = ddlfiletype.SelectedValue;
        long errreturncode = -1;
        if(ddltype.SelectedValue!="0")
        {
        if (fileupload1.HasFile)
        {
            #region ForCSVupload
            if (selectedfileformat == "1" && selectedfileformat!="")
            {                             
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

                    temp = temp.Replace(".csv", ".txt");
                    System.IO.File.Move(full, temp.Replace(".csv", ".txt"));
                    full = temp;

                    //Change File Name here
                    filename = filename.Replace(".csv", ".txt");
                    CacheTempFull = full;
                    CacheTempFileName = filename;
                    DataTable dtupdatedata = Test(full, "test", ",");
                    pathname = GetConfigValue("TRF_UploadPath", OrgID);
                    fileupload1.SaveAs( pathname+ fileupload1.FileName.ToString());
                    originalfilename = System.IO.Path.GetFileNameWithoutExtension(fileupload1.FileName);
                    if (dtupdatedata.Rows.Count > 0)
                    {
                        //To remove empty row from datatable
                        for (int i = 0; i < dtupdatedata.Rows.Count; i++)
                        {
                            if (dtupdatedata.Rows[i].IsNull(0) == true)
                            {
                                dtupdatedata.Rows[i].Delete();
                               
                            }                            
                        }
                        dtupdatedata.AcceptChanges();

                        invBulkDataUpload_BL = new InvBulkDataUpload_BL(base.ContextInfo);
                        if (ddltype.SelectedValue == "TestMaster")
                        {
                            errreturncode = Validatedata(dtupdatedata);
                            InsertInvGrpPkgLog(errreturncode, filename);
                            
                        }
                        if (ddltype.SelectedValue == "GroupMaster")
                        {
                            errreturncode = Validatedata(dtupdatedata);
                            InsertInvGrpPkgLog(errreturncode, filename);
                           
                        }
                        if (ddltype.SelectedValue == "PackageMaster")
                        {
                            errreturncode = Validatedata(dtupdatedata);
                            InsertInvGrpPkgLog(errreturncode, filename);
                        }
                        if (ddltype.SelectedValue == "GroupContentMaster")
                        {
                            errreturncode = Validatedata(dtupdatedata);
                            InsertInvGrpPkgLog(errreturncode, filename);
                        }
                        if (ddltype.SelectedValue == "Packagecontent")
                        {
                            errreturncode = Validatedata(dtupdatedata);
                            InsertInvGrpPkgLog(errreturncode, filename);
                        }
                        dtupdatedata.Clear();
                        if (System.IO.File.Exists(uploadedFile))
                            System.IO.File.Delete(uploadedFile);
                        if (File.Exists(newfilepath))
                        {
                            File.Delete(newfilepath);
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alrexcel", "alert('Incorrect Excel sheet or Empty Excel sheet');", true);
                    }
                }
                catch(Exception ex)
                {
                    NotSuccessMsg();
                }
            }
            #endregion
            #region ForExcelupload
            if (selectedfileformat == "2" && selectedfileformat != "")
            {
                string connString = "";
                string inputdata = "";
                errreturncode = -1;
                long insertreturncode = -1;
                OleDbCommand cmdupdatedata;
                OleDbDataAdapter daupdatedata;
                filenameex = Path.GetExtension(fileupload1.FileName.ToString());
                filetype = filenameex.Trim().ToString();
                originalfilename = System.IO.Path.GetFileNameWithoutExtension(fileupload1.FileName);
                if (filetype == ".xls" || filetype == ".xlsx")
                {
                    try
                    {
                        fileupload1.SaveAs(Server.MapPath("" + fileupload1.FileName.ToString()));
                        uploadedFile = (Server.MapPath("" + fileupload1.FileName.ToString()));
                        //Connection String to Excel Workbook
                        if (filetype.Trim() == ".xls")
                        {
                            connString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + uploadedFile + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                        }
                        else if (filetype.Trim() == ".xlsx")
                        {
                            connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + uploadedFile + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                        }
                        OleDbConnection conn = new OleDbConnection(connString);
                        if (conn.State == ConnectionState.Closed)
                            conn.Open();
                        dtupdatedata = new DataTable();
                        DataTable Sheets = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                        if (ddltype.SelectedValue == "TestMaster")
                        {
                            foreach (DataRow dr in Sheets.Rows)
                            {
                                string sht = dr[2].ToString().Replace("'", "");
                                if (sht == "Testmaster$")
                                {
                                    inputdata = "SELECT * FROM [Testmaster$]";
                                    cmdupdatedata = new OleDbCommand(inputdata, conn);
                                    daupdatedata = new OleDbDataAdapter(cmdupdatedata);
                                    daupdatedata.Fill(dtupdatedata);
                                }

                            }
                        }
                        if (ddltype.SelectedValue == "GroupMaster")
                        {
                            foreach (DataRow dr in Sheets.Rows)
                            {
                                string sht = dr[2].ToString().Replace("'", "");
                                if (sht == "Groupmaster$")
                                {
                                    inputdata = "SELECT * FROM [Groupmaster$]";
                                    cmdupdatedata = new OleDbCommand(inputdata, conn);
                                    daupdatedata = new OleDbDataAdapter(cmdupdatedata);
                                    daupdatedata.Fill(dtupdatedata);
                                }
                            }
                        }
                        if (ddltype.SelectedValue == "PackageMaster")
                        {
                            foreach (DataRow dr in Sheets.Rows)
                            {
                                string sht = dr[2].ToString().Replace("'", "");
                                if (sht == "Packagemaster$")
                                {
                                    inputdata = "SELECT * FROM [Packagemaster$]";
                                    cmdupdatedata = new OleDbCommand(inputdata, conn);
                                    daupdatedata = new OleDbDataAdapter(cmdupdatedata);
                                    daupdatedata.Fill(dtupdatedata);
                                }
                            }
                        }
                        if (ddltype.SelectedValue == "GroupContentMaster")
                        {
                            foreach (DataRow dr in Sheets.Rows)
                            {
                                string sht = dr[2].ToString().Replace("'", "");
                                if (sht == "Groupcontent$")
                                {
                                    inputdata = "SELECT * FROM [Groupcontent$]";
                                    cmdupdatedata = new OleDbCommand(inputdata, conn);
                                    daupdatedata = new OleDbDataAdapter(cmdupdatedata);
                                    daupdatedata.Fill(dtupdatedata);
                                }
                            }
                        }
                        if (ddltype.SelectedValue == "Packagecontent")
                        {

                            foreach (DataRow dr in Sheets.Rows)
                            {
                                string sht = dr[2].ToString().Replace("'", "");
                                if (sht == "Packagecontent$")
                                {
                                    inputdata = "SELECT * FROM [Packagecontent$]";
                                    cmdupdatedata = new OleDbCommand(inputdata, conn);
                                    daupdatedata = new OleDbDataAdapter(cmdupdatedata);
                                    daupdatedata.Fill(dtupdatedata);
                                }
                            }
                        }
                        conn.Close();
                        conn.Dispose();

                        if (dtupdatedata.Rows.Count > 0)
                        {
                            //To remove empty row from datatable
                            for (int i = 0; i < dtupdatedata.Rows.Count; i++)
                            {
                                if (dtupdatedata.Rows[i].IsNull(0) == true)
                                {
                                    dtupdatedata.Rows[i].Delete();

                                }
                            }
                            dtupdatedata.AcceptChanges();
                            invBulkDataUpload_BL = new InvBulkDataUpload_BL(base.ContextInfo);
                            if (ddltype.SelectedValue == "TestMaster")
                            {
                                errreturncode = Validatedata(dtupdatedata);
                                InsertInvGrpPkgLog(errreturncode, filename);

                            }
                            if (ddltype.SelectedValue == "GroupMaster")
                            {
                                errreturncode = Validatedata(dtupdatedata);
                                InsertInvGrpPkgLog(errreturncode, filename);

                            }
                            if (ddltype.SelectedValue == "PackageMaster")
                            {
                                errreturncode = Validatedata(dtupdatedata);
                                InsertInvGrpPkgLog(errreturncode, filename);
                            }
                            if (ddltype.SelectedValue == "GroupContentMaster")
                            {
                                errreturncode = Validatedata(dtupdatedata);
                                InsertInvGrpPkgLog(errreturncode, filename);
                            }
                            if (ddltype.SelectedValue == "Packagecontent")
                            {
                                errreturncode = Validatedata(dtupdatedata);
                                InsertInvGrpPkgLog(errreturncode, filename);
                            }
                            dtupdatedata.Clear();
                            if (System.IO.File.Exists(uploadedFile))
                                System.IO.File.Delete(uploadedFile);
                            if (File.Exists(uploadedFile))
                            {
                                File.Delete(uploadedFile);
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alrexcel", "alert('Incorrect Excel sheet or Empty Excel sheet');", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        NotSuccessMsg();
                    }
                }
            }
            #endregion
        }
    }
    else
      {
          ScriptManager.RegisterStartupScript(this, this.GetType(), "alrtypemissing", "alert('Select the type');", true);
      }
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
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);
        }
    }
    public void SuccessMsg()
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "alert('Inserted Successfully');", true);
        grderrorinfo.Visible = false;
    }
    public void NotSuccessMsg()
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "alert('Not Inserted');", true);
    }
    //Insert function for Log Data
    public void InsertInvGrpPkgLog(long insertreturncode, string filename)
    {
        int lid = Convert.ToInt16(LID);
        if (insertreturncode == 0)
        {
            SuccessMsg();
            invBulkDataUpload_BL.InsertInvGrpPkgLog(OrgID, ddltype.SelectedValue, originalfilename, lid, "Completed");
        }
        else
        {
            NotSuccessMsg();
            invBulkDataUpload_BL.InsertInvGrpPkgLog(OrgID, ddltype.SelectedValue, originalfilename, lid, "Not Completed");
        }
        BindLogInfo();
    }
    //To bind log info into Grid
    public void BindLogInfo()
    {
        long returnCode = -1;
        List<InvCreateUpdate> lstloginfo = new List<InvCreateUpdate>();
        InvBulkDataUpload_BL invBulkDataUpload_BL = new InvBulkDataUpload_BL(base.ContextInfo);
        returnCode = invBulkDataUpload_BL.GetInvGrpPkgLog(OrgID, out lstloginfo);
        if (lstloginfo.Count > 0)
        {
            grdloginfo.Attributes.Add("style", "block");
            grdloginfo.Visible = true;
            grdloginfo.DataSource = lstloginfo;
            grdloginfo.DataBind();

        }
        else
        {
            grdloginfo.Attributes.Add("style", "none");
            grdloginfo.Visible = false;
        }
    }
    protected void grdloginfo_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                grdloginfo.PageIndex = e.NewPageIndex;
                grdloginfo.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("err", ex);
        }
    }
    //Validate function for Master data
    public long Validatedata(DataTable dtupdatedata)
    {
       long noerror=-1;
       try
       {
            if (ddltype.SelectedValue == "TestMaster")
            {
                noerror = invBulkDataUpload_BL.ValidateTestMasterData(dtupdatedata, OrgID);
                if(noerror>0)
                {
                    BindErrorLog();
                }
            }
            if (ddltype.SelectedValue == "GroupMaster")
            {
                noerror = invBulkDataUpload_BL.ValidateGrpMasterData(dtupdatedata, OrgID);
                if (noerror > 0)
                {
                    BindErrorLog();
                }
            }
            if (ddltype.SelectedValue == "PackageMaster")
            {
                noerror = invBulkDataUpload_BL.ValidatePkgMasterData(dtupdatedata, OrgID);
                if (noerror > 0)
                {
                    BindErrorLog();
                }
            }
            if (ddltype.SelectedValue == "GroupContentMaster")
            {
                noerror = invBulkDataUpload_BL.ValidateGrpContentData(dtupdatedata, OrgID);
                if (noerror > 0)
                {
                    BindErrorLog();
                }
            }
            if (ddltype.SelectedValue == "Packagecontent")
            {
                noerror = invBulkDataUpload_BL.ValidatePkgContentData(dtupdatedata, OrgID);
                if (noerror > 0)
                {
                    BindErrorLog();
                }
            }
        }
    
    catch
   {
   }
    return noerror;
    }
    protected void grderrorinfo_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                BindErrorLog();
                grderrorinfo.PageIndex = e.NewPageIndex;
                grderrorinfo.DataBind();
                grderrorinfo.Visible = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("err", ex);
        }
    }
    //To bind Error info into Grid
    public void BindErrorLog()
    {
        long returnCode = -1;
        List<InvCreateUpdate> lstloginfo = new List<InvCreateUpdate>();
        InvBulkDataUpload_BL invBulkDataUpload_BL = new InvBulkDataUpload_BL(base.ContextInfo);
        returnCode = invBulkDataUpload_BL.GetInvGrpPkgError(out lsterrorinfo);
        if (lsterrorinfo.Count > 0)
        {
            grderrorinfo.DataSource = lsterrorinfo;
            grderrorinfo.DataBind();
            grderrorinfo.Visible = true;
        }
        else
        {
            grderrorinfo.Visible = false;
        }
    }
    public DataTable Test(string File, string TableName, string delimiter)
    {
        //The DataSet to Return
        DataTable result = new DataTable();
        //Open the file in a stream reader.
        s = new StreamReader(File);
        //Split the first line into the columns       
        string[] columns = s.ReadLine().Split(delimiter.ToCharArray());
        //Cycle the colums, adding those that don't exist yet 
        //and sequencing the one that do.
        foreach (string col in columns)
        {
            bool added = false;
            string next = "";
            int i = 0;
            while (!added)
            {
                //Build the column name and remove any unwanted characters.
                string columnname = col + next;
                columnname = columnname.Replace("#", "");
                columnname = columnname.Replace("'", "");
                columnname = columnname.Replace("&", "");

                //See if the column already exists
                if (!result.Columns.Contains(columnname))
                {
                    //if it doesn't then we add it here and mark it as added
                    result.Columns.Add(columnname);
                    added = true;
                }
                else
                {
                    //if it did exist then we increment the sequencer and try again.
                    i++;
                    next = "_" + i.ToString();
                }
            }
        }
        //Read the rest of the data in the file.        
        string AllData = s.ReadToEnd();
        
        //Split off each row at the Carriage Return/Line Feed
        //Default line ending in most windows exports.  
        //You may have to edit this to match your particular file.
        //This will work for Excel, Access, etc. default exports.
       
        string[] rows = AllData.Split("\r\n".ToCharArray());

        //Now add each row to the DataSet        
        foreach (string r in rows)
        {
            if (!string.IsNullOrEmpty(r))
            {
                //Split the row at the delimiter.
                string[] items = r.Split(delimiter.ToCharArray());
                //Add the item
                result.Rows.Add(items);
            }
        }
        // int val = Convert.ToInt16("dsfsdf");
        s.Close();
        //Return the imported data. 
        return result;
    }
}




















