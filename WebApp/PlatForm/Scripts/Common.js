/* Event Functions */
// Add an event to the obj given
// event_name refers to the event trigger, without the "on", like click or mouseover
// func_name refers to the function callback when event is triggered
var YearofBirth;
if (!String.prototype.trim) {
    String.prototype.trim = function() {
        return this.replace(/^\s+|\s+$/g, '');
    };
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
// Removes an event from the object
function removeEvent(obj, event_name, func_name) {
    if (obj.detachEvent) {
        obj.detachEvent("on" + event_name, func_name);
    } else if (obj.removeEventListener) {
        obj.removeEventListener(event_name, func_name, true);
    } else {
        obj["on" + event_name] = null;
    }
}
// Stop an event from bubbling up the event DOM
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
// Get the obj that starts the event
function getElement(evt) {
    if (window.event) {
        return window.event.srcElement;
    } else {
        return evt.currentTarget;
    }
}
// Get the obj that triggers off the event
function getTargetElement(evt) {
    if (window.event) {
        return window.event.srcElement;
    } else {
        return evt.target;
    }
}
// For IE only, stops the obj from being selected
function stopSelect(obj) {
    if (typeof obj.onselectstart != 'undefined') {
        addEvent(obj, "selectstart", function() { return false; });
    }
}
/*    Caret Functions     */
// Get the end position of the caret in the object. Note that the obj needs to be in focus first
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

// Remove of InPatientRegistration Organs Delete

function OrganDonationDeleteRow(id, did) {

    var count = 0;
    document.getElementById(id).style.display = "none";

    document.getElementById(did).value = document.getElementById(did).value + id + ",";
    var rowlist = document.getElementById('gridTab').rows;
    var rowcount = document.getElementById('gridTab').rows.length;
    for (i = 1; i < rowcount; i++) {
        if (rowlist[i].style.display == "none") {
            count = count + 1;

        }
    }

    if (count == (rowcount - 1)) {


        document.getElementById('gridTab').style.display = "none";
    }

}



// Get the start position of the caret in the object
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
// sets the caret position to l in the object
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
// sets the caret selection from s to e in the object
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
/*    Escape function   */
String.prototype.addslashes = function() {
    return this.replace(/(["\\\.\|\[\]\^\*\+\?\$\(\)])/g, '\\$1');
}
String.prototype.trim = function() {
    return this.replace(/^\s*(\S*(\s+\S+)*)\s*$/, "$1");
};
/* --- Escape --- */
/* Offset position from top of the screen */
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
/* ------ End of Offset function ------- */
/* Types Function */
// is a given input a number?
function isNumber(a) {
    return typeof a == 'number' && isFinite(a);
}
/* Object Functions */
function replaceHTML(obj, text) {
    while (el = obj.childNodes[0]) {
        obj.removeChild(el);
    };
    obj.appendChild(document.createTextNode(text));
}
/*---------------Common.js----------------*/
function ChangeImage() {
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (Number(document.getElementById('txtDue').value) > 0) {
        animatedcollapse.toggle('Due');
        if (document.getElementById('imgDue').src.split('Images')[1] == '/collapse.jpg')
            document.getElementById('imgDue').src = '../PlatForm/Images/expand.jpg';
        else if (document.getElementById('imgDue').src.split('Images')[1] == '/expand.jpg')
            document.getElementById('imgDue').src = '../PlatForm/Images/collapse.jpg';
    }
    else {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_01") == null ? "There is no due for this invoice" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_01");
 ValidationWindow(userMsg, errorMsg);
    }
}
function format_number(pnumber, decimals) {
    if (isNaN(pnumber)) { return 0 };
    if (pnumber == '') { return 0 };
    var snum = new String(pnumber);
    var sec = snum.split('.');
    var whole = parseFloat(sec[0]);
    var result = '';
    if (sec.length > 1) {
        var dec = new String(sec[1]);
        dec = String(parseFloat(sec[1]) / Math.pow(10, (dec.length - decimals)));
        dec = String(whole + Math.round(parseFloat(dec)) / Math.pow(10, decimals));
        var dot = dec.indexOf('.');
        if (dot == -1) {
            dec += '.';
            dot = dec.indexOf('.');
        }
        while (dec.length <= dot + decimals) { dec += '0'; }
        result = dec;
    } else {
        var dot;
        var dec = new String(whole);
        dec += '.';
        dot = dec.indexOf('.');
        while (dec.length <= dot + decimals) { dec += '0'; }
        result = dec;
    }

    return result;
}

function format_number_withSign(pnumber, decimals) {
    var result = Math.round(pnumber * Math.pow(10, decimals)) / Math.pow(10, decimals);
    return result;
}
function format_number_withSignNone(pnumber, decimals) {
    var result = Math.round(pnumber * Math.pow(1, decimals)) / Math.pow(1, decimals);
    return result;
}
//function Digitonly(e) {
//    if (event.keyCode < 48 || event.keyCode > 57) {
//        return false;
//    }
//}
function onKeyPressBlockNumbers(e) {
    var key = window.event ? e.keyCode : e.which;
    var keychar = String.fromCharCode(key);
    reg = /\d/;
    return !reg.test(keychar);
}
function ExcedDate11(objFrm, objT, ValidateObj) {
    var regExp = /^(([0-2]\d|[3][0-1])\/([0]\d|[1][0-2])\/[2][0]\d{2})$|^(([0-2]\d|[3][0-1])\/([0]\d|[1][0-2])\/[2][0]\d{2}\s([0-1]\d|[2][0-3])\:[0-5]\d\:[0-5]\d)$/;
    var objTo = document.getElementById(objT);
    var objFrom = document.getElementById(objFrm);
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (objFrom.value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_02") == null ? "Provide valid date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_02");
 ValidationWindow(userMsg, errorMsg);
        objFrom.focus();
        return false;
    }
    if (!objFrom.value.match(regExp)) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_03") == null ? "Date is not in a valid format" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_03");
 ValidationWindow(userMsg, errorMsg);
        objFrom.value = "";
        objFrom.focus();
        return false;
    }
    if (objTo.value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_02") == null ? "Provide valid date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_02");
 ValidationWindow(userMsg, errorMsg);
        objTo.focus();
        return false;
    }
    if (!objTo.value.match(regExp)) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_03") == null ? "Date is not in a valid format" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_03");
 ValidationWindow(userMsg, errorMsg);
        objTo.value = "";
        objTo.focus();
        return false;
    }
    var F1 = objFrom.value.split('/');
    var FDtTime = new Date(F1[2] + '/' + F1[1] + '/' + F1[0]);
    var FMonth = FDtTime.getMonth() + 1;
    var FDay = FDtTime.getDate();
    var FYear = FDtTime.getFullYear();

    var T1 = objTo.value.split('/');
    var TDtTime = new Date(T1[2] + '/' + T1[1] + '/' + T1[0]);
    var TMonth = TDtTime.getMonth() + 1;
    var TDay = TDtTime.getDate();
    var TYear = TDtTime.getFullYear();

    //var cDate = GetServerDate().format("dd/MM/yyyy").split('/');
    //var currentTime = new Date(cDate[2] + '/' + cDate[1] + '/' + cDate[0]);
    var currentTime = GetServerDate();
    var CMonth = currentTime.getMonth() + 1;
    var CDay = currentTime.getDate();
    var CYear = currentTime.getFullYear();
    if (ValidateObj != "1") {
        if (FYear < CYear || (FYear == CYear && FMonth < CMonth) || (FYear == CYear && FMonth == CMonth && FDay < CDay)) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_04") == null ? "Invalid date. Provide only a future date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_04");
 ValidationWindow(userMsg, errorMsg);
            objFrom.focus();
            return false;
        }
    }
    if (TYear < CYear || (TYear == CYear && TMonth < CMonth) || (TYear == CYear && TMonth == CMonth && TDay < CDay)) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_04") == null ? "Invalid date. Provide only a future date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_04");
 ValidationWindow(userMsg, errorMsg);
        objTo.focus();
        return false;
    }
    if (FYear > TYear || (FYear == TYear && FMonth > TMonth) || (FYear == TYear && FMonth == TMonth && FDay > TDay)) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_05") == null ? "Mismatch between from and to date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_05");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
    return true;
}
function ExcedDate(obj1, StartDt, wedFlag, BAflage) {
    var obj = document.getElementById(obj1);
    var currentTime;
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (obj.value != '' && obj.value != '__/__/____') {
        dobDt = obj.value.split('/');
        if (dobDt.length < 2) {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_06") == null ? "Invalid date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_06");
            ValidationWindow(userMsg, errorMsg);
            obj.value = '__/__/____';
            obj.focus();
            return false;
        }
        var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
        var mMonth = dobDtTime.getMonth() + 1;
        var mDay = dobDtTime.getDate();
        var mYear = dobDtTime.getFullYear();
        if (wedFlag == 0) {
            currentTime = GetServerDate();
        }
        else {
            wedDt = document.getElementById(StartDt).value.split('/');
            var currentTime = new Date(wedDt[2] + '/' + wedDt[1] + '/' + wedDt[0]);
        }
        var month = currentTime.getMonth() + 1;
        var day = currentTime.getDate();
        var year = currentTime.getFullYear();
        if (BAflage == 0) {
            if (mYear > year) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_06") == null ? "Invalid date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_06");
 ValidationWindow(userMsg, errorMsg);
                obj.value = '__/__/____';
                obj.focus();
                return false;
            }
            else if (mYear == year && mMonth > month) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_06") == null ? "Invalid date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_06");
 ValidationWindow(userMsg, errorMsg);
                obj.value = '__/__/____';
                obj.focus();
                return false;
            }
            else if (mYear == year && mMonth == month && mDay > day) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_06") == null ? "Invalid date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_06");
 ValidationWindow(userMsg, errorMsg);
                obj.value = '__/__/____';
                obj.focus();
                return false;
            }
        }
        else {
            if (mYear < year) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_04") == null ? "Invalid date. Provide only a future date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_04");
 ValidationWindow(userMsg, errorMsg);
                obj.value = '__/__/____';
                obj.focus();
                return false;
            }
            else if (mYear == year && mMonth < month) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_04") == null ? "Invalid date. Provide only a future date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_04");
 ValidationWindow(userMsg, errorMsg);
                obj.value = '__/__/____';
                obj.focus();
                return false;
            }
            else if (mYear == year && mMonth == month && mDay < day) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_04") == null ? "Invalid date. Provide only a future date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_04");
 ValidationWindow(userMsg, errorMsg);
                obj.value = '__/__/____';
                obj.focus();
                return false;
            }
        }
        return true;
    }
    else {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_06") == null ? "Invalid date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_06");
 ValidationWindow(userMsg, errorMsg);
        obj.focus();
        return false;
    }
}


function setDOBYear(id) {
    var ageVal = document.getElementById(id);
    if (ageVal.value != '') {
        if (ageVal.value.length < 3) {
            var days = GetServerDate();
            //var gdate = days.getDate();
            //var gmonth = days.getMonth();
            var gyear = days.getFullYear();
            dobYear = gyear - ageVal.value;
            document.getElementById('tDOB').value = '01/01/' + dobYear;
        }
    }
}
function setSexValue(sexId, msId) {
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].value);
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);
    if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '12') {
        document.getElementById(sexId).value = 'M';
    }
    else if (document.getElementById(msId).value == '2'  || document.getElementById(msId).value == '9' || document.getElementById(msId).value == '10' || document.getElementById(msId).value == '11') {
        document.getElementById(sexId).value = 'F';
    }
      else {
       
        if (!($('#QPR_hdnsexvalueset').val() == "") || ($('#QPR_hdnsexvalueset').val() == "undefined")) {
         if ($('#QPR_hdnsexvalueset').val() == "Y") {
                document.getElementById(sexId).value = 'M';
            }
            else {
       
                document.getElementById(sexId).value = '0';
            }
        }
}
    if (document.getElementById(msId).value == '4' || document.getElementById(msId).value == '8' || document.getElementById(msId).value == '7' || document.getElementById(msId).value == '5') {
        document.getElementById(sexId).value = '0'
    }
    // document.getElementById(sexId).value = '0';
}
function setSalValue(sexId, msId) {
    if (document.getElementById(msId).value == "0") {
        if (document.getElementById(sexId).value == 'M') {
            if ((document.getElementById(msId).value == '2' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '9' || document.getElementById(msId).value == '10' || document.getElementById(msId).value == '11') && document.getElementById(msId).value != '8')
            //document.getElementById(msId).value != '1' && document.getElementById(msId).value != '3' && document.getElementById(msId).value != '5' && document.getElementById(msId).value != '6' && document.getElementById(msId).value != '7'  && document.getElementById(msId).value != '12') {
            {
                document.getElementById(msId).value = '1';
            }

        }
        else {
            if ((document.getElementById(msId).value == '1' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '6' || document.getElementById(msId).value == '7' || document.getElementById(msId).value == '12') && document.getElementById(msId).value != '8') {
                //document.getElementById(msId).value != '2' && document.getElementById(msId).value != '4' && document.getElementById(msId).value != '9' && document.getElementById(msId).value != '10' && document.getElementById(msId).value != '8'  && document.getElementById(msId).value != '11') {
                document.getElementById(msId).value = '2';
            }
        }

        if (document.getElementById(msId).value == '4') {
            document.getElementById(sexId).value = '0'
        }
        if (document.getElementById(msId).value != '5') {
            document.getElementById(msId).value = '0';
            //document.getElementById('ddMarital').value = '0';
        }
    }
}
function setSexValueQB(sexId, msId, ddMaritalID, hdnddlSex) {

    //       alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].value);
    //        alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);|| document.getElementById(msId).value == '7'
    if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '6' || document.getElementById(msId).value == '8' || document.getElementById(msId).value == '12' || document.getElementById(msId).value == '15') {
        document.getElementById(sexId).value = 'M';
    }
    else if (document.getElementById(msId).value == '2' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '9' || document.getElementById(msId).value == '10' || document.getElementById(msId).value == '11') {
        document.getElementById(sexId).value = 'F';
    }
    else if (document.getElementById(msId).value != '5') {
        document.getElementById(sexId).value = '0'
    }
    if (document.getElementById(msId).value == '10' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '2' || document.getElementById(msId).value == '1') {
        document.getElementById(ddMaritalID).value = 'S';
    }
    else if (document.getElementById(msId).value == '9') {
        document.getElementById(ddMaritalID).value = 'M';
    }
    else {
        document.getElementById(ddMaritalID).value = '0';
    }

    if (document.getElementById(msId).value == '7') {
        document.getElementById(sexId).value = '0'
    }
    document.getElementById(ddMaritalID).value = "0";
    document.getElementById(hdnddlSex).value = document.getElementById(sexId).value;
}
//Sri changes start
function setsalutationValueQB(sexId, msId, ddMaritalID) {

    if ((document.getElementById(sexId).value == 'F') && (document.getElementById(ddMaritalID).value == 'S')) {
        document.getElementById(msId).value = '2'
    }
    else if ((document.getElementById(sexId).value == 'F') && (document.getElementById(ddMaritalID).value == 'M')) {
        document.getElementById(msId).value = '9'
    }
    else if (document.getElementById(sexId).value == 'F') {
        document.getElementById(msId).value = '2'
    }
    else if (document.getElementById(sexId).value == 'M') {
        document.getElementById(msId).value = '1'
    }
    else {
        document.getElementById(msId).value = '0'
    }
}
//End
function setSexValueopt(sexId, msId) {
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].value);
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);|| document.getElementById(msId).value == '7' 
    if (document.getElementById(msId).value == '6' || document.getElementById(msId).value == '8' || document.getElementById(msId).value == '9') {
        document.getElementById(sexId).value = 'M';
    }
    else if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '2' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '11') {
        document.getElementById(sexId).value = 'F';
    }

    if (document.getElementById(msId).value == '4') {
        document.getElementById(sexId).value = '0'
    }
    document.getElementById(msId).value = '0';
}
function setSexValueNew(sexId, msId) {

    var ddlSex = $('select[id*=' + sexId);
    var SalutCtrl = $('select[id*=' + msId);
    var SalutValue = $('select[id*=' + msId).val();
    if (ddlSex.val() == 'M') {
        if ((SalutValue == '0' || SalutValue == '2'  || SalutValue == '9' || SalutValue == '10' || SalutValue == '11') && SalutValue != '8') {
            SalutCtrl.val('1');
        }
    }
    else if (ddlSex.val() == '0') {
        SalutCtrl.val('0');
    }
    else {
        if ((SalutValue == '0' || SalutValue == '1' || SalutValue == '3' || SalutValue == '5' || SalutValue == '6' || SalutValue == '7' || SalutValue == '12') && SalutValue != '8') {
            SalutCtrl.val('2');
        }
    }

}
function setSexValueBySting(sexId, msId) {
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);
    var salutaionValue = document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text;
    if (salutaionValue == 'Mr.' || salutaionValue == 'Master.'  || salutaionValue == 'Prof.' || salutaionValue == 'Col.' || salutaionValue == 'Dr.') {
        document.getElementById(sexId).value = 'M';
    }

    else if (salutaionValue == 'Ms.' || salutaionValue == 'Mrs.' || salutaionValue == 'Sister.' || salutaionValue == 'Shri.' || salutaionValue == 'Thirumathi') {
        document.getElementById(sexId).value = 'F';
    }
    else {
        document.getElementById(sexId).value = '0';
    }

    if (document.getElementById(msId).value == '4') {
        document.getElementById(sexId).value = '0'
    }
}
function echeck(str) {
    var at = "@"
    var dot = "."
    var lat = str.indexOf(at)
    var lstr = str.length
    var ldot = str.indexOf(dot)
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (str.indexOf(at) == -1) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_07") == null ? "Invalid e-mail id" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_07");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
    if (str.indexOf(at) == -1 || str.indexOf(at) == 0 || str.indexOf(at) == lstr) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_07") == null ? "Invalid e-mail id" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_07");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
    if (str.indexOf(dot) == -1 || str.indexOf(dot) == 0 || str.indexOf(dot) == lstr) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_07") == null ? "Invalid e-mail id" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_07");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
    if (str.indexOf(at, (lat + 1)) != -1) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_07") == null ? "Invalid e-mail id" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_07");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
    if (str.substring(lat - 1, lat) == dot || str.substring(lat + 1, lat + 2) == dot) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_07") == null ? "Invalid e-mail id" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_07");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
    if (str.indexOf(dot, (lat + 2)) == -1) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_07") == null ? "Invalid e-mail id" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_07");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
    if (str.indexOf(" ") != -1) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_07") == null ? "Invalid e-mail id" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_07");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
    return true;
}
// These are for the paste Event
function BeforePaste_Event() {
    // Cancel default behavior
    event.returnValue = false;
}
function Paste_Event() {
    // This is for Getting the Source Element..
    var objTxtBox = window.event.srcElement;
    // Cancel default behavior, ie., The Pasting Functionality..
    event.returnValue = false;
    // Still if you need to paste but need to check some condition, you can use the below codes
    // Get the pasted value from the clipboard..
    var PasteData = window.clipboardData.getData('Text');

    if (PasteData.length < 0) {
        // This is the case where the pasted text is float and it is less than 24,
        objTxtBox.value = PasteData;
    }
}
/*Admin Reports*/
function setChkEnabled() {
    if (document.getElementById("chkToday").checked) {
        document.getElementById("txtFrom").value = '';
        document.getElementById("txtTo").value = '';
        document.getElementById("ImageButton1").disabled = true;
        document.getElementById("ImageButton2").disabled = true;
        return true;
    }
    else if (!document.getElementById("chkToday").checked) {
        document.getElementById("ImageButton1").disabled = false;
        document.getElementById("ImageButton2").disabled = false;
        return true;
    }
}
function setTxtEnabled() {
    document.getElementById("chkToday").checked = false;
    document.getElementById("ImageButton1").disabled = false;
    document.getElementById("ImageButton2").disabled = false;
    return true;
}
function compareDate() {
    if (document.getElementById('chkToday').checked == false) {
        var inputFromDt = document.getElementById('TextBox1').value.split('/');
        var fromDate = new Date(inputFromDt[2] + '/' + inputFromDt[0] + '/' + inputFromDt[1]);

        var inputToDt = document.getElementById('TextBox2').value.split('/');
        var toDate = new Date(inputToDt[2] + '/' + inputToDt[0] + '/' + inputToDt[1]);

        if (toDate > fromDate) { return true }
        else {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_08") == null ? "To date must be greater than  or equal to from date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_08");
 var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
            return false;
        }
    }
}
/*Doctor Schedule*/
function sheduleTimeValidation(frmId, toId) {
    var frmTAddRail;
    var toTAddRail;
    var frmTHrsRail;
    var toTHrsRail;
    var frmTSplit = document.getElementById(frmId).value.split(' ');
    var frmTimeHrs = document.getElementById(frmId).value.split(':');
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    for (var i = 0; i < frmTSplit.length; i++) {
        if (frmTSplit[i] == 'AM') {
            frmTAddRail = parseFloat(frmTSplit[i - 1]);
            frmTHrsRail = frmTimeHrs[i].substr(0, 2);
        }
        if (frmTSplit[i] == 'PM') {
            if (parseFloat(frmTSplit[i - 1]) == 12) {
                frmTAddRail = (parseFloat(frmTSplit[i - 1]) - 12.00);
            }
            else {
                frmTAddRail = (parseFloat(frmTSplit[i - 1]) + 12.00);
            }
            frmTHrsRail = frmTimeHrs[i].substr(0, 2);
        }
    }
    var toTSplit = document.getElementById(toId).value.split(' ');
    var toTimeHrs = document.getElementById(toId).value.split(':');
    for (var i = 0; i < toTSplit.length; i++) {
        if (toTSplit[i] == 'AM') {
            toTAddRail = parseFloat(toTSplit[i - 1]);
            toTHrsRail = toTimeHrs[i].substr(0, 2);
        }
        if (toTSplit[i] == 'PM') {
            if (parseFloat(toTSplit[i - 1]) == 12) {
                toTAddRail = (parseFloat(toTSplit[i - 1]) - 12.00);
            }
            else {
                toTAddRail = (parseFloat(toTSplit[i - 1]) + 12.00);
            }
            toTHrsRail = toTimeHrs[i].substr(0, 2);
        }
    }
    if (frmTAddRail <= toTAddRail) {
        if (frmTAddRail == toTAddRail && frmTHrsRail >= toTHrsRail) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_09") == null ? "Scheduled timing is invalid" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_09");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById(frmId).focus();
            return false;
        }
    }
    else {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_09") == null ? "Scheduled timing is invalid" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_09");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById(frmId).focus();
        return false;
    }
    return true;
}

function loadMonths() {

        //if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == "Daily") {
    if (document.getElementById('ddlRepeat').value == "1") {
        document.getElementById('dRepeat').style.display = 'none';
        var htmlDays = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_01") == null ? "Days" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_01");
        document.getElementById('lblMW').innerHTML = htmlDays;
        document.getElementById('dMonthly').style.display = 'none';
        document.getElementById('dWeekly').style.display = 'block';
        document.getElementById('dRepeat').disabled = true;
        document.getElementById('ddlMonths').value = 1;
        document.getElementById('chkDays_0').checked = true;
        document.getElementById('chkDays_1').checked = true;
        document.getElementById('chkDays_2').checked = true;
        document.getElementById('chkDays_3').checked = true;
        document.getElementById('chkDays_4').checked = true;
        document.getElementById('chkDays_5').checked = true;
        document.getElementById('chkDays_6').checked = true;
        document.getElementById('chkDays_0').disabled = true;
        document.getElementById('chkDays_1').disabled = true;
        document.getElementById('chkDays_2').disabled = true;
        document.getElementById('chkDays_3').disabled = true;
        document.getElementById('chkDays_4').disabled = true;
        document.getElementById('chkDays_5').disabled = true;
        document.getElementById('chkDays_6').disabled = true;
    }
//    else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == "Weekly") {
    else if (document.getElementById('ddlRepeat').value == "2") {
        document.getElementById('dRepeat').style.display = 'block';
        var htmlWeeks = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_02") == null ? "Weeks" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_02");
        document.getElementById('lblMW').innerHTML = htmlWeeks;
        document.getElementById('dMonthly').style.display = 'none';
        document.getElementById('dWeekly').style.display = 'block';
        document.getElementById('dRepeat').disabled = false;
        document.getElementById('chkDays_0').checked = false;
        document.getElementById('chkDays_1').checked = false;
        document.getElementById('chkDays_2').checked = false;
        document.getElementById('chkDays_3').checked = false;
        document.getElementById('chkDays_4').checked = false;
        document.getElementById('chkDays_5').checked = false;
        document.getElementById('chkDays_6').checked = false;
        document.getElementById('chkDays_0').disabled = false;
        document.getElementById('chkDays_1').disabled = false;
        document.getElementById('chkDays_2').disabled = false;
        document.getElementById('chkDays_3').disabled = false;
        document.getElementById('chkDays_4').disabled = false;
        document.getElementById('chkDays_5').disabled = false;
        document.getElementById('chkDays_6').disabled = false;
    }
    else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == "Monthly") {
        document.getElementById('dRepeat').style.display = 'block';
        var htmlMonths = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_03") == null ? "Months" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_03");
        document.getElementById('lblMW').innerHTML = htmlMonths;
        document.getElementById('dMonthly').style.display = 'block';
        document.getElementById('dWeekly').style.display = 'none';
        document.getElementById('dRepeat').disabled = false;

    }
    else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == "Yearly") {
        document.getElementById('dRepeat').style.display = 'block';
        document.getElementById('dRepeat').disabled = true;
        var htmlYears = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_04") == null ? "Years" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_04");
        document.getElementById('lblMW').innerHTML = htmlYears;
        document.getElementById('dMonthly').style.display = 'none';
        document.getElementById('dWeekly').style.display = 'none';

    }

    //    else {
    //        document.getElementById('dRepeat').style.display = 'block';
    //        document.getElementById('dMonthly').style.display = 'none';
    //        document.getElementById('dWeekly').style.display = 'none';
    //    }

    if (document.getElementById('tDOB').value != '') {
        loadText();
    }
    else {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_10") == null ? "Select date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_10");
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('ddlRepeat').value = '1';
        document.getElementById('tDOB').focus();
        document.getElementById('dRepeat').style.display = 'none';
        document.getElementById('dMonthly').style.display = 'none';
        document.getElementById('dWeekly').style.display = 'none';
    }

}
function loadText() {
    var days = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
    var months = new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');
    var chkText;
    var count = 0;
    var rptDays = 0;
    var number;
    for (var i = 0; i < 7; i++) {
        if (document.getElementById('chkDays_' + i).checked) {
            if (count == 0) {
                rptDays = days[i];
                count++;
            }
            else {
                rptDays = rptDays + "," + days[i];
            }
        }
    }
    //to get the day from given date
    if (rptDays == 0) {
        var date = document.getElementById('tDOB').value;
        date = date.split('/');
        var mydate = new Date(date[2], date[1] - 1, date[0]);
        var dayno = mydate.getDay();
        rptDays = days[dayno];
    }
    if ((document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Weekly')
    && (document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML == '1')) {
        document.getElementById('dWords').style.display = 'block';
        var rptWeekly = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_05") == null ? "Weekly on " : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_05");
        document.getElementById('lblRepeatWords').innerHTML = rptWeekly + rptDays;
    }
    else if ((document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Weekly')
&& (document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML != '1')) {
        document.getElementById('dWords').style.display = 'block';
        number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
        var rptEvery = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_06") == null ? "Every" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_06");
        var rptWeeks = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_07") == null ? "weeks on" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_07");
        document.getElementById('lblRepeatWords').innerHTML = rptEvery + number + rptWeeks + rptDays;
    }
    else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Daily') {
        document.getElementById('dWords').style.display = 'block';
        number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
        if (number == '1') {
        var rptEveryDay = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_08") == null ? "Every day" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_08");
            document.getElementById('lblRepeatWords').innerHTML = rptEveryDay;
        }
        else {
        var rptEvery = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_06") == null ? "Every" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_06");
        var rptDay = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_09") == null ? "days" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_09");
        document.getElementById('lblRepeatWords').innerHTML = rptEvery + number + rptDay;
        }
    }
    else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Monthly') {
        if (document.getElementById('rdrptBy_0').checked == true) {
            document.getElementById('dWords').style.display = 'block';
            number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
            var date = document.getElementById('tDOB').value;
            date = date.split('/');
            var rptEvery = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_06") == null ? "Every" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_06");
            var rptMonth = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_10") == null ? "months on day" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_10");
            document.getElementById('lblRepeatWords').innerHTML = rptEvery + number + rptMonth + date[0];
        }
        else if (document.getElementById('rdrptBy_1').checked == true) {
            document.getElementById('dWords').style.display = 'block';
            number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
            var date = document.getElementById('tDOB').value;
            date = date.split('/');
            var mydate1 = new Date(date[2], date[1] - 1, date[0]);
            var dayno = mydate1.getDay();
            rptDays = days[dayno];
            var FDofMonth = new Date(mydate1.getYear(), mydate1.getMonth(), 1);
            var weekNo = GetServerDate();
            var weekText;
            for (i = 0; i < 5; i++) {
                if (i == 0) {
                    weekNo.setDate(FDofMonth.getDate() + 7);
                    if (mydate1 <= weekNo) {
                        weekText = "First";
                        break;
                    }
                }
                else if (i == 1) {
                    weekNo.setDate(FDofMonth.getDate() + 14);
                    if (mydate1 <= weekNo) {
                        weekText = "Second";
                        break;
                    }
                }
                else if (i == 2) {
                    weekNo.setDate(FDofMonth.getDate() + 21);
                    if (mydate1 <= weekNo) {
                        weekText = "Third";
                        break;
                    }
                }
                else if (i == 3) {
                    weekNo.setDate(FDofMonth.getDate() + 28);
                    if (mydate1 <= weekNo) {
                        weekText = "Fourth";
                        break;
                    }
                }
                else {
                    weekText = "Fifth";
                    break;
                }
            }
            document.getElementById('weekNo').value = weekText;
            if (document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML == '1') {
            var rptMonthly = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_11") == null ? "Monthly on " : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_11");
                document.getElementById('lblRepeatWords').innerHTML = rptMonthly + weekText + " " + rptDays;

            }
            else {
                number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
                var rptEvery = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_06") == null ? "Every" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_06");
                var rptMonthOn = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_12") == null ? "months on the" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_12");
                document.getElementById('lblRepeatWords').innerHTML = rptEvery + number + rptMonthOn + weekText + " " + rptDays;

            }
        }
        else {
            document.getElementById('rdrptBy_0').checked = true;
            document.getElementById('dWords').style.display = 'block';
            number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
            var date = document.getElementById('tDOB').value;
            date = date.split('/');
            var rptEvery = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_06") == null ? "Every" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_06");
            var rptMonth = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_10") == null ? "months on day" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_10");
            document.getElementById('lblRepeatWords').innerHTML = rptEvery + number + rptMonth + date[0];
        }
    }
    else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Yearly') {
        document.getElementById('dWords').style.display = 'block';
        number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
        var date = document.getElementById('tDOB').value.split('/');
        var mon = date[1];
        var rptEvery = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_06") == null ? "Every" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_06");
        var rptYears = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_13") == null ? "years on" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_13");
        document.getElementById('lblRepeatWords').innerHTML = rptEvery + number + rptYears + months[date[1] - 1] + " " + date[0];
    }
    else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Yearly') {
        document.getElementById('dWords').style.display = 'block';
        number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
        var rptEvery = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_06") == null ? "Every" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_06");
        var rptDay = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_09") == null ? "days" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_09");
        document.getElementById('lblRepeatWords').innerHTML = rptEvery + number + rptDay;
    }
}
function daysInMonth(iMonth, iYear) {
    alert(32 - new Date(iYear, iMonth, 32).getDate());
}

/*Advice.ascx*/
function CheckValidation() {
    //tDName, tFrm, tDose, tROA, tFRQ, tDura
    //    if (document.getElementById('tDName').value == '') {
    //        document.getElementById('tDName').focus();
    //        return false;
    //    }
    //    if (document.getElementById('tFrm').value == '') {
    //        document.getElementById('tFrm').focus();
    //        return false;
    //    }
    return true;
}
var test;
function DeleteRow(id, did, rowindex) {
    var count = 0;
    //    var m = elem.rowIndex;
    //    alert("Row Index: " + m);

    //    alert(id);
    document.getElementById(id).style.display = "none";
    //alert(rowindex);
    //document.getElementById('uAd_tabDrg').deleteRow(rowindex);
    //uAd_tabDrg.deleteRow(1);
    //   var oRow = src.parentElement.parentElement;
    //   alert(oRow.rowIndex);
    //once the row reference is obtained, delete it passing in its rowIndex
    //   document.all("uAd_tabDrg").deleteRow(1);//oRow.rowIndex); 

    document.getElementById(did).value = document.getElementById(did).value + id + ",";
    var rowlist = document.getElementById('uAd_tabDrg').rows;
    var rowcount = document.getElementById('uAd_tabDrg').rows.length;
    for (i = 1; i < rowcount; i++) {
        if (rowlist[i].style.display == "none") {
            count = count + 1;

        }
    }

    if (count == (rowcount - 1)) {

        document.getElementById('uAd_tDName').value = '';
        document.getElementById('uAd_tFrm').value = '';
        //document.getElementById('uAd_tROA').value = '';
        document.getElementById('uAd_tDose').value = '';
        document.getElementById('uAd_tabDrg').style.display = "none";
    }

}
//    function fillDrugs() {
//        var dName = document.getElementById('<%=tDName.ClientID%>').value;
//        if (Number(dName.length) == 2)
//            WebService.GetDrugName(dName, LoadDrugs);
//    }
function LoadDrugs(result) {
    if (result != null) {
        var drugName = new actb(document.getElementById('uAd_tDName'), result);
    }
}
function autoFill(cId) {
    var dName = document.getElementById(cId).value;
    if (dName != '') {
        WebService.getDrugs(dName, onDrugSelected);
    }
    else {
        document.getElementById('uAd_tFrm').value = '';
        document.getElementById('uAd_tFrm').value = '';
        document.getElementById('uAd_tDose').value = '';
        // document.getElementById('uAd_tROA').value = '';
        document.getElementById('uAd_tFRQ').value = '';
        document.getElementById('uAd_tDura').value = '';
        //document.getElementById('uAd_tDName').focus();
    }
}
function onDrugSelected(result) {
    if (result != null) {
        if (result.length > 0) {
            var formulation = new Array(result.length);
            var Dose = new Array(result.length);
            var ROA = new Array(result.length);
            for (i = 0; i < result.length; i++) {
                var values = result[i].split(",");
                formulation[i] = values[0];
                Dose[i] = values[1];
                ROA[i] = values[2];
            }
        }
        document.getElementById('uAd_tFrm').value = formulation[0];
        document.getElementById('uAd_tDose').value = Dose[0];
        // document.getElementById('uAd_tROA').value = ROA[0];
    }
}
function FillDose(cId, dID) {
    //    alert('dId');
    var Formulation = document.getElementById(cId).value;
    var drugName = document.getElementById(dID).value;
    // alert(drugName);
    if (Formulation != '') {
        WebService.getDose(Formulation, drugName, onFormulationSelected);
    }
    else {
        document.getElementById('uAd_tDose').value = '';
        //document.getElementById('uAd_tROA').value = '';
        document.getElementById('uAd_tFRQ').value = '';
        document.getElementById('uAd_tDura').value = '';
        // document.getElementById('uAd_tDName').focus();
    }
}
function onFormulationSelected(result) {
    if (result != null) {
        if (result.length > 0) {
            var Dose = new Array(result.length);
            var ROA = new Array(result.length);

            for (i = 0; i < result.length; i++) {
                var values = result[i].split(",");
                Dose[i] = values[0];
                ROA[i] = values[1];
            }
        }
        document.getElementById('uAd_tDose').value = Dose[0];
        //document.getElementById('uAd_tROA').value = ROA[0];
    }
}
/*Fees Entry.ascx*/
function PopUp() {
    var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
    strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=320,width=500";
    // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
    strFeatures = strFeatures + ",left=150,top=250";
    window.open("DialysisCaseSheetPrint.aspx", "", strFeatures, "");
}

/*Patient Search.ascx*/
function SelectRowCommon(rid, patid, patOrgID, patNumber, isSurgeryPatient, PatientRegStatus) {
    chosen = "";
    var len = document.forms[0].elements.length;
    for (var i = 0; i < len; i++) {
        if (document.forms[0].elements[i].type == "radio") {
            document.forms[0].elements[i].checked = false;
        }
    }
    document.getElementById(rid).checked = true;
    document.getElementById("pid").value = patid;
    document.getElementById("patOrgID").value = patOrgID
    document.getElementById("PNumber").value = patNumber
    document.getElementById("hdnIsSurgeryPatient").value = isSurgeryPatient
    document.getElementById("hdnPatientRegistrationStatus").value = PatientRegStatus
}
/*DialysisCaseSheetPrint.aspx*/
function PrintMe() {
    document.getElementById('btnPrint').style.visibility = "hidden";
    document.getElementById('btnCancel').style.visiblilty = "hidden";
    window.print();

    document.getElementById('btnPrint').style.visibility = "visible";
    document.getElementById('btnCancel').style.visiblilty = "visible";
}
/*DialysisOnFlow.aspx*/
var currentStatus;
var previousStatus;
function showLink(targetID, bidid) {
    window.location.href = '#' + targetID;

    if (previousStatus == null) {
        previousStatus = bidid;
        currentStatus = bidid;
        var obj = document.getElementById(bidid);
        obj.className = 'SelectedBid';
    }
    else {
        previousStatus = currentStatus;
        currentStatus = bidid;
        var obj1 = document.getElementById(previousStatus);
        obj1.className = 'tablerow';
        var obj2 = document.getElementById(currentStatus);
        obj2.className = 'SelectedBid';
    }
}
function adjustPickList(layerId, topPos) {
    var obj = document.getElementById(layerId);
    obj.style.top = 63 + "px";
}
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
    if (init == true) with (navigator) {
        if ((appName == "Netscape") && (parseInt(appVersion) == 4)) {
            document.MM_pgW = innerWidth; document.MM_pgH = innerHeight; onresize = MM_reloadPage;
        }
    }
    else if (innerWidth != document.MM_pgW || innerHeight != document.MM_pgH) location.reload();
}
/*DialysisRecord.aspx*/
function CalcWeightGain() {

    var pwt = document.getElementById('txtprevWt').value;
    var cwt = document.getElementById('txtPreWeight').value;
    if (isNaN(pwt) || pwt == '0' || pwt == '') {
        document.getElementById('txtprevWt').value = "";
        document.getElementById('txtWtGain').value = "";
        return false;
    }
    cwt = parseFloat(cwt) - parseFloat(pwt);
    document.getElementById('txtWtGain').value = cwt.toString();
}
function Page_Load() {
var saveBtn = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_14") == null ? "Save" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_14");
var finishBtn = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_15") == null ? "Finish" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_15");
    if (document.getElementById('btnSubmit').value == saveBtn) {
        document.getElementById('ACX2plus1').style.display = 'none';
        document.getElementById('ACX2minus1').style.display = 'block';
        document.getElementById('ACX2responses1').style.display = 'block';
        document.getElementById('ACX2plus2').style.display = 'none';
        document.getElementById('ACX2minus2').style.display = 'block';
        document.getElementById('ACX2responses2').style.display = 'block';
        document.getElementById('tblOnflowDetail').style.display = 'none';
        document.getElementById('txtPreSBP').focus();
    }
    if (document.getElementById('btnSubmit').value == finishBtn) {
        document.getElementById('tblOnflowDetail').style.display = 'block';
        document.getElementById('ACX2plus1').style.display = 'block';
        document.getElementById('ACX2minus1').style.display = 'none';
        document.getElementById('ACX2responses1').style.display = 'none';
        document.getElementById('ACX2plus2').style.display = 'block';
        document.getElementById('ACX2minus2').style.display = 'none';
        document.getElementById('ACX2responses2').style.display = 'none';
        document.getElementById('txtPostTemp').focus();
    }
}
function adjustPickList(layerId, topPos) {
    var obj = document.getElementById(layerId);
    obj.style.top = 63 + "px";
}
/*Investigation.aspx*/
function toggleDiv(divid) {
    if (document.getElementById(divid).style.display == 'block') {
        document.getElementById(divid).style.display = 'none';
    } else {
        document.getElementById(divid).style.display = 'block';
    }
}
function isEmptyTxt() {
    if (document.getElementById('txtSearchText').value == '') {
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_11") == null ? "Provide search text" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_11");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
    return true;
}
function PeripheralRedCellMorphology() {
    if (document.getElementById('tabContain_tp2001_r2018_0').checked)
        document.getElementById('divMorphology').style.display = "none";
    else
        document.getElementById('divMorphology').style.display = "block";
}
function PeripheralRedCellDistribution() {
    if (document.getElementById('tabContain_tp2001_r2019_0').checked)
        document.getElementById('divDistribution').style.display = "none";
    else
        document.getElementById('divDistribution').style.display = "block";
}
function PeripheralParasitesPresent() {
    if (document.getElementById('tabContain_tp2001_r2030_0').checked)
        document.getElementById('divParasites').style.display = "none";
    else
        document.getElementById('divParasites').style.display = "block";
}
function OthersHbElectroPhoresis() {
    if (document.getElementById('tabContain_tp2001_r2041_0').checked)
        document.getElementById('divElectroAbNormal').style.display = "none";
    else
        document.getElementById('divElectroAbNormal').style.display = "block";
}
function UrineCellsCastsPresent() {
    if (document.getElementById('tabContain_tp4001_dd4011').options[document.getElementById('tabContain_tp4001_dd4011').selectedIndex].innerHTML == 'Present')
        document.getElementById('divCastsPresent').style.display = "block";
    else
        document.getElementById('divCastsPresent').style.display = "none";
}
function loadHepatitis() {
    if (document.getElementById('tabContain_tp4001_r4086_1').checked == true)
        document.getElementById('divHepat').style.display = "block";
    else
        document.getElementById('divHepat').style.display = "none";
}
function showMalignant() {
    if (document.getElementById('tabContain_tp4001_r4075_1').checked == true)
        document.getElementById('divMalignant').style.display = "block";
    else
        document.getElementById('divMalignant').style.display = "none";
}
function checkTotal() {
    var Lympho = document.getElementById('tabContain_tp4001_t4054').value;
    var Mono = document.getElementById('tabContain_tp4001_t4055').value;
    var Neutro = document.getElementById('tabContain_tp4001_t4056').value;
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if ((Lympho > 100 || Lympho != '') || (Mono > 100 || Mono != '') || (Neutro > 100 || Neutro != '')) {
        var Total = Number(Lympho) + Number(Mono) + Number(Neutro);
        if (Total != 100)
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_12") == null ? "Sum of differential count should be equal to 100" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_12");
 ValidationWindow(userMsg, errorMsg);
    }
    else {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_13") == null ? "Value cannot exceed 100 / value cannot be empty" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_13");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('tabContain_tp4001_t4056').focus();
    }
}
function liverTotal() {
    var tot = document.getElementById('tabContain_tp3001_t3032').value;
    var dir = document.getElementById('tabContain_tp3001_t3033').value;
    var inDir = document.getElementById('tabContain_tp3001_t3034').value;
    alert(tot);
}
function totBilirubin() {
    var tot = document.getElementById('tabContain_tp3001_t3032').value;
    var dir = document.getElementById('tabContain_tp3001_t3033').value;
    var inDir = document.getElementById('tabContain_tp3001_t3034').value;
    if (tot == '0')
        tot = '0';
    if (dir == '0')
        dir = '0';
    if (inDir == '0')
        inDir = '0';
    document.getElementById('tabContain_tp3001_t3034').value = Number(tot) - Number(dir);
}
function totProteins() {
    var tot = document.getElementById('tabContain_tp3001_t3036').value;
    var alb = document.getElementById('tabContain_tp3001_t3037').value;
    var glo = document.getElementById('tabContain_tp3001_t3038').value;
    if (tot == '0')
        tot = '0';
    if (alb == '0')
        alb = '0';
    if (glo == '0')
        glo = '0';
    document.getElementById('tabContain_tp3001_t3038').value = Number(tot) - Number(alb);
}
function ShowRubella() {
    if (document.getElementById('tabContain_tp1001_dd31004').options[document.getElementById('tabContain_tp1001_dd31004').selectedIndex].innerHTML == 'Quantitative') {
        document.getElementById('divRubellaQuan').style.display = "block";
        document.getElementById('divRubellaQual').style.display = "block";
    }
    else if (document.getElementById('tabContain_tp1001_dd31004').options[document.getElementById('tabContain_tp1001_dd31004').selectedIndex].innerHTML == 'Qualitative') {
        document.getElementById('divRubellaQuan').style.display = "none";
        document.getElementById('divRubellaQual').style.display = "block";
    }
    else {
        document.getElementById('divRubellaQual').style.display = "none";
        document.getElementById('divRubellaQuan').style.display = "none";
    }
}
function ShowRubella1() {
    if (document.getElementById('tabContain_tp1001_dd31005').options[document.getElementById('tabContain_tp1001_dd31005').selectedIndex].innerHTML == 'Quantitative') {
        document.getElementById('divRubellaQuan1').style.display = "block";
        document.getElementById('divRubellaQual1').style.display = "block";
    }
    else if (document.getElementById('tabContain_tp1001_dd31005').options[document.getElementById('tabContain_tp1001_dd31005').selectedIndex].innerHTML == 'Qualitative') {
        document.getElementById('divRubellaQuan1').style.display = "none";
        document.getElementById('divRubellaQual1').style.display = "block";
    }
    else {
        document.getElementById('divRubellaQual1').style.display = "none";
        document.getElementById('divRubellaQuan1').style.display = "none";
    }
}
function ShowCyto() {

    if (document.getElementById('tabContain_tp1001_dd31006').options[document.getElementById('tabContain_tp1001_dd31006').selectedIndex].innerHTML == 'Quantitative') {
        document.getElementById('divCytoQuan').style.display = "block";
        document.getElementById('divCytoQual').style.display = "block";
    }
    else if (document.getElementById('tabContain_tp1001_dd31006').options[document.getElementById('tabContain_tp1001_dd31006').selectedIndex].innerHTML == 'Qualitative') {
        document.getElementById('divCytoQuan').style.display = "none";
        document.getElementById('divCytoQual').style.display = "block";
    }
    else {
        document.getElementById('divCytoQual').style.display = "none";
        document.getElementById('divCytoQuan').style.display = "none";
    }
}
function ShowCyto1() {

    if (document.getElementById('tabContain_tp1001_dd31007').options[document.getElementById('tabContain_tp1001_dd31007').selectedIndex].innerHTML == 'Quantitative') {
        document.getElementById('divCytoQuan1').style.display = "block";
        document.getElementById('divCytoQual1').style.display = "block";
    }
    else if (document.getElementById('tabContain_tp1001_dd31007').options[document.getElementById('tabContain_tp1001_dd31007').selectedIndex].innerHTML == 'Qualitative') {
        document.getElementById('divCytoQuan1').style.display = "none";
        document.getElementById('divCytoQual1').style.display = "block";
    }
    else {
        document.getElementById('divCytoQual1').style.display = "none";
        document.getElementById('divCytoQuan1').style.display = "none";
    }
}
function ShowToxo() {
    if (document.getElementById('tabContain_tp1001_dd31008').options[document.getElementById('tabContain_tp1001_dd31008').selectedIndex].innerHTML == 'Quantitative') {
        document.getElementById('divToxoQuan').style.display = "block";
        document.getElementById('divToxoQual').style.display = "block";
    }
    else if (document.getElementById('tabContain_tp1001_dd31008').options[document.getElementById('tabContain_tp1001_dd31008').selectedIndex].innerHTML == 'Qualitative') {
        document.getElementById('divToxoQuan').style.display = "none";
        document.getElementById('divToxoQual').style.display = "block";
    }
    else {
        document.getElementById('divToxoQual').style.display = "none";
        document.getElementById('divToxoQuan').style.display = "none";
    }
}
function ShowToxo1() {
    if (document.getElementById('tabContain_tp1001_dd31009').options[document.getElementById('tabContain_tp1001_dd31009').selectedIndex].innerHTML == 'Quantitative') {
        document.getElementById('divToxoQuan1').style.display = "block";
        document.getElementById('divToxoQual1').style.display = "block";
    }
    else if (document.getElementById('tabContain_tp1001_dd31009').options[document.getElementById('tabContain_tp1001_dd31009').selectedIndex].innerHTML == 'Qualitative') {
        document.getElementById('divToxoQuan1').style.display = "none";
        document.getElementById('divToxoQual1').style.display = "block";
    }
    else {
        document.getElementById('divToxoQual1').style.display = "none";
        document.getElementById('divToxoQuan1').style.display = "none";
    }
}
function ShowHerpes() {
    if (document.getElementById('tabContain_tp1001_dd31010').options[document.getElementById('tabContain_tp1001_dd31010').selectedIndex].innerHTML == 'Quantitative') {
        document.getElementById('divHerpesQuan').style.display = "block";
        document.getElementById('divHerpesQual').style.display = "block";
    }
    else if (document.getElementById('tabContain_tp1001_dd31010').options[document.getElementById('tabContain_tp1001_dd31010').selectedIndex].innerHTML == 'Qualitative') {
        document.getElementById('divHerpesQuan').style.display = "none";
        document.getElementById('divHerpesQual').style.display = "block";
    }
    else {
        document.getElementById('divHerpesQual').style.display = "none";
        document.getElementById('divHerpesQuan').style.display = "none";
    }
}
function ShowHerpes1() {
    if (document.getElementById('tabContain_TabMicro_ddlHerpesResult1').options[document.getElementById('tabContain_tp1001_dd31011').selectedIndex].innerHTML == 'Quantitative') {
        document.getElementById('divHerpesQuan1').style.display = "block";
        document.getElementById('divHerpesQual1').style.display = "block";
    }
    else if (document.getElementById('tabContain_tp1001_dd31011').options[document.getElementById('tabContain_tp1001_dd31011').selectedIndex].innerHTML == 'Qualitative') {
        document.getElementById('divHerpesQuan1').style.display = "none";
        document.getElementById('divHerpesQual1').style.display = "block";
    }
    else {
        document.getElementById('divHerpesQual1').style.display = "none";
        document.getElementById('divHerpesQuan1').style.display = "none";
    }
}
function ShowHCG() {
    if (document.getElementById('tabContain_tp1001_dd31012').options[document.getElementById('tabContain_tp1001_dd31012').selectedIndex].innerHTML == 'Quantitative') {
        document.getElementById('divHCGResult').style.display = "block";
        document.getElementById('divHCGQual').style.display = "block";
    }
    else if (document.getElementById('tabContain_tp1001_dd31012').options[document.getElementById('tabContain_tp1001_dd31012').selectedIndex].innerHTML == 'Qualitative') {
        document.getElementById('divHCGResult').style.display = "none";
        document.getElementById('divHCGQual').style.display = "block";
    }
    else {
        document.getElementById('divHCGResult').style.display = "none";
        document.getElementById('divHCGQual').style.display = "none";
    }
}
/*Patient Visit*/
function nextFocus(obj) {
    var t = obj.tabIndex;
    alert(document.getElementById('dPurpose').selectedIndex);
    if (document.getElementById('dPurpose').selectedIndex == '1') {
        t++;
        alert(t);
    }
    if (document.getElementById('dPurpose').selectedIndex == '2') {
        t = t + 3;
        alert(t);
    }
    if (document.getElementById('dPurpose').selectedIndex == '3') {
        t = t + 4;
        alert(t);
    }
    for (var i = 0; i < document.forms[0].elements.length; i++) {
        if (document.forms[0].elements[i].tabIndex == t) {
            document.forms[0].elements[i].focus();
            //document.forms[0].elements[i].select();
        }
    }
}
/*Patient Details.aspx*/
function isEmptyTxt() {
    if (document.getElementById('txtSearchText').value == '') {
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_11") == null ? "Provide search text" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_11");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
    return true;
}
/*PatientDiagnose.aspx*/
function Showtext(id, chid) {
    if (document.getElementById(id).style.visibility == "visible") {
        document.getElementById(id).style.visibility = "hidden";
        document.getElementById(chid).checked = false;
    }
    else {
        document.getElementById(id).style.visibility = "visible";
        document.getElementById(chid).checked = true;
        document.getElementById(id).value = '';
        document.getElementById(id).focus();
    }
    if (document.getElementById(chid).checked) {
        document.getElementById(id).style.visibility = "visible";
        document.getElementById(chid).checked = true;
        document.getElementById(id).value = '';
        document.getElementById(id).focus();
    }
    else {
        document.getElementById(id).style.visibility = "hidden";
        document.getElementById(chid).checked = false;
    }
}

/*PatientDiagnose.aspx*/
function ShowUnShowtext(id, chid) {
    if (document.getElementById(id).style.visibility == "visible") {
        document.getElementById(id).style.visibility = "hidden";
        document.getElementById(chid).checked = false;
    }
    else {
        document.getElementById(id).style.visibility = "visible";
        document.getElementById(chid).checked = true;
        document.getElementById(id).value = '';
        //document.getElementById(id).focus();
    }
    if (document.getElementById(chid).checked) {
        document.getElementById(id).style.visibility = "visible";
        document.getElementById(chid).checked = true;
        document.getElementById(id).value = '';
        //document.getElementById(id).focus();
    }
    else {
        document.getElementById(id).style.visibility = "hidden";
        document.getElementById(chid).checked = false;
    }
}
function unShowtext(id, chid) {
    document.getElementById(id).style.visibility = "hidden";
    document.getElementById(chid).checked = false;
}

function GetDesc() {
    var len = document.forms[0].elements.length;
    var hist = document.getElementById('hdHist');
    var exam = document.getElementById('hdExam');
    if (hist != null && exam != null) {

        hist.value = '';
        exam.value = '';
        var cIdSub;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "checkbox") {
                if (document.forms[0].elements[i].checked) {
                    var cId = document.forms[0].elements[i];
                    if (cId.id.substring(0, 3) == 'tCE') {
                        cIdSub = cId.id.substring(3, cId.id.length);
                        exam.value = exam.value + cIdSub + '~' + document.getElementById('tE' + cIdSub).value + '^';
                    }
                    if (cId.id.substring(0, 3) == 'tCH') {
                        cIdSub = cId.id.substring(3, cId.id.length);
                        hist.value = hist.value + cIdSub + '~' + document.getElementById('tH' + cIdSub).value + '^';
                    }
                }
            }
        }
    }
}
function PDvalidation() {
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (document.getElementById('uAd_tDName').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_14") == null ? "Provide drug name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_14");
 ValidationWindow(userMsg, errorMsg);
        // document.getElementById('uAd_tDName').focus();
        return false;
    }
    if (document.getElementById('uAd_tFrm').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_15") == null ? "Provide formulation" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_15");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('uAd_tFrm').focus();
        return false;
    }
    //    if (document.getElementById('uAd_tDose').value == '') {
    //        alert('Enter the Dose');
    //        document.getElementById('uAd_tDose').focus();
    //        return false;
    //    }
    //    if (document.getElementById('uAd_routeBlock1').style.display=="block") {
    //        if (document.getElementById('uAd_tROA').value == '') {
    //            alert('Enter the Route');
    //            document.getElementById('uAd_tROA').focus();
    //            return false;
    //        }
    //    }



    if (document.getElementById('uAd_tFRQ').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_16") == null ? "Provide frequency" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_16");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('uAd_tFRQ').focus();
        return false;
    }
    //    if (document.getElementById('uAd_tDura').value == '') {
    //        alert('Enter the Duration');
    //        document.getElementById('uAd_tDura').focus();
    //        return false;
    //    }


    var drugName = document.getElementById('uAd_tDName').value;
    var drugFrm = "";
    var ddFormulation = document.getElementById('uAd_ddFormulation');
    var txtval = ddFormulation.options[ddFormulation.selectedIndex].value;
    var ddlOthers = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_17") == null ? "Others" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_17");
    if (txtval == "") {
        drugFrm = document.getElementById('uAd_tFrm').value;
    }
    else if (txtval == ddlOthers) {
        drugFrm = document.getElementById('uAd_tFrm').value;
    }

    else {
        drugFrm = txtval;
    }

    var strdFrq = "";

    var ddFrequency = document.getElementById('uAd_ddFrequency');
    var txFrequencytval = ddFrequency.options[ddFrequency.selectedIndex].value;
    // alert(txFrequencytval);
    if (txFrequencytval == "") {
        strdFrq = document.getElementById('uAd_tFRQ').value;
    }
    else if (txFrequencytval == ddlOthers) {
        strdFrq = document.getElementById('uAd_tFRQ').value;
    }
    else {
        strdFrq = txFrequencytval;
    }
    // alert(strdFrq);

    var dDose = document.getElementById('uAd_tDose').value;
    var dROA = document.getElementById('uAd_tROA').value;
    var ctlDp = document.getElementById('uAd_ddlInstruction');
    var ddlIns = ctlDp.options[ctlDp.selectedIndex].value;
    if (ddlIns == "Other") {
        ddlIns = document.getElementById('uAd_txtINS').value;

        if (document.getElementById('uAd_txtINS').value == "") {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_17") == null ? "Provide other instruction" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_17");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('uAd_txtINS').focus();
            return false;
        }
    }
    else {
        ctlDp = document.getElementById('uAd_ddlInstruction');
        ddlIns = ctlDp.options[ctlDp.selectedIndex].value;
    }

    var Dura = document.getElementById('uAd_txtFrequencyNumber').value;
    var Dura1 = document.getElementById('uAd_ddlFrequencyType').value;

    var frequency = document.getElementById('uAd_ddFrequency').value;
    Dura = Dura + ' ' + Dura1;
    var retval = drugName + "~" + drugFrm + "~" + dDose + "~" + dROA + "~" + strdFrq + "~" + Dura + "~" + ddlIns;

    return retval;
}
/* IpDrugEntry Control */

function IpDrugEntryValidation() {
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (document.getElementById('uAd_tDName').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_14") == null ? "Provide drug name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_14");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('uAd_tDName').focus();
        return false;
    }
    if (document.getElementById('uAd_tFrm').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_15") == null ? "Provide formulation" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_15");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('uAd_tFrm').focus();
        return false;
    }
    if (document.getElementById('uAd_tDose').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_18") == null ? "Provide dose" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_18");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('uAd_tDose').focus();
        return false;
    }
    //    if (document.getElementById('uAd_tROA').value == '') {
    //        alert('Enter the Route');
    //        document.getElementById('uAd_tROA').focus();
    //        return false;
    //    }
    if (document.getElementById('uAd_hdnRoleName').value != 'Physician') {
        if ((document.getElementById('uAd_txtDate').value == '') && (document.getElementById('uAd_txtToDate').value == '')) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_19") == null ? "Provide date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_19");
 ValidationWindow(userMsg, errorMsg);
            //document.getElementById('uAd_imgFDate').focus();
            return false;
        }
    }
    var drugName = document.getElementById('uAd_tDName').value;
    var drugFrm = document.getElementById('uAd_tFrm').value;
    var dDose = document.getElementById('uAd_tDose').value;
    var dROA = document.getElementById('uAd_tROA').value;
    var Freq = document.getElementById('uAd_tFRQ').value;
    var Dura = document.getElementById('uAd_tDura').value;
    var Dura1 = document.getElementById('uAd_ddlFrequencyType').value;
        Dura = Dura + ' ' + Dura1;
    var ctlDp = document.getElementById('uAd_ddlInstruction');
    var ddlIns = ctlDp.options[ctlDp.selectedIndex].value;
    var dDate = document.getElementById('uAd_txtDate').value;
    var dDateto = document.getElementById('uAd_txtToDate').value;
    var presID = document.getElementById('uAd_txtPresID').value;
    var retval = drugName + "~" + drugFrm + "~" + dDose + "~" + dROA + "~" + Freq + "~" + Dura + "~" + ddlIns + "~" + dDate + "~" + dDateto + "~" + presID;
    return retval;
}


/* IPDrugEntry Control */

function IpDrugEntryControlclear() {
    document.getElementById('uAd_tDName').value = '';
    document.getElementById('uAd_tFrm').value = 'Tab.';
    document.getElementById('uAd_tROA').value = '';
    document.getElementById('uAd_tDose').value = '';
    document.getElementById('uAd_ddFormulation').value = 'Tab.';
    document.getElementById('uAd_tDName').focus();
    document.getElementById('uAd_txtDate').value = '';
    document.getElementById('uAd_tFRQ').value = '1-0-0';
    document.getElementById('uAd_ddlInstruction').value = '';
    document.getElementById('uAd_txtToDate').value = '';
    document.getElementById('uAd_txtPresID').value = '0';
    document.getElementById('uAd_tDura').value = '';
    return false;
}



/* Check exsisting Drug */

function check() {

    var rowcount = document.getElementById('uAd_tabDrg1').rows.length;
    var rowlist = document.getElementById('uAd_tabDrg1').rows;
    var drugname = document.getElementById('uAd_tDName').value;
    var frmName = document.getElementById('uAd_tFrm').value;
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    for (i = 1; i < rowcount; i++) {
        //    alert('Hsi...1  : ' + rowcount);
        var drug = rowlist[i].cells[1];
        //  alert('Hsi...2');
        var formmulation = rowlist[i].cells[2];
        //alert('Hsi...3');
        //alert('Drug :' + drug.firstChild.nodeValue + 'Formulation :' + formmulation.firstChild.nodeValue);
        if ((drug.firstChild.nodeValue == drugname) && (formmulation.firstChild.nodeValue == frmName)) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_20") == null ? "Already exist" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_20");
 ValidationWindow(userMsg, errorMsg);
            return false;
        }
    }
    return true;
}

/*Schedule.aspx*/
function Book(st, et, tk) {
    document.getElementById('desc').style.display = 'block';
    document.getElementById('canDiv').style.display = 'none';
    document.getElementById('lblToken').innerHTML = tk;
    document.getElementById('lblTime').innerHTML = st + " To " + et;
    document.getElementById('hidDate').value = st + "To" + et;
    document.getElementById('hidToken').value = tk;
    SlotsSelect(st, et, tk, "Book");
    $('#tSchAv').attr("disabled", true);
    window.scroll(0, 0);
}

function SlotsSelect(st, et, tk, ptype) {
    var HidValue = $('#hidTokenDetails').val();
    var list = HidValue.split('^');
    var newCList = '';
    $('#hidTokenDetails').val(st + '~' + et + '~' + tk + '~0^');
    if (list != "") {
        for (var count = 0; count < list.length; count++) {
            var CList = list[count].split('~');
            if (CList[0] != '') {
                if ($('#' + CList[2]).is(':checked') && (CList[2] == (parseFloat(tk) - 1) || CList[2] == (parseFloat(tk) + 1))) {
                    newCList += list[count] + '^';
                    $('hdnType').val('M');
                }
            }
        }
    }
    $('#hidTokenDetails').val($('#hidTokenDetails').val() + newCList);

    var HidValue = $('#hidTokenDetails').val();
    var list = HidValue.split('^');
    var newCList = '';
    $('#lblToken').html('');
    $('#lblTime').html('');

    document.getElementById('lblToken').innerHTML
    if (list != "") {
        for (var count = 0; count < list.length; count++) {
            var CList = list[count].split('~');
            if (CList[0] != '') {
                if ($('#lblToken').html() != '') {
                    $('#lblToken').html($('#lblToken').html() + ', ' + CList[2]);
                    $('#lblTime').html($('#lblTime').html() + ' and ' + CList[0] + ' To ' + CList[1]);
                }
                else {
                    $('#lblToken').html(CList[2]);
                    $('#lblTime').html(CList[0] + ' To ' + CList[1]);
                }
            }
        }
    }
}
function CheckboxSelect(st, et, tk) {
    var HidValue = $('#hidTokenDetails').val();
    var list = HidValue.split('^');
    var newCList = '';
    if ($('#hidTokenDetails').val() != "") {
        for (var count = 0; count < list.length; count++) {
            var CList = list[count].split('~');
            if (CList[0] != '') {
                if ($('#' + CList[2]).is(':checked') && CList[2] != tk) {
                    newCList += list[count] + '^';
                }
            }
        }
    }
    if ($('#' + tk).is(':checked')) {
        $('#hidTokenDetails').val(newCList + st + '~' + et + '~' + tk + '~1^');
    }
    else {
        $('#hidTokenDetails').val(newCList);
    }
}
function ResetBooking() {
    $('#tSchAv').attr("disabled", false);
    var HidValue = $('#hidTokenDetails').val();
    var list = HidValue.split('^');
    var newCList = '';
    if ($('#hidTokenDetails').val() != "") {
        for (var count = 0; count < list.length; count++) {
            var CList = list[count].split('~');
            if (CList[0] != '') {
                $('#' + CList[2]).attr('checked', false);
            }
        }
    }

    $('#desc').css('display', 'none');
    $('#canDiv').css('display', 'none');
    $('#tSchAv').attr("disabled", false);
    $('#lblToken').html('');
    $('#lblTime').html('');
    $('#hidDate').val('');
    $('#hidToken').val('0');
    $('#hidTokenDetails').val('');
    $('hdnType').val('N');
    return false;

}
function CancelBooking(bkid, Desc) {
    document.getElementById('hidBKID').value = bkid;
    document.getElementById('canDiv').style.display = 'block';
    document.getElementById('desc').style.display = 'none';
    document.getElementById('lDesc').innerHTML = Desc;
    document.getElementById('ddlReason').focus();
}
/*PatientVisit.aspx*/
function onComboFocus() {
var ddlselect = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_16") == null ? "Select" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_16");
    if (document.getElementById('dPurpose').value == ddlselect) {
        document.getElementById('dPurpose').focus();
    }
}
function pruposeChangeFocus() {
    if (document.getElementById('dPurpose').selectedIndex == '1') {
        document.getElementById('divConsulting').style.display = 'block';
        document.getElementById('divRefer').style.display = 'none';
        document.getElementById('divProcedure').style.display = 'none';
        //document.getElementById('usrConsulting_ddlSpeciality').focus();
    }
    if (document.getElementById('dPurpose').selectedIndex == '2') {
        document.getElementById('divConsulting').style.display = 'none';
        document.getElementById('divRefer').style.display = 'block';
        document.getElementById('divProcedure').style.display = 'none';
        //document.getElementById('ReferDoctor1_ddlDoctor').focus();
    }
    if (document.getElementById('dPurpose').selectedIndex == '3') {
        document.getElementById('divConsulting').style.display = 'none';
        document.getElementById('divRefer').style.display = 'none';
        document.getElementById('divProcedure').style.display = 'block';
        //document.getElementById('usrProcedure_ddlProcedureName').focus();
    }
}
function pruposeLostFocus() {
    if (document.getElementById('dPurpose').selectedIndex == '1') {
        document.getElementById('usrConsulting_ddlSpeciality').focus();
    }
    if (document.getElementById('dPurpose').selectedIndex == '2') {
        document.getElementById('ReferDoctor1_ddlDoctor').focus();
    }
    if (document.getElementById('dPurpose').selectedIndex == '3') {
        document.getElementById('usrProcedure_ddlProcedureName').focus();
    }
}
/*PatientRegistration.aspx*/
function toggle(id, cid) {
    chkbx = document.getElementById(cid);
    control = document.getElementById(id);
    if (chkbx.checked) {
        control.style.display = "none";
    }
    else {
        control.style.display = "block";
    }
}
function toggleCheck() {

    if ($('[id$=ucCAdd_txtAddress1]').length > 0) {
        if ($('[id$=ucCAdd_txtAddress1]').val() != '' && $('[id$=ucCAdd_txtCity]').val() != '') {

            document.getElementById('cAdsame').checked = false;
            document.getElementById('CAD').style.display = "block";
            var IsCorporateOrg = document.getElementById('hdnIsCorpOrg').value;
            if (IsCorporateOrg == 'Y')
                document.getElementById('cAdsame').checked = true;
        }
    }
}
function validationWithArrays(valVariable) {
    for (i = 0; i < valVariable.length; i++) {
        if (document.getElementById(valVariable[i]).value == '') {
            var alertName = valVariable[i].substr(3, valVariable[i].length);
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_21") == null ? "Enter the '"+alertName+"'" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_21");
userMsg = userMsg.replace("{0}",alertName);
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById(valVariable[i]).focus();
            return false;
        }
    }
    return true;
}
function validationComboWithArrays(valVariable) {
    for (i = 0; i < valVariable.length; i++) {
    var ddlselect = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_16") == null ? "Select" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_16");
        if (document.getElementById(valVariable[i]).value == ddlselect) {
            var alertName = valVariable[i].substr(3, valVariable[i].length);
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_21") == null ? "Enter the '" + alertName+ "'" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_21");
userMsg = userMsg.replace("{0}",alertName);
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById(valVariable[i]).focus();
            return false;
        }
    }
    return true;
}

function GetDuplication() {
    var PatientId = "-1";
    var txtMobileNo = document.getElementById('txtMobile').value.trim();
    var txtLandNo = document.getElementById('txtLandLine').value.trim();
    if (txtMobileNo == "") {
        txtMobileNo = document.getElementById('ucPAdd_txtMobile').value;
    }
    if (txtLandNo == "") {
        txtLandNo = document.getElementById('ucPAdd_txtLandLine').value;
    }
    var txtPatientName = document.getElementById('txtName').value.trim();
    var txtOrgId = document.getElementById('hdnOrgId').value;
    if (document.getElementById('hdnPatID').value != "")
        PatientId = document.getElementById('hdnPatID').value;
    if (txtPatientName != "" && (txtMobileNo != "" || txtLandNo != "")) {
        OPIPBilling.CheckPatientforDuplicate(txtPatientName, txtMobileNo, txtLandNo, txtOrgId, PatientId, pSetPatientRegisterValues);
    }
}

function pSetPatientRegisterValues(PatientListDetails) {
    var PatientCount = PatientListDetails[0].ClientID;
    var PatientList = "";
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    for (var i = 0; i < PatientListDetails.length; i++) {
        if (PatientListDetails[i].Name != '') {
            if (PatientList != "")
                PatientList = PatientList + "," + "\n" + PatientListDetails[i].Name;
            else
                PatientList = PatientListDetails[i].Name;
        }
    }
    if (PatientCount > 0) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_22") == null ? "The patient details with same name and contact details already exist. Provide the changes and retry" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_22");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
    if (PatientList != "") {
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
                    var informMsg = SListForAppMsg.Get("PlatForm_Information") == null ? "Information" : SListForAppMsg.Get("PlatForm_Information");
                    var okMsg = SListForAppMsg.Get("PlatForm_Ok") == null ? "Ok" : SListForAppMsg.Get("PlatForm_Ok")
                    var cancelMsg = SListForAppMsg.Get("PlatForm_Cancel") == null ? "Cancel" : SListForAppMsg.Get("PlatForm_Cancel");
                     var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_128") == null ? "Duplicate contact no. Do you want to continue ?  \n" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_128");
        var msg = userMsg  + PatientList;
        var SS = ConfirmWindow(msg,informMsg,okMsg,cancelMsg);
        if (SS == false) {
            return false;
        }
    }

    var btnID = document.getElementById('hdnbtnId').value;
    if (btnID == 'btnFinish') {
        document.getElementById('btnFinish').style.display = 'none';
        document.getElementById('hdnBtnStatus').value = '0';
        javascript: __doPostBack('btnFinish', '');
    }
    if (btnID == 'btnUpdate') {
        document.getElementById('btnUpdate').style.display = 'none';
        document.getElementById('hdnBtnStatus').value = '1';
        javascript: __doPostBack('btnUpdate', '');
    }
    if (btnID == 'btnURNo') {
        document.getElementById('btnURNo').style.display = 'none';
        document.getElementById('hdnBtnStatus').value = '2';
        javascript: __doPostBack('btnURNo', '');
    }
    return true;
}
function validation(btnID) {

    //-----------------------------------------------------------Corporate Org
    var IsCorporateOrg = document.getElementById('hdnIsCorpOrg').value;
    var ddlselect = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_16") == null ? "Select" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_16");
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (IsCorporateOrg == 'Y') {
        //        if (document.getElementById('txtFileNo').value == '') {
        //            alert('Provide the txtFileNo');
        //            document.getElementById('txtFileNo').focus();
        //            return false;
        //        }

        if (document.getElementById('uctrlEmployer_ddlPatientType').selectedIndex == '0') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_23") == null ? "Select Patient type" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_23");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('uctrlEmployer_ddlPatientType').focus();
            return false;
        }
        else if (document.getElementById('uctrlEmployer_ddlPatientType').selectedIndex == '1') {
            if (document.getElementById('uctrlEmployer_ddlEmployementType').selectedIndex == '0') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_24") == null ? "Select employee type" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_24");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('uctrlEmployer_ddlEmployementType').focus();

                return false;
            }
            if (document.getElementById('uctrlEmployer_txtEmployementTypeNo').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_25") == null ? "Provide employee number" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_25");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('uctrlEmployer_txtEmployementTypeNo').focus();

                return false;
            }
            //            if (document.getElementById('uctrlEmployer_txtJoinDate').value == '') {
            //                alert('Provide the Join Date');
            //                document.getElementById('uctrlEmployer_txtJoinDate').focus();

            //                return false;
            //            }
            //            if (document.getElementById('uctrlEmployer_ddlDepartment').selectedIndex == '0') {
            //                alert('Provide the Department');
            //                document.getElementById('uctrlEmployer_ddlDepartment').focus();

            //                return false;
            //            }
            //            if (document.getElementById('uctrlEmployer_ddlDesignation').selectedIndex == '0') {
            //                alert('Provide the Designation');
            //                document.getElementById('uctrlEmployer_ddlDesignation').focus();

            //                return false;
            //            }
            //            if (document.getElementById('uctrlEmployer_ddlEmployerLocation').selectedIndex == '0') {
            //                alert('Provide the EmployerLocation');
            //                document.getElementById('uctrlEmployer_ddlEmployerLocation').focus();

            //                return false;
            //            }
            //            if (document.getElementById('uctrlEmployer_txtQualification').value == '') {
            //                alert('Provide the Qualification');
            //                document.getElementById('uctrlEmployer_txtQualification').focus();

            //                return false;
            //            }

            //            if (document.getElementById('uctrlEmployer_ddlGrade').selectedIndex == '0') {
            //                alert('Provide the Grade');
            //                document.getElementById('uctrlEmployer_ddlGrade').focus();

            //                return false;
            //            }
            if (document.getElementById('uctrlEmployer_ddlEmployerName').selectedIndex == '0') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_26") == null ? "Select employer name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_26");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('uctrlEmployer_ddlEmployerName').focus();

                return false;
            }

        }
        else if (document.getElementById('uctrlEmployer_ddlPatientType').selectedIndex == '2') {
            if (document.getElementById('uctrlEmployer_ddlRelation').selectedIndex == '0') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_27") == null ? "Select relationship" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_27");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('uctrlEmployer_ddlRelation').focus();

                return false;
            }
            if (document.getElementById('uctrlEmployer_txtEmployerID').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_28") == null ? "Provide employer number" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_28");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('uctrlEmployer_txtEmployerID').focus();

                return false;
            }

        }
        else if (document.getElementById('uctrlEmployer_ddlPatientType').selectedIndex == '4') {
        }
        else if (document.getElementById('uctrlEmployer_ddlPatientType').selectedIndex == '5') {
        }
        else {
            if (document.getElementById('uctrlEmployer_ddlExtended').selectedIndex == '0') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_29") == null ? "Select extended type" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_29");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('uctrlEmployer_ddlExtended').focus();
                return false;
            }
            if (document.getElementById('uctrlEmployer_txtEmployerID').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_28") == null ? "Provide employer number" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_28");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('uctrlEmployer_txtEmployerID').focus();
                return false;
            }
        }

    }

    //----------------------------------------------------------------------------
    //----------------------------------------------------------------------------
    if (document.getElementById('ddSalutation').value == '0') {
       var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_30") == null ? "Select Salutation" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_30");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('ddSalutation').focus();
        return false;
    }
    if (document.getElementById('txtName').value == '') {
       var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_31") == null ? "Provide name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_31");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtName').focus();
        return false;
    }
    if ((document.getElementById('txtApprovedby').value == '') && (btnID == 'btnUpdate')) {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_32") == null ? "Provide Approved by" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_32");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtApprovedby').focus();
        return false;
    }

    if ($('[id$=tDOB]').length > 0) {
        if ($('[id$=tDOB]')[0].value == '') {
           var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_33") == null ? "Provide Date Of Birth or Age" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_33");
 ValidationWindow(userMsg, errorMsg);
           $('[id$=tDOB]')[0].focus();
            return false;
        }
    }

    if (document.getElementById('ddMarital').value == ddlselect && document.getElementById('hdnMarriedStatus').value.trim() == "Y") {
        if (document.getElementById('ddSalutation').value != '4' && document.getElementById('ddSalutation').value != '8') {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_34") == null ? "Select marital status" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_34");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddMarital').focus();
            return false;
        }
    }
    //0 meaning for 0 is (--Select--)
    if (document.getElementById('ddSex').value == '0') {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_35") == null ? "Select sex" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_35");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('ddSex').focus();
        return false;
    }

    if (document.getElementById('ddMarital').value == '0' && document.getElementById('hdnMarriedStatus').value.trim() == "Y") {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_34") == null ? "Select marital status" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_34");
 ValidationWindow(userMsg, errorMsg);
       document.getElementById('ddMarital').focus();
        return false;
    }

    if (document.getElementById('hdnAddress').value == "N") {
        if (document.getElementById('txtAddress').value == '') {
           var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_36") == null ? "Provide address" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_36");
 ValidationWindow(userMsg, errorMsg);
           document.getElementById('txtAddress').focus();
            return false;
        }
        if (document.getElementById('txtCity').value == '') {
            if (document.getElementById('txtAddress').value == '') {
                var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_37") == null ? "Provide city" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_37");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtCity').focus();
                return false;
            }
        }
        if ((document.getElementById('txtMobile').value == '') && (document.getElementById('txtLandLine').value == '')) {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_38") == null ? "Provide contact number" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_38");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtMobile').focus();
            return false;
        }

        if (document.getElementById('ddCountry').value == '0') {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_39") == null ? "Select country name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_39");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddCountry').focus();
            return false;
        }
        if (document.getElementById('ddState').value == '0') {
           var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_40") == null ? "Select state name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_40");
 ValidationWindow(userMsg, errorMsg);
           document.getElementById('ddState').focus();
            return false;
        }


        //txtApprovedby

        //        var hdnValue = document.getElementById('patientID');
        //        if (hdnValue !=0) {
        //            if (document.getElementById('txtApprovedby').value == '') {

        //                alert('Provide the name who are the person give the permission for edit patient details.');

        //                document.getElementById('txtApprovedby').focus();
        //                return false;
        //            }
        //        
        //        }
        //        if (document.getElementById('hdnapprovedid').value != null) {

        //        }
        document.getElementById('ucPAdd_txtAddress2').value = document.getElementById('txtAddress').value;
        document.getElementById('ucPAdd_txtMobile').value = document.getElementById('txtMobile').value;
        document.getElementById('ucPAdd_txtLandLine').value = document.getElementById('txtLandLine').value;
        document.getElementById('ucPAdd_txtCity').value = document.getElementById('txtCity').value;

        document.getElementById('ucPAdd_txtOtherCountry').value = document.getElementById('txtOtherCountry').value;
        document.getElementById('ucPAdd_txtOtherState').value = document.getElementById('txtOtherState').value;
        document.getElementById('ucCAdd_txtOtherCountry').value = document.getElementById('txtOtherCountry').value;
        document.getElementById('ucCAdd_txtOtherState').value = document.getElementById('txtOtherState').value;

        document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].text = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].text;
        document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].value = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].value;
        document.getElementById('ucPAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].text = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].text;
        document.getElementById('ucPAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].value = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].value;
        document.getElementById('ucCAdd_hdnCurrentAddressState').value = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].value;
        document.getElementById('ucCAdd_hdnCurrentAddressCountry').value = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].value;
        document.getElementById('ucPAdd_hdnPermanentAddressState').value = document.getElementById('ucPAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].value
        document.getElementById('ucPAdd_hdnPermanentAddressCountry').value = document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].value



        if (document.getElementById('cAdsame').checked) {
            document.getElementById('ucCAdd_txtAddress2').value = document.getElementById('txtAddress').value;
            document.getElementById('ucCAdd_txtMobile').value = document.getElementById('txtMobile').value;
            document.getElementById('ucCAdd_txtLandLine').value = document.getElementById('txtLandLine').value;
            document.getElementById('ucCAdd_txtCity').value = document.getElementById('txtCity').value;

            document.getElementById('ucCAdd_txtOtherCountry').value = document.getElementById('txtOtherCountry').value;
            document.getElementById('ucCAdd_txtOtherState').value = document.getElementById('txtOtherState').value;

            document.getElementById('ucCAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].text = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].text;
            document.getElementById('ucCAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].value = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].value;
            document.getElementById('ucCAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].text = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].text;
            document.getElementById('ucCAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].value = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].value;
            document.getElementById('ucCAdd_hdnCurrentAddressState').value = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].value;
            document.getElementById('ucCAdd_hdnCurrentAddressCountry').value = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].value;
            document.getElementById('ucPAdd_hdnPermanentAddressState').value = document.getElementById('ucPAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].value
            document.getElementById('ucPAdd_hdnPermanentAddressCountry').value = document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].value


        }


    }
    if (document.getElementById('hdnTOrg').value == 'Y') {
        if (document.getElementById('URNControl1_txtURNo').value == '') {
           var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_41") == null ? "Provide URN number" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_41");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('URNControl1_txtURNo').focus();
            return false;
        }

    }

    //    if (document.getElementById('hdnURN').value != '0') {
    //            alert('Enter the URN ');
    //            document.getElementById('txtURNo').focus();
    //            return false;
    //    }

    //    if (URN == "Y") {

    //        if (document.getElementById('URNControl1_txtURNo').value == '') {
    //            alert('Enter the URN ');
    //            document.getElementById('URNControl1_txtURNo').focus();
    //            return false;
    //        }
    //}

    if (document.getElementById('URNControl1_txtURNo').value != '') {

        if (document.getElementById('URNControl1_ddlUrnType').value == '0') {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_42") == null ? "Select URN type" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_42");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('URNControl1_ddlUrnType').focus();
            return false;
        }
    }

    if (document.getElementById('URNControl1_ddlUrnoOf').value == '2') {

        if (document.getElementById('URNControl1_ddlRelation').value == '0') {
           var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_43") == null ? "Select the RelationShipType" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_43");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('URNControl1_ddlRelation').focus();
            return false;
        }
        else {
            if (document.getElementById('URNControl1_txtName').value == '') {

                var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_44") == null ? "Select the RelationshipName" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_44");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('URNControl1_txtName').focus();
                return false;
            }

        }
    }

    if (document.getElementById('hdnAddress').value == "Y") {
        if (document.getElementById('ucPAdd_txtAddress2').value == '') {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_36") == null ? "Provide address" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_36");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ucPAdd_txtAddress2').focus();
            return false;
        }
        if (document.getElementById('ucPAdd_txtCity').value == '') {
           var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_37") == null ? "Provide city" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_37");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ucPAdd_txtCity').focus();
            return false;
        }
        if ((document.getElementById('ucPAdd_txtMobile').value == '') && (document.getElementById('ucPAdd_txtLandLine').value == '')) {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_45") == null ? "Provide any one contact number" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_45");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ucPAdd_txtMobile').focus();
            return false;
        }
    }
    if (document.getElementById('CAD').style.display == 'block') {
        if (document.getElementById('ucCAdd_txtAddress2').value == '') {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_46") == null ? "Provide the street/road name in current address" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_46");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ucCAdd_txtAddress2').focus();
            return false;
        }
        if (document.getElementById('ucCAdd_txtCity').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_47") == null ? "Enter the Current City" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_47");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ucCAdd_txtCity').focus();
            return false;
        }
        if ((document.getElementById('ucCAdd_txtMobile').value == '') && (document.getElementById('ucCAdd_txtLandLine').value == '')) {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_45") == null ? "Provide any one contact number" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_45");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ucCAdd_txtMobile').focus();
            return false;
        }
    }
    var IsEmailMandatory = document.getElementById('hdnEmailMandatory').value;
    if (IsEmailMandatory == 'Y') {

        if (document.getElementById('txtEmail').value == '') {
            showResponses('divMore1', 'divMore2', 'divMore3', 1);
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_48") == null ? "Provide the email address" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_48");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtEmail').focus();
            return false;

        }

    }
    if (document.getElementById('txtEmail').value != '') {
        if (echeck(document.getElementById('txtEmail').value) == false) {
            document.getElementById('txtEmail').value = "";
            document.getElementById('txtEmail').focus();
            return false;
        }
    }


    if (document.getElementById('uctlSmartCard1_ddlReIssueReason') != null) {
        if (document.getElementById('uctlSmartCard1_chkReIssueSmartCard').checked == true) {
            if (document.getElementById('uctlSmartCard1_ddlReIssueReason').value == '0') {
                var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_49") == null ? "Select a reason for Re-Issue of Smart Card" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_49");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('uctlSmartCard1_ddlReIssueReason').focus();
                return false;
            }
        }
    }


    //document.getElementById('btnFinish').style.display = 'none';




    var PhotoUpload = $("#[name$='PhotoUpload']").val();
    var chkUploadPhoto = $("#[name$='chkUploadPhoto']");
    var extension;
    if (chkUploadPhoto.attr("checked")) {
        if (PhotoUpload.length <= 0) {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_50") == null ? "Browse a file to upload." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_50");
 ValidationWindow(userMsg, errorMsg);
           $("#[name$='PhotoUpload']").focus();
            return false;
        }
        else if (PhotoUpload.length > 0 || PhotoUpload.length < 4194304) {
            extension = PhotoUpload.substring(PhotoUpload.lastIndexOf('.')).toLowerCase();
            var ValidFileType = ".jpg, .png, .gif, .jpeg, .bmp";
            if (ValidFileType.indexOf(extension) < 0) {
                var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_51") == null ? "The file must have an extension of (.jpg, .png, .gif, .jpeg, .bmp)" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_51");
 ValidationWindow(userMsg, errorMsg);
                $("#[name$='PhotoUpload']").focus();
                return false;
            }
        }
        else {
           var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_52") == null ? "Maximum size of the file is 4 MB only." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_52");
 ValidationWindow(userMsg, errorMsg);
          }
    }

    if (document.getElementById('uctlSmartCard1_chkIssueSmartCard').checked) {
        if ($("select[id='ucMembershipCard1_ddlCardType'] option:selected").index() == 0) {
           var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_53") == null ? "Please select a card type from the list" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_53");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ucMembershipCard1_ddlCardType').focus();
            return false;
        }

        if (document.getElementById('ucMembershipCard1_txtCardNo').value.trim() == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_54") == null ? "Please Enter a CardNo Number" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_54");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ucMembershipCard1_txtCardNo').focus();
            return false;
        }
        if (document.getElementById('ucMembershipCard1_txtValidFrom').value.trim() == '') {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_55") == null ? "Please select a valid date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_55");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ucMembershipCard1_txtValidFrom').focus();
            return false;
        }

    }
    //    if (btnID == 'btnFinish') {
    //        document.getElementById('btnFinish').style.display = 'none';
    //        document.getElementById('hdnBtnStatus').value = '0';
    //    }
    //    if (btnID == 'btnUpdate') {
    //        document.getElementById('btnUpdate').style.display = 'none';
    //        document.getElementById('hdnBtnStatus').value = '1';
    //    }
    //    if (btnID == 'btnURNo') {
    //        document.getElementById('btnURNo').style.display = 'none';
    //        document.getElementById('hdnBtnStatus').value = '2';
    //    }

    SetValidFrom($('#ucMembershipCard1_txtValidFrom').val(), $('#ucMembershipCard1_txtValidTo').val());
    document.getElementById('hdnbtnId').value = btnID;
    GetDuplication();

    return false;
}
function searchValidate() {
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    //if(document.getElementById('txtPatientNo').value=='' && document.getElementById('txtPatientName').value=='' && document.getElementById('txtRelation').value=='' &&document.getElementById('txtLocation').value=='' && document.getElementById('txtOthers').value=='') {
    if (document.getElementById('txtPatientNo').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_56") == null ? "Provide at least one filter criterion" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_56");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtPatientNo').focus();
        return false;
    }
    return true;
}
function onEnterKeyPressFocus(e, str) {
    var key = window.event ? e.keyCode : e.which;
    var keychar = String.fromCharCode(key);
    if (key == 13) {
        document.getElementById(str).focus();
        return false;
    }
}
function onEnterKeyPress(e) {
    var key = window.event ? e.keyCode : e.which;
    var keychar = String.fromCharCode(key);
    if (key == 13) {
        return false;
    }
}
function pValidation() {
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (document.getElementById("pid").value == '') {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_57") == null ? "Select patient name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_57");
 ValidationWindow(userMsg, errorMsg);
       return false;
    }
    if (document.getElementById('hdnPatientRegistrationStatus').value == 'N' && document.getElementById('dList').value != 'Edit_Patient_Registration_Details_PatientRegistration' && document.getElementById('dList').value != 'Book_Transfer_Room_RoomBooking') {
        if (document.getElementById('dList').value == 'Edit_Patient_Admission_Details_InPatientRegistration' || document.getElementById('dList').value == 'BloodBank_BloodRequest') {
            return true;
        }


        else {
            if (document.getElementById('dList').value == 'Update_Performer') {
                var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_132") == null ? "This action cannot be performed due to no visit details." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_132");
            }
            else {
                var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_133") == null ? "This action cannot be performed due to incomplete admission details." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_133");

            }
 ValidationWindow(userMsg, errorMsg);
             return false;
        }

    }

}
window.history.forward(1);

var number = "1234567890.- ";
var range = "123456789.-";
//Function to validate of Number Only
function validatenumber(e, number) {
    var k;
    k = document.all ? parseInt(e.keyCode) : parseInt(e.which);
    return (number.indexOf(String.fromCharCode(k)) != -1);

}
function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    else
        return true;
}
function NotZero(e, range) {
    var k;
    k = document.all ? parseInt(e.keyCode) : parseInt(e.which);
    return (range.indexOf(String.fromCharCode(k)) != -1);

}
function validatenumber(evt) {
    var keyCode = 0;
    if (evt) {
        keyCode = evt.keyCode || evt.which;
    }
    else {
        keyCode = window.event.keyCode;
    }
    //alert('keyCode  : '+keyCode);
    if ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105) || (keyCode == 110) || (keyCode == 8) || (keyCode == 9) || (keyCode == 12) || (keyCode == 27) || (keyCode == 37) || (keyCode == 39) || (keyCode == 46) || (keyCode == 190) || (keyCode == 188)) {
        return true;
    }
    else {
        return false;
    }

    //    var keyCode = evt.which ? evt.which : evt.keyCode;
    //    return keyCode < '0'.charCodeAt() || keyCode > '9'.charCodeAt();
}
function validateDecimalNumber(evt, obj) {

    var charCode = (evt.which) ? evt.which : event.keyCode
    var value = obj.value;
    var dotcontains = value.indexOf(".") != -1;
    if (dotcontains)
        if (charCode == 46) return false;
    if (charCode == 46) return true;
    if ((charCode > 31 && (charCode < 48 || (charCode > 57 && charCode < 96 && charCode > 105)) || ((evt.key.shiftKey) && (charCode > 47 && charCode < 58))))
        return false;
    return true;
}
function validatenumberOnly(evt, txtID) {
    var keyCode = 0;
    if (evt) {
        keyCode = evt.keyCode || evt.which;
    }
    else {
        keyCode = window.event.keyCode;
    }
    if (!evt.shiftKey && ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105) || (keyCode == 110) ||
            (keyCode == 8) || (keyCode == 9) || (keyCode == 12) ||
            (keyCode == 27) || (keyCode == 37) || (keyCode == 39) || (keyCode == 46) || (keyCode == 190) ||
            (keyCode == 109) || (keyCode == 189))) {

        var txtValue;
        if (txtID != undefined && txtValue != undefined) {
            txtValue = document.getElementById(txtID).value;
        }
        else {
            txtValue = "";
        }
        if ((keyCode == 110 || keyCode == 190) && (txtValue.length != 0 && txtValue.indexOf(".") != -1)) {
            return false;
        }

        if ((keyCode == 109 || keyCode == 189) && (txtValue.length != 0 && txtValue.indexOf("-") != -1)) {
            return false;
        }


        return true;
    }
    else {
        return false;
    }
}

function validatePercentage(evt, txtID) {
    var keyCode = 0;
    if (evt) {
        keyCode = evt.keyCode || evt.which;
    }
    else {
        keyCode = window.event.keyCode;
    }
    var txtValue = document.getElementById(txtID).value;
    if (!evt.shiftKey && ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105) || (keyCode == 110) ||
            (keyCode == 8) || (keyCode == 9) || (keyCode == 12) ||
            (keyCode == 27) || (keyCode == 37) || (keyCode == 39) || (keyCode == 46) || (keyCode == 190))) {

        if ((keyCode == 110 || keyCode == 190) && (txtValue.length != 0 && txtValue.indexOf(".") != -1)) {
            return false;
        }

        return true;
    }
    else {
        return false;
    }
}

/*Reception/Home.aspx*/
function pageLoadFocus(focusId) {
    if (document.getElementById(focusId).value == '')

        if ($('#hdnCashClousre').val() == '0') {
        document.getElementById(focusId).focus();
    }
}
function onComboFocus(focusId) {
var ddlselect = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_16") == null ? "Select" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_16");
    if (document.getElementById(focusId).value == ddlselect) {
        document.getElementById(focusId).focus();
    }
    else if (document.getElementById(focusId).value == ddlselect) {
        document.getElementById(focusId).focus();
    }
}
/*scrolling.js*/
var clipTop = 0;
var clipWidth;
var clipBottom;
var lyrheight = 0;
var time, amount, theTime, theHeight, DHTML, topper;
function init(SclayerName, topPos, ScAreaWidth, ScAreaBottom) {
    this.topper = topPos;
    this.clipWidth = ScAreaWidth;
    this.clipBottom = ScAreaBottom;
    DHTML = (document.getElementById || document.all || document.layers)
    if (!DHTML) return;
    var x = new getObj(SclayerName);
    if (document.layers) {
        lyrheight = x.style.clip.bottom;
        lyrheight += 20;
        x.style.clip.top = clipTop;
        x.style.clip.left = 0;
        x.style.clip.right = clipWidth;
        x.style.clip.bottom = clipBottom;
    }
    else if (document.getElementById || document.all) {
        lyrheight = x.obj.offsetHeight;
        var clipstring = 'rect(' + clipTop + 'px,' + clipWidth + 'px,' + clipBottom + 'px,0)';
        x.style.clip = clipstring;
    }
}
function scrollayer(layername, amt, tim) {
    if (!DHTML) return;
    thelayer = new getObj(layername);
    if (!thelayer) return;
    amount = amt;
    theTime = tim;
    //	alert(layername);
    realscroll();
}
function stopScroll() {
    if (time) clearTimeout(time);
}
function realscroll() {
    if (!DHTML) return;
    clipTop += amount;
    clipBottom += amount;
    topper -= amount;
    if (clipTop < 0 || clipBottom > lyrheight) {
        clipTop -= amount;
        clipBottom -= amount;
        topper += amount;
        return;
    }
    if (document.getElementById || document.all) {
        clipstring = 'rect(' + clipTop + 'px,' + clipWidth + 'px,' + clipBottom + 'px,0)'
        thelayer.style.clip = clipstring;
        thelayer.style.top = topper + 'px';
    }
    else if (document.layers) {
        thelayer.style.clip.top = clipTop;
        thelayer.style.clip.bottom = clipBottom;
        thelayer.style.top = topper;
    }
    time = setTimeout('realscroll()', theTime);
}
function getObj(name) {
    if (document.getElementById) {
        this.obj = document.getElementById(name);
        this.style = document.getElementById(name).style;
    }
    else if (document.all) {
        this.obj = document.all[name];
        this.style = document.all[name].style;
    }
    else if (document.layers) {
        this.obj = document.layers[name];
        this.style = document.layers[name];
    }
}
/*pickListScrolling.js*/
// JavaScript Document
var clipTop = 0;
var clipWidth;
var clipBottom;
var lyrheight = 0;
var time, amount, theTime, theHeight, DHTML, topper;
function init1(SclayerName, topPos, ScAreaWidth, ScAreaBottom) {
    this.topper = topPos;
    this.clipWidth = ScAreaWidth;
    this.clipBottom = ScAreaBottom;
    DHTML = (document.getElementById || document.all || document.layers)
    if (!DHTML) return;
    var x = new getObj1(SclayerName);
    if (document.layers) {
        lyrheight = x.style.clip.bottom;
        lyrheight += 20;
        x.style.clip.top = clipTop;
        x.style.clip.left = 0;
        x.style.clip.right = clipWidth;
        x.style.clip.bottom = clipBottom;
    }
    else if (document.getElementById || document.all) {
        lyrheight = x.obj.offsetHeight;
        var clipstring = 'rect(' + clipTop + 'px,' + clipWidth + 'px,' + clipBottom + 'px,0)';
        x.style.clip = clipstring;
    }

}
function scrollayer1(layername, amt, tim) {
    if (!DHTML) return;
    thelayer = new getObj(layername);
    if (!thelayer) return;
    amount = amt;
    theTime = tim;
    realscroll();
}

function stopScroll1() {
    if (time) clearTimeout(time);
}
function realscroll() {
    if (!DHTML) return;
    clipTop += amount;
    clipBottom += amount;
    topper -= amount;
    if (clipTop < 0 || clipBottom > lyrheight) {
        clipTop -= amount;
        clipBottom -= amount;
        topper += amount;
        return;
    }
    if (document.getElementById || document.all) {
        clipstring = 'rect(' + clipTop + 'px,' + clipWidth + 'px,' + clipBottom + 'px,0)'
        thelayer.style.clip = clipstring;
        thelayer.style.top = topper + 'px';
    }
    else if (document.layers) {
        thelayer.style.clip.top = clipTop;
        thelayer.style.clip.bottom = clipBottom;
        thelayer.style.top = topper;
    }
    time = setTimeout('realscroll()', theTime);
}
function getObj1(name) {
    if (document.getElementById) {
        this.obj = document.getElementById(name);
        this.style = document.getElementById(name).style;
    }
    else if (document.all) {
        this.obj = document.all[name];
        this.style = document.all[name].style;
    }
    else if (document.layers) {
        this.obj = document.layers[name];
        this.style = document.layers[name];
    }
}
/*Permanent.js*/
// JScript File
var ExpandImageSrc = "expand.jpg"; //image location to display when Div is collapsed
var CollapseImageSrc = "collapse.jpg"; //image location to display when Div is Expanded
//Code
//********************************************************
var iTimer;
var calcHeight;
function PermanentDiv(divToShow, imgID) {
    var help = document.getElementById(divToShow);
    if (help.style.display != "block") {
        if (imgID) {
            document.getElementById(imgID).setAttribute('src', CollapseImageSrc);
        }
        showDiv(divToShow);
    }
    else {
        if (imgID) {
            document.getElementById(imgID).setAttribute('src', ExpandImageSrc);
        }
        collapse(divToShow);
    }
}
function Permanentcollapse(divName) {
    var help = document.getElementById(divName);
    help.style.display = "none";
}
function showDiv(divName) {
    var div = document.getElementById(divName);
    div.style.display = "block";
}
/*floatLayer.js*/
// JavaScript Document
function JSFX_FloatTopLeft() {
    var obj = document.getElementById('divStayTopLeft');
    var startX = 18;
    var startY = -1;

    var ns = (navigator.appName.indexOf("Netscape") != -1);
    var d = document;
    var px = document.layers ? "" : "px";
    function ml(id) {
        var el = d.getElementById ? d.getElementById(id) : d.all ? d.all[id] : d.layers[id];
        if (d.layers) el.style = el;
        el.sP = function(x, y) { this.style.left = x + px; this.style.top = y + px; };
        el.x = startX; el.y = startY;
        return el;
    }
    window.stayTopLeft = function() {
        var pY = ns ? pageYOffset : document.documentElement && document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop;
        ftlObj.y += (pY + startY - ftlObj.y) / 8;
        ftlObj.sP(ftlObj.x, ftlObj.y);
        setTimeout("stayTopLeft()", 10);
    }
    ftlObj = ml("divStayTopLeft");
    stayTopLeft();
}
/*floater.js*/
// JavaScript Document
function initFloaters() {
    if (!document.getElementById) return;
    allFloaters = new Array();

    floater1 = new floater('bidhistory', 3, -1, -1, 30, 30);
}
function floater(div, position, width, height, hMargin, vMargin) {
    this.div = document.getElementById(div);
    this.div.style.visibility = 'visible';
    if (width == -1) width = this.div.offsetWidth;
    if (height == -1) height = this.div.offsetHeight;
    this.position = position;
    this.width = width;
    this.height = height;
    this.hMargin = hMargin;
    this.vMargin = vMargin;

    this.doFloat = doFloat;
    this.idNo = allFloaters.length;
    allFloaters[allFloaters.length] = this;
    this.floatTimer = setInterval("allFloaters[" + this.idNo + "].doFloat()", 20);
}
function doFloat() {
    browserVars.updateVars();
    var w = browserVars.width - this.width;
    var h = browserVars.height - this.height;
    var xPos = 0;
    var yPos = 0;
    if (this.position == 1) { xPos = this.hMargin; yPos = this.vMargin; }
    if (this.position == 2) { xPos = w / 2; yPos = this.vMargin; }
    if (this.position == 3) { xPos = w - this.hMargin; yPos = this.vMargin; }
    if (this.position == 4) { xPos = w - this.hMargin; yPos = h / 2; }
    if (this.position == 5) { xPos = w - this.hMargin; yPos = h - this.vMargin; }
    if (this.position == 6) { xPos = w / 2; yPos = h - this.vMargin; }
    if (this.position == 7) { xPos = this.hMargin; yPos = h - this.vMargin; }
    if (this.position == 8) { xPos = this.hMargin; yPos = h / 2; }
    if (this.position == 9) { xPos = w / 2; yPos = h / 2; }

    if (isNaN(xPos) || isNaN(yPos)) return;

    this.div.style.left = browserVars.scrollLeft + xPos;
    this.div.style.top = browserVars.scrollTop + yPos;
}
/*drag.js*/
// JavaScript Document
function MM_findObj(n, d) { //v4.01
    var p, i, x; if (!d) d = document; if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
        d = parent.frames[n.substring(p + 1)].document; n = n.substring(0, p);
    }
    if (!(x = d[n]) && d.all) x = d.all[n]; for (i = 0; !x && i < d.forms.length; i++) x = d.forms[i][n];
    for (i = 0; !x && d.layers && i < d.layers.length; i++) x = MM_findObj(n, d.layers[i].document);
    if (!x && d.getElementById) x = d.getElementById(n); return x;
}
function MM_dragLayer(objName, x, hL, hT, hW, hH, toFront, dropBack, cU, cD, cL, cR, targL, targT, tol, dropJS, et, dragJS) { //v4.01
    //Copyright 1998 Macromedia, Inc. All rights reserved.
    var i, j, aLayer, retVal, curDrag = null, curLeft, curTop, IE = document.all, NS4 = document.layers;
    var NS6 = (!IE && document.getElementById), NS = (NS4 || NS6); if (!IE && !NS) return false;
    retVal = true; if (IE && event) event.returnValue = true;
    if (MM_dragLayer.arguments.length > 1) {
        curDrag = MM_findObj(objName); if (!curDrag) return false;
        if (!document.allLayers) {
            document.allLayers = new Array();
            with (document) if (NS4) {
                for (i = 0; i < layers.length; i++) allLayers[i] = layers[i];
                for (i = 0; i < allLayers.length; i++) if (allLayers[i].document && allLayers[i].document.layers)
                    with (allLayers[i].document) for (j = 0; j < layers.length; j++) allLayers[allLayers.length] = layers[j];
            } else {
                if (NS6) {
                    var spns = getElementsByTagName("span"); var all = getElementsByTagName("div");
                    for (i = 0; i < spns.length; i++) if (spns[i].style && spns[i].style.position) allLayers[allLayers.length] = spns[i];
                }
                for (i = 0; i < all.length; i++) if (all[i].style && all[i].style.position) allLayers[allLayers.length] = all[i];
            }
        }
        curDrag.MM_dragOk = true; curDrag.MM_targL = targL; curDrag.MM_targT = targT;
        curDrag.MM_tol = Math.pow(tol, 2); curDrag.MM_hLeft = hL; curDrag.MM_hTop = hT;
        curDrag.MM_hWidth = hW; curDrag.MM_hHeight = hH; curDrag.MM_toFront = toFront;
        curDrag.MM_dropBack = dropBack; curDrag.MM_dropJS = dropJS;
        curDrag.MM_everyTime = et; curDrag.MM_dragJS = dragJS;
        curDrag.MM_oldZ = (NS4) ? curDrag.zIndex : curDrag.style.zIndex;
        curLeft = (NS4) ? curDrag.left : (NS6) ? parseInt(curDrag.style.left) : curDrag.style.pixelLeft;
        if (String(curLeft) == "NaN") curLeft = 0; curDrag.MM_startL = curLeft;
        curTop = (NS4) ? curDrag.top : (NS6) ? parseInt(curDrag.style.top) : curDrag.style.pixelTop;
        if (String(curTop) == "NaN") curTop = 0; curDrag.MM_startT = curTop;
        curDrag.MM_bL = (cL < 0) ? null : curLeft - cL; curDrag.MM_bT = (cU < 0) ? null : curTop - cU;
        curDrag.MM_bR = (cR < 0) ? null : curLeft + cR; curDrag.MM_bB = (cD < 0) ? null : curTop + cD;
        curDrag.MM_LEFTRIGHT = 0; curDrag.MM_UPDOWN = 0; curDrag.MM_SNAPPED = false; //use in your JS!
        document.onmousedown = MM_dragLayer; document.onmouseup = MM_dragLayer;
        if (NS) document.captureEvents(Event.MOUSEDOWN | Event.MOUSEUP);
    } else {
        var theEvent = ((NS) ? objName.type : event.type);
        if (theEvent == 'mousedown') {
            var mouseX = (NS) ? objName.pageX : event.clientX + document.body.scrollLeft;
            var mouseY = (NS) ? objName.pageY : event.clientY + document.body.scrollTop;
            var maxDragZ = null; document.MM_maxZ = 0;
            for (i = 0; i < document.allLayers.length; i++) {
                aLayer = document.allLayers[i];
                var aLayerZ = (NS4) ? aLayer.zIndex : parseInt(aLayer.style.zIndex);
                if (aLayerZ > document.MM_maxZ) document.MM_maxZ = aLayerZ;
                var isVisible = (((NS4) ? aLayer.visibility : aLayer.style.visibility).indexOf('hid') == -1);
                if (aLayer.MM_dragOk != null && isVisible) with (aLayer) {
                    var parentL = 0; var parentT = 0;
                    if (NS6) {
                        parentLayer = aLayer.parentNode;
                        while (parentLayer != null && parentLayer.style.position) {
                            parentL += parseInt(parentLayer.offsetLeft); parentT += parseInt(parentLayer.offsetTop);
                            parentLayer = parentLayer.parentNode;
                        }
                    } else if (IE) {
                        parentLayer = aLayer.parentElement;
                        while (parentLayer != null && parentLayer.style.position) {
                            parentL += parentLayer.offsetLeft; parentT += parentLayer.offsetTop;
                            parentLayer = parentLayer.parentElement;
                        }
                    }
                    var tmpX = mouseX - (((NS4) ? pageX : ((NS6) ? parseInt(style.left) : style.pixelLeft) + parentL) + MM_hLeft);
                    var tmpY = mouseY - (((NS4) ? pageY : ((NS6) ? parseInt(style.top) : style.pixelTop) + parentT) + MM_hTop);
                    if (String(tmpX) == "NaN") tmpX = 0; if (String(tmpY) == "NaN") tmpY = 0;
                    var tmpW = MM_hWidth; if (tmpW <= 0) tmpW += ((NS4) ? clip.width : offsetWidth);
                    var tmpH = MM_hHeight; if (tmpH <= 0) tmpH += ((NS4) ? clip.height : offsetHeight);
                    if ((0 <= tmpX && tmpX < tmpW && 0 <= tmpY && tmpY < tmpH) && (maxDragZ == null
              || maxDragZ <= aLayerZ)) { curDrag = aLayer; maxDragZ = aLayerZ; }
                }
            }
            if (curDrag) {
                document.onmousemove = MM_dragLayer; if (NS4) document.captureEvents(Event.MOUSEMOVE);
                curLeft = (NS4) ? curDrag.left : (NS6) ? parseInt(curDrag.style.left) : curDrag.style.pixelLeft;
                curTop = (NS4) ? curDrag.top : (NS6) ? parseInt(curDrag.style.top) : curDrag.style.pixelTop;
                if (String(curLeft) == "NaN") curLeft = 0; if (String(curTop) == "NaN") curTop = 0;
                MM_oldX = mouseX - curLeft; MM_oldY = mouseY - curTop;
                document.MM_curDrag = curDrag; curDrag.MM_SNAPPED = false;
                if (curDrag.MM_toFront) {
                    eval('curDrag.' + ((NS4) ? '' : 'style.') + 'zIndex=document.MM_maxZ+1');
                    if (!curDrag.MM_dropBack) document.MM_maxZ++;
                }
                retVal = false; if (!NS4 && !NS6) event.returnValue = false;
            }
        } else if (theEvent == 'mousemove') {
            if (document.MM_curDrag) with (document.MM_curDrag) {
                var mouseX = (NS) ? objName.pageX : event.clientX + document.body.scrollLeft;
                var mouseY = (NS) ? objName.pageY : event.clientY + document.body.scrollTop;
                newLeft = mouseX - MM_oldX; newTop = mouseY - MM_oldY;
                if (MM_bL != null) newLeft = Math.max(newLeft, MM_bL);
                if (MM_bR != null) newLeft = Math.min(newLeft, MM_bR);
                if (MM_bT != null) newTop = Math.max(newTop, MM_bT);
                if (MM_bB != null) newTop = Math.min(newTop, MM_bB);
                MM_LEFTRIGHT = newLeft - MM_startL; MM_UPDOWN = newTop - MM_startT;
                if (NS4) { left = newLeft; top = newTop; }
                else if (NS6) { style.left = newLeft; style.top = newTop; }
                else { style.pixelLeft = newLeft; style.pixelTop = newTop; }
                if (MM_dragJS) eval(MM_dragJS);
                retVal = false; if (!NS) event.returnValue = false;
            }
        } else if (theEvent == 'mouseup') {
            document.onmousemove = null;
            if (NS) document.releaseEvents(Event.MOUSEMOVE);
            if (NS) document.captureEvents(Event.MOUSEDOWN); //for mac NS
            if (document.MM_curDrag) with (document.MM_curDrag) {
                if (typeof MM_targL == 'number' && typeof MM_targT == 'number' &&
            (Math.pow(MM_targL - ((NS4) ? left : (NS6) ? parseInt(style.left) : style.pixelLeft), 2) +
             Math.pow(MM_targT - ((NS4) ? top : (NS6) ? parseInt(style.top) : style.pixelTop), 2)) <= MM_tol) {
                    if (NS4) { left = MM_targL; top = MM_targT; }
                    else if (NS6) { style.left = MM_targL; style.top = MM_targT; }
                    else { style.pixelLeft = MM_targL; style.pixelTop = MM_targT; }
                    MM_SNAPPED = true; MM_LEFTRIGHT = MM_startL - MM_targL; MM_UPDOWN = MM_startT - MM_targT;
                }
                if (MM_everyTime || MM_SNAPPED) eval(MM_dropJS);
                if (MM_dropBack) { if (NS4) zIndex = MM_oldZ; else style.zIndex = MM_oldZ; }
                retVal = false; if (!NS) event.returnValue = false;
            }
            document.MM_curDrag = null;
        }
        if (NS) document.routeEvent(objName);
    } return retVal;
}
/*dom-drag.js*/
/**************************************************
* dom-drag.js
* 09.25.2001
* www.youngpup.net
* Script featured on Dynamic Drive (http://www.dynamicdrive.com) 12.08.2005
**************************************************
* 10.28.2001 - fixed minor bug where events
* sometimes fired off the handle, not the root.
**************************************************/
var Drag = {
    obj: null,
    init: function(o, oRoot, minX, maxX, minY, maxY, bSwapHorzRef, bSwapVertRef, fXMapper, fYMapper) {
        o.onmousedown = Drag.start;

        o.hmode = bSwapHorzRef ? false : true;
        o.vmode = bSwapVertRef ? false : true;

        o.root = oRoot && oRoot != null ? oRoot : o;

        if (o.hmode && isNaN(parseInt(o.root.style.left))) o.root.style.left = "0px";
        if (o.vmode && isNaN(parseInt(o.root.style.top))) o.root.style.top = "0px";
        if (!o.hmode && isNaN(parseInt(o.root.style.right))) o.root.style.right = "0px";
        if (!o.vmode && isNaN(parseInt(o.root.style.bottom))) o.root.style.bottom = "0px";

        o.minX = typeof minX != 'undefined' ? minX : null;
        o.minY = typeof minY != 'undefined' ? minY : null;
        o.maxX = typeof maxX != 'undefined' ? maxX : null;
        o.maxY = typeof maxY != 'undefined' ? maxY : null;

        o.xMapper = fXMapper ? fXMapper : null;
        o.yMapper = fYMapper ? fYMapper : null;

        o.root.onDragStart = new Function();
        o.root.onDragEnd = new Function();
        o.root.onDrag = new Function();
    },

    start: function(e) {
        var o = Drag.obj = this;
        e = Drag.fixE(e);
        var y = parseInt(o.vmode ? o.root.style.top : o.root.style.bottom);
        var x = parseInt(o.hmode ? o.root.style.left : o.root.style.right);
        o.root.onDragStart(x, y);

        o.lastMouseX = e.clientX;
        o.lastMouseY = e.clientY;

        if (o.hmode) {
            if (o.minX != null) o.minMouseX = e.clientX - x + o.minX;
            if (o.maxX != null) o.maxMouseX = o.minMouseX + o.maxX - o.minX;
        } else {
            if (o.minX != null) o.maxMouseX = -o.minX + e.clientX + x;
            if (o.maxX != null) o.minMouseX = -o.maxX + e.clientX + x;
        }

        if (o.vmode) {
            if (o.minY != null) o.minMouseY = e.clientY - y + o.minY;
            if (o.maxY != null) o.maxMouseY = o.minMouseY + o.maxY - o.minY;
        } else {
            if (o.minY != null) o.maxMouseY = -o.minY + e.clientY + y;
            if (o.maxY != null) o.minMouseY = -o.maxY + e.clientY + y;
        }

        document.onmousemove = Drag.drag;
        document.onmouseup = Drag.end;

        return false;
    },

    drag: function(e) {
        e = Drag.fixE(e);
        var o = Drag.obj;

        var ey = e.clientY;
        var ex = e.clientX;
        var y = parseInt(o.vmode ? o.root.style.top : o.root.style.bottom);
        var x = parseInt(o.hmode ? o.root.style.left : o.root.style.right);
        var nx, ny;

        if (o.minX != null) ex = o.hmode ? Math.max(ex, o.minMouseX) : Math.min(ex, o.maxMouseX);
        if (o.maxX != null) ex = o.hmode ? Math.min(ex, o.maxMouseX) : Math.max(ex, o.minMouseX);
        if (o.minY != null) ey = o.vmode ? Math.max(ey, o.minMouseY) : Math.min(ey, o.maxMouseY);
        if (o.maxY != null) ey = o.vmode ? Math.min(ey, o.maxMouseY) : Math.max(ey, o.minMouseY);

        nx = x + ((ex - o.lastMouseX) * (o.hmode ? 1 : -1));
        ny = y + ((ey - o.lastMouseY) * (o.vmode ? 1 : -1));

        if (o.xMapper) nx = o.xMapper(y)
        else if (o.yMapper) ny = o.yMapper(x)

        Drag.obj.root.style[o.hmode ? "left" : "right"] = nx + "px";
        Drag.obj.root.style[o.vmode ? "top" : "bottom"] = ny + "px";
        Drag.obj.lastMouseX = ex;
        Drag.obj.lastMouseY = ey;

        Drag.obj.root.onDrag(nx, ny);
        return false;
    },

    end: function() {
        document.onmousemove = null;
        document.onmouseup = null;
        Drag.obj.root.onDragEnd(parseInt(Drag.obj.root.style[Drag.obj.hmode ? "left" : "right"]),
									parseInt(Drag.obj.root.style[Drag.obj.vmode ? "top" : "bottom"]));
        Drag.obj = null;
    },

    fixE: function(e) {
        if (typeof e == 'undefined') e = window.event;
        if (typeof e.layerX == 'undefined') e.layerX = e.offsetX;
        if (typeof e.layerY == 'undefined') e.layerY = e.offsetY;
        return e;
    }
};
/*collapseableDIV.js*/
var ExpandImageSrc = "expand.jpg"; //image location to display when Div is collapsed
var CollapseImageSrc = "collapse.jpg"; //image location to display when Div is Expanded
//Code
//********************************************************
var iTimer;
var calcHeight;
function toggleDiv(divToShow, imgID) {
    var help = document.getElementById(divToShow);
    if (help.style.display != "block") {
        if (imgID) {
            document.getElementById(imgID).setAttribute('src', CollapseImageSrc);
        }
        showDiv(divToShow);
    }
    else {
        if (imgID) {
            document.getElementById(imgID).setAttribute('src', ExpandImageSrc);
        }
        collapse(divToShow);
    }
}
function collapse(divName) {
    var help = document.getElementById(divName);
    help.style.display = "none";
}
function showDiv(divName) {
    var div = document.getElementById(divName);
    div.style.display = "block";
}
//*******************************************************
/*browser.js*/
/* Browser Detection Script */
browserVars = new browserVarsObj();
if (!browserVars.type.getById) document.captureEvents(Event.MOUSEMOVE)
document.onmousemove = new Function('e', 'browserVars.updateMouse(e)');
function browserDetect() {
    this.getById = document.getElementById ? true : false;
    this.layers = document.layers ? true : false;
    this.ns4 = ((this.layers) && (!this.getById));
    this.ns6 = ((navigator.userAgent.indexOf('Netscape6') != -1) && (this.getById));
    this.moz = ((navigator.appName.indexOf('Netscape') != -1) && (this.getById) && (!this.ns6));
    this.ie = ((!this.layers) && (this.getById) && (!(this.ns6 || this.moz)));
    this.opera = window.opera ? true : false;
}
function browserVarsObj() {
    this.updateMouse = browserVarsObjUpdateMouse;
    this.updateVars = browserVarsObjUpdateVars;
    this.mouseX = 0;
    this.mouseY = 0;
    this.type = new browserDetect();
    this.width = 0;
    this.height = 0
    this.screenWidth = screen.width;
    this.screenHeight = screen.height;
    this.scrollWidth = 0;
    this.scrollHeight = 0;
    this.scrollLeft = 0;
    this.scrollTop = 0;
    this.updateVars();
}
function browserVarsObjUpdateMouse(e) {
    if (!this.type.ie) {
        this.mouseX = e.pageX;
        this.mouseY = e.pageY;
    }
    else {
        this.mouseX = window.event.clientX + this.scrollLeft;
        this.mouseY = window.event.clientY + this.scrollTop;
    }
}
function browserVarsObjUpdateVars() {
    if (!this.type.getById) {
        this.width = window.innerWidth;
        this.height = window.innerHeight;
        this.scrollWidth = document.width;
        this.scrollHeight = document.height;
        this.scrollLeft = window.pageXOffset;
        this.scrollTop = window.pageYOffset;
        if (this.width < this.scrollWidth) this.width -= 16
        if (this.height < this.scrollHeight) this.height -= 16
    }
    else {
        if ((!(this.type.ns6 || this.type.moz)) && (document.body)) {
            this.width = document.body.offsetWidth;
            this.height = document.body.offsetHeight;
            this.scrollWidth = document.body.scrollWidth;
            this.scrollHeight = document.body.scrollHeight;
            this.scrollLeft = document.body.scrollLeft;
            this.scrollTop = document.body.scrollTop;
        }

        if ((this.type.ns6 || this.type.moz) && (document.body)) {
            this.width = window.innerWidth;
            this.height = window.innerHeight;
            this.scrollWidth = document.body.scrollWidth;
            this.scrollHeight = document.body.scrollHeight;
            this.scrollLeft = window.pageXOffset;
            this.scrollTop = window.pageYOffset;
        }
    }
}
function showChangeRoles() {

    if (document.getElementById('hidediv').style.display == 'none') {
        document.getElementById('hidediv').style.display = 'block';
        document.getElementById('hidediv').style.display == 'block'

        //        if (document.getElementById('hideOPdiv')) {
        //            if (document.getElementById('hideOPdiv').style.display == 'block') {
        //                document.getElementById('hideOPdiv').style.display = 'none';
        //                document.getElementById('hideOPdiv').style.display == 'none'
        //            } 
        //        }
        if (document.getElementById('hidedivRates')) {
            if (document.getElementById('hidedivRates').style.display == 'block') {
                document.getElementById('hidedivRates').style.display = 'none';
                document.getElementById('hidedivRates').style.display == 'none'
            }
        }
        if (document.getElementById('hideIPdiv')) {
            if (document.getElementById('hideIPdiv').style.display == 'block') {
                document.getElementById('hideIPdiv').style.display = 'none';
                document.getElementById('hideIPdiv').style.display == 'none'
            }
        }
        if (document.getElementById('hideInventorydiv')) {
            if (document.getElementById('hideInventorydiv').style.display == 'block') {
                document.getElementById('hideInventorydiv').style.display = 'none';
                document.getElementById('hideInventorydiv').style.display == 'none'
            }
        }
        if (document.getElementById('hideReferraldiv')) {
            if (document.getElementById('hideReferraldiv').style.display == 'block') {
                document.getElementById('hideReferraldiv').style.display = 'none';
                document.getElementById('hideReferraldiv').style.display == 'none'
            }
        }
        if (document.getElementById('hideManageSchedules')) {
            if (document.getElementById('hideManageSchedules').style.display == 'block') {
                document.getElementById('hideManageSchedules').style.display = 'none';
                document.getElementById('hideManageSchedules').style.display == 'none'
            }
        }
    }
    else {
        document.getElementById('hidediv').style.display = 'none';
        document.getElementById('hidediv').style.display == 'none'
    }
}
/*SelectRole.aspx*/
function DisableRadioButton(rdButtonid) {

    var len = document.forms[0].elements.length;
    for (var i = 0; i < len; i++) {
        if (document.forms[0].elements[i].type == "radio") {
            document.forms[0].elements[i].checked = false;
        }
    }
    document.getElementById(rdButtonid).checked = true;
}
/*Investigation Profile.aspx*/
function SelectPanel(id) {
    if (document.getElementById(id).checked) {
        document.getElementById('Profile1_chk1008').checked = true;
        document.getElementById('Profile1_chk1005').checked = true;
        document.getElementById('Profile1_chk1006').checked = true;
        document.getElementById('Profile1_chk1010').checked = true;
    }
    else {
        document.getElementById('Profile1_chk1008').checked = false;
        document.getElementById('Profile1_chk1005').checked = false;
        document.getElementById('Profile1_chk1006').checked = false;
        document.getElementById('Profile1_chk1010').checked = false;
    }
}
function checkTorch() {
    var ctrlid = new Array('Profile1_chk1008', 'Profile1_chk1005', 'Profile1_chk1006', 'Profile1_chk1010');
    var cnt = 0;
    for (i = 0; i < ctrlid.length; i++) {
        if (document.getElementById(ctrlid[i]).checked == true) {
            cnt = cnt + 1;
        }
    }
    if (cnt == 4) {
        document.getElementById('Profile1_chkTorchpanel').checked = true;
    }
    else {
        document.getElementById('Profile1_chkTorchpanel').checked = false;
    }
}
function SelectHepatitis(id) {
    if (document.getElementById(id).checked) {
        document.getElementById('Profile1_chk4127').checked = true;
        document.getElementById('Profile1_chk4128').checked = true;
        document.getElementById('Profile1_chk4129').checked = true;
        document.getElementById('Profile1_chk4132').checked = true;
        document.getElementById('Profile1_chk4134').checked = true;
    }
    else {
        document.getElementById('Profile1_chk4127').checked = false;
        document.getElementById('Profile1_chk4128').checked = false;
        document.getElementById('Profile1_chk4129').checked = false;
        document.getElementById('Profile1_chk4132').checked = false;
        document.getElementById('Profile1_chk4134').checked = false;
    }
}
function checkHepatitis() {
    var ctrlid = new Array('Profile1_chk4127', 'Profile1_chk4128', 'Profile1_chk4129', 'Profile1_chk4132', 'Profile1_chk4134');
    var cnt = 0;
    for (i = 0; i < ctrlid.length; i++) {
        if (document.getElementById(ctrlid[i]).checked == true) {
            cnt = cnt + 1;
        }
    }
    if (cnt == 5) {
        document.getElementById('Profile1_chkHepatitis').checked = true;
    }
    else {
        document.getElementById('Profile1_chkHepatitis').checked = false;
    }
}
function SelectCoagulate(id) {
    if (document.getElementById(id).checked) {
        document.getElementById('Profile1_chkPlateletCount').checked = true;
        document.getElementById('Profile1_chkBleedingTime').checked = true;
        document.getElementById('Profile1_chkClottingTime').checked = true;
        document.getElementById('Profile1_chkProthrombinTimeINR').checked = true;
        document.getElementById('Profile1_chkAPTT').checked = true;
    }
    else {
        document.getElementById('Profile1_chkPlateletCount').checked = false;
        document.getElementById('Profile1_chkBleedingTime').checked = false;
        document.getElementById('Profile1_chkClottingTime').checked = false;
        document.getElementById('Profile1_chkProthrombinTimeINR').checked = false;
        document.getElementById('Profile1_chkAPTT').checked = false;
    }
}
function checkCoagulate() {
    var ctrlid = new Array('Profile1_chkPlateletCount', 'Profile1_chkBleedingTime', 'Profile1_chkClottingTime', 'Profile1_chkProthrombinTimeINR', 'Profile1_chkAPTT');
    var cnt = 0;
    for (i = 0; i < ctrlid.length; i++) {
        if (document.getElementById(ctrlid[i]).checked == true) {
            cnt = cnt + 1;
        }
    }
    if (cnt == 5) {
        document.getElementById('Profile1_chkCoagulation').checked = true;
    }
    else {
        document.getElementById('Profile1_chkCoagulation').checked = false;
    }
}
function SelectSerology(id) {
    var ctrlid = new Array('Profile1_chk4121', 'Profile1_chk4089', 'Profile1_chk4092', 'Profile1_chk4091', 'Profile1_chk4090', 'Profile1_chk4084', 'Profile1_chk4088');

    if (document.getElementById(id).checked) {
        for (i = 0; i < ctrlid.length; i++) {
            document.getElementById(ctrlid[i]).checked = true;
        }
    }
    else {
        for (i = 0; i < ctrlid.length; i++) {
            document.getElementById(ctrlid[i]).checked = false;
        }
    }
}
function checkSerology() {
    var ctrlid = new Array('Profile1_chk4121', 'Profile1_chk4089', 'Profile1_chk4092', 'Profile1_chk4091', 'Profile1_chk4090', 'Profile1_chk4084', 'Profile1_chk4088');
    var cnt = 0;
    for (i = 0; i < ctrlid.length; i++) {
        if (document.getElementById(ctrlid[i]).checked == true) {
            cnt = cnt + 1;
        }
    }
    if (cnt == 7) {
        document.getElementById('Profile1_chkSerology').checked = true;
    }
    else {
        document.getElementById('Profile1_chkSerology').checked = false;
    }
}
function SelectElectrolyte(id) {
    var ctrlid = new Array('Profile1_chk3003', 'Profile1_chk3004', 'Profile1_chk3005');
    if (document.getElementById(id).checked) {
        for (i = 0; i < ctrlid.length; i++) {
            document.getElementById(ctrlid[i]).checked = true;
        }
    }
    else {
        for (i = 0; i < ctrlid.length; i++) {
            document.getElementById(ctrlid[i]).checked = false;
        }
    }
}
function checkElectro() {
    var ctrlid = new Array('Profile1_chk3003', 'Profile1_chk3004', 'Profile1_chk3005');
    var cnt = 0;
    for (i = 0; i < ctrlid.length; i++) {
        if (document.getElementById(ctrlid[i]).checked == true) {
            cnt = cnt + 1;
        }
    }
    if (cnt == 3) {
        document.getElementById('Profile1_chkElectrolyte').checked = true;
    }
    else {
        document.getElementById('Profile1_chkElectrolyte').checked = false;
    }
}
function Passwordvalidation() {
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    var minpasslen = document.getElementById("hdnMinpasslength").value;
    if (document.getElementById('hdnpwdplcycount').value != '0') {

        if (document.getElementById('txtOldpassword').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_59") == null ? "Provide old password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_59");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtOldpassword').focus();
            return false;
        }


        if (document.getElementById('txtNewpassword').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_60") == null ? "Provide new password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_60");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtConfirmpassword').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_61") == null ? "Provide confirm password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_61");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtConfirmpassword').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value.length < minpasslen) {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_62") == null ? "Password length should be minimum of {0} characters." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_62");
            userMsg = userMsg.replace('{0}', minpasslen)
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        var passlen = document.getElementById("hdnpasslength").value;
        if (document.getElementById('txtNewpassword').value.length > Number(passlen)) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_63") == null ? "Maximum Length Reached Please check Password Hint." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_63");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value != document.getElementById('txtConfirmpassword').value) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_64") == null ? "There is a password mismatch" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_64");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }
        if (document.getElementById('txtOldpassword').value == document.getElementById('txtNewpassword').value) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_65") == null ? "New password and old password cannot be same" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_65");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtOldpassword').value = '';
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtOldpassword').focus();
            return false;
        }


        if (document.getElementById('txtNewpassword').value == document.getElementById('txtConfirmpassword').value) {
            var passlen = document.getElementById("hdnpasslength").value;
            var splchar = document.getElementById("hdnsplcharlen").value;
            var numchar = document.getElementById("hdnnumcharlen").value;

            var pw = document.getElementById('txtConfirmpassword').value;
            var passed = validatePassword(pw, { alpha: 1, special: splchar, numeric: numchar });
            if (!passed) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_66") == null ? "Password Policy Mismatch Please check Password Hint" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_66");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtNewpassword').value = '';
                document.getElementById('txtConfirmpassword').value = '';
                document.getElementById('txtNewpassword').focus();
                return false;
            }

        }

    }
    else {

        if (document.getElementById('txtOldpassword').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_59") == null ? "Provide old password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_59");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtOldpassword').focus();
            return false;
        }


        if (document.getElementById('txtNewpassword').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_60") == null ? "Provide new password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_60");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtConfirmpassword').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_61") == null ? "Provide confirm password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_61");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtConfirmpassword').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value.length < minpasslen) {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_62") == null ? "Password length should be minimum of {0} characters." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_62");
            userMsg = userMsg.replace('{0}', minpasslen);
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value != document.getElementById('txtConfirmpassword').value) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_64") == null ? "There is a password mismatch" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_64");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }
        if (document.getElementById('txtOldpassword').value == document.getElementById('txtNewpassword').value) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_65") == null ? "New password and old password cannot be same" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_65");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtOldpassword').value = '';
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtOldpassword').focus();
            return false;
        }
        if (document.getElementById('txtNewpassword').value == document.getElementById('txtConfirmpassword').value) {
            var pw = document.getElementById('txtConfirmpassword').value;
            var passed = validatePassword(pw, { alpha: 1, special: 1, numeric: 1 });
            if (!passed) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_67") == null ? "Password should contain atleast one special character,an alphabet and a number" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_67");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtNewpassword').value = '';
                document.getElementById('txtConfirmpassword').value = '';
                document.getElementById('txtNewpassword').focus();
                return false;
            }

        }


    }

    if (document.getElementById('hdntranspwdplcycount').value != '0') {


        if (document.getElementById('Txtoldtranspwd').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_68") == null ? "Provide old Transaction password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_68");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('Txtoldtranspwd').focus();
            return false;
        }

        if (document.getElementById('TxtNewtranspwd').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_69") == null ? "Provide New Transaction password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_69");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }

        if (document.getElementById('TxtconTranspwd').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_70") == null ? "Provide Confirm Transaction password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_70");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('TxtconTranspwd').focus();
            return false;
        }



        if (document.getElementById('TxtNewtranspwd').value.length < 6) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_71") == null ? "Transaction Password length should be minimum of 6 characters." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_71");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }

        var passlen = document.getElementById("hdntranspasslength").value;
        if (passlen != "") {
            if (document.getElementById('TxtNewtranspwd').value.length > Number(passlen)) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_72") == null ? "Maximum Length Reached Please check transaction Password Hint." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_72");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('TxtNewtranspwd').value = '';
                document.getElementById('TxtconTranspwd').value = '';
                document.getElementById('TxtNewtranspwd').focus();
                return false;
            }
        }

        if (document.getElementById('Txtoldtranspwd').value == document.getElementById('TxtNewtranspwd').value) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_73") == null ? "New Transaction password and old Transaction password cannot be same" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_73");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('Txtoldtranspwd').value = '';
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('Txtoldtranspwd').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value == document.getElementById('TxtNewtranspwd').value) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_74") == null ? "New password and Transaction password cannot be same" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_74");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }



        if (document.getElementById('TxtNewtranspwd').value != document.getElementById('TxtconTranspwd').value) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_75") == null ? "There is a Transaction password mismatch" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_75");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }




        if (document.getElementById('TxtNewtranspwd').value == document.getElementById('TxtconTranspwd').value) {
            var pw = document.getElementById('TxtconTranspwd').value;
            var transpasslen = document.getElementById("hdntranspasslength").value;
            var transsplchar = document.getElementById("hdntranssplcharlen").value;
            var transnumchar = document.getElementById("hdntransnumcharlen").value;
            var passed = validatePassword(pw, { alpha: 1, special: transsplchar, numeric: transnumchar });
            if (!passed) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_76") == null ? "Transaction Password Policy Mismatch Please check Transaction Password Hint" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_76");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('TxtNewtranspwd').value = '';
                document.getElementById('TxtconTranspwd').value = '';
                document.getElementById('TxtNewtranspwd').focus();
                return false;
            }

        }

    }

    else {

        if (document.getElementById('Txtoldtranspwd').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_68") == null ? "Provide old Transaction password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_68");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('Txtoldtranspwd').focus();
            return false;
        }

        if (document.getElementById('TxtNewtranspwd').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_69") == null ? "Provide New Transaction password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_69");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }

        if (document.getElementById('TxtconTranspwd').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_70") == null ? "Provide Confirm Transaction password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_70");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('TxtconTranspwd').focus();
            return false;
        }



        if (document.getElementById('TxtNewtranspwd').value.length < 6) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_71") == null ? "Transaction Password length should be minimum of 6 characters." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_71");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }


        if (document.getElementById('Txtoldtranspwd').value == document.getElementById('TxtNewtranspwd').value) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_73") == null ? "New Transaction password and old Transaction password cannot be same" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_73");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('Txtoldtranspwd').value = '';
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('Txtoldtranspwd').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value == document.getElementById('TxtNewtranspwd').value) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_74") == null ? "New password and Transaction password cannot be same" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_74");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }



        if (document.getElementById('TxtNewtranspwd').value != document.getElementById('TxtconTranspwd').value) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_75") == null ? "There is a Transaction password mismatch" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_75");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }




        if (document.getElementById('TxtNewtranspwd').value == document.getElementById('TxtconTranspwd').value) {
            var pw = document.getElementById('TxtconTranspwd').value;
            var passed = validatePassword(pw, { alpha: 1, special: 1, numeric: 1 });
            if (!passed) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_77") == null ? "Transaction Password should contain atleast one special character,an alphabet and a number" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_77");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('TxtNewtranspwd').value = '';
                document.getElementById('TxtconTranspwd').value = '';
                document.getElementById('TxtNewtranspwd').focus();
                return false;
            }

        }
    }
    return true;
}
function TextboxValidation() {
    var passlen = document.getElementById("hdnpasslength").value;
    var minpasslen = document.getElementById("hdnMinpasslength").value;
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (document.getElementById('hdnpwdplcycount').value != '0') {

        if (document.getElementById('txtOldpassword').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_59") == null ? "Provide old password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_59");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtOldpassword').focus();
            return false;
        }
        if (document.getElementById('txtNewpassword').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_60") == null ? "Provide new password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_60");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtConfirmpassword').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_61") == null ? "Provide confirm password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_61");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtConfirmpassword').focus();
            return false;
        }
        if (document.getElementById('txtNewpassword').value.length < minpasslen) {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_62") == null ? "Password length should be minimum of " + minpasslen + " characters." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_62");
            userMsg = userMsg.replace('{0}', minpasslen);
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtNewpassword').focus();
            return false;
        }

      
        if (document.getElementById('txtNewpassword').value.length > Number(passlen)) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_63") == null ? "Maximum Length Reached Please check Password Hint." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_63");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtOldpassword').value == document.getElementById('txtNewpassword').value) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_65") == null ? "New password and old password cannot be same" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_65");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtOldpassword').value = '';
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtOldpassword').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value != document.getElementById('txtConfirmpassword').value) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_64") == null ? "There is a password mismatch" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_64");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }
       if (document.getElementById('txtNewpassword').value == document.getElementById('txtConfirmpassword').value) {
            var passlen = document.getElementById("hdnpasslength").value;
            var splchar = document.getElementById("hdnsplcharlen").value;
            var numchar = document.getElementById("hdnnumcharlen").value;

            var pw = document.getElementById('txtConfirmpassword').value;
            var passed = validatePassword(pw, { alpha: 0, special: splchar, numeric: numchar });
            if (!passed) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_66") == null ? "Password Policy Mismatch Please check Password Hint" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_66");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtNewpassword').value = '';
                document.getElementById('txtConfirmpassword').value = '';
                document.getElementById('txtNewpassword').focus();
                return false;
            }

        }
    }
    else {
        if (document.getElementById('txtOldpassword').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_59") == null ? "Provide old password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_59");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtOldpassword').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_60") == null ? "Provide new password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_60");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtConfirmpassword').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_61") == null ? "Provide confirm password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_61");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtConfirmpassword').focus();
            return false;
        }


        if (document.getElementById('txtNewpassword').value.length < minpasslen) {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_62") == null ? "Password length should be minimum of {0} characters." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_62");
            userMsg = userMsg.replace('{0}', minpasslen);
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }


        if (document.getElementById('txtOldpassword').value == document.getElementById('txtNewpassword').value) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_65") == null ? "New password and old password cannot be same" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_65");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtOldpassword').value = '';
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtOldpassword').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value != document.getElementById('txtConfirmpassword').value) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_64") == null ? "There is a password mismatch" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_64");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }



        if (document.getElementById('txtNewpassword').value == document.getElementById('txtConfirmpassword').value) {
            var pw = document.getElementById('txtConfirmpassword').value;
            var passed = validatePassword(pw, { alpha: 1, special: 1, numeric: 1 });
            if (!passed) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_67") == null ? "Password should contain atleast one special character,an alphabet and a number" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_67");
 ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtNewpassword').value = '';
                document.getElementById('txtConfirmpassword').value = '';
                document.getElementById('txtNewpassword').focus();
                return false;
            }

        }

    }

    return true;
}


function validatePassword(pw, options) {
    // default options (allows any password)
    var o = {
        lower: 0,
        upper: 0,
        alpha: 0, /* lower + upper */
        numeric: 0,
        special: 0,
        length: [0, Infinity],
        custom: [ /* regexes and/or functions */],
        badWords: [],
        badSequenceLength: 0,
        noQwertySequences: false,
        noSequential: false
    };

    for (var property in options)
        o[property] = options[property];

    var re = {
        numeric: /[0-9]/g,
        special: /[\W_]/g
    },
		rule, i;

    // enforce min/max length
    if (pw.length < o.length[0] || pw.length > o.length[1])
        return false;

    // enforce lower/upper/alpha/numeric/special rules
    for (rule in re) {
        if ((pw.match(re[rule]) || []).length < o[rule])
            return false;
    }
//Regex added to check multilanguage alphabets
 if ((XRegExp.match(re[rule], RegExSelector(),'all')).length < o[rule])
            return false;

    // enforce word ban (case insensitive)
    for (i = 0; i < o.badWords.length; i++) {
        if (pw.toLowerCase().indexOf(o.badWords[i].toLowerCase()) > -1)
            return false;
    }

    // enforce the no sequential, identical characters rule
    if (o.noSequential && /([\S\s])\1/.test(pw))
        return false;

    // enforce alphanumeric/qwerty sequence ban rules
    if (o.badSequenceLength) {
        var lower = "abcdefghijklmnopqrstuvwxyz",
			upper = lower.toUpperCase(),
			numbers = "0123456789",
			qwerty = "qwertyuiopasdfghjklzxcvbnm",
			start = o.badSequenceLength - 1,
			seq = "_" + pw.slice(0, start);
        for (i = start; i < pw.length; i++) {
            seq = seq.slice(1) + pw.charAt(i);
            if (
				lower.indexOf(seq) > -1 ||
				upper.indexOf(seq) > -1 ||
				numbers.indexOf(seq) > -1 ||
				(o.noQwertySequences && qwerty.indexOf(seq) > -1)
			) {
                return false;
            }
        }
    }

    // enforce custom regex/function rules
    for (i = 0; i < o.custom.length; i++) {
        rule = o.custom[i];
        if (rule instanceof RegExp) {
            if (!rule.test(pw))
                return false;
        } else if (rule instanceof Function) {
            if (!rule(pw))
                return false;
        }
    }

    // great success!
    return true;
}
function SelectHemogram(id) {
    var ctrlid = new Array('Profile1_chk2002', 'Profile1_chk2003', 'Profile1_chk2005', 'Profile1_chk2012',
        'Profile1_chk2014', 'Profile1_chk2032', 'Profile1_chk2033', 'Profile1_chk2034', 'Profile1_chk2035');
    if (document.getElementById(id).checked) {
        for (i = 0; i < ctrlid.length; i++) {
            document.getElementById(ctrlid[i]).checked = true;
        }
    }
    else {
        for (i = 0; i < ctrlid.length; i++) {
            document.getElementById(ctrlid[i]).checked = false;
        }
    }
}
function checkHemat() {
    var ctrlid = new Array('Profile1_chk2002', 'Profile1_chk2003', 'Profile1_chk2005', 'Profile1_chk2012',
        'Profile1_chk2014', 'Profile1_chk2032', 'Profile1_chk2033', 'Profile1_chk2034', 'Profile1_chk2035');
    var cnt = 0;
    for (i = 0; i < ctrlid.length; i++) {
        if (document.getElementById(ctrlid[i]).checked == true) {
            cnt = cnt + 1;
        }
    }
    if (cnt == 9) {
        document.getElementById('Profile1_chkCompleteHemogram').checked = true;
    }
    else {
        document.getElementById('Profile1_chkCompleteHemogram').checked = false;
    }
}
function calculate(objisi) {
    var pat = document.getElementById('2047_txtpatient').value;
    var ctrl = document.getElementById('2047_txtControl').value;
    var isi = document.getElementById('2047_' + objisi).value;
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (pat == '') {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_78") == null ? "Provide the value for patient" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_78");
        ValidationWindow(userMsg, errorMsg);
    }
    else if (ctrl == '') {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_79") == null ? "Provide the value for control" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_79");
        ValidationWindow(userMsg, errorMsg);
    }
    //alert(Math.pow((Number(pat) / Number(ctrl)), isi));
    document.getElementById('2047_txtINR').value = Math.pow((Number(pat) / Number(ctrl)), isi).toFixed(2);
}
//PatientiDiagnose.aspx
function ShowProfile(obj) {

    if ($('#' + obj).attr('class') == 'hide') {

        $('#' + obj).attr('class', 'show');
        $('#dMain').attr('class', 'hide');
    }
    else {
        $('#' + obj).attr('class', 'hide');
        $('#dMain').attr('class', 'show');
    }
}
/*Patterns*/
function Clear(obj) {
    if (document.getElementById(obj).value == 'Comments') {
        document.getElementById(obj).value = '';
    }
    else if (document.getElementById(obj).value == 'Reference range') {
        document.getElementById(obj).value = '';
    }
}
function setComments(obj) {
    var splitValue = obj.split('_');
    if (document.getElementById(obj).value == '') {
        if (splitValue[1] == "txtRefRange") {
            document.getElementById(obj).value = 'Reference range';
        }
        else if (splitValue[1] == "txtReason") {
            document.getElementById(obj).value = 'Comments';
        }
    }
}
/* Clear Function for Prescription */

function AdviceControlclear() {
var ddlselect = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_16") == null ? "Select" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_16");
    document.getElementById('uAd_tDName').value = '';
    // document.getElementById('uAd_tFrm').value = 'Tab.';
    //document.getElementById('uAd_tROA').value = '';
    document.getElementById('uAd_tDose').value = '';
    document.getElementById('uAd_txtFrequencyNumber').value = '1';
    document.getElementById('uAd_ddlFrequencyType').value = 'Day(s)';

    //document.getElementById('uAd_tDura').value = '';
    document.getElementById('uAd_ddlInstruction').value = '';
    document.getElementById('uAd_ddFormulation').value = 'Tab.';
    document.getElementById('uAd_tFrm').style.display = 'none';
    document.getElementById('uAd_ddFrequency').value = ddlselect;
    document.getElementById('uAd_tDName').focus();
    document.getElementById('uAd_tFRQ').value = '';
    document.getElementById('uAd_tFRQ').style.display = 'none';
    return false;
}




function addDaysToDate(frmId, toId) {
    addDt = document.getElementById(frmId).value.split('/');
    var d = new Date(addDt[2] + '/' + addDt[1] + '/' + addDt[0]);
    d.setDate(d.getDate() + 280);
    var futureDt = d.getDate() + '/' + (d.getMonth() + 1) + '/' + d.getFullYear();
    document.getElementById(toId).value = futureDt;
}
/* Tree view validation for investigation */

function OnTreeClick(evt) {

    var src = window.event != window.undefined ? window.event.srcElement : evt.target;
    var isChkBoxClick = (src.tagName.toLowerCase() == "input" && src.type == "checkbox");
    if (isChkBoxClick) {
        var parentTable = GetParentByTagName("table", src);
        var nxtSibling = parentTable.nextSibling;
        if (nxtSibling && nxtSibling.nodeType == 1)//check if nxt sibling is not null & is an element node
        {
            if (nxtSibling.tagName.toLowerCase() == "div") //if node has children
            {
                //check or uncheck children at all levels
                CheckUncheckChildren(parentTable.nextSibling, src.checked);
            }
        }
        //check or uncheck parents at all levels
        CheckUncheckParents(src, src.checked);
    }
}
function CheckUncheckChildren(childContainer, check) {
    var childChkBoxes = childContainer.getElementsByTagName("input");
    var childChkBoxCount = childChkBoxes.length;
    for (var i = 0; i < childChkBoxCount; i++) {
        childChkBoxes[i].checked = check;
    }
}
function CheckUncheckParents(srcChild, check) {
    var parentDiv = GetParentByTagName("div", srcChild);
    var parentNodeTable = parentDiv.previousSibling;
    if (parentNodeTable) {
        var checkUncheckSwitch;
        if (check) //checkbox checked
        {
            var isAllSiblingsChecked = AreAllSiblingsChecked(srcChild);
            if (isAllSiblingsChecked)
                checkUncheckSwitch = true;
            else
                return; //do not need to check parent if any child is not checked
        }
        else //checkbox unchecked
        {
            checkUncheckSwitch = false;
        }
        var inpElemsInParentTable = parentNodeTable.getElementsByTagName("input");
        if (inpElemsInParentTable.length > 0) {
            var parentNodeChkBox = inpElemsInParentTable[0];
            parentNodeChkBox.checked = checkUncheckSwitch;
            //do the same recursively
            CheckUncheckParents(parentNodeChkBox, checkUncheckSwitch);
        }
    }
}

function AreAllSiblingsChecked(chkBox) {
    var parentDiv = GetParentByTagName("div", chkBox);
    var childCount = parentDiv.childNodes.length;
    for (var i = 0; i < childCount; i++) {
        if (parentDiv.childNodes[i].nodeType == 1) //check if the child node is an element node
        {
            if (parentDiv.childNodes[i].tagName.toLowerCase() == "table") {
                var prevChkBox = parentDiv.childNodes[i].getElementsByTagName("input")[0];
                //if any of sibling nodes are not checked, return false
                if (!prevChkBox.checked) {
                    return false;
                }
            }
        }
    }
    return true;
}

//utility function to get the container of an element by tagname
function GetParentByTagName(parentTagName, childElementObj) {
    var parent = childElementObj.parentNode;
    while (parent.tagName.toLowerCase() != parentTagName.toLowerCase()) {
        parent = parent.parentNode;
    }
    return parent;
}


/* Tab control scripts */

/* Sample Registration and Billing Validation starts */
/* Sample Registration and Billing Validation starts */
function sampleRegValidation() {
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (document.getElementById('txtPatientName').value.trim() == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_80") == null ? "Provide Patient name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_80");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtPatientName').focus();
        return false;
    }

    if (document.getElementById('txtAge').value.trim() == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_81") == null ? "Provide Age" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_81");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtAge').focus();
        return false;
    }

    //    if (document.getElementById('patientAddressCtrl_txtAddress2').value == '') 
    //    {
    //        alert('Please Enter Street/Road Name');
    //        document.getElementById('patientAddressCtrl_txtAddress2').focus();
    //        return false;
    //    }
    if (document.getElementById('URNControl1_txtURNo').value != '') {

        if (document.getElementById('URNControl1_ddlUrnType').value == '0') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_82") == null ? "Provide the URN type" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_82");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('URNControl1_ddlUrnType').focus();
            return false;
        }
    }
    //    if (document.getElementById('ucPAdd_txtCity').value.trim() == '') {
    //        alert('Please Enter City');
    //        document.getElementById('ucPAdd_txtCity').focus();
    //        return false;
    //    }
    if (document.getElementById('ddlPhysician').value == 0 && document.getElementById('chkPhyOthers').checked != true) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_83") == null ? "Select Doctor name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_83");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('ddlPhysician').focus();
        return false;
    }
    else if (document.getElementById('chkPhyOthers').checked) {
        if (document.getElementById('txtDrName').value.trim() == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_84") == null ? "Provide Doctor name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_84");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtDrName').focus();
            return false;
        }
    }

    if ((document.getElementById('ddlHospital').value == "0") && (document.getElementById('ddlBranch').value == "0")) {
        if (document.getElementById('rdOthers').checked == false) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_85") == null ? "Select Hospital/branch" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_85");
 ValidationWindow(userMsg, errorMsg);
            return false;
        }
    }
    if ((document.getElementById('rdPackage').checked == true) && (document.getElementById('ddlPkg').options[0].selected == true)) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_86") == null ? "Select Insurance" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_86");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('ddlPkg').focus();
        return false;
    }
    if ((document.getElementById('rdClient').checked == true) && (document.getElementById('ddlClients').options[0].selected == true)) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_87") == null ? "Select Client" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_87");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('ddlClients').focus();
        return false;
    }
    if ((document.getElementById('rdClient').checked == true) && (document.getElementById('ddlClients').options[document.getElementById('ddlClients').selectedIndex].text == 'Collection Centre')) {
        if (document.getElementById('ddlCollectionCentre').value == '0') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_88") == null ? "Select Collection Centre" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_88");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddlCollectionCentre').focus();
            return false;
        }
    }
    if (document.getElementById('ddPublishingMode').value == '0' && document.getElementById('txtEmailID').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_89") == null ? "Select Publishing Mode" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_89");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('ddPublishingMode').focus();
        return false;
    }
    if (document.getElementById('txtEmailID').value.trim() != '') {
        if (echeck(document.getElementById('txtEmailID').value) == false) {
            document.getElementById('txtEmailID').value = "";
            document.getElementById('txtEmailID').focus();
            return false;
        }
    }
    if (document.getElementById('ddPublishingMode').value != '0') {
        if (document.getElementById('ddPublishingMode').value == '0' && document.getElementById('txtEmailID').value.trim() == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_89") == null ? "Select Publishing Mode" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_89");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddPublishingMode').focus();
            return false;
        }
        if (document.getElementById('txtName').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_90") == null ? "Provide Name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_90");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtName').focus();
            return false;
        }
        //        if (document.getElementById('shippingAddress_txtAddress2').value == '') 
        //        {
        //            alert('Please Enter Street/Road Name');
        //            document.getElementById('shippingAddress_txtAddress2').focus();
        //            return false;
        //        }
        if (document.getElementById('shippingAddress_txtCity').value.trim() == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_91") == null ? "Provide City" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_91");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('shippingAddress_txtCity').focus();
            return false;
        }
    }
    //return checkForCurrentDate('tDOB', 'Date Of Birth');
}

function SameAsAbove() {
    if (document.getElementById('chkSameAsAbove').checked) {
        document.getElementById('txtName').value = document.getElementById('txtPatientName').value;
        document.getElementById('shippingAddress_txtAddress1').value = document.getElementById('ucPAdd_txtAddress1').value;
        document.getElementById('shippingAddress_txtAddress2').value = document.getElementById('ucPAdd_txtAddress2').value;
        document.getElementById('shippingAddress_txtAddress3').value = document.getElementById('ucPAdd_txtAddress3').value;
        document.getElementById('shippingAddress_txtCity').value = document.getElementById('ucPAdd_txtCity').value;
        document.getElementById('shippingAddress_txtPostalCode').value = document.getElementById('ucPAdd_txtPostalCode').value;
        document.getElementById('shippingAddress_txtMobile').value = document.getElementById('ucPAdd_txtMobile').value;
        document.getElementById('shippingAddress_txtLandLine').value = document.getElementById('ucPAdd_txtLandLine').value;
        document.getElementById('shippingAddress_ddState').selectedIndex = (document.getElementById('ucPAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].value) - 1;
    }
    else {
        document.getElementById('txtName').value = "";
        document.getElementById('shippingAddress_txtAddress1').value = "";
        document.getElementById('shippingAddress_txtAddress2').value = "";
        document.getElementById('shippingAddress_txtAddress3').value = "";
        document.getElementById('shippingAddress_txtCity').value = "";
        document.getElementById('shippingAddress_txtPostalCode').value = "";
        document.getElementById('shippingAddress_txtMobile').value = "";
        document.getElementById('shippingAddress_txtLandLine').value = "";
        document.getElementById('shippingAddress_ddState').selectedIndex = 30;

    }
}

function SampleRegShowHide() {
    if (document.getElementById('ddPublishingMode').value < 1) {
        // document.getElementById('trEmailID').style.display = 'none';

        document.getElementById('trAddress').style.display = 'none';
    }
    /* else if (document.getElementById('ddPublishingMode').value == 1) {
    document.getElementById('trEmailID').style.display = 'block';
    document.getElementById('trAddress').style.display = 'none';
    document.getElementById('chkEmail').checked = true;
    }*/
    else {

        //document.getElementById('trEmailID').style.display = 'none';
        document.getElementById('trAddress').style.display = 'block';
    }
}
function SelectBillNo(rid, patid) {
    chosen = "";
    var len = document.forms[0].elements.length;
    for (var i = 0; i < len; i++) {
        if (document.forms[0].elements[i].type == "radio") {
            document.forms[0].elements[i].checked = false;
        }
    }
    document.getElementById(rid).checked = true;
    document.getElementById("bid").value = patid;
}

function SelectedBillNo(rid, patid, pid, vid, pName, pNumber, BillID, billStatus, BillNo, VisitType) {
    chosen = "";
    var len = document.forms[0].elements.length;
    for (var i = 0; i < len; i++) {
        if (document.forms[0].elements[i].type == "radio") {
            document.forms[0].elements[i].checked = false;
        }
    }
    document.getElementById(rid).checked = true;
    document.getElementById("bid").value = patid;
    document.getElementById("hdnBillStatus").value = billStatus;
    VisitDetails(vid, pid, pName, pNumber, BillID);
    VisitDetails(vid, pid, pName, pNumber, BillID, BillNo, VisitType);
}

function pBillValidation() {
    if (document.getElementById("bid").value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_92") == null ? "Select a bill" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_92");
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }

}
function checkFromDateToDateold(fromDate, toDate) {
    var today = GetServerDate();
    var stfromDate = document.getElementById(fromDate).value;
    var sttoDate = document.getElementById(toDate).value;
    var dd = stfromDate.substring(0, 2);
    var mm = stfromDate.substring(3, 5);
    var yy = stfromDate.substring(6, 10);
    var fromDate = GetServerDate();
    fromDate.setFullYear(yy, mm - 1, dd);
    dd = sttoDate.substring(0, 2);
    mm = sttoDate.substring(3, 5);
    yy = sttoDate.substring(6, 10);
    var toDate = GetServerDate();
    toDate.setFullYear(yy, mm - 1, dd);
    if (fromDate > today) {
        //alert("Please Check. From Date Greater than Current Date.");
        //return false;
    }
    if (toDate > today) {
        //alert("Please Check. To Date Greater than Current Date.");
        // return false;
    }

    if (toDate < fromDate) {
        //alert("Please Check. To Date is Less than From Date.");
        // return false;
    }


}

function checkForCurrentDate(dateFieldId, dateFieldText) {
    var currentDate = GetServerDate();
    if (document.getElementById(dateFieldId).value != '') {
        if (Date.parse(document.getElementById(dateFieldId).value) > Date.parse(currentDate.format($('#hdnDateFormat').val()))) {
            // alert("Please Check. " + dateFieldText + " is Greater than Current Date.");
            // return false;
        }
    }

}
function checkForFutureDate(dateFieldId, dateFieldText) {
    var currentDate = GetServerDate();
    if (document.getElementById(dateFieldId).value != '') {
        if (Date.parse(document.getElementById(dateFieldId).value) < Date.parse(currentDate.format($('#hdnDateFormat').val()))) {
            // alert("Please Check. " + dateFieldText + " is Less than Current Date.");
            // return false;
        }
    }

}



/* Sample Registration and Billing Validation ends */
/* Venkat InvControl Block*/
function showInv() {

    //document.cookie = "displayvalue=" + 1;

    if (document.getElementById('Investigation').style.display == 'none') {
        document.getElementById('Investigation').style.display = 'block';

        document.getElementById('visibleDiv').style.display = 'block';
        document.getElementById('invisibleDiv').style.display = 'none';

        document.getElementById('Profile').style.display = 'none';

        document.getElementById('pVisibleDiv').style.display = 'none';
        document.getElementById('pInvisibleDiv').style.display = 'block';


        document.getElementById('pkgVisibleDiv').style.display = 'none';
        document.getElementById('pkgINVisibleDiv').style.display = 'block';

        document.getElementById('package').style.display = 'none';
    }
    document.getElementById('Profile1_hidValue').value = 1;
}


function showProfile() {

    //document.cookie = "displayvalue=" + 2;
    if (document.getElementById('Profile').style.display == 'none') {
        document.getElementById('Investigation').style.display = 'none';
        document.getElementById('Profile').style.display = 'block';
        document.getElementById('pVisibleDiv').style.display = 'block';
        document.getElementById('pInvisibleDiv').style.display = 'none';
        document.getElementById('visibleDiv').style.display = 'none';
        document.getElementById('invisibleDiv').style.display = 'block';

        document.getElementById('pkgVisibleDiv').style.display = 'none';
        document.getElementById('pkgINVisibleDiv').style.display = 'block';
        document.getElementById('package').style.display = 'none';
    }
    document.getElementById('Profile1_hidValue').value = 2;
}

function showPackage() {
    //document.cookie = "displayvalue=" + 3;
    if (document.getElementById('package').style.display == 'none') {

        document.getElementById('Investigation').style.display = 'none';
        document.getElementById('package').style.display = 'block';
        document.getElementById('pVisibleDiv').style.display = 'none';
        document.getElementById('pInvisibleDiv').style.display = 'block';
        document.getElementById('visibleDiv').style.display = 'none';
        document.getElementById('invisibleDiv').style.display = 'block';

        document.getElementById('pkgVisibleDiv').style.display = 'block';
        document.getElementById('pkgINVisibleDiv').style.display = 'none';
        document.getElementById('Profile').style.display = 'none';

    }
    document.getElementById('Profile1_hidValue').value = 3;
}

function hideInvesDiv(ID) {
    if (document.getElementById(ID).style.display == 'block') {
        document.getElementById(ID).style.display = 'none';
        document.getElementById('plus' + ID).src = '../PlatForm/Images/plus.png';
    }
    else {
        document.getElementById(ID).style.display = 'block';
        document.getElementById('plus' + ID).src = '../PlatForm/Images/minus.png';
    }
}


/* ANC Prasanna */

function toggleDropDownDiv(cntrid, divid) {
    if (document.getElementById(cntrid).selectedIndex == '1') {
        document.getElementById(divid).style.display = 'block';
    } else {
        document.getElementById(divid).style.display = 'none';
    }
}

function addDaysToDateanc(frmId, toId) {
    if (document.getElementById(frmId).value != '') {
        addDt = document.getElementById(frmId).value.split('/');
        var d = new Date(addDt[2] + '/' + addDt[1] + '/' + addDt[0]);
        d.setDate(d.getDate() + 280);

        if ((d.getMonth() + 1) > 9) {
            var futureMon = d.getMonth() + 1;
        }
        else {
            var futureMon = '0' + (d.getMonth() + 1);
        }
        if (d.getDate() > 9) {
            var futureDt = d.getDate();
        }
        else {
            var futureDt = '0' + d.getDate();
        }
        var futureDate = futureDt + '/' + futureMon + '/' + d.getFullYear();
        document.getElementById(toId).value = futureDate;
    }
    else {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_93") == null ? "Provide the LMP date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_93");
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
        //document.getElementById(frmId).value = '__/__/____';
        document.getElementById(frmId).focus();
        return false;
    }
}

/* General Advice */

function GenAdvicevalidation() {
    if (document.getElementById('uGAdv_tTreatmentAdvice').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_94") == null ? "Provide the Advice" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_94");
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('uGAdv_tTreatmentAdvice').focus();
        return false;
    }
    var gAdv = document.getElementById('uGAdv_tTreatmentAdvice').value;
    document.getElementById('uGAdv_tTreatmentAdvice').value = '';
    document.getElementById('uGAdv_tTreatmentAdvice').focus();
    var retvalue = gAdv;
    return retvalue;
}

/* Nutrition Advice */

function NAdvicevalidation() {
    if (document.getElementById('uNAdv_tNTreatmentAdvice').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_94") == null ? "Provide the Advice" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_94");
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('uNAdv_tNTreatmentAdvice').focus();
        return false;
    }
    var gAdv = document.getElementById('uNAdv_tNTreatmentAdvice').value;
    document.getElementById('uNAdv_tNTreatmentAdvice').value = '';
    document.getElementById('uNAdv_tNTreatmentAdvice').focus();
    var retvalue = gAdv;
    return retvalue;
}

/* Patient Investigation Sample Collection Results */

function invSampleValidation() {
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (document.getElementById('ucSC_ddlSamples').value == '0') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_95") == null ? "Select Sample" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_95");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('ucSC_ddlSamples').focus();
        return false;
    }
    if (document.getElementById('ucSC_ddlAttributes').value == '0') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_96") == null ? "Select sample attributes" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_96");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('ucSC_ddlAttributes').focus();
        return false;
    }
    if ((document.getElementById('ucSC_txtValues').value == '') && (document.getElementById('ucSC_txtDescription').value == '')) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_97") == null ? "Provide the sample values or comments" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_97");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('ucSC_txtValues').focus();
        return false;
    }

    var samCode = document.getElementById('ucSC_ddlSamples').value;
    var samName = document.getElementById('ucSC_ddlSamples').options[document.getElementById('ucSC_ddlSamples').selectedIndex].innerHTML;
    var samAttCode = document.getElementById('ucSC_ddlAttributes').value;
    var samAtt = document.getElementById('ucSC_ddlAttributes').options[document.getElementById('ucSC_ddlAttributes').selectedIndex].innerHTML;
    var samValue = document.getElementById('ucSC_txtValues').value;
    var samDesc = document.getElementById('ucSC_txtDescription').value;
    var retSample = samCode + "~" + samName + "~" + samAttCode + "~" + samAtt + "~" + samValue + "~" + samDesc;

    document.getElementById('ucSC_ddlSamples').value = '0';
    document.getElementById('ucSC_ddlAttributes').value = '0'
    document.getElementById('ucSC_txtValues').value = ''
    document.getElementById('ucSC_txtDescription').value = ''

    return retSample;
}

function checkMobileNumber() {    //Mani
    var mobileNoLength = $("[id$=hdnPhLength]").val();
    var AllowLesserDigit = $("[id$=hdnAllowLesserDigitMobileYN]").val();
    //var mobileMaxLength = $("[id$=AllowLesserDigitMobileYN]").val();
    if (mobileNoLength == "" || mobileNoLength == null || mobileNoLength == undefined) {
        if ($("[id$=hdnConfigvalue]").val()== "Y") {
            mobileNoLength = 9;
        }
        else if ((mobileMaxLength == "" || mobileMaxLength == null || mobileMaxLength == undefined) && $("[id$=hdnConfigvalue]").val() == "N"){
        mobileNoLength = hdnPhLength;
        }
        else {
            mobileNoLength = 10;
        }
    }
    //sathish--for validating manufacturer ph.no.in products screen
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (!(($('#AddManufacturer1_txtAddMfgPhone').val() == "") || ($('#AddManufacturer1_txtAddMfgPhone').val() == undefined))) {
        var cmn = $('#AddManufacturer1_txtAddMfgPhone').val();
        if ($('#AddManufacturer1_txtAddMfgPhone').val() != '') {
            if (cmn.length != mobileNoLength) {
                var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
                var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_98") == null ? "Enter {0} valid Mobile No" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_98");
                userMsg = userMsg.replace("{0}", mobileNoLength);
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('AddManufacturer1_txtAddMfgPhone').value = '';
                document.getElementById('AddManufacturer1_txtAddMfgPhone').focus();
                return false;
            }
        }
    }
    if (!(($('#ucPAdd_txtMobile').val() == "") || ($('#ucPAdd_txtMobile').val() == undefined))) {
        if ($('#ucPAdd_hdnsme').val() != "Y") {
            var cmn = $('#ucPAdd_txtMobile').val();
            if ($('#ucPAdd_txtMobile').val() != '') {
                if (cmn.length != mobileNoLength) {
                    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
                    var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_98") == null ? "Enter " +mobileNoLength+ " Digits valid Mobile No" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_98");
                    userMsg = userMsg.replace("{0}", mobileNoLength);
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('ucPAdd_txtMobile').value = '';
                    document.getElementById('ucPAdd_txtMobile').focus();
                    return false;
                }
            }
        }
        else {
            var cmn = $('#ucPAdd_txtMobile').val();
            if ($('#ucPAdd_txtMobile').val() != '') {
          
                if (cmn.length != mobileNoLength && AllowLesserDigit!="Y") {
                    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
                    var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_98") == null ? "Enter " +mobileNoLength+" Digits valid Mobile No" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_98");
                    userMsg = userMsg.replace("{0}", mobileNoLength);
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('ucPAdd_txtMobile').value = '';
                    document.getElementById('ucPAdd_txtMobile').focus();
                    return false;
                }
            }
        }
    }

    if (!(($('#QPR_ucPAdd_txtMobile').val() == "") || ($('#QPR_ucPAdd_txtMobile').val() == undefined))) {
        if ($('#ucPAdd_hdnsme').val() != "Y") {
            var cmn = $('#QPR_ucPAdd_txtMobile').val();
            if ($('#QPR_ucPAdd_txtMobile').val() != '') {
                if (cmn.length != mobileNoLength) {
                    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
                    var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_98") == null ? "Enter {0} Digits valid Mobile No" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_98");
                    userMsg = userMsg.replace("{0}", mobileNoLength);
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('ucPAdd_txtMobile').value = '';
                    document.getElementById('ucPAdd_txtMobile').focus();
                    return false;
                }
            }
        }
        else {
            var cmn = $('#QPR_ucPAdd_txtMobile').val();
            if ($('#QPR_ucPAdd_txtMobile').val() != '') {

                if (cmn.length != mobileNoLength && AllowLesserDigit != "Y") {
                    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
                    var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_98") == null ? "Enter {0} Digits valid Mobile No" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_98");
                    userMsg = userMsg.replace("{0}", mobileNoLength);
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('ucPAdd_txtMobile').value = '';
                    document.getElementById('ucPAdd_txtMobile').focus();
                    return false;
                }
            }
        }
    }
    
    if (!(($('#ucCAdd_txtMobile').val() == "") || ($('#ucCAdd_txtMobile').val() == undefined))) {

        if ($('#ucCAdd_hdnsme').val() != "") {
            var cmn = document.getElementById('ucCAdd_txtMobile').value;
            if (document.getElementById('ucCAdd_txtMobile').value != '') {
                if (cmn.length != mobileNoLength) {
                    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
                    var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_98") == null ? "Enter {0} Digits valid Mobile No" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_98");
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('ucCAdd_txtMobile').value = '';
                    document.getElementById('ucCAdd_txtMobile').focus();
                    return false;
                }
            }
        }
    }
   
}

function checkLandLineNumber() {

    if ($('[id$=ucPAdd_txtLandLine]').length > 0) {
        var clln = $('[id$=ucPAdd_txtLandLine]')[0].value;

        if ($('[id$=ucPAdd_txtLandLine]')[0].value != '') {
            if (clln.length < 6) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_100") == null ? "Provide the correct land line number" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_100");
                var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
                $('[id$=ucPAdd_txtLandLine]')[0].value = '';
                $('[id$=ucPAdd_txtLandLine]')[0].focus();
            }
            else {

            }
        }
        else {

        }
    }

}

function funcChkProcedures(txtUnitPrice, txtQuantity, txtAmount, hdnTotalAmount,
                            hdnOldPrice, hdnOldQuantity, txtGross, txtDiscount,
                            txtRecievedAdvance, txtGrandTotal, hdnGross,
                            txtindDiscount, hdnDiscountArray, hdnNonMedicalItem,
                            lblNonReimbuse, nonReimburseChkBoxID, flag) {

    var Quantity = document.getElementById(txtQuantity);
    var UnitPrice = document.getElementById(txtUnitPrice);
    var Amount = document.getElementById(txtAmount);
    var hdnAmount = document.getElementById(hdnTotalAmount);

    var OldPrice = document.getElementById(hdnOldPrice);
    var OldQuantity = document.getElementById(hdnOldQuantity);

    //var oldAmt = Number(OldPrice.value) * Number(OldQuantity.value);

    var oldAmt = Number(ToInternalFormat($('#' + OldPrice.id))) * Number(ToInternalFormat($('#' + OldQuantity.id)));

    var Gross = document.getElementById(txtGross);
    var Discount = document.getElementById(txtDiscount);
    var RecievedAdvance = document.getElementById(txtRecievedAdvance);
    var GrandTotal = document.getElementById(txtGrandTotal);

    //    var OldPricetoDelete = chkIsnumber(OldPrice.value);
    //    var OldQuantitytoDelete = chkIsnumber(OldQuantity.value);

    var OldPricetoDelete = chkIsnumber(ToInternalFormat($('#' + OldPrice.id)));
    var OldQuantitytoDelete = chkIsnumber(ToInternalFormat($('#' + OldQuantity.id)));

    var hdnGrossBillAmount = document.getElementById(hdnGross);
    var OldAmounttoDelete = format_number((Number(OldPricetoDelete) * Number(OldQuantitytoDelete)), 2);



    var IndividualDiscount = document.getElementById(txtindDiscount);
    if (IndividualDiscount == "" || IndividualDiscount == null) {
        IndividualDiscount = 0;
    }

    //var OldAmounttoDelete = 0;
    //format_number(Number(UnitPrice.value), 2);

    //    Quantity.value = chkIsnumber(Quantity.value);
    //    UnitPrice.value = chkIsnumber(UnitPrice.value);
    Quantity.value = chkIsnumber(ToInternalFormat($('#' + Quantity.id)));
    UnitPrice.value = chkIsnumber(ToInternalFormat($('#' + UnitPrice.id)));
    ToTargetFormat($('#' + Quantity.id));
    ToTargetFormat($('#' + UnitPrice.id));

    //    UnitPrice.value = format_number(Number(UnitPrice.value), 2);
    //    Amount.value = format_number((Number(Quantity.value) * Number(UnitPrice.value)), 2);

    UnitPrice.value = format_number(Number(ToInternalFormat($('#' + UnitPrice.id))), 2);
    ToTargetFormat($('#' + UnitPrice.id));
    Amount.value = format_number((Number(ToInternalFormat($('#' + Quantity.id))) * Number(ToInternalFormat($('#' + UnitPrice.id)))), 2);
    ToTargetFormat($('#' + Amount.id));
    // hdnAmount.value = Amount.value;
    hdnAmount.value = ToInternalFormat($('#' + Amount.id));
    ToTargetFormat($('#' + hdnAmount.id));
    // var newAmt = Amount.value;

    var newAmt = ToInternalFormat($('#' + Amount.id));
    //   Gross.value = format_number((Number(Gross.value) + Number(Amount.value) - Number(OldAmounttoDelete)), 2);
    //  hdnGrossBillAmount.value = Gross.value;

    Gross.value = format_number((Number(ToInternalFormat($('#' + Gross.id))) + Number(ToInternalFormat($('#' + Amount.id))) - Number(OldAmounttoDelete)), 2);
    ToTargetFormat($('#' + Gross.id));

    hdnGrossBillAmount.value = Gross.value;
    ToTargetFormat($('#' + hdnGrossBillAmount.id));

    //    if (Number(Amount.value) < Number(chkIsnumber(IndividualDiscount.value))) {
    //        alert('Discount cannot be greater than amount');
    //        IndividualDiscount.value = 0.00; // Amount.value;
    //    }


    if (Number(ToInternalFormat($('#' + Amount.id))) < Number(chkIsnumber(ToInternalFormat($('#' + IndividualDiscount.id))))) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_101") == null ? "Discount cannot be greater than amount" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_101");
 var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
        IndividualDiscount.value = 0.00; // Amount.value;
        ToTargetFormat($('#' + IndividualDiscount.id));
    }

    var DiscountCntrls = new Array();
    var tempCtrl;
    if (hdnDiscountArray == null || hdnDiscountArray == "" || hdnDiscountArray == undefined) {
        tempCtrl = "";
    }
    else {
        tempCtrl = document.getElementById(hdnDiscountArray).value;
    }
    DiscountCntrls = tempCtrl.split('|');
    var iCnt = 0;
    var DiscountAmount = 0;
    for (iCnt = 0; iCnt < DiscountCntrls.length; iCnt++) {
        if (DiscountCntrls[iCnt] != '') {
            //DiscountAmount = Number(chkIsnumber(document.getElementById(DiscountCntrls[iCnt]).value)) + Number(DiscountAmount);
            DiscountAmount = Number(chkIsnumber(ToInternalFormat($('#' + DiscountCntrls[iCnt].id)))) + Number(DiscountAmount);
        }
    }
    // if (Number(DiscountAmount) != 0) {
    Discount.value = DiscountAmount;
    // }

    ToTargetFormat($('#' + Discount.id));
    OldPrice.value = UnitPrice.value;
    OldQuantity.value = Quantity.value;

    ToTargetFormat($('#' + OldPrice.id));
    ToTargetFormat($('#' + OldQuantity.id));

    totalCalculate();
    ValidateDiscountReason();
    //    if (document.getElementById('chkisCreditTransaction').checked == true) {
    if (flag != "ROOM") {
        var gridChkBox = document.getElementById(nonReimburseChkBoxID);
        var hdnNonMedical = document.getElementById(hdnNonMedicalItem);
        var lblNonReimbuse = document.getElementById(lblNonReimbuse);
        if (gridChkBox != undefined) {
            if (gridChkBox.checked) {
                //nothing
            }
            else {
                // lblNonReimbuse.innerHTML = hdnNonMedical.value = parseFloat(parseFloat(hdnNonMedical.value) + (newAmt - oldAmt)).toFixed(2);
                lblNonReimbuse.innerHTML = hdnNonMedical.value = parseFloat(parseFloat(ToInternalFormat($('#' + hdnNonMedical))) + (newAmt - oldAmt)).toFixed(2);
                ToTargetFormat($('#' + lblNonReimbuse.id));
                ToTargetFormat($('#' + hdnNonMedical.id));

            }
            doCalcReimburse();
        }
    }
    //    }

}


function chkIsnumber(pnumber) {
    if (isNaN(pnumber)) {
        return 0;
    }
    else {
        return pnumber;
    }
}

/* for IP Left Menu */
function showIP() {

    if (document.getElementById('hideIPdiv').style.display == 'none') {
        document.getElementById('hideIPdiv').style.display = 'block';
        document.getElementById('hideIPdiv').style.display == 'block'

        if (document.getElementById('hidediv')) {
            if (document.getElementById('hidediv').style.display == 'block') {
                document.getElementById('hidediv').style.display = 'none';
                document.getElementById('hidediv').style.display == 'none'
            }
        }
        //        if (document.getElementById('hideOPdiv')) {
        //            if (document.getElementById('hideOPdiv').style.display == 'block') {
        //                document.getElementById('hideOPdiv').style.display = 'none';
        //                document.getElementById('hideOPdiv').style.display == 'none'
        //            }
        //        }
        if (document.getElementById('hidedivRates')) {
            if (document.getElementById('hidedivRates').style.display == 'block') {
                document.getElementById('hidedivRates').style.display = 'none';
                document.getElementById('hidedivRates').style.display == 'none'
            }
        }
        if (document.getElementById('hideInventorydiv')) {
            if (document.getElementById('hideInventorydiv').style.display == 'block') {
                document.getElementById('hideInventorydiv').style.display = 'none';
                document.getElementById('hideInventorydiv').style.display == 'none'
            }
        }
        if (document.getElementById('hideReferraldiv')) {
            if (document.getElementById('hideReferraldiv').style.display == 'block') {
                document.getElementById('hideReferraldiv').style.display = 'none';
                document.getElementById('hideReferraldiv').style.display == 'none'
            }
        }
        if (document.getElementById('hideManageSchedules')) {
            if (document.getElementById('hideManageSchedules').style.display == 'block') {
                document.getElementById('hideManageSchedules').style.display = 'none';
                document.getElementById('hideManageSchedules').style.display == 'none'
            }
        }
    }
    else {
        document.getElementById('hideIPdiv').style.display = 'none';
        document.getElementById('hideIPdiv').style.display == 'none'
    }
}

/* for OP Left Menu */
function showOP() {

    if (document.getElementById('hideOPdiv').style.display == 'none') {
        document.getElementById('hideOPdiv').style.display = 'block';
        document.getElementById('hideOPdiv').style.display == 'block'
        if (document.getElementById('hidediv')) {
            if (document.getElementById('hidediv').style.display == 'block') {
                document.getElementById('hidediv').style.display = 'none';
                document.getElementById('hidediv').style.display == 'none'
            }
        }
        if (document.getElementById('hidedivRates')) {
            if (document.getElementById('hidedivRates').style.display == 'block') {
                document.getElementById('hidedivRates').style.display = 'none';
                document.getElementById('hidedivRates').style.display == 'none'
            }
        }
        if (document.getElementById('hideIPdiv')) {
            if (document.getElementById('hideIPdiv').style.display == 'block') {
                document.getElementById('hideIPdiv').style.display = 'none';
                document.getElementById('hideIPdiv').style.display == 'none'
            }
        }
        if (document.getElementById('hideInventorydiv')) {
            if (document.getElementById('hideInventorydiv').style.display == 'block') {
                document.getElementById('hideInventorydiv').style.display = 'none';
                document.getElementById('hideInventorydiv').style.display == 'none'
            }
        }
        if (document.getElementById('hideReferraldiv')) {
            if (document.getElementById('hideReferraldiv').style.display == 'block') {
                document.getElementById('hideReferraldiv').style.display = 'none';
                document.getElementById('hideReferraldiv').style.display == 'none'
            }
        }
        if (document.getElementById('hideManageSchedules')) {
            if (document.getElementById('hideManageSchedules').style.display == 'block') {
                document.getElementById('hideManageSchedules').style.display = 'none';
                document.getElementById('hideManageSchedules').style.display == 'none'
            }
        }
    }
    //    else {
    //        document.getElementById('hideOPdiv').style.display = 'none';
    //        document.getElementById('hideOPdiv').style.display == 'none'
    //    }
}

/* for IP Left Update RatesMenu */
function showUpdateRates() {

    if (document.getElementById('hidedivRates').style.display == 'none') {
        document.getElementById('hidedivRates').style.display = 'block';
        document.getElementById('hidedivRates').style.display == 'block'
        if (document.getElementById('hidediv')) {
            if (document.getElementById('hidediv').style.display == 'block') {
                document.getElementById('hidediv').style.display = 'none';
                document.getElementById('hidediv').style.display == 'none'
            }
        }
        //        if (document.getElementById('hideOPdiv')) {
        //            if (document.getElementById('hideOPdiv').style.display == 'block') {
        //                document.getElementById('hideOPdiv').style.display = 'none';
        //                document.getElementById('hideOPdiv').style.display == 'none'
        //            }
        //        }
        if (document.getElementById('hideIPdiv')) {
            if (document.getElementById('hideIPdiv').style.display == 'block') {
                document.getElementById('hideIPdiv').style.display = 'none';
                document.getElementById('hideIPdiv').style.display == 'none'
            }
        }
        if (document.getElementById('hideInventorydiv')) {
            if (document.getElementById('hideInventorydiv').style.display == 'block') {
                document.getElementById('hideInventorydiv').style.display = 'none';
                document.getElementById('hideInventorydiv').style.display == 'none'
            }
        }
        if (document.getElementById('hideReferraldiv')) {
            if (document.getElementById('hideReferraldiv').style.display == 'block') {
                document.getElementById('hideReferraldiv').style.display = 'none';
                document.getElementById('hideReferraldiv').style.display == 'none'
            }
        }
        if (document.getElementById('hideManageSchedules')) {
            if (document.getElementById('hideManageSchedules').style.display == 'block') {
                document.getElementById('hideManageSchedules').style.display = 'none';
                document.getElementById('hideManageSchedules').style.display == 'none'
            }
        }
    }
    else {
        document.getElementById('hidedivRates').style.display = 'none';
        document.getElementById('hidedivRates').style.display == 'none'
    }
}

/* for ANC Complaints */
function getAssociatedDiseasesANC() {
    var len = document.forms[0].elements.length;
    var complaint = document.getElementById('hdComplaint');

    complaint.value = '';
    var cIdSub;
    for (var i = 0; i < len; i++) {
        if (document.forms[0].elements[i].type == "checkbox") {
            if (document.forms[0].elements[i].checked) {
                var cId = document.forms[0].elements[i];
                if (cId.id.substring(0, 3) == 'tCA') {
                    cIdSub = cId.id.substring(3, cId.id.length);
                    complaint.value = complaint.value + cIdSub + '~' + document.getElementById('tA' + cIdSub).value + '^';
                }
            }
        }
    }
}

/* for Inventory Left Menu */
function showInventory() {
    if (document.getElementById('hideInventorydiv').style.display == 'none') {
        document.getElementById('hideInventorydiv').style.display = 'block';
        document.getElementById('hideInventorydiv').style.display == 'block'
        if (document.getElementById('hidediv')) {
            if (document.getElementById('hidediv').style.display == 'block') {
                document.getElementById('hidediv').style.display = 'none';
                document.getElementById('hidediv').style.display == 'none'
            }
        }
        //        if (document.getElementById('hideOPdiv')) {
        //            if (document.getElementById('hideOPdiv').style.display == 'block') {
        //                document.getElementById('hideOPdiv').style.display = 'none';
        //                document.getElementById('hideOPdiv').style.display == 'none'
        //            }
        //        }
        if (document.getElementById('hideIPdiv')) {
            if (document.getElementById('hideIPdiv').style.display == 'block') {
                document.getElementById('hideIPdiv').style.display = 'none';
                document.getElementById('hideIPdiv').style.display == 'none'
            }
        }
        if (document.getElementById('hidedivRates')) {
            if (document.getElementById('hidedivRates').style.display == 'block') {
                document.getElementById('hidedivRates').style.display = 'none';
                document.getElementById('hidedivRates').style.display == 'none'
            }
        }
        if (document.getElementById('hideManageSchedules')) {
            if (document.getElementById('hideManageSchedules').style.display == 'block') {
                document.getElementById('hideManageSchedules').style.display = 'none';
                document.getElementById('hideManageSchedules').style.display == 'none'
            }
        }
    }
    else {
        document.getElementById('hideInventorydiv').style.display = 'none';
        document.getElementById('hideInventorydiv').style.display == 'none'
    }
}


/* for Referral Left Menu */
function showReferral() {
    if (document.getElementById('hideReferraldiv').style.display == 'none') {
        document.getElementById('hideReferraldiv').style.display = 'block';
        document.getElementById('hideReferraldiv').style.display == 'block'
        if (document.getElementById('hidediv')) {
            if (document.getElementById('hidediv').style.display == 'block') {
                document.getElementById('hidediv').style.display = 'none';
                document.getElementById('hidediv').style.display == 'none'
            }
        }
        //        if (document.getElementById('hideOPdiv')) {
        //            if (document.getElementById('hideOPdiv').style.display == 'block') {
        //                document.getElementById('hideOPdiv').style.display = 'none';
        //                document.getElementById('hideOPdiv').style.display == 'none'
        //            }
        //        }
        if (document.getElementById('hideIPdiv')) {
            if (document.getElementById('hideIPdiv').style.display == 'block') {
                document.getElementById('hideIPdiv').style.display = 'none';
                document.getElementById('hideIPdiv').style.display == 'none'
            }
        }
        if (document.getElementById('hidedivRates')) {
            if (document.getElementById('hidedivRates').style.display == 'block') {
                document.getElementById('hidedivRates').style.display = 'none';
                document.getElementById('hidedivRates').style.display == 'none'
            }
        }
        if (document.getElementById('hideManageSchedules')) {
            if (document.getElementById('hideManageSchedules').style.display == 'block') {
                document.getElementById('hideManageSchedules').style.display = 'none';
                document.getElementById('hideManageSchedules').style.display == 'none'
            }
        }
    }
    else {
        document.getElementById('hideReferraldiv').style.display = 'none';
        document.getElementById('hideReferraldiv').style.display == 'none'
    }
}

function showMenuMaster() {
    if (document.getElementById('hideManageSchedules').style.display == 'none') {
        document.getElementById('hideManageSchedules').style.display = 'block';
        document.getElementById('hideManageSchedules').style.display == 'block'
        if (document.getElementById('hidediv')) {
            if (document.getElementById('hidediv').style.display == 'block') {
                document.getElementById('hidediv').style.display = 'none';
                document.getElementById('hidediv').style.display == 'none'
            }
        }
        //        if (document.getElementById('hideOPdiv')) {
        //            if (document.getElementById('hideOPdiv').style.display == 'block') {
        //                document.getElementById('hideOPdiv').style.display = 'none';
        //                document.getElementById('hideOPdiv').style.display == 'none'
        //            }
        //        }
        if (document.getElementById('hideIPdiv')) {
            if (document.getElementById('hideIPdiv').style.display == 'block') {
                document.getElementById('hideIPdiv').style.display = 'none';
                document.getElementById('hideIPdiv').style.display == 'none'
            }
        }
        if (document.getElementById('hidedivRates')) {
            if (document.getElementById('hidedivRates').style.display == 'block') {
                document.getElementById('hidedivRates').style.display = 'none';
                document.getElementById('hidedivRates').style.display == 'none'
            }
        }
        if (document.getElementById('hideInventorydiv')) {
            if (document.getElementById('hideInventorydiv').style.display == 'block') {
                document.getElementById('hideInventorydiv').style.display = 'none';
                document.getElementById('hideInventorydiv').style.display == 'none'
            }
        }
        if (document.getElementById('hideReferraldiv')) {
            if (document.getElementById('hideReferraldiv').style.display == 'block') {
                document.getElementById('hideReferraldiv').style.display = 'none';
                document.getElementById('hideReferraldiv').style.display == 'none'
            }
        }
    }
    else {
        document.getElementById('hideInventorydiv').style.display = 'none';
        document.getElementById('hideInventorydiv').style.display == 'none'
    }
}

function BasketValidation() {
    if (document.getElementById('inventoryBasket_txtQuantity').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_102") == null ? "Provide the quantity" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_102");
 var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('inventoryBasket_txtQuantity').focus();
        return false;
    }
    //    if (document.getElementById('uAd_tFrm').value == '') {
    //        alert('Enter the Formulation');
    //        document.getElementById('uAd_tFrm').focus();
    //        return false;
    //    }

    //    if (document.getElementById('uAd_tFRQ').value == '') {
    //        alert('Enter the Frequency');
    //        document.getElementById('uAd_tFRQ').focus();
    //        return false;
    //    }


    var CatId = document.getElementById('inventoryBasket_ddlCategory').value;
    var CatPrdID = document.getElementById('inventoryBasket_ddlProducts').value;
    var Quantity = document.getElementById('inventoryBasket_txtQuantity').value;
    var CatName = document.getElementById('inventoryBasket_ddlCategory').options[document.getElementById('inventoryBasket_ddlCategory').selectedIndex].innerHTML;
    var CatProducts = document.getElementById('inventoryBasket_ddlProducts').options[document.getElementById('inventoryBasket_ddlProducts').selectedIndex].innerHTML;
    //    alert("Cat Name = " + CatName);
    //    alert("CatID = " + CatId);
    //    alert("ProductID = " + CatPrdID);
    //    alert("Product Name = " + CatProducts);
    //    alert("Quantity = " + Quantity);

    var retval = CatId + "~" + CatPrdID + "~" + CatName + "~" + CatProducts + "~" + Quantity;
    //alert(retval);
    return retval;
}

function getAssociatedDiseasesANC() {
    //alert('h');
    var len = document.forms[0].elements.length;
    var complaint = document.getElementById('hdComplaint');
    complaint.value = '';
    //alert(complaint);
    var cIdSub;
    for (var i = 0; i < len; i++) {
        if (document.forms[0].elements[i].type == "checkbox") {

            if (document.forms[0].elements[i].checked) {

                var cId = document.forms[0].elements[i];
                if (cId.id.substring(0, 3) == 'tCA') {

                    cIdSub = cId.id.substring(3, cId.id.length);
                    complaint.value = complaint.value + cIdSub + '~' + document.getElementById('tA' + cIdSub).value + '^';
                    //alert(complaint.value);
                }
            }
        }
    }
}

function formatTime(ipTime) {
    var ipSplit = ipTime.split(':');

    hour = ipSplit[0];
    min = ipSplit[1];
    sec = ipSplit[2];

    if (min <= 9) {
        min = "" + min;
    }
    if (sec <= 9) {
        sec = "0" + sec;
    }
    if (hour > 12) {
        hour = hour - 12;
        add = " p.m.";
    } else {
        hour = hour;
        add = " a.m.";
    }
    if (hour == 12) {
        add = " p.m.";
    }
    if (hour == 00) {
        hour = "12";
    }

    return ((hour <= 9) ? "0" + hour : hour) + ":" + min + add;
}

//function funmouseover(id)
//{
//    id.className = 'btn btnhov';
//}

//function funmouseout(id)
//{
//    id.className = 'btn';
//class='btn' onmouseover='funmouseover(this.id);' onmouseout='funmouseout(this.id);'
//}

function closeApplication() {
    //alert('1');
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
                    var informMsg = SListForAppMsg.Get("PlatForm_Information") == null ? "Information" : SListForAppMsg.Get("PlatForm_Information");
                    var okMsg = SListForAppMsg.Get("PlatForm_Ok") == null ? "Ok" : SListForAppMsg.Get("PlatForm_Ok")
                    var cancelMsg = SListForAppMsg.Get("PlatForm_Cancel") == null ? "Cancel" : SListForAppMsg.Get("PlatForm_Cancel");
                     var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_129") == null ? "Are you sure You want to LogOut Now. Continue?" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_129");
    if (ConfirmWindow(userMsg,informMsg,okMsg,cancelMsg)) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_103") == null ? "Confirm" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_103");
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
        window.location = "http://www.google.com/";

    }
    else {
        return false;
    }
}



function SelectRdoValues(rid, sdid) {
    chosen = "";

    var len = document.forms[0].elements.length;
    for (var i = 0; i < len; i++) {
        if (document.forms[0].elements[i].type == "radio") {
            document.forms[0].elements[i].checked = false;
        }
    }
    document.getElementById(rid).checked = true;
    document.getElementById("Did").value = sdid;
    document.getElementById("rid").value = rid;
}



//function checkItemsAdded() {
//    if (document.getElementById('InvestigationControl1_iconHid').value == "") {
//        alert("Please Select Investigation");
//        document.getElementById('InvestigationControl1_listINV').focus();
//        document.getElementById('InvestigationControl1_listINV').selectedIndex = 0;
//        return false;
//    }
//    else {
//        return true;
//    }
//}

function checkBillForTotal(id) {


    var result;
    document.getElementById(id).style.display = "none";
    if (!document.getElementById('BillPrintCtrl_chkUseCredit').checked) {
        if (document.getElementById('BillPrintCtrl_txtAmountReceived').value == 0) {
        var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
                    var informMsg = SListForAppMsg.Get("PlatForm_Information") == null ? "Information" : SListForAppMsg.Get("PlatForm_Information");
                    var okMsg = SListForAppMsg.Get("PlatForm_Ok") == null ? "Ok" : SListForAppMsg.Get("PlatForm_Ok")
                    var cancelMsg = SListForAppMsg.Get("PlatForm_Cancel") == null ? "Cancel" : SListForAppMsg.Get("PlatForm_Cancel");
                     var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_130") == null ? "Amount Received is Zero. Do you want to continue?" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_130");
            result = ConfirmWindow(userMsg,informMsg,okMsg,cancelMsg);
            if (result == false) {
                document.getElementById(id).style.display = "block";
                return false;
            }
            else {
                return true;
            }
        }
        else {
            return true;
        }
    }
    else {
        return true;
    }
}

function expand_me(mycontrol) {
    mycontrol.style.width = "250";
}
function shrink_me(mycontrol) {
    mycontrol.style.width = "50";
}

//function setCompletedStatus(id) {
//    var x = id.split("_");
//    if (document.getElementById(id).value.trim() != "") {
//        var len = document.getElementById(x[0] + "_ddlstatus").options.length;
//        var drpdwn = document.getElementById(x[0] + "_ddlstatus");
//         
//        var txtValue = document.getElementById(x[0] + "_txtValue");
//        var txtValuLen = txtValue.value.length;
//        var isCompletedExists = 'false';
//        var CompletedValue = 0;
//        var PendingValue = 0;
//        for (var i = 0; i < len; i++) {
//            if (drpdwn.options[i].text == 'Completed') {
//                isCompletedExists = 'true';
//                CompletedValue = drpdwn.options[i].value;
//            }
//            if (drpdwn.options[i].text == 'Pending') {
//                
//                PendingValue = drpdwn.options[i].value;
//            }
//        }
//        if (len > 0 && isCompletedExists == 'true' && txtValuLen > 0) {

//            document.getElementById(x[0] + "_ddlstatus").value = CompletedValue;
//            return true;
//        } else {
//            document.getElementById(x[0] + "_ddlstatus").value = PendingValue;
//            return true;
//        }
//    }
//  return false;
//}
function setCompletedStatus(GrpName, id) {
    try {
        var x = id.split("_");
        var type = document.getElementById(id).type;
        var resultValue = "";
        if (type.indexOf("select") >= 0) {
            var ddl = document.getElementById(id);
            if (ddl.selectedIndex > 0) {
                resultValue = ddl.options[ddl.selectedIndex].text;
            }
        }
        else {
            resultValue = document.getElementById(id).value;
        }
        if (resultValue.trim() != "") {
            var len = document.getElementById(x[0] + "_ddlstatus").options.length;
            var drpdwn = document.getElementById(x[0] + "_ddlstatus");
            if (x[1] == "txtValue") {
                var txtValue = document.getElementById(x[0] + "_txtValue");
                var txtValuLen = txtValue.value.length;

                var isCompletedExists = 'false';
                var CompletedValue = 0;
                var PendingValue = 0;
                for (var i = 0; i < len; i++) {
                    if (drpdwn.options[i].value.split('_')[0] == 'Completed') {
                        isCompletedExists = 'true';
                        CompletedValue = drpdwn.options[i].value;
                    }
                    if (drpdwn.options[i].value.split('_')[0] == 'Pending') {

                        PendingValue = drpdwn.options[i].value;
                    }
                    if (drpdwn.options[i].value.split('_')[0] == 'Approve') {

                        PendingValue = drpdwn.options[i].value;
                    }
                }
                if (len > 0 && isCompletedExists == 'true' && txtValuLen > 0) {

                    document.getElementById(x[0] + "_ddlstatus").value = CompletedValue;
                } else {
                    document.getElementById(x[0] + "_ddlstatus").value = PendingValue;
                }
            }
            else {
                var isCompletedExists = 'false';
                var CompletedValue = 0;
                var PendingValue = 0;
                for (var i = 0; i < len; i++) {
                    if (drpdwn.options[i].value.split('_')[0] == 'Completed') {
                        isCompletedExists = 'true';
                        CompletedValue = drpdwn.options[i].value;
                    }
                    if (drpdwn.options[i].value.split('_')[0] == 'Pending') {

                        PendingValue = drpdwn.options[i].value;
                    }
                    if (drpdwn.options[i].value.split('_')[0] == 'Approve') {

                        PendingValue = drpdwn.options[i].value;
                    }
                }
                if (len > 0 && isCompletedExists == 'true') {

                    document.getElementById(x[0] + "_ddlstatus").value = CompletedValue;
                } else {
                    document.getElementById(x[0] + "_ddlstatus").value = PendingValue;
                }

            }
        }
        else {
            var PendingValue = 0;
            var len = document.getElementById(x[0] + "_ddlstatus").options.length;
            var drpdwn = document.getElementById(x[0] + "_ddlstatus");
            for (var i = 0; i < len; i++) {
                if (drpdwn.options[i].value.split('_')[0] == 'Completed') {
                    isCompletedExists = 'true';
                    CompletedValue = drpdwn.options[i].value;
                }
                if (drpdwn.options[i].value.split('_')[0] == 'Pending') {

                    PendingValue = drpdwn.options[i].value;
                }
                if (drpdwn.options[i].value.split('_')[0] == 'Approve') {

                    PendingValue = drpdwn.options[i].value;
                }
            }
            document.getElementById(x[0] + "_ddlstatus").value = PendingValue;
        }
        ChangeGroupStatus(GrpName, x[0] + "_ddlstatus");
    }
    catch (e) {
        return false;
    }
    return true;
}
//for Value Type Decimals validation - Start
function setCompletedStatusValueType(evt, GrpName, id, deciDigits) {
    try {
        setCompletedStatus(GrpName, id);
        //Value Type Decimals validation
        var vtxtVal = document.getElementById(id).value;
        if (vtxtVal != null && vtxtVal.trim().length > 0 && !isNaN(vtxtVal)) {
            if (deciDigits != null && deciDigits.trim().length > 0 && !isNaN(deciDigits)) {
                var decimalPlace = parseInt(deciDigits);
                if (decimalPlace > 0) {
                    if (vtxtVal.indexOf(".") != -1) {
                        var vArray = vtxtVal.split(".");
                        var vLeft = vArray[0];
                        var vRight = vArray[1];
                        if (vRight.length > decimalPlace) {
                            document.getElementById(id).value = vLeft + '.' + vRight.substring(0, decimalPlace);
                        }
                    }
                }
            }
        }
        //Value Type Decimals validation
    }
    catch (e) {
        return false;
    }
    return false;
}
//for Value Type Decimals validation - End
function SelectOperationID(rid, OPid) {
    chosen = "";

    var len = document.forms[0].elements.length;
    for (var i = 0; i < len; i++) {
        if (document.forms[0].elements[i].type == "radio") {
            document.forms[0].elements[i].checked = false;
        }
    }
    document.getElementById(rid).checked = true;
    document.getElementById("OPid").value = OPid;

}
function InvCalculationdrug() {
    if (document.getElementById('uIAdv_txtQty').value != '' && ToInternalFormat($('#uIAdv_txtQty')) > 0) {
        var T1 = ToInternalFormat($('#uIAdv_txtQty'));
        var ttotal = format_number(Number(T1), 1);
        var totals = ttotal.split('.');
        var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
        if (totals[1] == '0') {
        }
        else {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_104") == null ? "Please enter the round qty." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_104");
 ValidationWindow(userMsg, errorMsg);
            return false;
        }
    }
    else {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_105") == null ? "Provide Quantity" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_105");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('uIAdv_txtQty').focus();
        return false;
        //        var txtDay = document.getElementById('uIAdv_txtFrequencyNumber').value;
        //        var ddlInst = document.getElementById('uIAdv_ddlFrequencyType').value;
        //        var FrequencyType;
        //        var total;
        //        if (ddlInst == 'Day(s)') {
        //            FrequencyType = 1;
        //        }
        //        else if (ddlInst == 'Week(s)') {
        //            FrequencyType = 7;
        //        }
        //        else if (ddlInst == 'Month(s)') {
        //            FrequencyType = 30;
        //        }
        //        else {
        //            FrequencyType = 365;
        //        }
        //        var temoTotal = 0.00;
        //        if (document.getElementById('uIAdv_hdnDrugcalculation').value == '0.00') {
        //            var ddFreq = document.getElementById('uIAdv_tFRQ').value;
        //            var arrayFreq = ddFreq.split('-');
        //            for (var i = 0; i < arrayFreq.length; i++) {
        //                temoTotal += Number(arrayFreq[i]);
        //            }
        //        }
        //        else {
        //            temoTotal = document.getElementById('uIAdv_hdnDrugcalculation').value;
        //        }
        //        total = Number(FrequencyType) * Number(txtDay);
        //        var ttotal = format_number(Number(temoTotal) * Number(total), 1);
        //        var T = ttotal.toString();
        //        var totals = T.split('.');
        //        if (totals[1] == '0') {
        //        }
        //        else {
        //            alert('The drug frequency format provided is not valid. Please redefine.');
        //            document.getElementById('uIAdv_txtFrequencyNumber').focus();
        //            return false;
        //        }
    }
    return true;
}


var iAlreadyPresentRepeat = 0;
var isAlreadyDrugExist = 0;
function InventoryValidation() {
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
var StartDate=$('#uIAdv_txtstartdate').val();
var EndDate=$('#uIAdv_txtenddate').val();
    if (document.getElementById('uIAdv_hdnInvtaskStatusID').value == '0' || document.getElementById('uIAdv_hdnInvtaskStatusID').value == '2' || document.getElementById('uIAdv_hdnInvtaskStatusID').value == '1') {
    }
    else {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_106") == null ? "The prescription part cannot be altered as the task in pharmacy is already picked." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_106");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
    if (document.getElementById('uIAdv_tDName').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_14") == null ? "Provide drug name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_14");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('uIAdv_tDName').focus();
        return false;
    }
    if (document.getElementById('uIAdv_txtfrequency').value == '' && document.getElementById('uIAdv_hdnfreqvalidation').value!='Y') {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_108") == null ? "Provide the frequency" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_108");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('uIAdv_txtfrequency').focus();
        return false;
    }

    //    if (document.getElementById('uIAdv_routeBlock1').style.display == "block") {
    //        if (document.getElementById('uIAdv_tROA').value == '') {
    //            alert('Enter the Route');
    //            document.getElementById('uIAdv_tROA').focus();
    //            return false;
    //        }
    //    }
    //    if (document.getElementById('uIAdv_txtFrequencyNumber').value == '') {
    //    {
    //        alert('Provide Frequency Number');
    //        document.getElementById('uIAdv_txtFrequencyNumber').focus();
    //        return false;    
    //    }


    if (document.getElementById('uIAdv_ddlFrequencyType').value == '' ||
        document.getElementById('uIAdv_ddlFrequencyType').value == '0' ||
        document.getElementById('uIAdv_ddlFrequencyType').value == undefined ||
        document.getElementById('uIAdv_ddlFrequencyType').value == 'undefined') {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_107") == null ? "Provide frequency type" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_107");

 ValidationWindow(userMsg, errorMsg);
        document.getElementById('uIAdv_tFRQ').focus();
        return false;
    }


   /* if (document.getElementById('uIAdv_ddlInstruction').value == '' ||
        document.getElementById('uIAdv_ddlInstruction').value == '0' ||
        document.getElementById('uIAdv_ddlInstruction').value == undefined ||
        document.getElementById('uIAdv_ddlInstruction').value == 'undefined') {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_109") == null ? "Provide the Instruction" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_109");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('uIAdv_tFRQ').focus();
        return false;
    }*/
    if(document.getElementById('uIAdv_txtdruginstruction').value=='')
    {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_109") == null ? "Provide the Instruction" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_109");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('uIAdv_tFRQ').focus();
        return false;
    }
    var productID = document.getElementById('uIAdv_hdnProductID').value;

    if (productID == '' || productID == 0 || productID == 'undefined' || productID == null) {

        document.getElementById('uIAdv_tDName').focus();
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_110") == null ? "Free text not allowed" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_110");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('uIAdv_tDName').value = '';
        return false;
    }
    if(StartDate !='' && EndDate!="" && ToInternalDate(StartDate) >ToInternalDate(EndDate))
    { 
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_142") == null ? "Start Date should be less than end date" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_142");
         ValidationWindow(userMsg, errorMsg);
        document.getElementById('uIAdv_txtstartdate').value = '';
        document.getElementById('uIAdv_txtenddate').value = '';
        return false;
    }
    //^\d{3}([\- ]?)\d{2}([\- ]?)\d{4}$
    if (document.getElementById('uIAdv_txtfrequency').value == '-Others-') {
        var RE_SSN = /^\d*[0-9](|\.\d*[0-9])-\d*[0-9](|\.\d*[0-9])-\d*[0-9](\.\d*[0-9])?$/;
        if (RE_SSN.test(document.getElementById('uIAdv_tFRQ').value)) {
        }
        else {
            //alert("The drug frequency format provided is not valid. Please redefine the format(M-A-N)");
            //document.getElementById('uIAdv_tFRQ').focus();
            //return false;
        }
    }
    var val = InvCalculationdrug();
    if (val == false) {
        return false;
    }
    var drugName = document.getElementById('uIAdv_tDName').value;

    var strdFrq = "";

    var ddFrequency = document.getElementById('uIAdv_ddFrequency');
    var txFrequencytval = ddFrequency.options[ddFrequency.selectedIndex].innerHTML;
    if (document.getElementById('uIAdv_txtfrequency').value == 'Others') {
        var txFrequencytval = document.getElementById('uIAdv_tFRQ').value
    }
    else {
        var txFrequencytval = document.getElementById('uIAdv_txtfrequency').value;
        var txtfreqvalue = document.getElementById('uIAdv_hdnfrequencyid').value;


    }
    var ddDirection = document.getElementById('uIAdv_ddDirection');
    var txddDirectionval = ddDirection.options[ddDirection.selectedIndex].innerHTML;
    var txtddDirecvalue = ddDirection.options[ddDirection.selectedIndex].value;
    if (txFrequencytval == "") {
        strdFrq = document.getElementById('uIAdv_tFRQ').value;
    }

    else {
        strdFrq = txFrequencytval;
    }
    var Qty = ToInternalFormat($('#uIAdv_txtQty'));
    var dDose = document.getElementById('uIAdv_tDose').value;
    var dROA = document.getElementById('uIAdv_tROA').value;
    var ctlDp = document.getElementById('uIAdv_ddlInstruction');
    var ddlIns = ctlDp.options[ctlDp.selectedIndex].value;
    var ddlInstxt =$('#uIAdv_txtdruginstruction').val();// ctlDp.options[ctlDp.selectedIndex].innerHTML;
    //ddlInstxt = ddlInstxt == $('#uIAdv_hdnSelect').val() ? "" : ddlInstxt;
    if (ddlIns == "Other") {
        //ddlIns = document.getElementById('uIAdv_txtINS').value;

        if (document.getElementById('uIAdv_txtINS').value == "") {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_111") == null ? "Provide instruction for others" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_111");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('uIAdv_txtINS').focus();
            return false;
        }
    }
    else {
        ctlDp = document.getElementById('uIAdv_ddlInstruction');
        ddlIns = ctlDp.options[ctlDp.selectedIndex].value;
    }
//    if (document.getElementById('uIAdv_txtINS').value != "" && document.getElementById('uIAdv_txtINS').value != document.getElementById('uIAdv_txtINS').title) {
//        if (ddlIns != $('#uIAdv_hdnSelect').val()) {
//            if (ddlIns != "Other") {
//                ddlIns = ddlIns + '-' + document.getElementById('uIAdv_txtINS').value;
//            }
//            else {
//                ddlIns = document.getElementById('uIAdv_txtINS').value;
//            }
//        }
//        document.getElementById('uIAdv_txtINS').value = document.getElementById('uIAdv_txtINS').title;
//    }
    var Dura = document.getElementById('uIAdv_txtFrequencyNumber').value;
    var Dur = document.getElementById('uIAdv_ddlFrequencyType');
    var Dura1 = Dur.options[Dur.selectedIndex].innerHTML;
    Dura = Dura + ' ' + Dura1;
    var productID = document.getElementById('uIAdv_hdnProductID').value;
    var AutoID = document.getElementById('uIAdv_hdnAutoID').value;
    var TaskID = document.getElementById('uIAdv_hdnTaskID').value;
    var price = $('input[id*=txtPrice]').val();


    var IsGeneric = document.getElementById('uIAdv_hdnIsGeneric').value;
    var GenericID = document.getElementById('uIAdv_hdnGenericID').value;

    var isDrugAready = 0;
    iAlreadyPresentRepeat = 0;

    if (productID == '' || productID == 0 || productID == undefined || productID == null) {
        document.getElementById('uIAdv_tDName').focus();
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_110") == null ? "Free text not allowed" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_110");
        ValidationWindow(userMsg, errorMsg);
        return false;
    }

    if (document.getElementById('uIAdv_hdfDrugs').value != '') {
        isAlreadyDrugExist = 0;
        var arraydrugs = "";
        var arraydDose = "";
        var tempDatas1 = document.getElementById('uIAdv_hdfDrugs').value;
        var arrayAlreadyPresentDatasRepeat = tempDatas1.split('~');
         var arraystartdate='';
            var arrayenddate='';
        for (var j = 0; j < arrayAlreadyPresentDatasRepeat.length; j++) {
            //            if (arrayAlreadyPresentDatasRepeat[j].split('^')[0] == 'DNAME') {
            //                var arraydrugs = arrayAlreadyPresentDatasRepeat[j].split('^')[1];
            //                if (arraydrugs.length > 0) {
            //                    if (arraydrugs.toLowerCase() == (DrugName.toLowerCase())) {
            //                        iAlreadyPresentRepeat++;
            //                    }
            //                }
            //            }
            if(arrayAlreadyPresentDatasRepeat[j].split('^')[0] == 'StartDate') {
                arraystartdate=arrayAlreadyPresentDatasRepeat[j].split('^')[1];
            }
            if(arrayAlreadyPresentDatasRepeat[j].split('^')[0] == 'EndDate') {
                arrayenddate=arrayAlreadyPresentDatasRepeat[j].split('^')[1];
            }
            if (arrayAlreadyPresentDatasRepeat[j].split('^')[0] == 'DNAME') {
                arraydrugs = arrayAlreadyPresentDatasRepeat[j].split('^')[1];

                if (arraydrugs.toLowerCase() == drugName.toLowerCase()) {
                    isDrugAready++;
                }
                if (arraydrugs.toLowerCase() == drugName.toLowerCase()
                && arraydDose.toLowerCase() == strdFrq.toLowerCase() && arraydDose != '' 
                && arrayenddate==EndDate && arraystartdate==StartDate && EndDate!='' && StartDate!='') {
                    iAlreadyPresentRepeat++;
                }
            }
            else if (arrayAlreadyPresentDatasRepeat[j].split('^')[0] == 'FRQ') {
                arraydDose = arrayAlreadyPresentDatasRepeat[j].split('^')[1];

                if (arraydrugs.toLowerCase() == drugName.toLowerCase() && arraydDose.toLowerCase() == strdFrq.toLowerCase() && arrayenddate==EndDate && arraystartdate==StartDate && EndDate!='' && StartDate!='') {
                    iAlreadyPresentRepeat++;
                }
            }
            else if (arrayAlreadyPresentDatasRepeat[j].split('^')[0] == "IsGeneric") {
                IsGeneric = arrayAlreadyPresentDatasRepeat[j].split('^')[1]
            }
            else if (arrayAlreadyPresentDatasRepeat[j].split('^')[0] == 'GenericID') {
                var arraydrugs = arrayAlreadyPresentDatasRepeat[j].split('^')[1];
                if (arraydrugs.length > 0) {
                    if (arraydrugs.split('|')[0] == GenericID && IsGeneric == "Y" ){//&& StartDate && EndDate) {
                        isAlreadyDrugExist++;
                    }
                }
            }
            if (arraydrugs.toLowerCase() == drugName.toLowerCase() && arraydDose.toLowerCase() == txtfreqvalue.toLowerCase() && arrayenddate==EndDate && arraystartdate==StartDate && EndDate!='' && StartDate!='') {
                    iAlreadyPresentRepeat++;
                }
        }

        if (iAlreadyPresentRepeat > 0) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_112") == null ? "Drug Name & Dose already exists!" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_112");
 ValidationWindow(userMsg, errorMsg);
            InventoryAdviceControlclear();
            return false;
        }

        if (isDrugAready > 0) {
            if (ddlIns == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_113") == null ? "Please Enter a Instruction!" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_113");
 ValidationWindow(userMsg, errorMsg);
                return false;
            }
        }
        if (isAlreadyDrugExist > 0) {
        var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
                    var informMsg = SListForAppMsg.Get("PlatForm_Information") == null ? "Information" : SListForAppMsg.Get("PlatForm_Information");
                    var okMsg = SListForAppMsg.Get("PlatForm_Ok") == null ? "Ok" : SListForAppMsg.Get("PlatForm_Ok")
                    var cancelMsg = SListForAppMsg.Get("PlatForm_Cancel") == null ? "Cancel" : SListForAppMsg.Get("PlatForm_Cancel");
                     var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_131") == null ? "Drug Generic Name already exists! Do you want to continue " : SListForAppMsg.Get("PlatForm_Scripts_Common_js_131");
            i = ConfirmWindow(userMsg,informMsg,okMsg,cancelMsg);
            if (!i) {
                InventoryAdviceControlclear();
                return false;
            }
        }


    }
    else {
        // return true;
    }
    var DocterType = document.getElementById('uIAdv_hdnDoctortype').value;

    var PhysicianID = "0";
    var PhysicianName = '';

    if (DocterType == "M") {
        PhysicianID = $('#uIAdv_ddlPresPhysican').val();
        PhysicianName = $('#uIAdv_ddlPresPhysican option:selected').text();
        if (PhysicianID == 0 || PhysicianID == null) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_114") == null ? "Please Select Physician Name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_114");
 ValidationWindow(userMsg, errorMsg);
            return false;
        }
    }
    var PhysicianName;
    var PhysicianID;
    if (document.getElementById('uIAdv_ChkPhysician').checked == true || document.getElementById('uIAdv_txtPhysicianName').value != '') {
         PhysicianName = document.getElementById('uIAdv_txtPhysicianName').value;
         PhysicianID = document.getElementById('uIAdv_hdnPrescribedby').value;
    }
    else {
        PhysicianName = document.getElementById('uIAdv_hdnLoginName').value;
        PhysicianID = document.getElementById('uIAdv_hdnLoginId').value;
    }
    var status = $('#uIAdv_hdnStatus').val();
    var retval = { DrugName: drugName, Dose: dDose, ROA: dROA, Frequency: txtfreqvalue, Direction: txddDirectionval, Duration: Dura, Instruction: ddlInstxt, ProductID: productID, AutoID: AutoID, TaskID: TaskID, Quantity: Qty, IsGeneric: IsGeneric, GenericID: GenericID, ddlIns: ddlIns, Status: status, Price: price, FrequencyText: strdFrq, PhysicianID: PhysicianID, PhysicianName: PhysicianName,StartDate: StartDate,EndDate:EndDate };
    //  var retval = drugName + "~" + dDose + "~" + dROA + "~" + strdFrq + "~" + txddDirectionval + "~" + Dura + "~" + ddlInstxt + "~" + productID + "~" + AutoID + "~" + TaskID + "~" + Qty + "~" + IsGeneric + "~" + GenericID + '~' + txtfreqvalue + '~' + ddlIns;


    return retval;
}


function InventoryAdviceControlclear() {
    document.getElementById('uIAdv_tDName').value = '';
    var IsCorporateOrg = document.getElementById('uIAdv_hdnIsCorpOrg').value;
    if (IsCorporateOrg == 'Y') {
        document.getElementById('uIAdv_tROA').value = '';
    }
    document.getElementById('uIAdv_tFRQ').style.display = "none";
    document.getElementById('uIAdv_tDose').value = '';
    document.getElementById('uIAdv_txtFrequencyNumber').value = '1';
    document.getElementById('uIAdv_ddlFrequencyType').selectedIndex = 0;
   // document.getElementById('uIAdv_ddFrequency').value = '';
    //document.getElementById('uIAdv_ddDirection').value = '';
    document.getElementById('uIAdv_ddFrequency').selectedIndex = 0;
    document.getElementById('uIAdv_ddDirection').selectedIndex = 0;
    document.getElementById('uIAdv_tDura').value = '';
    //document.getElementById('uIAdv_tFRQ').value = '1-0-0';
    document.getElementById('uIAdv_txtQty').value = '';
    // document.getElementById('uIAdv_ddlInstruction').value = '';
    document.getElementById('uIAdv_ddlInstruction').selectedIndex = 0;
    document.getElementById('uIAdv_txtdruginstruction').value="";
    //document.getElementById('uIAdv_ddFrequency').value = '1-0-0';
    document.getElementById('uIAdv_tDName').focus();
    document.getElementById('uIAdv_hdnProductID').value = "";
    document.getElementById('uIAdv_hdnAutoID').value = 0;
    document.getElementById('uIAdv_hdnTaskID').value = 0;
    document.getElementById('uIAdv_hdnIsGeneric').value = "N";
    document.getElementById('uIAdv_hdnGenericID').value = "0";
    document.getElementById('uIAdv_txtPrice').value = "";
    document.getElementById('uIAdv_txtstartdate').value = "";
    document.getElementById('uIAdv_txtenddate').value = "";
     document.getElementById('uIAdv_hdnfrequencyid').value = "0";
     document.getElementById('uIAdv_txtfrequency').value = "";
    if (document.getElementById('uIAdv_ChkPhysician').checked == false) {
        document.getElementById('uIAdv_txtPhysicianName').value = "";
    }
    $('#uIAdv_hdnStatus').val('Open');
    $('#uIAdv_tDName').attr("disabled", false)
    return false;
}


function checkProductValidation(txtProduct) {
    if (document.getElementById(txtProduct).value.trim() == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_118") == null ? "Provide the Product name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_118");
 var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById(txtProduct).focus();
        return false;
    }
    return true;

}
function SetProductItem(id, txtProduct) {
    var obj = document.getElementById(id);
    var i = obj.getElementsByTagName('OPTION');
    if (obj.options.selectedIndex != -1) {
        document.getElementById(txtProduct).value = obj.options[obj.selectedIndex].text;
    }
}

function showExamPKGContent(id) {

    var chkvalue = id.split('_');

    var trid = chkvalue[0] + "_tr1" + chkvalue[1] + "_" + chkvalue[2];
    if (document.getElementById(id).checked == true) {
        document.getElementById(trid).style.display = 'block';
    }
    else {
        document.getElementById(trid).style.display = 'none';
    }

}


//EMR Advice

function EMRvalidation() {
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tDName').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_14") == null ? "Provide drug name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_14");
 ValidationWindow(userMsg, errorMsg);
        // document.getElementById('uAd_tDName').focus();
        return false;
    }
    if (document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tFrm').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_119") == null ? "Provide the Formulation" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_119");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tFrm').focus();
        return false;
    }
    //    if (document.getElementById('uAd_tDose').value == '') {
    //        alert('Enter the Dose');
    //        document.getElementById('uAd_tDose').focus();
    //        return false;
    //    }
    //    if (document.getElementById('tcEMR_tpHistory_ucHistory_uAd_routeBlock1').style.display == "block") {
    //        if (document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tROA').value == '') {
    //            alert('Enter the Route');
    //            document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tROA').focus();
    //            return false;
    //        }
    //    }
    if (document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tFRQ').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_120") == null ? "Provide the Frequency" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_120");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tFRQ').focus();
        return false;
    }
    //    if (document.getElementById('uAd_tDura').value == '') {
    //        alert('Enter the Duration');
    //        document.getElementById('uAd_tDura').focus();
    //        return false;
    //    }


    var drugName = document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tDName').value;
    var drugFrm = "";
    var ddFormulation = document.getElementById('tcEMR_tpHistory_ucHistory_uAd_ddFormulation');
    var txtval = ddFormulation.options[ddFormulation.selectedIndex].value;

    if (txtval == "") {
        drugFrm = document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tFrm').value;
    }
    else {
        drugFrm = txtval;
    }
    var strdFrq = "";

    var ddFrequency = document.getElementById('tcEMR_tpHistory_ucHistory_uAd_ddFrequency');
    var txFrequencytval = ddFrequency.options[ddFrequency.selectedIndex].value;
    // alert(txFrequencytval);
    if (txFrequencytval == "") {
        strdFrq = document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tFRQ').value;
    }
    else {
        strdFrq = txFrequencytval;
    }
    // alert(strdFrq);

    var dDose = document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tDose').value;
    var dROA = document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tROA').value;




    var Dura = document.getElementById('tcEMR_tpHistory_ucHistory_uAd_txtFrequencyNumber').value;
    var Dura1 = document.getElementById('tcEMR_tpHistory_ucHistory_uAd_ddlFrequencyType').value;
    Dura = Dura + ' ' + Dura1;
    var retval = drugName + "~" + drugFrm + "~" + dDose + "~" + dROA + "~" + strdFrq + "~" + Dura;

    return retval;
}



function EMRAdviceControlclear() {
    document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tDName').value = '';
    document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tFrm').value = 'Tab.';
    //document.getElementById('uAd_tROA').value = '';
    document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tDose').value = '';
    document.getElementById('tcEMR_tpHistory_ucHistory_uAd_txtFrequencyNumber').value = '1';
    document.getElementById('tcEMR_tpHistory_ucHistory_uAd_ddlFrequencyType').value = 'Day(s)';

    document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tDura').value = '';
    //document.getElementById('uAd_tFRQ').value = '1-0-0';

    document.getElementById('tcEMR_tpHistory_ucHistory_uAd_ddFormulation').value = 'Tab.';
    //document.getElementById('uAd_ddFrequency').value = '1-0-0';
    document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tDName').focus();

    return false;
}


function showExamPKGContents(id) {

    var chkvalue = id.split('_');

    var trid = chkvalue[0] + "_" + chkvalue[1] + "_" + chkvalue[2] + "_tr1" + chkvalue[3] + "_" + chkvalue[4];

    if (document.getElementById(id).checked == true) {
        document.getElementById(trid).style.display = 'block';
    }
    else {
        document.getElementById(trid).style.display = 'none';
    }

}

function showExamPKGOthers(ddl) {

    var ddlValue = document.getElementById(ddl).options[document.getElementById(ddl).selectedIndex].innerHTML;
    var ddlist = ddl.split('_');
    var strDiv = ddlist[0] + '_' + ddlist[1] + '_' + ddlist[2] + '_div' + ddlist[3] + '_' + ddlist[4];
    if ((ddlValue == "Others" || ddlValue == "Abnormal")) {
        document.getElementById(strDiv).style.display = 'block';
    }
    else {
        document.getElementById(strDiv).style.display = 'none';
    }



    if (ddl == "tcEMR_tpExamination_ucNails_ddlNailsType_4" && ddlValue != "Normal" && ddlValue != "Others") {


        document.getElementById('tcEMR_tpExamination_ucNails_trNailsDescription_5').style.display = 'block';
    }
    else {

        if (ddl == "tcEMR_tpExamination_ucNails_ddlNailsType_4" && ddlValue == "Others") {
            document.getElementById('tcEMR_tpExamination_ucNails_trNailsDescription_5').style.display = 'none';
        }
        else {
            if (ddl == "tcEMR_tpExamination_ucNails_ddlNailsType_4" && ddlValue == "Normal") {
                document.getElementById('tcEMR_tpExamination_ucNails_trNailsDescription_5').style.display = 'none';
            }

        }
    }

}


function showDiagnosticsPKGContents(id) {



    var chkvalue = id.split('_');

    var trid = chkvalue[0] + "_" + chkvalue[1] + "_" + chkvalue[2] + "_tr1" + chkvalue[3] + "_" + chkvalue[4];

    if (document.getElementById(id).checked == true) {
        document.getElementById(trid).style.display = 'block';
    }
    else {
        document.getElementById(trid).style.display = 'none';
    }

}


function showDiagnosticsPKGOthers(ddl) {


    var val = document.getElementById(ddl).value;


    var ddlValue = document.getElementById(ddl).options[document.getElementById(ddl).selectedIndex].innerHTML;

    var ddlist = ddl.split('_');
    var strDiv = ddlist[0] + '_' + ddlist[1] + '_' + ddlist[2] + '_div' + ddlist[3] + '_' + ddlist[4];
    if ((ddlValue == "Others")) {
        document.getElementById(strDiv).style.display = 'block';
    }
    else {
        document.getElementById(strDiv).style.display = 'none';
    }
}




function showDiagnosticsCHKPKGOthers(ddl) {


    var cboxObj = document.getElementById(ddl);
    var cboxList = cboxObj.getElementsByTagName('input');
    var lbList = cboxObj.getElementsByTagName('label');
    for (var i = 0; i < cboxList.length; i++) {
        if (cboxList[i].checked) {
            if (lbList[i].innerText == "Others") {
                var ddlValue = lbList[i].innerText;
            }
        }
    }

    var ddlist = ddl.split('_');
    var strDiv = ddlist[0] + '_' + ddlist[1] + '_' + ddlist[2] + '_div' + ddlist[3] + '_' + ddlist[4];
    if ((ddlValue == "Others")) {
        document.getElementById(strDiv).style.display = 'block';
    }
    else {
        document.getElementById(strDiv).style.display = 'none';
    }

}



function SelectReferralID(rid, RefID) {
    chosen = "";

    var len = document.forms[0].elements.length;
    for (var i = 0; i < len; i++) {
        if (document.forms[0].elements[i].type == "radio") {
            document.forms[0].elements[i].checked = false;
        }
    }
    document.getElementById(rid).checked = true;
    document.getElementById("RefID").value = RefID;

}



function NACvalidation() {
var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (document.getElementById('uNewAd_tDName').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_14") == null ? "Provide drug name" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_14");
 ValidationWindow(userMsg, errorMsg);
        // document.getElementById('uNewAd_tDName').focus();
        return false;
    }
    if (document.getElementById('uNewAd_tFrm').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_119") == null ? "Provide the Formulation" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_119");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('uNewAd_tFrm').focus();
        return false;
    }
    //    if (document.getElementById('uNewAd_tDose').value == '') {
    //        alert('Enter the Dose');
    //        document.getElementById('uNewAd_tDose').focus();
    //        return false;
    //    }
    //    if (document.getElementById('uNewAd_routeBlock1').style.display == "block") {
    //        if (document.getElementById('uNewAd_tROA').value == '') {
    //            alert('Enter the Route');
    //            document.getElementById('uNewAd_tROA').focus();
    //            return false;
    //        }
    //    }
    if (document.getElementById('uNewAd_tFRQ').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_120") == null ? "Provide the Frequency" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_120");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('uNewAd_tFRQ').focus();
        return false;
    }
    //    if (document.getElementById('uNewAd_tDura').value == '') {
    //        alert('Enter the Duration');
    //        document.getElementById('uNewAd_tDura').focus();
    //        return false;
    //    }


    var drugName = document.getElementById('uNewAd_tDName').value;
    var drugFrm = "";
    var ddFormulation = document.getElementById('uNewAd_ddFormulation');
    var txtval = ddFormulation.options[ddFormulation.selectedIndex].value;

    if (txtval == "") {
        drugFrm = document.getElementById('uNewAd_tFrm').value;
    }
    else {
        drugFrm = txtval;
    }
    var strdFrq = "";

    var ddFrequency = document.getElementById('uNewAd_ddFrequency');
    var txFrequencytval = ddFrequency.options[ddFrequency.selectedIndex].value;
    // alert(txFrequencytval);
    if (txFrequencytval == "") {
        strdFrq = document.getElementById('uNewAd_tFRQ').value;
    }
    else {
        strdFrq = txFrequencytval;
    }
    // alert(strdFrq);

    var dDose = document.getElementById('uNewAd_tDose').value;
    var dROA = document.getElementById('uNewAd_tROA').value;
    var ctlDp = document.getElementById('uNewAd_ddlInstruction');
    var ddlIns = ctlDp.options[ctlDp.selectedIndex].value;
    if (ddlIns == "Other") {
        ddlIns = document.getElementById('uNewAd_txtINS').value;

        if (document.getElementById('uNewAd_txtINS').value == "") {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_111") == null ? "Provide instruction for others" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_111");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('uNewAd_txtINS').focus();
            return false;
        }
    }
    else {
        ctlDp = document.getElementById('uNewAd_ddlInstruction');
        ddlIns = ctlDp.options[ctlDp.selectedIndex].value;
    }

    var Dura = document.getElementById('uNewAd_txtFrequencyNumber').value;
    var Dura1 = document.getElementById('uNewAd_ddlFrequencyType').value;
    Dura = Dura + ' ' + Dura1;
    var retval = drugName + "~" + drugFrm + "~" + dDose + "~" + dROA + "~" + strdFrq + "~" + Dura + "~" + ddlIns;

    return retval;
}


function NACclear() {
    document.getElementById('uNewAd_tDName').value = '';
    document.getElementById('uNewAd_tFrm').value = 'Tab.';
    //document.getElementById('uNewAd_tROA').value = '';
    document.getElementById('uNewAd_tDose').value = '';
    document.getElementById('uNewAd_txtFrequencyNumber').value = '1';
    document.getElementById('uNewAd_ddlFrequencyType').value = 'Day(s)';

    document.getElementById('uNewAd_tDura').value = '';
    //document.getElementById('uNewAd_tFRQ').value = '1-0-0';
    document.getElementById('uNewAd_ddlInstruction').value = '';
    document.getElementById('uNewAd_ddFormulation').value = 'Tab.';
    //document.getElementById('uNewAd_ddFrequency').value = '1-0-0';
    document.getElementById('uNewAd_tDName').focus();

    return false;
}


/*Patient Search.ascx*/
function SelectSurgeryRowCommon(rid, patid) {
    chosen = "";

    var len = document.forms[0].elements.length;
    for (var i = 0; i < len; i++) {
        if (document.forms[0].elements[i].type == "radio") {
            document.forms[0].elements[i].checked = false;
        }
    }
    document.getElementById(rid).checked = true;
    document.getElementById("pid").value = patid;

}

function ReportPopUP(url) {
    var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
    strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=1050";
    // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
    strFeatures = strFeatures + ",left=150,top=250";
    window.open(url, "", strFeatures, "");
}

function ConverttoUpperCase(id) {
    var lowerCase = document.getElementById(id).value;
    var upperCase = lowerCase.toUpperCase();
    document.getElementById(id).value = upperCase;
}
function countAgeLab(id) {
    if (document.getElementById(id).value != '') {
        bD = document.getElementById(id).value.split('/');
        var agetemp = 0;
        dd = bD[0];
        mm = bD[1];
        yy = bD[2];
        main = "valid";
        if ((dd == "__") || (mm == "__") || (yy == "____")) {
            //document.getElementById('txtAge').value = '';
            return false;
        }
        if ((mm < 1) || (mm > 12) || (dd < 1) || (dd > 31) || (yy < 1) || (mm == "") || (dd == "") || (yy == ""))
            main = "Invalid";
        else
            if (((mm == 4) || (mm == 6) || (mm == 9) || (mm == 11)) && (dd > 30))
            main = "Invalid";
        else
            if (mm == 2) {
            if (dd > 29)
                main = "Invalid";
            else if ((dd > 28) && (!lyear(yy)))
                main = "Invalid";
        }
        else
            if ((yy > 9999) || (yy < 0))
            main = "Invalid";
        else
            main = main;
        if (main == "valid") {
            function leapyear(a) {
                if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0))
                    return true;
                else
                    return false;
            }
            var days = GetServerDate();

            var gdate = days.getDate();
            var gmonth = days.getMonth();
            var gyear = days.getFullYear();
            age = gyear - yy;
            if ((mm == (gmonth + 1)) && (dd <= parseInt(gdate))) {
                age = age;
            }
            else {
                if (mm <= (gmonth)) {
                    age = age;
                }
                else {
                    age = age - 1;
                }
            }
            if (age == 0)
                age = age;
            agetemp = age;
            if (mm <= (gmonth + 1))
                age = age - 1;
            if ((mm == (gmonth + 1)) && (dd > parseInt(gdate)))
                age = age + 1;
            var m;
            var n;
            if (mm == 12) { n = 31 - dd; }
            if (mm == 11) { n = 61 - dd; }
            if (mm == 10) { n = 92 - dd; }
            if (mm == 9) { n = 122 - dd; }
            if (mm == 8) { n = 153 - dd; }
            if (mm == 7) { n = 184 - dd; }
            if (mm == 6) { n = 214 - dd; }
            if (mm == 5) { n = 245 - dd; }
            if (mm == 4) { n = 275 - dd; }
            if (mm == 3) { n = 306 - dd; }
            if (mm == 2) { n = 334 - dd; if (leapyear(yy)) n = n + 1; }
            if (mm == 1) { n = 365 - dd; if (leapyear(yy)) n = n + 1; }
            if (gmonth == 1) m = 31;
            if (gmonth == 2) { m = 59; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 3) { m = 90; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 4) { m = 120; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 5) { m = 151; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 6) { m = 181; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 7) { m = 212; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 8) { m = 243; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 9) { m = 273; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 10) { m = 304; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 11) { m = 334; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 12) { m = 365; if (leapyear(gyear)) m = m + 1; }
            totdays = (parseInt(age) * 365);
            totdays += age / 4;
            totdays = parseInt(totdays) + gdate + m + n;
            months = age * 12;
            months += 12 - parseInt(mm);
            months += gmonth;
            if (gmonth == 1) p = 31 + gdate;
            if (gmonth == 2) { p = 59 + gdate; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 3) { p = 90 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 4) { p = 120 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 5) { p = 151 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 6) { p = 181 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 7) { p = 212 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 8) { p = 243 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 9) { p = 273 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 10) { p = 304 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 11) { p = 334 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 12) { p = 365 + gdate; if (leapyear(gyear)) p = p + 1; }
            weeks = totdays / 7;
            weeks += " weeks";
            weeks = parseInt(weeks);
            if (agetemp <= 0) {
                if (months <= 0) {
                    if (weeks <= 0) {
                        if (totdays >= 0) {
                            if (totdays == 1) {
                                document.getElementById('txtAge').value = totdays;
                                document.getElementById('ddlAgeUnit').value = 'Day(s)';
                            }
                            else {
                                document.getElementById('txtAge').value = totdays;
                                document.getElementById('ddlAgeUnit').value = 'Day(s)';
                            }
                        }
                    }
                    else {
                        if (weeks == 1) {
                            document.getElementById('txtAge').value = weeks;
                            document.getElementById('ddlAgeUnit').value = 'Week(s)';
                        }
                        else {
                            document.getElementById('txtAge').value = weeks;
                            document.getElementById('ddlAgeUnit').value = 'week(s)';
                        }
                    }
                }
                else {
                    if (months == 1) {
                        document.getElementById('txtAge').value = months;
                        document.getElementById('ddlAgeUnit').value = 'Month(s)';
                    }
                    else {
                        document.getElementById('txtAge').value = months;
                        document.getElementById('ddlAgeUnit').value = 'Month(s)';
                    }
                }
            }
            else {
                if (agetemp == 1) {
                    document.getElementById('txtAge').value = agetemp;
                    document.getElementById('ddlAgeUnit').value = 'Year(s)';
                }
                else {
                    document.getElementById('txtAge').value = agetemp;
                    document.getElementById('ddlAgeUnit').value = 'Year(s)';
                }
            }

            function lyear(a) {
                if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0)) return true;
                else return false;
            }
        }
        else {
            alert(main + ' Date');
            document.getElementById('txtAge').value = '';
            document.getElementById('tDOB').value = '';
            document.getElementById('tDOB').value = '__/__/____';
            document.getElementById('tDOB').focus();
        }
    }
}


var datadiv_tooltip = false;
var datadiv_tooltipShadow = false;
var datadiv_shadowSize = 4;
var datadiv_tooltipMaxWidth = 200;
var datadiv_tooltipMinWidth = 100;
var datadiv_iframe = false;
var tooltip_is_msie = (navigator.userAgent.indexOf('MSIE') >= 0 && navigator.userAgent.indexOf('opera') == -1 && document.all) ? true : false;
function showTooltip(e, tooltipTxt) {

    var bodyWidth = Math.max(document.body.clientWidth, document.documentElement.clientWidth) - 20;

    if (!datadiv_tooltip) {
        datadiv_tooltip = document.createElement('DIV');
        datadiv_tooltip.id = 'datadiv_tooltip';
        datadiv_tooltipShadow = document.createElement('DIV');
        datadiv_tooltipShadow.id = 'datadiv_tooltipShadow';

        document.body.appendChild(datadiv_tooltip);
        document.body.appendChild(datadiv_tooltipShadow);

        if (tooltip_is_msie) {
            datadiv_iframe = document.createElement('IFRAME');
            datadiv_iframe.frameborder = '5';
            datadiv_iframe.style.backgroundColor = '#FFFFFF';
            datadiv_iframe.src = '#';
            datadiv_iframe.style.zIndex = 100;
            datadiv_iframe.style.position = 'absolute';
            document.body.appendChild(datadiv_iframe);
        }

    }

    datadiv_tooltip.style.display = 'block';
    datadiv_tooltipShadow.style.display = 'block';
    if (tooltip_is_msie) datadiv_iframe.style.display = 'block';

    var st = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    if (navigator.userAgent.toLowerCase().indexOf('safari') >= 0) st = 0;
    var leftPos = e.clientX + 10;

    datadiv_tooltip.style.width = null; // Reset style width if it's set 
    datadiv_tooltip.innerHTML = tooltipTxt;
    datadiv_tooltip.style.left = leftPos + 'px';
    datadiv_tooltip.style.top = e.clientY + 10 + st + 'px';


    datadiv_tooltipShadow.style.left = leftPos + datadiv_shadowSize + 'px';
    datadiv_tooltipShadow.style.top = e.clientY + 10 + st + datadiv_shadowSize + 'px';

    if (datadiv_tooltip.offsetWidth > datadiv_tooltipMaxWidth) {	/* Exceeding max width of tooltip ? */
        datadiv_tooltip.style.width = datadiv_tooltipMaxWidth + 'px';
    }

    var tooltipWidth = datadiv_tooltip.offsetWidth;
    if (tooltipWidth < datadiv_tooltipMinWidth) tooltipWidth = datadiv_tooltipMinWidth;


    datadiv_tooltip.style.width = tooltipWidth + 'px';
    datadiv_tooltipShadow.style.width = datadiv_tooltip.offsetWidth + 'px';
    datadiv_tooltipShadow.style.height = datadiv_tooltip.offsetHeight + 'px';

    if ((leftPos + tooltipWidth) > bodyWidth) {
        datadiv_tooltip.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth)) + 'px';
        datadiv_tooltipShadow.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth) + datadiv_shadowSize) + 'px';
    }

    if (tooltip_is_msie) {
        datadiv_iframe.style.left = datadiv_tooltip.style.left;
        datadiv_iframe.style.top = datadiv_tooltip.style.top;
        datadiv_iframe.style.width = datadiv_tooltip.offsetWidth + 'px';
        datadiv_iframe.style.height = datadiv_tooltip.offsetHeight + 'px';

    }

}

function hideTooltip() {
    datadiv_tooltip.style.display = 'none';
    datadiv_tooltipShadow.style.display = 'none';
    if (tooltip_is_msie) datadiv_iframe.style.display = 'none';
}

function CheckExistingURN(ctl) {
    if (document.getElementById('URNControl1_hdnUrn').value == '0' ){//&& $('#URNControl1_hdnconfig').val() != 'Y') {
        if (document.getElementById('URNControl1_txtURNo').value != '' && document.getElementById('URNControl1_ddlUrnType').value != '0') {
            Attune.Kernel.Shared.CommonServices.GetURN(document.getElementById('URNControl1_ddlUrnType').value, document.getElementById('URNControl1_txtURNo').value, GetURN);
        }
    }

}
function GetURN(URnList) {
    var URNValue = $('#URNControl1_hdnURNVal').val();
    //var txtValue = document.getElementById('URNControl1_txtURNo').value;&& $('#URNControl1_hdnconfig').val() != 'Y' 
    if (URnList.length > 0 && URnList[0].SeqNo != $('#URNControl1_hdnPatientID').val() && $('#URNControl1_ddlUrnoOf').val()=='1') {
var userMsg ='Patient' +' '+URnList[0].RelationName+' '+(SListForAppMsg.Get("PlatForm_Scripts_Common_js_121") == null ? "Already exist in this URN type" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_121"));
 var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg,'URNControl1_txtURNo');
        //document.getElementById('URNControl1_txtURNo').value = "";
       // document.getElementById('URNControl1_txtURNo').focus();
        return false;
    }
}
function getNode(ctl, nodeName) {
    if (ctl.parentNode.nodeName == nodeName)
        return ctl.parentNode;
    else
        ctlRet = getNode(ctl.parentNode, nodeName);
    return ctlRet;
}
function SortTable(grdId, srcTabId, sortBy, ctl) { // "srcTabId" it will give a Temp Table id from Aspx Page.(Not Necessary)
    var srcTab;
    //var E = document.getElementById(grdId);
    //   E.rows.length
    //   srcTab = document.getElementById(grdId + '_' + srcTabId);
    //   for (var k = 2; E.rows.length > k; k++) {
    //       var ObjTag = E.childNodes[0].childNodes[k].cells[0].childNodes[0].childNodes[0]
    //       var selRow = getNode(ObjTag, "TD");
    //       alert(selRow[k].innerText);
    //   }
    // alert(srcTab);
    //srcTab.childNodes
    if (grdId == "")
        srcTab = document.getElementById(srcTabId);
    else

        srcTab = document.getElementById(grdId);
    //srcTab = document.getElementById(lvwId + '_' + srcTabId);
    var tmpRow = srcTab.insertRow();
    if (ctl.tag == '1') {
        ascDesc = 1;
        ctl.tag = '2';
        // ctl.className = "sortDesc";
    }
    else {
        ascDesc = 2;
        ctl.tag = '1';
        //ctl.className = "sortAsc";
    }
    for (var i = 0; i < srcTab.rows[0].cells.length; i++)
        var newCel = tmpRow.insertCell();
    for (var i = 1; i < srcTab.rows.length - 2; i++)
        for (var j = i + 1; j < srcTab.rows.length - 1; j++) {
        if (ascDesc == 1) {
            if (j <= 10)
            // bChk = srcTab.rows[i].cells[sortBy].innerText > srcTab.rows[j].cells[sortBy].innerText;
                if (isNaN(srcTab.childNodes[0].childNodes[i].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[sortBy].innerText)) {
                bChk = srcTab.childNodes[0].childNodes[i].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[sortBy].innerText > srcTab.childNodes[0].childNodes[j].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[sortBy].innerText
            }
            else {

                bChk = parseInt(srcTab.childNodes[0].childNodes[i].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[sortBy].innerText) > parseInt(srcTab.childNodes[0].childNodes[j].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[sortBy].innerText)
            }
        }
        else {
            if (j <= 10)
                if (isNaN(srcTab.childNodes[0].childNodes[i].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[sortBy].innerText)) {
                bChk = srcTab.childNodes[0].childNodes[i].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[sortBy].innerText < srcTab.childNodes[0].childNodes[j].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[sortBy].innerText
            }
            else {
                bChk = parseInt(srcTab.childNodes[0].childNodes[i].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[sortBy].innerText) < parseInt(srcTab.childNodes[0].childNodes[j].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[sortBy].innerText)

            }
            //alert(srcTab.rows[i].cells[sortBy].innerText);
            //bChk = srcTab.rows[i].cells[sortBy].innerText < srcTab.rows[j].cells[sortBy].innerText;                
            //bChk = parseInt(srcTab.childNodes[0].childNodes[i].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[sortBy].innerText) < parseInt(srcTab.childNodes[0].childNodes[j].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[sortBy].innerText)
        }
        if (bChk) {
            swapRows(tmpRow, srcTab.rows[i]);
            swapRows(srcTab.rows[i], srcTab.rows[j]);
            swapRows(srcTab.rows[j], tmpRow);
        }
    }
    srcTab.deleteRow(i + 1);
    return false;
}

function swapRows(dstRow, srcRow) {
    for (var i = 0; i < srcRow.cells.length; i++)
        dstRow.cells[i].innerHTML = srcRow.cells[i].innerHTML;
}

//Added By venkat
function countAge(id) {
    //alert(document.getElementById(id).value);
    if (document.getElementById(id).value != '') {
        bD = document.getElementById(id).value.split('/');
        var agetemp = 0;
        dd = bD[0];
        mm = bD[1];
        yy = bD[2];
        main = "valid";
        if ((dd == "__") || (mm == "__") || (yy == "____")) {
            //document.getElementById('txtAge').value = '';
            return false;
        }
        if ((mm < 1) || (mm > 12) || (dd < 1) || (dd > 31) || (yy < 1) || (mm == "") || (dd == "") || (yy == ""))
            main = "Invalid";
        else
            if (((mm == 4) || (mm == 6) || (mm == 9) || (mm == 11)) && (dd > 30))
            main = "Invalid";
        else
            if (mm == 2) {
            if (dd > 29)
                main = "Invalid";
            else if ((dd > 28) && (!lyear(yy)))
                main = "Invalid";
        }
        else
            if ((yy > 9999) || (yy < 0))
            main = "Invalid";
        else
            main = main;
        if (main == "valid") {
            function leapyear(a) {
                if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0))
                    return true;
                else
                    return false;
            }
            var days = GetServerDate();

            var gdate = days.getDate();
            var gmonth = days.getMonth();
            var gyear = days.getFullYear();
            age = gyear - yy;
            if ((mm == (gmonth + 1)) && (dd <= parseInt(gdate))) {
                age = age;
            }
            else {
                if (mm <= (gmonth)) {
                    age = age;
                }
                else {
                    age = age - 1;
                }
            }
            if (age == 0)
                age = age;
            agetemp = age;
            if (mm <= (gmonth + 1))
                age = age - 1;
            if ((mm == (gmonth + 1)) && (dd > parseInt(gdate)))
                age = age + 1;
            var m;
            var n;
            if (mm == 12) { n = 31 - dd; }
            if (mm == 11) { n = 61 - dd; }
            if (mm == 10) { n = 92 - dd; }
            if (mm == 9) { n = 122 - dd; }
            if (mm == 8) { n = 153 - dd; }
            if (mm == 7) { n = 184 - dd; }
            if (mm == 6) { n = 214 - dd; }
            if (mm == 5) { n = 245 - dd; }
            if (mm == 4) { n = 275 - dd; }
            if (mm == 3) { n = 306 - dd; }
            if (mm == 2) { n = 334 - dd; if (leapyear(yy)) n = n + 1; }
            if (mm == 1) { n = 365 - dd; if (leapyear(yy)) n = n + 1; }
            if (gmonth == 1) m = 31;
            if (gmonth == 2) { m = 59; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 3) { m = 90; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 4) { m = 120; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 5) { m = 151; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 6) { m = 181; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 7) { m = 212; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 8) { m = 243; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 9) { m = 273; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 10) { m = 304; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 11) { m = 334; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 12) { m = 365; if (leapyear(gyear)) m = m + 1; }
            totdays = (parseInt(age) * 365);
            totdays += age / 4;
            totdays = parseInt(totdays) + gdate + m + n;
            months = age * 12;
            var t = parseInt(mm);
            months += 12 - mm;
            months += gmonth + 1;
            if (gmonth == 1) p = 31 + gdate;
            if (gmonth == 2) { p = 59 + gdate; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 3) { p = 90 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 4) { p = 120 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 5) { p = 151 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 6) { p = 181 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 7) { p = 212 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 8) { p = 243 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 9) { p = 273 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 10) { p = 304 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 11) { p = 334 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 12) { p = 365 + gdate; if (leapyear(gyear)) p = p + 1; }
            weeks = totdays / 7;
            weeks += " weeks";
            weeks = parseInt(weeks);
            if (agetemp <= 0) {
                if (months <= 0) {
                    if (weeks <= 0) {
                        if (totdays >= 0) {
                            if (totdays == 1) {
                                document.getElementById('txtDOBNos').value = totdays;
                                document.getElementById('ddlDOBDWMY').value = 'D';
                            }
                            else {
                                document.getElementById('txtDOBNos').value = totdays;
                                document.getElementById('ddlDOBDWMY').value = 'D';
                            }
                        }
                    }
                    else {
                        if (weeks == 1) {
                            document.getElementById('txtDOBNos').value = weeks;
                            document.getElementById('ddlDOBDWMY').value = 'W';
                        }
                        else {
                            document.getElementById('txtDOBNos').value = weeks;
                            document.getElementById('ddlDOBDWMY').value = 'W';
                        }
                    }
                }
                else {
                    if (months == 1) {
                        document.getElementById('txtDOBNos').value = months;
                        document.getElementById('ddlDOBDWMY').value = 'M';
                    }
                    else {
                        document.getElementById('txtDOBNos').value = months;
                        document.getElementById('ddlDOBDWMY').value = 'M';
                    }
                }
            }
            else {
                if (agetemp == 1) {
                    document.getElementById('txtDOBNos').value = agetemp;
                    document.getElementById('ddlDOBDWMY').value = 'Y';
                }
                else {
                    document.getElementById('txtDOBNos').value = agetemp;
                    document.getElementById('ddlDOBDWMY').value = 'Y';
                }
            }

            function lyear(a) {
                if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0)) return true;
                else return false;
            }
        }
        else {
            alert(main + ' Date');
            document.getElementById('txtDOBNos').value = '';
            document.getElementById('tDOB').value = '';
            document.getElementById('tDOB').value = '__/__/____';
            document.getElementById('tDOB').focus();
        }
    }
}


function Getdigitalnumber(pConName, pNumber) {
    var s = pNumber.toString().trim();
    var Len = pNumber.toString().trim().length;
    var row = pConName;
    var str = "<table style='background-color: Black;' cellpadding='4' cellspacing='4'><tr><td>";
    var end = "</td></tr></table>";
    var imgname = "";
    var pStatus = "N";
    for (i = 0; i < Len; i++) {
        if (IsValied(s.charAt(i))) {
            pStatus = "Y";
            if (s.charAt(i) == ".") {
                imgname += "<img src='../DigitalNumber/dgdot.gif' />";
            }
            else if (s.charAt(i) == ",") {
            imgname += "<img style='padding-top:15px;' src='../DigitalNumber/dgComma.gif' />";
            }
            else {
                imgname += "<img src='../DigitalNumber/dg" + s.charAt(i) + ".gif' />";
            }
        }
        else {
            pStatus = "N";
            row.innerHTML = "";
            return;
        }
    }
    if (pStatus == "Y") {
        row.innerHTML = str + imgname + end;
    }
}
function IsValied(obj) {
    switch (obj) {
        case "1":
        case "2":
        case "3":
        case "4":
        case "5":
        case "6":
        case "7":
        case "8":
        case "9":
        case "0":
        case ".":
        case ",":
            return true;
        default:
            return false;
    }
}


/* new code*/

//function Showmenu() {
//    if (document.getElementById('Attuneheader_menu').style.display == 'block' || document.getElementById('Attuneheader_menu').style.display=="")
//        document.getElementById('Attuneheader_menu').style.display = 'none';
//    else
//        document.getElementById('Attuneheader_menu').style.display = 'block';

//    return false;
//}
//function Showhide() {
//    if (document.getElementById('showmenu').src.split('Images')[1] == '/show.png')
//        document.getElementById('showmenu').src = '../PlatForm/Images/hide.png';
//    else if (document.getElementById('showmenu').src.split('Images')[1] == '/hide.png')
//        document.getElementById('showmenu').src = '../PlatForm/Images/show.png';

//}

function Showmenu() {
    if (document.getElementById('Attuneheader_menu').style.display == 'block' || document.getElementById('Attuneheader_menu').style.display == "") {
        document.getElementById('Attuneheader_menu').style.display = 'none';
        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE ");
        if (msie > 0)      // If Internet Explorer, return version number
        {
            if (document.getElementById('Qualification1_col2') != null) {
                document.getElementById('Qualification1_col2').style.width = '50.5%';
            }
        }
        else                 // If another browser, return 0
        {
            if (document.getElementById('Qualification1_col2') != null) {
                document.getElementById('Qualification1_col2').style.width = '52.5%';
            }
        }
    }
    else {
        document.getElementById('Attuneheader_menu').style.display = 'block';
        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE ");
        if (msie > 0)      // If Internet Explorer, return version number
        {
            if (document.getElementById('Qualification1_col2') != null) {
                document.getElementById('Qualification1_col2').style.width = '50.5%';
            }
        }
        else                 // If another browser, return 0
        {
            if (document.getElementById('Qualification1_col2') != null) {
                document.getElementById('Qualification1_col2').style.width = '50.5%';
            }
        }
    }
    return false;
}

function Showhide() {

    if (document.getElementById('showmenu').src.split('Images')[1] == '/show.png') {
        document.getElementById('showmenu').src = '../PlatForm/Images/hide.png';
        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE ");
        if (msie > 0)      // If Internet Explorer, return version number
        {
            if (document.getElementById('Qualification1_col2') != null) {
                document.getElementById('Qualification1_col2').style.width = '50.5%';
            }
        }
        else                 // If another browser, return 0
        {
            if (document.getElementById('Qualification1_col2') != null) {
                document.getElementById('Qualification1_col2').style.width = '52.5%';
            }
        }
    }
    else if (document.getElementById('showmenu').src.split('Images')[1] == '/hide.png') {
        document.getElementById('showmenu').src = '../PlatForm/Images/show.png';
        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE ");
        if (msie > 0)      // If Internet Explorer, return version number
        {
            if (document.getElementById('Qualification1_col2') != null) {
                document.getElementById('Qualification1_col2').style.width = '50.5%';
            }
        }
        else                 // If another browser, return 0
        {
            if (document.getElementById('Qualification1_col2') != null) {
                document.getElementById('Qualification1_col2').style.width = '50.5%';
            }
        }
    }

}

/* End */

//function countAge(id) {
//    if (document.getElementById(id).value != '') {
//        bD = document.getElementById(id).value.split('/');
//        var agetemp = 0;
//        dd = bD[0];
//        mm = bD[1];
//        yy = bD[2];
//        main = "valid";
//        if ((dd == "__") || (mm == "__") || (yy == "____")) {
//            document.getElementById('txtAge').value = '';
//            return false;
//        }
//        if ((mm < 1) || (mm > 12) || (dd < 1) || (dd > 31) || (yy < 1) || (mm == "") || (dd == "") || (yy == ""))
//            main = "Invalid";
//        else
//            if (((mm == 4) || (mm == 6) || (mm == 9) || (mm == 11)) && (dd > 30))
//            main = "Invalid";
//        else
//            if (mm == 2) {
//            if (dd > 29)
//                main = "Invalid";
//            else if ((dd > 28) && (!lyear(yy)))
//                main = "Invalid";
//        }
//        else
//            if ((yy > 9999) || (yy < 0))
//            main = "Invalid";
//        else
//            main = main;
//        if (main == "valid") {
//            function leapyear(a) {
//                if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0))
//                    return true;
//                else
//                    return false;
//            }
//            var days = GetServerDate();

//            var gdate = days.getDate();
//            var gmonth = days.getMonth();
//            var gyear = days.getFullYear();
//            age = gyear - yy;
//            if ((mm == (gmonth + 1)) && (dd <= parseInt(gdate))) {
//                age = age;
//            }
//            else {
//                if (mm <= (gmonth)) {
//                    age = age;
//                }
//                else {
//                    age = age - 1;
//                }
//            }
//            if (age == 0)
//                age = age;
//            agetemp = age;
//            if (mm <= (gmonth + 1))
//                age = age - 1;
//            if ((mm == (gmonth + 1)) && (dd > parseInt(gdate)))
//                age = age + 1;
//            var m;
//            var n;
//            if (mm == 12) { n = 31 - dd; }
//            if (mm == 11) { n = 61 - dd; }
//            if (mm == 10) { n = 92 - dd; }
//            if (mm == 9) { n = 122 - dd; }
//            if (mm == 8) { n = 153 - dd; }
//            if (mm == 7) { n = 184 - dd; }
//            if (mm == 6) { n = 214 - dd; }
//            if (mm == 5) { n = 245 - dd; }
//            if (mm == 4) { n = 275 - dd; }
//            if (mm == 3) { n = 306 - dd; }
//            if (mm == 2) { n = 334 - dd; if (leapyear(yy)) n = n + 1; }
//            if (mm == 1) { n = 365 - dd; if (leapyear(yy)) n = n + 1; }
//            if (gmonth == 1) m = 31;
//            if (gmonth == 2) { m = 59; if (leapyear(gyear)) m = m + 1; }
//            if (gmonth == 3) { m = 90; if (leapyear(gyear)) m = m + 1; }
//            if (gmonth == 4) { m = 120; if (leapyear(gyear)) m = m + 1; }
//            if (gmonth == 5) { m = 151; if (leapyear(gyear)) m = m + 1; }
//            if (gmonth == 6) { m = 181; if (leapyear(gyear)) m = m + 1; }
//            if (gmonth == 7) { m = 212; if (leapyear(gyear)) m = m + 1; }
//            if (gmonth == 8) { m = 243; if (leapyear(gyear)) m = m + 1; }
//            if ((gmonth+1) == 9) { m = 273; if (leapyear(gyear)) m = m + 1; }
//            if (gmonth == 10) { m = 304; if (leapyear(gyear)) m = m + 1; }
//            if (gmonth == 11) { m = 334; if (leapyear(gyear)) m = m + 1; }
//            if (gmonth == 12) { m = 365; if (leapyear(gyear)) m = m + 1; }
//            totdays = (parseInt(age) * 365);
//            totdays += age / 4;
//            totdays = parseInt(totdays) + gdate + m + n;
//            months = age * 12;
//            months += 12 - parseInt(mm);
//            months += gmonth;
//            if (gmonth == 1) p = 31 + gdate;
//            if (gmonth == 2) { p = 59 + gdate; if (leapyear(gyear)) m = m + 1; }
//            if (gmonth == 3) { p = 90 + gdate; if (leapyear(gyear)) p = p + 1; }
//            if (gmonth == 4) { p = 120 + gdate; if (leapyear(gyear)) p = p + 1; }
//            if (gmonth == 5) { p = 151 + gdate; if (leapyear(gyear)) p = p + 1; }
//            if (gmonth == 6) { p = 181 + gdate; if (leapyear(gyear)) p = p + 1; }
//            if (gmonth == 7) { p = 212 + gdate; if (leapyear(gyear)) p = p + 1; }
//            if (gmonth == 8) { p = 243 + gdate; if (leapyear(gyear)) p = p + 1; }
//            if (gmonth == 9) { p = 273 + gdate; if (leapyear(gyear)) p = p + 1; }
//            if (gmonth == 10) { p = 304 + gdate; if (leapyear(gyear)) p = p + 1; }
//            if (gmonth == 11) { p = 334 + gdate; if (leapyear(gyear)) p = p + 1; }
//            if (gmonth == 12) { p = 365 + gdate; if (leapyear(gyear)) p = p + 1; }
//            weeks = totdays / 7;
//            weeks += " weeks";
//            weeks = parseInt(weeks);
//            if (agetemp <= 0) {
//                if (months <= 0) {
//                    if (weeks <= 0) {
//                        if (totdays >= 0) {
//                            if (totdays == 1)
//                                document.getElementById('txtDOBNos').value = totdays + ' day ';
//                            else
//                                document.getElementById('txtDOBNos').value = totdays + ' days ';
//                        }
//                    }
//                    else {
//                        if (weeks == 1)
//                            document.getElementById('txtDOBNos').value = weeks + ' Week';
//                        else
//                            document.getElementById('txtDOBNos').value = weeks + ' Weeks';
//                    }
//                }
//                else {
//                    if (months == 1)
//                        document.getElementById('txtDOBNos').value = months + ' Month';
//                    else
//                        document.getElementById('txtDOBNos').value = months + ' Months';
//                }
//            }
//            else {
//                if (agetemp == 1)
//                    document.getElementById('txtDOBNos').value = agetemp + ' year';
//                else
//                    document.getElementById('txtDOBNos').value = agetemp + ' years';
//            }

//            function lyear(a) {
//                if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0)) return true;
//                else return false;
//            }
//        }
//        else {
//            alert(main + ' Date');
//            document.getElementById('txtDOBNos').value = '';
//            document.getElementById('tDOB').value = '__/__/____';
//            document.getElementById('tDOB').focus();
//        }
//    }
//}

function validateNaN(evt) {
    //validateNaN validates for Number and does allow others including dot(.)
    var keyCode = 0;
    if (evt) {
        keyCode = evt.keyCode || evt.which;
    }
    else {
        keyCode = window.event.keyCode;
    }
    //alert('keyCode  : ' + keyCode);
    if ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105) || (keyCode == 8) || (keyCode == 9) || (keyCode == 12) || (keyCode == 27) || (keyCode == 37) || (keyCode == 39) || (keyCode == 46)) {
        return true;
    }
    else {
        return false;
    }

    //    var keyCode = evt.which ? evt.which : evt.keyCode;
    //    return keyCode < '0'.charCodeAt() || keyCode > '9'.charCodeAt();
    // excluded Num(.)(keyCode == 110) Alp (.) || (keyCode == 190)
}

function CheckIfEmpty(id, CheckID) {
    var x = id.split("_");
    //alert(document.getElementById().option[document.getElementById(x[0] + "_ddlstatus").value].text);

    //    alert(document.getElementById(x[0] + "_ddlstatus").options[document.getElementById(x[0] + "_ddlstatus").selectedIndex].text);
    var CompareString = document.getElementById(x[0] + "_ddlstatus").options[document.getElementById(x[0] + "_ddlstatus").selectedIndex].text;
    if (CompareString == "Completed") {
        if (document.getElementById(x[0] + "_" + CheckID) != undefined) {
            if ((document.getElementById(x[0] + "_" + CheckID).value == '') || (document.getElementById(x[0] + "_" + CheckID).value == '0')) {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_122") == null ? "No Value Entered, Please Check Investigation status" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_122");
 var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
                var len = document.getElementById(x[0] + "_ddlstatus").options.length;
                var drpdwn = document.getElementById(x[0] + "_ddlstatus");
                var isCompletedExists = 'false';
                var CompletedValue = 0;
                var PendingValue = 0;
                for (var i = 0; i < len; i++) {
                    if (drpdwn.options[i].text == 'Completed') {
                        isCompletedExists = 'true';
                        CompletedValue = drpdwn.options[i].value;
                    }
                    if (drpdwn.options[i].text == 'Pending') {

                        PendingValue = drpdwn.options[i].value;
                    }
                }
                document.getElementById(x[0] + "_ddlstatus").value = PendingValue;
                return false;
                
            }
        }
        // else if (document.getElementById(x[0] + "_" + CheckID).options[document.getElementById(x[0] + "_" + CheckID).selectedIndex].text == 'Select') {
        // }
    }
}
function CheckIfEmpty1(id, ddlID, txtid) {
    var x = id.split("_"); var CompareString = document.getElementById(x[0] + "_ddlstatus").options[document.getElementById(x[0] + "_ddlstatus").selectedIndex].text;
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
    if (CompareString == "Completed") {
        if (txtid != '0') {
            if (document.getElementById(x[0] + "_" + txtid) != undefined && document.getElementById(x[0] + "_" + ddlID) != undefined) {
                if (((document.getElementById(x[0] + "_" + txtid).value == '') || (document.getElementById(x[0] + "_" + txtid).value == '0'))
        && document.getElementById(x[0] + "_" + ddlID).options[document.getElementById(x[0] + "_" + ddlID).selectedIndex].value == '0') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_122") == null ? "No Value Entered, Please Check Investigation status" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_122");
 ValidationWindow(userMsg, errorMsg);
                    var len = document.getElementById(x[0] + "_ddlstatus").options.length;
                    var drpdwn = document.getElementById(x[0] + "_ddlstatus");
                    var isCompletedExists = 'false';
                    var CompletedValue = 0;
                    var PendingValue = 0;
                    for (var i = 0; i < len; i++) {
                        if (drpdwn.options[i].text == 'Completed') {
                            isCompletedExists = 'true';
                            CompletedValue = drpdwn.options[i].value;
                        }
                        if (drpdwn.options[i].text == 'Pending') {

                            PendingValue = drpdwn.options[i].value;
                        }
                    }
                    //  document.getElementById(x[0] + "_ddlstatus").value = PendingValue;

                }
            }
        }
        else {
            if (document.getElementById(x[0] + "_" + txtid) != undefined && document.getElementById(x[0] + "_" + ddlID) != undefined) {
                if (document.getElementById(x[0] + "_" + ddlID).options[document.getElementById(x[0] + "_" + ddlID).selectedIndex].value == '0') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_122") == null ? "No Value Entered, Please Check Investigation status" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_122");
 ValidationWindow(userMsg, errorMsg);
                    var len = document.getElementById(x[0] + "_ddlstatus").options.length;
                    var drpdwn = document.getElementById(x[0] + "_ddlstatus");
                    var isCompletedExists = 'false';
                    var CompletedValue = 0;
                    var PendingValue = 0;
                    for (var i = 0; i < len; i++) {
                        var drpdwnVal = drpdwn.options[i].value.split("_");
                        //if (drpdwn.options[i].text == 'Completed') {
                        if (drpdwnVal[0] == 'Completed') {
                            isCompletedExists = 'true';
                            //CompletedValue = drpdwn.options[i].value;
                            CompletedValue = drpdwnVal[1];
                        }
                        //if (drpdwn.options[i].text == 'Pending') {
                        if (drpdwnVal[0] == 'Pending') {
                            PendingValue = drpdwn.options[i].value;
                        }
                    }
                    try {

                        if (document.getElementById('hdnstatuschange').value != 'Y') {
                            document.getElementById(x[0] + "_ddlstatus").value = PendingValue;
                            document.getElementById(ddlId).value = PendingValue;
                        }
                        else {
                        }

                    }
                    catch (e) {
                    }

                }
            }
        }
    }
}



function ChangeStatus(GrpName, ddlID) {
    //alert(document.getElementById('hdnGroupCollection').value);
    //alert(ddlID);
    var count = document.getElementById('hdnGroupCollection').value;
    var len = count.split('^');
    var k = 0;
    var tblGrpStatusReason1 = "tblGrpStatusReason1" + ddlID;
    var tblGrpStatusReason2 = "tblGrpStatusReason2" + ddlID;
    var tblGrpStatusOpinion1 = "tblGrpStatusOpinion1" + ddlID;
    var tblGrpStatusOpinion2 = "tblGrpStatusOpinion2" + ddlID;
    for (var i = 0; i < len.length; i++) {
        if (len[i] != "") {
            var ctrlID = len[i].split('|');
            if (GrpName == ctrlID[1]) {
                var drpdwn = document.getElementById(ddlID);
                var ddldwn = document.getElementById(ctrlID[2]);
                var length = document.getElementById(ctrlID[2]).options.length;
                //                        alert(drpdwn.options[drpdwn.selectedIndex].text);
                var status = drpdwn.options[drpdwn.selectedIndex].text;
                var CompletedValue = 0;
                for (var j = 0; j < length; j++) {
                    if (ddldwn.options[j].text == status) {
                        CompletedValue = ddldwn.options[j].value;
                        document.getElementById(ctrlID[2]).value = CompletedValue;
                        CheckIfEmpty(ctrlID[2], 'txtValue');
                        CheckIfEmpty1(ctrlID[2], 'ddlData', '0');
                        var PrefixID = ctrlID[2].split('_');
                        var tdInvStatusReason1 = PrefixID[0] + "_tdInvStatusReason1";
                        var tdInvStatusReason2 = PrefixID[0] + "_tdInvStatusReason2";
                        var tdInvStatusOpinion1 = PrefixID[0] + "_tdInvStatusOpinion1";
                        var tdInvStatusOpinion2 = PrefixID[0] + "_tdInvStatusOpinion2";
                        var newListItem = "";
                        var newListItem1 = "";
                        //var lstReason = JSON.parse($('input[id$="hdnlstreasons"]').val());

                        var ddlReason = PrefixID[0] + "_ddlStatusReason";
                        var deptlstReason = "ddlGrpReason" + ddlID;
                        document.getElementById(ddlReason).options.length = 1;
                        //document.getElementById(deptlstReason).options.length = 1;
                        //                        $.each(lstReason, function(i, obj) {
                        //                            if (obj.StatusID == CompletedValue) {

                        //                                deptListItem = document.createElement("option");
                        //                                //document.getElementById(deptlstReason).options.add(deptListItem);
                        //                                deptListItem.text = obj.ReasonDesc;
                        //                                deptListItem.value = obj.ReasonID;

                        //                                newListItem = document.createElement("option");
                        //                                document.getElementById(ddlReason).options.add(newListItem);
                        //                                newListItem.text = obj.ReasonDesc;
                        //                                newListItem.value = obj.ReasonID;
                        //                            }
                        //                        });

                        if (status == "Reject") {
                            document.getElementById(tdInvStatusReason1).style.display = "block";
                            document.getElementById(tdInvStatusReason2).style.display = "block";
                            document.getElementById(tdInvStatusOpinion1).style.display = "none";
                            document.getElementById(tdInvStatusOpinion2).style.display = "none";
                            if (k == 0) {
                                document.getElementById(tblGrpStatusReason1).style.display = "block";
                                document.getElementById(tblGrpStatusReason2).style.display = "block";
                                document.getElementById(tblGrpStatusOpinion1).style.display = "none";
                                document.getElementById(tblGrpStatusOpinion2).style.display = "none";
                                k = 1;
                            }
                        }
                        else if (status == "With Held") {
                            document.getElementById(tdInvStatusReason1).style.display = "block";
                            document.getElementById(tdInvStatusReason2).style.display = "block";
                            document.getElementById(tdInvStatusOpinion1).style.display = "none";
                            document.getElementById(tdInvStatusOpinion2).style.display = "none";
                            if (k == 0) {
                                document.getElementById(tblGrpStatusReason1).style.display = "block";
                                document.getElementById(tblGrpStatusReason2).style.display = "block";
                                document.getElementById(tblGrpStatusOpinion1).style.display = "none";
                                document.getElementById(tblGrpStatusOpinion2).style.display = "none";
                                k = 1;
                            }
                        }
                        else if (status == "Co-authorize") {
                            document.getElementById(tdInvStatusReason1).style.display = "none";
                            document.getElementById(tdInvStatusReason2).style.display = "none";
                            document.getElementById(tdInvStatusOpinion1).style.display = "block";
                            document.getElementById(tdInvStatusOpinion2).style.display = "block";
                            if (k == 0) {
                                document.getElementById(tblGrpStatusReason1).style.display = "none";
                                document.getElementById(tblGrpStatusReason2).style.display = "none";
                                document.getElementById(tblGrpStatusOpinion1).style.display = "block";
                                document.getElementById(tblGrpStatusOpinion2).style.display = "block";
                                k = 1;
                            }
                        }
                        else {
                            if (document.getElementById(tblGrpStatusReason1) != null) {
                                document.getElementById(tdInvStatusReason1).style.display = "none";
                                document.getElementById(tdInvStatusReason2).style.display = "none";
                                document.getElementById(tdInvStatusOpinion1).style.display = "none";
                                document.getElementById(tdInvStatusOpinion2).style.display = "none";
                                if (k == 0) {
                                    document.getElementById(tblGrpStatusReason1).style.display = "none";
                                    document.getElementById(tblGrpStatusReason2).style.display = "none";
                                    document.getElementById(tblGrpStatusOpinion1).style.display = "none";
                                    document.getElementById(tblGrpStatusOpinion2).style.display = "none";
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return true;
}

function ChangeGroupStatus(GrpName, ddlID) {
    try {
        var count = document.getElementById('hdnGroupCollection').value;
        var lstGrpDetails = count.split('$');
        var isSameGroup = false;
        if (lstGrpDetails != null && lstGrpDetails.length > 0) {
            for (var g = 0; g < lstGrpDetails.length; g++) {
                isSameGroup = false;
                var GrpDetails = lstGrpDetails[g].split('#');
                if (GrpDetails != null && GrpDetails.length > 1) {
                    var isSameStatus = false;
                    var sameStatusValue = "Completed";
                    var pendingValue = "Pending";
                    var len = GrpDetails[1].split('^');
                    for (var i = 0; i < len.length; i++) {
                        if (len[i] != "") {
                            var ctrlID = len[i].split('|');
                            if (GrpName == ctrlID[1]) {
                                isSameGroup = true;
                                var drpdwn = document.getElementById(ddlID);
                                var ddldwn = document.getElementById(ctrlID[2]);
                                var status = drpdwn.options[drpdwn.selectedIndex].text;
                                statusValue = drpdwn.options[drpdwn.selectedIndex].value;
                                var othersStatusValue = ddldwn.options[ddldwn.selectedIndex].value;
                                if (othersStatusValue == statusValue) {
                                    //sameStatusValue = status;
                                    isSameStatus = true;
                                }
                                else {
                                    isSameStatus = false;
                                    break;
                                }
                            }
                        }
                    }
                    if (isSameGroup) {
                        if (isSameStatus) {
                            document.getElementById(GrpDetails[0]).value = sameStatusValue;
                        }
                        else {
                            document.getElementById(GrpDetails[0]).value = pendingValue;
                        }
                    }
                }
            }
        }
    }
    catch (e) {
    }
}

/* Function to Suppress F5 based Refresh. This can be called in individual pages in the 'onkeydown' event of Body / Form */
function SuppressBrowserRefresh(e) {
    if (e != undefined) {
        var keycode = (window.event) ? event.keyCode : e.keyCode;
        if (Number(keycode) == Number(116)) {
            //alert("Doing browser refresh may cause loss or unstable data. Please be sure before continuing");
            event.keyCode = 0;
            event.returnValue = false;
            return false;
        }
    }
}
/* Function to Suppress Backspace based Refresh. This can be called in individual pages in the 'onkeydown' event of Body / Form */
function SuppressBrowserBackspaceRefresh(e) {
    var keycode = (window.event) ? event.keyCode : e.keyCode;
    if (keycode == 8) {
        //alert("Doing browser refresh may cause loss or unstable data. Please be sure before continuing");
        event.keyCode = 0;
        //event.returnValue = true;
        return false;
    }
}

/* The below will suppress F5 based refresh for the whole application. This will work well for IE and partially for Firefox;
Need to do some more R & D to make it all browser compatible */
//document.attachEvent("onkeydown", SuppressBrowserRefresh);



function ChangeDeptStatus(GrpName, ddlID) {
    //alert(document.getElementById('hdnGroupCollection').value);
    //alert(ddlID);
    var count = document.getElementById('hdnGroupCollection').value;
    var tblStatusReason1 = "tblStatusReason1" + ddlID;
    var tblStatusReason2 = "tblStatusReason2" + ddlID;
    var tblStatusOpinion1 = "tblStatusOpinion1" + ddlID;
    var tblStatusOpinion2 = "tblStatusOpinion2" + ddlID;
    var len = count.split('^');
    var k = 0;
    for (var i = 0; i < len.length; i++) {
        if (len[i] != "") {
            var ctrlID = len[i].split('|');
            if (GrpName == ctrlID[0]) {
                var drpdwn = document.getElementById(ddlID);
                var ddldwn = document.getElementById(ctrlID[2]);
                var length = document.getElementById(ctrlID[2]).options.length;
                //                        alert(drpdwn.options[drpdwn.selectedIndex].text);
                var status = drpdwn.options[drpdwn.selectedIndex].text;
                var CompletedValue = 0;
                for (var j = 0; j < length; j++) {
                    if (ddldwn.options[j].text == status) {
                        CompletedValue = ddldwn.options[j].value;

                        var PrefixID = ctrlID[2].split('_');
                        var tdInvStatusReason1 = PrefixID[0] + "_tdInvStatusReason1";
                        var tdInvStatusReason2 = PrefixID[0] + "_tdInvStatusReason2";
                        var tdInvStatusOpinion1 = PrefixID[0] + "_tdInvStatusOpinion1";
                        var tdInvStatusOpinion2 = PrefixID[0] + "_tdInvStatusOpinion2";


                        var newListItem = "";
                        var newListItem1 = "";
                        var lstReason = JSON.parse($('input[id$="hdnlstreasons"]').val());

                        var ddlReason = PrefixID[0] + "_ddlStatusReason";
                        var deptlstReason = "ddlReason" + ddlID;
                        document.getElementById(ddlReason).options.length = 1;
                        document.getElementById(deptlstReason).options.length = 1;
                        $.each(lstReason, function(i, obj) {
                            if (obj.StatusID == CompletedValue) {

                                newListItem = document.createElement("option");
                                document.getElementById(ddlReason).options.add(newListItem);
                                newListItem.text = obj.ReasonDesc;
                                newListItem.value = obj.ReasonID;

                                deptListItem = document.createElement("option");
                                document.getElementById(deptlstReason).options.add(deptListItem);
                                deptListItem.text = obj.ReasonDesc;
                                deptListItem.value = obj.ReasonID;
                            }
                        });
                        //                        $.each(lstReason, function(i, obj) {
                        //                            if (obj.StatusID == CompletedValue) {

                        //                                newListItem1 = document.createElement("option");
                        //                                document.getElementById(deptlstReason).options.add(newListItem1);
                        //                                newListItem1.text = obj.ReasonDesc;
                        //                                newListItem1.value = obj.ReasonID;

                        //                            }
                        //                        });
                        //  document.getElementById(tdInvStatusReason1).DataSource = newListItem;

                        document.getElementById(ctrlID[2]).value = CompletedValue;

                        if (CompletedValue == 3 && ddldwn.options[j].innerHTML == "Reject") {

                            document.getElementById(tdInvStatusReason1).style.display = "block";
                            document.getElementById(tdInvStatusReason2).style.display = "block";
                            document.getElementById(tdInvStatusOpinion1).style.display = "none";
                            document.getElementById(tdInvStatusOpinion2).style.display = "none";
                            if (k == 0) {
                                document.getElementById(tblStatusReason1).style.display = "block";
                                document.getElementById(tblStatusReason2).style.display = "block";
                                document.getElementById(tblStatusOpinion1).style.display = "none";
                                document.getElementById(tblStatusOpinion2).style.display = "none";
                                k = 1;
                            }
                        }
                        else if (CompletedValue == 8 && ddldwn.options[j].innerHTML == "With Held") {
                            document.getElementById(tdInvStatusReason1).style.display = "block";
                            document.getElementById(tdInvStatusReason2).style.display = "block";
                            document.getElementById(tdInvStatusOpinion1).style.display = "none";
                            document.getElementById(tdInvStatusOpinion2).style.display = "none";
                            if (k == 0) {
                                document.getElementById(tblStatusReason1).style.display = "block";
                                document.getElementById(tblStatusReason2).style.display = "block";
                                document.getElementById(tblStatusOpinion1).style.display = "none";
                                document.getElementById(tblStatusOpinion2).style.display = "none";
                                k = 1;
                            }
                        }
                        else if (CompletedValue == 6 && ddldwn.options[j].innerHTML == "Co-authorize") {
                            document.getElementById(tdInvStatusReason1).style.display = "none";
                            document.getElementById(tdInvStatusReason2).style.display = "none";
                            document.getElementById(tdInvStatusOpinion1).style.display = "block";
                            document.getElementById(tdInvStatusOpinion2).style.display = "block";
                            if (k == 0) {
                                document.getElementById(tblStatusReason1).style.display = "none";
                                document.getElementById(tblStatusReason2).style.display = "none";
                                document.getElementById(tblStatusOpinion1).style.display = "block";
                                document.getElementById(tblStatusOpinion2).style.display = "block";
                                k = 1;
                            }
                        }
                        else {
                            document.getElementById(tdInvStatusReason1).style.display = "none";
                            document.getElementById(tdInvStatusReason2).style.display = "none";
                            document.getElementById(tdInvStatusOpinion1).style.display = "none";
                            document.getElementById(tdInvStatusOpinion2).style.display = "none";
                            if (k == 0) {
                                if (document.getElementById(tblStatusReason1) != null) {
                                    document.getElementById(tblStatusReason1).style.display = "none";
                                    document.getElementById(tblStatusReason2).style.display = "none";
                                    document.getElementById(tblStatusOpinion1).style.display = "none";
                                    document.getElementById(tblStatusOpinion2).style.display = "none";
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return true;
}

function isNumerics(e, Id) {
    var key; var isCtrl;

    if (window.event) {
        key = window.event.keyCode;
        if (window.event.shiftKey) {
            isCtrl = false;
        }
        else {
            if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190)) {
                isCtrl = true;
            }
            else {
                if ((key >= 185 && key <= 192) || (key >= 218 && key <= 222))
                    isCtrl = false;
            }
        }
    } return isCtrl;
}
function isNumericss(e, Id) {

    var key; var isCtrl; var flag = 0;
    var txtVal = document.getElementById(Id).value.trim();
    var len = txtVal.split('.');
    if (len.length > 1) {
        flag = 1;
    }
    if (window.event) {
        key = window.event.keyCode;
        if (window.event.shiftKey) {
            isCtrl = false;
        }
        else {
            if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                isCtrl = true;
            }
            else {
                isCtrl = false;
            }
        }
    } return isCtrl;
}

function AutoTextboxExpand(me) {
    // alert(me);
    boxValue = me.value.length;
    // alert(boxValue);
    boxSize = me.size;
    minNum = 20;
    maxNum = 500;


    if (boxValue > minNum) {
        me.size = boxValue
    }
    else
        if (boxValue < minNum || boxValue != minNum) {
        me.size = minNum
    }
}
function expandDropDownList(elementRef) {
    elementRef.style.width = '200px';
}

function collapseDropDownList(elementRef) {
    elementRef.style.width = elementRef.normalWidth;
}

//function GetCheckCode(codeType, TextBoxID) {
//    var txtValue = document.getElementById(TextBoxID).value;
//    WebService.GetCheckCode(codeType, txtValue, onCheckCount);
//}

//function onCheckCount(count) {
//    if (count > 0) {
//        alert("This Code Already Exists");
//        return false;
//    }
//}

function ShowStatusReason(id) {
    var x = id.split("_");
    var CompareString = document.getElementById(x[0] + "_ddlstatus").options[document.getElementById(x[0] + "_ddlstatus").selectedIndex].text;
    var CompareValue = document.getElementById(x[0] + "_ddlstatus").options[document.getElementById(x[0] + "_ddlstatus").selectedIndex].value;
    var TDInvStatusReason1 = x[0] + '_tdInvStatusReason1';
    var TDInvStatusReason2 = x[0] + '_tdInvStatusReason2';
    var TDInvStatusOpinion1 = x[0] + '_tdInvStatusOpinion1';
    var TDInvStatusOpinion2 = x[0] + '_tdInvStatusOpinion2';
    if (CompareString == "Reject") {
        document.getElementById(TDInvStatusReason1).style.display = "block";
        document.getElementById(TDInvStatusReason2).style.display = "block";
    }
    else if (CompareString == "With Held") {
        document.getElementById(TDInvStatusReason1).style.display = "block";
        document.getElementById(TDInvStatusReason2).style.display = "block";
    }
    else if (CompareString == "Co-authorize" && CompareValue != '1') {
        document.getElementById(TDInvStatusOpinion1).style.display = "block";
        document.getElementById(TDInvStatusOpinion2).style.display = "block";
    }
    else {
        document.getElementById(TDInvStatusReason1).style.display = "none";
        document.getElementById(TDInvStatusReason2).style.display = "none";
        document.getElementById(TDInvStatusOpinion1).style.display = "none";
        document.getElementById(TDInvStatusOpinion2).style.display = "none";
    }
}
function ChangeDeptStatusReason(GrpName, ddlID) {
    //alert(document.getElementById('hdnGroupCollection').value);
    //alert(ddlID);
    var count = document.getElementById('hdnGroupCollection').value;
    var len = count.split('^');
    for (var i = 0; i < len.length; i++) {
        if (len[i] != "") {
            var ctrlID = len[i].split('|');
            if (GrpName == ctrlID[0]) {
                var drpdwn = document.getElementById(ddlID);
                var ddldwn = document.getElementById(ctrlID[2]);

                var PrefixID = ctrlID[2].split('_');
                var ddlStatusReason = PrefixID[0] + "_ddlStatusReason";
                var ddldwn = document.getElementById(ddlStatusReason);
                var length = document.getElementById(ddlStatusReason).options.length;
                //                        alert(drpdwn.options[drpdwn.selectedIndex].text);
                var status = drpdwn.options[drpdwn.selectedIndex].text;
                var CompletedValue = 0;
                for (var j = 0; j < length; j++) {
                    if (ddldwn.options[j].text == status) {
                        CompletedValue = ddldwn.options[j].value;
                        document.getElementById(ddlStatusReason).value = CompletedValue;

                    }
                }
            }
        }
    }
    return true;
}
function ChangeDeptStatusOpinion(GrpName, ddlID) {
    //alert(document.getElementById('hdnGroupCollection').value);
    //alert(ddlID);
    var count = document.getElementById('hdnGroupCollection').value;
    var len = count.split('^');
    for (var i = 0; i < len.length; i++) {
        if (len[i] != "") {
            var ctrlID = len[i].split('|');
            if (GrpName == ctrlID[0]) {
                var drpdwn = document.getElementById(ddlID);
                var ddldwn = document.getElementById(ctrlID[2]);

                var PrefixID = ctrlID[2].split('_');
                var ddlOpinionUser = PrefixID[0] + "_ddlOpinionUser";
                var ddldwn = document.getElementById(ddlOpinionUser);
                var length = document.getElementById(ddlOpinionUser).options.length;
                //                        alert(drpdwn.options[drpdwn.selectedIndex].text);
                var status = drpdwn.options[drpdwn.selectedIndex].text;
                var CompletedValue = 0;
                for (var j = 0; j < length; j++) {
                    if (ddldwn.options[j].text == status) {
                        CompletedValue = ddldwn.options[j].value;
                        document.getElementById(ddlOpinionUser).value = CompletedValue;

                    }
                }
            }
        }
    }
    return true;
}
function ChangeGrpStatusReason(GrpName, ddlID) {
    //alert(document.getElementById('hdnGroupCollection').value);
    //alert(ddlID);
    var count = document.getElementById('hdnGroupCollection').value;
    var len = count.split('^');
    for (var i = 0; i < len.length; i++) {
        if (len[i] != "") {
            var ctrlID = len[i].split('|');
            if (GrpName == ctrlID[1]) {
                var drpdwn = document.getElementById(ddlID);
                var ddldwn = document.getElementById(ctrlID[2]);

                var PrefixID = ctrlID[2].split('_');
                var ddlStatusReason = PrefixID[0] + "_ddlStatusReason";
                var ddldwn = document.getElementById(ddlStatusReason);
                var length = document.getElementById(ddlStatusReason).options.length;
                //                        alert(drpdwn.options[drpdwn.selectedIndex].text);
                var status = drpdwn.options[drpdwn.selectedIndex].text;
                var CompletedValue = 0;
                for (var j = 0; j < length; j++) {
                    if (ddldwn.options[j].text == status) {
                        CompletedValue = ddldwn.options[j].value;
                        document.getElementById(ddlStatusReason).value = CompletedValue;

                    }
                }
            }
        }
    }
    return true;
}
function ChangeGrpStatusOpinion(GrpName, ddlID) {
    //alert(document.getElementById('hdnGroupCollection').value);
    //alert(ddlID);
    var count = document.getElementById('hdnGroupCollection').value;
    var len = count.split('^');
    for (var i = 0; i < len.length; i++) {
        if (len[i] != "") {
            var ctrlID = len[i].split('|');
            if (GrpName == ctrlID[1]) {
                var drpdwn = document.getElementById(ddlID);
                var ddldwn = document.getElementById(ctrlID[2]);

                var PrefixID = ctrlID[2].split('_');
                var ddlOpinionUser = PrefixID[0] + "_ddlOpinionUser";
                var ddldwn = document.getElementById(ddlOpinionUser);
                var length = document.getElementById(ddlOpinionUser).options.length;
                //                        alert(drpdwn.options[drpdwn.selectedIndex].text);
                var status = drpdwn.options[drpdwn.selectedIndex].text;
                var CompletedValue = 0;
                for (var j = 0; j < length; j++) {
                    if (ddldwn.options[j].text == status) {
                        CompletedValue = ddldwn.options[j].value;
                        document.getElementById(ddlOpinionUser).value = CompletedValue;

                    }
                }
            }
        }
    }
    return true;
}
function ChangeDDLItemListWidth() {
	try{
    var vVersion = parseInt($.browser.version, 10);
    if ($.browser.msie && vVersion < 9) {
        var fnExpand = function() {
            var vIsExpanded = $(this).data("expanded");

            if (!vIsExpanded) {
                var vTrueWidth = $(this).outerWidth();
                var vCssWidth = $(this).css("width");

                if (vCssWidth != "auto" && vCssWidth != "") {
                    $(this).data("origWidth", vTrueWidth + "px");
                    $(this).css("width", "auto");

                    if ($(this).outerWidth() < vTrueWidth)
                        $(this).css("width", vTrueWidth + "px");
                }

                $(this).data("expanded", true);
            }
        };

        var fnCollapse = function() {
            var vIsExpanded = $(this).data("expanded");
            if (vIsExpanded) {
                $(this).css("width", $(this).data("origWidth"));
                $(this).data("expanded", false);
            }
        };

        $(".richcombobox select")
			.bind('focus', fnExpand)
			.bind('mousedown', fnExpand)
			.bind('blur', fnCollapse)
			.bind('change', fnCollapse);

        if (vVersion < 7) {
            $(".richcombobox select").bind('mouseover', fnExpand);

            $("span.richcombobox").each(function() {
                vCssWidth = $(this).css("width");

                if (vCssWidth != "auto" && vCssWidth != "") {
                    $(this).css("width", parseInt(vCssWidth) - 1 + "px");

                }
            });
        }
    }
	 }
    catch(Error)
    {
	}
}
function SelectPatientStatus(source, eventArgs) {

    document.getElementById('hdnPStatus').value = eventArgs.get_value();
}

function showMandatory(id) {
    if (id == 'Y')
        document.getElementById('imgMandatory').style.display = 'block';
    else
        document.getElementById('imgMandatory').style.display = 'none';
}

//Common method created to solve age and Birthcalculation issue
function CalculateAge(DOB) {
    bD = DOB.split('/');
    var agetemp = 0;
    dd = bD[0];
    mm = bD[1];
    yy = bD[2];
    main = "valid";
    if ((dd == "__") || (mm == "__") || (yy == "____")) {
        //document.getElementById('txtAge').value = '';
        return {
            isvalid: false,
            Num: 0,
            type: ''
        };
    }
    if ((mm < 1) || (mm > 12) || (dd < 1) || (dd > 31) || (yy < 1) || (mm == "") || (dd == "") || (yy == ""))
        main = "Invalid";
    else
        if (((mm == 4) || (mm == 6) || (mm == 9) || (mm == 11)) && (dd > 30))
        main = "Invalid";
    else
        if (mm == 2) {
        if (dd > 29)
            main = "Invalid";
        else if ((dd > 28) && (!lyear(yy)))
            main = "Invalid";
    } else
        if ((yy > 9999) || (yy < 0))
        main = "Invalid";
    else
        main = main;
    if (main == "valid") {
        function leapyear(a) {
            if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0))
                return true;
            else
                return false;
        }
        var days = GetServerDate();

        var gdate = days.getDate();
        var gmonth = days.getMonth();
        var gyear = days.getFullYear();

        //If birthdate is curent date. age is 0 days
        if (parseInt(gdate) == dd && (gmonth + 1) == mm && gyear == yy) {
            document.getElementById('txtDOBNos').value = 0;
            document.getElementById('ddlDOBDWMY').value = 'D';
            return {
                isvalid: true,
                Num: 0,
                type: 'D'
            };
        }

        age = gyear - yy;
        if ((mm == (gmonth + 1)) && (dd <= parseInt(gdate))) {
            age = age;
        } else {
            if (mm <= (gmonth)) {
                age = age;
            } else {
                age = age - 1;
            }
        }
        if (age == 0)
            age = age;
        agetemp = age;
        if (mm <= (gmonth + 1))
            age = age - 1;
        if ((mm == (gmonth + 1)) && (dd > parseInt(gdate)))
            age = age + 1;
        var m = 0; //variable initilised for age dropdown issue
        var n = 0; //variable initilised for age dropdown issue
        if (mm == 12) {
            n = 31 - dd;
        }
        if (mm == 11) {
            n = 61 - dd;
        }
        if (mm == 10) {
            n = 92 - dd;
        }
        if (mm == 9) {
            n = 122 - dd;
        }
        if (mm == 8) {
            n = 153 - dd;
        }
        if (mm == 7) {
            n = 184 - dd;
        }
        if (mm == 6) {
            n = 214 - dd;
        }
        if (mm == 5) {
            n = 245 - dd;
        }
        if (mm == 4) {
            n = 275 - dd;
        }
        if (mm == 3) {
            n = 306 - dd;
        }
        if (mm == 2) {
            n = 334 - dd;
            if (leapyear(yy)) n = n + 1;
        }
        if (mm == 1) {
            n = 365 - dd;
            if (leapyear(yy)) n = n + 1;
        }
        if (gmonth == 1) m = 31;
        if (gmonth == 2) {
            m = 59;
            if (leapyear(gyear)) m = m + 1;
        }
        if (gmonth == 3) {
            m = 90;
            if (leapyear(gyear)) m = m + 1;
        }
        if (gmonth == 4) {
            m = 120;
            if (leapyear(gyear)) m = m + 1;
        }
        if (gmonth == 5) {
            m = 151;
            if (leapyear(gyear)) m = m + 1;
        }
        if (gmonth == 6) {
            m = 181;
            if (leapyear(gyear)) m = m + 1;
        }
        if (gmonth == 7) {
            m = 212;
            if (leapyear(gyear)) m = m + 1;
        }
        if (gmonth == 8) {
            m = 243;
            if (leapyear(gyear)) m = m + 1;
        }
        if (gmonth == 9) {
            m = 273;
            if (leapyear(gyear)) m = m + 1;
        }
        if (gmonth == 10) {
            m = 304;
            if (leapyear(gyear)) m = m + 1;
        }
        if (gmonth == 11) {
            m = 334;
            if (leapyear(gyear)) m = m + 1;
        }
        if (gmonth == 12) {
            m = 365;
            if (leapyear(gyear)) m = m + 1;
        }
        totdays = (parseInt(age) * 365);
        totdays += age / 4;
        totdays = parseInt(totdays) + gdate + m + n;
        months = age * 12;
        var t = parseInt(mm);
        months += 12 - mm;
        months += gmonth + 1;
        //                    if (gmonth == 1) p = 31 + gdate;
        //                    if (gmonth == 2) { p = 59 + gdate; if (leapyear(gyear)) m = m + 1; }
        //                    if (gmonth == 3) { p = 90 + gdate; if (leapyear(gyear)) p = p + 1; }
        //                    if (gmonth == 4) { p = 120 + gdate; if (leapyear(gyear)) p = p + 1; }
        //                    if (gmonth == 5) { p = 151 + gdate; if (leapyear(gyear)) p = p + 1; }
        //                    if (gmonth == 6) { p = 181 + gdate; if (leapyear(gyear)) p = p + 1; }
        //                    if (gmonth == 7) { p = 212 + gdate; if (leapyear(gyear)) p = p + 1; }
        //                    if (gmonth == 8) { p = 243 + gdate; if (leapyear(gyear)) p = p + 1; }
        //                    if (gmonth == 9) { p = 273 + gdate; if (leapyear(gyear)) p = p + 1; }
        //                    if (gmonth == 10) { p = 304 + gdate; if (leapyear(gyear)) p = p + 1; }
        //                    if (gmonth == 11) { p = 334 + gdate; if (leapyear(gyear)) p = p + 1; }
        //                    if (gmonth == 12) { p = 365 + gdate; if (leapyear(gyear)) p = p + 1; }
        weeks = totdays / 7;
        weeks += " weeks";
        weeks = parseInt(weeks);
        if (agetemp <= 0) {
            if (months <= 0) {
                if (weeks <= 0) {
                    if (totdays >= 0) {
                        if (totdays == 1) {
                            //                                        document.getElementById('txtDOBNos').value = totdays;
                            //                                        document.getElementById('ddlDOBDWMY').value = 'D';
                            return {
                                isvalid: true,
                                Num: totdays,
                                type: 'D'
                            };
                        } else {
                            //                                        document.getElementById('txtDOBNos').value = totdays;
                            //                                        document.getElementById('ddlDOBDWMY').value = 'D';
                            return {
                                isvalid: true,
                                Num: totdays,
                                type: 'D'
                            };
                        }
                    }
                } else {
                    if (weeks == 1) {
                        //                                    document.getElementById('txtDOBNos').value = weeks;
                        //                                    document.getElementById('ddlDOBDWMY').value = 'W';
                        return {
                            isvalid: true,
                            Num: weeks,
                            type: 'W'
                        };
                    } else {
                        //                                    document.getElementById('txtDOBNos').value = weeks;
                        //                                    document.getElementById('ddlDOBDWMY').value = 'W';
                        return {
                            isvalid: true,
                            Num: weeks,
                            type: 'W'
                        };
                    }
                }
            } else {
                if (months == 1) {
                    //                                document.getElementById('txtDOBNos').value = months;
                    //                                document.getElementById('ddlDOBDWMY').value = 'M';
                    return {
                        isvalid: true,
                        Num: months,
                        type: 'M'
                    };
                } else {
                    //                                document.getElementById('txtDOBNos').value = months;
                    //                                document.getElementById('ddlDOBDWMY').value = 'M';
                    return {
                        isvalid: true,
                        Num: months,
                        type: 'M'
                    };
                }
            }
        } else {
            if (agetemp == 1) {
                //                            document.getElementById('txtDOBNos').value = agetemp;
                //                            document.getElementById('ddlDOBDWMY').value = 'Y';
                return {
                    isvalid: true,
                    Num: agetemp,
                    type: 'Y'
                };
            } else {
                //                            document.getElementById('txtDOBNos').value = agetemp;
                //                            document.getElementById('ddlDOBDWMY').value = 'Y';
                return {
                    isvalid: true,
                    Num: agetemp,
                    type: 'Y'
                };
            }
        }

        function lyear(a) {
            if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0)) return true;
            else return false;
        }
    } else {
        return {
            isvalid: false,
            Num: 0,
            type: ''
        };
    }
}

//Common method created to solve age and Birthcalculation issue
function CalculateAge1(DOB) {

    var fyear = 0;
    var fmonth = 0;
    var fweek = 0;
    var fday = 0;
    if (DOB == '') {
        return {
            isvalid: true,
            Year: '',
            Month: '',
            Week: '',
            Day: ''
        };
    }
    bD = DOB.split('/');
    var agetemp = 0;
    dd = bD[0].indexOf('0') == 0 ? bD[0].substring(1) : bD[0];
    mm = bD[1].indexOf('0') == 0 ? bD[1].substring(1) : bD[1];
    yy = bD[2];
    main = "valid";
    if ((dd == "__") || (mm == "__") || (yy == "____")) {
        //document.getElementById('txtAge').value = '';
        return {
            isvalid: false,
            Year: 0,
            Month: 0,
            Week: 0,
            Day: 0
        };
    }
    if ((mm < 1) || (mm > 12) || (dd < 1) || (dd > 31) || (yy < 1) || (mm == "") || (dd == "") || (yy == ""))
        main = "Invalid";
    else
        if (((mm == 4) || (mm == 6) || (mm == 9) || (mm == 11)) && (dd > 30))
        main = "Invalid";
    else
        if (mm == 2) {
        if (dd > 29)
            main = "Invalid";
        else if ((dd > 28) && (!lyear(yy)))
            main = "Invalid";
    } else
        if ((yy > 9999) || (yy < 0))
        main = "Invalid";
    else
        main = main;
    if (main == "valid") {
        var from = {
            d: parseInt(dd),
            m: parseInt(mm),
            y: parseInt(yy)
        };
        var days = GetServerDate();
        var to = {
            d: parseInt(days.getDate()),
            m: parseInt(days.getMonth() + 1),
            y: parseInt(days.getFullYear())
        };

        var daysFebruary = to.y % 4 != 0 || (to.y % 100 == 0 && to.y % 400 != 0) ? 28 : 29;
        var daysInMonths = [31, 31, daysFebruary, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

        if (to.d < from.d) {
            to.d += daysInMonths[parseInt(to.m - 1)];
            from.m += 1;
        }
        if (to.m < from.m) {
            to.m += 12;
            from.y += 1;
        }
        fyear = to.y - from.y;
        fmonth = to.m - from.m;
        fday = to.d - from.d;
        if (fday > 6) {
            fweek = parseInt(fday / 7);
        }
        fday = fday - (fweek * 7);
        if (fyear < 0 || fmonth < 0 || fday < 0 || fweek < 0) {
            return {
                isvalid: false,
                Day: fday,
                Month: fmonth,
                Year: fyear,
                Week: fweek
            };
        }
        else {
            return {
                isvalid: true,
                Day: fday,
                Month: fmonth,
                Year: fyear,
                Week: fweek
            };
        }
    } else {
        return {
            isvalid: false,
            Year: fyear,
            Month: fmonth,
            Week: fweek,
            Day: fday
        };
    }
}

function CalculateDOB(strDay, strWeek, strMonth, strYear) {
    var totdays = 0;
    var totmonths = 0;
    var totyears = 0;
    var days = GetServerDate();
    if (strDay > 0) {
        totdays = parseInt(strDay);
    }
    if (strWeek > 0) {
        totdays = totdays + (parseInt(strWeek) * 7);
    }
    var curryear = parseInt(days.getFullYear());
    var daysInMonths = getDaysInMonth(curryear);

    if (totdays < daysInMonth[days.getMonth() + 1]) {
        days = processDays(days, totdays);
    }
    else {
        var currMonth = days.getMonth() + 1;

        var currMonthDays = daysInMonths[currMonth];

        while (totdays >= currMonthDays) {
            totmonths = totmonths + 1;
            totdays = totdays - currMonthDays;
            if (currMonth == 1) {
                currMonth = 12;
                curryear = curryear - 1;
                daysInMonths = getDaysInMonth(curryear);
            } else {
                currMonth = currMonth - 1;
            }
            currMonthDays = daysInMonths[currMonth];
        }
        days = processDays(days, totdays);
    }
    if (strMonth > 0) {
        totmonths = totmonths + parseInt(strMonth);
    }
    if (totmonths < 12) {
        days = processMonth(days, totmonths);
    }
    else {
        totyears = parseInt(totmonths / 12);
        totmonths = totmonths - (totyears * 12);
        days = processMonth(days, totmonths);
    }
    if (strYear > 0) {
        totyears = totyears + parseInt(strYear);
    }
    if (totyears != 0) {
        days.setFullYear(days.getFullYear() - totyears);
    }
    var fmonth = days.getMonth() + 1;
    var fday = days.getDate();
    if (fmonth < 10)
        fmonth = '0' + fmonth;
    if (fday < 10)
        fday = '0' + fday;
    return fday + '/' + fmonth + '/' + days.getFullYear();
}
function check_color() {
    var vals = {};
    $("#tabDrg1 tr td:nth-child(2)").each(function(i, e) {
        var txt = $(e).text();
        var val = vals[txt];
        vals[txt] = val == null ? 1 : val + 1;
    })
    $("#tabDrg1 tr td:nth-child(2)").each(function(i, e) {
        var txt = $(e).text();
        if (vals[txt] > 1) {
            $(e).css("color", "Blue");
        }
    })
}


function FnChangedDate() {
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

$(document).ready(function() {

    var div1 = $('<div id="dialog" title="Basic dialog" class="hide">');
    var P1 = $(' <p id="message" style="line-height: 20px; min-height: 38px; text-align: center;">');
    var innerDiv1 = $('<div class="w-100p a-center">');
    var Btn1 = $('<button id="opener" onclick="" style="width: 40px; padding: 4px 0;" class="btn ">Ok</button>');
    innerDiv1.append(Btn1);
    div1.append(P1);
    div1.append(innerDiv1);
    $('body').append(div1);

    var div2 = $('<div id="dvconformdialog" title="Basic dialog" class="hide">');
    var P2 = $('<p id="pmessage" style="line-height: 20px; min-height: 38px; text-align: center;">');
    var innerDiv2 = $('<div class="w-100p a-center">');
    var Btn2 = $('<button id="btnconok" onclick="" type="submit" runat="server" style="width: 40px; padding: 4px 0;" class="btn">Ok');
    var Btn3 = $('<button id="btnconclose" style="width: 40px; padding: 4px 0;" class="btn"> Cancel');
    innerDiv2.append(Btn2);
    innerDiv2.append(Btn3);
    div2.append(P2);
    div2.append(innerDiv2);
    $('body').append(div2);


    setTimeout(function() {
        if ($('.vertical-handle').length > 0) {
            $('.vertical-handle').children('div').each(function() {
                $(this).css('display', 'none');
            });
        }

        var n = 1;
        $('input,textarea , select').each(function() {
            $(this).attr('tabindex', n++);
        });

        //        $('.email').blur(function() {
        //            if (document.getElementById('hdnEmailAlert').value == "Y" || $.trim($(this).val()) != "") {
        //                if (!ValidateEmail($.trim($(this).val()))) {
        //var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_123") == null ? "Invalid email address." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_123");
        // var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Error" : SListForAppMsg.Get("PlatForm_Error");
        // ValidationWindow(userMsg, errorMsg);
        //                    $(this).val('');
        //                }
        //            }
        //        });

        if ($('INPUT[type="text"]').length > 0) {
            $('INPUT[type="text"]').on('keypress', function(evt) {
                var keyCode = 0;
                if (evt) {
                    keyCode = evt.keyCode || evt.which;
                }
                else {
                    keyCode = window.event.keyCode;
                }
                if (keyCode == 13) {
                    return false;
                }
            });
        }

        $(document).bind('contextmenu', function(e) {
            e.preventDefault();
        });

        $('body').attr('onkeydown', 'return (event.keyCode != 116)');

    }, 500);
});


function ValidateEmail(email) {
    var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    return expr.test(email);
};

function ValNumbersOnly(keyCode) {
    return ((keyCode >= 48 && keyCode <= 57) || keyCode == 8 ||
               (keyCode >= 96 && keyCode <= 105))
}

function ValidateAlphabets(evt) {
    var keyCode = 0;
    if (evt) {
        keyCode = evt.keyCode || evt.which;
    }
    else {
        keyCode = window.event.keyCode;
    }
    var pressedkey = keyCode;
    if (!((pressedkey == 8) || (pressedkey == 32) || (pressedkey == 46)  || (pressedkey == 17) || (pressedkey == 18) || (pressedkey == 19) || (pressedkey >= 65 && pressedkey <= 90) || (pressedkey >= 97 && pressedkey <= 122))) {
        return false;
    }
    else {
        return true;
    }
}


function LettersWithSpaceDotOnly(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
    ((evt.which) ? evt.which : 0));
    if (charCode != 46 && charCode != 39) {
        if (charCode > 32 && (charCode < 65 || charCode > 90) &&
        (charCode < 97 || charCode > 122)) {
            return false;
        }
    }
    return true;
}
function LettersWithSpaceDotAposandSlashOnly(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
    ((evt.which) ? evt.which : 0));
    if (charCode != 46 && charCode != 39 && charCode != 47) {
        if (charCode > 32 && (charCode < 65 || charCode > 90) &&
        (charCode < 97 || charCode > 122)) {
            return false;
        }
    }
    return true;
}
function AlphaNumericOnly(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
    ((evt.which) ? evt.which : 0));

    if (charCode > 31 && (charCode < 48 || charCode > 57) && (charCode < 65 || charCode > 90) &&
        (charCode < 97 || charCode > 122)) {
        return false;
    }

    return true;
}



function AlphaNumericSlashhypenColonOnly(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
    ((evt.which) ? evt.which : 0));
    if (charCode != 47 && charCode != 58 && charCode != 45) {
        if (charCode > 32 && (charCode < 48 || charCode > 57) && (charCode < 65 || charCode > 90) &&
        (charCode < 97 || charCode > 122)) {
            return false;
        }
    }

    return true;
}

function LettersWithSpaceOnly(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
    ((evt.which) ? evt.which : 0));

    if (charCode > 32 && (charCode < 65 || charCode > 90) && (charCode < 97 || charCode > 122)) {
        return false;
    }

    return true;
}



function ValidateText(evt, Content, Length, Type) {
    var IsValid = true;
    var ErrorType = -1;
    if (Length > 0 && Content.trim().length > Length) {
        ErrorType = 1;
        IsValid = false;
    }
    if (IsValid && evt != null) {
        var charCode = (evt.which) ? evt.which : ((evt.keyCode) ? evt.keyCode : ((evt.charCode) ? evt.charCode : 0));

        if (Type != '' && Type.length > 0 && charCode != 16 && charCode != 17 && charCode != 9 && charCode != 8 && charCode != 46) {
            switch (Type.toUpperCase()) {
                case "A":
                    if (!evt.shiftKey && charCode != 35 && charCode != 36 && charCode != 37 && charCode != 39 && charCode != 32) {
                        if (!((charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122))) {
                            IsValid = false;
                        }
                    }
                    else if (evt.shiftKey && !((charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122))) {
                        IsValid = false;
                    }
                    if (!IsValid)
                        ErrorType = 2;
                    break;
                case "N":
                    if (!((charCode >= 48 && charCode <= 57) || (charCode >= 96 && charCode <= 105))) {
                        IsValid = false;
                        ErrorType = 2;
                    }
                    break;
                case "AN":
                    if (!evt.shiftKey && charCode != 35 && charCode != 36 && charCode != 37 && charCode != 39) {
                        if (!((charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122) || (charCode >= 48 && charCode <= 57) || (charCode >= 96 && charCode <= 105))) {
                            IsValid = false;
                        }
                    }
                    else if (evt.shiftKey && !((charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122))) {
                        IsValid = false;
                    }
                    if (!IsValid)
                        ErrorType = 2;
                    break;
                case "NAME":
                    if (!evt.shiftKey && charCode != 35 && charCode != 36 && charCode != 37 && charCode != 39 && charCode != 222) {
                        if (!(charCode == 46 || charCode == 32 || (charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122))) {
                            IsValid = false;
                        }
                    }
                    else if (evt.shiftKey && !((charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122))) {
                        IsValid = false;
                    }
                    if (!IsValid)
                        ErrorType = 2;
                    break;
                case "EMAIL":
                    break;
                case "NWD":
                    if (!((charCode >= 48 && charCode <= 57) || (charCode >= 96 && charCode <= 105) || charCode == 190)) {
                        IsValid = false;
                        ErrorType = 2;
                    }
                    break;
                case "ANWD":
                    if (!evt.shiftKey && charCode != 35 && charCode != 36 && charCode != 37 && charCode != 39 || charCode != 190 || charCode != 222) {
                        if (!((charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122) || (charCode >= 48 && charCode <= 57) || (charCode == 32) || (charCode == 39) || (charCode >= 96 && charCode <= 105))) {
                            IsValid = false;
                        }
                    }
                    else if (evt.shiftKey && !((charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122))) {
                        IsValid = false;
                    }
                    if (!IsValid)
                        ErrorType = 2;
                    break;
                case "TEXT":
                    if (charCode == 37 || charCode == 42 || charCode == 60 || charCode == 62) {
                        IsValid = false;
                        ErrorType = 2;
                    }
            }
        }
    }

    if (!IsValid) {
        switch (ErrorType) {
            case 1: var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_124") == null ? "The text exceeds the allowed limit" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_124");
                    ValidationWindow(userMsg, errorMsg);
                break;
            case 2: var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_125") == null ? "Not allowed!" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_125");
                    ValidationWindow(userMsg, errorMsg);
                break;
            default:
                break;
        }
    }
    //            alert(charCode);

    return IsValid;

    function IsAlpha() {
    }

    function IsNum() {
    }

    function IsSplCharAllowed() {
    }

    function IsDotAllowed() {
    }
}

function preventCopyPaste(evt, id, Content, Type) {
    var charCode = (evt.which) ? evt.which : ((evt.keyCode) ? evt.keyCode : ((evt.charCode) ? evt.charCode : 0));
    var IsAllowed = true;
    if (evt.shiftKey && charCode == 45)
        IsAllowed = false;
    if (evt.ctrlKey && (charCode == 67 || charCode == 99 || charCode == 86 || charCode == 118 || charCode == 88 || charCode == 120))
        IsAllowed = false;
    if (Type != '' && Type.length > 0) {
        switch (Type.toUpperCase()) {
            case "A":
                if (charCode == 190)
                    IsAllowed = false;
                break;
            case "N": if (charCode >= 65 && charCode <= 90)
                    IsAllowed = false;
                break;
            case "TEXT": if (charCode == 106)
                    IsAllowed = false;
            default:
                break;
        }
    }
    if (charCode == 9 && Type.toUpperCase() == "TEXT") {
        var expr = '[<>*%]';
        var RE = new RegExp(expr);
        if (RE.test(Content)) {
            document.getElementById(id).focus();
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_126") == null ? "Special characters not allowed!" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_126");
 var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
            if (evt.preventDefault)
                evt.preventDefault();
            IsAllowed = false;
        }
    }
    if (evt.altKey)
        IsAllowed = false;
    return IsAllowed;
}

function IsValidText(id, Content) {
    var expr = '[<>*]';
    var RE = new RegExp(expr);
    var IsAllowed = true;
    if (RE.test(Content)) {
        document.getElementById(id).focus();
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_126") == null ? "Special characters not allowed!" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_126");
 var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
        IsAllowed = false;
    }
    return IsAllowed;
}

function endSession() {

    $.ajax({
        method: "POST",
        url: "../AjaxHandler.ashx?method=LogOut",
        success: function() {
        },
        error: function() {
        }

    });
}



var validNavigation = false;

function wireUpEvents() {

    document.onclick = function(e) {
        if (e.target != null)
            validNavigation = true;
    }

    window.onbeforeunload = function(e) {

        if (e != 'undefined') {
            if (!validNavigation) {
                endSession();
                validNavigation = false;
            }
        }
    }
}

// Wire up the events as soon as the DOM tree is ready
$(document).ready(function() {
    wireUpEvents();
});




function Investigationvalidation() {
    if (document.getElementById('txtName').value == '') {
var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_127") == null ? "Provide the Investigation" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_127");
 var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtName').focus();
        return false;
    }
    var InvName = document.getElementById('txtName').value;
    document.getElementById('txtName').value = '';
    document.getElementById('txtName').focus();
    var retvalue = InvName;
    return retvalue;
}


function SetOtherCurrPayble(pCurrName, pCurrAmount, pNetAmount, ConValue, IsDisplay) {

    var pTotalNetAmt =parseFloat(pNetAmount) / parseFloat(pCurrAmount);
    document.getElementById(ConValue + "_lblOtherCurrPaybleName").innerHTML = pCurrName;
    document.getElementById(ConValue + "_lblOtherCurrRecdName").innerHTML = pCurrName;
    document.getElementById(ConValue + "_lblOtherCurrPaybleAmount").innerHTML = pTotalNetAmt;
    document.getElementById(ConValue + "_hdnOterCurrPayble").value = pTotalNetAmt;
	ToTargetFormat($('#'+ConValue + "_lblOtherCurrPaybleName"))
	ToTargetFormat($('#'+ConValue + "_lblOtherCurrRecdName"))
	ToTargetFormat($('#'+ConValue + "_lblOtherCurrPaybleAmount"))
	ToTargetFormat($('#'+ConValue + "_hdnOterCurrPayble"))
	
}
function SetOtherCurrReceived(pCurrAmount, pNetAmount, pServiceCharge, ConValue) {
    var pTotalNetAmt = Number(pNetAmount);
    document.getElementById(ConValue + "_lblOtherCurrRecdAmount").innerHTML = pTotalNetAmt;
    document.getElementById(ConValue + "_hdnOterCurrReceived").value = pTotalNetAmt;
    document.getElementById(ConValue + "_hdnOterCurrServiceCharge").value = pServiceCharge;
	ToTargetFormat($('#'+ConValue + "_lblOtherCurrRecdAmount"))
	ToTargetFormat($('#'+ConValue + "_hdnOterCurrReceived"))
	ToTargetFormat($('#'+ConValue + "_hdnOterCurrServiceCharge"))
	 


}
function isOtherCurrDisplay1(pType) {
    if (pType == "B") {
        document.getElementById("OtherCurrencyDisplay1_tbAmountPayble").style.display = "block";
    }
    if (pType == "N") {
        document.getElementById("OtherCurrencyDisplay1_tbAmountPayble").style.display = "none";
    }


}

function ShowOptions(control, args) {
    control._completionListElement.style.zIndex = 10000001;
}
function HtmlDecode(strValue) {
    return $('<div></div>').html(strValue).text();
}
function getCustomRoundoff(roundoffVal, DefaultRound, RoundOffType) {
    var result = 0;
    DefaultRound = DefaultRound == 0 ? 1 : DefaultRound;
    var Roundoffpattern = $('#hdnRoundoffpattern').val();

    if (Roundoffpattern == "Y" && parseFloat(DefaultRound) == 1) {
        roundoffVal = parseFloat(roundoffVal).toFixed(2);
        var Values = roundoffVal.split(".");
        var FinalNetValue = Values[1];

        if (parseFloat(FinalNetValue) >= 50) {

            RoundOffType = "upper value";
        }
        else {
            RoundOffType = "lower value";
        }
    }

    if (RoundOffType.toLowerCase() == "lower value") {
        result = (Math.floor(Number(roundoffVal) / Number(DefaultRound))) * (Number(DefaultRound));
    }
    else if (RoundOffType.toLowerCase() == "upper value") {
        result = (Math.ceil(Number(roundoffVal) / Number(DefaultRound))) * (Number(DefaultRound));
    }
    else if (RoundOffType.toLowerCase() == "none") {
        result = format_number_withSignNone(roundoffVal, 2);
    }
    else {
        result = roundoffVal;
    }
    result = Number(result) - Number(roundoffVal);
    result = format_number_withSign(result, 2);
    return result;
}


function isOtherCurrDisplay(pType) {
    if (pType == "B") {
        //        document.getElementById("OtherCurrencyDisplay1_tbOtherCurr").style.display = "block";
    }
}
function isOtherCurrDisplay1(pType) {
    if (pType == "B") {
        document.getElementById("OtherCurrencyDisplay1_tbAmountPayble").style.display = "block";
    }
    if (pType == "N") {
        document.getElementById("OtherCurrencyDisplay1_tbAmountPayble").style.display = "none";
    }


}
function getOtherCurrAmtValues(pType, ConValue) {
    if (pType == "REC") {

        var pAMt = ToInternalFormat($("#" + ConValue + "_hdnOterCurrReceived")) == "" ? "0" : ToInternalFormat($("#" + ConValue + "_hdnOterCurrReceived"));
        return pAMt;
    }
    if (pType == "PAY") {
        var pAMt = ToInternalFormat($("#" + ConValue + "_hdnOterCurrPayble")) == "" ? "0" : ToInternalFormat($("#" + ConValue + "_hdnOterCurrPayble"));
        return pAMt;
    }
    if (pType == "SER") {
        var pAMt = ToInternalFormat($("#" + ConValue + "_hdnOterCurrServiceCharge")) == "" ? "0" : parseFloat(ToInternalFormat($("#" + ConValue + "_hdnOterCurrServiceCharge"))).toFixed(2);
        return parseFloat(pAMt).toFixed(2);
    }
}
function ClearOtherCurrValues(ConValue) {
    document.getElementById(ConValue + "_lblOtherCurrRecdAmount").innerHTML = 0;
    document.getElementById(ConValue + "_hdnOterCurrReceived").value = 0;
    document.getElementById(ConValue + "_hdnOterCurrServiceCharge").value = 0;
    ToTargetFormat($("#" + ConValue + "_lblOtherCurrRecdAmount"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrServiceCharge"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrReceived"));

}

function Calc_Copayment() {
    //    if (document.getElementById('QPR_rdoOP')!=null && document.getElementById('QPR_rdoOP').checked == true && getCreditBill() == true
    //          && document.getElementById('btnSave').style.display == "block")

    if (getCreditBill() == true) {
    //Add for SME IP Client Patient -to hide copayment grid
        var visittype = document.getElementById('hdnVisitType').value;
        var Middleeast = document.getElementById('hdnIsMiddleEast').value;
        if (visittype == "IP" && Middleeast == "N") {
        $('#tdCopayment').css('display', 'none');
    }
    else {

        var itemCopayAMT = parseFloat(ToInternalFormat($('#hdnItemCoPaymentTotal'))).toFixed(2);
        var totalNonMedical = parseFloat(ToInternalFormat($('#lblNonMedicalAmt'))).toFixed(2);
        if ($('#lblTotalAmt').length > 0) {
            var totalMedial = parseFloat(parseFloat(ToInternalFormat($('#lblTotalAmt'))) - parseFloat(totalNonMedical)).toFixed(2);
        }
        else {
            var totalMedial = 0;
            totalMedial = parseFloat(parseFloat((ToInternalFormat($('#txtTotal'))) + parseFloat(ToInternalFormat($('#txtitemdiscounts')))) - parseFloat(totalNonMedical)).toFixed(2);
        }
        var CoPaymentlogic = parseFloat(getPaymentlogicID());
        var Copayment_Percentage = parseFloat(getCoPaymentperent()).toFixed(2);
        setPrAutAmount();
        var PrAutAmount = isNaN(parseFloat(getPreAuthamount()).toFixed(2)) ? 0 : parseFloat(getPreAuthamount()).toFixed(2);
        var Claimlogin = getClaimID();
        var CoPaymentType = GetCopaymentType();
        var _claimAmount = 0;
        var _actualCoPayment = 0;
        var NetValue = ToInternalFormat($('#txtGrandTotal'));
        var AmountRevd = ToInternalFormat($('#txtAmountRecieved'));
        var NonReimpresDiscount = 0;
        if ($('#txtTotalDiscount').length > 0) {
            var TotalDiscount = ToInternalFormat($('#txtTotalDiscount'));  //ToInternalFormat($('#txtTotalDiscount'));
            NonReimpresDiscount = ToInternalFormat($('#hdnnonReimbursableDis'));
        }
        else {
        NonReimpresDiscount = ToInternalFormat($('#hdnnonReimbursableDis'));
            var TotalDiscount = ToInternalFormat($('#txtbillingleveldiscounts'));
            if (NonReimpresDiscount != 0 || NonReimpresDiscount != null) {
                TotalDiscount = TotalDiscount - NonReimpresDiscount;
            }
            
        }

        var DifferenceAmount = 0;
        var TotalAmount = 0;
        var PatientNetAmount = 0;
        var TotalClaimAmount = 0;
        var _Discount = 0;
        var _AmountReceive = 0;
        $('#hdnCoPaymentType').val(CoPaymentType);
        $('#hdnClaimID').val(Claimlogin);
        $('#hdnCoPaymentlogicID').val(CoPaymentlogic);
        $('#hdnCoPaymentPerCentage').val(Copayment_Percentage);


        $('#tdCopayment').css('display', 'table-cell');
        if (parseFloat(PrAutAmount) > 0 || parseFloat(Copayment_Percentage) > 0) {

            _actualCoPayment = Copayment_Login(CoPaymentlogic, Copayment_Percentage, PrAutAmount, totalMedial, CoPaymentType);
            _claimAmount = Copayment_Deducted_Login(Claimlogin, PrAutAmount, totalMedial, _actualCoPayment);
            //added by pavithra starts

            if (CoPaymentlogic == -1) {
                if (parseFloat(PrAutAmount) < parseFloat(totalMedial)) {
                    _actualCoPayment = parseFloat(totalMedial) - parseFloat(PrAutAmount)

                }
            }
            /////ends
            // DifferenceAmount = (parseFloat(totalMedial) - parseFloat(_claimAmount)).toFixed(2);
            var _grossBill = parseFloat(totalNonMedical) + parseFloat(totalMedial);
            var _amountReceivable = 0;
            _amountReceivable = parseFloat(_grossBill) - parseFloat(_claimAmount);
            DifferenceAmount = parseFloat(totalMedial) - parseFloat(_claimAmount) - parseFloat(_actualCoPayment);
            //            if (parseFloat(_amountReceivable) >= 0) {
            //                DifferenceAmount = 0;
            //            }
            //            else {
            //                DifferenceAmount = parseFloat(_claimAmount) > (parseFloat(totalNonMedical) + parseFloat(_actualCoPayment)) ? (parseFloat(_claimAmount) - (parseFloat(totalNonMedical) + parseFloat(_actualCoPayment))) : 0;
            //            } 

            TotalAmount = (parseFloat(DifferenceAmount) + parseFloat(_actualCoPayment) + parseFloat(totalNonMedical)).toFixed(2);
            TotalClaimAmount = parseFloat(_claimAmount);
            if (parseFloat(TotalAmount) > parseFloat(TotalDiscount)) {
                PatientNetAmount = parseFloat(parseFloat(TotalAmount) - parseFloat(TotalDiscount)).toFixed(2);
                _Discount = parseFloat(TotalAmount) - parseFloat(TotalDiscount);
            }
            else {
                PatientNetAmount = parseFloat(0).toFixed(2);
                _Discount = parseFloat(TotalDiscount) - parseFloat(TotalAmount);

            }
            if (parseFloat(PatientNetAmount) == 0 && parseFloat(_Discount) > 0) {
                if (parseFloat(TotalClaimAmount) > parseFloat(_Discount)) {
                    _claimAmount = (parseFloat(TotalClaimAmount) - parseFloat(_Discount)).toFixed(2);

                }
                else {
                    _claimAmount = parseFloat(0).toFixed(2);
                }
            }

            if (parseFloat(PatientNetAmount) >= parseFloat(AmountRevd)) {
                PatientNetAmount = parseFloat(parseFloat(PatientNetAmount) - parseFloat(AmountRevd)).toFixed(2);

            }
            else {

                _AmountReceive = parseFloat(parseFloat(AmountRevd) - parseFloat(PatientNetAmount)).toFixed(2);
                PatientNetAmount = parseFloat(0).toFixed(2);
                _claimAmount = parseFloat(parseFloat(_claimAmount) - parseFloat(_AmountReceive)).toFixed(2);
            }

            document.getElementById("lblpreauthAmount").innerHTML = parseFloat(PrAutAmount).toFixed(2);
            document.getElementById('lblActualCopaymenttxt').innerHTML = parseFloat(_actualCoPayment).toFixed(2);
            document.getElementById("lblClaminAmount").innerHTML = parseFloat(_claimAmount).toFixed(2);
            document.getElementById("lblMedical").innerHTML = parseFloat(totalMedial).toFixed(2);
            document.getElementById("lblNonMedical").innerHTML = parseFloat(totalNonMedical).toFixed(2);
            document.getElementById('hdnTotalCopayment').value = parseFloat(_actualCoPayment).toFixed(2);
            document.getElementById('hdnClaim').value = parseFloat(_claimAmount).toFixed(2);
            document.getElementById("lblDifferenceAmount").innerHTML = parseFloat(DifferenceAmount).toFixed(2);
            document.getElementById("lblTotal").innerHTML = parseFloat(PatientNetAmount).toFixed(2);
            document.getElementById("hdnlblTotal").value = parseFloat(PatientNetAmount).toFixed(2);
            document.getElementById("hdnTowardsAmount").value = parseFloat(PatientNetAmount).toFixed(2);

            //$('#lblTotal').html(PatientNetAmount);
            //$('#hdnTowardsAmount').val(PatientNetAmount);

            ToTargetFormat($('#lblActualCopaymenttxt'));
            ToTargetFormat($('#lblClaminAmount'));
            ToTargetFormat($('#lblDifferenceAmount'));
            ToTargetFormat($('#hdnTowardsAmount'));
            ToTargetFormat($('#lblTotal'));
            ToTargetFormat($('#hdnlblTotal'));
            ToTargetFormat($('#hdnClaim'));
            ToTargetFormat($('#lblpreauthAmount'));
            ToTargetFormat($('#lblMedical'));
            ToTargetFormat($('#lblNonMedical'));

        }
        else {
            // DifferenceAmount = (parseFloat(totalMedial) - parseFloat(_claimAmount)).toFixed(2);
            //added by pavithra
            if (parseFloat(PrAutAmount) == 0 && CoPaymentlogic == -1) {
                //    _claimAmount = parseFloat(totalMedial).toFixed(2);
                if (parseFloat(totalMedial) > 0)
                    _claimAmount = parseFloat(parseFloat(totalMedial) - parseFloat(TotalDiscount)).toFixed(2);
                TotalAmount = parseFloat(totalNonMedical);
            }

            ///ends
            var _grossBill = parseFloat(totalNonMedical) + parseFloat(totalMedial);
            var _amountReceivable = 0;
            _amountReceivable = parseFloat(_grossBill) - parseFloat(_claimAmount);
            DifferenceAmount = parseFloat(totalMedial) - parseFloat(_claimAmount) - parseFloat(_actualCoPayment);





            TotalAmount = (parseFloat(DifferenceAmount) + parseFloat(_actualCoPayment) + parseFloat(totalNonMedical) - parseFloat(NonReimpresDiscount)).toFixed(2);

            TotalClaimAmount = parseFloat(_claimAmount);
            if (parseFloat(TotalAmount) > parseFloat(TotalDiscount)) {
                PatientNetAmount = parseFloat(parseFloat(TotalAmount) - parseFloat(TotalDiscount)).toFixed(2);  //- parseFloat(TotalDiscount)).toFixed(2);
                _Discount = parseFloat(TotalAmount) - parseFloat(TotalDiscount);
                if (parseFloat(_claimAmount) >= parseFloat(TotalDiscount))
                    _claimAmount = parseFloat(parseFloat(_claimAmount)).toFixed(2); //- parseFloat(TotalDiscount)).toFixed(2);
            }
            else {
                PatientNetAmount = parseFloat(0).toFixed(2);
                _Discount = parseFloat(TotalDiscount) - parseFloat(TotalAmount);

            }
            if (PatientNetAmount == 0 && parseFloat(_Discount) > 0) {
                if (parseFloat(TotalClaimAmount) > parseFloat(_Discount)) {
                    _claimAmount = parseFloat(parseFloat(TotalClaimAmount) - parseFloat(_Discount)).toFixed(2);

                }
                else {
                    _claimAmount = parseFloat(0).toFixed(2);
                }
            }
            if (parseFloat(PatientNetAmount) >= parseFloat(AmountRevd)) {
                PatientNetAmount = parseFloat(parseFloat(PatientNetAmount) - parseFloat(AmountRevd)).toFixed(2);
                PrAutAmount = parseFloat(_claimAmount).toFixed(2);

            }
            else {
                _AmountReceive = parseFloat(parseFloat(AmountRevd) - parseFloat(PatientNetAmount)).toFixed(2);
                _claimAmount = parseFloat(parseFloat(_claimAmount) - parseFloat(_AmountReceive)).toFixed(2);
                PrAutAmount = parseFloat(_claimAmount).toFixed(2);
            }
            //item Copay Deduct
            /*-----------Condition Added for non Reimbursable items-------------
            Author: Thaya */
            if (PrAutAmount > 0) {

                PrAutAmount = parseFloat(PrAutAmount).toFixed(2) - parseFloat(itemCopayAMT).toFixed(2);
                _claimAmount = parseFloat(_claimAmount).toFixed(2) - parseFloat(itemCopayAMT).toFixed(2);
                _actualCoPayment = (parseFloat(_actualCoPayment) + parseFloat(itemCopayAMT)).toFixed(2);
                PatientNetAmount = (parseFloat(PatientNetAmount) + parseFloat(itemCopayAMT)).toFixed(2);
            }
            /*-----------End ------------------------*/
            $('#hdnPreAuthAmount').val(PrAutAmount);
            //item Copay Deduct

            document.getElementById("lblpreauthAmount").innerHTML = parseFloat(PrAutAmount).toFixed(2);
            document.getElementById('lblActualCopaymenttxt').innerHTML = parseFloat(_actualCoPayment).toFixed(2);
            document.getElementById("lblClaminAmount").innerHTML = parseFloat(_claimAmount).toFixed(2);
            document.getElementById("lblMedical").innerHTML = parseFloat(totalMedial).toFixed(2);
            document.getElementById("lblNonMedical").innerHTML = parseFloat(totalNonMedical).toFixed(2);
            document.getElementById('hdnTotalCopayment').value = parseFloat(_actualCoPayment).toFixed(2);
            document.getElementById('hdnClaim').value = parseFloat(_claimAmount).toFixed(2);
            document.getElementById("lblDifferenceAmount").innerHTML = parseFloat(DifferenceAmount).toFixed(2);
            document.getElementById("lblTotal").innerHTML = parseFloat(PatientNetAmount).toFixed(2);
            document.getElementById("hdnlblTotal").value = parseFloat(PatientNetAmount).toFixed(2);
            document.getElementById("hdnTowardsAmount").value = parseFloat(PatientNetAmount).toFixed(2);
            
            //$('#lblTotal').html(PatientNetAmount);
            //$('#hdnTowardsAmount').val(PatientNetAmount);

            ToTargetFormat($('#lblActualCopaymenttxt'));
            ToTargetFormat($('#lblClaminAmount'));
            ToTargetFormat($('#lblDifferenceAmount'));
            ToTargetFormat($('#hdnTowardsAmount'));
            ToTargetFormat($('#lblTotal'));
            ToTargetFormat($('#hdnlblTotal'));
            ToTargetFormat($('#hdnClaim'));
            ToTargetFormat($('#lblpreauthAmount'));
			ToTargetFormat($('#lblMedical'));
            ToTargetFormat($('#lblNonMedical'));
        }
        }
    }

}

function Copayment_Login(CoPaymentlogic, Copayment_Percentage, PrAutAmount, totalMedial, CoPaymentType) {
    var _actualCoPayment = 0;

    if (parseFloat(Copayment_Percentage) > 0 && parseFloat(ToInternalFormat($('#txtGrandTotal'))) > 0) {
        if (CoPaymentlogic == 0) {
            if (parseFloat(totalMedial) < parseFloat(PrAutAmount)) {
                if (CoPaymentType == "Value") {
                    _actualCoPayment = parseFloat(Copayment_Percentage);
                }
                else {
                    _actualCoPayment = (parseFloat(totalMedial) * parseFloat(Copayment_Percentage)) / 100;
                }
            }
            else {
                if (CoPaymentType == "Value") {
                    _actualCoPayment = parseFloat(Copayment_Percentage);
                }
                else {
                    _actualCoPayment = (parseFloat(PrAutAmount) * parseFloat(Copayment_Percentage)) / 100;
                }
            }
        }
        else if (CoPaymentlogic == 1) {
            if (CoPaymentType == "Value") {
                _actualCoPayment = parseFloat(Copayment_Percentage);
            }
            else {
                _actualCoPayment = (parseFloat(totalMedial) * parseFloat(Copayment_Percentage)) / 100;
            }
        }
        else if (CoPaymentlogic == 2) {
            if (parseFloat(PrAutAmount) > 0) {
                if (CoPaymentType == "Value") {
                    _actualCoPayment = parseFloat(Copayment_Percentage);
                }
                else {
                    _actualCoPayment = (parseFloat(PrAutAmount) * parseFloat(Copayment_Percentage)) / 100;
                }
            }
            else {
                _actualCoPayment = 0;
            }
        }
        else {
            if (CoPaymentType == "Value") {
                _actualCoPayment = parseFloat(Copayment_Percentage);
            }
            else {
                _actualCoPayment = 0;
            }
        }
    }
    else {
        _actualCoPayment = 0;
    }

    return _actualCoPayment;
}
function Copayment_Deducted_Login(Claimlogin, PrAutAmount, totalMedical, _actualCoPayment) {
    var _claimAmount = 0;
    if (parseFloat(Claimlogin) == 1) {
        if (parseFloat(totalMedical) >= parseFloat(_actualCoPayment)) {
            _claimAmount = parseFloat(totalMedical) - parseFloat(_actualCoPayment);

            if (_claimAmount > PrAutAmount) {
                _claimAmount = PrAutAmount;
            }
        }
        else {
            _claimAmount = 0;
        }
    }
    else if (parseFloat(Claimlogin) == 2) {
        if (parseFloat(PrAutAmount) >= parseFloat(_actualCoPayment)) {
            _claimAmount = parseFloat(PrAutAmount) - parseFloat(_actualCoPayment);

            if (_claimAmount > totalMedical) {
                _claimAmount = totalMedical;
            }
        }
        else {
            _claimAmount = 0;
        }
    }
    else {
        if (parseFloat(PrAutAmount) > parseFloat(totalMedical)) {
            _claimAmount = parseFloat(totalMedical);
        }
        else {
            _claimAmount = parseFloat(PrAutAmount);
        }
    }
    return _claimAmount;
}

function setPrAutAmount() {
    var PrAutAmount = 0;

    $('#hdnPreAuthType').val(GetPreAuthType());
    $('#hdnPreAuthPercentage').val(GetPreAuthPerent());
    ToTargetFormat($('#hdnPreAuthPercentage'));

    var Percentage = ToInternalFormat($('#hdnPreAuthPercentage'));
    var totalNonMedical = parseFloat(ToInternalFormat($('#lblNonMedicalAmt'))).toFixed(2);
    var totalMedial = parseFloat(parseFloat(ToInternalFormat($('#lblTotalAmt'))) - parseFloat(totalNonMedical)).toFixed(2);
    var NetValue = ToInternalFormat($('#txtGrandTotal'));

    if (GetPreAuthType() == "Percentage") {
        if (parseFloat(Percentage) > 0 && parseFloat(totalMedial) > 0) {
            PrAutAmount = (parseFloat(totalMedial) * parseFloat(Percentage)) / 100;
            $('#uctlClientTpa_txtAuthamount').val(PrAutAmount);
            ToTargetFormat($('#uctlClientTpa_txtAuthamount'));
        }
        else {
            PrAutAmount = parseFloat(totalMedial);
            $('#uctlClientTpa_txtAuthamount').val(PrAutAmount);
            ToTargetFormat($('#uctlClientTpa_txtAuthamount'));
        }
    }

    $('#hdnPreAuthAmount').val(ToInternalFormat($('#uctlClientTpa_txtAuthamount')));
    ToTargetFormat($('#hdnPreAuthAmount'));
}



//datetimepicker issue fix
function recalltimepicker() {
    var d = GetServerDate();
    $('.dateTimePicker').datetimepicker({
        changeMonth: true,
        changeYear: true,
        showOn: "both",
        buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif",
        buttonImageOnly: true,
        dateFormat: jQueryDateFormat,
        timeFormat: JQueryTimeFormat,
        hour: d.getHours(),
        minute: d.getMinutes(),
        second: d.getSeconds(),
        beforeShow: function(input, inst) {
            //$("#" + inst.id).after($("div#ui-datepicker-div"));
            $('#ui-datepicker-div').removeClass('hide-calendar');
        }
    });

}
function recalldatetimepicker() {
var d=  GetServerDate();
    $('.timePicker').timepicker({

        showOn: "both",
        buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif",
        buttonImageOnly: true,
        showButtonPanel: true,
        hour: d.getHours(),
        minute: d.getMinutes(),
        second: d.getSeconds(),
		timeFormat: JQueryTimeFormat,
        beforeShow: function(input, inst) {
            // $("#" + inst.id).after($("div#ui-datepicker-div"));

            $('#ui-datepicker-div').removeClass('hide-calendar');
        }
    });

}
if ($('#hdnDateFormat').val() != "" && $('#hdnDateFormat').val() != undefined) {
    var jQueryDateFormat = $('#hdnDateFormat').val();
    if (jQueryDateFormat.indexOf('yyyy') > -1) {

        jQueryDateFormat = jQueryDateFormat.replace('yyyy', 'yy');
    }
    else {
        jQueryDateFormat = jQueryDateFormat.replace('yy', 'y');
    }
    jQueryDateFormat = jQueryDateFormat.replace('MMM', 'M').replace('MM', 'mm');
    jQueryDateFormat = jQueryDateFormat.replace('ddd', 'D');
}
else {
    var jQueryDateFormat = "dd/MM/yyyy";
}
var JQueryTimeFormat=$('#hdnTimeFormat').val();
function recalldatepicker() {
    var d = GetServerDate();
    $('.datePicker').datepicker({
        changeMonth: true,
        changeYear: true,
        showOn: "both",
        buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif",
        buttonImageOnly: true,
        showButtonPanel: true,
        dateFormat: jQueryDateFormat,
        //yearRange: "1920:2016",
        beforeShow: function(input, inst) {
            //   var inp = $("#" + inst.id);
            //   inp.after($("div#ui-datepicker-div"));
            $('#ui-datepicker-div').removeClass('hide-calendar');
        }
    });
}
function recallpresentdatepicker() {
    $('.datePickerPres').datepicker({
        changeMonth: true,
        changeYear: true,
        showOn: "both",
        maxDate: 0,
        buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif",
        buttonImageOnly: true,
        showButtonPanel: true,
        dateFormat: jQueryDateFormat,
        yearRange: "1920:2100",
        beforeShow: function(input, inst) {
            //   var inp = $("#" + inst.id);
            //   inp.after($("div#ui-datepicker-div"));
            $('#ui-datepicker-div').removeClass('hide-calendar');
        }
    });
}
function recallpastdatepicker() {
            var d = GetServerDate();
            $('.datePickerPast').datepicker({
                changeMonth: true,
                changeYear: true,
                showOn: "both",
                buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif",
                buttonImageOnly: true,
                showButtonPanel: true,
                maxDate: GetServerDate(),
                dateFormat:jQueryDateFormat,
                beforeShow: function(input, inst) {
                    $('#ui-datepicker-div').removeClass('hide-calendar');
                }
            });
        }
   function recallpastdatetimepicker(){
            var d = GetServerDate();
            $(".dateTimePickerPastDate").datetimepicker({
            changeMonth: !0,
            changeYear: !0,
            showOn: "both",
            buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif",
            buttonImageOnly: !0,
            dateFormat: jQueryDateFormat,
            timeFormat: JQueryTimeFormat,
            hour: d.getHours(),
            maxDate: GetServerDate(),
            minute: d.getMinutes(),
            second: d.getSeconds(),
            beforeShow: function(e, t) {
                $("#ui-datepicker-div").removeClass("hide-calendar");
            }
        });
     }
var JQueryMonthFormat=$('#hdnMonthFormat').val();
function recallmonthpicker() {
    var d = GetServerDate();
    $('.monthYearPicker').datepicker({

        changeMonth: true,
        changeYear: true,
        showOn: "both",
        buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif",
        buttonImageOnly: true,
        showButtonPanel: true,
        dateFormat: JQueryMonthFormat,
        beforeShow: function(input, inst) {
            // $("#" + inst.id).after($("div#ui-datepicker-div"));
            // $(input).after($(input).datepicker('widget'));
            $('#ui-datepicker-div').addClass('hide-calendar');


        },
        onChangeMonthYear: function(year, month, dp_inst) {

            if (month < 10) {
                month = "0" + month;
            }
            $("#" + dp_inst.id).val(month + "/" + year);
        }
    });
}


$("#Attuneheader_menu").hide();
//$("#v-image").hide();
$("#imagetd").addClass("hide");
$(".newMenu").show();
$(".newMenu .categoryitems").css('display', 'none');




 

function fun_JSON_DT(DST) {
    var m, day;
    JDT = DST;
    var d = new Date(parseInt(JDT.substr(6)));
    m = d.getMonth() + 1;
    if (m < 10)
        m = '0' + m
    if (d.getDate() < 10)
        day = '0' + d.getDate()
    else
        day = d.getDate();

    return (day + '/' + m + '/' + d.getFullYear())
}


function fun_JSON_DM(DST) {
    var m, day, MIT;
    JDT = DST;
    var d = new Date(parseInt(JDT.substr(6)));
    m = d.getMonth() + 1;
    if (m < 10)
        m = '0' + m
    if (d.getDate() < 10)
        day = '0' + d.getDate()
    else
        day = d.getDate();

    var HOU = d.getHours();
    var MIN = d.getMinutes();

    if (Number(HOU) > 12) {
        HOU = Number(HOU) - 12;
        if (HOU < 10) { HOU = '0' + HOU }
        MIT = HOU + ':' + MIN + 'PM';
    }
    else {
        if (HOU < 10) { HOU = '0' + HOU }
        MIT = HOU + ':' + MIN + 'AM';
    }
    return (day + '-' + m + '-' + d.getFullYear() + ' ' + MIT)
}
//setInterval(function() { iscurrdate = false; }, 3000);
//var CurrentDate;
//var iscurrdate = false;
//function GetServerDate() {
//    if (iscurrdate)
//    { return CurrentDate; }
//    else {


//        $.ajax({
//            type: "GET",
//            url: "../PlatformWebServices/PlatFormServices.asmx/GetServerDate",
//            contentType: "application/json; charset=utf-8",
//            dataType: "json",
//            async: false,
//            success: function(data) {
//                CurrentDate = new Date(data.d);
//                // CurrentDate = new Date(moment.utc(parseInt(data.d.substr(6))).format()).toUTCString();
//                iscurrdate = true;
//            },
//            failure: function(msg) {
//                //alert('error');
//                return false;
//            }
//        });

//        return CurrentDate;
//    }
//}

function GetTimeZone() {
    var timeZone;
    $.ajax({
        type: "GET",
        url: "../PlatformWebServices/PlatFormServices.asmx/GetTimeZone",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            timeZone = data.d;
            // CurrentDate = new Date(moment.utc(parseInt(data.d.substr(6))).format()).toUTCString();

        },
        failure: function(msg) {
            //alert('error');
            return false;
        }
    });

    return timeZone;
}


function ValidationWindowResponse(message, tt,responseFunc) {
    jQuery('<div>')
        .html("<p>" + message + "</p>")
        .dialog({
            autoOpen: false,
            modal: true,
            title: tt,
            dialogClass: 'validationwindow',
			close: function() {
                jQuery(this).dialog("destroy");
            },
            buttons: {
                "MyButton": {
                    id: "OKResponse",
                    "class": "btn",
                    click: function() {
                        jQuery(this).dialog("destroy");
                    }
                }
            },
            create: function() {

                var canceltxt = jQuery('#Language').text();
                jQuery('#Cancelbtnid').text(canceltxt);
                //var oktxt = jQuery('[id$=hdnButtonText]').val();
                var oktxt = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_03") == null ? "Ok" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_03");
                if (oktxt == '' || oktxt == null) {
                    try {
                        oktxt = jQuery('[id$=btnRoleOK]').val();
                    }
                    catch (Error) {
                        oktxt = "Ok";
                    }
                    oktxt = oktxt == "" || oktxt == undefined ? "Ok" : oktxt;
                }
                jQuery('#OKResponse').text(oktxt);
                jQuery('#OKResponse').css("width", "80px");
                jQuery('#OKResponse').css("height", "20px");
                $('#OKResponse').click(function() {
                    setTimeout(responseFunc, 0);
                });

            }
        }).dialog("open");
            
}


function ValidationWindow(message, tt) {
    jQuery('<div>')
        .html("<p>" + message + "</p>")
        .dialog({
            autoOpen: false,
            modal: true,
            title: tt,
            dialogClass: 'validationwindow',
			close: function() {
                jQuery(this).dialog("destroy");
            },
            buttons: {
                "MyButton": {
                    id: "okbtnid",
                    "class": "btn",
                    click: function() {
                        jQuery(this).dialog("destroy");                        
                    }
                }
            },  
            create: function() {
                    
                    var canceltxt = jQuery('#Language').text();
                    jQuery('#Cancelbtnid').text(canceltxt);
                //var oktxt = jQuery('[id$=hdnButtonText]').val();
                var oktxt = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_03") == null ? "Ok" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_03");
                if (oktxt == '' || oktxt == null) {
                    try {
                        oktxt = jQuery('[id$=btnRoleOK]').val();
                    }
                    catch (Error) {
                        oktxt = "Ok";
                    }
                    oktxt = oktxt == "" || oktxt == undefined ? "Ok" : oktxt;
                }
                jQuery('#okbtnid').text(oktxt);
                jQuery('#okbtnid').css("width", "80px");
                jQuery('#okbtnid').css("height", "20px");

            }
        }).dialog("open");
    }

    function ValidationWindow(message, tt, cid) {
        jQuery('<div id="validationWindow">')
        .html("<p>" + message + "</p>")
        .dialog({
            autoOpen: false,
            modal: true,
            title: tt,
            dialogClass: 'validationwindow',
            close: function() {
                jQuery(this).dialog("destroy");

            },
            buttons: {
                "MyButton": {
                    id: "okbtnid",
                    "class": "btn",
                    click: function() {
                        jQuery(this).dialog("destroy");
                        if (cid!=null && cid!=undefined) {
                            document.getElementById(cid).focus();
                        }
                        
                    }
                }
            },
            create: function() {

                var canceltxt = jQuery('#Language').text();
                jQuery('#Cancelbtnid').text(canceltxt);
                //var oktxt = jQuery('[id$=hdnButtonText]').val();
                var oktxt = SListForAppDisplay.Get("PlatForm_Scripts_Common_js_03") == null ? "Ok" : SListForAppDisplay.Get("PlatForm_Scripts_Common_js_03");
                if (oktxt == '' || oktxt == null) {
                    try {
                        oktxt = jQuery('[id$=btnRoleOK]').val();
                    }
                    catch (Error) {
                        oktxt = "Ok";
                    }
                    oktxt = oktxt == "" || oktxt == undefined ? "Ok" : oktxt;
                }
                jQuery('#okbtnid').text(oktxt);
                
                document.getElementById('okbtnid').focus();
                jQuery('#okbtnid').css("width", "80px");
                jQuery('#okbtnid').css("height", "20px");
                //jQuery('[id$=okbtnid]').focus();
                
            }
        }).dialog("open");
        $('#okbtnid').focus();
        
    }
 
    function InsertLoginpreferences(IdentifyType, IdentifyValue, LoginID, OrgID) {
        var jdata = {};
        jdata.IdentifyType = IdentifyType;
        jdata.IdentifyValue = IdentifyValue;
        jdata.LoginID = LoginID;
        jdata.CreatedBy = LoginID;
        jdata.ModifiedBy = LoginID;
        jdata.OrgID = OrgID;
        jdata.SerialNo = 0;
        var vv = [];
        vv.push(jdata);
        var ss = {};
        ss.lstpreferences = vv;
        $.ajax({  
            url: '../PlatForm/CommonWebServices/CommonServices.asmx/InsertLoginpreferences',
            dataType: "json",
            type: "POST",
            data: JSON.stringify(ss),
            contentType: "application/json; charset=utf-8",
            success: function(result) {
            }

        });
        return false;
    }
    var vLoginPreferences = [];
    function GetLoginpreferences(LoginID, Identifytype, orgID) {
        var jdata = {};
        jdata.LoginId = LoginID;
        jdata.Identifytype = Identifytype;
        jdata.orgID = orgID;
       return  $.ajax({
       url: '../PlatForm/CommonWebServices/CommonServices.asmx/GetLoginpreferences',
            dataType: "json",
            type: "POST",
            data: JSON.stringify(jdata),
            contentType: "application/json; charset=utf-8",
            success: function(result) {
                vLoginPreferences = result;
            }
        });
    }
function ConfirmWindow(message, tt, btnoktext, btnclosetext) {
    //    jQuery('<div>')
    //        .html("<p>" + message + "</p>")
    //        .dialog({
    //            autoOpen: false,
    //            modal: true,
    //            title: tt,
    //            buttons: {
    //                Yes: function() {
    //                    jQuery(this).dialog("close");
    //                   
    //                },
    //                No: function() {
    //                    jQuery(this).dialog("close");


    //                }
    //            },
    //            close: function(event, ui) {
    //                $(this).remove();
    //            }
    //        }).dialog("open");
    //    return false;
    return confirm(message);
}
function checkLength(textBox, length) {
    var mLen = length;

    var maxLength = parseInt(mLen);

    if (textBox.value.length > maxLength) {
        textBox.value = textBox.value.substring(0, maxLength);
    }
}


function ValidateSpecifiedSplChar(e) {

    var unicode = e.charCode ? e.charCode : e.keyCode
    if (unicode != 8) { //if the key isn't the backspace key (which we should allow)
        if (unicode >= 48 && unicode <= 57 || unicode >= 65 && unicode <= 90 || unicode >= 97 && unicode <= 122 || unicode == 32 || unicode == 46 || unicode == 59 || unicode == 44 || unicode == 47 || unicode == 40 || unicode == 41 || unicode == 38) {
            return true;
        }

        else  //if not a number
        {
            return false //disable key press
        }
    }

}
function updatePerformerAlert() {
    var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_141") == null ? "This action cannot be performed due to no visit details" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_141");
    ValidationWindow(userMsg, errorMsg);
}


function ToExternalDate(dtDate) {
    if (dtDate != "" && dtDate != undefined) {
        var tempDate = new Date(dtDate);
        if (tempDate.getDate() == 1 && tempDate.getMonth() == 0 && tempDate.getYear() == -1899) {
            return "";
        }
        else if (tempDate.getDate() == 1 && tempDate.getMonth() == 0 && tempDate.getFullYear() == 10000) {
            return "";
        }
        else {
            var momentDate = moment(tempDate);
            var tempdate = momentDate.toDate();
            return tempdate.format($('#hdnDateFormat').val());
        }
    }
    return "";
}
function ToInternalDate(strDate) {
   var strFormater=$('#hdnDateFormat').val().toUpperCase();
   var momentDate = moment(strDate,strFormater);
    return momentDate.toDate();
}

function ToExternalDateTime(dtDate) {
    if (dtDate != "" && dtDate != undefined) {
        var tempDate = new Date(dtDate);
        if (tempDate.getDate() == 1 && tempDate.getMonth() == 0 && tempDate.getYear() == -1899) {
            return "";
        }
        else {
            var momentDate = moment(tempDate);

            var tempdate = momentDate.toDate();
            return tempdate.format($('#hdnDateTimeFormat').val());
        }
    }
    return "";
}
function ToInternalDateTime(strDate) {
    var strFormater = $('#hdnDateFormat').val().toUpperCase() + " " + $('#hdnTimeFormat').val().replace('tt','A');
    var momentDate = moment(strDate, strFormater);
    return momentDate.toDate();
}


function ToExternalTime(dtDate) {
    if (dtDate != "" && dtDate != undefined) {
        var tempDate = new Date(dtDate);
        if (tempDate.getDate() == 1 && tempDate.getMonth() == 0 && tempDate.getYear() == -1899) {
            return "";
        }
        else {
            var momentDate = moment(tempDate);

            var tempdate = momentDate.toDate();
            return tempdate.format($('#hdnTimeFormat').val());
        }
    }

    return "";
}
function ToInternalTime(strDate) {
    var strFormater = $('#hdnTimeFormat').val().replace('tt','A');
    var momentDate = moment(strDate, strFormater);
    return momentDate.toDate();
}

function ToExternalMonth(dtDate) {
    if (dtDate != "" && dtDate!=undefined) {
        var tempDate = new Date(dtDate);
        if (tempDate.getDate() == 1 && tempDate.getMonth() == 0 && tempDate.getYear() == -1899) {
            return "";
        }
        else {
            var momentDate = moment(tempDate);

            var tempdate = momentDate.toDate();
            return tempdate.format($('#hdnMonthFormat').val());
        }
    }
    return "";
}
function ToInternalMonth(strDate) {
    var strFormater = $('#hdnMonthFormat').val().toUpperCase();
    var momentDate = moment(strDate, strFormater);
    return momentDate.toDate();
}

function CheckFromToDate(strFromDate, strToDate) {
    var strFormater = $('#hdnDateFormat').val().toUpperCase();
    var momentFrom = moment(strFromDate, strFormater);
    var momentTo = moment(strToDate, strFormater);
    if (momentTo.diff(momentFrom) >= 0) {
        return true;
    }
    else {
        return false;
    }
}
function GetDifferenceDate(strFromDate, strToDate) {
    var strFormater = $('#hdnDateFormat').val().toUpperCase();
    var momentFrom = moment(strFromDate, strFormater);
    var momentTo = moment(strToDate, strFormater);
    return moment.duration(momentTo.diff(momentFrom)).asDays();

}
function GetDifferenceMonth(strFromDate, strToDate) {
    var strFormater = $('#hdnDateFormat').val().toUpperCase();
    var momentFrom = moment(strFromDate, strFormater);
    var momentTo = moment(strToDate, strFormater);
    //return momentTo.diff(momentFrom, 'Months', true);
    return moment.duration(momentTo.diff(momentFrom)).asMonths();

}
function ToExternalYear(dtDate) {
    var tempDate = new Date(dtDate);
    if (tempDate.getDate() == 1 && tempDate.getMonth() == 0 && tempDate.getYear() == -1899) {
        return "";
    }
    else {
        var momentDate = moment(tempDate);

        var tempdate = momentDate.toDate();
        return tempdate.format($('#hdnYearFormat').val());
    }
}

function JSONDateWithTime(dateStr) {
    jsonDate = dateStr;
    var d = new Date(parseInt(jsonDate.substr(6)));

    return d;
}
function CheckFromToMonth(strFromDate, strToDate) {
    var strFormater = $('#hdnMonthFormat').val().toUpperCase();
    var momentFrom = moment(strFromDate, strFormater);
    var momentTo = moment(strToDate, strFormater);
    if (momentTo.diff(momentFrom) >= 0) {
        return true;
    }
    else {
        return false;
    }
}
function CheckFromToDateTime(strFromDate, strToDate) {
    //var strFormater = $('#hdnDateTimeFormat').val().toUpperCase().replace('MM','mm').replace('TT','A');
	var strFormater = $('#hdnDateTimeFormat').val().toUpperCase().replace('TT','A');
    var momentFrom = moment(strFromDate, strFormater);
    var momentTo = moment(strToDate, strFormater);
    if (momentTo.diff(momentFrom) >= 0) {
        return true;
    }
    else {
        return false;
    }
}

function recalldatePickerFuture() {
    $(".datePickerFuture").datepicker({
        changeMonth: !0,
        changeYear: !0,
        showOn: "both",
        buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif",
        buttonImageOnly: !0,
        showButtonPanel: !0,
        dateFormat: jQueryDateFormat,
        minDate: GetServerDate(),
        yearRange: "2015:2050",
        beforeShow: function (e, t) {
            $("#ui-datepicker-div").removeClass("hide-calendar")
        }
    })
}
function fnCheckvalidDate(strDate) {
   var strFormater=$('#hdnDateFormat').val().toUpperCase();
   var momentDate = moment(strDate, strFormater, true).isValid();
    return momentDate;
}
function recallcustomDateSepDate() {
    var s = $('#hdnMaxtodate').val();
    var r = GetServerDate();
    var o = new Date(r.getFullYear(), r.getMonth(), r.getDate() + 1),
        i = new Date(r.getFullYear(), r.getMonth(), r.getDate() + (s - 1));
    $(".customDateSepDate").datepicker({
        changeMonth: !0, changeYear: !0, showOn: "both",
        minDate: o, maxDate: i,
        buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0,
        yearRange: "2000:2025",
        dateFormat: jQueryDateFormat,
        beforeShow: function (e, t) {
            $("#ui-datepicker-div").removeClass("hide-calendar")
        }
    });
}
function recallcustomDateWithCurrentDate() {
    var s = $('#hdnReviewMaxDate').val();
    var r = GetServerDate();
    var o = new Date(r.getFullYear(), r.getMonth(), r.getDate()),
        i = new Date(r.getFullYear(), r.getMonth(), r.getDate() + (s - 1));
    $(".customDateWithCurrentDate").datepicker({
        changeMonth: !0, changeYear: !0, showOn: "both",
        minDate: o, maxDate: i,
        buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif", buttonImageOnly: !0, showButtonPanel: !0,
        yearRange: "2000:2025",
        dateFormat: jQueryDateFormat,
        beforeShow: function(e, t) {
            $("#ui-datepicker-div").removeClass("hide-calendar")
        }
    });
}

function recalldatetimePickerFuture() {
    var d = GetServerDate();
    $('.dateTimePickerFutureDate').datetimepicker({

        showOn: "both",
        buttonImage: "../PlatForm/StyleSheets/start/images/calendar.gif",
        buttonImageOnly: true,
        showButtonPanel: true,
        hour: d.getHours(),
        minute: d.getMinutes(),
        second: d.getSeconds(),
        timeFormat: JQueryTimeFormat,
        beforeShow: function (input, inst) {
            // $("#" + inst.id).after($("div#ui-datepicker-div"));

            $('#ui-datepicker-div').removeClass('hide-calendar');
        }
    });
}

//get currentPageUrl/QueryString in external js file without using hiddenfield by JeniferLeo 
function getCurrentPageURL(name, url) {
   if (!url) {
       url = window.location.href;
   }
   name = name.replace(/[\[\]]/g, "\\$&");
   var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
      results = regex.exec(url);
   if (!results) return null;
   if (!results[2]) return '';
   return decodeURIComponent(results[2].replace(/\+/g, " "));
}
//end
function SpecialsCharNotallowed(event) {
    var key = window.event.keyCode;
    if (key==37) {
        return false;
    }
}

//Hari's Code starts
function ToInternalFormat(pControl) {
                return pControl.asNumber({ region: "<%=LanguageCode %>"  })
            }

function ToTargetFormat(pControl) {
    return pControl.formatCurrency({ region: "<%=LanguageCode %>" }).val();
}
//Hari's code ends

//abhi code for transaction password
function TransactionValidation() {
    var errorMsg = SListForAppMsg.Get("PlatForm_Error") == null ? "Alert" : SListForAppMsg.Get("PlatForm_Error");

    if (document.getElementById('txtTranoldpassword').value == '') {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_68") == null ? "Provide old Transaction password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_68");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtTranoldpassword').focus();
        return false;
    }

    if (document.getElementById('txtTrannewpassword').value == '') {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_69") == null ? "Provide New Transaction password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_69");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtTrannewpassword').focus();
        return false;
    }

    if (document.getElementById('txtTranconfirmpassword').value == '') {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_70") == null ? "Provide Confirm Transaction password" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_70");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtTranconfirmpassword').focus();
        return false;
    }



    if (document.getElementById('txtTrannewpassword').value.length < 6) {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_71") == null ? "Transaction Password length should be minimum of 6 characters." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_71");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtTrannewpassword').value = '';
        document.getElementById('txtTranconfirmpassword').value = '';
        document.getElementById('txtTrannewpassword').focus();
        return false;
    }

    var passlen = document.getElementById("hdnpasslength").value;
    if (passlen != "") {
        if (document.getElementById('txtTrannewpassword').value.length > Number(passlen)) {
    var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_72") == null ? "Maximum Length Reached Please check transaction Password Hint." : SListForAppMsg.Get("PlatForm_Scripts_Common_js_72");
    ValidationWindow(userMsg, errorMsg);
    document.getElementById('txtTrannewpassword').value = '';
    document.getElementById('txtTranconfirmpassword').value = '';
    document.getElementById('txtTrannewpassword').focus();
    return false;
    }
    }
    
    if (document.getElementById('txtTranoldpassword').value == document.getElementById('txtTrannewpassword').value) {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_73") == null ? "New Transaction password and old Transaction password cannot be same" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_73");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtTranoldpassword').value = '';
        document.getElementById('txtTrannewpassword').value = '';
        document.getElementById('txtTranconfirmpassword').value = '';
        document.getElementById('txtTranoldpassword').focus();
        return false;
    }



    if (document.getElementById('txtTrannewpassword').value != document.getElementById('txtTranconfirmpassword').value) {
        var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_75") == null ? "There is a Transaction password mismatch" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_75");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtTrannewpassword').value = '';
        document.getElementById('txtTranconfirmpassword').value = '';
        document.getElementById('txtTrannewpassword').focus();
        return false;
    }




    if (document.getElementById('txtTrannewpassword').value == document.getElementById('txtTranconfirmpassword').value) {
        var pw = document.getElementById('txtTranconfirmpassword').value;
        var transpasslen = document.getElementById("hdnpasslength").value;
        var transsplchar = document.getElementById("hdnsplcharlen").value;
        var transnumchar = document.getElementById("hdnnumcharlen").value;
    var passed = validatePassword(pw, { alpha: 1, special: transsplchar, numeric: transnumchar });
    if (!passed) {
    var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_76") == null ? "Transaction Password Policy Mismatch Please check Transaction Password Hint" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_76");
    ValidationWindow(userMsg, errorMsg);
    document.getElementById('txtTrannewpassword').value = '';
    document.getElementById('txtTranconfirmpassword').value = '';
    document.getElementById('txtTrannewpassword').focus();
    return false;
    }

        } 

    if (document.getElementById('txtTrannewpassword').value == document.getElementById('txtTranconfirmpassword').value) {
        var pw = document.getElementById('txtTranconfirmpassword').value;
        var passed = validatePassword(pw, { alpha: 1, special: 1, numeric: 1 });
        if (!passed) {
            var userMsg = SListForAppMsg.Get("PlatForm_Scripts_Common_js_77") == null ? "Transaction Password should contain atleast one special character,an alphabet and a number" : SListForAppMsg.Get("PlatForm_Scripts_Common_js_77");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtTrannewpassword').value = '';
            document.getElementById('txtTranconfirmpassword').value = '';
            document.getElementById('txtTrannewpassword').focus();
            return false;
        }

    }

    return true;
}
//abhi code ends
