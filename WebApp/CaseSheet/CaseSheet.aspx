<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CaseSheet.aspx.cs" Inherits="CaseSheet_CaseSheet" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/OPCaseSheet.ascx" TagName="OP" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/FeesEntry.ascx" TagName="FeesEntry" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Case Sheet</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
</head>

<body>
    <form id="form1" runat="server" defaultbutton="btnOk">
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
                <uc2:Header ID="Header2" runat="server" />
                <uc6:PatientHeader ID="PatientHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <uc10:OP ID="OP1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="middle">
                                    <uc1:FeesEntry ID="billing" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="middle">
                                    <div class="dataheader2" style="width: 488px;">
                                        <br clear="all" />
                                        &nbsp;<asp:Label ID="lblTxt" runat="server" Text="Next Review After" 
                                            CssClass="defaultfontcolor" meta:resourcekey="lblTxtResource1"></asp:Label>
                                        <asp:DropDownList ID="ddlNos" runat="server" meta:resourcekey="ddlNosResource1" CssClass="ddl">
                                            <asp:ListItem Value="1" meta:resourcekey="ListItemResource1">1</asp:ListItem>
                                            <asp:ListItem Value="2" meta:resourcekey="ListItemResource2">2</asp:ListItem>
                                            <asp:ListItem Value="3" meta:resourcekey="ListItemResource3">3</asp:ListItem>
                                            <asp:ListItem Value="4" meta:resourcekey="ListItemResource4">4</asp:ListItem>
                                            <asp:ListItem Value="5" meta:resourcekey="ListItemResource5">5</asp:ListItem>
                                            <asp:ListItem Value="6" meta:resourcekey="ListItemResource6">6</asp:ListItem>
                                            <asp:ListItem Value="7" meta:resourcekey="ListItemResource7">7</asp:ListItem>
                                            <asp:ListItem Value="8" meta:resourcekey="ListItemResource8">8</asp:ListItem>
                                            <asp:ListItem Value="9" meta:resourcekey="ListItemResource9">9</asp:ListItem>
                                            <asp:ListItem Value="10" meta:resourcekey="ListItemResource10">10</asp:ListItem>
                                            <asp:ListItem Value="11" meta:resourcekey="ListItemResource11">11</asp:ListItem>
                                            <asp:ListItem Value="0" meta:resourcekey="ListItemResource12">0</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddlDMY" runat="server" CssClass="ddl" meta:resourcekey="ddlDMYResource1" 
                                            Width="71px">
                                            <asp:ListItem Value="Day(s)" meta:resourcekey="ListItemResource13">Day(s)</asp:ListItem>
                                            <asp:ListItem Value="Week(s)" meta:resourcekey="ListItemResource14">Week(s)</asp:ListItem>
                                            <asp:ListItem Value="Month(s)" meta:resourcekey="ListItemResource15">Month(s)</asp:ListItem>
                                            <asp:ListItem Value="Year(s)" meta:resourcekey="ListItemResource16">Year(s)</asp:ListItem>
                                        </asp:DropDownList>
                                        <br clear="all" />
                                        <br />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="middle">
                                    <asp:Button ID="btnOk" Text="Ok" runat="server" OnClick="btnOk_Click" CssClass="btn"
                                        Width="63px" 
                                        meta:resourcekey="btnOkResource1" Height="24px" />
                                    <asp:Button ID="btnEdit" Text="Edit" runat="server" OnClick="btnEdit_Click" CssClass="btn"
                                         Width="69px" 
                                        meta:resourcekey="btnEditResource1" Height="26px" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
