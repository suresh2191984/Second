<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminXLStockReport.aspx.cs"
    Inherits="InventoryReports_AdminXLStockReport" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Stock Report</title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div id="divStockReport" class="contentdata">
        <asp:Table ID="DeStockReport" runat="server" Width="100%" meta:resourcekey="DeStockReportResource1">
            <asp:TableRow meta:resourcekey="TableRowResource3">
                <asp:TableCell ID="DecHeaderOrgAddress" Font-Bold="true" runat="server" meta:resourcekey="DecHeaderOrgAddressResource1">
                    <asp:Table ID="DetHeaderOrgAddress" runat="server" Width="50%" meta:resourcekey="DetHeaderOrgAddressResource1">
                        <asp:TableRow meta:resourcekey="TableRowResource1">
                            <asp:TableCell ID="DeorgName" Font-Bold="true" Font-Size="14px" runat="server" meta:resourcekey="DeorgNameResource1">
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow meta:resourcekey="TableRowResource2">
                            <asp:TableCell ID="DeorgAddress" Font-Bold="true" runat="server" meta:resourcekey="DeorgAddressResource1">
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
                <asp:TableCell ID="DecHeaderStockReport" Font-Bold="true" Font-Size="16px" HorizontalAlign="Right"
                    runat="server" meta:resourcekey="DecHeaderStockReportResource1">
  
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow meta:resourcekey="TableRowResource4">
                <asp:TableCell ColumnSpan="2" meta:resourcekey="TableCellResource1">
            <hr  />
           
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trstockreport" runat="server" meta:resourcekey="trstockreportResource1">
                <asp:TableCell ID="DefromToStockReport" Font-Bold="true" runat="server" ColumnSpan="2"
                    meta:resourcekey="DefromToStockReportResource1">
                    
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trhr" runat="server" meta:resourcekey="trhrResource1">
                <asp:TableCell ColumnSpan="2" meta:resourcekey="TableCellResource2">
            <hr  />
           
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow meta:resourcekey="TableRowResource5">
                <asp:TableCell ID="DecColumns" runat="server" Width="100%" ColumnSpan="2" meta:resourcekey="DecColumnsResource1">
                    <asp:Table ID="DeDataHeaders" runat="server" Width="100%" GridLines="Both" meta:resourcekey="DeDataHeadersResource1">
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
