<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintBill.aspx.cs" Inherits="Reception_PrintBill" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

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
<%@ Register Src="../CommonControls/FinalBillHeader.ascx" TagName="FinalBillHeader"
    TagPrefix="uc7" %>
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

	<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

	
    <script language="javascript" type="text/javascript">
        window.name = "BillWindow";
    </script>

</head>
<body id="oneColLayout" oncontextmenu="return false;">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table id="tblBillPrint" runat="server" border="0" cellpadding="2" cellspacing="1"
        width="600px">
        <tr id="trHtmlView" style="display: block;" align="center">
            <td width="700px">
                <table border="0" cellpadding="2" cellspacing="1" width="70%">
                    <tr>
                        <td colspan="2" align="center">
                            <asp:Image ID="imgBillLogo" runat="server" Visible="False" 
                                meta:resourcekey="imgBillLogoResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td id="lblHospitalName" runat="server" align="center">
                        </td>
                    </tr>
                </table>
                <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" Font-Size="Small"
                    BorderWidth="0px" runat="server" ID="billMasterTab" Width="70%" 
                    meta:resourcekey="billMasterTabResource1">
                    <asp:TableRow ID="trBillType" Height="15px" BorderWidth="0" 
                        meta:resourcekey="trBillTypeResource1">
                        <asp:TableHeaderCell ColumnSpan="4" HorizontalAlign="center" 
                            meta:resourcekey="TableHeaderCellResource1">
                            <asp:Label ID="lblBillType" runat="server" Font-Bold="true" 
                            Font-Names="Lucida Console" meta:resourcekey="lblBillTypeResource1"></asp:Label>
                        </asp:TableHeaderCell></asp:TableRow>
                    <asp:TableRow Height="15px" BorderWidth="0" 
                        meta:resourcekey="TableRowResource2">
                        <asp:TableHeaderCell HorizontalAlign="Left" 
                            meta:resourcekey="TableHeaderCellResource2">
                            <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" Font-Size="Small"
                                BorderWidth="0" runat="server" ID="dispTab" Width="100%" 
                            meta:resourcekey="dispTabResource1">
                                <asp:TableRow Height="15px" BorderWidth="0" 
                                    meta:resourcekey="TableRowResource1">
                                    <asp:TableHeaderCell HorizontalAlign="Left" 
                                        meta:resourcekey="TableHeaderCellResource3">
                                        <asp:Literal ID="ColBillNo" runat="server" Text="Bill No:" 
                                        meta:resourcekey="ColBillNoResource1"></asp:Literal>
                                        &nbsp;
                                        <asp:Literal ID="BillNo" runat="server" meta:resourcekey="BillNoResource2"></asp:Literal>
                                    </asp:TableHeaderCell>
                                    <asp:TableHeaderCell HorizontalAlign="center" 
                                        meta:resourcekey="TableHeaderCellResource4">
                                        <asp:Literal ID="ColVisitNo" runat="server" Text="Visit No:" 
                                        meta:resourcekey="ColVisitNoResource1"></asp:Literal>
                                        &nbsp;
                                        <asp:Literal ID="VisitNo" runat="server" 
                                        meta:resourcekey="VisitNoResource2"></asp:Literal>
                                    </asp:TableHeaderCell>
                                    <asp:TableHeaderCell HorizontalAlign="right" 
                                        meta:resourcekey="TableHeaderCellResource5">
                                        <asp:Literal ID="ColDate" runat="server" Text="Date:" 
                                        meta:resourcekey="ColDateResource1"></asp:Literal>
                                        &nbsp;
                                        <asp:Literal ID="BillDate" runat="server" 
                                        meta:resourcekey="BillDateResource1"></asp:Literal>
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableHeaderCell>
                    </asp:TableRow>
                    <asp:TableRow Height="15px" BorderWidth="0" 
                        meta:resourcekey="TableRowResource4">
                        <asp:TableHeaderCell HorizontalAlign="Left" 
                            meta:resourcekey="TableHeaderCellResource6">
                            <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" Font-Size="Small"
                                BorderWidth="0" runat="server" ID="dispTab1" Width="100%" 
                            meta:resourcekey="dispTab1Resource1">
                                <asp:TableRow Height="15px" BorderWidth="0" 
                                    meta:resourcekey="TableRowResource3">
                                    <asp:TableHeaderCell HorizontalAlign="Left" 
                                        meta:resourcekey="TableHeaderCellResource7">
                                        <asp:Literal ID="ColPatientName" runat="server" Text="Name:" 
                                        meta:resourcekey="ColPatientNameResource1"></asp:Literal>
                                        &nbsp;<asp:Literal ID="PatientName" runat="server" 
                                        meta:resourcekey="PatientNameResource2"></asp:Literal>
                                    </asp:TableHeaderCell>
                                    <asp:TableHeaderCell HorizontalAlign="center" 
                                        meta:resourcekey="TableHeaderCellResource8">
                                        <asp:Literal ID="Literal1" runat="server" Text="Age" 
                                        meta:resourcekey="Literal1Resource1"></asp:Literal>
                                        &nbsp;<asp:Literal ID="ltAge" runat="server" 
                                        meta:resourcekey="ltAgeResource1"></asp:Literal>
                                    </asp:TableHeaderCell>
                                    <asp:TableHeaderCell HorizontalAlign="right" 
                                        meta:resourcekey="TableHeaderCellResource9">
                                        <asp:Literal ID="Literal2" runat="server" Text="Sex:" 
                                        meta:resourcekey="Literal2Resource1"></asp:Literal>
                                        &nbsp;<asp:Literal ID="ltSex" runat="server" 
                                        meta:resourcekey="ltSexResource1"></asp:Literal>
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableHeaderCell>
                    </asp:TableRow>
                     <asp:TableRow Height="15px" BorderWidth="0" 
                        meta:resourcekey="TableRowResource8">
                        <asp:TableHeaderCell HorizontalAlign="left" 
                             meta:resourcekey="TableHeaderCellResource10">
                            <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" Font-Size="Small"
                                BorderWidth="0" runat="server" ID="Table3" Width="100%" 
                             meta:resourcekey="Table3Resource1">
                                <asp:TableRow Height="15px" BorderWidth="0" 
                                    meta:resourcekey="TableRowResource7">
                                    <asp:TableHeaderCell HorizontalAlign="left" 
                                        meta:resourcekey="TableHeaderCellResource11">
                                        <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="2" Font-Size="Small"
                                            BorderWidth="0" runat="server" ID="Table4" Width="100%" 
                                        meta:resourcekey="Table4Resource1">
                                            <asp:TableRow Height="15px" BorderWidth="0" 
                                                meta:resourcekey="TableRowResource5">
                                                <asp:TableHeaderCell HorizontalAlign="left" 
                                                    meta:resourcekey="TableHeaderCellResource12">
                                                    <asp:Literal ID="ColDrName" runat="server" Text="Dr. Name:" 
                                                    meta:resourcekey="ColDrNameResource1"></asp:Literal>
                                                    &nbsp;
                                                    <asp:Literal ID="DrName" runat="server" meta:resourcekey="DrNameResource2"></asp:Literal>
                                                </asp:TableHeaderCell>
                                            </asp:TableRow>
                                            <asp:TableRow Height="15px" BorderWidth="0" 
                                                meta:resourcekey="TableRowResource6">
                                                <asp:TableHeaderCell HorizontalAlign="left" 
                                                    meta:resourcekey="TableHeaderCellResource13">
                                                    <asp:Literal ID="Literal3" runat="server" Text="Referring clinic/hospital:" 
                                                    meta:resourcekey="Literal3Resource1"></asp:Literal>
                                                    &nbsp;
                                                    <asp:Literal ID="HospitalName" runat="server" 
                                                    meta:resourcekey="HospitalNameResource1"></asp:Literal>
                                                </asp:TableHeaderCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableHeaderCell>
                                    <asp:TableHeaderCell ID="tbrBarCode" runat="server" HorizontalAlign="Right" 
                                        Visible="false" meta:resourcekey="tbrBarCodeResource1">
                                        <asp:Image ID="imbbarcode" runat="server" 
                                        meta:resourcekey="imbbarcodeResource1" />
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableHeaderCell>
                    </asp:TableRow>
                    <asp:TableRow ID="TableRow1" runat="server" BorderWidth="0" 
                        meta:resourcekey="TableRow1Resource1">
                        <asp:TableHeaderCell ColumnSpan="2" HorizontalAlign="left" 
                            meta:resourcekey="TableHeaderCellResource14">
                            <asp:Table CellPadding="0" CellSpacing="0" BorderWidth="0" runat="server" ID="trCC"
                                Style="display: none;" Width="100%" meta:resourcekey="trCCResource1">
                                <asp:TableRow Height="15px" BorderWidth="0" 
                                    meta:resourcekey="TableRowResource9">
                                    <asp:TableHeaderCell ColumnSpan="2" HorizontalAlign="left" 
                                        meta:resourcekey="TableHeaderCellResource15">
                                        <asp:Literal ID="Literal4" runat="server" Text="Collection Centre:" 
                                        meta:resourcekey="Literal4Resource1"></asp:Literal>
                                        &nbsp;
                                        <asp:Literal ID="CollectionCentre" runat="server" 
                                        meta:resourcekey="CollectionCentreResource1"></asp:Literal>
                                    </asp:TableHeaderCell></asp:TableRow>
                            </asp:Table>
                        </asp:TableHeaderCell>
                    </asp:TableRow>
                    <asp:TableRow Height="15px" BorderWidth="0" 
                        meta:resourcekey="TableRowResource10">
                        <asp:TableHeaderCell HorizontalAlign="left" 
                            meta:resourcekey="TableHeaderCellResource16">
                            <uc7:FinalBillHeader ID="FinalBillHeader1" runat="server" />
                        </asp:TableHeaderCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:Table CellPadding="4" CssClass="colorforcontentborder" Font-Size="Small" CellSpacing="0"
                    BorderWidth="0px" runat="server" ID="billItemsTab" Width="70%" 
                    meta:resourcekey="billItemsTabResource1">
                    <asp:TableRow CssClass="colorbillprt" Height="15px" BorderWidth="0" 
                        meta:resourcekey="TableRowResource11">
                        <asp:TableHeaderCell Width="40%" HorizontalAlign="Left" 
                            meta:resourcekey="TableHeaderCellResource17">
                            <asp:Label ID="ColItem" runat="server"  Font-Underline="true" Text="Item" 
                            meta:resourcekey="ColItemResource1" ></asp:Label>
                        </asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="10%" HorizontalAlign="right" 
                            meta:resourcekey="TableHeaderCellResource18">
                            <asp:Label ID="ColQuantity" runat="server" Font-Underline="true"  
                            Text="Quantity" meta:resourcekey="ColQuantityResource1" ></asp:Label>
                        </asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="10%" HorizontalAlign="right" 
                            meta:resourcekey="TableHeaderCellResource19">
                            <asp:Label ID="ColRate" Text="Rate"  Font-Underline="true"  runat="server" 
                            meta:resourcekey="ColRateResource1"></asp:Label>
                        </asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="10%" HorizontalAlign="right" 
                            meta:resourcekey="TableHeaderCellResource20">
                            <asp:Label ID="ColAmount" Text="Amount" Font-Underline="true" 
                            runat="server" meta:resourcekey="ColAmountResource1"></asp:Label>
                        </asp:TableHeaderCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:Table CellPadding="4" CssClass="colorforcontentborder" Font-Size="Small" CellSpacing="0"
                    BorderWidth="0px" runat="server" ID="Table1" Width="70%" 
                    meta:resourcekey="Table1Resource1">
                    <asp:TableRow meta:resourcekey="TableRowResource12">
                        <asp:TableCell ColumnSpan="4" Width="70%" HorizontalAlign="right" 
                            meta:resourcekey="TableCellResource1">
                                                                    -------------------------------------------------
                        </asp:TableCell></asp:TableRow>
                    <asp:TableRow meta:resourcekey="TableRowResource13">
                        <asp:TableCell ColumnSpan="3" Width="60%" HorizontalAlign="right" 
                            meta:resourcekey="TableCellResource2">
                            <asp:Literal ID="ColGrossAmount" runat="server" Text="Gross Amount" 
                            meta:resourcekey="ColGrossAmountResource1"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell Width="10%" HorizontalAlign="right" 
                            meta:resourcekey="TableCellResource3">
                            <asp:Literal ID="GrossAmount" runat="server" 
                            meta:resourcekey="GrossAmountResource2"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow meta:resourcekey="TableRowResource14">
                        <asp:TableCell ColumnSpan="3" HorizontalAlign="right" 
                            meta:resourcekey="TableCellResource4">
                            <asp:Literal ID="ColDiscount" runat="server" Text="Discount" 
                            meta:resourcekey="ColDiscountResource1"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="right" meta:resourcekey="TableCellResource5">
                            <asp:Literal ID="Discount" runat="server" 
                            meta:resourcekey="DiscountResource2"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow meta:resourcekey="TableRowResource15">
                        <asp:TableCell ColumnSpan="3" HorizontalAlign="right" 
                            meta:resourcekey="TableCellResource6">
                            <asp:Literal ID="ColTaxPercent" runat="server" Text="Tax %" 
                            meta:resourcekey="ColTaxPercentResource1"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="right" meta:resourcekey="TableCellResource7">
                            <asp:Literal ID="TaxPercent" runat="server" 
                            meta:resourcekey="TaxPercentResource2"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow meta:resourcekey="TableRowResource16">
                        <asp:TableCell ColumnSpan="3" HorizontalAlign="right" 
                            meta:resourcekey="TableCellResource8">
                            <asp:Literal ID="ColPreviousDue" Visible="false" runat="server" 
                            Text="Previous Due" meta:resourcekey="ColPreviousDueResource1"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="right" meta:resourcekey="TableCellResource9">
                            <asp:Literal ID="PreviousDue" Visible="false" runat="server" 
                            meta:resourcekey="PreviousDueResource2"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow meta:resourcekey="TableRowResource17">
                        <asp:TableCell ColumnSpan="4" Width="70%" HorizontalAlign="right" 
                            meta:resourcekey="TableCellResource10">
                                                                    -------------------------------------------------
                        </asp:TableCell></asp:TableRow>
                    <asp:TableRow meta:resourcekey="TableRowResource18">
                        <asp:TableCell ColumnSpan="3" HorizontalAlign="right" 
                            meta:resourcekey="TableCellResource11">
                            <asp:Literal ID="ColNetAmount" runat="server" Text="Net Amount" 
                            meta:resourcekey="ColNetAmountResource1"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="right" meta:resourcekey="TableCellResource12">
                            <asp:Literal ID="NetAmount" runat="server" 
                            meta:resourcekey="NetAmountResource2"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow meta:resourcekey="TableRowResource19">
                        <asp:TableCell ColumnSpan="3" HorizontalAlign="right" 
                            meta:resourcekey="TableCellResource13">
                            <asp:Literal ID="ColAmountReceived" runat="server" Text="Amount Received" 
                            meta:resourcekey="ColAmountReceivedResource1"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="right" meta:resourcekey="TableCellResource14">
                            <asp:Literal ID="AmountReceived" runat="server" 
                            meta:resourcekey="AmountReceivedResource2"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow meta:resourcekey="TableRowResource20">
                        <asp:TableCell ColumnSpan="3" HorizontalAlign="right" 
                            meta:resourcekey="TableCellResource15">
                            <asp:Literal ID="ColAmountDue" runat="server" Text="Amount Due" 
                            meta:resourcekey="ColAmountDueResource1"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="right" meta:resourcekey="TableCellResource16">
                            <asp:Literal ID="AmountDue" runat="server" 
                            meta:resourcekey="AmountDueResource2"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="referenceIndicator" runat="server" Style="display: none;" 
                        meta:resourcekey="referenceIndicatorResource1">
                        <asp:TableCell Style="font-weight: bold; font-size: 12px;" ColumnSpan="4" Width="70%"
                            HorizontalAlign="left" meta:resourcekey="TableCellResource17">
                            <asp:Table CellPadding="2" CellSpacing="0" BorderWidth="0" runat="server" ID="Table2"
                                Width="100%" meta:resourcekey="Table2Resource1">
                                <asp:TableRow meta:resourcekey="TableRowResource21">
                                    <asp:TableCell Width="100%" HorizontalAlign="center" 
                                        meta:resourcekey="TableCellResource18">
                                        <asp:Literal ID="litReferenceIndicator" runat="server" 
                                        meta:resourcekey="litReferenceIndicatorResource1"></asp:Literal>
                                    </asp:TableCell></asp:TableRow>
                            </asp:Table>
                        </asp:TableCell></asp:TableRow>
                    <asp:TableRow meta:resourcekey="TableRowResource22">
                        <asp:TableCell ColumnSpan="4" HorizontalAlign="Left" 
                            meta:resourcekey="TableCellResource19">
                            <asp:Label ID="lblTaxDetails" Visible="False" runat="server" 
                            Style="font-weight: 700" meta:resourcekey="lblTaxDetailsResource1"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow meta:resourcekey="TableRowResource23">
                        <asp:TableCell ColumnSpan="4" Width="70%" HorizontalAlign="right" 
                            meta:resourcekey="TableCellResource20">
                                                                   &nbsp;
                        </asp:TableCell></asp:TableRow>
                    <asp:TableRow meta:resourcekey="TableRowResource24">
                        <asp:TableCell ColumnSpan="4" HorizontalAlign="Right" 
                            meta:resourcekey="TableCellResource21">
                            <asp:Literal runat="server" ID="ltSignature" 
                            meta:resourcekey="ltSignatureResource1"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        window.print();
       
    </script>

</body>
</html>
