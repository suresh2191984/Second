using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using System.Collections.Generic;
using System.Linq;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.Quotation.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.Quotation;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PerformingNextAction;

public partial class Quotation_ProductSupplierRateMapping : Attune_BasePage
{
    public Quotation_ProductSupplierRateMapping()
        : base("Quotation_ProductSupplierRateMapping_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    string displayTool = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Selling_Price_Rule_ProductType", OrgID, ILocationID, out lstInventoryConfig);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSrd", "javascript:SetDatePickterValue();", true);
        displayTool = Resources.Quotation_ClientDisplay.Quotation_ProductSupplierRateMapping_aspx_24;
        displayTool = displayTool == null ? "Approve" : displayTool;
        if (lstInventoryConfig.Count > 0)
        {
            hdnIsSellingPriceTypeRuleApply.Value = lstInventoryConfig[0].ConfigValue;

        }
        if (isCorporateOrg != "Y")
        {
            txtTax.Attributes.Add("ReadOnly", "ReadOnly");
			txtMRP.Attributes.Add("ReadOnly", "ReadOnly");
        }
        if (!IsPostBack)
        {
            // Theme1.Visible = false;
            hdnSupID.Value = "0";
            hdnQuotID.Value = "0";
            //chkActive.Style.Add("display", "none");
            chkActive.Attributes.Add("class", "hide");
            //  tdShowHide.Style.Add("display", "none");
            if (Request.QueryString["CPage"] != null && Request.QueryString["CPage"] == "Y")
            {
                //header.Visible = false;
                //MainHeader.Visible = false;
                //LeftMenu1.Visible = false;
                //showmenu.Visible = false;
                //ReceptionHeader.Visible = false;
                //Footer1.Visible = false;
                //Theme1.Visible = true;
                //tbTopHeader1.Visible = false;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "IsDefault", "Showmenu();", true);
                //HiddenField Productscontrol = (HiddenField)PreviousPage.FindControl("hdnproductsdata");
                //lblProducts.Text = Productscontrol.Value;
            }
            LoadSupplierList();
            LoadUnit();
            LoadConfigDetail();
            string str = RoleName;
            str = str=="InventoryAdmin" ?RoleHelper.Admin :str;
            if (str == RoleHelper.Admin)
            {
                hdnAdmin.Value = RoleHelper.Admin;
                btnSave.Text = displayTool;
                //btnClose.Visible = true;
                btnReject.Visible = true;
                chkActive.Attributes.Add("class", "show");
                //chkActive.Style.Add("display", "block");
            }
            if (Request.QueryString["SupplierID"] != "0" && Request.QueryString["SupplierID"] != null)
            {
                GetApprovedItems();
                btnSave.Text = displayTool;
                //btnClose.Visible = true;
                btnReject.Visible = true;
                hdnChkFlag.Value = "1";
                hdnQuotationID.Value = Request.QueryString["QuotationID"];
                tdShowHide.Attributes.Add("class", "displaytd");
                //tdShowHide.Style.Add("display", "block");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "showResponses", "showResponses('ACX2OPPmt1', 'ACX2minusOPPmt1', 'ACX2responses4', 0);", true);
            }

            //List<InventoryConfig> lstInventoryConfig1 = new List<InventoryConfig>();
            //new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("EnablePackSize", OrgID, ILocationID, out lstInventoryConfig1);
            //hdnOrdConfig.Value = "N";
            //if (lstInventoryConfig1.Count > 0)
            //{
            //    hdnOrdConfig.Value = lstInventoryConfig1[0].ConfigValue;
            //    //if (hdnOrdConfig.Value == "Y")
            //    //{
            //    //    //imgord.Attributes.Add("class", "a-center");
            //    //    //imgrange.Attributes.Add("class", "a-center");

            //    //}
            //}

            if (Request.QueryString["QID"] != "0" && Request.QueryString["QNO"] != null && Request.QueryString["SID"] != null)
            {

                hdnConfig.Value = "N";
                btnSave.Text = displayTool;
                //btnClose.Visible = true;
                btnReject.Visible = true;

                long QuotationID = -1;
                long returnCode = -1;
                long SupID = -1;
                int ProductID = 0;
                string QuatationNo = Request.QueryString["QNO"].ToString();

                string SID = Request.QueryString["SID"].ToString();
                SupID = Convert.ToInt64(SID);
                ddlsearchsupplier.SelectedValue = SID;
                txtsearchquotation.Text = QuatationNo;
                QuotationID = Convert.ToInt64(Request.QueryString["QID"].ToString());

                txtQuotationNo.Text = QuatationNo;
                DropSupplierName.SelectedValue = SID;

                List<QuotationMaster> lstQuotationMaster = new List<QuotationMaster>();

                Quotation_BL InventoryBL = new Quotation_BL(base.ContextInfo);

                lstQuotationMaster.Clear();
                returnCode = InventoryBL.GetQuotationDetails(OrgID, SupID, QuotationID, QuatationNo,ProductID, out lstQuotationMaster);


                hdnApproved.Value = lstQuotationMaster[0].Status;

                txtQuotationNo.Text = lstQuotationMaster[0].QuotationNo;
                txtValidFrom.Text = lstQuotationMaster[0].ValidFrom.ToExternalDate();
                txtValidTo.Text = lstQuotationMaster[0].ValidTo.ToExternalDate();
                txtComments.Value = lstQuotationMaster[0].Comments.ToString();
                tblQuotationID.Text = lstQuotationMaster[0].QuotationID.ToString();
                chkActive.Checked = lstQuotationMaster[0].IsActive == "y" ? true : false;
                hdnSetListTable.Value = "";
                hdnbeforeTable.Value = "";
                if (lstQuotationMaster[0].Status == "Approved")
                {

                    btnSave.Attributes.Add("class", "show");
                }
                string quotationproducts = OrgID + "," + SID + "," + QuotationID + "~" + QuatationNo;
                hdnAprdMappedProducts.Value = quotationproducts;

                //GetAprdMappedProducts --->This functin is called from backend
                //string function = "GetAprdMappedProducts('" + OrgID + "','" + SID + "','" + QuotationID + "~" + QuatationNo + "');";
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "loadSrd", function, true);
                //ScriptManager.RegisterStartupScript(UpdatePanel2, UpdatePanel2.GetType(), "loadSrd", function, true);


                 

            }
            if (IsCorporateOrg.ToUpper().Equals("Y"))
            {
                hdnCorpOrg.Value = "Y";
                imgQuotationNo.Attributes.Add("class","hide");
            }
        }
        //txtValidFrom.Attributes.Add("onchange", "ExcedDate('" + txtValidFrom.ClientID.ToString() + "','',0,0);");
        //txtValidTo.Attributes.Add("onchange", "ExcedDate('" + txtValidTo.ClientID.ToString() + "','txtValidFrom',1,1);");
        //txtValidTo.Attributes.Add("onchange", "ExcedDate('" + txtValidTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtValidTo.ClientID.ToString() + "','txtValidFrom',1,1);");
    }
    public void LoadConfigDetail()
    {
        try
        {
            long returnCode = -1;
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            List<InventoryConfig> lstInventoryRateConfig = new List<InventoryConfig>();
            returnCode = new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Quotation_Approval", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    hdnConfig.Value = "Y";
                }
                else
                {
                    hdnConfig.Value = "N";
                    btnSave.Text = displayTool;
                   // btnClose.Visible = true;
                    btnReject.Visible = true;
                }
            }
            returnCode = new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Show_SellingPrice_MRP", OrgID, ILocationID, out lstInventoryRateConfig);
            if (lstInventoryRateConfig.Count > 0)
            {
                if (lstInventoryRateConfig[0].ConfigValue == "Y")
                {
                    hdnRateConfig.Value = "Y";
                }
                else
                {
                    hdnRateConfig.Value = "N";
                }
            }

            List<Config> lstConfig = new List<Config>();
            returnCode = new Configuration_BL(base.ContextInfo).GetConfigDetails("IsShowSP", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue == "Y")
                {
                    hdnShowSellingPrice.Value = "Y";
                }
                else
                {
                    hdnShowSellingPrice.Value = "N";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetConfigDetails", ex);
        }
    }
    public void LoadSupplierList()
    {
        try
        {
            long returnCode = -1;
            InventoryCommon_BL QuotationBL = new InventoryCommon_BL(base.ContextInfo);
            List<Suppliers> lstSuppliers = new List<Suppliers>();
            returnCode = QuotationBL.GetSupplierList(OrgID, InventoryLocationID, out lstSuppliers);
            DropSupplierName.DataSource = lstSuppliers;
            DropSupplierName.DataTextField = "SupplierName";
            DropSupplierName.DataValueField = "SupplierID";
            DropSupplierName.DataBind();
            
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            DropSupplierName.Items.Insert(0, ddlselect);
            //DropSupplierName.Items.Insert(0, GetMetaData("Select","0"));
            //end
            DropSupplierName.Items[0].Selected = true;
            /// ****** search Quotation dropdown basic  *********///
            ddlsearchsupplier.DataSource = lstSuppliers;
            ddlsearchsupplier.DataTextField = "SupplierName";
            ddlsearchsupplier.DataValueField = "SupplierID";
            ddlsearchsupplier.DataBind();
            
            
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlsearchsupplier.Items.Insert(0, ddlselect);
            //ddlsearchsupplier.Items.Insert(0, GetMetaData("Select","0"));
            //end
            ddlsearchsupplier.Items[0].Selected = true;
            ////****   End ************////
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetSupplierList", ex);
        }
    }
    public void LoadUnit()
    {
        try
        {
            long returnCode = -1;
            //List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
            //returnCode = new InventoryCommon_BL(base.ContextInfo).GetUnitType(OrgID, InventoryLocationID, out lstInventoryUOM);
            //drpUnit.DataSource = lstInventoryUOM;
            //drpUnit.DataTextField = "UOMCode";
            //drpUnit.DataValueField = "UOMCode";
            //drpUnit.DataBind();
            
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            drpUnit.Items.Insert(0, ddlselect);
          //  drpUnit.Items.Insert(0, new ListItem("--Select--", "0"));
            //end
            drpUnit.Items[0].Selected = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetUnitType", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        Quotation_BL QuotationBL = new Quotation_BL(base.ContextInfo);
        List<InventoryItemsBasket> lstItemBasket = new List<InventoryItemsBasket>();
        List<InventoryItemsBasket> lstTempItemBasket = new List<InventoryItemsBasket>();
        List<QuotationMaster> lstQuotationMaster = new List<QuotationMaster>();
        QuotationMaster objQuotationMaster = new QuotationMaster();
        objQuotationMaster.QuotationID = Convert.ToInt64(tblQuotationID.Text.Trim());
        objQuotationMaster.QuotationNo = txtQuotationNo.Text.Trim();
        objQuotationMaster.ValidFrom = txtValidFrom.Text.Trim().ToInternalDate();
        objQuotationMaster.ValidTo = txtValidTo.Text.Trim().ToInternalDate();
        objQuotationMaster.Comments = txtComments.Value.Trim();
        objQuotationMaster.CreatedAt = DateTimeNow;
        objQuotationMaster.CreatedBy = LID;
        objQuotationMaster.ModifiedBy = LID;
        objQuotationMaster.ModifiedAt = DateTimeNow;
        objQuotationMaster.Status = StockOutFlowStatus.Pending;
        objQuotationMaster.IsActive = chkActive.Checked == true ? "Y" : "N";
        if (RoleName != RoleHelper.Admin)
        {
            objQuotationMaster.IsActive = "N";
        }
        if (hdnConfig.Value == "N")
        {
            objQuotationMaster.Status = StockOutFlowStatus.Approved;
        }
        else if (hdnConfig.Value == "Y" && RoleName == RoleHelper.Admin)
        {
            objQuotationMaster.Status = StockOutFlowStatus.Approved;
        }
        else if (hdnConfig.Value == "Y" &&  RoleName == RoleHelper.InventoryAdmin)
        {
            objQuotationMaster.Status = StockOutFlowStatus.Approved;
        }
          



        lstQuotationMaster.Add(objQuotationMaster);
        try
        {
            foreach (string listParent in hdnSaveTable.Value.Split('^'))
            {
                if (listParent != "")
                {
                    string[] hdnstatus = hdnCheckedStatus.Value.Split('^');
                    InventoryItemsBasket ItemBasket = new InventoryItemsBasket();
                    string[] listChild = listParent.Split('~');
                    ItemBasket.ID = 0;
                    if (listChild[8] != "")
                    {
                        ItemBasket.ID = Int64.Parse(listChild[8]);
                    }
                    ItemBasket.UOMID = Int32.Parse(listChild[7]);
                    ItemBasket.ProductID = Int32.Parse(listChild[2]);
                    ItemBasket.Rate = Convert.ToDecimal(listChild[3]);
                    ItemBasket.Unit = (listChild[4]);
                    ItemBasket.InvoiceQty = Convert.ToDecimal(listChild[5]);
                    ItemBasket.Type = listChild[6];
                    ItemBasket.Manufacture = DateTimeNow;
                    ItemBasket.ExpiryDate = DateTimeNow;
                    ItemBasket.AttributeDetail = listChild[9];
                    ItemBasket.Description = StockOutFlowStatus.Pending;
                    ItemBasket.UnitSellingPrice = Convert.ToDecimal(listChild[14]);
                    ItemBasket.MRP = Convert.ToDecimal(listChild[15]);
                    ItemBasket.Discount = Convert.ToDecimal(listChild[16]);
                    ItemBasket.Tax = Convert.ToDecimal(listChild[17]);
                    if (hdnConfig.Value != null)
                    {
                        if (hdnConfig.Value == "N")
                        {
                            if (hdnstatus.Length > 0)
                            {
                                foreach (string lst in hdnCheckedStatus.Value.Split('^'))
                                {
                                    if (lst != "")
                                    {
                                        if (lst.Split('~')[2] == listChild[2] && lst.Split('~')[9] == listChild[9] && lst.Split('~')[4] == listChild[4])
                                        {
                                            ItemBasket.Description = StockOutFlowStatus.Approved;
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                        if (hdnConfig.Value == "Y" && hdnAdmin.Value == RoleHelper.Admin)
                        {
                            if (hdnstatus.Length > 0)
                            {
                                foreach (string lst in hdnCheckedStatus.Value.Split('^'))
                                {
                                    if (lst != "")
                                    {
                                        if (lst.Split('~')[2] == listChild[2] && lst.Split('~')[9].ToString() == listChild[9].ToString() && lst.Split('~')[4] == listChild[4])
                                        {
                                            ItemBasket.Description = StockOutFlowStatus.Approved;
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    lstItemBasket.Add(ItemBasket);
                }
            }
            lstTempItemBasket = lstItemBasket.FindAll(P => P.AttributeDetail == "R");
            foreach (InventoryItemsBasket item in lstTempItemBasket)
            {
                item.Amount = (item.Rate / item.InvoiceQty);
                item.TSellingPrice = (item.UnitSellingPrice / item.InvoiceQty);
                item.RECQuantity = (item.MRP / item.InvoiceQty);
                foreach (InventoryItemsBasket item1 in lstItemBasket.FindAll(p => p.ProductID == item.ProductID))
                {
                    item1.Rate = item.Amount * item1.InvoiceQty;
                    item1.UnitSellingPrice = item.TSellingPrice * item1.InvoiceQty;
                    item1.MRP = item.RECQuantity * item1.InvoiceQty;

                }
            }
            if (lstItemBasket.Count == 0)
            {
                lstItemBasket.Add(new InventoryItemsBasket()
                {
                    UOMID = Convert.ToInt32(DropSupplierName.SelectedItem.Value),
                    Manufacture = DateTimeNow,
                    ExpiryDate = DateTimeNow
                });
            }

            returnCode = QuotationBL.SaveInventoryItems(OrgID, LID, lstQuotationMaster, lstItemBasket);
            if (Request.QueryString["tid"] != null)
            {
                long taskID;
                Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);

                new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
            }
            if (returnCode > 0)
            {

                int sid = Convert.ToInt32(DropSupplierName.SelectedItem.Value);
                if ((btnSave.Text == displayTool && hdnConfig.Value == "Y" && hdnAdmin.Value == RoleHelper.Admin && hdnChkFlag.Value == "0") || (hdnConfig.Value == "N"))
                {
                    string sPath = Resources.Quotation_AppMsg.Quotation_ProductSupplierRateMapping_aspx_27;
                    sPath = sPath == null ? "Approved Successfully" : sPath;

                    string errorMsg = Resources.Quotation_AppMsg.Quotation_Error;
                    errorMsg = errorMsg == null ? "Error" : errorMsg;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert1", " ValidationWindow('" + sPath + "','" + errorMsg + "');javascript:SetDatePickterValue();Tblist('');HidedvProductMap();", true);
                    Getquotationsdetails(sid, -1);

                }
                else if ((btnSave.Text == displayTool && hdnConfig.Value == "Y" && hdnAdmin.Value == RoleHelper.Admin && hdnChkFlag.Value == "1"))
              //end
                {
                    string sPath = Resources.Quotation_AppMsg.Quotation_ProductSupplierRateMapping_aspx_27;
                    sPath = sPath == null ? "Approved Successfully" : sPath;

                    string errorMsg = Resources.Quotation_AppMsg.Quotation_Information;
                    errorMsg = errorMsg == null ? "Information" : errorMsg;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert2", "ValidationWindow('" + sPath + "','" + errorMsg + "');javascript:SetDatePickterValue();Tblist('');HidedvProductMap();", true);
                    Getquotationsdetails(sid, Convert.ToInt64(tblQuotationID.Text.Trim()));

                }
                else
                {
                    string sPath = Resources.Quotation_AppMsg.Quotation_ProductSupplierRateMapping_aspx_28;
                    sPath = sPath == null ? "Quotation saved successfully" : sPath;

                    string errorMsg = Resources.Quotation_AppMsg.Quotation_Information;
                    errorMsg = errorMsg == null ? "Information" : errorMsg;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert3", "javascript:ValidationWindow('" + sPath + "','" + errorMsg + "');javascript:SetDatePickterValue();Tblist('');HidedvProductMap();", true);
                    Getquotationsdetails(sid, -1);

                }
                hdnSaveTable.Value = "";
                hdnSetListTable.Value = "";
                txtProductName.Text = "";
                txtRate.Text = "0.00";
                txtDiscount.Text = "0.00";
                txtTax.Text = "0.00";
                txtInverseQuantity.Text = "0";
                drpUnit.SelectedIndex = 0;
                chkIsDefault.Checked = false;
                hdnCheckedStatus.Value = "";
                hdnSetListTable.Value = "";
                txtQuotationNo.Text = "";
                txtValidFrom.Text = "";
                txtValidTo.Text = "";
                txtComments.Value = "";
                tblQuotationID.Text = "0";
                DropSupplierName.SelectedIndex = 0;
                chkActive.Checked = false;
                txtProduct.Text = "";
                //   DropSupplierName.Items.Clear();
                // LoadSupplierList();
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert4", "javascript:SetDatePickterValue();Tblist();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing SaveInventoryItem", ex);
        }
    }

    public void Getquotationsdetails(int SupID, long QuotationID)
    {
        long returncode = -1;
        string Quotationo = "";
        int ProductID = 0;
        DropSupplierName.SelectedItem.Value = SupID.ToString();
        Quotation_BL QuotationBL = new Quotation_BL(base.ContextInfo);
        List<QuotationMaster> lstQuotationMaster = new List<QuotationMaster>();
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        returncode = QuotationBL.GetQuotationDetails(OrgID, SupID, Convert.ToInt64(QuotationID), Quotationo,ProductID, out lstQuotationMaster);
        if (lstQuotationMaster.Count > 0)
        {
            grdQuotation.DataSource = lstQuotationMaster.OrderBy(p => p.Status).ToList();
            grdQuotation.DataBind();
        }
    }
    public void GetApprovedItems()
    {
        try
        {
            string QuotationNo = "";
            hdnSetListTable.Value = "";
            hdnbeforeTable.Value = "";
            txtQuotationNo.Text = "";
            txtValidFrom.Text = "";
            txtValidTo.Text = "";
            txtComments.Value = "";
            hdnUnProducts.Value = "";
            tblQuotationID.Text = "0";
            grdQuotation.DataSource = null;
            grdQuotation.DataBind();
            long returnCode = -1;
            int SupID = 0;
            int QuotationID = 0;
            SupID = Convert.ToInt32(Request.QueryString["SupplierID"]);
            QuotationID = Convert.ToInt32(Request.QueryString["QuotationID"]);
            int productID = 0;
            tdSupplier.Attributes.Add("class", "displaytd");
            DropSupplierName.SelectedValue = SupID.ToString();
            DropSupplierName.Enabled = false;
            //if (Request.QueryString["SupplierID"] != null && Request.QueryString["QuotationID"] != null)
            //{
            //    SupID = Convert.ToInt32(Request.QueryString["SupplierID"]);
            //    QuotationID = Convert.ToInt32(Request.QueryString["QuotationID"]);
            //    tdSupplier.Style.Add("display", "none");
            //}
            //else if (hdnSupID.Value != "0" && hdnQuotID.Value != "0")
            //{
            //    SupID = Convert.ToInt32(hdnSupID.Value);
            //    QuotationID = Convert.ToInt32(hdnQuotID.Value);
            //}
            //DropSupplierName.SelectedItem.Value = SupID.ToString();
            Quotation_BL QuotationBL = new Quotation_BL(base.ContextInfo);
            List<QuotationMaster> lstQuotationMaster = new List<QuotationMaster>();
            List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
            returnCode = QuotationBL.GetQuotationDetails(OrgID, SupID, Convert.ToInt64(QuotationID), QuotationNo,productID, out lstQuotationMaster);
            if (lstQuotationMaster.Count > 0)
            {
                grdQuotation.DataSource = lstQuotationMaster.OrderBy(p => p.Status).ToList();
                grdQuotation.DataBind();
                txtQuotationNo.Text = lstQuotationMaster[0].QuotationNo;
                txtValidFrom.Text = lstQuotationMaster[0].ValidFrom.ToString("dd/MM/yyyy");
                txtValidTo.Text = lstQuotationMaster[0].ValidTo.ToString("dd/MM/yyyy");
                txtComments.Value = lstQuotationMaster[0].Comments;
                tblQuotationID.Text = lstQuotationMaster[0].QuotationID.ToString();
                hdnSetListTable.Value = "";
                hdnbeforeTable.Value = "";
                //string str = OrgID + "," + SupID + ",'" + QuotationID.ToString() + "~" + lstQuotationMaster[0].QuotationNo.ToString() + "'";
                string str = OrgID + "," + SupID + "," + QuotationID.ToString() + "~" + lstQuotationMaster[0].QuotationNo.ToString();
                hdnAprdMappedProducts.Value = str;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "IsDefault", "GetAprdMappedProducts(" + str + ");", true);
                // if (hdnSupID.Value != "0" && hdnQuotID.Value != "0")
                // {
                //     long retCode = -1;
                //     retCode = InventoryBL.GetMappedProducts(OrgID, SupID, QuotationID, lstQuotationMaster[0].QuotationNo, out lstInventoryItemsBasket); 
                //     foreach (InventoryItemsBasket item in lstInventoryItemsBasket)
                //     {
                //         hdnSetListTable.Value += item.Description + "^";
                //     } 
                //     txtQuotationNo.Text = "";
                //     txtValidFrom.Text = "";
                //     txtValidTo.Text = "";
                //     txtComments.Value = "";
                //     tblQuotationID.Text = "0";
                // }
                //// ScriptManager.RegisterStartupScript(Page, this.GetType(), "loa1dSrd", "  Tblist();", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetQuotationDetails", ex);
        }
    }
    protected void ddlsearchsupplier_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            hdnSetListTable.Value = "";
            hdnbeforeTable.Value = "";
            txtQuotationNo.Text = "";
            txtValidFrom.Text = "";
            txtValidTo.Text = "";
            txtComments.Value = "";
            hdnUnProducts.Value = "";
            tblQuotationID.Text = "0";
            string QuatationNo = "";
            QuatationNo = txtsearchquotation.Text;
            List<QuotationMaster> lstQuotationMaster = new List<QuotationMaster>();
            Int32 SearchProductID = 0;
            Int32.TryParse(hdnProductSearchID.Value, out SearchProductID);
            if (ddlsearchsupplier.SelectedItem.Value != "0" || QuatationNo != "" || SearchProductID>0)
            {
                //tdShowHide.Style.Add("display", "block");
                long returnCode = -1;
                long QuotationID = -1;
                int SupID = Convert.ToInt32(ddlsearchsupplier.SelectedItem.Value);
                Quotation_BL QuotationBL = new Quotation_BL(base.ContextInfo);

                lstQuotationMaster.Clear();
                returnCode = QuotationBL.GetQuotationDetails(OrgID, SupID, QuotationID, QuatationNo,SearchProductID, out lstQuotationMaster);
                if (lstQuotationMaster.Count > 0)
                {
                    DropSupplierName.SelectedValue = lstQuotationMaster[0].SupplierID.ToString();
                    grdQuotation.DataSource = lstQuotationMaster.OrderBy(p => p.Status).ToList();
                    grdQuotation.DataBind();
                    tdShowHide.Attributes.Add("class", "displaytd");
                    //tdShowHide.Style.Add("display", "block");
                    //DivSupplier.Attributes.Add("class","hide")
                    //ACX2responses4.Attributes.Add("class", "panelHeader");

                    ACX2responses4.Attributes.Add("class", "displaytr");
                    //ACX2responses4.Style.Add("display", "block");
                    ACX2minusOPPmt1.Attributes.Add("class", "show");
                    ACX2OPPmt1.Attributes.Add("class", "hide");
                }
                else
                {
                    DropSupplierName.SelectedIndex = 0;
                    grdQuotation.DataSource = null;
                    grdQuotation.DataBind();
                }
            }
            else
            {
                DropSupplierName.SelectedIndex = 0;
                lstQuotationMaster.Clear();
                grdQuotation.DataSource = null;
                grdQuotation.DataBind();
            }
            DropSupplierName.Focus();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert5", "javascript:HideSellingPrice();Tblist();SetDatePickterValue();HideFillTable('hideButton')", true);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing GetMappedQuotations", ex);
        }

    }
    protected void grdQuotation_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {

            grdQuotation.PageIndex = e.NewPageIndex;
            ddlsearchsupplier_SelectedIndexChanged(sender, e);
        }
    }

    protected void grdQuotation_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.Pager)
        {
            //e.Row.Cells[5].Attributes.Add("class", "displaytr");
          //  e.Row.Cells[5].Attributes.Add("class", "hide");
        //    e.Row.Cells[7].Attributes.Add("class", "hide");
            e.Row.Cells[1].Attributes.Add("class", "hide");
            if (hdnIsSellingPriceTypeRuleApply.Value == "Y")
            {
                e.Row.Cells[10].Attributes.Add("class", "hide");
            }
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            QuotationMaster obj = (QuotationMaster)e.Row.DataItem;
            Label lblIsActive = (Label)e.Row.FindControl("lblIsActive");
            Label lblStatus = (Label)e.Row.FindControl("lblStatus");
            LinkButton likQuotationView = (LinkButton)e.Row.FindControl("likQuotationView");
            string displayTool1 = Resources.Quotation_AppMsg.Quotation_ProductSupplierRateMapping_aspx_03;
            displayTool1 = displayTool1 == null ? "Click to view mapped product details" : displayTool1;
            HiddenField hdnSupplierID = (HiddenField)e.Row.FindControl("hdnSupplierID");

            e.Row.ToolTip = displayTool1;
            if (obj.Status == StockOutFlowStatus.Approved)
            {
                e.Row.CssClass = "grdcheck";
            }

            string str = "GetMappedProducts('" + ((Label)e.Row.FindControl("lblQuotationID")).ClientID + "^" + OrgID + "^" +
                ((Label)e.Row.FindControl("lblQuotationNo")).ClientID + "^" +
                ((Label)e.Row.FindControl("lblValidFrom")).ClientID + "^" +
                ((Label)e.Row.FindControl("lblValidTo")).ClientID + "^" +
                ((Label)e.Row.FindControl("lblComments")).ClientID + "^" +
                ((Label)e.Row.FindControl("lblStatus")).ClientID + "^" +
                ((Label)e.Row.FindControl("lblIsActive")).ClientID + "^" +
                ((Label)e.Row.FindControl("lblSupplierId")).ClientID + "^" + "');";
            e.Row.Cells[2].Attributes.Add("onclick", str);

            string supllierId = hdnSupplierID.Value;// DropSupplierName.SelectedValue.ToString();
            string QuotationId = ((Label)e.Row.FindControl("lblQuotationID")).Text;
            string Strview = "ViewQuotationList('" + QuotationId + "','" + supllierId + "');";
            //e.Row.Cells[9].Attributes.Add("onclick", Strview);
            likQuotationView.Attributes.Add("onclick", Strview);
        }
    }
    #region CancelClick
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["SupplierID"] != "0" && Request.QueryString["SupplierID"] != null)
        {
            Response.Redirect("~/InventoryCommon/InventorySearch.aspx", true);
        }
        else
        {
            long Returncode = -1;
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            Returncode = new Attune_Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
    }
    #endregion
    protected void btnReject_Click(object sender, EventArgs e)
    {
        int sid = Convert.ToInt32(DropSupplierName.SelectedItem.Value);
        long QuatationID = Convert.ToInt64(tblQuotationID.Text.Trim());
        Quotation_BL QuotationBL = new Quotation_BL(base.ContextInfo);
        QuotationBL.UpdateQuatationStatus(OrgID, QuatationID, StockOutFlowStatus.Rejected);
        string sPath = Resources.Quotation_AppMsg.Quotation_ProductSupplierRateMapping_aspx_29;
        sPath = sPath == null ? "Quotation Rejected successfully" : sPath;

        string errorMsg = Resources.Quotation_AppMsg.Quotation_Information;
        errorMsg = errorMsg == null ? "Information" : errorMsg;
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert6", "ValidationWindow('" + sPath + "','" + errorMsg + "');", true);
        Getquotationsdetails(sid, QuatationID);
        
        hdnSaveTable.Value = "";
        hdnSetListTable.Value = "";
        txtProductName.Text = "";
        txtRate.Text = "0.00";
        txtDiscount.Text = "0.00";
        txtTax.Text = "0.00";
        txtInverseQuantity.Text = "0";
        drpUnit.SelectedIndex = 0;
        chkIsDefault.Checked = false;
        hdnCheckedStatus.Value = "";
        hdnSetListTable.Value = "";
        txtQuotationNo.Text = "";
        txtValidFrom.Text = "";
        txtValidTo.Text = "";
        txtComments.Value = "";
        tblQuotationID.Text = "0";
        DropSupplierName.SelectedIndex = 0;
        chkActive.Checked = false;
        txtProduct.Text = "";
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        int sid = Convert.ToInt32(DropSupplierName.SelectedItem.Value);
        long QuatationID = Convert.ToInt64(tblQuotationID.Text.Trim());
        Quotation_BL QuotationBL = new Quotation_BL(base.ContextInfo);
        QuotationBL.UpdateQuatationStatus(OrgID, QuatationID, StockOutFlowStatus.Cancelled);

        string sPath = Resources.Quotation_AppMsg.Quotation_ProductSupplierRateMapping_aspx_29;
        sPath = sPath == null ? "Quotation Rejected successfully" : sPath;

        string errorMsg = Resources.Quotation_AppMsg.Quotation_Information;
        errorMsg = errorMsg == null ? "Information" : errorMsg;
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert7", "ValidationWindow('" + sPath + "','" + errorMsg + "');", true);
        Getquotationsdetails(sid, -1);
    }
}


