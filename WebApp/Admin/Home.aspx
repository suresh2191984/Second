<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Admin_Home"
    meta:resourcekey="PageResource1" %>

<%--<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>--%>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>--%>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%--<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>--%>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc10" %>
<%--<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/ProductReminderDisplay.ascx" TagName="ProductReminderDisplay"
    TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/PhySchedule.ascx" TagName="PSchedule" TagPrefix="ps" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>
        <%=Resources.Admin_AppMsg.Admin_Home_aspx_01%>
    </title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>
<style>
    .cmdLink 
    {
        background:url(../Images/forward-icon.png) no-repeat;
     width: 214px;
    height: 29px;
    padding: 8px 0 0 9px;
    display: block;
    color: #fff!important;
    font-size: 18px;
    font-weight: bold;
    margin-top: 1px;
    }
</style>
</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
            <asp:LinkButton ID="cmdLink"  runat="server" CssClass="cmdLink" Text="Go To PMS Screen" OnClick="cmdLink_Click">
            </asp:LinkButton>
        <table class="datatable w-100p">
            <tr>
                <td>
                    <uc6:TaskControl ID="TaskControl1" runat="server" />
                    <uc10:Department ID="Department1" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <uc7:TaskEscalation ID="TaskEscalation1" runat="server" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td>
                    <uc8:ReminderDisplay ID="ReminderDisplay1" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <uc11:ProductReminderDisplay ID="ProductReminderDisplay" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr style="display:none">
                <td colspan="3">
                    <ps:PSchedule ID="phySch" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
