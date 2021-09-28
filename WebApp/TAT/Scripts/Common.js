/* Event Functions */
// Add an event to the obj given
// event_name refers to the event trigger, without the "on", like click or mouseover
// func_name refers to the function callback when event is triggered
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
function DocPopM(sender, e) {
    var behavior = $find('AutoRname');
    var target = behavior.get_completionList();
    for (i = 0; i < target.childNodes.length; i++) {
        var text = target.childNodes[i]._value;
        var ItemArry;
        ItemArry = text.split('~');
        if (ItemArry[11].trim().toLowerCase() == 'p') {
            target.childNodes[i].style.color = "Black";
        }
        else {
            target.childNodes[i].style.color = "orange";
        }
    }
}

function DocPopUm(sender, e) {
    var behavior = $find('AutoCompleteForUnMergePhysician');
    var target = behavior.get_completionList();
    for (i = 0; i < target.childNodes.length; i++) {
        var text = target.childNodes[i]._value;
        var ItemArry;
        ItemArry = text.split('~');
        if (ItemArry[11].trim().toLowerCase() == 'p') {
            target.childNodes[i].style.color = "Black";
        }
        else {
            target.childNodes[i].style.color = "orange";
        }
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
    if (Number(document.getElementById('txtDue').value) > 0) {
        animatedcollapse.toggle('Due');
        if (document.getElementById('imgDue').src.split('Images')[1] == '/collapse.jpg')
            document.getElementById('imgDue').src = '../Images/expand.jpg';
        else if (document.getElementById('imgDue').src.split('Images')[1] == '/expand.jpg')
            document.getElementById('imgDue').src = '../Images/collapse.jpg';
    }
    else {
        alert('There is no due for this invoice');
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

    if (objFrom.value == '') {
        alert('Provide valid date');
        objFrom.focus();
        return false;
    }
    if (!objFrom.value.match(regExp)) {
        alert('Date is not in a valid format');
        objFrom.value = "";
        objFrom.focus();
        return false;
    }
    if (objTo.value == '') {
        alert('Provide valid date');
        objTo.focus();
        return false;
    }
    if (!objTo.value.match(regExp)) {
        alert('Date is not in a valid format');
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

    var cDate = new Date().format("dd/MM/yyyy").split('/');
    var currentTime = new Date(cDate[2] + '/' + cDate[1] + '/' + cDate[0]);
    var CMonth = currentTime.getMonth() + 1;
    var CDay = currentTime.getDate();
    var CYear = currentTime.getFullYear();
    if (ValidateObj != "1") {
        if (FYear < CYear || (FYear == CYear && FMonth < CMonth) || (FYear == CYear && FMonth == CMonth && FDay < CDay)) {
            alert('Invalid date. Provide only a future date');
            objFrom.focus();
            return false;
        }
    }
    if (TYear < CYear || (TYear == CYear && TMonth < CMonth) || (TYear == CYear && TMonth == CMonth && TDay < CDay)) {
        alert('Invalid date. Provide only a future date');
        objTo.focus();
        return false;
    }
    if (FYear > TYear || (FYear == TYear && FMonth > TMonth) || (FYear == TYear && FMonth == TMonth && FDay > TDay)) {
        alert('Mismatch between from and to date');
        return false;
    }
    return true;
}
function ExcedDate(obj1, StartDt, wedFlag, BAflage) {
    var obj = document.getElementById(obj1);
    var currentTime;
    if (obj.value != '' && obj.value != '__/__/____') {
        dobDt = obj.value.split('/');
        var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
        var mMonth = dobDtTime.getMonth() + 1;
        var mDay = dobDtTime.getDate();
        var mYear = dobDtTime.getFullYear();
        if (wedFlag == 0) {
            currentTime = new Date();
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
                alert('Invalid date');
                obj.value = '__/__/____';
                obj.focus();
                return false;
            }
            else if (mYear == year && mMonth > month) {
                alert('Invalid date');
                obj.value = '__/__/____';
                obj.focus();
                return false;
            }
            else if (mYear == year && mMonth == month && mDay > day) {
                alert('Invalid date');
                obj.value = '__/__/____';
                obj.focus();
                return false;
            }
        }
        else {
            if (mYear < year) {
                alert('Invalid date. Provide only a future date');
                obj.value = '__/__/____';
                obj.focus();
                return false;
            }
            else if (mYear == year && mMonth < month) {
                alert('Invalid date. Provide only a future date');
                obj.value = '__/__/____';
                obj.focus();
                return false;
            }
            else if (mYear == year && mMonth == month && mDay < day) {
                alert('Invalid date. Provide only a future date');
                obj.value = '__/__/____';
                obj.focus();
                return false;
            }
        }
        return true;
    }
    else {
        alert('Invalid date');
        obj.focus();
        return false;
    }
}
function ExcedDatevisitsearch(obj1, StartDt, wedFlag, BAflage) {
    var Isvaliddate = true;
    var obj = document.getElementById(obj1);
    var currentTime;
    if (obj.value != '' && obj.value != '__/__/____') {
        dobDt = obj.value.split('/');
        var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
        var mMonth = dobDtTime.getMonth() + 1;
        var mDay = dobDtTime.getDate();
        var mYear = dobDtTime.getFullYear();
        if (wedFlag == 0) {
            currentTime = new Date();
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
                alert('Invalid date');
                obj.value = '__/__/____';
                obj.focus();
                Isvaliddate = false;
                return false;
            }
            else if (mYear == year && mMonth > month && Isvaliddate == true) {
                alert('Invalid date');
                obj.value = '__/__/____';
                obj.focus();
                Isvaliddate = false;
                return false;
            }
            else if (mYear == year && mMonth == month && mDay > day && Isvaliddate == true) {
                alert('Invalid date');
                obj.value = '__/__/____';
                obj.focus();
                Isvaliddate = false;
                return false;
            }
        }
        else {
            if (mYear < year) {
                alert('Invalid date. Provide only a future date');
                obj.value = '__/__/____';
                obj.focus();
                Isvaliddate = false;
                return false;
            }
            else if (mYear == year && mMonth < month && Isvaliddate == true) {
                alert('Invalid date. Provide only a future date');
                obj.value = '__/__/____';
                obj.focus();
                Isvaliddate = false;
                return false;
            }
            else if (mYear == year && mMonth == month && mDay < day && Isvaliddate == true) {
                alert('Invalid date. Provide only a future date');
                obj.value = '__/__/____';
                obj.focus();
                Isvaliddate = false;
                return false;
            }
        }
        return true;
    }
    //    else {
    //    alert('Invalid date');
    //    obj.focus();
    //    return false;
    //    }
}


function setDOBYear(id, PageType) {
    var DecimalConfig;
    if (PageType == 'CB') {
        if (document.getElementById(id).value == '0') {
            alert("Age cannot be zero");
            document.getElementById(id).value = '';
            document.getElementById(id).focus();
        }
        else if (document.getElementById(id).value != '') {
            if (document.getElementById(id).value == '.') {
                alert("Age Should be Number");
                document.getElementById(id).value = '';
                document.getElementById(id).focus();
            }
            else if (Number(document.getElementById(id).value) == '0') {
                alert("Age cannot be zero");
                document.getElementById(id).value = '';
                document.getElementById(id).focus();
            }
        }
        document.getElementById('tDOB').value = ''
        document.getElementById('tDOB').value = "dd//MM//yyyy";
        document.getElementById('ddlDOBDWMY').value = 'Year(s)';
        DecimalConfig = document.getElementById('hdnCBDecimalAge').value;
        /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
        $('#hdnIsDOBMandatoryDOBFlag').val("N");
        $('#hdnIsDOBMandatoryAgeFlag').val("Y");
        /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
    }
    else if (PageType == 'HC') {
        if (document.getElementById('hdnDecimalAgeHC') != null)
            DecimalConfig = document.getElementById('hdnDecimalAgeHC').value;
    }
    else if (PageType == 'LB') {
        if (document.getElementById('hdnDecimalAgeConfig') != null) {
            DecimalConfig = document.getElementById('hdnDecimalAgeConfig').value;
        }

        if (document.getElementById(id).value == '.') {
            alert("Age Should be Number");
            document.getElementById(id).value = '';
            document.getElementById(id).focus();
        }
        /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
        $('#hdnIsDOBMandatoryDOBFlag').val("N");
        $('#hdnIsDOBMandatoryAgeFlag').val("Y");
        /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
    }
    else {
        DecimalConfig = 'N';
    }

    if (DecimalConfig == 'Y') {
        setDecimalDOBYear(id)
    }
    else {
        var ageVal = document.getElementById(id);
        var decimalAge = ageVal.value.split('.');
        if (decimalAge.length > 1) {
            document.getElementById('ddlDOBDWMY').value = 'Year(s)';
            document.getElementById('txtDOBNos').value = '';
            document.getElementById('txtDOBNos').focus();
            alert('Should not be Decimal Values');
            return false;

        }
        if (ageVal.value != '') {
            if (ageVal.value.length < 3) {
                if (document.getElementById('hdnDOB') != null) {
                    document.getElementById('hdnDOB').value = '';
                }
                var days = new Date();
                //var gdate = days.getDate();
                //var gmonth = days.getMonth();
                var gyear = days.getFullYear();
                dobYear = gyear - ageVal.value;

                var gmonth = days.getMonth();
                gmonth = parseInt(gmonth) + 1;
                if (gmonth < 10) {
                    gmonth = '0' + gmonth;
                }

                var gday = days.getDate();
                gday = parseInt(gday);
                if (gday < 10) {
                    gday = '0' + gday;
                }
/* BEGIN | DefectID [439] | Dhana/Bhupathy | Datein 20160310 | M | Age Issue  */
                var curd = new Date(dobYear, gmonth-1, gday);

                var res = curd.getDay();
                var res2 = curd.getMonth();
                if (!(res2 == (gmonth-1))) {
                    var dm = DaysInMonth(dobYear, gmonth);
                    gday = dm;
                }
            /*END | DefectID [439] | Dhana/Bhupathy | Datein 20160310 */
                document.getElementById('tDOB').value = gday + '/' + gmonth + '/' + dobYear;


                if (document.getElementById('hdnDOB') != null) {
                    document.getElementById('hdnDOB').value = gday + '/' + gmonth + '/' + dobYear;
                }
                /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
                $('#hdnIsDOBMandatoryDOBFlag').val("N");
                $('#hdnIsDOBMandatoryAgeFlag').val("Y");
                /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */

            }
        }
    }
    setDDlDOBYear(id);
}
/* BEGIN | DefectID [Parent ID] | Dhana | Datein 20160303 | M | Age Issue  */
function DaysInMonth(Y, M) {
    with (new Date(Y, M, 1, 12)) {
        setDate(0);
        return getDate();
    }
    /* END | DefectID [Parent ID] | Dhana | Datein 20160303 */
}
function setDecimalDOBYear(id) {
    var ageVal = document.getElementById(id).value;
    var decimalAge = ageVal.split('.');
    var DecimalMonth;
    var dobYear;
    ageVal = decimalAge[0];

    dobYear = gyear - ageVal.value;
    var AgeUnit = document.getElementById('ddlDOBDWMY').value;
    if (decimalAge.length > 1) {

        DecimalMonth = decimalAge[1];
        document.getElementById('ddlDOBDWMY').value = 'Year(s)';
        if (decimalAge[1] == 12 && AgeUnit == 'Year(s)') {
            document.getElementById(id).value = parseInt(ageVal) + 1;
            ageVal = document.getElementById(id).value;

        }
        if (decimalAge[1] > 12 && AgeUnit == 'Year(s)') {
            alert('Month should not greater than 12');
            document.getElementById('txtDOBNos').value = '';
            document.getElementById(id).focus();
            return false;
        }
    }
    else {
        DecimalMonth = 0;
    }
    if (ageVal != '') {
        if (ageVal.length < 4) {
            if (document.getElementById('hdnDOB') != null) {
                document.getElementById('hdnDOB').value = '';
            }
            var days = new Date();

            var gmonth = days.getMonth();
            gmonth = parseInt(gmonth) + 1;
            var gyear = days.getFullYear();
            if (parseInt(gmonth) > parseInt(DecimalMonth)) {
                gmonth = (gmonth) - parseInt(DecimalMonth);
                dobYear = gyear - ageVal;
            }
            else {
                gmonth = parseInt(DecimalMonth) - (gmonth);
                dobYear = parseInt(gyear - ageVal) - 1;
                gmonth = ((days.getMonth() + 1) + 12) - parseInt(DecimalMonth);
            }
            if (gmonth < 10) {
                gmonth = '0' + gmonth;
            }

            var gday = days.getDate();
            gday = parseInt(gday);
            if (gday < 10) {
                gday = '0' + gday;
            }
 /* BEGIN | DefectID [439] | Dhana/Bhupathy | Datein 20160310 | M | Age Issue  */
            var curd = new Date(dobYear, gmonth-1, gday);

            var res = curd.getDay();
            var res2 = curd.getMonth();
            if (!(res2 == (gmonth-1))) {
                var dm = DaysInMonth(dobYear, gmonth);
                gday = dm;
            }
	    
/*END | DefectID [439] | Dhana/Bhupathy | Datein 20160310 */

            document.getElementById('tDOB').value = gday + '/' + gmonth + '/' + dobYear;
            if (document.getElementById('hdnPatientDOB') != null) {
                document.getElementById('hdnPatientDOB').value = gday + '/' + gmonth + '/' + dobYear;
            }
            if (document.getElementById('hdnDOB') != null) {
                document.getElementById('hdnDOB').value = gday + '/' + gmonth + '/' + dobYear;
            }

        }
    }
  //  setDDlDOBYear(id); 
}
function setSexValue(sexId, msId) {
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].value);
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);
    if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '8' || document.getElementById(msId).value == '12') {
        document.getElementById(sexId).value = 'M';
    }
    else if (document.getElementById(msId).value == '2' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '9' || document.getElementById(msId).value == '10' || document.getElementById(msId).value == '11') {
        document.getElementById(sexId).value = 'F';
    }
    else {
        document.getElementById(sexId).value = 'M';
        //        document.getElementById(sexId).value = '0'


    }
    if (document.getElementById(msId).value == '4') {
        document.getElementById(sexId).value = '0'
    }
}
function setSalValue(sexId, msId) {
    if (document.getElementById(sexId).value == 'M') {
        if ((document.getElementById(msId).value == '2' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '9' || document.getElementById(msId).value == '10' || document.getElementById(msId).value == '11') && document.getElementById(msId).value != '8')
        //document.getElementById(msId).value != '1' && document.getElementById(msId).value != '3' && document.getElementById(msId).value != '5' && document.getElementById(msId).value != '6' && document.getElementById(msId).value != '7'  && document.getElementById(msId).value != '12') {
        {
            document.getElementById(msId).value = '1';
        }
    }
    else {
        if ((document.getElementById(msId).value == '1' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '5' || document.getElementById(msId).value == '6' || document.getElementById(msId).value == '7' || document.getElementById(msId).value == '12') && document.getElementById(msId).value != '8') {
            //document.getElementById(msId).value != '2' && document.getElementById(msId).value != '4' && document.getElementById(msId).value != '9' && document.getElementById(msId).value != '10' && document.getElementById(msId).value != '8'  && document.getElementById(msId).value != '11') {
            document.getElementById(msId).value = '2';
        }
    }

    if (document.getElementById(msId).value == '4') {
        document.getElementById(sexId).value = '0'
    }

}
function setSexValueQB(sexId, msId, ddMaritalID) {
    //       alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].value);
    //        alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);
    if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '5' || document.getElementById(msId).value == '6' || document.getElementById(msId).value == '7' || document.getElementById(msId).value == '8' || document.getElementById(msId).value == '12') {
        document.getElementById(sexId).value = 'M';
    }
    else if (document.getElementById(msId).value == '2' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '9' || document.getElementById(msId).value == '10' || document.getElementById(msId).value == '11') {
        document.getElementById(sexId).value = 'F';
    }
    else {
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
    if (document.getElementById(msId).value == '4') {
        document.getElementById(sexId).value = '0'
    }
}


function setSexValueopt(sexId, msId) {
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].value);
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);
    if (document.getElementById(msId).value == '6' || document.getElementById(msId).value == '7' || document.getElementById(msId).value == '8' || document.getElementById(msId).value == '9') {
        document.getElementById(sexId).value = 'M';
    }
    else if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '2' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '11') {
        document.getElementById(sexId).value = 'F';
    }

    if (document.getElementById(msId).value == '4') {
        document.getElementById(sexId).value = '0'
    }
}

function setSexValueBySting(sexId, msId) {
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);
    var salutaionValue = document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text;
    if (salutaionValue == 'Mr.' || salutaionValue == 'Master.' || salutaionValue == 'Baby.' || salutaionValue == 'Prof.' || salutaionValue == 'Col.' || salutaionValue == 'Dr.') {
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
    if (str.indexOf(at) == -1) {
        alert('Invalid e-mail id');
        return false;
    }
    if (str.indexOf(at) == -1 || str.indexOf(at) == 0 || str.indexOf(at) == lstr) {
        alert('Invalid e-mail id');
        return false;
    }
    if (str.indexOf(dot) == -1 || str.indexOf(dot) == 0 || str.indexOf(dot) == lstr) {
        alert('Invalid e-mail id');
        return false;
    }
    if (str.indexOf(at, (lat + 1)) != -1) {
        alert('Invalid e-mail id');
        return false;
    }
    if (str.substring(lat - 1, lat) == dot || str.substring(lat + 1, lat + 2) == dot) {
        alert('Invalid e-mail id');
        return false;
    }
    if (str.indexOf(dot, (lat + 2)) == -1) {
        alert('Invalid e-mail id');
        return false;
    }
    if (str.indexOf(" ") != -1) {
        alert('Invalid e-mail id');
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
            alert('To date must be greater than  or equal to from date');
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
            alert('Scheduled timing is invalid');
            document.getElementById(frmId).focus();
            return false;
        }
    }
    else {
        alert('Scheduled timing is invalid');
        document.getElementById(frmId).focus();
        return false;
    }
    return true;
}

function loadMonths() {

    if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == "Daily") {
        document.getElementById('dRepeat').style.display = 'none';
        document.getElementById('lblMW').innerHTML = "Days";
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
    else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == "Weekly") {
        document.getElementById('dRepeat').style.display = 'block';
        document.getElementById('lblMW').innerHTML = "Week";
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
        document.getElementById('lblMW').innerHTML = "Month";
        document.getElementById('dMonthly').style.display = 'block';
        document.getElementById('dWeekly').style.display = 'none';
        document.getElementById('dRepeat').disabled = false;

    }
    else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == "Yearly") {
        document.getElementById('dRepeat').style.display = 'block';
        document.getElementById('dRepeat').disabled = true;
        document.getElementById('lblMW').innerHTML = "Year";
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
        alert('Select date');
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
        document.getElementById('lblRepeatWords').innerHTML = "Weekly on " + rptDays;
    }
    else if ((document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Weekly')
&& (document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML != '1')) {
        document.getElementById('dWords').style.display = 'block';
        number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
        document.getElementById('lblRepeatWords').innerHTML = "Every " + number + " week on " + rptDays;
    }
    else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Daily') {
        document.getElementById('dWords').style.display = 'block';
        number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
        if (number == '1') {
            document.getElementById('lblRepeatWords').innerHTML = "Every day";
        }
        else {
            document.getElementById('lblRepeatWords').innerHTML = "Every " + number + " days";
        }
    }
    else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Monthly') {
        if (document.getElementById('rdrptBy_0').checked == true) {
            document.getElementById('dWords').style.display = 'block';
            number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
            var date = document.getElementById('tDOB').value;
            date = date.split('/');
            document.getElementById('lblRepeatWords').innerHTML = "Every " + number + " month on day " + date[0];
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
            var weekNo = new Date();
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
                document.getElementById('lblRepeatWords').innerHTML = "Monthly on " + weekText + " " + rptDays;

            }
            else {
                number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
                document.getElementById('lblRepeatWords').innerHTML = "Every " + number + " month on the " + weekText + " " + rptDays;

            }
        }
        else {
            document.getElementById('rdrptBy_0').checked = true;
            document.getElementById('dWords').style.display = 'block';
            number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
            var date = document.getElementById('tDOB').value;
            date = date.split('/');
            document.getElementById('lblRepeatWords').innerHTML = "Every " + number + " month on day " + date[0];
        }
    }
    else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Yearly') {
        document.getElementById('dWords').style.display = 'block';
        number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
        var date = document.getElementById('tDOB').value.split('/');
        var mon = date[1];
        document.getElementById('lblRepeatWords').innerHTML = "Every " + number + " year on " + months[date[1] - 1] + " " + date[0];
    }
    else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Yearly') {
        document.getElementById('dWords').style.display = 'block';
        number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
        document.getElementById('lblRepeatWords').innerHTML = "Every " + number + " days";
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
    if (document.getElementById('btnSubmit').value == 'Save') {
        document.getElementById('ACX2plus1').style.display = 'none';
        document.getElementById('ACX2minus1').style.display = 'block';
        document.getElementById('ACX2responses1').style.display = 'block';
        document.getElementById('ACX2plus2').style.display = 'none';
        document.getElementById('ACX2minus2').style.display = 'block';
        document.getElementById('ACX2responses2').style.display = 'block';
        document.getElementById('tblOnflowDetail').style.display = 'none';
        document.getElementById('txtPreSBP').focus();
    }
    if (document.getElementById('btnSubmit').value == 'Finish') {
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
        alert('Provide search text');
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
    if ((Lympho > 100 || Lympho != '') || (Mono > 100 || Mono != '') || (Neutro > 100 || Neutro != '')) {
        var Total = Number(Lympho) + Number(Mono) + Number(Neutro);
        if (Total != 100)
            alert('Sum of differential count should be equal to 100');
    }
    else {
        alert('Value cannot exceed 100 / value cannot be empty');
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
        alert('Provide search text');
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

    if (document.getElementById('uAd_tDName').value == '') {
        alert('Provide drug name');
        // document.getElementById('uAd_tDName').focus();
        return false;
    }
    if (document.getElementById('uAd_tFrm').value == '') {
        alert('Provide formulation');
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
        alert('Provide frequency');
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

    if (txtval == "") {
        drugFrm = document.getElementById('uAd_tFrm').value;
    }
    else if (txtval == "-Others-") {
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
    else if (txFrequencytval == "-Others-") {
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
            alert('Provide other instruction');
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
    if (document.getElementById('uAd_tDName').value == '') {
        alert('Provide drug name');
        document.getElementById('uAd_tDName').focus();
        return false;
    }
    if (document.getElementById('uAd_tFrm').value == '') {
        alert('Provide formulation');
        document.getElementById('uAd_tFrm').focus();
        return false;
    }
    if (document.getElementById('uAd_tDose').value == '') {
        alert('Provide dose');
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
            alert('Provide date');
            //document.getElementById('uAd_imgFDate').focus();
            return false;
        }
    }
    var drugName = document.getElementById('uAd_tDName').value;
    var drugFrm = document.getElementById('uAd_tFrm').value;
    var dDose = document.getElementById('uAd_tDose').value;
    var dROA = document.getElementById('uAd_tROA').value;
    var Freq = document.getElementById('uAd_tFRQ').value;
    //    var Dura = document.getElementById('uAd_txtFrequencyNumber').value;
    var Dura1 = document.getElementById('uAd_ddlFrequencyType').value;
    // Dura = Dura + ' ' + Dura1;
    var ctlDp = document.getElementById('uAd_ddlInstruction');
    var ddlIns = ctlDp.options[ctlDp.selectedIndex].value;
    var dDate = document.getElementById('uAd_txtDate').value;
    var dDateto = document.getElementById('uAd_txtToDate').value;
    var presID = document.getElementById('uAd_txtPresID').value;
    var retval = drugName + "~" + drugFrm + "~" + dDose + "~" + dROA + "~" + Freq + "~" + Dura1 + "~" + ddlIns + "~" + dDate + "~" + dDateto + "~" + presID;
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
    return false;
}



/* Check exsisting Drug */

function check() {

    var rowcount = document.getElementById('uAd_tabDrg1').rows.length;
    var rowlist = document.getElementById('uAd_tabDrg1').rows;
    var drugname = document.getElementById('uAd_tDName').value;
    var frmName = document.getElementById('uAd_tFrm').value;
    for (i = 1; i < rowcount; i++) {
        //    alert('Hsi...1  : ' + rowcount);
        var drug = rowlist[i].cells[1];
        //  alert('Hsi...2');
        var formmulation = rowlist[i].cells[2];
        //alert('Hsi...3');
        //alert('Drug :' + drug.firstChild.nodeValue + 'Formulation :' + formmulation.firstChild.nodeValue);
        if ((drug.firstChild.nodeValue == drugname) && (formmulation.firstChild.nodeValue == frmName)) {
            alert('Already exist');
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
    document.getElementById('txtPatientName').focus();
    window.scroll(0, 0);

}
function CancelBooking(bkid, Desc) {
    document.getElementById('hidBKID').value = bkid;
    document.getElementById('canDiv').style.display = 'block';
    document.getElementById('desc').style.display = 'none';
    document.getElementById('lDesc').innerHTML = Desc;
    document.getElementById('tCanDesc').focus();
}
/*PatientVisit.aspx*/
function onComboFocus() {
    if (document.getElementById('dPurpose').value == 'Select') {
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
    if (document.getElementById('ucCAdd_txtAddress2').value != '' && document.getElementById('ucCAdd_txtCity').value != '') {
        document.getElementById('cAdsame').checked = false;
        document.getElementById('CAD').style.display = "block";
        var IsCorporateOrg = document.getElementById('hdnIsCorpOrg').value;
        if (IsCorporateOrg == 'Y')
            document.getElementById('cAdsame').checked = true;
    }
}
function validationWithArrays(valVariable) {
    for (i = 0; i < valVariable.length; i++) {
        if (document.getElementById(valVariable[i]).value == '') {
            var alertName = valVariable[i].substr(3, valVariable[i].length);
            alert('Enter the ' + alertName);
            document.getElementById(valVariable[i]).focus();
            return false;
        }
    }
    return true;
}
function validationComboWithArrays(valVariable) {
    for (i = 0; i < valVariable.length; i++) {
        if (document.getElementById(valVariable[i]).value == 'Select') {
            var alertName = valVariable[i].substr(3, valVariable[i].length);
            alert('Enter the ' + alertName);
            document.getElementById(valVariable[i]).focus();
            return false;
        }
    }
    return true;
}
function validation(btnID) {

    //-----------------------------------------------------------Corporate Org
    var IsCorporateOrg = document.getElementById('hdnIsCorpOrg').value;
    if (IsCorporateOrg == 'Y') {
        //        if (document.getElementById('txtFileNo').value == '') {
        //            alert('Provide the txtFileNo');
        //            document.getElementById('txtFileNo').focus();
        //            return false;
        //        }

        if (document.getElementById('uctrlEmployer_ddlPatientType').selectedIndex == '0') {
            alert('Select Patient type');
            document.getElementById('uctrlEmployer_ddlPatientType').focus();
            return false;
        }
        else if (document.getElementById('uctrlEmployer_ddlPatientType').selectedIndex == '1') {
            if (document.getElementById('uctrlEmployer_ddlEmployementType').selectedIndex == '0') {
                alert('Select employee type');
                document.getElementById('uctrlEmployer_ddlEmployementType').focus();

                return false;
            }
            if (document.getElementById('uctrlEmployer_txtEmployementTypeNo').value == '') {
                alert('Provide employee number');
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
                alert('Select employer name');
                document.getElementById('uctrlEmployer_ddlEmployerName').focus();

                return false;
            }

        }
        else if (document.getElementById('uctrlEmployer_ddlPatientType').selectedIndex == '2') {
            if (document.getElementById('uctrlEmployer_ddlRelation').selectedIndex == '0') {
                alert('Select relationship');
                document.getElementById('uctrlEmployer_ddlRelation').focus();

                return false;
            }
            if (document.getElementById('uctrlEmployer_txtEmployerID').value == '') {
                alert('Provide employer number');
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
                alert('Select extended type');
                document.getElementById('uctrlEmployer_ddlExtended').focus();
                return false;
            }
            if (document.getElementById('uctrlEmployer_txtEmployerID').value == '') {
                alert('Provide employer number');
                document.getElementById('uctrlEmployer_txtEmployerID').focus();
                return false;
            }
        }

    }

    //----------------------------------------------------------------------------
    //----------------------------------------------------------------------------
    if (document.getElementById('txtName').value == '') {
        var userMsg = SListForApplicationMessages.Get('Commonmessages_1');
        if (userMsg != null) {
            alert(userMsg);

        }
        else {
            alert('Provide name');
        }
        document.getElementById('txtName').focus();
        return false;
    }
    if ((document.getElementById('tDOB').value == '') && (document.getElementById('txtDOBNos').value == '')) {
        var userMsg = SListForApplicationMessages.Get('Commonmessages_2');
        if (userMsg != null) {
            alert(userMsg);
        }
        else {
            alert('Provide Date Of Birth or Age');
        }

        document.getElementById('tDOB').focus();
        return false;
    }

    if (document.getElementById('ddMarital').value == 'Select') {
        var userMsg = SListForApplicationMessages.Get('Commonmessages_3');
        if (userMsg != null) {
            alert(userMsg);
        }
        else {
            alert('Select marital status');
        }
        document.getElementById('ddMarital').focus();
        return false;
    }
    //0 meaning for 0 is (--Select--)
    if (document.getElementById('ddSex').value == '0') {
        var userMsg = SListForApplicationMessages.Get('Commonmessages_4');
        if (userMsg != null) {
            alert(userMsg);
        }
        else {
            alert('Select sex');
        }
        document.getElementById('ddSex').focus();
        return false;
    }
    if (document.getElementById('hdnAddress').value == "N") {
        if (document.getElementById('txtAddress').value == '') {
            var userMsg = SListForApplicationMessages.Get('Commonmessages_5');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Provide address ');
            }
            document.getElementById('txtAddress').focus();
            return false;
        }
        if (document.getElementById('txtCity').value == '') {
            if (document.getElementById('txtAddress').value == '') {
                var userMsg = SListForApplicationMessages.Get('Commonmessages_6');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Provide city ');
                }
                document.getElementById('txtCity').focus();
                return false;
            }
        }
        if ((document.getElementById('txtMobile').value == '') && (document.getElementById('txtLandLine').value == '')) {
            var userMsg = SListForApplicationMessages.Get('Commonmessages_7');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Provide contact number');
            }
            document.getElementById('txtMobile').focus();
            return false;
        }

        if (document.getElementById('ddCountry').value == '') {
            var userMsg = SListForApplicationMessages.Get('Commonmessages_8');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Select country name');
            }
            document.getElementById('ddCountry').focus();
            return false;
        }
        if (document.getElementById('ddState').value == 'Select') {
            var userMsg = SListForApplicationMessages.Get('Commonmessages_9');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Select state name');
            }
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
            var userMsg = SListForApplicationMessages.Get('Commonmessages_10');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Provide URN number');
            }
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
            var userMsg = SListForApplicationMessages.Get('Commonmessages_11');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Select URN type ');
            }
            document.getElementById('URNControl1_ddlUrnType').focus();
            return false;
        }
    }
    if (document.getElementById('hdnAddress').value == "Y") {
        if (document.getElementById('ucPAdd_txtAddress2').value == '') {
            var userMsg = SListForApplicationMessages.Get('Commonmessages_5');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Provide address ');
            }
            document.getElementById('ucPAdd_txtAddress2').focus();
            return false;
        }
        if (document.getElementById('ucPAdd_txtCity').value == '') {

            var userMsg = SListForApplicationMessages.Get('Commonmessages_6');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Provide city ');
            }
            document.getElementById('ucPAdd_txtCity').focus();
            return false;
        }
        if ((document.getElementById('ucPAdd_txtMobile').value == '') && (document.getElementById('ucPAdd_txtLandLine').value == '')) {
            var userMsg = SListForApplicationMessages.Get('Commonmessages_12');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Provide any one contact number');
            }
            document.getElementById('ucPAdd_txtMobile').focus();
            return false;
        }
    }
    if (document.getElementById('CAD').style.display == 'block') {
        if (document.getElementById('ucCAdd_txtAddress2').value == '') {
            var userMsg = SListForApplicationMessages.Get('Commonmessages_13');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Provide the street/road name in current address');
            }
            document.getElementById('ucCAdd_txtAddress2').focus();
            return false;
        }
        //        if (document.getElementById('ucCAdd_txtCity').value == '') {
        //            alert('Enter the Current City');
        //            document.getElementById('ucCAdd_txtCity').focus();
        //            return false;
        //        }
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
                var userMsg = SListForApplicationMessages.Get('Commonmessages_14');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {

                    alert('Select a reason for Re-Issue of Smart Card');
                }
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
            var userMsg = SListForApplicationMessages.Get('Commonmessages_15');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Browse a file to upload.');

            }
            $("#[name$='PhotoUpload']").focus();
            return false;
        }
        else if (PhotoUpload.length > 0 || PhotoUpload.length < 4194304) {
            extension = PhotoUpload.substring(PhotoUpload.lastIndexOf('.')).toLowerCase();
            var ValidFileType = ".jpg, .png, .gif, .jpeg, .bmp";
            if (ValidFileType.indexOf(extension) < 0) {
                var userMsg = SListForApplicationMessages.Get('Commonmessages_16');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('The file must have an extension of (.jpg, .png, .gif, .jpeg, .bmp)');
                }
                $("#[name$='PhotoUpload']").focus();
                return false;
            }
        }
        else {

            var userMsg = SListForApplicationMessages.Get('Commonmessages_17');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Maximum size of the file is 4 MB only.');
            }
        }
    }

    if (btnID == 'btnFinish') {
        document.getElementById('btnFinish').style.display = 'none';
        document.getElementById('hdnBtnStatus').value = '0';
    }
    if (btnID == 'btnUpdate') {
        document.getElementById('btnUpdate').style.display = 'none';
        document.getElementById('hdnBtnStatus').value = '1';
    }
    if (btnID == 'btnURNo') {
        document.getElementById('btnURNo').style.display = 'none';
        document.getElementById('hdnBtnStatus').value = '2';
    }

    return true;
}
function searchValidate() {
    //if(document.getElementById('txtPatientNo').value=='' && document.getElementById('txtPatientName').value=='' && document.getElementById('txtRelation').value=='' &&document.getElementById('txtLocation').value=='' && document.getElementById('txtOthers').value=='') {
    if (document.getElementById('txtPatientNo').value == '') {
        alert('Provide at least one filter criterion');
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
    if (document.getElementById("pid").value == '') {
        var userMsg = SListForApplicationMessages.Get('Reception\\PatientSearch.aspx_1');
        if (userMsg != null) {
            alert(userMsg);
        }
        else {
            alert('Select patient name');
        }
        return false;
    }
    if (document.getElementById('hdnPatientRegistrationStatus').value == 'N') {
        if (document.getElementById('dList').value == 'Edit_Patient_Admission_Details_InPatientRegistration' || document.getElementById('dList').value == 'BloodBank_BloodRequest') {
            return true;
        }


        else {
            var userMsg = SListForApplicationMessages.Get('Reception\\InPatientSearch.aspx_2');
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert('This action cannot be performed for the client patient');
                return false;
            }
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
    if ((keyCode >= 48 && keyCode <= 90) || (keyCode >= 96 && keyCode <= 105) || (keyCode == 108) || (keyCode == 119) || (keyCode == 110) || (keyCode == 32) || (keyCode == 111) || (keyCode == 118) || (keyCode == 8) || (keyCode == 9) || (keyCode == 12) || (keyCode == 27) || (keyCode == 37) || (keyCode == 39) || (keyCode == 46) || (keyCode == 190) || (keyCode == 188)) {
        return true;
    }
    else {
        return false;
    }

    //    var keyCode = evt.which ? evt.which : evt.keyCode;
    //    return keyCode < '0'.charCodeAt() || keyCode > '9'.charCodeAt();
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

        var txtValue = document.getElementById(txtID).value;

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
    if (document.getElementById(focusId).value == '') {
        document.getElementById(focusId).focus();
    }
}
function onComboFocus(focusId) {
    if (document.getElementById(focusId).value == '-----Select-----') {
        document.getElementById(focusId).focus();
    }
    else if (document.getElementById(focusId).value == 'Select') {
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

    if (document.getElementById('hdnpwdplcycount').value != '0') {

        if (document.getElementById('txtOldpassword').value == '') {
            alert('Provide old password');
            document.getElementById('txtOldpassword').focus();
            return false;
        }


        if (document.getElementById('txtNewpassword').value == '') {
            alert('Provide new password');
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtConfirmpassword').value == '') {
            alert('Provide confirm password');
            document.getElementById('txtConfirmpassword').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value.length < 6) {
            alert('Password length should be minimum of 6 characters.');
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        var passlen = document.getElementById("hdnpasslength").value;
        if (document.getElementById('txtNewpassword').value.length > Number(passlen)) {
            alert('Maximum Length Reached Please check Password Hint.');
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value != document.getElementById('txtConfirmpassword').value) {
            alert('There is a password mismatch');
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }
        if (document.getElementById('txtOldpassword').value == document.getElementById('txtNewpassword').value) {
            alert('New password and old password cannot be same');
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
                alert('Password Policy Mismatch Please check Password Hint');
                document.getElementById('txtNewpassword').value = '';
                document.getElementById('txtConfirmpassword').value = '';
                document.getElementById('txtNewpassword').focus();
                return false;
            }

        }

    }
    else {

        if (document.getElementById('txtOldpassword').value == '') {
            alert('Provide old password');
            document.getElementById('txtOldpassword').focus();
            return false;
        }


        if (document.getElementById('txtNewpassword').value == '') {
            alert('Provide new password');
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtConfirmpassword').value == '') {
            alert('Provide confirm password');
            document.getElementById('txtConfirmpassword').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value.length < 6) {
            alert('Password length should be minimum of 6 characters.');
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value != document.getElementById('txtConfirmpassword').value) {
            alert('There is a password mismatch');
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }
        if (document.getElementById('txtOldpassword').value == document.getElementById('txtNewpassword').value) {
            alert('New password and old password cannot be same');
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
                alert('Password should contain atleast one special character,an alphabet and a number');
                document.getElementById('txtNewpassword').value = '';
                document.getElementById('txtConfirmpassword').value = '';
                document.getElementById('txtNewpassword').focus();
                return false;
            }

        }


    }

    if (document.getElementById('hdntranspwdplcycount').value != '0') {


        if (document.getElementById('Txtoldtranspwd').value == '') {
            alert('Provide old Transaction password');
            document.getElementById('Txtoldtranspwd').focus();
            return false;
        }

        if (document.getElementById('TxtNewtranspwd').value == '') {
            alert('Provide New Transaction password');
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }

        if (document.getElementById('TxtconTranspwd').value == '') {
            alert('Provide Confirm Transaction password');
            document.getElementById('TxtconTranspwd').focus();
            return false;
        }



        if (document.getElementById('TxtNewtranspwd').value.length < 6) {
            alert('Transaction Password length should be minimum of 6 characters.');
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }

        var passlen = document.getElementById("hdntranspasslength").value;
        if (passlen != "") {
            if (document.getElementById('TxtNewtranspwd').value.length > Number(passlen)) {
                alert('Maximum Length Reached Please check transaction Password Hint.');
                document.getElementById('TxtNewtranspwd').value = '';
                document.getElementById('TxtconTranspwd').value = '';
                document.getElementById('TxtNewtranspwd').focus();
                return false;
            }
        }

        if (document.getElementById('Txtoldtranspwd').value == document.getElementById('TxtNewtranspwd').value) {
            alert('New Transaction password and old Transaction password cannot be same');
            document.getElementById('Txtoldtranspwd').value = '';
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('Txtoldtranspwd').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value == document.getElementById('TxtNewtranspwd').value) {
            alert('New password and Transaction password cannot be same');
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }



        if (document.getElementById('TxtNewtranspwd').value != document.getElementById('TxtconTranspwd').value) {
            alert('There is a Transaction password mismatch');
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
                alert('Transaction Password Policy Mismatch Please check Transaction Password Hint');
                document.getElementById('TxtNewtranspwd').value = '';
                document.getElementById('TxtconTranspwd').value = '';
                document.getElementById('TxtNewtranspwd').focus();
                return false;
            }

        }

    }

    else {

        if (document.getElementById('Txtoldtranspwd').value == '') {
            alert('Provide old Transaction password');
            document.getElementById('Txtoldtranspwd').focus();
            return false;
        }

        if (document.getElementById('TxtNewtranspwd').value == '') {
            alert('Provide New Transaction password');
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }

        if (document.getElementById('TxtconTranspwd').value == '') {
            alert('Provide Confirm Transaction password');
            document.getElementById('TxtconTranspwd').focus();
            return false;
        }



        if (document.getElementById('TxtNewtranspwd').value.length < 6) {
            alert('Transaction Password length should be minimum of 6 characters.');
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }


        if (document.getElementById('Txtoldtranspwd').value == document.getElementById('TxtNewtranspwd').value) {
            alert('New Transaction password and old Transaction password cannot be same');
            document.getElementById('Txtoldtranspwd').value = '';
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('Txtoldtranspwd').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value == document.getElementById('TxtNewtranspwd').value) {
            alert('New password and Transaction password cannot be same');
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }



        if (document.getElementById('TxtNewtranspwd').value != document.getElementById('TxtconTranspwd').value) {
            alert('There is a Transaction password mismatch');
            document.getElementById('TxtNewtranspwd').value = '';
            document.getElementById('TxtconTranspwd').value = '';
            document.getElementById('TxtNewtranspwd').focus();
            return false;
        }




        if (document.getElementById('TxtNewtranspwd').value == document.getElementById('TxtconTranspwd').value) {
            var pw = document.getElementById('TxtconTranspwd').value;
            var passed = validatePassword(pw, { alpha: 1, special: 1, numeric: 1 });
            if (!passed) {
                alert('Transaction Password should contain atleast one special character,an alphabet and a number');
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

    if (document.getElementById('hdnpwdplcycount').value != '0') {

        if (document.getElementById('txtOldpassword').value == '') {
            alert('Provide old password');
            document.getElementById('txtOldpassword').focus();
            return false;
        }
        if (document.getElementById('txtNewpassword').value == '') {
            alert('Provide new password');
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtConfirmpassword').value == '') {
            alert('Provide confirm password');
            document.getElementById('txtConfirmpassword').focus();
            return false;
        }
        if (document.getElementById('txtNewpassword').value.length < 6) {
            alert('Password length should be minimum of 6 characters.');
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        var passlen = document.getElementById("hdnpasslength").value;
        if (document.getElementById('txtNewpassword').value.length > Number(passlen)) {
            alert('Maximum Length Reached Please check Password Hint.');
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtOldpassword').value == document.getElementById('txtNewpassword').value) {
            alert('New password and old password cannot be same');
            document.getElementById('txtOldpassword').value = '';
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtOldpassword').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value != document.getElementById('txtConfirmpassword').value) {
            alert('There is a password mismatch');
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
            var passed = validatePassword(pw, { alpha: 1, special: splchar, numeric: numchar });
            if (!passed) {
                alert('Password Policy Mismatch Please check Password Hint');
                document.getElementById('txtNewpassword').value = '';
                document.getElementById('txtConfirmpassword').value = '';
                document.getElementById('txtNewpassword').focus();
                return false;
            }

        }
    }
    else {
        if (document.getElementById('txtOldpassword').value == '') {
            alert('Provide old password');
            document.getElementById('txtOldpassword').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value == '') {
            alert('Provide new password');
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtConfirmpassword').value == '') {
            alert('Provide confirm password');
            document.getElementById('txtConfirmpassword').focus();
            return false;
        }


        if (document.getElementById('txtNewpassword').value.length < 6) {
            alert('Password length should be minimum of 6 characters.');
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }


        if (document.getElementById('txtOldpassword').value == document.getElementById('txtNewpassword').value) {
            alert('New password and old password cannot be same');
            document.getElementById('txtOldpassword').value = '';
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtOldpassword').focus();
            return false;
        }

        if (document.getElementById('txtNewpassword').value != document.getElementById('txtConfirmpassword').value) {
            alert('There is a password mismatch');
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }



        if (document.getElementById('txtNewpassword').value == document.getElementById('txtConfirmpassword').value) {
            var pw = document.getElementById('txtConfirmpassword').value;
            var passed = validatePassword(pw, { alpha: 1, special: 1, numeric: 1 });
            if (!passed) {
                alert('Password should contain atleast one special character,an alphabet and a number');
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
        lower: /[a-z]/g,
        upper: /[A-Z]/g,
        alpha: /[A-Z]/gi,
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
    if (pat == '')
        alert('Provide the value for patient');
    else if (ctrl == '')
        alert('Provide the value for control');

    //alert(Math.pow((Number(pat) / Number(ctrl)), isi));
    document.getElementById('2047_txtINR').value = Math.pow((Number(pat) / Number(ctrl)), isi).toFixed(2);
}
//PatientiDiagnose.aspx
function ShowProfile(obj) {

    if (document.getElementById(obj).style.display == 'none') {

        document.getElementById(obj).style.display = 'block';
        document.getElementById('dMain').style.display = 'none';
    }
    else {
        document.getElementById(obj).style.display = 'none';
        document.getElementById('dMain').style.display = 'block';
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
    document.getElementById('uAd_tDName').value = '';
    // document.getElementById('uAd_tFrm').value = 'Tab.';
    //document.getElementById('uAd_tROA').value = '';
    document.getElementById('uAd_tDose').value = '';
    document.getElementById('uAd_txtFrequencyNumber').value = '1';
    document.getElementById('uAd_ddlFrequencyType').value = 'Day(s)';

    document.getElementById('uAd_tDura').value = '';
    document.getElementById('uAd_ddlInstruction').value = '';
    document.getElementById('uAd_ddFormulation').value = 'Tab.';
    document.getElementById('uAd_tFrm').style.display = 'none';
    document.getElementById('uAd_ddFrequency').value = '-Select-';
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

    if (document.getElementById('txtPatientName').value.trim() == '') {
        alert('Provide Patient name');
        document.getElementById('txtPatientName').focus();
        return false;
    }

    if (document.getElementById('txtAge').value.trim() == '') {
        alert('Provide Patient age');
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
            alert('Provide the URN type ');
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
        alert('Select Doctor name');
        document.getElementById('ddlPhysician').focus();
        return false;
    }
    else if (document.getElementById('chkPhyOthers').checked) {
        if (document.getElementById('txtDrName').value.trim() == '') {
            alert('Provide Doctor name');
            document.getElementById('txtDrName').focus();
            return false;
        }
    }

    if ((document.getElementById('ddlHospital').value == "0") && (document.getElementById('ddlBranch').value == "0")) {
        if (document.getElementById('rdOthers').checked == false) {
            alert('Select Hospital/branch');
            return false;
        }
    }
    if ((document.getElementById('rdPackage').checked == true) && (document.getElementById('ddlPkg').options[0].selected == true)) {
        alert('Select Insurance');
        document.getElementById('ddlPkg').focus();
        return false;
    }
    if ((document.getElementById('rdClient').checked == true) && (document.getElementById('ddlClients').options[0].selected == true)) {
        alert('Select Client');
        document.getElementById('ddlClients').focus();
        return false;
    }
    if ((document.getElementById('rdClient').checked == true) && (document.getElementById('ddlClients').options[document.getElementById('ddlClients').selectedIndex].text == 'Collection Centre')) {
        if (document.getElementById('ddlCollectionCentre').value == '0') {
            alert('Select Collection Centre');
            document.getElementById('ddlCollectionCentre').focus();
            return false;
        }
    }
    if (document.getElementById('ddPublishingMode').value == '0' && document.getElementById('txtEmailID').value == '') {
        alert('Select Publishing Mode');
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
            alert('Select Publishing Mode');
            document.getElementById('ddPublishingMode').focus();
            return false;
        }
        if (document.getElementById('txtName').value == '') {
            alert('Provide Name');
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
            alert('Provide City');
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
//MemberShipCarNo added by Thamilselvan.R on 02 Feb 2015 to Get the coupon No
function SelectedBillNo(rid, patid, pid, vid, pName, pNumber, BillID, billStatus, BillNo, MemberShipCarNo, ClientID, RefVisitID) {

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
    VisitDetails(vid, pid, pName, pNumber, BillID, BillNo, MemberShipCarNo, ClientID, RefVisitID); //MemberShipCarNo added by Thamilselvan.R on 02 Feb 2015 to Get the coupon No
}

function pBillValidation() {
    if (document.getElementById("bid").value == '') {
        alert('Select a bill');
        return false;
    }

}
function checkFromDateToDateold(fromDate, toDate) {
    var today = new Date();
    var stfromDate = document.getElementById(fromDate).value;
    var sttoDate = document.getElementById(toDate).value;
    var dd = stfromDate.substring(0, 2);
    var mm = stfromDate.substring(3, 5);
    var yy = stfromDate.substring(6, 10);
    var fromDate = new Date();
    fromDate.setFullYear(yy, mm - 1, dd);
    dd = sttoDate.substring(0, 2);
    mm = sttoDate.substring(3, 5);
    yy = sttoDate.substring(6, 10);
    var toDate = new Date();
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
function checkFromDateToDate(fromDate, toDate) {
    var today = new Date();
    var stfromDate = document.getElementById(fromDate).value;
    var sttoDate = document.getElementById(toDate).value;
    var dd = stfromDate.substring(0, 2);
    var mm = stfromDate.substring(3, 5);
    var yy = stfromDate.substring(6, 10);
    var fromDate = new Date();
    fromDate.setFullYear(yy, mm - 1, dd);

    dd = sttoDate.substring(0, 2);

    mm = sttoDate.substring(3, 5);

    yy = sttoDate.substring(6, 10);

    var toDate = new Date();
    toDate.setFullYear(yy, mm - 1, dd);

    if (fromDate.format("dd/yy") > today.format("dd/yy")) {
        //alert("Please Check. From Date Greater than Current Date.");
        // return false;
    }

    if (toDate.format("dd/yy") > today.format("dd/yy")) {
        // alert("Please Check. To Date Greater than Current Date.");
        // return false;
    }

    if (toDate.format("dd/yy") < fromDate.format("dd/yy")) {
        // alert("Please Check. To Date is Less than From Date.");
        // return false;
    }

}
function checkForCurrentDate(dateFieldId, dateFieldText) {
    var currentDate = new Date();
    if (document.getElementById(dateFieldId).value != '') {
        if (Date.parse(document.getElementById(dateFieldId).value) > Date.parse(currentDate.format("dd/MM/yyyy"))) {
            // alert("Please Check. " + dateFieldText + " is Greater than Current Date.");
            // return false;
        }
    }

}
function checkForFutureDate(dateFieldId, dateFieldText) {
    var currentDate = new Date();
    if (document.getElementById(dateFieldId).value != '') {
        if (Date.parse(document.getElementById(dateFieldId).value) < Date.parse(currentDate.format("dd/MM/yyyy"))) {
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
        document.getElementById('plus' + ID).src = '../Images/plus.png';
    }
    else {
        document.getElementById(ID).style.display = 'block';
        document.getElementById('plus' + ID).src = '../Images/minus.png';
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
        alert('Provide the LMP date');
        //document.getElementById(frmId).value = '__/__/____';
        document.getElementById(frmId).focus();
        return false;
    }
}

/* General Advice */

function GenAdvicevalidation() {
    if (document.getElementById('uGAdv_tTreatmentAdvice').value == '') {
        alert('Provide the Advice');
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
        alert('Provide the Advice');
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
    if (document.getElementById('ucSC_ddlSamples').value == '0') {
        alert('Select Sample');
        document.getElementById('ucSC_ddlSamples').focus();
        return false;
    }
    if (document.getElementById('ucSC_ddlAttributes').value == '0') {
        alert('Select sample attributes');
        document.getElementById('ucSC_ddlAttributes').focus();
        return false;
    }
    if ((document.getElementById('ucSC_txtValues').value == '') && (document.getElementById('ucSC_txtDescription').value == '')) {
        alert('Provide the sample values or comments');
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

function checkMobileNumber() {

    var cmn = document.getElementById('ucPAdd_txtMobile').value;
    if (document.getElementById('ucPAdd_txtMobile').value != '') {
        //        if ((cmn.substr(0, 1) == "9") || (cmn.substr(0, 1) == "8")) {
        //            if (cmn.length < 10) {
        //                alert("Enter 10 Digits valid Mobile No");
        //                document.getElementById('ucPAdd_txtMobile').value = '';
        //                document.getElementById('ucPAdd_txtMobile').focus();
        //            }
        //            else {

        //            }
        //        }
        //        else if ((cmn.substr(0, 1) != "9") && (cmn.substr(0, 1) != "8")) {
        //            alert("Enter valid Mobile No");
        //            document.getElementById('ucPAdd_txtMobile').value = '';
        //            document.getElementById('ucPAdd_txtMobile').focus();
        //        }
        //        else {

        //        }
    }
}

function checkLandLineNumber() {

    var clln = document.getElementById('ucPAdd_txtLandLine').value;

    if (document.getElementById('ucPAdd_txtLandLine').value != '') {
        if (clln.length < 6) {
            alert('Provide the correct land line number');
            document.getElementById('ucPAdd_txtLandLine').value = '';
            document.getElementById('ucPAdd_txtLandLine').focus();
        }
        else {

        }
    }
    else {

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
        alert('Discount cannot be greater than amount');
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
        alert('Provide the quantity');
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
    if (confirm('Are you sure You want to LogOut Now. Continue?')) {
        alert('Confirm');
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
            result = confirm("Amount Received is Zero. Do you want to continue?");
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
function setCompletedStatus(GrpName, id, IsAutoValidate) {
 
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
                var isPendingExists = 'false';
                var isValidateExists = 'false';
                var CompletedValue = 0;
                var PendingValue = 0;
                var ValidateValue = 0;
                for (var i = 0; i < len; i++) {
                    var drpdwnVal = drpdwn.options[i].value.split("_");
                    //if (drpdwn.options[i].text == 'Completed') {
                    if (drpdwnVal[0] == 'Completed') {
                        isCompletedExists = 'true';
                        CompletedValue = drpdwn.options[i].value;
                    }
                    //if (drpdwn.options[i].text == 'Pending') {
                    if (drpdwnVal[0] == 'Pending') {
                        isPendingExists = 'true';
                        PendingValue = drpdwn.options[i].value;
                    }
                    if (drpdwnVal[0] == 'Validate') {
                        isValidateExists = 'true';
                        ValidateValue = drpdwn.options[i].value;
                    }
                }
                if (len > 0 && isCompletedExists == 'true' && txtValuLen > 0) {
                    if (document.getElementById("hdnDefaultDropDownStatus") != null && document.getElementById("hdnDefaultDropDownStatus").value != "") {
                        var status = document.getElementById("hdnDefaultDropDownStatus").value + "_1";
                        document.getElementById(x[0] + "_ddlstatus").value = status;
                    }
                    else if (isValidateExists == 'true' && IsAutoValidate == 'Y') {
                        document.getElementById(x[0] + "_ddlstatus").value = ValidateValue;
                    }
                    else {
                        document.getElementById(x[0] + "_ddlstatus").value = CompletedValue;
                    }
                } else if (isPendingExists == 'true') {
                if (document.getElementById("hdnDefaultDropDownStatus") != null && document.getElementById("hdnDefaultDropDownStatus").value != "") {
                    var status = document.getElementById("hdnDefaultDropDownStatus").value + "_1";
                    document.getElementById(x[0] + "_ddlstatus").value = status;
                }
                else {
                    document.getElementById(x[0] + "_ddlstatus").value = PendingValue;
                }
                }
            }
            else {
                var isCompletedExists = 'false';
                var isPendingExists = 'false';
                var CompletedValue = 0;
                var PendingValue = 0;
                var isValidateExists = 'false';
                var ValidateValue = 0;
                for (var i = 0; i < len; i++) {
                    var drpdwnVal = drpdwn.options[i].value.split("_");
                    //if (drpdwn.options[i].text == 'Completed') {
                    if (drpdwnVal[0] == 'Completed') {
                        isCompletedExists = 'true';
                        CompletedValue = drpdwn.options[i].value;
                    }
                    //if (drpdwn.options[i].text == 'Pending') {
                    if (drpdwnVal[0] == 'Pending') {
                        isPendingExists = 'true';
                        PendingValue = drpdwn.options[i].value;
                    }
                    if (drpdwnVal[0] == 'Validate') {
                        isValidateExists = 'true';
                        ValidateValue = drpdwn.options[i].value;
                    }
                }
                if (len > 0 && isCompletedExists == 'true') {
                    if (document.getElementById("hdnDefaultDropDownStatus") != null && document.getElementById("hdnDefaultDropDownStatus").value != "") {
                        var status = document.getElementById("hdnDefaultDropDownStatus").value + "_1";
                        document.getElementById(x[0] + "_ddlstatus").value = status;
                    }
                    else if (isValidateExists == 'true' && IsAutoValidate == 'Y') {
                        document.getElementById(x[0] + "_ddlstatus").value = ValidateValue;
                    }
                    else {
                        document.getElementById(x[0] + "_ddlstatus").value = CompletedValue;
                    }
                } else if (isPendingExists == 'true') {
                    document.getElementById(x[0] + "_ddlstatus").value = PendingValue;
                }

            }
        }
        else {
            var multiControl = false;
            var secondResultValue = "";
            if (type.indexOf("select") >= 0) {
                var txt = document.getElementById(x[0] + "_txtValue");
                if (document.getElementById(x[0] + "_txtValue") != null) {
                    multiControl = true;
                    secondResultValue = document.getElementById(x[0] + "_txtValue").value;
                }
            }
            else {
                var ddl = document.getElementById(x[0] + "_ddlData");
                if (ddl != null && ddl.selectedIndex > 0) {
                    multiControl = true;
                    secondResultValue = ddl.options[ddl.selectedIndex].text;
                }
            }

            var PendingValue = 0;
            var isValidateExists = 'false';
            var ValidateValue = 0;
            var len = document.getElementById(x[0] + "_ddlstatus").options.length;
            var drpdwn = document.getElementById(x[0] + "_ddlstatus");
            for (var i = 0; i < len; i++) {
                var drpdwnVal = drpdwn.options[i].value.split("_");
                //if (drpdwn.options[i].text == 'Completed') {
                if (drpdwnVal[0] == 'Completed') {
                    isCompletedExists = 'true';
                    CompletedValue = drpdwn.options[i].value;
                }
                //if (drpdwn.options[i].text == 'Pending') {
                if (drpdwnVal[0] == 'Pending') {
                    isPendingExists = 'true';
                    PendingValue = drpdwn.options[i].value;
                }
                if (drpdwnVal[0] == 'Validate') {
                    isValidateExists = 'true';
                    ValidateValue = drpdwn.options[i].value;
                }
            }
            if (multiControl == true && secondResultValue.trim() != "" && isCompletedExists == 'true') {
                if (document.getElementById("hdnDefaultDropDownStatus") != null && document.getElementById("hdnDefaultDropDownStatus").value != "") {
                    var status = document.getElementById("hdnDefaultDropDownStatus").value + "_1";
                    document.getElementById(x[0] + "_ddlstatus").value = status;
                }
                else if (isValidateExists == 'true' && IsAutoValidate == 'Y') {
                    document.getElementById(x[0] + "_ddlstatus").value = ValidateValue;
                }
                else {
                    document.getElementById(x[0] + "_ddlstatus").value = CompletedValue;
                }
            }
            else if (isPendingExists == 'true') {
                document.getElementById(x[0] + "_ddlstatus").value = PendingValue;
            }
        }
        ChangeGroupStatus(GrpName, x[0] + "_ddlstatus", "");
    }
    catch (e) {
        return false;
    }
    return true;
}

//for Value Type Decimals validation - Start
function setCompletedStatusValueType(evt, GrpName, id, deciDigits, IsAutoValidate) {
    try {
        setCompletedStatus(GrpName, id, IsAutoValidate);
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
    if (document.getElementById('uIAdv_txtQty').value != '') {
        var T1 = document.getElementById('uIAdv_txtQty').value;
        var ttotal = format_number(Number(T1), 1);
        var totals = ttotal.split('.');
        if (totals[1] == '0') {
        }
        else {
            alert('Please enter the round qty.');
            return false;
        }
    }
    else {
        alert('Provide Quantity');
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
function InventoryValidation() {
    if (document.getElementById('uIAdv_hdnInvtaskStatusID').value == '0' || document.getElementById('uIAdv_hdnInvtaskStatusID').value == '1') {
    }
    else {
        alert('The prescription part cannot be altered as the task in pharmacy is already picked.');
        return false;
    }
    if (document.getElementById('uIAdv_tDName').value == '') {
        alert('Provide drug name');
        document.getElementById('uIAdv_tDName').focus();
        return false;
    }
    if (document.getElementById('uIAdv_ddFrequency').value == '') {
        alert('Provide frequency type');
        document.getElementById('uIAdv_ddFrequency').focus();
        return false;
    }

    //    if (document.getElementById('uIAdv_routeBlock1').style.display == "block") {
    //        if (document.getElementById('uIAdv_tROA').value == '') {
    //            alert('Enter the Route');
    //            document.getElementById('uIAdv_tROA').focus();
    //            return false;
    //        }
    //    }
    if (document.getElementById('uIAdv_tFRQ').value == '') {
        alert('Provide the frequency');
        document.getElementById('uIAdv_tFRQ').focus();
        return false;
    }
    //^\d{3}([\- ]?)\d{2}([\- ]?)\d{4}$
    if (document.getElementById('uIAdv_ddFrequency').value == '-Others-') {
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
    var txFrequencytval = ddFrequency.options[ddFrequency.selectedIndex].value;
    if (txFrequencytval == '-Others-') {
        var txFrequencytval = document.getElementById('uIAdv_tFRQ').value
    }
    else {
        var txFrequencytval = ddFrequency.options[ddFrequency.selectedIndex].value;
    }
    var ddDirection = document.getElementById('uIAdv_ddDirection');
    var txddDirectionval = ddDirection.options[ddDirection.selectedIndex].value;

    if (txFrequencytval == "") {
        strdFrq = document.getElementById('uIAdv_tFRQ').value;
    }

    else {
        strdFrq = txFrequencytval;
    }
    var Qty = document.getElementById('uIAdv_txtQty').value;
    var dDose = document.getElementById('uIAdv_tDose').value;
    var dROA = document.getElementById('uIAdv_tROA').value;
    var ctlDp = document.getElementById('uIAdv_ddlInstruction');
    var ddlIns = ctlDp.options[ctlDp.selectedIndex].value;
    if (ddlIns == "Other") {
        //ddlIns = document.getElementById('uIAdv_txtINS').value;

        if (document.getElementById('uIAdv_txtINS').value == "") {
            alert('Provide instruction for others');
            document.getElementById('uIAdv_txtINS').focus();
            return false;
        }
    }
    else {
        ctlDp = document.getElementById('uIAdv_ddlInstruction');
        ddlIns = ctlDp.options[ctlDp.selectedIndex].value;
    }
    if (document.getElementById('uIAdv_txtINS').value != "" && document.getElementById('uIAdv_txtINS').value != document.getElementById('uIAdv_txtINS').title) {
        if (ddlIns != "Other") {
            ddlIns = ddlIns + '-' + document.getElementById('uIAdv_txtINS').value;
        }
        else {
            ddlIns = document.getElementById('uIAdv_txtINS').value;
        }
        document.getElementById('uIAdv_txtINS').value = document.getElementById('uIAdv_txtINS').title;
    }
    var Dura = document.getElementById('uIAdv_txtFrequencyNumber').value;
    var Dur = document.getElementById('uIAdv_ddlFrequencyType');
    var Dura1 = Dur.options[Dur.selectedIndex].value;
    Dura = Dura + ' ' + Dura1;
    var productID = document.getElementById('uIAdv_hdnProductID').value;
    var AutoID = document.getElementById('uIAdv_hdnAutoID').value;
    var TaskID = document.getElementById('uIAdv_hdnTaskID').value;


    if (productID == "undefined") {
        productID = 0;

    }
    else {
        var splitColon = productID.split(':');
        var splitColonRes = splitColon[1];
        var pProductID = splitColonRes.split(')');
        productID = pProductID[0];

    }
    var retval = drugName + "~" + dDose + "~" + dROA + "~" + strdFrq + "~" + txddDirectionval + "~" + Dura + "~" + ddlIns + "~" + productID + "~" + AutoID + "~" + TaskID + "~" + Qty;

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
    document.getElementById('uIAdv_ddFrequency').value = '';
    document.getElementById('uIAdv_ddDirection').value = '';
    document.getElementById('uIAdv_tDura').value = '';
    //document.getElementById('uIAdv_tFRQ').value = '1-0-0';
    document.getElementById('uIAdv_txtQty').value = '';
    document.getElementById('uIAdv_ddlInstruction').value = '';

    //document.getElementById('uIAdv_ddFrequency').value = '1-0-0';
    document.getElementById('uIAdv_tDName').focus();
    document.getElementById('uIAdv_hdnProductID').value = "";
    document.getElementById('uIAdv_hdnAutoID').value = 0;
    document.getElementById('uIAdv_hdnTaskID').value = 0;

    return false;
}

function validateUsers() {
    if (document.getElementById('txtUserName').value == '') {
        alert('Provide User name');
        document.getElementById('txtUserName').focus();
        return false;
    }
    if (document.getElementById('txtPassword').value == '') {
        alert('Provide Password');
        document.getElementById('txtPassword').focus();
        return false;
    }
}

function checkProductValidation(txtProduct) {
    if (document.getElementById(txtProduct).value.trim() == '') {
        alert('Provide the Product name');
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

    if (document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tDName').value == '') {
        alert('Provide drug name');
        // document.getElementById('uAd_tDName').focus();
        return false;
    }
    if (document.getElementById('tcEMR_tpHistory_ucHistory_uAd_tFrm').value == '') {
        alert('Provide the Formulation');
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
        alert('Provide the Frequency');
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

    if (document.getElementById('uNewAd_tDName').value == '') {
        alert('Provide drug name');
        // document.getElementById('uNewAd_tDName').focus();
        return false;
    }
    if (document.getElementById('uNewAd_tFrm').value == '') {
        alert('Provide the Formulation');
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
        alert('Provide the Frequency');
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
            alert('Provide instruction for others');
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
            var days = new Date();

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
    if (document.getElementById('URNControl1_hdnUrn').value == '0') {
        if (document.getElementById('URNControl1_txtURNo').value != '' && document.getElementById('URNControl1_ddlUrnType').value != '0') {
            WebService.GetURN(document.getElementById('URNControl1_ddlUrnType').value, document.getElementById('URNControl1_txtURNo').value, GetURN);
        }
    }

}
function GetURN(URnList) {
    if (URnList.length > 0) {
        alert(' Already exist in this URN type');
        document.getElementById('URNControl1_txtURNo').value = "";
        document.getElementById('URNControl1_txtURNo').focus();
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
            var days = new Date();

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
                //                else {
                //                    age = age - 1;
                //                }
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
    var s = pNumber.toString();
    var Len = pNumber.toString().length;
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
            return true;
        default:
            return false;
    }
}


/* new code*/

function Showmenu() {
    if (document.getElementById('menu').style.display == 'block')
        document.getElementById('menu').style.display = 'none';
    else
        document.getElementById('menu').style.display = 'block';

    return false;
}
function Showhide() {
    if (document.getElementById('showmenu').src.split('Images')[1] == '/show.png')
        document.getElementById('showmenu').src = '../Images/hide.png';
    else if (document.getElementById('showmenu').src.split('Images')[1] == '/hide.png')
        document.getElementById('showmenu').src = '../Images/show.png';

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
//            var days = new Date();

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
    try {
        if (document.getElementById('hdnIscommonValidation').value != 'Y') {
            var x = id.split("_");
            //alert(document.getElementById().option[document.getElementById(x[0] + "_ddlstatus").value].text);
            var ctrlId = x[0] + "_" + CheckID;
            document.getElementById('ucReflexTest_hdnControlId').value = ctrlId;

            //    alert(document.getElementById(x[0] + "_ddlstatus").options[document.getElementById(x[0] + "_ddlstatus").selectedIndex].text);
            var tempstring = document.getElementById(x[0] + "_ddlstatus").options[document.getElementById(x[0] + "_ddlstatus").selectedIndex].value;
            //var CompareString = document.getElementById(x[0] + "_ddlstatus").options[document.getElementById(x[0] + "_ddlstatus").selectedIndex].text;
            var CompareString = tempstring.split("_");
            if (CompareString[0] == "Completed") {
                if (document.getElementById(x[0] + "_" + CheckID) != undefined) {
                    if ((document.getElementById(x[0] + "_" + CheckID).value == '') || (document.getElementById(x[0] + "_" + CheckID).value == '0')) {
                        alert('No Value Entered, Please Check Investigation status');
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
                                //PendingValue = drpdwn.options[i].value;
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
                        //                var DrpDdlId = document.getElementById(ddlId).value;
                        //                var status = DrpDdlId.options[DrpDdlId.selectedIndex].value;
                        //                DrpDdlId.options[DrpDdlId.selectedIndex].value = PendingValue;
                    }
                }
                // else if (document.getElementById(x[0] + "_" + CheckID).options[document.getElementById(x[0] + "_" + CheckID).selectedIndex].text == 'Select') {
                // }
            }
            if (CompareString[0] == "Reflexwithnewsample" || CompareString[0] == "Reflexwithsamesample") {
                if (document.getElementById(x[0] + "_" + CheckID) != undefined) {
                    //document.getElementById(ctrlId).disabled = true;
                    if ((document.getElementById(x[0] + "_" + CheckID).value == '') || (document.getElementById(x[0] + "_" + CheckID).value == '0')) {
                        alert('No Value Entered, Please Check Investigation status');
                        var len = document.getElementById(x[0] + "_ddlstatus").options.length;
                        var drpdwn = document.getElementById(x[0] + "_ddlstatus");
                        var isCompletedExists = 'false';
                        var CompletedValue = 0;
                        var PendingValue = 0;
                        for (var i = 0; i < len; i++) {
                            var drpdwnVal = drpdwn.options[i].value.split("_");
                            //if (drpdwn.options[i].text == 'Completed') {
                            if (drpdwnVal[0] == 'Reflexwithnewsample' || drpdwnVal[0] == "Reflexwithsamesample") {
                                isCompletedExists = 'true';
                                //CompletedValue = drpdwn.options[i].value;
                                CompletedValue = drpdwnVal[1];
                                //document.getElementById(CheckID).disabled = true;
                            }
                            //if (drpdwn.options[i].text == 'Pending') {
                            if (drpdwnVal[0] == 'Pending') {
                                //PendingValue = drpdwn.options[i].value;
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
                        //                var DrpDdlId = document.getElementById(ddlId).value;
                        //                var status = DrpDdlId.options[DrpDdlId.selectedIndex].value;
                        //                DrpDdlId.options[DrpDdlId.selectedIndex].value = PendingValue;
                    }
                }
                // else if (document.getElementById(x[0] + "_" + CheckID).options[document.getElementById(x[0] + "_" + CheckID).selectedIndex].text == 'Select') {
                // }
            }
        }
    }
    catch (e) {
    }
}
function CheckIfEmpty1(id, ddlID, txtid) {
    if (document.getElementById('hdnIscommonValidation').value != 'Y') {
        var x = id.split("_");
        //var CompareString = document.getElementById(x[0] + "_ddlstatus").options[document.getElementById(x[0] + "_ddlstatus").selectedIndex].text;
        var CompareString = document.getElementById(x[0] + "_ddlstatus").options[document.getElementById(x[0] + "_ddlstatus").selectedIndex].value.split("-");
        var CompareStringsplit = CompareString[0].split("_");
        if (CompareStringsplit[0] == "Completed") {
            if (txtid != '0') {
                if (document.getElementById(x[0] + "_" + txtid) != undefined && document.getElementById(x[0] + "_" + ddlID) != undefined) {
                    if (((document.getElementById(x[0] + "_" + txtid).value == '') || (document.getElementById(x[0] + "_" + txtid).value == '0'))
        && document.getElementById(x[0] + "_" + ddlID).options[document.getElementById(x[0] + "_" + ddlID).selectedIndex].value == '0') {
                        alert('No Value Entered, Please Check Investigation status');
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
                        document.getElementById(x[0] + "_ddlstatus").value = PendingValue;

                    }
                }
            }
            else {
                if (document.getElementById(x[0] + "_" + txtid) != undefined && document.getElementById(x[0] + "_" + ddlID) != undefined) {
                    if (document.getElementById(x[0] + "_" + ddlID).options[document.getElementById(x[0] + "_" + ddlID).selectedIndex].value == '0') {
                        alert('No Value Entered, Please Check Investigation status');
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
}



function ChangeStatus(GrpName, ddlID) {
    //alert(document.getElementById('hdnGroupCollection').value);
    //alert(ddlID);
    var count = document.getElementById('hdnGroupCollection').value;
    var len = count.split('^');
    var tmpAcc = count.split('^')[2];
    var AccNo = tmpAcc.split('~')[5];
    var InvId = tmpAcc.split('~')[3];
    if (AccNo != undefined || AccNo != null) {
        var AccessionNumber = AccNo.split("_")[0];
    }
    else {
        AccNo = id.split('~')[4];
        AccessionNumber = AccNo.split("_")[0];
    }

    var roleName = document.getElementById('hdnRoleName').value;
    var Vid = document.getElementById('PatientDetail_hdnVID').value;
    var ClientId = document.getElementById('PatientDetail_hdnClientID').value;
    var Gender = document.getElementById('PatientDetail_hdnGender').value;
    var OrgID = document.getElementById('hdnOrgID').value;
    var k = 0;
    var flag = 0;
    document.getElementById('ucReflexTest_hdnDropDownId').value = ddlID;
    document.getElementById('ucReflexTest_hdnGroupName').value = GrpName;
    var tblGrpStatusReason1 = "tblGrpStatusReason1" + ddlID;
    var tblGrpStatusReason2 = "tblGrpStatusReason2" + ddlID;
    var tblGrpStatusOpinion1 = "tblGrpStatusOpinion1" + ddlID;
    var tblGrpStatusOpinion2 = "tblGrpStatusOpinion2" + ddlID;
    var drpdwn1 = document.getElementById(ddlID);
    var status1 = drpdwn1.options[drpdwn1.selectedIndex].value.split("_");
    var GrpId1 = 0;
    GrpId1 = len[2].split('|')[2];
    chkRecollectCount(Vid, InvId, OrgID, roleName, GrpId1);

    if (status1[0] == "Retest" && document.getElementById('hdnRecollectCountFlag').value == "1") {
        alert('Recollect is not allowed more than twice');
        document.getElementById('hdnRecollectCountFlag').value = 0;
        return false;
    }
    for (var i = 0; i < len.length; i++) {
        if (len[i] != "") {
            var ctrlID = len[i].split('|');
            if (GrpName == ctrlID[1]) {
                var drpdwn = document.getElementById(ddlID);
                var ddldwn = document.getElementById(ctrlID[2]);
                var length = document.getElementById(ctrlID[2]).options.length;
                var grpId = 0;
                grpId = ctrlID[2];
                document.getElementById('ucReflexTest_hdnDisableDropDown').value = grpId;
                //                        alert(drpdwn.options[drpdwn.selectedIndex].text);
                //var status = drpdwn.options[drpdwn.selectedIndex].text;
                var status = drpdwn.options[drpdwn.selectedIndex].value.split("_");
                var CompletedValue = 0;
                for (var j = 0; j < length; j++) {
                    var ddldwnVal = ddldwn.options[j].value.split("_");
                    //if (ddldwn.options[j].text == status) {
                    if (ddldwnVal[0] == status[0]) {
                        //                        CompletedValue = ddldwn.options[j].value;
                        //                        document.getElementById(ctrlID[2]).value = CompletedValue;
                        CompletedValue = ddldwn.options[j].value.split("_");
                        document.getElementById(ctrlID[2]).value = ddldwn.options[j].value;
                        if (document.getElementById('hdnIscommonValidation').value != 'Y') {

                            CheckIfEmpty(ctrlID[2], 'txtValue');
                            CheckIfEmpty1(ctrlID[2], 'ddlData', '0');
                        }
                        var PrefixID = ctrlID[2].split('_');
                        var tdInvStatusReason1 = PrefixID[0] + "_tdInvStatusReason1";
                        var tdInvStatusReason2 = PrefixID[0] + "_tdInvStatusReason2";
                        var tdInvStatusOpinion1 = PrefixID[0] + "_tdInvStatusOpinion1";
                        var tdInvStatusOpinion2 = PrefixID[0] + "_tdInvStatusOpinion2";
                        var newListItem = "";
                        var newListItem1 = "";
                        if (CompletedValue[0] == "Co-authorize" || CompletedValue[0] == "Second Opinion") {
                            if ($('input[id$="hdnLstCoAuthorizeUser"]').val() != undefined) {
                                var lstOpinionUser = JSON.parse($('input[id$="hdnLstCoAuthorizeUser"]').val());

                                var ddlOpinionUser = PrefixID[0] + "_ddlOpinionUser";
                                var deptlstOpinionUser = "ddlGrpOpinionUser" + ddlID;
                                document.getElementById(ddlOpinionUser).options.length = 1;
                                document.getElementById(deptlstOpinionUser).options.length = 1;
                                $.each(lstOpinionUser, function(i, obj) {
                                    deptListItem = document.createElement("option");
                                    document.getElementById(deptlstOpinionUser).options.add(deptListItem);
                                    deptListItem.text = obj.Name;
                                    deptListItem.value = obj.LoginID;

                                    newListItem = document.createElement("option");
                                    document.getElementById(ddlOpinionUser).options.add(newListItem);
                                    newListItem.text = obj.Name;
                                    newListItem.value = obj.LoginID;
                                });
                            }
                        }
                        else {
                            if ($('input[id$="hdnlstreasons"]').val() != undefined) {
                                var lstReason = JSON.parse($('input[id$="hdnlstreasons"]').val());

                                var ddlReason = PrefixID[0] + "_ddlStatusReason";
                                var deptlstReason = "ddlGrpReason" + ddlID;
                                //document.getElementById(ddlReason).options.length = 1;
                                document.getElementById(deptlstReason).options.length = 1;
                                $.each(lstReason, function(i, obj) {
                                    if (obj.StatusID == CompletedValue[1]) {

                                        deptListItem = document.createElement("option");
                                        document.getElementById(deptlstReason).options.add(deptListItem);
                                        deptListItem.text = obj.ReasonDesc;
                                        deptListItem.value = obj.ReasonID;

                                        newListItem = document.createElement("option");
                                        // document.getElementById(ddlReason).options.add(newListItem);
                                        newListItem.text = obj.ReasonDesc;
                                        newListItem.value = obj.ReasonID;
                                    }
                                });
                            }

                            if (status[0] == "Recheck") {

                                if ($('input[id$="hdnrerunrecollect"]').val() == "Y") {


                                    $.each(lstReason, function(i, obj) {

                                        deptListItem = document.createElement("option");
                                        document.getElementById(deptlstReason).options.add(deptListItem);
                                        deptListItem.text = obj.ReasonDesc;
                                        deptListItem.value = obj.ReasonID;

                                        newListItem = document.createElement("option");
                                        document.getElementById(ddlReason).options.add(newListItem);
                                        newListItem.text = obj.ReasonDesc;
                                        newListItem.value = obj.ReasonID;

                                    });
                                }
                            }

                            if (status[0] == "Retest") {

                                if ($('input[id$="hdnrerunrecollect"]').val() == "Y") {


                                    $.each(lstReason, function(i, obj) {

                                        deptListItem = document.createElement("option");
                                        document.getElementById(deptlstReason).options.add(deptListItem);
                                        deptListItem.text = obj.ReasonDesc;
                                        deptListItem.value = obj.ReasonID;

                                        newListItem = document.createElement("option");
                                        document.getElementById(ddlReason).options.add(newListItem);
                                        newListItem.text = obj.ReasonDesc;
                                        newListItem.value = obj.ReasonID;

                                    });
                                }
                            }

                        }

                        if (status[0] == "Reject") {
                            if (document.getElementById(tdInvStatusReason1) != null) {
                                document.getElementById(tdInvStatusReason1).style.display = "block";
                            }
                            document.getElementById(tdInvStatusReason2).style.display = "block";
                            if (document.getElementById(tdInvStatusOpinion1) != null) {
                                document.getElementById(tdInvStatusOpinion1).style.display = "none";
                            }
                            document.getElementById(tdInvStatusOpinion2).style.display = "none";
                            if (k == 0) {
                                if (document.getElementById(tblGrpStatusReason1) != null) {
                                    document.getElementById(tblGrpStatusReason1).style.display = "block";
                                }
                                document.getElementById(tblGrpStatusReason2).style.display = "block";
                                if (document.getElementById(tblGrpStatusOpinion1) != null) {
                                    document.getElementById(tblGrpStatusOpinion1).style.display = "none";
                                }
                                document.getElementById(tblGrpStatusOpinion2).style.display = "none";
                                k = 1;
                            }
                        }
                        else if (status[0] == "Recheck") {

                            if ($('input[id$="hdnrerunrecollect"]').val() == "Y") {
                                if (document.getElementById(tdInvStatusReason1) != null) {
                                    document.getElementById(tdInvStatusReason1).style.display = "block";
                                }
                                document.getElementById(tdInvStatusReason2).style.display = "block";
                                if (document.getElementById(tdInvStatusOpinion1) != null) {
                                    document.getElementById(tdInvStatusOpinion1).style.display = "none";
                                }
                                document.getElementById(tdInvStatusOpinion2).style.display = "none";
                                if (k == 0) {
                                    if (document.getElementById(tblGrpStatusReason1) != null) {
                                        document.getElementById(tblGrpStatusReason1).style.display = "block";
                                    }
                                    document.getElementById(tblGrpStatusReason2).style.display = "block";
                                    if (document.getElementById(tblGrpStatusOpinion1) != null) {
                                        document.getElementById(tblGrpStatusOpinion1).style.display = "none";
                                    }
                                    document.getElementById(tblGrpStatusOpinion2).style.display = "none";
                                    k = 1;
                                }
                            }


                        }
                        else if (status[0] == "Retest") {

                            if ($('input[id$="hdnrerunrecollect"]').val() == "Y") {

                                if (document.getElementById(tdInvStatusReason1) != null) {
                                    document.getElementById(tdInvStatusReason1).style.display = "block";
                                }
                                document.getElementById(tdInvStatusReason2).style.display = "block";
                                if (document.getElementById(tdInvStatusOpinion1) != null) {
                                    document.getElementById(tdInvStatusOpinion1).style.display = "none";
                                }
                                document.getElementById(tdInvStatusOpinion2).style.display = "none";
                                if (k == 0) {
                                    if (document.getElementById(tblGrpStatusReason1) != null) {
                                        document.getElementById(tblGrpStatusReason1).style.display = "block";
                                    }
                                    document.getElementById(tblGrpStatusReason2).style.display = "block";
                                    if (document.getElementById(tblGrpStatusOpinion1) != null) {
                                        document.getElementById(tblGrpStatusOpinion1).style.display = "none";
                                    }
                                    document.getElementById(tblGrpStatusOpinion2).style.display = "none";
                                    k = 1;
                                }

                            }

                        }
                        else if (status[0] == "With Held") {
                            if (document.getElementById(tdInvStatusReason1) != null) {
                                document.getElementById(tdInvStatusReason1).style.display = "block";
                            }
                            document.getElementById(tdInvStatusReason2).style.display = "block";
                            if (document.getElementById(tdInvStatusOpinion1) != null) {
                                document.getElementById(tdInvStatusOpinion1).style.display = "none";
                            }
                            document.getElementById(tdInvStatusOpinion2).style.display = "none";
                            if (k == 0) {
                                if (document.getElementById(tblGrpStatusReason1) != null) {
                                    document.getElementById(tblGrpStatusReason1).style.display = "block";
                                }
                                document.getElementById(tblGrpStatusReason2).style.display = "block";
                                if (document.getElementById(tblGrpStatusOpinion1) != null) {
                                    document.getElementById(tblGrpStatusOpinion1).style.display = "none";
                                }
                                document.getElementById(tblGrpStatusOpinion2).style.display = "none";
                                k = 1;
                            }
                        }
                        else if (status[0] == "Co-authorize" || status[0] == "Second Opinion") {
                            if (document.getElementById(tdInvStatusReason1) != null) {
                                document.getElementById(tdInvStatusReason1).style.display = "none";
                            }
                            document.getElementById(tdInvStatusReason2).style.display = "none";
                            if (document.getElementById(tdInvStatusOpinion1) != null) {
                                document.getElementById(tdInvStatusOpinion1).style.display = "block";
                            }
                            document.getElementById(tdInvStatusOpinion2).style.display = "block";
                            if (k == 0) {
                                if (document.getElementById(tblGrpStatusReason1) != null) {
                                    document.getElementById(tblGrpStatusReason1).style.display = "none";
                                }
                                document.getElementById(tblGrpStatusReason2).style.display = "none";
                                if (document.getElementById(tblGrpStatusOpinion1) != null) {
                                    document.getElementById(tblGrpStatusOpinion1).style.display = "block";
                                }
                                document.getElementById(tblGrpStatusOpinion2).style.display = "block";
                                k = 1;
                            }
                        }
                        else {
                            if (document.getElementById(tblGrpStatusReason1) != null) {
                                //document.getElementById(tdInvStatusReason1).style.display = "none";
                                //document.getElementById(tdInvStatusReason2).style.display = "none";
                                //document.getElementById(tdInvStatusOpinion1).style.display = "none";
                                //document.getElementById(tdInvStatusOpinion2).style.display = "none";
                                if (k == 0) {
                                    document.getElementById(tblGrpStatusReason1).style.display = "none";
                                    document.getElementById(tblGrpStatusReason2).style.display = "none";
                                    document.getElementById(tblGrpStatusOpinion1).style.display = "none";
                                    document.getElementById(tblGrpStatusOpinion2).style.display = "none";

                                    document.getElementById(ddlReason).style.display = "none";
                                    //                                   document.getElementById(tdInvStatusReason2).style.display = "none";
                                    //                                   document.getElementById(tdInvStatusOpinion1).style.display = "none";
                                    //                                   document.getElementById(tdInvStatusOpinion2).style.display = "none";

                                }
                            }
                        }
                    }
                }
            }
        }
        if (document.getElementById('ucReflexTest_hdnDisableDropDown').value != "" && flag == 0) {

            var Grp = document.getElementById('ucReflexTest_hdnDisableDropDown').value;
            var ctrlID2 = Grp.split('~')[2];
            var parentType = "Grp";

            //if (GrpName == ctrlID[1]) {
            var drpdwn = document.getElementById(ddlID);
            //var ddldwn = document.getElementById(ctrlID[2]);
            //var length = document.getElementById(ctrlID[2]).options.length;
            //                        alert(drpdwn.options[drpdwn.selectedIndex].text);
            //var status = drpdwn.options[drpdwn.selectedIndex].text;
            var status = drpdwn.options[drpdwn.selectedIndex].value.split("_");

            if (status[0] == "Reflexwithnewsample" || status[0] == "Reflexwithsamesample") {
                var ans = window.confirm('Do you want to proceed with Reflex Test??');
                if (ans == true) {


                    if (status[0] == "Reflexwithnewsample") {
                        document.getElementById('ucReflexTest_hdnReflexType').value = status[0];
                    }
                    else {
                        document.getElementById('ucReflexTest_hdnReflexType').value = status[0];
                    }

                    var gen;
                    var sval1;
                    if (Gender == "Male") {
                        gen = "M";
                    }
                    else if (Gender = "Female") {
                        gen = "F";
                    }

                    var prefixText = '';
                    sval = OrgID;
                    var lstPreviousInvestigations = [];
                    var lstTotalItems = [];
                    var ArrayItems;
                    var Items;
                    var SamplesItems;
                    var TotalItems;
                    $('#ucReflexTest_hdnTotalItems').val('');
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../OPIPBilling.asmx/GetPatientOrderedInvestigation",
                        data: JSON.stringify({ prefixText: prefixText, contextKey: 'GRP' + '~' + Vid + '~' + ctrlID2 + '~' + AccessionNumber + '~' + parentType }),
                        dataType: "json",
                        async: false,
                        success: function(data) {
                            if (data.d.length > 0) {
                                ArrayItems = data.d;
                                Items = ArrayItems[0];
                                SamplesItems = ArrayItems[1];
                                TotalItems = ArrayItems[2];

                                if (TotalItems[0].InvestigationName == 'OrderedTest') {
                                    alert('Ordered test should not be reflexed./Already reflexed tests shuld not be reflexed again.');
                                    if (roleName == "Lab Technician") {
                                        setCompleteStatus(Grp);
                                        return false;
                                    }
                                    else {
                                        setValidateStatus(Grp);
                                        return false;
                                    }
                                }

                                if (TotalItems.length > 0) {
                                    $('#ucReflexTest_hdnTotalItems').val(JSON.stringify(TotalItems));
                                }
                                $('#ucReflexTest_grdReflexOrderedInv tbody tr').children().remove();
                                if (TotalItems.length > 0) {
                                    var list = TotalItems;
                                    if (list.length > 0) {
                                        $("#ucReflexTest_grdReflexOrderedInv").append("<tr class='dataheader1'><td><span id='lblSelect' align='left'>Select</span></td><td><span id ='lblInvestName'>Investigation Name</span></td><td><span id ='lblPatStatus'>Status</span></td><td style='display:none';><span id='lblGroupID' align='left'>GroupID</span></td></tr>");
                                        for (var i = 0; i < list.length; i++) {
                                            var AccessionNumber = list[i].AccessionNumber;
                                            var InvestigationName = list[i].InvestigationName;
                                            var Status = list[i].Status;
                                            var ID = list[i].ID;
                                            var GroupID = list[i].GroupID;
                                            if (GroupID == ID) {
                                                $("#ucReflexTest_grdReflexOrderedInv").append("<tr style='background-color:#F9B7FF;'><td><input type='radio' id='rdReflexSelinv' checked='checked' onclick='SelectSingleRadiobutton(this.id);'/></td><td style='display:none';><span id ='lblAccNo'>" + AccessionNumber + "</span></td><td style='display:none';><span id ='lblID'>" + ID + "</span></td><td><span id ='lblInvName'>" + InvestigationName + "</span></td><td><span id ='lblStatus'>" + Status + "</span></td><td style='display:none';><span id ='lblGrpID'>" + GroupID + "</span></td></tr>");
                                            }
                                            else {
                                                $("#ucReflexTest_grdReflexOrderedInv").append("<tr style='background-color:#F9B7FF;display:none'><td><input type='radio' id='rdReflexSelinv' onclick='SelectSingleRadiobutton(this.id);'/></td><td style='display:none';><span id ='lblAccNo'>" + AccessionNumber + "</span></td><td style='display:none';><span id ='lblID'>" + ID + "</span></td><td><span id ='lblInvName'>" + InvestigationName + "</span></td><td><span id ='lblStatus'>" + Status + "</span></td><td style='display:none';><span id ='lblGrpID'>" + GroupID + "</span></td></tr>");
                                            }
                                            $('#ucReflexTest_grdReflexOrderedInv').css('visibility', 'visible');

                                            if (GroupID == ID) {
                                                $('#ucReflexTest_grdReflexOrderedInv tbody tr:not(:first)').each(function(i, n) {
                                                    var $row = $(n);
                                                    var AccessionNo = $row.find($('span[id$="lblAccNo"]')).html();
                                                    var ParentInvName = $row.find($('span[id$="lblInvName"]')).html();
                                                    var ParentStatus = $row.find($('span[id$="lblStatus"]')).html();
                                                    var Vid = document.getElementById('PatientDetail_hdnVID').value;
                                                    document.getElementById('ucReflexTest_hdnReflexAccessionNo').value = AccessionNo;
                                                    document.getElementById('ucReflexTest_hdnReflexPrntInvName').value = ParentInvName;
                                                    document.getElementById('ucReflexTest_hdnStatus').value = ParentStatus;
                                                    document.getElementById('ucReflexTest_hdnVID').value = Vid;
                                                    sval1 = "COM" + '~' + ClientId + '~' + '~' + '~' + '' + gen;
                                                    $find('ucReflexTest_AutoCompleteExtender3').set_contextKey(sval1);

                                                });
                                            }

                                            document.getElementById('ucReflexTest_btnAddReflex').style.display = 'block';

                                            lstPreviousInvestigations.push({
                                                AccessionNumber: AccessionNumber,
                                                InvestigationName: InvestigationName,
                                                Status: Status,
                                                Id: ID
                                            });
                                            if (lstPreviousInvestigations.length > 0) {
                                                $('#hdnLstInvestigationQueue').val(JSON.stringify(lstPreviousInvestigations));
                                                flag = 1;
                                                showReflexPopUp();
                                            }
                                            else {
                                                hideReflexPopUp();
                                            }
                                            if (flag == 1) {
                                                return false;
                                            }
                                        }
                                    }
                                }
                            }

                        },
                        error: function(result) {
                            alert("New Error");
                        }
                    });
                    return true;
                }
                else {
                    if (roleName == "Lab Technician") {
                        setCompleteStatus(Grp);
                        return false;
                    }
                    else {
                        setValidateStatus(Grp);
                        return false;
                    }
                }
            }
        }
    }
}

function ChangeGroupStatus(GrpName, ddlID, Formula) {
    try {
        var count = document.getElementById('hdnGroupCollection').value;
        var lstGrpDetails = count.split('$');
        var formmula = Formula;
        var ddlInvId = ddlID;
        ddlInvId = ddlInvId.split('~');
        var isSameGroup = false;
        if (lstGrpDetails != null && lstGrpDetails.length > 0) {
            for (var g = 0; g < lstGrpDetails.length; g++) {
                isSameGroup = false;
                var GrpDetails = lstGrpDetails[g].split('#');
                if (GrpDetails != null && GrpDetails.length > 1) {
                    var isSameStatus = false;
                    var sameStatusValue = "Completed";
                    var pendingValue = "Pending";
                    for (var j = 0; j < GrpDetails.length; j++) {
                        var len = GrpDetails[j].split('^');

                        for (var i = 0; i < len.length; i++) {
                            if (len[i] != "") {
                                var ctrlID = len[i].split('|');
                                if (GrpName == ctrlID[1]) {
                                    var ddldwn = document.getElementById(ctrlID[2]);
                                    if (ddldwn != null) {
                                        //statusValue = drpdwn.options[drpdwn.selectedIndex].value;
                                        isSameGroup = true;
                                        var drpdwn = document.getElementById(ddlID);
                                        var status = drpdwn.options[drpdwn.selectedIndex].text;
                                        statusValue = drpdwn.options[drpdwn.selectedIndex].value.split("_");
                                        //var othersStatusValue = ddldwn.options[ddldwn.selectedIndex].value;
                                        var othersStatusValue = ddldwn.options[ddldwn.selectedIndex].value.split("_");
                                        var depInv = formmula.replace(/\~/g, '');
                                        var depInv1 = depInv.split('^');
                                        //Modified By Prasanna.S on 21-Sep-2013
                                        //if ((statusValue[0] == 'Recheck') || (statusValue[0] == 'Retest')) {
                                        //debugger;

                                        //}
                                        ChangeDependentStatus(depInv1, ddlInvId[0], ddlInvId, drpdwn);

                                        if (othersStatusValue[1] == statusValue[1]) {
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
                        }
                        if (isSameGroup) {
                            if (isSameStatus) {
                                for (var j = 0; j < GrpDetails.length; j++) {
                                    var len = GrpDetails[j].split('^');
                                    for (var i = 0; i < len.length; i++) {
                                        if (len[i] != "") {
                                            var ctrlID = len[i].split('|');
                                            var Grpid = ctrlID[0].split('_');
                                            if (GrpName == Grpid[0]) {
                                                document.getElementById(GrpDetails[j]).value = drpdwn.options[drpdwn.selectedIndex].value;
                                                var GrpElement = document.getElementById(GrpDetails[j]).value;
                                            }
                                        }
                                    }
                                }
                            }
                            else {
                                //document.getElementById(GrpDetails[0]).value = pendingValue;
                            }
                        }
                    }
                }
            }
        }
    }
    catch (e) {
    }
}


/*Funtion to change Status of dependent investigation*/
function ChangeDependentStatus(depInv1, a, ddlInvId, drpdwn) {
    //var a = ddlInvId[0];
    //debugger;
    try {
        for (var h = 0; h < depInv1.length; h++) {
            var depInv2 = depInv1[h].split('=');
            var contains = (depInv1[h].indexOf(a) > -1);
            if (contains == true) {
                var b;
                var tempb = depInv2[0].match(/\d\d\d\d/g);
                b = tempb[0];
                var depddlid = b + '~' + ddlInvId[1] + '~' + ddlInvId[2] + '~' + ddlInvId[3] + '~' + ddlInvId[4] + '~' + ddlInvId[5];
                if (document.getElementById(depddlid) != null) {
                    document.getElementById(depddlid).value = drpdwn.options[drpdwn.selectedIndex].value;
                    //ChangeDependentStatus(depInv1, b, ddlInvId, drpdwn);
                }
                ChangeDependentStatus1(depInv1, depInv2[1], ddlInvId, drpdwn);
            }
        }
    }
    catch (e) {
        throw e;
    }
}

function ChangeDependentStatus1(depInv1, depInv2, ddlInvId, drpdwn) {
    //var a = ddlInvId[0];
    //debugger;
    try {
        for (var h = 0; h < depInv1.length; h++) {
            var numb1 = depInv2.match(/\d\d\d\d/g);
            for (var g = 0; g < numb1.length; g++) {
                var contains = (depInv1[h].indexOf(numb1[g]) > -1);
                if (contains == true) {
                    //var depInv2 = depInv1.split('=');
                    var numb = depInv1[h].match(/\d\d\d\d/g);
                    for (var k = 0; k < numb.length; k++) {
                        var depddlid = numb[k] + '~' + ddlInvId[1] + '~' + ddlInvId[2] + '~' + ddlInvId[3] + '~' + ddlInvId[4] + '~' + ddlInvId[5];
                        if (document.getElementById(depddlid) != null) {
                            document.getElementById(depddlid).value = drpdwn.options[drpdwn.selectedIndex].value;
                        }
                        //ChangeDependentStatus1(depInv1, numb[k], ddlInvId, drpdwn);
                    }
                }
            }
        }
    }
    catch (e) {
        throw e;
    }
}
/* Function to Suppress F5 based Refresh. This can be called in individual pages in the 'onkeydown' event of Body / Form */
function SuppressBrowserRefresh(e) {
    var keycode = (window.event) ? event.keyCode : e.keyCode;
    if (keycode == 116) {
        //alert("Doing browser refresh may cause loss or unstable data. Please be sure before continuing");
        event.keyCode = 0;
        event.returnValue = false;
        return false;
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
                //var status = drpdwn.options[drpdwn.selectedIndex].text;
                var status = drpdwn.options[drpdwn.selectedIndex].value.split("_");
                var CompletedValue = 0;
                for (var j = 0; j < length; j++) {
                    //if (ddldwn.options[j].text == status) {
                    var ddldwnVal = ddldwn.options[j].value.split("_");
                    if (ddldwnVal[0] == status[0]) {
                        //CompletedValue = ddldwn.options[j].value;
                        CompletedValue = ddldwn.options[j].value.split("_");
                        if (CompletedValue[0] == "Reflexwithnewsample" || CompletedValue[0] == "Reflexwithsamesample") {
                            alert('kindly do not select department level Reflex');
                            document.getElementById(ddlID).value = drpdwn[0].value;
                            return false;

                        }
                        document.getElementById(ctrlID[2]).value = ddldwn.options[j].value;
                        CheckIfEmpty(ctrlID[2], 'txtValue');
                        var PrefixID = ctrlID[2].split('_');
                        var tdInvStatusReason1 = PrefixID[0] + "_tdInvStatusReason1";
                        var tdInvStatusReason2 = PrefixID[0] + "_tdInvStatusReason2";
                        var tdInvStatusOpinion1 = PrefixID[0] + "_tdInvStatusOpinion1";
                        var tdInvStatusOpinion2 = PrefixID[0] + "_tdInvStatusOpinion2";


                        var newListItem = "";
                        var newListItem1 = "";
                        if (CompletedValue[0] == "Co-authorize" || CompletedValue[0] == "Second Opinion") {
                            if ($('input[id$="hdnLstCoAuthorizeUser"]').val() != undefined) {
                                var lstOpinionUser = JSON.parse($('input[id$="hdnLstCoAuthorizeUser"]').val());

                                var ddlOpinionUser = PrefixID[0] + "_ddlOpinionUser";
                                var deptlstOpinionUser = "ddlOpinionUser" + ddlID;
                                document.getElementById(ddlOpinionUser).options.length = 1;
                                document.getElementById(deptlstOpinionUser).options.length = 1;
                                $.each(lstOpinionUser, function(i, obj) {
                                    deptListItem = document.createElement("option");
                                    document.getElementById(deptlstOpinionUser).options.add(deptListItem);
                                    deptListItem.text = obj.Name;
                                    deptListItem.value = obj.LoginID;

                                    newListItem = document.createElement("option");
                                    document.getElementById(ddlOpinionUser).options.add(newListItem);
                                    newListItem.text = obj.Name;
                                    newListItem.value = obj.LoginID;
                                });
                            }
                        }
                        else {
                            if ($('input[id$="hdnlstreasons"]').val().length > 0) {
                                var lstReason = JSON.parse($('input[id$="hdnlstreasons"]').val());

                                var ddlReason = PrefixID[0] + "_ddlStatusReason";
                                var deptlstReason = "ddlReason" + ddlID;
                                document.getElementById(ddlReason).options.length = 1;
                                document.getElementById(deptlstReason).options.length = 1;
                                $.each(lstReason, function(i, obj) {
                                    if (obj.StatusID == CompletedValue[1]) {

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

                                if ($('input[id$="hdnrerunrecollect"]').val() == "Y") {
                                    $.each(lstReason, function(i, obj) {
                                        if (CompletedValue[0] == "Recheck") {

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
                                    if (CompletedValue[0] == "Retest") {

                                        $.each(lstReason, function(i, obj) {
                                            newListItem = document.createElement("option");
                                            document.getElementById(ddlReason).options.add(newListItem);
                                            newListItem.text = obj.ReasonDesc;
                                            newListItem.value = obj.ReasonID;

                                            deptListItem = document.createElement("option");
                                            document.getElementById(deptlstReason).options.add(deptListItem);
                                            deptListItem.text = obj.ReasonDesc;
                                            deptListItem.value = obj.ReasonID;
                                        });




                                    }

                                }



                            }
                        }
                        //                        $.each(lstReason, function(i, obj) {
                        //                            if (obj.StatusID == CompletedValue) {

                        //                                newListItem1 = document.createElement("option");
                        //                                document.getElementById(deptlstReason).options.add(newListItem1);
                        //                                newListItem1.text = obj.ReasonDesc;
                        //                                newListItem1.value = obj.ReasonID;

                        //                            }
                        //                        });
                        //  document.getElementById(tdInvStatusReason1).DataSource = newListItem;

                        //document.getElementById(ctrlID[2]).value = CompletedValue;
                        document.getElementById(ctrlID[2]).value = ddldwn.options[j].value;

                        //if (CompletedValue[1] == 3 && ddldwn.options[j].innerHTML == "Reject") {
                        if (CompletedValue[0] == "Reject") {
                            if (document.getElementById(tdInvStatusReason1) != null) {
                                document.getElementById(tdInvStatusReason1).style.display = "block";
                            }

                            document.getElementById(tdInvStatusReason2).style.display = "block";
                            if (document.getElementById(tdInvStatusOpinion1) != null) {
                                document.getElementById(tdInvStatusOpinion1).style.display = "none";
                            }
                            document.getElementById(tdInvStatusOpinion2).style.display = "none";
                            if (k == 0) {
                                if (document.getElementById(tblStatusReason1) != null) {
                                    document.getElementById(tblStatusReason1).style.display = "block";
                                }
                                document.getElementById(tblStatusReason2).style.display = "block";
                                if (document.getElementById(tblStatusOpinion1) != null) {
                                    document.getElementById(tblStatusOpinion1).style.display = "none";
                                }
                                document.getElementById(tblStatusOpinion2).style.display = "none";
                                k = 1;
                            }
                        }
                        //else if (Rerun == "Y") {

                        else if (CompletedValue[0] == "Recheck") {
                            if ($('input[id$="hdnrerunrecollect"]').val() == "Y") {

                                if (document.getElementById(tdInvStatusReason1) != null) {
                                    document.getElementById(tdInvStatusReason1).style.display = "block";
                                }
                                document.getElementById(tdInvStatusReason2).style.display = "block";
                                if (document.getElementById(tdInvStatusOpinion1) != null) {
                                    document.getElementById(tdInvStatusOpinion1).style.display = "none";
                                }
                                document.getElementById(tdInvStatusOpinion2).style.display = "none";
                                if (k == 0) {
                                    if (document.getElementById(tblStatusReason1) != null) {
                                        document.getElementById(tblStatusReason1).style.display = "block";
                                    }
                                    document.getElementById(tblStatusReason2).style.display = "block";
                                    if (document.getElementById(tblStatusOpinion1) != null) {
                                        document.getElementById(tblStatusOpinion1).style.display = "none";
                                    }
                                    document.getElementById(tblStatusOpinion2).style.display = "none";
                                    k = 1;
                                }
                            }
                        }
                        else if (CompletedValue[0] == "Retest") {

                            if ($('input[id$="hdnrerunrecollect"]').val() == "Y") {

                                if (document.getElementById(tdInvStatusReason1) != null) {
                                    document.getElementById(tdInvStatusReason1).style.display = "block";
                                }
                                document.getElementById(tdInvStatusReason2).style.display = "block";
                                if (document.getElementById(tdInvStatusOpinion1) != null) {
                                    document.getElementById(tdInvStatusOpinion1).style.display = "none";
                                }
                                document.getElementById(tdInvStatusOpinion2).style.display = "none";
                                if (k == 0) {
                                    if (document.getElementById(tblStatusReason1) != null) {
                                        document.getElementById(tblStatusReason1).style.display = "block";
                                    }
                                    document.getElementById(tblStatusReason2).style.display = "block";
                                    if (document.getElementById(tblStatusOpinion1) != null) {
                                        document.getElementById(tblStatusOpinion1).style.display = "none";
                                    }
                                    document.getElementById(tblStatusOpinion2).style.display = "none";
                                    k = 1;
                                }
                            }

                        }

                        //}
                        //else if (CompletedValue == 8 && ddldwn.options[j].innerHTML == "With Held") {
                        else if (CompletedValue[0] == "With Held") {
                            if (document.getElementById(tdInvStatusReason1) != null) {
                                document.getElementById(tdInvStatusReason1).style.display = "block";
                            }
                            document.getElementById(tdInvStatusReason2).style.display = "block";
                            if (document.getElementById(tdInvStatusOpinion1) != null) {
                                document.getElementById(tdInvStatusOpinion1).style.display = "none";
                            }
                            document.getElementById(tdInvStatusOpinion2).style.display = "none";
                            if (k == 0) {
                                if (document.getElementById(tblStatusReason1) != null) {
                                    document.getElementById(tblStatusReason1).style.display = "block";
                                }
                                document.getElementById(tblStatusReason2).style.display = "block";
                                if (document.getElementById(tblStatusOpinion1) != null) {
                                    document.getElementById(tblStatusOpinion1).style.display = "none";
                                }
                                document.getElementById(tblStatusOpinion2).style.display = "none";
                                k = 1;
                            }
                        }
                        //else if (CompletedValue == 6 && ddldwn.options[j].innerHTML == "Co-authorize") {
                        else if (CompletedValue[0] == "Co-authorize" || CompletedValue[0] == "Second Opinion") {
                            if (document.getElementById(tdInvStatusReason1) != null) {
                                document.getElementById(tdInvStatusReason1).style.display = "none";
                            }
                            document.getElementById(tdInvStatusReason2).style.display = "none";
                            if (document.getElementById(tdInvStatusOpinion1) != null) {
                                document.getElementById(tdInvStatusOpinion1).style.display = "block";
                            }
                            document.getElementById(tdInvStatusOpinion2).style.display = "block";
                            if (k == 0) {
                                if (document.getElementById(tblStatusReason1) != null) {
                                    document.getElementById(tblStatusReason1).style.display = "none";
                                }
                                document.getElementById(tblStatusReason2).style.display = "none";
                                if (document.getElementById(tblStatusOpinion1) != null) {
                                    document.getElementById(tblStatusOpinion1).style.display = "block";
                                }
                                document.getElementById(tblStatusOpinion2).style.display = "block";
                                k = 1;
                            }
                        }
                        else {
                            if (document.getElementById(tdInvStatusReason1) != null) {
                                document.getElementById(tdInvStatusReason1).style.display = "none";
                            }
                            document.getElementById(tdInvStatusReason2).style.display = "none";
                            if (document.getElementById(tdInvStatusOpinion1) != null) {
                                document.getElementById(tdInvStatusOpinion1).style.display = "none";
                            }
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
    var tempString = document.getElementById(x[0] + "_ddlstatus").options[document.getElementById(x[0] + "_ddlstatus").selectedIndex].value.split("_");
    // var CompareString = document.getElementById(x[0] + "_ddlstatus").options[document.getElementById(x[0] + "_ddlstatus").selectedIndex].text;
    // var CompareValue = document.getElementById(x[0] + "_ddlstatus").options[document.getElementById(x[0] + "_ddlstatus").selectedIndex].value;
    var CompareString = tempString[0];
    var CompareValue = tempString[1];
    var TDInvStatusReason1 = x[0] + '_tdInvStatusReason1';
    var TDInvStatusReason2 = x[0] + '_tdInvStatusReason2';
    var TDInvStatusOpinion1 = x[0] + '_tdInvStatusOpinion1';
    var TDInvStatusOpinion2 = x[0] + '_tdInvStatusOpinion2';
    if (document.getElementById(TDInvStatusReason1) != null) {
        document.getElementById(TDInvStatusReason1).style.display = "none";
    }
    document.getElementById(TDInvStatusReason2).style.display = "none";
    if (document.getElementById(TDInvStatusOpinion1) != null) {
        document.getElementById(TDInvStatusOpinion1).style.display = "none";
    }
    document.getElementById(TDInvStatusOpinion2).style.display = "none";
    if (CompareString == "Reject") {
        if (document.getElementById(TDInvStatusReason1) != null) {
            document.getElementById(TDInvStatusReason1).style.display = "block";
        }
        document.getElementById(TDInvStatusReason2).style.display = "block";
    }
    else if (CompareString == "With Held") {
        if (document.getElementById(TDInvStatusReason1) != null) {
            document.getElementById(TDInvStatusReason1).style.display = "block";
        }
        document.getElementById(TDInvStatusReason2).style.display = "block";

    }
    //    else if (CompareString=="Recheck") {

    //    if ($('input[id$="hdnrerunrecollect"]').val() == "Y") {

    //        if (document.getElementById(TDInvStatusReason1) != null) {
    //            document.getElementById(TDInvStatusReason1).style.display = "block";
    //        }
    //        document.getElementById(TDInvStatusReason2).style.display = "block";
    //    }

    //    }
    else if (CompareString == "Retest") {

        if (document.getElementById(TDInvStatusReason1) != null) {
            document.getElementById(TDInvStatusReason1).style.display = "block";
        }
        document.getElementById(TDInvStatusReason2).style.display = "block";


    }
    else if (CompareString == "Co-authorize" || CompareString == "Second Opinion") {
        if (document.getElementById(TDInvStatusOpinion1) != null) {
            document.getElementById(TDInvStatusOpinion1).style.display = "block";
        }
        document.getElementById(TDInvStatusOpinion2).style.display = "block";
    }
    else {
        if (document.getElementById(TDInvStatusReason1) != null) {
            document.getElementById(TDInvStatusReason1).style.display = "none";
        }
        document.getElementById(TDInvStatusReason2).style.display = "none";
        if (document.getElementById(TDInvStatusOpinion1) != null) {
            document.getElementById(TDInvStatusOpinion1).style.display = "none";
        }
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
                var hdnStatusReason = PrefixID[0] + "_hdnstatusreason";
                var ddldwn = document.getElementById(ddlStatusReason);
                var length = document.getElementById(ddlStatusReason).options.length;
                //                        alert(drpdwn.options[drpdwn.selectedIndex].text);
                // var status = drpdwn.options[drpdwn.selectedIndex].text;
                var status = drpdwn.options[drpdwn.selectedIndex].value.split("_");
                var CompletedValue = 0;
                for (var j = 0; j < length; j++) {
                    var ddldwnVal = ddldwn.options[j].value.split("_");
                    //if (ddldwn.options[j].text == status[0]) {
                    if (ddldwnVal[0] == status[0]) {
                        CompletedValue = ddldwn.options[j].value;
                        document.getElementById(ddlStatusReason).value = CompletedValue;
                        //                        $('input[id$="hdnstatusreason"]').val(CompletedValue + "~" + ddldwn.options[j].text);
                        document.getElementById(hdnStatusReason).value = CompletedValue + "~" + ddldwn.options[j].text;
                        //alert(CompletedValue + "~" + ddldwn.options[j].text);   

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
                var status = drpdwn.options[drpdwn.selectedIndex].value;
                var hdnOpinionUserID = PrefixID[0] + "_hdnOpinionUser";
                for (var j = 0; j < length; j++) {
                    if (ddldwn.options[j].value == status) {
                        document.getElementById(ddlOpinionUser).value = status;
                        document.getElementById(hdnOpinionUserID).value = status;
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
                var status = drpdwn.options[drpdwn.selectedIndex].value;
                var hdnOpinionUserID = PrefixID[0] + "_hdnOpinionUser";
                for (var j = 0; j < length; j++) {
                    if (ddldwn.options[j].value == status) {
                        document.getElementById(ddlOpinionUser).value = status;
                        document.getElementById(hdnOpinionUserID).value = status;
                    }
                }
            }
        }
    }
    return true;
}
function ChangeDDLItemListWidth() {
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
function SelectPatientStatus(source, eventArgs) {

    document.getElementById('hdnPStatus').value = eventArgs.get_value();
}


 