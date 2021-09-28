<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Header.ascx.cs" Inherits="Physician_Header" %>
<%@ OutputCache Duration="300" VaryByParam="None" Shared="true" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<div>
    <ul>
        <li class="details_label">Name:</li>
        <li class="details_value1">
            <asp:Literal ID="lblName" runat="server"></asp:Literal></li>
    </ul>
</div>
<div>
    <ul>
        <li class="details_label">Age:</li>
        <li class="details_value1">
            <asp:Literal ID="lblAge" runat="server"></asp:Literal></li>
    </ul>
</div>
