<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IPBilledVsActualReport.aspx.cs"
    Inherits="Reports_IPBilledVsActualReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title><asp:Label ID="IPvsARpt" Text ="IP Billed Vs Actual Report" runat ="server" ></asp:Label></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
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
                <uc3:Header ID="AdminHeader" runat="server" />
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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
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
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:Panel runat="server" CssClass="dataheader2" ID="pnlDate" Width="99%" Visible="true">
                            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="height: 5px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table border="0" width="100%" cellpadding="4" cellspacing="0">
                                            <tr>
                                                <td align="right" style="width: 15%">
                                                    <asp:Label runat="server" ID="Rs_fromDate" Text="From Date" CssClass="label_title">
                                                    </asp:Label>
                                                </td>
                                                <td style="width: 35%;">
                                                    <asp:TextBox ID="txtFrom" runat="server" CssClass ="Txtboxsmall" Width ="120px" TabIndex="4" MaxLength="1"
                                                        Style="text-align: justify" ValidationGroup="MKE" />
                                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFrom"
                                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" />
                                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFrom"
                                                        PopupButtonID="ImageButton1" Format="dd/MM/yyyy" />
                                                </td>
                                                <td align="right" style="width: 15%;">
                                                    <asp:Label runat="server" ID="Rs_toDate" Text="To Date" CssClass="label_title">
                                                    </asp:Label>
                                                </td>
                                                <td style="width: 35%">
                                                    <asp:TextBox ID="txtTo" runat="server" CssClass ="Txtboxsmall" Width ="120px" TabIndex="5" MaxLength="1" Style="text-align: justify"
                                                        ValidationGroup="MKE" />
                                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtTo"
                                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                        ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtTo"
                                                        PopupButtonID="ImageButton2" Format="dd/MM/yyyy" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="width: 15%;" align="right">
                                                <asp:Label ID="Rs_SelectServiceType" Text ="Select Service Type" runat ="server" ></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList runat="server" ID="ddlServiceType" TabIndex="1"  CssClass ="ddlmedium" >
                                                        <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                                                        <asp:ListItem Text="Lab" Value="Lab"></asp:ListItem>
                                                        <asp:ListItem Text="CONSULTATION" Value="CONSULTATION"></asp:ListItem>
                                                        <asp:ListItem Text="Procedures" Value="Procedures"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Button runat="server" ID="btnGo" Text=" Go " CssClass="btn" TabIndex="6" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnGo_Click" />
                                        &nbsp;
                                        <asp:Button ID="btnCancel" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                            onmouseout="this.className='btn'" OnClick="btnCancel_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 5px;">
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Label ID="lblResult" Font-Bold="true" ForeColor="#333" runat="server"></asp:Label>
                        <table id="excelTab" runat="server" cellpadding="5" style="display: none; color: #333;"
                            cellspacing="0" border="0" width="100%" visible="false">
                            <tr>
                                <td align="right">
                                    <b> <asp:Label ID="Rs_ExportToExcel" Text ="Export To Excel" runat ="server" ></asp:Label></b>&nbsp;&nbsp;&nbsp;
                                    <asp:ImageButton ID="btnXL" OnClick="btnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                        ToolTip="Save As Excel" />
                                </td>
                            </tr>
                        </table>
                        <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                            CellPadding="0" PageSize="50" ForeColor="#333333" CssClass="mytable1" GridLines="Both"
                            OnPageIndexChanging="grdResult_PageIndexChanging" Width="100%" Font-Size="Smaller" >
                            <%--<PagerTemplate>
                                <tr>
                                    <td align="center" colspan="6">
                                        <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="false" CommandArgument="Prev"
                                            CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px" />
                                        <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="false" CommandArgument="Next"
                                            CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px" />
                                    </td>
                                </tr>
                            </PagerTemplate>
                            <HeaderStyle CssClass="dataheader1" />
                            <RowStyle Font-Bold="false" />
                            <PagerSettings Mode="NextPrevious"></PagerSettings>--%>
                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                            <Columns>
                                <asp:BoundField DataField="FinalBillID" HeaderText="Bill NO.">
                                    <ItemStyle HorizontalAlign="Center" Width="30px"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="Name" HeaderStyle-HorizontalAlign="Left" HeaderText="Patient Name"
                                    ItemStyle-HorizontalAlign="Left" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="120px"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="Comments" HeaderStyle-HorizontalAlign="Left" HeaderText="Description"
                                    ItemStyle-HorizontalAlign="Left" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="120px"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="DiscountReason" HeaderStyle-HorizontalAlign="Left" HeaderText="Service Type"
                                    ItemStyle-HorizontalAlign="Left" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="40px"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="NetValue" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                    HeaderText="Billed" ItemStyle-HorizontalAlign="Right" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="GrossBillValue" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                    HeaderText="Actual" ItemStyle-HorizontalAlign="Right" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="AmountReceived" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                    HeaderText="Diff." ItemStyle-HorizontalAlign="Right" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"  ></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
