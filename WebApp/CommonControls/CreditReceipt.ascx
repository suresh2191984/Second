<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CreditReceipt.ascx.cs"
    Inherits="CommonControls_CreditReceipt" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<style type="text/css">
    .style1
    {
        text-decoration: underline;
    }
</style>
<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />
<table width="95%" border="1" align="center" id="tblBillPrint" runat="server">
    <tr>
        <td>
            <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
                <tr>
                    <td colspan="6" align="center">
                        <asp:Label ID="Rs_CreditReceipt" runat="server" Text="Credit Receipt" meta:resourcekey="Rs_CreditReceiptResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td nowrap="nowrap">
                        &nbsp;&nbsp;
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
                        <asp:Label ID="Rs_Date" runat="server" Text="Date:" meta:resourcekey="Rs_DateResource1"></asp:Label>
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
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;
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
                        <asp:Label ID="Rs_BillingDetails" runat="server" Text="Billing Details" meta:resourcekey="Rs_BillingDetailsResource1"></asp:Label>
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
                        <asp:GridView ID="gvBillingDetail" runat="server" Width="100%" AutoGenerateColumns="False"
                            OnRowDataBound="gvBillingDetail_RowDataBound" meta:resourcekey="gvBillingDetailResource1">
                            <Columns>
                                <asp:BoundField DataField="BillingDetailsID" HeaderText="BillingDetailsID" meta:resourcekey="BoundFieldResource1" />
                                <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" Text='<%# Bind("FeeDescription") %>' runat="server"
                                            meta:resourcekey="lblDescriptionResource1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Amount" HeaderText="Unit Price" DataFormatString="{0:F2}"
                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource2">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Quantity" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right"
                                    DataField="Quantity" meta:resourcekey="BoundFieldResource3">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Amount" DataFormatString="{0:F2}" DataField="Rate" ItemStyle-HorizontalAlign="Right"
                                    meta:resourcekey="BoundFieldResource4">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
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
                            <tr>
                                <td height="10%" align="right">
                                    <asp:Label ID="Rs_GrandTotal" runat="server" Text="Grand Total" meta:resourcekey="Rs_GrandTotalResource1"></asp:Label>
                                </td>
                                <td height="10%" align="right">
                                    <asp:Label ID="lblGrandTotal" runat="server" meta:resourcekey="lblGrandTotalResource1" />
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
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="2">
                        <asp:Label ID="Rs_Signature" runat="server" Text="Signature" meta:resourcekey="Rs_SignatureResource1"></asp:Label>
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
                        &nbsp;
                    </td>
                    <td colspan="5">
                        <span class="style1">
                            <asp:Label ID="Rs_Disclaimer" runat="server" Text="Disclaimer:" meta:resourcekey="Rs_DisclaimerResource1"></asp:Label></span><asp:Label
                                ID="Rs_info" runat="server" Text="This is only a credit receipt. This receipt cannot be used for claiming 
            purpose." meta:resourcekey="Rs_ThisisonlyacreditreceiptThisreceiptcannotbeusedforclaimingpurposeResource1"></asp:Label>
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
