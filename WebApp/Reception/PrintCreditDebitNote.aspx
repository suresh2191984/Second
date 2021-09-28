<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintCreditDebitNote.aspx.cs" Inherits="Reception_PrintCreditDebitNote" %>
<%--<%@ Register Src="../CommonControls/AdvanceReceipt.ascx" TagName="AdvancePaid" TagPrefix="uc15" %>--%>
   <%@ Register Src="../CommonControls/AdvanceClientReceipt.ascx" TagName="AdvanceClientPaid" TagPrefix="UCClient" %>
   <%@ Register Src="../CommonControls/CreditdebitSummary.ascx" TagName="CreditdebitSummary" TagPrefix="UCCrDr" %>
 <%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Deposit Receipt </title>
    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript" >
        window.print();
        //window.opener.closeData();
    </script>
</head>
<body id="oneColLayout" onContextMenu="return false;" >
    <form id="form1" runat="server" >
     <div style="display:none;">
    <t1:Theme ID="Theme1" runat="server" />
    </div>
 <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table width="100%"  id="tblpatient" runat="server" >
    <tr><td align="left">
                <%--<uc15:AdvancePaid id="ucPatientAdvance" runat="server" />--%>
    </td>
    </tr>
    </table>
    <table width="100%" id="tblclients" runat="server">
    <tr><td align="left">
   <%--<UCClient:AdvanceClientPaid id="UCClientAdvance" runat="server" />--%>
    </td></tr>
    </table>
    <table width="100%" id="tblCrDr" runat="server">
    <tr>
    <td align="left">
    <UCCrDr:CreditdebitSummary id="UCCreditDebit" runat="server" />
    </td>
    </tr>
    </table>
   
</form>
</body>
</html>



