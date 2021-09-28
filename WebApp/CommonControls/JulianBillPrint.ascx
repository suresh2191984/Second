<%@ Control Language="C#" AutoEventWireup="true" CodeFile="JulianBillPrint.ascx.cs"
    Inherits="CommonControls_JulianBillPrint" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<%@ Register Src="FinalBillHeader.ascx" TagName="FinalBillHeader" TagPrefix="uc3" %>
<style type="text/css">
    .style1
    {
        width: 10px;
    }
    tHead
    {
        display: table-header-group;
    }
    .style2
    {
        height: 3px;
    }
</style>

<script type="text/javascript" language="javascript">
    function AddTHEAD() {
        var table = document.getElementById('<%=tblBillPrint.ClientID %>');
        if (table != null) {
            var head = document.createElement("THEAD");
            head.style.display = "table-header-group";
            head.appendChild(table.rows[0]);
            table.insertBefore(head, table.childNodes[0]);

        }
    }
    window.onload = AddTHEAD;

</script>

<table width="100%" id="tblBillPrint" align="center" style="font-family: Verdana;
    font-size: 13px; border-style: solid; border-width: 1px;" runat="server">
    <%--<tr>
        <td align="center">
            Home
        </td>
    </tr>--%>
    <tr>
        <td>
            <table width="100%" id="tblHead" runat="server" border="0" cellspacing="1" cellpadding="2"
                align="center">
                <tr>
                    <td colspan="2" align="center">
                        <asp:Image ID="imgBillLogo" runat="server" Visible="False" meta:resourcekey="imgBillLogoResource2" />
                    </td>
                </tr>
                <tr>
                    <td colspan="5" align="center">
                        <label style="font-family: Verdana; font-size: 14px;" id="lblHospitalName" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="7" id="tdDupBill" runat="server" align="center" style="display:none;">
                                   <%-- <asp:Label ID="lblTypeBill" Style="font-weight: bold;" runat="server" meta:resourcekey="lblTypeBillResource2"></asp:Label>--%>
                                    <asp:Label ID="lblDupBill" Style="font-weight: bold;" Text="(Duplicate Copy)" Visible="False"
                                        runat="server" meta:resourcekey="lblDupBillResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="7">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <%--<td align="right" nowrap="nowrap">
                                    Bill No
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 23%">
                                    <asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>--%>
                                
                                <td align="left" nowrap="nowrap" style="width: 10%">
                                    <asp:Label ID="Rs_PatientNo" Text="Patient No" runat="server" meta:resourcekey="Rs_PatientNoResource1" />
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 25%;">
                                    <span style="width: 23%">
                                        <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700;" meta:resourcekey="lblPatientNumberResource2"></asp:Label>
                                    </span>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 10%">
                                    <asp:Label ID="Rs_BillDate" Text="Date" runat="server" meta:resourcekey="Rs_BillDateResource2" />
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%">
                                    &nbsp;:
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 25%;">
                                    <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceDateResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" meta:resourcekey="Rs_PatientNameResource2" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <span style="width: 23%">
                                    <asp:Label ID="lblTitleName" runat="server" Style="font-weight: 700"></asp:Label>
                                        <asp:Label ID="lblName" runat="server" Style="font-weight: 700" meta:resourcekey="lblNameResource2"></asp:Label>
                                    </span>
                                </td>
                                <td align="left" nowrap="nowrap" style="display: none">
                                    <asp:Label ID="Rs_BillNo" Text="Bill No" runat="server" meta:resourcekey="Rs_BillNoResource2" />
                                </td>
                                <td align="left" nowrap="nowrap" style="display: none">
                                    &nbsp;:&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 23%; display: none">
                                    <asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceNoResource2"></asp:Label>
                                </td>
                                <%--<td align="right" nowrap="nowrap">
                                    Patient No
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;:&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <span style="width: 23%">
                                        <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700"></asp:Label>
                                    </span>
                                </td>--%>
                            </tr>
                            <tr>
                                
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="PatientAge" Text="Patient Age" runat="server" meta:resourcekey="PatientAgeResource2" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblAge" runat="server" Style="font-weight: 700" meta:resourcekey="lblAgeResource2"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblContactNotxt" Text="Patient Contact No" runat="server" 
                                        meta:resourcekey="lblContactNotxtResource1" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp;:
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 23%">
                                    <asp:Label ID="lblContactNo" runat="server" Style="font-weight: 700" 
                                        meta:resourcekey="lblContactNoResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                
                                <td align="left" nowrap="nowrap" valign="top">
                                    <asp:Label ID="Rs_sex" Text="Sex" runat="server" meta:resourcekey="Rs_sexResource1" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style1" valign="top">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap" valign="top">
                                    <asp:Label ID="lblSex" runat="server" Style="font-weight: 700" meta:resourcekey="lblSexResource2"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" valign="top">
                                    <asp:Label ID="lblAddrtxt" Text="Patient Address" runat="server" 
                                        meta:resourcekey="lblAddrtxtResource1" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style1" valign="top">
                                    &nbsp;:
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 23%" valign="top">
                                    <asp:Label ID="lblAddr" runat="server" Style="font-weight: 700" 
                                        meta:resourcekey="lblAddrResource1"></asp:Label>
                                </td>
                            </tr>
                            <%-- <tr>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                              <tr>
                                <td style="width: 7%">
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblContactNotxt" Text="Patient Contact No" runat="server"/>
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 23%">
                                    <asp:Label ID="lblContactNo" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>--%>
                            <tr>
                                <div id="phyDetails" runat="server">
                                    
                                    <td align="right" nowrap="nowrap">
                                        <asp:Label runat="server" ID="lblPhy" Text="Ref. Physician Name" meta:resourcekey="lblPhyResource2"></asp:Label>
                                    </td>
                                    <td align="left" nowrap="nowrap" class="style1">
                                        &nbsp; :
                                    </td>
                                    <td align="left" nowrap="nowrap">
                                        <asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700" meta:resourcekey="lblPhysicianResource2"></asp:Label>
                                    </td>
                                </div>
                                <td align="left" nowrap="nowrap">
                                </td>
                                <td align="left" nowrap="nowrap">
                                </td>
                                <td align="left" nowrap="nowrap">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" align="center">
                                    <uc3:FinalBillHeader ID="FinalBillHeader1" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:GridView ID="gvBillingDetail" runat="server" Width="100%" AutoGenerateColumns="False"
                            BorderStyle="Solid" BorderColor="#B6A8A8" BorderWidth="1px" OnRowDataBound="gvBillingDetail_RowDataBound"
                            meta:resourcekey="gvBillingDetailResource2">
                            <Columns>
                                <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" Text='<%# Bind("FeeDescription") %>' runat="server"
                                            meta:resourcekey="lblDescriptionResource2"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField ItemStyle-Width="15%" DataField="ServiceCode"  HeaderText="ServiceCode"
                                    meta:resourcekey="BoundFieldResource4">
                                    <ItemStyle Width="15%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField ItemStyle-Width="10%" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center"
                                    HeaderText="Units" DataField="Quantity" meta:resourcekey="BoundFieldResource5">
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField ItemStyle-Width="12%" DataField="Amount" HeaderText="Amount" DataFormatString="{0:F2}"
                                    ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource6">
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle Font-Bold="True" ForeColor="Black" />
                        </asp:GridView>
                    </td>
                </tr>
                <%--     <tr>
                    <td colspan="6">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr valign="top">
                                <td style="width: 30%">
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
                                <td align="right" style="width: 70%">
                                    <table border="0" cellpadding="0" cellspacing="0" style="border-color: #000000">
                                        <tr>
                                            <td align="right" valign="Middle">
                                                <asp:Label ID="Rs_GrossAmount" Text="Gross Amount" runat="server" meta:resourcekey="Rs_GrossAmountResource2" />
                                                :
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblGrossAmount" runat="server" meta:resourcekey="lblGrossAmountResource2" />
                                            </td>
                                        </tr>
                                        <tr style="display: none;">
                                            <td align="right" valign="Middle">
                                                <asp:Label ID="Rs_DeductionAmount" Text="Deduction Amount" runat="server" meta:resourcekey="Rs_DeductionAmountResource2" />
                                                :
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblDeduction" runat="server" meta:resourcekey="lblDeductionResource2" />
                                            </td>
                                        </tr>
                                        <tr id="trServiceCharge" style="display: none;" runat="server">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server" meta:resourcekey="Rs_ServiceChargeResource2" />
                                                :
                                            </td>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblServiceCharge" runat="server" meta:resourcekey="lblServiceChargeResource2" />
                                            </td>
                                        </tr>
                                         <tr id="trTaxAmount" style="display: none;" runat="server">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblTaxAmounttxt" Text="Tax Amount" runat="server"/>
                                                :
                                            </td>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblTaxAmount" runat="server"/>
                                            </td>
                                        </tr>
                                        <tr id="trDiscount" style="display: none;" runat="server">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblDiscountPercent" runat="server" meta:resourcekey="lblDiscountPercentResource2" />&nbsp;Discount
                                                (-) :
                                            </td>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblDiscount" runat="server" meta:resourcekey="lblDiscountResource2" />
                                            </td>
                                        </tr>
                                        <tr id="trRoundoff" style="display: none;" runat="server">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="Rs_RoundOffAmount" Text="Round Off Amount" runat="server" meta:resourcekey="Rs_RoundOffAmountResource2" />
                                                :
                                            </td>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblRoundOff" runat="server" Text="0.00" meta:resourcekey="lblRoundOffResource2" />
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
                                                <asp:Label ID="Rs_GrandTotal" Text="Grand Total" runat="server" meta:resourcekey="Rs_GrandTotalResource2" />
                                                :
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblGrandTotal" runat="server" meta:resourcekey="lblGrandTotalResource2" />
                                            </td>
                                        </tr>
                                        <tr id="trPreviousDue" style="display: none" runat="server">
                                            <td align="right" valign="Middle">
                                                <asp:Label ID="Rs_PreviousDue" Text="Previous Due" runat="server" meta:resourcekey="Rs_PreviousDueResource2" />
                                                :
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblPreviousDue" runat="server" meta:resourcekey="lblPreviousDueResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="2" valign="Middle">
                                                -----------------------------------
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="Rs_NetAmount" Text="Net Amount" runat="server" meta:resourcekey="Rs_NetAmountResource2" />
                                                :
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblNetValue" runat="server" Style="font-weight: 700" meta:resourcekey="lblNetValueResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="middle" colspan="2">
                                                -----------------------------------
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="Rs_AmountReceived" Text="Amount Received" runat="server" meta:resourcekey="Rs_AmountReceivedResource2" />
                                                :
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblAmountRecieved" runat="server" Style="font-weight: 700" meta:resourcekey="lblAmountRecievedResource2" />
                                            </td>
                                        </tr>--%>
                <table cellpadding="0" style="display: none" cellspacing="0" border="0" width="100%">
                    <tr id="trDue" runat="server" style="display: none">
                        <td align="right" valign="middle">
                            <asp:Label ID="lblCurrentVisitDueLabel" Text="Due" runat="server" meta:resourcekey="lblCurrentVisitDueLabelResource2"></asp:Label>
                            &nbsp;:
                        </td>
                        <td align="right">
                            <asp:Label ID="lblCurrentVisitDueText" runat="server" meta:resourcekey="lblCurrentVisitDueTextResource2" />
                        </td>
                    </tr>
                </table>
                <%--</td>
                            </tr>
                         
                            <tr>
                                <td colspan="6" align="left">
                                    <asp:Label ID="lblrefundamt" runat="server" Visible="False" Style="font-weight: 700"
                                        meta:resourcekey="lblrefundamtResource2"></asp:Label>
                                </td>
                            </tr>--%>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr valign="top" id="trPrescription" runat="server" style="display:none;">
                    <td colspan="6">
                        <table width="100%" border="0" style="height: 350px">
                          <tr>
                                <td valign="top" class="style2">
                                    <asp:Label ID="lblPrescription" Text="Prescription" runat="server" Font-Bold="True"
                                        Font-Underline="True" meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                                </td>
                            </tr>
                            
                            <tr>
                            <td valign="top">
                            <asp:GridView ID="grdpp" runat="server" AutoGenerateColumns="false" Width="100%">
                                <Columns>
                                    <%--<asp:BoundField HeaderText="Formulation" DataField="Formulation" />--%>
                                    <asp:BoundField HeaderText="BrandName" DataField="BrandName" />
                                    <asp:BoundField HeaderText="Dose" DataField="Dose"  />
                                    <asp:BoundField HeaderText="DrugFrequency" DataField="DrugFrequency" />
                                    <asp:BoundField HeaderText="Duration" DataField="Duration" />
                                    <asp:BoundField HeaderText="Instruction" DataField="Instruction"/>
                                </Columns>
                            </asp:GridView>
                                <%--<td style="height:20px">
                                    <asp:Label ID="lblno" Text="" runat="server" Font-Bold="True"
                                       meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                                </td>
                                <td style="height:20px">
                                    <asp:Label ID="lblFormulation" Text="" runat="server" Font-Bold="True"
                                       meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                                </td>
                                <td style="height:20px">
                                    <asp:Label ID="lblBrandName" Text="" runat="server" Font-Bold="True"
                                       meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblDose" Text="" runat="server" Font-Bold="True"
                                       meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                                </td>
                                <td style="height:20px">
                                    <asp:Label ID="lblDrugFrequency" Text="" runat="server" Font-Bold="True"
                                       meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                                </td>
                                <td style="height:20px">
                                    <asp:Label ID="lblDuration" Text="" runat="server" Font-Bold="True"
                                       meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                                </td>
                                <td style="height:20px">
                                    <asp:Label ID="lblRoa" Text="" runat="server" Font-Bold="True"
                                       meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                                </td>--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="height: 50px">
                        &nbsp;
                    </td>
                </tr>
               <%-- <tr>
                    <td colspan="6" align="right">
                        <asp:Label ID="lblBilledBy" runat="server" meta:resourcekey="lblBilledByResource2" />
                    </td>
                </tr>--%>
            </table>
        </td>
    </tr>
</table>
<%--</td> </tr> </table>--%>
<asp:HiddenField ID="hdnPayingCurrency" runat="server" />
<asp:HiddenField ID="hdnDiscount" runat="server" />
<asp:HiddenField ID="hdnServiceCharge" runat="server" />
<asp:HiddenField ID="hdnTaxAmount" runat="server" />
<asp:HiddenField ID="hdnPreviousDue" runat="server" />
<asp:HiddenField ID="hdnDue" runat="server" />
<asp:HiddenField ID="hdnRoundoff" runat="server" />
<asp:HiddenField ID="hdnRound" runat="server" />
<asp:HiddenField ID="hdfRoundcalc" runat="server" Value="0" />
<asp:HiddenField ID="hdnRoundAmt" runat="server" />

<script type="text/javascript" language="javascript">

</script>

<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />
