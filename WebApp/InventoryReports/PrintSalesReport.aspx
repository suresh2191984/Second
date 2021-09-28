<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintSalesReport.aspx.cs"
    Inherits="InventoryReports_PrintSalesReport" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sales Report</title>
    <style type="text/css">
        div1
        {
            border-top: 2px solid #369;
            border-left: 2px solid #369;
        }
    </style>
</head>
<body id="oneColLayout">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div id="div1" class="contentdata">
        <asp:Table ID="StockReport" runat="server" Width="100%" meta:resourcekey="StockReportResource1">
            <asp:TableRow meta:resourcekey="TableRowResource3">
                <asp:TableCell ID="cHeaderOrgAddress" Font-Bold="true" runat="server" meta:resourcekey="cHeaderOrgAddressResource1">
                    <asp:Table ID="tHeaderOrgAddress" runat="server" Width="50%" meta:resourcekey="tHeaderOrgAddressResource1">
                        <asp:TableRow meta:resourcekey="TableRowResource1">
                            <asp:TableCell ID="orgName" Font-Bold="true" Font-Size="14px" runat="server" meta:resourcekey="orgNameResource1">
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow meta:resourcekey="TableRowResource2">
                            <asp:TableCell ID="orgAddress" Font-Bold="true" runat="server" meta:resourcekey="orgAddressResource1">
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
                <asp:TableCell ID="cHeaderStockReport" Font-Bold="true" Font-Size="16px" HorizontalAlign="Right"
                    runat="server" meta:resourcekey="cHeaderStockReportResource1">
  
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow meta:resourcekey="TableRowResource4">
                <asp:TableCell ColumnSpan="2" meta:resourcekey="TableCellResource1">
            <hr/>
           
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow meta:resourcekey="TableRowResource5">
                <asp:TableCell ID="fromToStockReport" Font-Bold="true" runat="server" ColumnSpan="2"
                    meta:resourcekey="fromToStockReportResource1">
                    
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow meta:resourcekey="TableRowResource6">
                <asp:TableCell ColumnSpan="2" meta:resourcekey="TableCellResource2">
            <hr  />
           
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow Font-Names="calibri" Font-Size="Smaller" meta:resourcekey="TableRowResource7">
                <asp:TableCell ID="cColumns" runat="server" Width="100%" ColumnSpan="2" meta:resourcekey="cColumnsResource1">
                    <asp:Table ID="DataHeaders" runat="server" Width="100%" meta:resourcekey="DataHeadersResource1">
                    </asp:Table>
                    <asp:Table ID="DataHeaders1" runat="server" Width="100" BorderStyle="Double" Style="border-left: 3px gray;
                        border-right: border-right: 1px solid black; border-top: 3px gray; border-bottom: 3px gray;
                        border-right-style: 3px gray" HorizontalAlign="Right" meta:resourcekey="DataHeaders1Resource1">
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <div id="divPrint" align="center">
            <hr />
            <asp:Button ID="btnPrint" runat="server" Text="Print" Width="100px" CssClass="btn"
                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="return popupprint();"
                meta:resourcekey="btnPrintResource1" />
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>

<script language="javascript" type="text/javascript">


    function popupprint() {
        var prtContent = document.getElementById('div1');
        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
        //alert(WinPrint);
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();
    }
</script>

</html>
