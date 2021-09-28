<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LabSummaryReport.ascx.cs" Inherits="CommonControls_Lab_Summary_Report" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
    
    <%--<script type="text/javascript" src="../Scripts/jquery.min.js" language="javascript"></script>

<script type="text/javascript" src="../Scripts/ddaccordion.js" language="javascript"></script>
<script type="text/javascript" src="../scripts/menu.js" language="javascript"></script>--%>
<div id="leftUpDiv" runat="server" class="leftmenubgcode">
    <%--<div id="upRate" runat="server" style="cursor:pointer;" onclick="showMenuMaster();"></div>--%>
    <div class="arrowlistmenu">
        <div class="menuheader">
            <div class="dropmenutxt">
                <%=Resources.CommonControls_ClientDisplay.CommonControls_LabSummaryReport_ascx_001%>
            </div>
        </div>
      <div class="categoryitems">
    <div id="hideManageSchedules" style="display:block;">
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
