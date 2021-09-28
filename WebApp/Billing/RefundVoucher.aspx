<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RefundVoucher.aspx.cs" Inherits="Billing_RefundVoucher"
    meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Voucher Receipt </title>
    <style type="text/css">
        .style1
        {
            height: 18px;
        }
    </style>
</head>
<body style="font-size: 12px;" onload="window.print()" oncontextmenu="return false;">
    <form id="form1" runat="server">
    <table width="100%" border="1" align="center" id="tblBillPrint" runat="server">
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="2" style="font-family: Verdana; font-size: 10px;"
                    cellpadding="2" align="center" id="tbl1" runat="server">
                    <tr>
                        <td colspan="9" align="center">
                            <asp:Image ID="imgBillLogo" runat="server" Visible="False" meta:resourcekey="imgBillLogoResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9" align="center">
                            <label id="lblHospitalName" runat="server">
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" align="center" id="tdRefundHeaderText" runat="server" style="display: block;">
                            <br />
                            <span style="text-decoration: underline;">
                                <asp:Label ID="Rs_RefundVoucher" Text="Refund Voucher" runat="server" 
                                meta:resourcekey="Rs_RefundVoucherResource1"  ></asp:Label>
                            </span>
                        </td>
                        
                    </tr>
                    <tr>
                    <td  align="center" id="tdCancelHeaderText" runat="server" style="display: none;" colspan="11">
                            <br />
                            <span style="text-decoration: underline;">
                                <asp:Label ID="Label1" runat="server" 
                                meta:resourcekey="Label1Resource1"></asp:Label>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b>
                                <asp:Label ID="Rs_PatientNo" Text="Patient No" runat="server" meta:resourcekey="Rs_PatientNoResource1"></asp:Label></b>
                        </td>
                        <td>
                            &nbsp; :
                            <asp:Label ID="lblPNo" runat="server" meta:resourcekey="lblPNoResource1"></asp:Label>
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
                        <td nowrap="nowrap" align="left" id="tdREFdate" runat="server" style="display: block;">
                            <label style="font-weight: 700">
                                <asp:Label ID="Rs_RefundDate" Text="Refund Date" runat="server" meta:resourcekey="Rs_RefundDateResource1"></asp:Label>
                            </label>
                        </td>
                        <td nowrap="nowrap" align="left" id="tdCANdate" runat="server" style="display: none;">
                            <label style="font-weight: 700">
                                <asp:Label ID="lblCANdate" Text="Cancel Date" runat="server" 
                                meta:resourcekey="lblCANdateResource1"></asp:Label>
                            </label>
                        </td>
                        <td nowrap="nowrap" align="right">
                            <label>
                                :</label>
                        </td>
                        <td nowrap="nowrap" align="left">
                            <asp:Label ID="lblInvoiceDate" runat="server" meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b>
                                <asp:Label ID="Rs_Name" Text="Name" runat="server" meta:resourcekey="Rs_NameResource1"></asp:Label></b>
                        </td>
                        <td>
                            &nbsp; :
                            <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
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
                        <td nowrap="nowrap" align="left" id="tdREFno" runat="server" style="display: block;">
                            <b>
                                <asp:Label ID="Rs_RefundVoucherNo" Text="Refund Voucher No" runat="server" 
                                meta:resourcekey="Rs_RefundVoucherNoResource1" ></asp:Label></b>
                        </td>
                        <td nowrap="nowrap" align="left" id="tdCancelno" runat="server" style="display: none;">
                            <b>
                                <asp:Label ID="lblCANno" Text="Cancel Voucher No" runat="server" 
                                meta:resourcekey="lblCANnoResource1"></asp:Label></b>
                        </td>
                        <td nowrap="nowrap" align="right" id="tdCancelNoColon" runat="server" style="display: none;" >
                            &nbsp; :
                        </td>
                        <td nowrap="nowrap" align="left" id="tdLabelCancelno" runat="server" style="display: none;">
                            <asp:Label ID="lblRefundVoucherNo" runat="server" 
                                meta:resourcekey="lblRefundVoucherNoResource1"></asp:Label>
                        </td>
                        <td align="left" id="tdlblCancelNo" runat="server" style="display: none;">
                            <b>
                                <asp:Label ID="lblCancelNo" Text="Cancel Bill No" runat="server" 
                                meta:resourcekey="lblCancelNoResource1"></asp:Label></b>
                        </td>
                        <td nowrap="nowrap" align="right" id="tdTxtCancelNo" runat="server" style="display: none;">
                            &nbsp;:
                        </td>
                        <td>
                            <asp:Label ID="lblCancelValue" runat="server" 
                                meta:resourcekey="lblCancelValueResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b>
                                <asp:Label ID="Rs_Age" Text="Age" runat="server" meta:resourcekey="Rs_AgeResource1"></asp:Label></b>
                        </td>
                        <td>
                            &nbsp; :
                            <asp:Label ID="lblPAge" runat="server" meta:resourcekey="lblPAgeResource1"></asp:Label>
                        </td>
                        <td>
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
                        <td align="left" id="tdlblRefundNo" runat="server" >
                            <b>
                                <asp:Label ID="Rs_BillNo" Text="Bill No" runat="server" 
                                meta:resourcekey="Rs_BillNoResource1" ></asp:Label></b>
                        </td>
                           <td style="display: none;">
                        </td>
                        <td nowrap="nowrap" align="right" id="tdTxtRefundNo" runat="server" >
                            &nbsp;:
                        </td>
                        <td id="tdTxt1RefundNo" runat="server" >
                            <asp:Label ID="lblBillNo" runat="server" meta:resourcekey="lblBillNoResource1" ></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9" style="text-decoration: none;" runat="server" id="tdRefundDetails">
                            <asp:Label ID="Rs_BillNo1" Text="Refund Details:" runat="server" 
                                meta:resourcekey="Rs_BillNo1Resource1" ></asp:Label>
                        </td>
                        <td colspan="9" style="text-decoration: none; display: none;" runat="server" id="tdCancelDetails">
                            <asp:Label ID="lblCancelDetails" Text="Cancel Details:" runat="server" 
                                meta:resourcekey="lblCancelDetailsResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trRefundDetails" runat="server" style="display: none;">
                        <td>
                            &nbsp;
                        </td>
                        <td align="left" colspan="8">
                            <asp:Label ID="Rs_AsumofRs" Text="A sum of Rs." runat="server" 
                                meta:resourcekey="Rs_AsumofRsResource1"  ></asp:Label>
                            <b>
                                <asp:Label ID="lblAmount" runat="server" meta:resourcekey="lblAmountResource1"></asp:Label></b>
                            <asp:Label ID="Rs_forBillNo" Text="for Bill No." runat="server" meta:resourcekey="Rs_forBillNoResource1"></asp:Label>
                            <asp:Label ID="lblBillNoword" runat="server" meta:resourcekey="lblBillNowordResource1"></asp:Label>
                            <asp:Label ID="Rs_hasbeenrefunded" Text="has been refunded." runat="server" meta:resourcekey="Rs_hasbeenrefundedResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr id="gvdata" runat="server" style="display: none;">
                        <td colspan="9" class="style2">
                            <asp:GridView ID="gvResult" CellPadding="3" runat="server" AutoGenerateColumns="False"
                                Width="100%" Font-Names="Verdana" meta:resourcekey="gvResultResource1" OnRowDataBound="gvResult_RowDataBound">
                                <HeaderStyle CssClass="dataheader1" />
                                <PagerStyle CssClass="dataheader1" />
                                <Columns>
                                    <asp:BoundField HeaderText="Description" DataField="FeeDescription" ItemStyle-Width="44%"
                                        meta:resourcekey="BoundFieldResource1">
                                        <ItemStyle Width="44%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Amount" ItemStyle-Width="8%" DataField="Amount" ItemStyle-HorizontalAlign="Right"
                                        meta:resourcekey="BoundFieldResource2">
                                        <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                    </asp:BoundField>
                                     <asp:BoundField HeaderText="AmountReceived" ItemStyle-Width="8%" 
                                        DataField="AmountReceived" ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource3"
                                       >
                                        <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Refunded Amount" ItemStyle-Width="18%" DataField="RefundedAmt"
                                        ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource3">
                                        <ItemStyle HorizontalAlign="Right" Width="18%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Reason" DataField="ReasonforRefund" ItemStyle-Width="30%" Visible="false"
                                        meta:resourcekey="BoundFieldResource4">
                                        <ItemStyle Width="30%"></ItemStyle>
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr id="trReasonForCancel" style="display: none;">
                        <td>
                            <asp:Label ID="lblReasonForCancel" runat="server" Text="Reason For Cancel :" 
                                meta:resourcekey="lblReasonForCancelResource1"></asp:Label>
                        </td>
                        <td colspan="8">
                            <asp:Label ID="lblTxtReasonForCancel" runat="server" 
                                meta:resourcekey="lblTxtReasonForCancelResource1"></asp:Label>
                        </td>
                    </tr>
                      <tr id="trdue" style="display: none;" align=right>
                        <td colspan="7">
                            <asp:Label ID="lbldue" runat="server" Text="Remaining Due Amount :" 
                                meta:resourcekey="lbldueResource1"></asp:Label>
                             </td>
                        <td colspan="2">
                                <asp:Label ID="lbldues" runat="server" meta:resourcekey="lblduesResource1"></asp:Label>
                        </td>
                      <%--  <td colspan="8">
                        
                        </td>--%>
                    </tr>
                    <tr id="trdiscount" style="display: none;" align=right>
                        <td colspan="7">
                            <asp:Label ID="lbldiscounts" runat="server" Text="Discount Amount :" 
                                meta:resourcekey="lbldiscountsResource1"></asp:Label>
                             </td>
                        <td colspan="2">
                                <asp:Label ID="lblDiscount" runat="server" 
                                    meta:resourcekey="lblDiscountResource1"></asp:Label>
                        </td>
                      <%--  <td colspan="8">
                        
                        </td>--%>
                    </tr>
                    <tr id="trroundoff" style="display: none;" align=right>
                        <td colspan="7">
                            <asp:Label ID="lroundoff" runat="server" Text="Round OFF :" 
                                meta:resourcekey="lblroundoff"></asp:Label>
                             </td>
                        <td colspan="2">
                                <asp:Label ID="lroundoffval" runat="server" 
                                    meta:resourcekey="lblDiscountResource1"></asp:Label>
                        </td>
                     
                    </tr>
                    <tr id="tralreadyrefundamount" style="display: none;" align=right>
                        <td colspan="7">
                            <asp:Label ID="lblAlreadyrefundamt" runat="server" Text="Total Refund Amount :" 
                                meta:resourcekey="lblAlreadyrefundamtResource1" ></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblAlreadyrefundamts" runat="server" 
                                meta:resourcekey="lblAlreadyrefundamtsResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9" id="trRefundAmtInWords" runat="server" style="display: block;">
                            &nbsp;<asp:Label ID="Rs_TheSumof" Text="The Sum of" runat="server" meta:resourcekey="Rs_TheSumofResource1"></asp:Label>
                            <asp:Label ID="lblCurrency" runat="server" meta:resourcekey="lblCurrencyResource1" />.
                            &nbsp;<asp:Label ID="lblAmountword" runat="server" meta:resourcekey="lblAmountwordResource1"></asp:Label>
                            &nbsp;<asp:Label ID="Rs_Only" Text="Only..." runat="server" meta:resourcekey="Rs_OnlyResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trchequedetails" style="display: none;" runat="server">
                        <td>
                        <b>
                            <asp:Label ID="lblchequedetails" runat="server" Text="Cheque Details" 
                                meta:resourcekey="lblchequedetailsResource1"></asp:Label></b>
                        </td>
                        <td>
                            <asp:Label ID="lblchequeno" runat="server" 
                                meta:resourcekey="lblchequenoResource1"></asp:Label>
                        </td>
                         <td>
                            <asp:Label ID="lblbankname" runat="server" 
                                 meta:resourcekey="lblbanknameResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr >
                        <td  id="tdRefuntadjusted" runat="server" colspan="9"> 
                        <asp:Label ID="lblRefuntadjusted" runat="server" Visible="False" 
                                Text="Refunnd adjusted against due amount" 
                                meta:resourcekey="lblRefuntadjustedResource1"></asp:Label>
                        <asp:Label runat="server"  Visible="False" ID ="lbladjustedDue" 
                                meta:resourcekey="lbladjustedDueResource1" ></asp:Label>
                        </td>
                    </tr>
                    <tr id="trReasonForRefund" runat="server" style="display: none;">
                        <td colspan="9">
                            <asp:Label ID="lblReasonforRefund" runat="server" Text="Reason for Refund :" meta:resourcekey="lblReasonforRefundResource1"></asp:Label>
                            <asp:Label ID="lblRefundReason" runat="server" meta:resourcekey="lblRefundReasonResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="left">
                            <asp:Label ID="lblPassedBy" runat="server" Style="font-weight: 700" meta:resourcekey="lblPassedByResource1" />
                        </td>
                        <%--<td align="left">
                            |
                        </td>--%>
                        <td align="left">
                            <asp:Label ID="lblApprovedBy" runat="server" Style="font-weight: 700" />
                        </td>
                        <%--<td align="left">
                            |
                        </td>--%>
                        <td colspan="4" align="center">
                            <asp:Label ID="lblAccountant" runat="server" Style="font-weight: 700" meta:resourcekey="lblAccountantResource1" />
                        </td>
                        <td align="center">
                            &nbsp;| &nbsp;
                        </td>
                        <td align="center">
                            <asp:Label ID="lblReceiverSign" runat="server" Style="font-weight: 700" meta:resourcekey="lblReceiverSignResource1" />
                        </td>
                    </tr>
                    <%--<tr>
                        <td colspan="9" id="trRefundAmtInWords" runat="server" style="display: block;">
                            &nbsp;<asp:Label ID="Rs_TheSumof" Text="The Sum of" runat="server" meta:resourcekey="Rs_TheSumofResource1"></asp:Label>
                            <asp:Label ID="lblCurrency" runat="server" meta:resourcekey="lblCurrencyResource1" />.
                            &nbsp;<asp:Label ID="lblAmountword" runat="server" meta:resourcekey="lblAmountwordResource1"></asp:Label>
                            &nbsp;<asp:Label ID="Rs_Only" Text="Only..." runat="server" meta:resourcekey="Rs_OnlyResource1"></asp:Label>
                        </td>
                    </tr>--%>
                </table>
                <table id="tblxsl" runat="server">
                    <tr>
                        <td>
                            <asp:Xml ID="Xml1" runat="server"></asp:Xml>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
