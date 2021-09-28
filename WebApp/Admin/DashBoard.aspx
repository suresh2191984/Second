<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DashBoard.aspx.cs" Inherits="Admin_DashBoard"
    meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/RevenueDisplay.ascx" TagName="RevenueDisplay"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/LineChartDisplay.ascx" TagName="RevenueDisplay"
    TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Reports View</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

</head>
<body id="oneColLayout">
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc7:DocHeader ID="docHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <div id="primaryContent" style="height: auto; min-height: 455px;">
            <div id="maincontent">
                <div align="Right">
                    <span align="left">
                        <asp:Label ID="Rs_DashBoard" Text="Dash Board" runat="server" meta:resourcekey="Rs_DashBoardResource1"></asp:Label></span>
                    <asp:LinkButton ID="lnkHome" runat="server" Text="Home" CssClass="details_label_age"
                        OnClick="lnkHome_Click" meta:resourcekey="lnkHomeResource1"></asp:LinkButton>
                </div>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:WebPartManager ID="WebPartManager1" runat="server">
                        </asp:WebPartManager>
                        <table cellpadding="4" cellspacing="0" width="100%">
                            <tr>
                                <td valign="top" style="width: 450px;" class="dataheaderInvCtrl">
                                    <asp:WebPartZone ID="Zone1" runat="server" EmptyZoneText="" BorderColor="#CCCCCC"
                                        Font-Names="Verdana" Padding="6" HeaderText=" " Width="480px" meta:resourcekey="Zone1Resource1">
                                        <VerbStyle Height="450px" />
                                        <EmptyZoneTextStyle Font-Size="0.8em" />
                                        <PartStyle Font-Size="0.8em" ForeColor="#333333" />
                                        <TitleBarVerbStyle Font-Size="0.6em" Font-Underline="False" ForeColor="White" />
                                        <MenuLabelHoverStyle ForeColor="#D1DDF1" />
                                        <MenuPopupStyle BackColor="#507CD1" BorderColor="#CCCCCC" BorderWidth="1px" Font-Names="Verdana"
                                            Font-Size="0.6em" />
                                        <MenuVerbStyle BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px" ForeColor="White" />
                                        <PartTitleStyle BackColor="#507CD1" Font-Bold="True" Font-Size="0.8em" ForeColor="White" />
                                        <ZoneTemplate>
                                            <uc10:RevenueDisplay ID="revenueDisplay1" runat="server" title="Today's Revenue Breakup" />
                                            <uc10:RevenueDisplay ID="RevenueWeekly1" runat="server" title="This Week Revenue Breakup" />
                                            <uc10:RevenueDisplay ID="revenueMonthly1" runat="server" title="This Month Revenue Breakup" />
                                            <uc10:RevenueDisplay ID="revenueQuarterly1" runat="server" title="This Quarter Revenue Breakup" />
                                        </ZoneTemplate>
                                        <MenuVerbHoverStyle BackColor="#EFF3FB" BorderColor="#CCCCCC" BorderStyle="Solid"
                                            BorderWidth="1px" ForeColor="#333333" />
                                        <PartChromeStyle BackColor="#EFF3FB" BorderColor="#D1DDF1" Font-Names="Verdana" ForeColor="#333333" />
                                        <HeaderStyle Font-Size="0.7em" ForeColor="#CCCCCC" HorizontalAlign="Center" />
                                        <MenuLabelStyle ForeColor="White" />
                                    </asp:WebPartZone>
                                </td>
                                <td align="left" valign="top" style="width: 450px;" class="dataheaderInvCtrl">
                                    <asp:WebPartZone ID="WebPartZone1" runat="server" BorderColor="#CCCCCC" Font-Names="Verdana"
                                        Width="480px" Padding="6" HeaderText=" " EmptyZoneText="" meta:resourcekey="WebPartZone1Resource1">
                                        <VerbStyle Height="450px" />
                                        <EmptyZoneTextStyle Font-Size="0.8em" />
                                        <PartStyle Font-Size="0.8em" ForeColor="#333333" />
                                        <TitleBarVerbStyle Font-Size="0.6em" Font-Underline="False" ForeColor="White" />
                                        <MenuLabelHoverStyle ForeColor="#D1DDF1" />
                                        <MenuPopupStyle BackColor="#507CD1" BorderColor="#CCCCCC" BorderWidth="1px" Font-Names="Verdana"
                                            Font-Size="0.6em" />
                                        <MenuVerbStyle BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px" ForeColor="White" />
                                        <PartTitleStyle BackColor="#507CD1" Font-Bold="True" Font-Size="0.8em" ForeColor="White" />
                                        <MenuVerbHoverStyle BackColor="#EFF3FB" BorderColor="#CCCCCC" BorderStyle="Solid"
                                            BorderWidth="1px" ForeColor="#333333" />
                                        <PartChromeStyle BackColor="#EFF3FB" BorderColor="#D1DDF1" Font-Names="Verdana" ForeColor="#333333" />
                                        <HeaderStyle Font-Size="0.7em" ForeColor="#CCCCCC" HorizontalAlign="Center" />
                                        <MenuLabelStyle ForeColor="White" />
                                        <ZoneTemplate>
                                            <uc11:RevenueDisplay ID="LineDaily" runat="server" title="Daywise Revenue" />
                                            <uc11:RevenueDisplay ID="LineWeekly" runat="server" title="Weekwise Revenue" />
                                            <uc11:RevenueDisplay ID="LineMonthly" runat="server" title="Monthwise Revenue" />
                                            <uc11:RevenueDisplay ID="LineQuarterly" runat="server" title="Quarterlywise Revenue" />
                                        </ZoneTemplate>
                                    </asp:WebPartZone>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CatalogZone ID="CatalogZone1" runat="server" meta:resourcekey="CatalogZone1Resource1">
                                    </asp:CatalogZone>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <div>
            <uc5:Footer ID="Footer1" runat="server" />
        </div>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
