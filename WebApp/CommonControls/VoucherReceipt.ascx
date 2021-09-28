<%@ Control Language="C#" AutoEventWireup="true" CodeFile="VoucherReceipt.ascx.cs"
    Inherits="CommonControls_AdvanceReceipt" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<style type="text/css">
    .style2
    {
    }
    .style3
    {
        font-weight: bold;
        text-decoration: underline;
    }
    .style4
    {
        font-weight: bold;
    }
    .style5
    {
    }
    .style6
    {
        height: 12px;
    }
</style>
<table width="100%" border="1" align="center" id="tblBillPrint" runat="server">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" style="font-family: Verdana; font-size: 10px;"
                cellpadding="0" align="center" id="tbl1" runat="server">
                <tr>
                    <td colspan="9" align="center">
                        <asp:Image ID="imgBillLogo" runat="server" Visible="False" 
                            meta:resourcekey="imgBillLogoResource1" />
                    </td>
                </tr>
                <tr>
                    <td colspan="9" align="center">
                        <label id="lblHospitalName" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="9" align="center">
                        <br />
                        <span style="text-decoration: underline;">  
                        <asp:Label ID="lbpaymentvoucher" runat="server"
                            Text="Payment Voucher" meta:resourcekey="lbpaymentvoucherResource1"></asp:Label> </span>
                    </td>
                </tr>
                <tr>
                    <td colspan="9">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="right" class="style5">
                        <asp:Label ID="lbfor" runat="server" Text="For" 
                            meta:resourcekey="lbforResource1" Font-Bold ="true" ></asp:Label> 
                    </td>
                    <td class="style5">
                        &nbsp; :
                        <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                    </td>
                    <td class="style5">
                    </td>
                    <td class="style5">
                        &nbsp;
                    </td>
                    <td class="style5">
                        &nbsp;
                    </td>
                    <td class="style5">
                        &nbsp;
                    </td>
                    <td nowrap="nowrap" align="right" class="style5">
                        <label style="font-weight: 700">
                    <asp:Label ID="lbprintdate" runat="server" Text="Printed Date" 
                            meta:resourcekey="lbprintdateResource1"></asp:Label>
                        </label>
                    </td>
                    <td nowrap="nowrap" align="right" class="style5">
                        <label>
                            :</label>
                    </td>
                    <td nowrap="nowrap" align="left" class="style5">
                        <asp:Label ID="lblInvoiceDate" runat="server" 
                            meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td nowrap="nowrap" align="right">
                        &nbsp;
                    </td>
                    <td nowrap="nowrap" align="right">
                        &nbsp;
                    </td>
                    <td nowrap="nowrap" align="right">
                        &nbsp;
                    </td>
                    <td nowrap="nowrap" align="right">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="right" nowrap="nowrap">
                 <asp:Label ID="lbpaiddate" runat="server" Text="Paid Date" 
                            meta:resourcekey="lbpaiddateResource1" Font-Bold="true" ></asp:Label> 
                    </td>
                    <td class="style2">
                        &nbsp; :
                        <asp:Label ID="lblPaidDate" runat="server" 
                            meta:resourcekey="lblPaidDateResource1"></asp:Label>
                    </td>
                    <td class="style2">
                        &nbsp;
                    </td>
                    <td class="style2">
                        &nbsp;
                    </td>
                    <td class="style2">
                        &nbsp;
                    </td>
                    <td class="style2">
                    </td>
                    <td nowrap="nowrap" align="right" class="style4">
         <asp:Label ID="lbvouchernum" runat="server" Text="Voucher Number" 
                            meta:resourcekey="lbvouchernumResource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap" align="right" class="style2">
                        :
                    </td>
                    <td nowrap="nowrap" align="Left" class="style2">
                        <asp:Label ID="lblVoucherNo" runat="server" 
                            meta:resourcekey="lblVoucherNoResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="9">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="9" style="text-decoration: none;">
                  <asp:Label ID="lbpaymentdet" runat="server" Text="Payment Details" 
                            meta:resourcekey="lbpaymentdetResource1"></asp:Label> :
                        <br />
                    </td>
                </tr>
                <tr>
                    <td colspan="9" class="style3">
                    </td>
                </tr>
                <tr>
                    <td colspan="9">
                        <div id="dvDetails" runat="server">
                            <asp:GridView ID="gvPaymentModes" CellPadding="3" runat="server" 
                                AutoGenerateColumns="False" Width="100%" Font-Names="Verdana" Font-Size="10px" 
                                OnRowDataBound="gvPaymentModes_RowDataBound" 
                                meta:resourcekey="gvPaymentModesResource1">
                                <HeaderStyle CssClass="dataheader1" />
                                <PagerStyle CssClass="dataheader1" />
                                <Columns>
                                    <asp:BoundField HeaderText="Payment Mode" DataField="PaymentName" 
                                        meta:resourcekey="BoundFieldResource1">
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" 
                                        HeaderText="Card/Cheque No" meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCardChequeNo" runat="server" 
                                                Text='<%# Bind("ChequeorCardNumber") %>' 
                                                meta:resourcekey="lblCardChequeNoResource1"></asp:Label>
                                        </ItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:TemplateField>
                                    <%--  <asp:BoundField HeaderText="Card/Cheque No" DataField="ChequeorCardNumber">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:BoundField>--%>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" 
                                        HeaderText="Bank/Card Name" meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBankName" runat="server" 
                                                Text='<%# Bind("BankNameorCardType") %>' 
                                                meta:resourcekey="lblBankNameResource1"></asp:Label>
                                        </ItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField HeaderText="Bank/Card Name" DataField="BankNameorCardType">
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </asp:BoundField>--%>
                                    <asp:BoundField HeaderText="Amount" DataField="AmtPaid" 
                                        DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource2">
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ServiceCharge" HeaderText="Card Fee (%)" 
                                        meta:resourcekey="BoundFieldResource3">
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="style2" colspan="9">
                        &nbsp;&nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="style2" colspan="9">
                       <asp:Label ID="lbremark" runat="server" Text="Remarks" 
                            meta:resourcekey="lbremarkResource1" Font-Bold ="true" ></asp:Label> :
                        <asp:Label ID="lblRemarks" runat="server" 
                            meta:resourcekey="lblRemarksResource1" />
                    </td>
                </tr>
                <tr>
                    <td class="style2" colspan="9" align="right">
                      <asp:Label ID="lbtot" runat="server" Text="Total" 
                            meta:resourcekey="lbtotResource1" Font-Bold ="true" ></asp:Label>  :
                        <asp:Label ID="lblTotal" runat="server" meta:resourcekey="lblTotalResource1" />
                        /-
                    </td>
                </tr>
                <tr>
                    <td class="style2" colspan="9" align="right">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="9" class="style2">
                        &nbsp; <asp:Label ID="lbsumof" runat="server" Text="The Sum of" 
                            meta:resourcekey="lbsumofResource1"></asp:Label>
                        <asp:Label ID="lblCurrency" runat="server" 
                            meta:resourcekey="lblCurrencyResource1" />.<asp:Label ID="lblAmount" 
                            runat="server" meta:resourcekey="lblAmountResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td style="text-align: right;">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="4">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td align="center">
                        &nbsp;
                    </td>
                    <td align="center">
                        &nbsp;
                    </td>
                    <td align="center">
                        &nbsp;
                    </td>
                    <td align="center">
                        &nbsp;
                    </td>
                    <td align="center">
                        &nbsp;
                    </td>
                    <td align="center">
                        &nbsp;
                    </td>
                    <td align="center">
                        &nbsp;
                    </td>
                    <td align="center">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td align="left">
                        <asp:Label ID="lblPassedBy" runat="server" Style="font-weight: 700" 
                            meta:resourcekey="lblPassedByResource1" />
                    </td>
                    <td align="left">
                        |
                    </td>
                    <td colspan="4" align="center">
                        <asp:Label ID="lblAccountant" runat="server" Style="font-weight: 700" 
                            meta:resourcekey="lblAccountantResource1" />
                    </td>
                    <td align="center">
                        &nbsp;| &nbsp;
                    </td>
                    <td align="center">
                        <asp:Label ID="lblReceiverSign" runat="server" Style="font-weight: 700" 
                            meta:resourcekey="lblReceiverSignResource1" />
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td style="text-align: right;">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="4">
                        &nbsp; &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="9">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="4">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
