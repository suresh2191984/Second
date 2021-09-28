var isfocus = true;
function loadCurrformat() {
    ToTargetFormat($("#txtGross"));
    ToTargetFormat($("#txtDiscount"));
    ToTargetFormat($("#txtNetAmount"));
    ToTargetFormat($("#txtAmountDue"));
    ToTargetFormat($("#txtNonMedical"));
    ToTargetFormat($("#txtCoPayment"));
    ToTargetFormat($("#lblNonMedicalAmt"));
    ToTargetFormat($("#txtExcess"));
   
}


function CheckSurPatient() {
   
//    if (document.getElementById('ChkIsSurgeryPatient').checked == true) {

//        document.getElementById('tbMAkePaymet').style.display = "none";
//        document.getElementById('divpayType').style.display = "none";
//        document.getElementById('tdservice').style.display = "none";
//        document.getElementById('tdamtreceived').style.display = "none";
//        document.getElementById('tdnetamount').style.display = "none";
//        document.getElementById('tdgrss').style.display = "none";
//        document.getElementById('trmedicalAmt').style.display = "none";
//       
//    }
//    else {
//        document.getElementById('tbMAkePaymet').style.display = "block";
//        document.getElementById('divpayType').style.display = "block";
//        document.getElementById('tdservice').style.display = "block";
//        document.getElementById('tdamtreceived').style.display = "block";

//        document.getElementById('tdnetamount').style.display = "block";
//        document.getElementById('tdgrss').style.display = "block";
//        document.getElementById('trmedicalAmt').style.display = "block";
//        document.getElementById('ChkIsSurgeryPatient').visible = false;

    //    }

if(document.getElementById('hdnIsSurgeryPatient').value !='N'){

    if (document.getElementById('ChkIsSurgeryPatient').checked != true) {



        document.getElementById('tbMAkePaymet').style.display = "block";
        document.getElementById('divpayType').style.display = "block";
        document.getElementById('tdservice').style.display = "block";
        document.getElementById('tdamtreceived').style.display = "block";

        document.getElementById('tdnetamount').style.display = "block";
        document.getElementById('tdgrss').style.display = "block";
        document.getElementById('trmedicalAmt').style.display = "block";
        document.getElementById('ChkIsSurgeryPatient').visible = false;
        
      

    }
    else {
        document.getElementById('tbMAkePaymet').style.display = "none";
        document.getElementById('divpayType').style.display = "none";
        document.getElementById('tdservice').style.display = "none";
        document.getElementById('tdamtreceived').style.display = "none";
        document.getElementById('tdnetamount').style.display = "none";
        document.getElementById('tdgrss').style.display = "none";
        document.getElementById('trmedicalAmt').style.display = "none";

    }
    }
}
function CheckProdDetails() {
    
    document.getElementById('btnSave').style.display = 'none';
    if (!CheckProductList()) {
         document.getElementById('txtProduct').focus();
     alert('Provide the product list');
          document.getElementById('btnSave').style.display = 'block';
        return false;

    }
    //var GrandTotal = ToInternalFormat($('##PaymentType_txtTotalAmount'));document.getElementById('txtGross').value == 0.00 ? 0 : document.getElementById('txtGross').value;
    var GrandTotal = ToInternalFormat($('#txtGross')) == 0.00 ? 0 : ToInternalFormat($('#txtGross'));
    if (!InvCreditLimitCheck(GrandTotal)) {
        document.getElementById('btnSave').style.display = 'block';
        alert('Collect Advance or Make Payment');
        return false;
    }
    else {
        return true;
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
                    if (lis[i].split('|')[1].split('~')[2] == xTempP[0] && lis[i].split('|')[0] == xTempP[6] && lis[i].split('~')[4] == xTempP[4] && lis[i].split('~')[5] == xTempP[7] && lis[i].split('~')[8] == xTempP[9] && lis[i].split('~')[18] == xTempP[17]) {
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
            if (CheckTaskItems(pid + "~" + y[0] + "~" + y[2] + "~" + y[4] + "~" + y[5] + "~" + y[8] + "~" + y[18])) {
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
    CheckSurPatient();
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
    
 //   debugger;
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
    document.getElementById('add').focus();
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
                    document.getElementById('hdnTax').value = val[6];
                    document.getElementById('hdnExpiryDate').value = val[8];
                    document.getElementById('hdnHasExpiryDate').value = val[13];
                    document.getElementById('hdnDisorEnhpercent').value = val[14];
                    document.getElementById('hdnDisorEnhType').value = val[15];
                    document.getElementById('hdnRemarks').value = val[16];
                    document.getElementById('hdnIsKitType').value = val[17];
                    document.getElementById('hdnUnitPrice').value = val[18];
                    ToTargetFormat($("#hdnUnitPrice"));
                    ToTargetFormat($("#hdnSellingPrice"));
                    ToTargetFormat($("#hdnDisorEnhpercent"));
                    ToTargetFormat($("#hdnTax"));
                    ToTargetFormat($("#txtBatchQuantity"));
                     
                    
                    
                   document.getElementById('chkIsReimburse').checked = false;
                    if (document.getElementById('hdnIsCreditBill').value == "Y") {
                        document.getElementById('chkIsReimburse').checked = val[12] == "Y" ? true : false;
                    }
//                    else {
//                        document.getElementById('chkIsReimburse').checked = val[12] == "Y" ? true : false;
//                    }
                    
                        
                     
                      document.getElementById('hdnMedSellingPrice').value = val[19];
                      document.getElementById('hdnNonSellingPrice').value = val[20];
                      document.getElementById('hdnActualAmount').value = val[22];
                      ToTargetFormat($("#hdnActualAmount"));
                      ToTargetFormat($("#hdnMedSellingPrice"));
                      ToTargetFormat($("#hdnNonSellingPrice"));
                      document.getElementById('hdnExpiryDateCheck').value = val[23];

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
        var NonmedicalAmt =ToInternalFormat($('#hdnNonMedicalAmt'));// document.getElementById('hdnNonMedicalAmt').value;
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
        //var pQTY = document.getElementById('txtBatchQuantity').value;
        var pQTY = ToInternalFormat($('#txtBatchQuantity'));
        var pBatchNo = document.getElementById('txtBatchNo').value;
        var pQuantity = document.getElementById('txtQuantity').value;
        var pUnit = document.getElementById('txtUnit').value;
        
        //var pSellingPrice = document.getElementById('hdnSellingPrice').value;
        var pSellingPrice = ToInternalFormat($('#hdnSellingPrice'));

        //var pTax = document.getElementById('hdnTax').value;
        var pTax = ToInternalFormat($('#hdnTax'));

        var pExp = document.getElementById('hdnExpiryDate').value;
        var pProBatchNo = document.getElementById('hdnProBatchNo').value;
        var pHasExpiryDate = document.getElementById('hdnHasExpiryDate').value;
        
        //var pActualPrice = document.getElementById('hdnActualAmount').value;
        var pActualPrice = ToInternalFormat($('#hdnActualAmount'));
       
       // var hdnDisorEnhpercent = document.getElementById('hdnDisorEnhpercent').value;
        var hdnDisorEnhpercent = ToInternalFormat($('[id$="hdnDisorEnhpercent"]'));
        
        var hdnDisorEnhType = document.getElementById('hdnDisorEnhType').value;
        var hdnRemarks = document.getElementById('hdnRemarks').value;
        var kit = document.getElementById('hdnIsKitType').value;
        
       // var phdnUnitPrice = document.getElementById('hdnUnitPrice').value;
         var phdnUnitPrice = ToInternalFormat($('#hdnUnitPrice'));
         
        if (document.getElementById('chkIsReimburse') != null)
            var IsReimburse = document.getElementById('chkIsReimburse').checked ? "Yes" : "No";
         
       // var pMedSellingPrice =document.getElementById('hdnMedSellingPrice').value;
     var pMedSellingPrice = ToInternalFormat($('#hdnMedSellingPrice'));
         
        //var pNonSellingPrice = document.getElementById('hdnNonSellingPrice').value;
     var pNonSellingPrice = ToInternalFormat($('#hdnNonSellingPrice'));
         
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
////                    if (isExpired == 1) {
////                        alert("This Item is Alredy Expired");
////                        document.getElementById('txtProduct').value = "";
////                        document.getElementById('divProductDetails').style.display = 'none';
////                        return false;
////                    }
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
//        
        

        document.getElementById('hdnProductList').value += pId + "~" + pName + "~" +
                        pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" +
                        pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" + pProBatchNo + "~"
                        + IsReimburse + "~" + pHasExpiryDate + "~" + hdnDisorEnhpercent + "~" + hdnDisorEnhType
                        + "~" + hdnRemarks + "~" + kit + "~" + phdnUnitPrice + "~" + pMedSellingPrice + "~" + pNonSellingPrice + "~" + pActualPrice + "^";
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
    ToTargetFormat($("#hdnGrandTotal"));
    document.getElementById('txtGrandTotal').value = 0;
    ToTargetFormat($("#txtGrandTotal"));

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
    var cell9 = Headrow.insertCell(8);
    var cell10 = Headrow.insertCell(9);
    var cell11 = Headrow.insertCell(10);
    var cell12 = Headrow.insertCell(11);
    var cell13 = Headrow.insertCell(12);


    cell1.innerHTML = SProductHeaderList.SNo;
    cell2.innerHTML = SProductHeaderList.ProductName;
    cell3.innerHTML = SProductHeaderList.BatchNo;
    cell4.innerHTML = SProductHeaderList.IssuedQty;
    cell5.innerHTML = SProductHeaderList.Unit;
    cell6.innerHTML = SProductHeaderList.SellingPrice;
    cell7.innerHTML = SProductHeaderList.Amount;
    cell8.innerHTML = SProductHeaderList.IsReimbursable;
    cell9.innerHTML = SProductHeaderList.Action;



    //    cell1.innerHTML = "S.No.";
    //    cell2.innerHTML = "Product Name";
    //    cell3.innerHTML = "Batch No";
    //    cell4.innerHTML = "Issued Qty";
    //    cell5.innerHTML = "Unit";
    //    cell6.innerHTML = "Selling Price";
    //    cell7.innerHTML = "Amount";
    //    cell8.innerHTML = "IsReimbursable";
    //    cell9.innerHTML = "Action";
    cell10.innerHTML = "DiscOrEnhancePercent";
    cell11.innerHTML = "DiscOrEnhanceType";
    cell12.innerHTML = "Remarks";
    cell13.innerHTML = "Actual Price";

    cell10.style.display = 'none';
    cell11.style.display = 'none';
    cell12.style.display = 'none';
    cell13.style.display = 'none';
    if (document.getElementById('hdnProductList').value == '') {
        document.getElementById('tdExpiredIndication').style.display = 'none';
    }

    var x = document.getElementById('hdnProductList').value.split("^");
    var pCount = x.length;
    pCount = pCount - 1;
    //if (document.getElementById('lblNonMedicalAmt') != null)
    if (ToInternalFormat($("#lblNonMedicalAmt")) != null)
    document.getElementById('lblNonMedicalAmt').innerHTML = "0.00";
    ToTargetFormat($("#lblNonMedicalAmt"));  
              
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
            var cell9 = row.insertCell(8);
            var cell10 = row.insertCell(9);
            var cell11 = row.insertCell(10);
            var cell12 = row.insertCell(11);
            var cell13 = row.insertCell(12);

            cell1.innerHTML = pCount;
            cell2.innerHTML = y[1];
            cell3.innerHTML = y[2];
            cell4.innerHTML = y[3];
            cell5.innerHTML = y[4];
            cell6.innerHTML = parseFloat(y[7]).toFixed(2);

            if ((y[11] == "Yes") && (y[16] == "Y") && (document.getElementById('hdnIsCreditBill').value == "Y")) {
                cell7.innerHTML = parseFloat(1 * y[18]).toFixed(2);
                tGrandTotal = parseFloat(parseFloat(tGrandTotal) + parseFloat(1 * y[18])).toFixed(2);
            }

            else {
                cell7.innerHTML = parseFloat(y[3] * y[7]).toFixed(2);
                tGrandTotal = parseFloat(parseFloat(tGrandTotal) + parseFloat(y[3] * y[7])).toFixed(2);
            }
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

                //document.getElementById('lblNonMedicalAmt').innerHTML = parseFloat(Number(document.getElementById('lblNonMedicalAmt').innerHTML) + Number(Number(y[3]) * Number(y[7]))).toFixed(2);
                document.getElementById('lblNonMedicalAmt').innerHTML = parseFloat(Number(ToInternalFormat($("#lblNonMedicalAmt"))) + Number(Number(y[3]) * Number(y[7]))).toFixed(2);
                 ToTargetFormat($("#lblNonMedicalAmt"));
            }
            if ((y[11] == "Yes") && (y[16] == "Y") && (document.getElementById('hdnIsCreditBill').value == "Y")) {
                // document.getElementById('lblNonMedicalAmt').innerHTML = parseFloat(Number(document.getElementById('lblNonMedicalAmt').innerHTML) + Number(Number(y[3]) * Number(y[18]))).toFixed(2);
                document.getElementById('lblNonMedicalAmt').innerHTML = parseFloat(Number(ToInternalFormat($("#lblNonMedicalAmt"))) + Number(Number(y[3]) * Number(y[18]))).toFixed(2);
                 ToTargetFormat($("#lblNonMedicalAmt"));
            }
            //            if (document.getElementById('hdnIsCreditBill').value == "Y") {
            //                if (y[16] == "Y") {
            //                    document.getElementById('lblNonMedicalAmt').innerHTML = parseFloat(Number(document.getElementById('lblNonMedicalAmt').innerHTML) + Number(Number(1) * Number(y[18]))).toFixed(2);
            //                }
            //   
            
       

            cell8.innerHTML = y[11];
            var pAction = "";

            pAction = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~"+y[20]+ "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
            if (y[16] == "Y") {
                pAction += "<input tabindex='-1' onblur='divDisplay();'  name='" + y[2] + "~" + y[6] + "'  onclick='GetKitDetails(name);' value = 'Show Kit Details' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />";
                var row1 = document.getElementById('tblOrederedItems').insertRow(2);
                row1.id = "kitRow" + y[6] + y[2];
                row1.style.display = "none";
                row1.style.textAlign = "center";
                row1.style.height = "13px";
                var KitCell = row1.insertCell(0);
                KitCell.id = "kitCell" + y[6] + y[2];
                KitCell.colSpan = 11;

            }
            cell9.innerHTML = pAction;
            cell10.innerHTML = y[13];
            cell11.innerHTML = y[14];
            cell12.innerHTML = y[15];
            cell13.innerHTML = y[20];
            cell10.style.display = 'none';
            cell11.style.display = 'none';
            cell12.style.display = 'none';
            cell13.style.display = 'none';
            if (document.getElementById('hdnTaskBilling').value == 1 && document.getElementById('hdnIsPay').value == "Y") {
                for (var j = 0; j < document.getElementById('tblOrederedItems').rows.length; j++) {
                    var firstRow = document.getElementById("tblOrederedItems").rows[j];
                    var cells = firstRow.cells.length;
                    if (cells >= 9) {
                        firstRow.deleteCell(8);
                    }
                }
            }
        }
        pCount = pCount - 1;
    }
    document.getElementById('hdnProBatchNo').value = '';
    document.getElementById('txtBatchNo').value = '';
    
    document.getElementById('txtBatchQuantity').value = '';
    ToTargetFormat($("#txtBatchQuantity"));
    
    document.getElementById('hdnBatchList').value = '';
    document.getElementById('hdnHasExpiryDate').value = '';
    document.getElementById('hdnExpiryDate').value = '';
    document.getElementById('hdnProBatchNo').value = '';
    document.getElementById('hdnHasExpiryDate').value = '';
    document.getElementById('hdnIsKitType').value = 'N'

    document.getElementById('hdnUnitPrice').value = '';
    ToTargetFormat($("#hdnUnitPrice"));

    document.getElementById('hdnMedSellingPrice').value = '';
    ToTargetFormat($("#hdnMedSellingPrice"));

    document.getElementById('hdnNonSellingPrice').value = '';
    ToTargetFormat($("#hdnNonSellingPrice"));

    document.getElementById('hdnActualAmount').value = '';
    ToTargetFormat($("#hdnActualAmount"));

  
    if (document.getElementById('chkIsReimburse') != null)
    // document.getElementById('chkIsReimburse').checked = true;
        document.getElementById('divProductDetails').style.display = 'none';
    document.getElementById('txtProduct').focus();
    CheckTotal();
    doCalcReimburse();
    ShowExpiryIndication();
}




function ShowExpiryIndication()
{
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
                                if(ShowExpiredIndication==2)
                                {
                                    flag = 1;
                                 }
                                }
                            }
                        }
                }
            }
            if(flag == 1)
            {
            document.getElementById('tdExpiredIndication').style.display='block';
            }
            else{
            document.getElementById('tdExpiredIndication').style.display='none';
            }

}
function GetKitDetails(kitobj) {
    document.getElementById('hndKitID').value = kitobj.split('~')[1]+kitobj.split('~')[0];
    GetKitPrepDetails(kitobj.split('~')[0], kitobj.split('~')[1]);
}
function divDisplay() {
    var kitID = document.getElementById('hndKitID').value;
    var pRow = "kitRow" + kitID;
    document.getElementById(pRow).style.display = "none";
}

function DisplayKitDetails() {
    var kitID = document.getElementById('hndKitID').value;
    var pRow = "kitRow" + kitID;
    var pCell = "kitCell" + kitID;
    var res = document.getElementById('hndKitDetails').value;
    document.getElementById(pRow).style.display = "block";
    document.getElementById(pCell).innerHTML = res;
    document.getElementById('hndKitDetails').value = "";
}


function findExpiryItem(Expiredate, ConfigExpiryDateLevel) {
    var today = new Date();
    var Expdate = new Date(Expiredate);

    var monthdiff = monthDiff(today, Expdate);
    if (monthdiff > 0) {
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

        //var pQTY = document.getElementById('txtBatchQuantity').value; //var pQTY = document.getElementById('txtBatchQuantity').value;
        var pQTY = ToInternalFormat($("#txtBatchQuantity"));
        
        var pBatchNo = document.getElementById('txtBatchNo').value;
        var pQuantity = document.getElementById('txtQuantity').value;
        var pUnit = document.getElementById('txtUnit').value;

        //var pSellingPrice = document.getElementById('hdnSellingPrice').value;
        var pSellingPrice = ToInternalFormat($("#hdnSellingPrice"));

        //var pTax = document.getElementById('hdnTax').value;
        var pTax = ToInternalFormat($("#hdnTax"));
        
        var pExp = document.getElementById('hdnExpiryDate').value;
        var pProBatchNo = document.getElementById('hdnProBatchNo').value;
        var pHasExpiryDate = document.getElementById('hdnHasExpiryDate').value;
        var IsReimburse = document.getElementById('chkIsReimburse').checked ? "Yes" : "No";

        //var hdnDisorEnhpercent = document.getElementById('hdnDisorEnhpercent').value;
        var hdnDisorEnhpercent = ToInternalFormat($("#hdnTax"));
        
        var hdnDisorEnhType = document.getElementById('hdnDisorEnhType').value;
        var hdnRemarks = document.getElementById('hdnRemarks').value;

        //var phdnUnitPrice = document.getElementById('hdnUnitPrice').value;
        var phdnUnitPrice = ToInternalFormat($("#hdnUnitPrice"));
        
       var kit = document.getElementById('hdnIsKitType').value;
       //var pMedSellingPrice = document.getElementById('hdnMedSellingPrice').value;
       var pMedSellingPrice = ToInternalFormat($('#hdnMedSellingPrice'));
        
       //var pNonSellingPrice = document.getElementById('hdnNonSellingPrice').value;
        var pNonSellingPrice = ToInternalFormat($('#hdnNonSellingPrice'));
      // var pActualPrice = document.getElementById('hdnActualAmount').value;
       var pActualPrice = ToInternalFormat($('#hdnActualAmount'));
        
        document.getElementById('hdnProductList').value = pId + "~" + pName + "~" +
                            pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" +
                            pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" + pProBatchNo + "~" +
                            IsReimburse + "~" + pHasExpiryDate + "~" + hdnDisorEnhpercent + "~" + hdnDisorEnhType
                            + "~" + hdnRemarks + "~" + kit + "~" + phdnUnitPrice +"~" + pMedSellingPrice + "~" + pNonSellingPrice +"~"+ pActualPrice + "^";


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
    document.getElementById('txtBatchQuantity').value = (parseFloat(inhandqty[0].TotalStockReceived)).toFixed(2);
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
    //document.getElementById('txtBatchQuantity').value = y[5];
    if (document.getElementById('hdnTaskBilling').value == "1")
        GetStockInHandByStockInHandID(y[6], y[0], 'aa');
    else
        document.getElementById('txtBatchQuantity').value = y[5];
        ToTargetFormat($("#txtBatchQuantity"));
    document.getElementById('hdnProductId').value = y[6];
    document.getElementById('hdnRowEdit').value = sEditedData;
    document.getElementById('add').value = 'Update';
    document.getElementById('divProductDetails').style.display = 'block';
    
    document.getElementById('hdnSellingPrice').value = y[7];
        ToInternalFormat($("#hdnSellingPrice"));
    document.getElementById('hdnTax').value = y[8];
        ToInternalFormat($("#hdnTax"));
    
    
    document.getElementById('hdnExpiryDate').value = y[9];
    document.getElementById('hdnProBatchNo').value = y[10];
    document.getElementById('chkIsReimburse').checked = y[11] == "Yes" ? true : false;
    document.getElementById('hdnHasExpiryDate').value = y[12];
    document.getElementById('hdnDisorEnhpercent').value = y[13];
    document.getElementById('hdnDisorEnhType').value = y[14];
    document.getElementById('hdnRemarks').value = y[15];
    document.getElementById('hdnIsKitType').value = y[16];
    
    document.getElementById('hdnUnitPrice').value = y[17];
    ToInternalFormat($("#hdnUnitPrice"));
    document.getElementById('hdnMedSellingPrice').value = y[18];
    ToInternalFormat($("#hdnMedSellingPrice"));
    document.getElementById('hdnNonSellingPrice').value = y[19];
    ToInternalFormat($("#hdnNonSellingPrice"));
    document.getElementById('hdnActualAmount').value = y[20];
    ToInternalFormat($("#hdnActualAmount"));
           
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
}

function pTotalAmount() {
    var temp = 0.00;
    var vat = 0.00;
    var TotalTemp = 0.00;
    var x = document.getElementById('hdnProductList').value.split("^");
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            var y = x[i].split("~");
            
                if ((y[11] == "Yes") && (y[16] == "Y") && (document.getElementById('hdnIsCreditBill').value == "Y")) {
                    //document.getElementById('lblNonMedicalAmt').innerHTML = parseFloat(Number(document.getElementById('lblNonMedicalAmt').innerHTML) + Number(Number(1) * Number(y[18]))).toFixed(2);
                    TotalTemp = parseFloat(1 * y[18]).toFixed(2);
                    temp = parseFloat(parseFloat(temp) + parseFloat(1 * y[18])).toFixed(2);
                    vat = parseFloat(parseFloat(vat) + parseFloat(TotalTemp) * parseFloat(y[8]) / 100).toFixed(2);

                 }
            else {

                TotalTemp = parseFloat(y[3] * y[7]).toFixed(2);
                temp = parseFloat(parseFloat(temp) + parseFloat(y[3] * y[7])).toFixed(2);
                vat = parseFloat(parseFloat(vat) + parseFloat(TotalTemp) * parseFloat(y[8]) / 100).toFixed(2);
            }
        }
    }
    var subT = parseFloat(parseFloat(temp) - parseFloat(vat)).toFixed(2);
    var vatT = parseFloat(vat).toFixed(2);
    var grossT = parseFloat(temp).toFixed(2);
    document.getElementById('hdnAddedAmount').value = subT + "~" + vatT + "~" + grossT;
    ToInternalFormat($("#hdnAddedAmount"));
    TotalCalculation();
}


function CheckDueTotal() {
   
   // var AmountRecieved = document.getElementById('txtAmountRecieved').value;
   var AmountRecieved = ToInternalFormat($('#txtAmountRecieved'));
   
    //var AmountRecieved = document.getElementById('hdnAmountRecieved').value;
    var AmountRecieved = ToInternalFormat($('#hdnAmountRecieved'));
   // var GrandTotal = document.getElementById('hdnNetAmount').value;
   var GrandTotal = ToInternalFormat($('#hdnNetAmount'));

    //var serviceCharge = document.getElementById('txtServiceCharge').value;
    var serviceCharge = ToInternalFormat($('#txtServiceCharge'));
    GrandTotal = parseFloat(GrandTotal);

    if (parseFloat(GrandTotal) >= parseFloat(AmountRecieved)) {
        //var AmountDue = document.getElementById('txtAmountDue').value = parseFloat(parseFloat(GrandTotal) - parseFloat(AmountRecieved)).toFixed(2);
        // var AmountDue = ToInternalFormat($('#txtAmountDue'))= parseFloat(parseFloat(GrandTotal) - parseFloat(AmountRecieved)).toFixed(2);
        document.getElementById('txtAmountDue').value = parseFloat(parseFloat(GrandTotal) - parseFloat(AmountRecieved)).toFixed(2);
        var AmountDue = ToInternalFormat($('#txtAmountDue'));
       // var AmountDue = document.getElementById('hdnAmountDue').value = parseFloat(parseFloat(GrandTotal) - parseFloat(AmountRecieved)).toFixed(2);
       // var AmountDue = ToInternalFormat($('#hdnAmountDue'))= parseFloat(parseFloat(GrandTotal) - parseFloat(AmountRecieved)).toFixed(2);
        document.getElementById('hdnAmountDue').value = parseFloat(parseFloat(GrandTotal) - parseFloat(AmountRecieved)).toFixed(2);
        var AmountDue = ToInternalFormat($('#hdnAmountDue'));
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
        
        ToTargetFormat($("#txtDiscount"));
        document.getElementById('txtDiscount').readOnly = false;
        ToTargetFormat($("#txtDiscount"));
        document.getElementById('txtDiscountPercent').style.display = 'None';
        CheckTotal();
    }
    else if ((document.getElementById('ddDiscountPercent').value) == '0.00') {
    document.getElementById('txtDiscount').value = parseFloat(0).toFixed(2);
    ToInternalFormat($("#txtDiscount"));
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


    //var tax = document.getElementById('txtTax').value == 0.00 ? 0 : document.getElementById('txtTax').value;
    //var tax = ToInternalFormat($('txtTax')) == 0.00 ? 0 : ToInternalFormat($('txtTax'));

    //var tax = document.getElementById('hdnTtax').value == 0.00 ? 0 : document.getElementById('hdnTtax').value;
    var tax = ToInternalFormat($('#hdnTtax')) == 0.00 ? 0 : ToInternalFormat($('#hdnTtax'));

    if ((document.getElementById('ddDiscountPercent').value) != 'select') {
        if ((document.getElementById('ddDiscountPercent').value) == '0.00') {
           // document.getElementById('txtDiscount').value = parseFloat((parseFloat(document.getElementById('txtGross').value) / 100) * (document.getElementById('txtDiscountPercent').value)).toFixed(2);
            document.getElementById('txtDiscount').value = parseFloat((parseFloat(ToInternalFormat($('#txtGross'))) / 100) * ToInternalFormat($('#txtDiscountPercent'))).toFixed(2);
            ToTargetFormat($('#txtDiscount'));
            
            //document.getElementById('txtDiscountPercent').visible = true;
            document.getElementById('txtDiscountPercent').style.display = 'Block';
        }
        else {
           // document.getElementById('txtDiscount').value = parseFloat((parseFloat(document.getElementById('txtGross').value) / 100) * (document.getElementById('ddDiscountPercent').value)).toFixed(2);
            
            document.getElementById('txtDiscount').value = parseFloat((parseFloat(ToInternalFormat($('#txtGross'))) / 100) * ToInternalFormat($('#ddDiscountPercent'))).toFixed(2);
            ToTargetFormat($('#txtDiscount'));
        }
        document.getElementById('txtDiscount').readOnly = true;
    }

    else {
        document.getElementById('txtDiscount').readOnly = false;
    }

    //var Discount = document.getElementById('txtDiscount').value == 0.00 ? 0 : document.getElementById('txtDiscount').value;
    var Discount = ToInternalFormat($('#txtDiscount')) == 0.00 ? 0 : ToInternalFormat($('#txtDiscount'));
    

    //var GrandTotal = document.getElementById('txtGross').value == 0.00 ? 0 : document.getElementById('txtGross').value;
    var GrandTotal = ToInternalFormat($('#txtGross')) == 0.00 ? 0 : ToInternalFormat($('#txtGross'));
    
    //var GrandTotal = document.getElementById('hdnGross').value == 0.00 ? 0 : document.getElementById('hdnGross').value;
    var GrandTotal = ToInternalFormat($('#hdnGross')) == 0.00 ? 0 : ToInternalFormat($('#hdnGross'));
    

    //var PreviousDue = document.getElementById('txtDue').value == 0.00 ? 0 : document.getElementById('txtDue').value;
    var PreviousDue = ToInternalFormat($('#txtDue')) == 0.00 ? 0 : ToInternalFormat($('#txtDue'));
    
    Total = parseFloat(parseFloat(GrandTotal) - parseFloat(Discount)).toFixed(2);
  //  var nonmedicalamt = document.getElementById('lblNonMedicalAmt').innerText == 0.00 ? 0 : document.getElementById('lblNonMedicalAmt').innerText;
    var nonmedicalamt = ToInternalFormat($('#lblNonMedicalAmt')) == 0.00 ? 0 : ToInternalFormat($('#lblNonMedicalAmt'));
    
    if (Total < 0) {
        alert('Discount Amount should not exceed total amount')
        document.getElementById('txtDiscountPercent').value = 0.00;
        document.getElementById('txtDiscount').value = 0.00;
        //var Discount = document.getElementById('txtDiscount').value == 0.00 ? 0 : document.getElementById('txtDiscount').value;
        var Discount = ToInternalFormat($('#txtDiscount')) == 0.00 ? 0 : ToInternalFormat($('#txtDiscount'));
        
        

       // var GrandTotal = document.getElementById('txtGross').value == 0.00 ? 0 : document.getElementById('txtGross').value;
        var GrandTotal = ToInternalFormat($('#txtGross')) == 0.00 ? 0 : ToInternalFormat($('#txtGross'));
       
//        var GrandTotal = document.getElementById('hdnGross').value == 0.00 ? 0 : document.getElementById('hdnGross').value;
        var GrandTotal =  ToInternalFormat($('#hdnGross')) == 0.00 ? 0 : ToInternalFormat($('#hdnGross'));


       // var PreviousDue = document.getElementById('txtDue').value == 0.00 ? 0 : document.getElementById('txtDue').value;
        var PreviousDue = ToInternalFormat($('#txtDue')) == 0.00 ? 0 : ToInternalFormat($('#txtDue'));
        

        Total = parseFloat(parseFloat(GrandTotal) - parseFloat(Discount)).toFixed(2);
    }

    tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(2);
    document.getElementById('txtNetAmount').value = getOPCustomRoundoff(parseFloat(parseFloat(Total) + parseFloat(PreviousDue)).toFixed(2));
    ToTargetFormat($("#txtNetAmount"));
    document.getElementById('hdnNetAmount').value = getOPCustomRoundoff(parseFloat(parseFloat(Total) + parseFloat(PreviousDue)).toFixed(2));
    ToTargetFormat($("#hdnNetAmount"));
    document.getElementById('PaymentType_txtAmount').value =getOPCustomRoundoff( parseFloat(nonmedicalamt).toFixed(2));
    ToTargetFormat($("#PaymentType_txtAmount"));
    document.getElementById('hdnNonMedicalAmt1').value = getOPCustomRoundoff(parseFloat(nonmedicalamt).toFixed(2)); 
    ToTargetFormat($("#hdnNonMedicalAmt1"));
    //document.getElementById('PaymentType_txtAmount').value = parseFloat(parseFloat(Total) + parseFloat(PreviousDue)).toFixed(2);
    if (document.getElementById('hdnUseDeposit').value == "N") {
        //document.getElementById('PaymentType_txtAmount').value = parseFloat(parseFloat(Total) + parseFloat(PreviousDue)).toFixed(2);
        document.getElementById('PaymentType_txtAmount').value = getOPCustomRoundoff(parseFloat(nonmedicalamt).toFixed(2));
        ToTargetFormat($("#PaymentType_txtAmount"));
    }
    changeAmountValues();

    //CheckDueTotal();
}
function DueCal() {
    var tempTaxAmt;
    var Total;
    
    //var tax = document.getElementById('txtTax').value == 0.00 ? 0 : document.getElementById('txtTax').value;
    var tax = ToInternalFormat($('#txtTax')) == 0.00 ? 0 : ToInternalFormat($('#txtTax'));
    
    //var tax = document.getElementById('hdnTtax').value == 0.00 ? 0 : document.getElementById('hdnTtax').value;
    var tax =  ToInternalFormat($('#hdnTtax')) == 0.00 ? 0 : ToInternalFormat($('#hdnTtax'));
    

    //var Discount = document.getElementById('txtDiscount').value == 0.00 ? 0 : document.getElementById('txtDiscount').value;
    var Discount = ToInternalFormat($('#txtDiscount')) == 0.00 ? 0 : ToInternalFormat($('#txtDiscount'));
    
    //var GrandTotal = document.getElementById('txtNetAmount').value == 0.00 ? 0 : document.getElementById('txtNetAmount').value;
    var GrandTotal = ToInternalFormat($('#txtNetAmount')) == 0.00 ? 0 : ToInternalFormat($('#txtNetAmount'));
    
    //    var GrandTotal = document.getElementById('hdnNetAmount').value == 0.00 ? 0 : document.getElementById('hdnNetAmount').value;
    var PreviousDue = document.getElementById('txtDue').value == 0.00 ? 0 : document.getElementById('txtDue').value;

    document.getElementById('txtDiscount').value = parseFloat(Discount).toFixed(2);
    
      ToTargetFormat($("#txtDiscount"));
      Total = parseFloat(parseFloat(GrandTotal) - parseFloat(Discount)).toFixed(2);
    
    tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(2);
    document.getElementById('txtNetAmount').value = parseFloat(parseFloat(Total) + parseFloat(PreviousDue)).toFixed(2);
     ToTargetFormat($("#txtNetAmount"));
    document.getElementById('hdnNetAmount').value = parseFloat(parseFloat(Total) + parseFloat(PreviousDue)).toFixed(2);
     ToTargetFormat($("#hdnNetAmount"));

    //CheckDueTotal();

}

function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {


    var ConValue = "OtherCurrencyDisplay1";

    var sVal = getOtherCurrAmtValues("REC", ConValue);
    var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
    var tempService = getOtherCurrAmtValues("SER", ConValue);
    var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
    sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
    sVal = format_number(Number(sVal) + Number(TotalAmount), 4);
    if (PaymentAmount > 0) {

        if (Number(sNetValue) >= Number(sVal)) {
            sVal = format_number(sVal, 2);
            SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
            var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);

            document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2);
            ToTargetFormat($("#txtServiceCharge"));



            var amtRec = ToInternalFormat($('#hdnDepositUsed'));//document.getElementById('hdnDepositUsed').value;
            amtRec = 0;
            document.getElementById('hdnAmountRecieved').value = format_number(Number(amtRec) + Number(pAmt), 2);
              ToTargetFormat($("#hdnAmountRecieved"));
            
            document.getElementById('txtAmountRecieved').value = format_number(Number(amtRec) + Number(pAmt), 2);
              ToTargetFormat($("#txtAmountRecieved"));

            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);


            document.getElementById('txtNetAmount').value = format_number(Number(pTotal), 2);
             ToTargetFormat($("#txtNetAmount"));
            document.getElementById('hdnNetAmount').value = format_number(Number(pTotal), 2);
             ToTargetFormat($("#hdnNetAmount"));
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

    //    var sVal = document.getElementById('txtAmountRecieved').value;
    //    var sVal = document.getElementById('hdnAmountRecieved').value;

    //    var sNetValue = document.getElementById('txtNetAmount').value;
    //    var sNetValue = document.getElementById('hdnNetAmount').value;

    //    var tempService = document.getElementById('txtServiceCharge').value;

    //    ServiceCharge = (parseFloat(ServiceCharge) * parseFloat(PaymentAmount) / 100);

    //    sNetValue = format_number(parseFloat(sNetValue) + parseFloat(ServiceCharge), 2);
    //    sVal = format_number(parseFloat(sVal) + parseFloat(TotalAmount), 2);

    //    if (parseFloat(sNetValue) >= parseFloat(sVal)) {
    //        sVal = format_number(sVal, 2);
    //        document.getElementById('txtServiceCharge').value = format_number(parseFloat(ServiceCharge) + parseFloat(tempService), 2);
    //        document.getElementById('txtAmountRecieved').value = sVal;
    //        document.getElementById('hdnAmountRecieved').value = sVal;
    //        document.getElementById('txtNetAmount').value = parseFloat(sNetValue).toFixed(2);
    //        document.getElementById('hdnNetAmount').value = parseFloat(sNetValue).toFixed(2);
    //        CheckDueTotal();
    //        return true;
    //    }
    //    else {
    //                alert('Amount provided is greater than net amount');
    //        return false;
    //    }

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
    ToTargetFormat($("#txtServiceCharge"));
    
    var amtRec = ToInternalFormat($('#ucCreditLimit_hdnCreditLimt'));//document.getElementById('hdnDepositUsed').value;
    amtRec = 0;
    document.getElementById('hdnAmountRecieved').value = format_number(Number(sVal) + Number(amtRec), 2);
    ToTargetFormat($("#hdnAmountRecieved"));
    
    document.getElementById('txtAmountRecieved').value = format_number(Number(sVal) + Number(amtRec), 2);
      ToTargetFormat($("#txtAmountRecieved"));

    //    document.getElementById('hdnAmountRecieved').value = format_number(sVal, 2);
    //    document.getElementById('txtAmountRecieved').value = format_number(sVal, 2);


    // totalCalculate();


    SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);

    var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

    document.getElementById('txtNetAmount').value = format_number(Number(pTotal), 2);
    ToTargetFormat($("#txtNetAmount"));
    document.getElementById('hdnNetAmount').value = format_number(Number(pTotal), 2);
    ToTargetFormat($("#hdnNetAmount"));
    CheckDueTotal();
    //    var sVal = document.getElementById('txtAmountRecieved').value;
    //    var sVal = document.getElementById('hdnAmountRecieved').value;
    //    sVal = format_number(parseFloat(sVal) - parseFloat(TotalAmount), 2);
    //    var tempService = document.getElementById('txtServiceCharge').value;
    //    ServiceCharge = (parseFloat(ServiceCharge) * parseFloat(PaymentAmount) / 100);

    //    document.getElementById('txtServiceCharge').value = format_number(parseFloat(tempService) - parseFloat(ServiceCharge), 2);

    //    document.getElementById('txtAmountRecieved').value = sVal;
    //    document.getElementById('hdnAmountRecieved').value = sVal;
    //    var sNetValue = document.getElementById('txtNetAmount').value;
    //    var sNetValue = document.getElementById('hdnNetAmount').value;
    //    document.getElementById('txtNetAmount').value = parseFloat(parseFloat(sNetValue) - parseFloat(ServiceCharge)).toFixed();
    //    document.getElementById('hdnNetAmount').value = parseFloat(parseFloat(sNetValue) - parseFloat(ServiceCharge)).toFixed();
    doCalcReimburse();
}

function chkCreditPament() {
    document.getElementById('chkisCreditTransaction').checked = false;
}

function checkIsCredit() {
    if (document.getElementById('chkisCreditTransaction').checked == true) {
        document.getElementById('txtAmountRecieved').value = '0.00';
        ToTargetFormat($("#txtAmountRecieved"));
        document.getElementById('hdnAmountRecieved').value = '0.00';
        ToTargetFormat($("#hdnAmountRecieved"));
        document.getElementById('hdnTotalAmtRec').value = '0.00';
        ToTargetFormat($("#hdnTotalAmtRec"));
        document.getElementById('txtAmountRecieved').disabled = true;
        ToTargetFormat($("#txtAmountRecieved"));
        document.getElementById('divpayType').disabled = true;
        document.getElementById('PaymentType_txtAmount').value = 0;
        ToTargetFormat($("#PaymentType_txtAmount"));
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
function addEvent(obj, event_name, func_name) {
    if (obj.attachEvent) {
        obj.attachEvent("on" + event_name, func_name);
    } else if (obj.addEventListener) {
        obj.addEventListener(event_name, func_name, true);
    } else {
        obj["on" + event_name] = func_name;
    }
}
function removeEvent(obj, event_name, func_name) {
    if (obj.detachEvent) {
        obj.detachEvent("on" + event_name, func_name);
    } else if (obj.removeEventListener) {
        obj.removeEventListener(event_name, func_name, true);
    } else {
        obj["on" + event_name] = null;
    }
}
function stopEvent(evt) {
    evt || window.event;
    if (evt.stopPropagation) {
        evt.stopPropagation();
        evt.preventDefault();
    } else if (typeof evt.cancelBubble != "undefined") {
        evt.cancelBubble = true;
        evt.returnValue = false;
    }
    return false;
}
function getElement(evt) {
    if (window.event) {
        return window.event.srcElement;
    } else {
        return evt.currentTarget;
    }
}
function getTargetElement(evt) {
    if (window.event) {
        return window.event.srcElement;
    } else {
        return evt.target;
    }
}
function stopSelect(obj) {
    if (typeof obj.onselectstart != 'undefined') {
        addEvent(obj, "selectstart", function() { return false; });
    }
}
function getCaretEnd(obj) {
    if (typeof obj.selectionEnd != "undefined") {
        return obj.selectionEnd;
    } else if (document.selection && document.selection.createRange) {
        var M = document.selection.createRange();
        try {
            var Lp = M.duplicate();
            Lp.moveToElementText(obj);
        } catch (e) {
            var Lp = obj.createTextRange();
        }
        Lp.setEndPoint("EndToEnd", M);
        var rb = Lp.text.length;
        if (rb > obj.value.length) {
            return -1;
        }
        return rb;
    }
}
function getCaretStart(obj) {
    if (typeof obj.selectionStart != "undefined") {
        return obj.selectionStart;
    } else if (document.selection && document.selection.createRange) {
        var M = document.selection.createRange();
        try {
            var Lp = M.duplicate();
            Lp.moveToElementText(obj);
        } catch (e) {
            var Lp = obj.createTextRange();
        }
        Lp.setEndPoint("EndToStart", M);
        var rb = Lp.text.length;
        if (rb > obj.value.length) {
            return -1;
        }
        return rb;
    }
}
function setCaret(obj, l) {
    obj.focus();
    if (obj.setSelectionRange) {
        obj.setSelectionRange(l, l);
    } else if (obj.createTextRange) {
        m = obj.createTextRange();
        m.moveStart('character', l);
        m.collapse();
        m.select();
    }
}
function setSelection(obj, s, e) {
    obj.focus();
    if (obj.setSelectionRange) {
        obj.setSelectionRange(s, e);
    } else if (obj.createTextRange) {
        m = obj.createTextRange();
        m.moveStart('character', s);
        m.moveEnd('character', e);
        m.select();
    }
}
String.prototype.addslashes = function() {
    return this.replace(/(["\\\.\|\[\]\^\*\+\?\$\(\)])/g, '\\$1');
}
String.prototype.trim = function() {
    return this.replace(/^\s*(\S*(\s+\S+)*)\s*$/, "$1");
};
function curTop(obj) {
    toreturn = 0;
    while (obj) {
        toreturn += obj.offsetTop;
        obj = obj.offsetParent;
    }
    return toreturn;
}
function curLeft(obj) {
    toreturn = 0;
    while (obj) {
        toreturn += obj.offsetLeft;
        obj = obj.offsetParent;
    }
    return toreturn;
}
function isNumber(a) {
    return typeof a == 'number' && isFinite(a);
}
function replaceHTML(obj, text) {
    while (el = obj.childNodes[0]) {
        obj.removeChild(el);
    };
    obj.appendChild(document.createTextNode(text));
}

function actb(obj, ca) {
    /* ---- Public Variables ---- */
    this.actb_timeOut = -1; // Autocomplete Timeout in ms (-1: autocomplete never time out)
    this.actb_lim = 4;    // Number of elements autocomplete can show (-1: no limit)
    this.actb_firstText = false; // should the auto complete be limited to the beginning of keyword?
    this.actb_mouse = true; // Enable Mouse Support
    this.actb_delimiter = new Array(';', ',');  // Delimiter for multiple autocomplete. Set it to empty array for single autocomplete
    this.actb_startcheck = 1; // Show widget only after this number of characters is typed in.
    /* ---- Public Variables ---- */

    /* --- Styles --- */
    this.actb_bgColor = '#888888';
    this.actb_fwidth = '93px';
    this.actb_textColor = '#FFFFFF';
    this.actb_hColor = '#000000';
    this.actb_fFamily = 'Verdana';
    this.actb_fSize = '11px';
    this.actb_hStyle = 'text-decoration:underline;font-weight="bold"';
    /* --- Styles --- */

    /* ---- Private Variables ---- */
    var actb_delimwords = new Array();
    var actb_cdelimword = 0;
    var actb_delimchar = new Array();
    var actb_display = false;
    var actb_pos = 0;
    var actb_total = 0;
    var actb_curr = null;
    var actb_rangeu = 0;
    var actb_ranged = 0;
    var actb_bool = new Array();
    var actb_pre = 0;
    var actb_toid;
    var actb_tomake = false;
    var actb_getpre = "";
    var actb_mouse_on_list = 1;
    var actb_kwcount = 0;
    var actb_caretmove = false;
    this.actb_keywords = new Array();
    /* ---- Private Variables---- */

    this.actb_keywords = ca;
    var actb_self = this;

    actb_curr = obj;

    addEvent(actb_curr, "focus", actb_setup);
    function actb_setup() {
        addEvent(document, "keydown", actb_checkkey);
        addEvent(actb_curr, "blur", actb_clear);
        addEvent(document, "keypress", actb_keypress);
    }

    function actb_clear(evt) {
        if (!evt) evt = event;
        removeEvent(document, "keydown", actb_checkkey);
        removeEvent(actb_curr, "blur", actb_clear);
        removeEvent(document, "keypress", actb_keypress);
        actb_removedisp();
    }
    function actb_parse(n) {
        if (actb_self.actb_delimiter.length > 0) {
            var t = actb_delimwords[actb_cdelimword].trim().addslashes();
            var plen = actb_delimwords[actb_cdelimword].trim().length;
        } else {
            var t = actb_curr.value.addslashes();
            var plen = actb_curr.value.length;
        }
        var tobuild = '';
        var i;

        if (actb_self.actb_firstText) {
            var re = new RegExp("^" + t, "i");
        } else {
            var re = new RegExp(t, "i");
        }
        var p = n.search(re);

        for (i = 0; i < p; i++) {
            tobuild += n.substr(i, 1);
        }
        tobuild += "<font style='" + (actb_self.actb_hStyle) + "'>"
        for (i = p; i < plen + p; i++) {
            tobuild += n.substr(i, 1);
        }
        tobuild += "</font>";
        for (i = plen + p; i < n.length; i++) {
            tobuild += n.substr(i, 1);
        }
        return tobuild;
    }
    function actb_generate() {

        if (document.getElementById('tat_table')) { actb_display = false; document.body.removeChild(document.getElementById('tat_table')); }
        if (actb_kwcount == 0) {
            actb_display = false;
            return;
        }
        a = document.createElement('table');
        a.cellSpacing = '1px';
        a.cellPadding = '2px';
        a.style.position = 'absolute';
        a.style.top = eval(curTop(actb_curr) + actb_curr.offsetHeight) + "px";
        a.style.left = curLeft(actb_curr) + "px";
        a.style.backgroundColor = actb_self.actb_bgColor;
        a.style.width = actb_self.actb_fwidth;
        a.id = 'tat_table';
        document.body.appendChild(a);
        if (actb_curr.value.length > 1) {
            document.getElementById('tat_table').style.display = 'block';
        }
        if (actb_curr.value.length < 1) {
            document.getElementById('tat_table').style.display = 'none';
            return;
        }


        var i;
        var first = true;
        var j = 1;
        if (actb_self.actb_mouse) {
            a.onmouseout = actb_table_unfocus;
            a.onmouseover = actb_table_focus;
        }
        var counter = 0;
        for (i = 0; i < actb_self.actb_keywords.length; i++) {
            if (actb_bool[i]) {
                counter++;
                r = a.insertRow(-1);
                if (first && !actb_tomake) {
                    r.style.backgroundColor = actb_self.actb_hColor;
                    first = false;
                    actb_pos = counter;
                } else if (actb_pre == i) {
                    r.style.backgroundColor = actb_self.actb_hColor;
                    first = false;
                    actb_pos = counter;
                } else {
                    r.style.backgroundColor = actb_self.actb_bgColor;
                    r.style.width = actb_self.actb_fwidth;
                }
                r.id = 'tat_tr' + (j);
                c = r.insertCell(-1);
                c.style.color = actb_self.actb_textColor;
                c.style.fontFamily = actb_self.actb_fFamily;
                c.style.fontSize = actb_self.actb_fSize;
                c.innerHTML = actb_parse(actb_self.actb_keywords[i]);
                c.id = 'tat_td' + (j);
                c.setAttribute('pos', j);
                if (actb_self.actb_mouse) {
                    c.style.cursor = 'pointer';
                    c.onclick = actb_mouseclick;
                    c.onmouseover = actb_table_highlight;
                }
                j++;
            }
            if (j - 1 == actb_self.actb_lim && j < actb_total) {
                r = a.insertRow(-1);
                r.style.backgroundColor = actb_self.actb_bgColor;
                r.style.width = actb_self.actb_fwidth;
                c = r.insertCell(-1);
                c.style.color = actb_self.actb_textColor;
                c.style.fontFamily = 'arial narrow';
                c.style.fontSize = actb_self.actb_fSize;
                c.align = 'center';
                replaceHTML(c, '\\/');
                if (actb_self.actb_mouse) {
                    c.style.cursor = 'pointer';
                    c.onclick = actb_mouse_down;
                }
                break;
            }
        }
        actb_rangeu = 1;
        actb_ranged = j - 1;
        actb_display = true;
        if (actb_pos <= 0) actb_pos = 1;
    }
    function actb_remake() {
        document.body.removeChild(document.getElementById('tat_table'));
        a = document.createElement('table');
        a.cellSpacing = '1px';
        a.cellPadding = '2px';
        a.style.position = 'absolute';
        a.style.top = eval(curTop(actb_curr) + actb_curr.offsetHeight) + "px";
        a.style.left = curLeft(actb_curr) + "px";
        a.style.backgroundColor = actb_self.actb_bgColor;
        a.style.width = actb_self.actb_fwidth;
        a.id = 'tat_table';
        if (actb_self.actb_mouse) {
            a.onmouseout = actb_table_unfocus;
            a.onmouseover = actb_table_focus;
        }
        document.body.appendChild(a);
        var i;
        var first = true;
        var j = 1;
        if (actb_rangeu > 1) {
            r = a.insertRow(-1);
            r.style.backgroundColor = actb_self.actb_bgColor;
            r.style.width = actb_self.actb_fwidth;
            c = r.insertCell(-1);
            c.style.color = actb_self.actb_textColor;
            c.style.fontFamily = 'arial narrow';
            c.style.fontSize = actb_self.actb_fSize;
            c.align = 'center';
            replaceHTML(c, '/\\');
            if (actb_self.actb_mouse) {
                c.style.cursor = 'pointer';
                c.onclick = actb_mouse_up;
            }
        }
        for (i = 0; i < actb_self.actb_keywords.length; i++) {
            if (actb_bool[i]) {
                if (j >= actb_rangeu && j <= actb_ranged) {
                    r = a.insertRow(-1);
                    r.style.backgroundColor = actb_self.actb_bgColor;
                    r.style.width = actb_self.actb_fwidth;
                    r.id = 'tat_tr' + (j);
                    c = r.insertCell(-1);
                    c.style.color = actb_self.actb_textColor;
                    c.style.fontFamily = actb_self.actb_fFamily;
                    c.style.fontSize = actb_self.actb_fSize;
                    c.innerHTML = actb_parse(actb_self.actb_keywords[i]);
                    c.id = 'tat_td' + (j);
                    c.setAttribute('pos', j);
                    if (actb_self.actb_mouse) {
                        c.style.cursor = 'pointer';
                        c.onclick = actb_mouseclick;
                        c.onmouseover = actb_table_highlight;
                    }
                    j++;
                } else {
                    j++;
                }
            }
            if (j > actb_ranged) break;
        }
        if (j - 1 < actb_total) {
            r = a.insertRow(-1);
            r.style.backgroundColor = actb_self.actb_bgColor;
            r.style.width = actb_self.actb_fwidth;
            c = r.insertCell(-1);
            c.style.color = actb_self.actb_textColor;
            c.style.fontFamily = 'arial narrow';
            c.style.fontSize = actb_self.actb_fSize;
            c.align = 'center';
            replaceHTML(c, '\\/');
            if (actb_self.actb_mouse) {
                c.style.cursor = 'pointer';
                c.onclick = actb_mouse_down;
            }
        }
    }
    function actb_goup() {
        if (!actb_display) return;
        if (actb_pos == 1) return;
        document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
        document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;
        actb_pos--;
        if (actb_pos < actb_rangeu) actb_moveup();
        document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
        if (actb_toid) clearTimeout(actb_toid);
        if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
    }
    function actb_godown() {
        if (!actb_display) return;
        if (actb_pos == actb_total) return;
        document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
        document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;

        actb_pos++;
        if (actb_pos > actb_ranged) actb_movedown();
        document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
        if (actb_toid) clearTimeout(actb_toid);
        if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
    }
    function actb_movedown() {
        actb_rangeu++;
        actb_ranged++;
        actb_remake();
    }
    function actb_moveup() {
        actb_rangeu--;
        actb_ranged--;
        actb_remake();
    }

    /* Mouse */
    function actb_mouse_down() {
        document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
        document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;

        actb_pos++;
        actb_movedown();
        document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
        actb_curr.focus();
        actb_mouse_on_list = 0;
        if (actb_toid) clearTimeout(actb_toid);
        if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
    }
    function actb_mouse_up(evt) {
        if (!evt) evt = event;
        if (evt.stopPropagation) {
            evt.stopPropagation();
        } else {
            evt.cancelBubble = true;
        }
        document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
        document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;

        actb_pos--;
        actb_moveup();
        document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
        actb_curr.focus();
        actb_mouse_on_list = 0;
        if (actb_toid) clearTimeout(actb_toid);
        if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
    }
    function actb_mouseclick(evt) {
        if (!evt) evt = event;
        if (!actb_display) return;
        actb_mouse_on_list = 0;
        actb_pos = this.getAttribute('pos');
        actb_penter();
    }
    function actb_table_focus() {
        actb_mouse_on_list = 1;
    }
    function actb_table_unfocus() {
        actb_mouse_on_list = 0;
        if (actb_toid) clearTimeout(actb_toid);
        if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
    }
    function actb_table_highlight() {
        actb_mouse_on_list = 1;
        document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
        document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;

        actb_pos = this.getAttribute('pos');
        while (actb_pos < actb_rangeu) actb_moveup();
        while (actb_pos > actb_ranged) actb_movedown();
        document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
        if (actb_toid) clearTimeout(actb_toid);
        if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
    }
    /* ---- */

    function actb_insertword(a) {
        if (actb_self.actb_delimiter.length > 0) {
            str = '';
            l = 0;
            for (i = 0; i < actb_delimwords.length; i++) {
                if (actb_cdelimword == i) {
                    prespace = postspace = '';
                    gotbreak = false;
                    for (j = 0; j < actb_delimwords[i].length; ++j) {
                        if (actb_delimwords[i].charAt(j) != ' ') {
                            gotbreak = true;
                            break;
                        }
                        prespace += ' ';
                    }
                    for (j = actb_delimwords[i].length - 1; j >= 0; --j) {
                        if (actb_delimwords[i].charAt(j) != ' ') break;
                        postspace += ' ';
                    }
                    str += prespace;
                    str += a;
                    l = str.length;
                    if (gotbreak) str += postspace;
                } else {
                    str += actb_delimwords[i];
                }
                if (i != actb_delimwords.length - 1) {
                    str += actb_delimchar[i];
                }
            }
            actb_curr.value = str;
            setCaret(actb_curr, l);
        } else {
            actb_curr.value = a;
        }
        actb_mouse_on_list = 0;
        actb_removedisp();
    }
    function actb_penter() {
        if (!actb_display) return;
        actb_display = false;
        var word = '';
        var c = 0;
        for (var i = 0; i <= actb_self.actb_keywords.length; i++) {
            if (actb_bool[i]) c++;
            if (c == actb_pos) {
                word = actb_self.actb_keywords[i];
                break;
            }
        }
        actb_insertword(word);
        l = getCaretStart(actb_curr);
    }
    function actb_removedisp() {
        if (actb_mouse_on_list == 0) {
            actb_display = 0;
            if (document.getElementById('tat_table')) { document.body.removeChild(document.getElementById('tat_table')); }
            if (actb_toid) clearTimeout(actb_toid);
        }
    }
    function actb_keypress(e) {
        if (actb_caretmove) stopEvent(e);
        return !actb_caretmove;
    }
    function actb_checkkey(evt) {


        if (!evt) evt = event;
        a = evt.keyCode;
        caret_pos_start = getCaretStart(actb_curr);
        actb_caretmove = 0;
        switch (a) {
            case 38:
                actb_goup();
                actb_caretmove = 1;
                return false;
                break;
            case 40:
                actb_godown();
                actb_caretmove = 1;
                return false;
                break;
            case 13: case 9:
                if (actb_display) {
                    actb_caretmove = 1;
                    actb_penter();
                    return false;
                } else {
                    return true;
                }
                break;
            default:
                setTimeout(function() { actb_tocomplete(a) }, 50);
                break;
        }
    }

    function actb_tocomplete(kc) {

        if (kc == 38 || kc == 40 || kc == 13) return;
        var i;
        if (actb_display) {
            var word = 0;
            var c = 0;
            for (var i = 0; i <= actb_self.actb_keywords.length; i++) {
                if (actb_bool[i]) c++;
                if (c == actb_pos) {
                    word = i;
                    break;
                }
            }
            actb_pre = word;
        } else { actb_pre = -1 };

        if (actb_curr.value == '') {
            actb_mouse_on_list = 0;
            actb_removedisp();
            return;
        }
        if (actb_self.actb_delimiter.length > 0) {
            caret_pos_start = getCaretStart(actb_curr);
            caret_pos_end = getCaretEnd(actb_curr);

            delim_split = '';
            for (i = 0; i < actb_self.actb_delimiter.length; i++) {
                delim_split += actb_self.actb_delimiter[i];
            }
            delim_split = delim_split.addslashes();
            delim_split_rx = new RegExp("([" + delim_split + "])");
            c = 0;
            actb_delimwords = new Array();
            actb_delimwords[0] = '';

            for (i = 0, j = actb_curr.value.length; i < actb_curr.value.length; i++, j--) {
                if (actb_curr.value.substr(i, j).search(delim_split_rx) == 0) {
                    ma = actb_curr.value.substr(i, j).match(delim_split_rx);
                    actb_delimchar[c] = ma[1];
                    c++;
                    actb_delimwords[c] = '';
                } else {
                    actb_delimwords[c] += actb_curr.value.charAt(i);
                }
            }

            var l = 0;
            actb_cdelimword = -1;
            for (i = 0; i < actb_delimwords.length; i++) {
                if (caret_pos_end >= l && caret_pos_end <= l + actb_delimwords[i].length) {
                    actb_cdelimword = i;
                }
                l += actb_delimwords[i].length + 1;
            }
            var ot = actb_delimwords[actb_cdelimword].trim();
            var t = actb_delimwords[actb_cdelimword].addslashes().trim();
        } else {
            var ot = actb_curr.value;
            var t = actb_curr.value.addslashes();
        }
        if (ot.length == 0) {
            actb_mouse_on_list = 0;
            actb_removedisp();
        }
        if (ot.length < actb_self.actb_startcheck) return this;
        if (actb_self.actb_firstText) {
            var re = new RegExp("^" + t, "i");
        } else {
            var re = new RegExp(t, "i");
        }

        actb_total = 0;
        actb_tomake = false;
        actb_kwcount = 0;
        for (i = 0; i < actb_self.actb_keywords.length; i++) {
            actb_bool[i] = false;
            if (re.test(actb_self.actb_keywords[i])) {
                actb_total++;
                actb_bool[i] = true;
                actb_kwcount++;
                if (actb_pre == i) actb_tomake = true;
            }
        }

        if (actb_toid) clearTimeout(actb_toid);
        if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
        actb_generate();
    }
    return this;
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


    var alte = PaymentSaveValidation();
    if (alte == true) {
        var AmtRecieved = ToInternalFormat($('#txtAmountRecieved')); //document.getElementById('txtAmountRecieved').value;
        var AmtNet = ToInternalFormat($('#txtNetAmount')); // document.getElementById('txtNetAmount').value;
        var isCreditLimitForOrg = document.getElementById('hdnOrgCreditLimt').value;
        if (isCreditLimitForOrg == "Y") {
            var TotalCashandCreditLimitinHand = -1;
            TotalCashandCreditLimitinHand = getCashInHand();
            TotalCashandCreditLimitinHand = Number(TotalCashandCreditLimitinHand) + Number(AmtRecieved);
            if (Number(TotalCashandCreditLimitinHand) < Number(AmtNet)) {
                var mustCollectAmt = parseFloat(Number(AmtNet) - Number(TotalCashandCreditLimitinHand)).toFixed(2);
                alert('You should Collect Rs. ' + mustCollectAmt);
                return false;
            }
        }
        if (document.getElementById('btnConsumable').value == "Generate Task") {
            var pBill = confirm("Task has been Generated");
            if (pBill != true) {
                return false;
            }
        }
        else {
            if (Number(AmtNet) > (Number(AmtRecieved))) {
                var pBill = confirm("This bill amount will be added to due.\nDo you want to continue");
                if (pBill != true) {
                    return false;
                }
            }

            else {
                var pBill = confirm("Please confirm if this amount has been received");
                if (pBill != true) {
                    return false;
                }
            }
        }
        document.getElementById('hdnTotalAmtRec').value = AmtRecieved;
        ToTargetFormat($("#hdnTotalAmtRec"));
        document.getElementById('btnConsumable').style.display = 'none';
        return true;
    }
    else {
        return false;
    }
    if (document.getElementById('hdnType').value == "OP") {
        var Client = document.getElementById('ddlClients').options[document.getElementById('ddlClients').selectedIndex].text.toUpperCase();
        if (document.getElementById('hdnpatientID').value == "-1") {
            if (document.getElementById('hdnIsCreditBill').value == "N") {
                if (Client == "GENERAL") {
                    //if (parseFloat(document.getElementById('hdnAmountDue').value).toFixed(2) != 0.00) {
                    if (parseFloat(ToInternalFormat($('#hdnAmountDue'))).toFixed(2) != 0.00) { 
                        alert('Collect the due amount');
                        document.getElementById('PaymentType_txtAmount').focus();
                        document.getElementById('btnConsumable').style.display = 'block';
                        return false;
                    }
                }
            }
            if (Client == "GENERAL" && document.getElementById('hdnIsCreditBill').value == "Y") {
                if (parseFloat(ToInternalFormat($('#hdnAmountDue'))).toFixed(2) != 0.00) {
                    alert('Collect the due amount');
                    document.getElementById('PaymentType_txtAmount').focus();
                    document.getElementById('btnConsumable').style.display = 'block';
                    return false;
                }
            }
        }
    }
    //    if (document.getElementById('hdnType').value == "IP") {
    //        if (parseFloat(document.getElementById('hdnAmountDue').value).toFixed(2) != 0.00) {
    //                alert('Collect the due amount');
    //            document.getElementById('PaymentType_txtAmount').focus();
    //            document.getElementById('btnConsumable').style.display = 'block';
    //            return false;
    //        }
    //    }

    return true;
}

function openPOPup(url) {
    PaymentControlclear();

    ClearOtherCurrValues("OtherCurrencyDisplay1");
    SetReceivedOtherCurr(0, 0, "OtherCurrencyDisplay1");

    if (typeof unCheckDepositUsage == 'function') {
        unCheckDepositUsage();
        document.getElementById('txtAmountRecieved').value = 0;
        ToTargetFormat($("#txtAmountRecieved"));
    }
    document.getElementById("hdnprint").click();
    document.getElementById('PaymentType_ddlPaymentType').value = 1;
   // ToTargetFormat($("#PaymentType_ddlPaymentType"));
    
}
function DuePupupClear() {
    PaymentControlclear();
    ClearOtherCurrValues("OtherCurrencyDisplay1");
    document.getElementById('PaymentType_ddlPaymentType').value = 1;
    document.getElementById('btnSave').style.display = 'block';
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
                      ToTargetFormat($("#T_Amount"));
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
                    ToTargetFormat($("#T_AblQty"));
                    document.getElementById("T_IssQty" + tProID).disabled = false;
                    document.getElementById("T_Bacth" + tProID).disabled = false;
                    document.getElementById("T_Unit" + tProID).value = y[3];
                    document.getElementById("T_SellPrice" + tProID).value = y[4];
                    document.getElementById("T_Amount" + tProID).value = '0.00'
                      ToTargetFormat($("#T_Amount"));
                    document.getElementById("T_IssQty" + tProID).value = '';
                    document.getElementById("T_IssQty" + tProID).focus();
                    break;
                }
                else {
                    document.getElementById("T_AblQty" + tProID).value = '0.00'
                    ToTargetFormat($("#T_AblQty"));
                    document.getElementById("T_IssQty" + tProID).value = '0'
                    
                    document.getElementById("T_IssQty" + tProID).disabled = true;
                    document.getElementById("T_Unit" + tProID).value = '--'
                    document.getElementById("T_SellPrice" + tProID).value = '0.00'
                    ToTargetFormat($("#T_SellPrice"));
                    document.getElementById("T_Amount" + tProID).value = '0.00'
                    ToTargetFormat($("#T_Amount"));
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
                    ToTargetFormat($("#T_AblQty"));
                    
                    document.getElementById("T_IssQty" + tProID).disabled = false;
                    document.getElementById("T_Bacth" + tProID).disabled = false;
                    document.getElementById("T_Unit" + tProID).value = y[3];
                    document.getElementById("T_SellPrice" + tProID).value = y[4];
                    ToTargetFormat($("#T_SellPrice"));
                    
                    document.getElementById("T_Amount" + tProID).value = '0.00'
                    ToTargetFormat($("#T_Amount"));
                    document.getElementById("T_IssQty" + tProID).value = '';
                    document.getElementById("T_IssQty" + tProID).focus();
                    TaskAddedListItem(y[0] + "~" + y[1] + "~" + y[7], "Added"); break;
                }


            } else {
                document.getElementById("T_Bacth" + tProID).value = '--'
                document.getElementById("T_Bacth" + tProID).disabled = true;
                document.getElementById("T_AblQty" + tProID).value = '0.00'
                ToTargetFormat($("#T_AblQty"));
                
                document.getElementById("T_IssQty" + tProID).value = '0'
                document.getElementById("T_IssQty" + tProID).disabled = true;
                document.getElementById("T_Unit" + tProID).value = '--'
                document.getElementById("T_SellPrice" + tProID).value = '0.00'
                ToTargetFormat($("#T_SellPrice"));
                
                document.getElementById("T_Amount" + tProID).value = '0.00'
                ToTargetFormat($("#T_Amount"));
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
    document.getElementById('hdnGrandTotal').value = parseFloat(parseFloat(AddedAmt[2]) + parseFloat(TaskAmt[2])).toFixed(2);
    ToTargetFormat($("#hdnGrandTotal"));
    document.getElementById('txtGrandTotal').value = getOPCustomRoundoff(parseFloat(parseFloat(AddedAmt[2]) + parseFloat(TaskAmt[2])).toFixed(2));
       ToTargetFormat($("#txtGrandTotal"));
    document.getElementById('txtSubTotal').value = getOPCustomRoundoff(parseFloat(parseFloat(AddedAmt[0]) + parseFloat(TaskAmt[0])).toFixed(2));
    ToTargetFormat($("#txtSubTotal"));
    document.getElementById('txtTax').value = parseFloat(parseFloat(AddedAmt[1]) + parseFloat(TaskAmt[1])).toFixed(2);
    ToTargetFormat($("#txtTax"));
    
    document.getElementById('hdnTtax').value = parseFloat(parseFloat(AddedAmt[1]) + parseFloat(TaskAmt[1])).toFixed(2);
    ToTargetFormat($("#hdnTtax"));
    
    document.getElementById('txtGross').value =getOPCustomRoundoff( parseFloat(parseFloat(AddedAmt[2]) + parseFloat(TaskAmt[2])).toFixed(2));
    ToTargetFormat($("#txtGross"));
    
    document.getElementById('hdnGross').value = parseFloat(parseFloat(AddedAmt[2]) + parseFloat(TaskAmt[2])).toFixed(2);
    ToTargetFormat($("#hdnGross"));
    
    Getdigitalnumber(document.getElementById('lbldigitalnumber'),getOPCustomRoundoff( parseFloat(parseFloat(AddedAmt[2]) + parseFloat(TaskAmt[2])).toFixed(2)));
    
   document.getElementById('lblNonMedicalAmt').innerHTML = getOPCustomRoundoff(parseFloat(document.getElementById('lblNonMedicalAmt').innerHTML).toFixed(2));
    //document.getElementById('lblNonMedicalAmt').innerHTML = getOPCustomRoundoff(parseFloat(ToInternalFormat($('#lblNonMedicalAmt'))).toFixed(2));

    ToTargetFormat($("#lblNonMedicalAmt"));
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

    var Tooltips = '<table border="0"><tr><td>Name</td><td>:</td><td align="left">' + tName + '</td></tr>';
    Tooltips += '<tr><td>Patient No</td><td>:</td> <td align="left">' + tNum + '</td> </tr>';
    Tooltips += '<tr><td>IP No</td><td>:</td> <td align="left">' + IPNumber + '</td> </tr>';
    Tooltips += '<tr><td>DOB</td><td>:</td> <td align="left">' + DOB + '</td> </tr>';
    Tooltips += '<tr><td>Age</td><td>:</td> <td align="left">' + tAge + '</td> </tr>';
    Tooltips += '<tr><td>Sex</td><td>:</td> <td align="left">' + tSex + '</td> </tr>';
    Tooltips += '<tr><td>Address</td><td>:</td> <td align="left">' + tAdd1 + '</td> </tr>';
    Tooltips += '<tr><td>City</td><td>:</td> <td align="left">' + City + '</td> </tr>';
    Tooltips += '<tr><td>Phone No</td><td>:</td> <td align="left">' + TPNumber + '</td> </tr>';
    Tooltips += '<tr><td>Visit Purpose</td><td>:</td> <td align="left">' + tPOAName + '</td> </tr> </table>';
    dhelp.innerHTML = Tooltips;

}

function onChangeItem() {

    var dhelp = document.getElementById('dvHelp');
    dhelp.innerHTML = '';
    document.getElementById('txtPhysicianName').focus();

}


function ClearPatientDetails() {
    document.getElementById('txtAddress').value = "";
    document.getElementById('txtPhysicianName').value = "";
    document.getElementById('txtConsumedBy').readOnly = false;
    document.getElementById('txtPatientNo').readOnly = false;
    document.getElementById('ddSalutation').disabled = false;
    document.getElementById('divisCredit').style.display = "none";
    document.getElementById('txtSmartCardNo').readOnly = false;
    document.getElementById('txtSmartCardNo').value = "";
    document.getElementById('txtPatientNo').value = "";
    document.getElementById('ddSalutation').options[0].selected = true;
    unCheckDepositUsage();
    showHideUsageTab();
}

function doCalcReimburse() {

    var hdnNonMedical = 0;
    var txtServiceCharge =ToInternalFormat($('#txtServiceCharge'));// document.getElementById("txtServiceCharge");
    var txtGrandTotal =ToInternalFormat($('#txtGrandTotal'));// document.getElementById("txtGrandTotal");
    var txtAmountRecieved =ToInternalFormat($('#txtAmountRecieved'));// document.getElementById("txtAmountRecieved");
    //
    var txtNonMedical =ToInternalFormat($('#txtNonMedical'));// document.getElementById("txtNonMedical");
    var txtCoPayment =ToInternalFormat($('#txtCoPayment'));// document.getElementById("txtCoPayment");
    var txtExcess = ToInternalFormat($('#txtExcess'));//document.getElementById("txtExcess");

    var pPreAuthAmount = 0;
    //pro
    // alert("");
    //if (document.getElementById('lblNonMedicalAmt') != null)
   if( ToInternalFormat($('#lblNonMedicalAmt'))!=null)
   
        var NonReimburseAmt = Number(ToInternalFormat($('#hdnDefaultRoundoff')));//document.getElementById("lblNonMedicalAmt").innerHTML);

    var AmtRecd = Number(txtAmountRecieved.value);

    var TpaPaidAmt = 0;

    pPreAuthAmount = TpaPaidAmt > 0 ? pPreAuthAmount - TpaPaidAmt : pPreAuthAmount;

//    if (NonReimburseAmt > 0 && NonReimburseAmt <= AmtRecd) {
//        txtNonMedical.value = parseFloat(NonReimburseAmt).toFixed(2);
//        txtCoPayment.value = parseFloat(AmtRecd - NonReimburseAmt).toFixed(2);

//        if (Number(txtCoPayment.value) > Number(pPreAuthAmount)) {
//            txtExcess.value = parseFloat(Number(txtCoPayment.value) - Number(pPreAuthAmount)).toFixed(2);
//            txtCoPayment.value = Number(pPreAuthAmount).toFixed(2);
//        } else {
//            txtExcess.value = (0).toFixed(2);
//        }

//    } else if (NonReimburseAmt > 0 && NonReimburseAmt > AmtRecd) {

//        txtNonMedical.value = parseFloat(AmtRecd).toFixed(2);
//        txtCoPayment.value = (0).toFixed(2);
//        txtExcess.value = (0).toFixed(2);

//    } else if (NonReimburseAmt == 0) {

//        txtCoPayment.value = parseFloat(AmtRecd).toFixed(2);
//        txtNonMedical.value = (0).toFixed(2);
//        if (Number(txtCoPayment.value) > Number(pPreAuthAmount)) {
//            txtExcess.value = parseFloat(Number(txtCoPayment.value) - Number(pPreAuthAmount)).toFixed(2);
//            txtCoPayment.value = Number(pPreAuthAmount).toFixed(2);
//        } else {
//            txtExcess.value = (0).toFixed(2);
//        }
//    }

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
    var txtCoPayment = ToInternalFormat($('#txtCoPayment'));//document.getElementById("txtCoPayment");
    var txtExcess =ToInternalFormat($('#txtExcess')); //document.getElementById("txtExcess");
    var hdnCoPayment =ToInternalFormat($('#hdnCoPayment'));// document.getElementById("hdnCoPayment");

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
    var hdnCoPayment = ToInternalFormat($('#hdnCoPayment'));//document.getElementById("hdnCoPayment");
    var txtCoPayment = ToInternalFormat($('#txtCoPayment'));//document.getElementById("txtCoPayment");
    getPrecision(txtCoPayment);
    hdnCoPayment.value = txtCoPayment.value;
}

function getOPCustomRoundoff(netRound) {
   var DefaultRound = ToInternalFormat($('#hdnDefaultRoundoff'));
   // var DefaultRound = document.getElementById('hdnDefaultRoundoff').value;
    var RoundType =document.getElementById('hdnRoundOffType').value;
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
