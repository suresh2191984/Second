<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockReturn.aspx.cs" Inherits="StockReturn_StockReturn"
    meta:resourcekey="PageResource1" EnableEventValidation="false"%>

<%@ Register Src="~/InventoryCommon/Controls/INVStockUsage.ascx" TagName="INVStockUsage"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Stock Return</title>
    <script src="../PlatForm/Scripts/linq.min.js" type="text/javascript"></script>
    <script src="../InventoryCommon/Scripts/InvAutoCompBacthNo.js" type="text/javascript"></script>
</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="divInCnt" class="w-100p pos-relative">
            <table class="w-100p ">
                <tr>
                    <td>
                        <div id="DivSupp" runat="server">
                            <%--<div class="w-100p">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <div class="marginT10 marginB10">
                                        <div class="w-97p marginauto card-md card-md-default padding10 ">
                                            <table class="w-100p lh30">
                                                <tr>
                                                    <td class="w-15p">
                                                        <asp:Label ID="lblStockReturnDate" runat="server" Text="Stock Return Date" CssClass="bold" meta:resourcekey="lblStockReturnDateResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-20p">
                                                        <asp:TextBox ID="txtStockReturnDate" runat="server" TabIndex="1" CssClass="datePicker small" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            meta:resourcekey="txtStockReturnDateResource1"></asp:TextBox>
                                                    &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                                    </td>
                                                    <td colspan="2">
                                                        <div id="divSuppliers" runat="server">
                                                            <table class="w-90p">
                                                                <tr>
                                                                    <td class="w-50p">
                                                                        <asp:Label ID="lblSupplierName" runat="server" Text="Supplier Name" CssClass="bold" meta:resourcekey="lblSupplierNameResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlSupplierList" TabIndex="3" CssClass="small" runat="server"
                                                                            onchange="checkSupplier1(this)">
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hdnIsSupplier" runat="server" Value="Y" />
                                                                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <div id="divLocation" runat="server">
                                                            <table class="w-90p">
                                                                <tr>
                                                                    <td class="w-50p">
                                                                        <asp:Label ID="lblLocationName" runat="server" CssClass="bold" Text="Location Name" meta:resourcekey="lblLocationNameResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlLocation" runat="server" meta:resourcekey="ddlLocationResource1">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                    <td class="">
                                                        <asp:Label ID="lblresos" runat="server" CssClass="bold" Text="Reason for Stock out flow" meta:resourcekey="lblresosResource1"></asp:Label>
                                                    </td>
                                                    <td class="">
                                                        <asp:DropDownList ID="ddlStockReturnType" TabIndex="2" CssClass="small" runat="server"
                                                            meta:resourcekey="ddlStockReturnTypeResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblComments" runat="server" Text="Comments" CssClass="bold" meta:resourcekey="lblCommentsResource1"></asp:Label>
                                                    </td>
                                                    <td class="">
                                                        <asp:TextBox ID="txtComments" TextMode="MultiLine" TabIndex="4" runat="server" CssClass="w-156" Columns="25"
                                                            Rows="2" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                                    </td>
                                                    <td id="tdIsInternal" >
                                                         <asp:CheckBox ID="ChkIsInternal" runat="server" Text="IsInternal" CssClass="bold"   meta:resourcekey="ChkIsInternalResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>--%>
                        <div class="w-100p">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="marginT10 marginB10">
                                        <div class="w-97p marginauto card-md card-md-default padding10 ">
                                            <table class="w-100p">
                                                <tr class="lh30">
                                                    <td id="tdSearch" runat="server" class="w-15p v-top">
                                                        <asp:Label ID="lblmsg" runat="server" CssClass="bold" meta:resourcekey="lblmsgResource1"></asp:Label>
                                                    </td>
                                                    <td class="">
                                                        <asp:Panel ID="pnSearch" runat="server" meta:resourcekey="pnSearchResource1">
                                                            <asp:TextBox ID="txtProduct" TabIndex="5" 
                                                                onkeypress="return ValidateMultiLangChar(this);" onkeyup="doClearTable();" CssClass="medium bg-searchimage"
                                                                placeholder="Enter Product Name" ToolTip="Enter Product Name" runat="server"  
                                                                onblur="pSetFocus('pro');" meta:resourcekey="txtProductResource1" ></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                UseContextKey="true" CompletionListItemCssClass="listitemtwo" EnableCaching="False"
                                                                FirstRowSelected="True" MinimumPrefixLength="1" OnClientItemSelected="IAmSelected"
                                                                ServiceMethod="getCompleteStockDetails" OnClientItemOver="doGetProductTotalQuantityCommonJSON"
                                                                ServicePath="~/StockReturn/WebService/StockReturnService.asmx" TargetControlID="txtProduct"
                                                                DelimiterCharacters="" Enabled="True">
                                                            </ajc:AutoCompleteExtender>
                                                            &nbsp;<asp:Button Visible="False" ID="btnSearch" TabIndex="6" runat="server" CssClass="btn"
                                                                OnClick="btnSearch_Click" OnClientClick="return SearchText()" Text="Search" meta:resourcekey="btnSearchResource1" />
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table class="w-100p">
                                                <tr class="lh30">
                                                    <td>
                                                        <asp:Label ID="lblProdDesc" class="w-100p" runat="server" meta:resourcekey="lblProdDescResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3">
                                                        <asp:Label ID="lblMsgpro" runat="server" meta:resourcekey="lblMsgproResource1"></asp:Label>
                                                        &nbsp;&nbsp;<asp:Label ID="lblProductName" Visible="False" runat="server" meta:resourcekey="lblProductNameResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3">
                                                        <input type="hidden" id="hdnReceivedID" runat="server" />
                                                        <input id="hdnProductId" runat="server" type="hidden" />
                                                        <input id="tempTable" runat="server" type="hidden" />
                                                        <input id="hdnProductList" runat="server" type="hidden" />
                                                        <input id="hdnProductName" runat="server" type="hidden" />
                                                        <input id="hdnTotalqty" runat="server" type="hidden" />
                                                        <input id="hdnRowEdit" runat="server" type="hidden" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="v-top" colspan="3">
                                                        <div id="divProductDetails" runat="server" class="hide">
                                                            <table id="TableProductDetails" class="w-100p">
                                                                <tr id="Tr1" class="" runat="server">
                                                                    <td id="Td1" runat="server">
                                                                        <asp:Label ID="lblInvoiceNo" runat="server" Text="Invoice No" CssClass="bold" meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="Td9" runat="server">
                                                                        <asp:TextBox ID="txtInvoiceNo" CssClass="smaller" TabIndex="7" ReadOnly="True" onkeypress="return ValidateMultiLangChar(this);" runat="server"
                                                                            onblur="pSetFocus('pro');"></asp:TextBox>
                                                                    </td>
                                                                    <td id="Td2" runat="server">
                                                                        <asp:Label ID="lblBatchNo" runat="server" Text="Batch No" CssClass="bold" meta:resourcekey="lblBatchNoResource1"></asp:Label>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="Td10" runat="server">
                                                                        <asp:TextBox CssClass="smaller" ID="txtBatchNo" TabIndex="8" runat="server" onkeypress="return ValidateMultiLangChar(this);" onblur="return BindQuantity();"></asp:TextBox>
                                                                    </td>
                                                                    <td id="Td3" runat="server">
                                                                        <asp:Label ID="lblAvailableQty" runat="server" Text="Inhand Quantity" CssClass="bold" ></asp:Label>
                                                                    </td>
                                                                    <td id="Td11" class="" runat="server">
                                                                        <asp:TextBox CssClass="smaller a-left" ID="txtBatchQuantity" onkeypress="return ValidateMultiLangChar(this);" TabIndex="9" ReadOnly="True"
                                                                                runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td id="Td4" runat="server">
                                                                        <asp:Label ID="lblReturnQty" runat="server" Text="Return Qty" CssClass="bold" meta:resourcekey="lblReturnQtyResource1"></asp:Label>
                                                                    </td>
                                                                    <td id="Td12" runat="server">
                                                                        <asp:TextBox ID="txtQuantity" CssClass="smaller a-right" TabIndex="10" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                                                OnBlur="CheckQty();" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td id="Td5" runat="server">
                                                                        <asp:Label ID="lblUnit" runat="server" Text="Unit" CssClass="bold" meta:resourcekey="lblUnitResource1"></asp:Label>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="Td13" runat="server">
                                                                        <asp:TextBox ID="txtUnit" CssClass="smaller a-left" TabIndex="11" onkeypress="return ValidateMultiLangChar(this);" runat="server" ReadOnly="True"></asp:TextBox>
                                                                    </td>
                                                                    <td id="Td6" runat="server">
                                                                        <asp:Label ID="lblUnitPrice" runat="server" Text="UnitPrice" CssClass="bold" meta:resourcekey="lblUnitPriceResource1"></asp:Label>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="Td14" runat="server">
                                                                    <asp:TextBox ID="txtUnitPrice" CssClass="smaller a-right" TabIndex="12" ReadOnly="true" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                                        OnBlur="Calctotal();" runat="server"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td id="tdlblSchemeDisc" runat="server">
                                                                       <asp:Label ID="lblSchemeDisc" runat="server" Text="Scheme Discount" CssClass="bold"></asp:Label>
                                                                    </td>
                                                                    <td id="tdtxtScheme" runat="server">
                                                                        <asp:TextBox ID="txtSchemeDisc" runat="server" CssClass ="smaller a-right" TabIndex="12" 
                                                                        ReadOnly="true"></asp:TextBox>
                                                                    </td>
                                                                    <td id="tdlblDiscount" runat ="server">
                                                                       <asp:Label ID="lblDisc" runat="server" Text="Normal Discount" CssClass="bold"></asp:Label>
                                                                    </td>
                                                                    <td id="tdtxtDiscount" runat="server">
                                                                      <asp:TextBox ID="txtDisc" runat ="server" CssClass ="smaller a-right" TabIndex="12" 
                                                                        ReadOnly="true"></asp:TextBox>
                                                                    </td>
                                                                    <td id="tdTax" runat="server">
                                                                        <asp:Label ID="lblTax" runat="server" Text="GST(%)" CssClass="bold" meta:resourcekey="lblTaxResource1"></asp:Label>
                                                                    </td>
                                                                    <td id="tdTaxAmt" runat="server">
                                                                        <asp:TextBox ID="txtTax" TabIndex="12" CssClass="smaller a-right" ReadOnly="true" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                                            OnBlur="Calctotal();" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td id="Td7" runat="server">
                                                                        <asp:Label ID="lblTotalAmount" runat="server" CssClass="bold" Text="Total Amount" meta:resourcekey="lblTotalAmountResource1"></asp:Label>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="Td15" runat="server">
                                                                        <asp:TextBox ID="txtPrice" CssClass="smaller a-right" onkeypress="return ValidateMultiLangChar(this);" runat="server" ReadOnly="True" Text="0.00"></asp:TextBox>
                                                                    </td>
                                                                    <td id="tdlblCompQty" runat="server">
                                                                      <asp:Label ID="lblCompQty" runat="server" CssClass="bold" Text="Return CompQty"></asp:Label>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="tdtxtCompQty" runat="server">
                                                                       <asp:TextBox ID="txtCompQty" CssClass="smaller a-right" onkeypress="return ValidateSpecialAndNumeric(this);" 
                                                                        OnBlur="CheckQty();" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    
                                                                    <%--<td id="Td8" class="hide" runat="server">
                                                                    </td>--%>
                                                                   <%-- <td id="Td17" runat="server">
                                                                        <asp:Button ID="add" runat="server" Text="Add" TabIndex="13"
                                                                            class="btn w-60" OnClientClick="javascript:return checkIsEmpty();"
                                                                            meta:resourcekey="btnaddResource1" />
                                                                    </td>--%>
                                                                </tr>
                                                                <tr id="Tr" runat="server">
                                                                    <td id="Td16" runat="server">
                                                                        <asp:Label ID="lblStockReceivedID" CssClass="hide" runat="server"></asp:Label>
                                                                    </td>
                                                                    
                                                                </tr>
                                                            </table>
                                                        </div>
                                                         </td>
                                                </tr>
                                                </table>
                                            </div>
                                            <div id="DivSupplier" runat="server">
                                                <div class="w-100p">
                                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                        <ContentTemplate>
                                                            <div class="marginT10 marginB10">
                                                                <div class="w-97p marginauto card-md card-md-default padding10 ">
                                                                    <table class="w-100p lh30">
                                                                        <tr>
                                                                            <td class="w-15p">
                                                                                <asp:Label ID="lblStockReturnDate" runat="server" Text="Stock Return Date" CssClass="bold"
                                                                                    meta:resourcekey="lblStockReturnDateResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="w-20p">
                                                                                <asp:TextBox ID="txtStockReturnDate" runat="server" TabIndex="1" CssClass="datePicker small"
                                                                                    onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtStockReturnDateResource1"></asp:TextBox>
                                                                                &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <div id="divSuppliers" runat="server">
                                                                                    <table class="w-90p">
                                                                                        <tr>
                                                                                            <td class="w-50p">
                                                                                                <asp:Label ID="lblSupplierName" runat="server" Text="Supplier Name" CssClass="bold"
                                                                                                    meta:resourcekey="lblSupplierNameResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="ddlSupplierList" TabIndex="3" CssClass="small" runat="server"
                                                                                                    onchange="checkSupplier1(this)">
                                                                                                </asp:DropDownList>
                                                                                                <asp:HiddenField ID="hdnIsSupplier" runat="server" Value="Y" />
                                                                                                &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div id="divLocation" runat="server">
                                                                                    <table class="w-90p">
                                                                                        <tr>
                                                                                            <td class="w-50p">
                                                                                                <asp:Label ID="lblLocationName" runat="server" CssClass="bold" Text="Location Name"
                                                                                                    meta:resourcekey="lblLocationNameResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="ddlLocation" runat="server" meta:resourcekey="ddlLocationResource1">
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                            <td class="">
                                                                                <asp:Label ID="lblresos" runat="server" CssClass="bold" Text="Reason for Stock out flow"
                                                                                    meta:resourcekey="lblresosResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="">
                                                                                <asp:DropDownList ID="ddlStockReturnType" TabIndex="2" CssClass="small" runat="server"
                                                                                    meta:resourcekey="ddlStockReturnTypeResource1">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="a-left">
                                                                                <asp:Label ID="lblComments" runat="server" Text="Comments" CssClass="bold" meta:resourcekey="lblCommentsResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="">
                                                                                <asp:TextBox ID="txtComments" TextMode="MultiLine" TabIndex="4" runat="server" CssClass="w-156"
                                                                                    Columns="25" Rows="2" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                                                            </td>
                                                                            <td id="Td8" runat="server">
                                                                                <asp:Label ID="lblstockreceivenumber" runat="server" CssClass="bold" Text="Stock Receive Number"
                                                                                    meta:resourcekey="lblstockreceivenumberResource1"></asp:Label>
                                                                                &nbsp;
                                                                            </td>
                                                                            <td id="Td18" runat="server">
                                                                                <asp:TextBox ID="txtStockReceiveNo" CssClass="smaller a-right" onkeypress="return ValidateMultiLangChar(this);"
                                                                                    runat="server" ReadOnly="True"></asp:TextBox>
                                                                            </td>
                                                                            <td id="tdIsInternal">
                                                                                <asp:CheckBox ID="ChkIsInternal" runat="server" Text="IsInternal" CssClass="bold"
                                                                                    meta:resourcekey="ChkIsInternalResource1" />
                                                                            </td>
                                                                            <td id="tdWithoutGST" runat="server">
                                                                                <asp:CheckBox ID="chkbIsGST" runat="server" Text="GST (Not Applicable)" CssClass="bold"
                                                                                    onclick="Checked();" />
                                                                            </td>
                                                                            <td id="Td17" runat="server">
                                                                                <asp:Button ID="add" runat="server" Text="Add" TabIndex="13" class="btn w-60" OnClientClick="javascript:return checkIsEmpty();"
                                                                                    meta:resourcekey="btnaddResource1" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>
                                            <br />
                                        </div>
                                        <table class="w-99p marginauto lh30">
                                            <tr>
                                                <td>
                                                    <div class="">
                                                        <asp:Label ID="lblTable" class="w-100p" runat="server" meta:resourcekey="lblTableResource1"></asp:Label>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
            <div class="w-100p  pos-absolute bottom0">
                <table class="w-100p">
                    <tr class="lh30">
                        <td class="a-center hide" id="tdCancelSubmit">
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" TabIndex="15" CssClass="cancel-btn marginR10"
                                OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                            <asp:Button ID="btnReturnStock" Text="Submit" TabIndex="14" runat="server" CssClass="btn marginL10"
                                OnClientClick="javascript:if(!checkDetails()) return false;" OnClick="btnReturnStock_Click"
                                meta:resourcekey="btnReturnStockResource1" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <input type="hidden" id="hdnFID" runat="server" />
    <input id="hdnBatchList" runat="server" type="hidden" value="" />
    <input id="hdnSupplier" runat="server" type="hidden" value="" />
   
    <input id="hdnProBatchNo" runat="server" type="hidden" value="" />
    <input id="hdnSupplierId" runat="server" type="hidden" value="" />
     <input id="hdnSupplierName" runat="server" type="hidden" value="" />
    <input id="hdnStockReceivedID" runat="server" type="hidden" value="" />
    <input id="hdnUnitPrice" runat="server" type="hidden" value="" />
    <input id="hdnAddedTaskList" runat="server" type="hidden" value="" />
    <input id="hdnList" runat="server" type="hidden" value="" />
    <input id="hdnDC" runat="server" type="hidden" value="" />
    <input id="hdnIC" runat="server" type="hidden" value="" />
    <input type="hidden" id="hdnTax" runat="server" />
    <input type="hidden" id="hdnSellingPrice" runat="server" />
    <input type="hidden" id="hdnExpiryDate" runat="server" />
    <input type="hidden" id="hdnEditExpiryDate" runat="server" />
    <input type="hidden" id="hdnPdtRcvdDtlsID" runat="server" />
    <input type="hidden" id="hdnReceivedUniqueNumber" runat="server" />
    <input type="hidden" id="hdnStockReceivedBarcodeDetailsID" runat="server"/>
    <input type="hidden" id="hdnBarcodeNo" runat="server" />
    <input type="hidden" id="hdnParentProductID" runat="server" />
    <input type="hidden" id="hdnToTargetmsg" runat="server" />
    <input type="hidden" id="hdnShowCostPrice" runat="server" value="Y" />
    <input id="hdnExpiryDateLevel" runat="server" type="hidden" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnNoGSTforExpiredProducts" runat="server" value="N"/>
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    <input type="hidden" ID="hdnWithoutGST" runat="server" />
    <input type="hidden" id="hdnIsSchemeDisc" runat="server" />
    <input type="hidden" id="hdnReturnProdsScheDisc" runat="server" />
    <input type="hidden" id="hdnReturnProdsDisc" runat="server" />
    <input type="hidden" id="hdnRecdTotalQty" runat="server" />
    <input type="hidden" id="hdnChkbIsGST" runat="server" value="N" />
    <input type="hidden" id="hdnCompQty" runat="server" />
    <input type="hidden" id="hdnReturnedCompQty" runat="server" />
    <input type="hidden" id="hdnRecdProdsScheDisc" runat="server" />
    <input type="hidden" id="hdnRecdProdsNormalDisc" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
    <script type="text/javascript" src="../PlatForm/Scripts/tableFixedHeader.js"></script>
<script language="javascript" type="text/javascript">
    $(document).ready(function () {
        calcdivInCnt();
        $("#stockRtnTbl").tableHeadFixer({ height: 250, tableHead: false });
    });
    $(window).resize(function () {
        calcdivInCnt();
    });
    function calcdivInCnt() {
        setTimeout(function () {
            var divHgt = $(".contentdata").height() - 20;
            $('#divInCnt').css('min-height', divHgt);
            $('#divInCnt').css("overflow","auto");
        }, 500);
    }
        var lstProductList = [];
        var Product = SListForAppDisplay.Get('StockReturn_StockReturn_aspx_11');
        if (Product == null) {
            Product = "Product Name";
        }

        var InvoiceNo = SListForAppDisplay.Get('StockReturn_StockReturn_aspx_12');
        if (InvoiceNo == null) {
            InvoiceNo = "Invoice No";
        }

    var BatchNo = SListForAppDisplay.Get('StockReturn_StockReturn_aspx_13');
    if (BatchNo == null) {
        BatchNo = "Batch No";
    }

    var ReturnQTY = null;
    if (ReturnQTY == null) {
        ReturnQTY = "Return Qty";
    }

    var Unit = SListForAppDisplay.Get('StockReturn_StockReturn_aspx_15');
    if (Unit == null) {
        Unit = "Unit";
    }

    var UnitPrice = null;
    if (UnitPrice == null) {
        UnitPrice = "Cost Price";
    }

    var Tax = SListForAppDisplay.Get('StockReturn_ViewStockReturn_aspx_06');
    if (Tax == null) {
        Tax = "GST";
    }

    var Total = null;
    if (Total == null) {
        Total = "Total Cost";
    }

    var Action = SListForAppDisplay.Get('StockReturn_StockReturn_aspx_16');
    if (Action == null) {
        Action = "Action";
    }

    var ReturnCompQty = null;
    if (ReturnCompQty == null) {
        ReturnCompQty = "Return CompQty";
    }

    var SchemeDisc = null;
    if (SchemeDisc == null) {
        SchemeDisc = "Scheme Discount";
    }

    var NormalDisc = null;
    if (NormalDisc == null) {
        NormalDisc = "Normal Discount";
    }

    var ExpiryDate = null;
    if (ExpiryDate == null) {
        ExpiryDate = "Expiry Date";
    }
    

    var Header;
    if (Product != null && InvoiceNo != null && BatchNo != null && ReturnQTY != null && Unit != null && UnitPrice != null && Tax != null && Total != null && Action != null && ReturnCompQty != null && SchemeDisc != null && NormalDisc != null && ExpiryDate != null) {
        Header = { Product: Product, InvoiceNo: InvoiceNo, BatchNo: BatchNo, ExpiryDate: ExpiryDate, ReturnQTY: ReturnQTY, ReturnCompQty: ReturnCompQty, Unit: Unit, UnitPrice: UnitPrice, SchemeDisc: SchemeDisc, NormalDisc: NormalDisc, Tax: Tax, Total: Total, Action: Action };
    }
    else {
        Header = { Product: "Product Name", InvoiceNo: "InvoiceNo", BatchNo: "Batch No", ExpiryDate: "Expiry Date", ReturnQTY: "Return Qty", ReturnCompQty: "Return CompQty", Unit: "Unit", UnitPrice: "Cost Price", SchemeDisc: "Scheme Discount", NormalDisc: "Normal Discount", Tax: "Tax", Total: "Total Cost", Action: "Action" };
    }
    function checkDetails() {
        if (document.getElementById('ddlSupplierList').value == 0) {
            var userMsg = SListForAppMsg.Get('StockReturn_StockReturn_aspx_04');
            var errorMsg = SListForAppMsg.Get('StockReturn_Error');
            if (userMsg != null && errorMsg != null) {
                ValidationWindow(userMsg, errorMsg);
                return false;

            }
            else {
                ValidationWindow('Select supplier', 'Alert');
                return false;

            }
            //arya
            // document.getElementById('ddlSupplierList').focus();
            return false;
        }
        else
            $find('AutoCompleteProduct').set_contextKey(document.getElementById('ddlSupplierList').value);
        if (document.getElementById('ddlStockReturnType').value == 0) {
            var userMsg = SListForAppMsg.Get('StockReturn_StockReturn_aspx_07');
            var errorMsg = SListForAppMsg.Get('StockReturn_Error');
            if (userMsg != null && errorMsg != null) {
                ValidationWindow(userMsg, errorMsg);
                return false;

                }
                else {
                    ValidationWindow('Select reason for stock outflow', 'Alert');
                    return false;

                }
            }
            if (document.getElementById('hdnProductList').value == '') {
                var userMsg = SListForAppMsg.Get('StockReturn_StockReturn_aspx_01');
                var errorMsg = SListForAppMsg.Get('StockReturn_Error');
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

                else {
                    ValidationWindow('Check that the items added or quantity is provided properly', 'Alert');
                    return false;

            }
            document.getElementById('txtProduct').focus();
            return false;
        }
        var y; var i;
        var x = document.getElementById('hdnProductList').value.split("^");
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
                if (y[6] == '') {
                    var userMsg = SListForAppMsg.Get('StockReturn_StockReturn_aspx_01');
                    var errorMsg = SListForAppMsg.Get('StockReturn_Error');
                    if (userMsg != null && errorMsg != null) {
                        ValidationWindow(userMsg, errorMsg);

                    }
                    else {
                        ValidationWindow('Check that the items added or quantity is provided properly', 'Error');


                    }
                    document.getElementById('txtProduct').focus();
                    return false;

                }

            }
        }


        $('#btnReturnStock').removeClass().addClass('hide');

        return true;
    }

    function checkIsEmpty() {
 if (document.getElementById('txtProduct').value == "") {
                var userMsg =  "Enter Product Name";
                var errorMsg = SListForAppMsg.Get('StockReturn_Error') != null ? SListForAppMsg.Get('StockReturn_Error') : "Alert";

            document.getElementById('txtProduct').focus();
            ValidationWindow(userMsg, errorMsg);
            return false;
        }

        if (document.getElementById('txtQuantity').value == '' && (document.getElementById('txtCompQty').value == '' || document.getElementById('txtCompQty').value == 0)) {
                var userMsg = SListForAppMsg.Get('StockReturn_StockReturn_aspx_02') != null ? SListForAppMsg.Get('StockReturn_StockReturn_aspx_02') : "Provide return quantity or return Complimentary quantity";
                var errorMsg = SListForAppMsg.Get('StockReturn_Error') != null ? SListForAppMsg.Get('StockReturn_Error') : "Alert";

            document.getElementById('txtQuantity').focus();
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        if (document.getElementById('txtCompQty').value == "") {
            if (Number(ToInternalFormat($('#txtBatchQuantity'))) < Number(ToInternalFormat($('#txtQuantity')))) {
                var userMsg = SListForAppMsg.Get('StockReturn_StockReturn_aspx_01');
                var errorMsg = SListForAppMsg.Get('StockReturn_Error');
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    return false;

                }
                else {
                    ValidationWindow('Check that the items added or quantity is provided properly', 'Error');
                    return false;
                }
                document.getElementById('txtQuantity').focus();
                return false;
            } 
        }
        if (document.getElementById('txtCompQty').value == "") {
            if (Number(ToInternalFormat($('#txtQuantity'))) == 0) {
                var userMsg = SListForAppMsg.Get('StockReturn_StockReturn_aspx_01');
                var errorMsg = SListForAppMsg.Get('StockReturn_Error');
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    return false;

                }
                else {
                    ValidationWindow('Check that the items added or quantity is provided properly', 'Error');
                    return false;

                }
                document.getElementById('txtQuantity').focus();
                return false;
            }
        }

        if (document.getElementById('add').value != 'Update') {
            var pProductId = document.getElementById('hdnProductId').value;
            var pName = unescape(document.getElementById('hdnProductName').value);
            var pInvoiceNo = document.getElementById('txtInvoiceNo').value;

                var pBatchNo = document.getElementById('txtBatchNo').value;
                $.each(lstProductList, function (obj, value) {
                if (value.ProductID == pProductId && value.ReceivedUniqueNumber == $('#hdnReceivedUniqueNumber').val()) {
                        var userMsg = SListForAppMsg.Get('StockReturn_StockReturn_aspx_03');
                        var errorMsg = SListForAppMsg.Get('StockReturn_Error');
                        if (userMsg != null && errorMsg != null) {
                            ValidationWindow(userMsg, errorMsg);
                            return false;

                        }
                        else {
                            ValidationWindow('Product name and batch number combination already exist', 'Error');
                            return false;

                        }
                        document.getElementById('txtQuantity').focus();
                        return false;

                    }
                });
            }
        return BindProductList();

        }


    function BindProductList() {
        var pExp = document.getElementById('hdnExpiryDate').value;
        var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
        if (expirylevel != '' && expirylevel != null) {
            if (expirylevel > 0) {
                var isExpired = findExpiryItem(pExp, expirylevel);
                if (isExpired == 2) {
                    var userMsg = SListForAppMsg.Get('StockReturn_StockReturn_aspx_06');
                    userMsg = userMsg.replace('{0}', expirylevel);
                    var cancel = SListForAppMsg.Get('StockReturn_Cancel');
                    var OK = SListForAppMsg.Get('StockReturn_OK');
                    var Information = SListForAppMsg.Get('StockReturn_Information');
                    if (userMsg != null && errorMsg != null && OK != null && Information != null) {
                        var Replay = ConfirmWindow(userMsg, cancel, OK, Information);

                    }
                    else {
                        Replay = ConfirmWindow("This Item Will be Expired with in " + expirylevel + " Months. Do you want to continue!Click 'OK'", "cancel", "OK", "Information");
                    }
                    if (Replay == false) {
                        return;
                    }
                }
            }
        }
        if (document.getElementById('add').value == 'Update') {
                    var editData = JSON.parse($('#hdnRowEdit').val());
                    if (editData != "") {
                        var arrF = $.grep(lstProductList, function (n, i) {
                        return n.ReceivedUniqueNumber != editData.ReceivedUniqueNumber
                        });
                        lstProductList = [];
                        lstProductList = arrF;
                    }
                }
                if(document.getElementById('hdnSupplierName').value != "" && document.getElementById('hdnSupplierName').value != document.getElementById('ddlSupplierList').value)
                {
                 ValidationWindow('The Supplier Name choosen is different from the earlier entry for the same product. ', 'Error');
                $('#divProductDetails').removeClass().addClass('hide');
                return false;
            }

            if (ToInternalFormat($('#txtBatchQuantity')) == 0) {
                ValidationWindow('InHand Quantity should not be blank.', 'Error');
                return false;
            }
                document.getElementById('hdnSupplierName').value = document.getElementById('ddlSupplierList').value;

                    var pId = document.getElementById('hdnReceivedID').value;
                    var pName = unescape(document.getElementById('hdnProductName').value);
                    var pDcNo = document.getElementById('hdnDC').value;
                    var pInvoiceNo = document.getElementById('txtInvoiceNo').value;

        var pProductId = document.getElementById('hdnProductId').value;
        var pQTY = ToInternalFormat($('#hdnTotalqty'));
        var pBatchNo = document.getElementById('txtBatchNo').value;
        var pQuantity = ToInternalFormat($('#txtQuantity'));
        var pUnit = document.getElementById('txtUnit').value;
        var pUnitPrice = ToInternalFormat($('#txtUnitPrice'));
        var pStockReceivedID = document.getElementById('lblStockReceivedID').value;
        var pPrice = ToInternalFormat($('#txtPrice'));
        var pCompQty = ToInternalFormat($('#txtCompQty'));

        var pTax = ToInternalFormat($('#hdnTax'));
        if (document.getElementById('hdnChkbIsGST').value == "Y")
        { pTax = 0; }
        var pExpiryDate = document.getElementById('hdnExpiryDate').value;
        var pSellingPrice = ToInternalFormat($('#hdnSellingPrice'));
        var pPdtRcvdDtlsID = document.getElementById('hdnPdtRcvdDtlsID').value;
        var pReceivedUniqueNumber = document.getElementById('hdnReceivedUniqueNumber').value;
        var pParentProductID = document.getElementById('hdnParentProductID').value;

        var pStockReceivedBarcodeDetailsID = $("#hdnStockReceivedBarcodeDetailsID").val();
        var phdnBarcodeNo = $("#hdnBarcodeNo").val();

        var pSupplierId = document.getElementById('ddlSupplierList').value;
        document.getElementById('hdnSupplier').value = pSupplierId;

        var pSchemeDisc = ToInternalFormat($('#txtSchemeDisc'));
        var pNormalDisc = ToInternalFormat($('#txtDisc'));

        var pReturnQtyScheDisc = ToInternalFormat($('#hdnReturnProdsScheDisc'));
        var pReturnQtyNormalDisc = ToInternalFormat($('#hdnReturnProdsDisc'));

        var pEditExpiryDt = document.getElementById('hdnEditExpiryDate').value;
        
        var objProduct = new Object();
        objProduct.ProductName = unescape(pName);
        objProduct.ID = pId;
        objProduct.BatchNo = pBatchNo;
        objProduct.InHandQuantity = pQTY;
        objProduct.Quantity = pQuantity;
        objProduct.Unit = pUnit;
        objProduct.ProductID = pProductId;
        objProduct.ParentProductID = pParentProductID;
        objProduct.Rate = pSellingPrice;
        objProduct.Tax = parseFloat(pTax);
        objProduct.ExpiryDate = (pEditExpiryDt == "" || pEditExpiryDt == null) ? new Date(parseInt(pExp.substr(6))) : pEditExpiryDt;
        objProduct.UnitPrice = parseFloat(pUnitPrice);
        objProduct.Amount = pPrice;
        objProduct.InvoiceNo = pInvoiceNo;
        objProduct.ReceiptNo = pDcNo;
        objProduct.ProductReceivedDetailsID = pPdtRcvdDtlsID;
        objProduct.ReceivedUniqueNumber = pReceivedUniqueNumber;
        objProduct.Providedby = pStockReceivedID;
        objProduct.StockReceivedBarcodeDetailsID = pStockReceivedBarcodeDetailsID;
        objProduct.BarcodeNo = phdnBarcodeNo;
        objProduct.SupplierId = pSupplierId;
        objProduct.Discount = pNormalDisc;
        objProduct.SchemeDisc = pSchemeDisc;
        objProduct.TotalSchemeDisc = pReturnQtyScheDisc;
        objProduct.TotalNormalDisc = pReturnQtyNormalDisc;
        objProduct.ComplimentQTY = pCompQty;
        lstProductList.push(objProduct);
        $('#hdnProductList').val(JSON.stringify(lstProductList));

                    Tblist();
                    $('#chkbIsGST').attr('disabled', 'true');
                    document.getElementById('txtQuantity').value = '';
                    document.getElementById('txtUnit').value = '';
                    document.getElementById('txtDisc').value = '';
                    document.getElementById('txtSchemeDisc').value = '';
                    document.getElementById('txtBatchNo').value = '';
                    document.getElementById('txtUnitPrice').value = '';
                    document.getElementById('txtPrice').value = '';
                    document.getElementById('txtTax').value = '';
                    document.getElementById('txtCompQty').value = '';
                    document.getElementById('txtBatchQuantity').value = '';
                    document.getElementById('txtInvoiceNo').value = '';                                        
                    document.getElementById("lblProdDesc").innerHTML = "";
                    document.getElementById('txtProduct').value = '';
                    document.getElementById('txtProduct').focus();
                

                document.getElementById('add').value = SListForAppDisplay.Get("StockReturn_StockReturn_aspx_19") == null ? "Add" : SListForAppDisplay.Get("StockReturn_StockReturn_aspx_19");
               //arya
//             $('#divProductDetails').removeClass().addClass('hide');
                return false;
            }

    function findExpiryItem(Expiredate, ConfigExpiryDateLevel) {
        var today = GetServerDate();
        var Expdate = new Date(Expiredate);

                var monthdiff = monthDiff(today, Expdate);
                if (monthdiff >= 0) {
                    if (monthdiff > ConfigExpiryDateLevel) {
                    }
                    else {
                        return 2;
                    }
                }
            }
            function monthDiff(d1, d2) {
                var months;
                months = (d2.getFullYear() - d1.getFullYear()) * 12;
                months -= d1.getMonth();
                months += d2.getMonth();
                return months;
            }
            
            function Tblist() {
                
                var table = '';
                var tr = '';
                var end = '</table>';
                
//                if(document.getElementById('hdnSupplierName').value != "" && document.getElementById('hdnSupplierName').value != document.getElementById('ddlSupplierList').value)
//                {
//                 ValidationWindow('The Supplier Name chosen is different from the earlier entry for the same product. ', 'Error');
//                return false;
//                }
                document.getElementById('hdnSupplierName').value = document.getElementById('ddlSupplierList').value;
                document.getElementById('lblTable').innerHTML = '';
                table = "<table id='stockRtnTbl' class='w-100p responstable animated fadeIn fixResponsTable ' "
                                   + "><tr class='responstableHeader fixTableHeader a-center'><td>" + Header.Product + "</td>"
                                   + " <td>" + Header.InvoiceNo + "</td><td class='a-center'>" + Header.BatchNo + "</td><td class='a-center'>" + Header.ExpiryDate + "</td><td>" + Header.ReturnQTY + " </td><td>" + Header.ReturnCompQty + " </td>"
                                   + "<td class='a-center'>" + Header.Unit + "</td><td class='a-center'>" + Header.UnitPrice + "</td><td class='a-center'>"
                                   + Header.SchemeDisc + "</td><td class='a-center'>" + Header.NormalDisc + "</td><td class='a-center'>"
                                   + Header.Tax + "</td><td class='a-center'>" + Header.Total + "</td><td>" + Header.Action + "</td>";
        var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
        $.each(lstProductList, function(obj, value) {
            var bgcolor = '';
            if (expirylevel != '' && expirylevel != null) {
                if (expirylevel > 0) {
                    var isExpired = findExpiryItem(value.ExpiryDate, expirylevel);
                    if (isExpired == 2) {
                        bgcolor = "Orange";
                    }
                }
            }

            var pYear = moment(value.ExpiryDate).format("YYYY")
            
            tr += "<tr " + bgcolor + "><td >" + value.ProductName + "</td><td class='a-left' >"
                               + value.InvoiceNo + "</td><td class='a-left'>"
                               + value.BatchNo + "</td><td class='a-left'>"
                               + ((pYear == '1753' || pYear =='9999' || pYear =='0001') ? '**' : moment(value.ExpiryDate).format("MMM-YYYY")) + "</td><td class='a-left' >"
                               + value.Quantity + "</td><td class='a-left' >" + value.ComplimentQTY + "</td><td>"
                               + value.Unit + "</td><td class='a-right'>" + value.UnitPrice + "</td><td class='a-right'>"
                               + value.TotalSchemeDisc + "</td><td class='a-right'>" + value.TotalNormalDisc + "</td><td class='a-right'>"
                               + value.Tax + "</td><td class='a-right'>" + value.Amount + "</td>"
                               + "<td class='w-100 paddingL20'><input name='Edit' onclick='btnEdit_OnClick(" + JSON.stringify(value) + ");invoicefocus();' value = '' type='button' class='ui-icon ui-icon-pencil pull-left'  /> " +
                               "<input name='Delete' onclick='btnDelete(" + JSON.stringify(value) + ");' value = '' type='button' class='ui-icon ui-icon-trash pull-left'   /></td></tr>";
        });

        var temp = table + tr + end;

        document.getElementById('tempTable').value = temp;
        document.getElementById('lblTable').innerHTML = temp;
        document.getElementById('ddlSupplierList').disabled = false;
        document.getElementById('txtStockReturnDate').disabled = false;
        $('#chkbIsGST').attr('disabled', 'true');

        if ($("#lblTable table tr").length == 1) {
            document.getElementById('lblTable').innerHTML = '';
            $("#tdCancelSubmit").removeClass().addClass("hide");
        }
        else {
            $("#tdCancelSubmit").removeClass().addClass("a-center");
        }
        $("#stockRtnTbl").tableHeadFixer({ height: 250, tableHead: false });
    }
    function Deleterows() {


        var RowEdit = document.getElementById('hdnRowEdit').value;
        var x = document.getElementById('hdnProductList').value.split("^");
        if (RowEdit != "") {

            var pId = document.getElementById('hdnReceivedID').value;
            var pProductId = document.getElementById('hdnProductId').value;
            var pName = document.getElementById('hdnProductName').value;
            var pInvoiceNo = document.getElementById('txtInvoiceNo').value;
            var pQTY = ToInternalFormat($('#hdnTotalqty'));
            var pBatchNo = document.getElementById('txtBatchNo').value;
            var pQuantity = ToInternalFormat($('#txtQuantity'));
            var pUnit = document.getElementById('txtUnit').value;
            var pUnitPrice = ToInternalFormat($('#txtUnitPrice'));
            var pPrice = ToInternalFormat($('#txtPrice'));
            var pTax = ToInternalFormat($('#hdnTax'));
            var pStockReceivedID = document.getElementById('lblStockReceivedID').value;
            var pSellingPrice = ToInternalFormat($('#hdnSellingPrice'));
            var pExpiryDate = document.getElementById('hdnExpiryDate').value;
            var pProductKey = document.getElementById('hdnPdtRcvdDtlsID').value;
            var pReceivedUniqueNumber = document.getElementById('hdnReceivedUniqueNumber').value;
            var pParentProductID = document.getElementById('hdnParentProductID').value;


                    document.getElementById('hdnProductList').value = pId + "~" + pName + "~" + pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" + pProductId + "~" + pUnitPrice + "~" + pStockReceivedID + "~" + pPrice + "~" + pInvoiceNo + "~" + pSellingPrice + "~" + pExpiryDate + "~" + pTax + "~" + pReceivedUniqueNumber + "~" + pParentProductID + "^";

                    for (i = 0; i < x.length; i++) {
                        if (x[i] != "") {
                            if (x[i] != RowEdit) {
                                document.getElementById('hdnProductList').value += x[i] + "^";
                            }
                        }
                    }

                    Tblist();
                    document.getElementById('txtQuantity').value = '';
                    document.getElementById('txtUnit').value = '';
                }
            }
            function btnEdit_OnClick(sEditedData) {

        document.getElementById('hdnReceivedID').value = sEditedData.ID;
        document.getElementById('txtProduct').value = unescape(sEditedData.ProductName);
        document.getElementById('hdnProductName').value = unescape(sEditedData.ProductName);
        document.getElementById('txtBatchNo').value = sEditedData.BatchNo;
        //document.getElementById('txtBatchNo').readOnly = true;
        document.getElementById('txtQuantity').value = sEditedData.Quantity;
        document.getElementById('txtUnit').value = sEditedData.Unit;
        document.getElementById('hdnTotalqty').value = sEditedData.InHandQuantity;
        document.getElementById('txtBatchQuantity').value = sEditedData.InHandQuantity;
        ToTargetFormat($('#txtBatchQuantity'));
        document.getElementById('hdnProductId').value = sEditedData.ProductID;
        document.getElementById('txtUnitPrice').value = sEditedData.UnitPrice;
        ToTargetFormat($('#txtUnitPrice'));
        document.getElementById('lblStockReceivedID').value = sEditedData.Providedby;
        document.getElementById('txtPrice').value = sEditedData.Amount;
        ToTargetFormat($('#txtPrice'));
        //document.getElementById('hdnTax').value = sEditedData.Tax;
        document.getElementById('hdnSellingPrice').value = sEditedData.Rate;
        ToTargetFormat($('#hdnSellingPrice'));
        document.getElementById('hdnEditExpiryDate').value = sEditedData.ExpiryDate;
        if (sEditedData.InvoiceNo != '') {
            document.getElementById('txtInvoiceNo').value = sEditedData.InvoiceNo;
        }
        else {
            document.getElementById('txtInvoiceNo').value = '';
        }
        document.getElementById('txtSchemeDisc').value = sEditedData.SchemeDisc;
        ToTargetFormat($('#txtSchemeDisc'));
        document.getElementById('txtDisc').value = sEditedData.Discount;
        ToTargetFormat($('#txtDisc'));
        if (document.getElementById('hdnChkbIsGST').value == "Y" || Number(ToInternalFormat($('#txtCompQty'))) > 0)
        { document.getElementById('txtTax').value = 0; }
        else
        { document.getElementById('txtTax').value = document.getElementById('hdnTax').value };

        document.getElementById('txtCompQty').value = sEditedData.ComplimentQTY;

        document.getElementById('hdnPdtRcvdDtlsID').value = sEditedData.ProductReceivedDetailsID;
        document.getElementById('hdnParentProductID').value = sEditedData.ParentProductID;
        document.getElementById('hdnReceivedUniqueNumber').value = sEditedData.ReceivedUniqueNumber;

        document.getElementById('ddlSupplierList').value = document.getElementById('hdnSupplierName').value;
        document.getElementById('hdnRowEdit').value = JSON.stringify(sEditedData);
        var update = SListForAppDisplay.Get("StockReturn_StockReturn_aspx_18") == null ? "Update" : SListForAppDisplay.Get("StockReturn_StockReturn_aspx_18");
        document.getElementById('add').value = update;

        $('#divProductDetails').removeClass().addClass('show animated fadeIn');

    }

    function btnDelete(sEditedData) {

        var arrF = $.grep(lstProductList, function (n, i) {
            return n.ReceivedUniqueNumber != sEditedData.ReceivedUniqueNumber;
        });
        lstProductList = [];
        lstProductList = arrF;
        $('#hdnProductList').val(JSON.stringify(lstProductList));

        Tblist();
        document.getElementById('hdnSupplierName').value = "";

    }
    function ChangeHeightCol() {

        //document.getElementById('listProducts').style.height = '100px';

    }
    function ChangeHeightExp() {

        //document.getElementById('listProducts').style.height = '200px';
    }
    function checkSupplier1(id) {
    //arya - need to ask commented as this caused the page refresh
//        if (document.getElementById('lblTable').innerHTML != '' || $('#divProductDetails').hasClass('show')) {
//            document.location.href = location.href + '?id=' + id.value;
//        }
        if (document.getElementById('ddlSupplierList').value == 0) {
            var userMsg = SListForAppMsg.Get('StockReturn_StockReturn_aspx_04');
            var errorMsg = SListForAppMsg.Get('StockReturn_Error');
            if (userMsg != null && errorMsg != null) {
                ValidationWindow(userMsg, errorMsg);
                return false;

            }
            else {
                ValidationWindow('Select supplier', 'Error');
                return false;

            }

            document.getElementById('ddlSupplierList').focus();
            return false;
        }
        else {
            $find('AutoCompleteProduct').set_contextKey(document.getElementById('ddlSupplierList').value);
        }
        var blnExists = false;
        var BatchNoList = [];
        if ($('#hdnBatchList').val() != '') {
            BatchNoList = JSON.parse($('#hdnBatchList').val());
            var lsttempArrary = $.grep(BatchNoList, function(n, i) {
                return n.SupplierId == document.getElementById('ddlSupplierList').value.trim();
            });
        };

        if (lsttempArrary.length > 0) {
            var tempobject = lsttempArrary[0];
            document.getElementById('hdnProductName').value = unescape(tempobject.ProductName);
            document.getElementById('hdnReceivedID').value = tempobject.ID;
            document.getElementById('txtBatchQuantity').value = tempobject.InHandQuantity;
            ToTargetFormat($('#txtBatchQuantity'));
            document.getElementById('hdnTotalqty').value = tempobject.InHandQuantity;
            document.getElementById('txtUnit').value = tempobject.SellingUnit;
            document.getElementById('txtUnitPrice').value = tempobject.CostPrice;
            ToTargetFormat($('#txtUnitPrice'));
            document.getElementById('lblStockReceivedID').value = tempobject.StockReceivedId;
            document.getElementById('txtInvoiceNo').value = tempobject.InvoiceNo;
            document.getElementById('hdnTax').value = tempobject.Tax;
            document.getElementById('txtTax').value = tempobject.Tax;
            document.getElementById('hdnSellingPrice').value = tempobject.SellingPrice;
            document.getElementById('hdnExpiryDate').value = tempobject.ExpiryDate;
            document.getElementById('hdnPdtRcvdDtlsID').value = tempobject.ProductReceivedDetailsID;
            document.getElementById('hdnReceivedUniqueNumber').value = tempobject.ReceivedUniqueNumber;
            document.getElementById('hdnParentProductID').value = tempobject.ParentProductID;
            document.getElementById('ddlSupplierList').value = tempobject.SupplierId;
            $("#hdnStockReceivedBarcodeDetailsID").val(tempobject.StockReceivedBarcodeDetailsID);
            $("#hdnBarcodeNo").val(tempobject.BarcodeNo);
            document.getElementById('txtQuantity').readOnly = false;
            document.getElementById('txtQuantity').focus();
           
            blnExists = true;
             $('#divProductDetails').removeClass().addClass('show animated fadeIn'); 
        }
        //                document.getElementById('AutoCompleteProduct.ContextKey').value = ddlSupplierList.SelectedValue;
    }
    function checkSupplier() {
        if (document.getElementById('ddlSupplierList').value == 0) {
            var userMsg = SListForAppMsg.Get('StockReturn_StockReturn_aspx_04');
            var errorMsg = SListForAppMsg.Get('StockReturn_Error');
            if (userMsg != null && errorMsg != null) {
                ValidationWindow(userMsg, errorMsg);
                return false;

            }
            else {
                ValidationWindow('Select supplier', 'Error');
                return false;

            }
            document.getElementById('ddlSupplierList').focus();
            return false;
        }
        if (document.getElementById('txtProduct').value.trim() == '') {
            var userMsg = SListForAppMsg.Get('StockReturn_StockReturn_aspx_05');
            var errorMsg = SListForAppMsg.Get('StockReturn_Error');
            if (userMsg != null && errorMsg != null) {
                ValidationWindow(userMsg, errorMsg);
                return false;

            }
            else {
                ValidationWindow('Provide the product name', 'Error');
                return false;

            }
            document.getElementById('txtProduct').value = '';
            document.getElementById('txtProduct').focus();
            return false;
        }
        return true;
    }
</script>

<script language="javascript" type="text/javascript">
    function doGetProductTotalQuantity(source, eventArgs) {
        if (document.getElementById('txtProduct').value.length < 2) {
            document.getElementById("lblProdDesc").innerHTML = "";
        } else {
            var tblString = new Array();
            tblString[0] = "<table  class='responstable w-100p marginB5 animated fadeIn'>";
            var Product = SListForAppDisplay.Get('StockReturn_StockReturn_aspx_01');
            if (Product == null) {
                Product = "Product";
            }

            var BatchNo = SListForAppDisplay.Get('StockReturn_StockReturn_aspx_02');
            if (BatchNo == null) {
                BatchNo = "Batch No";
            }

            var InvoiceNo = SListForAppDisplay.Get('StockReturn_StockReturn_aspx_03');
            if (InvoiceNo == null) {
                InvoiceNo = "InvoiceNo";
            }

            var SRDNo = SListForAppDisplay.Get('StockReturn_StockReturn_aspx_04');
            if (SRDNo == null) {
                SRDNo = "SRD No";
            }

            var AvailableQty = SListForAppDisplay.Get('StockReturn_StockReturn_aspx_05');
            if (AvailableQty == null) {
                AvailableQty = "Available Qty";
            }

            var UnitPrice = SListForAppDisplay.Get('StockReturn_StockReturn_aspx_06');
            if (UnitPrice == null) {
                UnitPrice = "Unit Price";
            }

            var ExpDate = SListForAppDisplay.Get('StockReturn_StockReturn_aspx_07');
            if (ExpDate == null) {
                ExpDate = "Exp.Date";
            }

            tblString[1] = "<tr class='responstableHeader a-center'><td >Product </td><td  class='dataheader1 a-center'>Batch No</td><td  class='dataheader1'>Expiry Date</td><td  class='dataheader1'>Invoice No</td><td  class='dataheader1'>SRD No</td><td  class='dataheader1'>Available Qty</td><td  class='dataheader1 a-center'>Unit Price</td></tr>";
            tblString[2] = "";
            tblString[3] = "</table>";


            var lis = JSON.parse(eventArgs.get_value());
            var sum = 0;
            var unit = "";

            $.each(lis, function (obj, value) {
                if (value != "") {
                    var tblData = value;
                    var DateSplit = (new Date(parseInt(value.ExpiryDate.substr(6)))).format("dd/MM/yyyy") == "01/01/1753" ? "**" : (new Date(parseInt(value.ExpiryDate.substr(6)))).format("dd/MM/yyyy");
                    document.getElementById('hdnToTargetmsg').value = tblData.InHandQuantity;
                    var Vhndtargetmsgtbl3 = ToTargetFormat($('#hdnToTargetmsg'));
                    document.getElementById('hdnToTargetmsg').value = tblData.CostPrice;
                    var Vhndtargetmsgtbl5 = ToTargetFormat($('#hdnToTargetmsg'));

                    tblString[2] += "<tr><td>" + tblData.ProductName + "</td><td class='a-center'>" + tblData.BatchNo + "</td><td class='a-left'>" + DateSplit + "</td><td>" + tblData.InvoiceNo + "</td><td>" + tblData.ReceiptNo + "</td><td class='a-right'>" + Vhndtargetmsgtbl3 + "(" + tblData.SellingUnit + ")" + "</td><td class='a-right'>" + Vhndtargetmsgtbl5 + "</td></tr>";
                    sum += parseFloat(tblData.InHandQuantity);

                    unit = "(" + tblData.SellingUnit + ")";
                }
            });
            var tsum = sum.toFixed(2);
            document.getElementById('hdnToTargetmsg').value = tsum;
            var Vhndtargetmsgtblsum = ToTargetFormat($('#hdnToTargetmsg'));
            tblString[2] += "<tr><td colspan='5' class='a-right bold'><%=Resources.StockReturn_ClientDisplay.StockReturn_StockReturn_aspx_21%></td><td class='a-right bold'>" + Vhndtargetmsgtblsum + unit + "</td></tr>";
            document.getElementById("lblProdDesc").innerHTML = tblString[0] + tblString[1] + tblString[2] + tblString[3];
        }
    }

    function doClearTable() {
        if (document.getElementById('txtProduct').value.length < 2) {
            document.getElementById("lblProdDesc").innerHTML = ""
        }
        else
            $find('AutoCompleteProduct').set_contextKey(document.getElementById('ddlSupplierList').value);
    }



    function invoicefocus() {
        document.getElementById('txtInvoiceNo').focus();
    }
    function pSetFocus(obj) {
        var lis = document.getElementById('hdnBatchList').value.split('^');
    }
    function IAmSelected(source, eventArgs) {

        if (document.getElementById('txtProduct').value.trim() == '') {
            document.getElementById('lblProdDesc').innerHTML = '';
        }
        document.getElementById('hdnBatchList').value = '';
        document.getElementById('hdnProductId').value = '';
        var t = JSON.parse(eventArgs.get_value());
        var lstArray = JSON.parse(eventArgs.get_value());
        var lis = lstArray[0];
        var arrF = new Object();
        var arrX = [];
        arrY = [];
         document.getElementById('hdnSupplierId').value = "";
        $.each(lstArray, function (obj, value) {
            arrF = $.grep(lstProductList, function (n, i) {
                return n.ReceivedUniqueNumber == value.ReceivedUniqueNumber
            });
            if (arrF.length > 0) {
                $.merge(arrY, arrF)
            }
        });

        if (arrY.length > 0) {
            if (arrY.length == lstArray.length) {
                alert("Product already Added");
                return false;
            }
            var pid = Enumerable.From(lstArray).Select("$.ReceivedUniqueNumber").ToArray();
            var npid = Enumerable.From(arrY).Select("$.ReceivedUniqueNumber").ToArray();
            var rpid = [];
            jQuery.grep(pid, function (el) {
                if (jQuery.inArray(el.toString(), npid) == -1)
                    rpid.push(el);
            });
            arrX = Enumerable.From(lstArray).Where(function (x) { return Enumerable.From(rpid).Contains(x.ReceivedUniqueNumber) }).ToArray();
        }
        else {
            arrX = lstArray;
        }
  
            
              
        document.getElementById('hdnBatchList').value = JSON.stringify(arrX);
        document.getElementById('hdnProductId').value = lis.ProductID;

        var pid = document.getElementById('hdnProductId').value;
        document.getElementById('hdnProBatchNo').value = '';
        document.getElementById('txtQuantity').value = '';
        document.getElementById('txtBatchQuantity').value = '';
        document.getElementById('txtUnit').value = '';
        document.getElementById('txtBatchNo').value = '';
        document.getElementById('txtPrice').value = '';
        document.getElementById('hdnPdtRcvdDtlsID').value = '';
        document.getElementById('hdnReceivedUniqueNumber').value = '';
        document.getElementById('hdnParentProductID').value = '';
        document.getElementById('txtStockReceiveNo').value = '';
        document.getElementById('txtSchemeDisc').value = '';
        document.getElementById('txtDisc').value = '';
        document.getElementById('txtCompQty').value = '';
        
        if ($('#hdnBatchList').val() != '') {
            var x = JSON.parse($('#hdnBatchList').val());
            var isAddItem = 0;
             var val1 = "";
            $.each(x, function (obj, value) {
           
            document.getElementById('hdnSupplierId').value  +=  value.SupplierId +"*" + value.SupplierName + "|";
             });
 GetSupplier();
              
            $.each(x, function (obj, value) {
            
                if (CheckTaskItems(pid + "~" + value.ReceivedUniqueNumber)) {
                    document.getElementById('hdnProBatchNo').value += value.BatchNo + "@#$" + value.ID + "|";
                  //arya
                  $('#divProductDetails').removeClass().addClass('show animated fadeIn');
                    if (arrX.length > 0) {
                        if (isAddItem == 0) {
                            document.getElementById('txtBatchNo').value += value.BatchNo;
                            document.getElementById('ddlSupplierList').value = value.SupplierId;
                            document.getElementById('hdnReceivedID').value = value.ID;
                            BindQuantity();
                            isAddItem = 1;
                        }
                    }
                }
//                document.getElementById('ddlSupplierList').disabled = true;
//arya
$('#ddlSupplierList option:not(:selected)').attr('disabled', true);
            });
        }
       
        AutoCompBacthNo();
        ProductItemSelected(source, eventArgs);
//        var temp = "";
//          var lst = t;
//       var arrFt = new Object();
//        $.each(lst, function(obj, value) {
//        arrFt = $.grep(lst, function (n, i) {
//                return n.SupplierId == value.SupplierId
//            });

//                         });
//                         lst = arrFt;
//         ddlSupplierList.append($("<option></option>").val("-1").html("---Select Supplier--"));
//         $.each(lst, function(obj, value) {
//	$('#ddlSupplierList').append($("<option></option>").val(value.SupplierId.toString()).html(value.SupplierName));
//        });
    
//    var optionValues =[];
//$('#ddlSupplierList option').each(function(){
//   if($.inArray(this.value, optionValues) >-1){
//      $(this).remove()
//   }
    
   
    
    
    }
    function AutoCompBacthNo() {
        var customarray = document.getElementById('hdnProBatchNo').value.split("|");
        actb(document.getElementById('txtBatchNo'), customarray);
    }
    function GetSupplier() {
        var arrF = new Object();
        var arrX = [];
        arrY = [];
        var temp = "";
        $('#ddlSupplierList').empty();
        //  $("#ddlSupplierList > option").remove();
        $('#ddlSupplierList').append($("<option></option>").val("-1").html("---Select Supplier--"));
        var x = document.getElementById('hdnSupplierId').value.split("|");
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('*');
                z = x[i + 1].split('*');
                if (y[0] != z[0]) {
                    $('#ddlSupplierList').append($("<option></option>").val(y[0].toString()).html(y[1]));
                }

            }
        }
    }





    function Calctotal() {
        if (document.getElementById('txtQuantity').value == "") {
            document.getElementById('txtPrice').value = "0.00";
            ToTargetFormat($('#txtPrice'));

            $("#hdnReturnProdsScheDisc").val(0);
            ToTargetFormat($("#hdnReturnProdsScheDisc"));
            $("#hdnReturnProdsDisc").val(0);
            ToTargetFormat($("#hdnReturnProdsDisc"));
        }
        else {
            var vtxtPrice1 = ToInternalFormat($('#txtUnitPrice'));
            var vtxtUnit1 = ToInternalFormat($('#txtQuantity'));
            var vtxtTax1 = ToInternalFormat($('#txtTax'));
            var vtxtBatchQty = ToInternalFormat($('#txtBatchQuantity'));
            var vtxtDisc = $('#hdnRecdProdsNormalDisc').val();
            var vtxtSchemeDisc = $('#hdnRecdProdsScheDisc').val();
            var vRecdTotalQty = document.getElementById('hdnRecdTotalQty').value;

            $("#hdnReturnProdsScheDisc").val(0);
            $("#hdnReturnProdsDisc").val(0);

            var vSingleProductDisc = 0, vSchemeDisc = 0, vNormalDisc = 0, vTotal = 0;
            var vRetProdsTotalSchDiscAmt = 0, vRetProdsTotalNormalDiscAmt = 0;

            if (document.getElementById('hdnIsSchemeDisc').value == 'Y') {
                /* Get Single Product Scheme Discount : SchemeDisc / RecdTotalQty     */
                vSchemeDisc = parseFloat(parseFloat(vtxtSchemeDisc / vRecdTotalQty)).toFixed(3);

                /* Get Single Product Normal Discount : NormalDisc/ RecdTotalQty     */
                vNormalDisc = parseFloat(parseFloat(vtxtDisc / vRecdTotalQty)).toFixed(2);
                vSingleProductDisc = parseFloat(parseFloat(vSchemeDisc) + parseFloat(vNormalDisc));
                
            }
            else {
                /* Get Single Product Normal Discount : TotalDiscount / RecdTotalQty     */
                vNormalDisc = parseFloat(parseFloat(vtxtDisc / vRecdTotalQty).toFixed(2));
                vSingleProductDisc = parseFloat(vNormalDisc).toFixed(2);
            }
            
            vRetProdsTotalSchDiscAmt = parseFloat(parseFloat(vtxtUnit1) * parseFloat(vSchemeDisc)).toFixed(2);
            vRetProdsTotalNormalDiscAmt = parseFloat(parseFloat(vtxtUnit1) * parseFloat(vNormalDisc)).toFixed(2);

            $("#hdnReturnProdsScheDisc").val(vRetProdsTotalSchDiscAmt);
            $("#hdnReturnProdsDisc").val(vRetProdsTotalNormalDiscAmt);

            /* Get Return Products Total Discount : Return Qty * Single Prod Discount     */
            var vReturnQtyTotalDisc = parseFloat(parseFloat(vtxtUnit1) * parseFloat(vSingleProductDisc)).toFixed(2);

            /* Get Return Products Total Amount : ((UnitPrice * ReturnQty) - ReturnQty Total Discount)    */
            vTotal = parseFloat(parseFloat(parseFloat(vtxtPrice1) * parseFloat(vtxtUnit1)) - parseFloat(vReturnQtyTotalDisc)).toFixed(2);

            if (document.getElementById('hdnChkbIsGST').value == "Y") {
                document.getElementById('txtPrice').value = parseFloat(vTotal).toFixed(2);
                document.getElementById('txtTax').value = 0;
            }
            else {
                document.getElementById('txtTax').value = document.getElementById('hdnTax').value;
                vtxtTax1 = document.getElementById('txtTax').value;
                vTotal = parseFloat(vtxtPrice1 * vtxtUnit1 - parseFloat(vReturnQtyTotalDisc));
                document.getElementById('txtPrice').value = parseFloat(vTotal) + parseFloat(vTotal / 100 * vtxtTax1);
            }

            ToTargetFormat($('#txtPrice'));
            ToTargetFormat($("#hdnReturnProdsScheDisc"));
            ToTargetFormat($("#hdnReturnProdsDisc"));
        }
    }

    function Checked() {
        if (document.getElementById('chkbIsGST').checked == true) {
            ValidationWindow('If IsGST checked then GST will not be applied for return products.', 'Alert');
            document.getElementById('hdnChkbIsGST').value = "Y";
        }
        else {
            document.getElementById('hdnChkbIsGST').value = "N";
        }
        Calctotal();
    }


    function CheckQty() {
        if (document.getElementById('hdnRecdTotalQty').value == 0 && Number(ToInternalFormat($('#txtQuantity'))) > 0) {
            ValidationWindow('Specified Batch No of Product has no Return Qunatity.', 'Alert');
            document.getElementById('txtQuantity').value = '';
            return false;
        }
        else if (document.getElementById('hdnCompQty').value == 0 && Number(ToInternalFormat($('#txtCompQty'))) > 0) {
        ValidationWindow('Specified Batch No of Product has no Complementary Qunatity', 'Alert');
            document.getElementById('txtCompQty').value = '';
            return false;
        }
//        else {
//          if (Number(ToInternalFormat($('#txtQuantity'))) > 0)
//          {
//            Calctotal();
//          }
//        }

        var AvailCompQty = (document.getElementById('hdnCompQty').value - document.getElementById('hdnReturnedCompQty').value)
        if (Number(ToInternalFormat($('#txtCompQty'))) > AvailCompQty) {
            ValidationWindow('Provide actual ComplQty.', 'Alert');
            document.getElementById('txtCompQty').value = '';
            return false;
        }

        var AvailReturnQty = (document.getElementById('hdnTotalqty').value - AvailCompQty)
        if (Number(ToInternalFormat($('#txtQuantity'))) > AvailReturnQty) {
            ValidationWindow('Entered Return Quantity greater than Inhand Quantity.', 'Alert');
            document.getElementById('txtQuantity').value = '';
            document.getElementById('txtPrice').value = "0.00";
            ToTargetFormat($('#txtPrice'));
            return false;
        }

         if (Number(ToInternalFormat($('#txtQuantity'))) > 0) {
             Calctotal();
         }
    }

    function Calctotal1() {
        if (document.getElementById('txtQuantity').value == "") {
            document.getElementById('txtPrice').value = "0.00";
            ToTargetFormat($('#txtPrice'));
        }
        else {
            var vtxtPrice1 = ToInternalFormat($('#txtUnitPrice'));
            var vtxtUnit1 = ToInternalFormat($('#txtQuantity'));
            document.getElementById('txtPrice').value = parseFloat(parseFloat(vtxtPrice1) * parseFloat(vtxtUnit1)).toFixed(2);
            ToTargetFormat($('#txtPrice'));
        }
    }
    function CheckTaskItems(obj) {
        var x1 = document.getElementById("hdnAddedTaskList").value.split("^");
        for (j = 0; j < x1.length; j++) {
            if (x1[j] != "") {
                if (x1[j] == obj) {
                    return false
                }
            }
        }
        return true;
    }
    
    function formatDate(date) {
        var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Agu', 'Sep', 'Oct', 'Nov', 'Dec'];
        var day = date.getDate();
        var year = date.getFullYear();
        var month = months[date.getMonth()];
        if (year == "1753" || year == "9999" || year == "0001" || year == "1752") {
            return "**";
        }
        else {
            return month + "- " + year;
        }
    }
    
    function compare(dateTimeA, dateTimeB) {
        var momentA = moment(dateTimeA, "DD/MM/YYYY");
        var momentB = moment(dateTimeB, "DD/MM/YYYY");
        if (momentA > momentB) return 1;
        else if (momentA < momentB) return -1;
        else return 0;
    }
    function BindQuantity() {
        var blnExists = false;
        var BatchNoList = [];
        if ($('#hdnBatchList').val() != '') {
            BatchNoList = JSON.parse($('#hdnBatchList').val());
            var lsttempArrary = $.grep(BatchNoList, function(n, i) {
                return n.BatchNo == document.getElementById('txtBatchNo').value.trim();
            });
        };

        if (lsttempArrary.length > 0) {
            var tempobject = lsttempArrary[0];
            document.getElementById('hdnProductName').value = unescape(tempobject.ProductName);
            document.getElementById('hdnReceivedID').value = tempobject.ID;
            document.getElementById('txtBatchQuantity').value = tempobject.InHandQuantity;
            ToTargetFormat($('#txtBatchQuantity'));
            document.getElementById('hdnTotalqty').value = tempobject.InHandQuantity;
            document.getElementById('txtUnit').value = tempobject.SellingUnit;
            document.getElementById('txtUnitPrice').value = tempobject.CostPrice;
            ToTargetFormat($('#txtUnitPrice'));
            document.getElementById('lblStockReceivedID').value = tempobject.StockReceivedId;
            document.getElementById('txtInvoiceNo').value = tempobject.InvoiceNo;
            $("#hdnRecdProdsScheDisc").val(tempobject.SchemeDisc);
            //ToTargetFormat($('#hdnRecdProdsScheDisc'));
            $("#hdnRecdProdsNormalDisc").val(tempobject.Discount);
            //ToTargetFormat($('#hdnRecdProdsNormalDisc'));
            var pRecdTotalNormalDisc = $('#hdnRecdProdsNormalDisc').val();
            var pRecdTotalSchemeDisc = $('#hdnRecdProdsScheDisc').val();
            var vSchemeDisc = parseFloat(parseFloat(pRecdTotalSchemeDisc / tempobject.RECQuantity));
            document.getElementById('txtSchemeDisc').value = parseFloat(vSchemeDisc).toFixed(3);
            
            //ToTargetFormat($("#txtSchemeDisc"));
            var vDisc = parseFloat(parseFloat(pRecdTotalNormalDisc / tempobject.RECQuantity));
            document.getElementById('txtDisc').value = parseFloat(vDisc).toFixed(2);
            //ToTargetFormat($("#txtDisc"));

            document.getElementById('hdnRecdTotalQty').value = tempobject.RECQuantity;
            document.getElementById('hdnCompQty').value = tempobject.ComplimentQTY;
            document.getElementById('hdnReturnedCompQty').value = tempobject.SubstoreReturnqty // Total ReturnedCompQty;

            var tdate = new Date(GetServerDate()).format("dd/MM/yyyy");
            var Expdate = (new Date(parseInt(tempobject.ExpiryDate.substr(6)))).format("dd/MM/yyyy");
            // var DateSplit = (new Date(parseInt(value.ExpiryDate.substr(6)))).format("dd/MM/yyyy") == "01/01/1753" ? "**" : (new Date(parseInt(value.ExpiryDate.substr(6)))).format("dd/MM/yyyy");

            if (Expdate == "01/01/1753") {
                Expdate = new Date(GetServerDate()).format("dd/MM/yyyy");
            }
            
            var res = compare(Expdate, tdate);
            if (res == -1) {
                document.getElementById('hdnTax').value = 0;
                document.getElementById('txtTax').value = 0;
            }
            // else if(res == -1 && document.getElementById(hdnNoGSTforExpiredProducts).value == 'Y')
            else {
                if (document.getElementById('hdnChkbIsGST').value == "Y") {
                    document.getElementById('hdnTax').value = 0;
                    document.getElementById('txtTax').value = 0;
                }
                else {
                    document.getElementById('hdnTax').value = tempobject.Tax;
                    document.getElementById('txtTax').value = tempobject.Tax;
                }
            }
            document.getElementById('hdnSellingPrice').value = tempobject.SellingPrice;
            document.getElementById('hdnExpiryDate').value = tempobject.ExpiryDate;
            document.getElementById('hdnPdtRcvdDtlsID').value = tempobject.ProductReceivedDetailsID;
            document.getElementById('hdnReceivedUniqueNumber').value = tempobject.ReceivedUniqueNumber;
            document.getElementById('hdnParentProductID').value = tempobject.ParentProductID;
            document.getElementById('ddlSupplierList').value = tempobject.SupplierId;
            document.getElementById('txtStockReceiveNo').value = tempobject.ReceiptNo;
            $("#hdnStockReceivedBarcodeDetailsID").val(tempobject.StockReceivedBarcodeDetailsID);
            $("#hdnBarcodeNo").val(tempobject.BarcodeNo);
            $("#txtStockReceiveNo").val(tempobject.ReceiptNo);

            document.getElementById('txtQuantity').readOnly = false;
            document.getElementById('txtQuantity').focus();
            if (lsttempArrary.length == 1) {
                $('#ddlSupplierList option:not(:selected)').attr('disabled', true);
            }
            else {
                $('#ddlSupplierList').removeAttr('disabled');
                $("#ddlSupplierList").prop("disabled", false);
                $('#ddlSupplierList option:not(:selected)').attr('disabled', false);

            }
            blnExists = true; 
        }
        if (blnExists == false) {
            document.getElementById('txtUnit').value = '';
            document.getElementById('txtBatchQuantity').value = '';
            document.getElementById('txtBatchNo').value = '';
            return false;
        }
    }
</script>

</body>
</html>

