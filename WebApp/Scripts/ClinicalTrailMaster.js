
//Part 1
function loadState() {
    $("select[id$=drpState] > option").remove();
    $.ajax({
        type: "POST",
        url: "../OPIPBilling.asmx/GetStateByCountry",
        data: "{ 'CountryID': '" + parseInt(document.getElementById('drpCountry').value) + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function(data) {
            var Items = data.d;

            $('#drpState').attr("disabled", false);
            $('#drpState').append('<option value="-1">--Select--</option>');
            $.each(Items, function(index, Item) {
                $('#drpState').append('<option value="' + Item.StateID + '">' + Item.StateName + '</option>');
                document.getElementById('lblCountryCode').innerHTML = "+" + Item.ISDCode;
            });
            if (document.getElementById('hdnStateID').value > 0) {
                $('#drpState').val(document.getElementById('hdnStateID').value);
            }

        },
        failure: function(msg) {
            ShowErrorMessage(msg);
        }
    });
}
function onchangeState() {
    $('#hdnStateID').val(document.getElementById('drpState').value);
}

function SetContextKey(id) {

    var EpiClientID = document.getElementById('hdnOwnClientID').value;
    var sval = 'SIT^' + EpiClientID;
    $find('AutoCompleteExtenderSiteName').set_contextKey(sval);
}
function SelectedSiteValue(source, eventArgs) {
    document.getElementById('txtSiteName').value = eventArgs.get_text();
    document.getElementById('hdnSIteID').value = eventArgs.get_value();

}
function SelectedEpisodeValue(source, eventArgs) {
    var Args = eventArgs.get_value().split("^");
    var IsAlreadyCreated = Args[4];
    if (IsAlreadyCreated == "Y") {
        alert("This Episode is Already Created/Mapped with Visit");
        document.getElementById('txtEpisodeName').value = "";
        return false;
    } else {
        document.getElementById('txtEpisodeName').value = eventArgs.get_text();
        document.getElementById('hdnEpisodeName').value = eventArgs.get_text();

        // document.getElementById('hdnEpisodeID').value = Args[0];
        document.getElementById('hdnOwnClientID').value = Args[0];
        document.getElementById('hdnChildClientList').value = Args[1];  //Args[1];
        document.getElementById('hdnParentClientList').value = Args[2];
        document.getElementById('hdnChildCode').value = Args[3];
        document.getElementById('txtEpisodeNo').value = Args[3];
        document.getElementById('ddlEpisodeType').value = Args[5];
        document.getElementById('hdnClientType').value = Args[5];

        // document.getElementById('ddlEpisodeType').disabled = true;
        document.getElementById('txtEpisodeNo').readOnly = true;

        SetEpisodeValues();
        SetContextKey();
    }
}
function SetEpisodeValues() {
    var ParentClientList = document.getElementById('hdnParentClientList').value.split('###');
    var ParentClient = ParentClientList[0].split('~');
    document.getElementById('hdnClientID').value = ParentClient[0];
    document.getElementById('txtClientName').value = ParentClient[1];
    document.getElementById('txtSponsor').value = ParentClient[1];
    document.getElementById('txtClientName').readOnly = true;
    var IsFromTable = 'N';
    CreateChildClientList(IsFromTable);
}
function SelectedPackageValue(source, eventArgs) {
    document.getElementById('txtPkgName').value = eventArgs.get_text();
    document.getElementById('hdnPackageID').value = eventArgs.get_value();

}
function SelectedClientValue(source, eventArgs) {
    document.getElementById('txtClientName').value = eventArgs.get_text();
    var Args = eventArgs.get_value().split("^");
    document.getElementById('hdnClientID').value = Args[0];
    document.getElementById('hdnChildClientList').value = Args[1];  //Args[1];

}

function SelectedKitName(source, eventArgs) {
    document.getElementById('txtKitName').value = eventArgs.get_text();
    document.getElementById('hdnKitID').value = eventArgs.get_value();

}
function OnsalesManselected(source, eventArgs) {
    document.getElementById('txtsalesmancode').value = eventArgs.get_text();
    document.getElementById('hdntxtsalesmancode').value = eventArgs.get_value();
}
function Onzoneselected(source, eventArgs) {
    document.getElementById('txtzone').value = eventArgs.get_text();
    document.getElementById('hdntxtzoneID').value = eventArgs.get_value();
}
function OnCollectioncenterselected(source, eventArgs) {
    document.getElementById('txtcollectioncenter').value = eventArgs.get_text();
    document.getElementById('hdncollectioncenterid').value = eventArgs.get_value();
}
function viewParentrow() {
    if (document.getElementById('chkparentlcient').checked) {
        document.getElementById('viewparent').style.display = 'block';
    }
    else {
        document.getElementById('viewparent').style.display = 'none';
    }

}
//        function isNumericss(e, Id) {

//            var key; var isCtrl; var flag = 0;
//            var txtVal = document.getElementById(Id).value.trim();
//            var len = txtVal.split('.');
//            if (len.length > 1) {
//                flag = 1;
//            }
//            if (window.event) {
//                key = window.event.keyCode;
//                if (window.event.shiftKey) {
//                    isCtrl = false;
//                }
//                else {
//                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
//                        isCtrl = true;
//                    }
//                    else {
//                        isCtrl = false;
//                    }
//                }
//            } return isCtrl;
//        }

//Only numbers will allowed
function isNumeric(e, Id) {
    //            var key; var isCtrl; var flag = 0;
    //            var txtVal = document.getElementById(Id).value.trim();
    //            var len = txtVal.split('.');
    //            if (len.length > 0) {
    //                flag = 1;
    //            }
    //            if (window.event) {
    //                key = window.event.keyCode;
    //                if (window.event.shiftKey) {
    //                    isCtrl = true;
    //                }
    //                else {
    //                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 188) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
    //                        isCtrl = true;
    //                    }
    //                    else {
    //                        isCtrl = false;
    //                    }
    //                }
    //            }
    return true;
}
//only text allowed
function vaddress(e) {
    var key;
    var isCtrl = false;

    if (window.event) // IE8 and earlier
    {
        key = e.keyCode;
    }
    else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
    {
        key = e.which;
    }

    if ((key != 36) && (key != 126)) {
        isCtrl = true;
    }

    return isCtrl;
}
var EditorInstance = "";
function isSpclChar(e) {
    var key;
    var isCtrl = false;

    if (window.event) // IE8 and earlier
    {
        key = e.keyCode;
    }
    else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
    {
        key = e.which;
    }

    if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32) || (key == 44) || (key == 46)) {
        isCtrl = true;
    }

    return isCtrl;
}


function CheckCodes(codeType, TextBoxID) {
    var txtValue = document.getElementById(TextBoxID).value;
    WebService.GetCheckCode(codeType, txtValue, onCheckCounts);
}
function checkMailId() {
    var emailID = document.getElementById('txtEmailID')
    if ((emailID.value == null) || (emailID.value.trim() != "")) {
        if (echecks(emailID.value) == false) {
            emailID.value = ""
            emailID.focus()
            return false
        }
    }
    return true
}
function evalid(str) {
    var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
    if (reg.test(str) == false) {
        document.getElementById('txtEmailID').value = "";
        document.getElementById('txtEmailID').focus();
        alert('Invalid e-mail ID');
        return false;
    }
}
function echecks(str) {
    var flag = 0;
    if (str.split(",")[0] != "") {
        var s = str.split(",");
        for (var i = 0; i < s.length; i++) {
            if (s[i] != "") {
                if (checkits(s[i])) {
                    evalid(s[i]);
                    flag = 0;
                }
                else {
                }
            }
        }
    }
    else {
        if (checkits(str)) {
            flag = 0;
        }
        else {
            flag = 1;
        }
    }
    if (flag == 0) {
        return true;
    }
    else {
        alert('Invalid e-mail ID');
        return false;
    }


}
function checkits(str) {
    var at = "@"
    var dot = "."
    var lat = str.indexOf(at)
    var lstr = str.length
    var ldot = str.indexOf(dot)
    if (str.indexOf(at) == -1) {
        //                alert('Invalid e-mail ID');
        return false
    }

    if (str.indexOf(at) == -1 || str.indexOf(at) == 0 || str.indexOf(at) == lstr) {
        //                alert('Invalid e-mail ID');
        return false
    }

    if (str.indexOf(dot) == -1 || str.indexOf(dot) == 0 || str.indexOf(dot) == lstr) {
        //                alert('Invalid e-mail ID');
        return false
    }

    if (str.indexOf(at, (lat + 1)) != -1) {
        //                alert('Invalid e-mail ID');
        return false
    }

    if (str.substring(lat - 1, lat) == dot || str.substring(lat + 1, lat + 2) == dot) {
        //                alert('Invalid e-mail ID');
        return false
    }

    if (str.indexOf(dot, (lat + 2)) == -1) {
        //                alert('Invalid e-mail ID');
        return false
    }

    if (str.indexOf(" ") != -1) {
        //                alert('Invalid e-mail ID');
        return false
    }

    return true
}
function onCheckCounts(count) {
    if (count > 0) {
        document.getElementById('txtClientCode').value = "";

        alert("This Code Already Exists");
        return false;


    }
}
function clientname() {
    //            if (document.getElementById('txtClientName').value == "") {
    //                document.getElementById('txtClientName').value = "";
    //                alert("Enter Client Name");
    //                return false;
    //            }
    //            else {
    //                return true;
    //            }
    //
}
function mobilevalid() {
    if (document.getElementById('txtmobileno').value != "") {
        var str = document.getElementById('txtmobileno').value;
        if (str.split(",")[0] != "") {
            var s = str.split(",");
            for (var i = 0; i < s.length; i++) {
                if (s[i] != "") {
                    if (s[i].length > 10 || s[i].length < 10) {
                        alert("Mobile No. should be 10 digit");
                        document.getElementById('txtmobileno').focus();
                        document.getElementById('txtmobileno').value = "";
                        return false;
                    }

                }
            }
        }
    }
}
function checkAddressDetails() {
    if (document.getElementById('hdnPackageID').value == "") {
        document.getElementById('txtPkgName').value = "";
        document.getElementById('txtPkgName').focus();
        alert("Enter Package Name");
        return false;
    }
    if (document.getElementById('txtVisitName').value == "") {
        document.getElementById('txtVisitName').value = "";
        document.getElementById('txtVisitName').focus();
        alert("Enter Visit Name");
        return false;
    }
    if (document.getElementById('txtPkgName').value == "") {
        document.getElementById('txtPkgName').value = "";
        document.getElementById('txtPkgName').focus();
        alert("Enter Package Name");
        return false;
    }
    if (document.getElementById('txtTimedValue').value == "") {
        document.getElementById('txtTimedValue').value = "";
        document.getElementById('txtTimedValue').focus();
        alert("Enter Timed Visit");
        return false;
    }
    if (document.getElementById('txtVisitNo').value == "") {
        document.getElementById('txtVisitNo').value = "";
        document.getElementById('txtVisitNo').focus();
        alert("Enter Visit No");
        return false;
    }
    if (document.getElementById('hdnKitDetails').value == "") {
        document.getElementById('txtKitName').value = "";
        document.getElementById('txtKitName').focus();
        alert("Add Kit Details");
        return false;
    }
    if (document.getElementById('ddlSiteWiseSubject').value == "2" || document.getElementById('ddlVisitWiseSubject').value == "2") {
        if (document.getElementById('hdnSiteDetails').value == "") {
            document.getElementById('txtSiteName').value = "";
            document.getElementById('txtSiteName').focus();
            alert("Associate Sites with Visit");
            return false;
        }
    }


    //            if (!CheckVisitNumberSequence()) {
    //                return false;
    //            }
    return true;
}
function checkisempty() {
    var UndefinedScreening = document.getElementById('chkUndefinedScreening').checked;
    if (document.getElementById('txtFromPeriod').value == "" && document.getElementById('txtToPeriod').value == "") {
        if (!confirm('From Date & To Date of this Study/Protocol is not Mention here, Are you Sure to procced?')) {
            return false;
        }
    }
    else {
        if (!ExcedDate('txtFromPeriod', 'txtToPeriod', 1, 0)) {
            return false;
        }
    }
    if (document.getElementById('hdnClientID').value == "") {
        document.getElementById('txtClientName').value = "";
        document.getElementById('txtClientName').focus();
        alert("Enter Client Name");
        return false;
    }
    if (document.getElementById('ddlEpisodeType').value == "0") {
        document.getElementById('ddlEpisodeType').value = "0";
        document.getElementById('ddlEpisodeType').focus();
        alert("Select Episode Type");
        return false;
    }

    if (document.getElementById('txtClientName').value == "") {
        document.getElementById('txtClientName').value = "";
        document.getElementById('txtClientName').focus();
        alert("Enter Client Name");
        return false;
    }
    if (document.getElementById('txtEpisodeName').value == "") {
        document.getElementById('txtEpisodeName').value = "";
        document.getElementById('txtEpisodeName').focus();
        alert("Enter Episode Name");
        return false;
    }
    if (document.getElementById('txtEpisodeNo').value == "") {
        document.getElementById('txtEpisodeNo').value = "";
        document.getElementById('txtEpisodeNo').focus();
        alert("Enter Episode Number");
        return false;
    }
    if (!UndefinedScreening) {
        if (document.getElementById('txtscrSubjects').value == "" || document.getElementById('txtscrSubjects').value == "0") {
            document.getElementById('txtscrSubjects').value = "";
            document.getElementById('txtscrSubjects').focus();
            alert("Enter Number Screening Subjects");
            return false;
        }
    }
    if (document.getElementById('txtNoOfPatient').value == "" || document.getElementById('txtNoOfPatient').value == "0") {
        document.getElementById('txtNoOfPatient').value = "";
        document.getElementById('txtNoOfPatient').focus();
        alert("Enter Number Monitoring Subjects");
        return false;
    }
    if (document.getElementById('txtSiteCount').value == "") {
        document.getElementById('txtSiteCount').value = "";
        document.getElementById('txtSiteCount').focus();
        alert("Enter Number Of Sites");
        return false;
    }
    var TotalNoOfSites = document.getElementById('txtSiteCount').value;
    var TotalNoSubjects = document.getElementById('txtNoOfPatient').value;
    var TotalScreenSubjects = document.getElementById('txtscrSubjects').value;

    var Resu = String(Number(TotalNoSubjects) / Number(TotalNoOfSites));
    
    //alert(Resu);  
    if (!UndefinedScreening) {
        var ScreenResu = String(Number(TotalScreenSubjects) / Number(TotalNoOfSites));
        if (ScreenResu.indexOf(".") != -1) {
            if (document.getElementById('ddlSiteWiseSubject').value == "1" || document.getElementById('ddlVisitWiseSubject').value == "1") {
                alert("Number of Screening Subjects and Number Sites are MisMatched");
                document.getElementById('txtscrSubjects').focus();
                return false;
            }
        }        
    }
    else {
        if (!confirm('The No.of Screening Subject is Undefined, Are you Sure to procced?')) {
            document.getElementById('chkUndefinedScreening').focus();
            return false;
        }
    }
    if (Resu.indexOf(".") != -1) {
        if (document.getElementById('ddlSiteWiseSubject').value == "1" || document.getElementById('ddlVisitWiseSubject').value == "1") {
            alert("Number of Monitoring Subjects and Number Sites are MisMatched");
            document.getElementById('txtNoOfPatient').focus();
            return false;
        }
    }
   
    
    // return false;


    //    if (document.getElementById('ddlCTStudyPhase').value == "0") {
    //        document.getElementById('ddlCTStudyPhase').value = "0";
    //        document.getElementById('ddlCTStudyPhase').focus();
    //        alert("Select Ct Study Phase");
    //        return false;
    //    }

    var pList = document.getElementById('hdnAddressDetails').value.split("^");
    if (pList == "") {
        alert("Enter Visit Episode Information");
        return false;
    }
    if (!CheckVisitNumberSequence()) {
        return false;
    }
    return true;
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
    if (isCtrl || (key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 188) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46)) {
        //            if (key == 8 || isCtrl) {
        return true;
    }

    reg = /\d/;
    var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
    var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

    return isFirstN || isFirstD || reg.test(keychar);
}


//Part 2

function showNewDIV() {
    showResponses('dvShowNew', 'dvHideNew', 'dvNewEpisode', 1)
}
function ShowTRFUpload(obj, id) {
    if (obj.checked) {
        document.getElementById('divUpload').style.display = 'block';
    }
    else {
        document.getElementById('divUpload').style.display = 'none';
    }
}
function clientcler() {
    document.getElementById('ddlClientTypes').value = "1";
    document.getElementById('txtValue').value = "";
    document.getElementById('txtClientAttributes').value = "";
    document.getElementById('chkReg').checked = false;
    document.getElementById('chkInvoice').checked = false;
    document.getElementById('chkReceipt').checked = false;

}
function createClienttab() {
    if (document.getElementById('txtClientAttributes').value == "") {
        document.getElementById('txtClientAttributes').focus();
        alert('Enter the Episode Attributes');
        return false;
    }
    if (document.getElementById('txtValue').value == "") {
        document.getElementById('txtValue').focus();
        alert('Enter the Clien Attributes Values');
        return false;
    }
    if (document.getElementById('chkReg').checked != true || document.getElementById('chkInvoice').checked != true || document.getElementById('chkReceipt').checked != true) {

    }
    else {
        alert('Select Any one Show Type');
        return false;
    }

    var j = 1;
    var obj = document.getElementById('ddlClientTypes');
    var i = obj.getElementsByTagName('OPTION');
    var AddStatus = 0;
    var Attributes = document.getElementById('txtClientAttributes').value;
    var Value = document.getElementById('txtValue').value;
    var rwNumber = j;  //obj.options[obj.selectedIndex].value;
    var Type = obj.options[obj.selectedIndex].text;
    var ShowIn = '';

    if (document.getElementById('chkReg').checked == true) {
        ShowIn = 'Reg';
    }
    if (document.getElementById('chkInvoice').checked == true) {
        ShowIn = ShowIn + ',' + 'Invoice';
    }
    if (document.getElementById('chkReceipt').checked == true) {
        ShowIn = ShowIn + ',' + 'Receipt';
    }
    //document.getElementById('tblAttributes').style.display = 'block';
    var HidValue = document.getElementById('hdnClientAttributes').value;
    // var txtvalue = document.getElementById('hdntxtvalue').value;
    var list = HidValue.split('^');
    //var clientvalue = txtvalue.split('^');
    if (document.getElementById('hdnClientAttributes').value != "") {
        for (var count = 0; count < list.length; count++) {
            var SpecialityList = list[count].split('~');
            if (SpecialityList[1] != '') {
                if (SpecialityList[0] != '') {
                    rwNumber = parseInt(parseInt(SpecialityList[0]) + parseInt(1));
                }
                if (Attributes != '') {
                    if (SpecialityList[1] == Attributes) {
                        AddStatus = 1;
                    }
                }
            }
        }
    }
    else {

        if (Attributes != '') {
            var row = document.getElementById('tblClientAttributes').insertRow(1);
            //rwNumber = Attributes + rwNumber;
            row.id = rwNumber;
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            //alert("rwNumber:" + rwNumber);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient(" + rwNumber + ");' src='../Images/Delete.jpg' />";
            cell1.width = "10%";
            cell2.innerHTML = "<b>" + Attributes + "</b> ";
            cell2.width = "45%";
            cell3.innerHTML = "<b>" + Type + "</b> ";
            cell3.width = "45%";
            cell4.innerHTML = "<b>" + Value + "</b> ";
            cell4.width = "45%";
            cell5.innerHTML = "<b>" + ShowIn + "</b> ";
            cell5.width = "55%";

            document.getElementById('hdnClientAttributes').value += rwNumber + "~" + Attributes + "~" + Type + "~" + Value + "~" + ShowIn + "^";

            AddStatus = 2;
            document.getElementById('tblClientAttributes').style.display = 'block'
            j++;
        }
        else {
            alert('Provide attribute value');
        }
    }
    if (AddStatus == 0) {
        if (Attributes != '') {
            var row = document.getElementById('tblClientAttributes').insertRow(1);
            //alert("rwNumber1:" + rwNumber);
            //rwNumber = Attributes + rwNumber;
            row.id = rwNumber;
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            //alert("rwNumber1:" + rwNumber);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient(" + rwNumber + ");' src='../Images/Delete.jpg' />";
            cell1.width = "6%";
            cell2.innerHTML = "<b>" + Attributes + "</b> ";
            cell3.innerHTML = "<b>" + Type + "</b>";
            cell4.innerHTML = "<b>" + Value + "</b>";
            cell5.innerHTML = "<b>" + ShowIn + "</b> ";
            j++;
            document.getElementById('hdnClientAttributes').value += rwNumber + "~" + Attributes + "~" + Type + "~" + Value + "~" + ShowIn + "^";
            document.getElementById('tblClientAttributes').style.display = 'block';
        }

        else {
            alert('Provide attribute value');
        }

    }
    else if (AddStatus == 1) {
        alert('Attribute already added');
    }
    clientcler();
    return;
}

function ImgOnclickClient(ImgID) {
    document.getElementById(ImgID).style.display = "none";
    var HidValue = document.getElementById('hdnClientAttributes').value;
    var list = HidValue.split('^');
    var NewHealthCheckupList = '';
    if (document.getElementById('hdnClientAttributes').value != "") {
        for (var count = 0; count < list.length; count++) {
            var HealthCheckupList = list[count].split('~');
            if (HealthCheckupList[0] != '') {
                if (HealthCheckupList[0] != ImgID) {
                    NewHealthCheckupList += list[count] + '^';
                }
            }
        }
        document.getElementById('hdnClientAttributes').value = NewHealthCheckupList;
    }
    if (document.getElementById('hdnClientAttributes').value == '') {
        document.getElementById('hdnClientAttributes').style.display = 'none';

    }
}


//part 3

function CheckVisitNumber(id) {
    var VisitNo = document.getElementById(id).value;
    var pList = document.getElementById('hdnAddressDetails').value.split("^");
    if (pList != "") {
        var CompareLength = 1;
        for (var i = 0; i < pList.length - 1; i++) {
            if (pList[i] != "") {
                var y = pList[i].split('|');
                if (y[4] == VisitNo) {
                    alert("This Visit Number is already Given, Give Another number");
                    document.getElementById('txtVisitNo').value = "";
                    document.getElementById('txtVisitNo').focus();
                    return false;
                }
            }
        }
    }
    return true;
}
function CheckVisitNumberSequence() {
    var pList = document.getElementById('hdnAddressDetails').value.split("^");
    if (pList != "") {
        var CompareLength = 0;
        for (var i = 0; i < pList.length - 1; i++) {
            if (pList[i] != "") {
                var y = pList[i].split('|');
                for (var j = 1; j < pList.length; j++) {
                    if (y[4] == j) {
                        CompareLength++;
                    }
                }
            }
        }
        if (CompareLength != pList.length - 1) {
            alert("Visit Number Sequence is Incorrect");
            return false;
        }
    }
    return true;
}

function clearaddress() {
    //        var countryid = document.getElementById('drpCountry').value;
    //        var stateid = document.getElementById('drpState').value;
    document.getElementById('txtVisitName').value = "";
    document.getElementById('txtPkgName').value = "";
    document.getElementById('txtTimedValue').value = "";
    document.getElementById('txtVisitNo').value = "";
    document.getElementById('ddlTimedType').value = "D";

    document.getElementById('txtKitName').value = "";
    document.getElementById('txtNoOfKit').value = "1";
    document.getElementById('chkmandatory').checked = false;
    document.getElementById('hdnKitDetails').value = "";
    document.getElementById('hdnSiteDetails').value = "";
    document.getElementById('txtSiteName').value = "";
    document.getElementById('txtSitePatientNo').value = "0";

    document.getElementById('hdnPackageID').value = "";
    document.getElementById('ddlVisitType').value = "0";

    document.getElementById('hdnVisitGuid').value = "";
    document.getElementById('hdnEpisodeVisitId').value = "";
}
function checkCustomerAddress() {
    if (checkAddressDetails()) {

        var VisitName = document.getElementById('txtVisitName').value;
        var PkgName = document.getElementById('txtPkgName').value;
        var TimedNo = document.getElementById('txtTimedValue').value;
        var VisitNo = document.getElementById('txtVisitNo').value;

        var obj = document.getElementById('ddlTimedType');
        var i = obj.getElementsByTagName('OPTION');
        var TimedType = obj.options[obj.selectedIndex].text;
        var TimedTypeID = document.getElementById('ddlTimedType').value;

        var KitName = document.getElementById('txtKitName').value;
        var NoOfKit = document.getElementById('txtNoOfKit').value;

        var PackageID = document.getElementById('hdnPackageID').value;
        var IsMandatory = document.getElementById('chkmandatory').checked ? "Yes" : "No";

        var VisitTypeID = document.getElementById('ddlVisitType').value;
        var VisitType
        if (VisitTypeID != "0") {
            var VisitTypeobj = document.getElementById('ddlVisitType');
            VisitType = VisitTypeobj.options[VisitTypeobj.selectedIndex].text;
        }
        else {
            VisitType = '--'
        }
        //document.getElementById('btnAdd').value = 'A';
        //document.getElementById('lblmsg').innerText = "AddMore";
        // document.getElementById('hdnStatus').value = 'AddMore';

        // var addresstype = document.getElementById('drpaddresstype').options[document.getElementById('drpaddresstype').selectedIndex].text;
        var VisitGuid = document.getElementById('hdnVisitGuid').value == "" ? "NEWVISIT" : document.getElementById('hdnVisitGuid').value;
        var EpisodeVisitId = document.getElementById('hdnEpisodeVisitId').value == "" ? "-1" : document.getElementById('hdnEpisodeVisitId').value;

        document.getElementById('hdnSiteTempTable1').value = document.getElementById('hdnSiteTempTable1').value == '' ? 'Proportional' : document.getElementById('hdnSiteTempTable1').value;
        document.getElementById('hdnSiteTempTable2').value = document.getElementById('hdnSiteTempTable2').value == '' ? 'Proportional' : document.getElementById('hdnSiteTempTable2').value;
        
        document.getElementById('hdnAddressDetails').value += VisitName + "|" + PkgName + "|" + TimedNo + "|" + TimedType + "|" + VisitNo + "|" + document.getElementById('hdnKitTempTable1').value + "|" +
        document.getElementById('hdnKitTempTable2').value + "|" + IsMandatory + "|" + TimedTypeID + "|" + PackageID + "|" +
        document.getElementById('hdnSiteTempTable1').value + "|" + document.getElementById('hdnSiteTempTable2').value + "|" + VisitType + "|" +
        VisitTypeID + "|" + VisitGuid + "|" + EpisodeVisitId + "^";

        GenerateTable();
        document.getElementById('hdnKitDetails').value = "";
        document.getElementById('hdnKitTempTable1').value = "";
        document.getElementById('hdnKitTempTable2').value = "";
        document.getElementById('hdnSiteDetails').value = "";
        document.getElementById('hdnSiteTempTable1').value = "";
        document.getElementById('hdnSiteTempTable2').value = "";
        GenerateKitDetailTable();
        GenerateSiteDetailTable();

        clearaddress();
        showResponses('dvAtt1', 'dvAtt2', 'divLocation', 0);
    }

}

function GenerateTable() {

    document.getElementById('btnAdd').value = "Add Visit";
    while (count = document.getElementById('tblClientDetail').rows.length) {
        for (var j = 0; j < document.getElementById('tblClientDetail').rows.length; j++) {
            document.getElementById('tblClientDetail').deleteRow(j);
        }
    }
    var pList = document.getElementById('hdnAddressDetails').value.split("^");
    if (pList != "") {
        document.getElementById('divaddressdetails').style.display = "block";
        var Headrow = document.getElementById('tblClientDetail').insertRow(0);
        Headrow.id = "HeadID";
        var id = 0;
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
        var cell9 = Headrow.insertCell(8);
        var cell10 = Headrow.insertCell(9);

        cell1.innerHTML = "S.No.";
        cell2.innerHTML = "Visit Name";
        cell3.innerHTML = "Visit Type";
        cell4.innerHTML = "Package Name";
        cell5.innerHTML = "Timed Visit";
        cell6.innerHTML = "Visit No";
        cell7.innerHTML = "Kit Details";
        cell8.innerHTML = "Site Associates";
        cell9.innerHTML = "Is Mandatory";
        cell10.innerHTML = "Action";

        for (s = 0; s < pList.length; s++) {
            if (pList[s] != "") {
                y = pList[s].split('|');
                var row = document.getElementById('tblClientDetail').insertRow(1);
                row.style.height = "10px";
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

                cell1.innerHTML = pList.length == 1 ? pList.length : pList.length - s - 1;
                cell2.innerHTML = y[0];
                cell3.innerHTML = y[12];
                cell4.innerHTML = y[1];
                var NumType;
                if (y[2] > 3 && y[2] < 21) {
                    NumType = "<sup>th</sup>";
                }
                else {
                    var StrCount = y[2].length;
                    var Num = y[2].charAt(StrCount - 1)

                    if (Num == "1") {
                        NumType = "<sup>st</sup>";
                    }
                    if (Num == "2") {
                        NumType = "<sup>nd</sup>";
                    }
                    if (Num == "3") {
                        NumType = "<sup>rd</sup>";
                    }
                    if (Num == "4" || Num == "5" || Num == "6" || Num == "7" || Num == "8" || Num == "9" || Num == "10") {
                        NumType = "<sup>th</sup>";
                    }
                }
                cell5.innerHTML = y[2] + NumType + " " + y[3];
                cell6.innerHTML = y[4];

                cell7.innerHTML = y[6];
                cell8.innerHTML = y[11];
                cell9.innerHTML = y[7];
                cell10.innerHTML = "<input id='edit1' name='" + y[0] + "|" + y[1] + "|" + y[2] + "|" + y[3] + "|" + y[4] + "|" + y[5] + "|" + y[6] + "|" + y[7] + "|" + y[8] + "|" + y[9] + "|" + y[10] + "|" + y[11] + "|" + y[12] + "|" + y[13] + "|" + y[14] + "|" + y[15] +
                                                                "' onclick='btnDeleteTblClientDetails(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  />"

                                + "<input id='edit' name='" + y[0] + "|" + y[1] + "|" + y[2] + "|" + y[3] + "|" + y[4] + "|" + y[5] + "|" + y[6] + "|" + y[7] + "|" + y[8] + "|" + y[9] + "|" + y[10] + "|" + y[11] + "|" + y[12] + "|" + y[13] + "|" + y[14] + "|" + y[15] +
                                                                                               "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;"
            }
        }
        document.getElementById('ddlSiteWiseSubject').disabled = true;
        document.getElementById('ddlVisitWiseSubject').disabled = true;
    }
    else {
        document.getElementById('ddlSiteWiseSubject').disabled = false;
        document.getElementById('ddlVisitWiseSubject').disabled = false;
    }
    showResponses('dvAtt1', 'dvAtt2', 'divLocation', 0)
}
function btnEdit_OnClick(sEditedData) {
    if (document.getElementById('hdnAddressDetails').value != "") {
        var y = sEditedData.split('|');
        //document.getElementById('ddlTimedType').value;
        document.getElementById('txtVisitName').value = y[0];
        document.getElementById('txtPkgName').value = y[1];
        document.getElementById('txtTimedValue').value = y[2];
        document.getElementById('ddlTimedType').value = y[8];
        document.getElementById('txtVisitNo').value = y[4];

        var Kit = y[5].split('@');
        var NewKit = "";
        for (s = 0; s < Kit.length; s++) {
            if (Kit[s] != "") {
                NewKit += Kit[s] + "^";
            }
        }
        document.getElementById('hdnKitDetails').value = NewKit;
        document.getElementById('hdnKitTempTable1').value = y[5]; // += KitID + "~" + KitName + "~" + Value + "@";
        document.getElementById('hdnKitTempTable2').value = y[6]; //KitName + " : " + Value + " (Nos) " + " <br> ";
        GenerateKitDetailTable();
        if (y[10] != 'Proportional') {
            var Site = y[10].split('@');
            var NewSite = "";
            for (s = 0; s < Site.length; s++) {
                if (Site[s] != "") {
                    NewSite += Site[s] + "^";
                }
            }
            document.getElementById('hdnSiteDetails').value = NewSite;
            document.getElementById('hdnSiteTempTable1').value = y[10]; // += KitID + "~" + KitName + "~" + Value + "@";
            document.getElementById('hdnSiteTempTable2').value = y[11]; //KitName + " : " + Value + " (Nos) " + " <br> ";
        }
        else {
            document.getElementById('hdnSiteDetails').value = '';
            document.getElementById('hdnSiteTempTable1').value = y[10];
            document.getElementById('hdnSiteTempTable2').value = y[10];
        }
        GenerateSiteDetailTable();

        document.getElementById('hdnPackageID').value = y[9];
        document.getElementById('chkmandatory').checked = y[7] == "Yes" ? true : false;

        var list = document.getElementById('hdnAddressDetails').value.split("^");
        document.getElementById('hdnAddressDetails').value = "";
        for (var i = 0; i < list.length; i++) {
            if (list[i] != "") {
                if (list[i] != sEditedData) {
                    document.getElementById('hdnAddressDetails').value += list[i] + "^";
                }
            }
        }
        document.getElementById('ddlVisitType').value = y[13];
        document.getElementById('hdnVisitGuid').value = y[14];
        document.getElementById('hdnEpisodeVisitId').value = y[15];
    }
    //   showResponses('ACX2OPPmt', 'ACX2minusOPPmt', 'ACX2responsesOPPmt', 0)
    GenerateTable();
    //        var tbl = document.getElementById('tblClientDetail').rows.length;
    //        var Tb = document.getElementById('tblClientDetail');
    //        if (tbl > 0) {
    //            for (var j = 0; j < tbl; j++) {
    //                Tb.rows[j].cells[9].style.display = "none";
    //            }
    //        }



    document.getElementById('btnAdd').value = "Add Visit";
}
function btnDeleteTblClientDetails(sEditedData) {
    var i;
    var IsDelete = confirm("Confirm to delete!!");
    if (IsDelete == true) {
        var x = document.getElementById('hdnAddressDetails').value.split("^");
        document.getElementById('hdnAddressDetails').value = '';
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                if (x[i] != sEditedData) {
                    document.getElementById('hdnAddressDetails').value += x[i] + "^";
                }
            }
        }
        GenerateTable();
    }
    else {
        return false;
    }
}

//part4

function checkEpisodeAttributes() {
    if (document.getElementById('txtClientAttributes').value == "") {
        document.getElementById('txtClientAttributes').focus();
        alert('Enter the Episode Attributes');
        return false;
    }
    if (document.getElementById('txtValue').value == "") {
        document.getElementById('txtValue').focus();
        alert('Enter the Clien Attributes Values');
        return false;
    }
    if (document.getElementById('chkReg').checked == true || document.getElementById('chkInvoice').checked == true || document.getElementById('chkReceipt').checked == true) {

    }
    else {
        alert('Select Any one Show Type');
        return false;
    }
    return true;
}
function clearEpisodeAttributes() {
    document.getElementById('ddlClientTypes').value = "1";
    document.getElementById('txtValue').value = "";
    document.getElementById('txtClientAttributes').value = "";
    document.getElementById('chkReg').checked = false;
    document.getElementById('chkInvoice').checked = false;
    document.getElementById('chkReceipt').checked = false;


}
function checkEpisodeATtributes() {
    if (checkEpisodeAttributes()) {

        var obj = document.getElementById('ddlClientTypes');
        var i = obj.getElementsByTagName('OPTION');
        var AddStatus = 0;
        var Attributes = document.getElementById('txtClientAttributes').value;
        var Value = document.getElementById('txtValue').value;
        var Type = obj.options[obj.selectedIndex].text;
        var ShowIn = '';
        if (document.getElementById('chkReg').checked == true) {
            ShowIn = 'Reg';
        }
        if (document.getElementById('chkInvoice').checked == true) {
            ShowIn = ShowIn + ',' + 'Invoice';
        }
        if (document.getElementById('chkReceipt').checked == true) {
            ShowIn = ShowIn + ',' + 'Receipt';
        }
        var rwNumber = 1;

        document.getElementById('hdnClientAttributes').value += Attributes + "~" + Type + "~" + Value + "~" + ShowIn + "^";

        GenerateEpisodeAttributesTable();
        clearEpisodeAttributes();
        //showResponses('Div1', 'Div2', 'divLocation', 0)
    }
}

function GenerateEpisodeAttributesTable() {

    //document.getElementById('btnAdd').value = "AddMore";
    while (count = document.getElementById('tblClientAttributes').rows.length) {
        for (var j = 0; j < document.getElementById('tblClientAttributes').rows.length; j++) {
            document.getElementById('tblClientAttributes').deleteRow(j);
        }
    }
    var pList = document.getElementById('hdnClientAttributes').value.split("^");
    if (pList != "") {
        //document.getElementById('divaddressdetails').style.display = "block";
        var Headrow = document.getElementById('tblClientAttributes').insertRow(0);
        Headrow.id = "HeadID";
        var id = 0;
        Headrow.style.fontWeight = "bold";
        Headrow.className = "dataheader1"

        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);
        var cell5 = Headrow.insertCell(4);
        var cell6 = Headrow.insertCell(5);


        cell1.innerHTML = "S.No.";
        cell2.innerHTML = "Attributes";
        cell3.innerHTML = "Type";
        cell4.innerHTML = "Value";
        cell5.innerHTML = "ShowIn";
        cell6.innerHTML = "Action";

        for (s = 0; s < pList.length; s++) {
            if (pList[s] != "") {
                y = pList[s].split('~');
                var row = document.getElementById('tblClientAttributes').insertRow(1);
                row.style.height = "10px";
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);

                cell1.innerHTML = pList.length == 1 ? pList.length : pList.length - s - 1;
                cell2.innerHTML = y[0];
                cell3.innerHTML = y[1];
                cell4.innerHTML = y[2];
                cell5.innerHTML = y[3];



                cell6.innerHTML = "<input id='edit1' name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] +
                                                                "' onclick='btnDeletetblClientAttri(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  />"

            }
        }
    }
}

function btnDeletetblClientAttri(sEditedData) {
    var i;
    var IsDelete = confirm("Confirm to delete!!");
    if (IsDelete == true) {
        var x = document.getElementById('hdnClientAttributes').value.split("^");
        document.getElementById('hdnClientAttributes').value = '';
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                if (x[i] != sEditedData) {
                    document.getElementById('hdnClientAttributes').value += x[i] + "^";
                }
            }
        }
        GenerateEpisodeAttributesTable();
    }
    else {
        return false;
    }
}

//part 5

function checkKitDetails() {
    if (document.getElementById('hdnKitID').value == "") {
        document.getElementById('txtKitName').focus();
        document.getElementById('txtKitName').value = "";
        alert('Enter the Kit Name');
        return false;
    }
    if (document.getElementById('txtKitName').value == "") {
        document.getElementById('txtKitName').focus();
        alert('Enter the Kit Name');
        return false;
    }
    if (document.getElementById('txtNoOfKit').value == "") {
        document.getElementById('txtNoOfKit').focus();
        alert('Enter the Number of Kit');
        return false;
    }
    return true;
}
function clearKitDetails() {
    document.getElementById('txtKitName').value = "";
    document.getElementById('txtNoOfKit').value = "1";
    document.getElementById('hdnKitID').value = "";
}
function AddKitDetails() {
    if (checkKitDetails()) {
        var KitName = document.getElementById('txtKitName').value;
        var Value = document.getElementById('txtNoOfKit').value;
        var KitID = document.getElementById('hdnKitID').value;

        if (!IsKitAlreadyAdded(KitID)) {
            clearKitDetails();
            document.getElementById('txtKitName').focus();
            return false;
        }
        else {
            //var ProductVisitMapID = document.getElementById('hdnProductVisitMapID').value == "" ? -1 : document.getElementById('hdnProductVisitMapID').value;

            document.getElementById('hdnKitDetails').value += KitID + "~" + KitName + "~" + Value + "~" + "-1" + "^";
            document.getElementById('hdnKitTempTable1').value += KitID + "~" + KitName + "~" + Value + "~" + "-1" + "@";
            document.getElementById('hdnKitTempTable2').value += KitName + " : " + Value + " (Nos) " + " <br> ";
            GenerateKitDetailTable();
            clearKitDetails();
        }
        //showResponses('Div1', 'Div2', 'divLocation', 0)
    }
}

function GenerateKitDetailTable() {

    //document.getElementById('btnAdd').value = "AddMore";
    while (count = document.getElementById('tdKitTable').rows.length) {
        for (var j = 0; j < document.getElementById('tdKitTable').rows.length; j++) {
            document.getElementById('tdKitTable').deleteRow(j);
        }
    }
    var pList = document.getElementById('hdnKitDetails').value.split("^");
    if (pList != "") {
        //document.getElementById('divaddressdetails').style.display = "block";
        var Headrow = document.getElementById('tdKitTable').insertRow(0);
        Headrow.id = "HeadID";
        var id = 0;
        Headrow.style.fontWeight = "bold";
        Headrow.className = "dataheader1"

        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);

        cell1.innerHTML = "S.No.";
        cell2.innerHTML = "Kit Name";
        cell3.innerHTML = "Value(No of Kit)";
        cell4.innerHTML = "Action";

        for (s = 0; s < pList.length; s++) {
            if (pList[s] != "") {
                y = pList[s].split('~');
                var row = document.getElementById('tdKitTable').insertRow(1);
                row.style.height = "10px";
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);

                cell1.innerHTML = pList.length == 1 ? pList.length : pList.length - s - 1;
                cell2.innerHTML = y[1];
                cell3.innerHTML = y[2];


                cell4.innerHTML = "<input id='edit1' name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] +
                                                                "' onclick='btnDeletKitTablee(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  />"

            }
        }
    }

}

function btnDeletKitTablee(sEditedData) {
    var i;
    var IsDelete = confirm("Confirm to delete!!");
    if (IsDelete == true) {
        var x = document.getElementById('hdnKitDetails').value.split("^");
        var y = document.getElementById('hdnKitTempTable1').value.split("@");
        var z = document.getElementById('hdnKitTempTable2').value.split("<br>");
        document.getElementById('hdnKitDetails').value = '';
        document.getElementById('hdnKitTempTable1').value = '';
        document.getElementById('hdnKitTempTable2').value = '';
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                if (x[i] != sEditedData) {
                    document.getElementById('hdnKitDetails').value += x[i] + "^";
                    document.getElementById('hdnKitTempTable1').value += y[i] + "@";
                    document.getElementById('hdnKitTempTable2').value += z[i] + "<br>";
                }
            }
        }
        GenerateKitDetailTable();
    }
    else {
        return false;
    }
}

//part 6


function CreateChildClientList(IsFromTable) {
    var ChildClientList = document.getElementById('hdnChildClientList').value;
    if (ChildClientList != "") {
        CreateChildClientListTable(ChildClientList, IsFromTable);
    }
    else {
        document.getElementById('gNadvTable').innerHTML = "";
        document.getElementById('txtSiteCount').value = "0";
    }
}
function CreateChildClientListTable(ChildClientList, IsFromTable) {

    document.getElementById('gNadvTable').innerHTML = "";
    var NganewTable, NgastartTag, NgaendTag;

    NgastartTag = "<TABLE ID='tabNadv1' Cellpadding='1' Cellspacing='1' Border='1' style='BackgroundColor:#ff6600;' ><TBODY><tr><td > Select </td><td style='width:300px;'> Description </td> </tr>";
    NgaendTag = "</TBODY></TABLE>";
    NganewTable = NgastartTag;

    var ChildClientListing = ChildClientList.split("###");
    var NganewTable = '';
    var tblStatr;
    var tblBoody;
    var tblEnd;
    var tblResult;
    if (ChildClientListing.length > 0) {
        for (var i = 0; i < ChildClientListing.length - 1; i++) {
            var UniChild = ChildClientListing[i].split("~");
            var ID = "ChildLBL_" + UniChild[0] + "_" + UniChild[1];
            NganewTable += "<TR><TD><input name='" + ID + "' onclick='NgachkUnCheck(name);'  type='checkbox' checked='checked' disabled='disabled'  /> </TD><TD style=\"WIDTH: 120px\" >" + UniChild[1] + "</TD> </TR>";
        }
        if (IsFromTable == 'N') {
            document.getElementById('txtSiteCount').value = ChildClientListing.length - 1;
            document.getElementById('hdnTotalNoOfSites').value = ChildClientListing.length - 1;
        }
    }
    NganewTable += NgaendTag;
    document.getElementById('gNadvTable').innerHTML += NganewTable;
    document.getElementById('tdChildClient').style.display = "block";

}

function NgachkUnCheck(NgaDataValue) {
    var obj = document.getElementById(NgaDataValue);
    if (document.getElementById(NgaDataValue).checked == true) {
        var ID = NgaDataValue.split('_');
        document.getElementById('hdnChildClientID').value += ID[1] + "~" + ID[2] + "^";
    }
    else {
        var ID = NgaDataValue.split('_');
        var x = document.getElementById('hdnChildClientID').value.split("^");
        document.getElementById('hdnChildClientIDDummy').value = '';
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                var Val = x[i].split("~")
                {
                    if (Val[0] != ID[1]) {
                        document.getElementById('hdnChildClientIDDummy').value += Val[1] + "~" + Val[2] + "^";
                    }
                }
            }
        }
        document.getElementById('hdnChildClientID').value = document.getElementById('hdnChildClientIDDummy').value;
    }

}
function ChildClientCheck() {
    var CheckedValues = document.getElementById('tempChkChildIDs').value
    var x = CheckedValues.split("^");
    for (var i = 0; i < x.length; i++) {
        if (x[i] != "") {
            var ID = "ChildLBL_" + x[i];
            document.getElementById(ID).checked = true;
            document.getElementById('hdnChildClientID').value += x[0] + "~" + x[1] + "^";
        }
    }
}
function CreateChildClientListTableFromPast() {

    var ChildClientList = document.getElementById('hdnChildClientList').value;
    if (ChildClientList != "") {


        document.getElementById('gNadvTable').innerHTML = "";
        var NganewTable, NgastartTag, NgaendTag;

        NgastartTag = "<TABLE ID='tabNadv1' Cellpadding='1' Cellspacing='1' Border='1' style='BackgroundColor:#ff6600;' ><TBODY><tr><td > Select </td><td style='width:300px;'> Description </td> </tr>";
        NgaendTag = "</TBODY></TABLE>";
        NganewTable = NgastartTag;

        var ChildClientListing = ChildClientList.split("###");
        var NganewTable = '';
        var tblStatr;
        var tblBoody;
        var tblEnd;
        var tblResult;
        if (ChildClientListing.length > 0) {
            for (var i = 0; i < ChildClientListing.length - 1; i++) {
                var UniChild = ChildClientListing[i].split("~");

                var CheckedValues = document.getElementById('tempChkChildIDs').value;
                var x = CheckedValues.split("^");
                var IsCheck = 0;
                for (var j = 0; j < x.length; j++) {
                    if (x[j] != "") {
                        if (UniChild[0] == x[j]) {
                            IsCheck = 1;
                        }
                    }
                }
                if (IsCheck == "1") {
                    var ID = "ChildLBL_" + UniChild[0] + "_" + UniChild[1];
                    var ID = "ChildLBL_" + UniChild[0] + "_" + UniChild[1];
                    NganewTable += "<TR><TD><input name='" + ID + "' onclick='NgachkUnCheck(name);'  type='checkbox' checked='true' /> </TD><TD style=\"WIDTH: 120px\" >" + UniChild[1] + "</TD> </TR>";
                    document.getElementById('hdnChildClientID').value += UniChild[0] + "~" + UniChild[1] + "^";
                }
                else {
                    var ID = "ChildLBL_" + UniChild[0] + "_" + UniChild[1];
                    var ID = "ChildLBL_" + UniChild[0] + "_" + UniChild[1];
                    NganewTable += "<TR><TD><input name='" + ID + "' onclick='NgachkUnCheck(name);'  type='checkbox' /> </TD><TD style=\"WIDTH: 120px\" >" + UniChild[1] + "</TD> </TR>";
                }

            }
        }
        NganewTable += NgaendTag;
        document.getElementById('gNadvTable').innerHTML += NganewTable;
        document.getElementById('tdChildClient').style.display = "block";
    }
}

//part 7

function checkSiteDetails() {
    if (document.getElementById('hdnSIteID').value == "") {
        document.getElementById('txtSiteName').focus();
        document.getElementById('txtSiteName').value = "";
        alert('Enter the Site Name');
        return false;
    }
    if (document.getElementById('txtSiteName').value == "") {
        document.getElementById('txtSiteName').focus();
        alert('Enter the Site Name');
        return false;
    }
    if (document.getElementById('txtSitePatientNo').value == "" || document.getElementById('txtSitePatientNo').value == "0") {
        document.getElementById('txtSitePatientNo').focus();
        alert('Enter the Number Subjects to be Performed in Particular Site');
        return false;
    }
    return true;
}
function clearSiteDetails() {
    document.getElementById('txtSiteName').value = "";
    document.getElementById('txtSitePatientNo').value = "0";
    document.getElementById('hdnSIteID').value = "";
}
function AddSiteDetails() {
    if (checkSiteDetails()) {
        var SiteName = document.getElementById('txtSiteName').value;
        var Value = document.getElementById('txtSitePatientNo').value;
        var SiteID = document.getElementById('hdnSIteID').value;
        Value = Value == "" ? 0 : Number(Value);


        if (!IsSiteAlreadyAdded(SiteID)) {
            clearSiteDetails();
            document.getElementById('txtSiteName').focus();
            return false;
        }
        else {
            if (!SiteWiseSubjectValidation()) {
                return false;
            }
            else { 
            
                // var SiteVisitMapID = document.getElementById('hdnSiteVisitMapID').value == "" ? -1 : document.getElementById('hdnSiteVisitMapID').value;

                document.getElementById('hdnSiteDetails').value += SiteID + "~" + SiteName + "~" + Value + "~" + "-1" + "^";
                document.getElementById('hdnSiteTempTable1').value += SiteID + "~" + SiteName + "~" + Value + "~" + "-1" + "@";
                document.getElementById('hdnSiteTempTable2').value += SiteName + " : " + Value + " Subjects(Nos) " + " <br> ";
                GenerateSiteDetailTable();
                clearSiteDetails();
            }
        }
        //showResponses('Div1', 'Div2', 'divLocation', 0)
    }
}

function GenerateSiteDetailTable() {

    //document.getElementById('btnAdd').value = "AddMore";
    while (count = document.getElementById('tdSiteTable').rows.length) {
        for (var j = 0; j < document.getElementById('tdSiteTable').rows.length; j++) {
            document.getElementById('tdSiteTable').deleteRow(j);
        }
    }
    var pList = document.getElementById('hdnSiteDetails').value.split("^");
    if (pList != "") {
        //document.getElementById('divaddressdetails').style.display = "block";
        var Headrow = document.getElementById('tdSiteTable').insertRow(0);
        Headrow.id = "HeadID";
        var id = 0;
        Headrow.style.fontWeight = "bold";
        Headrow.className = "dataheader1"

        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);

        cell1.innerHTML = "S.No.";
        cell2.innerHTML = "Site Name";
        cell3.innerHTML = "Value(No of Subjects)";
        cell4.innerHTML = "Action";

        for (s = 0; s < pList.length; s++) {
            if (pList[s] != "") {
                y = pList[s].split('~');
                var row = document.getElementById('tdSiteTable').insertRow(1);
                row.style.height = "10px";
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);

                cell1.innerHTML = pList.length == 1 ? pList.length : pList.length - s - 1;
                cell2.innerHTML = y[1];
                cell3.innerHTML = y[2];


                cell4.innerHTML = "<input id='edit1' name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] +
                                                                "' onclick='btnDeletSiteTablee(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  />"

            }
        }
    }

}

function btnDeletSiteTablee(sEditedData) {
    var i;
    var IsDelete = confirm("Confirm to delete!!");
    if (IsDelete == true) {
        var x = document.getElementById('hdnSiteDetails').value.split("^");
        var y = document.getElementById('hdnSiteTempTable1').value.split("@");
        var z = document.getElementById('hdnSiteTempTable2').value.split("<br>");
        document.getElementById('hdnSiteDetails').value = '';
        document.getElementById('hdnSiteTempTable1').value = '';
        document.getElementById('hdnSiteTempTable2').value = '';
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                if (x[i] != sEditedData) {
                    document.getElementById('hdnSiteDetails').value += x[i] + "^";
                    document.getElementById('hdnSiteTempTable1').value += y[i] + "@";
                    document.getElementById('hdnSiteTempTable2').value += z[i] + "<br>";
                }
            }
        }
        GenerateSiteDetailTable();
    }
    else {
        return false;
    }
}

//part 8
function SetSiteSubjectAllocation(id) {
    var obj = document.getElementById(id);
    document.getElementById('hdnSetSiteSubjectAllocation').value = document.getElementById('ddlSiteWiseSubject').value;
    if (document.getElementById('ddlSiteWiseSubject').value == '2') {
        document.getElementById('tdSite').style.display = 'block';
        return true;
    }
    else {
        document.getElementById('tdSite').style.display = 'none';
        return true;
    }
   
}
function SetVisitSubjectAllocation(id) {
    var obj = document.getElementById(id);
    document.getElementById('hdnVisitWiseSubject').value = document.getElementById('ddlVisitWiseSubject').value;
    if (document.getElementById('ddlVisitWiseSubject').value == '2') {
        document.getElementById('tdSite').style.display = 'block';
        return true;
    }
    else {
        document.getElementById('tdSite').style.display = 'none';
        return true;
    }
   
}

//Common Validation
function CheckSiteCount(id) {
    var txtSiteCount = document.getElementById('txtSiteCount').value;
    var ActualSiteCount = document.getElementById('hdnTotalNoOfSites').value;
    if (txtSiteCount != "") {
        if (Number(txtSiteCount) < Number(ActualSiteCount)) {
            alert("Number Of Sites which you Given is Less than Actual Number of Sites, kindly Give Equal or More Number of Sites!");
            document.getElementById('txtSiteCount').value = "";
            document.getElementById('txtSiteCount').focus();
            return false;
        }
    }
    return true;
}

function IsKitAlreadyAdded(KitID) {
    if (document.getElementById('hdnKitDetails').value != "") {
        var pList = document.getElementById('hdnKitDetails').value.split("^");
        if (pList != "") {
            var CompareID = KitID;
            for (s = 0; s < pList.length; s++) {
                if (pList[s] != "") {
                    y = pList[s].split('~');
                    if (CompareID == Number(y[0])) {
                        alert("This Kit is Already Added");
                        return false
                    }
                }
            } 
        }
    }
    return true;
}
function IsSiteAlreadyAdded(SiteID) {
    if (document.getElementById('hdnSiteDetails').value != "") {
        var pList = document.getElementById('hdnSiteDetails').value.split("^");
        if (pList != "") {
            var CompareID = SiteID;
            for (s = 0; s < pList.length; s++) {
                if (pList[s] != "") {
                    y = pList[s].split('~');
                    if (CompareID == Number(y[0])) {
                        alert("This Site is Already Added");
                        return false
                    }
                }
            }
        }
    }
    return true;
}
function ValidateSubjectCount(ID) {
    var TotalMonitoringSubjects = Number(document.getElementById('txtNoOfPatient').value);
    var UndefinedScreening = document.getElementById('chkUndefinedScreening').checked;
    if (!UndefinedScreening) {
        var TotalScreenSubjects = Number(document.getElementById('txtscrSubjects').value);
        if (TotalMonitoringSubjects > TotalScreenSubjects) {
            alert("Screening subjects should be greater than monitoring subjects");
            document.getElementById(ID).value = "";
            document.getElementById(ID).focus();
            return false;
        }
    }
    else {
        if (!confirm('The No.of Screening Subject is Undefined, Are you Sure to procced?')) {
            document.getElementById('chkUndefinedScreening').focus();
            return false;
        }
    }
    
    return true;
} 
function expandTextBox(id) {
    document.getElementById(id).rows = "5";
    document.getElementById(id).cols = "20";
    ConverttoUpperCase(id);
}
function collapseTextBox(id) {
    document.getElementById(id).rows = "1";
    document.getElementById(id).cols = "20";
    ConverttoUpperCase(id);

}
function SiteWiseSubjectValidation() {
    
    var TotalScreenSubjects = '';
    var Value = document.getElementById('txtSitePatientNo').value;
    if (document.getElementById('ddlVisitType').value == '1') {
        var UndefinedScreening = document.getElementById('chkUndefinedScreening').checked;
        if (!UndefinedScreening) {
            TotalScreenSubjects = document.getElementById('txtscrSubjects').value;
            if (TotalScreenSubjects == "") {
                TotalScreenSubjects = 0;
            }
            TotalNoSubjects = Number(TotalScreenSubjects);
            if (document.getElementById('hdnSiteDetails').value != "") {
                var pList = document.getElementById('hdnSiteDetails').value.split("^");
                if (pList != "") {
                    var Count = 0;
                    for (s = 0; s < pList.length; s++) {
                        if (pList[s] != "") {
                            y = pList[s].split('~');
                            Count += Number(y[2]);
                        }
                    }
                    Count += Number(Value);
                    if (Count > TotalNoSubjects) {
                        alert("Site wise Subject Alloction Should not More than Number of  Screening Subjects");
                        document.getElementById('txtSitePatientNo').focus();
                        return false;
                    }
                }
            }
            else {
                if (Value > TotalNoSubjects) {
                    alert("Site wise Subject Alloction Should not More than Number of  Screening Subjects");
                    document.getElementById('txtSitePatientNo').focus();
                    return false;
                }
            }
            return true;
        }
    }
    else {
        var TotalNoSubjects = '';
        TotalNoSubjects = document.getElementById('txtNoOfPatient').value;
        if (TotalNoSubjects == "") {
            TotalNoSubjects = 0;
        }
        TotalNoSubjects = Number(TotalNoSubjects);

        if (document.getElementById('hdnSiteDetails').value != "") {
            var pList = document.getElementById('hdnSiteDetails').value.split("^");
            if (pList != "") {
                var Count = 0;
                for (s = 0; s < pList.length; s++) {
                    if (pList[s] != "") {
                        y = pList[s].split('~');
                        Count += Number(y[2]);
                    }
                }
                Count += Number(Value);
                if (Count > TotalNoSubjects) {
                    alert("Site wise Subject Alloction Should not More than Number of  Monitoring Subjects");
                    document.getElementById('txtSitePatientNo').focus();
                    return false;
                }
            }
        }
        else {
            if (Value > TotalNoSubjects) {
                alert("Site wise Subject Alloction Should not More than Number of  Monitoring Subjects");
                document.getElementById('txtSitePatientNo').focus();
                return false;
            }
        }
        return true;
    }

    return true;
}

function ScreeningUndefined() {
    if (document.getElementById('chkUndefinedScreening').checked) {
      document.getElementById('txtscrSubjects').value = "∞"; 
      document.getElementById('txtscrSubjects').disabled = true;
      
    }
    else {
        document.getElementById('txtscrSubjects').value = "";
        document.getElementById('txtscrSubjects').disabled = false;
    }
    
}
 
