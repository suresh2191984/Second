<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LabPatientRegistration.aspx.cs"--%>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LabPatientRegistration.aspx.cs"
    Inherits="Reception_LabPatientRegistration" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<%@ Register Src="../CommonControls/URNControl.ascx" TagName="URNControl" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/IPClientTpaInsurance.ascx" TagName="ClientTpa"
    TagPrefix="uc9" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Registration</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

        <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>
       <script src ="../scripts/MessageHandler.js" language ="javascript" type ="text/javascript" ></script>
        <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>
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
  
        function ShowUpload(obj, id) {
            if (obj.checked) {
                //  $('[name$="FileUpload1"]').show();
                document.getElementById('TRFimage').style.display = 'block';
            }
            else {
                document.getElementById('TRFimage').style.display = 'none';
                //                $('[name$="FileUpload1"]').empty();
                //                var fu = document.getElementById("FileUpload1");
                //                if (fu != null) {
                //                    document.getElementById("FileUpload1").outerHTML = fu.outerHTML;
                //                }
                //                $('[name$="FileUpload1"]').hide();
            }
        }
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
        function SetType(id) {
            if (id == 'rdoHospital') {
                document.getElementById('hdnRefOrgType').value = "1";
            }
            else if (id == 'rdoClinic') {
                document.getElementById('hdnRefOrgType').value = "2";
            }
            else {
                document.getElementById('hdnRefOrgType').value = "3";
            }

        }
    </script>

</head>
<body onload="pageLoad(); " oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnFinish">

    <script type="text/javascript" language="javascript">
     var userMsg;
        //Validate Salutation
        function LabPatientRegValidation(id) {


         var AlertType = SListForAppMsg.Get('Reception_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Reception_Header_Alert');
         var vPatientName = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_22') == null ? "Provide patient name" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_22');
         var vSelectSex = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_23') == null ? "Select sex" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_23');
         var vPatientAge = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_24') == null ? "Provide patient age" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_24');
         var vWardNo = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_25') == null ? "Provide ward No" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_25');
         var vCity = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_26') == null ? "Provide city" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_26');
         var vDoctorName = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_27') == null ? "Provide name for doctor" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_27');
         var vRefOrg = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_28') == null ? "Select Referring Organization" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_28');
         var vPayerType = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_29') == null ? "Select payer type" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_29');
         var vRateType = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_30') == null ? "Select Rate type" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_30');
         var vInsName = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_31') == null ? "Select TPA/Insurance Name" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_31');
         var vClientName = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_32') == null ? "Select Client Name" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_32');
         var vSeleIns = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_33') == null ? "Select insurance" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_33');
         var vPublish = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_34') == null ? "Select publishing mode" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_34')
         var vProvideName = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_35') == null ? "Provide name" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_35');
         
         
         var v1 = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_49') == null ? "Provide" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_49');
         var v2 = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_50') == null ? "to send notification" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_50');
         
    
         
            //            if (document.getElementById('ddSalutation').value == "0") {
            //                alert('Please Select Salutation');
            //                document.getElementById('ddSalutation').focus();
            //                return false;
            //            }

            if (document.getElementById('txtPatientName').value.trim() == '') {
             userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_2');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  // alert('Provide patient name');
                  ValidationWindow(vPatientName, AlertType);
                             return false;
                
                }
                document.getElementById('txtPatientName').focus();
                return false;
            }
            if (document.getElementById('ddSex').value == "0") {
             userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_3');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  // alert('Select sex');
                  
                  ValidationWindow(vSelectSex, AlertType);
                             return false;
                
                }
                document.getElementById('ddSex').focus();
                return false;
            }
            if (document.getElementById('txtAge').value == '') {
             userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_4');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  // alert('Provide patient age');

                  ValidationWindow(vPatientAge, AlertType);
                             return false;
                
                }
                document.getElementById('txtAge').focus();
                return false;
            }
            if (document.getElementById('ddlPatientCategory').value == "1") {
                if (document.getElementById('txtward').value == '') {
                 userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_5');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  // alert('Provide ward No');
                  ValidationWindow(vWardNo, AlertType);
                             return false;
                    
                    }
                    document.getElementById('txtward').focus();
                    return false;
                }
            }
            //    if (document.getElementById('patientAddressCtrl_txtAddress2').value == '') 
            //    {
            //        alert('Please Enter Street/Road Name');
            //        document.getElementById('patientAddressCtrl_txtAddress2').focus();
            //        return false;
            //    }

            //            if (URN == "Y") {

            //                if (document.getElementById('URNControl1_txtURNo').value == '') {
            //                    alert('Provide the URN');
            //                    document.getElementById('URNControl1_txtURNo').focus();
            //                    return false;
            //                }
            //            }
            //            if (document.getElementById('URNControl1_txtURNo').value != '') {

            //                if (document.getElementById('URNControl1_ddlUrnType').value == '0') {
            //                    alert('Provide the URN type ');
            //                    document.getElementById('URNControl1_ddlUrnType').focus();
            //                    return false;
            //                }
            //            }







            if (document.getElementById('ucPAdd_txtCity').value.trim() == '') {
             userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_9');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                 // alert('Provide city');
                  ValidationWindow(vCity, AlertType);
                             return false;
                
                }
                document.getElementById('ucPAdd_txtCity').focus();
                return false;
            }
            //            if (document.getElementById('txtPhysician').value.trim() == '' && document.getElementById('chkPhyOthers').checked != true) {
            //                alert('Please Select Doctor Name');
            //                document.getElementById('txtPhysician').focus();
            //                return false;
            //            }
            //            else
            if (document.getElementById('chkPhyOthers').checked) {
                if (document.getElementById('txtDrName').value.trim() == '') {
                 userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_11');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{

                  //alert('Provide name for doctor');

                  ValidationWindow(vDoctorName, AlertType);
                             return false;
                    
                    }
                    document.getElementById('txtPhysician').focus();
                    return false;
                }
            }
            else {
                // hdnPhysicianID
                //                var DrName = document.getElementById('txtPhysician').value;
                //                var splitName = DrName.split('~');
                //                if (splitName.length > 1) {

                //                } else {
                //                    alert('please Select Doctor name from list');
                //                    document.getElementById('txtPhysician').value = "";
                //                    document.getElementById('txtPhysician').focus();
                //                    return false;
                //                }

            }

            if (document.getElementById('ddlHospital').value == "0" && document.getElementById('ddlClinic').value == "0" && document.getElementById('ddlLab').value == "0") {
             userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_39');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  /// alert('Select Referring Organization');
                  ValidationWindow(vRefOrg, AlertType);
                             return false;
                
                }
                document.getElementById('ddlHospital').focus();
                return false;
            }
            if (document.getElementById('ddlPayerType').value == "0") {
             userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_14');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  //alert('Select payer type');
                  ValidationWindow(vPayerType, AlertType);
                             return false;
                
                }
                document.getElementById('ddlPayerType').focus();
                return false;
            }
            if (document.getElementById('ddlRateType').value == "0") {
             userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_40');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  //alert('Select Rate type');
                  ValidationWindow(vRateType, AlertType);
                             return false;
                
                }
                document.getElementById('ddlPayerType').focus();
                return false;
            }

            if (document.getElementById('ddlPayerType').value == "3") {
                if ((document.getElementById('rdoTpa').checked == true) && (document.getElementById('ddlTPAnew').value == "0")) {
                 userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_15');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  // alert('Select TPA/Insurance Name');
                  ValidationWindow(vInsName, AlertType);
                             return false;
                    
                    }
                    document.getElementById('ddlTPAnew').focus();
                    return false;
                }
                if ((document.getElementById('rdoClient').checked == true) && (document.getElementById('ddlClientnew').value == "0")) {
                 userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_17');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  //alert('Select Client Name');
                  ValidationWindow(vClientName, AlertType);
                             return false;
                    
                    }
                    document.getElementById('ddlClientnew').focus();
                    return false;
                }
            }

            if ((document.getElementById('rdPackage').checked == true) && (document.getElementById('ddlPkg').options[0].selected == true)) {
             userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_16');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                //alert('Select insurance');
                  ValidationWindow(vSeleIns, AlertType);
                             return false;
                
                }
                document.getElementById('ddlPkg').focus();
                return false;
            }
            //            if ((document.getElementById('rdClient').checked == true) && (document.getElementById('ddlClients').value == "0")) {
            //                alert('Select client');
            //                document.getElementById('ddlClients').focus();
            //                return false;
            //            }
            //            if ((document.getElementById('rdClient').checked == true) && (document.getElementById('ddlClients').options[document.getElementById('ddlClients').selectedIndex].text == 'Collection Centre')) {
            //                if (document.getElementById('ddlCollectionCentre').value == '0') {
            //                    alert('Select collection centre');
            //                    document.getElementById('ddlCollectionCentre').focus();
            //                    return false;
            //                }
            //            }
            //            if (document.getElementById('ddPublishingMode').value == '0' && document.getElementById('txtEmailID').value.trim() == '') {
            //                alert('Please Select Publishing Mode');
            //                document.getElementById('ddPublishingMode').focus();
            //                return false;
            //            }
            //            if (document.getElementById('txtEmailID').value.trim() != '') {
            //                if (echeck(document.getElementById('txtEmailID').value) == false) {
            //                    document.getElementById('txtEmailID').value = "";
            //                    document.getElementById('txtEmailID').focus();
            //                    return false;
            //                }
            //            }
            if (document.getElementById('ddPublishingMode').value != '0') {
                if (document.getElementById('ddPublishingMode').value == '0' && document.getElementById('txtEmailID').value.trim() == '') {
                 userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_20');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                    //alert('Select publishing mode');
                    ValidationWindow(vPublish,AlertType);
                             return false;
                    
                    }
                    document.getElementById('ddPublishingMode').focus();
                    return false;
                }
                if (document.getElementById('txtName').value.trim() == '') {
                 userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_35');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                    //alert('Provide name');
                    ValidationWindow(vProvideName, vSeleIns AlertType);
                             return false;
                    
                    }
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
                 userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_9');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                    //alert('Provide city');
                  ValidationWindow(vCity, AlertType);
                             return false;
                    
                    }
                    document.getElementById('shippingAddress_txtCity').focus();
                    return false;
                }
            }
            if (document.getElementById('chkIsNotify').checked == true) {
                var message = '';
                if (document.getElementById('txtEmailID').value.trim() == '')
                    message = "E-mail address";
                if (document.getElementById('ucPAdd_txtMobile').value.trim() == '') {
                    if (message == '')
                        message = "Mobile Number";
                    else
                        message = message + " and Mobile Number";
                }
                if (message != '') {
                 ValidationWindow(v1 + message + v2 , AlertType);
                
                    //alert('Provide '+ message +' to send notification');
                    document.getElementById('txtEmailID').focus();
                    return false;
                }
            }
            //return checkForCurrentDate('tDOB', 'Date Of Birth');

            //GetKnowledgeDesc();
            document.getElementById(id).style.visibility = 'hidden';
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
        
         var vProviderAge = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_37') == null ? "Provide age in (days or weeks or months or year) & choose appropriate from the list" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_37');
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
             userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_24');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
               // alert('Provide age in (days or weeks or months or year) & choose appropriate from the list');
                ValidationWindow(vProviderAge, AlertType);
                             return false;
                
                }
                document.getElementById('txtAge').focus();
                return false;
            }
            return true;
        }
        function ClearDOB() {
        
        var vValidYear = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_40') == null ? "Provide a valid year" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_40');
        var vValidMonth = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_41') == null ? "Provide a valid month" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_41');
   
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
                 userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_25');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                    //alert('Provide a valid year');
                    ValidationWindow(vValidYear, AlertType);
                             return false;
                    
                    }
                    document.getElementById('txtAge').value = '';
                    document.getElementById('txtAge').focus();
                    return false;
                }
                //                currentTime = new Date(); 
                //                var yr = currentTime.getFullYear();
                //                var givenyr = document.getElementById('txtDOBNos').value;
                //                var dobyear = yr - givenyr;
                //                alert('dobyear : ' + dobyear);
            }
            if (document.getElementById('ddlAgeUnit').value == 'Month(s)') {

                if (document.getElementById('txtAge').value >= 2500) {
                 userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_25');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                    //alert('Provide a valid month');
                    ValidationWindow(vValidMonth, AlertType);
                             return false;
                    
                    }
                    document.getElementById('txtAge').value = '';
                    document.getElementById('txtAge').focus();
                    return false;
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
          var vPhysicianList = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_42') == null ? "Select physician name from the list" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_42');
   
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
                     userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_27');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                    //alert('Select physician name from the list');
                    ValidationWindow(vPhysicianList, AlertType);
                    return false ;
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
                }
            }
            else {
                functionClear();
                pID = document.getElementById('hdnID').value = '';
            }
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
            document.getElementById('DrpRelationtype').value = patientList[0].RelationTypeId// == '' ? '0' : patientList[0].RelationshipID;
            document.getElementById("txtRelationname").value = patientList[0].RelationName;
            document.getElementById("txtpreviousname").value = patientList[0].PreviousKnownName;
            document.getElementById("TxtAliasname").value = patientList[0].AliasName;
            document.getElementById("ddRace").value = patientList[0].Race == '' ? '0' : patientList[0].Race;
            if (document.getElementById("txtEmailID").value == 'null') {
                document.getElementById("txtEmailID").value = '';
            }


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
                return true;
            }

            else (document.getElementById('ddlPatientCategory').value == '0')
            {

                document.getElementById('trWardNo').style.display = 'none';
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
                    <div class="contentdata" style="height: auto; overflow: visible">
                        <asp:Label ID="Rs_RegisterthePatientsDetails" Text="Register the Patient's Details."
                            runat="server"></asp:Label>
                        <table border="0" cellpadding="2" cellspacing="1" width="100%">
                            <%--<tr>
                                <td >
                                    <table border="0" id="mytable1" cellpadding="4" cellspacing="0" width="100%">
                                        <tr>
                                            <td colspan="5" id="us">
                                              
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>--%>
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel1" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="padding-top: 5px;">
                                                    <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                        <tr valign="top">
                                                            <td align="right" style="width: 18%;">
                                                                <asp:Label ID="Rs_PatientsName" Text="Patient's Name" runat="server"></asp:Label>
                                                            </td>
                                                            <td style="width: 38%;">
                                                                <asp:DropDownList ID="ddSalutation" ToolTip="Select Salutation" onchange="javascript:return setSex();"
                                                                    runat="server" Width="80px" TabIndex="1">
                                                                </asp:DropDownList>
                                                                <asp:TextBox ID="txtPatientName" ToolTip="Patient Name" onblur="ConverttoUpperCase(this.id); GetPatientDetails(this.value);"
                                                                    runat="server" MaxLength="60" TabIndex="2"></asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtPatientName"
                                                                    EnableCaching="false" FirstRowSelected="true" CompletionInterval="100" CompletionSetCount="10"
                                                                    MinimumPrefixLength="2" CompletionListCssClass="listtwo" CompletionListItemCssClass="listitemtwo"
                                                                    CompletionListHighlightedItemCssClass="hoverlistitemtwo" ServiceMethod="GetPatientListWithDetails"
                                                                    ServicePath="~/InventoryWebService.asmx">
                                                                </ajc:AutoCompleteExtender>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                            <td>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <table>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="Rs_PatientCategory" Text="Patient Category" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:DropDownList ID="ddlPatientCategory" TabIndex="3" runat="server" onchange="javascript:return PatientCategory();">
                                                                                <%--  andrews          <asp:ListItem Value="0">OP</asp:ListItem>
                                                                                            <asp:ListItem Value="1">IP</asp:ListItem>--%>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td>
                                                                            <table>
                                                                                <tr style="display: none;" id="trWardNo" runat="server">
                                                                                    <td align="right">
                                                                                        <asp:Label ID="lblWard" runat="server" Text="WardNo"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtward" runat="server" Width="65px"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td align="right" style="width: 20%; display: none;">
                                                                <asp:Label ID="Rs_Priority" Text="Priority" runat="server"></asp:Label>
                                                            </td>
                                                            <td style="width: 27%; display: none;">
                                                                <asp:DropDownList ID="ddlPriority" ToolTip="Select Work Order Priority" runat="server" Width="69px">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" colspan="4" style="padding-bottom: 2px;">
                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <table style="width: 100%;">
                                                                                <tr>
                                                                                    <td align="right" style="width: 18%;">
                                                                                        <asp:Label ID="lblPreviousname" runat="server" Text="Previously Known as"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtpreviousname" runat="server" TabIndex="4">
                                                                                        </asp:TextBox>
                                                                                    </td>
                                                                                    <td align="right" style="width: 27%;">
                                                                                        <asp:Label ID="LblAlias" runat="server" Text="Alias Name"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="TxtAliasname" runat="server" TabIndex="5"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="left" style="width: 18%;">
                                                                                        <asp:Label ID="LblRtype" runat="server" Text="Relation&Name"></asp:Label>
                                                                                        <asp:DropDownList ID="DrpRelationtype" runat="server" TabIndex="6">
                                                                                          
                                                                                        </asp:DropDownList>
                                                                                       
                                                                                 </td>
                                                                                   <td>
                                                                                    
                                                                                        <asp:TextBox ID="txtRelationname" runat="server" TabIndex="7"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            <uc8:AddressControl ID="ucPAdd" runat="server" TabIndex="8" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="5">
                                                                <table border="0" width="100%">
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label ID="Rs_Nationality" Text="Nationality" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlNationality" runat="server" TabIndex="18">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Label ID="Rs_DateofBirth" Text="Date of Birth" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="tDOB" ToolTip="Date Of Birth" runat="server" Width="130px" MaxLength="1"
                                                                                Style="text-align: justify" ValidationGroup="MKE" TabIndex="19" onblur="javascript:countAgeLab(this.id);" />
                                                                                
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
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width: 18%" align="right">
                                                                            <asp:Label ID="Rs_Age" Text="Age" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtAge" ToolTip="Age" Width="65px" runat="server" MaxLength="3"
                                                                                TabIndex="20" onblur="javascript:ClearDOB();"></asp:TextBox>
                                                                            <asp:DropDownList ID="ddlAgeUnit" TabIndex="21" onblur="javascript:ClearDOB();" onChange="javascript:getDOB();"
                                                                                runat="server" ToolTip="Select Age Duration">
                                                                              <%-- andrews  <asp:ListItem Value="Day(s)">Day(s)</asp:ListItem>
                                                                                <asp:ListItem Value="Week(s)">Week(s)</asp:ListItem>
                                                                                <asp:ListItem Value="Month(s)">Month(s)</asp:ListItem>
                                                                                <asp:ListItem Value="Year(s)" Selected="True">Year(s)</asp:ListItem>--%>
                                                                            </asp:DropDownList>
                                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" /><img src="../Images/starbutton.png"
                                                                                alt="" align="middle" />
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Label ID="Rs_Sex" Text="Sex" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 31%;">
                                                                        <asp:DropDownList ID="ddSex" runat="server" ToolTip="Select Sex" TabIndex="22">
                                                          <%-- andrews          <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                                                <asp:ListItem Value="M">Male</asp:ListItem>
                                                                                <asp:ListItem Value="F">Female</asp:ListItem>
                                                                                <asp:ListItem Value="NotKnown">NotKnown</asp:ListItem>--%>
                                                                            </asp:DropDownList>
                                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right" style="width: 18%;">
                                                                            <asp:Label ID="Rs_Race" Text="Race" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddRace" runat="server" TabIndex="23">
                                                                            </asp:DropDownList>
                                                                            <%--<asp:TextBox ID="txtRace" ToolTip="Race" runat="server" MaxLength="60" ></asp:TextBox>--%>
                                                                        </td>
                                                                        <%-- </tr>
                                                        <tr>--%>
                                                                        <td align="right">
                                                                            <asp:Label ID="Rs_email" Text="e-mail" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 30%;" colspan="3">
                                                                            <asp:TextBox ID="txtEmailID" runat="server" ToolTip="Contact E-Mail Address" MaxLength="60"
                                                                                TabIndex="24"></asp:TextBox>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                            <asp:CheckBox ID="chkIsNotify" Text="Send Notification" runat="server" Style="display:none;" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="display: block;">
                                                                        <td colspan="4">
                                                                            <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                                                                <tr>
                                                                                    <td align="right" style="display: none;">
                                                                                        <asp:Label ID="Rs_Mobile1" Text="Mobile" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="display: none;">
                                                                                        <asp:TextBox ID="txtMobile"  ToolTip="Contact Mobile Number" runat="server"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <%--<td >
                                                             Patient Category
                                                             <asp:DropDownList ID="DropDownList1" runat="server" onchange="javascript:return PatientCategory();">
                                                             
                                                             <asp:ListItem Value ="0">OP</asp:ListItem>
                                                             <asp:ListItem Value ="1">IP</asp:ListItem>
                                                             </asp:DropDownList>      
                                                            </td>--%>
                                                            <td colspan="4">
                                                                <uc7:URNControl ID="URNControl1" runat="server" TabIndex="25" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                                <td colspan="4">
                                                                    <input id="chkUploadPhoto" runat="server" value="Upload" type="checkbox" onclick="ShowUpload(this, this.id);"
                                                                        name="PatientPhoto" /><label for="chkUploadPhoto" id="lblUploadPhoto" runat="server"
                                                                            style="color: #2C88B1; font-size:small; font-weight: bold;">TRF Image Upload</label>
                                                                               <asp:HiddenField ID="hdnPatientImageName" runat="server" Value="" />
                                                                </td>
                                                            </tr>
                                                       
                                                            
                                                            <tr>
                                                            <td>
                                                            <div id="TRFimage" style="display: none;">
        <asp:FileUpload ID="FileUpload1" runat="server" class="multi" /> 
     
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
                                    <asp:Panel ID="Panel3" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td style="padding-top: 1px;">
                                                                <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td align="right" style="width: 20%;">
                                                                            <asp:Label ID="Rs_ReferingPhysicianName" Text="Refering Physician Name" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 55%;">
                                                                            <asp:TextBox ID="txtPhysician" ToolTip="Refering Physician(Doctor) Name" runat="server"
                                                                                autocomplete="off" Width="200px" TabIndex="29" onblur="ConverttoUpperCase(this.id); getList(this.value);"></asp:TextBox>
                                                                            <%-- &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                                            <ajc:AutoCompleteExtender ID="AutoRname" runat="server" TargetControlID="txtPhysician"
                                                                                FirstRowSelected="true" ServiceMethod="GetPhysician" ServicePath="~/WebService.asmx"
                                                                                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="2" BehaviorID="AutoCompleteEx1"
                                                                                CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                                                            </ajc:AutoCompleteExtender>
                                                                        </td>
                                                                        <td style="font-weight: normal; height: 20px; color: #000; width: 30%;" align="left">
                                                                            <asp:UpdatePanel ID="Up2" runat="server">
                                                                                <ContentTemplate>
                                                                                    <asp:LinkButton ForeColor="Red" runat="server" ToolTip="Click here to add new Referring Physician"
                                                                                        ID="lnkAddnew" Text="Add New Ref Physician" OnClick="lnkAddnew_Click"></asp:LinkButton>
                                                                                    <asp:Label ID="ltrMsg" runat="server"></asp:Label>
                                                                                </ContentTemplate>
                                                                            </asp:UpdatePanel>
                                                                        </td>
                                                                        <td style="width: 20%; display: none;">
                                                                            <asp:Label ID="Rs_IfOthers" Text="If Others" runat="server"></asp:Label><input type="checkbox"
                                                                                id="chkPhyOthers"  onclick="javascript:setPhysician();" runat="server"
                                                                                value="1" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="padding-bottom: 3px;">
                                                                <div id="trPhysician" style="display: none;" runat="server">
                                                                    <table border="0" cellpadding="2" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td style="width: 15%;" align="right">
                                                                                <asp:Label ID="Rs_ReferringPhysicianName" Text="Referring Physician Name" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td align="left" style="width: 20%;">
                                                                                <asp:TextBox ID="txtDrName" ToolTip="Referring Physician(Doctor) Name" runat="server"
                                                                                    MaxLength="60" TabIndex="30"></asp:TextBox>
                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                            </td>
                                                                            <td style="width: 10%;" align="right">
                                                                                <asp:Label ID="Rs_Qualification" Text="Qualification" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td align="left" style="width: 10%;">
                                                                                <asp:TextBox ID="txtDrQualification" ToolTip="Referring Physician(Doctor) Qualification"
                                                                                    runat="server" MaxLength="40" TabIndex="31" Width="100px"></asp:TextBox>
                                                                            </td>
                                                                            <td style="width: 10%;" align="right">
                                                                                <asp:Label ID="Rs_Organization" Text="Organization" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td align="center" style="width: 10%;">
                                                                                <asp:TextBox ID="txtDrOrganization" TabIndex="32" ToolTip="Referring Physician(Doctor) Organisation"
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
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel7" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td style="width: 32%;">
                                                                <asp:Panel ID="pnRefOrg" Width="60%" GroupingText="Referring Organization Type" runat="server">
                                                                    <asp:RadioButton ID="rdoHospital" type="radio" Text="Hospital" Checked="true" GroupName="RefOrgType1"
                                                                        TabIndex="33" value="1" onclick="javascript:showHideClientType(this);" runat="server" />
                                                                    <asp:RadioButton ID="rdoBranch" TabIndex="34" type="radio" Text="Clinic" value="2"
                                                                        GroupName="RefOrgType1" onclick="javascript:showHideClientType(this);" runat="server" />
                                                                    <asp:RadioButton ID="rdoRLab" TabIndex="35" type="radio" Text="Lab" value="3" GroupName="RefOrgType1"
                                                                        onclick="javascript:showHideClientType(this);" runat="server" />
                                                                    <%--<input id="rdOthers" tabindex="24" type="radio" name="clientType" value="3" onclick="javascript:showHideClientType(this);"
                                                                    runat="server" /><label id="lblOthers" runat="server">Others</label>--%>
                                                                </asp:Panel>
                                                            </td>
                                                            <td style="width: 40%;" align="left">
                                                                <div id="CTHospital" runat="server">
                                                                    <asp:DropDownList ID="ddlHospital" ToolTip="Select Refering Hospital" runat="server"
                                                                        TabIndex="36" onchange="javascript:SHHospitalAddress();collapseDropDownList(this);"
                                                                        Width="250px" OnSelectedIndexChanged="ddlHospital_SelectedIndexChanged" normalWidth="250px"
                                                                        onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);"
                                                                        AutoPostBack="false">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </div>
                                                                <div id="CTBranch" runat="server" style="display: none;">
                                                                    <asp:DropDownList ID="ddlClinic" ToolTip="Select Refering Branch" runat="server"
                                                                        TabIndex="37" onchange="javascript:SHHospitalAddress();" AutoPostBack="true"
                                                                        OnSelectedIndexChanged="ddlClinic_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </div>
                                                                <div id="CTLab" runat="server" style="display: none;">
                                                                    <asp:DropDownList ID="ddlLab" ToolTip="Select Refering Lab" runat="server" TabIndex="38"
                                                                        onchange="javascript:SHHospitalAddress();" AutoPostBack="true" OnSelectedIndexChanged="ddlLab_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </td>
                                                            <td style="font-weight: normal; height: 20px; color: #000; width: 45%;" align="center">
                                                                <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:LinkButton ForeColor="Red" runat="server" ToolTip="Click Here to add new Referring Clinic"
                                                                            ID="lnkNewClinic" Text="Add New Ref.Organization" OnClick="lnkNewClinic_Click"></asp:LinkButton>
                                                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
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
                                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td align="right" style="width: 18%;">
                                                                    <asp:Label ID="Rs_Address" Text="Address" runat="server"></asp:Label>
                                                                </td>
                                                                <td style="width: 82%;">
                                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                        <ContentTemplate>
                                                                            <asp:TextBox ID="txtHospitalAddress" ToolTip="Refering Hospital Address" runat="server"
                                                                                TextMode="MultiLine" Rows="4" ReadOnly Columns="50"></asp:TextBox>
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
                            <tr id="payerTR" runat="server">
                                <td id="payerTD" runat="server">
                                    <asp:Panel ID="Panel8" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="padding: 3px;">
                                                    <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td style="width: 10%; display: none;" align="right" id="payerTitleTD" runat="server">
                                                                <asp:Label ID="Rs_PayerType" Text="Payer Type" runat="server"></asp:Label>
                                                            </td>
                                                            <td style="width: 15%;">
                                                                <div id="payerDiv" runat="server" style="display: none;">
                                                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                                        <ContentTemplate>
                                                                            <asp:DropDownList ID="ddlPayerType" onchange="javascript:ChangeSPP();" ToolTip="Select Payer"
                                                                                AutoPostBack="true" OnSelectedIndexChanged="ddlPayerType_SelectedIndexChanged"
                                                                                TabIndex="39" runat="server">
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
                                                            <td style="width: 10%;" align="right">
                                                                <div id="divBillGuarantor" style="display: none;" runat="server">
                                                                    <asp:Label ID="Rs_BillGuarantor" Text="Bill Guarantor" runat="server"></asp:Label></div>
                                                            </td>
                                                            <td id="tdddlBillGuarantor" style="width: 40%;" nowrap="nowrap">
                                                                <div id="divddlBillGuarantor" style="display: none;" runat="server">
                                                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                                        <ContentTemplate>
                                                                            <div id="divMore3" style="display: block;" title="Client And Insurance / TPA">
                                                                                <%--<uc9:ClientTpa IsQuickBill="Y" ID="uctlClientTpa" runat="server" />--%>
                                                                                <table id="tbTable" class="defaultfontcolor" runat="server" cellspacing="0" border="0"
                                                                                    width="100%">
                                                                                    <tr>
                                                                                        <td class="style1">
                                                                                            <asp:RadioButton ID="rdoTpa" runat="server" Text="Insurance/TPA" GroupName="clientTpa"
                                                                                                onclick="javascript:showTPA(this.id);" Checked="true" />
                                                                                            <asp:RadioButton ID="rdoClient" runat="server" Text="Client" GroupName="clientTpa"
                                                                                                onclick="javascript:showclient(this.id);" />&nbsp;
                                                                                            <%--<asp:RadioButton ID="rdoNone" runat="server" Text="None" GroupName="clientTpa" onclick="javascript:showNone(this.id);" />--%>
                                                                                        </td>
                                                                                        <td>
                                                                                            <table id="tdTPA" runat="server" style="display: block;">
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                                                                                            <ContentTemplate>
                                                                                                                <asp:DropDownList ID="ddlTPAnew" runat="server" OnSelectedIndexChanged="ddlTPA_SelectedIndexChanged"
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
                                                                                                                <asp:DropDownList ID="ddlClientnew" runat="server" OnSelectedIndexChanged="ddlClient_SelectedIndexChanged"
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
                                                            <td style="width: 10%;">
                                                                <input id="rdClient" type="radio" name="price" tabindex="40" runat="server" checked
                                                                    value="1" /><label id="lblClient" runat="server">Price Structure</label>
                                                                <%--  onclick="javascript:showHideClientPackage(this);"--%>
                                                                <input id="rdPackage" tabindex="41" type="radio" name="price" value="2" onclick="javascript:showHideClientPackage(this);"
                                                                    runat="server" /><label id="lblPackage" runat="server">Insurance</label>
                                                            </td>
                                                            <td style="width: 15%;">
                                                                <div id="divClient" runat="server">
                                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                                                    <ContentTemplate>
                                                                                        <%--<asp:DropDownList ID="ddlClients" ToolTip="Select Client" OnChange="javascript:setClientPackage(this);"
                                                                                            TabIndex="30" runat="server">
                                                                                        </asp:DropDownList>--%>
                                                                                        <asp:DropDownList ID="ddlRateType" ToolTip="Select Price Structure" TabIndex="42"
                                                                                            runat="server">
                                                                                        </asp:DropDownList>
                                                                                    </ContentTemplate>
                                                                                    <Triggers>
                                                                                        <asp:AsyncPostBackTrigger ControlID="ddlPayerType" EventName="SelectedIndexChanged" />
                                                                                        <asp:AsyncPostBackTrigger ControlID="ddlTPAnew" EventName="SelectedIndexChanged" />
                                                                                        <asp:AsyncPostBackTrigger ControlID="ddlClientnew" EventName="SelectedIndexChanged" />
                                                                                    </Triggers>
                                                                                </asp:UpdatePanel>
                                                                            </td>
                                                                            <td>
                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
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
                            <%--  <tr>
                                <td>
                                    <asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor">
                                        <table border="1" cellpadding="0" cellspacing="0" width="70%" class="defaultfontcolor">
                                            <tr>
                                                <td class="colorforcontent" style="width: 30%;" height="23" align="left">
                                                    <div id="ACX2plus1" style="display: block;">
                                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                                            &nbsp;<asp:Label ID="Rs_FilterResult1" runat="server" Text="Client And Insurance / TPA"></asp:Label></span>
                                                    </div>
                                                    <div id="ACX2minus1" style="display: none;">
                                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                                            &nbsp<asp:Label ID="Rs_FilterResult2" runat="server" Text="Client And Insurance / TPA"></asp:Label></span>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr class="tablerow" id="ACX2responses1" style="display: block;">
                                                <td colspan="4">
                                                   
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>--%>
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
                                                                    <asp:DropDownList ID="ddlPkg" ToolTip="Select Insurance" Width="250px" TabIndex="43"
                                                                        runat="server">
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </td>
                                                            <td style="width: 20%;">
                                                                <div id="divCollectionCentre" style="display: none" runat="server">
                                                                    <asp:DropDownList ID="ddlCollectionCentre" ToolTip="Select Collection Centre" TabIndex="44"
                                                                        runat="server">
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
                                                                    TabIndex="45" runat="server">
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
                                                                        runat="server" MaxLength="60" TabIndex="46"></asp:TextBox>
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
                                                                    <uc8:AddressControl ID="shippingAddress" runat="server" StartIndex="35" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-bottom: 2px;">
                                                        <span style="font: bold italic 16px serif;">
                                                            <asp:Label ID="Rs_didyouhearaboutthis" Text="did you hear about this?" runat="server"></asp:Label></span>
                                                        <asp:GridView ID="gvKOS" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvKOS_RowDataBound"
                                                            Width="50%">
                                                            <Columns>
                                                                <asp:TemplateField ItemStyle-Width="5%">
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chk" runat="server" />
                                                                        <asp:Label ID="lblKOSID" runat="server" Text='<%#Bind("KnowledgeOfServiceID") %>'
                                                                            Visible="false"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="1%"></ItemStyle>
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
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="btnFinish" ToolTip="Click here to Save & Continue" Style="cursor: pointer;"
                                        runat="server" OnClientClick="return LabPatientRegValidation(this.id);" OnClick="btnFinish_Click"
                                        Text="Next" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        TabIndex="47" />
                                    <asp:Button ID="btnCancel" runat="server" ToolTip="Click here to Cancel" Style="cursor: pointer;"
                                        Text="Cancel" OnClick="btnCancel_Click" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        TabIndex="48" onmouseout="this.className='btn'" />
                                </td>
                            </tr>
                        </table>
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
                                                                                    <asp:Label ID="lblHeader" runat="server" CssClass="reflabel">
                                                                                        <asp:Label ID="Rs_ReferingHospitals" Text="Refering Hospitals" runat="server"></asp:Label>
                                                                                    </asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        <table id="tblOrederedInves" runat="server" class="dataheaderInvCtrl" cellpadding="1"
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
                                                                        <asp:DropDownList ID="ddSalutation1" TabIndex="49" ToolTip="Select Salutation" runat="server"
                                                                            Width="80px">
                                                                        </asp:DropDownList>
                                                                        <asp:TextBox ID="txtDrName1" TabIndex="50" ToolTip="Refering Physician(Doctor) Name"
                                                                            onchange="GetOrgName()" runat="server" Width="168px" MaxLength="60"></asp:TextBox>
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
                                                                        <asp:TextBox ID="txtDrQualification1" TabIndex="51" ToolTip="Refering Physician(Doctor) Qualification"
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
                                                                        <asp:TextBox ID="txtDrOrganization1" TabIndex="52" Width="250px" ToolTip="Refering Physician(Doctor) Organization"
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
                                                                        <asp:DropDownList ID="DropDownList2" TabIndex="53" runat="server" ToolTip="Select Sex">
                                                                            <%--<asp:ListItem Value="0">--Select--</asp:ListItem>
                                                                            <asp:ListItem Value="M">Male</asp:ListItem>
                                                                            <asp:ListItem Value="F">Female</asp:ListItem>
                                                                            <asp:ListItem Value="NotKnown">NotKnown</asp:ListItem>--%>
                                                                        </asp:DropDownList>
                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Label ID="Rs_Filter" Text="Filter" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <input type="text" tabindex="54" onkeyup="MyUtil.selectFilter('chklstHsptl', this.value)"
                                                                            id="txtBX" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 25%;" align="right">
                                                                        <asp:Label ID="Rs_ReferalHospitalName" Text="Referral Hospital Name" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 50%;">
                                                                        <asp:ListBox ID="chklstHsptl" TabIndex="55" runat="server" ToolTip="Double Click the List or Press Enter to Select Group"
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
                                                                        <asp:CheckBox ID="chkUserLogin" TabIndex="56" runat="server" Checked="false" Text="Create User Login" />
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
                                                                                        <asp:TextBox ID="txtUserName" TabIndex="57" Width="135px" runat="server"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right">
                                                                                        <asp:Label ID="Rs_Password" Text="Password" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox TextMode="Password" TabIndex="58" Width="135px" ID="txtPassword" runat="server"></asp:TextBox>
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
                                                                                                <asp:Label ID="Rs_HospitalClinicName" Text="Referring Organization Name" runat="server"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width: 50%;">
                                                                                                <asp:TextBox ID="txtNewClinicName" ToolTip="Refering Hospital Name" runat="server"
                                                                                                    MaxLength="60" TabIndex="59"></asp:TextBox>
                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                            </td>
                                                                                            <td align="left" style="width: 32%;">
                                                                                                <asp:Panel ID="pnRefOrgType" Width="70%" GroupingText="Type" runat="server">
                                                                                                    <%--<input id="rdoHospital" type="radio" name="clientTypes" value="1" runat="server" />
                                                                                                    <input id="rdoClinic" type="radio" name="clientTypes" value="2" runat="server" />
                                                                                                    <input id="rdoLab" type="radio" name="clientTypes" value="3" runat="server" />--%>
                                                                                                    <asp:RadioButton ID="rdoRHospital" Text="Hospital" Checked="true" onClick="javascript:SetType(this.id);"
                                                                                                        GroupName="RefOrgType" runat="server" TabIndex="60" />
                                                                                                    <asp:RadioButton ID="rdoClinic" Text="Clinic" onClick="javascript:SetType(this.id);"
                                                                                                        GroupName="RefOrgType" runat="server" TabIndex="61" />
                                                                                                    <asp:RadioButton ID="rdoLab" Text="Lab" onClick="javascript:SetType(this.id);" GroupName="RefOrgType"
                                                                                                        runat="server" TabIndex="62" />
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
                                                                                                                MaxLength="60" TabIndex="63"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td class="style2">
                                                                                                            &nbsp;
                                                                                                        </td>
                                                                                                        <td style="width: 19%" align="right">
                                                                                                            <asp:Label ID="Rs_Address2" Text="Address 2" runat="server"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtAddress2" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                                                                                                MaxLength="60" TabIndex="64"></asp:TextBox>
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
                                                                                                                MaxLength="60" TabIndex="65"></asp:TextBox>
                                                                                                        </td>
                                                                                                        <td class="style2">
                                                                                                            &nbsp;
                                                                                                        </td>
                                                                                                        <td align="right">
                                                                                                            <asp:Label ID="Rs_City" Text="City" runat="server"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtCity" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                                                                                                MaxLength="25" TabIndex="66"></asp:TextBox>
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
                                                                                                            <asp:DropDownList ID="ddCountry" runat="server" TabIndex="67" AutoPostBack="True"
                                                                                                                OnSelectedIndexChanged="ddCountry_SelectedIndexChanged">
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
                                                                                                                    <asp:DropDownList ID="ddState" runat="server" TabIndex="68">
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
                                                                                                            <asp:TextBox ID="txtPostalCode" TabIndex="69" runat="server" MaxLength="6"></asp:TextBox>
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
                                                                                                            <asp:TextBox ID="txtLandLine" TabIndex="70" runat="server" MaxLength="12"></asp:TextBox>
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
                                                                                                            <asp:TextBox ID="txtRefOrgMobile" TabIndex="71" runat="server" MaxLength="11"></asp:TextBox>
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
                                                                                                            <asp:TextBox ID="txtAltLandLine" TabIndex="72" runat="server" MaxLength="12"></asp:TextBox>
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
                                                                                                            <asp:TextBox ID="txtFax" TabIndex="73" runat="server" MaxLength="12"></asp:TextBox>
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
                                                                    Style="cursor: pointer;" runat="server" OnClientClick="return validateLabRefOrgDetails();" OnClick="btnClinicSave_Click" Text="Save"
                                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                    TabIndex="74" />
                                                                <asp:Button ID="btnDelete" Visible="false" runat="server" OnClick="btnDelete_Click"
                                                                    Text="Remove" TabIndex="75" Style="cursor: pointer;" ToolTip="Click here to Remove Refering Hospital Details"
                                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                                                                <asp:Button ID="btnClinicCancel" TabIndex="76" runat="server" Text="Close" ToolTip="Click here to Cancel, View the Home Page"
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
        <asp:HiddenField ID ="hdnMessages" runat ="server" />
        <input type="hidden" id="hdKOS" value="E" runat="server" />
        <input type="text" style="display: none" id="hdnPhysicianID" runat="server" />
        <input type="text" style="display: none" id="hdnID" runat="server" />
    </div>

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

            var vAlready = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_51') == null ? "Already Exists." : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_51');
            if (arg.length != 0)
             {
                //  alert(document.getElementById('txtDrName').value + " Already Exists.");
                ValidationWindow(document.getElementById('txtDrName').value + vAlready, AlertType);
                return false;
            }
        }
        function OnTimeOut(arg) {

            var vTimeOut = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_43') == null ? "Timeout has occured" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_43');
            var vError = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_44') == null ? "Error has occured:" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_44');
            
         userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_28');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  //alert('Timeout has occured');
                  ValidationWindow(vTimeOut, AlertType);
            return false ;
            }
        }

        function OnWSRequestFailed(arg) {
         userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_29');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  //alert('Error has occured: ');
                  ValidationWindow(vError, AlertType);
            
            return false ;
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

            var vPhysicianName = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_45') == null ? "Provide physician name" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_45');

            var vSalitation = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_46') == null ? "Select salutation" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_46');
            var vWardNo = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_47') == null ? "Please Enter The WardNo" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_47');

            
            if (document.getElementById('txtDrName1').value.trim() == '') {
             userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_30');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                 // alert('Provide physician name');
                  ValidationWindow(vPhysicianName, AlertType);
                             return false;
                
                }
                document.getElementById('txtDrName1').focus();
                return false;
            }
            if (document.getElementById('ddSalutation1').value == '0') {
             userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_31');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  // alert('Select salutation');
                  ValidationWindow(vSalitation, AlertType);
                             return false;
                
                }
                document.getElementById('ddSalutation1').focus();
                return false;

                if (document.getElementById('ddlPatientCategory').value == '1') {
                    if (document.getElementById('txtward').value == 'null') {
                     userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_32');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  //alert('Please Enter The WardNo');
                  ValidationWindow(vWardNo, AlertType);
                        return false ;
                        }
                        document.getElementById('txtward').focus();
                    }
                }
            }
        }

        function checkSearchName() {

            var vfindPhysicicna = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_48') == null ? "Provide the search text to find the physician" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_48');
            
                if (document.getElementById('txtSearchPhysicianName').value.trim() == '') {
                 userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_33');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  //alert('Provide the search text to find the physician');
                  ValidationWindow(vfindPhysicicna, AlertType);
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
                var vHospitalAlreadyAdd = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_36') == null ? "Hospital already added" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_36');
               


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
                    document.getElementById('<%= lblHeader.ClientID %>').style.display = "block";
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
                    document.getElementById('<%= iconHid.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "|";
                    //rate = obj.options[obj.selectedIndex].text.split(':');
                    //total = parseFloat(rate[1]);
                    //alert('total:' + parseFloat(total).toFixed(2));

                    AddStatus = 2;
                    //document.getElementById('tblTot').style.display = "block";

                }
                if (AddStatus == 0) {
                    document.getElementById('<%= lblHeader.ClientID %>').style.display = 'block';
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
                    document.getElementById('<%= iconHid.ClientID %>').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "|";
                    //rate = obj.options[obj.selectedIndex].text.split(':');
                    //alert('rae:' + rate[1]);
                    //total = parseFloat(total) + parseFloat(rate[1]);

                }
                else if (AddStatus == 1) {
                 userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_34');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  //alert('Hospital already added');
                  ValidationWindow(vHospitalAlreadyAdd, AlertType);
                             return false;
                    
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
                var vRefOrgName = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_38') == null ? "Please Enter The Referring Organization Name" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_38');
                var vProviderAdd = SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_39') == null ? "You must provide one address" : SListForAppMsg.Get('Reception_LabPatientRegistration_aspx_39');
                
                Clearmsg();
                if (document.getElementById('txtNewClinicName').value == '') {
                 userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_41');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  //alert('Please Enter The Referring Organization Name');
                  ValidationWindow(vRefOrgName, AlertType);
                             return false;
                    
                    }
                    document.getElementById('txtNewClinicName').focus();
                    return false;
                } 
                if (document.getElementById('txtAddress1').value == '' && document.getElementById('txtAddress2').value == '' && document.getElementById('txtAddress3').value == '') {
                 userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_36');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                 // alert('You must provide one address');
                  ValidationWindow(vProviderAdd, AlertType);
                             return false;
                    
                    }
                    document.getElementById('txtAddress1').focus();
                    return false;
                }
                if (document.getElementById('txtCity').value == '') {
                 userMsg = SListForApplicationMessages.Get('Reception\\LabPatientRegistration.aspx_9');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                  //alert('Provide city');
                  ValidationWindow(vCity, AlertType);
                             return false;
                    
                    }
                    document.getElementById('txtCity').focus();
                    return false;
                }
            }

        
    </script>

    <script language="javascript" type="text/javascript">

        document.getElementById('<%= hidID.ClientID %>').value = document.getElementById('<%=chklstHsptl.ClientID %>').id;
    </script>

    </form>
</body>
</html>
