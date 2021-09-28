<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RatesUpdation.aspx.cs" Inherits="Admin_RatesUpdation"
    meta:resourcekey="PageResource1" ViewStateEncryptionMode="Never" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Rate Update</title>
    <link href="../StyleSheets/chosen.css" rel="stylesheet" type="text/css" />
 <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>
    
    <style>
        .bg-searchimage
        {
            background: url("../Images/magnifying-glass.png") no-repeat scroll right top;
        }
        .finalcopylist
        {
               overflow: auto;
                border: 2px;
                border-color: #fff;
                height: 150px;
                width: 150px;
                margin: 30px 0;
        }
        .finalfilename td
        {
            padding: 10px 0 0;
        }
        #divFiles div
        {
            padding: 5px 20px 0 3px;
        }
        .ui-autocomplete.ui-front
        {
            width: 160px !important;
            min-height: 20px;
            max-height: 200px;
            overflow: auto;
        }
        #ddlSubMore option
        {
            width: 200px !important;
        }
        .textwrap
        {
            text-overflow: ellipsis;
            word-break: break-all;
            word-wrap: break-word;
        }
    </style>
</head>
<body>

    <script type="text/javascript" language="javascript">
        function change() {
            $get("<%=txtCopyToRate.ClientID %>").value = '';

        }
        function checkexlfileornot() {
            var objVar01 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_01") == null ? "Please select a xlsx or xls file for upload" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_01");
            var objVar02 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_02") == null ? "Please Upload a file" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_02");
            var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");

            var fileElement = document.getElementById('xlsUpload');
            var fileExtension = "";
            if (fileElement.value.lastIndexOf(".") > 0) {
                fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
            }
            if (fileElement.value != '') {

                if (fileExtension == "xlsx" || fileExtension == "xls") {
                    return true;
                }
                else {
                   // alert('Please select a xlsx or xls file for upload');
                    ValidationWindow(objVar01, objAlert);

                    return false;
                }
            }
            else {
                //alert('Please Upload a file');
                ValidationWindow(objVar02, objAlert);

                return false;
            }
        }
        function ClearFields() {

            document.getElementById('xlsUpload').value = '';

        }
        function isNumerc(e, Id) {
            var key; var isCtrl;
            if (window.event) {
                key = window.event.keyCode;
                if (window.event.shiftKey) {
                    isCtrl = false;
                }
                else {
                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190)) {
                        isCtrl = true;
                    }
                    else {
                        //if ((key >= 185 && key <= 192) || (key >= 218 && key <= 222))
                        isCtrl = false;
                    }
                }
            } return isCtrl;
        }
        function ShowAlertMsg(key) {
            var objVar03 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_03") == null ? "Rates are Copied" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_03");
            var objVar04 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_04") == null ? "Changes saved sucessfully" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_04");
            var objVar05 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_05") == null ? "Enter Appropriate values, Format(999999.99)" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_05");
            var objVar06 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_06") == null ? "Un-Mapped Successfully" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_06");
            var objVar07 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_07") == null ? "Error on Removing Rates" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_07");
            var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");

            var userMsg = SListForAppMsg.Get(key);
            if (userMsg != null) {
                //alert(userMsg);
                ValidationWindow(userMsg, objAlert);
            }
            else if (key == "Admin\\RatesUpdation.aspx.cs_9") {
            // alert('Rates are Copied');
            ValidationWindow(objVar03, objAlert);

            }

            else if (key == "Admin\\RatesUpdation.aspx.cs_13") {
            //alert('Changes saved sucessfully');
            ValidationWindow(objVar04, objAlert);

            }
            else if (key == "Admin\\RatesUpdation.aspx.cs_11") {
            // alert('Enter Appropriate values, Format(999999.99)');
            ValidationWindow(objVar05, objAlert);

            }
            else if (key == "AdminRatesUpdation.aspx.cs_10") {
            // alert('Un-Mapped Successfully');
            ValidationWindow(objVar06, objAlert);

            }
            else if (key == "AdminRatesUpdation.aspx.cs_14") {
            // alert('Error on Removing Rates');
            ValidationWindow(objVar07, objAlert);

            }
            return false;
        }
        function IAmSelected(source, eventArgs) {
            var varGetText = eventArgs.get_text();
            var varGetIndex = varGetText.indexOf('(');
            if (varGetIndex != '-1') {
                $('#txtsearch').val(varGetText);
            }
        }

        function ddlrtValidation() {
            var objVar08 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_08") == null ? "Select fee type" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_08");
            var objVar09 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_09") == null ? "Select Organisation" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_09");
            var objVar10 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_10") == null ? "Select rate type" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_10");
            var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");

            if (document.getElementById("ddlFeeType").value == "0") {

                var userMsg = SListForApplicationMessages.Get('Admin\\RatesUpdation.aspx_1');
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);

                }
                else {
                    // alert('Select fee type');
                    ValidationWindow(objVar08, objAlert);

                }
                //document.getElementById("ddlFeeType").focus();
                return false;
            }
            if (document.getElementById("drpTrustedOrg").value == "0") {
                var userMsg = SListForApplicationMessages.Get("Admin\\RatesUpdation.aspx_28");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);

                    return false;
                }
                else {
                    // alert('Select Organisation');
                    ValidationWindow(objVar09, objAlert);

                    return false;
                }


                document.getElementById("drpTrustedOrg").focus();
                return false;
            }
            if (document.getElementById("txtRateCard").value == "") {
                var userMsg = SListForApplicationMessages.Get('Admin\\RatesUpdation.aspx_7');
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);

                }
                else {
                    //  alert('Select rate type');
                    ValidationWindow(objVar10, objAlert);

                }
                // document.getElementById("ddlRateCard").focus();
                return false;

            }
        }
        
        function ddlrtValidation() {
            var objVar11 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_11") == null ? "Select fee type" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_11");
            var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");
            var objVar09 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_09") == null ? "Select Organisation" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_09");
            var objVar15 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_15") == null ? "Select the rate card" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_15");

            if (document.getElementById('<%= ddlFeeType.ClientID %>').value == "0") {

                var userMsg = SListForApplicationMessages.Get('Admin\\RatesUpdation.aspx_1');
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                }
                else {
                    //alert('Select fee type');
                    ValidationWindow(objVar11, objAlert);

                }
                document.getElementById('<%= ddlFeeType.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%= drpTrustedOrg.ClientID %>').value == "0") {

                var userMsg = SListForApplicationMessages.Get("Admin\\RatesUpdation.aspx_28");
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    //alert('Select Organisation');
                    ValidationWindow(objVar09, objAlert);
                    return false;
                }
                document.getElementById('<%= drpTrustedOrg.ClientID %>').focus();
                return false;
            }
            if ((document.getElementById('<%= ddlFeeType.ClientID %>').value != "MEDICAL_INDENTS_RATES") || (document.getElementById('<%= ddlFeeType.ClientID %>').value != "GENERAL_BILLING_ITEMS") || (document.getElementById('<%= ddlFeeType.ClientID %>').value != "SOI_PROCEDURE")) {
            if (document.getElementById('<%= txtRateCard.ClientID %>').value == "") {      
                    var userMsg = SListForApplicationMessages.Get('Admin\\RatesUpdation.aspx_6');
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, objAlert);
                    }
                    else {
                        // alert('Select rate type');
                        ValidationWindow(objVar15, objAlert);
                    }
                    return false;
                }
            }
        }
        function chkPros() {
            if (document.getElementById('ddlFeeType').value == 'PHYSICIAN_FEE') {
                document.getElementById('hdnFeeType').value = 'CON';
            }
            else if (document.getElementById('ddlFeeType').value == 'INVESTIGATION_GROUP_FEE') {
                document.getElementById('hdnFeeType').value = 'GRP';
            }
            else if (document.getElementById('ddlFeeType').value == 'INVESTIGATION_FEE') {
                document.getElementById('hdnFeeType').value = 'INV';
            }
            else if (document.getElementById('ddlFeeType').value == 'HEALTH_PACKAGE') {
                document.getElementById('hdnFeeType').value = 'PKG';
            }
            else if (document.getElementById('ddlFeeType').value == 'PROCEDURE_FEE') {
                document.getElementById('hdnFeeType').value = 'PRO';
            }
            else if (document.getElementById('ddlFeeType').value == 'MEDICAL_INDENTS_RATES') {
                document.getElementById('hdnFeeType').value = 'IND';
            }
            else if (document.getElementById('ddlFeeType').value == 'GENERAL_BILLING_ITEMS') {
                // document.getElementById('hdnFeeType').value = 'GBI';
                document.getElementById('hdnFeeType').value = 'GEN';
            }

            else if (document.getElementById('ddlFeeType').value == 'SOI_PROCEDURE') {
                document.getElementById('hdnFeeType').value = 'SOI';
            }

            //-------------Babu 26-12-2012-----------------
            else if (document.getElementById('ddlFeeType').value == 'SPECIALITY') {
                document.getElementById('hdnFeeType').value = 'SPE';
            }

            //------------------------EN-----------------------------

            if (document.getElementById('ddlFeeType').value != '0') {
                var orgID = '<%= OrgID %>';
                var sval = document.getElementById('<%= hdnFeeType.ClientID %>').value;
                var sRateID = document.getElementById('hdnRateID').value.split('~');
                var RateID = sRateID[1];
                var pvalue = 'OP';
                var pVisitID = -1;
                var IsMapped;
                var BillPage;
                BillPage = "MGRATES";
                if (document.getElementById('ddlMappingItems').value == 0) IsMapped = null;
                else if (document.getElementById('ddlMappingItems').value == 1) IsMapped = 'Y';
                else if (document.getElementById('ddlMappingItems').value == 2) IsMapped = 'N';
                else if (document.getElementById('ddlMappingItems').value == 3) IsMapped = null;
                else if (document.getElementById('ddlMappingItems').value == 4) IsMapped = 'Y';
                else if (document.getElementById('ddlMappingItems').value == 5) IsMapped = 'N';

                sval = sval + '~' + orgID + '~' + RateID + '~' + pvalue + '~' + pVisitID + '~' + IsMapped + '~' + BillPage;
                $find('AutoCompleteExtender3').set_contextKey(sval);
            }
        }

        function ddlValuesCheck() {
            document.getElementById('<%= optionsTab.ClientID %>').style.display = 'block';
            document.getElementById('<%= hdn.ClientID %>').value = "";

            if (document.getElementById('ddlFeeType').value == 'PHYSICIAN_FEE') {
                document.getElementById('hdnFeeType').value = 'CON';
                Hide();

            }
            else if (document.getElementById('ddlFeeType').value == 'INVESTIGATION_GROUP_FEE') {
                document.getElementById('hdnFeeType').value = 'GRP';
                Show();
            }
            else if (document.getElementById('ddlFeeType').value == 'INVESTIGATION_FEE') {
                document.getElementById('hdnFeeType').value = 'INV';
                Show();
            }
            else if (document.getElementById('ddlFeeType').value == 'PROCEDURE_FEE') {
                document.getElementById('hdnFeeType').value = 'PRO';
                Hide();
            }
            else if (document.getElementById('ddlFeeType').value == 'MEDICAL_INDENTS_RATES') {
                document.getElementById('hdnFeeType').value = 'IND';
                Hide();
            }
            else if (document.getElementById('ddlFeeType').value == 'GENERAL_BILLING_ITEMS') {
                //document.getElementById('hdnFeeType').value = 'GBI';
                document.getElementById('hdnFeeType').value = 'GEN';
                Hide();
            }

            else if (document.getElementById('ddlFeeType').value == 'SOI_PROCEDURE') {
                document.getElementById('hdnFeeType').value = 'SOI';
                Hide();
            }

            //-------------Babu 26-12-2012-----------------
            else if (document.getElementById('ddlFeeType').value == 'SPECIALITY') {
                document.getElementById('hdnFeeType').value = 'SPE';
                Hide();
            }
            else if (document.getElementById('ddlFeeType').value == 'HEALTH_PACKAGE') {
                document.getElementById('hdnFeeType').value = 'PKG';
                Show();
            }

            //------------------------EN-----------------------------

            else {
                document.getElementById('hdnFeeType').value = 'PKG';
                Hide();
            }


        }

        function Retevalidate() {
            var objVar13 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_13") == null ? "Select an item to save the changes" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_13");
            var objVar12 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_12") == null ? "Kindly provide  Reason" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_12");
            var objVar14 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_14") == null ? "Some of the Entered Amount(s) are Lesser Than CPRT Rate." : SListForAppMsg.Get("Admin_RatesUpdation_aspx_14");
            var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");

            if (document.getElementById('ddlReason').value == "0") {
                // alert('Kindly provide  Reason');
                ValidationWindow(objVar12, objAlert);

                var hdn = document.getElementById('<%=hdnSelect.ClientID%>');
                document.getElementById('<%=hdnSelect.ClientID%>').value = "";
                return false;
            }
            var hdnvalidate = document.getElementById('hdn').value;
            var hddd = document.getElementById('<%=hdnRateComparePass.ClientID %>').value;
            var i = 0;
            if (hdnvalidate != null) {
                var list = hdnvalidate.split('~');
                for (var j = 0; j < list.length - 1; j++) {
                    if (document.getElementById(list[j]) != null && document.getElementById(list[j]).checked == true) {
                        i = 1;
                    }
                }
            }
            else {
                var userMsg = SListForApplicationMessages.Get('Admin\\RatesUpdation.aspx_8');
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);

                }
                else {
                    //alert('Select an item to save the changes');
                    ValidationWindow(objVar13, objAlert);

                }
                return false;
            }
            if (document.getElementById('ddlReason').value == "0") {
                // alert('Kindly provide  Reason');
                ValidationWindow(objVar12, objAlert);

                return false;
            }
            var checkBoxSelector = '#<%=gvRatesMaster.ClientID%> input[id*="chkBox"]:checkbox';
            var totalCkboxes = $(checkBoxSelector),
            checkedCheckboxes = totalCkboxes.filter(":checked")
            if (checkedCheckboxes.length === 0) {
                var userMsg = SListForApplicationMessages.Get('Admin\\RatesUpdation.aspx_8');
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                }
                else {
                   // alert('Select an item to save the changes');
                    ValidationWindow(objVar13, objAlert);
                }
                return false;
            }
            if (hddd == "Fail") {
                var r = confirm(objVar14);
                if (r == true) {
                    return true;
                }
                else {
                    return false;
                }
            }
            return true;
        }

        function loadValue(DDLControls) {
            document.getElementById('hdnRateID').value = document.getElementById(DDLControls).value;
            document.getElementById('hdnRateName').value = document.getElementById(DDLControls).options[document.getElementById(DDLControls).selectedIndex].text;
            document.getElementById('hdnRateNames').value = document.getElementById(DDLControls).value;
        }
        function ChkRateSelect() {
            var objVar15 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_15") == null ? "Select the rate card" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_15");
            var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");

            if (document.getElementById('hdnRateID').value == "0") {
                var userMsg = SListForApplicationMessages.Get("Admin\\RatesUpdation.aspx_29");
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);

                    return false;
                }
                else {
                    // alert('Select the rate card');
                    ValidationWindow(objVar15, objAlert);

                    return false;
                }
                return;
            }
        }
        function setAllValues() {
            document.getElementById("drpVendorType").value = document.getElementById('hdnVendorTypeID').value;
            document.getElementById("ddlSubtype").value = document.getElementById('hdnSubRatetype').value;
        }


        function funFeetypeSerive(source, eventArgs) {
            var txtType = eventArgs.get_text();
            var txttxt = eventArgs.get_value();
            document.getElementById('<%= txtFeetypeSerive.ClientID %>').value = txtType;
            document.getElementById('<%= hdnFeeTypeServiceID.ClientID %>').value = txttxt;
        }    
        
    </script>

    

    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" ScriptMode="Release" runat="server">
    </asp:ScriptManager>
    <script type="text/javascript">
      $(function () {
            initializer();
        });
        var prmInstance = Sys.WebForms.PageRequestManager.getInstance();
        prmInstance.add_endRequest(function () {
            //you need to re-bind your jquery events here
            initializer();
        });
         function initializer() {
     $("#txtRateCard").autocomplete({
           

                source: function(request, response) {
                    if ($('#ddlSubtype').val() != 0) {
                        var vdatas = {};
                        vdatas.InputList = JSON.parse(lstDetails);
                        vdatas.Type = $("#drpVendorType option:selected").text();
                        vdatas.SubType = subType;
                        vdatas.txtName = $('#txtRateCard').val();
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "RatesUpdation.aspx/GetRateNamesAutocomplete",
                            data: JSON.stringify(vdatas),
                            dataType: "json",
                            success: function(data) {
                                var returnedData = JSON.parse(data.d);
                                if (returnedData.length > 0) {
                                    response($.map(returnedData, function(item) {
                                        return {
                                            label: item.ButtonName,
                                            val: item.ContextType
                                        }
                                    }))
                                }
                                else {
                                    //alert('No records found');
                                    ValidationWindow(objVar32, objAlert);

                                    $('#txtRateCard').val('');
                                    return false;
                                }
                            },
                            error: function(result) {
                                //alert('No Match');
                                ValidationWindow(objVar31, objAlert);

                            }
                        });
                    }
                    else {
                        //alert('Select the Rate Sub Type');
                        ValidationWindow(objVar30, objAlert);

                        $('#txtRateCard').val('');
                        return false;
                    }
                },
                select: function(e, i) {

                    $('#hdnRateID').val(i.item.val);
                    $('#hdnRateName').val(i.item.label);
                    $('#hdnRateNames').val(i.item.val);
                },
                minLength: 1
            });
    
    }
    </script>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="saveprogressbar" runat="server" style="display:none;">
            <div id="progressBackgroundFilter" class="a-center">
            </div>
            <div id="processMessage" class="a-center w-20p">
                <asp:Image ID="img2" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                    meta:resourcekey="img1Resource1" />
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel3" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                meta:resourcekey="img1Resource1" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div id="TabsMenu" class="TabsMenu ">
                    <ul id="RateTabsMenu">
                        <li id="tabManageRates" onclick="ShowTabContent('tabManageRates','tabContentManageRates')"
                            class="active"><a href="#">
                                <asp:Label ID="lbltabManageRates" runat="server" Text="Manage Rates" meta:resourcekey="lbltabManageRatesResource1" /></a></li>
                        <li id="tabAttachDocuments" onclick="ShowTabContent('tabAttachDocuments','tabContentAttachDocuments')">
                            <a href="#">
                                <asp:Label ID="lbltabAttachDocuments" runat="server" Text="Attach Documents" meta:resourcekey="lbltabAttachDocumentsResource1" /></a></li>
                    </ul>
                </div>
                <br />
                <table class="w-100p" id="tabContentManageRates">
                    <tr>
                        <td>
                            <table class="dataheader2 searchPanel w-100p">
                                <tr>
                                    <td>
                                        <table id="Table1" runat="server" class="w-100p" style="display: table;">
                                            <tr id="Tr2" runat="server">
                                                <td id="Td6" class="colorforcontent w-100p h-15 a-left" runat="server">
                                                    <div style="display: block;" id="ACX2plusRateCard">
                                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top" style="cursor: pointer"
                                                            onclick="showResponses('ACX2plusRateCard','ACX2minusRateCard','ACX2responsesRateCard',1);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusRateCard','ACX2minusRateCard','ACX2responsesRateCard',1);">
                                                            <asp:Label ID="Label9" Text="Bulk Rate Card Updates" runat="server" meta:resourcekey="Label9Resource1"></asp:Label></span>
                                                    </div>
                                                    <div style="display: none;" class="h-18" id="ACX2minusRateCard">
                                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                                                            onclick="showResponses('ACX2plusRateCard','ACX2minusRateCard','ACX2responsesRateCard',0);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusRateCard','ACX2minusRateCard','ACX2responsesRateCard',0);">
                                                            <asp:Label ID="Label10" Text="Bulk Rate Card Updates" runat="server" meta:resourcekey="Label9Resource1"></asp:Label>
                                                        </span>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="ACX2responsesRateCard" style="display: none;" class="tablerow" runat="server">
                                                <td id="Td7" runat="server">
                                                    <table class="h-80">
                                                        <tr>
                                                            <td>
                                                                <asp:LinkButton ID="lnkXls" CssClass="font14" Style="color: Blue;" runat="server"
                                                                    Text="Click here for download Rate updation template" OnClick="lnkXls_Click"
                                                                    ToolTip="Download Excel" meta:resourcekey="lnkXlsResource1"></asp:LinkButton>
                                                                <asp:ImageButton ID="ImgXls" OnClick="lnkXls_Click" runat="server" ImageUrl="~/Images/ExcelImage.GIF"
                                                                    ToolTip="Download Excel" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:FileUpload ID="fupRatecardDetails" runat="server" />
                                                                <asp:Button ID="btnUploadRatecard" runat="server" Text="Upload Rate Card" OnClick="btnUploadRatecard_Click"
                                                                    CssClass="btn" meta:resourcekey="btnUploadRatecardResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-center">
                                        <asp:Panel ID="pnlconfirmation" runat="server" CssClass="modalPopup dataheaderPopup w-30p h-80"
                                            Style="display: none; top: 400px;" meta:resourcekey="pnlPatientSearchResource1">
                                            <table>
                                                <tr>
                                                    <td class="paddingT20">
                                                        There is some errors in excel sheet, So you want to check the tests?
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="paddingT10">
                                                        <asp:Button ID="btnXls" runat="server" Text="Yes" OnClick="btnXls_Click" CssClass="btn w-70" />
                                                        <asp:Button ID="btnCancelPopup" runat="server" Text="No" CssClass="btn w-70" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                    <td>
                                        <ajc:ModalPopupExtender ID="ModelPopRatecard" runat="server" TargetControlID="btnR"
                                            BehaviorID="ModelPopRatecard" PopupControlID="pnlconfirmation" BackgroundCssClass="modalBackground"
                                            CancelControlID="btnCancelPopup" DynamicServicePath="" Enabled="True" />
                                        <input type="button" id="btnR" runat="server" style="display: none;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                     <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <table class="panelContent w-100p bg-row">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblOrganisation" Text="Organization" runat="server" meta:resourcekey="lblOrganisationResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList CssClass="ddlsmall" ID="drpTrustedOrg" runat="server" meta:resourcekey="drpTrustedOrgResource1"
                                                        onChange="fnLoadVendorType('Cli');">
                                                    </asp:DropDownList>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblRateCardType" runat="server" Text="Rate Card Type" meta:resourcekey="lblRateCardTypeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList CssClass="ddlsmall" ID="drpVendorType" runat="server" onChange="fnloadRate('Cli');">
                                                    </asp:DropDownList>
                                                     &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                </td>
                                                <td class="a-left ">
                                                    <asp:Label runat="server" class="w-100p" ID="label11" Text="Sub Type:" meta:resourcekey="label11Resource1"></asp:Label>
                                                </td>
                                                <td class="a-left " runat="server" id="Td8">
                                                    <asp:DropDownList ID="ddlSubtype" runat="server" onChange="fnloadRateSubType('Cli');"
                                                        CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                     &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblRateCard" runat="server" meta:resourcekey="lblRateCardResource1"
                                                        Text="Rate Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtRateCard" runat="server" CssClass="small bg-searchimage paddingR10"></asp:TextBox>
                                                     &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_Selectanoption" Text="Fee Type" runat="server" meta:resourcekey="Rs_SelectanoptionResource2"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList CssClass="ddlsmall" ID="ddlFeeType" runat="server" onChange="javascript:ddlValuesCheck() ;"
                                                        meta:resourcekey="ddlFeeTypeResource1">
                                                    </asp:DropDownList>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label12" Text="Apply To" runat="server" meta:resourcekey="Label12Resource1"></asp:Label>
                                                </td>
                                                <td class="a-left " runat="server" id="label15">
                                                    <asp:DropDownList ID="ddlMappingItems" runat="server" CssClass="ddlsmall">
                                                        <%--<asp:ListItem Value="0" Text="--Select--">  </asp:ListItem>
                                                        <asp:ListItem Value="1" Text="Mapped Services"></asp:ListItem>
                                                        <asp:ListItem Value="2" Text="Un-Mapped Service"></asp:ListItem>
                                                        <asp:ListItem Value="3" Text="Zero-Value services"></asp:ListItem>
                                                        <asp:ListItem Value="4" Text="Zero-Value with mapped Services"></asp:ListItem>
                                                        <asp:ListItem Value="5" Text="Zero With Un-Mapped Services"></asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="a-left ">
                                                    <asp:Label runat="server" class="w-100p" ID="lblMore" Text="More Options:" meta:resourcekey="label50Resource1"></asp:Label>
                                                </td>
                                                <td class="a-left" runat="server">
                                                    <asp:DropDownList ID="ddlMoreOption" runat="server" CssClass="ddlsmall">
                                                    <%--    <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                                                        <asp:ListItem Value="1" Text="Department"></asp:ListItem>
                                                    --%>    <%-- <asp:ListItem Value="2" Text="Analyzer"></asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="a-left" runat="server" id="label20">
                                                    <asp:DropDownList ID="ddlSubMore" runat="server" CssClass="ddlsmall">
                                                     <%--<asp:ListItem Value="0" Text="--Select--"></asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </td>
                                                <%--<td>
                                                        <asp:CheckBox ID="chkunmapitems" runat="server" Text="Include UnMapped Items" />
                                                </td>--%>
                                                <td>
                                                    <asp:Button ID="btnGo" runat="server" meta:resourcekey="btnGoResource2" OnClick="btnGo_Click"
                                                        OnClientClick="javascript:return ddlrtValidation();" onmouseout="this.className='btn'"
                                                        onmouseover="this.className='btn btnhov'" Text="Search" CssClass="btn w-60" />
                                                </td>
                                            </tr>
                                        </table>
                                        </ContentTemplate></asp:UpdatePanel>
                                        <asp:HiddenField ID="hdn" runat="server" />
                                        <asp:HiddenField ID="hdnAllRateNames" runat="server" />
                                        <asp:HiddenField ID="hdnRateID" Value="0" runat="server" />
                                        <asp:HiddenField ID="hdnRateName" runat="server" />
                                        <asp:HiddenField ID="hdniValue" runat="server" />
                                        <asp:HiddenField ID="hdnFeeType" runat="server" />
                                        <asp:HiddenField ID="hdnAmountValidate" runat="server" />
                                        <asp:HiddenField ID="hdnVendorType" runat="server" />
                                        <asp:HiddenField ID="hdnVendorTypeID" runat="server" />
                                        <asp:HiddenField ID="hdnSelectGen" runat="server" Value="N" />
                                        <asp:HiddenField ID="hdnSubTypeSpecial" runat="server" />
                                        <asp:HiddenField ID="hdnSubTypeVendor" runat="server" />
                                        <asp:HiddenField ID="hdnSubRatetype" runat="server" />
                                        <asp:HiddenField ID="hdnRateNames" runat="server" />
                                        <asp:HiddenField ID="hdnDept" runat="server" />
                                        <asp:HiddenField ID="hdnDeparment" runat="server" />
                                        <asp:HiddenField ID="hdnSubTypeNormal" runat="server" />
                                    </td>
                                </tr>
                                <tr class="panelFooter">
                                    <td>
                                        <asp:Panel ID="pnlSearch" CssClass="dataheader2" runat="server" Style="display: block;"
                                            meta:resourcekey="pnlSearchResource1">
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="font12 h-20 w-10p" style="font-weight: normal; color: #000;">
                                                        <asp:Label ID="Rs_EntertoSearch" Text="Enter to Search" runat="server" meta:resourcekey="Rs_EntertoSearchResource1"></asp:Label>
                                                    </td>
                                                    <td class="font12 h-20 w-26" style="font-weight: normal; color: #000;">
                                                        <asp:TextBox ID="txtsearch" onkeydown="chkPros();" CssClass="small" runat="server"
                                                            onkeyup="fnGetText(this)" meta:resourcekey="txtsearchResource1"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtsearch"
                                                            EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetQuickBillItems"
                                                            ServicePath="~/OPIPBilling.asmx" UseContextKey="True" DelimiterCharacters=""
                                                            OnClientItemSelected="IAmSelected" Enabled="True">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Button ID="btnSearch" Text="Search" runat="server" CssClass="btn w-62" onmouseout="this.className='btn'"
                                                            onmouseover="this.className='btn btnhov'" OnClientClick="javascript:return ddlrtValidation();"
                                                            OnClick="btnSearch_Click" meta:resourcekey="Button1Resource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table id="optionsTab" runat="server" class="w-100p" style="display: table;">
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="ChkCopyingActions" runat="server" onclick="FnChkCopyingActions(this);"
                                                        meta:resourcekey="ChkCopyingActionsResource1" />
                                                </td>
                                            </tr>
                                            <tr id="ACX2responsesMVitals" class="tablerow" runat="server">
                                                <td id="Td2" runat="server">
                                                    <table class="dataheaderInvCtrl w-100p" id="tblCopyAction" runat="server">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label3" runat="server" meta:resourcekey="Label3Resource1"></asp:Label>
                                                                <asp:DropDownList CssClass="ddlsmall" ID="ddlCopypTrustedOrg" onclick="ChkRateSelect();"
                                                                    onChange="fnLoadVendorType1();" runat="server">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblCopytype" runat="server" meta:resourcekey="lblCopytypeResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlCopyRateType" runat="server"  onChange="change();" CssClass="ddlsmall" >
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label4" runat="server" meta:resourcekey="Label4Resource1"></asp:Label>
                                                                <asp:TextBox CssClass="small bg-searchimage paddingR10" ID="txtCopyToRate" runat="server">
                                                                </asp:TextBox>
                                                                <asp:HiddenField ID="hdnFromClient" runat="server" />
                                                                &nbsp;&nbsp;&nbsp;
                                                                <asp:Label runat="server" Font-Bold="True" ID="lblToClient"></asp:Label>
                                                            </td>
                                                            <td class="a-left " runat="server" id="Td1">
                                                                <asp:DropDownList ID="ddlrateMapping" runat="server" CssClass="ddlsmall">
                                                                    <%--<asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                                                                    <asp:ListItem Value="1" Text="Mapped Services"></asp:ListItem>
                                                                    <asp:ListItem Value="2" Text="Un-Mapped Service"></asp:ListItem>
                                                                    <asp:ListItem Value="3" Text="Zero-Value services"></asp:ListItem>
                                                                    <asp:ListItem Value="4" Text="Zero-Value with mapped Services"></asp:ListItem>
                                                                    <asp:ListItem Value="5" Text="Zero With Un-Mapped Services"></asp:ListItem>--%>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList CssClass="smaller" ID="ddlAddReduce" runat="server">
                                                                    <%--<asp:ListItem Text="Add" Selected="True" Value="ADD"></asp:ListItem>
                                                                    <asp:ListItem Text="Reduce" Value="REDUCE"></asp:ListItem>--%>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox CssClass="Txtboxverysmall" ID="txtAddReduce"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                    runat="server" Text="0.00" Style="text-align: right;"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList CssClass="smaller" ID="ddlPercentageValue" runat="server">
                                                                    <%--<asp:ListItem Text="Percentage" Selected="True" Value="PER"></asp:ListItem>
                                                                    <asp:ListItem Text="Value" Value="VAL"></asp:ListItem>--%>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Button ID="btnCopyRates" Text="Copy" runat="server" CssClass="btn" OnClick="btnCopyRates_Click" meta:resourcekey="btnCopyRatesResource1"
                                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" OnClientClick="return ValidateCopyRates()" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-right">
                                        <asp:ImageButton ID="imgExportToExcel" OnClick="imgExportToExcel_Click" runat="server"
                                            ImageUrl="../Images/ExcelImage.GIF" ToolTip="Save As Excel" Visible="false" />
                                        <asp:LinkButton ID="lnkExportXL" OnClick="imgExportToExcel_Click" runat="server"
                                            Font-Bold="True" Text="Export To XL" Font-Underline="True" CssClass="font12"
                                            ForeColor="Black" ToolTip="Save As Excel" Visible="false" meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr style="display: none;">
                                    <td>
                                        <asp:UpdatePanel ID="updatePanel4" runat="server">
                                            <ContentTemplate>
                                                <table id="tblfileuploadcntrl" runat="server" style="display: none; float: right;">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lbl_ErrorMessage" runat="server" Text="Choose File" Font-Bold="true"
                                                                Style="display: none"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:FileUpload ID="xlsUpload" runat="server" Font-Size="Small" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btn" Font-Bold="true"
                                                                OnClientClick="javascript:return checkexlfileornot();" OnClick="btnUpload_Click" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" Font-Bold="true"
                                                                onmouseover="this.className='btn btnhov'" OnClientClick="javascript:return ClearFields();"
                                                                onmouseout="this.className='btn'" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap" class="contentPanel style2">
                                        <div id="divgv" runat="server">
                                            <asp:GridView ID="gvRatesMaster" CssClass="gridView w-100p m-auto" runat="server"
                                                AutoGenerateColumns="False" BorderStyle="Groove" PagerSettings-Mode="NextPrevious"
                                                OnPageIndexChanging="gvRatesMaster_PageIndexChanging" OnRowCommand="gvRatesMaster_RowCommand"
                                                OnRowDataBound="gvRatesMaster_RowDataBound" PageSize="5" meta:resourcekey="gvRatesMasterResource1"
                                                AlternatingRowStyle-CssClass="trOdd">
                                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                    PageButtonCount="5" PreviousPageText="" />
                                                <HeaderStyle CssClass="dataheader1 a-center" />
                                                <RowStyle Font-Size="10px" HorizontalAlign="Center" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource13">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Description Name" meta:resourcekey="TemplateFieldResource14">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDescriptionName" runat="server" Text='<%# Eval("DescriptionName") %>'
                                                                meta:resourcekey="lblDescriptionNameResource1"></asp:Label>
                                                            <asp:HiddenField ID="hdnSpecId" runat="server" Value='<%# Eval("UOMID") %>' />
                                                            <asp:HiddenField ID="hdnIsParent" runat="server" Value='<%# Eval("ReferenceRange") %>' />
                                                            <asp:HiddenField ID="hdnSourceID" runat="server" Value='<%# Eval("SourceID") %>' />
                                                            <asp:HiddenField ID="hdnID" runat="server" Value='<%# Eval("ID") %>' />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Amount For OP" meta:resourcekey="TemplateFieldResource15">
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="hdnAmount" runat="server" Value='<%# Eval("Amount") %>' />
                                                            <asp:TextBox ID="txtAmount" runat="server" MaxLength="10" onblur="CheckRow(this.id);"
                                                                onkeydown="return isNumerc(event,this.id);" Style="text-align: right;" Text='<%# Eval("Amount") %>'
                                                                Width="60px" meta:resourcekey="txtAmountResource3"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="General Rate" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="hdnGeneralAmount" runat="server" Value='<%# Eval("GeneralAmount") %>' />
                                                            <asp:Label ID="lblGeneralAmount" runat="server" Text='<%# Eval("GeneralAmount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Collection Amount"  meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDiffAmount" runat="server" Text='<%# Eval("DiffAmount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Collection Percentage" meta:resourcekey="TemplateFieldResource4">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDiffPercentage" runat="server" Text='<%# Eval("DiffPercentage") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Processed Type" meta:resourcekey="TemplateFieldResource5">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSubCategoryType" runat="server" Text='<%# Eval("SubCategoryType") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Discount Category" meta:resourcekey="TemplateFieldResource6">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldiscount" runat="server" Text='<%# Eval("DiscountCategory") %>'>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="CPT Rate" meta:resourcekey="TemplateFieldResource7">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblCptRate" runat="server" Text='<%# Eval("CptAmount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="CPRT Rate" meta:resourcekey="TemplateFieldResource20">
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="hdncprtAmount" runat="server" Value='<%# Eval("CprtAmount") %>' />
                                                            <asp:Label ID="lblCprtRate" runat="server" Text='<%# Eval("CprtAmount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Amount For IP" meta:resourcekey="TemplateFieldResource16">
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="hdnIPAmount" runat="server" Value='<%# Eval("IPAmount") %>' />
                                                            <asp:TextBox ID="txtIPAmount" runat="server" MaxLength="10" onchange="return CheckRow(this.id);"
                                                                 onkeypress="return ValidateOnlyNumeric(this);"  Style="text-align: right;" Text='<%# Eval("IPAmount") %>'
                                                                Width="60px" meta:resourcekey="txtIPAmountResource2"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="OP Percent" meta:resourcekey="TemplateFieldResource17">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtOPPrecent" runat="server" MaxLength="10" onchange="return CheckRow(this.id);"
                                                                 onkeypress="return ValidateOnlyNumeric(this);"  Style="text-align: right;" Text='<%# Eval("OPPercent") %>'
                                                                Width="60px" meta:resourcekey="txtOPPrecentResource2"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="IP Percent" meta:resourcekey="TemplateFieldResource18">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtIPPrecent" runat="server" MaxLength="10" onchange="return CheckRow(this.id);"
                                                                 onkeypress="return ValidateOnlyNumeric(this);"  Style="text-align: right;" Text='<%# Eval("IPPercent") %>'
                                                                Width="60px" meta:resourcekey="txtIPPrecentResource2"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Minimun Advance Amount" meta:resourcekey="TemplateFieldResource19">
                                                        <ItemTemplate>														
                                                            <asp:TextBox ID="txtMinAdvAmount" runat="server" MaxLength="10" onchange="return ValidateOnlyNumeric(this);"
                                                                onkeypress="CheckRow(this.id);" Style="text-align: right;" Text='<%# Eval("MinAdvanceAmt") %>'
                                                                Width="60px" meta:resourcekey="txtMinAdvAmountResource1"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Service Code" meta:resourcekey="TemplateFieldResource8">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtServiceCode" runat="server" MaxLength="10" meta:resourcekey="txtServiceCodeResource1"
                                                                onkeydown="return CheckRow(this.id);" Style="text-align: right;" Text='<%# Eval("UOMCode") %>'
                                                                Width="60px"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="More Details" meta:resourcekey="TemplateFieldResource9">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkShowSpkgDetails" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                CommandName="ShowSpkgDetails" ForeColor="Black" meta:resourcekey="lnkShowSpkgDetailsResource1"
                                                                Text="ShowDetails"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Is Mapped" meta:resourcekey="TemplateFieldResource10">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblIsMapped" runat="server" Text='<%# Eval("IsMapped") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkBox" runat="server" meta:resourcekey="chkBoxResource2" />
                                                            <asp:HiddenField ID="hdnvalue" runat="server" />
                                                            <asp:LinkButton ID="lnkSplitDetails" runat="server" Text="AddSplit" OnClientClick="javascript:return Check_FeeType(this.id);"
                                                                Style="color: Blue;" meta:resourcekey="lnkSplitDetailsResource1" onblur="CheckRow(this.id);"></asp:LinkButton>
                                                            <asp:HiddenField ID="hdnSplitAmount" runat="server" Value='<%# Eval("SplitDetails") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Is Mapped" Visible="False" meta:resourcekey="TemplateFieldResource21">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkIsMapped" runat="server" meta:resourcekey="chkIsMappedResource2" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                            </asp:GridView>
                                        </div>
                                    </td>
                                </tr>
                                <tr id="GrdFooter" runat="server" style="display: none" class="dataheaderInvCtrl">
                                    <td id="Td3" colspan="10" class="defaultfontcolor a-center" runat="server">
                                        <asp:Label ID="Label1" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                                        <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                        <asp:Label ID="Label2" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                                        <asp:LinkButton ID="Btn_Previous" runat="server" Text="<<" Font-Bold="True" ForeColor="Blue"
                                            OnClientClick="OnSuccess()" OnClick="Btn_Previous_Click"></asp:LinkButton>&nbsp;&nbsp;&nbsp;
                                        <asp:LinkButton ID="Btn_Next" OnClientClick="OnSuccess()" runat="server" Text=">>"
                                            Font-Bold="True" ForeColor="Blue" OnClick="Btn_Next_Click"></asp:LinkButton>
                                        <asp:HiddenField ID="hdnCurrent" runat="server" />
                                        <asp:Label ID="Label7" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label7Resource1"></asp:Label>
                                        <asp:TextBox ID="txtpageNo" runat="server" CssClass="Txtboxverysmall" MaxLength='4'
                                            onkeydown="javascript:return validatenumberOnly(event,this.id);"></asp:TextBox>
                                        <asp:Button ID="btnGo1" runat="server" Text="Go" CssClass="btn" OnClientClick="OnSuccess(this.id)" meta:resourcekey="btnGo1Resource1"
                                            OnClick="btnGo1_Click" />
                                        <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                    </td>
                                </tr>
                                <tr id="trButton" runat="server" style="display: none" class="a-center">
                                    <td id="Td4" runat="server">
                                        <asp:Label ID="lblReason" runat="server" meta:resourcekey="lblReasonResource1" />&nbsp;
                                        <asp:DropDownList ID="ddlReason" runat="server" AutoPostBack="false" CssClass="ddlmedium">
                                        </asp:DropDownList>
                                        &nbsp;
                                        <img class="v-middle" alt="" src="../Images/starbutton.png" /><asp:Button ID="btnSave"
                                            runat="server" Text="Save" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                            OnClientClick="javascript:OnSuccess(this.id);return Retevalidate();" OnClick="btnSave_Click"
                                            meta:resourcekey="btnSaveResource1" />
                                        <%--OnClientClick="javascript:return OnSuccess();"--%>
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                        <asp:Button ID="btnRemove" runat="server" Text="Un-Map" CssClass="btn" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" OnClientClick="javascript:return OnSuccess('Un-Map');"
                                            OnClick="btnRemove_Click" meta:resourceKey="btnRemoveResource1" />
                                        <asp:HiddenField ID="hdnStatus" runat="server" />
                                        <asp:HiddenField ID="hdnSelect" runat="server" />
                                        <asp:HiddenField ID="hdnSearch" runat="server" />
                                        <asp:HiddenField ID="hdnConfirmNames" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDisplay" runat="server" meta:resourcekey="lblDisplayResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <ajc:ModalPopupExtender ID="MPEFeeType" runat="server" TargetControlID="btn" PopupControlID="Panel1"
                                BackgroundCssClass="modalBackground" Enabled="True" DropShadow="True" DynamicServicePath="" />
                            <input type="button" id="btn" runat="server" style="display: none;" />
                            <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup dataheaderPopup" Style="width: 600px;
                                height: auto;" meta:resourcekey="Panel1Resource1">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <table class="w-100p">
                                            <tr class="dataheader1">
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblSplitSelectOption" Text="Fee Type" runat="server" meta:resourcekey="lblSplitSelectOptionResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblRateSplit" Text="Rate Name" runat="server" meta:resourcekey="lblRateSplitResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblSplitDescrption1" Text="Descrption" runat="server" meta:resourcekey="lblSplitDescrption1Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="Label5" Text="Amount" runat="server" meta:resourcekey="Label5Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblSplitSelect" runat="server" meta:resourcekey="lblSplitSelectResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblSplitRateType" runat="server" meta:resourcekey="lblSplitRateTypeResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblSplitDescrption" runat="server" meta:resourcekey="lblSplitDescrptionResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblOPSplitAmount" runat="server" meta:resourcekey="lblOPSplitAmountResource1"></asp:Label>
                                                    <asp:Label ID="lblIPSplitAmount" runat="server" meta:resourcekey="lblIPSplitAmountResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr class="dataheader1">
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblFeeTypeService" Text="Service Name" runat="server" meta:resourcekey="lblFeeTypeServiceResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblType" Text="Type" runat="server" meta:resourcekey="lblTypeResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblAmount" Text="Amount" runat="server" meta:resourcekey="lblAmountResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblAction" Text="Action" runat="server" meta:resourcekey="lblActionResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap">
                                                    <asp:TextBox ID="txtFeetypeSerive" runat="server" CssClass="small" onclick="ChkFeeTypeSerives();"
                                                        autocomplete="off" meta:resourcekey="txtFeetypeSeriveResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderFeetypeSerive" runat="server" TargetControlID="txtFeetypeSerive"
                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                        OnClientItemSelected="funFeetypeSerive" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        ServiceMethod="GetFeeTypeAttributes" ServicePath="~/OPIPBilling.asmx" UseContextKey="True"
                                                        DelimiterCharacters="" Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:CheckBox ID="chkOP" runat="server" Text="OP" Value="OP" Checked="True" meta:resourcekey="chkOPResource1" />
                                                    <asp:CheckBox ID="chkIP" runat="server" Text="IP" Value="IP" meta:resourcekey="chkIPResource1" />
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:TextBox ID="txtFeeTypeAmount" runat="server" MaxLength="20" Style="text-align: right;"
                                                        CssClass="Txtboxverysmall"  onkeypress="return ValidateOnlyNumeric(this);"  onchange="javascript:return split_AmountValidation();"
                                                        meta:resourcekey="txtFeeTypeAmountResource1"></asp:TextBox>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn" OnClientClick="javascript:return Check_SplitValidation();" />
                                                    <%--<input type="button" value="Add" runat="server" id="btnAdd" class="btn" onclick="javascript:Check_SplitValidation();" />--%>
                                                    <asp:HiddenField ID="hdnTotalSplitFeeValue" runat="server" />
                                                    <asp:HiddenField ID="hdnRowEdit" runat="server" />
                                                    <asp:HiddenField ID="hdnTempValue" runat="server" />
                                                    <asp:HiddenField ID="hdnFeeTypeServiceID" runat="server" Value="0" />
                                                    <asp:HiddenField ID="hdnFeeSplitAmount" runat="server" Value="0" />
                                                    <asp:HiddenField ID="hdnRateComparePass" runat="server" Value="0" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <table id="tblOrederedItems" class="dataheaderInvCtrl font11 w-100p" style="text-align: left;">
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr style="display: none;" id="trDisplay" runat="server">
                                                <td id="Td5" class="a-right" colspan="4" style="color: Red;" nowrap="nowrap" runat="server">
                                                    <strong>
                                                        <asp:Label ID="Label6" Text="OP : " runat="server"></asp:Label>
                                                        <asp:Label ID="lblOPSplitTotalAmount" runat="server"></asp:Label>
                                                        <asp:Label ID="Label8" Text="IP : " runat="server"></asp:Label>
                                                        <asp:Label ID="lblIPSplitTotalAmount" runat="server"></asp:Label>
                                                    </strong>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center" colspan="4">
                                                    <asp:Button ID="btnPopupSave" runat="server" Text="Save" CssClass="btn" OnClientClick="javascript:return Close_ModalPOP_Hide();" />
                                                    <asp:Button ID="btnClose" type="button" Text="Close" runat="server" OnClientClick="javascript:return ClientClose();"
                                                        CssClass="btn" />
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
                <table class="w-100p hide paddingL1 searchPanel" id="tabContentAttachDocuments">
                    <tr>
                        <td colspan="5">
                            <table class="w-100p padding4 marginT5 borderGrey marginB7">
                                <tr class="lh30">
                                    <td class="a-left ">
                                        <asp:Label runat="server" class="w-100p" ID="label38" Text="Organization"></asp:Label>
                                    </td>
                                    <td class="a-left bold" runat="server" id="oo">
                                        <label id="lblOrg">
                                            Organization</label>
                                    </td>
                                    <td class="a-left ">
                                        <asp:Label runat="server" class="w-100p" ID="label40" meta:resourcekey="label40Resource1"></asp:Label>
                                    </td>
                                    <td class="a-left bold" runat="server" id="kk">
                                        <asp:Label runat="server" class="w-100p" ID="lblVendorType" Text="Organization"></asp:Label>
                                    </td>
                                    <td class="a-left ">
                                        <asp:Label runat="server" class="w-100p" ID="label42" meta:resourcekey="label42Resource1"></asp:Label>
                                    </td>
                                    <td class="a-left bold" runat="server" id="mklop">
                                        <asp:Label runat="server" class="w-100p" ID="lblSubType" Text="Organization"></asp:Label>
                                    </td>
                                    <td class="a-left ">
                                        <asp:Label runat="server" class="w-100p" ID="label44" Text="Rate Name"></asp:Label>
                                    </td>
                                    <td class="a-left bold" runat="server" id="plkmio">
                                        <asp:Label runat="server" class="w-100p" ID="lblRate" Text="Organization"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="lh30">
                                    <td class="a-left ">
                                        <asp:Label runat="server" class="w-100p" ID="label46" Text="Fee Type"></asp:Label>
                                    </td>
                                    <td class="a-left bold" runat="server" id="label52">
                                        <asp:Label runat="server" class="w-100p" ID="lblFeeType" Text="Organization"></asp:Label>
                                    </td>
                                    <td class="a-left ">
                                        <asp:Label runat="server" class="w-100p" ID="label48" meta:resourcekey="label48Resource1"></asp:Label>
                                    </td>
                                    <td class="a-left bold" runat="server" id="label53">
                                        <asp:Label runat="server" class="w-100p" ID="lblMapping" Text="Organization"></asp:Label>
                                    </td>
                                    <td class="a-left ">
                                        <asp:Label runat="server" class="w-100p" ID="label50" Text="More opitions"></asp:Label>
                                    </td>
                                    <td class="a-left bold" runat="server" id="label54">
                                        <asp:Label runat="server" class="w-100p" ID="lblMoreOp" Text="Organization"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="w-100p">
                                <tr>
                                    <td colspan="5" class="colorforcontent">
                                        <asp:Label runat="server" ID="label61" Text="Attach Documents"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="finalfilename">
                                    <td class="w-10p">
                                        <asp:Label ID="label58" runat="server" Text="File Name"></asp:Label>
                                    </td>
                                    <td class="w-20p">
                                        <asp:TextBox ID="txtFilename" runat="server" class="small"></asp:TextBox>
                                    </td>
                                    <td class="w-10p">
                                        <asp:Label ID="label59" runat="server" Text="File Date"></asp:Label>
                                    </td>
                                    <td class="w-20p">
                                        <%--  <asp:TextBox ID="textbox1" runat="server" class="small datePicker"></asp:TextBox>--%>
                                        <asp:TextBox CssClass="Txtboxsmall" ToolTip="dd/mm/yyyy" ID="tDOB" runat="server"
                                            Width="100px" Style="text-align: justify" ValidationGroup="MKE" meta:resourceKey="tDOBResource1" />
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                            CultureTimePlaceholder="" Enabled="True" />
                                        <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                            PopupButtonID="ImgBntCalc" Enabled="True" />
                                    </td>
                                    <td class="w-20p">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr class="">
                                    <td>
                                        <asp:Label ID="label60" runat="server" Text="Upload File"></asp:Label>
                                    </td>
                                    <td class="w-30p">
                                        <input id="fileToUpload" name="fileToUpload" class="btn marginL570" size="45" type="file" />
                                    </td>
                                    <td class="a-left">
                                        <asp:Button ID="Button1" runat="server" class="ClsAdd btn marginL570" Text="Add" />
                                    </td>
                                    <td class="w-40p">
                                        <asp:ListBox ID="ListFiles" runat="server" CssClass="w-50p h-100" Style="display: none;" />
                                        <div id="divFiles" class="finalcopylist borderGrey bg-white marginL5 w-70p">
                                        </div>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="a-right w-20p">
                                                    <button type="reset" id="btnCancel23" class="btn marginL570">
                                                        Clear</button>
                                                </td>
                                                <td class="a-center w-10p">
                                                    <asp:Label ID="label99" runat="server" class="w-100p" Text="Select Reason"></asp:Label>
                                                </td>
                                                <td id="tddocname111" runat="server" class="a-left w-10p">
                                                    <asp:DropDownList ID="ddlAttachReason" runat="server" CssClass="small">
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="w-14p">
                                                    <asp:TextBox ID="txtAddReason" runat="server"></asp:TextBox>
                                                </td>
                                                <td class="a-left w-30p">
                                                    <asp:Button ID="btnFirstSave456" runat="server" class="btnsaveRate btn marginL570"
                                                        Text="Save" />
                                                </td>
                                                <td>
                                                    <caption>
                                                        <iframe id="iframe" style="display: none;"></iframe>
                                                    </caption>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
             </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnUploadRatecard" />
                <%-- <asp:PostBackTrigger ControlID="imgExportToExcel" />--%>
                <asp:PostBackTrigger ControlID="lnkExportXL" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <%----------------Babu 21-12-2012--------------------------%>
    <%-----------------end----------------------%>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnVendorTypeID1" runat="server" Value="0" />

   <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
        <script src="../Scripts/chosen.jquery.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        var objAlert = "";
        $(document).ready(function() {
           
        });
        function PassCleared() {
            var checkedRowsCount = 0;
            $("#divgv table tr").each(function() {
                var tr = $(this).closest("tr");
                if ($(tr).find("input:text[id$=txtAmount]").val() != undefined) {
                    var chk = $(tr).find("input:checkbox[id$=chkBox]").is(':checked');

                    if (chk == true) {
                        var hdn = document.getElementById('<%=hdnSelect.ClientID%>');
                        var rowid = document.getElementById('<%=hdnCurrent.ClientID %>').value;
                        var hdnSpid = $(tr).find("input:hidden[id$=hdnSpecId]") ? $(tr).find("input:hidden[id$=hdnSpecId]").val() : '';
                        var hdnIsPar = $(tr).find("input:hidden[id$=hdnIsParent]") ? $(tr).find("input:hidden[id$=hdnIsParent]").val() : '';
                        var hdnSouid = $(tr).find("input:hidden[id$=hdnSourceID]") ? $(tr).find("input:hidden[id$=hdnSourceID]").val() : '';
                        var hdid = $(tr).find("input:hidden[id$=hdnID]") ? $(tr).find("input:hidden[id$=hdnID]").val() : '';
                        var hdamt = $(tr).find("input:hidden[id$=hdnAmount]") ? $(tr).find("input:hidden[id$=hdnAmount]").val() : '';
                        var hdnIpamt = $(tr).find("input:hidden[id$=hdnIPAmount]") ? $(tr).find("input:hidden[id$=hdnIPAmount]").val() : '';
                        var hdnMinAdvAmt = $(tr).find("input:hidden[id$=hdnMinAdvAmt]") ? $(tr).find("input:hidden[id$=hdnMinAdvAmt]").val() : '';
                        var txtamt = $(tr).find("input:text[id$=txtAmount]").val();
                        var hdnSplitAmt = $(tr).find("input:hidden[id$=hdnSplitAmount]") ? $(tr).find("input:hidden[id$=hdnSplitAmount]").val() : '';

                        var cprtAmt = $(tr).find("input:hidden[id$=hdncprtAmount]") ? $(tr).find("input:hidden[id$=hdncprtAmount]").val() : '';


                        if (txtamt == undefined)
                            txtamt = '0.00';
                        var txtIpamt = $(tr).find("input:text[id$=txtIPAmount]").val();
                        if (txtIpamt == undefined)
                            txtIpamt = '0.00';
                        var txtOpPer = $(tr).find("input:text[id$=txtOPPrecent]").val();
                        if (txtOpPer == undefined)
                            txtOpPer = '0.00';
                        var txtIpPer = $(tr).find("input:text[id$=txtIPPrecent]").val();
                        if (txtIpPer == undefined)
                            txtIpPer = '0.00';
                        var txtScode = $(tr).find("input:text[id$=txtServiceCode]").val();
                        if (txtScode == undefined)
                            txtScode = '0.00';
                        var txtMinAdvAmt = $(tr).find("input:text[id$=txtMinAdvAmount]").val();
                        if (txtMinAdvAmt == undefined)
                            txtMinAdvAmt = '0.00';
                        var chkMapd = $(tr).find("input:checkbox[id$=chkIsMapped]").attr('checked') ? true : false;
                        if (chkMapd == undefined)
                            chkMapd = false;
                        var des = $(tr).find("#lblDescriptionName").prevObject[0].innerText;
                        var des1 = '';
//                        if (des == "Yes") {
//                            des1 = des.replace('Yes', '');
//                        }
//                        if (des == "No") {
//                            des1 = des.replace('No', '');
//                        }
                                                des = des.replace('Yes', '');
                                                des = des.replace('No', '');
                        // des = des.text();
                        //removeOldItems(hdnSouid, hdnSpid, hdid);

                        hdn.value += rowid + '*' + hdnSouid + '~' + hdnSpid + '~' + hdid + '~' + hdamt + '~' + txtamt + '~' +
                                                          hdnIpamt + '~' + txtIpamt + '~' + txtOpPer + '~' + txtIpPer + '~' + txtScode + '~' + txtMinAdvAmt + '~' + chkMapd + '~' + des + '^';

                        if (hdnSplitAmt != '') {
                            document.getElementById('<%=hdnTotalSplitFeeValue.ClientID%>').value += hdnSplitAmt + '$';
                        }
                        if (parseFloat(txtamt) < parseFloat(cprtAmt)) {
                            document.getElementById('<%=hdnRateComparePass.ClientID %>').value = "Fail";
                        }
                        else {
                            document.getElementById('<%=hdnRateComparePass.ClientID %>').value = "Pass";
                        }

                        //var hdn = document.getElementById('<%=hdnSelect.ClientID%>');                                                            
                        checkedRowsCount++;
                    }
                }
            });

            document.getElementById('<%=hdnStatus.ClientID %>').value = "Changed";

        }
        function OnSuccess(checkPage) {




            if (checkPage === 'ConfirmSubmit') {
                PassCleared();
                return true;
            }

            if (checkPage === 'Un-Map') {

                var objVar16 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_16") == null ? "Rates want to un-map ?" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_16");
                var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");
                var objVar17 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_17") == null ? "Please select atleast one item" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_17");

                PassCleared();
              
                var checkedNames = [];
                var serialNo = 1;
                var onlyselectedNames = [];
                var DescriptionName = [];
                var getRateNames = [];
                var selectedNames = [];
                var unqiueDescriptionNames = [];
                var finalResults = '';
                var removeAddsplitNames = [];
                var tempValue = '';
                getRateNames = (document.getElementById('<%=hdnSelect.ClientID%>').value).split('^');
                alert(document.getElementById('<%=hdnSelect.ClientID%>').value);
                //append the current page names with total selected names

                if (getRateNames.length > 1) {

                    //textBox.length + [backup]        
                    selectedNames = getRateNames.uniqueNames();
                    for (var i = 0; i < selectedNames.length; i++) {
                        onlyselectedNames = selectedNames[i].split('~');
                        DescriptionName[i] = onlyselectedNames[12];


                    }

                }
                if (DescriptionName.length > 0) {
                    DescriptionName.length = DescriptionName.length - 1;
                }


                unqiueDescriptionNames = DescriptionName.uniqueNames();
                unqiueDescriptionNames.sort(function(a, b) {
                    return a.toLowerCase().localeCompare(b.toLowerCase());
                });
                for (var i = 0; i < unqiueDescriptionNames.length; i++) {
                    tempValue = unqiueDescriptionNames[i];
                    tempValue = tempValue.replace('AddSplit', '');
                    removeAddsplitNames[i] = tempValue;
                }
                //display the names in the alert box

                for (var i = 0; i < removeAddsplitNames.length; i++) {
                    finalResults += serialNo + '. ' + removeAddsplitNames[i] + '\n';
                    serialNo++;
                }
                if (unqiueDescriptionNames.length > 0) {
                    if (confirm(finalResults + '\n ' + objVar16)) {
                        finalResults = '';
                        unqiueDescriptionNames = [];
                        DescriptionName = [];
                        return true;
                    }
                    else {

                        selectedNames = [];
                        finalResults = '';
                        unqiueNames = [];
                        DescriptionName = [];
                        unqiueDescriptionNames = [];
                        document.getElementById('<%=hdnSelect.ClientID%>').value = '';
                        return false;
                    }

                }
                else {
                    //  alert('Please select atleast one item');
                    ValidationWindow(objVar17, objAlert);
                    return false;
                }
            }

            if (checkPage === 'btnSave') {
                PassCleared();

                return true;
            }
        }

        function removeOldItems(SorID, SpID, ID) {
            var i;
            var x = document.getElementById('<%=hdnSelect.ClientID%>').value.split("^");
            document.getElementById('<%=hdnSelect.ClientID%>').value = '';
            for (i = 0; i < x.length - 1; i++) {
                if (x[i] != "") {
                    var val = x[i].split("*")[1].split("~");
                    if (val[0] != SorID) {
                        document.getElementById('<%=hdnSelect.ClientID%>').value += x[i] + "^";
                    }
                }
            }
        }


        function SetValue() {
            var hdsl = document.getElementById('<%=hdnSelect.ClientID%>').value;
            var curPage = document.getElementById('<%=hdnCurrent.ClientID%>').value;
            if (hdsl != '') {
                var preval = hdsl.split('^');
                for (var i = 0; i < preval.length; i++) {
                    var selva = preval[i].split('*');
                    if (selva[0] == curPage) {
                        var selv = selva[1].split('~');
                        $("#divgv table tr").each(function() {
                            var tr = $(this).closest("tr");
                            var hdn = document.getElementById('<%=hdnSelect.ClientID%>');
                            var rowid = document.getElementById('<%=hdnCurrent.ClientID %>').value;
                            var chk = $(tr).find("input:checkbox[id$=chkBox]");
                            if (chk != undefined) {
                                //var hdnSpid = $(tr).find("input:hidden[id$=hdnSpecId]").val() : '';
                                // var hdnIsPar = $(tr).find("input:hidden[id$=hdnIsParent]") ? $(tr).find("input:hidden[id$=hdnIsParent]").val() : '';
                                var hdnSouid = $(tr).find("input:hidden[id$=hdnSourceID]") ? $(tr).find("input:hidden[id$=hdnSourceID]").val() : '';
                                //  var hdid = $(tr).find("input:hidden[id$=hdnID]") ? $(tr).find("input:hidden[id$=hdnID]").val() : '';
                                //  var hdamt = $(tr).find("input:hidden[id$=hdnAmount]") ? $(tr).find("input:hidden[id$=hdnAmount]").val() : '';
                                var txtamt = $(tr).find("input:text[id$=txtAmount]").val();
                                //  var hdnIpamt = $(tr).find("input:hidden[id$=hdnIPAmount]") ? $(tr).find("input:hidden[id$=hdnIPAmount]").val() : '';
                                var txtIpamt = $(tr).find("input:text[id$=txtIPAmount]") ? $(tr).find("input:text[id$=txtIPAmount]").val() : '';
                                var txtOpPer = $(tr).find("input:text[id$=txtOPPrecent]") ? $(tr).find("input:text[id$=txtOPPrecent]").val() : $(tr).find("input:text[id$=txtOPPrecent]").val('0.00');
                                var txtIpPer = $(tr).find("input:text[id$=txtIPPrecent]") ? $(tr).find("input:text[id$=txtIPPrecent]").val() : $(tr).find("input:text[id$=txtIPPrecent]").val('0.00');
                                var txtminAdvAmt = $(tr).find("input:text[id$=txtMinAdvAmount]") ? $(tr).find("input:text[id$=txtMinAdvAmount]").val() : $(tr).find("input:text[id$=txtMinAdvAmount]").val('0.00');
                                var txtScode = '';
                                if ($(tr).find("input:text[id$=txtServiceCode]") != undefined);
                                txtScode = $(tr).find("input:text[id$=txtServiceCode]") ? $(tr).find("input:text[id$=txtServiceCode]").val() : '';
                                var chkMapd = $(tr).find("input:checkbox[id$=chkIsMapped]");
                                if (hdnSouid == selv[0]) {
                                    $(tr).find("input:hidden[id$=hdnSourceID]").val(selv[0]);
                                    $(tr).find("input:hidden[id$=hdnSpecId]").val(selv[1]);
                                    $(tr).find("input:hidden[id$=hdnID]").val(selv[2]);
                                    $(tr).find("input:hidden[id$=hdnAmount]").val(selv[3]);
                                    if (txtamt == undefined)
                                        txtamt = '0.00';
                                    else
                                        $(tr).find("input:text[id$=txtAmount]").val(selv[4]);
                                    $(tr).find("input:hidden[id$=hdnIPAmount]").val(selv[5]);
                                    if (txtIpamt == undefined)
                                        txtIpamt = '0.00';
                                    else
                                        $(tr).find("input:text[id$=txtIPAmount]").val(selv[6]);
                                    if (txtOpPer == undefined)
                                        txtOpPer = '0.00';
                                    else
                                        $(tr).find("input:text[id$=txtOPPrecent]").val(selv[7]);
                                    if (txtIpPer == undefined)
                                        txtIpPer = '0.00';
                                    else
                                        $(tr).find("input:text[id$=txtIPPrecent]").val(selv[8]);
                                    if (txtScode == undefined)
                                        txtScode = '0.00';
                                    else
                                        $(tr).find("input:text[id$=txtServiceCode]").val(selv[9]);

                                    if (txtminAdvAmt == undefined)
                                        txtminAdvAmt = '0.00';
                                    else
                                        $(tr).find("input:text[id$=txtMinAdvAmount]").val(selv[10]);
                                    if (chkMapd == undefined)
                                        chkMapd = false;
                                    else
                                        chkMapd.attr('checked', chkMapd);
                                    chk.attr('checked', true);
                                }
                            }
                        }
                        );
                    }
                }
            }
        }
        function CheckRow(id) {
            var ids = id.split('_');
            var txt = ids[2];
            //document.getElementById('<%=btnSave.ClientID %>').disabled = true;
            //document.getElementById('<%=hdnStatus.ClientID %>').value = "";
            //document.getElementById(''+ ids[0] + '_' + ids[1] + '_' + 'hdnSplitAmount').value='';

            // $("#divgv table tr").each(function() {
            //   var tr = $(this).closest("tr");
            // $(tr).find("input:text[id$=" + txt + "]").change(
            //function(event) {
            var txtval = $("#" + id).val();
            var grid = id.substring(0, id.lastIndexOf('_') + 1);
            var hdn = $("#" + grid + "hdnAmount").val(); //$(tr).find("input:hidden[id$=hdnAmount]").val();
            if (txtval != undefined && hdn != undefined) {
                txtval = Number(txtval);
                hdn = Number(hdn);
                var chk = $("#" + grid + "chkBox"); //$(tr).find("input:checkbox[id$=chkBox]");
                if (hdn != txtval) {
                    chk.attr('checked', true);
                    // document.getElementById('<%=btnSave.ClientID %>').disabled = false;
                    //document.getElementById('<%=hdnStatus.ClientID %>').value = "Changed";


                }
                else {
                    chk.attr('checked', false);
                }
                document.getElementById('<%=hdnStatus.ClientID %>').value = "Changed";
            }
            // }
            // );
            // });
        }

        var Status;
        //--------------Babu 21-12-2012------------------------
        function Check_FeeType(id) {
            var objVar18 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_18") == null ? "Please Select a Fee Type" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_18");
            var objVar19 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_19") == null ? "Please Select a Rate Name" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_19");
            var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");

            var ids = id.split('_');
            if (document.getElementById('<%= ddlFeeType.ClientID %>').selectedIndex == 0) {

                var userMsg = SListForApplicationMessages.Get('Admin\\RatesUpdation.aspx_21');
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                }
                else {
                    //alert('Please Select a Fee Type');
                    ValidationWindow(objvar18, objAlert);

                }

                return false;

            }
            else if (document.getElementById('<%= txtRateCard.ClientID %>').value == "") {

                var userMsg = SListForApplicationMessages.Get('Admin\\RatesUpdation.aspx_22');

                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                }
                else {
                    // alert('Please Select a Rate Name');
                    ValidationWindow(objVar19, objAlert);
                }
                return false;

            }


            var Descriptiom = ids[0] + '_' + ids[1] + '_' + 'lblDescriptionName';
            var SpecID = ids[0] + '_' + ids[1] + '_' + 'hdnSpecId';
            var PHYID = ids[0] + '_' + ids[1] + '_' + 'hdnSourceID';
            var ID = ids[0] + '_' + ids[1] + '_' + 'hdnID';
            var Check = ids[0] + '_' + ids[1] + '_' + 'chkBox';
            $("#" + Check).attr("checked", true);
            var OPAmount = ids[0] + '_' + ids[1] + '_' + 'txtAmount';
            var IPAmount = ids[0] + '_' + ids[1] + '_' + 'txtIPAmount';

            $('#lblSplitDescrption')[0].innerHTML = $('#' + Descriptiom + '')[0].innerHTML;
            var ddlSelect = document.getElementById("ddlFeeType");
            var ddlSelectText = ddlSelect.options[ddlSelect.selectedIndex].text;

            $('#lblSplitSelect')[0].innerHTML = ddlSelectText;

            $('#lblOPSplitAmount')[0].innerHTML = 'OP : ' + $('#' + OPAmount + '').val();
            $('#lblIPSplitAmount')[0].innerHTML = 'IP : ' + $('#' + IPAmount + '').val();

            //var skillsSelect = document.getElementById("ddlRateCard");
            //var selectedText = skillsSelect.options[skillsSelect.selectedIndex].text;

            //$('#lblSplitRateType')[0].innerHTML = selectedText;


            //var RateValue = document.getElementById("ddlRateCard").value.split('~');


            //document.getElementById('<%= hdnFeeSplitAmount.ClientID %>').value = $('#' + OPAmount + '').val()+ '$' + $('#' + IPAmount + '').val();
            document.getElementById('<%= hdnFeeSplitAmount.ClientID %>').value = Number(ToInternalFormat($('#' + OPAmount + ''))) + '$' + Number(ToInternalFormat($('#' + IPAmount + '')));
            //document.getElementById('<%= hdnTempValue.ClientID %>').value =ids[0] + '_' + ids[1] + '_' + 'hdnSplitAmount'
            //                                             + '$' + $('#' + SpecID + '').val() + '$' + $('#' + PHYID + '').val()+'$'+RateValue[1]+'$'+$('#' + ID + '').val();

            var SID = Number(ToInternalFormat($('#' + SpecID + '')));
            var SourceID = Number(ToInternalFormat($('#' + PHYID + '')));
            var VID = Number(ToInternalFormat($('#' + ID + '')));

            document.getElementById('<%= hdnTempValue.ClientID %>').value = ids[0] + '_' + ids[1] + '_' + 'hdnSplitAmount'
                                                        + '$' + SID + '$' + SourceID + '$' + RateValue[1] + '$' + VID;


            TableSplitType(ids[0] + '_' + ids[1] + '_' + 'hdnSplitAmount', SID, SourceID, RateValue[1], VID);
            Status = ids[0] + '_' + ids[1] + '_' + 'hdnSplitAmount';
            document.getElementById('<%=chkOP.ClientID %>').checked = true;
            document.getElementById('<%=chkIP.ClientID %>').checked = false;


            $find("MPEFeeType").show();

            // document.getElementById('<%= txtFeetypeSerive.ClientID %>').focus();

            return false;
        }




        function Close_ModalPOP_Hide() {

            var a = document.getElementById('<%= hdnTempValue.ClientID %>').value;
            var b = a.split('$');
            var SplitAmount = document.getElementById('<%= hdnFeeSplitAmount.ClientID %>').value.split('$');
            var OPAmount = 0;
            var IPAmount = 0;

            var x = document.getElementById(b[0]).value.split("^");
            for (i = 0; i < x.length; i++) {

                if (x[i] != "") {

                    var y = x[i].split('~');

                    if (y[2] == 'OPIP') {
                        IPAmount = parseFloat(IPAmount) + parseFloat(y[4]);
                        OPAmount = parseFloat(OPAmount) + parseFloat(y[4]);
                    } else if (y[2] == 'OP') {
                        OPAmount = parseFloat(OPAmount) + parseFloat(y[4]);
                    } else {
                        IPAmount = parseFloat(IPAmount) + parseFloat(y[4]);
                    }
                }
            }
            var objVar20 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_20") == null ? "Amount Mismatch" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_20");
            var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");

            if ((OPAmount != parseFloat(SplitAmount[0]) && OPAmount > 0) || (IPAmount != parseFloat(SplitAmount[1]) && IPAmount > 0)) {

                var userMsg = SListForApplicationMessages.Get('Admin\\RatesUpdation.aspx_23');

                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                }
                else {
                    // alert('Amount Mismatch');
                    ValidationWindow(objVar20, objAlert);
                    document.getElementById('<%= txtFeeTypeAmount.ClientID %>').focus();
                }
            }
            else {
                Clear();
                var modal = $find("MPEFeeType");
                modal.hide();
            }

            return false;
        }

        function ClientClose() {
            Clear();
            //document.getElementById(Status).value = "";
            EmptySplitValue();
            var modal = $find("MPEFeeType");
            modal.hide();
            return false;
        }

        function EmptySplitValue() {
            var a = document.getElementById('<%= hdnTempValue.ClientID %>').value;
            var b = a.split('$');
            var SplitAmount = document.getElementById('<%= hdnFeeSplitAmount.ClientID %>').value.split('$');
            var OPAmount = 0;
            var IPAmount = 0;

            var x = document.getElementById(b[0]).value.split("^");
            for (i = 0; i < x.length; i++) {

                if (x[i] != "") {

                    var y = x[i].split('~');

                    if (y[2] == 'OPIP') {
                        IPAmount = parseFloat(IPAmount) + parseFloat(y[4]);
                        OPAmount = parseFloat(OPAmount) + parseFloat(y[4]);
                    } else if (y[2] == 'OP') {
                        OPAmount = parseFloat(OPAmount) + parseFloat(y[4]);
                    } else {
                        IPAmount = parseFloat(IPAmount) + parseFloat(y[4]);
                    }
                }
            }

            if ((OPAmount != parseFloat(SplitAmount[0]) && OPAmount > 0) || (IPAmount != parseFloat(SplitAmount[1]) && IPAmount > 0)) {
                document.getElementById(b[0]).value = '';

            }
        }
        function Check_SplitValidation() {
            var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");
            var objVar18 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_18") == null ? "Please Select a Fee Type" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_18");
            var objVar27 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_27") == null ? "Please Enter a FeeType Service Name" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_27");
            var objVar22 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_22") == null ? "Please Enter a Amount" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_22");
            var objVar23 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_23") == null ? "FeeType Service Already Exists" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_23");

            var FeeOP = document.getElementById('<%=chkOP.ClientID %>');
            var FeeIP = document.getElementById('<%=chkIP.ClientID %>');
            var FeeAmount = Number(ToInternalFormat($('#txtFeeTypeAmount')));

            // var FeeAmount = ToInternalFormat document.getElementById('<%= txtFeeTypeAmount.ClientID %>').value;
            var FeeService = document.getElementById('<%= txtFeetypeSerive.ClientID %>').value;
            var FeeTypeAttriID = document.getElementById('<%= hdnFeeTypeServiceID.ClientID %>').value;

            if (FeeOP.checked == false && FeeIP.checked == false) {
                var userMsg = SListForApplicationMessages.Get('Admin\\RatesUpdation.aspx_24');

                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                }
                else {
                    // alert('Please Select a FeeType');
                    ValidationWindow(objVar18, objAlert);
                }
                return false;
            }
            else if (FeeService == '' || FeeTypeAttriID == "0") {
                var userMsg = SListForApplicationMessages.Get('Admin\\RatesUpdation.aspx_25');

                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                }
                else {
                    // alert('Please Enter a FeeType Service Name');
                    ValidationWindow(objVar27, objAlert);
                }


                document.getElementById('<%= txtFeetypeSerive.ClientID %>').focus();

                return false;

            }

            else if (FeeAmount == '' || FeeAmount == 0) {
                var userMsg = SListForApplicationMessages.Get('Admin\\RatesUpdation.aspx_26');

                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                }
                else {
                    //alert('Please Enter a Amount');
                    ValidationWindow(objVar22, objAlert);
                }

                document.getElementById('<%= txtFeeTypeAmount.ClientID %>').focus();
                return false;
            }

            if (split_AmountValidation() == false) {
                return false;
            }

            var a = document.getElementById('<%= hdnTempValue.ClientID %>').value;
            var b = a.split('$');


            if (document.getElementById('btnAdd').value != 'Update') {
                var x = document.getElementById(b[0]).value.split("^");

                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        y = x[i].split('~');
                        var type;
                        if (FeeOP.checked == true && FeeIP.checked == true)
                            type = 'OPIP';
                        else if (FeeOP.checked == true)
                            type = 'OP';
                        else
                            type = 'IP';

                        if (y[0] == b[1] && y[1] == b[2] && y[5] == FeeTypeAttriID && y[2] == type) {
                            var userMsg = SListForApplicationMessages.Get('Admin\\RatesUpdation.aspx_27');
                            if (userMsg != null) {
                                alert(userMsg);
                            }
                            else {
                                // alert('FeeType Service Already Exists ');
                                ValidationWindow(objVar23, objAlert);
                            }
                            return false;
                        }
                    }
                }
            }


            BindSplitAmountList(b[0], b[1], b[2], b[3], b[4]);
            return false;
        }

        function BindSplitAmountList(hdnvalue, SpecID, PhyID, RateID, ID) {

            if (document.getElementById('<%=btnAdd.ClientID %>').value == 'Update') {
                Deleterows(hdnvalue, SpecID, PhyID, RateID);
            }
            else {
                var FeeOP = document.getElementById('chkOP');
                var FeeIP = document.getElementById('chkIP');
                //var FeeAmount = document.getElementById('txtFeeTypeAmount').value;
                var FeeAmount = Number(ToInternalFormat($('#txtFeeTypeAmount')));
                var FeeService = document.getElementById('txtFeetypeSerive').value;
                var FeeTypeAttriID = document.getElementById('hdnFeeTypeServiceID').value;


                SpecID = SpecID != null ? SpecID : 0;
                PhyID = PhyID != null ? PhyID : 0;
                RateID = RateID != null ? RateID : 0;
                ID = ID != null ? ID : 0;

                if (FeeOP.checked == true && FeeIP.checked == true) {

                    document.getElementById(hdnvalue).value += SpecID + '~' + PhyID + '~' + "OPIP~" + FeeService + "~" +
                                                                FeeAmount + '~' + FeeTypeAttriID + '~' + RateID + '~' + ID + '^';

                }
                else if (FeeOP.checked == true) {

                    document.getElementById(hdnvalue).value += SpecID + '~' + PhyID + '~' + "OP~" + FeeService + "~"
                                                                 + FeeAmount + '~' + FeeTypeAttriID + '~' + RateID + '~' + ID + '^';
                }
                else if (FeeIP.checked == true) {

                    document.getElementById(hdnvalue).value += SpecID + '~' + PhyID + '~' + "IP~" + FeeService + "~" +
                                                 FeeAmount + '~' + FeeTypeAttriID + '~' + RateID + '~' + ID + '^';
                }

            }

            TableSplitType(hdnvalue, SpecID, PhyID, RateID, ID);
            Clear();

            document.getElementById('<%=btnAdd.ClientID %>').value = 'Add';

        }


        function TableSplitType(hdnvalue, SpecID, PhyID, RateID, ID) {

            while (count = document.getElementById('tblOrederedItems').rows.length) {

                for (var j = 0; j < document.getElementById('tblOrederedItems').rows.length; j++) {
                    document.getElementById('tblOrederedItems').deleteRow(j);
                }
            }

            var Headrow = document.getElementById('tblOrederedItems').insertRow(0);
            Headrow.id = "HeadID";
            Headrow.style.fontWeight = "bold";
            Headrow.className = "dataheader1"
            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            var cell4 = Headrow.insertCell(3);


            cell1.innerHTML = "Fee Type";
            cell2.innerHTML = "Service Name";
            cell3.innerHTML = "Amount";
            cell4.innerHTML = "Action";

            var OPAmount = 0;
            var IPAmount = 0;

            var x = document.getElementById(hdnvalue).value.split("^");
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    var y = x[i].split('~')
                    var row = document.getElementById('tblOrederedItems').insertRow(1);
                    row.style.height = "13px";
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);

                    cell1.innerHTML = y[2];
                    cell2.innerHTML = y[3];
                    cell3.innerHTML = y[4];
                    //                    cell4.innerHTML = "<input name='" + SpecID + '~' + PhyID + '~' + y[2] + "~" + y[3] + "~" + y[4] + '~' + y[5] + '~' + RateID + '~' + ID + "' onclick='btnEdit_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.Admin_RatesUpdation_Edit%>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/> &nbsp;&nbsp;" +
                    //                                              "<input name='" + SpecID + '~' + PhyID + '~' + y[2] + "~" + y[3] + "~" + y[4] + '~' + y[5] + '~' + RateID + '~' + ID + "' onclick='btnDelete(name);' value = '<%=Resources.ClientSideDisplayTexts.Admin_RatesUpdation_Delete%>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>"

                    //

                    cell4.innerHTML = "<input name='" + SpecID + '~' + PhyID + '~' + y[2] + "~" + y[3] + "~" + y[4] + '~' + y[5] + '~' + RateID + '~' + ID + "' onclick='btnDelete(name);' value = '<%=Resources.ClientSideDisplayTexts.Admin_RatesUpdation_Delete%>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";



                    if (y[2] == 'OPIP') {
                        IPAmount = parseFloat(IPAmount) + parseFloat(y[4]);
                        OPAmount = parseFloat(OPAmount) + parseFloat(y[4]);
                    } else if (y[2] == 'OP') {
                        OPAmount = parseFloat(OPAmount) + parseFloat(y[4]);
                    } else {
                        IPAmount = parseFloat(IPAmount) + parseFloat(y[4]);
                    }


                }

            }

            if (x.length > 1) {

                document.getElementById('trDisplay').style.display = 'table-row';

                document.getElementById('lblIPSplitTotalAmount').innerHTML = IPAmount;
                document.getElementById('lblOPSplitTotalAmount').innerHTML = OPAmount;
                ToTargetFormat($('#lblIPSplitTotalAmount'));
                ToTargetFormat($('#lblOPSplitTotalAmount'));
            }
            else {
                document.getElementById('trDisplay').style.display = 'none';
            }

        }

        function btnDelete(sEditedData) {

            var a = document.getElementById('<%= hdnTempValue.ClientID %>').value;

            var b = a.split('$');


            var x = document.getElementById(b[0]).value.split("^");
            document.getElementById(b[0]).value = '';


            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {

                    if (x[i] != sEditedData) {
                        document.getElementById(b[0]).value += x[i] + "^";
                    }
                }
            }
            TableSplitType(b[0], b[1], b[2], b[3], b[4]);
        }

        function btnEdit_OnClick(sEditedData) {
            var y = sEditedData.split('~');

            document.getElementById('<%= txtFeeTypeAmount.ClientID %>').value = y[4];
            document.getElementById('<%= txtFeetypeSerive.ClientID %>').value = y[3];
            document.getElementById('<%= hdnFeeTypeServiceID.ClientID %>').value = y[5];

            if (y[2].length == 4) {
                document.getElementById('<%=chkIP.ClientID %>').checked = true;
                document.getElementById('<%=chkOP.ClientID %>').checked = true;
            }
            else if (y[2] == 'OP') {
                document.getElementById('<%=chkOP.ClientID %>').checked = true;
            }
            else if (y[2] == 'IP') {
                document.getElementById('<%=chkIP.ClientID %>').checked = true;
            }


            document.getElementById('<%=btnAdd.ClientID %>').value = "Update";
            document.getElementById('hdnRowEdit').value = sEditedData;
        }


        function Deleterows(hdnvalue, SpecID, PhyID, RateID, ID) {
            var RowEdit = document.getElementById('hdnRowEdit').value;
            var x = document.getElementById(hdnvalue).value.split("^");

            if (RowEdit != "") {
                var FeeOP = document.getElementById('<%=chkOP.ClientID %>');
                var FeeIP = document.getElementById('<%=chkIP.ClientID %>');
                var FeeAmount = document.getElementById('<%= txtFeeTypeAmount.ClientID %>').value;
                var FeeService = document.getElementById('<%= txtFeetypeSerive.ClientID %>').value;
                var FeeTypeAttriID = document.getElementById('<%= hdnFeeTypeServiceID.ClientID %>').value;

                SpecID = SpecID != null ? SpecID : 0;
                PhyID = PhyID != null ? PhyID : 0;
                RateID = RateID != null ? RateID : 0;
                ID = ID != null ? ID : 0;

                if (FeeOP.checked == true && FeeIP.checked == true) {

                    document.getElementById(hdnvalue).value = SpecID + '~' + PhyID + '~' + "OPIP~" + FeeService + "~"
                     + FeeAmount + '~' + FeeTypeAttriID + '~' + RateID + '~' + ID + '^';

                }
                else if (FeeOP.checked == true) {

                    document.getElementById(hdnvalue).value = SpecID + '~' + PhyID + '~' + "OP~" + FeeService + "~" + FeeAmount
                     + '~' + FeeTypeAttriID + '~' + RateID + '~' + ID + '^';
                }
                else if (FeeIP.checked == true) {

                    document.getElementById(hdnvalue).value = SpecID + '~' + PhyID + '~' + "IP~" + FeeService + "~" + FeeAmount
                     + '~' + FeeTypeAttriID + '~' + RateID + '~' + ID + '^';
                }

                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != RowEdit) {
                            document.getElementById(hdnvalue).value += x[i] + "^";
                        }
                    }
                }

            }
        }


        function ChkFeeTypeSerives() {
            var sval = document.getElementById('hdnFeeType').value;
            $find('AutoCompleteExtenderFeetypeSerive').set_contextKey(sval);
        }

        function UpdateRate(txtAmount, rowindex) {
            //debugger;
            var Chck = txtAmount.replace('txtAmount', '') + 'chkBox';
            document.getElementById(Chck).checked = true;
            document.getElementById('<%=hdnStatus.ClientID %>').value = "Changed";

            var txtAmt = document.getElementById(txtAmount).value;
            if (txtAmt != "") {
                txtAmt = parseFloat(txtAmt);
                $("#<%=gvRatesMaster.ClientID %> tr").each(function() {
                    //Skip first(header) row
                    if (!this.rowIndex) return;
                    if (this.rowIndex == parseInt(rowindex) + 1) {
                        var tr = $(this).closest("tr");
                        var GnrlAmtid = $(tr).find("span[id*=lblGeneralAmount]");
                        var DiffAmtid = $(tr).find("span[id*=lblDiffAmount]");
                        var DiffPcg = $(tr).find("span[id*=lblDiffPercentage]");
                        DiffAmtid.text(parseFloat(parseFloat(GnrlAmtid.text()) - parseFloat(txtAmt)));
                        if (GnrlAmtid.text() != 0.00) {
                            var temp = parseFloat(DiffAmtid.text()) / parseFloat(GnrlAmtid.text());
                            var tempprg = parseFloat(temp) * 100;
                            DiffPcg.text(tempprg.toFixed(2));
                        }
                    }
                });
            }
            else {

            }
        }
        function rateCompare(txtAmount, cprtAmount, GeneralAmt, rowindex, chkid) {
            // debugger;
            var objVar28 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_28") == null ? "Genral Rate is Not Applied" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_28");
            var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");
            var objVar24 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_24") == null ? "Please Ensure the Entered Amount is Greater than CPRT Rate" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_24");
            var objVar22 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_22") == null ? "Please Enter a Amount" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_22");

            var txtAmt = document.getElementById(txtAmount).value;
            if (txtAmt != "") {
                txtAmt = parseFloat(txtAmt);
                $("#<%=gvRatesMaster.ClientID %> tr").each(function() {
                    //Skip first(header) row
                    if (!this.rowIndex) return;
                    if (this.rowIndex == parseInt(rowindex) + 1) {
                        var tr = $(this).closest("tr");
                        var GnrlAmtid = $(tr).find("span[id*=lblGeneralAmount]");
                        var DiffAmtid = $(tr).find("span[id*=lblDiffAmount]");
                        var DiffPcg = $(tr).find("span[id*=lblDiffPercentage]");
                        DiffAmtid.text(parseFloat(parseFloat(GnrlAmtid.text()) - parseFloat(txtAmt)));
                        if (GnrlAmtid.text() != 0.00) {
                            var temp = parseFloat(DiffAmtid.text()) / parseFloat(GnrlAmtid.text());
                            var tempprg = parseFloat(temp) * 100;
                            DiffPcg.text(tempprg.toFixed(2));
                        }
                    }
                });
                if (GeneralAmt == '0') {
                    if (txtAmt > GeneralAmt) {
                        // alert('Genral Rate is Not Applied');
                        ValidationWindow(objVar28, objAlert);

                        document.getElementById(txtAmount).value = '0.00';
                        document.getElementById('hdnSelectGen').Value = 'Y';
                        var a = document.getElementById('hdnSelectGen').Value = 'Y';
                        if (a == 'Y') {
                            UncheckselGen();
                        }
                        return false;
                    }

                }
                if (txtAmt < cprtAmount) {
                    //if (txtAmt < 5000) {
                    //                    var r = confirm("Please Ensure the Entered Amount is Greater than CPRT Rate");
                    var r = confirm(objVar24);
                    if (r == true) {
                        return true;
                    }
                    else {
                        document.getElementById(txtAmount).focus();
                        return false;
                    }
                    //return false;
                }
            }
            else {
                //alert('Please Enter Amount');  andrews
                ValidationWindow(objVar22, objAlert);
                //document.getElementById(txtAmount).focus();
                //return false;
            }

        }


        function UncheckselGen() {
            $("#divgv table tr").each(function() {

                var tr = $(this).closest("tr");
                if ($(tr).find("input:text[id$=txtAmount]").val() != undefined) {
                    var chk = $(tr).find("input:checkbox[id$=chkBox]").attr('checked') ? true : false;
                    if (chk == true) {
                        $(tr).find("input:checkbox[id$=chkBox]").attr('checked', false);
                    }
                }
            });
        }

        function split_AmountValidation() {

            //var FeeAmount = document.getElementById('<%= txtFeeTypeAmount.ClientID %>').value;
            var FeeAmount = Number(ToInternalFormat($('#txtFeeTypeAmount')));
            var FeeTypeAttriID = document.getElementById('<%= hdnFeeTypeServiceID.ClientID %>').value;
            var FeeOP = document.getElementById('<%=chkOP.ClientID %>');
            var FeeIP = document.getElementById('<%=chkIP.ClientID %>');


            if (FeeAmount > 0 && FeeTypeAttriID > 0) {
                var RowEdit = '';

                if (document.getElementById('btnAdd').value == 'Update') {
                    RowEdit = document.getElementById('hdnRowEdit').value;
                }
                var a = document.getElementById('<%= hdnTempValue.ClientID %>').value;
                var b = a.split('$');
                var SplitAmount = document.getElementById('<%= hdnFeeSplitAmount.ClientID %>').value.split('$');
                var OPAmount = 0;
                var IPAmount = 0;


                var x = document.getElementById(b[0]).value.split("^");
                for (i = 0; i < x.length; i++) {

                    if (x[i] != "") {

                        if (x[i] != RowEdit) {

                            var y = x[i].split('~');

                            if (y[2] == 'OPIP') {
                                IPAmount = parseFloat(IPAmount) + parseFloat(y[4]);
                                OPAmount = parseFloat(OPAmount) + parseFloat(y[4]);
                            } else if (y[2] == 'OP') {
                                OPAmount = parseFloat(OPAmount) + parseFloat(y[4]);
                            } else {
                                IPAmount = parseFloat(IPAmount) + parseFloat(y[4]);
                            }
                        }
                    }

                }

                if (FeeOP.checked == true && FeeIP.checked == true) {

                    IPAmount = parseFloat(IPAmount) + parseFloat(FeeAmount);
                    OPAmount = parseFloat(OPAmount) + parseFloat(FeeAmount);

                }
                else if (FeeOP.checked == true) {

                    OPAmount = parseFloat(OPAmount) + parseFloat(FeeAmount);

                }
                else if (FeeIP.checked == true) {

                    IPAmount = parseFloat(IPAmount) + parseFloat(FeeAmount);
                }
                var objVar20 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_20") == null ? "Amount Mismatch" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_20");
                var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");

                if (OPAmount > parseFloat(SplitAmount[0]) || IPAmount > parseFloat(SplitAmount[1])) {

                    var userMsg = SListForApplicationMessages.Get('Admin\\RatesUpdation.aspx_23');

                    if (userMsg != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg, objAlert);
                    }
                    else {
                        //alert('Amount Mismatch');
                        ValidationWindow(objVar20, objAlert);
                        document.getElementById('<%= txtFeeTypeAmount.ClientID %>').focus();
                    }
                    return false;
                }

                else {
                    return true;
                }
            }
        }

        function Clear() {
            document.getElementById('<%= txtFeeTypeAmount.ClientID %>').value = "";
            document.getElementById('<%= txtFeetypeSerive.ClientID %>').value = "";
            document.getElementById('hdnFeeTypeServiceID').value = "0";

            //document.getElementById('<%=btnAdd.ClientID %>').value = 'Add';
        }

        function fnLoadVendorType(pType) {
            var objVar25 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_25") == null ? "--Select--" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_25");
            //debugger;
            var OrgVal = document.getElementById("drpTrustedOrg").value;
            //var DDLRateControls = document.getElementById("ddlRateCard");
            var DDLVendorType = document.getElementById("drpVendorType");
            var plist = document.getElementById('hdnVendorType').value.split('$');
            DDLVendorType.options.length = 0;
            var optn = document.createElement("option");
            DDLVendorType.options.add(optn);
            //            optn.text = "--Select--";
            optn.text = objVar25;
            optn.value = "0"; 

//            
            if (pType != "Svr") {
                document.getElementById("ddlSubtype").value = 0;
                //document.getElementById("ddlRateCard").value = 0;
                document.getElementById("ddlFeeType").value = 0;
                document.getElementById("ddlMappingItems").value = 0;
                document.getElementById("ddlMoreOption").value = 0;
                document.getElementById("ddlSubMore").value = 0;
                
                document.getElementById('hdnVendorTypeID').value = "0";
            }

            if (OrgVal != "0") {
                for (var i = 0; i < plist.length - 1; i++) {
                    var Vtype = plist[i].split('#');
                    {
                        var optn = document.createElement("option");
                        DDLVendorType.options.add(optn);
                        optn.text = Vtype[1];
                        optn.value = Vtype[0];
                    }
                }
            }
            if (document.getElementById('hdnVendorTypeID').value != 0) {
                DDLVendorType.value = document.getElementById('hdnVendorTypeID').value;
            }
        }

        function fnloadRate(pType) {
            var objVar25 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_25") == null ? "--Select--" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_25");

            var plist = "";
            var OrgVal = document.getElementById("drpVendorType").value;
            var DDLVendorType = document.getElementById("ddlSubtype");
            if (OrgVal == "Normal") plist = document.getElementById('hdnSubTypeNormal').value.split('$');
            else if (OrgVal == "Special") plist = document.getElementById('hdnSubTypeSpecial').value.split('$');
            else if (OrgVal == "Vendor") plist = document.getElementById('hdnSubTypeVendor').value.split('$');
            DDLVendorType.options.length = 0;
            var optn = document.createElement("option");
            DDLVendorType.options.add(optn);
            //            optn.text = "--Select--";
            optn.text = objVar25;
            optn.value = "0";
         
            document.getElementById('txtRateCard').value = "";

            if (pType != "Svr") {
                document.getElementById('hdnRateNames').value = "";            
                document.getElementById('hdnVendorTypeID').value = "0";
            }
            if (OrgVal != "0") {
                for (var i = 0; i < plist.length - 1; i++) {
                    var Vtype = plist[i].split('#');
                    {
                        var optn = document.createElement("option");
                        DDLVendorType.options.add(optn);
                        optn.text = Vtype[1];
                        optn.value = Vtype[0];
                    }
                }
            }
            if (document.getElementById('hdnVendorTypeID').value != 0) {
                DDLVendorType.value = document.getElementById('hdnVendorTypeID').value;
            }
        }



        function fnloadRateSubType(pType) {
            var OrgVal = document.getElementById("drpTrustedOrg").value;

//            var DDLTrusRateControls = document.getElementById("txtCopyToRate");
            var DDLVendorType = document.getElementById("drpVendorType");
            var DDLVendorTypeSub = document.getElementById("ddlSubtype");

            document.getElementById('hdnSubRatetype').value = DDLVendorTypeSub.value
//            DDLTrusRateControls.options.length = 0;
//            var optn = document.createElement("option");
//            DDLTrusRateControls.options.add(optn);

//            optn.text = "--Select--";
//            optn.value = "0";
            if (pType != "Svr") {
                document.getElementById('hdnRateID').value = 0;
                document.getElementById("ddlCopypTrustedOrg").value = 0;
            }
            document.getElementById('hdnVendorTypeID').value = DDLVendorType.value;
            var plist = document.getElementById('hdnAllRateNames').value.split('^');
            document.getElementById('txtRateCard').value = "";  

            if (document.getElementById('hdnRateNames').value != "") {
                document.getElementById('hdnRateID').value = document.getElementById('hdnRateNames').value;
                document.getElementById("txtRateCard").value = document.getElementById('hdnRateName').value;
            }

            subType = document.getElementById('ddlSubtype').value;
            GetChosen();
        }




        //--------------end------------------------
      
    </script>

    <script type="text/javascript">

        function ToInternalFormat(pControl) {
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

        /// added by Einstien castro
        function fnGetText(ele) {
            if ($.trim($(ele).val()) == '') {
                $('#btnSearch').click();
                document.getElementById('<%=txtsearch.ClientID %>').focus();
            }
        }
        function ValidateCopyRates() {
            var objVar26 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_26") == null ? "Choose the Filter Options!" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_26");
            var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");

            var Organization = document.getElementById('ddlCopypTrustedOrg').value;
            var RateType = document.getElementById('txtCopyToRate').value;
            if (Organization == "0" || RateType == "") {
                //alert('Choose the Filter Options!');
                ValidationWindow(objVar26, objAlert);

                return false;
            }
            else {
                return true;
            }
        }
        
    </script>

    <script type="text/javascript">

        function fnLoadVendorType1(pType) {
            var objVar25 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_25") == null ? "--Select--" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_25");

            var OrgVal = document.getElementById("ddlCopypTrustedOrg").value;
//            var DDLRateControls = document.getElementById("txtCopyToRate");
            var DDLVendorType = document.getElementById("ddlCopyRateType");
            var plist = document.getElementById('hdnVendorType').value.split('$');
            DDLVendorType.options.length = 0;
            var optn = document.createElement("option");
            DDLVendorType.options.add(optn);
            //            optn.text = "--Select--";
            optn.text = objVar25;
            optn.value = "0";
            if (pType != "Svr") {
                document.getElementById("ddlCopyRateType").value = 0;
                document.getElementById("txtCopyToRate").value = ""; 
                document.getElementById("ddlrateMapping").value = 0;
                document.getElementById("txtAddReduce").value = "0.00";
            
                document.getElementById('hdnVendorTypeID1').value = "0";
            }


//            DDLRateControls.options.length = 0;
//            var optnRate = document.createElement("option");
//            DDLRateControls.options.add(optnRate);
//            optnRate.text = "--Select--";
//            optnRate.value = "0";

            if (OrgVal != "0") {
                for (var i = 0; i < plist.length - 1; i++) {
                    var Vtype = plist[i].split('#');
                    {
                        var optn = document.createElement("option");
                        DDLVendorType.options.add(optn);
                        optn.text = Vtype[1];
                        optn.value = Vtype[0];
                    }
                }
            }
            if (document.getElementById('hdnVendorTypeID1').value != 0) {
                DDLVendorType.value = document.getElementById('hdnVendorTypeID1').value;
            }
        }


        //General Utilities
        if (!Array.prototype.unique) {
            Array.prototype.uniqueNames = function() {

                var nArr = [],
                oLen = this.length,
                dup, x, y;

                for (x = 0; x < oLen; x++) {
                    dup = undefined;

                    for (y = 0; y < nArr.length; y++) {
                        if (this[x] === nArr[y]) {
                            dup = 1;
                            break;
                        }
                    }

                    if (!dup) { nArr.push(this[x]); }
                }
                return nArr;
            };
        }
    </script>

    <script type="text/javascript">
        var config = {
            '.chosen-select': {},
            '.chosen-select-deselect': { allow_single_deselect: true },
            '.chosen-select-no-single': { disable_search_threshold: 10 },
            '.chosen-select-no-results': { no_results_text: 'Oops, nothing found!' },
            '.chosen-select-width': { width: "95%" }
        }

        for (var selector in config) {
            $(selector).chosen(config[selector]);
        }
    </script>

    <script type="text/javascript">
        function GetHdnValue() {
            var ddlReport = document.getElementById("txtRateCard").value;
            $(".chosen-select").chosen({
                disable_search_threshold: 10,
                no_results_text: "No Match Record Found !!!",
                width: "95%"
            });
            var RateName = Text;

        }
    </script>

    <script type="text/javascript">
        function GetChosen() {
            var config = {
                '.chosen-select': {},
                '.chosen-select-deselect': { allow_single_deselect: true },
                '.chosen-select-no-single': { disable_search_threshold: 10 },
                '.chosen-select-no-results': { no_results_text: 'Oops, nothing found!' },
                '.chosen-select-width': { width: "95%" }
            }
            for (var selector in config) {
                $(selector).chosen(config[selector]);
            }
            $(".chosen-select").val('').trigger("chosen:updated");
        }
    </script>

    <script type="text/javascript">
        var Flag = 0;
        $(function() {
            $('[id^="tabContent"]').hide();
            $('#tabManageRates').addClass('active');
            $('#tabContentManageRates').show();
            //   $('#tabContentAttachDocuments').show();
        });
        function ShowTabContent(tabId, DivId) {
            if (Flag == 1 && document.getElementById('txtRateCard').value != "") {

                $('[id^="tabContent"]').hide();
                $('#TabsMenu li').removeClass('active');
                $('li#' + tabId).addClass('active');
                $('#' + DivId).show();
                if (DivId == 'tabContentAttachDocuments') {
                    LoadLabelValue();
                    loadDocDetail();
                    $('#fileToUpload').show();
                }
                else {
                    $('#fileToUpload').hide();
                }
                // return false;
            }
            else {
                return false;
            }
        }
        SetReadOnly();
        Hide();
        function Hide() {
            document.getElementById('ddlMoreOption').style.display = 'none';
            document.getElementById('ddlSubMore').style.display = 'none';
            document.getElementById('lblMore').style.display = 'none';
            document.getElementById('lblMoreOp').style.display = 'none';
            document.getElementById('label50').style.display = 'none';

        }
        function Show() {
            document.getElementById('ddlMoreOption').style.display = 'inline-block';
            document.getElementById('ddlSubMore').style.display = 'inline-block';
            document.getElementById('lblMore').style.display = 'inline-block';
            document.getElementById('lblMoreOp').style.display = 'inline-block';
            document.getElementById('label50').style.display = 'inline-block';
        }
        function SetTabReadOnly() {
            toggleDisabled(document.getElementById("TabsMenu"));
        }
        function SetReadOnly() {
            toggleDisabled(document.getElementById("tblCopyAction"));
        }
        function toggleDisabled(el) {
            try {
                el.disabled = el.disabled ? false : true;
            }
            catch (E) {
            }
            if (el.childNodes && el.childNodes.length > 0) {
                for (var x = 0; x < el.childNodes.length; x++) {
                    toggleDisabled(el.childNodes[x]);
                }
            }
        }

        function FnChkCopyingActions(chk_bx) {
            
                SetReadOnly();
        }
        function ChkUncheck() {
            Flag = 1;
            document.getElementById("ChkCopyingActions").checked = false;
            if (document.getElementById('ddlFeeType').value == 'INVESTIGATION_GROUP_FEE' || document.getElementById('ddlFeeType').value == 'INVESTIGATION_FEE' || document.getElementById('ddlFeeType').value == 'HEALTH_PACKAGE') {
                Show();

            }
            else {
                Hide();
            }
        }

        function LoadLabelValue() {
            document.getElementById('lblOrg').innerHTML = document.getElementById('drpTrustedOrg').options[document.getElementById('drpTrustedOrg').selectedIndex].text;
            document.getElementById('lblVendorType').innerHTML = document.getElementById('drpVendorType').options[document.getElementById('drpVendorType').selectedIndex].text;
            document.getElementById('lblSubType').innerHTML = document.getElementById('ddlSubtype').options[document.getElementById('ddlSubtype').selectedIndex].text;
            document.getElementById('lblRate').innerHTML = document.getElementById('txtRateCard').value;
            document.getElementById('lblFeeType').innerHTML = document.getElementById('ddlFeeType').options[document.getElementById('ddlFeeType').selectedIndex].text;
            if (document.getElementById('ddlMappingItems').value == 0) {
                document.getElementById('lblMapping').innerHTML = "All";
            }
            else {
                document.getElementById('lblMapping').innerHTML = document.getElementById('ddlMappingItems').options[document.getElementById('ddlMappingItems').selectedIndex].text;
            }
            if (document.getElementById('ddlSubMore').value == 0) {
                document.getElementById('lblMoreOp').innerHTML = "All";
            }
            else{
            document.getElementById('lblMoreOp').innerHTML = document.getElementById('ddlSubMore').options[document.getElementById('ddlSubMore').selectedIndex].text;
            }
        }
        
    </script>
    <script type="text/javascript">

        $(document).ready(function() {
        var objVar39 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_39") == null ? "The selected file" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_39");
        var objVar40 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_40") == null ? "already added" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_40");
var objAlert=SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert")== null ?"Alert":SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");
 

            var FilePath = '<%=sFilePath%>';
            var OrgId = '<%=OrgID%>';
            var FileUploadPath = FilePath.replace(/-/g, "\\\\");
            $(document).on('click', '.ClsAdd', function() {
                var UploadFileName1 = $("#fileToUpload").val().split('\\').pop().replace(/\s+/g, '');
                var UploadFileName; var UploadFileNameExt;
                if ($("#txtFilename").val() != "" && $("#fileToUpload").val() != "") {
                    var ext = UploadFileName1.split('.').pop();
                    UploadFileName = $("#txtFilename").val() + '.' + ext;
                    UploadFileNameExt = $("#txtFilename").val();
                }
                else {
                    UploadFileName = $("#fileToUpload").val().split('\\').pop().replace(/\s+/g, '');
                    UploadFileNameExt = UploadFileName.substr(0, UploadFileName.lastIndexOf('.')) || UploadFileName;
                }
                if (UploadFileName != "") {

                    if ($("#ListFiles option[value='" + UploadFileNameExt + "']").length > 0) {
                        //alert('The selected file ' + ' ' + UploadFileNameExt + ' already added');
                        ValidationWindow(objVar39 + ' ' + UploadFileNameExt + objVar40,);
                    }
                    else {

                        $('#ListFiles').append(' <option value="' + UploadFileNameExt + '">' + UploadFileName + '</option> ');
                        var FilesList = "<div id='" + UploadFileNameExt + "'><label class='lh25 textwrap'>" + UploadFileName + "</label><img title='Click to Download' alt='Click to Download' class='btnDownloadRate pull-right' src='../Images/download1.png' /><img title='Click to Delete' alt='Click to Delete' class='btndeleteRate pull-right' src='../Images/delete11.png' /></div>"
                        $(FilesList).appendTo('#divFiles');

                        if (!isAjaxUploadSupported()) { //IE fallfack
                            var iframe = document.createElement("<iframe name='upload_iframe' id='upload_iframe'>");
                            iframe.setAttribute("width", "0");
                            iframe.setAttribute("height", "0");
                            iframe.setAttribute("border", "0");
                            iframe.setAttribute("src", "javascript:false;");
                            iframe.style.display = "none";

                            var form = document.createElement("form");
                            form.setAttribute("target", "upload_iframe");
                            form.setAttribute("action", "../FileUpload.ashx?Filepath=" + FileUploadPath + "&Filename=" + UploadFileName);
                            form.setAttribute("method", "post");
                            form.setAttribute("enctype", "multipart/form-data");
                            form.setAttribute("encoding", "multipart/form-data");
                            form.style.display = "inline-block";
                            form.style.left = "168px";
                            form.style.bottom = "150px";
                            form.style.position = "absolute";
                            var files = document.getElementById("fileToUpload");
                            form.appendChild(files);
                            document.body.appendChild(form);
                            document.body.appendChild(iframe);
                            iframeIdmyFile = document.getElementById("upload_iframe");
                            form.submit();
                            var uplctrl = document.getElementById("fileToUpload");
                            uplctrl.select();
                           // clrctrl = uplctrl.createTextRange();
                            //clrctrl.execCommand('delete');
                            uplctrl.focus();
                            $('#fileToUpload').replaceWith($('#fileToUpload').clone());
                            
                            return false;
                        }
                        else {
                            AddtoFolder(UploadFileName);
                            $('#fileToUpload').val("");
                        }
                        return false;
                    }
                }
                else
                    var objVar38 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_38") == null ? "Please Add File" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_38");
                var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");

                //alert('Please Add File');
                ValidationWindow(objVar38, objAlert);
                return false;
            });


            function isAjaxUploadSupported() {
                var input = document.createElement("input");
                input.type = "file";
                return (
		        "multiple" in input &&
		            typeof File != "undefined" &&
		            typeof FormData != "undefined" &&
		            typeof (new XMLHttpRequest()).upload != "undefined");
            }


            function getIframeContentJSON(iframe) {
                //IE may throw an "access is denied" error when attempting to access contentDocument on the iframe in some cases
                try {
                    // iframe.contentWindow.document - for IE<7
                    var doc = iframe.contentDocument ? iframe.contentDocument : iframe.contentWindow.document;
                    var response;
                    var innerHTML = doc.body.innerHTML;
                    //plain text response may be wrapped in <pre> tag
                    if (innerHTML.slice(0, 5).toLowerCase() == "<pre>" && innerHTML.slice(-6).toLowerCase() == "</pre>") {
                        innerHTML = doc.body.firstChild.firstChild.nodeValue;
                    }
                    //  response = eval("(" + innerHTML + ")");
                    response = { success: true };
                } catch (err) {
                    response = { success: false };
                }

                return response;
            }

            function AddtoFolder(UploadFileName) {
                var fileUpload = $("#fileToUpload").get(0);
                var files = fileUpload.files;
                var FileDetails = new FormData();
                for (var i = 0; i < files.length; i++) {
                    FileDetails.append(files[i].name, files[i]);
                }
                var FileDetails;
                $.ajax({
                    url: "../FileUpload.ashx?OrgID=" + OrgId + "&Filepath=" + FileUploadPath + "&Filename=" + UploadFileName,
                    type: "POST",
                    contentType: false,
                    processData: false,
                    data: FileDetails,
                    success: function(result) {
                    },
                    error: function(err) {
                        alert(err.statusText);
                    }
                });
            };

            function DownloadFile(DownloadFileName) {
                $.ajax({
                    url: '../DownloadFile.ashx?OrgID=' + OrgId + '&Filename=' + DownloadFileName + '&Filepath=' + FileUploadPath,
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function(response) {
                        if (isNaN(response.d) == true) {
                            $('#iframe').attr('src', '../DownloadFile.ashx?OrgID=' + OrgId + '&Filename=' + DownloadFileName + '&Filepath=' + FileUploadPath);
                            $('#iframe').load();
                        }
                        else {
                            alert(response.d);
                        }
                    },
                    error: function(err) {
                        alert(err.statusText);
                    }
                });
            };

            //==== Method to delete a record
            function deleteRecord(RemoveItems) {
                var objVar37 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_37") == null ? "Are you sure to delete a record?" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_37");

                var ans = confirm(objVar37);
                var type = 'Delete';
                var searchtext = RemoveItems;
                if (ans == true) {
                    $.ajax({
                        type: "POST",
                        url: "RatesUpdation.aspx/RemoveDocDetails",
                        data: "{'searchtext':'" + searchtext + "','type': '" + type + "' }",
                        contentType: "application/json; charset=utf-8",
                        datatype: "json",
                        success: function(response) {
                            $('#' + RemoveItems + '').remove();
                            $("#ListFiles option[value='" + RemoveItems + "']").remove();
                            //  alert('Record successfully delete');
                        },
                        error: function(response) {
                            alert(response.status + ' ' + response.statusText);
                        }
                    });
                }
                else {
                    return false;
                }
            }

            //==== Method to save a record
            function SaveDocDetail(saveDetails) {
                var objVar35 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_35") == null ? "Select the Reason" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_35");
                var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");
                var objVar36 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_36") == null ? "The record has been successfully saved" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_36");

                if ($('#ddlAttachReason').val() != 0) {
                    var StrReason;
                    if ($('#ddlAttachReason').val() == 1) {
                        StrReason = $("#ddlAttachReason option:selected").text() + '(' + $('#txtAddReason').val() + ')';
                    }
                    else {
                        StrReason = $("#ddlAttachReason option:selected").text();
                    }

                    $.ajax({
                        type: "POST",
                        url: "RatesUpdation.aspx/SaveTypeDetails",
                        data: "{'lstInvestigationDetail':'" + saveDetails + "','UpdateDate':'" + $('#tDOB').val() + "','Reason':'" + StrReason + "' }",
                        contentType: "application/json; charset=utf-8",
                        datatype: "json",
                        success: function(data) {
                            var GetData = data.d;
                            // alert('The record has been successfully saved');
                            ValidationWindow(objvar36, objAlert);

                            $('#divFiles').empty();
                            $("#ListFiles").empty();
                            $("#txtFilename").val('');
                            $("#txtAddReason").val('');
                            $("#fileToUpload").val('');
                            $("#ddlAttachReason").val(0);
                            ShowTabContent('tabManageRates', 'tabContentManageRates')
                            return false;
                        },
                        error: function(response) {
                            alert(response.status + ' ' + response.statusText);
                        }
                    });
                }
                else {
                    //alert('Select the Reason');
                    ValidationWindow(objvar35, objAlert);

                    return false;
                }
            }


            //Download  button Click in Second tab
            $(document).on('click', '.btnDownloadRate', function() {
                var DownloadFileName;
                var DownFile = $(this).parent().attr('id')
                $('#ListFiles option').each(function() {
                    if (DownFile == $(this).val())
                        DownloadFileName = $(this).text();
                });
                DownloadFile(DownloadFileName);
            });

            //Delete button Click in Second tab
            $(document).on('click', '.btndeleteRate', function() {
                var RemoveItems = $(this).parent().attr('id');
                deleteRecord(RemoveItems);

            });

            //save  button Click in Second tab
            $(document).on('click', '.btnsaveRate', function() {
                var StrRateId = $('#hdnRateNames').val().split('~')[1];
                var RateName = $("#ddlFeeType").find("option:selected").text();
                if ($("#ListFiles option").length > 0) {
                    var obj = [];
                    $('#ListFiles option').each(function() {
                        var DocUrl = FileUploadPath + '\\\\' + $(this).text();
                        var tmptest = {
                            'DocFileIds': '',
                            'DocFileName': $(this).text(),
                            'DocFileUrl': DocUrl,
                            'IdentifyingType': RateName,
                            'IdentifyingId': StrRateId
                        };
                        obj.push(tmptest)

                    });
                    var jsonString = JSON.stringify(obj);
                    SaveDocDetail(jsonString)
                    return false;

                };
            });

            var objVar34 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_34") == null ? "Allowed file size exceeded. (Max.1 MB)" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_34");
            var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");


            //binds to onchange event of your input field
            $('#fileToUpload').bind('change', function() {
                // var f = document.querySelector("input[type='file']");
                var f = this.files[0];
                if (f.size > 1048576 || f.fileSize > 1048576) {
                    // alert('Allowed file size exceeded. (Max.1 MB)')
                    ValidationWindow(objVar34, objAlert);

                    this.value = null;
                }
            });

        });


        function loadDocDetail() {
           
            var objVar33 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_33") == null ? "No matching records found" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_33");
            var objVar31 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_31") == null ? "No Match" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_31");

            var StrRateId = 0;
            if ($('#hdnRateNames').val().split('~')[1] != 'undefined') StrRateId = $('#hdnRateNames').val().split('~')[1];
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "RatesUpdation.aspx/GetUploadDocDetails",
                data: "{'FileDetails':'" + StrRateId + "'}",
                dataType: "json",
                success: function(data) {
                    if (data.d.length > 0) {
                        $('#ListFiles').text("");
                        $('#ListFiles').val("");
                        $('#divFiles').empty();
                        var returnedData = JSON.parse(data.d);
                        $.each(returnedData, function(index, returnedData) {
                            var url = returnedData.DocFileUrl;
                            var filename = returnedData.DocFileName.substr(0, returnedData.DocFileName.lastIndexOf('.')) || returnedData.DocFileName;
                            $('#ListFiles').append(' <option value="' + filename + '">' + returnedData.DocFileName + '</option> ');
                            var FilesList = "<div id='" + filename + "'><label class='lh25 textwrap'>" + returnedData.DocFileName + "</label><img title='Click to Download' alt='Click to Download' class='btnDownloadRate pull-right' src='../Images/download1.png' /><img title='Click to Delete' alt='Click to Delete' class='btndeleteRate pull-right' src='../Images/delete11.png' /></div>"
                            $(FilesList).appendTo('#divFiles');
                        });

                    }
                    else {
                        //alert('No matching records found');
                        ValidationWindow(objVar33, objAlert);
                    }
                },
                error: function(result) {
                //                    alert('No Match');
                ValidationWindow(objVar31, objAlert);
                }
            });
        }

    </script>

    <script type="text/javascript">
        var OrgId1 = '<%=OrgID%>';
        var lstDetails = '<%=strout%>';
        var subType;
        function pageLoad() {
        var objVar29=SListForAppMsg.Get("Admin_RatesUpdation_aspx_29")== null ?"Failed to load names":SListForAppMsg.Get("Admin_RatesUpdation_aspx_29");
var objAlert=SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert")== null ?"Alert":SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");
        var objVar30 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_30") == null ? "Select the Rate Sub Type" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_30");
        var objVar31 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_31") == null ? "No Match" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_31");
        var objVar32 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_32") == null ? "No records found" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_32");
        var objAlert = SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");
        var objVar29 = SListForAppMsg.Get("Admin_RatesUpdation_aspx_29") == null ? "Failed to load names" : SListForAppMsg.Get("Admin_RatesUpdation_aspx_29");
            var objVarsel = SListForAppDisplay.Get("Admin_RatesUpdation_aspx_01") == null ? "--Select--" : SListForAppDisplay.Get("Admin_RatesUpdation_aspx_01");
            //txtCopyToRate AutoComplete
            $("#txtCopyToRate").autocomplete({
                //            if ($('#ddlCopyRateType').val() != 0) {
                source: function(request, response) {
                    $.ajax({
                        type: "POST",
                        url: "RatesUpdation.aspx/GetCopyFromRateName",
                        data: "{'OrgId':'" + $('#ddlCopypTrustedOrg').val() + "','RateType':'" + $('#ddlCopyRateType').val() + "','txtSearchName':'" + $('#txtCopyToRate').val() + "' }",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function(data) {
                            var returnedData = JSON.parse(data.d);
                            response($.map(returnedData, function(item) {
                                return {
                                    label: item.ButtonName,
                                    val: item.ContextType
                                }
                            }))
                        },
                        error: function(result) {
                           // alert('Failed to load names');
                           ValidationWindow(objvar29, objAlert);

                        }
                    });
                },
                select: function(e, i) {
                    $('#hdnFromClient').val(i.item.val);

                },
                minLength: 1
                //              }
            });
            //txtRateCard AutoComplete
           

            $("#txtAddReason").hide();
            $("#ddlAttachReason").change(function() {
                if ($("#ddlAttachReason").val() == 1) {
                    $("#txtAddReason").show();
                }
                else {
                    $("#txtAddReason").hide();
                }
            });

            $("#ddlMoreOption").change(function() {
                if ($(this).val() != 0) {
                    LoadDept(0);
                }
                else {
                    $("#ddlSubMore").get(0).options.length = 0;
                    $("#ddlSubMore").get(0).options[0] = new Option(objVarsel, "0");
                }
            });
            $("#ddlSubMore").change(function() {
                $("#hdnDept").val($(this).val());
                if ($(this).val() == 0) {
                    $("#hdnDeparment").val(null);
                }
                else {
                    $("#hdnDeparment").val($(this).val());
                }

            });

            $('#btnCancel23').click(function(e) {
                $('#divFiles').empty();
                $("#ListFiles").empty();
                $("#txtFilename").val('');
                $("#txtAddReason").val('');
                $("#fileToUpload").val('');
                $("#ddlAttachReason").val(0);
                loadDocDetail();
                $("#txtFilename").focus();
                return false;
            });
        }
        function LoadDept(Flag) {
        var objVar29=SListForAppMsg.Get("Admin_RatesUpdation_aspx_29")== null ?"Failed to load names":SListForAppMsg.Get("Admin_RatesUpdation_aspx_29");
var objAlert=SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert")== null ?"Alert":SListForAppMsg.Get("Admin_RatesUpdation_aspx_Alert");
            var objVarsel = SListForAppDisplay.Get("Admin_RatesUpdation_aspx_01") == null ? "--Select--" : SListForAppDisplay.Get("Admin_RatesUpdation_aspx_01");

            if ($('#ddlMoreOption').val() != 0) {
                $.ajax({
                    type: "POST",
                    url: "RatesUpdation.aspx/GetDepartment",
                    data: "{'OrgId':'" + OrgId1 + "' }",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(msg) {
                        $("#ddlSubMore").get(0).options.length = 0;
                        $("#ddlSubMore").get(0).options[0] = new Option(objVarsel, "0");

                        $.each(msg.d, function(index, item) {
                            $("#ddlSubMore").append($("<option></option>").val(item.DeptID).html(item.DeptName));
                        });
                        if (Flag == 1) {
                            var dd = $('#hdnDept').val();
                            $("#ddlSubMore").val(dd);
                        }
                    },
                    error: function() {
                        $("#ddlSubMore").get(0).options.length = 0;
                        $("#ddlSubMore").get(0).options[0] = new Option(objVarsel, "0");
                        //alert('Failed to load names');
                        ValidationWindow(objVar29, objAlert);
                    }
                });

            }
        }


       
    </script>
</body>
</html>
