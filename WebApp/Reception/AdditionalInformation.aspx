<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdditionalInformation.aspx.cs"
    Inherits="Reception_AdditionalInformation" %>

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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Additional Information</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        function calculateTotal() {
            if (document.getElementById('txtQuantity').value == '') {
                document.getElementById('txtQuantity').value = parseFloat(0).toFixed(2);
            }
            else {
                document.getElementById('txtQuantity').value = parseFloat(document.getElementById('txtQuantity').value).toFixed(2);
            }
            if (document.getElementById('txtRate').value == '') {
                document.getElementById('txtRate').value = parseFloat(0).toFixed(2);
            }
            else {
                document.getElementById('txtRate').value = parseFloat(document.getElementById('txtRate').value).toFixed(2);
            }
            if (document.getElementById('txtAmount').value == '') {
                document.getElementById('txtAmount').value = parseFloat(0).toFixed(2);
            }
            else {
                document.getElementById('txtAmount').value = parseFloat(document.getElementById('txtAmount').value).toFixed(2);
            }

            if (document.getElementById('txtQuantity').value != '' && document.getElementById('txtRate').value != '') {
                document.getElementById('txtAmount').value = parseFloat(parseFloat(document.getElementById('txtQuantity').value) * parseFloat(document.getElementById('txtRate').value)).toFixed(2);
            }

        }
  
     
    </script>

</head>
<body oncontextmenu="return true;" runat="server">
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
                                                <asp:Literal ID="ColBillNo" runat="server" Text="No:"></asp:Literal>
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
                                                            &#160;
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
                                        <%-- <asp:TableRow>
                        <asp:TableCell ColumnSpan="3" HorizontalAlign="right">
                            <asp:Literal ID="ColAmountReceived" runat="server" Text="Amount Received"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="right">
                            <asp:Literal ID="AmountReceived" runat="server"></asp:Literal>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="3" Font-Bold="false" HorizontalAlign="right">
                            <asp:Literal ID="ColAmountDue" runat="server" Text="Amount Due"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell Font-Bold="false" HorizontalAlign="right">
                            <asp:Literal ID="AmountDue" runat="server"></asp:Literal>
                            <input type="hidden" runat="server" id="hdnAmountDue" value="0" />
                        </asp:TableCell>
                    </asp:TableRow>--%>
                                        <%--<asp:TableRow ID="trReceivedDue" runat="server">
                        <asp:TableCell ColumnSpan="3" Font-Bold="true" HorizontalAlign="right">
                            <asp:Literal ID="ColReceivedDue" runat="server" Text="Enter the Received Due Amount"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell  HorizontalAlign="right">
                            <input type="text" id="txtReceivedDue" onblur="javascript:calculateDue1();" runat="server"   onkeypress="return ValidateOnlyNumeric(this);"   value="0.00"  style=" width:75px;text-align:right; border-color:#d8d8d8; background-color:#efefef; border-style:solid;" />
                        </asp:TableCell>
                    </asp:TableRow>
                     <asp:TableRow ID="trBalanceDue" runat="server">
                        <asp:TableCell ColumnSpan="3" Font-Bold="true" HorizontalAlign="right">
                            <asp:Literal ID="ColBalanceDue" runat="server" Text="Balance Due Amount"></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell  HorizontalAlign="right">
                            <input type="text" id="txtBalanceDue" runat="server" readonly="readonly"   onkeypress="return ValidateOnlyNumeric(this);"   value="0.00"  style=" width:75px;text-align:right; border-color:#d8d8d8; background-color:#efefef; border-style:solid;" />
                        </asp:TableCell>
                    </asp:TableRow>--%>
                                    </asp:Table>
                                </td>
                            </tr>
                            <tr id="referenceIndicator" runat="server" style="display: none;">
                                <td align="left" style="font-weight: bold; font-size: 11px;">
                                    <asp:Literal ID="litReferenceIndicator" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr id="trAdditionalInformation" runat="server" style="display: block;">
                                <td style="width: 600px;">
                                    <asp:Table CellPadding="4" CellSpacing="0" BorderWidth="0" runat="server" ID="Table3"
                                        Width="70%">
                                        <asp:TableRow Height="15px" BorderWidth="0">
                                            <asp:TableCell Font-Bold="true" Font-Underline="true" Font-Size="12px" ColumnSpan="4">
                    Additional Information
                                            </asp:TableCell></asp:TableRow>
                                    </asp:Table>
                                    <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="1px"
                                        runat="server" ID="Table2" Width="70%">
                                        <asp:TableRow CssClass="colorbillprt" Font-Size="11px" Height="15px" BorderWidth="0">
                                            <asp:TableHeaderCell Width="40%" HorizontalAlign="Left">
                                                <asp:Literal ID="Literal3" runat="server"><u>Item</u></asp:Literal>
                                            </asp:TableHeaderCell>
                                            <asp:TableHeaderCell Width="10%" HorizontalAlign="right">
                                                <asp:Literal ID="Literal4" runat="server"><u>Quantity</u></asp:Literal>
                                            </asp:TableHeaderCell>
                                            <asp:TableHeaderCell Width="10%" HorizontalAlign="right">
                                                <asp:Literal ID="Literal5" runat="server"><u>Rate</u></asp:Literal>
                                            </asp:TableHeaderCell>
                                            <asp:TableHeaderCell Width="10%" HorizontalAlign="right">
                                                <asp:Literal ID="Literal6" runat="server"><u>Amount</u></asp:Literal>
                                            </asp:TableHeaderCell>
                                        </asp:TableRow>
                                        <asp:TableRow Height="15px" BorderWidth="0">
                                            <asp:TableHeaderCell Width="40%" HorizontalAlign="Left">
                                                <input type="text" id="txtItemName" tooltip="Additional Item Name" tabindex="1" runat="server"
                                                    value="" style="width: 200px; text-align: left; border-color: #d8d8d8; background-color: #efefef;
                                                    border-style: solid;" />
                                            </asp:TableHeaderCell>
                                            <asp:TableHeaderCell Width="10%" HorizontalAlign="right">
                                                <input type="text" id="txtQuantity" tabindex="2" tooltip="Quantity" onblur="javascript:calculateTotal();"
                                                    runat="server"   onkeypress="return ValidateOnlyNumeric(this);"   value="1.00" style="width: 50px;
                                                    text-align: right; border-color: #d8d8d8; background-color: #efefef; border-style: solid;" />
                                            </asp:TableHeaderCell>
                                            <asp:TableHeaderCell Width="10%" HorizontalAlign="right">
                                                <input type="text" id="txtRate" tabindex="3" tooltip="Rate" onblur="javascript:calculateTotal();"
                                                    runat="server"   onkeypress="return ValidateOnlyNumeric(this);"   value="0.00" style="width: 50px;
                                                    text-align: right; border-color: #d8d8d8; background-color: #efefef; border-style: solid;" />
                                            </asp:TableHeaderCell>
                                            <asp:TableHeaderCell Width="10%" HorizontalAlign="right">
                                                <input type="text" id="txtAmount" tooltip="Amount" readonly="readonly" onblur="javascript:calculateTotal();"
                                                    runat="server"   onkeypress="return ValidateOnlyNumeric(this);"   value="0.00" style="width: 63px;
                                                    text-align: right; border-color: #d8d8d8; background-color: #efefef; border-style: solid;" />
                                            </asp:TableHeaderCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </td>
                            </tr>
                            <tr id="commentsBlock" runat="server" style="display: block;">
                                <td align="left" valign="middle" style="padding-bottom: 10px; padding-left: 90px;
                                    padding-top: 10px;">
                                    <asp:Label ID="lblComments" runat="server" Font-Bold="true" Font-Size="12px">Comments</asp:Label>
                                    <textarea id="txtComments" tabindex="4" runat="server" rows="2" tooltip="Comments to be Added for Additional Information"
                                        cols="29"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="padding-left: 130px;">
                                    <input type="hidden" runat="server" id="hdnPatientID" />
                                    <input type="hidden" runat="server" id="hdnClientID" />
                                    <input type="hidden" runat="server" id="hdnCCID" />
                                    <input type="hidden" runat="server" id="hdnVisitID" />
                                    <asp:Button ID="btnCancel" runat="server" ToolTip="Click here to View the Home Page"
                                        Style="cursor: pointer;" Text="Home" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnCancel_Click" />
                                    <asp:Button ID="btnAdditionalInformation" runat="server" Visible="true" ToolTip="Click here to Add the Additional Information"
                                        Style="cursor: pointer;" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="javascript:return calculateDue();"
                                        OnClick="btnAdditionalInformation_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
