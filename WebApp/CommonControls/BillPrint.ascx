<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BillPrint.ascx.cs" Inherits="Billing_BillPrint" %>
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
        height: 18px;
    }
    .style3
    {
        width: 613px;
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

<script runat="server">
    string _date;
    string GetDate(string Date)
    {
        if (Date != "01/Jan/1900")
        {
            _date = Date;
        }
        else
        {
            _date = " ";
        }
        return _date;
    }
</script>

<table id="tblBillPrint" style="font-family: Verdana;" runat="server" class="w-100p font10 a-center">
    <%--<tr>
        <td align="center">
            Home
        </td>
    </tr>--%>
    <tr id="tbprint" runat="server">
        <td>
            <table width="100%" id="tblHead" runat="server" border="0" cellspacing="0" cellpadding="0"
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
                    <td id="tblPatientDetails" runat="server" colspan="6">
                        <table class="w-100p">
                            <tr>
                                <td colspan="7" id="tdDupBill" runat="server" align="center" style="display: none;">
                                    <asp:Label ID="lblTypeBill" Style="font-weight: bold;" runat="server" meta:resourcekey="lblTypeBillResource2"></asp:Label>
                                    <asp:Label ID="lblDupBill" Style="font-weight: bold;" Text="(Duplicate Copy)" Visible="False"
                                        runat="server" meta:resourcekey="lblDupBillResource2"></asp:Label>
                                </td>
                                <td id="tdBarcode" runat="server" visible="false" colspan="7" align="right" width="15%">
                                    <asp:Image ID="imgBarcode" runat="server" meta:resourcekey="imgBarcodeResource1" />
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
                                <td class="w-7p">
                                </td>
                                <td align="left" nowrap="nowrap" class="w-10p">
                                    <asp:Label ID="Rs_PatientNo" Text="Patient No" runat="server" meta:resourcekey="Rs_PatientNoResource1" />
                                </td>
                                <td align="left" nowrap="nowrap" class="w-3p">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap" class="w-25p">
                                    <span>
                                        <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700;" meta:resourcekey="lblPatientNumberResource2"></asp:Label>
                                    </span>
                                </td>
                                <td align="left" nowrap="nowrap" class="w-10p">
                                    <asp:Label ID="Rs_BillDate" Text="Bill Date" runat="server" meta:resourcekey="Rs_BillDateResource2" />
                                </td>
                                <td align="left" nowrap="nowrap" class="w-3p">
                                    &nbsp;:
                                </td>
                                <td align="left" nowrap="nowrap" class="w-25p">
                                    <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceDateResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left" colspan="7">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" meta:resourcekey="Rs_PatientNameResource2" />
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <span>
                                        <asp:Label ID="lblTitleName" runat="server" Style="font-weight: 700" meta:resourcekey="lblTitleNameResource1"></asp:Label>
                                        <asp:Label ID="lblName" runat="server" Style="font-weight: 700" meta:resourcekey="lblNameResource2"></asp:Label>
                                        <asp:Label ID="lblQualification" runat="server" Style="font-weight: 700" 
                                        meta:resourcekey="lblQualificationResource1"></asp:Label>
                                    </span>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_BillNo" Text="Bill No" runat="server" meta:resourcekey="Rs_BillNoResource2" />
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;:&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
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
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="Tr1" visible="true" runat="server">
                                <td>
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="PatientAge" Text="Patient Age" runat="server" meta:resourcekey="PatientAgeResource2" />
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblAge" runat="server" Style="font-weight: 700" meta:resourcekey="lblAgeResource2"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" id="trLabNo" runat="server" visible="false">
                                    <asp:Label ID="lLabNo" Text="Lab No" runat="server" 
                                        meta:resourcekey="lLabNoResource1" />
                                    <asp:Label ID="Rs_VisitNumber" Text="/Visit No" runat="server" Visible="False" 
                                        meta:resourcekey="Rs_VisitNumberResource1" />
                                    <asp:Label ID="RS_RefBillNo" Text="Due Receipt No" runat="server" 
                                        Visible="False" meta:resourcekey="RS_RefBillNoResource1" />
                                </td>
                                <td align="left" nowrap="nowrap" id="trLabNo1" runat="server" visible="false">
                                    &nbsp;:&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" id="trLabNo2" runat="server" visible="false">
                                    <asp:Label ID="lblLabNo" runat="server" Style="font-weight: 700" meta:resourcekey="lblLabNoResource1"></asp:Label>
                                    <asp:Label ID="lblVisitNumber" runat="server" Style="font-weight: 700" Visible="False"
                                        meta:resourcekey="lblVisitNumberResource1"></asp:Label>
                                    <asp:Label ID="RS_RbillNo" runat="server" Style="font-weight: 700" 
                                        Visible="False" meta:resourcekey="RS_RbillNoResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_sex" Text="Sex" runat="server" meta:resourcekey="Rs_sexResource1" />
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblSex" runat="server" Style="font-weight: 700" meta:resourcekey="lblSexResource2"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_PatPhoneNo" Text="Pat.Phone No" runat="server" meta:resourcekey="Rs_PatPhoneNoResource1" />
                                </td>
                                <td id="trmodbdot" runat="server" align="left" nowrap="nowrap">
                                    &nbsp;:&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblPatPhoneNumber" runat="server" Style="font-weight: 700" meta:resourcekey="lblPatPhoneNumberResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="7" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="phyDetails" runat="server">
                                <td>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label runat="server" ID="lblPhy" Text="Ref. Physician Name" 
                                        meta:resourcekey="lblPhyResource1"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700" 
                                        meta:resourcekey="lblPhysicianResource1"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblRefHos" Text="Referring Hos" runat="server" 
                                        meta:resourcekey="lblRefHosResource1" />
                                </td>
                                <td id="trduedot" runat="server" align="left" nowrap="nowrap">
                                    :
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblReferringHos" runat="server" Style="font-weight: 700" 
                                        meta:resourcekey="lblReferringHosResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="tBookingNo" runat="server" style="display: none;">
                                <td>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label runat="server" ID="Label4" Text="Booking No" 
                                        meta:resourcekey="Label4Resource1"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblBookingNo" runat="server" Style="font-weight: 700" 
                                        meta:resourcekey="lblBookingNoResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="7" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trFinalBillHeader" runat="server" style="display: none;">
                                <td colspan="7" align="center">
                                    <uc3:FinalBillHeader ID="FinalBillHeader1" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <%--<tr>
                    <td colspan="6" style="text-decoration: Underline;">
                        Billing Details
                    </td>
                </tr>--%>
                <tr>
                    <td colspan="6">
                        <asp:GridView ID="gvBillingDetail" runat="server" Width="100%" AutoGenerateColumns="False"
                            BorderStyle="Solid" BorderColor="#B6A8A8" BorderWidth="1px" OnRowDataBound="gvBillingDetail_RowDataBound"
                            meta:resourcekey="gvBillingDetailResource2">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No" ItemStyle-Width="4%" meta:resourcekey="TemplateFieldResource101">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill No" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBillNumber" Text='<%# Bind("BillNumber") %>' runat="server" meta:resourcekey="lblBillNumberResource1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description" HeaderStyle-Width="25%" 
                                    meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" Text='<%# Bind("FeeDescription") %>' runat="server"
                                            meta:resourcekey="lblDescriptionResource2"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Split Description" 
                                    meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSplitDescription" Text='<%# Bind("Address") %>' 
                                            runat="server" meta:resourcekey="lblSplitDescriptionResource1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField ItemStyle-Width="15%" DataField="ServiceCode" HeaderText="Service Code"
                                    meta:resourcekey="BoundFieldResource4">
                                    <ItemStyle Width="15%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField ItemStyle-Width="8%" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center"
                                    HeaderText="Units" DataField="Quantity" meta:resourcekey="BoundFieldResource5">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Report Date" ItemStyle-Width="15%" 
                                    meta:resourcekey="TemplateFieldResource4">
                                    <ItemTemplate>
                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "ModifiedAt", "{0:dd/MMM/yyyy}").ToString())%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField ItemStyle-Width="12%" DataField="Amount" HeaderText="Amount" DataFormatString="{0:F2}"
                                    ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource6">
                                    <HeaderStyle HorizontalAlign="Center" Width="5%" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle Font-Bold="True" ForeColor="Black" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr valign="top">
                                <td width="50%">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%" id="PaymentModeDetails"
                                        runat="server">
                                        <tr>
                                            <td style="padding-top: 5px;">
                                                <asp:Label Font-Bold="True" ID="lblPayment" Text="Payment Mode" runat="server" meta:resourcekey="lblPaymentResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="lblPaymentMode" meta:resourcekey="lblPaymentModeResource2"></asp:Label>
                                                <span id="lblPayMode" runat="server">&nbsp;
                                                    <asp:Label Visible="False" ID="lblDepositAmtUsed" runat="server" meta:resourcekey="lblDepositAmtUsedResource2"></asp:Label>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr id="trDeposit" runat="server" style="display: table-row">
                                            <td>
                                                <asp:Label ID="lblPaymentremark" CssClass="clsWrap" Width="500px" runat="server"
                                                    meta:resourcekey="lblPaymentModeResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trDeposit1" runat="server" style="display: table-row">
                                            <td class="style5">
                                                &nbsp;
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
                                    <table border="0" cellpadding="0" cellspacing="0" style="border-color: #000000" id="AmountPayDetails"
                                        runat="server">
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
                                                <asp:Label ID="lblTaxAmounttxt" Text="Tax Amount" runat="server" meta:resourcekey="lblTaxAmounttxtResource1" />
                                                :
                                            </td>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblTaxAmount" runat="server" meta:resourcekey="lblTaxAmountResource1" />
                                            </td>
                                        </tr>
                                        <tr id="trEDCess" style="display: none;" runat="server">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="Rs_EDCess" Text="ED Cess" runat="server" meta:resourcekey="Rs_EDCessResource1" />
                                                :
                                            </td>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblEDCess" runat="server" meta:resourcekey="lblEDCessResource1" />
                                            </td>
                                        </tr>
                                        <tr id="trSHEDCess" style="display: none;" runat="server">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="Rs_SHEDCess" Text="SHED Cess" runat="server" meta:resourcekey="Rs_SHEDCessResource1" />
                                                :
                                            </td>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblSHEDCess" runat="server" meta:resourcekey="lblSHEDCessResource1" />
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
                                            <td align="right" valign="Middle" colspan="2">
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
                                        <tr id="trAmtrevd" runat="server">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="Rs_AmountReceived" Text="Amount Received" runat="server" meta:resourcekey="Rs_AmountReceivedResource2" />
                                                :
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblAmountRecieved" runat="server" Style="font-weight: 700" meta:resourcekey="lblAmountRecievedResource2" />
                                            </td>
                                        </tr>
                                        <tr id="trDue" runat="server" style="display: none">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblCurrentVisitDueLabel" Text="Due" runat="server" meta:resourcekey="lblCurrentVisitDueLabelResource2"></asp:Label>
                                                &nbsp;:
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblCurrentVisitDueText" runat="server" meta:resourcekey="lblCurrentVisitDueTextResource2" />
                                            </td>
                                        </tr>
                                        <tr id="trAmountRevd" runat="server" style="display: none">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="Label2" Text="Amount Refound" runat="server" 
                                                    meta:resourcekey="Label2Resource1"></asp:Label>
                                                &nbsp;:
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblAmountRefound" runat="server" meta:resourcekey="lblCurrentVisitDueTextResource2" />
                                            </td>
                                        </tr>
                                        <tr id="trClaminAmount" runat="server" style="display: none">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="Label3" Text="Clamin Amount" runat="server" 
                                                    meta:resourcekey="Label3Resource1"></asp:Label>
                                                &nbsp;:
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblClaminAmount" runat="server" 
                                                    meta:resourcekey="lblClaminAmountResource1" />
                                            </td>
                                        </tr>
                                        <tr id="trwriteoff" runat="server" style="display: none">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblWriteoff" Text="Writeoff Amount" runat="server" 
                                                    meta:resourcekey="lblWriteoffResource1"></asp:Label>
                                                &nbsp;:
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblCurrentWriteOff" runat="server" Style="font-weight: 700" 
                                                    meta:resourcekey="lblCurrentWriteOffResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" class="style2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="style3">
                                    <table id="TaxDueDetails" runat="server" width="100%">
                                        <tr>
                                            <td colspan="6" align="left">
                                                <asp:Label ID="lblrefundamt" runat="server" Visible="False" Style="font-weight: 700"
                                                    meta:resourcekey="lblrefundamtResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" align="left">
                                                <asp:Label ID="lblDisplayAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblDisplayAmountResource2"></asp:Label>
                                                <asp:Label ID="lblAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblAmountResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <%--<tr>
                                <td colspan="6">
                                    &nbsp;
                                </td>
                            </tr>--%>
                                        <tr id="trPayingCurrency" runat="server" style="display: none">
                                            <td colspan="6" align="left">
                                                <asp:Label ID="lblPayingCurrency" runat="server" Style="font-weight: 700; display: none;"
                                                    meta:resourcekey="lblPayingCurrencyResource2"></asp:Label>
                                                <asp:Label ID="lblPayingCurrencyinWords" runat="server" Style="font-weight: 700;
                                                    display: none;" meta:resourcekey="lblPayingCurrencyinWordsResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" align="left">
                                                <asp:Label ID="lblDueAmountinWords" runat="server" Style="font-weight: 700" meta:resourcekey="lblDueAmountinWordsResource2"></asp:Label>
                                                <asp:Label ID="lblDueAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblDueAmountResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" align="left">
                                                <asp:Label ID="Label1" Visible="False" runat="server" Style="font-weight: 700" meta:resourcekey="Label1Resource2"></asp:Label>
                                                <asp:Label ID="RemainDeposit" Visible="False" runat="server" Style="font-weight: 700"
                                                    meta:resourcekey="RemainDepositResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trTaxDetails" runat="server">
                                            <td colspan="6" align="left">
                                                <asp:Label ID="lblTaxDetails" Visible="False" runat="server" Style="font-weight: 700"
                                                    meta:resourcekey="lblTaxDetailsResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        </table>
                                        </tr>
                                        <tr></tr> 
                                          <tr id="tdUserName" runat="server"   visible="false">
                                         <td colspan="6"  align="right">
                                    <asp:Label ID="lblUserName" Text="User Name:" runat="server" 
                                        meta:resourcekey="lblUserNameResource1" />
                                    <asp:Label ID="lblLoginName" runat="server" 
                                        meta:resourcekey="lblLoginNameResource1" />
                                          </td>
                                        </tr>
                                        <tr id="tbPassword" runat="server" visible="false">
                                         <td colspan="6"  align="right" >
                                   <asp:Label ID="lblPass" Text="Password:" runat="server" Visible="False" 
                                         meta:resourcekey="lblPassResource1"/>
                                    <asp:Label ID="lblPassword" runat="server" 
                                         meta:resourcekey="lblPasswordResource1" />
                                </td>
                                 </tr>
                                   <tr>
                                <td colspan="6" align="left">
                                    &nbsp;
                                    <asp:Label ID="lblURL" Visible="False" Text="To view Patient Report log on to" runat="server" 
                                        meta:resourcekey="lblURLResource1" /> 
                                   <asp:Label ID="lblLoginurl" runat="server" 
                                        meta:resourcekey="lblLoginurlResource1" /> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" align="left">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trReportDate" runat="server">
                                            <td colspan="6" align="left">
                                                <asp:Label ID="lblReportcommitDate" runat="server" meta:resourcekey="lblReportcommitDateResource1"></asp:Label>
                                            </td>
                                        </tr>
                                   
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" align="right">
                                    <asp:Label ID="lblBilledBy" runat="server" meta:resourcekey="lblBilledByResource2" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%" runat="server" style="display: none;" id="tdPrint" enableviewstate="false">
        </td>
    </tr>
</table>
<input type="hidden" id="hdnEDCess" runat="server" value="0" />
<input id="hdnSHEDCess" type="hidden" runat="server" value="0" />
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
<input type="hidden" id="hdnIsRoundOff" value="ON" runat="server" />

<script type="text/javascript" language="javascript">
    if (document.getElementById('<%=hdnPayingCurrency.ClientID %>').value == "1") {
        document.getElementById('<%=trPayingCurrency.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnDiscount.ClientID %>').value == "1") {
        document.getElementById('<%=trDiscount.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnServiceCharge.ClientID %>').value == "1") {
        document.getElementById('<%=trServiceCharge.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnTaxAmount.ClientID %>').value == "1") {
        document.getElementById('<%=trTaxAmount.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnDue.ClientID %>').value == "1") {
        document.getElementById('<%=trDue.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnPreviousDue.ClientID %>').value == "1") {
        document.getElementById('<%=trPreviousDue.ClientID %>').style.display = "none";
    }
    if (document.getElementById('<%=hdnRoundoff.ClientID %>').value == "1") {
        document.getElementById('<%=trRoundoff.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnEDCess.ClientID %>').value == "1") {
        document.getElementById('<%=trEDCess.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnSHEDCess.ClientID %>').value == "1") {
        document.getElementById('<%=trSHEDCess.ClientID %>').style.display = "table-row";
    }


    function ViewColumn(SplitValue, lsChecked) {

        var BillID = '<%= Request.QueryString["bid"] %>';

        if (BillID == null || BillID == "") {
            BillID = 0;
        }
        rows = document.getElementById('<%=gvBillingDetail.ClientID %>').rows;

        for (i = 0; i < rows.length; i++) {
            if (lsChecked == true || SplitValue == "Y") {
                if (BillID == 0) {
                    rows[i].cells[3].style.display = "block";
                }
                else {
                    rows[i].cells[2].style.display = "block";
                }
            }
            else {
                if (BillID == 0) {
                    rows[i].cells[3].style.display = "none";
                }
                else {
                    rows[i].cells[2].style.display = "none";
                }
            }
        }

    }
    
    
   
      
        
     
</script>

<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />
