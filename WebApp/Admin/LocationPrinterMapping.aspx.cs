using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Security.Cryptography;
using System.Web.Security;
using System.Text;
using System.Runtime.InteropServices;
using System.IO;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities.CustomEntities;

public partial class Admin_LocationPrinterMapping : BasePage
{
    public Admin_LocationPrinterMapping()
        : base("Admin\\LocationPrinterMapping.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    Master_BL objReasonMaster;
    string ddlPrinterType;
    Label lbl_;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            LblFileName.Attributes.Add("Style", "diplay:none");
            Link_Del.Attributes.Add("Style", "diplay:none");
            if (!IsPostBack)
            {
                LoadGrid();
				Session["PostID"] = "1001";
                ViewState["PostID"] = Session["PostID"].ToString();
            }
            //LoadGrid();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading location printer mapping page", ex);
        }
    }
public bool IsValidPost()
    {
        if (ViewState["PostID"].ToString()== Session["PostID"].ToString())
        {
            Session["PostID"] =(Convert.ToInt16(Session["PostID"]) + 1).ToString();

            ViewState["PostID"] = Session["PostID"].ToString();

            return true;
        }
        else
        {
            ViewState["PostID"] =Session["PostID"].ToString();

            return false;
        }

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
	if (IsValidPost())
        {
       try
        {
            LblFileName1.Text = "";
            string FileContentVal = string.Empty;
            string savePath = string.Empty;

            long returnCode = -1;
            Master_BL objMaster_BL = new Master_BL(base.ContextInfo);
            Int64 autoID = 0;
            Int64 printerCode = 0;
            Int64.TryParse(hdnPrinterID.Value, out autoID);
            Int32 printerCount = grdPrinter.Rows.Count + 1;
            int isActive = 1;
            int isColorPrinter = 1;
            string pCode = string.Empty;




            string file_name = string.Empty;
            string file_name1 = string.Empty;
            string fileName = string.Empty;
            string pathToCheck = string.Empty;
            string tempfileName = "";
            //***************************************************

            if (!string.IsNullOrEmpty(txtPrinterName.Text))
            {
                if (txtfileupload.HasFile)
                {
                    file_name = txtfileupload.FileName.ToString();
                    //string extension = Path.GetExtension(txtfileupload.PostedFile.FileName);
                    file_name1 = Server.MapPath(txtfileupload.FileName);


                savePath = GetConfigValue("PRN_UploadPath", OrgID);

                    savePath = "E:\\LisKernel_Preprod\\PRNFiles\\";

                // string savePath = "E:\\temp\\PRNFileuploads\\";
                //savePath = System.Configuration.ConfigurationManager.AppSettings["PRNFileUploadPath"];

                    // Get the name of the file to upload.
                    fileName = txtfileupload.FileName;
                    // Create the path and file name to check for duplicates.
                    pathToCheck = savePath + fileName;
                    // Create a temporary file name to use for checking duplicates.

                txtfileupload.SaveAs(pathToCheck);
                //txtfileupload.PostedFile.SaveAs(MapPath(pathToCheck));
                // string file_name1 =txtfileupload.PostedFile.SaveAs(MapPath(".") + txtfileupload.PostedFile.FileName);

                    // string tempfileName = "";
                    // Check to see if a file already exists with the
                    // same name as the file to upload.    
                    if (System.IO.File.Exists(pathToCheck))
                    {
                        int counter = 2;
                        while (System.IO.File.Exists(pathToCheck))
                        {
                            // if a file with this name already exists,
                            // prefix the filename with a number.
                            tempfileName = counter.ToString() + fileName;
                            pathToCheck = savePath + tempfileName;
                            counter++;
                        }

                    fileName = tempfileName;
                    savePath += fileName;
                    txtfileupload.SaveAs(savePath);
                    FileContentVal = File.ReadAllText(savePath);


                }
            }

            if (printerCount < 10)
            {
                pCode = ILocationID.ToString() + "0" + printerCount.ToString();
                Int64.TryParse(pCode, out printerCode);
            }
            else
            {
                pCode = ILocationID.ToString() + "" + printerCount.ToString();
                Int64.TryParse(pCode, out printerCode);
            }
            if (chkActive.Checked)
                isActive = 1;
            else
                isActive = 0;

            if (chkColorPrinter.Checked)
                isColorPrinter = 1;
            else
                isColorPrinter = 0;



                //if (btnSave.Text == "Update" && LblFileName1.Text != "")
                //{

                //    if (System.IO.File.Exists(LblFileName1.Text))
                //    {
                //        int counter = 2;

                //        string splitstrval = LblFileName1.Text;
                //        string[] v = splitstrval.Split(new char[] { '\\' }, StringSplitOptions.RemoveEmptyEntries);
                //        fileName = v[3].ToString();
                //        //while (System.IO.File.Exists(LblFileName1.Text))
                //        //{
                //        // if a file with this name already exists,
                //        // prefix the filename with a number.

                //        savePath = "E:\\LisKernel_Preprod\\PRNFiles\\";

                //        tempfileName = counter.ToString() + fileName;
                //        pathToCheck = savePath + tempfileName;
                //        counter++;
                //        //}

                //        fileName = tempfileName;
                //        savePath += fileName;
                //        txtfileupload.SaveAs(savePath);
                //        FileContentVal = File.ReadAllText(savePath);


                //    }
                //}
                LblFileName1.Text = "";
                //returnCode = objMaster_BL.UpdateLocationPrintMapping(autoID, printerCode, txtPrinterName.Text, TxtDescription.Text, TxtType.Text, TxtPath.Text);
                returnCode = objMaster_BL.UpdateLocationPrintMapping(autoID, printerCode, txtPrinterName.Text, TxtDescription.Text, ddltype2.SelectedItem.Text, TxtPath.Text, isActive, isColorPrinter, FileContentVal, savePath);

            if (returnCode == 0)
            {
                Clear();
                ScriptManager.RegisterClientScriptBlock(UdtPanel, typeof(UpdatePanel), "", "alert('Printer Type saved/Updated successfully')", true);
                LoadGrid();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(UdtPanel, typeof(UpdatePanel), "", "alert('The Printer Details Already Exist.')", true);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving location printer mapping", ex);
        }
}


    }
    public void Clear()
    {
        txtPrinterName.Text = String.Empty;
        //TxtType.Text = string.Empty;
        TxtPath.Text = string.Empty;
        TxtDescription.Text = string.Empty;
        hdnPrinterID.Value = "0";
        hdnPrinterCode.Value = "";
        btnSave.Text = "Add";
        chkColorPrinter.Checked = false;
        chkActive.Checked = false;
        LblFileName1.Text = string.Empty;
    }
    protected void grdPrinter_RowDataBound(object sender, GridViewRowEventArgs e)
    {
         long lreturnCode = -1;


         //if (e.Row.RowType == DataControlRowType.DataRow)
         //{
         //    //getting username from particular row
         //    string Printername = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PrinterName"));
         //    //identifying the control in gridview
         //    LinkButton lnkbtnresult = (LinkButton)e.Row.FindControl("lnkDelete");
         //    //raising javascript confirmationbox whenver user clicks on link button
         //    lnkbtnresult.Attributes.Add("onclick", "javascript:return ConfirmationBox('" + Printername + "')");
         //}
        //List<DateAttributes> lstAddressType = new List<DateAttributes>();
        //List<Gender> lstGender = new List<Gender>();
        //List<MaritalStatus> lstMartialStatus = new List<MaritalStatus>();
         //try
         //{
             //if (!IsPostBack)
             //{
                 //if (e.Row.RowType == DataControlRowType.DataRow)
                 //{

                     //DropDownList ddltype1 = (e.Row.FindControl("ddltype") as DropDownList);
                     //                Title_BL objMaster_BL = new Title_BL(base.ContextInfo);
                     //returnCode = objMaster_BL.GetMetaData(out lstAddressType, out lstGender, out lstMartialStatus);
                     //if (lstAddressType.Count == 0)
                     //{
                     //    ddltype1.Items.Add("select");

                     //    ddltype1.Items.Add("1");

                     //    ddltype1.Items.Add("3"); 
                     //    ddltype1.DataBind();

                     //}

                     //DropDownList ddltype1 = (e.Row.FindControl("ddltype") as DropDownList);
                     //string domains = "PrinterType";
                     //string[] Tempdata = domains.Split(',');
                     //List<MetaData> lstmetadataInput = new List<MetaData>();
                     //List<MetaData> lstmetadataOutput = new List<MetaData>();
                     //MetaData objMeta;
                     //for (int i = 0; i < Tempdata.Length; i++)
                     //{
                     //    objMeta = new MetaData();
                     //    objMeta.Domain = Tempdata[i];
                     //    lstmetadataInput.Add(objMeta);
                     //}
                     //lreturnCode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);

                     //if (lreturnCode == 0)
                     //{
                     //    if (lstmetadataOutput.Count > 0)
                     //    {
                     //        var childItems = from child in lstmetadataOutput
                     //                         where child.Domain == "PrinterType"
                     //                         orderby child.MetaDataID ascending
                     //                         select child;
                     //        ddltype1.DataSource = childItems;
                     //        ddltype1.DataTextField = "DisplayText";
                     //       // ddltype1.DataValueField = "Code";
                     //        ddltype1.DataBind();
                     //        ddltype1.Items.Insert(0, "--Select--");
                            

                             //DataTable dtCurrentData = (DataTable)ViewState["CurrentData"];
                             //ddl.SelectedIndex = Convert.ToInt32(dtCurrentData.Rows[e.Row.RowIndex]["ddlIndex"]);

                             //System.Data.DataTable dt = ConvertToDatatable1(lstmetadataOutput);
                             //ddltype1.SelectedIndex = Convert.ToInt32(dt.Rows[e.Row.RowIndex]["ddltype"]);



         //                    string status = (e.Row.FindControl("lblCountry") as Label).Text;
         //                    ddltype1.Items.FindByValue(status).Selected = true;

         //                }
         //            }


         //        }
         //    //}
         //}
         //catch (Exception ex)
         //{
         //    CLogger.LogError("Error in loading location printer mapping grid: ", ex);
         //}
    }
    //public static DataTable ConvertToDatatable1(List<MetaData> lstMetaData)
    //{
    //    DataTable dt = new DataTable();
    //    dt.Columns.Add("DisplayText");
    //    dt.Columns.Add("Code");

    //    if (lstMetaData.Count > 0)
    //    {
    //        foreach (var item in lstMetaData)
    //        {
    //            dt.Rows.Add(item.DisplayText, item.Code);
                   
    //        }
    //    }
    //    return dt;
    //}

    protected void grdPrinter_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        try
        {
            if (e.CommandName == "Select")
            {
                btnSave.Text = "Update";
                Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = grdPrinter.Rows[rowIndex];
                hdnPrinterID.Value = grdPrinter.DataKeys[rowIndex]["AutoID"] != null ? Convert.ToString(grdPrinter.DataKeys[rowIndex]["AutoID"]) : string.Empty;
                txtPrinterName.Text = grdPrinter.DataKeys[rowIndex]["PrinterName"] != null ? (string)grdPrinter.DataKeys[rowIndex]["PrinterName"] : string.Empty;
                txtPrinterName.Focus();
                TxtDescription.Text = grdPrinter.DataKeys[rowIndex]["Description"] != null ? (string)grdPrinter.DataKeys[rowIndex]["Description"] : string.Empty;
                string text = grdPrinter.DataKeys[rowIndex]["Type"] != null ? (string)grdPrinter.DataKeys[rowIndex]["Type"] : string.Empty;
                ddltype2.ClearSelection();
                ddltype2.Items.FindByText(text).Selected = true;
                //ddlPrinterType = ddltype2.SelectedValue;
                //lbl_ = ddltype2.Items.FindByText(text);
                TxtPath.Text = grdPrinter.DataKeys[rowIndex]["Path"] != null ? (string)grdPrinter.DataKeys[rowIndex]["Path"] : string.Empty;

                int Val_Is_Active = grdPrinter.DataKeys[rowIndex]["IsActive"] != null ? grdPrinter.DataKeys[rowIndex]["IsActive"].ToString() == "False" ? 0 : 1 : 0;
                if ((Val_Is_Active) == 0)
                    chkActive.Checked = false;
                else
                    chkActive.Checked = true;


                int Val_Is_ColorPrinter = grdPrinter.DataKeys[rowIndex]["IsColorPrinter"] != null ? grdPrinter.DataKeys[rowIndex]["IsColorPrinter"].ToString() == "False" ? 0 : 1 : 0;
                if ((Val_Is_ColorPrinter) == 0)
                    chkColorPrinter.Checked = false;
                else
                    chkColorPrinter.Checked = true;

                String FileName_ = grdPrinter.DataKeys[rowIndex]["FilePathAndName"] != null ? Convert.ToString(grdPrinter.DataKeys[rowIndex]["FilePathAndName"]) : string.Empty;
                String FileContent_ = grdPrinter.DataKeys[rowIndex]["FileContent"] != null ? Convert.ToString(grdPrinter.DataKeys[rowIndex]["FileContent"]) : string.Empty;

                LblFileName1.Text = FileName_;
                if (LblFileName1.Text != string.Empty)
                {
                    LblFileName.Attributes.Add("Style", "diplay:block");
                    Link_Del.Attributes.Add("Style", "diplay:block");
                }
                else
                {
                    LblFileName.Attributes.Add("Style", "diplay:none");
                    Link_Del.Attributes.Add("Style", "diplay:none");
                }
            }
            //else if (e.CommandName == "Delete")
            //{

            //    Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
            //    GridViewRow row = grdPrinter.Rows[rowIndex];
            //    hdnPrinterID.Value = grdPrinter.DataKeys[rowIndex]["AutoID"] != null ? Convert.ToString(grdPrinter.DataKeys[rowIndex]["AutoID"]) : string.Empty;
            //    String FilePath_ = grdPrinter.DataKeys[rowIndex]["FilePathAndName"] != null ? Convert.ToString(grdPrinter.DataKeys[rowIndex]["FilePathAndName"]) : string.Empty;
            //    String FileContent_ = grdPrinter.DataKeys[rowIndex]["FileContent"] != null ? Convert.ToString(grdPrinter.DataKeys[rowIndex]["FileContent"]) : string.Empty;

            //    //String FilePath_ = "E:\\temp\\PRNFileuploads\\barcode LPL.prn";

            //    if (FilePath_ != string.Empty || FilePath_ != null)
            //    {
            //        if ((System.IO.File.Exists(FilePath_)))
            //        {
            //            System.IO.File.Delete(FilePath_);
            //        }

            //    }



            //    Master_BL objMaster_BL = new Master_BL(base.ContextInfo);
            //    long returnCode = -1;
            //    returnCode = objMaster_BL.DeleteLocationPrintMapping(Convert.ToInt32(hdnPrinterID.Value), "D");
            //    if (returnCode == 0)
            //    {

            //        //ScriptManager.RegisterClientScriptBlock(UdtPanel, typeof(UpdatePanel), "", "alert('Records Deleted successfully')", true);
            //       // this.UdtPanel.Update();
            //        LoadGrid();
            //    }
            //    else
            //    {
            //        //ScriptManager.RegisterClientScriptBlock(UdtPanel, typeof(UpdatePanel), "", "alert('Unable to Delete the Record.')", true);
            //    }

            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while editing printer", ex);
        }
    }


    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;

        try
        {

            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();

            returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
            if (lstConfig.Count > 0)
                configValue = lstConfig[0].ConfigValue;


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetConfigValue - HL7Messages.aspx", ex);
        }
        return configValue;
    }
    private void LoadGrid()
    {
        long returnCode = -1;
        Referrals_BL objReferrals_BL = new Referrals_BL(base.ContextInfo);
        List<LocationPrintMap> lstLocationPrintMapping = new List<LocationPrintMap>();
        string PrintType = "";
        returnCode = objReferrals_BL.GetLocation_Printer(OrgID, ILocationID, PrintType, out lstLocationPrintMapping);


        if (lstLocationPrintMapping.Count > 0)
        {
            grdPrinter.Attributes.Add("Style", "diplay:block");
            //lblResult.Visible = false;
            //lblResult.Text = "";
            grdPrinter.DataSource = lstLocationPrintMapping;
            grdPrinter.DataBind();
        }
        else
        {
            grdPrinter.Attributes.Add("Style", "diplay:none");
            //lblResult.Visible = true;
            //lblResult.Text = "No matching records found";
        }
    
        string domains = "PrinterType";
        string[] Tempdata = domains.Split(',');
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();
        MetaData objMeta;
        for (int i = 0; i < Tempdata.Length; i++)
        {
            objMeta = new MetaData();
            objMeta.Domain = Tempdata[i];
            lstmetadataInput.Add(objMeta);
        }
        returnCode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);

        if (returnCode == 0)
        {
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "PrinterType"
                                 orderby child.MetaDataID ascending
                                 select child;
                ddltype2.DataSource = childItems;
                ddltype2.DataTextField = "DisplayText";
                ddltype2.DataValueField = "MetaDataID";
                ddltype2.DataBind();
                ddltype2.Items.Insert(0, "--Select--");
            }
        }

    }
    protected void grdPrinter_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
       // LoadGrid();
        grdPrinter.PageIndex = e.NewPageIndex;
        LoadGrid();
       // grdPrinter.DataBind();
    }

    protected void lnkdelete_Click(object sender, EventArgs e)
    {

        LinkButton lnkbtn = sender as LinkButton;
        //getting particular row linkbutton
        GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
        //getting userid of particular row
        int autoid = Convert.ToInt32(grdPrinter.DataKeys[gvrow.RowIndex].Value.ToString());
       // int  autoid = Convert.ToInt32(gvrow.Cells[1].Text);
        string FilePath_ = gvrow.Cells[8].Text;
        string FileContent = gvrow.Cells[9].Text;


           if (FilePath_ != string.Empty || FilePath_ != null)
           {
               if ((System.IO.File.Exists(FilePath_)))
               {
                   System.IO.File.Delete(FilePath_);
               }

           }

           Master_BL objMaster_BL = new Master_BL(base.ContextInfo);
           long returnCode = -1;
           returnCode = objMaster_BL.DeleteLocationPrintMapping(Convert.ToInt32(autoid), "D");


           if (returnCode == 0)
                {

                    LoadGrid();
                    Clear();
               ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('Printer id " + autoid + " details deleted successfully')", true);
                }
                else
                {
                    //ScriptManager.RegisterClientScriptBlock(UdtPanel, typeof(UpdatePanel), "", "alert('Unable to Delete the Record.')", true);
                }

            }

    protected void Link_Del_Click(object sender, EventArgs e)
    {
        if ((Convert.ToInt32(hdnPrinterID.Value) != 0) && (LblFileName1.Text != string.Empty))
        {
            //Eixsisting file deleted from the physicalLocation
            if (LblFileName1.Text != string.Empty || LblFileName1.Text != null)
            {
                if ((System.IO.File.Exists(LblFileName1.Text)))
                {
                    System.IO.File.Delete(LblFileName1.Text);
                }

            }

            //to Delete the file and content from the backend
            Master_BL objMaster_BL = new Master_BL(base.ContextInfo);
            long returnCode = -1;
            returnCode = objMaster_BL.DeleteLocationPrintMapping(Convert.ToInt32(hdnPrinterID.Value), "U");
            if (returnCode == 0)
            {

                ScriptManager.RegisterClientScriptBlock(UdtPanel, typeof(UpdatePanel), "", "alert('Exsisting File Deleted successfully')", true);
                //LoadGrid();
                LblFileName1.Text = string.Empty;
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(UdtPanel, typeof(UpdatePanel), "", "alert('Unable to Delete the Record.')", true);
            }
        }
    }
}
