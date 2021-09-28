using System;
using System.IO;
using System.Data;
using System.Linq;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Data.OleDb;



using System.Xml;


using System.Text.RegularExpressions;
using System.Globalization;


using System.Xml.Linq;


public partial class Admin_CouponTestMaster : BasePage
{
    public Admin_CouponTestMaster()
        : base("Admin\\CouponTestMaster.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long Returncode = -1;
    long returncode = -1;
    string status;
    string physicianName = string.Empty;
    string CacheTempFull = string.Empty;
    string CacheTempFileName = string.Empty;
    StreamReader s = null;
    CouponValueMaster cvm = new CouponValueMaster();
    List<CouponValueMaster> cvma = new List<CouponValueMaster>();
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AutoCompleteExtender3.ContextKey = OrgID.ToString();
            AutoCompleteExtender1.ContextKey = OrgID.ToString();
            LoadFeeType();
            //gridpopulate(out lstCouponValueMaster);
        }
        CouponCodeLength();
        
    }

    public void CouponCodeLength()
    {
        try
        {
            string CouponBarcodeLength = string.Empty;
            CouponBarcodeLength = GetConfigValue("CouponBarcodeLength", OrgID);
            CouponBarcodeLength = "9";
           
            List<CouponValueMaster> lstCouponValueMaster = new List<CouponValueMaster>();
            rdosingle.Checked = true;
            rdobulk.Checked = false;
            Role_BL roleBL;
            roleBL = new Role_BL(base.ContextInfo);
            physicianName = txtDrName.Text;
            AutoRname.ContextKey = "Y";
            AutoCompleteExtender4.ContextKey = "Y";
            if ((!String.IsNullOrEmpty(CouponBarcodeLength)) && CouponBarcodeLength.Length > 0)
            {
                hdnCouponlength.Value = CouponBarcodeLength;
                txtbarcode.MaxLength = Convert.ToInt32(hdnCouponlength.Value);
            }
           
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while Page Load ", ex);
        }
    }
    public void LoadFeeType()
    {
        try
        {
            #region Load FeeTypes
            long returnCode = -1;
            List<FeeTypeMaster> lstFTM = new List<FeeTypeMaster>();
            AutoCompleteExtender3.ContextKey = hdnFeeType1.Value.ToString() + "~" + OrgID.ToString() + "~" + 0.ToString() + "~" + hndLocationID.Value.ToString() + "~";
            AutoCompleteExtender1.ContextKey = hdnFeeType1.Value.ToString() + "~" + OrgID.ToString() + "~" + 0.ToString() + "~" + hndLocationID.Value.ToString() + "~";
            #endregion
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while Load Fee Type ", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            lblCouponMsg.Visible = false;
            List<CouponValueMaster> lstOutputMsg = new List<CouponValueMaster>();
            Master_BL GCVM = new Master_BL(base.ContextInfo);
            string ActiveStatus = string.Empty;
            string status = "N";
            if (chkActiveStatus.Checked == true)
            {
                ActiveStatus = "Y";
            }
            else
            {
                ActiveStatus = "N";
            }
            cvm.CouponName = txtTestName.Text.Trim();
            cvm.PhysicianId = Convert.ToInt64(txtDrName.Text.Split('~')[1]);
            cvm.ValidFrom = Convert.ToDateTime(txtFrmDate.Text);
            cvm.ValidTo = Convert.ToDateTime(txtToDate.Text.Trim());
            cvm.Status = status.ToString();
            cvm.CouponBarcode = txtbarcode.Text.Trim();
            cvm.CouponValue = Convert.ToDecimal(txtBarcodeValue.Text);
            cvm.Type = hdnFeeTypeSelected.Value;
            cvm.InvestigationID = Convert.ToInt64(hdnID.Value);
            cvm.IsDelete = ActiveStatus.ToString();
            cvma.Add(cvm);
            returncode = GCVM.InsertCoupenValueMaster(cvma, out lstOutputMsg);
            if (lstOutputMsg.Count > 0)
            {
                grdCouponTestMaster1.Visible = false;
                lblCouponMsg.Visible = true;
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('Same Coupon Code already exists. Please Check!'); ", true);
                alertmessage();
                Session["DupList"] = lstOutputMsg;
                grdduplicate.Visible = true;
                grdduplicate.DataSource = (List<CouponValueMaster>)Session["DupList"];
                grdduplicate.DataBind();

            }
            else
            {
                grdduplicate.Visible = false;
                grdCouponTestMaster1.Visible = false;

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('Coupon(s) Added Successfully'); ", true);
                alertmessage();
                //gridpopulate(out lstOutputMsg);
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while Insert The Record ", ex);
        }
    }

    public void alertmessage()
    {
        txtTestName.Text = "";
        txtbarcode.Text = "";
        txtBarcodeValue.Text = "";
        txtFrmDate.Text = "";
        txtToDate.Text = "";
        txtDrName.Text = "";
        chkActiveStatus.Checked = false;
        hdnID.Value = "0";
        txtSCouponCode.Text = "";
        txtSDrName.Text = "";
        txtSTestName.Text = "";

    }

    public DataTable Test(string File, string TableName, string delimiter)
    {

        //The DataSet to Return
        DataTable result = new DataTable();

        //Open the file in a stream reader.
        s = new StreamReader(File);

        //Split the first line into the columns       
        string[] columns = s.ReadLine().Split(delimiter.ToCharArray());

        //Add the new DataTable to the RecordSet
        //result.Tables.Add(TableName);

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

    protected void BtnSheet_Click(object sender, EventArgs e)
    {
        List<CouponValueMaster> lstOutputMsg = new List<CouponValueMaster>();
        try
        {
            string status = "N";
            long returncode = -1;
            Master_BL GCVM = new Master_BL(base.ContextInfo);

            if (fulSelect.HasFile)
            {
                //string newfilepath = "";
                string connString = string.Empty;
                string fileName = Server.HtmlEncode(fulSelect.FileName);
                string extension = System.IO.Path.GetExtension(fileName);
                /////////////////////////////////////////
                //string fileName = Path.GetFileName(fulSelect.PostedFile.FileName).ToLower();
                //string fileExtension = Path.GetExtension(fulSelect.PostedFile.FileName).ToLower();


                if (((fileName.Length - extension.Length) <= 50) && (extension.ToLower() == ".csv"))
                {
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('Invalid File Format. Please Check!'); ", true);
                    alertmessage();
                    return;
                }
                string DatetimeNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("yyyyMMddHHmmssfff");
                fileName = fileName.Replace(".csv", "") + "_" + DatetimeNow + extension;
                string newfilepath = Server.MapPath("~/ExcelTest/" + fileName);
                fulSelect.SaveAs(newfilepath);
                string full = System.IO.Path.GetFullPath(newfilepath);
                string tempfull = newfilepath;
                string file = System.IO.Path.GetFileName(full);
                string dir = System.IO.Path.GetDirectoryName(full);
                string temp = newfilepath;

                temp = temp.Replace(".csv", ".txt");
                System.IO.File.Move(full, temp.Replace(".csv", ".txt"));
                full = temp;

                //Change File Name here

                fileName = fileName.Replace(".csv", ".txt");
                CacheTempFull = full;
                CacheTempFileName = fileName;
                DataTable dt = Test(full, "test", ",");


                if (!CheckHeader(dt))
                {

                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('Invalid Column Header in Upload File. Please Check!'); ", true);
                    if (File.Exists(newfilepath))
                    {
                        File.Delete(newfilepath);
                    }
                    alertmessage();
                    return;
                }
                if (dt.Rows.Count > 1000 || dt.Rows.Count == 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('No. Of Entries in Upload File should be less than or equal to 1000. Please Check!'); ", true);
                    if (File.Exists(newfilepath))
                    {
                        File.Delete(newfilepath);
                    }
                    alertmessage();
                    return;
                }
                DataRow[] nullResultSet = dt.Select(" [CouponBarcode] is null OR [CouponBarcode]  ='' ");
                if (nullResultSet.Length > 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('Empty rows found in Upload File. Please Check!'); ", true);
                    if (File.Exists(newfilepath))
                    {
                        File.Delete(newfilepath);
                    }
                    alertmessage();
                    return;
                }
                foreach (DataRow row in dt.Rows)
                {
                    string CouponBarcode = row["CouponBarcode"].ToString().Trim();
                    if (!string.IsNullOrEmpty(CouponBarcode) && CouponBarcode.Length != Convert.ToInt32(hdnCouponlength.Value))
                    {
                        string str = "Barcode length should be " + hdnCouponlength.Value + " charcters";
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('" + str + "'); ", true);
                        if (File.Exists(newfilepath))
                        {
                            File.Delete(newfilepath);
                        }
                        alertmessage();
                        return;
                    }


                }
                int rowIndex = 0;
                if (CheckDuplicate(dt) != null && CheckDuplicate(dt).Rows.Count > 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('Duplicate Coupon Code found in Upload File. Please Check!'); ", true);
                    if (File.Exists(newfilepath))
                    {
                        File.Delete(newfilepath);
                    }
                    alertmessage();
                    return;
                } string ActiveStatus;
                foreach (DataRow dr in dt.Rows)
                {
                    ActiveStatus = string.Empty;

                    if (chkActiveStatus.Checked == true)
                    {
                        ActiveStatus = "Y";
                    }
                    else
                    {
                        ActiveStatus = "N";
                    }
                    cvm = new CouponValueMaster();
                    cvm.CouponName = txtTestName.Text.Trim();
                    cvm.ValidFrom = Convert.ToDateTime(txtFrmDate.Text.Trim());
                    cvm.ValidTo = Convert.ToDateTime(txtToDate.Text.Trim());
                    cvm.Status = status.ToString();
                    cvm.Type = hdnFeeTypeSelected.Value;
                    cvm.PhysicianId = Convert.ToInt64(txtDrName.Text.Split('~')[1]);
                    cvm.InvestigationID = Convert.ToInt64(hdnID.Value);
                    cvm.CouponBarcode = dr.ItemArray[0].ToString();
                    cvm.CouponValue = Convert.ToDecimal(dr.ItemArray[1]);
                    cvm.IsDelete = ActiveStatus.ToString();
                    cvma.Add(cvm);
                }
                returncode = GCVM.InsertCoupenValueMaster(cvma, out lstOutputMsg);

                if (lstOutputMsg.Count > 0)
                {
                    grdCouponTestMaster1.Visible = false;
                    lblCouponMsg.Visible = true;
                    if (grdduplicate.Visible == false)
                    {
                        grdduplicate.Visible = true;
                    }
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('Same Coupon Code already exists. Please Check!'); ", true);
                    alertmessage();
                    Session["DupList"] = lstOutputMsg;
                    grdduplicate.DataSource = (List<CouponValueMaster>)Session["DupList"];
                    grdduplicate.DataBind();

                }
                else
                {
                    if (grdduplicate.Visible == true)
                    {
                        grdduplicate.Visible = false;

                        grdCouponTestMaster1.Visible = false;
                    }
                    lblCouponMsg.Visible = false;
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('Coupon(s) Added Successfully'); ", true);

                    alertmessage();

                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Inserting Coupon(s) ", ex);
        }
    }
    private bool CheckHeader(DataTable HeaderCheck)
    {
        try
        {
            if (HeaderCheck.Columns[0].ColumnName != "CouponBarcode")
            {
                return false;
            }
            if (HeaderCheck.Columns[1].ColumnName != "CouponValue")
            {
                return false;
            }
        }
        catch (Exception ex)
        {
        }
        return true;
    }

    private DataTable CheckDuplicate(DataTable dtDuplicate)
    {
        DataTable resultTable = null;
        try
        {
            var duplicateRows = dtDuplicate
                   .AsEnumerable()
                   .GroupBy(r => new { CouponBarcode = r["CouponBarcode"] })
                   .Where(g => g.Count() > 1).SelectMany(g => g);
            if (duplicateRows.ToList().Count > 0)
            {

                resultTable = duplicateRows.CopyToDataTable<DataRow>();
                if (resultTable.Rows.Count > 0)
                {
                    grdCouponTestMaster1.Visible = false;
                    lblCouponMsg.Visible = true;
                    if (grdduplicate.Visible == false)
                    {
                        grdduplicate.Visible = true;
                    }
                    grdCouponTestMaster1.Visible = false;
                    lblCouponMsg.Visible = true;
                    Session["DupList"] = resultTable;
                    grdduplicate.DataSource = (DataTable)Session["DupList"];
                    grdduplicate.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
        }
        return resultTable;
    }

    private DataTable GetDataTable(string sql, string connectionString)
    {
        OleDbConnection connExcel = new OleDbConnection(connectionString);
        OleDbCommand cmdExcel = new OleDbCommand();
        OleDbDataAdapter oda = new OleDbDataAdapter();
        DataTable dt = new DataTable();
        try
        {
            cmdExcel.Connection = connExcel;
            connExcel.Open();
            connExcel.Close();
            connExcel.Open();
            cmdExcel.CommandText = sql;
            oda.SelectCommand = cmdExcel;
            oda.Fill(dt);
            connExcel.Close();

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while Get Excel Data  ", ex);
        }
        return dt;
    }


    protected void grdCouponTestMaster1_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        try
        {

            if (e.CommandName == "Select")
            {
                btnSave.Visible = false;
                btnUpdate.Visible = true;
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                hdnCouponId.Value = Convert.ToString(grdCouponTestMaster1.DataKeys[RowIndex][0]);
                txtTestName.Text = Convert.ToString(grdCouponTestMaster1.DataKeys[RowIndex][1]);
                txtbarcode.Text = Convert.ToString(grdCouponTestMaster1.DataKeys[RowIndex][2]);
                txtBarcodeValue.Text = Convert.ToString(grdCouponTestMaster1.DataKeys[RowIndex][3]);
                hdnDrId.Value = Convert.ToString(grdCouponTestMaster1.DataKeys[RowIndex][4]);
                txtDrName.Text = Convert.ToString(grdCouponTestMaster1.DataKeys[RowIndex][5]);
                txtFrmDate.Text = Convert.ToString(grdCouponTestMaster1.DataKeys[RowIndex][6]);
                txtToDate.Text = Convert.ToString(grdCouponTestMaster1.DataKeys[RowIndex][7]);
                string Activestat = Convert.ToString(grdCouponTestMaster1.DataKeys[RowIndex][8]);
                GridViewRow row = (GridViewRow)grdCouponTestMaster1.Rows[RowIndex];
                if (Activestat == "Y")
                {
                    chkActiveStatus.Checked = true;
                }
                else
                {
                    chkActiveStatus.Checked = false;
                }
                txtTestName.Enabled = false;
                txtbarcode.Enabled = false;
                txtBarcodeValue.Enabled = false;
                txtDrName.Enabled = false;
                txtFrmDate.Enabled = false;

            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Coupon Details to Change ", ex);
        }
    }

    protected void grdCouponTestMaster1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdCouponTestMaster1, "Select$" + e.Row.RowIndex));
                //ClientScriptManager.RegisterForEventValidation(grdCouponTestMaster1 .u
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Binding The Coupon(s) Details ", ex);
        }
    }
    protected void grdCouponTestMaster1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            Master_BL GCVM = new Master_BL(base.ContextInfo);
            int orgid = OrgID;
            string TestName = Session["TestName"].ToString();
            string CouponBarcode = Session["CouponBarcode"].ToString();
            long PhysicianId = Convert.ToInt64(Session["PhysicianId"].ToString());
            List<CouponValueMaster> lstCouponValueMaster = new List<CouponValueMaster>();
            if (e.NewPageIndex != -1)
            {
                grdCouponTestMaster1.PageIndex = e.NewPageIndex;
                GCVM.GetCoupenTestValuemaster(out lstCouponValueMaster, orgid, TestName, CouponBarcode, PhysicianId);
                grdCouponTestMaster1.DataSource = lstCouponValueMaster;
                grdCouponTestMaster1.DataBind();
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while Page Intex Changing ", ex);
        }

    }
    protected override void Render(HtmlTextWriter writer)
    {
        try
        {
            for (int i = 0; i < this.grdCouponTestMaster1.Rows.Count; i++)
            {
                this.Page.ClientScript.RegisterForEventValidation(this.grdCouponTestMaster1.UniqueID, "Select$" + i);
            }
            base.Render(writer);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading The Coupon(s) Details ", ex);
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            List<CouponValueMaster> lstOutputMsg = new List<CouponValueMaster>();
            Master_BL GCVM = new Master_BL(base.ContextInfo);

            string status = string.Empty;
            string ActiveStatus = string.Empty;
            if (chkActiveStatus.Checked == true)
            {
                ActiveStatus = "Y";
            }
            else
            {
                ActiveStatus = "N";
            }
            cvm.CouponId = 0;
            cvm.CouponName = txtTestName.Text.Trim();
            cvm.CouponBarcode = txtbarcode.Text.Trim();
            cvm.CouponValue = Convert.ToDecimal(txtBarcodeValue.Text.Trim());
            cvm.ValidFrom = Convert.ToDateTime(txtFrmDate.Text.Trim());
            cvm.ValidTo = Convert.ToDateTime(txtToDate.Text.Trim());
            cvm.Status = status.ToString();
            cvm.Type = hdnFeeTypeSelected.Value;
            cvm.PhysicianId = 0;
            cvm.InvestigationID = 0;
            cvm.IsDelete = ActiveStatus.ToString();
            cvma.Add(cvm);
            returncode = GCVM.UpdateCoupenTestValuemaster(cvma);
            if (returncode == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('Record Updated Successfully'); ", true);
                alertmessage();
            }
            txtTestName.Enabled = true;
            txtDrName.Enabled = true;
            btnSave.Visible = true;
            btnUpdate.Visible = false;
            grdCouponTestMaster1.Visible = false;

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while Insert The Record ", ex);
        }
    }

    protected void btnUploadCancel_Click(object sender, EventArgs e)
    {
        alertmessage();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        alertmessage();
        btnSave.Visible = true;
        btnUpdate.Visible = false;
        txtTestName.Enabled = true;
        txtbarcode.Enabled = true;
        txtBarcodeValue.Enabled = true;
        txtDrName.Enabled = true;
        txtFrmDate.Enabled = true;

    }
    protected void grdduplicate_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                grdduplicate.PageIndex = e.NewPageIndex;
                grdduplicate.DataSource = (List<CouponValueMaster>)Session["DupList"];
                grdduplicate.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Page Index Changing ", ex);
        }
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            lblCouponMsg.Visible = false;
            Session["TestName"] = null;
            Session["CouponBarcode"] = null;
            Session["PhysicianId"] = null;
            int orgid = OrgID;
            string TestName, CouponBarcode;
            long PhysicianId;
            if (txtSDrName.Text != "")
            {
                PhysicianId = Convert.ToInt64(txtSDrName.Text.Split('~')[1]);
            }
            else
            {
                PhysicianId = -1;
            }
            Master_BL GCVM = new Master_BL(base.ContextInfo);
            List<CouponValueMaster> lstCouponValueMaster = new List<CouponValueMaster>();
            TestName = txtSTestName.Text.Trim();
            CouponBarcode = txtSCouponCode.Text.Trim();
            Session["TestName"] = TestName.ToString();
            Session["CouponBarcode"] = CouponBarcode.ToString();
            Session["PhysicianId"] = PhysicianId.ToString();
            grdduplicate.Visible = false;
            returncode = GCVM.GetCoupenTestValuemaster(out lstCouponValueMaster, orgid, TestName, CouponBarcode, PhysicianId);
            if (lstCouponValueMaster.Count > 0)
            {

                grdCouponTestMaster1.DataSource = lstCouponValueMaster;
                grdCouponTestMaster1.DataBind();
                grdCouponTestMaster1.Visible = true;
            }
            else
            {
                grdCouponTestMaster1.DataSource = null;
                grdCouponTestMaster1.DataBind();
                grdCouponTestMaster1.Visible = false;
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('No Matching Records Found!'); ", true);
                alertmessage();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Searching The Coupon(s) Details ", ex);
        }
    }




    protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Admin/CouponTestMaster.aspx");
    }
}
