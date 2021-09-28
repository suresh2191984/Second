<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Psychologist_Home" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay" TagPrefix="uc6" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Psychologist's Home</title>
    <script src="../Scripts/bid.js" type="text/javascript"></script>
    <script src="../Scripts/Common.js" type="text/javascript"></script>
</head>
<body>
    <form id="form2" runat="server" defaultbutton="btnHideValues">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:DocHeader ID="docHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <%--<h2 id="us">
                            <asp:Label ID="Rs_OutPatients" Text="Out Patients" runat="server" meta:resourcekey="Rs_OutPatientsResource1"></asp:Label></h2>--%>
                        <table cellpadding="2" cellspacing="1" width="100%" class="datatable" border="0">
                            <tr>
                                <td align="right">
                                    <uc9:Department ID="Department1" runat="server" />
                                    <asp:LinkButton ID="lbtnPRcount" Text="RecomendationCount" runat="server" Visible="False"
                                        Font-Underline="True" Font-Bold="True" ForeColor="#0033CC" PostBackUrl="~/Patient/PendingRecommendation.aspx"
                                        ToolTip="Click here to view Pending Recommendations" meta:resourcekey="lbtnPRcountResource1"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%--<uc7:Tasks ID="Tasks1" runat="server" />--%>
                                    <uc8:Task ID="TaskNew1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc6:ReminderDisplay ID="ReminderDisplay1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:LinkButton Text="link" runat="server" Visible="False" Enabled="False" 
                                        PostBackUrl="~/Psychologist/Counselling.aspx" 
                                        meta:resourcekey="LinkButtonResource1"></asp:LinkButton>
                                    &nbsp;                                        
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    <asp:Button ID="btnHideValues" runat="server" OnClientClick="javascript:return false;"
        Style="height: 0px; width: 0px;" meta:resourcekey="btnHideValuesResource1" />
    </form>
</body>
</html>
