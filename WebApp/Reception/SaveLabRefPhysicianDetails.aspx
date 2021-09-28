<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SaveLabRefPhysicianDetails.aspx.cs"
    Inherits="Reception_SaveLabRefPhysicianDetails" EnableEventValidation="false"
    ValidateRequest="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>--%>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Manage Refering Physician Details</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

 

    <script language="javascript" type="text/javascript">
        function checkSMS(id) {
            var objAlert = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert");
            var objApp01 = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_01") == null ? "Enter Phone Number " : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_01");
            if (document.getElementById('chkActive').checked == true) {
                document.getElementById('hdnsms').value = 'Y';
            }
            else {

                document.getElementById('hdnsms').value = 'N';
                return true;

            }

            if (document.getElementById('txtmobileno').value.trim() == '') {
                ValidationWindow(objApp01, objAlert);
                //alert(' Enter Phone Number ');
                return false;
            }






        }

        //surya Start
        function ConfirmResetPswd() {
            var cnfm;
            var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_27") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_27") : "Are you sure you want to Reset Password?";

            //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_31");
            if (UsrAlrtMsg != null) {
                cnfm = confirm(UsrAlrtMsg);
                //return false;
            }
            else {
                cnfm = confirm(UsrAlrtMsg);
                //return false;
            }
            //cnfm = confirm("Are you sure you want to Reset Password?");var cnfm = confirm("Are you sure you want to Reset Password?");
            if (cnfm == true) {
                document.getElementById('hdnRstPswd').value = "1";
            }
            else {
                document.getElementById('hdnRstPswd').value = "0";
            }
        }





        //surya END
        function validateLabRefPhysicianDetails() {
            var objAlert = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert");
            var objApp01 = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_02") == null ? "Provide physician name " : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_02");
            var objApp02 = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_03") == null ? "Provide Physician Code " : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_03");
            var objApp03 = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_04") == null ? "Select salutation " : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_04");
            var objApp04 = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_05") == null ? "Physician code already exists.Please give any other code" : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_05");
            if (document.getElementById('txtDrName').value.trim() == '') {
                var userMsg = SListForAppMsg.Get('Reception\\SaveLabRefPhysicianDetails.aspx_1');
                if (userMsg != null) {
                    ValidationWindow(userMsg, objAlert);
                   // alert(userMsg);
                    return false;

                }
                else {
                    ValidationWindow(objApp01, objAlert);
                
                   // alert('Provide physician name');
                    return false;
                }
                document.getElementById('txtDrName').focus();
                return false;
            }
            if (document.getElementById('txtPhysicianCode').value.trim() == '') {
                var userMsg = SListForAppMsg.Get('Reception\\SaveLabRefPhysicianDetails.aspx_9');
                if (userMsg != null) {
                    ValidationWindow(userMsg, objAlert);
                    //alert(userMsg);
                    return false;

                } else {

                ValidationWindow(objApp02, objAlert);
                    //alert('Provide Physician Code');
                    return false;

                }
                document.getElementById('txtPhysicianCode').focus();
                return false;
            }

            if (document.getElementById('ddSalutation').value == '0') {
                var userMsg = SListForAppMsg.Get('Reception\\SaveLabRefPhysicianDetails.aspx_2');
                if (userMsg != null) {
                    ValidationWindow(userMsg, objAlert);
                   // alert(userMsg);
                    return false;

                }
                else {
                    ValidationWindow(objApp03, objAlert);
                    //alert('Select salutation');
                    return false;

                }
                document.getElementById('ddSalutation').focus();
                return false;
            }
            if (document.getElementById('hdnCheckCode').value == '1') {
                var userMsg = SListForAppMsg.Get('Reception\\SaveLabRefPhysicianDetails.aspx_4');
                if (userMsg != null) {
                    ValidationWindow(userMsg, objAlert);
                    //alert(userMsg);
                    return false;

                } else {
                ValidationWindow(objApp04, objAlert);
                   //alert('Physician code already exists.Please give any other code');
                    return false;

                }
                document.getElementById('txtPhysicianCode').focus();
                return false;
            }
            //            if (document.getElementById('ddsex').options[document.getElementById('ddsex').selectedIndex].value == '0') {
            //                alert('Please select the gender');
            //                return false;
            //            }
        }

        function ValidateCode() {
            if (document.getElementById('txtPhysicianCode').disabled == false) {
                var codeType = 'REF';
                var txtValue = document.getElementById('txtPhysicianCode').value;
                WebService.GetCheckCode(codeType, txtValue, onCheckCount);
            }
        }

        function onCheckCount(Count) {
            document.getElementById('hdnCheckCode').value = Count;
        }

        function checkSearchName() {
            var objAlert = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert");
            var objApp06 = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_06") == null ? "Provide the search text to find the physician " : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_06");
            if (document.getElementById('txtSearchPhysicianName').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\SaveLabRefPhysicianDetails.aspx_5');
                if (userMsg != null) {
                    ValidationWindow(userMsg, objAlert);
                   // alert(userMsg);
                    return false;

                } else {
                ValidationWindow(objApp06, objAlert);
                    //alert('Provide the search text to find the physician');
                    return false;

                }
                document.getElementById('txtSearchPhysicianName').focus();
                return false;
            }
        }

        function HideDiv() {
            document.getElementById('TabNew').style.visibility = 'visible';
        }
        var total = '';

        function onClick1(id) {

            var type;
            var rate = '';
            var obj = document.getElementById(id);
            var i = obj.getElementsByTagName('OPTION');

            var AddStatus = 0;
            var obj = document.getElementById(id);
            var i = obj.getElementsByTagName('OPTION');
            if (id == document.getElementById('chklstHsptl').getAttribute('id')) {
                type = 'GRP';
            }


            document.getElementById('iconHid').value = document.getElementById('iconHid').value == "" ? document.getElementById('HdnHospitalID').value : document.getElementById('iconHid').value;

            var HidValue = document.getElementById('iconHid').value;
            var list = HidValue.split('|');

            if (document.getElementById('iconHid').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {

                        if (obj.selectedIndex >= 0) {
                            if (InvesList[0] == obj.options[obj.selectedIndex].value) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {
                document.getElementById('lblHeader').style.display = "block";
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                //var cell4 = row.insertCell(3);

                cell1.innerHTML = "<img id='" + obj.options[obj.selectedIndex].value + "' style='cursor:pointer;' OnClick='ImgOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                cell3.innerHTML = obj.options[obj.selectedIndex].value;
                cell3.style.display = "none";
                //cell4.innerHTML = addPhyFeeList(obj.options[obj.selectedIndex].value);
                //cell4.width = "30%";
                document.getElementById('iconHid').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "|";
                //rate = obj.options[obj.selectedIndex].text.split(':');
                //total = parseFloat(rate[1]);
                //alert('total:' + parseFloat(total).toFixed(2));

                AddStatus = 2;
                //document.getElementById('tblTot').style.display = "block";

            }
            if (AddStatus == 0) {
                document.getElementById('lblHeader').style.display = 'block';
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                //var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                cell2.width = "300Px";
                cell3.innerHTML = obj.options[obj.selectedIndex].value;
                cell3.style.display = "none";
                //cell4.innerHTML = addPhyFeeList(obj.options[obj.selectedIndex].value);
                //cell4.width = "30%";
                document.getElementById('iconHid').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "|";
                //rate = obj.options[obj.selectedIndex].text.split(':');
                //alert('rae:' + rate[1]);
                //total = parseFloat(total) + parseFloat(rate[1]);

            }
            else if (AddStatus == 1) {
            var objAlert = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert");
            var objApp07 = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_07") == null ? "Hospital already added " : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_07");
                var userMsg = SListForApplicationMessages.Get('Reception\\SaveLabRefPhysicianDetails.aspx_6');
                if (userMsg != null) {
                    ValidationWindow(userMsg, objAlert);
                  //  alert(userMsg);


                } else {
                ValidationWindow(objApp07, objAlert);
                    //alert('Hospital already added');


                }
            }
            return false;
        }
        function setItem(e, ctl) {

            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClick1(ctl.id);
            }
            else if (key == 0) {
                document.getElementById(ctl).focus();
            }
        }
        function SetId(ID) {

            if (ID != document.getElementById('hidID').value) {
                MyUtil.selectFilter(document.getElementById('hidID').value, '');
                alert(ID);
                document.getElementById('hidID').value = ID;

                // document.getElementById('txtBX').value = '';
                //document.getElementById('txtBX').focus();
            }

            return false;
        }
        MyUtil = new Object();
        MyUtil.selectFilterData = new Object();
        MyUtil.selectFilter = function(selectId, filter) {
            selectId = document.getElementById('hidID').value;
            var list = document.getElementById(selectId);
            if (!MyUtil.selectFilterData[selectId]) { //if we don't have a list of all the options, cache them now'
                MyUtil.selectFilterData[selectId] = new Array();
                for (var i = 0; i < list.options.length; i++) MyUtil.selectFilterData[selectId][i] = list.options[i];
            }
            list.options.length = 0;   //remove all elements from the list
            for (var i = 0; i < MyUtil.selectFilterData[selectId].length; i++) { //add elements from cache if they match filter
                var o = MyUtil.selectFilterData[selectId][i];
                if (o.text.toLowerCase().indexOf(filter.toLowerCase()) >= 0) {
                    if (navigator.appName == "Microsoft Internet Explorer") {
                        //alert("hai");
                        list.add(o);
                    }
                    else {
                        //alert("httt");
                        list.add(o, null);

                    }
                }
            }
        }
        function addPhyFeeList(invID) {
            var HdnLPF = document.getElementById('HdnLPF').value;
            var LPFlist = HdnLPF.split('^');

            if (document.getElementById('HdnLPF').value != "") {

                for (var count = 0; count < LPFlist.length; count++) {
                    var FeeList = LPFlist[count].split('~');
                    if (FeeList[0] == invID) {
                        return FeeList[2];
                    }
                }
                return "---";
            }
            else {
                return "---";
            }
        }
        function ImgOnclick(ImgID) {

            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('iconHid').value != "" ? document.getElementById('iconHid').value : document.getElementById('HdnHospitalID').value;
            var list = HidValue.split('|');
            var minusamt;
            var newInvList = '';
            if (document.getElementById('iconHid').value != "" || document.getElementById('HdnHospitalID').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (InvesList[0] != ImgID) {
                            newInvList += list[count] + '|';
                        }
                    }
                }
                document.getElementById('iconHid').value = newInvList;
                document.getElementById('HdnHospitalID').value = newInvList;
            }
        }
        function GetGender(obj) {
        
        var selectedOption = obj.options[obj.selectedIndex];
        var selText = selectedOption.text;        
        document.getElementById('hdnGender').value = selText;
           // document.getElementById('hdnGender').value = document.getElementById('ddsex').options[document.getElementById('ddsex').selectedIndex].text;
        }
        function checkAll(obj1) {
            var checkboxCollection = document.getElementById('chkCategory').getElementsByTagName('input');

            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
            }
        }
        function countQuickAge(id) {
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
                            document.getElementById('txtDOBNos').value = agetemp;
                            document.getElementById('ddlDOBDWMY').value = 'Year(s)';
                        }
                        else {
                            document.getElementById('txtDOBNos').value = agetemp;
                            document.getElementById('ddlDOBDWMY').value = 'Year(s)';
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
                    document.getElementById('tDOB').value = "dd//MM//yyyy";
                    document.getElementById('tDOB').value = "dd//MM//yyyy";
                    document.getElementById('tDOB').focus();
                }
            }
        }

        function getDOB() {
            if (document.getElementById('txtDOBNos').value == '') {
                var objAlert = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert");
                var objApp08 = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_08") == null ? "Provide Age in (Days or Weeks or Months or Year) & choose appropriate from the list " : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_08");
                var userMsg = SListForApplicationMessages.Get('Reception\\SaveLabRefPhysicianDetails.aspx_8');
                if (userMsg != null) {
                    ValidationWindow(userMsg, objAlert);
                   // alert(userMsg);
                    return false;

                } else {
                ValidationWindow(objApp08, objAlert);
                   // alert('Provide Age in (Days or Weeks or Months or Year) & choose appropriate from the list');
                    return false;

                }
                document.getElementById('txtDOBNos').focus();
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
            if (key == 8 || isCtrl) {
                return true;
            }

            reg = /\d/;
            var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
            var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

            return isFirstN || isFirstD || reg.test(keychar);
        }

     
    </script>

    <style type="text/css">
        .style2
        {
            width: 50%;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnFinish">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>

    <script language="javascript" type="text/javascript">
        function GetOrgName() {
            //WebService.GetReferingHospital(, RoomTypename, OnRequestComplete, OnWSRequestFiled);
            //document.getElementById('txtDrName').value = "";
            return false;
        }
        function OnRequestComplete(arg) {
            if (arg.length != 0) {

                alert(document.getElementById('txtDrName').value + " Already Exists.");

                return false;
            }
        }
        function OnTimeOut(arg) {
            var objAlert = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert");
            var objApp09 = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_09") == null ? "Timeout has occured " : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_09");
           
            var userMsg = SListForApplicationMessages.Get('Reception\\SaveLabRefPhysicianDetails.aspx_10');
            if (userMsg != null) {
                ValidationWindow(userMsg, objAlert);
                //alert(userMsg);
                return false;

            } else {
            ValidationWindow(objApp09, objAlert);
                //alert('Timeout has occured');
                return false;
            }
        }

        function OnWSRequestFailed(arg) {
            var objAlert = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert");
            var objApp10 = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_10") == null ? "Error has occured: " : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_10");
            var userMsg = SListForApplicationMessages.Get('Reception\\SaveLabRefPhysicianDetails.aspx_11');
            if (userMsg != null) {
                ValidationWindow(userMsg, objAlert);
                //alert(userMsg);
                return false;

            } else {
            ValidationWindow(objApp09, objAlert);
                //alert('Error has occured: ');
                return false;
            }
        }
        function ShowLogin(ctl) {
            if (ctl.checked == true) {
                document.getElementById("Login").style.display = "block";
                var DrName = document.getElementById("txtDrName").value;
                var Temp = DrName.split(' ');
                document.getElementById("txtUserName").value = Temp[0];
            }
            else {
                document.getElementById("Login").style.display = "none";
                document.getElementById("txtUserName").value = "";
            }


        }
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
        function SetStateID() {
            document.getElementById('drpState').value = document.getElementById('hdnStateID').value;
        }
        function onchangeState() {
            $('#hdnStateID').val(document.getElementById('drpState').value);
        }
        function isNumeric(e, Id) {
            var key; var isCtrl; var flag = 0;
            var txtVal = document.getElementById(Id).value.trim();
            var len = txtVal.split('.');
            if (len.length > 0) {
                flag = 1;
            }
            if (window.event) {
                key = window.event.keyCode;
                if (window.event.shiftKey) {
                    isCtrl = true;
                }
                else {
                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 188) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                        isCtrl = true;
                    }
                    else {
                        isCtrl = false;
                    }
                }
            } return isCtrl;
        }
        function LimitTextValidation(limitField) {
            var countrycode = document.getElementById("lblCountryCode").innerHTML;
            if (countrycode == "+86") {
                limitField.value = limitField.value.substring(0, 13);
                return true;
            }
            else if (countrycode == "+91") {
                limitField.value = limitField.value.substring(0, 10);
                return true;
            }
            else {
                return false;
            }
        }
        function ClearDOB() {
            var objAlert = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_Alert");
            var objApp11 = SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_11") == null ? "Provide a valid year " : SListForAppMsg.Get("Reception_SaveLabRefPhysicianDetails_aspx_11");
            if (document.getElementById('txtDOBNos').value <= 0) {
                document.getElementById('txtDOBNos').value = '';
            }
            if (document.getElementById('txtDOBNos').value >= 150) {
                var userMsg = SListForApplicationMessages.Get('Reception\\SaveLabRefPhysicianDetails.aspx_12');
                if (userMsg != null) {
                    ValidationWindow(userMsg, objAlert);
                    //alert(userMsg);
                    return false;

                } else {
                ValidationWindow(objApp11, objAlert);
                    //alert('Provide a valid year');
                    return false;

                }
                document.getElementById('tDOB').value = "dd//MM//yyyy";
                document.getElementById('txtDOBNos').value = '';
                document.getElementById('txtDOBNos').focus();
                return false;
            }
        }
        function SetContextKey() {
            var deptName = document.getElementById('drplstPerson').options[document.getElementById('drplstPerson').selectedIndex].text;
            var deptCode = document.getElementById('drplstPerson').options[document.getElementById('drplstPerson').selectedIndex].value;
            var depart = document.getElementById('hdnAddDepart').value.split('^');
            var flag = 0;
            for (var i = 0; i < depart.length; i++) {
                if (depart[i] != "") {
                    if (deptCode == depart[i].split('~')[1]) {
                        flag = 1;
                        break;
                    }
                }
            }
            if (flag == 1) {
                document.getElementById('hdnEmpID').value = "-1";
                document.getElementById('tdtxtClnt').style.display = "table-cell";
                document.getElementById('tdtxtPrsn').style.display = "none";
            }
            else {

                $find('AutoCompleteExtender3').set_contextKey(deptCode);
            }
            return;
        }

        function GetEmpID(source, eventArgs) {
            var strVal = eventArgs.get_value();
            document.getElementById('txtPersonName').value = eventArgs.get_text();
            document.getElementById('hdnEmpID').value = strVal.split('~')[0].trim();
            document.getElementById('txtPrsnMobile').value = strVal.split('~')[1].trim();
            document.getElementById('txtPrsnLandNo').value = strVal.split('~')[2].trim();
            document.getElementById('txtPrsnEmail').value = strVal.split('~')[3].trim();
        }
        function setDOBYearRef(id, PageType) {
            var DecimalConfig;
            var AlrtWinHdr = SListForAppMsg.Get("Scripts_datetimepicker_js_02") != null ? SListForAppMsg.Get("Scripts_datetimepicker_js_02") : "Information";
            var UsrAlrtMsg = SListForAppMsg.Get("Scripts_Common_js_08") != null ? SListForAppMsg.Get("Scripts_Common_js_08") : "Age cannot be zero";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Scripts_Common_js_09") != null ? SListForAppMsg.Get("Scripts_Common_js_09") : "Age Should be Number";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Scripts_Common_js_10") != null ? SListForAppMsg.Get("Scripts_Common_js_10") : "Should not be Decimal Values";


            if (PageType == 'CB') {
                if (document.getElementById(id).value == '0') {
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    //alert("Age cannot be zero");
                    document.getElementById(id).value = '';
                    document.getElementById(id).focus();
                }
                else if (document.getElementById(id).value != '') {
                    if (document.getElementById(id).value == '.') {
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                        //alert("Age Should be Number");
                        document.getElementById(id).value = '';
                        document.getElementById(id).focus();
                    }
                    else if (Number(document.getElementById(id).value) == '0') {
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                        //alert("Age cannot be zero");
                        document.getElementById(id).value = '';
                        document.getElementById(id).focus();
                    }
                }
                document.getElementById('tDOB').value = ''
                document.getElementById('tDOB').value = "dd//MM//yyyy";
                document.getElementById('ddlDOBDWMY').value = 'Year(s)';
                if (document.getElementById('chkIncomplete').checked == true && document.getElementById(id).value == '') {

                    document.getElementById('ddlDOBDWMY').value = 'UnKnown';
                }
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
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    //alert("Age Should be Number");
                    document.getElementById(id).value = '';
                    document.getElementById(id).focus();
                }
                //Added by Gowtham Raj
//                if (document.getElementById('chkIncomplete') != null) {

//                    if (document.getElementById('chkIncomplete').checked == true && document.getElementById(id).value == '') {

//                        document.getElementById('ddlDOBDWMY').value = 'UnKnown';
//                    }
//                    else if (document.getElementById('chkIncomplete').checked == true && document.getElementById(id).value != '') {
//                        document.getElementById('ddlDOBDWMY').value = 'Year(s)';
//                    }
//                }
                document.getElementById('tDOB').value = ''
                document.getElementById('tDOB').value = "dd//MM//yyyy";
                document.getElementById('ddlDOBDWMY').value = 'Year(s)';
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
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr); 
                    return false;

                }
                if (ageVal.value != '') {
                    if (ageVal.value.length <= 3 && ageVal.value < 121) {
                        if (document.getElementById('hdnDOB') != null) {
                            document.getElementById('hdnDOB').value = '';
                        }
                        var days = new Date(); 
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
                        var Cday = new Date(dobYear, gmonth, gday);
                        var Cmth = Cday.getMonth();
                        if (Cmth < 10) {
                            Cmth = '0' + Cmth;
                        } 
                        document.getElementById('tDOB').value = gday + '/' + gmonth + '/' + dobYear; 

                        if (document.getElementById('hdnDOB') != null) {
                            document.getElementById('hdnDOB').value = gday + '/' + gmonth + '/' + dobYear;
                        }

                    }
                }
            }
            setDDlDOBYear(id);
        }
        
    </script>

    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <input type="hidden" id="iconHid" style="width: 50%;" runat="server" />
                <input type="hidden" id="HidDel" style="width: 50%;" runat="server" />
                <input type="hidden" id="HdnRoleID" runat="server" />
                <input type="hidden" id="hdnUserId" runat="server" />
                <input type="hidden" id="hdnsms" runat="server" />
                <input type="hidden" id="LogID" runat="server" />
                <table class="w-100p searchPanel">
                    <tr>
                        <td class="h-32">
                            <table id="mytable1" class="w-100p">
                                <tr>
                                    <td colspan="5" id="us">
                                        <asp:Literal runat="server" ID="ltHead" Text="Search for existing Physician details or click on Add New 
                                                Physician." meta:resourcekey="ltHeadResource1"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-right" style="display: none;">
                                        &nbsp;&nbsp;<img src="../Images/starbutton.png" id="imgstar" runat="server" alt=""
                                            class="v-middle" />
                                        <asp:Label ID="Label4" Text="Type the first two characters to see the list of physicians. "
                                            runat="server" meta:resourcekey="Label4Resource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Panel ID="Panel7" CssClass="dataheader2 b-grey" BorderWidth="1px" 
                                runat="server" meta:resourcekey="Panel7Resource1">
                                <table class="w-100p bg-row">
                                    <tr>
                                        <td class="padding3">
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="a-center w-25p">
                                                        <%--Enter Physician Name--%>
                                                        <%=Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_06%>
                                                    </td>
                                                    <td class="w-35p">
                                                        <asp:TextBox ID="txtSearchPhysicianName" ToolTip="Refering Physician(Doctor) Name"
                                                            
                                                          CssClass="small" runat="server"   meta:resourcekey="txtSearchPhysicianNameResource1"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoRname" runat="server" TargetControlID="txtSearchPhysicianName"
                                                            FirstRowSelected="true" ServiceMethod="GetPhysician" ServicePath="~/WebService.asmx"
                                                            CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="2" BehaviorID="AutoCompleteEx1"
                                                            CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                                        </ajc:AutoCompleteExtender>
                                                   
                                                        <asp:Button ID="btnSearch" runat="server" ToolTip="Click here to Search Referring Physician Name"
                                                            Style="cursor: pointer;" OnClientClick="javascript:return checkSearchName();"
                                                            OnClick="btnSearch_Click" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" meta:resourcekey="btnSearchResource1" />
                                                    </td>
                                                    <td nowrap="nowrap">
                                                        <div id="ExportXL" runat="server">
                                                            <asp:Label ID="lblExport" runat="server" Text="Export To Excel" Font-Bold="True"
                                                                Font-Names="Verdana" Font-Size="9pt" meta:resourcekey="lblExportResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="ImageBtnExport" runat="server" Visible="true" ImageUrl="~/Images/ExcelImage.GIF"
                                                            meta:resourcekey="imgBtnXLResource1" OnClick="ImageBtnExport_Click" />
                                                        </div>
                                                    </td>
                                                    <td class="w-40p a-center">
                                                        <asp:LinkButton ID="addNewPhysician" ToolTip="Click here to add new Referring Physician"
                                                            Visible="true" ForeColor="#333" runat="server" OnClick="addNewPhysician_Click" 
															meta:resourcekey="addNewPhysicianResource1"><u>Add 
                                                                        new Refering Physician</u></asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr class="contentPanel">
                        <td class="paddingB10">
                            <asp:Label ID="lblStatus" Visible="false" runat="server" ForeColor="#333" Text="No Matching Records Found!"
							 meta:resourcekey="lblStatusResource1"></asp:Label>
                            <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                CellPadding="4" PageSize="10" CssClass="mytable1 gridView w-100p m-auto" ForeColor="#333333"
                                GridLines="Both" OnPageIndexChanging="grdResult_PageIndexChanging" PagerSettings-Mode="NextPrevious"
                                DataKeyNames="ReferingPhysicianID,PhysicianName,Qualification,OrganizationName,LoginName,PhysicianCode,IsClient,IsActive,Gender,Address1,City,CountryID,StateID,EmailID,Phone,
                                                Mobile,FaxNumber,DOB,Age,DiscountLimit,DiscountPeriod,DiscountValidFrom,DiscountValidTo,RefFeeCategoryid,Category,ContactPersonID,ContactPersonName,ContactPersonTypeID"
                                OnRowCommand="grdResult_RowCommand" 
                                OnRowDataBound="grdResult_RowDataBound" 
                                EmptyDataText="No matching records found.!" 
                                meta:resourcekey="grdResultResource1">
                                <PagerTemplate>
                                    <tr class="gridPager">
                                        <td class="a-center" colspan="6">
                                            <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="false" CommandArgument="Prev"
                                                CommandName="Page" CssClass="h-18 w-18" ImageUrl="~/Images/previousimage.png" 
												meta:resourcekey="lnkPrevResource1"/>
                                            <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="false" CommandArgument="Next"
                                                CommandName="Page" CssClass="h-18 w-18" ImageUrl="~/Images/nextimage.png" meta:resourcekey="lnkNextResource1" />
                                        </td>
                                    </tr>
                                </PagerTemplate>
                                <HeaderStyle CssClass="dataheader1" />
                                <RowStyle Font-Bold="false" />
                                <PagerSettings Mode="NextPrevious"></PagerSettings>
                                <Columns>
                                    <asp:BoundField DataField="ReferingPhysicianID" HeaderText="ReferingPhysicianID"
                                        Visible="false"  meta:resourcekey="BoundFieldResource1" />
                                    <asp:TemplateField Visible="false" meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:Label Visible="False" ID="lblLoginId" runat="server" 
                                                Text='<%# Eval("LoginId") %>' meta:resourcekey="lblLoginIdResource1"></asp:Label></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false" meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:Label Visible="False" ID="lblSalutation" runat="server" 
                                                Text='<%# Eval("Salutation") %>' meta:resourcekey="lblSalutationResource1"></asp:Label></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="PhysicianName" HeaderStyle-HorizontalAlign="Left" HeaderText="Physician Name"
                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource2"></asp:BoundField>
                                    <asp:BoundField DataField="Qualification" HeaderStyle-HorizontalAlign="Left" HeaderText="Qualification"
                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource3"></asp:BoundField>
                                    <asp:BoundField DataField="PhysicianCode" HeaderStyle-HorizontalAlign="Left" HeaderText="Physician Code"
                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource4" />
                                    <asp:BoundField DataField="OrganizationName" HeaderStyle-HorizontalAlign="Left" HeaderText="Ref Clinic Name"
                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource5" />
                                    <asp:TemplateField Visible="true" SortExpression="LoginName" 
                                        meta:resourcekey="TemplateFieldResource3">
                                        <HeaderTemplate>
                                            <asp:LinkButton ID="lnkLoginName" runat="server" CommandName="Sort" 
                                                CommandArgument="LoginName" meta:resourcekey="lnkLoginNameResource1">LoginName</asp:LinkButton>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblLoginName" Text='<%# Bind("LoginName") %>' runat="server" 
                                                meta:resourcekey="lblLoginNameResource1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Wrap="true" ItemStyle-Width="40%" HeaderText="Action"
                                        SortExpression="Action" meta:resourcekey="TemplateFieldResource4">
                                        <ItemTemplate>
                                            <%--  <asp:LinkButton ID="lnkAccess" Style="color: Red; text-decoration: underline;" runat="server" CommandName="Access">Access Denied</asp:LinkButton> 
                                                               &nbsp;|&nbsp;--%>
                                            <asp:LinkButton ID="lnkReset" Style="color: Red; text-decoration: underline;" runat="server"
                                                CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' 
                                                CommandName="Reset"  OnClientClick="ConfirmResetPswd();" meta:resourcekey="lnkResetResource1">Reset Password</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr class="panelFooter">
                        <td>
                            <div>
                                <input type="hidden" id="hdnReferingPhysicianID" runat="server" />
                                <input type="hidden" id="HdnLPF" value="" runat="server" />
                                <input type="hidden" id="hidID" value="" runat="server" />
                                <table class="dataheader2 searchPanel a-center w-80p" id="TabNew" runat="server"
                                    style="font-size: small;">
                                    <tr class="a-left">
                                        <td>
                                            <asp:Label ID="lblDoctorName" runat="server" Text="Doctor's Name" 
                                                meta:resourcekey="lblDoctorNameResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddSalutation" TabIndex="1" ToolTip="Select Salutation" 
                                                runat="server" meta:resourcekey="ddSalutationResource1">
                                            </asp:DropDownList>
                                            <asp:TextBox ID="txtDrName" TabIndex="2" ToolTip="Refering Physician(Doctor) Name"
                                                onchange="GetOrgName()" runat="server" CssClass="small" MaxLength="60" 
                                                meta:resourcekey="txtDrNameResource1"></asp:TextBox>
                                            &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCode" runat="server" Text="Physician Code" 
                                                meta:resourcekey="lblCodeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" ID="txtPhysicianCode" TabIndex="3" MaxLength="20" CssClass="small"
                                                onKeyUp="ValidateCode()" meta:resourcekey="txtPhysicianCodeResource1"></asp:TextBox>
                                            <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td>
                                            <asp:Label ID="lblDOB" runat="server" Text="DOB" 
                                                meta:resourcekey="lblDOBResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <%--<asp:TextBox CssClass="small datePicker" ToolTip="dd/mm/yyyy" placeholder="dd/mm/yyyy"
                                                        ID="tDOB" runat="server" onchange="javascript:CalculateAge(this);"
                                                        onblur="javascript:CalculateAge(this);" onkeypress="return RestrictInput(event)" Width="120px" Style="text-align: justify"
                                                        ValidationGroup="MKE" meta:resourceKey="tDOBResource1" />--%>
                                            <%-- <asp:TextBox  ToolTip="dd/mm/yyyy" placeholder="dd/mm/yyyy"
                                                        ID="tDOB" runat="server" Width="120px" Style="text-align: justify"
                                                         />--%>
                                            <%--surya started --%>
                                           
                                           
                                            <%--<asp:ImageButton ID="ImageBtnDOB" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="tDOB"
                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""  
                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                Enabled="True" />
                                            <ajc:MaskedEditValidator ID="MaskedEditValidator3" runat="server" ControlExtender="MaskedEditExtender1"
                                                ControlToValidate="tDOB" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1"
                                                 meta:resourcekey="MaskedEditValidator1Resource1" />
                                            <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="tDOB" 
                                                Format="dd/MM/yyyy" PopupButtonID="ImageBtnDOB" Enabled="True" />--%>
                                            <%--  Surya ENded        --%>
                                            <%-- <asp:TextBox ToolTip="dd/mm/yyyy" ID="tDOBA" CssClass="small" runat="server" TabIndex="4"
                                                onblur="javascript:countQuickAge(this.id);" Style="text-align: justify" ValidationGroup="MKE"
                                                meta:resourcekey="tDOBResource1" />--%>
                                        <%--  <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                CultureTimePlaceholder="" Enabled="True" />--%>
                                                  <asp:TextBox CssClass="small datePicker" ToolTip="dd/mm/yyyy" placeholder="dd/mm/yyyy"
                                                        ID="tDOB" runat="server" onchange="javascript:countQuickAge(this.id);"
                                                        onblur="javascript:countQuickAge(this.id);" onkeypress="return RestrictInput(event)" Width="120px" Style="text-align: justify"
                                                        ValidationGroup="MKE" meta:resourceKey="tDOBResource1" onkeydown="javascript:preventInput(event);">
                                            </asp:TextBox> 
                                          <%--  <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                                PopupButtonID="ImgBntCalc" Enabled="True" /> --%>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblAge" runat="server" Text="Age" 
                                                meta:resourcekey="lblAgeResource1"></asp:Label>
                                        </td>
                                        <td>
                                              <asp:TextBox ID="txtDOBNos" autocomplete="off" onblur="ClearDOB();" onchange="setDOBYearRef(this.id,'LB');"
                                                             onkeypress="return ValidateOnlyNumeric(this);"    CssClass="Txtboxsmall"
                                                        Width="18%" runat="server" MaxLength="6" Style="text-align: justify" meta:resourceKey="txtDOBNosResource1" />
                                                    <asp:DropDownList onChange="getDOB();setDDlDOBYear(this.id); changestatus(this.id);" ID="ddlDOBDWMY" Width="114px"
                                                        runat="server" CssClass="ddl" meta:resourcekey="ddlDOBDWMYResource1">
                                                    </asp:DropDownList>
                                           <%-- <ajc:TextBoxWatermarkExtender ID="txt_DOB_TextBoxWatermarkExtender" runat="server"
                                                Enabled="True" TargetControlID="tDOB" WatermarkCssClass="watermarked" WatermarkText="dd/MM/yyyy">
                                            </ajc:TextBoxWatermarkExtender>--%>
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td>
                                            <asp:Label ID="lblSex" runat="server" Text="Sex" 
                                                meta:resourcekey="lblSexResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddSex"  TabIndex="7" CssClass="ddlsmall" runat="server" ToolTip="Select Sex"
                                                onChange="GetGender(this)" meta:resourcekey="ddSexResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblQualify" runat="server" Text="Qualification" 
                                                meta:resourcekey="lblQualifyResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDrQualification" TabIndex="8" ToolTip="Refering Physician(Doctor) Qualification"
                                                CssClass="small" runat="server" MaxLength="60" 
                                                meta:resourcekey="txtDrQualificationResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td>
                                            <asp:Label ID="lbladd1" Text="Address" runat="server" 
                                                meta:resourcekey="lbladd1Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtaddres1" runat="server" CssClass="small" MaxLength="100" TextMode="MultiLine"
                                                TabIndex="9" AutoComplete="off" meta:resourcekey="txtaddres1Resource1"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblcity" Text="City" runat="server" 
                                                onkeydown=" return isNumeric(event,this.id)" 
                                                meta:resourcekey="lblcityResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtciti" runat="server" MaxLength="50" CssClass="small" TabIndex="10"
                                                AutoComplete="off" 
                                                  OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" 
                                                meta:resourcekey="txtcitiResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td>
                                            <asp:Label ID="lblCountry" Text="Country" runat="server" 
                                                meta:resourcekey="lblCountryResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="drpCountry" runat="server" TabIndex="11" CssClass="ddlsmall"
                                                onchange="javascript:loadState();" 
                                                meta:resourcekey="drpCountryResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblState" Text="State" runat="server" 
                                                meta:resourcekey="lblStateResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="drpState" runat="server" CssClass="ddlsmall" TabIndex="12"
                                                onchange="javascript:onchangeState();" 
                                                meta:resourcekey="drpStateResource1" />
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td>
                                            <asp:Label ID="Rs_EmailID" Text="Email ID" runat="server" 
                                                meta:resourcekey="Rs_EmailIDResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtEmailID" runat="server" CssClass="small" TabIndex="13" 
                                                AutoComplete="off" meta:resourcekey="txtEmailIDResource1"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblMobile" Text="Mobile Number" runat="server" 
                                                meta:resourcekey="lblMobileResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCountryCode" runat="server" 
                                                meta:resourcekey="lblCountryCodeResource1"></asp:Label>&nbsp;
                                            <asp:TextBox ID="txtmobileno" runat="server" CssClass="small" TabIndex="14" AutoComplete="off"
                                               onkeyup="LimitTextValidation(this.form.txtmobileno);" onkeydown=" return isNumeric(event,this.id);" 
                                                meta:resourcekey="txtmobilenoResource1" />
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td>
                                            <asp:Label ID="Rs_LandLine" Text="LandLine Number" runat="server" 
                                                meta:resourcekey="Rs_LandLineResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPhoneNumber" runat="server" MaxLength="15" TabIndex="15" CssClass="small"
                                                AutoComplete="off" onkeydown="return isNumeric(event,this.id);" 
                                                meta:resourcekey="txtPhoneNumberResource1"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblfaxno" Text="Fax No" runat="server" 
                                                meta:resourcekey="lblfaxnoResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtfax" runat="server" MaxLength="20" CssClass="small" AutoComplete="off"
                                                TabIndex="16" onkeydown=" return isNumeric(event,this.id);" 
                                                meta:resourcekey="txtfaxResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td>
                                            <asp:Label ID="lblOrg" runat="server" Text="Organization Name" 
                                                meta:resourcekey="lblOrgResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDrOrganization" TabIndex="17" CssClass="small" ToolTip="Refering Physician(Doctor) Organization"
                                                runat="server" MaxLength="60" 
                                                meta:resourcekey="txtDrOrganizationResource1"></asp:TextBox>
                                        </td>
                                        <td colspan="2">
                                            <asp:CheckBox ID="chkIsClient" runat="server" Text="IsClient" TabIndex="18" 
                                                meta:resourcekey="chkIsClientResource1" />
                                            <asp:CheckBox ID="chkActive" runat="server" Text="SMS" TabIndex="19" 
                                                onclick="javascript:return checkSMS(this.id);" 
                                                meta:resourcekey="chkActiveResource1" />
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td>
                                            <asp:Label ID="lblFilter" runat="server" Text="Filter" 
                                                meta:resourcekey="lblFilterResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <input type="text" tabindex="18" onkeyup="MyUtil.selectFilter('chklstHsptl', this.value)"
                                                class="Txtboxsmall" id="txtBX" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDiscountLimit" runat="server" Text="Discount Limit" 
                                                meta:resourcekey="lblDiscountLimitResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDiscountLimit" runat="server" MaxLength="20" CssClass="small"
                                                AutoComplete="off" TabIndex="16" 
                                                onkeydown=" return isNumeric(event,this.id);" 
                                                meta:resourcekey="txtDiscountLimitResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td>
                                            <asp:Label ID="Rs_FromDate2" runat="server" Text="Discount Valid From" 
                                                meta:resourcekey="Rs_FromDate2Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox CssClass="small" ID="txtFromPeriod" runat="server" 
                                                meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                            <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFromPeriod"
                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                Enabled="True" />
                                            <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                                                meta:resourcekey="MaskedEditValidator1Resource1" />
                                            <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFromPeriod"
                                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                        </td>
                                        <td>
                                            <asp:Label ID="Rs_ToDate2" runat="server" Text="Discount Valid To" 
                                                meta:resourcekey="Rs_ToDate2Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox CssClass="small" runat="server" ID="txtToPeriod" 
                                                meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                            <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtToPeriod"
                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                Enabled="True" />
                                            <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" 
                                                meta:resourcekey="MaskedEditValidator2Resource1" />
                                            <ajc:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtToPeriod"
                                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td>
                                            <asp:Label ID="Label1" runat="server" Text="Referal Hospital Name" 
                                                meta:resourcekey="Label1Resource1"></asp:Label>
                                        </td>
                                        <td colspan="3">
                                            <asp:ListBox ID="chklstHsptl" TabIndex="19" runat="server" ToolTip="Double Click the List or Press Enter to Select Group"
                                                EnableViewState="False" Width="350px" CssClass="h-100" onclick="javascript:return SetId(this.id);"
                                                onkeypress="javascript:setItem(event,this);" 
                                                ondblClick="javascript:onClick1(this.id);" 
                                                meta:resourcekey="chklstHsptlResource1">
                                            </asp:ListBox>
                                            <asp:HiddenField ID="HdnHospitalID" runat="server" />
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td>
                                            <asp:Label ID="lbl_category" runat="server" Text="Category" 
                                                meta:resourcekey="lbl_categoryResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlcategory" TabIndex="7" CssClass="ddlsmall" 
                                                runat="server" meta:resourcekey="ddlcategoryResource1">
                                            </asp:DropDownList>
                                            <%--<asp:Panel ID="CategoryPanel" runat="server">
                                                        <%--<asp:UpdatePanel ID="UpdatePanel" runat="server">--%>
                                            <%--<ContentTemplate>--%>
                                            <%-- <asp:CheckBox ID="ChkboxAll" Text="ALL" runat="server" CssClass="smallfon" onclick="checkAll(this)"
                                                                    Checked="false" />
                                                                <asp:CheckBoxList ID="chkCategory" runat="server" RepeatColumns="6 " RepeatDirection="Horizontal"
                                                                    RepeatLayout="Table" CssClass="smallfon">
                                                                </asp:CheckBoxList>--%>
                                            <%--</ContentTemplate>--%>
                                            <%--<Triggers>
                                                                <asp:AsyncPostBackTrigger ControlID="ddlTrustedOrg" EventName="SelectedIndexChanged" />
                                                            </Triggers>--%>
                                            <%--</asp:UpdatePanel>--%>
                                            <%--  </asp:Panel> --%>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbl_rate" runat="server" Text="Rate" meta:resourcekey="lbl_rateResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" ID="Txt_Rate" TabIndex="3" MaxLength="20" CssClass="Txtboxsmall"></asp:TextBox>
                                        </td>
                                    </tr>
		                            <tr class="a-left">
		                            <td>
		                                    <asp:Label ID="lblRef_FeeCategory" runat="server" Text="RefFeeCategory" meta:resourcekey="lblRef_FeeCategoryResource1"></asp:Label>
		                                </td>
		                                <td>
		                                   <asp:DropDownList ID="ddlFeeCategory" TabIndex="7" CssClass="small" runat="server">
		                                    </asp:DropDownList>
		                                </td>
		                            </tr>
		                            <tr class="a-left">
		                             <td>
                                                                                                                        <asp:Label ID="lblContactType" Text="Contact Type" runat="server" meta:resourcekey="lblContactTypeResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:DropDownList runat="server" ID="drplstPerson" Width="170px" CssClass="small" onChange="SetContextKey();"
                                                                                                                            meta:resourcekey="drplstPersonResource1">
                                                                                                                        </asp:DropDownList>
                                                                                                                      <%--  &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:Label ID="lblPersonName" Text="Name" runat="server" meta:resourcekey="lblPersonNameResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td style="display: table-cell;" id="tdtxtPrsn">
                                                                                                                        <asp:TextBox ID="txtPersonName" runat="server" CssClass="Txtboxsmall" Width="170px"
                                                                                                                            meta:resourcekey="txtPersonNameResource1"></asp:TextBox>
                                                                                                                        <%--&nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtPersonName"
                                                                                                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                                                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetSpecifiedDeptEmployee"
                                                                                                                            OnClientItemSelected="GetEmpID" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                                                                            DelimiterCharacters="" Enabled="True">
                                                                                                                        </ajc:AutoCompleteExtender>
                                                                                                                    </td>
		                            </tr>
									<tr class="a-left">
                                        <td colspan="4">
                                            <table class="w-50p">
                                                <tr>
                                                    <td class="v-middle">
                                                        <asp:Label ID="lblHeader" runat="server" CssClass="reflabel">
                                                                         Refering Hospital&nbsp;&nbsp;&nbsp;&nbsp;</asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tblOrederedInves" runat="server" class="dataheaderInvCtrl w-50p">
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td colspan="4">
                                            <asp:Label ID="lblLoginName" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td id="Td1" style="display: none;">
                                            <asp:CheckBox ID="chkUserLogin" TabIndex="20" runat="server" Text="Create User Login" />
                                        </td>
                                        <td colspan="3">
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td colspan="3">
                                            <div id="Login" runat="server" class="modalPopup dataheaderPopup h-100" style="display: none;
                                                border: none 20px; width: 300Px; border-color: Black;">
                                                <table>
                                                    <tr>
                                                        <td class="a-right">
                                                            Preferred User Name
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtUserName" CssClass="small" TabIndex="21" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-right">
                                                            Password
                                                        </td>
                                                        <td>
                                                            <asp:TextBox TextMode="Password" CssClass="small" TabIndex="22" Enabled="false" ID="txtPassword"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-right">
                                                            UserType
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkRefPhysician" Enabled="false" Text="Referring Physician" Checked="true"
                                                                TabIndex="23" runat="server"></asp:CheckBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td colspan="4">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td class="a-center" colspan="4">
                                            <asp:Button ID="btnFinish" UseSubmitBehavior="true" OnClientClick="return validateLabRefPhysicianDetails();"
                                                runat="server" OnClick="btnFinish_Click" TabIndex="20" Text="Save" ToolTip="Click here to Save Refering Physician(Doctor) Details"
                                                Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnFinishResource1" />
                                            <asp:Button ID="btnUpdate" Visible="false" OnClientClick="return validateLabRefPhysicianDetails();"
                                                TabIndex="21" runat="server" OnClick="btnUpdate_Click" Text="Save Changes" CssClass="btn"
                                                ToolTip="Click here to Change Refering Physician(Doctor) Details" Style="cursor: pointer;"
                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnUpdateResource1" />
                                            <asp:Button ID="btnDelete" Visible="false" ToolTip="Click here to Remove Refering Physician(Doctor) Details"
                                                Style="cursor: pointer;" OnClientClick="javascript:return ConfirmWindow('Are you sure to proceed?');return validateLabRefPhysicianDetails();"
                                                runat="server" OnClick="btnDelete_Click" Text="Delete" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnDeleteResource1" />
                                            <asp:Button ID="btnCancel" runat="server" TabIndex="22" Text="Cancel" ToolTip="Click here to Cancel"
                                                Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                                                <ProgressTemplate>
                                                    <div id="progressBackgroundFilter" class="a-center">
                                                    </div>
                                                    <div id="processMessage" class="a-center w-20p">
                                                        <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                                            meta:resourcekey="img1Resource1" />
                                                    </div>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <input type="hidden" id="hdnStateID" value="0" runat="server" />
                <input type="hidden" id="hdnCountryID" value="0" runat="server" />
                <asp:HiddenField ID="hdnCheckCode" Value="0" runat="server" />
                <asp:HiddenField ID="hdnGender" runat="server" />
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="ImageBtnExport" />
                <asp:PostBackTrigger ControlID="btnFinish" />
                <asp:PostBackTrigger ControlID="btnUpdate" />
                <asp:PostBackTrigger ControlID="btnDelete" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnpwdexpdate" runat="server" />
    <asp:HiddenField ID="hdntranspwdexpdate" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <input type="hidden" runat="server" id="hdnDateFormatConfig" value="dd/MM/yyyy" />
    <input type="hidden" id="hdnCBDecimalAge" runat="server" />
    <asp:HiddenField ID="hdnCalculateDays" Value="0" runat="server" />
    <input type="hidden" id="hdnPatientDOB" runat="server" />
    <input type="hidden" id="hdnAddDepart" runat="server" value="" />
    <input type="hidden" id="hdnEmpID" runat="server" value="" />
	<input type="hidden" id="hdnRstPswd" runat="server" value="0" />
    
        <script language="javascript" type="text/javascript">

            document.getElementById('hidID').value = document.getElementById('chklstHsptl').id;
        </script>

   
    </form>
</body>

<script>
//Added by Vinothini

    $(".contentdata").on("scroll", function() {
        $("#CalendarExtender1_popupDiv").css("display", "none");
        $("#txtDOBNos").focus();
    });
    $(function() {
        $(".datePicker").datepicker({
            dateFormat: 'dd/mm/yy',
            defaultDate: "+1w",
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                //$(".datePicker").datepicker("option", "maxDate", selectedDate);

                //var date = $("#txtFrom").datepicker('getDate');
                //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                // $("#txtTo").datepicker("option", "maxDate", d);

            }
        });

    });
    
</script>

</html>
