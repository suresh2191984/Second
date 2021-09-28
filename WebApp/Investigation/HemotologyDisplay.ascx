<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HemotologyDisplay.ascx.cs"
    Inherits="Investigation_HemotologyDisplay" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<table cellspacing="1" style="height: auto" width="100%" border="0">
    <tr>
        <td>
            <div id="d2001" style="display: none" runat="server">
                <asp:Label Text="Hemotology" runat="server" ID="lblHemot" CssClass="main_title" meta:resourcekey="lblHemotResource1"></asp:Label>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <asp:Repeater runat="server" ID="rpt2002">
                <ItemTemplate>
                    <table style="padding-left: 10px">
                        <tr>
                            <td>
                                <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                    meta:resourcekey="lblNameResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                    meta:resourcekey="lblResultResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                    meta:resourcekey="Uom1004Resource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <a id="a2004" runat="server" visible="False"><span class="label_title">
                <asp:Label ID="Rs_DC" Text="DC" runat="server" meta:resourcekey="Rs_DCResource1"></asp:Label></span></a>
            <div id="d2004" style="display: none; padding-left: 30px" runat="server">
                <asp:Repeater runat="server" ID="rpt2004">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                        meta:resourcekey="lblNameResource2"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                        meta:resourcekey="lblResultResource2"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                        meta:resourcekey="Uom1004Resource2"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <asp:Repeater runat="server" ID="rpt12004">
                <ItemTemplate>
                    <table style="padding-left: 10px">
                        <tr>
                            <td>
                                <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                    meta:resourcekey="lblNameResource3"></asp:Label>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                    meta:resourcekey="lblResultResource3"></asp:Label>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                    meta:resourcekey="Uom1004Resource3"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>
            <table style="padding-left: 10px">
                <tr>
                    <td>
                        <asp:Label runat="server" ID="l2055" CssClass="results" meta:resourcekey="l2055Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="l12055" CssClass="results" meta:resourcekey="l12055Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="Uom2055" CssClass="results" meta:resourcekey="Uom2055Resource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <a id="a2016" runat="server" visible="False"><span class="label_title">
                <asp:Label ID="Rs_PeripheralSmear" Text="Peripheral Smear" runat="server" meta:resourcekey="Rs_PeripheralSmearResource1"></asp:Label></span></a>
            <div id="d2016" style="display: none; padding-left: 30px" runat="server">
                <table>
                    <tr>
                        <td>
                            <a id="a2017" runat="server" visible="false"><span class="label_title">
                                <asp:Label ID="Rs_RedCells" Text="Red Cells" runat="server" meta:resourcekey="Rs_RedCellsResource1"></asp:Label></span></a>
                            <div id="d2017" style="width: 100%; display: block; padding-left: 30px">
                                <asp:Repeater runat="server" ID="rpt2017">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource4"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource4"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a id="a2023" runat="server" visible="false"><span class="label_title">
                                <asp:Label ID="Rs_WBC" Text="WBC" runat="server" meta:resourcekey="Rs_WBCResource1"></asp:Label></span></a>
                            <div id="d2023" style="width: 100%; display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt2023">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource5"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource5"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a id="a2027" runat="server" visible="false"><span class="label_title">
                                <asp:Label ID="Rs_Platlets" Text="Platlets" runat="server" meta:resourcekey="Rs_PlatletsResource1"></asp:Label></span></a>
                            <div id="d2027" style="width: 100%; display: none; padding-left: 30px" runat="server">
                                <asp:Repeater runat="server" ID="rpt2027">
                                    <ItemTemplate>
                                        <table style="padding-left: 10px">
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                        meta:resourcekey="lblNameResource6"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                        meta:resourcekey="lblResultResource6"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Panel runat="server" ID="pn2030" Visible="False" meta:resourcekey="pn2030Resource1">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="lbl2030" CssClass="results" meta:resourcekey="lbl2030Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lbl12030" CssClass="results" meta:resourcekey="lbl12030Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lbl22030" CssClass="results" meta:resourcekey="lbl22030Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lbl32030" CssClass="results" meta:resourcekey="lbl32030Resource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <asp:Repeater runat="server" ID="rpt2032">
                <ItemTemplate>
                    <table style="padding-left: 10px">
                        <tr>
                            <td>
                                <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                    meta:resourcekey="lblNameResource7"></asp:Label>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                    meta:resourcekey="lblResultResource7"></asp:Label>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                    meta:resourcekey="Uom1004Resource4"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>
            <table>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lbl2031" CssClass="results" meta:resourcekey="lbl2031Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="lbl12031" CssClass="results" meta:resourcekey="lbl12031Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="lbl22031" CssClass="results" meta:resourcekey="lbl22031Resource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 10px">
            <a id="a2036" runat="server" visible="false"><span class="label_title">
                <asp:Label ID="Rs_others" Text="others" runat="server" meta:resourcekey="Rs_othersResource1"></asp:Label>
            </span></a>
            <div id="d2036" style="width: 100%; display: none; padding-left: 30px" runat="server">
                <table>
                    <tr>
                        <td>
                            <asp:Repeater runat="server" ID="rpt2036">
                                <ItemTemplate>
                                    <table style="padding-left: 10px">
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                                    meta:resourcekey="lblNameResource8"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                                    meta:resourcekey="lblResultResource8"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:Repeater>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Panel runat="server" ID="pn2037" meta:resourcekey="pn2037Resource1">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="l2037" CssClass="results" meta:resourcekey="l2037Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="l12037" CssClass="results" meta:resourcekey="l12037Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="l22037" CssClass="results" meta:resourcekey="l22037Resource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Panel runat="server" ID="pn2038" meta:resourcekey="pn2038Resource1">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="l2038" CssClass="results" meta:resourcekey="l2038Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="l12038" CssClass="results" meta:resourcekey="l12038Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="l22038" CssClass="results" meta:resourcekey="l22038Resource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Panel runat="server" ID="pn2041" meta:resourcekey="pn2041Resource1">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="l2041" CssClass="results" meta:resourcekey="l2041Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="l12041" CssClass="results" meta:resourcekey="l12041Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="l22041" CssClass="results" meta:resourcekey="l22041Resource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <a id="a2042" runat="server" visible="false"><span class="label_title">
                <asp:Label ID="Rs_CoagulationProfile" Text="Coagulation Profile" runat="server" meta:resourcekey="Rs_CoagulationProfileResource1"></asp:Label></span></a>
            <div id="d2042" style="width: 100%; display: none; padding-left: 30px" runat="server">
                <asp:Repeater runat="server" ID="rpt2042">
                    <ItemTemplate>
                        <table style="padding-left: 10px">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblName" CssClass="results" Text='<%# Bind("InvestigationName") %>'
                                        meta:resourcekey="lblNameResource9"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblResult" Text='<%# Bind("Value") %>' CssClass="results"
                                        meta:resourcekey="lblResultResource9"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="Uom1004" Text='<%# Bind("UOMCode") %>' CssClass="results"
                                        meta:resourcekey="Uom1004Resource5"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div id="d2047" style="width: 100%; display: none; padding-left: 30px" runat="server">
                <table style="padding-left: 10px">
                    <tr>
                        <td colspan="3">
                            <asp:Label runat="server" ID="lblpro" CssClass="defaultfontcolor" meta:resourcekey="lblproResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="lblControl" CssClass="results" meta:resourcekey="lblControlResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lblResult1" CssClass="results" meta:resourcekey="lblResult1Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="Uomcontrol" CssClass="results" meta:resourcekey="UomcontrolResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="lblPatient" CssClass="results" meta:resourcekey="lblPatientResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lblResult2" CssClass="results" meta:resourcekey="lblResult2Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="UomResult" CssClass="results" meta:resourcekey="UomResultResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="lblINR" CssClass="results" meta:resourcekey="lblINRResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lblResult3" CssClass="results" meta:resourcekey="lblResult3Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="UomINR" CssClass="results" meta:resourcekey="UomINRResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
