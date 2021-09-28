using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Web.UI.HtmlControls;
using System.IO;
using AjaxControlToolkit;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using System.Xml;
public partial class Admin_Analyzer : BasePage
{
    public Admin_Analyzer()
        : base("Admin_Analyzer_aspx")
    {
    }
    string pathname = string.Empty;
    SharedInventory_BL inventoryBL;
    List<Locations> lstInvLocation = new List<Locations>();
    ClinicalTrail_BL CT_BL;
    List<InvestigationMethod> lstInvMethod = new List<InvestigationMethod>();
    List<InvPrincipleMaster> lstInvPrincipleMaster = new List<InvPrincipleMaster>();
    List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
    Patient_BL patientBL;
    static List<InvInstrumentMaster> lstInvInstrumentMaster = new List<InvInstrumentMaster>();
    static int TypeID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new SharedInventory_BL(base.ContextInfo);
        CT_BL = new ClinicalTrail_BL(base.ContextInfo);
        patientBL = new Patient_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            BindProductType();
            // LoadUnit();
            LoadMetaData();
            loadDept();
            LoadInvestigationMethod();
            LoadInvestigationPrinciple();
            LoadTRFDetails();
            LoadAnalyzerDetails();
            hypLnkUOM.Attributes.Add("onclick", "javascript:setUOM(this.id);");
            hypLnkUOM1.Attributes.Add("onclick", "javascript:setUOM(this.id);");
            hypLnkUOM2.Attributes.Add("onclick", "javascript:setUOM(this.id);");
        }
    }
    public void LoadAnalyzerDetails()
    {
        try
        {
            new SharedInventory_BL(base.ContextInfo).GetAnalyzerProducts(OrgID, ILocationID, string.Empty, InventoryLocationID, out lstInvInstrumentMaster);
            if (lstInvInstrumentMaster.Count > 0)
            {
                grdAllProducts.DataSource = lstInvInstrumentMaster;
                grdAllProducts.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetAnalyzerProducts", ex);
        }
    }
    public void LoadTRFDetails()
    {
        //try
        //{
        //    long returnCode = -1;
        //    List<TRFfilemanager> lstTRF = new List<TRFfilemanager>();
        //    returnCode = new Patient_BL(base.ContextInfo).GetTRFimageDetails(-1, 0, OrgID, out lstTRF);
        //    grdTRFViewer.DataSource = lstTRF;
        //    grdTRFViewer.DataBind();
        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error while LoadTRFDetails()", ex);
        //}
    }
    public void LoadInvestigationMethod()
    {
        try
        {
            string strselect = Resources.Admin_AppMsg.Admin_drpSelect == null ? "--Select--" : Resources.Admin_AppMsg.Admin_drpSelect;
            long returnCode = -1;
            returnCode = patientBL.GetInvestigationMethod(OrgID, "", "", out lstInvMethod);
            if (lstInvMethod.Count > 0)
            {
                ddlMethod.DataSource = lstInvMethod;
                ddlMethod.DataTextField = "MethodName";
                ddlMethod.DataValueField = "MethodID";
                ddlMethod.DataBind();
                ddlMethod.Items.Insert(0, new ListItem(strselect, "0"));
            }
            foreach (var item in lstInvMethod)
            {
                hdnMethod.Value += item.MethodName + "~" + item.MethodID + "^";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetInvestigationMethod", ex);
        }
    }
    public void LoadInvestigationPrinciple()
    {
        try
        {
            string strselect = Resources.Admin_AppMsg.Admin_drpSelect == null ? "--Select--" : Resources.Admin_AppMsg.Admin_drpSelect;
           
            long returnCode = -1;
            returnCode = patientBL.GetInvestigationPrinciple(OrgID, "", "", out lstInvPrincipleMaster);
            if (lstInvPrincipleMaster.Count > 0)
            {
                ddlPrinciple.DataSource = lstInvPrincipleMaster;
                ddlPrinciple.DataTextField = "PrincipleName";
                ddlPrinciple.DataValueField = "PrincipleID";
                ddlPrinciple.DataBind();
                ddlPrinciple.Items.Insert(0, new ListItem(strselect, "0"));
            }
            foreach (var item in lstInvPrincipleMaster)
            {
                hdnPrinciple.Value += item.PrincipleName + "~" + item.PrincipleID + "^";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetInvestigationPrinciple()", ex);
        }
    }

    //public void LoadUnit()
    //{
    //    try
    //    {
    //        long returnCode = -1;
    //        List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    //        List<UOM> lstUOM = new List<UOM>();
    //        returnCode = new Investigation_BL(base.ContextInfo).GetUOMCode(out lstUOM);

    //        ddlSampleValue.DataSource = lstUOM;
    //        ddlSampleValue.DataTextField = "UOMCode";
    //        ddlSampleValue.DataValueField = "UOMID";
    //        ddlSampleValue.DataBind();
    //        ddlSampleValue.Items.Insert(0, new ListItem("--Select--", "0"));
    //        ddlSampleValue.Items[0].Selected = true;

    //        ddlDataStorage.DataSource = lstUOM;
    //        ddlDataStorage.DataTextField = "UOMCode";
    //        ddlDataStorage.DataValueField = "UOMID";
    //        ddlDataStorage.DataBind();
    //        ddlDataStorage.Items.Insert(0, new ListItem("--Select--", "0"));
    //        ddlDataStorage.Items[0].Selected = true;

    //        ddlThroughput.DataSource = lstUOM;
    //        ddlThroughput.DataTextField = "UOMCode";
    //        ddlThroughput.DataValueField = "UOMID";
    //        ddlThroughput.DataBind();
    //        ddlThroughput.Items.Insert(0, new ListItem("--Select--", "0"));
    //        ddlThroughput.Items[0].Selected = true;
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while GetUnitType", ex);
    //    }
    //}
    private void BindProductType()
    {
        try
        {
            List<ProductType> lstProductType = new List<ProductType>();
            inventoryBL.GetProductType(OrgID, out lstProductType);
            foreach (var item in lstProductType)
            {
                if (item.TypeName.ToUpper() == "ASSET")
                {
                    TypeID = item.TypeID;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetProductType", ex);
        }
    }
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
    private void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "Direction,Processing Mode";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childDirectionItems = from child in lstmetadataOutput
                                          where child.Domain == "Direction" //orderby child .MetaDataID
                                          select child;

                for (int m = 0; m < childDirectionItems.Count(); m++)
                {
                    hdnDirection.Value += childDirectionItems.ToList()[m].DisplayText + "~" + childDirectionItems.ToList()[m].Code + "^";
                }
                ddlDirection.DataSource = childDirectionItems;
                ddlDirection.DataTextField = "DisplayText";
                ddlDirection.DataValueField = "Code";
                ddlDirection.DataBind();
                var childProcessItems = from child in lstmetadataOutput
                                        where child.Domain == "Processing Mode" //orderby child .MetaDataID
                                        select child;
                for (int p = 0; p < childDirectionItems.Count(); p++)
                {
                    hdnProcessMode.Value += childProcessItems.ToList()[p].DisplayText + "~" + childProcessItems.ToList()[p].Code + "^";
                }

                ddlProcess.DataSource = childProcessItems;
                ddlProcess.DataTextField = "DisplayText";
                ddlProcess.DataValueField = "Code";
                ddlProcess.DataBind();

                #region Commented Lines for Duration dropdownlist
                //var childHistoryDuration = from child in lstmetadataOutput
                //                           where child.Domain == "HistoryDuration" //orderby child .MetaDataID
                //                           select child;
                //for (int D = 0; D < childHistoryDuration.Count(); D++)
                //{
                //    hdnDuration.Value += childHistoryDuration.ToList()[D].DisplayText + "~" + childHistoryDuration.ToList()[D].Code + "^";
                //}

                //ddlSampleValueDayHour.DataSource = childHistoryDuration;
                //ddlSampleValueDayHour.DataTextField = "DisplayText";
                //ddlSampleValueDayHour.DataValueField = "Code";
                //ddlSampleValueDayHour.DataBind();

                //ddlThroughputDayHour.DataSource = childHistoryDuration;
                //ddlThroughputDayHour.DataTextField = "DisplayText";
                //ddlThroughputDayHour.DataValueField = "Code";
                //ddlThroughputDayHour.DataBind();
                #endregion
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);
        }
    }
    protected void EpisodeFileUpload_Click(object sender, FileUploadCollectionEventArgs e)
    {
        try
        {
            long InstrumentID = SaveAnalyzerItems();
            long returncode = -1;
            pathname = GetConfigValue("TRF_UploadPath", OrgID);

            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

            int Year = dt.Year;
            int Month = dt.Month;
            int Day = dt.Day;

            //Root Path =D:\ATTUNE_UPLOAD_FILES\TRF_Upload\67\2013\10\9\123456\14_A.pdf

            String Root = String.Empty;
            String RootPath = String.Empty;
            //Root = ATTUNE_UPLOAD_FILES\TRF_Upload\ + OrgID + '\' + Year + '\' + Month + '\' + Day + '/' + Visitnumber ;
            Root ="ANALYZER-"+ OrgID + "-" + Year + "-" + Month + "-" + Day + "-" + "ANALYZER" + "-";
            Root = Root.Replace("-", "\\\\");
            RootPath = pathname + Root;
            //ENd///


            HttpFileCollection oHttpFileCollection = e.PostedFiles;
            HttpPostedFile oHttpPostedFile = null;
            if (e.HasFiles)
            {
                for (int n = 0; n < e.Count; n++)
                {
                    oHttpPostedFile = oHttpFileCollection[n];
                    if (oHttpPostedFile.ContentLength <= 0)
                        continue;
                    else
                    {
                        //string imagePath = pathname;
                        string Picture = System.IO.Path.GetFileNameWithoutExtension(oHttpPostedFile.FileName);
                        string FullName = System.IO.Path.GetFileName(oHttpPostedFile.FileName);
                        string picNameWithoutExt = OrgID.ToString();
                        string pictureName = picNameWithoutExt + '_' + Picture;
                        string NotImageFormat = OrgID.ToString() + '_' + FullName;
                        string fileExtension = System.IO.Path.GetExtension(oHttpPostedFile.FileName);
                        //string filePath = imagePath + NotImageFormat;
                        string filePath = RootPath + NotImageFormat;
                        
                        Response.OutputStream.Flush();
                        if (!System.IO.Directory.Exists(RootPath))
                        {
                            System.IO.Directory.CreateDirectory(RootPath);
                        }
                        string imageExtension = ".GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD";
                        if (imageExtension.Contains(fileExtension.ToUpper()))
                        {
                            pictureName = pictureName + ".jpg";
                            //filePath = imagePath + pictureName;
                            filePath = RootPath + pictureName;
                            int thumbWidth = 640, thumbHeight = 480;
                            System.Drawing.Image image = System.Drawing.Image.FromStream(oHttpPostedFile.InputStream);
                            int srcWidth = image.Width;
                            int srcHeight = image.Height;
                            if (thumbWidth > srcWidth)
                                thumbWidth = srcWidth;
                            if (thumbHeight > srcHeight)
                                thumbHeight = srcHeight;
                            Bitmap bmp = new Bitmap(thumbWidth, thumbHeight);
                            System.Drawing.Graphics gr = System.Drawing.Graphics.FromImage(bmp);
                            gr.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                            gr.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
                            gr.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
                            gr.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
                            System.Drawing.Rectangle rectDestination = new System.Drawing.Rectangle(0, 0, thumbWidth, thumbHeight);
                            gr.DrawImage(image, rectDestination, 0, 0, srcWidth, srcHeight, GraphicsUnit.Pixel);
                            if (System.IO.Directory.Exists(RootPath))
                            {
                                bmp.Save(filePath, ImageFormat.Jpeg);
                            }
                            gr.Dispose();
                            bmp.Dispose();
                            image.Dispose();
                            Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                            returncode = objPatientBL.SaveTRFDetails(pictureName, 0, 0, OrgID, InstrumentID, "ANALYZER",Root,LID,dt,"Y",0);
                        }
                        else
                        {
                            Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                            oHttpPostedFile.SaveAs(filePath);
                            pictureName = pictureName + fileExtension;
                            returncode = objPatientBL.SaveTRFDetails(pictureName, 0, 0, OrgID, InstrumentID, "ANALYZER", Root, LID, dt,"Y",0);
                        }
                    }
                }
            }
            if (returncode >= 0||InstrumentID>0)
            {
                string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02 == null ? "Information" : Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                string UsrMsgs = Resources.Admin_AppMsg.Admin_Analyzer_aspx_03 == null ? "Saved successfully." : Resources.Admin_AppMsg.Admin_Analyzer_aspx_03;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs + "','" + Information + "'); ClearFields('');", true);

                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "javascript:alert('Saved successfully'); ClearFields('');", true);
            }
            else if (InstrumentID == 0)
            {
                string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02 == null ? "Information" : Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                string UsrMsgs = Resources.Admin_AppMsg.Admin_Analyzer_aspx_04 == null ? "Device Code already exits !!!" : Resources.Admin_AppMsg.Admin_Analyzer_aspx_04;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs + "','" + Information + "');", true);

            }
            LoadAnalyzerDetails();
            Search(txtProductName.Text.Trim());
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Analyzer Items", ex);
        }
    }
    public long SaveAnalyzerItems()
    {
        long returncode = -1;
        long InstrumentID = 0;
        string strselect = Resources.Admin_AppMsg.Admin_drpSelect == null ? "--Select--" : Resources.Admin_AppMsg.Admin_drpSelect;
        AdminReports_BL Admin_BL = new AdminReports_BL(base.ContextInfo);
        List<InvInstrumentMaster> lstInvInstrumentMaster = new List<InvInstrumentMaster>();
        InvInstrumentMaster objInvInstrumentMaster = new InvInstrumentMaster();
        objInvInstrumentMaster.InstrumentID = Convert.ToInt64(hdnInstrumentID.Value);
        objInvInstrumentMaster.InstrumentName = txtProductName.Text.Trim();
        objInvInstrumentMaster.InstrumentType = TypeID;
        objInvInstrumentMaster.ProductCode = string.IsNullOrEmpty(hdnProductCode.Value.Trim()) ? txtProductCode.Text.Trim() : hdnProductCode.Value.Trim();
        objInvInstrumentMaster.Model = string.IsNullOrEmpty(hdnModel.Value.Trim()) ? txtModel.Text.Trim() : hdnModel.Value.Trim();
        objInvInstrumentMaster.Manufacturer = string.IsNullOrEmpty(hdnManufaturer.Value.Trim()) ? txtManufacturer.Text.Trim() : hdnManufaturer.Value.Trim();
        if (ddlMethod.Items.Count > 0)
        {
            objInvInstrumentMaster.Method = ddlMethod.SelectedItem.Text.Trim().Equals(strselect) == true ? "" : ddlMethod.SelectedItem.Text.Trim();
        }
        if (ddlPrinciple.Items.Count > 0)
        {
            objInvInstrumentMaster.Principle = ddlPrinciple.SelectedItem.Text.Trim().Equals(strselect) == true ? "" : ddlPrinciple.SelectedItem.Text.Trim();
        }
        if (ddlDepartment.Items.Count > 0)
        {
            objInvInstrumentMaster.Department = ddlDepartment.SelectedItem.Text.Trim().Equals(strselect) == true ? "" : ddlDepartment.SelectedItem.Text.Trim();
            objInvInstrumentMaster.DeptID = Convert.ToInt32(ddlDepartment.SelectedValue);
        }
        if (ddlProcess.Items.Count > 0)
        {
            objInvInstrumentMaster.ProcessingMode = ddlProcess.SelectedItem.Text.Trim().Equals("---Select---") == true ? "" : ddlProcess.SelectedItem.Text.Trim();
        }
        objInvInstrumentMaster.SampleVolume = string.IsNullOrEmpty(txtSampleValue.Text.Trim()) ? "" : txtSampleValue.Text.Trim() + "," + uomCode.Value; //+"," + ddlSampleValueDayHour.SelectedItem.Text;
        objInvInstrumentMaster.DataStorage = string.IsNullOrEmpty(txtDataStorage.Text.Trim()) ? "" : txtDataStorage.Text.Trim() + "," + uomCode1.Value;
        objInvInstrumentMaster.ThroughPut = string.IsNullOrEmpty(txtThroughput.Text.Trim()) ? "" : txtThroughput.Text.Trim() + "," + uomCode2.Value;//+ "," + ddlThroughputDayHour.SelectedItem.Text;
        if (ddlDirection.Items.Count > 0)
        {
            objInvInstrumentMaster.Direction = ddlDirection.SelectedItem.Text.Trim().Equals("---Select---") == true ? "" : ddlDirection.SelectedItem.Text.Trim();
        }
        objInvInstrumentMaster.ImagePath = string.Empty;
        objInvInstrumentMaster.CreatedBy = LID;
        objInvInstrumentMaster.OrgID = OrgID;
        objInvInstrumentMaster.LocationID = ILocationID;
        lstInvInstrumentMaster.Add(objInvInstrumentMaster);
        returncode = Admin_BL.SaveAnalyzerDetails(OrgID, ILocationID, lstInvInstrumentMaster, out InstrumentID);
        hdnProductCode.Value = string.Empty;
        hdnModel.Value = string.Empty;
        hdnManufaturer.Value = string.Empty;
        return InstrumentID;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        TRFImageUpload.btnUpload_Click(sender, e);
        string Msg1 = Resources.Admin_ClientDisplay.Admin_Analyzer_aspx_01 == null ? "Save" : Resources.Admin_ClientDisplay.Admin_Analyzer_aspx_01;
       // btnSave.Text = "Save";
        btnSave.Text = Msg1;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string objStr = txtSearch.Text.Trim();
        Search(objStr);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "javascript:ClearFields('SRCH');", true);
    }
    public void Search(string objStr)
    {
        if (objStr != string.Empty && txtSearch.Text =="")
        {
            grdAllProducts.DataSource = lstInvInstrumentMaster;
            grdAllProducts.DataBind();
        }
        else
        {
            var lstInvMaster = (from inv in lstInvInstrumentMaster
                                where inv.InstrumentName.ToLower().Contains(objStr.ToLower())
                                select new
                                {
                                    inv.InstrumentName,
                                    inv.InstrumentID,
                                    inv.InstrumentType,
                                    inv.ProductCode,
                                    inv.Model,
                                    inv.Manufacturer,
                                    inv.Method,
                                    inv.Principle,
                                    inv.Department,
                                    //inv.DeptID,
                                    inv.ProcessingMode,
                                    inv.SampleVolume,
                                    inv.DataStorage,
                                    inv.ThroughPut,
                                    inv.Direction,
                                    inv.Status,
                                    inv.CreatedBy,
                                    inv.QCData,
                                    inv.ImagePath
                                }).ToList();

            if (lstInvMaster.Count() > 0)
            {
                grdAllProducts.DataSource = lstInvMaster;
                grdAllProducts.DataBind();
            }
            else
            {
                grdAllProducts.DataSource = null;
                grdAllProducts.DataBind();
            }
        }
    }
    protected void grdAllProducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdAllProducts.PageIndex = e.NewPageIndex;
            LoadAnalyzerDetails();
        }
    }
    public string BindValue(string str)
    {
        string combinedStr = string.Empty;
        if (str.Contains(","))
        {
            combinedStr = str.Replace(",", " / ");
        }
        return combinedStr;
    }
    protected void grdAllProducts_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblPath = (Label)e.Row.FindControl("lblPath");
            Label lblInstrumentName = (Label)e.Row.FindControl("lblInstrumentName");
            Label lblValues = (Label)e.Row.FindControl("lblValues");
            e.Row.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
            string strVal = lblValues.Text.Trim();
            string str = "fill('" + strVal + "','" + lblInstrumentName.Text.Trim() + "','N','" + lblPath.Text.Trim() + "');";
            e.Row.Attributes.Add("onclick", str);
            string Msg2 = Resources.Admin_ClientDisplay.Admin_Analyzer_aspx_02 == null ? "Click here to edit details !!" : Resources.Admin_ClientDisplay.Admin_Analyzer_aspx_02;
            e.Row.ToolTip = Msg2;
            //e.Row.ToolTip = "Click here to edit details !!";
        }
    }
    protected void loadDept()
    {
        try
        {
            string strselect = Resources.Admin_AppMsg.Admin_drpSelect == null ? "--Select--" : Resources.Admin_AppMsg.Admin_drpSelect;
           
            long returnCode = -1;
            PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
            List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            returnCode = ObjInv.GetDeptSequence(OrgID, out lstDpt);
            if (lstDpt.Count > 0)
            {
                ddlDepartment.DataSource = lstDpt;
                ddlDepartment.DataTextField = "DeptName";
                ddlDepartment.DataValueField = "DeptID";
                ddlDepartment.DataBind();
                ddlDepartment.Items.Insert(0, new ListItem(strselect, "0"));
            }

            foreach (var item in lstDpt)
            {
                hdnDepartment.Value += item.DeptName + "~" + item.DeptID + "^";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loadDept()", ex);
        }

    }
}