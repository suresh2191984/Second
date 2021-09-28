<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReferedInvestigation.aspx.cs"
    Inherits="Investigation_ReferedInvestigation" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/ReferedInvestigation.ascx" TagName="ReferedInvestigation"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function printMe() {

            window.print();
            return false;
        }
    
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <uc1:ReferedInvestigation ID="ReferedInvestigation1" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Button ID="btnHome" runat="server" Text="Home" CssClass="btn" OnClick="btnHome_Click" meta:resourcekey="btnHomeResource1" />
                <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn" meta:resourcekey="btnPrintResource1" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
