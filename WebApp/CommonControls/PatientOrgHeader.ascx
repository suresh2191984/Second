<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientOrgHeader.ascx.cs" Inherits="CommonControls_PatientOrgHeader" %>
<div>
    <table style="width:100%;" class="title" border="0" cellpadding="0" 
        cellspacing="0">
        <tr>
            <td class="main_title" style="width:35%">
                <asp:Label ID="lblOrgName" runat="server" 
                    meta:resourcekey="lblOrgNameResource1"></asp:Label>
            </td>
            <td style="width:35%">
                <div id="divBanner" runat="server">
                    <marquee scrolldelay="250" scrollAmount="5" direction="left">
                        <asp:Label ID="lblBannerText" CssClass="bannerText" runat="server"></asp:Label></marquee>
                </div>
            </td>
            <td style="width:30%">
                <asp:LinkButton ID="lnkLogOut" runat="server" CssClass="logout_position"
                    ForeColor="White"
                    onclick="lnkLogOut_Click" Width=90px 
                    meta:resourcekey="lnkLogOutResource1" />
            </td>
        </tr>
    </table>
</div>