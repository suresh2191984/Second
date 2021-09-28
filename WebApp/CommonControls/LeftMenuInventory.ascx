<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LeftMenuInventory.ascx.cs" Inherits="CommonControls_LeftMenuInventory" %>
<div id="leftDiv" runat="server">

    <div class="arrowlistmenu" >
        <div class="menuheader">
            <div class="dropmenutxt">
                <%--<%=Resources.MenuMasterHeader.__CommonControls_LeftMenuInventory_ascx%>--%><%=Resources.CommonControls_ClientDisplay.CommonControls_LeftMenuInventory_ascx_001%>
            </div>
        </div>
        <div class="categoryitems">
    <div id="hideInventorydiv" style="display: block;">
        <ul class="boxe">
         <asp:Repeater ID="rptInventory" runat="server">
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