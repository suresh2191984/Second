<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReminderDisplay.aspx.cs" Inherits="Reminder_ReminderDisplay"  Culture="auto" UICulture="auto"  %>

<%@ Register src="../CommonControls/ReminderDisplay.ascx" tagname="ReminderDisplay" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body onContextMenu="return false;">
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
    </asp:ScriptManager>
        <table border="0" cellpadding="0" cellspacing="0" width="80%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="remain" runat="server"><ContentTemplate>
                    <uc1:ReminderDisplay ID="RemainderDisplay1" runat="server"  />
                    </ContentTemplate></asp:UpdatePanel>
                </td>            
            </tr>        
        </table>
    </form>
</body>
</html>
