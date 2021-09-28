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
        document.getElementById('lblProdDesc').innerHTML = '';
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
                document.getElementById('divProductDetails').style.display = 'block';
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

function KeyPress1(e) {

    var ddlaction = document.getElementById('ddlKitNames');
    if (ddlaction.options[ddlaction.selectedIndex].text == '--Select--') {
        alert('Select Kit Names');
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
    //    if (document.getElementById('txtBatchNo').value.trim() != "") {
    var BatchNoList = document.getElementById('hdnBatchList').value.split("^");
    for (i = 0; i < BatchNoList.length; i++) {
        if (BatchNoList[i] != "") {
            var val = BatchNoList[i].split("~");
            if (val[0].toUpperCase() == (document.getElementById('txtBatchNo').value.trim()).toUpperCase()) {
                document.getElementById('hdnProductName').value = val[1];
                document.getElementById('hdnReceivedID').value = val[2];
                document.getElementById('txtBatchQuantity').value = val[4];
                document.getElementById('txtQuantity').value = val[5];

                document.getElementById('txtUnit').value = val[6];
                document.getElementById('hdnSellingPrice').value = val[7];
                document.getElementById('hdnTax').value = val[8];
                document.getElementById('hdnCategoryID').value = val[9];
                document.getElementById('hdnExpiryDate').value = val[10];
                document.getElementById('hdnStockInHandID').value = val[11];
                document.getElementById('hdnIntendID').value = val[12];
                document.getElementById('hdnUnitPrice').value = val[17];
                document.getElementById('chkIsReimburse').checked = val[18] == "Y" ? true : false;

//                if (document.getElementById('chkIsReimburse').checked == true) {

//                    document.getElementById('hdnIsReimbursable').value = "Y";
//                }
//                else {
//                    document.getElementById('hdnIsReimbursable').value = "N";
//                }
                




                // document.getElementById('txtQuantity').focus();
                blnExists = true; break;
            }
        }
    }
    //    }
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
        var pProductId = document.getElementById('hdnProductId').value;
        var pName = document.getElementById('hdnProductName').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        var y; var i;
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
                //y[2] == pBatchNo
                if (y[6] == pProductId && y[2] == pBatchNo) {
                    alert('This Product is already  already added');
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
        var pStockInHandID = document.getElementById('hdnStockInHandID').value;
        var pIntendID = document.getElementById('hdnIntendID').value;
        var pCategoryID = document.getElementById('hdnCategoryID').value;
        var pUnitPrice = document.getElementById('hdnUnitPrice').value;
        if (document.getElementById('chkIsReimburse') != null)
        var pIsReimbursable = document.getElementById('chkIsReimburse').checked == true ? "Y" : "N";
        
        
//        if (document.getElementById('hdnIsReimbursable') != null) {
//            var pIsReimbursable = document.getElementById('hdnIsReimbursable').value;
//        }
//        
        

        document.getElementById('hdnProductList').value += pId + "~" + pName + "~" +
                        pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" +
                        pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" + pIntendID + "~" + pCategoryID + "~" + pStockInHandID + "~" + pUnitPrice + "~" + pIsReimbursable + "^";
        Tblist();
//        GetSmallestDate();
//        document.getElementById('txtExpiryDate').value = new Date(GetSmallestDate()).format("dd/MM/yyyy"); 
        document.getElementById('txtQuantity').value = '';
        document.getElementById('txtUnit').value = '';
        

    }
    document.getElementById('add').value = 'Add';
    document.getElementById('txtProduct').value = '';
    document.getElementById('lblProdDesc').innerHTML = '';
   
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
    var cell8 = Headrow.insertCell(7);


    cell1.innerHTML = "Product Name";
    cell2.innerHTML = "Batch No";
    cell3.innerHTML = "Issued Qty";
    cell4.innerHTML = "Unit";
    cell5.innerHTML = "Selling Price";
    cell6.innerHTML = "Amount";
    cell7.innerHTML = "IsReimbursable";
    cell8.innerHTML = "Action";

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
            var cell8 = row.insertCell(7);


            cell1.innerHTML = y[1];
            cell2.innerHTML = y[2];
            cell3.innerHTML = y[3];
            cell4.innerHTML = y[4];
            cell5.innerHTML = y[7];
            cell6.innerHTML = parseFloat(y[3] * y[7]).toFixed(2);
            tGrandTotal = parseFloat(parseFloat(tGrandTotal) + parseFloat(y[3] * y[7])).toFixed(2);
            cell7.innerHTML = y[14];
//            var d = new Date(y[9]);
//            var expdete = d.getDay() + "/" + d.getMonth() + "/" + d.getFullYear();
//            document.getElementById('txtExpiryDate').value = expdete;
//            alert(expdete);
//            document.getElementById('txtExpiryDate').value = y[9];
            cell8.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
        }
    }
    //document.getElementById('txtExpiryDate').value='';
    document.getElementById('hdnProBatchNo').value = '';
    document.getElementById('txtBatchNo').value = '';
    document.getElementById('txtBatchQuantity').value = '';
    document.getElementById('hdnBatchList').value = '';
    document.getElementById('hdnUnitPrice').value = '';
    document.getElementById('hdnIsReimbursable').value = '';
    document.getElementById('divProductDetails').style.display = 'none';
    document.getElementById('txtProduct').focus();
  //  document.getElementById('chkIsReimburse').checked = false;
    if (document.getElementById('chkIsReimburse') != null) {
       // document.getElementById('chkIsReimburse').checked = false;
    }


}



function GetSmallestDate() {

    var x = document.getElementById('hdnProductList').value.split("^");

    var SmallestDate = new Date(x[0].split('~')[9]);
    for (i = 1; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');
            var TempDate = new Date(x[i].split('~')[9]);
            if (TempDate < SmallestDate)
                SmallestDate = TempDate;

        }
        return SmallestDate;
    }
    
//    var SmallestDate = new Date(DateArray[0]);
//    for (var i = 1; i < DateArray.length; i++) {
//        var TempDate = new Date(DateArray[i]);
//        if (TempDate < SmallestDate)
//            SmallestDate = TempDate;
//    }
//    return SmallestDate; 
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
        var pIntendID = document.getElementById('hdnIntendID').value;
        var pCategoryID = document.getElementById('hdnCategoryID').value
        var pStockInHandID = document.getElementById('hdnStockInHandID').value;
        var pUnitPrice = document.getElementById('hdnUnitPrice').value;
        var pIsReimbursable = document.getElementById('chkIsReimburse').checked ? "Y" : "N";
       

        document.getElementById('hdnProductList').value = pId + "~" + pName + "~" +
                            pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" +
                            pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" + pIntendID + "~" + pCategoryID + "~" + pStockInHandID + "~" + pUnitPrice + "~" + pIsReimbursable + "^";


        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                if (x[i] != RowEdit) {
                    document.getElementById('hdnProductList').value += x[i] + "^";
                }
            }
        }
        Tblist();
//        document.getElementById('txtExpiryDate').value = new Date(GetSmallestDate()).format("dd/MM/yyyy");
        document.getElementById('txtQuantity').value = '';
        document.getElementById('txtUnit').value = '';
    }
}

function btnEdit_OnClick(sEditedData) {
    var y = sEditedData.split('~');

    document.getElementById('hdnReceivedID').value = y[0];
    document.getElementById('hdnProductName').value = y[1];
    document.getElementById('txtProduct').value = y[1];
    if (y[2] == "*") {
        document.getElementById('txtBatchNo').disabled = true;
    }
    else {
        document.getElementById('txtBatchNo').disabled = false;
    }
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
    document.getElementById('hdnProBatchNo').value = y[2];
    document.getElementById('hdnIntendID').value = y[10];
    document.getElementById('hdnCategoryID').value = y[11];
    document.getElementById('hdnStockInHandID').value = y[12];
    document.getElementById('hdnUnitPrice').value = y[13];
   // document.getElementById('hdnIsReimbursable').value = y[14];
    document.getElementById('chkIsReimburse').checked = y[14] == "Y" ? true : false;


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
//    document.getElementById('txtExpiryDate').value = new Date(GetSmallestDate()).format("dd/MM/yyyy");
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

function Checkquanity() {
    var temp = 0;
   
    var x = document.getElementById('hdnProductList').value.split("^");
    var grid = document.getElementById('hdngridviewdata').value.split("^");
    var y; var i;
    var g; 
    var data;
    
//    if (x.length != grid.length) {
//        alert("No. of Products are not same in Kit Box Products");
//        document.getElementById('txtProduct').focus();
//        return false;

//    }
    for (data = 0; data < grid.length; data++) {
        if (grid[data] != "") {
            g = grid[data].split('~');
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    if (g[1] == y[0]) {
               
                        temp = parseInt(y[3]) + parseInt(temp);
                    }
                }
            }

            if (temp < g[3] && temp != 0) {
                alert("Table List " + g[2] + " Product is Lesser than kit qunatity ");
                document.getElementById('ddlKitNames').focus();
                return false;
            }
            if (temp > g[3] && temp != 0) {
                alert("Table List " + g[2] + " Product is greater than kit qunatity ");
                document.getElementById('ddlKitNames').focus();
                return false;
            }
           

           
            if(temp <= 0){
                alert("No. of Products are not same in Kit Box Products");
                     document.getElementById('txtProduct').focus();
                        return false;
            }


            temp = 0;
            g[3] = 0;
           // PID = 0;
        }
    }
   
    return true;
}

function checkDetails() {
//    if (document.getElementById('ddlLocation').value == '0') {
//        alert('Select the issue to location ');
//        document.getElementById('ddlLocation').focus();
//        return false;
//    }
    if (document.getElementById('ddlKitNames').value == '0') {
        alert('Select the received by ');
        document.getElementById('ddlKitNames').focus();
        return false;
    }
  Checkquanity();

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


function doGetProductTotalQuantity(source, eventArgs) {
    // alert(eventArgs.get_value());

    if (document.getElementById('txtProduct').value.length < 2) {
        document.getElementById("lblProdDesc").innerHTML = "";
    } else {
        var tblString = new Array();
        tblString[0] = "<table border ='1px' class='dataheaderInvCtrl' width='100%'>";
        tblString[1] = "<tr class='dataheader1' align='center'><td>Product</td><td>Batch No.</td><td>Exp. Date</td><td>Selling Price</td><td>Available Qty.</td></tr>";
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

                var pdate = new Date();
                pdate = new Date(tblData[10]);

                var d = pdate.getDate() + "/" + pdate.getMonth() + "/" + pdate.getFullYear();
                if (tblData[10] != "**") {

                }


                tblString[2] += "<tr><td>" + tblData[1] + "</td><td>" + tblData[3] + "</td><td align='left'>" + d + "</td><td>" + tblData[7] + "</td><td align='right'>" + tblData[6] + "(" + tblData[4] + ")" + "</td></tr>";
                sum += parseFloat(tblData[4]);
                unit = "(" + tblData[6] + ")";
            }
        }
        tblString[2] += "<tr><td colspan='4' align='right'>Total</td><td align='right'>" + sum.toFixed(2) + unit + "</td></tr>";
        document.getElementById("lblProdDesc").innerHTML = tblString[0] + tblString[1] + tblString[2] + tblString[3];
    }
}

function doClearTable() {
    if (document.getElementById('txtProduct').value.length < 2) {
        document.getElementById("lblProdDesc").innerHTML = "";
    }
}



function KitBatchCount() {
    ////debugger;
    var exptrue = true;


    if (document.getElementById('ddlKitNames').value == '0') {
        alert('Select the received by ');
        document.getElementById('ddlKitNames').focus();
        return false;
    }

    if (document.getElementById('txtKitNos').value == '') {
        alert('Provide KitNos ');
        document.getElementById('txtKitNos').focus();
        return false;
    }

    var kitbatchkitNos = document.getElementById('hdnKitBatchQty').value;
    var ExpBatchNos = document.getElementById('hdnExpMonth').value;
    var kitNos = document.getElementById('txtKitNos').value;
    var Minimumlife = document.getElementById('txtMinimumlife').value;

    if (Number(ExpBatchNos) >= Number(Minimumlife)) {
        document.getElementById('txtMinimumlife').value = Minimumlife;
        exptrue = true;

    }
    else {

        if (ExpBatchNos != "" && ExpBatchNos != "0") {
            if (confirm(ExpBatchNos + " month is minimum shelf-life of this Kit.\n Do you want to continue?")) {
                document.getElementById('txtMinimumlife').value = ExpBatchNos;
                exptrue = true;

            }
            else {
                document.getElementById('txtMinimumlife').value = '';
                document.getElementById('txtMinimumlife').focus();
                exptrue = false;

            }
        }
        else {
            alert("Check Product Quantity")
            return false;
        }

    }



    if (exptrue == true) {

        if (Number(kitbatchkitNos) >= Number(kitNos)) {

            document.getElementById('txtKitNos').value = kitNos;
            return true;

        }


        else {
            if (kitbatchkitNos != "" && kitbatchkitNos != "0") {
                if (confirm(kitbatchkitNos + " - KitBatch Can be Created in this Kit.\n Do you want to continue?")) {

                    document.getElementById('txtKitNos').value = kitbatchkitNos;
                    return true;

                }
                else {
                    document.getElementById('txtKitNos').value = '';
                    document.getElementById('txtKitNos').focus();
                    return false;

                }
            }
            else {
                alert("Check Product Quantity")
                return false;
            }


        }
    }
    else {

        return false;
    }
}
