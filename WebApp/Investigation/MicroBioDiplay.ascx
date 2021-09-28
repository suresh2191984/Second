<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MicroBioDiplay.ascx.cs"
    Inherits="Investigation_InvestigationDiplay" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<table cellspacing="1" style="height: auto" width="100%" border="0">
    <tr>
        <td>
            <div id="d1001" style="display: none" runat="server">
                <asp:Label Text="Microbiology" runat="server" ID="lblMicro" 
                    CssClass="main_title" meta:resourcekey="lblMicroResource1"></asp:Label>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <a id="a1002" runat="server" visible="false"><span class="label_title">
            <asp:Label ID="Rs_TORCHPanel" Text="TORCH Panel" runat="server" 
                meta:resourcekey="Rs_TORCHPanelResource1"></asp:Label></span></a>
            <div id="d1004" style="display: block; padding-left: 30px" runat="server">
                <table style="padding-left: 10px">
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="lblHead" CssClass="label_subtitle" 
                                meta:resourcekey="lblHeadResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
                <asp:Repeater runat="server" ID="rptRubella">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblName" Text='<%# Bind("Name") %>' 
                                        CssClass="results" meta:resourcekey="lblNameResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' 
                                        CssClass="results" meta:resourcekey="lblResultResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' 
                                        CssClass="results" meta:resourcekey="Uom1004Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div id="d1005" style="display: none; padding-left: 30px" runat="server">
                <table style="padding-left: 10px">
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="l1005" CssClass="label_title" 
                                meta:resourcekey="l1005Resource1"></asp:Label>
                        </td>
                    </tr>
                </table>
                <asp:Repeater runat="server" ID="rpt1005">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="Name1005" Text='<%# Bind("Name") %>' 
                                        CssClass="results" meta:resourcekey="Name1005Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Result1005" Text='<%# Bind("Value") %>' 
                                        CssClass="results" meta:resourcekey="Result1005Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Uom1005" Text='<%# Bind("UOMCode") %>' 
                                        CssClass="results" meta:resourcekey="Uom1005Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div id="d1006" style="display: none; padding-left: 30px" runat="server">
                <table style="padding-left: 10px">
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="l1006" CssClass="label_title" 
                                meta:resourcekey="l1006Resource1"></asp:Label>
                        </td>
                    </tr>
                </table>
                <asp:Repeater runat="server" ID="rpt1006">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="Name1006" Text='<%# Bind("Name") %>' 
                                        CssClass="results" meta:resourcekey="Name1006Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Result1006" Text='<%# Bind("Value") %>' 
                                        CssClass="results" meta:resourcekey="Result1006Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Uom1006" Text='<%# Bind("UOMCode") %>' 
                                        CssClass="results" meta:resourcekey="Uom1006Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div id="d1007" style="display: none; padding-left: 30px" runat="server">
                <table style="padding-left: 10px">
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="l1007" CssClass="label_title" 
                                meta:resourcekey="l1007Resource1"></asp:Label>
                        </td>
                    </tr>
                </table>
                <asp:Repeater runat="server" ID="rpt1007">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="Name1007" Text='<%# Bind("Name") %>' 
                                        CssClass="results" meta:resourcekey="Name1007Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Result1007" Text='<%# Bind("Value") %>' 
                                        CssClass="results" meta:resourcekey="Result1007Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Uom1007" Text='<%# Bind("UOMCode") %>' 
                                        CssClass="results" meta:resourcekey="Uom1007Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div id="d1008" style="display: none; padding-left: 30px" runat="server">
                <table style="padding-left: 10px">
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="l1008" CssClass="label_title" 
                                meta:resourcekey="l1008Resource1"></asp:Label>
                        </td>
                    </tr>
                </table>
                <asp:Repeater runat="server" ID="rpt1008">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="Name1008" Text='<%# Bind("Name") %>' 
                                        CssClass="results" meta:resourcekey="Name1008Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Result1008" Text='<%# Bind("Value") %>' 
                                        CssClass="results" meta:resourcekey="Result1008Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Uom1008" Text='<%# Bind("UOMCode") %>' 
                                        CssClass="results" meta:resourcekey="Uom1008Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div id="d1009" style="display: none; padding-left: 30px" runat="server">
                <table style="padding-left: 10px">
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="l1009" CssClass="label_title" 
                                meta:resourcekey="l1009Resource1"></asp:Label>
                        </td>
                    </tr>
                </table>
                <asp:Repeater runat="server" ID="rpt1009">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="Name1009" Text='<%# Bind("Name") %>' 
                                        CssClass="results" meta:resourcekey="Name1009Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Result1009" Text='<%# Bind("Value") %>' 
                                        CssClass="results" meta:resourcekey="Result1009Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Uom1009" Text='<%# Bind("UOMCode") %>' 
                                        CssClass="results" meta:resourcekey="Uom1009Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </td>
    </tr>
</table>
