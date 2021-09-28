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
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.CentralReceiving.BL;


public partial class CentralReceiving_CentralStockReceivedByCategory : Attune_BasePage
{
    public CentralReceiving_CentralStockReceivedByCategory()

        : base("CentralReceiving_CentralStockReceivedByCategory_aspx")
    {}
    string purchaseOrderNo = string.Empty;
    string ordereddate = string.Empty;
    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    List<StockStatus> lstStockStatus = new List<StockStatus>();
    List<StockStatus> lstStockStatus1 = new List<StockStatus>();
    List<StockType> lstStockType = new List<StockType>();
    //long TaskID = 0,  ID = 0, POID = 0;
    long CurrentTaskID = 0;
    //int StockTypeID = 0, StatusID = 0, ActionID = 0, SeqNo = 0;
    string ApprovelConfigValue = string.Empty;
    string SupplierName = string.Empty;
    string StockReceivedNo = "0";
	List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
   
    string IsEditTaxRate = "N";
    string IsAttributeConfig = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
            Suppliers();
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Stock_Receive_Approval", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    ApprovelConfigValue = "Y";
                }
                else
                {
                    ApprovelConfigValue = "N";
                }
            }

            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedCompQtyCalculation", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {

                hdnREQCalcCompQTY.Value = lstInventoryConfig[0].ConfigValue;
            }

            if (!string.IsNullOrEmpty(Request.QueryString["orderdate"]))
            {
                ordereddate = Request.QueryString["orderdate"].ToString();
            }
            if (!string.IsNullOrEmpty(Request.QueryString["PONO"]))
            {
                LoadStockCategories(Request.QueryString["PONO"]);
            }
            if (Request.QueryString["tid"] != null)
            {
                CurrentTaskID = Convert.ToInt64(Request.QueryString["ID"]);
            }
            GetUnites();
            SetValues();
            string HideTaxOpbilling = GetConfigValue("IsMiddleEast", OrgID);
            if (HideTaxOpbilling == "Y")
            {

                trSupplierServiceTax.Style.Add("display", "none");
                trTotalTaxAmount.Style.Add("display", "none");
            }               
            //hdnbarCodeMapping.Value = GetInventoryConfigDetailsValue("BarCodeMappingBeforeStockReceiveApproval",OrgID, 0)=="Y"?"Y":"N";
            hdnExpiryDateFormatDDMMYYY.Value = GetInventoryConfigDetailsValue("StockReceiveExpirydateFormatDD/MM/YYYY", OrgID, 0) == "Y" ? "Y" : "N";
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
        ddlSupplier.Items.Insert(0, ddlselect);
        ddlSupplier.Items[0].Value = "0";
    }

    protected void LoadStockCategories(string PONO)
    {
        int supplierID = 0;
        long returnCode = -1;
        purchaseOrderNo = PONO;

        InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        List<InventoryItemsBasket> lstInventoryItemsBasket1 = new List<InventoryItemsBasket>();
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        List<Suppliers> lstSuppliers = new List<Suppliers>();
        List<InventoryItemsBasket> lstTempSrd = new List<InventoryItemsBasket>();
        List<SupplierCreditorDebitNote> lstSCDN = new List<SupplierCreditorDebitNote>();
        List<StockReceiveByCategory> lstStockReceiveByCategory = new List<StockReceiveByCategory>();
        List<Taxmaster> lstTaxmaster = new List<Taxmaster>();
        returnCode = new CentralReceiving_BL(base.ContextInfo).GetCentralStockReceivedByCategory(OrgID, ILocationID, InventoryLocationID, purchaseOrderNo, supplierID, ordereddate,
            out lstSuppliers, out lstInventoryItemsBasket1, out lstTempSrd, out lstSCDN, out lstInventoryItemsBasket, out lstStockReceiveByCategory, out lstTaxmaster);

        Session["lstInventoryItemsBasket"] = lstInventoryItemsBasket;
        Session["lstStockReceiveByCategory"] = lstStockReceiveByCategory;
        if (lstSuppliers != null && lstSuppliers[0].CFormType)
        {
            divNotification.Style.Add("display", "block");
        }

        if (lstSCDN.Count != 0)
        {
            hdnAvailableCreditAmount.Value = Convert.ToString(lstSCDN[0].CreditAmount - lstSCDN[0].UsedAmount);
            txtAvailCreditAmount.Text = Convert.ToString(lstSCDN[0].CreditAmount - lstSCDN[0].UsedAmount);
        }

        else
        {
            hdnAvailableCreditAmount.Value = "0.00";
        }

        //var tempbarcodemapping = from ITB in lstInventoryItemsBasket1
        //                         where ITB.Description.Split('|')[15] == "Y"
        //                         select ITB;
        //List<InventoryItemsBasket> lstInventoryItemswithBarCode = tempbarcodemapping.ToList<InventoryItemsBasket>();
        //if (lstInventoryItemswithBarCode.Count > 0)
        //{
        //    hdnbarCodeMapping.Value = GetInventoryConfigDetailsValue("BarCodeMappingBeforeStockReceiveApproval", OrgID, 0) == "Y" ? "Y" : "N";
        //}

        txtPurchaseOrderNo.Text = lstSuppliers[0].ContactPerson;
        hdnSupplierID.Value = lstSuppliers[0].SupplierID.ToString();
        ddlSupplier.SelectedValue = lstSuppliers[0].SupplierID.ToString();
        txtReceivedDate.Text = DateTimeNow.ToExternalDateTime();
        hdnSupplierName.Value = ddlSupplier.SelectedItem.Text;
        hdnPOID.Value = lstSuppliers[0].ParentSupplierID.ToString();
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
        if (IsNeededTaxValue == "Y" && lstSuppliers[0].PIN.Equals(StateID.ToString()))
        {
            hdnFlag.Value = "1";
            Session["SuppliersPIN"] = "1";
        }
        else
        {
            hdnFlag.Value = "0";
            Session["SuppliersPIN"] = "0";
        }

         
        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "CP1", "ChangeCalculation_load('CP');", true);
        
        hdnGetTaxList.Value = string.Empty;
        if (lstTaxmaster != null && lstTaxmaster.Count > 0)
        {
            JavaScriptSerializer objJSS = new JavaScriptSerializer();
            hdnGetTaxList.Value = objJSS.Serialize(lstTaxmaster);
        }

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
                    sb.Append(StockRow(lstIB, lstStockReceiveByCategory));
                }
            }
            else
            {
                sb.Append(StockRow(lstInventoryItemsBasket, lstStockReceiveByCategory));
            }

              
            
        }
        divStockReceived.InnerHtml = string.Empty;
        divStockReceived.InnerHtml = sb.ToString();
       
    }

    protected StringBuilder StockRow(List<InventoryItemsBasket> lstIIB, List<StockReceiveByCategory> lstStockReceiveByCategory)
    {
        string strSetAttr = string.Empty;
        string strCategoryName = string.Empty;
        StringBuilder sbHeadStart = new StringBuilder();
        StringBuilder sbBody = new StringBuilder();
        StringBuilder sb = new StringBuilder();
        int i = 1;
        sbHeadStart.Append(DefaultHeader());
        foreach (InventoryItemsBasket row in lstIIB)
        {
            sbBody.Append("<tr class='trRow'>");
            if(IsAttributeConfig=="Y")
              sbBody.Append("<td align='center'><span class='ProductName w-100p' Validate='0' CategoryID='" + row.CategoryID + "' ProductID='" + row.ProductID + "'>" + row.ProductName + "("+row.CategoryName+")</span></td>");
            else
                sbBody.Append("<td align='center'><span class='ProductName w-100p' Validate='0' CategoryID='" + row.CategoryID + "' ProductID='" + row.ProductID + "'>" + row.ProductName + "</span></td>");
            sbBody.Append("<td align='center'><span id='" + Guid.NewGuid() + "' class='POQuantity' Validate='0' ASRQty='" + row.RECQuantity + "' Attr='POQuantity' >" + row.POQuantity + "</span></td>");
            sbBody.Append("<td align='center'><span id='" + Guid.NewGuid() + "' Validate='0' class='POUnit' Attr='POUnit'>" + row.POUnit + "</span></td>");
            sbBody.Append("<td align='center'><span id='" + Guid.NewGuid() + "' Validate='0' class='RECUnit' Attr='RECUnit'>" + row.POUnit + "</span></td>");
            sbBody.Append("<td align='center'><span id='" + Guid.NewGuid() + "' Validate='0' class='LSUnit' Attr='LSUnit'>" + row.SellingUnit + "</span></td>");
            List<StockReceiveByCategory> lstSRC = lstStockReceiveByCategory.FindAll(P => (P.ProductID == row.ProductID));
            if (lstSRC != null && lstSRC.Count > 0)
            {
                string getCategories = string.Empty;
                foreach (StockReceiveByCategory childRow in lstSRC.OrderBy(P=>P.SeqNo))
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
                                    var v2 = row.GetType().GetProperty(childRow.AttributeName).GetValue(row, null);
                                    txtValue = v2.ToString();
                                }
                                catch (Exception)
                                {

                                }
                                getCategories = GetTextBox(childRow.CategorieMappingID.ToString(), childRow.AttributeName, txtValue, childRow.IsMandatory, childRow.ShowColumn, childRow.DataType);
                                sbBody.Append(getCategories);

                                break;

                            case "checkbox":
                                string chkValue = string.Empty;
                                if (i == lstIIB.Count)
                                {
                                    if (childRow.ShowColumn.Equals("0"))
                                    {
                                        strSetAttr = " style='display:none'";
                                    }
                                    sbHeadStart.Append("<th " + strSetAttr + " class='dataheader1'>" + childRow.DisplayText + "</th>");
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
                                    if (childRow.ShowColumn.Equals("0"))
                                    {
                                        strSetAttr = " style='display:none'";
                                    }
                                    sbHeadStart.Append("<th " + strSetAttr + " class='dataheader1'>" + childRow.DisplayText + "</th>");
                                }
                                try
                                {
                                    var v2 = row.GetType().GetProperty(childRow.AttributeName).GetValue(row, null);
                                    ddlValue = v2.ToString();
                                }
                                catch (Exception)
                                {

                                }
                                getCategories = GetDropDownList(childRow.CategorieMappingID.ToString(), childRow.AttributeName, childRow.ControlValue, childRow.IsMandatory, row.LSUnit, childRow.ShowColumn);
                                sbBody.Append(getCategories);
                                break;

                            case "button":
                                string btnValue = string.Empty;
                                if (i == lstIIB.Count)
                                {
                                    if (childRow.ShowColumn.Equals("0"))
                                    {
                                        strSetAttr = " style='display:none'";
                                    }
                                    sbHeadStart.Append("<th " + strSetAttr + " class='dataheader1'>" + childRow.DisplayText + "</th>");
                                }
                                try
                                {
                                    var v2 = row.GetType().GetProperty(childRow.AttributeName).GetValue(row, null);
                                    btnValue = v2.ToString();
                                }
                                catch (Exception)
                                {
                                    btnValue = " ADD ";
                                }
                                getCategories = GetButton(childRow.CategorieMappingID.ToString(), childRow.AttributeName, btnValue, childRow.IsMandatory, childRow.ShowColumn);
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
        if(IsAttributeConfig=="N")
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

           // case "UnitCostPrice":
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
                if (Session["SuppliersPIN"] == "0"  && IsEditTaxRate =="N")
                {
                    setAttr = " class='TAX' onkeyup='CalculateTotalCost(this)' maxlength='6' ";
                }
                else
                {
                    setAttr = " class='TAX' onkeyup='CalculateTotalCost(this)' maxlength='6'  disabled='disabled' ";
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
                 // setAttr = " class='Manufacture'";
                setAttr = " class='monthYearPicker'";
                break;

            case "RcvdLSUQty":
                setAttr = " class='RcvdLSUQty' onkeyup='CalculateTotalCost(this)'";
                break;

           // case "UnitPrice":
			case "UnitCostPrice":
                setAttr = " class='UnitPrice' onkeyup='CalculateTotalCost(this)'";
                break;

            case "Action":
                setAttr = " class='btn' ";
                break;

            case "BatchNo":
                setAttr = " class='BatchNo' ";
                break;

            case "LSUnit":
                setAttr = " class='LSUnit' onchange='ChkInverseQty(this);' ";
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

            case "MRP":
                setAttr = " class='MRP'  onkeyup='CalculateTotalCost(this)' ";
                break;

            case "SellingPrice":
                setAttr = " class='SellingPrice' onkeyup='CalculateTotalCost(this)'";
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
                
            case "UnitSellingPrice":
                setAttr = " class='UnitSellingPrice'";
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
            if (dt.ToString("yyyy").Equals("9999") || dt.ToString("yyyy").Equals("0001"))
            {
                TXTValue = string.Empty;
            }
            else
            {
                TXTValue = dt.ToString("MM/yyyy");
            }
        }
        string _validate = "0";
        if (IsMandatory)
        {
            _validate = "1";
        }

        if (ShowColumn.Equals("0"))
        {
            strSetAttr = " style='display:none'";
        }

        switch (DataType.ToLower())
        {
            case "int":
                setAttr += " onkeypress='SetKeypress(event);' ";
                try
                {
                    TXTValue = Convert.ToDecimal(TXTValue).ToString("0.00");
                }
                catch (Exception ec)
                {
                    CLogger.LogError("Error while executing GetTextBox in CentralStockReceivedByCategory", ec);
                    TXTValue = "0.00";
                }
                break;

            case "decimal":
                setAttr += " onkeypress='SetKeypress(event);' ";
                try
                {
                    TXTValue = Convert.ToDecimal(TXTValue).ToString("0.00");
                    if (AttributeName.Equals("InvoiceQty"))
                    {
                       // TXTValue = "1.00";
                    }
                }
                catch (Exception ec)
                {
                    CLogger.LogError("Error while executing GetTextBox in CentralStockReceivedByCategory", ec);
                    TXTValue = "0.00";
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
        return "<td " + strSetAttr + " align='center'><input id='" + Guid.NewGuid() + "' " + setAttr + " Validate='" + _validate + "' type='text' Attr='" + AttributeName.Trim() + '~' + ID + "' value='" + TXTValue + "' /></td>";
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
        return "<td " + strSetAttr + " align='center'><input id='" + Guid.NewGuid() + "' Validate='" + _validate + "' style='width:50px;' type='button' Attr='" + AttributeName + '~' + ID + "' value='" + CHKValue + "' /></td>";
    }

    protected string GetDropDownList(string ID, string AttributeName, string DDLValue, bool IsMandatory, string pounit, string ShowColumn)
    {
        string sSelect = Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_06;
        if (sSelect == null)
        {
            sSelect = "--select--";
        }

        string shortage = Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_07;
        if (shortage == null)
        {
            shortage = "shortage";
        }

        string Damage = Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_08;
        if (Damage == null)
        {
            Damage = "Damage";
        }

        string Rejected = Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_09;
        if (Rejected == null)
        {
            Rejected = "Rejected";
        }

        GetUnites();
        string strAtrr = GetAttributes(AttributeName);
        string strSetAttr = string.Empty;
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
        strDDL += "<td " + strSetAttr + " align='center'><select " + strAtrr + " id='" + Guid.NewGuid() + "' Validate='" + _validate + "' style='width:50px;' Attr='" + AttributeName + '~' + ID + "'>";
        strDDL += "<option value='0'>sSelect</option>";
        string strSetSelect = string.Empty;
        switch (AttributeName)
        {
            case "StockStatus":
                strDDL += "<option value='" + "1" + "'>" + shortage + "</option>";
                strDDL += "<option value='" + "2" + "'>" + Damage + "</option>";
                strDDL += "<option value='" + "3" + "'>" + Rejected + "</option>";
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

    protected string GetButton(string ID, string AttributeName, string BtnValue, bool IsMandatory, string ShowColumn)
    {
        string strSetAttr = string.Empty;
        string setAttr = GetAttributes(AttributeName);
        string _validate = "0";
        if (ShowColumn.Equals("0"))
        {
            strSetAttr = " style='display:none'";
        }
        if (AttributeName.Equals("Action"))
        {
            string strAdd = "<img style='float:left;' id='" + Guid.NewGuid() + "' Validate='" + _validate + "' onclick='AddNewRow(this);' alt='Add' title='ADD' width='18' height='20' src='../PlatForm/Images/T_Plus.png' />";
            //string strMinus = "<img id='" + Guid.NewGuid() + "' Validate='" + _validate + "' onclick='RemoveRow(this);' alt='Remove' title='Remove' width='18' height='20' src='../PlatForm/Images/T_Minus.png' />";
            string strMinus = string.Empty;
            return "<td " + strSetAttr + " >" + strAdd + " " + strMinus + "</td>";
        }
        else
        {
            return "<td " + strSetAttr + " align='center'><input " + setAttr + " id='" + Guid.NewGuid() + "' Validate='" + _validate + "' style='width:50px;' type='button' Attr='" + AttributeName + '~' + ID + "' value='" + BtnValue + "' /></td>";
        }
    }

    private void GetUnites()
    {
        InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);

        inventoryBL.GetInventoryUOM(out lstInventoryUOM);

    }

    protected string DefaultHeader()
    {
        string ProductName = Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_10;
        if (ProductName == null)
        {
            ProductName = "Product Name";
        }

        string POQty = Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_11;
        if (POQty == null)
        {
            POQty = "PO Qty";
        }

        string POUnit = Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_12;
        if (POUnit == null)
        {
            POUnit = "PO Unit";
        }

        string RECUnit = Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_13;
        if (RECUnit == null)
        {
            RECUnit = "REC Unit";
        }
        string LSU = Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_14 == null ? "LSU" : Resources.CentralReceiving_ClientDisplay.CentralReceiving_CentralStockReceivedByCategory_aspx_14;
        string strHeader = string.Empty;
        strHeader += "<tr class='thRow' >";
        strHeader += "<th class='dataheader1'>" + ProductName + "</th>";
        strHeader += "<th class='dataheader1'>" + POQty + "</th>";
        strHeader += "<th class='dataheader1'>" + POUnit + "</th>";
        strHeader += "<th class='dataheader1'>" + RECUnit + "</th>";
        strHeader += "<th class='dataheader1'>" + LSU + "</th>";
        return strHeader;
    }


    protected void SetValues()
    {
        hdnOrgID.Value = OrgID.ToString();
        hdnILocationID.Value = ILocationID.ToString();
        hdnInventoryLocationID.Value = InventoryLocationID.ToString();
        hdnLID.Value = LID.ToString();
        hdnFromSupplier.Value = ((int)StockReceivedTypes.FromSupplier).ToString();
        hdnStockOutFlowStatus.Value = StockOutFlowStatus.Pending;
        
    }

    protected void btnRedirect_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(hdnSRID.Value) && !hdnSRID.Value.Equals("0"))
        {
            Response.Redirect("../CentralReceiving/ViewStockReceivedByCategory.aspx?ID=" + hdnSRID.Value);
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
    public string GetInventoryConfigDetailsValue(string configKey, int orgID, int OrgAddressID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        Configuration_BL objGateway = new Configuration_BL(new Attune_BaseClass().ContextInfo);
        List<InventoryConfig> lstConfig = null;
        returncode = objGateway.GetInventoryConfigDetails(configKey, orgID, OrgAddressID, out lstConfig);
        if (lstConfig!=null && lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;
        return configValue;
    }
}
