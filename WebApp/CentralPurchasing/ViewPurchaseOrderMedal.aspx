<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewPurchaseOrderMedal.aspx.cs"
    EnableEventValidation="false" Inherits="CentralPurchasing_ViewPurchaseOrderMedal" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Purchase Order</title>
  
    <script language="javascript" type="text/javascript">
        function CallPrint() {
            var prtContent = document.getElementById('Divpo');
            document.getElementById('btnBack').style.display = "none";
            document.getElementById('btnPrint').style.display = "none";
            var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            document.getElementById('btnBack').style.display = "inline-block";
            document.getElementById('btnPrint').style.display = "inline-block";
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <div id="Divpo" runat="server">
            <table class="w-100p a-center" align="center">
                                 <tr>
                                     <td>
                        <table class="w-100p">
                                            <tr>
                                                <td class="a-center bold" align="center"  colspan="4">
                                                    <br />
                                                    <strong><u>
                                                        <%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_ViewPurchaseOrderMedal_aspx_01%></u>
                                                    </strong>
                                                </td>
                                            </tr>
                                             <tr>
                                <td class="w-70p" colspan="4">
                                                    <asp:Image ID="imgBillLogo" runat="server" class="hide" meta:resourcekey="imgBillLogoResource2" />
                                                    <br />
                                                    <asp:Label Font-Names="Verdana" ID="lblHeaderorg" runat="server" 
                                                        Font-Size="Larger" class="bold" meta:resourcekey="lblHeaderorgResource1"></asp:Label>
                                                    <br />
                                                    <asp:Label Font-Names="Verdana" ID="lblstreet" runat="server" 
                                                        meta:resourcekey="lblstreetResource1"></asp:Label>
                                                    <br />
                                                    <asp:Label Font-Names="Verdana" ID="lblPhonenumber" runat="server" 
                                                        meta:resourcekey="lblPhonenumberResource1"></asp:Label>
                                                </td>
                                            </tr>
                         
                                            <tr>
                                                <td class="bold a-left" colspan="4">
                                                        <%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_ViewPurchaseOrderMedal_aspx_02%>
                                                </td>
                                            </tr>
                                            <tr>
                                <td colspan="2" class="w-60p" >
                                    <table class="w-100p a-left" >
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblVendorContactPerson" runat="server" class="bold"  style="font-weight:bold;"
                                                                    meta:resourcekey="lblVendorContactPersonResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblVendorName" class="bold" runat="server" 
                                                                    meta:resourcekey="lblVendorNameResource1"></asp:Label>
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
                                                                <%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_ViewPurchaseOrderMedal_aspx_03%>
                                                                <asp:Label ID="lblVendorPhone" runat="server" 
                                                                    meta:resourcekey="lblVendorPhoneResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblVendorEmail" runat="server" 
                                                                    meta:resourcekey="lblVendorEmailResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                <table class="w-100p a-left" >
                                                                    <tr id="tdsuppliervedorcode" class="hide" style="display:none;" runat="server">
                                                                        <td>
                                                                            <asp:Label ID="lblTin" Text=" Vendor code " CssClass="bold" runat="server" 
                                                                                meta:resourcekey="lblTinResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td  >
                                                                            <asp:Label ID="lblVendorTINNo" runat="server" 
                                                                                meta:resourcekey="lblVendorTINNoResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="tdsupplierTinNo" style="display:none;" class="hide" runat="server">
                                                                        <td>
                                                                            <asp:Label ID="lblSupplierTinNotext" Text=" Vendor TIN No " CssClass="bold" 
                                                                                runat="server" meta:resourcekey="lblSupplierTinNotextResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td >
                                                                            <asp:Label ID="lblsupplierTinno" runat="server" 
                                                                                meta:resourcekey="lblsupplierTinnoResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="tdSupplierDLNo" style="display:none;" class="hide" runat="server">
                                                                        <td>
                                                                            <asp:Label ID="lblDLNo" Text=" Vendor DL No " CssClass="bold" runat="server" 
                                                                                meta:resourcekey="lblDLNoResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td > 
                                                                            <asp:Label ID="lblsupplierDLno" runat="server" 
                                                                                meta:resourcekey="lblsupplierDLnoResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="tdventorpanno" style="display:none;" class="hide" runat="server">
                                                                        <td>
                                                                            <asp:Label ID="lblVendorPanNo" Text=" Vendor PAN No " CssClass="bold" 
                                                                                runat="server" meta:resourcekey="lblVendorPanNoResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            :
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblPanNotxt" runat="server" 
                                                                                meta:resourcekey="lblPanNotxtResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td colspan="2" class="v-top w-50p" width="50%">
                                                    <table class="a-right w-100p" width="100%">
                                                        <tr>
                                                            <td class="a-right" align="right" >
                                                                <asp:Label ID="lblPONo" Text="P.O No " class="bold" runat="server" 
                                                                    meta:resourcekey="lblPONoResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td class="w-50p a-left" width="75%" align="left">
                                                                <asp:Label ID="lblPOID" runat="server" meta:resourcekey="lblPOIDResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right" align="right">
                                                                <asp:Label ID="lblDae" Text="Date " class="bold" runat="server" 
                                                                    meta:resourcekey="lblDaeResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td  class="w-75p a-left" width="75%" align="left">
                                                                <asp:Label ID="lblPODate" runat="server" meta:resourcekey="lblPODateResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right" align="right">
                                                                <asp:Label ID="lblStatustxt" Text="Status " class="bold" runat="server" 
                                                                    meta:resourcekey="lblStatustxtResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td  class="w-75p a-left" width="75%" align="left">
                                                                <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="Quotationref" class="hide" style="display:none;">
                                                            <td class="a-right" align="right">
                                                                <asp:Label ID="lblQuotationref" Text="Quotation ref  " class="bold" 
                                                                    runat="server" meta:resourcekey="lblQuotationrefResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td  class="w-75p a-left" width="75%" align="left">
                                                                <asp:Label ID="lblQuotationNo" runat="server" 
                                                                    meta:resourcekey="lblQuotationNoResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="QuotationDate" class="hide" style="display:none;">
                                                            <td class="a-right" align="right">
                                                                <asp:Label ID="lblDateFrom" Text="Quotation valid " CssClass="bold" 
                                                                    runat="server" meta:resourcekey="lblDateFromResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td  class="w-75p a-left" width="75%" align="left">
                                                                <asp:Label ID="lblVlaidDate" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <div id="divPORateDetails" runat="server" >
                                                        <asp:GridView EmptyDataText="No matching records found " ID="grdResult"
                                                            runat="server" AutoGenerateColumns="False" ForeColor="#333333" 
                                                            Width="100%" CssClass="gridView"
                                                            OnRowDataBound="grdResult_RowDataBound" 
                                                            meta:resourcekey="grdResultResource1">
                                                            <HeaderStyle CssClass="gridHeader" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="SL No." 
                                                                    meta:resourcekey="TemplateFieldResource1">
                                                                    <ItemTemplate>
                                                                        <%#Container.DataItemIndex+1 %>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField HeaderText="Product Name" DataField="ProductName" 
                                                                    meta:resourcekey="BoundFieldResource1" />
                                                                 <asp:BoundField HeaderText="Product Description" DataField="ProductDescription" />
                                                                <asp:BoundField HeaderText="Location" DataField="LocationName" 
                                                                    meta:resourcekey="BoundFieldResource2" />
                                                                <asp:TemplateField HeaderText="Ordered Qty"
                                                                    meta:resourcekey="TemplateFieldResource2">
                                                                    <ItemTemplate>
                                                                        <%# Eval("Quantity")%>
                                                                        <%# Eval("Units")%>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="LSU Qty" ControlStyle-Width="30PX" 
                                                                    meta:resourcekey="TemplateFieldResource3">
                                                                    <ItemTemplate>
                                                                        <%# Eval("Comments")%>
                                                                        <%# Eval("LSU")%>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField HeaderText="Unit Price(Rs.)" DataField="Rate" 
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource3" />
                                                                <asp:BoundField HeaderText="Discount(%)" DataField="Discount" 
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource4" />
                                                                <asp:BoundField HeaderText="Vat(%)" DataField="Vat" 
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource5" />
                                                                <asp:BoundField HeaderText="Total Amount(Rs.)" DataField="Amount" ItemStyle-HorizontalAlign="Right"
                                                                    DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource6" >

                                                                </asp:BoundField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                    <div id="divPOQuantityDetails" runat="server">
                                                     <asp:GridView EmptyDataText="No matching records found " ID="grdPOQuantityResult"
                                                            runat="server" AutoGenerateColumns="False" ForeColor="#333333" 
                                                            Width="100%" CssClass="gridView"
                                                            OnRowDataBound="grdPOQuantityResult_RowDataBound" 
                                                            meta:resourcekey="grdPOQuantityResultResource1">
                                                            <HeaderStyle CssClass="gridHeader" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="SL No." 
                                                                    meta:resourcekey="TemplateFieldResource4">
                                                                    <ItemTemplate>
                                                                        <%#Container.DataItemIndex+1 %>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField HeaderText="Product Name" DataField="ProductName" 
                                                                    meta:resourcekey="BoundFieldResource7" />
                                                                <asp:TemplateField HeaderText="PO Unit" 
                                                                    meta:resourcekey="TemplateFieldResource5">
                                                                    <ItemTemplate> 
                                                                        <%# Eval("Units")%>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                  <asp:BoundField HeaderText="Quantity" DataField="Quantity" 
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource8" >
                                                                </asp:BoundField>
                                                          <%--      <asp:TemplateField HeaderText="Quantity" ControlStyle-Width="30PX">
                                                                    <ItemTemplate  >
                                                                    <
                                                                       <%# Eval("Quantity")%>
                                                                      
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>--%>
                                                               <%-- <asp:BoundField HeaderText="Unit Price(Rs.)" DataField="Rate" ItemStyle-HorizontalAlign="Right" />
                                                                <asp:BoundField HeaderText="Discount(%)" DataField="Discount" ItemStyle-HorizontalAlign="Right" />
                                                                <asp:BoundField HeaderText="Vat(%)" DataField="Vat" ItemStyle-HorizontalAlign="Right" />
                                                                <asp:BoundField HeaderText="Total Amount(Rs.)" DataField="Amount" ItemStyle-HorizontalAlign="Right"
                                                                    DataFormatString="{0:0.00}" />--%>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" id="commentsTD" runat="server">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="v-top w-80p" width="80%">
                                                    <table>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="Label3" CssClass="bold underline" Text="Billing and Delivery Address:-"
                                                                    runat="server" meta:resourcekey="Label3Resource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table>
                                                                    <tr>
                                                                        <td class="a-left">
                                                                            <asp:Label ID="lblOrgName" Font-Bold="True" runat="server" 
                                                                                meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="a-left">
                                                                            <asp:Label ID="lblStreetAddress" runat="server" 
                                                                                meta:resourcekey="lblStreetAddressResource1"></asp:Label>
                                                                            <%--<b>As Above</b>--%>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="a-left">
                                                                            <asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="a-left">
                                                                            <asp:Label ID="lblPhone" Visible="False" runat="server" 
                                                                                meta:resourcekey="lblPhoneResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="a-left">
                                                                            <asp:Label ID="lblEmail" runat="server" meta:resourcekey="lblEmailResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr runat="server" id="tdlblOrgTIN" class="hide" style="display:none;">
                                                                        <td class="a-left">
                                                                            <asp:Label ID="lblOrgTIN" runat="server" CssClass="bold" 
                                                                                meta:resourcekey="lblOrgTINResource1">
                                                                         <%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_ViewPurchaseOrderMedal_aspx_04%>
                                                                            </asp:Label>
                                                                            <asp:Label ID="lblOrgTINNo" runat="server" 
                                                                                meta:resourcekey="lblOrgTINNoResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr runat="server" id="tdlblOrgDL" class="hide" style="display:none;">
                                                                        <td class="a-left">
                                                                            <asp:Label ID="lblOrgDL" runat="server" CssClass="bold" 
                                                                                meta:resourcekey="lblOrgDLResource1">
                                                                         <%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_ViewPurchaseOrderMedal_aspx_05%>
                                                                            </asp:Label>
                                                                            <asp:Label ID="lblOrgDLNo" runat="server" 
                                                                                meta:resourcekey="lblOrgDLNoResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td colspan="3" class="hide a-right" id="tdcalculation" runat="server">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblGrossAmttxt" Text="Gross amount" runat="server" 
                                                                    meta:resourcekey="lblGrossAmttxtResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lblGrossAmt" runat="server" 
                                                                    meta:resourcekey="lblGrossAmtResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblPODisctxt" Text="P.O discount(%)" runat="server" 
                                                                    meta:resourcekey="lblPODisctxtResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lblPODisc" runat="server" meta:resourcekey="lblPODiscResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblTotalDiscounttxt" Text="Total discount amount " 
                                                                    runat="server" meta:resourcekey="lblTotalDiscounttxtResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lblTotalDiscount" Width="50px" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lblTotalDiscountResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblTotalTaxAmounttxt" Text="Total VAT amount " runat="server" 
                                                                    meta:resourcekey="lblTotalTaxAmounttxtResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lblTotaltax" Width="50px" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lblTotaltaxResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblFreightCourierchargestxt" Text="Freight/Courier charges" 
                                                                    runat="server" meta:resourcekey="lblFreightCourierchargestxtResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lblFreightCouriercharges" runat="server" 
                                                                    meta:resourcekey="lblFreightCourierchargesResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblNetAmttxt" Text="Net amount " CssClass="bold" runat="server" 
                                                                    meta:resourcekey="lblNetAmttxtResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lblNetAmt"  CssClass="bold" runat="server" 
                                                                    meta:resourcekey="lblNetAmtResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr id="trPackingSale" runat="server" style="visibility: hidden"  class="a-right">
                                                            <td align="left">
                                                                <asp:Label ID="lblPackingSale" runat="server" Text="Packing Sale :" 
                                                                    meta:resourcekey="lblPackingSaleResource1"></asp:Label>
                                                            </td>
                                                              <td>
                                                                :
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="lbltxtPackingSale" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lbltxtPackingSaleResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr id="trExciseDuty" runat="server"  class="hide">
                                                            <td class="a-left">
                                                                <asp:Label ID="lblExciseDuty" runat="server" Text="Excise Duty :" 
                                                                    meta:resourcekey="lblExciseDutyResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lbltxtExciseDuty" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lbltxtExciseDutyResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr id="trEduCess" runat="server"  class="hide">
                                                            <td class="a-left">
                                                                <asp:Label ID="lblEduCess" runat="server" Text="Edu Cess :" 
                                                                    meta:resourcekey="lblEduCessResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lbltxtEduCess" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lbltxtEduCessResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr id="trSecCess" runat="server"  class="hide">
                                                            <td class="a-left">
                                                                <asp:Label ID="lblSecCess" runat="server" Text="Sec Cess :" 
                                                                    meta:resourcekey="lblSecCessResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lbltxtSecCess" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lbltxtSecCessResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr id="trTotal" runat="server"  class="hide">
                                                            <td class="a-left">
                                                                <asp:Label ID="Label2" runat="server" Text="Total " 
                                                                    meta:resourcekey="Label2Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lbltxtTotal"  runat="server" Text="0.00" 
                                                                    meta:resourcekey="lbltxtTotalResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr id="trCST" runat="server"  class="hide">
                                                            <td class="a-left">
                                                                <asp:Label ID="lblCSTTax" runat="server" Text="CST :" 
                                                                    meta:resourcekey="lblCSTTaxResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                :
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lbltxtCST" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lbltxtCSTResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left v-top" runat="server" id="tdcomments">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-20p v-top">
                                                                <asp:Label ID="Label1" Text="Comments: " runat="server" 
                                                                    meta:resourcekey="Label1Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblComments" runat="server" CssClass="word-wrap: break-all" 
                                                                    meta:resourcekey="lblCommentsResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr id="trNotes" runat="server">
                                                <td colspan="4">
                                                    <table>
                                                        <tr>
                                                            <td id="Td1" class="a-left bold" runat="server">
                                                                <asp:Label runat="server" Text="For terms and conditions , pl. refer to annexure"
                                                                    ID="lbltermcon" meta:resourcekey="lbltermconResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblNotes" runat="server" meta:resourcekey="lblNotesResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                <td colspan="4" class="a-center paddingT10" >
                                                    <%--  <asp:Label ID="lblNotes" runat="server" Text="1.Delivery:- With in 2 days from the date of order <br>2.Payment:- 45 days from the date of Invoice<br>3.You should produce original invoice and  Delivery challan with goods received seal and signed by <br>&nbsp;&nbsp;&nbsp;&nbsp;Center Manager	Without Delivery challan & PO copy, your invoice will not be processed.<br>4.Please communicate the status to Head Office after delivery <br><br> (for Medall Healthcare Pvt Ltd)</br>"></asp:Label>--%>
                                                    <table width="100%">
                                                        <tr>
                                            <td class="a-left v-bottom w-33p">
														        <asp:Literal ID="litPrepared" runat="server" 
                                                                    meta:resourcekey="litPreparedResource1"></asp:Literal><br />
                                                                <asp:Label Style="font-weight: bold;" ID="lblSign" runat="server" 
                                                                    Text="Prepared By" meta:resourcekey="lblSignResource1"></asp:Label>
                                                            </td>
                                            <td class="a-left v-bottom w-33p">
                                                                <asp:Label Style="font-weight: bold;" ID="lblauthorized" runat="server" 
                                                                    Text="Authorized By" meta:resourcekey="lblauthorizedResource1"></asp:Label>
                                                            </td>
                                            <td class="w-34p">
                                                                <asp:Literal ID="litApprovedBy" runat="server" 
                                                                    meta:resourcekey="litApprovedByResource1"></asp:Literal><br />
                                                           <asp:Image ID="imgApprovedsigin" runat="server" Class="hide"  /><br />
                                                                <asp:Label Style="font-weight: bold;" ID="lblapproved" runat="server" 
                                                                    Text="Approved By" meta:resourcekey="lblapprovedResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                            </table>
                                            </td>
                                            </tr>
                            <tr id="approvalTR" class="a-left hide" runat="server">
                                                <td colspan="4">
                                                    <table width="100%" cellpadding="5" cellspacing="0" border="0">
                                                        <tr>
                                                            <td class="bold">
                                                                <%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_ViewPurchaseOrderMedal_aspx_06%>
                                                            </td>
                                                            <td id="approvedDateTD" class="a-left w-80p" runat="server">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="bold">
                                                                <%=Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_ViewPurchaseOrderMedal_aspx_07%>
                                                            </td>
                                                            <td id="approvedByTD" runat="server">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                    <td class="a-center">
                        <table class="w-100p">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblMessage" runat="server" 
                                                        meta:resourcekey="lblMessageResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                <td class="a-center">
                                    <table id="tprint" runat="server" class="w-100p">
                                                        <tr>
                                                            <td id="tdBack" runat="server" class="a-right">
                                                                <asp:Button ID="btnBack" Text="Back" runat="server" CssClass="cancel-btn" 
                                                                    OnClick="btnBack_Click" meta:resourcekey="btnBackResource1" />
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:Button ID="btnPrint" Text="Print" OnClientClick="CallPrint();return false;"
                                                                    Width="40px" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                    onmouseout="this.className='btn'" meta:resourcekey="btnPrintResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
    <asp:HiddenField ID="hdnGetTaxList" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" Value="" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
</body>
</html>
<script type="text/javascript" src="../PlatForm/Scripts/Json_BrowserSupport.js"></script>
<script type="text/javascript">

    $(function () {
        if ($('#hdnGetTaxList').val() != '') {
            var myJSONText = $('#hdnGetTaxList').val();
            var Tax = JSON.parse(myJSONText);
            BindTaxTypes(Tax);
        }
    });


    function BindTaxTypes(Taxmaster) {
        var strPackingSale = SListForAppDisplay.Get("CentralPurchasing_ViewPurchaseOrderMedal_aspx_09") == null ? "Packing Sale" : SListForAppDisplay.Get("CentralPurchasing_ViewPurchaseOrderMedal_aspx_09");
        var strexciseduty = SListForAppDisplay.Get("CentralPurchasing_ViewPurchaseOrderMedal_aspx_10") == null ? "Excise Duty" : SListForAppDisplay.Get("CentralPurchasing_ViewPurchaseOrderMedal_aspx_10");
        var streducess = SListForAppDisplay.Get("CentralPurchasing_ViewPurchaseOrderMedal_aspx_11") == null ? "Edu Cess" : SListForAppDisplay.Get("CentralPurchasing_ViewPurchaseOrderMedal_aspx_11");
        var strSecCess = SListForAppDisplay.Get("CentralPurchasing_ViewPurchaseOrderMedal_aspx_12") == null ? "Sec Cess" : SListForAppDisplay.Get("CentralPurchasing_ViewPurchaseOrderMedal_aspx_12");
        var strCST = SListForAppDisplay.Get("CentralPurchasing_ViewPurchaseOrderMedal_aspx_13") == null ? "CST" : SListForAppDisplay.Get("CentralPurchasing_ViewPurchaseOrderMedal_aspx_13");
        
        $.each(Taxmaster, function (index, Tax) {
            switch (Tax.TaxName) {
                case "PackingSale":
                    $('#trPackingSale').css("visibility", "visible");
                    $('#lblPackingSale').html(strPackingSale+"(" + Tax.TaxPercent + "%" + ")");
                    break;

                case "ExciseDuty":
                    $('#trExciseDuty').css("visibility", "visible");
                    $('#lblExciseDuty').html(strexciseduty+"(" + Tax.TaxPercent + "%" + ")");
                    break;

                case "EduCess":
                    $('#trEduCess').css("visibility", "visible");
                    $('#lblEduCess').html(streducess+"(" + Tax.TaxPercent + "%" + ")");
                    break;

                case "SecCess":
                    $('#trSecCess').css("visibility", "visible");
                    $('#lblSecCess').html(strSecCess+"(" + Tax.TaxPercent + "%" + ")");
                    break;

                case "CST":
                    $('#trCST').css("visibility", "visible");
                    $('#lblCSTTax').html(strCST+"(" + Tax.TaxPercent + "%" + ")");
                    break;

                default:
                    break;
            }
        });
        $('#trTotal').css("visibility", "visible");
        $('#lbltxtTotal').html(TotalCalculation($('#lblNetAmt').html(), $('#lbltxtPackingSale').html(), $('#lbltxtExciseDuty').html(), $('#lbltxtEduCess').html(), $('#lbltxtSecCess').html()));
    }


    function TotalCalculation(NetTotal, PackingSale, ExciseDuty, EduCess, SecCess) {
        var TotalSum = parseFloat(NetTotal) + parseFloat(PackingSale) + parseFloat(ExciseDuty) + parseFloat(EduCess) + parseFloat(SecCess);
        var Total = parseFloat(TotalSum).toFixed(2);
        return Total;
    }
</script>

