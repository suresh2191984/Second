<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientsRegistration.aspx.cs"
    Inherits="Reception_PatientsRegistration" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/URNControl.ascx" TagName="URNControl" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="~/CommonControls/SmartCard.ascx" TagName="SmartCard" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/EmployerRegDetail.ascx" TagName="EmployerRegDetail"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/PatientAddress.ascx" TagName="PatientAddress"
    TagPrefix="uc12" %>
<%@ Register Src="~/CommonControls/Qualification.ascx" TagName="Qualification" TagPrefix="uc13" %>
<%@ Register Src="~/CommonControls/DonorCard.ascx" TagName="ucDonorCard" TagPrefix="uc25" %>
<%@ Register Src="~/CommonControls/ValidationMesseage.ascx" TagName="ucMandatory"
    TagPrefix="uc120" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Registration</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/PatientsRegistration.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <link href="../StyleSheets/StyleSheet.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function ShowAlertMsg(key) {

            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
            }
            else if (key == "Reception\\PatientRegistration.aspx.cs_7") {
                alert('Patient number already exits');
            }

            else if (key == "Reception\\PatientRegistration.aspx_25") {
                alert('Provide Approved By ');
            }
            else if (key == "Reception\\PatientRegistration.aspx_26") {
                alert('Donor registered successfully');
            }
            else if (key == "Reception\\PatientRegistration.aspx_27") {
                alert('There was a problem in Save Billing Details.');
            }
            else if (key == "Reception\\PatientRegistration.aspx.cs_10") {
                alert('The patient details with same name and contact details already exist. Provide the changes and retry.');
            }

            return true;
        }

        function showResponse() {
            // showResponses('divEmp1', 'divEmp2', 'divEmployer', 1);
            ShowPatientType();
        }

        function expandTextBox(id) {
            document.getElementById(id).rows = "5";
            document.getElementById(id).cols = "23";
            ConverttoUpperCase(id);
        }
        function collapseTextBox(id) {
            document.getElementById(id).rows = "1";
            document.getElementById(id).cols = "23";
            ConverttoUpperCase(id);

        }
        function blacknumber(e) {

            if ((e.keyCode >= 97 && e.keyCode <= 122) || (e.keyCode >= 65 && e.keyCode <= 90) || (e.keyCode == 32) || (e.keyCode == 46)) {
                return true;
            }
            else {
                e.keyCode = 0;
            }


        }
        function showdrugothers(id) {
            var cboxObj = document.getElementById(id);
            var cboxList = cboxObj.getElementsByTagName('input');

            var lbList = cboxObj.getElementsByTagName('label');

            var divid = 'divddlDrugs_34';
            for (var i = 0; i < cboxList.length; i++) {
                if (cboxList[i].checked) {

                    if (lbList[i].innerHTML == "Others") {

                        document.getElementById(divid).style.display = 'block';
                    }
                    else {

                        document.getElementById(divid).style.display = 'none';
                    }
                }
            }
        }
        function validate(bid) {
            $get(bid).disabled = true;
            javascript: __doPostBack(bid, '');
        }
        function fnChkDayCare(chkid) {
            var objDay = document.getElementById('chkDayCare');
            var objAdmit = document.getElementById('chkBox');
            var objDonor = document.getElementById('chkDonor');
            if (chkid == 'chkDayCare' && objDay.checked == true) {
                objAdmit.checked = false;
                objDonor.checked = false;
            }
            else if (chkid == 'chkBox' && objAdmit.checked == true) {
                if (objDay != null) {
                    objDay.checked = false;
                }
                objDonor.checked = false;
            }
            else if (chkid == 'chkDonor' && objDonor.checked == true) {
                if (objDay != null) {
                    objDay.checked = false;
                }
                objAdmit.checked = false;
            }
        }
        function validate() {
            var textBoxToValidate = document.getElementById('txtName');
            var r = /^[0-9a-zA-Z ]+$/;
            if (textBoxToValidate.value == '') {

            }

            else if (textBoxToValidate.value.match('^[a-zA-Z].*')) {

                if (textBoxToValidate.value.match('^[a-zA-Z0-9 ]+$')) {
                    return true;
                }

            }
            else {
                var userMsg = SListForApplicationMessages.Get('Reception\\PatientRegistration.aspx_11');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('The first character of the name must be a letter');
                    return false;
                }
                document.getElementById('txtName').value = '';
                document.getElementById('txtName').focus();
                return false;
            }


        }
        function showfoodothers(id) {
            var cboxObj = document.getElementById(id);
            var cboxList = cboxObj.getElementsByTagName('input');
            var lbList = cboxObj.getElementsByTagName('label');
            var divid = 'divddlFoodType_37';
            for (var i = 0; i < cboxList.length; i++) {
                if (cboxList[i].checked) {
                    if (lbList[i].innerHTML == "Others") {

                        document.getElementById(divid).style.display = 'block';
                    }
                    else {
                        document.getElementById(divid).style.display = 'none';
                    }
                }
            }
        }
        function showContentHis(id) {

            var chkvalue = id;
            var ddl = id.split('_');
            var divid = 'divchkDrugs_1061';
            if (document.getElementById(id).checked == true) {
                document.getElementById(divid).style.display = 'block';
            }
            else {
                document.getElementById(divid).style.display = 'none';
            }
        }

        function showContent(id) {
            var chkvalue = id;
            var ddl = id.split('_');
            var divid = 'divchkFood_1062';
            if (document.getElementById(id).checked == true) {
                document.getElementById(divid).style.display = 'block';
            }
            else {
                document.getElementById(divid).style.display = 'none';
            }
        }
        function pageLoad() {
            if (document.getElementById('txtPatientNo').disabled == false) {
                document.getElementById('ddSalutation').focus();
            }
            //            else {
            //                document.getElementById('ddSalutation').focus();
            //            }
            if (document.getElementById('tDOB').value != '') {
                countAge('tDOB');
            }
            if (document.getElementById('hdnIsCorpOrg').value == 'Y') {
                document.getElementById('uctrlEmployer_TextBoxURN').focus();
            }
        }
        function getDOB() {
            if (document.getElementById('txtDOBNos').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\PatientRegistration.aspx_2');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Provide age in (days or weeks or months or year) & choose appropriate from the list');
                    return false;
                }
                document.getElementById('txtDOBNos').focus();
                return false;
            }
            return true;
        }
        function SetTxtName() { document.getElementById('txtName').focus(); }
        function ClearDOB() {
            var currentTime;
            if (document.getElementById('txtDOBNos').value <= 0) {
                document.getElementById('txtDOBNos').value = '';
            }
            //            if (document.getElementById('tDOB').value == '') {
            //            }
            //            else if (document.getElementById('tDOB').value != '') {
            //                document.getElementById('txtDOBNos').value = '';
            //            }
            //            else if (document.getElementById('txtDOBNos').value == '') {
            //            }
            //            else if (document.getElementById('txtDOBNos').value != '') {
            //                document.getElementById('tDOB').value = '';
            //            }
            if (document.getElementById('ddlDOBDWMY').value == 'Y') {

                if (document.getElementById('txtDOBNos').value >= 150) {
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientRegistration.aspx_3');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    }
                    else {
                        alert('Provide a valid year');
                        return false;
                    }
                    document.getElementById('txtDOBNos').value = '';
                    document.getElementById('txtDOBNos').focus();
                    return false;
                }
                //                currentTime = new Date(); 
                //                var yr = currentTime.getFullYear();
                //                var givenyr = document.getElementById('txtDOBNos').value;
                //                var dobyear = yr - givenyr;
                //                alert('dobyear : ' + dobyear);
            }
            if (document.getElementById('ddlDOBDWMY').value == 'M') {

                if (document.getElementById('txtDOBNos').value >= 2500) {
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientRegistration.aspx_4');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    }
                    else {
                        alert('Provide a valid month');
                        return false;
                    }
                    document.getElementById('txtDOBNos').value = '';
                    document.getElementById('txtDOBNos').focus();
                    return false;
                }
            }
        }
        function URNchecking() {
            //    if (document.getElementById('hdnTOrg').value == 'Y') {
            //        if (document.getElementById('URNControl1_txtURNo').value == '') {
            //            alert('Enter URNumber');
            //            document.getElementById('URNControl1_txtURNo').focus();
            //            return false;
            //        }
            //    }
        }

        function GetPatientDetails(PID) {

            if (PID != '') {
                var pID = PID.split('~');

                //            alert("Se"+PID.search('~'));
                //            alert(pID.length);
                //Venkat (27 Year(s))-(Urn NO :~12

                if (pID.length > 1) {
                    functionClear();
                    document.getElementById('hdnPatientID').value = '';

                    document.getElementById('hdnPatientID').value = pID[1];
                    var name = PID.split('(');
                    document.getElementById('txtName').value = name[0];
                    SetSmartNo(pID[2]);
                    if (document.getElementById('hdnPatientID').value != '') {
                        pID = document.getElementById('hdnPatientID').value;
                        WebService.GetPatientDetails(pID, OrgID, OnPatientProcesComplete);

                    }
                }
                else {
                    var Smartnumber = document.getElementById('hdnSmardno').value;
                    SetSmartNo(Smartnumber);
                    // functionClear();
                    document.getElementById('hdnPatientID').value = '';
                    document.getElementById("txtPatientNo").value = '';
                }


            }
        }
        function functionClear() {
            //document.getElementById("txtPatientName").value = '';
            document.getElementById("tDOB").value = '';
            document.getElementById("URNControl1_txtURNo").value = '';
            document.getElementById("URNControl1_ddlUrnoOf").value = '1';
            document.getElementById("URNControl1_ddlUrnType").value = '0';
            document.getElementById("URNControl1_ddlUrnType").value = '0';
            //document.getElementById("txtEmailID").value = '';
            document.getElementById("ucPAdd_txtAddress1").value = '';

            document.getElementById('txtDOBNos').value = '';

            document.getElementById('ddlDOBDWMY').value = 'Y';

            //pAddress = patientList[0].PatientAddress[1];
            document.getElementById("ucPAdd_txtAddress1").value = '';
            document.getElementById("ucPAdd_txtAddress2").value = '';
            document.getElementById("ucPAdd_txtAddress3").value = '';
            //document.getElementById("ucPAdd_txtCity").value = '';

            document.getElementById("ucPAdd_txtPostalCode").value = '';
            document.getElementById("ucPAdd_txtMobile").value = '';
            document.getElementById("ucPAdd_txtLandLine").value = '';
            //document.getElementById("ucPAdd_ddState").value = '';
            //document.getElementById("ucPAdd_ddCountry").options[document.getElementById("ucPAdd_ddCountry").selectedIndex].value = patientList[0].PatientAddress[0].CountryID;
            //document.getElementById("ucPAdd_ddCountry").value = '0';

            //document.getElementById(ddl).options[document.getElementById(ddl).selectedIndex].innerHTML

            //document.getElementById('ddSalutation').value = '1';
            ////document.getElementById('ddSex').value = 'M';

            document.getElementById("ddRace").value = '1';

            //document.getElementById("txtEmailID").value = '';
            //document.getElementById("ddCountry").value = 0;
            //document.getElementById("ddCountry").value = 0;



        }
        function dateformatchange(dateFormat) {
            var today = new Date();
            var dd = dateFormat.getDate();
            var mm = dateFormat.getMonth() + 1; //January is 0!
            var yyyy = dateFormat.getFullYear();
            if (dd < 10) { dd = '0' + dd }
            if (mm < 10) { mm = '0' + mm }
            var fmt = dd + '/' + mm + '/' + yyyy;
            if (fmt != '01/01/1800') {
                return fmt;
            }
            else {
                return '';
            }
        }
        function OnPatientProcesComplete(patientList) {

            if (patientList.length > 0) {

                document.getElementById("txtName").value = patientList[0].Name;
                //alert(patientList[0].DOB);
                var nowdt = new Date();
                nowdt = patientList[0].DOB;
                document.getElementById("hdnPatientNo").value = patientList[0].PatientNumber;
                var pDOB = dateformatchange(nowdt);
                document.getElementById("tDOB").value = pDOB;
                document.getElementById("URNControl1_txtURNo").value = patientList[0].URNO;
                document.getElementById("tAlias").value = patientList[0].AliasName;
                document.getElementById("URNControl1_ddlUrnoOf").value = patientList[0].URNofId;
                document.getElementById("URNControl1_ddlUrnType").value = patientList[0].URNTypeId;
                document.getElementById("txtEmail").value = patientList[0].EMail;
                document.getElementById("txtPatientNo").value = patientList[0].PatientNumber;

                var nowdt1 = new Date();
                nowdt1 = patientList[0].URNEXPDate;
                var pDOB1 = dateformatchange(nowdt1);
                if (pDOB1 != '01/01/1') {
                    document.getElementById("URNControl1_txtValidate").value = pDOB1;
                }
                else {
                    document.getElementById("URNControl1_txtValidate").value = '';
                }

                //alert(patientList[0].PatientAge);
                var ageUnit = patientList[0].PatientAge;
                var age = ageUnit.split(' ');
                document.getElementById("txtDOBNos").value = age[0];
                document.getElementById('ddlDOBDWMY').value = age[1] == "" ? 'Y' : age[1].substring(0, 1);

                document.getElementById('ddMarital').value = patientList[0].MartialStatus.substring(0, 1);
                document.getElementById('txtRelation').value = patientList[0].RelationName;
                document.getElementById('txtPlaceOfBirth').value = patientList[0].PlaceOfBirth;
                document.getElementById('txtOccupation').value = patientList[0].OCCUPATION;
                if (document.getElementById('hdnIsCorpOrg').value == 'Y') {
                }
                else {
                    document.getElementById('ddBloodGrp').value = patientList[0].BloodGroup;
                }
                document.getElementById('ddlReligion').value = patientList[0].Religion;

                if (patientList[0].PersonalIdentification != null) {
                    var identification = patientList[0].PersonalIdentification.split('~');
                    document.getElementById('txtIdentification1').value = identification[0];
                    document.getElementById('txtIdentification2').value = identification[1]
                }

                if (patientList[0].PatientAddress[0].AddressType == "C") {
                    var CityCode = patientList[0].PatientAddress[1].StateCode;
                    document.getElementById("ucPAdd_txtAddress1").value = patientList[0].PatientAddress[1].Add2;
                    document.getElementById("ucPAdd_txtAddress2").value = patientList[0].PatientAddress[1].Add1;
                    document.getElementById("ucPAdd_txtAddress3").value = patientList[0].PatientAddress[1].Add3;

                    document.getElementById("ucPAdd_ddCountry").value = patientList[0].PatientAddress[1].CountryCode;

                    loadState(document.getElementById("ucPAdd_ddState").id, patientList[0].PatientAddress[1].StateCode);
                    loadCity(document.getElementById("ucPAdd_ddlCity").id, patientList[0].PatientAddress[1].CityCode, patientList[0].PatientAddress[1].StateCode);
                    loadDis(document.getElementById("ucPAdd_ddlDistricts").id, patientList[0].PatientAddress[1].AddLevel1, patientList[0].PatientAddress[1].CityCode);
                    loaLocality(document.getElementById("ucPAdd_ddllocalities").id, patientList[0].PatientAddress[1].AddLevel2, patientList[0].PatientAddress[1].AddLevel1);
                    document.getElementById("ucPAdd_txtPostalCode").value = patientList[0].PatientAddress[1].PostalCode;
                    document.getElementById("ucPAdd_txtMobile").value = patientList[0].PatientAddress[1].MobileNumber;
                    document.getElementById("ucPAdd_txtLandLine").value = patientList[0].PatientAddress[1].LandLineNumber;
                    document.getElementById("ucPAdd_txtOtherCountry").value = patientList[0].PatientAddress[1].OtherCountryName;
                    document.getElementById("ucPAdd_txtOtherState").value = patientList[0].PatientAddress[1].OtherStateName;

                }
                else {

                    document.getElementById("ucPAdd_txtAddress1").value = patientList[0].PatientAddress[0].Add1;
                    document.getElementById("ucPAdd_txtAddress2").value = patientList[0].PatientAddress[0].Add2;
                    document.getElementById("ucPAdd_txtAddress3").value = patientList[0].PatientAddress[0].Add3;
                    document.getElementById("ucPAdd_ddlCity").value = patientList[0].PatientAddress[0].City;
                    document.getElementById("txtMobile").value = patientList[0].PatientAddress[0].MobileNumber;
                    document.getElementById("txtLandLine").value == patientList[0].PatientAddress[0].LandLineNumber;


                    document.getElementById("ucPAdd_txtPostalCode").value = patientList[0].PatientAddress[0].PostalCode;
                    document.getElementById("ucPAdd_txtMobile").value = patientList[0].PatientAddress[0].MobileNumber;
                    document.getElementById("ucPAdd_txtLandLine").value = patientList[0].PatientAddress[0].LandLineNumber;
                    document.getElementById("ucPAdd_ddState").value = patientList[0].PatientAddress[0].StaateKey;
                    document.getElementById("ucPAdd_ddCountry").value = patientList[0].PatientAddress[1].CountryCode;
                    document.getElementById("ucPAdd_txtOtherCountry").value = patientList[0].PatientAddress[0].OtherCountryName;
                    document.getElementById("ucPAdd_txtOtherState").value = patientList[0].PatientAddress[0].OtherStateName;

                }
                //document.getElementById(ddl).options[document.getElementById(ddl).selectedIndex].innerHTML

                document.getElementById('ddSalutation').value = patientList[0].TITLECode;
                document.getElementById('ddSex').value = patientList[0].SEX == '' ? '0' : patientList[0].SEX;

                document.getElementById("ddRace").value = patientList[0].Race == '' ? '0' : patientList[0].Race;
                if (patientList[0].MetaTypeID != null && patientList[0].MetaTypeID != '')
                    document.getElementById("Qualification_ddlQualification").value = patientList[0].MetaTypeID;
                else {
                    document.getElementById("Qualification_ddlQualification").value = 0;
                    var select = document.getElementById("Qualification_ddlDescriptions");
                    for (i = 1; i < select.options.length; i++) {
                        select.options[i] = null;
                    }
                    document.getElementById("Qualification_ddlDescriptions").value = 0;
                }
                if (patientList[0].MetaTypeID != null && patientList[0].MetaTypeID != '') {
                    fnGetQualification(patientList[0].MetaTypeID, patientList[0].MetaValueID);
                }
                //            if (document.getElementById("txtEmailID").value == 'null') {
                //                document.getElementById("txtEmailID").value = '';
                //            }

            }
            else {
                //alert(document.getElementById('hdnPatientID').value);
                if (document.getElementById('hdnPatientID').value != '') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientRegistration.aspx_6');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    }
                    else {
                        alert('This patient is not yet discharged; action cannot be performed');
                        return false;
                    }
                }
            }


        }

        //        function showothercouuntry() {
        //            var e = document.getElementById("ddCountry");
        //            var strCountry = e.options[e.selectedIndex].text;
        //            if (strCountry == 'Others') {
        //                document.getElementById('trOthers').style.display = 'block';
        //                document.getElementById('trOthers1').style.display = 'block';
        //                document.getElementById('trOthers2').style.display = 'block';
        //                document.getElementById('trOthers3').style.display = 'block';
        //            }
        //            else {
        //                document.getElementById('trOthers').style.display = 'none';
        //                document.getElementById('trOthers1').style.display = 'none';
        //                document.getElementById('trOthers2').style.display = 'none';
        //                document.getElementById('trOthers3').style.display = 'none';

        //            }
        //        }
        //        function showotherStates() {
        //            var e = document.getElementById("ddCountry");
        //            var strCountry = e.options[e.selectedIndex].text;
        //            var e = document.getElementById("ddState");
        //            var strState = e.options[e.selectedIndex].text;
        //            if (strCountry == 'Others' & strState == 'OTHERS') {
        //                document.getElementById('trOthers').style.display = 'block';
        //                document.getElementById('trOthers1').style.display = 'block';
        //                document.getElementById('trOthers2').style.display = 'block';
        //                document.getElementById('trOthers3').style.display = 'block';
        //            }
        //            else if (strState == 'OTHERS') {
        //                document.getElementById('trOthers').style.display = 'none';
        //                document.getElementById('trOthers1').style.display = 'none';
        //                document.getElementById('trOthers2').style.display = 'block';
        //                document.getElementById('trOthers3').style.display = 'block';
        //            }
        //            else {
        //                document.getElementById('trOthers').style.display = 'none';
        //                document.getElementById('trOthers1').style.display = 'none';
        //                document.getElementById('trOthers2').style.display = 'none';
        //                document.getElementById('trOthers3').style.display = 'none';
        //                document.getElementById('txtOtherCountry').value = '';
        //                document.getElementById('txtOtherState').value = '';
        //            }
        //        }
        function AlphaNumeric(e) {
            if (val.match(/^[a-zA-Z0-9]+$/)) {
                return true;
            }
            else {
                return false;
            }
        }
        function AllowAlphaNumericOnly(e) {
            var keycode;
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode;
            else if (e) keycode = e.which;
            else return true;

            if ((keycode >= 48 && keycode <= 57) || (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122) || (keycode == 32) || (keycode == 46)) {
                return true;
            }
            else {
                return false;
            }
            return true;
        }

        function ShowUpload(obj, id) {
            if (obj.checked) {
                $('[name$="PhotoUpload"]').show();
            }
            else {
                $('[name$="PhotoUpload"]').empty();
                var fu = document.getElementById("PhotoUpload");
                if (fu != null) {
                    document.getElementById("PhotoUpload").outerHTML = fu.outerHTML;
                }
                $('[name$="PhotoUpload"]').hide();
            }
            $('[name$="chkRemovePhoto"]').removeAttr("checked");
        }

        function RemovePhoto(obj, id) {
            $('[name$="PhotoUpload"]').hide();
            $('[name$="PhotoUpload"]').val('');
            $('[name$="chkUploadPhoto"]').removeAttr("checked");
        }

        function FnIsvalid() {
            var userMsg = SListForApplicationMessages.Get('Reception\\PatientRegistration.aspx_9');
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert("Updated successfully.");
                return false;
            }
            document.getElementById('btnCancel').click();
        }
        function SelectedTemp(source, eventArgs) {
            document.getElementById('hdnSelectedPatientTempDetails').value = eventArgs.get_value();
            Tblist();

        }

        function SelectedNewPatient(source, eventArgs) {
            var x = document.getElementById('hdnSelectedPatientTempDetails').value.split("~");
            var PatientID = x[14];
            document.getElementById('hdnNewPatientID').value = PatientID;

        }



        function Tblist() {
            $('[id$="trPatientDetails"]').show();
            var table = '';
            var tr = '';
            var end = '</table>';
            var y = '';
            $('[id$="lblPatientDetails"]').html("");
            table = "<table cellpadding='1' class='dataheaderInvCtrl' cellspacing='0' border='1'"
                           + "style='width:100%'><thead  align='Left' class='dataheader1' style='font-size:11px'>"
                           + "<th style='width:80px;'>Name</th>"
                           + "<th style='width:50px;'>Number</th>"
                           + "<th style='width:300px;'>Address</th>"
                           + "<th style='Widht:100px;'>Phone</th> </thead>";
            var x = document.getElementById('hdnSelectedPatientTempDetails').value.split("~");

            tr = "<tr style='font-size:10px;height:10px' align='Left'><td style='width:250px;'>"
                        + x[1] + "</td><td style='width:100px;'>"
                        + x[2] + "</td><td style='width:100px;'>"
                        + x[8] + ',' + x[20] + ',' + x[9] + "</td><td style='width:100px;'>"
                        + x[7] + "</td></tr>";

            var PatientID = x[14];
            document.getElementById('hdnNewPatientID').value = PatientID;


            var tab = table + tr + end;
            $('[id$="lblPatientDetails"]').html(tab);
            tbshow();


        }
        function tbshow() {
            document.onmouseup = new Function("dragapproved=false")

            document.getElementById("showimage").style.display = "block";
        }
        //

        var ns4 = document.layers
        var ie4 = document.all
        var ns6 = document.getElementById && !document.all


        var dragswitch = 0
        var nsx
        var nsy
        var nstemp

        function drag_dropns(name) {
            if (!ns4)
                return
            temp = eval(name)
            temp.captureEvents(Event.MOUSEDOWN | Event.MOUSEUP)
            temp.onmousedown = gons
            temp.onmousemove = dragns
            temp.onmouseup = stopns
        }

        function gons(e) {
            temp.captureEvents(Event.MOUSEMOVE)
            nsx = e.x
            nsy = e.y
        }
        function dragns(e) {
            if (dragswitch == 1) {
                temp.moveBy(e.x - nsx, e.y - nsy)
                return false
            }
        }

        function stopns() {
            temp.releaseEvents(Event.MOUSEMOVE)
        }

        //drag drop function for ie4+ and NS6////
        /////////////////////////////////


        function drag_drop(e) {
            if (ie4 && dragapproved) {
                crossobj.style.left = tempx + event.clientX - offsetx
                crossobj.style.top = tempy + event.clientY - offsety
                return false
            }
            else if (ns6 && dragapproved) {
                crossobj.style.left = tempx + e.clientX - offsetx + "px"
                crossobj.style.top = tempy + e.clientY - offsety + "px"
                return false
            }
        }

        function initializedrag(e) {
            crossobj = ns6 ? document.getElementById("showimage") : document.all.showimage
            var firedobj = ns6 ? e.target : event.srcElement
            var topelement = ns6 ? "html" : document.compatMode != "BackCompat" ? "documentElement" : "body"
            while (firedobj.tagName != topelement.toUpperCase() && firedobj.id != "dragbar") {
                firedobj = ns6 ? firedobj.parentNode : firedobj.parentElement
            }

            if (firedobj.id == "dragbar") {
                offsetx = ie4 ? event.clientX : e.clientX
                offsety = ie4 ? event.clientY : e.clientY

                tempx = parseInt(crossobj.style.left)
                tempy = parseInt(crossobj.style.top)

                dragapproved = true
                document.onmousemove = drag_drop
            }
        }

        ////drag drop functions end here//////

        function hidebox() {
            crossobj = ns6 ? document.getElementById("showimage") : document.all.showimage

            crossobj.style.display = "none"

        }
        function setPatientSearch() {
            try {
                var searchvalue, searchtype = 0;

                if (searchtype == 0) {
                    $find('AutoCompleteExtenderPatient').set_minimumPrefixLength(3);
                }
                else if (searchtype == 1) {
                    $find('AutoCompleteExtenderPatient').set_minimumPrefixLength(1);
                }
                else if (searchtype == 2) {
                    $find('AutoCompleteExtenderPatient').set_minimumPrefixLength(5);
                }
                var PatientID = -1;
                searchvalue = 1 + "~" + -1 + "~" + 0;
                $find('AutoCompleteExtenderPatient').set_contextKey(searchvalue);
            } catch (e) {
                //alert(e);
            }
        }

    </script>

</head>
<body onload="pageLoad(); toggleCheck();" oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnFinish">

    <script type="text/javascript" language="javascript">
        function IAmSelected(source, eventArgs) {
            var varGetVal = eventArgs.get_value();
            var list = eventArgs.get_value().split('~');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        document.getElementById('<%=hdnapprovedid.ClientID %>').value = list[1];
                        document.getElementById('<%=txtApprovedby.ClientID %>').value = list[0];

                    }
                }
            }
        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" cellpadding="2" cellspacing="2" width="100%">
                            <tr id="EmpControl" runat="server" style="display: none;">
                                <td>
                                    <div style="vertical-align: text-top; width: 120px;">
                                        <div id="divEmp1" onclick="showResponses('divEmp1','divEmp2','divEmployer',1);" style="display: none;"
                                            runat="server">
                                            &nbsp;<img src="../Images/plus.png" alt="Show" style="cursor: pointer" />
                                            <asp:Label ID="Label1" Text="Employee Details" Font-Bold="True" runat="server" meta:resourcekey="Label1Resource1" />
                                        </div>
                                        <div id="divEmp2" style="cursor: pointer; display: block; cursor: pointer;" runat="server">
                                            &nbsp;<img src="../Images/minus.png" alt="hide" />
                                            <asp:Label ID="Label2" Text="Employee Details" Font-Bold="True" runat="server" meta:resourcekey="Label2Resource1" />
                                        </div>
                                    </div>
                                    <div id="divEmployer" style="display: block;" title="Employee Details">
                                        <asp:Panel ID="pnEmployerDetails" runat="server" CssClass="dataheader2 defaultfontcolor"
                                            meta:resourcekey="pnEmployerDetailsResource1">
                                        </asp:Panel>
                                        <%--<asp:Panel ID="pnEmployerDetails" runat="server" CssClass="dataheader2 defaultfontcolor">
                                            <uc9:EmployerRegDetail ID="uctrlEmployer" runat="server" />
                                        </asp:Panel>--%>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div style="vertical-align: text-top;">
                                        <div id="ACX2OPPmt" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','regPatientDetails',1);"
                                            style="display: none;" runat="server">
                                            &nbsp;<img src="../Images/plus.png" alt="Show" style="cursor: pointer" />
                                            <asp:Label ID="Rs_PatientDetails" Text="Patient Details" Font-Bold="True" runat="server"
                                                meta:resourcekey="Rs_PatientDetailsResource1" />
                                        </div>
                                        <div id="ACX2minusOPPmt" style="cursor: pointer; display: block; cursor: pointer;"
                                            runat="server">
                                            &nbsp;<img src="../Images/minus.png" alt="hide" />
                                            <asp:Label ID="Rs1_PatientDetails" Text="Patient Details" Font-Bold="True" runat="server"
                                                meta:resourcekey="Rs1_PatientDetailsResource1" />
                                        </div>
                                    </div>
                                    <div id="regPatientDetails" style="display: block;" title="Patient Details">
                                        <asp:Panel ID="pnPatientDetails" runat="server" CssClass="dataheader2 defaultfontcolor"
                                            meta:resourcekey="pnPatientDetailsResource1">
                                            <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                <tr>
                                                    <td style="width: 85%;" valign="top">
                                                        <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                            <tr>
                                                                <td style="width: 171px;">
                                                                    <asp:Label ID="Rs_Name" Text="Name" runat="server" meta:resourcekey="Rs_NameResource1" />
                                                                </td>
                                                                <td style="width: 300px;">
                                                                    <asp:DropDownList ID="ddSalutation" CssClass="ddl" runat="server" TabIndex="3" Width="54px"
                                                                        onblur="SetTxtName()" meta:resourcekey="ddSalutationResource1">
                                                                    </asp:DropDownList>
                                                                    <asp:TextBox ID="txtName" runat="server" CssClass="Txtboxsmall" onblur="ConverttoUpperCase(this.id); GetPatientDetails(this.value); validate();"
                                                                        MaxLength="60" TabIndex="4" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="100"
                                                                        CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                                        CompletionListItemCssClass="listitemtwo" DelimiterCharacters="" EnableCaching="False"
                                                                        Enabled="True" MinimumPrefixLength="2" ServiceMethod="GetPatientListWithDetails"
                                                                        ServicePath="~/InventoryWebService.asmx" TargetControlID="txtName">
                                                                    </ajc:AutoCompleteExtender>
                                                                    <img align="middle" alt="" src="../Images/starbutton.png" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Rs_AliasName" Text="Alias Name" runat="server" meta:resourcekey="Rs_AliasNameResource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="tAlias" CssClass="Txtboxsmall" onBlur="return ConverttoUpperCase(this.id);"
                                                                        TabIndex="4" runat="server" meta:resourcekey="tAliasResource1"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 150px;">
                                                                    <asp:Label ID="Rs_DateofBirth" Text="Date of Birth" runat="server" meta:resourcekey="Rs_DateofBirthResource1" />
                                                                </td>
                                                                <td>
                                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                                                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                        Enabled="True" />
                                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                                                        PopupButtonID="ImgBntCalc" Enabled="True" />
                                                                    <asp:TextBox ToolTip="dd/mm/yyyy" ID="tDOB" CssClass="Txtboxsmall" runat="server"
                                                                        Width="130px" TabIndex="6" onblur="javascript:countAge(this.id);" MaxLength="1"
                                                                        Style="text-align: justify" ValidationGroup="MKE" meta:resourcekey="tDOBResource1" />
                                                                    <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                        CausesValidation="False" meta:resourcekey="ImgBntCalcResource1" />
                                                                    <%-- <ajc:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderdob" runat="server" TargetControlID="tDOB"
                                                                     WatermarkText="dd/mm/yyyy" WatermarkCssClass="watermarked">
                                                                     </ajc:TextBoxWatermarkExtender>--%>&nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                                <td class="style5">
                                                                    <asp:Label ID="Rs_Age" Text="Age" runat="server" meta:resourcekey="Rs_AgeResource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtAge" Visible="False" TabIndex="7" runat="server" CssClass="Txtboxsmall"
                                                                        meta:resourcekey="txtAgeResource1"></asp:TextBox>
                                                                    <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender2"
                                                                        TargetControlID="txtDOBNos" Enabled="True">
                                                                    </ajc:FilteredTextBoxExtender>
                                                                    <asp:TextBox ID="txtDOBNos" CssClass="Txtboxsmall" runat="server" onblur="ClearDOB()"
                                                                        Width="30px" TabIndex="7" MaxLength="6" Style="text-align: justify" meta:resourcekey="txtDOBNosResource1" />
                                                                    <asp:DropDownList CssClass="ddlsmall" onChange="getDOB()" ID="ddlDOBDWMY" runat="server"
                                                                        TabIndex="8" meta:resourcekey="ddlDOBDWMYResource1">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" /><img src="../Images/starbutton.png"
                                                                        alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_MaritalStatus" Text="Marital Status" runat="server" meta:resourcekey="Rs_MaritalStatusResource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddMarital" CssClass="ddlsmall" runat="server" TabIndex="9"
                                                                        Width="90px" meta:resourcekey="ddMaritalResource1">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Rs_Sex" Text="Sex" runat="server" meta:resourcekey="Rs_SexResource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddSex" CssClass="ddlsmall" runat="server" TabIndex="10" meta:resourcekey="ddSexResource1">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4">
                                                                    <asp:Panel ID="pnAddress" runat="server" meta:resourceKey="pnAddressResource1">
                                                                        <table border="0" cellpadding="2" cellspacing="2" width="97%">
                                                                            <tr>
                                                                                <td>
                                                                                    <uc12:PatientAddress ID="ucPAdd" runat="server" StartIndex="20" AddressType="PERMANENT"
                                                                                        Title="Address Details" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:CheckBox ID="cAdsame" runat="server" Checked="True" CssClass="defaultfontcolor"
                                                                                        Text="Check this if current address is same as above" meta:resourcekey="cAdsameResource1" />
                                                                                    <div id="CAD" style="display: none; text-align: left;">
                                                                                        <uc12:PatientAddress ID="ucCAdd" runat="server" StartIndex="29" AddressType="CURRENT"
                                                                                            Title="Current Address" />
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                            <tr id="trapprovedby" runat="server">
                                                                <td runat="server">
                                                                    <asp:Label ID="lblapproved" Text="Approved By" runat="server" meta:resourcekey="lblapprovedResource1"></asp:Label>
                                                                </td>
                                                                <td runat="server">
                                                                    <asp:TextBox ID="txtApprovedby" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    <ajc:AutoCompleteExtender ID="AutoApprovedBy" runat="server" TargetControlID="txtApprovedby"
                                                                        ServiceMethod="getUserNamesWithLoginID" ServicePath="~/WebService.asmx" EnableCaching="False"
                                                                        MinimumPrefixLength="2" CompletionInterval="30" OnClientItemSelected="IAmSelected"
                                                                        DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected" Enabled="True">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                            </tr>
                                                            <tr id="trFileNo" runat="server" style="display: none">
                                                                <td id="Td1" runat="server" class="style8">
                                                                    <asp:Label ID="lblFileno" runat="server" Text="File Number" meta:resourcekey="lblFilenoResource1"></asp:Label>
                                                                </td>
                                                                <td id="Td2" runat="server" class="style9">
                                                                    <asp:TextBox ID="txtFileNo" runat="server" CssClass="Txtboxmedium" TabIndex="15"
                                                                        onkeypress="if ((event.keyCode < 48) ||(event.keyCode > 122)) event.returnValue = false;"></asp:TextBox>
                                                                    &nbsp;<%--<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                                </td>
                                                                <td id="Td3" runat="server" class="style9">
                                                                </td>
                                                                <td id="Td4" runat="server" class="style9">
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td align="center" style="width: 15%;">
                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td colspan="2">
                                                                    <img id="imgPatient" runat="server" alt="Patient Photo" src="~/Images/ProfileDefault.jpg" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <input id="chkUploadPhoto" runat="server" value="Upload" type="checkbox" onclick="ShowUpload(this, this.id);" />
                                                                    <label id="lblUploadPhoto" runat="server" for="chkUploadPhoto" style="color: #2C88B1;
                                                                        font-weight: bold;">
                                                                        <asp:Label ID="lblUpload1" runat="server" Text="Upload" meta:resourcekey="lblUpload1Resource1"></asp:Label>
                                                                    </label>
                                                                </td>
                                                                <td>
                                                                    <div id="divRemovePhoto" runat="server" style="display: none;">
                                                                        <input id="chkRemovePhoto" runat="server" value="Remove" type="checkbox" onclick="RemovePhoto(this, this.id);" />
                                                                        <label for="chkRemovePhoto" style="color: #2C88B1; font-weight: bold;">
                                                                            <asp:Label ID="lblDelete1" runat="server" Text=" Delete" meta:resourcekey="lblDelete1Resource1"></asp:Label>
                                                                        </label>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    &nbsp;
                                                                    <input id="PhotoUpload" type="file" runat="server" style="width: 150px; display: none;" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:HiddenField ID="hdnOthersstate" Value="0" runat="server" />
                                            <asp:HiddenField ID="hdnIsCorpOrg" Value="N" runat="server" />
                                            <asp:HiddenField ID="hdnSstateID" runat="server" />
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div style="vertical-align: text-top; width: 110px;">
                                        <div id="divMore1" onclick="showResponses('divMore1','divMore2','divMore3',1);" style="cursor: pointer;
                                            display: block;" runat="server">
                                            &nbsp;<img src="../Images/plus.png" alt="Show" />
                                            <asp:Label ID="Rs_MoreDetails" Text="More Details" Font-Bold="True" runat="server"
                                                meta:resourcekey="Rs_MoreDetailsResource1" />
                                        </div>
                                        <div id="divMore2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('divMore1','divMore2','divMore3',0);"
                                            runat="server">
                                            &nbsp;<img src="../Images/minus.png" alt="hide" />
                                            <asp:Label ID="Rs1_MoreDetails" Text="More Details" Font-Bold="True" runat="server"
                                                meta:resourcekey="Rs1_MoreDetailsResource1" />
                                        </div>
                                        <%--  --%>
                                    </div>
                                    <div id="divMore3" style="display: none;" title="More Details">
                                        <asp:Panel ID="pnMoreDetails" runat="server" CssClass="dataheader2 defaultfontcolor"
                                            meta:resourcekey="pnMoreDetailsResource1">
                                            <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                <tr>
                                                    <td style="width: 171px;">
                                                        <asp:Label ID="Rs_PatientNo" Text="Patient No" runat="server" meta:resourcekey="Rs_PatientNoResource1" />
                                                    </td>
                                                    <td style="width: 300px;">
                                                        <asp:TextBox ID="txtPatientNo" CssClass="Txtboxsmall" runat="server" MaxLength="16"
                                                            TabIndex="1" onKeyPress="onEnterKeyPress(event);" Enabled="False" meta:resourcekey="txtPatientNoResource1"></asp:TextBox>
                                                        <asp:Label ID="lblUseSmartCard" runat="server" Visible="False" meta:resourcekey="lblUseSmartCardResource1"></asp:Label>
                                                    </td>
                                                    <td style="width: 150px;">
                                                        <asp:Label ID="Rs_RegistrationFees" Text="Registration Fees" runat="server" meta:resourcekey="Rs_RegistrationFeesResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtRegistFees" CssClass="Txtboxsmall" runat="server" TabIndex="2"
                                                            MaxLength="20" meta:resourcekey="txtRegistFeesResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_SpouseFatherName" Text="Spouse/Father Name" runat="server" meta:resourcekey="Rs_SpouseFatherNameResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtRelation" CssClass="Txtboxsmall" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                                            MaxLength="50" TabIndex="9" meta:resourcekey="txtRelationResource1"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_PlaceOfBirth" Text="Place Of Birth" runat="server" meta:resourcekey="Rs_PlaceOfBirthResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPlaceOfBirth" CssClass="Txtboxsmall" onBlur="return ConverttoUpperCase(this.id);"
                                                            runat="server" MaxLength="30" TabIndex="10" meta:resourcekey="txtPlaceOfBirthResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_Occupation" Text="Occupation" runat="server" meta:resourcekey="Rs_OccupationResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtOccupation" CssClass="Txtboxsmall" onBlur="return ConverttoUpperCase(this.id);"
                                                            runat="server" MaxLength="20" TabIndex="11" meta:resourcekey="txtOccupationResource1"></asp:TextBox>
                                                    </td>
                                                    <td runat="server" id="tdBloodgrouplable">
                                                        <asp:Label ID="Rs_BloodGroup" Text="Blood Group" runat="server" meta:resourcekey="Rs_BloodGroupResource1" />
                                                    </td>
                                                    <td runat="server" id="tdBloodgrouplable1">
                                                        <asp:DropDownList ID="ddBloodGrp" CssClass="ddlsmall" runat="server" TabIndex="12"
                                                            meta:resourcekey="ddBloodGrpResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_Religion" Text="Religion" runat="server" meta:resourcekey="Rs_ReligionResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlReligion" CssClass="ddlsmall" runat="server" TabIndex="13"
                                                            meta:resourcekey="ddlReligionResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_EMail" Text="EMail" runat="server" meta:resourcekey="Rs_EMailResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtEmail" CssClass="Txtboxsmall" runat="server" MaxLength="100"
                                                            onbeforepaste="BeforePaste_Event()" onPaste="Paste_Event()" TabIndex="14" meta:resourcekey="txtEmailResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_Race" Text="Race" runat="server" meta:resourcekey="Rs_RaceResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddRace" CssClass="ddlsmall" runat="server" meta:resourcekey="ddRaceResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_Nationality" Text="Nationality" runat="server" meta:resourcekey="Rs_NationalityResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                            <ContentTemplate>
                                                                <asp:DropDownList ID="ddlNationality" CssClass="ddlsmall" runat="server" TabIndex="14"
                                                                    meta:resourcekey="ddlNationalityResource1">
                                                                </asp:DropDownList>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_IdentificationMarks1" Text="Identification Mark 1" runat="server"
                                                            meta:resourcekey="Rs_IdentificationMarks1Resource1" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtIdentification1" runat="server" TabIndex="15" TextMode="MultiLine"
                                                            Width="150px" Rows="2" Columns="20" MaxLength="128" meta:resourcekey="txtIdentification1Resource1"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_IdentificationMarks2" Text="Identification Marks 2" runat="server"
                                                            meta:resourcekey="Rs_IdentificationMarks2Resource1" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtIdentification2" runat="server" TabIndex="16" TextMode="MultiLine"
                                                            Width="150px" Rows="2" Columns="20" MaxLength="127" meta:resourcekey="txtIdentification2Resource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <uc13:Qualification ID="Qualification" runat="server" Title="Qualification" />
                                                    </td>
                                                </tr>
                                                <tr id="trPatientStatus" runat="server" style="display: none;">
                                                    <td id="TdStatus" runat="server">
                                                        <asp:Label ID="Rs_PatientStatus" Text="Status" runat="server" meta:resourcekey="Rs_PatientStatusResource1" />
                                                    </td>
                                                    <td id="TdrblPatientStatus" runat="server">
                                                        <asp:RadioButtonList ID="rblPatientStatus" runat="server" RepeatDirection="Horizontal">
                                                            <asp:ListItem Value="A" Selected="True" Text="Active" meta:resourcekey="A_rblPatientStatus"></asp:ListItem>
                                                            <asp:ListItem Value="D" Text="Inactive" meta:resourcekey="B_rblPatientStatus"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:Label ID="lblreason" runat="server" Text="Reason For InActive" meta:resourcekey="lblreason"></asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:DropDownList ID="ddlReason" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        <asp:Panel ID="pnOthers" runat="server" CssClass="dataheader2 defaultfontcolor" meta:resourcekey="pnOthersResource1">
                                            <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                <tr>
                                                    <td>
                                                        <uc7:URNControl ID="URNControl1" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_AllergicHistory" Font-Bold="True" Text="Allergic History" runat="server"
                                                                        meta:resourcekey="Rs_AllergicHistoryResource1" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 471px;">
                                                                    <asp:Label ID="Rs_DrugAllergy" Text="Drug Allergy" runat="server" meta:resourcekey="Rs_DrugAllergyResource1" />
                                                                    <asp:CheckBox ID="chkDrugs_1061" runat="server" onclick="javascript:showContentHis(this.id);"
                                                                        meta:resourcekey="chkDrugs_1061Resource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Rs_FoodAllergy" Text="Food Allergy " runat="server" meta:resourcekey="Rs_FoodAllergyResource1" />
                                                                    <asp:CheckBox ID="chkFood_1062" runat="server" onclick="javascript:showContent(this.id);"
                                                                        meta:resourcekey="chkFood_1062Resource1" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div id="divchkDrugs_1061" runat="server" style="display: none">
                                                                        <table class="dataheaderInvCtrl">
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblTypeDrugs" runat="server" Text="Type" meta:resourcekey="lblTypeDrugsResource1"></asp:Label>
                                                                                    <br />
                                                                                    <asp:CheckBoxList RepeatColumns="3" ID="chkDrugs" onclick="javascript:showdrugothers(this.id);"
                                                                                        RepeatDirection="Horizontal" runat="server" meta:resourcekey="chkDrugsResource1">
                                                                                        <asp:ListItem Value="30" meta:resourcekey="ListItemResource29" Text="Pencillin"></asp:ListItem>
                                                                                        <asp:ListItem Value="31" meta:resourcekey="ListItemResource30" Text="Cephalosporins"></asp:ListItem>
                                                                                        <asp:ListItem Value="32" meta:resourcekey="ListItemResource31" Text="Digoxin"></asp:ListItem>
                                                                                        <asp:ListItem Value="33" meta:resourcekey="ListItemResource32" Text="SulphaDrugs"></asp:ListItem>
                                                                                        <asp:ListItem Value="34" meta:resourcekey="ListItemResource33" Text="Others"></asp:ListItem>
                                                                                    </asp:CheckBoxList>
                                                                                    <br />
                                                                                    <div id="divddlDrugs_34" runat="server" style="display: none">
                                                                                        <asp:TextBox ID="txtOthersTypeDrugs_34" runat="server" meta:resourcekey="txtOthersTypeDrugs_34Resource1"></asp:TextBox>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <div id="divchkFood_1062" runat="server" style="display: none">
                                                                        <table class="dataheaderInvCtrl" style="width: 100%;">
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblTypeFood" runat="server" CssClass="defaultfontcolor" Text="Type"
                                                                                        meta:resourcekey="lblTypeFoodResource1"></asp:Label>
                                                                                    <table style="width: 100%;">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBoxList ID="chkFood" onclick="javascript:showfoodothers(this.id);" RepeatDirection="Horizontal"
                                                                                                    runat="server" meta:resourcekey="chkFoodResource1">
                                                                                                    <asp:ListItem Value="35" meta:resourcekey="ListItemResource34" Text="Shellfish"></asp:ListItem>
                                                                                                    <asp:ListItem Value="36" meta:resourcekey="ListItemResource35" Text="Tomato"></asp:ListItem>
                                                                                                    <asp:ListItem Value="37" meta:resourcekey="ListItemResource36" Text="Others"></asp:ListItem>
                                                                                                </asp:CheckBoxList>
                                                                                                <div id="divddlFoodType_37" runat="server" style="display: none">
                                                                                                    <asp:TextBox ID="txtOthersTypeFood_37" runat="server" meta:resourcekey="txtOthersTypeFood_37Resource1"></asp:TextBox>
                                                                                                </div>
                                                                                            </td>
                                                                                            <asp:HiddenField ID="HdnDrug" runat="server" />
                                                                                            <asp:HiddenField ID="HdnFood" runat="server" />
                                                                                            <asp:HiddenField ID="hdnPatientNo" runat="server" />
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                            <tr id="rowSmartCard" runat="server">
                                <td colspan="2">
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <div style="vertical-align: text-top; width: 110px;">
                                                <div runat="server" id="divSmartCard1" onclick="showResponses('divSmartCard1','divSmartCard2','divSmartCard3',1);"
                                                    style="cursor: pointer; display: none;">
                                                    &nbsp;<img src="../Images/plus.png" alt="Show" />
                                                    <asp:Label ID="Rs_SmartCard" Text="Smart Card" Font-Bold="True" runat="server" meta:resourcekey="Rs_SmartCardResource1" />
                                                </div>
                                                <div runat="server" id="divSmartCard2" style="cursor: pointer; display: block; cursor: pointer;"
                                                    onclick="showResponses('divSmartCard1','divSmartCard2','divSmartCard3',0);">
                                                    &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                    <asp:Label ID="Rs1_SmartCard" Text="Smart Card" Font-Bold="True" runat="server" meta:resourcekey="Rs1_SmartCardResource1" />
                                                </div>
                                            </div>
                                            <div runat="server" id="divSmartCard3" style="display: block;" title="More Details">
                                                <asp:Panel ID="SmartCardPanel" runat="server" CssClass="dataheader2 defaultfontcolor"
                                                    meta:resourcekey="SmartCardPanelResource1">
                                                    <uc8:SmartCard ID="uctlSmartCard1" runat="server" />
                                                </asp:Panel>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" runat="server" id="tdPatientupdate" style="display: none">
                                    <div style="vertical-align: text-top;">
                                        <div id="div11" onclick="showResponses('div11','div12','div13',1);" style="cursor: pointer;
                                            display: block;" runat="server">
                                            &nbsp;<img src="../Images/plus.png" alt="Show" />
                                            <asp:Label ID="Label3" Text="Patient To Updates" Font-Bold="True" runat="server" />
                                        </div>
                                        <div id="div12" style="cursor: pointer; display: none" onclick="showResponses('div11','div12','div13',0);"
                                            runat="server">
                                            &nbsp;<img src="../Images/minus.png" alt="hide" />
                                            <asp:Label ID="Label4" Text="Patient To Update" Font-Bold="True" runat="server" />
                                        </div>
                                    </div>
                                    <div id="div13" style="display: none;" title="Patient To Update">
                                        <table border="0" cellpadding="0" cellspacing="2" width="100%" class="dataheader3">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblPatient" Text="Patient Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtOldPatient" onfocus="javascript:setPatientSearch();" onblur="javascript:ConverttoUpperCase(this.id); GetPatientDetails(this.value);CheckEmergency();"
                                                        autocomplete="off" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPatient" runat="server" TargetControlID="txtOldPatient"
                                                        ServiceMethod="GetLabQuickBillPatientList" ServicePath="~/OPIPBilling.asmx" EnableCaching="False"
                                                        CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                        OnClientItemOver="SelectedTemp" OnClientItemSelected="SelectedNewPatient" Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="trPatientDetails" style="display: none;">
                                                    <div id="showimage" style="display: none; position: absolute; width: 460px; left: 50%;
                                                        top: 73%">
                                                        <div onclick="hidebox();return false" class="divCloseRight">
                                                        </div>
                                                        <table border="0" width="453px" cellspacing="1" class="modalPopup dataheaderPopup"
                                                            cellpadding="1">
                                                            <tr>
                                                                <td id="dragbar" style="cursor: move; cursor: pointer" width="100%" onmousedown="initializedrag(event)">
                                                                    <asp:Label ID="lblPatientDetails" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2">
                                    <asp:CheckBox runat="server" ID="chkGenerateLogin" Text="Please check this box to allow online access for this patient"
                                        TextAlign="Left" meta:resourcekey="chkGenerateLoginResource1" />
                                </td>
                            </tr>
                            <tr id="tradmitdaycare" runat="server">
                                <td class="style4">
                                    <asp:CheckBox ID="chkBox" runat="server" Text="Admit Patient" meta:resourcekey="chkBoxResource1"
                                        onclick="fnChkDayCare(this.id);" />
                                </td>
                                <td class="style4">
                                    <asp:CheckBox ID="chkDonor" runat="server" Text="Is Blood Donor" meta:resourcekey="chkDonorResource1"
                                        onclick="fnChkDayCare(this.id);" />
                                </td>
                                <td>
                                    <asp:CheckBox ID="chkDayCare" runat="server" Text="Day Care" onclick="fnChkDayCare(this.id);"
                                        meta:resourcekey="chkDayCareResource1" />
                                </td>
                            </tr>
                            <tr id="tradmitdaycares" runat="server">
                                <td align="center" colspan="2">
                                    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>--%>
                                    <asp:Button ID="btnFinish" Enabled="False" runat="server" OnClientClick="return validation(this.id);"
                                        OnClick="btnFinish_Click" TabIndex="41" Text="Finish" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" meta:resourcekey="btnFinishResource1" Visible="False" />
                                    <asp:Button ID="btnUpdate" Enabled="False" runat="server" OnClientClick="return validation(this.id);"
                                        OnClick="btnFinish_Click" TabIndex="41" Text="Update" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Visible="False" meta:resourcekey="btnUpdateResource1" />
                                    <asp:Button ID="btnURNo" Enabled="False" runat="server" OnClientClick="return validation(this.id);"
                                        OnClick="btnFinish_Click" TabIndex="41" Text="Enter URNo & Make Visit" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" Visible="False"
                                        meta:resourcekey="btnURNoResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        meta:resourcekey="btnCancelResource1" />
                                    <span style="display: none;">
                                        <asp:Button ID="btnEmpReg" runat="server" Text="Cancel" OnClick="btnEmp_Click" CssClass="btn"
                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnEmpRegResource1" /></span>
                                    <%--</ContentTemplate>
                                    </asp:UpdatePanel>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc120:ucMandatory ID="ucMandatory" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btn"
                                                PopupControlID="Panel1" BackgroundCssClass="modalBackground" DynamicServicePath=""
                                                Enabled="True" />
                                            <input type="button" id="btn" runat="server" style="display: none;" />
                                            <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup dataheaderPopup" Width="25%"
                                                Style="display: none" meta:resourcekey="Panel1Resource1">
                                                <table width="100%">
                                                    <tr>
                                                        <td align="center">
                                                            <table width="90%">
                                                                <tr>
                                                                    <td align="left">
                                                                        <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" meta:resourcekey="Rs_PatientNameResource1" />
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:Label ID="lblPatientName" runat="server" Font-Bold="True" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="left">
                                                                        <asp:Label ID="Rs_PatientNumber" Text="Patient Number" runat="server" meta:resourcekey="Rs_PatientNumberResource1" />
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:Label ID="lblPatientNumber" runat="server" Font-Bold="True" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                                                        <asp:Label ID="lblEmpNumber" Visible="False" runat="server" Font-Bold="True" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2" align="left">
                                                                        <asp:Label ID="lblUserPass" runat="server" meta:resourcekey="lblUserPassResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <asp:Button ID="btnOK" runat="server" Text="Ok" OnClick="btnOk_Click" CssClass="btn"
                                                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnOKResource1" />
                                                                        <asp:HiddenField ID="hdnRedirectURL" runat="server" />
                                                                        <asp:HiddenField ID="hdnRedirectPateintVisit" runat="server" />
                                                                        <asp:HiddenField ID="hdnInsertorUpdate" runat="server" />
                                                                        <asp:HiddenField ID="hdnCityName" runat="server" />
                                                                        <asp:HiddenField ID="hdnSelectedPatientTempDetails" runat="server" />
                                                                        <asp:HiddenField ID="hdnNewPatientID" runat="server" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div id="printDonorCard" runat="server" align="center" style="display: none;">
                                                    <uc25:ucDonorCard ID="UcDCard" runat="server" />
                                                </div>
                                            </asp:Panel>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
        <input type="hidden" id="hdnTOrg" runat="server" />
        <asp:HiddenField ID="hdnPatientID" runat="server" />
        <asp:HiddenField ID="hdnAddress" Value="N" runat="server" />
        <asp:HiddenField ID="hdnBtnStatus" runat="server" />
        <asp:HiddenField ID="hdnPatientImageName" runat="server" />
        <asp:HiddenField ID="hdnPatientAgeLimit" runat="server" />
        <asp:HiddenField ID="hdnEmpNo" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnapprovedid" runat="server" Value="0" />
        <asp:HiddenField ID="hdnSmardno" runat="server" Value="" />
    </div>
    <div id="divPatientImage" class="divPopup">
    </div>
    </form>

    <script language="javascript" type="text/javascript">
        function setDropValue(val) {

            var ddl = document.getElementById("ucPAdd_ddCountry");
            for (var count = 0; count < ddl.options.length; count++) {
                if (ddl.options[count].text == val) {
                    ddl.options[count].selected = true;
                    break;
                }
            }
        }
        //        function SetIsvalidation(obj1, obj2) {
        //            //debugger;
        //            document.getElementById("hdnAddress").value = "N";
        //           // document.getElementById('trAddress1').style.display = "block";
        //            //document.getElementById('trAddress2').style.display = "block";
        //            //document.getElementById('trCountry').style.display = "block";

        //            if (obj2 == "plus") {
        //                document.getElementById("hdnAddress").value = "Y";
        ////                document.getElementById('ucPAdd_txtAddress2').value = document.getElementById('txtAddress').value;
        ////                document.getElementById('ucPAdd_txtMobile').value = document.getElementById('txtMobile').value;
        ////                document.getElementById('ucPAdd_txtLandLine').value = document.getElementById('txtLandLine').value;
        //                //document.getElementById('ucPAdd_txtCity').value = document.getElementById('txtCity').value;

        //                // setDropValue(document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].text, document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].text);
        //                //                alert(document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].text = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].text);
        //                //                alert(document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].value = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].value);
        //                //                alert(document.getElementById('ucPAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].text = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].text);
        //                //                alert(document.getElementById('ucPAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].value = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].value);
        //                //                document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].text = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].text;
        //                //                document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].value = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].value;
        //                //                document.getElementById('ucPAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].text = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].text;
        //                //                document.getElementById('ucPAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].value = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].value;

        //                //                document.getElementById('ucCAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].text = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].text;
        //                //                document.getElementById('ucCAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].value = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].value;
        //                //                document.getElementById('ucCAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].text = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].text;
        //                //                document.getElementById('ucCAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].value = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].value;
        //                //document.getElementById('ucPAdd_ddlCity').options[document.getElementById('ucPAdd_ddlCity').selectedIndex].text = document.getElementById('ddlCity').options[document.getElementById('ddlCity').selectedIndex].text;
        ////                document.getElementById('ucPAdd_txtOtherCountry').value = document.getElementById('txtOtherCountry').value;
        ////                document.getElementById('ucPAdd_txtOtherState').value = document.getElementById('txtOtherState').value;
        ////                document.getElementById('ucCAdd_txtOtherCountry').value = document.getElementById('txtOtherCountry').value;
        ////                document.getElementById('ucCAdd_txtOtherState').value = document.getElementById('txtOtherState').value;


        //                //document.getElementById('trAddress1').style.display = "none";
        //                //document.getElementById('trAddress2').style.display = "none";
        //               // document.getElementById('trCountry').style.display = "none";

        ////                document.getElementById('ucPAdd_ddlCity').options[document.getElementById('ucPAdd_ddlCity').selectedIndex].text = document.getElementById('ddlCity').options[document.getElementById('ddlCity').selectedIndex].text;
        ////                document.getElementById('ucCAdd_ddlCity').options[document.getElementById('ucCAdd_ddlCity').selectedIndex].value = document.getElementById('ddlCity').options[document.getElementById('ddlCity').selectedIndex].value;
        ////                document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].text = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].text;
        ////                document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].value = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].value;
        ////                document.getElementById('ucPAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].text = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].text;
        ////                document.getElementById('ucPAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].value = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].value;

        ////                document.getElementById('ucCAdd_ddCountry').options[document.getElementById('ucCAdd_ddCountry').selectedIndex].text = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].text;
        ////                document.getElementById('ucCAdd_ddCountry').options[document.getElementById('ucCAdd_ddCountry').selectedIndex].value = document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].value;
        ////                document.getElementById('ucCAdd_ddState').options[document.getElementById('ucCAdd_ddState').selectedIndex].text = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].text;
        ////                document.getElementById('ucCAdd_ddState').options[document.getElementById('ucCAdd_ddState').selectedIndex].value = document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].value;


        //            }
        //            if (obj2 == "minus") {
        ////                document.getElementById('txtAddress').value = document.getElementById('ucPAdd_txtAddress2').value;
        ////                document.getElementById('txtMobile').value = document.getElementById('ucPAdd_txtMobile').value;
        ////                document.getElementById('txtLandLine').value = document.getElementById('ucPAdd_txtLandLine').value;
        ////                //document.getElementById('txtCity').value = document.getElementById('ddlCity').options[document.getElementById('ddlCity').selectedIndex].text;
        ////                //document.getElementById('ucPAdd_txtCity').value;
        ////                document.getElementById('ddlCity').options[document.getElementById('ddlCity').selectedIndex].text = document.getElementById('ucPAdd_ddlCity').options[document.getElementById('ucPAdd_ddlCity').selectedIndex].text;
        ////                document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].text = document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucCAdd_ddCountry').selectedIndex].text;
        ////                document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].value = document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucCAdd_ddCountry').selectedIndex].value;
        ////                document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].text = document.getElementById('ucPAdd_ddState').options[document.getElementById('ucCAdd_ddState').selectedIndex].text;
        ////                document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].value = document.getElementById('ucPAdd_ddState').options[document.getElementById('ucCAdd_ddState').selectedIndex].value;

        ////                document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].text = document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].text;
        ////                document.getElementById('ddCountry').options[document.getElementById('ddCountry').selectedIndex].value = document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].value;
        ////                document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].text = document.getElementById('ucPAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].text;
        ////                document.getElementById('ddState').options[document.getElementById('ddState').selectedIndex].value = document.getElementById('ucPAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].value;

        ////                document.getElementById('txtOtherCountry').value = document.getElementById('ucPAdd_txtOtherCountry').value;
        ////                document.getElementById('txtOtherState').value = document.getElementById('ucPAdd_txtOtherState').value;



        //            }
        //        }

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

            if (document.getElementById('hdnOthersstate').value == "1") {
                document.getElementById('divOthers').style.display = "block";

            }
        }

        function CreateEmpVisit(PatientAge) {
            // btnEdit_OnClick(Select);
            var split = PatientAge.split('~');
            var cnt = split.length;
            if (cnt > 1) {
                var Sex = split[0];
                var Marital = split[1];
                var DOB = split[2];
                var EmployeeType = split[3];
                var EmpNo = split[4];
                var objPatientID = split[5];
                var Status = split[6];
                if (Status == 'D') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientRegistration.aspx_1');

                    if (Status == 'D') {
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;
                        }
                        else {
                            alert('New visits and ordering of services cannot be done as the patient is not in active status.');
                            return false;
                        }
                        return false;
                    }
                }
                var AgeLimit = document.getElementById('hdnPatientAgeLimit').value
                var sServiceBasedOnAgeMessage = 'Service cannot be placed as the dependent is above the configured limit of ' + AgeLimit + ' years.';
                document.getElementById('tDOB').value = DOB;
                countAge('tDOB');
                var Age = document.getElementById('txtDOBNos').value;
                if (EmployeeType.toUpperCase() == 'DAUGHTER' && (Marital.toUpperCase() == 'M' || Number(Age) > Number(AgeLimit))) {
                    alert(sServiceBasedOnAgeMessage);
                    return false;
                }
                if (EmployeeType.toUpperCase() == 'SON' && Number(Age) > Number(AgeLimit)) {
                    alert(sServiceBasedOnAgeMessage);
                    return false;
                }
                if (objPatientID > 0) {
                    document.getElementById('hdnPatientID').value = objPatientID;
                    document.getElementById('hdnEmpNo').value = EmpNo;
                    document.getElementById('btnEmpReg').click();
                }
                else {
                    var userMsg3 = SListForApplicationMessages.Get('Reception\\PatientRegistrtion.aspx_2');
                    if (userMsg3 != null) {
                        alert(userMsg3);
                        return false;
                    }
                    else {

                        alert('Please Registration Next go Process');
                        return false;
                    }
                }
            }
        }


        function AgeLimit() {
            var userMsg1 = SListForApplicationMessages.Get('Reception\\PatientRegistration.aspx_7');
            var userMsg2 = SListForApplicationMessages.Get('Reception\\PatientRegistration.aspx_8');

            if (userMsg1 != null && userMsg2 != null) {
                alert(userMsg1 + AgeLimit + userMsg2);
            }
            else {
                var sServiceBasedOnAgeMessage = 'Service cannot be placed as the dependent is above the configured limit of ' + AgeLimit + ' years.';
            }
        }

        $(function() {
            var preValue = '';
            $('#txtDOBNos').focus(function() {
                preValue = $.trim($(this).val());
            });
            $("#txtDOBNos").keyup(function() {
                if (preValue != $.trim($("#txtDOBNos").val()))
                    $('#tDOB').val('');
            });
        });
       
    </script>

    <script language="javascript" type="text/javascript">
        var ClientSelect = { Select: '<%=Resources.Defaults.Select%>' };

        var Smartnumber = document.getElementById('hdnSmardno').value;

        SetSmartNo(Smartnumber);



    </script>

</body>
</html>
