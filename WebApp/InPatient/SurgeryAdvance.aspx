<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SurgeryAdvance.aspx.cs" Inherits="InPatient_SurgeryAdvance"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/SurgeryAdvanceQuickBill.ascx" TagName="SurgeryAdvance"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Advance Payments</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet"
        type="text/css" />--%>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script src ="../scripts/MessageHandler.js" language ="javascript" type ="text/javascript" ></script>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">

    <script type="text/javascript">
        function openPOPupQuick(url) {
            window.open(url, "PrictBill", "letf=0,top=0,toolbar=0,scrollbars=0,status=0");
        }
        function SurgeryModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {



            var oldAmount = document.getElementById('<%= txtSurAmount.ClientID %>').value;


            oldAmount = Number(oldAmount) + Number(TotalAmount);



            //var tempService = document.getElementById('txtsurService').value;
            //ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);

            var ConValue = "OtherCurrencyDisplay3";

            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = SurgeryGetOtherCurrency("OtherCurrRate", ConValue);

            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
            sVal = format_number(Number(sVal) + Number(TotalAmount), 4);

            SurgerySetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
            var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);




            document.getElementById('<%= hdnSurService.ClientID %>').value = format_number(pScrAmt, 2);
            document.getElementById('<%= txtsurService.ClientID %>').value = format_number(pScrAmt, 2);
            document.getElementById('<%= txtSurAmount.ClientID %>').value = format_number(pAmt, 2);
            document.getElementById('<%= hdnSurPayment.ClientID %>').value = format_number(pAmt, 2);
            SetOtherCurrValues();
            return true;

        }


        function SurgeryDeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            //            var oldAmount = document.getElementById('<%= txtSurAmount.ClientID %>').value;
            //            oldAmount = Number(oldAmount) - Number(TotalAmount);
            //            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            //            var tempService = document.getElementById('<%= txtsurService.ClientID %>').value;

            var ConValue = "OtherCurrencyDisplay3";
            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = SurgeryGetOtherCurrency("OtherCurrRate");

            sVal = Number(Number(sVal) - Number(TotalAmount));
            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);

            SurgerySetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);


            document.getElementById('<%= txtSurAmount.ClientID %>').value = format_number(sVal, 2);
            document.getElementById('<%= hdnSurPayment.ClientID %>').value = format_number(sVal, 2);
            document.getElementById('<%= txtsurService.ClientID %>').value = format_number(pScrAmt, 2);
            document.getElementById('<%= hdnSurService.ClientID %>').value = format_number(pScrAmt, 2);
            SetOtherCurrValues();
        }
        function checkForValues() {
            var alte = SurgeryPaymentSaveValidation();
            if (alte == true) {
                return true;
            }
            else {
                return false;
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




            
    </script>

    <asp:ScriptManager ID="scrpt" runat="server">
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
                                    <table width="100%" border="0">
                                        <tr>
                                            <%--  <td align="Right">
                                                Patient Number :
                                            </td>
                                            <td align="left" style="font-weight: bold;">
                                                <asp:Label ID="lblPatientID" runat="server" Text=""></asp:Label>
                                            </td>--%>
                                            <td align="Right">
                                                <asp:Label ID="Rs_PatientName" Text="Patient Name :" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                            </td>
                                            <td align="left" style="font-weight: bold;">
                                                <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="Preauth" runat="server" style="display: none">
                                            <td colspan="2" align="Right">
                                                <asp:Label ID="Label1" runat="server" Text="Pre Authorization Amount :" Font-Bold="True"
                                                    meta:resourcekey="Label1Resource1"></asp:Label>
                                            </td>
                                            <td colspan="2">
                                                <asp:Label ID="lblPreAuthAmount" runat="server" Font-Bold="True" meta:resourcekey="lblPreAuthAmountResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td colspan="4" id="divSurgeryAdvance">
                                                <table class="dataheaderInvCtrl" width="100%" border="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_TotalAmount" Text="Total Amount :" runat="server" meta:resourcekey="Rs_TotalAmountResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox  CssClass ="Txtboxsmall" ID="txtSurAmount" Width="70px" Style="text-align: right;"
                                                                runat="server" ReadOnly="True" Text="0.00" meta:resourcekey="txtSurAmountResource1"></asp:TextBox>
                                                            <asp:HiddenField ID="hdnSurPayment" runat="server" Value="0" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_ServiceCharge" Text="Service Charge :" runat="server" meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox  CssClass="Txtboxsmall" ID="txtsurService" Width="70px" Enabled="False"
                                                                runat="server" Text="0.00" Font-Bold="True" meta:resourcekey="txtsurServiceResource1" />
                                                            <asp:HiddenField ID="hdnSurService" runat="server" Value="0" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" colspan="4">
                                                            <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay3" IsDisplayPayedAmount="false"
                                                                runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4">
                                                            <uc2:SurgeryAdvance ID="SurgeryBilling1" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    &nbsp;<asp:Button ID="btnSave" runat="server" Text="Finish" CssClass="btn" onmouseover="this.className='btn btnhov1'"
                                        onmouseout="this.className='btn'" OnClick="btnSave_Click" OnClientClick="javascript:return checkForValues();"
                                        meta:resourcekey="btnSaveResource1" Width="98px" />
                                    &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov1'"
                                        onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1"
                                        Width="75px" />
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btn"
                                    PopupControlID="Panel1" BackgroundCssClass="modalBackground" DynamicServicePath=""
                                    Enabled="True" />
                                <input type="button" id="btn" runat="server" style="display: none;" />
                                <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup dataheaderPopup" Width="25%"
                                    Style="display: none" meta:resourcekey="Panel1Resource1">
                                    <table width="100%">
                                        <tr id="trErMsg" runat="server" style="display: none;">
                                            <td align="center" runat="server">
                                                <table width="90%">
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="Rs_Info" Text="Please settle surgery amount before making Final settlement"
                                                                runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="btnOK" runat="server" Text="Ok" OnClick="btnOk_Click" CssClass="btn"
                                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="trFinalSettleMent" runat="server" style="display: none;">
                                            <td align="center" runat="server">
                                                <table width="90%">
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="Rs_Proceedtofinallsettlement" Text="Proceed to finall settlement"
                                                                runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="btnFinalSettlement" runat="server" Text="Ok" OnClick="btnFinalSettlement_Click"
                                                                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <br />
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
        <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </div>
    </form>

    <script>
        GetSurgeryDetailForAdvance('<%= Request.QueryString["VID"] %>');
        SurgeryPaymentControlclear();
        SurgeryGetCurrencyValues();
        function SetOtherCurrValues() {
            var pnetAmt = 0;

            var ConValue = "OtherCurrencyDisplay3";
            SurgerySetPaybleOtherCurr(pnetAmt, ConValue, false);


        }
    </script>

</body>
</html>
