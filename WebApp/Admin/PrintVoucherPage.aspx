<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintVoucherPage.aspx.cs"
    Inherits="Admin_PrintReceiptPage" %>

<%@ Register Src="../CommonControls/VoucherReceipt.ascx" TagName="Vouchers" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PrintReceipt.ascx" TagName="Receipt" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Voucher Receipt </title>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        window.print();
        //        window.opener.closeData();
    </script>

</head>
<body id="oneColLayout" style="font-size: 12px;" oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table width="100%">
        <tr>
            <td align="left">
                <table border="0" id="maintable" runat="server" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <div id="advanceReceipt" runat="server">
                                <uc1:Vouchers ID="ucPatientAdvance" runat="server" />
                            </div>
                            &nbsp;
                            <div id="divReceiptDetails" runat="server">
                                <uc2:Receipt ID="ucReceiptDetails" runat="server" />
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
