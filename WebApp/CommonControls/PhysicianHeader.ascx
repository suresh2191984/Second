<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PhysicianHeader.ascx.cs" Inherits="Physician_PhysicianHeader" %>
<div class="details">
    <ul>
        <li class="details_label"><%=Resources.CommonControls_ClientDisplay.CommonControls_PhysicianHeader_ascx_01%> </li>
        <li class="details_valueleft">
            <asp:Literal ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Literal></li>
        <li class="details_valueright"> 
    <asp:Label ID="lblRolename" Font-Bold="True" runat="server" 
                meta:resourcekey="lblRolenameResource1" ></asp:Label>
</li>    
    </ul>
</div>
