<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientWiseCombinedReport.aspx.cs"
    Inherits="Reports_PatientWiseCombinedReport" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
          <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function validateToDate() {

            if (document.getElementById('txtFDate').value == '') {
                var userMsg = SListForApplicationMessages.Get('CommonMessages_18');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {

                    alert('Provide / select value for From date');
                }
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                var userMsg = SListForApplicationMessages.Get('CommonMessages_19');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Provide / select value for To date');
                }
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
    
    </script>

    <style type="text/css">
        .style1
        {
            width: 370px;
        }
        .style2
        {
            width: 15px;
        }
        .style3
        {
            width: 111px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
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
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tblCollectionOPIP" align="center" width="100%">
                            <tr align="center">
                                <td align="left">
                                    <div class="dataheaderWider">
                                        <table id="tbl">
                                            <tr>
                                                <td class="style1">
                                                    <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                    <asp:TextBox ID="txtFDate" CssClass ="Txtboxsmall" Width ="120px" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                        PopupButtonID="ImgFDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                </td>
                                                <td class="style1">
                                                    <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                    <asp:TextBox ID="txtTDate" CssClass ="Txtboxsmall" Width ="120px" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                        PopupButtonID="ImgTDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_SelectConsultant" Text="Select Consultant:" runat="server" meta:resourcekey="Rs_SelectConsultantResource1"></asp:Label>
                                                </td>
                                                <td align="left" class="style2">
                                                    <asp:DropDownList ID="ddlPhysician" ToolTip="Click here to Select Physician" CssClass ="ddlsmall"
                                                        runat="server" meta:resourcekey="ddlPhysicianResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="style3">
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                </td>
                                                <td>
                                                    <%--                                                    <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click"
                                                        meta:resourcekey="lnkBackResource1">
                                                        <asp:Label ID="Rs_Back" Text="Back" runat="server" meta:resourcekey="Rs_BackResource1"></asp:Label>
                                                        &nbsp;&nbsp;&nbsp;</asp:LinkButton>--%>
                                                    <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " 
                                                        CssClass="details_label_age" OnClick="lnkBack_Click" 
                                                        meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:UpdateProgress ID="Progressbar" runat="server">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <asp:Label ID="lblMessage" runat="server" Text="No Matching Records Found!" Font-Bold="True"
                                                Visible="False" meta:resourcekey="lblMessageResource1"></asp:Label>
                                            <asp:GridView ID="gvReport" CssClass="mytable1" runat="server" AutoGenerateColumns="False"
                                                Visible="False" Width="100%" meta:resourcekey="gvReportResource1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField HeaderText="Year" DataField="Year" meta:resourcekey="BoundFieldResource1" />
                                                    <asp:BoundField HeaderText="Month" DataField="Month" meta:resourcekey="BoundFieldResource2">
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Date" DataField="Date" meta:resourcekey="BoundFieldResource3">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Screened At" DataField="ScreenedAt" meta:resourcekey="BoundFieldResource4" />
                                                    <asp:BoundField HeaderText="Revenue Centre" DataField="RevenueCentre" meta:resourcekey="BoundFieldResource5" />
                                                    <asp:BoundField HeaderText="Dr.Name" DataField="DrName" meta:resourcekey="BoundFieldResource6" />
                                                    <asp:BoundField HeaderText="Dr.Category" DataField="DrCategory" meta:resourcekey="BoundFieldResource7" />
                                                    <asp:BoundField HeaderText="Refered By" DataField="ReferedBy" meta:resourcekey="BoundFieldResource8" />
                                                    <asp:BoundField HeaderText="Bill No" DataField="BillNo" meta:resourcekey="BoundFieldResource9" />
                                                    <asp:BoundField HeaderText="Receipt No" DataField="ReceiptNo" meta:resourcekey="BoundFieldResource10" />
                                                    <asp:BoundField HeaderText="Patient Name" DataField="PatientName" meta:resourcekey="BoundFieldResource11" />
                                                    <asp:BoundField HeaderText="Visit Type" DataField="VisitType" meta:resourcekey="BoundFieldResource12" />
                                                    <asp:BoundField HeaderText="Mode Of Payment" DataField="ModeOfPayment" meta:resourcekey="BoundFieldResource13" />
                                                    <asp:BoundField HeaderText="Panel Name" DataField="PanelName" meta:resourcekey="BoundFieldResource14" />
                                                    <asp:BoundField HeaderText="Surgery Name" DataField="SurgeryName" meta:resourcekey="BoundFieldResource15" />
                                                    <asp:BoundField HeaderText="Surgery Type" DataField="SurgeryType" meta:resourcekey="BoundFieldResource16" />
                                                    <asp:BoundField HeaderText="Lense Name" DataField="LenseName" meta:resourcekey="BoundFieldResource17" />
                                                    <asp:BoundField HeaderText="Lense Price" DataField="LensePrice" DataFormatString="{0:0.00}"
                                                        meta:resourcekey="BoundFieldResource18">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Surgical Fee" DataField="SurgicalFee" meta:resourcekey="BoundFieldResource19">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Discount Remarks" DataField="DiscountRemarks" meta:resourcekey="BoundFieldResource20" />
                                                    <asp:BoundField HeaderText="OPD Credit" DataFormatString="{0:0.00}" DataField="OPDCredit"
                                                        meta:resourcekey="BoundFieldResource21">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="OPD Cash" DataFormatString="{0:0.00}" DataField="OPDCash"
                                                        meta:resourcekey="BoundFieldResource22">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Surgery Credit" DataFormatString="{0:0.00}" DataField="SurgeryCredit"
                                                        meta:resourcekey="BoundFieldResource23">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Surgery Cash" DataFormatString="{0:0.00}" DataField="SurgeryCash"
                                                        meta:resourcekey="BoundFieldResource24">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="OPD PRO Credit" DataFormatString="{0:0.00}" DataField="OPDPROCredit"
                                                        meta:resourcekey="BoundFieldResource25">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="OPD PRO Cash" DataFormatString="{0:0.00}" DataField="OPDPROCash"
                                                        meta:resourcekey="BoundFieldResource26">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Credit Card Payment" DataFormatString="{0:0.00}" DataField="CreditCardPayment"
                                                        meta:resourcekey="BoundFieldResource27">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Cheque Payment" DataFormatString="{0:0.00}" DataField="ChequePayment"
                                                        meta:resourcekey="BoundFieldResource28">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Bill Status" DataField="BillStatus" meta:resourcekey="BoundFieldResource29" />
                                                    <asp:BoundField HeaderText="Bill Amount" DataField="BillAmount" DataFormatString="{0:0.00}"
                                                        meta:resourcekey="BoundFieldResource30">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Referral Commission" DataField="ReferralCommission" DataFormatString="{0:0.00}"
                                                        meta:resourcekey="BoundFieldResource31">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Bill Sub Date" DataField="BillSubDate" DataFormatString="{0:dd-MMM-yyyy}"
                                                        meta:resourcekey="BoundFieldResource32" />
                                                    <asp:BoundField HeaderText="Bill Sub Amount" DataField="BillSubAmount" DataFormatString="{0:0.00}"
                                                        meta:resourcekey="BoundFieldResource33">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Payment Status" DataField="PaymentStatus" meta:resourcekey="BoundFieldResource34" />
                                                    <asp:BoundField HeaderText="Pay Rec Date" DataField="PayRecDate" DataFormatString="{0:dd-MMM-yyyy}"
                                                        meta:resourcekey="BoundFieldResource35" />
                                                    <asp:BoundField HeaderText="Receipt Amount" DataField="ReceiptAmount" meta:resourcekey="BoundFieldResource36">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Cheque No" DataField="ChequeNo" meta:resourcekey="BoundFieldResource37">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Cheque Date" DataField="ChequeDate" meta:resourcekey="BoundFieldResource38" />
                                                    <asp:BoundField HeaderText="Bank Name" DataField="BankName" meta:resourcekey="BoundFieldResource39" />
                                                    <asp:BoundField HeaderText="Bank City" DataField="BankCity" meta:resourcekey="BoundFieldResource40" />
                                                    <asp:BoundField HeaderText="AR Ageing" DataField="ARAgeing" meta:resourcekey="BoundFieldResource41" />
                                                    <asp:BoundField HeaderText="DedNon-PayItems" DataField="DedNonPayItems" DataFormatString="{0:0.00}"
                                                        meta:resourcekey="BoundFieldResource42">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Discount" DataField="Discount" DataFormatString="{0:0.00}"
                                                        meta:resourcekey="BoundFieldResource43">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="TDS Deduction" DataField="TDSDeduction" DataFormatString="{0:0.00}"
                                                        meta:resourcekey="BoundFieldResource44">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Total Deduction" DataField="TotalDeduction" DataFormatString="{0:0.00}"
                                                        meta:resourcekey="BoundFieldResource45">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Packaging" DataField="Packaging" meta:resourcekey="BoundFieldResource46">
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
    </div>
    </form>
</body>
</html>
