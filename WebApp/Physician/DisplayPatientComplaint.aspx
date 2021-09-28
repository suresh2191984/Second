<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DisplayPatientComplaint.aspx.cs"
    Inherits="Physician_DisplayPatientComplaint" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Select Complaint</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>
<body oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnHideValues">
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
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:DocHeader ID="ReceptionHeader" runat="server" />
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
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" cellpadding="0" cellspacing="0" width="50%" align="center">
                            <tr>
                                <td>
                                    <asp:Label ID="lblComplaintName" runat="server" Text="Complaint Name" CssClass="defaultfontcolor"
                                        meta:resourcekey="lblComplaintNameResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <asp:RadioButtonList ID="rdolPatientComplaint" runat="server" CssClass="defaultfontcolor"
                                        meta:resourcekey="rdolPatientComplaintResource1">
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnAddMore" Text="Add" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnAddMore_Click" meta:resourcekey="btnAddMoreResource1"
                                        Width="60px" />
                                    <asp:Button ID="btnEdit" Text="Edit" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnEdit_Click" meta:resourcekey="btnEditResource1"
                                        Width="50px" />
                                    <asp:Button ID="btnRemove" Text="Remove" Visible="False" runat="server" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnRemove_Click"
                                        meta:resourcekey="btnRemoveResource1" Width="57px" />
                                    <asp:Button ID="btnDone" Text="Back" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnDone_Click" meta:resourcekey="btnDoneResource1"
                                        Width="53px" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:Button ID="btnHideValues" runat="server" OnClientClick="javascript:return false;"
        Style="height: 0px; width: 0px;" meta:resourcekey="btnHideValuesResource1" />
    </form>
</body>
</html>
