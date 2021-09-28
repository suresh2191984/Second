<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewBill.aspx.cs" Inherits="Reception_ViewBill"
    meta:resourcekey="PageResource1" %>

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
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/FinalBillHeader.ascx" TagName="FinalBillHeader"
    TagPrefix="uc7" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Print Bill</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        var id;

        function PrintView(id) {

            if (id == 'TextView') {
                document.getElementById('trHtmlView').style.display = 'none';
                document.getElementById('trTextView').style.display = 'block';
                document.getElementById('HtmlView').style.display = 'block';
                document.getElementById('TextView').style.display = 'none';
            }
            if (id == 'HtmlView') {
                document.getElementById('trTextView').style.display = 'none';
                document.getElementById('trHtmlView').style.display = 'block';
                document.getElementById('HtmlView').style.display = 'none';
                document.getElementById('TextView').style.display = 'block';
            }
        }
        function printPage() {
            document.getElementById('PrintArea').select();
        }
       

     
    </script>

</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" cellpadding="2" cellspacing="1" width="100%">
                            <tr id="trPriority" runat="server" style="display: none;">
                                <td align="center">
                                    <asp:Label ID="lblPriority" Font-Bold="True" Font-Size="12px" ForeColor="#403F3E"
                                        runat="server" meta:resourcekey="lblPriorityResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-size: 11px;">
                                    <asp:Panel ID="Panel1" CssClass="dataheader2" BorderWidth="1px" runat="server" meta:resourcekey="Panel1Resource1">
                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 12%;" align="left">
                                                    <%--Patient No:--%>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="lblPatientNo" runat="server" meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 13%;" align="left">
                                                    <%-- Patient Name:--%>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000;" align="left">
                                                    <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <%-- Gender:--%>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                    <asp:Label ID="lblGender" runat="server" meta:resourcekey="lblGenderResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <%--Age:--%>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                    <%-- Visit No:--%>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="lblVisitNo" runat="server" meta:resourcekey="lblVisitNoResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td width="600px" style="display: none;">
                                    <asp:Label ID="TextView" runat="server" Font-Bold="True" OnClick="PrintView(this.id);"
                                        Font-Names="Lucida Console" meta:resourcekey="TextViewResource1"><%--Text--%> <%=Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_06%></asp:Label>
                                    <asp:Label ID="HtmlView" runat="server" Font-Bold="True" Style="display: none;" OnClick="PrintView(this.id);"
                                        Font-Names="Lucida Console" meta:resourcekey="HtmlViewResource1"><%--HTML--%> <%=Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_07%></asp:Label>
                                </td>
                            </tr>
                            <tr id="trTextView" style="display: none;">
                                <td width="600px">
                                    <asp:TextBox ID="PrintArea" runat="server" TextMode="MultiLine" Height="300px" Width="40%"
                                        meta:resourcekey="PrintAreaResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr id="trHtmlView" style="display: block;">
                                <td width="600px" style="font-size: 11px;">
                                    <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="0px"
                                        runat="server" ID="billMasterTab" Width="70%" meta:resourcekey="billMasterTabResource1">
                                        <asp:TableRow ID="trBillType" Height="15px" BorderWidth="0" meta:resourcekey="trBillTypeResource1">
                                            <asp:TableHeaderCell ColumnSpan="4" HorizontalAlign="center" meta:resourcekey="TableHeaderCellResource1">
                                                <asp:Label ID="lblBillType" runat="server" Font-Bold="true" Font-Names="Lucida Console"
                                                    meta:resourcekey="lblBillTypeResource1"></asp:Label>
                                            </asp:TableHeaderCell></asp:TableRow>
                                        <asp:TableRow Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource1">
                                            <asp:TableHeaderCell HorizontalAlign="Left" meta:resourcekey="TableHeaderCellResource2">
                                                <asp:Literal ID="ColBillNo" runat="server" Text="Bill No:" meta:resourcekey="ColBillNoResource1"></asp:Literal>
                                                &nbsp;
                                                <asp:Literal ID="BillNo" runat="server" meta:resourcekey="BillNoResource2"></asp:Literal>
                                            </asp:TableHeaderCell>
                                            <asp:TableHeaderCell HorizontalAlign="right" meta:resourcekey="TableHeaderCellResource3">
                                                <asp:Literal ID="ColDate" runat="server" Text="Date:" meta:resourcekey="ColDateResource1"></asp:Literal>
                                                &nbsp;
                                                <asp:Literal ID="BillDate" runat="server" meta:resourcekey="BillDateResource1"></asp:Literal>
                                            </asp:TableHeaderCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource2">
                                            <asp:TableHeaderCell HorizontalAlign="Left" meta:resourcekey="TableHeaderCellResource4">
                                                <asp:Literal ID="ColPatientName" runat="server" Text="Name:" meta:resourcekey="ColPatientNameResource1"></asp:Literal>
                                                &nbsp;<asp:Literal ID="PatientName" runat="server" meta:resourcekey="PatientNameResource2"></asp:Literal>
                                            </asp:TableHeaderCell>
                                            <asp:TableHeaderCell HorizontalAlign="right" meta:resourcekey="TableHeaderCellResource5">
                                                <asp:Literal ID="ColDrName" runat="server" Text="Dr. Name:" meta:resourcekey="ColDrNameResource1"></asp:Literal>
                                                &nbsp;
                                                <asp:Literal ID="DrName" runat="server" meta:resourcekey="DrNameResource2"></asp:Literal>
                                            </asp:TableHeaderCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource3">
                                            <asp:TableHeaderCell ColumnSpan="2" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource6">
                                                <asp:Literal ID="Literal1" runat="server" Text="Referring clinic/hospital:" meta:resourcekey="Literal1Resource1"></asp:Literal>
                                                &nbsp;
                                                <asp:Literal ID="HospitalName" runat="server" meta:resourcekey="HospitalNameResource1"></asp:Literal>
                                            </asp:TableHeaderCell>
                                        </asp:TableRow>
                                        <asp:TableRow ID="TableRow1" runat="server" BorderWidth="0" meta:resourcekey="TableRowResource5">
                                            <asp:TableHeaderCell ColumnSpan="2" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource7">
                                                <asp:Table CellPadding="0" CellSpacing="0" BorderWidth="0" runat="server" ID="trCC"
                                                    Style="display: none;" Width="100%" meta:resourcekey="trCCResource1">
                                                    <asp:TableRow Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource4">
                                                        <asp:TableHeaderCell ColumnSpan="2" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource8">
                                                            <asp:Literal ID="Literal2" runat="server" Text="Collection Centre:" meta:resourcekey="Literal2Resource1"></asp:Literal>
                                                            &#160;
                                                            <asp:Literal ID="CollectionCentre" runat="server" meta:resourcekey="CollectionCentreResource1"></asp:Literal>
                                                        </asp:TableHeaderCell>
                                                    </asp:TableRow>
                                                </asp:Table>
                                            </asp:TableHeaderCell>
                                        </asp:TableRow>
                                        <asp:TableRow ID="tbrBarCode" BorderWidth="0" HorizontalAlign="Right" Visible="false"
                                            runat="server" meta:resourcekey="tbrBarCodeResource1">
                                            <asp:TableHeaderCell HorizontalAlign="Right" meta:resourcekey="TableHeaderCellResource9">                                               
                                                 &nbsp;
                                            </asp:TableHeaderCell>
                                            <asp:TableHeaderCell HorizontalAlign="Right" meta:resourcekey="TableHeaderCellResource10">
                                                <asp:Image ID="imbbarcode" runat="server" meta:resourcekey="imbbarcodeResource1" />
                                            </asp:TableHeaderCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource6">
                                            <asp:TableHeaderCell HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource11">
                                                <uc7:FinalBillHeader ID="FinalBillHeader1" runat="server" />
                                            </asp:TableHeaderCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                    <asp:Table CellPadding="4" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="0"
                                        runat="server" ID="billItemsTab" Width="70%">
                                        <asp:TableRow CssClass="colorbillprt" Height="15px" BorderWidth="0">
                                            <asp:TableHeaderCell Width="40%" HorizontalAlign="Left">
                                                <asp:Literal ID="ColItem" runat="server"><%--<u>Item</u>--%></asp:Literal>
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
                                    <asp:Table CellPadding="4" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="0px"
                                        runat="server" ID="Table1" Width="70%" meta:resourcekey="Table1Resource1">
                                        <asp:TableRow meta:resourcekey="TableRowResource7">
                                            <asp:TableCell ColumnSpan="4" Width="70%" HorizontalAlign="right" meta:resourcekey="TableCellResource1">
                                                                    -------------------------------------------------
                                            </asp:TableCell></asp:TableRow>
                                        <asp:TableRow meta:resourcekey="TableRowResource8">
                                            <asp:TableCell ColumnSpan="3" Width="60%" HorizontalAlign="right" meta:resourcekey="TableCellResource2">
                                                <asp:Literal ID="ColGrossAmount" runat="server" Text="Gross Amount" meta:resourcekey="ColGrossAmountResource1"></asp:Literal>
                                            </asp:TableCell>
                                            <asp:TableCell Width="10%" HorizontalAlign="right" meta:resourcekey="TableCellResource3">
                                                <asp:Literal ID="GrossAmount" runat="server" meta:resourcekey="GrossAmountResource2"></asp:Literal>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow meta:resourcekey="TableRowResource9">
                                            <asp:TableCell ColumnSpan="3" HorizontalAlign="right" meta:resourcekey="TableCellResource4">
                                                <asp:Literal ID="ColDiscount" runat="server" Text="Discount" meta:resourcekey="ColDiscountResource1"></asp:Literal>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right" meta:resourcekey="TableCellResource5">
                                                <asp:Literal ID="Discount" runat="server" meta:resourcekey="DiscountResource2"></asp:Literal>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow meta:resourcekey="TableRowResource10">
                                            <asp:TableCell ColumnSpan="3" HorizontalAlign="right" meta:resourcekey="TableCellResource6">
                                                <asp:Literal ID="ColTaxPercent" runat="server" Text="Tax %" meta:resourcekey="ColTaxPercentResource1"></asp:Literal>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right" meta:resourcekey="TableCellResource7">
                                                <asp:Literal ID="TaxPercent" runat="server" meta:resourcekey="TaxPercentResource2"></asp:Literal>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow meta:resourcekey="TableRowResource11">
                                            <asp:TableCell ColumnSpan="3" HorizontalAlign="right" meta:resourcekey="TableCellResource8">
                                                <asp:Literal ID="ColPreviousDue" Visible="false" runat="server" Text="Previous Due"
                                                    meta:resourcekey="ColPreviousDueResource1"></asp:Literal>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right" meta:resourcekey="TableCellResource9">
                                                <asp:Literal ID="PreviousDue" Visible="false" runat="server" meta:resourcekey="PreviousDueResource2"></asp:Literal>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow meta:resourcekey="TableRowResource12">
                                            <asp:TableCell ColumnSpan="4" Width="70%" HorizontalAlign="right" meta:resourcekey="TableCellResource10">
                                                                    -------------------------------------------------
                                            </asp:TableCell></asp:TableRow>
                                        <asp:TableRow meta:resourcekey="TableRowResource13">
                                            <asp:TableCell ColumnSpan="3" HorizontalAlign="right" meta:resourcekey="TableCellResource11">
                                                <asp:Literal ID="ColNetAmount" runat="server" Text="Net Amount" meta:resourcekey="ColNetAmountResource1"></asp:Literal>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right" meta:resourcekey="TableCellResource12">
                                                <asp:Literal ID="NetAmount" runat="server" meta:resourcekey="NetAmountResource2"></asp:Literal>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow meta:resourcekey="TableRowResource14">
                                            <asp:TableCell ColumnSpan="3" HorizontalAlign="right" meta:resourcekey="TableCellResource13">
                                                <asp:Literal ID="ColAmountReceived" runat="server" Text="Amount Received" meta:resourcekey="ColAmountReceivedResource1"></asp:Literal>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right" meta:resourcekey="TableCellResource14">
                                                <asp:Literal ID="AmountReceived" runat="server" meta:resourcekey="AmountReceivedResource2"></asp:Literal>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow meta:resourcekey="TableRowResource15">
                                            <asp:TableCell ColumnSpan="3" HorizontalAlign="right" meta:resourcekey="TableCellResource15">
                                                <asp:Literal ID="ColAmountDue" runat="server" Text="Amount Due" meta:resourcekey="ColAmountDueResource1"></asp:Literal>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="right" meta:resourcekey="TableCellResource16">
                                                <asp:Literal ID="AmountDue" runat="server" meta:resourcekey="AmountDueResource2"></asp:Literal>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </td>
                            </tr>
                            <tr id="referenceIndicator" runat="server" style="display: none;">
                                <td align="left" style="font-weight: bold; font-size: 11px;">
                                    <asp:Table CellPadding="2" CellSpacing="0" BorderWidth="0px" runat="server" ID="Table2"
                                        Width="55%" meta:resourcekey="Table2Resource1">
                                        <asp:TableRow meta:resourcekey="TableRowResource16">
                                            <asp:TableCell Width="70%" HorizontalAlign="center" meta:resourcekey="TableCellResource17">
                                                <asp:Literal ID="litReferenceIndicator" runat="server" meta:resourcekey="litReferenceIndicatorResource1"></asp:Literal>
                                            </asp:TableCell></asp:TableRow>
                                    </asp:Table>
                                </td>
                            </tr>
                            <tr id="commentsBlock" runat="server" style="display: none;">
                                <td align="left" valign="middle" style="padding-bottom: 10px; padding-top: 10px;">
                                    <asp:Label ID="lblComments" runat="server" Font-Bold="True" Font-Size="12px" meta:resourcekey="lblCommentsResource1"><%--Reason For Cancellation--%><%=Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_12%></asp:Label>
                                    <textarea id="txtComments" runat="server" rows="2" cols="29"></textarea>
                                </td>
                            </tr>
                            <tr id="trTaxDetails" runat="server">
                                <td colspan="6" align="left">
                                    <asp:Label ID="lblTaxDetails" Visible="False" runat="server" Font-Size="11px" Font-Bold="True"
                                        meta:resourcekey="lblTaxDetailsResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnCancel" runat="server" Text="Home" ToolTip="Click Here To View Home Page"
                                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        Style="cursor: pointer;" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                    &nbsp;&nbsp;
                                    <asp:HyperLink ID="hypLnkPrint" Font-Bold="true" Visible="false" Font-Size="12px"
                                        ForeColor="#000000" Target="BillWindow" runat="server" ToolTip="Click Here To Print the Bill"
                                        meta:resourcekey="hypLnkPrintResource1">
                                        <img id="imgPrint" runat="server" style="border-width: 0px;" src="~/Images/printer.gif" />&nbsp;<u>Print
                                            &nbsp;<u><%--Print Current Bill--%><%=Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_13%></u></asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:HyperLink ID="hypLnkParentPrint" Font-Bold="true" Visible="false" Font-Size="12px"
                                        ForeColor="#000000" Target="BillWindow" runat="server" ToolTip="Click Here To Print the Parent Bill"
                                        meta:resourcekey="hypLnkParentPrintResource1">
                                        <img id="imgParentPrint" runat="server" style="border-width: 0px;" src="~/Images/printer.gif" />
                                        &nbsp;<u><%--Print Parent Bill--%><%=Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_14%></u></asp:HyperLink>
                                    <asp:Button ID="btnBillCancel" runat="server" Visible="false" Text="Cancel Bill"
                                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        OnClientClick="javascript:return confirm('Are you sure want to Cancel the Bill?');"
                                        OnClick="btnBillCancel_Click" meta:resourcekey="btnBillCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
