var lstProductList = [];
function CheckProdDetails() {
    if (!CheckProductList()) {
        var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_01") == null ? "Provide the product list" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_01");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtProduct').focus();
        return false;
    }
}
function CheckProductList() {
    var restTrue = true;
    if (document.getElementById("hdnProductList").value.length < 1) {
        restTrue = false;
    }
    return restTrue;

}
/*
function IAmSelected(source, eventArgs) {
    if (document.getElementById('txtProduct').value.trim() == '') {
        while (count = document.getElementById('tbllist').rows.length) {
            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }
    }
    document.getElementById('hdnBatchList').value = '';
    document.getElementById('hdnProductId').value = '';
    var lis = eventArgs.get_value().split('^');
    var pMainX = document.getElementById('hdnProductList').value.split("^");
    var isTrue = true;
    for (i = 0; i < lis.length; i++) {
        if (lis[i] != "") {
            var isTrue = true;
            for (xY = 0; xY < pMainX.length; xY++) {
                if (pMainX[xY] != "") {
                    xTempP = pMainX[xY].split('~');
                    if (lis[i].split('|')[1].split('~')[2] == xTempP[0] && lis[i].split('|')[0] == xTempP[6]) {
                        isTrue = false;
                        break;
                    }
                }
            }

            if (isTrue) {
                document.getElementById('hdnBatchList').value += lis[i].split('|')[1] + '^';
                document.getElementById('hdnProductId').value = lis[i].split('|')[0];
            }
        }

    }

    var pid = document.getElementById('hdnProductId').value;
    document.getElementById('hdnProBatchNo').value = '';
    document.getElementById('txtQuantity').value = '';
    document.getElementById('txtBatchQuantity').value = '';
    document.getElementById('txtUnit').value = '';
    document.getElementById('txtBatchNo').value = '';
    document.getElementById('hdnReceivedID').value = 0;
    document.getElementById('txtBatchNo').disabled = false;
    var x = document.getElementById('hdnBatchList').value.split('^');
    var isAddItem = 0;
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');
            if (CheckTaskItems(pid + "~" + y[0] + "~" + y[2])) {
                document.getElementById('hdnProBatchNo').value += y[0] + "@#$" + y[2] + "|";
                document.getElementById('divProductDetails').style.display = 'block';
                if (lis.length > 1) {
                    if (isAddItem == 0) {
                        document.getElementById('hdnReceivedID').value = y[2];
                        BindQuantity();
                        isAddItem = 1;
                    }
                }
            }

        }

}
AutoCompBacthNo();
ProductItemSelected(source, eventArgs);
} */

function ProductItemSelected(sender, args) {


    var ProductCategory = document.forms[0][sender.get_element().name].value; //$("#" + sender.get_element().name).val(); //document.getElementById(sender.get_element().name).value;  //
    var Product = '';
    var result = '';

    if (ProductCategory == '' || ProductCategory == undefined) {

        Product = ProductCategory;
        document.forms[0][sender.get_element().name].value = Product;

    }
    else {

        result = ProductCategory.match(/[^[\]]+(?=])/g)
        if (result != null) {
            Product = ProductCategory.replace(/\s*\[.*?\]\s*/g, '');
            document.forms[0][sender.get_element().name].value = Product;
            // $('#' + sender.get_element().name).val(Product);
        }
        else {

            Product = ProductCategory;
            document.forms[0][sender.get_element().name].value = Product;

        }
    }
}
function CheckTaskItems(obj) {
    var x1 = document.getElementById("hdnAddedTaskList").value.split("^");
    for (j = 0; j < x1.length; j++) {
        if (x1[j] != "") {
            if (x1[j] == obj) {
                return false
            }
        }
    }
    return true;
}


function pSetFocus(obj) {
    var lis = document.getElementById('hdnBatchList').value.split('^');
    if (lis.length > 2) {
        document.getElementById('txtBatchNo').focus();
    }
}

function KeyPress1(e) {

    var ddlaction = document.getElementById('ddlUser');
    var userMsg = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_10") == null ? "Select" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_10");
    if (ddlaction.options[ddlaction.selectedIndex].text == userMsg) {
        var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_02") == null ? "Select The Issued Location And  Received By" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_02");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
}


function pSetAddFocus() {
    var qty = document.getElementById('txtQuantity').value.trim();
}

/*
function BindQuantity() {
    var blnExists = false;
    if (document.getElementById('hdnReceivedID').value > 0) {
        var BatchNoList = document.getElementById('hdnBatchList').value.split("^");
        for (i = 0; i < BatchNoList.length; i++) {
            if (BatchNoList[i] != "") {
                var val = BatchNoList[i].split("~");
                if (val[2].trim() == (document.getElementById('hdnReceivedID').value.trim())) {
                    document.getElementById('txtBatchNo').value = val[0];
                    document.getElementById('hdnProductName').value = val[1];
                    document.getElementById('hdnReceivedID').value = val[2];
                    document.getElementById('txtBatchQuantity').value = val[3];
                    document.getElementById('txtUnit').value = val[4];
                    document.getElementById('hdnSellingPrice').value = val[5];
                    document.getElementById('hdnTax').value = val[6];
                    document.getElementById('hdnExpiryDate').value = val[8];
                    document.getElementById('hdnHasExpiryDate').value = val[13];
                    document.getElementById('hdnUnitPrice').value = val[14];
                    // document.getElementById('txtQuantity').focus();
                   
                    document.getElementById('txtreturnstock').value = val[19];
                    if (val[19] < 1) {
                        $('#tdreturnstock').hide();
                        $('#tdlblreturnstock').hide();
                    }
                    else {
                        $('#tdreturnstock').show();
                        $('#tdlblreturnstock').show();
                    }


                    ToTargetFormat($("#txtBatchQuantity"));
                    ToTargetFormat($("#hdnSellingPrice"));
                    ToTargetFormat($("#hdnTax"));
                    ToTargetFormat($("#hdnUnitPrice"));
                    
                    var pCell = document.getElementById('hdnReceivedID').value;

                    for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                        document.getElementById('tbllist').rows[j].style.backgroundColor = "";
                        if ("tr_par" + pCell == document.getElementById('tbllist').rows[j].id) {
                            document.getElementById('tbllist').rows[j].style.backgroundColor = '#DCFC5C';
                        }

                    }
                    blnExists = true; break;
                }
            }
        }
    }
    if (blnExists == false) {
        document.getElementById('txtUnit').value = '';
        document.getElementById('txtBatchQuantity').value = '';
        document.getElementById('txtBatchNo').value = '';
        return false;
    }
}
function checkIsEmpty() {
    if (document.getElementById('txtBatchNo').value.trim() == "") {
        var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_03") == null ? "Provide the batch number" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_03");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtBatchNo').focus();
        return false;
    }

    if (document.getElementById('txtQuantity').value == "") {
        var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_04") == null ? "Provide issue quantity" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_04");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }
    //if (Number(document.getElementById('txtBatchQuantity').value) < Number(document.getElementById('txtQuantity').value)) {
    if (Number(ToInternalFormat($('#txtBatchQuantity'))) < Number(ToInternalFormat($('#txtQuantity')))) {
        var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_05") == null ? "Ensure the items added/quantity are provided properly" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_05");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }

    //if (Number(document.getElementById('txtQuantity').value) < 1) {
    if (Number(ToInternalFormat($('#txtQuantity'))) < 1) {
        var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_05") == null ? "Ensure the items added/quantity are provided properly" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_05");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }
    
    var remqty = document.getElementById('txtBatchQuantity').value - document.getElementById('txtreturnstock').value;
    var qty = document.getElementById('txtreturnstock').value;
    if (Number(document.getElementById('txtreturnstock').value) > (Number(document.getElementById('txtBatchQuantity').value) - Number(document.getElementById('txtQuantity').value))) {
        var usermsg1 = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_20") == null ? "This product have return sub store stock" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_20");
        var usermsg2 = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_21") == null ? "You can use remaining stock" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_21");
        var userMsg = usermsg1 + qty + usermsg2 + remqty + '.00';
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').value = "";
        document.getElementById('txtQuantity').focus();
        return false;
    }
    
    var Updatebtn = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_01") == null ? "Update" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_01");
    if (document.getElementById('add').value != Updatebtn) {
        var x = document.getElementById('hdnProductList').value.split("^");
        var pId = document.getElementById('hdnReceivedID').value;
        var pName = document.getElementById('hdnProductName').value;

        var y; var i;
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
                if (y[0] == pId) {
                    var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_06") == null ? "Product number and batch number combination already exist" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_06");
 ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtProduct').value = '';
                    document.getElementById('txtProduct').focus();
                    return false;
                }
            }
        }
    }
    BindProductList();
    return false;
}

function BindProductList() {
    var Updatebtn = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_01") == null ? "Update" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_01");
    if (document.getElementById('add').value == Updatebtn) {
        Deleterows();
    }
    else {

        var pId = document.getElementById('hdnReceivedID').value;
        var pName = document.getElementById('hdnProductName').value;
        var pProductId = document.getElementById('hdnProductId').value;
        //var pQTY = document.getElementById('txtBatchQuantity').value;
        var pQTY = ToInternalFormat($('#txtBatchQuantity'));
        var pBatchNo = document.getElementById('txtBatchNo').value;
        //var pQuantity = document.getElementById('txtQuantity').value;
        var pQuantity = ToInternalFormat($('#txtQuantity'));
        var pUnit = document.getElementById('txtUnit').value;
        //var pSellingPrice = document.getElementById('hdnSellingPrice').value;
        var pSellingPrice = ToInternalFormat($('#hdnSellingPrice'));
        //var pTax = document.getElementById('hdnTax').value;
        var pTax = ToInternalFormat($('#hdnTax'));
        var pExp = document.getElementById('hdnExpiryDate').value;
        var pProBatchNo = document.getElementById('hdnProBatchNo').value;
        var pHasExpiryDate = document.getElementById('hdnHasExpiryDate').value;
        //var pUnitPrice = document.getElementById('hdnUnitPrice').value;
        var pUnitPrice = ToInternalFormat($('#hdnUnitPrice'));
        if (pHasExpiryDate == "Y") {
            var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
            if (expirylevel != '' && expirylevel != null) {
                if (expirylevel > 0) {
                    var isExpired = findExpiryItem(pExp, expirylevel);
                    if (isExpired == 2) {
                    var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
                    var informMsg = SListForAppMsg.Get('StockOutFlow_Information') == null ? "Information" : SListForAppMsg.Get('StockOutFlow_Information');
                    var okMsg = SListForAppMsg.Get('StockOutFlow_Ok') == null ? "Ok" : SListForAppMsg.Get('StockOutFlow_Ok')
                    var cancelMsg = SListForAppMsg.Get('StockOutFlow_Cancel') == null ? "Cancel" : SListForAppMsg.Get('StockOutFlow_Cancel');

                    var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_12") == null ? "This Item Will be Expired with in {0} Months. Do you want to continue!Click 'OK'" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_12");
                        userMsg = userMsg.replace("{0}", expirylevel);
                        var Replay = ConfirmWindow(userMsg,informMsg,okMsg,cancelMsg);
                        if (Replay == true) {
                        }
                        else {
                            document.getElementById('txtProduct').value = "";
                            document.getElementById('divProductDetails').style.display = 'none';
                            while (count = document.getElementById('tbllist').rows.length) {

                                for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                                    document.getElementById('tbllist').deleteRow(j);
                                }
                            }
                            return false;
                        }
                    }
                }
            }
        }

        document.getElementById('hdnProductList').value += pId + "~" + pName + "~" +
                        pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" +
                        pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" + pProBatchNo + "~" + pHasExpiryDate + "~" + pUnitPrice + "^";
        Tblist();
        document.getElementById('txtQuantity').value = '';
        document.getElementById('txtUnit').value = '';

    }
    var Addbtn = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_02") == null ? "Add" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_02");
    document.getElementById('add').value = Addbtn;
    document.getElementById('txtProduct').value = '';
    while (count = document.getElementById('tbllist').rows.length) {

        for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
            document.getElementById('tbllist').deleteRow(j);
        }
    }
}
function Tblist() {
    while (count = document.getElementById('tblOrederedItems').rows.length) {

        for (var j = 0; j < document.getElementById('tblOrederedItems').rows.length; j++) {
            document.getElementById('tblOrederedItems').deleteRow(j);
        }
    }


    var Headrow = document.getElementById('tblOrederedItems').insertRow(0);
    Headrow.id = "HeadID";
    Headrow.className = "gridHeader"
    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    var cell5 = Headrow.insertCell(4);
    var cell6 = Headrow.insertCell(5);
    var cell7 = Headrow.insertCell(6);

    var ProductName = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_03") == null ? "Product Name" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_03");
    var BatchNo = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_04") == null ? "Batch No" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_04");
    var IssuedQty = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_05") == null ? "Issued Qty" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_05");
    var Unit = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_06") == null ? "Unit" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_06");
    var SellingPrice = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_07") == null ? "Selling Price" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_07");
    var Amount = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_08") == null ? "Amount" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_08");
    var Action = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_09") == null ? "Action" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_09");

    cell1.innerHTML = ProductName;
    cell2.innerHTML = BatchNo;
    cell3.innerHTML = IssuedQty;
    cell4.innerHTML = Unit;
    cell5.innerHTML = SellingPrice;
    cell6.innerHTML = Amount;
    cell7.innerHTML = Action;

    var x = document.getElementById('hdnProductList').value.split("^");
    if (document.getElementById('lblNonMedicalAmt') != null)
        document.getElementById('lblNonMedicalAmt').innerHTML = "0.00";
    var tGrandTotal = 0.00;
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');

            var row = document.getElementById('tblOrederedItems').insertRow(1);
            row.style.height = "13px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);


            cell1.innerHTML = y[1];
            cell2.innerHTML = y[2];
            cell3.innerHTML = SetNumberFormat(y[3]);
            cell4.innerHTML = y[4];
            cell5.innerHTML = SetNumberFormat(y[7]);
            cell6.innerHTML = SetNumberFormat(parseFloat(y[3] * y[7]).toFixed(2));
            tGrandTotal = parseFloat(parseFloat(tGrandTotal) + parseFloat(y[3] * y[7])).toFixed(2);
            var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
            if (y[11] == "Y") {
                if (expirylevel != '' && expirylevel != null) {
                    if (expirylevel > 0) {
                        var isExpired = findExpiryItem(y[9], expirylevel);
                        if (isExpired == 2) {
                            row.style.backgroundColor = "Orange";
                        }
                    }
                }
            }
            cell7.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "' onclick='btnEdit_OnClick(name);' value = '' type='button' class='ui-icon ui-icon-pencil pull-left'  /> " +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "' onclick='btnDelete(name);' value = '' type='button' class='ui-icon ui-icon-trash pull-left' />"
        }
    }
    document.getElementById('hdnProBatchNo').value = '';
    document.getElementById('txtBatchNo').value = '';
    document.getElementById('txtBatchQuantity').value = '';
    document.getElementById('hdnBatchList').value = '';
    document.getElementById('hdnHasExpiryDate').value = '';
    document.getElementById('divProductDetails').style.display = 'none';
    document.getElementById('txtProduct').focus();
    document.getElementById('hdnProductName').value = '';
    document.getElementById('txtBatchNo').disabled = false;

}  */

var monthdiff = 0;
function findExpiryItem(Expiredate, ConfigExpiryDateLevel) {
    var today = new Date();

    pdate1 = new Date(Expiredate);
    monthdiff = monthDiff(today, pdate1);
    if (monthdiff >= 0) {
        if (monthdiff > ConfigExpiryDateLevel) {
        }
        else {
            return 2;
        }
    }
}

function monthDiff(d1, d2) {
    var months;
    months = (d2.getFullYear() - d1.getFullYear()) * 12;
    months -= d1.getMonth();
    months += d2.getMonth();
    return months;
}

/*
function Deleterows() {

    var RowEdit = document.getElementById('hdnRowEdit').value;
    var x = document.getElementById('hdnProductList').value.split("^");
    if (RowEdit != "") {
        var pId = document.getElementById('hdnReceivedID').value;
        var pProductId = document.getElementById('hdnProductId').value;
        var pName = document.getElementById('hdnProductName').value;
        var pQTY = ToInternalFormat($('#txtBatchQuantity'));
        var pBatchNo = document.getElementById('txtBatchNo').value;
        var pQuantity = ToInternalFormat($('#txtQuantity'));
        var pUnit = document.getElementById('txtUnit').value;
        var pSellingPrice = ToInternalFormat($('#hdnSellingPrice'));
        var pTax = ToInternalFormat($('#hdnTax'));
        var pExp = document.getElementById('hdnExpiryDate').value;
        var pProBatchNo = document.getElementById('hdnProBatchNo').value;
        var pHasExpiryDate = document.getElementById('hdnHasExpiryDate').value;
        var pUnitPrice = ToInternalFormat($('#hdnUnitPrice'));
        document.getElementById('hdnProductList').value = pId + "~" + pName + "~" +
                            pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" +
                            pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" + pProBatchNo + "~" + pHasExpiryDate + "~" + pUnitPrice + "^";


        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                if (x[i] != RowEdit) {
                    document.getElementById('hdnProductList').value += x[i] + "^";
                }
            }
        }
        Tblist();
        document.getElementById('txtQuantity').value = '';
        document.getElementById('txtUnit').value = '';
    }
}

function btnEdit_OnClick(sEditedData) {

    var y = sEditedData.split('~');

    document.getElementById('hdnReceivedID').value = y[0];
    document.getElementById('hdnProductName').value = y[1];
    document.getElementById('txtProduct').value = y[1];
    document.getElementById('txtBatchNo').disabled = true;
    document.getElementById('txtBatchNo').value = y[2];
    document.getElementById('txtQuantity').value = y[3];
    document.getElementById('txtUnit').value = y[4];
    document.getElementById('txtBatchQuantity').value = y[5];
    document.getElementById('hdnProductId').value = y[6];
    document.getElementById('hdnRowEdit').value = sEditedData;
    document.getElementById('add').value = 'Update';
    document.getElementById('divProductDetails').style.display = 'block';
    document.getElementById('hdnSellingPrice').value = y[7];
    document.getElementById('hdnTax').value = y[8];
    document.getElementById('hdnExpiryDate').value = y[9];
    document.getElementById('hdnProBatchNo').value = y[10];
    document.getElementById('hdnHasExpiryDate').value = y[11];
    document.getElementById('hdnUnitPrice').value = y[12];

    AutoCompBacthNo();
}

function btnDelete(sEditedData) {

    var i;
    var x = document.getElementById('hdnProductList').value.split("^");
    document.getElementById('hdnProductList').value = '';
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            if (x[i] != sEditedData) {
                document.getElementById('hdnProductList').value += x[i] + "^";
            }
        }
    }
    Tblist();

//        
} */

///////////////Auto/////////
function AutoCompBacthNo() {
    var customarray = document.getElementById('hdnProBatchNo').value.split("|");
    actb(document.getElementById('txtBatchNo'), customarray);
}
//////////////////////////////////



function checkDetails(objFile) {
    if (objFile == "StockIssued") {
        if (document.getElementById('ddlLocation').value == '0') {
            var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_07") == null ? "Select the issue to location" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_07");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddlLocation').focus();
            return false;
        }
        if (document.getElementById('ddlUser').value == '0') {
            var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_08") == null ? "Select the received by" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_08");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddlUser').focus();
            return false;
        }
        document.getElementById('btnSubmit').style.display = "none";
    }
    if (objFile == "StockDamage") {
        if (document.getElementById('txtStockDamageDate').value == '') {
            var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_09") == null ? "Select stock damage date" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_09");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('btnSubmit').style.display = "block";
            document.getElementById('txtStockDamageDate').focus();
            return false;
        }

        if (document.getElementById('INVStockUsage1_hdnProductList').value == '') {
            var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_10") == null ? "Select the product" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_10");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('btnSubmit').style.display = "block";
            document.getElementById('INVStockUsage1_txtProduct').focus();
            return false;
        }

        document.getElementById('btnReturnStock').style.display = "none";


    }

    var x = document.getElementById("hdnTasklist").value.split("^");
    document.getElementById("hdnTaskCollectedItems").value = '';
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            var tProID = x[i];
            var T_select = document.getElementById("T_select" + tProID).checked;
            var T_Bacth = document.getElementById("T_Bacth" + tProID).value;
            //var T_IssQty = document.getElementById("T_IssQty" + tProID).value;
            var T_IssQty = ToInternalFormat($("#T_IssQty" + tProID));
            var T_ProList = document.getElementById("T_ProList" + tProID).value;
            if (T_select) {
                var T_temp = T_ProList.split('^');
                for (j = 0; j < T_temp.length; j++) {
                    if (T_temp[j] != "") {
                        y = T_temp[j].split('~');
                        if (T_Bacth.trim().toUpperCase() == y[1].trim().toUpperCase()) {
                            if (T_IssQty > 0) {
                                document.getElementById("hdnTaskCollectedItems").value += T_temp[j] + "~" + T_IssQty + "^"
                            }
                            else {
                                var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_11") == null ? "Ensure items added/quantity are provided properly" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_11");
 ValidationWindow(userMsg, errorMsg);
                                document.getElementById("T_IssQty" + tProID).focus();
                                return false;
                            }
                        }
                    }
                }
            }
        }
    }
    if (document.getElementById('hdnProductList').value == '') {
        var lst = document.getElementById("hdnTaskCollectedItems").value.split('^');
        if (lst == "") {
            var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_10") == null ? "Select the product" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_10");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('btnSubmit').style.display = "block";
            document.getElementById('txtProduct').focus();
            return false;
        }
    }

    if (lstProductList.length > 0) {

        var arrF = $.grep(lstProductList, function(n, i) {
            return n.ExpiryDate = (new Date(parseInt(n.ExpiryDate.substr(6)))).format("dd/MM/yyyy");
        });
        $('#hdnProductList').val(JSON.stringify(lstProductList));
    }



    return true;
}

function openPOPup(url) {
    PaymentControlclear();

    ClearOtherCurrValues("OtherCurrencyDisplay1");
    SetReceivedOtherCurr(0, 0, "OtherCurrencyDisplay1");

    if (typeof unCheckDepositUsage == 'function') {
        unCheckDepositUsage();
        document.getElementById('txtAmountRecieved').value = 0;
    }
    document.getElementById("hdnprint").click();
    document.getElementById('PaymentType_ddlPaymentType').value = 1;
}
function DuePupupClear() {
    PaymentControlclear();
    ClearOtherCurrValues("OtherCurrencyDisplay1");
    document.getElementById('PaymentType_ddlPaymentType').value = 1;
}

function TaskItemAutoComplet(objBatch, txtBacth, listItems) {

    var x = document.getElementById(listItems).value.split("^");
    //var Taskcustomarray = document.getElementById(objBatch).value.split("|");
    var Tasklist = "";
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');
            if (checkAddedItems(y[0] + "~" + y[1] + "~" + y[7])) {
                Tasklist += y[1] + "|";
            }

        }
    }
    var Taskcustomarray = Tasklist.split("|");
    actb(document.getElementById(txtBacth), Taskcustomarray);
}
/*
function checkAddedItems(obj) {
    var x = document.getElementById("hdnProductList").value.split("^");
    for (j = 0; j < x.length; j++) {
        if (x[j] != "") {
            y1 = x[j].split('~');
            if (y1[6] + "~" + y1[2] + "~" + y1[0] == obj) {
                return false
            }
        }
    }
    return true;
}
*/
function TaskItemCalculation(tProductList, tBacth) {
    var tProID = 0;
    var tIssQty = 0;
    var tAmount = 0;
    var tbacNo = document.getElementById(tBacth).value;
    var x = document.getElementById(tProductList).value.split('^');
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~'); tProID = y[0];
            var tcheck = document.getElementById("T_select" + tProID).checked;
            if (tcheck) {
                if (tbacNo.trim().toUpperCase() == y[1].trim().toUpperCase()) {

                    //tIssQty = document.getElementById("T_IssQty" + tProID).value;
                    tIssQty = ToInternalFormat($("#T_IssQty" + tProID));
                    if (Number(y[2]) < Number(tIssQty)) {
                        var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_11") == null ? "Ensure items added/quantity are provided properly" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_11");
 ValidationWindow(userMsg, errorMsg);
                        document.getElementById("T_IssQty" + tProID).focus();
                        document.getElementById("T_IssQty" + tProID).value = '';
                        return false;
                    }
                    if (document.getElementById("T_IssQty" + tProID).value == "") {
                        tIssQty = document.getElementById("T_IssQty" + tProID).value = 0;
                    }
                    document.getElementById("T_Amount" + tProID).value = parseFloat(parseFloat(tIssQty) * parseFloat(y[4])).toFixed(2);
                    ToTargetFormat($("#T_Amount" + tProID));
                    CalcTaskListItem();
                }
            }

        }
    }
}
function SetEmptyValue(obj) {
    if (document.getElementById(obj).value == "0") {
        document.getElementById(obj).focus();
        document.getElementById(obj).value = '';
    }
}
function TaskCheckItemList(tProductList, tBacth) {
    var x = document.getElementById(tProductList).value.split('^');
    var tbacNo = document.getElementById(tBacth).value;
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');
            tProID = y[0];
            var tcheck = document.getElementById("T_select" + tProID).checked;
            if (tcheck) {
                if (tbacNo.trim().toUpperCase() == y[1].trim().toUpperCase()) {
                    TaskAddedListItem(y[0] + "~" + y[1] + "~" + y[7], "Added");
                    document.getElementById("T_Bacth" + tProID).value = y[1];
                    document.getElementById("T_AblQty" + tProID).value = y[2];
                    document.getElementById("T_IssQty" + tProID).disabled = false;
                    document.getElementById("T_Bacth" + tProID).disabled = false;
                    document.getElementById("T_Unit" + tProID).value = y[3];
                    document.getElementById("T_SellPrice" + tProID).value = y[4];
                    document.getElementById("T_Amount" + tProID).value = '0.00'
                    document.getElementById("T_IssQty" + tProID).value = '';
                    document.getElementById("T_IssQty" + tProID).focus();
                    ToTargetFormat($("#T_Amount" + tProID));
                    ToTargetFormat($("#T_IssQty" + tProID));
                    ToTargetFormat($("#T_AblQty" + tProID));
                    ToTargetFormat($("#T_SellPrice" + tProID));
                    break;
                }
                else {
                    document.getElementById("T_AblQty" + tProID).value = '0.00'
                    document.getElementById("T_IssQty" + tProID).value = '0'
                    document.getElementById("T_IssQty" + tProID).disabled = true;
                    document.getElementById("T_Unit" + tProID).value = '--'
                    document.getElementById("T_SellPrice" + tProID).value = '0.00'
                    document.getElementById("T_Amount" + tProID).value = '0.00'
                    TaskAddedListItem(y[0] + "~" + y[1] + "~" + y[7], "Delete");
                }


            }
        }
    }
}

function IsCheckItemList(tProductList, tcheck) {
    var x = document.getElementById(tProductList).value.split('^');
    var tcheck = document.getElementById(tcheck).checked;

    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');
            tProID = y[0];
            if (tcheck) {
                if (checkAddedItems(y[0] + "~" + y[1] + "~" + y[7])) {
                    document.getElementById("T_Bacth" + tProID).value = y[1];
                    document.getElementById("T_AblQty" + tProID).value = y[2];
                    document.getElementById("T_IssQty" + tProID).disabled = false;
                    document.getElementById("T_Bacth" + tProID).disabled = false;
                    document.getElementById("T_Unit" + tProID).value = y[3];
                    document.getElementById("T_SellPrice" + tProID).value = y[4];
                    document.getElementById("T_Amount" + tProID).value = '0.00'
                    document.getElementById("T_IssQty" + tProID).value = '';
                    document.getElementById("T_IssQty" + tProID).focus();
                    ToTargetFormat($("#T_Amount" + tProID));
                    ToTargetFormat($("#T_IssQty" + tProID));
                    ToTargetFormat($("#T_AblQty" + tProID));
                    ToTargetFormat($("#T_SellPrice" + tProID));
                    TaskAddedListItem(y[0] + "~" + y[1] + "~" + y[7], "Added"); break;
                    
                    
                }


            } else {
                document.getElementById("T_Bacth" + tProID).value = '--'
                document.getElementById("T_Bacth" + tProID).disabled = true;
                document.getElementById("T_AblQty" + tProID).value = '0.00'
                document.getElementById("T_IssQty" + tProID).value = '0'
                document.getElementById("T_IssQty" + tProID).disabled = true;
                document.getElementById("T_Unit" + tProID).value = '--'
                document.getElementById("T_SellPrice" + tProID).value = '0.00'
                document.getElementById("T_Amount" + tProID).value = '0.00'
                TaskAddedListItem(y[0] + "~" + y[1] + "~" + y[7], "Delete");
                CalcTaskListItem();
                break;
            }
        }
    }
}
function TaskAddedListItem(list, tType) {
    var x1 = document.getElementById("hdnAddedTaskList").value.split("^");
    document.getElementById("hdnAddedTaskList").value = '';
    if (tType == "Delete") {
        for (j = 0; j < x1.length; j++) {
            if (x1[j] != "") {
                if (x1[j] != list) {
                    document.getElementById("hdnAddedTaskList").value = x1[j] + "^";
                }
            }
        }
    }
    if (tType == "Added") {
        document.getElementById("hdnAddedTaskList").value += list + "^";
    }
}

function CalcTaskListItem() {
    var x = document.getElementById("hdnTasklist").value.split("^");
    var temp = 0.00;
    var vat = 0.00;
    var t_tempamt = 0.00;
    var t_vatamt = 0.00;
    document.getElementById("hdnTaskCollectedItems").value = '';
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            var tProID = x[i];
            var T_select = document.getElementById("T_select" + tProID).checked;
            var T_Bacth = document.getElementById("T_Bacth" + tProID).value;
            // var T_IssQty = document.getElementById("T_IssQty" + tProID).value;
            var T_IssQty = ToInternalFormat($("#T_IssQty" + tProID));
            var T_ProList = document.getElementById("T_ProList" + tProID).value;
            if (T_select && T_IssQty > 0) {
                document.getElementById("hdnTaskCollectedItems").value = T_ProList + ""
                var T_temp = T_ProList.split('^');
                for (j = 0; j < T_temp.length; j++) {
                    if (T_temp[j] != "") {
                        y = T_temp[j].split('~');
                        if (T_Bacth.trim().toUpperCase() == y[1].trim().toUpperCase()) {
                            document.getElementById("hdnTaskCollectedItems").value += T_temp[j] + "~" + T_IssQty + "^"
                            temp = parseFloat(parseFloat(y[4] * T_IssQty)).toFixed(2);
                            vat = parseFloat(parseFloat(temp) * parseFloat(y[5]) / 100).toFixed(2);
                            t_tempamt = parseFloat(parseFloat(t_tempamt) + parseFloat(temp)).toFixed(2);
                            t_vatamt = parseFloat(parseFloat(t_vatamt) + parseFloat(vat)).toFixed(2);
                        }
                    }
                }
            }
        }
    }
    var subT = parseFloat(parseFloat(t_tempamt) - parseFloat(t_vatamt)).toFixed(2);
    var vatT = parseFloat(t_vatamt).toFixed(2);
    var grossT = parseFloat(t_tempamt).toFixed(2);
    document.getElementById('hdnTaskAmount').value = subT + "~" + vatT + "~" + grossT;

}
function SetNumberFormat(Decimalvalue) {
    $('#hdnDisplaydata').val(Decimalvalue);
    ToTargetFormat($('#hdnDisplaydata'));
    return $('#hdnDisplaydata').val();
}
/*-----------------------JSON-----------------------------------*/

function IAmSelected(source, eventArgs) {
    document.getElementById('hdnBatchList').value = '';
    document.getElementById('hdnProductId').value = '';
    var lstArray = JSON.parse(eventArgs.get_value());
    var lis = lstArray[0];
    var isTrue = true;
    var arrF = new Object();
    var arrX = [];
    arrY = [];
    $.each(lstArray, function (obj, value) {
        arrF = $.grep(lstProductList, function (n, i) {
            return n.ID == value.StockInHandID
        });
        if (arrF.length > 0) {
            $.merge(arrY, arrF)
        }
    });

    if (arrY.length > 0) {
        if (arrY.length == lstArray.length) {
            alert("Product already Added");
            return false;
        }
        var pid = Enumerable.From(lstArray).Select("$.ReceivedUniqueNumber").ToArray();
        var npid = Enumerable.From(arrY).Select("$.ReceivedUniqueNumber").ToArray();
        var rpid = [];
        jQuery.grep(pid, function (el) {
            if (jQuery.inArray(el.toString(), npid) == -1)
                rpid.push(el);
        });
        arrX = Enumerable.From(lstArray).Where(function(x) { return Enumerable.From(rpid).Contains(x.ReceivedUniqueNumber) }).ToArray();
    }
    else {
        arrX = lstArray;
    }
    document.getElementById('hdnBatchList').value = JSON.stringify(arrX);
        document.getElementById('hdnProductId').value = lis.ProductID;
    
    var pid = document.getElementById('hdnProductId').value;
    document.getElementById('hdnProBatchNo').value = '';
    document.getElementById('txtQuantity').value = '';
    document.getElementById('txtBatchQuantity').value = '';
    document.getElementById('txtUnit').value = '';
    document.getElementById('txtBatchNo').value = '';
    document.getElementById('hdnReceivedID').value = 0;
    document.getElementById('txtBatchNo').disabled = false;
    if ($('#hdnBatchList').val() != '') {
        var x = JSON.parse($('#hdnBatchList').val());
        var isAddItem = 0;
        $.each(x, function(obj, value) {
            if (CheckTaskItems(pid + "~" + value.BatchNo + "~" + value.StockInHandID)) {
                document.getElementById('hdnProBatchNo').value += value.BatchNo + "@#$" + value.StockInHandID + "|";
                $('#divProductDetails').removeClass().addClass('show');
                if (lstArray.length > 0) {
                    if (isAddItem == 0) {
                        document.getElementById('hdnReceivedID').value = value.StockInHandID;
                        BindQuantity();
                        isAddItem = 1;
                    }
                }
            }
        });
    }

    AutoCompBacthNo();
    ProductItemSelected(source, eventArgs);
}

function BindQuantity() {
    var blnExists = false;
    var BatchNoList = [];
    if ($('#hdnBatchList').val() != '') {
        BatchNoList = JSON.parse($('#hdnBatchList').val());
    };
    if (document.getElementById('hdnReceivedID').value > 0) {
        var lsttempArrary = $.grep(BatchNoList, function(n, i) {
            return n.StockInHandID == document.getElementById('hdnReceivedID').value.trim();
        });
        if (lsttempArrary.length > 0) {
            var tempobject = lsttempArrary[0];
            document.getElementById('txtBatchNo').value = tempobject.BatchNo;
            document.getElementById('hdnProductName').value = tempobject.Name;
            document.getElementById('hdnReceivedID').value = tempobject.StockInHandID;
            document.getElementById('txtBatchQuantity').value = tempobject.InHandQuantity;
            document.getElementById('txtUnit').value = tempobject.SellingUnit;
            document.getElementById('hdnSellingPrice').value = tempobject.SellingPrice;
            document.getElementById('hdnTax').value = tempobject.Tax;
            document.getElementById('hdnExpiryDate').value = tempobject.ExpiryDate;
            document.getElementById('hdnHasExpiryDate').value = tempobject.HasExpiryDate;
            document.getElementById('hdnUnitPrice').value = tempobject.UnitPrice;
            document.getElementById('txtreturnstock').value = tempobject.SubstoreReturnqty;
            $('#hdnPdtRcvdDtlsID').val(tempobject.ProductReceivedDetailsID);
            $('#hdnReceivedUniqueNumber').val(tempobject.ReceivedUniqueNumber);
            $('#hdnStockReceivedBarcodeDetailsID').val(tempobject.StockReceivedBarcodeDetailsID);
            $('#hdnBarcodeNo').val(tempobject.BarcodeNo);
            
            if (tempobject.SubstoreReturnqty < 1) {
                $('#tdreturnstock').hide();
                $('#tdlblreturnstock').hide();
            }
            else {
                $('#tdreturnstock').show();
                $('#tdlblreturnstock').show();
            }
            ToTargetFormat($("#txtBatchQuantity"));
            ToTargetFormat($("#hdnSellingPrice"));
            ToTargetFormat($("#hdnTax"));
            ToTargetFormat($("#hdnUnitPrice"));
            var pCell = document.getElementById('hdnReceivedID').value;
            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').rows[j].style.backgroundColor = "";
                if ("tr_par" + pCell == document.getElementById('tbllist').rows[j].id) {
                    document.getElementById('tbllist').rows[j].style.backgroundColor = '#DCFC5C';
                }
            }
            blnExists = true;
        }
    }
    if (blnExists == false) {
        document.getElementById('txtUnit').value = '';
        document.getElementById('txtBatchQuantity').value = '';
        document.getElementById('txtBatchNo').value = '';
        return false;
    }
}

function checkIsEmpty() {
    if (document.getElementById('txtBatchNo').value.trim() == "") {
        var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
        var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_03") == null ? "Provide the batch number" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_03");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtBatchNo').focus();
        return false;
    }

    if (document.getElementById('txtQuantity').value == "") {
        var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
        var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_04") == null ? "Provide issue quantity" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_04");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }
    if (Number(ToInternalFormat($('#txtBatchQuantity'))) < Number(ToInternalFormat($('#txtQuantity')))) {
        var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
        var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_05") == null ? "Ensure the items added/quantity are provided properly" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_05");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }
    if (Number(ToInternalFormat($('#txtQuantity'))) < 1) {
        var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
        var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_05") == null ? "Ensure the items added/quantity are provided properly" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_05");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }
    var remqty = Number(ToInternalFormat($('#txtBatchQuantity'))) - Number(ToInternalFormat($('#txtreturnstock'))); //document.getElementById('txtBatchQuantity').value - document.getElementById('txtreturnstock').value;
    var qty = Number(ToInternalFormat($('#txtreturnstock')));

    if (Number(ToInternalFormat($('#txtreturnstock'))) > (Number(ToInternalFormat($('#txtBatchQuantity'))) - Number(ToInternalFormat($('#txtQuantity'))))) {
        var usermsg1 = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_20") == null ? "This product have return sub store stock" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_20");
        var usermsg2 = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_21") == null ? "You can use remaining stock" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_21");
        var userMsg = usermsg1 + qty + usermsg2 + remqty + '.00';
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').value = "";
        document.getElementById('txtQuantity').focus();
        return false;
    }

    var Updatebtn = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_01") == null ? "Update" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_01");
    if (document.getElementById('add').value != Updatebtn) {
        var pId = document.getElementById('hdnReceivedID').value;
        var pName = document.getElementById('hdnProductName').value;
        var arrF = $.grep(lstProductList, function(n, i) {
          return n.ID == pId;
        });
        if (arrF.length > 0) {
            var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
            var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_06") == null ? "Product number and batch number combination already exist" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_06");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtProduct').value = '';
            document.getElementById('txtProduct').focus();
            return false;
        }
    }
    BindProductList();
    return false;
}

function BindProductList() {
    var Updatebtn = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_01") == null ? "Update" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_01");
    if (document.getElementById('add').value == Updatebtn) {
        var editData = JSON.parse($('#hdnRowEdit').val());
        if (editData != "") {
            var arrF = $.grep(lstProductList, function(n, i) {
                return n.ID != editData.ID;
            });
            lstProductList = [];
            lstProductList = arrF;
        }

    }
    var pId = document.getElementById('hdnReceivedID').value;
    var pName = document.getElementById('hdnProductName').value;
    var pProductId = document.getElementById('hdnProductId').value;
    var pQTY = ToInternalFormat($('#txtBatchQuantity'));
    var pBatchNo = document.getElementById('txtBatchNo').value;
    var pQuantity = ToInternalFormat($('#txtQuantity'));
    var pUnit = document.getElementById('txtUnit').value;
    var pSellingPrice = ToInternalFormat($('#hdnSellingPrice'));
    var pTax = ToInternalFormat($('#hdnTax'));
    var pExp = document.getElementById('hdnExpiryDate').value;
    var pProBatchNo = document.getElementById('hdnProBatchNo').value;
    var pHasExpiryDate = document.getElementById('hdnHasExpiryDate').value;
    var pUnitPrice = ToInternalFormat($('#hdnUnitPrice'));
    var pStockReceivedBarcodeDetailsID = $("#hdnStockReceivedBarcodeDetailsID").val();
    var phdnBarcodeNo = $("#hdnBarcodeNo").val();
    var remarks = $('#txtRemarks').val();
    
    if (pHasExpiryDate == "Y") {
        var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
        if (expirylevel != '' && expirylevel != null) {
            if (expirylevel > 0) {
                var isExpired = findExpiryItem(pExp, expirylevel);
                if (isExpired == 2) {
                    var errorMsg = SListForAppMsg.Get('StockOutFlow_Error') == null ? "Error" : SListForAppMsg.Get('StockOutFlow_Error');
                    var informMsg = SListForAppMsg.Get('StockOutFlow_Information') == null ? "Information" : SListForAppMsg.Get('StockOutFlow_Information');
                    var okMsg = SListForAppMsg.Get('StockOutFlow_Ok') == null ? "Ok" : SListForAppMsg.Get('StockOutFlow_Ok')
                    var cancelMsg = SListForAppMsg.Get('StockOutFlow_Cancel') == null ? "Cancel" : SListForAppMsg.Get('StockOutFlow_Cancel');

                    var userMsg = SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_12") == null ? "This Item Will be Expired with in {0} Months. Do you want to continue!Click 'OK'" : SListForAppMsg.Get("StockOutFlow_Scripts_StockUsage_js_12");
                    userMsg = userMsg.replace("{0}", expirylevel);
                    var Replay = ConfirmWindow(userMsg, informMsg, okMsg, cancelMsg);
                    if (Replay == true) {
                    }
                    else {
                        $('#divProductDetails').removeClass().addClass('hide');
                        $('#tbllist tr').remove();
                        document.getElementById('txtProduct').value = "";
                        return false;
                    }
                }
            }
        }
    }
    var objProduct = new Object();
    objProduct.ID = pId;    
    objProduct.ProductName = pName;
    objProduct.BatchNo = pBatchNo;
    objProduct.Quantity = pQuantity;
    objProduct.Unit = pUnit;
    objProduct.ComplimentQTY = pQTY;
    objProduct.ProductID = pProductId;
    objProduct.Rate = pSellingPrice;
    objProduct.Tax = parseFloat(pTax);
    objProduct.ExpiryDate = new Date(parseInt(pExp.substr(6)));
    objProduct.HasBatchNo = pProBatchNo;
    objProduct.HasExpiryDate = pHasExpiryDate;
    objProduct.UnitPrice = parseFloat(pUnitPrice);
    objProduct.ProductReceivedDetailsID = $('#hdnPdtRcvdDtlsID').val();
    objProduct.ReceivedUniqueNumber = $('#hdnReceivedUniqueNumber').val();
    objProduct.StockReceivedBarcodeDetailsID = pStockReceivedBarcodeDetailsID;
    objProduct.BarcodeNo = phdnBarcodeNo;
    objProduct.Remarks = remarks;
    
    lstProductList.push(objProduct);
    $('#hdnProductList').val(JSON.stringify(lstProductList));
    Tblist();
    document.getElementById('txtQuantity').value = '';
    document.getElementById('txtUnit').value = '';

    var Addbtn = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_02") == null ? "Add" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_02");
    document.getElementById('add').value = Addbtn;
    document.getElementById('txtProduct').value = '';
    $('#tbllist tr').remove();
}

function Tblist() {
    $("#tblOrederedItems tr").remove();
    var Headrow = document.getElementById('tblOrederedItems').insertRow(0);
    Headrow.id = "HeadID";
    Headrow.className = "responstableHeader  w-100p"
    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    var cell5 = Headrow.insertCell(4);
    var cell6 = Headrow.insertCell(5);
    var cell7 = Headrow.insertCell(6);
    var cell8 = Headrow.insertCell(7);
    var cell9 = Headrow.insertCell(8);
    var cell10 = Headrow.insertCell(9);

    var ProductName = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_03") == null ? "Product Name" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_03");
    var BatchNo = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_04") == null ? "Batch No" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_04");
    //var IssuedQty = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_05") == null ? "Issued Qty" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_05");
    var OpeningQty = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_10") == null ? "Opening Balance" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_10");  
    var IssuedQty = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_11") == null ? "Usage Quantity" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_11"); 
    var ClosingQty = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_12") == null ? "Closing Balance" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_13");  
    var Remarks = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_13") == null ? "Remarks" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_09");  
    var Unit = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_06") == null ? "Unit" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_06");
    var SellingPrice = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_07") == null ? "Selling Price" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_07");
    var Amount = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_08") == null ? "Amount" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_08");
    var Action = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_09") == null ? "Action" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_09");

    cell1.innerHTML = ProductName;
    cell2.innerHTML = BatchNo;
    //cell3.innerHTML = IssuedQty;
    cell3.innerHTML = OpeningQty;
    cell4.innerHTML = IssuedQty;
    cell5.innerHTML = ClosingQty;
    cell6.innerHTML = Unit;
    cell7.innerHTML = SellingPrice;
    cell8.innerHTML = Amount;
    cell9.innerHTML = Remarks;
    cell9.className = "w-20p";
    cell10.innerHTML = Action;

    if (document.getElementById('lblNonMedicalAmt') != null)
        document.getElementById('lblNonMedicalAmt').innerHTML = "0.00";
    var tGrandTotal = 0.00;
    var StockInHandID = 0;
    $.each(lstProductList, function(obj, value) {
        var row = document.getElementById('tblOrederedItems').insertRow(1);
        row.style.height = "13px";
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

        var objProduct = new Object();
        
        cell1.innerHTML = value.ProductName;
        cell2.innerHTML = value.BatchNo;
        //cell3.innerHTML = SetNumberFormat(value.Quantity);
        cell3.innerHTML = value.ComplimentQTY;
        //cell4.innerHTML = value.Unit;
        cell4.innerHTML = SetNumberFormat(value.Quantity);
        //cell5.innerHTML = SetNumberFormat(value.Rate);
        cell5.innerHTML = value.ComplimentQTY - SetNumberFormat(value.Quantity);
        //cell6.innerHTML = SetNumberFormat(parseFloat(value.Quantity * value.Rate).toFixed(2));
        cell6.innerHTML = value.Unit;
        cell7.innerHTML = SetNumberFormat(value.Rate);
        cell8.innerHTML = SetNumberFormat(parseFloat(value.Quantity * value.Rate).toFixed(2));
        cell9.innerHTML = value.Remarks;
        tGrandTotal = parseFloat(parseFloat(tGrandTotal) + parseFloat(value.Quantity * value.Rate)).toFixed(2);
        if (value.HasExpiryDate == "Y") {
            var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
            if (expirylevel != '' && expirylevel != null) {
                if (expirylevel > 0) {
                    var isExpired = findExpiryItem(value.ExpiryDate, expirylevel);
                    if (isExpired == 2) {
                        row.style.cssText = 'background-color: Orange !important';
                    }
                }
            }
        }
        cell10.innerHTML = "<input name='Edit' onclick='btnEdit_OnClick(" + JSON.stringify(value) + ");' value = '' type='button' class='ui-icon ui-icon-pencil pull-left'  /> " +
                        "<input name='Delete' onclick='btnDelete(" + JSON.stringify(value) + ");' value = '' type='button' class='ui-icon ui-icon-trash pull-left' />" + "<a class='pointer' onclick='showpopup(" + value.ID + ");'>Audit Log</a>"
    });
    document.getElementById('hdnProBatchNo').value = '';
    document.getElementById('txtBatchNo').value = '';
    document.getElementById('txtBatchQuantity').value = '';
    document.getElementById('hdnBatchList').value = '';
    document.getElementById('hdnHasExpiryDate').value = '';
    $('#divProductDetails').removeClass().addClass('hide');
    document.getElementById('txtProduct').focus();
    document.getElementById('hdnProductName').value = '';
    document.getElementById('txtBatchNo').disabled = false;
    $("#hdnStockReceivedBarcodeDetailsID").val('0');
    $("#hdnBarcodeNo").val('');
    $('#txtRemarks').val('');
}

function btnEdit_OnClick(sEditedData) {
    $('#divProductDetails').removeClass().addClass('show');
    document.getElementById('hdnRowEdit').value = JSON.stringify(sEditedData);
    document.getElementById('add').value = 'Update';
    document.getElementById('hdnReceivedID').value = sEditedData.ID;
    document.getElementById('hdnProductName').value = sEditedData.ProductName;
    document.getElementById('txtProduct').value = sEditedData.ProductName;
    document.getElementById('txtBatchNo').disabled = true;
    document.getElementById('txtBatchNo').value = sEditedData.BatchNo;
    document.getElementById('txtRemarks').value = sEditedData.Remarks;
    document.getElementById('txtQuantity').value = sEditedData.Quantity;
    document.getElementById('txtUnit').value = sEditedData.Unit;
    document.getElementById('txtBatchQuantity').value = sEditedData.ComplimentQTY;
    document.getElementById('hdnProductId').value = sEditedData.ProductID;
    document.getElementById('hdnSellingPrice').value = sEditedData.Rate;
    document.getElementById('hdnTax').value = sEditedData.Tax;
    document.getElementById('hdnExpiryDate').value = sEditedData.ExpiryDate;
    document.getElementById('hdnProBatchNo').value = sEditedData.HasBatchNo;
    document.getElementById('hdnHasExpiryDate').value = sEditedData.HasExpiryDate;
    document.getElementById('hdnUnitPrice').value = sEditedData.UnitPrice;
    $('#hdnPdtRcvdDtlsID').val(sEditedData.ProductReceivedDetailsID);
    $('#hdnReceivedUniqueNumber').val(sEditedData.ReceivedUniqueNumber);
    AutoCompBacthNo();
}

function btnDelete(sEditedData) {
    var arrF = $.grep(lstProductList, function(n, i) {
        return n.ID != sEditedData.ID;
    });
    lstProductList = [];
    lstProductList = arrF;
    $('#hdnProductList').val(JSON.stringify(lstProductList));

    Tblist();


}





function checkAddedItems(obj) {
    var arrF = $.grep(lstProductList, function(n, i) {
        return n.ProductID + "~" + n.BatchNo + "~" + n.ID == obj;
    });
    if (arrF.length > 0) {
        return false
    }
    return true;
}

function NumericOnly(event) {
    var regex = new RegExp("^[0-9\]+$");
    var key = String.fromCharCode(event.charCode ? event.which : event.charCode);
    if (!regex.test(key)) {
        event.preventDefault();
        return false;
    }
}
function SetFrequency() {
    if ($find('AutoCompleteProduct') != null) {
        if ($("label[for='" + $("#rblStockTakingFrequency").find(":checked").attr('id') + "']").text() != "" && $("label[for='" + $("#rblStockTakingFrequency").find(":checked").attr('id') + "']").text() != "None") {
            $find('AutoCompleteProduct').set_contextKey($("label[for='" + $("#rblStockTakingFrequency").find(":checked").attr('id') + "']").text());
        }
        else {
            $find('AutoCompleteProduct').set_contextKey("");
        }
    }
}
function showpopup(id) {
    $('#Bck-black').show();
    $('#Blockslot').show();

    return $.ajax({
        type: "POST",
        url: '../InventoryCommon/WebService/InventoryWebService.asmx/GetStockUsageandUpdateAudit',
        contentType: "application/json",
        data: '{StockInHandID: "' + id + '" }',
        dataType: "json",
        success: function(result) {
            if (result.d.length > 0) {
                BindProductAudit(result.d);
            }
        }
    });
}
function Closeclick() {
    $('#Bck-black').hide();
    $('#Blockslot').hide();
}
function BindProductAudit(lstAudit) {
    $("#auditlog tr").remove();
    var Headrow = document.getElementById('auditlog').insertRow(0);
    Headrow.id = "HeadID";
    Headrow.className = "responstableHeader  w-100p"
    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    var cell5 = Headrow.insertCell(4);
    var cell6 = Headrow.insertCell(5);
    var cell7 = Headrow.insertCell(6);
    var cell8 = Headrow.insertCell(7);
    var cell9 = Headrow.insertCell(8);    

    var ProductName = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_03") == null ? "Product Name" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_03");
    var DateTime = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_14") == null ? "Stock Usage Date Time" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_14");  
    var BatchNo = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_04") == null ? "Batch No" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_04");
    var ExpiryDate = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_15") == null ? "Expiry Date" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_15");  
    var OpeningQty = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_10") == null ? "Opening Balance" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_10");
    var IssuedQty = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_11") == null ? "Usage Quantity" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_11");
    var ClosingQty = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_12") == null ? "Closing Balance" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_13");
    var OnBehalfOf = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_16") == null ? "Entered By" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_16");
    var Remarks = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_13") == null ? "Remarks" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_09");  
    
    cell1.innerHTML = ProductName;
    cell2.innerHTML = BatchNo;
    cell3.innerHTML = ExpiryDate;
    cell4.innerHTML = DateTime;
    cell5.innerHTML = OpeningQty;
    cell6.innerHTML = IssuedQty;
    cell7.innerHTML = ClosingQty;
    cell8.innerHTML = OnBehalfOf;
    cell9.innerHTML = Remarks;
    
    var arrE = $.grep(lstAudit, function(n, i) {
        return n.ExpiryDate = (new Date(parseInt(n.ExpiryDate.substr(6)))).format("dd/MM/yyyy");
    });
    var arrD = $.grep(lstAudit, function(n, i) {
        return n.StockReceivedDate = (new Date(parseInt(n.StockReceivedDate.substr(6)))).format("dd/MM/yyyy HH:mm:ss");
    });
    $.each(lstAudit, function(obj, value) {
        var row = document.getElementById('auditlog').insertRow(1);
        row.style.height = "13px";
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var cell5 = row.insertCell(4);
        var cell6 = row.insertCell(5);
        var cell7 = row.insertCell(6);
        var cell8 = row.insertCell(7);
        var cell9 = row.insertCell(8);
        
        cell1.innerHTML = value.ProductName;
        cell2.innerHTML = value.BatchNo;
        cell3.innerHTML = value.ExpiryDate;
        cell4.innerHTML = value.StockReceivedDate;
        cell5.innerHTML = value.ComplimentQTY;
        cell6.innerHTML = value.Quantity;
        cell7.innerHTML = value.InHandQuantity;
        cell8.innerHTML = value.Name;
        cell9.innerHTML = "<textarea rows='5' cols='10' readonly>" + value.Remarks + "</textarea>";
    });
}