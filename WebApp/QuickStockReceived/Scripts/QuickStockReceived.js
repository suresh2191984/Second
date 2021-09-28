var lstProductList = [];
var CGST = 0;
var SGST = 0;
var IGST = 0;
function IAmSelected(source, eventArgs) {
    //$('#tdheadLSU').removeClass().addClass('show');
   // $('#tdShowLSU').removeClass().addClass('show');
    var arrDBVal = JSON.parse(eventArgs.get_value());
    var pProductID = arrDBVal.ProductID;
    var pProductName = arrDBVal.ProductName;
    var pBatchno = arrDBVal.BatchNo;
    var pManufacture = arrDBVal.Manufacture;
    var pExpDate = arrDBVal.ExpiryDate;
    var pRecQty = arrDBVal.RECQuantity;
    var pRecUnit = arrDBVal.RECUnit;
    var pInverseQty = arrDBVal.InvoiceQty;
    var pSellingUnit = arrDBVal.SellingUnit;
    var pRecLSUQty = arrDBVal.RcvdLSUQty;
    var pCompQty = arrDBVal.ComplimentQTY;
    var pUnitPrice = arrDBVal.UnitPrice;
    var pSellingPrice = arrDBVal.SellingPrice;
    var pDiscount = arrDBVal.Discount;
    var pTax = arrDBVal.Tax;
    var pUnitCostPrice = arrDBVal.UnitCostPrice;
    var pUnitSellingPrice = arrDBVal.UnitSellingPrice;
    var pHasBatch = arrDBVal.HasBatchNo;
    var pHasCostPrice = arrDBVal.HasCostPrice;
    var pHasSellingPrice = arrDBVal.HasSellingPrice;
   
    var pHasExpiry = arrDBVal.HasExpiryDate;
    var pRakNo = arrDBVal.RakNo;
    var pMRP = arrDBVal.MRP;
    var pExTax = arrDBVal.ExciseTax;
    var pParentProductID = arrDBVal.ParentProductID;
    var pNominal = arrDBVal.Nominal; //pNominal
    
    var pSchemeType = arrDBVal.SchemeType;
    var pSchemeDisc = arrDBVal.SchemeDisc;
    var pDiscountType = arrDBVal.DiscountType;
    

    /*GST Start*/
    var pHSNcode = arrDBVal.HSNCode;
    $('#lblhsncode').text(pHSNcode);
    document.getElementById('txtTax').value = pTax;
    if (document.getElementById("CheckState").value == "Y") {
        CGST = pTax / 2;
        SGST = pTax / 2;
        IGST = 0

    }
    else {
        IGST = pTax;
        CGST = 0;
        SGST = 0;
    }
    if ($('#hdnIsVATNotApplicable').val().trim() != "Y")
    {
       $('.ww-300').html('<table class="gsttbl" border="1" rules="all"><tr><td>CGST(%)</td><td>SGST(%)</td><td>IGST(%)</td></tr><tr><td>' + CGST + '</td><td>' + SGST + '</td><td>' + IGST + '</td></tr></table>');
    }
    else{
    $('.ww-300').html('<table class="gsttbl" border="1" rules="all" style="width: 60px;"><tr><td>Tax(%)</td></tr><tr><td>' + pTax + '</td></tr></table>');
    $("#divTaxDetails").css({ 'width': "60px" });
    }
    /*GST END*/

    var lblLSUValue = arrDBVal.LSUnit;
    var pOrderedUnit = arrDBVal.OrderedUnit;
    ConvertOrderUnitList(arrDBVal.OrderedUnitValues, "");
	
    pManufacture = ToInternalDate(pManufacture).format("MM/yyyy");
    pExpDate = ToInternalDate(pExpDate).format("MM/yyyy");
	pManufacture = "";
	pExpDate = "";
	
    document.getElementById('txtRakNo').value = pRakNo;
    document.getElementById('txtTax').value = pTax;
    if (pBatchno != "No Batch Found") {
        document.getElementById('hdnproductId').value = pProductID;
        document.getElementById('hdnProductName').value = arrDBVal.Name;
        document.getElementById('txtBatchNo').value = "";
        document.getElementById('txtMFTDate').value = "";
        document.getElementById('txtEXPDate').value = "";
        if (pHasBatch != "N") {
            document.getElementById('txtBatchNo').value = pBatchno;
        }
        if (pHasExpiry != "N") {
            document.getElementById('txtEXPDate').value = pExpDate;
            document.getElementById('txtMFTDate').value = pManufacture;
        }
        document.getElementById('txtBatchNo').focus();
        document.getElementById('txtRECQuantity').value = pRecQty;
        ToTargetFormatWOR($("#txtRECQuantity"));
        // document.getElementById('ddlRcvdUnit').value = pRecUnit.trim() == "" ? "0" : pRecUnit; pOrderedUnit
        //  document.getElementById('ddlSelling').value = pSellingUnit;
//        document.getElementById('ddlRcvdUnit').value = pOrderedUnit.trim() == "" ? "0" : pOrderedUnit;
//        $('#ddlRcvdUnit option:not(:selected)').prop('disabled', true);
        document.getElementById('ddlSelling').value = lblLSUValue;
        $('#ddlSelling option:not(:selected)').prop('disabled', true); 
        document.getElementById('txtUnitPrice').value = parseFloat(pUnitPrice).toFixed(2);
        ToTargetFormatWOR($("#txtUnitPrice"));
        var pType = document.getElementById('ddlStockReceivedType').options[document.getElementById('ddlStockReceivedType').selectedIndex].text;
        if (pType == 'FreeProduct') {
            document.getElementById('txtUnitPrice').value = 0.00;
            ToTargetFormatWOR($("#txtUnitPrice"));
            document.getElementById('txtUnitPrice').readOnly = true;
        }
        document.getElementById('txtTotalCost').value = 0.00;
        ToTargetFormatWOR($("#txtTotalCost"));
        document.getElementById('txtTotalCost').readOnly = true;

        document.getElementById('txtCompQuantity').value = pCompQty;
        ToTargetFormatWOR($("#txtCompQuantity"));
        document.getElementById('txtTax').value = pTax;
        ToTargetFormatWOR($("#txtTax"));
        document.getElementById('txtDiscount').value = pDiscount;
        ToTargetFormatWOR($("#txtDiscount"));
        document.getElementById('add').value = 'Add';
        document.getElementById('hdnUnitCostPrice').value = pUnitCostPrice;
        ToTargetFormatWOR($("#hdnUnitCostPrice"));
        document.getElementById('hdnUnitSellingPrice').value = pUnitSellingPrice;
        ToTargetFormatWOR($("#hdnUnitSellingPrice"));
        document.getElementById('hdnAdd').value = 'Add';

        document.getElementById('txtSellingPrice').value = parseFloat(pUnitSellingPrice).toFixed(2);
        ToTargetFormatWOR($("#txtSellingPrice"));
        document.getElementById('txtRcvdLSUQty').value = pRecLSUQty;
        ToTargetFormatWOR($("#txtRcvdLSUQty"));
        //document.getElementById('txtInvoiceQty').value = pInverseQty;
        ToTargetFormatWOR($("#txtInvoiceQty"));
        document.getElementById('txtExTax').value = pExTax;
        ToTargetFormatWOR($("#txtExTax"));

        document.getElementById('txtRcvdLSUQty').readOnly = true;
      //  if (pRecUnit == 'Nos') {
       //     document.getElementById('ddlSelling').value = 'Nos';
      //      document.getElementById('txtInvoiceQty').value = 1;
     //       ToTargetFormat($("#txtInvoiceQty"));

    //        document.getElementById('txtInvoiceQty').disabled = true;
     //       document.getElementById('ddlSelling').disabled = true;
            
     //   }
      //  else {

     //       document.getElementById('txtInvoiceQty').disabled = false;
     //       document.getElementById('ddlSelling').disabled = false;
     //   }
        document.getElementById('hdnHasBatchNo').value = pHasBatch;
        document.getElementById('hdnHasCostPrice').value = pHasCostPrice;
        document.getElementById('hdnHasSellingPrice').value = pHasSellingPrice;
        document.getElementById('hdnHasExpiryDate').value = pHasExpiry;
        document.getElementById('txtRakNo').value = pRakNo;
        document.getElementById('txtMRP').value = pMRP;
        document.getElementById('lblLSUValue').innerHTML = lblLSUValue;
        ToTargetFormatWOR($("#txtMRP"));
        document.getElementById('hdnParentProductID').value = pParentProductID;
        document.getElementById('txtNominal').value = pNominal;
        ToTargetFormatWOR($("#txtNominal"));
        TotalCalculation();
    } else {

        document.getElementById('hdnproductId').value = pProductID;
        document.getElementById('hdnProductName').value = arrDBVal.Name;
        document.getElementById('txtBatchNo').value = "";
        document.getElementById('txtBatchNo').focus();
        document.getElementById('txtEXPDate').value = "";
        document.getElementById('txtMFTDate').value = "";
        document.getElementById('txtRECQuantity').value = "";
        //document.getElementById('ddlRcvdUnit').value = pRecUnit.trim() == "" ? "0" : pRecUnit;
//        document.getElementById('ddlRcvdUnit').value = pOrderedUnit.trim() == "" ? "0" : pOrderedUnit;
//        $('#ddlRcvdUnit option:not(:selected)').prop('disabled', true);

        //document.getElementById('ddlSelling').value = pRecUnit.trim() == "" ? "0" : pRecUnit; lblLSUValue
        document.getElementById('ddlSelling').value = lblLSUValue.trim() == "" ? "0" : lblLSUValue;
        $('#ddlSelling option:not(:selected)').prop('disabled', true);
        //document.getElementById('txtInvoiceQty').value = pInverseQty;
        
        document.getElementById('txtUnitPrice').value = "";
        document.getElementById('txtTotalCost').value = "0.00";
        ToTargetFormatWOR($("#txtTotalCost"));
        document.getElementById('txtTotalCost').readOnly = true;
        document.getElementById('txtCompQuantity').value = "";
        document.getElementById('txtTax').value = pTax;
        document.getElementById('txtDiscount').value = "";
        document.getElementById('add').value = 'Add';
        document.getElementById('hdnUnitCostPrice').value = "";
        document.getElementById('hdnUnitSellingPrice').value = "";
        document.getElementById('hdnAdd').value = 'Add';
        document.getElementById('txtSellingPrice').value = "";
        document.getElementById('txtRcvdLSUQty').value = "";
        //document.getElementById('txtInvoiceQty').value = "";
        document.getElementById('txtMRP').value = "";
        document.getElementById('txtExTax').value = "";
        // document.getElementById('txtInvoiceQty').disabled = true;
      //  document.getElementById('ddlSelling').disabled = false;
        document.getElementById('hdnHasBatchNo').value = pHasBatch;
        document.getElementById('hdnHasCostPrice').value = pHasCostPrice;
        document.getElementById('hdnHasSellingPrice').value = pHasSellingPrice;
        
        document.getElementById('hdnHasExpiryDate').value = pHasExpiry;
        document.getElementById('hdnParentProductID').value = pParentProductID;
        document.getElementById('txtNominal').value = "";
        document.getElementById('lblLSUValue').innerHTML = lblLSUValue;
    }
    $('#btnPopUp').removeClass().addClass('btn');
    document.getElementById('hdnType').value = '';
    document.getElementById('btnAddNew').focus();
}
function checkIsEmpty(id) {
    document.getElementById('txtBatchNo').focus();
    var chk = document.getElementById('ChkIsConsign');
    if (document.getElementById('txtProductName').value.trim() == '' && document.getElementById('hdnAdd').value != 'Update') {
        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_17") == null ? "Provide product name" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_17");
        ValidationWindow(userMsg, ErrorMsg);
        document.getElementById('txtProductName').focus();
        return false;
    }
    if (document.getElementById('ddlRcvdUnit').value == 0) {
        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_18") == null ? "Provide the received unit" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_18");
        ValidationWindow(userMsg, ErrorMsg);
        document.getElementById('ddlRcvdUnit').focus();
        return false;
    }
    if (document.getElementById('chkIntax').checked == false && document.getElementById('chkExtax').checked == false) {
        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_19") == null ? "Select the tax calculation with CostPrice or SellingPrice" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_19");
        ValidationWindow(userMsg, ErrorMsg);
        return false;
    }
    if (document.getElementById('hdnHasBatchNo').value == 'Y') {
        if (document.getElementById('txtBatchNo').value == '') {
            if ($('#hdnMandFieldDisable').val() == "Y") {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_20") == null ? "Provide batch number" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_20");
                ValidationWindow(userMsg, ErrorMsg);
                document.getElementById('txtBatchNo').focus();
                return false;
            }
        }
    }

    if (document.getElementById('hdnHasCostPrice').value == 'Y') {
        if (document.getElementById('txtUnitPrice').value == '') {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_24") == null ? "Provide Cost Price" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_24");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtUnitPrice').focus();
            return false;
        }
    }

    if (document.getElementById('hdnHasSellingPrice').value == 'Y') {
        if (document.getElementById('txtSellingPrice').value == '') {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_29") == null ? "Provide Selling Price" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_29");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtSellingPrice').focus();
            return false;
        }
    }
    
    if (document.getElementById('hdnHasExpiryDate').value == 'Y') {
        if (document.getElementById('txtEXPDate').value == '') {
            if ($('#hdnMandFieldDisable').val() == "Y") {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_50") == null ? "Provide Expiry Date" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_50");
                ValidationWindow(userMsg, ErrorMsg);
                document.getElementById('txtEXPDate').focus();
                return false;
            }
        }
    }
    if ($("#hdnCompQty").val() == 'Y') {
        if ((ToInternalFormat($("#txtRECQuantity")) == 0.00) && (ToInternalFormat($("#txtCompQuantity")) == 0.00)) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_21") == null ? "Provide received or ComplimentQuantity" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_21");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtRECQuantity').focus();
            return false;
        }
    }
    else {
        if (ToInternalFormat($("#txtRECQuantity")) == 0.00) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_22") == null ? "Provide received quantity" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_22");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtRECQuantity').focus();
            return false;
        }
    }

    if (document.getElementById('ddlSelling').value == 0) {
        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_23") == null ? "Select selling unit" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_23");
        ValidationWindow(userMsg, ErrorMsg);
        document.getElementById('ddlSelling').focus();
        return false;
    }

    var pType = document.getElementById('ddlStockReceivedType').options[document.getElementById('ddlStockReceivedType').selectedIndex].text;
    if (pType != 'FreeProduct') {
     if (($('hdnisConsignmentStock').val() != 'Y') && chk.checked == false) {
         if (ToInternalFormat($("#txtUnitPrice")) == 0.00) {
             if (document.getElementById('hdnHasCostPrice').value == 'Y') {
                 var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_24") == null ? "Provide cost price" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_24");
                 ValidationWindow(userMsg, ErrorMsg);
                 document.getElementById('txtUnitPrice').focus();
                 return false;
             }
         }        
        }
    }
    if (ToInternalFormat($("#txtInvoiceQty")) == 0.00) {
        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_25") == null ? "Provide invoice qty" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_25");
        ValidationWindow(userMsg, ErrorMsg);
        document.getElementById('txtInvoiceQty').focus();
        return false;
    }
    if ($("#hdnCompQty").val() == 'Y') {
        if (ToInternalFormat($("#txtRcvdLSUQty")) == 0.00 && (ToInternalFormat($("#txtCompQuantity")) == 0.00)) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_26") == null ? "Provide received LSU qty or comp qty" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_26");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtRcvdLSUQty').focus();
            return false;
        }
    }
    else {
        if (ToInternalFormat($("#txtRcvdLSUQty")) == 0.00) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_27") == null ? "Provide received LSU qty" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_27");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtRcvdLSUQty').focus();
            return false;
        }
    }

    /*if (Number(ToInternalFormat($("#txtNominal"))) > Number(ToInternalFormat($("#txtUnitPrice")))) {
        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_28") == null ? "Provide Nominal value less then Cost Price" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_28");
        ValidationWindow(userMsg, ErrorMsg);
        document.getElementById('txtNominal').focus();
        return false;
    }*/
    if (($('hdnisConsignmentStock').val() != 'Y') && chk.checked == false) {
        if (ToInternalFormat($("#txtSellingPrice")) == 0.00) {
            if (document.getElementById('hdnHasSellingPrice').value == 'Y') {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_29") == null ? "Provide Selling Price" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_29");
                ValidationWindow(userMsg, ErrorMsg);
                document.getElementById('txtSellingPrice').focus();
                return false;
            }
        }
    }
    if (($('hdnisConsignmentStock').val() != 'Y') && chk.checked == false) {
        if (ToInternalFormat($("#txtMRP")) == 0.00) {
            if (document.getElementById('hdnHasSellingPrice').value == 'Y') {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_30") == null ? "Provide MRP" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_30");
                ValidationWindow(userMsg, ErrorMsg);
                document.getElementById('txtMRP').focus();
                return false;
            }
        }
    }

    if (Number(ToInternalFormat($("#txtSellingPrice"))) < Number(ToInternalFormat($("#txtUnitPrice")))) {
        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_31") == null ? "Provide Selling Price greater than Cost Price" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_31");
        ValidationWindow(userMsg, ErrorMsg);
        document.getElementById('txtSellingPrice').select();
        return false;
    }

    if (Number(ToInternalFormat($("#txtMRP"))) < Number(ToInternalFormat($("#txtUnitPrice")))) {
        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_32") == null ? "Provide MRP greater than Cost Price" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_32");
        ValidationWindow(userMsg, ErrorMsg);
        document.getElementById('txtMRP').select();
        return false;
    }
    var ExTax = document.getElementById('txtExTax').value;
    var PurchaseTax = document.getElementById('txtPurchaseTax').value;
    if ((ExTax != "" && Number(ToInternalFormat($("#txtExTax"))) > 0) && (PurchaseTax != "" && Number(ToInternalFormat($("#txtPurchaseTax"))) > 0)) {

        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_32") == null ? "Provide any one of Tax. Excess Tax / Purchase Tax" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_32");
        ValidationWindow(userMsg, ErrorMsg);
        return false;
    }
    if (document.getElementById('add').value != 'Update') {

        var pProductId = document.getElementById('hdnproductId').value;
        var pName = document.getElementById('hdnProductName').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        if (pBatchNo == '') {
            pBatchNo = '*';
        }
        var arrF = $.grep(lstProductList, function(n, i) {
            return n.ProductID == pProductId && n.BatchNo == pBatchNo;
        });
        if (arrF.length > 0) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_34") == null ? "Product name and batch number combination already exist" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_34");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtBatchNo').focus();
            return false;
        }
    }
    if (document.getElementById('add').value != 'Update') {
        var pProductId = document.getElementById('hdnproductId').value;
        var pName = document.getElementById('hdnProductName').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        if (pBatchNo == '') {
            pBatchNo = '*';
        }
    }
    $('#tbTotalCost').removeClass().addClass('displaytb w-100p');
   /* No Need to validate based on batchno 
   if (document.getElementById('hdnHasBatchNo').value != 'N') {
        if ($('#txtMFTDate').val() == '') {
            $('#txtMFTDate').val(GetServerDate().format('MM/yyyy'));
            var _flag = CheckDatesMfg(' ', document.getElementById('txtMFTDate'), 'MFG') == true ? CheckDatesExp(' ', document.getElementById('txtEXPDate'), 'EXP') : false;
            $('#txtMFTDate').val('');
            return _flag;
        }
        else {
            return CheckDatesMfg(' ', document.getElementById('txtMFTDate'), 'MFG') == true ? CheckDatesExp(' ', document.getElementById('txtEXPDate'), 'EXP') : false;
        }
    }*/
    return true;
}
function BindProductList() {
    document.getElementById('ddlStockReceivedType').disabled = true;
    $('#tdShowLSU').removeClass().addClass('hide');
    $('#tdheadLSU').removeClass().addClass('hide');
    if (document.getElementById('add').value == 'Update') {
    //changes related to CalCompQty 26:8:2016
        document.getElementById('txtProductName').readOnly = false;
        var editData = JSON.parse($('#hdnRowEdit').val());
        if (editData != "") {
            var arrF = $.grep(lstProductList, function(n, i) {
                //return n.ProductID != editData.ProductID && n.BatchNo != editData.BatchNo;
                if (n.ProductID == editData.ProductID) {
                    return n.BatchNo != editData.BatchNo;
                }
                else if (n.BatchNo == editData.BatchNo) {
                    return n.ProductID != editData.ProductID;
                }
                else {
                    return n.ProductID != editData.ProductID && n.BatchNo != editData.BatchNo;
                }

            });
            lstProductList = [];
            lstProductList = arrF;
        }
    }

    var pProductID = document.getElementById('hdnproductId').value;
    var pProductNamefull =escape(document.getElementById('txtProductName').value);
    var pProductNamesplit = $('#hdnProductName').val();
    var pProductName = $('#hdnProductName').val();
    var pBatchno = document.getElementById('txtBatchNo').value;
    var pManufacture = "";
    var pExpDate = "";
    var pRecQty = $.trim(document.getElementById('txtRECQuantity').value) == "" ? 0 : ToInternalFormat($('#txtRECQuantity'));
    var SplitRecUnit = document.getElementById('ddlRcvdUnit').value.split('~');
    var pRecUnit = SplitRecUnit[0];
    var pInverseQty = $.trim(document.getElementById('txtInvoiceQty').value) == "" ? 1 : ToInternalFormat($('#txtInvoiceQty'));
    var pSellingUnit = document.getElementById('ddlSelling').value;
    var pRecLSUQty = $.trim(document.getElementById('txtRcvdLSUQty').value) == "" ? 0 : ToInternalFormat($('#txtRcvdLSUQty'));
    var pCompQty = $.trim(document.getElementById('txtCompQuantity').value) == "" ? 0 : ToInternalFormat($('#txtCompQuantity'));
    var pUnitPrice = $.trim(document.getElementById('txtUnitPrice').value) == "" ? 0 : ToInternalFormat($('#txtUnitPrice'));
    var pSellingPrice = $.trim(document.getElementById('txtSellingPrice').value) == "" ? 0 : ToInternalFormat($('#txtSellingPrice'));
    var pDiscount = $.trim(document.getElementById('txtDiscount').value) == "" ? 0 : ToInternalFormat($('#txtDiscount'));
    var pTax = $.trim(document.getElementById('txtTax').value) == "" ? 0 : ToInternalFormat($('#txtTax'));
    var pUnitCostPrice = $.trim(document.getElementById('hdnUnitCostPrice').value) == "" ? 0 : ToInternalFormat($('#hdnUnitCostPrice'));
    var pUnitSellingPrice = $.trim(document.getElementById('hdnUnitSellingPrice').value) == "" ? 0 : ToInternalFormat($('#hdnUnitSellingPrice'));
    var pHasBatch = document.getElementById('hdnHasBatchNo').value;
    var pHasExpiry = document.getElementById('hdnHasExpiryDate').value;
    var pTotalCost = $.trim(document.getElementById('txtTotalCost').value) == "" ? 0 : ToInternalFormat($('#txtTotalCost'));
    var pTQty = ToInternalFormat($('#hdnType'));
    var pRakNo = document.getElementById('txtRakNo').value;
    var pMRP = $.trim(document.getElementById('txtMRP').value) == "" ? 0 : ToInternalFormat($('#txtMRP'));
    var pID = $.trim(document.getElementById('hdnID').value) == "" ? 0 : document.getElementById('hdnID').value;
    var pSno = document.getElementById('hdnSno').value
    var pExTax = $.trim(document.getElementById('txtExTax').value) == "" ? 0 : ToInternalFormat($('#txtExTax'));
    var pPurchaseTax = document.getElementById('txtPurchaseTax').value == "" || document.getElementById('txtPurchaseTax').value == undefined ? 0 : ToInternalFormat($('#txtPurchaseTax'));
    var pIsConsign = $('#ChkIsConsign').prop('checked') == true ? 'Y' : 'N';

    var pHasSellingPrice = document.getElementById('hdnHasSellingPrice').value;
    var pHasCostPrice = document.getElementById('hdnHasCostPrice').value;
    
    var pSchemeDiscount = $.trim(document.getElementById('txtSchemeDisc').value) == "" ? 0 : ToInternalFormat($('#txtSchemeDisc'));
    var pSchemeType = document.getElementById('ddlSchemetype').value;
    var pDiscountType = document.getElementById('ddlDisctype').value;
	
    
    if (pBatchno == '') {
        pBatchno = '*';
    }
    if (document.getElementById('txtEXPDate').value == '') {
        pExpDate = "";

    }
    else {
        pExpDate = $('#txtEXPDate').val();
    }    
    if (document.getElementById('txtMFTDate').value == '') {
        pManufacture = "";
    }
    else {
        pManufacture = $('#txtMFTDate').val();
    }
   
    if (pDiscount == "") {
        document.getElementById('txtDiscount').value = '0.00';
		ToTargetFormat($("#txtDiscount"));

    } else {
        document.getElementById('txtDiscount').value = (parseFloat(ToInternalFormat($("#txtDiscount")))).toFixed(2);
		ToTargetFormat($("#txtDiscount"));
    }
    pDiscount = ToInternalFormat($("#txtDiscount"));

    if (pTax == "") {
        document.getElementById('txtTax').value = '0.00';
        ToTargetFormatWOR($("#txtTax"));
    } else {
        document.getElementById('txtTax').value = (parseFloat(ToInternalFormat($("#txtTax")))).toFixed(2);
        ToTargetFormatWOR($("#txtTax"));
    }
    pTax = ToInternalFormat($("#txtTax"));
    if (pCompQty == "") {
        document.getElementById('txtCompQuantity').value = '0.00';
    } else {
        document.getElementById('txtCompQuantity').value = (parseFloat(ToInternalFormat($("#txtCompQuantity")))).toFixed(2);
    }
    pCompQty = ToInternalFormat($("#txtCompQuantity"));
    if (pRakNo.trim() == "") {
        pRakNo = '--';
    }
    var pParentProductID = document.getElementById('hdnParentProductID').value == "0" ? 0 : document.getElementById('hdnParentProductID').value;

    /*var pNominal = $.trim(document.getElementById('txtNominal').value) == "" ? 0 : ToInternalFormat($("#txtNominal"));
    if (pNominal == "") {
        document.getElementById('txtNominal').value = '0.00';

    } else {

        document.getElementById('txtNominal').value = (parseFloat(ToInternalFormat($("#txtNominal")))).toFixed(2);
    }
    pNominal = ToInternalFormat($("#txtNominal"));*/
    
    if($('#hdnIsSchemeDiscount').val() == "N") {
       document.getElementById('txtSchemeDisc').value = '0.00';
    }
    
    if (pSchemeDiscount == "") {
        document.getElementById('txtSchemeDisc').value = '0.00';
		ToTargetFormat($("#txtSchemeDisc"));

    } else {
        document.getElementById('txtSchemeDisc').value = (parseFloat(ToInternalFormat($("#txtSchemeDisc")))).toFixed(2);
		ToTargetFormat($("#txtSchemeDisc"));
    }
    pSchemeDiscount = ToInternalFormat($("#txtSchemeDisc"));
    
    var pNominal = 0;
    var CGSTTax = CGST;
    var SGSTTax = SGST;
    var IGSTTax = IGST;
    var CGSTTaxAmount = parseFloat(parseFloat(parseFloat(CGST) / 100) * (parseFloat(parseFloat(parseFloat(pRecQty) * parseFloat(pUnitPrice)))));
    var SGSTTaxAmount = parseFloat(parseFloat(parseFloat(SGST) / 100) * (parseFloat(parseFloat(parseFloat(pRecQty) * parseFloat(pUnitPrice)))));
    var IGSTTaxAmount = parseFloat(parseFloat(parseFloat(IGST) / 100) * (parseFloat(parseFloat(parseFloat(pRecQty) * parseFloat(pUnitPrice)))));
    var objProduct = new Object();
    objProduct.ProductID = pProductID;
    objProduct.ProductName =escape(pProductName);
    objProduct.BatchNo = pBatchno;
    objProduct.Manufacture = pManufacture;
    objProduct.ExpiryDate = pExpDate;
    objProduct.RECQuantity = pRecQty;
    objProduct.RECUnit = pRecUnit;
    objProduct.InvoiceQty = pInverseQty;
    objProduct.SellingUnit = pSellingUnit;
    objProduct.RcvdLSUQty = pRecLSUQty;
    objProduct.ComplimentQTY = pCompQty;
    objProduct.UnitPrice = pUnitPrice;
    objProduct.SellingPrice = pSellingPrice;
    objProduct.Discount = pDiscount;
    objProduct.Tax = pTax;
    objProduct.UnitCostPrice = pUnitCostPrice;
    objProduct.UnitSellingPrice = pUnitSellingPrice;
    objProduct.HasBatchNo = pHasBatch;
    objProduct.HasExpiryDate = pHasExpiry;
    objProduct.TotalCost = pTotalCost;
    objProduct.TotalQty = pTQty;
    objProduct.RakNo = pRakNo;
    objProduct.MRP = pMRP;
    objProduct.ID = pID;
    objProduct.ExciseTax = pExTax;
    objProduct.ParentProductID = pParentProductID;
    objProduct.Nominal = pNominal;
    objProduct.PurchaseTax = pPurchaseTax;
    objProduct.IsConsign = pIsConsign;
    objProduct.OrderedUnitValues = ddlvalue;
    objProduct.HasSellingPrice = pHasSellingPrice;
    objProduct.HasCostPrice = pHasCostPrice;
    objProduct.CGSTTax = CGSTTax;
    objProduct.SGSTTax = SGSTTax;
    objProduct.IGSTTax = IGSTTax;
    objProduct.DiscountType = pDiscountType;
    objProduct.SchemeType = pSchemeType; 
    objProduct.SchemeDisc = pSchemeDiscount; 
    
    lstProductList.push(objProduct);
    $('#hdnProductList').val(JSON.stringify(lstProductList));
    Tblist();
    var pNo = Number(document.getElementById('hdnSno').value);
    document.getElementById('hdnSno').value = pNo + 1;
    document.getElementById('add').value = 'Add';
    document.getElementById('hdnAdd').value = 'Add';
    var objadd = SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_51") == null ? "Add" : SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_51");
    $('#add').text(objadd);
    clearFields();
    document.getElementById('txtProductName').focus();
    $('.ww-300').html('<table class="gsttbl" border="1" rules="all"><tr><td>CGST(%)</td><td>SGST(%)</td><td>IGST(%)</td></tr><tr><td>0</td><td>0</td><td>0</td></tr></table>');
}

/*function Tblist() {
    $('#lblBatchNo').text(slist.BatchNo);
    $('#lblCostPrice').text(slist.CostPrice);
    $('#lblNominal').text(slist.Nominal);
    $('#lblDiscou').text(slist.Discount);
    $('#lblSellingPrice').text(slist.SellingPrice);
    $('#lblMRP').text(slist.MRP);
    $('#lblRakNo').text(slist.RakNo);
    $('#lblTotalCost').text(slist.TotalCost);
    $('#lblRcvdQty').text(slist.RcvdQty);
    $('#lblselling').text(slist.sellingUnit);
    $('#lblInversQty').text(slist.InverseQty);
    $('#lblRcdLSUQty').text(slist.RcvdQty_lsu);
    $('#lblPurchaseTax').text(slist.PurchaseTax);

    $("#TableCollectedItems tr").remove();
    $('#TableCollectedItems').removeClass().addClass('w-100p responstable font11 marginT10 marginB10');

    var Headrow = document.getElementById('TableCollectedItems').insertRow(0);
    Headrow.id = "HeadID";
    Headrow.className = "bold";
    Headrow.className = "responstableHeader"
    var cell20;
    var cell1 = Headrow.insertCell(0);
    cell1.className = "w-2p";
    var cell2 = Headrow.insertCell(1);
    cell2.className = "w-12p";
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    cell4.className = "w-6p";
    var cell5 = Headrow.insertCell(4);
    var cell6 = Headrow.insertCell(5);
    var cell7 = Headrow.insertCell(6);
    var cell8 = Headrow.insertCell(7);
    var cell9 = Headrow.insertCell(8);
    cell9.className = "w-7p";
    var cell10 = Headrow.insertCell(9);
    var cell11 = Headrow.insertCell(10);
    var cell12 = Headrow.insertCell(11);
    var cell13 = Headrow.insertCell(12);
    cell20 = Headrow.insertCell(13);
    var cell14 = Headrow.insertCell(14);
    var cell15 = Headrow.insertCell(15);
    var cell16 = Headrow.insertCell(16);
    var cell17 = Headrow.insertCell(17);
    var cell18 = Headrow.insertCell(18);
    var cell19 = Headrow.insertCell(19);
    cell19.className = "w-4p";
    cell1.innerHTML = slist.sno;
    cell2.innerHTML = slist.ProductName;
    cell3.innerHTML = slist.BatchNo;
    cell4.innerHTML = slist.Date;
    cell5.innerHTML = slist.RcvdQty;
    cell6.innerHTML = slist.sellingUnit;
    cell7.innerHTML = slist.InverseQty;
    cell8.innerHTML = slist.RcvdQty_lsu;
    cell9.innerHTML = slist.CompQty;
    cell10.innerHTML = slist.CostPrice;
    cell11.innerHTML = slist.Nominal;
    cell12.innerHTML = slist.Discount;
    cell13.innerHTML = slist.Tax;
    cell14.innerHTML = slist.SellingPrice;
    cell15.innerHTML = slist.Ex_percent;
    cell16.innerHTML = slist.MRP;
    cell17.innerHTML = slist.RakNo;
    cell18.innerHTML = slist.TotalCost;
    cell19.innerHTML = slist.Action;
    cell20.innerHTML = slist.PurchaseTax;
    //Tax Hide for Vasan
    if ($("#hdnHideTax").val() == "Y") {
        cell13.hidden = true;
        cell15.hidden = true;
        cell20.hidden = true;
    }
    //Tax Hide for Vasan    

    document.getElementById('lblTotalCostAmount').innerHTML = '0.00';
    ToTargetFormat($("#lblTotalCostAmount"));
    document.getElementById('txtGrandTotal').value = '0.00';
    ToTargetFormat($("#txtGrandTotal"));
    document.getElementById('txtNetTotal').value = '0.00';
    ToTargetFormat($("#txtNetTotal"));
    document.getElementById('txtGrandwithRoundof').value = '0.00';
    ToTargetFormat($("#txtGrandwithRoundof"));
    document.getElementById('txtRoundOffValue').value = '0.00';
    ToTargetFormat($("#txtRoundOffValue"));
    document.getElementById('txtTotalDiscountAmt').value = '0.00';
    ToTargetFormat($("#txtTotalDiscountAmt"));
    document.getElementById('txtTotalTaxAmt').value = '0.00';
    ToTargetFormat($("#txtTotalTaxAmt"));
    
    ToTargetFormat($("#txtTotaltax"));
    ToTargetFormat($("#txtTotalDiscount"));
    document.getElementById('hdnTotalCost').value = '0';
    ToTargetFormat($("#hdnTotalCost"));
    if (Number($('#hdnAvailableCreditAmount').val()) > 0 && ToInternalFormat($('#hdnAvailableCreditAmount')) != '0.00') {
        document.getElementById('txtAvailCreditAmount').value = parseFloat(ToInternalFormat($("#hdnAvailableCreditAmount"))).toFixed(2);
        ToTargetFormat($("#txtAvailCreditAmount"));
    }
    else {
        document.getElementById('txtAvailCreditAmount').value = '0.00';
        ToTargetFormat($("#txtAvailCreditAmount"));
    }
    document.getElementById('txtUseCreditAmount').value = 0.00;
    if (parseFloat(ToInternalFormat($('#hdnAvailableCreditAmount'))) > 0)
        document.getElementById('txtUseCreditAmount').diabled = false;
    else
        document.getElementById('txtUseCreditAmount').disabled = true;

    if (lstProductList.length > 0) {
        document.getElementById('ddlStockReceivedType').disabled = false;
        lstProductList[0].IsConsign=='Y'? $('#ChkIsConsign').prop('checked',true) : $('#ChkIsConsign').prop('checked',false);
    }else{
    $('#ChkIsConsign').prop('checked',false)
    }
    var count = lstProductList.length;
    $.each(lstProductList, function(obj, value) {
        var row = document.getElementById('TableCollectedItems').insertRow(1);
        row.style.height = "13px";
        row.className = "font11-imp"
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var cell5 = row.insertCell(4);
        var cell6 = row.insertCell(5);
        var cell7 = row.insertCell(6);
        var cell8 = row.insertCell(7);
        var cell9 = row.insertCell(8);
        var cell10 = row.insertCell(9);
        var cell11 = row.insertCell(10);
        var cell12 = row.insertCell(11);
        var cell13 = row.insertCell(12);
        cell20 = row.insertCell(13);
        var cell14 = row.insertCell(14);
        var cell15 = row.insertCell(15);
        var cell16 = row.insertCell(16);
        var cell17 = row.insertCell(17);
        var cell18 = row.insertCell(18);
        var cell19 = row.insertCell(19);
        cell19.className="a-center"
        cell1.innerHTML = count;
        cell2.innerHTML =unescape(value.ProductName); //Produt Name
        cell3.innerHTML = value.BatchNo; //Batch No

        var dateMFT = value.Manufacture == "" ? "**" : value.Manufacture;
        var dateEXP = value.ExpiryDate == "" ? "**" : value.ExpiryDate;
        cell4.innerHTML = "<table class='w-100p no-border'><tr><td>MFT :" + dateMFT + "</td></tr><tr><td>EXP :" + dateEXP + "</td></tr></table>";
        //cell4.width = "13%";
        $('#hdnTempValue').val(value.RECQuantity);
        cell5.innerHTML = ToTargetFormat($('#hdnTempValue')) + " (" + value.RECUnit + ")";  // Rev qty + Rev Unit
        cell6.innerHTML = value.SellingUnit;   //Sellling Unit
        $('#hdnTempValue').val(value.InvoiceQty);
        cell7.innerHTML = ToTargetFormat($('#hdnTempValue'));   //Inve Qty
        $('#hdnTempValue').val(value.RcvdLSUQty);
        cell8.innerHTML = ToTargetFormat($('#hdnTempValue'));  // Revd qty(LSU)
        $('#hdnTempValue').val(value.ComplimentQTY);
        cell9.innerHTML = ToTargetFormat($('#hdnTempValue'));  // Comp qty
        $('#hdnTempValue').val(value.UnitPrice);
        cell10.innerHTML = ToTargetFormat($('#hdnTempValue')); // Cost Price
        $('#hdnTempValue').val(value.Nominal);
        cell11.innerHTML = ToTargetFormat($('#hdnTempValue')); //---Nominal
        $('#hdnTempValue').val(value.Discount);
        cell12.innerHTML = ToTargetFormat($('#hdnTempValue'));  //Discount
        $('#hdnTempValue').val(value.Tax);
        cell13.innerHTML = ToTargetFormat($('#hdnTempValue'));  // Tax
        $('#hdnTempValue').val(value.PurchaseTax);
        cell20.innerHTML = ToTargetFormat($('#hdnTempValue'));
        $('#hdnTempValue').val(value.SellingPrice);
        cell14.innerHTML = ToTargetFormat($('#hdnTempValue'));  // Sellinng Price
        $('#hdnTempValue').val(value.ExciseTax);
        cell15.innerHTML = ToTargetFormat($('#hdnTempValue'));    // Ex
        $('#hdnTempValue').val(value.MRP);
        cell16.innerHTML = ToTargetFormat($('#hdnTempValue'));   // MRP
        cell17.innerHTML = value.RakNo;  // Rak No
        $('#hdnTempValue').val(value.TotalCost);
        cell18.innerHTML = ToTargetFormat($('#hdnTempValue'));  // Total Cost
        cell19.innerHTML = "<input name='edit' onclick='btnEdit_OnClick(" + JSON.stringify(value) + ");' value = '' type='button' title='Click to Edit'  class='dis-inline marginR5 ui-icon ui-icon-pencil cursor pointer'   />" +
                        "<input name='Delete' onclick='btnDelete(" + JSON.stringify(value) + ");' value = '' type='button' title='Click to Delete'  class='dis-inline ui-icon ui-icon-trash cursor pointer'   />";

        document.getElementById('lblTotalCostAmount').innerHTML =
        parseFloat(parseFloat(value.TotalCost) + parseFloat(ToInternalFormat($("#lblTotalCostAmount")))).toFixed(2);
        ToTargetFormat($("#lblTotalCostAmount"));

        document.getElementById('hdnTotalCost').value = parseFloat(parseFloat(value.TotalCost) + parseFloat(ToInternalFormat($("#hdnTotalCost")))).toFixed(2);
        ToTargetFormat($("#hdnTotalCost"));

        document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(value.TotalCost) + parseFloat(ToInternalFormat($("#txtGrandTotal")))).toFixed(2);
        ToTargetFormat($("#txtGrandTotal"));

        document.getElementById('txtNetTotal').value = parseFloat(ToInternalFormat($("#txtGrandTotal"))).toFixed(2);
        ToTargetFormat($("#txtNetTotal"));

        document.getElementById('txtGrandwithRoundof').value = ToInternalFormat($("#txtNetTotal"));
        ToTargetFormat($("#txtGrandwithRoundof"));

        var totalNominal = parseFloat(parseFloat(value.RECQuantity) * parseFloat(value.Nominal)).toFixed(2);
        document.getElementById('hdnfdisplaydata').value = value.UnitPrice;

        var Cost = ToInternalFormat($('#hdnfdisplaydata'));
        document.getElementById('txtTotalDiscountAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalDiscountAmt")))
         + parseFloat(parseFloat(parseFloat(value.Discount) / 100) * (parseFloat(Cost - parseFloat(value.Nominal)) * parseFloat(value.RECQuantity)))).toFixed(2);
        ToTargetFormat($("#txtTotalDiscountAmt"));

        var SubDiscount = parseFloat(parseFloat(parseFloat(value.Discount) / 100) * parseFloat(parseFloat(value.UnitPrice) * parseFloat(value.RECQuantity))).toFixed(2);
        var InclusiveTax = document.getElementById('chkIntax').checked ? "Y" : "N";
        var IsReqComplQTYCalc = $('#hdnREQCalcCompQTY').val();

        if (InclusiveTax == "Y") {
            if (value.PurchaseTax > 0) {
                document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
                        parseFloat(parseFloat(parseFloat(value.PurchaseTax) / 100) *
                        (parseFloat(parseFloat(parseFloat(value.UnitPrice) * parseFloat(value.RECQuantity)) - parseFloat(SubDiscount))))).toFixed(2);
            }
            else {
                document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt")))); /*(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
                                                                     (parseFloat(value.Tax) / 100
                                                                  * ((parseFloat(value.UnitPrice)
                                                                  * parseFloat(value.RECQuantity)) - parseFloat(SubDiscount)))).toFixed(2);*/
/*}
if (IsReqComplQTYCalc == "Y") {
    if (value.PurchaseTax > 0) {
        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
              parseFloat(parseFloat(parseFloat(value.PurchaseTax) / (100))
             * (parseFloat(parseFloat(parseFloat(value.UnitCostPrice) * parseFloat(value.ComplimentQTY)))))).toFixed(2);
    }
    else {
        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))));
        //parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
        //parseFloat(parseFloat(parseFloat(value.Tax) / (100)) *
        //(parseFloat(parseFloat(parseFloat(value.UnitCostPrice) * parseFloat(value.ComplimentQTY)))))).toFixed(2);
    }
}
}
else {
    if (value.PurchaseTax > 0) {
        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
                 parseFloat(parseFloat(parseFloat(value.PurchaseTax) / (100 + parseFloat(value.PurchaseTax)))
                * (parseFloat(parseFloat(parseFloat(value.SellingPrice) * parseFloat(value.RECQuantity)) -
                 parseFloat(SubDiscount))))).toFixed(2);
    }
    else {
        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))));
        //parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
        //parseFloat(parseFloat(parseFloat(value.Tax) / (100 + parseFloat(value.Tax))) *
        //(parseFloat(parseFloat(parseFloat(value.SellingPrice) * parseFloat(value.RECQuantity)) - parseFloat(SubDiscount))))).toFixed(2);
    }
    if (IsReqComplQTYCalc == "Y") {
        if (value.PurchaseTax > 0) {
            document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
                parseFloat(parseFloat(parseFloat(value.PurchaseTax) / (100 + parseFloat(value.PurchaseTax))) *
                (parseFloat(parseFloat(parseFloat(value.UnitSellingPrice) *
                parseFloat(value.ComplimentQTY)))))).toFixed(2); //     compqty*price*tax/100
        }
        else {
            document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))));
            // parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
            //parseFloat(parseFloat(parseFloat(value.Tax) / (100 + parseFloat(value.Tax))) *
            // (parseFloat(parseFloat(parseFloat(value.UnitSellingPrice) *
            //parseFloat(value.ComplimentQTY)))))).toFixed(2); //     compqty*price*tax/100
        }
    }
}
ToTargetFormat($("#txtTotalTaxAmt"));
var s = parseFloat(parseFloat(parseFloat(value.UnitPrice) * parseFloat(value.RECQuantity)) -
 parseFloat(parseFloat(parseFloat(value.Discount) / 100) *
 parseFloat(parseFloat(Cost - parseFloat(value.Nominal)) * parseFloat(value.RECQuantity)))).toFixed(2);
//Tax Hide for Vasan
if ($("#hdnHideTax").val() == "Y") {
    cell13.hidden = true;
    cell15.hidden = true;
    cell20.hidden = true;
}
//Tax Hide for Vasan
count = count - 1;

    });
    if (lstProductList.length == 0) {
        $('#submitTab').removeClass().addClass('hide');

    }
    else {
        $('#submitTab').removeClass().addClass('displaytb w-100p');
    }
    $('#tblPODetail').removeClass().addClass('w-100p animated fadeIn');
    CSTCalculation();
}*/
function Tblist() {
    $('#lblBatchNo').text(slist.BatchNo);
    $('#lblCostPrice').text(slist.CostPrice);
    //$('#lblNominal').text(slist.Nominal);
    $('#lblDiscou').text(slist.Discount);
    $('#lblSellingPrice').text(slist.SellingPrice);
    $('#lblMRP').text(slist.MRP);
    $('#lblRakNo').text(slist.RakNo);
    $('#lblTotalCost').text(slist.TotalCost);
    $('#lblRcvdQty').text(slist.RcvdQty);
    $('#lblselling').text(slist.sellingUnit);
    $('#lblInversQty').text(slist.InverseQty);
    $('#lblRcdLSUQty').text(slist.RcvdQty_lsu);
    //$('#lblPurchaseTax').text(slist.PurchaseTax);

    $("#TableCollectedItems tr").remove();
    $('#TableCollectedItems').removeClass().addClass('w-100p responstable font11 marginT10 marginB10');

    var Headrow = document.getElementById('TableCollectedItems').insertRow(0);
    var Headrow1 = document.getElementById('TableCollectedItems').insertRow(1);
    var Headrow2 = document.getElementById('TableCollectedItems').insertRow(2);
    Headrow.id = "HeadID";
    Headrow.className = "bold";
    Headrow1.className = "bold";
    Headrow2.className = "bold";
    Headrow.className = "responstableHeader"
    Headrow1.className = "responstableHeader"
    Headrow2.className = "responstableHeader"
    var cell20;
    var cell1 = Headrow.insertCell(0);
    cell1.className = "w-2p";
    var cell2 = Headrow.insertCell(1);
    cell2.className = "w-12p";
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    cell4.className = "w-6p";
    var cell5 = Headrow.insertCell(4);
    var cell6 = Headrow.insertCell(5);
    var cell7 = Headrow.insertCell(6);
    var cell8 = Headrow.insertCell(7);
    var cell9 = Headrow.insertCell(8);
    cell9.className = "w-7p";
    var cell10 = Headrow.insertCell(9);
    var cell11 = Headrow.insertCell(10);
    cell11.className = "hide";
    var cell12 = Headrow.insertCell(11);
    var cell13 = Headrow.insertCell(12);
    cell20 = Headrow.insertCell(13);
    var cell14 = Headrow.insertCell(14);
    var cell15 = Headrow.insertCell(15);
    var cell16 = Headrow.insertCell(16);
    var cell17 = Headrow.insertCell(17);
    var cell18 = Headrow.insertCell(18);
    var cell19 = Headrow.insertCell(19);
    var cell21 = Headrow1.insertCell(0);
    var cell22 = Headrow1.insertCell(1);
    var cell23 = Headrow1.insertCell(2);
    var cell24 = Headrow2.insertCell(0);
    var cell25 = Headrow2.insertCell(1);
    var cell26 = Headrow2.insertCell(2);
    var cell27 = Headrow2.insertCell(3);
    var cell28 = Headrow2.insertCell(4);
    var cell29 = Headrow2.insertCell(5);
    
    var cell30 = Headrow1.insertCell(0);
    var cell31 = Headrow1.insertCell(1);
    var cell32 = Headrow2.insertCell(0);
    var cell33 = Headrow2.insertCell(1);
    var cell34 = Headrow2.insertCell(2);
    var cell35 = Headrow2.insertCell(3);
    
    cell19.className = "w-4p";
    cell20.className = "hide";


    cell1.setAttribute("rowspan", 3);
    cell2.setAttribute("rowspan", 3);
    cell3.setAttribute("rowspan", 3);
    cell4.setAttribute("rowspan", 3);
    cell5.setAttribute("rowspan", 3);
    cell6.setAttribute("rowspan", 3);
    cell7.setAttribute("rowspan", 3);
    cell8.setAttribute("rowspan", 3);
    cell9.setAttribute("rowspan", 3);
    cell10.setAttribute("rowspan", 3);
    cell11.setAttribute("rowspan", 3);
    cell12.setAttribute("colspan", 4);
    cell13.setAttribute("colspan", 6);
    cell14.setAttribute("rowspan", 3);
    cell15.setAttribute("rowspan", 3);
    cell15.className = "hide"; // Check 01
    cell16.setAttribute("rowspan", 3);
    cell17.setAttribute("rowspan", 3);
    cell18.setAttribute("rowspan", 3);
    cell19.setAttribute("rowspan", 3);
    cell20.setAttribute("rowspan", 3);


    cell21.setAttribute("colspan", 2);
    cell22.setAttribute("colspan", 2);
    cell23.setAttribute("colspan", 2);
    
    cell30.setAttribute("colspan", 2);
    cell31.setAttribute("colspan", 2);
    
    cell30.innerHTML = 'Scheme';
    cell31.innerHTML = 'Normal';
    cell32.innerHTML = '%';
    cell33.innerHTML = 'Value';
    cell34.innerHTML = '%';
    cell35.innerHTML = 'Value';

if ($('#hdnIsVATNotApplicable').val().trim() != "Y")
    {
        cell21.innerHTML = 'CGST';
        cell22.innerHTML = 'SGST';
        cell23.innerHTML = 'IGST';
        cell24.innerHTML = '%';
        cell25.innerHTML = 'amt';
        cell26.innerHTML = '%';
        cell27.innerHTML = 'amt';
        cell28.innerHTML = '%';
        cell29.innerHTML = 'amt';
    }
    if ($('#hdnIsVATNotApplicable').val().trim() == "Y")
    {
        cell21.innerHTML = '%';
        cell22.innerHTML = 'Amount';
    }
    cell1.innerHTML = slist.sno;
    cell2.innerHTML = slist.ProductName;
    cell3.innerHTML = slist.BatchNo;
    cell4.innerHTML = slist.Date;
    cell5.innerHTML = slist.RcvdQty;
    cell6.innerHTML = slist.sellingUnit;
    cell7.innerHTML = slist.InverseQty;
    cell8.innerHTML = slist.RcvdQty_lsu;
    cell9.innerHTML = slist.CompQty;
    cell10.innerHTML = slist.CostPrice;
    cell11.innerHTML = slist.Nominal;
    cell12.innerHTML = slist.Discount;
    cell13.innerHTML = slist.Tax;
    cell14.innerHTML = slist.SellingPrice;
    cell15.innerHTML = slist.Ex_percent;
    cell16.innerHTML = slist.MRP;
    cell17.innerHTML = slist.RakNo;
    cell18.innerHTML = slist.TotalCost;
    cell19.innerHTML = slist.Action;
    cell20.innerHTML = slist.PurchaseTax;
    //Tax Hide for Vasan
    if ($("#hdnHideTax").val() == "Y") {
        cell13.hidden = true;
        cell15.hidden = true;
        cell20.hidden = true;
    }
    //Tax Hide for Vasan    
            //Hari's Code starts for GST hide
            if($('#hdnIsVATNotApplicable').val().trim()=="Y")
            {
//                    cell21.hidden=true;
//                    cell22.hidden=true;
//                    cell23.hidden=true;
                    cell24.hidden=true;
                    cell25.hidden=true;
                    cell26.hidden=true;
                    cell27.hidden=true;
                    cell28.hidden=true;
                    cell29.hidden=true;
                    cell30.hidden=true;
                    cell13.setAttribute('colspan',4)
                    cell22.setAttribute('colspan',3)
                    //$('#gstRow').hide();
                    $('#totalCGSTId').hide();
                    $('#totalSGSTId').hide();
                    $('#totalIGSTId').hide();
                
            }
            //Hari's Code ends for GST hide
    document.getElementById('lblTotalCostAmount').innerHTML = '0.00';
    ToTargetFormatWOR($("#lblTotalCostAmount"));
    document.getElementById('txtGrandTotal').value = '0.00';
    ToTargetFormatWOR($("#txtGrandTotal"));
    document.getElementById('txtNetTotal').value = '0.00';
    ToTargetFormatWOR($("#txtNetTotal"));
    document.getElementById('txtGrandwithRoundof').value = '0.00';
    ToTargetFormatWOR($("#txtGrandwithRoundof"));
    document.getElementById('txtRoundOffValue').value = '0.00';
    ToTargetFormatWOR($("#txtRoundOffValue"));
    document.getElementById('txtTotalDiscountAmt').value = '0.00';
    ToTargetFormatWOR($("#txtTotalDiscountAmt"));
    document.getElementById('txtTotalTaxAmt').value = '0.00';
    ToTargetFormatWOR($("#txtTotalTaxAmt"));

    ToTargetFormatWOR($("#txtTotaltax"));
    ToTargetFormatWOR($("#txtTotalDiscount"));
    document.getElementById('hdnTotalCost').value = '0';

    document.getElementById('txtcgst').value = '0.00';
    document.getElementById('txtsgst').value = '0.00';
    document.getElementById('txtigst').value = '0.00';

    ToTargetFormatWOR($("#hdnTotalCost"));
    if (Number($('#hdnAvailableCreditAmount').val()) > 0 && ToInternalFormat($('#hdnAvailableCreditAmount')) != '0.00') {
        document.getElementById('txtAvailCreditAmount').value = parseFloat(ToInternalFormat($("#hdnAvailableCreditAmount"))).toFixed(2);
        ToTargetFormatWOR($("#txtAvailCreditAmount"));
    }
    else {
        document.getElementById('txtAvailCreditAmount').value = '0.00';
        ToTargetFormatWOR($("#txtAvailCreditAmount"));
    }
    document.getElementById('txtUseCreditAmount').value = 0.00;
    if (parseFloat(ToInternalFormat($('#hdnAvailableCreditAmount'))) > 0)
        document.getElementById('txtUseCreditAmount').diabled = false;
    else
        document.getElementById('txtUseCreditAmount').disabled = true;

    if (lstProductList.length > 0) {
        document.getElementById('ddlStockReceivedType').disabled = false;
        lstProductList[0].IsConsign == 'Y' ? $('#ChkIsConsign').prop('checked', true) : $('#ChkIsConsign').prop('checked', false);
    } else {
        $('#ChkIsConsign').prop('checked', false)
    }
    var count = lstProductList.length;
    if (count > 0) {
        $.each(lstProductList, function (obj, value) {
            var row = document.getElementById('TableCollectedItems').insertRow(3);
            row.style.height = "13px";
            row.className = "font11-imp"
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);
            var cell8 = row.insertCell(7);
            var cell9 = row.insertCell(8);
            var cell10 = row.insertCell(9);
            var cell11 = row.insertCell(10);
            var cell12 = row.insertCell(11);
            var cell13 = row.insertCell(12);
            //cell20 = row.insertCell(13);
            var cell14 = row.insertCell(13);
            var cell15 = row.insertCell(14);
            var cell16 = row.insertCell(15);
            var cell17 = row.insertCell(16);
            var cell18 = row.insertCell(17);
            var cell19 = row.insertCell(18);
            var cell20 = row.insertCell(19);
            var cell21 = row.insertCell(20);
            var cell22 = row.insertCell(21);
            var cell23 = row.insertCell(22);
            var cell24 = row.insertCell(23);
            var cell25 = row.insertCell(24);

  //         var cell26 = row.insertCell(25);
//            var cell27 = row.insertCell(26);
//            var cell28 = row.insertCell(27);


            cell19.className = "a-center";

            cell1.innerHTML = count;
            cell2.innerHTML = unescape(value.ProductName); //Produt Name
            cell3.innerHTML = value.BatchNo; //Batch No

            var dateMFT = value.Manufacture == "" ? "**" : value.Manufacture;
            var dateEXP = value.ExpiryDate == "" ? "**" : value.ExpiryDate;
            cell4.innerHTML = "<table class='w-100p no-border'><tr><td>MFT :" + dateMFT + "</td></tr><tr><td>EXP :" + dateEXP + "</td></tr></table>";
            //cell4.width = "13%";
            $('#hdnTempValue').val(value.RECQuantity);
            cell5.innerHTML = ToTargetFormatWOR($('#hdnTempValue')) + " (" + value.RECUnit + ")";  // Rev qty + Rev Unit
            cell6.innerHTML = value.SellingUnit;   //Sellling Unit
            $('#hdnTempValue').val(value.InvoiceQty);
            cell7.innerHTML = ToTargetFormatWOR($('#hdnTempValue'));   //Inve Qty
            $('#hdnTempValue').val(value.RcvdLSUQty);
            cell8.innerHTML = ToTargetFormatWOR($('#hdnTempValue'));  // Revd qty(LSU)
            $('#hdnTempValue').val(value.ComplimentQTY);
            cell9.innerHTML = ToTargetFormatWOR($('#hdnTempValue'));  // Comp qty
            $('#hdnTempValue').val(value.UnitPrice);
            cell10.innerHTML = ToTargetFormatWOR($('#hdnTempValue')); // Cost Price
//            $('#hdnTempValue').val(value.Nominal);
//            cell11.innerHTML = ToTargetFormatWOR($('#hdnTempValue')); //---Nominal
//            cell11.className = 'hide';

            $('#hdnTempValue').val(value.SchemeDisc);
            if (value.SchemeType == "0") { // If 0 then Percetage else 1 then Value  
                cell11.innerHTML = ToTargetFormatWOR($('#hdnTempValue')); //SchemeDisc
            }
            else {
                cell12.innerHTML = ToTargetFormatWOR($('#hdnTempValue')); //SchemeDisc
            }

            $('#hdnTempValue').val(value.Discount);
            if (value.DiscountType == "0") { // If 0 then Percetage else 1 then Value
                cell13.innerHTML = ToTargetFormatWOR($('#hdnTempValue'));  //Discount 
            }
            else {
                cell14.innerHTML = ToTargetFormatWOR($('#hdnTempValue'));  //Discount
            }
            //cell15.className = 'hide'; // Check 01

            //------------------------------Tax Calculation Part
            
        var TtlCost = parseFloat(parseFloat(value.RECQuantity) * parseFloat(value.UnitPrice)).toFixed(2);
        var pSchDisc = 0, pDis, ptotal;
        
        if($('#hdnIsSchemeDiscount').val()== "Y") {
            if(value.SchemeType == 0){
              pSchDisc = parseFloat(parseFloat(parseFloat(TtlCost) / parseFloat(100)) * parseFloat(value.SchemeDisc)).toFixed(2);
            }
            else{
              pSchDisc = parseFloat(value.SchemeDisc).toFixed(2);
            }
            
            TtlCost = parseFloat(parseFloat(TtlCost) - parseFloat(pSchDisc)).toFixed(2);
        }
        else {
            TtlCost = parseFloat(TtlCost).toFixed(2);
        }
        
        if(value.DiscountType == 0){
           pDis = parseFloat(parseFloat(parseFloat(TtlCost) / parseFloat(100)) * parseFloat(value.Discount)).toFixed(2);
        }
        else {
           pDis = parseFloat(value.Discount).toFixed(2);
        }
                
        ptotal = parseFloat(parseFloat(TtlCost) - parseFloat(pDis)).toFixed(2);
            
            
            $('#hdnTempValue').val(value.Tax);
            var GSTtaxamount = 0.00;
            var IGSTtaxamount = 0.00;
            var GSTTax = 0.00;
            if ($('#CheckState').val() == "Y") {
                if (value.Tax > 0) {
                    if ($('#hdnIsVATNotApplicable').val().trim() != "Y") {
                        GSTtaxamount = (parseFloat(parseFloat(ptotal) * value.Tax / 100) / 2).toFixed(2);
                        GSTTax = (parseFloat(value.Tax) / 2).toFixed(2);
                        $('#hdnTax').val(GSTTax);
                        ToTargetFormat($('#hdnTax'));
                        $('#hdnTotalTax').val(GSTtaxamount);
                        ToTargetFormat($('#hdnTotalTax'));
                        cell15.innerHTML = ToTargetFormat($('#hdnTax')); // GSTTax;  // Tax
                        cell16.innerHTML = ToTargetFormat($('#hdnTotalTax')); //GSTtaxamount;
                        cell17.innerHTML = GSTTax;
                        cell18.innerHTML = ToTargetFormat($('#hdnTotalTax')); //GSTtaxamount;
                        cell19.innerHTML = '0.0';
                        cell20.innerHTML = '0.0';
                    }
                    else {
                        GSTtaxamount = (parseFloat(parseFloat(ptotal) * value.Tax / 100)).toFixed(2);
                        GSTTax = (parseFloat(value.Tax)).toFixed(2);
                        $('#hdnTax').val(GSTTax);
                        ToTargetFormat($('#hdnTax'));
                        cell15.innerHTML = ToTargetFormat($('#hdnTax')); //GSTTax;  // Tax
                        $('#hdnTotalTax').val(GSTtaxamount);
                        ToTargetFormat($('#hdnTotalTax'));
                        cell16.innerHTML = ToTargetFormat($('#hdnTotalTax')); //GSTtaxamount;
                        cell17.innerHTML = '0.0';
                        cell18.innerHTML = '0.0';
                        cell19.innerHTML = '0.0';
                        cell20.innerHTML = GSTTax;

                    }
                }
            }
            else {
                IGSTtaxamount = (parseFloat(parseFloat(ptotal) * value.Tax / 100)).toFixed(2);
                GSTTax = (parseFloat(value.Tax)).toFixed(2);
                $('#hdnTax').val(GSTTax);
                ToTargetFormatWOR($('#hdnTax'));
                cell15.innerHTML = '0.00' //ToTargetFormatWOR($('#hdnTax'));//GSTTax;  // Tax
                $('#hdnTax').val('');
                $('#hdnTotalTax').val(IGSTtaxamount);
                ToTargetFormat($('#hdnTotalTax'));
                cell16.innerHTML = '0.00' //ToTargetFormat($('#hdnTotalTax'));
                $('#hdnTotalTax').val('');
                cell17.innerHTML = '0.0';
                cell18.innerHTML = '0.0';
                cell19.innerHTML = GSTTax;
                cell20.innerHTML = IGSTtaxamount;
            }

            //-------------------------------END
            $('#hdnTempValue').val(value.SellingPrice);
            cell21.innerHTML = ToTargetFormatWOR($('#hdnTempValue'));

//            $('#hdnTempValue').val(value.PurchaseTax);
            //            cell22.innerHTML = ToTargetFormatWOR($('#hdnTempValue'));

            //cell20.className = 'hide'; Check 01
            //cell25.innerHTML = ToTargetFormatWOR($('#hdnTempValue'));  // Sellinng Price
//            $('#hdnTempValue').val(value.ExciseTax);
//            cell23.innerHTML = ToTargetFormatWOR($('#hdnTempValue'));    // Ex
//            cell23.className = 'hide'; //Check 01
            
            $('#hdnTempValue').val(value.MRP);
            cell22.innerHTML = ToTargetFormatWOR($('#hdnTempValue'));   // MRP
            cell23.innerHTML = value.RakNo;  // Rak No
            $('#hdnTempValue').val(value.TotalCost);
            cell24.innerHTML = ToTargetFormatWOR($('#hdnTempValue'));  // Total Cost
            cell25.innerHTML = "<input name='edit' onclick='btnEdit_OnClick(" + JSON.stringify(value) + ");' value = '' type='button' title='Click to Edit'  class='dis-inline marginR5 ui-icon ui-icon-pencil cursor pointer'   />" +
                            "<input name='Delete' onclick='btnDelete(" + JSON.stringify(value) + ");' value = '' type='button' title='Click to Delete'  class='dis-inline ui-icon ui-icon-trash cursor pointer'   />";

            document.getElementById('lblTotalCostAmount').innerHTML =
            parseFloat(parseFloat(value.TotalCost) + parseFloat(ToInternalFormat($("#lblTotalCostAmount")))).toFixed(2);
            ToTargetFormatWOR($("#lblTotalCostAmount"));

            document.getElementById('hdnTotalCost').value = parseFloat(parseFloat(value.TotalCost) + parseFloat(ToInternalFormat($("#hdnTotalCost")))).toFixed(2);
            ToTargetFormatWOR($("#hdnTotalCost"));

            document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(value.TotalCost) + parseFloat(ToInternalFormat($("#txtGrandTotal")))).toFixed(2);
            ToTargetFormatWOR($("#txtGrandTotal"));

            document.getElementById('txtNetTotal').value = parseFloat(ToInternalFormat($("#txtGrandTotal"))).toFixed(2);
            ToTargetFormatWOR($("#txtNetTotal"));

            document.getElementById('txtGrandwithRoundof').value = ToInternalFormat($("#txtNetTotal"));
            ToTargetFormatWOR($("#txtGrandwithRoundof"));

            var totalNominal = parseFloat(parseFloat(value.RECQuantity) * parseFloat(value.Nominal)).toFixed(2);
            document.getElementById('hdnfdisplaydata').value = value.UnitPrice;
            
            var Cost = ToInternalFormat($('#hdnfdisplaydata'));
            var totalCost = parseFloat(parseFloat(value.RECQuantity) * parseFloat((Cost) - parseFloat(value.Nominal))).toFixed(2);
            var tempScheme = 0;
            
            if ($('#hdnIsSchemeDiscount').val()== "Y"){
               if(value.SchemeType == "0"){
                   document.getElementById('txtTotalDiscountAmt').value =
                            parseFloat(parseFloat(ToInternalFormat($("#txtTotalDiscountAmt")))
                           + parseFloat(parseFloat(parseFloat(totalCost) / parseFloat(100)) * parseFloat(value.SchemeDisc))).toFixed(2);
                           
                   tempScheme = parseFloat((parseFloat(totalCost) / parseFloat(100)) * parseFloat(value.SchemeDisc)).toFixed(2);
               }
               else {
                   document.getElementById('txtTotalDiscountAmt').value = 
                            parseFloat(parseFloat(ToInternalFormat($("#txtTotalDiscountAmt")))
                          + parseFloat(value.SchemeDisc)).toFixed(2);
                          
                    tempScheme = parseFloat(value.SchemeDisc).toFixed(2);
               }
               totalCost = parseFloat(parseFloat(totalCost) - parseFloat(tempScheme)).toFixed(2);
            }
            else {
               totalCost = parseFloat(totalCost).toFixed(2);
            }
            
            
            if(value.DiscountType == "0"){
               document.getElementById('txtTotalDiscountAmt').value =  parseFloat(parseFloat(ToInternalFormat($("#txtTotalDiscountAmt")))
                       + parseFloat(parseFloat(parseFloat(totalCost) / parseFloat(100)) * parseFloat(value.Discount))).toFixed(2);
            }
            else {
                document.getElementById('txtTotalDiscountAmt').value =
                         parseFloat(parseFloat(ToInternalFormat($("#txtTotalDiscountAmt")))
                         + parseFloat(value.Discount)).toFixed(2) 
            }
            
            ToTargetFormatWOR($("#txtTotalDiscountAmt"));

//            var Cost = ToInternalFormat($('#hdnfdisplaydata'));
//            document.getElementById('txtTotalDiscountAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalDiscountAmt")))
//             + parseFloat(parseFloat(parseFloat(value.Discount) / 100) * (parseFloat(Cost - parseFloat(value.Nominal)) * parseFloat(value.RECQuantity)))).toFixed(2);
//            ToTargetFormatWOR($("#txtTotalDiscountAmt"));
           
//            var SubDiscount = parseFloat(parseFloat(parseFloat(value.Discount) / 100) * parseFloat(parseFloat(value.UnitPrice) * parseFloat(value.RECQuantity))).toFixed(2);
             
            var SubDiscount = parseFloat(parseFloat(pSchDisc) + parseFloat(pDis)).toFixed(2);
              
            var InclusiveTax = document.getElementById('chkIntax').checked ? "Y" : "N";
            var IsReqComplQTYCalc = $('#hdnREQCalcCompQTY').val();
            //------------------------------Tax Calculation Part
            if ($("#CheckState").val() == "Y") {
                document.getElementById('txtcgst').value = (parseFloat(parseFloat(ToInternalFormat($("#txtcgst"))) + parseFloat(GSTtaxamount))).toFixed(2);
                document.getElementById('txtsgst').value = (parseFloat(parseFloat(ToInternalFormat($("#txtsgst"))) + parseFloat(GSTtaxamount))).toFixed(2);
            }
            else {
                document.getElementById('txtigst').value = (parseFloat(parseFloat(ToInternalFormat($("#txtigst"))) + parseFloat(IGSTtaxamount))).toFixed(2);
            }
            //------------------------------Tax Calculation Part END
            if (InclusiveTax == "Y") {
                if (value.Tax > 0) {
                    document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
                            parseFloat(parseFloat(parseFloat(value.Tax) / 100) *
                            (parseFloat(parseFloat(value.UnitPrice) * parseFloat(value.RECQuantity)) - parseFloat(SubDiscount)))).toFixed(2);
                }
                else {
                    document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt")))); /*(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
                                                                     (parseFloat(value.Tax) / 100
                                                                  * ((parseFloat(value.UnitPrice)
                                                                  * parseFloat(value.RECQuantity)) - parseFloat(SubDiscount)))).toFixed(2);*/
                }
                if (IsReqComplQTYCalc == "Y") {
                    if (value.PurchaseTax > 0) {
                        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
                              parseFloat(parseFloat(parseFloat(value.PurchaseTax) / (100))
                             * (parseFloat(parseFloat(parseFloat(value.UnitCostPrice) * parseFloat(value.ComplimentQTY)))))).toFixed(2);
                    }
                    else {
                        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))));
                        /*parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
                        parseFloat(parseFloat(parseFloat(value.Tax) / (100)) *
                        (parseFloat(parseFloat(parseFloat(value.UnitCostPrice) * parseFloat(value.ComplimentQTY)))))).toFixed(2);*/
                    }
                }
            }
            else {
                if (value.PurchaseTax > 0) {
                    document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
                             parseFloat(parseFloat(parseFloat(value.PurchaseTax) / (100 + parseFloat(value.PurchaseTax)))
                            * (parseFloat(parseFloat(parseFloat(value.SellingPrice) * parseFloat(value.RECQuantity)) -
                             parseFloat(SubDiscount))))).toFixed(2);
                }
                else {
                    document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))));
                    /*parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
                    parseFloat(parseFloat(parseFloat(value.Tax) / (100 + parseFloat(value.Tax))) *
                    (parseFloat(parseFloat(parseFloat(value.SellingPrice) * parseFloat(value.RECQuantity)) - parseFloat(SubDiscount))))).toFixed(2);*/
                }
                if (IsReqComplQTYCalc == "Y") {
                    if (value.PurchaseTax > 0) {
                        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
                            parseFloat(parseFloat(parseFloat(value.PurchaseTax) / (100 + parseFloat(value.PurchaseTax))) *
                            (parseFloat(parseFloat(parseFloat(value.UnitSellingPrice) *
                            parseFloat(value.ComplimentQTY)))))).toFixed(2); //     compqty*price*tax/100
                    }
                    else {
                        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))));
                        /* parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
                        parseFloat(parseFloat(parseFloat(value.Tax) / (100 + parseFloat(value.Tax))) *
                        (parseFloat(parseFloat(parseFloat(value.UnitSellingPrice) *
                        parseFloat(value.ComplimentQTY)))))).toFixed(2);*/
                        //     compqty*price*tax/100
                    }
                }
            }
            ToTargetFormatWOR($("#txtTotalTaxAmt"));
            var s = parseFloat(parseFloat(parseFloat(value.UnitPrice) * parseFloat(value.RECQuantity)) -
             parseFloat(parseFloat(parseFloat(value.Discount) / 100) *
             parseFloat(parseFloat(Cost - parseFloat(value.Nominal)) * parseFloat(value.RECQuantity)))).toFixed(2);
            //Tax Hide for Vasan
            if ($("#hdnHideTax").val() == "Y") {
                cell18.hidden = true;
                cell19.hidden = true;
                cell20.hidden = true;
            }
            //Tax Hide for Vasan
            //Hari's Code starts for GST hide
            if ($('#hdnIsVATNotApplicable').val().trim() == "Y") {
                // cell12.hidden=true;
                //cell13.hidden=true;
                //cell14.hidden=true;
                cell14.setAttribute('colspan', 3)
                cell19.hidden = true;
                cell20.hidden = true;
                cell21.hidden = true;
                cell18.hidden = true;


            }
            //Hari's Code ends for GST hide
            count = count - 1;

        });
    }
    if (lstProductList.length == 0) {
        $('#submitTab').removeClass().addClass('hide');

    }
    else {
        $('#submitTab').removeClass().addClass('displaytb w-100p');
    }
    $('#tblPODetail').removeClass().addClass('w-100p animated fadeIn');
    //CSTCalculation();
}
function btnEdit_OnClick(sEditedData) {
    document.getElementById('hdnRowEdit').value = JSON.stringify(sEditedData);
    document.getElementById('add').value = 'Update';
    var objadd = SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_50") == null ? "Update" : SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_50");
    $('#add').text(objadd);
    document.getElementById('hdnAdd').value = 'Update';

    document.getElementById('hdnproductId').value = sEditedData.ProductID; //
    document.getElementById('hdnProductName').value =unescape(sEditedData.ProductName); //y[2];
    document.getElementById('txtProductName').value =unescape(sEditedData.ProductName); //y[2];
    document.getElementById('txtBatchNo').value = sEditedData.BatchNo; // y[3];
    var dateMFT = sEditedData.Manufacture;
    var dateEXP = sEditedData.ExpiryDate;   
    document.getElementById('txtMFTDate').value = dateMFT;
    document.getElementById('txtEXPDate').value = dateEXP;
    document.getElementById('txtRECQuantity').value = sEditedData.RECQuantity; //y[6];
//    document.getElementById('ddlRcvdUnit').value = sEditedData.RECUnit; //y[7];
//    $('#ddlRcvdUnit option:not(:selected)').prop('disabled', true);
    ConvertOrderUnitList(sEditedData.OrderedUnitValues, sEditedData.RECUnit);
    document.getElementById('txtInvoiceQty').value = sEditedData.InvoiceQty; //y[8];
    document.getElementById('ddlSelling').value = sEditedData.SellingUnit; // y[9];
    $('#ddlSelling option:not(:selected)').prop('disabled', true);
    document.getElementById('txtRcvdLSUQty').value = sEditedData.RcvdLSUQty; //y[10];
    document.getElementById('txtCompQuantity').value = sEditedData.ComplimentQTY; // y[11];
    document.getElementById('txtUnitPrice').value = sEditedData.UnitPrice; //y[12];
    document.getElementById('txtSellingPrice').value = sEditedData.SellingPrice; //y[13];
    document.getElementById('txtDiscount').value = sEditedData.Discount; //y[14];
    document.getElementById('txtTax').value = sEditedData.Tax; //y[15];
    document.getElementById('hdnUnitCostPrice').value = sEditedData.UnitCostPrice; //y[16];
    document.getElementById('hdnUnitSellingPrice').value = sEditedData.UnitSellingPrice; // y[17];
    document.getElementById('hdnHasBatchNo').value = sEditedData.HasBatchNo; //y[18];
    document.getElementById('hdnHasCostPrice').value = sEditedData.HasCostPrice;
    document.getElementById('hdnHasSellingPrice').value = sEditedData.HasSellingPrice;
    
    document.getElementById('hdnHasExpiryDate').value = sEditedData.HasExpiryDate; // y[19];
    document.getElementById('txtTotalCost').value = sEditedData.TotalCost; //y[20];
    document.getElementById('hdnType').value = sEditedData.TotalQty; //y[21];
    document.getElementById('txtRakNo').value = sEditedData.RakNo; //y[22];
    document.getElementById('txtMRP').value = sEditedData.MRP; //y[23];
    document.getElementById('hdnID').value = sEditedData.ID; //y[24];
    document.getElementById('txtExTax').value = sEditedData.ExciseTax; //y[25];
    document.getElementById('hdnParentProductID').value = sEditedData.ParentProductID; //y[26];
    document.getElementById('txtNominal').value = sEditedData.Nominal; //y[27];
    $('#txtPurchaseTax').val(sEditedData.PurchaseTax); //y[28]); 
    
    document.getElementById('ddlSchemetype').value = sEditedData.SchemeType; 
    document.getElementById('txtSchemeDisc').value = sEditedData.SchemeDisc; 
    document.getElementById('ddlDisctype').value = sEditedData.DiscountType; 
    
    document.getElementById('txtTotalCost').readOnly = true;
    document.getElementById('txtRcvdLSUQty').readOnly = true;
    document.getElementById('txtProductName').readOnly = true;
    $('#btnPopUp').removeClass().addClass('hide');
    CGST = sEditedData.CGSTTax;
    SGST = sEditedData.SGSTTax;
    IGST = sEditedData.IGSTTax;
    $('.ww-300').html('<table class="gsttbl" border="1" rules="all"><tr><td>CGST(%)</td><td>SGST(%)</td><td>IGST(%)</td></tr><tr><td >' + CGST + '</td><td>' + SGST + '</td><td>' + IGST + '</td></tr></table>');
    ToTargetFormatWOR($("#txtRECQuantity"));
    ToTargetFormatWOR($("#txtInvoiceQty"));
    ToTargetFormatWOR($("#txtRcvdLSUQty"));
    ToTargetFormatWOR($("#txtCompQuantity"));
    ToTargetFormatWOR($("#txtUnitPrice"));
    ToTargetFormatWOR($("#txtSellingPrice"));
    ToTargetFormatWOR($("#txtDiscount"));
    ToTargetFormatWOR($("#txtTax"));
    ToTargetFormatWOR($("#hdnUnitCostPrice"));
    ToTargetFormatWOR($("#hdnUnitSellingPrice"));
    ToTargetFormatWOR($("#txtTotalCost"));
    ToTargetFormatWOR($("#hdnType"));
    ToTargetFormatWOR($("#txtMRP"));
    ToTargetFormatWOR($("#txtNominal"));
    ToTargetFormatWOR($("#txtExTax"));
    ToTargetFormatWOR($("#txtPurchaseTax"));

}
function btnDelete(sEditedData) {
    var arrF = $.grep(lstProductList, function(n, i) {
    	//changes related to CalCompQty 26:8:2016
        //return n.ProductID != sEditedData.ProductID && n.BatchNo != sEditedData.BatchNo;
        if (n.ProductID == sEditedData.ProductID) {
            return n.BatchNo != sEditedData.BatchNo;
        }
        else if (n.BatchNo == sEditedData.BatchNo) {
            return n.ProductID != sEditedData.ProductID;
        }
        else {
            return n.ProductID != sEditedData.ProductID && n.BatchNo != sEditedData.BatchNo;
        }

    });
    lstProductList = [];
    lstProductList = arrF;
    $('#hdnProductList').val(JSON.stringify(lstProductList));

   // document.getElementById('hdnProductList').value = '';
    document.getElementById('lblTotalCostAmount').innerHTML = '0.00';
    ToTargetFormatWOR($("#lblTotalCostAmount"));
    document.getElementById('txtGrandTotal').value = '0.00';
    ToTargetFormatWOR($("#txtGrandTotal"));
    document.getElementById('hdnType').value = "";
    document.getElementById('add').value = 'Add';
    document.getElementById('hdnAdd').value = 'Add';   
    
    document.getElementById('txtRcvdLSUQty').readOnly = false;
    document.getElementById('txtProductName').readOnly = false;
    Tblist();

    document.getElementById('add').value = 'Add';
    document.getElementById('hdnAdd').value = 'Add';
    var objadd = SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_51") == null ? "Add" : SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_51");
    $('#add').text(objadd);
    $('#ChkIsConsign').prop('checked',false)
    clearFields();
    document.getElementById('txtProductName').focus();
}

function CSTCalculation() {
    var CSTValue = document.getElementById('hdnCSTValue').value; 
    document.getElementById('txtCST').value = 0.00;
    ToTargetFormatWOR($('#txtCST'));
    var TotalSales = 0;
    var TotalExcise = 0;
    var CstCalSales = 0
    var p1 = 0;
    var p2 = 0;
    var p3 = 0;
    var pNominal = 0;
    $.each(lstProductList, function(obj, value) {
        pNominal = 0;
        p1 = value.RECQuantity;
        p2 = value.UnitPrice;
        p3 = value.ExciseTax;
        pNominal = value.Nominal;
        var tot = p2 - pNominal;
        TotalSales = TotalSales + (tot * p1);
        if (p3 > 0) {
            CstCalSales = CstCalSales + (tot * p1);
            TotalExcise = TotalExcise + (((tot * p1) * p3) / 100)
        }
    });
    document.getElementById('txtTotalSales').value = parseFloat(TotalSales).toFixed(2);
    ToTargetFormatWOR($("#txtTotalSales"));
    /*document.getElementById('txtTotalExcise').value = parseFloat(TotalExcise).toFixed(2);
    ToTargetFormat($("#txtTotalExcise"));

    document.getElementById('txtCessOnExcise').value = parseFloat((TotalExcise * 2) / 100).toFixed(2);
    ToTargetFormat($("#txtCessOnExcise"));
    document.getElementById('txtHighterEdCess').value = parseFloat((TotalExcise * 1) / 100).toFixed(2);
    ToTargetFormat($("#txtHighterEdCess"));
    if (TotalExcise > 0 && TotalSales > 0) {
      //document.getElementById('txtCST').value = parseFloat(((CstCalSales + TotalExcise + ((TotalExcise * 2) / 100) + ((TotalExcise * 1) / 100)) * 5) / 100).toFixed(2);
        document.getElementById('txtCST').value = parseFloat(((CstCalSales + TotalExcise + ((TotalExcise * 2) / 100) + ((TotalExcise * 1) / 100)) * CSTValue) / 100).toFixed(2);
        ToTargetFormat($("#txtCST"));
    }*/
}


function DynamicTable(id) {
    if (lstProductList.length > 0) {
        document.getElementById('hdnProductList').value = "";
        var tempArray = lstProductList;
        lstProductList = [];
        $.each(tempArray, function(obj, value) {
            var pTempCP;
            var pScheme, pDiscount, total;
            var totalCP = (parseFloat(value.RECQuantity) * parseFloat(value.UnitPrice)).toFixed(2);
            //var Disc = parseFloat(parseFloat(parseFloat(totalCP) / parseFloat(100)) * parseFloat(value.Discount)).toFixed(2);
            //var total = parseFloat(parseFloat(totalCP) - parseFloat(Disc)).toFixed(2);
            
            var IsNeedSchemeInValue = $('#<%=ddlSchemetype.ClientID %> option:selected').val();
            var IsNeedDiscInValue = $('#<%=ddlDisctype.ClientID %> option:selected').val();
        
            var IsSchemeDiscount = ToInternalFormat($('#hdnIsSchemeDiscount'));
            
            if(IsSchemeDiscount == "Y") {
                if(IsNeedSchemeInValue == 0){
                  pScheme = parseFloat(parseFloat(parseFloat(totalCP) / parseFloat(100)) * parseFloat(value.SchemeDisc)).toFixed(2);
                }
                else{
                  pScheme = parseFloat(SchemeDisc).toFixed(2);
                }
                
                pTempCP = parseFloat(parseFloat(totalCP) - parseFloat(pScheme)).toFixed(2);
            }
            else {
               pTempCP = parseFloat(totalCP).toFixed(2);
            }
            
            if(IsNeedDiscInValue == 0){
               pDiscount = parseFloat(parseFloat(parseFloat(pTempCP) / parseFloat(100)) * parseFloat(value.Discount)).toFixed(2);
            }
            else {
               pDiscount = parseFloat(value.Discount).toFixed(2);
            }
            
            var total = parseFloat(parseFloat(pTempCP) - parseFloat(pDiscount)).toFixed(2);
            
            var compQtyTotal = (parseFloat(value.ComplimentQTY) * parseFloat(value.UnitPrice)).toFixed(2);
            var IsReqComplQTYCalc = ToInternalFormat($('#hdnREQCalcCompQTY'));

            if (id == 'chkIntax') {
                var tax = 0;
                if (value.PurchaseTax > 0) {
                    tax = parseFloat(parseFloat(parseFloat(total) / parseFloat(100 + parseFloat(value.PurchaseTax))) * parseFloat(value.PurchaseTax)).toFixed(2);
                }
                else {
                    tax = parseFloat(parseFloat(parseFloat(total) / parseFloat(100)) * parseFloat(value.Tax)).toFixed(2);
                }
                var compQtyTax = 0;
                if (IsReqComplQTYCalc == "Y") {
                    if (value.PurchaseTax > 0) {
                        compQtyTax = parseFloat(parseFloat(parseFloat(compQtyTotal) / parseFloat(100)) * parseFloat(value.PurchaseTax)).toFixed(2);
                    }
                    else {
                        compQtyTax =0;// parseFloat(parseFloat(parseFloat(compQtyTotal) / parseFloat(100)) * parseFloat(value.Tax)).toFixed(2);
                    }
                }
                else {
                    compQtyTax = 0;
                }
                value.TotalCost = (parseFloat(total) + parseFloat(tax) + parseFloat(compQtyTax)).toFixed(2);
            }
            else {
                var totalSP = (parseFloat(value.RECQuantity) * parseFloat(value.SellingPrice)).toFixed(2);
                var TotalCompQtySP = (parseFloat(value.ComplimentQTY) * parseFloat(value.SellingPrice)).toFixed(2);
                var taxmrp = 0;
                if (value.PurchaseTax > 0) {
                    taxmrp = parseFloat(parseFloat(parseFloat(totalSP) / parseFloat(100 + parseFloat(value.PurchaseTax))) * parseFloat(value.PurchaseTax)).toFixed(2);
                }
                else {
                    taxmrp = 0;//parseFloat(parseFloat(parseFloat(totalSP) / parseFloat(100 + parseFloat(value.Tax))) * parseFloat(value.Tax)).toFixed(2);
                }
                var CompQtymrp = 0;
                if (IsReqComplQTYCalc == "Y") {
                    if (value.PurchaseTax > 0) {
                        CompQtymrp = parseFloat(parseFloat(parseFloat(TotalCompQtySP) / parseFloat(100 + parseFloat(value.PurchaseTax))) * parseFloat(value.PurchaseTax)).toFixed(2);
                    }
                    else {
                        CompQtymrp = 0;//parseFloat(parseFloat(parseFloat(TotalCompQtySP) / parseFloat(100 + parseFloat(value.Tax))) * parseFloat(value.Tax)).toFixed(2);
                    }
                }
                else {
                    CompQtymrp = 0;
                }
                value.TotalCost = (parseFloat(total) + parseFloat(taxmrp) + parseFloat(CompQtymrp)).toFixed(2);
            }

            lstProductList.push(value);
        });
        $('#hdnProductList').val(JSON.stringify(lstProductList));
    }


    Tblist();

    TotalCalculation();
    if (document.getElementById('txtTotalCost').value == "NaN") {
        document.getElementById('txtTotalCost').value = '0.00';
        ToTargetFormatWOR($("#txtTotalCost"));
    }
}


function LoadDraf() {
    lstProductList = [];
    if ($("#hdnProductList").val() != "") {
        lstProductList = JSON.parse($("#hdnProductList").val());

    }
    Tblist();
}
var FreeTextFlag = '';
function FreeTextValidateBasedOnFeeType() {
    FreeTextFlag = '';
    $find('AutoCompleteProduct')._onMethodComplete = function(result, context) {
    $find('AutoCompleteProduct')._update(context, result, /* cacheResults */false);
        FreeTextValidateBasedOnFeeTypewebservice_callback(result, context);
    };

}
function FreeTextValidateBasedOnFeeTypewebservice_callback(result, context) {
    if (result == "") {
        FreeTextFlag = 1;
        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_52") == null ? "Free Text not allowed" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_52");
        ValidationWindow(userMsg, ErrorMsg);
        $('#txtProductName').val('');
    }
}


/*OrderUnitList DropDown Bind*/

var OrderUnitList = [];
var ddlvalue;


function ConvertOrderUnitList(value, ddlSelectedVal) {
    OrderUnitList = [];
    ddlvalue = value;

    var SplitVal = value.split('^');

    $.each(SplitVal, function(index, item) {

        var objProduct = new Object();
        var supSplit = item.split(',');

        $.each(supSplit, function(i, val) {

            var FiledSplit = val.split(':');

            if ($.trim(FiledSplit[0]) == "UOMCode") {
                objProduct.UOMCode = FiledSplit[1];
            }

            if ($.trim(FiledSplit[0]) == "ConvesionQty") {
                objProduct.ConvesionQty = FiledSplit[1];
            }

        });

        OrderUnitList.push(objProduct);
    });

    BindOrderUnitddl(OrderUnitList, ddlSelectedVal);

}

function BindOrderUnitddl(lstOrderUnit, SelectedValue) {
    var dropdown = $('#ddlRcvdUnit');
    dropdown.empty();

    $.each(lstOrderUnit, function(index, item) {
        var $option = $("<option />");
        $option.attr("value", item.UOMCode + "~" + item.ConvesionQty).text(item.UOMCode);
        $(dropdown).append($option);

    });


    if ($.trim(SelectedValue) != "") {
        $("#ddlRcvdUnit option:contains(" + $.trim(SelectedValue) + ")").attr('selected', true);
    }
      var ddlRecUnitval = $('#ddlRcvdUnit').val().split('~');
      $("#txtInvoiceQty").val($.trim(ddlRecUnitval[1]));
      ToTargetFormatWOR($("#txtInvoiceQty"));
      document.getElementById('txtInvoiceQty').disabled = true;
}


function ChangeConvesionQty() {  
    
    var ddlRecUnitval = $('#ddlRcvdUnit').val().split('~');
    var ConQty = $.trim(ddlRecUnitval[1]);
    var RecQty = $("#txtRECQuantity").val();
    if ($.trim(RecQty) == "") {
        RecQty = "0";
        $("#txtRcvdLSUQty").val("0");
      }
    $("#txtInvoiceQty").val(ConQty);
    $("#txtRcvdLSUQty").val(Number(RecQty) * Number(ConQty));
    document.getElementById('txtRcvdLSUQty').disabled = true;
    document.getElementById('txtInvoiceQty').disabled = true;
	ToTargetFormat($("#txtInvoiceQty"))
	ToTargetFormat($("#txtRcvdLSUQty"))
    return false;
}



function AddRecUnitDefault() {
    $("#ddlRcvdUnit").empty();
    var ddlval = SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_06") == null ? "Select" : SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_06");
    var $option = $("<option />");
    $option.attr("value", $.trim("0")).text($.trim(ddlval));
    $("#ddlRcvdUnit").append($option);
}