<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InPatientRegistration.aspx.cs"
    Inherits="Reception_InPatientRegistration" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/ReferedPhysician.ascx" TagName="ReferedPhysician"
    TagPrefix="uc10" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc8" %>
<%@ Register Src="../InPatient/TPAArttibControl.ascx" TagName="TPAArttibControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../InPatient/AttribWithDate.ascx" TagName="AttribWithDate" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="PaymentType"
    TagPrefix="uc15" %>
<%@ Register Src="../CommonControls/IPClientTpaInsurance.ascx" TagName="ClientTpa"
    TagPrefix="uc19" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register Src="../CommonControls/QuickBillReferedPhysician.ascx" TagName="ReferedPhysician"
    TagPrefix="uc16" %>
    <%@ Register Src="~/CommonControls/AttenderDetails.ascx" TagName="ucAD" TagPrefix="uc200" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>InPatient Registration</title>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/StyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    

    <script type="text/javascript" language="javascript">
          
        
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

        function GetTextDO(pDutyOff) {
            if (pDutyOff != "") {
                var arrayGotValue = new Array();
                arrayGotValue = pDutyOff.split('~');
                if (arrayGotValue.length > 1) {
                    document.getElementById('hdnDO').value = "";
                    document.getElementById('hdnDO').value = pDutyOff;
                    document.getElementById('txtDutyOfficer').value = arrayGotValue[1];

                }
                else {
                    if (document.getElementById('hdnDO').value != "") {
                        var arrayGotValue = new Array();
                        arrayGotValue = document.getElementById('hdnDO').value.split('~');
                        document.getElementById('txtDutyOfficer').value = arrayGotValue[1];
                    }
                    else {
                        document.getElementById('txtDutyOfficer').value = "";
                    }
                }
            }
        }

        function GetTextCS(pConSurg) {

            if (pConSurg != "") {
                var arrayGotValue = new Array();
                arrayGotValue = pConSurg.split('~');
                if (arrayGotValue.length > 1) {
                    document.getElementById('hdnCS').value = "";
                    document.getElementById('hdnCS').value = pConSurg;
                    document.getElementById('txtSurgen').value = arrayGotValue[1];
                }
                else {
                    if (document.getElementById('hdnCS').value != "") {
                        var arrayGotValue = new Array();
                        arrayGotValue = document.getElementById('hdnCS').value.split('~');
                        document.getElementById('txtSurgen').value = arrayGotValue[1];
                    }
                    else {
                        document.getElementById('txtSurgen').value = "";
                    }
                }
            }
        }



        function GetTextPC(PrmCons) {

            if (PrmCons != "" && PrmCons != "Type the name and then add") {
                var arrayGotValue = new Array();
                arrayGotValue = PrmCons.split('~');
                if (arrayGotValue.length > 1) {
                    document.getElementById('hdnPC').value = "";
                    document.getElementById('hdnPC').value = PrmCons;
                    document.getElementById('txtPrimaryCons').value = arrayGotValue[1];

                }
                else {
                    if (document.getElementById('hdnPC').value != "") {
                        var arrayGotValue = new Array();
                        arrayGotValue = document.getElementById('hdnPC').value.split('~');
                        document.getElementById('txtPrimaryCons').value = arrayGotValue[1];
                    }
                    else {
                        document.getElementById('txtPrimaryCons').value = "";
                    }
                }

            }
        }






        function onClickAddPC() {



            if (document.getElementById('txtPrimaryCons').value == "" && document.getElementById('txtPrimaryCons').value != "Type the name and then add") {
                var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    return false ;
                }
                else {
                    alert('Provide the primary consultant name');
                    return false ;
                }
                document.getElementById('txtPrimaryCons').focus();
                return false;
            }


            var rwNumber = parseInt(320);
            var AddStatus = 0;
            var arrayGotValue = new Array();

            arrayGotValue = document.getElementById('hdnPC').value.split('~');



            if (arrayGotValue.length > 1) {
                var PCID = arrayGotValue[0];
                var PCName = arrayGotValue[1]
            }
            else {
                var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_2');
                if (userMsg != null) {
                    alert(userMsg);
                                    }
                else {
                    alert('Provide the correct primary consultant name');
                }
                return false;
            }


            var HidValue = document.getElementById('hdnPCItems').value;
            var list = HidValue.split('^');
            document.getElementById('trPC').style.display = 'block';

            if (document.getElementById('hdnPCItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var PCList = list[count].split('~');

                    if (PCList[1] != '') {
                        if (PCList[0] != '') {
                            rwNumber = parseInt(parseInt(PCList[0]) + parseInt(1));
                        }
                        if (PCID != '') {
                            if (PCList[1] == PCID) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }

            else {

                if (PCID != '') {
                    var row = document.getElementById('tblPCItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);

                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickPC(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = PCName;
                    document.getElementById('hdnPCItems').value += parseInt(rwNumber) + "~" + PCID + "~" + PCName + "^";
                    AddStatus = 2;
                }
            }

            if (AddStatus == 0) {
                if (PCID != '') {
                    var row = document.getElementById('tblPCItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);

                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickPC(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = PCName;
                    document.getElementById('hdnPCItems').value += parseInt(rwNumber) + "~" + PCID + "~" + PCName + "^";
                }
            }
            else if (AddStatus == 1) {
                //Reception\InPatientRegistration.aspx_3
                var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_3');
                if (userMsg != null) {
                    alert(userMsg);
                    return false ;
                }
                else {

                    alert('Primary consultant already added');
                    return false ;
                }
            }
            document.getElementById('txtPrimaryCons').value = '';


            return false;

        }


        function ImgOnclickPC(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnPCItems').value;
            var list = HidValue.split('^');
            var newPCList = '';
            if (document.getElementById('hdnPCItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var PCList = list[count].split('~');
                    if (PCList[0] != '') {
                        if (PCList[0] != ImgID) {
                            newPCList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnPCItems').value = newPCList;
            }
            if (document.getElementById('hdnPCItems').value == '') {
                document.getElementById('trPC').style.display = 'none';
            }
        }

        function LoadPCItems() {
            var HidValue = document.getElementById('hdnPCItems').value;

            var list = HidValue.split('^');
            if (document.getElementById('hdnPCItems').value != "") {

                for (var count = 0; count < list.length - 1; count++) {
                    var PCList = list[count].split('~');
                    var row = document.getElementById('tblPCItems').insertRow(0);
                    row.id = PCList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickPC(" + PCList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = PCList[2];

                }
            }
        }



        function pageLoad() {
            document.getElementById('ucAttenderDetails_txtATTName').focus();
        }

        function toggleOrganDiv(divid, x) {
            if (x == 0) {
                document.getElementById(divid).style.display = 'none';
            }
            if (x == 1) {
                document.getElementById(divid).style.display = 'block';
            }
        }

        function showHideEmployerBlock(id) {

        }
        function InPatientValidation(bid) {
            var flag = 0;
            var radio = document.getElementsByName('rblSurgeryPatient');
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].checked) {
                    flag = 1;
                }
            }
            if (flag == 0) {
                //Reception\InPatientRegistration.aspx_27
                var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_27');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Please select Surgery Patient Yes or No');
                }
                return false;
            }

            if (document.getElementById('chkCreditLimit').checked == true) {
                if (document.getElementById('txtCreditLimt').value == "") {
                    //Reception\InPatientRegistration.aspx_28
                    var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_28');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false ;

                    }
                    else {
                        alert('Please Enter Credit Limit');
                        return false ;
                    }
                    document.getElementById('txtCreditLimt').focus();
                    return false;
                }
                var txtCreditLimit = document.getElementById('txtCreditLimt').value;
                var hdnOldCreditLimitAmount = document.getElementById('hdnOldCreditLimitAmount').value;
                var hdnGrossAmt = document.getElementById('hdnGrossAmt').value;
                if (Number(txtCreditLimit) == Number(hdnOldCreditLimitAmount) || Number(hdnOldCreditLimitAmount) == 0) {
                    return true;
                }
                if (Number(txtCreditLimit) < Number(hdnOldCreditLimitAmount)) {
                    if (Number(hdnGrossAmt) > Number(txtCreditLimit)) {
                        var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_29');
                        if (userMsg != null) {
                            alert(userMsg);
                        }
                        else {
                            alert('Gross Bill amount Greater than Credit Limit');
                        }
                        return false;
                    }
                }
            }


            if (document.getElementById('hdnPCItems').value == "") {
                //Reception\InPatientRegistration.aspx_4
                var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_4');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Select the primary physician name');
                }
                document.getElementById('txtPrimaryCons').focus();
                return false;
            }

            if (document.getElementById('speciality').value == "0") {
                var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_5');
                if (userMsg != null) {
                    alert(userMsg);
                    return false ;
                }
                else {
                    alert('Select the specialty');
                    return false ;
                }
                document.getElementById('speciality').focus();
                return false;
            }

            if (document.getElementById('txtAdmissionDate').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_6');
                if (userMsg != null) {
                    alert(userMsg);
                    return false ;
                }
                else {
                    alert('Provide the admission date');
                    return false ;
                }
                document.getElementById('txtAdmissionDate').focus();
                return false;
            }

            //            if (document.getElementById('relContactNo').value == '') {
            //                alert('Provide the contact no')
            //                document.getElementById('relContactNo').focus();
            //                return false;
            //            }


            if (document.getElementById('uctlClientTpa_chkcredit').checked == true) {

                //                if (document.getElementById("uctlClientTpa_ddlTPA").options[document.getElementById("uctlClientTpa_ddlTPA").selectedIndex].value == 0 && document.getElementById("uctlClientTpa_ddlClient").options[document.getElementById("uctlClientTpa_ddlClient").selectedIndex].value == 0) {
                //                    var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_8');
                //                    if (userMsg != null) {
                //                        alert(userMsg);
                //                    }
                //                    else {
                //                        alert('Select the Client or TPA to apply credit bill')
                //                    }
                //                    return false;
                //                }


                if (document.getElementById('chkRegFee').checked == true) {
                    var rdoPayNow = document.getElementById('rdoPayNow').checked;
                    var rdoPayLater = document.getElementById('rdoPayLater').checked;

                    if (rdoPayNow == true) {
                        if (document.getElementById('hdnNowPaid').value != '') {

                            if (document.getElementById('hdnNowPaid').value == document.getElementById('txtRegFee').value) {
                                $get(bid).disabled = true;
                                javascript: __doPostBack(bid, '');


                                return true;
                            }
                            else {
                                var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_9');
                                if (userMsg != null) {
                                    alert(userMsg);
                                }
                                else {
                                    alert('Collect Registration Fee or Select PayLater');
                                }
                                return false;
                            }
                        } else {
                            var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_9');
                            if (userMsg != null) {
                                alert(userMsg);
                            }
                            else {
                                alert('Collect Registration Fee or Select PayLater');
                            }
                            return false;

                        }

                    }
                    else {
                        $get(bid).disabled = true;
                        javascript: __doPostBack(bid, '');
                        return true;
                    }

                }
                else {
                    $get(bid).disabled = true;
                    javascript: __doPostBack(bid, '');
                    return true;
                }

            }



            if (document.getElementById('chkRTA').checked) {

                if (document.getElementById('txtRTADate').value == "") {
                    //Reception\InPatientRegistration.aspx_11'
                    var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_11');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false ;
                    }
                    else {
                        alert('Provide event date');
                        return false ;
                    }
                    document.getElementById('txtRTADate').focus();
                    return false;
                }
                else {
                    if (document.getElementById('txtRTALocation').value == "") {
                        var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_12');
                        if (userMsg != null) {
                            alert(userMsg);
                            return false ;
                        }
                        else {
                            alert('Provide event  location');
                            return false ;
                        }
                        document.getElementById('txtRTALocation').focus();
                        return false;
                    }
                }
            }


            //            if (document.getElementById('txtEmployerName').value != '' && document.getElementById('chkCorporate').checked == true) {
            //                if (document.getElementById('employerAddress_txtAddress2').value == '') {
            //                    alert('Provide the employer details - street/road name')
            //                    document.getElementById('employerAddress_txtAddress2').focus();
            //                    return false;
            //                }
            //                if (document.getElementById('employerAddress_txtCity').value == '') {
            //                    alert('Provide the city')
            //                    document.getElementById('employerAddress_txtCity').focus();
            //                    return false;
            //                }
            //                if ((document.getElementById('employerAddress_txtMobile').value == '') && (document.getElementById('employerAddress_txtLandLine').value == '')) {
            //                    alert('Provide either mobile or landline contact number')
            //                    document.getElementById('employerAddress_txtMobile').focus();
            //                    return false;
            //                }
            //                else {
            //                    return true;
            //                }
            //            }




            if (document.getElementById('chkPED').checked == true) {

                if (document.getElementById('txtEmployerName').value == '') {
                    //Reception\InPatientRegistration.aspx_16
                    var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_16');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false ;
                    }
                    else {
                        alert('Provide the employer name');
                        return false ;
                    }
                    document.getElementById('txtEmployerName').focus();
                    return false;
                }
                if (document.getElementById('employerAddress_txtAddress2').value == '') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_17');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false ;
                    }
                    else {
                        alert('Provide the employer details - street/road name');
                        return false ;
                    }
                    document.getElementById('employerAddress_txtAddress2').focus();
                    return false;
                }


                if (document.getElementById('employerAddress_txtCity').value == '') {
                    //Reception\InPatientRegistration.aspx_14
                    var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_14');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false ;
                    }
                    else {
                        alert('Provide the city');
                        return false ;
                    }
                    document.getElementById('employerAddress_txtCity').focus();
                    return false;
                }
                if ((document.getElementById('employerAddress_txtMobile').value == '') && (document.getElementById('employerAddress_txtLandLine').value == '')) {
                    //Reception\InPatientRegistration.aspx_15
                    var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_15');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false ;
                    }
                    else {
                        alert('Provide either mobile or landline contact number');
                        return false ;
                    }
                    document.getElementById('employerAddress_txtMobile').focus();
                    return false;
                }
                else {
                    if (bid == "btnFinish") {
                        $get('btnPrint').disabled = true;
                        $get('btnFinish').disabled = true;
                        fn_SetClientVisitDetails();
                        javascript: __doPostBack('btnFinish', '');
                        return true;
                    }
                    if (bid == "btnPrint") {
                        $get('btnPrint').disabled = true;
                        $get('btnFinish').disabled = true;
                        fn_SetClientVisitDetails();
                        javascript: __doPostBack('btnPrint', '');
                        return true;
                    }

                    //                    $get(bid).disabled = true;
                    //                    javascript: __doPostBack(bid, '');
                    //                    return true;
                }
            }
            if (bid == "btnFinish") {
                $get('btnPrint').disabled = true;
                $get('btnFinish').disabled = true;
                fn_SetClientVisitDetails();

                javascript: __doPostBack('btnFinish', '');
                return true;
            }
            if (bid == "btnPrint") {
                $get('btnPrint').disabled = true;
                $get('btnFinish').disabled = true;
                fn_SetClientVisitDetails();

                javascript: __doPostBack('btnPrint', '');
                return true;
            }
        }


        function showTPA(TPAID) {

            if (document.getElementById(TPAID).checked == true) {
                document.getElementById('tdTPA').style.display = 'block';
                if (document.getElementById('chkclient').checked == true) {
                    document.getElementById('chkclient').checked = false
                    document.getElementById('tdclient').style.display = 'none';
                    document.getElementById('ddlClient').value = "0"

                }
            }
            else {
                document.getElementById('tdTPA').style.display = 'none';
                document.getElementById('pnlTPADetails').style.display = 'none';

            }

        }

        function showclient(ID) {

            if (document.getElementById(ID).checked == true) {
                document.getElementById('tdclient').style.display = 'block';
                if (document.getElementById('chkTPA').checked == true) {
                    document.getElementById('chkTPA').checked = false
                    document.getElementById('tdTPA').style.display = 'none';
                    document.getElementById('ddlTPA').value = "0"
                    document.getElementById('pnlTPADetails').style.display = 'none';
                }
            }
            else {
                document.getElementById('tdclient').style.display = 'none';
                document.getElementById('ddlClient').value = "0"
            }

        }

        function validateIsCredit(ID) {

            if (document.getElementById(ID).checked == false) {

                document.getElementById('tdclient').style.display = 'none';
                document.getElementById('ddlClient').value = "0"
                document.getElementById('tdTPA').style.display = 'none';
                document.getElementById('ddlTPA').value = "0"
                document.getElementById('pnlAttrib').style.display = 'none';
                document.getElementById('rdoClient').checked = false;
                document.getElementById('rdoTpa').checked = false;

            }
            else { document.getElementById(ID).checked = false }
        }

        function showCorporate(Cid) {
            if (document.getElementById(Cid).checked == true) {
                document.getElementById('tdCorporate').style.display = 'block';
                if (document.getElementById('chkTPA').checked == true) {
                    document.getElementById('chkTPA').checked = false
                    document.getElementById('tdTPA').style.display = 'none';
                }
            }
            else {
                document.getElementById('tdCorporate').style.display = 'none';
                document.getElementById('ddlCorporate').value = "0"
            }
        }

        function showRTABlock() {
            if (document.getElementById('trRTABlock').style.display == "none") {
                document.getElementById('trRTABlock').style.display = "block";
            }
            else {
                document.getElementById('trRTABlock').style.display = "none";
            }
        }

        function showPED() {
            if (document.getElementById('trPED').style.display == "none") {
                document.getElementById('trPED').style.display = "block";
            }
            else {
                document.getElementById('trPED').style.display = "none";
            }
        }

        function checkCreditBill(id) {
            var obj = document.getElementById('ddlClient');
            var text = obj.options[obj.selectedIndex].text;
            if (id > 0) {
                document.getElementById('chkcredit').checked = true;
                document.getElementById('auth').style.display = "block";
            }
            else if ((id == 0) && (text == 'GENERAL')) {
                document.getElementById('chkcredit').checked = false;
                document.getElementById('auth').style.display = "none";
            }

        }




        function clientdata(id) {
            var hdn = document.getElementById('hdnclient').value;
            var val = document.getElementById(id).value;
            var list = hdn.split('^');
            for (var i = 0; i < list.length; i++) {
                var value = list[i].split('~');
                if (val == value[0]) {

                    document.getElementById('ddlCorporate').value = value[1];
                    document.getElementById('chkcredit').checked = true;
                    document.getElementById('auth').style.display = "block";
                }
            }
            var client = document.getElementById('ddlTPA').value;
            var obj = document.getElementById(id);
            var text = obj.options[obj.selectedIndex].text;
            if (text == '---Select---') {
                document.getElementById('chkcredit').checked = false;
                document.getElementById('auth').style.display = "none";
            }

        }

        function TPAdata(id) {
            var hdn = document.getElementById('hdnTPA').value;
            var val = document.getElementById(id).value;
            var list = hdn.split('^');
            for (var i = 0; i < list.length; i++) {
                var value = list[i].split('~');
                if (val == value[0]) {

                    document.getElementById('ddlCorporate').value = value[1];
                    document.getElementById('chkcredit').checked = true;
                    document.getElementById('auth').style.display = "block";
                }
            }
            var client = document.getElementById('ddlTPA').value;
            var obj = document.getElementById(id);
            var text = obj.options[obj.selectedIndex].text;
            if (text == '---Select---') {
                document.getElementById('chkcredit').checked = false;
                document.getElementById('auth').style.display = "none";
            }



        }

        function showREGFeeBlock() {

            if (document.getElementById('chkRegFee').checked == true) {

                document.getElementById('trREGFee').style.display = "block";

            }
            else {

                document.getElementById('trREGFee').style.display = "none";
            }
        }
        function showCreditBlock() {
            if (document.getElementById('chkCreditLimit').checked == true) {
                document.getElementById('trApproved').style.display = "block";
            }
            else {
                document.getElementById('txtCreditLimt').value = "";
                document.getElementById('txtApprovedBy').value = "";
                document.getElementById('trApproved').style.display = "none";
            }
        }
        function ShowPaymentType() {

            if (document.getElementById('rdoPayNow').checked) {
                document.getElementById('trREGFeePayType').style.display = "block";
                document.getElementById('divAmtPaid').style.display = "block";
                document.getElementById('trREGFee').style.display = "block";

            }

        }
        function ShowPaymentTypeCompleted() {

            if (document.getElementById('rdoPayNow').checked) {
                document.getElementById('trREGFeePayType').style.display = "block";
                document.getElementById('trREGFee').style.display = "block";
                document.getElementById('trREGFeePayType').style.display = "none";

            }

        }
        function HidePaymentType() {

            if (document.getElementById('rdoPayLater').checked) {
                document.getElementById('trREGFeePayType').style.display = "none";
                document.getElementById('txtPayment').value = '0';
                document.getElementById('hdnNowPaid').value = '';
                document.getElementById('PaymentTypes_dvPaymentTable').innerHTML = "";
                document.getElementById('PaymentTypes_hdfPaymentType').value = "";
                PaymentControlclear();
                document.getElementById('divAmtPaid').style.display = "none";
            }

        }

        function ValidateRegFee() {


            if (document.getElementById('chkRegFee').checked == true) {
                var rdoPayNow = document.getElementById('rdoPayNow').checked;
                var rdoPayLater = document.getElementById('rdoPayLater').checked;

                if (rdoPayNow == true) {
                    if (document.getElementById('hdnNowPaid').value != '') {

                        if (document.getElementById('hdnNowPaid').value == document.getElementById('txtRegFee').value) {
                            return true;
                        }
                        else {
                            var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_9');
                            if (userMsg != null) {
                                alert(userMsg);
                            }
                            else {
                                alert('Collect Registration Fee or Select PayLater');
                            }
                            return false;
                        }
                    } else {
                        var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_9');
                        if (userMsg != null) {
                            alert(userMsg);
                            return false ;
                        }
                        else {
                            alert('Collect Registration Fee or Select PayLater');
                            return false ;
                        }
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
      
    </script>

    <style type="text/css">
        .style2
        {
            width: 151px;
        }
    </style>
</head>
<body id="oneColLayout2" onload="pageLoad();" oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnFinish">

<script>

    function ToInternalFormat(pControl) {
        // //debugger;
        if ("<%=LanguageCode%>" == "en-GB") {
            if (pControl.is('span')) {
                return pControl.text();
            }
            else {
                return pControl.val();
            }
        }
        else {
            return pControl.asNumber({ region: "<%=LanguageCode%>" });
        }
    }

    function ToTargetFormat(pControl) {
        // //debugger;
        if ("<%=LanguageCode%>" == "en-GB") {
            if (pControl.is('span')) {
                return pControl.text();
            }
            else {
                return pControl.val();
            }
        }
        else {
            return pControl.formatCurrency({ region: "<%=LanguageCode%>" }).val();
        }
    }
        
        

        

    </script>

    <script language="javascript" type="text/javascript">
    
    
    
    function reCreateDoctorTable() {
    
             
            document.getElementById('trPC').style.display = 'block';
            document.getElementById('rdoPayNow').checked="true";
            
            
            
//            var rwNumber = parseInt(320);
//            var firstRow = false;
//            var HidValue = document.getElementById('hdnPCItems').value;
//            var list = HidValue.split('^');
//            document.getElementById('trPC').style.display = 'block';
//            if (document.getElementById('hdnPCItems').value != "") {
//                for (var count = 0; count < list.length; count++) {
//                    var PCList = list[count].split('~');

//                    if (PCList[1] != '') {
//                        if (PCList[0] != '') {
//                            if (firstRow == false) {
//                            
//                                var row = document.getElementById('tblPCItems').insertRow(0);
//                                row.id = parseInt(rwNumber);
//                                var cell1 = row.insertCell(0);
//                                var cell2 = row.insertCell(1);

//                                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickPC(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
//                                cell1.width = "6%";
//                                cell2.innerHTML = PCList[2];
//                                
//                    
//                            
//                             
//                            } else {

//                            rwNumber = rwNumber + parseInt(1);
//                            var row = document.getElementById('tblPCItems').insertRow(0);
//                            row.id = parseInt(rwNumber);
//                            var cell1 = row.insertCell(0);
//                            var cell2 = row.insertCell(1);

//                            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickPC(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
//                            cell1.width = "6%";
//                            cell2.innerHTML = PCList[2];
//                            }
//                            
//                            
//                            
//                        }
//                         
//                    }
//                }
//            }
        
        }
    
    
    function PopUpPage() {
    
        dDate = document.getElementById('<%= hdnDate.ClientID %>').value;
        dAmount = document.getElementById('hdnAmount').value;
        var dReceiptNo = document.getElementById('<%= hdnReceiptNo.ClientID %>').value ;
        var dBdetNo  = document.getElementById('<%= hdnIPINterID.ClientID %>').value ;
        var sptype = document.getElementById('<%= hdnPayType.ClientID %>').value ;
        if((dAmount !='')&&(Number(dAmount) > 0))
        {
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
            strFeatures = strFeatures + ",left=0,top=0";
            var strURL = "PrintReceiptPage.aspx?Amount=" + dAmount + "&dDate=" + dDate+ "&rcptno=" + dReceiptNo + "&PNAME=<%=Request.QueryString["PNAME"] %>&pdid=" + dBdetNo +"&pDet=" + sptype +"";
            window.open(strURL, "", strFeatures, true);
            
        }
        else
        {//Reception\InPatientRegistration.aspx_22
          var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_22');
                                if (userMsg != null) {
                                    alert(userMsg);
                                }
                                else 
                                {
                                 alert("Please Select a Payment");
                                }
                                return false;
        }
    }
    
    function ClearScriptDatas()
    {
         document.getElementById('<%= hdnAmount.ClientID %>').value="";
         document.getElementById('<%= hdnDate.ClientID %>').value="";
         document.getElementById('<%= hdnNowPaid.ClientID %>').value="";
         document.getElementById('<%= hdnReceiptNo.ClientID %>').value = "";
    }
    function closeData()
    {
    }
    </script>

    <script type="text/javascript">
        function CallPrintReceipt(idValue, dDate, dAmount, dReceiptNo) {
            var previousAmount = document.getElementById('<%= hdnAmount.ClientID %>').value;

            var newAmount = 0;
            if (document.getElementById('<%= hdnPrevControl.ClientID %>').value != "") {
                var valPrevControl = document.getElementById(document.getElementById('<%= hdnPrevControl.ClientID %>').value);
                valPrevControl.checked = false;
            }
            document.getElementById('<%= hdnPrevControl.ClientID %>').value = idValue;
            document.getElementById('<%= hdnReceiptNo.ClientID %>').value = dReceiptNo;
            var objChkBok = document.getElementById(idValue);

            document.getElementById('<%= hdnDate.ClientID %>').value = dDate;
            document.getElementById('<%= hdnAmount.ClientID %>').value = dReceiptNo;
            newAmount = Number(dAmount);

            document.getElementById('<%= hdnAmount.ClientID %>').value = newAmount;
        }


        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {

            if (TotalAmount > 0) {
                var actualAmount = document.getElementById('<%= txtRegFee.ClientID %>').value;

                var ConValue = "OtherCurrencyDisplay1";

                var sVal = getOtherCurrAmtValues("REC", ConValue);
                var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
                var tempService = getOtherCurrAmtValues("SER", ConValue);
                var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

                ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
                sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
                sVal = format_number(Number(sVal) + Number(TotalAmount), 4);

                SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
                var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
                var pScrAmt = Number(pScr) * Number(CurrRate);
                var pAmt = Number(sVal) * Number(CurrRate);


                if (format_number(pAmt, 2) > format_number(actualAmount, 2)) {
                    //Reception\InPatientRegistration.aspx_23
                    var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_23');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert("Total Amount cannot be Greater");
                    }
                    return false;
                }


                document.getElementById('<%= txtPayment.ClientID %>').value = format_number(pAmt, 2);
                document.getElementById('<%= hdnNowPaid.ClientID %>').value = format_number(pAmt, 2);
                document.getElementById('<%= hdnServiceCharge.ClientID %>').value = format_number(pScrAmt, 2);
                document.getElementById('<%= hdnServiceCharge.ClientID %>').value = format_number(pScrAmt, 2);

                SetOtherCurrValues();
                return true;

            }
            else {
                var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_24');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Amount Cannot be Zero");
                }
                return false;
            }
        }


        function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var ConValue = "OtherCurrencyDisplay1";
            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate");

            sVal = Number(Number(sVal) - Number(TotalAmount));
            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);
            //                    sVal = format_number(Number(sVal) - Number(TotalAmount), 2);
            //                    
            //                    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);

            document.getElementById('<%= txtPayment.ClientID %>').value = format_number(sVal, 2);
            document.getElementById('<%= hdnNowPaid.ClientID %>').value = format_number(sVal, 2);
            document.getElementById('<%= txtServiceCharge.ClientID %>').value = format_number(pScrAmt, 2);
            document.getElementById('<%= hdnServiceCharge.ClientID %>').value = format_number(pScrAmt, 2);
            SetOtherCurrValues();
        }

        function chkCreditPament() {
        }


        function CheckAmount() {

            var paidAmount = document.getElementById('<%= txtPayment.ClientID %>').value;
            var actualAmount = document.getElementById('<%= txtRegFee.ClientID %>').value;

            if (Number(actualAmount) > 0) {

                if (Number(paidAmount) < Number(actualAmount)) {
                    //Reception\InPatientRegistration.aspx_25
                    var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_25');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Given Amount is less than the Registration Fee');
                    }
                    return false;
                }
                return true;
            } else {
                var userMsg = SListForApplicationMessages.Get('Reception\\InPatientRegistration.aspx_26');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Registration Fee is Zero');
                }
                return false;

            }


        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
     <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
             
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
                        <asp:TextBox ID="txtPatientNo" runat="server" MaxLength="6" TabIndex="1" Visible="False"
                            meta:resourcekey="txtPatientNoResource1"></asp:TextBox>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server"/>
                            <ContentTemplate>
                                <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                    <tr class="defaultfontcolor">
                                        <td height="32">
                                            <table border="0" id="Table2" cellpadding="4" cellspacing="0" width="100%">
                                                <tr>
                                                    <td colspan="5" id="Td2">
                                                        <asp:Label ID="Rs_AdmissionDetails" Text="Admission Details" runat="server" meta:resourcekey="Rs_AdmissionDetailsResource1"></asp:Label>
                                                        <asp:HiddenField ID="hdnPC" runat="server" />
                                                        <asp:HiddenField ID="hdnCS" runat="server" />
                                                        <asp:HiddenField ID="hdnDO" runat="server" />
                                                        <asp:HiddenField ID="hdnPCItems" runat="server" />
                                                        <asp:HiddenField ID="hdnclient" runat="server" />
                                                        <asp:HiddenField ID="hdnTPA" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Panel7" BorderWidth="1px" CssClass="dataheader2" runat="server" meta:resourcekey="Panel7Resource1">
                                                <p style="margin-top: 5px; margin-bottom: 5px;">
                                                    <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                                        <tr class="defaultfontcolor">
                                                            <td align="right" style="width: 17%;">
                                                                <asp:Label ID="Rs_AdmissionDate" Text="Admission Date" runat="server" meta:resourcekey="Rs_AdmissionDateResource1"></asp:Label>
                                                            </td>
                                                            <td class="style2">
                                                                <asp:TextBox runat="server" ID="txtAdmissionDate"  MaxLength="25" size="25" CssClass ="Txtboxsmall" meta:resourcekey="txtAdmissionDateResource1"></asp:TextBox>
                                                            </td>
                                                            <td id="datecheck" runat="server" align="left">
                                                                <a href="javascript:NewCal('<%=txtAdmissionDate.ClientID %>','ddmmyyyy',true,12)">
                                                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </p>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr class="defaultfontcolor">
                                        <td style="display: none;">
                                            <asp:Panel ID="Panel6" BorderWidth="1px" CssClass="dataheader2" runat="server" meta:resourcekey="Panel6Resource1">
                                                <uc16:ReferedPhysician SpecialityVisiblity="true" ReferringType="Referring Physician : "
                                                    ID="ReferDoctor1" runat="server" />
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr class="defaultfontcolor">
                                        <td>
                                            <asp:Panel ID="Panel5" BorderWidth="1px" CssClass="dataheader2" runat="server" meta:resourcekey="Panel5Resource1">
                                                <p style="margin-top: 5px; margin-bottom: 5px;">
                                                    <%--<table border="0" cellpadding="2" cellspacing="1" width="100%">
                                                        <tr>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_AccompaniedBy" Text="Accompanied By(Attender)" runat="server" meta:resourcekey="Rs_AccompaniedByResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="accompany" MaxLength="60" runat="server" CssClass ="Txtboxsmall" TabIndex="33" meta:resourcekey="accompanyResource1"></asp:TextBox>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_Relationship" Text="Relationship" runat="server" meta:resourcekey="Rs_RelationshipResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtrelationship" runat="server" MaxLength="60" TabIndex="34"  CssClass ="Txtboxsmall" meta:resourcekey="txtrelationshipResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_ContactNo" Text="Contact No" runat="server" meta:resourcekey="Rs_ContactNoResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="relContactNo" runat="server" TabIndex="35" CssClass ="Txtboxsmall" meta:resourcekey="relContactNoResource1"></asp:TextBox>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_EmergencyContactNo" Text="Emergency Contact No" runat="server"
                                                                    meta:resourcekey="Rs_EmergencyContactNoResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="emergencyContactNo" onPaste="Paste_Event();" onbeforepaste="BeforePaste_Event();" CssClass ="Txtboxsmall"
                                                                    runat="server" MaxLength="12" TabIndex="36" meta:resourcekey="emergencyContactNoResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>--%>
                                                    <uc200:ucAD id="ucAttenderDetails" runat="server" ></uc200:ucAD>
                                                </p>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr class="defaultfontcolor">
                                        <td>
                                            <asp:Panel ID="Panel3" BorderWidth="1px" CssClass="dataheader2" runat="server" meta:resourcekey="Panel3Resource1">
                                                <p style="margin-top: 0px; margin-bottom: 0px;">
                                                    <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                                        <tr>
                                                            <td align="right" style="width: 30%;">
                                                                <asp:Label ID="Rs_RegisteredForOrganDonation" Text="Registered For Organ Donation"
                                                                    runat="server" meta:resourcekey="Rs_RegisteredForOrganDonationResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" style="width: 70%;">
                                                                <asp:RadioButtonList ID="regForOrgan" RepeatDirection="Horizontal" runat="server"
                                                                    TabIndex="32" meta:resourcekey="regForOrganResource1">
                                                                    <asp:ListItem Text="Yes" Value="1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                    <asp:ListItem Text="No" Selected="True" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:UpdatePanel ID="pnlPurpose" runat="server">
                                                                    <ContentTemplate>
                                                                        <div id="organDIV" style="display: block; border: 1px;" runat="server">
                                                                            <table border="0" style="border-collapse: collapse; border-color: #f7f7f7;" id="orgDynTab"
                                                                                runat="server" cellpadding="2" cellspacing="1" width="100%">
                                                                                <tr runat="server">
                                                                                    <td align="right" runat="server">
                                                                                        <p style="margin-left: 5px; margin-right: 5px;">
                                                                                            <asp:Label ID="Rs_OrgansRegistered" Text="Organs Registered" runat="server"></asp:Label></p>
                                                                                    </td>
                                                                                    <td runat="server">
                                                                                        <p style="margin-left: 5px; margin-right: 5px;">
                                                                                            <asp:DropDownList ID="organsRegistered" runat="server" CssClass="ddl"  TabIndex="37">
                                                                                            </asp:DropDownList>
                                                                                        </p>
                                                                                    </td>
                                                                                    <td align="right" runat="server">
                                                                                        <p style="margin-left: 5px; margin-right: 5px;">
                                                                                            <asp:Label ID="Rs_RegisteredWithOrganisation" Text="Registered With Organisation"
                                                                                                runat="server"></asp:Label></p>
                                                                                    </td>
                                                                                    <td runat="server">
                                                                                        <p style="margin-left: 5px; margin-right: 5px;">
                                                                                            <asp:TextBox ID="regWithOrganisation" runat="server" MaxLength="60" CssClass="Txtboxsmall" TabIndex="38"></asp:TextBox>
                                                                                        </p>
                                                                                    </td>
                                                                                    <td runat="server">
                                                                                        <p style="margin-right: 20px;">
                                                                                            <asp:Button UseSubmitBehavior="False" ID="btnOrgan" OnClick="btnOrgan_Click" CssClass="btn"
                                                                                                Text="ADD" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                                                runat="server" /></p>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr runat="server">
                                                                                    <td colspan="5" align="center" runat="server">
                                                                                        <p style="margin: 5px;">
                                                                                            <asp:Table CellPadding="4" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="1px"
                                                                                                runat="server" ID="gridTab" Width="100%">
                                                                                                <asp:TableRow CssClass="colorbillprt" BorderWidth="0px" runat="server">
                                                                                                    <asp:TableHeaderCell BorderWidth="0px" runat="server">
                                                                                                        <asp:Label ID="Rs_Remove" Text="Remove" runat="server"></asp:Label>
                                                                                                    </asp:TableHeaderCell>
                                                                                                    <asp:TableHeaderCell runat="server">
                                                                                                        <asp:Label ID="Rs_Organ" Text="Organ" runat="server"></asp:Label>
                                                                                                    </asp:TableHeaderCell>
                                                                                                    <asp:TableHeaderCell runat="server">
                                                                                                        <asp:Label ID="Rs_RegisteredWithOrganization" Text="Registered With Organization"
                                                                                                            runat="server"></asp:Label>
                                                                                                    </asp:TableHeaderCell>
                                                                                                    <asp:TableHeaderCell runat="server"></asp:TableHeaderCell>
                                                                                                    <asp:TableHeaderCell runat="server"></asp:TableHeaderCell>
                                                                                                </asp:TableRow>
                                                                                            </asp:Table>
                                                                                        </p>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                                <input type="hidden" id="did" runat="server"> </input>
                                                                </input> </input> </input> </input> </input> </input>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </p>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr class="defaultfontcolor">
                                        <td>
                                            <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                <ContentTemplate>--%>
                                            <asp:Panel ID="Panel2" BorderWidth="1px" CssClass="dataheader2" runat="server" meta:resourcekey="Panel2Resource1">
                                                <p style="margin-top: 5px; margin-bottom: 5px;">
                                                    <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                                        <tr>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_PurposeOfAdmission" Text="Purpose Of Admission" runat="server"
                                                                    meta:resourcekey="Rs_PurposeOfAdmissionResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="purposeOfAdmission" runat="server" TabIndex="39" CssClass="ddlsmall" meta:resourcekey="purposeOfAdmissionResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_ConditionOnAdmission" Text="Condition On Admission" runat="server"
                                                                    meta:resourcekey="Rs_ConditionOnAdmissionResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ctndOnAdmission" runat="server" TabIndex="40" CssClass="ddlsmall" meta:resourcekey="ctndOnAdmissionResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_PrimaryConsultant" Text="Primary Consultant" runat="server" meta:resourcekey="Rs_PrimaryConsultantResource1"></asp:Label>
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:TextBox ID="txtPrimaryCons" runat="server" meta:resourcekey="txtPrimaryConsResource1" CssClass ="Txtboxsmall"
                                                                    OnChange="javascript:GetTextPC(this.value);" Style="width: 150px;" TabIndex="41"></asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" CompletionInterval="10"
                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                    Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="getVisitingConsultant"
                                                                    ServicePath="~/WebService.asmx" TargetControlID="txtPrimaryCons">
                                                                </ajc:AutoCompleteExtender>
                                                            
                                                                </ajc:TextBoxWatermarkExtender>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                <%--<input type="button" name="btnAddPC" id="btnIPTreatmentPlanAdd" onclick="onClickAddPC();"
                                                                    value="Add" class="btn" tabindex="42" onclick="return btnIPTreatmentPlanAdd_onclick()" />--%>
                                                                    
                                                                    <asp:Button  ID="btnIPTreatmentPlanAdd"   OnClientClick ="javascript:return onClickAddPC();"
                                                                     Text ="Add" CssClass="btn" tabindex="42" runat="server"  meta:resourcekey="btnIPTreatmentPlanAdd1"/>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="trPC" style="display: none;">
                                                            <td valign="top" colspan="4" runat="server">
                                                                <table id="tblPCItems" class="dataheaderInvCtrl" cellpadding="4px" cellspacing="0"
                                                                    width="50%">
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_ConsultingSurgeon" Text="Consulting Surgeon" runat="server" meta:resourcekey="Rs_ConsultingSurgeonResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtSurgen" Style="width: 190px;" OnChange="javascript:GetTextCS(this.value);" CssClass ="Txtboxsmall"
                                                                    TabIndex="44" meta:resourcekey="txtSurgenResource1"></asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtSurgen"
                                                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="10" FirstRowSelected="True"
                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getSurgeon"
                                                                    ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
                                                                </ajc:AutoCompleteExtender>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_MedicalDutyOfficer" Text="Medical Duty Officer" runat="server"
                                                                    meta:resourcekey="Rs_MedicalDutyOfficerResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtDutyOfficer" Style="width: 190px;" OnChange="javascript:GetTextDO(this.value);" CssClass="Txtboxsmall"
                                                                    TabIndex="45" meta:resourcekey="txtDutyOfficerResource1"></asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtDutyOfficer"
                                                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="10" FirstRowSelected="True"
                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDutyOffices"
                                                                    ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
                                                                </ajc:AutoCompleteExtender>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_Speciality" Text="Speciality" runat="server" meta:resourcekey="Rs_SpecialityResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="speciality" runat="server" TabIndex="46"  CssClass="ddlsmall" meta:resourcekey="specialityResource1">
                                                                </asp:DropDownList>
                                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </p>
                                            </asp:Panel>
                                            <%--</ContentTemplate>
                                                            </asp:UpdatePanel>--%>
                                        </td>
                                    </tr>
                                    <tr class="defaultfontcolor" id="trCreditLimit" style="display: none;" runat="server">
                                        <td align="left">
                                            <asp:CheckBox ID="chkCreditLimit" onClick="javascript:showCreditBlock();" Text="Set the credit limit to Patient"
                                                runat="server" meta:resourcekey="chkCreditLimitResource1"></asp:CheckBox>
                                            <asp:HiddenField ID="hdnGrossAmt" runat="server" Value="0.00" />
                                            <asp:HiddenField ID="hdnOldCreditLimitAmount" runat="server" Value="0.00" />
                                        </td>
                                    </tr>
                                    <tr id="trApproved" style="display: none;" runat="server">
                                        <td>
                                            <asp:Label ID="lblCreditLimit" runat="server" Text="Credit Limit Amount" meta:resourcekey="lblCreditLimitResource1"></asp:Label>
                                            <asp:TextBox Style="text-align: right;"   onkeypress="return ValidateOnlyNumeric(this);"   CssClass ="Txtboxsmall"
                                                ID="txtCreditLimt" onblur="if(this.value!='')this.value=parseFloat(this.value).toFixed(2);"
                                                runat="server" meta:resourcekey="txtCreditLimtResource1"></asp:TextBox>
                                            &nbsp; &nbsp;
                                            <asp:Label ID="lblApporverTxt" runat="server" Text="Approved By" meta:resourcekey="lblApporverTxtResource1"></asp:Label>
                                            <asp:TextBox ID="txtApprovedBy" autocomplete="off" CssClass ="Txtboxsmall" runat="server" meta:resourcekey="txtApprovedByResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoGname1" runat="server" TargetControlID="txtApprovedBy"
                                                ServiceMethod="getUserNamesWithLoginID" ServicePath="~/WebService.asmx" EnableCaching="False"
                                                MinimumPrefixLength="2" BehaviorID="AutoCompleteExLstGrp11" CompletionInterval="30"
                                                DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" Enabled="True">
                                            </ajc:AutoCompleteExtender>
                                            &nbsp;
                                            <asp:Label ID="lblCreditRemarks" runat="server" Text="Remarks" meta:resourcekey="lblCreditRemarksResource1"></asp:Label>
                                            <asp:TextBox ID="txtCreditRemarks" onFocus="return expandTextBox(this.id)" onBlur="return collapseTextBox(this.id);"
                                                TextMode="MultiLine" runat="server" meta:resourcekey="txtCreditRemarksResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr class="defaultfontcolor" id="trIsSurgeryPatient" style="display: block;" runat="server">
                                        <td>
                                            <asp:Panel ID="pnlSurgeryPatient" BorderWidth="1px" CssClass="dataheader2" runat="server"
                                                meta:resourcekey="pnlSurgeryPatientResource1">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblSurgeryPatient" runat="server" Text="Surgery Patient" meta:resourcekey="lblSurgeryPatientResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="rblSurgeryPatient" RepeatDirection="Horizontal" runat="server"
                                                                meta:resourcekey="rblSurgeryPatientResource1">
                                                                <asp:ListItem Text="Yes" Value="Y" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                                <asp:ListItem Text="No" Value="N" Selected="True" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div style="vertical-align: text-top; width: 350px;">
                                                <div id="divMore1" onclick="showResponses('divMore1','divMore2','divMore3',1);" style="cursor: pointer;
                                                    display: block;" runat="server">
                                                    &nbsp;<img src="../Images/plus.png" alt="Show" />
                                                    <strong>
                                                        <asp:Label ID="Rs_MedicallyInsuredCorporateInsurance" Text="Medically Insured / Corporate Insurance"
                                                            runat="server" meta:resourcekey="Rs_MedicallyInsuredCorporateInsuranceResource1"></asp:Label></strong>
                                                </div>
                                                <div id="divMore2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('divMore1','divMore2','divMore3',0);"
                                                    runat="server">
                                                    &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                    <strong>
                                                        <asp:Label ID="Rs_MedicallyInsuredCorporateInsurance1" Text="Medically Insured / Corporate Insurance"
                                                            runat="server" meta:resourcekey="Rs_MedicallyInsuredCorporateInsurance1Resource1"></asp:Label></strong>
                                                </div>
                                            </div>
                                            <div id="divMore3" style="display: none;" title="More Details">
                                                <uc19:ClientTpa ID="uctlClientTpa" runat="server" />
                                            </div>
                                        </td>
                                    </tr>
                                    <%--<tr class="defaultfontcolor">
                                    <td>
                                        If Medically Insured / Corporate Insurance
                                    </td>
                                </tr>
                                <tr class="defaultfontcolor">
                                    <td>
                                        <asp:Panel ID="Panel6" BorderWidth="1px" CssClass="dataheader2" runat="server">
                                            <table cellspacing="1px" border="0px" width="100%">
                                                
                                                <tr>
                                                    <td style="width: 30%; padding-left:6px;">
                                                        <asp:CheckBox ID="chkclient" runat="server" Text="Select Client" onclick="javascript:showclient(this.id);" />
                                                    </td>
                                                    <td style="display: none; width: 70%" id="tdclient" runat="server">
                                                        <asp:DropDownList ID="ddlClient" runat="server" onchange="javascript:clientdata(this.id)">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" style="width: 30%">
                                                        <asp:UpdatePanel ID="upnlDDL" runat="server">
                                                            <ContentTemplate>
                                                                <table width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <table border="0px" width="100%">
                                                                                <tr>
                                                                                    <td style="width: 30%">
                                                                                    
                                                                                        <asp:CheckBox ID="chkTPA" runat="server" Text="Select Insurance / TPA" onclick="javascript:showTPA(this.id);" />
                                                                                    
                                                                                    </td>
                                                                                    <td style="display: none; width: 70%" id="tdTPA" runat="server">
                                                                                        <asp:DropDownList AutoPostBack="true" ID="ddlTPA" runat="server" onchange="javascript:TPAdata(this.id);"
                                                                                            OnSelectedIndexChanged="ddlTPA_SelectedIndexChanged">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Panel ID="pnlTPADetails" runat="server" Style="display: none" BorderWidth="0px">
                                                                                <table class="defaultfontcolor" id="tblTPADetails" width="75%" border="1px">
                                                                                    <tr>
                                                                                        <td style="width: 10%">
                                                                                            <asp:Label ID="lblPolicyNo" ForeColor="Black" runat="server" Text="Policy No :"></asp:Label>
                                                                                        </td>
                                                                                        <td style="width: 20%">
                                                                                            <asp:TextBox ID="txtpolicyNo" runat="server"></asp:TextBox>
                                                                                        </td>
                                                                                        <td style="width: 10%">
                                                                                            <asp:Label ID="lblTPALimit" runat="server" Font-Bold="false" ForeColor="Black" Text="TPA Limit :"></asp:Label>
                                                                                        </td>
                                                                                        <td style="width: 20%">
                                                                                            <asp:TextBox ID="txtTPALimit" Width="100px" runat="server"></asp:TextBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="width: 10%">
                                                                                            <asp:Label ID="lblPolicyName" ForeColor="Black" runat="server" Text="Policy Name :"></asp:Label>
                                                                                        </td>
                                                                                        <td style="width: 20%">
                                                                                            <asp:TextBox ID="txtPolicyName" runat="server"></asp:TextBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </asp:Panel>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                <td colspan="2">
                                                 <table cellspacing="1px" border="0px" width="100%">
                                                <tr>
                                                    <td style="width: 30%; padding-left: 10px;">
                                                        Select RateType
                                                    </td>
                                                    <td style="display: block; width: 70%" id="tdCorporate" runat="server">
                                                        <asp:DropDownList ID="ddlCorporate" onChange="javascript:showHideEmployerBlock(this.id);"
                                                            runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                                </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-left:7px;">
                                                        <asp:CheckBox ID="chkcredit" runat="server" Text="IS CreditBill" />
                                                    </td>
                                                </tr>
                                            </table>
                                           
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="auth" runat="server" style="display: none;">
                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                            <ContentTemplate>
                                                <asp:Panel ID="authpnl" runat="server" BorderWidth="1px" CssClass="dataheader2">
                                                    Pre-AuthAmount
                                                    <asp:TextBox ID="txtAuthamount" runat="server" MaxLength="7" Text="0.00" Width="75px"></asp:TextBox>
                                                </asp:Panel>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <%--<tr>
                                <td>
                                    <asp:Panel ID="pnlTPADetails" runat="server" Visible="false" BorderWidth="1px" CssClass="dataheader2">
                                        <table class="defaultfontcolor">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblPolicyNo" ForeColor="Black" runat="server" Text="Policy No :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtpolicyNo" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPolicyName" ForeColor="Black" runat="server" Text="Policy Name :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPolicyName" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTPALimit" runat="server" Font-Bold="false" ForeColor="Black" Text="TPALimit :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTPALimit" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                                <tr>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                            <ContentTemplate>
                                                <asp:Panel ID="pnlAttrib" BorderWidth="1px" CssClass="dataheader2" runat="server">
                                                </asp:Panel>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>--%>
                                    <tr class="defaultfontcolor">
                                        <td>
                                            <asp:Panel ID="Panel4" BorderWidth="1px" CssClass="dataheader2" runat="server">
                                                <p style="margin-top: 5px; margin-bottom: 5px;">
                                                    <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                                        <tr>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_KnowledgeOfOurService" Text="Knowledge Of Our Service" runat="server"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ourService" runat="server" TabIndex="47">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_ServiceProviderName" Text="Service Provider Name" runat="server"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="name" MaxLength="60" runat="server" TabIndex="48"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_InformationProvidedBy" Text="Information Provided By" runat="server"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="informationBy" runat="server" MaxLength="60" TabIndex="49"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </p>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr id="trEmployerBlock" runat="server" style="display: block;" class="defaultfontcolor">
                                        <td>
                                            <table border="0" id="Table1" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td id="Td1">
                                                        <asp:CheckBox ID="chkPED" runat="server" onClick="javascript:showPED();" 
                                                        Text="Patient Employer Details(Use this block if patient is related to any of the staffs in the hospital)"
                                                       meta:resourcekey="chkPED1"  />
                                                    </td>
                                                </tr>
                                                <tr id="trPED" runat="server" style="display: none;">
                                                    <td>
                                                        <asp:Panel ID="Panel1" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                                            <p style="margin-top: 5px; margin-bottom: 5px;">
                                                                <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                                                    <tr>
                                                                        <td align="left">
                                                                            <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                                                                <tr>
                                                                                    <td align="right" style="width: 177px">
                                                                                        <asp:Label ID="Rs_EmployersName" Text="Employer's Name" runat="server"
                                                                                        meta:resourcekey="RsEmployer1"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtEmployerName" runat="server" MaxLength="60" TabIndex="50"></asp:TextBox>
                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Rs_EmployeeName" Text="Employee Name" runat="server"
                                                                                        meta:resourcekey="RsEmployer2"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtEmployeeName" runat="server" MaxLength="60" TabIndex="51"></asp:TextBox>
                                                                                    </td>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Rs_EmployeeNo" Text="Employee No" runat="server"
                                                                                        meta:resourcekey="RsEmployer3"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtEmployeeNo" runat="server" MaxLength="60" TabIndex="52"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="padding-left: 60px;">
                                                                            <!-- <p style="margin-left: 60px;"> -->
                                                                            <uc8:AddressControl ID="employerAddress" runat="server" />
                                                                            <!-- </p> -->
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </p>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="defaultfontcolor">
                                        <td>
                                            <table cellpadding="4" cellspacing="0" border="0" width="40%">
                                                <tr>
                                                    <td>
                                                        <asp:CheckBox ID="chkRTA" runat="server" onClick="javascript:showRTABlock();" Text="MLC Formalities" 
                                                         meta:resourcekey="chkRTA1"/>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="chkRegFee" runat="server" onClick="javascript:showREGFeeBlock();"
                                                            Text="Collect Registration Fee" meta:resourcekey="chkRegFee1"/>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trRTABlock" runat="server" style="display: none;" class="defaultfontcolor">
                                        <td>
                                            <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="98%">
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:CheckBox ID="chkRTAInfluenceOfDrugs" runat="server" Text="Under the influence of Alcohol / Drugs" 
                                                        meta:resourcekey="chkRTAInfluenceOfDrugs1"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 20%;">
                                                        <asp:Label ID="Rs_EventLocation" Text="Event Location" runat="server"
                                                        meta:resourcekey="Rs_EventLocation1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtRTALocation" runat="server"></asp:TextBox>
                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_EventDate" Text="Event Date" runat="server"
                                                        meta:resourcekey="Rs_EventDate1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtRTADate" runat="server" CssClass="txtboxps"></asp:TextBox>
                                                        <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" />
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtRTADate"
                                                            Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                            OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                            ErrorTooltipEnabled="True" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtRTADate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" />&nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtRTADate"
                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_FIRNo" Text="FIR No" runat="server"  meta:resourcekey="Rs_FIRNo1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtRTAFIRNo" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_FIRDate" Text="FIR Date" runat="server" meta:resourcekey="Rs_FIRDate1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtFIRDate" runat="server" CssClass="txtboxps"></asp:TextBox>
                                                        <asp:ImageButton ID="ImgBntCalcFIR" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" />
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFIRDate"
                                                            Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                            OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                            ErrorTooltipEnabled="True" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender1"
                                                            ControlToValidate="txtFIRDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" />
                                                        <ajc:CalendarExtender ID="CalendarExtender5" runat="server" TargetControlID="txtFIRDate"
                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFIR" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_PoliceStation" Text="Police Station" runat="server" meta:resourcekey="Rs_PoliceStation1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPoliceStation" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_MLCNo" Text="MLC No." runat="server" meta:resourcekey="Rs_MLCNo1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtMLCNo" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trREGFee" runat="server" style="display: none;" class="defaultfontcolor">
                                        <td>
                                            <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="98%">
                                                <tr>
                                                    <td align="left" width="30%">
                                                        &nbsp;<asp:Label ID="Rs_RegistrationFee" Text="Registration Fee" runat="server" meta:resourcekey="Rs_RegistrationFee1"></asp:Label>&nbsp;<asp:TextBox
                                                            ID="txtRegFee" runat="server" Width="100px" Enabled="false" ></asp:TextBox>
                                                    </td>
                                                    <td width="30%">
                                                        <asp:RadioButton ID="rdoPayNow" runat="server" GroupName="grprdo" Text="Pay Now" meta:resourcekey="rdoPayNow1"/>
                                                        &nbsp;
                                                        <asp:RadioButton ID="rdoPayLater" runat="server" GroupName="grprdo" Text="Pay Later" meta:resourcekey="rdoPayLater1"/>
                                                    </td>
                                                    <td align="left">
                                                        <div id="divAmtPaid" runat="server" style="display: none;">
                                                            <table width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Rs_AmountPaid" Text="Amount Paid :" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtPayment" Width="70px" Style="text-align: right;" runat="server"
                                                                            ReadOnly="true" CssClass="isocolor">0</asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Rs_ServiceCharge" Text="Service Charge :" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtServiceCharge" Width="70px" Enabled="false" runat="server" Text="0.00"
                                                                            CssClass="textBoxRightAlign" Font-Bold="True" />
                                                                        <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnPrintReceipt" runat="server" Text="Print Receipt" CssClass="btn"
                                                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="javascript:return CheckAmount();"
                                                                            OnClick="SaveRegFee" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" IsDisplayPayedAmount="false"
                                                                        runat="server" />
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <div id="divRegFeePaid" runat="server" visible="false">
                                                            <span class="isocolor">
                                                                <asp:Label ID="lblRegFeeCollectMsg" runat="server" Text=""></asp:Label>
                                                            </span>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr id="trREGFeePayType" runat="server" style="display: none;">
                                                    <td colspan="3" align="center">
                                                        <uc15:PaymentType ID="PaymentTypes" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="4">
                                            <asp:Button ID="btnFinish" Enabled="false" UseSubmitBehavior="true" runat="server"
                                                OnClientClick="return InPatientValidation(this.id);" OnClick="btnFinish_Click"
                                                TabIndex="57" Text="Finish" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnFinish1"/>
                                            <asp:Button ID="btnPrint" Enabled="false" UseSubmitBehavior="true" runat="server"
                                                OnClientClick="return InPatientValidation(this.id);" OnClick="btnPrint_Click"
                                                TabIndex="58" Text="Finish & Print AdmissionDetails" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnPrint1"/>
                                            <asp:Button ID="btnUpdate" Enabled="false" UseSubmitBehavior="true" runat="server"
                                                OnClientClick="return InPatientValidation(this.id);" OnClick="btnUpdate_Click"
                                                TabIndex="59" Text="Update" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnUpdate1"/>
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" 
                                                meta:resourcekey="btnCancel1"/>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                            <%-- <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnPrintReceipt" EventName="Click" />
                            </Triggers>--%>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnURL" runat="server" />
    <input type="hidden" runat="server" id="hdnDate" />
    <input type="hidden" runat="server" id="hdnReceiptNo" />
    <input type="hidden" runat="server" id="hdnPrevControl" />
    <input type="hidden" id="hdnCount" />
    <input type="hidden" runat="server" id="hdnAmount" />
    <input type="hidden" runat="server" id="hdnNowPaid" />
    <input type="hidden" runat="server" id="hdnIPINterID" />
    <input type="hidden" runat="server" id="hdnPayType" />
    <input type="hidden" runat="server" id="hdnRegFeeStatus" />
    <asp:HiddenField ID="hdnClientID" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnOldRoomValue" runat="server"  Value="0"/>
    </form>

    <script language="javascript" type="text/javascript">
        LoadPCItems();
     
    </script>

    <script type ="text/javascript" language ="javascript" >
        function SetOtherCurrValues() {
            var pnetAmt = 0;
            var ConValue = "OtherCurrencyDisplay1";
            SetPaybleOtherCurr(pnetAmt, ConValue, true);
        }
        GetCurrencyValues();
        function SethdnClientID(pValue) {
            document.getElementById('<%= hdnClientID.ClientID %>').value = pValue;
        }
        function btnIPTreatmentPlanAdd_onclick() {

        }
        fu_Tblist();

    </script>

    <script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>

</body>
</html>
