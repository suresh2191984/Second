var lstProductList = [];
function GetLocationlist() {
    var drpOrgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
    var options = document.getElementById('hdnlocation').value;
    var ddlLocation = document.getElementById('ddlLocation');
    var ddlUser = document.getElementById('ddlUser');
    var userList = document.getElementById('hdnUserlist').value;

    ddlUser.options.length = 0;
    ddlLocation.options.length = 0;
    var optn1 = document.createElement("option");
    ddlUser.options.add(optn1);
    ddlLocation.options.add(optn1);
    var ddlselect = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_01") == null ? "Select" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_01");
    optn1.text = ddlselect;
    optn1.value = "0";

    var list = options.split('^');
    var optn = document.createElement("option");
    for (i = 0; i < list.length; i++) {
        if (list[i] != "") {
            var res = list[i].split('~');

        

            if (drpOrgid == res[0]) {
                ddlLocation.options.add(optn);
                optn.text = res[2];
                optn.value = res[1];
            }
          
        }
    }
    Getuserlist();

//    var uselist = userList.split('^');
//    for (i = 0; i < uselist.length; i++) {
//        if (uselist[i] != "") {
//            var res1 = uselist[i].split('~');

//            if (drpOrgid == res1[2]) {
//                var optnuserlist = document.createElement("option");
//                ddlUser.options.add(optnuserlist);
//                optnuserlist.text = res1[0];
//                optnuserlist.value = res1[1];
//            }
//        }



//    }

}

/*Colour change for Trusted Drugs start*/
function SetColor() {

    var completionList = $find("AutoCompleteProduct").get_completionList().childNodes;
    var HighlightProduct = '';
    var _Color = '';
    for (var i = 0; i < completionList.length; i++) {
        _Color = completionList[i]._value.split('^');
        if (_Color != undefined && _Color != '') {
            HighlightProduct = _Color[0].split('~')[18];
        } else {
            HighlightProduct = 'N';
        }
        if (HighlightProduct == 'Y') {
            completionList[i].style.color = "orange";
        }
    }
}
/*Colour change for Trusted Drugs End*/

function checkExpDate(obj) {
    var myValStr = document.getElementById(obj).value;
    var TodayDate = GetServerDate();
    var DayFormat = TodayDate.format("MM/dd/yyyy");
    var TodayYear = DayFormat.split('/')[2];
    var Todaymonth = DayFormat.split('/')[0];
    var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
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
         var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_01") == null ? "Provide valid date" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_01");
 ValidationWindow(userMsg, errorMsg);
                return isTrue;
        }

        var pdate = Mon + pyyyy;
        var pdatelen = pdate.length;
        for (j = 0; j < pdatelen; j++) {
            if (pdate.charAt(j) == "_") {
                document.getElementById(obj).focus();
           var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_01") == null ? "Provide valid date" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_01");
 ValidationWindow(userMsg, errorMsg);
                    return false;
               }
        }
    }
}

//End:
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


function GetLocationlist_Laundry() {
    //

    var drpOrgid = document.getElementById('hdnOrgid').value;
    var options = document.getElementById('hdnlocation').value;
    var ddlLocation = document.getElementById('ddlLocation');
    var ddlUser = document.getElementById('ddlUser');
    var userList = document.getElementById('hdnUserlist').value;

    ddlUser.options.length = 0;
    ddlLocation.options.length = 0;
    var optn1 = document.createElement("option");
    ddlUser.options.add(optn1);
    var ddlselect = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_01") == null ? "Select" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_01");
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
    Getuserlist_Laundry();
}
function Getuserlist_Laundry() {

    var drpOrgid1 = document.getElementById('hdnOrgid').value;
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
function GetLocationlist_CSSD() {
    //

    var drpOrgid = document.getElementById('hdnOrgid').value;
    var options = document.getElementById('hdnlocation').value;
    var ddlLocation = document.getElementById('ddlLocation');
    var ddlUser = document.getElementById('ddlUser');
    var userList = document.getElementById('hdnUserlist').value;

    ddlUser.options.length = 0;
    ddlLocation.options.length = 0;
    var optn1 = document.createElement("option");
    ddlUser.options.add(optn1);
    var ddlselect = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_01") == null ? "Select" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_01");
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
    Getuserlist_Laundry();
}
function Getuserlist_CSSD() {

    var drpOrgid1 = document.getElementById('hdnOrgid').value;
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
    var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
    if (!CheckProductList()) {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_02") == null ? "Provide the product list" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_02");
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
    var banned = lis.IsTransactionBlock;
    var AvilableQty = lis.InHandQuantity;
    var ReorderQty = lis.ReorderQuantity;

    var isTrue = false;
    if (banned == 'Y') {
        var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
        var informMsg = SListForAppMsg.Get("InventoryCommon_Information") == null ? "Information" : SListForAppMsg.Get("InventoryCommon_Information");
        var okMsg = SListForAppMsg.Get("InventoryCommon_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryCommon_Ok")
        var cancelMsg = SListForAppMsg.Get("InventoryCommon_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryCommon_Cancel");
        var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_16") == null ? "Selected product has been marked as Banned. Do you still wish to use this?" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_16");
        if (ConfirmWindow(userMsg,informMsg,okMsg,cancelMsg)) {
        }
        else {
            document.getElementById('txtProduct').value = '';
            document.getElementById('txtProduct').focus();
            while (count = document.getElementById('tbllist').rows.length) {
                for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                    document.getElementById('tbllist').deleteRow(j);
                }
            }
            $('#divProductDetails').removeClass().addClass('hide');
            return false;
        }
    }


    
    if ((parseInt(ReorderQty) >= parseInt(AvilableQty)) ||(parseInt(ReorderQty) > parseInt(AvilableQty))) {
    
        isTrue = true;
        
        }
  
    else {
        isTrue = false ;
    }
    

    if (isTrue == true) {
        var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
        var informMsg = SListForAppMsg.Get("InventoryCommon_Information") == null ? "Information" : SListForAppMsg.Get("InventoryCommon_Information");
        var okMsg = SListForAppMsg.Get("InventoryCommon_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryCommon_Ok")
        var cancelMsg = SListForAppMsg.Get("InventoryCommon_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryCommon_Cancel");
        var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_17") == null ? "Selected product has been reach as reorder level. Do you still wish to use this?" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_17");
        if (ConfirmWindow(userMsg,informMsg,okMsg,cancelMsg)) {

        }
        else {

            while (count = document.getElementById('tbllist').rows.length) {
                for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                    document.getElementById('tbllist').deleteRow(j);
                }
            }
            $('#divProductDetails').removeClass().addClass('hide');
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
        arrX = Enumerable.From(lstArray).Where(function (x) { return Enumerable.From(rpid).Contains(x.ReceivedUniqueNumber) }).ToArray();
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
    ToTargetFormat($('#txtBatchQuantity'));
    
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
                        document.getElementById('hdnReceivedID').value = value.StockInHandID;
                        document.getElementById('txtBatchNo').value = value.BatchNo;
                        $('#hdnAddFlag').val('N');
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


function IAmSelected_Laundry(source, eventArgs) {

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
    var banned = lis[0].split('~')[16];
    var AvilableQty = lis[0].split('~')[3];
    var ReorderQty = lis[0].split('~')[17];

    var isTrue = false;
    if (banned == 'Y') {
        var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
        var informMsg = SListForAppMsg.Get("InventoryCommon_Information") == null ? "Information" : SListForAppMsg.Get("InventoryCommon_Information");
        var okMsg = SListForAppMsg.Get("InventoryCommon_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryCommon_Ok")
        var cancelMsg = SListForAppMsg.Get("InventoryCommon_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryCommon_Cancel");
        var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_16") == null ? "Selected product has been marked as Banned. Do you still wish to use this?" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_16");
        if (confirm('Selected product has been marked as Banned. Do you still wish to use this?')) {
        }
        else {
            document.getElementById('txtProduct').value = '';
            document.getElementById('txtProduct').focus();
            while (count = document.getElementById('tbllist').rows.length) {
                for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                    document.getElementById('tbllist').deleteRow(j);
                }
            }
            document.getElementById('divProductDetails').style.display = 'none';
            return false;
        }
    }



    if ((parseInt(ReorderQty) >= parseInt(AvilableQty)) || (parseInt(ReorderQty) > parseInt(AvilableQty))) {

        isTrue = true;

    }

    else {
        isTrue = false;
    }


    if (isTrue == true) {

        var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
        var informMsg = SListForAppMsg.Get("InventoryCommon_Information") == null ? "Information" : SListForAppMsg.Get("InventoryCommon_Information");
        var okMsg = SListForAppMsg.Get("InventoryCommon_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryCommon_Ok")
        var cancelMsg = SListForAppMsg.Get("InventoryCommon_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryCommon_Cancel");
        var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_17") == null ? "Selected product has been reach as reorder level. Do you still wish to use this?" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_17");
        if (ConfirmWindow(userMsg,informMsg,okMsg,cancelMsg)) {

        }
        else {

            while (count = document.getElementById('tbllist').rows.length) {
                for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                    document.getElementById('tbllist').deleteRow(j);
                }
            }
            document.getElementById('divProductDetails').style.display = 'none';
            document.getElementById('txtProduct').value = '';
            document.getElementById('txtProduct').focus();
            return false;
        }
    }


    //    if ((AvilableQty <= ReorderQty )) {

    //        if (confirm('Selected product has been reach as reorder level. Do you still wish to use this?')) {

    //        }
    //        else {
    //           
    //            while (count = document.getElementById('tbllist').rows.length) {
    //                for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
    //                    document.getElementById('tbllist').deleteRow(j);
    //                }
    //            }
    //            document.getElementById('divProductDetails').style.display = 'none';
    //            document.getElementById('txtProduct').value = '';
    //            document.getElementById('txtProduct').focus();
    //           return false;
    //        }
    //    }

    var pMainX = document.getElementById('hdnProductList').value.split("^");
    var isTrue = true;
    for (i = 0; i < lis.length; i++) {
        if (lis[i] != "") {
            var isTrue = true;
            for (xY = 0; xY < pMainX.length; xY++) {
                if (pMainX[xY] != "") {
                    xTempP = pMainX[xY].split('~');
                    //   alert(lis[i]);
                    if (lis[i].split('|')[1].split('~')[2] == xTempP[0] && lis[i].split('|')[0] == xTempP[6]) {
                        isTrue = true;
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
    ToTargetFormat($('#txtBatchQuantity'));

    document.getElementById('txtUnit').value = '';
    document.getElementById('txtBatchNo').value = '';
    document.getElementById('hdnReceivedID').value = 0;
    document.getElementById('txtBatchNo').disabled = false;
    var x = document.getElementById('hdnBatchList').value.split('^');
    var isAddItem = 0;
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');
            if (CheckTaskItems(pid + "~" + y[0] + "~" + y[2] + "~" + y[18])) {
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
    var ddlselect = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_01") == null ? "Select" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_01");
    if (ddlaction.options[ddlaction.selectedIndex].text == ddlselect) {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_04") == null ? "Select The Issued Location And  Received By" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_04");
var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
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
        var lsttempArrary = $.grep(BatchNoList, function (n, i) {
            return n.StockInHandID == document.getElementById('hdnReceivedID').value;
        });
        if (lsttempArrary.length > 0) {
            var tempobject = lsttempArrary[0];
                document.getElementById('txtBatchNo').value= tempobject.BatchNo;
                document.getElementById('hdnProductName').value = tempobject.Name;
                document.getElementById('hdnReceivedID').value = tempobject.StockInHandID;

                document.getElementById('txtBatchQuantity').value = tempobject.InHandQuantity;
                //ToTargetFormat($('#txtBatchQuantity'));

                document.getElementById('txtUnit').value = tempobject.SellingUnit;
                ToTargetFormat($('#txtUnit'));

                document.getElementById('hdnSellingPrice').value = tempobject.SellingPrice;
                ToTargetFormat($('#hdnSellingPrice'));

                document.getElementById('hdnTax').value = tempobject.Tax;
                ToTargetFormat($('#hdnTax'));
                    
                document.getElementById('hdnExpiryDate').value = tempobject.ExpiryDate;
                document.getElementById('hdnHasExpiryDate').value = tempobject.HasExpiryDate;
                    
                document.getElementById('hdnUnitPrice').value = tempobject.CostPrice;
                ToTargetFormat($('#hdnUnitPrice'));
                    
                document.getElementById('hdnParentProductID').value = tempobject.ParentProductID;

                document.getElementById('txtreturnstock').value = tempobject.SubstoreReturnqty;

                document.getElementById('hdnPdtRcvdDtlsID').value = tempobject.ProductReceivedDetailsID;
                document.getElementById('hdnReceivedUniqueNumber').value = tempobject.ReceivedUniqueNumber;

                if ($("#hdnStockReceivedBarcodeDetailsID").length > 0) {
                    $("#hdnStockReceivedBarcodeDetailsID").val(tempobject.StockReceivedBarcodeDetailsID)
                }

                if ($("#hdnStockReceivedBarcodeID").length > 0) {
                    $("#hdnStockReceivedBarcodeID").val(tempobject.StockReceivedBarcodeID)
                }

                                
                if ($("#hdnBarcodeNo").length > 0) {
                    $("#hdnBarcodeNo").val(tempobject.BarcodeNo);
                }

                if ($("#hdnIsUniqueBarcode").length > 0) {
                    $("#hdnIsUniqueBarcode").val(tempobject.IsUniqueBarcode)
                }
                 
                
                
                if (tempobject.SubstoreReturnqty < 1) {
                    $('#tdreturnstock').hide();
                    $('#tdlblreturnstock').hide();
                }
                else {
                    $('#tdreturnstock').show();
                    $('#tdlblreturnstock').show();
                }
                $('#txtExpDate').val(new Date(parseInt(tempobject.ExpiryDate.substr(6))));
                $('#txtExpDate').attr("disabled", "disabled");
                var pCell = document.getElementById('hdnReceivedID').value;
                for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                    document.getElementById('tbllist').rows[j].style.backgroundColor = "";
                    if ("tr_par" + pCell == document.getElementById('tbllist').rows[j].id) {
                        document.getElementById('tbllist').rows[j].style.backgroundColor = '#DCFC5C';
                    }
                }
                blnExists = true;
                $('#divProductDetails').removeClass().addClass('show');
        }
      
    }
    if (blnExists == false) {
        document.getElementById('txtUnit').value = '';
        document.getElementById('txtBatchQuantity').value = '';
        ToTargetFormat($('#txtBatchQuantity'));
        document.getElementById('txtBatchNo').value = '';
        return false;
    }
}
function checkIsEmpty() {
    var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Alert" : SListForAppMsg.Get("InventoryCommon_Error");
    
    var updateBtn = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02") == null ? "Update" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02");
    if (document.getElementById('txtBatchNo').value.trim() == "") {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_05") == null ? "Provide the batch number" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_05");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtBatchNo').focus();
        return false;
    }

    if (document.getElementById('txtQuantity').value == "") {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_06") == null ? "Provide issue quantity" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_06");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }
    if (Number(ToInternalFormat($('#txtBatchQuantity'))) < Number(ToInternalFormat($('#txtQuantity')))) {
   
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_07") == null ? "Ensure the items added/quantity are provided properly" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_07");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }

    if (Number(document.getElementById('txtQuantity').value) < 1) {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_07") == null ? "Ensure the items added/quantity are provided properly" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_07");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }
    
    var remqty = document.getElementById('txtBatchQuantity').value - document.getElementById('txtreturnstock').value;
    var qty = document.getElementById('txtreturnstock').value;
    if (Number(document.getElementById('txtreturnstock').value) > (Number(document.getElementById('txtBatchQuantity').value) - Number(document.getElementById('txtQuantity').value))) {
        var usermsg1 = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_20") == null ? "This product have return sub store stock" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_20");
        var usermsg2 = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_21") == null ? "You can use remaining stock" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_21");
        var userMsg = usermsg1 + qty + usermsg2 + remqty + '.00';
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').value = "";
        document.getElementById('txtQuantity').focus();
        return false;
    }

    if (document.getElementById('add').value != updateBtn && $("#cheBarcodeSearch").length == 0) {
        var isTrue = true;
        $.each(lstProductList, function(obj, value) {
            if (document.getElementById('hdnReceivedUniqueNumber').value == value.ReceivedUniqueNumber) {
                var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_03") == null ? "Productname and batch number combination already exist" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_03");
                ValidationWindow(userMsg, errorMsg);
                isTrue = false;
            }
        });
        
        
        
        if (isTrue == false) {
            return false;
        }
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
    
    
    return BindProductList();
}

function BindProductList() {
    var updateBtn = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02") == null ? "Update" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02");
    if (document.getElementById('add').value == updateBtn) {
        var editData = JSON.parse($('#hdnRowEdit').val());
        if (editData != "") {
            var arrF = $.grep(lstProductList, function (n, i) {
            return n.ReceivedUniqueNumber != editData.ReceivedUniqueNumber
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
        var pPdtRcvdDtlsID = document.getElementById('hdnPdtRcvdDtlsID').value;
        var pReceivedUniqueNumber = document.getElementById('hdnReceivedUniqueNumber').value;
        var pBarcodeDetailsId = $("#hdnStockReceivedBarcodeDetailsID").length > 0 ? $("#hdnStockReceivedBarcodeDetailsID").val() : '0';
        var pBarcodeId = $("#hdnStockReceivedBarcodeID").length > 0 ? $("#hdnStockReceivedBarcodeID").val() : '0';
        var pBarcodeNo = $("#hdnBarcodeNo").length > 0 ? $("#hdnBarcodeNo").val() : '';
        var phdnIsUniqueBarcode = $("#hdnIsUniqueBarcode").length > 0 ? $("#hdnIsUniqueBarcode").val() : 'N';
        if (pHasExpiryDate == "Y") {
            var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
            if (expirylevel != '' && expirylevel != null) {
                if (expirylevel > 0) {
                    var isExpired = findExpiryItem(pExp, expirylevel);
                    if (isExpired == 2) {
                        var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
                        var informMsg = SListForAppMsg.Get("InventoryCommon_Information") == null ? "Information" : SListForAppMsg.Get("InventoryCommon_Information");
                        var okMsg = SListForAppMsg.Get("InventoryCommon_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryCommon_Ok")
                        var cancelMsg = SListForAppMsg.Get("InventoryCommon_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryCommon_Cancel");
                        var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_18") == null ? "The drug above Expired with in " + expirylevel + " Months. Do you want to continue!Click 'OK'" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_18");
                        userMsg = userMsg.replace("{0}", expirylevel)
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

        var objProduct = new Object();
        objProduct.ID = pId;
        objProduct.ProductName = pName;
        objProduct.BatchNo = pBatchNo;
        objProduct.InHandQuantity = pQTY;
        objProduct.Quantity = pQuantity;
        objProduct.Unit = pUnit;
        objProduct.ProductID = pProductId;
        objProduct.ParentProductID = pParentProductID;
        objProduct.Rate = parseFloat(pSellingPrice);
        objProduct.Tax = parseFloat(pTax);
        var Flag = $('#hdnAddFlag').val();
        if (Flag == 'Y') {
            objProduct.ExpiryDate = pExp;
        }
        else {
            objProduct.ExpiryDate = new Date(parseInt(pExp.substr(6)));
        }
        objProduct.HasExpiryDate = pHasExpiryDate;
        objProduct.HasBatchNo = pProBatchNo;
        objProduct.UnitPrice = parseFloat(pUnitPrice);
        objProduct.ProductReceivedDetailsID = pPdtRcvdDtlsID;
        objProduct.ReceivedUniqueNumber = pReceivedUniqueNumber;
        objProduct.StockReceivedBarcodeDetailsID = pBarcodeDetailsId;
        objProduct.StockReceivedBarcodeID = pBarcodeId;
        objProduct.BarcodeNo = pBarcodeNo;
        objProduct.IsUniqueBarcode = phdnIsUniqueBarcode;
                
        lstProductList.push(objProduct);
        $('#hdnProductList').val(JSON.stringify(lstProductList));
        $('#hdnAddFlag').val('N');

        Tblist();
            document.getElementById('txtQuantity').value = '';
            document.getElementById('txtUnit').value = '';

        var addBtn = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_10") == null ? "Add" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_10");
        document.getElementById('add').value = addBtn;
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

        if (lstProductList.length > 0) {
            var Headrow = document.getElementById('tblOrederedItems').insertRow(0);
            Headrow.id = "HeadID";
            Headrow.style.fontWeight = "bold";
            Headrow.className = "responstableHeader a-center"
            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            var cell4 = Headrow.insertCell(3);
            var cell5 = Headrow.insertCell(4);
            var cell6 = Headrow.insertCell(5);
            var cell7 = Headrow.insertCell(6);
            var ProductName = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_03") == null ? "Product Name" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_03");
            var BatchNo = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_04") == null ? "Batch No" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_04");
            var IssuedQty = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_05") == null ? "Issued Qty" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_05");
            var Unit = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_06") == null ? "Unit" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_06");
            var SellingPrice = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_07") == null ? "Selling Price" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_07");
            var Amount = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_08") == null ? "Amount" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_08");
            var Action = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_09") == null ? "Action" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_09");

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
                row.style.height = "13px";
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell4.className = "a-center";
                var cell5 = row.insertCell(4);
                cell5.className = "a-right";
                var cell6 = row.insertCell(5);
                cell6.className = "a-right";
                var cell7 = row.insertCell(6);

                //cell1.innerHTML = value.ProductName;
                if ($.trim(value.BarcodeNo) != "") {
                    cell1.innerHTML = value.ProductName + " - " + value.BarcodeNo;
                } else {
                    cell1.innerHTML = value.ProductName;
                }
                cell2.innerHTML = value.BatchNo;
                cell3.innerHTML = SetNumberFormat(value.Quantity);
                cell4.innerHTML = value.Unit;
                cell5.innerHTML = SetNumberFormat(value.Rate);
                document.getElementById('hdnDisplaydata').value = value.Quantity;
                var sp = ToInternalFormat($('#hdnDisplaydata'));
                document.getElementById('hdnDisplaydata').value = SetNumberFormat(value.Rate);
                var ap = ToInternalFormat($('#hdnDisplaydata'));
                document.getElementById('hdnDisplaydata').value = SetNumberFormat(parseFloat(ap * sp).toFixed(2));
                var tol = ToTargetFormat($('#hdnDisplaydata'));
                cell6.innerHTML = tol;
                tGrandTotal = parseFloat(parseFloat(tGrandTotal) + parseFloat(ap * sp));
                var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
                if (value.HasExpiryDate == "Y") {
                    if (expirylevel != '' && expirylevel != null) {
                        if (expirylevel > 0) {
                            var isExpired = findExpiryItem(value.ExpiryDate, expirylevel);
                            if (isExpired == 2) {
                                row.style.cssText = 'background-color: Orange !important';
                            }
                        }
                    }
                }
                var Edit = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_11") == null ? "Edit" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_11");
                var Delete = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_12") == null ? "Delete" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_12");
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
        }

    }


    function findExpiryItem(Expiredate, ConfigExpiryDateLevel) {
        var today = GetServerDate();
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

    function Deleterows_CSSD() {

        var RowEdit = document.getElementById('hdnRowEdit').value;
        var x = document.getElementById('hdnProductList').value.split("^");
        if (RowEdit != "") {
            var dropdown = $("#ddlLaundryStatus option:selected");
            var selected_value = dropdown.text();

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
            var pParentProductID = document.getElementById('hdnParentProductID').value;

            document.getElementById('hdnProductList').value = pId + "~" + pName + "~" +
                            pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" +
                            pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" + pProBatchNo + "~" + pHasExpiryDate + "~" + pUnitPrice + '~' + pParentProductID + '~' + selected_value + "^";


            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != RowEdit) {
                        document.getElementById('hdnProductList').value += x[i] + "^";
                    }
                }
            }

            Tblist_CSSD();
            document.getElementById('txtQuantity').value = '';
            document.getElementById('txtUnit').value = '';
        }
    }
    function Deleterows_Laundry() {

        var RowEdit = document.getElementById('hdnRowEdit').value;
        var x = document.getElementById('hdnProductList').value.split("^");
        if (RowEdit != "") {
            var dropdown = $("#ddlLaundryStatus option:selected");
            var selected_value = dropdown.text();
            var Linen_value = dropdown.val();

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
            var pParentProductID = document.getElementById('hdnParentProductID').value;
            //var pCategory = $("#yourdropdownid option:selected").text();

            document.getElementById('hdnProductList').value = pId + "~" + pName + "~" +
                            pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" +
                            pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" + pProBatchNo + "~" + pHasExpiryDate + "~" + pUnitPrice + "~" + pParentProductID + "~" + selected_value + "~" + Linen_value + "^";


            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != RowEdit) {
                        document.getElementById('hdnProductList').value += x[i] + "^";
                    }
                }
            }

            Tblist_Laundry();
            document.getElementById('txtQuantity').value = '';
            document.getElementById('txtUnit').value = '';
        }
    }

    function btnEdit_OnClick(sEditedData) {
       
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
        var updateBtn = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02") == null ? "Update" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02");
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
        document.getElementById('ddlLaundryStatus').value = sEditedData.CategoryID;
        
        $('#hdnAddFlag').val('Y');
        

        AutoCompBacthNo();
    }


    function btnEdit_Linen_OnClick(sEditedData) {
        btnDelete_Laundry(sEditedData);

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
        var updateBtn = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02") == null ? "Update" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02");
        document.getElementById('add').value = updateBtn;
        document.getElementById('divProductDetails').style.display = 'block';
        document.getElementById('hdnSellingPrice').value = y[7];
        document.getElementById('hdnTax').value = y[8];
        document.getElementById('hdnExpiryDate').value = y[9];
        document.getElementById('hdnProBatchNo').value = y[10];
        document.getElementById('hdnHasExpiryDate').value = y[11];
        document.getElementById('hdnUnitPrice').value = y[12];
        document.getElementById('hdnParentProductID').value = y[13];
        document.getElementById('ddlLaundryStatus').value = y[15];


        AutoCompBacthNo();
    }

    function btnDelete(sEditedData) {

        var arrF = $.grep(lstProductList, function(n, i) {
            return n.ReceivedUniqueNumber != sEditedData.ReceivedUniqueNumber && $.trim(n.Barcode) == "";
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

    function btnDelete_Laundry(sEditedData) {

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

        Tblist_Laundry();

        //        
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
        else{
      //  alert('select an organization');
        return false;
        }
        var SelectUserID = document.getElementById('ddlUser').options[document.getElementById('ddlUser').selectedIndex].value;

        if (SelectUserID > 0) {

            document.getElementById('hdnUserID').value = SelectUserID;
        }
//else{
//     //  alert('select the received by');
//       return false ;
//       }
        var Fromlocationid = document.getElementById('ddlLocation').options[document.getElementById('ddlLocation').selectedIndex].value;

        if (Fromlocationid > 0) {

            document.getElementById('hdnFromLocationID').value = Fromlocationid;
        }
        else {
            var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_08") == null ? "select the location" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_08");
 ValidationWindow(userMsg, errorMsg);
        return false ;
        }
    
    }
    
    //=================================

    function checkDetails(objFile) {

           if(locationdetails()==false){return false;} 
        var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");


        if (objFile == "StockIssued") {

            if (document.getElementById('ddlTrustedOrg').value == '0') {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_09") == null ? "Select the Organization" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_09");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlTrustedOrg').focus();
                return false;
            }
            if (document.getElementById('ddlLocation').value == '0') {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_10") == null ? "Select the issue to location" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_10");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlLocation').focus();
                return false;
            }
//            if (document.getElementById('ddlUser').value == '0') {
//                alert('Select the received by ');
//                document.getElementById('ddlUser').focus();
//                return false;
//            }
            document.getElementById('btnSubmit').style.display = "none";
        }
        if (objFile == "StockDamage") {
            if (document.getElementById('txtStockDamageDate').value == '') {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_11") == null ? "Select stock damage date" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_11");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtStockDamageDate').focus();
                return false;
            }

            if (document.getElementById('INVStockUsage1_hdnProductList').value == '') {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_12") == null ? "Select the product" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_12");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('INVStockUsage1_txtProduct').focus();
                return false;
            }

            document.getElementById('btnReturnStock').style.display = "none";
            
        
        }

        
        if (document.getElementById('hdnProductList').value == '') {
            
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_12") == null ? "Select the product" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_12");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtProduct').focus();
                return false;
            
        }




       
        return true;
    }


    function checkDetails_CSSD(objFile) {

        locationdetails_CSSD();
        var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");

        if (objFile == "StockIssued") {


            if (document.getElementById('ddlLocation').value == '0') {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_10") == null ? "Select the issue to location" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_10");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlLocation').focus();
                return false;
            }
//            if (document.getElementById('ddlUser').value == '0') {
//                alert('Select the received by ');
//                document.getElementById('ddlUser').focus();
//                return false;
//            }
            document.getElementById('btnSubmit').style.display = "none";
        }
        if (objFile == "StockDamage") {
            if (document.getElementById('txtStockDamageDate').value == '') {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_11") == null ? "Select stock damage date" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_11");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtStockDamageDate').focus();
                return false;
            }

            if (document.getElementById('INVStockUsage1_hdnProductList').value == '') {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_12") == null ? "Select the product" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_12");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('INVStockUsage1_txtProduct').focus();
                return false;
            }

            document.getElementById('btnReturnStock').style.display = "none";


        }


        if (document.getElementById('hdnProductList').value == '') {

var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_12") == null ? "Select the product" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_12");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtProduct').focus();
            return false;

        }





        return true;
    }
    function checkDetails_Laundry(objFile) {

        locationdetails_Laundry();
        var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
        
        if (objFile == "StockIssued") {


            if (document.getElementById('ddlLocation').value == '0') {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_10") == null ? "Select the issue to location" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_10");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlLocation').focus();
                return false;
            }
//            if (document.getElementById('ddlUser').value == '0') {
//                alert('Select the received by ');
//                document.getElementById('ddlUser').focus();
//                return false;
//            }
            document.getElementById('btnSubmit').style.display = "none";
        }
        if (objFile == "StockDamage") {
            if (document.getElementById('txtStockDamageDate').value == '') {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_11") == null ? "Select stock damage date" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_11");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtStockDamageDate').focus();
                return false;
            }

            if (document.getElementById('INVStockUsage1_hdnProductList').value == '') {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_12") == null ? "Select the product" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_12");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('INVStockUsage1_txtProduct').focus();
                return false;
            }

            document.getElementById('btnReturnStock').style.display = "none";


        }


        if (document.getElementById('hdnProductList').value == '') {

var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_12") == null ? "Select the product" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_12");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtProduct').focus();
            return false;

        }



        return true;
    }
    function checkIsEmpty_Laundry() {

        var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
        var updateBtn = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02") == null ? "Update" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02");
        if (document.getElementById('txtBatchNo').value.trim() == "") {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_05") == null ? "Provide the batch number" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_05");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtBatchNo').focus();
            return false;
        }

        if (document.getElementById('txtQuantity').value == "") {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_06") == null ? "Provide issue quantity" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_06");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtQuantity').focus();
            return false;
        }
        // if (Number(document.getElementById('txtBatchQuantity').value) < Number(document.getElementById('txtQuantity').value)) {
        if (Number(ToInternalFormat($('#txtBatchQuantity'))) < Number(ToInternalFormat($('#txtQuantity')))) {

var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_07") == null ? "Ensure the items added/quantity are provided properly" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_07");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtQuantity').focus();
            return false;
        }

        var dropdown = $("#ddlLaundryStatus option:selected");
        var selected_value = dropdown.val();

        if (selected_value == 0) {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_13") == null ? "Please Select Linen Category" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_13");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddlLaundryStatus').focus();
            return false;
        }
        if (Number(document.getElementById('txtQuantity').value) < 1) {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_07") == null ? "Ensure the items added/quantity are provided properly" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_07");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddlLaundryStatus').focus();
            return false;
        }

        if (document.getElementById('add').value != updateBtn || document.getElementById('add').value == updateBtn) {
            var x = document.getElementById('hdnProductList').value.split("^");
            var pId = document.getElementById('hdnReceivedID').value;
            var pName = document.getElementById('hdnProductName').value;
            var pProductID = document.getElementById('hdnProductId').value;
            var pCategory = $("#ddlLaundryStatus option:selected").text();
            var y; var i;
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');

                    if (y[14] == pCategory && y[0] == pId) {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_14") == null ? "This Product & Linen Category combination already exist" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_14");
 ValidationWindow(userMsg, errorMsg);

                        return false;
                    }

                }
            }
        }

        if (true) {
            return BindProductList_Laundry();
        }
        return false;
    }

    function AddLaundryItem() {

        var Isvalue = checkIsEmpty_Laundry();
        if (Isvalue == true) {
            BindProductList_Laundry();
            return true;
        }


        return false;
    }

    function checkIsEmpty_CSSD() {
        var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
        var updateBtn = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02") == null ? "Update" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02");
        if (document.getElementById('txtBatchNo').value.trim() == "") {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_05") == null ? "Provide the batch number" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_05");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtBatchNo').focus();
            return false;
        }

        if (document.getElementById('txtQuantity').value == "") {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_06") == null ? "Provide issue quantity" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_06");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtQuantity').focus();
            return false;
        }
        // if (Number(document.getElementById('txtBatchQuantity').value) < Number(document.getElementById('txtQuantity').value)) {
        if (Number(ToInternalFormat($('#txtBatchQuantity'))) < Number(ToInternalFormat($('#txtQuantity')))) {

var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_07") == null ? "Ensure the items added/quantity are provided properly" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_07");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtQuantity').focus();
            return false;
        }

        var dropdown = $("#ddlLaundryStatus option:selected");
        var selected_value = dropdown.val();

        if (selected_value == 0) {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_15") == null ? "PLease Select Linen Category" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_15");
 ValidationWindow(userMsg, errorMsg);
            //document.getElementById('txtQuantity').focus();
            return false;
        }
        if (Number(document.getElementById('txtQuantity').value) < 1) {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_07") == null ? "Ensure the items added/quantity are provided properly" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_07");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddlLaundryStatus').focus();
            return false;
        }

        if (document.getElementById('add').value != updateBtn) {
            var x = document.getElementById('hdnProductList').value.split("^");
            var pId = document.getElementById('hdnReceivedID').value;
            var pName = document.getElementById('hdnProductName').value;

            var y; var i;
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    if (y[0] == pId) {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_03") == null ? "Product number and batch number combination already exist" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_03");
 ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtProduct').value = '';
                        document.getElementById('txtProduct').focus();
                        return false;
                    }
                }
            }
        }
        //        if (document.getElementById('add').value == 'Update') 
        //        {
        //            
        //            var x = document.getElementById('hdnProductList').value.split("^");
        //            var pId = document.getElementById('hdnReceivedID').value;
        //            var pName = document.getElementById('hdnProductName').value;

        //            var y; var i;
        //            for (i = 0; i < x.length; i++)
        //             {
        //                 if (x[i] != "") 
        //                {
        //                    y = x[i].split('~');
        //                    if (y[0] == pId)
        //                     {
        //                       // alert('Product number and batch number combination already exist');
        //                        document.getElementById('txtProduct').value = '';
        //                        document.getElementById('txtProduct').focus();
        //                        return true;
        //                    }
        //                }
        //            }
        //        }

        return BindProductList_CSSD();
        return false;
    }
    function BindProductList_Laundry() {
        var updateBtn = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02") == null ? "Update" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02");
        if (document.getElementById('add').value == updateBtn) {
            var editData = JSON.parse($('#hdnRowEdit').val());
            if (editData != "") {
                var arrF = $.grep(lstProductList, function (n, i) {
                    return n.ID != editData.ID
                });
                lstProductList = [];
                lstProductList = arrF;
            }
        }
       // else {
            var dropdown = $("#ddlLaundryStatus option:selected");
            var selected_value = dropdown.text();
            var Linen_value = dropdown.val();

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
            var pPdtRcvdDtlsID = document.getElementById('hdnPdtRcvdDtlsID').value;
            var pReceivedUniqueNumber = document.getElementById('hdnReceivedUniqueNumber').value;
            if (pHasExpiryDate == "Y") {
                var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
                if (expirylevel != '' && expirylevel != null) {
                    if (expirylevel > 0) {
                        var isExpired = findExpiryItem(pExp, expirylevel);
                        if (isExpired == 2) {
                            var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
                            var informMsg = SListForAppMsg.Get("InventoryCommon_Information") == null ? "Information" : SListForAppMsg.Get("InventoryCommon_Information");
                            var okMsg = SListForAppMsg.Get("InventoryCommon_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryCommon_Ok")
                            var cancelMsg = SListForAppMsg.Get("InventoryCommon_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryCommon_Cancel");
                            var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_18") == null ? "The drug above Expired with in " + expirylevel + " Months. Do you want to continue!Click 'OK'" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_18");
                            userMsg = userMsg.replace("{0}", expirylevel)
                            var Replay = ConfirmWindow(userMsg, informMsg, okMsg, cancelMsg);
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
            objProduct.Rate = parseFloat(pSellingPrice);
            objProduct.Tax = parseFloat(pTax);
            objProduct.ExpiryDate = new Date(parseInt(pExp.substr(6)));
            objProduct.HasExpiryDate = pHasExpiryDate;
            objProduct.HasBatchNo = pProBatchNo;
            objProduct.UnitPrice = parseFloat(pUnitPrice);
            objProduct.Remarks = selected_value;
            objProduct.ProductReceivedDetailsID = pPdtRcvdDtlsID;
            objProduct.ReceivedUniqueNumber = pReceivedUniqueNumber;
            objProduct.CategoryID = Linen_value;
            lstProductList.push(objProduct);
        //}
        $('#hdnProductList').val(JSON.stringify(lstProductList));

            Tblist_Laundry();
            document.getElementById('txtQuantity').value = '';
            document.getElementById('txtUnit').value = '';
        var addBtn = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_10") == null ? "Add" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_10");
        document.getElementById('add').value = addBtn;
        document.getElementById('txtProduct').value = '';
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }
		$('#ddlLaundryStatus').val(0);
        return false;

    }

    function BindProductList_CSSD() {
        var updateBtn = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02") == null ? "Update" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_02");
        if (document.getElementById('add').value == updateBtn) {

            Deleterows_CSSD();

        }
        else {

            var dropdown = $("#ddlLaundryStatus option:selected");
            var selected_value = dropdown.text();

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
            var pPdtRcvdDtlsID = document.getElementById('hdnPdtRcvdDtlsID').value;
            if (pHasExpiryDate == "Y") {
                var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
                if (expirylevel != '' && expirylevel != null) {
                    if (expirylevel > 0) {
                        var isExpired = findExpiryItem(pExp, expirylevel);
                        if (isExpired == 2) {
                            var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
                            var informMsg = SListForAppMsg.Get("InventoryCommon_Information") == null ? "Information" : SListForAppMsg.Get("InventoryCommon_Information");
                            var okMsg = SListForAppMsg.Get("InventoryCommon_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryCommon_Ok")
                            var cancelMsg = SListForAppMsg.Get("InventoryCommon_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryCommon_Cancel");
                            var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_18") == null ? "The drug above Expired with in " + expirylevel + " Months. Do you want to continue!Click 'OK'" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_18");
                            userMsg = userMsg.replace("{0}", expirylevel)
                            var Replay = ConfirmWindow(userMsg, informMsg, okMsg, cancelMsg);
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
                        pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" + pProBatchNo + "~" + pHasExpiryDate + "~" + pUnitPrice + '~' + pParentProductID + '~' + selected_value + "^";
            Tblist_CSSD();
            document.getElementById('txtQuantity').value = '';
            document.getElementById('txtUnit').value = '';

        }
        var addBtn = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_10") == null ? "Add" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_10");
        document.getElementById('add').value = addBtn;
        document.getElementById('txtProduct').value = '';
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }
        return false;

    }

    function Tblist_Laundry() {

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
        var ProductName = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_03") == null ? "Product Name" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_03");
        var BatchNo = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_04") == null ? "Batch No" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_04");
        var sendQty = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_13") == null ? "Send Qty" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_13");
        var Unit = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_06") == null ? "Unit" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_06");
        var linenCategory = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_14") == null ? "Linen Category" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_14");
        var Action = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_09") == null ? "Action" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_09");

        cell1.innerHTML = ProductName;
        cell2.innerHTML = BatchNo;
        cell3.innerHTML = sendQty;
        cell4.innerHTML = Unit;
        cell5.innerHTML = linenCategory;
        cell6.innerHTML = Action;

        var x = document.getElementById('hdnProductList').value.split("^");
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

            cell1.innerHTML = value.ProductName;
            cell2.innerHTML = value.BatchNo;
            cell3.innerHTML = SetNumberFormat(value.Quantity);
            cell4.innerHTML = value.Unit;
            cell5.innerHTML = value.Remarks;

            document.getElementById('hdnDisplaydata').value = value.Quantity;
            var sp = ToInternalFormat($('#hdnDisplaydata'));

            document.getElementById('hdnDisplaydata').value = value.Rate;
            var ap = ToInternalFormat($('#hdnDisplaydata'));

                document.getElementById('hdnDisplaydata').value = parseFloat(ap * sp).toFixed(2);

                var tol = ToTargetFormat($('#hdnDisplaydata'));
                cell6.innerHTML = tol;

            tGrandTotal = parseFloat(parseFloat(tGrandTotal) + parseFloat(ap * sp));
            var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
            if (value.HasExpiryDate == "Y") {
                if (expirylevel != '' && expirylevel != null) {
                    if (expirylevel > 0) {
                        var isExpired = findExpiryItem(value.ExpiryDate, expirylevel);
                        if (isExpired == 2) {
                            row.style.cssText = 'background-color: Orange !important';
                        }
                    }
                }
            }
            var Edit = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_11") == null ? "Edit" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_11");
            var Delete = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_12") == null ? "Delete" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_12");
            cell6.innerHTML = "<input name='Edit' onclick='btnEdit_OnClick(" + JSON.stringify(value) + ");' value = '' type='button' class='ui-icon ui-icon-pencil pull-left'  /> " +
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


    }
    function Tblist_CSSD() {
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
        var ProductName = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_03") == null ? "Product Name" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_03");
        var BatchNo = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_04") == null ? "Batch No" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_04");
        var sendQty = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_13") == null ? "Send Qty" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_13");
        var Unit = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_06") == null ? "Unit" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_06");
        var Action = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_09") == null ? "Action" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_09");
        cell1.innerHTML = ProductName;
        cell2.innerHTML = BatchNo;
        cell3.innerHTML = sendQty;
        cell4.innerHTML = Unit;

        cell5.innerHTML = Action;

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



                cell1.innerHTML = y[1];
                cell2.innerHTML = y[2];
                cell3.innerHTML = y[3];
                cell4.innerHTML = y[4];
                cell5.innerHTML = y[14];

                document.getElementById('hdnDisplaydata').value = y[3];
                var sp = ToInternalFormat($('#hdnDisplaydata'));

                document.getElementById('hdnDisplaydata').value = y[7];
                var ap = ToInternalFormat($('#hdnDisplaydata'));

                document.getElementById('hdnDisplaydata').value = parseFloat(ap * sp).toFixed(2);

                var tol = ToTargetFormat($('#hdnDisplaydata'));
                cell5.innerHTML = tol;

                tGrandTotal = parseFloat(parseFloat(tGrandTotal) + parseFloat(ap * sp));
                var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
                if (y[11] == "Y") {
                    if (expirylevel != '' && expirylevel != null) {
                        if (expirylevel > 0) {
                            var isExpired = findExpiryItem(y[9], expirylevel);
                            if (isExpired == 2) {
                                row.style.cssText = 'background-color: Orange !important';
                            }
                        }
                    }
                }
                var Edit = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_11") == null ? "Edit" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_11");
                var Delete = SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_12") == null ? "Delete" : SListForAppDisplay.Get("InventoryCommon_Scripts_InvStockUsage_js_12");
                cell5.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
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
        document.getElementById('hdnParentProductID').value = '';
        //document.getElementById('tblOrederedItems').style.display = 'block';


    }




    function locationdetails_Laundry() {

        var SelectUserID = document.getElementById('ddlUser').options[document.getElementById('ddlUser').selectedIndex].value;

        if (SelectUserID > 0) {

            document.getElementById('hdnUserID').value = SelectUserID;
        }
        else {
            //  alert('select the received by');
            return false;
        }
        var Fromlocationid = document.getElementById('ddlLocation').options[document.getElementById('ddlLocation').selectedIndex].value;

        if (Fromlocationid > 0) {

            document.getElementById('hdnFromLocationID').value = Fromlocationid;
        }
        else {
            var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_08") == null ? "select the location" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_08");
 ValidationWindow(userMsg, errorMsg);
            return false;
        }

    }



    function locationdetails_CSSD() {

        var SelectUserID = document.getElementById('ddlUser').options[document.getElementById('ddlUser').selectedIndex].value;

        if (SelectUserID > 0) {

            document.getElementById('hdnUserID').value = SelectUserID;
        }
        else {
            //  alert('select the received by');
            return false;
        }
        var Fromlocationid = document.getElementById('ddlLocation').options[document.getElementById('ddlLocation').selectedIndex].value;

        if (Fromlocationid > 0) {

            document.getElementById('hdnFromLocationID').value = Fromlocationid;
        }
        else {
            var errorMsg = SListForAppMsg.Get("InventoryCommon_Error") == null ? "Error" : SListForAppMsg.Get("InventoryCommon_Error");
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_08") == null ? "select the location" : SListForAppMsg.Get("InventoryCommon_Scripts_InvStockUsage_js_08");
 ValidationWindow(userMsg, errorMsg);
            return false;
        }

    }

    function SetNumberFormat(Decimalvalue) {
        $('#hdnDisplaydata').val(Decimalvalue);
        ToTargetFormat($('#hdnDisplaydata'));
        return $('#hdnDisplaydata').val();
    }


     

     
    

   
    
