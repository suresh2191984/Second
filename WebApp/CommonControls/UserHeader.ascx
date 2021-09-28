<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserHeader.ascx.cs" Inherits="CommonControls_UserHeader" %>
<%@ Register Src="Communication.ascx" TagName="Communication" TagPrefix="uc7" %>
<div class="details" align="left">
    <style type="text/css">
        .details_valueMsg
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
            font-weight: bold;
            color: #ffffff;
            margin-top: 10px;
            margin-left: 500px;
        }
    </style>
    <ul>
        <li class="details_label">
            <%=Resources.CommonControls_ClientDisplay.CommonControls_PhysicianHeader_ascx_01 %>
        </li>
        <li class="details_valueleft">
            <asp:Literal ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Literal></li>
        <%--Added below lines for communciation module--%>
        <li class="details_valueMsg">
            <uc7:Communication ID="Communication1" runat="server" />
        </li>
        <%--Communciation module End--%>
        <li class="details_valueright">
            <asp:Label ID="lblRolename" Font-Bold="True" runat="server" meta:resourcekey="lblRolenameResource1"></asp:Label>
        </li>
    </ul>
</div>
