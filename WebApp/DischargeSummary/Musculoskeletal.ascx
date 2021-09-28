<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Musculoskeletal.ascx.cs"
    Inherits="DischargeSummary_Musculoskeletal" %>
<table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblOrtho" style="display: none;"
    runat="server">
    <tr runat="server" id="trBP" style="display: none;">
        <td>
            <asp:Table ID="tblBP" runat="server" CellSpacing="0" 
                meta:resourcekey="tblBPResource1">
            </asp:Table>
        </td>
    </tr>
    <tr runat="server" id="trBPAbsent" style="display: none;">
        <td>
            <asp:Table ID="tbBPAbsent" runat="server" CellSpacing="0" 
                meta:resourcekey="tbBPAbsentResource1">
            </asp:Table>
        </td>
    </tr>
    <tr runat="server" id="trOpentWound" style="display: none;">
        <td>
            <asp:Table ID="tblOpentWound" runat="server" CellSpacing="0" 
                meta:resourcekey="tblOpentWoundResource1">
            </asp:Table>
        </td>
    </tr>
    <tr runat="server" id="trVD" style="display: none; " >
        <td>
            <asp:Table ID="tblVD" runat="server" CellSpacing="0" 
                meta:resourcekey="tblVDResource1">
            </asp:Table>
        </td>
    </tr>
    <tr runat="server" id="trPND" style="display: none;" >
        <td>
            <table cellpadding="0" cellspacing="0" border="0">
                <tr runat="server" id="trPNDH" style="display: none;">
                    <td>
                        <asp:Label ID="lblPNDH" Text="Neurological deficit present:" runat="server" 
                            Font-Bold="True" meta:resourcekey="lblPNDHResource1"></asp:Label>
                    </td>
                </tr>
                <tr runat="server" id="trRoot" style="display: none;">
                    <td>
                        <asp:Label ID="lblRoot" runat="server" meta:resourcekey="lblRootResource1"></asp:Label>
                    </td>
                </tr>
                <tr runat="server" id="trPlexus" style="display: none;">
                    <td>
                        <asp:Label ID="lblPlexus" runat="server" meta:resourcekey="lblPlexusResource1"></asp:Label>
                    </td>
                </tr>
                <tr runat="server" id="trNerve" style="display: none;">
                    <td>
                        <asp:Label ID="lblNerve" runat="server" meta:resourcekey="lblNerveResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr runat="server" id="trRef" style="display: none;">
        <td>
            <asp:Table ID="tblRef" runat="server" cellpadding="0" cellspacing="0" 
                border="0" meta:resourcekey="tblRefResource1">
            </asp:Table>
        </td>
    </tr>
    <tr runat="server" id="trMus" style="display: none;">
        <td>
            <asp:Table ID="tblMus" runat="server" cellpadding="0" cellspacing="0" 
                border="0" meta:resourcekey="tblMusResource1">
            </asp:Table>
        </td>
    </tr>
    <tr runat="server" id="trMW" style="display: none;">
        <td>
           <asp:Label ID="lblMWH" Text="Muscle Wasting:" runat="server" Font-Bold="True" 
                meta:resourcekey="lblMWHResource1"></asp:Label>
           <asp:Label ID="lblMWT"  runat="server" meta:resourcekey="lblMWTResource1" ></asp:Label>
        </td>
    </tr>
</table>
