<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportDisplay.aspx.cs" Inherits="Admin_ReportDisplay" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1
        {
            width: 14%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <uc2:Header ID="Header2" runat="server" />
            <uc7:AdminHeader ID="AdminHeader" runat="server" />
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
                        <table width="100%">
                            <tr style="width: 100%">
                                <td style="width: 70%" valign="top">
                                    From Date
                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" 
                                        ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                        TargetControlID="txtFrom" CultureAMPMPlaceholder="" 
                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                        TargetControlID="txtFrom" Enabled="True" />
                                    <asp:TextBox ID="txtFrom" runat="server" MaxLength="1" Style="text-align: justify"
                                        TabIndex="3" ValidationGroup="MKE"  CssClass ="Txtboxsmall" Width ="120px" 
                                        meta:resourcekey="txtFromResource1" />
                                    <asp:ImageButton ID="ImgBntCalc" runat="server" CausesValidation="False" Height="16px"
                                        ImageUrl="~/images/Calendar_scheduleHS.png" Width="17px" 
                                        meta:resourcekey="ImgBntCalcResource1" />
                                    To Date
                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" 
                                        ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                        TargetControlID="txtTo" CultureAMPMPlaceholder="" 
                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc1"
                                        TargetControlID="txtTo" Enabled="True" />
                                    <asp:TextBox ID="txtTo" runat="server" MaxLength="1" Style="text-align: justify"
                                        TabIndex="4" ValidationGroup="MKE" CssClass ="Txtboxsmall" Width ="120px"
                                        meta:resourcekey="txtToResource1" />
                                    <asp:ImageButton ID="ImgBntCalc1" runat="server" CausesValidation="False" Height="16px"
                                        ImageUrl="~/images/Calendar_scheduleHS.png" Width="17px" 
                                        meta:resourcekey="ImgBntCalc1Resource1" />
                                    <asp:CheckBox ID="chkTodayDate" Text="ToDay" runat="server" 
                                        meta:resourcekey="chkTodayDateResource1" />
                                </td>
                                <td align="right" valign="top" class="style1">
                                    <asp:DropDownList ID="ddlList" runat="server"  CssClass ="ddlsmall"                                        meta:resourcekey="ddlListResource1">
                                    </asp:DropDownList>
                                </td>
                                <td valign="top" style="width: 3%">
                                    <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click"
                                        Height="23px" Width="43px" onmouseover="this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" meta:resourcekey="btnGoResource1" />
                                </td>
                                <td valign="top" style="width: 5%">
                                    <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" OnClick="btnBack_Click"
                                        Height="23px" Width="43px" onmouseover="this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" meta:resourcekey="btnBackResource1" />
                                </td>
                            </tr>
                        </table>
                        <rsweb:ReportViewer ID="ReportViewer" runat="server" 
                            ProcessingMode="Remote" Font-Names="Verdana" Font-Size="8pt" 
                            meta:resourcekey="ReportViewerResource1">
                            <ServerReport ReportServerUrl="" />
                        </rsweb:ReportViewer>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
