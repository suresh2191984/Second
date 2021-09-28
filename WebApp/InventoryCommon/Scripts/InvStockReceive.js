
var errorMsg = SListForAppMsg.Get("Scripts_Error") == null ? "Error" : SListForAppMsg.Get("Scripts_Error");
var infromMsg = SListForAppMsg.Get("Scripts_Information") == null ? "Information" : SListForAppMsg.Get("Scripts_Information");
var OkMsg = SListForAppMsg.Get("Scripts_Ok") == null ? "Ok" : SListForAppMsg.Get("Scripts_Ok");
var CancelMsg = SListForAppMsg.Get("Scripts_Cancel") == null ? "Cancel" : SListForAppMsg.Get("Scripts_Cancel");


function checkDetails() {
    //            alert("jkhjkh");

    if (document.getElementById('txtPurchaseOrderNo').value == '') {
           var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_01") == null ? "Provide purchase order number" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_01");
            ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtPurchaseOrderNo').focus();
        return false;
    }
    if (document.getElementById('txtReceivedDate').value == '') {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_02") == null ? "Select stock received date" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_02");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtReceivedDate').focus();
        return false;
    }
    if (document.getElementById('ddlSupplier').value != null) {
        if (document.getElementById('ddlSupplier').value == '0') {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_03") == null ? "Select the supplier name" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_03");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddlSupplier').focus();
            return false;
        }
    }
    if (document.getElementById('txtDCNumber').value == "" && document.getElementById('txtInvoiceNo').value == "") {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_04") == null ? "Enter DC Number/InvoiceNo" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_04");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtDCNumber').focus();
        document.getElementById('txtProductName').value = "";
        // document.getElementById('btnFinish').style.display = 'block';
        return false;
    }

    if ($('#txtInvoiceNo').val() != "" && $('#txtInvoiceDate').val() == "") {
        $('#imagInvoiceDate').attr("disabled", false);
        $('#txtInvoiceDate').attr("disabled", true);
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_05") == null ? "Check the invoice Date" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_05");
 ValidationWindow(userMsg, errorMsg);
        //document.getElementById('btnFinish').style.display = 'block';
        return false;
    }

    if (document.getElementById('hdnProductList').value == '') {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_06") == null ? "Check the product list" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_06");
 ValidationWindow(userMsg, errorMsg);
        // document.getElementById('btnFinish').style.display = 'block';
        return false;
    }

    //if (document.getElementById('txtGrandTotal').value != 0.00) {
    if (ToInternalFormat($('#txtGrandTotal')) != 0.00) {
        //document.getElementById('hdnGrandTotal').value = document.getElementById('txtGrandTotal').value;
        document.getElementById('hdnGrandTotal').value = ToInternalFormat($('#txtGrandTotal'));
        ToTargetFormat($('#txtGrandTotal'));
        ToTargetFormat($('#hdnGrandTotal'));
    }
    else {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_06") == null ? "Check the product list" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_06");
 ValidationWindow(userMsg, errorMsg);
        // document.getElementById('btnFinish').style.display = 'block';
        return false;
    }
    document.getElementById('btnFinish').style.display = 'none';
    $('#hdnTotalTax').val($('#txtTaxAmt').val());
    $('#hdnTotalDiscount').val($('#txtDiscountAmt').val());
    return true;
}

function checkIsEmpty(id) {


    if (document.getElementById('txtProductName').value == '') {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_07") == null ? "Provide Product Name" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_07");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtProductName').focus();
        return false;
    }
    if (document.getElementById('ddlCategory').value == 0) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_08") == null ? "Select category" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_08");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('ddlCategory').focus();
        return false;
    }


    if (document.getElementById('hdnHasBatchNo').value != 'N') {
        if (document.getElementById('txtBatchNo').value == '') {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_09") == null ? "Provide batch number" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_09");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtBatchNo').focus();
            return false;
        }

    }



    if (document.getElementById('hdnHasExpiryDate').value != 'N') {
        if (document.getElementById('txtEXPDate').value == '') {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_10") == null ? "Provide expiry date" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_10");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtEXPDate').focus();
            return false;
        }
    }
    if (document.getElementById('txtPoQuantity').value == '') {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_11") == null ? "Provide purchase order quantity" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_11");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }
    if (document.getElementById('txtPoUnit').value == '') {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_12") == null ? "Provide purchase order unit" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_12");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtPoUnit').focus();
        return false;
    }

    //  if (document.getElementById('txtRECQuantity').value == 0.00) {
    if (ToInternalFormat($('#txtRECQuantity')) == 0.00) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_13") == null ? "Provide received quantity" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_13");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtRECQuantity').focus();
        return false;
    }
    if (document.getElementById('txtRcvdUnit').value == '') {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_14") == null ? "Provide the received unit" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_14");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtRcvdUnit').focus();
        return false;
    }
    if (document.getElementById('ddlSelling').value == '0') {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_15") == null ? "Select selling unit" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_15");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('ddlSelling').focus();
        return false;
    }

    //if (document.getElementById('txtUnitPrice').value == 0.00) {
    if (ToInternalFormat($('#txtUnitPrice')) == 0.00) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_16") == null ? "Provide cost price" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_16");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtUnitPrice').focus();
        return false;
    }

    // if (document.getElementById('txtInvoiceQty').value == 0.00) {
    if (ToInternalFormat($('#txtInvoiceQty')) == 0.00) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_17") == null ? "Provide invoice qty" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_17");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtInvoiceQty').focus();
        return false;
    }

    //if (document.getElementById('txtRcvdLSUQty').value == 0.00) {
    if (ToInternalFormat($('#txtRcvdLSUQty')) == 0.00) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_18") == null ? "Provide received LSU qty" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_18");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtRcvdLSUQty').focus();
        return false;
    }
    // if (document.getElementById('txtSellingPrice').value == 0.00) {
    if (ToInternalFormat($('#txtSellingPrice')) == 0.00) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_19") == null ? "Provide Selling Price" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_19");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtSellingPrice').focus();
        return false;
    }
    //if (document.getElementById('txtMRP').value == 0.00) {
    if (ToInternalFormat($('#txtMRP')) == 0.00) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_20") == null ? "Provide MRP" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_20");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtMRP').focus();
        return false;
    }


    if (document.getElementById('hdnAttributeDetail').value == '') {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_21") == null ? "Provide the attributes" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_21");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('lbtnAttribute').focus();
        return false;
    }

    if ($('#hdnIsSellingPriceTypeRuleApply').val() != 'Y') {
        // if (Number(document.getElementById('txtSellingPrice').value) < Number(document.getElementById('txtUnitPrice').value)) {
        if (Number(ToInternalFormat($('#txtSellingPrice'))) < Number(ToInternalFormat($('#txtUnitPrice')))) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_22") == null ? "Provide Selling Price greater than Cost Price" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_22");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtSellingPrice').select();
            return false;
        }

        // if (Number(document.getElementById('txtMRP').value) < Number(document.getElementById('txtUnitPrice').value)) {
        if (Number(ToInternalFormat($('#txtMRP'))) < Number(ToInternalFormat($('#txtUnitPrice')))) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_23") == null ? "Provide MRP greater than Cost Price" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_23");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtMRP').select();
            return false;
        }
    }

    if (document.getElementById('add').value != 'Update') {


        var x = document.getElementById('hdnProductList').value.split("^");
        var pProductId = document.getElementById('hdnproductId').value;
        var pName = document.getElementById('hdnProductName').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        if (pBatchNo == '') {
            pBatchNo = '*';
        }
        var y; var i;
        //var tempQ = document.getElementById('txtPoQuantity').value;
        var tempQ = ToInternalFormat($('#txtPoQuantity'));
        //var AllowedQty = document.getElementById('hdnAllowedQty').value;
        var AllowedQty = ToInternalFormat($('#hdnAllowedQty'));
        if (Number(tempQ) > 0) {
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');

                    if (y[0] == pProductId && y[4] == pBatchNo) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_24") == null ? "Product name and batch number combination already exist" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_24");
 ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtBatchNo').focus();
                        return false;
                    }

                }
            }
        }
        else {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_25") == null ? "Ensure items added/quantity are provided properly" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_25");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtPoQuantity').focus();
            return false;
        }
    }
    if (document.getElementById('add').value != 'Update') {

        var x = document.getElementById('hdnProductList').value.split("^");
        var pProductId = document.getElementById('hdnproductId').value;
        var pName = document.getElementById('hdnProductName').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        if (pBatchNo == '') {
            pBatchNo = '*';
        }

        var y; var i;

        //  var tempQ = document.getElementById('hdnAllowedQty').value;
        var tempQ = ToInternalFormat($('#hdnAllowedQty'));
        //  var q = Number(document.getElementById('txtRECQuantity').value)
        var q = Number(ToInternalFormat($('#txtRECQuantity')));
        var TotalQTY = q;
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
                if (y[0] == pProductId) {
                    TotalQTY = Number(TotalQTY) + Number(y[9]);
                    if (Number(TotalQTY) > Number(tempQ)) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_26") == null ? "Provide received quantity less than or equal to ordered qty" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_26");
 ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtPoQuantity').focus();
                        return false;
                    }



                }

            }

        }
    }
    //document.getElementById('tbTotalCost').style.display = "block";
    $('#tbTotalCost').removeClass().addClass('displaytb w-100p'); 
    if (document.getElementById('hdnHasBatchNo').value != 'N') {
        return CheckDatesMfg(' ', document.getElementById('txtMFTDate'), 'MFG') == true ? CheckDatesExp(' ', document.getElementById('txtEXPDate'), 'EXP') : false;
    }
    return true;
}

function getFocus() {
    document.getElementById('txtSearchTxt').focus();
}


function AddProductDetails(obj) {

    var p = obj.split('~');
    var pDetails = p[9].split('|');
    document.getElementById('hdnOnDeleteReset').value = obj;
    var pBac = pDetails[0];
    var pMaf = pDetails[1];
    var pExp = pDetails[2];
    var pInQty = pDetails[3] == 0 || pDetails[3] == "" ? 1 : pDetails[3];
    var pSellUn = pDetails[4];
    var pCostPr = pDetails[5];
    var pSellPr = pDetails[6];
    var pTax = pDetails[7];
    var pUniCostPr = pDetails[8];
    var pUnitSellPr = pDetails[9];
    var pMRP = pDetails[9];


    document.getElementById('hdnproductId').value = p[0];
    document.getElementById('hdnProductName').value = p[1];
    document.getElementById('txtProductName').value = document.getElementById('hdnProductName').value;
    document.getElementById('TableProductDetails').style.display = "table";
    document.getElementById('ddlCategory').value = p[2];
    document.getElementById('ddlCategory').disabled = true;
    //            document.getElementById('txtProductName').disabled = true;
    document.getElementById('txtPoQuantity').value = p[3];
    ToTargetFormat($('#txtPoQuantity'));
    document.getElementById('txtPoUnit').value = p[4];
    document.getElementById('txtRcvdUnit').value = p[4];
    document.getElementById('txtRcvdUnit').readOnly = true;
    document.getElementById('txtPoQuantity').readOnly = true;
    document.getElementById('hdbTempQut').value = p[2];
    document.getElementById('txtBatchNo').value = '';
    //            
    document.getElementById('txtEXPDate').value = '';
    document.getElementById('txtMFTDate').value = '';
    document.getElementById('txtRECQuantity').value = parseFloat(parseFloat(p[3]).toFixed(2) - parseFloat(p[5]).toFixed(2)).toFixed(2);
    ToTargetFormat($('#txtRECQuantity'));
    document.getElementById('hdnAllowedQty').value = parseFloat(parseFloat(p[3]).toFixed(2) - parseFloat(p[5]).toFixed(2)).toFixed(2);
    ToTargetFormat($('#hdnAllowedQty'));
    document.getElementById('ddlSelling').value = pSellUn;
    //document.getElementById('ddlSelling').value = pSellUn;

    document.getElementById('txtPoUnit').readOnly = true;

    document.getElementById('txtUnitPrice').value = pUniCostPr;
    ToTargetFormat($('#txtUnitPrice'));
    document.getElementById('txtTotalCost').value = 0.00;
    ToTargetFormat($('#txtTotalCost'));
    document.getElementById('txtTotalCost').readOnly = true;
    document.getElementById('txtCompQuantity').value = 0.00;
    ToTargetFormat($('#txtCompQuantity'));
    document.getElementById('txtTax').value = pTax;
    ToTargetFormat($('#txtTax'));
    document.getElementById('txtDiscount').value = 0.00;
    ToTargetFormat($('#txtDiscount'));
    document.getElementById('add').value = 'Add';
    document.getElementById('hdnUnitCostPrice').value = pUniCostPr
    ToTargetFormat($('#hdnUnitCostPrice'));
    document.getElementById('hdnUnitSellingPrice').value = pUnitSellPr
    ToTargetFormat($('#hdnUnitSellingPrice'));
    document.getElementById('hdnAdd').value = 'Add';
    //     document.getElementById('hdnAttributeDetail').value = '';

    document.getElementById('hdnType').value = '';
    document.getElementById('txtSellingPrice').value = pUnitSellPr;
    ToTargetFormat($('#txtSellingPrice'));
    document.getElementById('txtMRP').value = pMRP;
    ToTargetFormat($('#txtMRP'));
    document.getElementById('txtRcvdLSUQty').value = '0.00';
    ToTargetFormat($('#txtRcvdLSUQty'));
    document.getElementById('txtInvoiceQty').value = pInQty;
    ToTargetFormat($('#txtInvoiceQty'));
    document.getElementById('txtRcvdLSUQty').readOnly = true;
    if (p[4] == 'Nos') {
        document.getElementById('ddlSelling').value = 'Nos';
        document.getElementById('txtInvoiceQty').value = 1;
        ToTargetFormat($('#txtInvoiceQty'));
        document.getElementById('txtInvoiceQty').disabled = true;
        document.getElementById('ddlSelling').disabled = true;
    }
    else {

        document.getElementById('txtInvoiceQty').disabled = false;
        document.getElementById('ddlSelling').disabled = false;
    }
    if (p[6] != 'N') {
        document.getElementById('hdnAttributes').value = p[6];
        document.getElementById('lbtnAttribute').style.display = "block"
    }
    else {
        document.getElementById('hdnAttributeDetail').value = p[6];
        document.getElementById('lbtnAttribute').style.display = "none"
        document.getElementById('hdnAttributes').value = "N";
    }
    CheckRcvdLSUQty();

    document.getElementById('hdnHasExpiryDate').value = p[7];
    document.getElementById('hdnHasBatchNo').value = p[8];
    if (p[10] != 'N') {
        document.getElementById('hdnUsageLimit').value = p[11];
    }
    document.getElementById('txtNominal').value = 0.00;
    ToTargetFormat($('#txtNominal'));



}
function BindProductList() {
    if (document.getElementById('hdnAttributes').value == 'N') {
        document.getElementById('hdnGridPopCount').value = (Number(document.getElementById('txtRcvdLSUQty').value) + Number(document.getElementById('txtCompQuantity').value))
    }

    if (document.getElementById('hdnAttributes').value != 'N' && Number(document.getElementById('hdnGridPopCount').value) != (Number(document.getElementById('txtRcvdLSUQty').value) + Number(document.getElementById('txtCompQuantity').value))) {
        if (document.getElementById('hdnAttributeDetail').value == '') {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_21") == null ? "Provide the attributes" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_21");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('lbtnAttribute').focus();
            return false;
        }
        else {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_27") == null ? "The number of product and detail does not match" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_27");
 ValidationWindow(userMsg, errorMsg);
            return false;
        }
    }

    if (document.getElementById('add').value == 'Update') {
        Deleterows();
    }
    else {
        var pMFTDate = '';
        var pEXPDate = '';
        var pProductNamefull = document.getElementById('txtProductName').value;
        var pProductNamesplit = pProductNamefull.split('[');
        var pName = pProductNamesplit[0];
        // var pName = document.getElementById('txtProductName').value;
        var pId = document.getElementById('hdnproductId').value;
        var pCategory = document.getElementById('ddlCategory').options[document.getElementById('ddlCategory').selectedIndex].text;
        var pCategoryId = document.getElementById('ddlCategory').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        if (pBatchNo == '') {
            pBatchNo = '*';
        }

        if (document.getElementById('txtEXPDate').value == '') {
            pEXPDate = '**';
        }
        else {
            pEXPDate = document.getElementById('txtEXPDate').value;
        }

        if (document.getElementById('txtMFTDate').value == '') {
            pMFTDate = '**';
        }
        else {
            pMFTDate = document.getElementById('txtMFTDate').value;
        }

        var pPoQuantity = document.getElementById('txtPoQuantity').value;
        var pPoUnit = document.getElementById('txtPoUnit').value;

        var pRECQuantity = document.getElementById('txtRECQuantity').value == "" ? 0 : ToInternalFormat($("#txtRECQuantity")); //document.getElementById('txtRcvdLSUQty').value;
        // var pRECQuantity = document.getElementById('txtRECQuantity').value;
        var pRECUnit = document.getElementById('txtRcvdUnit').value; // document.getElementById('ddlUOM').options[document.getElementById('ddlUOM').selectedIndex].text;
        var pCompQTY = document.getElementById('txtCompQuantity').value == "" ? 0 : ToInternalFormat($("#txtCompQuantity")); //document.getElementById('txtRcvdLSUQty').value;
        //var pCompQTY = document.getElementById('txtCompQuantity').value;
        var pTax = document.getElementById('txtTax').value;
        var pDiscount = document.getElementById('txtDiscount').value == "" ? 0 : ToInternalFormat($("#txtDiscount")); // document.getElementById('txtDiscount').value;

        // var pDiscount = document.getElementById('txtDiscount').value;

        var pUnitPrice = document.getElementById('txtUnitPrice').value == "" ? 0 : ToInternalFormat($("#txtUnitPrice")); //document.getElementById('txtUnitPrice').value;


        //var pUnitPrice = document.getElementById('txtUnitPrice').value;
        var pTotalCost = document.getElementById('txtTotalCost').value;
        var pTQty = document.getElementById('hdnType').value;
        var pSellingPrice = document.getElementById('txtSellingPrice').value == "" ? 0 : ToInternalFormat($("#txtSellingPrice")); // document.getElementById('txtSellingPrice').value;

        //var pSellingPrice = document.getElementById('txtSellingPrice').value;
        //var pMRP = document.getElementById('txtMRP').value;
        var pMRP = document.getElementById('txtMRP').value == "" ? 0 : ToInternalFormat($("#txtMRP")); // document.getElementById('txtMRP').value;
        var pRcvdLSUQty = document.getElementById('txtRcvdLSUQty').value;
        var pInvoiceQty = document.getElementById('txtInvoiceQty').value;
        var pSellingUnit = document.getElementById('ddlSelling').value; // document.getElementById('ddlSelling').value
        // var pUnitCostPrice = document.getElementById('hdnUnitCostPrice').value;
        //var pUnitSellingPrice = document.getElementById('hdnUnitSellingPrice').value;
        var pUnitCostPrice = document.getElementById('hdnUnitCostPrice').value == "" ? 0 : ToInternalFormat($("#hdnUnitCostPrice")); // document.getElementById('hdnUnitCostPrice').value;
        var pUnitSellingPrice = document.getElementById('hdnUnitSellingPrice').value == "" ? 0 : ToInternalFormat($("#hdnUnitSellingPrice")); //document.getElementById('hdnUnitSellingPrice').value;
        var pAttrib = document.getElementById('hdnAttributes').value;
        var pAttribDetail = document.getElementById('hdnAttributeDetail').value;
        var pHasExpDate = document.getElementById('hdnHasExpiryDate').value;
        var pHasBatchNo = document.getElementById('hdnHasBatchNo').value;

        var pAttCount = document.getElementById('hdnGridPopCount').value;
        var pRakNo = document.getElementById('txtRakNo').value;
        var pNominal = document.getElementById('txtNominal').value == "" ? 0 : document.getElementById('txtNominal').value;
        if (pNominal == 0) {

            pNominal = document.getElementById('txtNominal').value = 0;
        }
        else {
            pNominal = ToInternalFormat($("#txtNominal")) == 0.00 ? 0 : ToInternalFormat($("#txtNominal"));

        }


        document.getElementById('hdnProductList').value = pId + "~" + pName + "~" +
                                    pCategory + "~" + pCategoryId + "~" + pBatchNo + "~" +
                                    pMFTDate + "~" + pEXPDate + "~" + pPoQuantity + "~" +
                                    pPoUnit + "~" + pRECQuantity + "~" +
                                    pRECUnit + "~" + pCompQTY + "~" + pUnitPrice + "~" + pDiscount + "~" + pTax
                                     + "~" + pTotalCost + "~" + pTQty + "~" + pSellingPrice + "~" + pSellingUnit + "~" + pInvoiceQty
                                     + "~" + pRcvdLSUQty + "~" + pUnitCostPrice + "~" + pUnitSellingPrice + "~" + pAttrib
                                     + "~" + pAttribDetail + "~" + pHasExpDate + "~" + pHasBatchNo + "~" + pAttCount + "~"
                                     + pRakNo + "~" + pMRP + "~" + pNominal + "^" +
                                     document.getElementById('hdnProductList').value;
        Tblist();




    }
    //It affects InvAttribute user control
    document.getElementById('add').value = 'Add';
    document.getElementById('hdnAdd').value = 'Add';
    document.getElementById('hdnGridPopCount').value = '';
    document.getElementById('hdnAttributeDetail').value = 'N';
    fnClear();
}

function Tblist() {
    HideTax = $("#hdnTax").val();
    var str = '';
    var hideTaxCol = '';
    var table = '';
    var tr = '';
    var end = '</table>';
    var y = '';
    var pRowId = document.getElementById('hdnRowId').value;
    document.getElementById('lblTable').innerHTML = '';
	if (HideTax == "Y") 
	{
        strTax = "<th class='tbltax hide' >Tax %</th>";
    }
    else {
        strTax = "<th class='tbltax' >Tax %</th>";

    }
    var ProductName = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_01") == null ? "Product Name" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_01");
    var BatchNo = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_02") == null ? "Batch No" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_02");
    var Date = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_03") == null ? "Date" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_03");
    var POQty = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_04") == null ? "PO Qty" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_04");
    var ReceivedQty = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_05") == null ? "Rcvd Qty" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_05");
    var SellingUnit = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_06") == null ? "Selling Unit" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_06");
    var InverseQty = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_07") == null ? "Inverse Qty" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_07");
    var ReceivedLSUQty = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_08") == null ? "Rcvd LSU Qty" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_08");
    var CompLSUQty = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_09") == null ? "Comp Qty(LSU)" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_09");
    var CostPrice = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_10") == null ? "Cost Price" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_10");
    var Nominal = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_11") == null ? "Nominal" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_11");
    var Discount = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_12") == null ? "Discount" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_12");
    var SellingPrice = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_13") == null ? "Selling Price" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_13");
    var MRP = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_14") == null ? "M.R.P/S.R.P" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_14");
    var RakNo = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_15") == null ? "RakNo" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_15");
    var TotalCost = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_16") == null ? "Total Cost" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_16");
    var Action = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_17") == null ? "Action" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_17");

	
     table = "<table id='tbladdproductlist' class='gridView w-100p'><thead  class='a-center gridHeader'>"
                           + "<th>" + ProductName + "</th>"
                           + "<th>" + BatchNo + "</th>"
                           + "<th>" + Date + "</th>"
                           + "<th>" + POQty + "</th>"
                           + "<th>" + ReceivedQty + "</th>"
                           + "<th>" + SellingUnit + "</th>"
                           + "<th>" + InverseQty + "</th>"
                           + "<th>" + ReceivedLSUQty + "</th>"
                           + "<th>" + CompLSUQty + "</th>"
                           + "<th>" + CostPrice + "</th>"
                           + "<th>" + Nominal + "</th>"
                           + "<th>" + Discount + "</th>"
                            +strTax
//                           + "<th class=tbltax >Tax %</th>"
                           + "<th>" + SellingPrice + "</th>"
                           + "<th>" + MRP + "</th>"
                           + "<th>" + RakNo + "</th>"
                           + "<th>" + TotalCost + "</th>"
                           + "<th>" + Action + "</th></thead>";

    var x = document.getElementById('hdnProductList').value.split("^");
    document.getElementById('lblTotalCostAmount').innerHTML = '0.00';
    ToTargetFormat($('#lblTotalCostAmount'));
    document.getElementById('txtDiscountAmt').value = '0.00'
    ToTargetFormat($('#txtDiscountAmt'));
    document.getElementById('txtTotalSales').value = '0.00'
    ToTargetFormat($('#txtTotalSales'));
    document.getElementById('txtGrandTotal').value = '0.00';
    ToTargetFormat($('#txtGrandTotal'));
    document.getElementById('txtTaxAmt').value = '0.00';
    ToTargetFormat($('#txtTaxAmt'));
    //********************
    document.getElementById('txtNetTotal').value = '0.00';
    ToTargetFormat($('#txtNetTotal'));
    document.getElementById('txtGrandwithRoundof').value = '0.00';
    ToTargetFormat($('#txtGrandwithRoundof'));
    document.getElementById('txtRoundOffValue').value = '0.00';
    ToTargetFormat($('#txtRoundOffValue'));

    //*********************

    document.getElementById('hdnTotalCost').value = '0';
    ToTargetFormat($('#hdnTotalCost'));
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');
            if (HideTax == "Y") {
                hideTaxCol = "<td class='hide'>" + y[14] + "</td>";
            }
            else {
                hideTaxCol = "<td class='a-right'>" + y[14] + "</td>";

            }
            tr += "<tr class='gridView w-100p'><td >"
                        + y[1] + "</td><td>"
                        + y[4] + "</td><td><table><tr ><td>MFT: "
                        + y[5] + "</td></tr><tr><td>EXP: "
                        + y[6] + "</td></tr></table></td><td>"
                        + y[7] + "<br/>(" + y[8] + ")</td><td>"
                        + y[9] + "<br/>(" + y[10] + ")</td><td>"
                        + y[18] + "</td><td class='a-right'>"
                        + y[19] + "</td><td class='a-right'>"
                        + y[20] + "</td><td class='a-right'>"
                        + y[11] + "</td><td class='a-right'>"
                        + y[12] + "</td><td class='a-right'>"
                        + y[30] + "</td><td class='a-right'>"  // nominal
                        + y[13] + "</td>"
                        +hideTaxCol+
                       // + y[14] + "</td><td>"
                      "<td class='a-right'>" + y[17] + "</td><td class='a-right'>"
                        + y[29] + "</td><td class='a-right'>"
                        + y[28] + "</td><td class='a-right'>"
                        + y[15] + "</td>"
                         + "<td><input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "~" + y[23] + "~" + y[24] + "~" + y[25] + "~" + y[26] + "~" + y[27] + "~" + y[28] + "~" + y[29] + "~" + y[30] + "' onclick='btnEdit_OnClick(name);' type='button' Class='ui-icon ui-icon-pencil b-none pointer pull-left' />"
                        + "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "~" + y[23] + "~" + y[24] + "~" + y[25] + "~" + y[26] + "~" + y[27] + "~" + y[28] + "~" + y[29] + "~" + y[30] + "' onclick='btnDelete(name);'  type='button' Class='ui-icon ui-icon-trash b-none pointer'/></td></tr>";
            $('#hdnTempValue').val(y[15]);
            document.getElementById('hdnFormatvalue').value = document.getElementById('lblTotalCostAmount').innerHTML;
            ToTargetFormat($('#hdnFormatvalue'));
            document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(ToInternalFormat($('#hdnTempValue'))) + parseFloat(ToInternalFormat($('#hdnFormatvalue')))).toFixed(2);
            ToTargetFormat($("#lblTotalCostAmount"));
            //document.getElementById('hdnTotalCost').value = parseFloat(parseFloat(y[15]) + parseFloat(document.getElementById('hdnTotalCost').value)).toFixed(2);
            document.getElementById('hdnTotalCost').value = parseFloat(parseFloat(ToInternalFormat($('#hdnTempValue'))) + parseFloat(ToInternalFormat($('#hdnTotalCost')))).toFixed(2);
            ToTargetFormat($('#hdnTotalCost'));

            document.getElementById('txtTotalSales').value = ToInternalFormat($('#txtTotalSales')) + (parseFloat(y[12]) * parseFloat(y[9]));
            ToTargetFormat($('#txtTotalSales'));
                
            if ($('#txtTotaltax').val() != '' && $('#txtTotaltax').val() != "0.00") {
                //var totaltax = ($('#txtTotaltax').val() * parseFloat(y[15])) / 100;
                var Total = parseFloat(parseFloat((ToInternalFormat($('#hdnTempValue')))) - parseFloat(ToInternalFormat($('#txtTotalDiscount')))).toFixed(2);
                var totaltax = parseFloat((parseFloat(parseFloat(Total)) / parseFloat(100)) * parseFloat(ToInternalFormat($('#txtTotaltax')))).toFixed(2);
                totaltax = parseFloat(parseFloat(totaltax) + parseFloat(Total)).toFixed(2);
                totaltax = parseFloat(parseFloat(totaltax).toFixed(2) + parseFloat(ToInternalFormat($('#txtGrandTotal')))).toFixed(2);
                $('#txtGrandTotal').val(parseFloat(totaltax).toFixed(2));
                $('#lblTotalCostAmount').text(parseFloat(totaltax).toFixed(2));
                ToTargetFormat($("#lblTotalCostAmount"));
            }
            else {
                document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(ToInternalFormat($('#hdnTempValue'))) + parseFloat(ToInternalFormat($('#txtGrandTotal')))).toFixed(2);
            }
            
            
            ToTargetFormat($('#txtGrandTotal'));
            var cUnitPrice = 0;
            $('#hdnTempValue').val(y[12]);
            cUnitPrice = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);

            document.getElementById('txtNetTotal').value = (parseFloat(ToInternalFormat($('#txtGrandTotal')))).toFixed(2);
            ToTargetFormat($('#txtNetTotal'));

            document.getElementById('txtDiscountAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtDiscountAmt'))) + parseFloat(parseFloat(parseFloat(y[13]) / 100) * (parseFloat(parseFloat(cUnitPrice) - parseFloat(y[30])) * parseFloat(y[9])))).toFixed(2);
            ToTargetFormat($('#txtDiscountAmt'));
           
            var SubDis = parseFloat(parseFloat(parseFloat(y[13]) / 100) * (parseFloat(parseFloat(cUnitPrice) - parseFloat(y[30])) * parseFloat(y[9]))).toFixed(2);
            //  document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(document.getElementById('txtTaxAmt').value) + parseFloat(parseFloat(parseFloat(y[14]) / 100) * (parseFloat(parseFloat(y[12]) * parseFloat(y[9]))))).toFixed(2);
            var _Tax = 0;
            var _UnitPrice = 0;
            var _pNominalDiscount = 0;
            var _RcvdLSUQtyNo = 0;
            var _Discount = 0;
            $('#hdnTempValue').val(y[14]);
            _Tax = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);
            $('#hdnTempValue').val(y[12]);
            _UnitPrice = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);
            $('#hdnTempValue').val(y[30]);
            _pNominalDiscount = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);
            $('#hdnTempValue').val(y[9]);
            _RcvdLSUQtyNo = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);
            $('#hdnTempValue').val(y[13]);
            _Discount = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);



            document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) + parseFloat(parseFloat(parseFloat(_Tax) / 100) * (parseFloat(parseFloat(parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo) + parseFloat(y[11]))) - parseFloat(parseFloat(parseFloat(parseFloat(_Discount) / 100) * (parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo) + parseFloat(+parseFloat(y[11])))))))))).toFixed(2);
            ToTargetFormat($('#txtTaxAmt'));

            ///

            if (document.getElementById('txtTotalDiscount').value.trim() == '')
                document.getElementById('txtTotalDiscount').value = "0.00";
            if (document.getElementById('txtTotaltax').value.trim() == '')
                document.getElementById('txtTotaltax').value = "0.00";
            // var Total = parseFloat(parseFloat(document.geElementById('hdnTotalCost').value) - parseFloat(document.getElementById('txtTotalDiscount').value)).toFixed(2);
            var Total = parseFloat(parseFloat(ToInternalFormat($('#hdnTotalCost'))) - parseFloat(ToInternalFormat($('#txtTotalDiscount')))).toFixed(2);

            // tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(document.getElementById('txtTotaltax').value)).toFixed(2);
            tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(ToInternalFormat($('#txtTotaltax')))).toFixed(2);
            $('#hdnsupplierServiceTaxAmount').val(parseFloat(tempTaxAmt).toFixed(2));
            ToTargetFormat($('#hdnsupplierServiceTaxAmount'));
            document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
            ToTargetFormat($('#lblTotalCostAmount'));
            document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
            ToTargetFormat($('#txtGrandTotal'));
            //document.getElementById('txtNetTotal').value = parseFloat((parseFloat(document.getElementById('txtGrandTotal').value)) - parseFloat(document.getElementById('txtUseCreditAmount').value)).toFixed(2);
            document.getElementById('txtNetTotal').value = parseFloat((parseFloat(ToInternalFormat($('#txtGrandTotal')))) - parseFloat(ToInternalFormat($('#txtUseCreditAmount')))).toFixed(2);
            ToTargetFormat($('#txtNetTotal'));


            ////

            //if (document.getElementById('hdnAvailableCreditAmount').value != null) {
            if (ToInternalFormat($('#hdnAvailableCreditAmount')) != null) {
                // document.getElementById('txtAvailCreditAmount').value = parseFloat(document.getElementById('hdnAvailableCreditAmount').value).toFixed(2);
                document.getElementById('txtAvailCreditAmount').value = parseFloat(ToInternalFormat($('#hdnAvailableCreditAmount'))).toFixed(2);
                ToTargetFormat($('#txtAvailCreditAmount'));
            }
            else {
                document.getElementById('txtAvailCreditAmount').value = 0.00;
                ToTargetFormat($('#txtAvailCreditAmount'));
            }
            document.getElementById('txtUseCreditAmount').value = 0.00;
            ToTargetFormat($('#txtUseCreditAmount'));
            if (parseFloat(ToInternalFormat($('#hdnAvailableCreditAmount'))) > 0)
                document.getElementById('txtUseCreditAmount').diabled = false;
            else
                document.getElementById('txtUseCreditAmount').disabled = true;
        }


    }
    if (x.length == 0) {
        //document.getElementById('submitTab').style.display = "none";
        $('#submitTab').removeClass().addClass('hide');
        $('#tbTotalCost').removeClass().addClass('hide'); 
    }
    else {
        //document.getElementById('submitTab').style.display = "block";
        $('#submitTab').removeClass().addClass('displaytb w-100p');
        $('#tbTotalCost').removeClass().addClass('displaytb w-100p'); 
    }
    var temp = table + tr + end;

    document.getElementById('hdnTempTable').value = temp;
    document.getElementById('lblTable').innerHTML = temp;
}

function btnDelete(sEditedData) {

    var i;
    var x = document.getElementById('hdnProductList').value.split("^");
    document.getElementById('hdnProductList').value = '';
    document.getElementById('lblTotalCostAmount').innerHTML = '0.00';
    ToTargetFormat($('#lblTotalCostAmount'));
    document.getElementById('txtGrandTotal').value = '0.00';
    ToTargetFormat($('#txtGrandTotal'));
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {

            if (x[i] != sEditedData) {
                document.getElementById('hdnProductList').value += x[i] + "^";
                document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(x[i].split('~')[15]) + parseFloat(ToInternalFormat($('#lblTotalCostAmount')).innerHTML)).toFixed(2);
                ToTargetFormat($('#lblTotalCostAmount'));
                document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(x[i].split('~')[15]) + parseFloat(ToInternalFormat($('#txtGrandTotal')))).toFixed(2);
                ToTargetFormat($('#txtGrandTotal'));
            }

        }
    }
    document.getElementById('hdnType').value = "";
    document.getElementById('add').value = 'Add';
    document.getElementById('hdnAdd').value = 'Add';

    document.getElementById('hdnAttributeDetail').value = 'N';
    document.getElementById('hdnGridPopCount').value = '';
    //            document.getElementById('INVAttributes1_hdnTotalCount').value = '0';
    document.getElementById('INVAttributes1_hdnAttValue').value = 'N';
    document.getElementById('INVAttributes1_hdnGridCount').value = '0';
    btnEdit_OnClick(sEditedData);
    Tblist();
}
function AppendMRP() {
    //            if (document.getElementById('txtUnitPrice').value == 0.00 || document.getElementById('txtUnitPrice').value.trim() == "") {
    //                alert('Provide cost price');
    //                document.getElementById('txtUnitPrice').focus();
    //                return false;
    //            }
    //            if (document.getElementById('txtSellingPrice').value == 0.00 || document.getElementById('txtSellingPrice').value.trim() == "") {
    //                alert('Provide Selling Price');
    //                document.getElementById('txtSellingPrice').focus();
    //                return false;
    //            }
    //            if (Number(document.getElementById('txtSellingPrice').value) < Number(document.getElementById('txtUnitPrice').value)) {
    //                alert('Selling Price is less than Cost Price');
    //                document.getElementById('txtSellingPrice').select();
    //                return false;
    //            }
    //getPrecision(document.getElementById('txtSellingPrice'));
    getPrecision(ToInternalFormat($('#txtSellingPrice')));
    // document.getElementById('txtMRP').value = document.getElementById('txtSellingPrice').value;
    document.getElementById('txtMRP').value = ToInternalFormat($('#txtSellingPrice'));
    ToTargetFormat($('#txtMRP'));
}
function TotalCalculation() {
    var tempTaxAmt;
    var Total;
    var pDiscount;
    var pNominalDiscount;
    if ($('#txtNominal').val() == '') {
        $('#txtNominal').val(0);
    }
    calculateCastPerUnit();
    if ($('#txtDiscount').val() == '') {
        $('#txtDiscount').val(0);
    }
    var pNominalDiscount = ToInternalFormat($('#txtNominal')) == 0.00 ? 0 : ToInternalFormat($('#txtNominal'));
    var tax = ToInternalFormat($('#txtTax')) == 0.00 ? 0 : ToInternalFormat($('#txtTax')); //document.getElementById('txtTax').value == 0.00 ? 0 : document.getElementById('txtTax').value;
    var Discount = ToInternalFormat($('#txtDiscount')) == 0.00 ? 0 : ToInternalFormat($('#txtDiscount'));  //document.getElementById('txtDiscount').value == 0.00 ? 0 : document.getElementById('txtDiscount').value;
    var UnitPrice = ToInternalFormat($('#txtUnitPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtUnitPrice'));  //document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
    var RECQuantity = ToInternalFormat($('#txtRcvdLSUQty')) == 0.00 ? 0 : ToInternalFormat($('#txtRcvdLSUQty'));  //document.getElementById('txtRcvdLSUQty').value == 0.00 ? 0 : document.getElementById('txtRcvdLSUQty').value;
    //old var UnitPrice = document.getElementById('hdnUnitCostPrice').value == 0.00 ? 0 : document.getElementById('hdnUnitCostPrice').value;
    var Inverse = ToInternalFormat($('#txtInvoiceQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvoiceQty')); //document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
    var CompQuantity = ToInternalFormat($('#txtCompQuantity')) == 0.00 ? 0 : ToInternalFormat($('#txtCompQuantity'));  //document.getElementById('txtRcvdLSUQty').value == 0.00 ? 0 : document.getElementById('txtRcvdLSUQty').value;

    if (Inverse > 0) {
        UnitPrice = pNominalDiscount > 0 ? parseFloat(parseFloat(UnitPrice) - parseFloat(pNominalDiscount)).toFixed(6) : UnitPrice;

        RECQuantity = Number(RECQuantity) / Number(Inverse);
        var TotalCost = (parseFloat(RECQuantity) * parseFloat(UnitPrice)).toFixed(6);

        pDiscount = parseFloat(parseFloat(parseFloat(TotalCost) / parseFloat(100)) * parseFloat(Discount)).toFixed(6);


        Total = parseFloat(parseFloat(TotalCost) - parseFloat(pDiscount)).toFixed(6);

        tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(6);

        document.getElementById('txtTotalCost').value = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);

        if ($('#hdnREQCalcCompQTY').val() == 'Y') {
            var ComTax = parseFloat(CompQuantity) * parseFloat(UnitPrice) * (parseFloat(parseFloat(tax) / parseFloat(100)).toFixed(2));
            var TotComTax = parseFloat(parseFloat(ComTax) + parseFloat($('#txtTotalCost').val())).toFixed(2);
            $('#txtTotalCost').val(TotComTax);
        }

        ToTargetFormat(($('#txtTotalCost')));
    }

}

function calculateCastPerUnit() {
    var IsRule = document.getElementById('hdnIsSellingPriceRuleApply').value;
    var pNominalDiscount = ToInternalFormat($("#txtNominal")) == 0.00 ? 0 : ToInternalFormat($("#txtNominal"));
    var Costprice = ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));
    var IsRecd = document.getElementById('hdnIsResdCalc').value;
    if (IsRecd == 'SUnit') {
        var UnitPrice = ToInternalFormat($('#txtUnitPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtUnitPrice'));   //var UnitPrice = document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
        var Inverse = ToInternalFormat($('#txtInvoiceQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvoiceQty')); // var Inverse = document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitCostPrice').value = parseFloat(UnitPrice).toFixed(6);
        //ToTargetFormat($('#hdnUnitCostPrice'));
    }
    if (IsRecd == 'PoUnit') {
        var UnitPrice = pNominalDiscount > 0 ? parseFloat(parseFloat(Costprice) - parseFloat(pNominalDiscount)).toFixed(6) : ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));
        // var UnitPrice = ToInternalFormat($('#txtUnitPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtUnitPrice')); // var UnitPrice = document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
        var Inverse = ToInternalFormat($('#txtInvoiceQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvoiceQty')); //var Inverse = document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitCostPrice').value = (parseFloat(UnitPrice) / parseFloat(Inverse)).toFixed(6);
        //ToTargetFormat($('#hdnUnitCostPrice'));
    }

    if (IsRecd == 'RPoUnit') {


        var UnitPrice = ToInternalFormat($('#txtUnitPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtUnitPrice'));  // var UnitPrice = document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
        var RecdQty = ToInternalFormat($('#txtRECQuantity')) == 0.00 ? 0 : ToInternalFormat($('#txtRECQuantity'));  //var RecdQty = document.getElementById('txtRECQuantity').value == 0.00 ? 0 : document.getElementById('txtRECQuantity').value;
        var perUnit = (parseFloat(UnitPrice) / parseFloat(RecdQty)).toFixed(6);

        //var Inverse = document.getElementById('txtInvoiceQty').value;
        var Inverse = ToInternalFormat($('#txtInvoiceQty'));
        document.getElementById('hdnUnitCostPrice').value = (parseFloat(perUnit) / parseFloat(Inverse)).toFixed(6);
        //ToTargetFormat($('#hdnUnitCostPrice'));
    }
    if (IsRecd == 'RLsuSell') {
        var UnitPrice = ToInternalFormat($('#txtUnitPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtUnitPrice'));  //   var UnitPrice = document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
        var Inverse = ToInternalFormat($('#txtInvoiceQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvoiceQty')); // var Inverse = document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        var RecdQtylsu = ToInternalFormat($('#txtRcvdLSUQty')) == 0.00 ? 0 : ToInternalFormat($('#txtRcvdLSUQty')); // var RecdQtylsu = document.getElementById('txtRcvdLSUQty').value == 0.00 ? 0 : document.getElementById('txtRcvdLSUQty').value;
        var perUnitLsu = (parseFloat(UnitPrice) / parseFloat(RecdQtylsu)).toFixed(6);
        document.getElementById('hdnUnitCostPrice').value = parseFloat(perUnitLsu).toFixed(6);
        //ToTargetFormat($('#hdnUnitCostPrice'));
    }

    if (IsRule == 'Y') {
        AutoSellingprice();
    }

}


function AutoSellingprice() {
    var IsRule = document.getElementById('hdnIsSellingPriceRuleApply').value;
    var Istrue = false;
    var tax = ToInternalFormat($('#txtTax')) == 0.00 ? 0 : ToInternalFormat($('#txtTax'));
    var Discount = ToInternalFormat($('#txtDiscount')) == 0.00 ? 0 : ToInternalFormat($('#txtDiscount'));
    var pNominalDiscount = ToInternalFormat($("#txtNominal")) == 0.00 ? 0 : ToInternalFormat($("#txtNominal"));
    var pselval = document.getElementById('hdnSellingPrieRuleList').value.split("^");
    var Costprice = ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));
    var UnitPrice = pNominalDiscount > 0 ? parseFloat(parseFloat(Costprice) - parseFloat(pNominalDiscount)).toFixed(6) : ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));
    var sellingPrice = 0.00;
    var tempTaxAmt = 0.00;
    var Total = 0.00;
    var pDiscount = 0.00;
    var Price = 0.00;
    var i;
    if (UnitPrice > 0 && IsRule == 'Y') {

        for (i = 0; i < pselval.length; i++) {
            if (pselval[i] != "" && Istrue == false) {
                p_sel = pselval[i].split('~');

                if (p_sel[4] == "N") {
                    pDiscount = parseFloat(parseFloat(parseFloat(UnitPrice) / parseFloat(100)) * parseFloat(Discount)).toFixed(6);
                    Total = parseFloat(parseFloat(UnitPrice) - parseFloat(pDiscount)).toFixed(6);
                    tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(6);
                    Price = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(6);
                }
                else {
                    tempTaxAmt = parseFloat(parseFloat(parseFloat(UnitPrice) / parseFloat(100)) * parseFloat(tax)).toFixed(6);
                    Price = parseFloat(parseFloat(UnitPrice) + parseFloat(tempTaxAmt)).toFixed(6);
                }


                if (parseFloat(Price) >= parseFloat(p_sel[1]) && parseFloat(Price) <= parseFloat(p_sel[2])) {

                    sellingPrice = parseFloat(parseFloat(Price) + parseFloat(parseFloat(Price) * parseFloat(parseFloat(p_sel[3]) / 100))).toFixed(6);
                    document.getElementById('txtSellingPrice').value = parseFloat(sellingPrice).toFixed(6);
                    //document.getElementById('txtMRP').value = parseFloat(sellingPrice).toFixed(6);
                    ToTargetFormat($('#txtSellingPrice'));
                    ToTargetFormat($('#txtMRP'));
                    Istrue = true;
                }

            }
        }
    }

    var IsRecd = document.getElementById('hdnIsResdCalc').value;
    if (IsRecd == 'SUnit') {

        var pSellingPrice = ToInternalFormat($('#txtSellingPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtSellingPrice'));  //document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
        var Inverse = ToInternalFormat($('#txtInvoiceQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvoiceQty')); //document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitSellingPrice').value = parseFloat(pSellingPrice).toFixed(6);
        ToTargetFormat($('#hdnUnitSellingPrice'));

    }
    if (IsRecd == 'PoUnit') {
        var pSellingPrice = ToInternalFormat($('#txtSellingPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtSellingPrice')); //document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
        var Inverse = ToInternalFormat($('#txtInvoiceQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvoiceQty')); // document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitSellingPrice').value = (parseFloat(pSellingPrice) / parseFloat(Inverse)).toFixed(6);
        ToTargetFormat($('#hdnUnitSellingPrice'));

    }

    if (IsRecd == 'RPoUnit') {

        var pSellingPrice = ToInternalFormat($('#txtSellingPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtSellingPrice')); //document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
        var RecdQty = ToInternalFormat($('#txtRECQuantity')) == 0.00 ? 0 : ToInternalFormat($('#txtRECQuantity')); //document.getElementById('txtRECQuantity').value == 0.00 ? 0 : document.getElementById('txtRECQuantity').value;
        var perUnit = (parseFloat(pSellingPrice) / parseFloat(RecdQty)).toFixed(6);

        var Inverse = ToInternalFormat($('#txtInvoiceQty')); //document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitSellingPrice').value = (parseFloat(perUnit) / parseFloat(Inverse)).toFixed(6);
        ToTargetFormat($('#hdnUnitSellingPrice'));

    }
    if (IsRecd == 'RLsuSell') {
        var pSellingPrice = ToInternalFormat($('#txtSellingPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtSellingPrice'));  //document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
        var Inverse = ToInternalFormat($('#txtInvoiceQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvoiceQty')); //document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        var RecdQtylsu = ToInternalFormat($('#txtRcvdLSUQty')) == 0.00 ? 0 : ToInternalFormat($('#txtRcvdLSUQty')); // document.getElementById('txtRcvdLSUQty').value == 0.00 ? 0 : document.getElementById('txtRcvdLSUQty').value;
        var perUnitLsu = (parseFloat(pSellingPrice) / parseFloat(RecdQtylsu)).toFixed(6);
        document.getElementById('hdnUnitSellingPrice').value = parseFloat(perUnitLsu).toFixed(6);
        ToTargetFormat($('#hdnUnitSellingPrice'));

    }




}
function btnCalcSellingPrice() {
    var IsRecd = document.getElementById('hdnIsResdCalc').value;
    if (IsRecd == 'SUnit') {

        var pSellingPrice = ToInternalFormat($('#txtSellingPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtSellingPrice'));  //document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
        var Inverse = ToInternalFormat($('#txtInvoiceQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvoiceQty')); //document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitSellingPrice').value = parseFloat(pSellingPrice).toFixed(6);
        ToTargetFormat($('#hdnUnitSellingPrice'));

    }
    if (IsRecd == 'PoUnit') {
        var pSellingPrice = ToInternalFormat($('#txtSellingPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtSellingPrice')); //document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
        var Inverse = ToInternalFormat($('#txtInvoiceQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvoiceQty')); // document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitSellingPrice').value = (parseFloat(pSellingPrice) / parseFloat(Inverse)).toFixed(6);
        ToTargetFormat($('#hdnUnitSellingPrice'));

    }

    if (IsRecd == 'RPoUnit') {

        var pSellingPrice = ToInternalFormat($('#txtSellingPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtSellingPrice')); //document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
        var RecdQty = ToInternalFormat($('#txtRECQuantity')) == 0.00 ? 0 : ToInternalFormat($('#txtRECQuantity')); //document.getElementById('txtRECQuantity').value == 0.00 ? 0 : document.getElementById('txtRECQuantity').value;
        var perUnit = (parseFloat(pSellingPrice) / parseFloat(RecdQty)).toFixed(6);

        var Inverse = ToInternalFormat($('#txtInvoiceQty')); //document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitSellingPrice').value = (parseFloat(perUnit) / parseFloat(Inverse)).toFixed(6);
        ToTargetFormat($('#hdnUnitSellingPrice'));

    }
    if (IsRecd == 'RLsuSell') {
        var pSellingPrice = ToInternalFormat($('#txtSellingPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtSellingPrice'));  //document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
        var Inverse = ToInternalFormat($('#txtInvoiceQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvoiceQty')); //document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        var RecdQtylsu = ToInternalFormat($('#txtRcvdLSUQty')) == 0.00 ? 0 : ToInternalFormat($('#txtRcvdLSUQty')); // document.getElementById('txtRcvdLSUQty').value == 0.00 ? 0 : document.getElementById('txtRcvdLSUQty').value;
        var perUnitLsu = (parseFloat(pSellingPrice) / parseFloat(RecdQtylsu)).toFixed(6);
        document.getElementById('hdnUnitSellingPrice').value = parseFloat(perUnitLsu).toFixed(6);
        ToTargetFormat($('#hdnUnitSellingPrice'));

    }
    //btnOnFocus();
}



function Deleterows() {
    var RowEdit = document.getElementById('hdnRowEdit').value;
    var x = document.getElementById('hdnProductList').value.split("^");
    if (RowEdit != "") {
        var pId = document.getElementById('hdnproductId').value;
        var pName = document.getElementById('hdnProductName').value;
        var pCategory = document.getElementById('ddlCategory').options[document.getElementById('ddlCategory').selectedIndex].text;
        var pCategoryId = document.getElementById('ddlCategory').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        if (pBatchNo == '') {
            pBatchNo = '*';
        }
        var pEXPDate = document.getElementById('txtEXPDate').value;
        if (pEXPDate == '') {
            pEXPDate = '**'
        }
        var pMFTDate = document.getElementById('txtMFTDate').value;
        if (pMFTDate == '') {
            pMFTDate = '**'
        }
        var pPoQuantity = document.getElementById('txtPoQuantity').value;
        var pPoUnit = document.getElementById('txtPoUnit').value;

        var pRECQuantity = document.getElementById('txtRECQuantity').value;
        var pRECUnit = document.getElementById('txtRcvdUnit').value; // document.getElementById('ddlUOM').options[document.getElementById('ddlUOM').selectedIndex].text;

        var pCompQTY = document.getElementById('txtCompQuantity').value;
        var pTax = document.getElementById('txtTax').value;
        var pDiscount = document.getElementById('txtDiscount').value;

        var pUnitPrice = document.getElementById('txtUnitPrice').value;
        var pTotalCost = document.getElementById('txtTotalCost').value;
        var pTQty = document.getElementById('hdnType').value;
        var pSellingPrice = document.getElementById('txtSellingPrice').value;
        var pMRP = document.getElementById('txtMRP').value;
        var pRcvdLSUQty = document.getElementById('txtRcvdLSUQty').value;
        var pInvoiceQty = document.getElementById('txtInvoiceQty').value;
        var pSellingUnit = document.getElementById('ddlSelling').value; // document.getElementById('ddlSelling').value
        var pUnitCostPrice = document.getElementById('hdnUnitCostPrice').value;
        var pUnitSellingPrice = document.getElementById('hdnUnitSellingPrice').value;
        var pAttrib = document.getElementById('hdnAttributes').value;
        var pAttribDetail = document.getElementById('hdnAttributeDetail').value;
        var pHasExpDate = document.getElementById('hdnHasExpiryDate').value;
        var pHasBatchNo = document.getElementById('hdnHasBatchNo').value;

        var pAttCount = document.getElementById('hdnGridPopCount').value;
        var pRakNo = document.getElementById('txtRakNo').value;
        if ($('#txtNominal').val() == '') {
            document.getElementById('txtNominal').value = '0.00';
        }
        var pNominal = document.getElementById('txtNominal').value;

        document.getElementById('hdnProductList').value = pId + "~" + pName + "~" +
                                    pCategory + "~" + pCategoryId + "~" + pBatchNo + "~" +
                                    pMFTDate + "~" + pEXPDate + "~" + pPoQuantity + "~" +
                                    pPoUnit + "~" + pRECQuantity + "~" +
                                    pRECUnit + "~" + pCompQTY + "~" + pUnitPrice + "~" + pDiscount + "~" + pTax
                                    + "~" + pTotalCost + "~" + pTQty + "~" + pSellingPrice + "~" + pSellingUnit + "~" +
                                    pInvoiceQty + "~" + pRcvdLSUQty + "~" + pUnitCostPrice + "~" + pUnitSellingPrice + "~" +
                                    pAttrib + "~" + pAttribDetail + "~" + pHasExpDate + "~" +
                                    pHasBatchNo + "~" + pAttCount + "~" + pRakNo + "~" + pMRP + "~" + pNominal + "^";

        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {

                if (x[i] != RowEdit) {
                    document.getElementById('hdnProductList').value += x[i] + "^";
                }
            }
        }

        // var delObj = document.getElementById('hdnOnDeleteReset').value;

        //  document.getElementById('INVAttributes1_hdnTotalCount').value = '0';
        //  document.getElementById('INVAttributes1_hdnAttValue').value = 'N';
        //  BindProductList();
        //  AddProductDetails(delObj);
        //   
        document.getElementById('hdnRowEdit').value = "";
        Tblist();
        document.getElementById('hdnAttributeDetail').value = 'N';
    }
}
function btnEdit_OnClick(sEditedData) {

    var y = sEditedData.split('~');
    document.getElementById('hdnproductId').value = y[0];
    document.getElementById('hdnProductName').value = y[1];
    document.getElementById('txtProductName').value = y[1];
    document.getElementById('ddlCategory').value = y[3];
    document.getElementById('txtBatchNo').value = y[4];
    document.getElementById('txtMFTDate').value = y[5];
    document.getElementById('txtEXPDate').value = y[6];
    document.getElementById('txtPoQuantity').value = y[7];
    document.getElementById('txtPoUnit').value = y[8];
    document.getElementById('txtRECQuantity').value = y[9];
    document.getElementById('txtRcvdUnit').value = y[10];

    document.getElementById('txtCompQuantity').value = y[11];
    document.getElementById('txtUnitPrice').value = y[12];

    document.getElementById('txtDiscount').value = y[13];
    document.getElementById('txtTax').value = y[14];

    document.getElementById('txtTotalCost').value = y[15];
    document.getElementById('hdnRowEdit').value = sEditedData;
    document.getElementById('hdnType').value = y[16];
    document.getElementById('add').value = 'Update';

    document.getElementById('hdnAdd').value = 'Update';

    document.getElementById('txtSellingPrice').value = y[17];
    document.getElementById('ddlSelling').value = y[18];
    document.getElementById('txtInvoiceQty').value = y[19];
    document.getElementById('txtRcvdLSUQty').value = y[20];
    document.getElementById('hdnUnitCostPrice').value = y[21];
    document.getElementById('hdnUnitSellingPrice').value = y[22];
    document.getElementById('hdnAttributes').value = y[23];
    document.getElementById('hdnAttributeDetail').value = y[24];
    document.getElementById('hdnHasExpiryDate').value = y[25];
    document.getElementById('hdnHasBatchNo').value = y[26];
    document.getElementById('hdnGridPopCount').value = y[27];
    document.getElementById('txtRakNo').value = y[28];
    document.getElementById('txtMRP').value = y[29];
    document.getElementById('txtNominal').value = y[30];

    document.getElementById('TableProductDetails').style.display = "table";
    document.getElementById('ddlCategory').disabled = true;
    //            document.getElementById('txtProductName').disabled = true;
    document.getElementById('txtRcvdUnit').readOnly = true;
    document.getElementById('txtPoQuantity').readOnly = true;
    document.getElementById('txtPoUnit').readOnly = true;
    document.getElementById('txtTotalCost').readOnly = true;
    document.getElementById('txtRcvdLSUQty').readOnly = true;

    if (y[23] != 'N') {
        document.getElementById('lbtnAttribute').style.display = "block"
    }
    else {
        document.getElementById('lbtnAttribute').style.display = "none"
        document.getElementById('hdnAttributes').value = "N";
    }
}


function ProductsListPopup() {
    var cId = document.getElementById('ddlCategory').value;
    var Org = document.getElementById('hdnOrgId').value;
    var LocID = document.getElementById('hdnOrgLocId').value;
    window.showModalDialog("ProductsList.aspx?Cid=" + cId + "&OrgId=" + Org + "&LocID=" + LocID + "", "Products List", "dialogWidth:626px;dialogHeight:476px");
}

function bindNewProduct(Id, Name) {
    document.getElementById('hdnproductId').value = Id;
    document.getElementById('hdnProductName').value = Name;
    document.getElementById('txtProductName').value = Name;
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_28") == null ? "" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_28");
 ValidationWindow(userMsg, errorMsg);
}

function CheckRcvdLSUQty() {
    var pInvoiceQty = ToInternalFormat($('#txtInvoiceQty')); //  var pInvoiceQty = document.getElementById('txtInvoiceQty').value;
    var pRECQuantity = ToInternalFormat($('#txtRECQuantity')); //var pRECQuantity = document.getElementById('txtRECQuantity').value;

    // var AllowedQty = document.getElementById('hdnAllowedQty').value;
    var AllowedQty = ToInternalFormat($('#hdnAllowedQty'));
    if (pInvoiceQty != "" && pRECQuantity != "") {
        document.getElementById('txtRcvdLSUQty').value = parseFloat(pInvoiceQty).toFixed(2) * parseFloat(pRECQuantity).toFixed(2);
    }
    else {
        document.getElementById('txtRcvdLSUQty').value = "";
    }
    ToTargetFormat($('#txtRcvdLSUQty'));
    //if (Number(pRECQuantity) > Number(document.getElementById('txtPoQuantity').value)) {
    if (Number(pRECQuantity) > Number(ToInternalFormat($('#txtPoQuantity')))) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_26") == null ? "Provide received quantity less than or equal to ordered qty" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_26");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtRECQuantity').focus();
        return false;
    }


    CheckCompQty();
    TotalCalculation();


}


function ProductDetails() {
    document.getElementById('ddlCategory').disabled = false;
    document.getElementById('txtProductName').disabled = false;
    document.getElementById('hdnproductId').value = 0;
    document.getElementById('hdnProductName').value = '';
    document.getElementById('txtProductName').value = '';
    document.getElementById('TableProductDetails').style.display = "table";
    document.getElementById('ddlCategory').value = 0;
    document.getElementById('txtUnit').value = '';
    document.getElementById('hdbTempQut').value = '';
    document.getElementById('txtBatchNo').value = '';
    document.getElementById('txtEXPDate').value = '';
    document.getElementById('txtMFTDate').value = '';
    document.getElementById('txtUnitPrice').value = '';
    document.getElementById('txtTotalCost').value = '';
    document.getElementById('txtCompQuantity').value = '';
    document.getElementById('txtTax').value = '';
    document.getElementById('txtDiscount').value = '';
    document.getElementById('txtMRP').value = '';
    document.getElementById('txtSellingPrice').value = '';

}
function btnOnFocus() {
    document.getElementById('add').focus();
    if (checkIsEmpty())
    { BindProductList(); }
}

function CheckInverseQty() {
    var pRECUnit = document.getElementById('txtRcvdUnit').value;
    var pSellingUnit = document.getElementById('ddlSelling').value; // document.getElementById('ddlSelling').value
    if (pRECUnit == pSellingUnit) {
        document.getElementById('txtInvoiceQty').value = 1;
        document.getElementById('txtInvoiceQty').disabled = true;
    }
    else {
        document.getElementById('txtInvoiceQty').value = '0.00';
        ToTargetFormat($('#txtInvoiceQty'));
        document.getElementById('txtInvoiceQty').disabled = false;

    }
    CheckRcvdLSUQty();



}

function checkAddToTotal() {
    if (document.getElementById('txtTotalDiscount').value.trim() == '')
        document.getElementById('txtTotalDiscount').value = "0.00";
    if (document.getElementById('txtTotaltax').value.trim() == '')
        document.getElementById('txtTotaltax').value = "0.00";
    // var Total = parseFloat(parseFloat(document.geElementById('hdnTotalCost').value) - parseFloat(document.getElementById('txtTotalDiscount').value)).toFixed(2);
    var Total = parseFloat(parseFloat(ToInternalFormat($('#hdnTotalCost'))) - parseFloat(ToInternalFormat($('#txtTotalDiscount')))).toFixed(2);

    // tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(document.getElementById('txtTotaltax').value)).toFixed(2);
    tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(ToInternalFormat($('#txtTotaltax')))).toFixed(2);
    $('#hdnsupplierServiceTaxAmount').val(parseFloat(tempTaxAmt).toFixed(2));
    document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
    ToTargetFormat($('#lblTotalCostAmount'));
    document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
    ToTargetFormat($('#txtGrandTotal'));
    //document.getElementById('txtNetTotal').value = parseFloat((parseFloat(document.getElementById('txtGrandTotal').value)) - parseFloat(document.getElementById('txtUseCreditAmount').value)).toFixed(2);
    document.getElementById('txtNetTotal').value = parseFloat((parseFloat(ToInternalFormat($('#txtGrandTotal')))) - parseFloat(ToInternalFormat($('#txtUseCreditAmount')))).toFixed(2);
    ToTargetFormat($('#txtNetTotal'));
    //if (parseFloat(document.getElementById('txtUseCreditAmount').value) > parseFloat(document.getElementById('txtAvailCreditAmount').value)) {
    if (parseFloat(ToInternalFormat($('#txtUseCreditAmount'))) > parseFloat(ToInternalFormat($('#txtAvailCreditAmount')))) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_29") == null ? "Use within available credit amount" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_29");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtUseCreditAmount').value = 0;
        ToTargetFormat($('#txtUseCreditAmount'));
        document.getElementById('txtUseCreditAmount').focus();
    }
    // if (parseFloat(document.getElementById('txtUseCreditAmount').value) > parseFloat(document.getElementById('txtGrandTotal').value)) {
    if (parseFloat(ToInternalFormat($('#txtUseCreditAmount'))) > parseFloat(ToInternalFormat($('#txtGrandTotal')))) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_30") == null ? "Use credit amount lessthan or equal to GrandTotal" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_30");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtUseCreditAmount').value = 0;
        ToTargetFormat($('#txtUseCreditAmount'));
        document.getElementById('txtUseCreditAmount').focus();
    }
    return false;
}
function CheckCompQty() {
    if (document.getElementById('hdnAttributes').value == "N") {
        // document.getElementById('hdnGridPopCount').value = (Number(document.getElementById('txtRcvdLSUQty').value) + Number(document.getElementById('txtCompQuantity').value));
        document.getElementById('hdnGridPopCount').value = (Number(ToInternalFormat($('#txtRcvdLSUQty'))) + Number(ToInternalFormat($('#txtCompQuantity'))));
        TotalCalculation();
    }

}

function INVRowCommon(rid, patid, SupID, PONO) {
    chosen = "";

    var len = document.forms[0].elements.length;
    for (var i = 0; i < len; i++) {
        if (document.forms[0].elements[i].type == "radio") {
            document.forms[0].elements[i].checked = false;
        }
    }
    document.getElementById(rid).checked = true;
    document.getElementById("poNoid").value = patid;
    document.getElementById("SupID").value = SupID;
    document.getElementById("HdnPOno").value = PONO;
    document.getElementById("tdgo").style.display = 'block';
    //document.getElementById("patOrgID").value = patOrgID
}
function CheckPoNo() {
    //           if (document.getElementById('ddlSupplier').value == 0) {
    //               alert('Please Select an Order');
    //               return false;
    //           }
}
function funcChangeType() {
    if (document.getElementById('ddlSupplier').value != 0) {
        document.getElementById("hdnSupplierID").value = document.getElementById('ddlSupplier').value;
    }

}


function onCalendarShown() {

    var cal = $find("calendar1");
    //Setting the default mode to month
    cal._switchMode("months", true);

    //Iterate every month Item and attach click event to it
    if (cal._monthsBody) {
        for (var i = 0; i < cal._monthsBody.rows.length; i++) {
            var row = cal._monthsBody.rows[i];
            for (var j = 0; j < row.cells.length; j++) {
                Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call);
            }
        }
    }
}

function onCalendarHidden() {
    var cal = $find("calendar1");
    //Iterate every month Item and remove click event from it
    if (cal._monthsBody) {
        for (var i = 0; i < cal._monthsBody.rows.length; i++) {
            var row = cal._monthsBody.rows[i];
            for (var j = 0; j < row.cells.length; j++) {
                Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call);
            }
        }
    }

}

function call(eventElement) {
    var target = eventElement.target;
    switch (target.mode) {
        case "month":
            var cal = $find("calendar1");
            cal._visibleDate = target.date;
            cal.set_selectedDate(target.date);
            cal._switchMonth(target.date);
            cal._blur.post(true);
            cal.raiseDateSelectionChanged();
            break;
    }
}

function onCalendarShown2() {

    var cal = $find("calendar2");
    //Setting the default mode to month
    cal._switchMode("months", true);

    //Iterate every month Item and attach click event to it
    if (cal._monthsBody) {
        for (var i = 0; i < cal._monthsBody.rows.length; i++) {
            var row = cal._monthsBody.rows[i];
            for (var j = 0; j < row.cells.length; j++) {
                Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call2);
            }
        }
    }
}

function onCalendarHidden2() {
    var cal = $find("calendar2");
    //Iterate every month Item and remove click event from it
    if (cal._monthsBody) {
        for (var i = 0; i < cal._monthsBody.rows.length; i++) {
            var row = cal._monthsBody.rows[i];
            for (var j = 0; j < row.cells.length; j++) {
                Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call2);
            }
        }
    }

}

function call2(eventElement) {
    var target = eventElement.target;
    switch (target.mode) {
        case "month":
            var cal = $find("calendar2");
            cal._visibleDate = target.date;
            cal.set_selectedDate(target.date);
            cal._switchMonth(target.date);
            cal._blur.post(true);
            cal.raiseDateSelectionChanged();
            break;
    }
}

function getPrecision(obj) {
    obj.value = obj.value == "" ? parseFloat(0).toFixed(2) : parseFloat(obj.value).toFixed(2);
}


function getMonthValue(source, str) {
    if (isNaN(str == true)) {
        var month_names = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
    }
    else {
        var month_names = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    }
    for (var i = 0; i < month_names.length; i++) {
        if (month_names[i] == source) {
            return i;
        }
    }
}

function CheckDatesMfg(splitChar, ObjDate, flag) {

    var today = GetServerDate();

    if (ObjDate.value.trim() == '') {
        if (flag == "MFG") {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_36") == null ? "Provide Manufactured Date!" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_36");
            ValidationWindow(userMsg, errorMsg);
        }
        else {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_37") == null ? "Provide Expiry Date!" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_37");
            ValidationWindow(userMsg, errorMsg);
        }
        //alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
        ObjDate.select();
        return false;
    }
    else {
        //Assign From And To Date from Controls
        splitChar = ObjDate.value.split(' ').length > 1 ? splitChar : '/';
        var DateFrom = new Array(2);
        var DateNow = new Array(2);
        var str = ObjDate.value.split(splitChar)[0];
    
        DateFrom[0] = (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1,str);
        DateFrom[1] = ObjDate.value.split(splitChar)[1];
        // DateTo = ("01" + splitChar + (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1) + splitChar + ObjDate.value.split(splitChar)[1]).split(splitChar);
        DateNow[0] = today.getMonth() + 1;
        DateNow[1] = today.getFullYear();
        //Argument Value 0 for validating Current Date And To Date 
        //Argument Value 1 for validating Current From And To Date
        if (doDateValidation(DateFrom, DateNow, 0)) {
            //       alert("Validation Succeeded");
            return true;
        }
        else {
            ObjDate.select();
            return false;
        }
    }

}
function CheckDatesExp(splitChar, ObjDate, flag) {

    var today = GetServerDate();

    if (ObjDate.value.trim() == '') {
        if (flag == "MFG") {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_36") == null ? "Provide Manufactured Date!" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_36");
            ValidationWindow(userMsg, errorMsg);
        }
        else {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_37") == null ? "Provide Expiry Date!" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_37");
            ValidationWindow(userMsg, errorMsg);
        }
        //alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
        ObjDate.select();
        return false;
    }
    else {
        //Assign From And To Date from Controls
        splitChar = ObjDate.value.split(' ').length > 1 ? splitChar : '/';
        var DateFrom = new Array(2);
        var DateNow = new Array(2);
        var str = ObjDate.value.split(splitChar)[0];
        DateFrom[0] = (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1,str);
        DateFrom[1] = ObjDate.value.split(splitChar)[1];
        // DateTo = ("01" + splitChar + (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1) + splitChar + ObjDate.value.split(splitChar)[1]).split(splitChar);
        DateNow[0] = today.getMonth() + 1;
        DateNow[1] = today.getFullYear();
        //Argument Value 0 for validating Current Date And To Date 
        //Argument Value 1 for validating Current From And To Date
        if (doDateValidation(DateNow, DateFrom, 1)) {
            //       alert("Validation Succeeded");
            return true;
        }
        else {
            ObjDate.select();
            return false;
        }
    }

}

function doDateValidation(from, to, bit) {
    var monthFlag = true;
    var i = from.length - 1;
    if (Number(to[i]) >= Number(from[i])) {
        if (Number(to[i]) == Number(from[i])) {
            monthFlag = false;
        }
        i--;
        if (Number(to[i]) >= Number(from[i])) {
            return true;
        }
        else if (monthFlag) {
            return true;
        }
        else {
            if (bit == 0) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_31") == null ? "Mismatch Month Between Current & Mfg Date" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_31");
 ValidationWindow(userMsg, errorMsg);
            }
            else {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_32") == null ? "Mismatch Month Between Current & Exp Date" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_32");
 ValidationWindow(userMsg, errorMsg);
            }
            return false;
        }
    }
    else {
        if (bit == 0) {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_33") == null ? "Mismatch Year Between Current & Mfg Date" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_33");
 ValidationWindow(userMsg, errorMsg);
        }
        else {
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_34") == null ? "Mismatch Year Between Current & Exp Date" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_34");
 ValidationWindow(userMsg, errorMsg);
        }
        return false;
    }
}

////////////////////////////////////////////////////auto comp/////////////////////
function fnSelectedProducts(source, eventArgs) {

    var lis = eventArgs.get_value();
    AddProductDetails(lis);
}

function fnClear(obj) {
    if (obj != "Pro") {

        document.getElementById('hdnProductName').value = "";
        document.getElementById('txtProductName').value = "";
    }

    document.getElementById('hdnproductId').value = "";
    document.getElementById('ddlCategory').value = "0";
    document.getElementById('txtBatchNo').value = "";
    document.getElementById('txtMFTDate').value = "";
    document.getElementById('txtEXPDate').value = "";
    document.getElementById('txtPoQuantity').value = "";
    document.getElementById('txtPoUnit').value = "";
    document.getElementById('txtRECQuantity').value = "";
    document.getElementById('txtRcvdUnit').value = "";

    document.getElementById('txtCompQuantity').value = "";
    document.getElementById('txtUnitPrice').value = "";

    document.getElementById('txtDiscount').value = "";
    document.getElementById('txtTax').value = "";

    document.getElementById('txtTotalCost').value = "";
    document.getElementById('hdnType').value = "";
    document.getElementById('add').value = 'Add';

    document.getElementById('hdnAdd').value = 'Add';

    document.getElementById('txtSellingPrice').value = "";
    document.getElementById('ddlSelling').value = "0";
    document.getElementById('txtInvoiceQty').value = "";
    document.getElementById('txtRcvdLSUQty').value = "";
    document.getElementById('hdnUnitCostPrice').value = 0;
    document.getElementById('hdnUnitSellingPrice').value = 0;
    document.getElementById('hdnAttributes').value = "N";
    document.getElementById('hdnAttributeDetail').value = "N"; ;
    document.getElementById('hdnHasExpiryDate').value = "N"; ;
    document.getElementById('hdnHasBatchNo').value = "N"; ;
    document.getElementById('hdnGridPopCount').value = 0;
    document.getElementById('txtRakNo').value = "";
    document.getElementById('txtMRP').value = "";
    // document.getElementById('txtNominal').value = "0";
    document.getElementById('ddlSelling').disabled = false;

    //*****jayamoorthi************
    document.getElementById('txtGrandwithRoundof').value = '0.00';
    ToTargetFormat($('#txtGrandwithRoundof'));
    //****************
    document.getElementById('TableProductDetails').style.display = "table";


}


function checkDate(obj) {

    var myValStr = document.getElementById(obj).value;
    if (myValStr != "___/____" && myValStr != "") {
        var Mon = myValStr.split('/')[0];
        var isTrue = false;

        var myMonth = new Array('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');

        for (i = 0; i < myMonth.length; i++) {
            if (myMonth[i] != "" && Mon != "" && Mon.toLowerCase() == myMonth[i].toLowerCase() && Mon.length == 3) {
                isTrue = true;
            }
        }

        if (!isTrue) {
            document.getElementById(obj).focus();
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_35") == null ? "Provide valid date" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_35");
 ValidationWindow(userMsg, errorMsg);
        }
        return isTrue;
    }


}


function checkDate1(obj) {

    var myValStr = document.getElementById(obj).value;
    if (myValStr != "__/____" && myValStr != "") {
        var Mon = myValStr.split('/')[0];
        var isTrue = false;

        var myMonth = new Array('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12');

        for (i = 0; i < myMonth.length; i++) {
            if (myMonth[i] != "" && Mon != "" && Mon == myMonth[i] && Mon.length == 2) {
                isTrue = true;
            }
        }

        if (!isTrue) {
           // document.getElementById(obj).focus();
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_35") == null ? "Provide valid date" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_35");
 ValidationWindow(userMsg, errorMsg);
        }
        return isTrue;
    }


}


//  ProductName+'~'+                                    
//  CategoryName+'~'+                                    
//  CONVERT(varchar,P.CategoryId)+'~'+                                    
//  BatchNo+'~'+                                    
//  CONVERT(varchar, convert(varchar(4),Manufacture,100)  + convert(varchar(4),year(Manufacture)))+'~'+                                     
//  CONVERT(varchar, convert(varchar(4),ExpiryDate,100)  + convert(varchar(4),year(ExpiryDate)))+'~'+                                     
//  CONVERT(varchar,POQuantity)+'~'+                                    
//  POUnit+'~'+                                    
//  CONVERT(varchar, RECQuantity)+'~'+                                    
//   RECUnit+'~'+                                    
//  CONVERT(varchar,ComplimentQTY )+'~'+                                    
//  CONVERT(varchar,UnitPrice) +'~'+                                    
//  CONVERT(varchar,Discount)+'~'+                                    
//   CONVERT(varchar,P.TaxPercent)+'~'+                                     
//  CONVERT(varchar,TotalCost)+'~'+                                    
//  ''+'~'+                                    
//  CONVERT(varchar,SellingPrice)+'~'+                                    
//  SellingUnit+'~'+                                    
//  CONVERT(varchar,InvoiceQty )+'~'+                                    
//  CONVERT(varchar,RcvdLSUQty)+'~'+                                    
//  CONVERT(varchar,cast(UnitCostPrice as decimal(18,6)))+'~'+                                    
//  CONVERT(varchar, UnitSellingPrice)+'~'+                                    
//  CASE ISNULL(P.HasAttributes,'N') WHEN 'Y'                                            
//  THEN P.Attributes                
//  ELSE 'N'                                         
//  END +'~'+ AttributeDetail+'~'+                                    
//  CASE ISNULL(P.HasExpiryDate,'N') WHEN 'Y'                                            
//  THEN P.HasExpiryDate         
//  ELSE 'N'                            
//  END +'~'+                                        
//  CASE ISNULL(P.HasBatchNo,'N') WHEN 'Y'                                            
//  THEN P.HasBatchNo                                            
//  ELSE 'N'                            
//  END +'~'+  CONVERT(varchar,(RcvdLSUQty+isnull(ComplimentQTY,0))) +'~'+ISNULL(RakNo,'--')+'~'+CONVERT(Varchar,MRP)+'~' +CONVERT(varchar,ISNULL(Nominal,0))
function conversionval() {
    var x = document.getElementById('hdnLanguageProductList').value.split("^");

    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            var y = x[i].split("~");
            if (y != "") {
                document.getElementById('hdnfdisplaydata').value = y[7];
                var POQuantity = ToTargetFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[9];
                var RecQuantity = ToTargetFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[11];
                var CompQty = ToTargetFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[12];
                var UnitPrice = ToTargetFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[13];
                var Discount = ToTargetFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[14];
                var Tax = ToTargetFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[15];
                var TotalCost = ToTargetFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[17];
                var SellingPrice = ToTargetFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[19];
                var InvoiceQty = ToTargetFormat($('#hdnfdisplaydata'));


                document.getElementById('hdnfdisplaydata').value = y[20];
                var RcvdLSUQty = ToTargetFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[21];
                var unitCostPrice = ToTargetFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[22];
                var unitSellingPrice = ToTargetFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[27];
                var ComQty = ToTargetFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[29];
                var MRP = ToTargetFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[30];
                var Nominal = ToTargetFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnProductList').value += y[0] + "~" + //Productid
                                                                   y[1] + "~" + //ProductName
                                                                   y[2] + "~" + //CategoryName
                                                                   y[3] + "~" + //CategoryId
                                                                   y[4] + "~" + //BatchNo
                                                                   y[5] + "~" + // Manufacture
                                                                   y[6] + "~" + //ExpiryDate
                                                                   POQuantity + "~" + //POQuantity
                                                                   y[8] + "~" + //POUnit
                                                                   RecQuantity + "~" + //RECQuantity
                                                                   y[10] + "~" + //RECUnit
                                                                   CompQty + "~" + //ComplimentQTY
                                                                   UnitPrice + "~" + //UnitPrice
                                                                   Discount + "~" + //Discount
                                                                   Tax + "~" + // TaxPercent
                                                                   TotalCost + "~" + // TotalCost
                                                                   y[16] + "~" + //
                                                                   SellingPrice + "~" + //SellingPrice
                                                                   y[18] + "~" + //SellingUnit
                                                                   InvoiceQty + "~" + //InvoiceQty
                                                                   RcvdLSUQty + "~" + //RcvdLSUQty
                                                                 unitCostPrice + "~" + //UnitCostPrice
                                                                unitSellingPrice + "~" + //UnitSellingPrice
                                                            y[23] + "~" + //HasAttributes
                                                        y[24] + "~" + //AttributeDetail
                                                   y[25] + "~" + //HasExpiryDate
                                                y[26] + "~" + //HasBatchNo
                                             ComQty + "~" + //ComplimentQTY + Rcvdlsuqty
                                        y[28] + "~" + //Rakno
                                    MRP + "~" + //MRP
                                Nominal + "^"; //Nominal


                //               document.getElementById('hdnProductList').value = pId + "~" + pName + "~" +
                //                                    pCategory + "~" + pCategoryId + "~" + pBatchNo + "~" +
                //                                    pMFTDate + "~" + pEXPDate + "~" + pPoQuantity + "~" +
                //                                    pPoUnit + "~" + pRECQuantity + "~" +
                //                                    pRECUnit + "~" + pCompQTY + "~" + pUnitPrice + "~" + pDiscount + "~" + pTax
                //                                    + "~" + pTotalCost + "~" + pTQty + "~" + pSellingPrice + "~" + pSellingUnit + "~" +
                //                                    pInvoiceQty + "~" + pRcvdLSUQty + "~" + pUnitCostPrice + "~" + pUnitSellingPrice + "~" +
                //                                    pAttrib + "~" + pAttribDetail + "~" + pHasExpDate + "~" +
                //                                    pHasBatchNo + "~" + pAttCount + "~" + pRakNo + "~" + pMRP + "~" + pNominal + "^";              


            }
        }
    }

}

    
