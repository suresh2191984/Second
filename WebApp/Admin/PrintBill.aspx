<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintBill.aspx.cs" Inherits="Admin_PrintBill" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/SampleBillPrint.ascx" TagName="BillPrintControl"
    TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Print Bill</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <style type="text/css" media="print">
        #header, #footer
        {
            display: none;
        }
    </style>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        window.name = "BillWindow";
    </script>

</head>
<body id="oneColLayout" oncontextmenu="return false;">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table border="0" cellpadding="2" cellspacing="1" width="600px">
        <tr id="trHtmlView" style="display: block;">
            <td width="700px">
                <table border="0" cellpadding="2" cellspacing="1" width="70%">
    <tr>
    <td id="orgHeaderRD" runat="server" align="center">
    
    </td>
    </tr>
    </table>
                <asp:Table CellPadding="2" CssClass="colorforcontentborder"  CellSpacing="0" Font-Size="Small"
                    BorderWidth="0" runat="server" ID="billMasterTab" Width="70%">
                    <asp:TableRow ID="TableRow2" Height="15px" BorderWidth="0">
                        <asp:TableHeaderCell ColumnSpan="4" HorizontalAlign="right">
                    
                    <img id="imgPrint" src="../Images/printer.gif" style="cursor:pointer;" onclick="javascript:PrintBill();" />
                        </asp:TableHeaderCell></asp:TableRow>
                    <asp:TableRow ID="trBillType" Height="15px" BorderWidth="0">
                        <asp:TableHeaderCell ColumnSpan="4" HorizontalAlign="center">
                            <asp:Label ID="lblBillType" runat="server" Font-Bold="true" Font-Names="Lucida Console"></asp:Label>
                        </asp:TableHeaderCell></asp:TableRow>
                    <asp:TableRow Height="15px" BorderWidth="0">
                        <asp:TableHeaderCell HorizontalAlign="Left">
                            <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" Font-Size="Small"
                                BorderWidth="0" runat="server" ID="dispTab" Width="100%">
                                <asp:TableRow Height="15px" BorderWidth="0">
                                    <asp:TableHeaderCell HorizontalAlign="Left">
                                        <asp:Literal ID="ColBillNo" runat="server" Text="No:"></asp:Literal>
                                        &nbsp;
                                        <asp:Literal ID="BillNo" runat="server"></asp:Literal>
                                    </asp:TableHeaderCell>
                                    <asp:TableHeaderCell HorizontalAlign="center">
                                        <asp:Literal ID="ColVisitNo" runat="server" Text="Visit No:"></asp:Literal>
                                        &nbsp;
                                        <asp:Literal ID="VisitNo" runat="server"></asp:Literal>
                                    </asp:TableHeaderCell>
                                    <asp:TableHeaderCell HorizontalAlign="right">
                                        <asp:Literal ID="ColDate" runat="server" Text="Date:"></asp:Literal>
                                        &nbsp;
                                        <asp:Literal ID="BillDate" runat="server"></asp:Literal>
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableHeaderCell>
                    </asp:TableRow>
                    <asp:TableRow Height="15px" BorderWidth="0">
                        <asp:TableHeaderCell HorizontalAlign="Left">
                            <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" Font-Size="Small"
                                BorderWidth="0" runat="server" ID="dispTab1" Width="100%">
                                <asp:TableRow Height="15px" BorderWidth="0">
                                    <asp:TableHeaderCell HorizontalAlign="Left">
                                        <asp:Literal ID="ColPatientName" runat="server" Text="Name:"></asp:Literal>
                                        &nbsp;<asp:Literal ID="PatientName" runat="server"></asp:Literal>
                                    </asp:TableHeaderCell>
                                    <asp:TableHeaderCell HorizontalAlign="center">
                                        <asp:Literal ID="Literal1" runat="server" Text="Age:"></asp:Literal>
                                        &nbsp;<asp:Literal ID="ltAge" runat="server"></asp:Literal>
                                    </asp:TableHeaderCell>
                                    <asp:TableHeaderCell HorizontalAlign="right">
                                        <asp:Literal ID="Literal2" runat="server" Text="Sex:"></asp:Literal>
                                        &nbsp;<asp:Literal ID="ltSex" runat="server"></asp:Literal>
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableHeaderCell>
                    </asp:TableRow>
                    <asp:TableRow Height="15px" BorderWidth="0">
                        <asp:TableHeaderCell HorizontalAlign="left">
                            <asp:Literal ID="ColDrName" runat="server" Text="Dr. Name:"></asp:Literal>
                            &nbsp;
                            <asp:Literal ID="DrName" runat="server"></asp:Literal>
                        </asp:TableHeaderCell>
                    </asp:TableRow>
                    <asp:TableRow Height="15px" BorderWidth="0">
                        <asp:TableHeaderCell HorizontalAlign="left">
                            <asp:Literal ID="Literal3" runat="server" Text="Hospital/Branch:"></asp:Literal>
                            &nbsp;
                            <asp:Literal ID="HospitalName" runat="server"></asp:Literal>
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
                </asp:Table>
                <asp:Table CellPadding="4" CssClass="colorforcontentborder" Font-Size="Small" CellSpacing="0"
                    BorderWidth="0" runat="server" ID="billItemsTab" Width="70%">
                    <asp:TableRow CssClass="colorforcontentborder" ForeColor="#f6f6f6" Height="15px" BorderWidth="0">
                        <asp:TableHeaderCell Width="40%" HorizontalAlign="Left">
                            <asp:Literal ID="ColItem" runat="server"><u>Item</u></asp:Literal>
                        </asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="10%" HorizontalAlign="right">
                            <asp:Literal ID="ColQuantity" runat="server"><u>Quantity</u></asp:Literal>
                        </asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="10%" HorizontalAlign="right">
                            <asp:Literal ID="ColRate" runat="server"><u>Rate</u></asp:Literal>
                        </asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="10%" HorizontalAlign="right">
                            <asp:Literal ID="ColAmount" runat="server"><u>Amount</u></asp:Literal>
                        </asp:TableHeaderCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:Table CellPadding="4" CssClass="colorforcontentborder" Font-Size="Small" CellSpacing="0"
                    BorderWidth="0" runat="server" ID="Table1" Width="70%">
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="4" Width="70%" HorizontalAlign="right">
                                                                    -------------------------------------------------
                        </asp:TableCell></asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="3" Width="60%" HorizontalAlign="right">
                            <asp:Literal ID="ColGrossAmount" runat="server" Text="Gross Amount"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell Width="10%" HorizontalAlign="right">
                            <asp:Literal ID="GrossAmount" runat="server"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="3" HorizontalAlign="right">
                            <asp:Literal ID="ColDiscount" runat="server" Text="Discount"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="right">
                            <asp:Literal ID="Discount" runat="server"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="3" HorizontalAlign="right">
                            <asp:Literal ID="ColTaxPercent" runat="server" Text="Tax %"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="right">
                            <asp:Literal ID="TaxPercent" runat="server"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="3" HorizontalAlign="right">
                            <asp:Literal ID="ColPreviousDue" Visible="false" runat="server" Text="Previous Due"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="right">
                            <asp:Literal ID="PreviousDue" Visible="false" runat="server"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="4" Width="70%" HorizontalAlign="right">
                                                                    -------------------------------------------------
                        </asp:TableCell></asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="3" HorizontalAlign="right">
                            <asp:Literal ID="ColNetAmount" runat="server" Text="Net Amount"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="right">
                            <asp:Literal ID="NetAmount" runat="server"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="3" HorizontalAlign="right">
                            <asp:Literal ID="ColAmountReceived" runat="server" Text="Amount Received"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="right">
                            <asp:Literal ID="AmountReceived" runat="server"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="3" HorizontalAlign="right">
                            <asp:Literal ID="ColAmountDue" runat="server" Text="Amount Due"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="right">
                            <asp:Literal ID="AmountDue" runat="server"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="referenceIndicator" runat="server" Style="display: none;">
                        <asp:TableCell Style="font-weight: bold; font-size: 12px;" ColumnSpan="4" Width="70%"
                            HorizontalAlign="left">
                            <asp:Table CellPadding="2" CellSpacing="0" BorderWidth="0" runat="server" ID="Table2"
                                Width="100%">
                                <asp:TableRow>
                                    <asp:TableCell Width="100%" HorizontalAlign="center">
                                        <asp:Literal ID="litReferenceIndicator" runat="server"></asp:Literal>
                                    </asp:TableCell></asp:TableRow>
                            </asp:Table>
                        </asp:TableCell></asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="4" Width="70%" HorizontalAlign="right">
                                                                   &nbsp;
                        </asp:TableCell></asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="4" HorizontalAlign="Right">
                            <asp:Literal runat="server" ID="ltSignature"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </td>
        </tr>
    </table>
    </form>

    <script language="javascript" type="text/javascript">
        function PrintBill() {
            window.print();
        }
    </script>

</body>
</html>
