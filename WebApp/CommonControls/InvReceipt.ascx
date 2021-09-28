<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InvReceipt.ascx.cs" Inherits="CommonControls_InvReceipt" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<style type="text/css">
    .style1
    {
        width: 10px;
    }
    .style2
    {
        width: 18%;
    }
    .style3
    {
        width: 332px;
    }
</style>
<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />
<table width="75%" border="0" align="center" id="tblBillPrint" runat="server">
    <tr>
        <td>
            <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
                <tr>
                  
                    <td colspan="7" align="center">
                        <label style="font-family: Arial; font-size: medium;" id="lblHospitalName" runat="server">
                        </label>
                    </td>
                  
                </tr>
                 <tr id="OrgaddressDisplay" runat="server" style="display:none;">
                    
                    <td colspan="7" align="center" >
                       <asp:Label ID="lblOrgAddress" runat="server" style="font-family: Arial; font-size: medium;"></asp:Label>
                    </td>
                   
                </tr>
                 <tr>
                    <td colspan="7">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="7" align="center">
                        <!--Payment Receipt-->
                        <asp:label style="font-family: Arial; font-size: medium;" id="lblPaymentDisplay" runat="server">
                        </asp:label>
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
                    <td colspan="5">
                        <table width="90%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <label>
                                        Receipt No</label>
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp;
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <span style="width: 23%">
                                        <asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700"></asp:Label>
                                    </span>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    Receipt Date:
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;:&nbsp;
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <span style="width: 23%">
                                        <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <label>
                                        Patient Name
                                        <td align="left" nowrap="nowrap" class="style1">
                                            &nbsp; :
                                        </td>
                                        <td width="83%" align="left" nowrap="nowrap">
                                            <span style="width: 23%">
                                                <asp:Label ID="lblName" runat="server" Style="font-weight: 700"></asp:Label>
                                            </span>
                                        </td>
                                        <td width="83%" align="left" nowrap="nowrap">
                                            Patient No
                                        </td>
                                        <td width="83%" align="left" nowrap="nowrap">
                                            &nbsp;:&nbsp;
                                        </td>
                                        <td width="83%" align="left" nowrap="nowrap">
                                            <span style="width: 23%">
                                                <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700"></asp:Label>
                                            </span>
                                        </td>
                                </td>
                            </tr>
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    Patient Age
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp; :
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <asp:Label ID="lblAge" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    Sex
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;:&nbsp;
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <asp:Label ID="lblSex" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <div id="phyDetails" runat="server">
                                    <td align="left" nowrap="nowrap">
                                        <asp:Label runat="server" ID="lblPhy" Text="Prescribed By"></asp:Label>
                                    </td>
                                    <td align="left" nowrap="nowrap" class="style1">
                                        &nbsp; :
                                    </td>
                                    <td align="left" nowrap="nowrap">
                                        <b></b>
                                        <asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700"></asp:Label>
                                    </td>
                                </div>
                                <div id="divipnumber" runat="server">
                                    <td align="left" nowrap="nowrap">
                                        <asp:Label runat="server" ID="lblIPNo" Text="IP No"></asp:Label>
                                    </td>
                                    <td align="left" nowrap="nowrap">
                                        &nbsp;
                                    </td>
                                    <td align="left" nowrap="nowrap">
                                        <b></b>
                                        <asp:Label runat="server" ID="lblIPNumber" Style="font-weight: 700"></asp:Label>
                                    </td>
                                </div>
                            </tr>
                            <tr>
                                 <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                 <asp:Label runat="server" ID="lblPBillNo" Text="Pharmacy Bill No" Visible ="false"></asp:Label>
                                 
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp; :
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <asp:Label ID="lblPharmacyBillNo" runat="server" Style="font-weight: 700" Visible="false" ></asp:Label>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                     &nbsp;</td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;&nbsp;
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;</td>
                            </tr>
                         
                            <tr>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
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
                        &nbsp;
                    </td>
                    <td colspan="5" style="text-decoration: Underline;">
                        Billing Details
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
                        <asp:GridView BorderStyle="None" GridLines="None" ID="gvBillingDetail" runat="server"
                            Width="100%" AutoGenerateColumns="False">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" Text='<%#Bind("FeeDescription") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Batch" DataField="BatchNo"></asp:BoundField>
                                 <asp:TemplateField HeaderText="Exp Date">
                                    <ItemTemplate>
                                 <%# Eval("ExpiryDate", "{0:MMM/yyyy}").ToString() == "Jan/1753" ? ("**") : Eval("ExpiryDate", "{0:MMM/yyyy}")%>
                                   </ItemTemplate>
                                </asp:TemplateField>
                                
                              <%--  <asp:BoundField HeaderText="Exp Date" DataFormatString="{0:MMM/yyyy}" DataField="ExpiryDate">  </asp:BoundField>--%>
                               
                                <asp:BoundField HeaderText="M.R.P." DataField="Amount"></asp:BoundField>
                                <asp:BoundField HeaderText="Quantity" DataField="Quantity"></asp:BoundField>
                                <asp:BoundField DataField="Rate" HeaderText="Amount" DataFormatString="{0:F2}"></asp:BoundField>
                            </Columns>
                            <RowStyle HorizontalAlign="Left" />
                            <HeaderStyle HorizontalAlign="Left" />
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
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td>
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
                        <table width="100%" border="0" cellpadding="2" cellspacing="2" style="border-color: #000000">
                            <tr>
                                <td align="right" colspan="2" valign="Middle">
                                    -----------------------------------
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="Middle">
                                    Net Amount :
                                </td>
                                <td align="center">
                                    &nbsp;<asp:Label ID="lblNetValue" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="Middle">
                                    Amount Received :
                                </td>
                                <td align="center">
                                    &nbsp;<asp:Label ID="lblAmountRecieved" runat="server" Style="font-weight: 700" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" valign="Middle" colspan="0">
                                    -----------------------------------
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
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="5" align="left">
                        <table width="100%" border="0" cellpadding="4" cellspacing="3" style="border-color: #000000">
                            <tr>
                                <td>
                                    <asp:Label ID="lblDisplayAmount" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblAmount" runat="server" Style="font-weight: 700"> </asp:Label>
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
                    <td colspan="5" align="left">
                        <asp:Label ID="lblBilledBy" runat="server" />
                    </td>
                    
                    
                </tr>
            </table>
        </td>
    </tr>
</table>
<input type="hidden" runat="server" id="hdnDefaultRoundoff" />
<input type="hidden" runat="server" id="hdnRoundOffType" />

<script language="javascript" type="text/javascript">
    function Round() {
        var NetValue = parseFloat(document.getElementById('ReceiptPrint1_lblNetValue').innerHTML);
        var AmountRecieved = parseFloat(document.getElementById('ReceiptPrint1_lblAmountRecieved').innerHTML);
        document.getElementById('ReceiptPrint1_lblNetValue').innerHTML = getOPCustomRoundoff(NetValue.toFixed(2));
        document.getElementById('ReceiptPrint1_lblAmountRecieved').innerHTML = getOPCustomRoundoff(AmountRecieved.toFixed(2));
    }
    function getOPCustomRoundoff(netRound) {
        var DefaultRound = document.getElementById('ReceiptPrint1_hdnDefaultRoundoff').value;
        var RoundType = document.getElementById('ReceiptPrint1_hdnRoundOffType').value;
        if (RoundType.toLowerCase() == "lower value") {
            result = (Math.floor(Number(netRound) / Number(DefaultRound))) * (Number(DefaultRound));
        }
        else if (RoundType.toLowerCase() == "upper value") {
            result = (Math.ceil(Number(netRound) / Number(DefaultRound))) * (Number(DefaultRound));
        }
        else if (RoundType.toLowerCase() == "none") {
            result = format_number_withSignNone(netRound, 2);
        }
        else {
            result = parseFloat(netRound).toFixed(2);
        }
        result = parseFloat(result).toFixed(2);
        return result;
    }
</script>

