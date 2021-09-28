<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RefundtoAdvance.aspx.cs"
    Inherits="Reception_Collections" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/DynamicDHEBAdder.ascx" TagName="OtherPayments"
    TagPrefix="uc14" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="PaymentType"
    TagPrefix="uc15" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Collections</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--<link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">

    <script language="javascript" type="text/javascript">


        function RadioCheck(rb) {
            var row = rb.parentNode.parentNode;
            var row2 = $(row).find("td").eq(1).html();
            var row3 = $(row).find("td").eq(2).html();
            document.getElementById('hdnRefund').value = row2;
            document.getElementById('hdnDate').value = row3;

        }

        function OnselectedClientName(source, eventArgs) {
            document.getElementById('txtClientNameSrch').value = eventArgs.get_text();
            document.getElementById('<%=hdnclientName.ClientID %>').value = eventArgs.get_text();
            document.getElementById('<%=hdnCustomerType.ClientID %>').value = 'C';
            document.getElementById('<%=hdnClientID.ClientID %>').value = eventArgs.get_value();
            document.getElementById('hdnClientTypeID').value = '0';
        }
        /*AB Code
        function OnselectedClientName(source, eventArgs) {

            document.getElementById('<%=hdnClientID.ClientID %>').value = eventArgs.get_value().split('~')[0];
        if (eventArgs.get_value().split('~')[1] == "0") {
        alert("This is not a Advance Client");
        return false;
        }
        document.getElementById('txtClientNameSrch').value = eventArgs.get_text();
        document.getElementById('<%=hdnclientName.ClientID %>').value = eventArgs.get_text();
        document.getElementById('<%=hdnCustomerType.ClientID %>').value = 'C';

            document.getElementById('hdnClientTypeID').value = '0';
        }
        */
        function PopUpPage() {

            var dDate = document.getElementById('<%= hdnDate.ClientID %>').value;
            dAmount = document.getElementById('hdnAmount').value;
            var dReceiptNo = document.getElementById('<%= hdnReceiptNo.ClientID %>').value;
            var dBdetNo = document.getElementById('<%= hdnIPINterID.ClientID %>').value;
            var sptype = document.getElementById('<%= hdnPayType.ClientID %>').value;
            var pName = document.getElementById('<%= hdnPatientName.ClientID %>').value;
            var pNumber = document.getElementById('<%= hdnPatientNumber.ClientID %>').value;
            var pVisitId = document.getElementById('<%= hdnPVisitId.ClientID %>').value;
            var page = document.getElementById('<%= hdnAge.ClientID %>').value;
            var pPatientID = document.getElementById('<%= hdnPatientID.ClientID %>').value;
            var Customertype = document.getElementById('<%=hdnCustomerType.ClientID %>').value;
            var pClientID = document.getElementById('<%=hdnClientID.ClientID %>').value;
            var pClientName = document.getElementById('<%=hdnclientName.ClientID %>').value;
            var pDAmount = document.getElementById('<%=HdntotAmount.ClientID %>').value;
            var pCollectionType = document.getElementById('<%=hdnCollectiontype.ClientID %>').value;



            if ((dAmount != '') && (Number(dAmount) > 0)) {
                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
                strFeatures = strFeatures + ",left=0,top=0";
                if (Customertype == 'C') {
                    var strURL = "PrintDepositReceipt.aspx?rcptno=" + dReceiptNo + "&ClientID=" + pClientID + "&ClientName=" + pClientName + "&DAmount=" + dAmount + "&DDate=" + dDate + "&CollectionType=" + pCollectionType + "&Rtype=Refund" + "&IsPopup=Y";
                }
                else {
                    var strURL = "PrintDepositReceipt.aspx?rcptno=" + dReceiptNo + "&PNumber=" + pNumber + "&pdid=" + dBdetNo + "&pDet=" + sptype + "&PID=" + pPatientID + "&VID=" + pVisitId + "&Rtype=Refund" + "&IsPopup=Y";
                }
                window.open(strURL, "", strFeatures, true);
                var ConValue = "OtherCurrencyDisplay1";
                SetReceivedOtherCurr(0, 0, ConValue);

            }
            else {
                alert('Select a Deposit Receipt to Print');
                return false;
            }
        }
        //AB Code
        function PopUpPage1() {

            var dDate = document.getElementById('hdnDate').value;

            //var dDate = '09/07/2015 14:06:13';
            dAmount = document.getElementById('hdnRefund').value;

            var dReceiptNo = document.getElementById('<%= hdnReceiptNo.ClientID %>').value;
            var dBdetNo = document.getElementById('<%= hdnIPINterID.ClientID %>').value;
            var sptype = document.getElementById('<%= hdnPayType.ClientID %>').value;
            var pName = document.getElementById('<%= hdnPatientName.ClientID %>').value;
            var pNumber = document.getElementById('<%= hdnPatientNumber.ClientID %>').value;
            var pVisitId = document.getElementById('<%= hdnPVisitId.ClientID %>').value;
            var page = document.getElementById('<%= hdnAge.ClientID %>').value;
            var pPatientID = document.getElementById('<%= hdnPatientID.ClientID %>').value;
            var Customertype = document.getElementById('<%=hdnCustomerType.ClientID %>').value;
            var pClientID = document.getElementById('<%=hdnClientID.ClientID %>').value;
            var pClientName = document.getElementById('<%=hdnclientName.ClientID %>').value;
            var pDAmount = document.getElementById('<%=HdntotAmount.ClientID %>').value;
            var pCollectionType = document.getElementById('<%=hdnCollectiontype.ClientID %>').value;



            if ((dAmount != '') && (Number(dAmount) > 0)) {
                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
                strFeatures = strFeatures + ",left=0,top=0";
                if (Customertype == 'C') {
                    var strURL = "PrintRefundReceipt.aspx?rcptno=" + dReceiptNo + "&ClientID=" + pClientID + "&ClientName=" + pClientName + "&DAmount=" + dAmount + "&DDate=" + dDate + "&CollectionType=" + pCollectionType + "&Rtype=Refund" + "&IsPopup=Y";
                    //var strURL = "PrintDepositReceipt.aspx?rcptno=" + dReceiptNo + "&ClientID=" + pClientID + "&ClientName=" + pClientName + "&DAmount=" + dAmount + "&CollectionType=" + pCollectionType + "&IsPopup=Y";
                }
                else {
                    var strURL = "PrintDepositReceipt.aspx?rcptno=" + dReceiptNo + "&PNumber=" + pNumber + "&pdid=" + dBdetNo + "&pDet=" + sptype + "&PID=" + pPatientID + "&VID=" + pVisitId + "&Rtype=Refund" + "&IsPopup=Y";
                }
                window.open(strURL, "", strFeatures, true);
                var ConValue = "OtherCurrencyDisplay1";
                SetReceivedOtherCurr(0, 0, ConValue);

            }
            else {
                alert('Select a Deposit Receipt to Print');
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
            if (document.getElementById('txtPayment').value <= 0 || document.getElementById('txtPayment').value == '') {

                alert('Add Deposite Amount');
                return false;
            }
            var payment = document.getElementById('txtPayment').value;

            var RefundedAmt = document.getElementById('lblRefundedAmt').innerText;

            var TotalDepositAmount = document.getElementById('lblTotalDepositAmount').innerText;



            var exceed = document.getElementById('lblTotalRefundable').innerText;

            if (parseFloat(payment) > parseFloat(exceed)) {

                alert('Refund amount should not exceed total amount');
                return false;
            }

        }
        function Validate() {
            var Cname = document.getElementById('txtClientNameSrch').value;
            var CID = document.getElementById('<%=hdnClientID.ClientID %>').value;

            //AB Code
            //            var dList = document.getElementById('<%=dList.ClientID %>').value;
            if (CID != "0" && CID == "") {
                alert('Enter Valid Client');
                document.getElementById('txtClientNameSrch').focus();
                return false;
            }
            //            if (dList == "-1") {

            //                alert('Select Collection type');
            //                document.getElementById('dList').focus();
            //                return false;
            //            }
        }
    </script>

    <script type="text/javascript">
        function CallPrintReceipt(idValue, dDate, dAmount, dReceiptNo, IdentificationType) {
            //debugger;
            document.getElementById('hdnRefund').value = dAmount;
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
            if (IdentificationType == "Deposit") {
                document.getElementById('<%= hdnCollectiontype.ClientID %>').value = "0";
            }
            else {
                document.getElementById('<%= hdnCollectiontype.ClientID %>').value = "1";

            }

        }


        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            if (TotalAmount > 0) {
                var oldAmount = document.getElementById('<%= txtPayment.ClientID %>').value;

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
                oldAmount = Number(oldAmount) + Number(TotalAmount);

                document.getElementById('<%= txtPayment.ClientID %>').value = format_number(pAmt, 2);
                document.getElementById('<%= hdnNowPaid.ClientID %>').value = format_number(pAmt, 2);
                document.getElementById('<%= hdnServiceCharge.ClientID %>').value = format_number(pScrAmt, 2);
                document.getElementById('<%= hdnServiceCharge.ClientID %>').value = format_number(pScrAmt, 2);
                SetOtherCurrValues();
                return true;
            }
            else {
                alert('Amount cannot be zero');
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
            SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);

            document.getElementById('<%= txtPayment.ClientID %>').value = format_number(sVal, 2);
            document.getElementById('<%= hdnNowPaid.ClientID %>').value = format_number(sVal, 2);
            document.getElementById('<%= txtServiceCharge.ClientID %>').value = format_number(pScrAmt, 2);
            document.getElementById('<%= hdnServiceCharge.ClientID %>').value = format_number(pScrAmt, 2);
            SetOtherCurrValues();
        }

    </script>

    <asp:ScriptManager ID="scrpt" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="colorforcontent" height="23" align="left">
                                    <div id="Div11" runat="server" style="display: block;">
                                        &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                            style="cursor: pointer" onclick="showResponses('Div11','Div22','Div3',1);" />
                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div11','Div22','Div3',1);">
                                            <asp:Label ID="Label2" Text="Client Search" runat="server" meta:resourcekey="Rs_SupplierSearchResource1"></asp:Label>
                                        </span>
                                    </div>
                                    <div id="Div22" runat="server" style="display: none;">
                                        &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                            style="cursor: pointer" onclick="showResponses('Div11','Div22','Div3',0);" />
                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div11','Div22','Div3',0);">
                                            <asp:Label ID="Label3" Text="Client Search" runat="server" meta:resourcekey="Rs_SupplierSearch1Resource1"></asp:Label></span></div>
                                </td>
                            </tr>
                            <tr class="tablerow" id="Div3" runat="server" style="display: table-row;">
                                <td id="Td21" colspan="2" runat="server">
                                    <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="4"
                                        cellspacing="0">
                                        <tr id="Tr1" runat="server">
                                            <td id="Td11" runat="server" width="10%">
                                                <asp:Label ID="Label4" Text="Client Name" runat="server" meta:resourcekey="Rs_SupplierNameResource1"></asp:Label>
                                            </td>
                                            <td id="Td22" runat="server" width="15%">
                                                <asp:TextBox ID="txtClientNameSrch" runat="server" MaxLength="20" CssClass="Txtboxsmall"
                                                    AutoComplete="off"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientNameSrch"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="3" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                                                    OnClientItemSelected="OnselectedClientName" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                    Enabled="True" UseContextKey="True">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                            <td id="Td8" runat="server" width="10%" visible="false">
                                                <asp:Label ID="Label5" Text="Client Code" runat="server" meta:resourcekey="Rs_TinNo1Resource1"></asp:Label>
                                            </td>
                                            <td id="Td9" runat="server" width="15%" visible="false">
                                                <asp:TextBox ID="txtClientCodeSrch" runat="server" MaxLength="20" CssClass="Txtboxsmall"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtClientCodeSrch"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                                                    ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True" UseContextKey="True">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                            <td id="Td10" align="left" class="defaultfontcolor" runat="server" width="18%" style="display: none;">
                                                <asp:Label ID="Rs_Selectapatient" Text="Choose type of Collection" runat="server" />
                                            </td>
                                            <td id="Td12" runat="server" width="25%" class="defaultfontcolor" align="left" style="display: none;">
                                                <asp:DropDownList ID="dList" runat="server" CssClass="ddllarge">
                                                </asp:DropDownList>
                                                &nbsp;<asp:CheckBox ID="chkIsRefund" Text="Is Refund" Style="display: none" runat="server" />
                                            </td>
                                            <td id="Td13" runat="server" class="defaultfontcolor" align="left">
                                                <asp:Button ID="bGo" runat="server" CssClass="btn" Width="35px" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'" Text="Go" OnClick="bGo_Click" OnClientClick="javascript:return Validate()" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table border="0" width="100%" cellpadding="4" cellspacing="1" class="defaultfontcolor"
                            id="tblData" runat="server" style="display: none">
                            <tr>
                                <td>
                                    <table>
                                        <tr id="trpatient" runat="server">
                                            <td>
                                                <asp:Label ID="Rs_Number" Text="Patient Number :" runat="server" meta:resourcekey="Rs_NumberResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblPatientID" runat="server" Font-Bold="True" meta:resourcekey="lblPatientIDResource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_PatientName" Text="Patient Name :" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblPatientName" runat="server" Font-Bold="True" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_Age" Text="Age:" runat="server" meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblAge" runat="server" Font-Bold="True" meta:resourcekey="lblAgeResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trClient" runat="server">
                                            <td>
                                                <asp:Label ID="lblClnt" Text="Client Name :" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblClientName" runat="server" Font-Bold="True"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblClnt0" Text="Customer Type :" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblClienttype" runat="server" Font-Bold="True"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblClnt1" Text="Collection Type :" runat="server" Style="display: none"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCollection" Style="display: none" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr id="Preauth" runat="server" style="display: none;">
                                            <td>
                                                <asp:Label ID="Label1" runat="server" Text="Pre Authorization Amount :" Font-Bold="True"
                                                    meta:resourcekey="Label1Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblPreAuthAmount" runat="server" Font-Bold="True" meta:resourcekey="lblPreAuthAmountResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-decoration: none">
                                    <div id="divAdvance">
                                        <asp:Panel ID="pnltempAdvancePayments" runat="server" CssClass="defaultfontcolor"
                                            meta:resourcekey="pnltempAdvancePaymentsResource1">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td class="colorforcontent" colspan="2" height="23" align="left">
                                                        <div id="ACX2plusAdvPmt" style="display: block; width: 100%">
                                                            &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',1);" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',1);">
                                                                <asp:Label ID="Rs_TotalAmountDeposited" Text="Total Advance Amount:" runat="server"
                                                                    meta:resourcekey="Rs_TotalAmountDepositedResource1" Style="cursor: pointer"></asp:Label>&nbsp;<asp:Label
                                                                        ID="lblTotalDepositAmount" Font-Bold="True" runat="server" meta:resourcekey="lblTotalDepositAmountResource1"
                                                                        Style="cursor: pointer"></asp:Label>
                                                                &nbsp;|
                                                                <asp:Label ID="Rs_PreviousDepositPayments" Text="Total Advance Used:" runat="server"
                                                                    meta:resourcekey="Rs_PreviousDepositPaymentsResource1" Style="cursor: default"></asp:Label><asp:Label
                                                                        ID="lblRefundUsed" Font-Bold="True" runat="server" meta:resourcekey="lblRefundUsedResource1"
                                                                        Style="cursor: default"></asp:Label>
                                                                &nbsp;|
                                                                <asp:Label ID="Rs_TotalDepositAmountUsed" Text="Total Refund Amount:" runat="server"
                                                                    meta:resourcekey="Rs_TotalDepositAmountUsedResource1" Style="cursor: default"></asp:Label>&nbsp;<asp:Label
                                                                        ID="lblRefundedAmt" Font-Bold="True" runat="server" meta:resourcekey="lblRefundedAmtResource1"
                                                                        Style="cursor: default"></asp:Label>
                                                                &nbsp; |
                                                                <asp:Label ID="Rs_AvailableDepositBalance" Text="Total Refundable Amount:" runat="server"
                                                                    meta:resourcekey="Rs_AvailableDepositBalanceResource1" Style="cursor: default"></asp:Label>&nbsp;<asp:Label
                                                                        ID="lblTotalRefundable" Font-Bold="True" runat="server" meta:resourcekey="lblTotalRefundableResource1"
                                                                        Style="cursor: default"></asp:Label>
                                                                &nbsp; |
                                                                <%--<asp:Label Visible="False" ID="lblRefundedAmt" runat="server" Text="Refunded Amount:"
                                                                    meta:resourcekey="lblRefundedAmtResource1"></asp:Label>
                                                                &nbsp;<asp:Label Visible="False" ID="lblRefundAmt" Font-Bold="True" runat="server"
                                                                    meta:resourcekey="lblRefundAmtResource1"></asp:Label>--%>
                                                            </span>
                                                        </div>
                                                        <div id="ACX2minusAdvPmt" style="display: none;">
                                                            &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',0);">
                                                                &nbsp;<asp:Label ID="Rs_PreviousDepositPayments1" Text="Previous Deposit Payments"
                                                                    runat="server" meta:resourcekey="Rs_PreviousDepositPayments1Resource1"></asp:Label>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr class="tablerow" id="ACX2responsesAdvPmt" style="display: none;">
                                                    <td colspan="2">
                                                        <div class="filterdatahe">
                                                            <asp:GridView ID="gvCollectDepositDetails" runat="server" AutoGenerateColumns="False"
                                                                BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                                CellPadding="3" Font-Bold="False" Width="50%" OnRowDataBound="gvCollectDepositDetails_RowDataBound"
                                                                meta:resourcekey="gvCollectDepositDetailsResource1">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Select">
                                                                        <%--<ItemTemplate>--%>
                                                                            <%--<asp:RadioButton ID="rdoID" runat="server" name="rdoID"  onclick="RadioCheck(this);" />--%>
                                                                            <%--<input type="radio" id="rdoID" value="male" onclick="RadioCheck(this);"><br>
                                                                        </ItemTemplate>--%>
                                                                         <ItemTemplate>
                                                                            <asp:RadioButton ID="rdoID" runat="server" name="rdoID" />
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt Number">
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="RefundAmount" HeaderText="Refund Deposited">
                                                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                                        HeaderText="Refunded Date" meta:resourcekey="BoundFieldResource3">
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="RefundedBy" HeaderText="Refunded by">
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                <RowStyle ForeColor="#000066" />
                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                            </asp:GridView>
                                                            <br />
                                                            <div align="right" style="width: 385px; font-weight: bold;">
                                                                <asp:Label ID="Rs_TotalDepositedAmount" Text="Total Deposited Amount:" runat="server"
                                                                    meta:resourcekey="Rs_TotalDepositedAmountResource1"></asp:Label>&nbsp;<asp:Label
                                                                        ID="lblTotalDepositAmountTemp" Font-Bold="True" runat="server"></asp:Label>
                                                            </div>
                                                            <br />
                                                            <asp:Button ID="btnPrint" runat="server" Text="Print Receipt" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                                                onmouseout="this.className='btn1'" OnClientClick='PopUpPage1();return false;'
                                                                meta:resourcekey="btnPrintResource1" />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        <br clear="all" />
                                        <div style="display: none;">
                                            <asp:Label ID="Rs_TotalAmount" Text="Refund Amount:" runat="server" meta:resourcekey="Rs_TotalAmountResource1"></asp:Label>
                                            <asp:TextBox ID="txtPayment" Width="70px" Style="text-align: right;" runat="server"
                                                ReadOnly="False" CssClass="Txtboxsmall" meta:resourcekey="txtPaymentResource1"
                                                Text="0"></asp:TextBox>
                                            <asp:Label ID="Rs_ServiceCharge" Text="Service Charge :" runat="server" meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
                                            <asp:TextBox ID="txtServiceCharge" Width="70px" Enabled="False" runat="server" Text="0.00"
                                                TabIndex="9" CssClass="Txtboxsmall" Font-Bold="True" meta:resourcekey="txtServiceChargeResource1" />
                                            <br />
                                            <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" IsDisplayPayedAmount="false"
                                                runat="server" />
                                        </div>
                                        <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                        <br clear="all" />
                                        <br />
                                        <uc15:PaymentType ID="PaymentTypes" runat="server" />
                                    </div>
                                    <div id="divOthers" style="display: none;">
                                        <uc14:OtherPayments ID="OtherPayments" runat="server" ServiceMethod="m10" ServicePath="~/p"
                                            DescriptionDisplayText="FeeType" CommentDisplayText="Amount" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    &nbsp;<asp:Button ID="btnSave" runat="server" Text="Refund" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" OnClientClick="javascript:return AmtValidate();"
                                        OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                    &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" runat="server" id="hdnDate" />
                        <input type="hidden" runat="server" id="hdnReceiptNo" />
                        <input type="hidden" runat="server" id="hdnPrevControl" />
                        <input type="hidden" id="hdnCount" />
                        <input type="hidden" runat="server" id="hdnAmount" />
                        <input type="hidden" runat="server" id="hdnRefund" />
                        <input type="hidden" runat="server" id="hdnNowPaid" />
                        <input type="hidden" runat="server" id="hdnIPINterID" />
                        <input type="hidden" runat="server" id="hdnPayType" />
                        <input type="hidden" runat="server" id="hdnPatientName" />
                        <input type="hidden" runat="server" id="hdnPatientNumber" />
                        <input type="hidden" runat="server" id="hdnPVisitId" />
                        <input type="hidden" runat="server" id="hdnDepoAmount" />
                        <input type="hidden" runat="server" id="hdnAge" />
                        <input type="hidden" runat="server" id="hdnPatientID" />
                        <input type="hidden" runat="server" id="hdnClientID" />
                        <input type="hidden" runat="server" id="hdnclientName" />
                        <input type="hidden" runat="server" id="hdnCustomerType" />
                        <input type="hidden" runat="server" id="hdnClientTypeID" />
                        <input type="hidden" runat="server" id="HdntotAmount" />
                        <input type="hidden" runat="server" id="hdnCollectiontype" />
                        <asp:HiddenField ID="hdnMessages" runat="server" />
                        <br />
                    </div>
               
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
  
    </form>

    <script type="text/javascript">
        function SetOtherCurrValues() {
            var pnetAmt = 0;
            var ConValue = "OtherCurrencyDisplay1";
            SetPaybleOtherCurr(pnetAmt, ConValue, true);
        }
        GetCurrencyValues();
    </script>

</body>
</html>
