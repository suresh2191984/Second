<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Advance.aspx.cs" Inherits="Reception_Advance" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
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
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Advance Payments</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--<link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />--%>
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>
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
        var dReceiptNo = document.getElementById('<%= hdnReceiptNo.ClientID %>').value ;
        var dBdetNo  = document.getElementById('<%= hdnIPINterID.ClientID %>').value ;
        var sptype = document.getElementById('<%= hdnPayType.ClientID %>').value ;
        var pvid = document.getElementById('<%=hdnVisitID.ClientID %>').value;
        var PNo = document.getElementById('<%=hdnPNumber.ClientID %>').value;
        //alert(dAmount);
        if((dAmount !='')&&(Number(dAmount) > 0))
        {
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
            strFeatures = strFeatures + ",left=0,top=0";
            var strURL = "PrintReceiptPage.aspx?Amount=" + dAmount + "&dDate=" + dDate+ "&rcptno=" + dReceiptNo + "&PNAME=<%=Request.QueryString["PNAME"] %>&pdid=" + dBdetNo +"&pDet=" + sptype + "&VID=" + pvid + "&PNumber=" + PNo +"";
            window.open(strURL, "", strFeatures, true);
             var ConValue = "OtherCurrencyDisplay1";
            SetReceivedOtherCurr(0, 0, ConValue);
        }
        else
        { 
                var userMsg = SListForApplicationMessages.Get('InPatient\\Advance.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Select a payment');
                return false ;
                }
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

    <style type="text/css">
        .style2
        {
            height: 21px;
        }
    </style>

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
                  var userMsg = SListForApplicationMessages.Get('InPatient\\Advance.aspx_2');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Amount cannot be zero');
                return false;
            }
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
//            var alte = PaymentSaveValidation();
//            if (alte == true) {
                return true;
//            }
//            else {
//                return false;
//            }
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
                        <uc121:LeftMenu ID="LeftMenu1" runat="server" />
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
                                            <td class="style2">
                                               <asp:Label ID="Rs_PatientNumber" Text="Patient Number :" runat="server" 
                                                    meta:resourcekey="Rs_PatientNumberResource1"></asp:Label>
                                            </td>
                                            <td class="style2">
                                                <asp:Label ID="lblPatientID" runat="server" Font-Bold="True" 
                                                    meta:resourcekey="lblPatientIDResource1"></asp:Label>
                                            </td>
                                            <td class="style2">
                                                &nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td class="style2">
                                               <asp:Label  ID="Rs_PatientName" Text="Patient Name :" runat="server" 
                                                    meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                            </td>
                                            <td class="style2">
                                                <asp:Label ID="lblPatientName" runat="server" Font-Bold="True" 
                                                    meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="Preauth" runat="server" style="display: none">
                                            <td>
                                                <asp:Label ID="Label1" runat="server" Text="Pre Authorization Amount :" 
                                                    Font-Bold="True" meta:resourcekey="Label1Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblPreAuthAmount" runat="server" Font-Bold="True" 
                                                    meta:resourcekey="lblPreAuthAmountResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-decoration: none">
                                    <div id="divAdvance">
                                        <asp:Panel ID="pnltempAdvancePayments" runat="server" 
                                            CssClass="defaultfontcolor" meta:resourcekey="pnltempAdvancePaymentsResource1">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td class="colorforcontent" width=" 25%" height="23" align="left">
                                                        <div id="ACX2plusAdvPmt" style="display: block; width: 393px">
                                                            &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',1);">
                                                                &nbsp;<asp:Label ID="Rs_Info" Text="Previous Advance Payments Total :" 
                                                                runat="server" meta:resourcekey="Rs_InfoResource1"></asp:Label>&nbsp;<asp:Label 
                                                                ID="lblAdvancePaid" runat="server" meta:resourcekey="lblAdvancePaidResource1"></asp:Label>
                                                            </span>
                                                        </div>
                                                        <div id="ACX2minusAdvPmt" style="display: none;">
                                                            &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',0);">
                                                            &nbsp;<asp:Label ID="Rs_PreviousAdvancePayments" Text="Previous Advance Payments" 
                                                                runat="server" meta:resourcekey="Rs_PreviousAdvancePaymentsResource1"></asp:Label>
                                                        </div>
                                                    </td>
                                                    <td style="width: 75%" height="23" align="left">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr class="tablerow" id="ACX2responsesAdvPmt" style="display: none;">
                                                    <td colspan="2">
                                                        <div class="filterdatahe">
                                                            <asp:GridView ID="gvAdvancePaidDetails" runat="server" AutoGenerateColumns="False"
                                                                BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                                CellPadding="3" Font-Bold="False" Width="50%" 
                                                                OnRowDataBound="gvAdvancePaidDetails_RowDataBound" 
                                                                meta:resourcekey="gvAdvancePaidDetailsResource1" style="margin-top: 0px">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Select" 
                                                                        meta:resourcekey="TemplateFieldResource1">
                                                                        <ItemTemplate>
                                                                            <asp:RadioButton ID="rdoID" runat="server" meta:resourcekey="rdoIDResource1" 
                                                                                name="rdoID" />
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt Number" 
                                                                        meta:resourcekey="BoundFieldResource1">
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="AdvanceAmount" HeaderText="Amount" 
                                                                        meta:resourcekey="BoundFieldResource2">
                                                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="PaidDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" 
                                                                        HeaderText="Paid Date" meta:resourcekey="BoundFieldResource3">
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                <RowStyle ForeColor="#000066" />
                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                            </asp:GridView>
                                                            <div align="right" style="width: 240px; font-weight: bold;" class="grdtxt">
                                                               <asp:Label ID="Rs_Total" Text="Total:" runat="server" 
                                                                    meta:resourcekey="Rs_TotalResource1"></asp:Label>&nbsp;<asp:Label 
                                                                    ID="lblAdvancePaid1" runat="server" meta:resourcekey="lblAdvancePaid1Resource1"></asp:Label>
                                                            </div>
                                                            <asp:Button ID="btnPrint" runat="server" Text="Print Receipt" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                                                onmouseout="this.className='btn1'" 
                                                                OnClientClick='PopUpPage();return false;' 
                                                                meta:resourcekey="btnPrintResource1" />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        <br clear="all" />
                                        <asp:Label ID="Rs_TotalAmount" Text="Total Amount :" runat="server" 
                                            meta:resourcekey="Rs_TotalAmountResource1"></asp:Label>
                                        <asp:TextBox ID="txtPayment" Width="93px" Style="text-align: right;" runat="server"
                                            ReadOnly="True"  CssClass ="Txtboxsmall" meta:resourcekey="txtPaymentResource1"></asp:TextBox>
                                        <asp:Label ID="Rs_ServiceCharge" Text="Service Charge:" runat="server" 
                                            meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
                                        <asp:TextBox ID="txtServiceCharge" Width="90px" Enabled="False" runat="server" Text="0.00"
                                            TabIndex="9"  CssClass ="Txtboxsmall" Font-Bold="True" 
                                            meta:resourcekey="txtServiceChargeResource1" />
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
                                    &nbsp;<asp:Button ID="btnSave" runat="server" Text="Finish" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" OnClientClick="javascript:return chkCreditPament();"
                                        OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                    &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" OnClick="btnCancel_Click" 
                                        meta:resourcekey="btnCancelResource1" />
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
                        <input type="hidden" runat="server" id="hdnPNumber" />
                        <asp:HiddenField ID="hdnVisitID" runat="server" />
                        <br />
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
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
