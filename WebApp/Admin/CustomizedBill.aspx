<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CustomizedBill.aspx.cs" Inherits="Reception_CustomizedBill" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head id="Head1" runat="server">
    <title>Print Bill</title>

    <script language="javascript" type="text/javascript">
        window.name ="BillWindow";
    </script>

</head>
<body id="oneColLayout"  oncontextmenu="return false;">
    <form id="prFrm" runat="server">  <asp:ScriptManager ID="ScriptManager1" runat="server">
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
                            <asp:Table CellPadding="0" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="0"
                                runat="server" ID="billMasterTab" Width="876px">
                                <asp:TableRow ID="trBillType" Height="5px" BorderWidth="0">
                                    <asp:TableHeaderCell ColumnSpan="4" HorizontalAlign="center">
                                        <asp:Label ID="lblBillType" runat="server" Font-Bold="false" Font-Names="Lucida Console"></asp:Label>
                                    </asp:TableHeaderCell></asp:TableRow>
                                <asp:TableRow BorderWidth="0">
                                    <asp:TableHeaderCell HorizontalAlign="Left">
                                        <asp:Table CellPadding="1" Font-Bold="false" CssClass="colorforcontentborder" CellSpacing="0"
                                            BorderWidth="0" runat="server" ID="dispTab1" Width="100%">
                                            <asp:TableRow Height="20px" BorderWidth="0">
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="right" Width="5%">
                            
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="Left" Width="40%">
                                                    <asp:Literal ID="PatientName" runat="server"></asp:Literal>
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="right" Width="25%">
                               
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="Left" Width="24%">
                                                    <asp:Literal ID="BillNo" runat="server"></asp:Literal>
                                                </asp:TableHeaderCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                                <asp:TableRow BorderWidth="0">
                                    <asp:TableHeaderCell HorizontalAlign="Left">
                                        <asp:Table CellPadding="1" Font-Bold="false" CssClass="colorforcontentborder" CellSpacing="0"
                                            BorderWidth="0" runat="server" ID="dispTab" Width="100%">
                                            <asp:TableRow Height="20px" BorderWidth="0">
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="right" Width="5%">
                                    
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="Left" Width="40%">
                                 
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="right" Width="25%">
                                         </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="Left" Width="24%">
                                                    <asp:Literal ID="BillDate" runat="server"></asp:Literal>
                                                </asp:TableHeaderCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                                <asp:TableRow Height="20px" BorderWidth="0">
                                    <asp:TableHeaderCell HorizontalAlign="left">
                                        <asp:Table CellPadding="1" Font-Bold="false" CssClass="colorforcontentborder" CellSpacing="0"
                                            BorderWidth="0" runat="server" ID="Table1" Width="100%">
                                            <asp:TableRow Height="10px" BorderWidth="0">
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="right" Width="5%">
                               
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="Left" Width="40%">
                                                    <asp:Literal ID="DrName" runat="server"></asp:Literal>
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="right" Width="25%">
                            
                                                </asp:TableHeaderCell>
                                                <asp:TableHeaderCell Font-Bold="false" HorizontalAlign="Left" Width="24%">
                                                    <asp:Literal ID="VisitNo" runat="server"></asp:Literal>
                                                </asp:TableHeaderCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                                <asp:TableRow ID="TableRow1" runat="server" BorderWidth="0">
                                    <asp:TableHeaderCell ColumnSpan="2" HorizontalAlign="left">
                                        <asp:Table CellPadding="0" CellSpacing="0" BorderWidth="0" runat="server" ID="trCC"
                                            Style="display: none;" Width="100%">
                                            <asp:TableRow Height="15px" BorderWidth="0">
                                                <asp:TableHeaderCell ColumnSpan="2" HorizontalAlign="left">
                                                    <asp:Literal ID="Literal4" runat="server" Text="Collection Centre:"></asp:Literal>
                                                    &nbsp;
                                                    <asp:Literal ID="CollectionCentre" runat="server"></asp:Literal>
                                                </asp:TableHeaderCell></asp:TableRow>
                                        </asp:Table>
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                                <asp:TableRow Height="40px" runat="server" BorderWidth="0">
                                    <asp:TableCell>&nbsp;&nbsp;&nbsp;</asp:TableCell></asp:TableRow>
                                <%--<asp:TableRow ID="TableRow2" runat="server" BorderWidth="0">
                                    <asp:TableCell>&nbsp;&nbsp;&nbsp;</asp:TableCell></asp:TableRow>
                                <asp:TableRow ID="TableRow3" runat="server" BorderWidth="0">
                                <asp:TableCell>&nbsp;&nbsp;&nbsp;</asp:TableCell></asp:TableRow>--%>
                            </asp:Table>
                            <%--</td>
                    </tr>
        <tr>--%>
                            <%--<td style="height: 162px;" valign="top">--%>
                            <table cellpadding="0" cellspacing="0" border="0" style="font-size:13px; height: 31%"
                                width="100%">
                                <tr>
                                    <td colspan="4" style="width: 720px;" valign="top">
                                        <asp:Panel ID="pnlTst" runat="server" Width="720px">
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
                                        <asp:Label runat="server" ID="lblTot"></asp:Label>
                                    </td>
                                    <td style="width: 154px;">
                                        &nbsp;
                                    </td>
                                    <td style="width: 27px;" align="left">
                                        <asp:Label runat="server" ID="lblPaidAmt"></asp:Label>
                                    </td>
                                    <td style="width: 213px;">
                                        &nbsp;
                                    </td>
                                    <td style="width: 151px;" align="left">
                                        <asp:Label runat="server" ID="lblDueAmt"></asp:Label>
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
