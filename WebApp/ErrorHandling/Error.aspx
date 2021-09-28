<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="ErrorHandling_Error" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/PlatFormControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/PlatFormControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Error Page</title>
</head>
<body oncontextmenu="return false;">
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table cellpadding="2" cellspacing="1" width="100%">
            <tr>
                <td>
                    <h3>
                        An Error has occurred</h3>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>An unexpected error has occurred. The Administrator </br> has been notified
                    </strong>
                </td>
            </tr>
        </table>
    </div>
   
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
