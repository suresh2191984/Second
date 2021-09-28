

var isfocus = true;
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
    isfocus = true;
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
                    if (lis[i].split('|')[1].split('~')[2] == xTempP[0] && lis[i].split('|')[0] == xTempP[6] && lis[i].split('~')[4] == xTempP[4] && lis[i].split('~')[5] == xTempP[7] && lis[i].split('~')[8] == xTempP[9] && lis[i].split('~')[18] == xTempP[13]) {
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
    //document.getElementById('chkisCreditTransaction').checked = false;
}

function pSetAddFocus() {
    var qty = document.getElementById('txtQuantity').value.trim();

    if (qty == '0' || qty == '') {
        if (isfocus) {
            document.getElementById('txtQuantity').focus();
            isfocus = false;
            return;
        }
    }
        if (Number(qty) > 0) {
        document.getElementById('add').focus();
    }
    
  
}

function ProductsListPopup() {
    if (document.getElementById('txtConsumedBy').value.trim() == '' && document.getElementById('txtPatientNo').value.trim() == '' && document.getElementById('txtSmartCardNo').value.trim() == '') {
        alert('Provide consumed by or patient number');
        document.getElementById('txtConsumedBy').focus();
        return false;
    }
    if (document.getElementById('txtPatientNo').value.trim() == '' && document.getElementById('txtSmartCardNo').value.trim() == '') {
        if (document.getElementById('txtConsumedBy').value.trim().length < 2) {
            alert('Provide minimum two characters');
            document.getElementById('txtConsumedBy').focus();
            return false;
        }
    }
    var PName;
    var pNo;
    var SmartCardNo;
    pName = document.getElementById('txtConsumedBy').value.trim();
    pNo = document.getElementById('txtPatientNo').value.trim();
    SmartCardNo = document.getElementById('txtSmartCardNo').value.trim();
    window.open("PatientList.aspx?Sno=" + SmartCardNo + "&pName=" + pName + "&IsPopup=Y&pNo=" + pNo + "", "Patient", "height=450,width=810,scrollbars=yes");
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
                      ToTargetFormat($('#hdnSellingPrice'));
                    document.getElementById('hdnTax').value = val[6];
                      ToTargetFormat($('#hdnTax'));
                    document.getElementById('hdnExpiryDate').value = val[8];
                    document.getElementById('hdnHasExpiryDate').value = val[13];
                    document.getElementById('hdnUnitPrice').value = val[18];
                     ToTargetFormat($('#hdnUnitPrice'));
                    document.getElementById('hdnExpiryDateCheck').value = val[23];
                    // document.getElementById('txtUnit').disabled = true;
                    
                     ToTargetFormat($('#txtBatchQuantity'));

                    document.getElementById('txtQuantity').focus();
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
        alert('Ensure items added/quantity are provided properly');
        document.getElementById('txtQuantity').focus();
        return false;
    }

    if (Number(document.getElementById('txtQuantity').value) < 1) {
        alert('Ensure items added/quantity are provided properly');
        document.getElementById('txtQuantity').focus();
        return false;
    }

    if (document.getElementById('add').value != 'Update') {
        var x = document.getElementById('hdnProductList').value.split("^");
        var pid = document.getElementById('hdnReceivedID').value;
        var pName = document.getElementById('hdnProductName').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        var y; var i;
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
                if (y[0] == pid && y[2] == pBatchNo) {
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
        var pSellingPrice = ToInternalFormat($('#hdnSellingPrice'));
        var pTax = ToInternalFormat($('#hdnTax'));
        var pExp = document.getElementById('hdnExpiryDate').value;
        var pProBatchNo = document.getElementById('hdnProBatchNo').value;
        var pHasExpiryDate = document.getElementById('hdnHasExpiryDate').value;
        var phdnUnitPrice = ToInternalFormat($('#hdnUnitPrice'));
        if (document.getElementById('chkIsReimburse') != null)
            var IsReimburse = document.getElementById('chkIsReimburse').checked ? "Yes" : "No";

        var pExpiryDateCheck = document.getElementById('hdnExpiryDateCheck').value;
        var expirylevelBlocked = document.getElementById('hdnExpiryBlocked').value;

        if ((pHasExpiryDate == "Y") || (pExpiryDateCheck == "Y")) {
            var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
            if (expirylevel != '' && expirylevel != null) {
                if (expirylevel > 0) {
                    var isExpired = findExpiryItem(pExp, expirylevel);
                    if (isExpired == 2) {
                        if (expirylevelBlocked == "Y") {
                            alert("This Item Will be Expired with in " + expirylevel + " Months.Please select any other Batch (if available)");
                            document.getElementById('txtBatchNo').focus();
                            return false;
                        }
                        else {
                            var Replay = confirm("This Item Will be Expired with in " + expirylevel + " Months");
                            if (Replay != true) {

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
                    else if (isExpired == 0) {
                        alert("This Item is Alredy Expired.Please select any other Batch (if available) ");

                        if (document.getElementById('tbllist').rows.length > 1) {
                            document.getElementById('txtBatchNo').focus();
                            return false;

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

        
//        if (pHasExpiryDate == "Y") {
//            var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
//            if (expirylevel != '' && expirylevel != null) {
//                if (expirylevel > 0) {
//                    var isExpired = findExpiryItem(pExp, expirylevel);
//                    //                        if (isExpired == 1) {
//                    //                            alert("This Item is Alredy Expired");
//                    //                            document.getElementById('txtProduct').value = "";
//                    //                            document.getElementById('divProductDetails').style.display = 'none';
//                    //                            return false;
//                    //                            }
//                    if (isExpired == 2) {
//                        var Replay = confirm("This Item Will be Expired with in " + expirylevel + " Months. Do you want to continue!Click 'OK'");
//                        if (Replay == true) {
//                        }
//                        else {
//                            document.getElementById('txtProduct').value = "";
//                            document.getElementById('divProductDetails').style.display = 'none';
//                            while (count = document.getElementById('tbllist').rows.length) {

//                                for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
//                                    document.getElementById('tbllist').deleteRow(j);
//                                }
//                            }
//                            return false;
//                        }
//                    }
//                }
//            }
//        }


        document.getElementById('hdnProductList').value += pId + "~" + pName + "~" +
                        pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" +
                        pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" + pProBatchNo + "~" + IsReimburse + "~" + pHasExpiryDate + "~" + phdnUnitPrice + "^";
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

    return false;
}
function Tblist() {
    while (count = document.getElementById('tblOrederedItems').rows.length) {

        for (var j = 0; j < document.getElementById('tblOrederedItems').rows.length; j++) {
            document.getElementById('tblOrederedItems').deleteRow(j);
        }
    }

    document.getElementById('hdnGrandTotal').value = 0;
      ToTargetFormat($('#hdnGrandTotal'));
    document.getElementById('txtGrandTotal').value = 0;
     ToTargetFormat($('#txtGrandTotal'));
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
    var cell8 = Headrow.insertCell(7);

    //    cell1.innerHTML = "Product Name";
    //    cell2.innerHTML = "Batch No";
    //    cell3.innerHTML = "Issued Qty";
    //    cell4.innerHTML = "Unit";
    //    cell5.innerHTML = "Selling Price";
    //    cell6.innerHTML = "Amount";
    //    cell7.innerHTML = "IsReimbursable";
    //    cell8.innerHTML = "Action";
    

    cell1.innerHTML = SProductHeaderList.ProductName;
    cell2.innerHTML = SProductHeaderList.BatchNo;
    cell3.innerHTML = SProductHeaderList.IssuedQty;
    cell4.innerHTML = SProductHeaderList.Unit;
    cell5.innerHTML = SProductHeaderList.SellingPrice;
    cell6.innerHTML = SProductHeaderList.Amount;
    cell7.innerHTML = SProductHeaderList.IsReimbursable;
    cell8.innerHTML = SProductHeaderList.Action;

    if (document.getElementById('hdnProductList').value == '') {
        document.getElementById('tdExpiredIndication').style.display = 'none';
    }

    var x = document.getElementById('hdnProductList').value.split("^");
    if ( document.getElementById('lblNonMedicalAmt') != null)
        document.getElementById('lblNonMedicalAmt').innerHTML = "0.00";
        ToTargetFormat($('#lblNonMedicalAmt'));
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
            var cell8 = row.insertCell(7);

            cell1.innerHTML = y[1];
            cell2.innerHTML = y[2];
            cell3.innerHTML = y[3];
            cell4.innerHTML = y[4];
            document.getElementById('hdnDisplaydata').value = parseFloat(y[7]).toFixed(2);
           var pLrate= ToTargetFormat($('#hdnDisplaydata'));
           cell5.innerHTML = pLrate;
           document.getElementById('hdnDisplaydata').value = parseFloat(y[3] * y[7]).toFixed(2);
           pLrate = ToTargetFormat($('#hdnDisplaydata'));
           cell6.innerHTML = pLrate;
            tGrandTotal = parseFloat(parseFloat(tGrandTotal) + parseFloat(y[3] * y[7])).toFixed(2);
            var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
            if (y[12] == "Y") {
                if (expirylevel != '' && expirylevel != null) {
                    if (expirylevel > 0) {
                        var isExpired = findExpiryItem(y[9], expirylevel);
                        //                        if (isExpired == 1) {
                        //                            row.style.backgroundColor = "Blue";
                        //                        }
                        if (isExpired == 2) {
                            row.style.backgroundColor = "Orange";
                        }
                    }
                }
            }
            if (y[11] == "No") {
                document.getElementById('lblNonMedicalAmt').innerHTML = parseFloat(Number(ToInternalFormat($('#lblNonMedicalAmt'))) + Number(Number(y[3]) * Number(y[7]))).toFixed(2);
                  ToTargetFormat($('#lblNonMedicalAmt'));
            }
            cell7.innerHTML = y[11];
            cell8.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "' onclick='btnInvEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "' onclick='btnInvDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"

            if (document.getElementById('hdnTaskBilling').value == 1 && document.getElementById('hdnIsPay').value == "Y") {
                for (var j = 0; j < document.getElementById('tblOrederedItems').rows.length; j++) {
                    var firstRow = document.getElementById("tblOrederedItems").rows[j];
                    var cells = firstRow.cells.length;
                    if (cells >= 8) {
                        firstRow.deleteCell(7);
                    }
                }
            }

        }


    }


    document.getElementById('hdnProBatchNo').value = '';
    document.getElementById('txtBatchNo').value = '';
    document.getElementById('txtBatchQuantity').value = '';
    document.getElementById('hdnBatchList').value = '';
    document.getElementById('hdnHasExpiryDate').value = '';
     document.getElementById('hdnUnitPrice').value='';
   // ToInternalFormat($('#hdnUnitPrice')) = '';
    if (document.getElementById('chkIsReimburse') != null)
        document.getElementById('chkIsReimburse').checked = true;
    document.getElementById('divProductDetails').style.display = 'none';
    document.getElementById('txtProduct').focus();
    CheckTotal();
    doCalcReimburse();
    ShowExpiryIndication();

}
function ShowExpiryIndication() {
    var flag = 0;
    var z = document.getElementById('hdnProductList').value.split("^");
    for (i = 0; i < z.length; i++) {
        if (z[i] != "") {
            y = z[i].split('~');
            var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
            if (y[12] == "Y") {
                if (expirylevel != '' && expirylevel != null) {
                    if (expirylevel > 0) {
                        var ShowExpiredIndication = findExpiryItem(y[9], expirylevel);
                        if (ShowExpiredIndication == 2) {
                            flag = 1;
                        }
                    }
                }
            }
        }
    }
    if (flag == 1) {
        document.getElementById('tdExpiredIndication').style.display = 'block';
    }
    else {
        document.getElementById('tdExpiredIndication').style.display = 'none';
    }

}
function findExpiryItem(Expiredate, ConfigExpiryDateLevel) {
    var today = new Date();
    var Expdate = new Date(Expiredate);

    var monthdiff = monthDiff(today, Expdate);
    if (monthdiff >= 0) {
        if (monthdiff > ConfigExpiryDateLevel) {
            return monthdiff;
        }
        else {
            return 2; //Expired with in ConfigExpiryDateLevel
        }
    }
    else {
        return 0; //Alredy Expired
    }
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
        var pSellingPrice = ToInternalFormat($('#hdnSellingPrice'));
        var pTax = ToInternalFormat($('#hdnTax'));
        var pExp = document.getElementById('hdnExpiryDate').value;
        var pProBatchNo = document.getElementById('hdnProBatchNo').value;
        var pHasExpiryDate = document.getElementById('hdnHasExpiryDate').value;
        var phdnUnitPrice = ToInternalFormat($('#hdnUnitPrice'));
        var IsReimburse = document.getElementById('chkIsReimburse').checked ? "Yes" : "No";
        document.getElementById('hdnProductList').value = pId + "~" + pName + "~" +
                            pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" +
                            pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" + pProBatchNo + "~" + IsReimburse + "~" + pHasExpiryDate + "~" + phdnUnitPrice + "^";


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
function GetStockInHandByStockInHandID(ProductID, StockInHandID, ProductKey) {

    InventoryWebService.GetStockInHandByStockInHandID(ProductID, StockInHandID, ProductKey, stockinhandbyid);
}
function stockinhandbyid(inhandqty) {
    document.getElementById('TaskStockInHandQty').value = inhandqty[0].TotalStockReceived
    document.getElementById('txtBatchQuantity').value = (parseFloat(inhandqty[0].TotalStockReceived)).toFixed(2);
}
function btnInvEdit_OnClick(sEditedData) {
    var y = sEditedData.split('~');

    document.getElementById('hdnReceivedID').value = y[0];
    document.getElementById('hdnProductName').value = y[1];
    document.getElementById('txtProduct').value = y[1];
    document.getElementById('txtBatchNo').disabled = true;

    document.getElementById('txtBatchNo').value = y[2];
    document.getElementById('txtQuantity').value = y[3];
    document.getElementById('txtUnit').value = y[4];
    if (document.getElementById('hdnTaskBilling').value == "1")
        GetStockInHandByStockInHandID(y[6], y[0], 'aa');
    else
        document.getElementById('txtBatchQuantity').value = y[5];
    document.getElementById('hdnProductId').value = y[6];
    document.getElementById('hdnRowEdit').value = sEditedData;
    document.getElementById('add').value = 'Update';
    document.getElementById('divProductDetails').style.display = 'block';
    document.getElementById('hdnSellingPrice').value = y[7];
      ToTargetFormat($('#hdnSellingPrice'))
    document.getElementById('hdnTax').value = y[8];
      ToTargetFormat($('#hdnTax'))
    document.getElementById('hdnExpiryDate').value = y[9];
    document.getElementById('hdnProBatchNo').value = y[10];
    document.getElementById('chkIsReimburse').checked = y[11] == "Yes" ? true : false;
    document.getElementById('hdnHasExpiryDate').value = y[12];
    document.getElementById('hdnUnitPrice').value = y[13];
     ToTargetFormat($('#hdnUnitPrice'));
    AutoCompBacthNo();
}

function btnInvDelete(sEditedData) {
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
}

function pTotalAmount() {
    var temp = 0.00;
    var vat = 0.00;
    var TotalTemp = 0.00;
    var x = document.getElementById('hdnProductList').value.split("^");
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            var y = x[i].split("~");
            TotalTemp = parseFloat(y[3] * y[7]).toFixed(2);
            temp = parseFloat(parseFloat(temp) + parseFloat(y[3] * y[7])).toFixed(2);
            vat = parseFloat(parseFloat(vat) + parseFloat(TotalTemp) * parseFloat(y[8]) / 100).toFixed(2);
        }
    }
    var subT = parseFloat(parseFloat(temp) - parseFloat(vat)).toFixed(2);
    var vatT = parseFloat(vat).toFixed(2);
    var grossT = parseFloat(temp).toFixed(2);
    document.getElementById('hdnAddedAmount').value = subT + "~" + vatT + "~" + grossT;
//     ToTargetFormat($('#hdnAddedAmount'));
    TotalCalculation();
}


function CheckDueTotal() {
    var AmountRecieved = ToInternalFormat($('#txtAmountRecieved'));
    var AmountRecieved =ToInternalFormat($('#hdnAmountRecieved'));
    
    var GrandTotal = ToInternalFormat($('#hdnNetAmount'));

    var serviceCharge = ToInternalFormat($('#txtServiceCharge'));
    GrandTotal = parseFloat(GrandTotal);

    if (parseFloat(GrandTotal) >= parseFloat(AmountRecieved)) {
        // var AmountDue = ToInternalFormat($('#txtAmountDue')) = parseFloat(parseFloat(GrandTotal) - parseFloat(AmountRecieved)).toFixed(2);
        var AmountDue = parseFloat(parseFloat(GrandTotal) - parseFloat(AmountRecieved)).toFixed(2);
        document.getElementById('txtAmountDue').value = AmountDue;
         ToTargetFormat($('#txtAmountDue'));
         // var AmountDue = ToInternalFormat($('#hdnAmountDue')) = parseFloat(parseFloat(GrandTotal) - parseFloat(AmountRecieved)).toFixed(2);
         document.getElementById('hdnAmountDue').value = AmountDue;
          ToTargetFormat($('#hdnAmountDue'));

    }
    else {
        alert('Provide received amount less than or equal to net amount');
        return false;
    }
    SetOtherCurrValues();

}
function CheckDiscount() {
    pTotalAmount();
    GetNetAmount();
    SetOtherCurrValues();
}
function CheckTotal() {
    pTotalAmount();
    GetNetAmount();
    checkIsCredit();
    SetOtherCurrValues();

}

function setDiscount() {
    if ((document.getElementById('ddDiscountPercent').value) == 'select') {
        document.getElementById('txtDiscount').value = parseFloat(0).toFixed(2);
        ToTargetFormat($('#txtDiscount'));
        document.getElementById('txtDiscount').readOnly = false;
        document.getElementById('txtDiscountPercent').style.display = 'None';
        CheckTotal();
    }
    else if ((document.getElementById('ddDiscountPercent').value) == '0.00') {
        document.getElementById('txtDiscount').value = parseFloat(0).toFixed(2);
                ToTargetFormat($('#txtDiscount'));
        CheckDiscount();

    }

    else {
        document.getElementById('txtDiscountPercent').style.display = 'None';
        CheckTotal();
    }
}

function GetNetAmount() {
    var tempTaxAmt;
    var Total;


    var tax = ToInternalFormat($('#txtTax'))  == 0.00 ? 0 : ToInternalFormat($('#txtTax')) ;
    var tax = ToInternalFormat($('#hdnTtax'))== 0.00 ? 0 : ToInternalFormat($('#hdnTtax'));

    if ((document.getElementById('ddDiscountPercent').value) != 'select') {
        if ((ToInternalFormat($('#ddDiscountPercent'))) == '0.00') {
        document.getElementById('txtDiscount').value =  parseFloat((parseFloat(document.getElementById('txtGross').value) / 100) * (document.getElementById('txtDiscountPercent').value)).toFixed(2);
           
            //document.getElementById('txtDiscountPercent').visible = true;
            ToTargetFormat($('#txtDiscount'));
            document.getElementById('txtDiscountPercent').style.display = 'Block';
        }
        else {
         document.getElementById('txtDiscount').value = parseFloat((parseFloat(document.getElementById('txtGross').value) / 100) * (document.getElementById('ddDiscountPercent').value)).toFixed(2);
            
             ToTargetFormat($('#txtDiscount'));
        }
        document.getElementById('txtDiscount').readOnly = true;
    }

    else {
        document.getElementById('txtDiscount').readOnly = false;
    }

    var Discount = ToInternalFormat($('#txtDiscount'))== 0.00 ? 0 : ToInternalFormat($('#txtDiscount'));

    var GrandTotal = ToInternalFormat($('#txtGross'))== 0.00 ? 0 : ToInternalFormat($('#txtGross'));
    var GrandTotal = ToInternalFormat($('#hdnGross'))== 0.00 ? 0 : ToInternalFormat($('#hdnGross'));

    var PreviousDue = ToInternalFormat($('#txtDue'))== 0.00 ? 0 : ToInternalFormat($('#txtDue'));
    Total = parseFloat(parseFloat(GrandTotal) - parseFloat(Discount)).toFixed(2);
    if (Total < 0) {
        alert('Discount Amount should not exceed total amount');
        document.getElementById('ddDiscountPercent').value=0.00;
      ToTargetFormat($('#ddDiscountPercent'));
      document.getElementById('txtDiscount').value=0.00;
    ToTargetFormat($('#txtDiscount'));
        var Discount = ToInternalFormat($('#txtDiscount'))== 0.00 ? 0 :ToInternalFormat($('#txtDiscount'));

        var GrandTotal = ToInternalFormat($('#txtGross'))== 0.00 ? 0 :ToInternalFormat($('#txtGross'));
        var GrandTotal = ToInternalFormat($('#hdnGross')) == 0.00 ? 0 :ToInternalFormat($('#hdnGross'));
        var PreviousDue = ToInternalFormat($('#txtDue')) == 0.00 ? 0 : ToInternalFormat($('#txtDue'));
        Total = parseFloat(parseFloat(GrandTotal) - parseFloat(Discount)).toFixed(2);
    }


    tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(2);
    var beforeRoundNet = parseFloat(parseFloat(Total) + parseFloat(PreviousDue)).toFixed(2);
    var RoundNetAmt = parseFloat(getOPCustomRoundoff(parseFloat(Total) + parseFloat(PreviousDue))).toFixed(2);
    document.getElementById('txtNetAmount').value = RoundNetAmt;
     ToTargetFormat($('#txtNetAmount'));
    document.getElementById('hdnNetAmount').value = RoundNetAmt;
     ToTargetFormat($('#hdnNetAmount'));
    document.getElementById('txtRoundoffAmount').value = parseFloat(RoundNetAmt - beforeRoundNet).toFixed(2);
    ToTargetFormat($('#txtRoundoffAmount'));
    document.getElementById('hdnRoundBalace').value = document.getElementById('txtRoundoffAmount').value;
     ToTargetFormat($('#hdnRoundBalace'));
    document.getElementById('PaymentType_txtAmount').value = RoundNetAmt;
    ToTargetFormat($('#PaymentType_txtAmount'));
    if (document.getElementById('hdnUseDeposit').value == "N") {
        document.getElementById('PaymentType_txtAmount').value = RoundNetAmt;
         ToTargetFormat($('#PaymentType_txtAmount'));
    }
    changeAmountValues();

    //CheckDueTotal();
}
function DueCal() {
    var tempTaxAmt;
    var Total;
    var tax =  ToInternalFormat($('#txtTax')) == 0.00 ? 0 :  ToInternalFormat($('#txtTax'));
    var tax = ToInternalFormat($('# hdnTtax'))  == 0.00 ? 0 : ToInternalFormat($('# hdnTtax'));

    var Discount = ToInternalFormat($('#txtDiscount')) == 0.00 ? 0 : ToInternalFormat($('#txtDiscount'));
    var GrandTotal = ToInternalFormat($('#txtNetAmount')) == 0.00 ? 0 : ToInternalFormat($('#txtNetAmount'));
    //    var GrandTotal = document.getElementById('hdnNetAmount').value == 0.00 ? 0 : document.getElementById('hdnNetAmount').value;
    var PreviousDue = ToInternalFormat($('#txtDue')) == 0.00 ? 0 : ToInternalFormat($('#txtDue'));

    document.getElementById('txtDiscount').value = parseFloat(Discount).toFixed(2);
     ToTargetFormat($('#txtDiscount'));
    Total = parseFloat(parseFloat(GrandTotal) - parseFloat(Discount)).toFixed(2);
    tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(2);
    document.getElementById('txtNetAmount').value = parseFloat(parseFloat(Total) + parseFloat(PreviousDue)).toFixed(2);
     ToTargetFormat($('#txtNetAmount'));
    document.getElementById('hdnNetAmount').value = parseFloat(parseFloat(Total) + parseFloat(PreviousDue)).toFixed(2);
      ToTargetFormat($('#hdnNetAmount'));
    //CheckDueTotal();

}

function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {


    var ConValue = "OtherCurrencyDisplay1";

    var sVal = getOtherCurrAmtValues("REC", ConValue);
    var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
    var tempService = getOtherCurrAmtValues("SER", ConValue);
    var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
    sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 2);
    sVal = format_number(Number(sVal) + Number(TotalAmount), 2);
    if (PaymentAmount > 0) {

        if (Number(sNetValue) >= Number(sVal)) {
            sVal = format_number(sVal, 2);
            SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
            var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);

            document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2)
             ToTargetFormat($('#txtServiceCharge'));


            var amtRec = document.getElementById('hdnDepositUsed').value;
            amtRec = 0;
            document.getElementById('hdnAmountRecieved').value = format_number(Number(amtRec) + Number(pAmt), 2);
            ToTargetFormat($('#hdnAmountRecieved'));
            document.getElementById('txtAmountRecieved').value = format_number(Number(amtRec) + Number(pAmt), 2);
             ToTargetFormat($('#txtAmountRecieved'));
            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);


            document.getElementById('txtNetAmount').value = format_number(Number(pTotal), 2);
             ToTargetFormat($('#txtNetAmount'));
            document.getElementById('hdnNetAmount').value = format_number(Number(pTotal), 2);
             ToTargetFormat($('#hdnNetAmount'));
            CheckDueTotal();
            doCalcReimburse();
            return true;
        }
        else {
            alert('Amount provided is greater than net amount')
            return false;
        }
    }
    else {
        doCalcReimburse();
        return true;
    }



}


function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {

    var ConValue = "OtherCurrencyDisplay1";
    var sVal = getOtherCurrAmtValues("REC", ConValue);
    var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
    var tempService = getOtherCurrAmtValues("SER", ConValue);
    var CurrRate = GetOtherCurrency("OtherCurrRate");

    sVal = Number(Number(sVal) - Number(TotalAmount));
    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
    var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
    var pScrAmt = Number(pScr) * Number(CurrRate);
    var pAmt = Number(sVal) * Number(CurrRate);


    document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2);
     ToTargetFormat($('#txtServiceCharge'));
    var amtRec = document.getElementById('hdnDepositUsed').value;
    amtRec = 0;
    document.getElementById('hdnAmountRecieved').value = format_number(Number(sVal) + Number(amtRec), 2);
         ToTargetFormat($('#hdnAmountRecieved'));
    document.getElementById('txtAmountRecieved').value = format_number(Number(sVal) + Number(amtRec), 2);
          ToTargetFormat($('#txtAmountRecieved'));
    SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);

    var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

    document.getElementById('txtNetAmount').value = format_number(Number(pTotal), 2);
              ToTargetFormat($('#txtNetAmount'));
    document.getElementById('hdnNetAmount').value = format_number(Number(pTotal), 2);
              ToTargetFormat($('#hdnNetAmount'));
    CheckDueTotal();
    doCalcReimburse();
}

function chkCreditPament() {
    document.getElementById('chkisCreditTransaction').checked = false;
}

function checkIsCredit() {
    if (document.getElementById('chkisCreditTransaction').checked == true) {
        document.getElementById('txtAmountRecieved').value = '0.00';
        ToTargetFormat($('#txtAmountRecieved'));
        document.getElementById('hdnAmountRecieved').value = '0.00';
        ToTargetFormat($('#hdnAmountRecieved'));
        document.getElementById('hdnTotalAmtRec').value = '0.00';
        ToTargetFormat($('#hdnTotalAmtRec'));
        document.getElementById('txtAmountRecieved').disabled = true;
        document.getElementById('divpayType').disabled = true;
        document.getElementById('PaymentType_txtAmount').value = 0;
        ToTargetFormat($('#PaymentType_txtAmount'));
        ClearPaymentControlEvents();
        changeAmountValues();

    }
    if (document.getElementById('chkisCreditTransaction').checked == false) {
        document.getElementById('divpayType').disabled = false;
    }
}

function AutoCompBacthNo() {
    var customarray = document.getElementById('hdnProBatchNo').value.split("|");
    actb(document.getElementById('txtBatchNo'), customarray);
}


function ShowCredit() {
    document.getElementById('divisCredit').style.display = "block";
    document.getElementById('chkisCreditTransaction').checked = true;
    if (document.getElementById('hdnpatientID').value == "-1") {
        if (document.getElementById('ddlClients').options[document.getElementById('ddlClients').selectedIndex].text.toUpperCase() == "GENERAL") {
            document.getElementById('divisCredit').style.display = "none";
            document.getElementById('chkisCreditTransaction').checked = false;
        }
    }
    checkIsCredit();
}
function checkDetails() {

 
        if (document.getElementById('txtConsumedBy').value.trim() == "") {
            alert('Provide  patient name ');
            document.getElementById('txtConsumedBy').focus();
            return false;
        }

        if (document.getElementById('hdnIsPharmacisitCashier').value == "Y") {

            if (document.getElementById('txtDOBNos').value == "") {
                alert('Provide Patient Age');
                document.getElementById('txtDOBNos').focus();
                return false;
            }
            if (document.getElementById('txtMobile').value == "" && document.getElementById('txtLandLine').value == "") {
                alert('Provide Mobile Patient or Land Line Number ');
                document.getElementById('txtMobile').focus();
                return false;
            }
            if (document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].text == "Select") {
                alert('Select Patient State');
                document.getElementById('ddState').focus();
                return false;
            }
            if (document.getElementById('txtAddress').value == "") {
                alert('Provide Patient Address');
                document.getElementById('txtAddress').focus();
                return false;
            }
        }

        //        var x = document.getElementById("hdnTasklist").value.split("^");
        //        document.getElementById("hdnTaskCollectedItems").value = '';
        //        for (i = 0; i < x.length; i++) {
        //            if (x[i] != "") {
        //                var tProID = x[i];
        //                var T_select = document.getElementById("T_select" + tProID).checked;
        //                var T_Bacth = document.getElementById("T_Bacth" + tProID).value;
        //                var T_IssQty = document.getElementById("T_IssQty" + tProID).value;
        //                var T_ProList = document.getElementById("T_ProList" + tProID).value;
        //                if (T_select) {
        //                    var T_temp = T_ProList.split('^');
        //                    for (j = 0; j < T_temp.length; j++) {
        //                        if (T_temp[j] != "") {
        //                            y = T_temp[j].split('~');
        //                            if (T_Bacth.trim().toUpperCase() == y[1].trim().toUpperCase()) {
        //                                if (T_IssQty > 0) {
        //                                    document.getElementById("hdnTaskCollectedItems").value += T_temp[j] + "~" + T_IssQty + "^"
        //                                }
        //                                else {
        //                                    alert('Ensure items added/quantity are provided properly');
        //                                    document.getElementById("T_IssQty" + tProID).focus();
        //                                    return false;
        //                                }
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        //        }
        if (document.getElementById('hdnProductList').value == '') {
            var lst = document.getElementById("hdnTaskCollectedItems").value.split('^');
            if (lst == "") {
                alert('Select the product');
                document.getElementById('txtProduct').focus();
                return false;
            }
        }
//        if (document.getElementById('hdnProdlists').value != '' && document.getElementById('chkTaskReasgin').checked != true) {
//            var x = document.getElementById("hdnProductList").value.split('^');
//            var y = document.getElementById("hdnProdlists").value.split('^');

//            var flag = 0;
//            var count = 0;
//            for (i = 0; i < x.length; i++) {
//                for (j = 0; j < y.length; j++) {
//                    if (x[i] != "") {
//                        if (y[j] != "") {
//                            var s = y[j].split('~');
//                            var z = x[i].split('~');
//                            if (z[6] == s[1]) {
//                                if (z[3] != s[2]) {

//                                    var txtCancel = confirm('Prescribed quantity is lesser than issued Product.. So This task Reassigned');
//                                    if (txtCancel == true) {
//                                        document.getElementById('chkTaskReasgin').focus();
//                                        return false;
//                                    }
//                                }
//                                else {
//                                    document.getElementById('btnConsumable').style.display = 'none';
//                                    return true;

//                                }
//                            }
//                            //                            if (z[6] == s[1]) {

//                            //                                count=count +z[3];
//                            //                            }
//                        }
//                    }
//                }
//                //                if (s[2] <=count) {
//                //                    flag = 1;

//                //                }

//                //                count = 0;
//                //                s = "";
//                //                z = "";

//                //            }
//                //            if (flag == 0) {
//                //                var txtCancel = confirm('Prescribed quantity is lesser than issued Product.. So This task Reassigned');
//                //                if (txtCancel == true) {
//                //                    document.getElementById('chkTaskReasgin').focus();
//                //                    return false;
//                //                }
//                //                document.getElementById('btnConsumable').style.display = 'none';
//                //                return true;


//                //            }


//            }
//        }



        var alte = PaymentSaveValidation();
        if (alte == true) {
            var AmtRecieved = ToInternalFormat($('#txtAmountRecieved'));
            var AmtNet = ToInternalFormat($('#txtNetAmount'));
            //this condition for walk-in patient 
            if (document.getElementById('hdnType').value == "OP" && document.getElementById('hdnpatientID').value == "-1" && document.getElementById('hdnIsCreditBill').value == "N") {

                if (Number(AmtRecieved) < Number(AmtNet)) {
                    alert('For Walk-in Patient Due not Allowed.So Collect the Bill Amount');
                    return false;
                }


            }
            else {
                //end
                if (Number(AmtNet) > Number(AmtRecieved)) {
                    var pBill = confirm("This BillAmount will be added to due.\n Do you want to continue");
                    if (pBill != true) {
                        return false;
                    }
                }

            }


            document.getElementById('hdnTotalAmtRec').value = AmtRecieved;
            ToTargetFormat($('#hdnTotalAmtRec'));
            document.getElementById('btnConsumable').style.display = 'none';
            getClientID("OP");
            return true;
        }
        else {


            return false;
        }
        
       
        document.getElementById('btnConsumable').disabled = false;

        return true;
    
}
function openPOPup(url) {
    PaymentControlclear();

    ClearOtherCurrValues("OtherCurrencyDisplay1");
    SetReceivedOtherCurr(0, 0, "OtherCurrencyDisplay1");

    if (typeof unCheckDepositUsage == 'function') {
        unCheckDepositUsage();
        // document.getElementById('txtAmountRecieved').value = 0;
        ToTargetFormat($('#txtAmountRecieved'));
    }
    document.getElementById("hdnprint").click();
    // document.getElementById('PaymentType_ddlPaymentType').value = 1;
    ToTargetFormat($('#PaymentType_ddlPaymentType'));
}
function DuePupupClear() {
    PaymentControlclear();
    ClearOtherCurrValues("OtherCurrencyDisplay1");
    //document.getElementById('PaymentType_ddlPaymentType').value = 1;
    ToInternalFormat($('#PaymentType_ddlPaymentType'))=1;
}

function TaskItemAutoComplet(objBatch, txtBacth, listItems, tRecID) {

    var x = document.getElementById(listItems).value.split("^");
    InvOpSubTable(document.getElementById(listItems).value);
    var tuniqueID = document.getElementById(tRecID).value;
    var Tasklist = "";
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');
            if (checkAddedItems(y[0] + "~" + y[1] + "~" + y[3])) {
                document.getElementById('hdnReceivedID').value = tuniqueID;
                Tasklist += y[1] + "@#$" + y[3] + "|";
            }

        }
    }

    for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
        document.getElementById('tbllist').rows[j].style.backgroundColor = "";
        if ("tr_par" + tuniqueID == document.getElementById('tbllist').rows[j].id) {
            document.getElementById('tbllist').rows[j].style.backgroundColor = '#DCFC5C';
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
                if (tbacNo.trim().toUpperCase() == y[3].trim().toUpperCase()) {

                    tIssQty = document.getElementById("T_IssQty" + tProID).value;
                    if (Number(y[4]) < Number(tIssQty)) {
                        alert('Ensure items added/quantity are provided properly');
                        document.getElementById("T_IssQty" + tProID).focus();
                        document.getElementById("T_IssQty" + tProID).value = '';
                        return false;
                    }
                    if (document.getElementById("T_IssQty" + tProID).value == "") {
                        tIssQty = document.getElementById("T_IssQty" + tProID).value = 0;
                    }
                    document.getElementById("T_Amount" + tProID).value = parseFloat(parseFloat(tIssQty) * parseFloat(y[6])).toFixed(2);
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
function TaskCheckItemList(tProductList, tRecID) {
    var x = document.getElementById(tProductList).value.split('^');

    var tuniqueID = document.getElementById('hdnReceivedID').value;

    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');
            tProID = y[0];
            var tcheck = document.getElementById("T_select" + tProID).checked;
            if (tcheck) {
                if (tuniqueID.trim().toUpperCase() == y[3].trim().toUpperCase()) {
                    TaskAddedListItem(y[0] + "~" + y[1] + "~" + y[3], "Added");
                    document.getElementById("T_Bacth" + tProID).value = y[1];
                    document.getElementById("T_AblQty" + tProID).value = y[4];
                    document.getElementById("T_IssQty" + tProID).disabled = false;
                    document.getElementById("T_Bacth" + tProID).disabled = false;
                    document.getElementById("T_Unit" + tProID).value = y[5];
                    document.getElementById("T_SellPrice" + tProID).value = y[6];
                      ToTargetFormat($('#T_SellPrice + tProID'));
                    document.getElementById("T_Amount" + tProID).value = '0.00'
                     ToTargetFormat($('#T_Amount + tProID'));
                    document.getElementById("T_IssQty" + tProID).value = '';
                    document.getElementById("T_IssQty" + tProID).focus();
                    document.getElementById(tRecID).value = document.getElementById('hdnReceivedID').value = y[3];
                    break;
                }
                else {
                    document.getElementById("T_AblQty" + tProID).value = '0.00'
                    document.getElementById("T_IssQty" + tProID).value = '0'
                    document.getElementById("T_IssQty" + tProID).disabled = true;
                    document.getElementById("T_Unit" + tProID).value = '--'
                    document.getElementById("T_SellPrice" + tProID).value = '0.00'
                     ToTargetFormat($('#T_SellPrice + tProID'));
                    document.getElementById("T_Amount" + tProID).value = '0.00'
                      ToTargetFormat($('#T_Amount + tProID'));
                    TaskAddedListItem(y[0] + "~" + y[1] + "~" + y[3], "Delete");
                }


            }
        }
    }

    while (count = document.getElementById('tbllist').rows.length) {

        for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
            document.getElementById('tbllist').deleteRow(j);
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
                if (checkAddedItems(y[0] + "~" + y[1] + "~" + y[3])) {
                    document.getElementById("T_Bacth" + tProID).value = y[1];
                    document.getElementById("T_AblQty" + tProID).value = y[4];
                    document.getElementById("T_IssQty" + tProID).disabled = false;
                    document.getElementById("T_Bacth" + tProID).disabled = false;
                    document.getElementById("T_Unit" + tProID).value = y[5];
                    document.getElementById("T_SellPrice" + tProID).value = y[6];
                     ToTargetFormat($('#T_SellPrice + tProID'));
                    document.getElementById("T_Amount" + tProID).value = '0.00'
                     ToTargetFormat($('#T_Amount + tProID'));
                    document.getElementById("T_IssQty" + tProID).value = '';
                    document.getElementById("T_IssQty" + tProID).focus();
                    document.getElementById("T_uniqueID" + tProID).value = y[3];
                    TaskAddedListItem(y[0] + "~" + y[1] + "~" + y[3], "Added"); break;
                }


            } else {
                document.getElementById("T_Bacth" + tProID).value = '--'
                document.getElementById("T_Bacth" + tProID).disabled = true;
                document.getElementById("T_AblQty" + tProID).value = '0.00'
                document.getElementById("T_IssQty" + tProID).value = '0'
                document.getElementById("T_IssQty" + tProID).disabled = true;
                document.getElementById("T_Unit" + tProID).value = '--'
                document.getElementById("T_SellPrice" + tProID).value = '0.00'
                 ToTargetFormat($('#T_SellPrice + tProID'));
                document.getElementById("T_Amount" + tProID).value = '0.00'
                 ToTargetFormat($('#T_Amount + tProID'));
                TaskAddedListItem(y[0] + "~" + y[1] + "~" + y[3], "Delete");
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
            var T_UniqueID = document.getElementById("T_uniqueID" + tProID).value;
            if (T_select && T_IssQty > 0) {
                document.getElementById("hdnTaskCollectedItems").value = T_ProList + ""
                var T_temp = T_ProList.split('^');
                for (j = 0; j < T_temp.length; j++) {
                    if (T_temp[j] != "") {
                        y = T_temp[j].split('~');
                        if (T_UniqueID.trim().toUpperCase() == y[3].trim().toUpperCase()) {
                            document.getElementById("hdnTaskCollectedItems").value += T_temp[j] + "~" + T_IssQty + "^"
                            temp = parseFloat(parseFloat(y[6] * T_IssQty)).toFixed(2);
                            vat = parseFloat(parseFloat(temp) * parseFloat(y[7]) / 100).toFixed(2);
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
     //ToTargetFormat($('#hdnTaskAmount'));
    TotalCalculation();
    GetNetAmount();
    SetOtherCurrValues();
}

function TotalCalculation() {
    var AddedAmt = document.getElementById('hdnAddedAmount').value.split('~');
    var TaskAmt = document.getElementById('hdnTaskAmount').value.split('~');
    if (AddedAmt == "") {
        AddedAmt[0] = 0;
        AddedAmt[1] = 0;
        AddedAmt[2] = 0;
    }
    if (TaskAmt == "") {
        TaskAmt[0] = 0;
        TaskAmt[1] = 0;
        TaskAmt[2] = 0;
    }
    //
    document.getElementById('hdnGrandTotal').value = getOPCustomRoundoff(parseFloat(parseFloat(AddedAmt[2]) + parseFloat(TaskAmt[2])).toFixed(2));
    ToTargetFormat($('#hdnGrandTotal'));
    document.getElementById('txtGrandTotal').value = getOPCustomRoundoff(AddedAmt[2] + TaskAmt[2]);
      ToTargetFormat($('#txtGrandTotal'));
    document.getElementById('txtSubTotal').value = parseFloat(parseFloat(AddedAmt[0]) + parseFloat(TaskAmt[0])).toFixed(2);
    ToTargetFormat($('#txtSubTotal'));
    document.getElementById('txtTax').value = parseFloat(parseFloat(AddedAmt[1]) + parseFloat(TaskAmt[1])).toFixed(2);
      ToTargetFormat($('#txtTax'));
    document.getElementById('hdnTtax').value = parseFloat(parseFloat(AddedAmt[1]) + parseFloat(TaskAmt[1])).toFixed(2);
     ToTargetFormat($('#hdnTtax'));
    document.getElementById('txtGross').value = parseFloat(parseFloat(AddedAmt[2]) + parseFloat(TaskAmt[2])).toFixed(2);
     ToTargetFormat($('#txtGross'));
    document.getElementById('hdnGross').value = parseFloat(parseFloat(AddedAmt[2]) + parseFloat(TaskAmt[2])).toFixed(2);
    ToTargetFormat($('#hdnGross'));
    //Getdigitalnumber(document.getElementById('lbldigitalnumber'), getOPCustomRoundoff(parseFloat(parseFloat(AddedAmt[2]) + parseFloat(TaskAmt[2])).toFixed(2)));
    Getdigitalnumber(  ToTargetFormat($('#lbldigitalnumber')), getOPCustomRoundoff(parseFloat(parseFloat(AddedAmt[2]) + parseFloat(TaskAmt[2])).toFixed(2)));


}

function ReDirectPage(URL) {
    window.location.href = URL;
}

function SelectedPatient(source, eventArgs) {

    var tName = eventArgs.get_text().split(':')[0];
    var tNum = eventArgs.get_text().split(':')[1];
    var tvType = eventArgs.get_text().split(':')[2];
    var tVisitID = eventArgs.get_value().split('~')[0];
    var tSex = eventArgs.get_value().split('~')[1] == "M" ? "Male" : "Female";
    var tTITLECode = eventArgs.get_value().split('~')[2];
    var tAge = eventArgs.get_value().split('~')[3];
    var tAdd1 = eventArgs.get_value().split('~')[4];
    var tClientID = eventArgs.get_value().split('~')[5];
    var tRateID = eventArgs.get_value().split('~')[6];
    var tPOAName = eventArgs.get_value().split('~')[7];
    var IPNumber = eventArgs.get_value().split('~')[8];
    var TPNumber = eventArgs.get_value().split('~')[9];
    var Pid = eventArgs.get_value().split('~')[10];
    var visitState = eventArgs.get_value().split('~')[11];
    var DOB = eventArgs.get_value().split('~')[12];
    var MartialStatus = eventArgs.get_value().split('~')[13];
    var City = eventArgs.get_value().split('~')[14];
    var Mobile = eventArgs.get_value().split('~')[15];
    var IsCreditBill = eventArgs.get_value().split('~')[16];
    var TPAID = eventArgs.get_value().split('~')[17];
    var Nationality = eventArgs.get_value().split('~')[18];
    var StateID = eventArgs.get_value().split('~')[19];
    var CountryID = eventArgs.get_value().split('~')[20];
    var VisitPurpose = eventArgs.get_value().split('~')[21];
    var PreAuthAmount = eventArgs.get_value().split('~')[22];
    var SmartCardNumber = eventArgs.get_value().split('~')[26];

    document.getElementById('txtConsumedBy').value = tName;
    document.getElementById('txtPatientNo').value = tNum;
    document.getElementById('hdnPatientNo').value = tNum;
    document.getElementById('hdnpatientID').value = Pid;
    document.getElementById('ddSalutation').value = tTITLECode;
    document.getElementById('hdnPatVisitID').value = tVisitID;
    document.getElementById('txtSmartCardNo').value = SmartCardNumber;
    document.getElementById('txtMobile').value = Mobile.split(',')[0];
    document.getElementById('txtLandLine').value = Mobile.split(',')[1];
    document.getElementById('txtDOBNos').value = tAge.split(' ')[0];
    document.getElementById('ddState').value = StateID;
    document.getElementById('ddMarital').value = MartialStatus;
    document.getElementById('ddCountry').value = CountryID;
    document.getElementById('ddlNationality').value = Nationality;
    if (tSex == "Male")
        tSex = "M";
    if (tSex == "Female")
        tSex = "F";
    document.getElementById('ddSex').value = tSex;

    var pAdd = "";
    if (tAdd1 != "") {
        pAdd = tAdd1.trim();
    }
    if (City != "") {
        pAdd = City;
        if (tAdd1 != "") {
            pAdd = tAdd1.trim() + ", " + City.trim();
        }
    }

    document.getElementById('txtAddress').value = pAdd;
    document.getElementById('txtPhysicianName').value = '';
    document.getElementById('ddSalutation').disabled = true;
    document.getElementById('divisCredit').style.display = "none";
    document.getElementById('txtSmartCardNo').readOnly = true;
    document.getElementById('txtMobile').readOnly = true;
    document.getElementById('txtLandLine').readOnly = true;
    document.getElementById('txtDOBNos').readOnly = true;
    document.getElementById('ddState').disabled = true;
    document.getElementById('ddMarital').disabled = true;
    document.getElementById('ddSex').disabled = true;
    document.getElementById('ddCountry').disabled = true;
    document.getElementById('ddlNationality').disabled = true;
    getUsageDeposit()

}


function fDepositDetail(tDeposit) {
    var Pid = document.getElementById('hdnpatientID').value;
    if (Number(Pid) <= 0) {
        Pid = 0;
    }
    if (tDeposit.length > 0 && tDeposit[tDeposit.length - 1].AmountDeposited) {
        document.getElementById('hdnUseDeposit').value = "Y";
        setDepositValues(Pid, tDeposit[0].DepositID, tDeposit[tDeposit.length - 1].AmountDeposited, tDeposit[tDeposit.length - 1].PaidCurrencyAmount);
    }
}

function SelectedTemp(Source, eventArgs) {
    var tName = eventArgs.get_text().split(':')[0];
    var tNum = eventArgs.get_text().split(':')[1];
    var tvType = eventArgs.get_text().split(':')[2];
    var tVisitID = eventArgs.get_value().split('~')[0];
    var tSex = eventArgs.get_value().split('~')[1] == "M" ? "Male" : "Female";
    var tTITLECode = eventArgs.get_value().split('~')[2];
    var tAge = eventArgs.get_value().split('~')[3];
    var tAdd1 = eventArgs.get_value().split('~')[4];
    var tClientID = eventArgs.get_value().split('~')[5];
    var tRateID = eventArgs.get_value().split('~')[6];
    var tPOAName = eventArgs.get_value().split('~')[7];
    var IPNumber = eventArgs.get_value().split('~')[8];
    var TPNumber = eventArgs.get_value().split('~')[9];
    var dhelp = document.getElementById('dvHelp');
    var DOB = eventArgs.get_value().split('~')[12];
    var City = eventArgs.get_value().split('~')[14];
 
 
    var Tooltips = '<table border="0"><tr><td>'+s.Sname+'</td><td>:</td><td align="left">' + tName + '</td></tr>';
    Tooltips += '<tr><td>'+s.Patientno+'</td><td>:</td> <td align="left">' + tNum + '</td> </tr>';
    Tooltips += '<tr><td>'+s.IpNo+'</td><td>:</td> <td align="left">' + IPNumber + '</td> </tr>';
    Tooltips += '<tr><td>'+s.DOB+'</td><td>:</td> <td align="left">' + DOB + '</td> </tr>';
    Tooltips += '<tr><td>'+s.Age+'</td><td>:</td> <td align="left">' + tAge + '</td> </tr>';
    Tooltips += '<tr><td>'+s.Sex+'</td><td>:</td> <td align="left">' + tSex + '</td> </tr>';
    Tooltips += '<tr><td>'+s.Address+'</td><td>:</td> <td align="left">' + tAdd1 + '</td> </tr>';
    Tooltips += '<tr><td>'+s.City+'</td><td>:</td> <td align="left">' + City + '</td> </tr>';
    Tooltips += '<tr><td>'+s.PhoneNo+'</td><td>:</td> <td align="left">' + TPNumber + '</td> </tr>';
    Tooltips += '<tr><td>'+s.VisitPurpose+'</td><td>:</td> <td align="left">' + tPOAName + '</td> </tr> </table>';
    dhelp.innerHTML = Tooltips;

}

function onChangeItem() {

    var dhelp = document.getElementById('dvHelp');
    dhelp.innerHTML = '';
    if (document.getElementById('hdnIsPharmacisitCashier').value == "Y" && document.getElementById('hdnTaskBilling').value != 1) {
        document.getElementById('txtDOBNos').focus();
    }
    else if (document.getElementById('hdnTaskBilling').value != 1) {
        document.getElementById('txtPhysicianName').focus();
    }

}


function ClearPatientDetails(evt) {
    var keycode = 0;
    if (evt) {
        keycode = evt.keyCode || evt.which
    }
    else {
        keycode = window.event.keyCode;
    }
    if (keycode != 9) {
        document.getElementById('txtAddress').value = "";
        document.getElementById('txtPhysicianName').value = "";
        document.getElementById('txtConsumedBy').readOnly = false;
        document.getElementById('txtPatientNo').readOnly = false;
        document.getElementById('ddSalutation').disabled = false;
        document.getElementById('divisCredit').style.display = "none";
        document.getElementById('txtSmartCardNo').readOnly = false;
        document.getElementById('txtSmartCardNo').value = "";
        document.getElementById('txtPatientNo').value = "";
        document.getElementById('txtDOBNos').value = "";
        document.getElementById('txtMobile').value = "";
        document.getElementById('txtLandLine').value = "";
        document.getElementById('txtDOBNos').readOnly = false;
        document.getElementById('txtMobile').readOnly = false;
        document.getElementById('txtLandLine').readOnly = false;
        document.getElementById('ddSex').disabled = false;
        document.getElementById('ddState').disabled = false;
        document.getElementById('ddState').value = "Select";
        document.getElementById('ddCountry').value = 75;
        document.getElementById('ddlNationality').value = 86;
        document.getElementById('ddMarital').disabled = false;
        document.getElementById('ddMarital').disabled = false;
        document.getElementById('ddCountry').disabled = false;
        document.getElementById('ddlNationality').disabled = false;
        document.getElementById('hdnpatientID').value = "-1";
        //document.getElementById('ddSalutation').options[0].selected = true;
        unCheckDepositUsage();

        showHideUsageTab();
        SetVisitTypePros();
    }

}

function doCalcReimburse() {

    var hdnNonMedical = 0;
    var txtServiceCharge = ToInternalFormat($('#txtServiceCharge'));
    var txtGrandTotal = ToInternalFormat($('#txtGrandTotal'));
    var txtAmountRecieved = ToInternalFormat($('#txtAmountRecieved'));
    //
    var txtNonMedical = ToInternalFormat($('#txtNonMedical'));
    var txtCoPayment = ToInternalFormat($('#txtCoPayment'));
    var txtExcess = ToInternalFormat($('#txtExcess'));

    var pPreAuthAmount = 0;
    //pro
    // alert("");
    if (document.getElementById('lblNonMedicalAmt') != null )
        var NonReimburseAmt = Number(ToInternalFormat($('#lblNonMedicalAmt')));

    var AmtRecd = Number(txtAmountRecieved.value);

    var TpaPaidAmt = 0;

    pPreAuthAmount = TpaPaidAmt > 0 ? pPreAuthAmount - TpaPaidAmt : pPreAuthAmount;

    if (NonReimburseAmt > 0 && NonReimburseAmt <= AmtRecd) {
        txtNonMedical.value = parseFloat(NonReimburseAmt).toFixed(2);
        txtCoPayment.value = parseFloat(AmtRecd - NonReimburseAmt).toFixed(2);

        if (Number(txtCoPayment.value) > Number(pPreAuthAmount)) {
            txtExcess.value = parseFloat(Number(txtCoPayment.value) - Number(pPreAuthAmount)).toFixed(2);
            txtCoPayment.value = Number(pPreAuthAmount).toFixed(2);
        } else {
            txtExcess.value = (0).toFixed(2);
        }

    } else if (NonReimburseAmt > 0 && NonReimburseAmt > AmtRecd) {

        txtNonMedical.value = parseFloat(AmtRecd).toFixed(2);
        txtCoPayment.value = (0).toFixed(2);
        txtExcess.value = (0).toFixed(2);

    } else if (NonReimburseAmt == 0) {

        txtCoPayment.value = parseFloat(AmtRecd).toFixed(2);
        txtNonMedical.value = (0).toFixed(2);
        if (Number(txtCoPayment.value) > Number(pPreAuthAmount)) {
            txtExcess.value = parseFloat(Number(txtCoPayment.value) - Number(pPreAuthAmount)).toFixed(2);
            txtCoPayment.value = Number(pPreAuthAmount).toFixed(2);
        } else {
            txtExcess.value = (0).toFixed(2);
        }
    }

    if (txtCoPayment != null)
        var CoPay = Number(txtCoPayment.value);
    if (Excess != null)
        var Excess = Number(txtExcess.value);
    if (NonMedical != null)
        var NonMedical = Number(txtNonMedical.value);
    if (NetBill != null)
        var NetBill = Number(txtGrandTotal.value);



}

function getPrecision(obj) {
    obj.value = obj.value == "" ? parseFloat(0).toFixed(2) : parseFloat(obj.value).toFixed(2);
}

function customCoPayment() {
    var txtCoPayment = ToInternalFormat($('#txtCoPayment'));
    var txtExcess =  ToInternalFormat($('#txtExcess'));
    var hdnCoPayment = ToInternalFormat($('#hdnCoPayment'));

    var excess = Number(txtExcess.value);
    var diffAmt = Number(txtCoPayment.value) - Number(hdnCoPayment.value);

    if (diffAmt > 0) {
        if (diffAmt > excess) {
            txtCoPayment.value = parseFloat(Number(hdnCoPayment.value) + excess).toFixed(2);
            txtExcess.value = parseFloat(0).toFixed(2);
        } else {
            txtCoPayment.value = parseFloat(Number(hdnCoPayment.value) + diffAmt).toFixed(2);
            txtExcess.value = parseFloat(excess - diffAmt).toFixed(2);
        }
    } else {
        diffAmt = (-1) * diffAmt;
        txtCoPayment.value = parseFloat(Number(hdnCoPayment.value) - diffAmt).toFixed(2);
        txtExcess.value = parseFloat(Number(txtExcess.value) + diffAmt).toFixed(2);
    }
}

function prepareCopayment() {
    var hdnCoPayment = ToInternalFormat($('#hdnCoPayment'));
    var txtCoPayment =  ToInternalFormat($('#txtCoPayment'));
    getPrecision(txtCoPayment);
    hdnCoPayment.value = txtCoPayment.value;
}





//Code By Syed: Start
function getOPCustomRoundoff(netRound) {
    var DefaultRound =ToInternalFormat($('#hdnDefaultRoundoff'));
    var RoundType = document.getElementById('hdnRoundOffType').value;
   
    if (RoundType.toLowerCase() == "lower value") {
        result = (Math.floor(Number(netRound) / Number(DefaultRound))) * (Number(DefaultRound));
    }
    else if (RoundType.toLowerCase() == "upper value") {
        result = (Math.ceil(Number(netRound) / Number(DefaultRound))) * (Number(DefaultRound));
    }
    else if (RoundType.toLowerCase() == "none") {
        result = format_number_withSignNone(netRound, 2);
    }
    else {
        result = parseFloat(netRound).toFixed(2);
    }
    result = parseFloat(result).toFixed(2);
    return result;
}
//End:
