<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Admin_Home"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="~/PlatFormControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/PlatFormControls/Department.ascx" TagName="Department" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Home Page</title>
</head>
<body>
    <form id="RecHome" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
       
        <table class="w-100p">
            <tr>
                <td>
                    <uc2:Department ID="Department1" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="blackfontcolorbig">
                    <asp:Label ID="Rs_TasksLists" Text="Tasks Lists" runat="server" meta:resourcekey="Rs_TasksListsResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <uc8:Task ID="TaskControl1" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
