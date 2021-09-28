<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LeftReferrals.ascx.cs" Inherits="CommonControls_LeftReferrals" %>


<div id="leftDiv" runat="server">
 <%--<div id="midReferral" runat="server" style="cursor:pointer;" onclick="showReferral();"></div>--%>
     <div class="arrowlistmenu">
        <div class="menuheader">
            <div class="dropmenutxt">
                <%=Resources.CommonControls_ClientDisplay.CommonControls_LeftReferrals_ascx_001%>
            </div>
        </div>
      <div class="categoryitems">
    <div id="hideReferraldiv" style="display:  block;">
        <ul class="boxe">
         <asp:Repeater ID="rptReferral" runat="server">
            <ItemTemplate>
                            <asp:HyperLink ID="hlk" Font-Underline="False" NavigateUrl='<%# Eval("MenuURL") %>'
                                runat="server" meta:resourcekey="hlkResource1"> 
                    <li class="boxmenu_1"><%#Eval("MenuName")%>
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