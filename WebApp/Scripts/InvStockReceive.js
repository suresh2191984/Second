
function checkDetails() {
    //            alert("jkhjkh");
    document.getElementById('btnFinish').style.display = 'none';
    if (document.getElementById('txtPurchaseOrderNo').value == '') {
        alert('Provide purchase order number');
        document.getElementById('txtPurchaseOrderNo').focus();
        return false;
    }
    if (document.getElementById('txtReceivedDate').value == '') {
        alert('Select stock received date');
        document.getElementById('txtReceivedDate').focus();
        return false;
    }
    if (document.getElementById('ddlSupplier').value != null) {
        if (document.getElementById('ddlSupplier').value == '0') {
            alert('Select the supplier name');
            document.getElementById('ddlSupplier').focus();
            return false;
        }
    }
    if (document.getElementById('txtDCNumber').value == "" && document.getElementById('txtInvoiceNo').value == "") {
        alert('Enter DC Number/InvoiceNo');
        document.getElementById('txtDCNumber').focus();
        document.getElementById('txtProductName').value = "";
        document.getElementById('btnFinish').style.display = 'block';
        return false;
    }

    if (document.getElementById('hdnProductList').value == '') {
        alert('Check the product list');
        document.getElementById('btnFinish').style.display = 'block';
        return false;
    }

    //if (document.getElementById('txtGrandTotal').value != 0.00) {
    if (ToInternalFormat($('#txtGrandTotal')) != 0.00) {
        //document.getElementById('hdnGrandTotal').value = document.getElementById('txtGrandTotal').value;
        document.getElementById('hdnGrandTotal').value = ToInternalFormat($('#txtGrandTotal'));
        ToTargetFormat($('#hdnGrandTotal'));
    }
    else {
        alert('Check the product list');
        document.getElementById('btnFinish').style.display = 'block';
        return false;
    }

    return true;
}

function checkIsEmpty(id) {




    if (document.getElementById('hdnHasExpiryDate').value != 'N') {
        if (document.getElementById('txtBatchNo').value == '') {
            alert('Provide batch number');
            document.getElementById('txtBatchNo').focus();
            return false;
        }

    }

    if (document.getElementById('ddlCategory').value == 0) {
        alert('Select category');
        document.getElementById('ddlCategory').focus();
        return false;
    }

    if (document.getElementById('hdnHasBatchNo').value != 'N') {
        if (document.getElementById('txtEXPDate').value == '') {
            alert('Provide expiry date');
            document.getElementById('txtEXPDate').focus();
            return false;
        }
    }
    if (document.getElementById('txtPoQuantity').value == '') {
        alert('Provide purchase order quantity');
        document.getElementById('txtQuantity').focus();
        return false;
    }
    if (document.getElementById('txtPoUnit').value == '') {
        alert('Provide purchase order unit');
        document.getElementById('txtPoUnit').focus();
        return false;
    }

    //  if (document.getElementById('txtRECQuantity').value == 0.00) {
    if (ToInternalFormat($('#txtRECQuantity')) == 0.00) {
        alert('Provide received quantity');
        document.getElementById('txtRECQuantity').focus();
        return false;
    }
    if (document.getElementById('txtRcvdUnit').value == '') {
        alert('Provide the received unit');
        document.getElementById('txtRcvdUnit').focus();
        return false;
    }
    if (document.getElementById('ddlSelling').value == '0') {
        alert('Select selling unit');
        document.getElementById('ddlSelling').focus();
        return false;
    }

    //if (document.getElementById('txtUnitPrice').value == 0.00) {
    if (ToInternalFormat($('#txtUnitPrice')) == 0.00) {
        alert('Provide cost price');
        document.getElementById('txtUnitPrice').focus();
        return false;
    }

    // if (document.getElementById('txtInvoiceQty').value == 0.00) {
    if (ToInternalFormat($('#txtInvoiceQty')) == 0.00) {
        alert('Provide invoice qty');
        document.getElementById('txtInvoiceQty').focus();
        return false;
    }

    //if (document.getElementById('txtRcvdLSUQty').value == 0.00) {
    if (ToInternalFormat($('#txtRcvdLSUQty')) == 0.00) {
        alert('Provide received LSU qty');
        document.getElementById('txtRcvdLSUQty').focus();
        return false;
    }
    // if (document.getElementById('txtSellingPrice').value == 0.00) {
    if (ToInternalFormat($('#txtSellingPrice')) == 0.00) {
        alert('Provide Selling Price');
        document.getElementById('txtSellingPrice').focus();
        return false;
    }
    //if (document.getElementById('txtMRP').value == 0.00) {
    if (ToInternalFormat($('#txtMRP')) == 0.00) {
        alert('Provide MRP');
        document.getElementById('txtMRP').focus();
        return false;
    }


    if (document.getElementById('hdnAttributeDetail').value == '') {
        alert('Provide the attributes');
        document.getElementById('lbtnAttribute').focus();
        return false;
    }

    // if (Number(document.getElementById('txtSellingPrice').value) < Number(document.getElementById('txtUnitPrice').value)) {
    if (Number(ToInternalFormat($('#txtSellingPrice'))) < Number(ToInternalFormat($('#txtUnitPrice')))) {
        alert('Provide Selling Price greater than Cost Price');
        document.getElementById('txtSellingPrice').select();
        return false;
    }

    // if (Number(document.getElementById('txtMRP').value) < Number(document.getElementById('txtUnitPrice').value)) {
    if (Number(ToInternalFormat($('#txtMRP'))) < Number(ToInternalFormat($('#txtUnitPrice')))) {
        alert('Provide MRP greater than Cost Price');
        document.getElementById('txtMRP').select();
        return false;
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
                        alert('Product name and batch number combination already exist ');
                        document.getElementById('txtBatchNo').focus();
                        return false;
                    }

                }
            }
        }
        else {
            alert('Ensure items added/quantity are provided properly');
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
                        alert('Provide received quantity less than or equal to ordered qty');
                        document.getElementById('txtPoQuantity').focus();
                        return false;
                    }



                }

            }

        }
    }
    document.getElementById('tbTotalCost').style.display = "block";
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
    document.getElementById('TableProductDetails').style.display = "block";
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



}
function BindProductList() {

    if (document.getElementById('hdnAttributes').value == 'N') {
        document.getElementById('hdnGridPopCount').value = (Number(document.getElementById('txtRcvdLSUQty').value) + Number(document.getElementById('txtCompQuantity').value))
    }

    if (document.getElementById('hdnAttributes').value != 'N' && Number(document.getElementById('hdnGridPopCount').value) != (Number(document.getElementById('txtRcvdLSUQty').value) + Number(document.getElementById('txtCompQuantity').value))) {
        if (document.getElementById('hdnAttributeDetail').value == '') {
            alert('Provide the attributes');
            document.getElementById('lbtnAttribute').focus();
            return false;
        }
        else {
            alert('The number of product and detail does not match');
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

        document.getElementById('hdnProductList').value = pId + "~" + pName + "~" +
                                    pCategory + "~" + pCategoryId + "~" + pBatchNo + "~" +
                                    pMFTDate + "~" + pEXPDate + "~" + pPoQuantity + "~" +
                                    pPoUnit + "~" + pRECQuantity + "~" +
                                    pRECUnit + "~" + pCompQTY + "~" + pUnitPrice + "~" + pDiscount + "~" + pTax
                                     + "~" + pTotalCost + "~" + pTQty + "~" + pSellingPrice + "~" + pSellingUnit + "~" + pInvoiceQty
                                     + "~" + pRcvdLSUQty + "~" + pUnitCostPrice + "~" + pUnitSellingPrice + "~" + pAttrib
                                     + "~" + pAttribDetail + "~" + pHasExpDate + "~" + pHasBatchNo + "~" + pAttCount + "~"
                                     + pRakNo + "~" + pMRP + "^" +
                                     document.getElementById('hdnProductList').value;
        Tblist();




    }
    //It affects InvAttribute user control
    document.getElementById('add').value = 'Add';
    document.getElementById('hdnAdd').value = 'Add';
    document.getElementById('hdnGridPopCount').value = '';
    document.getElementById('hdnAttributeDetail').value = 'N';

}

function Tblist() {
    var table = '';
    var tr = '';
    var end = '</table>';
    var y = '';
    var pRowId = document.getElementById('hdnRowId').value;
    document.getElementById('lblTable').innerHTML = '';
    table = "<table cellpadding='2' class='dataheaderInvCtrl' cellspacing='0' border='1'"
                           + "style='width: 97%'><thead  align='center' class='dataheader1' style='padding: 5 5 5 5; font-size:11px'>"
                           + "<th style='width:115px;'>Product Name</th>"
                           + "<th style='width:70px;'>Batch No</th>"
                           + "<th style='width:100px;'>Date</th>"
                           + "<th style='width:85px;'>PO Qty</th>"
                           + "<th style='width:85px;'>Rcvd Qty</th>"
                           + "<th style='width:50px;'>Selling Unit</th>"
                           + "<th style='width:50px;'>Inverse Qty</th>"
                           + "<th style='width:85px;'>Rcvd LSU Qty</th>"
                           + "<th style='width:85px;'>Comp Qty(LSU)</th>"
                           + "<th style='width:60px;'>Cost Price</th>"
                           + "<th style='width:50px;'>Discount</th>"
                           + "<th style='width:50px;'>Tax %</th>"
                           + "<th style='width:85px;'>Selling Price</th>"
                           + "<th style='width:85px;'>M.R.P</th>"
                           + "<th style='width:85px;'>RakNo</th>"
                           + "<th style='width:85px;'>Total Cost</th>"
                           + "<th style='width:85px;'>Action</th></thead>";

    var x = document.getElementById('hdnProductList').value.split("^");
    document.getElementById('lblTotalCostAmount').innerHTML = '0.00';
    ToTargetFormat($('#lblTotalCostAmount'));
    document.getElementById('txtDiscountAmt').value = '0.00'
    ToTargetFormat($('#txtDiscountAmt'));
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

            tr += "<tr align='center'><td style='width:115px;'>"
                        + y[1] + "</td><td style='width:70px;'>"
                        + y[4] + "</td><td style='width:180px;'><table width='100%'><tr ><td>MFT: "
                        + y[5] + "</td></tr><tr><td>EXP: "
                        + y[6] + "</td></tr></table></td><td style='width:90px;'>"
                        + y[7] + "<br/>(" + y[8] + ")</td><td style='width:85px;'>"
                        + y[9] + "<br/>(" + y[10] + ")</td><td style='width:85px;'>"
                        + y[18] + "</td><td style='width:50px;'>"
                        + y[19] + "</td><td style='width:50px;'>"
                        + y[20] + "</td><td style='width:50px;'>"
                        + y[11] + "</td><td style='width:50px;'>"
                        + y[12] + "</td><td style='width:50px;'>"
                        + y[13] + "</td><td style='width:50px;'>"
                        + y[14] + "</td><td style='width:50px;'>"
                        + y[17] + "</td><td style='width:50px;'>"
                        + y[29] + "</td><td style='width:50px;'>"
                        + y[28] + "</td><td style='width:50px;'>"
                        + y[15] + "</td>"
                         + "<td><input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "~" + y[23] + "~" + y[24] + "~" + y[25] + "~" + y[26] + "~" + y[27] + "~" + y[28] + "~" + y[29] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
                        + "<br><input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "~" + y[23] + "~" + y[24] + "~" + y[25] + "~" + y[26] + "~" + y[27] + "~" + y[28] + "~" + y[29] + "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></td></tr>";


            document.getElementById('hdnFormatvalue').value = document.getElementById('lblTotalCostAmount').innerHTML;
            ToTargetFormat($('#hdnFormatvalue'));
            document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(y[15]) + parseFloat(ToInternalFormat($('#hdnFormatvalue')))).toFixed(2);
            ToTargetFormat($('#lblTotalCostAmount'));
            //document.getElementById('hdnTotalCost').value = parseFloat(parseFloat(y[15]) + parseFloat(document.getElementById('hdnTotalCost').value)).toFixed(2);
            document.getElementById('hdnTotalCost').value = parseFloat(parseFloat(y[15]) + parseFloat(ToInternalFormat($('#hdnTotalCost')))).toFixed(2);
            ToTargetFormat($('#hdnTotalCost'));

            document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(y[15]) + parseFloat(ToInternalFormat($('#txtGrandTotal')))).toFixed(2);
            ToTargetFormat($('#txtGrandTotal'));

            document.getElementById('txtNetTotal').value = (parseFloat(ToInternalFormat($('#txtGrandTotal')))).toFixed(2);
            ToTargetFormat($('#txtNetTotal'));

            document.getElementById('txtDiscountAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtDiscountAmt'))) + parseFloat(parseFloat(parseFloat(y[13]) / 100) * (parseFloat(y[12]) * parseFloat(y[9])))).toFixed(2);
            ToTargetFormat($('#txtDiscountAmt'));
            var SubDis = parseFloat(parseFloat(parseFloat(y[13]) / 100) * (parseFloat(y[12]) * parseFloat(y[9]))).toFixed(2);
            //  document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(document.getElementById('txtTaxAmt').value) + parseFloat(parseFloat(parseFloat(y[14]) / 100) * (parseFloat(parseFloat(y[12]) * parseFloat(y[9]))))).toFixed(2);

            document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($('#txtTaxAmt'))) + parseFloat(parseFloat(parseFloat(y[14]) / 100) * (parseFloat(parseFloat(parseFloat(y[12]) * parseFloat(y[9])) - parseFloat(parseFloat(parseFloat(parseFloat(y[13]) / 100) * (parseFloat(y[12]) * parseFloat(y[9])))))))).toFixed(2);
            ToTargetFormat($('#txtTaxAmt'));

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
        document.getElementById('submitTab').style.display = "none";
    }
    else {
        document.getElementById('submitTab').style.display = "block";
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
    calculateCastPerUnit();
    var tax = ToInternalFormat($('#txtTax')) == 0.00 ? 0 : ToInternalFormat($('#txtTax')); //document.getElementById('txtTax').value == 0.00 ? 0 : document.getElementById('txtTax').value;
    var Discount = ToInternalFormat($('#txtDiscount')) == 0.00 ? 0 : ToInternalFormat($('#txtDiscount'));  //document.getElementById('txtDiscount').value == 0.00 ? 0 : document.getElementById('txtDiscount').value;
    var UnitPrice = ToInternalFormat($('#txtUnitPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtUnitPrice'));  //document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
    var RECQuantity = ToInternalFormat($('#txtRcvdLSUQty')) == 0.00 ? 0 : ToInternalFormat($('#txtRcvdLSUQty'));  //document.getElementById('txtRcvdLSUQty').value == 0.00 ? 0 : document.getElementById('txtRcvdLSUQty').value;
    //old var UnitPrice = document.getElementById('hdnUnitCostPrice').value == 0.00 ? 0 : document.getElementById('hdnUnitCostPrice').value;
    var Inverse = ToInternalFormat($('#txtInvoiceQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvoiceQty')); //document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
    if (Inverse > 0) {
        RECQuantity = Number(RECQuantity) / Number(Inverse);
        var TotalCost = (parseFloat(RECQuantity) * parseFloat(UnitPrice)).toFixed(6);

        pDiscount = parseFloat(parseFloat(parseFloat(TotalCost) / parseFloat(100)) * parseFloat(Discount)).toFixed(6);


        Total = parseFloat(parseFloat(TotalCost) - parseFloat(pDiscount)).toFixed(6);

        tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(6);

        document.getElementById('txtTotalCost').value = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);

        ToTargetFormat(($('#txtTotalCost')));
    }

}

function calculateCastPerUnit() {

    var IsRecd = document.getElementById('hdnIsResdCalc').value;
    if (IsRecd == 'SUnit') {
        var UnitPrice = ToInternalFormat($('#txtUnitPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtUnitPrice'));   //var UnitPrice = document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
        var Inverse = ToInternalFormat($('#txtInvoiceQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvoiceQty')); // var Inverse = document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitCostPrice').value = parseFloat(UnitPrice).toFixed(6);
        ToTargetFormat($('#hdnUnitCostPrice'));
    }
    if (IsRecd == 'PoUnit') {
        var UnitPrice = ToInternalFormat($('#txtUnitPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtUnitPrice')); // var UnitPrice = document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
        var Inverse = ToInternalFormat($('#txtInvoiceQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvoiceQty')); //var Inverse = document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitCostPrice').value = (parseFloat(UnitPrice) / parseFloat(Inverse)).toFixed(6);
        ToTargetFormat($('#hdnUnitCostPrice'));
    }

    if (IsRecd == 'RPoUnit') {


        var UnitPrice = ToInternalFormat($('#txtUnitPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtUnitPrice'));  // var UnitPrice = document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
        var RecdQty = ToInternalFormat($('#txtRECQuantity')) == 0.00 ? 0 : ToInternalFormat($('#txtRECQuantity'));  //var RecdQty = document.getElementById('txtRECQuantity').value == 0.00 ? 0 : document.getElementById('txtRECQuantity').value;
        var perUnit = (parseFloat(UnitPrice) / parseFloat(RecdQty)).toFixed(6);

        //var Inverse = document.getElementById('txtInvoiceQty').value;
        var Inverse = ToInternalFormat($('#txtInvoiceQty'));
        document.getElementById('hdnUnitCostPrice').value = (parseFloat(perUnit) / parseFloat(Inverse)).toFixed(6);
        ToTargetFormat($('#hdnUnitCostPrice'));
    }
    if (IsRecd == 'RLsuSell') {
        var UnitPrice = ToInternalFormat($('#txtUnitPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtUnitPrice'));  //   var UnitPrice = document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
        var Inverse = ToInternalFormat($('#txtInvoiceQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvoiceQty')); // var Inverse = document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        var RecdQtylsu = ToInternalFormat($('#txtRcvdLSUQty')) == 0.00 ? 0 : ToInternalFormat($('#txtRcvdLSUQty')); // var RecdQtylsu = document.getElementById('txtRcvdLSUQty').value == 0.00 ? 0 : document.getElementById('txtRcvdLSUQty').value;
        var perUnitLsu = (parseFloat(UnitPrice) / parseFloat(RecdQtylsu)).toFixed(6);
        document.getElementById('hdnUnitCostPrice').value = parseFloat(perUnitLsu).toFixed(6);
        ToTargetFormat($('#hdnUnitCostPrice'));
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

        document.getElementById('hdnProductList').value = pId + "~" + pName + "~" +
                                    pCategory + "~" + pCategoryId + "~" + pBatchNo + "~" +
                                    pMFTDate + "~" + pEXPDate + "~" + pPoQuantity + "~" +
                                    pPoUnit + "~" + pRECQuantity + "~" +
                                    pRECUnit + "~" + pCompQTY + "~" + pUnitPrice + "~" + pDiscount + "~" + pTax
                                    + "~" + pTotalCost + "~" + pTQty + "~" + pSellingPrice + "~" + pSellingUnit + "~" +
                                    pInvoiceQty + "~" + pRcvdLSUQty + "~" + pUnitCostPrice + "~" + pUnitSellingPrice + "~" +
                                    pAttrib + "~" + pAttribDetail + "~" + pHasExpDate + "~" +
                                    pHasBatchNo + "~" + pAttCount + "~" + pRakNo + "~" + pMRP + "^";

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

    document.getElementById('TableProductDetails').style.display = "block";
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
    alert('    ')
}

function CheckRcvdLSUQty() {
    var pInvoiceQty = ToInternalFormat($('#txtInvoiceQty')); //  var pInvoiceQty = document.getElementById('txtInvoiceQty').value;
    var pRECQuantity = ToInternalFormat($('#txtRECQuantity')); //var pRECQuantity = document.getElementById('txtRECQuantity').value;

    // var AllowedQty = document.getElementById('hdnAllowedQty').value;
    var AllowedQty = ToInternalFormat($('#hdnAllowedQty'));
    document.getElementById('txtRcvdLSUQty').value = parseFloat(pInvoiceQty).toFixed(2) * parseFloat(pRECQuantity).toFixed(2);
    ToTargetFormat($('#txtRcvdLSUQty'));
    //if (Number(pRECQuantity) > Number(document.getElementById('txtPoQuantity').value)) {
    if (Number(pRECQuantity) > Number(ToInternalFormat($('#txtPoQuantity')))) {
        alert('Provide received quantity less than or equal to ordered qty')
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
    document.getElementById('TableProductDetails').style.display = "block";
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
    // var Total = parseFloat(parseFloat(document.getElementById('hdnTotalCost').value) - parseFloat(document.getElementById('txtTotalDiscount').value)).toFixed(2);
    var Total = parseFloat(parseFloat(ToInternalFormat($('#hdnTotalCost'))) - parseFloat(ToInternalFormat($('#txtTotalDiscount')))).toFixed(2);

    // tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(document.getElementById('txtTotaltax').value)).toFixed(2);
    tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(ToInternalFormat($('#txtTotaltax')))).toFixed(2);

    document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
    ToTargetFormat($('#lblTotalCostAmount'));
    document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
    ToTargetFormat($('#txtGrandTotal'));
    //document.getElementById('txtNetTotal').value = parseFloat((parseFloat(document.getElementById('txtGrandTotal').value)) - parseFloat(document.getElementById('txtUseCreditAmount').value)).toFixed(2);
    document.getElementById('txtNetTotal').value = parseFloat((parseFloat(ToInternalFormat($('#txtGrandTotal')))) - parseFloat(ToInternalFormat($('#txtUseCreditAmount')))).toFixed(2);
    ToTargetFormat($('#txtNetTotal'));
    //if (parseFloat(document.getElementById('txtUseCreditAmount').value) > parseFloat(document.getElementById('txtAvailCreditAmount').value)) {
    if (parseFloat(ToInternalFormat($('#txtUseCreditAmount'))) > parseFloat(ToInternalFormat($('#txtAvailCreditAmount')))) {
        alert('Use within available credit amount');
        document.getElementById('txtUseCreditAmount').value = 0;
        ToTargetFormat($('#txtUseCreditAmount'));
        document.getElementById('txtUseCreditAmount').focus();
    }
    // if (parseFloat(document.getElementById('txtUseCreditAmount').value) > parseFloat(document.getElementById('txtGrandTotal').value)) {
    if (parseFloat(ToInternalFormat($('#txtUseCreditAmount'))) > parseFloat(ToInternalFormat($('#txtGrandTotal')))) {
        alert('Use credit amount lessthan or equal to GrandTotal');
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


function getMonthValue(source) {
    var month_names = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    for (var i = 0; i < month_names.length; i++) {
        if (month_names[i] == source) {
            return i;
        }
    }
}

function CheckDatesMfg(splitChar, ObjDate, flag) {

    var today = new Date();

    if (ObjDate.value.trim() == '') {
        alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
        ObjDate.select();
        return false;
    }
    else {
        //Assign From And To Date from Controls
        splitChar = ObjDate.value.split(' ').length > 1 ? splitChar : '/';
        var DateFrom = new Array(2);
        var DateNow = new Array(2);
        DateFrom[0] = (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1);
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

    var today = new Date();

    if (ObjDate.value.trim() == '') {
        alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
        ObjDate.select();
        return false;
    }
    else {
        //Assign From And To Date from Controls
        splitChar = ObjDate.value.split(' ').length > 1 ? splitChar : '/';
        var DateFrom = new Array(2);
        var DateNow = new Array(2);
        DateFrom[0] = (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1);
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
                alert('Mismatch Month Between Current & Mfg Date');
            }
            else {
                alert('Mismatch Month Between Current & Exp Date');
            }
            return false;
        }
    }
    else {
        if (bit == 0) {
            alert('Mismatch Year Between Current & Mfg Date');
        }
        else {
            alert('Mismatch Year Between Current & Exp Date');
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
    document.getElementById('ddlSelling').disabled = false;

    //*****jayamoorthi************
    document.getElementById('txtGrandwithRoundof').value = '0.00';
    ToTargetFormat($('#txtGrandwithRoundof'));
    //****************
    document.getElementById('TableProductDetails').style.display = "block";


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
            alert("Provide valid date");
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
            document.getElementById(obj).focus();
            alert("Provide valid date");
        }
        return isTrue;
    }


}
    