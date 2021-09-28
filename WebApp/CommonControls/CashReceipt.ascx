<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CashReceipt.ascx.cs" Inherits="CommonControls_CashReceipt" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<style type="text/css">
    .style1
    {
        text-decoration: underline;
    }
</style>
<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />
<table width="95%" border="0" align="center" id="tblBillPrint" runat="server">
    <tr>
        <td>
            <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
                <tr>
                    <td colspan="6" align="center">
                        <asp:Label ID="Rs_CashReceipt" runat="server" Text="Cash Receipt" meta:resourcekey="Rs_CashReceiptResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td nowrap="nowrap">
                        &nbsp;&nbsp;<asp:Label ID="Rs_ReceiptNo" runat="server" Text="Receipt No :" meta:resourcekey="Rs_ReceiptNoResource1"></asp:Label>
                    </td>
                    <td width="18%">
                        <asp:Label ID="lblReceiptNo" runat="server" meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                    </td>
                    <td width="24%">
                        &nbsp;
                    </td>
                    <td width="13%">
                        &nbsp;
                    </td>
                    <td nowrap="nowrap">
                        <label>
                            <asp:Label ID="Rs_Date" runat="server" Text="Date" meta:resourcekey="Rs_DateResource1"></asp:Label>
                            :
                        </label>
                        <asp:Label ID="lblInvoiceDate" runat="server" meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        &nbsp; &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="5">
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <label>
                                        <asp:Label ID="Rs_PatientName" runat="server" Text="Patient Name :" meta:resourcekey="Rs_PatientNameResource1"></asp:Label></label>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <span style="width: 23%">
                                        <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                    </span>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_PatientNo" runat="server" Text="Patient No :" meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <span style="width: 23%">
                                        <asp:Label ID="lblPatientNumber" runat="server" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <label>
                                        <asp:Label ID="Rs_PatientAge" runat="server" Text="Patient Age :" meta:resourcekey="Rs_PatientAgeResource1"></asp:Label></label>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_Sex" runat="server" Text="Sex :" meta:resourcekey="Rs_SexResource1"></asp:Label>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <asp:Label ID="lblSex" runat="server" meta:resourcekey="lblSexResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_AdmissionDate" runat="server" Text="Admission Date :" meta:resourcekey="Rs_AdmissionDateResource1"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblAdmission" runat="server" meta:resourcekey="lblAdmissionResource1"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_IPNo" runat="server" Text="IP No :" meta:resourcekey="Rs_IPNoResource1"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblIPNo" runat="server" meta:resourcekey="lblIPNoResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp; <span lang="en-us">&nbsp;</span>
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
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="5" style="text-decoration: Underline;">
                        <asp:Label ID="Rs_ReceiptDetails" runat="server" Text="Receipt Details" meta:resourcekey="Rs_ReceiptDetailsResource1"></asp:Label>
                    </td>
                    <td>
                        &nbsp;&nbsp;
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
                        <%--<asp:GridView ID="gvBillingDetail" runat="server" Width="100%" 
                AutoGenerateColumns="False" onrowdatabound="gvBillingDetail_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="BillingDetailsID" HeaderText="BillingDetailsID" />
                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                            <asp:Label ID="lblDescription" Text='<%#Bind("FeeDescription") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="Amount" HeaderText="Unit Price" DataFormatString="{0:F2}"
                        ItemStyle-HorizontalAlign="Right" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Quantity" DataFormatString="{0:F2}"
                        ItemStyle-HorizontalAlign="Right" DataField="Quantity"   >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Amount"  DataFormatString="{0:F2}"  DataField="Rate"
                        ItemStyle-HorizontalAlign="Right"  >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </asp:BoundField>
                </Columns>
            </asp:GridView>--%>
                        <asp:Label ID="Rs_TheSumof" runat="server" Text="The Sum of" meta:resourcekey="Rs_TheSumofResource1"></asp:Label>
                        <asp:Label ID="lblCurrency" runat="server" meta:resourcekey="lblCurrencyResource1"></asp:Label>&nbsp;<asp:Label
                            ID="lblAmount" runat="server" meta:resourcekey="lblAmountResource1"></asp:Label>
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
                    <td>
                    </td>
                    <td colspan="1">
                        &nbsp;
                        <input id="Hidden1" runat="server" type="hidden" />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="3">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <%-- <tr>
                    <td height="10%" align="right">
                        Grand Total
                    </td>
                    <td height="10%" align="right">
                        <asp:Label ID="lblGrandTotal" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td height="10%" align="right">
                        Service Charge</td>
                    <td height="10%" align="right">
                        <asp:Label ID="lblServiceCharge" runat="server" />
                    </td>
                </tr>--%>
                            <tr>
                                <td height="10%" align="right">
                                    <asp:Label ID="Rs_AmountRecieved" runat="server" Text="Amount Recieved" meta:resourcekey="Rs_AmountRecievedResource1"></asp:Label>
                                </td>
                                <td height="10%" align="right">
                                    <asp:Label ID="lblAmountRecieved" runat="server" meta:resourcekey="lblAmountRecievedResource1" />
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
                        <asp:Label ID="lblBilledBy" runat="server" meta:resourcekey="lblBilledByResource1" />
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
                <%--  <tr>
        <td>
            &nbsp;
        </td>
        <td colspan="5" align="left">
            <asp:Label ID="Label1" runat="server"  style="font-weight: 700">Amount in Words:&nbsp;</asp:Label>()&nbsp;
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
            &nbsp;&nbsp;
        </td>
        <td>
            &nbsp;
        </td>
    </tr>--%>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="5">
                        <div id="dvDisclaimer" runat="server">
                            <span class="style1">
                                <asp:Label ID="Rs_Disclaimer" runat="server" Text="Disclaimer:" meta:resourcekey="Rs_DisclaimerResource1"></asp:Label></span><asp:Label
                                    ID="Rs_info" runat="server" Text="This is only a cash receipt. This receipt cannot be used for claiming 
            purpose." meta:resourcekey="Rs_ThisisonlyacashreceiptThisreceiptcannotbeusedforclaimingpurposeResource1"></asp:Label>
                        </div>
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
