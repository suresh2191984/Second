<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PhyAvailableSchedules.ascx.cs"
    Inherits="CommonControls_PhySchedule" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<table class="mytable2" runat="server" id="tblHide" visible="false">
    <tr>
        <td colspan="6" class="blackfontcolormedium">
            <asp:Label ID="Rs_Weekly_Sche" runat="server" Text="Weekly Schedule" meta:resourcekey="Rs_Weekly_ScheResource1"></asp:Label>
        </td>
        <td class="blackfontcolormedium">
        </td>
    </tr>
    <tr>
        <td colspan="6" class="blackfontcolormedium" align="center">
            <asp:LinkButton ID="lnkWeek1" Style="color: Black; font-weight: normal;" runat="server"
                OnClick="lNext_Click" Text="Week1" meta:resourcekey="lnkWeek1Resource1"></asp:LinkButton>
            &nbsp;|&nbsp;
            <asp:LinkButton ID="lnkWeek2" Style="color: Black; font-weight: normal;" runat="server"
                OnClick="lNext_Click" Text="Week2" meta:resourcekey="lnkWeek2Resource1"></asp:LinkButton>
            &nbsp;|&nbsp;
            <asp:LinkButton ID="lnkWeek3" Style="color: Black; font-weight: normal;" runat="server"
                OnClick="lNext_Click" Text="Week3" meta:resourcekey="lnkWeek3Resource1"></asp:LinkButton>
            &nbsp;|&nbsp;
            <asp:LinkButton ID="lnkWeek4" Style="color: Black; font-weight: normal;" runat="server"
                OnClick="lNext_Click" Text="Week4" meta:resourcekey="lnkWeek4Resource1"></asp:LinkButton>
        </td>
        <td class="blackfontcolormedium">
            &nbsp;
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td align="center">
            <asp:Label ID="lday1" runat="server" meta:resourcekey="lday1Resource1"></asp:Label>
        </td>
        <td align="center">
            <asp:Label ID="lday2" runat="server" meta:resourcekey="lday2Resource1"></asp:Label>
        </td>
        <td align="center">
            <asp:Label ID="lday3" runat="server" meta:resourcekey="lday3Resource1"></asp:Label>
        </td>
        <td align="center">
            <asp:Label ID="lday4" runat="server" meta:resourcekey="lday4Resource1"></asp:Label>
        </td>
        <td align="center">
            <asp:Label ID="lday5" runat="server" meta:resourcekey="lday5Resource1"></asp:Label>
        </td>
        <td align="center">
            <asp:Label ID="lday6" runat="server" meta:resourcekey="lday6Resource1"></asp:Label>
        </td>
        <td align="center">
            <asp:Label ID="lday7" runat="server" meta:resourcekey="lday7Resource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td valign="top">
            <asp:Repeater ID="rDay1" runat="server">
                <ItemTemplate>
                    <table align="center" class="ef" cellspacing="2" cellpadding="2">
                        <tr>
                            <td align="center" id="lik">
                                <table height="59" width="100%" align="center" id="ef">
                                    <tr>
                                        <td class="tokenbooking" align="center" id="ef">
                                            <asp:Label ID="lPName" Text='<%# Eval("Details") %>' runat="server"><%--meta:resourcekey="lPNameResource1"--%></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>
        </td>
        <td valign="top">
            <asp:Repeater ID="rDay2" runat="server">
                <ItemTemplate>
                    <table align="center" class="ef" cellspacing="2" cellpadding="2">
                        <tr>
                            <td align="center" id="lik">
                                <table height="59" width="100%" align="center" id="ef">
                                    <tr>
                                        <td class="tokenbooking" align="center" id="ef">
                                            <asp:Literal ID="lPName" Text='<%# Eval("Details") %>' runat="server"></asp:Literal>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>
        </td>
        <td valign="top">
            <asp:Repeater ID="rDay3" runat="server">
                <ItemTemplate>
                    <table align="center" class="ef" cellspacing="2" cellpadding="2">
                        <tr>
                            <td align="center" id="lik">
                                <table height="59" width="100%" align="center" id="ef">
                                    <tr>
                                        <td class="tokenbooking" align="center" id="ef">
                                            <asp:Literal ID="lPName" Text='<%# Eval("Details") %>' runat="server"></asp:Literal>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>
        </td>
        <td valign="top">
            <asp:Repeater ID="rDay4" runat="server">
                <ItemTemplate>
                    <table align="center" class="ef" cellspacing="2" cellpadding="2">
                        <tr>
                            <td align="center" id="lik">
                                <table height="59" width="100%" align="center" id="ef">
                                    <tr>
                                        <td class="tokenbooking" align="center" id="ef">
                                            <asp:Literal ID="lPName" Text='<%# Eval("Details") %>' runat="server"></asp:Literal>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>
        </td>
        <td valign="top">
            <asp:Repeater ID="rDay5" runat="server">
                <ItemTemplate>
                    <table align="center" class="ef" cellspacing="2" cellpadding="2">
                        <tr>
                            <td align="center" id="lik">
                                <table height="59" width="100%" align="center">
                                    <tr>
                                        <td class="tokenbooking" align="center" id="ef">
                                            <asp:Literal ID="lPName" Text='<%# Eval("Details") %>' runat="server"></asp:Literal>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>
        </td>
        <td valign="top">
            <asp:Repeater ID="rDay6" runat="server">
                <ItemTemplate>
                    <table align="center" cellspacing="2" cellpadding="2">
                        <tr>
                            <td align="center" id="lik">
                                <table height="59" width="100%" align="center" id="ef">
                                    <tr>
                                        <td class="tokenbooking" align="center" id="ef">
                                            <asp:Literal ID="lPName" Text='<%# Eval("Details") %>' runat="server"></asp:Literal>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>
        </td>
    </tr>
</table>
