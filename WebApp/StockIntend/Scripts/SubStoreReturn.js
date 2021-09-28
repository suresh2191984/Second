var lstProductList = [];

function GetLocationlist() {
    var errorMsg = SListForAppMsg.Get("StockIntend_Error") == null ? "Error" : SListForAppMsg.Get("StockIntend_Error");
    if (document.getElementById('ddlStockReturnType').value == '0') {
        var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_01") == null ? "Select StockReturn Type" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_01");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('ddlStockReturnType').focus();
       // var ddl = document.getElementById('ddlTrustedOrg');
      
        document.getElementById('ddlTrustedOrg').value = 0;
        
        
        return false;
    }
    var drpOrgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
    var options = document.getElementById('hdnlocation').value;
    var ddlLocation = document.getElementById('ddlLocation');
    var ddlUser = document.getElementById('ddlUser');
    var userList = document.getElementById('hdnUserlist').value;

    ddlUser.options.length = 0;
    ddlLocation.options.length = 0;

    var optn2 = document.createElement("option");
    ddlLocation.options.add(optn2);
    var ddlselect = SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_01") == null ? "Select" : SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_01");
    optn2.text = ddlselect;
    optn2.value = "0";
    var optn1 = document.createElement("option");
    ddlUser.options.add(optn1);
    optn1.text = ddlselect;
    optn1.value = "0";

    var list = options.split('^');
    for (i = 0; i < list.length; i++) {
        if (list[i] != "") {
            var res = list[i].split('~');



            if (drpOrgid == res[0]) {
                var optn = document.createElement("option");
                ddlLocation.options.add(optn);
                optn.text = res[2];
                optn.value = res[1];
            }

        }
    }
    Getuserlist();
}

function checkExpDate(obj) {
    var myValStr = document.getElementById(obj).value;
    var TodayDate = GetServerDate();
    var DayFormat = TodayDate.format("MM/dd/yyyy");
    var TodayYear = DayFormat.split('/')[2];
    var Todaymonth = DayFormat.split('/')[0];
    var errorMsg = SListForAppMsg.Get("StockIntend_Error") == null ? "Error" : SListForAppMsg.Get("StockIntend_Error");
    if (myValStr != "__/____" && myValStr != "") {
        var Mon = myValStr.split('/')[0];
        var pyyyy = myValStr.split('/')[1];
        var GetDiff = Number(pyyyy) - Number(TodayYear)
        var GetMonthDiff = Number(Mon) - Number(Todaymonth)
        var isTrue = false;
        var myMonth = new Array('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12');
        for (i = 0; i < myMonth.length; i++) {
            if (myMonth[i] != "" && Mon != "" && Mon == myMonth[i] && Mon.length == 2) {
                isTrue = true;
            }
        }
        if (GetDiff < 0) {
            isTrue = false;
        }
        else if (GetDiff == 0 && GetMonthDiff < 0) {
            isTrue = false;
        }
        if (!isTrue) {
            document.getElementById(obj).focus();
            var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_02") == null ? "Provide valid date" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_02");
 ValidationWindow(userMsg, errorMsg);
             return isTrue;
        }

        var pdate = Mon + pyyyy;
        var pdatelen = pdate.length;
        for (j = 0; j < pdatelen; j++) {
            if (pdate.charAt(j) == "_") {
                document.getElementById(obj).focus();
                var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_02") == null ? "Provide valid date" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_02");
 ValidationWindow(userMsg, errorMsg);
                    return false;
                }
            }
        }
    }
    //Arun
    //}
//end
function Getuserlist() {

    var drpOrgid1 = document.getElementById('ddlTrustedOrg').value;
    var ddlUser = document.getElementById('ddlUser');
    var userList = document.getElementById('hdnUserlist').value;
    var uselist = userList.split('^');
    for (i = 0; i < uselist.length; i++) {
        if (uselist[i] != "") {
            if (uselist[i].split('~')[2] == Number(drpOrgid1)) {
                res1 = uselist[i].split('~');
                if (drpOrgid1 == res1[2]) {
                    var optnuserlist = document.createElement("option");
                    ddlUser.options.add(optnuserlist);
                    optnuserlist.text = res1[0];
                    optnuserlist.value = res1[1];
                }
            }
        }



    }


}



function CheckProdDetails() {
var errorMsg = SListForAppMsg.Get("StockIntend_Error") == null ? "Error" : SListForAppMsg.Get("StockIntend_Error");
    if (!CheckProductList()) {
        var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_03") == null ? "Provide the product list" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_03");
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
    var lstArray = JSON.parse(eventArgs.get_value());
    var lis = lstArray[0];
   /* var isTrue = true;
    $.each(lstArray, function (obj, value) {
        if (isTrue == true) {
            var arrF = $.grep(lstProductList, function (n, i) {
                return n.ReceivedUniqueNumber == value.ReceivedUniqueNumber;
            });
            if (arrF.length > 0) {
                isTrue = false;
            }
        }
    });
    if (isTrue) {
        document.getElementById('hdnBatchList').value = JSON.stringify(lstArray);
        document.getElementById('hdnProductId').value = lis.ProductID;
    }*/
    
    var isTrue = true;
        var arrF = new Object();
        var arrX = [];
        var arrY = [];
        
        $.each(lstArray, function (obj, value) {
                arrF = $.grep(lstProductList, function (n, i) {
                    if (value.StockReceivedBarcodeID > 0 && value.IsUniqueBarcode.trim() == 'Y') {
                        return (n.ReceivedUniqueNumber == value.ReceivedUniqueNumber && n.StockReceivedBarcodeDetailsID == value.StockReceivedBarcodeDetailsID)
                    }
                    else {
                        return n.ReceivedUniqueNumber == value.ReceivedUniqueNumber
                    }
                });
                if (arrF.length > 0) {
                    $.merge(arrY,arrF);
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
            jQuery.grep(pid, function(el) {
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
        $.each(x, function (obj, value) {
            if (CheckTaskItems(pid + "~" + value.BatchNo + "~" + value.StockInHandID)) {
                document.getElementById('hdnProBatchNo').value += value.BatchNo + "@#$" + value.StockInHandID + "|";
                $('#divProductDetails').removeClass().addClass('show');
                if (lstArray.length > 0) {
                    if (isAddItem == 0) {
                        document.getElementById('hdnReceivedID').value = value.StockInHandID;
                        $('#hdnAddFlag').val('N');
                        BindQuantity();
                        isAddItem = 1;
                    }
                }
            }

        });

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
var errorMsg = SListForAppMsg.Get("StockIntend_Error") == null ? "Error" : SListForAppMsg.Get("StockIntend_Error");
var ddlselect = SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_01") == null ? "Select" : SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_01");
    var ddlaction = document.getElementById('ddlUser');
    if (ddlaction.options[ddlaction.selectedIndex].text == ddlselect) {
        var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_04") == null ? "Select The Issued Location And  Received By" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_04");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
}


function pSetAddFocus() {
    var qty = document.getElementById('txtQuantity').value.trim();
}


function BindQuantity() {
    var blnExists = false;
    var BatchNoList = [];
    if ($('#hdnBatchList').val() != '') {
        BatchNoList = JSON.parse($('#hdnBatchList').val());
    };
    if (document.getElementById('hdnReceivedID').value > 0) {
        var lsttempArrary = $.grep(BatchNoList, function (n, i) {
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
            document.getElementById('hdnUnitPrice').value = tempobject.CostPrice;
            document.getElementById('hdnParentProductID').value = tempobject.ParentProductID;
            document.getElementById('txtreturnstock').value = tempobject.SubstoreReturnqty;
            document.getElementById('hdnPdtRcvdDtlsID').value = tempobject.ProductReceivedDetailsID;
	    document.getElementById('hdnReceivedUniqueNumber').value = tempobject.ReceivedUniqueNumber;
            $("#hdnStockReceivedBarcodeDetailsID").val(tempobject.StockReceivedBarcodeDetailsID);
            $("#hdnBarcodeNo").val(tempobject.BarcodeNo);
            if (tempobject.SubstoreReturnqty < 1) {
                $('#tdreturnstock').hide();
                $('#tdlblreturnstock').hide();
            }
            else {
                $('#tdreturnstock').show();
                $('#tdlblreturnstock').show();
            }
            var pCell = document.getElementById('hdnReceivedID').value;
            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').rows[j].style.backgroundColor = "";
                if ("tr_par" + pCell == document.getElementById('tbllist').rows[j].id) {
                    document.getElementById('tbllist').rows[j].style.backgroundColor = '#DCFC5C';
                }

            }
            blnExists = true;
        }
        if (blnExists == false) {
            document.getElementById('txtUnit').value = '';
            document.getElementById('txtBatchQuantity').value = '';
            document.getElementById('txtBatchNo').value = '';
            return false;
        }
    }
}
function checkIsEmpty() {
var errorMsg = SListForAppMsg.Get("StockIntend_Error") == null ? "Error" : SListForAppMsg.Get("StockIntend_Error");
var updateBtn = SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_02") == null ? "Update" : SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_02");
    if (document.getElementById('txtBatchNo').value.trim() == "") {
        var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_05") == null ? "Provide the batch number" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_05");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtBatchNo').focus();
        return false;
    }

    if (document.getElementById('txtQuantity').value == "") {
        var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_06") == null ? "Provide issue quantity" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_06");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }
    if (Number(document.getElementById('txtBatchQuantity').value) < Number(document.getElementById('txtQuantity').value)) {
        var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_07") == null ? "Ensure the items added/quantity are provided properly" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_07");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }

    if (Number(document.getElementById('txtQuantity').value) < 1) {
        var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_07") == null ? "Ensure the items added/quantity are provided properly" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_07");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }
    //Arun
    var remqty = document.getElementById('txtBatchQuantity').value - document.getElementById('txtreturnstock').value;
    var qty = document.getElementById('txtreturnstock').value;
    if (Number(document.getElementById('txtreturnstock').value) > (Number(document.getElementById('txtBatchQuantity').value) - Number(document.getElementById('txtQuantity').value))) {
        var usermsg1 = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_26") == null ? "This product have return sub store stock" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_26");
        var usermsg2 = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_27") == null ? "You can use remaining stock" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_27");
        var userMsg = usermsg1 + qty + usermsg2 + remqty + '.00';
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').value = "";
        document.getElementById('txtQuantity').focus();
        return false;
    }
    //end
    if (document.getElementById('add').value != updateBtn) {
        var x = document.getElementById('hdnProductList').value.split("^");
        var pId = document.getElementById('hdnReceivedID').value;
        var pName = document.getElementById('hdnProductName').value;

        var y; var i;
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
                if (y[0] == pId) {
                    var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_08") == null ? "Product number and batch number combination already exist" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_08");
 ValidationWindow(userMsg, errorMsg);
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
    var updateBtn = SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_02") == null ? "Update" : SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_02");
    if (document.getElementById('add').value == updateBtn) {
        var editData = JSON.parse($('#hdnRowEdit').val());
        if (editData != "") {
            var arrF = $.grep(lstProductList, function (n, i) {
                return n.ReceivedUniqueNumber != editData.ReceivedUniqueNumber;
            });
            lstProductList = [];
            lstProductList = arrF;
        }
    }
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
        var pParentProductID = document.getElementById('hdnParentProductID').value;
        var pPdtRcvddtlsID = document.getElementById('hdnPdtRcvdDtlsID').value;
        var pReceivedUniqueNumber = document.getElementById('hdnReceivedUniqueNumber').value;
         var pReturnstock = document.getElementById('txtreturnstock').value
        var pStockReceivedBarcodeDetailsID = $("#hdnStockReceivedBarcodeDetailsID").val();
        var pBarcodeNo = $("#hdnBarcodeNo").val();
        if (pHasExpiryDate == "Y") {
            var expirylevel = document.getElementById('hdnExpiryDateLevel').value == 'Y' ? 1 : 0//; Number(document.getElementById('hdnExpiryDateLevel').value);
            if (expirylevel != '' && expirylevel != null) {
                if (expirylevel > 0) {
                    var isExpired = findExpiryItem(new Date(parseInt(pExp.substr(6))), expirylevel);
                    if (isExpired == 2) {
                        var errorMsg = SListForAppMsg.Get("StockIntend_Error") == null ? "Error" : SListForAppMsg.Get("StockIntend_Error");
                        var informMsg = SListForAppMsg.Get("StockIntend_Information") == null ? "Information" : SListForAppMsg.Get("StockIntend_Information");
                        var okMsg = SListForAppMsg.Get("StockIntend_Ok") == null ? "Ok" : SListForAppMsg.Get("StockIntend_Ok")
                        var cancelMsg = SListForAppMsg.Get("StockIntend_Cancel") == null ? "Cancel" : SListForAppMsg.Get("StockIntend_Cancel");
                        var userMsg = SListForAppMsg.Get("InventoryScripts_SubStoreReturn_js_15") == null ? "This Item Will be Expired with in " + expirylevel + " Months. Do you want to continue!Click 'OK'": SListForAppMsg.Get("InventoryScripts_SubStoreReturn_js_15");
                        userMsg = userMsg.replace("{0}", expirylevel)
                        var Replay = ConfirmWindow(userMsg,informMsg,okMsg,cancelMsg);
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

        var objProduct = new Object();
        objProduct.ID = pId;
        objProduct.ProductName = pName;
        objProduct.BatchNo = pBatchNo;
        objProduct.InHandQuantity = pQTY;
        objProduct.Quantity = pQuantity;
        objProduct.Unit = pUnit;
        objProduct.ProductID = pProductId;
        objProduct.ParentProductID = pParentProductID;
        objProduct.Rate = pSellingPrice;
        objProduct.Tax = parseFloat(pTax);
        var Flag = $('#hdnAddFlag').val();
        if (Flag == 'Y') {
            objProduct.ExpiryDate = pExp;
        }
        else {
            objProduct.ExpiryDate = new Date(parseInt(pExp.substr(6)));
        }
        objProduct.HasBatchNo = pProBatchNo;
        objProduct.HasExpiryDate = pHasExpiryDate;
        objProduct.UnitPrice = parseFloat(pUnitPrice);
        objProduct.ProductReceivedDetailsID = pPdtRcvddtlsID;
        objProduct.ReceivedUniqueNumber = pReceivedUniqueNumber;
        objProduct.SubstoreReturnqty = pReturnstock;
        objProduct.StockReceivedBarcodeDetailsID = pStockReceivedBarcodeDetailsID;
        objProduct.BarcodeNo = pBarcodeNo;  
        lstProductList.push(objProduct);
        $('#hdnProductList').val(JSON.stringify(lstProductList));

        Tblist();
        document.getElementById('txtQuantity').value = '';
        document.getElementById('txtUnit').value = '';
        $('#hdnAddFlag').val('N');

    var addBtn = SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_10") == null ? "Add" : SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_10");
    document.getElementById('add').value = addBtn;
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
    Headrow.className = "gridHeader"
    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    var cell5 = Headrow.insertCell(4);
    var cell6 = Headrow.insertCell(5);
    var cell7 = Headrow.insertCell(6);
    var ProductName = SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_03") == null ? "Product Name" : SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_03");
    var BatchNo = SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_04") == null ? "Batch No" : SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_04");
    var IssuedQty = SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_05") == null ? "Issued Qty" : SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_05");
    var Unit = SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_06") == null ? "Unit" : SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_06");
    var SellingPrice = SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_07") == null ? "Selling Price" : SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_07");
    var Amount = SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_08") == null ? "Amount" : SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_08");
    var Action = SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_09") == null ? "Action" : SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_09");

    cell1.innerHTML = ProductName;
    cell2.innerHTML = BatchNo;
    cell3.innerHTML = IssuedQty;
    cell4.innerHTML = Unit;
    cell5.innerHTML = SellingPrice;
    cell6.innerHTML = Amount;
    cell7.innerHTML = Action;

    if (document.getElementById('lblNonMedicalAmt') != null)
        document.getElementById('lblNonMedicalAmt').innerHTML = "0.00";
    var tGrandTotal = 0.00;

    $.each(lstProductList, function (obj, value) {
        var row = document.getElementById('tblOrederedItems').insertRow(1);

        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var cell5 = row.insertCell(4);
        var cell6 = row.insertCell(5);
        var cell7 = row.insertCell(6);


        cell1.innerHTML = value.ProductName;
        cell2.innerHTML = value.BatchNo;
        cell3.innerHTML = value.Quantity;
        cell4.innerHTML = value.Unit;
        cell5.innerHTML = parseFloat(value.Rate).toFixed(2);
        cell6.innerHTML = parseFloat(value.Quantity * value.Rate).toFixed(2);
        tGrandTotal = parseFloat(parseFloat(tGrandTotal) + parseFloat(value.Quantity * value.Rate)).toFixed(2);
        var expirylevel = document.getElementById('hdnExpiryDateLevel').value == 'Y' ? 1 : 0; 
        if (value.HasExpiryDate == "Y") {
            if (expirylevel != '' && expirylevel != null) {
                if (expirylevel > 0) {
                    var isExpired = findExpiryItem(value.ExpiryDate, expirylevel);
                    if (isExpired == 2) {
                        row.style.backgroundColor = "Orange";
                    }
                }
            }
        }
        cell7.innerHTML = "<input name='Edit' onclick='btnEdit_OnClick(" + JSON.stringify(value) + ");' value = '' type='button' class='ui-icon ui-icon-pencil pull-left'  /> " +
                           "<input name='Delete' onclick='btnDelete(" + JSON.stringify(value) + ");' value = '' type='button' class='ui-icon ui-icon-trash pull-left' />"

    });

    document.getElementById('hdnProBatchNo').value = '';
    document.getElementById('txtBatchNo').value = '';
    document.getElementById('txtBatchQuantity').value = '';
    document.getElementById('hdnBatchList').value = '';
    document.getElementById('hdnHasExpiryDate').value = '';
    document.getElementById('divProductDetails').style.display = 'none';
    document.getElementById('txtProduct').focus();
    document.getElementById('hdnProductName').value = '';
    document.getElementById('txtBatchNo').disabled = false;
    document.getElementById('hdnParentProductID').value = '';
    document.getElementById('hdnPdtRcvdDtlsID').value = '';
    document.getElementById('hdnReceivedUniqueNumber').value = '';
    $("#hdnStockReceivedBarcodeDetailsID").val('0');
    $("#hdnBarcodeNo").val('');

}

function findExpiryItem(Expiredate, ConfigExpiryDateLevel) {
    var today = GetServerDate();
    var Expdate = new Date(Expiredate);

    var monthdiff = monthDiff(today, Expdate);
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

function btnEdit_OnClick(sEditedData) {

    var updateBtn = SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_02") == null ? "Update" : SListForAppDisplay.Get("StockIntend_Scripts_SubStoreReturn_js_02");
    document.getElementById('hdnReceivedID').value = sEditedData.ID;
    document.getElementById('hdnProductName').value = sEditedData.ProductName;
    document.getElementById('txtProduct').value = sEditedData.ProductName;
    document.getElementById('txtBatchNo').disabled = true;
    document.getElementById('txtBatchNo').value = sEditedData.BatchNo;
    document.getElementById('txtQuantity').value = sEditedData.Quantity;
    document.getElementById('txtUnit').value = sEditedData.Unit;
    document.getElementById('txtBatchQuantity').value = sEditedData.InHandQuantity;
    document.getElementById('hdnProductId').value = sEditedData.ProductID;
    document.getElementById('hdnRowEdit').value = JSON.stringify(sEditedData);
    document.getElementById('add').value = updateBtn;
    document.getElementById('divProductDetails').style.display = 'block';
    document.getElementById('hdnSellingPrice').value = sEditedData.Rate;
    document.getElementById('hdnTax').value = sEditedData.Tax;
    document.getElementById('hdnExpiryDate').value = sEditedData.ExpiryDate;
    document.getElementById('hdnProBatchNo').value = sEditedData.HasBatchNo;
    document.getElementById('hdnHasExpiryDate').value = sEditedData.HasExpiryDate;
    document.getElementById('hdnUnitPrice').value = sEditedData.UnitPrice;
    document.getElementById('hdnParentProductID').value = sEditedData.ParentProductID;
    document.getElementById('hdnPdtRcvdDtlsID').value = sEditedData.ProductReceivedDetailsID;
    document.getElementById('hdnReceivedUniqueNumber').value = sEditedData.ReceivedUniqueNumber;
    $('#hdnAddFlag').val('Y');
    AutoCompBacthNo();
}

function btnDelete(sEditedData) {

    var arrF = $.grep(lstProductList, function (n, i) {
    return n.ReceivedUniqueNumber != sEditedData.ReceivedUniqueNumber;
    });
    lstProductList = [];
    lstProductList = arrF;
    $('#hdnProductList').val(JSON.stringify(lstProductList));
    Tblist();
}

///////////////Auto/////////
function AutoCompBacthNo() {
    var customarray = document.getElementById('hdnProBatchNo').value.split("|");
    actb(document.getElementById('txtBatchNo'), customarray);
}
//////////////////////////////////
//==============jayamoorthi=====================
function locationdetails() {
    var Trustedorgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
    if (Trustedorgid > 0) {

        document.getElementById('hdnProBatchNo').value = Trustedorgid;
    }
    var SelectUserID = document.getElementById('ddlUser').options[document.getElementById('ddlUser').selectedIndex].value;

    if (SelectUserID > 0) {

        document.getElementById('hdnUserID').value = SelectUserID;
    }

    var Fromlocationid = document.getElementById('ddlLocation').options[document.getElementById('ddlLocation').selectedIndex].value;

    if (Fromlocationid > 0) {

        document.getElementById('hdnFromLocationID').value = Fromlocationid;
    }

}

//=================================

function checkDetails(objFile) {

    locationdetails();
 var errorMsg = SListForAppMsg.Get("StockIntend_Error") == null ? "Error" : SListForAppMsg.Get("StockIntend_Error");

    if (objFile == "StockIssued") {
      

        if (document.getElementById('ddlStockReturnType').value == '0') {
            var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_01") == null ? "Select StockReturn Type" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_01");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddlStockReturnType').focus();
            return false;
        }

        if (document.getElementById('ddlTrustedOrg').value == '0') {
            var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_09") == null ? "Select the Organization" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_09");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddlTrustedOrg').focus();
            return false;
        }

        if (document.getElementById('ddlStockReturnType').options[document.getElementById('ddlStockReturnType').selectedIndex].value == 'StockIssued') {
            if ((document.getElementById('ddlLocation').value == '0')) {
                var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_10") == null ? "Select the issue to location" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_10");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlLocation').focus();
                return false;
            }
        }
       // Arun
        
//        if (document.getElementById('ddlUser').value == '0') {
//var userMsg = SListForAppMsg.Get("InventoryScripts_SubStoreReturn_js_11") == null ? "Select the received by" : SListForAppMsg.Get("InventoryScripts_SubStoreReturn_js_11");
// ValidationWindow(userMsg, errorMsg);
//            document.getElementById('ddlUser').focus();
//            return false;
//        }
        //        document.getElementById('btnSubmit').style.display = "none";
//end
   }
    if (objFile == "StockDamage") {
        if (document.getElementById('txtStockDamageDate').value == '') {
            var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_12") == null ? "Select stock damage date" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_12");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtStockDamageDate').focus();
            return false;
        }

        if (document.getElementById('INVStockUsage1_hdnProductList').value == '') {
            var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_13") == null ? "Select the product" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_13");
 ValidationWindow(userMsg, errorMsg);
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
                                var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_14") == null ? "Ensure items added/quantity are provided properly" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_14");
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
            var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_13") == null ? "Select the product" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_13");
 ValidationWindow(userMsg, errorMsg);
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
    var errorMsg = SListForAppMsg.Get("StockIntend_Error") == null ? "Error" : SListForAppMsg.Get("StockIntend_Error");
    var x = document.getElementById(tProductList).value.split('^');
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~'); tProID = y[0];
            var tcheck = document.getElementById("T_select" + tProID).checked;
            if (tcheck) {
                if (tbacNo.trim().toUpperCase() == y[1].trim().toUpperCase()) {

                    tIssQty = document.getElementById("T_IssQty" + tProID).value;
                    if (Number(y[2]) < Number(tIssQty)) {
                        var userMsg = SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_14") == null ? "Ensure items added/quantity are provided properly" : SListForAppMsg.Get("StockIntend_Scripts_SubStoreReturn_js_14");
 ValidationWindow(userMsg, errorMsg);
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
function fnChangeToLocation() {

    if ($('#ddlTrustedOrg').val() == 0 || $('#ddlLocation').val() == 0) {
        $('#txtProduct').val('');
    }
    else {

        $find('AutoCompleteProduct').set_contextKey($('#ddlLocation').val());
    }

}


   
    


