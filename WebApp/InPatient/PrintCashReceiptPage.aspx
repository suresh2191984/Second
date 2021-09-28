<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintCashReceiptPage.aspx.cs" Inherits="Reception_PrintReceiptPage" meta:resourcekey="PageResource1" %>
<%@ Register Src="../CommonControls/CashReceipt.ascx" TagName="CashReceipt" TagPrefix="uc9" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Advance Receipt </title>
    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript" >
        window.print();
    </script>
</head>
<body id="oneColLayout" style="font-size: 12px;" onContextMenu="return false;" >
    <form id="form1" runat="server" >
 <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <table width="90%"><tr><td align="left">
    
    
    <table border="0" id="maintable" runat="server" cellpadding="0" cellspacing="0" width="90%" > 
        <tr>
            <td >
                  <div id="advanceReceipt">
                             <uc9:CashReceipt id="Cashreceipt" runat="server" />
                                
                                </div>&nbsp;</td>
        </tr>
    </table>   
                         
    </td></tr></table>
   
</form>
</body>
</html>


