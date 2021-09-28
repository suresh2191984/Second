<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DptWiseRevenueRpt.aspx.cs"
    Inherits="Reports_DptWiseRevenueRpt" meta:resourcekey="PageResource1" %>

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
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/datetimepicker.css" rel="stylesheet" type="text/css">--%>
          <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

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
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tblCollectionOPIP" align="center" width="100%">
                            <tr align="center">
                                <td align="center">
                                    <div class="dataheaderWider">
                                        <table id="tbl">
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" 
                                                        meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtFDate" runat="server" CssClass ="Txtboxsmall" Width="120px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
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
                                                    <asp:TextBox ID="txtTDate" runat="server" CssClass ="Txtboxsmall"  Width ="120px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
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
                                                    <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" 
                                                        runat="server" meta:resourcekey="rblVisitTypeResource1">
                                                        <asp:ListItem Text="OP" Selected="True" Value="0" 
                                                            meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                        <%--<asp:ListItem Text="OP&IP" Value="-1"></asp:ListItem>--%>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" Style="width: 16px" 
                                                        meta:resourcekey="imgBtnXLResource1" />
                                                    <asp:LinkButton ID="lnkExportXL" Text="Export To XL" Font-Underline="True"  
                                                        runat="server" Font-Bold="True" Font-Size="12px"
                                                        ForeColor="Black" ToolTip="Save As Excel" OnClick="lnkExportXL_Click" 
                                                        meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>
                                                </td>
                                                <td align="left">
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                </td>
                                                <td align="left">
                                                    <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age" 
                                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <table id="tabCurrency" runat="server">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Rs_SelectCurrency" Text="Select Currency" runat="server" 
                                                                    meta:resourcekey="Rs_SelectCurrencyResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlCurrency" ToolTip="Select Currency" runat="server" 
                                                                    Width="250px" meta:resourcekey="ddlCurrencyResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td>
                                                    <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" 
                                                        runat="server" meta:resourcekey="rblReportTypeResource1">
                                                        <asp:ListItem Text="Summary" Selected="True" Value="0" 
                                                            meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                        <asp:ListItem Text="Detail" Value="1" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
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
                                            <div id="divOPDWCR" runat="server" style="display: block;">
                                                <div id="prnReport" style="font-family: Verdana; text-decoration: none; font-size: 10px;">
                                                    <asp:GridView ID="gvIPReport" runat="server" AutoGenerateColumns="False" Visible="False"
                                                        Width="100%" OnRowDataBound="gvIPReport_RowDataBound" Font-Names="verdana" 
                                                        Font-Size="10px" meta:resourcekey="gvIPReportResource1">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Collection Report" 
                                                                meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                        <tr>
                                                                            <td align="left" style="height: 25px;">
                                                                                <b>
                                                                                    <asp:Label ID="Rs_Date" Text="Date:" runat="server" 
                                                                                    meta:resourcekey="Rs_DateResource1"></asp:Label></b>
                                                                                <asp:LinkButton ID="lnkDate" ForeColor="Blue" Font-Bold="True" Font-Size="12px" Text='<%# Eval("VisitDate", "{0:dd/MM/yyyy}") %>'
                                                                                    runat="server" meta:resourcekey="lnkDateResource1"></asp:LinkButton>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                                    ForeColor="#333333" CssClass="mytable1" OnRowDataBound="gvIPCreditMain_RowDataBound"
                                                                                    OnRowCommand="gvIPCreditMain_RowCommand" 
                                                                                    meta:resourcekey="gvIPCreditMainResource1">
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="Department Name" 
                                                                                            meta:resourcekey="TemplateFieldResource1">
                                                                                            <ItemTemplate>
                                                                                                <asp:LinkButton ID="lnkDept" ForeColor="Blue" Font-Size="12px" Text='<%# Eval("FeeType") %>'
                                                                                                    runat="server" meta:resourcekey="lnkDeptResource1"></asp:LinkButton>
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="ItemQuantity" DataFormatString="{0:N0}"
                                                                                            HeaderText="Quantity" meta:resourcekey="BoundFieldResource1" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField Visible="False" DataField="ItemAmount"
                                                                                            DataFormatString="{0:0.00}" HeaderText="Amount" 
                                                                                            meta:resourcekey="BoundFieldResource2" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="BilledAmount" DataFormatString="{0:0.00}"
                                                                                            HeaderText="BilledAmount" meta:resourcekey="BoundFieldResource3" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="AmountReceived" DataFormatString="{0:0.00}" HeaderText="AmountReceived"
                                                                                            Visible="False" meta:resourcekey="BoundFieldResource4" />
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                                </asp:GridView>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <table border="0" width="100%">
                                                                                    <tr style="font-weight: bold; color: Black;">
                                                                                        <td width="50%" align="center">
                                                                                            <asp:Label ID="lblSubTotal" Font-Size="12px" Text="Total" runat="server" 
                                                                                                meta:resourcekey="lblSubTotalResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="17%" align="right">
                                                                                            <asp:Label ID="lblQty" runat="server" meta:resourcekey="lblQtyResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td width="33%" align="Right" colspan="2">
                                                                                            <asp:Label ID="lblBilledAmount" runat="server" 
                                                                                                meta:resourcekey="lblBilledAmountResource1"></asp:Label>
                                                                                        </td>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:GridView ID="gvIPCreditMain1" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                                    ForeColor="#333333" CssClass="mytable1" 
                                                                                    OnRowDataBound="gvIPCreditMain1_RowDataBound" 
                                                                                    meta:resourcekey="gvIPCreditMain1Resource1">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="patientID" HeaderText="No." 
                                                                                            meta:resourcekey="BoundFieldResource5" >
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="PatientName" HeaderText="Name" 
                                                                                            meta:resourcekey="BoundFieldResource6">
                                                                                            <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Age" HeaderText="Age" 
                                                                                            meta:resourcekey="BoundFieldResource7">
                                                                                            <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="BillNumber" HeaderText="Bill No" 
                                                                                            meta:resourcekey="BoundFieldResource8" >
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="ConsultantName" Visible="False"
                                                                                            HeaderText="Consultant" meta:resourcekey="BoundFieldResource9" >
                                                                                            <ItemStyle HorizontalAlign="Left" Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="BillAmount"
                                                                                            HeaderText="Bill Amt" meta:resourcekey="BoundFieldResource10">
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="PreviousDue"
                                                                                            HeaderText="Acc Due" meta:resourcekey="BoundFieldResource11" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="NetValue"
                                                                                            HeaderText="Net Amt" meta:resourcekey="BoundFieldResource12" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="ReceivedAmount"
                                                                                            HeaderText="Total Rcvd Amt" meta:resourcekey="BoundFieldResource13" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="Cash"
                                                                                            HeaderText="Cash" meta:resourcekey="BoundFieldResource14" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="Cards"
                                                                                            HeaderText="Cards" meta:resourcekey="BoundFieldResource15" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="Cheque"
                                                                                            HeaderText="Cheque" meta:resourcekey="BoundFieldResource16" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="DD"
                                                                                            HeaderText="Drafts" meta:resourcekey="BoundFieldResource17" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="AmountRefund"
                                                                                            HeaderText="Total Rfd Amt" meta:resourcekey="BoundFieldResource18" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="Discount"
                                                                                            HeaderText="Total Discount" meta:resourcekey="BoundFieldResource19" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="PaidCurrency" HeaderText="Paid Currency" 
                                                                                            meta:resourcekey="BoundFieldResource20" >
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="PaidCurrencyAmount"
                                                                                            HeaderText="Paid Currency Amt" meta:resourcekey="BoundFieldResource21" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="Due"
                                                                                            HeaderText="Cash Bill Due" Visible="False" 
                                                                                            meta:resourcekey="BoundFieldResource22" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="CreditDue"
                                                                                            HeaderText="Credit Due" Visible="False" 
                                                                                            meta:resourcekey="BoundFieldResource23" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                                </asp:GridView>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <table id="tblgvIPCreditMainSummary" visible="False" runat="server" cellpadding="0"
                                                        cellspacing="0" border="0" width="100%">
                                                        <tr runat="server">
                                                            <td align="left" style="height: 25px;" runat="server">
                                                                <b>
                                                                    <asp:Label ID="Rs_Date" Text="Date:" runat="server"></asp:Label></b>
                                                                <asp:LinkButton ID="lnkDateSummary" ForeColor="Blue" Font-Bold="True" Font-Size="12px"
                                                                    runat="server"></asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server">
                                                            <td runat="server">
                                                                <asp:GridView ID="gvIPCreditMainSummary" runat="server" AutoGenerateColumns="False"
                                                                    Width="100%" ForeColor="#333333" CssClass="mytable1" OnRowDataBound="gvIPCreditMainSummary_RowDataBound"
                                                                    OnRowCommand="gvIPCreditMainSummary_RowCommand">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Department Name">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkDept" ForeColor="Blue" Font-Size="12px" Text='<%# Eval("FeeType") %>'
                                                                                    runat="server"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataFormatString="{0:N0}" DataField="ItemQuantity"
                                                                            HeaderText="Quantity" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataFormatString="{0:0.00}" Visible="False"
                                                                            DataField="ItemAmount" HeaderText="Amount" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="BilledAmount"
                                                                            HeaderText="BilledAmount" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="AmountReceived"
                                                                            HeaderText="AmountReceived" Visible="False" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                    <table id="tabTotal2" style="display: none;" runat="server" cellpadding="0" cellspacing="0"
                                                        border="0" width="100%">
                                                        <tr runat="server">
                                                            <td runat="server">
                                                                <table cellpadding="4" cellspacing="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                                                    border="0" width="100%">
                                                                    <tr style="height: 25px; font-weight: bold;">
                                                                        <td width="50%" align="right">
                                                                            <asp:Label ID="Rs_Total" Text="Total" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td id="tdQuantity2" width="20%" align="right" runat="server">
                                                                        </td>
                                                                        <td id="tdBilledAmount2" width="25%" align="right" runat="server">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server">
                                                            <td runat="server">
                                                                <asp:GridView ID="gvIPCreditMainSummary1" Font-Bold="True" runat="server" AutoGenerateColumns="False"
                                                                    Width="100%" ForeColor="#333333" CssClass="mytable1" 
                                                                    OnRowDataBound="gvIPCreditMainSummary1_RowDataBound">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="ReceivedAmount" HeaderText="Total Rcvd Amt" >
                                                                            <ItemStyle Width="25px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="Cash"
                                                                            HeaderText="Cash" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="Cards"
                                                                            HeaderText="Cards" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="Cheque"
                                                                            HeaderText="Cheque" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="DD"
                                                                            HeaderText="Drafts" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="AmountRefund"
                                                                            HeaderText="Total Rfd Amt" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="Discount"
                                                                            HeaderText="Total Discount" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="PaidCurrency" HeaderText="Paid Currency" >
                                                                            <ItemStyle Width="25px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="PaidCurrencyAmount"
                                                                            HeaderText="Paid Currency Amt" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="Due"
                                                                            HeaderText="Cash Bill Due" Visible="False" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="CreditDue"
                                                                            HeaderText="Credit Due" Visible="False" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
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
