<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EsBillPrint.ascx.cs" Inherits="CommonControls_EsBillPrint" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<%@ Register Src="FinalBillHeader.ascx" TagName="FinalBillHeader" TagPrefix="uc3" %>
<style type="text/css">
    .style1
    {
        width: 10px;
    }
    .style2
    {
        height: 18px;
    }
    .style3
    {
        width: 10px;
        height: 18px;
    }
    .style4
    {
        width: 12px;
    }
</style>
<table width="100%" align="left" id="tblBillPrint" style="font-family: Verdana; font-size: 10px;
    border-style: solid; border-width: 1px;" runat="server">
    <tr>
        <td align="left" style="padding-left: 60px;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
                <tr>
                    <td colspan="1" align="center">
                        <asp:Image ID="imgBillLogo" runat="server" Visible="False" meta:resourcekey="imgBillLogoResource1" />
                    </td>
                    <td colspan="7" align="center">
                        <label style="font-family: Verdana; font-size: 14px;" id="lblHospitalName" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="7" align="left">
                        <br />
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td colspan="9" id="tdDupBill" runat="server" align="center" style="display:none;">
                                    <asp:Label ID="lblTypeBill" Style="font-weight: bold;" runat="server" meta:resourcekey="lblTypeBillResource1"></asp:Label>
                                    <asp:Label ID="lblDupBill" Style="font-weight: bold;" Text="(Duplicate Copy)" Visible="False"
                                        runat="server" meta:resourcekey="lblDupBillResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" nowrap="nowrap">
                                    <asp:Label ID="Rs_BillNo" runat="server" Text="Bill No" meta:resourcekey="Rs_BillNoResource1"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 23%">
                                    <asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td class="style4">
                                    &nbsp;
                                </td>
                                <td align="right" nowrap="nowrap">
                                    <label>
                                        <asp:Label ID="Rs_BillDate" runat="server" Text="Bill Date" meta:resourcekey="Rs_BillDateResource1"></asp:Label></label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;:&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" nowrap="nowrap">
                                    <asp:Label ID="Rs_PatientName" runat="server" Text="Patient Name" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp; :
                                </td>
                                <td align="left" colspan="3" nowrap="nowrap">
                                    <span style="width: 23%">
                                    <asp:Label ID="lblTitleName" runat="server" Style="font-weight: 700"></asp:Label>
                                        <asp:Label ID="lblName" runat="server" Style="font-weight: 700" meta:resourcekey="lblNameResource1"></asp:Label>
                                    </span>
                                </td>
                                <td class="style4">
                                    &nbsp;
                                </td>
                                <td align="right" nowrap="nowrap">
                                    <asp:Label ID="Rs_PatientNo" runat="server" Text="Patient No" meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;:&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <span style="width: 23%">
                                        <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" nowrap="nowrap">
                                    <asp:Label ID="Rs_PatientAgeSex" runat="server" Text="Patient Age/Sex" meta:resourcekey="Rs_PatientAgeSexResource1"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblAge" runat="server" Style="font-weight: 700" meta:resourcekey="lblAgeResource1"></asp:Label>
                                    /
                                    <asp:Label ID="lblSex" runat="server" Style="font-weight: 700" meta:resourcekey="lblSexResource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td class="style4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="9">
                                    <div id="divref" runat="server">
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td align="right" nowrap="nowrap">
                                                    <asp:Label runat="server" ID="lblrefPhyH" Text="Referring Physician" meta:resourcekey="lblrefPhyHResource1"></asp:Label>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    &nbsp;:
                                                </td>
                                                <td align="left" colspan="7" nowrap="nowrap">
                                                    <asp:Label runat="server" ID="lblRefPhy" Font-Bold="True" meta:resourcekey="lblRefPhyResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <div id="phyDetails" runat="server">
                                    <td align="right" nowrap="nowrap" class="style2">
                                        <asp:Label runat="server" ID="lblPhy" Text="Physician Name" meta:resourcekey="lblPhyResource1"></asp:Label>
                                    </td>
                                    <td align="left" nowrap="nowrap" class="style3">
                                        &nbsp; :
                                    </td>
                                    <td align="left" nowrap="nowrap" colspan="7" class="style2">
                                        <asp:Label ID="Rs_Dr" Font-Bold="True" runat="server" Text="Dr." meta:resourcekey="Rs_DrResource1"></asp:Label><asp:Label
                                            ID="lblPhysician" runat="server" Style="font-weight: 700" meta:resourcekey="lblPhysicianResource1"></asp:Label>
                                    </td>
                                </div>
                            </tr>
                            <tr>
                                <td colspan="9" align="center">
                                    <uc3:FinalBillHeader ID="FinalBillHeader1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <%--  <tr>
       
        <td colspan="7" align="center" style="height:1px;background-color:Gray;" >
          
        </td>
       
    </tr>--%>
                <tr>
                    <td colspan="7" style="text-decoration: Underline;">
                        <asp:Label ID="Rs_BillingDetails" runat="server" Text="Billing Details" meta:resourcekey="Rs_BillingDetailsResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <asp:GridView ID="gvBillingDetail" runat="server" Width="100%" AutoGenerateColumns="False"
                            GridLines="None" meta:resourcekey="gvBillingDetailResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" Text='<%# Bind("FeeDescription") %>' runat="server"
                                            meta:resourcekey="lblDescriptionResource1"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Units" DataField="Quantity" meta:resourcekey="BoundFieldResource1">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0:F2}"
                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource2">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle Font-Bold="True" ForeColor="Black" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr valign="top">
                    <td colspan="7">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-color: #000000">
                            <tr>
                                <td colspan="2" align="right" valign="Middle">
                                    -----------------------------------
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="Middle">
                                    <asp:Label ID="Rs_GrossAmount" runat="server" Text="Gross Amount :" meta:resourcekey="Rs_GrossAmountResource1"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblGrossAmount" runat="server" meta:resourcekey="lblGrossAmountResource1" />
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td align="right" valign="Middle">
                                    <asp:Label ID="Rs_DeductionAmount" runat="server" Text="Deduction Amount :" meta:resourcekey="Rs_DeductionAmountResource1"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblDeduction" runat="server" meta:resourcekey="lblDeductionResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="Middle">
                                    <asp:Label ID="Rs_ServiceCharge" runat="server" Text="Service Charge :" meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
                                </td>
                                <td align="right" valign="middle">
                                    <asp:Label ID="lblServiceCharge" runat="server" meta:resourcekey="lblServiceChargeResource1" />
                                </td>
                            </tr>
                             <tr>
                                <td align="right" valign="Middle">
                                    Tax Amount :
                                </td>
                                <td align="right" valign="middle">
                                    <asp:Label ID="lblTaxAmount" runat="server" />
                                </td>
                            </tr>
                            <tr id="trDiscount" runat="server">
                                <td align="right" valign="Middle">
                                    <asp:Label ID="Discount" runat="server" Text="Discount (-) :" meta:resourcekey="DiscountResource2"></asp:Label>
                                </td>
                                <td align="right" valign="middle">
                                    <asp:Label ID="lblDiscount" runat="server" meta:resourcekey="lblDiscountResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="Middle">
                                    <asp:Label ID="Rs_RoundOffAmount" runat="server" Text="Round Off Amount :" meta:resourcekey="Rs_RoundOffAmountResource1"></asp:Label>
                                </td>
                                <td align="right" valign="middle">
                                    <asp:Label ID="lblRoundOff" runat="server" Text="0.00" meta:resourcekey="lblRoundOffResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="Middle" align="right" colspan="2">
                                    <div id="dvTaxDetails" runat="server">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="Middle" colspan="2">
                                    -----------------------------------
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="Middle">
                                    <asp:Label ID="Rs_GrandTotal" runat="server" Text="Grand Total :" meta:resourcekey="Rs_GrandTotalResource1"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblGrandTotal" runat="server" meta:resourcekey="lblGrandTotalResource1" />
                                </td>
                            </tr>
                            <tr style="display:none">
                                <td align="right" valign="Middle">
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
                                    <asp:Label ID="Rs_Amount" Text="Amount" runat="server" meta:resourcekey="Rs_AmountResource1" />
                                    :
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblAmountRecieved" runat="server" Style="font-weight: 700" meta:resourcekey="lblAmountRecievedResource1" />
                                </td>
                            </tr>
                            <tr runat="server" id="trDue">
                                <td align="right" valign="Middle">
                                    <asp:Label ID="lblCurrentVisitDueLabel" Text="Due" runat="server" meta:resourcekey="lblCurrentVisitDueLabelResource1"></asp:Label>
                                    &nbsp;:
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblCurrentVisitDueText" runat="server" meta:resourcekey="lblCurrentVisitDueTextResource1" />
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td colspan="7">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td style="padding-top: 5px;">
                                                <asp:Label ID="Rs_PaymentMode" Font-Bold="True" runat="server" Text="Payment Mode"
                                                    meta:resourcekey="Rs_PaymentModeResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="lblPaymentMode" meta:resourcekey="lblPaymentModeResource1"></asp:Label>
                                                <span id="lblPayMode" runat="server"></span>
                                            </td>
                                        </tr>
                                        <tr id="trDeposit" runat="server" style="display: table-row">
                                            <td>
                                                <asp:Label Visible="False" ID="lblDepositAmtUsed" runat="server" meta:resourcekey="lblDepositAmtUsedResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="lblOtherCurrency" meta:resourcekey="lblOtherCurrencyResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
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
                    <td colspan="7" align="left">
                        <asp:Label ID="lblDisplayAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblDisplayAmountResource1"></asp:Label>
                        <asp:Label ID="lblAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblAmountResource1"></asp:Label>
                    </td>
                </tr>
                <tr id="trPayingCurrency" runat="server" style="display: none">
                    <td colspan="7" align="left">
                        <asp:Label ID="lblPayingCurrency" runat="server" Style="font-weight: 700" meta:resourcekey="lblPayingCurrencyResource1"></asp:Label>
                        <asp:Label ID="lblPayingCurrencyinWords" runat="server" Style="font-weight: 700"
                            meta:resourcekey="lblPayingCurrencyinWordsResource1"></asp:Label>
                    </td>
                </tr>
                <tr id="trDueWords" runat="server">
                    <td colspan="7" align="left">
                        <asp:Label ID="lblDueAmountinWords" runat="server" Style="font-weight: 700" meta:resourcekey="lblDueAmountinWordsResource1"></asp:Label>
                        <asp:Label ID="lblDueAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblDueAmountResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="76" align="right">
                        <asp:Label ID="lblBilledBy" runat="server" meta:resourcekey="lblBilledByResource1" />
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

<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />
