
function CheckInteger(sender, allowNegative, allowSpecialChar) {

    if (((event.keyCode >= 48 && event.keyCode <= 57 && event.shiftKey == false) ||
    // 0-9 numbers        
        (event.keyCode >= 96 && event.keyCode <= 105 && event.shiftKey == false) ||
    // 0-9 numbers (the numeric keys at the right of the keyboard)
        (event.keyCode >= 37 && event.keyCode <= 40) || // Left, Up, Right and Down        
        event.keyCode == 8 || // backspaceASKII
        event.keyCode == 9 || // tabASKII
        event.keyCode == 16 || // shift
        event.keyCode == 17 || // control
        event.keyCode == 35 || // End
        event.keyCode == 36 || // Home
        event.keyCode == 46) || // deleteASKII
        (allowSpecialChar == true &&
        ((event.keyCode >= 186 && event.keyCode <= 188) ||
        (event.keyCode >= 191 && event.keyCode <= 192) || //(;:=+_/ ?` ~,./
        (event.keyCode >= 219 && event.keyCode <= 222) || //[ {\ |] }" '
        (event.keyCode >= 106 && event.keyCode <= 108) || // /*-+.
        (event.keyCode == 111) || // /*-+.
        (event.keyCode >= 48 && event.keyCode <= 57 && event.shiftKey == true)))) //!@#$%^&*()
        return true;
    else if ((event.keyCode == 189 || event.keyCode == 109) && allowNegative == true) { // dash (-)
        if ((sender.value.indexOf('-', 0) > -1)) {
            return false;
        }
        else
            return true;
    }
    else
        return false;
}

function CheckDecimal(sender, allowNegative, allowSpecialChar) {

    var valueArr;
    if (((event.keyCode >= 48 && event.keyCode <= 57 && event.shiftKey == false) || // 0-9 numbers        
        (event.keyCode >= 96 && event.keyCode <= 105 && event.shiftKey == false) ||
        (event.keyCode >= 37 && event.keyCode <= 40) || // Left, Up, Right and Down
        event.keyCode == 8 || // backspaceASKII
        event.keyCode == 9 || // tabASKII
        event.keyCode == 16 || // shift
        event.keyCode == 17 || // control
        event.keyCode == 35 || // End
        event.keyCode == 36 || // Home
        event.keyCode == 46) || // deleteASKII
        (allowSpecialChar == true &&
        ((event.keyCode >= 186 && event.keyCode <= 188) ||
        (event.keyCode >= 191 && event.keyCode <= 192) || //(;:=+_/ ?` ~,./
        (event.keyCode >= 219 && event.keyCode <= 222) || //[ {\ |] }" '
        (event.keyCode >= 106 && event.keyCode <= 108) || // /*-+.
        (event.keyCode == 111) ||
        (event.keyCode >= 48 && event.keyCode <= 57 && event.shiftKey == true)))) //!@#$%^&*()
        return true;
    else if ((event.keyCode == 189 || event.keyCode == 109) && allowNegative == true) { // dash (-)
        if (sender.value.indexOf('-', 0) > -1)
            return false;
        else
            return true;
    }
    else if ((event.keyCode == 190 || event.keyCode == 110) && /[^.]/gi.test(sender.value)) { // decimal point (.)
        valueArr = sender.value.split('.');
        if (valueArr[0] != null && valueArr[1] == null)
            return true;
        else
            return false;
    }
    else
        return false;
}

function CheckCurrency(sender, allowNegative) {
    var valueArr;
    if ((event.keyCode >= 48 && event.keyCode <= 57 && event.shiftKey == false) || // 0-9 numbers        
        (event.keyCode >= 96 && event.keyCode <= 105 && event.shiftKey == false) ||
        (event.keyCode >= 37 && event.keyCode <= 40) || // Left, Up, Right and Down
        event.keyCode == 8 || // backspaceASKII
        event.keyCode == 9 || // tabASKII
        event.keyCode == 16 || // shift
        event.keyCode == 17 || // control
        event.keyCode == 35 || // End
        event.keyCode == 36 || // Home
        event.keyCode == 46 ||
        event.keyCode == 188)// [Comma]
        return true;
    else if (event.keyCode == 189 || event.keyCode == 109) { // dash (-) minus
        if (allowNegative == true) {
            if (sender.value.indexOf('-', 0) > -1)
                return false;
            else
                return true;
        }
        else
            return false;
    }
    else if ((event.keyCode == 190 || event.keyCode == 110) && /[^.]/gi.test(sender.value)) { // decimal point (.)
        valueArr = sender.value.split('.');
        if (valueArr[0] != null && valueArr[1] == null)
            return true;
        else
            return false;
    }
    else
        return false;
}

function CheckNegative(sender, AllowNegative) {
    if (AllowNegative && (event.keyCode == 189 || event.keyCode == 109)) { // dash (-)
        if (sender.value.indexOf('-', 0) > 0)
            sender.value = sender.value.replace('-', '');
    }
    var value = '';
    if (sender.value.length > 0)
        value = parseFloat(sender.value);
    if (AllowNegative == true && /^[+-]?[0-9]\d*(\.\d{1,3})?$/gi.test(value))
        return true;
    else if (/^([0-9]\d*(\.\d{1,3})?)?$/gi.test(value))
        return true;
    else {
        valueArr = sender.value.split('.');
        if (valueArr[1].length > 3) {
            sender.value = sender.value.substr(0, sender.value.length - 1)
        }
        else {
            alert("Enter valid Number");
            sender.value = ''
        }
        return false;
    }
}

function CheckAlpha(sender, nMaxlength, AllowSpecialChar) {
    if (((event.keyCode >= 37 && event.keyCode <= 40) || // Left, Up, Right and Down
            event.keyCode == 8 || // backspaceASKII
            event.keyCode == 9 || // tabASKII
            event.keyCode == 16 || // shift
            event.keyCode == 17 || // control
            event.keyCode == 35 || // End
            event.keyCode == 36 || // Home
            event.keyCode == 46)) // deleteASKII
        return true;
    else if ((event.keyCode >= 65 && event.keyCode <= 90) || //a-z A-Z
            event.keyCode == 190 || // Dot
            event.keyCode == 32 || //Spacebar
            (AllowSpecialChar == true &&
            ((event.keyCode >= 186 && event.keyCode <= 192) || //(;:=+-_/ ?` ~,./
            (event.keyCode >= 219 && event.keyCode <= 222) || //[ {\ |] }" '
            (event.keyCode >= 106 && event.keyCode <= 111) || // /*-+.
            (event.keyCode >= 48 && event.keyCode <= 57 && event.shiftKey == true)))) //!@#$%^&*()
    //Alphabets (A-Z, a-z)   
    {
        var nVal = parseInt(sender.value.length);
        if (parseInt(nMaxlength) > 0) {
            if (nVal <= parseInt(nMaxlength))
                return true;
            else
                return false;
        }
    }
    else
        return false;
}

function CheckAlphaNumeric(sender, nMaxlength, AllowSpecialChar) {

    if (((event.keyCode >= 37 && event.keyCode <= 40) || // Left, Up, Right and Down
        event.keyCode == 8 || // backspaceASKII
        event.keyCode == 9 || // tabASKII
        event.keyCode == 16 || // shift
        event.keyCode == 17 || // control
        event.keyCode == 35 || // End
        event.keyCode == 36 || // Home
        event.keyCode == 46)) // deleteASKII
        return true;
    else if ((event.keyCode >= 48 && event.keyCode <= 57 && event.shiftKey == false) || // 0-9 numbers        
        (event.keyCode >= 96 && event.keyCode <= 105 && event.shiftKey == false) || // 0-9 number pab
        (event.keyCode >= 65 && event.keyCode <= 90) || //a-z A-Z
        event.keyCode == 190 || // Dot
        event.keyCode == 32 || //Spacebar
        (AllowSpecialChar == true &&
        ((event.keyCode >= 186 && event.keyCode <= 192) || //(;:=+-_/ ?` ~,./
        (event.keyCode >= 219 && event.keyCode <= 222) || //[ {\ |] }" '
        (event.keyCode >= 106 && event.keyCode <= 111) || // /*-+.
        (event.keyCode >= 48 && event.keyCode <= 57 && event.shiftKey == true)))) //!@#$%^&*()
    //Alphabets (A-Z, a-z)   
    {
        var nVal = parseInt(sender.value.length);
        if (parseInt(nMaxlength) > 0) {
            if (nVal <= parseInt(nMaxlength))
                return true;
            else
                return false;
        }
    }
    else
        return false;
}

function CheckLength(sender, nMinlength, nMaxlength) {
    var WithinRange = true;
    var nVal = parseInt(sender.value.length);

    if (parseInt(nMinlength) > 0 && parseInt(nMaxlength) > 0) {
        if (nVal > 0 && (nVal < parseInt(nMinlength) || nVal > parseInt(nMaxlength)))
            WithinRange = false;
    }
    else if (parseInt(nMinlength) < 1 && parseInt(nMaxlength) > 0) {
        if (nVal > 0 && (nVal > parseInt(nMaxlength)))
            WithinRange = false;
    }
    else if (parseInt(nMaxlength) < 1 && parseInt(nMinlength) > 0) {
        if (nVal > 0 && (nVal < parseInt(nMinlength)))
            WithinRange = false;
    }
    else
        return WithinRange;
    if (!WithinRange) {
        alert("Text should contain mininum of " + nMinlength + " and maximum of " + nMaxlength + " characters");
        sender.value = '';
    }
    return WithinRange;
}
function CheckRange(sender, nMinVal, nMaxVal) {
    var nVal = parseFloat(sender.value);
    if (parseFloat(nMinVal) == 0 && parseFloat(nMaxVal) == 0)
        return true
    else if (nVal < parseFloat(nMinVal) || nVal > parseFloat(nMaxVal)) {
        alert("number out of Range(" + nMinVal + "-" + nMaxVal + ")");
        return false;
    }
    else
        return true;
}

function CheckSplChar(sender, RegexPattern, ContentType) {
    var strg;
    var RGXPattern = new RegExp(RegexPattern);
    if (ContentType == 'Numeric')
        strg = parseFloat(sender.value);
    else
        strg = sender.value;
    if (RGXPattern.test(strg))
        return true;
    else {
        alert("Invalid data entered, text will be cleared");
        sender.value = '';
        return false;
    }
}

function validatetext(sender, nMinVal, nMaxVal, nMinlength, nMaxlength) {
    var Isvalid = true;
    Isvalid = CheckRange(sender, nMinVal, nMaxVal);
    if (Isvalid)
    {
        Isvalid = CheckLength(sender, nMinlength, nMaxlength);
    }
    else
    {
        sender.value = '';
        return false;
    }

    return Isvalid;
}
