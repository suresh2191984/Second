<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="ReceiveStock.aspx.cs"
    Inherits="StockReceived_ReceiveStock" meta:resourcekey="PageResource2" %>

<%@ Register Src="~/InventoryCommon/Controls/INVAttributes.ascx" TagName="INVAttributes"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Receive Stock</title>
    <style type="text/css">
        .cancel-btn {
            background: #ccc !important;
            color: #555555 !important;
        }

        .searchPanel .panelContent td span {
            padding-left: 0 !important;
        }

        #innerDiv {
            display: none !important;
        }

        .ww-300 {
            width: 300px;
        }

        .right0 {
            right: 0;
        }
    </style>

</head>
<body>
    <form id="prFrm" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
            <Services>
                <asp:ServiceReference Path="~/InventoryCommon/WebService/InventoryWebService.asmx" />
            </Services>
        </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <script language="javascript" src="Scripts/InvStockReceive.js" type="text/javascript"></script>
        <div class="contentdata">
            <table class="w-100p ">
                <tr class="panelHeader hide">
                    <td colspan="5">
                        <div id="ACX2OPPmt" class="hide" runat="server">
                            &nbsp;<img src="../PlatForm/Images/ShowBids.gif" alt="Show" class="v-top w-16 h-18 pointer"
                                onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);" />
                            <span class="pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);">&nbsp;<asp:Label ID="lblPurchaseOrderList" runat="server" Text="Purchase Order List"
                                meta:resourcekey="lblPurchaseOrderListResource1"></asp:Label></span>
                        </div>
                        <div id="ACX2minusOPPmt" runat="server">
                            &nbsp;<img src="../PlatForm/Images/HideBids.gif" alt="hide" class="v-top w-16 h-18 pointer"
                                onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);" />
                            <span class="pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);">&nbsp;<asp:Label ID="lblPurchaseOrderList2" runat="server" Text="Purchase Order List"
                                meta:resourcekey="lblPurchaseOrderList2Resource1"></asp:Label></span>
                        </div>
                    </td>
                </tr>
                <tr id="ACX2responsesOPPmt" runat="server">
                    <td colspan="5">
                        <div>
                            <asp:GridView ID="grdResult" EmptyDataText="No Matching Records Found!" runat="server"
                                AllowPaging="True" CellPadding="3" AutoGenerateColumns="False" DataKeyNames="OrderNo"
                                OnRowDataBound="grdResult_RowDataBound" OnPageIndexChanging="grdResult_PageIndexChanging"
                                PageSize="14" CssClass="responstable w-100p" OnRowCommand="grdResult_RowCommand" meta:resourcekey="grdResultResource2">
                                <HeaderStyle CssClass="responstableHeader" />
                                <PagerStyle CssClass="pagination-ys" HorizontalAlign="Right" />
                                <Columns>
                                    <asp:BoundField Visible="false" DataField="OrderId" HeaderText="Order No" meta:resourcekey="BoundFieldResource10" />
                                    <asp:TemplateField ItemStyle-Width="2%" HeaderText="Select" HeaderStyle-HorizontalAlign="Left"
                                        meta:resourcekey="TemplateFieldResource4">
                                        <ItemTemplate>
                                            <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="OrderSelect"
                                                meta:resourcekey="rdSelResource2" />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle Width="2%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="OrderNo" HeaderText="Order No" HeaderStyle-HorizontalAlign="left"
                                        ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource11">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="15%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PoNo" Visible="true" HeaderText="Supplier" ItemStyle-Width="40%"
                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource12">
                                        <ItemStyle HorizontalAlign="Left" Width="40%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Status" Visible="true" HeaderText="Status" ItemStyle-Width="12%"
                                        ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource13">
                                        <ItemStyle HorizontalAlign="Center" Width="12%"></ItemStyle>
                                    </asp:BoundField>
                                    <%--<asp:BoundField DataField="OrderDate" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}"
                                    ItemStyle-Width="25%" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                    meta:resourcekey="BoundFieldResource14">
                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="25%"></ItemStyle>
                                </asp:BoundField>--%>
                                    <asp:TemplateField HeaderText="Date" meta:resourcekey="BoundFieldResource14">
                                        <ItemTemplate>
                                            <span>
                                                <%#((DateTime)DataBinder.Eval(Container.DataItem, "OrderDate")).ToString(DateFormat)%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource5">
                                        <ItemTemplate>
                                            <asp:Button ID="btnReceivedPO" runat="server" Text="Cancel" CssClass="cancel-btn"
                                                meta:resourcekey="btnReceivedPOResource2" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <br />
                        </div>
                        <div id="tdgo" class="hide a-center">
                            <asp:Button ID="btnGo" runat="server" Text="GO" CssClass="btn" OnClientClick="return CheckPoNo();"
                                OnClick="btnGo_Click" meta:resourcekey="btnGoResource2" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td></td>
                </tr>
            </table>
            <table id="tabRecd" runat="server" class="w-100p hide searchPanel">
                <tr>
                    <td class="v-top w-40p">
                        <table id="stockReceivedTab" runat="server" class="w-100p hide">
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblPurchesOrder" runat="server" Text="Purchase Order No" meta:resourcekey="lblPurchesOrderResource2"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <asp:TextBox ID="txtPurchaseOrderNo" runat="server" MaxLength="255" Rows="2" CssClass="small"
                                        onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtPurchaseOrderNoResource2"></asp:TextBox>
                                    &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblReceivedDate" runat="server" Text="Received Date" meta:resourcekey="lblReceivedDateResource2"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <asp:TextBox ID="txtReceivedDate" runat="server" onkeypress="return ValidateSpecialAndNumeric(this);"
                                        CssClass="small datePickerPres" meta:resourcekey="txtReceivedDateResource2"></asp:TextBox>
                                    &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblSupplierName" runat="server" Text="Supplier Name" CssClass="small"
                                        meta:resourcekey="lblSupplierNameResource2"></asp:Label>
                                </td>
                                <td>
                                    <div id="divsup1" runat="server" class="hide">
                                        <asp:DropDownList onchange="javascript:funcChangeType();" ID="ddlSupplier" CssClass="small a-right"
                                            runat="server" meta:resourcekey="ddlSupplierResource2">
                                        </asp:DropDownList>
                                    </div>
                                    <asp:TextBox ID="txtSupplierName" runat="server" ReadOnly="True" MaxLength="255"
                                        onkeypress="return ValidateMultiLangChar(this);" CssClass="small" meta:resourcekey="txtSupplierNameResource2"></asp:TextBox>
                                    &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                    <input type="hidden" id="hdnSupplierID" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblDCNumber" runat="server" Text="DC Number" meta:resourcekey="lblDCNumberResource2"></asp:Label>
                                    <asp:Label ID="lblDCNumber1" CssClass="hide" runat="server" Text="Ref. Inv No." meta:resourcekey="lblDCNumber1Resource2"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDCNumber" runat="server" MaxLength="50" onkeypress="return ValidateMultiLangChar(this) && KeyPress1(event)"
                                        onBlur="return getvalidation(event);" CssClass="small" meta:resourcekey="txtDCNumberResource2"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompleteDcNumber" runat="server" CompletionInterval="1"
                                        CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                        CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                        MinimumPrefixLength="1" OnClientItemSelected="ChkDcSupplierCombination" ServiceMethod="GetSuppliernumcombination"
                                        ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" TargetControlID="txtDCNumber"
                                        DelimiterCharacters="" Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                    &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                    <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblInvoiceNo" runat="server" Text="Invoice No" meta:resourcekey="lblInvoiceNoResource2"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtInvoiceNo" runat="server" MaxLength="50" onkeypress="return ValidateMultiLangChar(this) && KeyPress2(event)"
                                        onBlur="return getvalidation(event);" CssClass="small" meta:resourcekey="txtInvoiceNoResource2"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompleteInvoiceNumber" runat="server" CompletionInterval="1"
                                        CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                        CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                        MinimumPrefixLength="1" OnClientItemSelected="ChkInvoiceSupplierCombination"
                                        ServiceMethod="GetSuppliernumcombination" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                        TargetControlID="txtInvoiceNo" DelimiterCharacters="" Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                    &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                    <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="Label2" runat="server" Text="Invoice Date" meta:resourcekey="Label2Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtInvoiceDate" runat="server" CssClass="small datePickerPres"
                                        onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtInvoiceDateResource1"></asp:TextBox>
                                    <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblComments" runat="server" Text="Comments" meta:resourcekey="lblCommentsResource2"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtComments" TextMode="MultiLine" onkeypress="return ValidateMultiLangChar(this);"
                                        runat="server" Columns="21" Rows="1" meta:resourcekey="txtCommentsResource2"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"></td>
                            </tr>
                        </table>
                    </td>
                    <td class="v-top w-60p">
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <div class="auto">
                                        <asp:Table runat="server" ID="stockReceivedDetailsTab" CssClass="w-100p" meta:resourcekey="stockReceivedDetailsTabResource2">
                                        </asp:Table>
                                        <asp:GridView ID="gvReceivedDetails" EmptyDataText="No Matching Records Found!" runat="server"
                                            AllowPaging="True" CellPadding="2" OnPageIndexChanging="gvReceivedDetails_PageIndexChanging"
                                            OnRowDataBound="gvReceivedDetails_RowDataBound" CssClass="gridView w-100p" CellSpacing="2"
                                            AutoGenerateColumns="False" PageSize="100" meta:resourcekey="gvReceivedDetailsResource2">
                                            <HeaderStyle CssClass="gridHeader" />
                                            <Columns>
                                                <asp:BoundField DataField="ProductName" HeaderText="Product Name" meta:resourcekey="BoundFieldResource15" />
                                                <asp:BoundField DataField="POQuantity" HeaderText="Ordered Qty" meta:resourcekey="BoundFieldResource16" />
                                                <asp:BoundField DataField="Unit" HeaderText="Unit" meta:resourcekey="BoundFieldResource17" />
                                                <asp:BoundField DataField="RECQuantity" HeaderText="Received Quantity" meta:resourcekey="BoundFieldResource18" />
                                                <asp:BoundField DataField="ComplimentQty" HeaderText="CompQty" meta:resourcekey="BoundFieldResource19" />
                                                <asp:BoundField DataField="PurchaseTax" HeaderText="PurchaseTax(%)" HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide" meta:resourcekey="BoundFieldResource20" />
                                                <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource6">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnAction" runat="server" Text="Add" CssClass="btn" meta:resourcekey="btnActionResource2" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <center>
                <asp:Panel ID="pnAddList" runat="server" meta:resourcekey="pnAddListResource2">
                    <table class="w-100p hide lineHeight searchPanel padding5" runat="server" id="TableProductDetails">
                        <tr runat="server" class="panelContent">
                            <td class="hide" colspan="2" runat="server">
                                <strong style="padding-bottom: 15px">
                                    <asp:Label ID="lblCategory" runat="server" Text="Category" meta:resourcekey="lblCategoryResource1"></asp:Label></strong>
                                &nbsp;
                            <asp:DropDownList ID="ddlCategory" CssClass="ddl" runat="server" meta:resourcekey="ddlCategoryResource1">
                            </asp:DropDownList>
                            </td>
                            <td>
                                <strong>
                                    <asp:Label ID="lblProductName" runat="server" Text="ProductName" meta:resourcekey="lblProductNameResource1"></asp:Label></strong>
                            </td>
                            <td colspan="3" runat="server">
                                <asp:TextBox ID="txtProductName" CssClass="larger bg-searchimage" onkeypress="return ValidateMultiLangChar(this);"
                                    runat="server"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    CompletionListItemCssClass="wordWheel itemsMain" EnableCaching="False" FirstRowSelected="True"
                                    MinimumPrefixLength="1" OnClientItemSelected="fnSelectedProducts" ServiceMethod="GetProductsListforSrickReceiveJSON"
                                    ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" TargetControlID="txtProductName"
                                    DelimiterCharacters="" Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                            <td>
                                <strong>
                                    <asp:Label ID="lblPOQty" runat="server" Text="PO Qty" meta:resourcekey="lblPOQtyResource1"></asp:Label></strong>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPoQuantity" onkeypress="return ValidateSpecialAndNumeric(this);"
                                    runat="server" CssClass="xsmaller a-right" meta:resourcekey="txtPoQuantityResource1"></asp:TextBox>
                            </td>
                            <td>
                                <strong>
                                    <asp:Label ID="lblPOUnit" runat="server" Text="PO Unit" meta:resourcekey="lblPOUnitResource1"></asp:Label></strong>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPoUnit" runat="server" onkeypress="return ValidateMultiLangChar(this);"
                                    CssClass="xsmaller" meta:resourcekey="txtPoUnitResource1"></asp:TextBox>
                            </td>
                            <td class="a-left">
                                <strong>
                                    <asp:Label ID="lblTotalAmount" runat="server" Text="Total Amount" meta:resourcekey="lblTotalAmountResource1"></asp:Label></strong>
                            </td>
                            <td>
                                <asp:Label ID="lblTotalCostAmount" Text="0.00" runat="server" Width="70px" meta:resourcekey="lblTotalCostAmountResource1" />
                            </td>
                        </tr>
                        <tr class="panelContent">
                            <td class="w-7p">
                                <asp:Label ID="lblBatchNo" runat="server" Text="BatchNo" meta:resourcekey="lblBatchNoResource1"></asp:Label>
                            </td>
                            <td id="Td1" class="a-left w-8p">
                                <asp:TextBox ID="txtBatchNo" onkeypress="return ValidateMultiLangChar(this)"
                                    TabIndex="1" runat="server" CssClass="xsmaller" meta:resourcekey="txtBatchNoResource1"></asp:TextBox>
                            </td>

                            <td class="w-9p">
                                <asp:Label ID="lblMFTDate" runat="server" Text="MFT Date" meta:resourcekey="lblMFTDateResource1"></asp:Label>
                            </td>
                            <td id="Td2" class="a-left w-9p">
                                <asp:TextBox ID="txtMFTDate" TabIndex="2" CssClass="monthYearPicker xsmaller" onkeypress="return ValidateSpecialAndNumeric(this);"
                                    onblur="return checkDate1(this.id);" runat="server" ReadOnly="true" meta:resourcekey="txtMFTDateResource1"></asp:TextBox>
                            </td>

                            <td class="w-11p">
                                <asp:Label ID="lblEXPDate" runat="server" Text="EXP Date" meta:resourcekey="lblEXPDateResource1"></asp:Label>
                            </td>
                            <td id="Td3" class="a-left w-9p">
                                <asp:TextBox ID="txtEXPDate" TabIndex="3" onblur="return checkDate1(this.id);" CssClass="monthYearPicker xsmaller"
                                    ReadOnly="true" onkeypress="return ValidateSpecialAndNumeric(this);" runat="server"
                                    meta:resourcekey="txtEXPDateResource1"></asp:TextBox>
                            </td>
                            <td class="w-9p">
                                <strong>
                                    <asp:Label ID="lblRcvdUnit" runat="server" Text="Rcvd Unit" meta:resourcekey="lblRcvdUnitResource1"></asp:Label></strong>
                                <%--<asp:TextBox ID="txtRcvdUnit" runat="server" onkeypress="return ValidateMultiLangChar(this);"
                                CssClass="smaller" meta:resourcekey="txtRcvdUnitResource1"></asp:TextBox>--%>
                            </td>
                            <td class="w-8p">
                                <asp:DropDownList ID="ddlRecUnit" CssClass="w-81" runat="server" onchange="return ChangeConvesionQty();">
                                </asp:DropDownList>
                            </td>
                            <td class="w-9p">
                                <asp:Label ID="lblRcvdQty" runat="server" Text="Rcvd Qty" meta:resourcekey="lblRcvdQtyResource1"></asp:Label>
                            </td>
                            <td id="Td4" class="a-left w-7p">
                                <asp:TextBox ID="txtRECQuantity" TabIndex="4" CssClass="xsmaller a-right" onblur="CheckRcvdLSUQty();"
                                    onkeypress="return ValidateMultiLangChar(this);" onKeyDown="return validatenumber(event);"
                                    runat="server" meta:resourcekey="txtRECQuantityResource1"></asp:TextBox>
                            </td>
                            <td id="tbllblTax" runat="server">
                                <asp:Label ID="lblTax" runat="server" Text="Tax (%)" meta:resourcekey="lblTaxResource1"></asp:Label>
                            </td>
                            <td id="tbltxtTax" runat="server">
                                <asp:TextBox ID="txtTax" TabIndex="12" onblur="TotalCalculation()" CssClass="xsmaller a-right" Enabled="false"
                                    onkeypress="return ValidateMultiLangChar(this);" runat="server" disabled="true" meta:resourcekey="txtTaxResource1"></asp:TextBox>
                                <span id="popTaxTrigger" class="ui-icon ui-icon-info inline-block"></span>
                                <div id="divTaxDetails" runat="server" class=" right0 ww-300 p-ab card-md card-md-default padding10 hide">
                                </div>
                                <asp:HiddenField ID="CheckState" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblInverseQty" runat="server" Text="Inverse Qty" meta:resourcekey="lblInverseQtyResource1"></asp:Label>
                            </td>
                            <td id="Td6">
                                <asp:TextBox ID="txtInvoiceQty" TabIndex="6" CssClass="xsmaller a-right" onblur="CheckRcvdLSUQty();"
                                    onkeypress="return ValidateSpecialAndNumeric(this);" runat="server" meta:resourcekey="txtInvoiceQtyResource1"></asp:TextBox>
                            </td>

                            <td>
                                <asp:Label ID="lblcvdQty" runat="server" Text="R'cvd Qty (LSU)" meta:resourcekey="lblcvdQtyResource1"></asp:Label>
                            </td>
                            <td id="Td7">
                                <asp:TextBox ID="txtRcvdLSUQty" TabIndex="7" CssClass="xsmaller a-right" onkeypress="return ValidateSpecialAndNumeric(this);"
                                    ReadOnly="true" runat="server" meta:resourcekey="txtRcvdLSUQtyResource1"></asp:TextBox>
                            </td>

                            <td>
                                <asp:Label ID="lblComQty" runat="server" Text="Comp. Qty(LSU)" meta:resourcekey="lblComQtyResource1"></asp:Label>
                            </td>
                            <td id="Td8" class="a-left">
                                <asp:TextBox ID="txtCompQuantity" TabIndex="8" CssClass="xsmaller a-right" onblur="CheckCompQty();"
                                    onkeypress="return ValidateMultiLangChar(this);" runat="server" meta:resourcekey="txtCompQuantityResource1"></asp:TextBox>
                            </td>

                            <td id="tdlblPurchaseTax" runat="server" class="hide">
                                <asp:Label ID="lblPurchaseTax" runat="server" Text="Purchase Tax(%)"></asp:Label>
                            </td>
                            <td id="tdPurchaseTax" align="left" runat="server" class="hide">
                                <asp:TextBox ID="txtPurchaseTax" CssClass="xsmaller" onblur="TotalCalculation()"
                                    onKeyDown="return validatenumber(event);" runat="server"></asp:TextBox>
                            </td>

                            <td runat="server">
                                <asp:Label ID="lblCostPrice" runat="server" Text="Cost Price" meta:resourcekey="lblCostPriceResource1"></asp:Label>
                            </td>
                            <td class="a-left" runat="server">
                                <asp:TextBox ID="txtUnitPrice" TabIndex="9" CssClass="xsmaller a-right" onblur="TotalCalculation()" MaxLength="20"
                                    onkeypress="return ValidateMultiLangChar(this);" runat="server" meta:resourcekey="txtUnitPriceResource1"></asp:TextBox>
                            </td>

                            <td id="Td17" class="hide" runat="server">
                                <asp:Label ID="lblNominal" runat="server" Text="Nominal" meta:resourcekey="lblNominalResource1"></asp:Label>
                            </td>
                            <td id="Td33" class="hide" runat="server">
                                <asp:TextBox ID="txtNominal" TabIndex="10" CssClass="xsmaller" onblur="TotalCalculation()"
                                    onkeypress="return ValidateMultiLangChar(this);" runat="server" meta:resourcekey="txtNominalResource1"></asp:TextBox>
                            </td>

                            <td runat="server">
                                <asp:Label ID="lblDiscount" runat="server" Text="Discount(%)" meta:resourcekey="lblDiscountResource1"></asp:Label>
                            </td>
                            <td class="a-left" runat="server">
                                <asp:TextBox ID="txtDiscount" TabIndex="11" CssClass="xsmaller a-right" onblur="TotalCalculation()"
                                    onkeypress="return ValidateMultiLangChar(this);" runat="server" meta:resourcekey="txtDiscountResource1"></asp:TextBox>
                            </td>
                            <td runat="server">
                                <asp:Label ID="lblSellingPrice" runat="server" Text="Selling Price" meta:resourcekey="lblSellingPriceResource1"></asp:Label>
                            </td>
                            <td runat="server">
                                <asp:TextBox ID="txtSellingPrice" TabIndex="13" CssClass="xsmaller a-right" onblur="AppendMRP();btnCalcSellingPrice();" MaxLength="12"
                                    onkeypress="return ValidateMultiLangChar(this);" runat="server" meta:resourcekey="txtSellingPriceResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="panelContent" runat="server">

                            <td runat="server">
                                <asp:Label ID="lblMRP" runat="server" Text="MRP/SRP" meta:resourcekey="lblMRPResource1"></asp:Label>
                            </td>
                            <td runat="server">
                                <asp:TextBox ID="txtMRP" TabIndex="14" CssClass="xsmaller a-right" onblur="btnCalcSellingPrice();"
                                    onkeypress="return ValidateMultiLangChar(this);" runat="server" meta:resourcekey="txtMRPResource1"></asp:TextBox>
                            </td>

                            <td runat="server" class="hide">
                                <asp:Label ID="lblRakNo" runat="server" Text="RakNo" meta:resourcekey="lblRakNoResource1"></asp:Label>
                            </td>
                            <td runat="server" class="hide">
                                <asp:TextBox ID="txtRakNo" TabIndex="15" CssClass="xsmaller a-right" onkeypress="return ValidateSpecialAndNumeric(this);"
                                    runat="server" meta:resourcekey="txtRakNoResource1"></asp:TextBox>
                            </td>

                            <td runat="server">
                                <asp:Label ID="lblTotalCost" runat="server" Text="Total Cost" meta:resourcekey="lblTotalCostResource1"></asp:Label>
                            </td>
                            <td class="a-left" runat="server">
                                <asp:TextBox ID="txtTotalCost" TabIndex="16" CssClass="xsmaller a-right" onkeypress="return ValidateMultiLangChar(this);"
                                    runat="server" meta:resourcekey="txtTotalCostResource1"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="lblLeastSellableUnit" runat="server" Text="Least Sellable Unit (LSU)"
                                    meta:resourcekey="lblLeastSellableUnitResource1"></asp:Label>
                            </td>
                            <td id="Td5">
                                <asp:DropDownList ID="ddlSelling" TabIndex="5" CssClass="w-81"
                                    runat="server" meta:resourcekey="ddlSellingResource1">
                                </asp:DropDownList>
                                <%--onchange="CheckInverseQty();"--%>
                            
                            </td>
                            <td class="a-left v-middle">
                                <%--<button id="add" runat="server" value='<%= Resources.StockReceived_ClientDisplay.StockReceived_ReceiveStock_aspx_03%>'  class="btn" onclick="javascript:return checkIsEmpty();"
                                tabindex="17">
                                </button>--%>
                                <a href="#" id="add" runat="server" class="btn" onclick="javascript:return checkIsEmpty();"
                                    tabindex="17"><%= Resources.StockReceived_ClientDisplay.StockReceived_ReceiveStock_aspx_03%></a>
                            </td>
                            <td class="a-left v-middle" colspan="2">
                                <a href="#" onclick="fnClear();" class="cancel-btn"><%=Resources.StockReceived_ClientDisplay.StockReceived_ReceiveStock_aspx_04 %></a>

                            </td>
                        </tr>
                        <tr class="hide" runat="server">
                            <td colspan="10" runat="server">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <uc2:INVAttributes ID="INVAttributes1" runat="server" />
                                        <asp:LinkButton ID="lbtnAttribute" runat="server" Text="More Attributes" CssClass="attribute_LnkBtn"
                                            OnClick="lbtnAttribute_Click" meta:resourcekey="lbtnAttributeResource1"></asp:LinkButton>
                                        <asp:HiddenField ID="hdnAttributeDetail" runat="server" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <br />
                <asp:Label ID="lblTableT" CssClass="w-100p font10 marginT10 marginB10" runat="server"></asp:Label>
            </center>
            <table class="w-100p hide" id="tbTotalCost">
                <tr>
                    <td class="w-100p hide" id="tdAvailableCreditAmount">
                        <asp:Label ID="lblAvailableCreditAmount" runat="server" Text="Available Credit Amount :"
                            meta:resourcekey="lblAvailableCreditAmountResource1"></asp:Label>
                        <asp:TextBox ID="txtAvailCreditAmount" ReadOnly="True" CssClass="smaller a-right"
                            onkeypress="return ValidateMultiLangChar(this);" runat="server" Text="0.00" meta:resourcekey="txtAvailCreditAmountResource2"></asp:TextBox>
                        &nbsp;
                    </td>
                    <asp:HiddenField ID="hdnAvailableCreditAmount" runat="server" />
                </tr>
                <tr>
                    <td class="a-right" colspan="4">
                        <asp:Label ID="lblTotalSales" runat="server" Text="Total Sales :" meta:resourcekey="lblTotalSalesResource1"></asp:Label>
                        <asp:TextBox ID="txtTotalSales" onkeypress="return ValidateMultiLangChar(this);"
                            runat="server" CssClass="smaller a-right" Text="0.00" meta:resourcekey="txtTotalSalesResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="a-right w-100p hide" id="lblSupplierSerTax" runat="server">
                        <asp:Label ID="lblSupplierService" runat="server" Text="Supplier Service Tax(%) :"
                            meta:resourcekey="lblSupplierServiceResource1"></asp:Label>
                        <asp:TextBox ID="txtTotaltax" MaxLength="6" onkeypress="return ValidateMultiLangChar(this);"
                            onblur="checkAddToTotal();" CssClass="smaller a-right" runat="server" Text="0.00"
                            meta:resourcekey="txtTotaltaxResource2"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="a-right">
                        <asp:Label ID="lblTotDiscountAmoun" runat="server" Text="Total Discount Amount :"
                            meta:resourcekey="lblTotDiscountAmounResource1"></asp:Label><asp:TextBox ID="txtDiscountAmt"
                                onkeypress="return ValidateMultiLangChar(this);" runat="server" CssClass="smaller a-right" Enabled="false"
                                Text="0.00" meta:resourcekey="txtDiscountAmtResource2"></asp:TextBox>
                    </td>
                </tr>
                <tr class="hide">
                    <td class="a-right" id="lblTaxPercen" runat="server">
                        <asp:Label ID="lblToTaxAmo" runat="server" Text="Total Tax Amount :" meta:resourcekey="lblToTaxAmoResource1"></asp:Label><asp:TextBox
                            ID="txtTaxAmt" runat="server" CssClass="smaller a-right" Text="0.00" onkeypress="return ValidateMultiLangChar(this);"
                            meta:resourcekey="txtTaxAmtResource2"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="a-right">
                        <asp:Label ID="lblcgst" Text="Total CGST:" runat="server" meta:resourcekey="lblcgstResource1"></asp:Label>
                        <asp:TextBox ID="txtcgst" runat="server" CssClass="smaller a-right" Enabled="False"
                            onblur="checkAddToTotal();" onKeyDown="return validatenumber(event);" runat="server"
                            Text="0.00"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="a-right">
                        <asp:Label ID="lblsgst" Text="Total SGST:" runat="server" meta:resourcekey="lblsgstResource1"></asp:Label>
                        <asp:TextBox ID="txtsgst" runat="server" CssClass="smaller a-right" Enabled="False"
                            onblur="checkAddToTotal();" onKeyDown="return validatenumber(event);" runat="server"
                            Text="0.00"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="a-right">
                        <asp:Label ID="lbligst" Text="Total IGST:" runat="server" meta:resourcekey="lbligstResource1"></asp:Label>
                        <asp:TextBox ID="txtigst" runat="server" CssClass="smaller a-right" Enabled="False"
                            onblur="checkAddToTotal();" onKeyDown="return validatenumber(event);" runat="server"
                            Text="0.00"></asp:TextBox>

                    </td>
                </tr>
                <tr>
                    <td class="a-right">
                        <asp:Label ID="lblTTAmount" runat="server" Text="Total GST Amount :" CssClass="bold" meta:resourcekey="lblTTAmountResource1"></asp:Label>
                        <asp:TextBox ID="txtTotalTaxAmt" Enabled="False" CssClass="smaller a-right" onkeypress="return ValidateMultiLangChar(this);" runat="server" Text="0.00" meta:resourcekey="txtTotalTaxAmtResource1"></asp:TextBox>
                    </td>

                </tr>
                
                 <tr id="trTCSTax" class="hide">
                    <td class="a-right">
                        <asp:Label ID="lblTCSTax" runat="server" Text="TCS Tax:" CssClass="bold" meta:resourcekey="lblTCSTaxResource1"></asp:Label>
                        <asp:TextBox ID="txtTCSTax" Enabled="False" CssClass="smaller a-right"  runat="server" Text="0.00" meta:resourcekey="lblTCSTaxResource1"></asp:TextBox>
                    </td>

                </tr>
                
                <tr>
                    <td class="a-right">
                        <asp:Label ID="lblPODiscount" runat="server" Text="PO Discount :" meta:resourcekey="lblPODiscountResource1"></asp:Label>
                        <asp:TextBox onkeypress="return ValidateMultiLangChar(this);" ID="txtTotalDiscount"
                            CssClass="smaller a-right" runat="server" Text="0.00" onblur="checkAddToTotal();"
                            meta:resourcekey="txtTotalDiscountResource2"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="a-right">
                        <asp:Label ID="lblGrandTotal" runat="server" Text="Grand Total :" meta:resourcekey="lblGrandTotalResource1"></asp:Label>
                        <asp:TextBox ID="txtGrandTotal" Enabled="False" CssClass="smaller a-right" runat="server"
                            onkeypress="return ValidateMultiLangChar(this);" Text="0.00" meta:resourcekey="txtGrandTotalResource2"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="a-right">
                        <asp:Label ID="lblcrditAmt" runat="server" Text="Credit Amount To Be Used :" meta:resourcekey="lblcrditAmtResource1"></asp:Label>
                        <asp:TextBox ID="txtUseCreditAmount" runat="server" Text="0.00" CssClass="smaller a-right"
                            onkeypress="return ValidateMultiLangChar(this);" onblur="checkAddToTotal();"
                            meta:resourcekey="txtUseCreditAmountResource2"></asp:TextBox>
                    </td>
                </tr>
                <tr id="trStampFee" runat="server">
                    <td class="a-right">
                        <asp:Label ID="lblStampFee" runat="server" Text="Stamp Fee :" meta:resourcekey="lblStampFeeResource1"></asp:Label>
                        <asp:TextBox ID="txtStampFee" CssClass="smaller a-right" Enabled="True" runat="server"
                            Text="0.00" meta:resourcekey="txtStampFeeResource1" onkeypress="return ValidateSpecialAndNumeric(this);"
                            onblur="checkAddToTotal();"></asp:TextBox>
                    </td>
                </tr>
                <tr id="trDeliveryCharges" runat="server">
                    <td class="a-right">
                        <asp:Label ID="lblDeliveryCharges" runat="server" Text="Delivery Charges :" meta:resourcekey="lblDeliveryChargesResource1"></asp:Label>
                        <asp:TextBox ID="txtDeliveryCharges" CssClass="smaller a-right" Enabled="True" runat="server"
                            Text="0.00" meta:resourcekey="txtDeliveryChargeResource1" onkeypress="return ValidateSpecialAndNumeric(this);"
                            onblur="checkAddToTotal();"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="a-right">
                        <asp:Label ID="lblNetTotal" runat="server" Text="Net Total :" meta:resourcekey="lblNetTotalResource1"></asp:Label>
                        <asp:TextBox ID="txtNetTotal" Enabled="False" runat="server" CssClass="smaller a-right"
                            onkeypress="return ValidateMultiLangChar(this);" Text="0.00" meta:resourcekey="txtNetTotalResource2"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="a-right">
                        <asp:Label ID="lblRoundOffNetTotal" runat="server" Text="Rounded-Off Net Total :"
                            meta:resourcekey="lblRoundOffNetTotalResource1"></asp:Label>
                        <asp:TextBox ID="txtGrandwithRoundof" CssClass="Align smaller a-right" runat="server"
                            onkeypress="return ValidateMultiLangChar(this);" Text="0.00" onblur="return CalRounfOff(); "
                            meta:resourcekey="txtGrandwithRoundofResource2"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="a-right">
                        <asp:Label ID="lblRoundOfValue" runat="server" Text="RoundOff Value :" meta:resourcekey="lblRoundOfValueResource1"></asp:Label>
                        <%--  <asp:TextBox ID="txtRoundOffValue" Width="70" onblur="CheckRoundOffvalue();" runat="server"
                                        CssClass="Align" Text="0.00" Enabled="false"></asp:TextBox>&nbsp;--%>
                        <asp:TextBox ID="txtRoundOffValue" runat="server" CssClass="Align smaller a-right"
                            onkeypress="return ValidateMultiLangChar(this);" Text="0.00" Enabled="False"
                            meta:resourcekey="txtRoundOffValueResource2"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <input type="hidden" id="hdnRowEdit" runat="server" />
            <input type="hidden" id="hdnOrgId" runat="server" />
            <input type="hidden" id="hdnOrgLocId" runat="server" />
            <input type="hidden" id="hdnProductList" runat="server" />
            <input type="hidden" id="hdbTempQut" value="0.00" runat="server" />
            <input type="hidden" id="hdnRowId" value="0" runat="server" />
            <input type="hidden" id="hdnProductName" runat="server" />
            <input type="hidden" id="hdnReceivedItems" runat="server" />
            <input type="hidden" id="hdnCollectedValues" runat="server" />
            <input type="hidden" id="hdnType" runat="server" />
            <input type="hidden" id="hdnTempTable" runat="server" />
            <input type="hidden" id="hdnStatus" runat="server" />
            <input type="hidden" id="hdnAllowedQty" runat="server" />
            <input type="hidden" id="hdnUnitCostPrice" value="0" runat="server" />
            <input type="hidden" id="hdnCostPrice" value="0" runat="server" />
            <input type="hidden" id="hdnHasExpiryDate" value="Y" runat="server" />
            <input type="hidden" id="hdnHasBatchNo" value="Y" runat="server" />
            <input type="hidden" id="hdnHasCostPrice" value="N" runat="server" />
            <input type="hidden" id="hdnHasSellingPrice" value="N" runat="server" />
            <asp:HiddenField ID="hdnproductId" runat="server" />
            <asp:HiddenField ID="hdnAttributes" Value="N" runat="server" />
            <input type="hidden" id="hdnHasAttributes" value="N" runat="server" />
            <input type="hidden" id="HdnPOno" runat="server" />
            <input type="hidden" id="hdnTotalCost" value="0" runat="server" />
            <input type="hidden" id="hdnUnitSellingPrice" value="0" runat="server" />
            <asp:HiddenField ID="hdnGridPopCount" runat="server" />
            <input id="hdnOnDeleteReset" type="hidden" value="" runat="server" />
            <input id="hdnTotalPodetails" type="hidden" value="" runat="server" />
            <asp:HiddenField ID="hdnGrandTotal" Value="0.00" runat="server" />
            <asp:HiddenField ID="hdnUsageLimit" Value="0" runat="server" />
            <asp:HiddenField ID="hdnIsPODisplay" Value="N" runat="server" />
            <asp:HiddenField ID="hdnCompQty" runat="server" Value="N" />
            <asp:HiddenField ID="hdnIsSellingPriceTypeRuleApply" runat="server" Value="N" />
            <asp:HiddenField ID="hdnRoundofType" Value="0.00" runat="server" />
            <input id="RoundOffNetTotal" type="hidden" value="0.00" runat="server" />
            <input id="RoundoffValue" type="hidden" value="0.00" runat="server" />
            <input type="hidden" id="hdnLanguageProductList" runat="server" />
            <asp:HiddenField ID="hdnfdisplaydata" runat="server" />
            <asp:HiddenField ID="hdnSellingPrieRuleList" runat="server" />
            <asp:HiddenField ID="hdnIsSellingPriceRuleApply" runat="server" Value="N" />
            <asp:HiddenField ID="hdnREQCalcCompQTY" runat="server" Value="N" />
            <asp:HiddenField ID="hdnTotalTax" runat="server" Value="0" />
            <asp:HiddenField ID="hdnTotalDiscount" runat="server" Value="0" />
            <asp:HiddenField ID="hdnsupplierServiceTaxAmount" runat="server" Value="0" />
            <asp:HiddenField ID="hdnActlRecedQty" runat="server" Value="0" />
            <input type="hidden" id="hdnMFDMandatoryRemove" value="N" runat="server" />
            <asp:HiddenField ID="hdnAdd" runat="server" Value="Add" />
            <table class="w-100p">
                <tr>
                    <td class="a-center">
                        <br />
                        <table id="submitTab" runat="server" class="hide" border="0">
                            <tr>
                                <td class="a-center">
                                    <asp:Button ID="btnFinish" OnClientClick="javascript:return checkDetails();" runat="server"
                                        OnClick="btnFinish_Click" Text="Finish" CssClass="btn" meta:resourcekey="btnFinishResource2" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Home" OnClick="btnCancel_Click" OnClientClick="javascript:return Validate();"
                                        CssClass="cancel-btn marginL10" meta:resourcekey="btnCancelResource2" />
                                    <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" CssClass="cancel-btn"
                                        meta:resourcekey="btnBackResources1" Text="Back" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <input id="poNoid" type="hidden" value="0" runat="server" />
            <input id="SupID" type="hidden" value="0" runat="server" />
            <asp:HiddenField ID="hdnIsResdCalc" runat="server" />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="tmrPostback" />
                </Triggers>
                <ContentTemplate>
                    <asp:Timer ID="tmrPostback" runat="server" Interval="30000" OnTick="tmrPostback_Tick">
                    </asp:Timer>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
         <asp:HiddenField ID="hdnIsTCSSupplier" runat="server" Value="N" />
        <asp:HiddenField ID="hdnNeedTcsTax" runat="server" Value="N" />
        <asp:HiddenField ID="hdnTcsTaxPer" runat="server" Value="0.0" />
        <asp:HiddenField ID="HiddenField1" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnFormatvalue" runat="server" />
        <asp:HiddenField ID="hdnSuppliereMand" Value="N" runat="server" />
        <asp:HiddenField ID="hdnTempValue" Value="N" runat="server" />
        <asp:HiddenField ID="hdnDCNo" runat="server" Value="N" />
        <asp:HiddenField ID="hdnTax" runat="server" />
        <asp:HiddenField ID="hdnIsTaxPerc" runat="server" Value="0" />
        <asp:HiddenField ID="hdnMarginValue" runat="server" Value="0" />
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    <script type="text/javascript" language="javascript">
        //-------------Mani--------
        $(document).ready(function () {
            if ($('#hdnIsSellingPriceTypeRuleApply').val() == 'Y') {
                var _TaxPerc = 0;
                _TaxPerc = $('#hdnIsTaxPerc').val();
                $('#txtPurchaseTax').val(_TaxPerc);
                $('#txtPurchaseTax').attr('disabled', 'disabled');
                $('#tdAvailableCreditAmount').css('visibility', 'hidden');
            }
            if ($("#Attuneheader_TopHeader1_lblvalue").text() == 'ReceiveStock') {
                $("#Attuneheader_TopHeader1_lblvalue").text('Receive Stock');
            }
            $('#txtReceivedDate').val(moment(GetServerDate()).format("DD/MM/YYYY"));
            $('#txtReceivedDate').attr("readOnly", "readOnly");
        });
        //----------End------------    


        function CalRounfOff() {
            // //debugger;
            // var GrandwithRoundof = document.getElementById('txtGrandwithRoundof').value;
            var GrandwithRoundof = ToInternalFormat($('#txtGrandwithRoundof'));
            //var NetTotal = document.getElementById('txtNetTotal').value;
            var NetTotal = ToInternalFormat($('#txtNetTotal'));
            var RoundOfValue = 0;
            UPresult = Math.ceil(Number(NetTotal));
            LOresult = Math.floor(Number(NetTotal));
            if (UPresult >= GrandwithRoundof && LOresult <= GrandwithRoundof) {
                if (GrandwithRoundof > NetTotal) {
                    RoundOfValue = Number(GrandwithRoundof) - Number(NetTotal);
                    document.getElementById('hdnRoundofType').value = 'UL';
                }
                if (GrandwithRoundof < NetTotal) {
                    RoundOfValue = Number(NetTotal) - Number(GrandwithRoundof);
                    document.getElementById('hdnRoundofType').value = 'LL';
                }
                document.getElementById('txtRoundOffValue').value = parseFloat(RoundOfValue).toFixed(2);
                ToTargetFormat($('#txtRoundOffValue'));
                //             document.getElementById('RoundOffNetTotal').value = document.getElementById('txtGrandwithRoundof').value;
                //             document.getElementById('RoundoffValue').value = document.getElementById('txtRoundOffValue').value;

                document.getElementById('RoundOffNetTotal').value = ToInternalFormat($('#txtGrandwithRoundof'));
                document.getElementById('RoundoffValue').value = ToInternalFormat($('#txtRoundOffValue'));
                ToTargetFormat($('#RoundOffNetTotal'));
                ToTargetFormat($('#RoundoffValue'));
                return true;
            }
            else {
                document.getElementById('txtGrandwithRoundof').value = NetTotal;
                document.getElementById('txtRoundOffValue').value = 0.00;
                ToTargetFormat($('#txtGrandwithRoundof'));
                //document.getElementById('RoundOffNetTotal').value = document.getElementById('txtGrandwithRoundof').value;
                //document.getElementById('RoundoffValue').value = document.getElementById('txtRoundOffValue').value;
                document.getElementById('RoundOffNetTotal').value = ToInternalFormat($('#txtGrandwithRoundof'));
                document.getElementById('RoundoffValue').value = ToInternalFormat($('#txtRoundOffValue'));

                ToTargetFormat($('#RoundOffNetTotal'));
                ToTargetFormat($('#RoundoffValue'));
                return true
            }



        }

        function Roundvalue() {

            //if (document.getElementById('RoundoffValue').value > 0) {
            if (ToInternalFormat($('#RoundoffValue')) > 0) {
                //             document.getElementById('txtGrandwithRoundof').value = document.getElementById('RoundOffNetTotal').value;
                //             document.getElementById('txtRoundOffValue').value = document.getElementById('RoundoffValue').value;

                document.getElementById('txtGrandwithRoundof').value = ToInternalFormat($('#RoundOffNetTotal'));
                document.getElementById('txtRoundOffValue').value = ToInternalFormat($('#RoundoffValue'));

                ToTargetFormat($('#txtGrandwithRoundof'));
                ToTargetFormat($('#txtRoundOffValue'));
            }


        }
        //Added by sathish.p for MiddleEast-Issue Fix v.1.0.0.0
        function ValidateNotNumbersSpl(event) {
            var regex = new RegExp("^[a-zA-Z]+$");
            var key = String.fromCharCode(event.charCode ? event.which : event.charCode);
            if (!regex.test(key)) {
                event.preventDefault();
                return false;
            }
        }

        function ValidateNotSpl(event) {
            var regex = new RegExp("^[0-9a-zA-Z]+$");
            var key = String.fromCharCode(event.charCode ? event.which : event.charCode);
            if (!regex.test(key)) {
                event.preventDefault();
                return false;
            }
        }

        function ValidateCommafullstop(event) {
            var regex = new RegExp("^[a-zA-Z.,]+$");
            var key = String.fromCharCode(event.charCode ? event.which : event.charCode);
            if (!regex.test(key)) {
                event.preventDefault();
                return false;
            }
        }
        //sathish-start--should alow alphanumeric.. 
        function ValidateSplChar(txt) {
            txt.value = txt.value.replace(/[^a-zA-Z 0-9\n\r]+/g, '');
        }
        //sathish-end--should alow alphanumeric.. 
        //end
        //        function CalRounfOff() {
        //           // //debugger;
        //            var GrandwithRoundof = document.getElementById('txtGrandwithRoundof').value;
        //            var NetTotal = document.getElementById('txtNetTotal').value;
        //            var RoundOfValue;
        //            UPresult = Math.ceil(Number(NetTotal));
        //            LOresult = Math.floor(Number(NetTotal));
        //            if (UPresult >= GrandwithRoundof && LOresult <= GrandwithRoundof) {

        //                if (GrandwithRoundof > NetTotal) {
        //                    RoundOfValue = Number(GrandwithRoundof) - Number(NetTotal);
        //                    document.getElementById('hdnRoundofType').value = 'UL';
        //                }
        //                if (GrandwithRoundof < NetTotal) {
        //                    RoundOfValue = Number(NetTotal) - Number(GrandwithRoundof);
        //                    document.getElementById('hdnRoundofType').value = 'LL';
        //                }
        //                document.getElementById('txtRoundOffValue').value = parseFloat(RoundOfValue).toFixed(2);
        //                return true;
        //            }
        //            else {
        //                alert('Provide Correct Rounded-Off Net Total');
        //                document.getElementById('txtGrandwithRoundof').value = 0.00;
        //                document.getElementById('txtGrandwithRoundof').focus();
        //                return false;
        //            }
        //        }

    </script>

    <script language="javascript" type="text/javascript">
        var ErrorMsg = SListForAppMsg.Get("StockReceived_Error") == null ? "Error" : SListForAppMsg.Get("StockReceived_Error");
        var infromMsg = SListForAppMsg.Get("StockReceived_Information") == null ? "Information" : SListForAppMsg.Get("StockReceived_Information");
        var OkMsg = SListForAppMsg.Get("StockReceived_Ok") == null ? "Ok" : SListForAppMsg.Get("StockReceived_Ok");
        var CancelMsg = SListForAppMsg.Get("StockReceived_Cancel") == null ? "Cancel" : SListForAppMsg.Get("StockReceived_Cancel");
    </script>

    <script type="text/javascript" language="javascript">
        var userMsg;
        function getvalidation(evt) {

            //            var keycode = 0;
            //            if (evt) {
            //                keycode = evt.keyCode || evt.which;
            //            }
            //            else {
            //                keycode = window.event.keyCode
            //            }
            //            if (keycode != 9) {
            var ddlSupplier = document.getElementById('txtSupplierName').value;
            if (ddlSupplier == '') {
                var userMsg = SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_01") == null ? "Select a Supplier Name" : SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_01");
                ValidationWindow(userMsg, ErrorMsg);

                document.getElementById('txtProductName').value = "";
                return false;
            }
            //        if (document.getElementById('txtDCNumber').value == "" && document.getElementById('txtInvoiceNo').value == "") {

            //            var userMsg = SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_02") == null ? "Enter DC Number/InvoiceNo" : SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_02");
            //            ValidationWindow(userMsg, ErrorMsg);

            //            document.getElementById('txtProductName').value = "";
            //            return false;
            //        }


            if ($('#txtInvoiceNo').val() != '') {
                $('#imagInvoiceDate').attr("disabled", true);
                $('#txtInvoiceDate').attr("readonly", 'readonly');
                //$('#txtInvoiceDate').focus();
            }
            else {
                $('#txtInvoiceDate').val('');
                $('#imagInvoiceDate').attr("disabled", true);
                $('#txtInvoiceDate').attr("readonly", 'readonly');
            }
            //document.getElementById('txtBatchNo').focus();
            return true;

        }


        ///////////////////////////////////////////////////////////////////
        //        function Chkclick(id) {
        //         
        //            if (id == 'chkCompQty') {
        //                var InclusiveCompTax = document.getElementById('chkCompQty').checked ? "Y" : "N";

        //                if (document.getElementById('txtProductName').value == '') {
        //                    alert('Provide Product Name');
        //                    document.getElementById('txtProductName').focus();
        //                    $("#chkCompQty").prop('checked', false); 
        //                    return false;
        //                }
        //               
        //            }
        //        }


        function Validate() {
            var userMsg = SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_03") == null ? "Do you want to continue !Click 'OK'" : SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_03");
            if (ConfirmWindow(userMsg, infromMsg, OkMsg, CancelMsg) == false) {
                return false;


            } else {
                document.getElementById('btnCancel').focus();
                return true


            }
        }


        function KeyPress1(e) {
            var ddlaction = document.getElementById('ddlSupplier');
            if (ddlaction.visibility == "visible") {
                if (ddlaction.options[ddlaction.selectedIndex].value == '0') {
                    var userMsg = SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_04") == null ? "Select a Supplier" : SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_04");
                    ValidationWindow(userMsg, ErrorMsg);
                    return false;

                }

                var Type = 'DC';
                var s1val = ddlaction.options[ddlaction.selectedIndex].value + '~' + Type;
            }
            else {
                var Type = 'DC';
                var s1val = document.getElementById('hdnSupplierID').value + '~' + Type;
            }
            $find('AutoCompleteDcNumber').set_contextKey(s1val);
        }

        function KeyPress2(e) {
            var ddlaction = document.getElementById('ddlSupplier');
            if (ddlaction.visibility == "visible") {

                if (ddlaction.options[ddlaction.selectedIndex].value == '0') {
                    var userMsg = SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_04") == null ? "Select a Supplier" : SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_04");
                    ValidationWindow(userMsg, ErrorMsg);
                    return false;
                }

                var Type = 'INVOICE';
                var s1val = ddlaction.options[ddlaction.selectedIndex].value + '~' + Type;
            }
            else {
                var Type = 'INVOICE';
                var s1val = document.getElementById('hdnSupplierID').value + '~' + Type;
            }
            $find('AutoCompleteInvoiceNumber').set_contextKey(s1val);
        }

        function ChkDcSupplierCombination(source, eventArgs) {
            var supplierid = eventArgs.get_value();
            var ddl = document.getElementById('ddlSupplier');
            if (ddl.visibility == "visible") {
                if (supplierid == ddl.options[ddl.selectedIndex].value) {
                    DCAlert();
                }
            }
            else {
                if (supplierid == document.getElementById('hdnSupplierID').value) {
                    DCAlert();
                }
            }
        }

        function ChkInvoiceSupplierCombination(source, eventArgs) {
            var supplierid = eventArgs.get_value();
            var ddl = document.getElementById('ddlSupplier');
            if (ddl.visibility == "visible") {
                if (supplierid == ddl.options[ddl.selectedIndex].value) {
                    InvoiceAlert();
                }
            }
            else {
                if (supplierid == document.getElementById('hdnSupplierID').value) {
                    InvoiceAlert();
                }
            }
        }
        function DCAlert() {
            var userMsg = SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_05") == null ? "This combination of Supplier name & DC No Already exists. Do you want to continue!Click 'OK'" : SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_05");
            var DC = ConfirmWindow(userMsg, infromMsg, OkMsg, CancelMsg);
            if (DC == true) {
                document.getElementById('txtInvoiceNo').focus();
            }
            else {
                document.getElementById('txtDCNumber').value = "";
                //document.getElementById('txtInvoiceNo').value = "";
            }
        }
        function InvoiceAlert() {
            var userMsg = SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_05") == null ? "This combination of Supplier name & DC No Already exists. Do you want to continue!Click 'OK'" : SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_05");
            var Invoice = ConfirmWindow(userMsg, infromMsg, OkMsg, CancelMsg);
            if (Invoice == true) {
                document.getElementById('txtBatchNo').focus();
            }
            else {
                //document.getElementById('txtDCNumber').value = "";
                document.getElementById('txtInvoiceNo').value = "";
            }
        }

        function ValidateSpecialCharacter(event) {
            var k = event.which;
            var ok = k >= 65 && k <= 90 ||  // A-Z 
                         k >= 97 && k <= 122 || // a-z
                         k >= 48 && k <= 57 ||
                         k == 46;    // decimalPoint
            if (!ok) {
                event.preventDefault();
            }
            //        else {
            //            var strNumber = document.getElementById(event.currentTarget.id).value;
            //            var NoOfDots = strNumber.match(/./g) || [];
            //            if (NoOfDots.length==1 && k==46 ) {               
            //                event.preventDefault();               
            //            }

            //       }
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(document).delegate("#popTaxTrigger", "click", function (event) {
                $('#divTaxDetails').toggleClass('hide');
                event.stopPropagation();
            });
            $(document).click(function () {
                $('#divTaxDetails').addClass('hide');
            });
        });
    </script>
    <style>
        .responstable th, .responstable .responstableHeader td {
            border: 1px solid #eee !important;
            border-right: 1px solid #ccc !important;
            vertical-align: middle;
        }
    </style>
</body>
</html>
