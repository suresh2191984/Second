
/*! Copyright (c) 2010 Einstien Castro (http://EinstienCastro.net)
* Licensed under the MIT License (LICENSE.txt).
*
* Version 1.1.1-Live
*/
//var errorMsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Error" : SListForAppMsg.Get("CentralReceiving_Error");
//var infoMsg = SListForAppMsg.Get("CentralReceiving_Information") == null ? "Information" : SListForAppMsg.Get("CentralReceiving_Information");
//var okMsg = SListForAppMsg.Get("CentralReceiving_Ok") == null ? "Ok" : SListForAppMsg.Get("CentralReceiving_Ok");
//var cancelMsg = SListForAppMsg.Get("CentralReceiving_Cancel") == null ? "Cancel" : SListForAppMsg.Get("CentralReceiving_Cancel");
//var objPackSale = SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_01') == null ? "Packing Sale" : SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_01');
//var objExDuty = SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_02') == null ? "Excise Duty" : SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_02');
//var objEdClass = SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_03') == null ? "Edu Cess" : SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_03');
//var objSecClass = SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_04') == null ? "Sec Cess" : SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_04');

var NetTotal;

$(function() {
    if ($('#hdnGetTaxList').val() != '') {
        var myJSONText = $('#hdnGetTaxList').val();
        var Tax = JSON.parse(myJSONText);
        BindTaxTypes(Tax);
    }

    PageLoadScript();
    $('#divNotification').corner();
    $('.contentdata1').css('height', $(document).height());
});

$(document).ready(function() {
    SetColorFocus();
    ValidateCheckBatchNo();
    setTimeout(function() {
        $('#divLoadingGif').hide();
    }, 200);
    //    $("#txtReceivedDate").datepicker({ dateFormat: "dd/mm/yy", changeYear: true });
    //    $("#txtInvoiceDate").datepicker({ dateFormat: "dd/mm/yy", changeYear: true });


    $('#divStockReceived input:text').blur(function() {
        if ($(this).attr('class') != undefined && $(this).attr('class') != ''
    && ($(this).attr('class') == 'SellingPrice' || $(this).attr('class') == 'ComplimentQTY'
    || $(this).attr('class') == 'DIS' || $(this).attr('class') == 'TAX' || $(this).attr('class') == 'InvoiceQty')) {
            var val = $.trim($(this).val());
            if (val == '') {
                $(this).val('0.00');
            }
        }
    });

    $('#txtUseCreditAmount').keyup(function(event) {
        CalculateNetTotal('CA');
        var netTotal = $.trim($('#txtNetTotal').val());
        if (netTotal == '') {
            netTotal = 0;
        }
        var availableCredit = $.trim($('#txtAvailCreditAmount').val());
        if (availableCredit == '') {
            availableCredit = 0;
        }
        var creditAmount = $.trim($('#txtUseCreditAmount').val());
        if (creditAmount == '') {
            creditAmount = 0;
        }
        if (Number(creditAmount) > Number(netTotal) || Number(creditAmount) > Number(availableCredit)) {
            var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_01") == null ? "Credit Amount Should not be Greater Than Net Amount" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_01");
            var errorMsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Alert" : SListForAppMsg.Get("CentralReceiving_Error");
            ValidationWindow(userMsg, errorMsg);
            $('#txtUseCreditAmount').val('0.00');
        }
    });

});


function PageLoadScript() {
    var errorMsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Alert" : SListForAppMsg.Get("CentralReceiving_Error");
    $(".Manufacture").datepicker({ dateFormat: $('#hdnMonthFormat').val(), changeYear: true, changeMonth: true });
    if ($("#hdnExpiryDateFormatDDMMYYY").val() != "Y") {
        $(".ExpiryDate").datepicker({ dateFormat: $('#hdnMonthFormat').val(), changeYear: true, changeMonth: true });
    }
    else {
        $(".ExpiryDate").datepicker({ dateFormat: $('#hdnDateFormat').val(), changeYear: true, changeMonth: true });
        $(".ExpiryDate").mask("_/_/_");
        $(".ExpiryDate").attr("style", "width:70px")
    }

    $("#txtReceivedDate").mask("_/_/_");
    $("#txtInvoiceDate").mask("_/_/_");
    $(".Manufacture").mask("_/_");
    $(".ExpiryDate").mask("_/_");

    $('.ExpiryDate').change(function() {
        var rowObj = $(this).parent('td').parent('tr').find('td');
        var eDate = $(this).val();
        var mDate = $(rowObj).children('input.Manufacture').val()

        var from = '01/' + mDate;
        var to;
        if ($("#hdnExpiryDateFormatDDMMYYY").val() != "Y") {
            to = '01/' + eDate;
        }
        else {
            to = $(this).val();
        }
        if (Date.parse(from) >= Date.parse(to)) {
            var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_02") == null ? "Invalid Date Range" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_02");
            ValidationWindow(userMsg, errorMsg);
            $(this).val('');
        }
    });

    $('.Manufacture').change(function() {
        var rowObj = $(this).parent('td').parent('tr').find('td');
        var mDate = $(this).val();

        var today = new Date();
        var mm = today.getMonth() + 1;
        var yyyy = today.getFullYear();

        var from = '01/' + mDate;
        var to = '01/' + mm + '/' + yyyy;

        if (Date.parse(from) > Date.parse(to)) {
            var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_02") == null ? "Invalid Date Range" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_02");
            ValidationWindow(userMsg, errorMsg);
            $(this).val('');
        }
    });

    SetNoValiDation();
    CalculateUnitPrice();
    CalculateTotalDiscountAmount();
    CalculateSupplierServiceTax('');
    CalculatePODiscount('');
    NetTotal = $('#txtNetTotal').val();
}

function SetColorFocus() {

    //$('input:text').css({ 'background-color': '#96C4DD', 'border': 'none' });

    //    $('input:text').focus(function() {
    //        $(this).css({ 'background-color': '#8FE9EB', 'border': 'solid 1px black' });
    //    });

    //    $('input:text').blur(function() {
    //        $(this).css({ 'background-color': 'none', 'border': 'none' });
    //    });
}


var _topError = 0;
var userMsg;
function getvalidation(evt) {
    var errorMsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Alert" : SListForAppMsg.Get("CentralReceiving_Error");
    var ddlSupplier = document.getElementById('ddlSupplier').value;
    if (ddlSupplier == '') {
        _topError = 1;
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_03") == null ? "Select a Supplier Name" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_03");
        ValidationWindow(userMsg, errorMsg);
        return false;
    }
    else {
        _topError = 0;
    }
    if (document.getElementById('txtDCNumber').value == "" && document.getElementById('txtInvoiceNo').value == "") {
        _topError = 2;
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_04") == null ? "Enter DC Number/InvoiceNo" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_04");
        ValidationWindow(userMsg, errorMsg);
        return false;
    }
    else {
        _topError = 0;
    }

    if (document.getElementById('txtInvoiceDate').value == "" && document.getElementById('txtInvoiceNo').value != "") {
        _topError = 3;
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_05") == null ? "Enter Invoice Date" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_05");
        ValidationWindow(userMsg, errorMsg);
        return false;
    }
    else {
        _topError = 0;
    }

    return true;
}


function Validate() {

    var infoMsg = SListForAppMsg.Get("CentralReceiving_Information") == null ? "Information" : SListForAppMsg.Get("CentralReceiving_Information");
    var okMsg = SListForAppMsg.Get("CentralReceiving_Ok") == null ? "Ok" : SListForAppMsg.Get("CentralReceiving_Ok");
    var cancelMsg = SListForAppMsg.Get("CentralReceiving_Cancel") == null ? "Cancel" : SListForAppMsg.Get("CentralReceiving_Cancel");
    var objcnfrm = SListForAppMsg.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_15') == null ? "Do you want to continue Click OK" : SListForAppMsg.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_15');
    if (ConfirmWindow(objcnfrm, infoMsg, okMsg, cancelMsg) == false) {
        return false;
    } else {
        document.getElementById('btnCancel').focus();
        return true
    }
}


function KeyPress1(e) {
    var errorMsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Alert" : SListForAppMsg.Get("CentralReceiving_Error");
    var ddlaction = document.getElementById('ddlSupplier');
    if (ddlaction.visibility == "visible") {
        if (ddlaction.options[ddlaction.selectedIndex].value == '0') {
            var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_06") == null ? "Select a Supplier" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_06");
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        var Type = 'DC';
        var s1val = ddlaction.options[ddlaction.selectedIndex].value + '~' + Type;
    }
    else {
        var Type = 'DC';
        var s1val = document.getElementById('hdnSupplierID').value + '~' + Type;
    }
}

function KeyPress2(e) {
    var errorMsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Alert" : SListForAppMsg.Get("CentralReceiving_Error");
    var ddlaction = document.getElementById('ddlSupplier');
    if (ddlaction.visibility == "visible") {
        if (ddlaction.options[ddlaction.selectedIndex].value == '0') {
            var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_06") == null ? "Select a Supplier" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_06");
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        var Type = 'INVOICE';
        var s1val = ddlaction.options[ddlaction.selectedIndex].value + '~' + Type;
    }
    else {
        var Type = 'INVOICE';
        var s1val = document.getElementById('hdnSupplierID').value + '~' + Type;
    }
}
function ChkDcSupplierCombination(source, eventArgs) {
    var supplierid = eventArgs.get_value();
    var ddl = document.getElementById('ddlSupplier');
    if (ddl.visibility == "visible") {
        if (supplierid == ddl.options[ddl.selectedIndex].value) {
            DCAlert();
        }
    }
    else {
        if (supplierid == document.getElementById('hdnSupplierID').value) {
            DCAlert();
        }
    }
}

function ChkInvoiceSupplierCombination(source, eventArgs) {
    var supplierid = eventArgs.get_value();
    var ddl = document.getElementById('ddlSupplier');
    if (ddl.visibility == "visible") {
        if (supplierid == ddl.options[ddl.selectedIndex].value) {
            InvoiceAlert();
        }
    }
    else {
        if (supplierid == document.getElementById('hdnSupplierID').value) {
            InvoiceAlert();
        }
    }
}

function funcChangeType() {
    if (document.getElementById('ddlSupplier').value != 0) {
        document.getElementById("hdnSupplierID").value = document.getElementById('ddlSupplier').value;
    }
}

var _error = 0;
function GetStockReceivedDatas() {
    getvalidation();
    ValidateFields();
    var errorMsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Alert" : SListForAppMsg.Get("CentralReceiving_Error");
    if (_topError == 0) {
        if (_error == 0) {
            GetSRDatas();
            if ($('#hdnProductList').val() != '') {
                $('#divLoadingGif').show();
                SaveProductList();
            }
            else {
                var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_07") == null ? "No Items To Save !!!" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_07");
                ValidationWindow(userMsg, errorMsg);
            }
        }
        else {
            var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_08") == null ? "Please Enter The Fields With Red Border & Empty Fields" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_08");
            ValidationWindow(userMsg, errorMsg);
        }
    }
}

function SaveProductList() {
    var errorMsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Alert" : SListForAppMsg.Get("CentralReceiving_Error");
    var frameQueryString = '';
    var SupplierID = 0;
    if ($('#hdnSupplierID').val() != '') {
        frameQueryString += '&SupplierID=' + $('#hdnSupplierID').val();
    }
    frameQueryString += '&Comments=' + $.trim($('#txtComments').val());
    frameQueryString += '&POrgID=' + $('#hdnOrgID').val();
    frameQueryString += '&OrgAddressID=' + $('#hdnILocationID').val();
    frameQueryString += '&ToLocationID=' + $('#hdnInventoryLocationID').val();
    frameQueryString += '&FromLocationID=' + $('#hdnInventoryLocationID').val();
    frameQueryString += '&CreatedBy=' + $('#hdnLID').val();
    frameQueryString += '&InvoiceNo=' + $.trim($('#txtInvoiceNo').val());
    frameQueryString += '&InvoiceDate=' + $.trim($('#txtInvoiceDate').val());
    frameQueryString += '&DCNumber=' + $.trim($('#txtDCNumber').val());
    frameQueryString += '&Tax=' + $.trim($('#txtTaxAmt').val());
    frameQueryString += '&StockReceivedTypeID=' + $('#hdnFromSupplier').val();
    frameQueryString += '&Discount=' + $.trim($('#txtDiscountAmt').val());
    frameQueryString += '&GrandTotal=' + $.trim($('#txtNetTotal').val());
    frameQueryString += '&Status=' + $('#hdnStockOutFlowStatus').val();
    frameQueryString += '&UsedCreditAmount=' + $.trim($('#txtUseCreditAmount').val());
    frameQueryString += '&RoundOfValue=' + $.trim($('#txtRoundOffValue').val());
    var calcType = 'SP';
    if ($('#rbtnCP').attr('checked')) {
        calcType = 'CP';
    }
    frameQueryString += '&CalculationType=' + calcType;
    var PurchaseOrderNo = 0;
    if (getParameterByName('PONO') != '') {
        frameQueryString += '&PurchaseOrderNo=' + getParameterByName('PONO');
    }

    frameQueryString += '&PackingSale=' + $('#txtPackingSale').val();
    frameQueryString += '&ExciseDuty=' + $('#txtExciseDuty').val();
    frameQueryString += '&EduCess=' + $('#txtEduCess').val();
    frameQueryString += '&SecCess=' + $('#txtSecCess').val();
    frameQueryString += '&CST=' + $('#txtCST').val();
    frameQueryString += '&POID=' + $('#hdnPOID').val();
    frameQueryString += '&SName=' + $('#hdnSupplierName').val();
    frameQueryString += '&SupplierServiceTax=' + $('#txtTotaltax').val();
    frameQueryString += '&PoDiscount=' + $.trim($('#txtTotalDiscount').val());
    frameQueryString += '&SupplierServiceTaxAmount=' + $.trim(SupplierServiceTax);

    var ReceivedDate = $('#txtReceivedDate').val();

    var d = new Date();
    var time;

    if (!!d.valueOf()) { // Valid date
        var Hours = d.getHours();
        var Minutes = d.getMinutes();
        var Seconds = d.getSeconds();

        if (Number(Hours) < 10) {
            Hours = "0" + Hours;
        }
        if (Number(Minutes) < 10) {
            Minutes = "0" + Minutes;
        }
        if (Number(Seconds) < 10) {
            Seconds = "0" + Seconds;
        }
        time = Hours + ":" + Minutes + ":" + Seconds;
    }
    var _DateTime = ReceivedDate;// + ' ' + time;
    frameQueryString += '&ReceivedDate=' + $.trim(_DateTime);
    if ($('#hdnbarCodeMapping').val() == "Y") {
        frameQueryString += '&BarCodeMapping=Y';
    }
    else {
        frameQueryString += '&BarCodeMapping=N' ;
    }
    frameQueryString = 'Save=Yes&ProductList=' + $('#hdnProductList').val() + frameQueryString;
    $.ajax({
        url: 'GetCategoryRow.aspx?' + frameQueryString,
        success: function(data) {
            $('#divLoadingGif').hide();
            var StockReceivedID = data.split('||')[0];
            if (StockReceivedID != '' && StockReceivedID != '-1') {
                $('#hdnSRID').val(StockReceivedID);
                $('#btnRedirect').click();
            }
            else {
                var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_09") == null ? "Error..." : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_09");
                ValidationWindow(userMsg, errorMsg);
            }
        }
    });
}

function ValidateFields() {
    var count = $("#divStockReceived table#tblSRRow tbody tr.trRow").children().length;
    var errorMsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Alert" : SListForAppMsg.Get("CentralReceiving_Error");
    _error = 0;

    $("#divStockReceived table#tblSRRow tbody tr.trRow").each(function() {
        $(this).children('td').each(function(i) {
            if ($(this).children().attr('tagName') == 'SPAN') {

            }
            else if ($(this).children().attr('tagName') == 'SELECT') {
                if ($(this).children('select').attr('Validate') == '1') {
                    if ($(this).children('select').val() == '0') {
                        $(this).children('select').css('border', 'solid 1px red');
                        _error++;
                    }
                    else {
                        $(this).children('select').css('border', '0');
                    }
                }
            }
            else {
                if ($(this).css('display') == 'table-cell' && $(this).children('input').attr('Validate') == '1') {
                    if ($(this).children('input').attr('type') == 'checkbox') {
                        if (!$(this).children('input').attr('checked')) {
                            $(this).children('input').css('border', 'solid 1px red');
                            _error++;
                        }
                    }
                    else if ($(this).children('input').attr('type') == 'text') {
                        if ($.trim($(this).children('input').val()) == '' || $(this).children('input').val() == '_/_'
                    || Number($.trim($(this).children('input').val())) <= 0) {
                            $(this).children('input').css('border', 'solid 1px red');
                            _error++;
                        }
                    }
                    else {
                        if ($(this).children('input').attr('class') == 'ExpiryDate hasDatepicker') {
                            var futureDate = new Date();
                            futureDate.setMonth(futureDate.getMonth() + 3);
                            var getExpDateField = $(this).children('input').val().split('/');
                            var expDate = new Date(getExpDateField[0] + '/01/' + getExpDateField[1]);
                            if (Date.parse(expDate) < Date.parse(futureDate)) {
                                var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_10") == null ? "Expiry Date Sholud Be Greter Than Three Months" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_10");
                                ValidationWindow(userMsg, errorMsg);
                                $(this).children('input').css('border', 'solid 1px red');
                                _error++;
                            }
                        }
                        else {
                            $(this).children('input').css('border', '0');
                        }
                    }
                }
            }
        });
    });
}


function GetSRDatas() {
    var count = $("#divStockReceived table#tblSRRow tbody tr.trRow").children().length;
    var GetValue = '';
    $("#divStockReceived table#tblSRRow tbody tr.trRow").each(function() {
        $(this).children('td').each(function(i) {
            if (i == 0) {
                GetValue += 'CategoryID' + '*' + $(this).children('span').attr('CategoryID') + '^';
                GetValue += 'ProductID' + '*' + $(this).children('span').attr('ProductID') + '^';
            }
            else {
                if ($(this).children().attr('tagName') == 'SPAN') {
                    if ($(this).children().html() != '') {
                        GetValue += $(this).children().attr('Attr') + '*' + $(this).children().html() + '^';
                    }
                    else {
                        GetValue += $(this).children().attr('Attr') + '*' + ' ' + '^';
                    }
                }
                else if ($(this).children().attr('tagName') != 'IMG') {
                    if ($(this).children('input').attr('type') == 'checkbox') {

                        if ($(this).children('input').attr('checked')) {
                            GetValue += $(this).children().attr('Attr') + '*' + '1' + '^';
                        }
                        else {
                            GetValue += $(this).children().attr('Attr') + '*' + '0' + '^';
                        }
                    }
                    else {
                        if ($(this).children().val() != '') {
                            GetValue += $(this).children().attr('Attr') + '*' + $(this).children().val() + '^';
                        }
                        else {
                            GetValue += $(this).children().attr('Attr') + '*' + $(this).children().html() + '^';
                        }
                    }
                }
            }
        });
        GetValue += '|';
    });
    $('#hdnProductList').val(GetValue);
}


function CalculateTotalCost(ele) {
    var obj = '';
    var errorMsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Alert" : SListForAppMsg.Get("CentralReceiving_Error");
    switch ($(ele).attr('class')) {
        case 'RQTY':

            if ($.trim($(ele).val()) == '' || $.trim($(ele).val()) <= 0) {
                var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_11") == null ? "Please enter the received qty greatter than zero" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_11");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else {

            }

            break;

        case 'ComplimentQTY':

            break;

        case 'UCP':
            break;


        case 'MRP':

            break;
        case 'DIS':


            break;
        case 'TAX':


            break;

        case 'InvoiceQty':
            var rowObj = $(ele).parent('td').parent('tr').find('td');

            var poQty = $.trim(rowObj.children('span.POQuantity').html());
            var getRcvdLSUQty = $(rowObj).children('input.RcvdLSUQty');
            var getInverseQty = $.trim($(ele).val());
            var getUnitCostPrice = $.trim($(rowObj).children('input.UCP').val());
            var getUnitPrice = $(rowObj).children('input.UnitPrice');
            var getReceiveQty = $.trim($(rowObj).children('input.RQTY').val());
            if (getReceiveQty == '') {
                getReceiveQty = 0;
            }
            var UnitPrice = 0;

            var totalQty = 0;
            if (poQty == '') {
                poQty = 0;
            }
            if (getInverseQty == '') {
                getInverseQty = 1;
            }
            if (getUnitCostPrice == '') {
                getUnitCostPrice = 0;
            }
            if (getInverseQty <= 0) {
                var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_12") == null ? "Please enter the invoice qty greatter than zero" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_12");
                ValidationWindow(userMsg, errorMsg);
                $(ele).val(0);
            }
            else {
                UnitPrice = parseFloat(parseFloat(getUnitCostPrice) / parseFloat(getInverseQty)).toFixed(2);
            }
            totalQty = parseFloat(parseFloat(getInverseQty) * parseFloat(getReceiveQty)).toFixed(2);
            $(getUnitPrice).val(UnitPrice);
            $(getRcvdLSUQty).val(totalQty);

            break;

        case 'Shortage':
            var rowObj = $(ele).parent('td').parent('tr').find('td');
            var getReceiveQty = $(rowObj).children('input.RQTY');
            var Shortage = $.trim($(rowObj).children('input.Shortage').val());
            var Damage = $.trim($(rowObj).children('input.Damage').val());
            var Rejected = $.trim($(rowObj).children('input.Rejected').val());
            var POQuantity = $.trim($(rowObj).children('span.POQuantity').attr('ASRQty'));
            var _flag = true;
            var setReceiveQty = 0;

            if (Rejected == '') {
                Rejected = 0;
            }
            if (Shortage == '') {
                Shortage = 0;
            }
            if (Damage == '') {
                Damage = 0;
            }

            var deftiveQty = parseFloat(Shortage) + parseFloat(Damage) + parseFloat(Rejected);

            if (deftiveQty > POQuantity) {
                $(rowObj).children('input.Shortage').val(0.00);
            }

            Shortage = $.trim($(rowObj).children('input.Shortage').val());

            if (Shortage == '') {
                Shortage = 0;
            }

            if (Number(POQuantity) > 0 && Number(Shortage) >= 0) {
                setReceiveQty = parseFloat(parseFloat(POQuantity) - parseFloat(parseFloat(Shortage) + parseFloat(Damage) + parseFloat(Rejected))).toFixed(2);
                $(getReceiveQty).val(setReceiveQty);
            }
            if (Number(Shortage) > Number(POQuantity)) {
                setReceiveQty = parseFloat(parseFloat(POQuantity) - parseFloat(Damage) - parseFloat(Rejected)).toFixed(2);
                $(getReceiveQty).val(setReceiveQty);
                $(ele).val(0.00);
            }
            ReCalculateRowTotalCost(ele);

            break;

        case 'Damage':
            var rowObj = $(ele).parent('td').parent('tr').find('td');
            var getReceiveQty = $(rowObj).children('input.RQTY');
            var Shortage = $.trim($(rowObj).children('input.Shortage').val());
            var Damage = $.trim($(rowObj).children('input.Damage').val());
            var Rejected = $.trim($(rowObj).children('input.Rejected').val());
            var POQuantity = $.trim($(rowObj).children('span.POQuantity').attr('ASRQty'));
            var _flag = false;
            var setReceiveQty = 0;

            if (Rejected == '') {
                Rejected = 0;
            }
            if (Shortage == '') {
                Shortage = 0;
            }
            if (Damage == '') {
                Damage = 0;
            }
            var deftiveQty = parseFloat(Shortage) + parseFloat(Damage) + parseFloat(Rejected);

            if (deftiveQty > POQuantity) {
                $(rowObj).children('input.Damage').val(0.00);
            }

            Damage = $.trim($(rowObj).children('input.Damage').val());

            if (Damage == '') {
                Damage = 0;
            }

            if (Number(POQuantity) > 0 && Number(Damage) >= 0) {
                setReceiveQty = parseFloat(parseFloat(POQuantity) - parseFloat(parseFloat(Shortage) + parseFloat(Damage) + parseFloat(Rejected))).toFixed(2);
                $(getReceiveQty).val(setReceiveQty);
            }
            if (Number(Shortage) > Number(POQuantity)) {
                setReceiveQty = parseFloat(parseFloat(POQuantity) - parseFloat(Shortage) - parseFloat(Rejected)).toFixed(2);
                $(getReceiveQty).val(setReceiveQty);
                $(ele).val(0.00);
            }
            ReCalculateRowTotalCost(ele);

            break;

        case 'Rejected':
            var rowObj = $(ele).parent('td').parent('tr').find('td');
            var getReceiveQty = $(rowObj).children('input.RQTY');
            var Shortage = $.trim($(rowObj).children('input.Shortage').val());
            var Damage = $.trim($(rowObj).children('input.Damage').val());
            var Rejected = $.trim($(rowObj).children('input.Rejected').val());
            var POQuantity = $.trim($(rowObj).children('span.POQuantity').attr('ASRQty'));
            var _flag = false;
            var setReceiveQty = 0;

            if (Rejected == '') {
                Rejected = 0;
            }
            if (Shortage == '') {
                Shortage = 0;
            }
            if (Damage == '') {
                Damage = 0;
            }

            var deftiveQty = parseFloat(Shortage) + parseFloat(Damage) + parseFloat(Rejected);

            if (deftiveQty > POQuantity) {
                $(rowObj).children('input.Rejected').val(0.00);
            }

            Rejected = $.trim($(rowObj).children('input.Rejected').val());

            if (Rejected == '') {
                Rejected = 0;
            }
            if (Number(POQuantity) > 0 && Number(Rejected) >= 0) {
                setReceiveQty = parseFloat(parseFloat(POQuantity) - parseFloat(parseFloat(Shortage) + parseFloat(Damage) + parseFloat(Rejected))).toFixed(2);
                $(getReceiveQty).val(setReceiveQty);
            }
            if (Number(Shortage) > Number(POQuantity)) {
                setReceiveQty = parseFloat(parseFloat(POQuantity) - parseFloat(Damage) - parseFloat(Shortage)).toFixed(2);
                $(getReceiveQty).val(setReceiveQty);
                $(ele).val(0.00);
            }
            ReCalculateRowTotalCost(ele);

            break;

        default:
            break;
    }
    if ($('#rbtnMRP').attr('checked')) {
        obj = $('#rbtnMRP');
    }
    else if ($('#rbtnCP').attr('checked')) {
        obj = $('#rbtnCP');
    }

    ChangeCalculation(obj);
    CalculateTotalAmount();
    CalculateTotalTaxAmount();
    CalculateTotalDiscountAmount();
    CalculateSupplierServiceTax('');
    CalculatePODiscount('');
    TaxTypeCalculation();
    CalculateNetTotal();
}


function ReCalculateRowTotalCost(ele) {
    var rowObj = $(ele).parent('td').parent('tr').find('td');
    var qty = $.trim($(rowObj).children('input.RQTY').val());
    var getcostPrice = $.trim($(rowObj).children('input.UCP').val());
    var getTax = $.trim($(rowObj).children('input.TAX').val());
    var getDiscount = $.trim($(rowObj).children('input.DIS').val());
    var getPOQuantity = $.trim($(rowObj).children('span.POQuantity').attr('ASRQty'));
    var getRcvdLSUQty = $(rowObj).children('input.RcvdLSUQty');
    var getInvoiceQty = $(rowObj).children('input.InvoiceQty');
    if (getTax == '') {
        getTax = 0;
    }
    if ($.trim($(getInvoiceQty).val()) == '') {
        $(getInvoiceQty).val(0);
    }
    if (Number(qty) > Number(getPOQuantity)) {
        $(ele).val(getPOQuantity);
    }
    var _RcvdLSUQty = parseFloat(parseFloat(qty) * parseFloat($(getInvoiceQty).val())).toFixed(2);
    $(getRcvdLSUQty).val(_RcvdLSUQty);

    if ($('#hdnFlag').val() == '1') {
        getTax = 0;
    }
    if (getDiscount == '') {
        getDiscount = 0;
    }
    var cost = 0;
    if (getcostPrice != '' && qty != '') {
        cost = Number(getcostPrice) * Number(qty);
    }
    var DisAmt = 0;
    var TaxAmt = 0;
    var Total = 0;

    if (!isNaN(cost) && !isNaN(getDiscount)) {
        DisAmt = parseFloat(parseFloat(parseFloat(cost) / parseFloat(100)) * parseFloat(getDiscount)).toFixed(2);
    }

    if (!isNaN(cost) && !isNaN(getTax)) {
        TaxAmt = parseFloat(parseFloat(parseFloat(cost) / parseFloat(100)) * parseFloat(getTax)).toFixed(2);
    }

    if (!isNaN(cost) && !isNaN(DisAmt) && !isNaN(TaxAmt)) {
        Total = parseFloat((parseFloat(cost) + parseFloat(TaxAmt)) - parseFloat(DisAmt)).toFixed(2);
    }

    $(rowObj).children('input.TP').val(Total);
}

function CalculateTotalAmount() {
    var netValue = 0;
    var crrValue = 0;
    $("#divStockReceived table#tblSRRow tbody tr td").children('input.TP').each(function() {
        if ($(this).val() != '') {
            crrValue = $(this).val();
        }
        netValue = parseFloat(parseFloat(netValue) + parseFloat(crrValue)).toFixed(2);
    });
    $('#txtGrandTotal').val(netValue);
    CalculateRoundOff();
}

function CalculateTotalTaxAmount() {
    var taxAmount = 0;
    var crrValue = 0;
    $("#divStockReceived table#tblSRRow tbody tr.trRow").each(function() {
        var qty = $(this).children('td').children('input.RQTY').val() == '' ? 0 : $(this).children('td').children('input.RQTY').val();
        var price = $(this).children('td').children('input.UCP').val() == '' ? 0 : $(this).children('td').children('input.UCP').val();
        var tax = $(this).children('td').children('input.TAX').val() == '' ? 0 : $(this).children('td').children('input.TAX').val();
        if (tax == '') {
            tax = 0;
        }
        var discount = $(this).children('td').children('input.DIS').val();
        var sum = parseFloat(parseFloat(price) * parseFloat(qty)).toFixed(2);
        var taxAmt = 0;

        //added for comp.qty calculation
        var getComplimentQTY = $(this).children('td').children('input.ComplimentQTY').val() == '' ? 0 : $(this).children('td').children('input.ComplimentQTY').val();
        var MRPprice = $(this).children('td').children('input.MRP').val() == '' ? 0 : $(this).children('td').children('input.MRP').val();


        var sumCP = parseFloat(parseFloat(price) * parseFloat(qty)).toFixed(2);
        var TotalCompQtySP = (parseFloat(getComplimentQTY) * parseFloat(MRPprice)).toFixed(2);
        var CompAmt = parseFloat(parseFloat(price) * parseFloat(getComplimentQTY)).toFixed(2);

        //ends
        if (!isNaN(sum) && !isNaN(discount)) {

            if ($('#rbtnMRP').attr('checked')) {
                var totalSP = 0;
                totalSP = (parseFloat(qty) * parseFloat(MRPprice)).toFixed(2);
                if (parseFloat(100 + parseFloat(tax)) != 0) {
                    taxAmt = parseFloat(parseFloat(parseFloat(totalSP) / parseFloat(100 + parseFloat(tax))) * parseFloat(tax)).toFixed(2);
                }
                else {
                    taxAmt = 0;
                }
            }
            else if ($('#rbtnCP').attr('checked')) {
                taxAmt = parseFloat(parseFloat(parseFloat(sum) / parseFloat(100)) * parseFloat(tax)).toFixed(2);
            }
            var compQtyTax = 0;
            if ($.trim($('#hdnREQCalcCompQTY').val()) == "Y" && $('#rbtnMRP').attr('checked')) {
                compQtyTax = parseFloat(parseFloat(parseFloat(TotalCompQtySP) / parseFloat(100 + parseFloat(tax))) * parseFloat(tax)).toFixed(2);
            }
            else if ($.trim($('#hdnREQCalcCompQTY').val()) == "Y" && $('#rbtnCP').attr('checked')) {
                compQtyTax = parseFloat(parseFloat(parseFloat(CompAmt) / parseFloat(100)) * parseFloat(taxAmt)).toFixed(2);
            }
            else {
                compQtyTax = 0;
            }


            taxAmount = parseFloat(parseFloat(taxAmount) + parseFloat(taxAmt) + parseFloat(compQtyTax)).toFixed(2);



        }

        $('#txtTaxAmt').val(taxAmount);

    });
}

function CalculateTotalDiscountAmount() {
    var discountAmount = 0;
    var crrValue = 0;
    $("#divStockReceived table#tblSRRow tbody tr.trRow").each(function() {
        var qty = $(this).children('td').children('input.RQTY').val() == '' ? 0 : $(this).children('td').children('input.RQTY').val();
        var price = $(this).children('td').children('input.UCP').val() == '' ? 0 : $(this).children('td').children('input.UCP').val();
        var tax = $(this).children('td').children('input.TAX').val() == '' ? 0 : $(this).children('td').children('input.TAX').val();
        if ($('#hdnFlag').val() == '1') {
            tax = 0;
        }
        var discount = $(this).children('td').children('input.DIS').val() == '' ? 0 : $(this).children('td').children('input.DIS').val();
        if (discount == '') {
            discount = 0;
        }
        var DisAmt = 0;
        var sum = parseFloat(parseFloat(price) * parseFloat(qty)).toFixed(2);
        if (!isNaN(sum) && !isNaN(discount)) {
            DisAmt = parseFloat(parseFloat(parseFloat(sum) / parseFloat(100)) * parseFloat(discount)).toFixed(2);
            discountAmount = parseFloat(parseFloat(discountAmount) + parseFloat(DisAmt)).toFixed(2);
        }
        $('#txtDiscountAmt').val(discountAmount);
    });

}


function CalculateSupplierServiceTax(obj) {
    var calTotal = 0;
    var getSSTax = 0;
    var grandTotal = 0;
    if ($('#txtGrandTotal').val() != '') {
        grandTotal = $('#txtGrandTotal').val();
    }
    if ($('#txtTotaltax').val() != '' && Number($('#txtTotaltax').val()) <= 100) {
        getSSTax = $('#txtTotaltax').val();
        getSSTax = parseFloat(parseFloat(parseFloat(grandTotal) / parseFloat(100)) * parseFloat(getSSTax)).toFixed(2);
    }
    else {
        $('#txtTotaltax').val('0.00');
        getSSTax = 0;
    }
    var getPODiscount = 0;
    if ($('#txtTotalDiscount').val() != '') {
        getPODiscount = $('#txtTotalDiscount').val();
    }

    calTotal = parseFloat(parseFloat(parseFloat(grandTotal) - parseFloat(getPODiscount)) + parseFloat(getSSTax)).toFixed(2);
    $('#txtGrandTotal').val(calTotal);
    $('#hdnGrandTotal').val(calTotal);
    if (obj == 'CL') {
        CalculateTotalAmount();
    }
    CalculateNetTotal();
}

function CalculatePODiscount(obj) {
    var calTotal = 0;
    var getSSTax = 0;
    if ($('#txtTotaltax').val() != '') {
        getSSTax = $.trim($('#txtTotaltax').val());
        if (getSSTax == '') {
            getSSTax = 0;
        }
    }
    var grandTotal = 0;
    if ($('#txtGrandTotal').val() != '') {
        grandTotal = $('#txtGrandTotal').val();
    }
    var getPODiscount = 0;
    if ($('#txtTotalDiscount').val() != '') {
        getPODiscount = $('#txtTotalDiscount').val();
    }

    if (Number(getPODiscount) > Number(grandTotal)) {
        getPODiscount = 0;
        $('#txtTotalDiscount').val(0.00);
    }
    getSSTax = parseFloat(parseFloat(parseFloat(grandTotal) / parseFloat(100)) * parseFloat(getSSTax)).toFixed(2);

    calTotal =parseFloat(grandTotal) + parseFloat(getSSTax);
    calTotal = parseFloat(calTotal -(calTotal * parseFloat(getPODiscount) / 100)).toFixed(2);
    $('#txtGrandTotal').val(calTotal);
    $('#hdnGrandTotal').val(calTotal);

    if (obj == 'CL') {
        CalculateTotalAmount();
    }
    CalculateNetTotal();
}


function CalculateRowTotalCost() {
    var errorMsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Alert" : SListForAppMsg.Get("CentralReceiving_Error");
    $("#divStockReceived table#tblSRRow tbody tr.trRow").each(function() {
        var qty = $(this).children('td').children('input.RQTY').val() == '' ? 0 : $(this).children('td').children('input.RQTY').val();
        var price = $(this).children('td').children('input.UCP').val() == '' ? 0 : $(this).children('td').children('input.UCP').val();
        var tax = $(this).children('td').children('input.TAX').val() == '' ? 0 : $(this).children('td').children('input.TAX').val();
        var discount = $(this).children('td').children('input.DIS').val() == '' ? 0 : $(this).children('td').children('input.DIS').val();
        var RcvdLSUQty = $(this).children('td').children('input.RcvdLSUQty').val() == '' ? 0 : $(this).children('td').children('input.RcvdLSUQty').val();
        var validateRnot = $(this).children('td').children('input.TP');
        var inverseQty = $(this).children('td').children('input.InvoiceQty').val() == '' ? 0 : $(this).children('td').children('input.InvoiceQty').val();
        //added for comp.qty
        var getComplimentQTY = $(this).children('td').children('input.ComplimentQTY').val() == '' ? 0 : $(this).children('td').children('input.ComplimentQTY').val();


        RcvdLSUQty = qty * inverseQty;
        $(this).children('td').children('input.RcvdLSUQty').val(RcvdLSUQty);
        var CompAmt = 0;
        if (Number(price) > 0 && Number(inverseQty) > 0) {
            CompAmt = parseFloat(parseFloat(parseFloat(price) / parseFloat(inverseQty)) * parseFloat(getComplimentQTY)).toFixed(2);
        }

        if (price == '') {
            price = 0;
        }
        if (qty == '') {
            qty = 0;
        }

        if (tax == '' || $('#hdnFlag').val() == '1') {
            tax = 0;
        }

        if (discount == '') {
            discount = 0;
        }
        var sum = parseFloat(parseFloat(price) * parseFloat(qty)).toFixed(2);
        var DisAmt = 0;
        if (!isNaN(sum) && !isNaN(discount)) {
            DisAmt = parseFloat(parseFloat(parseFloat(sum) / parseFloat(100)) * parseFloat(discount)).toFixed(2);
        }
        var TaxAmt = 0;
        if (!isNaN(sum) && !isNaN(tax)) {
            TaxAmt = parseFloat(parseFloat(parseFloat(sum) / parseFloat(100)) * parseFloat(tax)).toFixed(2);
        }
        var Total = 0;
        var compQtyTax = 0;
        if (!isNaN(sum) && !isNaN(DisAmt) && !isNaN(TaxAmt)) {
            if ($('#hdnFlag').val() == '0') {
                if ($.trim($('#hdnREQCalcCompQTY').val()) == "Y") {
                    compQtyTax = parseFloat(parseFloat(parseFloat(CompAmt) / parseFloat(100)) * parseFloat(tax)).toFixed(2);
                }
                else {
                    compQtyTax = 0;
                }
                if ((parseFloat(sum) + parseFloat(TaxAmt) + parseFloat(compQtyTax)) < parseFloat(DisAmt)) {
                    $(this).children('td').children('input.DIS').val('0');
                    var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_13") == null ? "Discount amount should not exceed the total amount" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_13");
                    ValidationWindow(userMsg, errorMsg);
                }
                else {
                    Total = parseFloat((parseFloat(sum) + parseFloat(TaxAmt) + parseFloat(compQtyTax)) - parseFloat(DisAmt)).toFixed(2);
                }
            }
            else {
                if ((parseFloat(sum)) < parseFloat(DisAmt)) {
                    $(this).children('td').children('input.DIS').val('0');
                    var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_13") == null ? "Discount amount should not exceed the total amount" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_13");
                    ValidationWindow(userMsg, errorMsg);
                }
                else {
                    Total = parseFloat(parseFloat(sum) - parseFloat(DisAmt)).toFixed(2);
                }
            }
        }

        $(validateRnot).val(Total);
    });
}

function CalculateUnitPrice() {

    $("#divStockReceived table#tblSRRow tbody tr.trRow").each(function() {
        var POQuantity = $.trim($(this).children('td').children('span.POQuantity').html());
        var getUnitCostPrice = $.trim($(this).children('td').children('input.UCP').val());
        var getUnitCostPriceObj = $(this).children('td').children('input.UCP');
        var getInverseQty = $.trim($(this).children('td').children('input.InvoiceQty').val());
        var getRcvdLSUQty = $(this).children('td').children('input.RcvdLSUQty');
        var getUnitPrice = $(this).children('td').children('input.UnitPrice');
        var getTax = $.trim($(this).children('td').children('input.TAX').val());
        var getReceiveQty = $.trim($(this).children('td').children('input.RQTY').val());
        var UnitPrice = 0;

        var totalQty = 0;
        if (POQuantity == '') {
            POQuantity = 0;
        }
        if (getInverseQty == '') {
            getInverseQty = 0;
        }
        if (getUnitCostPrice == '') {
            getUnitCostPrice = 0;
        }
        if (getTax == '') {
            getTax = 0;
        }

        if (getInverseQty <= 0) {
            UnitPrice = 0;
        }
        else {
            if ($('#hdnFlag').val() == '0') {
               UnitPrice = parseFloat(parseFloat(getUnitCostPrice) / parseFloat(1)).toFixed(2);
            }
            else {
                var TaxAmt = parseFloat(parseFloat(parseFloat(getUnitCostPrice) / parseFloat(100)) * parseFloat(getTax)).toFixed(2);
                UnitPrice = parseFloat(parseFloat(parseFloat(getUnitCostPrice) + parseFloat(TaxAmt)) / parseFloat(getInverseQty)).toFixed(2);
            }
        }
        totalQty = parseFloat(parseFloat(getInverseQty) * parseFloat(getReceiveQty)).toFixed(2);
        $(getUnitPrice).val(UnitPrice);
        $(getUnitCostPriceObj).val(UnitPrice);
        $(getRcvdLSUQty).val(totalQty);
    });

}

function AddNewRow(ele) {
    var currentRowObj = $(ele).parent('td').parent('tr');
    var rowObj = $(ele).parent('td').parent('tr').find('td');
    var categoryID = $.trim(rowObj.children('span.ProductName').attr('CategoryID'));
    var productID = $.trim(rowObj.children('span.ProductName').attr('ProductID'));
    if (categoryID != '' && productID != '') {
        $.ajax({
            url: 'GetCategoryRow.aspx?categoryID=' + categoryID + '&productID=' + productID,
            success: function(data) {
                $(currentRowObj).after(data);
                PageLoadScript();
                SetColorFocus();
                ValidateCheckBatchNo();
            }
        });
    }
}

function RemoveRow(ele) {
    $(ele).parent('td').parent('tr').remove();
}

function ValidateCheckBatchNo() {
    var errorMsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Alert" : SListForAppMsg.Get("CentralReceiving_Error");
    $(".BatchNo").bind("keyup", function(event) {

        var _flagBatchNo = 0;
        var _flagManufacture = 0;
        var _flagExpiryDate = 0;
        var _flagproductID = 0;
        var _flagcategoryID = 0;

        var currentBatchNo = $(this);
        var rowObj = $(currentBatchNo).parent('td').parent('tr').find('td');
        var getManufacture = $.trim(rowObj.children('input.Manufacture').val());
        var getExpiryDate = $.trim(rowObj.children('input.ExpiryDate').val());
        var getProductID = rowObj.children('span.ProductName').attr('ProductID');
        var getCategoryID = rowObj.children('span.ProductName').attr('CategoryID');

        $("#divStockReceived table#tblSRRow tbody tr.trRow").each(function() {

            _flagBatchNo = $(this).children('td').children('input.BatchNo');
            _flagManufacture = $(this).children('td').children('input.Manufacture').val();
            _flagExpiryDate = $(this).children('td').children('input.ExpiryDate').val();
            _flagproductID = $(this).children('td').children('span.ProductName').attr('ProductID');
            _flagcategoryID = $(this).children('td').children('span.ProductName').attr('CategoryID');

            if ($(_flagBatchNo).attr('id') != $(currentBatchNo).attr('id')) {

                if (_flagBatchNo != '' && _flagManufacture != '' && _flagExpiryDate != ''
                && _flagproductID != '' && _flagcategoryID != '') {

                    if ($(_flagBatchNo).val() == $(currentBatchNo).val() && _flagManufacture == getManufacture && _flagExpiryDate == getExpiryDate
                && _flagproductID == getProductID && _flagcategoryID == getCategoryID) {
                        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_14") == null ? "This (' + $(currentBatchNo).val() +  BatchNo Cannot Applicable" : SListForAppMsg.Get("CentralReceiving_Scripts_CentralStockReceivedByCategory_js_14");
                        ValidationWindow(userMsg, errorMsg);
                        $(currentBatchNo).val('');
                        return false;
                    }

                }
            }



        });

    });
}

function ChkInverseQty(ele) {
    var rowObj = $(ele).parent('td').parent('tr').find('td');
    var recUnit = $.trim($(rowObj).children('span.RECUnit').html());
    var InvQty = $(rowObj).children('input.InvoiceQty');

    var RecQty = $(rowObj).children('input.RQTY').val() == '' ? 0 : $(rowObj).children('input.RQTY').val();
    var InverseQty = $(rowObj).children('input.InvoiceQty').val() == '' ? 0 : $(rowObj).children('input.InvoiceQty').val();
    var RcvdLSUQty = $(rowObj).children('input.RcvdLSUQty');
    var LSUQty;

    var txt = $(ele).find("option:selected").text();
    if (txt == recUnit) {
        $(InvQty).val(1);
        InverseQty = 1;
        LSUQty = RecQty * InverseQty;
        $(RcvdLSUQty).val(LSUQty);
    }
    else {
        $(InvQty).val(0);
        InverseQty = 0;
        LSUQty = RecQty * InverseQty;
        $(RcvdLSUQty).val(LSUQty);
    }
    //$(RcvdLSUQty).val();
}

//Get QueryString Value
function getParameterByName(name) {
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}

// RoundOff Value
function MakeRoundOff(val) {
    var CurrentVal = val.substring((val.length - 1), (val.length - 2));
    if (CurrentVal < 5) {
        return val.substring(0, (val.length - 2))
    }
    else {
        var returnValue = val.substring(0, (val.length - 2));
        var getCurrentLastVal = val.substring((val.length - 2), (val.length - 3));
        return returnValue.replace(getCurrentLastVal, Number(getCurrentLastVal) + 1);
    }
}

function HideNotification(ele) {
    $('#divNotification').fadeOut(1600, "linear");
}



var PackingSale;
var ExciseDuty;
var EduCess;
var SecCess;
var CST;
function TaxTypeCalculation() {
    NetTotal = $('#txtNetTotal').val();
    PackingSale = $('#txtPackingSale').val();
    ExciseDuty = $('#txtExciseDuty').val();
    EduCess = $('#txtEduCess').val();
    SecCess = $('#txtSecCess').val();
    CST = $('#txtCST').val();
    if ($('#chkPackingSale').attr('checked')) {
        $('#txtPackingSale').val(PackingSaleCalculation(NetTotal, $('#txtPackingSale').attr('Tax')));
    }
    if ($('#chkExciseDuty').attr('checked')) {
        $('#txtExciseDuty').val(ExciseDutyCalculation(NetTotal, PackingSale, $('#txtExciseDuty').attr('Tax')));
        $('#txtEduCess').val(EduAndSecCalculation($('#txtExciseDuty').val(), $('#txtEduCess').attr('Tax')));
        $('#txtSecCess').val(EduAndSecCalculation($('#txtExciseDuty').val(), $('#txtSecCess').attr('Tax')));
        $('#txtCST').val(CSTCalculation(NetTotal, $('#txtPackingSale').val(), $('#txtExciseDuty').val(), $('#txtEduCess').val(), $('#txtSecCess').val(), $('#txtCST').attr('Tax')));
        $('#txtTotal').val(TotalCalculation(NetTotal, $('#txtPackingSale').val(), $('#txtExciseDuty').val(), $('#txtEduCess').val(), $('#txtSecCess').val()));
    }
}


function CalculatePackingSale(ele) {
    if ($(ele).attr('checked')) {
        $('#txtPackingSale').val(PackingSaleCalculation(NetTotal, $('#txtPackingSale').attr('Tax')));
        $('#txtTotal').val(TotalCalculation(NetTotal, $('#txtPackingSale').val(), $('#txtExciseDuty').val(), $('#txtEduCess').val(), $('#txtSecCess').val()));
    }
    else {
        $('#txtPackingSale').val(0.00);
        $('#txtCST').val(0.00);
        $('#txtTotal').val(TotalCalculation(NetTotal, $('#txtPackingSale').val(), $('#txtExciseDuty').val(), $('#txtEduCess').val(), $('#txtSecCess').val()));
    }
}

function CalculateExciseDuty(ele) {
    if ($(ele).attr('checked')) {
        $('#txtExciseDuty').val(ExciseDutyCalculation(NetTotal, $('#txtPackingSale').val(), $('#txtExciseDuty').attr('Tax')));
        $('#txtEduCess').val(EduAndSecCalculation($('#txtExciseDuty').val(), $('#txtEduCess').attr('Tax')));
        $('#txtSecCess').val(EduAndSecCalculation($('#txtExciseDuty').val(), $('#txtSecCess').attr('Tax')));
        $('#txtCST').val(CSTCalculation(NetTotal, $('#txtPackingSale').val(), $('#txtExciseDuty').val(), $('#txtEduCess').val(), $('#txtSecCess').val(), $('#txtCST').attr('Tax')));
        $('#txtTotal').val(TotalCalculation(NetTotal, $('#txtPackingSale').val(), $('#txtExciseDuty').val(), $('#txtEduCess').val(), $('#txtSecCess').val()));
    }
    else {
        $('#txtExciseDuty').val(0.00);
        $('#txtEduCess').val(0.00);
        $('#txtSecCess').val(0.00);
        $('#txtCST').val(0.00);
        $('#txtTotal').val(TotalCalculation(NetTotal, $('#txtPackingSale').val(), $('#txtExciseDuty').val(), $('#txtEduCess').val(), $('#txtSecCess').val()));
    }
}

function PackingSaleCalculation(NetTotal, Percentage) {
    if (Percentage == undefined) {
        Percentage = 0;
    }
    var PackingSale = parseFloat(parseFloat(parseFloat(NetTotal) / parseFloat(100)) * parseFloat(Percentage)).toFixed(2);
    return PackingSale;
}


function ExciseDutyCalculation(NetTotal, PackingSale, Percentage) {
    if (Percentage == undefined) {
        Percentage = 0;
    }
    var Duty = parseFloat(parseFloat(NetTotal) + parseFloat(PackingSale)).toFixed(2);
    var ExciseDuty = parseFloat(parseFloat(parseFloat(Duty) / parseFloat(100)) * parseFloat(Percentage)).toFixed(2);
    return ExciseDuty;
}

function EduAndSecCalculation(ExciseDuty, Percentage) {
    if (Percentage == undefined) {
        Percentage = 0;
    }
    var EduCess = parseFloat(parseFloat(parseFloat(ExciseDuty) / parseFloat(100)) * parseFloat(Percentage)).toFixed(2);
    return EduCess;
}

function CSTCalculation(NetTotal, PackingSale, ExciseDuty, EduCess, SecCess, Percentage) {
    if (Percentage == undefined) {
        Percentage = 0;
    }
    var CSTSum = parseFloat(NetTotal) + parseFloat(PackingSale) + parseFloat(ExciseDuty) + parseFloat(EduCess) + parseFloat(SecCess);
    var CST = parseFloat(parseFloat(parseFloat(CSTSum) / parseFloat(100)) * parseFloat(Percentage)).toFixed(2);
    return CST;
}

function TotalCalculation(NetTotal, PackingSale, ExciseDuty, EduCess, SecCess) {
    var TotalSum = parseFloat(NetTotal) + parseFloat(PackingSale) + parseFloat(ExciseDuty) + parseFloat(EduCess) + parseFloat(SecCess);
    var Total = parseFloat(TotalSum).toFixed(2);
    return Total;
}


function BindTaxTypes(Taxmaster) {
    var objPackSale = SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_01') == null ? "Packing Sale" : SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_01');
    var objExDuty = SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_02') == null ? "Excise Duty" : SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_02');
    var objEdClass = SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_03') == null ? "Edu Cess" : SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_03');
    var objSecClass = SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_04') == null ? "Sec Cess" : SListForAppDisplay.Get('CentralReceiving_Scripts_CentralStockReceivedByCategory_js_04');
    $.each(Taxmaster, function(index, Tax) {
        switch (Tax.TaxName) {
            case "PackingSale":
                $('#trPackingSale').css("visibility", "visible");
                $('#lblPackingSale').html(objPackSale + "(" + Tax.TaxPercent + "%" + ")");
                $('#txtPackingSale').attr("Tax", Tax.TaxPercent);
                break;

            case "ExciseDuty":
                $('#trExciseDuty').css("visibility", "visible");
                $('#lblExciseDuty').html(objExDuty + "(" + Tax.TaxPercent + "%" + ")");
                $('#txtExciseDuty').attr("Tax", Tax.TaxPercent);
                break;

            case "EduCess":
                $('#trEduCess').css("visibility", "visible");
                $('#lblEduCess').html(objEdClass + "(" + Tax.TaxPercent + "%" + ")");
                $('#txtEduCess').attr("Tax", Tax.TaxPercent);
                break;

            case "SecCess":
                $('#trSecCess').css("visibility", "visible");
                $('#lblSecCess').html(objSecClass + "(" + Tax.TaxPercent + "%" + ")");
                $('#txtSecCess').attr("Tax", Tax.TaxPercent);
                break;

            case "CST":
                $('#trTotal').css("visibility", "visible");
                $('#trCST').css("visibility", "visible");
                $('#lblCST').html("CST(" + Tax.TaxPercent + "%" + ")");
                $('#txtCST').attr("Tax", Tax.TaxPercent);
                break;

            default:
                break;
        }
    });
}

function SetNoValiDation() {
    $('.RcvdLSUQty').keypress(function(event) {
        if (event.which < 46 || event.which > 59) {
            event.preventDefault();
        } // prevent if not number/dot

        if (event.which == 46 && $(this).val().indexOf('.') != -1) {
            event.preventDefault();
        } // prevent if already dot
    });

    $('.RQTY').keypress(function(event) {
        if (event.which < 46 || event.which > 59) {
            event.preventDefault();
        } // prevent if not number/dot

        if (event.which == 46 && $(this).val().indexOf('.') != -1) {
            event.preventDefault();
        } // prevent if already dot
    });

    $('.InvoiceQty').keypress(function(event) {
        if (event.which < 46 || event.which > 59) {
            event.preventDefault();
        } // prevent if not number/dot

        if (event.which == 46 && $(this).val().indexOf('.') != -1) {
            event.preventDefault();
        } // prevent if already dot
    });

    $('.TAX').keypress(function(event) {
        if (event.which < 46 || event.which > 59) {
            event.preventDefault();
        } // prevent if not number/dot

        if (event.which == 46 && $(this).val().indexOf('.') != -1) {
            event.preventDefault();
        } // prevent if already dot
    });

    $('.UnitPrice').keypress(function(event) {
        if (event.which < 46 || event.which > 59) {
            event.preventDefault();
        } // prevent if not number/dot

        if (event.which == 46 && $(this).val().indexOf('.') != -1) {
            event.preventDefault();
        } // prevent if already dot
    });

    $('.MRP').keypress(function(event) {
        if (event.which < 46 || event.which > 59) {
            event.preventDefault();
        } // prevent if not number/dot

        if (event.which == 46 && $(this).val().indexOf('.') != -1) {
            event.preventDefault();
        } // prevent if already dot
    });

    $('.ComplimentQTY').keypress(function(event) {
        if (event.which < 46 || event.which > 59) {
            event.preventDefault();
        } // prevent if not number/dot

        if (event.which == 46 && $(this).val().indexOf('.') != -1) {
            event.preventDefault();
        } // prevent if already dot
    });

    $('.DIS').keypress(function(event) {
        if (event.which < 46 || event.which > 59) {
            event.preventDefault();
        } // prevent if not number/dot

        if (event.which == 46 && $(this).val().indexOf('.') != -1) {
            event.preventDefault();
        } // prevent if already dot
    });

    $('.SellingPrice').keypress(function(event) {
        if (event.which < 46 || event.which > 59) {
            event.preventDefault();
        } // prevent if not number/dot

        if (event.which == 46 && $(this).val().indexOf('.') != -1) {
            event.preventDefault();
        } // prevent if already dot
    });

    $('.DefectiveQty').keypress(function(event) {
        if (event.which < 46 || event.which > 59) {
            event.preventDefault();
        } // prevent if not number/dot

        if (event.which == 46 && $(this).val().indexOf('.') != -1) {
            event.preventDefault();
        } // prevent if already dot
    });

    $('.Shortage').keypress(function(event) {
        if (event.which < 46 || event.which > 59) {
            event.preventDefault();
        } // prevent if not number/dot

        if (event.which == 46 && $(this).val().indexOf('.') != -1) {
            event.preventDefault();
        } // prevent if already dot
    });

    $('.Damage').keypress(function(event) {
        if (event.which < 46 || event.which > 59) {
            event.preventDefault();
        } // prevent if not number/dot

        if (event.which == 46 && $(this).val().indexOf('.') != -1) {
            event.preventDefault();
        } // prevent if already dot
    });

    $('.Rejected').keypress(function(event) {
        if (event.which < 46 || event.which > 59) {
            event.preventDefault();
        } // prevent if not number/dot

        if (event.which == 46 && $(this).val().indexOf('.') != -1) {
            event.preventDefault();
        } // prevent if already dot
    });

}


function SetKeypress(event) {
    if (event.which < 46 || event.which > 59) {
        event.preventDefault();
    } // prevent if not number/dot

    if (event.which == 46 && $(this).val().indexOf('.') != -1) {
        event.preventDefault();
    } // prevent if already dot
}
var SupplierServiceTax = 0;
function CalculateNetTotal(ele) {
    var calTotal = 0;
    var getSSTax = 0;
    SupplierServiceTax = 0;

    var netValue = 0;
    var crrValue = 0;
    $("#divStockReceived table#tblSRRow tbody tr td").children('input.TP').each(function() {
        if ($(this).val() != '') {
            crrValue = $(this).val();
        }
        netValue = parseFloat(parseFloat(netValue) + parseFloat(crrValue)).toFixed(2);
    });

    if ($('#txtTotaltax').val() != '') {
        getSSTax = $.trim($('#txtTotaltax').val());
        if (getSSTax == '') {
            getSSTax = 0;
        }
    }

    var getPODiscount = 0;
    if ($('#txtTotalDiscount').val() != '') {
        getPODiscount = $('#txtTotalDiscount').val();
    }
    var DiscountAmount = 0;
    if ($('#txtDiscountAmt').val() != '') {
        //DiscountAmount = $('#txtDiscountAmt').val();
    }
    var TotalTaxAmount = 0;
    if ($('#txtTaxAmt').val() != '') {
        //TotalTaxAmount = $('#txtTaxAmt').val();
    }

    var creditAmount = $.trim($('#txtUseCreditAmount').val());
    if (creditAmount == '') {
        creditAmount = 0;
    }
    var _Dis = 0;
    if (ele == 'CA') {
        _Dis = parseFloat(netValue*getPODiscount/100).toFixed(2);
    }
    else {
        _Dis = parseFloat(parseFloat(netValue * getPODiscount / 100) + parseFloat(creditAmount)).toFixed(2);
    }
    var Amount = parseFloat(parseFloat(netValue).toFixed(6) - parseFloat(netValue * getPODiscount / 100).toFixed(6)).toFixed(2);
    SupplierServiceTax = parseFloat(parseFloat(parseFloat(Amount).toFixed(6) / parseFloat(100)).toFixed(6) * parseFloat(getSSTax).toFixed(6)).toFixed(2);
    var _Tax = parseFloat(SupplierServiceTax).toFixed(2);
    calTotal = parseFloat(parseFloat(parseFloat(netValue) + parseFloat(_Tax)) - parseFloat(_Dis)).toFixed(2);
    $('#txtNetTotal').val(calTotal);
}

function CalculateRoundOff() {
    var netTotal = $.trim($('#txtNetTotal').val());
    if (netTotal == '') {
        netTotal = 0;
    }
    var roundoffAmount = $.trim($('#txtGrandwithRoundof').val());
    if (roundoffAmount == '') {
        roundoffAmount = 0;
    }
    if (Number(roundoffAmount) != 0) {
        if (Number(roundoffAmount) <= Number(netTotal)) {
            roundoffAmount = parseFloat(parseFloat(netTotal) + parseFloat(roundoffAmount)).toFixed(2);
            $('#txtRoundOffValue').val(roundoffAmount);
        }
        else {
            $('#txtGrandwithRoundof').val(netTotal);
            $('#txtRoundOffValue').val(0.00);
        }
    }
    else {
        $('#txtGrandwithRoundof').val(0.00);
        $('#txtRoundOffValue').val(0.00);
    }
}


function ChangeCalculation(ele) {


    switch ($.trim($(ele).val())) {

        case 'CP':
            CalculateRowTotalCost();
            CalculateTotalAmount();
            CalculateNetTotal();
            CalculateTotalTaxAmount();
            break;

        case 'SP':
            CalculateRowTotalCostUsingMRP();
            CalculateTotalAmount();
            CalculateNetTotal();
            CalculateTotalTaxAmount();
            break;

        default:
            break;
    }
}
function ChangeCalculation_load(ele) {


    switch (ele) {
        case 'CP':
            document.getElementById("rbtnCP").checked = true;
            document.getElementById("rbtnCP").click();

            break;

        case 'SP':
            document.getElementById("rbtnMRP").checked = true;
            document.getElementById("rbtnMRP").click();

            break;

        default:
            break;
    }
}



function CalculateRowTotalCostUsingMRP() {
    $("#divStockReceived table#tblSRRow tbody tr.trRow").each(function() {
        var qty = $(this).children('td').children('input.RQTY').val() == '' ? 0 : $(this).children('td').children('input.RQTY').val();
        var MRPprice = $(this).children('td').children('input.MRP').val() == '' ? 0 : $(this).children('td').children('input.MRP').val();
        var tax = $(this).children('td').children('input.TAX').val() == '' ? 0 : $(this).children('td').children('input.TAX').val();
        var discount = $(this).children('td').children('input.DIS').val() == '' ? 0 : $(this).children('td').children('input.DIS').val();
        var validateRnot = $(this).children('td').children('input.TP');
        var getUnitCostPrice = $(this).children('td').children('input.UCP').val() == '' ? 0 : $(this).children('td').children('input.UCP').val();
        var inverseQty = $(this).children('td').children('input.InvoiceQty').val() == '' ? 0 : $(this).children('td').children('input.InvoiceQty').val();

        var getComplimentQTY = $(this).children('td').children('input.ComplimentQTY').val() == '' ? 0 : $(this).children('td').children('input.ComplimentQTY').val();

        var price = $(this).children('td').children('input.UCP').val();
        var sumCP = parseFloat(parseFloat(price) * parseFloat(qty)).toFixed(2);
        var TotalCompQtySP = 0;
        if (Number(MRPprice) > 0 && Number(inverseQty) > 0) {
            TotalCompQtySP = parseFloat(parseFloat(parseFloat(MRPprice) / parseFloat(inverseQty)) * parseFloat(getComplimentQTY)).toFixed(2);
        }

        if ($.trim(getUnitCostPrice) == '') {
            getUnitCostPrice = 0;
        }


        if (MRPprice == '') {
            MRPprice = 0;
        }
        if (qty == '') {
            qty = 0;
        }

        if (tax == '' || $('#hdnFlag').val() == '1') {
            tax = 0;
        }

        if (discount == '') {
            discount = 0;
        }

        /** MRP  Calculation Formula (quantity*MRP*Tax/100+Tax)+CP*Qnty=Net Amount **/

        var sum = parseFloat(parseFloat(MRPprice) * parseFloat(qty)).toFixed(2);
        var DisAmt = 0;
        if (!isNaN(sum) && !isNaN(discount)) {
            DisAmt = parseFloat(parseFloat(parseFloat(sumCP) / parseFloat(100)) * parseFloat(discount)).toFixed(2);
        }

        sumCP = parseFloat(parseFloat(sumCP) - parseFloat(DisAmt)).toFixed(2);
        var TaxAmt = 0;
        if (!isNaN(tax)) {
            TaxAmt = parseFloat(tax).toFixed(2);
        }

        var Total = 0;
        var CompQtymrp = 0;
        if (!isNaN(sum) && !isNaN(DisAmt) && !isNaN(TaxAmt)) {
            if ($('#hdnFlag').val() == '0') {
                TaxAmt = parseFloat(parseFloat(parseFloat(sum) / parseFloat(100 + parseFloat(TaxAmt))) * parseFloat(TaxAmt)).toFixed(2);
                if ($.trim($('#hdnREQCalcCompQTY').val()) == "Y") {
                    CompQtymrp = parseFloat(parseFloat(parseFloat(TotalCompQtySP) / parseFloat(100 + parseFloat(tax))) * parseFloat(tax)).toFixed(2);
                }
                else {
                    CompQtymrp = 0;
                }
                Total = (parseFloat(TaxAmt) + parseFloat(sumCP) + parseFloat(CompQtymrp)).toFixed(2);
            }
            else {
                Total = parseFloat(parseFloat(sum) - parseFloat(DisAmt)).toFixed(2);
            }
        }

        $(validateRnot).val(Total);
    });
}




