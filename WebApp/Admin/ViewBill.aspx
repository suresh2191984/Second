<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewBill.aspx.cs" Inherits="Admin_ViewBill" %>

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
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Print Bill</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

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
<body oncontextmenu="return false;" runat="server">
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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
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
                                    <asp:Label ID="lblPriority" Font-Bold="true" Font-Size="12px" ForeColor="#403f3e"
                                        runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-size: 11px;">
                                    <asp:Panel ID="Panel1" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    Patient No:
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="lblPatientNo" runat="server"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 13%;" align="left">
                                                    Patient Name:
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000;" align="left">
                                                    <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    Gender:
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                    <asp:Label ID="lblGender" runat="server"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    Age:
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="lblAge" runat="server"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                    Visit No:
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="lblVisitNo" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td width="600px" style="display: none;">
                                    <asp:Label ID="TextView" runat="server" Font-Bold="true" OnClick="PrintView(this.id);"
                                        Font-Names="Lucida Console">Text</asp:Label>
                                    <asp:Label ID="HtmlView" runat="server" Font-Bold="true" Style="display: none;" OnClick="PrintView(this.id);"
                                        Font-Names="Lucida Console">HTML</asp:Label>
                                </td>
                            </tr>
                            <tr id="trTextView" style="display: none;">
                                <td width="600px">
                                    <asp:TextBox ID="PrintArea" runat="server" TextMode="MultiLine" Height="300px" Width="40%">
                                    
                                    
                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr id="trHtmlView" style="display: block;">
                                <td width="600px" style="font-size: 11px;">
                                    <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="0"
                                        runat="server" ID="billMasterTab" Width="70%">
                                        <asp:TableRow ID="trBillType" Height="15px" BorderWidth="0">
                                            <asp:TableHeaderCell ColumnSpan="4" HorizontalAlign="center">
                                                <asp:Label ID="lblBillType" runat="server" Font-Bold="true" Font-Names="Lucida Console"></asp:Label>
                                            </asp:TableHeaderCell></asp:TableRow>
                                        <asp:TableRow Height="15px" BorderWidth="0">
                                            <asp:TableHeaderCell HorizontalAlign="Left">
                                                <asp:Literal ID="ColBillNo" runat="server" Text="Bill No:"></asp:Literal>
                                                &nbsp;
                                                <asp:Literal ID="BillNo" runat="server"></asp:Literal>
                                            </asp:TableHeaderCell>
                                            <asp:TableHeaderCell HorizontalAlign="right">
                                                <asp:Literal ID="ColDate" runat="server" Text="Date:"></asp:Literal>
                                                &nbsp;
                                                <asp:Literal ID="BillDate" runat="server"></asp:Literal>
                                            </asp:TableHeaderCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="15px" BorderWidth="0">
                                            <asp:TableHeaderCell HorizontalAlign="Left">
                                                <asp:Literal ID="ColPatientName" runat="server" Text="Name:"></asp:Literal>
                                                &nbsp;<asp:Literal ID="PatientName" runat="server"></asp:Literal>
                                            </asp:TableHeaderCell>
                                            <asp:TableHeaderCell HorizontalAlign="right">
                                                <asp:Literal ID="ColDrName" runat="server" Text="Dr. Name:"></asp:Literal>
                                                &nbsp;
                                                <asp:Literal ID="DrName" runat="server"></asp:Literal>
                                            </asp:TableHeaderCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="15px" BorderWidth="0">
                                            <asp:TableHeaderCell ColumnSpan="2" HorizontalAlign="left">
                                                <asp:Literal ID="Literal1" runat="server" Text="Hospital/Branch:"></asp:Literal>
                                                &nbsp;
                                                <asp:Literal ID="HospitalName" runat="server"></asp:Literal>
                                            </asp:TableHeaderCell>
                                        </asp:TableRow>
                                        <asp:TableRow runat="server" BorderWidth="0">
                                            <asp:TableHeaderCell ColumnSpan="2" HorizontalAlign="left">
                                                <asp:Table CellPadding="0" CellSpacing="0" BorderWidth="0" runat="server" ID="trCC"
                                                    Style="display: none;" Width="100%">
                                                    <asp:TableRow Height="15px" BorderWidth="0">
                                                        <asp:TableHeaderCell ColumnSpan="2" HorizontalAlign="left">
                                                            <asp:Literal ID="Literal2" runat="server" Text="Collection Centre:"></asp:Literal>
                                                            &nbsp;
                                                            <asp:Literal ID="CollectionCentre" runat="server"></asp:Literal>
                                                        </asp:TableHeaderCell></asp:TableRow>
                                                </asp:Table>
                                            </asp:TableHeaderCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                    <asp:Table CellPadding="4" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="0"
                                        runat="server" ID="billItemsTab" Width="70%">
                                        <asp:TableRow CssClass="colorbillprt" Height="15px" BorderWidth="0">
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
                                    <asp:Table CellPadding="4" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="0"
                                        runat="server" ID="Table1" Width="70%">
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
                </asp:Table>
            </td>
        </tr>
        <tr id="referenceIndicator" runat="server" style=" display:none;">
        <td align="left" style=" font-weight:bold; font-size:11px;">
        <asp:Table CellPadding="2" CellSpacing="0" BorderWidth="0"
                    runat="server" ID="Table2" Width="55%">
                    <asp:TableRow>
                        <asp:TableCell Width="70%" HorizontalAlign="center">
        <asp:Literal ID="litReferenceIndicator" runat="server" ></asp:Literal>
        </asp:TableCell></asp:TableRow></asp:Table>
        </td>
        </tr>
        <tr id="commentsBlock" runat="server" style=" display:none;">
        <td align="left" valign="middle" style="padding-bottom:10px; padding-top:10px;">
        <asp:Label ID="lblComments" runat="server" Font-Bold="true" Font-Size="12px" >Reason For Cancellation</asp:Label>
        <textarea id="txtComments" runat="server" rows="2" cols="29"></textarea>
        </td>
        </tr>
        <tr>
            <td>
            
            
            <asp:Button ID="btnCancel" runat="server" Text="Home" ToolTip="Click Here To View Home Page" style="cursor:pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                    onmouseout="this.className='btn'" OnClick="btnCancel_Click" />
                    &nbsp;&nbsp;
                   
             <asp:HyperLink ID="hypLnkPrint" Font-Bold="true" Visible="false" Font-Size="12px"  ForeColor="#000000" Target="BillWindow" runat="server" ToolTip="Click Here To Print the Bill" ><img id="imgPrint" runat="server" style=" border-width:0px;" src="~/Images/printer.gif" />&nbsp;<u>Print Current Bill</u></asp:HyperLink> 
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:HyperLink ID="hypLnkParentPrint" Font-Bold="true" Visible="false" Font-Size="12px"
                                            ForeColor="#000000" Target="BillWindow" runat="server" ToolTip="Click Here To Print the Parent Bill">
                                            <img id="imgParentPrint" runat="server" style="border-width: 0px;" src="~/Images/printer.gif" />&nbsp;<u>Print
                                                Parent Bill</u></asp:HyperLink>
               <asp:Button ID="btnBillCancel" runat="server" Visible="false" Text="Cancel Bill" CssClass="btn" onmouseover="this.className='btn btnhov'"
onmouseout="this.className='btn'" OnClientClick="javascript:return confirm('Are you sure you wish to cancel the bill?');" OnClick="btnBillCancel_Click" />
               </td>
        </tr>
    </table>
  </div>
   </div>
            </div>
        </div>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
