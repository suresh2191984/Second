<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientVitals2.ascx.cs"
    Inherits="CommonControls_PatientVitals2" %>
<%@ OutputCache Duration="300" VaryByParam="None" Shared="true" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<div class="details">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="13">
                &nbsp;
            </td>
            <td width="604" valign="middle">
                <ul>
                    <li class="details_label">
                        <asp:Label ID="Rs_Name" runat="server" Text="Name" meta:resourcekey="Rs_NameResource1"></asp:Label></li>
                    <li class="details_value">
                        <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label></li>
                    <li class="details_label2">
                        <asp:Label ID="Rs_Age" runat="server" Text="Age" meta:resourcekey="Rs_AgeResource1"></asp:Label>
                    </li>
                    <li class="details_value">
                        <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label></li>
                    <li class="details_label2">
                        <asp:Label ID="Rs_Sex" runat="server" Text="Sex" meta:resourcekey="Rs_SexResource1"></asp:Label>
                    </li>
                    <li class="details_value">
                        <asp:Label ID="lblSex" runat="server" meta:resourcekey="lblSexResource1"></asp:Label></li>
                    <li class="details_value"></li>
                </ul>
            </td>
            <td width="100" align="center" valign="middle">
                <img id="vitalsImg" runat="server" src="Images/today_event.png" alt="case summary"
                    width="100" height="45" />
            </td>
            <td width="225">
                <ul class="casesummary">
                    <li id="VSummry1" runat="server" class="casesummary">
                        <asp:Label ID="lblBP" runat="server" meta:resourcekey="lblBPResource1"></asp:Label>
                        <asp:Label ID="lblBPVal" runat="server" meta:resourcekey="lblBPValResource1">/</asp:Label>
                        <asp:Label ID="lblBPUOMCode" runat="server" meta:resourcekey="lblBPUOMCodeResource1"></asp:Label></li>
                    <li id="VSummry2" runat="server" class="casesummary">
                        <asp:Label ID="lblTemp" runat="server" meta:resourcekey="lblTempResource1"></asp:Label>
                        <asp:Label ID="lblTempVal" runat="server" meta:resourcekey="lblTempValResource1"></asp:Label>
                        <asp:Label ID="lblTempUOMCode" runat="server" meta:resourcekey="lblTempUOMCodeResource1"></asp:Label></li>
                    <li id="VSummry3" runat="server" class="casesummary">
                        <asp:Label ID="lblPulse" runat="server" meta:resourcekey="lblPulseResource1"></asp:Label>
                        <asp:Label ID="lblPulseVal" runat="server" meta:resourcekey="lblPulseValResource1"></asp:Label>
                        <asp:Label ID="lblPulseUOMCode" runat="server" meta:resourcekey="lblPulseUOMCodeResource1"></asp:Label></li>
                </ul>
            </td>
            <td width="12">
                &nbsp;
            </td>
        </tr>
    </table>
</div>
