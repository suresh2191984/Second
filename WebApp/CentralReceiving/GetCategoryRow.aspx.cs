using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.CentralReceiving.BL;
using Attune.Kernel.InventoryCommon;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.BL;


public partial class CentralReceiving_GetCategoryRow : Attune_BasePage
{
    public CentralReceiving_GetCategoryRow()

        : base("CentralReceiving_GetCategoryRow_aspx")
    {}

    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    string ProductList, SupplierID, Comments, OrgID, ILocationID
        , InventoryLocationID, LID, InvoiceNo, DCNumber, Tax, Discount
        , GrandTotal, UsedCreditAmount, RoundOfValue, PurchaseOrderNo,
     PackingSale, ExciseDuty, EduCess, SecCess, CST, POID, SupplierName, SupplierServiceTax, PoDiscount, SupplierServiceTaxAmount = string.Empty, InvoiceDate, CalculationType, ReceivedDate = string.Empty;
    List<StockStatus> lstStockStatus = new List<StockStatus>();
    List<StockStatus> lstStockStatus1 = new List<StockStatus>();
    List<StockType> lstStockType = new List<StockType>();
    long TaskID = 0, CurrentTaskID = 0;//, ID = 0;
    int StatusID = 0, ActionID = 0, SeqNo = 0;
    string ApprovelConfigValue = string.Empty;
    string StockReceivedNo = "0";

    protected void Page_Load(object sender, EventArgs e)
    {
        SetActionByType();
    }

    protected void SetActionByType()
    {
        int intcategoryID = 0;
        int intproductID = 0;
        if (!string.IsNullOrEmpty(Request.QueryString["categoryID"]) && !string.IsNullOrEmpty(Request.QueryString["productID"]))
        {
            intcategoryID = int.Parse(Request.QueryString["categoryID"]);
            intproductID = int.Parse(Request.QueryString["productID"]);
            List<InventoryItemsBasket> lstInventoryItemsBasket = (List<InventoryItemsBasket>)Session["lstInventoryItemsBasket"];
            List<StockReceiveByCategory> lstStockReceiveByCategory = (List<StockReceiveByCategory>)Session["lstStockReceiveByCategory"];
            if (lstInventoryItemsBasket != null && lstInventoryItemsBasket.Count > 0
               && lstStockReceiveByCategory != null && lstStockReceiveByCategory.Count > 0)
            {
                List<InventoryItemsBasket> lstIB = lstInventoryItemsBasket.FindAll(P => (P.CategoryID == intcategoryID && P.ProductID == intproductID));
                if (lstIB != null && lstIB.Count > 0)
                {
                    Response.Write(StockRow(lstIB, lstStockReceiveByCategory));
                }
            }
        }
        else if (!string.IsNullOrEmpty(Request.QueryString["Save"]))
        {
            if (!string.IsNullOrEmpty(Request.QueryString["ProductList"]))
            {
                ProductList = Request.QueryString["ProductList"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["SupplierID"]))
            {
                SupplierID = Request.QueryString["SupplierID"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["Comments"]))
            {
                Comments = Request.QueryString["Comments"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["POrgID"]))
            {
                OrgID = Request.QueryString["POrgID"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["OrgAddressID"]))
            {
                ILocationID = Request.QueryString["OrgAddressID"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["ToLocationID"]))
            {
                InventoryLocationID = Request.QueryString["ToLocationID"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["CreatedBy"]))
            {
                LID = Request.QueryString["CreatedBy"];
            }

            if (Request.QueryString["InvoiceNo"] != null && !string.IsNullOrEmpty(Request.QueryString["InvoiceNo"]))
            {
                InvoiceNo = Request.QueryString["InvoiceNo"];
            }

            if (Request.QueryString["InvoiceDate"] != null && !string.IsNullOrEmpty(Request.QueryString["InvoiceDate"]))
            {
                InvoiceDate = Request.QueryString["InvoiceDate"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["DCNumber"]))
            {
                DCNumber = Request.QueryString["DCNumber"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["Tax"]))
            {
                Tax = Request.QueryString["Tax"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["Discount"]))
            {
                Discount = Request.QueryString["Discount"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["GrandTotal"]))
            {
                GrandTotal = Request.QueryString["GrandTotal"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["UsedCreditAmount"]))
            {
                UsedCreditAmount = Request.QueryString["UsedCreditAmount"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["RoundOfValue"]))
            {
                RoundOfValue = Request.QueryString["RoundOfValue"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["PurchaseOrderNo"]))
            {
                PurchaseOrderNo = Request.QueryString["PurchaseOrderNo"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["PackingSale"]))
            {
                PackingSale = Request.QueryString["PackingSale"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["ExciseDuty"]))
            {
                ExciseDuty = Request.QueryString["ExciseDuty"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["EduCess"]))
            {
                EduCess = Request.QueryString["EduCess"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["SecCess"]))
            {
                SecCess = Request.QueryString["SecCess"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["CST"]))
            {
                CST = Request.QueryString["CST"];
            }
            if (!string.IsNullOrEmpty(Request.QueryString["POID"]))
            {
                POID = Request.QueryString["POID"];
            }

            if (!string.IsNullOrEmpty(Request.QueryString["SName"]))
            {
                SupplierName = Request.QueryString["SName"];
            }
            if (Request.QueryString["tid"] != null)
            {
                CurrentTaskID = Convert.ToInt64(Request.QueryString["ID"]);
            }
            if (Request.QueryString["SupplierServiceTax"] != null)
            {
                SupplierServiceTax = Request.QueryString["SupplierServiceTax"];
            }
            if (Request.QueryString["PoDiscount"] != null)
            {
                PoDiscount = Request.QueryString["PoDiscount"];
            }
            if (Request.QueryString["SupplierServiceTaxAmount"] != null)
            {
                SupplierServiceTaxAmount = Request.QueryString["SupplierServiceTaxAmount"];
            }
            if (Request.QueryString["CalculationType"] != null)
            {
                CalculationType = Request.QueryString["CalculationType"];
            }
            if (Request.QueryString["ReceivedDate"] != null)
            {
                ReceivedDate = Request.QueryString["ReceivedDate"];
            }

            SaveItems(ProductList, SupplierID, Comments, OrgID, ILocationID, InventoryLocationID, LID, InvoiceNo, DCNumber, Tax, Discount
        , GrandTotal, UsedCreditAmount, RoundOfValue, PurchaseOrderNo, PackingSale, ExciseDuty, EduCess, SecCess, CST, POID, SupplierName, SupplierServiceTax, PoDiscount, SupplierServiceTaxAmount, InvoiceDate, CalculationType, ReceivedDate);
        }

    }

    protected StringBuilder StockRow(List<InventoryItemsBasket> lstIIB, List<StockReceiveByCategory> lstStockReceiveByCategory)
    {
        string strSetAttr = string.Empty;
        string strCategoryName = string.Empty;
        StringBuilder sbBody = new StringBuilder();
        StringBuilder sb = new StringBuilder();
        foreach (InventoryItemsBasket row in lstIIB)
        {
            sbBody.Append("<tr class='trRow'>");
            sbBody.Append("<td align='center'><span class='ProductName' Validate='0' CategoryID='" + row.CategoryID + "' ProductID='" + row.ProductID + "'>" + row.ProductName + "</span></td>");
            sbBody.Append("<td align='center'><span id='" + Guid.NewGuid() + "' class='POQuantity' Validate='0' Attr='POQuantity'>" + row.POQuantity + "</span></td>");
            sbBody.Append("<td align='center'><span id='" + Guid.NewGuid() + "' Validate='0' class='POUnit' Attr='POUnit'>" + row.POUnit + "</span></td>");
            sbBody.Append("<td align='center'><span id='" + Guid.NewGuid() + "' Validate='0' class='RECUnit' Attr='RECUnit'>" + row.POUnit + "</span></td>");
            sbBody.Append("<td align='center'><span id='" + Guid.NewGuid() + "' Validate='0' class='LSUnit' Attr='LSUnit'>" + row.SellingUnit + "</span></td>");
            List<StockReceiveByCategory> lstSRC = lstStockReceiveByCategory.FindAll(P => (P.ProductID == row.ProductID));
            if (lstSRC != null && lstSRC.Count > 0)
            {
                string getCategories = string.Empty;
                foreach (StockReceiveByCategory childRow in lstSRC)
                {
                    if (childRow.AttributeName == "POQuantity" || childRow.AttributeName == "POUnit" || childRow.AttributeName == "ProductName")
                    {

                    }
                    else
                    {
                        strSetAttr = string.Empty;
                        switch (childRow.ControlName.ToLower())
                        {
                            case "textbox":
                                string txtValue = string.Empty;
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
                                try
                                {
                                    var v2 = row.GetType().GetProperty(childRow.AttributeName).GetValue(row, null);
                                    ddlValue = v2.ToString();
                                }
                                catch (Exception)
                                {

                                }
                                getCategories = GetDropDownList(childRow.CategorieMappingID.ToString(), childRow.AttributeName, childRow.ControlValue, childRow.IsMandatory, row.POUnit, childRow.ShowColumn);
                                sbBody.Append(getCategories);
                                break;

                            case "button":
                                string btnValue = string.Empty;
                                try
                                {
                                    var v2 = row.GetType().GetProperty(childRow.AttributeName).GetValue(row, null);
                                    btnValue = v2.ToString();
                                }
                                catch (Exception)
                                {
                                    btnValue = " Delete ";
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
        }
        sb.Append(sbBody);
        return sb;
    }

    protected string GetAttributes(string AttributeName)
    {
        string setAttr = string.Empty;
        switch (AttributeName)
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
                setAttr = " class='TAX' onkeyup='CalculateTotalCost(this)' maxlength='6' ";
                break;

            case "InvoiceQty":
                setAttr = " class='InvoiceQty' onkeyup='CalculateTotalCost(this)' maxlength='6' ";
                break;

            case "Manufacture":
                // setAttr = " class='Manufacture'";
                setAttr = " class='monthYearPicker'";
                break;

            case "ExpiryDate":
                // setAttr = " class='ExpiryDate'";
                setAttr = " class='monthYearPicker'";
                break;

            case "RcvdLSUQty":
                setAttr = " class='RcvdLSUQty'";
                break;

            //case "UnitPrice":
            case "UnitCostPrice":
                setAttr = " class='UnitPrice'";
                break;

            case "Action":
                setAttr = " class='btn' onclick='RemoveRow(this);' ";
                break;

            case "BatchNo":
                setAttr = " class='BatchNo' ";
                break;

            case "LSUnit":
                setAttr = " class='LSUnit' onchange='ChkInverseQty(this);' ";
                break;

            case "ComplimentQTY":
                setAttr = " class='ComplimentQTY' ";
                break;

            case "MRP":
                setAttr = " class='MRP'";
                break;

            case "SellingPrice":
                setAttr = " class='SellingPrice'";
                break;

            case "DefectiveQty":
                setAttr = " class='DefectiveQty'";
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
                if (!string.IsNullOrEmpty(TXTValue))
                {
                    try
                    {
                        TXTValue = Convert.ToDecimal(TXTValue).ToString("0.00");
                    }
                    catch (Exception ec)
                    {
                        CLogger.LogError("Error while executing GetTextBox in GetCategoryRow", ec);
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
                        TXTValue = Convert.ToDecimal(TXTValue).ToString("0.00");
                    }
                    catch (Exception ec)
                    {
                        CLogger.LogError("Error while executing GetTextBox in GetCategoryRow", ec);
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
        return "<td " + strSetAttr + " align='center'><input id='" + Guid.NewGuid() + "' " + setAttr + " Validate='" + _validate + "' type='text' Attr='" + AttributeName + '~' + ID + "' value='" + TXTValue + "' /></td>";
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
        return "<td " + strSetAttr + " align='center'><input id='" + Guid.NewGuid() + "' Validate='" + _validate + "' style='width:50px;' type='checkbox' Attr='" + AttributeName + '~' + ID + "' value='" + CHKValue + "' /></td>";
    }

    protected string GetDropDownList(string ID, string AttributeName, string DDLValue, bool IsMandatory, string pounit, string ShowColumn)
    {
        string sSelect = Resources.CentralReceiving_ClientDisplay.CentralReceiving_GetCategoryRow_aspx_01;
        if (sSelect == null)
        {
            sSelect = "--select--";
        }

        string shortage = Resources.CentralReceiving_ClientDisplay.CentralReceiving_GetCategoryRow_aspx_02;
        if (shortage == null)
        {
            shortage = "shortage";
        }

        string Damage = Resources.CentralReceiving_ClientDisplay.CentralReceiving_GetCategoryRow_aspx_03;
        if (Damage == null)
        {
            Damage = "Damage";
        }

        string Rejected = Resources.CentralReceiving_ClientDisplay.CentralReceiving_GetCategoryRow_aspx_04;
        if (Rejected == null)
        {
            Rejected = "Rejected";
        }

        GetUnites();
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
        strDDL += "<td " + strSetAttr + " align='center'><select id='" + Guid.NewGuid() + "' Validate='" + _validate + "' style='width:50px;' Attr='" + AttributeName + '~' + ID + "'>";
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
            string strMinus = "<img id='" + Guid.NewGuid() + "' Validate='" + _validate + "' onclick='RemoveRow(this);' alt='Remove' title='Remove' width='20' height='20' src='../Images/T_Minus.png' />";
            return "<td " + strSetAttr + " align='center'>" + strMinus + "</td>";
        }
        else
        {
            return "<td " + strSetAttr + " align='center'><input " + setAttr + " id='" + Guid.NewGuid() + "' Validate='" + _validate + "' style='width:50px;' type='button' Attr='" + AttributeName + '~' + ID + "' value='" + BtnValue + "' /></td>";
        }
    }

    private void GetUnites()
    {
        InventoryCommon_BL inventoryBL = new InventoryCommon_BL();
        inventoryBL.GetInventoryUOM(out lstInventoryUOM);
    }

    public void SaveItems(string ProductList, string SupplierID, string Comments, string OrgID, string ILocationID
        , string InventoryLocationID, string LID, string InvoiceNo, string DCNumber, string Tax, string Discount
        , string GrandTotal, string UsedCreditAmount, string RoundOfValue, string PurchaseOrderNo
         , string PackingSale, string ExciseDuty, string EduCess, string SecCess, string CST
        , string POID, string SupplierName, string SupplierServiceTax, string PoDiscount, string SupplierServiceTaxAmount, string InvoiceDate, string CalculationType, string ReceivedDate)
    {
        List<InventoryItemsBasket> lstReceivedItemsBasket = new List<InventoryItemsBasket>();
        List<StockReceivedAttributesDetails> lstSRAD = new List<StockReceivedAttributesDetails>();

        // Supplier Details
        StockReceived objStockReceived = new StockReceived();
        if (ReceivedDate != null && !string.IsNullOrEmpty(ReceivedDate))
        {
            objStockReceived.StockReceivedDate = ReceivedDate.ToInternalDateTime();
        }
        else
        {
            objStockReceived.StockReceivedDate = DateTimeNow;
        }
        if (!string.IsNullOrEmpty(SupplierID))
        {
            objStockReceived.SupplierID = Convert.ToInt32(SupplierID);
        }
        if (Comments != null)
        {
            objStockReceived.Comments = Comments;
        }
        if (!string.IsNullOrEmpty(OrgID))
        {
            objStockReceived.OrgID = int.Parse(OrgID);
        }
        if (!string.IsNullOrEmpty(ILocationID))
        {
            objStockReceived.OrgAddressID = int.Parse(ILocationID);
        }
        if (!string.IsNullOrEmpty(InventoryLocationID))
        {
            objStockReceived.ToLocationID = int.Parse(InventoryLocationID);
            objStockReceived.FromLocationID = int.Parse(InventoryLocationID);
        }
        if (!string.IsNullOrEmpty(LID))
        {
            objStockReceived.CreatedBy = int.Parse(LID);
        }
        if (InvoiceNo != null && !string.IsNullOrEmpty(InvoiceNo))
        {
            objStockReceived.InvoiceNo = InvoiceNo;
        }

        if (InvoiceDate != null && !string.IsNullOrEmpty(InvoiceDate))
        {
            objStockReceived.InvoiceDate = InvoiceDate.ToInternalDate();
        }
        else
        {
            objStockReceived.InvoiceDate = DateTime.MaxValue;
        }
        if (DCNumber != null && !string.IsNullOrEmpty(DCNumber))
        {
            objStockReceived.DCNumber = DCNumber;
        }
        if (!string.IsNullOrEmpty(Tax))
        {
            objStockReceived.Tax = Convert.ToDecimal(Tax);
        }
        objStockReceived.StockReceivedTypeID = (int)StockReceivedTypes.FromSupplier;
        if (!string.IsNullOrEmpty(Discount))
        {
            objStockReceived.Discount = Convert.ToDecimal(Discount);
        }
        if (!string.IsNullOrEmpty(GrandTotal))
        {
            objStockReceived.GrandTotal = Convert.ToDecimal(GrandTotal);
        }
        objStockReceived.Status = StockOutFlowStatus.Pending;

        string barcodeMapping=Request.QueryString["BarCodeMapping"] != null?Request.QueryString["BarCodeMapping"].ToString():"N";
        if (barcodeMapping.ToUpper()=="Y")
        {
            GetStatusID((int)StockTypeName.BarCodeMapping, StockOutFlowStatus.Pending, out StatusID);
        }
        else
        {
        GetStatusID((int)StockTypeName.StockReceived, StockOutFlowStatus.Pending, out StatusID);
        }
        objStockReceived.StatusID = StatusID;
        objStockReceived.PurchaseOrderID = Convert.ToInt64(POID);
        objStockReceived.UsedCreditAmount = Convert.ToDecimal(UsedCreditAmount);
        if (!string.IsNullOrEmpty(RoundOfValue))
        {
            objStockReceived.RoundOfValue = Convert.ToDecimal(RoundOfValue);
        }
        //objStockReceived.RoundOfType = hdnRoundofType.Value;
        //objStockReceived.InvoiceDate = DateTime.MaxValue;
        objStockReceived.PurchaseOrderNo = PurchaseOrderNo;

        if (!string.IsNullOrEmpty(PackingSale))
        {
            objStockReceived.PackingSale = Convert.ToDecimal(PackingSale);
        }
        if (!string.IsNullOrEmpty(ExciseDuty))
        {
            objStockReceived.ExciseDuty = Convert.ToDecimal(ExciseDuty);
        }
        if (!string.IsNullOrEmpty(EduCess))
        {
            objStockReceived.EduCess = Convert.ToDecimal(EduCess);
        }
        if (!string.IsNullOrEmpty(SecCess))
        {
            objStockReceived.SecCess = Convert.ToDecimal(SecCess);
        }
        if (!string.IsNullOrEmpty(CST))
        {
            objStockReceived.CST = Convert.ToDecimal(CST);
        }
        if (!string.IsNullOrEmpty(SupplierServiceTax))
        {
            objStockReceived.SupServiceTax = Convert.ToDecimal(SupplierServiceTax);
        }
        if (!string.IsNullOrEmpty(SupplierServiceTax))
        {
            objStockReceived.SupServiceTax = Convert.ToDecimal(SupplierServiceTax);
        }
        if (!string.IsNullOrEmpty(SupplierServiceTaxAmount))
        {
            objStockReceived.SupServiceTaxAmount = Convert.ToDecimal(SupplierServiceTaxAmount);
        }
        if (!string.IsNullOrEmpty(PoDiscount))
        {
            objStockReceived.PODiscountAmount = Convert.ToDecimal(PoDiscount);
        }
        if (CalculationType != null && !string.IsNullOrEmpty(CalculationType))
        {
            objStockReceived.NetCalcTax = CalculationType;
        }
        // Product List
        GetReceivedItems(ProductList, out lstReceivedItemsBasket, out lstSRAD);
        int loginid = Convert.ToInt32(Session["LID"].ToString());
        int pOrgID = Convert.ToInt32(OrgID);
        long StockReceivedID = -1;
        CentralReceiving_BL inventoryBL = new CentralReceiving_BL(new Attune_BaseClass().ContextInfo);
        if (GetInventoryConfigDetailsValue("BarCodeMappingBeforeStockReceiveApproval", int.Parse(OrgID), 0).Equals("Y") && barcodeMapping.ToUpper() == "Y")
        {
            inventoryBL.SavecentralStockReceivedDetails(objStockReceived, lstReceivedItemsBasket, lstSRAD, out StockReceivedID, out StockReceivedNo, (int)StockTypeName.BarCodeMapping, StatusID, out TaskID, CurrentTaskID, out ActionID, out SeqNo, SupplierName, pOrgID, loginid);
        }
        else
        {
        inventoryBL.SavecentralStockReceivedDetails(objStockReceived, lstReceivedItemsBasket, lstSRAD, out StockReceivedID, out StockReceivedNo, (int)StockTypeName.StockReceived, StatusID, out TaskID, CurrentTaskID, out ActionID, out SeqNo, SupplierName, pOrgID, loginid);
        }
        Response.Write(StockReceivedID + "||");
    }


    public void GetReceivedItems(string ProductList, out List<InventoryItemsBasket> lstReceivedItemsBasket, out List<StockReceivedAttributesDetails> lstSRAD)
    {
        lstReceivedItemsBasket = new List<InventoryItemsBasket>();
        lstSRAD = new List<StockReceivedAttributesDetails>();
        StockReceivedAttributesDetails objSRAD;
        foreach (string listParent in ProductList.Split('|'))
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
                                if (!string.IsNullOrEmpty(row.Split('*')[1]) && row.Split('*')[1].Trim() != "_/_")
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
                                if (!string.IsNullOrEmpty(row.Split('*')[1]) && row.Split('*')[1].Trim() != "_/_")
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
                                    // newBasket.UnitCostPrice = Convert.ToDecimal(row.Split('*')[1]);
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
                                    //   newBasket.UnitSellingPrice = Convert.ToDecimal(row.Split('*')[1]);
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
                                 //objSRAD.OrgID = int.Parse(Request.QueryString["OrgID"]);
                                objSRAD.OrgID = int.Parse(OrgID);
                                objSRAD.CreatedBy = int.Parse(Request.QueryString["CreatedBy"]);
                                lstSRAD.Add(objSRAD);
                                break;
                        }
                    }
                }
                //string ProductKey = string.Empty;
                //string CurrentCulture = string.Empty;
                //CurrentCulture = CultureInfo.CurrentCulture.Name;
                //if (!CurrentCulture.Equals("en-GB"))
                //{
                //    Attune_InventoryProductKey.GenerateProductKey(newBasket.ProductID, newBasket.BatchNo, newBasket.ExpiryDate, newBasket.UnitPrice, newBasket.Rate, newBasket.SellingUnit, CurrentCulture, out ProductKey);
                //    if (ProductKey != "")
                //    {
                //        newBasket.ProductKey = ProductKey;
                //    }
                //}
                //else
                //{
                //    newBasket.ProductKey = newBasket.ProductID + "@#$" + newBasket.BatchNo + "@#$" + newBasket.ExpiryDate.ToString("MMM/yyyy")
                //                   + "@#$" + String.Format("{0:0.000000}", newBasket.UnitPrice) + "@#$" + String.Format("{0:0.000000}", newBasket.Rate) + "@#$" + newBasket.SellingUnit;
                //}
                lstReceivedItemsBasket.Add(newBasket);
            }
        }
    }


    public void GetStatusID(int StockTypeID, string Status, out int StatusID)
    {
        long returnCode = -1;
        StatusID = 0;
        try
        {
            InventoryCommon_BL inventoryBL = new InventoryCommon_BL(new Attune_BaseClass().ContextInfo);
            returnCode = inventoryBL.GetStockStatus(Convert.ToInt32(OrgID), LanguageCode, out lstStockStatus, out lstStockType);

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

