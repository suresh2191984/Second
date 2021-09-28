function CheckProdDetails() {
    if (!CheckProductList()) {
        alert('Provide the product list');
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
    if (ddlaction.options[ddlaction.selectedIndex].text == '--Select--') {
        alert('Select The Issued Location And  Received By');
        return false;
    }
}


function pSetAddFocus() {
    var qty = document.getElementById('txtQuantity').value.trim();
}


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
        alert('Provide the batch number');
        document.getElementById('txtBatchNo').focus();
        return false;
    }

    if (document.getElementById('txtQuantity').value == "") {
        alert('Provide issue quantity');
        document.getElementById('txtQuantity').focus();
        return false;
    }
    if (Number(document.getElementById('txtBatchQuantity').value) < Number(document.getElementById('txtQuantity').value)) {
        alert('Ensure the items added/quantity are provided properly');
        document.getElementById('txtQuantity').focus();
        return false;
    }

    if (Number(document.getElementById('txtQuantity').value) < 1) {
        alert('Ensure the items added/quantity are provided properly');
        document.getElementById('txtQuantity').focus();
        return false;
    }

    if (document.getElementById('add').value != 'Update') {
        var x = document.getElementById('hdnProductList').value.split("^");
        var pId = document.getElementById('hdnReceivedID').value;
        var pName = document.getElementById('hdnProductName').value;

        var y; var i;
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
                if (y[0] == pId) {
                    alert('Product number and batch number combination already exist');
                    document.getElementById('txtProduct').value = '';
                    document.getElementById('txtProduct').focus();
                    return false;
                }
            }
        }
    }
    return true;
}

function BindProductList() {

    if (document.getElementById('add').value == 'Update') {
        Deleterows();
    }
    else {

        var pId = document.getElementById('hdnReceivedID').value;
        var pName = document.getElementById('hdnProductName').value;
        var pProductId = document.getElementById('hdnProductId').value;
        var pQTY = document.getElementById('txtBatchQuantity').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        var pQuantity = document.getElementById('txtQuantity').value;
        var pUnit = document.getElementById('txtUnit').value;
        var pSellingPrice = document.getElementById('hdnSellingPrice').value;
        var pTax = document.getElementById('hdnTax').value;
        var pExp = document.getElementById('hdnExpiryDate').value;
        var pProBatchNo = document.getElementById('hdnProBatchNo').value;
        var pHasExpiryDate = document.getElementById('hdnHasExpiryDate').value;
        var pUnitPrice = document.getElementById('hdnUnitPrice').value;
        if (pHasExpiryDate == "Y") {
            var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
            if (expirylevel != '' && expirylevel != null) {
                if (expirylevel > 0) {
                    var isExpired = findExpiryItem(pExp, expirylevel);
                    if (isExpired == 2) {
                        var Replay = confirm("This Item Will be Expired with in " + expirylevel + " Months. Do you want to continue!Click 'OK'");
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
    document.getElementById('add').value = 'Add';
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
    //    Headrow.style.backgroundColor = "#2c88b1";
    Headrow.style.fontWeight = "bold";
    //    Headrow.style.color = "#FFFFFF";
    Headrow.className = "dataheader1"
    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    var cell5 = Headrow.insertCell(4);
    var cell6 = Headrow.insertCell(5);
    var cell7 = Headrow.insertCell(6);


    cell1.innerHTML = "Product Name";
    cell2.innerHTML = "Batch No";
    cell3.innerHTML = "Issued Qty";
    cell4.innerHTML = "Unit";
    cell5.innerHTML = "Selling Price";
    cell6.innerHTML = "Amount";
    cell7.innerHTML = "Action";

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
            cell3.innerHTML = y[3];
            cell4.innerHTML = y[4];
            cell5.innerHTML = y[7];
            cell6.innerHTML = parseFloat(y[3] * y[7]).toFixed(2);
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
            cell7.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
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

}

function findExpiryItem(Expiredate, ConfigExpiryDateLevel) {
    var today = new Date();
    var Expdate = new Date(Expiredate);

    var monthdiff = monthDiff(today, Expdate);
    if (monthdiff >= 0) {
        if (monthdiff > ConfigExpiryDateLevel) {
        }
        else {
            return 2; //Expired with in ConfigExpiryDateLevel
        }
    }
    //        else {
    //            return 1; //Alredy Expired
    //        }
}
function monthDiff(d1, d2) {
    var months;
    months = (d2.getFullYear() - d1.getFullYear()) * 12;
    months -= d1.getMonth();
    months += d2.getMonth();
    return months;
}

function Deleterows() {

    var RowEdit = document.getElementById('hdnRowEdit').value;
    var x = document.getElementById('hdnProductList').value.split("^");
    if (RowEdit != "") {
        var pId = document.getElementById('hdnReceivedID').value;
        var pProductId = document.getElementById('hdnProductId').value;
        var pName = document.getElementById('hdnProductName').value;
        var pQTY = document.getElementById('txtBatchQuantity').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        var pQuantity = document.getElementById('txtQuantity').value;
        var pUnit = document.getElementById('txtUnit').value;
        var pSellingPrice = document.getElementById('hdnSellingPrice').value;
        var pTax = document.getElementById('hdnTax').value;
        var pExp = document.getElementById('hdnExpiryDate').value;
        var pProBatchNo = document.getElementById('hdnProBatchNo').value;
        var pHasExpiryDate = document.getElementById('hdnHasExpiryDate').value;
        var pUnitPrice = document.getElementById('hdnUnitPrice').value;
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
}

///////////////Auto/////////
function AutoCompBacthNo() {
    var customarray = document.getElementById('hdnProBatchNo').value.split("|");
    actb(document.getElementById('txtBatchNo'), customarray);
}
//////////////////////////////////



function checkDetails(objFile) {
    if (objFile == "StockIssued") {
        if (document.getElementById('ddlLocation').value == '0') {
            alert('Select the issue to location ');
            document.getElementById('ddlLocation').focus();
            return false;
        }
        if (document.getElementById('ddlUser').value == '0') {
            alert('Select the received by ');
            document.getElementById('ddlUser').focus();
            return false;
        }
        document.getElementById('btnSubmit').style.display = "none";
    }
    if (objFile == "StockDamage") {
        if (document.getElementById('txtStockDamageDate').value == '') {
            alert('Select stock damage date');
            document.getElementById('txtStockDamageDate').focus();
            return false;
        }

        if (document.getElementById('INVStockUsage1_hdnProductList').value == '') {
            alert('Select the product');
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
            var T_IssQty = document.getElementById("T_IssQty" + tProID).value;
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
                                alert('Ensure items added/quantity are provided properly');
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
            alert('Select the product');
            document.getElementById('txtProduct').focus();
            return false;
        }
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

                    tIssQty = document.getElementById("T_IssQty" + tProID).value;
                    if (Number(y[2]) < Number(tIssQty)) {
                        alert('Ensure items added/quantity are provided properly');
                        document.getElementById("T_IssQty" + tProID).focus();
                        document.getElementById("T_IssQty" + tProID).value = '';
                        return false;
                    }
                    if (document.getElementById("T_IssQty" + tProID).value == "") {
                        tIssQty = document.getElementById("T_IssQty" + tProID).value = 0;
                    }
                    document.getElementById("T_Amount" + tProID).value = parseFloat(parseFloat(tIssQty) * parseFloat(y[4])).toFixed(2);
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
            var T_IssQty = document.getElementById("T_IssQty" + tProID).value;
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
