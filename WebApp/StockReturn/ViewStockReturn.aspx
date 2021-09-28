<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewStockReturn.aspx.cs"
    Inherits="StockReturn_ViewStockReturn" meta:resourcekey="PageResource1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Stock Return</title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div id="DivReturn" class="field">
                    <table class="w-100p" id="prntdiv">
                        <tr>
                            <td colspan="4" class="a-center">
                                <asp:Image ID="imgBillLogo" runat="server" class="hide a-center" meta:resourcekey="imgBillLogoResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" class="a-center bold">
                                <asp:Label ID="lblStockReturn" CssClass="bold font16" runat="server" Text="Stock Return"
                                    meta:resourcekey="lblStockReturnResource1"></asp:Label>
                            </td>
                        </tr>
                        <%--<tr>
                            <td colspan="4" class="a-center bold">
                                <asp:Label ID="lblOrgName" CssClass="bold font14" runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                            </td>
                        </tr>--%>
                        <tr>
                            <td colspan="4">
                                <%--<asp:Label ID="lblfrom" runat="server" Text="From" meta:resourcekey="lblfromResource1"></asp:Label>--%>
                                <span>From</span><br />
                                <asp:Label ID="lblOrgName" runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="w-74p">
                                <asp:Label ID="lblStreetAddress" runat="server" meta:resourcekey="lblStreetAddressResource1"></asp:Label>
                            </td>
                            <td class="a-right bold" id="prntlbldate">
                                <asp:Label ID="lbldate" runat="server" Text="Date" meta:resourcekey="lbldateResource1"></asp:Label>
                            </td>
                            <td class="w-2p">
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblSRDate" runat="server" meta:resourcekey="lblSRDateResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="w-74p">
                                <asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource1"></asp:Label>
                            </td>
                            <td class="a-right bold" id="prntlblreturnno">
                                <asp:Label ID="lblreturnno" Text="StockReturn No" runat="server" meta:resourcekey="lblreturnnoResource1"></asp:Label>
                            </td>
                            <td class="w-2p">
                                :
                            </td>
                            <td>
                                &nbsp;
                                <asp:Label ID="lblSRID" runat="server" meta:resourcekey="lblSRIDResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="w-74p">
                                <asp:Label ID="lblPhone" runat="server" meta:resourcekey="lblPhoneResource1"></asp:Label>
                            </td>
                            <td class="a-right bold" id="prntlblstatusd">
                                <asp:Label Text="Status" ID="lblstatusd" runat="server" meta:resourcekey="lblstatusdResource1"></asp:Label>
                            </td>
                            <td class="w-2p">
                                :
                            </td>
                            <td class="w-5p">
                                <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="bold">
                                <asp:Label ID="lblTo" Text="To" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <asp:Label ID="lblVendorName" runat="server" meta:resourcekey="lblVendorNameResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:Label ID="lblVendorAddress" runat="server" meta:resourcekey="lblVendorAddressResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:Label ID="lblVendorCity" runat="server" meta:resourcekey="lblVendorCityResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:Label ID="lblVendorPhone" runat="server" meta:resourcekey="lblVendorPhoneResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:GridView ID="grdResult" EmptyDataText="No matching records found " runat="server"
                                    AutoGenerateColumns="False" OnRowDataBound="grdResult_RowDataBound" CssClass="gridView w-100p"
                                    meta:resourcekey="grdResultResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex+1 %>
                                                <asp:HiddenField ID="hdnBatchNo" runat="server" Value='<%# bind("BatchNo") %>' />
                                                <asp:HiddenField ID="hdnProductID" runat="server" Value='<%# bind("ProductID") %>' />
                                                <asp:HiddenField ID="hdnpParentProductID" runat="server" Value='<%# bind("ParentProductID") %>' />
                                                <asp:HiddenField ID="hdnpInHandQuantity" runat="server" Value='<%# bind("InHandQuantity") %>' />
                                                <asp:HiddenField ID="hdnpUnits" runat="server" Value='<%# bind("Unit") %>' />
                                                <asp:HiddenField ID="hdnComplimentQTY" runat="server" Value='<%# bind("ComplimentQTY") %>' />
                                                <asp:HiddenField ID="hdnReceivedUniqueNumber" runat="server" Value='<%# bind("ReceivedUniqueNumber") %>' />
                                                <asp:HiddenField ID="hdnProductRecdDetailsID" runat="server" Value='<%# bind("ProductReceivedDetailsID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="GRN No" DataField="Description" meta:resourcekey="BoundFieldResource1">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" Width="20%" Wrap="True" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Product Name" DataField="ProductName" meta:resourcekey="BoundFieldResource2">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" Width="20%" Wrap="True" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Product Code" DataField="ProductCode" 
                                            meta:resourcekey="BoundFieldResource11" />
                                        <asp:BoundField HeaderText="Batch No" DataField="BatchNo" meta:resourcekey="BoundFieldResource3" />
                                        <asp:TemplateField HeaderText="Quantity" meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <asp:TextBox Text='<%# Eval("Quantity","{0:N}") %>' Width="60px" onkeypress="return ValidateMultiLangChar(this);"
                                                    ID="txtQuantity" runat="server" meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Inhand Qty" meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <asp:Label Text='<%# Eval("InHandQuantity","{0:N}") %>' Width="40px" ID="lblInHandQty"
                                                    runat="server" meta:resourcekey="lblInHandQtyResource1"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="SellingUnit" DataField="Unit" meta:resourcekey="BoundFieldResource4" />
                                        <asp:BoundField HeaderText="Unit Price" DataFormatString="{0:N}" DataField="UnitPrice" 
                                            meta:resourcekey="BoundFieldResource12" />
                                    </Columns>
                                    <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="gridHeader" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                    <table class="w-100p">
                        <tr>
                            <td colspan="3">
                                <asp:DataList ID="grdStockReturn" Width="100%" runat="server">
                                    <HeaderTemplate>
                                        <table width="100%" cellspacing="0" rules="all" border="1" style="margin-top: 10px;
                                            color: #333333; width: 100%; border-collapse: collapse;">
                                            <tr>
                                                <th rowspan="3">
                                                    Product
                                                </th>
                                                <th rowspan="3">
                                                    GRN No
                                                </th>
                                                <th rowspan="3">
                                                    Batch No
                                                </th>
                                                <th rowspan="3">
                                                    HSN Code
                                                </th>
                                               <th rowspan="3">
                                                   Expiry Date
                                                </th>
                                                <th rowspan="3">
                                                    Return Qty
                                                </th>
                                                <th rowspan="3">
                                                    Comp Qty
                                                </th>
                                                <th rowspan="3">
                                                    Cost Price
                                                </th>
                                                <th colspan="2">
                                                    Scheme
                                                </th>
                                                <th colspan="2">
                                                    Discount
                                                </th>
                                                <th colspan="6">
                                                    GST
                                                </th>
                                                <th rowspan="3">
                                                    Selling Price
                                                </th>
                                                <th rowspan="3">
                                                    Total Cost
                                                </th>
                                                <th rowspan="3">
                                                    Reason for Stock Return
                                                </th>
                                            </tr>
                                            <tr>
                                                <th rowspan="2">
                                                    %
                                                </th>
                                                <th rowspan="2">
                                                    Amt
                                                </th>
                                                <th rowspan="2">
                                                    %
                                                </th>
                                                <th rowspan="2">
                                                    Amt
                                                </th>
                                                <th colspan="2">
                                                    CGST
                                                </th>
                                                <th colspan="2">
                                                    SGST
                                                </th>
                                                <th colspan="2">
                                                    IGST
                                                </th>
                                            </tr>
                                            <tr>
                                                <th>
                                                    %
                                                </th>
                                                <th>
                                                    Amt
                                                </th>
                                                <th>
                                                    %
                                                </th>
                                                <th>
                                                    Amt
                                                </th>
                                                <th>
                                                    %
                                                </th>
                                                <th>
                                                    Amt
                                                </th>
                                            </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <%#Eval("ProductName")%>
                                            </td>
                                            <td>
                                                <%#Eval("Description")%>
                                            </td>
                                            <td>
                                                <%#Eval("BatchNo")%>
                                            </td>
                                            <td>
                                                <%# Eval("HSNCode")%>
                                            </td>
                                            <td>
                                              <%# ((Eval("ExpiryDate", "{0:yyyy}")) == "1753" || (Eval("ExpiryDate", "{0:yyyy}")) == "9999" || (Eval("ExpiryDate", "{0:yyyy}")) == "0001") ? "**" : Eval("ExpiryDate", "{0: MMM-yyyy}")%>
                                            </td>
                                            <td>
                                                <%# Eval("Quantity")%>
                                            </td>
                                            <td>
                                                <%# Eval("ComplimentQTY")%>
                                            </td>
                                            <td>
                                                <%# string.Format("{0:n}", hdnIsCostPriceChange.Value == "Y" ? Eval("PrepareCharges") : Eval("UnitPrice"))%> 
                                                <%--<%# string.Format("{0:n}", Eval("UnitPrice"))%>--%>
                                            </td>
                                            <td>
                                                <%# string.Format("{0:n}", Eval("SchemeType"))%>
                                            </td>
                                            <td>
                                                <%# string.Format("{0:n}", Eval("TotalSchemeDisc"))%>
                                            </td>
                                            <td>
                                                <%# string.Format("{0:n}", Eval("DiscountType"))%>
                                            </td>
                                            <td>
                                                <%# string.Format("{0:n}", Eval("TotalNormalDisc"))%>
                                            </td>
                                            <td>
                                                <%# string.Format("{0:n}", Eval("CGSTPercent"))%>
                                            </td>
                                            <td>
                                                <%# string.Format("{0:n}", Eval("CGSTRate"))%>
                                            </td>
                                            <td>
                                                <%# string.Format("{0:n}", Eval("SGSTPercent"))%>
                                            </td>
                                            <td>
                                                <%# string.Format("{0:n}", Eval("SGSTRate"))%>
                                            </td>
                                            <td>
                                                <%# string.Format("{0:n}", Eval("IGSTPercent"))%>
                                            </td>
                                            <td>
                                                <%# string.Format("{0:n}", Eval("IGSTRate"))%>
                                            </td>
                                            <td>
                                                <%# string.Format("{0:n}", Eval("SellingPrice"))%>
                                            </td>
                                            <td>
                                                <%# string.Format("{0:n}", Eval("TotalCost"))%>
                                            </td>
                                            <td>
                                                <%# string.Format("{0:n}", Eval("Remarks"))%>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="hide" />
                                    <FooterTemplate>
                                        </table>
                                    </FooterTemplate>
                                    <FooterStyle CssClass="hide" />
                                </asp:DataList>
                            </td>
                        </tr><br />
                        <tr>
                            <td colspan="2" class="a-left w-80p v-bottom"><br />
                                <table cellpadding="4" cellspacing="4">
                                    <tr>
                                        <td align="left" colspan="2">
                                            <asp:DataList ID="grdGstTax" Width="100%" runat="server" align="center">
                                                <HeaderTemplate>
                                                    <table cellspacing="0" rules="all" border="1" style="color: #333333; width: 75%;
                                                        border-collapse: collapse;" class="w-100p">
                                                        <tr>
                                                            <td colspan="7" align="center">
                                                                <b>
                                                                    <center>
                                                                        GST Tax Breakup Details</center>
                                                                </b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th rowspan="2">
                                                                Taxable<br />
                                                                Value
                                                            </th>
                                                            <th colspan="2">
                                                                CGST
                                                            </th>
                                                            <th colspan="2">
                                                                SGST
                                                            </th>
                                                            <th colspan="2">
                                                                IGST
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                %
                                                            </th>
                                                            <th>
                                                                Amount
                                                            </th>
                                                            <th>
                                                                %
                                                            </th>
                                                            <th>
                                                                Amount
                                                            </th>
                                                            <th>
                                                                %
                                                            </th>
                                                            <th>
                                                                Amount
                                                            </th>
                                                        </tr>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td class="a-right" style="height: 25px;">
                                                            <%# string.Format("{0:n}", Eval("TaxableValue"))%>
                                                        </td>
                                                        <td class="a-center">
                                                            <%# string.Format("{0:n}", Eval("CGSTPercent"))%>
                                                        </td>
                                                        <td class="a-right">
                                                            <%# string.Format("{0:n}", Eval("CGSTRate"))%>
                                                        </td>
                                                        <td class="a-center">
                                                            <%# string.Format("{0:n}", Eval("SGSTPercent"))%>
                                                        </td>
                                                        <td class="a-right">
                                                            <%# string.Format("{0:n}", Eval("SGSTRate"))%>
                                                        </td>
                                                        <td class="a-center">
                                                            <%# string.Format("{0:n}", Eval("IGSTPercent"))%>
                                                        </td>
                                                        <td class="a-right">
                                                            <%# string.Format("{0:n}", Eval("IGSTRate"))%>
                                                        </td>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="hide" />
                                                <FooterTemplate>
                                                    </tr> </table>
                                                </FooterTemplate>
                                                <FooterStyle CssClass="hide" />
                                            </asp:DataList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblTotalTaxablevalue" runat="server" meta:resourceKey="lblTotalTaxablevalueResource2"
                                                Visible="false"></asp:Label>
                                            <br />
                                            <asp:Label ID="lblTotalCGSTAmount" runat="server" meta:resourceKey="lblTotalCGSTAmountResource2"
                                                Visible="false"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotalSGSTAmount" runat="server" meta:resourceKey="lblTotalSGSTAmountResource1"
                                                Visible="false"></asp:Label><br />
                                            <asp:Label ID="lblTotalIGSTAmount" runat="server" meta:resourceKey="lblTotalIGSTAmountResource1"
                                                Visible="false">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="v-top">
                                        </td>
                                        <td class="v-bottom">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="a-right w-20p" style="width: 20% !important; text-align: right !important;">
                                <table id="tblAmountDetails" runat="server" class="w-100p a-right" cellspacing="5">
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblTotalValue1" runat="server" Text="Total Values"></asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblTotalValue" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblTotalSchemeDisc" runat="server" Text="Scheme Discount"></asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblTotalSchemeAmt" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblTotalDiscount" runat="server" Text="Discount"></asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblTotalDiscountAmt" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <%--<tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblAmtBeforeTax" runat="server" Text="Amount Before Tax"> </asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblAmtBefTax" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trcgst" runat="server">
                                        <td align="left">
                                            <asp:Label ID="lbltotcgst" runat="server" Text="Total CGST"></asp:Label>&nbsp;&nbsp;
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lbltotcgstamt" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trsgst" runat="server">
                                        <td align="left">
                                            <asp:Label ID="lbltotsgst" runat="server" Text="Total SGST"></asp:Label>&nbsp;&nbsp;
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lbltotsgstamt" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trigst" runat="server">
                                        <td align="left">
                                            <asp:Label ID="lbltotigst" runat="server" Text="Total IGST"></asp:Label>&nbsp;&nbsp;
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lbltotigstamt" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>--%>
                                    <tr id="totalTaxAmt" runat="server">
                                        <td class="a-left">
                                            <asp:Label ID="lblTotalTaxAmount" runat="server" Text="Total GST Amount"></asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblTotaltax" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <%--<tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblAmtAfterTax" runat="server" Text="Amount After Tax"></asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblAmtAftTax" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <br />
                                    <tr runat="server" id="trpodiscount">
                                        <td class="a-left">
                                            <asp:Label ID="lblPODiscount2" runat="server" Text="PO Discount"></asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblDiscount" Width="50px" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblCreditAmountToBeUsed2" runat="server" Text="Credit Amount To Be Used"
                                                meta:resourcekey="lblCreditAmountToBeUsed2Resource1"></asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblamountused" Width="50px" runat="server" Text="0.00" meta:resourcekey="lblamountusedResource2"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblTotal" runat="server" Text="Total" meta:resourcekey="lblTotalResource1"></asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblGrountTotal" runat="server" Text="0.00" meta:resourcekey="lblGrountTotalResource2"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trStampFee" runat="server">
                                        <td class="a-left">
                                            <asp:Label ID="lblStampFee" runat="server" Text="Stamp Fee" meta:resourcekey="lblStampFeeResource1"></asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblStampFeeused" Width="50px" runat="server" Text="0.00" meta:resourcekey="lblStampFeeResource2"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trDeliveryCharges" runat="server">
                                        <td class="a-left">
                                            <asp:Label ID="lblDeliveryCharges" runat="server" Text="Delivery Charges" meta:resourcekey="lblDeliveryChargesResource1"></asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblDeliveryChargesUsed" Width="50px" runat="server" Text="0.00" meta:resourcekey="lblDeliveryChargesResource2"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblRoundOffValue1" runat="server" Text="RoundOff Value" meta:resourcekey="lblRoundOffValueResource2"></asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblRoundOffValue" runat="server" Text="0.00" meta:resourcekey="lblRoundOffValueResource1"></asp:Label>
                                        </td>
                                    </tr>--%>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblGrandTotal" runat="server" Text="Grand Total" class="bold" meta:resourcekey="lblGrandTotalResource1"></asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblGrandwithRoundof" runat="server" Text="0.00" class="bold" meta:resourcekey="lblGrandwithRoundofResource2"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table class="w-100p">
                        <tr class="hide">
                            <td id="commentsTD" runat="server">
                                <hr />
                            </td>
                        </tr>
                        <tr id="approvalTR" class="hide" runat="server">
                            <td id="Td1" runat="server">
                                <table id="tbltotalamount" class="hide" class="w-100p marginT5">
                                    <tr>
                                        <td colspan="3">
                                        </td>
                                        <td class="paddingL50 bold a-right" runat="server" id="tdProdAmount">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                        </td>
                                        <td runat="server" class="paddingL50 bold a-right" id="tdTax">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                        </td>
                                        <td id="ReturnamountTD" class="paddingL50 bold a-right" runat="server">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="w-20p bold">
                                            <asp:Label ID="lblReason" runat="server" Text="Reason for Return" meta:resourcekey="lblReasonResource1"></asp:Label>
                                        </td>
                                        <td class="w-3p">
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblReasontxt" runat="server" meta:resourcekey="lblReasontxtResource1"></asp:Label>
                                        </td>
                                        <td class="w-82p">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="w-20p bold">
                                            <asp:Label ID="Label2" runat="server" Text="Approved Date" meta:resourcekey="Label2Resource1"></asp:Label>
                                        </td>
                                        <td class="w-3p">
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="approvedDateTD" runat="server" meta:resourcekey="approvedDateTDResource1"></asp:Label>
                                        </td>
                                        <td class="w-82p">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="bold">
                                            <asp:Label ID="Label1" Text="Approved By" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                                        </td>
                                        <td class="w-3p">
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="approvedByTD" runat="server" meta:resourcekey="approvedByTDResource1"></asp:Label>
                                        </td>
                                        <td class="w-82p">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="bold">
                               <span> Kindly Debit the Total Amount in above vendor's A/c.</span>
                            </td>
                        </tr>
                        <tr>
                        </tr>
                        <tr>
                            <td class="w-50p bold">
                                <asp:Label class="bold" ID="lblSign" runat="server" Text="<br><br>Prepared By" meta:resourcekey="lblSignResource1"></asp:Label>
                            </td>
                            <td class="w-35p bold">
                                <asp:Label class="bold" ID="lblauthorized" runat="server" Text="<br><br>Authorized By"
                                    meta:resourcekey="lblauthorizedResource1"></asp:Label>
                            </td>
                            <td class="w-28p bold">
                                <asp:Label class="bold" ID="lblapproved" runat="server" Text="<br><br>Approved By"
                                    meta:resourcekey="lblapprovedResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="w-50p bold" id="lblPreparedbyVal" runat="server">
                            </td>
                            <td class="w-35p bold" id="lblauthorizedVal" runat="server">
                            </td>
                            <td class="w-28p bold" >
                              <asp:Label id="lblApprovedbyVal" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center" colspan="3">
                                <table class="w-100p">
                                    <tr>
                                        <td class="a-center">
                                            <asp:Button ID="btnUpdate" Text="Update" Width="50px" runat="server" CssClass="btn"
                                                OnClick="btnUpdate_Click" meta:resourcekey="btnUpdateResource1" />
                                            &nbsp;
                                            <asp:Button ID="btnApprove" Text="Approve" runat="server" CssClass="btn" OnClick="btnApprove_Click"
                                                meta:resourcekey="btnApproveResource1" />
                                            &nbsp;
                                            <asp:Button ID="btnCancel" Text ="Cancel" runat="server" CssClass ="btn" OnClick="btnCancel_Click" />
                                            &nbsp;
                                            <asp:Button ID="btnPrint" Text="Print" OnClientClick="CallPrint();return false;"
                                                runat="server" CssClass="btn" meta:resourcekey="btnPrintResource1" />
                                            <input type="hidden" id="hdnApproveStockReturn" runat="server" />
                                            <asp:Button ID="btnBack" runat="server" CssClass="cancel-btn" meta:resourcekey="btnBackResource1"
                                                OnClick="btnBack_Click" Text="Back" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:HiddenField ID="hdnTableData" runat="server" />
        <asp:HiddenField ID="hdnCount" Value="0" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnNoGSTforExpiredProducts" runat="server" Value="N" />
    <asp:HiddenField ID="hdnIsSchemeDisc" runat="server" Value="N" />
    <asp:HiddenField ID="hdnIsCostPriceChange" runat="server" Value="N" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">

        function ValidateReturnQty(avilableQty, ReturnQuantity) {

            //             var pavilableQty = document.getElementById(avilableQty).value;
            //             var pReturnQuantity = document.getElementById(ReturnQuantity).value;
            var pavilableQty = ToInternalFormat($('#' + avilableQty));
            var pReturnQuantity = ToInternalFormat($('#' + ReturnQuantity));

            if (Number(pavilableQty) < Number(pReturnQuantity)) {
                var userMsg = SListForAppMsg.Get('StockReturn_ViewStockReturn_aspx_01');
                var errorMsg = SListForAppMsg.Get('StockReturn_Error');
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
                else {
                    ValidationWindow('Provide return quantity less than or equal to Available quantity', 'Error');
                    return false;

                }
                //document.getElementById(ReturnQuantity).value = Number(pIssuedQuantity).toFixed(2);
                document.getElementById(ReturnQuantity).value = '';
                document.getElementById(ReturnQuantity).focus();
                return false;
            }

        }
    </script>

    <script language="javascript" type="text/javascript">

        function CallPrint() {

            var prtContent = document.getElementById('DivReturn');
            document.getElementById('btnPrint').style.display = 'none';
            document.getElementById('btnBack').style.display = 'none';
            //document.getElementById('btnApprove').style.display = 'none';
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write('<html><head><title></title>');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/Common.css" />');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/Themes/GG/style.css" />');
            WinPrint.document.write('</head><body>');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.write('</body></html>');
            WinPrint.document.close();
            WinPrint.focus();
            setTimeout(function() {
                WinPrint.print();
                WinPrint.close();
            }, 1000);
            document.getElementById('btnPrint').style.display = 'inline-block';
            document.getElementById('btnBack').style.display = 'inline-block';
        }
    </script>

</body>
</html>
