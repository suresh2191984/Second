<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InvRefundRecepit.ascx.cs"
    Inherits="CommonControls_InvRefundRecepit" %>
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
                    <td align="center">
                        &nbsp;
                    </td>
                    <td align="center">
                        &nbsp;
                    </td>
                    <td colspan="3" align="center">
                        <label style="font-family: Arial; font-size: medium;" id="lblHospitalName" runat="server">
                        </label>
                    </td>
                    <td align="center">
                        &nbsp;
                    </td>
                    <td align="center">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="7" align="center">
                        <asp:Label ID="Rs_RefundReceipt" Text=" (Refund Receipt)" runat="server" meta:resourcekey="Rs_RefundReceiptResource1" />
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
                                    <asp:Label ID="Rs_ReceiptNo" Text="Receipt No" runat="server" meta:resourcekey="Rs_ReceiptNoResource1" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp;
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <span style="width: 23%">
                                        <asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
                                    </span>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_ReceiptDate" Text="Receipt Date:" runat="server" meta:resourcekey="Rs_ReceiptDateResource1" />
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;:&nbsp;
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <span style="width: 23%">
                                        <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700" meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" meta:resourcekey="Rs_PatientNameResource1" />
                                    <td align="left" nowrap="nowrap" class="style1">
                                        &nbsp; :
                                    </td>
                                    <td width="83%" align="left" nowrap="nowrap">
                                        <span style="width: 23%">
                                            <asp:Label ID="lblName" runat="server" Style="font-weight: 700" meta:resourcekey="lblNameResource1"></asp:Label>
                                        </span>
                                    </td>
                                    <td width="83%" align="left" nowrap="nowrap">
                                        <asp:Label ID="Rs_PatientNo" Text="Patient No" runat="server" meta:resourcekey="Rs_PatientNoResource1" />
                                    </td>
                                    <td width="83%" align="left" nowrap="nowrap">
                                        &nbsp;:&nbsp;
                                    </td>
                                    <td width="83%" align="left" nowrap="nowrap">
                                        <span style="width: 23%">
                                            <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                        </span>
                                    </td>
                                </td>
                            </tr>
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_PatientAge" Text="Patient Age" runat="server" meta:resourcekey="Rs_PatientAgeResource1" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp; :
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <asp:Label ID="lblAge" runat="server" Style="font-weight: 700" meta:resourcekey="lblAgeResource1"></asp:Label>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_Sex" Text="Sex" runat="server" meta:resourcekey="Rs_SexResource1" />
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;:&nbsp;
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <asp:Label ID="lblSex" runat="server" Style="font-weight: 700" meta:resourcekey="lblSexResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <div id="phyDetails" runat="server">
                                    <td align="left" nowrap="nowrap">
                                        <asp:Label runat="server" ID="lblPhy" Text="Prescribed By" meta:resourcekey="lblPhyResource1"></asp:Label>
                                    </td>
                                    <td align="left" nowrap="nowrap" class="style1">
                                        &nbsp; :
                                    </td>
                                    <td align="left" nowrap="nowrap">
                                        <b></b>
                                        <asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700" meta:resourcekey="lblPhysicianResource1"></asp:Label>
                                    </td>
                                </div>
                                <div id="divipnumber" runat="server">
                                    <td align="left" nowrap="nowrap">
                                        <asp:Label runat="server" ID="lblIPNo" Text="IP No" meta:resourcekey="lblIPNoResource1"></asp:Label>
                                    </td>
                                    <td align="left" nowrap="nowrap">
                                        &nbsp;
                                    </td>
                                    <td align="left" nowrap="nowrap">
                                        <b></b>
                                        <asp:Label runat="server" ID="lblIPNumber" Style="font-weight: 700" meta:resourcekey="lblIPNumberResource1"></asp:Label>
                                    </td>
                                </div>
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
                        <asp:Label ID="Rs_BillingDetails" Text="Billing Details" runat="server" meta:resourcekey="Rs_BillingDetailsResource1" />
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
                            Width="100%" AutoGenerateColumns="False" meta:resourcekey="gvBillingDetailResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" Text='<%# Bind("FeeDescription") %>' runat="server"
                                            meta:resourcekey="lblDescriptionResource1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Batch" DataField="BatchNo" meta:resourcekey="BoundFieldResource1">
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Exp Date" DataFormatString="{0:MMM/yyyy}" DataField="ExpiryDate"
                                    meta:resourcekey="BoundFieldResource2"></asp:BoundField>
                                <asp:BoundField HeaderText="M.R.P." DataField="Rate" meta:resourcekey="BoundFieldResource3">
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Quantity" DataField="Quantity" meta:resourcekey="BoundFieldResource4">
                                </asp:BoundField>
                                <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0:F2}"
                                    meta:resourcekey="BoundFieldResource5"></asp:BoundField>
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
                    <td class="style2">
                        &nbsp;
                    </td>
                    <td colspan="3">
                        <table width="100%" border="0" cellpadding="2" cellspacing="2" style="border-color: #000000">
                            <tr>
                                <td align="right" colspan="2" valign="Middle">
                                    -----------------------------------
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="Middle" class="style3">
                                    <asp:Label ID="Rs_NetAmount" Text="Net Amount :" runat="server" meta:resourcekey="Rs_NetAmountResource1" />
                                </td>
                                <td align="center">
                                    &nbsp;<asp:Label ID="lblNetValue" runat="server" Style="font-weight: 700" meta:resourcekey="lblNetValueResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="Middle" class="style3">
                                    <asp:Label ID="Rs_AmountReceived" Text="Amount Received :" runat="server" meta:resourcekey="Rs_AmountReceivedResource1" />
                                </td>
                                <td align="center">
                                    &nbsp;<asp:Label ID="lblAmountRecieved" runat="server" Style="font-weight: 700" meta:resourcekey="lblAmountRecievedResource1" />
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
                                    <asp:Label ID="lblDisplayAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblDisplayAmountResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblAmount" runat="server" Style="font-weight: 700" meta:resourcekey="lblAmountResource1"></asp:Label>
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
                        &nbsp;
                    </td>
                    <td class="style2">
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
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td class="style2">
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
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td class="style2">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="2" align="center">
                        <asp:Label ID="lblBilledBy" runat="server" meta:resourcekey="lblBilledByResource1" />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
