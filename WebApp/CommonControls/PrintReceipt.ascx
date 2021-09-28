<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PrintReceipt.ascx.cs"
    Inherits="CommonControls_PrintReceipt" %>
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
                        <asp:Image ID="imgBillLogo" runat="server" Visible="false" />
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
                        <span style="text-decoration: underline;">Payment Receipt </span>
                    </td>
                </tr>
                <tr>
                    <td colspan="9">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="right" class="style5">
                        <b>For </b>
                    </td>
                    <td class="style5">
                        &nbsp; :
                        <asp:Label ID="lblName" runat="server"></asp:Label>
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
                            Printed Date
                        </label>
                    </td>
                    <td nowrap="nowrap" align="right" class="style5">
                        <label>
                            :</label>
                    </td>
                    <td nowrap="nowrap" align="left" class="style5">
                        <asp:Label ID="lblInvoiceDate" runat="server"></asp:Label>
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
                        <b>Paid Date</b>
                    </td>
                    <td class="style2">
                        &nbsp; :
                        <asp:Label ID="lblPaidDate" runat="server"></asp:Label>
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
                        Receipt Number
                    </td>
                    <td nowrap="nowrap" align="right" class="style2">
                        :
                    </td>
                    <td nowrap="nowrap" align="left" class="style2">
                        <asp:Label ID="lblReceiptNo" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="9">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="9" style="text-decoration: none;">
                        Payment Details:
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
                            <asp:GridView ID="gvPaymentModes" CellPadding="3" runat="server" AutoGenerateColumns="False"
                                GridLines="Both" Width="100%" Font-Names="Verdana" Font-Size="10px" OnRowDataBound="gvPaymentModes_RowDataBound">
                                <HeaderStyle CssClass="dataheader1" />
                                <PagerStyle CssClass="dataheader1" />
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="8%" HeaderText="S.No">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Payment Mode" DataField="ModeOFPayment">
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Card/Cheque No">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCardChequeNo" runat="server" Text='<%# Bind("ChequeNo") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Bank/Card Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBankName" runat="server" Text='<%# Bind("BankName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Amount">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAmountReceived" runat="server" Text='<%# Eval("AmountReceived") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField> 
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
                        <b>Remarks </b>:
                        <asp:Label ID="lblRemarks" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="style2" colspan="9" align="right">
                        <b>Total :</b>
                        <asp:Label ID="lblTotal" runat="server" />
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
                        &nbsp;The Sum of
                        <asp:Label ID="lblCurrency" runat="server" />.<asp:Label ID="lblAmount" runat="server"> </asp:Label>
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
                        <asp:Label ID="lblPassedBy" runat="server" Style="display: none; font-weight: 700" />
                    </td>
                    <td align="left">
                    </td>
                    <td colspan="4" align="center">
                        <asp:Label ID="lblAccountant" runat="server" Style="display: none; font-weight: 700" />
                    </td>
                    <td align="center">
                        &nbsp; &nbsp;
                    </td>
                    <td align="center">
                        <asp:Label ID="lblReceiverSign" runat="server" Style="font-weight: 700" />
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
                    <td colspan="4">
                        &nbsp;
                    </td>
                    <td align="center">
                        <asp:Label ID="lblReceivedBy" runat="server" Style="font-weight: 700" />
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
