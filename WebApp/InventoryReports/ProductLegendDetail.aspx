<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductLegendDetail.aspx.cs"
    Inherits="InventoryReports_ProductLegendDetail" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Stock Report</title>
</head>
<body id="oneColLayout">
    <form id="form1" runat="server">
    &nbsp;&nbsp;&nbsp;
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div id="div1" runat="server" class="contentdata">
        <div id="divprnt" runat="server">
        <asp:Table ID="StockReport" runat="server" Width="100%" meta:resourcekey="StockReportResource1">
            <asp:TableRow>
                <asp:TableCell ID="cHeaderStockReport" Font-Bold="true" Font-Size="16px" HorizontalAlign="Right"
                    runat="server" meta:resourcekey="cHeaderStockReportResource1">
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow meta:resourcekey="TableRowResource4">
                <asp:TableCell ColumnSpan="11" meta:resourcekey="TableCellResource1">
            <hr  />
           
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow meta:resourcekey="TableRowResource5">
                <asp:TableCell ID="fromToStockReport" Font-Bold="true" runat="server" ColumnSpan="9"
                    meta:resourcekey="fromToStockReportResource1">
                    
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow meta:resourcekey="TableRowResource6">
                <asp:TableCell ColumnSpan="11" meta:resourcekey="TableCellResource2">
            <hr  />
           
                </asp:TableCell>
            </asp:TableRow>
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
            </asp:TableRow>
            <asp:TableRow meta:resourcekey="TableRowResource7">
                <asp:TableCell ID="cColumns" runat="server" Width="100%" ColumnSpan="2" meta:resourcekey="cColumnsResource1">
                    <asp:Table ID="DataHeaders" runat="server" Width="100%" meta:resourcekey="DataHeadersResource1">
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <input type="hidden" id="hdnRowCount" runat="server" />
        </div>
                <hr />
        <div id="divPrint" align="center">
            
            <input type="button" name="btnPrint" value="Print" class="btn" onmouseover="this.className='btn btnhov'"
                onmouseout="this.className='btn'" onclick="PrintReport()" />
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">
    function PrintReport() {
        //        document.getElementById("btnPrint").style.display = "none";
        //        window.print();
        //document.getElementById("btnPrint").style.display = "none";
        var prtContent = document.getElementById('divprnt');
        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no,height=768,width=1350');
        // WinPrint.document.write($('head').html() + prtContent.innerHTML);
        WinPrint.document.write('<html><head><title></title>');
        WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/Common.css" />');
        WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/Themes/IB/style.css" />');
        WinPrint.document.write('</head><body >');
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.write('</body></html>');
        WinPrint.document.close();
        
        WinPrint.focus();
        setTimeout(function() {

            WinPrint.print();
            WinPrint.close();
        }, 1000);
    }
</script>

