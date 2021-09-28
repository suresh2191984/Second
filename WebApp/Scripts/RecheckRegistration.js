function ConverttoUpperCase(id) {
    var lowerCase = document.getElementById(id).value;
    var upperCase = lowerCase.toUpperCase();
    document.getElementById(id).value = upperCase;
}

function alpha(e) {
    var k;
    document.all ? k = e.keyCode : k = e.which;
    return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
    
}


function countQuickAge(id) {
    //alert(document.getElementById(id).value);
    if (document.getElementById(id).value != '' && document.getElementById('txtDOBNos').value != "0" && document.getElementById('txtDOBNos').value != ".") {
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
                                document.getElementById('ddlDOBDWMY').value = 'Day(s)';
                            }
                            else {
                                document.getElementById('txtDOBNos').value = totdays;
                                document.getElementById('ddlDOBDWMY').value = 'Day(s)';
                            }
                        }
                    }
                    else {
                        if (weeks == 1) {
                            document.getElementById('txtDOBNos').value = weeks;
                            document.getElementById('ddlDOBDWMY').value = 'Week(s)';
                        }
                        else {
                            document.getElementById('txtDOBNos').value = weeks;
                            document.getElementById('ddlDOBDWMY').value = 'Week(s)';
                        }
                    }
                }
                else {
                    if (months == 1) {
                        document.getElementById('txtDOBNos').value = months;
                        document.getElementById('ddlDOBDWMY').value = 'Month(s)';
                    }
                    else {
                        document.getElementById('txtDOBNos').value = months;
                        document.getElementById('ddlDOBDWMY').value = 'Month(s)';
                    }
                }
            }
            else {
                if (agetemp == 1) {

                    decimalAgeValue(agetemp, mm);
                    document.getElementById('ddlDOBDWMY').value = 'Year(s)';
                }
                else {

                    decimalAgeValue(agetemp, mm);
                    document.getElementById('ddlDOBDWMY').value = 'Year(s)';
                }
            }

            function lyear(a) {
                if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0)) return true;
                else return false;
            }
            // document.getElementById('ddlSex').focus();
            if (document.getElementById('hdnDoFrmVisit') == null || document.getElementById('hdnDoFrmVisit').value == "") {
                document.getElementById('txtDOBNos').focus();
            }
            else {
                document.getElementById('ddlSex').focus();
            }
        }
        else {
            alert(main + ' Date');
            document.getElementById('txtDOBNos').value = '';
            document.getElementById('tDOB').value = "dd//MM//yyyy";
            document.getElementById('tDOB').value = "dd//MM//yyyy";
            document.getElementById('tDOB').focus();
        }
    }
}


function ClearDOB() {

    if (document.getElementById('txtDOBNos').value < 0) {
        document.getElementById('txtDOBNos').value = '';
    }
    if (document.getElementById('txtDOBNos').value >= 150) {
        alert('Provide a valid year');
        document.getElementById('tDOB').value = "dd//MM//yyyy";
        document.getElementById('txtDOBNos').value = '';
        document.getElementById('txtDOBNos').focus();
        return false;
    }
    var valAge = 105;
    var valage1 = 95;
    var AGE = document.getElementById('txtDOBNos').value;
    if (AGE >= valAge) {
        alert('Age Should not be Greater than 105');
        document.getElementById('txtDOBNos').value = '';
        return false;
    }
    else if (AGE >= valage1 && AGE <= valAge) {
        var Userval = confirm('Age is Greater than 95 Do You want to continue');
    }
}


function blockNonNumbers(obj, e, allowDecimal, allowNegative) {
    var key;
    var isCtrl = false;
    var keychar;
    var reg;

    if (window.event) {
        key = e.keyCode;
        isCtrl = window.event.ctrlKey
    }
    else if (e.which) {
        key = e.which;
        isCtrl = e.ctrlKey;
    }

    if (isNaN(key)) return true;

    keychar = String.fromCharCode(key);

    // check for backspace or delete, or if Ctrl was pressed
    if (key == 8 || isCtrl) {
        return true;
    }

    reg = /\d/;
    var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
    var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

    return isFirstN || isFirstD || reg.test(keychar);
}

function getDOB() {
    if (document.getElementById('txtDOBNos').value.trim() == '') {
        alert('Provide Age in (Days or Weeks or Months or Year) & choose appropriate from the list');
        document.getElementById('txtDOBNos').focus();
        return false;
    }
    return true;
}

function setDDlDOBYear(id) {

    var ageVal = document.getElementById('txtDOBNos');

    // ageVal = document.getElementById('txtDOBNos');


    var ddlDOB = document.getElementById('ddlDOBDWMY');


    var dob = document.getElementById('tDOB');


    var date = dob.value;


    var ddlval = ddlDOB.value;


    var decimalAge = ageVal.value.split('.');
    if (decimalAge.length > 1 && ddlval != 'Year(s)') {
        alert('Can not give the Decimal value');
        document.getElementById('tDOB').value = '';
        document.getElementById('txtDOBNos').value = '';
        document.getElementById('ddlDOBDWMY').value = 'Year(s)';
        return false;
    }
    var days = new Date();

    if (ageVal.value != '') {
        if (ageVal.value.length < 3 && ddlval == 'Year(s)') {

            //var gdate = days.getDate();

            //var gmonth = days.getMonth();

            var gyear = days.getFullYear();

            dobYear = gyear - ageVal.value;

            document.getElementById('tDOB').value = '01/01/' + dobYear;

        }

        else if ((ddlval != 'Year(s)') && (ddlval == 'Month(s)' || ddlval == 'Day(s)' || ddlval == 'Week(s)')) {

            if (ageVal.value <= 1 && (ddlval == 'Year(s)')) {

                document.getElementById('tDOB').value = date;

            }

            else {

                if (ddlval == 'Day(s)') {
                    document.getElementById('tDOB').value = subDate(days, ageVal.value).format('dd/MM/yyyy'); //days.setDate(days.getDay() - ageVal.value);

                }

                if (ddlval == 'Week(s)') {
                    document.getElementById('tDOB').value = subWeek(days, ageVal.value).format('dd/MM/yyyy'); //days.setDate(days.getDay() - ageVal.value);

                }

                if (ddlval == 'Month(s)') {

                    document.getElementById('tDOB').value = subMonth(days, ageVal.value).format('dd/MM/yyyy'); //days.setDate(days.getDay() - ageVal.value);

                }

            }

        }


    }

}


function validateMultipleEmailsCommaSeparated(emailcntl, seperator) {
    var value = emailcntl.value;
    if (value != '') {
        var result = value.split(seperator);
        for (var i = 0; i < result.length; i++) {
            if (result[i] != '') {
                if (!validateEmail(result[i])) {
                    emailcntl.focus();
                    alert('Please check, "' + result[i] + '" email addresses not valid!');


                    return false;
                }
            }
        }
    }
    return true;
}

function validateEmail(field) {
    var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,5}$/;
    return (regex.test(field)) ? true : false;
}
function ClearDiscountLimitValues() {
    if (document.getElementById('hdnDiscountLimitType').value != 'EMPL') {
        document.getElementById('hdnDiscountLimitAmt').value = 0;
        document.getElementById('hdnSumDiscountAmt').value = 0;
        document.getElementById('hdnAvailableDiscountAmt').value = 0;
    }
}

//function setDOBYear(id) {

//    var ageVal = document.getElementById(id);
//    var decimalAge = ageVal.value.split('.');
//    ageVal = decimalAge[0];
//    var dob = document.getElementById('tDOB');


//    var ddlDOB = document.getElementById('ddlDOBDWMY');

//    var date = dob.value;


//    var ddlval = ddlDOB.value;

//    var days = new Date();

//    if (ageVal.value != '') {

//        if (ageVal.value.length < 3 && ddlval == 'Year(s)') {

//            //var gdate = days.getDate();

//            //var gmonth = days.getMonth();

//            var gyear = days.getFullYear();

//            dobYear = gyear - ageVal.value;

//            document.getElementById('tDOB').value = '01/01/' + dobYear;

//        }

//        else if ((ddlval != 'Year(s)') && (ddlval == 'Month(s)' || ddlval == 'Day(s)' || ddlval == 'Week(s)')) {

//            if (ageVal.value <= 1) {

//                document.getElementById('tDOB').value = date;

//            }

//            else {

//                if (ddlval == 'Day(s)') {

//                    document.getElementById('tDOB').value = subDate(days, ageVal.value).format('dd/MM/yyyy'); //days.setDate(days.getDay() - ageVal.value);

//                }

//                if (ddlval == 'Week(s)') {

//                    document.getElementById('tDOB').value = subWeek(days, ageVal.value).format('dd/MM/yyyy'); //days.setDate(days.getDay() - ageVal.value);

//                }

//                if (ddlval == 'Month(s)') {

//                    document.getElementById('tDOB').value = subMonth(days, ageVal.value).format('dd/MM/yyyy'); //days.setDate(days.getDay() - ageVal.value);

//                }

//            }

//        }

//    }

//}
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
                var days = new Date();
                //var gdate = days.getDate();
                //var gmonth = days.getMonth();
                var gyear = days.getFullYear();
                dobYear = gyear - ageVal.value;
                document.getElementById('tDOB').value = '01/01/' + dobYear;

 

            }
        }
    }
}

function PhysicianTempSelected(source, eventArgs) {
    $find('AutoCompleteExtenderRefPhy')._onMethodComplete = function(result, context) {
        //var Perphysicianname = document.getElementById('txtperphy').value;
        $find('AutoCompleteExtenderRefPhy')._update(context, result, /* cacheResults */false);
        if (result == "") {
            //alert('Please select Refering physician from the list');
            // $('[id$="txtInternalExternalPhysician"]').val("");
        }
    };

}

function PhysicianSelected(source, eventArgs) {

    var PhysicianID;
    var PhysicianName;
    var PhysicianCode;
    var PhysicianType;
    document.getElementById('txtInternalExternalPhysician').value = eventArgs.get_text();
    var PhyType;
    var list = eventArgs.get_value().split('^');
    //List[0] PhysicianType
    //List[1] PhysicianID
    //List[2] PhysicianName
    //List[3] PhysicianCode
    if (list.length > 0) {
        for (i = 0; i < list.length; i++) {
            if (list[i] != "") {
                PhysicianID = list[1];
                PhysicianName = list[2];
                PhysicianCode = list[3];
                PhysicianType = list[0].trim();
                PhyType = list[4];
            }
        }
    }
    document.getElementById('hdnReferedPhyID').value = PhysicianID;
    document.getElementById('hdnReferedPhyName').value = PhysicianName;
    document.getElementById('hdnReferedPhysicianCode').value = PhysicianCode;
    document.getElementById('hdnReferedPhyType').value = PhysicianType;

}

function DocPopulated(sender, e) {
    var behavior = $find('AutoCompleteExtenderRefPhy');
    var target = behavior.get_completionList();
    for (i = 0; i < target.childNodes.length; i++) {
        var text = target.childNodes[i]._value;
        var ItemArry;
        ItemArry = text.split('^');
        if (ItemArry[0].trim().toLowerCase() == 'p') {
            target.childNodes[i].style.color = "Black";
        }
        else {
            target.childNodes[i].style.color = "orange";
        }
    }
}
function subDate(o, days) {
    var newDate = new Date(o.getFullYear(), o.getMonth(), o.getDate() - days);
    return newDate;
}
function subMonth(o, days) {
    var newDate = new Date(o.getFullYear(), o.getMonth() - days, o.getDate());
    return newDate;
}
function subWeek(o, days) {
    var newDate = new Date(o.getFullYear(), o.getMonth(), o.getDate() - 7 * days);
    return newDate;
}

function decimalAgeValue(Yr, M) {
    var DecimalAge;
    var days = new Date();
    var gmonth = days.getMonth();
    var tmonth;
    var Dobvalue = document.getElementById('txtDOBNos').value;
    Dobvalue = Dobvalue.split('.');
    gmonth = parseInt(gmonth + 1);
    if (gmonth > M) {
        if (Dobvalue.length > 1 || Dobvalue == '') {
            tmonth = parseInt(gmonth - M);
            DecimalAge = Yr + '.' + tmonth;
        }
        else {
            DecimalAge = Yr;
        }
    }
    else {
        if (gmonth == M) {
            DecimalAge = Yr;
        }
        else {
            tmonth = M - gmonth;
            tmonth = 12 - tmonth;
            DecimalAge = Yr + '.' + tmonth;
        }
    }

    document.getElementById('txtDOBNos').value = DecimalAge;

}


function setSexValueQBLab(sexId, msId) {

    if (document.getElementById(msId).value == '6' || document.getElementById(msId).value == '7' || document.getElementById(msId).value == '8' || document.getElementById(msId).value == '12' || document.getElementById(msId).value == '9' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '19' || document.getElementById(msId).value == '20') {
        document.getElementById(sexId).value = 'M';
    }
    else if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '2' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '11' || document.getElementById(msId).value == '15'|| document.getElementById(msId).value == '22') {
        document.getElementById(sexId).value = 'F';
    }
    else if (document.getElementById(msId).value == '14') {
    }
    else {
        document.getElementById(sexId).value = '-1'; 
    }
}
