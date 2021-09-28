<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LeftMenu.ascx.cs" Inherits="CommonControls_LeftMenu" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="UserRoleChange.ascx" TagName="ChangeRole" TagPrefix="uc1" %>
<%@ Register Src="LeftMenuIP.ascx" TagName="LeftMenuIP" TagPrefix="uc2" %>
<%@ Register Src="LeftMenuMDM.ascx" TagName="LeftMenuMDM" TagPrefix="uc3" %>
<%@ Register Src="LeftMenuInventory.ascx" TagName="LeftMenuInventory" TagPrefix="uc4" %>
<%@ Register Src="ManageSchedules.ascx" TagName="ManageSchedules" TagPrefix="uc5" %>
<%@ Register Src="LeftReferrals.ascx" TagName="LeftReferrals" TagPrefix="uc6" %>
<%@ Register Src="LabSummaryReport.ascx" TagName="LabSummaryReport" TagPrefix="uc7" %>
<%@ Register Src="LeftMenuHelp.ascx" TagName="LeftMenuHelp" TagPrefix="uc8" %>
<%@ Register Src="LeftMenuMRD.ascx" TagName="LeftMenuMRD" TagPrefix="uc9" %>
<%@ Register Src="Theme.ascx" TagName="Theme" TagPrefix="uc101" %>
<%@ Register Src="ChangeLocation.ascx" TagName="ChangeLocation" TagPrefix="uc11" %>
<%@ Register Src="DaycareMenu.ascx" TagName="Daycare" TagPrefix="uc12" %>
<%@ Register Src="Corporate.ascx" TagName="ucCorp" TagPrefix="uc13" %>
<%@ Register Src="InventoryAdmin.ascx" TagName="ucInvAdmin" TagPrefix="uc14" %>
<%@ Register Src="LeftMenuInventorySales.ascx" TagName="LeftMenuInvSales" TagPrefix="uc15" %>

<%--<script src="../Scripts_New/Common.js" type="text/javascript" language="javascript"></script>--%>

<%-- neww code--%>
<%--<script type="text/javascript" src="../Scripts/jquery.min.js" language="javascript"></script>

<script type="text/javascript" src="../Scripts/ddaccordion.js "language="javascript"></script>

<script type="text/javascript" src="../scripts/menu.js" language="javascript"></script>--%>

<div id="leftDiv" runat="server">
    <div class="arrowlistmenu">
        <div class="menuheader">
            <div class="dropmenutxt" style="padding-right:0px;padding-left:21px;">
                <%=Resources.CommonControls_ClientDisplay.CommonControls_LeftMenu_ascx_001%>
                <%--<%=Resources.MenuMasterHeader.__CommonControls_LeftMenu_ascx%>--%></div>
        </div>
        <div class="categoryitems">
            <div id="hideOPdiv" style="display: block;">
                <ul class="boxe">
                    <asp:Repeater ID="rptMenu" runat="server">
                        <ItemTemplate>
                            <%--<asp:HyperLink ID="hlk" Font-Underline="false" NavigateUrl='<%# Eval("MenuURL")%>'
                                runat="server"> <li class="boxmenu_2"><%#Eval("MenuName")%> </li></asp:HyperLink>
                             --%>
                            <li class="boxmenu_2">
                            <a href="javascript:void(0);"  role="button" onclick='<%#string.Format("navigateURL(\"{0}\",\"..{1}\",\"{2}\",\"{3}\",\"{4}\");",Eval("PageID"),Eval("MenuURL"),Eval("MenuName"),Eval("TemplateUrl"),Eval("Controller"),Eval("SequenceId")) %>'>
                                                       <%#Eval("MenuName")%>
                                                </a>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
                <ul class="menubottom">
                    <li></li>
                </ul>
            </div>
        </div>
    </div>
    <uc1:ChangeRole ID="ucChangeRole" runat="server" CSSMidStyle="changerole" />
    <uc2:LeftMenuIP ID="CommonTaskIP" runat="server" CSSMidStyle="topIP" />
    <uc3:LeftMenuMDM ID="LeftMenuMDM" runat="server" CSSMidStyle="MDM" />
    <uc4:LeftMenuInventory ID="LeftMenuInventory" runat="server" CSSMidStyle="topInventory" />
    <uc14:ucInvAdmin ID="InvAdmin" runat="server" CSSMidStyle="topInventory" />
    <uc15:LeftMenuInvSales ID="LeftMenuInventorySalesOrder" runat="server" CSSMidStyle="topInventory" />
    <uc11:ChangeLocation ID="ChangeLocation1" runat="server" />
    <uc5:ManageSchedules ID="LeftManageSchedules" runat="server" CSSMidStyle="ManageSchedules" />
    <uc6:LeftReferrals ID="LeftReferrals1" runat="server" CSSMidStyle="topReferral" />
    <uc7:LabSummaryReport ID="LeftLabSummaryReport" runat="server" CSSMidStyle="LabSummaryReport" />
    <uc9:LeftMenuMRD ID="LeftMenuMRD1" runat="server" />
    <uc8:LeftMenuHelp ID="LeftMenuHelp1" runat="server" />
    <uc12:Daycare ID="Daycare" runat="server" />
    <uc13:ucCorp ID="Corporate" runat="server" />
    <uc101:Theme ID="Theme1" runat="server"  />
</div>
<div id="jsonDiv" style="display: block;">
</div>
