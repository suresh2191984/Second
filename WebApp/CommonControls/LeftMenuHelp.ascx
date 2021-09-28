<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LeftMenuHelp.ascx.cs" Inherits="CommonControls_LeftMenuHelp" %>


    
<div id="leftDiv"  runat="server">
 <div class="arrowlistmenu">
    <div class="menuheader"><div class="dropmenutxt" style="padding-right:0px;padding-left:21px;">
<%=Resources.CommonControls_ClientDisplay.CommonControls_LeftMenuHelp_ascx_001%></div></div>
      <div class="categoryitems">
    <%--<div id="midIP" runat="server" style="cursor:pointer;" onclick="showIP();"></div>--%>
    <div id="hideIPdiv" style="display: block;">
        <ul class="boxe">
         <asp:Repeater ID="rptHelp" runat="server">
            <ItemTemplate>
                <asp:HyperLink ID="hlk" Font-Underline="False" 
                    NavigateUrl='<%# Eval("MenuURL") %>' runat="server" 
                    meta:resourcekey="hlkResource1"> 
                    <li class="boxmenu_2"><%#Eval("MenuName")%>
                </li></asp:HyperLink>
            </ItemTemplate>
        </asp:Repeater>
        </ul>
    
        <ul class="bottom">
        <li></li>
        </ul>
    </div>
 </div>
 </div>
</div>    