<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PharmacyDueReceipt.ascx.cs"
    Inherits="CommonControls_PharmacyDueReceipt" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<style type="text/css">
    .style1
    {
        text-decoration: underline;
    }
    .style2
    {
        height: 12px;
    }
    .style3
    {
        font-weight: bold;
        text-decoration: underline;
    }
</style>
<table width="100%" align="center" border="0" id="tblBillPrint" runat="server">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" style="font-family: Verdana; font-size: 10px;"
                cellpadding="0" align="center" id="tbl1" runat="server">
                <tr>
                    <td colspan="6" align="center">
                        <asp:Image ID="imgBillLogo" runat="server" Visible="false" />
                    </td>
                </tr>
                <tr>
                    <td colspan="6" align="center">
                        <label style="font-family: Arial; font-size: medium;" id="lblHospitalName" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="6" align="center" id="tdReceiptType" runat="server">
                        Due
                        Payment Receipt
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td nowrap="nowrap">
                        &nbsp;&nbsp;
                    </td>
                    <td width="18%">
                        &nbsp;
                    </td>
                    <td width="24%">
                        &nbsp;
                    </td>
                    <td width="13%">
                        &nbsp;
                    </td>
                    <td nowrap="nowrap" align="right">
                        <label>
                            Date :
                        </label>
                        <asp:Label ID="lblInvoiceDate" runat="server"></asp:Label>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        &nbsp;&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="5">
                        <table border="0" cellspacing="0" cellpadding="0" style="font-family: Verdana; font-size: 10px;">
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <label>
                                        Received From :</label>
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <span style="width: 23%">
                                        <asp:Label ID="lblName" runat="server"></asp:Label>
                                    </span>
                                </td>
                                <td width="83%" align="right" nowrap="nowrap">
                                    Receipt Number :
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <asp:Label ID="lblReceiptNo" runat="server"></asp:Label>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;&nbsp;
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    Paid Date :
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <asp:Label ID="lblPaidDate" runat="server"></asp:Label>
                                </td>
                                <td width="83%" align="right" nowrap="nowrap">
                                    <div id="divref" runat="server">
                                        <table>
                                            <tr>
                                                <td align="Right" nowrap="nowrap">
                                                    <asp:Label runat="server" ID="lblrefPhyH" Text="Referring Physician :"></asp:Label>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label runat="server" ID="lblRefPhy"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td colspan="5" style="text-decoration: none;">
                        &nbsp;</td>
                    <td>
                        &nbsp;&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="5">
                        &nbsp;&nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="7" class="style3">
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <div id="dvDetails" runat="server">
                            <%--<asp:GridView ID="gvIndents" CellPadding="3" runat="server" AutoGenerateColumns="False"
                                GridLines="none" Width="100%" Font-Names="Verdana" Font-Size="10px">
                                <HeaderStyle CssClass="dataheader1" />
                                <PagerStyle CssClass="dataheader1" />
                                <Columns>--%>
                                    <%--  <asp:BoundField HeaderText="Description" DataField="Description">
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </asp:BoundField>--%>
                                   <%-- <asp:TemplateField HeaderText="Description">
                                        <ItemTemplate>
                                            <asp:Label ID="chkID" runat="server" Style="text-align: left;" Text='<%# Eval("FeeDescription") %>' />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Date" DataField="FromDate" DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="UnitPrice">
                                        <ItemTemplate>
                                            <asp:Label ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                Text='<%#Eval("Amount") %>'    onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"></asp:Label>
                                            <asp:HiddenField ID="hdnOldPrice" Value='<%#Eval("Amount") %>' runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Quantity">
                                        <ItemTemplate>
                                            <asp:Label ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                Text='<%#Eval("Quantity") %>'    onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"></asp:Label>
                                            <asp:HiddenField ID="hdnOldQuantity" Value='<%#Eval("Quantity") %>' runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount">
                                        <ItemTemplate>
                                            <asp:Label ID="txtAmount" runat="server" Style="text-align: right;" ReadOnly="true"
                                                Text='<%# NumberConvert(Eval("Quantity"),Eval("Amount")) %>' Width="60px"></asp:Label>
                                            <asp:HiddenField ID="hdnAmount" runat="server" />
                                            <headerstyle horizontalalign="Center" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>--%>
                        </div>
                        <div id="dvAdvance" runat="server" align="center">
                            Due Payment
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="style2" colspan="6">
                        &nbsp;&nbsp;
                    </td>
                    <td class="style2">
                    </td>
                </tr>
                <tr>
                <td colspan="7">
                <asp:GridView ID="gvBillingDetail" runat="server" Width="100%" AutoGenerateColumns="false">
                                                        <Columns>
                                                        <asp:BoundField DataField="ItemName" HeaderText="Description" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField DataField="BatchNo" HeaderText="Batch" />
                                                           <%--<asp:BoundField DataField="Amount" HeaderText="Unit Price" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right" />--%>
                                                            <asp:BoundField DataField="Quantity" HeaderText="Qty" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Center"/>
                                                            <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right" />
                                                            <%--<asp:BoundField DataField="ReasonforRefund" HeaderText="Reason For Refund"  />--%>
                                                        </Columns>
                                                       
                                                    </asp:GridView>
                 </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="width: 30%">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td style="padding-top: 5px;">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="lblPaymentMode"></asp:Label>
                                                <span id="lblPayMode" runat="server"></span>
                                            </td>
                                        </tr>
                                         <tr id="trDeposit" runat="server" style="display:block">
                                            <td>
                                                <asp:Label Visible="false" ID="lblDepositAmtUsed" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 70%">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td align="right">
                                                Total :
                                                <asp:Label ID="lblTotal" runat="server" />
                                                 <asp:Label ID="lblTotal1" runat="server" />
                                                /-
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Amount Recieved :
                                                <asp:Label ID="lblAmountRecieved" runat="server" />
                                                /-
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:Label runat="server" ID="lblOtherCurrency"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:Label ID="lblPayingCurrency" runat="server"></asp:Label>
                        <asp:Label ID="lblPayingCurrencyinWords" runat="server"> </asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="6" class="style2">
                        &nbsp;Amount in Words: The Sum of
                        <asp:Label ID="lblCurrency" runat="server" />.<asp:Label ID="lblAmount" runat="server"> </asp:Label>
                    </td>
                    <td class="style2">
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td style="text-align: right;">
                        &nbsp;
                    </td>
                    <td colspan="2">
                        &nbsp;
                    </td>
                    <td>
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
                    <td style="text-align: right;">
                        &nbsp;
                    </td>
                    <td colspan="2">
                        <asp:Label ID="lblBilledBy" runat="server" />
                    </td>
                    <td>
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
                    <td style="text-align: right;">
                        &nbsp;
                    </td>
                    <td colspan="2">
                        &nbsp; &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="5">
                        <div id="dvDisclaimer" runat="server">
                            <span class="style1">Disclaimer:</span> This is only an cash&nbsp; receipt. This
                            receipt cannot be used for claiming purpose.</div>
                    </td>
                    <td>
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
                    <td colspan="2">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>