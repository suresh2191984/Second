<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RakshithBillPrint.ascx.cs"
    Inherits="Billing_RakshithBillPrint" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<%@ Register Src="FinalBillHeader.ascx" TagName="FinalBillHeader" TagPrefix="uc3" %>
<style type="text/css">
    .style4
    {
        width: 107px;
    }
    .style6
    {
        width: 250px;
    }
    .style7
    {
        width: 89px;
    }
    .style9
    {
        width: 701px;
    }
</style>
<table width="700px" style="font-size: 14px;" border="0" align="left" id="tblBillPrint"
    runat="server">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                <tr>
                    <td>
                        <table cellpadding="2" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td colspan="4" id="tdDupBill" runat="server" align="center" style="display:none;">
                                    <asp:Label ID="lblTypeBill" Style="font-weight: bold;" runat="server" meta:resourcekey="lblTypeBillResource1"></asp:Label>
                                    <asp:Label ID="lblDupBill" Style="font-weight: bold;" Text="(Duplicate Copy)" Visible="False"
                                        runat="server" meta:resourcekey="lblDupBillResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="style7">
                                    <asp:Label ID="Rs_BillNo" runat="server" Text="Bill No:" meta:resourcekey="Rs_BillNoResource1"></asp:Label>
                                </td>
                                <td class="style6">
                                    <asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
                                </td>
                                <td class="style4">
                                    <asp:Label ID="Rs_Date" runat="server" Text="Date:" meta:resourcekey="Rs_DateResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="style7">
                                    <asp:Label ID="Rs_PatientName" runat="server" Text="Patient Name:" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                </td>
                                <td class="style6">
                                <asp:Label ID="lblTitleName" runat="server" Style="font-weight: 700"></asp:Label>
                                    <asp:Label ID="lblName" runat="server" Style="font-weight: 700" meta:resourcekey="lblNameResource1"></asp:Label>
                                </td>
                                <td id="lblPhy" runat="server" class="style4">
                                    <asp:Label ID="Rs_PhysicianName" runat="server" Text="Physician Name:" meta:resourcekey="Rs_PhysicianNameResource1"></asp:Label>
                                </td>
                                <td id="tblPhySal" runat="server">
                                    <b>
                                        <asp:Label ID="Rs_Dr" runat="server" Text="Dr." meta:resourcekey="Rs_DrResource1"></asp:Label>
                                    </b>
                                    <asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700" meta:resourcekey="lblPhysicianResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td class="style7">
                                    <asp:Label ID="Rs_PatientAge" runat="server" Text="Patient Age:" meta:resourcekey="Rs_PatientAgeResource1"></asp:Label>
                                </td>
                                <td class="style6">
                                    <asp:Label ID="lblAge" runat="server" Style="font-weight: 700" meta:resourcekey="lblAgeResource1"></asp:Label>
                                </td>
                                <td class="style4">
                                    <asp:Label ID="Rs_Sex" runat="server" Text="Sex:" meta:resourcekey="Rs_SexResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblSex" runat="server" Style="font-weight: 700" meta:resourcekey="lblSexResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="phyDetails" runat="server">
                                <td class="style7">
                                    <asp:Label ID="Rs_PatientNo" runat="server" Text="Patient No:" meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                                </td>
                                <td colspan="3">
                                    <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <uc3:FinalBillHeader ID="FinalBillHeader1" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="gvBillingDetail" runat="server" BorderWidth="0px" CellPadding="0"
                            Width="100%" AutoGenerateColumns="False" meta:resourcekey="gvBillingDetailResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="Description" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                    meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" Text='<%# Bind("FeeDescription") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Amount" HeaderText="Amount" HeaderStyle-HorizontalAlign="Right"
                                    DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource1">
                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td align="right" class="style9">
                                    &nbsp;
                                </td>
                                <td colspan="6" align="right" class="style9">
                                    --------------------------------------------------------
                                </td>
                            </tr>
                            <tr>
                                <td class="style9" align="left">
                                    <b>
                                        <asp:Label ID="Rs_PaymentMode" runat="server" Text="Payment Mode" meta:resourcekey="Rs_PaymentModeResource1"></asp:Label></b>
                                </td>
                                <td class="style9" align="right">
                                    <asp:Label ID="Rs_GrossAmount" runat="server" Text="Gross Amount:" meta:resourcekey="Rs_GrossAmountResource1"></asp:Label>
                                </td>
                                <td colspan="5" align="right">
                                    <asp:Label ID="lblGrossAmount" runat="server" meta:resourcekey="lblGrossAmountResource1" />
                                </td>
                            </tr>
                            <tr style="display: table-row;">
                                <td class="style9" align="left">
                                    <asp:Label runat="server" ID="lblPaymentMode" meta:resourcekey="lblPaymentModeResource1"></asp:Label>
                                    <span id="lblPayMode" runat="server"></span>
                                </td>
                                <td class="style9" align="right">
                                    <asp:Label ID="Rs_DeductionAmount" runat="server" Text="Deduction Amount:" meta:resourcekey="Rs_DeductionAmountResource1"></asp:Label>
                                </td>
                                <td colspan="5" align="right">
                                    <asp:Label ID="lblDeduction" runat="server" meta:resourcekey="lblDeductionResource1" />
                                </td>
                            </tr>
                            <tr id="trServiceCharge" runat="server">
                                <td class="style9" align="left">
                                    <asp:Label runat="server" ID="lblOtherCurrency" meta:resourcekey="lblOtherCurrencyResource1"></asp:Label>
                                </td>
                                <td class="style9" align="right">
                                    <asp:Label ID="Rs_ServiceCharge" runat="server" Text="Service Charge:" meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
                                </td>
                                <td colspan="5" align="right">
                                    <asp:Label ID="lblServiceCharge" runat="server" meta:resourcekey="lblServiceChargeResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td class="style9" align="left">
                                    <asp:Label ID="lblDepositAmtUsed" Visible="False" runat="server" meta:resourcekey="lblDepositAmtUsedResource1"></asp:Label>
                                </td>
                                <td class="style9" align="right">
                                    <asp:Label ID="Rs_Discount" runat="server" Text="Discount: (-)" meta:resourcekey="Rs_DiscountResource1"></asp:Label>
                                </td>
                                <td colspan="5" align="right">
                                    <asp:Label ID="lblDiscount" runat="server" meta:resourcekey="lblDiscountResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td rowspan="10">
                                </td>
                                <td class="style9" align="right">
                                    <asp:Label ID="Rs_RoundOffAmount" runat="server" Text="Round Off Amount :" meta:resourcekey="Rs_RoundOffAmountResource1"></asp:Label>
                                </td>
                                <td colspan="5" align="right">
                                    <asp:Label ID="lblRoundOff" runat="server" Text="0.00" meta:resourcekey="lblRoundOffResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="right">
                                    <div id="dvTaxDetails" runat="server">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" align="right">
                                    --------------------------------------------------------
                                </td>
                            </tr>
                            <tr id="trGrandTotal" runat="server">
                                <td class="style9" align="right">
                                    <asp:Label ID="Rs_GrandTotal" runat="server" Text="Grand Total:" meta:resourcekey="Rs_GrandTotalResource1"></asp:Label>
                                </td>
                                <td colspan="5" align="right">
                                    <asp:Label ID="lblGrandTotal" runat="server" meta:resourcekey="lblGrandTotalResource1" />
                                </td>
                            </tr>
                            <tr id="trPreviousDue" runat="server">
                                <td class="style9" align="right">
                                    <asp:Label ID="Rs_PreviousDue" runat="server" Text="Previous Due:" meta:resourcekey="Rs_PreviousDueResource1"></asp:Label>
                                </td>
                                <td colspan="5" align="right">
                                    <asp:Label ID="lblPreviousDue" runat="server" meta:resourcekey="lblPreviousDueResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trGrandTotalLine" runat="server">
                                <td colspan="6" align="right">
                                    --------------------------------------------------------
                                </td>
                            </tr>
                            <tr>
                                <td class="style9" align="right">
                                    <asp:Label ID="RS_NetAmount" runat="server" Text=" Net Amount:" meta:resourcekey="RS_NetAmountResource1"></asp:Label>
                                </td>
                                <td colspan="5" align="right">
                                    <asp:Label ID="lblNetValue" runat="server" Style="font-weight: 700" meta:resourcekey="lblNetValueResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" align="right">
                                    --------------------------------------------------------
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="top" class="style9">
                                    <table>
                                        <tr>
                                            <td align="right" valign="top">
                                                <asp:Label ID="Rs_AmountReceived" runat="server" Text="Amount Received:" meta:resourcekey="Rs_AmountReceivedResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td colspan="5" valign="top">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="lblAmountRecieved" runat="server" Style="font-weight: 700" meta:resourcekey="lblAmountRecievedResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <%--<td class="style8">
                                    <asp:Label ID="Label2" runat="server" Style="font-weight: 700">Amount in Words:&nbsp;(<%= CurrencyName %>)&nbsp;</asp:Label>
                                    &nbsp;
                                    <asp:Label ID="Label3" runat="server" Style="font-weight: 700"> </asp:Label>
                                </td>--%>
                                <td class="style9" align="right">
                                    <asp:Label ID="lblCurrentVisitDueLabel" Text="Due:" runat="server" meta:resourcekey="lblCurrentVisitDueLabelResource1"></asp:Label>
                                </td>
                                <td colspan="5" align="right">
                                    <asp:Label ID="lblCurrentVisitDueText" runat="server" meta:resourcekey="lblCurrentVisitDueTextResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td class="style9">
                                    &nbsp;
                                </td>
                                <td class="style9">
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
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" align="left">
                                    <asp:Label ID="lblDisplayAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblDisplayAmountResource1"></asp:Label>
                                    <asp:Label ID="lblAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblAmountResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trPayingCurrency" runat="server" style="display: none">
                                <td colspan="6" align="left">
                                    <asp:Label ID="lblPayingCurrency" runat="server" Style="font-weight: 700" meta:resourcekey="lblPayingCurrencyResource1"></asp:Label>
                                    <asp:Label ID="lblPayingCurrencyinWords" runat="server" Style="font-weight: 700"
                                        meta:resourcekey="lblPayingCurrencyinWordsResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" align="left">
                                    <asp:Label ID="lblDueAmountinWords" runat="server" Style="font-weight: 700" meta:resourcekey="lblDueAmountinWordsResource1"></asp:Label>
                                    <asp:Label ID="lblDueAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblDueAmountResource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    &nbsp;
                                </td>
                                <td colspan="6" align="right">
                                    <asp:Label ID="lblBilledBy" runat="server" meta:resourcekey="lblBilledByResource1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hdnPayingCurrency" runat="server" />

<script type="text/javascript" language="javascript">
    if (document.getElementById('<%=hdnPayingCurrency.ClientID %>').value == "1") {
        document.getElementById('<%=trPayingCurrency.ClientID %>').style.display = "table-row";
    }
</script>

