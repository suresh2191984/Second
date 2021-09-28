<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreditDebitSummary.aspx.cs"
    Inherits="Reception_CreditDebitSummary" EnableEventValidation="false" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>--%>
<%@ Register Src="../CommonControls/DynamicDHEBAdder.ascx" TagName="OtherPayments"
    TagPrefix="uc14" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="PaymentType"
    TagPrefix="uc15" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%--<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/DateSelection.ascx" TagName="DateSelection" TagPrefix="DateCtrl" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>CreditDebitSummary</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--<link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />--%>
    <%--    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
    <%-- <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>
--%>
    <%--    <script src="../Scripts_New/bid.js" type="text/javascript"></script>--%>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <%--    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>--%>
    <link href="../StyleSheets_New/DHEBAdder.css" rel="Stylesheet" type="text/css" />
    <%--    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <%--  <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>--%>

    <script src="../Scripts/CommonBilling.js" type="text/javascript"></script>

    <style type="text/css">
        #ddlcredit
        {
            /* width: 60%; */
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">

    <script language="javascript" type="text/javascript">
        function OnselectedClientName(source, eventArgs) {
            document.getElementById('txtClientNameSrch').value = eventArgs.get_text();
            document.getElementById('<%=hdnclientName.ClientID %>').value = eventArgs.get_text();
            document.getElementById('<%=hdnCustomerType.ClientID %>').value = 'C';
            document.getElementById('<%=hdnClientID.ClientID %>').value = eventArgs.get_value();
            if (document.getElementById("<%=ddlcredit.ClientID%>").value == '0') {
                document.getElementById('hdnClientTypeID').value = '0';

            }
            else if (document.getElementById("<%=ddlcredit.ClientID%>").value == '1') {
                document.getElementById('hdnClientTypeID').value = '1';
            }
        }
        function OnselectedAuthorizeName(source, eventArgs) {
            document.getElementById('txtAuthorised').value = eventArgs.get_text();
            document.getElementById('<%=hdnAuthorised.ClientID %>').value = eventArgs.get_value();
            document.getElementById('<%=txtAuthorised.ClientID %>').value = eventArgs.get_text();
        }
        function IAmSelected() {

            var patient = eventArgs.get_value().split('~')
            var patientdetail = eventArgs.get_text().split('~');
            document.getElementById('hdnSelectedPatientID').value = patient[5];
        }
        function OnselectedClientName1(source, eventArgs) {
            document.getElementById('txtClientNameSearch').value = eventArgs.get_text();
            document.getElementById('<%=hdnclientName1.ClientID %>').value = eventArgs.get_text();
            document.getElementById('<%=hdnCustomerType.ClientID %>').value = 'C';
            document.getElementById('<%=hdnClientID1.ClientID %>').value = eventArgs.get_value();
            document.getElementById('hdnClientTypeID1').value = '0';
        }
        function PopUpPage() {
            var objVar01 = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_01") == null ? "Please select Credit/Debit details" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_01");
            var objAlert = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_Alert");

            var dDate = document.getElementById('<%= hdnDatecredit.ClientID %>').value;
            dAmount = document.getElementById('hdnAmount').value;
            var dReceiptNo = document.getElementById('<%= hdnReceiptNo.ClientID %>').value;
            var dBdetNo = document.getElementById('<%= hdnIPINterID.ClientID %>').value;
            var sptype = document.getElementById('<%= hdnCrDrType.ClientID %>').value;
            var pName = document.getElementById('<%= hdnPatientName.ClientID %>').value;
            var pNumber = document.getElementById('<%= hdnPatientNumber.ClientID %>').value;
            var pVisitId = document.getElementById('<%= hdnPVisitId.ClientID %>').value;
            var page = document.getElementById('<%= hdnAge.ClientID %>').value;
            var pPatientID = document.getElementById('<%= hdnPatientID.ClientID %>').value;
            var Customertype = document.getElementById('<%=hdnCustomerType.ClientID %>').value;
            var pClientID = document.getElementById('<%=hdnClientID.ClientID %>').value;
            var pClientName = document.getElementById('<%=hdnclientName.ClientID %>').value;
            var pDAmount = document.getElementById('<%=hdnAmountCredit.ClientID %>').value;
            var pCollectionType = document.getElementById('<%=hdnCollectiontype.ClientID %>').value;


            var pDate = document.getElementById('<%= hdnDatecredit.ClientID %>').value;
            var pClientId = document.getElementById('<%= hdnClientID.ClientID %>').value;
            var pClientName = document.getElementById('<%= hdnclientName.ClientID %>').value;
            var pAuthorizedby = document.getElementById('<%= hdnAuthorised.ClientID %>').value;
            var pReason = document.getElementById('<%= hdnReason.ClientID %>').value;
            var pCrDrType = document.getElementById('<%= hdnCrDrType.ClientID %>').value;
            var pReferenceID = document.getElementById('<%= hdnReferenceID.ClientID %>').value;
            var pReceiptNo = document.getElementById('<%= hdnreceiptno1.ClientID %>').value;
            var pClientType = document.getElementById('<%= hdnClientType.ClientID %>').value;
            var pAmount = document.getElementById('<%= hdnAmountCredit.ClientID %>').value;
            var ReceiptNo = document.getElementById('<%= hdnReceiptNoCredit.ClientID %>').value;
            var ddltypeCredit = document.getElementById('<%= hdnddltypeCredit.ClientID %>').value;
            var hdnClientAddress = document.getElementById('<%= hdnAddress.ClientID %>').value;
            var hdnremark = document.getElementById('<%= hdnremarks.ClientID %>').value;
            var hdnreasoncr = document.getElementById('<%= hdnreasoncredit.ClientID %>').value;
            //            var CrDR = document.getElementById('<%= hdnCreditValue.ClientID %>').value;
            if (document.getElementById('<%= hdnClientID.ClientID %>').value != '') {


                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
                strFeatures = strFeatures + ",left=0,top=0";
                var strURL = "PrintCreditDebitNote.aspx?rcptno=" + ReceiptNo + "&ClientID=" + pClientId + " &Amount=" + pAmount + " &ClientType=" + pClientType + " &ReferenceID=" + pReferenceID + "&CrDrType=" + pCrDrType + "&Reason=" + pReason + "&Authorizedby=" + pAuthorizedby + "&ClientName=" + pClientName + "&pDate=" + pDate + "&DddltypeCredit=" + ddltypeCredit + "&CollectionType=" + pCollectionType + " &hdnCAddress=" + hdnClientAddress + " &hdnremarks=" + hdnremark + " &hdnreasoncred=" + hdnreasoncr + " &IsPopup=Y";
                window.open(strURL, "", strFeatures, true);
                var ConValue = "OtherCurrencyDisplay1";
            }
            else {
                //alert('Please select Credit/Debit details');
                ValidationWindow(objVar01, objAlert);

                return false;
            }


        }

        function ClearScriptDatas() {
            document.getElementById('<%= hdnAmount.ClientID %>').value = "";
            document.getElementById('<%= hdnDate.ClientID %>').value = "";
            document.getElementById('<%= hdnNowPaid.ClientID %>').value = "";
            document.getElementById('<%= hdnReceiptNo.ClientID %>').value = "";
        }
        function closeData() {
        }
        function AmtValidate() {
            var objAlert = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_Alert");
            var objVar02 = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_02") == null ? "Add Deposite Amount" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_02");

            if (document.getElementById('txtPayment').value <= 0 || document.getElementById('txtPayment').value == '') {

                // alert('Add Deposite Amount');
                ValidationWindow(objVar02, objAlert);

                return false;
            }

            return true;
        }
        function checkForValues() {
            var objAlert = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_Alert");
            var objVar03 = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_03") == null ? "Provide page number" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_03");
            var objVar04 = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_04") == null ? "Provide correct page number" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_04");

            if (document.getElementById('<%=txtpageNo.ClientID %>').value == "") {
                //alert('Provide page number');
                ValidationWindow(objVar03, objAlert);

                return false;
            }
            if (Number(document.getElementById('<%=txtpageNo.ClientID %>').value) < Number(1)) {
                //alert('Provide correct page number');
                ValidationWindow(objVar04, objAlert);

                return false;
            }
            if (Number(document.getElementById('<%=txtpageNo.ClientID %>').value) > Number(document.getElementById('<%=lblTotal.ClientID %>').innerText)) {
                // alert('Provide correct page number');
                ValidationWindow(objVar04, objAlert);

                return false;
            }
            return true;
        }
        function SetCreditDebit(obj) {

            if (obj == "CR") {
                document.getElementById('<%=hdnSetCreditDebit.ClientID %>').value = 'Credit'.trim();
                //                document.getElementById('<%=hdnCreditValue.ClientID %>').value = "0";
                //
            }
            else if (obj == "DR") {
                document.getElementById('<%=hdnSetCreditDebit.ClientID %>').value = 'Debit'.trim();
                //                document.getElementById('<%=hdnCreditValue.ClientID %>').value = "1";
            }

        }
        function SetPatientClient() {

            if (document.getElementById("<%=ddlcredit.ClientID%>").value == '1') {
                var sval = "0";
                $find('AutoCompleteExtender1').set_contextKey(sval);
                document.getElementById('hdnClientTypeID').value = '0';
                document.getElementById('<%=hdnddltypeCredit.ClientID %>').value = 'Client';
                document.getElementById('<%=txtClientNameSrch.ClientID %>').value = '';
                document.getElementById('<%=TxtRefTypeNo.ClientID %>').value = '';
                document.getElementById('<%=TxtAmount.ClientID %>').value = '';
                document.getElementById('<%=TxtRemarks.ClientID %>').value = '';
                document.getElementById('<%=txtAuthorised.ClientID %>').value = '';
                var objSel = document.getElementById("ddltype");
                objSel.options[0] = new Option("---Select---", "0");
                objSel.options[1] = new Option("INVOICE NO", "1");
                objSel.options[2] = new Option("BILL NO", "2");
                objSel.options[3] = new Option("OTHERS", "3");



            }
            else if (document.getElementById("<%=ddlcredit.ClientID%>").value == '2') {
                var sval = "1";
                $find('AutoCompleteExtender1').set_contextKey(sval);
                document.getElementById('<%=hdnddltypeCredit.ClientID %>').value = 'Patient';
                document.getElementById('<%=txtClientNameSrch.ClientID %>').value = '';
                document.getElementById('<%=TxtRefTypeNo.ClientID %>').value = '';
                document.getElementById('<%=TxtAmount.ClientID %>').value = '';
                document.getElementById('<%=TxtRemarks.ClientID %>').value = '';
                document.getElementById('<%=txtAuthorised.ClientID %>').value = '';
                var objSel = document.getElementById("ddltype");
                for (i = objSel.length - 1; i >= 0; i--) {
                    if (objSel.options[i].selected) {
                        objSel.remove(i);
                    }
                }

                objSel.options[0] = new Option("---Select---", "0");
                objSel.options[1] = new Option("BILL NO", "2");
                objSel.options[2] = new Option("OTHERS", "3");

            }

        }
        function SetPatientClientSearch() {
            if (document.getElementById("<%=ddlcreditsearch.ClientID%>").value == '1') {
                var sval = "0";
                $find('AutoCompleteExtender2').set_contextKey(sval);
                document.getElementById('hdnClientTypeID').value = '0';
                document.getElementById('<%=hdnddltypeCreditsearch.ClientID %>').value = 'Client';



            }
            else if (document.getElementById("<%=ddlcreditsearch.ClientID%>").value == '2') {
                var sval = "1";
                $find('AutoCompleteExtender2').set_contextKey(sval);
                document.getElementById('<%=hdnddltypeCreditsearch.ClientID %>').value = 'Patient';
            }

        }

        function RequireValidate() {
            var objVar06 = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_06") == null ? "Please Select Type Name" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_06");
            var objAlert = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_Alert");
            var objVar07 = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_07") == null ? "Please Enter Valid Name" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_07");
            var objVar08 = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_08") == null ? "Please Enter Valid Authorizer Name" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_08");
            var objVar09 = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_09") == null ? "Please Select Ref Type Name" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_09");
            var objVar10 = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_10") == null ? "Please Enter Reference Number" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_10");
            var objVar11 = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_11") == null ? "Please Enter Amount" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_11");
            var objVar12 = SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_12") == null ? "Please Enter Valid ReferenceNo" : SListForAppMsg.Get("Reception_CreditDebitSummary_aspx_12");

            //debugger;
            var isMandatory = false;
            var message = "";
            if (document.getElementById("<%=ddlcredit.ClientID%>").value == "0") {
                //alert('Please Select Type Name');
                ValidationWindow(objVar06, objAlert);

                return false;
            }
            if (document.getElementById("<%=txtClientNameSrch.ClientID%>").value == "") {
                // alert('Please Enter Valid Name');
                ValidationWindow(objVar07, objAlert);
                document.getElementById('txtClientNameSrch').value = '';
                document.getElementById('txtClientNameSrch').focus();
                return false;
            }
            if (document.getElementById('hdnClientID').value == "") {
                // alert('Please Enter Valid Name');
                ValidationWindow(objVar07, objAlert);
                document.getElementById('txtClientNameSrch').value = '';
                document.getElementById('txtClientNameSrch').focus();
                return false;
            }
            if (document.getElementById('hdnAuthorised').value == "") {
                // alert('Please Enter Valid Authorizer Name');
                ValidationWindow(objVar08, objAlert);
                document.getElementById('txtAuthorised').value = '';
                document.getElementById('txtAuthorised').focus();
                return false;
            }
            if (document.getElementById("<%=ddltype.ClientID%>").value == "0") {
                //alert('Please Select Ref Type Name');
                ValidationWindow(objVar09, objAlert);
                return false;
            }
            if (document.getElementById("<%=ddltype.ClientID%>").value != "3") {
                if (document.getElementById("<%=TxtRefTypeNo.ClientID%>").value == "") {
                    //alert('Please Enter Reference Number');
                    ValidationWindow(objVar10, objAlert);
                    document.getElementById('TxtRefTypeNo').value = '';
                    document.getElementById('TxtRefTypeNo').focus();
                    return false;
                }
            }

            if (document.getElementById("<%=TxtAmount.ClientID%>").value == "") {
                //                message += "Please Enter Amount";
                //                isMandatory = true;

                //alert('Please Enter Amount');
                ValidationWindow(objVar11, objAlert);
                document.getElementById('TxtAmount').value = '';
                document.getElementById('TxtAmount').focus();
                return false;
            }
            var ClientID = document.getElementById('<%= hdnClientID.ClientID %>').value;
            var ClientType = document.getElementById('<%= ddltype.ClientID %>').value;
            var ReferenceID = document.getElementById('<%= TxtRefTypeNo.ClientID %>').value;
            var Type = document.getElementById('<%= ddlcredit.ClientID %>').value;
            var PatientID = document.getElementById('<%= hdnPatientID.ClientID %>').value;
            if (document.getElementById("<%=ddltype.ClientID%>").value != "3") {
                $.ajax({
                    type: "POST",
                    url: "../OPIPBilling.asmx/ClientValidation",
                    data: "{ 'WClientID': '" + ClientID + "','WClientType': '" + ClientType + "','WReferenceID': '" + ReferenceID + "','WType': '" + PatientID + "' ,'WPatientID': '" + Type + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        var lstinvoice = data.d;
                        if (lstinvoice.length <= 0) {
                            //                            message += "Please Enter Valid ReferenceNo";
                            message += objVar12;
                            isMandatory = true;
                            document.getElementById('TxtRefTypeNo').value = '';
                            document.getElementById('TxtRefTypeNo').focus();
                        }
                        else {
                            var lstinvoice = data.d[0].InvoiceID;
                            document.getElementById('<%= hdnReferenceNumber.ClientID %>').value = lstinvoice;
                        }
                    }
                });
            }
            if (isMandatory) {
                if (document.getElementById("<%=ddltype.ClientID%>").value != '3') {
                    //alert(message);
                    ValidationWindow(message, objAlert);

                    return false;
                    document.getElementById("<%=TxtRefTypeNo.ClientID%>").value == ""
                    document.getElementById('TxtRefTypeNo').focus();

                }
                else {
                    return true;
                }
            }
            else {
                return true;
            }
            //            var returnValue = CallClientValidation(pClientId, pClientType, pReferenceID);
            //            if (returnValue) {
            //                return returnValue;
            //            }

        }

        function SetTypeClient() {

            if (document.getElementById("<%=ddltype.ClientID%>").value == "3") {
                document.getElementById('imgstar').style.display = "none";
                document.getElementById('selectvalue').value = 'OTHERS';

            }
            else {
                document.getElementById('imgstar').style.display = "block";
                var ddltype1 = document.getElementById("<%=ddltype.ClientID%>").value;
                if (document.getElementById("<%=ddltype.ClientID%>").value == "1") {
                    document.getElementById('selectvalue').value = 'INVOICE NO';
                }
                if (document.getElementById("<%=ddltype.ClientID%>").value == "2") {
                    document.getElementById('selectvalue').value = 'BILL NO';
                }


            }
        }


        function CallPrintReceipt(ivale, Date, ClientId, ClientName, Authorizedby, Reason, CrDrType, BillNumber, ReferenceID, ReceiptNo, ClientType, Amount, Remarks, ReasonCredit, Address, ItemType) {
            var previousAmount = document.getElementById('<%= hdnAmountCredit.ClientID %>').value;
            var newAmount = 0;
            if (document.getElementById('<%= hdnPrevControl.ClientID %>').value != "") {
                var valPrevControl = document.getElementById(document.getElementById('<%= hdnPrevControl.ClientID %>').value);
                valPrevControl.checked = false;
            }
            document.getElementById('<%= hdnPrevControl.ClientID %>').value = ivale;
            document.getElementById('<%= hdnDatecredit.ClientID %>').value = Date;
            document.getElementById('<%= hdnClientID.ClientID %>').value = ClientId;
            document.getElementById('<%= hdnclientName.ClientID %>').value = ClientName;
            document.getElementById('<%= hdnAuthorised.ClientID %>').value = Authorizedby;
            document.getElementById('<%= hdnReason.ClientID %>').value = Reason;
            document.getElementById('<%= hdnCrDrType.ClientID %>').value = CrDrType;
            document.getElementById('<%= hdnIdCredit.ClientID %>').value = ReferenceID;
            document.getElementById('<%= hdnReceiptNoCredit.ClientID %>').value = ReceiptNo;
            document.getElementById('<%= hdnddltypeCredit.ClientID %>').value = ClientType;
            //            var objChkBok = document.getElementById(idValue);
            document.getElementById('<%= hdnAmountCredit.ClientID %>').value = Amount;
            document.getElementById('<%= hdnremarks.ClientID %>').value = Remarks;
            document.getElementById('<%= hdnreasoncredit.ClientID %>').value = ReasonCredit;
            document.getElementById('<%= hdnAddress.ClientID %>').value = Address;
            document.getElementById('<%= hdnClientType.ClientID %>').value = ItemType;
            document.getElementById('<%= hdnReferenceID.ClientID %>').value = BillNumber;

            //            document.getElementById('<%= hdnAmountCredit.ClientID %>').value = dAmount;
            ////            newAmount = Number(dAmount);
            //            document.getElementById('<%= hdnCrDrType.ClientID %>').value = Credittype;
            //            if (IdentificationType == "Deposit") {
            //                document.getElementById('<%= hdnCollectiontype.ClientID %>').value = "0";
            //            }
            //            else {
            //                document.getElementById('<%= hdnCollectiontype.ClientID %>').value = "1";

            ////            }

        }

        function validatenumberamount(evt) {

            var keyCode = 0;
            if (evt) {
                keyCode = evt.keyCode || evt.which;
            }
            else {
                keyCode = window.event.keyCode;
            }
            //alert('keyCode  : '+keyCode);
            if ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105) || (keyCode == 110) || (keyCode == 8) || (keyCode == 9) || (keyCode == 12) || (keyCode == 27) || (keyCode == 37) || (keyCode == 39) || (keyCode == 46) || (keyCode == 190) || (keyCode == 188)) {
                return true;
            }
            else {
                return false;
            }

            //    var keyCode = evt.which ? evt.which : evt.keyCode;
            //    return keyCode < '0'.charCodeAt() || keyCode > '9'.charCodeAt();
        }
        
    </script>

    <script type="text/javascript">


        function chkCreditPament() {
        }
        
    </script>

    <asp:ScriptManager ID="scrpt" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p searchPanel">
            <tr>
                <td class="a-center">
                    <table class="dataheader2 defaultfontcolor w-100p">
                        <tr>
                            <td id="Td8" runat="server" class="a-left w-5p">
                                <asp:Label ID="Label5" Text="Type" runat="server" meta:resourcekey="Rs_TinNo1Resource1"></asp:Label>
                            </td>
                            <td class="h-23 w-10p a-left">
                                <%--   <td id="CTHospital" runat="server">--%>
                                <select id="ddlcredit" runat="server" class="ddlsmall" onchange="Javascript:SetPatientClient();">
                            <%--    <option value="0">Select</option>
                                    <option value="1">Client</option>
                                    <option value="2">Patient</option>--%>
                                </select>
                                <%--</td>--%>
                            </td>
                            <td class="h-23 w-20p a-left">
                                <input cssclass="bilddltb" type="radio" value="CR" name="SearchType" runat="server"
                                    id="rdoPS" onclick="Javascript:SetCreditDebit('CR');" tabindex="0" checked="true" />
                                <asp:Label ID="Credit" runat="server" Font-Bold="False" Text="Credit" meta:resourcekey="CreditResource1"></asp:Label>
                                <input cssclass="bilddltb" type="radio" value="DR" name="SearchType" runat="server"
                                    id="rdoTS" onclick="Javascript:SetCreditDebit('DR');" tabindex="2" />
                                <asp:Label ID="Debit" runat="server" Font-Bold="False" Text="Debit" meta:resourcekey="DebitResource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr class="tablerow" id="Div3" runat="server" style="display: table-row;">
                <td id="Td21" colspan="2" class="a-center" runat="server">
                    <table class="dataheader2 defaultfontcolor w-100p">
                        <tr id="Tr1" runat="server">
                            <%--<td id="Td4" runat="server" align="left" width="13%">
                                                <asp:Label ID="Label9" Text="Name" runat="server" meta:resourcekey="Rs_SupplierNameResource1"></asp:Label>
                                            </td>
                                            <td>                                                
                                                <asp:TextBox ID="txtName" runat="server" MaxLength="20" CssClass="Txtboxsmall"
                                                    AutoComplete="off"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPatient" runat="server" TargetControlID="txtName"
                                                    ServiceMethod="GetLabQuickBillPatientList" ServicePath="~/OPIPBilling.asmx" EnableCaching="False"
                                                    CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                   Enabled="True"
                                                    >
                                                </ajc:AutoCompleteExtender>
                                               
                                            </td>--%>
                            <td id="Td11" class="a-left w-10p" runat="server">
                                <asp:Label ID="Label4" Text="Name" runat="server" meta:resourcekey="Rs_SupplierNameResource1"></asp:Label>
                            </td>
                            <td id="Td22" runat="server" class="a-left w-15p">
                                <asp:TextBox ID="txtClientNameSrch" runat="server" MaxLength="20" CssClass="small"
                                    AutoComplete="off" meta:resourcekey="txtClientNameSrchResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientNameSrch"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                                    OnClientItemSelected="OnselectedClientName" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                    Enabled="True" UseContextKey="True">
                                </ajc:AutoCompleteExtender>
                                &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                            </td>
                            <td id="Td10" class="a-left w-10p" runat="server">
                                <asp:Label ID="Rs_Selectapatient" Text="Reference Type" runat="server" meta:resourcekey="Rs_SelectapatientResource1" />
                            </td>
                            <td id="Td12" runat="server" class="w-12p a-left">
                                <asp:DropDownList ID="ddltype" runat="server" CssClass="ddlsmall" onchange="Javascript:SetTypeClient();">
                                    <%--  <asp:ListItem meta:resourcekey="ListItemResource1">---Select---</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource2">INVOICE NO</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource3">BILL NO</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource4">OTHERS</asp:ListItem>--%>
                                </asp:DropDownList>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                            <td id="Td3" runat="server" class="a-left w-10p">
                                <asp:Label ID="Label10" Text="ReferenceTypeNo" runat="server" meta:resourcekey="Label10Resource1"></asp:Label>
                            </td>
                            <td id="Td113" runat="server" class="a-left w-10p">
                                <asp:TextBox ID="TxtRefTypeNo" runat="server" MaxLength="20" CssClass="small" AutoComplete="off"
                                    meta:resourcekey="TxtRefTypeNoResource1"></asp:TextBox>
                                &nbsp;<img id="imgstar" src="../Images/starbutton.png" alt="" class="v-middle" style="display: inline" />
                            </td>
                        </tr>
                        <tr>
                            <td id="Td15" runat="server" class="a-left w-10p">
                                <asp:Label ID="Label7" Text="Amount" runat="server" meta:resourcekey="Label7Resource1"></asp:Label>
                            </td>
                            <td id="Td18" runat="server" class="a-left w-10p">
                                <%--  <asp:TextBox ID="TxtAmount" runat="server" MaxLength="20" CssClass="Txtboxsmall"
                                                    AutoComplete="off"></asp:TextBox>--%>
                                <asp:TextBox runat="server" ID="TxtAmount" CssClass="small"      onkeypress="return ValidateOnlyNumeric(this);"   
                                    MaxLength="9" autocomplete="off" meta:resourcekey="TxtAmountResource1"></asp:TextBox>
                                &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                            </td>
                            <td id="Td5" runat="server" class="a-left w-10p">
                                <asp:Label ID="Label6" Text="Reason" runat="server" meta:resourcekey="Label6Resource1"></asp:Label>
                            </td>
                            <td id="Td6" runat="server" class="a-left w-10p">
                                <asp:DropDownList ID="ddlreason" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlreasonResource1">
                                </asp:DropDownList>
                            </td>
                            <td id="Td19" runat="server" class="a-left w-10p">
                                <asp:Label ID="Label8" Text="Authorized By" runat="server" meta:resourcekey="Label8Resource1"></asp:Label>
                            </td>
                            <td id="Td20" runat="server" class="a-left w-10p">
                                <asp:TextBox ID="txtAuthorised" autocomplete="off" CssClass="small" runat="server"
                                    meta:resourcekey="txtAuthorisedResource1" />
                                <ajc:AutoCompleteExtender ID="AutoAuthorizer" runat="server" CompletionInterval="10"
                                    FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                    Enabled="True" MinimumPrefixLength="1" ServiceMethod="getUserNamesWithNameandLoginID"
                                    OnClientItemSelected="OnselectedAuthorizeName" ServicePath="~/WebService.asmx"
                                    TargetControlID="txtAuthorised">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr>
                            <td id="Td7" runat="server" class="a-left w-10p">
                                <asp:Label ID="Label11" Text="Remarks" runat="server" meta:resourcekey="Label11Resource1"></asp:Label>
                            </td>
                            <td id="Td9" runat="server" class="a-left w-10p">
                                <asp:TextBox ID="TxtRemarks" runat="server" MaxLength="49" CssClass="small" AutoComplete="off"
                                    TextMode="MultiLine" meta:resourcekey="TxtRemarksResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <%-- <tr>
                                         
                                        </tr>--%>
                        <tr>
                            <td>
                                <asp:CheckBox ID="ChkPrint" Text="PrintBill" runat="server" Checked="True" meta:resourcekey="ChkPrintResource1" />
                                <td id="Td13" runat="server" class="defaultfontcolor a-left w-5p">
                                    <asp:Button ID="bGo" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" Text="Save" OnClientClick="javascript:return RequireValidate();"
                                        OnClick="btnSave_Click" meta:resourcekey="bGoResource1" />
                                    <asp:Button ID="Button1" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr class="tablerow">
                <td colspan="2" class="a-center">
                    <table class="dataheader2 defaultfontcolor w-90p bg-row">
                        <tr class="colorforcontent">
                            <td id="Td35" runat="server" class="a-left w-13p padding5" colspan="10">
                                <asp:Label ID="Labe23" Text="Client Search" Style="color: White" runat="server" meta:resourcekey="Rs_SupplierNameResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td id="Td4" runat="server" class="a-left w-5p">
                                <asp:Label ID="Label9" Text="Type" runat="server" meta:resourcekey="Rs_TinNo1Resource1"></asp:Label>
                            </td>
                            <td class="h-23 w-10p a-left">
                                <%--   <td id="CTHospital" runat="server">--%>
                                <select id="ddlcreditsearch" runat="server" class="ddlsmall" onchange="Javascript:SetPatientClientSearch();">
                                    <%--<option value="0">Select</option>
                                    <option value="1">Client</option>
                                    <option value="2">Patient</option>--%>
                                </select>
                                <%--</td>--%>
                            </td>
                            <td id="Td1" runat="server" class="a-left w-13p">
                                <asp:Label ID="Label21" Text="Name" runat="server" meta:resourcekey="Rs_SupplierNameResource1"></asp:Label>
                            </td>
                            <td id="Td2" runat="server" class="a-left w-15p">
                                <asp:TextBox ID="txtClientNameSearch" runat="server" MaxLength="20" CssClass="small"
                                    AutoComplete="off" meta:resourcekey="txtClientNameSearchResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtClientNameSearch"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                                    OnClientItemSelected="OnselectedClientName1" ServicePath="~/WebService.asmx"
                                    DelimiterCharacters="" Enabled="True" UseContextKey="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                            <td>
                                <DateCtrl:DateSelection ID="ucDateCtrl" runat="server" />
                            </td>
                            <td id="Td23" runat="server" class="defaultfontcolor w-5p a-left">
                                <asp:Button ID="Btn_Go" CssClass="btn" Text="Go" OnClick="btnGo_Click" onmouseout="this.className='btn'"
                                    onmouseover="this.className='btn btnhov'" runat="server" meta:resourcekey="Btn_GoResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="a-center">
                </td>
            </tr>
        </table>
        <table class="a-center w-70p defaultfontcolor" id="tblData" runat="server" style="display: none">
            <tr class="tablerow a-center" id="datagrid" runat="server" style="display: none;">
                <td colspan="2">
                    <div class="dataheader2">
                        <asp:GridView ID="gvCollectDeposit" runat="server" AutoGenerateColumns="False" BackColor="White"
                            CssClass="gridView w-100p m-auto" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                            DataKeyNames="ClientId,ClientName,ClientType,ReferenceType,
                                            AuthorizerName,ItemType,Reason,BillNumber,ReceiptNo,ReferenceID,Authorizedby,Remarks,Crdrtype,CrDrDate,Amount"
                            CellPadding="3" Font-Bold="False" OnRowCommand="gvCollectDeposit_RowCommand"
                            OnRowDataBound="gvCollectDepositDetails_RowDataBound" OnRowEditing="gvCollectDeposit_RowEditing"
                            meta:resourcekey="gvCollectDepositResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:RadioButton ID="rdoID" runat="server" name="rdoID" meta:resourcekey="rdoIDResource1" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="ClientId" Visible="false" HeaderText="Client Name" meta:resourcekey="BoundFieldResource1">
                                    <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ClientName" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                    <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ClientType" HeaderText="Client Type" meta:resourcekey="BoundFieldResource3">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CrDrDate" HeaderText="Date" DataFormatString="{0:d}" meta:resourcekey="BoundFieldResource4">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource5">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="AuthorizerName" HeaderText="AuthorizerName" meta:resourcekey="BoundFieldResource6">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ItemType" Visible="true" HeaderText="Item Type" meta:resourcekey="BoundFieldResource7">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ReferenceType" HeaderText="Reference Type" meta:resourcekey="BoundFieldResource8">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="BillNumber" HeaderText="Ref Type No" meta:resourcekey="BoundFieldResource9">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Reason" Visible="true" HeaderText="Reason" meta:resourcekey="BoundFieldResource10">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ReceiptNo" Visible="false" HeaderText="Receipt No" meta:resourcekey="BoundFieldResource11">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ReferenceID" Visible="false" HeaderText="ReferenceID"
                                    meta:resourcekey="BoundFieldResource12">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Authorizedby" HeaderText="Authorized By" Visible="false"
                                    meta:resourcekey="BoundFieldResource13">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Remarks" Visible="true" HeaderText="Remarks" meta:resourcekey="BoundFieldResource14">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Crdrtype" Visible="false" HeaderText="Address" meta:resourcekey="BoundFieldResource15">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Action" Visible="false" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="linkEdit" Visible="False" CommandName="Edit" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                            Style="color: Black; text-decoration: underline" Text="Edit" runat="server" meta:resourcekey="linkEditResource1" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="White" ForeColor="#000066" />
                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                            <RowStyle ForeColor="#000066" />
                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                        <%-- <br />
                                        <div align="right" visible="false" style="width: 385px; font-weight: bold;">
                                            <asp:Label ID="Rs_TotalDepositedAmount" Text="Total Deposited Amount:" visible="false" runat="server"></asp:Label>&nbsp;<asp:Label
                                                ID="lblTotalDepositAmountTemp" Font-Bold="True" runat="server"></asp:Label>
                                        </div>
                                        <br />--%>
                        <asp:Button ID="btnPrint" runat="server" Text="Print Receipt" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                            onmouseout="this.className='btn1'" OnClientClick='PopUpPage();return false;'
                            meta:resourcekey="btnPrintResource1" />
                    </div>
                </td>
            </tr>
            <tr class="a-center">
                <td>
                    <table class="w-100p">
                        <tr id="GrdFooter" runat="server" class="dataheaderInvCtrl" style="display: none;">
                            <td class="defaultfontcolor a-center">
                                <asp:Label ID="Label1" runat="server" Text="Page"  meta:resourcekey="Label1Resource1"></asp:Label><asp:Label ID="lblCurrent"
                                    runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label><asp:Label ID="Label2"
                                        runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label><asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label><asp:Button
                                            ID="btnPrevious" runat="server" CssClass="btn" OnClick="btnPrevious_Click" Text="Previous"  meta:resourcekey="btnPreviousResource1"/><asp:Button
                                                ID="btnNext" runat="server" CssClass="btn" OnClick="btnNext_Click" Text="Next" meta:resourcekey="btnNextResource1"/><asp:HiddenField
                                                    ID="hdnCurrent" runat="server" />
                                <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label><asp:TextBox
                                    ID="txtpageNo" runat="server" AutoComplete="off" meta:resourcekey="txtpageNoResource1"></asp:TextBox><asp:Button ID="Button2"
                                        runat="server" CssClass="btn w-30" OnClick="btnGo1_Click" OnClientClick="javascript:return checkForValues();"
                                        Text="Go" meta:resourcekey="Button2Resource1" /><asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br clear="all" />
        <asp:Label ID="Rs_TotalAmount" Text="Total Amount:" Visible="false" runat="server"
            meta:resourcekey="Rs_TotalAmountResource1"></asp:Label>
        <asp:TextBox ID="txtPayment" Visible="false" Style="text-align: right;" runat="server"
            ReadOnly="True" CssClass="small" meta:resourcekey="txtPaymentResource1" Text="0"></asp:TextBox>
        <asp:Label ID="Rs_ServiceCharge" Text="Service Charge :" Visible="false" runat="server"
            meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
        <asp:TextBox ID="txtServiceCharge" Enabled="False" Visible="false" runat="server"
            Text="0.00" TabIndex="9" CssClass="small" Font-Bold="True" meta:resourcekey="txtServiceChargeResource1" />
        <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
    </div>
    <div id="divOthers" style="display: none;">
        <uc14:OtherPayments ID="OtherPayments" runat="server" ServiceMethod="m10" ServicePath="~/p"
            DescriptionDisplayText="FeeType" CommentDisplayText="Amount" />
    </div>
    </td> </tr>
    <tr>
        <td class="a-center">
            &nbsp;<asp:Button ID="btnSave" runat="server" Text="Finish" Visible="false" CssClass="btn1"
                onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                OnClientClick="javascript:return AmtValidate();" meta:resourcekey="btnSaveResource1" />
            &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" Visible="false" CssClass="btn1"
                onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                meta:resourcekey="btnCancelResource1" />
        </td>
    </tr>
    </table>
    <input type="hidden" runat="server" id="hdnDate" />
    <input type="hidden" runat="server" id="hdnReceiptNo" />
    <input type="hidden" runat="server" id="hdnddltype" />
    <input type="hidden" runat="server" id="hdnReceiptNoCredit" />
    <input type="hidden" runat="server" id="hdnPrevControl" />
    <input type="hidden" id="hdnCount" />
    <input type="hidden" runat="server" id="hdnSelectedPatientID" />
    <input type="hidden" runat="server" id="hdnSetCreditDebit" value="Credit" />
    <input type="hidden" runat="server" id="hdnAmount" />
    <input type="hidden" runat="server" id="hdnNowPaid" />
    <input type="hidden" runat="server" id="hdnIPINterID" />
    <input type="hidden" runat="server" id="hdnPayType" />
    <input type="hidden" runat="server" id="hdnPatientName" />
    <input type="hidden" runat="server" id="hdnPatientNumber" />
    <input type="hidden" runat="server" id="hdnPVisitId" />
    <input type="hidden" runat="server" id="hdnDepoAmount" />
    <input type="hidden" runat="server" id="hdnAge" />
    <input type="hidden" runat="server" id="hdnPatientID" />
    <input type="hidden" runat="server" id="hdntype" />
    <input type="hidden" runat="server" id="hdnClientID" />
    <input type="hidden" runat="server" id="hdnClientID1" />
    <input type="hidden" runat="server" id="hdnReferenceNumber" />
    <input type="hidden" runat="server" id="hdnclientName" />
    <input type="hidden" runat="server" id="hdnclientName1" />
    <input type="hidden" runat="server" id="hdnCustomerType" />
    <input type="hidden" runat="server" id="hdnClientTypeID" />
    <input type="hidden" runat="server" id="hdnClientTypeID1" />
    <input type="hidden" runat="server" id="HdntotAmount" />
    <input type="hidden" runat="server" id="hdnReferenceType" />
    <input type="hidden" runat="server" id="hdnReferenceID" />
    <input type="hidden" runat="server" id="hdnCollectiontype" />
    <input type="hidden" runat="server" id="hdnddltypeCredit" />
    <input type="hidden" runat="server" id="hdnddltypeCreditsearch" />
    <input type="hidden" runat="server" id="hdnClientType" />
    <input type="hidden" runat="server" id="hdnRefno" />
    <input type="hidden" runat="server" id="hdnReason" />
    <input type="hidden" runat="server" id="hdnAmountCredit" />
    <input type="hidden" runat="server" id="hdnAuthorised" />
    <input type="hidden" runat="server" id="hdnCrDrType" />
    <input type="hidden" runat="server" id="hdnDatecredit" />
    <input type="hidden" runat="server" id="hdnreceiptno1" />
    <input type="hidden" runat="server" id="hdnIdCredit" />
    <input type="hidden" runat="server" id="selectvalue" />
    <input type="hidden" runat="server" id="hdnAddress" />
    <input type="hidden" runat="server" id="hdnloginname" />
    <input type="hidden" runat="server" id="hdnremarks" />
    <input type="hidden" runat="server" id="hdnreasoncredit" />
    <input type="hidden" runat="server" id="hdnCreditValue" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <br />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <%--</div> </td> </tr> </table>
    <uc5:footer id="Footer1" runat="server" />
    </div>--%>
    </form>

    <script type="text/javascript">
        function SetOtherCurrValues() {
            var pnetAmt = 0;
            var ConValue = "OtherCurrencyDisplay1";
            SetPaybleOtherCurr(pnetAmt, ConValue, true);
        }

        function DiscountAuthSelected(source, eventArgs) {
            document.getElementById('hdnDiscountApprovedBy').value = eventArgs.get_value();
            GetCurrencyValues();
        }
        //        
    </script>

</body>
</html>
