<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CreditdebitSummary.ascx.cs" Inherits="CommonControls_CreditdebitSummary" %>
<style type="text/css">
    .style2
    {
        width: 25%;
    }
</style>
<script language="javascript">

    function fnCallPrint(pControlsvalues) {
        var prtContent = document.getElementById(pControlsvalues);
        var WinPrint = window.open('', '', 'left=-1,top=-1,width=10,height=10,toolbar=0,scrollbars=0,status=0');
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();

    }
</script>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<table width="100%" align="center" border="0" id="tblClientPrint" runat="server">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" style="font-family: Verdana;" cellpadding="0"
                align="center" id="tbl1" runat="server">
                <tr>
                    <td colspan="7" align="center">
                        <asp:Image ID="imgBillLogo" runat="server" Visible="False" />
                    </td>
                </tr>
                <tr>
                    <td colspan="7" align="center">
                        <label style="font-family: Arial; font-size: medium;" id="lblHospitalName" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="7" align="right" id="tdReceiptType" runat="server">
                        <asp:Label ID="Rs_CreditorDebit"  runat="server" 
                            style="font-weight: 700; font-size: large" ></asp:Label>
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
                                    <asp:Label ID="lblclnt" Text="To" runat="server"  />
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblClientName" runat="server" Style="font-weight: 400;" ></asp:Label>
                                </td>
                                <td width="15%">
                                <asp:Label ID="lblDate" Text="Date"  runat=server>
                                </asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td width="15%">
                                <asp:Label ID="lblDateoutput" runat="server" ></asp:Label>
                                </td>
                                <%--<td>
                                <asp:Label ID="lbl
                                </td>--%>
                                <%--<td nowrap="nowrap" align="left">
                                    <asp:Label ID="Rs_Date" Text="Reference Number" runat="server" 
                                        meta:resourceKey="Rs_DateResource2" />
                                </td>
                                <td>
                                    :
                                </td>--%>
                               <%-- <td>
                                    <asp:Label ID="lblReferenceID1" runat="server" Style="font-weight: 400;" ></asp:Label>
                                </td>--%>
                            </tr>
                            <%--<tr>
                                <td>
                                    <asp:Label ID="Rs_PaidDate" Text="Client Type" runat="server" />
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblClienttype1" runat="server" Style="font-weight: 400;" ></asp:Label>
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="Rs_ReceiptNumber" Text="Amount" runat="server"  />
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblAmountcredit" runat="server" Style="font-weight: 400;"></asp:Label>
                                </td>
                            </tr>--%>
                           <%-- <tr>
                                <td>
                                    <asp:Label ID="Label1" Text="Reason" runat="server" />
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Reason" runat="server" Style="font-weight: 400;" ></asp:Label>
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="Label3" Text="AuthorizedBy" runat="server"  />
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Authorized" runat="server" Style="font-weight: 400;"></asp:Label>
                                </td>
                            </tr>--%>
                            <tr>
                            <td>
                                    <asp:Label ID="lbl_RcptNo" Text="Address" runat="server" />
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lbl_Address" runat="server" Style="font-weight: 400;" ></asp:Label>
                                </td>
                                <td>
                                <asp:Label ID="lbl_CreditNoteNumber" Text="Note Number" runat="server">
                                </asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                <asp:Label ID="lbl_CreditNoteNumberoutput" runat="server">
                                </asp:Label>
                                </td>
                               <%-- <td>
                                <asp:Label ID="lbl_InvoiceNumber"  Text="Number" runat="server"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td width="10%">
                                <asp:Label ID="lbl_referenceNo"  runat="server"></asp:Label>                                
                                </td>--%>
                                
                            </tr>
                            <tr>
                            <td width="10%">
                            <asp:Label ID="lbl_reason" runat="server" Text="Reason" >
                            </asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                            <asp:Label ID="lbl_reasonoutput" runat="server" >
                            </asp:Label>
                            </td> 
                            <td>  
                            <asp:Label ID="lbl_remar" Text="Remarks" runat="server">
                            </asp:Label>                          
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                            <asp:Label ID="lbl_remarkoutput" runat="server"></asp:Label>
                            </td>
                            </tr>
                            <tr>                            
                            </tr>
                            </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="7" style="font-weight: bold;">
                        <asp:Label ID="Rs_PaymentDetails" runat="server" Text="Payment Details:" ></asp:Label>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td colspan="7" align="center">
                        <div id="dvAdvance" runat="server" align="center">
                            <asp:Label ID="lblAmountType" runat="server" Text="Advance Payment" style="display:none"></asp:Label>
                        </div>
                        <div id="dvGenerateBill" runat="server" visible="false" align="center">
                            <asp:Label ID="lblGenerateBillAmt" runat="server" ></asp:Label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="dvDetails" runat="server">
                        <table class="dataheaderInvCtrl" border="1" cellpadding="3" cellspacing="0" width="100%">
                        <tr style="height: 10px;">
                            <td style="width: 25%;" align="left">
                                <asp:Label runat="server" ID="lblclint" Text="Particulars"  />
                            </td>
                            <%--<td style="width: 25%;" align="left">
                                <asp:Label runat="server" ID="lblpayType" Text="Deposited Date"  />
                            </td>--%>
                            <td style="width: 25%;" align="left">
                                <asp:Label runat="server" ID="lblAmount1" Text="Amount" />
                            </td>
                        
                        </tr>
                        <tr><td>
                                    <asp:Label ID="lblClienttype" runat="server" 
                                Style="font-weight: 400;" ></asp:Label>
                                -
                                
                                <asp:Label ID="lblReferenceID" Visible="true" runat="server" Style="font-weight: 400;" ></asp:Label>
                                </td>
                               <%-- <td>
                                    <asp:Label ID="lblInvoiceDate1" runat="server" Style="font-weight: 400;" ></asp:Label>
                                </td>--%>
                                <td>
                                    <asp:Label ID="lblAmountcredit" runat="server" Style="font-weight: 400;"></asp:Label>
                                </td></tr>
                        </table>
                        </div>
                        <div>
                        </div>
                        <div id="DvAuthorizeDetails" runat="server">
                        <table class="dataheaderInvCtrl" border="0" cellpadding="3" cellspacing="0" width="100%">
                        <tr style="height: 10px;">
                            <td style="width: 25%;" align="left" colspan="2">
                            <asp:Label ID="lblAuthorize" runat="server" Text="AuthorizeBy"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                        <td class="style2">
                        <asp:Label ID="lblAuthorizer" Text="Authorizer Name" runat="server"></asp:Label>
                         <asp:Label ID="lblAuthorzeroutput" runat="server"></asp:Label>
                        </td>
                        <td>
                        
                        </td>
                        <td>
                        <asp:Label ID="lbl_Signature" runat="server" Text="Signature">
                        </asp:Label>
                        </td>
                        <td>                       
                        <asp:Label ID="lblDateoutputAuthorize" runat="server"></asp:Label>                        
                        </td>
                        <td align="right">
                        <asp:Label ID="LabelDate1" Text="Date" runat="server"></asp:Label>
                        </td>
                       
                        <td align="left" width="18%">
                        <asp:Label ID="lblDateoutputAuth" runat="server"></asp:Label>
                        </td>                                              
                        </tr>
                        
                        </table>
                        </div>
                        <div>                        
                        </div>
                        <div>
                        </div>
                        <div>
                        </div>
                        <div>
                        </div>
                        <div>
                        <table align="right" runat="server"  > 
                        <tr> 
                        <td>
                        <asp:Label ID="lbl_bill" Text="Billed By" runat="server"></asp:Label>
                        </td>                            
                        </tr>
                        <tr>
                        </tr>  
                        <tr>
                        </tr>
                        <tr>
                        <td>
                        <asp:Label ID="lbl_Billedoutput" runat="server"></asp:Label>                        
                        </td>
                        </tr>    
                        </table>
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
                        <%--<table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="width: 30%">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td style="padding-top: 5px;" class="style1">
                                                <b>
                                                    <asp:Label ID="Rs_PaymentMode" runat="server" Text="Payment Mode"  ></asp:Label></b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="lblPaymentMode" ></asp:Label>
                                                <span id="lblPayMode" runat="server"></span>
                                            </td>
                                        </tr>
                                        <tr id="trDeposit" runat="server" style="display: block">
                                            <td>
                                                <asp:Label Visible="False" ID="lblDepositAmtUsed" runat="server" ></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 100%">
                                    <%--<table cellpadding="2" cellspacing="2" border="0" width="100%">
                                        <tr>
                                            <td style="width:95%" align="right">
                                                <asp:Label ID="Rs_Total" runat="server" Text="Total :" ></asp:Label>
                                                
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblTotal" runat="server"  />
                                            </td>
                                        </tr>
                                        <tr id="trRoundOffAmount" runat="server">
                                            <td align="right">
                                                <asp:Label ID="lblRoundOffAmount" runat="server" Text="Round Off Amount :" ></asp:Label>
                                                
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblRoundOffAmountText" runat="server" Text="0.00" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="Rs_AmountReceived" Text="Amount Received" runat="server"  />:
                                                
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblAmountRecieved" runat="server" />
                                            </td>
                                        </tr>
                                    </table>--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trPreviousReceipt" runat="server" style="display: none;">
                    <td colspan="7">
                        <asp:Label ID="lblFinalReceiptAmount" runat="server" Text="0.00" ></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <asp:Label runat="server" ID="lblOtherCurrency" ></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:Label ID="lblPayingCurrency" runat="server" ></asp:Label>
                        <asp:Label ID="lblPayingCurrencyinWords" runat="server" ></asp:Label>
                    </td>
                </tr>
               <%-- <tr>
                    <td colspan="7">
                        <asp:Label ID="Rs_AmountinWords" Text="Amount in Words" runat="server"  />:
                        <asp:Label ID="lblCurrency" runat="server"  />-<asp:Label
                            ID="lblAmount" runat="server" ></asp:Label>
                    </td>
                </tr>--%>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <asp:Label ID="lblBilledBy" runat="server"  />
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
               <%-- <tr>
                    <td colspan="7">
                        <div id="dvDisclaimer" runat="server">
                            <asp:Label ID="Rs_Disclaimer" Text="Disclaimer" runat="server"  />:
                            <asp:Label ID="Rs_info" Text=" This is only an cash&nbsp; receipt. This receipt cannot
                            be used for claiming purpose." runat="server"  />
                        </div>
                    </td>
                </tr>--%>
                <tr>
                   
                    <td colspan="7" style="display: none;" width="100%" runat="server" id="tdPrint" enableviewstate="false">
                    </td>
                </tr>
                <tr>
                <td colspan="7" align="center">
            
                </td>
                </tr>
            </table>
        <%--</td>
    </tr>
</table>--%>
<input type="hidden" id="hdnpaymode" runat="server" />
