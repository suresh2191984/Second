<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="INVBulkUpdate.aspx.cs"
    Inherits="StockManagement_INVBulkUpdate" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Inventory Bulk Update</title>
</head>
<body runat="server">
    <form id="prFrm" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />

    <script type="text/javascript" language="javascript">
        var ErrMsg = SListForAppMsg.Get('StockManagement_Error') == null ? "Alert" : SListForAppMsg.Get('StockManagement_Error');
        var informMsg = SListForAppMsg.Get('StockManagement_Information') == null ? "Information" : SListForAppMsg.Get('StockManagement_Information');
        var okMsg = SListForAppMsg.Get('StockManagement_Ok') == null ? "Ok" : SListForAppMsg.Get('StockManagement_Ok')
        var cancelMsg = SListForAppMsg.Get('StockManagement_Cancel') == null ? "Cancel" : SListForAppMsg.Get('StockManagement_Cancel');
        function ShowAlertMsg(key) {
            if (key == "StockManagement_INVBulkUpdate_aspx_05") {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_05') == null ? "Successfully Updated" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_05');
                ValidationWindow(userMsg, ErrMsg);
            }
            else if (key == "StockManagement_INVBulkUpdate_aspx_06") {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_06') == null ? "Successfully saved" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_06');
                ValidationWindow(userMsg, ErrMsg);
            }
            else if (key == "StockManagement_INVBulkUpdate_aspx_07") {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_07') == null ? "Product Added Successfully" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_07');
                ValidationWindow(userMsg, ErrMsg);
            }

            return true;
        }
        function ShowAlertMsg1() {
            var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_08') == null ? "Product combination already exist" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_08');
            ValidationWindow(userMsg, ErrMsg);
            return true;
        }



        var userMsg;
        function checkValidation() {
            var e = document.getElementById("ddlCategory");
            var category = e.options[e.selectedIndex].value;

            if (document.getElementById('txtProduct').value.trim() == '' && $('#txtGenericName2').val() == '' && category == '0') {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_09') == null ? "Enter the product name" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_09');
                ValidationWindow(userMsg, ErrMsg);

                document.getElementById('txtProduct').focus();
                return false;
            }
            return true;
        }
        function ProductsListPopup(obj, cName) {
            window.open("../StockManagement/PopUpProductUpdate.aspx?val=" + obj + "&CName=" + cName + "&IsPopup=Y", null, "height=450,width=1500,scrollbars=yes");
            return false;

        }
        function setItem(id) {
            var obj = document.getElementById(id);
            var i = obj.getElementsByTagName('OPTION');
            document.getElementById("txtProduct").value = obj.options[obj.selectedIndex].text;
        }
        function ShowAddProduct() {
            document.getElementById('hdnGenericID').value = '0';
            document.getElementById('txtproProduct').value = ''
            document.getElementById('ddlproCategory').value = '0';
            document.getElementById('txtproBatchNo').value = '';
            document.getElementById('ddlproExpMonth').value = '-1';
            document.getElementById('ddlproExpYear').value = '-1';
            document.getElementById('txtproQuantity').value = '0';
            document.getElementById('ddlproUnit').value = '0';
            document.getElementById('txtproSellingPrice').value = '0';
            document.getElementById('txtproUnitPrice').value = '0';
            if ($('#hdnHideTaxpercen').val() == "Y") {
                document.getElementById('txtproTax').value = '0';
                //document.getElementById('txtproTax').style.display = 'none';
                $('#txtproTax').removeClass().addClass('hide');
            }
            else {
                document.getElementById('txtproTax').value = '0';

            }
            document.getElementById('ddlType').value = '0';
            //document.getElementById('divAddProduct').style.display = 'Block';
            $('#divAddProduct').removeClass().addClass('show');
            //document.getElementById('DivResult').style.display = 'none';
            $('#DivResult').removeClass().addClass('hide');
            //document.getElementById('divAction').style.display = 'none';
            $('#divAction').removeClass().addClass('hide');
            //document.getElementById('tdlist').style.display = 'none';
            $('#tdlist').removeClass().addClass('hide');
            // document.getElementById('txtproProduct').focus();
            document.getElementById('txtGenericName').focus();
            return false;
        }
        function CheckAddProduct() {

            if (document.getElementById('txtproProduct').value.trim() == '') {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_10') == null ? "Provide the product name" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_10');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('txtproProduct').focus();
                return false;
            }
            if (document.getElementById('ddlproCategory').value == '0') {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_11') == null ? "Select the category" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_11');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('ddlproCategory').focus();
                return false;
            }
            if (document.getElementById('ddlType').value == "0") {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_12') == null ? "Select the type" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_12');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('ddlType').focus();
                return false;
            }
            if (document.getElementById('txtproBatchNo').value.trim() == '') {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_13') == null ? "Provide the BatchNo" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_13');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('txtproBatchNo').focus();
                return false;
            }
            if (document.getElementById('ddlproExpMonth').value == '-1') {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_14') == null ? "Provide the Month" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_14');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('ddlproExpMonth').focus();
                return false;
            }
            if (document.getElementById('ddlproExpYear').selectedIndex == '0') {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_15') == null ? "Provide the Year" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_15');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('ddlproExpYear').focus();
                return false;
            }
            if (document.getElementById('txtproQuantity').value.trim() == '') {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_16') == null ? "Provide the quantity" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_16');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('txtproQuantity').focus();
                return false;
            }
            if (document.getElementById('ddlproUnit').value == '0') {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_17') == null ? "Select the unit" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_17');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('ddlproUnit').focus();
                return false;
            }
            if ((document.getElementById('txtproUnitPrice').value.trim() == '') || (document.getElementById('txtproUnitPrice').value == 0)) {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_18') == null ? "Provide the Cost price" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_18');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('txtproUnitPrice').focus();
                return false;
            }
            if ((document.getElementById('txtproSellingPrice').value.trim() == '') || (document.getElementById('txtproSellingPrice').value == 0)) {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_19') == null ? "Provide the selling price" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_19');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('txtproSellingPrice').focus();
                return false;
            }
            if (document.getElementById('txtproTax').value.trim() == '') {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_20') == null ? "Provide the tax" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_20');
                ValidationWindow(userMsg, ErrMsg);
                document.getElementById('txtproTax').focus();
                return false;
            }
            return true;
        }
        function btnDisplayNone() {
            //document.getElementById('btnUpdate').style.display = "hide";
            $('#btnUpdate').removeClass().addClass('hide');
        }

        function fu_save(obj) {

            //document.getElementById(obj).style.display = "hide";
            $('#' + obj).removeClass().addClass('hide');


        }

        /*Colour change for Trusted Drugs start*/
        function SetColor() {

            var completionList = $find("AutoCompleteExtender1").get_completionList().childNodes;
            var HighlightProduct = '';
            var _Color = '';
            for (var i = 0; i < completionList.length; i++) {
                _Color = completionList[i]._value.split('^');
                if (_Color != undefined && _Color != '') {
                    HighlightProduct = _Color[0].split('~')[12];
                } else {
                    HighlightProduct = 'N';
                }
                if (HighlightProduct == 'Y') {
                    completionList[i].style.color = "orange";
                }
            }
        }
        /*Colour change for Trusted Drugs End*/
        function isSpclChar(e) {
            var key;
            var isCtrl = false;

            if (window.event) // IE8 and earlier
            {
                key = e.keyCode;
            }
            else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
            {
                key = e.which;
            }

            if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
                isCtrl = true;
            }

            return isCtrl;
        }

        function SelectGeneric(source, eventArgs) {
            var PColval = eventArgs.get_value().split('~');
            document.getElementById('hdnGenericID').value = PColval[0];
            //            document.getElementById('txtGenericName').value = PColval[1];

        }
        function SelectProduct(source, eventArgs) {
            var PColval = eventArgs.get_value().split('~');
            document.getElementById('hdnGenericID').value = PColval[0];
            //document.getElementById('txtGenericName').value = PColval[1];

            var CategoryName = "[" + eventArgs._value.split('~')[2] + "]";

            // $("#txtProduct").val($.trim(eventArgs._text.substring(0, eventArgs._text.indexOf("["))));

            $("#txtProduct").val($.trim(eventArgs._text.replace(CategoryName, "")));
        }
        //petchi
        function ProductItemsSelected(source, eventArgs) {
            debugger;
            var Product = eventArgs.get_text().split('^^');
            document.getElementById('txtProduct').value = Product[0];

        }
        function calculateselling1() {
            // alert('hi');
            var IsRule = document.getElementById('hdnIsSellingPriceRuleApply').value;
            if (IsRule == "Y") {
                AutoSellingprice1();
            }

        }
        function Checkqty(row) {

            var idindex = row.id.lastIndexOf('_');
            var index = row.id.substring(0, idindex);
            var inhandqty = document.getElementById(index + '_txtQuantity').value;
            var hdnqty = document.getElementById(index + '_hdnDamage').value;
            var Orginalqty = document.getElementById(index + '_hdnHand').value;

            if (Number(inhandqty) < Number(hdnqty)) {
                var userMsg = SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_25') == null ? "does not update the stock" : SListForAppMsg.Get('StockManagement_INVBulkUpdate_aspx_25');
                ValidationWindow(userMsg, ErrMsg);
                // alert('does not update the stock');
                document.getElementById(index + '_txtQuantity').value = Orginalqty;
            }
            return false;

        }


        function AutoSellingprice1() {
            var Istrue = false;

            var pNominalDiscount = 0;
            var pselval = document.getElementById('hdnSellingPrieRuleList').value.split("^");
            var tax = ToInternalFormat($("#txtproTax")) == 0.00 ? 0 : ToInternalFormat($("#txtproTax"));
            var Costprice = ToInternalFormat($("#txtproUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtproUnitPrice"));
            var UnitPrice = pNominalDiscount > 0 ? parseFloat(parseFloat(Costprice) - parseFloat(pNominalDiscount)).toFixed(6) : ToInternalFormat($("#txtproUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtproUnitPrice"));
            var tempTaxAmt = parseFloat(parseFloat(parseFloat(UnitPrice) / parseFloat(100)) * parseFloat(tax)).toFixed(6);
            var sellingPrice = 0.00;
            var Price = 0.00;
            Price = parseFloat(parseFloat(UnitPrice) + parseFloat(tempTaxAmt)).toFixed(6);

            var i;
            if (Price > 0) {

                for (i = 0; i < pselval.length; i++) {
                    if (pselval[i] != "" && Istrue == false) {
                        p_sel = pselval[i].split('~');

                        if (parseFloat(Price) >= parseFloat(p_sel[1]) && parseFloat(Price) <= parseFloat(p_sel[2])) {

                            sellingPrice = parseFloat(parseFloat(Price) + parseFloat(parseFloat(Price) * parseFloat(parseFloat(p_sel[3]) / 100))).toFixed(6)
                            document.getElementById('txtproSellingPrice').value = parseFloat(sellingPrice).toFixed(6);
                            document.getElementById('txtproSellingPrice').value = parseFloat(sellingPrice).toFixed(6);
                            //grdResult_ctl02_txtSellingPrice
                            ToTargetFormat($('#txtproSellingPrice'));
                            Istrue = true;
                        }

                    }
                }
            }
        }

        function calculateselling(ele) {
            var IsRule = document.getElementById('hdnIsSellingPriceRuleApply').value;
            if (IsRule == "Y") {
                var idFrame = $(ele).attr('id').split('_');
                var unitPrice = idFrame[0] + '_' + idFrame[1] + '_' + 'txtUnitPrice';
                var sPrice = idFrame[0] + '_' + idFrame[1] + '_' + 'txtSellingPrice';
                var Tax = idFrame[0] + '_' + idFrame[1] + '_' + 'txtTax';
                AutoSellingprice(unitPrice, sPrice, Tax);
            }

        }

        function AutoSellingprice(unitPrice, sPrice, Tax) {
            var Istrue = false;

            var pNominalDiscount = 0;
            var pselval = document.getElementById('hdnSellingPrieRuleList').value.split("^");
            var tax = ToInternalFormat($('#' + Tax)) == 0.00 ? 0 : ToInternalFormat($('#' + Tax));
            var Costprice = ToInternalFormat($('#' + unitPrice)) == 0.00 ? 0 : ToInternalFormat($('#' + unitPrice));
            var UnitPrice = pNominalDiscount > 0 ? parseFloat(parseFloat(Costprice) - parseFloat(pNominalDiscount)).toFixed(6) : ToInternalFormat($('#' + unitPrice)) == 0.00 ? 0 : ToInternalFormat($('#' + unitPrice));
            var tempTaxAmt = parseFloat(parseFloat(parseFloat(UnitPrice) / parseFloat(100)) * parseFloat(tax)).toFixed(6);
            var sellingPrice = 0.00;
            var Price = 0.00;
            Price = parseFloat(parseFloat(UnitPrice) + parseFloat(tempTaxAmt)).toFixed(6);

            var i;
            if (Price > 0) {

                for (i = 0; i < pselval.length; i++) {
                    if (pselval[i] != "" && Istrue == false) {
                        p_sel = pselval[i].split('~');

                        if (parseFloat(Price) >= parseFloat(p_sel[1]) && parseFloat(Price) <= parseFloat(p_sel[2])) {

                            sellingPrice = parseFloat(parseFloat(Price) + parseFloat(parseFloat(Price) * parseFloat(parseFloat(p_sel[3]) / 100))).toFixed(6)
                            $('#' + sPrice).val(parseFloat(sellingPrice).toFixed(6));
                            ToTargetFormat($('#' + sPrice));
                            Istrue = true;
                        }

                    }
                }
            }
        }
    </script>
    
<div class="contentdata">
        <div class="a-right hide">
            <asp:LinkButton ID="lnkHome" runat="server" Text="Home  " CssClass="details_label_age"
                OnClick="lnkHome_Click" meta:resourcekey="lnkHomeResource1"></asp:LinkButton>
        </div>
        <div class="marginT10 marginB10">
            <div class="w-97p marginauto card-md card-md-default padding10">
                <table id="stockReceivedTab" runat="server" class="w-100p lh25">
                    <tr id="Tr2" runat="server" class="panelContent lh25">
                        <td class="a-left w-10p" runat="server">
                            <asp:Label ID="lblSelectCategory" runat="server" CssClass="bold" Text="Select Category :" meta:resourcekey="lblSelectCategoryResource1"></asp:Label>
                        </td>
                        <td runat="server" class="w-30p a-center">
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="large " meta:resourcekey="ddlCategoryResource1">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <%--OnClientClick="javascript:if(!checkValidation()) return false;"--%>
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                        </td>
                        <td  class="a-center" id="tdlist" rowspan="3" runat="server">
                            <asp:ListBox ID="listSearch" Visible="False" CssClass="style_lst1 listBox w-100p" runat="server"
                                onClick="javascript:setItem(this.id);" meta:resourcekey="listSearchResource1">
                            </asp:ListBox>
                        </td>
                        
                        <td id="tdidNewProduct" class="hide" runat="server">
                            <asp:Button ID="btnAddProduct" runat="server" CssClass="btn" Text="Add Products"
                                OnClientClick="javascript:if(!ShowAddProduct()) return false;"
                                meta:resourcekey="btnAddProductResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Generic Name :" CssClass="bold" meta:resourcekey="Label1Resource1"></asp:Label>
                        </td>
                        <td class="a-center">
                            <asp:TextBox ID="txtGenericName2" CssClass="large bg-searchimage" runat="server" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtProductResource1"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtGenericName2"
                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                OnClientItemSelected="SelectGeneric" MinimumPrefixLength="1" CompletionInterval="1"
                                FirstRowSelected="True" ServiceMethod="GetSearchGenericList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                DelimiterCharacters="" Enabled="True">
                            </ajc:AutoCompleteExtender>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td class="a-left" runat="server">
                            <asp:Label ID="lblProduct" runat="server" CssClass="bold" Text="Product :" meta:resourcekey="lblProductResource1"></asp:Label>
                        </td>
                        <td class="a-center" runat="server">
                            <asp:TextBox ID="txtProduct" CssClass="large bg-searchimage" runat="server" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtProductResource1"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProduct"
                                OnClientItemSelected="SelectProduct" ServiceMethod="GetSearchProductList"
                                ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" EnableCaching="False"
                                MinimumPrefixLength="1" CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" FirstRowSelected="True"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="wordWheel itemsMain"
                               Enabled="True" OnClientPopulated="SetColor" BehaviorID="AutoCompleteExtender1">
                            </ajc:AutoCompleteExtender>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td class="a-center" colspan="8" runat="server">
                            <asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr id="Tr1" runat="server">
                        <td id="Td1" colspan="8" runat="server">
                            <div id="divAddProduct" runat="server" class="hide">
                                <asp:Panel ID="pnNewProduct" runat="server" GroupingText="ADD NEW PRODUCT" meta:resourcekey="pnNewProductResource1">
                                    <table class="w-100p">
                                        <tr class="a-center">
                                            <td>
                                                <asp:Label ID="lblGeneric" runat="server" Text="Generic Name" meta:resourcekey="lblGenericResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblProdu" runat="server" Text="Product" meta:resourcekey="lblProduResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCategory" runat="server" Text="Category" meta:resourcekey="lblCategoryResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblType" runat="server" Text="Type" meta:resourcekey="lblTypeResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblBatchNo" runat="server" Text="BatchNo" meta:resourcekey="lblBatchNoResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblEXPDate" runat="server" Text="EXP Date" meta:resourcekey="lblEXPDateResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblRcvdQty" runat="server" Text="Rcvd Qty" meta:resourcekey="lblRcvdQtyResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblUnits" runat="server" Text="Units" meta:resourcekey="lblUnitsResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCost" runat="server" Text="Cost Price" meta:resourcekey="lblCostResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSelling" runat="server" Text="Selling Price" meta:resourcekey="lblSellingResource1"></asp:Label>
                                            </td>
                                            <td runat="server" id="tdTaxperc">
                                                <asp:Label ID="lblTaxPercent" runat="server" Text="Tax%" meta:resourcekey="lblTaxPercentResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblRakNo" runat="server" Text="Rak No" meta:resourcekey="lblRakNoResource1"></asp:Label>
                                            </td>
                                               <td>
                                                <asp:Label ID="lblRemarks" runat="server" Text="Remarks" meta:resourcekey="lblRemarksResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblAction" runat="server" Text="Action" meta:resourcekey="lblActionResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtGenericName" runat="server" MaxLength="50" onkeypress="javascript:return ValidateMultiLangCharacter(this) && ValidateOnlyNumeric(this)"
                                                    CssClass="small w-133" meta:resourcekey="txtGenericNameResource1"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderGeneric" runat="server" TargetControlID="txtGenericName"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    OnClientItemSelected="SelectGeneric" MinimumPrefixLength="1" CompletionInterval="1"
                                                    FirstRowSelected="True" ServiceMethod="GetSearchGenericList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                    DelimiterCharacters="" Enabled="True">
                                                </ajc:AutoCompleteExtender>
                                                <input id="hdnGenericID" runat="server" type="hidden" value="0" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtproProduct" CssClass="small" onkeypress="return ValidateMultiLangChar(this);" runat="server" meta:resourcekey="txtproProductResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlproCategory" runat="server" CssClass="smaller">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlType" runat="server" CssClass="smaller">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:TextBox CssClass="small w-70" ID="txtproBatchNo" onkeypress="return ValidateMultiLangChar(this);" runat="server" meta:resourcekey="txtproBatchNoResource1"></asp:TextBox>
                                            </td>
                                            <td class="w-165">
                                                <asp:DropDownList ID="ddlproExpMonth" runat="server" CssClass="xsmaller" meta:resourcekey="ddlproExpMonthResource1">
                                                    <asp:ListItem Text="MMM" Value="-1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                    <asp:ListItem Text="Jan" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                    <asp:ListItem Text="Feb" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                    <asp:ListItem Text="Mar" Value="3" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                    <asp:ListItem Text="Apr" Value="4" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                    <asp:ListItem Text="May" Value="5" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                    <asp:ListItem Text="Jun" Value="6" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                    <asp:ListItem Text="Jul" Value="7" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                    <asp:ListItem Text="Aug" Value="8" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                                    <asp:ListItem Text="Sep" Value="9" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                                    <asp:ListItem Text="Oct" Value="10" meta:resourcekey="ListItemResource11"></asp:ListItem>
                                                    <asp:ListItem Text="Nov" Value="11" meta:resourcekey="ListItemResource12"></asp:ListItem>
                                                    <asp:ListItem Text="Dec" Value="12" meta:resourcekey="ListItemResource13"></asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:DropDownList ID="ddlproExpYear" runat="server" CssClass="xsmaller">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:TextBox onkeypress="return ValidateSpecialAndNumeric(this);" CssClass="mini" ID="txtproQuantity"
                                                    Text="0" runat="server" meta:resourcekey="txtproQuantityResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlproUnit" runat="server" CssClass="xsmaller" meta:resourcekey="ddlproUnitResource1">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:TextBox CssClass="mini" onkeypress="return ValidateSpecialAndNumeric(this);" ID="txtproUnitPrice"
                                                    onblur="calculateselling1();" Text="0" runat="server" meta:resourcekey="txtproUnitPriceResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox CssClass="mini" onkeypress="return ValidateSpecialAndNumeric(this);" ID="txtproSellingPrice"
                                                    Text="0" runat="server" meta:resourcekey="txtproSellingPriceResource1"></asp:TextBox>
                                            </td>
                                            <td runat="server" id="tdprotax">
                                                <asp:TextBox onkeypress="return ValidateSpecialAndNumeric(this);" ID="txtproTax" onblur="calculateselling1();"
                                                    CssClass="mini" Text="0" runat="server" meta:resourcekey="txtproTaxResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox CssClass="mini" onkeypress="return ValidateMultiLangChar(this);" ID="txtRakNo" runat="server" meta:resourcekey="txtRakNoResource1"></asp:TextBox>
                                            </td>
                                            <td runat="server" id="tdTxtRemarks">
                                                <asp:TextBox CssClass="small" ID="txtPrdtRemarks" runat="server" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtPrdtRemarksResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Button ID="btnAddNewProduct" Text="Add" runat="server" 
                                                    CssClass="btn" OnClick="btnAddNewProduct_Click"
                                                    OnClientClick="javascript:if(!CheckAddProduct()) return false;" meta:resourcekey="btnAddNewProductResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </div>
                        </td>
                    </tr>
                    
                </table>
            </div>
        </div>
        <table class="w-99p marginauto">
        <tr>
            <td id="tdExcel" runat="server" class="hide" colspan="8">
                <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../PlatForm/Images/ExcelImage.GIF"
                    ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                <asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" Font-Bold="True"
                    ForeColor="Black" ToolTip="Save As Excel" meta:resourcekey="lnkExportXLResource1"><u>Export To XL</u></asp:LinkButton>
                &nbsp;&nbsp;
            </td>
        </tr>
            <tr runat="server">
                <td colspan="8" class="a-center" runat="server">
                    <div id="DivResult" runat="server">
                        <asp:GridView ID="grdResult" EmptyDataText="No matching records found " AllowPaging="false" runat="server"
                            AutoGenerateColumns="False" OnRowDataBound="grdResult_RowDataBound" CssClass="responstable w-100p fixResponsTable"
                            EmptyDataRowStyle-CssClass="ui-state-info ui-corner-all a-center" OnRowCommand="grdResult_RowCommand"
                            OnPageIndexChanging="grdResult_PageIndexChanging" meta:resourcekey="grdResultResource1">
                            <PagerStyle CssClass="gridPager" />
                            <EmptyDataRowStyle CssClass="ui-state-info ui-corner-all a-center"></EmptyDataRowStyle>
                            <Columns>
                                <asp:BoundField HeaderText="Generic Name" DataField="GenericName" meta:resourcekey="BoundFieldResource1">
                                    <HeaderStyle HorizontalAlign="Left" CssClass="w-7p" />
                                    <ItemStyle CssClass="a-left" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Category Name" DataField="CategoryName" meta:resourcekey="BoundFieldResource2">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="w-12p" />
                                    <ItemStyle CssClass="a-left" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Product" DataField="ProductName" meta:resourcekey="BoundFieldResource3">
                                    <HeaderStyle CssClass="a-center" />
                                    <ItemStyle CssClass="a-left" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Product Code" meta:resourcekey="TemplateFieldResource1">
                                <HeaderStyle CssClass="w-7p" />
                                    <ItemTemplate>
                                        <asp:TextBox Text='<%# Eval("ProductCode") %>' ID="txtproductcode" onkeypress="return ValidateMultiLangChar(this);" Width="100px"
                                            runat="server" Enabled="False"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="BatchNo" meta:resourcekey="TemplateFieldResource2">
                                <HeaderStyle CssClass="w-5p" />
                                    <ItemTemplate>
                                        <asp:TextBox Text='<%# Eval("BatchNo") %>' Width="60px" ID="txtBatchNo" onkeypress="return ValidateMultiLangChar(this);" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EXP Date" meta:resourcekey="TemplateFieldResource3">
                                <HeaderStyle CssClass="w-10p" />
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlExpMonth" CssClass="ddlTheme" runat="server" Width="50px"
                                            meta:resourcekey="ddlExpMonthResource1">
                                            <asp:ListItem Text="MMM" Value="-1" meta:resourcekey="ListItemResource14"></asp:ListItem>
                                            <asp:ListItem Text="Jan" Value="1" meta:resourcekey="ListItemResource15"></asp:ListItem>
                                            <asp:ListItem Text="Feb" Value="2" meta:resourcekey="ListItemResource16"></asp:ListItem>
                                            <asp:ListItem Text="Mar" Value="3" meta:resourcekey="ListItemResource17"></asp:ListItem>
                                            <asp:ListItem Text="Apr" Value="4" meta:resourcekey="ListItemResource18"></asp:ListItem>
                                            <asp:ListItem Text="May" Value="5" meta:resourcekey="ListItemResource19"></asp:ListItem>
                                            <asp:ListItem Text="Jun" Value="6" meta:resourcekey="ListItemResource20"></asp:ListItem>
                                            <asp:ListItem Text="Jul" Value="7" meta:resourcekey="ListItemResource21"></asp:ListItem>
                                            <asp:ListItem Text="Aug" Value="8" meta:resourcekey="ListItemResource22"></asp:ListItem>
                                            <asp:ListItem Text="Sep" Value="9" meta:resourcekey="ListItemResource23"></asp:ListItem>
                                            <asp:ListItem Text="Oct" Value="10" meta:resourcekey="ListItemResource24"></asp:ListItem>
                                            <asp:ListItem Text="Nov" Value="11" meta:resourcekey="ListItemResource25"></asp:ListItem>
                                            <asp:ListItem Text="Dec" Value="12" meta:resourcekey="ListItemResource26"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddlExpYear" CssClass="ddlTheme" runat="server">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Inhand Qty" meta:resourcekey="TemplateFieldResource4">
                                <HeaderStyle CssClass="w-5p" />
                                    <ItemTemplate>
                                        <asp:TextBox Text='<%# Eval("InHandQuantity") %>' onkeypress="return ValidateSpecialAndNumeric(this);"
                                            onblur="return Checkqty(this)" CssClass="xsmaller a-right" ID="txtQuantity" runat="server"
                                            meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                        <asp:HiddenField ID="hdnHand" Value='<%# Eval("InHandQuantity") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Units(LSU)" meta:resourcekey="TemplateFieldResource5">
                                <HeaderStyle CssClass="w-4p" />
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlUnit" runat="server" CssClass="xsmaller" meta:resourcekey="ddlUnitResource1">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Cost Price" meta:resourcekey="TemplateFieldResource6">
                                <HeaderStyle CssClass="w-4p" />
                                    <ItemTemplate>
                                        <asp:TextBox Text='<%# Eval("UnitPrice") %>' CssClass="xsmaller a-right" onkeypress="return ValidateSpecialAndNumeric(this);"
                                            onblur="calculateselling(this);" ID="txtUnitPrice" runat="server" meta:resourcekey="txtUnitPriceResource1"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Selling Price" meta:resourcekey="TemplateFieldResource7">
                                <HeaderStyle CssClass="w-4p" />
                                    <ItemTemplate>
                                        <asp:TextBox Text='<%# Eval("Rate") %>' CssClass="xsmaller a-right" onkeypress="return ValidateSpecialAndNumeric(this);"
                                            ID="txtSellingPrice" runat="server" meta:resourcekey="txtSellingPriceResource1"></asp:TextBox>
                                        <asp:HiddenField ID="hdnRid" Value='<%# Eval("ID") %>' runat="server" />
                                        <asp:HiddenField ID="hdnCategoryId" Value='<%# Eval("CategoryId") %>' runat="server" />
                                        <asp:HiddenField ID="hdnProductId" Value='<%# Eval("ProductId") %>' runat="server" />
                                        <asp:HiddenField ID="hdnprovidedby" Value='<%# Eval("providedby") %>' runat="server" />
                                        <asp:HiddenField ID="hdnProductName" Value='<%# Eval("ProductName") %>' runat="server" />
                                        <asp:HiddenField ID="hdnDescription" Value='<%# Eval("Description") %>' runat="server" />
                                        <asp:HiddenField ID="hdnDamage" Value='<%# Eval("Damage") %>' runat="server" />
                                        <asp:HiddenField ID="hdnPdtRcvdDtlsID" Value='<%# Eval("ProductReceivedDetailsID") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tax%" meta:resourcekey="TemplateFieldResource8">
                                <HeaderStyle CssClass="w-4p" />
                                    <ItemTemplate>
                                        <asp:TextBox Text='<%# Eval("Tax") %>' onkeypress="return ValidateSpecialAndNumeric(this);"
                                            onblur="calculateselling(this);" CssClass="mini a-right" ID="txtTax" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rack No" meta:resourcekey="TemplateFieldResource9">
                                <HeaderStyle CssClass="w-4p" />
                                    <ItemTemplate>
                                        <asp:TextBox Text='<%# Eval("RakNo") %>' CssClass="mini" ID="txtRakNo" onkeypress="return ValidateMultiLangChar(this);" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks" meta:resourcekey="TemplateFieldResource10">
                                <HeaderStyle CssClass="w-7p" />
                                    <ItemTemplate>
                                        <asp:TextBox Text='<%# Eval("Remarks") %>' ID="txtPrdtRemarks" onkeypress="return ValidateMultiLangChar(this);" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Wrap="True" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource11">
                                <HeaderStyle CssClass="w-4p" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnSave" CommandName="INVSave" runat="server" CssClass="ui-icon ui-icon-disk b-none pointer pull-left marginR5"
                                            meta:resourcekey="btnSaveResource1" />
                                        <asp:LinkButton ID="btnAddMore" runat="server" CssClass="ui-icon ui-icon-plus b-none pointer pull-left"
                                            meta:resourcekey="btnAddMoreResource1" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="responstableHeader fixTableHeader" />
                        </asp:GridView>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="8" class="a-center">
                    <div id="dvRemarks" runat="server" visible="false">
                        <asp:Label ID="Label2" runat="server" Text="Remarks" meta:resourcekey="Label2Resource1"></asp:Label>
                        <asp:TextBox TextMode="MultiLine" ID="txtRemarks" onkeypress="return ValidateMultiLangChar(this);" runat="server" meta:resourcekey="txtRemarksResource1"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr runat="server">
                <td class="a-center" colspan="8" runat="server">
                    <div id="divAction" runat="server">
                        <asp:Button ID="btnUpdate" OnClientClick="btnDisplayNone();" Text="Update" Visible="False"
                            runat="server" CssClass="btn" 
                            OnClick="btnUpdate_Click" meta:resourcekey="btnUpdateResource1" />
                        &nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" Visible="False" CssClass="cancel-btn"
                            OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                    </div>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnUpdate" runat="server" />
        <%--</ContentTemplate>
                        </asp:UpdatePanel>--%>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnSellingPrieRuleList" runat="server" />
    <asp:HiddenField ID="hdnIsSellingPriceRuleApply" runat="server" Value="N" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    <asp:HiddenField ID="hdnHideTaxpercen" runat="server" />

    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
    <script type="text/javascript" src="../PlatForm/Scripts/tableFixedHeader.js"></script>
    <script type="text/javascript" language="javascript">

        var isPopUP = '<%=Request.QueryString["ispopup"] %>';

        if (isPopUP == "Y") {
            $('#menu').css("display", "hide");
            $('#header').css("display", "hide");
            $('#lnkHome').css("display", "hide");
            $('#showmenu').css("display", "hide");

        }
        $(document).ready(function () {
            $("#grdResult").tableHeadFixer({ height: 350, tableHead: false });
        });
		
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>
    
</body>
</html>
