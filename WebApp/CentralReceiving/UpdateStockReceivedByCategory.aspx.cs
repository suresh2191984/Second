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
using System.Linq;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using System.Collections.Generic;
using AjaxControlToolkit;
using System.Globalization;
using System.Text;
using System.Web.Script.Serialization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.InventoryCommon;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.CentralReceiving.BL;

public partial class CentralReceiving_UpdateStockReceivedByCategory : Attune_BasePage
{
    public CentralReceiving_UpdateStockReceivedByCategory()
        : base("CentralReceiving_UpdateStockReceivedByCategory_aspx")
    {
    }
    long longStockReceivedID = 0;
    string purchaseOrderNo = string.Empty;
    string ordereddate = string.Empty;
    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    List<StockStatus> lstStockStatus = new List<StockStatus>();
    List<StockStatus> lstStockStatus1 = new List<StockStatus>();
    List<StockType> lstStockType = new List<StockType>();
    long TaskID = 0, CurrentTaskID = 0, StockReceivedID = 0, POID = 0;
    int StockTypeID = 0, StatusID = 0, ActionID = 0, SeqNo = 0, RuleID = 0;
    string ApprovelConfigValue = string.Empty;
    string SupplierName = string.Empty;
    string StockReceivedNo = string.Empty;
    string Status = string.Empty;
	List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    string IsEditTaxRate = "N";
    string IsAttributeConfig = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedCompQtyCalculation", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {

                hdnREQCalcCompQTY.Value = lstInventoryConfig[0].ConfigValue;
            }
            hdnExpiryDateFormatDDMMYYY.Value = GetInventoryConfigDetailsValue("StockReceiveExpirydateFormatDD/MM/YYYY", OrgID, 0) == "Y" ? "Y" : "N";
            Suppliers();
            if (!string.IsNullOrEmpty(Request.QueryString["orderdate"]))
            {
                ordereddate = Request.QueryString["orderdate"].ToString();
            }
            if (!string.IsNullOrEmpty(Request.QueryString["PONO"]))
            {
                StockReceivedID = Convert.ToInt64(Request.QueryString["PONO"]);
                longStockReceivedID = Convert.ToInt64(Request.QueryString["PONO"]);
                LoadStockCategories(longStockReceivedID);
            }
            if (!string.IsNullOrEmpty(Request.QueryString["ID"]))
            {
                longStockReceivedID = Convert.ToInt64(Request.QueryString["ID"]);
                StockReceivedID = Convert.ToInt64(Request.QueryString["ID"]);
                LoadStockCategories(StockReceivedID);
            }
            GetUnites();
            string HideTaxOpbilling = GetConfigValue("IsMiddleEast", OrgID);
            if (HideTaxOpbilling == "Y")
            { 
              trSupplierServiceTax.Style.Add("display", "none");
              trTotalTaxAmount.Style.Add("display", "none");               
            }   
        }

    }

    protected void Suppliers()
    {
        List<Suppliers> lstSuppliers = new List<Suppliers>();
        InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);
        if (lstSuppliers != null && lstSuppliers.Count > 0)
        {
            ddlSupplier.DataSource = lstSuppliers;
            ddlSupplier.DataTextField = "SupplierName";
            ddlSupplier.DataValueField = "SupplierID";
            ddlSupplier.DataBind();
        }
        ListItem ddlselect = GetMetaData("Any", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Any", Value = "0" };
        }  
        ddlSupplier.Items.Insert(0,ddlselect);
        ddlSupplier.Items[0].Value = "0";
    }

    protected void LoadStockCategories(long PONO)
    {
        InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        List<InventoryItemsBasket> lstInventoryItemsBasket1 = new List<InventoryItemsBasket>();
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        List<Suppliers> lstSuppliers = new List<Suppliers>();
        List<InventoryItemsBasket> lstTempSrd = new List<InventoryItemsBasket>();
        List<SupplierCreditorDebitNote> lstSCDN = new List<SupplierCreditorDebitNote>();
        List<StockReceiveByCategory> lstStockReceiveByCategory = new List<StockReceiveByCategory>();
        List<Organization> lstOrganization = new List<Organization>();
        List<Suppliers> lstSupplierss = new List<Suppliers>();
        List<StockReceived> lstStockReceived = new List<StockReceived>();
        List<StockReceivedAttributesDetails> lstARAD = new List<StockReceivedAttributesDetails>();
        List<StockReceived> lstTaxType = new List<StockReceived>();
        List<Taxmaster> lstTaxmaster = new List<Taxmaster>();
        inventoryBL.GetCentralStockReceivedDetails(OrgID, ILocationID, PONO, out lstOrganization, out lstSupplierss, out lstStockReceived,
            out lstInventoryItemsBasket, out lstStockReceiveByCategory, out lstARAD, out lstTaxType, out lstTaxmaster);
        if (lstTaxType != null && lstTaxType.Count > 0)
        {
            SetTaxType(lstTaxType);
        }
        if (lstSupplierss != null && lstStockReceived != null && lstSupplierss.Count > 0 && lstStockReceived.Count > 0)
        {
            if (!string.IsNullOrEmpty(lstStockReceived[0].SupServiceTax.ToString()))
            {
                txtTotaltax.Text = String.Format("{0:0.00}", lstStockReceived[0].SupServiceTax);
            }
            if (!string.IsNullOrEmpty(lstStockReceived[0].Discount.ToString()))
            {
                txtTotalDiscount.Text = String.Format("{0:0.00}", lstStockReceived[0].PODiscountAmount);
            }
            if (!string.IsNullOrEmpty(lstStockReceived[0].GrandTotal.ToString()))
            {
                txtNetTotal.Text = String.Format("{0:0.00}", lstStockReceived[0].GrandTotal);
            }
            if (lstStockReceived[0].GrandTotal > 0 && lstStockReceived[0].RoundOfValue > 0)
            {
                txtGrandwithRoundof.Text = String.Format("{0:0.00}", lstStockReceived[0].GrandTotal - lstStockReceived[0].RoundOfValue);
                txtRoundOffValue.Text = String.Format("{0:0.00}", lstStockReceived[0].RoundOfValue);
            }

            if (!string.IsNullOrEmpty(lstStockReceived[0].UsedCreditAmount.ToString()) && lstStockReceived[0].UsedCreditAmount >0)
            {
                txtUseCreditAmount.Text =String.Format("{0:0.00}", lstStockReceived[0].UsedCreditAmount);
            }
            if (!string.IsNullOrEmpty(lstStockReceived[0].InvoiceDate.ToString()))
            {
                //txtInvoiceDate.T = Convert.ToDateTime(lstStockReceived[0].InvoiceDate).ToString("dd/MM/yyyy");
                txtInvoiceDate.Text = lstStockReceived[0].InvoiceDate.ToExternalDate();
            }
            if (!string.IsNullOrEmpty(lstStockReceived[0].NetCalcTax))
            {
                string NetcalcTax = string.Empty;
                NetcalcTax =lstStockReceived[0].NetCalcTax.Trim();
                hdncalTaxType.Value = NetcalcTax;
                if (NetcalcTax == "CP")
                {
                    hdncalTaxType.Value = NetcalcTax;
                    rbtnCP.Checked = true;
                  ScriptManager.RegisterStartupScript(Page, this.GetType(), "CP1", "ChangeCalculation_load('CP');", true);
                }
                else if (NetcalcTax == "SP")
                {
                    rbtnMRP.Checked = true;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "SP1", "ChangeCalculation_load('SP');", true);
                }
                else
                {
                    rbtnCP.Checked = true;

                }
            }
            else
            {
                rbtnCP.Checked = true;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "CP1", "ChangeCalculation_load('CP');", true);
            }
            BindSupplierDetails(lstSupplierss, lstStockReceived);
        }
        if (lstTaxmaster != null && lstTaxmaster.Count > 0)
        {
            JavaScriptSerializer objJSS = new JavaScriptSerializer();
            hdnGetTaxList.Value = objJSS.Serialize(lstTaxmaster);
        }
        divStockReceived.InnerHtml = string.Empty;
        StringBuilder sb = new StringBuilder();

        var distinctCustomers = ((from p in lstInventoryItemsBasket
                                  where p.CategoryID.ToString() != string.Empty
                                  select p.CategoryID.ToString()).Distinct()).ToArray();


        if (distinctCustomers != null)
        {
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Attributes_Basedby_Category", OrgID, ILocationID, out lstInventoryConfig);
            

            IsAttributeConfig = lstInventoryConfig.Count == 0 ? "N" : lstInventoryConfig[0].ConfigValue;
            if (IsAttributeConfig == "N")
            {
                for (int i = 0; i < distinctCustomers.Count(); i++)
                {
                    List<InventoryItemsBasket> lstIB = lstInventoryItemsBasket.FindAll(P => (P.CategoryID == int.Parse(distinctCustomers[i])));
                    sb.Append(StockRow(lstIB, lstStockReceiveByCategory, lstARAD));
                }
            }
            else
            {
                sb.Append(StockRow(lstInventoryItemsBasket, lstStockReceiveByCategory, lstARAD));
            }


        }
        divStockReceived.InnerHtml = string.Empty;
        divStockReceived.InnerHtml = sb.ToString();
    }

    protected void BindSupplierDetails(List<Suppliers> lstSupplierss, List<StockReceived> lstStockReceived)
    {
        txtPurchaseOrderNo.Text = Convert.ToString(lstSupplierss[0].ContactPerson);
        hdnSupplierID.Value = lstSupplierss[0].SupplierID.ToString();
        ddlSupplier.SelectedValue = lstSupplierss[0].SupplierID.ToString();
        hdnPOID.Value = lstSupplierss[0].ParentSupplierID.ToString();
        txtPurchaseOrderNo.Text = lstStockReceived[0].PurchaseOrderNo;
        txtDCNumber.Text = lstStockReceived[0].DCNumber;
        txtInvoiceNo.Text = lstStockReceived[0].InvoiceNo;
        StockReceivedNo = lstStockReceived[0].StockReceivedNo;
        hdnStockReceivedNo.Value = lstStockReceived[0].StockReceivedNo;
        if (lstStockReceived[0].InvoiceDate.ToString("yyyy").Equals("9999"))
        {
            txtInvoiceDate.Text = DateTimeNow.ToExternalDate();
        }
        else
        {
            txtInvoiceDate.Text = lstStockReceived[0].InvoiceDate.ToExternalDate();
        }
        txtComments.Text = lstStockReceived[0].Comments;
        txtReceivedDate.Text = DateTimeNow.ToExternalDate();
        string IsNeededTaxValue = string.Empty;
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedTaxValueAddedCostPrice", OrgID, ILocationID, out lstInventoryConfig);
        if (lstInventoryConfig.Count > 0)
        {
            IsNeededTaxValue = lstInventoryConfig[0].ConfigValue;
        }
        else
        {
            IsNeededTaxValue = "N";
        }
        if (IsNeededTaxValue == "Y" && lstSupplierss[0].PIN.Equals(StateID.ToString()))
        {
            hdnFlag.Value = "1";
            Session["SuppliersPIN"] = "1";
        }
        else
        {
            hdnFlag.Value = "0";
            Session["SuppliersPIN"] = "0";
        }
    }

    protected StringBuilder StockRow(List<InventoryItemsBasket> lstIIB, List<StockReceiveByCategory> lstStockReceiveByCategory, List<StockReceivedAttributesDetails> lstSRAD)
    {
        StringBuilder sbHeadStart = new StringBuilder();
        StringBuilder sbBody = new StringBuilder();
        StringBuilder sb = new StringBuilder();
        int i = 1;
        string strCategoryName = string.Empty;
        string strSetAttr = string.Empty;
        sbHeadStart.Append(DefaultHeader());

        foreach (InventoryItemsBasket row in lstIIB)
        {
            sbBody.Append("<tr class='trRow'>");
            if (IsAttributeConfig == "Y")
                sbBody.Append("<td align='center'><span id='" + Guid.NewGuid() + "' Validate='0' SRDID='" + row.ID + "' CategoryID='" + row.CategoryID + "' ProductID='" + row.ProductID + "'>" + row.ProductName + "(" + row.CategoryName + ")</span></td>");
            else
                sbBody.Append("<td align='center'><span id='" + Guid.NewGuid() + "' Validate='0' SRDID='" + row.ID + "' CategoryID='" + row.CategoryID + "' ProductID='" + row.ProductID + "'>" + row.ProductName + "</span></td>");

            sbBody.Append("<td align='center'><span id='" + Guid.NewGuid() + "' class='POQuantity' Validate='0' ASRQty='" + row.TotalQty + "' Attr='POQuantity'>" + row.POQuantity + "</span></td>");
            sbBody.Append("<td align='center'><span id='" + Guid.NewGuid() + "' Validate='0' Attr='POUnit'>" + row.POUnit + "</span></td>");
            sbBody.Append("<td align='center'><span id='" + Guid.NewGuid() + "' Validate='0' Attr='RECUnit'>" + row.POUnit + "</span></td>");
            sbBody.Append("<td align='center'><span id='" + Guid.NewGuid() + "' Validate='0' class='LSUnit' Attr='LSUnit'>" + row.LSUnit + "</span></td>");
            List<StockReceiveByCategory> lstSRC = lstStockReceiveByCategory.FindAll(P => (P.ProductID == row.ProductID) && (P.CategoryID == row.CategoryID));
            List<StockReceivedAttributesDetails> lstCAM = lstSRAD.FindAll(P => (P.CategorieMappingID == row.CategoryID) && (P.StockReceivedDetailsId == row.ProductID));
            if (lstSRC != null && lstSRC.Count > 0)
            {
                string getCategories = string.Empty;
                foreach (StockReceiveByCategory childRow in lstSRC.OrderBy(P => P.SeqNo))
                {
                    if (childRow.AttributeName == "POQuantity" || childRow.AttributeName == "POUnit" || childRow.AttributeName == "ProductName" || childRow.AttributeName == "LSUnit")
                    {

                    }
                    else
                    {
                        strSetAttr = string.Empty;
                        switch (childRow.ControlName.ToLower())
                        {
                            case "textbox":
                                string txtValue = string.Empty;
                                if (i == lstIIB.Count)
                                {
                                    if (childRow.ShowColumn.Equals("0"))
                                    {
                                        strSetAttr = " style='display:none'";
                                    }
                                    strCategoryName = row.CategoryName;
                                    sbHeadStart.Append("<th " + strSetAttr + " class='dataheader1'>" + childRow.DisplayText + "</th>");
                                }
                                try
                                {
                                    if (childRow.AttributeName.Equals("Type"))
                                    {
                                        var v3 = row.GetType().GetProperty("Type").GetValue(row, null);
                                        txtValue = v3.ToString();
                                    }
                                    else
                                    {
                                        var v2 = row.GetType().GetProperty(childRow.AttributeName.Trim()).GetValue(row, null);
                                        txtValue = v2.ToString();
                                    }
                                }
                                catch (Exception)
                                {
                                    foreach (StockReceivedAttributesDetails CAT in lstCAM)
                                    {
                                        if (childRow.AttributeName.Equals(CAT.AttributesKey))
                                        {
                                            txtValue = CAT.AttributesValue;
                                            break;
                                        }
                                    }
                                }
                                getCategories = GetTextBox(childRow.CategorieMappingID.ToString(), childRow.AttributeName, txtValue, childRow.IsMandatory, childRow.ShowColumn, childRow.DataType);
                                sbBody.Append(getCategories);

                                break;

                            case "checkbox":
                                string chkValue = string.Empty;
                                if (i == lstIIB.Count)
                                {
                                    sbHeadStart.Append("<th class='dataheader1'>" + childRow.DisplayText + "</th>");
                                }
                                try
                                {
                                    var v2 = row.GetType().GetProperty(childRow.AttributeName).GetValue(row, null);
                                    chkValue = v2.ToString();
                                }
                                catch (Exception)
                                {

                                }
                                getCategories = GetChktBox(childRow.CategorieMappingID.ToString(), childRow.AttributeName, chkValue, childRow.IsMandatory, childRow.ShowColumn);
                                sbBody.Append(getCategories);
                                break;

                            case "dropdownlist":
                                string ddlValue = string.Empty;
                                if (i == lstIIB.Count)
                                {
                                    sbHeadStart.Append("<th class='dataheader1'>" + childRow.DisplayText + "</th>");
                                }
                                try
                                {
                                    var v2 = row.GetType().GetProperty(childRow.AttributeName).GetValue(row, null);
                                    ddlValue = v2.ToString();
                                }
                                catch (Exception)
                                {

                                }
                                getCategories = GetDropDownList(childRow.CategorieMappingID.ToString(), childRow.AttributeName, childRow.ControlValue, childRow.IsMandatory, ddlValue, childRow.ShowColumn);
                                sbBody.Append(getCategories);
                                break;

                            default:
                                break;
                        }
                    }
                }
            }
            sbBody.Append("</tr>");
            i++;
        }
        sbHeadStart.Append("</tr>");
        if (IsAttributeConfig == "N")
        {
            sb.Append("<span style='border:solid 1px black;background-color:#BBE7ED;padding:3px;' >" + strCategoryName + "</span>");
        }
        sb.Append("<table id='tblSRRow' style='margin-bottom:10px;width:100%;' border='1' cellpadding='4' cellspacing='0'>");
        sb.Append(sbHeadStart);
        sb.Append(sbBody);
        sb.Append("</table>");

        return sb;
    }

    protected string GetAttributes(string AttributeName)
    {
        string setAttr = string.Empty;
        switch (AttributeName.Trim())
        {
            case "RECQuantity":
                setAttr = " class='RQTY' onkeyup='CalculateTotalCost(this)' maxlength='6' ";
                break;

           //case "UnitCostPrice":
            case "UnitPrice":
                setAttr = " class='UCP' onkeyup='CalculateTotalCost(this)' maxlength='12' ";
                break;

            case "Type":
                setAttr = " class='TP' maxlength='12' ";
                break;

            case "Discount":
                setAttr = " class='DIS' onkeyup='CalculateTotalCost(this)' maxlength='6' ";
                break;

            case "Tax":
				 new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Is_change_or_edit_VAT_Rate_Products", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    if (lstInventoryConfig[0].ConfigValue == "Y")
                    {
                        IsEditTaxRate = "Y";
                    }
                    else
                    {
                        IsEditTaxRate = "N";
                    }
                }
                else
                {
                    IsEditTaxRate = "N";
                }
                if (Session["SuppliersPIN"] == "0" && IsEditTaxRate == "N")
                {
                    setAttr = " class='TAX' onkeyup='CalculateTotalCost(this)' maxlength='6' ";
                }
                else
                {
                    setAttr = " class='TAX' onkeyup='CalculateTotalCost(this)' maxlength='6' disabled='disabled' ";
                    //setAttr = " class='TAX' onkeyup='CalculateTotalCost(this)' maxlength='6' disabled='disabled' ";
                }
                break;

            case "InvoiceQty":
                setAttr = " class='InvoiceQty' onkeyup='CalculateTotalCost(this)' maxlength='6' ";
                break;

            case "Manufacture":
                 // setAttr = " class='Manufacture'";
                setAttr = " class='monthYearPicker'";
                break;

            case "ExpiryDate":
                setAttr = " class='monthYearPicker'";
                break;

            case "RcvdLSUQty":
                setAttr = " class='RcvdLSUQty'  onkeyup='CalculateTotalCost(this)'";
                break;

           // case "UnitPrice":
            case "UnitCostPrice":

                setAttr = " class='UnitPrice'  onkeyup='CalculateTotalCost(this)'";
                break;

            case "MRP":
                setAttr = " class='MRP' onkeyup='CalculateTotalCost(this)'  ";
                break;

            case "ComplimentQTY":
                if (!string.IsNullOrEmpty(hdnREQCalcCompQTY.Value) && hdnREQCalcCompQTY.Value.Equals("Y"))
                {
                    setAttr = " class='ComplimentQTY' onkeyup='CalculateTotalCost(this)' ";
                }
                else
                {
                    setAttr = " class='ComplimentQTY' ";
                }
                break;

            case "SellingPrice":
                setAttr = " class='SellingPrice' onkeyup='CalculateTotalCost(this)' ";
                break;

            case "Shortage":
                setAttr = " class='Shortage' onkeyup='CalculateTotalCost(this)' ";
                break;

            case "Damage":
                setAttr = " class='Damage' onkeyup='CalculateTotalCost(this)' ";
                break;

            case "Rejected":
                setAttr = " class='Rejected' onkeyup='CalculateTotalCost(this)' ";
                break;

            case "Comments":
                setAttr = " class='Comments'";
                break;

            default:
                break;
        }
        return setAttr;
    }


    protected string GetTextBox(string ID, string AttributeName, string TXTValue, bool IsMandatory, string ShowColumn, string DataType)
    {
        string strSetAttr = string.Empty;
        string setAttr = GetAttributes(AttributeName);
        if (AttributeName.Equals("Manufacture") || AttributeName.Equals("ExpiryDate"))
        {
            DateTime dt = Convert.ToDateTime(TXTValue);
            if (dt.ToString("yyyy").Equals("9999"))
            {
                TXTValue = string.Empty;
            }
            else
            {
                TXTValue = hdnExpiryDateFormatDDMMYYY.Value == "Y" && AttributeName.Equals("ExpiryDate") ? dt.ToString("dd/MM/yyyy") : dt.ToString("MM/yyyy");
            }
        }

        if (ShowColumn.Equals("0"))
        {
            strSetAttr = " style='display:none'";
        }

        string _validate = "0";
        if (IsMandatory)
        {
            _validate = "1";
        }
        switch (DataType.ToLower())
        {
            case "int":
                setAttr += " onkeypress='SetKeypress(event);' ";
                if (!string.IsNullOrEmpty(TXTValue))
                {
                    try
                    {
                        TXTValue = Convert.ToDecimal(TXTValue).ToString("0.00");
                    }
                    catch (Exception ec)
                    {
                        CLogger.LogError("Error while executing GetTextBox in UpdateStockReceivedByCategory", ec);
                        TXTValue = "0.00";
                    }
                }
                break;

            case "decimal":
                setAttr += " onkeypress='SetKeypress(event);' ";
                if (!string.IsNullOrEmpty(TXTValue))
                {
                    try
                    {
                        if (AttributeName.Equals("RakNo"))
                        {
                            TXTValue = TXTValue.ToString();
                        }
                        else
                        {
                            TXTValue = Convert.ToDecimal(TXTValue).ToString("0.00");
                        }
                    }
                    catch (Exception ec)
                    {
                        CLogger.LogError("Error while executing GetTextBox in UpdateStockReceivedByCategory", ec);
                        TXTValue = "0.00";
                        
                    }
                }
                break;

            default:
                break;
        }
        if (AttributeName.Equals("Comments"))
        {
            setAttr += " style='width:100px;height:40px;'";
        }
        else
        {
            setAttr += " style='width:50px;'";
        }
        return "<td " + strSetAttr + " align='center'><input" + setAttr + " Validate='" + _validate + "' type='text' id='" + Guid.NewGuid() + "'  Attr='" + AttributeName.Trim() + '~' + ID + "' value='" + TXTValue + "' /></td>";
    }

    protected string GetChktBox(string ID, string AttributeName, string CHKValue, bool IsMandatory, string ShowColumn)
    {
        string strSetAttr = string.Empty;
        string _validate = "0";
        if (IsMandatory)
        {
            _validate = "1";
        }
        if (ShowColumn.Equals("0"))
        {
            strSetAttr = " style='display:none'";
        }
        if (CHKValue.Equals("1"))
        {
            return "<td " + strSetAttr + " align='center'><input Validate='" + _validate + "' style='width:50px;' checked='checked' type='checkbox'  id='" + Guid.NewGuid() + "' Attr='" + AttributeName + '~' + ID + "' value='" + CHKValue + "' /></td>";
        }
        else
        {
            return "<td " + strSetAttr + " align='center'><input Validate='" + _validate + "' style='width:50px;' type='checkbox'  id='" + Guid.NewGuid() + "' Attr='" + AttributeName + '~' + ID + "' value='" + CHKValue + "' /></td>";
        }
    }

    protected string GetDropDownList(string ID, string AttributeName, string DDLValue, bool IsMandatory, string pounit, string ShowColumn)
    {
        string sSelect = Resources.CentralReceiving_ClientDisplay.CentralReceiving_UpdateStockReceivedByCategory_aspx_04;
        if (sSelect == null)
        {
            sSelect = "--select--";
        }

        string shortage = Resources.CentralReceiving_ClientDisplay.CentralReceiving_UpdateStockReceivedByCategory_aspx_05;
        if (shortage == null)
        {
            shortage = "shortage";
        }

        string Damage = Resources.CentralReceiving_ClientDisplay.CentralReceiving_UpdateStockReceivedByCategory_aspx_06;
        if (Damage == null)
        {
            Damage = "Damage";
        }

        string Rejected = Resources.CentralReceiving_ClientDisplay.CentralReceiving_UpdateStockReceivedByCategory_aspx_07;
        if (Rejected == null)
        {
            Rejected = "Rejected";
        }

        string strSetAttr = string.Empty;
        GetUnites();
        string strDDL = string.Empty;
        string _validate = "0";
        if (IsMandatory)
        {
            _validate = "1";
        }
        if (ShowColumn.Equals("0"))
        {
            strSetAttr = " style='display:none'";
        }
        if (AttributeName.Equals("StockStatus"))
        {
            _validate = "0";
        }
        strDDL += "<td " + strSetAttr + " align='center'><select Validate='" + _validate + "' style='width:50px;' id='" + Guid.NewGuid() + "'  Attr='" + AttributeName + '~' + ID + "'>";
        strDDL += "<option value='0'>sSelect</option>";
        string strSetSelect = string.Empty;
        switch (AttributeName)
        {
            case "StockStatus":
                if (pounit.Equals("1"))
                {
                    strDDL += "<option selected='selected' value='" + "1" + "'>" + shortage + "</option>";
                }
                else
                {
                    strDDL += "<option value='" + "1" + "'>" + shortage + "</option>";
                }
                if (pounit.Equals("2"))
                {
                    strDDL += "<option selected='selected' value='" + "2" + "'>" + Damage + "</option>";
                }
                else
                {
                    strDDL += "<option value='" + "2" + "'>" + Damage + "</option>";
                }
                if (pounit.Equals("3"))
                {
                    strDDL += "<option selected='selected' value='" + "3" + "'>" + Rejected + "</option>";
                }
                else
                {
                    strDDL += "<option value='" + "3" + "'>" + Rejected + "</option>";
                }
                break;

            default:
                foreach (InventoryUOM option in lstInventoryUOM)
                {
                    if (option.UOMCode.Equals(pounit))
                    {
                        strSetSelect = "selected='selected'";
                    }
                    strDDL += "<option " + strSetSelect + "  value='" + option.UOMCode + "'>" + option.UOMCode + "</option>";
                    strSetSelect = string.Empty;
                }
                break;
        }
        strDDL += "</select></td>";
        return strDDL;
    }

    private void GetUnites()
    {
        InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        inventoryBL.GetInventoryUOM(out lstInventoryUOM);
    }

    protected string DefaultHeader()
    {
        string ProductName = Resources.CentralReceiving_ClientDisplay.CentralReceiving_UpdateStockReceivedByCategory_aspx_08;
        if (ProductName == null)
        {
            ProductName = "Product Name";
        }

        string POQty = Resources.CentralReceiving_ClientDisplay.CentralReceiving_UpdateStockReceivedByCategory_aspx_09;
        if (POQty == null)
        {
            POQty = "PO Qty";
        }

        string POUnit = Resources.CentralReceiving_ClientDisplay.CentralReceiving_UpdateStockReceivedByCategory_aspx_10;
        if (POUnit == null)
        {
            POUnit = "PO Unit";
        }

        string RECUnit = Resources.CentralReceiving_ClientDisplay.CentralReceiving_UpdateStockReceivedByCategory_aspx_11;
        if (RECUnit == null)
        {
            RECUnit = "REC Unit";
        }

        string strHeader = string.Empty;
        strHeader += "<tr class='thRow' >";
        strHeader += "<th class='dataheader1'>ProductName</th>";
        strHeader += "<th class='dataheader1'>POQty</th>";
        strHeader += "<th class='dataheader1'>POUnit</th>";
        strHeader += "<th class='dataheader1'>RECUnit</th>";
        strHeader += "<th class='dataheader1'>LSU</th>";
        return strHeader;
    }


    public void GetReceivedItems(out List<InventoryItemsBasket> lstReceivedItemsBasket, out List<StockReceivedAttributesDetails> lstSRAD)
    {
        lstReceivedItemsBasket = new List<InventoryItemsBasket>();
        lstSRAD = new List<StockReceivedAttributesDetails>();
        StockReceivedAttributesDetails objSRAD;
        foreach (string listParent in hdnProductList.Value.Split('|'))
        {
            if (!string.IsNullOrEmpty(listParent))
            {
                InventoryItemsBasket newBasket = new InventoryItemsBasket();
                string[] listChild = listParent.Split('^');
                foreach (string row in listChild)
                {
                    if (!string.IsNullOrEmpty(row))
                    {
                        
                        switch (row.Split('*')[0].Split('~')[0])
                        {
                            case "ID":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.ID = Convert.ToInt64(row.Split('*')[1]);
                                }
                                break;

                            case "ProductID":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.ProductID = Convert.ToInt64(row.Split('*')[1]);
                                }
                                break;

                            case "CategoryID":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.CategoryID = Convert.ToInt16(row.Split('*')[1]);
                                }
                                break;

                            case "POQuantity":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.POQuantity = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;

                            case "POUnit":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.POUnit = row.Split('*')[1];
                                }
                                break;

                            case "RECUnit":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.RECUnit = row.Split('*')[1];
                                }
                                break;

                            case "RECQuantity":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.RECQuantity = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;

                            case "Manufacture":
                                if (!string.IsNullOrEmpty(row.Split('*')[1].Trim())&& row.Split('*')[1].Trim() != "_/_")
                                {
                                    newBasket.Manufacture = Convert.ToDateTime(row.Split('*')[1]);
                                }
                                break;

                            case "BatchNo":
                                if (string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.BatchNo = "*";
                                }
                                else
                                {
                                    newBasket.BatchNo = row.Split('*')[1];
                                }
                                break;

                            case "ExpiryDate":
                                if (!string.IsNullOrEmpty(row.Split('*')[1].Trim())&& row.Split('*')[1].Trim() != "_/_")
                                {
                                    newBasket.ExpiryDate = Convert.ToDateTime(row.Split('*')[1]);
                                }
                                break;

                            case "Discount":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.Discount = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;

                            case "Type":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.Amount = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;

                            case "Rate":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    //if (Convert.ToDecimal(row.Split('*')[1]) > 0 && newBasket.InvoiceQty > 0)
                                    //{
                                    //    newBasket.Rate = Convert.ToDecimal(row.Split('*')[1]) / newBasket.InvoiceQty;
                                    //}
                                    //else
                                    //{
                                    //    newBasket.Rate = Convert.ToDecimal("0.00");
                                    //}
                                }
                                break;

                            case "SellingUnit":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.SellingUnit = row.Split('*')[1];
                                }
                                break;

                            case "InvoiceQty":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.InvoiceQty = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;

                            case "RcvdLSUQty":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.RcvdLSUQty = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;

                            case "AttributeDetail":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.AttributeDetail = row.Split('*')[1];
                                }
                                break;

                            case "UnitCostPrice":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    //newBasket.UnitCostPrice = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;


                            case "UnitPrice":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.UnitCostPrice = Convert.ToDecimal(row.Split('*')[1]);
                                    if (!string.IsNullOrEmpty(listParent))
                                    {
                                        int lngInvoiceQty = listParent.IndexOf("InvoiceQty");
                                        string strInvoiceQty = string.Empty;
                                        if (lngInvoiceQty > 0)
                                        {
                                            strInvoiceQty = listParent.Substring(lngInvoiceQty);
                                        }
                                        string[] getInvoiceQty = strInvoiceQty.Split('^');
                                        if (!string.IsNullOrEmpty(getInvoiceQty[0].Split('*')[1]) && Convert.ToDecimal(getInvoiceQty[0].Split('*')[1]) > 0)
                                        {
                                            newBasket.UnitPrice = newBasket.UnitCostPrice / Convert.ToDecimal(getInvoiceQty[0].Split('*')[1]);
                                        }
                                        else
                                        {
                                            newBasket.UnitPrice = newBasket.UnitCostPrice;
                                        }
                                    }
                                }
                                break;


                            case "UnitSellingPrice":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    //newBasket.UnitSellingPrice = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;

                            case "RakNo":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.RakNo = row.Split('*')[1];
                                }
                                break;

                            case "MRP":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.MRP = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;

                            case "ActualAmount":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.ActualAmount = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;

                            case "Tax":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.Tax = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;

                            case "ComplimentQTY":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.ComplimentQTY = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;

                            case "LSUnit":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.LSUnit = row.Split('*')[1];
                                    newBasket.SellingUnit = row.Split('*')[1];
                                }
                                break;

                            case "SellingPrice":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.UnitSellingPrice = Convert.ToDecimal(row.Split('*')[1]);
                                    if (!string.IsNullOrEmpty(listParent))
                                    {
                                        int lngInvoiceQty = listParent.IndexOf("InvoiceQty");
                                        string strInvoiceQty = string.Empty;
                                        if (lngInvoiceQty > 0)
                                        {
                                            strInvoiceQty = listParent.Substring(lngInvoiceQty);
                                        }
                                        string[] getInvoiceQty = strInvoiceQty.Split('^');
                                        if (!string.IsNullOrEmpty(getInvoiceQty[0].Split('*')[1]) && Convert.ToDecimal(getInvoiceQty[0].Split('*')[1]) > 0)
                                            
										 {
                                            newBasket.Rate = newBasket.UnitSellingPrice / Convert.ToDecimal(getInvoiceQty[0].Split('*')[1]);
                                        }
                                        else
                                        {
                                            newBasket.Rate = newBasket.UnitSellingPrice;
                                        }
                                    }
                                }
                                break;

                            case "StockStatus":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.StockStatus = int.Parse(row.Split('*')[1]);
                                }
                                break;


                            case "Shortage":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.Shortage = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;

                            case "Damage":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.Damage = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;

                            case "Rejected":
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    newBasket.Rejected = Convert.ToDecimal(row.Split('*')[1]);
                                }
                                break;


                            case "Comments":
                                if (!string.IsNullOrEmpty(row.Split('*')[1].Trim()))
                                {
                                    newBasket.Comments = row.Split('*')[1].Trim();
                                }
                                break;

                            default:
                                objSRAD = new StockReceivedAttributesDetails();
                                objSRAD.StockReceivedDetailsId = newBasket.ProductID;
                                if (!string.IsNullOrEmpty(row.Split('*')[0].Split('~')[1]))
                                {
                                    objSRAD.CategorieMappingID = Convert.ToInt16(row.Split('*')[0].Split('~')[1]);
                                }
                                if (!string.IsNullOrEmpty(row.Split('*')[1]))
                                {
                                    objSRAD.AttributesValue = row.Split('*')[1];
                                }
                                objSRAD.OrgID = OrgID;
                                objSRAD.CreatedBy = LID;
                                lstSRAD.Add(objSRAD);
                                break;
                        }
                    }
                }
                string ProductKey = string.Empty;
                string CurrentCulture = string.Empty;
                CurrentCulture = CultureInfo.CurrentCulture.Name;
                if (!CurrentCulture.Equals("en-GB"))
                {
                    Attune_InventoryProductKey.GenerateProductKey(newBasket.ProductID, newBasket.BatchNo, newBasket.ExpiryDate, newBasket.UnitPrice, newBasket.Rate, newBasket.SellingUnit, CurrentCulture, out ProductKey);
                    if (ProductKey != "")
                    {
                        newBasket.ProductKey = ProductKey;
                    }
                }
                else
                {
                    newBasket.ProductKey = newBasket.ProductID + "@#$" + newBasket.BatchNo + "@#$" + newBasket.ExpiryDate.ToString("MMM/yyyy")
                                   + "@#$" + String.Format("{0:0.000000}", newBasket.UnitPrice) + "@#$" + String.Format("{0:0.000000}", newBasket.Rate) + "@#$" + newBasket.SellingUnit;
                }
                if (string.IsNullOrEmpty(newBasket.BatchNo))
                {
                    newBasket.BatchNo = "*";
                }
                lstReceivedItemsBasket.Add(newBasket);
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        List<InventoryItemsBasket> lstReceivedItemsBasket = new List<InventoryItemsBasket>();
        List<StockReceivedAttributesDetails> lstSRAD = new List<StockReceivedAttributesDetails>();

        StockReceived objStockReceived = new StockReceived();
        objStockReceived.PurchaseOrderNo = purchaseOrderNo;

        if (!string.IsNullOrEmpty(txtReceivedDate.Text.Trim()))
        {
            objStockReceived.StockReceivedDate = txtReceivedDate.Text.ToInternalDate();
        }
        else
        {
            objStockReceived.StockReceivedDate = DateTimeNow;
        }
        if (!string.IsNullOrEmpty(hdnSupplierID.Value))
        {
            objStockReceived.SupplierID = Convert.ToInt32(hdnSupplierID.Value);
        }
        objStockReceived.Comments = txtComments.Text.Trim();
        objStockReceived.OrgID = OrgID;
        objStockReceived.OrgAddressID = ILocationID;
        objStockReceived.ToLocationID = InventoryLocationID;
        objStockReceived.FromLocationID = InventoryLocationID;
        objStockReceived.CreatedBy = LID;
        if (txtInvoiceNo.Text != null && !string.IsNullOrEmpty(txtInvoiceNo.Text))
        {
            objStockReceived.InvoiceNo = txtInvoiceNo.Text.Trim();
        }

        if (txtInvoiceDate.Text != null && !string.IsNullOrEmpty(txtInvoiceDate.Text))
        {
            objStockReceived.InvoiceDate = txtInvoiceDate.Text.ToInternalDate();
        }
        else
        {
            objStockReceived.InvoiceDate = DateTime.MaxValue;
        }
        if (txtDCNumber.Text.Trim() != null && !string.IsNullOrEmpty(txtDCNumber.Text.Trim()))
        {
            objStockReceived.DCNumber = txtDCNumber.Text.Trim();
        }
        if (!string.IsNullOrEmpty(txtTaxAmt.Text.Trim()))
        {
            objStockReceived.Tax = Convert.ToDecimal(txtTaxAmt.Text.Trim());
        }
        objStockReceived.StockReceivedTypeID = (int)StockReceivedTypes.FromSupplier;
        if (!string.IsNullOrEmpty(txtTotalDiscount.Text.Trim()))
        {
            objStockReceived.PODiscountAmount = Convert.ToDecimal(txtTotalDiscount.Text);
        }
        if (!string.IsNullOrEmpty(txtDiscountAmt.Text.Trim()))
        {
            objStockReceived.Discount = Convert.ToDecimal(txtDiscountAmt.Text);
        }
        if (!string.IsNullOrEmpty(txtNetTotal.Text.Trim()))
        {
            objStockReceived.GrandTotal = Convert.ToDecimal(txtNetTotal.Text.Trim());
        }
        objStockReceived.Status = StockOutFlowStatus.Approved;
        GetStatusID((int)StockTypeName.StockReceived, StockOutFlowStatus.Approved, out StatusID);
        objStockReceived.StatusID = StatusID;
        objStockReceived.PurchaseOrderID = Convert.ToInt64(hdnPOID.Value);
        objStockReceived.UsedCreditAmount = Convert.ToDecimal(txtUseCreditAmount.Text);
        if (!string.IsNullOrEmpty(txtRoundOffValue.Text.Trim()))
        {
            objStockReceived.RoundOfValue = Convert.ToDecimal(txtRoundOffValue.Text.Trim());
        }
        if (!string.IsNullOrEmpty(txtTotaltax.Text.Trim()))
        {
            decimal ssTaxAmount = 0;
            objStockReceived.SupServiceTax = Convert.ToDecimal(txtTotaltax.Text.Trim());
            if (objStockReceived.SupServiceTax > 0 && !string.IsNullOrEmpty(txtNetTotal.Text.Trim()))
            {
                ssTaxAmount = Convert.ToDecimal(txtNetTotal.Text.Trim()) * objStockReceived.SupServiceTax / 100;
            }
            objStockReceived.SupServiceTaxAmount = ssTaxAmount;
        }
        if (!string.IsNullOrEmpty(Request.QueryString["PONO"]))
        {
            longStockReceivedID = Convert.ToInt64(Request.QueryString["PONO"]);
            StockReceivedID = Convert.ToInt64(Request.QueryString["PONO"]);
        }
        else
        {
            if (!string.IsNullOrEmpty(Request.QueryString["ID"]))
            {
                longStockReceivedID = Convert.ToInt64(Request.QueryString["ID"]);
                StockReceivedID = Convert.ToInt64(Request.QueryString["ID"]);
            }

        }
        objStockReceived.StockReceivedID = longStockReceivedID;

        if (!string.IsNullOrEmpty(txtPackingSale.Text.Trim()))
        {
            objStockReceived.PackingSale = Convert.ToDecimal(txtPackingSale.Text.Trim());
        }
        if (!string.IsNullOrEmpty(txtExciseDuty.Text.Trim()))
        {
            objStockReceived.ExciseDuty = Convert.ToDecimal(txtExciseDuty.Text.Trim());
        }
        if (!string.IsNullOrEmpty(txtEduCess.Text.Trim()))
        {
            objStockReceived.EduCess = Convert.ToDecimal(txtEduCess.Text.Trim());
        }
        if (!string.IsNullOrEmpty(txtSecCess.Text.Trim()))
        {
            objStockReceived.SecCess = Convert.ToDecimal(txtSecCess.Text.Trim());
        }
        if (!string.IsNullOrEmpty(txtCST.Text.Trim()))
        {
            objStockReceived.CST = Convert.ToDecimal(txtCST.Text.Trim());
        }

        if (!string.IsNullOrEmpty(Request.QueryString["RuleID"]))
        {
            RuleID = Convert.ToInt32(Request.QueryString["RuleID"]);
        }

        GetReceivedItems(out lstReceivedItemsBasket, out lstSRAD);
        long returnCode = -1;
        InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        SupplierName = ddlSupplier.SelectedItem.Text;
        if (!string.IsNullOrEmpty(hdnStockReceivedNo.Value))
        {
            StockReceivedNo = hdnStockReceivedNo.Value;
        }
        if (Request.QueryString["tid"] != null)
        {
            CurrentTaskID = Convert.ToInt64(Request.QueryString["tid"]);
        }
        int POrgID = Convert.ToInt32(OrgID);

        returnCode = new CentralReceiving_BL(base.ContextInfo).UpdateCentralStockReceived(lstReceivedItemsBasket, objStockReceived, lstSRAD, StockReceivedID, StockReceivedNo, purchaseOrderNo, (int)StockTypeName.StockReceived,
            StatusID, out TaskID, purchaseOrderNo, CurrentTaskID, out ActionID, out SeqNo, SupplierName, RuleID, POrgID);
        if (returnCode >= 0)
        {
            if (CurrentTaskID > 0)
            {
                new Tasks_BL(base.ContextInfo).UpdateTask(Convert.ToInt64(Request.QueryString["tid"]), TaskHelper.TaskStatus.Completed, UID);
            }
            if (!longStockReceivedID.Equals(0))
            {
                Response.Redirect("ViewStockReceivedByCategory.aspx?ID=" + longStockReceivedID, true);
            }
        }
    }

    protected void SetTaxType(List<StockReceived> lstTaxType)
    {
        if (!string.IsNullOrEmpty(lstTaxType[0].PackingSale.ToString()))
        {
            txtPackingSale.Text = lstTaxType[0].PackingSale.ToString();
        }

        if (!string.IsNullOrEmpty(lstTaxType[0].ExciseDuty.ToString()))
        {
            txtExciseDuty.Text = lstTaxType[0].ExciseDuty.ToString();
        }

        if (!string.IsNullOrEmpty(lstTaxType[0].EduCess.ToString()))
        {
            txtEduCess.Text = lstTaxType[0].EduCess.ToString();
        }

        if (!string.IsNullOrEmpty(lstTaxType[0].SecCess.ToString()))
        {
            txtSecCess.Text = lstTaxType[0].SecCess.ToString();
        }

        if (!string.IsNullOrEmpty(lstTaxType[0].CST.ToString()))
        {
            txtCST.Text = lstTaxType[0].CST.ToString();
        }
    }


    public void GetStatusID(int StockTypeID, string Status, out int StatusID)
    {
        long returnCode = -1;
        StatusID = 0;
        try
        {
            InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            returnCode = inventoryBL.GetStockStatus(OrgID, LanguageCode, out lstStockStatus, out lstStockType);

            lstStockStatus1 = lstStockStatus.FindAll(P => (P.StockTypeID == StockTypeID) && (P.StockStatusName == Status));
            if (lstStockStatus1.Count == 1)
            {
                StatusID = lstStockStatus1[0].StockStatusID;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetStatusID", ex);
        }
    }


    public void GetStatus(int StockTypeID, int StatusID, out string Status)
    {
        long returnCode = -1;
        Status = "";
        try
        {
            InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            returnCode = inventoryBL.GetStockStatus(OrgID, LanguageCode, out lstStockStatus, out lstStockType);

            lstStockStatus1 = lstStockStatus.FindAll(P => (P.StockTypeID == StockTypeID) && (P.StockStatusID == StatusID));
            if (lstStockStatus1.Count == 1)
            {
                Status = lstStockStatus1[0].StockStatusName;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetStatus", ex);
        }
    }
    public string GetInventoryConfigDetailsValue(string configKey, int orgID, int OrgAddressID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        Configuration_BL objGateway = new Configuration_BL(new Attune_BaseClass().ContextInfo);
        List<InventoryConfig> lstConfig = null;
        returncode = objGateway.GetInventoryConfigDetails(configKey, orgID, OrgAddressID, out lstConfig);
        if (lstConfig !=null && lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;
        return configValue;
    }
}

