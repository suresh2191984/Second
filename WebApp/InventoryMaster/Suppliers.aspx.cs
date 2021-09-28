using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.InventoryMaster.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Common;
using System.Linq;
using System.Drawing;


public partial class Inventory_Suppliers : Attune_BasePage
{
    public Inventory_Suppliers()
        : base("InventoryMaster_Suppliers_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryMaster_BL inventoryBL;
    Suppliers objSuppliers = new Suppliers();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    string SupplierNameSrch, TinNumberSrch;
    
    int CodeID=0;
    Attune_IPatientAddress ucPAdd;
    Attune_IPatientAddress ucCAdd;

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            inventoryBL = new InventoryMaster_BL(base.ContextInfo);
            excel.Visible = false;
            string sPath = "";
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Is_Supplier_TIN_No_Mandatory", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue != null && lstInventoryConfig[0].ConfigValue != "")
                {
                    hdnTinMandatory.Value = lstInventoryConfig[0].ConfigValue;
                    tinMandatory.Visible = false;
                }
                else
                {
                    hdnTinMandatory.Value = "N";
                }
            }
            else
            {
                hdnTinMandatory.Value = "N";
            }
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("SupplierRename", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                hdnSupplierNaming.Value = lstInventoryConfig[0].ConfigValue;
                if (hdnSupplierNaming.Value == "Y")
                {
                    sPath = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_17 == null ? "Inactivate Supplier" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_17;
                    chkDelete.Text = sPath;
                }
            }
            if (!IsPostBack)
            {
                if (isCorporateOrg == "Y")
                
                    tdAddrSame.Attributes.Add("class", "hide");
              
                // chkDelete.Visible = false;
                txtEmailID.Attributes.Add("onblur", "javascript:checkMailId();");

                txtContactPerson.Attributes.Add("onkeypress", "return ValidateAlphabets(event);");
                //txtSupplierName.Attributes.Add("onkeypress", "return ValidateSpecialAndNumeric(event);");
                txtFaxNumber.Attributes.Add("onkeypress", "return validatenumber(event);");
                //Tax Column hiding for Vasan
                string TAX_COLUMNHIDE = GetConfigValue("IsMiddleEast", OrgID);
                TAX_COLUMNHIDE = !string.IsNullOrEmpty(TAX_COLUMNHIDE) ? TAX_COLUMNHIDE : "N";
                if (TAX_COLUMNHIDE == "Y")
                {
                    tdlblServiceTaxNo.Attributes.Add("class", "hide");
                    tdtxtServiceTaxNo.Attributes.Add("class", "hide");
                    tdlblCstNo.Attributes.Add("class", "hide");
                    tdtxtCstNo.Attributes.Add("class", "hide");
                    gvSupplier.Columns[5].Visible = false;
                    gvSupplier.Columns[8].Visible = false;
                }
                //Tax Column hiding for Vasan--end
                /*MandatFieldDisable-Sathish*/
                string MandFieldRemove = GetConfigValue("IsMandatoryFieldRequired", OrgID);
                if (MandFieldRemove == "Y")
                {
                    hdnMandFieldDisable.Value = "N";
                    imgContactperson.Attributes.Add("class", "hide");
                }
            }
            fckInvDetailss.EnableToolbars = true;
            fckInvDetailss.EnableHtmlMode = true;
            fckInvDetailss.ToolbarBackgroundImage = true;
            fckInvDetailss.ToolbarBackColor = Color.Gray;
            fckInvDetailss.UseToolbarBackGroundImage = true;
            fckInvDetailss.ToolbarLayout = "";
            fckInvDetailss.ToolbarStyleConfiguration = FreeTextBoxControls.ToolbarStyleConfiguration.NotSet;
            fckInvDetailss.AutoGenerateToolbarsFromString = true;
           /*  sPath = Request.Url.AbsolutePath;
            int iIndex = sPath.LastIndexOf("/");

            sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
            sPath = Request.ApplicationPath;
            sPath = sPath + "/fckeditor/";
           fckInvDetailss.BasePath = sPath;
            fckInvDetailss.ToolbarSet = "Attune";
            fckInvDetailss.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            fckInvDetailss.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";*/
           
            #region Load Address Control dynamically
            Control objPAdd = new Control();
            ucPAdd = Attune_WebAppUtilities.GetPatientAddressCtrl(ref objPAdd, OrgID);
            objPAdd.ID = "ucPAdd";
            ucPAdd.Title = "1";
            ucPAdd.SetColumnWidths(20, 33, 15, 32);
            ucPAdd.AddressType = Attune_eAddType.PERMANENT;
            dvucPAdd.Controls.Add(objPAdd);


            //Control objCAdd = new Control();
            //ucCAdd = Attune_WebAppUtilities.GetPatientAddressCtrl(ref objCAdd, OrgID);
            //objCAdd.ID = "ucCAdd";
            //ucCAdd.Title = "2";
            //ucCAdd.SetColumnWidths(20, 33, 15, 32);
            //ucCAdd.AddressType = Attune_eAddType.CURRENT;
            //dvucCAdd.Controls.Add(objCAdd);
            #endregion
            // ((TextBox)Page.FindControl("ucPAdd").FindControl("txtAddress1")).Attributes.Add("onkeyup", "IsAlpha(this);");   //Commented by Mani
            //((TextBox)Page.FindControl("ucCAdd").FindControl("txtAddress1")).Attributes.Add("onkeyup", "IsAlpha(this);");

            SetTabIndex();
            #region
            /*Sathish-Mobile No Validation*/
            LoadCountry(CodeID);
            #endregion
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - Suppliers.aspx", ex);
          //  ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    public void LoadCountry(int CodeID)
    {
        long returnCode = -1;
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
        List<Localities> lstLocalities = new List<Localities>();
        List<InvestigationMaster> i = new List<InvestigationMaster>();
        List<State> states = new List<State>();
        State_BL stateBL = new State_BL(base.ContextInfo);
        Country selectedCountry = new Country();

        try
        {
            returnCode = countryBL.GetCountryList(out countries);

            returnCode = countryBL.GetLocalities(CodeID, out lstLocalities);


            
            if (CountryID > 0)
            {
                var childItems = (from n in countries 
                                  where n.CountryID == CountryID
                                  select new { n.CountryCode, n.PhoneNo_Length }).ToList();
                if (childItems.Count > 0)
                {
                    long CountryCode = childItems[0].CountryCode;
                    int PhLength = childItems[0].PhoneNo_Length;
                    hdnPhLength.Value = PhLength.ToString();
                    txtMobileNumber.Attributes.Add("MaxLength", PhLength.ToString());
                }
                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Country", ex);
        }
        finally
        {
        }
    }
    public void LoadSuppliersList()
    {
        try
        {
            SupplierNameSrch = txtSupplierNameSrch.Text.Trim();
            TinNumberSrch = txtTinNumberSrch.Text.Trim();
            inventoryBL.GetAllSuppliersDetails(OrgID, ILocationID, SupplierNameSrch, TinNumberSrch, out lstSuppliers);
            if (lstSuppliers != null && lstSuppliers.Count > 0)
            {
                chkDelete.Visible = true;
                excel.Visible = true;
                gvSupplier.DataSource = lstSuppliers;
                if (isCorporateOrg == "Y")
                    gvSupplier.Columns[15].Visible = false;
                gvSupplier.DataBind();
                tblSupplierContainer.Attributes.Add("class", "w-100p");
            }
            else
            {
                tblSupplierContainer.Attributes.Add("class", "hide");
                gvSupplier.DataSource = null;
                gvSupplier.DataBind();
                  string sPath =  Resources.InventoryMaster_AppMsg.InventoryMaster_Suppliers_aspx_19==null?"":Resources.InventoryMaster_AppMsg.InventoryMaster_Suppliers_aspx_19;
                  string ErrorMsg = Resources.InventoryMaster_AppMsg.InventoryMaster_Error == null ? "Error" : Resources.InventoryMaster_AppMsg.InventoryMaster_Error;
                //string sPath = "Inventory\\\\Suppliers.aspx.cs_20";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('No matching record found');", true);
                  ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "');", true);
                excel.Visible = false;
            }
            txtSupplierName.Focus();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Load - Suppliers.aspx", ex);
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void gvSupplier_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        
        if (e.NewPageIndex != -1)
        {
            gvSupplier.PageIndex = e.NewPageIndex;
            LoadSuppliersList();
            txtAddress1.Text = "";
            txtAddress2.Text = "";
            txtCity.Text = "";
            txtContactPerson.Text = "";
            txtEmailID.Text = "";
            txtMobileNumber.Text = "";
            txtPhoneNumber.Text = "";
            txtSupplierName.Text = "";
            txtFaxNumber.Text = "";
            fckInvDetailss.Text = "";
            //txtTermsConditions.Text = "";
            txtCstNo.Text = "";
            txtDrugLicenceNo.Text = "";
            txtPanNo.Text = "";
            txtServiceTaxNo.Text = "";
            txtDrugLicenceNo1.Text = "";
            txtDrugLicenceNo2.Text = "";
            txtSupplierCode.Text = "";
            txtPin.Text = "";
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            var userMsg = "";
            long returnCode = -1;
            objSuppliers.SupplierName = txtSupplierName.Text.Trim();
            objSuppliers.Address1 = txtAddress1.Text.Trim();
            objSuppliers.Address2 = txtAddress2.Text.Trim();
            objSuppliers.City = txtCity.Text.Trim();
            objSuppliers.Phone = txtPhoneNumber.Text.Trim();
            objSuppliers.Mobile = txtMobileNumber.Text.Trim();
            objSuppliers.OrgID = OrgID;
            objSuppliers.CreatedBy = LID;
            objSuppliers.ContactPerson = txtContactPerson.Text.Trim();
            objSuppliers.EmailID = txtEmailID.Text.Trim();
            objSuppliers.SupplierID = int.Parse(hdnId.Value);
            objSuppliers.OrgAddressID = ILocationID;
            objSuppliers.TinNo = txtTinNo.Text.Trim();
            objSuppliers.GSTIN = txtGSTINNo.Text.Trim();//Vijayaraja
            objSuppliers.FaxNumber = txtFaxNumber.Text.Trim();

            if (!string.IsNullOrEmpty(fckInvDetailss.Text))
            {
                string str = fckInvDetailss.Text;
                objSuppliers.Termsconditions = Server.HtmlEncode(str);
            }
            //if (!string.IsNullOrEmpty(txtTermsConditions.Text.Trim()))
            //{
            //    objSuppliers.Termsconditions = replace(txtTermsConditions.Text.Trim());
            //}
            objSuppliers.IsDeleted = "N";
            if (chkDelete.Checked == true)
            {
                objSuppliers.IsDeleted = "Y";
            }
            objSuppliers.CstNo = txtCstNo.Text.Trim();
            objSuppliers.DrugLicenceNo = txtDrugLicenceNo.Text.Trim();
            objSuppliers.PanNo = txtPanNo.Text.Trim();
            objSuppliers.ServiceTaxNo = txtServiceTaxNo.Text.Trim();
            objSuppliers.DrugLicenceNo1 = txtDrugLicenceNo1.Text.Trim();
            objSuppliers.DrugLicenceNo2 = txtDrugLicenceNo2.Text.Trim();
            objSuppliers.SupplierCode = txtSupplierCode.Text.Trim();
            objSuppliers.PIN = txtPin.Text.Trim();

            List<PatientAddress> lstPatientAddress = new List<PatientAddress>();
            PatientAddress pAddresses = new PatientAddress();
            PatientAddress pAddr = new PatientAddress();
            PatientAddress cAddresses = new PatientAddress();

            pAddr = ucPAdd.GetPAddress();
            pAddr.AddressType = "P";
            pAddresses = pAddr;

            if (chkAddrSame.Checked)
            {
                PatientAddress objPatientAddress = new PatientAddress();
                objPatientAddress = ucPAdd.GetPAddress();
                objPatientAddress.AddressType = "C";
                cAddresses = objPatientAddress;
            }
            else
            {
                PatientAddress objPatientAddress = new PatientAddress();
                objPatientAddress = ucCAdd.GetPAddress();
                objPatientAddress.AddressType = "C";
                cAddresses = objPatientAddress;
            }
            lstPatientAddress.Add(pAddresses);
            lstPatientAddress.Add(cAddresses);

            returnCode = inventoryBL.SaveSuppliers(objSuppliers, lstPatientAddress);
            if (returnCode == 0)
            {
                SupplierNameSrch = txtSupplierNameSrch.Text.Trim();
                TinNumberSrch = txtTinNumberSrch.Text.Trim();
                inventoryBL.GetAllSuppliersDetails(OrgID, ILocationID, SupplierNameSrch, TinNumberSrch, out lstSuppliers);
                gvSupplier.DataSource = lstSuppliers;
                gvSupplier.DataBind();
                txtAddress2.Text = "";
                txtContactPerson.Text = "";
                txtEmailID.Text = "";
                txtMobileNumber.Text = "";
                txtPhoneNumber.Text = "";
                txtFaxNumber.Text = "";
                txtSupplierName.Text = "";
                txtTinNo.Text = "";
                txtGSTINNo.Text = "";//Vijayaraja
                hdnId.Value = "0";

                fckInvDetailss.Text = "";
                //txtTermsConditions.Text = "";
                txtCstNo.Text = "";
                txtDrugLicenceNo.Text = "";
                txtPanNo.Text = "";
                txtServiceTaxNo.Text = "";
                txtDrugLicenceNo1.Text = "";
                txtDrugLicenceNo2.Text = "";
                txtSupplierCode.Text = "";
                txtPin.Text = "";

                chkDelete.Checked = false;

                if (hdnStatus.Value == "Delete")
                {
                    string userMsg1 = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_18 == null ? "Supplier Deleted sucessfully" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_18;
                    userMsg = userMsg1;
                }

                else if (hdnStatus.Value == "Update")
                {
                     string userMsg2 = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_19 == null ? "Supplier Updated sucessfully" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_19;
                     userMsg = userMsg2;
                }
                else
                {
                    string userMsg3 = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_20 == null ? "Supplier Added sucessfully" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_20;
                    userMsg = userMsg3;
                }
                hdnStatus.Value = "";
                string ErrorMsg = Resources.InventoryMaster_AppMsg.InventoryMaster_Information == null ? "Information" : Resources.InventoryMaster_AppMsg.InventoryMaster_Information;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "SaveAlert", "javascript:HideADD();SuccessAlert('" + userMsg + "','" + ErrorMsg + "');", true);
            }
            else
            {
                if (hdnStatus.Value == "Delete")
                {
                    string userMsg4 = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_21 == null ? "Supplier Deleted Failed" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_21;
                    userMsg = userMsg4;

                }
                if (hdnStatus.Value == "Update")
                {
                    string userMsg5 = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_22 == null ? "Supplier Updated Failed" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_22;
                    userMsg = userMsg5;

                }
                else
                {
                    string userMsg6 = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_23 == null ? "Supplier Added Failed" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_23;
                    userMsg = userMsg6;
                    txtAddress1.Text = "";
                    txtAddress2.Text = "";
                    txtCity.Text = "";
                    txtContactPerson.Text = "";
                    txtEmailID.Text = "";
                    txtMobileNumber.Text = "";
                    txtPhoneNumber.Text = "";
                    txtFaxNumber.Text = "";
                    txtSupplierName.Text = "";
                    txtTinNo.Text = "";
                    txtGSTINNo.Text = "";//Vijayaraj

                    fckInvDetailss.Text = "";
                    //txtTermsConditions.Text = "";
                    txtCstNo.Text = "";
                    txtDrugLicenceNo.Text = "";
                    txtPanNo.Text = "";
                    txtServiceTaxNo.Text = "";
                    txtDrugLicenceNo1.Text = "";
                    txtDrugLicenceNo2.Text = "";
                    txtSupplierCode.Text = "";
                    txtPin.Text = "";
                    chkDelete.Checked = false;

                }
                string ErrorMsg = Resources.InventoryMaster_AppMsg.InventoryMaster_Error == null ? "Error" : Resources.InventoryMaster_AppMsg.InventoryMaster_Error;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "FailAlert", "javascript:HideADD();ValidationWindow('" + userMsg + "','" + ErrorMsg + "');", true);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving Suppliers - Suppliers.aspx", ex);
           // ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Attune_Navigation navigation = new Attune_Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    protected void btnSearch_Click1(object sender, EventArgs e)
    {
        try
        {
            LoadSuppliersList();

            txtAddress1.Text = "";
            txtAddress2.Text = "";
            txtCity.Text = "";
            txtContactPerson.Text = "";
            txtEmailID.Text = "";
            txtMobileNumber.Text = "";
            txtPhoneNumber.Text = "";
            txtSupplierName.Text = "";
            txtTinNo.Text = "";
            txtGSTINNo.Text = "";//Vijayaraja
            txtFaxNumber.Text = "";
            //txtSupplierNameSrch.Text = "";
            //txtTinNumberSrch.Text = "";
            fckInvDetailss.Text = "";
            //txtTermsConditions.Text = "";
            txtCstNo.Text = "";
            txtDrugLicenceNo.Text = "";
            txtPanNo.Text = "";
            txtServiceTaxNo.Text = "";
            txtDrugLicenceNo1.Text = "";
            txtDrugLicenceNo2.Text = "";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:HideADD();", true);//SetUIAlign();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Search Suppliers - Suppliers.aspx", ex);
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }
    protected void btn_export_Click(object sender, EventArgs e)
    {
        gvSupplier.Columns[0].Visible = false;
        gvSupplier.AllowPaging = false;
        LoadSuppliersList();

        ExportToExcel();
        gvSupplier.AllowPaging = true;
        gvSupplier.DataSource = lstSuppliers;
        gvSupplier.DataBind();


    }




    protected void PrintReport_Click(object sender, EventArgs e)
    {


        gvSupplier.Columns[0].Visible = false;

        //gvSupplier.AllowPaging = false;
        //LoadSuppliersList();

        //gvSupplier.AllowPaging = true;

        //gvSupplier.DataSource = lstSuppliers;

        //gvSupplier.DataBind();



    }



    public void ExportToExcel()
    {
        //export to excel
        string prefix = string.Empty;
        prefix = "SupplierList";

        string rptDate = prefix + DateTimeNow.ToShortDateString();
        string attachment = "attachment; filename=" + rptDate + ".xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;

        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
        gvSupplier.RenderControl(oHtmlTextWriter);

        Response.Write(oStringWriter.ToString());

        Response.End();


    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    List<PatientAddress> lstPatientAddress;
    protected void gvSupplier_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
            Int32 SupplierID = Convert.ToInt32(gvSupplier.DataKeys[rowIndex]["SupplierID"]);

            HiddenField StateCode = (HiddenField)gvSupplier.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnStateCode");
            HiddenField CountryCode = (HiddenField)gvSupplier.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnCountryCode");

            if (e.CommandName == "History")
            {
                audit_History.ViewAudit_History(SupplierID, OrgID, "SPLRSRCH");
                ModelPopSupplierSearch.Show();
            }
            long returnCode = -1;
            Utilities objUt = new Utilities();
            List<Localities> lstLocalities = new List<Localities>();
            Country_BL countryBL = new Country_BL(base.ContextInfo);
            string Select = objUt.GetDefaultEntryForDropDownControl("Defaults", "Select");

            //DropDownList ddState = (DropDownList)ucPAdd.FindControl("ddState");
            
            
            returnCode = countryBL.GetLocalities(int.Parse(CountryCode.Value), out lstLocalities);
            //ddState.DataSource = lstLocalities;
            //ddState.DataTextField = "Locality_Value";
            //ddState.DataValueField = "Locality_ID";
            //ddState.DataBind();
            //ddState.Items.Insert(0, Select);
            //ddState.SelectedValue = int.Parse(StateCode.Value).ToString();
            PatientAddress objAddress=new PatientAddress();
            objAddress.StateID=Int64.Parse(StateCode.Value);
            objAddress.CountryID = Int64.Parse(CountryCode.Value);
            ucPAdd.SetAddress(objAddress);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Editing Supplier History.", ex);
           // ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    private void SetTabIndex()
    {
        short tabIndex = 1;
        txtSupplierName.TabIndex = tabIndex++;
        txtTinNo.TabIndex = tabIndex++;
        txtCstNo.TabIndex = tabIndex++;
        txtDrugLicenceNo.TabIndex = tabIndex++;
        txtDrugLicenceNo1.TabIndex = tabIndex++;
        txtDrugLicenceNo2.TabIndex = tabIndex++;
        txtServiceTaxNo.TabIndex = tabIndex++;
        txtPanNo.TabIndex = tabIndex++;
        txtContactPerson.TabIndex = tabIndex++;
        txtEmailID.TabIndex = tabIndex++;

        txtPhoneNumber.TabIndex = tabIndex++;
        txtMobileNumber.TabIndex = tabIndex++;
        txtFaxNumber.TabIndex = tabIndex++;

        txtSupplierCode.TabIndex = tabIndex++;
        txtPin.TabIndex = tabIndex++;

        // patient address
        ucPAdd.SetTabIndex(ref tabIndex);
        ucCAdd.SetTabIndex(ref tabIndex);
        //TextBox txtAddress2 = (TextBox)ucPAdd.FindControl("txtAddress2");
        //txtAddress2.TabIndex = tabIndex++;
        //TextBox txtAddress1 = (TextBox)ucPAdd.FindControl("txtAddress1");
        //txtAddress1.TabIndex = tabIndex++;
        //TextBox txtAddress3 = (TextBox)ucPAdd.FindControl("txtAddress3");
        //txtAddress3.TabIndex = tabIndex++;
        //DropDownList ddCountry = (DropDownList)ucPAdd.FindControl("ddCountry");
        //ddCountry.TabIndex = tabIndex++;
        //DropDownList ddState = (DropDownList)ucPAdd.FindControl("ddState");
        //ddState.TabIndex = tabIndex++;
        //DropDownList ddlCity = (DropDownList)ucPAdd.FindControl("ddlCity");
        //ddlCity.TabIndex = tabIndex++;
        //DropDownList ddlDistricts = (DropDownList)ucPAdd.FindControl("ddlDistricts");
        //ddlDistricts.TabIndex = tabIndex++;
        //DropDownList ddllocalities = (DropDownList)ucPAdd.FindControl("ddllocalities");
        //ddllocalities.TabIndex = tabIndex++;
        //TextBox txtPostalCode = (TextBox)ucPAdd.FindControl("txtPostalCode");
        //txtPostalCode.TabIndex = tabIndex++;
        //TextBox txtMobile = (TextBox)ucPAdd.FindControl("txtMobile");
        //txtMobile.TabIndex = tabIndex++;
        //TextBox txtLandLine = (TextBox)ucPAdd.FindControl("txtLandLine");
        //txtLandLine.TabIndex = tabIndex++;
        //btnFinish.TabIndex = tabIndex++;
    }

    public string replace(string s)
    {
        String noHTML = Regex.Replace(s, @"<[^>]+>|&nbsp;", "").Trim();
        String result = Regex.Replace(noHTML, @"\s{2,}", " ");
        return result;
    }
    protected void gvSupplier_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int Rowindex = e.Row.RowIndex;
            if (lstSuppliers[Rowindex].IsDeleted.Trim() == "N")
                e.Row.Cells[14].Text = "Y";
            else
                e.Row.Cells[14].Text = "N";
        }
    }
}
