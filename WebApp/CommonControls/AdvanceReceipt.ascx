<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdvanceReceipt.ascx.cs"
    Inherits="CommonControls_AdvanceReceipt" %>

<style type="text/css">
    .style1
    {
        height: 23px;
    }
</style>

<script language="javascript">

    function fnCallPrint(pControlsvalues) {
        var prtContent = document.getElementById(pControlsvalues);
//        prtContent.style.display = "block";
        var WinPrint = window.open('', '', 'left=-1,top=-1,width=10,height=10,toolbar=0,scrollbars=0,status=0');
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();

    }
</script>

<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<table width="100%" align="center" border="0" id="tblBillPrint" runat="server">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" style="font-family: Verdana;" cellpadding="0"
                align="center" id="tbl1" runat="server">
                <tr>
                    <td colspan="7" align="center">
                        <asp:Image ID="imgBillLogo" runat="server" Visible="False" meta:resourcekey="imgBillLogoResource1" />
                    </td>
                </tr>
                <tr>
                    <td colspan="7" align="center">
                        <label style="font-family: Arial; font-size: medium;" id="lblHospitalName" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="7" align="center" id="tdReceiptType" runat="server">
                        <asp:Label ID="Rs_PaymentReceipt" runat="server" Text="Payment Receipt" meta:resourcekey="Rs_PaymentReceiptResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <table border="0" width="100%" cellspacing="3" cellpadding="3" style="font-family: Verdana;">
                            <tr>
                                <td>
                                    <asp:Label ID="Rs_PatientNo" Text="Patient No" runat="server" meta:resourcekey="Rs_PatientNoResource1" />
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblPatientNo" runat="server" Style="font-weight: 400;" meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="Rs_Date" Text="Date" runat="server" meta:resourcekey="Rs_DateResource2" />
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 400;" meta:resourcekey="lblInvoiceDateResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" meta:resourcekey="Rs_PatientNameResource1" />
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblName" runat="server" Style="font-weight: 400;" meta:resourcekey="lblNameResource2"></asp:Label>
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="Rs_ReceiptNumber" Text="Receipt Number" runat="server" meta:resourcekey="Rs_ReceiptNumberResource2" />
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblReceiptNo" runat="server" Style="font-weight: 400;" meta:resourcekey="lblReceiptNoResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Rs_AgeandSex" Text="Age/Sex" runat="server" meta:resourcekey="Rs_AgeandSexResource1" />
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblAge" runat="server" Style="font-weight: 400;" meta:resourcekey="lblAgeResource1"></asp:Label>
                                </td>
                                <td id="tdlabno" nowrap="nowrap" align="left">
                                    <asp:Label ID="labNumber" Text="Lab Number" runat="server" style="display:none;" />
                                </td>
                                <td id="tdComma" style="display:none;" runat="server">
                                    :
                                </td>
                                <td id="tdlabno1" runat="server">
                                    <asp:Label ID="lblAdLabno" runat="server" Style="font-weight: 400;display:none;"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Rs_PaidDate" Text="Paid Date" runat="server" meta:resourcekey="Rs_PaidDateResource2" />
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblPaidDate" runat="server" Style="font-weight: 400;" meta:resourcekey="lblPaidDateResource2"></asp:Label>
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label runat="server" ID="lblrefPhyH" Text="Referring Physician" meta:resourcekey="lblrefPhyHResource2"></asp:Label>
                                </td>
                                <td id="refphy" runat="server">
                                    :
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblRefPhy" meta:resourcekey="lblRefPhyResource2"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="7" style="font-weight: bold;">
                        <asp:Label ID="Rs_PaymentDetails" runat="server" Text="Payment Details:" meta:resourcekey="Rs_PaymentDetailsResource1"></asp:Label>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td colspan="7" align="center">
                        <div id="dvAdvance" runat="server" align="center">
                            <asp:Label ID="lblAmountType" runat="server" Text="Advance Payment" meta:resourcekey="lblAmountTypeResource1"></asp:Label>
                        </div>
                        <div id="dvGenerateBill" runat="server" visible="false" align="center">
                            <asp:Label ID="lblGenerateBillAmt" runat="server" meta:resourcekey="lblGenerateBillAmtResource1"></asp:Label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <div id="dvDetails" runat="server">
                            <asp:GridView ID="gvIndents" CellPadding="3" runat="server" AutoGenerateColumns="False"
                                GridLines="None" Width="100%" Font-Names="Verdana" meta:resourcekey="gvIndentsResource2">
                                <HeaderStyle CssClass="dataheader1" />
                                <PagerStyle CssClass="dataheader1" />
                                <Columns>
                                    <%--  <asp:BoundField HeaderText="Description" DataField="Description">
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </asp:BoundField>--%>
                                    <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:Label ID="chkID" runat="server" Style="text-align: left;" Text='<%# Eval("FeeDescription") %>'
                                                meta:resourcekey="chkIDResource2" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Date" DataField="FromDate" DataFormatString="{0:dd/MM/yyyy}"
                                        meta:resourcekey="BoundFieldResource1">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="UnitPrice" meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:Label ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                Text='<%# Eval("Amount") %>'    onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                                meta:resourcekey="txtUnitPriceResource2"></asp:Label>
                                            <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("Amount") %>' runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Quantity" meta:resourcekey="TemplateFieldResource3">
                                        <ItemTemplate>
                                            <asp:Label ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                Text='<%# Eval("Quantity") %>'    onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                                meta:resourcekey="txtQuantityResource2"></asp:Label>
                                            <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("Quantity") %>' runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount" meta:resourcekey="TemplateFieldResource4">
                                        <ItemTemplate>
                                            <asp:Label ID="txtAmount" runat="server" Style="text-align: right;" ReadOnly="true"
                                                Text='<%# NumberConvert(Eval("Quantity"),Eval("Amount")) %>' Width="60px" meta:resourcekey="txtAmountResource2"></asp:Label>
                                            <asp:HiddenField ID="hdnAmount" runat="server" />
                                            <headerstyle horizontalalign="Center" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        &nbsp;&nbsp;
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="width: 30%">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td style="padding-top: 5px;" class="style1">
                                                <b>
                                                    <asp:Label ID="Rs_PaymentMode" runat="server" Text="Payment Mode" meta:resourcekey="Rs_PaymentModeResource1"></asp:Label></b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="lblPaymentMode" meta:resourcekey="lblPaymentModeResource1"></asp:Label>
                                                <span id="lblPayMode" runat="server"></span>
                                            </td>
                                        </tr>
                                        <tr id="trDeposit" runat="server" style="display: block">
                                            <td>
                                                <asp:Label Visible="False" ID="lblDepositAmtUsed" runat="server" meta:resourcekey="lblDepositAmtUsedResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 100%">
                                    <table cellpadding="2" cellspacing="2" border="0" width="100%">
                                        <tr>
                                            <td style="width:95%" align="right">
                                                <asp:Label ID="Rs_Total" runat="server" Text="Total :" meta:resourcekey="Rs_TotalResource1"></asp:Label>
                                                
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblTotal" runat="server" meta:resourcekey="lblTotalResource1" />
                                            </td>
                                        </tr>
                                        <tr id="trRoundOffAmount" runat="server">
                                            <td align="right">
                                                <asp:Label ID="lblRoundOffAmount" runat="server" Text="Round Off Amount :" meta:resourcekey="lblRoundOffAmountResource1" ></asp:Label>
                                                
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblRoundOffAmountText" runat="server" Text="0.00" />
                                            </td>
                                        </tr>
                                        <tr id="trAlreadduepaidamt" runat="server" style="display:none;">
                                            <td align="right">
                                                <asp:Label ID="lblAlreadyDuePaidAmount" runat="server" Text="Already Due Paid Amount :" meta:resourcekey="lblAlreadyDuePaidAmountResource1"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblAlreadyDuePaidAmountText" runat="server" Text="0.00" />
                                            </td>
                                        </tr>
                                        <tr id="trPreviousDuecollection" runat="server" style="display:none;">
                                            <td align="right">
                                                <asp:Label ID="PreviousDueCollectionAmt" runat="server" Text="Previously Amount Collected:" meta:resourcekey="PreviousDueCollectionAmtResource1"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblPreviousDueCollectionAmtText" runat="server" Text="0.00" />
                                            </td>
                                        </tr>
                                        
                                        <tr id="trdiscountamount" runat="server" style="display:none;" >
                                            <td align="right">
                                                <asp:Label ID="lblDiscountAmounttxt" Text="Discount Amount" runat="server" meta:resourcekey="lblDiscountAmounttxtResource1" />:
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblDiscountAmount" Text="0.00" runat="server" />
                                            </td>
                                        </tr>
										 <tr id="trwriteofamount" runat="server" style="display: none">
                                            <td align="right">
                                                <asp:Label ID="lblWriteOfAmounttxt" Text="Write Off Amount" runat="server" />:
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblWriteofAmount" Text="0.00" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="Rs_AmountReceived" Text="Amount Received" runat="server" meta:resourcekey="Rs_AmountReceivedResource1" />:
                                                
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblAmountRecieved" runat="server" meta:resourcekey="lblAmountRecievedResource2" />
                                            </td>
                                        </tr>
                                         <tr>
                                            <td align="right" id="tdDueAmountlbl" runat="server" >
                                                <asp:Label ID="lblRemainingDue" Text="RemainingDue Amount" runat="server" meta:resourcekey="lblRemainingDueResource1" />:
                                            </td>
                                            <td align="right" id="tdDueAmounttxt" runat="server">
                                                <asp:Label ID="lblRemainingDuevalue" runat="server" Text="0.00" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" id="tdWriteOffAmtlbl" runat="server" style="display:none;">
                                                <asp:Label ID="lblWriteOffAmt" Text="Write-Off Amount :" runat="server" />
                                            </td>
                                            <td align="right" id="tdWriteOffAmttxt" runat="server" style="display:none;" >
                                                <asp:Label ID="lblWriteOffAmt1" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trPreviousReceipt" runat="server" style="display: none;">
                    <td colspan="7">
                        <asp:Label ID="lblFinalReceiptAmount" runat="server" Text="0.00" meta:resourcekey="lblFinalReceiptAmountResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <asp:Label runat="server" ID="lblOtherCurrency" meta:resourcekey="lblOtherCurrencyResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:Label ID="lblPayingCurrency" runat="server" meta:resourcekey="lblPayingCurrencyResource1"></asp:Label>
                        <asp:Label ID="lblPayingCurrencyinWords" runat="server" meta:resourcekey="lblPayingCurrencyinWordsResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <asp:Label ID="Rs_AmountinWords" Text="Amount in Words" runat="server" meta:resourcekey="Rs_AmountinWordsResource1" />:
                        <asp:Label ID="lblCurrency" runat="server" meta:resourcekey="lblCurrencyResource2" />-<asp:Label
                            ID="lblAmount" runat="server" meta:resourcekey="lblAmountResource2"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <asp:Label ID="lblBilledBy" runat="server" meta:resourcekey="lblBilledByResource1" />
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <div id="dvDisclaimer" runat="server">
                            <asp:Label ID="Rs_Disclaimer" Text="Disclaimer" runat="server" meta:resourcekey="Rs_DisclaimerResource2" />:
                            <asp:Label ID="Rs_info" Text=" This is only an cash&nbsp; receipt. This receipt cannot
                            be used for claiming purpose." runat="server" meta:resourcekey="Rs_infoResource1" />
                        </div>
                    </td>
                </tr>
                <tr>
                   
                    <td colspan="7" style="display: none;" width="100%" runat="server" id="tdPrint" enableviewstate="false">
                    </td>
                </tr>
                <tr>
                <td colspan="7" align="center">
            
                </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<input type="hidden" id="hdnpaymode" runat="server" />
