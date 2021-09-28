<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientDepositReport.aspx.cs"
    Inherits="Reports_PatientDepositReport" meta:resourcekey="PageResource1" %>

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

    <script language="javascript" type="text/javascript">
        function validateDateName() {
            if (document.getElementById('txtpatname').value == '') {

                if (document.getElementById('txtFDate').value == '') {
                    alert('Enter From Date');
                    document.getElementById('txtFDate').focus();
                    return false;
                }
                if (document.getElementById('txtTDate').value == '') {
                    alert('Enter To Date');
                    document.getElementById('txtTDate').focus();
                    return false;
                }
            }
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
            return false;
        }

        function popupprintD() {
            var prtContent = document.getElementById('tblPatientDetail');
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
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tblICDreport" align="center" width="100%">
                            <tr align="left">
                                <td>
                                    <div class="dataheaderWider">
                                        <table id="tbl">
                                            <tr>
                                                <td colspan="7" align="center">
                                                    <asp:Label ID="lblRpt" Text="Search Based On Patient Registration Date" Font-Bold="True"
                                                        runat="server" meta:resourcekey="lblRptResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtFDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
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
                                                <td align="right">
                                                    <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtTDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
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
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbpatname" runat="server" Text="Patient Name:" meta:resourcekey="lbpatnameResource1" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtpatname" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtpatnameResource1" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkSmart" Text="Show Smart Card Holders Only" runat="server" meta:resourcekey="chkSmartResource1" />
                                                </td>
                                                <td align="left">
                                                    <asp:Button ID="btnSearch" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateDateName();"
                                                        OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                </td>
                                                <td align="left">
                                                    <%-- <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click"
                                                        meta:resourcekey="lnkBackResource1">
                                                        <asp:Label ID="Rs_Back" Text="Back" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;</asp:LinkButton>--%>
                                                    <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " 
                                                        CssClass="details_label_age" OnClick="lnkBack_Click" 
                                                        meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <%-- <tr>
                                            <td colspan="7" align="left">
                                              <table id="tabCurrency" runat="server">
                                                           <tr>
                                                           <td>
                                                           Select Currency
                                                           </td>
                                                           <td>
                                                            <asp:DropDownList ID="ddlCurrency" ToolTip="Select Currency" runat="server"
                                                                                Width="250px">
                                                                            </asp:DropDownList>
                                                           </td>
                                                           </tr>
                                                           </table>
                                            </td>
                                            </tr>--%>
                                            <tr>
                                                <td colspan="4" id="tdnotfound" runat="server" align="left" visible="false">
                                                    <asp:Label ID="lblmsg" runat="server" Text="No Records Found" meta:resourcekey="lblmsgResource1"></asp:Label>
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
                                    <div id="divPrint" style="display: none;" runat="server">
                                        <table cellpadding="0" cellspacing="0" border="0" width="95%">
                                            <tr>
                                                <td align="right" style="padding-right: 10px; color: #000000;">
                                                    <b id="printText" runat="server">
                                                        <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>&nbsp;&nbsp;
                                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div id="prnReport">
                                                <table width="100%">
                                                    <tr>
                                                        <td class="dataheaderInvCtrl">
                                                            <asp:GridView ID="gvDepositRpt" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                AllowPaging="True" PageSize="100" CssClass="dataheader2" ShowFooter="True" OnPageIndexChanging="gvDepositRpt_PageIndexChanging1"
                                                                OnRowDataBound="gvDepositRpt_RowDataBound" meta:resourcekey="gvDepositRptResource1">
                                                                <HeaderStyle HorizontalAlign="Left" CssClass="dataheader1"></HeaderStyle>
                                                                <PagerStyle CssClass="dataheader1" />
                                                                <RowStyle HorizontalAlign="Center"></RowStyle>
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Patient Number" meta:resourcekey="TemplateFieldResource1">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblNo" runat="server" Text='<%# Bind("PatientNumber") %>' Width="15px"
                                                                                meta:resourcekey="lblNoResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Patient Name" meta:resourcekey="TemplateFieldResource2">
                                                                        <ItemTemplate>
                                                                            <asp:HyperLink ID="hypName" ForeColor="Blue" h Font-Size="12px" Text='<%# Bind("Name") %>'
                                                                                Target="_blank" runat="server" Width="150px" meta:resourcekey="hypNameResource1"></asp:HyperLink>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Age" meta:resourcekey="TemplateFieldResource3">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>' Width="70px" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="SmartCard No" meta:resourcekey="TemplateFieldResource4">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSmartCardNo" runat="server" Text='<%# Bind("SmartCardNumber") %>'
                                                                                meta:resourcekey="lblSmartCardNoResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Contact No" meta:resourcekey="TemplateFieldResource5">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblContactNo" runat="server" Text='<%# Bind("MobileNumber") %>' meta:resourcekey="lblContactNoResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Address" meta:resourcekey="TemplateFieldResource6">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("Address") %>' meta:resourcekey="lblAddressResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Total Deposit Amount" meta:resourcekey="TemplateFieldResource7">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblTDA" runat="server" Text='<%# Bind("TotalDepositAmount") %>' meta:resourcekey="lblTDAResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Total Deposit Used" meta:resourcekey="TemplateFieldResource8">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblTDU" runat="server" Text='<%# Bind("TotalDepositUsed") %>' meta:resourcekey="lblTDUResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Balance Amount" meta:resourcekey="TemplateFieldResource9">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBA" runat="server" Text='<%# Bind("DepositBalance") %>' meta:resourcekey="lblBAResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Amount Refunded" meta:resourcekey="TemplateFieldResource10">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblRefundAmt" runat="server" Text='<%# Bind("AmtRefund") %>' Width="15px"
                                                                                meta:resourcekey="lblRefundAmtResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:HiddenField ID="Hdnsmartcard" runat="server" />
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
