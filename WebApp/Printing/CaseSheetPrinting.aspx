<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CaseSheetPrinting.aspx.cs"
    Inherits="Printing_CaseSheetPrinting" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/OPCaseSheet.ascx" TagName="OPCaseSheet" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table border="0" cellpadding="0" cellspacing="0" width="70%">
        <tr>
            <td>
                <uc1:OPCaseSheet ID="OPCaseSheet1" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                    onmouseout="this.className='btn'" meta:resourcekey="btnPrintResource1" />
                <asp:Button ID="btnHome" runat="server" Text="Home" OnClick="btnHome_Click" CssClass="btn"
                    onmouseover="this.className='btn btnhov'" 
                    onmouseout="this.className='btn'" meta:resourcekey="btnHomeResource1" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
