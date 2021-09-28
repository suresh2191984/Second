<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SmallSummary.ascx.cs" Inherits="CommonControls_SmallSummary" %>
<li class="patientdetailslist">
<ul class="patientheader">
<li class="patientheader"><asp:Literal ID="litTitle" runat="server"></asp:Literal></li>
<asp:Repeater ID="rptItems" runat="server">
<ItemTemplate>
<li class="patientnote"><%#Eval("Text") %> </li>
</ItemTemplate>
</asp:Repeater>
</ul>
</li>