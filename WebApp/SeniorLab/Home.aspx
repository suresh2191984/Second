<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Lab_InvestigationApproval"
%>

<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="OrgHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc6" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Investigation Sample Collection</title>
    <link href="../StyleSheets/dialysis.css" rel="stylesheet" type="text/css" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:OrgHeader ID="OrgHeader1" runat="server" />
                <uc3:UserHeader ID="UserHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc2:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <ul>
                            <li>
                                <uc4:ErrorDisplay ID="ErrorDisplay2" runat="server" />
                            </li>
                        </ul>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td colspan="2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%; height: 22px;" class="colorforcontent">
                                    <asp:Label ID="lblName" Text="Reports for approval" runat="server" Font-Size="Larger"
                                        ForeColor="White"></asp:Label>
                                </td>
                                <td style="width: 40%;">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div runat="server" id="ShowDiv" visible="false">
                                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Width="60%"
                                            CellSpacing="0" CellPadding="4" OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound"
                                            DataKeyNames="PatientVisitID" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging">
                                            <HeaderStyle CssClass="Duecolor" />
                                            <Columns>
                                                <asp:BoundField Visible="false" DataField="PatientVisitID" HeaderText="VisitID" />
                                                <asp:TemplateField HeaderText="View Investigation Report">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblname" Text='<%# "View Investigation Report of "+(string)DataBinder.Eval(Container.DataItem,"PatientName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                    <div runat="server" id="ShowDiv1" visible="false">
                                        <asp:Label runat="server" ID="lblshow" Text="No Reports to approve">
                                        </asp:Label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
