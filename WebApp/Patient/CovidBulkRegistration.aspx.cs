using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.DataAccessEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Data.OleDb;
using System.IO;
using System.Data;
using Attune.Podium.FileUpload;
using System.Web.Script.Serialization;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Drawing;
using OfficeOpenXml.DataValidation;

public partial class Inventory_CovidBulkRegistration : BasePage
{
    public Inventory_CovidBulkRegistration()
        : base("Patient_CovidBulkRegistration_aspx")
    {
    }

    //protected void page_Init(object sender, EventArgs e)
    //{
    //    base.page_Init(sender, e);
    //}
    //Inventory_BL inventoryBL;



    protected void Page_Load(object sender, EventArgs e)
    {
        //inventoryBL = new Inventory_BL(base.ContextInfo);
        //
    }


    protected void BtnSheet_Click(object sender, EventArgs e)
    {
        string pat = "";
        pat = Server.MapPath(fulSelect.FileName);
    }

    private bool DeleteFile(FileUpload ful)
    {

        string newfilepath = "";
        try
        {
            if (ful.HasFile)
            {
                string fileName = Server.HtmlEncode(ful.FileName);
                string extension = System.IO.Path.GetExtension(fileName);
                if ((extension == ".xls" || extension == ".xlsx"))
                {
                    newfilepath = Server.MapPath("~/ExcelTest/" + fileName);
                    File.Delete(newfilepath);
                }

            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception Ex)
        {


        }

        return true;
    }

    public string[] GetExcelSheetNames(string excelFileName)
    {
        OleDbConnection con = null;
        DataTable dt = null;
        String conStr = "Provider=Microsoft.Jet.OLEDB.4.0;" + "Data Source=" + excelFileName + ";Extended Properties=Excel 8.0;";
        con = new OleDbConnection(conStr);
        con.Open();
        dt = con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

        if (dt == null)
        {
            return null;
        }

        String[] excelSheetNames = new String[dt.Rows.Count];
        int i = 0;

        foreach (DataRow row in dt.Rows)
        {
            excelSheetNames[i] = row["TABLE_NAME"].ToString();
            i++;
        }

        return excelSheetNames;
    }


    public bool ValidatePatientDetails(DataTable dTable)
    {


        return true;
    }


    public DataTable RemoveDuplicateRows(DataTable dTable)
    {
        Hashtable hTable = new Hashtable();
        ArrayList duplicateList = new ArrayList();
        foreach (DataRow drow in dTable.Rows)
        {
            if (drow.ItemArray[0] == System.DBNull.Value)
            {
                duplicateList.Add(drow);
            }

        }
        foreach (DataRow dRow in duplicateList)
            dTable.Rows.Remove(dRow);

        return dTable;
    }

    public DataTable RemoveDuplicateRows(DataTable dTable, string colName)
    {
        Hashtable hTable = new Hashtable();
        ArrayList duplicateList = new ArrayList();
        foreach (DataRow drow in dTable.Rows)
        {
            if (drow.ItemArray[0] != System.DBNull.Value)
            {

                if (hTable.Contains(drow[colName]))
                    duplicateList.Add(drow);
                else
                    hTable.Add(drow[colName], string.Empty);
            }
            else
            {
                duplicateList.Add(drow);
            }
        }
        foreach (DataRow dRow in duplicateList)
            dTable.Rows.Remove(dRow);

        return dTable;
    }

    private DataTable basket(DataTable objDataTable)
    {
        DataTable basket = new DataTable();

        try
        {
            basket.Columns.Add("CategoryID");
            basket.Columns.Add("ProductID");
            basket.Columns.Add("CategoryName");
            basket.Columns.Add("ProductName");
            basket.Columns.Add("Quantity");
            basket.Columns.Add("ComplimentQTY");
            basket.Columns.Add("Tax");
            basket.Columns.Add("Discount");
            basket.Columns.Add("Rate");
            basket.Columns.Add("UOMID");
            basket.Columns.Add("Unit");
            basket.Columns.Add("UnitPrice");
            basket.Columns.Add("LSUnit");
            basket.Columns.Add("Description");
            basket.Columns.Add("ExpiryDate");
            basket.Columns.Add("Manufacture");
            basket.Columns.Add("BatchNo");
            basket.Columns.Add("Providedby");
            basket.Columns.Add("Type");
            basket.Columns.Add("Amount");
            basket.Columns.Add("ID");
            basket.Columns.Add("POQuantity");
            basket.Columns.Add("POUnit");
            basket.Columns.Add("RECQuantity");
            basket.Columns.Add("RECUnit");
            basket.Columns.Add("SellingUnit");
            basket.Columns.Add("InvoiceQty");
            basket.Columns.Add("RcvdLSUQty");
            basket.Columns.Add("AttributeDetail");
            basket.Columns.Add("HasExpiryDate");
            basket.Columns.Add("HasBatchNo");
            basket.Columns.Add("HasUsage");
            basket.Columns.Add("UsageCount");
            basket.Columns.Add("RakNo");
            basket.Columns.Add("MRP");
            basket.Columns.Add("InHandQuantity");
            basket.Columns.Add("ExciseTax");
            basket.Columns.Add("DiscOrEnhancePercent");
            basket.Columns.Add("DiscOrEnhanceType");
            basket.Columns.Add("Remarks");
            basket.Columns.Add("ProductKey");
            basket.Columns.Add("UnitSellingPrice");
            basket.Columns.Add("UnitCostPrice");
            basket.Columns.Add("ReceivedOrgID");
            basket.Columns.Add("ParentProductID");
            basket.Columns.Add("ReceivedOrgAddID");
            basket.Columns.Add("ParentProductKey");
            basket.Columns.Add("PrescriptionNO");
            DataRow dr;

            foreach (DataRow pod in objDataTable.Rows)
            {
                dr = basket.NewRow();
                if (rdoDetailed.Checked)
                {
                    dr["CategoryID"] = 0;
                    dr["ProductID"] = 0;

                    if (pod["Category"].ToString() != "")
                    {
                        dr["CategoryName"] = pod["Category"];
                    }
                    else
                    {
                        dr["CategoryName"] = "Others";
                    }
                    //dr["CategoryName"] = pod["Category"];
                    dr["ProductName"] = pod["ItemName"];
                    if (pod["Quantity"].ToString() != "")
                    {
                        dr["Quantity"] = pod["Quantity"];
                    }
                    else
                    {
                        dr["Quantity"] = 0;
                    }

                    dr["ComplimentQTY"] = 0;
                    if (pod["Tax"].ToString() != "")
                    {
                        dr["Tax"] = pod["Tax"].ToString();
                    }
                    dr["Discount"] = 0;
                    if (pod["Rate"].ToString() != "")
                    {
                        dr["Rate"] = pod["Rate"];
                    }
                    else
                    {
                        dr["Rate"] = 0;
                    }
                    if (pod["InvoiceQty"].ToString() != "")
                    {
                        dr["InvoiceQty"] = pod["InvoiceQty"].ToString();
                    }
                    dr["Unit"] = pod["Units"];
                    dr["UnitPrice"] = 0;
                    dr["LSUnit"] = 0;
                    dr["Description"] = 0;
                    if (pod["ExpiryDate"].ToString() != "**" || pod["ExpiryDate"].ToString() != "")
                    {
                        dr["ExpiryDate"] = pod["ExpiryDate"];
                    }
                    else
                    {
                        dr["ExpiryDate"] = DateTime.Parse("01/01/1753");
                    }
                    if (pod["Manufacture"].ToString() != "**" || pod["ExpiryDate"].ToString() != "")
                    {
                        dr["Manufacture"] = pod["Manufacture"];
                    }
                    else
                    {
                        dr["Manufacture"] = DateTime.Parse("01/01/1753");
                    }
                    if (pod["BatchNo"].ToString() != "" || pod["BatchNo"].ToString() != "*")
                    {
                        dr["BatchNo"] = pod["BatchNo"];
                    }
                    else
                    {
                        dr["BatchNo"] = "*";
                    }

                    dr["Providedby"] = 0;
                    dr["Type"] = 0;
                    dr["Amount"] = 0;
                    dr["ID"] = 0;
                    dr["POQuantity"] = 0;
                    dr["POUnit"] = 0;
                    dr["RECQuantity"] = 0;
                    dr["RECUnit"] = 0;
                    dr["SellingUnit"] = 0;
                    dr["InvoiceQty"] = 0;
                    dr["RcvdLSUQty"] = 0;
                    dr["AttributeDetail"] = "";
                    dr["HasExpiryDate"] = "Y";
                    dr["HasBatchNo"] = "Y";
                    dr["HasUsage"] = "N";
                    dr["UsageCount"] = "";
                    dr["RakNo"] = "";
                    dr["MRP"] = 0;
                    dr["InHandQuantity"] = 0;
                    dr["ExciseTax"] = 0;
                    dr["DiscOrEnhancePercent"] = 0;
                    dr["DiscOrEnhanceType"] = "";
                    dr["Remarks"] = "";
                    dr["ProductKey"] = "";
                    dr["UnitSellingPrice"] = 0;
                    dr["UnitCostPrice"] = 0;
                    dr["ReceivedOrgID"] = 0;
                    dr["ParentProductID"] = 0;
                    dr["ReceivedOrgAddID"] = 0;
                    dr["ParentProductKey"] = "";
                    dr["PrescriptionNO"] = "0";
                }
                if (rdoMinimal.Checked)
                {
                    dr["CategoryID"] = 0;
                    dr["ProductID"] = 0;
                    if (pod["Category"].ToString() != "")
                    {
                        dr["CategoryName"] = pod["Category"];
                    }
                    else
                    {
                        dr["CategoryName"] = "Others";
                    }
                    dr["ProductName"] = pod["ItemName"];
                    dr["Quantity"] = 0;
                    dr["ComplimentQTY"] = 0;
                    dr["Tax"] = 0;
                    dr["Discount"] = 0;
                    dr["Rate"] = 0;
                    dr["InvoiceQty"] = DBNull.Value;
                    dr["Unit"] = DBNull.Value;
                    dr["UnitPrice"] = 0;
                    dr["LSUnit"] = 0;
                    dr["Description"] = 0;
                    dr["ExpiryDate"] = DBNull.Value;
                    dr["Manufacture"] = DBNull.Value;
                    dr["BatchNo"] = 1;
                    dr["Providedby"] = 0;
                    dr["Type"] = 0;
                    dr["Amount"] = 0;
                    dr["ID"] = 0;
                    dr["POQuantity"] = 0;
                    dr["POUnit"] = 0;
                    dr["RECQuantity"] = 0;
                    dr["RECUnit"] = 0;
                    dr["SellingUnit"] = 0;
                    dr["InvoiceQty"] = 0;
                    dr["RcvdLSUQty"] = 0;
                    dr["AttributeDetail"] = "";
                    dr["HasExpiryDate"] = "";
                    dr["HasBatchNo"] = "";
                    dr["HasUsage"] = "";
                    dr["UsageCount"] = "";
                    dr["RakNo"] = "";
                    dr["MRP"] = 0;
                    dr["InHandQuantity"] = 0;
                    dr["ExciseTax"] = 0;
                    dr["DiscOrEnhancePercent"] = 0;
                    dr["DiscOrEnhanceType"] = "";
                    dr["Remarks"] = "";
                    dr["ProductKey"] = "";
                    dr["UnitSellingPrice"] = 0;
                    dr["UnitCostPrice"] = 0;
                    dr["ReceivedOrgID"] = 0;
                    dr["ParentProductID"] = 0;
                    dr["ReceivedOrgAddID"] = 0;
                    dr["ParentProductKey"] = "";
                    dr["PrescriptionNO"] = "0";
                }
                basket.Rows.Add(dr);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DAL lstInventoryItemsBasket", ex);
        }

        return basket;
    }

    protected void GetConnection(object sender, EventArgs e)
    {
        string path = "";
        string fileNameWithoutExtension = System.IO.Path.GetFileNameWithoutExtension(fulSelect.FileName);
        string extension = System.IO.Path.GetExtension(fulSelect.FileName);
        string guid = System.Guid.NewGuid().ToString();
        path = Server.MapPath(@"~\ExcelTest\") + fileNameWithoutExtension + guid + extension;

        fulSelect.SaveAs(Server.MapPath(@"~\ExcelTest\") + fileNameWithoutExtension + guid + extension);

        path = path.Replace("\\", "~");
        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "doValidate('" + path + "');", true);


    }
    protected void lnkXls_Click(object sender, EventArgs e)
    {
        try
        {

            string filepath = Server.MapPath(@"~\ExcelTest\BulkRegistrationTemplates\BulkRegistration.xls");
            FileInfo myfile = new FileInfo(filepath);
            if (myfile.Exists)
            {
                Response.ClearContent();
                Response.AddHeader("Content-Disposition", "attachment; filename=" + myfile.Name);
                Response.AddHeader("Content-Length", myfile.Length.ToString());
                Response.ContentType = "application/vnd.ms-excel";
                Response.TransmitFile(myfile.FullName);
                Response.End();
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    public void ExportToExcelForBulkReg()
    {
        try
        {
            //string attachment = "attachment; filename=" + ddlFeeType.SelectedValue + " - " + hdnRateName.Value + " - " + DateTime.Now.ToShortDateString() + ".xls";
            System.Data.DataTable dt = new DataTable();
            dt.Columns.Add("SlNo");
            dt.Columns.Add("OrgName");
            dt.Columns.Add("Registration Date");
            dt.Columns.Add("Sample Collected Date & Time");
            dt.Columns.Add("Sample Collected By (Phlebotomy name)");
            dt.Columns.Add("UniqueID");
            dt.Columns.Add("Title");
            dt.Columns.Add("NAME");
            dt.Columns.Add("AGE");
            dt.Columns.Add("AgeType");
            dt.Columns.Add("SEX");
            dt.Columns.Add("LOCATION");
            dt.Columns.Add("Doctor");
            dt.Columns.Add("Ref.Hospital");
            dt.Columns.Add("Priority");
            dt.Columns.Add("Dispatch Mode");
            dt.Columns.Add("TESTSREQUESTED");
            dt.Columns.Add("CHARGED");
            dt.Columns.Add("Amount Paid");
            dt.Columns.Add("Discount Amount");
            dt.Columns.Add("Disocunt Reason");
            dt.Columns.Add("Discount Authorised By");
            dt.Columns.Add("History");
            dt.Columns.Add("Remarks");
            dt.Columns.Add("MobileNo");
            dt.Columns.Add("CreatedBy");
            dt.Columns.Add("clientid (Client Code)");
            dt.Columns.Add("Email ID");
            dt.Columns.Add("Patient Number");
            dt.Columns.Add("Healthhub ID");
            dt.Columns.Add("Employee ID");
            dt.Columns.Add("Source Type");
			dt.Columns.Add("BookingID");
            dt.Columns.Add("ExternalRefNo");
            dt.Columns.Add("SampleNumber");
            dt.AcceptChanges();



            using (ExcelPackage pck = new ExcelPackage())
            {
                //Create the worksheet
                // pck.Workbook.Worksheets.Add("INV_Rates").Protection.IsProtected = true;
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("BulkRegistration");
                var tbl = dt;
                //Load the datatable into the sheet, starting from cell A1. Print the column names on row 1

                ws.Cells["A1"].LoadFromDataTable(tbl, true);

                //Format the header for column 1-7
                using (ExcelRange rng = ws.Cells["A1:AC1"])
                {
                    rng.Style.Font.Bold = true;
                    rng.Style.Fill.PatternType = ExcelFillStyle.Solid;                      //Set Pattern for the background to Solid
                    rng.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(79, 129, 189));  //Set color to dark blue
                    rng.Style.Font.Color.SetColor(Color.White);
                }


                //ws.Column(7).Style.Hidden = true;
                for (int i = 0; i < dt.Rows.Count; i++)
                    ws.Cells["AC" + (i + 1)].Style.Hidden = true;

                //   ws.Protection.IsProtected = true;
                // ws.Column(2).Style.Locked = false;


                var dataRange = ws.Cells[ws.Dimension.Address.ToString()];
                dataRange.AutoFitColumns();
                HttpContext.Current.Response.Clear();
                //Write it back to the client
                HttpContext.Current.Response.ContentType = "application/ms-excel";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment;  filename=" + OrgName + "_" + OrgID + "_" + "BulkRegistration.xls");
                HttpContext.Current.Response.BinaryWrite(pck.GetAsByteArray());
                //HttpContext.Current.ApplicationInstance.CompleteRequest();

                HttpContext.Current.Response.End();

            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }

    }
}
