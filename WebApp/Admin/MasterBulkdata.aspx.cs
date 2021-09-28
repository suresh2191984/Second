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


public partial class MasterBulkdata : BasePage 
{
   OleDbConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void BtnSheet_Click(object sender, EventArgs e)
    {

        ErrorDisplay1.Visible = false;
      
        string Conne = "";
        
        
        DataTable objbulkdata = new DataTable();
        Users_BL MBulkBl = new Users_BL(base.ContextInfo);

        Conne = GetConnection(fulSelect);
        
        try
        {
                con = new OleDbConnection(Conne);
                con.Open();
            if (Conne != "")
            {
                DataTable dt = con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                foreach (DataRow dr in dt.Rows)
                {
                    ddlSheet.Items.Add(new ListItem(dr["Table_Name"].ToString()));
                }
                
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Generat XLS Sheet ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }


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

    private string GetConnection(FileUpload ful)
    {
        string newfilepath = "";
        string Conne = "";
        try
        {
            if (ful.HasFile)
            {
                
                string fileName = Server.HtmlEncode(ful.FileName);
                string extension = System.IO.Path.GetExtension(fileName);
                if ((extension == ".xls" || extension == ".xlsx"))
                {
                    String rootPath = Server.MapPath("~/ExcelTest/");
                    if (!System.IO.File.Exists(rootPath))
                    {
                        ful.SaveAs(rootPath + ful.FileName);
                    }
                    newfilepath = Server.MapPath("~/ExcelTest/" + ful.FileName);
                    if (extension == ".xls")
                    {
                        Conne = "Provider=Microsoft.Jet.OleDb.4.0;data source=" + newfilepath + ";Extended Properties=Excel 8.0;";
                    }
                    if (extension == ".xlsx")
                    {
                        Conne = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + newfilepath + ";Extended Properties=Excel 12.0";
                    }
                }
                Session["ConString"] = Conne;
            }
        }
        catch (Exception Ex)
        {

            
        }
        
        return Conne;
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
            basket.Columns.Add("TestName");
            basket.Columns.Add("CasualtyRate");
            basket.Columns.Add("ProcedureDesc");
            basket.Columns.Add("Amount");
            basket.Columns.Add("IPAmount");
            basket.Columns.Add("ItemName");
            basket.Columns.Add("Rate");
            basket.Columns.Add("PhysicianName");
            basket.Columns.Add("Qualification");
            basket.Columns.Add("OrganizationName");
            basket.Columns.Add("IPTreatmentPlanName");
            basket.Columns.Add("IPTreatmentPlanParentID");
           
            DataRow dr;

            foreach (DataRow pod in objDataTable.Rows)
            {
                dr = basket.NewRow();
                if (objDataTable.Columns["TestName"] != null)
                {
                    dr["TestName"] = pod["TestName"];
                }
                else
                {
                    dr["TestName"] = "";
                }
                if (objDataTable.Columns["CasualtyRate"] != null)
                {
                    dr["CasualtyRate"] = pod["CasualtyRate"];
                }
                else
                {
                    dr["CasualtyRate"] = 0;
                }

                if (objDataTable.Columns["ProcedureDesc"] != null)
                {
                    dr["ProcedureDesc"] = pod["ProcedureDesc"];
                }
                else
                {
                    dr["ProcedureDesc"] = "";
                }
                if (objDataTable.Columns["Amount"] != null)
                {
                    dr["Amount"] = pod["Amount"];
                }
                else
                {
                    dr["Amount"] = 0;
                }
                if (objDataTable.Columns["IPAmount"] != null )
                {
                    dr["IPAmount"] = pod["IPAmount"];
                }
                else
                {
                    dr["IPAmount"] = 0;
                }

                if (objDataTable.Columns["ItemName"] != null)
                {
                    dr["ItemName"] = pod["ItemName"];
                }
                else
                {
                    dr["ItemName"] = "";
                }


                if (objDataTable.Columns["Rate"] != null)
                {
                    dr["Rate"] = pod["Rate"];
                }
                else
                {
                    dr["Rate"] = 0;
                }
                if (objDataTable.Columns["PhysicianName"] != null )
                {
                    dr["PhysicianName"] = pod["PhysicianName"];
                }
                else
                {
                    dr["PhysicianName"] = "";
                }
                if (objDataTable.Columns["Qualification"] != null )
                {
                    dr["Qualification"] = pod["Qualification"];
                }
                else
                {
                    dr["Qualification"] = "";
                }
                if (objDataTable.Columns["OrganizationName"] != null )
                {
                    dr["OrganizationName"] = pod["OrganizationName"];
                }
                else
                {
                    dr["OrganizationName"] ="";
                }
                if (objDataTable.Columns["IPTreatmentPlanName"] != null )
                {
                    dr["IPTreatmentPlanName"] = pod["IPTreatmentPlanName"];
                }
                else
                {
                    dr["IPTreatmentPlanName"] = "";
                }
                if (objDataTable.Columns["IPTreatmentPlanParentID"] != null )
                {
                    dr["IPTreatmentPlanParentID"] = pod["IPTreatmentPlanParentID"];
                }
                else
                {
                    dr["IPTreatmentPlanParentID"] = 0;
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {

            string ConnectionString = GetConnection(fulSelect);
            if (ConnectionString == string.Empty)
                ConnectionString = Session["ConString"].ToString();
            con = new OleDbConnection(ConnectionString);
            OleDbDataAdapter adp = new OleDbDataAdapter("select * from [" + ddlSheet.SelectedItem.Text + "]", con);
            DataSet ds = new DataSet();
            DataTable objbulkdata = new DataTable();
            adp.Fill(objbulkdata);
            string Sheettype = ddlSheet.SelectedItem.Text;
            objbulkdata = basket(RemoveDuplicateRows(objbulkdata));
            new Users_BL(base.ContextInfo).SaveMasterBulkLoad(OrgID, LID, Sheettype, objbulkdata);
            DeleteFile(fulSelect);
            lblTest.Visible = true;
            lblTest.Text = (ddlSheet.SelectedItem.Text + "Successfully Inserted");


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Master databulkdata", ex);
        }
    }
}



