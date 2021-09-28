<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PO_RequestPrint.aspx.cs"
    Inherits="PORequest_RequestPrint" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/PORequest/Controls/PurchaseRequestPrint.ascx" TagName="RequestPrint"
    TagPrefix="uc7" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PO Request Print page</title>

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        function doPrint() {
            document.getElementById('btnsearch').style.display = 'none';
            var prtContent = document.getElementById('tdBtns');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();


        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <attune:attuneheader id="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="tdBtns">
            <table class="w-100p">
                <tr>
                    <td colspan="2">
                        <asp:Repeater ID="RptrReports" runat="server" OnItemDataBound="RptrReports_ItemDataBound">
                            <ItemTemplate>
                                <asp:HiddenField ID="hdnprid" runat="server" Value='<%#Eval("PurchaseRequestID") %>' />
                                <uc7:RequestPrint ID="RequestPrints" runat="server" />
                            </ItemTemplate>
                        </asp:Repeater>
                    </td>
                </tr>
                <tr>
                    <td class="a-center" colspan="2">
                        <asp:Button ID="btnsearch" runat="server" CssClass="btn" Text="Print" 
                            OnClientClick="return doPrint();" meta:resourcekey="btnsearchResource1" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <input type="hidden" id="hdnvalues" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <attune:attunefooter id="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    </form>
</body>
</html>
