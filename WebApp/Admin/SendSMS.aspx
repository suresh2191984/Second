<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SendSMS.aspx.cs" Inherits="Admin_SendSMS"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>--%>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Send SMS</title>
    <%--    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />--%>
    <script src="../js/jquery-ui.min.js" language="javascript" type="text/javascript"></script>
    
    <%--<script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>--%>
    
        

    <script src="../Scripts/CommonBilling.js" type="text/javascript"></script>

    <%--   <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />--%>

    <script language="javascript" type="text/javascript">

        function ValidateEnterSpace(evt) {
            var keyCode = 0;
            if (evt) {
                keyCode = evt.keyCode || evt.which;
            }
            else {
                keyCode = window.event.keyCode;
            }

            if ((keyCode == 13) || (keyCode == 32)) {
                return false;
            }
            else {
                return true;
            }

            //    var keyCode = evt.which ? evt.which : evt.keyCode;
            //    return keyCode < '0'.charCodeAt() || keyCode > '9'.charCodeAt();
        }
        
        function getrefhospid(source, eventArgs) {
            var sval = 0;
            var OrgID = document.getElementById('hdnOrgID').value;
            var rec = 0;
            //document.getElementById('hdfReferalHospitalID').value;
            var sval = "RPH" + "^" + OrgID + "^" + rec;
            $find('AutoCompleteExtenderRefPhy').set_contextKey(sval);
        }
        function ShowPopUp(visitnumber) {
           var ReturnValue = window.open("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&VisitNumber=" + visitnumber, "", "height=800,width=1000,scrollbars=Yes");
       }
       function isInteger(evt) {
           var charCode = (evt.which) ? evt.which : event.keyCode
           if (charCode > 31 && (charCode < 48 || charCode > 57))
               return false;
           return true;
       }
        function checkForValues() {

            if (document.getElementById('txtpageNo').value == "") {
                alert('Provide page number');
                return false;
            }
            if (Number(document.getElementById('txtpageNo').value) < Number(1)) {
                alert('Provide correct page number');
                return false;
            }
            if (Number(document.getElementById('txtpageNo').value) > Number(document.getElementById('lblTotal').innerText)) {
                alert('Provide correct page number');
                return false;
            }
            return true;
        }
        function Clears() {
            //            document.getElementById('chkUserList').checked = false;
            //            document.getElementById('chkClientList').checked = false;
            //            document.getElementById('chkPatientList').checked = false;
            //            document.getElementById('chkHospital').checked = false;
            //            document.getElementById('txtAge').value = "";
            //            document.getElementById('drpserviceType').value = '0';
            //document.getElementById('txtInvestigations').value = "";
            // document.getElementById('txtSubject').value = "";
            //            document.getElementById('txtFromDate').value = "";
            //            document.getElementById('txtToDate').value = "";
            //            document.getElementById('drpresulttype').value = "0";
            //            document.getElementById('drpmartial').value = "0";
            //            document.getElementById('ddlRegisterDate').value = "-1";
            //document.getElementById('txtsearchothers').value = "";
        }
        function Checktypes() {
           if ((document.getElementById('chkUserList').checked == false) && (document.getElementById('chkClientList').checked == false)
                    && (document.getElementById('chkPatientList').checked == false) && (document.getElementById('chkHospital').checked == false)
                    && (document.getElementById('chkdoctors').checked == false) 
                    && (document.getElementById('chktests').checked == false) && (document.getElementById('chkvisitno').checked == false)) {
                alert('Select the type');
                document.getElementById('chkPatientList').focus();
                return false;
            }            
        }
        function CheckValues() {
            if ((document.getElementById('chkUserList').checked == false) && (document.getElementById('chkClientList').checked == false)
                    && (document.getElementById('chkPatientList').checked == false) && (document.getElementById('chkHospital').checked == false)
                    && (document.getElementById('chkdoctors').checked == false)
                     && (document.getElementById('chktests').checked == false) && (document.getElementById('chkvisitno').checked == false)) {
                alert('Select the type');
                document.getElementById('chkPatientList').focus();
                return false;
            }
            if (document.getElementById('txtFrom').value == '' || document.getElementById('txtTo').value == ''){
            if (document.getElementById('txtsearchothers').value == '' || document.getElementById('txtsearchothers').value == 'Enter the Name') {
                alert('Enter the Name');
                document.getElementById('txtsearchothers').focus();
                return false;
            }
        }
        }
        function checkAge() {
            if (document.getElementById('txtAge').value != '') {
                //                var RE_SSN = /^\d*[0-9](|\.\d*[0-9])-\d*[0-9](|\.\d*[0-9])-\d*[0-9](\.\d*[0-9])?$/;
                var RE_SSN = /^\d*[0-9]-\d*[0-9]?$/;
                if (RE_SSN.test(document.getElementById('txtAge').value)) {
                }
                else {
                    //alert("The drug frequency format provided is not valid. Please redefine the format(M-A-N)");
                    //document.getElementById('uIAdv_tFRQ').focus();
                    //return false;
                    document.getElementById('txtAge').value = '';
                    alert('Entered age combination is invalid !!');
                    document.getElementById('txtAge').focus();
                    return false;
                }
            }
        }
        function Checks() {
            //debugger;
            //document.getElementById('txtInvestigations').value = "";
            document.getElementById('trMobileNoList2').style.display = 'table-row';
        }
        function checkPatientLst() {
            document.getElementById('txtsearchothers').value = "";
            document.getElementById('trMobileNoList2').style.display = 'none';
            document.getElementById('divbday').style.display = 'none';
            checkPatientList();
        }
        function checkPatientList() {
         
//            document.getElementById('txtFrom').value = "";
//            document.getElementById('txtTo').value = "";
            document.getElementById('txtFrom').style.display = 'block';
            document.getElementById('txtTo').style.display = 'block';
            document.getElementById('lblFrom').style.display = 'block';
            document.getElementById('lblTo').style.display = 'block';
            document.getElementById('ImageButton1').style.display = 'block';
            document.getElementById('ImageButton2').style.display = 'block';
            document.getElementById('chkbday').checked = false;
            var orgid = document.getElementById('ddlOrganization').value;
            var FromDate = document.getElementById('txtFrom').value;
            var ToDate = document.getElementById('txtTo').value;
            if ($find('AutoCompleteExtender2') != null) {
                $find('AutoCompleteExtender2').set_contextKey(orgid + '~' + 'P' + '~' + 'N' + '~' + FromDate + '~' + ToDate);
            }
        }
        function checkClientList() {
                document.getElementById('txtFrom').style.display = 'none';
                document.getElementById('txtTo').style.display = 'none';
                document.getElementById('lblFrom').style.display = 'none';
                document.getElementById('lblTo').style.display = 'none';
                document.getElementById('ImageButton1').style.display = 'none';
                document.getElementById('ImageButton2').style.display = 'none';
             
            document.getElementById('txtsearchothers').value = "";
            document.getElementById('trMobileNoList2').style.display = 'none';
            document.getElementById('divbday').style.display = 'none';
            document.getElementById('chkbday').checked = false;
            var orgid = document.getElementById('ddlOrganization').value;
            var FromDate = document.getElementById('txtFrom').value;
            var ToDate = document.getElementById('txtTo').value;
            $find('AutoCompleteExtender2').set_contextKey(orgid + '~' + 'C' + '~' + 'N' + '~' + FromDate + '~' + ToDate);
        }
        function checkuserList() {
            
                document.getElementById('txtFrom').style.display = 'none';
                document.getElementById('txtTo').style.display = 'none';
                document.getElementById('lblFrom').style.display = 'none';
                document.getElementById('lblTo').style.display = 'none';
                document.getElementById('ImageButton1').style.display = 'none';
                document.getElementById('ImageButton2').style.display = 'none';
            
             
            document.getElementById('txtsearchothers').value = "";
            document.getElementById('trMobileNoList2').style.display = 'none';
            document.getElementById('divbday').style.display = 'none';
            document.getElementById('chkbday').checked = false;
            var orgid = document.getElementById('ddlOrganization').value;
            var FromDate = document.getElementById('txtFrom').value;
            var ToDate = document.getElementById('txtTo').value;
            
            $find('AutoCompleteExtender2').set_contextKey(orgid + '~' + 'U' + '~' + 'N' + '~' + FromDate + '~' + ToDate);
        }

        function checkHospitalList() {
            
                document.getElementById('txtFrom').style.display = 'none';
                document.getElementById('txtTo').style.display = 'none';
                document.getElementById('lblFrom').style.display = 'none';
                document.getElementById('lblTo').style.display = 'none';
                document.getElementById('ImageButton1').style.display = 'none';
                document.getElementById('ImageButton2').style.display = 'none';
            
             
            document.getElementById('txtsearchothers').value = "";
            document.getElementById('trMobileNoList2').style.display = 'none';
            document.getElementById('divbday').style.display = 'none';
            document.getElementById('chkbday').checked = false;
            var orgid = document.getElementById('ddlOrganization').value;
            var FromDate = document.getElementById('txtFrom').value;
            var ToDate = document.getElementById('txtTo').value;
            $find('AutoCompleteExtender2').set_contextKey(orgid + '~' + 'H' + '~' + 'N' + '~' + FromDate + '~' + ToDate);
        }
        function checkDoctorList() {
                document.getElementById('txtFrom').style.display = 'none';
                document.getElementById('txtTo').style.display = 'none';
                document.getElementById('lblFrom').style.display = 'none';
                document.getElementById('lblTo').style.display = 'none';
                document.getElementById('ImageButton1').style.display = 'none';
                document.getElementById('ImageButton2').style.display = 'none';
            
             
            document.getElementById('txtsearchothers').value = "";
            document.getElementById('trMobileNoList2').style.display = 'none';
            document.getElementById('divbday').style.display = 'block';
            var bday = 'N'
            if (document.getElementById('chkbday').checked) {
                bday = 'Y'
            }
            var orgid = document.getElementById('ddlOrganization').value;
            var FromDate = document.getElementById('txtFrom').value;
            var ToDate = document.getElementById('txtTo').value;
            $find('AutoCompleteExtender2').set_contextKey(orgid + '~' + 'D' + '~' + bday + '~' + FromDate + '~' + ToDate);
        }
        function checkTestList() {
//            document.getElementById('txtFrom').value = "";
//            document.getElementById('txtTo').value = "";
            document.getElementById('txtFrom').style.display = 'block';
            document.getElementById('txtTo').style.display = 'block';
            document.getElementById('lblFrom').style.display = 'block';
            document.getElementById('lblTo').style.display = 'block';
            document.getElementById('ImageButton1').style.display = 'block';
            document.getElementById('ImageButton2').style.display = 'block';

            document.getElementById('txtsearchothers').value = "";
            document.getElementById('trMobileNoList2').style.display = 'none';
            document.getElementById('divbday').style.display = 'none';
            document.getElementById('chkbday').checked = false;
            var orgid = document.getElementById('ddlOrganization').value;
            var FromDate = document.getElementById('txtFrom').value;
            var ToDate = document.getElementById('txtTo').value;
            $find('AutoCompleteExtender2').set_contextKey(orgid + '~' + 'T' + '~' + 'N' + '~' + FromDate + '~' + ToDate);
        }

        function checkvisitList() {
            debugger;
//            document.getElementById('txtFrom').value = "";
//            document.getElementById('txtTo').value = "";
            document.getElementById('txtFrom').style.display = 'block';
            document.getElementById('txtTo').style.display = 'block';
            document.getElementById('lblFrom').style.display = 'block';
            document.getElementById('lblTo').style.display = 'block';
            document.getElementById('ImageButton1').style.display = 'block';
            document.getElementById('ImageButton2').style.display = 'block';
            document.getElementById('txtsearchothers').value = "";
            document.getElementById('trMobileNoList2').style.display = 'none';
            document.getElementById('divbday').style.display = 'none';
            document.getElementById('chkbday').checked = false;
            var orgid = document.getElementById('ddlOrganization').value;
            var FromDate = document.getElementById('txtFrom').value;
            var ToDate = document.getElementById('txtTo').value;
            $find('AutoCompleteExtender2').set_contextKey(orgid + '~' + 'V' + '~' + 'N' + '~' + FromDate + '~' + ToDate);
        }
        
        function gettypes1() {
             
            var Types = document.getElementById('drpserviceType').value;
            var orgID = '<%# OrgID %>';
            $find('AutoCompleteExtender1').set_contextKey(orgID + '~' + Types);

        }
        function IAmSelected(source, eventArgs) {
            //debugger;
            document.getElementById('txtInvestigations').value = eventArgs.get_text();
            var s = eventArgs.get_value();
            document.getElementById('hdnInvestigationID').value = s.split('^')[0];
            document.getElementById('hdnType').value = s.split('^')[2];
        }
        function IAmselothers(sourch, eventArgs) {
            document.getElementById('txtsearchothers').value = eventArgs.get_text();

        }
        function DisplayTabMenu(tabName, SelectedValue) {
            DisplayTab(tabName);
            document.getElementById('drpnotification').value = SelectedValue;
        }
        function ClearAdvPatientserach() {
            document.getElementById('drpserviceType').value = '0'
            document.getElementById('txtInvestigations').value = "";
            document.getElementById('drpmartial').value = "0";
            //            document.getElementById('txtFromDate').value = "";
            //            document.getElementById('txtToDate').value = "";
            document.getElementById('txtSubject').value = "";
            document.getElementById('txtAge').value = "";
            document.getElementById('drpresulttype').value = "0";
            document.getElementById('ddlRegisterDate').value = "-1";
            //            document.getElementById('txtFromDate').style.display = 'block';
            //            document.getElementById('txtToDate').style.display = 'block';
        }
        function ClearAdvPatientserach1() {
            //document.getElementById('drpserviceType').value = '0'
            document.getElementById('txtInvestigations').value = "";
            document.getElementById('drpmartial').value = "0";
            //            document.getElementById('txtFromDate').value = "";
            //            document.getElementById('txtToDate').value = "";
            document.getElementById('txtSubject').value = "";
            document.getElementById('txtAge').value = "";
            document.getElementById('drpresulttype').value = "0";
            document.getElementById('ddlRegisterDate').value = "-1";
            //            document.getElementById('txtFromDate').style.display = 'block';
            //            document.getElementById('txtToDate').style.display = 'block';
        }
        function DisplayTab(tabName) {
              $('#TabsMenu li').removeClass('active');
            if (tabName == 'PWS') {
                document.getElementById('hdnSearchType').value = "PWS";
                //                document.getElementById('chkPatientList').checked = true;
                ClearAdvPatientserach();
                document.getElementById('patwise').style.display = 'table-cell';
                $('#li1').addClass('active');
                document.getElementById('chkEnterMobileNo').checked = false;
                document.getElementById('trMobileNoList1').style.display = 'table-row';
                document.getElementById('trMobileNoList2').style.display = 'none';
                document.getElementById('trEnterMobileNo').style.display = 'none';
                document.getElementById('tdinvestigation').style.display = 'none';
                //document.getElementById('AdvancedSearch').style.display = 'none';
                document.getElementById('drpnotification').value = "0";
                document.getElementById('drpnotification').disabled = false;
                document.getElementById('Td14').style.display = 'block';
                Clears();
                document.getElementById('hdntabs').value = 'Tab1';
                checkPatientList();
                //$('#<%# gvwNameList.ID %> table tbody tr').remove(); 
            }
            else if (tabName == 'DPS') {
            document.getElementById('hdnSearchType').value = "DPS";
                $('#li2').addClass('active');
                document.getElementById('patwise').style.display = 'none';
                document.getElementById('chkEnterMobileNo').checked = false;
                document.getElementById('trMobileNoList1').style.display = 'none';
                document.getElementById('trMobileNoList2').style.display = 'none';
                document.getElementById('trEnterMobileNo').style.display = 'none';
                //document.getElementById('AdvancedSearch').style.display = 'block';
                //  document.getElementById('gvwNameList').style.display = 'none';
                document.getElementById('Td14').style.display = 'block';
                document.getElementById('tdinvestigation').style.display = 'table-cell';
                document.getElementById('drpnotification').disabled = false;
                Clears();
                document.getElementById('hdntabs').value = 'Filters';
                document.getElementById('drpnotification').value = "0";
                //                $('#<%# gvwNameList.ID %> table tbody tr').remove();

               

            }
            else if (tabName == 'SS') {
            document.getElementById('hdnSearchType').value = "SS";
                $('#li3').addClass('active');
                ClearAdvPatientserach(); 
                document.getElementById('patwise').style.display = 'none';
                document.getElementById('chkEnterMobileNo').checked = true;
                document.getElementById('Td14').style.display = 'none';
                document.getElementById('trMobileNoList1').style.display = 'none';
                document.getElementById('trMobileNoList2').style.display = 'none';
                document.getElementById('trEnterMobileNo').style.display = 'table-row';
                document.getElementById('tdinvestigation').style.display = 'none';
                document.getElementById('drpnotification').value = "S";
                document.getElementById('drpnotification').disabled = true;
                //                $('#<%# gvwNameList.ID %> table tbody tr').remove();
                Clears();
                
            }


        }

        function validatesendsms(clientids, Patientid, mnumber, email) {
            if (document.getElementById(clientids).checked) {
                if (document.getElementById('drpnotification').value == "E" && email == '') {
                    alert('Please Enter EmailId');
                    document.getElementById(clientids).checked = false;
                    return false;
                }
                else if (document.getElementById('drpnotification').value == "S" && mnumber == '') {
                    alert('Please Enter Mobile No');
                    document.getElementById(clientids).checked = false;
                    return false;
                }
                else if (document.getElementById('drpnotification').value == "0" ) {
                    alert('Please Select the Notification Type');
                    document.getElementById(clientids).checked = false;
                    return false;
                }
                else if (document.getElementById('drpnotification').value == "S")
                {
                    var phoneno = /^\+?([0-9]{2})\)?[-. ]?([0-9]{4})[-. ]?([0-9]{4})$/;

                    if ((mnumber.match(phoneno))) {


                        document.getElementById('hdnmobileNos').value += Patientid + '~' + mnumber + '~' + email + '^';
                    
                          return true;
                                       }
                        else
                             {
                                 alert("Please Enter Valid Mobile Number");
                                 document.getElementById(clientids).checked = false;
                           return false;
                        }
                }
                else if (document.getElementById('drpnotification').value == "0" && mnumber == '' && email == '') {
                    alert('Please Enter Mobile No/Email Id');
                    document.getElementById(clientids).checked = false;
                    return false;
                }
                else {
                    document.getElementById('hdnmobileNos').value += Patientid + '~' + mnumber + '~' + email + '^';
                }
            }
            else {
                if (document.getElementById('hdnmobileNos').value != "") {
                    var s = document.getElementById('hdnmobileNos').value.split("^");
                    document.getElementById('hdnmobileNos').value = "";
                    if (s != "") {
                        for (var i in s) {
                            var parts = s[i].split('~')[0];
                            if (Patientid != parts && parts != "") {
                                document.getElementById('hdnmobileNos').value += s[i].split('~')[0] + '~' + s[i].split('~')[1] + '~' + s[i].split('~')[2] + '^';
                            }
                        }
                    }
                }
            }
        }

        function validateclientsendsms(clientids, Patientid, mnumber, email) {
            //debugger;
            if (document.getElementById(clientids).checked) {
                if (document.getElementById('drpnotification').value == "E" && email == '') {
                    alert('Please Enter EmailId');
                    document.getElementById(clientids).checked = false;
                    return false;
                }
                else if (document.getElementById('drpnotification').value == "S" && mnumber == '') {
                    alert('Please Enter Mobile No');
                    document.getElementById(clientids).checked = false;
                    return false;
                }
                else if (document.getElementById('drpnotification').value == "0" && mnumber == '' && email == '') {
                    alert('Please Enter Mobile No/Email Id');
                    document.getElementById(clientids).checked = false;
                    return false;
                }
                else {
                    document.getElementById('hdnClientMobile').value += Patientid + '~' + mnumber + '~' + email + '^';
                }
            }
            else {
                if (document.getElementById('hdnClientMobile').value != "") {
                    var s = document.getElementById('hdnClientMobile').value.split("^");
                    document.getElementById('hdnClientMobile').value = "";
                    if (s != "") {
                        for (var i in s) {
                            var parts = s[i].split('~')[0];
                            if (Patientid != parts && parts != "") {
                                document.getElementById('hdnClientMobile').value += s[i].split('~')[0] + '~' + s[i].split('~')[1] + '~' + s[i].split('~')[2] + '^';
                            }
                        }
                    }
                }
            }
        }

        function validateRefDocsendsms(clientids, Patientid, mnumber, email) {
             if (document.getElementById(clientids).checked) {
                if (document.getElementById('drpnotification').value == "E" && email == '') {
                    alert('Please Enter EmailId');
                    document.getElementById(clientids).checked = false;
                    return false;
                }
                else if (document.getElementById('drpnotification').value == "S" && mnumber == '') {
                    alert('Please Enter Mobile No');
                    document.getElementById(clientids).checked = false;
                    return false;
                }
                else if (document.getElementById('drpnotification').value == "0" && mnumber == '' && email == '') {
                    alert('Please Enter Mobile No/Email Id');
                    document.getElementById(clientids).checked = false;
                    return false;
                }
                else {
                    document.getElementById('hdnRefDocMobile').value += Patientid + '~' + mnumber + '~' + email + '^';
                }
            }
            else {
                if (document.getElementById('hdnRefDocMobile').value != "") {
                    var s = document.getElementById('hdnRefDocMobile').value.split("^");
                    document.getElementById('hdnRefDocMobile').value = "";
                    if (s != "") {
                        for (var i in s) {
                            var parts = s[i].split('~')[0];
                            if (Patientid != parts && parts != "") {
                                document.getElementById('hdnRefDocMobile').value += s[i].split('~')[0] + '~' + s[i].split('~')[1] + '~' + s[i].split('~')[2] + '^';
                            }
                        }
                    }
                }
            }
        }

        function CheckOnOff(rdoId, gridName, strSmsTemplate) {
            var all = document.getElementsByTagName("input");
            for (i = 0; i < all.length; i++) {
                if (all[i].type == "radio" && all[i].id != rdoId.id) {
                    var count = all[i].id.indexOf(gridName);
                    if (count != -1) {
                        all[i].checked = false;
                    }
                }
            }
            rdoId.checked = true;
            document.getElementById('txtSubject').value = strSmsTemplate.innerHTML;
        }
        function ShowMobileTextBox() {
            if (document.getElementById("chkEnterMobileNo").checked) {
                document.getElementById("trEnterMobileNo").style.display = "table-row";
                document.getElementById("trMobileNoList1").style.display = "none";
                //                document.getElementById("trMobileNoList2").style.display = "none";
            }
            else {
                document.getElementById("trEnterMobileNo").style.display = "none";
                document.getElementById("trMobileNoList1").style.display = "table-row";
                //                document.getElementById("trMobileNoList2").style.display = "block";
            }
        }
        function ShowRegDate() {
            document.getElementById('txtFromDate').value = "";
            document.getElementById('txtToDate').value = "";

            document.getElementById('hdnTempFrom').value = "";
            document.getElementById('hdnTempTo').value = "";

            document.getElementById('hdnTempFromPeriod').value = "0";
            document.getElementById('hdnTempToPeriod').value = "0";
            if (document.getElementById('ddlRegisterDate').value == "0") {

                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayWeek').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayWeek').value;

                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayWeek').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayWeek').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayMonth').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayMonth').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayMonth').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayMonth').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "2") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayYear').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayYear').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayYear').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayYear').value

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';

            }
            if (document.getElementById('ddlRegisterDate').value == "3") {
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'block';
                document.getElementById('divRegCustomDate').style.display = 'block';
                document.getElementById('divRegCustomDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'inline';
                document.getElementById('hdnTempFromPeriod').value = "1";
                document.getElementById('hdnTempToPeriod').value = "1";

            }
            if (document.getElementById('ddlRegisterDate').value == "-1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';


            }
            if (document.getElementById('ddlRegisterDate').value == "4") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';


            }

            if (document.getElementById('ddlRegisterDate').value == "5") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastWeekFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastWeekLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastWeekFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastWeekLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "6") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastMonthFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastMonthLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastMonthFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastMonthLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "7") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastYearFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastYearLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastYearFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastYearLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
        }
        function CheckFilters() {
            //debugger;
            if (document.getElementById('drpserviceType').value == '0') {
                alert('Select the Service Type');
                document.getElementById('drpserviceType').focus();
                return false;
            }

            if (document.getElementById('drpserviceType').value == 'INV') {
                if (document.getElementById('txtInvestigations').value.trim() == '') {
                    alert('Please Enter Investigation Type');
                    document.getElementById('txtInvestigations').focus();
                    return false;
                }
            }
            if (document.getElementById('drpserviceType').value == 'PRO') {
                var tst = document.getElementById('ddlProGrp').value;
                if (document.getElementById('ddlProGrp').value.trim() == '0') {
                    alert('Please Enter Protocol Type');
                    document.getElementById('ddlProGrp').focus();
                    return false;
                }
            }
        }
    </script>

    <style type="text/css">
        .btn
        {
            height: 26px;
        }
    </style>
</head>
<body>
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table class="w-100p">
                    <tr>
                        <td>
                            <asp:Panel ID="Panel7" CssClass="dataheader2 searchPanel" BorderWidth="1px" runat="server" meta:resourcekey="Panel7Resource1">
                                <table>
                                    <tr>
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="v-top" colspan="2">
                                                        <div id='TabsMenu' class="a-left">
                                                            <ul>
                                                                <li id="li1" class="active" onclick="DisplayTab('PWS')"><a href='#'><span>Customer/Employee
                                                                    Search</span></a></li>
                                                            <li id="li2" style="display:none"  onclick="DisplayTab('DPS')"><a href='#'><span>Advanced Patient Search</span></a></li>
                                                                <li id="li3" style="display:none" onclick="DisplayTab('SS')"><a href='#'><span>Random/Bulk SMS</span></a></li>
                                                            </ul>
                                                        </div>
                                                        <br />
                                                        <br />
                                                        <br />
                                                    </td>
                                                </tr>
                                                <tr class="a-center">
                                                    <td colspan="2">
                                                    <table ><tr style="width:100%">
                                                    <td  style="width:24%">
                                                        <asp:Label ID="Label7" Text="Select Notification Type" runat="server" meta:resourcekey="Label7Resource1"></asp:Label>
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:DropDownList ID="drpnotification" runat="server" CssClass="ddlsmall" meta:resourcekey="drpnotificationResource1">
                                                            <asp:ListItem Value="0" Text="--Select--" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                            <asp:ListItem Value="E" Text="Email" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                            <asp:ListItem Value="S" Text="Sms" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        </td>
                                                        
                                                        
                                                       <td style="width:20%"> 
                                                       <asp:Label ID="lblFrom" Text="From" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                                       <asp:TextBox Width="142px" ID="txtFrom" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                       
                                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" /><br />
                                                            <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtFrom"
                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                Enabled="True" />
                                                            <cc1:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                                ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                            <cc1:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtFrom"
                                                                Format="dd/MM/yyyy" PopupButtonID="ImageButton1" Enabled="True" />
                                                                
                                                               </td>
                                                                <td style="width:20%">
                                                                 <asp:Label ID="lblTo" Text="To" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                                                                  <asp:TextBox ID="txtTo" Width="125px" runat="server" meta:resourcekey="txtToResource1"
                                                                CssClass="Txtboxsmall"></asp:TextBox>
                                                           
                                                           <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" /><br />
                                                            <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtTo"
                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                Enabled="True" />
                                                            <cc1:MaskedEditValidator ID="MaskedEditValidator3" runat="server" ControlExtender="MaskedEditExtender3"
                                                                ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator3" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                            <cc1:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="txtTo"
                                                                Format="dd/MM/yyyy" PopupButtonID="ImageButton2" Enabled="True" /> 
                                                                </td>
                                              </tr></table>
                                                        </td>
                                                        
                                                            
                                                       
                                                          
                                                     
                                                    
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                        <ContentTemplate>
                                                            <%--<asp:UpdateProgress ID="upProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                                                                <ProgressTemplate>
                                                                    <div id="progressBackgroundFilter">
                                                                    </div>
                                                                    <div align="center" id="processMessage" style="width:15%">
                                                                        <asp:Label ID="Rs_Pleasewait1" Text="Please wait... " runat="server" Font-Bold="true"
                                                                            Font-Size="Larger" />
                                                                        <br />
                                                                        <br />
                                                                        <asp:Image ID="imgProgressbar1" runat="server" ImageUrl="~/Images/ProgressBar.gif" />
                                                                    </div>
                                                                </ProgressTemplate>
                                                                </asp:UpdateProgress>--%>
                                                            <td colspan="2" id="patwise" runat="server">
                                                                <asp:Panel ID="Panel1" runat="server" GroupingText="Search Options" meta:resourcekey="Panel1Resource1">
                                                                    <table class="bg-row">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblOrg" Text="Organization" runat="server" meta:resourcekey="lblOrgResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlOrganization" runat="server" AutoPostBack="True" CssClass="ddlsmall"
                                                                                    meta:resourcekey="ddlOrganizationResource1">
                                                                                </asp:DropDownList>
                                                                                <div id="chkmobile" runat="server" style="display: none;">
                                                                                    <asp:CheckBox ID="chkEnterMobileNo" Text="Enter Mobile Nos." runat="server" meta:resourcekey="chkEnterMobileNoResource1" />
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divbday" runat="server" style="display: none;">
                                                                                    <asp:CheckBox ID="chkbday" Text="Today's Birthday" runat="server" />
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr id="trMobileNoList1" style="display: table-row;" runat="server">
                                                                            <td id="Td1" runat="server">
                                                                                <asp:Label ID="lblUserType" Text="Type" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td id="Td2" runat="server">
                                                                                <table>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:RadioButton ID="chkPatientList" Text="Patient" runat="server" onclick="checkPatientLst();"
                                                                                                GroupName="checklist" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:RadioButton ID="chkClientList" Text="Client" runat="server" onclick="checkClientList();"
                                                                                                GroupName="checklist" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:RadioButton ID="chkUserList" Text="User" runat="server" onclick="checkuserList();"
                                                                                                GroupName="checklist" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:RadioButton ID="chkHospital" Text="Refer Hospital" runat="server" onclick="checkHospitalList();"
                                                                                                GroupName="checklist" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:RadioButton ID="chkdoctors" Text="Refering Doctor's" runat="server" onclick="checkDoctorList();"
                                                                                                GroupName="checklist" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:RadioButton ID="chktests" Text="Test Name" runat="server" onclick="checkTestList();"
                                                                                                GroupName="checklist" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:RadioButton ID="chkvisitno" Text="Visit Number" runat="server" onclick="checkvisitList();"
                                                                                                GroupName="checklist" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:TextBox ID="txtsearchothers" runat="server" CssClass="small" onfocus="Checktypes();" />
                                                                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtsearchothers"
                                                                                                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetSMSRecipientsList"
                                                                                                OnClientItemSelected="IAmselothers" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                                                DelimiterCharacters="" Enabled="True">
                                                                                            </cc1:AutoCompleteExtender>
                                                                                            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtsearchothers"
                                                                                                WatermarkText="Enter the Name">
                                                                                            </cc1:TextBoxWatermarkExtender>
                                                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:Button ID="btnsearchothers" runat="server" Text="Search" Style="cursor: pointer;"
                                                                                                CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                                                OnClick="btnsearchothers_Click" OnClientClick=" return CheckValues();" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                            <td id="Td3" runat="server">
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </tr>
                                                <tr>
                                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                        <ContentTemplate>
                                                            <td colspan="2" id="tdinvestigation" runat="server" style="display: none;">
                                                                <asp:Panel ID="pnlsearchdia" runat="server" GroupingText="Search Options" meta:resourcekey="pnlsearchdiaResource1">
                                                                    <table cellpadding="2" class="bg-row">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Label2" Text="Select Service Type" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="drpserviceType" runat="server" CssClass="ddlsmall" onChange="gettypes();"
                                                                                    meta:resourcekey="drpserviceTypeResource1" OnSelectedIndexChanged="drpserviceType_SelectedIndexChanged">
                                                                                    <asp:ListItem Value="0" Text="--Select--" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                                                    <asp:ListItem Value="INV" Text="Test"></asp:ListItem>
                                                                                    <asp:ListItem Value="PRO" Text="Protocol Group"></asp:ListItem>
                                                                                    <%-- <asp:ListItem Value="PKG" Text="Package" meta:resourcekey="ListItemResource7"></asp:ListItem>--%>
                                                                                    <asp:ListItem Value="Due" Text="Patient Due" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                                            </td>
                                                                            <td id="tdinvestigations" runat="server" style="display: none;">
                                                                                <asp:Label ID="Label1" Text="Enter the Investigations" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                                                                            </td>
                                                                            <td id="tdinvestigations1" runat="server" style="display: none;">
                                                                                <asp:TextBox ID="txtInvestigations" runat="server" CssClass="small" class="tb1"
                                                                                    meta:resourcekey="txtInvestigationsResource1" />
                                                                                <div id="aceDiv">
                                                                                </div>
                                                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtInvestigations"
                                                                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetOrgInvestigationsGroupandPKG"
                                                                                    OnClientItemSelected="IAmSelected" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                                    CompletionListElementID="aceDiv" OnClientShown="setAceWidth" DelimiterCharacters=""
                                                                                    Enabled="True">
                                                                                </cc1:AutoCompleteExtender>
                                                                            </td>
                                                                            <td id="tdinvestigations2" runat="server" style="display: none;">
                                                                                <asp:DropDownList ID="ddlProGrp" CssClass="ddlsmall" runat="server">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td id="tdresulttype" runat="server" style="display: none;">
                                                                                <asp:Label ID="Label3" Text="Result Type" runat="server" meta:resourcekey="Label3Resource1"></asp:Label>
                                                                            </td>
                                                                            <td id="tdresulttype1" runat="server" style="display: none;">
                                                                                <asp:DropDownList ID="drpresulttype" runat="server" CssClass="ddlsmall" meta:resourcekey="drpresulttypeResource1">
                                                                                    <asp:ListItem Value="0" Text="--Select--" meta:resourcekey="ListItemResource18"></asp:ListItem>
                                                                                    <asp:ListItem Value="N" Text="Normal" meta:resourcekey="ListItemResource19"></asp:ListItem>
                                                                                    <asp:ListItem Value="A" Text="AbNormal" meta:resourcekey="ListItemResource20"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr id="trresulttype2" runat="server" style="display: none;">
                                                                            <td>
                                                                                <asp:Label ID="lblClientName" Text="ClientName" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtClientName" CssClass="small" runat="server"></asp:TextBox>
                                                                                <div id="aceDiv1">
                                                                                </div>
                                                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtClientName"
                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                                                                                    ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True" UseContextKey="True"
                                                                                     CompletionListElementID="aceDiv1" OnClientShown="setAceWidth">
                                                                                </cc1:AutoCompleteExtender>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblRefPhyName" Text="RefPhyName" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtRefPhyName" runat="server" onFocus="return getrefhospid(this.id)"></asp:TextBox>
                                                                                <div id="aceDiv2">
                                                                                </div>
                                                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionSetCount="10" EnableCaching="false"
                                                                                    FirstRowSelected="true" MinimumPrefixLength="2" CompletionListElementID="aceDiv2"
                                                                                    ServiceMethod="GetRateCardForBilling" OnClientShown="setAceWidth" ServicePath="~/OPIPBilling.asmx"
                                                                                    OnClientItemOver="PhysicianTempSelected" TargetControlID="txtRefPhyName">
                                                                                </cc1:AutoCompleteExtender>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="Rs_RegisteredDate" runat="server" Text="Registered Date" meta:resourcekey="Rs_RegisteredDateResource1"></asp:Label>
                                                                            </td>
                                                                            <td colspan="3">
                                                                                <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                                                                                    CssClass="ddlsmall" runat="server" meta:resourcekey="ddlRegisterDateResource1">
                                                                                    <asp:ListItem Value="-1" Selected="True" meta:resourcekey="ListItemResource9">--Select--</asp:ListItem>
                                                                                    <asp:ListItem Value="0" meta:resourcekey="ListItemResource10">This Week</asp:ListItem>
                                                                                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource11">This Month</asp:ListItem>
                                                                                    <%--<asp:ListItem Value="2" meta:resourcekey="ListItemResource12">This Year</asp:ListItem>--%>
                                                                                    <asp:ListItem Value="3" meta:resourcekey="ListItemResource13">Custom Period</asp:ListItem>
                                                                                    <asp:ListItem Value="4" meta:resourcekey="ListItemResource14">Today</asp:ListItem>
                                                                                    <asp:ListItem Value="5" meta:resourcekey="ListItemResource15">Last Week</asp:ListItem>
                                                                                    <asp:ListItem Value="6" meta:resourcekey="ListItemResource16">Last Month</asp:ListItem>
                                                                                    <%-- <asp:ListItem Value="7" meta:resourcekey="ListItemResource17">Last Year</asp:ListItem>--%>
                                                                                </asp:DropDownList>
                                                                                <div id="divRegDate" style="display: none" runat="server">
                                                                                    <asp:Label ID="Rs_FromDate" runat="server" Text="From Date" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                                                    <asp:TextBox Width="70px" ID="txtFromDate" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                                                    <asp:Label ID="Rs_ToDate" runat="server" Text="To Date" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                                                    <asp:TextBox Width="70px" runat="server" ID="txtToDate" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                                                </div>
                                                                                <div id="divRegCustomDate" runat="server" style="display: none;">
                                                                                    <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate1Resource1"></asp:Label>
                                                                                    <asp:TextBox CssClass="small" ID="txtFromPeriod" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                                                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                        CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                                                    <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromPeriod"
                                                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                                        CultureTimePlaceholder="" Enabled="True" />
                                                                                    <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                                        ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromPeriod"
                                                                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                                                    <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                                                                                    <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                                                                    <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                        CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                                                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToPeriod"
                                                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                                        CultureTimePlaceholder="" Enabled="True" />
                                                                                    <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                                                        ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToPeriod"
                                                                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblVisitnumber" Text="VisitNumber" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtVisitNumber" CssClass="small" runat="server"></asp:TextBox>
                                                                            </td>
                                                                            <td id="Td10" runat="server">
                                                                                <asp:Label ID="Label4" Text="Gender" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td id="Td11" runat="server">
                                                                                <asp:DropDownList ID="drpmartial" runat="server" CssClass="ddlsmall">
                                                                                    <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                                                                                    <asp:ListItem Value="M" Text="Male"></asp:ListItem>
                                                                                    <asp:ListItem Value="F" Text="Female"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td id="Td12" runat="server">
                                                                                <asp:Label ID="Label5" Text="Age" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td id="Td13" runat="server">
                                                                                <asp:TextBox ID="txtAge" runat="server" CssClass="small" Onblur="checkAge();" />
                                                                                <asp:Label ID="Label6" Text="For eg: 25-30" runat="server" />
                                                                            </td>
                                                                            <%-- <tr id="trinvestigationid3" runat="server" style="display: none;">
                                                                                </tr>--%>
                                                                        </tr>
                                                                        <tr id="trbilling" runat="server" style="display: none;">
                                                                            <td id="Td4" runat="server">
                                                                                <asp:Label ID="Rs_PatientNo" Text="Patient No" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td id="Td5" runat="server">
                                                                                <asp:TextBox ID="txtPatientNo" runat="server" CssClass="small"></asp:TextBox>
                                                                                <cc1:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="filtxtPatientNo"
                                                                                    TargetControlID="txtPatientNo" Enabled="True">
                                                                                </cc1:FilteredTextBoxExtender>
                                                                            </td>
                                                                            <td id="Td6" runat="server">
                                                                                <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td id="Td7" runat="server">
                                                                                <asp:TextBox ID="txtPatientName" CssClass="small" runat="server"></asp:TextBox>
                                                                            </td>
                                                                            <td id="Td8" runat="server">
                                                                                <asp:Label ID="Rs_BillNo" Text="Bill No" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td id="Td9" runat="server">
                                                                                <asp:TextBox ID="txtBillNo" runat="server" CssClass="small"></asp:TextBox>
                                                                                <cc1:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="filtxtBillNo"
                                                                                    TargetControlID="txtBillNo" Enabled="True">
                                                                                </cc1:FilteredTextBoxExtender>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="6" class="a-center">
                                                                                <asp:Button ID="btn" runat="server" Style="cursor: pointer;" CssClass="btn" onmouseout="this.className='btn'"
                                                                                    onmouseover="this.className='btn btnhov'" Text="Search" OnClientClick=" return CheckFilters();Checks();"
                                                                                    OnClick="btn_Click" meta:resourcekey="btnResource1" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </tr>
                                                <tr>
                                                    <td id="Td14" class="v-top" runat="server" colspan="3">
                                                        <asp:Label ID="lblNameList" CssClass="colorforcontent" Text="MobileNo's / Email" runat="server" />
                                                    
                                                                               </td>
                                                </tr>
                                                <tr id="trMobileNoList2" style="display: none;" runat="server">
                                                    <td>
                                                    </td>
                                                    <td id="Td15" runat="server">
                                                        <asp:GridView ID="gvwNameList" AllowPaging="True" AutoGenerateColumns="False" 
                                                            CssClass="mytable1 gridView w-100p m-auto" ForeColor="#333333"  runat="server" OnPageIndexChanging="gvwNameList_PageIndexChanging"
                                                            OnRowDataBound="gvwNameList_RowDataBound" DataKeyNames="PatientID,MobileNumber"
                                                            EmptyDataText="No Matching Records"   PageSize="20">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle Font-Bold="False" />
                                                            <Columns>
                                                           
                                                               <%--<asp:TemplateField HeaderText="Sr.No">
                                                                <ItemTemplate>
                                                                <asp:Label ID="lblRowNumber" Text=' <%#Container.DataItemIndex+1 %>' runat="server" />
                                                                </ItemTemplate>
                                                                 </asp:TemplateField>--%>

                                                               
                                                                <asp:TemplateField HeaderText="S.No">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblPatientID" Text='<%# Bind("PatientID") %>' runat="server"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                               
                                                                <asp:TemplateField HeaderText="VisitNumber">
                                                                    <ItemTemplate>
                                                                        <%--<asp:Label ID="lblVisitNumber" Text='<%# Bind("PatientNumber") %>' runat="server"></asp:Label>--%>
                                                                        <asp:LinkButton ID="lnkbtnVisitNumber" runat="server" Text='<%#Eval("VisitNumber") %>'
                                                                            Style="color: Blue" OnClientClick='<%# String.Format("ShowPopUp({0});return false;",Eval("VisitNumber"))%> ' />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                 <asp:TemplateField HeaderText="ClientCode">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblClientId" runat="server" Text='<%# Bind("ClientCode") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblName" Text='<%# Bind("Name") %>' runat="server"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="MobileNumber">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblMobile" runat="server" Text='<%# Bind("MobileNumber") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="TotalDueAmt">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbldueamount" runat="server" Text='<%# Bind("TotalDueAmt") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Email">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblemail" runat="server" Text='<%# Bind("EMail") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Sex">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblSex" runat="server" Text='<%# Bind("SEX") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Age">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="ClientCode">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblClientId1" runat="server" Text='<%# Bind("ClientCode") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="ClientName">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblClientName" runat="server" Text='<%# Bind("ClientName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                
                                                                <asp:TemplateField HeaderText="ClientEmailId">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblClientEmailId" runat="server" Text='<%# Bind("ClientEmailId") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="ClientMobile">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblClientMobile" runat="server" Text='<%# Bind("ClientMobile") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="ReceivedAmount">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblReceivedAmount" runat="server" Text='<%# Bind("ReceivedAmount") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="BillNo">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblBillNo" runat="server" Text='<%# Bind("BillNo") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="TPASettledAmt">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTPASettledAmt" runat="server" Text='<%# Bind("TPASettledAmt") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Ref.Doctor Code">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRefDoctorCode" runat="server" Text='<%# Bind("RefDocCode") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Ref.Doctor Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRefDoctorName" runat="server" Text='<%# Bind("RefDocName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="RefDoc Mobile">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRefDocMobile" runat="server" Text='<%# Bind("RefDocMobile") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="RefDoc EmailId">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRefDocEmailId" runat="server" Text='<%# Bind("RefDocEmailId") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                
                                                                <asp:TemplateField HeaderText="Patient">
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkSelectNL" runat="server" />
                                                                        <asp:HiddenField ID="hdnSelect" Value='<%# Bind("PatientID") %>' runat="server" />
                                                                        <asp:HiddenField ID="hdnPatientType" Value='<%# Bind("PatientType") %>' runat="server" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Client">
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkSelectClient" runat="server" />
                                                                        <asp:HiddenField ID="hdnClientSelect" Value='<%# Bind("ClientId") %>' runat="server" />
                                                                        <asp:HiddenField ID="hdnPatientType1" Value='<%# Bind("PatientType") %>' runat="server" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="RefDoc">
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkSelectRefDoc" runat="server" />
                                                                        <asp:HiddenField ID="hdnRefDocSelect" Value='<%# Bind("RefDocCode") %>' runat="server" />
                                                                        <asp:HiddenField ID="hdnPatientType2" Value='<%# Bind("PatientType") %>' runat="server" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                                                                </asp:TemplateField>
                                                                <%--<asp:TemplateField HeaderText="LnNumber">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblPatientNumber" runat="server" Text='<%# Bind("PatientNumber") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>--%>
                                                                <asp:TemplateField HeaderText="VisitType">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblVisitType" runat="server" Text='<%# Bind("VisitType") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <%--<asp:TemplateField HeaderText="VisitDate">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblVisitDate" runat="server" Text='<%# Bind("VisitDate") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>--%>
                                                                 <asp:TemplateField HeaderText="TestName">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTestName" runat="server" Text='<%# Bind("Comments") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="TestStatus">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTestStatus" runat="server" Text='<%# Bind("BloodGroup") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                 <asp:TemplateField HeaderText="Select">
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkSelect" runat="server" />
                                                                        <%--<asp:HiddenField ID="hdnRefDocSelect" Value='<%# Bind("RefDocCode") %>' runat="server" />
                                                                        <asp:HiddenField ID="hdnPatientType2" Value='<%# Bind("PatientType") %>' runat="server" />--%>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                        </asp:GridView>
                                                        <div id="divFooterNav" runat="server" align="center">
                                                            <asp:Label ID="Label12" runat="server" Text="Page"></asp:Label>
                                                            <%--meta:resourcekey="Label1Resource1"--%>
                                                            <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                            <asp:Label ID="Label13" runat="server" Text="Of"></asp:Label>
                                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                            <asp:Button ID="Btn_Previous" runat="server" Text="Previous" OnClick="Btn_Previous_Click"
                                                                CssClass="btn" meta:resourcekey="Btn_PreviousResource1" Style="width: 71px" />
                                                            <asp:Button ID="Btn_Next" runat="server" Text="Next" OnClick="Btn_Next_Click" CssClass="btn"
                                                                meta:resourcekey="Btn_NextResource1" />
                                                            <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                            <asp:HiddenField ID="hdnPostBack" runat="server" />
                                                            <asp:HiddenField ID="hdnOrgID" runat="server" />
                                                            <asp:HiddenField ID="hdnPatientTypeSearch" runat="server" />
                                                            <asp:Label ID="Label14" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label14Resource1"></asp:Label>
                                                            <asp:TextBox ID="txtpageNo" runat="server" CssClass="w-30"   onkeypress="return ValidateOnlyNumeric(this);" 
                                                                meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                                            <asp:Button ID="Button1" runat="server" Text="Go" OnClientClick="javascript:return checkForValues();"
                                                                OnClick="btnGo_Click1" CssClass="btn" meta:resourcekey="btnGoResource1" />
                                                        </div>
                                                    </td>
                                                    <td id="Td16" runat="server">
                                                    </td>
                                                </tr>
                                                <tr id="trEnterMobileNo" style="display: none;" runat="server">
                                                    <td id="Td17" class="v-top"  runat="server">
                                                        <asp:Label ID="lbltext" Text="MobileNo's" runat="server" />
                                                    </td>
                                                    <td id="Td18" runat="server" class="v-top">
                                                        <asp:TextBox ID="txtMobileNo" ToolTip="Enter Comma ( , ) separated Mobile Numbers"
                                                            runat="server" TextMode="MultiLine" Rows="12" Width="700px"    onkeypress="return ValidateOnlyNumeric(this);"  ></asp:TextBox>
                                                        <span class="v-top">
                                                            <asp:Label ID="lblSMSTemplate" runat="server" />
                                                        </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:GridView ID="gvwSMSTemplate" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                            Visible="false"  CssClass="mytable1 gridView w-100p m-auto" ForeColor="#333333" 
                                                            OnRowDataBound="gvwSMSTemplate_RowDataBound" meta:resourcekey="gvwSMSTemplateResource1">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle Font-Bold="False" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                                    <ItemTemplate>
                                                                        <asp:RadioButton ID="rbSelectTL" GroupName="grpSelectTL" runat="server" meta:resourcekey="rbSelectTLResource1" />
                                                                        <asp:HiddenField ID="hdnTemplateID" runat="server" Value='<%# Bind("TemplateID") %>' />
                                                                    </ItemTemplate>
                                                                    <ItemStyle CssClass="a-left w-15" Wrap="False" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="SMS Text Template" meta:resourcekey="TemplateFieldResource2">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblSMSTemplate" runat="server" Text='<%# Bind("Template") %>' Width="700px"
                                                                            meta:resourcekey="lblSMSTemplateResource2"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle CssClass="a-left w-50" Wrap="False" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <PagerStyle CssClass="dataheader1 a-center"  />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="v-top" >
                                                        <asp:Label ID="lblSubject" runat="server" Text="Message" meta:resourcekey="lblSubjectResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtSubject" runat="server" Height="100px" TextMode="MultiLine" Width="700px"
                                                            meta:resourcekey="txtSubjectResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-center" colspan="2">
                                                        <asp:Button ID="btnSend" runat="server" ToolTip="Click here to Send SMS" Style="cursor: pointer;"
                                                            CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                            Text="Send" OnClick="btnSend_Click" meta:resourcekey="btnSendResource1" OnClientClick="return CheckNotifytype();" />
                                                        <asp:HiddenField ID="hdnmobileNos" runat="server" />
                                                        <asp:HiddenField ID="hdnemailids" runat="server" />
                                                        <asp:HiddenField ID="hdnClientMobile" runat="server" />
                                                        <asp:HiddenField ID="hdnRefDocMobile" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
                </div>
            </ContentTemplate>
            <%--<Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlOrganization" EventName="SelectedIndexChanged" />
                            </Triggers>--%>
        </asp:UpdatePanel>
        <asp:HiddenField ID="hdnType" runat="server" />
        <asp:HiddenField ID="hdnFirstDayWeek" runat="server" />
        <asp:HiddenField ID="hdnLastDayWeek" runat="server" />
        <asp:HiddenField ID="hdnFirstDayMonth" runat="server" />
        <asp:HiddenField ID="hdnLastDayMonth" runat="server" />
        <asp:HiddenField ID="hdnFirstDayYear" runat="server" />
        <asp:HiddenField ID="hdnLastDayYear" runat="server" />
        <asp:HiddenField ID="hdnDateImage" runat="server" />
        <asp:HiddenField ID="hdnTempFrom" runat="server" />
        <asp:HiddenField ID="hdnTempTo" runat="server" />
        <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
        <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
        <asp:HiddenField ID="hdnLastMonthFirst" runat="server" />
        <asp:HiddenField ID="hdnLastMonthLast" runat="server" />
        <asp:HiddenField ID="hdnLastWeekFirst" runat="server" />
        <asp:HiddenField ID="hdnLastWeekLast" runat="server" />
        <asp:HiddenField runat="server" ID="hdnLastYearFirst" />
        <asp:HiddenField ID="hdnLastYearLast" runat="server" />
        <asp:HiddenField ID="hdnActionCount" runat="server" />
        <asp:HiddenField ID="hdnInvestigationID" runat="server" Value="0" />
        <asp:HiddenField ID="hdnInvestValue" runat="server" />
        <asp:HiddenField ID="hdntabs" runat="server" />
        <asp:HiddenField ID="hdnSearchType" runat="server" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
   

    <script language="javascript" type="text/javascript">
        function gettypes() {
            //debugger;
            var Types = document.getElementById('drpserviceType').value;
            if (Types == 'Due') {
                document.getElementById('trbilling').style.display = 'table-row';
                document.getElementById('tdinvestigations').style.display = 'none';
                document.getElementById('tdresulttype').style.display = 'none';
                document.getElementById('tdinvestigations1').style.display = 'none';
                document.getElementById('tdinvestigations2').style.display = 'none';
                document.getElementById('tdresulttype1').style.display = 'none';
                document.getElementById('trresulttype2').style.display = 'none';
                //document.getElementById('trinvestigationid3').style.display = 'none';
                document.getElementById('Td10').style.display = 'none';
                document.getElementById('Td11').style.display = 'none';
                document.getElementById('Td12').style.display = 'none';
                document.getElementById('Td13').style.display = 'none';
                document.getElementById('txtPatientNo').value = '';
                document.getElementById('txtBillNo').value = '';
                document.getElementById('txtAge').value = '';
                document.getElementById('txtInvestigations').value = '';
                document.getElementById('txtAge').value = '';
                document.getElementById('txtPatientName').value = '';
            }
            else if (Types == 'INV') {
                document.getElementById('trbilling').style.display = 'none';
                document.getElementById('tdinvestigations').style.display = 'table-cell';
                document.getElementById('tdresulttype').style.display = 'table-cell';
                document.getElementById('tdinvestigations1').style.display = 'table-cell';
                document.getElementById('tdinvestigations2').style.display = 'none';
                document.getElementById('trresulttype2').style.display = 'table-row';
                document.getElementById('tdresulttype1').style.display = 'table-cell';
                //document.getElementById('trinvestigationid3').style.display = 'block';
                document.getElementById('Td10').style.display = 'table-cell';
                document.getElementById('Td11').style.display = 'table-cell';
                document.getElementById('Td12').style.display = 'table-cell';
                document.getElementById('Td13').style.display = 'table-cell';
                document.getElementById('txtPatientNo').value = '';
                document.getElementById('txtBillNo').value = '';
                document.getElementById('txtAge').value = '';
                ///document.getElementById('txtInvestigations').value = '';
                document.getElementById('txtAge').value = '';
                document.getElementById('txtPatientName').value = '';
                var orgID = '<%= OrgID %>';
                if ($find('AutoCompleteExtender1') != null) {
                    $find('AutoCompleteExtender1').set_contextKey(orgID + '~' + Types);
                }
            }
            else if (Types == 'PRO') {
                document.getElementById('trbilling').style.display = 'none';
                document.getElementById('tdinvestigations').style.display = 'table-cell';
                document.getElementById('tdresulttype').style.display = 'table-cell';
                document.getElementById('tdinvestigations1').style.display = 'none';
                document.getElementById('tdinvestigations2').style.display = 'table-cell';
                document.getElementById('tdresulttype1').style.display = 'table-cell';
                document.getElementById('trresulttype2').style.display = 'table-row';
                //document.getElementById('trinvestigationid3').style.display = 'block';
                document.getElementById('txtPatientNo').value = '';
                document.getElementById('txtBillNo').value = '';
                document.getElementById('txtAge').value = '';
                //document.getElementById('txtInvestigations').value = '';
                document.getElementById('txtAge').value = '';
                document.getElementById('txtPatientName').value = '';
            }
            else {
                document.getElementById('trbilling').style.display = 'none';
                document.getElementById('tdinvestigations').style.display = 'none';
                document.getElementById('tdresulttype').style.display = 'none';
                document.getElementById('tdinvestigations1').style.display = 'none';
                document.getElementById('tdinvestigations2').style.display = 'none';
                document.getElementById('tdresulttype1').style.display = 'none';
                document.getElementById('trresulttype2').style.display = 'none';
                //document.getElementById('trinvestigationid3').style.display = 'block';
                document.getElementById('txtPatientNo').value = '';
                document.getElementById('txtBillNo').value = '';
                document.getElementById('txtAge').value = '';
                //document.getElementById('txtInvestigations').value = '';
                document.getElementById('txtAge').value = '';
                document.getElementById('txtPatientName').value = '';
            }



        }
        function CheckNotifytype() {
            //debugger;
                if (document.getElementById('drpnotification').value == "0") {
                alert('Select the Notification Type');
                return false;
                document.getElementById('drpnotification').focus();
            }
            if (document.getElementById('chkEnterMobileNo').checked == true) {
                if (document.getElementById('txtMobileNo').value.trim() == "") {
                    alert('Enter Mobile Number(s)');
                    document.getElementById('txtMobileNo').focus();
                    return false;
                }
                if (document.getElementById('hdnSearchType').value == "SS") {
                    var evt = document.getElementById('txtMobileNo').value
                    var numbers = /^[0-9, ]+$/;
                    if (document.getElementById('txtMobileNo').value.match(numbers)) {
                        return true;
                    }
                    else {
                        alert('Please Enter Valid Numbers');
                        return false;
                    }
                }
            }
            else {
                if (document.getElementById('drpnotification').value == "S") {
                    var test = document.getElementById('hdnSearchType').value;
                    if (document.getElementById('hdnSearchType').value != "DPS") {
                        var mobileNos = document.getElementById('hdnmobileNos').value;
                        var sup = mobileNos.split('^');
                        if (sup[0] == "") {
                            alert('Select/Enter Mobile Number(s)');
                            return false;
                        }
                    }
                    if (document.getElementById('hdnSearchType').value == "DPS") {
                        var mobileNos = document.getElementById('hdnmobileNos').value;
                        var ClientmobileNos = document.getElementById('hdnClientMobile').value;
                        var RefmobileNos = document.getElementById('hdnRefDocMobile').value;
                        if (mobileNos == "" && ClientmobileNos == "" && RefmobileNos == "") {
                            alert('Select/Enter Mobile Number(s)');
                            return false;
                        }
                    }
                    if (document.getElementById('hdnSearchType').value == "PWS") {
                        var mobileNos = document.getElementById('hdnmobileNos').value;

                        if (mobileNos == "") {
                            alert('Select/Enter Mobile Number(s)');
                            return false;
                        }

                    }
                }

                else {
                    if (document.getElementById('drpnotification').value == "E") {
                        if (document.getElementById('hdnSearchType').value == "PWS") {
                            var EmailId = document.getElementById('hdnmobileNos').value;
                            //var email=EmailId.split
                            if (EmailId == "") {
                                alert('Select/Enter EmailId');
                                return false;
                            }
                        }
                        else if (document.getElementById('hdnSearchType').value == "DPS") {
                            var EmailId = document.getElementById('hdnClientMobile').value;
                            var RefDocEmail = document.getElementById('hdnRefDocMobile').value;
                            var patEmailId = document.getElementById('hdnmobileNos').value;
                            if (EmailId == "" && RefDocEmail == "" && patEmailId == "") {
                                alert('Select/Enter EmailId');
                                return false;
                            }
                        }
                    }
                }
            }
            
            
            if (document.getElementById('txtSubject').value.trim() == "") {
                alert('Select/Enter Subject');
                document.getElementById('txtSubject').focus();
                return false;
            }
            
        }
    </script>

    <script language="javascript" type="text/javascript">
        function setAceWidth(source, eventArgs) {
            document.getElementById('aceDiv').style.width = 'auto';
            document.getElementById('aceDiv1').style.width = 'auto';
            document.getElementById('aceDiv2').style.width = 'auto';
        }
    </script>

    </form>
</body>
</html>
