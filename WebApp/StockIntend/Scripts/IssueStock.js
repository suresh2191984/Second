var lstProductList = [];
var arrY = [];
function GetLocationlist_new() {

    var objSelect = SListForAppDisplay.Get("StockIntend_Scripts_IssueStock_js_01") == null ? "select" : SListForAppDisplay.Get("StockIntend_Scripts_IssueStock_js_01");
    var drpOrgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
    var options = document.getElementById('hdnlocation').value;
    var ddlLocation = document.getElementById('ddlLocation');
    var ddlUser = document.getElementById('ddlUser');
    var userList = document.getElementById('hdnUserlist').value;

    ddlUser.options.length = 0;
    ddlLocation.options.length = 0;
    var optn1 = document.createElement("option");
    ddlUser.options.add(optn1);
    optn1.text = objSelect;
    optn1.value = "0";
    ddlLocation.options.add(optn1);
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
    if (!CheckProductList()) {
        var errorMsg = SListForAppMsg.Get("StockIntend_Error") != null ? SListForAppMsg.Get("StockIntend_Error") : "Error";
        var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_01") == null ? "Provide the product list" : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_01");
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
var productAndBarCode = [];

function BarCodeExist(productlist) {
    var lstUniQueBarCode=[];
    var listCount = productlist.length;
    var productAndBarCodeCount = productAndBarCode.length;
    if (productAndBarCodeCount > 0) {
        for (var i = 0; i < listCount; i++) {
            if (productlist[i] != "") {
                var notExists = true;
                var subProductList = productlist[i].split('~');
                if (subProductList != "") {
                   
                    for (var j = 0; j < productAndBarCodeCount; j++) {

                        if (subProductList[1] == productAndBarCode[j].productID && subProductList[18] == productAndBarCode[j].barCode) {
                            notExists = false;
                            break;
                         }


                     }
                     if (notExists == true) {
                         lstUniQueBarCode.push(productlist[i]);
                     }
                }
            }
        }
        return lstUniQueBarCode;
    }
    else {
        return productlist;
    }
}
function addBarCodeItem(item) { 
    $("#tblBarCodeList").dialog("close");
    var itemlist = $(item).find("#hdnItemList").val();
    //    alert(item);

//    $('#tblBarCodeList').dataTable().fnDestroy();
    ///For Duplicate Removal Purposevar productAndBarCode 
    var productlist = itemlist.split("^");
    var listCount = productlist.length;
    var msg = "";
    for (var i = 0; i < listCount; i++) {
        if (subProductList != "") {
            var subProductList = productlist[i].split('~');
            if (subProductList != "") {
                msg = CheckProductQuantityValidation(subProductList[0], 1);
                if (msg == "") {
                    var product = { productID: subProductList[0], barCode: subProductList[17] };
                    productAndBarCode.push(product);
                }
            }
        }

    }


    /////Duplicate Removak Purpose End

    if (msg == "") {
        document.getElementById('hdnProductList').value += itemlist;
        Tblist();
        $("#divBarCodeList").parent().css("display", "none");
//        $('.ui-dialog').css("display", "none");

        $('#divProductDetails').removeClass().addClass('hide');
        $("#txtProduct").val("").focus();
        return false;
    }
    else {
        $("#divBarCodeList").parent().css("display", "none");
        //        $('.ui-dialog').css("display", "none");

        $('#divProductDetails').removeClass().addClass('hide');
        alert(msg);
        $("#txtProduct").val("").focus();
       
        return false;              
    }

//    

}

function tblBarCodeList(arraylist) {

    $('#tblBarCodeList').dataTable().fnDestroy();
    var array = BarCodeExist(arraylist);
    $("#tblBarCodeList tbody").empty();
    $("#tblBarCodeList").removeClass("hide");
    //    $("#tblBarCodeList").addClass("show");
  $("#tblBarCodeList").dialog({
             modal: true,
             title: 'Product Quantity',
             draggable: false,
             resizable: false,
             show: 'blind',
             hide: 'blind',
             dialogClass: 'w-500 pos-top',
             position: ['center',"80"]
                   
     });
    var row = "";
	var arrayLength = array.length;
	for (var i = 0; i < arrayLength; i++) {
//	    if (array[i] != null) {
	        var subArray = array[i].split('~');
	        var subArrayCount = subArray.length;

	     if(subArray!=""){
	         row += "<tr>";
	         var arrayItems = subArray[1] + "~" + subArray[2] + "~" +
                        subArray[3] + "~" + subArray[4] + "~" + subArray[5] + "~" + subArray[6] + "~" +
                        subArray[7] + "~" + subArray[8] + "~" + subArray[9] + "~" + subArray[10] + "~" + subArray[11] + "~" + subArray[12] + "~" + subArray[13] + "~" + subArray[14] + "~" + subArray[15]
                        + "~" + subArray[16] + "~" + subArray[17] + "~" + subArray[18] + "~" + subArray[19] + "~" + subArray[20] + "^";
	         var hdnList = "<input type='hidden'  id='hdnItemList' value='" + arrayItems + "' tabindex='3'>";
	            row += "<td style='width: 168px'>" + subArray[2] + "</td>";
	            row += "<td style='width: 168px' onclick='addBarCodeItem(this)'>" + subArray[18] + hdnList + "</td>";
	            row += "</tr>";
	          

	        }
//	    }

}
$("#tblBarCodeList tbody").append(row);

$('#tblBarCodeList').DataTable({
    "ordering": false

});

//$("#divBarCodeList").dialog();
//$(".ui-dialog.ui-widget.ui-widget-content").addClass("popupBorder");
//$("#divBarCodeList").parent().css("display", "block");
}

function AddBarCodeExceptionItem() {

    if ($("#txtQuantityofExceptionItem").val() != "" && $("#txtQuantityofExceptionItem").val()!="0") {
        var li = $("#hdnBarCodeExceptionItems").val().split('~');
        var Quantity = parseInt($("#txtQuantityofExceptionItem").val()) * parseInt(li[19]);
        var msg = CheckProductQuantityValidation(li[1], Quantity);
        if (msg == "") {
            document.getElementById('hdnProductList').value += li[1] + "~" + li[2] + "~" + li[3] + "~" +
							Quantity + "~" + li[5] + "~" + li[6] + "~" +
							li[7] + "~" + li[8] + "~" + li[9] + "~" + li[10] + "~" + li[11] + "~" + li[12] + "~" + li[13] + "~" + li[14] + "~" + li[15]
							+ "~" + li[16] + "~" + li[17] + "~" + li[18] + "~" + li[19] + "~" + li[20] + "^";
            Tblist();
            $("#txtProduct").val("").focus();
            $(".ui-dialog").css("display", "none");
        }
        else {
            alert(msg);
            $("#txtProduct").val("").focus();
        }
    }
    else {
        alert("Please enter item quantity");
    }
}
	 
function IsNumeric(e) {
    var keyCode = e.which ? e.which : e.keyCode
    var ret =(keyCode >= 48 && keyCode <= 57);  
    return ret;
}
function IAmSelected(sender, eventArgs) {
    var OK = SListForAppMsg.Get("StockIntend_Ok") != null ? SListForAppMsg.Get("StockIntend_Ok") : "OK";
    var Cancel = SListForAppMsg.Get("StockIntend_Cancel") != null ? SListForAppMsg.Get("StockIntend_Cancel") : "Cancel";
    var Information = SListForAppMsg.Get("StockIntend_Information") != null ? SListForAppMsg.Get("StockIntend_Information") : "Information";

    var BarcodeType = "";
    if ($("#hdnEnableBarCode").val() == "Y") {
        var lstTotalItems = eventArgs.get_value().split('^')[0].split('~');
        if (lstTotalItems.length >= 22 && lstTotalItems[21] == "MULTIPLECODES") {
            tblBarCodeList(eventArgs.get_value().split('^'));
            BarcodeType = "multiple";
        }
        else if (lstTotalItems.length >= 22 && lstTotalItems[21] == "BARCODE") {
            var li = eventArgs.get_value().split('~');

        var x = document.getElementById('hdnProductList').value.split("^");
        
        var y; var i;
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
                if (li[18] == y[17] && li[1] == y[0]) {
                    var errorMsg = SListForAppMsg.Get("StockIntend_Error") != null ? SListForAppMsg.Get("StockIntend_Error") : "Error";
                    var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_07") == null ? "Product number and batch number combination already exist" : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_07");
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtProduct').value = '';
                    document.getElementById('txtProduct').focus();
                    return false;
                }
            }
        }
            var msg = "";
            msg = CheckProductQuantityValidation(li[1], 1);
            if (msg == "") {

                var product = { productID: lstTotalItems[1], barCode: lstTotalItems[18] };
                productAndBarCode.push(product);
        
    
       
        document.getElementById('hdnProductList').value += li[1] + "~" + li[2] + "~" +
                        li[3] + "~" + li[4] + "~" + li[5] + "~" + li[6] + "~" +
                        li[7] + "~" + li[8] + "~" + li[9] + "~" + li[10] + "~" + li[11] + "~" + li[12] + "~" + li[13] + "~" + li[14] + "~" + li[15] 
                        + "~" + li[16] + "~" + li[17] + "~" + li[18] + "~" + li[19] + "~" + li[20]    + "^";


        Tblist();
        document.getElementById('txtProduct').value = "";
        document.getElementById('txtProduct').focus();
        return;
            }
            else {
                alert(msg)
            }
        }
        else if (lstTotalItems[21] == "NONBARCODE") {
        BarcodeType = "NONBARCODE";
        $("#ExceptionItemUnit").html(lstTotalItems[20]);
        var Items = eventArgs.get_value().split('^')[0];
         $("#hdnBarCodeExceptionItems").val(Items);
         $("#txtQuantityofExceptionItem").val("");
         $("#divBarCodeException").dialog({
             modal: true,
             title: 'Product Quantity',
             draggable: false,
             resizable: false,
             show: 'blind',
             hide: 'blind',
             dialogClass: 'w-500',
             buttons: {
             "Add": function() {
             AddBarCodeExceptionItem();
             $(this).dialog("close");
}
         }
     });
//         $("#divBarCodeException")
         $("#divBarCodeException").parent().css("display", "block");
        }
    }


    //pack size end

    if (BarcodeType == "") {

    if (document.getElementById('txtProduct').value.trim() == '') {
        document.getElementById('lblProdDesc').innerHTML = '';
    }
    document.getElementById('hdnBatchList').value = '';
    document.getElementById('hdnProductId').value = '';
    var lis = eventArgs.get_value().split('^');
    var bannedItem = lis[0].split('~')[18];
    var AvilableQty = lis[1].split('~')[4];
    var ReorderQty = lis[0].split('~')[19];
    var UserMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_10")!=null?SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_10"):"Selected product has been marked as Banned. Do you still wish to use this?";
    if (bannedItem == 'Y') {


        if (ConfirmWindow(UserMsg, Information, OK, Cancel)) {

        }
        else {
            document.getElementById("lblProdDesc").innerHTML = "";
            document.getElementById('txtProduct').value = '';
            document.getElementById('txtProduct').focus();
            return false;
        }
    }

    var pMainX = document.getElementById('hdnProductList').value.split("^");
    var isTrue = true;
    for (i = 0; i < lis.length; i++) {
        if (lis[i] != "") {
            var isTrue = true;
            for (xY = 0; xY < pMainX.length; xY++) {
                if (pMainX[xY] != "") {
                    xTempP = pMainX[xY].split('~');
                    if (lis[i].split('|')[1].split('~')[0] == xTempP[2] && lis[i].split('|')[0] == xTempP[6]) {
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
    var x = document.getElementById('hdnBatchList').value.split('^');
    var isAddItem = 0;
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');
            if (CheckTaskItems(pid + "~" + y[0] + "~" + y[8])) {
                document.getElementById('hdnProBatchNo').value += y[0] + "|";
                //document.getElementById('divProductDetails').style.display = 'block';
                $('#divProductDetails').removeClass().addClass('show');

                if (lis.length > 1) {
                    if (isAddItem == 0) {
                        document.getElementById('txtBatchNo').value += y[0];
                        BindQuantity();
                        isAddItem = 1;
                    }
                }
            }

        }

    }
    AutoCompBacthNo();
    ProductItemSelected(sender, eventArgs);
}
     return;
}

function IAmSelectedJSON(sender, eventArgs) {
    var OK = SListForAppMsg.Get("StockIntend_Ok") != null ? SListForAppMsg.Get("StockIntend_Ok") : "OK";
    var Cancel = SListForAppMsg.Get("StockIntend_Cancel") != null ? SListForAppMsg.Get("StockIntend_Cancel") : "Cancel";
    var Information = SListForAppMsg.Get("StockIntend_Information") != null ? SListForAppMsg.Get("StockIntend_Information") : "Information";

    var lstArray = JSON.parse(eventArgs.get_value());
    var lis = lstArray[0];
    var arrSelectedValue = [];


    if ($("#cheBarcodeSearch").is(':checked')) {
        lis = [];
        arrSelectedValue = $.grep(lstArray, function(n, i) {
            return $.trim(n.ProductName) == $.trim(eventArgs._text);
        });
        lis = arrSelectedValue[0];
        if ($("#lblProdDesc").length > 0) {
            document.getElementById('lblProdDesc').innerHTML = '';
            OnItemSelecteddoBindProduct(arrSelectedValue);
        }
        else {
            OnSelectBarcodeProductTotalQuantityCommonJSON(arrSelectedValue);
        }
        

    }

    var BarcodeType = "";
    if ($("#hdnEnableBarCode").val() == "Y") {
        if (lis.CategoryName == "MULTIPLECODES") {
            tblBarCodeList(eventArgs.get_value().split('^'));
            BarcodeType = "multiple";
        }
        else if (lis.CategoryName == "BARCODE") {
            var li = eventArgs.get_value().split('~');

            var x = document.getElementById('hdnProductList').value.split("^");

            var y; var i;
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    if (li[18] == y[17] && li[1] == y[0]) {
                        var errorMsg = SListForAppMsg.Get("StockIntend_Error") != null ? SListForAppMsg.Get("StockIntend_Error") : "Error";
                        var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_07") == null ? "Product number and batch number combination already exist" : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_07");
                        ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtProduct').value = '';
                        document.getElementById('txtProduct').focus();
                        return false;
                    }
                }
            }
            var msg = "";
            msg = CheckProductQuantityValidation(li[1], 1);
            if (msg == "") {

                var product = { productID: lstTotalItems[1], barCode: lstTotalItems[18] };
                productAndBarCode.push(product);



                document.getElementById('hdnProductList').value += li[1] + "~" + li[2] + "~" +
                                li[3] + "~" + li[4] + "~" + li[5] + "~" + li[6] + "~" +
                                li[7] + "~" + li[8] + "~" + li[9] + "~" + li[10] + "~" + li[11] + "~" + li[12] + "~" + li[13] + "~" + li[14] + "~" + li[15]
                                + "~" + li[16] + "~" + li[17] + "~" + li[18] + "~" + li[19] + "~" + li[20] + "^";


                Tblist();
                document.getElementById('txtProduct').value = "";
                document.getElementById('txtProduct').focus();
                return;
            }
            else {
                alert(msg)
            }
        }
        else if (lis.CategoryName == "NONBARCODE") {
            BarcodeType = "NONBARCODE";
            $("#ExceptionItemUnit").html(lstTotalItems[20]);
            var Items = eventArgs.get_value().split('^')[0];
            $("#hdnBarCodeExceptionItems").val(Items);
            $("#txtQuantityofExceptionItem").val("");
            $("#divBarCodeException").dialog({
                modal: true,
                title: 'Product Quantity',
                draggable: false,
                resizable: false,
                show: 'blind',
                hide: 'blind',
                dialogClass: 'w-500',
                buttons: {
                    "Add": function () {
                        AddBarCodeExceptionItem();
                        $(this).dialog("close");
                    }
                }
            });
            $("#divBarCodeException").parent().css("display", "block");
        }
    }


    //pack size end

    if (BarcodeType == "") {

        if (document.getElementById('txtProduct').value.trim() == '') {
            document.getElementById('lblProdDesc').innerHTML = '';
        }
        document.getElementById('hdnBatchList').value = '';
        document.getElementById('hdnProductId').value = '';
        var bannedItem = lis.IsTransactionBlock;
        var AvilableQty = lis.InHandQuantity;
        var ReorderQty = lis.ReorderQuantity;
        var UserMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_10") != null ? SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_10") : "Selected product has been marked as Banned. Do you still wish to use this?";
        if (bannedItem == 'Y') {
            if (ConfirmWindow(UserMsg, Information, OK, Cancel)) {

            }
            else {
                document.getElementById("lblProdDesc").innerHTML = "";
                document.getElementById('txtProduct').value = '';
                document.getElementById('txtProduct').focus();
                return false;
            }
        }
        var arrF = new Object();
        var arrX = [];
        arrY = [];
        $.each(lstArray, function (obj, value) {
            arrF = $.grep(lstProductList, function (n, i) {
            return n.ReceivedUniqueNumber == value.ReceivedUniqueNumber
            });
            if (arrF.length > 0) {
                $.merge(arrY, arrF)
            }
        });

        if (arrY.length > 0 && $("#cheBarcodeSearch").is(':checked') == false) {
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
        else if ($("#cheBarcodeSearch").is(':checked') == true) {

            $.each(arrSelectedValue, function(obj, value) {

                arrF = $.grep(lstProductList, function(n, i) {
                return n.ReceivedUniqueNumber == value.ReceivedUniqueNumber && $.trim(n.BarcodeNo) == $.trim(value.BarcodeNo);
                });
            });

            if (arrF.length > 0) {
                alert("This Product barcode already Added");
                return false;
            }
            else {
                arrX = arrSelectedValue;
            }

        }
        else {
            //   if ($("#cheBarcodeSearch").is(':checked')) { arrX = arrSelectedValue; }
            //   else { arrX = lstArray; }
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
                if (CheckTaskItems(pid + "~" + value.StockInHandID)) {
                    document.getElementById('hdnProBatchNo').value += value.BatchNo + "@#$" + value.StockInHandID + "|";
                    $('#divProductDetails').removeClass().addClass('show');
                    if (arrX.length > 0) {
                        if (isAddItem == 0) {
                            document.getElementById('txtBatchNo').value = value.BatchNo;
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
        ProductItemSelected(sender, eventArgs);
    }
    return;
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
    // if (lis.length > 2) {
        // document.getElementById('txtBatchNo').focus();

    // }
    // $("#txtProduct").focus();
    //document.getElementById('chkisCreditTransaction').checked = false;
}

function KeyPress1(e) {

    var ddlaction = document.getElementById('ddlUser');
    if (ddlaction.options[ddlaction.selectedIndex].value == '0') {
        var errorMsg = SListForAppMsg.Get("StockIntend_Error") != null ? SListForAppMsg.Get("StockIntend_Error") : "Error";
        var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_02") == null ? "Select The Issued And  Received By" : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_02");
        ValidationWindow(userMsg, errorMsg);
        return false;
    }
}


function pSetAddFocus() {
    var qty = document.getElementById('txtQuantity').value.trim();

    //    if (qty == '0' || qty == '') {
    //        document.getElementById('txtQuantity').focus();
    //        return;
    //    }
    //    document.getElementById('add').focus();
}


function BindQuantity() {
    var blnExists = false;
    var BatchNoList = [];
    if ($('#hdnBatchList').val() != '') {
        BatchNoList = JSON.parse($('#hdnBatchList').val());
        var lsttempArrary = $.grep(BatchNoList, function(n, i) {
            return n.StockInHandID == document.getElementById('hdnReceivedID').value.trim();
        });
    };

    if (lsttempArrary.length > 0) {
        var tempobject = lsttempArrary[0];
        document.getElementById('hdnProductName').value = tempobject.Name;
        document.getElementById('hdnReceivedID').value = tempobject.StockInHandID;
        document.getElementById('txtBatchQuantity').value = tempobject.InHandQuantity;
        ToTargetFormat($('#txtBatchQuantity'));
        document.getElementById('txtQuantity').value = tempobject.Quantity;
        document.getElementById('hdnQty').value = tempobject.Quantity;
        document.getElementById('hdnRaisedQty').value = tempobject.Quantity;
       // ToTargetFormat($('#txtQuantity'));
        document.getElementById('txtUnit').value = tempobject.SellingUnit;
        document.getElementById('hdnSellingPrice').value = tempobject.SellingPrice;
        ToInternalFormat($('#hdnSellingPrice'));
        document.getElementById('hdnTax').value = tempobject.Tax;
        ToInternalFormat($('#hdnTax'));
        document.getElementById('hdnCategoryID').value = tempobject.CategoryID;
        document.getElementById('hdnExpiryDate').value = tempobject.ExpiryDate;
        document.getElementById('hdnStockInHandID').value = tempobject.Providedby;
        document.getElementById('hdnIntendID').value = tempobject.ID;
        document.getElementById('hdnUnitPrice').value = tempobject.CostPrice;
        ToInternalFormat($('#hdnUnitPrice'));
        document.getElementById('hdnParentProductID').value = tempobject.ParentProductID;
        document.getElementById('hdnMRP').value = tempobject.MRP;
        document.getElementById('hdnPdtRcvdDtlsID').value = tempobject.ProductReceivedDetailsID;
        document.getElementById('hdnReceivedUniqueNumber').value = tempobject.ReceivedUniqueNumber;
        ToInternalFormat($('#hdnMRP'));
        document.getElementById('hdnStockReceivedBarcodeDetailsID').value = tempobject.StockReceivedBarcodeDetailsID;
        document.getElementById('hdnStockReceivedBarcodeID').value = tempobject.StockReceivedBarcodeID;
        document.getElementById('hdnBarcode').value = tempobject.BarcodeNo;
        document.getElementById('hdnIsUniqueBarcode').value = tempobject.IsUniqueBarcode;
        document.getElementById('txtRakNo').value = tempobject.RakNo;
        blnExists = true;
    };
    if (blnExists == false) {
        document.getElementById('txtUnit').value = '';
        document.getElementById('txtBatchQuantity').value = '';
        document.getElementById('txtBatchNo').value = '';
        return false;
    }
}
function checkIsEmpty() {
    var errorMsg = SListForAppMsg.Get("StockIntend_Error") != null ? SListForAppMsg.Get("StockIntend_Error") : "Error";
    if (document.getElementById('txtBatchNo').value.trim() == "") {
var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_03") == null ? "Provide the batch number" : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_03");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtBatchNo').focus();
        return false;
    }

    if (document.getElementById('txtQuantity').value == "") {
var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_04") == null ? "Provide issue quantity" : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_04");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }

    var _validqty = 0;
    var _minusvalidqty = 0;
    if (document.getElementById('lblNonMedicalAmt') != null)
        document.getElementById('lblNonMedicalAmt').innerHTML = "0.00";
    var tGrandTotal = 0.00;

    $.each(lstProductList, function (obj, value) {
        if (document.getElementById('add').value == 'Add') {
            if ($('#hdnProductName').val() == value.ProductName) {
                _validqty = (parseFloat(value.Quantity) + parseFloat(Number(_validqty))).toFixed(2); //y[3] + Number(_validqty);
            }
        }
        if (document.getElementById('add').value == 'Update') {
            if ($('#hdnProductName').val() == value.ProductName && $('#txtBatchNo').val() == value.BatchNo) {
                _minusvalidqty = (parseFloat(_validqty) + parseFloat(Number(value.Quantity))).toFixed(2); //Number(_validqty) - Number(y[3]);
            }
            else if ($('#hdnProductName').val() == value.ProductName) {
                _validqty = (parseFloat(Number(value.Quantity)) + parseFloat(_validqty)).toFixed(2); //Number(y[3]) + Number();
            }

        }
    });

    var textqty = document.getElementById('txtQuantity').value;
    _validqty = (parseFloat(_validqty) + parseFloat(textqty)).toFixed(2); //Number(_validqty) + Number(textqty);
    var qty = document.getElementById('hdnQty').value;
    if (parseFloat(_validqty) > parseFloat(qty)) {//(Number(_validqty) > qty) {
var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_05") == null ? "Provide the actual indent quantity" : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_05");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }

    if ( ToInternalFormat($("#txtBatchQuantity"))  < ToInternalFormat($("#txtQuantity") )) {
var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_06") == null ? "Ensure items added/quantity are provided properly" : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_06");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }

    if (Number(document.getElementById('txtQuantity').value) < 1) {
var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_06") == null ? "Ensure items added/quantity are provided properly" : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_06");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }




    if (document.getElementById('add').value != 'Update' && $("#cheBarcodeSearch").is(':checked') == false) {
        var pProductId = document.getElementById('hdnProductId').value;
        var pName = document.getElementById('hdnProductName').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        $.each(lstProductList, function (obj, value) {
        if (value.ReceivedUniqueNumber == document.getElementById('hdnReceivedUniqueNumber').value) {
            var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_07") == null ? "Product number and batch number combination already exist" : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_07");
             ValidationWindow(userMsg, errorMsg);
                                document.getElementById('txtProduct').value = '';
                                document.getElementById('txtProduct').focus();
                                return false;
                            }

        });
    }

    if ($("#cheBarcodeSearch").length > 0) {

        if ($("#cheBarcodeSearch").is(':checked') == true) {

            var pStockReceivedBarcodeID = document.getElementById('hdnStockReceivedBarcodeID').value;
            var pStockReceivedBarcodeDetailsID = document.getElementById('hdnStockReceivedBarcodeDetailsID').value;
            var pIsUniqueBarcode = $("#hdnIsUniqueBarcode").val();
            var arrSelectedValue = [];



            arrSelectedValue = $.grep(lstProductList, function(n, i) {
                return n.StockReceivedBarcodeID == pStockReceivedBarcodeID && n.IsUniqueBarcode == "PB";
            });


            if (arrSelectedValue.length > 0) {
                var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_11") == null ? "This Product  parent barcode already added." : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_11");
                alert("This Product  parent barcode already added.");
                return false;
            }

            arrSelectedValue = [];


            arrSelectedValue = $.grep(lstProductList, function(n, i) {
                return n.StockReceivedBarcodeID == pStockReceivedBarcodeID && pStockReceivedBarcodeDetailsID == 0 && n.IsUniqueBarcode == "Y";
            });

            if (arrSelectedValue.length > 0) {
                var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_11") == null ? "This Product  child barcode already added." : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_11");
                alert("This Product  child barcode already added.");
                return false;
            }

        }
    }
    
    return true;
}

function SetNumberFormat(Decimalvalue) {
    $('#hdnDisplaydata').val(Decimalvalue);
    ToTargetFormat($('#hdnDisplaydata'));
    return $('#hdnDisplaydata').val();
}

function BindProductList() {
    if (document.getElementById('add').value == 'Update') {
        var editData = JSON.parse($('#hdnRowEdit').val());
        if (editData != "") {
            var arrF = $.grep(lstProductList, function (n, i) {
                return n.StockInHandID != editData.StockInHandID
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
        var pTax = document.getElementById('hdnTax').value == "" ? 0 : ToInternalFormat($("#hdnTax")); 
        var pTax = ToInternalFormat($('#hdnTax')); 
        var pExp = document.getElementById('hdnExpiryDate').value;
        var pProBatchNo = document.getElementById('hdnProBatchNo').value;
        var pStockInHandID = document.getElementById('hdnStockInHandID').value;
        var pIntendID = document.getElementById('hdnIntendID').value;
        var pCategoryID = document.getElementById('hdnCategoryID').value;
        var pUnitPrice = document.getElementById('hdnUnitPrice').value == "" ? 0 : ToInternalFormat($("#hdnUnitPrice")); 
        var pRaisedQty = document.getElementById('hdnRaisedQty').value;
        var pMRP = ToInternalFormat($('#hdnMRP'));
        var pParentProductID = document.getElementById('hdnParentProductID').value;
        var pPdtRcvdDtlsID = document.getElementById('hdnPdtRcvdDtlsID').value;
        var pReceivedUniqueNumber = document.getElementById('hdnReceivedUniqueNumber').value;

        var pStockReceivedBarcodeDetailsID = document.getElementById('hdnStockReceivedBarcodeDetailsID').value;
        var pStockReceivedBarcodeID = document.getElementById('hdnStockReceivedBarcodeID').value;
        var pBarcode = document.getElementById('hdnBarcode').value;
    var pIsUniqueBarcode = document.getElementById('hdnIsUniqueBarcode').value;
    var pRakNo = document.getElementById('hdnRakno').value;
        if ($('#hdnTaxAddFlag').val() == '0') {
            var CalculatedTax = parseFloat(parseFloat(parseFloat(PUnitPrice) / parseFloat(100)) * parseFloat(pTax)).toFixed(2);
            PUnitPrice = parseFloat(parseFloat(PUnitPrice) + parseFloat(CalculatedTax)).toFixed(2);
        }

        var objProduct = new Object();
        objProduct.ID = pIntendID;
        objProduct.ProductName = pName;
        objProduct.BatchNo = pBatchNo;
        objProduct.InHandQuantity = pQTY;
        objProduct.InvoiceQty = pRaisedQty; 
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
        objProduct.UnitPrice = parseFloat(pUnitPrice);
        objProduct.ProductReceivedDetailsID = pPdtRcvdDtlsID;
        objProduct.StockInHandID = pStockInHandID;
        objProduct.CategoryID = pCategoryID;
        objProduct.ReceivedUniqueNumber = pReceivedUniqueNumber;
        objProduct.StockReceivedBarcodeDetailsID = pStockReceivedBarcodeDetailsID;
        objProduct.StockReceivedBarcodeID = pStockReceivedBarcodeID;
    objProduct.BarcodeNo = pBarcode; 
    objProduct.IsUniqueBarcode = pIsUniqueBarcode;
    objProduct.RakNo = pRakNo;
        lstProductList.push(objProduct);
        $('#hdnProductList').val(JSON.stringify(lstProductList));

        Tblist();
        document.getElementById('txtQuantity').value = '';
        document.getElementById('txtUnit').value = '';

        document.getElementById('add').value = 'Add';
    document.getElementById('txtProduct').value = '';
    document.getElementById('lblProdDesc').innerHTML = '';
        $('#hdnAddFlag').val('N');
}
function Tblist() {
    while (count = document.getElementById('tblOrederedItems').rows.length) {

        for (var j = 0; j < document.getElementById('tblOrederedItems').rows.length; j++) {
            document.getElementById('tblOrederedItems').deleteRow(j);
        }
    }
    if (lstProductList.length > 0) {
        var Headrow = document.getElementById('tblOrederedItems').insertRow(0);
        Headrow.id = "HeadID";

        Headrow.className = "gridHeader"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);
        var cell5 = Headrow.insertCell(4);
        var cell6 = Headrow.insertCell(5);
        if ($("#hdnEnableBarCode").val() == "Y") {
            cell4.className = "hide";
        }

        var objProductName = SListForAppDisplay.Get("StockIntend_Scripts_IssueStock_js_16") == null ? "Product Name" : SListForAppDisplay.Get("StockIntend_Scripts_IssueStock_js_16");
        var objBatchNo = SListForAppDisplay.Get("StockIntend_Scripts_IssueStock_js_17") == null ? "Batch No" : SListForAppDisplay.Get("StockIntend_Scripts_IssueStock_js_17");
        var objIssuedQty = SListForAppDisplay.Get("StockIntend_Scripts_IssueStock_js_18") == null ? "Issued Qty" : SListForAppDisplay.Get("StockIntend_Scripts_IssueStock_js_18");
        var objSellingPrice = SListForAppDisplay.Get("StockIntend_Scripts_IssueStock_js_19") == null ? "Selling Price" : SListForAppDisplay.Get("StockIntend_Scripts_IssueStock_js_19");
        var objAmount = SListForAppDisplay.Get("StockIntend_Scripts_IssueStock_js_20") == null ? "Amount" : SListForAppDisplay.Get("StockIntend_Scripts_IssueStock_js_20");
        var objAction = SListForAppDisplay.Get("StockIntend_Scripts_IssueStock_js_21") == null ? "Action" : SListForAppDisplay.Get("StockIntend_Scripts_IssueStock_js_21");

        cell1.innerHTML = objProductName;
        cell2.innerHTML = objBatchNo;
        cell3.innerHTML = objIssuedQty;
        cell4.innerHTML = objSellingPrice;
        cell5.innerHTML = objAmount;
        cell6.innerHTML = objAction;

        if (document.getElementById('lblNonMedicalAmt') != null)
            document.getElementById('lblNonMedicalAmt').innerHTML = "0.00";
        var tGrandTotal = 0.00;

        $.each(lstProductList, function (obj, value) {
            var row = document.getElementById('tblOrederedItems').insertRow(1);
            row.style.height = "13px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);

            if ($.trim(value.BarcodeNo) != "") {
                cell1.innerHTML = value.ProductName + " - " + value.BarcodeNo;
            } else {
                cell1.innerHTML = value.ProductName;
            }
            cell2.innerHTML = value.BatchNo;
            cell3.innerHTML = SetNumberFormat(value.Quantity);
            cell4.innerHTML = SetNumberFormat(value.Rate);
            cell5.innerHTML = SetNumberFormat(parseFloat(value.Quantity * value.Rate).toFixed(2));
            tGrandTotal = parseFloat(parseFloat(tGrandTotal) + parseFloat(value.Quantity * value.Rate)).toFixed(2);
            cell6.innerHTML = "<input name='Edit' onclick='btnEdit_OnClick(" + JSON.stringify(value) + ");' value = '' type='button' class='ui-icon ui-icon-pencil pull-left'  /> " +
                            "<input name='Delete' onclick='btnDelete(" + JSON.stringify(value) + ");' value = '' type='button' class='ui-icon ui-icon-trash pull-left' />"
        });

    }
    document.getElementById('hdnProBatchNo').value = '';
    document.getElementById('txtBatchNo').value = '';
    document.getElementById('txtBatchQuantity').value = '';
    document.getElementById('hdnBatchList').value = '';
    $('#divProductDetails').removeClass().addClass('hide');
    document.getElementById('txtProduct').focus();
    document.getElementById('hdnUnitPrice').value = '';
    document.getElementById('hdnMRP').value = '';
    document.getElementById('hdnPdtRcvdDtlsID').value = '';
}


function btnEdit_OnClick(sEditedData) {
    document.getElementById('hdnReceivedID').value = sEditedData.StockInHandID;
    document.getElementById('hdnProductName').value = sEditedData.ProductName;
    document.getElementById('txtProduct').value = sEditedData.ProductName;
    if (sEditedData.BatchNo == "*") {
        document.getElementById('txtBatchNo').disabled = true;
    }
    else {
        document.getElementById('txtBatchNo').disabled = false;
    }
    document.getElementById('txtBatchNo').value = sEditedData.BatchNo;
    document.getElementById('txtQuantity').value = sEditedData.Quantity;
    //ToTargetFormat($('#txtQuantity'));
    document.getElementById('txtUnit').value = sEditedData.Unit;
    document.getElementById('hdnQty').value = sEditedData.InvoiceQty;
    document.getElementById('hdnRaisedQty').value = sEditedData.InvoiceQty;
    document.getElementById('txtBatchQuantity').value = sEditedData.InHandQuantity;
    ToTargetFormat($('#txtBatchQuantity'));
    document.getElementById('hdnProductId').value = sEditedData.ProductID;
    document.getElementById('hdnRowEdit').value = JSON.stringify(sEditedData);
    document.getElementById('add').value = 'Update';
    $('#divProductDetails').removeClass().addClass('show');
    document.getElementById('hdnSellingPrice').value = sEditedData.Rate;
    ToInternalFormat($('#hdnSellingPrice'));
    document.getElementById('hdnTax').value = sEditedData.Tax;
    ToInternalFormat($('#hdnTax'));
    document.getElementById('hdnExpiryDate').value = sEditedData.ExpiryDate;
    document.getElementById('hdnProBatchNo').value = sEditedData.HasBatchNo;
    document.getElementById('hdnIntendID').value = sEditedData.ID;
    document.getElementById('hdnCategoryID').value = sEditedData.CategoryID;
    document.getElementById('hdnStockInHandID').value = sEditedData.StockInHandID;
    document.getElementById('hdnUnitPrice').value = sEditedData.UnitPrice;
    ToInternalFormat($('#hdnUnitPrice'));
    document.getElementById('hdnParentProductID').value = sEditedData.ParentProductID;
    document.getElementById('hdnMRP').value = sEditedData.MRP;
    document.getElementById('hdnPdtRcvdDtlsID').value = sEditedData.ProductReceivedDetailsID;
    document.getElementById('hdnReceivedUniqueNumber').value = sEditedData.ReceivedUniqueNumber;
    document.getElementById('hdnStockReceivedBarcodeDetailsID').value = sEditedData.StockReceivedBarcodeDetailsID;
    document.getElementById('hdnStockReceivedBarcodeID').value = sEditedData.StockReceivedBarcodeID;
    document.getElementById('hdnBarcode').value = sEditedData.BarcodeNo;
    document.getElementById('hdnIsUniqueBarcode').value = sEditedData.IsUniqueBarcode;

    ToInternalFormat($('#hdnMRP'));
    $('#hdnAddFlag').val('Y');
    AutoCompBacthNo();
}

function btnDelete(sEditedData) {
    //var i;
    //var RemoveFrom = sEditedData.split('~');

    //var tmpproductAndBarCode=[];
    //           var productAndBarCodeCount=productAndBarCode.length;
               
    //           for (var i = 0; i < productAndBarCodeCount; i++) {
    //               if (productAndBarCode[i].productID == RemoveFrom[0] && productAndBarCode[i].barCode == RemoveFrom[17]) {

    //               }
    //               else {
    //                   tmpproductAndBarCode.push(productAndBarCode[i]);
    //               }
    //           }

    //           productAndBarCode = tmpproductAndBarCode;

    var arrF = $.grep(lstProductList, function(n, i) {
    return n.StockInHandID != sEditedData.StockInHandID && $.trim(n.Barcode) == "";
    });

    var arrBarCode = $.grep(lstProductList, function(n, i) {
    return n.StockReceivedBarcodeDetailsID != sEditedData.StockReceivedBarcodeDetailsID && n.BarcodeNo != sEditedData.BarcodeNo && $.trim(n.BarcodeNo) != "";
    });

    $.merge(arrF, arrBarCode);
               lstProductList = [];
               lstProductList = arrF;
               $('#hdnProductList').val(JSON.stringify(lstProductList));
               Tblist();
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

function checkDetails() {
    var errorMsg = SListForAppMsg.Get("StockIntend_Error") != null ? SListForAppMsg.Get("StockIntend_Error") : "Error";
    if (document.getElementById('ddlLocation').value == '0') {
var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_08") == null ? "Select the issue to location" : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_08");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('ddlLocation').focus();
        return false;
    }
    //    if (document.getElementById('ddlUser').value == '0') {
    //        alert('Select the received by ');
    //        document.getElementById('ddlUser').focus();
    //        return false;
    //    }

    var x = document.getElementById("hdnTasklist").value.split("^");
    document.getElementById("hdnTaskCollectedItems").value = '';
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            var tProID = x[i];
            var T_select = document.getElementById("T_select" + tProID).checked;
            var T_Bacth = document.getElementById("T_Bacth" + tProID).value;
            //            var T_IssQty = document.getElementById("T_IssQty" + tProID).value;

            var T_IssQty = ToInternalFormat($('#T_IssQty' + tProID));
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
var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_06") == null ? "Ensure items added/quantity are provided properly" : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_06");
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
var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_09") == null ? "Select the product" : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_09");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtProduct').focus();
            return false;
        }
    }
    // document.getElementById('btnSubmit').style.display = "none";
    $('#btnSubmit').removeClass().addClass('hide');
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
    var errorMsg = SListForAppMsg.Get("StockIntend_Error") != null ? SListForAppMsg.Get("StockIntend_Error") : "Error";
    var x = document.getElementById(tProductList).value.split('^');
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~'); tProID = y[0];
            var tcheck = document.getElementById("T_select" + tProID).checked;
            if (tcheck) {
                if (tbacNo.trim().toUpperCase() == y[1].trim().toUpperCase()) {

                    //tIssQty = document.getElementById("T_IssQty" + tProID).value;
                    tIssQty = ToInternalFormat($('#' + "T_IssQty" + tProID));
                    if (Number(y[2]) < Number(tIssQty)) {
var userMsg = SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_06") == null ? "Ensure items added/quantity are provided properly" : SListForAppMsg.Get("StockIntend_Scripts_IssueStock_js_06");
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
                    ToTargetFormat($('#T_AblQty' + tProID));

                    document.getElementById("T_IssQty" + tProID).disabled = false;
                    document.getElementById("T_Bacth" + tProID).disabled = false;

                    document.getElementById("T_Unit" + tProID).value = y[3];
                    ToTargetFormat($('#T_Unit' + tProID));

                    document.getElementById("T_SellPrice" + tProID).value = y[4];
                    ToTargetFormat($('#T_SellPrice' + tProID));

                    document.getElementById("T_Amount" + tProID).value = '0.00'
                    ToTargetFormat($('#T_Amount' + tProID));

                    document.getElementById("T_IssQty" + tProID).value = '';
                    document.getElementById("T_IssQty" + tProID).focus();
                    break;
                }
                else {
                    document.getElementById("T_AblQty" + tProID).value = '0.00'
                    ToTargetFormat($('#T_AblQty' + tProID));

                    document.getElementById("T_IssQty" + tProID).value = '0'
                    document.getElementById("T_IssQty" + tProID).disabled = true;
                    document.getElementById("T_Unit" + tProID).value = '--'

                    document.getElementById("T_SellPrice" + tProID).value = '0.00'
                    ToTargetFormat($('#T_SellPrice' + tProID));

                    document.getElementById("T_Amount" + tProID).value = '0.00'
                    ToTargetFormat($('#T_Amount' + tProID));

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
                    ToTargetFormat($("#T_Bacth" + tProID));

                    document.getElementById("T_AblQty" + tProID).value = y[2];
                    ToTargetFormat($("#T_AblQty" + tProID));

                    document.getElementById("T_IssQty" + tProID).disabled = false;
                    document.getElementById("T_Bacth" + tProID).disabled = false;

                    document.getElementById("T_Unit" + tProID).value = y[3];
                    ToTargetFormat($("#T_Unit" + tProID));

                    document.getElementById("T_SellPrice" + tProID).value = y[4];
                    ToTargetFormat($("#T_SellPrice" + tProID));

                    document.getElementById("T_Amount" + tProID).value = '0.00'
                    ToTargetFormat($("#T_Amount" + tProID));

                    document.getElementById("T_IssQty" + tProID).value = '';
                    document.getElementById("T_IssQty" + tProID).focus();
                    TaskAddedListItem(y[0] + "~" + y[1] + "~" + y[7], "Added"); break;
                }


            } else {
                document.getElementById("T_Bacth" + tProID).value = '--'
                document.getElementById("T_Bacth" + tProID).disabled = true;

                document.getElementById("T_AblQty" + tProID).value = '0.00'
                ToTargetFormat($("#T_AblQty" + tProID));

                document.getElementById("T_IssQty" + tProID).value = '0'
                document.getElementById("T_IssQty" + tProID).disabled = true;
                document.getElementById("T_Unit" + tProID).value = '--'

                document.getElementById("T_SellPrice" + tProID).value = '0.00'
                ToTargetFormat($("#T_SellPrice" + tProID));

                document.getElementById("T_Amount" + tProID).value = '0.00'
                ToTargetFormat($("#T_Amount" + tProID));

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
            var T_IssQty = ToInternalFormat($("#T_IssQty" + tProID));  //document.getElementById("T_IssQty" + tProID).value;
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

    $('#hdnTargetMsg').val(parseFloat(parseFloat(t_tempamt) - parseFloat(t_vatamt)).toFixed(2));
    var subT = ToInternalFormat($('#hdnTargetMsg'));

    $('#hdnTargetMsg').val(parseFloat(t_vatamt).toFixed(2));
    var vatT = ToInternalFormat($('#hdnTargetMsg'));

    $('#hdnTargetMsg').val(parseFloat(t_tempamt).toFixed(2));
    var grossT = ToInternalFormat($('#hdnTargetMsg'));
    document.getElementById('hdnTaskAmount').value = subT + "~" + vatT + "~" + grossT;

}


function doGetProductTotalQuantity(source, eventArgs) {
    // alert(eventArgs.get_value());
    if ($("#hdnEnableBarCode").val() != "Y") {
        if (document.getElementById('txtProduct').value.length < 2) {
            document.getElementById("lblProdDesc").innerHTML = "";
        } else {
            var tblString = new Array();
            tblString[0] = "<table class='w-100p gridView'>";
            tblString[1] = "<tr class='gridHeader'><td>Product</td><td>Batch No.</td><td>Exp. Date</td><td>Selling Price</td><td>Available Qty.</td></tr>";
            tblString[2] = "";
            tblString[3] = "</table>";


        var lis = eventArgs.get_value().split('^');
        var sum = 0;
        var unit = "";
        for (i = 0; i < lis.length; i++) {
            if (lis[i] != "") {
                var tblData = lis[i].split('~');
                //                    tblString[2] += "<tr><td>" + tblData[1] + "</td><td>" + tblData[] + "</td><td align='left'>" + tblData[8].trim().split(' ')[1] + "/" + tblData[8].trim().split(' ')[2] + "</td><td align='right'>" + tblData[3] + "(" + tblData[4] + ")" + "</td></tr>";

                // var pdate = tblData[6];

                var pdate = GetServerDate();
                //                pdate = new Date(tblData[10]);

                var DateSplit = tblData[10].split(' ');
                    if (DateSplit.length > 4) {
                        if (DateSplit[1] == "") {
                            DateSplit[1] = "0";
                            DateSplit[1] = DateSplit[1] + DateSplit[2];
                            DateSplit[2] = DateSplit[3];
                            DateSplit[3] = DateSplit[4];
                            DateSplit[4] = "";
                        }
                    }
                if (DateSplit.length > 0) {
                        var DateFormat = DateSplit[0] + " " + DateSplit[1] + " " + DateSplit[2]; //"Dec 02 , 2014"
                    pdate = new Date(DateFormat);
                }
                else {
                    pdate = new Date(tblData[10]);
                }



                //var d = pdate.getDate() + "/" + pdate.getMonth() + "/" + pdate.getFullYear();
                var d = pdate.getDate() + "/" + (pdate.getMonth() + 1) + "/" + pdate.getFullYear();
                if (tblData[10] != "**") {

                }

                $('#hdnTargetMsg').val(tblData[7]);
                $('#hdnTargetMsg1').val(tblData[4]);
                tblString[2] += "<tr><td>" + tblData[1] + "</td><td>" + tblData[3] + "</td><td class='a-left'>" + d + "</td><td>" + ToTargetFormat($('#hdnTargetMsg')) + "</td><td align='right'>" + tblData[6] + "(" + ToTargetFormat($('#hdnTargetMsg1')) + ")" + "</td></tr>";
                sum += parseFloat(tblData[4]);
                unit = "(" + tblData[6] + ")";
            }
        }
        $('#hdnTargetMsg').val(sum);
        var _total = ToTargetFormat($('#hdnTargetMsg')) + unit;
        tblString[2] += "<tr><td colspan='4' class='a-right'>Total</td><td class='a-right'>" + _total + "</td></tr>";
        document.getElementById("lblProdDesc").innerHTML = tblString[0] + tblString[1] + tblString[2] + tblString[3];
    }
}
}

function doGetProductTotalQuantityJSON(source, eventArgs) {
    if ($("#hdnEnableBarCode").val() != "Y") {
        if (document.getElementById('txtProduct').value.length < 2) {
            document.getElementById("lblProdDesc").innerHTML = "";
        } else {
            var tblString = new Array();
            tblString[0] = "<table id='tbllist' class='w-100p gridView'>";
            tblString[1] = "<tr class='gridHeader'><td>Product</td><td>Batch No.</td><td>Exp. Date</td><td>Selling Price</td><td>Available Qty.</td></tr>";
            tblString[2] = "";
            tblString[3] = "</table>";

            var lis = JSON.parse(eventArgs.get_value());
            var sum = 0;
            var unit = "";
            var cheBarcode = $("#cheBarcodeSearch").is(':checked');
            var ProductName = "";
            $.each(lis, function (obj, value) {
                if (value != "") {
                    var tblData = value;
                    var DateSplit = (new Date(parseInt(value.ExpiryDate.substr(6)))).format("dd/MM/yyyy") == "01/01/1753" ? "**" : (new Date(parseInt(value.ExpiryDate.substr(6)))).format("dd/MM/yyyy");
                    $('#hdnTargetMsg').val(tblData.SellingPrice);
                    $('#hdnTargetMsg1').val(tblData.InHandQuantity);

                    ProductName = cheBarcode == true ? tblData.Name + '  [ ' + tblData.BarcodeNo + ' ]' : tblData.Name;

                    tblString[2] += "<tr><td>" + ProductName + "</td><td>" + tblData.BatchNo + "</td><td class='a-left'>" + DateSplit + "</td><td>" + ToTargetFormat($('#hdnTargetMsg')) + "</td><td align='right'>" + ToTargetFormat($('#hdnTargetMsg1')) + "(" + tblData.SellingUnit + ")" + "</td></tr>";
                    sum += parseFloat(tblData.InHandQuantity);
                    unit = "(" + tblData.SellingUnit + ")";
                }
            });
            $('#hdnTargetMsg').val(sum);
            var _total = ToTargetFormat($('#hdnTargetMsg')) + unit;
            tblString[2] += "<tr><td colspan='4' class='a-right'>Total</td><td class='a-right'>" + _total + "</td></tr>";
            document.getElementById("lblProdDesc").innerHTML = tblString[0] + tblString[1] + tblString[2] + tblString[3];
        }
    }
}

function doClearTable() {
    if (document.getElementById('txtProduct').value.length < 2) {
        document.getElementById("lblProdDesc").innerHTML = "";
    }
}


function AddInHandQuantity() {
	var listOfItems = $("#gvIndentDetails tbody tr");
	var TotalCount = listOfItems.length;

	for (var i = 1 ; i < TotalCount; i++) {

		if ($(listOfItems).eq(0).find("[id*=hdnProductID]") != "") {
			var ProductID = $(listOfItems).eq(i).find("[id$=hdnProductID]").val();
			var OrderedQuantity = $(listOfItems).eq(i).find("[id$=hdnOrderedQuantity]").val();
			var InhandQuantity = $(listOfItems).eq(i).find("[id$=hdnInhandQuantity]").val();

			var productObject = {
			"ProductID": ProductID,
			"OrderedQuantity": OrderedQuantity,
			"InhandQuantity": InhandQuantity
			};
			// Pushed Into Global Variable
			IndentProductDetails.push(productObject);

		}

	}
}


function hdnProductDetails() {
    var lstHdnProducts = [];
    var hdnProducts = $("#hdnProductList").val().split("^");
    var hdnProductsCount = hdnProducts.length;

    for (var i = 0; i < hdnProductsCount; i++) {
        if (hdnProducts[i] != "" && hdnProducts[i] != undefined) {
        var lstHdnProductsCount = lstHdnProducts.length;
        if (lstHdnProductsCount > 0) {
            for (var j = 0; j < lstHdnProductsCount; j++) {
                var hdnSubProduct = hdnProducts[i].split("~");
                if (lstHdnProducts[j].ProductID == hdnSubProduct[0]) {
                    lstHdnProducts[j].OrderedQuantity = parseInt(lstHdnProducts[j].OrderedQuantity) + parseInt(hdnSubProduct[3]);
                } else {
                    var productObject = {
                        "ProductID": hdnSubProduct[0],
                        "OrderedQuantity": hdnSubProduct[3]
                    };
                    lstHdnProducts.push(productObject);
                }
            }
        } else {
            var hdnSubProduct = hdnProducts[i].split("~");
            var productObject = {
                "ProductID": hdnSubProduct[0],
                "OrderedQuantity": hdnSubProduct[3]
            };
            lstHdnProducts.push(productObject);
        }
        }
    }
    return lstHdnProducts;
}

function CheckProductQuantityValidation(currentproductID, TotalConvertQuantity) {
    IndentProductDetailsCount = IndentProductDetails.length;
    var OrderedQuantity = 0;
    var InhandQuantity = 0;
    for (var k = 0; k < IndentProductDetailsCount; k++) {
        if (IndentProductDetails[k].ProductID == currentproductID) {
            OrderedQuantity = IndentProductDetails[k].OrderedQuantity;
            InhandQuantity = IndentProductDetails[k].InhandQuantity;
            break;
        }
    }
    var tableProducts = hdnProductDetails();
    var tableProductsCount = tableProducts.length;

    var AddedQuantity;
    var OrderedInHandQuantity;
    var TotalReceivingQty = TotalConvertQuantity;
    for (var i = 0; i < tableProductsCount; i++) {
        if (tableProducts[i].ProductID == currentproductID) {
            TotalReceivingQty = parseInt(tableProducts[i].OrderedQuantity) + TotalConvertQuantity;
            break;
        }
    }
    var msg = "";
    if (InhandQuantity < TotalReceivingQty) {
        msg = "There is no sufficient in-hand quantity to issue indent";
    }
    if (OrderedQuantity < TotalReceivingQty) {
        msg = "You can not add products more than ordered quantity";
    }

    return msg;
}

function OnItemSelecteddoBindProduct(arrSelectedlist) {

    var tblString = new Array();
    tblString[0] = "<table id='tbllist' class='w-100p gridView'>";
    tblString[1] = "<tr class='gridHeader'><td>Product</td><td>Batch No.</td><td>Exp. Date</td><td>Selling Price</td><td>Available Qty.</td></tr>";
    tblString[2] = "";
    tblString[3] = "</table>";

    var lis = arrSelectedlist;
    var sum = 0;
    var unit = "";
    var cheBarcode = $("#cheBarcodeSearch").is(':checked');
    var ProductName = "";

    $.each(lis, function(obj, value) {
        if (value != "") {
            var tblData = value;
            var DateSplit = (new Date(parseInt(value.ExpiryDate.substr(6)))).format("dd/MM/yyyy") == "01/01/1753" ? "**" : (new Date(parseInt(value.ExpiryDate.substr(6)))).format("dd/MM/yyyy");
            $('#hdnTargetMsg').val(tblData.SellingPrice);
            $('#hdnTargetMsg1').val(tblData.InHandQuantity);

            ProductName = cheBarcode == true ? tblData.Name + '  [ ' + tblData.BarcodeNo + ' ]' : tblData.Name;

            tblString[2] += "<tr><td>" + ProductName + "</td><td>" + tblData.BatchNo + "</td><td class='a-left'>" + DateSplit + "</td><td>" + ToTargetFormat($('#hdnTargetMsg')) + "</td><td align='right'>" + ToTargetFormat($('#hdnTargetMsg1')) + "(" + tblData.SellingUnit + ")" + "</td></tr>";
            sum += parseFloat(tblData.InHandQuantity);
            unit = "(" + tblData.SellingUnit + ")";
        }
    });
    $('#hdnTargetMsg').val(sum);
    var _total = ToTargetFormat($('#hdnTargetMsg')) + unit;
    tblString[2] += "<tr><td colspan='4' class='a-right'>Total</td><td class='a-right'>" + _total + "</td></tr>";
    document.getElementById("lblProdDesc").innerHTML = tblString[0] + tblString[1] + tblString[2] + tblString[3];


}