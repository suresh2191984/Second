<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CustomizedBill.aspx.cs" Inherits="Reception_CustomizedBill"
    meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head id="Head1" runat="server">
    <title>Print Bill</title>

    <script language="javascript" type="text/javascript">
        window.name = "BillWindow";
    </script>

</head>
<body id="oneColLayout" oncontextmenu="return false;">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table border="0" id="tblprt" cellpadding="2" cellspacing="1" width="100%" style="font-size: 14px;">
        <%--<tr>
            <td style="height: 62px;">
                &nbsp;
            </td>
        </tr>--%>
        <tr id="trHtmlView" style="display: block;">
            <td style="width: 1%;">
                &nbsp;
            </td>
            <td width="100%">
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td width="10%" style='width: 10.9%; padding: .75pt .75pt .75pt .75pt; height: 5.0pt'>
                            &nbsp; &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 300px;" valign="top">
                            <asp:Table CellPadding="0" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="0px"
                                runat="server" ID="billMasterTab" Width="876px" meta:resourcekey="billMasterTabResource1">
                                <asp:TableRow ID="trBillType" Height="5px" BorderWidth="0" meta:resourcekey="trBillTypeResource1">
                                    <asp:TableHeaderCell ColumnSpan="4" HorizontalAlign="center" meta:resourcekey="TableHeaderCellResource1">
                                        <asp:Label ID="lblBillType" runat="server" Font-Bold="false" Font-Names="Lucida Console"
                                            meta:resourcekey="lblBillTypeResource1"></asp:Label>
                                    </asp:TableHeaderCell></asp:TableRow>
                                <asp:TableRow BorderWidth="0" meta:resourcekey="TableRowResource2">
                                    <asp:TableHeaderCell HorizontalAlign="Left" meta:resourcekey="TableHeaderCellResource2">
                                        <asp:Table CellPadding="1" Font-Bold="false" CssClass="colorforcontentborder" CellSpacing="0"
                                            BorderWidth="0" runat="server" ID="dispTab1" Width="100%" meta:resourcekey="dispTab1Resource1">
                                            <asp:TableRow Height="20px" BorderWidth="0" meta:resourcekey="TableRowResource1">
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="right" Width="5%" meta:resourcekey="TableHeaderCellResource3">
                                &nbsp;
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="Left" Width="40%" meta:resourcekey="TableHeaderCellResource4">
                                                    <asp:Literal ID="PatientName" runat="server" meta:resourcekey="PatientNameResource1"></asp:Literal>
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="right" Width="25%" meta:resourcekey="TableHeaderCellResource5">
                                &nbsp;
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="Left" Width="24%" meta:resourcekey="TableHeaderCellResource6">
                                                    <asp:Literal ID="BillNo" runat="server" meta:resourcekey="BillNoResource1"></asp:Literal>
                                                </asp:TableHeaderCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                                <asp:TableRow BorderWidth="0" meta:resourcekey="TableRowResource4">
                                    <asp:TableHeaderCell HorizontalAlign="Left" meta:resourcekey="TableHeaderCellResource7">
                                        <asp:Table CellPadding="1" Font-Bold="false" CssClass="colorforcontentborder" CellSpacing="0"
                                            BorderWidth="0" runat="server" ID="dispTab" Width="100%" meta:resourcekey="dispTabResource1">
                                            <asp:TableRow Height="20px" BorderWidth="0" meta:resourcekey="TableRowResource3">
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="right" Width="5%" meta:resourcekey="TableHeaderCellResource8">
                                 &nbsp;     
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="Left" Width="40%" meta:resourcekey="TableHeaderCellResource9">
                                      &nbsp;
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="right" Width="25%" meta:resourcekey="TableHeaderCellResource10">
                                      &nbsp;
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="Left" Width="24%" meta:resourcekey="TableHeaderCellResource11">
                                                    <asp:Literal ID="BillDate" runat="server" meta:resourcekey="BillDateResource1"></asp:Literal>
                                                </asp:TableHeaderCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                                <asp:TableRow Height="20px" BorderWidth="0" meta:resourcekey="TableRowResource6">
                                    <asp:TableHeaderCell HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource12">
                                        <asp:Table CellPadding="1" Font-Bold="false" CssClass="colorforcontentborder" CellSpacing="0"
                                            BorderWidth="0" runat="server" ID="Table1" Width="100%" meta:resourcekey="Table1Resource1">
                                            <asp:TableRow Height="10px" BorderWidth="0" meta:resourcekey="TableRowResource5">
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="right" Width="5%" meta:resourcekey="TableHeaderCellResource13">
                                &nbsp;
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="Left" Width="40%" meta:resourcekey="TableHeaderCellResource14">
                                                    <asp:Literal ID="DrName" runat="server" meta:resourcekey="DrNameResource1"></asp:Literal>
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="right" Width="25%" meta:resourcekey="TableHeaderCellResource15">
                              &nbsp;
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="Left" Width="24%" meta:resourcekey="TableHeaderCellResource16">
                                                    <asp:Literal ID="VisitNo" runat="server" meta:resourcekey="VisitNoResource1"></asp:Literal>
                                                </asp:TableHeaderCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                                <asp:TableRow ID="TableRow1" runat="server" BorderWidth="0" meta:resourcekey="TableRow1Resource1">
                                    <asp:TableHeaderCell ColumnSpan="2" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource17">
                                        <asp:Table CellPadding="0" CellSpacing="0" BorderWidth="0" runat="server" ID="trCC"
                                            Style="display: none;" Width="100%" meta:resourcekey="trCCResource1">
                                            <asp:TableRow Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource7">
                                                <asp:TableHeaderCell ColumnSpan="2" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource18">
                                                    <asp:Literal ID="Literal4" runat="server" Text="Collection Centre:" meta:resourcekey="Literal4Resource1"></asp:Literal>
                                                    &nbsp;
                                                    <asp:Literal ID="CollectionCentre" runat="server" meta:resourcekey="CollectionCentreResource1"></asp:Literal>
                                                </asp:TableHeaderCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                                <asp:TableRow Height="40px" runat="server" BorderWidth="0" meta:resourcekey="TableRowResource8">
                                    <asp:TableCell meta:resourcekey="TableCellResource1">&nbsp;&nbsp;&nbsp;</asp:TableCell></asp:TableRow>
                                <%--<asp:TableRow ID="TableRow2" runat="server" BorderWidth="0">
                                    <asp:TableCell>&nbsp;&nbsp;&nbsp;</asp:TableCell></asp:TableRow>
                                <asp:TableRow ID="TableRow3" runat="server" BorderWidth="0">
                                <asp:TableCell>&nbsp;&nbsp;&nbsp;</asp:TableCell></asp:TableRow>--%>
                            </asp:Table>
                            <%--</td>
                    </tr>
        <tr>--%>
                            <%--<td style="height: 162px;" valign="top">--%>
                            <table cellpadding="0" cellspacing="0" border="0" style="font-size: 15px; height: 31%"
                                width="100%">
                                <tr>
                                    <td colspan="4" style="width: 720px;" valign="top">
                                        <asp:Panel ID="pnlTst" runat="server" Width="720px" meta:resourcekey="pnlTstResource1">
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table cellpadding="2" cellspacing="0" border="0" width="100%">
                                <tr>
                                    <td style="width: 80px;">
                                        &nbsp;
                                    </td>
                                    <td style="width: 98px;" align="left">
                                        <asp:Label runat="server" ID="lblTot" meta:resourcekey="lblTotResource1"></asp:Label>
                                    </td>
                                    <td style="width: 154px;">
                                        &nbsp;
                                    </td>
                                    <td style="width: 27px;" align="left">
                                        <asp:Label runat="server" ID="lblPaidAmt" meta:resourcekey="lblPaidAmtResource1"></asp:Label>
                                    </td>
                                    <td style="width: 213px;">
                                        &nbsp;
                                    </td>
                                    <td style="width: 151px;" align="left">
                                        <asp:Label runat="server" ID="lblDueAmt" meta:resourcekey="lblDueAmtResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 13.5%;">
                &nbsp;
            </td>
        </tr>
    </table>
    </form>

    <script language="javascript" type="text/javascript">

        window.print();
        //var prtContent = document.getElementById('tblprt');
        //var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,Addressbar=no');
        //alert(WinPrint);
        //var WinPrint = window.open('', '', 'letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
        //WinPrint.document.write(prtContent.innerHTML);
        //WinPrint.document.close();
        //WinPrint.focus();
        //WinPrint.print();
        //WinPrint.close();
    </script>

</body>
</html>
