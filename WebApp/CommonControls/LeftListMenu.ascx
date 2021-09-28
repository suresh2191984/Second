<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LeftListMenu.ascx.cs" Inherits="CommonControls_General" %>
<%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
<asp:Repeater ID="rptMenu" runat="server">

<ItemTemplate>
<asp:HyperLink ID="hlk" Font-Underline="false" NavigateUrl='<%# Eval("URL")%>'  runat="server"> <li class="boxmenu"><%# Eval("Text")%></li></asp:HyperLink>
</ItemTemplate>
</asp:Repeater>
<div class="boxmenu">
<h1></h1>
<ul>
<li class="boxmenu">Main Menu1</li>
<ul>
<li class="boxmenusub">Sub Menu1 what happens if its too long</li>
<li class="boxmenusub">Sub Menu2</li>
<li class="boxmenusub">Sub Menu3</li>
<li class="boxmenusub">Sub Menu4</li>
</ul>
<li class="boxmenu">Main Menu2</li>
<ul>
<li class="boxmenusub">Sub Menu1</li>
<li class="boxmenusub">Sub Menu2</li>
<li class="boxmenusub">Sub Menu3</li>
<li class="boxmenusub">Sub Menu4</li>
</ul>
</ul>
</div>