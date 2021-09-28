<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InsuranceCorpReport.aspx.cs"
    Inherits="Reports_InsuranceCorpReport" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="~/CommonControls/InsuranceSearch.ascx" TagName="Insurance" TagPrefix="ucINC" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
            <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function validateToDate() {

            if (document.getElementById('txtFDate').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('txtTDate').focus();
                return false;
            }
            if (document.getElementById('ddlTpaName').style.display == "block")
                document.getElementById('ddlTpaName').style.display = "block";
            if (document.getElementById('ddlCorporate').style.display == "block")
                document.getElementById('ddlCorporate').style.display = "block";

        }


        function ShowDDl() {

            var obj = document.getElementById('ddlType');

            if (obj.options[obj.selectedIndex].value == 1) {
                document.getElementById('ddlCorporate').style.display = "block";
                document.getElementById('ddlTpaName').style.display = "none";
                document.getElementById('ddlTpaName').selectedIndex = "0";
            }
            else if (obj.options[obj.selectedIndex].value == 2) {
                document.getElementById('ddlTpaName').style.display = "block";
                document.getElementById('ddlCorporate').style.display = "none";
                document.getElementById('ddlCorporate').selectedIndex = "0";
            }
            else {
                document.getElementById('ddlCorporate').selectedIndex = "0";
                document.getElementById('ddlTpaName').selectedIndex = "0";
                document.getElementById('ddlCorporate').style.display = "none";
                document.getElementById('ddlTpaName').style.display = "none";
            }
            return false;
        }
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

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
                        <table width="100%" border="0" cellpadding="4" cellspacing="0" class="defaultfontcolor">
                            <tr>
                                <td>
                                    <table width="80%" border="0" cellpadding="4" cellspacing="0" class="defaultfontcolor"
                                        align="center" class="dataheaderInvCtrl">
                                        <tr>
                                            <td>
                                                <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtFDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
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
                                            <td>
                                                <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
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
                                        </tr>
                                        <tr id="trPatient" runat="server">
                                            <td style="width: 13%">
                                                <asp:Label ID="Rs_PatientNo" Text="Patient No" runat="server" meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                                            </td>
                                            <td style="width: 39%">
                                                <asp:TextBox ID="txtPatientNo" CssClass ="Txtboxsmall" Width ="120px" runat="server" MaxLength="16" onkeypress="return onEnterKeyPress(event);"
                                                    meta:resourcekey="txtPatientNoResource1"></asp:TextBox>
                                            </td>
                                            <td style="width: 20%">
                                                <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                            </td>
                                            <td style="width: 28%">
                                                <asp:TextBox ID="txtPatientName" CssClass ="Txtboxsmall" Width ="120px" runat="server" MaxLength="255" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Rs_CorporateInsurance" Text="Corporate/Insurance" runat="server" meta:resourcekey="Rs_CorporateInsuranceResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:DropDownList ID="ddlType" onChange="javascript:return ShowDDl();" runat="server" CssClass ="ddlsmall"
                                                             Width ="120px"    meta:resourcekey="ddlTypeResource1">
                                                                <asp:ListItem Text="Any" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                <asp:ListItem Text="Client" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                <asp:ListItem Text="Insurance" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlTpaName" Style="display: none" runat="server" meta:resourcekey="ddlTpaNameResource1">
                                                            </asp:DropDownList>
                                                            <asp:DropDownList ID="ddlCorporate" Style="display: none" runat="server" meta:resourcekey="ddlCorporateResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td nowrap="nowrap">
                                                <asp:Label ID="Rs_PaymentType" Text="Payment Type" runat="server" meta:resourcekey="Rs_PaymentTypeResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPaymentype" runat="server" CssClass ="ddlsmall" Width ="120px" TabIndex="39" meta:resourcekey="ddlPaymentypeResource1">
                                                    <asp:ListItem Text="Pending" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                    <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <Triggers>
                                            <%--<asp:PostBackTrigger ControlID="lnkExportXL" />--%>
                                            <asp:PostBackTrigger ControlID="imgBtnXL" />
                                        </Triggers>
                                        <ContentTemplate>
                                            <table width="100%" border="0" cellpadding="4" cellspacing="0" class="defaultfontcolor">
                                                <tr>
                                                    <td>
                                                        <tr>
                                                            <td colspan="4" align="center">
                                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                                                    onmouseout="this.className='btn'" OnClick="btnSearch_Click" OnClientClick="return validateToDate();"
                                                                    meta:resourcekey="btnSearchResource1" />
                                                                &nbsp;
                                                                <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                                    OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4" align="center">
                                                                &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblResult" runat="server" Text="No matching records found"
                                                                    Font-Bold="True" Visible="False" meta:resourcekey="lblResultResource1"></asp:Label>
                                                                <asp:Label ID="lblTPC" runat="server" Font-Bold="True" Visible="False" ForeColor="Red"
                                                                    meta:resourcekey="lblTPCResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4" align="center">
                                                                <asp:UpdateProgress ID="Progressbar" runat="server">
                                                                    <ProgressTemplate>
                                                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" Height="16px"
                                                                            Width="16px" meta:resourcekey="imgProgressbarResource1" />
                                                                        <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                                                    </ProgressTemplate>
                                                                </asp:UpdateProgress>
                                                                <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                                    ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" Width="16px"
                                                                    Visible="False" meta:resourcekey="imgBtnXLResource1" />
                                                                <asp:HyperLink ID="hypLnkPrint" Font-Underline="True" Font-Bold="True" Visible="False"
                                                                    Font-Size="12px" ForeColor="Black" Target="BillWindow" runat="server" ToolTip="Click Here To Print Sales Tax Report"
                                                                    meta:resourcekey="hypLnkPrintResource1">
                                                                    Print Insurance &amp; Corporate Report<img id="imgPrint" runat="server" style="border-width: 0px;"
                                                                        src="~/Images/printer.gif" />
                                                                </asp:HyperLink>
                                                            </td>
                                                        </tr>
                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblStatus" Text="No Matching Records Found!" runat="server" Visible="False"
                                                                        meta:resourcekey="lblStatusResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:GridView ID="grdResult" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                        DataKeyNames="PatientID,PatientVisitID" OnRowDataBound="grdResult_RowDataBound"
                                                                        PageSize="25" OnPageIndexChanging="grdResult_PageIndexChanging" ShowFooter="True"
                                                                        HorizontalAlign="Right" meta:resourcekey="grdResultResource1">
                                                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                            PageButtonCount="5" PreviousPageText="" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="S.No">
                                                                                <ItemTemplate>
                                                                                    <%# Container.DataItemIndex + 1 %>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="PatientID" HeaderText="PatientID" Visible="False" meta:resourcekey="BoundFieldResource1" />
                                                                            <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource2" />
                                                                            <asp:BoundField DataField="PatientNumber" HeaderText="Patient No." meta:resourcekey="BoundFieldResource3" />
                                                                            <asp:TemplateField HeaderText="Admission Date" meta:resourcekey="TemplateFieldResource1">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblAdmissionDate" runat="server" meta:resourcekey="lblAdmissionDateResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Discharge Date" meta:resourcekey="TemplateFieldResource2">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDischaredDT" runat="server" meta:resourcekey="lblDischaredDTResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="RefPhysicianName" HeaderText="Ref Physician" meta:resourcekey="BoundFieldResource4">
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="PrimaryConsultant" HeaderText="Consultant Name" meta:resourcekey="BoundFieldResource5">
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="TPAName" HeaderText="TPA / Corporate" meta:resourcekey="BoundFieldResource6">
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="PreAuthAmount" HeaderText="PreAuth Amount" meta:resourcekey="BoundFieldResource7">
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:BoundField>
                                                                            <asp:TemplateField HeaderText="Bill Amount" meta:resourcekey="TemplateFieldResource3">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblBillAmount" runat="server" Text='<%# Bind("GrossAmount") %>' meta:resourcekey="lblBillAmountResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Recieved From Patient" meta:resourcekey="TemplateFieldResource4">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblRecievedAmount" runat="server" Text='<%# Bind("RecievedAmount") %>'
                                                                                        meta:resourcekey="lblRecievedAmountResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Refund / Discount " meta:resourcekey="TemplateFieldResource5">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblRefund" runat="server" meta:resourcekey="lblRefundResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Claim From TPA" meta:resourcekey="TemplateFieldResource6">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblClaimFromTPA" runat="server" Text='<%# Bind("TPABillAmount") %>'
                                                                                        meta:resourcekey="lblClaimFromTPAResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Received From TPA" meta:resourcekey="TemplateFieldResource7">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblPaidByTPA" runat="server" Text='<%# Bind("PaidByTPA") %>' meta:resourcekey="lblPaidByTPAResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="TDS" meta:resourcekey="TemplateFieldResource8">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblTDS" runat="server" Text='<%# Bind("TDSAmount") %>' meta:resourcekey="lblTDSResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="WriteOff" meta:resourcekey="TemplateFieldResource9">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblWriteOff" runat="server" Text='<%# Bind("WriteOff") %>' meta:resourcekey="lblWriteOffResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Claim Forwarded Date" meta:resourcekey="TemplateFieldResource10">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblCliamForwardDate" runat="server" meta:resourcekey="lblCliamForwardDateResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Settlement Date" meta:resourcekey="TemplateFieldResource11">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblTPASettlementDate" runat="server" meta:resourcekey="lblTPASettlementDateResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
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
    </div>
    </form>
</body>
</html>
