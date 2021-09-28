<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="DailyBillReport.aspx.cs"
    Inherits="Admin_DailyBillReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>User Wise Collection Report</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
       <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <uc7:AdminHeader ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="32">
                                    <table border="0" id="mytable1" cellpadding="4" cellspacing="0" width="100%">
                                        <tr>
                                            <td id="us">
                                                <asp:Label ID="Rs_Info" Text="Looking up for User Wise Collection Details" runat="server"
                                                    meta:resourcekey="Rs_InfoResource1"></asp:Label>
                                                <asp:GridView ID="grdResultCashBill" runat="server" Font-Size="10px" AutoGenerateColumns="False"
                                                    CellPadding="4" CssClass="mytable1" DataKeyNames="BillID" ForeColor="#333333"
                                                    Width="99%" meta:resourcekey="grdResultCashBillResource1">
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                    <Columns>
                                                        <asp:BoundField DataField="BillID" HeaderText="BillID" Visible="false" meta:resourcekey="BoundFieldResource31" />
                                                        <asp:TemplateField HeaderText="Bill No" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="5%"
                                                            meta:resourcekey="TemplateFieldResource4">
                                                            <ItemTemplate>
                                                                <asp:HyperLink ID="lnkBillID" Font-Bold="True" NavigateUrl='<%# Eval("BillID", "PrintBill.aspx?billNo={0}") %>'
                                                                    Text='<%# Bind("BillID") %>' Font-Underline="True" ToolTip="Click To View & Print Bill"
                                                                    ForeColor="Black" Target="BillWindow" runat="server" meta:resourcekey="lnkBillIDResource4"></asp:HyperLink>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Center" Width="5%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="BillDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderStyle-HorizontalAlign="Left"
                                                            HeaderText="Bill Date" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="14%"
                                                            meta:resourcekey="BoundFieldResource32">
                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="14%"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Name" HeaderStyle-HorizontalAlign="Left" HeaderText="Patient Name"
                                                            ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="15%" meta:resourcekey="BoundFieldResource33">
                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="15%"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Age" HeaderStyle-HorizontalAlign="Left" HeaderText="Age"
                                                            ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="8%" meta:resourcekey="BoundFieldResource34">
                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="ReferingPhysicianName" HeaderStyle-HorizontalAlign="Left"
                                                            HeaderText="Physicain Name" ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="20%"
                                                            meta:resourcekey="BoundFieldResource35">
                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="ClientName" HeaderStyle-HorizontalAlign="left" HeaderText="ClientName"
                                                            Visible="false" meta:resourcekey="BoundFieldResource36">
                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="GrossAmount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                            HeaderText="Bill Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                            Visible="true" meta:resourcekey="BoundFieldResource37">
                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Discount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                            HeaderText="Discount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                            Visible="true" meta:resourcekey="BoundFieldResource38">
                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="AmountReceived" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                            HeaderText="Amount Received" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="12%"
                                                            Visible="true" meta:resourcekey="BoundFieldResource39">
                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="AmountDue" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                            HeaderText="Due Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                            Visible="true" meta:resourcekey="BoundFieldResource40">
                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                        </asp:BoundField>
                                                        <%-- <asp:BoundField DataField="IsCredit" HeaderText="Credit Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="IsDue" HeaderText="Due Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>--%>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div>
                                        <asp:Panel runat="server" CssClass="dataheader2" ID="pnlDate" Width="99%" meta:resourcekey="pnlDateResource1">
                                            <table border="0" width="100%" cellpadding="4" cellspacing="0">
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label ID="lblfTime" runat="server" Text="From Time" meta:resourcekey="lblfTimeResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlFrmtime"  CssClass ="ddl" runat="server" meta:resourcekey="ddlFrmtimeResource1">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlFrmMinutes" CssClass ="ddl" runat="server" meta:resourcekey="ddlFrmMinutesResource1">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlfrmSession"  CssClass ="ddl" runat="server" meta:resourcekey="ddlfrmSessionResource1">
                                                                        <asp:ListItem meta:resourcekey="ListItemResource1" Text="AM"></asp:ListItem>
                                                                        <asp:ListItem meta:resourcekey="ListItemResource2" Text="PM"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td align="right">
                                                        <asp:Label ID="lblTotime" runat="server" Text="ToTime" meta:resourcekey="lblTotimeResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlTotime" CssClass ="ddl" runat="server" meta:resourcekey="ddlTotimeResource1">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlToMinutes" CssClass ="ddl" runat="server" meta:resourcekey="ddlToMinutesResource1">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlToSession" runat="server" CssClass ="ddl" meta:resourcekey="ddlToSessionResource1">
                                                                        <asp:ListItem meta:resourcekey="ListItemResource3" Text="AM"></asp:ListItem>
                                                                        <asp:ListItem meta:resourcekey="ListItemResource4" Text="PM"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 5px;">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label runat="server" ID="fromDate" Text="From Date" CssClass="label_title" meta:resourcekey="fromDateResource1"></asp:Label>
                                                    </td>
                                                    <td style="width: 35%;">
                                                        <asp:TextBox ID="txtFrom" runat="server"  CssClass ="Txtboxsmall" TabIndex="4" MaxLength="1"
                                                            Style="text-align: justify" ValidationGroup="MKE" meta:resourcekey="txtFromResource1" />
                                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" Height="16px" meta:resourcekey="ImageButton1Resource1" />
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFrom"
                                                            Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                            Enabled="True" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                            ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                        <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFrom"
                                                            PopupButtonID="ImageButton1" Format="dd/MM/yyyy" Enabled="True" />
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                    <td align="right" style="width: 10%;">
                                                        <asp:Label runat="server" ID="toDate" Text="To Date" CssClass="label_title" meta:resourcekey="toDateResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtTo" runat="server" CssClass ="Txtboxsmall" TabIndex="5" MaxLength="1" Style="text-align: justify"
                                                            ValidationGroup="MKE" meta:resourcekey="txtToResource1" />
                                                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" meta:resourcekey="ImageButton2Resource1" />
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtTo"
                                                            Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                            Enabled="True" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                            ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                                                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtTo"
                                                            PopupButtonID="ImageButton2" Format="dd/MM/yyyy" Enabled="True" />
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" style="width: 15%;">
                                                        <asp:Label runat="server" ID="Label2" Text="Select a Name" meta:resourcekey="Label2Resource1"></asp:Label>
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:DropDownList ID="ddlUsers" runat="server"  CssClass ="ddlsmall" TabIndex="2"
                                                            meta:resourcekey="ddlUsersResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnGo0" runat="server" CssClass="btn" OnClick="btnGo_Click" onmouseout="this.className='btn'"
                                                            onmouseover="this.className='btn btnhov'" OnClientClick="return ValidateDate();"
                                                            TabIndex="6" Text=" Go " meta:resourcekey="btnGo0Resource1" />
                                                        <asp:Button ID="btnCancel0" runat="server" CssClass="btn1" onmouseout="this.className='btn1'"
                                                            onmouseover="this.className='btn1 btnhov1'" Text="Reset" meta:resourcekey="btnCancel0Resource1" />
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 5px;">
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblResult" ForeColor="#000333" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div id="dprint" runat="server" style="display: none;">
                                        <table id="orgHeaderTab" runat="server" cellpadding="0" cellspacing="0" border="0"
                                            width="100%">
                                            <tr>
                                                <td id="orgHeaderTextForReport" colspan="2" align="center" runat="server" style="color: #000000;
                                                    font-size: 12px; font-weight: bold;">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="dateTextForReport" align="left" runat="server" style="color: #000000; font-size: 11px;
                                                    font-weight: bold; padding-top: 20px;">
                                                </td>
                                                <td align="right" style="color: #000000; font-size: 11px; font-weight: bold; padding-top: 20px;">
                                                    <asp:HyperLink ID="hypLnkPrint" ImageUrl="~/Images/printer.gif" ToolTip="Print" Visible="False"
                                                        Target="ReportWindow" runat="server" meta:resourcekey="hypLnkPrintResource1"></asp:HyperLink>
                                                    <label id="dispLabel" runat="server" visible="false" style="color: #000;">
                                                        Print Report/Export To Excel</label>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <table id="totalResult" runat="server" cellpadding="0" cellspacing="0" border="0"
                                            width="100%">
                                            <tr>
                                                <td>
                                                    <div id="divT" runat="server" style="display: none;">
                                                        <asp:Panel runat="server" CssClass="dataheaderInvCtrl" ID="Panel1" Width="99%" meta:resourcekey="Panel1Resource1">
                                                            <table cellpadding="4" style="font-weight: bold;" cellspacing="0" border="0" width="100%">
                                                                <tr style="color: Green;">
                                                                    <td align="right" style="width: 80%;">
                                                                        <asp:Label ID="Rs_CashBillAmount" Text="Cash Bill Amount" runat="server" meta:resourcekey="Rs_CashBillAmountResource1"></asp:Label>
                                                                    </td>
                                                                    <td id="tdCashAmount" runat="server" align="right">
                                                                    </td>
                                                                </tr>
                                                                <tr style="color: Green;">
                                                                    <td align="right" style="width: 80%;">
                                                                        <asp:Label ID="Rs_DueAmountReceived" Text="Due Amount Received" runat="server" meta:resourcekey="Rs_DueAmountReceivedResource1"></asp:Label>
                                                                    </td>
                                                                    <td id="tdDueReceivedAmount" runat="server" align="right">
                                                                    </td>
                                                                </tr>
                                                                <tr style="color: Green;">
                                                                    <td align="right" style="width: 80%;">
                                                                        <asp:Label ID="RS_CreditBillAmount" Text="CreditBillAmount" runat="server" meta:resourcekey="RS_CreditBillAmountResource1"></asp:Label>
                                                                    </td>
                                                                    <td id="tdCreditAmount" runat="server" align="right">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2" align="right">
                                                                        ---------------------------------------------------
                                                                    </td>
                                                                </tr>
                                                                <tr style="color: Blue;">
                                                                    <td align="right" style="width: 80%;">
                                                                        <asp:Label ID="Rs_DiscountAmount" Text="Discount Amount" runat="server" meta:resourcekey="Rs_DiscountAmountResource1"></asp:Label>
                                                                    </td>
                                                                    <td id="tdDiscountAmount" runat="server" align="right">
                                                                    </td>
                                                                </tr>
                                                                <tr style="color: Red;">
                                                                    <td align="right" style="width: 80%;">
                                                                        <asp:Label ID="Rs_PendingDueAmount" Text="Pending Due Amount" runat="server" meta:resourcekey="Rs_PendingDueAmountResource1"></asp:Label>
                                                                    </td>
                                                                    <td id="tdPendingDueAmount" runat="server" align="right">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2" align="right">
                                                                        ---------------------------------------------------
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right" style="width: 80%;">
                                                                        <asp:Label ID="Rs_TotalAmount" Text="Total Amount" runat="server" meta:resourcekey="Rs_TotalAmountResource1"></asp:Label>
                                                                    </td>
                                                                    <td id="tdTotalAmount" runat="server" align="right">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </div>
                                                    <table id="cashBillTab" runat="server" cellpadding="0" cellspacing="0" border="0"
                                                        width="100%">
                                                        <tr>
                                                            <td style="font-weight: bold;">
                                                                <asp:Label ID="Rs_CashBills" Text="CashBills" runat="server" meta:resourcekey="Rs_CashBillsResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table id="creditBillTab" runat="server" cellpadding="0" cellspacing="0" border="0"
                                                        width="100%">
                                                        <tr>
                                                            <td style="font-weight: bold;">
                                                                <asp:Label ID="Rs_CreditBills" Text="Credit Bills" runat="server" meta:resourcekey="Rs_CreditBillsResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="grdResultCreditBill" runat="server" Font-Size="10px" AutoGenerateColumns="False"
                                                                    CellPadding="4" CssClass="mytable1" DataKeyNames="BillID" ForeColor="#333333"
                                                                    Width="99%" meta:resourcekey="grdResultCreditBillResource1">
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                    <Columns>
                                                                        <asp:BoundField DataField="BillID" HeaderText="BillID" Visible="false" meta:resourcekey="BoundFieldResource1" />
                                                                        <asp:TemplateField HeaderText="Bill No" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="5%"
                                                                            meta:resourcekey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <asp:HyperLink ID="lnkBillID" Font-Bold="True" NavigateUrl='<%# Eval("BillID", "PrintBill.aspx?billNo={0}") %>'
                                                                                    Text='<%# Bind("BillID") %>' Font-Underline="True" ToolTip="Click To View & Print Bill"
                                                                                    ForeColor="Black" Target="BillWindow" runat="server" meta:resourcekey="lnkBillIDResource1"></asp:HyperLink>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Center" Width="5%"></ItemStyle>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="BillDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderStyle-HorizontalAlign="Left"
                                                                            HeaderText="Bill Date" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="14%"
                                                                            meta:resourcekey="BoundFieldResource2">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left" Width="14%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Name" HeaderStyle-HorizontalAlign="Left" HeaderText="Patient Name"
                                                                            ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="15%" meta:resourcekey="BoundFieldResource3">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left" Width="15%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Age" HeaderStyle-HorizontalAlign="Left" HeaderText="Age"
                                                                            ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="8%" meta:resourcekey="BoundFieldResource4">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ReferingPhysicianName" HeaderStyle-HorizontalAlign="Left"
                                                                            HeaderText="Physicain Name" ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="20%"
                                                                            meta:resourcekey="BoundFieldResource5">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ClientName" HeaderStyle-HorizontalAlign="left" HeaderText="ClientName"
                                                                            Visible="false" meta:resourcekey="BoundFieldResource6">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="GrossAmount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                                            HeaderText="Bill Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                                            Visible="true" meta:resourcekey="BoundFieldResource7">
                                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Discount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                                            HeaderText="Discount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                                            Visible="true" meta:resourcekey="BoundFieldResource8">
                                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmountReceived" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                                            HeaderText="Amount Received" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="12%"
                                                                            Visible="true" meta:resourcekey="BoundFieldResource9">
                                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmountDue" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                                            HeaderText="Due Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                                            Visible="true" meta:resourcekey="BoundFieldResource10">
                                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <%-- <asp:BoundField DataField="IsCredit" HeaderText="Credit Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="IsDue" HeaderText="Due Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>--%>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table id="dueAmountReceivedTab" runat="server" cellpadding="0" cellspacing="0" border="0"
                                                        width="100%">
                                                        <tr>
                                                            <td style="font-weight: bold;">
                                                                <asp:Label ID="Rs_DueAmountReceivedBills" Text="DueAmountReceivedBills" runat="server"
                                                                    meta:resourcekey="Rs_DueAmountReceivedBillsResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="grdResultDueReceivedBill" runat="server" Font-Size="10px" AutoGenerateColumns="False"
                                                                    CellPadding="4" CssClass="mytable1" DataKeyNames="BillID" ForeColor="#333333"
                                                                    Width="99%" meta:resourcekey="grdResultDueReceivedBillResource1">
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                    <Columns>
                                                                        <asp:BoundField DataField="BillID" HeaderText="BillID" Visible="false" meta:resourcekey="BoundFieldResource11" />
                                                                        <asp:TemplateField HeaderText="Bill No" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="5%"
                                                                            meta:resourcekey="TemplateFieldResource2">
                                                                            <ItemTemplate>
                                                                                <asp:HyperLink ID="lnkBillID" Font-Bold="True" NavigateUrl='<%# Eval("BillID", "PrintBill.aspx?billNo={0}") %>'
                                                                                    Text='<%# Bind("BillID") %>' Font-Underline="True" ToolTip="Click To View & Print Bill"
                                                                                    ForeColor="Black" Target="BillWindow" runat="server" meta:resourcekey="lnkBillIDResource2"></asp:HyperLink>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Center" Width="5%"></ItemStyle>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="BillDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderStyle-HorizontalAlign="Left"
                                                                            HeaderText="Bill Date" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="14%"
                                                                            meta:resourcekey="BoundFieldResource12">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left" Width="14%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Name" HeaderStyle-HorizontalAlign="Left" HeaderText="Patient Name"
                                                                            ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="15%" meta:resourcekey="BoundFieldResource13">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left" Width="15%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Age" HeaderStyle-HorizontalAlign="Left" HeaderText="Age"
                                                                            ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="8%" meta:resourcekey="BoundFieldResource14">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ReferingPhysicianName" HeaderStyle-HorizontalAlign="Left"
                                                                            HeaderText="Physicain Name" ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="20%"
                                                                            meta:resourcekey="BoundFieldResource15">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ClientName" HeaderStyle-HorizontalAlign="left" HeaderText="ClientName"
                                                                            Visible="false" meta:resourcekey="BoundFieldResource16">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="GrossAmount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                                            HeaderText="Bill Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                                            Visible="true" meta:resourcekey="BoundFieldResource17">
                                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Discount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                                            HeaderText="Discount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                                            Visible="true" meta:resourcekey="BoundFieldResource18">
                                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmountReceived" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                                            HeaderText="Amount Received" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="12%"
                                                                            Visible="true" meta:resourcekey="BoundFieldResource19">
                                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmountDue" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                                            HeaderText="Due Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                                            Visible="true" meta:resourcekey="BoundFieldResource20">
                                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <%-- <asp:BoundField DataField="IsCredit" HeaderText="Credit Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="IsDue" HeaderText="Due Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>--%>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table id="cancelledBillTab" runat="server" cellpadding="0" cellspacing="0" border="0"
                                                        width="100%">
                                                        <tr>
                                                            <td style="font-weight: bold;">
                                                                <asp:Label ID="Rs_CancelledBills" Text="Cancelled Bills" runat="server" meta:resourcekey="Rs_CancelledBillsResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="grdResultCancelledBill" runat="server" Font-Size="10px" AutoGenerateColumns="False"
                                                                    CellPadding="4" CssClass="mytable1" DataKeyNames="BillID" ForeColor="#333333"
                                                                    Width="99%" meta:resourcekey="grdResultCancelledBillResource1">
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                    <Columns>
                                                                        <asp:BoundField DataField="BillID" HeaderText="BillID" Visible="false" meta:resourcekey="BoundFieldResource21" />
                                                                        <asp:TemplateField HeaderText="Bill No" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="5%"
                                                                            meta:resourcekey="TemplateFieldResource3">
                                                                            <ItemTemplate>
                                                                                <asp:HyperLink ID="lnkBillID" Font-Bold="True" NavigateUrl='<%# Eval("BillID", "PrintBill.aspx?billNo={0}") %>'
                                                                                    Text='<%# Bind("BillID") %>' Font-Underline="True" ToolTip="Click To View & Print Bill"
                                                                                    ForeColor="Black" Target="BillWindow" runat="server" meta:resourcekey="lnkBillIDResource3"></asp:HyperLink>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Center" Width="5%"></ItemStyle>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="BillDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderStyle-HorizontalAlign="Left"
                                                                            HeaderText="Bill Date" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="14%"
                                                                            meta:resourcekey="BoundFieldResource22">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left" Width="14%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Name" HeaderStyle-HorizontalAlign="Left" HeaderText="Patient Name"
                                                                            ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="15%" meta:resourcekey="BoundFieldResource23">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left" Width="15%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Age" HeaderStyle-HorizontalAlign="Left" HeaderText="Age"
                                                                            ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="8%" meta:resourcekey="BoundFieldResource24">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ReferingPhysicianName" HeaderStyle-HorizontalAlign="Left"
                                                                            HeaderText="Physicain Name" ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="20%"
                                                                            meta:resourcekey="BoundFieldResource25">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ClientName" HeaderStyle-HorizontalAlign="left" HeaderText="ClientName"
                                                                            Visible="false" meta:resourcekey="BoundFieldResource26">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="GrossAmount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                                            HeaderText="Bill Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                                            Visible="true" meta:resourcekey="BoundFieldResource27">
                                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Discount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                                            HeaderText="Discount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                                            Visible="true" meta:resourcekey="BoundFieldResource28">
                                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmountReceived" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                                            HeaderText="Amount Received" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="12%"
                                                                            Visible="true" meta:resourcekey="BoundFieldResource29">
                                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmountDue" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                                            HeaderText="Due Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                                            Visible="true" meta:resourcekey="BoundFieldResource30">
                                                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <%-- <asp:BoundField DataField="IsCredit" HeaderText="Credit Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="IsDue" HeaderText="Due Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>--%>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
