<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintStockReport.aspx.cs"
    Inherits="InventoryReports_PrintStockReport" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Stock Report</title>
</head>
<body id="oneColLayout">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div id="div1" class="contentdata">
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label ID="fromToStockReport" runat="server" Font-Names="Calibri" meta:resourcekey="fromToStockReportResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="orgName" runat="server" Font-Names="Calibri" meta:resourcekey="orgNameResource1"></asp:Label>
                    <asp:Label ID="orgAddress" runat="server" Font-Names="Calibri" meta:resourcekey="orgAddressResource1"></asp:Label>
                </td>
            </tr>
        </table>
        <asp:GridView ID="gvprintsales" runat="server" AutoGenerateColumns="False" Width="100%"
            Visible="False" ForeColor="#333333" HeaderStyle-Font-Bold="true" OnRowDataBound="gvprintsales_RowDataBound"
            Font-Names="Calibri" meta:resourcekey="gvprintsalesResource1">
            <Columns>
                <asp:BoundField DataField="TDate" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}"
                    ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource1">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="BatchNo" HeaderText="Batch NO" ItemStyle-HorizontalAlign="Center"
                    meta:resourcekey="BoundFieldResource2">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="ExpiredDate" HeaderText="Expiry Date " DataFormatString="{0:dd/MM/yyyy}"
                    ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource3">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="OpeningBalance" HeaderText="OpeningBalance " ItemStyle-HorizontalAlign="Center"
                    meta:resourcekey="BoundFieldResource4">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="CostPrice" HeaderText="Cost Price " ItemStyle-HorizontalAlign="right"
                    meta:resourcekey="BoundFieldResource5">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="SellingPrice" HeaderText="Selling Price " ItemStyle-HorizontalAlign="right"
                    meta:resourcekey="BoundFieldResource6">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="OpeningStockValueCP" HeaderText="Opening Stock Value @CP "
                    ItemStyle-HorizontalAlign="right" meta:resourcekey="BoundFieldResource7">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="OpeningStockValue" HeaderText="Opening Stock Value @SP "
                    ItemStyle-HorizontalAlign="right" meta:resourcekey="BoundFieldResource8">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="StockReceived" HeaderText="Stock Received" ItemStyle-HorizontalAlign="Center"
                    meta:resourcekey="BoundFieldResource9">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="ReceivedStockValueCP" HeaderText="Received Stock Value @ CP "
                    ItemStyle-HorizontalAlign="right" meta:resourcekey="BoundFieldResource10">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="ReceivedStockValue" HeaderText="Received Stock Value @ SP "
                    ItemStyle-HorizontalAlign="right" meta:resourcekey="BoundFieldResource11">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="StockIssued" HeaderText="Stock Issued" ItemStyle-HorizontalAlign="Center"
                    meta:resourcekey="BoundFieldResource12">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="IssuedStockValueCP" HeaderText="Issued Stock Value @ CP "
                    ItemStyle-HorizontalAlign="right" meta:resourcekey="BoundFieldResource13">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="IssuedStockValue" HeaderText="Issued Stock Value @ SP "
                    ItemStyle-HorizontalAlign="right" meta:resourcekey="BoundFieldResource14">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="StockDamage" HeaderText="Stock Damage " ItemStyle-HorizontalAlign="Center"
                    meta:resourcekey="BoundFieldResource15">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="StockReturn" HeaderText="Stock Return" ItemStyle-HorizontalAlign="Center"
                    meta:resourcekey="BoundFieldResource16">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="ClosingBalance" HeaderText="Closing Balance " ItemStyle-HorizontalAlign="Center"
                    meta:resourcekey="BoundFieldResource17">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="ClosingStockValueCP" HeaderText="Closing Stock Value @CP "
                    ItemStyle-HorizontalAlign="right" meta:resourcekey="BoundFieldResource18">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="ClosingStockValue" HeaderText="Closing Stock Value @SP "
                    ItemStyle-HorizontalAlign="right" meta:resourcekey="BoundFieldResource19">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="Units" HeaderText="Units" ItemStyle-HorizontalAlign="Center"
                    meta:resourcekey="BoundFieldResource20">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
            </Columns>
            <HeaderStyle Font-Bold="True"></HeaderStyle>
        </asp:GridView>
        <div id="divPrint" align="center">
            <hr />
            <input type="button" name="btnPrint" value="Print" class="btn" onmouseover="this.className='btn btnhov'"
                onmouseout="this.className='btn'" onclick="PrintReport()" />
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">
    function PrintReport() {
        document.getElementById('divPrint').style.display = "none";
        //window.print();

        var prtContent = document.getElementById('div1');

        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();
        return false;
    }
</script>

