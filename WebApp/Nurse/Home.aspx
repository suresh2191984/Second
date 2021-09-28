<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Masters_NurseHome"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/TransactionStatus.ascx" tagname="transtatus" tagprefix="uc9" %>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Nurse Home Page</title>


</head>
<body oncontextmenu="return false;">
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <table class="w-100p">
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="Rs_PendingTaskList" Text="Pending Task List" runat="server" meta:resourcekey="Rs_PendingTaskListResource1"></asp:Label>
                                    <uc10:Department ID="Department1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td id="defaultfontcolor">
                                    <uc8:Task ID="tasknew" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
         <Attune:Attunefooter ID="Attunefooter" runat="server" />      
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
