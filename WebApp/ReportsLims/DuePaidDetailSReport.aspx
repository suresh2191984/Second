<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DuePaidDetailSReport.aspx.cs"
    Inherits="Reports_DuePaidDetailSReport" meta:resourcekey="PageResource1" %>

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
        function validateToDate() {

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
                                                <td align="right">
                                                    <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" 
                                                        meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtFDate" runat="server" CssClass="Txtboxsmall" Width ="120px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                        PopupButtonID="ImgFDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" 
                                                        meta:resourcekey="MaskedEditValidator5Resource1" />
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" 
                                                        meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtTDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                        PopupButtonID="ImgTDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                                                        meta:resourcekey="MaskedEditValidator1Resource1" />
                                                </td>
                                                <td align="left">
                                                    <asp:Button ID="btnSearch" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" 
                                                        meta:resourcekey="imgBtnXLResource1" />
                                                </td>
                                                <td align="left">
                                                    <asp:LinkButton ID="lnkBack"  Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age" 
                                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="7" align="left">
                                                    <table id="tabCurrency" runat="server">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Rs_SelectCurrency" Text="Select Currency" runat="server" 
                                                                    meta:resourcekey="Rs_SelectCurrencyResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlCurrency" ToolTip="Select Currency" runat="server" 
                                                                CssClass ="ddllarge" meta:resourcekey="ddlCurrencyResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:UpdateProgress ID="Progressbar" runat="server">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                                                meta:resourcekey="imgProgressbarResource1" />
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" 
                                                meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                    <div id="divPrint" style="display: none;" runat="server">
                                        <table cellpadding="0" cellspacing="0" border="0" width="95%">
                                            <tr>
                                                <td align="right" style="padding-right: 10px; color: #000000;">
                                                    <b id="printText" runat="server">
                                                        <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" 
                                                        meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
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
                                                            <asp:Label ID="lblmsg" runat="server" Text="No Records Found" Visible="False" 
                                                                meta:resourcekey="lblmsgResource1"></asp:Label>
                                                            <asp:GridView ID="gvDuepaidReport" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                AllowPaging="True" PageSize="100" CssClass="dataheader2" OnRowDataBound="gvDuepaidReport_RowDataBound"
                                                                OnPageIndexChanging="gvDuepaidReport_PageIndexChanging" ShowFooter="True" 
                                                                meta:resourcekey="gvDuepaidReportResource1">
                                                                <HeaderStyle HorizontalAlign="Left" CssClass="dataheader1"></HeaderStyle>
                                                                <PagerStyle CssClass="dataheader1" />
                                                                <RowStyle HorizontalAlign="Left"></RowStyle>
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Patient Name" 
                                                                        meta:resourcekey="TemplateFieldResource1">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblName" runat="server" Text='<%# Bind("PatientName") %>' 
                                                                                Width="100px" meta:resourcekey="lblNameResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Age" meta:resourcekey="TemplateFieldResource2">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>' 
                                                                                meta:resourcekey="lblAgeResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Due BillNo" 
                                                                        meta:resourcekey="TemplateFieldResource3">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDueBillNo" runat="server" Text='<%# Bind("DueBillNo") %>' 
                                                                                meta:resourcekey="lblDueBillNoResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                     <asp:TemplateField HeaderText="Due Paid BillNo" 
                                                                        meta:resourcekey="TemplateFieldResource7">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblpaidBillNo" runat="server" Text='<%# Bind("PaidBillNo") %>' 
                                                                                meta:resourcekey="lblpaidBillNoResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Due Bill Date" 
                                                                        meta:resourcekey="TemplateFieldResource4">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDueBillDate" runat="server" Text='<%# Bind("DueBillDate") %>' 
                                                                                meta:resourcekey="lblDueBillDateResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Paid Amount" 
                                                                        meta:resourcekey="TemplateFieldResource5">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPaidAmount" runat="server" Text='<%# Bind("PaidAmount") %>' 
                                                                                meta:resourcekey="lblPaidAmountResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Paid Date" 
                                                                        meta:resourcekey="TemplateFieldResource6">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPaidDate" runat="server" Text='<%# Bind("PaidDate") %>' 
                                                                                meta:resourcekey="lblPaidDateResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="PaidCurrency" HeaderText="Paid Currency" 
                                                                        meta:resourcekey="BoundFieldResource1" />
                                                                    <asp:BoundField DataField="PaidCurrencyAmount"
                                                                        HeaderText="Paid Currency Amt" meta:resourcekey="BoundFieldResource2" >
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="centre">
                                                            <asp:Label ID="lblPaidAmount" runat="server" 
                                                                meta:resourcekey="lblPaidAmountResource2"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            </div>
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
