<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Collections.aspx.cs" Inherits="Reception_Collections" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/DynamicDHEBAdder.ascx" TagName="OtherPayments"
    TagPrefix="uc14" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="PaymentType"
    TagPrefix="uc15" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Collections</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--<link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />--%>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />
    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>
  <style>
  .pageCollection #Div1, .pageCollection #Div2 { overflow:hidden; height:auto; padding:0;}
  </style>
</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">
<script language="javascript" type="text/javascript">

function DisableButton() {
    document.getElementById("<%=btnSave.ClientID %>").disabled = true;
}
window.onbeforeunload = DisableButton;

    function OnselectedClientName(source, eventArgs) 
    {
        document.getElementById('txtClientNameSrch').value = eventArgs.get_text();
        document.getElementById('<%=hdnclientName.ClientID %>').value = eventArgs.get_text();
        document.getElementById('<%=hdnCustomerType.ClientID %>').value = 'C';
        document.getElementById('<%=hdnClientID.ClientID %>').value = eventArgs.get_value();
        document.getElementById('hdnClientTypeID').value = '0';
    }
    function PopUpPage(IsTaskApproval)
     {
        
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
        var objVar01 = SListForAppMsg.Get("Reception_Collections_aspx_01") == null ? "Select a Deposit Receipt to Print" : SListForAppMsg.Get("Reception_Collections_aspx_01");
        var objAlert = SListForAppMsg.Get("Reception_Collections_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_Collections_aspx_Alert");

        
        //alert(dAmount);
        if ((dAmount != '') && (Number(dAmount) > 0)) 
        {
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
            strFeatures = strFeatures + ",left=0,top=0";
            if (Customertype == 'C') {
                var strURL = "PrintDepositReceipt.aspx?rcptno=" + dReceiptNo + "&ClientID=" + pClientID + "&ClientName=" + pClientName + "&DAmount=" + dAmount + "&DDate=" + dDate + "&CollectionType=" + pCollectionType + "&IsPopup=Y";
            }
            else {
                var strURL = "PrintDepositReceipt.aspx?rcptno=" + dReceiptNo + "&PNumber=" + pNumber + "&pdid=" + dBdetNo + "&pDet=" + sptype + "&PID=" + pPatientID + "&VID=" + pVisitId + "&IsPopup=Y";
            }
            window.open(strURL, "", strFeatures, true);
            var ConValue = "OtherCurrencyDisplay1";
            SetReceivedOtherCurr(0, 0, ConValue);

            if (IsTaskApproval == "Y") {
                window.location = 'Home.aspx';
            }

        }
        else 
        {
            // alert('Select a Deposit Receipt to Print');
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
        var objVar02 = SListForAppMsg.Get("Reception_Collections_aspx_02") == null ? "Add Deposite Amount" : SListForAppMsg.Get("Reception_Collections_aspx_02");
        var objAlert = SListForAppMsg.Get("Reception_Collections_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_Collections_aspx_Alert");

        if (document.getElementById('txtPayment').value <= 0 || document.getElementById('txtPayment').value == '') {

            //alert('Add Deposite Amount');
            ValidationWindow(objVar02, objAlert);

                return false;
            }
        
        return true;
    }
    function Validate() {
        var objVar03 = SListForAppMsg.Get("Reception_Collections_aspx_03") == null ? "Enter Valid Client" : SListForAppMsg.Get("Reception_Collections_aspx_03");
        var objAlert = SListForAppMsg.Get("Reception_Collections_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_Collections_aspx_Alert");
        var objVar04 = SListForAppMsg.Get("Reception_Collections_aspx_04") == null ? "Select Collection type" : SListForAppMsg.Get("Reception_Collections_aspx_04");

       var Cname = document.getElementById('txtClientNameSrch').value;
        var CID = document.getElementById('<%=hdnClientID.ClientID %>').value;
        var dList=document.getElementById('<%=dList.ClientID %>').value;
        if (CID != "0" && CID == "") {
            //alert('Enter Valid Client');
            ValidationWindow(objVar03, objAlert);

            document.getElementById('txtClientNameSrch').focus();
            return false;
        }
        if (dList == "-1") {

            // alert('Select Collection type');
            ValidationWindow(objVar04, objAlert);

            document.getElementById('dList').focus();
            return false;
        }
    }
    </script>
    <script type="text/javascript">
        function CallPrintReceipt(idValue, dDate, dAmount, dReceiptNo,IdentificationType) {
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
                document.getElementById('<%= hdnCollectiontype.ClientID %>').value ="0";
            }
            else {
                document.getElementById('<%= hdnCollectiontype.ClientID %>').value = "1";
            
            }
            
        }


        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var objVar05 = SListForAppMsg.Get("Reception_Collections_aspx_05") == null ? "Amount cannot be zero" : SListForAppMsg.Get("Reception_Collections_aspx_05");
            var objAlert = SListForAppMsg.Get("Reception_Collections_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_Collections_aspx_Alert");

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
                //alert('Amount cannot be zero');
                ValidationWindow(objVar05, objAlert);

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
                    

 <table class="w-100p pageCollection searchPanel">
    <tr>
        <td class="colorforcontent a-left h-23">
            <div id="Div1" runat="server" style="display: block;">
                &nbsp;<img src="../Images/ShowBids.gif" alt="Show" class="w-15 h-15 v-top pointer" onclick="showResponses('Div1','Div2','Div3',1);" />
                <span class="dataheader1txt pointer" onclick="showResponses('Div1','Div2','Div3',1);">
                    <asp:Label ID="Label2" Text="Client Search" runat="server" meta:resourcekey="Rs_SupplierSearchResource1"></asp:Label>
                </span>
            </div>
            <div id="Div2" runat="server" style="display: none;">
                &nbsp;<img src="../Images/HideBids.gif" alt="hide" class="w-15 h-15 v-top pointer" onclick="showResponses('Div1','Div2','Div3',0);" />
                <span class="dataheader1txt pointer" onclick="showResponses('Div1','Div2','Div3',0);">
                    <asp:Label ID="Label3" Text="Client Search" runat="server" meta:resourcekey="Rs_SupplierSearch1Resource1"></asp:Label></span></div>
        </td>
    </tr>
    <tr class="tablerow" id="Div3" runat="server" style="display: table-row;">
        <td id="Td21" colspan="2" runat="server">
            <table class="dataheader2 defaultfontcolor w-100p">
                <tr id="Tr1" runat="server">
                    <td id="Td11"  runat="server" class="w-10p">
                        <asp:Label ID="Label4" Text="Client Name" runat="server" meta:resourcekey="Rs_SupplierNameResource1"></asp:Label>
                    </td>
                    <td id="Td22" runat="server" class="w-15p">
                        <asp:TextBox ID="txtClientNameSrch" runat="server" MaxLength="20" CssClass="Txtboxsmall"
                            AutoComplete="off" meta:resourcekey="txtClientNameSrchResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientNameSrch"
                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy" OnClientItemSelected="OnselectedClientName"
                            ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True" UseContextKey="True">
                        </ajc:AutoCompleteExtender>
                    </td>
                    <td id="Td8" runat="server"  class="w-10p" visible="false">
                        <asp:Label ID="Label5" Text="Client Code" runat="server" meta:resourcekey="Rs_TinNo1Resource1"></asp:Label>
                    </td>
                    <td id="Td9" runat="server" class="w-15p" visible="false">
                        <asp:TextBox ID="txtClientCodeSrch" runat="server" MaxLength="20" 
                            CssClass="Txtboxsmall" meta:resourcekey="txtClientCodeSrchResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtClientCodeSrch"
                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                            ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True" UseContextKey="True">
                        </ajc:AutoCompleteExtender>
                    </td>
                    
                    <td id="Td10" class="defaultfontcolor a-left w-18p" runat="server"> 
                        <asp:Label ID="Rs_Selectapatient" Text="Choose type of Collection" 
                            runat="server" meta:resourcekey="Rs_SelectapatientResource1" />  </td>
                      
                    <td id="Td12" runat="server" class="w-25p defaultfontcolor a-left">
                        <asp:DropDownList ID="dList" runat="server" CssClass="ddlsmall" 
                            meta:resourcekey="dListResource1"></asp:DropDownList> &nbsp;<asp:CheckBox 
                            id="chkIsRefund" Text="Is Refund" style="display:none" runat="server" 
                            meta:resourcekey="chkIsRefundResource1" /> </td>        
                    <td id="Td13" runat="server" width="5%" class="defaultfontcolor w-5p a-left">  
                        <asp:Button ID="bGo" runat="server" CssClass="btn" 
                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" 
                            Text="Go" onclick="bGo_Click" OnClientClick="javascript:return Validate()" 
                            meta:resourcekey="bGoResource1" />
                    </td>
                    
                </tr>
            </table>
        </td>
    </tr>
 </table>
                    
 <table class="defaultfontcolor w-100p" id="tblData" runat="server" style="display:none">
<tr>
    <td>
        <table>
            <tr id="trpatient" runat="server">
                <td>
                    <asp:Label ID="Rs_Number" Text="Patient Number :" runat="server" meta:resourcekey="Rs_NumberResource1"></asp:Label>
                </td>
                <td >
                    <asp:Label ID="lblPatientID" runat="server" Font-Bold="True" meta:resourcekey="lblPatientIDResource1"></asp:Label>
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;
                </td>
                <td>
                    <asp:Label ID="Rs_PatientName" Text="Patient Name:" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblPatientName" runat="server" Font-Bold="True" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="Rs_Age" Text="Age" runat="server" meta:resourcekey="Rs_AgeResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblAge" runat="server" Font-Bold="True" meta:resourcekey="lblAgeResource1"></asp:Label>
                </td>
            </tr>
             <tr id="trClient" runat="server">
             <td>
                    <asp:Label ID="lblClnt" Text="Client Name :" runat="server" 
                        meta:resourcekey="lblClntResource1" ></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblClientName" runat="server" Font-Bold="True" 
                        meta:resourcekey="lblClientNameResource1"></asp:Label>
                </td>
                <td >
                    <asp:Label ID="lblClnt0" Text="Customer Type :" runat="server" 
                        meta:resourcekey="lblClnt0Resource1" ></asp:Label>
                 </td>
                <td >
                    <asp:Label ID="lblClienttype" runat="server" Font-Bold="True" meta:resourcekey="lblClienttypeResource1" 
                       ></asp:Label>
                 </td>
                <td >
                    <asp:Label ID="lblClnt1" Text="Collection Type :" runat="server" 
                        style="display:none" meta:resourcekey="lblClnt1Resource1" ></asp:Label>
                 </td>
                <td ><asp:Label ID="lblCollection"  style="display:none" runat="server" 
                        meta:resourcekey="lblCollectionResource1" ></asp:Label></td>
                <td ></td>
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
        <table class="w-100p">
            <tr>
                <td class="colorforcontent a-left h-23">
                    <div id="ACX2plusAdvPmt" style="display: block;" class="w-100p">
                        &nbsp;<img src="../Images/ShowBids.gif" alt="Show" class="w-15 h-15 v-top pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',1);" />
                        <span class="dataheader1txt pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',1);">
                            &nbsp;<asp:Label ID="Rs_PreviousDepositPayments" Text="Previous Deposit Payments"
                                runat="server" meta:resourcekey="Rs_PreviousDepositPaymentsResource1"></asp:Label>
                            |
                            <asp:Label ID="Rs_TotalAmountDeposited" Text="Total Amount Deposited:" runat="server"
                                meta:resourcekey="Rs_TotalAmountDepositedResource1"></asp:Label>&nbsp;<asp:Label
                                    ID="lblTotalDepositAmount" Font-Bold="True" runat="server" meta:resourcekey="lblTotalDepositAmountResource1"></asp:Label>
                            &nbsp;|
                            <asp:Label ID="Rs_TotalDepositAmountUsed" Text="Total Deposit Amount Used:" runat="server"
                                meta:resourcekey="Rs_TotalDepositAmountUsedResource1"></asp:Label>&nbsp;<asp:Label
                                    ID="lblTotalDepositUsed" Font-Bold="True" runat="server" meta:resourcekey="lblTotalDepositUsedResource1"></asp:Label>
                            &nbsp; |
                            <asp:Label ID="Rs_AvailableDepositBalance" Text="Available Deposit Balance:" runat="server"
                                meta:resourcekey="Rs_AvailableDepositBalanceResource1"></asp:Label>&nbsp;<asp:Label
                                    ID="lblTotalDepositBalance" Font-Bold="True" runat="server" meta:resourcekey="lblTotalDepositBalanceResource1"></asp:Label>
                            &nbsp; |
                            <asp:Label Visible="False" ID="lblRefundedAmt" runat="server" Text="Refunded Amount:"
                                meta:resourcekey="lblRefundedAmtResource1"></asp:Label>
                            &nbsp;<asp:Label Visible="False" ID="lblRefundAmt" Font-Bold="True" runat="server"
                                meta:resourcekey="lblRefundAmtResource1"></asp:Label>
                        </span>
                    </div>
                    <div id="ACX2minusAdvPmt" style="display: none;">
                        &nbsp;<img src="../Images/HideBids.gif" alt="hide" class="w-15 h-15 v-top pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',0);" />
                        <span class="dataheader1txt pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',0);">
                            &nbsp;<asp:Label ID="Rs_PreviousDepositPayments1" Text="Previous Deposit Payments"
                                runat="server" meta:resourcekey="Rs_PreviousDepositPayments1Resource1"></asp:Label>
                    </div>
                </td>
            </tr>
            <tr class="tablerow" id="ACX2responsesAdvPmt" style="display: none;">
                <td colspan="2">
                    <div class="filterdatahe">
                        <asp:GridView ID="gvCollectDepositDetails" CssClass="w-50p gridView" runat="server" AutoGenerateColumns="False"
                            BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                            CellPadding="3" Font-Bold="False" OnRowDataBound="gvCollectDepositDetails_RowDataBound"
                            meta:resourcekey="gvCollectDepositDetailsResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" 
                                    meta:resourcekey="TemplateFieldResource1" >
                                    <ItemTemplate>
                                        <asp:RadioButton ID="rdoID" runat="server" name="rdoID" 
                                            meta:resourcekey="rdoIDResource1" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt Number" 
                                    meta:resourcekey="BoundFieldResource1" >
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="AmountDeposited" HeaderText="Amount Deposited" 
                                    meta:resourcekey="BoundFieldResource2" >
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                    HeaderText="Deposited Date" meta:resourcekey="BoundFieldResource3">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="IdentificationType" 
                                    HeaderText="Collection Type" meta:resourcekey="BoundFieldResource4">
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
                        <div class="a-right bold" style="width: 385px;">
                            <asp:Label ID="Rs_TotalDepositedAmount" Text="Total Deposited Amount:" runat="server"
                                meta:resourcekey="Rs_TotalDepositedAmountResource1"></asp:Label>&nbsp;<asp:Label
                                    ID="lblTotalDepositAmountTemp" Font-Bold="True" runat="server" 
                                meta:resourcekey="lblTotalDepositAmountTempResource1" ></asp:Label>
                        </div>
                        <br />
                        <asp:Button ID="btnPrint" runat="server" Text="Print Receipt" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                            onmouseout="this.className='btn1'" OnClientClick='PopUpPage();return false;'
                            meta:resourcekey="btnPrintResource1" />
                    </div>
                </td>
            </tr>
        </table>
    </asp:Panel>
    
    <table class="w-100p bg-row">
    <tr>
    <td>
     <asp:Label ID="Rs_TotalAmount" Text="Total Amount:" runat="server" meta:resourcekey="Rs_TotalAmountResource1"></asp:Label>
    <asp:TextBox ID="txtPayment" Width="70px" Style="text-align: right;" runat="server"  
        ReadOnly="True"  CssClass="Txtboxsmall" meta:resourcekey="txtPaymentResource1" 
        Text="0" ></asp:TextBox>
    <asp:Label ID="Rs_ServiceCharge" Text="Service Charge :" runat="server" meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
    <asp:TextBox ID="txtServiceCharge" Width="70px" Enabled="False" runat="server" Text="0.00"
        TabIndex="9"  CssClass="Txtboxsmall" Font-Bold="True" meta:resourcekey="txtServiceChargeResource1" />
    <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
    <br />
    <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" IsDisplayPayedAmount="false"
        runat="server" />
    <br clear="all" />
    <br />
    <uc15:PaymentType ID="PaymentTypes" runat="server" />
    </td>
    </tr>
    </table>
   
    </div>
    <div id="divOthers" style="display: none;">
    <uc14:OtherPayments ID="OtherPayments" runat="server" ServiceMethod="m10" ServicePath="~/p"
        DescriptionDisplayText="FeeType" CommentDisplayText="Amount" />
    </div>
    </td>
    </tr>
                            <tr>
                                <td class="a-center">
                                    &nbsp;<asp:Button ID="btnSave" runat="server" Text="Finish" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" OnClientClick="javascript:return AmtValidate();" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                    &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
  
  <table class="w-100p" id="tblNotAlowed" runat="server" style="display:none;margin-top: 30px;">
  <tr><td class="w-100p" style="text-align: center;font-weight: bold;font-size: larger;">Deposit Collection available only for Advance Client </td></tr>
  </table>
                        <input type="hidden" runat="server" id="hdnDate" />
                        <input type="hidden" runat="server" id="hdnReceiptNo" />
                        <input type="hidden" runat="server" id="hdnPrevControl" />
                        <input type="hidden" id="hdnCount" />
                        <input type="hidden" runat="server" id="hdnAmount" />
                        <input type="hidden" runat="server" id="hdnNowPaid" />
                        <input type="hidden" runat="server" id="hdnIPINterID" />
                        <input type="hidden" runat="server" id="hdnPayType" />
                        <input type="hidden" runat="server" id="hdnPatientName" />
                        <input type="hidden" runat="server" id="hdnPatientNumber" />
                        <input type="hidden" runat="server" id="hdnPVisitId" />
                        <input type="hidden" runat="server" id="hdnDepoAmount" />
                        <input type="hidden" runat="server" id="hdnAge" />
                        <input type ="hidden" runat="server" id ="hdnPatientID" />
                        <input type ="hidden" runat="server" id ="hdnClientID" />
                        <input type ="hidden" runat="server" id ="hdnclientName" />
                         <input type ="hidden" runat="server" id ="hdnCustomerType" />
                         <input type="hidden"  runat="server" id="hdnClientTypeID" />
                         <input type="hidden"  runat="server" id="HdntotAmount" />
                         <input type="hidden"  runat="server" id="hdnCollectiontype" />
                         <input type="hidden"  runat="server" id="hdnPreCollectionID" value="0" />
                             <asp:HiddenField ID="hdnPaymentRule" runat="server" />
                             <asp:HiddenField ID="hdnminimumamount" runat="server" />
                             <asp:HiddenField ID="hdnTaskID" runat="server" />
                              <asp:HiddenField ID="hdnIsTaskApproval" Value="N" runat="server" />
                        
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

