<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CollectDeposit.aspx.cs" Inherits="Reception_CollectDeposit"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/InPatientProceduresBill.ascx" TagName="ipTreatmentBillDetails"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/ConsultationDetails.ascx" TagName="ipConsultationDetails"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/InPatientInvestigation.ascx" TagName="ipInvestigation"
    TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="ucinv1" %>
<%@ Register Src="../CommonControls/MedicalIndents.ascx" TagName="medIndents" TagPrefix="uc13" %>
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
    <title>Collect Deposit</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--<link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />--%>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function PopUpPage() {

            dDate = document.getElementById('<%= hdnDate.ClientID %>').value;
            //alert(dDate);
            dAmount = document.getElementById('hdnAmount').value;
            var dReceiptNo = document.getElementById('<%= hdnReceiptNo.ClientID %>').value;
            var dBdetNo = document.getElementById('<%= hdnIPINterID.ClientID %>').value;
            var sptype = document.getElementById('<%= hdnPayType.ClientID %>').value;
            var pName = document.getElementById('<%= hdnPatientName.ClientID %>').value;
            var pNumber = document.getElementById('<%= hdnPatientNumber.ClientID %>').value;
            var pVisitId = document.getElementById('<%= hdnPVisitId.ClientID %>').value;
            var page = document.getElementById('<%= hdnAge.ClientID %>').value;
            var pPatientID = document.getElementById('<%= hdnPatientID.ClientID %>').value;
            //alert(dAmount);
            if ((dAmount != '') && (Number(dAmount) > 0)) {
                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
                strFeatures = strFeatures + ",left=0,top=0";
                var strURL = "PrintDepositReceipt.aspx?rcptno=" + dReceiptNo + "&PNumber=" + pNumber + "&pdid=" + dBdetNo + "&pDet=" + sptype + "&PID=" + pPatientID + "&VID=" + pVisitId;
                window.open(strURL, "", strFeatures, true);
                var ConValue = "OtherCurrencyDisplay1";
                SetReceivedOtherCurr(0, 0, ConValue);

            }
            else 
            {
                var userMsg = SListForApplicationMessages.Get('Reception\\CollectDeposit.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Select a Deposit Receipt to Print');
                    return false;
                }
              
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
        function AmtValidate(){
            if (document.getElementById('txtPayment').value <= 0 || document.getElementById('txtPayment').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\CollectDeposit.aspx_3');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                alert('Add Deposite Amount');
                return false;
                }
               
            }
            return true;
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">

    <script type="text/javascript">
        function CallPrintReceipt(idValue, dDate, dAmount, dReceiptNo) {
            //alert(dAmount);
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
            //            if (objChkBok.checked == true) {
            //            
            //                newAmount = Number(previousAmount) + Number(dAmount);
            //            }
            //            if (objChkBok.checked == false) {
            newAmount = Number(dAmount);
            //            }

            document.getElementById('<%= hdnAmount.ClientID %>').value = newAmount;
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
                var userMsg = SListForApplicationMessages.Get('Reception\\CollectDeposit.aspx_2');
                if (userMsg != null)
                {
                    alert(userMsg);
                    return false;
                }
                else 
                {
                    alert('Amount cannot be zero');
                    return false;
                }
                //return false;
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
        
    </script>

    <asp:ScriptManager ID="scrpt" runat="server">
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
                <uc8:PatientHeader ID="PatientHeader" runat="server" />
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
                        <table border="0" width="100%" cellpadding="4" cellspacing="1" class="defaultfontcolor">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Rs_Number" Text="Patient Number :" runat="server" meta:resourcekey="Rs_NumberResource1"></asp:Label>
                                            </td>
                                            <td class="style3">
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
                                        <tr>
                                            <td>
                                                &nbsp;
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
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',1);">
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
                                                                    <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                                        <ItemTemplate>
                                                                            <asp:RadioButton ID="rdoID" runat="server" meta:resourcekey="rdoIDResource1" name="rdoID" />
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt Number" meta:resourcekey="BoundFieldResource1">
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="AmountDeposited" HeaderText="Amount Deposited" meta:resourcekey="BoundFieldResource2">
                                                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                                        HeaderText="Deposited Date" meta:resourcekey="BoundFieldResource3">
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
                                                                        ID="lblTotalDepositAmountTemp" Font-Bold="True" runat="server" meta:resourcekey="lblTotalDepositAmountTempResource1"></asp:Label>
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
                                        <br clear="all" />
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
                                    </div>
                                    <div id="divOthers" style="display: none;">
                                        <uc14:OtherPayments ID="OtherPayments" runat="server" ServiceMethod="m10" ServicePath="~/p"
                                            DescriptionDisplayText="FeeType" CommentDisplayText="Amount" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    &nbsp;<asp:Button ID="btnSave" runat="server" Text="Finish" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" OnClientClick="javascript:return AmtValidate();" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
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
                        <input type="hidden" runat="server" id="hdnNowPaid" />
                        <input type="hidden" runat="server" id="hdnIPINterID" />
                        <input type="hidden" runat="server" id="hdnPayType" />
                        <input type="hidden" runat="server" id="hdnPatientName" />
                        <input type="hidden" runat="server" id="hdnPatientNumber" />
                        <input type="hidden" runat="server" id="hdnPVisitId" />
                        <input type="hidden" runat="server" id="hdnDepoAmount" />
                        <input type="hidden" runat="server" id="hdnAge" />
                        <input type ="hidden" runat="server" id ="hdnPatientID" />
                        <br />
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>

    <script>
        function SetOtherCurrValues() {
            var pnetAmt = 0;
            var ConValue = "OtherCurrencyDisplay1";
            SetPaybleOtherCurr(pnetAmt, ConValue, true);
        }
        GetCurrencyValues();
    </script>

</body>
</html>
