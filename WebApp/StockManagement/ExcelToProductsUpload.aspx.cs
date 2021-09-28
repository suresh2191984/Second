using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Web.UI.HtmlControls;
using System.Web.Script.Serialization;
using System.IO;
using System.Data.OleDb;
using System.Data;
using OfficeOpenXml;
using Excel;
using System.ComponentModel;
using System.Data.SqlClient;
using Attune.Kernel.StockManagement.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.BL;

public partial class StockManagement_ExcelToProductsUpload : Attune_BasePage
{
    public StockManagement_ExcelToProductsUpload()
        : base("StockManagement_ExcelToProductsUpload_aspx")
    { }
    StockManagement_BL inventoryBL;
    List<Locations> lstLocation = new List<Locations>();
    Dictionary<int, string> dictColPositions = new Dictionary<int, string>();
    #region
    string strSupplierMsg = Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_12 == null ? "Supplier name Not Exist. please add supplier before upload" : Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_12;
    string strLSUMsg = Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_13 == null ? "LSU Does Not Exist.Please correct it before upload" : Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_13;
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            LoadLocationName();
            LoadExcelTempate();
            BindCategory();
        }
    }

    private void LoadExcelTempate()
    {
        DataTable sdt = new DataTable();
        sdt = GenerateSampleUploadTable();
        GridLoadExcelTempate.DataSource = sdt;
        GridLoadExcelTempate.DataBind();
    }

    private void LoadLocationName()
    {
        try
        {
            int OrgAddid = 0;
            new Master_BL(base.ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocation);
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlLocation.Items.Insert(0, ddlselect);

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details in ProductUploaad screen", Ex);
        }
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        string filename = Path.GetFullPath(xlsUpload.PostedFile.FileName);
        string sheetname = "Sheet1";
        string status = string.Empty;
        int InventoryLocationID = Convert.ToInt32(ddlLocation.SelectedValue);
        int orgID = OrgID;

        DataTable dt = new DataTable();
        dt = GetTable(filename, sheetname);



        if (dt.Rows.Count > 0)
        {
            int StockReceivedID = 0;
            StockManagement_BL inventoryBL1 = new StockManagement_BL(base.ContextInfo);
            returnCode = inventoryBL1.ExcelProductUploadBL(InventoryLocationID, orgID, dt, out StockReceivedID);
            #region direct_call_to_DB
            //SqlCommand cmd = new SqlCommand();
            //cmd.CommandText = "pInsertExcelToProductUpload";
            //cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@InventoryLocationID", InventoryLocationID);
            //cmd.Parameters.AddWithValue("@OrgID", OrgID);
            //cmd.Parameters.AddWithValue("@pExcelProducts", dt);
            //cmd.Parameters.AddWithValue("@ContextInfo", UDT_DAL.ConvertToUDT_Context(this.ContextInfo));
            //cmd.Parameters.Add(new SqlParameter() { Direction = ParameterDirection.Output, ParameterName = "@StockReceivedID", Value = StockReceivedID });

            //using (SqlConnection con=new SqlConnection())
            //{
            //    con.ConnectionString = Utilities.GetConnectionString();
            //    cmd.Connection = con;
            //    if (con.State == ConnectionState.Closed)
            //        con.Open();
            //    cmd.ExecuteNonQuery();
            //    StockReceivedID = Convert.ToInt32(cmd.Parameters["@StockReceivedID"].Value.ToString());
            //    if (con.State == ConnectionState.Open)
            //        con.Close();
            //}
            #endregion
            if (StockReceivedID > 0)
            {
                
                string struserMsg = Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_02;
                struserMsg = struserMsg == null ? "Details Uploaded sucessfully..." : struserMsg;

               // string struserMsg=Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_02==null?"":Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_02;
                lblFormat.Text = struserMsg;
                Response.Redirect("../StockReceived/ViewStockReceived.aspx?id=" + Convert.ToString(StockReceivedID));
            }
        }
        else if (dt.Rows.Count < 1)
        {
            
            string sPath = Resources.StockManagement_AppMsg.StockManagement_ExcelToProductsUpload_aspx_06;
            sPath = sPath == null ? "Please correct Highlighted Datas's .. !" : sPath;

            string errorMsg = Resources.StockManagement_AppMsg.StockManagement_Error;
            errorMsg = errorMsg == null ? "Error" : errorMsg;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ValidationWindow('" + sPath + "','" + errorMsg + "');", true);
        
        }

    }

    private DataTable GenerateSampleUploadTable()
    {
        DataTable sampedt = new DataTable();

        List<DynamicColumnMapping> lstColumnName = GetProductUploadTable();
        for (int i = 0; i < lstColumnName.Count; i++)
        {
            sampedt.Columns.Add(lstColumnName[i].SearchColumnName);
        }
        DataRow dr = sampedt.NewRow();
        for (int i = 0; i < lstColumnName.Count; i++)
        {
            switch (lstColumnName[i].SearchTypeName.ToLower())
            {
                case "varchar":
                case "char":
                case "nvarchar":
                case "text":
                case "ntext":
                    if (lstColumnName[i].SearchColumnName == "LSU") { dr[lstColumnName[i].SearchColumnName] = "Nos"; }
                    else
                    {
                        dr[lstColumnName[i].SearchColumnName] = "test " + lstColumnName[i].SearchColumnName;
                    }

                    break;
                case "int":
                case "smallint":
                case "tinyint":
                case "bigint":
                    dr[lstColumnName[i].SearchColumnName] = "1";
                    break;
                case "datetime":
                    dr[lstColumnName[i].SearchColumnName] = "12/31/2014";
                    break;
                case "decimal":
                    dr[lstColumnName[i].SearchColumnName] = "1.1";
                    break;
                case "bit":
                    dr[lstColumnName[i].SearchColumnName] = false;
                    break;
                default:
                    break;

            }

        }
        sampedt.Rows.Add(dr);
        return sampedt;
    }

    private List<DynamicColumnMapping> GetProductUploadTable()
    {

        #region Get column and data type for validation
        List<DynamicColumnMapping> lstColumnName = new List<DynamicColumnMapping>();
        StockManagement_BL inventoryBL = new StockManagement_BL(this.ContextInfo);
        inventoryBL.GetUDTColumnTypes("ExcelProductDetails", out lstColumnName);
        DynamicColumnMapping it = new DynamicColumnMapping();
        it.SearchColumnName = "ProductKey";
        it.SearchTypeName = "nvarchar";
        lstColumnName.Add(it);

        #endregion
        return lstColumnName;
    }
    public DataTable GetTable(string filename, string SheetName)
    {
        FileStream stream = null;
        DataTable dt = new DataTable();
        DataTable dtProductKey = new DataTable();
        DataTable dtDupProductKey = new DataTable();
        List<string> lstSuppliers = new List<string>();
        List<string> lstInventoryUOM = new List<string>();
        List<string> lstMFT_EXP_Mismatch = new List<string>();

        List<InventoryItemsBasket> lstInventory = new List<InventoryItemsBasket>();
       

        try
        {
            FileInfo fi = new FileInfo(filename);
            string fleUpload = Path.GetExtension(xlsUpload.FileName.ToString());
            string strFileType = fleUpload.Trim().ToLower();
            if (!(strFileType == ".xls" || strFileType == ".xlsx"))
                throw new Exception("File must be .xls or .xlsx Format");

            string flagPNAME = string.Empty;
            string flagCNAME = string.Empty;
            string flagBNO = string.Empty;
            string flagLSU = string.Empty;
            string flagQTY = string.Empty;
            string flagCP = string.Empty;
            string flagSP = string.Empty;
            // Check if the file exists
            if (xlsUpload.PostedFile.InputStream == null)
                throw new Exception("File " + filename + " Does Not Exists");

            using (ExcelPackage xlPackage = new ExcelPackage(xlsUpload.PostedFile.InputStream))
            {

                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets[SheetName];
                if (worksheet == null)
                    throw new Exception("Sheetname doesnot exisit");

                ExcelCellAddress startCell = worksheet.Dimension.Start;
                ExcelCellAddress endCell = worksheet.Dimension.End;



                DataTable ErrorDt = new DataTable();
                List<DynamicColumnMapping> lstColumnName = GetProductUploadTable();
                Dictionary<string, Type> dictColTypes = new Dictionary<string, Type>();
                // create all the needed DataColumn
                for (int i = 0; i < lstColumnName.Count; i++)
                {
                    Type ColType = null;
                    switch (lstColumnName[i].SearchTypeName.ToLower())
                    {
                        case "varchar":
                        case "char":
                        case "nvarchar":
                        case "text":
                        case "ntext":
                            ColType = typeof(string);
                            break;
                        case "int":
                        case "smallint":
                            ColType = typeof(Int16);
                            break;
                        case "tinyint":
                            ColType = typeof(Int32);
                            break;
                        case "bigint":
                            ColType = typeof(Int64);
                            break;
                        case "datetime":
                            ColType = typeof(DateTime);
                            break;
                        case "decimal":
                            ColType = typeof(Double);
                            break;
                        case "bit":
                            ColType = typeof(Boolean);
                            break;
                        default:
                            break;
                    }

                    if (!dictColTypes.ContainsKey(lstColumnName[i].SearchColumnName))
                    {
                        dt.Columns.Add(lstColumnName[i].SearchColumnName, ColType);
                        ErrorDt.Columns.Add(lstColumnName[i].SearchColumnName, ColType);
                        dtProductKey.Columns.Add(lstColumnName[i].SearchColumnName, ColType);
                        dictColTypes.Add(lstColumnName[i].SearchColumnName, ColType);
                    }
                }
                Dictionary<int, string> dictColPosition = new Dictionary<int, string>();
                for (int col = startCell.Column; col <= endCell.Column; col++)
                {
                    var Positon = lstColumnName.Where(o => o.SearchColumnName == Convert.ToString(worksheet.Cells[1, col].Value)).FirstOrDefault();
                    dictColPosition.Add(col, Positon.SearchColumnName);
                }

                for (int row = 2; row <= endCell.Row; row++)
                {
                    InventoryItemsBasket item = new InventoryItemsBasket();
                    DataRow dr = dt.NewRow();
                    DataRow ErrorDr = ErrorDt.NewRow();
                    DataRow drProductKey = dtProductKey.NewRow();
                    DataRow drDupProductKey = dtDupProductKey.NewRow();
                    int ErrorFlag = 0;
                    for (int col = startCell.Column; col <= endCell.Column; col++)
                    {

                        if (worksheet.Cells[row, col].Value != null)
                        {
                            var DataValue = worksheet.Cells[row, col].Value;
                            try
                            {
                                if (dictColPosition[col].ToUpper() == "VENDOR NAME")
                                {
                                    var duplicate = (from c in lstSuppliers
                                                     where c == DataValue
                                                     select c).ToList();
                                    if (duplicate.Count == 0)
                                    {
                                        lstSuppliers.Add(Convert.ToString(DataValue));
                                    }

                                }

                                if (dictColPosition[col].ToUpper() == "LSU")
                                {
                                    var duplicateLSU = (from c in lstInventoryUOM
                                                        where c == DataValue
                                                        select c).ToList();
                                    if (duplicateLSU.Count == 0)
                                    {
                                        lstInventoryUOM.Add(Convert.ToString(DataValue));
                                        item.LSUnit = Convert.ToString(DataValue);
                                    }
                                }


                                if (dictColPosition[col].ToUpper() == "MFT")
                                {
                                    
                                    var DataValueExp = worksheet.Cells[row, col + 1].Value; 
                                    var excelDate = worksheet.Cells[row, col + 1].Value;

                                    if (excelDate.GetType() == typeof(DateTime))
                                    {
                                        DataValueExp = excelDate;
                                    }
                                    else
                                    {
                                        if (excelDate.GetType() != typeof(DateTime))
                                        {
                                            ErrorFlag++;
                                        }
                                        else
                                        {
                                            DataValueExp = DateTime.FromOADate(Convert.ToInt64(worksheet.Cells[row, col + 1].Value));
                                        }
                                    }

                                    excelDate = worksheet.Cells[row, col].Value;
                                    if (excelDate.GetType() == typeof(DateTime))
                                    {
                                        DataValue = excelDate;
                                    }
                                    else
                                    {
                                        if (excelDate.GetType() != typeof(DateTime))
                                        {
                                            ErrorFlag++;
                                        }
                                        else
                                        {
                                            DataValue = DateTime.FromOADate(Convert.ToInt64(worksheet.Cells[row, col].Value));
                                        }
                                    }
                                    if (DataValueExp.GetType() != typeof(DateTime))
                                    {
                                        ErrorFlag++;
                                    }
                                    if (DataValue.GetType() != typeof(DateTime))
                                    {
                                        ErrorFlag++;
                                    }
                                    if (DataValue.GetType() == typeof(DateTime) && DataValueExp.GetType() == typeof(DateTime))
                                    {
                                        if (((System.DateTime)(DataValue)).Year > ((System.DateTime)(DataValueExp)).Year)
                                        {
                                            lstMFT_EXP_Mismatch.Add(Convert.ToString(DataValue));
                                            ErrorFlag++;
                                        }
                                    }
                                }

                                if (dictColPosition[col].ToUpper() == "EXP")
                                {
                                    var excelDate = DataValue;
                                    if (excelDate.GetType() == typeof(DateTime))
                                    {
                                        DataValue = excelDate;
                                    }
                                    else
                                    {
                                        if (DataValue.GetType() != typeof(DateTime))
                                        {
                                            ErrorFlag++;
                                        }
                                        else
                                        {
                                            DataValue = DateTime.FromOADate(Convert.ToInt64(DataValue));
                                        }
                                    }
                                    if (DataValue.GetType() != typeof(DateTime))
                                    {
                                        ErrorFlag++;
                                    }
                                }
                                if (dictColPosition[col].ToUpper() == "INVOICE DATE")
                                {
                                    var excelDate = DataValue;
                                    if (excelDate.GetType() == typeof(DateTime))
                                    {
                                        DataValue = excelDate;
                                    }
                                    else
                                    {
                                        if (DataValue.GetType() != typeof(DateTime))
                                        {
                                            ErrorFlag++;
                                        }
                                        DataValue = DateTime.FromOADate(Convert.ToInt64(DataValue));
                                    }
                                    if (DataValue.GetType() != typeof(DateTime))
                                    {
                                        ErrorFlag++;
                                    }
                                }

                                if (dictColPosition[col].ToUpper() == "STOCK RECEIVE DATE")
                                {
                                    var excelDate = DataValue;
                                    if (excelDate.GetType() == typeof(DateTime))
                                    {
                                        DataValue = excelDate;
                                    }
                                    else
                                    {
                                        if (DataValue.GetType() != typeof(DateTime))
                                        {
                                            ErrorFlag++;
                                        }
                                        else
                                        {
                                            DataValue = DateTime.FromOADate(Convert.ToInt64(DataValue));
                                        }
                                    }
                                    if (DataValue.GetType() != typeof(DateTime))
                                    {
                                        ErrorFlag++;
                                    }
                                }

                                if (dictColTypes[dictColPosition[col]] == typeof(string) || DataValue.GetType() == dictColTypes[dictColPosition[col]])
                                {
                                    if (DataValue.GetType() == typeof(String) && !string.IsNullOrEmpty(Convert.ToString(DataValue)))
                                    {
                                        dr[dictColPosition[col]] = DataValue;
                                        ErrorDr[dictColPosition[col]] = DataValue;
                                        drProductKey[dictColPosition[col]] = DataValue;
                                    }

                                    else if (DataValue.GetType() != typeof(String))
                                    {
                                            dr[dictColPosition[col]] = DataValue;
                                            ErrorDr[dictColPosition[col]] = DataValue;
                                            drProductKey[dictColPosition[col]] = DataValue;
                                    }
                                    else
                                    {
                                        ErrorFlag++;
                                    }

                                    switch (dictColPosition[col].ToLower())
                                    {
                                        case "productname":
                                            item.ProductName = DataValue.ToString();
                                            break;
                                        case "batchno":
                                            item.BatchNo = DataValue.ToString();
                                            break;
                                        case "category":
                                            item.CategoryName = DataValue.ToString();
                                            break;
                                        case "lsu":
                                            item.LSUnit = DataValue.ToString();
                                            break;
                                        case "cost price":
                                            item.UnitPrice = Convert.ToDecimal(DataValue.ToString());
                                            break;
                                        case "selling price":
                                            item.Rate = Convert.ToDecimal(DataValue.ToString());
                                            break;
                                        case "exp":
                                            item.ExpiryDate = Convert.ToDateTime(DataValue);
                                            break;
                                        default:
                                            break;
                                    }
                                }
                                else
                                {
                                    ErrorFlag++;
                                }

                            }
                            catch (Exception)
                            {

                            }

                            /* The duplicate rows check with product key validate in the list */
                            if (col == endCell.Column)
                            {
                                if (dictColTypes.ContainsKey("ProductKey"))
                                {
                                    item.ProductKey = item.ProductName + "@#$" + item.CategoryName + "@#$" + item.BatchNo + "@#$" + item.ExpiryDate.ToString("MMM/yyyy") + "@#$" + String.Format("{0:0.000000}", item.UnitPrice) + "@#$" + String.Format("{0:0.000000}", item.Rate) + "@#$" + item.LSUnit;
                                    if (item.ProductKey != "")
                                    {
                                        dr["ProductKey"] = "";
                                        drProductKey["ProductKey"] = item.ProductKey;
                                    }
                                }
                                if (dictColTypes.ContainsKey("ProductKeyflag"))
                                {
                                    dr["ProductKeyflag"] = false;
                                    drProductKey["ProductKeyflag"] = true;
                                }
                            }

                        }
                        else
                        {
                            var DataValue = worksheet.Cells[row, col].Value;
                            ErrorFlag++;
                        }
                    }

                    if (ErrorFlag == 0)
                    {
                        dt.Rows.Add(dr);
                    }
                    else
                    {
                        ErrorDt.Rows.Add(ErrorDr);
                    }

                    dtProductKey.Rows.Add(drProductKey);
                   
                }
                DataTable dtResult;
                if (dtProductKey.Rows.Count > 0)
                {
                    var rows = dtProductKey.AsEnumerable().GroupBy(o => o["ProductKey"]).Where(gr => gr.Count() > 1).Select(g => g.First());
                    if (rows.Any())
                    {
                        dtDupProductKey = rows.CopyToDataTable();

                        if (dtDupProductKey.Rows.Count > 0)
                        {
                            var dvProductKeys = from p in dtProductKey.AsEnumerable()
                                                join t in dtDupProductKey.AsEnumerable()
                                              on p.Field<string>("ProductKey") equals t.Field<string>("ProductKey")
                                                orderby p.Field<string>("ProductKey")
                                                select p;

                            dtProductKey = null;
                            if (dvProductKeys.Any())
                            {
                                dtResult = dvProductKeys.CopyToDataTable();
                                if (dtResult.Rows.Count > 0)
                                {
                                    string struserMsg = Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_03 == null ? "Please correct the duplicate rows and try again..." : Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_03;
                                    lblFormat.Text = struserMsg;
                                    GridLoadExcelTempate.DataSource = dtResult;
                                    GridLoadExcelTempate.DataBind();
                                    dt = new DataTable();
                                    ErrorDt = new DataTable();
                                }
                            }
                            else
                            {
                                dt = new DataTable();
                                ErrorDt = new DataTable();
                            }
                        }

                    }
                }
                if (ErrorDt.Rows.Count > 0)
                {
                    string struserMsg = Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_04 == null ? "Please correct the following lines and try again..." : Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_04;
                    lblFormat.Text = struserMsg;
                    GridLoadExcelTempate.DataSource = ErrorDt;
                    GridLoadExcelTempate.DataBind();
                    dt = new DataTable();
                }
                if (dt.Rows.Count > 0)
                {  
                    ErrorDt = new DataTable();
                }
            }

        }
        catch (Exception ex)
        {
            string struserMsg = Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_05 == null ? "Process could not be done. because it is being used by another process. .. !" : Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_05;
            string stralert = Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_06 == null ? "Please Rename Sheet Name as Sheet1 ..!" : Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_06;
            string struseralert = Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_07 == null ? "File doesnot exists ..!" : Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_07;
            string strAlertMsg = Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_08 == null ? "File must be xls or xlsx Format..!" : Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_08;
            string userMsg = Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_09 == null ? "String was not recognized as a valid DateTime" : Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_09;
            string errorMsg=Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_10==null?"Alert":Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_10;


            if (stream != null)
            {
                stream.Flush();
                stream.Close();
            }
            if (ex.Message.Contains(" because it is being used by another process."))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ValidationWindow('"+struserMsg+"','"+errorMsg+"');", true);
            }
            else if (ex.Message.Contains("Sheetname doesnot exisit"))
            { ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ValidationWindow('"+struserMsg+"','"+errorMsg+"');", true); }

            else if (ex.Message.Contains("File   Does Not Exists"))
            { ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ValidationWindow('"+struserMsg+"','"+errorMsg+"');", true); }
            else if (ex.Message.Contains("File must be .xls or .xlsx Format"))
            { ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ValidationWindow('"+struserMsg+"','"+errorMsg+"');", true); }
            else if (ex.Message.Contains("String was not recognized as a valid DateTime"))
            { ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ValidationWindow('"+struserMsg+"','"+errorMsg+"');", true); }
        }
        finally
        {
            if (stream != null)
            {
                stream.Flush();
                stream.Close();
            }
        }

        if (lstSuppliers.Count > 1)
        {
            string strFormat = Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_11 == null ? "More than One supplier found. Please correct it" : Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_11;
            lblFormat.Text = strFormat;
            dt = new DataTable();
        }
            else if (lstSuppliers.Count == 1)
        {
            List<Suppliers> lstSuppliers2 = new List<Suppliers>();
            InventoryCommon_BL inventoryBL = new InventoryCommon_BL(this.ContextInfo);
            inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers2);
            if (lstSuppliers2 != null && lstSuppliers2.Count > 0)
            {
                int CheckSupplier = (from c in lstSuppliers2
                                     where c.SupplierName == lstSuppliers[0]
                                     select c).Count();
                if (CheckSupplier == 0)
                {
                    lblFormat.Text = strSupplierMsg;
                    dt = new DataTable();
                }
            }
            else
            {
                lblFormat.Text = strSupplierMsg;
                dt = new DataTable();
            }
        }
        if (lstInventoryUOM.Count >= 1)
        {
            List<InventoryUOM> lstInventoryUOM2 = new List<InventoryUOM>();
            new InventoryCommon_BL(base.ContextInfo).GetInventoryUOM(out lstInventoryUOM2);
            int chkLSU = 0;
            if (lstInventoryUOM2 != null && lstInventoryUOM2.Count > 0)
            {
                for (int i = 0; i < lstInventoryUOM.Count; i++)
                {
                    chkLSU = lstInventoryUOM2.Where(p => p.UOMCode == lstInventoryUOM[i]).Count();

                    if (chkLSU == 0)
                    {
                        lblFormat.Text = strLSUMsg;
                        dt = new DataTable();
                    }
                }
            }
            else
            {
                lblFormat.Text = strLSUMsg;
                dt = new DataTable();
            }
        }

        if (lstMFT_EXP_Mismatch.Count >= 1)
        {
            string strYear = Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_14 == null ? "Mismatch Year Between MFT & EXP Date" : Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_14;
            lblFormat.Text = strYear;
            dt = new DataTable();
        }

        return dt;

    }

    protected void imgBtnXL_Click(Object sender, EventArgs e)
    {
        try
        {
            List<DynamicColumnMapping> lstColumnName = new List<DynamicColumnMapping>();
            StockManagement_BL inventoryBL = new StockManagement_BL(this.ContextInfo);
            inventoryBL.GetUDTColumnTypes("ExcelProductDetails", out lstColumnName);

            DataTable TemplateTable = new DataTable();
            DataRow TemplateRow = null;
            TemplateRow = TemplateTable.NewRow();

            for (int i = 0; i < lstColumnName.Count(); i++)
            {
                TemplateTable.Columns.Add(lstColumnName[i].SearchColumnName, typeof(string));
            }
            TemplateTable.Columns.Remove("ReceivedUniqueNumber");
            TemplateTable.Columns.Remove("productkeyflag");
            MemoryStream ms = ExportToExcel(TemplateTable, "Sheet1");
            ms.WriteTo(Response.OutputStream);

            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=ProductDetails.xlsx");

            Response.StatusCode = 200;
            Response.End();

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }


    public static MemoryStream ExportToExcel(DataTable table, string sheetName)
    {
        MemoryStream Result = new MemoryStream();
        ExcelPackage pack = new ExcelPackage();
        ExcelWorksheet ws = pack.Workbook.Worksheets.Add(sheetName);


        int col = 1;
        int row = 1;

        foreach (DataColumn cl in table.Columns)
        {
            if (cl.ColumnName != null)
                ws.Cells[row, col].Value = cl.ColumnName.ToString();
            col++;
        }


        pack.SaveAs(Result);
        return Result;
    }

    protected void GridLoadExcelTempate_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string constr = string.Empty;
        try
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                for (int i = 0; i < e.Row.Cells.Count; i++)
                {
                    if (i + 1 == e.Row.Cells.Count)
                    {
                        e.Row.Cells[i].Visible = false;
                    }
                }

                for (int i = 0; i < e.Row.Cells.Count; i++)
                {
                    constr = e.Row.Cells[i].Text.ToString();
                    switch (constr.ToLower())
                    {
                        case "productkey":
                            e.Row.Cells[i].Visible = false;
                            dictColPositions.Add(i, constr);
                            break;
                        case "productkeyflag":
                            e.Row.Cells[i].Visible = false;
                            dictColPositions.Add(i, constr);
                            break;
                        case "receiveduniquenumber":
                            e.Row.Cells[i].Visible = false;
                            dictColPositions.Add(i, constr);
                            break;
                        default:
                            break;
                    }
                }

            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string dispkey = string.Empty;
                for (int i = 0; i < e.Row.Cells.Count; i++)
                {

                    dispkey = i.ToString();
                    foreach (int key in dictColPositions.Keys)
                    {
                        if (dispkey.Contains(key.ToString()))
                        {
                            switch (dictColPositions[key].ToLower())
                            {
                                case "productkey":
                                    e.Row.Cells[key].Visible = false;
                                    break;
                                case "productkeyflag":
                                    //Chang this code from boll test
                                    if ((((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[key]) != DBNull.Value)
                                    {
                                        bool b = Convert.ToBoolean((((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[key]));
                                        if (b == true)
                                        {
                                            e.Row.Style.Add(HtmlTextWriterStyle.BackgroundColor, "white");
                                            e.Row.Style.Add(HtmlTextWriterStyle.Color, "blue");
                                        }
                                    }
                                    e.Row.Cells[key].Visible = false;
                                    break;

                                case "productreceiveddetailsid":
                                    e.Row.Cells[key].Visible = false;
                                    break;
                                default:
                                    break;
                            }
                        }
                    }


                    if (e.Row.Cells[i].Text == "&nbsp;")
                    {
                        e.Row.Cells[i].Style.Add(HtmlTextWriterStyle.BackgroundColor, "red");
                        e.Row.Cells[i].ForeColor = System.Drawing.Color.Blue;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Row Data bound like products ", ex);           
        }
    }

    protected void btnResetProductwise_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        string StockOutFlowNo = string.Empty;
        try
        {
            List<ProductLocationMapping> lstProductsWiseList = new List<ProductLocationMapping>();
            List<ProductCategories> lstProductCategories = new List<ProductCategories>();
            StockManagement_BL inventoryBL1 = new StockManagement_BL(base.ContextInfo);
            string strProduct = Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_15 == null ? "Products Qty Reseted to ZERO ..!" : Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_15;
            int resetType = 1;
            int stockOutflowid = 0;
            lstProductsWiseList = GetCollectedItems();
            returnCode = inventoryBL1.ResetProductsToZero(InventoryLocationID, OrgID, lstProductCategories, lstProductsWiseList, resetType, out stockOutflowid);
            if (returnCode > 0)
            {

                if (stockOutflowid > 0)
                {
                    lblProductListZeroMSG.Text = strProduct;
                    Response.Redirect("../StockOutFlow/ViewStockNonUsage.aspx?ID=" + Convert.ToString(stockOutflowid));
                }

                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey4", "DisplayTab('ResetProductsQty',1);", true);

            }

        }
        catch (Exception ex)
        { CLogger.LogError("Error while executing ResetQtyWithzero aspx", ex); }

    }

    public List<ProductLocationMapping> GetCollectedItems()
    {
        List<ProductLocationMapping> lstProductlist1 = new List<ProductLocationMapping>();

        string ProductWiseList = iconHid.Value;
        string[] Productwise = ProductWiseList.Split('^');
        for (int i = 0; i < Productwise.Length; i++)
        {
            ProductLocationMapping lstProductlist = new ProductLocationMapping();
            if (Productwise[i].Split('~')[0] != "")
            {

                lstProductlist.ProductID = Convert.ToInt32(Productwise[i].Split('~')[0]);
                lstProductlist.LocationID = InventoryLocationID;
                lstProductlist.OrgId = OrgID;
            }

            lstProductlist1.Add(lstProductlist);
        }
        return lstProductlist1;
    }

    protected void btnResetCategorieswise_Click(object sender, EventArgs e)
    {
        List<ProductCategories> lstCategories = new List<ProductCategories>();
        List<ProductCategories> lstProductCategories = new List<ProductCategories>();
        List<ProductCategories> lstProductCategories_all = new List<ProductCategories>();
        List<ProductLocationMapping> lstProductsWiseList = new List<ProductLocationMapping>();
        string strCategory = Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_16 == null ? "Selected Categories Qty Reseted to ZERO ..!" : Resources.StockManagement_ClientDisplay.StockManagement_ExcelToProductsUpload_aspx_16;
        long returnCode = -1;
        int resetType = 0;
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        string strLstProductCategories = hdnProductCategorieschk.Value;
        lstProductCategories = serializer.Deserialize<List<ProductCategories>>(strLstProductCategories);
        if (lstProductCategories == null)
        {
            lstProductCategories = new List<ProductCategories>();
        }
        else if (lstProductCategories.Count > 0)
        {
            lstProductCategories_all = lstProductCategories.FindAll(p => p.CategoryID == 0 || p.CategoryID > 0);

            if (lstProductCategories_all.Count > 0)
            {
                lstProductCategories = lstProductCategories.FindAll(p => p.CategoryID > 0);
            }
        }
        int stockOutflowid = 0;
        StockManagement_BL inventoryBL1 = new StockManagement_BL(base.ContextInfo);
        returnCode = inventoryBL1.ResetProductsToZero(InventoryLocationID, OrgID, lstProductCategories, lstProductsWiseList, resetType, out stockOutflowid);

        if (returnCode > 0)
        {

            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey4", "DisplayTab('ResetProductsQty',2);", true);

            lblCategorywiseList.Text = strCategory;
            Response.Redirect("../StockOutFlow/ViewStockNonUsage.aspx?ID=" + Convert.ToString(stockOutflowid));
        }

    }

    private void BindCategory()
    {
        List<ProductCategories> lstProductCategories = new List<ProductCategories>();
        List<ProductCategories> lstProductCategories_1 = new List<ProductCategories>();
        JavaScriptSerializer JSsearializer = new JavaScriptSerializer();
        InventoryCommon_BL inventoryBL1 = new InventoryCommon_BL(base.ContextInfo);
        inventoryBL1.GetProductCategories(OrgID, InventoryLocationID, out lstProductCategories);
        hdnProductCategories.Value = JSsearializer.Serialize(lstProductCategories);
    }


}
