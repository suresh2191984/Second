<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LeftMenuMDM.ascx.cs" Inherits="CommonControls_LeftMenuMDM" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
 
<div id="leftUpDiv"  runat="server">

     <div class="arrowlistmenu">
        <div class="menuheader">
            <div class="dropmenutxt" style="padding-right:0px;padding-left:21px;">
                <%--<%=Resources.MenuMasterHeader.__CommonControls_LeftMenuMDM_ascx%>--%><%=Resources.CommonControls_ClientDisplay.CommonControls_LeftMenuMDM_ascx_001%></div>
        </div>
        <div class="categoryitems">
    <div id="hidedivRates" style="display: block;">
        <ul class="boxe">
         <asp:Repeater ID="rptIP" runat="server">
            <ItemTemplate>
               <%-- <asp:HyperLink ID="hlk" Font-Underline="false" NavigateUrl='<%# Eval("MenuURL")%>' runat="server"> 
                    <li class="boxmenu_2"><%#Eval("MenuName")%>
                </li></asp:HyperLink>--%>
                 <li class="boxmenu_2">
                            <a href="javascript:void(0);"  role="button" onclick='<%#string.Format("navigateURL(\"{0}\",\"..{1}\",\"{2}\",\"{3}\",\"{4}\");",Eval("PageID"),Eval("MenuURL"),Eval("MenuName"),Eval("TemplateUrl"),Eval("Controller"),Eval("SequenceId")) %>'>
                                                       <%#Eval("MenuName")%>
                                                </a>
                            </li>
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
