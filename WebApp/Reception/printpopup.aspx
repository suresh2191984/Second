<%@ Page Language="C#" AutoEventWireup="true" CodeFile="printpopup.aspx.cs" Inherits="Reception_printpopup" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/PrintPatientRegistration.ascx" TagName="PrintPatRegistration"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/PrintIPAdmissionDetails.ascx" TagName="PrintIP" TagPrefix="uc10" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script language="javascript" type="text/javascript">
        function popupprint() {
            var prtContent = document.getElementById('printPatientReg');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>
</head>
<body onload="window.print();">
    <form id="form1" runat="server" >  <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="printPatientReg" runat="server">
        <uc9:PrintPatRegistration ID="ucPatReg" runat="server" />
        <uc10:PrintIP ID="ucIP" runat="server" />
    </div>
    </form>
</body>
</html>
