<%@ Control Language="C#" AutoEventWireup="true" CodeFile="QuatumBillPrint.ascx.cs" Inherits="CommonControls_QuatumBillPrint" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<%@ Register Src="FinalBillHeader.ascx" TagName="FinalBillHeader" TagPrefix="uc3" %>


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

<table width="100%" align="center" id="tblBillPrint" style="font-family: Verdana;
    font-size: 10px;" runat="server">

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
                <td>
                <table width="100%" cellpadding="2" cellspacing="2">
                <tr>
                <td id="tblPatientDetails" runat="server" colspan="6">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td colspan="9" id="tdDupBill" runat="server" align="center" style="display:none;">
                                    <asp:Label ID="lblTypeBill" runat="server" 
                                        meta:resourcekey="lblTypeBillResource2" Font-Bold="True" Font-Size="Medium"></asp:Label>
                                    <asp:Label ID="lblDupBill" Font-Bold="True" Text="(Duplicate Copy)" Visible="False"
                                        runat="server" meta:resourcekey="lblDupBillResource2" Font-Size="Medium"></asp:Label>
                                </td>
                               
                            </tr>
                            <tr>
                                <td colspan="9">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="9">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                
                               
                                <td align="left" nowrap="nowrap" style="width: 10%">
                                    <asp:Label ID="Rs_PatientNo" Text="Request No" runat="server" meta:resourcekey="Rs_PatientNoResource1" />
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 25%;">
                                    <span style="width: 23%">
                                         
                                    <asp:Label ID="lblVisitNumber" runat="server" Style="font-weight: 700" Visible="False"
                                        meta:resourcekey="lblVisitNumberResource1"></asp:Label>
                                         
                                    </span>
                                </td>
                                 <td align="left" nowrap="nowrap">
                                    <asp:Label runat="server" ID="lblPhy" Text="Ref Doctor"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    :
                                </td>
                                <td align="left" nowrap="nowrap" width="width: 25%;">
                                    <asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 10%">
                                    <asp:Label ID="Rs_BillDate" Text="Bill Date" runat="server" meta:resourcekey="Rs_BillDateResource2" />
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%">
                                    :
                                </td>
                                <td align="left" nowrap="nowrap" width="8%">
                                    <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceDateResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;
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
                                        <asp:Label ID="lblTitleName" runat="server" Style="font-weight: 700" meta:resourcekey="lblTitleNameResource1"></asp:Label>
                                        <asp:Label ID="lblName" runat="server" Style="font-weight: 700" meta:resourcekey="lblNameResource2"></asp:Label>
                                        <asp:Label ID="lblQualification" runat="server" Style="font-weight: 700"></asp:Label>
                                    </span>
                                </td>
                                 <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblRefHos" Text="Referring Hos" runat="server" />
                                </td>
                                <td id="trduedot" runat="server" align="left" nowrap="nowrap">
                                    :
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblReferringHos" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_BillNo" Text="Bill No" runat="server" meta:resourcekey="Rs_BillNoResource2" />
                                </td>
                                <td align="left" nowrap="nowrap">
                                    :&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceNoResource2"></asp:Label>
                                </td>
                          
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>

                            
                            <tr>
                                
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_sex" Text="Valid ID/Gender" runat="server" meta:resourcekey="Rs_sexResource1" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblSex" runat="server" Style="font-weight: 700" meta:resourcekey="lblSexResource2"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                   <asp:Label ID="RefClient" runat="server" Text="Ref Client"></asp:Label></td>
                                <td id="trmodbdot" runat="server" align="left" nowrap="nowrap">
                                    :&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                     <asp:Label ID="lblRefClient" runat="server" Font-Bold="True"></asp:Label></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                            
                          
                            <tr>
                                
                                <td align="left" nowrap="nowrap">
                                   
                                    <asp:Label ID="lblEmailID" runat="server" Text="Email Add"></asp:Label></td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap">
                                    
                                   <asp:Label ID="lblEmailADD" runat="server" Font-Bold="True"></asp:Label></td>
                                <td align="left" nowrap="nowrap">
                                   
                                    <asp:Label ID="Rs_PatPhoneNo" Text="Contact No" runat="server"/>
                                   
                                </td>
                                <td align="left" nowrap="nowrap">
                                    :</td>
                                <td align="left" nowrap="nowrap">
                                    
                                    <asp:Label ID="lblPatPhoneNumber" runat="server" Style="font-weight: 700" meta:resourcekey="lblPatPhoneNumberResource1"></asp:Label>
                                    
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
                </table>                
                </td>
                    
                </tr>
               
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
                                <asp:TemplateField HeaderText="Bill No" HeaderStyle-Width="5%" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBillNumber" Text='<%# Bind("BillNumber") %>' runat="server" meta:resourcekey="lblBillNumberResource1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Test" HeaderStyle-Width="25%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" Text='<%# Bind("FeeDescription") %>' runat="server"
                                            meta:resourcekey="lblDescriptionResource2"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Split Description" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSplitDescription" Text='<%# Bind("Address") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ServiceCode" HeaderText="Code"
                                    meta:resourcekey="BoundFieldResource4" HeaderStyle-Width="8%">
                                    <ItemStyle Width="15%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField ItemStyle-Width="8%" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center"
                                    HeaderText="Units" DataField="Quantity" meta:resourcekey="BoundFieldResource5" Visible="false">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Report Date" ItemStyle-Width="15%" Visible="false">
                                    <ItemTemplate>
                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "ModifiedAt", "{0:dd/MMM/yyyy}").ToString())%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField ItemStyle-Width="12%" DataField="Amount" HeaderText="Amount" DataFormatString="{0:N}"
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
                                                <asp:Label ID="lblGrossAmount" runat="server" 
                                                    meta:resourcekey="lblGrossAmountResource2" Font-Bold="True" />
                                            </td>
                                        </tr>
                                        <%--<tr style="display: none;">
                                            <td align="right" valign="Middle">
                                                <asp:Label ID="Rs_DeductionAmount" Text="Deduction Amount" runat="server" meta:resourcekey="Rs_DeductionAmountResource2" />
                                                :
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblDeduction" runat="server" meta:resourcekey="lblDeductionResource2" />
                                            </td>
                                        </tr>--%>
                                        <%--<tr id="trServiceCharge" style="display: none;" runat="server">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server" meta:resourcekey="Rs_ServiceChargeResource2" />
                                                :
                                            </td>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblServiceCharge" runat="server" meta:resourcekey="lblServiceChargeResource2" />
                                            </td>
                                        </tr>--%>
                                       
                                       <%-- <tr id="trEDCess" style="display: none;" runat="server">
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
                                        </tr>--%>
                                        <tr id="trDiscount" style="display: none;" runat="server">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblDiscountPercent" runat="server" meta:resourcekey="lblDiscountPercentResource2" />&nbsp;Discount
                                                (-) :
                                            </td>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblDiscount" runat="server" meta:resourcekey="lblDiscountResource2" />
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
                                        
                                         <tr id="trTaxAmount" style="display: none;" runat="server">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblTaxAmounttxt" Text="Tax Amount" runat="server" meta:resourcekey="lblTaxAmounttxtResource1" />
                                                :
                                            </td>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblTaxAmount" runat="server" meta:resourcekey="lblTaxAmountResource1" />
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
                                       <%-- <tr>
                                            <td align="right" valign="Middle" colspan="2">
                                                <div id="dvTaxDetails" runat="server">
                                                </div>
                                            </td>
                                        </tr>--%>
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
                                                <asp:Label ID="lblGrandTotal" runat="server" 
                                                    meta:resourcekey="lblGrandTotalResource2" Font-Bold="True" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="2" valign="Middle">
                                                -----------------------------------
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
                                                <asp:Label ID="Label2" Text="Amount Refound" runat="server"></asp:Label>
                                                &nbsp;:
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblAmountRefound" runat="server" meta:resourcekey="lblCurrentVisitDueTextResource2" />
                                            </td>
                                        </tr>
                                        <tr id="trClaminAmount" runat="server" style="display: none">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="Label3" Text="Clamin Amount" runat="server"></asp:Label>
                                                &nbsp;:
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblClaminAmount" runat="server" />
                                            </td>
                                        </tr>
                                        <tr id="trwriteoff" runat="server" style="display: none">
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblWriteoff" Text="Writeoff Amount" runat="server"></asp:Label>
                                                &nbsp;:
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblCurrentWriteOff" runat="server" Style="font-weight: 700" />
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
                                <td>
                                    <table id="TaxDueDetails" runat="server" width="100%">
                                        <tr>
                                            <td colspan="6" align="left">
                                                <asp:Label ID="lblrefundamt" runat="server" Visible="False" Style="font-weight: 700"
                                                    meta:resourcekey="lblrefundamtResource2"></asp:Label>
                                            </td>
                                        </tr>
                                       
                                        <tr>
                                            <td colspan="6" align="left">
                                                <asp:Label ID="lblDisplayAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblDisplayAmountResource2"></asp:Label>
                                                <asp:Label ID="lblAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblAmountResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        
                                         <tr>
                                            <td colspan="6" align="left">
                                                <asp:Label ID="lblVAT" runat="server" Text="Amount transacted in Philippine Peso" Font-Bold="True"></asp:Label><br />
                                                 <asp:Label ID="lblVATPer" runat="server" Text="Applied the current VAT rate of 12%" Font-Bold="True"></asp:Label>
                                                </td>
                                        </tr>
                                        <tr id="trPayingCurrency" runat="server" style="display: none">
                                            <td colspan="6" align="left">
                                                <asp:Label ID="lblPayingCurrency" runat="server" Style="font-weight: 700; display: none;"
                                                    meta:resourcekey="lblPayingCurrencyResource2"></asp:Label>
                                                <asp:Label ID="lblPayingCurrencyinWords" runat="server" Style="font-weight: 700;
                                                    display: none;" meta:resourcekey="lblPayingCurrencyinWordsResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        
                                        <tr id="trTaxDetails" runat="server">
                                            <td colspan="6" align="left">
                                                <asp:Label ID="lblTaxDetails" Visible="False" runat="server" Style="font-weight: 700"
                                                    meta:resourcekey="lblTaxDetailsResource1"></asp:Label>
                                            </td>
                                        </tr>
                                       
                                        <tr>
                                            <td colspan="6" align="left">
                                                <asp:Label ID="lblDueAmountinWords" runat="server" Style="font-weight: 700" meta:resourcekey="lblDueAmountinWordsResource2" Visible="false"></asp:Label>
                                                <asp:Label ID="lblDueAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblDueAmountResource2" Visible="false"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" align="left">
                                                <asp:Label ID="Label1" Visible="False" runat="server" Style="font-weight: 700" meta:resourcekey="Label1Resource2"></asp:Label>
                                                <asp:Label ID="RemainDeposit" Visible="False" runat="server" Style="font-weight: 700"
                                                    meta:resourcekey="RemainDepositResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trReportDate" runat="server">
                                            <td colspan="6" align="left">
                                                <asp:Label ID="lblReportcommitDate" runat="server" meta:resourcekey="lblReportcommitDateResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                 <table id="Table1" runat="server" width="100%">
                                        <tr>
                                            <td colspan="6" align="left">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" align="left">
                                                &nbsp;</td>
                                        </tr>
                                        
                                         <tr>
                                            <td colspan="6" align="left">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" align="right">
                                                <asp:Label ID="lblBilledBy" runat="server" />
                                            </td>
                                        </tr>
                                        
                                        <tr id="tr2" runat="server">
                                            <td colspan="6" align="left">
                                                &nbsp;</td>
                                        </tr>
                                       
                                        <tr>
                                            <td colspan="6" align="left">
                                                &nbsp;</td>
                                        </tr>
                                        <tr id="userHide" runat="server">
                                            <td colspan="6" align="right">
                                                User Name:
                                                <asp:Label ID="lblLoginName" runat="server" />
                                            </td>
                                        </tr>
                                        <tr id="passwordHide" runat="server">
                                            <td colspan="6" align="right">
                                                Password:
                                                <asp:Label ID="lblPassword" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" align="right">
                                   
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
                 
            }
        }

    }
    
    
   
      
        
     
</script>

<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />
