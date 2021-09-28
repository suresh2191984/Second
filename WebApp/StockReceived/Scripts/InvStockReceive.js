/*
var errorMsg = SListForAppMsg.Get("Scripts_Error") == null ? "Information" : SListForAppMsg.Get("Scripts_Error");
var infromMsg = SListForAppMsg.Get("Scripts_Information") == null ? "Information" : SListForAppMsg.Get("Scripts_Information");
var OkMsg = SListForAppMsg.Get("Scripts_Ok") == null ? "Ok" : SListForAppMsg.Get("Scripts_Ok");
var CancelMsg = SListForAppMsg.Get("Scripts_Cancel") == null ? "Cancel" : SListForAppMsg.Get("Scripts_Cancel");
*/
var errorMsg = SListForAppMsg.Get("Scripts_Error") == null ? "Alert" : SListForAppMsg.Get("Scripts_Error");
var lstProductList = [];

function checkDetails() {
    //alert("jkhjkh");
    $('#hdnTotalTax').val($('#txtTaxAmt').val());
    $('#hdnTotalDiscount').val($('#txtDiscountAmt').val());
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
        if (document.getElementById('hdnDCNo').value == "N") {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_04") == null ? "Enter DC Number/InvoiceNo" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_04");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtDCNumber').focus();
            document.getElementById('txtProductName').value = "";
            // document.getElementById('btnFinish').style.display = 'block';
            return false;
        }
    }
    if (document.getElementById('txtDCNumber').value == "" && document.getElementById('txtInvoiceNo').value == "") {
        if (document.getElementById('hdnDCNo').value == "Y") {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_38") == null ? "Enter Ref Inv No/InvoiceNo" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_38");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtDCNumber').focus();
            document.getElementById('txtProductName').value = "";
            // document.getElementById('btnFinish').style.display = 'block';
            return false;
        }
    }

    if ($('#txtInvoiceNo').val() != "" && $('#txtInvoiceDate').val() == "") {
        $('#imagInvoiceDate').attr("disabled", false);
       // $('#txtInvoiceDate').attr("disabled", true);
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
    if (ToInternalFormat($('#txtGrandTotal')) != 0.00 ) {
        document.getElementById('hdnGrandTotal').value = ToInternalFormat($('#txtGrandTotal'));
    }
    var arrCostPrice = $.grep(lstProductList, function(n, i) {
        //$('#hdnCostPrice').val(n.UnitPrice);
        return n.UnitPrice > 0
    });
    //if (document.getElementById('txtGrandTotal').value != 0.00) {
    if (ToInternalFormat($('#txtGrandTotal')) != 0.00 || arrCostPrice.length == 0) {
        //document.getElementById('hdnGrandTotal').value = document.getElementById('txtGrandTotal').value;
        document.getElementById('hdnGrandTotal').value = ToInternalFormat($('#txtGrandTotal'));
        //ToTargetFormat($('#txtGrandTotal'));
        //ToTargetFormat($('#hdnGrandTotal'));
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
/*

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

    if (document.getElementById('txtMFTDate').value == '') {
        var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_36") == null ? "Provide Manufactured Date!" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_36");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtMFTDate').focus();
        return false;
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
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_17") == null ? "Provide Inverse Qty" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_17");
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
    var _flag = true;
    $('#tbTotalCost').removeClass().addClass('displaytb w-100p');
    if (document.getElementById('hdnHasBatchNo').value != 'N') {
       
        
        _flag =  CheckDatesMfg(' ', document.getElementById('txtMFTDate'), 'MFG') == true ? CheckDatesExp(' ', document.getElementById('txtEXPDate'), 'EXP') : false;
       
    }
   
    if (_flag == true) {
        var flag = true;
        flag = BindProductList(flag);
        if (flag == true) {
            return true;
        } else {
        return false;
        }
    }
    else {
        return false;
    }
    
} */

function getFocus() {
    document.getElementById('txtSearchTxt').focus();
}

/*
function AddProductDetails(obj) {

    var p = obj.split('~');
    var pDetails = p[9].split('|');
    var pTax;
    document.getElementById('hdnOnDeleteReset').value = obj;
    var pBac = pDetails[0];
    var pMaf = pDetails[1];
    var pExp = pDetails[2];
    var pInQty = pDetails[3] == 0 || pDetails[3] == "" ? 1 : pDetails[3];
    //var pSellUn = pDetails[4];
    var pSellUn = p[12];
    var pCostPr = pDetails[5];
    var pSellPr = pDetails[6];
    if(pDetails[7]=="" || pDetails[7]=="0")
    {
    pTax = p[12];
    }
    else 
    {
   pTax = pDetails[7];
    }
    var pUniCostPr = pDetails[8];
    var pUnitSellPr = pDetails[9];
    var pMRP = pDetails[9];
    var rakno = pDetails[10];

    document.getElementById('txtRakNo').value = rakno;
    var compqty = "" ? 0.00 : p[15];
    var PurTax=p[16]==""?0.00:p[16];
     $('#txtPurchaseTax').val(PurTax);
    document.getElementById('hdnActlRecedQty').value = p[5];
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

    document.getElementById('txtUnitPrice').value = p[14]==undefined? '0.00' : p[14];// pUniCostPr;
    ToTargetFormat($('#txtUnitPrice'));
    document.getElementById('txtTotalCost').value = 0.00;
    ToTargetFormat($('#txtTotalCost'));
    document.getElementById('txtTotalCost').readOnly = true;
    document.getElementById('txtCompQuantity').value = p[15]=undefined? '0.00' : p[15];//0.00;
    ToTargetFormat($('#txtCompQuantity'));
    document.getElementById('txtTax').value =  p[13]=undefined? '0.00' : p[13];//pTax;
    ToTargetFormat($('#txtTax'));
    document.getElementById('txtDiscount').value =p[12]=undefined? '0.00' : p[12];//0.00;
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
    document.getElementById('txtCompQuantity').value = p[15];
    ToTargetFormat($('#txtCompQuantity'));
    


} */
function POQtyAndRecdQtyCompValidation(obj) {
    var AllowedQty = document.getElementById('hdnAllowedQty').value;
    var ReqRECQuantity = document.getElementById('txtRECQuantity').value; 
    var ActualRcdQty = document.getElementById('hdnActlRecedQty').value; 
    var TotalPoQuantity = document.getElementById('txtPoQuantity').value.replace(',','');    
    var TotalRecQty = (Number(document.getElementById('txtRECQuantity').value) + Number(document.getElementById('hdnActlRecedQty').value))
    if (parseInt(TotalRecQty) > parseInt(TotalPoQuantity)) {
       // alert('Received Qty Higher than PO Quantity');
        var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_39") == null ? "Received Qty Higher than PO Quantity" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_39");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtRECQuantity').value = '';
    }
}
/*
function BindProductList(flag) {
    if (document.getElementById('hdnAttributes').value == 'N') {
        document.getElementById('hdnGridPopCount').value = (Number(document.getElementById('txtRcvdLSUQty').value) + Number(document.getElementById('txtCompQuantity').value))
    }

    if (document.getElementById('hdnAttributes').value != 'N' && Number(document.getElementById('hdnGridPopCount').value) != (Number(document.getElementById('txtRcvdLSUQty').value) + Number(document.getElementById('txtCompQuantity').value))) {
        if (document.getElementById('hdnAttributeDetail').value == '') {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_21") == null ? "Provide the attributes" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_21");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('lbtnAttribute').focus();
            flag = false;
            return false;
        }
        else {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_27") == null ? "The number of product and detail does not match" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_27");
            ValidationWindow(userMsg, errorMsg);
            flag = false;
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
        var PurchTax=$('#txtPurchaseTax').val()==""?0.00:$('#txtPurchaseTax').val();
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
                                     + pRakNo + "~" + pMRP + "~" + pNominal +'~'+PurchTax+ "^" +
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
    var PurchaseTax='';
    var Purch='';
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
        PurchaseTax = "<th style='width:85px;' class='tbltax hide' >Purchase Tax %</th>";  
    }
    else {
        strTax = "<th class='tbltax' >Tax %</th>";
        PurchaseTax = "<th style='width:85px;' class='tbltax' >Purchase Tax %</th>";  

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
    var MRP = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_14") == null ? "MRP/SRP" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_14");
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
                            +PurchaseTax
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
	    Purch = "<td class='a-right'>" + y[31] + "</td>";
			 var dateMFT = ToInternalMonth(y[5]);
                var dateEXP = ToInternalMonth(y[6]);
            tr += "<tr class='gridView w-100p'><td >"
                        + y[1] + "</td><td>"
                        + y[4] + "</td><td><table><tr ><td>MFT: "
                        + ToExternalMonth(dateMFT) + "</td></tr><tr><td>EXP: "
                        + ToExternalMonth(dateEXP) + "</td></tr></table></td><td>"
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
                       "<td class='a-right'>" + y[31] + "</td><td class='a-right'>" 
                       + y[17] + "</td><td class='a-right'>"
                        + y[29] + "</td><td class='a-right'>"
                        + y[28] + "</td><td class='a-right'>"
                        + y[15] + "</td>"
                         + "<td><input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "~" + y[23] + "~" + y[24] + "~" + y[25] + "~" + y[26] + "~" + y[27] + "~" + y[28] + "~" + y[29] + "~" + y[30]  +"~"+ y[31]+ "' onclick='btnEdit_OnClick(name);' type='button' Class='ui-icon ui-icon-pencil b-none pointer pull-left' />"
                        + "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "~" + y[23] + "~" + y[24] + "~" + y[25] + "~" + y[26] + "~" + y[27] + "~" + y[28] + "~" + y[29] + "~" + y[30]  +"~"+ y[31] + "' onclick='btnDelete(name);'  type='button' Class='ui-icon ui-icon-trash b-none pointer'/></td></tr>";
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
            var _PurTax=0;
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
            $('#hdnTempValue').val(y[31]);
            _PurTax = parseFloat(ToInternalFormat($('#hdnTempValue'))).toFixed(2);

            if ($('#hdnREQCalcCompQTY').val() == 'Y') {
            if(y[31]!=undefined && y[31]!=""){
            if(y[31]>0)
            {
            document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) + 
            parseFloat(parseFloat(parseFloat(_PurTax) / 100) * 
            (parseFloat(parseFloat(parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * 
            (parseFloat(_RcvdLSUQtyNo) + parseFloat(y[11]))) - parseFloat(parseFloat(parseFloat(parseFloat(_Discount) / 100) * 
            (parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * 
            (parseFloat(_RcvdLSUQtyNo) + parseFloat(+parseFloat(y[11])))))))))).toFixed(2);
            }
            else
            {
            document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) + parseFloat(parseFloat(parseFloat(_Tax) / 100) * (parseFloat(parseFloat(parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo) + parseFloat(y[11]))) - parseFloat(parseFloat(parseFloat(parseFloat(_Discount) / 100) * (parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo) + parseFloat(+parseFloat(y[11])))))))))).toFixed(2);
            }
            }
            else
            {
            document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) + parseFloat(parseFloat(parseFloat(_Tax) / 100) * (parseFloat(parseFloat(parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo) + parseFloat(y[11]))) - parseFloat(parseFloat(parseFloat(parseFloat(_Discount) / 100) * (parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo) + parseFloat(+parseFloat(y[11])))))))))).toFixed(2);
            }            
            }
            else {
            if(y[31]!=undefined && y[31]!=""){
            if(y[31]>0)
            {
            document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) + 
            parseFloat(parseFloat(parseFloat(_PurTax) / 100) * (parseFloat(parseFloat(parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * 
            (parseFloat(_RcvdLSUQtyNo))) - parseFloat(parseFloat(parseFloat(parseFloat(_Discount) / 100) * 
            (parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo))))))))).toFixed(2);
             }
             else
                {
                document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) + parseFloat(parseFloat(parseFloat(_Tax) / 100) * (parseFloat(parseFloat(parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo))) - parseFloat(parseFloat(parseFloat(parseFloat(_Discount) / 100) * (parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo))))))))).toFixed(2);
                }
                }
                else
                {
                document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) + parseFloat(parseFloat(parseFloat(_Tax) / 100) * (parseFloat(parseFloat(parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo))) - parseFloat(parseFloat(parseFloat(parseFloat(_Discount) / 100) * (parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo))))))))).toFixed(2);
                }
            }
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
    //btnEdit_OnClick(sEditedData);
    Tblist();
}
*/
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
    btnCalcSellingPrice();
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
    var PurchaseTax = ToInternalFormat($('#txtPurchaseTax')) == 0.00 ? 0 : ToInternalFormat($('#txtPurchaseTax'));
    //added  For CompQuantity Tax Calculation Based on LSUUnitCost 31-8-2016
    var LsuUnitPrice = ToInternalFormat($('#hdnUnitCostPrice')) == 0.00 ? 0 : ToInternalFormat($('#hdnUnitCostPrice'));
    //end 
    if (Inverse > 0) {
        UnitPrice = pNominalDiscount > 0 ? parseFloat(parseFloat(UnitPrice) - parseFloat(pNominalDiscount)).toFixed(6) : UnitPrice;

        RECQuantity = Number(RECQuantity) / Number(Inverse);
        var TotalCost = (parseFloat(RECQuantity) * parseFloat(UnitPrice)).toFixed(6);

        pDiscount = parseFloat(parseFloat(parseFloat(TotalCost) / parseFloat(100)) * parseFloat(Discount)).toFixed(6);


        Total = parseFloat(parseFloat(TotalCost) - parseFloat(pDiscount)).toFixed(6);
        /*Sathish--Guname PurchaseTax Calc.*/
       // if(PurchaseTax>0)
       // {
        tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(6);
        //}
       /* else
        {
        tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(6);
        }*/

        document.getElementById('txtTotalCost').value = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);

        if ($('#hdnREQCalcCompQTY').val() == 'Y') {
            var ComQtyCost = parseFloat(CompQuantity) * parseFloat(LsuUnitPrice).toFixed(2);
            var TotComTax = parseFloat((parseFloat(ComQtyCost) / parseFloat(100) * parseFloat(PurchaseTax)) + parseFloat($('#txtTotalCost').val())).toFixed(2);
            $('#txtTotalCost').val(TotComTax);
        }
        else {
            TotComTax = 0.00;
        
        }
        
        // code new changes end
        

        ToTargetFormat(($('#txtTotalCost')));
    }

    if ($('#hdnIsSellingPriceTypeRuleApply').val() == 'Y') {
        var SellingPrice = 0;
        SellingPrice = parseFloat(Discount) > 0 ? (parseFloat(UnitPrice) - (parseFloat(UnitPrice) * parseFloat(Discount) / 100)) : UnitPrice;
        SellingPrice = parseFloat(ToInternalFormat($("#txtPurchaseTax"))) > 0 ? (parseFloat(SellingPrice) + (parseFloat(SellingPrice) * parseFloat(ToInternalFormat($("#txtPurchaseTax"))) / 100)) : SellingPrice;
        $('#txtSellingPrice').val(SellingPrice);
        $('#txtMRP').val(SellingPrice);
        ToTargetFormat($("#txtSellingPrice"));
        document.getElementById('hdnUnitSellingPrice').value = parseFloat(SellingPrice).toFixed(6);
        ToTargetFormat($('#hdnUnitSellingPrice'));
        ToTargetFormat($("#txtMRP"));

        var TotalMargin = 0, TotalCost = 0;
        TotalMargin = $("#hdnMarginValue").val();
        TotalMargin = parseFloat(parseFloat(ToInternalFormat($("#txtTotalCost"))) * parseFloat(TotalMargin)).toFixed(2);
        TotalCost = parseFloat(parseFloat(ToInternalFormat($("#txtTotalCost"))) + parseFloat(TotalMargin)).toFixed(2);
        $('#txtTotalCost').val(TotalCost);
        ToTargetFormat($("#txtTotalCost"));
        $("#txtSellingPrice").attr("disabled", "disabled");
        $("#txtMRP").attr("disabled", "disabled");

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
       // ToTargetFormat($('#hdnUnitCostPrice'));
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


/*
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
        var PurchTax=$('#txtPurchaseTax').val()==""?0.00:$('#txtPurchaseTax').val();
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
                                    pHasBatchNo + "~" + pAttCount + "~" + pRakNo + "~" + pMRP + "~" + pNominal + "~"+PurchTax+"^";

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
	var dateMFT = ToInternalMonth(y[5]);
        var dateEXP = ToInternalMonth(y[6]);
    document.getElementById('txtMFTDate').value = ToExternalMonth(dateMFT);
    document.getElementById('txtEXPDate').value = ToExternalMonth(dateEXP);
    document.getElementById('txtPoQuantity').value = y[7];
    document.getElementById('txtPoUnit').value = y[8];
    document.getElementById('txtRECQuantity').value = y[9];
    document.getElementById('txtRcvdUnit').value = y[10];

    document.getElementById('txtCompQuantity').value = y[11];
    $('#txtPurchaseTax').val(y[31]);
    document.getElementById('txtUnitPrice').value = y[12];

    document.getElementById('txtDiscount').value = y[13];
    document.getElementById('txtTax').value = y[14];

    document.getElementById('txtTotalCost').value = y[15];
    document.getElementById('hdnRowEdit').value = sEditedData;
    document.getElementById('hdnType').value = y[16];

    var objadd = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_18") == null ? "Update" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_18");

    document.getElementById('add').value = 'Update';
    $('#add').text(objadd);
    
   
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
    return false;
}

*/

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

    if (Number(pRECQuantity) > Number(ToInternalFormat($('#txtPoQuantity')))) {
        var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_26") == null ? "Provide received quantity less than or equal to ordered qty" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_26");      

//        ValidationWindow(userMsg, errorMsg);
//        $("#txtRECQuantity").val("0.00");
//        $('#txtRcvdLSUQty').val("0.00");
//        document.getElementById('txtRECQuantity').focus();
        return false;        
       
    }
    else {

        //CheckCompQty();
        if (document.getElementById('hdnAttributes').value == "N") {
            // document.getElementById('hdnGridPopCount').value = (Number(document.getElementById('txtRcvdLSUQty').value) + Number(document.getElementById('txtCompQuantity').value));
            document.getElementById('hdnGridPopCount').value = (Number(ToInternalFormat($('#txtRcvdLSUQty'))) + Number(ToInternalFormat($('#txtCompQuantity'))));
        }
        TotalCalculation();
    }


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
    var pSellingUnit = document.getElementById('ddlSelling').value;
    
    if (pRECUnit == pSellingUnit) {    
        $('#txtInvoiceQty').val('1');
        $('#txtInvoiceQty').attr("disabled", "disabled");  
    }

    else {        
        $('#txtInvoiceQty').val('0.00');
        ToTargetFormat($('#txtInvoiceQty'));
        $('#txtInvoiceQty').removeAttr('disabled');
        $("#txtInvoiceQty").prop("disabled", false);


    }
    
    CheckRcvdLSUQty();



}

function checkAddToTotal() {
    if (document.getElementById('txtTotalDiscount').value.trim() == '')
        document.getElementById('txtTotalDiscount').value = "0.00";
    if (document.getElementById('txtTotaltax').value.trim() == '')
        document.getElementById('txtTotaltax').value = "0.00";
    ToTargetFormat($('#txtTotaltax'));
    ToTargetFormat($('#txtTotalDiscount'));
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
        var rtn = CheckFromToMonth($('#txtMFTDate').val(), $('#txtEXPDate').val());
        if (rtn == false) {
            //  $('#txtMFTDate').focus();

            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_35") == null ? "Provide valid date" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_35");
            ValidationWindow(userMsg, ErrorMsg);

            return false;
        }

        return true;
      
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
        var rtn = CheckFromToMonth($('#txtMFTDate').val(), $('#txtEXPDate').val());
        if (rtn == false) {
            //  $('#txtMFTDate').focus();

            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_35") == null ? "Provide valid date" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_35");
            ValidationWindow(userMsg, ErrorMsg);

            return false;
        }

        return true;
      
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
/*function fnSelectedProducts(source, eventArgs) {

    var lis = eventArgs.get_value().split('|');
    var rakno = lis[10];

    document.getElementById('txtRakNo').value = rakno;

    AddProductDetails(lis);
}
 */
function fnClear(obj) {
    if (obj != "Pro") {

        document.getElementById('hdnProductName').value = "";
        document.getElementById('txtProductName').value = "";
    }
    $('#txtPurchaseTax').val('');
    document.getElementById('hdnproductId').value = "";
    document.getElementById('ddlCategory').value = "0";
    document.getElementById('txtBatchNo').value = "";
    document.getElementById('txtMFTDate').value = "";
    document.getElementById('txtEXPDate').value = "";
    document.getElementById('txtPoQuantity').value = "";
    document.getElementById('txtPoUnit').value = "";
    document.getElementById('txtRECQuantity').value = "";
    
    //document.getElementById('txtRcvdUnit').value = "";
    $("#ddlRecUnit").empty();
    AddRecUnitDefault();
    
    document.getElementById('txtCompQuantity').value = "";
    document.getElementById('txtUnitPrice').value = "";

    document.getElementById('txtDiscount').value = "";
    document.getElementById('txtTax').value = "";

    document.getElementById('txtTotalCost').value = "";
    document.getElementById('hdnType').value = "";
    document.getElementById('add').value = 'Add';
    $('#add').text('Add');
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
    document.getElementById('hdnHasCostPrice').value = "N";
    document.getElementById('hdnHasSellingPrice').value = "N"; 
    document.getElementById('hdnGridPopCount').value = 0;
    document.getElementById('txtRakNo').value = "";
    document.getElementById('txtMRP').value = "";
    // document.getElementById('txtNominal').value = "0";
   // document.getElementById('ddlSelling').disabled = false;
    $('#ddlSelling option:not(:selected)').prop('disabled', false);


    //*****jayamoorthi************
    document.getElementById('txtGrandwithRoundof').value = '0.00';
    ToTargetFormat($('#txtGrandwithRoundof'));
    //****************
    document.getElementById('TableProductDetails').style.display = "table";
    $('.ww-300').html('<table class="gsttbl" border="1" rules="all"><tr><td>CGST(%)</td><td>SGST(%)</td><td>IGST(%)</td></tr><tr><td>0</td><td>0</td><td>0</td></tr></table>');

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

var curTxtDateID;
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
           
var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_35") == null ? "Provide valid date" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_35");
curTxtDateID = obj;
ValidationWindowResponse(userMsg, errorMsg, txtfocus);
        }
        return isTrue;
    }


}

function txtfocus() {
    $("#" + curTxtDateID).val("");
    $("#" + curTxtDateID).focus();
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
/*function conversionval() {
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
                document.getElementById('hdnfdisplaydata').value = y[31];
                var PurchaseTax = ToTargetFormat($('#hdnfdisplaydata'));

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
                                Nominal + "~"+PurchaseTax+"^"; //Nominal


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
*/

/*----------------------------------JSON---------------------------------*/
var CGST = 0;
var SGST = 0;
var IGST = 0;
function AddProductDetails(obj) {
    var p = JSON.parse(obj);
    document.getElementById('hdnOnDeleteReset').value =JSON.stringify(obj); 
    
    var compqty = "" ? 0.00 : p.ComplimentQTY;
    var PurTax = p.PurchaseTax == "" ? 0.00 : p.PurchaseTax;
    $('#txtPurchaseTax').val(PurTax);
    ToTargetFormat($('#txtPurchaseTax'));
    document.getElementById('hdnActlRecedQty').value = p.RECQuantity;
    ToTargetFormat($('#hdnActlRecedQty'));
    document.getElementById('hdnproductId').value = p.ProductID;
    document.getElementById('hdnProductName').value = p.ProductName;
    document.getElementById('txtProductName').value = document.getElementById('hdnProductName').value;
    document.getElementById('TableProductDetails').style.display = "table";
    document.getElementById('ddlCategory').value = p.CategoryID;
    document.getElementById('ddlCategory').disabled = true;
    document.getElementById('txtPoQuantity').value = p.POQuantity;
    ToTargetFormat($('#txtPoQuantity'));
    document.getElementById('txtPoUnit').value = p.Unit;   
    document.getElementById('txtPoQuantity').readOnly = true;
    document.getElementById('hdbTempQut').value = p.CategoryID;
    document.getElementById('txtBatchNo').value = '';          
    document.getElementById('txtEXPDate').value = '';
    document.getElementById('txtMFTDate').value = '';
    document.getElementById('txtRECQuantity').value = parseFloat(parseFloat(p.POQuantity).toFixed(2) - parseFloat(p.RECQuantity).toFixed(2)).toFixed(2);
    ToTargetFormat($('#txtRECQuantity'));
    //document.getElementById('txtRcvdUnit').value = p.Unit;
    document.getElementById('txtRcvdLSUQty').value = document.getElementById('txtRECQuantity').value;
    document.getElementById('hdnAllowedQty').value = parseFloat(parseFloat(p.POQuantity).toFixed(2) - parseFloat(p.RECQuantity).toFixed(2)).toFixed(2);
    ToTargetFormat($('#hdnAllowedQty'));
    //document.getElementById('ddlSelling').value = p.Unit;
    document.getElementById('ddlSelling').value = p.LSUnit;
    $('#ddlSelling option:not(:selected)').prop('disabled', true); 
    document.getElementById('txtPoUnit').readOnly = true;
    document.getElementById('txtUnitPrice').value = p.Amount == undefined ? '0.00' : p.Amount; // pUniCostPr;
    ToTargetFormat($('#txtUnitPrice'));
    document.getElementById('txtCompQuantity').value = p.ComplimentQTY = undefined ? '0.00' : p.ComplimentQTY; //0.00;
    ToTargetFormat($('#txtCompQuantity'));
    document.getElementById('txtTax').value = p.Tax = undefined ? '0.00' : p.Tax; //pTax;
    var GSTTax = p.Tax == "" ? 0.00 : p.Tax;
    ToTargetFormat($('#txtTax'));
    /* Start*/
    if (document.getElementById("CheckState").value == "Y") {
        CGST = p.Tax / 2;
        SGST = p.Tax / 2;
        IGST = 0

    }
    else {
        IGST = p.Tax;
        CGST = 0;
        SGST = 0;
    }
    $('.ww-300').html('<table class="gsttbl" border="1" rules="all"><tr><td>CGST(%)</td><td>SGST(%)</td><td>IGST(%)</td></tr><tr><td>' + CGST + '</td><td>' + SGST + '</td><td>' + IGST + '</td></tr></table>');
    /* END*/
    document.getElementById('txtDiscount').value = p.Discount = undefined ? '0.00' : p.Discount; //0.00;
    ToTargetFormat($('#txtDiscount'));
    document.getElementById('add').value = 'Add';
   

    ConvertOrderUnitList(p.OrderedUnitValues, p.Unit);
    POtotalOrderQty = $("#txtRcvdLSUQty").val();
    ExistsRecLSUQty = p.RcvdLSUQty;
    
    
    if ($('#hdnIsSellingPriceTypeRuleApply').val() == "Y") {
        //$('#hdnMarginValue').val(p.Marginvalue);
        $('#hdnMarginValue').val(p.NonReimbursableAmount);
    }

   //  if (p.Unit == 'Nos') {
    //    document.getElementById('ddlSelling').value = 'Nos';
//        document.getElementById('txtInvoiceQty').value = p.InvoiceQty;
//        ToTargetFormat($('#txtInvoiceQty'));
        document.getElementById('txtInvoiceQty').disabled = true;
        //document.getElementById('ddlSelling').disabled = true;
    //}
 //   else {
   //     document.getElementById('txtInvoiceQty').disabled = false;
    //    document.getElementById('ddlSelling').disabled = false;
  //  }
    //if (p.Unit == $('#ddlSelling').val()) {
      
      //  document.getElementById('txtInvoiceQty').value = 1;
      //  ToTargetFormat($('#txtInvoiceQty'));
     //   document.getElementById('txtInvoiceQty').disabled = true;
       // document.getElementById('ddlSelling').disabled = true;
  //  }
    if (p.Attributes != 'N') {
        document.getElementById('hdnAttributes').value = p.Attributes;
        document.getElementById('lbtnAttribute').style.display = "block"
    }
    else {
        document.getElementById('hdnAttributeDetail').value = p.Attributes;
        document.getElementById('lbtnAttribute').style.display = "none"
        document.getElementById('hdnAttributes').value = "N";
    }
    CheckRcvdLSUQty();
    document.getElementById('hdnHasExpiryDate').value = p.HasExpiryDate;
    document.getElementById('hdnHasBatchNo').value = p.HasBatchNo;
    document.getElementById('hdnHasCostPrice').value = p.HasCostPrice;
    document.getElementById('hdnHasSellingPrice').value = p.HasSellingPrice;
    if (p.HasUsage != 'N') {
        document.getElementById('hdnUsageLimit').value = p.UsageCount;
    }
    document.getElementById('txtNominal').value = 0.00;
    ToTargetFormat($('#txtNominal'));
    document.getElementById('txtCompQuantity').value = p.ComplimentQTY;
    ToTargetFormat($('#txtCompQuantity'));
    if ($('#hdnIsSellingPriceTypeRuleApply').val() != "Y") {
        var TotalCost = (parseFloat(ToInternalFormat($('#txtRECQuantity'))) * parseFloat(document.getElementById('txtUnitPrice').value)).toFixed(6);

        pDiscount = parseFloat(parseFloat(parseFloat(TotalCost) / parseFloat(100)) * parseFloat(p.Discount)).toFixed(6);


        Total = parseFloat(parseFloat(TotalCost) - parseFloat(pDiscount)).toFixed(6);
        /*Sathish--Guname PurchaseTax Calc.*/
        //if(PurTax>0)
        //{
        //tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(PurTax)).toFixed(6);
        tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(GSTTax)).toFixed(6);
        
       // }
       /* else
        {
        tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(document.getElementById('txtTax').value)).toFixed(6);
        }*/

        document.getElementById('txtTotalCost').value = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);

    }
    ToTargetFormat($('#txtTotalCost'));
    document.getElementById('txtTotalCost').readOnly = true;

   // Attune.Kernel.InventoryCommon.InventoryWebService.GetPOSRDetailsJSON($('#poNoid').val(), p.ProductID, SetValue);   
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

    /*if (document.getElementById('txtMFTDate').value == '') {
        var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_36") == null ? "Provide Manufactured Date!" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_36");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtMFTDate').focus();
        return false;
    }*/

    if (document.getElementById('hdnHasExpiryDate').value == 'Y') {
        if (document.getElementById('txtEXPDate').value == '') {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_10") == null ? "Provide expiry date" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_10");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtEXPDate').focus();
            return false;
        }
    }
    if (document.getElementById('hdnHasCostPrice').value == 'Y') {
        if (document.getElementById('txtUnitPrice').value == '') {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_16") == null ? "Provide Cost Price" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_16");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtUnitPrice').focus();
            return false;
        }
    }

    if (document.getElementById('hdnHasSellingPrice').value == 'Y') {
        if (document.getElementById('txtSellingPrice').value == '') {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_19") == null ? "Provide Selling Price" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_19");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtSellingPrice').focus();
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
    if ($('#hdnCompQty').val() == 'Y') {
        if ((ToInternalFormat($('#txtRECQuantity')) == 0.00) && (ToInternalFormat($('#txtCompQuantity')) == 0.00)) {
            var tempPOQty = ToInternalFormat($('#txtPoQuantity'));
            if (tempPOQty <= 0) {
                //alert('Provide comp quantity');
                var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_40") == null ? "Provide  ComplimentQuantity " : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_40");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtRECQuantity').focus();
            }
            else {
                //alert('Provide received or comp quantity');
                var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_41") == null ? "Provide received or  ComplimentQuantity" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_41");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtRECQuantity').focus();
            }
            document.getElementById('txtRECQuantity').focus();
            return false;
        }
    }
    else {
        if (ToInternalFormat($('#txtRECQuantity')) == 0.00) {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_13") == null ? "Provide received quantity" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_13");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtRECQuantity').focus();
            return false;
        }
    }
//    if (document.getElementById('txtRcvdUnit').value == '') {
//        var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_14") == null ? "Provide the received unit" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_14");
//        ValidationWindow(userMsg, errorMsg);
//        document.getElementById('txtRcvdUnit').focus();
//        return false;
//    }
    if (document.getElementById('ddlSelling').value == '0') {
        var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_15") == null ? "Select selling unit" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_15");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('ddlSelling').focus();
        return false;
    }
    if (ToInternalFormat($('#txtUnitPrice')) == 0.00 && $("hdnHasCostPrice").val()=='Y') {
        var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_16") == null ? "Provide cost price" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_16");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtUnitPrice').focus();
        return false;
    }   
    if (ToInternalFormat($('#txtInvoiceQty')) == 0.00) {
        var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_17") == null ? "Provide Inverse Qty" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_17");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtInvoiceQty').focus();
        return false;
    }
    if ($('#hdnCompQty').val() == 'Y') {
        if ((ToInternalFormat($('#txtRcvdLSUQty')) == 0.00) && (ToInternalFormat($('#txtCompQuantity')) == 0.00)) {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_41") == null ? "Provide received or  ComplimentQuantity" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_41");
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
    }
    else {
        if (ToInternalFormat($('#txtRcvdLSUQty')) == 0.00) {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_18") == null ? "Provide received LSU qty" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_18");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtRcvdLSUQty').focus();
            return false;
        }
    }   
    if (ToInternalFormat($('#txtSellingPrice')) == 0.00 && $("#hdnHasSellingPrice").val()=="Y") {
        var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_19") == null ? "Provide Selling Price" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_19");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtSellingPrice').focus();
        return false;
    }
    if (ToInternalFormat($('#txtMRP')) == 0.00 && $("#hdnHasSellingPrice").val() == "Y") {
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
    if ($('#hdnIsSellingPriceTypeRuleApply').val() != 'Y' && $("#hdnHasSellingPrice").val() == "Y" ) {
        if (Number(ToInternalFormat($('#txtSellingPrice'))) < Number(ToInternalFormat($('#txtUnitPrice')))) {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_22") == null ? "Provide Selling Price greater than Cost Price" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_22");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtSellingPrice').select();
            return false;
        }     
        if (Number(ToInternalFormat($('#txtMRP'))) < Number(ToInternalFormat($('#txtUnitPrice')))) {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_23") == null ? "Provide MRP greater than Cost Price" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_23");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtMRP').select();
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
        var tempQ = ToInternalFormat($('#txtPoQuantity'));
        var AllowedQty = ToInternalFormat($('#hdnAllowedQty'));
        if (Number(tempQ) > 0) {
            var arrF = $.grep(lstProductList, function(n, i) {
                return n.ProductID == pProductId && n.BatchNo == pBatchNo;
            });
            if (arrF.length > 0) {
                var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_24") == null ? "Product name and batch number combination already exist" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_24");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtBatchNo').focus();
                return false;
            }
        }
        else {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_25") == null ? "Ensure items added/quantity are provided properly" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_25");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtPoQuantity').focus();
            return false;
        }
    }      
    var pProductId = document.getElementById('hdnproductId').value;
  
    if (document.getElementById('add').value != 'Update') {        
       
        var pName = document.getElementById('hdnProductName').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        if (pBatchNo == '') {
            pBatchNo = '*';
        }
    }
     var PoQuantity = ToInternalFormat($('#txtPoQuantity'));
     var PoUnit = $('#txtPoUnit').val();
     var PoUnitValue = $("#ddlRecUnit option:contains(" + $.trim(PoUnit) + ")").val().split('~');
     POtotalOrderQty = (Number(PoUnitValue[1]) * Number(PoQuantity)) - Number(ExistsRecLSUQty);
   
        var arrF = $.grep(lstProductList, function(n, i) {
            return n.ProductID == pProductId;
        });
    
        var tempQ = POtotalOrderQty;
        var q = Number(ToInternalFormat($('#txtRcvdLSUQty')));
        var TotalQTY = q;
        
        $.each(arrF, function(obj, value) {
        TotalQTY = Number(TotalQTY) + Number(value.RcvdLSUQty);        
        });

    if (document.getElementById('add').value == 'Update') {
        TotalQTY = TotalQTY - EditRECLSUqty;
    }
        if (Number(TotalQTY) > Number(tempQ)) {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_26") == null ? "Provide received quantity less than or equal to ordered qty" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_26");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtPoQuantity').focus();
            return false;
        }  
    
    if (Avoidfuturedate()) {
        var _flag = true;
    }
    $('#tbTotalCost').removeClass().addClass('displaytb w-100p');
   /* No Need to validate based on batchno
   if (document.getElementById('hdnHasBatchNo').value != 'N') {
        _flag = CheckDatesMfg(' ', document.getElementById('txtMFTDate'), 'MFG') == true ? CheckDatesExp(' ', document.getElementById('txtEXPDate'), 'EXP') : false;
    }*/
    if (_flag == true) {
        var flag = true;
        flag = BindProductList(flag);
        if (flag == true) {
            return true;
        } else {
            return false;
        }
    }
    else {
        return false;
    }
}

function BindProductList(flag) {
    if (document.getElementById('hdnAttributes').value == 'N') {
        document.getElementById('hdnGridPopCount').value = (Number(document.getElementById('txtRcvdLSUQty').value) + 
        Number(document.getElementById('txtCompQuantity').value))
    }

    if (document.getElementById('hdnAttributes').value != 'N' && Number(document.getElementById('hdnGridPopCount').value) != 
    (Number(document.getElementById('txtRcvdLSUQty').value) + Number(document.getElementById('txtCompQuantity').value))) {
        if (document.getElementById('hdnAttributeDetail').value == '') {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_21") == null ? "Provide the attributes" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_21");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('lbtnAttribute').focus();
            flag = false;
            return false;
        }
        else {
            var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_27") == null ? "The number of product and detail does not match" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_27");
            ValidationWindow(userMsg, errorMsg);
            flag = false;
            return false;
        }
    }

    if (document.getElementById('add').value == 'Update') {
        var editData = JSON.parse($('#hdnRowEdit').val());
        if (editData != "") {
	//changes 31:8:2016
            var arrF = $.grep(lstProductList, function(n, i) {
                //return n.ProductID != editData.ProductID && n.BatchNo != editData.BatchNo;
                //return n[i] != editData;
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
        TotalCalculation();
        var pMFTDate = '';
        var pEXPDate = '';
        var pProductNamefull =escape(document.getElementById('txtProductName').value);
        var pProductNamesplit = pProductNamefull.split('[');
        var pName = pProductNamesplit[0];       
        var pId = document.getElementById('hdnproductId').value;
        var pCategory = document.getElementById('ddlCategory').options[document.getElementById('ddlCategory').selectedIndex].text;
        var pCategoryId = document.getElementById('ddlCategory').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        if (pBatchNo == '') {
            pBatchNo = '*';
        }
        if (document.getElementById('txtEXPDate').value == '') {
            pEXPDate = '';
        }
        else {
            pEXPDate = document.getElementById('txtEXPDate').value;
        }

        if (document.getElementById('txtMFTDate').value == '') {
            pMFTDate = '';
        }
        else {
            pMFTDate = document.getElementById('txtMFTDate').value;
        }

        var pPoQuantity = document.getElementById('txtPoQuantity').value == "" ? 0 : ToInternalFormat($("#txtPoQuantity"));  //document.getElementById('txtPoQuantity').value;
        var pPoUnit = document.getElementById('txtPoUnit').value;

        var pRECQuantity = document.getElementById('txtRECQuantity').value == "" ? 0 : ToInternalFormat($("#txtRECQuantity")); //document.getElementById('txtRcvdLSUQty').value;
        var pRECUnit = $.trim($("#ddlRecUnit option:selected").text());
        //document.getElementById('txtRcvdUnit').value; 
        // document.getElementById('ddlUOM').options[document.getElementById('ddlUOM').selectedIndex].text;
        var pCompQTY = document.getElementById('txtCompQuantity').value == "" ? 0 : ToInternalFormat($("#txtCompQuantity")); //document.getElementById('txtRcvdLSUQty').value;
        var PurchTax = $('#txtPurchaseTax').val() == "" ? 0.00 :  ToInternalFormat($("#txtPurchaseTax"));
        var pTax =$('#txtTax').val() == "" ? 0.00 :  ToInternalFormat($("#txtTax")); 
        var pDiscount = document.getElementById('txtDiscount').value == "" ? 0 : ToInternalFormat($("#txtDiscount")); // document.getElementById('txtDiscount').value;
        var pUnitPrice = document.getElementById('txtUnitPrice').value == "" ? 0 : ToInternalFormat($("#txtUnitPrice")); //document.getElementById('txtUnitPrice').value;
        var pTotalCost = ToInternalFormat($("#txtTotalCost")); //document.getElementById('txtTotalCost').value;
        if (document.getElementById('hdnType').value == '') {
            $("#hdnType").val(0);
        }
        var pTQty = ToInternalFormat($("#hdnType")); //document.getElementById('hdnType').value;
        var pSellingPrice = document.getElementById('txtSellingPrice').value == "" ? 0 : ToInternalFormat($("#txtSellingPrice")); // document.getElementById('txtSellingPrice').value;
        var pMRP = document.getElementById('txtMRP').value == "" ? 0 : ToInternalFormat($("#txtMRP")); // document.getElementById('txtMRP').value;
        var pRcvdLSUQty = $('#txtRcvdLSUQty').val() == "" ? 0.00 : ToInternalFormat($("#txtRcvdLSUQty"));  //document.getElementById('txtRcvdLSUQty').value;
        var pInvoiceQty = $('#txtInvoiceQty').val() == "" ? 0.00 : ToInternalFormat($("#txtInvoiceQty"));  //document.getElementById('txtInvoiceQty').value;
        var pSellingUnit = document.getElementById('ddlSelling').value; // document.getElementById('ddlSelling').value
        var pUnitCostPrice = document.getElementById('hdnUnitCostPrice').value == "" ? 0 : ToInternalFormat($("#hdnUnitCostPrice")); // document.getElementById('hdnUnitCostPrice').value;
        var pUnitSellingPrice = document.getElementById('hdnUnitSellingPrice').value == "" ? 0 : ToInternalFormat($("#hdnUnitSellingPrice")); //document.getElementById('hdnUnitSellingPrice').value;
        var pAttrib = document.getElementById('hdnAttributes').value;
        var pAttribDetail = document.getElementById('hdnAttributeDetail').value;
        var pHasExpDate = document.getElementById('hdnHasExpiryDate').value;
        var pHasBatchNo = document.getElementById('hdnHasBatchNo').value;
        var pHasCostPrice = document.getElementById('hdnHasCostPrice').value;
        var pHasSellingPrice = document.getElementById('hdnHasSellingPrice').value;
        var pAttCount = document.getElementById('hdnGridPopCount').value;
        var pRakNo = document.getElementById('txtRakNo').value;
        var pNominal = document.getElementById('txtNominal').value == "" ? 0 : ToInternalFormat($("#txtNominal")); //document.getElementById('txtNominal').value;
        
       
        if (pNominal == 0) {
            pNominal = document.getElementById('txtNominal').value = 0;
        }
        else {
            pNominal = ToInternalFormat($("#txtNominal")) == 0.00 ? 0 : ToInternalFormat($("#txtNominal"));
        }

        var pMarginvalue = 0;
        if ($('#hdnIsSellingPriceTypeRuleApply').val() == 'Y') {
            pMarginvalue = $('#hdnMarginValue').val();
        }
       
        

        var objProduct = new Object();
        objProduct.ProductID = pId;
        objProduct.ProductName = pName;
        objProduct.CategoryID = pCategoryId;
        objProduct.CategoryName = pCategory;
        objProduct.BatchNo = pBatchNo;
        objProduct.Manufacture = pMFTDate;
        objProduct.ExpiryDate = pEXPDate;
        objProduct.POQuantity = pPoQuantity;
        objProduct.POUnit = pPoUnit;
        objProduct.RECQuantity = pRECQuantity;
        objProduct.RECUnit = pRECUnit;
        objProduct.ComplimentQTY = pCompQTY;
        objProduct.UnitPrice = pUnitPrice;
        objProduct.Discount = pDiscount;
        objProduct.Tax = pTax;
        objProduct.TotalCost = pTotalCost;
        objProduct.TotalQty = pTQty == '' ? 0 : pTQty;
        objProduct.SellingPrice = pSellingPrice;
        objProduct.SellingUnit = pSellingUnit;
        objProduct.InvoiceQty = pInvoiceQty;
        objProduct.RcvdLSUQty = pRcvdLSUQty;
        objProduct.UnitCostPrice = pUnitCostPrice;
        objProduct.UnitSellingPrice = pUnitSellingPrice;
        objProduct.Attributes = pAttrib;
        objProduct.AttributeDetail = pAttribDetail;
        objProduct.HasExpiryDate = pHasExpDate;
        objProduct.HasBatchNo = pHasBatchNo;
        objProduct.RakNo = pRakNo;
        objProduct.MRP = pMRP;
        objProduct.Nominal = pNominal;
        objProduct.PurchaseTax = PurchTax;
        objProduct.NonReimbursableAmount = pMarginvalue;
        objProduct.OrderedUnitValues = ddlvalue;
        objProduct.ExistsRecLSUQty = ExistsRecLSUQty;
        objProduct.HasCostPrice = pHasCostPrice;
        objProduct.HasSellingPrice = pHasSellingPrice;
        lstProductList.push(objProduct);
        $('#hdnProductList').val(JSON.stringify(lstProductList));
        
        Tblist();
        
    document.getElementById('add').value = 'Add';
    document.getElementById('hdnAdd').value = 'Add';
    document.getElementById('hdnGridPopCount').value = '';
    document.getElementById('hdnAttributeDetail').value = 'N';
    fnClear();
}


function fnSelectedProducts(source, eventArgs) {
    AddProductDetails(eventArgs.get_value());     
}

function SetValue(temp) {
    if (temp.length > 0) {
        var pDetails = temp[0];
        var pTax;
        var pBac = pDetails.BatchNo;
        var pMaf = pDetails.Manufacture;
        var pExp = pDetails.ExpiryDate;
        var pInQty = pDetails.InvoiceQty;
        var pSellUn = pDetails.SellingUnit;
        var pCostPr = pDetails.UnitPrice;
        var pSellPr = pDetails.SellingPrice;
        pTax = pDetails.Tax;
        var pUniCostPr = pDetails.UnitCostPrice;
        var pUnitSellPr = pDetails.UnitSellingPrice;
        var pMRP = pDetails.MRP;
        var rakno = pDetails.RakNo;

        document.getElementById('txtRakNo').value = rakno;
//        document.getElementById('txtRcvdUnit').value = pSellUn;
//        document.getElementById('txtRcvdUnit').readOnly = true;
        document.getElementById('hdnUnitCostPrice').value = pUniCostPr;
        ToTargetFormat($('#hdnUnitCostPrice'));
        document.getElementById('hdnUnitSellingPrice').value = pUnitSellPr;
        ToTargetFormat($('#hdnUnitSellingPrice'));
        document.getElementById('hdnAdd').value = 'Add';
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
        document.getElementById('txtUnitPrice').value = pUniCostPr == undefined ? '0.00' : pUniCostPr; // pUniCostPr;
        ToTargetFormat($('#txtUnitPrice'));
        document.getElementById('txtTax').value = pTax = undefined ? '0.00' : pTax; //pTax;
        ToTargetFormat($('#txtTax'));
        
    }
    else {
        document.getElementById('txtRakNo').value = "";
//        document.getElementById('txtRcvdUnit').value = "";
//        document.getElementById('txtRcvdUnit').readOnly = false;
        document.getElementById('hdnUnitCostPrice').value = 0;
        ToTargetFormat($('#hdnUnitCostPrice'));
        document.getElementById('hdnUnitSellingPrice').value = 0;
        ToTargetFormat($('#hdnUnitSellingPrice'));
        document.getElementById('hdnAdd').value = 'Add';
        document.getElementById('hdnType').value = '';
        document.getElementById('txtSellingPrice').value = 0;
        ToTargetFormat($('#txtSellingPrice'));
        document.getElementById('txtMRP').value = 0;
        ToTargetFormat($('#txtMRP'));
        document.getElementById('txtRcvdLSUQty').value = '0.00';
        ToTargetFormat($('#txtRcvdLSUQty'));
        document.getElementById('txtInvoiceQty').value = 1;
        ToTargetFormat($('#txtInvoiceQty'));
        document.getElementById('txtRcvdLSUQty').readOnly = false;
        //$('#txtRcvdUnit').val($('#txtPoUnit').val());
        
    }
    CheckRcvdLSUQty();
}


function Tblist() {
    HideTax = $("#hdnTax").val();
    var str = '';
    var PurchaseTax = '';
    var Purch = '';
    var hideTaxCol = '';
    var table = '';
    var tr = '';
    var end = '</table>';
    var y = '';
    var pRowId = document.getElementById('hdnRowId').value;
    document.getElementById('lblTableT').innerHTML = '';
    if (HideTax == "Y") {
        strTax = "<th class='tbltax hide' >Sales Tax(%)</th>";
        PurchaseTax = "<th style='width:85px;' class='tbltax hide' >Purchase Tax(%)</th>";
    }
    else {
        strTax = "<th class='tbltax' colspan='6'>Tax(%)</th>";
        PurchaseTax = "<th style='width:85px;' class='tbltax hide' >Purchase Tax(%)</th>";

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
    var Discount = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_12") == null ? "Discount(%)" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_12");
    var SellingPrice = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_13") == null ? "Selling Price" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_13");
    var MRP = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_14") == null ? "MRP/SRP" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_14");
    var RakNo = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_15") == null ? "RakNo" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_15");
    var TotalCost = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_16") == null ? "Total Cost" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_16");
    var Action = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_17") == null ? "Action" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_17");
    document.getElementById('txtcgst').value = '0.00';
    document.getElementById('txtsgst').value = '0.00';
    document.getElementById('txtigst').value = '0.00';
    document.getElementById('txtTotalTaxAmt').value = '0.00';
    ToTargetFormat($("#txtTotalTaxAmt"));

    table = "<table id='tbladdproductlist' class='w-100p responstable font11 marginT10 marginB10'><thead  class='a-center '><tr class='responstableHeader'>"
                           + "<th rowspan='3'>" + ProductName + "</th>"
                           + "<th rowspan='3'>" + BatchNo + "</th>"
                           + "<th rowspan='3'>" + Date + "</th>"
                           + "<th rowspan='3'>" + POQty + "</th>"
                           + "<th rowspan='3'>" + ReceivedQty + "</th>"
                           + "<th rowspan='3'>" + SellingUnit + "</th>"
                           + "<th rowspan='3'>" + InverseQty + "</th>"
                           + "<th rowspan='3'>" + ReceivedLSUQty + "</th>"
                           + "<th rowspan='3'>" + CompLSUQty + "</th>"
                           + "<th rowspan='3'>" + CostPrice + "</th>"
                           + "<th class='hide'>" + Nominal + "</th>"
                           + "<th rowspan='3'>" + Discount + "</th>"
                           + strTax
                           + PurchaseTax
                           + "<th rowspan='3'>" + SellingPrice + "</th>"
                           + "<th rowspan='3'>" + MRP + "</th>"
                           + "<th class='hide'>" + RakNo + "</th>"
                           + "<th rowspan='3'>" + TotalCost + "</th>"
                           + "<th rowspan='3'>" + Action + "</th></tr>"
                           + "<tr class='responstableHeader'>"
                            + "<th colspan='2'>CGST</th>"
                            + "<th colspan='2'>SGST</th>"
                            + "<th colspan='2'>IGST</th>"
                            + "</tr>"
                            + "<tr class='responstableHeader'>"
                            + "<th >%</th>"
                            + "<th >Amt</th>"
                            + "<th >%</th>"
                            + "<th >Amt</th>"
                            + "<th >%</th>"
                            + "<th >Amt</th>"
                           + "</tr>"
                           + "</thead>";
   
    document.getElementById('lblTotalCostAmount').innerHTML = '0.00';
    ToTargetFormat($('#lblTotalCostAmount'));
    document.getElementById('txtDiscountAmt').value = '0.00'
    ToTargetFormat($('#txtDiscountAmt'));
    document.getElementById('txtTotalSales').value = '0.00'
    ToTargetFormat($('#txtTotalSales'));
    document.getElementById('txtGrandTotal').value = '0.00';
    //ToTargetFormat($('#txtGrandTotal'));
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
    var TcsTotalCostPrice =0.00;
    
    $.each(lstProductList, function(obj, value) {

        $('#hdnTempValue').val(value.Tax);
        if (HideTax == "Y") {
            hideTaxCol = "<td class='hide'>" + ToTargetFormat($('#hdnTempValue')) + "</td>";
        }
        else {
            hideTaxCol = "<td class='a-right hide'>" + ToTargetFormat($('#hdnTempValue')) + "</td>";
        }
        $('#hdnTempValue').val(value.PurchaseTax);
        Purch = "<td class='a-right'>" + ToTargetFormat($('#hdnTempValue')) + "</td>";

        var dateMFT = value.Manufacture == "" ? "**" : value.Manufacture;
        var dateEXP = value.ExpiryDate == "" ? "**" : value.ExpiryDate;

        $('#hdnTempValue').val(value.POQuantity);
        var pPoQuantity = ToTargetFormat($('#hdnTempValue'));

        $('#hdnTempValue').val(value.RECQuantity);
        var pRECQuantity = ToTargetFormat($('#hdnTempValue'));


        $('#hdnTempValue').val(value.InvoiceQty);
        var pInvoiceQty = ToTargetFormat($('#hdnTempValue'));


        $('#hdnTempValue').val(value.RcvdLSUQty);
        var pRcvdLSUQty = ToTargetFormat($('#hdnTempValue'));

        $('#hdnTempValue').val(value.ComplimentQTY);
        var pCompQTY = ToTargetFormat($('#hdnTempValue'));


        $('#hdnTempValue').val(value.UnitPrice);
        var pUnitPrice = ToTargetFormat($('#hdnTempValue'));

        $('#hdnTempValue').val(value.Nominal);
        var pNominal = ToTargetFormat($('#hdnTempValue'));


        $('#hdnTempValue').val(value.Discount);
        var pDiscount = ToTargetFormat($('#hdnTempValue'));

        $('#hdnTempValue').val(value.PurchaseTax);
        var pPurchaseTax = ToTargetFormat($('#hdnTempValue'));

        $('#hdnTempValue').val(value.SellingPrice);
        var pSellingPrice = ToTargetFormat($('#hdnTempValue'));

        $('#hdnTempValue').val(value.MRP);
        var pMRP = ToTargetFormat($('#hdnTempValue'));

        $('#hdnTempValue').val(value.TotalCost);
        var pTotalCost = ToTargetFormat($('#hdnTempValue'));
        
        TcsTotalCostPrice =TcsTotalCostPrice + value.TotalCost;
        
        //------------------------------Tax Calculation Part
        var GSTtaxamount = 0.00;
        var IGSTtaxamount = 0.00;
        var GSTTax = 0.00;
        var cgstper = 0.00
        var cgstamt = 0.00
        var sgstper = 0.00;
        var sgstamt = 0.00;
        var igstper = 0.00;
        var igstamt = 0.00;
        var totgstamt = 0;
        if ($('#CheckState').val() == "Y") {
            if (value.Tax > 0) {
                GSTtaxamount = (parseFloat((((value.UnitPrice - (value.UnitPrice * value.Discount / 100)) * value.Tax / 100)) * value.RECQuantity) / 2).toFixed(2);
                GSTTax = (parseFloat(value.Tax) / 2).toFixed(2);
                cgstper = GSTTax;  // Tax
                cgstamt = GSTtaxamount;
                sgstper = GSTTax;
                sgstamt = GSTtaxamount;
                totgstamt = (parseFloat(GSTtaxamount) * 2).toFixed(2);
            }
        }
        else {
            IGSTtaxamount = (parseFloat((((value.UnitPrice - (value.UnitPrice * value.Discount / 100)) * value.Tax / 100)) * value.RECQuantity)).toFixed(2);
            GSTTax = (parseFloat(value.Tax)).toFixed(2);
            igstper = GSTTax;
            igstamt = IGSTtaxamount;
            totgstamt = parseFloat(IGSTtaxamount).toFixed(2);
        }

        //-------------------------------END
        
        tr += "<tr class='gridView w-100p'><td >"
                        + unescape(value.ProductName) + "</td><td>"
                        + value.BatchNo + "</td><td><table><tr ><td>MFT: "
                        + dateMFT + "</td></tr><tr><td>EXP: "
                        + dateEXP + "</td></tr></table></td><td>"
                        + pPoQuantity + "<br/>(" + value.POUnit + ")</td><td>"
                        + pRECQuantity + "<br/>(" + value.RECUnit + ")</td><td>"
                        + value.SellingUnit + "</td><td class='a-right'>"
                        + pInvoiceQty + "</td><td class='a-right'>"
                        + pRcvdLSUQty + "</td><td class='a-right'>"
                        + pCompQTY + "</td><td class='a-right'>"
                        + pUnitPrice + "</td><td class='a-right hide'>"
                        + pNominal + "</td><td class='a-right'>"  
                        + pDiscount + "</td>"
                        + hideTaxCol
                        + "<td class='a-right'>" + cgstper + "</td>"
                        + "<td class='a-right'>" + cgstamt + "</td>"
                        + "<td class='a-right'>" + sgstper + "</td>"
                        + "<td class='a-right'>" + sgstamt + "</td>"
                        + "<td class='a-right'>" + igstper + "</td>"
                        + "<td class='a-right'>" + igstamt + "</td>"
                        +"<td class='a-right hide'>" + pPurchaseTax + "</td><td class='a-right'>"
                        + pSellingPrice + "</td><td class='a-right'>"
                        + pMRP + "</td><td class='a-right hide'>"
                        + value.RakNo + "</td><td class='a-right'>"
                        + pTotalCost + "</td>"
                        + "<td><input name='Edit' onclick='btnEdit_OnClick(" + JSON.stringify(value) + ");' type='button' Class='ui-icon ui-icon-pencil b-none pointer pull-left' />"
                        + "<input name='Delete' onclick='btnDelete(" + JSON.stringify(value) + ");'  type='button' Class='ui-icon ui-icon-trash b-none pointer'/></td></tr>";
        
        
        document.getElementById('hdnFormatvalue').value = document.getElementById('lblTotalCostAmount').innerHTML;
        ToTargetFormat($('#hdnFormatvalue'));
        document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(value.TotalCost) + parseFloat(ToInternalFormat($('#hdnFormatvalue')))).toFixed(2);
        ToTargetFormat($("#lblTotalCostAmount"));
        document.getElementById('hdnTotalCost').value = parseFloat(parseFloat(value.TotalCost) + parseFloat(ToInternalFormat($('#hdnTotalCost')))).toFixed(2);
        ToTargetFormat($('#hdnTotalCost'));
        document.getElementById('txtTotalSales').value = ToInternalFormat($('#txtTotalSales')) + (parseFloat(value.UnitPrice) * parseFloat(value.RECQuantity)) + parseFloat(totgstamt);
        ToTargetFormat($('#txtTotalSales'));

        if ($('#txtTotaltax').val() != '' && $('#txtTotaltax').val() != "0.00") {            
            var Total = parseFloat(parseFloat((ToInternalFormat($('#hdnTempValue')))) - parseFloat(ToInternalFormat($('#txtTotalDiscount')))).toFixed(2);
            var totaltax = parseFloat((parseFloat(parseFloat(Total)) / parseFloat(100)) * parseFloat(ToInternalFormat($('#txtTotaltax')))).toFixed(2);
            totaltax = parseFloat(parseFloat(totaltax) + parseFloat(Total)).toFixed(2);
            totaltax = parseFloat(parseFloat(totaltax).toFixed(2) + parseFloat(ToInternalFormat($('#txtGrandTotal')))).toFixed(2);
            $('#txtGrandTotal').val(parseFloat(totaltax).toFixed(2));
            $('#lblTotalCostAmount').text(parseFloat(totaltax).toFixed(2));
            ToTargetFormat($("#lblTotalCostAmount"));
        }
        else {
            document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(ToInternalFormat($('#hdnTempValue'))) 
            + parseFloat(ToInternalFormat($('#txtGrandTotal')))).toFixed(2);
        }
        //ToTargetFormat($('#txtGrandTotal'));
        var cUnitPrice = 0;      
        cUnitPrice = parseFloat(value.UnitPrice).toFixed(2);

        document.getElementById('txtNetTotal').value = (parseFloat(ToInternalFormat($('#txtGrandTotal')))).toFixed(2);
        ToTargetFormat($('#txtNetTotal'));

        document.getElementById('txtDiscountAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtDiscountAmt')))
        + parseFloat(parseFloat(parseFloat(value.Discount) / 100) * (parseFloat(parseFloat(cUnitPrice) - parseFloat(value.Nominal))
         * parseFloat(value.RECQuantity)))).toFixed(2);
        ToTargetFormat($('#txtDiscountAmt'));

        var SubDis = parseFloat(parseFloat(parseFloat(value.Discount) / 100) *
         (parseFloat(parseFloat(cUnitPrice) - parseFloat(value.Nominal)) * parseFloat(value.RECQuantity))).toFixed(2);
       
        var _Tax = 0;
        var _UnitPrice = 0;
        var _pNominalDiscount = 0;
        var _RcvdLSUQtyNo = 0;
        var _Discount = 0;
        var _PurTax = 0;
	//changes related to CalCompQty 31:8:2016       
        var _ComplementryQuantity = 0;
        //var _LsuUnitPrice = 0;
        _Tax = parseFloat(value.Tax).toFixed(2);
        _UnitPrice = parseFloat(value.UnitPrice).toFixed(2);
        //changes related to CalCompQty 31:8:2016
        _ComplementryQuantity = (Number(value.ComplimentQTY) / Number(value.InvoiceQty)).toFixed(2);
        //_LsuUnitPrice = parseFloat(value.UnitCostPrice);
        //Changes end

        _pNominalDiscount = parseFloat(value.Nominal).toFixed(2);
        _RcvdLSUQtyNo = parseFloat(value.RECQuantity).toFixed(2);
        _Discount = parseFloat(value.Discount).toFixed(2);
        _PurTax = parseFloat(value.PurchaseTax).toFixed(2);

        if ($('#hdnREQCalcCompQTY').val() == 'Y') {
            if (value.PurchaseTax != undefined && value.PurchaseTax != "") {
                // if (value.PurchaseTax > 0) {
                //changes related to CalCompQty 22:8:2016 comment start
                //                document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) +
                //                  parseFloat(parseFloat(parseFloat(_PurTax) / 100) *
                //                 (parseFloat(parseFloat(parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) *
                //                 (parseFloat(_RcvdLSUQtyNo) + parseFloat(value.ComplimentQTY))) - parseFloat(parseFloat(parseFloat(parseFloat(_Discount) / 100) *
                //                 (parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) *
                //                 (parseFloat(_RcvdLSUQtyNo) + parseFloat(+parseFloat(value.ComplimentQTY)))))))))).toFixed(2);
                // changes related to CalCompQty 22:8:2016 comment end
               
                //changes related to CalCompQty 22:8:2016  addnew calculation
                ///////////////////////////////////////////////////////////////////////////////////////////////////
                document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) +
                  parseFloat(parseFloat(parseFloat(_PurTax) / 100) *
                 (parseFloat(parseFloat(parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) *
                 (parseFloat(_RcvdLSUQtyNo) + parseFloat(_ComplementryQuantity))) - parseFloat(parseFloat(parseFloat(parseFloat(_Discount) / 100) *
                 (parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) *
                 (parseFloat(_RcvdLSUQtyNo))))))))).toFixed(2);
                 
                 ////////////////////////////////////////////////////////////////////////////////////////////////////////
                   //changes related to CalCompQty 22:8:2016 addnew calculation  end




                //}
                /*else {
                    document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) +
                    parseFloat(parseFloat(parseFloat(_Tax) / 100) * (parseFloat(parseFloat(parseFloat(parseFloat(_UnitPrice) -
                    parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo) + parseFloat(value.ComplimentQTY))) -
                    parseFloat(parseFloat(parseFloat(parseFloat(_Discount) / 100) * (parseFloat(parseFloat(_UnitPrice) -
                    parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo) + parseFloat(+parseFloat(value.ComplimentQTY)))))))))).toFixed(2);
                }*/
            }
            /*else {
                document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) +
                 parseFloat(parseFloat(parseFloat(_Tax) / 100) * (parseFloat(parseFloat(parseFloat(parseFloat(_UnitPrice) -
                 parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo) + parseFloat(value.ComplimentQTY))) -
                 parseFloat(parseFloat(parseFloat(parseFloat(_Discount) / 100) * (parseFloat(parseFloat(_UnitPrice) -
                 parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo) + parseFloat(+parseFloat(value.ComplimentQTY)))))))))).toFixed(2);
            }*/
        }
        else {
            if (value.PurchaseTax != undefined && value.PurchaseTax != "") {
               // if (value.PurchaseTax > 0) {
                    document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) +
                   parseFloat(parseFloat(parseFloat(_PurTax) / 100) * (parseFloat(parseFloat(parseFloat(parseFloat(_UnitPrice) - 
                   parseFloat(_pNominalDiscount)) *
                   (parseFloat(_RcvdLSUQtyNo))) - parseFloat(parseFloat(parseFloat(parseFloat(_Discount) / 100) *
                  (parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo))))))))).toFixed(2);
               // }
               /* else {
                    document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) +
                     parseFloat(parseFloat(parseFloat(_Tax) / 100) * (parseFloat(parseFloat(parseFloat(parseFloat(_UnitPrice) -
                     parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo))) -
                     parseFloat(parseFloat(parseFloat(parseFloat(_Discount) / 100) *
                     (parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * 
                     (parseFloat(_RcvdLSUQtyNo))))))))).toFixed(2);
                }*/
            }
           /* else {
                document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) +
                parseFloat(parseFloat(parseFloat(_Tax) / 100) * (parseFloat(parseFloat(parseFloat(parseFloat(_UnitPrice) -
                parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo))) -
                parseFloat(parseFloat(parseFloat(parseFloat(_Discount) / 100) * (
                parseFloat(parseFloat(_UnitPrice) - parseFloat(_pNominalDiscount)) * (parseFloat(_RcvdLSUQtyNo))))))))).toFixed(2);
            }*/
        }
        ToTargetFormat($('#txtTaxAmt'));
        //------------------------------Tax Calculation Part
        if ($("#CheckState").val() == "Y") {
            document.getElementById('txtcgst').value = (parseFloat(parseFloat(ToInternalFormat($("#txtcgst"))) + parseFloat(GSTtaxamount))).toFixed(2);
            document.getElementById('txtsgst').value = (parseFloat(parseFloat(ToInternalFormat($("#txtsgst"))) + parseFloat(GSTtaxamount))).toFixed(2);
        }
        else {
            document.getElementById('txtigst').value = (parseFloat(parseFloat(ToInternalFormat($("#txtigst"))) + parseFloat(IGSTtaxamount))).toFixed(2);
        }
        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtcgst"))) + parseFloat(ToInternalFormat($("#txtsgst"))) + parseFloat(ToInternalFormat($("#txtigst"))));
        ToTargetFormat($('#txtTotalTaxAmt'));
        //------------------------------Tax Calculation Part END
        if (document.getElementById('txtTotalDiscount').value.trim() == '')
            document.getElementById('txtTotalDiscount').value = "0.00";
        if (document.getElementById('txtTotaltax').value.trim() == '')
            document.getElementById('txtTotaltax').value = "0.00";
        ToTargetFormat($('#txtTotaltax'));
        ToTargetFormat($('#txtTotalDiscount'));
        var Total = parseFloat(parseFloat(ToInternalFormat($('#hdnTotalCost'))) - parseFloat(ToInternalFormat($('#txtTotalDiscount')))).toFixed(2);
        tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(ToInternalFormat($('#txtTotaltax')))).toFixed(2);
        $('#hdnsupplierServiceTaxAmount').val(parseFloat(tempTaxAmt).toFixed(2));
        ToTargetFormat($('#hdnsupplierServiceTaxAmount'));
        document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
        ToTargetFormat($('#lblTotalCostAmount'));
        document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
        //ToTargetFormat($('#txtGrandTotal'));
        document.getElementById('txtNetTotal').value = parseFloat((parseFloat(ToInternalFormat($('#txtGrandTotal')))) - parseFloat(ToInternalFormat($('#txtUseCreditAmount')))).toFixed(2);
        ToTargetFormat($('#txtNetTotal'));
        if (ToInternalFormat($('#hdnAvailableCreditAmount')) != null) {
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
    });
    
    //Tcs Calculation :
    if($("#hdnNeedTcsTax").val()=="Y" && $("#hdnIsTCSSupplier").val()=="Y")
    {
      $('#trTCSTax').removeClass().addClass('displaytr');    
      var TTP= parseFloat($("#hdnTcsTaxPer").val()).toFixed(5);
      var TTA = ((TcsTotalCostPrice*TTP)/100);
      $("#txtTCSTax").val(TTA.toFixed(2));    
       var TTATotal= (parseFloat($("#txtNetTotal").val())+TTA).toFixed(2)
       $("#txtNetTotal").val(TTATotal);
       $("#txtGrandTotal").val(TTATotal);
      
    }
    
    if (lstProductList.length == 0) {       
        $('#submitTab').removeClass().addClass('hide');
        $('#tbTotalCost').removeClass().addClass('hide');
    }
    else {      
        $('#submitTab').removeClass().addClass('displaytb w-100p');
        $('#tbTotalCost').removeClass().addClass('displaytb w-100p');
    }
    var temp = table + tr + end;

    document.getElementById('hdnTempTable').value = temp;
    document.getElementById('lblTableT').innerHTML = temp;
}

function btnEdit_OnClick(sEditedData) {   
    var objadd = SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_18") == null ? "Update" : SListForAppDisplay.Get("StockReceived_Scripts_InvStockReceive_js_18");
    document.getElementById('add').value = 'Update';
    $('#add').text(objadd);
    document.getElementById('hdnAdd').value = 'Update';
    document.getElementById('hdnRowEdit').value = JSON.stringify(sEditedData);
    document.getElementById('hdnproductId').value = sEditedData.ProductID;
    document.getElementById('hdnProductName').value = sEditedData.ProductName;
    document.getElementById('txtProductName').value =unescape(sEditedData.ProductName);
    document.getElementById('ddlCategory').value = sEditedData.CategoryID;
    document.getElementById('txtBatchNo').value = sEditedData.BatchNo;
    document.getElementById('txtMFTDate').value = sEditedData.Manufacture;
    document.getElementById('txtEXPDate').value = sEditedData.ExpiryDate;
    document.getElementById('txtPoQuantity').value = sEditedData.POQuantity;
    document.getElementById('txtPoUnit').value = sEditedData.POUnit;
    document.getElementById('txtRECQuantity').value = sEditedData.RECQuantity;
    //document.getElementById('txtRcvdUnit').value = sEditedData.RECUnit;
    ConvertOrderUnitList(sEditedData.OrderedUnitValues, sEditedData.RECUnit);
    document.getElementById('txtCompQuantity').value = sEditedData.ComplimentQTY;
    $('#txtPurchaseTax').val(sEditedData.PurchaseTax);
    document.getElementById('txtUnitPrice').value = sEditedData.UnitPrice;
    document.getElementById('txtDiscount').value = sEditedData.Discount;
    document.getElementById('txtTax').value = sEditedData.Tax;
    document.getElementById('txtTotalCost').value = sEditedData.TotalCost;
    document.getElementById('hdnType').value = sEditedData.TotalQty;
    document.getElementById('txtSellingPrice').value = sEditedData.SellingPrice;
    $('#ddlSelling option:not(:selected)').prop('disabled', true); 
    document.getElementById('ddlSelling').value = sEditedData.SellingUnit;
    document.getElementById('txtInvoiceQty').value = sEditedData.InvoiceQty;
    document.getElementById('txtRcvdLSUQty').value = sEditedData.RcvdLSUQty;
    EditRECLSUqty =  sEditedData.RcvdLSUQty;
    ExistsRecLSUQty = sEditedData.ExistsRecLSUQty;
    document.getElementById('hdnUnitCostPrice').value = sEditedData.UnitCostPrice;
    document.getElementById('hdnUnitSellingPrice').value = sEditedData.UnitSellingPrice;
    document.getElementById('hdnAttributes').value = sEditedData.Attributes;
    document.getElementById('hdnAttributeDetail').value = sEditedData.AttributeDetail;
    document.getElementById('hdnHasExpiryDate').value = sEditedData.HasExpiryDate;
    document.getElementById('hdnHasBatchNo').value = sEditedData.HasBatchNo;
    document.getElementById('hdnHasCostPrice').value = sEditedData.HasCostPrice;
    document.getElementById('hdnHasSellingPrice').value = sEditedData.HasSellingPrice; 
    document.getElementById('txtRakNo').value = sEditedData.RakNo;
    document.getElementById('txtMRP').value = sEditedData.MRP;
    document.getElementById('txtNominal').value = sEditedData.Nominal;

    document.getElementById('TableProductDetails').style.display = "table";
    document.getElementById('ddlCategory').disabled = true; 
    //document.getElementById('txtRcvdUnit').readOnly = true;
    document.getElementById('txtPoQuantity').readOnly = true;
    document.getElementById('txtPoUnit').readOnly = true;
    document.getElementById('txtTotalCost').readOnly = true;
    document.getElementById('txtRcvdLSUQty').readOnly = true;
    document.getElementById('txtInvoiceQty').readOnly = true;
    if (sEditedData.Attributes != 'N') {
        document.getElementById('lbtnAttribute').style.display = "block"
    }
    else {
        document.getElementById('lbtnAttribute').style.display = "none"
        document.getElementById('hdnAttributes').value = "N";
    }
    if (document.getElementById("CheckState").value == "Y") {
        CGST = sEditedData.Tax / 2;
        SGST = sEditedData.Tax / 2;
        IGST = 0

    }
    else {
        IGST = sEditedData.Tax;
        CGST = 0;
        SGST = 0;
    }
    $('.ww-300').html('<table class="gsttbl" border="1" rules="all"><tr><td>CGST(%)</td><td>SGST(%)</td><td>IGST(%)</td></tr><tr><td>' + CGST + '</td><td>' + SGST + '</td><td>' + IGST + '</td></tr></table>');
    ToTargetFormat($("#txtPoQuantity"));
    ToTargetFormat($("#txtRECQuantity"));
    ToTargetFormat($("#txtCompQuantity"));
    ToTargetFormat($("#txtPurchaseTax"));
    ToTargetFormat($("#txtUnitPrice"));
    ToTargetFormat($("#txtDiscount"));
    ToTargetFormat($("#txtTax"));
    ToTargetFormat($("#txtTotalCost"));
    ToTargetFormat($("#hdnType"));
    ToTargetFormat($("#txtSellingPrice"));
    ToTargetFormat($("#txtInvoiceQty"));
    ToTargetFormat($("#hdnUnitCostPrice"));
    ToTargetFormat($("#hdnUnitSellingPrice"));
    ToTargetFormat($("#txtMRP"));
    ToTargetFormat($("#txtNominal"));
    
    
    return false;
}
function btnDelete(sEditedData) {
    var arrF = $.grep(lstProductList, function(n, i) {
    //changes related to CalCompQty 31:8:2016
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
  
    document.getElementById('lblTotalCostAmount').innerHTML = '0.00';
    ToTargetFormat($('#lblTotalCostAmount'));
    document.getElementById('txtGrandTotal').value = '0.00';
    //ToTargetFormat($('#txtGrandTotal'));    
    document.getElementById('hdnType').value = "";
    document.getElementById('add').value = 'Add';
    document.getElementById('hdnAdd').value = 'Add';
    document.getElementById('hdnAttributeDetail').value = 'N';
    document.getElementById('hdnGridPopCount').value = ''; 
    document.getElementById('INVAttributes1_hdnAttValue').value = 'N';
    document.getElementById('INVAttributes1_hdnGridCount').value = '0';
    Tblist();   
    document.getElementById('add').value = 'Add';
    document.getElementById('hdnAdd').value = 'Add';
    document.getElementById('hdnGridPopCount').value = '';
    document.getElementById('hdnAttributeDetail').value = 'N';
    $('#add').text('Add');
    fnClear();
}

function conversionval() {
    var x = document.getElementById('hdnLanguageProductList').value.split("^");
    $('#hdnProductList').val("");
    lstProductList = [];
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            var y = x[i].split("~");
            if (y != "") {
                var objProduct = new Object();
                objProduct.ProductID = y[0];
                objProduct.ProductName =unescape(y[1]);
                objProduct.CategoryID = y[3];
                objProduct.CategoryName = y[2];
                objProduct.BatchNo = y[4];
                objProduct.Manufacture = y[5];
                objProduct.ExpiryDate = y[6];
                objProduct.POQuantity = y[7];
                objProduct.POUnit = y[8];
                objProduct.RECQuantity = y[9];
                objProduct.RECUnit = y[10];
                objProduct.ComplimentQTY = y[11];
                objProduct.UnitPrice = y[12];
                objProduct.Discount = y[13];
                objProduct.Tax = y[14];
                objProduct.TotalCost = y[15];
                objProduct.TotalQty = y[16] == '' ? 0 : y[16];
                objProduct.SellingPrice = y[17];
                objProduct.SellingUnit = y[18];
                objProduct.InvoiceQty = y[19];
                objProduct.RcvdLSUQty = y[20];
                objProduct.UnitCostPrice = y[21];
                objProduct.UnitSellingPrice = y[22];
                objProduct.Attributes = y[23];
                objProduct.AttributeDetail = y[24];
                objProduct.HasExpiryDate = y[25];
                objProduct.HasBatchNo = y[26];
                objProduct.RakNo = y[28];
                objProduct.MRP = y[29];
                objProduct.Nominal = y[30];
                objProduct.PurchaseTax = y[31];
                objProduct.NonReimbursableAmount = y[32];
                objProduct.OrderedUnitValues = y[33].replace(/\#/g, '^');                
                objProduct.ExistsRecLSUQty = y[34];            
                lstProductList.push(objProduct);              

            }
        }
    }
    if (lstProductList.length > 0) {
        $('#hdnProductList').val(JSON.stringify(lstProductList));
    }

}

function Avoidfuturedate() {

    var manudate = document.getElementById('txtMFTDate').value;
    var manudatecurentmonth = manudate.split('/')[0];
    var manudatecurentyear = manudate.split('/')[1];
    var today = GetServerDate();
    var currentmonth = today.getMonth();
    var currentyear = today.getFullYear();
    if (manudatecurentmonth > currentmonth && manudatecurentyear > currentyear) {
        var userMsg = SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_42") == null ? "provide valide MFTdate" : SListForAppMsg.Get("StockReceived_Scripts_InvStockReceive_js_42");
        ValidationWindow(userMsg, errorMsg);        
        return false;
    }
    else {
        return true;
    }

}


/*OrderUnitList DropDown Bind*/

var OrderUnitList = [];
var ddlvalue;
var POtotalOrderQty;
var EditRECLSUqty;
var ExistsRecLSUQty;

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
                objProduct.UOMCode = $.trim(FiledSplit[1]);
            }

            if ($.trim(FiledSplit[0]) == "ConvesionQty") {
                objProduct.ConvesionQty = $.trim(FiledSplit[1]);
            }

        });

        OrderUnitList.push(objProduct);
    });

    BindOrderUnitddl(OrderUnitList, ddlSelectedVal);

}

function BindOrderUnitddl(lstOrderUnit, SelectedValue) {
    var dropdown = $('#ddlRecUnit');
    dropdown.empty();

    $.each(lstOrderUnit, function(index, item) {
        var $option = $("<option />");
        $option.attr("value", $.trim(item.UOMCode) + "~" + $.trim(item.ConvesionQty)).text($.trim(item.UOMCode));
        $(dropdown).append($option);

    });

    if ($.trim(SelectedValue) != "") {
        $("#ddlRecUnit option:contains(" + $.trim(SelectedValue) + ")").attr('selected', true);
        
        var ddlRecUnitval = $('#ddlRecUnit').val().split('~');
        var ConQty = $.trim(ddlRecUnitval[1]);        
        $("#txtInvoiceQty").val(ConQty);
        ToTargetFormat($("#txtInvoiceQty"));
        
        var RecQty = ToInternalFormat($("#txtRECQuantity"));
        var ConQty = ToInternalFormat($("#txtRECQuantity"));
        var lsu = parseFloat(RecQty).toFixed(2) * parseFloat(ConQty).toFixed(2);
        
        $("#txtRcvdLSUQty").val(lsu);
        ToTargetFormat($("#txtRcvdLSUQty"));
    }

}

function ChangeConvesionQty() {
    var ddlRecUnitval = $('#ddlRecUnit').val().split('~');
    var ConQty = $.trim(ddlRecUnitval[1]);
    var RecQty = $("#txtRECQuantity").val();
    $("#txtInvoiceQty").val(ConQty);
    $("#txtRcvdLSUQty").val(Number(RecQty) * Number(ConQty));
    //$("#txtUnitPrice").val("");

}


function AddRecUnitDefault() {
    var ddlval = SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_06") == null ? "Select" : SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_06");
    var $option = $("<option />");
    $option.attr("value", $.trim(ddlval) + "~0").text($.trim(ddlval));
    $("#ddlRecUnit").append($option);
}