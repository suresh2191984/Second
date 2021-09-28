      <%@ Page Language="C#" AutoEventWireup="true" CodeFile="RefPhyHome.aspx.cs" Inherits="Reception_RefPhyHome" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Home Page</title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        window.history.forward(1);
       
        
       
    </script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
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
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc9:UserHeader ID="UserHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table cellpadding="2" cellspacing="1" width="100%">
                            <tr>
                                <td align="left" class="defaultfontcolor">
                                    <asp:Label ID="Rs_PendingTaskList" Text="Pending Task List" runat="server" 
                                        meta:resourcekey="Rs_PendingTaskListResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td height="32" class="defaultfontcolor">
                                    <uc8:Task ID="uctlTaskList" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <br />
                        <%--     <div id="dCapture" runat="server" visible="false">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="background-color: #2c88b1" width="25%" height="23" align="left">
                                        <div id="dCaption" runat="server" visible="false">
                                            <span class="dataheader1txt">&nbsp;Investigaton Result Capture</span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                    &nbsp;
                                </tr>
                                <tr>
                                    <td colspan="2" class="defaultfontcolor">
                                        <asp:GridView ID="GridView1" runat="server" ForeColor="Black" Width="97%" CellPadding="4"
                                            AutoGenerateColumns="false" GridLines="Both" OnRowDataBound="GridView1_RowDataBound">
                                            <HeaderStyle BackColor="#2C88B1" ForeColor="White" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Radiology Tasks List" ControlStyle-Width="250px">
                                                    <ItemTemplate>
                                                    
                                                        <a href='<%# "~/Investigation/InvestigationCapture.aspx?vid="+DataBinder.Eval(Container.DataItem,"PatientVisitID") %>'
                                                            runat="server" id="lnklist" style="text-decoration: none; color: Black">
                                                            <%# "Enter Result for " +(string)DataBinder.Eval(Container.DataItem,"PatientName") %>
                                                        </a>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                    <asp:BoundField ControlStyle-Width="120px" DataField="VisitDate" HeaderText="Investigation Ordered Date" DataFormatString="{0:dd MMM yyyy}" />
                                                    <asp:BoundField ControlStyle-Width="80px" Visible="false" DataField="Status" HeaderText="Status" />
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </div>--%>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
