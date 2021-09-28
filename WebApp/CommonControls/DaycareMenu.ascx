<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DaycareMenu.ascx.cs" Inherits="CommonControls_DaycareMenu" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
   
<div id="leftDiv"  runat="server">
 <div class="arrowlistmenu">
        <div class="menuheader">
            <div class="dropmenutxt">
                <%=Resources.CommonControls_ClientDisplay.CommonControls_DaycareMenu_aspx_001%>
            </div>
        </div>
      <div class="categoryitems">
    <%--<div id="midIP" runat="server" style="cursor:pointer;" onclick="showIP();"></div>--%>
    <div id="hideIPdiv" style="display: block;">
        <ul class="boxe">
         <asp:Repeater ID="rptIP" runat="server">
            <ItemTemplate>
                            <asp:HyperLink ID="hlk" Font-Underline="False" NavigateUrl='<%# Eval("MenuURL") %>'
                                runat="server" meta:resourcekey="hlkResource1"> 
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