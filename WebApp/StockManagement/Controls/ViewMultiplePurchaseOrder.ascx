<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewMultiplePurchaseOrder.ascx.cs"
    Inherits="StockManagement_Controls_ViewMultiplePurchaseOrder" %>
<div id="DivPurchaseOrder" runat="server">
    <table class="w-100p a-center" border="1px">
        <tr>
            <td>
                <div id="Divpo" runat="server">
                    <table class="w-100p">
                        <tr>
                            <td class="a-center bold" colspan="4">
                                <asp:Image ID="imgBillLogo" runat="server" Visible="False" meta:resourcekey="imgBillLogoResource2" />
                                <br />
                                <asp:Label Font-Names="Verdana" ID="lblHeaderorg" runat="server" Font-Size="Larger"
                                    meta:resourcekey="lblHeaderorgResource1"></asp:Label>
                                <br />
                                <asp:Label Font-Names="Verdana" ID="lblstreet" runat="server" meta:resourcekey="lblstreetResource1"></asp:Label>
                                <br />
                                <asp:Label Font-Names="Verdana" ID="lblPhonenumber" runat="server" meta:resourcekey="lblPhonenumberResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-left" colspan="4">
                                <br />
                                <strong><u>
                                    <%=Resources.StockManagement_ClientDisplay.StockManagement_Controls_ViewMultiplePurchaseOrder_ascx_02%></u>
                                </strong>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <strong>
                                    <%=Resources.StockManagement_ClientDisplay.StockManagement_Controls_ViewMultiplePurchaseOrder_ascx_03%>
                                </strong>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="w-60p">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblVendorContactPerson" runat="server" Font-Bold="True" meta:resourcekey="lblVendorContactPersonResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblVendorName" Font-Bold="True" runat="server" meta:resourcekey="lblVendorNameResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblVendorAddress" runat="server" meta:resourcekey="lblVendorAddressResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblVendorCity" runat="server" meta:resourcekey="lblVendorCityResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Resources.StockManagement_ClientDisplay.StockManagement_Controls_ViewMultiplePurchaseOrder_ascx_04%>
                                            <asp:Label ID="lblVendorPhone" runat="server" meta:resourcekey="lblVendorPhoneResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblVendorEmail" runat="server" meta:resourcekey="lblVendorEmailResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table>
                                                <tr id="tdsuppliervedorcode" class="hide" runat="server">
                                                    <td>
                                                        <asp:Label ID="lblTin" Text=" Vendor code " Font-Bold="True" runat="server" meta:resourcekey="lblTinResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblVendorTINNo" runat="server" meta:resourcekey="lblVendorTINNoResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="tdsupplierTinNo" class="hide" runat="server">
                                                    <td>
                                                        <asp:Label ID="lblSupplierTinNotext" Text=" Vendor TIN No " Font-Bold="True" runat="server"
                                                            meta:resourcekey="lblSupplierTinNotextResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblsupplierTinno" runat="server" meta:resourcekey="lblsupplierTinnoResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="tdSupplierDLNo" class="hide" runat="server">
                                                    <td>
                                                        <asp:Label ID="lblDLNo" Text=" Vendor DL No " Font-Bold="True" runat="server" meta:resourcekey="lblDLNoResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblsupplierDLno" runat="server" meta:resourcekey="lblsupplierDLnoResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="tdventorpanno" class="hide" runat="server">
                                                    <td>
                                                        <asp:Label ID="lblVendorPanNo" Text=" Vendor PAN No " Font-Bold="True" runat="server"
                                                            meta:resourcekey="lblVendorPanNoResource1"></asp:Label>
                                                    </td>
                                                    <td cellspacing="2">
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblPanNotxt" runat="server" meta:resourcekey="lblPanNotxtResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="2" class="v-top w-40p">
                                <table class="a-right">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblPONo" Text="P.O No " Font-Bold="True" runat="server" meta:resourcekey="lblPONoResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPOID" runat="server" meta:resourcekey="lblPOIDResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblDae" Text="Date " Font-Bold="True" runat="server" meta:resourcekey="lblDaeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPODate" runat="server" meta:resourcekey="lblPODateResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblStatustxt" Text="Status " Font-Bold="True" runat="server" meta:resourcekey="lblStatustxtResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr runat="server" id="Quotationref" class="hide">
                                        <td>
                                            <asp:Label ID="lblQuotationref" Text="Quotation ref  " Font-Bold="True" runat="server"
                                                meta:resourcekey="lblQuotationrefResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblQuotationNo" runat="server" meta:resourcekey="lblQuotationNoResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr runat="server" id="QuotationDate" class="hide">
                                        <td>
                                            <asp:Label ID="lblDateFrom" Text="Quotation valid " Font-Bold="True" runat="server"
                                                meta:resourcekey="lblDateFromResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblVlaidDate" runat="server" meta:resourcekey="lblVlaidDateResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <div id="divPORateDetails" runat="server">
                                    <asp:GridView EmptyDataText="No matching records found " ID="grdResult" runat="server"
                                        AutoGenerateColumns="False" CssClass="w-100p gridView marginB10"
                                        OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource1">
                                        <HeaderStyle CssClass="gridHeader" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Product Name" DataField="ProductName" meta:resourcekey="BoundFieldResource1" />
                                            <asp:BoundField HeaderText="Location" DataField="LocationName" meta:resourcekey="BoundFieldResource2" />
                                            <asp:TemplateField HeaderText="Ordered Quantity" meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <%# Eval("Quantity")%>(
                                                    <%# Eval("Units")%>)
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Lsu Quantity" ControlStyle-Width="30PX" meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <%# Eval("Comments")%>(
                                                    <%# Eval("LSU")%>)
                                                </ItemTemplate>
                                                <ControlStyle Width="30px"></ControlStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Unit Price(Rs.)" DataField="Rate" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N}"
                                                meta:resourcekey="BoundFieldResource3">
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField HeaderText="Discount(%)" DataField="Discount" ItemStyle-HorizontalAlign="Right"  DataFormatString="{0:N}"
                                                meta:resourcekey="BoundFieldResource4">
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField HeaderText="Vat(%)" DataField="Vat" ItemStyle-HorizontalAlign="Right"  DataFormatString="{0:N}"
                                                meta:resourcekey="BoundFieldResource5">
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField HeaderText="Total Amount(Rs.)" DataField="Amount" ItemStyle-HorizontalAlign="Right"  DataFormatString="{0:N}"
                                                 meta:resourcekey="BoundFieldResource6">
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div id="divPOQuantityDetails" runat="server">
                                    <asp:GridView EmptyDataText="No matching records found " ID="grdPOQuantityResult"
                                        runat="server" AutoGenerateColumns="False" CssClass="w-100p gridView marginB10"
                                        OnRowDataBound="grdPOQuantityResult_RowDataBound" meta:resourcekey="grdPOQuantityResultResource1">
                                        <HeaderStyle CssClass="gridHeader" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Product Name" DataField="ProductName" meta:resourcekey="BoundFieldResource7" />
                                            <asp:TemplateField HeaderText="PO Unit" meta:resourcekey="TemplateFieldResource5">
                                                <ItemTemplate>
                                                    <%# Eval("Units")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Quantity" DataField="Quantity" ItemStyle-HorizontalAlign="Right"  DataFormatString="{0:N}"
                                                meta:resourcekey="BoundFieldResource8">
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:BoundField>
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
                            <td class="v-top">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label3" Font-Bold="True" Text="Billing and Delivery Address:-" Font-Underline="True"
                                                runat="server" meta:resourcekey="Label3Resource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblOrgName" Font-Bold="True" runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblStreetAddress" runat="server" meta:resourcekey="lblStreetAddressResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblPhone" Visible="False" runat="server" meta:resourcekey="lblPhoneResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblEmail" runat="server" meta:resourcekey="lblEmailResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="tdlblOrgTIN" class="hide">
                                                    <td>
                                                        <asp:Label ID="lblOrgTIN" runat="server" Font-Bold="True" meta:resourcekey="lblOrgTINResource1">
                                                                         <%=Resources.StockManagement_ClientDisplay.StockManagement_Controls_ViewMultiplePurchaseOrder_ascx_05%>
                                                        </asp:Label>
                                                        <asp:Label ID="lblOrgTINNo" runat="server" meta:resourcekey="lblOrgTINNoResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="tdlblOrgDL" class="hide">
                                                    <td>
                                                        <asp:Label ID="lblOrgDL" runat="server" Font-Bold="True" meta:resourcekey="lblOrgDLResource1">
                                                                         <%=Resources.StockManagement_ClientDisplay.StockManagement_Controls_ViewMultiplePurchaseOrder_ascx_06%>
                                                        </asp:Label>
                                                        <asp:Label ID="lblOrgDLNo" runat="server" meta:resourcekey="lblOrgDLNoResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="3" class="a-right" id="tdcalculation" runat="server">
                                <table>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblGrossAmttxt" Text="Gross amount" runat="server" meta:resourcekey="lblGrossAmttxtResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblGrossAmt" runat="server" meta:resourcekey="lblGrossAmtResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblPODisctxt" Text="P.O discount(%)" runat="server" meta:resourcekey="lblPODisctxtResource1"></asp:Label>
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
                                            <asp:Label ID="lblTotalDiscounttxt" Text="Total discount amount " runat="server"
                                                meta:resourcekey="lblTotalDiscounttxtResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblTotalDiscount" Width="50px" runat="server" Text="0.00" meta:resourcekey="lblTotalDiscountResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblTotalTaxAmounttxt" Text="Total VAT amount " runat="server" meta:resourcekey="lblTotalTaxAmounttxtResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblTotaltax" Width="50px" runat="server" Text="0.00" meta:resourcekey="lblTotaltaxResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblFreightCourierchargestxt" Text="Freight/Courier charges" runat="server"
                                                meta:resourcekey="lblFreightCourierchargestxtResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblFreightCouriercharges" runat="server" meta:resourcekey="lblFreightCourierchargesResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblNetAmttxt" Text="Net amount " Font-Bold="True" runat="server" meta:resourcekey="lblNetAmttxtResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblNetAmt" Font-Bold="True" runat="server" meta:resourcekey="lblNetAmtResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trPackingSale" runat="server" class="visibilityHide a-right">
                                        <td class="a-left">
                                            <asp:Label ID="lblPackingSale" runat="server" Text="Packing Sale :" meta:resourcekey="lblPackingSaleResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lbltxtPackingSale" Width="70px" runat="server" CssClass="clearLeft ui-tabs"
                                                Text="0.00" meta:resourcekey="lbltxtPackingSaleResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trExciseDuty" runat="server" class="visibilityHide">
                                        <td class="a-left">
                                            <asp:Label ID="lblExciseDuty" runat="server" Text="Excise Duty :" meta:resourcekey="lblExciseDutyResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lbltxtExciseDuty" Width="70px" runat="server" Text="0.00"
                                                meta:resourcekey="lbltxtExciseDutyResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trEduCess" runat="server" class="visibilityHide">
                                        <td class="a-left">
                                            <asp:Label ID="lblEduCess" runat="server" Text="Edu Cess :" meta:resourcekey="lblEduCessResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lbltxtEduCess" Width="70px" runat="server" Text="0.00"
                                                meta:resourcekey="lbltxtEduCessResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trSecCess" runat="server" class="visibilityHide">
                                        <td class="a-left">
                                            <asp:Label ID="lblSecCess" runat="server" Text="Sec Cess :" meta:resourcekey="lblSecCessResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lbltxtSecCess" Width="70px" runat="server" Text="0.00"
                                                meta:resourcekey="lbltxtSecCessResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trTotal" runat="server" class="visibilityHide">
                                        <td class="a-left">
                                            <asp:Label ID="Label2" runat="server" Text="Total " meta:resourcekey="Label2Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lbltxtTotal" Width="70px" runat="server" Text="0.00"
                                                meta:resourcekey="lbltxtTotalResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trCST" runat="server" class="visibilityHide">
                                        <td class="a-left">
                                            <asp:Label ID="lblCSTTax" runat="server" Text="CST :" meta:resourcekey="lblCSTTaxResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lbltxtCST" Width="70px" runat="server" CssClass="Align" Text="0.00"
                                                meta:resourcekey="lbltxtCSTResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-left v-top" colspan="2" runat="server" id="tdcomments">
                                <table class="w-100p">
                                    <tr>
                                        <td class="w-20p v-top">
                                            <asp:Label ID="Label1" Text="Comments: " runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                                        </td>
                                        <%--<td width="80%" style=" word-wrap: break-all " >
                                                                <asp:Label ID="lblComments" runat="server" style="word-wrap: break-all "></asp:Label>
                                                                
                                                            </td>--%>
                                        <td class="w-80p">
                                            <asp:Label ID="lblComments" runat="server" meta:resourcekey="lblCommentsResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="trNotes" runat="server">
                            <td colspan="4">
                                <table cellpadding="5">
                                    <tr>
                                        <td id="Td1" runat="server" class="a-left bold">
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
                            <td colspan="4" class="a-center">
                                <table cellpadding="w-100p">
                                    <tr>
                                        <td class="w-33p">
                                            <asp:Literal ID="litPrepared" runat="server" meta:resourcekey="litPreparedResource1"></asp:Literal>
                                            <asp:Label Style="font-weight: bold;" ID="lblSign" runat="server" Text="<br><br>Prepared By"
                                                meta:resourcekey="lblSignResource1"></asp:Label>
                                        </td>
                                        <td class="w-33p">
                                            <asp:Label Style="font-weight: bold;" ID="lblauthorized" runat="server" Text="<br><br>Authorized By"
                                                meta:resourcekey="lblauthorizedResource1"></asp:Label>
                                        </td>
                                        <td class="w-34p">
                                            <asp:Literal ID="litApprovedBy" runat="server" meta:resourcekey="litApprovedByResource1"></asp:Literal>
                                            <asp:Label Style="font-weight: bold;" ID="lblapproved" runat="server" Text="<br>Approved By"
                                                meta:resourcekey="lblapprovedResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="approvalTR" class="hide a-left" runat="server">
                            <td colspan="4">
                                <table class="w-100p" cellpadding="5">
                                    <tr>
                                        <td class="bold">
                                            <%=Resources.StockManagement_ClientDisplay.StockManagement_Controls_ViewMultiplePurchaseOrder_ascx_06%>
                                        </td>
                                        <td id="approvedDateTD" class="w-80p a-left" runat="server">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="bold">
                                            <%=Resources.StockManagement_ClientDisplay.StockManagement_Controls_ViewMultiplePurchaseOrder_ascx_06%>
                                        </td>
                                        <td id="approvedByTD" runat="server">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <table class="w-100p">
                    <tr>
                        <td>
                            <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                         <%--   <table id="tprint" runat="server" align="center">
                                <tr>
                                    <td id="tdBack" runat="server">
                                    </td>
                                    <td align="center">
                                        <asp:Button ID="btnprint" Text="Print" OnClientClick="return popupprint();" Width="40px"
                                            runat="server" CssClass="btn" onmouseover="this.classname='btn btnhov'" onmouseout="this.classname='btn'"
                                            meta:resourcekey="btnprintResource1" />
                                    </td>
                                </tr>
                            </table>--%>
                              <asp:Button ID="btnprint" Text="Print" OnClientClick="return popupprint();" Width="40px"
                                            runat="server" CssClass="btn"
                                            meta:resourcekey="btnprintResource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
<asp:HiddenField ID="hdnGetTaxList" runat="server" />

    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
<script type="text/javascript">

    $(function() {
        if ($('#'+'<%=hdnGetTaxList.ClientID %>').val() != '') {
            var myJSONText = $('#hdnGetTaxList').val();
            var Tax = JSON.parse(myJSONText);
            BindTaxTypes(Tax);
        }
    });

    function BindTaxTypes(Taxmaster) {
        $.each(Taxmaster, function(index, Tax) {
            switch (Tax.TaxName) {
                case "PackingSale":
                    $('#trPackingSale').css("visibility", "visible");
                    $('#lblPackingSale').html("Packing Sale(" + Tax.TaxPercent + "%" + ")");
                    break;

                case "ExciseDuty":
                    $('#trExciseDuty').css("visibility", "visible");
                    $('#lblExciseDuty').html("Excise Duty(" + Tax.TaxPercent + "%" + ")");
                    break;

                case "EduCess":
                    $('#trEduCess').css("visibility", "visible");
                    $('#lblEduCess').html("Edu Cess(" + Tax.TaxPercent + "%" + ")");
                    break;

                case "SecCess":
                    $('#trSecCess').css("visibility", "visible");
                    $('#lblSecCess').html("Sec Cess(" + Tax.TaxPercent + "%" + ")");
                    break;

                case "CST":
                    $('#trCST').css("visibility", "visible");
                    $('#lblCSTTax').html("CST(" + Tax.TaxPercent + "%" + ")");
                    break;

                default:
                    break;
            }
        });
        $('#trTotal').css("visibility", "visible");
        //  $('#lbltxtTotal').html(TotalCalculation($('#lblNetAmt').html(), $('#lbltxtPackingSale').html(), $('#lbltxtExciseDuty').html(), $('#lbltxtEduCess').html(), $('#lbltxtSecCess').html()));
        $('#lbltxtTotal').html(TotalCalculation(ToInternalFormat($('#lblNetAmt')), ToInternalFormat($('#lbltxtPackingSale')), ToInternalFormat($('#lbltxtExciseDuty')), ToInternalFormat($('#lbltxtEduCess')), ToInternalFormat($('#lbltxtSecCess'))));
        ToTargetFormat($('#lbltxtTotal'));
    }


    function TotalCalculation(NetTotal, PackingSale, ExciseDuty, EduCess, SecCess) {
        var TotalSum = parseFloat(NetTotal) + parseFloat(PackingSale) + parseFloat(ExciseDuty) + parseFloat(EduCess) + parseFloat(SecCess);
        var Total = parseFloat(TotalSum).toFixed(2);
        return Total;
    }
</script>

