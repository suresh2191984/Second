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
    if (lis.length == 0) {
        document.getElementById('txtProduct').value = '';
        document.getElementById('txtProduct').focus();
    }
   

    for (i = 0; i < lis.length; i++) {
        if (lis[i] != "") {
            var isTrue = true;
            for (xY = 0; xY < pMainX.length; xY++) {
                if (pMainX[xY] != "") {
                    xTempP = pMainX[xY].split('~');
                    if (lis[i].split('~')[3] == xTempP[6] && lis[i].split('~')[11] == xTempP[10] && lis[i].split('~')[7] == xTempP[4] && lis[i].split('~')[8] == xTempP[9] && lis[i].split('~')[11] == xTempP[10] ) {
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

    var pId = document.getElementById('hdnProductId').value;
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
            if (CheckTaskItems(pId + "~" + y[0] + "~" + y[3] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[11] + "~" + y[17] + "~" + y[18])) {
                document.getElementById('hdnProBatchNo').value += y[0] + "@#$" + y[11] + "|";
                document.getElementById('divProductDetails').style.display = 'block';
                if (lis.length > 1) {
                    if (isAddItem == 0) {
                        document.getElementById('hdnReceivedID').value = y[11];
                        BindQuantity();
                        isAddItem = 1;
                    }
                }
            }

        }

    }
     


    if (lis.length != pMainX.length) {
         AutoCompBacthNo();
        }
    else {
        while (count = document.getElementById('tbllist').rows.length) {
            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        } 
        document.getElementById('txtProduct').value = '';
        document.getElementById('txtProduct').focus();
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

function pSetAddFocus() {
    var qty = document.getElementById('txtQuantity').value.trim();
     
}


function BindQuantity() {
    var blnExists = false;
   
    if (document.getElementById('hdnReceivedID').value.trim() != "") {
        var BatchNoList = document.getElementById('hdnBatchList').value.split("^");
        for (i = 0; i < BatchNoList.length; i++) {
            if (BatchNoList[i] != "") {
                var val = BatchNoList[i].split("~");
                if (val[11] == (document.getElementById('hdnReceivedID').value.trim())) {
                    document.getElementById('txtBatchNo').value = val[0];
                    document.getElementById('hdnProductName').value = val[1];
                    document.getElementById('hdnReceivedID').value = val[3];
                    document.getElementById('txtBatchQuantity').value = val[5];
                    document.getElementById('txtUnit').value = val[7];
                    document.getElementById('hdnSellingPrice').value = val[9];
                    document.getElementById('hdnTax').value = val[6];
                    document.getElementById('hdnExpiryDate').value = val[8];
                    document.getElementById('hdnrate').value = val[9];
                    document.getElementById('hdnunit').value = val[5];
                    document.getElementById('hdnParReceiptId').value = val[10];
                    document.getElementById('hdnReceivedID').value = val[11];
                    document.getElementById('hdnptype').value = val[12];
                    document.getElementById('hdnFinalBillId').value = val[13];
                    document.getElementById('hdnIsReimbursable').value = val[14];
                    document.getElementById('hdnCreditBill').value = val[15];
                    document.getElementById('hdbkittype').value = val[16];
                    document.getElementById('hdnkitID').value = val[17];
                    document.getElementById('hdnIsKit').value = val[18];
                  var Kittype = document.getElementById('hdbkittype').value ;

                    var pCell = document.getElementById('hdnReceivedID').value;

                    for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                        document.getElementById('tbllist').rows[j].style.backgroundColor = "";
                        if ("tr_par" + pCell == document.getElementById('tbllist').rows[j].id) {
                            document.getElementById('tbllist').rows[j].style.backgroundColor = '#DCFC5C';
                        }
                        if (Kittype == 'Y') {
                            if ("tr_par" + pCell == document.getElementById('tbllist').rows[j].id) {
                                document.getElementById('tbllist').rows[j].style.backgroundColor = "Red";
                            }
                        }

                    }
                    
                    blnExists = true; 
                    break;
                }
            }
        }
    }
    if (blnExists == false) {
        document.getElementById('txtUnit').value = '';
        document.getElementById('txtBatchQuantity').value = '';
        document.getElementById('txtBatchNo').value = '';
        document.getElementById('hdnReceivedID').value = '';
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
        document.getElementById('txtQuantity').value = '';
        document.getElementById('txtQuantity').focus();
        return false;
    }

    if (Number(document.getElementById('txtQuantity').value) < 1) {
        alert('Ensure items added/quantity are provided properly');
        document.getElementById('txtQuantity').value = '';
        document.getElementById('txtQuantity').focus();
        return false;
    }

   
    if (document.getElementById('add').value != 'Update') {
        var x = document.getElementById('hdnProductList').value.split("^");
        var pProductId = document.getElementById('hdnProductId').value;
        var pName = document.getElementById('hdnProductName').value;
        var pBillingDetailsID = document.getElementById('hdnReceivedID').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        var pExp = document.getElementById('hdnExpiryDate').value;
        var pkittype = document.getElementById('hdbkittype').value;
        var pkitid = document.getElementById('hdnkitID').value;
        var piskit = document.getElementById('hdnIsKit').value;
        var y; var i;
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
       
                if (y[0] == pProductId && y[2] == pBatchNo && y[10] == pBillingDetailsID && y[10] == pBillingDetailsID && y[16]==pkitid ) {
                        alert('Product number and batch number combination already exist');
                        document.getElementById('txtProduct').value = '';
                        document.getElementById('txtProduct').focus();
                        return false;
                    }
             

               if (y[17] == piskit && y[15] == pkittype) {

                    if (y[15] == pkittype && y[16] == pkitid && y[0] == pProductId) {
                        alert('Kitbatch  combination already exist');
                        document.getElementById('txtProduct').value = '';
                        document.getElementById('txtProduct').focus();
                        return false;


                    }
                

                }
               else if (y[15] == pkittype && y[16] == pkitid ) {
                        alert('Kitbatch  combination already exist');
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
        var pType = document.getElementById('hdnptype').value;

        var pRecepitNo = document.getElementById('hdnParReceiptId').value;
        var pBillingDetailsID = document.getElementById('hdnReceivedID').value;
        var pFinalBillID = document.getElementById('hdnFinalBillId').value;
        var qty = document.getElementById('hdnunit').value;
        var PendingAmt = document.getElementById('hdnPendingAmt').value;
        var PaidAmt = document.getElementById('hdnpaidAmount').value;
        var ReFundAmt = document.getElementById('hdnReFundAmount').value;
        var pIsReimbursable = document.getElementById('hdnIsReimbursable').value;
        var pIsCreditBill = document.getElementById('hdnCreditBill').value;
        var kittype = document.getElementById('hdbkittype').value;
        var kitid = document.getElementById('hdnkitID').value;
        var iskit = document.getElementById('hdnIsKit').value;
        if ((pQTY == 0) && (pQuantity != 0) && (pQTY <= pQuantity) && (qty == 0)) {
            alert('Ensure items added/quantity are provided properly/Pharmacy Bill Due Is Avilable Should not Refund');
            document.getElementById('txtQuantity').value = '';
            document.getElementById('hdnProductList').value = '';
            document.getElementById('txtQuantity').focus();
            return false;
        }

        else {

            document.getElementById('hdnProductList').value += pId + "~" + pName + "~" +
                        pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" +
                        pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" +
                        pBillingDetailsID + "~" + pType + "~" + pFinalBillID + "~" +
                        pIsReimbursable + "~" + pIsCreditBill + "~" + kittype + "~" + kitid + "~" + iskit + "~" + pRecepitNo + "^";
                     Tblist();

            return true;
        }
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
    Headrow.style.fontWeight = "bold";
    Headrow.className = "dataheader1"
    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    var cell5 = Headrow.insertCell(4);
    var cell6 = Headrow.insertCell(5);
    var cell7 = Headrow.insertCell(6);
    var cell8 = Headrow.insertCell(7);
    cell4.style.display = "none";
    cell1.innerHTML = "Product Name";
    cell2.innerHTML = "Batch No";
    cell3.innerHTML = "Return Qty";
    cell4.innerHTML = "Unit";
    cell5.innerHTML = "Selling Price";
    cell6.innerHTML = "Amount";
    cell7.innerHTML = "Action";
    cell8.innerHTML = "Type";
    var TotalAmt = 0;
    var TotalDueAmt = 0;

    var totalPaid = parseFloat(document.getElementById('lblValueAdvanceAmt').innerHTML) +
                    parseFloat(document.getElementById('lblValueRecAmount').innerHTML)

    var x = document.getElementById('hdnProductList').value.split("^");
    if (document.getElementById('lblNonMedicalAmt') != null)
        document.getElementById('lblNonMedicalAmt').innerHTML = "0.00";
    var tGrandTotal = 0.00;
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');

            var row = document.getElementById('tblOrederedItems').insertRow(1);
            row.style.height = "13px";
            if (y[15] == 'Y') {
                row.style.backgroundColor = "White";
            }
            if (y[17] == 'Y') {
                row.style.backgroundColor = "Green";
            }
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);
            var cell8 = row.insertCell(7);
         
            cell4.style.display = "none";
            cell1.innerHTML = y[1];
            cell2.innerHTML = y[2];
            cell3.innerHTML = y[3];
            cell4.innerHTML = y[4];
            cell5.innerHTML = parseFloat(y[7]).toFixed(2);
            cell6.innerHTML = parseFloat(y[3] * y[7]).toFixed(2);

            var name = y[11];
            var isreimbursible = y[13];
            var isCreditBill = y[14];
            if (isCreditBill == 'Y') {
                if (name == "PDC") {
                    if (y[15] == 'Y' && y[17] != 'Y') {
                        cell8.innerHTML = "Due Item(Kit)";
                    }
                    else if (y[17] == 'Y' && y[15] == 'Y') {
                    cell8.innerHTML = "Kit";
                    }
                    else {
                        cell8.innerHTML = "Due Item";
                    }
                    TotalDueAmt = parseFloat(parseFloat(TotalDueAmt) + parseFloat(y[3] * y[7])).toFixed(2)
                    //                if (TotalDueAmt > 0) {
                    document.getElementById('hdnDueAmount').value = TotalDueAmt;
                    document.getElementById('lblTotalDueAmt').innerHTML =
                                        "Total Due Item Refund Amount  :" + TotalDueAmt;

                    //                }
                }
                else {
                    if (name != 'PDC' && isreimbursible == 'N') {
                        TotalAmt = parseFloat(parseFloat(TotalAmt) + parseFloat(y[3] * y[7])).toFixed(2)
                        //         if (TotalAmt > 0) {
                        document.getElementById('hdnBilledAmount').value = TotalAmt;
                        if (TotalAmt > totalPaid) {
                            document.getElementById('lbldigitalnumber').innerHTML = "Total Billed Item Refund Amount  :" + totalPaid.toFixed(2);
                            document.getElementById('hdntotamount').value = totalPaid.toFixed(2);
                        }
                        else {
                            document.getElementById('lbldigitalnumber').innerHTML = "Total Billed Item Refund Amount  :" + TotalAmt;
                            document.getElementById('hdntotamount').value = TotalAmt;
                        }
                        //            }
                        //
                        if (y[15] == 'Y' && y[17] != 'Y') {
                            cell8.innerHTML = "Billed Item(Kit)";
                        }
                        else if (y[17] == 'Y' && y[15] == 'Y') {
                            cell8.innerHTML = "Kit";
                        }
                        else {
                            cell8.innerHTML = "Billed Item";
                        }
                    }
                    else {
                        if (y[15] == 'Y' && y[17] != 'Y') {
                            cell8.innerHTML = "Due Item(Kit)";
                        }
                        else if (y[17] == 'Y' && y[15] == 'Y') {
                            cell8.innerHTML = "Kit";
                        }
                        else {
                            cell8.innerHTML = "Due Item";
                        }
                        TotalDueAmt = parseFloat(parseFloat(TotalDueAmt) + parseFloat(y[3] * y[7])).toFixed(2)
                        //                if (TotalDueAmt > 0) {
                        document.getElementById('hdnDueAmount').value = TotalDueAmt;
                        document.getElementById('lblTotalDueAmt').innerHTML =
                                        "Total Due Item Refund Amount  :" + TotalDueAmt;

                    }
                }

            }

            else {
                if (name == "PDC") {

                    if (y[15] == 'Y' && y[17] != 'Y') {
                        cell8.innerHTML = "Due Item(Kit)";
                    }
                    else if (y[17] == 'Y' && y[15] == 'Y') {
                        cell8.innerHTML = "Kit";
                    }
                    else {
                        cell8.innerHTML = "Due Item";
                    }
                    TotalDueAmt = parseFloat(parseFloat(TotalDueAmt) + parseFloat(y[3] * y[7])).toFixed(2)
                    //                if (TotalDueAmt > 0) {
                    document.getElementById('hdnDueAmount').value = TotalDueAmt;
                    document.getElementById('lblTotalDueAmt').innerHTML =
                                        "Total Due Item Refund Amount  :" + TotalDueAmt;

                    //                }
                }
                else {

                    TotalAmt = parseFloat(parseFloat(TotalAmt) + parseFloat(y[3] * y[7])).toFixed(2)
                    //         if (TotalAmt > 0) {
                    document.getElementById('hdnBilledAmount').value = TotalAmt;
                    if (TotalAmt > totalPaid) {
                        document.getElementById('lbldigitalnumber').innerHTML = "Total Billed Item Refund Amount  :" + totalPaid.toFixed(2);
                        document.getElementById('hdntotamount').value = totalPaid.toFixed(2);
                    }
                    else {
                        document.getElementById('lbldigitalnumber').innerHTML = "Total Billed Item Refund Amount  :" + TotalAmt;
                        document.getElementById('hdntotamount').value = TotalAmt;
                    }
                    //            }
                    //

                    if (y[15] == 'Y' && y[17] != 'Y') {
                        cell8.innerHTML = "Billed Item(Kit)";
                    }
                    else if (y[17] == 'Y' && y[15] == 'Y') {
                        cell8.innerHTML = "Kit";
                    }
                    else {
                        cell8.innerHTML = "Billed Item";
                    }

                   

                }
            }




            tGrandTotal = parseFloat(parseFloat(tGrandTotal) + parseFloat(y[3] * y[7])).toFixed(2);
            cell7.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] +  "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
        }
    }
    document.getElementById('hdnProBatchNo').value = '';
    document.getElementById('txtBatchNo').value = '';
    document.getElementById('txtBatchQuantity').value = '';
    document.getElementById('hdnBatchList').value = '';
    document.getElementById('divProductDetails').style.display = 'none';
    document.getElementById('txtProduct').focus();
    document.getElementById('txtProduct').value = '';
    document.getElementById('hdbkittype').value='';
    document.getElementById('hdnkitID').value = '';
    document.getElementById('hdnIsKit').value = '';

    document.getElementById('hdntotamount').value = TotalAmt;
    var RefTOT = document.getElementById('hdnTOTReFundAmount').value = parseFloat(TotalAmt);

    document.getElementById('txtBatchNo').disabled = false;
    if (document.getElementById('lblRefundAmt') == "0.00") {
        document.getElementById('lblRefundAmt').innerHTML = RefTOT;
    }
     
    doClearTable();

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
        var pBillingDetailsID = document.getElementById('hdnReceivedID').value;
        var pType = document.getElementById('hdnptype').value;
        var pFinalBillID = document.getElementById('hdnFinalBillId').value;
        var pIsReimbursable = document.getElementById('hdnIsReimbursable').value;
        var pIsCreditBill = document.getElementById('hdnCreditBill').value;


        var kittype = document.getElementById('hdbkittype').value;
        var kitid =document.getElementById('hdnkitID').value;
        var iskit = document.getElementById('hdnIsKit').value;
        var pRecepitNo = document.getElementById('hdnParReceiptId').value;

        document.getElementById('hdnProductList').value = pId + "~" + pName + "~" +
                            pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" +
                            pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" +
                             pBillingDetailsID + "~" + pType + "~" + pFinalBillID + "~" +
                              pIsReimbursable + "~" + pIsCreditBill + "~" + kittype + "~" + kitid + "~" + iskit + "~" + pRecepitNo + "^";


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
    document.getElementById('hdnProBatchNo').value = y[1];
    document.getElementById('hdnReceivedID').value = y[10];
    document.getElementById('hdnptype').value = y[11];
    document.getElementById('hdnFinalBillId').value = y[12];
    document.getElementById('hdnIsReimbursable').value = y[13];
    document.getElementById('hdnCreditBill').value = y[14];
    document.getElementById('hdbkittype').value = y[15];
    document.getElementById('hdnkitID').value = y[16];
    document.getElementById('hdnIsKit').value = y[17];
    document.getElementById('hdnParReceiptId').value = y[18];
    
     

    AutoCompBacthNo();
}

function btnDelete(sEditedData) {
    var i;
    var y = sEditedData.split('~');
    var x = document.getElementById('hdnProductList').value.split("^");
    document.getElementById('hdnProductList').value = '';
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            if (x[i] != sEditedData) {
                document.getElementById('hdnProductList').value += x[i] + "^";
            }



        }


    }
     
    var name = y[11];

    var isReimbursible = y[13];
    var isCreditBill = y[14];

    if (name == "PDC" || (isCreditBill == 'Y' && isReimbursible == 'Y')) {

        var DueAmount = document.getElementById('hdnDueAmount').value;
        // cell8.innerHTML = "Due Item";
        var due = parseFloat(parseFloat(DueAmount) - parseFloat(y[3] * y[7])).toFixed(2);
        if (due > 0) {
            document.getElementById('lblTotalDueAmt').innerHTML = "Total Due Item Refund Amount  :" + due;
        }
        document.getElementById('lblTotalDueAmt').innerHTML = '';
    }
    else {
        var BilledAmount = document.getElementById('hdnBilledAmount').value;
        var bill = parseFloat(parseFloat(BilledAmount) - parseFloat(y[3] * y[7])).toFixed(2);
        bill = isNaN(bill) ? 0 : bill;
        if (bill > 0) {
            document.getElementById('lbldigitalnumber').innerHTML = "Total Billed Item Refund Amount  :" + bill;
        }

        document.getElementById('lbldigitalnumber').innerHTML = '';

    }
    Tblist();

}


function AutoCompBacthNo() {
    var customarray = document.getElementById('hdnProBatchNo').value.split("|");
    actb(document.getElementById('txtBatchNo'), customarray);
}




function checkDetails() {
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


 