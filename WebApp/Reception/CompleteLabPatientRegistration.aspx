<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CompleteLabPatientRegistration.aspx.cs" Inherits="Reception_CompleteLabPatientRegistration" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/QuickAddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/QuickURNControl.ascx" TagName="URNControl" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/IPClientTpaInsurance.ascx" TagName="ClientTpa"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/PatientCreditLimt.ascx" TagName="CreditLimt"
    TagPrefix="uc22" %>
<%@ Register Src="../CommonControls/DepositUsage.ascx" TagName="DepositUsage" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register Src="../CommonControls/DisplayAllDataTemp.ascx" TagName="DisplayAllData"
    TagPrefix="uc17" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="uc18" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Registration</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <%--<script src="../Scripts/QuickBill.js" type="text/javascript"></script>--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <%--<style type="text/css">
        .list2
        {
            width: 110px;
            border: 1px solid DarkGray;
            list-style-type: none;
            margin: 0px;
            background-color: #fff;
            text-align: left;
            font-weight: normal;
            vertical-align: middle;
            color: Gray;
            font-family: Verdana;
            font-size: 11px;
        }
        ul.list2 li
        {
            padding: 0px 0px;
        }
        .listitem2
        {
            color: Gray;
        }
        .hoverlistitem2
        {
            background-color: #fff;
        }
        .listMain
        {
            background-color: #fff;
            width: 150px;
            max-height: 150px;
            text-align: left;
            list-style: none;
            margin-top: -1px;
            font-weight: normal;
            font-size: 12px;
            overflow: auto;
            padding-left: 1px;
            padding: 0;
        }
        .wordWheel .itemsMain
        {
            background: none;
            width: 150px;
            border-collapse: collapse;
            color: #383838;
            white-space: nowrap;
            text-align: left;
            font-weight: normal;
            font-size: 12px;
        }
        .wordWheel .itemsSelected
        {
            width: 150px;
            color: #ffffff;
            background: #2c88b1;
        }
    </style>--%>

    <script type="text/javascript" language="javascript">
        function showothercouuntry() {
            if (document.getElementById('ucPAdd_ddCountry').value == '190') {
                document.getElementById('ucPAdd_trusother').style.display = 'block'
            }
            else {
                document.getElementById('ucPAdd_trusother').style.display = 'none'
            }
        }
        function showotherState() {
            if (document.getElementById('ucPAdd_ddState').value == '214') {
                document.getElementById('ucPAdd_trusother').style.display = 'block'
            }
            else {
                document.getElementById('ucPAdd_trusother').style.display = 'none'
            }
        }
        //        function SetType(id) {
        //            if (id == 'rdoHospital') {
        //                document.getElementById('hdnRefOrgType').value = "1";
        //            }
        //            else if (id == 'rdoClinic') {
        //                document.getElementById('hdnRefOrgType').value = "2";
        //            }
        //            else {
        //                document.getElementById('hdnRefOrgType').value = "3";
        //            }

        //        }
       
    </script>

</head>
<body onload="pageLoad(); " oncontextmenu="return false;">
    <form id="prFrm" runat="server">
    <%--defaultbutton="btnFinish"--%>

    <script type="text/javascript" language="javascript">

        //Validate Salutation
        function LabPatientRegValidation(id) {

            if (document.getElementById('txtPatientName').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }

                else
                 {
                     alert('Provide patient namProvide patient nameProvide patient namee');
                     return false;
                 }
                document.getElementById('txtPatientName').focus();
                
            }
            if (document.getElementById('ddSex').value == "0") {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_2');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Provide patient name');
                    return false;
                }
                document.getElementById('ddSex').focus();
             
            }
            if (document.getElementById('txtAge').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_3');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }

                else {
                    alert('Provide patient age');
                    return false;
                 }
                document.getElementById('txtAge').focus();
               
            }
            if (document.getElementById('ddlPatientCategory').value == "1") {
                if (document.getElementById('txtward').value == '') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_4');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    }

                    else {
                        alert('Provide ward No');
                        return false;
                     }
                    document.getElementById('txtward').focus();
              
                }
            }

            if (document.getElementById('ucPAdd_txtCity').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_5');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }

                else {
                    alert('Provide city');
                    return false;
                    
                }
                document.getElementById('ucPAdd_txtCity').focus();
            }

            if (document.getElementById('chkPhyOthers').checked) {
                if (document.getElementById('txtDrName').value.trim() == '') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_6');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                       
                    }

                    else {
                        alert('Provide name for doctor');
                        return false;
                        
                    }
                    document.getElementById('txtPhysician').focus();
                }
            }
            else {

            }
            //            if (document.getElementById('ddlHospital').value == "0" && document.getElementById('ddlClinic').value == "0" && document.getElementById('ddlLab').value == "0") {
            //                alert('Select Referring Organization');
            //                document.getElementById('ddlHospital').focus();
            //                return false;
            //            }

            if (document.getElementById('ddlRateType').value == "0") {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_7');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('Select Rate type');
                    return false;
                    
                 }
                document.getElementById('ddlPayerType').focus();
            }

            if ((document.getElementById('rdPackage').checked == true) && (document.getElementById('ddlPkg').options[0].selected == true)) {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_8');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('Select insurance');
                    return false;
                    
                 }
                document.getElementById('ddlPkg').focus();
            }

            if (document.getElementById('ddPublishingMode').value != '0') {
                if (document.getElementById('ddPublishingMode').value == '0' && document.getElementById('txtEmailID').value.trim() == '') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_9');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                        
                    }
                    else {
                        alert('Select publishing mode');
                        return false;
                    }
                    document.getElementById('ddPublishingMode').focus();
                }
                if (document.getElementById('txtName').value.trim() == '') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_10');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                        
                    }

                    else {
                        alert('Provide name');
                        return false;
                        
                    }
                    document.getElementById('txtName').focus();
                }

                if (document.getElementById('shippingAddress_txtCity').value.trim() == '') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_5');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                        
                    }

                    else {
                        alert('Provide city');
                        return false;
                    }
                    document.getElementById('shippingAddress_txtCity').focus();
                }
            }
            if (document.getElementById('iconHid1').value == "") {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_12');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('Order Investigation for Test');
                    return false;
                }
                document.getElementById('txtInvNameold').focus();
            }
            //return checkForCurrentDate('tDOB', 'Date Of Birth');

            //GetKnowledgeDesc();
            chkBill();
            CopyBillItems();
            var ret = SetDueAmount();
            if (ret == true) {
                return true;
            }
            else {
                return false;
            }
            document.getElementById(id).style.visibility = 'hidden';

        }
        function chkBill() {
            var alte1 = PaymentSaveValidation();
            if (alte1 == true) {
                document.getElementById('btnFinish').style.display = 'none';
                return true;
            }
            else {
                return false;
            }
        }

        var z;

        function pageLoad() {
            document.getElementById('ddSalutation').focus();
            //document.getElementById('tDOB').focus();
            if (document.getElementById('rdClient').checked) {
                document.getElementById('divClient').style.display = 'block';
                document.getElementById('divPkg').style.display = 'none';
            }
            else if (document.getElementById('rdPackage').checked) {
                document.getElementById('divClient').style.display = 'none';
                document.getElementById('divPkg').style.display = 'block';
            }
            else {
                document.getElementById('divClient').style.display = 'none';
                document.getElementById('divPkg').style.display = 'none';
            }
            if (document.getElementById('tDOB').value != '') {
                countAgeLab('tDOB');
            }
        }
        function setPhysician() {
            if (document.getElementById('chkPhyOthers').checked) {
                //document.getElementById('ddlPhysician').selectedIndex = 0;
                //document.getElementById('ddlPhysician').options[0].selected = true;
                document.getElementById('txtPhysician').value = "";
                document.getElementById('trPhysician').style.display = 'block';
            }
            else {
                document.getElementById('trPhysician').style.display = 'none';
            }
        }
        function SHHospitalAddress() {
            if ((document.getElementById('ddlHospital').value != "0") || (document.getElementById('ddlClinic').value != "0")) {
                if (document.getElementById('chkHospitalAddress').checked) {
                    document.getElementById('divHospitalAddress').style.display = 'block';
                }
                else {
                    document.getElementById('divHospitalAddress').style.display = 'none';
                }
            }
            if (document.getElementById('ddlHospital').value != "0") {
                document.getElementById('divSHAddressCHKBOX').style.display = 'block';
            }

            if (document.getElementById('ddlClinic').value != "0") {
                document.getElementById('divSHAddressCHKBOX').style.display = 'block';
            }
            if (document.getElementById('ddlHospital').value == "0" && document.getElementById('ddlClinic').value == "0") {
                document.getElementById('divSHAddressCHKBOX').style.display = 'none';
            }
        }


        function resetReferingHospital() {
            if (document.getElementById("ddlHospital")) {
                document.getElementById("ddlHospital").selectedIndex = 0;
            }
            if (document.getElementById("ddlClinic")) {
                document.getElementById("ddlClinic").selectedIndex = 0;
            }

        }

        function showHideClientPackage(rdObj) {
            //            document.getElementById('ddlClients').selectedIndex = 0;
            //            document.getElementById('ddlClients').options[0].selected = true;
            document.getElementById('ddlPkg').selectedIndex = 0;
            document.getElementById('ddlPkg').options[0].selected = true;
            document.getElementById('ddlCollectionCentre').selectedIndex = 0;
            document.getElementById('ddlCollectionCentre').options[0].selected = true;
            if (rdObj.value == '1') {
                document.getElementById('divClient').style.display = 'block';
                document.getElementById('divPkg').style.display = 'none';
            }
            else if (rdObj.value == '2') {
                document.getElementById('divClient').style.display = 'none';
                document.getElementById('divCollectionCentre').style.display = 'none';
                document.getElementById('divPkg').style.display = 'block';
            }
            //else {
            //    document.getElementById('divClient').style.display = 'none';
            //   document.getElementById('divPkg').style.display = 'none';
            // }

        }

        function showHideClientType(rdObj) {
            document.getElementById('ddlHospital').selectedIndex = 0;
            document.getElementById('ddlHospital').options[0].selected = true;
            document.getElementById('ddlClinic').selectedIndex = 0;
            document.getElementById('ddlClinic').options[0].selected = true;
            document.getElementById('chkHospitalAddress').checked = false;
            document.getElementById('divSHAddressCHKBOX').style.display = 'none';
            document.getElementById('divHospitalAddress').style.display = 'none';
            if (rdObj.value == '1') {
                document.getElementById('CTHospital').style.display = 'block';
                document.getElementById('CTBranch').style.display = 'none';
                document.getElementById('CTLab').style.display = 'none';
            }
            else if (rdObj.value == '2') {
                document.getElementById('CTBranch').style.display = 'block';
                document.getElementById('CTHospital').style.display = 'none';
                document.getElementById('CTLab').style.display = 'none';
            }
            else if (rdObj.value == '3') {
                document.getElementById('CTLab').style.display = 'block';
                document.getElementById('CTHospital').style.display = 'none';
                document.getElementById('CTBranch').style.display = 'none';
            }
            else {
                document.getElementById('CTHospital').style.display = 'none';
                document.getElementById('CTBranch').style.display = 'none';
                document.getElementById('CTLab').style.display = 'none';
            }

        }


        function age() {
            if (document.getElementById('txtAge').value.trim() == '') {
                document.getElementById('txtAge').value = '';
            }
        }
        function setClientPackage(x) {
            document.getElementById('ddlCollectionCentre').selectedIndex = 0;
            document.getElementById('ddlCollectionCentre').options[0].selected = true;
            if (x.options[x.selectedIndex].text == 'Collection Centre') {
                document.getElementById('divCollectionCentre').style.display = 'block';
            }
            else {
                document.getElementById('divCollectionCentre').style.display = 'none';

            }
        }

        function setSex() {
            //alert('setSex');
            //            if (document.getElementById('ddSalutation').options[document.getElementById('ddSalutation').selectedIndex].value == 1) {
            //                //  alert('setSex1');
            //                document.getElementById('ddSex').selectedIndex = 0;
            //            }
            //            else if (document.getElementById('ddSalutation').options[document.getElementById('ddSalutation').selectedIndex].value == 2) {
            //                document.getElementById('ddSex').selectedIndex = 1;
            //            }
            //            else if (document.getElementById('ddSalutation').options[document.getElementById('ddSalutation').selectedIndex].value == 9) {
            //                document.getElementById('ddSex').selectedIndex = 1;
            //            }
            var Salutation = document.getElementById('ddSalutation').value;
            // alert(Salutation);

        }

        function ListOver(source, eventArgs) {

            $get("txtPhysician").value = eventArgs.get_value();
        }

        function checkForOthers(id) {
            var grdID = id.split('_');
            var txtID = "gvKOS_" + grdID[1] + "_" + "txtOthers";
            var ddlCTxt = document.getElementById(id).options[document.getElementById(id).selectedIndex].text;
            if (ddlCTxt == "Other") {
                document.getElementById(txtID).style.display = 'block';
            }
            else {
                document.getElementById(txtID).style.display = 'none';
                document.getElementById(txtID).value = "";
            }
        }
        function getDOB() {
            if (document.getElementById('txtAge').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_13');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('Provide age in (days or weeks or months or year) & choose appropriate from the list');
                    return false;
                    
                 }
                document.getElementById('txtAge').focus();
            }
            return true;
        }
        function ClearDOB() {
            var currentTime;
            if (document.getElementById('txtAge').value <= 0) {
                document.getElementById('txtAge').value = '';
            }
            //            if (document.getElementById('tDOB').value == '') {
            //            }
            //            else if (document.getElementById('tDOB').value != '') {
            //                document.getElementById('txtAge').value = '';
            //            }
            //            else if (document.getElementById('txtAge').value == '') {
            //            }
            //            else if (document.getElementById('txtAge').value != '') {
            //                document.getElementById('tDOB').value = '';
            //            }
            if (document.getElementById('ddlAgeUnit').value == 'Year(s)') {

                if (document.getElementById('txtAge').value >= 150) {
                    var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_14');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                        
                    }

                    else {
                        alert('Provide a valid year');
                        return false;
                        
                     }
                    document.getElementById('txtAge').value = '';
                    document.getElementById('txtAge').focus();
                }
                //                currentTime = new Date(); 
                //                var yr = currentTime.getFullYear();
                //                var givenyr = document.getElementById('txtDOBNos').value;
                //                var dobyear = yr - givenyr;
                //                alert('dobyear : ' + dobyear);
            }
            if (document.getElementById('ddlAgeUnit').value == 'Month(s)') {

                if (document.getElementById('txtAge').value >= 2500) {
                    var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_15');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                        
                    }

                    else {
                        alert('Provide a valid month');
                        return false;
                    }
                    document.getElementById('txtAge').value = '';
                    document.getElementById('txtAge').focus();
                }
            }
        }

        function setFocusToPayer() {
            if (document.getElementById('payerTD').style.display == "block") {
                document.getElementById('ddlPayerType').focus();
            }
            else {
                //                document.getElementById('ddlClients').focus();
            }
        }

        function setSalutation() {
            //alert(document.getElementById('ddSex').options[document.getElementById('ddSex').selectedIndex].value);
            if (document.getElementById('ddSex').options[document.getElementById('ddSex').selectedIndex].value == "M") {
                //  alert('setSex1');
                document.getElementById('ddSalutation').selectedIndex = 1;
            }
            else if (document.getElementById('ddSex').options[document.getElementById('ddSex').selectedIndex].value == "F") {
                document.getElementById('ddSalutation').selectedIndex = 2;
            }
            else if (document.getElementById('ddSex').options[document.getElementById('ddSex').selectedIndex].value == "NotKnown") {
                document.getElementById('ddSalutation').selectedIndex = 0;
            }

        }

        function getList(PhyID) {
            if (PhyID != '') {
                var StringSplit = PhyID.split('~');
                if ("1" in StringSplit) {
                    document.getElementById('txtPhysician').value = StringSplit[0];
                    document.getElementById('hdnPhysicianID').value = StringSplit[1];
                    //var orgID = 28;
                    //alert(OrgID);
                    WebService.GetReferingHospital(StringSplit[1], OrgID, OnLookupComplete);
                }
                else {
                    document.getElementById('txtPhysician').value = '';
                    document.getElementById('txtPhysician').focus();
                    var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_16');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                        
                    }

                    else {
                        alert('Select physician name from the list');
                        return false;
                    }

                }
            }
        }
        function OnLookupComplete(result) {
            var ddlPhysician = document.getElementById("ddlHospital");
            var ddltempClinic = document.getElementById("ddlClinic");
            var ddltempLab = document.getElementById("ddlLab");
            //res.innerHTML = "<b>" + result + "</b>";
            //alert(result.length);
            ddlPhysician.innerHTML = "";
            ddltempClinic.innerHTML = "";
            ddltempLab.innerHTML = "";
            var option = document.createElement("option");
            option.value = 0;
            option.innerHTML = "-----Select-----";
            ddlPhysician.appendChild(option);
            ddltempClinic.appendChild(option);
            ddltempLab.appendChild(option);
            for (var n = 0; n < result.length; n++) {
                var optionNew = document.createElement("option");
                //alert(result[0].RefOrgName);
                if (result[n].ClientTypeID == 1) {
                    optionNew.value = result[n].LabRefOrgID;
                    optionNew.innerHTML = result[n].RefOrgNameWithAddress;
                    ddlPhysician.appendChild(optionNew);
                }
                else if (result[n].ClientTypeID == 2) {
                    optionNew.value = result[n].LabRefOrgID;
                    optionNew.innerHTML = result[n].RefOrgNameWithAddress;
                    ddltempClinic.appendChild(optionNew);
                }
                else {
                    optionNew.value = result[n].LabRefOrgID;
                    optionNew.innerHTML = result[n].RefOrgNameWithAddress;
                    ddltempLab.appendChild(optionNew);
                }
            }
        }

        function GetPatientDetails(PID) {

            var pID = PID.split('~');
            //            alert("Se"+PID.search('~'));
            //            alert(pID.length);
            //Venkat (27 Year(s))-(Urn NO :~12

            if (pID.length > 1) {
                functionClear();
                document.getElementById('hdnID').value = '';

                document.getElementById('hdnID').value = pID[1];
                var name = PID.split('(');
                document.getElementById('txtPatientName').value = name[0];

                if (document.getElementById('hdnID').value != '') {
                    pID = document.getElementById('hdnID').value;
                    WebService.GetPatientDetails(pID, OrgID, OnPatientProcesComplete);
                    WebService.GetPreviousDue(pID, OrgID, OnPatientGetPreviousDue);
                }
            }
            else {
                functionClear();
                pID = document.getElementById('hdnID').value = '';
            }
        }
        function OnPatientGetPreviousDue(pPreviousDue) {
            document.getElementById('txtPreviousDue').value = parseFloat(pPreviousDue).toFixed(2);
            document.getElementById('txtGrandTotal').value = 0.00;  //parseFloat(pPreviousDue).toFixed(2);

        }

        function dateformatchange(dateFormat) {
            var today = new Date();
            var dd = dateFormat.getDate();
            var mm = dateFormat.getMonth() + 1; //January is 0!
            var yyyy = dateFormat.getFullYear();
            if (yyyy < '1800') {
                return '';
            }
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

            document.getElementById("txtPatientName").value = patientList[0].Name;
            //alert(patientList[0].DOB);
            var nowdt = new Date();
            nowdt = patientList[0].DOB;
            document.getElementById("tDOB").value = dateformatchange(nowdt);
            document.getElementById("URNControl1_txtURNo").value = patientList[0].URNO;
            document.getElementById("URNControl1_hdnUrn").value = patientList[0].URNO;
            document.getElementById("URNControl1_ddlUrnoOf").value = patientList[0].URNofId;
            document.getElementById("URNControl1_ddlUrnType").value = patientList[0].URNTypeId;
            document.getElementById("txtEmailID").value = patientList[0].EMail;
            document.getElementById("ucPAdd_txtAddress1").value = patientList[0].Name;
            //alert(patientList[0].PatientAge);
            var ageUnit = patientList[0].PatientAge;
            var age = ageUnit.split(' ');
            document.getElementById("txtAge").value = age[0];
            document.getElementById('ddlAgeUnit').value = age[1] == "" ? 'Year(s)' : age[1];
            document.getElementById('hdnPatientID').value = patientList[0].PatientID;

            if (patientList[0].PatientAddress[0].AddressType == "C") {
                //pAddress = patientList[0].PatientAddress[1];
                document.getElementById("ucPAdd_txtAddress1").value = patientList[0].PatientAddress[1].Add1;
                document.getElementById("ucPAdd_txtAddress2").value = patientList[0].PatientAddress[1].Add2;
                document.getElementById("ucPAdd_txtAddress3").value = patientList[0].PatientAddress[1].Add3;
                document.getElementById("ucPAdd_txtCity").value = patientList[0].PatientAddress[1].City;

                document.getElementById("ucPAdd_txtPostalCode").value = patientList[0].PatientAddress[1].PostalCode;
                document.getElementById("ucPAdd_txtMobile").value = patientList[0].PatientAddress[1].MobileNumber;
                document.getElementById("ucPAdd_txtLandLine").value = patientList[0].PatientAddress[1].LandLineNumber;
                document.getElementById("ddCountry").SelectedValue = patientList[0].PatientAddress[1].CountryID;
                document.getElementById("ddCountry").SelectedValue = patientList[0].PatientAddress[1].StateID;
            }
            else {
                //pAddress = patientList[0].PatientAddress[1];
                document.getElementById("ucPAdd_txtAddress1").value = patientList[0].PatientAddress[0].Add1;
                document.getElementById("ucPAdd_txtAddress2").value = patientList[0].PatientAddress[0].Add2;
                document.getElementById("ucPAdd_txtAddress3").value = patientList[0].PatientAddress[0].Add3;
                document.getElementById("ucPAdd_txtCity").value = patientList[0].PatientAddress[0].City;

                document.getElementById("ucPAdd_txtPostalCode").value = patientList[0].PatientAddress[0].PostalCode;
                document.getElementById("ucPAdd_txtMobile").value = patientList[0].PatientAddress[0].MobileNumber;
                document.getElementById("ucPAdd_txtLandLine").value = patientList[0].PatientAddress[0].LandLineNumber;
                document.getElementById("ucPAdd_ddState").value = patientList[0].PatientAddress[0].StateID;
                //document.getElementById("ucPAdd_ddCountry").options[document.getElementById("ucPAdd_ddCountry").selectedIndex].value = patientList[0].PatientAddress[0].CountryID;
                document.getElementById("ucPAdd_ddCountry").value = patientList[0].PatientAddress[0].CountryID;
            }
            //document.getElementById(ddl).options[document.getElementById(ddl).selectedIndex].innerHTML

            document.getElementById('ddSalutation').value = patientList[0].TITLECode;
            document.getElementById('ddSex').value = patientList[0].SEX == '' ? '0' : patientList[0].SEX;

            document.getElementById("ddRace").value = patientList[0].Race == '' ? '0' : patientList[0].Race;
            if (document.getElementById("txtEmailID").value == 'null') {
                document.getElementById("txtEmailID").value = '';
            }
            document.getElementById('DrpRelationtype').value = patientList[0].RelationTypeId; // == '' ? '0' : patientList[0].RelationshipID;
            document.getElementById("txtRelationname").value = patientList[0].RelationName;
            document.getElementById("txtpreviousname").value = patientList[0].PreviousKnownName;
            document.getElementById("TxtAliasname").value = patientList[0].AliasName;



        }
        function ChangeSPP() {
            if (document.getElementById('ddlPayerType').value == '3') {
                //alert('GB');document.getElementById('ddlPayerType').value;
                document.getElementById('divBillGuarantor').style.display = 'block';
                document.getElementById('divddlBillGuarantor').style.display = 'block';
            }
            else {
                //alert('Other');
                document.getElementById('divBillGuarantor').style.display = 'none';
                document.getElementById('divddlBillGuarantor').style.display = 'none';
            }
        }

        function functionClear() {
            //document.getElementById("txtPatientName").value = '';

            document.getElementById("tDOB").value = '';
            document.getElementById("URNControl1_txtURNo").value = '';
            document.getElementById("URNControl1_ddlUrnoOf").value = '1';
            document.getElementById("URNControl1_ddlUrnType").value = '0';
            document.getElementById("txtEmailID").value = '';
            document.getElementById("ucPAdd_txtAddress1").value = '';

            document.getElementById("txtAge").value = '';
            document.getElementById("txtward").value = '';

            document.getElementById('ddlAgeUnit').value = 'Year(s)';

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

            //document.getElementById('ddSalutation').value = '0';
            //document.getElementById('ddSex').value = '0';

            document.getElementById("ddRace").value = '0';

            document.getElementById("txtEmailID").value = '';
            //document.getElementById("ddCountry").value = 0;
            //document.getElementById("ddCountry").value = 0;



        }
        function expandDropDownList(elementRef) {
            elementRef.style.width = '450px';
        }

        function collapseDropDownList(elementRef) {
            elementRef.style.width = elementRef.normalWidth;
        }

        function PatientCategory() {

            if (document.getElementById('ddlPatientCategory').value == '1') {
                document.getElementById('trWardNo').style.display = 'block';
                document.getElementById('hdnPatientVisitType').value = "IP";
                return true;
            }

            else (document.getElementById('ddlPatientCategory').value == '0')
            {
                document.getElementById('trWardNo').style.display = 'none';
                document.getElementById('hdnPatientVisitType').value = "OP";
                return false;
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
                <td width="15%" valign="top" id="menu" style="display: none;">
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
                    <div class="contentdata" style="height: auto; overflow: visible">
                        <asp:Label ID="Rs_RegisterthePatientsDetails" Text="Register the Patient's Details."
                            runat="server"></asp:Label>
                        <table border="0" cellpadding="1" cellspacing="1" width="100%">
                            <!-- Patient Details Part -->
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel1" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="padding-top: 5px;">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr valign="top" style="height: 25px;">
                                                            <td>
                                                                <table border="0" cellpadding="1" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <table>
                                                                                <tr>
                                                                                    <td align="right" style="width: 10%;">
                                                                                        <asp:Label ID="Rs_PatientsName" runat="server" CssClass="bilddltb" 
                                                                                            Text="Patient's Name"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 25%;">
                                                                                        <asp:DropDownList ID="ddSalutation" runat="server" CssClass="bilddltb" 
                                                                                            onchange="javascript:return setSex();" TabIndex="1" ToolTip="Select Salutation" 
                                                                                            Width="80px">
                                                                                        </asp:DropDownList>
                                                                                        <asp:TextBox ID="txtPatientName" runat="server" CssClass="biltextb" 
                                                                                            MaxLength="60" 
                                                                                            onblur="ConverttoUpperCase(this.id); GetPatientDetails(this.value);" 
                                                                                            TabIndex="2" ToolTip="Patient Name"></asp:TextBox>
                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" 
                                                                                            CompletionInterval="100" CompletionListCssClass="listtwo" 
                                                                                            CompletionListHighlightedItemCssClass="hoverlistitemtwo" 
                                                                                            CompletionListItemCssClass="listitemtwo" CompletionSetCount="10" 
                                                                                            EnableCaching="false" FirstRowSelected="true" MinimumPrefixLength="2" 
                                                                                            ServiceMethod="GetPatientListWithDetails" 
                                                                                            ServicePath="~/InventoryWebService.asmx" TargetControlID="txtPatientName">
                                                                                        </ajc:AutoCompleteExtender>
                                                                                        &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                                                                    </td>
                                                                                    <td style="width: 30%;">
                                                                                        <table>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <table>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <asp:Label ID="Rs_PatientCategory" runat="server" CssClass="biltextb" 
                                                                                                                    Text="Patient Category"></asp:Label>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:DropDownList ID="ddlPatientCategory" runat="server" CssClass="bilddltb" 
                                                                                                                    onchange="javascript:return PatientCategory();" TabIndex="3">
                                                                                                                    <asp:ListItem Value="0">OP</asp:ListItem>
                                                                                                                    <asp:ListItem Value="1">IP</asp:ListItem>
                                                                                                                </asp:DropDownList>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <table>
                                                                                                        <tr ID="trWardNo" runat="server" style="display: none;">
                                                                                                            <td align="right">
                                                                                                                <asp:Label ID="lblWard" runat="server" CssClass="biltextb" Text="WardNo"></asp:Label>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:TextBox ID="txtward" runat="server" CssClass="biltextb" TabIndex="4" 
                                                                                                                    Width="65px"></asp:TextBox>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                    <td align="right" style="width: 15%; display: block;">
                                                                                        <asp:Label ID="Rs_Priority" runat="server" CssClass="biltextb" Text="Priority"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 15%; display: block;">
                                                                                        <asp:DropDownList ID="ddlPriority" runat="server" CssClass="bilddltb" 
                                                                                            TabIndex="4" ToolTip="Select Work Order Priority" Width="69px">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" colspan="4" style="padding-bottom: 1px;">
                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <table style="width: 100%;" border="1" cellpadding="1" cellspacing="1" class="tabledata">
                                                                                <tr>
                                                                                    <td align="left" style="width: 5%;">
                                                                                        <asp:Label ID="lblPreviousname" runat="server" Text="Previously Known as :" CssClass="biltextb"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 10%;">
                                                                                        <asp:TextBox ID="txtpreviousname" runat="server" TabIndex="4" CssClass="biltextb"> </asp:TextBox>
                                                                                    </td>
                                                                                    <td align="left" style="width: 5%;">
                                                                                        <asp:Label ID="LblAlias" runat="server" Text="Alias Name :" CssClass="biltextb"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 10%;">
                                                                                        <asp:TextBox ID="TxtAliasname" runat="server" TabIndex="5" CssClass="biltextb"></asp:TextBox>
                                                                                    </td>
                                                                                    <td align="left" style="width: 5%;">
                                                                                        <asp:Label ID="LblRtype" runat="server" Text="Relation Type :" CssClass="biltextb"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 10%;">
                                                                                        <asp:DropDownList ID="DrpRelationtype" runat="server" TabIndex="6" CssClass="bilddltb">
                                                                                            <asp:ListItem>--Select--</asp:ListItem>
                                                                                            <asp:ListItem>Father</asp:ListItem>
                                                                                            <asp:ListItem>Mother</asp:ListItem>
                                                                                            <asp:ListItem>Spouse</asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td style="width: 5%;" align="left">
                                                                                        <asp:Label ID="lblRelationName" runat="server" Text="Relation Name :" CssClass="biltextb"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 10%;">
                                                                                        <asp:TextBox ID="txtRelationname" runat="server" TabIndex="7" CssClass="biltextb"></asp:TextBox>
                                                                                    </td>
                                                                                    <td style="width: 5%">
                                                                                        &nbsp;
                                                                                    </td>
                                                                                    <td style="width: 10%">
                                                                                        &nbsp;
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="10">
                                                                                        <uc8:AddressControl ID="ucPAdd" runat="server" TabIndex="8" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="5" style="padding-bottom: 1px;">
                                                                <table border="0" width="100%" cellpadding="1" cellspacing="1">
                                                                    <tr>
                                                                        <td align="right" style="width: 5%;">
                                                                            <asp:Label ID="Rs_Nationality" Text="Nationality" runat="server" CssClass="biltextb"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 10%">
                                                                            <asp:DropDownList ID="ddlNationality" runat="server" TabIndex="18" CssClass="bilddltb">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td align="right" style="width: 5%">
                                                                            <asp:Label ID="Rs_Sex" Text="Sex" runat="server" CssClass="biltextb"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 10%;">
                                                                            <asp:DropDownList ID="ddSex" runat="server" ToolTip="Select Sex" TabIndex="19" CssClass="bilddltb">
                                                                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                                                <asp:ListItem Value="M">Male</asp:ListItem>
                                                                                <asp:ListItem Value="F">Female</asp:ListItem>
                                                                                <asp:ListItem Value="NotKnown">NotKnown</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                        </td>
                                                                        <td align="right" style="width: 5%">
                                                                            <asp:Label ID="Rs_DateofBirth" Text="Date of Birth" runat="server" CssClass="biltextb"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 12%">
                                                                            <asp:TextBox ID="tDOB" ToolTip="Date Of Birth" runat="server" Width="130px" MaxLength="1"
                                                                                Style="text-align: justify" ValidationGroup="MKE" TabIndex="20" onblur="javascript:countAgeLab(this.id);"
                                                                                CssClass="biltextb" />
                                                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                CausesValidation="False" />
                                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="tDOB"
                                                                                Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                                OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                                                ErrorTooltipEnabled="True" />
                                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                                                ControlToValidate="tDOB" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                                ValidationGroup="MKE" />
                                                                            <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="tDOB"
                                                                                PopupButtonID="ImageButton1" Format="dd/MM/yyyy" />
                                                                        </td>
                                                                        <td style="width: 5%" align="right">
                                                                            <asp:Label ID="Rs_Age" Text="Age" runat="server" CssClass="biltextb"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 13%">
                                                                            <asp:TextBox ID="txtAge" ToolTip="Age" Width="65px" runat="server" MaxLength="3"
                                                                                TabIndex="20" onblur="javascript:ClearDOB();" CssClass="biltextb"></asp:TextBox>
                                                                            <asp:DropDownList ID="ddlAgeUnit" TabIndex="21" onblur="javascript:ClearDOB();" onChange="javascript:getDOB();"
                                                                                runat="server" ToolTip="Select Age Duration" CssClass="bilddltb">
                                                                                <asp:ListItem Value="Day(s)">Day(s)</asp:ListItem>
                                                                                <asp:ListItem Value="Week(s)">Week(s)</asp:ListItem>
                                                                                <asp:ListItem Value="Month(s)">Month(s)</asp:ListItem>
                                                                                <asp:ListItem Value="Year(s)" Selected="True">Year(s)</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" /><img src="../Images/starbutton.png"
                                                                                alt="" align="middle" />
                                                                        </td>
                                                                        <td align="right" style="width: 5%;">
                                                                            <asp:Label ID="Rs_Race" Text="Race" runat="server" CssClass="biltextb"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 10%">
                                                                            <asp:DropDownList ID="ddRace" runat="server" TabIndex="22" CssClass="bilddltb">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right" style="width: 5%">
                                                                            <asp:Label ID="Rs_email" Text="e-mail" runat="server" CssClass="biltextb"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 10%;">
                                                                            <asp:TextBox ID="txtEmailID" runat="server" ToolTip="Contact E-Mail Address" MaxLength="60"
                                                                                TabIndex="23" CssClass="biltextb"></asp:TextBox>
                                                                        </td>
                                                                        <td colspan="2" style="width: 5%">
                                                                            <table cellpadding="1" cellspacing="0" border="0" width="100%">
                                                                                <tr>
                                                                                    <td align="right" style="display: none;">
                                                                                        <asp:Label ID="Rs_Mobile1" Text="Mobile" runat="server" CssClass="biltextb"></asp:Label>
                                                                                    </td>
                                                                                    <td style="display: none;">
                                                                                        <asp:TextBox ID="txtMobile" ToolTip="Contact Mobile Number" runat="server" CssClass="biltextb"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td>
                                                                        </td>
                                                                        <td>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                                <uc7:URNControl ID="URNControl1" runat="server" TabIndex="25" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <!-- Refering Physician Part -->
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel3" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td style="padding-top: 1px;">
                                                                <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td align="right" style="width: 15%;">
                                                                            <asp:Label ID="Rs_ReferingPhysicianName" Text="Refering Physician Name" runat="server"
                                                                                CssClass="biltextb"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 20%;">
                                                                            <asp:TextBox ID="txtPhysician" ToolTip="Refering Physician(Doctor) Name" runat="server"
                                                                                autocomplete="off" Width="200px" TabIndex="29" onblur="ConverttoUpperCase(this.id); getList(this.value);"
                                                                                CssClass="biltextb"></asp:TextBox>
                                                                            <%-- &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                                            <ajc:AutoCompleteExtender ID="AutoRname" runat="server" TargetControlID="txtPhysician"
                                                                                FirstRowSelected="true" ServiceMethod="GetPhysician" ServicePath="~/WebService.asmx"
                                                                                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="2" BehaviorID="AutoCompleteEx1"
                                                                                CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                                                            </ajc:AutoCompleteExtender>
                                                                        </td>
                                                                        <td style="font-weight: normal; height: 20px; color: #000; width: 30%; display: none;
                                                                            width: 20%;" align="left">
                                                                            <asp:UpdatePanel ID="Up2" runat="server">
                                                                                <ContentTemplate>
                                                                                    <asp:LinkButton ForeColor="Red" runat="server" ToolTip="Click here to add new Referring Physician"
                                                                                        ID="lnkAddnew" Text="Add New Ref Physician" OnClick="lnkAddnew_Click" CssClass="biltextb"></asp:LinkButton>
                                                                                    <asp:Label ID="ltrMsg" runat="server"></asp:Label>
                                                                                </ContentTemplate>
                                                                            </asp:UpdatePanel>
                                                                        </td>
                                                                        <td style="width: 15%; display: none;">
                                                                            <asp:Label ID="Rs_IfOthers" Text="If Others" runat="server" CssClass="biltextb"></asp:Label><input
                                                                                type="checkbox" id="chkPhyOthers" onclick="javascript:setPhysician();" runat="server"
                                                                                value="1" />
                                                                        </td>
                                                                        <td style="width: 15%;">
                                                                        </td>
                                                                        <td style="width: 15%;">
                                                                        </td>
                                                                        <td align="left" colspan="2" style="width: 20%;">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="padding-bottom: 1px;">
                                                                <div id="trPhysician" style="display: none;" runat="server">
                                                                    <table border="0" cellpadding="1" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td style="width: 15%;" align="right">
                                                                                <asp:Label ID="Rs_ReferringPhysicianName" Text="Referring Physician Name" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td align="left" style="width: 20%;">
                                                                                <asp:TextBox ID="txtDrName" ToolTip="Referring Physician(Doctor) Name" runat="server"
                                                                                    MaxLength="60"></asp:TextBox>
                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                            </td>
                                                                            <td style="width: 10%;" align="right">
                                                                                <asp:Label ID="Rs_Qualification" Text="Qualification" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td align="left" style="width: 10%;">
                                                                                <asp:TextBox ID="txtDrQualification" ToolTip="Referring Physician(Doctor) Qualification"
                                                                                    runat="server" MaxLength="40" Width="100px"></asp:TextBox>
                                                                            </td>
                                                                            <td style="width: 10%;" align="right">
                                                                                <asp:Label ID="Rs_Organization" Text="Organization" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td align="center" style="width: 10%;">
                                                                                <asp:TextBox ID="txtDrOrganization" ToolTip="Referring Physician(Doctor) Organisation"
                                                                                    runat="server" MaxLength="60"></asp:TextBox>
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
                                </td>
                            </tr>
                            <!-- Refering Hospital Part -->
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel7" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                        <tr style="display: none;">
                                                            <td style="width: 32%;">
                                                                <asp:Panel ID="pnRefOrg" Width="60%" GroupingText="Referring Organization Type" runat="server">
                                                                    <asp:RadioButton ID="rdoHospital" type="radio" Text="Hospital" Checked="true" GroupName="RefOrgType1"
                                                                        value="1" onclick="javascript:showHideClientType(this);" runat="server" />
                                                                    <asp:RadioButton ID="rdoBranch" TabIndex="31" type="radio" Text="Clinic" value="2"
                                                                        GroupName="RefOrgType1" onclick="javascript:showHideClientType(this);" runat="server" />
                                                                    <asp:RadioButton ID="rdoRLab" TabIndex="32" type="radio" Text="Lab" value="3" GroupName="RefOrgType1"
                                                                        onclick="javascript:showHideClientType(this);" runat="server" />
                                                                    <%--<input id="rdOthers" tabindex="24" type="radio" name="clientType" value="3" onclick="javascript:showHideClientType(this);"
                                                                    runat="server" /><label id="lblOthers" runat="server">Others</label>--%></asp:Panel>
                                                            </td>
                                                            <td style="width: 40%;" align="left">
                                                                <div id="CTHospital" runat="server">
                                                                    <asp:DropDownList ID="ddlHospital" ToolTip="Select Refering Hospital" runat="server"
                                                                        onchange="javascript:SHHospitalAddress();collapseDropDownList(this);" Width="250px"
                                                                        OnSelectedIndexChanged="ddlHospital_SelectedIndexChanged" normalWidth="250px"
                                                                        onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);"
                                                                        AutoPostBack="false" TabIndex="33">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </div>
                                                                <div id="CTBranch" runat="server" style="display: none;">
                                                                    <asp:DropDownList ID="ddlClinic" ToolTip="Select Refering Branch" runat="server"
                                                                        onchange="javascript:SHHospitalAddress();" AutoPostBack="true" TabIndex="34"
                                                                        OnSelectedIndexChanged="ddlClinic_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </div>
                                                                <div id="CTLab" runat="server" style="display: none;">
                                                                    <asp:DropDownList ID="ddlLab" TabIndex="35" ToolTip="Select Refering Lab" runat="server"
                                                                        onchange="javascript:SHHospitalAddress();" AutoPostBack="true" OnSelectedIndexChanged="ddlLab_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 20%; display: none;">
                                                                <div id="divSHAddressCHKBOX" runat="server" style="display: none;">
                                                                    <asp:Label ID="Rs_ShowAddress" Text="Show Address" runat="server"></asp:Label><input
                                                                        type="checkbox" id="chkHospitalAddress" onclick="javascript:SHHospitalAddress();"
                                                                        runat="server" value="1" />
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 15%;" align="right">
                                                                <asp:Label ID="lblReferringOrganization" runat="server" Text="Referring Organization:"
                                                                    CssClass="biltextb"></asp:Label>
                                                            </td>
                                                            <td style="width: 20%;">
                                                                <asp:TextBox ID="txtReferringOrganization" runat="server" Width="200px" TabIndex="30"
                                                                    CssClass="biltextb"></asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtReferringOrganization"
                                                                    EnableCaching="false" FirstRowSelected="true" CompletionInterval="1" CompletionSetCount="10"
                                                                    MinimumPrefixLength="1" CompletionListCssClass="listtwo" CompletionListItemCssClass="listitemtwo"
                                                                    CompletionListHighlightedItemCssClass="hoverlistitemtwo" ServiceMethod="GetReferringOrganization"
                                                                    ServicePath="~/WebService.asmx" OnClientItemSelected="IAmRefOrgSelected">
                                                                </ajc:AutoCompleteExtender>
                                                            </td>
                                                            <td style="font-weight: normal; height: 15px; color: #000; width: 20%; display: none;"
                                                                align="center">
                                                                <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:LinkButton ForeColor="Red" runat="server" ToolTip="Click Here to add new Referring Clinic"
                                                                            ID="lnkNewClinic" Text="Add New Ref.Organization" OnClick="lnkNewClinic_Click"
                                                                            CssClass="biltextb"></asp:LinkButton>
                                                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </td>
                                                            <td style="width: 15%;" align="right">
                                                                <input id="rdClient" type="radio" tabindex="41" name="price" runat="server" checked
                                                                    value="1" cssclass="biltextb" />
                                                                <label id="lblClient" runat="server">
                                                                    Price Structure</label>
                                                                <input id="rdPackage" type="radio" name="price" value="2" onclick="javascript:showHideClientPackage(this);"
                                                                    runat="server" /><label id="lblPackage" runat="server">Insurance</label>
                                                            </td>
                                                            <td style="width: 15%;">
                                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="ddlRateType" TabIndex="42" ToolTip="Select Price Structure"
                                                                            runat="server" onchange="javascript:SetRateID();" CssClass="bilddltb">
                                                                        </asp:DropDownList>
                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    </ContentTemplate>
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="ddlPayerType" EventName="SelectedIndexChanged" />
                                                                        <asp:AsyncPostBackTrigger ControlID="ddlTPAnew" EventName="SelectedIndexChanged" />
                                                                        <asp:AsyncPostBackTrigger ControlID="ddlClientnew" EventName="SelectedIndexChanged" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
                                                            </td>
                                                            <td align="left" colspan="2" style="width: 20%;">
                                                                <div id="divisCredit" style="display: block;" runat="server">
                                                                    <asp:CheckBox ID="chkisCreditTransaction" TabIndex="43" runat="server" class="defaultfontcolor"
                                                                        onclick="checkIsCredit();" Text="Credit Transaction" CssClass="biltextb" />
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="display: none;" id="divHospitalAddress" runat="server">
                                        <asp:Panel ID="Panel5" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td style="padding-top: 1px;">
                                                        <table border="0" cellpadding="1" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td align="right" style="width: 18%;">
                                                                    <asp:Label ID="Rs_Address" Text="Address" runat="server"></asp:Label>
                                                                </td>
                                                                <td style="width: 82%;">
                                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                        <ContentTemplate>
                                                                            <asp:TextBox ID="txtHospitalAddress" ToolTip="Refering Hospital Address" runat="server"
                                                                                TextMode="MultiLine" Rows="4" ReadOnly Columns="50" CssClass="biltextb"></asp:TextBox>
                                                                            &nbsp; &nbsp;
                                                                        </ContentTemplate>
                                                                        <Triggers>
                                                                            <asp:AsyncPostBackTrigger ControlID="ddlHospital" EventName="SelectedIndexChanged" />
                                                                            <asp:AsyncPostBackTrigger ControlID="ddlClinic" EventName="SelectedIndexChanged" />
                                                                            <asp:AsyncPostBackTrigger ControlID="ddlLab" EventName="SelectedIndexChanged" />
                                                                        </Triggers>
                                                                    </asp:UpdatePanel>
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
                            <!-- Payer,Client/TPA,Rates Part -->
                            <tr id="payerTR" runat="server" style="display: none;">
                                <td id="payerTD" runat="server">
                                    <asp:Panel ID="Panel8" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="padding: 3px;">
                                                    <table border="0" cellpadding="1" cellspacing="0" width="100%">
                                                        <tr id="trpayer" runat="server" style="display: none;">
                                                            <td style="width: 10%; display: none;" align="right" id="payerTitleTD" runat="server">
                                                                <asp:Label ID="Rs_PayerType" Text="Payer Type" runat="server"></asp:Label>
                                                            </td>
                                                            <td style="width: 15%;">
                                                                <div id="payerDiv" runat="server" style="display: block;">
                                                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                                        <ContentTemplate>
                                                                            <asp:DropDownList ID="ddlPayerType" onchange="javascript:ChangeSPP();" ToolTip="Select Payer"
                                                                                AutoPostBack="true" OnSelectedIndexChanged="ddlPayerType_SelectedIndexChanged"
                                                                                runat="server">
                                                                            </asp:DropDownList>
                                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                        </ContentTemplate>
                                                                        <Triggers>
                                                                            <asp:AsyncPostBackTrigger ControlID="ddlHospital" EventName="SelectedIndexChanged" />
                                                                            <asp:AsyncPostBackTrigger ControlID="ddlClinic" EventName="SelectedIndexChanged" />
                                                                            <asp:AsyncPostBackTrigger ControlID="ddlLab" EventName="SelectedIndexChanged" />
                                                                        </Triggers>
                                                                    </asp:UpdatePanel>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 10%;" align="right">
                                                                <div id="divBillGuarantor" style="display: block;" runat="server">
                                                                    <asp:Label ID="Rs_BillGuarantor" Text="Client & Insurance/TPA" runat="server"></asp:Label></div>
                                                            </td>
                                                            <td id="tdddlBillGuarantor" style="width: 40%;" nowrap="nowrap">
                                                                <div id="divddlBillGuarantor" style="display: block;" runat="server">
                                                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                                        <ContentTemplate>
                                                                            <div id="divMore3" style="display: block;" title="Client And Insurance / TPA">
                                                                                <%--<uc9:ClientTpa IsQuickBill="Y" ID="uctlClientTpa" runat="server" />--%>
                                                                                <table id="tbTable" class="defaultfontcolor" runat="server" cellspacing="0" border="0"
                                                                                    width="100%">
                                                                                    <tr>
                                                                                        <td class="style1">
                                                                                            <asp:RadioButton ID="rdoTpa" runat="server" TabIndex="36" Text="Insurance/TPA" GroupName="clientTpa"
                                                                                                onclick="javascript:showTPA(this.id);" />
                                                                                            <asp:RadioButton ID="rdoClient" runat="server" TabIndex="37" Text="Client" GroupName="clientTpa"
                                                                                                onclick="javascript:showclient(this.id);" />&nbsp;
                                                                                            <asp:RadioButton ID="rdoNone" runat="server" TabIndex="38" Text="None" GroupName="clientTpa"
                                                                                                onclick="javascript:showNone(this.id);" Checked="true" />
                                                                                            <asp:GridView ID="gvKOS" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvKOS_RowDataBound"
                                                                                                Width="50%">
                                                                                                <Columns>
                                                                                                    <asp:TemplateField ItemStyle-Width="5%">
                                                                                                        <ItemTemplate>
                                                                                                            <asp:CheckBox ID="chk" runat="server" />
                                                                                                            <asp:Label ID="lblKOSID" runat="server" Text='<%#Bind("KnowledgeOfServiceID") %>'
                                                                                                                Visible="false"></asp:Label>
                                                                                                        </ItemTemplate>
                                                                                                        <ItemStyle Width="1%" />
                                                                                                    </asp:TemplateField>
                                                                                                    <asp:TemplateField>
                                                                                                        <ItemTemplate>
                                                                                                            <asp:Label ID="lblKOS" runat="server" Text='<%#Bind("KnowledgeOfServiceName") %>'></asp:Label>
                                                                                                        </ItemTemplate>
                                                                                                    </asp:TemplateField>
                                                                                                    <asp:TemplateField>
                                                                                                        <ItemTemplate>
                                                                                                            <asp:DropDownList ID="ddlAttributes" runat="server" onchange="javascript:checkForOthers(this.id);">
                                                                                                            </asp:DropDownList>
                                                                                                            <asp:TextBox ID="txtOthers" runat="server"></asp:TextBox>
                                                                                                        </ItemTemplate>
                                                                                                    </asp:TemplateField>
                                                                                                </Columns>
                                                                                            </asp:GridView>
                                                                                        </td>
                                                                                        <td>
                                                                                            <table id="tdTPA" runat="server" style="display: none;">
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                                                                                            <ContentTemplate>
                                                                                                                <asp:DropDownList ID="ddlTPAnew" runat="server" TabIndex="39" OnSelectedIndexChanged="ddlTPA_SelectedIndexChanged"
                                                                                                                    onchange="javascript:PopUpAttributePage();" AutoPostBack="false">
                                                                                                                </asp:DropDownList>
                                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                <%-- onchange="javascript:TPAdata(this.id);"  OnSelectedIndexChanged="ddlTPA_SelectedIndexChanged"--%>
                                                                                                                <input type="hidden" id="hdnTPAValue" runat="server" />
                                                                                                                <input type="hidden" id="hdnTempTPAValue" runat="server" />
                                                                                                                <input type="hidden" id="hdnTPAClientAtttrbuteValue" runat="server" />
                                                                                                            </ContentTemplate>
                                                                                                        </asp:UpdatePanel>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                            <table id="tdclient" runat="server" style="display: none;">
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                                                                                            <ContentTemplate>
                                                                                                                <asp:DropDownList ID="ddlClientnew" runat="server" TabIndex="40" OnSelectedIndexChanged="ddlClient_SelectedIndexChanged"
                                                                                                                    onchange="javascript:PopUpAttributePage()" AutoPostBack="false">
                                                                                                                </asp:DropDownList>
                                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                <%--  onchange="javascript:clientdata(this.id)" --%>
                                                                                                                <input type="hidden" id="hdnClientValue" runat="server" />
                                                                                                            </ContentTemplate>
                                                                                                        </asp:UpdatePanel>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </ContentTemplate>
                                                                    </asp:UpdatePanel>
                                                                </div>
                                                            </td>
                                                            <td style="width: 15%;">
                                                                <div id="divClient" runat="server">
                                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <!-- Order Onvestigation Part -->
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                        <ContentTemplate>
                                            <asp:Panel ID="Panel9" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                                <table border="1" cellpadding="0" cellspacing="0" width="100%">
                                                    <tr align="left">
                                                        <td align="right" style="padding: 1px; width: 15%">
                                                            <asp:Label ID="Rs_InvName" runat="server" Text="Investigation Name: " CssClass="biltextb"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:TextBox ID="txtInvNameold" runat="server" onblur="return IsValid();" onfocus="chkPros();"
                                                                TabIndex="44" CssClass="biltextb"></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" CompletionInterval="0"
                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" OnClientItemSelected="IAmSelectedold"
                                                                ServiceMethod="GetQuickBillItems" ServicePath="~/OPIPBilling.asmx" TargetControlID="txtInvNameold"
                                                                UseContextKey="True">
                                                            </ajc:AutoCompleteExtender>
                                                        </td>
                                                        <td align="right" style="padding: 3px; width: 20%">
                                                            <asp:Label ID="lblamount" runat="server" Text="Amount: " CssClass="biltextb"></asp:Label>
                                                        </td>
                                                        <td align="left" style="padding: 3px; width: 15%">
                                                            <asp:TextBox ID="txtInvAmount" runat="server" TabIndex="45" CssClass="biltextb"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="padding: 3px; width: 15%" colspan="2">
                                                            <input id="btnAddInv" class="btn" onclick="freetxtCheck();" style="width: 70px;"
                                                                tabindex="46" type="button" value="Add" cssclass="biltextb" />
                                                        </td>
                                                        <td style="width: 20%;">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 60%" colspan="5" valign="top">
                                                            <%--<table cellpadding="0px" cellspacing="0" width="96%">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblHeader" runat="server" class="ddfonts"> Ordered Investigations&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Physician Fee</asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>--%>
                                                            <table id="tblOrederedInves" border="1" cellpadding="4px" cellspacing="0" class="dataheaderInvCtrl"
                                                                style="display: none" width="96%">
                                                                <tr class="dataheader1">
                                                                    <td style="width: 5%">
                                                                    </td>
                                                                    <td style="width: 40%">
                                                                        <asp:Label ID="Rs_Attributes" runat="server" Text="Ordered Investigations"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 20%">
                                                                        <asp:Label ID="Rs_Value" runat="server" Text="Amount"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="tblTot" class="dataheaderInvCtrl" style="display: none" width="96%">
                                                                <tr>
                                                                    <td align="right" style="width: 40%">
                                                                        <asp:Label ID="lblTotaltxt" runat="server" Text="Total Amount :"></asp:Label>
                                                                    </td>
                                                                    <td align="center" style="width: 60%">
                                                                        <asp:Label ID="lblTotal" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <div id="divPaid" runat="server" style="display: none;">
                                                                <asp:Image ID="imgPaid" runat="server" ImageUrl="../Images/starbutton.png" />
                                                                Amount Paid In Referred Org
                                                                <asp:Label ID="lblOrg" runat="server"></asp:Label>
                                                            </div>
                                                        </td>
                                                        <td style="width: 40%">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <!-- Billing Part -->
                            <tr>
                                <td align="right">
                                    <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                        <ContentTemplate>
                                            <table id="tblAmount" cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td colspan="2">
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label ID="lblGross" runat="server" Text="Gross" class="defaultfontcolor" />
                                                    </td>
                                                    <td align="right">
                                                        <asp:TextBox CssClass="biltextb" ID="txtGross" runat="server" Text="0.00" Enabled="False"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="style2">
                                                        &nbsp;
                                                        <asp:Label ID="tdDiscountLabel" Text="Select the Discount" runat="server" CssClass="biltextb" />
                                                    </td>
                                                    <td align="left" class="style2">
                                                        &nbsp;<asp:DropDownList ID="ddDiscountPercent" TabIndex="47" ToolTip="Select the Discount"
                                                            onChange="javascript:setDiscount();" runat="server" Style="margin-left: 0px"
                                                            CssClass="bilddltb">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td align="left" class="style2">
                                                        &nbsp;<asp:TextBox ID="txtDiscountPercent" runat="server" TabIndex="48" CssClass="invtextb"
                                                            MaxLength="9" onkeyup="javascript:CorrectTotal();" onblur="ValidateDiscountReason();"
                                                              onkeypress="return ValidateOnlyNumeric(this);"   Style="display: none;" Text="0.00" />
                                                    </td>
                                                    <td align="left" class="style2">
                                                        <asp:Label ID="lblDiscount" runat="server" Text="Discount" class="defaultfontcolor" />
                                                    </td>
                                                    <td align="right" class="style2">
                                                        <asp:TextBox CssClass="biltextb" ID="txtDiscount" TabIndex="49" runat="server" onkeyup="javascript:CorrectTotal();SetOtherCurrValues();"
                                                            Text="0.00" onblur="ValidateDiscountReason();"   onkeypress="return ValidateOnlyNumeric(this);"   />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td align="left" valign="top">
                                                        <asp:Label ID="Rs_Tax" Text="Tax%" runat="server" />
                                                    </td>
                                                    <td align="right">
                                                        <asp:TextBox CssClass="biltextb" ID="txtTax" TabIndex="50" onkeyup="CorrectTotal();SetOtherCurrValues();"
                                                            runat="server" Text="0"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server" />
                                                    </td>
                                                    <td align="right">
                                                        <asp:TextBox CssClass="biltextb" ID="txtServiceCharge" TabIndex="51" Enabled="False"
                                                            runat="server" Text="0.00" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="1" align="right">
                                                        <asp:Label ID="Rs_PreviousDue" Text="Previous Due" runat="server" />
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox CssClass="biltextb" ID="txtPreviousDue" TabIndex="51" Enabled="False"
                                                            runat="server" Text="0.00" />
                                                        <%-- &nbsp;--%>
                                                    </td>
                                                    <td align="left">
                                                    </td>
                                                    <td style="color: Black">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label ID="lblGrandTotal" runat="server" Text="Net Value" class="defaultfontcolor" />
                                                    </td>
                                                    <td align="right">
                                                        <asp:TextBox CssClass="biltextb" ID="txtGrandTotal" TabIndex="52" Enabled="False"
                                                            runat="server" Text="0.00" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label ID="lblAmountRecieved" runat="server" Text="Amount Recieved" class="defaultfontcolor" />
                                                    </td>
                                                    <td align="right">
                                                        <asp:TextBox CssClass="biltextb" ID="txtAmountRecieved" TabIndex="53" runat="server"
                                                            Text="0.00" ReadOnly="True" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label ID="lblDueAmount" runat="server" Text="DueAmount" class="defaultfontcolor" />
                                                    </td>
                                                    <td align="right">
                                                        <asp:TextBox CssClass="biltextb" ID="txtDue" runat="server" TabIndex="54" Text="0.00"
                                                            ReadOnly="True" />
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="trNonReimburse">
                                                    <td id="Td3" colspan="2" runat="server">
                                                        &nbsp;
                                                    </td>
                                                    <td id="Td4" runat="server">
                                                        &nbsp;
                                                    </td>
                                                    <td id="Td5" align="left" runat="server">
                                                        <div id="Div1" style="display: block">
                                                        </div>
                                                    </td>
                                                    <td id="Td6" align="right" runat="server">
                                                        <div id="Div2" style="display: block">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="trCoPayment">
                                                    <td id="Td7" colspan="2" runat="server">
                                                        &nbsp;
                                                    </td>
                                                    <td id="Td8" runat="server">
                                                        &nbsp;
                                                    </td>
                                                    <td id="Td9" align="left" runat="server">
                                                        <div id="Div1" style="display: block">
                                                        </div>
                                                    </td>
                                                    <td id="Td10" align="right" runat="server">
                                                        <div id="Div4" style="display: block">
                                                            <input type="hidden" value="0.00" id="hdnCoPayment" />
                                                            <asp:HiddenField ID="hdnGross" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnDiscount" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnTax" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnRoundOff" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnNetValue" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnAmountRecieved" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnDueAmount" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnGrandTotal" runat="server" Value="0" />
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="trExcess">
                                                    <td id="Td11" colspan="2" runat="server">
                                                        &nbsp;
                                                    </td>
                                                    <td id="Td12" runat="server">
                                                        &nbsp;
                                                    </td>
                                                    <td id="Td13" align="left" runat="server">
                                                        <div id="Div5" style="display: block">
                                                        </div>
                                                    </td>
                                                    <td id="Td14" align="right" runat="server">
                                                        <div id="Div6" style="display: block">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td colspan="2">
                                                <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay2" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div id="divpayType">
                                        <uc18:paymentType ID="PaymentType" TabIndex="55" runat="server" />
                                    </div>
                                </td>
                            </tr>
                            <!-- Unknown/Additional Part -->
                            <tr>
                                <td>
                                    <asp:Panel Style="display: none;" ID="Panel6" CssClass="dataheader2" BorderWidth="1px"
                                        runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="padding: 3px;">
                                                    <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td style="width: 20%;">
                                                                <div id="divPkg" style="display: none" runat="server">
                                                                    <asp:DropDownList ID="ddlPkg" ToolTip="Select Insurance" Width="250px" runat="server">
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </td>
                                                            <td style="width: 20%;">
                                                                <div id="divCollectionCentre" style="display: none" runat="server">
                                                                    <asp:DropDownList ID="ddlCollectionCentre" ToolTip="Select Collection Centre" runat="server">
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td align="left">
                                    <asp:Panel ID="Panel2" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="padding: 3px;">
                                                    <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td align="right" style="width: 18%;">
                                                                Result Publishing
                                                            </td>
                                                            <td style="width: 32%;">
                                                                <asp:DropDownList ID="ddPublishingMode" ToolTip="Select Result Publishing Mode" OnChange="SampleRegShowHide();"
                                                                    runat="server">
                                                                </asp:DropDownList>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="display: none;" id="trAddress" runat="server">
                                        <asp:Panel ID="Panel4" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td style="padding-top: 5px;">
                                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td align="right" style="width: 18%;">
                                                                    Same As Above
                                                                </td>
                                                                <td style="width: 82%;">
                                                                    <input type="checkbox" id="chkSameAsAbove" onclick="javascript:SameAsAbove();" runat="server"
                                                                        value="1" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" style="width: 18%;">
                                                                    Name
                                                                </td>
                                                                <td style="width: 82%;">
                                                                    <asp:TextBox ID="txtName" ToolTip="Name of the Person to which the Result has to be Published"
                                                                        runat="server" MaxLength="60"></asp:TextBox>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-bottom: 2px;">
                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td>
                                                                    <uc8:AddressControl ID="shippingAddress" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-bottom: 2px;">
                                                        <span style="font: bold italic 16px serif;">
                                                            <asp:Label ID="Rs_didyouhearaboutthis" Text="did you hear about this?" runat="server"></asp:Label></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                            <!-- Button Finish Part -->
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="btnFinish" TabIndex="65" ToolTip="Click here to Save & Continue"
                                        Style="cursor: pointer;" runat="server" OnClientClick="return LabPatientRegValidation(this.id);"
                                        OnClick="btnFinish_Click" Text="Submit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" />
                                    <asp:Button ID="btnCancel" TabIndex="66" runat="server" ToolTip="Click here to Cancel"
                                        Style="cursor: pointer;" Text="Cancel" OnClick="btnCancel_Click" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                                    <%--  <input type="button" onclick="btnExample_Click()" value="click" />--%>
                                    <asp:HiddenField ID="hdnPatientID" runat="server" />
                                    <asp:HiddenField ID="hdnVisitID" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <!-- New Refphy Popup -->
                        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                            <ContentTemplate>
                                <table border="0" width="50%">
                                    <tr>
                                        <td>
                                            <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none" />
                                            <ajc:ModalPopupExtender ID="programmaticModalPopup" runat="server" BackgroundCssClass="modalBackground"
                                                PopupControlID="pnlAttrib" TargetControlID="hiddenTargetControlForModalPopup">
                                            </ajc:ModalPopupExtender>
                                            <asp:Panel ID="pnlAttrib" BorderWidth="1px" Width="80%" CssClass="modalPopup dataheaderPopup"
                                                runat="server">
                                                <table border="2" width="100%" style="border-color: Red;">
                                                    <tr>
                                                        <td align="center">
                                                            <input type="hidden" id="iconHid" style="width: 50%;" runat="server" />
                                                            <input type="hidden" id="HidDel" style="width: 50%;" runat="server" />
                                                            <input type="hidden" id="HdnRoleID" runat="server" />
                                                            <input type="hidden" id="hdnUserId" runat="server" />
                                                            <input type="hidden" id="LogID" runat="server" />
                                                            <input type="hidden" id="hdnReferingPhysicianID" runat="server" />
                                                            <input type="hidden" id="HdnLPF" value="" runat="server" />
                                                            <input type="hidden" id="hidID" value="" runat="server" />
                                                            <table class="dataheader2" id="TabNew" runat="server" border="0" cellpadding="2"
                                                                cellspacing="0" width="100%">
                                                                <tr>
                                                                    <td>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                    <td rowspan="7" width="96%">
                                                                        <table cellpadding="0px" border="0px" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                <td valign="middle">
                                                                                    <asp:Label ID="lblHeaderReferingHospitals" runat="server" CssClass="reflabel">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                        <asp:Label ID="Rs_ReferingHospitals" Text="Refering Hospitals" runat="server"></asp:Label></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        <table id="tblReferingHospitals" runat="server" class="dataheaderInvCtrl" cellpadding="1"
                                                                            cellspacing="0" width="96%">
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 5px;">
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 25%;" align="right">
                                                                        <asp:Label ID="Rs_DoctorsName" Text="Doctor's Name" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td align="left" style="width: 50%;">
                                                                        <asp:DropDownList ID="ddSalutation1" ToolTip="Select Salutation" runat="server" Width="80px">
                                                                        </asp:DropDownList>
                                                                        <asp:TextBox ID="txtDrName1" ToolTip="Refering Physician(Doctor) Name" onchange="GetOrgName()"
                                                                            runat="server" Width="168px" MaxLength="60"></asp:TextBox>
                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 25%;" align="right">
                                                                        <asp:Label ID="Rs_Qualification1" Text="Qualification" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td align="left" style="width: 50%;">
                                                                        <asp:TextBox ID="txtDrQualification1" ToolTip="Refering Physician(Doctor) Qualification"
                                                                            Width="250px" runat="server" MaxLength="60"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 25%;" align="right">
                                                                        <asp:Label ID="Rs_OrganizationName" Text="Organization Name" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td align="left" style="width: 50%;">
                                                                        <asp:TextBox ID="txtDrOrganization1" Width="250px" ToolTip="Refering Physician(Doctor) Organization"
                                                                            runat="server" MaxLength="60"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Label ID="Rs_Sex1" Text="Sex" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="DropDownList2" runat="server" ToolTip="Select Sex">
                                                                            <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                                            <asp:ListItem Value="M">Male</asp:ListItem>
                                                                            <asp:ListItem Value="F">Female</asp:ListItem>
                                                                            <asp:ListItem Value="NotKnown">NotKnown</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Label ID="Rs_Filter" Text="Filter" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <input type="text" onkeyup="MyUtil.selectFilter('chklstHsptl', this.value)" id="txtBX" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 25%;" align="right">
                                                                        <asp:Label ID="Rs_ReferalHospitalName" Text="Referral Hospital Name" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <asp:ListBox ID="chklstHsptl" runat="server" ToolTip="Double Click the List or Press Enter to Select Group"
                                                                            EnableViewState="false" Width="300px" Height="100px" onclick="javascript:return SetId(this.id);"
                                                                            onkeypress="javascript:setItem(event,this);" ondblClick="javascript:onClick1(this.id);">
                                                                        </asp:ListBox>
                                                                        <%--<asp:CheckBoxList ID="chklstHsptl" runat="server" BorderWidth="1px" Height="51px" Width="453px">
                                                                    </asp:CheckBoxList>--%>
                                                                        <asp:HiddenField ID="HdnHospitalID" runat="server" />
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3">
                                                                        <asp:Label ID="lblLoginName" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                    </td>
                                                                    <td id="Td1">
                                                                        <asp:CheckBox ID="chkUserLogin" runat="server" Checked="false" Text="Create User Login" />
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                    </td>
                                                                    <td>
                                                                        <div id="Login" runat="server" class="modalPopup dataheaderPopup" style="display: none;
                                                                            border: none 20px; width: 300Px; height: 100px; border-color: Black;">
                                                                            <table border="0">
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Rs_PreferredUserName" Text="Preferred User Name" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtUserName" Width="135px" runat="server"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Rs_Password" Text="Password" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox TextMode="Password" Width="135px" ID="txtPassword" runat="server"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Rs_UserType" Text="UserType" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:CheckBox ID="chkRefPhysician" Enabled="false" Text="Referring Physician" Checked="true"
                                                                                            runat="server"></asp:CheckBox>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            onmouseout="this.className='btn'" OnClick="btnSave_Click" OnClientClick="return validateLabRefPhysicianDetails()" />
                                                                    </td>
                                                                    <td align="center">
                                                                        <asp:Button ID="btnCancel1" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            OnClick="btnCancel1_click" onmouseout="this.className='btn'" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            <asp:Label runat="server" ID="lblStatus" Visible="false" Text=""></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                    <ProgressTemplate>
                                        <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="imgProg" runat="server" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <!-- New Clinic Popup -->
                        <table border="0" width="50%">
                            <tr>
                                <td>
                                    <asp:Button ID="btnNewClinic" runat="server" Style="display: none" />
                                    <ajc:ModalPopupExtender ID="mpeNewClinic" runat="server" BackgroundCssClass="modalBackground"
                                        PopupControlID="pnlNewClinic" CancelControlID="btnClinicCancel" TargetControlID="btnNewClinic">
                                    </ajc:ModalPopupExtender>
                                    <asp:Panel ID="pnlNewClinic" BorderWidth="1px" Width="80%" CssClass="modalPopup dataheaderPopup"
                                        runat="server">
                                        <table border="2" width="100%" style="border-color: Red;">
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                                        <tr>
                                                            <td height="32">
                                                                <table border="0" id="Table1" cellpadding="4" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td colspan="5" id="Td2">
                                                                            <asp:Literal Visible="false" runat="server" ID="ltHead" Text="Select a Clinic/Hospital to edit the details or click on Add New Clinic."></asp:Literal>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <%-- <asp:Panel ID="Panel9" Visible="false" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td style="padding: 3px;">
                                                                                <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                                                    <tr>
                                                                                        <td align="right" style="width: 18%;">
                                                                                            <input id="rdonewHospitals" type="radio" style="display: none;" name="clientType"
                                                                                                checked value="1" runat="server" />Clinic/Hospital List
                                                                                        </td>
                                                                                        <td style="width: 45%;">
                                                                                            <div id="Div2" runat="server">
                                                                                                <asp:DropDownList ID="ddlNewClinic" ToolTip="Select Refering Hospital" runat="server"
                                                                                                    Width="250px" TabIndex="1" AutoPostBack="true" OnSelectedIndexChanged="ddlNewClinic_SelectedIndexChanged">
                                                                                                </asp:DropDownList>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td style="width: 10%;">
                                                                                        </td>
                                                                                        <td style="width: 30%;">
                                                                                            <asp:LinkButton ID="lnkAddNewClinic" ToolTip="Click here to Add New Refering Clinic"
                                                                                                Visible="true" ForeColor="#333" runat="server" OnClick="lnkAddNewClinic_Click">
                                                                                                <u>Add New Refering Clinic</u></asp:LinkButton>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>--%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblClinic" Visible="false" runat="server" ForeColor="#333" Text=""></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <div id="Div3" runat="server">
                                                                    <asp:Panel ID="Panel10" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                <td style="padding-top: 5px;">
                                                                                    <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                                                        <tr>
                                                                                            <td align="right" style="width: 18%;">
                                                                                                <asp:Label ID="Rs_HospitalClinicName" Text="Hospital/Clinic/Lab Name" runat="server"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width: 50%;">
                                                                                                <asp:TextBox ID="txtNewClinicName" ToolTip="Refering Hospital Name" runat="server"
                                                                                                    MaxLength="60"></asp:TextBox>
                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                            </td>
                                                                                            <td align="left" style="width: 32%;">
                                                                                                <asp:Panel ID="pnRefOrgType" Width="70%" GroupingText="Type" runat="server">
                                                                                                    <%--<input id="rdoHospital" type="radio" name="clientTypes" value="1" runat="server" />
                                                                                                    <input id="rdoClinic" type="radio" name="clientTypes" value="2" runat="server" />
                                                                                                    <input id="rdoLab" type="radio" name="clientTypes" value="3" runat="server" />--%>
                                                                                                    <%--<asp:RadioButton ID="rdoRHospital" Text="Hospital" Checked="true" onClick="javascript:SetType(this.id);"
                                                                                                        GroupName="RefOrgType" runat="server" />
                                                                                                    <asp:RadioButton ID="rdoClinic" Text="Clinic" onClick="javascript:SetType(this.id);"
                                                                                                        GroupName="RefOrgType" runat="server" />
                                                                                                    <asp:RadioButton ID="rdoLab" Text="Lab" onClick="javascript:SetType(this.id);" GroupName="RefOrgType"
                                                                                                        runat="server" />--%>
                                                                                                    <asp:DropDownList ID="ddlReferringOrgType" TabIndex="42" ToolTip="Select Referring-Org Type"
                                                                                                        runat="server">
                                                                                                    </asp:DropDownList>
                                                                                                    <asp:HiddenField ID="hdnRefOrgType" Value="1" runat="server" />
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="padding-bottom: 2px;">
                                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <!--Shaj -->
                                                                                                <table width="100%" border="0" cellpadding="4" cellspacing="0" class="tabledata">
                                                                                                    <tr>
                                                                                                        <td style="width: 3%">
                                                                                                            <asp:TextBox runat="server" Visible="false" ID="txtAddressID"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td style="width: 15%" align="right">
                                                                                                            <asp:Label ID="Rs_Address1" Text="Address 1" runat="server"></asp:Label>
                                                                                                        </td>
                                                                                                        <td class="style1">
                                                                                                            <asp:TextBox ID="txtAddress1" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                                                                                                MaxLength="60"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td class="style2">
                                                                                                            &nbsp;
                                                                                                        </td>
                                                                                                        <td style="width: 19%" align="right">
                                                                                                            <asp:Label ID="Rs_Address2" Text="Address 2" runat="server"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtAddress2" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                                                                                                MaxLength="60"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            &nbsp;
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                            <asp:Label ID="Rs_Address3" Text="Address 3" runat="server"></asp:Label>
                                                                                                        </td>
                                                                                                        <td class="style1">
                                                                                                            <asp:TextBox ID="txtAddress3" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                                                                                                MaxLength="60"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td class="style2">
                                                                                                            &nbsp;
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                            <asp:Label ID="Rs_City" Text="City" runat="server"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtCity" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                                                                                                MaxLength="25"></asp:TextBox>
                                                                                                            <%--  &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            &nbsp;
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                            <asp:Label ID="Rs_Country" Text="Country" runat="server"></asp:Label>
                                                                                                        </td>
                                                                                                        <td class="style1">
                                                                                                            <asp:DropDownList ID="ddCountry" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddCountry_SelectedIndexChanged">
                                                                                                            </asp:DropDownList>
                                                                                                        </td>
                                                                                                        <td class="style2">
                                                                                                            &nbsp;
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                            <asp:Label ID="Rs_State" Text="State" runat="server"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                                                                                                <ContentTemplate>
                                                                                                                    <asp:DropDownList ID="ddState" runat="server">
                                                                                                                    </asp:DropDownList>
                                                                                                                </ContentTemplate>
                                                                                                                <Triggers>
                                                                                                                    <asp:AsyncPostBackTrigger ControlID="ddCountry" EventName="SelectedIndexChanged" />
                                                                                                                </Triggers>
                                                                                                            </asp:UpdatePanel>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            &nbsp;
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                            <asp:Label ID="Rs_PostalCode" Text="PostalCode" runat="server"></asp:Label>
                                                                                                        </td>
                                                                                                        <td class="style1">
                                                                                                            <asp:TextBox ID="txtPostalCode" runat="server" MaxLength="6"></asp:TextBox>
                                                                                                            <ajc:FilteredTextBoxExtender ID="flpostal" FilterType="Numbers" TargetControlID="txtPostalCode"
                                                                                                                runat="server">
                                                                                                            </ajc:FilteredTextBoxExtender>
                                                                                                        </td>
                                                                                                        <td class="style2">
                                                                                                            &nbsp;
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                            <asp:Label ID="Rs_LandLine" Text="LandLine" runat="server"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtLandLine" runat="server" MaxLength="12"></asp:TextBox>
                                                                                                            <ajc:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" FilterType="Numbers" TargetControlID="txtLandLine"
                                                                                                                runat="server">
                                                                                                            </ajc:FilteredTextBoxExtender>
                                                                                                            <%--                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" /><img src="../Images/starbutton.png" alt="" align="middle" />
--%>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            &nbsp;
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                            <asp:Label ID="Rs_Mobile" Text="Mobile" runat="server"></asp:Label>
                                                                                                        </td>
                                                                                                        <td class="style1">
                                                                                                            <asp:TextBox ID="txtRefOrgMobile" runat="server" MaxLength="11"></asp:TextBox>
                                                                                                            <ajc:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" FilterType="Numbers" TargetControlID="txtRefOrgMobile"
                                                                                                                runat="server">
                                                                                                            </ajc:FilteredTextBoxExtender>
                                                                                                            <%--                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" /><img src="../Images/starbutton.png" alt="" align="middle" />
--%>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            &nbsp;
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                            <asp:Label ID="Rs_AlternateLandLine" Text="Alternate LandLine" runat="server"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtAltLandLine" runat="server" MaxLength="12"></asp:TextBox>
                                                                                                            <ajc:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" FilterType="Numbers" TargetControlID="txtAltLandLine"
                                                                                                                runat="server">
                                                                                                            </ajc:FilteredTextBoxExtender>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            &nbsp;
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                            <asp:Label ID="Rs_Fax" Text="Fax" runat="server"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtFax" runat="server" MaxLength="12"></asp:TextBox>
                                                                                                            <ajc:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" FilterType="Numbers" TargetControlID="txtFax"
                                                                                                                runat="server">
                                                                                                            </ajc:FilteredTextBoxExtender>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            &nbsp;
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                        </td>
                                                                                                        <td>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
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
                                                        <tr>
                                                            <td align="center" colspan="4">
                                                                <asp:Button ID="btnClinicSave" UseSubmitBehavior="true" ToolTip="Click here to Save Refering Hospital Details"
                                                                    Style="cursor: pointer;" runat="server" OnClick="btnClinicSave_Click" Text="Save"
                                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                                                                <asp:Button ID="btnDelete" Visible="false" runat="server" OnClick="btnDelete_Click"
                                                                    Text="Remove" Style="cursor: pointer;" ToolTip="Click here to Remove Refering Hospital Details"
                                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                                                                <asp:Button ID="btnClinicCancel" runat="server" Text="Close" ToolTip="Click here to Cancel, View the Home Page"
                                                                    Style="cursor: pointer;" CssClass="btn" OnClientClick="Clearmsg();" onmouseover="this.className='btn btnhov'"
                                                                    onmouseout="this.className='btn'" />
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
                        <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
        <input type="hidden" id="hdKOS" value="E" runat="server" />
        <input type="text" style="display: none" id="hdnPhysicianID" runat="server" />
        <input type="text" style="display: none" id="hdnID" runat="server" />
        <input type="hidden" id="iconHid1" value="" style="width: 50%;" runat="server" />
        <input type="hidden" id="HdnLPF1" value="" runat="server" />
        <input type="hidden" id="hidID1" value="" runat="server" />
        <input type="hidden" id="hdnInvName" value="" runat="server" />
        <input type="hidden" id="hdnfeeType" value="" runat="server" />
        <input type="hidden" id="hdnInvamount" value="" runat="server" />
        <input type="hidden" id="hdnInvId" value="" runat="server" />
        <input type="hidden" id="hdntempID" value="" runat="server" />
        <input type="hidden" id="hdnFinalGross" value="" runat="server" />
        <input type="hidden" id="hdnFinalDiscount" value="" runat="server" />
        <input type="hidden" id="hdnFinalTax" value="" runat="server" />
        <input type="hidden" id="hdnFinalGrandTotal" value="" runat="server" />
        <input type="hidden" id="hdnFinalAmountRecieved" value="" runat="server" />
        <input type="hidden" id="hdnFinalDue" value="" runat="server" />
        <input type="hidden" id="hdnRateType" value="" runat="server" />
        <input type="hidden" id="hdnPatientVisitType" value="" runat="server" />
        <input type="hidden" id="hdnClientTypeID" value="" runat="server" />
        <input type="hidden" id="hdnLabRefOrgID" value="" runat="server" />
        <input type="hidden" id="hdnRefOrgName" value="" runat="server" />
    </div>

    <script language="javascript" type="text/javascript">

        function SetOtherCurrValues() {
            var pnetAmt = 0;
            pnetAmt = document.getElementById('txtGrandTotal').value == "" ? "0" : document.getElementById('txtGrandTotal').value;
            var ConValue = "OtherCurrencyDisplay2";
            SetPaybleOtherCurr(pnetAmt, ConValue, true);
        }
        GetCurrencyValues();


        function SetOtherCurrPayble(pCurrName, pCurrAmount, pNetAmount, ConValue, IsDisplay) {

            var pTotalNetAmt = parseFloat(parseFloat(pNetAmount).toFixed(2) / parseFloat(pCurrAmount).toFixed(2)).toFixed(2);
            document.getElementById(ConValue + "_lblOtherCurrPaybleName").innerHTML = pCurrName;
            document.getElementById(ConValue + "_lblOtherCurrRecdName").innerHTML = pCurrName;
            document.getElementById(ConValue + "_lblOtherCurrPaybleAmount").innerHTML = parseFloat(pTotalNetAmt).toFixed(2);
            document.getElementById(ConValue + "_hdnOterCurrPayble").value = parseFloat(pTotalNetAmt).toFixed(2);

        }
        function SetOtherCurrReceived(pCurrAmount, pNetAmount, pServiceCharge, ConValue) {
            var pTotalNetAmt = Number(pNetAmount);
            document.getElementById(ConValue + "_lblOtherCurrRecdAmount").innerHTML = parseFloat(pTotalNetAmt).toFixed(2);
            document.getElementById(ConValue + "_hdnOterCurrReceived").value = parseFloat(pTotalNetAmt).toFixed(2);
            document.getElementById(ConValue + "_hdnOterCurrServiceCharge").value = parseFloat(pServiceCharge).toFixed(2);

        }


        function isOtherCurrDisplay1(pType) {
            if (pType == "B") {
                document.getElementById("OtherCurrencyDisplay2_tbAmountPayble").style.display = "block";
            }
            if (pType == "N") {
                document.getElementById("OtherCurrencyDisplay2_tbAmountPayble").style.display = "block";
            }
        }
        function isOtherCurrDisplay(pType) {
            if (pType == "B") {
                document.getElementById("OtherCurrencyDisplay2_tbAmountPayble").style.display = "block";
            }
            if (pType == "N") {
                document.getElementById("OtherCurrencyDisplay2_tbAmountPayble").style.display = "none";
            }
        }

        function getOtherCurrAmtValues(pType, ConValue) {
            if (pType == "REC") {
                var pAMt = document.getElementById(ConValue + "_hdnOterCurrReceived").value == "" ? "0" : document.getElementById(ConValue + "_hdnOterCurrReceived").value;
                return parseFloat(pAMt).toFixed(2);
            }
            if (pType == "PAY") {
                var pAMt = document.getElementById(ConValue + "_hdnOterCurrPayble").value == "" ? "0" : document.getElementById(ConValue + "_hdnOterCurrPayble").value;
                return parseFloat(pAMt).toFixed(2);
            }
            if (pType == "SER") {
                var pAMt = document.getElementById(ConValue + "_hdnOterCurrServiceCharge").value == "" ? "0" : document.getElementById(ConValue + "_hdnOterCurrServiceCharge").value;
                return parseFloat(pAMt).toFixed(2);
            }
        }

    </script>

    <script language="javascript" type="text/javascript">
        function SetDueAmount() {
            var totalDue;
            var ReceivedAmount;
            var PayableAmount;
            totalDue = document.getElementById('txtDue').value;
            ReceivedAmount = document.getElementById('OtherCurrencyDisplay2_lblOtherCurrRecdAmount').innerHTML;
            PayableAmount = document.getElementById('OtherCurrencyDisplay2_lblOtherCurrPaybleAmount').innerHTML;
            var ret = checkBillForTotal(ReceivedAmount, PayableAmount);
            if (ret == false) {
                return false;
            }
            else {
                document.getElementById('txtDue').value = parseFloat(parseFloat(totalDue) + (parseFloat(PayableAmount) - parseFloat(ReceivedAmount))).toFixed(2);
                document.getElementById('hdnFinalDue').value = document.getElementById('txtDue').value;
                return true;
            }
        }
        function checkBillForTotal(ReceivedAmount, PayableAmount) {
            var result;
            if (!document.getElementById('chkisCreditTransaction').checked) {
                if (ReceivedAmount == 0) {
                    result = confirm("Amount Received is Zero. Do you want to continue?");
                    if (result == false) {
                        return false;
                    }
                    else {
                        return true;
                    }
                }

                if (ReceivedAmount < PayableAmount) {
                    result = confirm("Received Amount is Lesser than Payable Amount. Do you want to continue with Due?");
                    if (result == false) {
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

        function openPOPupQuick(url) {
            window.open(url, "PrictBill", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
        }
        function SetRateID() {
            var RateID;
            RateID = document.getElementById('ddlRateType').value;
            document.getElementById('hdnRateType').value = RateID;
        }
        function IAmRefOrgSelected(source, eventArgs) {
            // alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());

            ////debugger;
            var LabRefOrgID;
            var ClientTypeID;
            var RateId;
            var LabRefOrgName;
            var Name;
            LabRefOrgName = eventArgs.get_text();
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        LabRefOrgID = list[0];
                        ClientTypeID = list[1];
                        RateId = list[2];
                        Name = list[3];
                    }
                }
            }
            if (RateId > 0) {
                document.getElementById('ddlRateType').value = RateId;
            }
            document.getElementById('hdnClientTypeID').value = ClientTypeID;
            document.getElementById('hdnLabRefOrgID').value = LabRefOrgID;
            document.getElementById('hdnRefOrgName').value = Name;
            document.getElementById('chkisCreditTransaction').checked = true;
            checkIsCredit();
        }
        function callWebfun() {

        }

        function chkPros() {
            // var sRateID = document.getElementById('hdnRateType').value;
            var sRateID = document.getElementById('ddlRateType').value;
            var pvalue;
            if (sRateID > 0) {
                var orgID = '<%= OrgID %>';
                var sval = 'LAB';
                // var sRateID = '2675';

                // var pvalue = 'OP';
                if (document.getElementById('hdnPatientVisitType').value != "") {
                    pvalue = 'OP'
                }
                else {
                    pvalue = document.getElementById('hdnPatientVisitType').value;
                }

                var pVisitID = '-1';
                var IsMapped = 'N';

                sval = sval + '~' + orgID + '~' + sRateID + '~' + pvalue + '~' + pVisitID + '~' + IsMapped;
                $find('AutoCompleteExtender3').set_contextKey(sval);
            }
            else {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_17');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert("Select Price Structure");
                    return false;
                }
            }

        }
        function IsValid() {
            if (document.getElementById('<%= hdntempID.ClientID %>').value == "") {
                // alert("Provide Investigation Name");
                document.getElementById('txtInvNameold').value = "";
                return false;
            }
        }

        //Order Investigation Part


        //Inv Auto Complete Create table
        function CopyBillItems() {

            document.getElementById('hdnFinalGross').value = document.getElementById('txtGross').value;
            document.getElementById('hdnFinalDiscount').value = document.getElementById('txtDiscount').value;
            document.getElementById('hdnFinalTax').value = document.getElementById('txtTax').value;
            document.getElementById('hdnFinalGrandTotal').value = document.getElementById('txtGrandTotal').value;
            document.getElementById('hdnFinalAmountRecieved').value = document.getElementById('txtAmountRecieved').value;
            document.getElementById('hdnFinalDue').value = document.getElementById('txtDue').value;
        }
        function IAmSelectedold(source, eventArgs) {

            // alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            ////debugger;
            var phyFeeId;
            var name;
            var feeType;
            var amount;
            var physicianLID;
            var specialityID;
            var isReimursable;
            var DisorEnhpercent;
            var DisorEnhType;
            var Remarks;
            var ReimbursableAmount;
            var NonReimbursableAmount;
            //            eventArgs.get_value()[0].PatientID;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        phyFeeId = list[0];
                        name = list[1];
                        feeType = list[2];
                        amount = list[7];
                        physicianLID = list[4];
                        specialityID = list[5];
                        isReimursable = list[6];
                        DisorEnhpercent = list[8];
                        DisorEnhType = list[9];
                        Remarks = list[10];
                        ReimbursableAmount = list[11];
                        NonReimbursableAmount = list[12];
                        // document.getElementById('txtAmount').value = amount;

                    }
                }

                ////////////////
                var type;
                var rate = amount;
                document.getElementById('<%= hdnInvName.ClientID %>').value = name;
                document.getElementById('<%= hdnInvId.ClientID %>').value = phyFeeId;
                document.getElementById('<%= hdnInvamount.ClientID %>').value = amount;
                document.getElementById('<%= hdnfeeType.ClientID %>').value = feeType;
                document.getElementById('<%= hdntempID.ClientID %>').value = phyFeeId;

                document.getElementById('txtInvNameold').value = name;
                document.getElementById('txtInvAmount').value = amount;
                document.getElementById('txtInvAmount').focus();
            }
            else {
                document.getElementById('<%= hdntempID.ClientID %>').value = "";
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_18');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('Provide Investigation Name');
                    return false;
                }
                document.getElementById('txtInvNameold').value = "";
                document.getElementById('txtInvNameold').focus();
            }
        }
        function freetxtCheck() {
            var name;
            var rate;
            var type;
            var phyFeeId;
            if (document.getElementById('txtInvNameold').value == "") {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_18');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('Provide Investigation Name');
                    return false;
                }
                document.getElementById('txtInvNameold').focus();
            }
            name = document.getElementById('<%= hdnInvName.ClientID %>').value;
            phyFeeId = document.getElementById('<%= hdnInvId.ClientID %>').value;
            // rate = document.getElementById('<%= hdnInvamount.ClientID %>').value;
            type = document.getElementById('<%= hdnfeeType.ClientID %>').value;

            var AddStatus = 0;


            var total = parseFloat(document.getElementById('lblTotal').innerHTML);
            var rate = parseFloat(document.getElementById('txtInvAmount').value);
            var HidValue = document.getElementById('<%= iconHid1.ClientID %>').value;
            var list = HidValue.split('^');

            if (document.getElementById('<%= iconHid1.ClientID %>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {

                        if (phyFeeId >= 0) {
                            if (InvesList[0] == phyFeeId) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                var row = document.getElementById('tblOrederedInves').insertRow(1);
                row.id = phyFeeId;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);

                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickINV(" + phyFeeId + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = name;
                cell3.innerHTML = type;
                cell3.width = "40%";
                cell3.style.display = "none";
                cell4.innerHTML = parseFloat(rate); // addPhyFeeList(phyFeeId);
                cell4.width = "20%";
                total = parseFloat(rate);
                document.getElementById('<%= iconHid1.ClientID %>').value += phyFeeId + "~" + name + "~" + type + "~Ordered" + "~" + parseFloat(rate).toFixed(2) + "^";
                //rate = name.split(':');

                //alert('total:' + parseFloat(total).toFixed(2));
                document.getElementById('<%= lblTotal.ClientID %>').innerHTML = (parseFloat(total)).toFixed(2);
                AddStatus = 2;
                document.getElementById('tblTot').style.display = "block";
                document.getElementById('tblOrederedInves').style.display = "block";
                CalculateAmount(rate);
            }
            if (AddStatus == 0) {

                var row = document.getElementById('tblOrederedInves').insertRow(1);
                row.id = phyFeeId;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickINV(" + phyFeeId + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = name;
                cell3.innerHTML = type;
                cell3.style.display = "none";
                cell3.width = "40%";
                cell4.innerHTML = parseFloat(rate);  //addPhyFeeList(phyFeeId);
                cell4.width = "20%";
                document.getElementById('<%= iconHid1.ClientID %>').value += phyFeeId + "~" + name + "~" + type + "~Ordered" + "~" + parseFloat(rate).toFixed(2) + "^";
                //rate = name.split(':');
                //alert('rae:' + rate[1]);
                total = parseFloat(total) + parseFloat(rate);
                document.getElementById('<%= lblTotal.ClientID %>').innerHTML = (parseFloat(total)).toFixed(2);
                document.getElementById('tblOrederedInves').style.display = "block";
                CalculateAmount(rate);
                //addItems();
            }
            else if (AddStatus == 1) {
            var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_20');
            if (userMsg != null) {
                alert(userMsg);
                return false;
                
            }

            else {
                alert("Investigation Already Added!");
                return false;
            }
            }
            document.getElementById('<%= hdntempID.ClientID %>').value = "";
            document.getElementById('txtInvNameold').value = '';
            document.getElementById('txtInvAmount').value = '';
            document.getElementById('txtInvNameold').focus();

        }
        function addPhyFeeList(invID) {
            var HdnLPF1 = document.getElementById('<%= HdnLPF1.ClientID %>').value;
            var LPFlist = HdnLPF1.split('^');

            if (document.getElementById('<%= HdnLPF1.ClientID %>').value != "") {

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

        function ImgOnclickINV(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('<%= iconHid1.ClientID %>').value;
            var list = HidValue.split('^');
            var minusamt;
            var newInvList = '';
            if (document.getElementById('<%= iconHid1.ClientID %>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (InvesList[0] != ImgID) {
                            newInvList += list[count] + '^';
                        }
                        else {
                            var Minusamount = InvesList[4];
                            var totalAmt = parseFloat(document.getElementById('<%= lblTotal.ClientID %>').innerHTML) - parseFloat(Minusamount);
                            document.getElementById('<%= lblTotal.ClientID %>').innerHTML = parseFloat(totalAmt).toFixed(2);
                            DeleteAmount(Minusamount);

                        }
                    }

                }
                document.getElementById('<%= iconHid1.ClientID %>').value = newInvList;
            }
        }

        function CalculateAmount(rate) {
            var Gross = 0;
            var Discount = 0;
            var Tax = 0;
            var ServiceCharge = 0;
            var RoundOff = 0;
            var NetValue = 0;
            var AmountRecieved = 0;
            var DueAmount = 0;

            Gross = document.getElementById('txtGross').value;


            Gross = Number(Gross) + Number(rate);
            document.getElementById('txtGross').value = parseFloat(Gross).toFixed(2);
            document.getElementById('hdnGross').value = parseFloat(Gross).toFixed(2);
            CorrectTotal();
            setDiscount();

        }
        function DeleteAmount(rate) {
            var Gross = 0;
            var Discount = 0;
            var Tax = 0;
            var ServiceCharge = 0;
            var RoundOff = 0;
            var NetValue = 0;
            var AmountRecieved = 0;
            var DueAmount = 0;

            Gross = document.getElementById('txtGross').value;


            Gross = Number(Gross) - Number(rate);
            document.getElementById('txtGross').value = parseFloat(Gross).toFixed(2);
            document.getElementById('hdnGross').value = parseFloat(Gross).toFixed(2);
            CorrectTotal();

        }
    </script>

    <script language="javascript" type="text/javascript">


        function ValidateDiscountReason() {
            if (document.getElementById('txtDiscount').value > 0) {

            }
            else {

            }
        }

        function CorrectTotal() {
            var Gross = 0;
            var Discount = 0;
            var Tax = 0;
            var ServiceCharge = 0;
            var tempDiscount = 0;
            var temptax = onblur;
            var Total = 0;
            var PrDue = 0;
            Gross = document.getElementById('hdnGross').value;
            Discount = document.getElementById('txtDiscount').value;
            PrDue = 0; ; //document.getElementById('txtPreviousDue').value;
            Tax = document.getElementById('txtTax').value;

            //            tempDiscount = parseFloat((Number(Gross) * Number(Discount)) / Number(100)).toFixed(2);
            //            tempDiscount = parseFloat(Number(Gross) - Number(Discount)).toFixed(2);
            Discount = parseFloat(Discount).toFixed(2);
            if (Total < 0) {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_21');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('Discount Amount should not exceed total amount');
                    return false;
                }
                document.getElementById('txtDiscount').value = 0.00;
            }
            else {
                //                  Gross = parseFloat(Number(Gross) - Number(tempDiscount)).toFixed(2);

                Gross = parseFloat(Number(Gross) - Number(Discount)).toFixed(2);
                temptax = parseFloat((Number(Gross) * Number(Tax)) / Number(100)).toFixed(2);
                Gross = parseFloat(Number(Gross) + Number(temptax) + Number(PrDue)).toFixed(2);
                document.getElementById('hdnGrandTotal').value = Gross;
                document.getElementById('txtGrandTotal').value = Gross;
            }
            SetOtherCurrValues();
        }
        function pTotalAmount(rate) {
            var Gross = 0;
            var Discount = 0;
            var Tax = 0;
            var ServiceCharge = 0;
            var RoundOff = 0;
            var NetValue = 0;
            var AmountRecieved = 0;
            var DueAmount = 0;
            var PrDue = 0;
            //            Discount = document.getElementById('hdnDiscount').value;
            //            Tax = document.getElementById('hdnTax').value;
            //            ServiceCharge = document.getElementById('hdnServiceCharge').value;
            //            NetValue = document.getElementById('hdnNetValue').value;
            //            AmountRecieved = document.getElementById('hdnAmountRecieved').value;
            //            DueAmount = document.getElementById('hdnDueAmount').value;
            PrDue = 0; //document.getElementById('txtPreviousDue').value;
            Gross = document.getElementById('txtGross').value;
            //            Discount = document.getElementById('txtDiscount').value;
            //            Tax = document.getElementById('txtTax').value;s
            //            ServiceCharge = document.getElementById('txtServiceCharge').value;
            //            NetValue = document.getElementById('txtGrandTotal').value;
            //            AmountRecieved = document.getElementById('txtAmountRecieved').value;
            //            DueAmount = document.getElementById('txtDue').value;

            Gross = Number(Gross) + Number(rate) + Number(PrDue);
            document.getElementById('txtGross').value = parseFloat(Gross).toFixed(2);
            document.getElementById('hdnGross').value = parseFloat(Gross).toFixed(2);



        }

        function setDiscount() {
            if ((document.getElementById('ddDiscountPercent').value) == 'select') {
                document.getElementById('txtDiscount').value = parseFloat(0).toFixed(2);
                document.getElementById('txtDiscount').readOnly = false;
                //                document.getElementById('txtDiscountPercent').style.display = 'None';
                CheckTotal();
            }
            else if ((document.getElementById('ddDiscountPercent').value) == '0.00') {
                document.getElementById('txtDiscount').value = parseFloat(0).toFixed(2);
                CheckDiscount();
            }

            else {
                document.getElementById('txtDiscount').value = parseFloat((Number(document.getElementById('txtGross').value) * Number(document.getElementById('ddDiscountPercent').value)) / 100).toFixed(2);
                //                document.getElementById('txtDiscountPercent').style.display = 'None';
                CheckTotal();
            }
        }
        function CheckTotal() {
            // pTotalAmount();
            GetNetAmount();
            checkIsCredit();
            SetOtherCurrValues();
        }
        function CheckDiscount() {
            //pTotalAmount();
            GetNetAmount();
            SetOtherCurrValues();

        }


        function CheckDueTotal() {
            var AmountRecieved = document.getElementById('txtAmountRecieved').value;
            var AmountRecieved = document.getElementById('hdnAmountRecieved').value;
            var GrandTotal = document.getElementById('hdnGrandTotal').value;

            var serviceCharge = document.getElementById('txtServiceCharge').value;
            GrandTotal = parseFloat(GrandTotal);

            if (parseFloat(GrandTotal) >= parseFloat(AmountRecieved)) {
                var AmountDue = document.getElementById('txtDue').value = parseFloat(parseFloat(GrandTotal) - parseFloat(AmountRecieved)).toFixed(2);
                var AmountDue = document.getElementById('hdnDueAmount').value = parseFloat(parseFloat(GrandTotal) - parseFloat(AmountRecieved)).toFixed(2);

            }
            else {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_22');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('Provide received amount less than or equal to net amount');
                    return false;
                }
            }
            SetOtherCurrValues();

        }



        function chkCreditPament() {
            document.getElementById('chkisCreditTransaction').checked = false;
        }

        function checkIsCredit() {
            if (document.getElementById('chkisCreditTransaction').checked == true) {
                document.getElementById('txtAmountRecieved').value = '0.00';
                document.getElementById('hdnAmountRecieved').value = '0.00';
                //                document.getElementById('hdnTotalAmtRec').value = '0.00';
                document.getElementById('txtAmountRecieved').disabled = true;
                document.getElementById('divpayType').disabled = true;
                document.getElementById('PaymentType_txtAmount').value = 0;
                ClearPaymentControlEvents();
                changeAmountValues();

            }
            if (document.getElementById('chkisCreditTransaction').checked == false) {
                document.getElementById('divpayType').disabled = false;
                document.getElementById('txtAmountRecieved').disabled = false;
            }
        }


        function GetNetAmount() {
            var tempTaxAmt;
            var Total;
            var PrDue = 0;

            PrDue = 0;  //document.getElementById('txtPreviousDue').value;
            var tax = document.getElementById('txtTax').value == 0.00 ? 0 : document.getElementById('txtTax').value;
            var tax = document.getElementById('hdnTax').value == 0.00 ? 0 : document.getElementById('hdnTax').value;

            //            if ((document.getElementById('ddDiscountPercent').value) != 'select') {
            //                if ((document.getElementById('ddDiscountPercent').value) == '0.00') {
            //                    document.getElementById('txtDiscount').value = parseFloat((parseFloat(document.getElementById('txtGross').value) / 100) * (document.getElementById('txtDiscountPercent').value)).toFixed(2);
            //                    //document.getElementById('txtDiscountPercent').visible = true;
            //                    document.getElementById('txtDiscountPercent').style.display = 'Block';
            //                }
            //                else {
            //                    document.getElementById('txtDiscount').value = parseFloat((parseFloat(document.getElementById('txtGross').value) / 100) * (document.getElementById('ddDiscountPercent').value)).toFixed(2);
            //                }
            //                document.getElementById('txtDiscount').readOnly = true;
            //            }

            //            else {
            //                document.getElementById('txtDiscount').readOnly = false;
            //            }

            var Discount = document.getElementById('txtDiscount').value == 0.00 ? 0 : document.getElementById('txtDiscount').value;

            var GrandTotal = document.getElementById('txtGross').value == 0.00 ? 0 : document.getElementById('txtGross').value;
            var GrandTotal = document.getElementById('hdnGross').value == 0.00 ? 0 : document.getElementById('hdnGross').value;

            var PreviousDue = document.getElementById('txtDue').value == 0.00 ? 0 : document.getElementById('txtDue').value;
            Total = parseFloat(parseFloat(GrandTotal) - parseFloat(Discount)).toFixed(2);
            if (Total < 0) {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_21');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('Discount Amount should not exceed total amount');
                    return false;
                }
                document.getElementById('txtDiscountPercent').value = 0.00;
                document.getElementById('txtDiscount').value = 0.00;
                var Discount = document.getElementById('txtDiscount').value == 0.00 ? 0 : document.getElementById('txtDiscount').value;

                var GrandTotal = document.getElementById('txtGross').value == 0.00 ? 0 : document.getElementById('txtGross').value;
                var GrandTotal = document.getElementById('hdnGross').value == 0.00 ? 0 : document.getElementById('hdnGross').value;

                var PreviousDue = document.getElementById('txtDue').value == 0.00 ? 0 : document.getElementById('txtDue').value;
                Total = parseFloat(parseFloat(GrandTotal) - parseFloat(Discount)).toFixed(2);
            }


            tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(2);
            var beforeRoundNet = parseFloat(parseFloat(Total) + parseFloat(PreviousDue) + parseFloat(PrDue)).toFixed(2);
            // var RoundNetAmt = parseFloat(getOPCustomRoundoff(parseFloat(Total) + parseFloat(PreviousDue))).toFixed(2);
            document.getElementById('txtGrandTotal').value = beforeRoundNet;
            document.getElementById('hdnGrandTotal').value = beforeRoundNet;
            // document.getElementById('txtRoundoffAmount').value = parseFloat(RoundNetAmt - beforeRoundNet).toFixed(2);
            //document.getElementById('hdnRoundBalace').value = document.getElementById('txtRoundoffAmount').value;
            //document.getElementById('PaymentType_txtAmount').value = beforeRoundNet;
            //if (document.getElementById('hdnUseDeposit').value == "N") {
            document.getElementById('PaymentType_txtAmount').value = beforeRoundNet;
            // }
            changeAmountValues(); //???

            //CheckDueTotal();
        }
        function DueCal() {
            var tempTaxAmt;
            var Total;
            var tax = document.getElementById('txtTax').value == 0.00 ? 0 : document.getElementById('txtTax').value;
            var tax = document.getElementById('hdnTax').value == 0.00 ? 0 : document.getElementById('hdnTax').value;

            var Discount = document.getElementById('txtDiscount').value == 0.00 ? 0 : document.getElementById('txtDiscount').value;
            var GrandTotal = document.getElementById('txtGrandTotal').value == 0.00 ? 0 : document.getElementById('txtGrandTotal').value;
            //    var GrandTotal = document.getElementById('hdnGrandTotal').value == 0.00 ? 0 : document.getElementById('hdnGrandTotal').value;
            var PreviousDue = document.getElementById('txtDue').value == 0.00 ? 0 : document.getElementById('txtDue').value;

            document.getElementById('txtDiscount').value = parseFloat(Discount).toFixed(2);
            Total = parseFloat(parseFloat(GrandTotal) - parseFloat(Discount)).toFixed(2);
            tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(2);
            document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(Total) + parseFloat(PreviousDue)).toFixed(2);
            document.getElementById('hdnGrandTotal').value = parseFloat(parseFloat(Total) + parseFloat(PreviousDue)).toFixed(2);

            //CheckDueTotal();

        }

        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {


            var ConValue = "OtherCurrencyDisplay2";

            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 2);
            sVal = format_number(Number(sVal) + Number(TotalAmount), 2);
            if (PaymentAmount > 0) {

                if (Number(sNetValue) >= Number(sVal)) {
                    sVal = format_number(sVal, 2);
                    SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
                    var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
                    var pScrAmt = Number(pScr) * Number(CurrRate);
                    var pAmt = Number(sVal) * Number(CurrRate);

                    document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2)



                    //var amtRec = document.getElementById('hdnDepositUsed').value;
                    amtRec = 0;
                    document.getElementById('hdnAmountRecieved').value = format_number(Number(amtRec) + Number(pAmt), 2);
                    document.getElementById('txtAmountRecieved').value = format_number(Number(amtRec) + Number(pAmt), 2);

                    var pTotal = Number(Number(sNetValue)) * Number(CurrRate);


                    document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);
                    document.getElementById('hdnGrandTotal').value = format_number(Number(pTotal), 2);
                    CheckDueTotal();
                    //doCalcReimburse();
                    return true;
                }
                else {
                    var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_24');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                        
                    }

                    else {
                        alert('Amount provided is greater than net amount');
                        return false;
                    }
                }
            }
            else {
                //doCalcReimburse();
                return true;
            }

        }


        function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {

            var ConValue = "OtherCurrencyDisplay2";
            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate");

            sVal = Number(Number(sVal) - Number(TotalAmount));
            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);


            document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2);
            // var amtRec = document.getElementById('hdnDepositUsed').value;
            amtRec = 0;
            document.getElementById('hdnAmountRecieved').value = format_number(Number(sVal) + Number(amtRec), 2);
            document.getElementById('txtAmountRecieved').value = format_number(Number(sVal) + Number(amtRec), 2);

            SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);

            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

            document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);
            document.getElementById('hdnGrandTotal').value = format_number(Number(pTotal), 2);
            CheckDueTotal();
            //doCalcReimburse();
        }



    </script>

    <script language="javascript" type="text/javascript">

        function Clearmsg() {
            if (document.getElementById('lblClinic') != undefined) {
                document.getElementById('lblClinic').innerHTML = '';
            }
        }
        function PopUpAttributePage() {
            ////debugger;
            GetRate();
            var pTpaID = document.getElementById('ddlTPAnew').value;
            //var pCon = "";
            var pCon = document.getElementById('hdnTPAClientAtttrbuteValue').id;
            var pClientID = document.getElementById('ddlClientnew').value;
            var pConClient = "";
            var pVID = '<%= Request.QueryString["VID"] %>';
            var pID = '<%= Request.QueryString["PID"] %>';
            if (pVID == null) {
                pVID = 0;
            } if (pID == null) {
                pID = 0;
            }
            // var pVID = 0;
            // var pID=0
            var pSelectedID = "";
            var WindowOpen;
            if (document.getElementById('ddlTPAnew').value != '0') {
                WindowOpen = window.open("../InPatient/PopUpAttributePage.aspx?TPAID=" + pTpaID + "&Con=" + pCon + "&IsPopup=Y&VID=" + pVID + "&PID=" + pID + "&type=NEW", 'POP', "height=400,width=590,scrollbars=no", true);
                WindowOpen.focus();
            }

            if (document.getElementById('ddlClientnew').value != '0') {
                WindowOpen = window.open("../InPatient/PopUpAttributePage.aspx?ClientID=" + pClientID + "&Con=" + pCon + "&IsPopup=Y&VID=" + pVID + "&PID=" + pID + "&type=NEW", 'POP', "height=400,width=590,scrollbars=no", true);
                WindowOpen.focus();
            }

        }
        function GetRate() {
            ////debugger;
            var refPhyID = '-1';
            var refOrgID = '-1';
            var payerID = '-1';
            var TpaOrClientID = '0';
            var Type = '';
            if (document.getElementById('txtPhysician').value != '') {
                refPhyID = document.getElementById('hdnPhysicianID').value;
                refOrgID = document.getElementById('ddlHospital').value;
                payerID = document.getElementById('ddlPayerType').value;
            }
            if (document.getElementById('ddlPayerType').value == "3") {
                if (document.getElementById('rdoTpa').checked) {
                    TpaOrClientID = document.getElementById('ddlTPAnew').value;
                    Type = "TPA";
                    WebService.GetPCClient(OrgID, refOrgID, refPhyID, payerID, TpaOrClientID, Type, getTpaClientRate);
                }
                if (document.getElementById('rdoClient').checked) {
                    TpaOrClientID = document.getElementById('ddlClientnew').value;
                    Type = "Client";
                    WebService.GetPCClient(OrgID, refOrgID, refPhyID, payerID, TpaOrClientID, Type, getTpaClientRate);
                }
            }
        }
        function getTpaClientRate(result) {
            var ddlRateType = document.getElementById("ddlRateType");
            //res.innerHTML = "<b>" + result + "</b>";
            //alert(result.length);
            ddlRateType.innerHTML = "";
            var option = document.createElement("option");
            option.value = 0;
            option.innerHTML = "-----Select-----";
            ddlRateType.appendChild(option);
            for (var n = 0; n < result.length; n++) {
                var optionNew = document.createElement("option");
                //alert(result[0].RefOrgName);
                optionNew.value = result[n].RateId;
                optionNew.innerHTML = result[n].RateName;
                ddlRateType.appendChild(optionNew);
            }
            var items = $("#ddlRateType option").length;
            if (items > 1) {
                document.getElementById("ddlRateType").selectedIndex = 1;
            }
        }

        function showclient(ID) {

            if (document.getElementById(ID).checked == true) {
                document.getElementById('<%= tdclient.ClientID %>').style.display = 'block';

                document.getElementById('<%= tdTPA.ClientID %>').style.display = 'none';
                document.getElementById('<%= ddlTPAnew.ClientID %>').value = "0"
                document.getElementById('<%= pnlAttrib.ClientID %>').style.display = 'none';

            }
            // Code modified by Vijay TV to fix Bugtracker Issue ID 812 begins...
            // Set the 'Is Reimbursible' check box of Parent page (GenerateBill.Aspx) to Checked status. Since this control
            // is only in GenerateBill.Aspx, for other Parent pages, this will throw error and hence handled 'Undefined'
            if (parent.document.getElementById('chkIsRI') != undefined)
                parent.document.getElementById('chkIsRI').checked = true;
            // Code modified by Vijay TV to fix Bugtracker Issue ID 812 ends...
        }
        function showTPA(TPAID) {
            if (document.getElementById(TPAID).checked == true) {
                document.getElementById('<%= tdTPA.ClientID %>').style.display = 'block';

                document.getElementById('<%= tdclient.ClientID %>').style.display = 'none';
                document.getElementById('<%= ddlClientnew.ClientID %>').value = "0"

            }
            // Code modified by Vijay TV to fix Bugtracker Issue ID 812 begins...
            // Set the 'Is Reimbursible' check box of Parent page (GenerateBill.Aspx) to Checked status. Since this control
            // is only in GenerateBill.Aspx, for other Parent pages, this will throw error and hence handled 'Undefined'
            if (parent.document.getElementById('chkIsRI') != undefined)
                parent.document.getElementById('chkIsRI').checked = true;
            // Code modified by Vijay TV to fix Bugtracker Issue ID 812 ends...
        }

        function showNone(ID) {
            if (document.getElementById(ID).checked == true) {
                document.getElementById('<%= tdclient.ClientID %>').style.display = 'none';
                document.getElementById('<%= tdTPA.ClientID %>').style.display = 'none';
                document.getElementById('<%= ddlTPAnew.ClientID %>').value = "0"
                document.getElementById('<%= ddlClientnew.ClientID %>').value = "0"
                document.getElementById('<%= pnlAttrib.ClientID %>').style.display = 'none';

            }
            // Code modified by Vijay TV to fix Bugtracker Issue ID 812 begins...
            // Set the 'Is Reimbursible' check box of Parent page (GenerateBill.Aspx) to Unchecked
            if (parent.document.getElementById('chkIsRI') != undefined)
                parent.document.getElementById('chkIsRI').checked = false;
            // Code modified by Vijay TV to fix Bugtracker Issue ID 812 ends...
        }
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
            var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_26');
            if (userMsg != null) {
                alert(userMsg);
                return false;
                
            }

            else {
                alert('Timeout has occured');
                return false;
            }
        }

        function OnWSRequestFailed(arg) {
            var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_28');
            if (userMsg != null) {
                alert(userMsg);
                return false;
                
            }
            else {
                alert('Error has occured: ');
                return false;
            }
        }
        function ShowLogin(ctl) {
            if (ctl.checked == true) {
                document.getElementById("Login").style.display = "block";
                var DrName = document.getElementById("txtDrName1").value;
                var Temp = DrName.split(' ');
                document.getElementById("txtUserName").value = Temp[0];
            }
            else {
                document.getElementById("Login").style.display = "none";
                document.getElementById("txtUserName").value = "";
            }


        }

    </script>

    <script language="javascript" type="text/javascript">

        function validateLabRefPhysicianDetails() {
            if (document.getElementById('txtDrName1').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_29');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('Provide physician name');
                    return false;
                }
                document.getElementById('txtDrName1').focus();
            }
            if (document.getElementById('ddSalutation1').value == '0') {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_30');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('Select salutation');
                    return false;
                }
                document.getElementById('ddSalutation1').focus();

                if (document.getElementById('ddlPatientCategory').value == '1') {
                    if (document.getElementById('txtward').value == 'null') {
                        var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_31');
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;
                            
                        }

                        else {
                            alert('Please Enter The WardNo');
                            return false;
                        }
                        document.getElementById('txtward').focus();
                    }
                }
            }
        }

        function checkSearchName() {
            if (document.getElementById('txtSearchPhysicianName').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_32');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('Provide the search text to find the physician');
                    return false;
                }
                document.getElementById('txtSearchPhysicianName').focus();
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
            if (id == document.getElementById("<%= chklstHsptl.ClientID %>").getAttribute('id')) {
                type = 'GRP';
            }


            document.getElementById('<%= iconHid.ClientID %>').value = document.getElementById('<%= iconHid.ClientID %>').value == "" ? document.getElementById('<%= HdnHospitalID.ClientID %>').value : document.getElementById('iconHid').value;

            var HidValue = document.getElementById('<%= iconHid.ClientID %>').value;
            var list = HidValue.split('|');

            if (document.getElementById('<%= iconHid.ClientID %>').value != "") {
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
                document.getElementById('<%= lblHeaderReferingHospitals.ClientID %>').style.display = "block";
                var row = document.getElementById('tblReferingHospitals').insertRow(0);
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
                document.getElementById('<%= iconHid.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "|";
                //rate = obj.options[obj.selectedIndex].text.split(':');
                //total = parseFloat(rate[1]);
                //alert('total:' + parseFloat(total).toFixed(2));

                AddStatus = 2;
                //document.getElementById('tblTot').style.display = "block";

            }
            if (AddStatus == 0) {
                document.getElementById('<%= lblHeaderReferingHospitals.ClientID %>').style.display = 'block';
                var row = document.getElementById('tblReferingHospitals').insertRow(0);
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
                document.getElementById('<%= iconHid.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "|";
                //rate = obj.options[obj.selectedIndex].text.split(':');
                //alert('rae:' + rate[1]);
                //total = parseFloat(total) + parseFloat(rate[1]);

            }
            else if (AddStatus == 1) {
            var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_33');
            if (userMsg != null) {
                alert(userMsg);
                return false;
                
            }

            else {
                alert('Hospital already added');
                return false;
            }
            }
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

            if (ID != document.getElementById('<%= hidID.ClientID %>').value) {
                MyUtil.selectFilter(document.getElementById('<%= hidID.ClientID %>').value, '');
                alert(ID);
                document.getElementById('<%= hidID.ClientID %>').value = ID;

                // document.getElementById('txtBX').value = '';
                //document.getElementById('txtBX').focus();
            }

            return false;
        }
        MyUtil = new Object();
        MyUtil.selectFilterData = new Object();
        MyUtil.selectFilter = function(selectId, filter) {
            selectId = document.getElementById('<%= hidID.ClientID %>').value;
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
            var HdnLPF = document.getElementById('<%= HdnLPF.ClientID %>').value;
            var LPFlist = HdnLPF.split('^');

            if (document.getElementById('<%= HdnLPF.ClientID %>').value != "") {

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
            var HidValue = document.getElementById('<%= iconHid.ClientID %>').value != "" ? document.getElementById('iconHid').value : document.getElementById('HdnHospitalID').value;
            var list = HidValue.split('|');
            var minusamt;
            var newInvList = '';
            if (document.getElementById('<%= iconHid.ClientID %>').value != "" || document.getElementById('<%= HdnHospitalID.ClientID %>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (InvesList[0] != ImgID) {
                            newInvList += list[count] + '|';
                        }
                    }
                }
                document.getElementById('<%= iconHid.ClientID %>').value = newInvList;
                document.getElementById('<%= HdnHospitalID.ClientID %>').value = newInvList;
            }
        }
        function validateLabRefOrgDetails() {
            if (document.getElementById('txtNewClinicName').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_10');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('Provide name');
                    return false;
                }
                document.getElementById('txtNewClinicName').focus();
            }
            if (document.getElementById('txtAddress1').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_35');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('You must provide one address');
                    return false;
                }
                document.getElementById('txtAddress1').focus();
                return false;
            }
            if (document.getElementById('txtCity').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\CompleteLabPatientRegistration.aspx_5');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                    
                }

                else {
                    alert('Provide city');
                    return false;
                }
                document.getElementById('txtCity').focus();
            }
        }

        
    </script>

    <script language="javascript" type="text/javascript">

        document.getElementById('<%= hidID.ClientID %>').value = document.getElementById('<%=chklstHsptl.ClientID %>').id;
    </script>

    </form>
</body>
</html>
