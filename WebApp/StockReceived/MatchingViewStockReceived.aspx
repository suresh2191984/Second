<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MatchingViewStockReceived.aspx.cs"
    Inherits="StockReceived_MatchingViewStockReceived" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body >
    <form id="form1" runat="server">
    
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager> 
    <attune:attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdatapopup">
        <div id="divPrint" class="show" runat="server">
            <table class="w-550">
                <tr>
                    <td class="a-right paddingR10 black">
                        <b id="printText" runat="server">
                        <asp:Label ID="lblPrintReport" Text="Print Report" runat="server" 
                            meta:resourcekey="lblPrintReportResource1"></asp:Label>
                        </b>&nbsp;&nbsp;
                        <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                            ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                    </td>
                </tr>
            </table>
        </div>
        <div id="divReceived">
            <table class="w-100p paddingL10">
                <tr>
                    <td colspan="2" class="a-center bold font18">
                    <asp:Label ID="lblMatchStkReceived" Text="Matching StockReceived" runat="server" 
                            meta:resourcekey="lblMatchStkReceivedResource1"></asp:Label>
                        
                    </td>
                </tr>
                <tr>
                    <td class="w-70p">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblOrgName" Font-Bold="True" Font-Size="Medium" runat="server" 
                                        meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblOrgTinnotxt" Font-Bold="True" Text="TIN No :" runat="server" 
                                        meta:resourcekey="lblOrgTinnotxtResource1"></asp:Label>
                                    <asp:Label ID="lblOrgTinno" runat="server" 
                                        meta:resourcekey="lblOrgTinnoResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblOrgDlnotxt" Font-Bold="True" Text="DL No :" runat="server" 
                                        meta:resourcekey="lblOrgDlnotxtResource1"></asp:Label>
                                    <asp:Label ID="lblorgDlno" runat="server" 
                                        meta:resourcekey="lblorgDlnoResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblStreetAddress" runat="server" 
                                        meta:resourcekey="lblStreetAddressResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblPhone" runat="server" meta:resourcekey="lblPhoneResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="h-10">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblVendorName" Font-Bold="True" Font-Size="Medium" 
                                        runat="server" meta:resourcekey="lblVendorNameResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblVendorTinnotxt" Font-Bold="True" Text="TIN No :" 
                                        runat="server" meta:resourcekey="lblVendorTinnotxtResource1"></asp:Label>
                                    <asp:Label ID="lblVendorTinno" runat="server" 
                                        meta:resourcekey="lblVendorTinnoResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblVendorAddress" runat="server" 
                                        meta:resourcekey="lblVendorAddressResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblVendorCity" runat="server" 
                                        meta:resourcekey="lblVendorCityResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblVendorPhone" runat="server" 
                                        meta:resourcekey="lblVendorPhoneResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td class="a-right w-30p paddingR20">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblDate" runat="server" Text="Date" 
                                        meta:resourcekey="lblDateResource1"></asp:Label>:
                                </td>
                                <td class="a-left">
                                    &nbsp; &nbsp;<asp:Label ID="lblSRDate" runat="server" 
                                        meta:resourcekey="lblSRDateResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblPONo" runat="server" Text="P.O No" 
                                        meta:resourcekey="lblPONoResource1"></asp:Label>:
                                </td>
                                <td class="a-left">
                                    &nbsp; &nbsp;
                                    <asp:Label ID="lblPOID" runat="server" meta:resourcekey="lblPOIDResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblReceivedNo" runat="server" Text="Received No" 
                                        meta:resourcekey="lblReceivedNoResource1"></asp:Label>:
                                </td>
                                <td class="a-left">
                                    &nbsp; &nbsp;
                                    <asp:Label ID="lblReceivedID" runat="server" 
                                        meta:resourcekey="lblReceivedIDResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblMatchingInvoiceNo" Text=" Matching Invoice No" runat="server" 
                                        meta:resourcekey="lblMatchingInvoiceNoResource1"></asp:Label>:
                                </td>
                                <td class="a-left">
                                    &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblMatchingInvoiceNotxt" runat="server" 
                                        meta:resourcekey="lblMatchingInvoiceNotxtResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblInvoiceNotxt" Text="Invoice No" runat="server" 
                                        meta:resourcekey="lblInvoiceNotxtResource1"></asp:Label>:
                                </td>
                                <td class="a-left">
                                    &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblInvoiceNo" runat="server" 
                                        meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" Text="DC No" runat="server" 
                                        meta:resourcekey="Label1Resource1"></asp:Label>:
                                </td>
                                <td class="a-left">
                                    &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblDCNo" runat="server" 
                                        meta:resourcekey="lblDCNoResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblStatustxt" runat="server" Text="Status" 
                                        meta:resourcekey="lblStatustxtResource1"></asp:Label>:
                                </td>
                                <td class="a-left">
                                    &nbsp; &nbsp;
                                    <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="h-20">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="a-left">
                                    <table cellpadding="4" cellspacing="4">
                                        <tr>
                                            <td class="v-top">
                                            <asp:Label ID="lblNote" Text="Note :" runat="server" 
                                                    meta:resourcekey="lblNoteResource1"></asp:Label>
                                                
                                            </td>
                                            <td class="v-bottom">
                                                * <asp:Label ID="lblBatchNo" Text="No Batch No." runat="server" 
                                                    meta:resourcekey="lblBatchNoResource1" ></asp:Label>
                                                <br />
                                                ** <asp:Label ID="lblExporMft" Text="No Exp or Mft Date." runat="server" 
                                                    meta:resourcekey="lblExporMftResource1" ></asp:Label>
                                                
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table class="w-100p">
                <tr>
                    <td class="w-15">
                        <asp:HiddenField ID="hdnIsResdCalc" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:GridView CellSpacing="2" EmptyDataText="No matching records found " ID="grdResult"
                            runat="server" CssClass="gridView w-100p" AutoGenerateColumns="False" OnRowDataBound="grdResult_RowDataBound"
                            meta:resourcekey="grdResultResource1">
                            <Columns>
                                <asp:BoundField HeaderText="Product" DataField="ProductName" 
                                    meta:resourcekey="BoundFieldResource1" />
                                <asp:BoundField HeaderText="Batch No" DataField="BatchNo" 
                                    meta:resourcekey="BoundFieldResource2" />
                                <asp:TemplateField HeaderText="Date" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        MFT :<%# GetDate(Eval("Manufacture", "{0:MMM-yyyy}"))%><br />
                                        EXP :<%# GetDate(Eval("ExpiryDate", "{0:MMM-yyyy}"))%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PO Qty" 
                                    meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <%# Eval("POQuantity")%>
                                        (<%# Eval("POUnit")%>)
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rcvd Qty(lsu)" 
                                    meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <%# Eval("RcvdLSUQty")%>
                                        (<%# Eval("SellingUnit")%>)
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Comp Qty(lsu)" 
                                    meta:resourcekey="TemplateFieldResource4">
                                    <ItemTemplate>
                                        <%# Eval("ComplimentQTY")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Billing Price" 
                                    meta:resourcekey="TemplateFieldResource5">
                                    <ItemTemplate>
                                        <%# Eval("Description")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Aggregate Price" 
                                    meta:resourcekey="TemplateFieldResource6">
                                    <ItemTemplate>
                                        <%# Eval("Unit")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Discount (%)" DataField="Discount" 
                                    meta:resourcekey="BoundFieldResource3" />
                                <asp:BoundField HeaderText="Ex (%)" DataField="ExciseTax" 
                                    meta:resourcekey="BoundFieldResource4" />
                                <asp:BoundField HeaderText="Tax (%)" DataField="Tax" 
                                    meta:resourcekey="BoundFieldResource5" />
                                <asp:TemplateField HeaderText="Selling Price" 
                                    meta:resourcekey="TemplateFieldResource7">
                                    <ItemTemplate>
                                        <%# Eval("Quantity")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="MRP" DataField="MRP" 
                                    meta:resourcekey="BoundFieldResource6" />
                                <asp:BoundField HeaderText="Total Cost" DataField="TotalCost" 
                                    meta:resourcekey="BoundFieldResource7" />
                            </Columns>
                        </asp:GridView>
                        <input id="hdnCollectedItems" runat="server" type="hidden" />
                        <input id="hdnConsumableItems" runat="server" type="hidden" />
                        <input id="hdnStatus" runat="server" type="hidden" />
                    </td>
                </tr>
                <tr>
                    <td class="a-right" colspan="3">
                        <table class="w-30p">
                            <tr>
                                <td class="a-right">
                                <asp:Label ID="lblTotalSales1" Text="Total Sales :" runat="server" 
                                        meta:resourcekey="lblTotalSales1Resource1" ></asp:Label>
                                   &nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblTotalSales" Width="70px" runat="server" Text="0.00" 
                                        meta:resourcekey="lblTotalSalesResource1"></asp:Label>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                <asp:Label ID="lblTotalDisAmt" Text="Total Discount Amount :" runat="server" 
                                        meta:resourcekey="lblTotalDisAmtResource1" ></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblTotalDiscount" Width="70px" runat="server" Text="0.00" 
                                        meta:resourcekey="lblTotalDiscountResource1"></asp:Label>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                <asp:Label ID="lblTotalTaxAmt" Text="Total Tax Amount :" runat="server" 
                                        meta:resourcekey="lblTotalTaxAmtResource1" ></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblTotaltax" Width="70px" runat="server" Text="0.00" 
                                        meta:resourcekey="lblTotaltaxResource1"></asp:Label>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                <asp:Label ID="lblTotalEx" Text="Total Excise :" runat="server" 
                                        meta:resourcekey="lblTotalExResource1" ></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblTotalExcise" Width="70px" runat="server" Text="0.00" 
                                        meta:resourcekey="lblTotalExciseResource1"></asp:Label>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                <asp:Label ID="lblcessOnEx" Text="Cess On Excise 2%:" runat="server" 
                                        meta:resourcekey="lblcessOnExResource1" ></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblCessOnExcise" Width="70px" runat="server" Text="0.00" 
                                        meta:resourcekey="lblCessOnExciseResource1"></asp:Label>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                <asp:Label ID="lblHigheredCess1" Text="Highter Ed.Cess 1%:" runat="server" 
                                        meta:resourcekey="lblHigheredCess1Resource1" ></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblHighterEdCess" Width="70px" runat="server" Text="0.00" 
                                        meta:resourcekey="lblHighterEdCessResource1"></asp:Label>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                <asp:Label ID="lblCST1" Text="CST 5%:" runat="server" 
                                        meta:resourcekey="lblCST1Resource1" ></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblCST" Width="70px" runat="server" Text="0.00" 
                                        meta:resourcekey="lblCSTResource1"></asp:Label>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                <asp:Label ID="lblSupplierServiceTax" Text="Supplier Service Tax(%) :" 
                                        runat="server" meta:resourcekey="lblSupplierServiceTaxResource1" ></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblTax" Width="70px" runat="server" Text="0.00" 
                                        meta:resourcekey="lblTaxResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                <asp:Label ID="lblPODis" Text="PO Discount :" runat="server" 
                                        meta:resourcekey="lblPODisResource1" ></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblDiscount" Width="70px" runat="server" Text="0.00" 
                                        meta:resourcekey="lblDiscountResource1"></asp:Label>
                                </td>
                            </tr>
                            
                             <tr>
                                <td class="a-right">
                                <asp:Label ID="lblFreightCharge" Text="Freight Charges :" runat="server" 
                                        meta:resourcekey="lblFreightChargeResource1" ></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblFreightCharges" Width="70px" runat="server" Text="0.00" 
                                        meta:resourcekey="lblFreightChargesResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                <asp:Label ID="lblTotal" Text="Total :" runat="server" 
                                        meta:resourcekey="lblTotalResource1" ></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblGrountTotal" Width="70px" runat="server" Text="0.00" 
                                        meta:resourcekey="lblGrountTotalResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                <asp:Label ID="lblRoundOffValue1" Text="RoundOff Value :" runat="server" 
                                        meta:resourcekey="lblRoundOffValue1Resource1" ></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblRoundOffValue" Width="70px" runat="server" Text="0.00" 
                                        meta:resourcekey="lblRoundOffValueResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                <asp:Label ID="lblGrandTotal" Text="Grand Total :" runat="server" 
                                        meta:resourcekey="lblGrandTotalResource1" ></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblGrandwithRoundof" Width="70px" runat="server" Text="0.00" 
                                        meta:resourcekey="lblGrandwithRoundofResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" id="commentsTD" runat="server">
                    </td>
                </tr>
                <tr id="approvalTR" class="hide" runat="server">
                    <td colspan="3">
                        <%--<table width="100%" cellpadding="5" cellspacing="0" border="0">
                                            <tr>
                                                <td style="font-weight: bold;">
                                                    Approved Date :
                                                </td>
                                                <td id="approvedDateTD" style="width: 80%; font-weight: bold;" align="left" runat="server">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight: bold;">
                                                    Approved By :
                                                </td>
                                                <td id="approvedByTD" style="width: 80%;" align="left" runat="server">
                                                </td>
                                            </tr>
                                        </table>--%>
                    </td>
                </tr>
                <tr>
                    <td class="h-10">
                    </td>
                </tr>
                <tr>
                    <td class="a-center" colspan="3">
                        <asp:Label ID="lblMessage" runat="server" 
                            meta:resourcekey="lblMessageResource1"></asp:Label>
                    </td>
                    <td>
                        <input type="hidden" id="hdnApproveStockReceived" runat="server" />
                    </td>
                </tr>
                <tr class="a-center">
                    <td>
                        <asp:Button ID="Button1" runat="server" CssClass="btn" Text="Close" 
                            OnClientClick="popupClose()" meta:resourcekey="Button1Resource1" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
     <attune:attunefooter ID="Attunefooter" runat="server" />
      <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </form>
    
    <script language="javascript" type="text/javascript">

        function popupprint() {
            var prtContent = document.getElementById('divReceived');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;
        }

        function popupClose() {
            window.close();
            return false;
        }
    </script>
    
</body>
</html>
