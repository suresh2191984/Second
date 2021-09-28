<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintDueRequestPage.aspx.cs"
    Inherits="InPatient_PrintDueRequestPage" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/DueChartList.ascx" TagName="DueRequest" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/EsInvIntrimBill.ascx" TagName="EsInvDue" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Due Request</title>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function fnPrint() {
            window.print();
        }  //window.opener.closeData();

        function PrintDynamic() {

            var prtContent = document.getElementById("pagetdPrint");
            var WinPrint = window.open('', '', 'left=-1,top=-1,width=10,height=10,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;

        }
        
    </script>

</head>
<body id="oneColLayout" oncontextmenu="return false;">
    <form id="form1" runat="server">
    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table width="100%">
        <tr>
            <td align="left">
                <uc1:DueRequest ID="uctlDueRequest1" runat="server" />
                <uc2:EsInvDue ID="EsInvDueRequest" runat="server" />
            </td>
        </tr>
        <tr>
            <td style="display: none;" width="100%" runat="server" id="pagetdPrint" enableviewstate="false">
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
