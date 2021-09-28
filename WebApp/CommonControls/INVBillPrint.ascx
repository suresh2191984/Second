<%@ Control Language="C#" AutoEventWireup="true" CodeFile="INVBillPrint.ascx.cs"
    Inherits="CommonControls_INVBillPrint" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />
<table width="75%" border="1" align="center" id="tblBillPrint" runat="server">
    <tr>
        <td>
            <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
                <tr>
                    <%--  <td width="5%" align="center">
                        &nbsp;
                    </td>
                    <td width="16%" align="center">
                        &nbsp;
                    </td>--%>
                    <td colspan="7" align="center">
                        <label style="font-family: Arial; font-size: medium;" id="lblHospitalName" runat="server">
                        </label>
                    </td>
                    <%-- <td width="17%" align="center">
                        &nbsp;
                    </td>
                    <td width="7%" align="center">
                        &nbsp;
                    </td>--%>
                </tr>
                <tr>
                    <td colspan="7" align="center">
                        <asp:Label ID="lblHospitalAddress" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td nowrap="nowrap">
                        <asp:Label ID="Rs_BillNo" runat="server" Text="Bill No:" meta:resourcekey="Rs_BillNoResource1"></asp:Label>
                        <asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
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
                    <td nowrap="nowrap">
                        <asp:Label ID="Rs_BillDate" runat="server" Text="Bill Date :" meta:resourcekey="Rs_BillDateResource1"></asp:Label>
                        <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td nowrap="nowrap">
                        <asp:Label ID="Rs_PatientName" runat="server" Text="Patient Name:" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                        <asp:Label ID="lblName" runat="server" Style="font-weight: 700" meta:resourcekey="lblNameResource1"></asp:Label>
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
                    <td nowrap="nowrap">
                        <label>
                            <asp:Label ID="lblPatientNo" runat="server" Text="Patient No  :" meta:resourcekey="lblPatientNoResource1"></asp:Label>
                        </label>
                        <asp:Label ID="lblPatientNumber" runat="server" Text="--" Style="font-weight: 700"
                            meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td nowrap="nowrap" id="tdphy" runat="server">
                        <asp:Label ID="Rs_PhysicianName" runat="server" Text="Physician Name" meta:resourcekey="Rs_PhysicianNameResource1"></asp:Label>
                        <asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700" meta:resourcekey="lblPhysicianResource1"></asp:Label>
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
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="5">
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="5" style="text-decoration: Underline;">
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="5">
                        <asp:GridView ID="gvBillingDetail" runat="server" Width="100%" AutoGenerateColumns="False"
                            OnRowDataBound="gvBillingDetail_RowDataBound" meta:resourcekey="gvBillingDetailResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" Text='<%# Bind("FeeDescription") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="BatchNo" HeaderText="Batch" meta:resourcekey="BoundFieldResource1" />
                                <%--<asp:BoundField DataField="ExpiryDate" HeaderText="Expiry" DataFormatString="{0:MMM-yyyy}" />--%>
                                <asp:TemplateField HeaderText="Expiry" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:Label ID="lblExpiry" Text='<%# Bind("ExpiryDate") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Quantity" HeaderText="Qty" DataFormatString="{0:F2}" meta:resourcekey="BoundFieldResource2" />
                                <asp:BoundField DataField="Amount" HeaderText="M.R.P" DataFormatString="{0:F2}" meta:resourcekey="BoundFieldResource3" />
                                <asp:BoundField DataField="Rate" HeaderText="Amount" DataFormatString="{0:F2}" meta:resourcekey="BoundFieldResource4" />
                            </Columns>
                        </asp:GridView>
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
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="3" valign="top">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td style="padding-top: 5px;">
                                    <asp:Label Font-Bold="True" ID="lblPayment" Text="Payment Mode" runat="server" meta:resourcekey="lblPaymentResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblPaymentMode" meta:resourcekey="lblPaymentModeResource2"></asp:Label>
                                    <span id="lblPayMode" runat="server"></span>
                                </td>
                            </tr>
                            <tr id="trDeposit" runat="server" style="display: block">
                                <td>
                                    <asp:Label Visible="False" ID="lblDepositAmtUsed" runat="server" meta:resourcekey="lblDepositAmtUsedResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblOtherCurrency" meta:resourcekey="lblOtherCurrencyResource2"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td colspan="3">
                        <table width="100%" height="150" border="0" cellpadding="0" cellspacing="0" style="border-color: #000000">
                            <tr>
                                <td align="right" valign="middle">
                                    <asp:Label ID="Rs_SubTotal" runat="server" Text="Sub Total :" meta:resourcekey="Rs_SubTotalResource1"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblSubTotal" runat="server" meta:resourcekey="lblSubTotalResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="middle">
                                    <asp:Label ID="Rs_Vat" runat="server" Text="Vat :" meta:resourcekey="Rs_VatResource1"></asp:Label>
                                </td>
                                <td align="right" valign="middle">
                                    <asp:Label ID="lblTax" runat="server" meta:resourcekey="lblTaxResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="middle" colspan="2">
                                    -----------------------------------
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="middle">
                                    <asp:Label ID="Rs_GrossAmount" runat="server" Text="Gross Amount :" meta:resourcekey="Rs_GrossAmountResource1"></asp:Label>
                                </td>
                                <td align="right" valign="middle">
                                    <asp:Label ID="lblGrossAmount" runat="server" meta:resourcekey="lblGrossAmountResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="middle">
                                    <asp:Label ID="Rs_Discount" runat="server" Text="Discount :" meta:resourcekey="Rs_DiscountResource1"></asp:Label>
                                </td>
                                <td align="right" valign="middle">
                                    <asp:Label ID="lblDiscount" runat="server" meta:resourcekey="lblDiscountResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="middle" colspan="2">
                                    -----------------------------------
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="middle">
                                    <asp:Label ID="RS_GrandTotal" runat="server" Text="Grand Total :" meta:resourcekey="RS_GrandTotalResource1"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblGrandTotal" runat="server" meta:resourcekey="lblGrandTotalResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="middle">
                                    <asp:Label ID="Rs_PreviousDue" runat="server" Text="Previous Due :" meta:resourcekey="Rs_PreviousDueResource1"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblPreviousDue" runat="server" meta:resourcekey="lblPreviousDueResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" valign="Middle">
                                    -----------------------------------
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="Middle">
                                    <asp:Label ID="Rs_NetAmount" runat="server" Text="Net Amount :" meta:resourcekey="Rs_NetAmountResource1"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblNetValue" runat="server" Style="font-weight: 700" meta:resourcekey="lblNetValueResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="Middle" colspan="2">
                                    -----------------------------------
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="Middle">
                                    <asp:Label ID="Rs_AmountReceived" runat="server" Text="Amount Received :" meta:resourcekey="Rs_AmountReceivedResource1"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblAmountRecieved" runat="server" Style="font-weight: 700" meta:resourcekey="lblAmountRecievedResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="Middle">
                                    <asp:Label ID="lblCurrentVisitDueLabel" Text="Due" runat="server" meta:resourcekey="lblCurrentVisitDueLabelResource1"></asp:Label>
                                    &nbsp;:
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblCurrentVisitDueText" runat="server" meta:resourcekey="lblCurrentVisitDueTextResource1" />
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
                    <td colspan="5" align="left">
                        <asp:Label ID="lblAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblAmountResource1"></asp:Label>
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
                <tr>
                    <td>
                        <asp:TableCell ID="tdSoldByLaser" Font-Bold="True" Style="padding-right: 0px; padding-left: 0px;"
                            HorizontalAlign="Left" runat="server" meta:resourcekey="tdSoldByLaserResource1"></asp:TableCell>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="2" align="center">
                        &nbsp;<asp:Label ID="Rs_Signature" runat="server" Text=" Signature" meta:resourcekey="Rs_SignatureResource1"></asp:Label>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="2" align="center">
                        <asp:Label ID="lblPolicy" runat="server" meta:resourcekey="lblPolicyResource1" />
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
                </tr>
            </table>
        </td>
    </tr>
</table>
