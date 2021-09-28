<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="ClientRateMapping.aspx.cs"
    Inherits="Admin_ClientRateMapping" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="uc31" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>--%>

    <script language="javascript" type="text/javascript">
        function CheckTransferRate() {
            var objMsg01 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_01") == null ? "TransferRate for this Client is already exists" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_01");
            var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");

            //alert('TransferRate for this Client is already exists');
            ValidationWindow(objMsg01, objAlert);
            document.getElementById('ChkInvRateID').checked = false;

        }
        function Duplicate() {
            document.getElementById("ChkInvRateID").onclick = null;
        }
        function validateFrom(obj1,obj2) {
            var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");
            var objMsg20 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_20") == null ? "ValidFrom Must be Greater than or Equalto Today Date" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_20");
            var obj = document.getElementById(obj1);
            var obj3 = document.getElementById(obj2);
            if (obj.value != '' && obj.value != '__/__/____' || obj3.value!='') {
                dobDt1 = obj.value.split('/');
                var dobDt2 = obj3.value.split('/');
                var dobDtTime = new Date(dobDt1[2] + '/' + dobDt1[1] + '/' + dobDt1[0]);
                var dobDtTime2 = new Date(dobDt2[2] + '/' + dobDt2[1] + '/' + dobDt2[0]);
                var month = (dobDtTime.getMonth() + 1);
                var monthTo = (dobDtTime2.getMonth() + 1);
                var day = parseInt(dobDt1[0]);
                var year = parseInt(dobDt1[2]);
                var dayTo = parseInt(dobDt2[0]);
                var yearTo = parseInt(dobDt2[2]);
                if ((obj3.value != '') && (day > dayTo && month > monthTo && year > yearTo)) {
                
                    ValidationWindow("ValidTO Must be Greater than or Equalto From Date", "Alert");
                    obj3.value = '';
                   
                }
            }
            var today = new Date(); //Today date
            var nowdd = today.getDate();
            var nowmm = (today.getMonth() + 1); //January is 0!
            var nowyyyy = today.getFullYear();
            if (year < nowyyyy) {
                ValidationWindow(objMsg20, objAlert);
                obj.value = '';
                obj.focus();
                return false;
            }
            else if (year == nowyyyy && month < nowmm) {
                ValidationWindow(objMsg20, objAlert);
                obj.value = '';
                obj.focus();
                return false;
            }
            else if (year == nowyyyy && month == nowmm && day < nowdd) {
                ValidationWindow(objMsg20, objAlert);
                obj.value = '';
                obj.focus();
                return false;
            }
            else if ((year > yearTo)) {
            obj3.value = '';
            }
            else if (year == yearTo &&   month > monthTo)
            { obj3.value = ''; }
            else if (year == yearTo && month == monthTo && day > dayTo)
            { obj3.value = ''; }
        }
        function ValidDate(obj1, obj2, StartDt, wedFlag, BAflage) {
            var obj = document.getElementById(obj1);
            var obj1 = document.getElementById(obj2);
            var objMsg02 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_02") == null ? "ValidTo Must be Greater than or Equalto ValidFrom Date" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_02");
            var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");
            var objMsg21 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_21") == null ? "Please Select Valid From Date" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_21");
            if (obj.value == '') {
                ValidationWindow(objMsg21, objAlert);
                obj1.value = '';
                obj.focus();
            }
            var currentTime;
            if (obj.value != '' && obj.value != '__/__/____') {
                dobDt = obj.value.split('/');
                var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
                var mMonth = (dobDtTime.getMonth() + 1);
                var mDay = parseInt(dobDt[0]);
                var mYear = parseInt(dobDt[2]);
            }
            if (obj1.value != '' && obj1.value != '__/__/____') {
                dobDt1 = obj1.value.split('/');
                var dobDtTime = new Date(dobDt1[2] + '/' + dobDt1[1] + '/' + dobDt1[0]);
                var month = (dobDtTime.getMonth() + 1);
                var day = parseInt(dobDt1[0]);
                var year = parseInt(dobDt1[2]);
            }
            if (mYear > year) {
                var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_1");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    document.getElementById('txtValidTo').value = '';
                    return false;
                }
                else {
                    //alert('ValidTo Must be Greater than or Equalto ValidFrom Date');
                    ValidationWindow(objMsg02, objAlert);
                    document.getElementById('txtValidTo').value = '';
                    return false;
                }
                obj1.value = '__/__/____';
                obj1.focus();
                return false;
            }
            else if ((mYear == year) && (mMonth > month)) {
                var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_1");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    document.getElementById('txtValidTo').value = '';
                    return false;
                }
                else {
                    var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_1");
                    if (userMsg != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg, objAlert);
                        document.getElementById('txtValidTo').value = '';
                        return false;
                    }
                    else {
                        //alert('ValidTo Must be Greater than or Equalto ValidFrom Date');
                        ValidationWindow(objMsg02, objAlert);
                        document.getElementById('txtValidTo').value = '';
                        return false;
                    }
                    return false;
                }
                obj1.value = '__/__/____';
                obj1.focus();
                return false;
            }
            else if (mYear == year && mMonth == month && mDay > day) {
                var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_1");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    document.getElementById('txtValidTo').value = '';
                    return false;
                }
                else {
                    //alert('ValidTo Must be Greater than or Equalto ValidFrom Date');
                    ValidationWindow(objMsg02, objAlert);
                    document.getElementById('txtValidTo').value = '';
                    return false;
                }
                obj1.value = '__/__/____';
                obj1.focus();
                return false;
            }
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
            //*************To block slash(/) into text box change the key value to 48***************************//
            if ((key >= 47 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
                isCtrl = true;
            }
            return isCtrl;
        }
        function ClearValues() {
            return true;
        }
        function SelectInvSeqRowCommon(rid) {
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
        }
        function SetEditedValues() {
        }
        function SelectedClientValue(source, eventArgs) {

            if (IsValidOrg() == true && IsValid() == true) {

                var Name = eventArgs.get_text();
                var ID = eventArgs.get_value();
                var ClientIDAndCode = ID.split('|');

                if (document.getElementById('hdnRateCode').value.trim() == "GENERAL" && document.getElementById('hdnClientCode').value.trim() == "GENERAL") {
                    document.getElementById('txtValidFrom').disabled = true;
                    document.getElementById('txtValidTo').disabled = true;
                }
                else {
                    document.getElementById('txtValidFrom').disabled = false;
                    document.getElementById('txtValidTo').disabled = false;
                }
                document.getElementById('txtClientName').disabled = false;
                document.getElementById('hdnClientID').value = ClientIDAndCode[0];
                document.getElementById('hdnClientCode').value = ClientIDAndCode[1];
                document.getElementById('txtRateCard').focus();
                IsMappingExists(Name, ClientIDAndCode[0]);
                javascript: __doPostBack('btnLoadGrid');
            }
        }
//        function checkclient() 
//        {
//            var objMsg33 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_18") == null ? "select from client list" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_18");
//            var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");

//            if (document.getElementById('hdnClientCode').value == '') {
//                //alert("select from client list");
//				ValidationWindow(objMsg33, objAlert);
//                document.getElementById('txtClientName').value = "";
//            }
//         
//        }
        function EnableTextBox() {
            document.getElementById('txtClientName').focus();
        }
        function SelectedRateValue(source, eventArgs) {
            var objMsg03 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_03") == null ? "Please select Client Name before you proceed" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_03");
            var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");

            if (IsValidOrg() == true && IsValid() == true) {

                var Name = eventArgs.get_text();
                var ID = eventArgs.get_value();
                var RateIDAndCode = ID.split('|');

                if (document.getElementById('txtClientName').value.trim() == "" || document.getElementById('hdnClientID').value == "0") {
                    var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_2");
                    if (userMsg != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg, objAlert);

                        return false;
                    }
                    else {
                        // alert('Please select Client Name before you proceed');
                        ValidationWindow(objMsg03, objAlert);
                        document.getElementById('txtClientName').value = "";
                        return false;
                    }

                    document.getElementById('txtRateCard').value = "";
                    document.getElementById('hdnRateID').value = "0";
                    document.getElementById('hdnRateCode').value = "";
                    document.getElementById('txtClientName').focus();
                    return false;
                }
                if (document.getElementById('hdnRateCode').value.trim() == "GENERAL" && document.getElementById('hdnClientCode').value.trim() == "GENERAL") {
                    document.getElementById('txtValidFrom').disabled = true;
                    document.getElementById('txtValidTo').disabled = true;
                }
                else {
                    document.getElementById('txtValidFrom').disabled = false;
                    document.getElementById('txtValidTo').disabled = false;
                }
                document.getElementById('txtClientName').disabled = false;
                document.getElementById('chkSelectAll').checked = false;
                if (document.getElementById('ddlClientType').value != "0") {
                    if (document.getElementById('chkClientList') != null) {
                        document.getElementById('chkClientList').style.display = "none";
                    }
                    document.getElementById('divChkList').style.display = "none";
                }
                document.getElementById('hdnRateID').value = RateIDAndCode[0];
                document.getElementById('hdnRateCode').value = RateIDAndCode[1];
                IsMappingExistss(Name, RateIDAndCode[0]);
            }
        }
        function IsMappingExistss(Name, ClientIDs) {
            if (document.getElementById('hdnClientID').value != "0") {
                ClientID = document.getElementById('hdnClientID').value;
                var RateID = document.getElementById('hdnRateID').value;
                var ClientTypeID = document.getElementById('ddlClientType').value;
                WebService.GetMappedClient(ClientID, RateID, ClientTypeID, GetListItems);
                return true;
            }
        }
        function ClearFields() {
            if (document.getElementById('txtClientName').value.trim() == "") {
                document.getElementById('hdnClientID').value = "0";
                document.getElementById('hdnClientCode').value = "";
            }
            if (document.getElementById('txtRateCard').value.trim() == "") {
                document.getElementById('hdnRateID').value = "0";
                document.getElementById('hdnRateCode').value = "";
            }
        }
        function GetListItems(lstCMaster) {
            var objMsg04 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_04") == null ? "Rate Card already mapped to this Client" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_04");
            var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");

            if (lstCMaster.length > 0) {
                var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_3");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    //alert('Rate Card already mapped to this Client');
                    ValidationWindow(objMsg04, objAlert);
                    return false;
                }
                document.getElementById('txtClientName').value = "";
                document.getElementById('hdnClientID').value = "0";
                document.getElementById('hdnClientCode').value = "";
                document.getElementById('txtRateCard').value = "";
                document.getElementById('hdnRateID').value = "0";
                document.getElementById('hdnRateCode').value = "";
                document.getElementById('txtClientName').focus();
                return false;
            }
        }
        function IsMappingExists(Name, ClientID) {
            var RateID = document.getElementById('hdnRateID').value;
            var ClientTypeID = document.getElementById('ddlClientType').value;
            WebService.GetMappedClient(ClientID, RateID, ClientTypeID, GetListItems);
            return true;
        }

        function IsRateSelected() {
            var objMsg05 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_05") == null ? "Please select Client Type before you proceed" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_05");
            var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");

            if (document.getElementById('chkSelectAll').checked == true) {
                if (document.getElementById('ddlClientType').value == "0") {
                    var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_4");
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, objAlert);

                        return false;
                    }
                    else {
                        //alert('Please select Client Type before you proceed');
                        ValidationWindow(objMsg05, objAlert);

                        return false;
                    }

                    document.getElementById('chkSelectAll').checked = false;
                    document.getElementById('ddlClientType').focus();
                    return false;
                }
                var objMsg06 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_06") == null ? "Please select Rate Card before you proceed" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_06");

                if (document.getElementById('txtRateCard').value.trim() == "" || document.getElementById('hdnRateID').value == "0") {
                    var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_5");
                    if (userMsg != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg, objAlert);
                        return false;
                    }
                    else {
                        // alert('Please select Rate Card before you proceed');
                        ValidationWindow(objMsg06, objAlert);
                        return false;
                    }
                    document.getElementById('chkSelectAll').checked = false;
                    document.getElementById('txtRateCard').focus();
                    return false;
                }
            }
            return true;
        }
        function ShowHideCheckList() {
            if (IsRateSelected() == true) {
                if (document.getElementById('ddlClientType').value != "0" && document.getElementById('chkClientList') != null) {
                    document.getElementById('chkClientList').style.display = document.getElementById('chkSelectAll').checked == true ? "block" : "none";
                    document.getElementById('divChkList').style.display = document.getElementById('chkSelectAll').checked == true ? "block" : "none";
                    if (document.getElementById('chkSelectAll').checked == false) {
                        document.getElementById('txtClientName').disabled = false;
                        document.getElementById('txtClientName').value = "";
                        document.getElementById('hdnClientID').value = "0";
                        document.getElementById('hdnClientCode').value = "";
                        for (var i = 0; i < document.getElementById('chkClientList').childNodes.length; i++) {
                            for (var j = 0; j < document.getElementById('chkClientList').childNodes[i].childNodes.length; j++) {
                                for (var k = 0; k < document.getElementById('chkClientList').childNodes[i].childNodes[j].childNodes.length; k++) {
                                    for (var l = 0; l < document.getElementById('chkClientList').childNodes[i].childNodes[j].childNodes[k].childNodes.length; l++) {
                                        var objid = document.getElementById('chkClientList').childNodes[i].childNodes[j].childNodes[k].childNodes[l].id;
                                        if (objid != "" && objid != null && document.getElementById(objid).type == "checkbox") {
                                            document.getElementById(objid).checked = false;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else {
                        document.getElementById('txtClientName').value = "";
                        document.getElementById('hdnClientID').value = "0";
                        document.getElementById('hdnClientCode').value = "";
                        document.getElementById('txtClientName').disabled = true;
                        for (var i = 0; i < document.getElementById('chkClientList').childNodes.length; i++) {
                            for (var j = 0; j < document.getElementById('chkClientList').childNodes[i].childNodes.length; j++) {
                                for (var k = 0; k < document.getElementById('chkClientList').childNodes[i].childNodes[j].childNodes.length; k++) {
                                    for (var l = 0; l < document.getElementById('chkClientList').childNodes[i].childNodes[j].childNodes[k].childNodes.length; l++) {
                                        var objid = document.getElementById('chkClientList').childNodes[i].childNodes[j].childNodes[k].childNodes[l].id;
                                        if (objid != "" && objid != null && document.getElementById(objid).type == "checkbox") {
                                            document.getElementById(objid).checked = false;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        function IsValid() {
            var objMsg07 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_07") == null ? "Select Client Type" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_07");
            var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");

            if (document.getElementById('ddlClientType').value == "0") {
                var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_6");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);

                    return false;
                }
                else {
                    // alert('Select Client Type');
                    ValidationWindow(objMsg07, objAlert);
                    return false;
                }
                document.getElementById('txtClientName').value = "";
                document.getElementById('hdnClientID').value = "0";
                document.getElementById('hdnClientCode').value = "";
                document.getElementById('txtRateCard').value = "";
                document.getElementById('hdnRateID').value = "0";
                document.getElementById('hdnRateCode').value = "";
                document.getElementById('ddlClientType').focus();
                return false;
            }
            return true;
        }
        function IsValidOrg() {
            if (document.getElementById('ddlTrustedOrg').value == "0") {
                var objMsg08 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_08") == null ? "Select Organization" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_08");
                var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");

                var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_7");
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);

                    return false;
                }
                else {
                    // alert('Select Organization');
                    ValidationWindow(objMsg08, objAlert);

                    return false;
                }
                document.getElementById('txtClientName').value = "";
                document.getElementById('hdnClientID').value = "0";
                document.getElementById('hdnClientCode').value = "";
                document.getElementById('txtRateCard').value = "";
                document.getElementById('hdnRateID').value = "0";
                document.getElementById('hdnRateCode').value = "";
                document.getElementById('ddlTrustedOrg').focus();
                return false;
            }
            return true;
        }
        function checkClientRateExists() {

            var objMsg08 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_08") == null ? "Select Organization" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_08");
            var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");
            var objMsg07 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_07") == null ? "Select Client Type" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_07");
            var objMsg09 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_09") == null ? "Provide Rate Card" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_09");
                     
					 var objMsg56 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_16") == null ? "Provide from date" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_16");
					 var objMsg57 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_17") == null ? "Provide to date" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_17");
		    if (document.getElementById('txtValidFrom').value == "") {

                //alert('Provide from date');
                ValidationWindow(objMsg56, objAlert);
                return false;
            }
            if (document.getElementById('txtValidTo').value == "") {

                //alert('Provide to date');
                ValidationWindow(objMsg57, objAlert);
                return false;
            }
            if (document.getElementById('ddlTrustedOrg').value == "0") {
                var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_7");
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    //  alert('Select Organization');
                    ValidationWindow(objMsg08, objAlert);
                    return false;
                }
                document.getElementById('ddlTrustedOrg').focus();
                return false;
            }
            if (document.getElementById('ddlClientType').value == "0") {
                var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_6");
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    // alert('Select Client Type');
                    ValidationWindow(objMsg07, objAlert);
                    return false;
                }
                document.getElementById('ddlClientType').focus();
                return false;
            }
            if (document.getElementById('txtRateCard').value.trim() == "" || document.getElementById('hdnRateID').value == "0") {
                var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_8");
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    //alert('Provide Rate Card');
                    ValidationWindow(objMsg09, objAlert);
                    return false;
                }

                document.getElementById('txtRateCard').focus();
                return false;
            }
            if (document.getElementById('ddlReason').value == "0") {
                var objMsg10 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_10") == null ? "Provide Reason" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_10");
                var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");

                // alert('Provide Reason');
                ValidationWindow(objMsg10, objAlert);
                return false;
            }
            var objMsg11 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_11") == null ? "Provide Name" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_11");
            var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");

            if (document.getElementById('chkSelectAll').checked == false) {
                if (document.getElementById('txtClientName').value.trim() == "" || document.getElementById('hdnClientID').value == "0") {
                    var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_9");
                    if (userMsg != null) {
                        //  alert(userMsg);
                        ValidationWindow(userMsg, objAlert);
                        return false;
                    }
                    else {
                        // alert('Provide Name');
                        ValidationWindow(objMsg11, objAlert);
                        return false;
                    }
                    document.getElementById('txtClientName').focus();
                    return false;
                }
            }
            var Ofrm = document.getElementById('txtValidFrom').id;
            var OTo = document.getElementById('txtValidTo').id;
            var ValidateObj = "0";
            if (document.getElementById('btnAdd').value == "Update") {
                ValidateObj = "1";
            }
            if (document.getElementById('hdnRateCode').value.trim() != "GENERAL" || document.getElementById('hdnClientCode').value.trim() != "GENERAL") {
                //                if (ExcedDate11(Ofrm, OTo, ValidateObj) == false) {
                //                    return false;
                //                }
            }
            //            if (document.getElementById('txtRateCard').value.trim() != "GENERAL" || document.getElementById('txtClientName').value.trim() != "GENERAL") {
            //                if (From.trim() == "" || From.trim() == "__/__/____") {
            //                    alert('Provide Valid Date');
            //                    document.getElementById('txtValidFrom').focus();
            //                    return false;
            //                }
            //                if (To.trim() == "" || To.trim() == "__/__/____") {
            //                    alert('Provide Valid Date');
            //                    document.getElementById('txtValidTo').focus();
            //                    return false;
            //                } 
            //            }
            var flag = "0";
            if (document.getElementById('chkSelectAll').checked == true && document.getElementById('ddlClientType').value != "0") {
                if (document.getElementById('chkClientList') != null) {
                    for (var i = 0; i < document.getElementById('chkClientList').childNodes.length; i++) {
                        for (var j = 0; j < document.getElementById('chkClientList').childNodes[i].childNodes.length; j++) {
                            for (var k = 0; k < document.getElementById('chkClientList').childNodes[i].childNodes[j].childNodes.length; k++) {
                                for (var l = 0; l < document.getElementById('chkClientList').childNodes[i].childNodes[j].childNodes[k].childNodes.length; l++) {
                                    var objid = document.getElementById('chkClientList').childNodes[i].childNodes[j].childNodes[k].childNodes[l].id;
                                    if (objid != "" && objid != null && document.getElementById(objid).type == "checkbox" && document.getElementById(objid).checked == true) {
                                        flag = "1";
                                    }
                                }
                            }
                        }
                    }
                }
                var objMsg12 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_12") == null ? "Please select atleast one Client to proceed" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_12");
                var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");

                if (flag == "0") {
                    var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_10");
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, objAlert);

                        return false;
                    }
                    else {
                        // alert('Please select atleast one Client to proceed');
                        ValidationWindow(objMsg12, objAlert);

                        return false;
                    }
                    return false;
                }
            }
        }
        function fnCheckClients(objList, objClientID) {
            var objMsg13 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_13") == null ? "This rate card already mapped to this client" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_13");
            var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");

            var list = objList.split('###');
            for (i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    var res = list[i].split('~');
                    if (document.getElementById('hdnRateID').value == res[0].trim()) {
                        var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_3");
                        if (userMsg != null) {
                            //alert(userMsg);
                            ValidationWindow(userMsg, objAlert);

                            return false;
                        }
                        else {
                            //  alert("This rate card already mapped to this client");
                            ValidationWindow(objMsg13, objAlert);

                            return false;
                        }
                        return false;
                    }
                }
            }
            return true;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <div style="display: none;">
        <uc31:Theme ID="Theme1" runat="server" />
    </div>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table class="defaultfontcolor w-100p">
                    <tr>
                        <td>
                            <div id="DivSupplier" runat="server">
                                <table id="tblSupplierDiv" runat="server" class="dataheader2 defaultfontcolor w-100p">
                                    <tr runat="server">
                                        <td colspan="2" runat="server">
                                            <table class="w-100p searchPanel">
                                                <tr id="Tr1" runat="server">
                                                    <td class="w-84p" id="Td1" runat="server">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <%--<td colspan="4">
                                                                                    <table width="100%">
                                                                                        <tr>--%>
                                                                <td class="a-left w-10p">
                                                                    <asp:Label ID="lblOrganization" runat="server" Text="Organization" meta:resourcekey="lblOrganizationResource1"></asp:Label>
                                                                </td>
                                                                <td class="a-left w-28p" nowrap="nowrap">
                                                                    <asp:DropDownList ID="ddlTrustedOrg" runat="server" AutoPostBack="True" TabIndex="1"
                                                                        CssClass="ddlsmall" OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged"
                                                                        meta:resourcekey="ddlTrustedOrgResource1">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                                </td>
                                                                <td class="a-left w-12p" nowrap="nowrap">
                                                                    <asp:Label ID="lblClientType" runat="server" Text="Business Type" meta:resourcekey="lblClientTypeResource1" ></asp:Label>
                                                                </td>
                                                                <td class="w-30p a-left" nowrap="nowrap">
                                                                    <asp:DropDownList ID="ddlClientType" CssClass="ddlsmall" runat="server" TabIndex="2"
                                                                        OnSelectedIndexChanged="ddlClientType_SelectedIndexChanged" AutoPostBack="True"
                                                                        meta:resourcekey="ddlClientTypeResource1">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                                </td>
                                                                <td class="w-17p a-left" style="display: none">
                                                                    <asp:CheckBox ID="chkSelectAll" runat="server" onclick="ShowHideCheckList();" Text="Apply to all"
                                                                        TabIndex="3" meta:resourcekey="chkSelectAllResource1" />
                                                                    <asp:CheckBox ID="chkShowAll" Style="display: none;" AutoPostBack="True" runat="server"
                                                                        TabIndex="4" Text="Show non-expired items" OnCheckedChanged="chkShowAll_CheckedChanged"
                                                                        meta:resourcekey="chkShowAllResource1" />
                                                                </td>
                                                                <td class="w-10p" nowrap="nowrap">
                                                                    <asp:Label ID="lblClientName" Text="Client Name" runat="server" meta:resourcekey="lblClientNameResource1" />
                                                                </td>
                                                                <td class="w-28p" nowrap="nowrap">
                                                                    <div id="divClient" runat="server">
                                                                        <asp:TextBox CssClass="small" ID="txtClientName" runat="server" TabIndex="4" meta:resourcekey="txtClientNameResource1" ></asp:TextBox>
                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                                                            BehaviorID="AutoCompleteExLstGrp" CompletionListCssClass="wordWheel listMain .box"
                                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                            EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                                                                            ServiceMethod="GetClientNamebyClientType" OnClientItemSelected="SelectedClientValue"
                                                                            ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
                                                                        </ajc:AutoCompleteExtender>
                                                                    </div>
                                                                </td>
                                                                <%--</tr>
                                                                                    </table>
                                                                                </td>--%>
                                                            </tr>
                                                            <tr class="a-left">
                                                                <td>
                                                                    <asp:Label ID="lblratetype" runat="server" Text="Rate Type" meta:resourcekey="lblratetypeResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlratetype" runat="server" OnSelectedIndexChanged="ddlratetype_SelectedIndexChanged"
                                                                        AutoPostBack="true" CssClass="ddlsmall" TabIndex="5">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="a-left w-12p">
                                                                    <asp:Label ID="lblRateCard" Text="Rate Card" runat="server" meta:resourcekey="lblRateCardResource1" />
                                                                </td>
                                                                <td class="w-30p" nowrap="nowrap">
                                                                    <asp:TextBox ID="txtRateCard" CssClass="small" TabIndex="6" runat="server" meta:resourcekey="txtRateCardResource1"></asp:TextBox>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtRateCard"
                                                                        BehaviorID="AutoCompleteExLstGrp1" CompletionListCssClass="wordWheel listMain .box"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                                                                        ServiceMethod="GetClientRateCard" OnClientItemSelected="SelectedRateValue" ServicePath="~/WebService.asmx"
                                                                        DelimiterCharacters="" Enabled="True">
                                                                    </ajc:AutoCompleteExtender>
                                                                    <asp:HiddenField ID="hdnRateID" runat="server" />
                                                                    <asp:HiddenField ID="hdnRateCode" runat="server" />
                                                                </td>
                                                                <td class="w-17p a-left" nowrap="nowrap">
                                                                    <asp:CheckBox ID="ChkBaserate" runat="server" Text="Base Rate" meta:resourcekey="ChkBaserateResource1" />
                                                                </td>
                                                                <td class="a-left w-17p" nowrap="nowrap">
                                                                    <asp:CheckBox ID="ChkInvRateID" runat="server" Text="Transfer Rate" meta:resourcekey="ChkInvRateIDResource1"/>
                                                                </td>
                                                            </tr>
                                                            <tr class="a-left">
                                                                <td class="w-10p" id="td2" runat="server">
                                                                    &nbsp;<asp:Label ID="lblValidFrom" Text="Valid From" runat="server" meta:resourcekey="lblValidFromResource1" />
                                                                </td>
                                                                <td class="w-28p">
                                                                    <asp:TextBox runat="server" size="25" CssClass="small" ID="txtValidFrom" TabIndex="7"
                                                                        MaxLength="10"  meta:resourcekey="txtValidFromResource1"></asp:TextBox>
                                                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MMM/yyyy" runat="server"
                                                                        TargetControlID="txtValidFrom" PopupButtonID="ImgBntCalc" Enabled="True" />
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;" />
                                                                    <asp:DropDownList runat="server" TabIndex="8" ID="ddlFrom" >
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="a-left w-12p">
                                                                    <asp:Label ID="lblValidTo" Text="Valid To" runat="server" meta:resourcekey="lblValidToResource1" />
                                                                </td>
                                                                <td class="w-30p">
                                                                    <asp:TextBox ID="txtValidTo" size="25" CssClass="small" runat="server" TabIndex="9"
                                                                        MaxLength="10"  meta:resourcekey="txtValidToResource1"></asp:TextBox>
                                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MMM/yyyy" runat="server"
                                                                        TargetControlID="txtValidTo" PopupButtonID="ImgBntCalc" Enabled="True" />
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;" />
                                                                    <asp:DropDownList runat="server" ID="ddlTo" TabIndex="10" >
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="w-17p a-left">
                                                                    <asp:Label ID="lblReason" runat="server" Text="Reason" meta:resourcekey="lblReasonResource1" />
                                                                </td>
                                                                <td class="w-17p a-left" nowrap="nowrap">
                                                                    <asp:DropDownList ID="ddlReason" runat="server" AutoPostBack="false" CssClass="ddlsmall">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="5" class="a-center">
                                                                    <asp:Button ID="btnAdd" runat="server" Text="Save" CssClass="btn h-22 w-59" onmouseover="this.className='btn btnhov'"
                                                                        TabIndex="11" onmouseout="this.className='btn'" OnClientClick="return checkClientRateExists();"
                                                                        OnClick="btnAdd_Click" meta:resourcekey="btnAddResource1" />
                                                                    <asp:Button ID="btnPopUp" Style="display: none;" runat="server" Text="PopUp" CssClass="btn h-22 w-59"
                                                                        TabIndex="12" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                        meta:resourcekey="btnPopUpResource1" />
                                                                    <asp:HiddenField ID="hdnMessages" runat="server" />
                                                                    <asp:HiddenField ID="hdnMappingDetailsID" Value="0" runat="server" />
                                                                    <asp:HiddenField ID="hdnClientID" Value="0" runat="server" />
                                                                    <asp:HiddenField ID="hdnClientCode" runat="server" />
                                                                    <asp:HiddenField ID="hdnClientTypeID" Value="0" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td class="w-35p v-top" rowspan="2" runat="server">
                                                        <table class="w-100p" border="1" id="divChkList" runat="server" style="display: none;">
                                                            <tr runat="server">
                                                                <td class="v-top w-100p" runat="server">
                                                                    <div id="divChkList1" runat="server" style="overflow: scroll;">
                                                                        <asp:CheckBoxList RepeatColumns="3" RepeatDirection="Horizontal" Style="display: none;"
                                                                            TabIndex="13" ID="chkClientList" runat="server">
                                                                        </asp:CheckBoxList>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4">
                                                        <asp:GridView ID="grdClientRateMapping" runat="server" AutoGenerateColumns="False"
                                                            AllowPaging="True" ForeColor="#333333" CssClass="dataheaderInvCtrl gridView w-100p m-auto"
                                                            OnPageIndexChanging="grdClientRateMapping_PageIndexChanging" OnRowEditing="grdClientRateMapping_RowEditing"
                                                            OnRowDataBound="grdClientRateMapping_RowDataBound" meta:resourcekey="grdClientRateMappingResource1">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Rate Card" meta:resourcekey="TemplateFieldResource2">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRate" runat="server" Text='<%# Bind("RateName") %>' meta:resourcekey="lblRateResource1" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Rate Type" meta:resourcekey="TemplateFieldResource40">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRate12" runat="server" Text='<%# Bind("Type") %>' />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField Visible="False" HeaderText="RateId" meta:resourcekey="TemplateFieldResource3">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRateId" runat="server" Text='<%# Bind("RateId") %>' meta:resourcekey="lblRateIdResource1" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField Visible="False" HeaderText="RateCode" meta:resourcekey="TemplateFieldResource32">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRateCode" runat="server" Text='<%# Bind("RateCode") %>' meta:resourcekey="lblRateCodeResource1" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Client Name" meta:resourcekey="TemplateFieldResource4">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblClient" runat="server" Text='<%# Bind("ClientName") %>' meta:resourcekey="lblClientResource1" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Priority No" meta:resourcekey="TemplateFieldResource41" >
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblSno" runat="server" Text='<%# Bind("Priority") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField Visible="False" HeaderText="ClientId" meta:resourcekey="TemplateFieldResource5">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblClientId" runat="server" Text='<%# Bind("ClientId") %>' meta:resourcekey="lblClientIdResource1" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField Visible="False" HeaderText="ClientCode" meta:resourcekey="TemplateFieldResource33">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblClientCode" runat="server" Text='<%# Bind("ClientCode") %>' meta:resourcekey="lblClientCodeResource1" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Valid From" meta:resourcekey="TemplateFieldResource6">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblFromDate" Text='<%#Eval("ValidFrom", "{0:dd/MMM/yyyy hh:mm tt}") %>'
                                                                            runat="server" meta:resourcekey="lblFromDateResource1"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Valid To" meta:resourcekey="TemplateFieldResource7">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblToDate" Text='<%# Eval("ValidTo", "{0:dd/MMM/yyyy hh:mm tt}") %>'
                                                                            runat="server" meta:resourcekey="lblToDateResource1" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField Visible="False" HeaderText="ClientTypeId" meta:resourcekey="TemplateFieldResource8">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblClientTypeId" Text='<%# Bind("ClientTypeId") %>' runat="server"
                                                                            meta:resourcekey="lblClientTypeIdResource1" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField Visible="False" HeaderText="MappingDetailsID" meta:resourcekey="TemplateFieldResource9">
                                                                    <ItemTemplate>
                                                                        <asp:Label CssClass="w-10" ID="lblMappingDetailsID" Text='<%# Bind("ClientMappingDetailsID") %>'
                                                                            runat="server" meta:resourcekey="lblMappingDetailsIDResource1" />
                                                                        <asp:Label CssClass="w-10" ID="lblPriority" Text='<%# Bind("Priority") %>' Visible="False"
                                                                            runat="server" meta:resourcekey="lblPriorityResource1" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField Visible="false" HeaderText="Transfer Rate" meta:resourcekey="TemplateFieldResource42">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblInvRate1" Text='<%# Bind("TransferRate") %>' runat="server" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField Visible="true" HeaderText="Base Rate" meta:resourcekey="TemplateFieldResource43">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblInvBaseRate" Text='<%# Bind("BaseRate") %>' runat="server" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource10" >
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="btnEdit" CommandName="Edit" runat="server" Text="Edit" OnClientClick="return SetEditedValues();"
                                                                            Style='background-color: Transparent; color: Blue; border-style: none; cursor: pointer'
                                                                            meta:resourcekey="btnEditResource1"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <RowStyle HorizontalAlign="Left" />
                                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                            <HeaderStyle CssClass="dataheader1" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table class="w-100p" runat="server">
                                    <tr runat="server">
                                        <td runat="server">
                                            <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btnPopUp"
                                                PopupControlID="DivEditWindow" BackgroundCssClass="modalBackground" BehaviorID="EditModalPopup"
                                                DynamicServicePath="" Enabled="True">
                                            </ajc:ModalPopupExtender>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="DivEditWindow" runat="server" style="overflow: scroll; border: 5px; background-color: White;
                                border-color: #fff; height: 450px; width: 900px; display: block;" class="dataheader1">
                                <table>
                                    <tr>
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvReckon" runat="server" AutoGenerateColumns="False" Caption="Re-order Sequence to set Priority"
                                                            CaptionAlign="Left" CellPadding="3" CssClass="dataheaderInvCtrl gridView w-100p m-auto"
                                                            EmptyDataText="No matching records found " ForeColor="#333333" OnRowCommand="gvReckon_RowCommand"
                                                            OnRowDataBound="gvReckon_RowDataBound" meta:resourcekey="gvReckonResource1">
                                                            <Columns>
                                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource11">
                                                                    <ItemTemplate>
                                                                        <asp:RadioButton ID="rdbcheck" runat="server" meta:resourcekey="rdbcheckResource1" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Rate Card" meta:resourcekey="TemplateFieldResource12">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRate" CssClass="w-100" runat="server" Text='<%# Bind("RateName") %>'
                                                                            meta:resourcekey="lblRateResource2" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="220px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Rate Type">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRate123" runat="server" Text='<%# Bind("Type") %>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="RateId" Visible="False" meta:resourcekey="TemplateFieldResource13">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRateId" CssClass="w-10" runat="server" Text='<%# Bind("RateId") %>'
                                                                            meta:resourcekey="lblRateIdResource2" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="RateCode" Visible="False" meta:resourcekey="TemplateFieldResource30">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRateCode" runat="server" Text='<%# Bind("RateCode") %>' CssClass="w-10"
                                                                            meta:resourcekey="lblRateCodeResource2" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Client Name" meta:resourcekey="TemplateFieldResource14">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblClient" runat="server" Text='<%# Bind("ClientName") %>' CssClass="w-100"
                                                                            meta:resourcekey="lblClientResource2" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="220px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="ClientId" Visible="False" meta:resourcekey="TemplateFieldResource15">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblClientId" runat="server" Text='<%# Bind("ClientID") %>' CssClass="w-10"
                                                                            meta:resourcekey="lblClientIdResource2" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="TransferRate" Visible="false" meta:resourcekey="TemplateFieldResource4">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblInvRate" runat="server" Text='<%# Bind("TransferRate") %>' CssClass="w-10"
                                                                            meta:resourcekey="lblInvRateResource1" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="BaseRate">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblInvBaseRateCard" runat="server" Text='<%# Bind("BaseRate") %>'
                                                                            CssClass="w-10" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="ClientCode" Visible="False" meta:resourcekey="TemplateFieldResource31">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblClientCode" runat="server" Text='<%# Bind("ClientCode") %>' CssClass="w-10"
                                                                            meta:resourcekey="lblClientCodeResource2" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Valid From" meta:resourcekey="TemplateFieldResource16">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblFromDate" runat="server" Text='<%# Bind("ValidFrom","{0:dd/MMM/yyyy hh:mm tt}") %>'
                                                                            CssClass="w-100" meta:resourcekey="lblFromDateResource2"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle CssClass="w-100" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Valid  To" meta:resourcekey="TemplateFieldResource17">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblToDate" runat="server" Text='<%# Bind("ValidTo","{0:dd/MMM/yyyy hh:mm tt}") %>'
                                                                            CssClass="w-100" meta:resourcekey="lblToDateResource2" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle CssClass="w-100" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="ClientTypeId" Visible="False" meta:resourcekey="TemplateFieldResource18">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblClientTypeId" runat="server" Text='<%# Bind("ClientTypeId") %>'
                                                                            CssClass="w-10" meta:resourcekey="lblClientTypeIdResource2" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="MappingDetailsID" Visible="False" meta:resourcekey="TemplateFieldResource19">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblMappingDetailsID" runat="server" Text='<%# Bind("ClientMappingDetailsID") %>'
                                                                            CssClass="w-10" meta:resourcekey="lblMappingDetailsIDResource2" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource20">
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="btnUp" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                            CommandName="UP" ImageUrl="~/Images/UpArrow.png" meta:resourcekey="btnUpResource1" />
                                                                        <asp:ImageButton ID="btnDown" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                            CommandName="DOWN" ImageUrl="~/Images/DownArrow.png" meta:resourcekey="btnDownResource1" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle CssClass="w-100" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Move" meta:resourcekey="TemplateFieldResource21">
                                                                    <ItemTemplate>
                                                                        <asp:Button ID="btnmove" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                            CommandName="Move" CssClass="btn" Text="Move Here" meta:resourcekey="btnmoveResource1" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <HeaderStyle CssClass="dataheader1" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:HiddenField ID="hdnpriorityid" Value="0" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <asp:Button ID="btnSave" runat="server" CssClass="btn h-22 w-59" OnClick="btnSave_Click"
                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Save"
                                                meta:resourcekey="btnSaveResource1" />
                                            <asp:Button ID="btnCancel" runat="server" CssClass="btn h-22 w-59" OnClick="btnCancel_Click"
                                                OnClientClick="return ClearValues();" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                Text="Cancel" meta:resourcekey="btnCancelResource1" />
                                            <asp:Button ID="btnLoadGrid" runat="server" CssClass="btn h-22 w-59" onmouseout="this.className='btn'"
                                                onmouseover="this.className='btn btnhov'" Text="Load Grid" OnClick="btnLoadGrid_Click"
                                                meta:resourcekey="btnLoadGridResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlratetype" EventName="SelectedIndexChanged" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
