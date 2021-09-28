using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using System.Xml.Linq;
using Attune.Podium.Common;
using System.Threading;
using System.Configuration;
using System.IO;
using System.Data;
using System.Data.OleDb;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Drawing;
using OfficeOpenXml.DataValidation;

using System.Web.Services;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
//----------Added by Baskaran ---
delegate void ExportDelegate(GridView Gv);
// ------- End  -----------------------------

public partial class Admin_RatesUpdation : BasePage
{
    int PageIndex = 1;
    int PageSize = 20;
	
    int PageCount = 0;
    int currentPageNo = 1;
    int totalRows = 0;
    int totalpage = 0;
    string Reftypes = "RM";
    List<ReasonMaster> lstReasonMaster;
    Master_BL objReasonMaster;
    List<AdminInvestigationRate> lstRates;
    List<AdminInvestigationRate> lstgridRates;
    
    public string strout;

    string sVal = string.Empty;
    public static string sFilePath = string.Empty;
    public static string FilePath = string.Empty;
    string strSelect = string.Empty;
    string strOrg = string.Empty;
    string strNotUpdate = string.Empty;
    string strAlert = string.Empty;
    string strUpdate = string.Empty;
    string strinvalid = string.Empty;
    public Admin_RatesUpdation()
        : base("Admin_RatesUpdation_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
         strSelect = Resources.Admin_ClientDisplay.Admin_RatesUpdation_aspx_01 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_RatesUpdation_aspx_01;
         strOrg = Resources.Admin_ClientDisplay.Admin_RatesUpdation_aspx_02 == null ? "--Select Organisation--" : Resources.Admin_ClientDisplay.Admin_RatesUpdation_aspx_02;
         
           strAlert = Resources.Admin_ClientDisplay.Admin_RatesUpdation_aspx_04 == null ? "Alert" : Resources.Admin_ClientDisplay.Admin_RatesUpdation_aspx_04;
            
             strNotUpdate = Resources.Admin_AppMsg.Admin_RatesUpdation_aspx_41 == null ? "Not Updated Successfully" : Resources.Admin_AppMsg.Admin_RatesUpdation_aspx_41;
             strUpdate = Resources.Admin_AppMsg.Admin_RatesUpdation_aspx_42 == null ? "Updated Successfully" : Resources.Admin_AppMsg.Admin_RatesUpdation_aspx_42;
              strinvalid = Resources.Admin_AppMsg.Admin_RatesUpdation_aspx_51 == null ? " Invalid Page Number. " : Resources.Admin_AppMsg.Admin_RatesUpdation_aspx_51;
        if (!IsPostBack)
        {
            LoadMetaData();
            LoadTrustedOrgDetails();
            LoadRates();
            LoadMetaDataVendorType();
            loadReasonDetails();
            tDOB.Text = Convert.ToString(Convert.ToDateTime(new BasePage().OrgDateTimeZone));
           // loadDepartments();
        }
        ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
        scriptManager.RegisterPostBackControl(this.imgExportToExcel);
        scriptManager.RegisterPostBackControl(this.btnUpload);
        scriptManager.RegisterPostBackControl(this.lnkXls);
        scriptManager.RegisterPostBackControl(this.ImgXls);
        scriptManager.RegisterPostBackControl(this.btnXls);
        sVal = GetConfigValue("HideFeeSplitUp", OrgID);
        sFilePath = GetConfigValue("RateDocumentUpload", OrgID).Replace("\\", "-");
        FilePath = GetConfigValue("RateDocumentUpload", OrgID);
      
        // .ShowError = false;
    }
    void loadReasonDetails()
    {
        long returnCode = -1;
        lstReasonMaster = new List<ReasonMaster>();
        objReasonMaster = new Master_BL(base.ContextInfo);
        returnCode = objReasonMaster.GetReasonMaster(0, 0, Reftypes, out lstReasonMaster);

        if (lstReasonMaster.Count > 0)
        {
            string setID = "0";
            ddlReason.DataSource = lstReasonMaster;
            ddlReason.DataTextField = "Reason";
            ddlReason.DataValueField = "Reason";
            ddlReason.DataBind();
            ddlReason.Items.Insert(0, strSelect);
            ddlReason.Items[0].Value = "0";
            ddlReason.SelectedValue = setID;
            
            ddlAttachReason.DataSource = lstReasonMaster;
            ddlAttachReason.DataTextField = "Reason";
            ddlAttachReason.DataValueField = "Reason";
            ddlAttachReason.DataBind();
            ddlAttachReason.Items.Insert(0, strSelect);
            ddlAttachReason.Items[0].Value = "0";
            ddlAttachReason.Items.Insert(1, "Others");
            ddlAttachReason.Items[1].Value = "1";
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
    protected void lnkXls_Click(object sender, EventArgs e)
    {
        try
        {
            ExportToExcelForRateCard();

        }
        catch (Exception ex)
        {

        }
    }
    protected void btnUploadRatecard_Click(object sender, EventArgs e)
    {

        try
        {
            DataTable dt = new DataTable();
            if (fupRatecardDetails.HasFile)
            {
                string connString = "";
                string ext = Path.GetExtension(fupRatecardDetails.FileName).ToLower();
                string path = Server.MapPath("~/Admin/" + fupRatecardDetails.FileName);
                fupRatecardDetails.SaveAs(path);
                //Connection String to Excel Workbook
                if (ext.Trim() == ".xls")
                {
                    connString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                }
                else if (ext.Trim() == ".xlsx")
                {
                    connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                }
                string query = "SELECT [SNO] as SNO,[OrgID] as Orgid,[TestCode],[TestType],[TestName] as TestName,[RateName] as RateName,Rate FROM [RateCardDetails$]";
                OleDbConnection conn = new OleDbConnection(connString);
                if (conn.State == ConnectionState.Closed)
                    conn.Open();
                try
                {
                    OleDbCommand cmd = new OleDbCommand(query, conn);
                    OleDbDataAdapter da = new OleDbDataAdapter(cmd);

                    da.Fill(dt);

                }
                catch
                {
                }
                finally
                {
                    conn.Close();
                }
                objReasonMaster = new Master_BL(base.ContextInfo);
                List<RateCardMaster> lstRateCardDetails = new List<RateCardMaster>();
                bool returnMsg = false;
                lstRateCardDetails = ConvertIntoRateCardList(dt, out returnMsg);
                if (returnMsg == true)
                {
                    List<RateCardMaster> lstInvClientMaster = new List<RateCardMaster>();
                    long returnCode = objReasonMaster.UpdateRateCardDetails(OrgID, lstRateCardDetails, out lstInvClientMaster);

                    if (lstInvClientMaster.Count == 0)
                    {

                        if (returnCode == -1)
                        {
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "BulkRatecardUpdate", "alert('Not Updated Successfully');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "BulkRatecardUpdate", "javascript:ValidationWindow('"+strNotUpdate+"','"+strAlert+"');", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "BulkRatecardUpdate", "javascript:ValidationWindow('" + strUpdate + "','" + strAlert + "');", true);

                        }
                    }
                    else
                    {
						JavaScriptSerializer serializer = new JavaScriptSerializer();
                         string strClientMaster = serializer.Serialize(lstInvClientMaster);
                       // Session["lstInvClientMaster"] = lstInvClientMaster;
						Session["lstInvClientMaster"]=strClientMaster;
                        ModelPopRatecard.Show();
                    }
                }
                else
                {
                    ACX2responsesRateCard.Style.Add("display", "block");
                    string strTestcode = Resources.Admin_AppMsg.Admin_RatesUpdation_aspx_43 == null ? "Testcode Or Rate Name is invalid in the excel sheet,Please check and re-upload" : Resources.Admin_AppMsg.Admin_RatesUpdation_aspx_43;

                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "BulkRatecardUpdate", "alert(' Testcode Or Rate Name is invalid in the excel sheet,Please check and re-upload');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "BulkRatecardUpdate", "javascript:ValidationWindow('" + strTestcode + "','" + strAlert + "');", true);
                }
                if (System.IO.File.Exists(path))
                    System.IO.File.Delete(path);

            }
        }
        catch (Exception ex)
        {


        }
    }
    protected void btnXls_Click(object sender, EventArgs e)
    {
        try
        {

            string sVersion = string.Empty;
           // List<RateCardMaster> lstRateCard = (List<RateCardMaster>)Session["lstInvClientMaster"];
		   JavaScriptSerializer serializer = new JavaScriptSerializer();
			List<RateCardMaster> lstRateCard=serializer.Deserialize<List<RateCardMaster>>(Convert.ToString(Session["lstInvClientMaster"]));
            //string attachment = "attachment; filename=" + ddlFeeType.SelectedValue + " - " + hdnRateName.Value + " - " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            System.Data.DataTable dt = ConvertToRateCardBulkUdate(lstRateCard);

            if (lstRateCard.Count > 0)
            {
                using (ExcelPackage pck = new ExcelPackage())
                {
                    //Create the worksheet
                    // pck.Workbook.Worksheets.Add("INV_Rates").Protection.IsProtected = true;
                    ExcelWorksheet ws = pck.Workbook.Worksheets.Add("RateCardDetails");
                    var tbl = dt;
                    //Load the datatable into the sheet, starting from cell A1. Print the column names on row 1

                    ws.Cells["A1"].LoadFromDataTable(tbl, true);

                    //Format the header for column 1-7
                    using (ExcelRange rng = ws.Cells["A1:G1"])
                    {
                        rng.Style.Font.Bold = true;
                        rng.Style.Fill.PatternType = ExcelFillStyle.Solid;                      //Set Pattern for the background to Solid
                        rng.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(79, 129, 189));  //Set color to dark blue
                        rng.Style.Font.Color.SetColor(Color.White);
                    }
                    ws.Column(7).Hidden = true;
                    ws.Column(7).Width = 0;

                    //ws.Column(7).Style.Hidden = true;
                    for (int i = 0; i < dt.Rows.Count; i++)
                        ws.Cells["G" + (i + 1)].Style.Hidden = true;


                    var dataRange = ws.Cells[ws.Dimension.Address.ToString()];
                    dataRange.AutoFitColumns();
                    HttpContext.Current.Response.Clear();
                    //Write it back to the client
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    HttpContext.Current.Response.AddHeader("content-disposition", "attachment;  filename=" + OrgName + "_" + OrgID + "_" + "RateupdationTemplate.xls");
                    HttpContext.Current.Response.BinaryWrite(pck.GetAsByteArray());

                    HttpContext.Current.Response.End();
                }
            }
        }
        catch
        {

            pnlconfirmation.Style.Add("display", "none");
        }
    }
    private DataTable ConvertToRateCardBulkUdate(List<RateCardMaster> listInvRateMaster)
    {
        //lan
        System.Data.DataTable _datatable = new System.Data.DataTable();
        _datatable.Columns.Add("SNo", typeof(System.Int32)); 
        _datatable.Columns.Add("OrgID", typeof(System.Int32));
        _datatable.Columns.Add("TestCode", typeof(System.String));
        _datatable.Columns.Add("TestType", typeof(System.String));
        _datatable.Columns.Add("TestName", typeof(System.String));
        _datatable.Columns.Add("RateName", typeof(System.String));
        _datatable.Columns.Add("Rate", typeof(System.Decimal));

        DataRow _datarow;
        foreach (RateCardMaster _list in listInvRateMaster)
        {

            _datarow = _datatable.NewRow();
            _datarow["SNo"] = _list.SNo; 
            _datarow["OrgID"] = _list.OrgID;
            _datarow["TestCode"] = _list.TestCode;
            _datarow["TestType"] = _list.TestType;
            _datarow["TestName"] = _list.TestName;
            _datarow["RateName"] = _list.RateName;
            _datarow["Rate"] = _list.Rate;
            _datatable.Rows.Add(_datarow);

        }
        return _datatable;
        //Test
    }

    private List<RateCardMaster> ConvertIntoRateCardList(DataTable dtRateCardData, out bool returnMsg)
    {
        List<RateCardMaster> lstRateCardData = new List<RateCardMaster>();
        returnMsg = true;
        try
        {

            for (int i = 0; i < dtRateCardData.Rows.Count; i++)
            {
                if (String.IsNullOrEmpty(dtRateCardData.Rows[i]["TestCode"].ToString()) || String.IsNullOrEmpty(dtRateCardData.Rows[i]["RateName"].ToString()))
                {
                    returnMsg = false;
                    return lstRateCardData;
                }
                RateCardMaster RateCardMaster = new RateCardMaster();
                RateCardMaster.SNo = Convert.ToInt32(dtRateCardData.Rows[i]["SNo"]);
                RateCardMaster.OrgID = Convert.ToInt32(dtRateCardData.Rows[i]["OrgID"].ToString());
                //   RateCardMaster.RateTypeID = Convert.ToInt32(dtRateCardData.Rows[i]["RateTypeID"].ToString());
                RateCardMaster.TestCode = dtRateCardData.Rows[i]["TestCode"].ToString();
                RateCardMaster.TestName = dtRateCardData.Rows[i]["TestName"].ToString();
                RateCardMaster.RateName = dtRateCardData.Rows[i]["RateName"].ToString();
                RateCardMaster.Rate = Convert.ToDecimal(dtRateCardData.Rows[i]["Rate"].ToString());
                RateCardMaster.TestType = dtRateCardData.Rows[i]["TestType"].ToString();
                lstRateCardData.Add(RateCardMaster);
            }
        }
        catch
        {

        }

        return lstRateCardData;
    }
    public void ExportToExcelForRateCard()
    {
        try
        {
            //string attachment = "attachment; filename=" + ddlFeeType.SelectedValue + " - " + hdnRateName.Value + " - " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            System.Data.DataTable dt = new DataTable();
            dt.Columns.Add("SNO");
            dt.Columns.Add("OrgID");
            dt.Columns.Add("TestCode");
            dt.Columns.Add("TestType");
            dt.Columns.Add("TestName");
            dt.Columns.Add("RateName");
            dt.Columns.Add("Rate");
            dt.AcceptChanges();



            using (ExcelPackage pck = new ExcelPackage())
            {
                //Create the worksheet
                // pck.Workbook.Worksheets.Add("INV_Rates").Protection.IsProtected = true;
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("RateCardDetails");
                var tbl = dt;
                //Load the datatable into the sheet, starting from cell A1. Print the column names on row 1

                ws.Cells["A1"].LoadFromDataTable(tbl, true);

                //Format the header for column 1-7
                using (ExcelRange rng = ws.Cells["A1:G1"])
                {
                    rng.Style.Font.Bold = true;
                    rng.Style.Fill.PatternType = ExcelFillStyle.Solid;                      //Set Pattern for the background to Solid
                    rng.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(79, 129, 189));  //Set color to dark blue
                    rng.Style.Font.Color.SetColor(Color.White);
                }

                //for (int i = 0; i < dt.Rows.Count; i++)
                //{
                //    var validation = ws.DataValidations.AddIntegerValidation("B" + (i + 1));
                //    validation.ShowErrorMessage = true;
                //    validation.ErrorTitle = "Invalid value was entered";
                //    validation.Error = "Value must be numeric value";
                //    validation.PromptTitle = "Enter numeric value here";
                //    validation.Prompt = "Value must be numeric value";
                //    validation.ShowInputMessage = true;
                //    // validation.Operator = ExcelDataValidationOperator.greaterThan;
                //    validation.Formula.Value = 0;
                //}



                //   ws.Column(7).Hidden = true;
                //   ws.Column(7).Width = 0;

                //ws.Column(7).Style.Hidden = true;
                for (int i = 0; i < dt.Rows.Count; i++)
                    ws.Cells["G" + (i + 1)].Style.Hidden = true;

                //   ws.Protection.IsProtected = true;
                // ws.Column(2).Style.Locked = false;


                var dataRange = ws.Cells[ws.Dimension.Address.ToString()];
                dataRange.AutoFitColumns();
                HttpContext.Current.Response.Clear();
                //Write it back to the client
                HttpContext.Current.Response.ContentType = "application/ms-excel";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment;  filename=" + OrgName + "_" + OrgID + "_" + "RateupdationTemplate.xls");
                HttpContext.Current.Response.BinaryWrite(pck.GetAsByteArray());
                //HttpContext.Current.ApplicationInstance.CompleteRequest();

                HttpContext.Current.Response.End();

                //Response.Clear();
                // //Write it back to the client
                // Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                //Response.AddHeader("content-disposition", "attachment;  filename=" + ddlFeeType.SelectedValue + " - " + hdnRateName.Value + " - " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xlsx");
                //Response.BinaryWrite(pck.GetAsByteArray());
                // //HttpContext.Current.ApplicationInstance.CompleteRequest();

                //  Response.End();
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }

    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        currentPageNo = 1;
        hdnCurrent.Value = "1";
        # region Added by Nalla
        /*Include UnMapped Items is added in both Go and Search button  */

        //if (chkunmapitems.Checked == true)
        //{
        //    ContextInfo.AdditionalInfo = "Y";
        //}
        //else
        //{
        //    ContextInfo.AdditionalInfo = "N";
        //}
        #endregion
        LoadGrid(currentPageNo, PageSize, "");
        hdnStatus.Value = "";
        hdnSearch.Value = "";
        txtsearch.Text = "";
        txtpageNo.Text = "";
        hdnSelect.Value = "";
        hdnTotalSplitFeeValue.Value = "";
    }

    protected void btnGo1_Click(object sender, EventArgs e)
    {
        if (txtpageNo.Text.Trim() != "")
        {
            # region Added by Nalla
            /*Include UnMapped Items is added in both Go and Search button  */
            //if (chkunmapitems.Checked == true)
            //{
            //    ContextInfo.AdditionalInfo = "Y";
            //}
            //else
            //{
            //    ContextInfo.AdditionalInfo = "N";
            //}
            #endregion
            int goPage = Convert.ToInt32(txtpageNo.Text.Trim());
            currentPageNo = Convert.ToInt32(txtpageNo.Text.Trim());
            string pname = "";
            if (hdnSearch.Value != "")
            {
                pname = hdnSearch.Value;
            }
            if (goPage <= Int32.Parse(lblTotal.Text))
            {
                hdnCurrent.Value = txtpageNo.Text;
                LoadGrid(Convert.ToInt32(txtpageNo.Text.Trim()), PageSize, pname);
            }
            else if (goPage > Int32.Parse(lblTotal.Text))
            {
               // ScriptManager.RegisterStartupScript(this, this.GetType(), "Invalidpage", "alert('"++"');", true);

                 ScriptManager.RegisterStartupScript(this, this.GetType(), "alrUpdateNotSuccessful", "javascript:ValidationWindow('" + strinvalid + "','" + strAlert + "');", true);
            }
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "CallGo", "fnLoadVendorType('Svr');fnloadRate('Svr');setAllValues();GetHdnValue();", true);
    }

    private int RateTypeID()
    {
        int iValue = 0;
        if (ddlFeeType.SelectedValue == "PHYSICIAN_FEE")
        {
            iValue = 1;
        }
        else if (ddlFeeType.SelectedValue == "INVESTIGATION_GROUP_FEE")
        {
            iValue = 2;
        }
        else if (ddlFeeType.SelectedValue == "INVESTIGATION_FEE")
        {
            iValue = 3;
        }
        else if (ddlFeeType.SelectedValue == "PROCEDURE_FEE")
        {
            iValue = 4;
        }
        else if (ddlFeeType.SelectedValue == "MEDICAL_INDENTS_RATES")
        {
            iValue = 5;
        }
        else if (ddlFeeType.SelectedValue == "GENERAL_BILLING_ITEMS")
        {
            iValue = 6;
        }

        else if (ddlFeeType.SelectedValue == "SURGERY_PACKAGE")
        {
            iValue = 7;
        }
        else if (ddlFeeType.SelectedValue == "HEALTH_PACKAGE")
        {
            iValue = 8;
        }
        else if (ddlFeeType.SelectedValue == "SOI_PROCEDURE")
        {
            iValue = 9;
        }
        else if (ddlFeeType.SelectedValue == "SPECIALITY")
        {
            iValue = 10;
        }
        return iValue;
    }

    private void LoadRates()
    {
        List<PageContextkey> lstRateTypes = new List<PageContextkey>();
        new AdminReports_BL(base.ContextInfo).pGetRateTypeMasters(OrgID, out lstRateTypes);

        //if (lstRateTypes.Count > 0)
        //{
        //    //lstRates =
        //    lstRateTypes = lstRateTypes.Where(j => j.ActionType == "Normal").ToList();
        //}

        foreach (PageContextkey textkey in lstRateTypes)
        {
            hdnAllRateNames.Value += textkey.OrgID + "#" + textkey.ContextType + "$" + textkey.ButtonName + "$" + textkey.ActionType + "$" + textkey.SubType + "^";
        }
        JavaScriptSerializer js = new JavaScriptSerializer();
        strout = js.Serialize(lstRateTypes);
        
        
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static String GetRateNamesAutocomplete(List<PageContextkey> InputList,String Type, String SubType, string txtName)
    {
        if (txtName=="%")
        {
            var query = from c in InputList
                        where c.SubType == SubType && c.ActionType == Type
                        select c;
            JavaScriptSerializer js = new JavaScriptSerializer();
            string strout = js.Serialize(query);
            return strout;
        }
        else
        {
            var query = from c in InputList
                        where c.ButtonName.ToLower().Contains(txtName.ToLower().Replace("%","").Trim()) && c.SubType == SubType && c.ActionType == Type 
                        select c;
            JavaScriptSerializer js = new JavaScriptSerializer();
            string strout = js.Serialize(query);
            return strout;
        }
        
    }
    private void loadDDLOrgDetails(DropDownList ddlOrgList, List<Organization> lstorgnList,int Flag,int BaseOrg)
    {
  if (Flag==0)
        ddlOrgList.DataSource = lstorgnList.Where(p => p.OrgID == BaseOrg);
  else  ddlOrgList.DataSource = lstorgnList;
        ddlOrgList.DataTextField = "Name";
        ddlOrgList.DataValueField = "OrgID";
        ddlOrgList.DataBind();
        ddlOrgList.Items.Insert(0, strOrg);
        ddlOrgList.Items[0].Value = "0";

    }

    private void LoadTrustedOrgDetails()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            SharedInventory_BL objBl = new SharedInventory_BL(base.ContextInfo);
            objBl.InvTrustedOrgDetail(OrgID,0, out lstOrgList);
            loadDDLOrgDetails(drpTrustedOrg, lstOrgList, 0, OrgID);
            loadDDLOrgDetails(ddlCopypTrustedOrg, lstOrgList, 1, OrgID);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }

    private void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "Rates,ServiceType,OptionType1,AddReduceType,PercentageValueType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            // string LangCode = string.Empty;
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
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "Rates" //orderby child .MetaDataID
                                 select child;
                ddlFeeType.DataSource = childItems;
                ddlFeeType.DataTextField = "DisplayText";
                ddlFeeType.DataValueField = "Code";
                ddlFeeType.DataBind();
                ddlFeeType.Items.Insert(0, strSelect);
                ddlFeeType.Items[0].Value = "0";
                
                var ServiceType = from child in lstmetadataOutput
                                  where child.Domain == "ServiceType" //orderby child .MetaDataID
                                 select child;
                if (ServiceType.Count() > 0)
                {
                    ddlMappingItems.DataSource = ServiceType;
                    ddlMappingItems.DataTextField = "DisplayText";
                    ddlMappingItems.DataValueField = "Code";
                    ddlMappingItems.DataBind();
                    ddlMappingItems.Items.Insert(0, strSelect);
                    ddlMappingItems.Items[0].Value = "0";
                    ddlrateMapping.DataSource = ServiceType;
                    ddlrateMapping.DataTextField = "DisplayText";
                    ddlrateMapping.DataValueField = "Code";
                    ddlrateMapping.DataBind();
                    ddlrateMapping.Items.Insert(0, strSelect);
                    ddlrateMapping.Items[0].Value = "0";
                }
                var OptionType1 = from child in lstmetadataOutput
                                 where child.Domain == "OptionType1" //orderby child .MetaDataID
                                  select child;
                if (OptionType1.Count() > 0)
                {
                    ddlMoreOption.DataSource = OptionType1;
                    ddlMoreOption.DataTextField = "DisplayText";
                    ddlMoreOption.DataValueField = "Code";
                    ddlMoreOption.DataBind();
                    ddlMoreOption.Items.Insert(0, strSelect);
                    ddlMoreOption.Items[0].Value = "0";
                    ddlSubMore.Items.Insert(0, strSelect);
                    ddlSubMore.Items[0].Value = "0";
                }
                var AddReduceType = from child in lstmetadataOutput
                                 where child.Domain == "AddReduceType" //orderby child .MetaDataID
                                 select child;
                if (AddReduceType.Count() > 0)
                {
                    ddlAddReduce.DataSource = AddReduceType;
                    ddlAddReduce.DataTextField = "DisplayText";
                    ddlAddReduce.DataValueField = "Code";
                    ddlAddReduce.DataBind();
                    ddlAddReduce.SelectedValue = "Add";
                }
                var PercentageValueType = from child in lstmetadataOutput
                                          where child.Domain == "PercentageValueType" //orderby child .MetaDataID
                                    select child;
                if (PercentageValueType.Count() > 0)
                {
                    ddlPercentageValue.DataSource = PercentageValueType;
                    ddlPercentageValue.DataTextField = "DisplayText";
                    ddlPercentageValue.DataValueField = "Code";
                    ddlPercentageValue.DataBind();
                    ddlPercentageValue.SelectedValue = "PER";
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);

        }
    }

    private void LoadMetaDataVendorType()
    {
        try
        {
            long returncode = -1;
            string domains = "Vendor Type";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            // string LangCode = string.Empty;
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
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "Vendor Type" && child.ParentID == 0
                                 select child;

                var SubtypeNormal = from child in lstmetadataOutput
                                    where child.Domain == "Vendor Type" && child.ParentID == Convert.ToInt32((from Parent in lstmetadataOutput
                                                                                                              where Parent.Code == "Normal" && Parent.Domain == "Vendor Type" && Parent.ParentID == 0
                                                                                                              select Parent.MetaDataID).FirstOrDefault())
                                    select child;

                var SubtypeSpecial = from child in lstmetadataOutput
                                     where child.Domain == "Vendor Type" && child.ParentID == Convert.ToInt32((from Parent in lstmetadataOutput
                                                                                                               where Parent.Code == "Special" && Parent.Domain == "Vendor Type" && Parent.ParentID == 0
                                                                                                               select Parent.MetaDataID).FirstOrDefault())
                                     select child;

                var SubtypeVendor = from child in lstmetadataOutput
                                    where child.Domain == "Vendor Type" && child.ParentID == Convert.ToInt32((from Parent in lstmetadataOutput
                                                                                                              where Parent.Code == "Vendor" && Parent.Domain == "Vendor Type" && Parent.ParentID == 0
                                                                                                              select Parent.MetaDataID).FirstOrDefault())
                                    select child;



                foreach (MetaData textkey in childItems)
                {
                    hdnVendorType.Value += textkey.Code + "#" + textkey.DisplayText + "$";
                }
                foreach (MetaData textkey in SubtypeNormal)
                {
                    hdnSubTypeNormal.Value += textkey.Code + "#" + textkey.DisplayText + "$";
                }

                foreach (MetaData textkey in SubtypeSpecial)
                {
                    hdnSubTypeSpecial.Value += textkey.Code + "#" + textkey.DisplayText + "$";
                }

                foreach (MetaData textkey in SubtypeVendor)
                {
                    hdnSubTypeVendor.Value += textkey.Code + "#" + textkey.DisplayText + "$";
                }
                //drpVendorType.DataSource = childItems;
                //drpVendorType.DataTextField = "DisplayText";
                //drpVendorType.DataValueField = "Code";
                //drpVendorType.DataBind();
                drpVendorType.Items.Insert(0, strSelect);
                drpVendorType.Items[0].Value = "0";
                ddlCopyRateType.Items.Insert(0, strSelect);
                ddlCopyRateType.Items[0].Value = "0";
                ddlSubtype.Items.Insert(0, strSelect);
                ddlSubtype.Items[0].Value = "0";


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Vendor Type  Meta Data ", ex);

        }
    }

    protected void gvRatesMaster_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chk = (CheckBox)e.Row.FindControl("chkBox");
                HiddenField hdnSpecId = (HiddenField)e.Row.FindControl("hdnSpecId");
                Label lblDescriptionName = (Label)e.Row.FindControl("lblDescriptionName");

                string strDescription = lblDescriptionName.Text.ToString();
                string[] GetSelectedValue = strDescription.Split('~');
                if (GetSelectedValue.Length > 1)
                {
                    lblDescriptionName.Text = GetSelectedValue[0];
                    hdnSpecId.Value = GetSelectedValue[1];
                }
                else
                {
                    lblDescriptionName.Text = GetSelectedValue[0];
                }
                if (sVal == "Y")
                {
                    LinkButton lnkSplitDetails = (LinkButton)e.Row.FindControl("lnkSplitDetails");
                    lnkSplitDetails.Visible = false;

                    if (ddlFeeType.SelectedValue == "INVESTIGATION_FEE")
                    {
                        if (hdnRateName.Value != "GENERAL")
                        {
                            TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
                            Label lblCprtRate = (Label)e.Row.FindControl("lblCprtRate");
                            Label lblGeneralAmount = (Label)e.Row.FindControl("lblGeneralAmount");
                            txtAmount.Attributes.Add("onblur", "rateCompare(  '" + txtAmount.ClientID + "', '" + Convert.ToDouble(lblCprtRate.Text) + "','" + Convert.ToDouble(lblGeneralAmount.Text) + "','" + e.Row.RowIndex + "')");
                            txtAmount.Attributes.Add("onkeyup", "UpdateRate(  '" + txtAmount.ClientID + "', '" + e.Row.RowIndex + "' )");
                            //txtAmount.Attributes.Add("onblur", "rateCompare('1', '2' )");                       
                        }
                    }
                }
            }

            if (e.Row.RowType != DataControlRowType.Pager)
            {
                e.Row.Cells[0].Visible = false;
                 e.Row.Cells[14].Visible = false;
                e.Row.Cells[10].Visible = true;
                e.Row.Cells[13].Visible = false;
               

                if (HideIPManageRate == "Y")
                {
                    e.Row.Cells[10].Visible = false;
                }

                if (sVal == "Y")
                {
                    //LinkButton lnkSplitDetails = (LinkButton)e.Row.FindControl("lnkSplitDetails");
                    //lnkSplitDetails.Visible = false;

                    if (hdnRateName.Value == "GENERAL")
                    {
                        e.Row.Cells[3].Visible = false;
                        e.Row.Cells[4].Visible = false;
                        e.Row.Cells[5].Visible = false;
                        e.Row.Cells[6].Visible = false;
                    }
                    else
                    {
                        e.Row.Cells[3].Visible = true;
                        e.Row.Cells[4].Visible = true;
                        e.Row.Cells[5].Visible = true;
                        e.Row.Cells[6].Visible = true;
                    }
                    if (ddlFeeType.SelectedValue == "INVESTIGATION_GROUP_FEE" || ddlFeeType.SelectedValue == "INVESTIGATION_FEE")
                    //if (ddlFeeType.SelectedValue == "INVESTIGATION_FEE")
                    {
                        e.Row.Cells[6].Visible = true;
                    }
                    else
                    {
                        e.Row.Cells[6].Visible = false;
                    }
                    if (ddlFeeType.SelectedValue == "INVESTIGATION_FEE")
                    {
                        
                        e.Row.Cells[8].Visible = true;
                        e.Row.Cells[9].Visible = true;
                    }
                    else
                    {
                        
                        e.Row.Cells[8].Visible = false;
                        e.Row.Cells[9].Visible = false;
                    }
                }
                else
                {
                    e.Row.Cells[3].Visible = false;
                    e.Row.Cells[4].Visible = false;
                    e.Row.Cells[5].Visible = false;
                    e.Row.Cells[6].Visible = false;
                    
                    e.Row.Cells[8].Visible = false;
                    e.Row.Cells[9].Visible = false;
                }
                if (ddlFeeType.SelectedValue != "PHYSICIAN_FEE" && ddlFeeType.SelectedValue != "SURGERY_PACKAGE" && ddlFeeType.SelectedValue != "SOI_PROCEDURE")
                {
                   
                    e.Row.Cells[11].Visible = false;
                    
                    e.Row.Cells[12].Visible = false;                   
                    e.Row.Cells[13].Visible = false;                   
                    e.Row.Cells[14].Visible = false;            
                    e.Row.Cells[15].Visible = false;         
                    e.Row.Cells[16].Visible = true;                
                }
                else if (ddlFeeType.SelectedValue != "PHYSICIAN_FEE" && ddlFeeType.SelectedValue == "SURGERY_PACKAGE" && ddlFeeType.SelectedValue != "SOI_PROCEDURE")
                {
                    
                    e.Row.Cells[11].Visible = false;                 
                    e.Row.Cells[12].Visible = false;                   
                    e.Row.Cells[13].Visible = false;                   
                    e.Row.Cells[14].Visible = false;              
                    e.Row.Cells[15].Visible = false;
                    e.Row.Cells[16].Visible = true;
                }

                else if (ddlFeeType.SelectedValue == "SOI_PROCEDURE")
                {
                    e.Row.Cells[10].Visible = true;
                    
                    e.Row.Cells[11].Visible = false;         
                    e.Row.Cells[12].Visible = false;                   
                    e.Row.Cells[13].Visible = true;                  
                    e.Row.Cells[14].Visible = false;                   
                    e.Row.Cells[15].Visible = false;
                    e.Row.Cells[16].Visible = true;
                    e.Row.Cells[17].Visible = false;

                }
                else
                {
                    if (e.Row.RowType == DataControlRowType.Header)
                    {
                        e.Row.Cells[2].Text = "Amount For OP";
                    }

                    
                    e.Row.Cells[14].Visible = false;                   
                    e.Row.Cells[15].Visible = false;
                    e.Row.Cells[16].Visible = true;
                    e.Row.Cells[17].Visible = false;
                }
                e.Row.Cells[17].Visible = true;


            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "SetVal", "SetValue();", true);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvInvRates_RowDataBound().", ex);
        }

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("RatesUpdation.aspx");
        //try
        //{
        //    long Returncode = -1;
        //    List<Role> lstUserRole = new List<Role>();
        //    string path = string.Empty;
        //    Role role = new Role();
        //    role.RoleID = RoleID;
        //    lstUserRole.Add(role);
        //    Returncode = new Navigation().GetLandingPage(lstUserRole, out path);
        //    Response.Redirect(Request.ApplicationPath + path, true);
        //}
        //catch (System.Threading.ThreadAbortException tae)
        //{
        //    string thread = tae.ToString();
        //}
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveRate();
    }

    protected void SaveRate()
    {

        if (!Page.IsValid)
        {
            string sPath = "Admin\\\\RatesUpdation.aspx.cs_11";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg('" + sPath + "')", true);

        }
        long returnCode = -1;
        //ErrorDisplay1.ShowError = false;
        List<AdminInvestigationRate> lstRates = new List<AdminInvestigationRate>();
        lstRates = GetInvRateDetails();
        List<FeeSplitSeriveDetails> lstSplitDetails = new List<FeeSplitSeriveDetails>();

        if (!string.IsNullOrEmpty(hdnTotalSplitFeeValue.Value))
        {
            lstSplitDetails = GetSplitDetails();
        }

        //if (hdniValue.Value == "7")
        //{
        //    lstRates = GetSPKGRateDetails();
        //}
        //else
        //{
        //    lstRates = GetInvRateDetails();
        //}
        AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
        if (hdnStatus.Value == "Changed")
        {
            if (lstRates.Count > 0)
            {
                int iValue = 0;
                iValue = RateTypeID();
                long RateRefID = -1;
                long ParentID = -1;
                string Reason = "";
                string Code = string.Empty;
                string[] RateID = hdnRateID.Value.Split('~');
                int iRateID = Convert.ToInt32(RateID[1].ToString());
                RateRefID = Convert.ToInt64(RateID[2].ToString());
                ParentID = Convert.ToInt64(RateID[3].ToString());
                //int iClientId = Convert.ToInt32(ddlClientName.SelectedValue);

                if (ddlReason.SelectedValue != "0")
                {
                    Reason = ddlReason.SelectedItem.ToString();
                }
                if (iRateID != 0)
                {
                    returnCode = objBl.SaveInvestigationRate(lstRates, iValue, iRateID, LID, OrgID, RateRefID, ParentID, Code, lstSplitDetails, Reason);
                }
                if (returnCode == 0)
                {
                    string sPath = "Admin\\\\RatesUpdation.aspx.cs_13";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg('" + sPath + "')", true);
                    if (Request.QueryString["ClientID"] != null && Request.QueryString["ClientCode"] != null && Request.QueryString["ClientName"] != null && Request.QueryString["OrgID"] != null && Request.QueryString["OrgAddressID"] != null)
                    {
                        string CltID = Request.QueryString["ClientID"];
                        string CltCode = Request.QueryString["ClientCode"];
                        string CltName = Request.QueryString["ClientName"];
                        string OrgID = Request.QueryString["OrgID"];
                        string OAddID = Request.QueryString["OrgAddressID"];
                        Response.Redirect("~/Invoice/ClientManagement.aspx?ClientID=" + CltID + "&ClientCode=" + CltCode + "&ClientName=" + CltName + "&OrgID=" + OrgID + "&OrgAddressID=" + OAddID + "", true);

                    }

                }
            }
            else
            {
                //ErrorDisplay1.ShowError = true;
                //ErrorDisplay1.Status = "Select a record and Save";
            }
        }
        currentPageNo = 1;
        hdnCurrent.Value = "1";
        //chkunmapitems.Checked = false;
        ContextInfo.AdditionalInfo = "Y";
        LoadGrid(currentPageNo, PageSize, "");
        hdnSearch.Value = "";
        txtsearch.Text = "";
        txtpageNo.Text = "";
        hdnSelect.Value = "";
        hdnStatus.Value = "";
        hdnTotalSplitFeeValue.Value = "";
    }

    public List<AdminInvestigationRate> GetSPKGRateDetails()
    {
        List<AdminInvestigationRate> lstAdminDetails = new List<AdminInvestigationRate>();

        foreach (GridViewRow row in gvRatesMaster.Rows)
        {
            CheckBox chkBox = (CheckBox)row.FindControl("chkBox");
            if (chkBox.Checked)
            {
                TextBox txtAmounts = new TextBox();
                TextBox txtIPAmt = new TextBox();
                TextBox txtOpPercent = new TextBox();
                TextBox txtIpPercent = new TextBox();
                TextBox txtServiceCodes = new TextBox();
                TextBox txtminAdvAmt = new TextBox();
                Label lblSourceID = new Label();
                Label lblDescriptionName = new Label();
                HiddenField hdnSpecId = new HiddenField();
                lblSourceID = (Label)row.FindControl("lblSourceID");
                txtAmounts = (TextBox)row.FindControl("txtAmount");
                txtIPAmt = (TextBox)row.FindControl("txtIPAmount");
                txtServiceCodes = (TextBox)row.FindControl("txtServiceCode");

                lblDescriptionName = (Label)row.FindControl("lblDescriptionName");
                hdnSpecId = (HiddenField)row.FindControl("hdnSpecId");
                txtminAdvAmt = (TextBox)row.FindControl("txtMinAdvAmount");
                //if (ddlFeeType.SelectedIndex == 1)
                //{
                if (ddlFeeType.SelectedValue == "PHYSICIAN_FEE")
                {
                    txtOpPercent = (TextBox)row.FindControl("txtOPPrecent");
                    txtIpPercent = (TextBox)row.FindControl("txtIPPrecent");
                }

                if (ddlFeeType.SelectedValue == "SOI_PROCEDURE")
                {
                    txtminAdvAmt = (TextBox)row.FindControl("txtMinAdvAmount");
                }
                if (txtAmounts.Text == "")
                {
                    txtAmounts.Text = "0.0";
                }
                if (txtIPAmt.Text == "")
                {
                    txtIPAmt.Text = "0.0";
                }
                if (txtOpPercent.Text == "")
                {
                    txtOpPercent.Text = "0.0";
                }
                if (txtIpPercent.Text == "")
                {
                    txtIpPercent.Text = "0.0";
                }
                if (txtServiceCodes.Text == "")
                {
                    txtServiceCodes.Text = "";
                }
                AdminInvestigationRate InvRateDetails = new AdminInvestigationRate();
                InvRateDetails.ID = Convert.ToInt64(row.Cells[0].Text);
                //InvRateDetails.DescriptionName = row.Cells[1].Text;
                InvRateDetails.DescriptionName = lblDescriptionName.Text + "~" + Convert.ToString(hdnSpecId.Value);
                InvRateDetails.Amount = Convert.ToDecimal(txtAmounts.Text.ToString());
                InvRateDetails.IPAmount = Convert.ToDecimal(txtIPAmt.Text.ToString());
                InvRateDetails.SourceID = Convert.ToInt64(lblSourceID.Text);
                InvRateDetails.UOMCode = txtServiceCodes.Text;
                if (ddlFeeType.SelectedValue == "PHYSICIAN_FEE")
                {
                    txtIPAmt = (TextBox)row.FindControl("txtIPAmount");
                    txtOpPercent = (TextBox)row.FindControl("txtOPPrecent");
                    txtIpPercent = (TextBox)row.FindControl("txtIPPrecent");
                    InvRateDetails.IPAmount = Convert.ToDecimal(txtIPAmt.Text.ToString());
                    InvRateDetails.IPPercent = Convert.ToDecimal(txtIpPercent.Text.ToString());
                    InvRateDetails.OPPercent = Convert.ToDecimal(txtOpPercent.Text.ToString());
                    InvRateDetails.UOMCode = txtServiceCodes.Text;
                }
                else
                {
                    InvRateDetails.IPPercent = 0;
                    InvRateDetails.OPPercent = 0;
                }
                lstAdminDetails.Add(InvRateDetails);
            }
        }
        return lstAdminDetails;
    }

    public List<AdminInvestigationRate> GetInvRateDetails()
    {
        List<AdminInvestigationRate> lstAdminDetails = new List<AdminInvestigationRate>();
        long ParentID = 0;
        AdminInvestigationRate InvRateDetails;
        string[] RateID = hdnRateID.Value.Split('~');
        Int64.TryParse(RateID[3], out ParentID);
        string[] SelVal = hdnSelect.Value.Split('^');
        for (int i = 0; i < SelVal.Length - 1; i++)
        {
            string[] Sel = SelVal[i].Split('*')[1].Split('~');
            InvRateDetails = new AdminInvestigationRate();
            InvRateDetails.ID = Convert.ToInt64(Sel[2]);
            InvRateDetails.DescriptionName = Sel[12].Replace("\r", "").Replace("\n", "").Replace("AddSplit", "");
            InvRateDetails.Amount = Convert.ToDecimal(Sel[4]);
            InvRateDetails.IPAmount = Convert.ToDecimal(Sel[6]);
            InvRateDetails.SourceID = Convert.ToInt64(Sel[0]);
            InvRateDetails.UOMCode = Sel[9];
            InvRateDetails.IPPercent = Convert.ToDecimal(Sel[8]);
            InvRateDetails.OPPercent = Convert.ToDecimal(Sel[7]);
            InvRateDetails.UOMID = Convert.ToInt32(Sel[1]);
            InvRateDetails.MinAdvanceAmt = Convert.ToDecimal(Sel[10]);
            if (InvRateDetails.Amount != 0 || InvRateDetails.IPAmount != 0)
            {
                InvRateDetails.Type = "Y";
            }
            else
            {
                InvRateDetails.Type = "N";
            }
            lstAdminDetails.Add(InvRateDetails);
        }
        return lstAdminDetails;
    }

    protected void gvRatesMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = gvRatesMaster.SelectedRow;
    }

    protected void gvRatesMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvRatesMaster.PageIndex = e.NewPageIndex;
            // Added by Perumal on 29 Oct 2011 - Start
            currentPageNo = e.NewPageIndex;
            // Added by Perumal on 29 Oct 2011 - End
            btnGo_Click(sender, e);
        }
    }

    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        string pname = "";
        if (hdnSearch.Value != "")
        {
            pname = hdnSearch.Value;
        }
        //if (chkunmapitems.Checked == true)
        //{
        //    ContextInfo.AdditionalInfo = "Y";
        //}
        //else
        //{
        //    ContextInfo.AdditionalInfo = "N";
        //}
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(currentPageNo, PageSize, pname);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(currentPageNo, PageSize, pname);
        }
        txtpageNo.Text = "";
    }

    protected void btnCopyRates_Click(object sender, EventArgs e)
    {
        String IsAction = "", Rate="";
        long returnCode = -1;
        long FromRateRefID = -1;
        long FromParentID = -1;
        long ToRateRefID = -1;
        long ToParentID = -1;
        try
        {
            int typeID = 0;
            if (ddlFeeType.SelectedValue == "PHYSICIAN_FEE")
            {
                typeID = 1;
            }
            else if (ddlFeeType.SelectedValue == "INVESTIGATION_GROUP_FEE")
            {
                typeID = 2;
            }
            else if (ddlFeeType.SelectedValue == "INVESTIGATION_FEE")
            {
                typeID = 3;
            }
            else if (ddlFeeType.SelectedValue == "PROCEDURE_FEE")
            {
                typeID = 4;
            }
            else if (ddlFeeType.SelectedValue == "MEDICAL_INDENTS_RATES")
            {
                typeID = 5;
            }
            else if (ddlFeeType.SelectedValue == "GENERAL_BILLING_ITEMS")
            {
                typeID = 6;
            }
            else if (ddlFeeType.SelectedValue == "HEALTH_PACKAGE")
            {
                typeID = 8;
            }
            else if (ddlFeeType.SelectedValue == "SOI_PROCEDURE")
            {
                typeID = 9;
            }
            else if (ddlFeeType.SelectedValue == "SPECIALITY")
            {
                typeID = 10;
            }

            if (ddlrateMapping.SelectedItem.Text == "Mapped Services") { IsAction = "Y"; Rate = null; }
            else if (ddlrateMapping.SelectedItem.Text == "Un-Mapped Service") { IsAction = "N"; Rate = null; }
            else if (ddlrateMapping.SelectedItem.Text == "Zero-Value services") { IsAction = null; Rate = "0"; }
            else if (ddlrateMapping.SelectedItem.Text == "Zero-Value with mapped Services") { IsAction = "Y"; Rate = "0"; }
            else if (ddlrateMapping.SelectedItem.Text == "Zero With Un-Mapped Services") { IsAction = "N"; Rate = "0"; }
            else if (ddlrateMapping.SelectedIndex == 0) { IsAction = null; Rate = null; }

            //hdnFromClient.Value = ddlCopyToRate.SelectedValue.ToString() == "0" ? hdnFromClient.Value : ddlCopyToRate.SelectedValue.ToString();
            string[] FormRate = hdnFromClient.Value.Split('~');
            Int64.TryParse(FormRate[2], out FromRateRefID);
            Int64.TryParse(FormRate[3], out FromParentID);
            //hdnFromClient.Value = "0";// ddlCopyToRate.SelectedValue.ToString();
            string[] TORate = hdnRateID.Value.Split('~');
            Int64.TryParse(TORate[2], out ToRateRefID);
            Int64.TryParse(TORate[3], out ToParentID);

            long fromRateID = Convert.ToInt64(FormRate[1]);
            long tORateID = Convert.ToInt64(TORate[1]);
            decimal addReduceValue = Convert.ToDecimal(txtAddReduce.Text);
            string addReduceType = ddlAddReduce.SelectedValue + ddlPercentageValue.SelectedValue;
            AdminReports_BL arBL = new AdminReports_BL(base.ContextInfo);
            int ToOrgID = 0;
            ToOrgID = Convert.ToInt32(ddlCopypTrustedOrg.SelectedValue);

            returnCode = arBL.UpdateRatesFromClientToClient(typeID, fromRateID, tORateID, addReduceValue, addReduceType, LID, OrgID, FromRateRefID, FromParentID, ToRateRefID, ToParentID, IsAction, Rate, ToOrgID);
            txtAddReduce.Text = "0.00";
            ddlPercentageValue.SelectedValue = ddlPercentageValue.Items.FindByValue("PER").Value;
            ddlAddReduce.SelectedValue = ddlAddReduce.Items.FindByValue("ADD").Value;

            currentPageNo = 1;
            hdnCurrent.Value = "1";
            LoadGrid(currentPageNo, PageSize, "");
            hdnStatus.Value = "";
            hdnSearch.Value = "";
            txtsearch.Text = "";
            txtpageNo.Text = "";
            hdnSelect.Value = "";

            if (returnCode == 0)
            {
                string sPath = "Admin\\\\RatesUpdation.aspx.cs_9";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg('" + sPath + "')", true);

                ddlCopypTrustedOrg.SelectedIndex = 0;

            }
        }
        catch (Exception ex)
        {

            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {

        try
        {
            ContextInfo.AdditionalInfo = "Y";
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            List<AdminInvestigationRate> lstRates = new List<AdminInvestigationRate>();
            string pName = txtsearch.Text.Trim();
            if (pName.Contains(':'))
            {
                pName = pName.Split(':')[0];
            }
            string name = pName;

            hdnSearch.Value = name;
            hdnCurrent.Value = "1";
            currentPageNo = 1;
            LoadGrid(currentPageNo, PageSize, name);
            txtpageNo.Text = "";
            if (txtsearch.Text.Trim() == "")
            {
                txtsearch.Focus();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Search the Items in Rates Updatation.", ex);
        }
    }

    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        string pname = "";
        if (hdnSearch.Value != "")
        {
            pname = hdnSearch.Value;
        }
        //if (chkunmapitems.Checked == true)
        //{
        //    ContextInfo.AdditionalInfo = "Y";
        //}
        //else
        //{
        //    ContextInfo.AdditionalInfo = "N";
        //}
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(currentPageNo, PageSize, pname);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(currentPageNo, PageSize, pname);
        }
        txtpageNo.Text = "";
    }

    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }

    public void LoadGrid(int currentPageNo, int PageSize, string pName)
    {
       
        if (pName.Contains('.'))
        {
            pName = pName.Split('.')[1];
        }
        if (pName.Contains(':'))
        {
            pName = pName.Split(':')[0];
        } 
        int iValue = RateTypeID();
        long pRateID = 0;
        long RateRefID = 0;
        long ParentRefID = 0;
        string Code = "",Rate="",InvDeptID="";
        string[] RateDetails = hdnRateID.Value.Split('~');
        pRateID = Convert.ToInt32(RateDetails[1].ToString());
        RateRefID = Convert.ToInt64(RateDetails[2].ToString());
        ParentRefID = Convert.ToInt64(RateDetails[3].ToString());
        lstRates = new List<AdminInvestigationRate>();
        lstgridRates = new List<AdminInvestigationRate>();
        //# region Added by Nalla
        // //Include UnMapped Items not working while Search

        //if (chkunmapitems.Checked == true)
        //{
        //    ContextInfo.AdditionalInfo = "Y";
        //}
        //else
        //{
        //    ContextInfo.AdditionalInfo = "N";
        //}
        //#endregion

        if (ddlMappingItems.SelectedItem.Text == "Mapped Services") { ContextInfo.AdditionalInfo = "Y"; Rate = null; }
        else if (ddlMappingItems.SelectedItem.Text == "Un-Mapped Service") { ContextInfo.AdditionalInfo = "N"; Rate = null; }
        else if (ddlMappingItems.SelectedItem.Text == "Zero-Value services") { ContextInfo.AdditionalInfo = null; Rate ="0"; }
        else if (ddlMappingItems.SelectedItem.Text == "Zero-Value with mapped Services") { ContextInfo.AdditionalInfo = "Y"; Rate = "0"; }
        else if (ddlMappingItems.SelectedItem.Text == "Zero With Un-Mapped Services") { ContextInfo.AdditionalInfo = "N"; Rate = "0"; }
        else if (ddlMappingItems.SelectedIndex == 0) { ContextInfo.AdditionalInfo = "ALL"; Rate = null; }

        if (hdnDeparment.Value == "" || hdnDeparment.Value == null)
        {
            InvDeptID = null;
        }
        else
        {
            InvDeptID = hdnDeparment.Value;
        }
        hdniValue.Value = Convert.ToString(iValue);
        new AdminReports_BL(base.ContextInfo).GetInvestigationRates(OrgID, iValue, pRateID, RateRefID, ParentRefID, Code,
            out lstRates, out lstgridRates, currentPageNo, PageSize, pName, out PageCount, Rate,InvDeptID);
        hdnDeparment.Value = null;
        if (lstRates.Count > 0)
        {
            totalRows = PageCount;
            lblTotal.Text = totalRows.ToString();

            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = currentPageNo.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                currentPageNo = Convert.ToInt32(hdnCurrent.Value);
            }
            if (currentPageNo == 1)
            {
                Btn_Previous.Enabled = false;

                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    Btn_Next.Enabled = true;
                }
                else
                    Btn_Next.Enabled = false;
            }
            else
            {
                Btn_Previous.Enabled = true;

                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    Btn_Next.Enabled = false;
                else Btn_Next.Enabled = true;
            }
            GrdFooter.Style.Add("display", "table-row");
            trButton.Style.Add("display", "table-row");
            imgExportToExcel.Visible = true;
            tblfileuploadcntrl.Style.Add("display", "table");
            lnkExportXL.Visible = true;
            
        }
        else
        {
            lstRates.Clear();
            currentPageNo = 0;
            totalpage = 0;
            GrdFooter.Style.Add("display", "none");
            trButton.Style.Add("display", "none");
            imgExportToExcel.Visible = false;
            tblfileuploadcntrl.Style.Add("display", "none");
            lnkExportXL.Visible = false;
        }
        gvRatesMaster.DataSource = lstRates;
        gvRatesMaster.DataBind();
		JavaScriptSerializer serializer = new JavaScriptSerializer();
        string strClientMaster = serializer.Serialize(lstRates);
        Session["lstrates"] = strClientMaster;
        //Session["lstgridrates"] = lstgridRates;


        hdnCurrent.Value = Convert.ToString(currentPageNo);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "CallGo", "fnLoadVendorType('Svr');fnloadRate('Svr');setAllValues();GetHdnValue();SetReadOnly();ChkUncheck();fnloadRateSubType('Cli');LoadDept(1);", true);
    }

    public List<FeeSplitSeriveDetails> GetSplitDetails()
    {
        List<FeeSplitSeriveDetails> lstSplAmount = new List<FeeSplitSeriveDetails>();
        FeeSplitSeriveDetails SplitAmount;
        string[] MainSplit = hdnTotalSplitFeeValue.Value.Split('$');

        for (int i = 0; i < MainSplit.Length - 1; i++)
        {
            string[] SelVal = MainSplit[i].Split('^');

            if (!string.IsNullOrEmpty(MainSplit[i]))
            {
                for (int j = 0; j < SelVal.Length - 1; j++)
                {

                    //document.getElementById(hdnvalue).value += SpcID + '~' + PhyID + '~' + "OPIP~" + FeeService + "~" + FeeAmount + '~' + FeeTypeAttriID + '^';
                    if (!string.IsNullOrEmpty(SelVal[j]))
                    {

                        string[] lsValue = SelVal[j].Split('~');
                        if (lsValue[2].Length == 4)
                        {
                            SplitAmount = new FeeSplitSeriveDetails();
                            SplitAmount = GetValue(SelVal[j], "OP");
                            lstSplAmount.Add(SplitAmount);
                            SplitAmount = new FeeSplitSeriveDetails();
                            SplitAmount = GetValue(SelVal[j], "IP");
                            lstSplAmount.Add(SplitAmount);
                        }
                        else
                        {
                            SplitAmount = new FeeSplitSeriveDetails();
                            SplitAmount = GetValue(SelVal[j], lsValue[2]);
                            lstSplAmount.Add(SplitAmount);

                        }

                    }
                }
            }
        }
        return lstSplAmount;
    }

    public FeeSplitSeriveDetails GetValue(string lsSplitValue, string lsType)
    {
        //document.getElementById(hdnvalue).value += SpecID + '~' + PhyID + '~' + "OPIP~" + FeeService + "~" + FeeAmount + '~' + FeeTypeAttriID + '^';

        FeeSplitSeriveDetails SplitAmount = new FeeSplitSeriveDetails();
        string[] lsValue = lsSplitValue.Split('~');
        SplitAmount.SpecID = Convert.ToInt64(lsValue[0]);
        SplitAmount.ID = Convert.ToInt64(lsValue[1]);
        SplitAmount.Type = lsType;
        SplitAmount.Amount = Convert.ToDecimal(lsValue[4]);
        SplitAmount.FeeTypeAttributesID = Convert.ToInt32(lsValue[5]);
        SplitAmount.RateId = Convert.ToInt64(lsValue[6]);
        SplitAmount.FeeID = Convert.ToInt64(lsValue[7]);
        SplitAmount.OrgID = OrgID;
        return SplitAmount;
    }




    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected void imgExportToExcel_Click(object sender, EventArgs e)
    {
        try
        {
            //if (base.OrgID == 69)
            //{
                int iValue = RateTypeID();
                long pRateID = 0;
                long RateRefID = 0;
                long ParentRefID = 0;
                string Code = "";
                string InvDeptID = "";
                string Rate = "";
                string[] RateDetails = hdnRateID.Value.Split('~');
                pRateID = Convert.ToInt32(RateDetails[1].ToString());
                RateRefID = Convert.ToInt64(RateDetails[2].ToString());
                ParentRefID = Convert.ToInt64(RateDetails[3].ToString());
                lstRates = new List<AdminInvestigationRate>();
                lstgridRates = new List<AdminInvestigationRate>();
                currentPageNo = Convert.ToInt32(hdnCurrent.Value);
                # region Added by Nalla
                //Include UnMapped Items not working while Search

                //if (chkunmapitems.Checked == true)
                //{
                //    ContextInfo.AdditionalInfo = "Y";
                //}
                //else
                //{
                //    ContextInfo.AdditionalInfo = "N";
                //}
                #endregion
                if (hdnDeparment.Value == "" || hdnDeparment.Value == null)
                {
                    InvDeptID = null;
                }
                else
                {
                    InvDeptID = hdnDeparment.Value;
                }
                if (ddlMappingItems.SelectedItem.Text == "Mapped Services") { ContextInfo.AdditionalInfo = "Y"; Rate = null; }
                else if (ddlMappingItems.SelectedItem.Text == "Un-Mapped Service") { ContextInfo.AdditionalInfo = "N"; Rate = null; }
                else if (ddlMappingItems.SelectedItem.Text == "Zero-Value services") { ContextInfo.AdditionalInfo = null; Rate = "0"; }
                else if (ddlMappingItems.SelectedItem.Text == "Zero-Value with mapped Services") { ContextInfo.AdditionalInfo = "Y"; Rate = "0"; }
                else if (ddlMappingItems.SelectedItem.Text == "Zero With Un-Mapped Services") { ContextInfo.AdditionalInfo = "N"; Rate = "0"; }
                else if (ddlMappingItems.SelectedIndex == 0) { ContextInfo.AdditionalInfo = "ALL"; Rate = null; }

                hdniValue.Value = Convert.ToString(iValue);
                new AdminReports_BL(base.ContextInfo).GetInvestigationRates(OrgID, iValue, pRateID, RateRefID, ParentRefID, Code,
                    out lstRates, out lstgridRates, currentPageNo, PageSize, "Excel", out PageCount,Rate, InvDeptID);


                ExportDelegate Exportmethod = new ExportDelegate(BulkToExcel);
                GridView ExportGRD = new GridView();
                ExportGRD.DataSource = lstRates;
                ExportGRD.DataBind();
                Exportmethod(ExportGRD);
                //gvRatesMaster.AllowPaging = false;
                //ExpotrGrd.Columns[16].Visible = false;

                //gvRatesMaster.AllowPaging = true;
                // ExpotrGrd.Columns[16].Visible = true;


            //}
            //else
            //{
            //    //currentPageNo = Int32.Parse(hdnCurrent.Value);
            //    //LoadGrid(currentPageNo, PageSize, "");
            //    gvRatesMaster.AllowPaging = false;
            //    gvRatesMaster.Columns[16].Visible = false;
            //    //ExportToExcel();
            //    ExportToExcel1();
            //    gvRatesMaster.AllowPaging = true;
            //    gvRatesMaster.Columns[16].Visible = true;
            //    //gvRatesMaster.DataSource = lstRates;
            //    //gvRatesMaster.DataBind();
            //}
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Excel Export", ex);
        }
    }

    //---------------Added by Baskaran  --------------

    public void BulkToExcel(GridView GvReportExcel)
    {
        //GridView GvReportExcel = new GridView();

        string attachment = "attachment; filename=" + ddlFeeType.SelectedValue + " - " + hdnRateName.Value + " - " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
        GvReportExcel.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();

    }


    //--------------End ------------------------------

    //public void ExportToExcel()
    //{
    //    //export to excel
    //    string attachment = "attachment; filename=" + ddlFeeType.SelectedValue + " - " + hdnRateName.Value + " - " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
    //    Response.ClearContent();
    //    Response.AddHeader("content-disposition", attachment);
    //    Response.ContentType = "application/ms-excel";
    //    Response.Charset = "";
    //    this.EnableViewState = false;
    //    System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
    //    System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
    //    gvRatesMaster.RenderControl(oHtmlTextWriter);
    //    Response.Write(oStringWriter.ToString());
    //    Response.End();

    //}
    public void ExportToExcel1()
    {
        string sVersion = string.Empty; 
        //lstgridRates = (List<AdminInvestigationRate>)Session["lstgridrates"];
        //lstgridRates = (List<AdminInvestigationRate>)Session["lstRates"];
		JavaScriptSerializer serializer = new JavaScriptSerializer();
		lstgridRates = serializer.Deserialize<List<AdminInvestigationRate>>(Convert.ToString(Session["lstRates"]));
        //string attachment = "attachment; filename=" + ddlFeeType.SelectedValue + " - " + hdnRateName.Value + " - " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
        System.Data.DataTable dt = ConvertToDatatable(lstgridRates);
        if (lstgridRates.Count > 0)
        {
            using (ExcelPackage pck = new ExcelPackage())
            {
                //Create the worksheet
                // pck.Workbook.Worksheets.Add("INV_Rates").Protection.IsProtected = true;
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("INV_Rates");
                var tbl = dt;
                //Load the datatable into the sheet, starting from cell A1. Print the column names on row 1

                ws.Cells["A1"].LoadFromDataTable(tbl, true);

                //Format the header for column 1-7
                using (ExcelRange rng = ws.Cells["A1:G1"])
                {
                    rng.Style.Font.Bold = true;
                    rng.Style.Fill.PatternType = ExcelFillStyle.Solid;                      //Set Pattern for the background to Solid
                    rng.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(79, 129, 189));  //Set color to dark blue
                    rng.Style.Font.Color.SetColor(Color.White);
                }

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    var validation = ws.DataValidations.AddDecimalValidation("B" + (i + 1));
                    validation.ShowErrorMessage = true;
                    validation.ErrorTitle = "Invalid value was entered";
                    validation.Error = "Value must be numeric value";
                    validation.PromptTitle = "Enter numeric value here";
                    validation.Prompt = "Value must be numeric value";
                    validation.ShowInputMessage = true;
                    // validation.Operator = ExcelDataValidationOperator.greaterThan;
                    validation.Formula.Value = 0;
                }

                ws.Column(7).Hidden = true;
                ws.Column(7).Width = 0;

                //ws.Column(7).Style.Hidden = true;
                for (int i = 0; i < dt.Rows.Count; i++)
                    ws.Cells["G" + (i + 1)].Style.Hidden = true;

                ws.Protection.IsProtected = true;
                ws.Column(2).Style.Locked = false;

                var dataRange = ws.Cells[ws.Dimension.Address.ToString()];
                dataRange.AutoFitColumns();
                HttpContext.Current.Response.Clear();
                //Write it back to the client
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment;  filename=" + ddlFeeType.SelectedValue + " - " + hdnRateName.Value + " - " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xlsx");
                HttpContext.Current.Response.BinaryWrite(pck.GetAsByteArray());
                //HttpContext.Current.ApplicationInstance.CompleteRequest();

                HttpContext.Current.Response.End();

                //Response.Clear();
                // //Write it back to the client
                // Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                //Response.AddHeader("content-disposition", "attachment;  filename=" + ddlFeeType.SelectedValue + " - " + hdnRateName.Value + " - " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xlsx");
                //Response.BinaryWrite(pck.GetAsByteArray());
                // //HttpContext.Current.ApplicationInstance.CompleteRequest();

                //  Response.End();
            }
        }
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        loadexcelfile();
    }
    public void loadexcelfile()
    {
        string connString = "";
        string strFileType = "";
        long returncode = -1;
        string uploadedFile=string.Empty;
        if (xlsUpload.HasFile)
        {

            string fleUpload = Path.GetExtension(xlsUpload.FileName.ToString());
            strFileType = fleUpload.Trim().ToLower();
            string filenameNoExtension = System.IO.Path.GetFileNameWithoutExtension(xlsUpload.FileName);
            string[] RateDetails = hdnRateID.Value.Split('~');
            long pRateID = Convert.ToInt32(RateDetails[1].ToString());
            int iValue = RateTypeID();

            if (strFileType == ".xls" | strFileType == ".xlsx")
            {
                xlsUpload.SaveAs(Server.MapPath("" + xlsUpload.FileName.ToString()));
               uploadedFile = (Server.MapPath("" + xlsUpload.FileName.ToString()));

                try
                {
                    //Connection String to Excel Workbook
                    if (strFileType.Trim() == ".xls")
                    {
                        connString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + uploadedFile + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                    }
                    else if (strFileType.Trim() == ".xlsx")
                    {
                        connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + uploadedFile + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                    }

                    string testratemaster = "SELECT * FROM [INV_Rates$]";
                    OleDbConnection conn = new OleDbConnection(connString);
                    if (conn.State == ConnectionState.Closed)
                        conn.Open();
                    OleDbCommand cmdratetest = new OleDbCommand(testratemaster, conn);
                    OleDbDataAdapter daratetest = new OleDbDataAdapter(cmdratetest);
                    DataTable dtpratetest = new DataTable();
                    daratetest.Fill(dtpratetest);

                    conn.Close();
                    conn.Dispose();
                    ContextInfo.AdditionalInfo = Convert.ToString(iValue);
                    AdminReports_BL ratesUpload = new AdminReports_BL(base.ContextInfo);
                    returncode = ratesUpload.SaveratesDetails(dtpratetest, pRateID);

                }
                catch (Exception)
                {
                    string strError = Resources.Admin_ClientDisplay.Admin_RatesUpdation_aspx_03 == null ? "Error in file upload" : Resources.Admin_ClientDisplay.Admin_RatesUpdation_aspx_03;

                   //lbl_ErrorMessage.Text = "Error in file upload";
                    lbl_ErrorMessage.Text = strError;

                }

            }

            if (returncode == -1)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alrUpdateNotSuccessful", "javascript:ValidationWindow('" + strNotUpdate + "','" + strAlert + "');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alrUpdateNotSuccessful", "javascript:ValidationWindow('" + strUpdate + "','" + strAlert + "');", true);
                LoadGrid(currentPageNo, PageSize, "");
                Panel1.Visible = false;
                if(System.IO.File.Exists(uploadedFile))
                    System.IO.File.Delete(uploadedFile);
            }
        }
    }
    public static DataTable ConvertToDatatable(List<AdminInvestigationRate> lstrates)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Description_Name");
        dt.Columns.Add("Amount_For_OP");
        dt.Columns.Add("Processed_Type");
        dt.Columns.Add("Discount_Category");
        dt.Columns.Add("CPT_Rate");
        dt.Columns.Add("CPRT _Rate");
        dt.Columns.Add("RateTypeID");
        if (lstrates.Count > 0)
        {
            foreach (var item in lstrates)
            {
                dt.Rows.Add(item.DescriptionName, item.Amount, item.SubCategoryType, item.DiscountCategory, item.CptAmount, item.CprtAmount, item.RateTypeId);
            }
        }
        return dt;
    }
    protected void btnRemove_Click(object sender, EventArgs e)
    {

        long returnCode = -1;
        string removedNames = string.Empty;
      //  ErrorDisplay1.ShowError = false;
        List<AdminInvestigationRate> lstRates = new List<AdminInvestigationRate>();
        lstRates = GetInvRateDetails();
        List<FeeSplitSeriveDetails> lstSplitDetails = new List<FeeSplitSeriveDetails>();

        if (!string.IsNullOrEmpty(hdnTotalSplitFeeValue.Value))
        {
            lstSplitDetails = GetSplitDetails();
        }

        //if (hdniValue.Value == "7")
        //{
        //    lstRates = GetSPKGRateDetails();
        //}
        //else
        //{
        //    lstRates = GetInvRateDetails();
        //}
        AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
        if (hdnStatus.Value == "Changed")
        {
            if (lstRates.Count > 0)
            {
                int iValue = 0;
                iValue = RateTypeID();
                long RateRefID = -1;
                long ParentID = -1;
                string Code = string.Empty;
                string[] RateID = hdnRateID.Value.Split('~');
                int iRateID = Convert.ToInt32(RateID[1].ToString());
                RateRefID = Convert.ToInt64(RateID[2].ToString());
                ParentID = Convert.ToInt64(RateID[3].ToString());
                //int iClientId = Convert.ToInt32(ddlClientName.SelectedValue);

                if (iRateID != 0)
                {
                    returnCode = objBl.RemoveInvestigationRate(lstRates, iValue, iRateID, OrgID, lstSplitDetails);
                }


            }

        }


        currentPageNo = 1;
        hdnCurrent.Value = "1";
        LoadGrid(currentPageNo, PageSize, "");
        hdnSearch.Value = "";
        txtsearch.Text = "";
        txtpageNo.Text = "";
        hdnSelect.Value = "";
        hdnStatus.Value = "";
        hdnTotalSplitFeeValue.Value = "";
        if (returnCode == 0)
        {
            string sPath = "Admin\\RatesUpdation.aspx.cs_10";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg('" + sPath + "')", true);

        }
        else
        {
            string sPath = "Admin\\RatesUpdation.aspx.cs_14";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg('" + sPath + "')", true);
        }
        //if (ContextInfo.AdditionalInfo == "Y")
        //{
        //    chkunmapitems.Checked = true;
        //}
        //else if (ContextInfo.AdditionalInfo == "N")
        //{
        //    chkunmapitems.Checked = false;
        //}

        hdnConfirmNames.Value = string.Empty;

    }

    [WebMethod]
    public static String RemoveDocDetails(string searchtext, string type)
    {
        try
        {
            {
                DirectoryInfo diSource = new DirectoryInfo(FilePath);

                foreach (FileInfo file in diSource.GetFiles(@"*.*"))
                {
                    string FileName = file.Name.Trim();
                    string FileNameExt = Path.GetFileNameWithoutExtension(FileName);
                    if (FileNameExt == searchtext)
                    {
                        System.IO.File.Delete(file.FullName);

                    }
                }
            }

            return "";
        }
        catch (Exception ex)
        { throw ex; }
    }


    [WebMethod(EnableSession = true)]
    public static long SaveTypeDetails(string lstInvestigationDetail,String UpdateDate,String Reason)
    {
        try
        {
            long Returncode = -1;
            Deployability_BL objMetaData_BL = new Deployability_BL(new BaseClass().ContextInfo);
            List<FileUploadDetails> lstInvestigationDetails = new JavaScriptSerializer().Deserialize<List<FileUploadDetails>>(lstInvestigationDetail);
            Returncode = objMetaData_BL.InsertDocData(lstInvestigationDetails, Convert.ToDateTime(UpdateDate), Reason);
            return Returncode;

        }
        catch (Exception ex)
        {
            return 1;
        }
    }



    [WebMethod]
    public static string GetUploadDocDetails(int FileDetails)
    {
        long returnvalue = -1;
        List<FileUploadDetails> lstUploadDocDetail = new List<FileUploadDetails>();
        Deployability_BL objMetaData_BL = new Deployability_BL(new BaseClass().ContextInfo);
        returnvalue = objMetaData_BL.GetUploadDocDetail(FileDetails, out lstUploadDocDetail);
        JavaScriptSerializer js = new JavaScriptSerializer();
        string strout = js.Serialize(lstUploadDocDetail);
        return strout;


    }

    [WebMethod]
    public static List<InvDeptMaster> GetDepartment(int OrgId)
    {
        PatientVisit_BL ObjPatVisit = new PatientVisit_BL(new BaseClass().ContextInfo);
        List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
        List<InvDeptMaster> lstDeptMaster = new List<InvDeptMaster>();
        try
        {
            ObjPatVisit.GetDepartment(OrgId, 0, 0, out lstInvDeptMaster, out lstDeptMaster);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in load Departments", ex);
        }
        return lstInvDeptMaster;

    }

    [WebMethod]
    public static String GetCopyFromRateName(int OrgId, string RateType,String txtSearchName)
    {
        JavaScriptSerializer js = new JavaScriptSerializer();
        List<PageContextkey> lstRateTypes = new List<PageContextkey>();
        try
        {
            new AdminReports_BL(new BaseClass().ContextInfo).pGetRateTypeMasters(OrgId, out lstRateTypes);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in load Departments", ex);
        }
        if (txtSearchName=="%")
        {
            var query = from c in lstRateTypes
                        where c.ActionType == RateType
                        select c;

            return js.Serialize(query);
        }
        else
        {
            var lstRateTypes1 = from FilterLst in lstRateTypes
                                where FilterLst.ActionType == RateType && FilterLst.ButtonName.ToLower().Contains(txtSearchName.ToLower().Replace("%","").Trim())
                                select FilterLst;
            return js.Serialize(lstRateTypes1);
        }
       
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string UploadData()
    {
        //get reference to posted file and do what you want with this file
        HttpPostedFile postedfile =  HttpContext.Current.Request.Files.Get(0) as HttpPostedFile;
        return "";
    }
}