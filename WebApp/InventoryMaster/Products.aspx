<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Products.aspx.cs" Inherits="Inventory_Products"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="~/InventoryCommon/Controls/ProductSearch.ascx" TagName="ProductSearch"
    TagPrefix="uc1" %>
<%@ Register Src="~/PlatFormControls/Audit_History.ascx" TagName="Audit_History"
    TagPrefix="adh1" %>
<%@ Register Src="~/InventoryMaster/Controls/AddGenericName.ascx" TagName="AddGenericName"
    TagPrefix="uc2" %>
<%@ Register Src="~/InventoryMaster/Controls/AddManufacturer.ascx" TagName="AddManufacturer"
    TagPrefix="uc7" %>
<%@ Register Src="~/InventoryMaster/Controls/AddProductAttributes.ascx" TagName="AddProductAttributes"
    TagPrefix="uc9" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <script src="../PlatForm/Scripts/MessageHandler.js" type="text/javascript"></script>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Products</title>
</head>
<body>
    <form id="prFrm" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="36000">
        </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />

        <script language="javascript" type="text/javascript">
            var errorMsg;
            var Information;
            var OkMsg;
            var CancelMsg;
            $(document).ready(function () {
                errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryMaster_Error');
                Information = SListForAppMsg.Get('InventoryMaster_Information') == null ? "Information" : SListForAppMsg.Get('InventoryMaster_Information');
                OkMsg = SListForAppMsg.Get('InventoryMaster_Ok') == null ? "Ok" : SListForAppMsg.Get('InventoryMaster_Ok');
                CancelMsg = SListForAppMsg.Get('InventoryMaster_Cancel') == null ? "Cancel" : SListForAppMsg.Get('InventoryMaster_Cancel');
                $.ionTabs("#tabs_1");
            });
        </script>

        <script language="javascript" type="text/javascript">
            function checkGreaterThanZero(id) {
                var packSize = $(id).val();
                if (packSize <= 0) {
                    alert("Please Enter packsize greater than zero");
                    $(id).val("1").focus();
                }
            }
            function DisplayTab(tabName) {
                $('#TabsMenu1 li').removeClass('active');
                var CurrentID = tabName.split('_')[1];
                $('div[id*=dvBody]').removeClass().addClass('hide');
                $('#li' + CurrentID).addClass('active');
                $('#dvBody_' + CurrentID).removeClass().addClass('show clearLeft');
                if (tabName == 'COM') {
                    //document.getElementById('tdCommercial').style.display = 'block';
                    $('#tdCommercial').removeClass().addClass('show');
                    $('#li1').addClass('active');
                    //document.getElementById('tdShip').style.display = 'none';
                    //document.getElementById('tdContact').style.display = 'none';
                    //document.getElementById('tdNotify').style.display = 'none';
                    //document.getElementById('tdReports').style.display = 'none';
                    //document.getElementById('tdTerms').style.display = 'none';
                    //document.getElementById('tdDespt').style.display = 'none';
                    //document.getElementById('tdCStatus').style.display = 'none';
                    //document.getElementById('tdAttribs').style.display = 'none';
                    $('#tdShip').removeClass().addClass('hide');
                    $('#tdContact').removeClass().addClass('hide');
                    $('#tdNotify').removeClass().addClass('hide');
                    $('#tdReports').removeClass().addClass('hide');
                    $('#tdTerms').removeClass().addClass('hide');
                    $('#tdDespt').removeClass().addClass('hide');
                    $('#tdCStatus').removeClass().addClass('hide');
                    $('#tdAttribs').removeClass().addClass('hide');
                }

            }
            //petchi

            function ShowAlertMsg(key) {

                var userMsg = SListForApplicationMessages.Get(key);
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    alert('Enter the attribute details');
                    return false;
                }
            }
            var userMsg;
            //Only numbers will allowed
            function isNumeric(e, Id) {
                var key; var isCtrl; var flag = 0;
                var txtVal = document.getElementById(Id).value.trim();
                var len = txtVal.split('.');
                if (len.length > 0) {
                    flag = 1;
                }
                if (window.event) {
                    key = window.event.keyCode;
                    if (window.event.shiftKey) {
                        isCtrl = false;
                    }
                    else {
                        if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                            isCtrl = true;
                        }
                        else {
                            isCtrl = false;
                        }
                    }
                } return isCtrl;
            }
            //Only numbers and only one dot value allowed for diecimal
            function isNumericss(e, Id) {

                var key; var isCtrl; var flag = 0;
                var txtVal = document.getElementById(Id).value.trim();
                var len = txtVal.split('.');
                if (len.length > 1) {
                    flag = 1;
                }
                if (window.event) {
                    key = window.event.keyCode;
                    if (window.event.shiftKey) {
                        isCtrl = false;
                    }
                    else {
                        if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                            isCtrl = true;
                        }
                        else {
                            isCtrl = false;
                        }
                    }
                } return isCtrl;
            }

            //only text allowed
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

                if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32) || (key == 46) || (key == 44) || (key == 45)) {
                    isCtrl = true;
                }

                return isCtrl;
            }


            var getHiddenValue = '';
            function checkDetails() {
                var getValue = '';
                document.getElementById('hdnvalue').value = '';

                $("#LocationPanel input.Txtboxverysmall").each(function () {
                    getValue += $(this).val() + '|';

                });

                document.getElementById('hdnvalue').value = getValue;

                if (document.getElementById('txtProductName').value.trim() == "") {
                    userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_01') == null ? "Provide product name" : SListForAppMsg.Get('InventoryMaster_Products_aspx_01');
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtProductName').focus();
                    return false;
                }


                if (document.getElementById('ddlType').value == "0") {
                    userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_02') == null ? "Select product type" : SListForAppMsg.Get('InventoryMaster_Products_aspx_02');
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('ddlType').focus();
                    return false;
                }



                if (document.getElementById('ddlCategory').value == "0") {
                    userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_03') == null ? "Select category name" : SListForAppMsg.Get('InventoryMaster_Products_aspx_03');
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('ddlCategory').focus();
                    return false;
                }

                //            if ($('#ddlOrdUnit').val() == "0") {
                //                userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_05') == null ? "Select Ordered Unit" : SListForAppMsg.Get('InventoryMaster_Products_aspx_05');
                //                ValidationWindow(userMsg, errorMsg);
                //                document.getElementById('ddlOrdUnit').focus();
                //                return false;
                //            }

                if (document.getElementById('bUnits').value == "0") {

                    userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_04') == null ? "Select Least Sellable Unit" : SListForAppMsg.Get('InventoryMaster_Products_aspx_04');
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('bUnits').focus();
                    return false;
                }


                //            if ($("#txtContainer").val() == "") {
                //                userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_21') == null ? "Please check conversion Qty empty" : SListForAppMsg.Get('InventoryMaster_Products_aspx_21');
                //                ValidationWindow(userMsg, errorMsg);
                //                document.getElementById('txtContainer').focus();
                //                return false;

                //            }

                //            if (Number($("#txtContainer").val()) == 0) {

                //                userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_22') == null ? "Please provide conversion qty is greater than zero" : SListForAppMsg.Get('InventoryMaster_Products_aspx_22');
                //                ValidationWindow(userMsg, errorMsg);
                //                document.getElementById('txtContainer').focus();
                //                return false;

                //            }


                if ($('#hdnOrdUnitConfig').val() == 'Y') {

                    //                if ($('#ddlOrdUnit').val() == "0") {
                    //                    userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_05') == null ? "Select Ordered Unit" : SListForAppMsg.Get('InventoryMaster_Products_aspx_05');
                    //                    ValidationWindow(userMsg, errorMsg);
                    //                    document.getElementById('ddlOrdUnit').focus();
                    //                    return false;
                    //                }

                    if ($('#txtPackSize').val() == "" && $('#hdnPackSize').val() == "Y") {
                        userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_06') == null ? "Provide Pack Size" : SListForAppMsg.Get('InventoryMaster_Products_aspx_06');
                        ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtPackSize').focus();
                        return false;
                    }
                }
                if ($('#ddlOrdUnit').val() != "0") {
                    if ($('#txtPackSize').val() == "" && $('#hdnPackSize').val() == "Y") {
                        userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_06') == null ? "Provide Pack Size" : SListForAppMsg.Get('InventoryMaster_Products_aspx_06');
                        ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtPackSize').focus();
                        return false;
                    }
                }
                if ($('#hdnPackSize').val() == "Y" && parseInt($('#txtPackSize').val()) > 1 && $('#ddlOrdUnit').val() == $('#bUnits').val()) {
                    userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_20') == null ? "Both Ordered Unit/Least Sellable Unit are same." : SListForAppMsg.Get('InventoryMaster_Products_aspx_20');
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtPackSize').focus();
                    return false;
                }
                ////////////////////////Nation Wide Product Master Changes
                var ctlDp = document.getElementById('ddlType');
                var DDLTYPETEXT = ctlDp.options[ctlDp.selectedIndex].innerHTML;

                //if (document.getElementById('hdnProductMand').value == "Y" && document.getElementById('TxtTax').value == 0 && DDLTYPETEXT == "Drugs") {
                //    userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_07') == null ? "Provide VAT(%)" : SListForAppMsg.Get('InventoryMaster_Products_aspx_07');
                //    ValidationWindow(userMsg, errorMsg);
                //    document.getElementById('TxtTax').value = "";
                //    document.getElementById('TxtTax').focus();
                //    return false;
                //}
                if ($('#ddlTaxtype').val()=='0') {
                    userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_077') == null ? "Provide Tax(%)" : SListForAppMsg.Get('InventoryMaster_Products_aspx_077');
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('TxtTax').value = "";
                    $('#ddlTaxtype').focus();
                    return false;
                }
                //                 if(document.getElementById('hdnProductMand').value =="Y" &&  document.getElementById('chkExpDate').checked == false && DDLTYPETEXT =="Drugs")
                //                {
                //                  alert('Provide Product Expiry Date');
                //                  document.getElementById('chkExpDate').focus();
                //                  return false ;
                //                }  
                //                 if(document.getElementById('hdnProductMand').value =="Y" &&  document.getElementById('chkBatchNo').checked == false && DDLTYPETEXT =="Drugs")
                //                {
                //                  alert('Provide Product Batch No');
                //                  document.getElementById('chkBatchNo').focus();
                //                  return false ;
                //                }   
                ///////////////////////   

                if (document.getElementById('hdnLocationList').value == "") {

                    if (document.getElementById('txtLocationName').value.trim() == "") {
                        userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_08') == null ? "Provide the LocationName" : SListForAppMsg.Get('InventoryMaster_Products_aspx_08');
                        ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtLocationName').focus();
                        return false;
                    }

                    if (document.getElementById('txtReOrderLevel').value == 0) {
                        userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_09') == null ? "Provide ReOrder Level quantity" : SListForAppMsg.Get('InventoryMaster_Products_aspx_09');
                        ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtReOrderLevel').value = "";
                        document.getElementById('txtReOrderLevel').focus();
                        return false;
                    }
                    else {
                        userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_10') == null ? "Add the location and then save the Details" : SListForAppMsg.Get('InventoryMaster_Products_aspx_10');
                        ValidationWindow(userMsg, errorMsg);
                        return false;
                    }
                }
                GetProductsAttributes();


                var Svalue = $.trim($("#bUnits option:selected").text());
                var arrF = $.grep(lstProducUOMList, function (n, i) {
                    return n.UOMCode == Svalue;
                });

                if (arrF.length == 0) {
                    $("#ddlOrdUnit option:contains(" + Svalue + ")").attr('selected', true);

                    var objProduct = new Object();
                    objProduct.ProductUOMID = 0;
                    objProduct.ProductID = 0;
                    objProduct.UOMCode = $("#ddlOrdUnit option:selected").text();
                    objProduct.UOMID = $("#ddlOrdUnit option:selected").val();
                    objProduct.ConvesionQty = 1;
                    //objProduct.LSU = $("#bUnits option:selected").val();
                    objProduct.Action = "M";
                    objProduct.IsBaseunit = "true";
                    lstProducUOMList.push(objProduct);

                }



                $('#hdnProductUomList').val(JSON.stringify(lstProducUOMList));
                lstProducUOMList = [];

            }

            function pageLoad() {
                document.getElementById('txtGenericName').focus();
            }


            function FnClear() {
                document.getElementById('ucProductAttributes_txtAddPurchasePrice').value = 0;
                document.getElementById('ucProductAttributes_txtDiscount').value = 0;
                document.getElementById('ucProductAttributes_txtInverseQuantity').value = 0;
                document.getElementById('ucProductAttributes_ddlSupplierName').value = 0;
                document.getElementById('txtMake').value = '';
                document.getElementById('txtProductCode').value = '';
                document.getElementById('TxtTax').value = 0;
                $("#ddlTaxtype").val("0");//Vijayaraja
                document.getElementById('hdnGetTax').value = 0;
                document.getElementById('hdnId').value = 0;
                document.getElementById('txtProductName').value = '';
                document.getElementById('ddlCategory').value = 0;
                document.getElementById('bUnits').value = 0;
                document.getElementById('txtDescription').value = '';
                document.getElementById('txtMfgName').value = '';
                document.getElementById('txtMfgCode').value = '';
                //document.getElementById('chkIsDeleted').checked = false;
                document.getElementById('btnFinish').value = 'Save';
                document.getElementById('lblmsg').innerText = '';
                document.getElementById('hdnStatus').value = 'Save';
                document.getElementById('ddlType').value = 0;
                document.getElementById('txtProductModel').value = '';
                document.getElementById('txtLTofProduct').value = '';
                document.getElementById('txtGenericName').value = '';
                document.getElementById('hdnGenericID').value = '0';
                //document.getElementById('tdTransblock').style.display = 'none';
                //document.getElementById('tddelete').style.display = 'none';
                document.getElementById('txtHsnCode').value = '';  //Vijayaraja
                $('#tdTransblock').removeClass().addClass('hide');
                $('#tddelete').removeClass().addClass('hide');
                document.getElementById('hdnLocationList').value = '';
                document.getElementById('hdnLocationName').value = '';
                $('#txtPackSize').val('');
                $('#ddlOrdUnit').val('0');
                //document.getElementById('tblLocationlist').style.display = 'none';
                while (count = document.getElementById('tblLocationlist').rows.length) {

                    for (var j = 0; j < document.getElementById('tblLocationlist').rows.length; j++) {
                        document.getElementById('tblLocationlist').deleteRow(j);
                    }
                }


                var len = document.forms[0].elements.length;
                for (var i = 0; i < len; i++) {
                    if (document.forms[0].elements[i].type == "checkbox") {
                        document.forms[0].elements[i].checked = false;
                    }
                }

                $('#hdnProductUomList').val('');
                lstProducUOMList = [];

            }
            function checkCount() {
                if (document.getElementById('txtUsageCount').value == '') {
                    document.getElementById('txtUsageCount').value = '0';
                }
            }
            var CSSDItemCheckResponse = false;
            var IsOtherProduct = false;

            function ProQuantityCheck(ProductID, Quantity) {
                var Information = SListForAppMsg.Get('InventoryMaster_Information') == null ? "Information" : SListForAppMsg.Get('InventoryMaster_Information');
                var OkMsg = SListForAppMsg.Get('InventoryMaster_Ok') == null ? "Ok" : SListForAppMsg.Get('InventoryMaster_Ok');
                var CancelMsg = SListForAppMsg.Get('InventoryMaster_Cancel') == null ? "Cancel" : SListForAppMsg.Get('InventoryMaster_Cancel');

                CSSDItemCheck(ProductID, 'PRODUCTS');

                if (!CSSDItemCheckResponse)
                    return false;

                if (IsOtherProduct) {
                    IsOtherProduct = false;
                    var PQuantity = Quantity;
                    if (PQuantity > 0) {
                        userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_11') == null ? "This Product Cannot be De-Activated" : SListForAppMsg.Get('InventoryMaster_Products_aspx_11');
                        ValidationWindow(userMsg, errorMsg);
                        FnClear();
                        return false;
                    }
                    else {
                        userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_12') == null ? "This Product will be De-Activated.Do you want to continue?" : SListForAppMsg.Get('InventoryMaster_Products_aspx_12');
                        var res = ConfirmWindow(userMsg, Information, OkMsg, CancelMsg);
                        if (res == true) {
                            return true;
                        }
                        else {
                            return false;
                        }
                    }
                }
                return true;
            }

            function CSSDItemCheck(ProductID, pType) {
                var param = { ItemID: ProductID, Type: pType };
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "../InventoryCommon/Webservice/InventoryWebService.asmx/IsActiveCSSDProduct",
                    data: JSON.stringify(param),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var items = data.d;
                        var userMsg;
                        IsOtherProduct = false;
                        if (items.length > 0) {
                            var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryMaster_Error');
                            CSSDItemCheckResponse = false;
                            if (items.length == 1 && items[0].Type.toUpperCase() == 'SET') {
                                userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_20') == null ? "Item is part of Item sets. \nItem cannot be deleted as it is part of {0} Item sets." : SListForAppMsg.Get('InventoryMaster_Products_aspx_20');
                                userMsg = userMsg.replace('{0}', items[0].Name);
                            }
                            else if (items.length == 1 && items[0].Type.toUpperCase() == 'KIT') {
                                userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_21') == null ? "Item is part of kits. \nItem cannot be deleted as it is part of {0} kits." : SListForAppMsg.Get('InventoryMaster_Products_aspx_21');
                                userMsg = userMsg.replace('{0}', items[0].Name);
                            }
                            else if (items.length == 2) {
                                userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_22') == null ? "Item is part of Item sets and kits. \nItem cannot be deleted as Item is part of {0} Item sets and {1} kits" : SListForAppMsg.Get('InventoryMaster_Products_aspx_22');
                                userMsg = userMsg.replace('{0}', items[0].Name);
                                userMsg = userMsg.replace('{1}', items[1].Name);
                            }
                            else if (items.length == 1 && items[0].Type.toUpperCase() == 'OTHER') {
                                IsOtherProduct = true;
                                CSSDItemCheckResponse = true;
                            }
                            else if (items.length == 1 && items[0].Type == 'ProductUOM') {
                                IsOtherProduct = true;
                                CSSDItemCheckResponse = true;
                                ProdctUOMReturnStatus = $.trim(items[0].Name);
                            }

                            if (!IsOtherProduct)
                                ValidationWindow(userMsg, errorMsg);
                        }
                        else {
                            userMsg = SListForAppMsg.Get('CSSD_ManageItems_Warning3') == null ? "This Item will be deleted. Are you sure you want to continue?" : SListForAppMsg.Get('CSSD_ManageItems_Warning3');
                            var Information = SListForAppMsg.Get('CSSD_Information') == null ? "Information" : SListForAppMsg.Get('CSSD_Information');
                            var OkMsg = SListForAppMsg.Get('CSSD_Ok') == null ? "Ok" : SListForAppMsg.Get('CSSD_Ok');
                            var CancelMsg = SListForAppMsg.Get('CSSD_Cancel') == null ? "Cancel" : SListForAppMsg.Get('CSSD_Cancel');
                            var res = ConfirmWindow(userMsg, Information, OkMsg, CancelMsg);
                            if (res == true) {
                                CSSDItemCheckResponse = true;
                            }
                            else {
                                CSSDItemCheckResponse = false;
                            }
                        }
                    }
                });
            }


            function checkLSU() {

                var obj = document.getElementById('hdnInHandQty').value;
            }
            /*Sathish*/
            function ddlCategoryOnSelectedIndexChange() {
                try {
                    var ddlCategory = $("#ddlCategory option:selected").text();
                    var ddlCategoryVal = $("#ddlCategory option:selected").val();
                    if ($("#hdnCategoryClear").val() != 0) {
                        if ($("#hdnCategoryClear").val() != ddlCategoryVal) {

                            CategoryClear();
                            GetService();
                        }
                        else {
                            GetService();
                        }
                    }
                    else if (ddlCategory.toLowerCase() == "frames" || ddlCategory.toLowerCase() == "lens" || ddlCategory.toLowerCase() == "sunglass" || ddlCategory.toLowerCase() == "accessories") {
                        GetService();
                    }
                    else if ($("#ddlCategory").val() == 0) {
                        $('#Bck-black').hide();
                        $('#Framediv').hide();
                    }
                }
                catch (e) {
                    alert(e);
                }
            }

            function ddlTypeOnSelectedIndexChange() {
                var ddlType = $("#ddlType option:selected").text().toUpperCase();

                //            if (document.getElementById('ddlType').value == "5") {

                //                $('#trAsset1').removeClass().addClass('displaytr');
                //                document.getElementById('txtProductModel').value = '';
                //                document.getElementById('txtLTofProduct').value = '';
                //            }
                //            else {

                //                $('#trAsset1').removeClass().addClass('hide');
                //                document.getElementById('txtProductModel').value = '';
                //                document.getElementById('txtLTofProduct').value = '';
                //            }

                GetCategory($("#ddlType").val(), '-1');
                GetLSU($("#ddlType").val());
            }
            /*Sathish-If Type is "Optical", then LSU to contain only "Pieces" should be made default.-Vasan*/
            function GetLSU(TypId) {
                try {
                    var Count = OrderedUnitList.length;
                    var ProCat = ProductCategories.length;
                    $("#bUnits > option").remove();
                    var DefaultSelect = '';
                    DefaultSelect += '<option value="' + 0 + '">' + 'Select' + '</option>';
                    $("#bUnits").append(DefaultSelect);
                    var flag = false;
                    var option = '';
                    for (var i = 0; i < Count; i++) {
                        var _StrLoadUnits = OrderedUnitList;
                        var _ProductCategories = ProductCategories;
                        var typeid = _StrLoadUnits[i].TypeId;
                        if (typeid != 0) {
                            if (typeid == TypId) {
                                option += '<option value="' + _StrLoadUnits[i].UOMCode + '">' + _StrLoadUnits[i].UOMDescription + '</option>';
                            }
                            else {
                                flag = true;
                            }
                        }
                        else {
                            flag = true;
                        }
                    }

                    $('#bUnits').append(option);
                    if (flag == true) {
                        var Count = $("#bUnits option").length;
                        if (Count <= 1) {
                            var _StrLoadUnits = OrderedUnitList;
                            var _Count = _StrLoadUnits.length;
                            var option = '';
                            for (var i = 0; i < _Count; i++) {
                                option += '<option value="' + _StrLoadUnits[i].UOMCode + '">' + _StrLoadUnits[i].UOMCode + '</option>';
                            }
                            $('#bUnits').append(option);

                        }
                        if ($("#ddlType option:selected").text() == "Optical") {
                            $("#bUnits")[0].selectedIndex = 0;
                        }
                    }

                }
                catch (Error) {
                    alert(Error);
                }
            }
            /*Sathish*/
            function CategoryPopUpValue() {
                if ($("#ddlCategory").val() != 0) {
                    GetService('True');
                } else {
                    alert('Please select Any Product Category.!');
                    return false;
                }
            }
            function CategoryPopUp() {

                var ddlCategory = $("#ddlCategory option:selected").text();
                try {
                    if ($("#ddlCategory").val() != 0) {
                        if (ddlCategory == "Frames" || ddlCategory == "Lens" || ddlCategory == "Sunglass" || ddlCategory == "Accessories") {

                            //$("#hdnAttributes").val(XMLdata);

                            var XMLdata = $('#hdnAttributes').val();
                            xmlDoc = $.parseXML(XMLdata),
                            $xml = $(xmlDoc),
                            $title = $xml.find("AttributeKey");

                            $xml.find("Attributes").each(function () {
                                // $xml.find("AttributeValue").each(function() {
                                if (ddlCategory == "Accessories") {
                                    Edit_AccessoriesSetUp($(this).find('AttributeKey').text(), $(this).find('AttributeValue').text());
                                }
                                else if (ddlCategory == "Frames") {
                                    Edit_FrameSetUp($(this).find('AttributeKey').text(), $(this).find('AttributeValue').text());
                                }
                                else if (ddlCategory == "Lens") {
                                    Edit_LensSetUp($(this).find('AttributeKey').text(), $(this).find('AttributeValue').text());
                                }
                                else if (ddlCategory == "Sunglass") {
                                    Edit_SunGlassSetUp($(this).find('AttributeKey').text(), $(this).find('AttributeValue').text());
                                }
                            });
                            return false;
                        }
                    }
                    else {
                        alert('Please select Any Product Category.!');
                        return false;
                    }
                }
                catch (Error) {
                    alert(Error);
                }
            }
            /*Sathish*/
            function GetCategory(typid, categoryid) {
                try {
                    var Count = ProductCategories.length;
                    var categoryid = Number(categoryid);
                    $("#ddlCategory > option").remove();
                    var DefaultSelect = '';
                    DefaultSelect += '<option value="' + 0 + '">' + 'Select' + '</option>';
                    $("#ddlCategory").append(DefaultSelect);
                    var flag = false;
                    var option = '';
                    for (var i = 0; i < Count; i++) {
                        var _ProductCategories = ProductCategories;
                        var typeid = _ProductCategories[i].TypeId;
                        if (typeid != 0) {
                            if (typeid == typid) {
                                option += '<option value="' + _ProductCategories[i].CategoryID + '">' + _ProductCategories[i].CategoryName + '</option>';
                            }
                            else {
                                flag = true;
                            }
                        }
                        else {
                            flag = true;
                        }
                    }
                    $('#ddlCategory').append(option);
                    if (flag == true) {
                        var Count = $("#ddlCategory option").length;
                        if (Count <= 1) {
                            var _ProductCategories = ProductCategories;
                            var _Count = _ProductCategories.length;
                            var option = '';
                            for (var i = 0; i < _Count; i++) {
                                option += '<option value="' + _ProductCategories[i].CategoryID + '">' + _ProductCategories[i].CategoryName + '</option>';
                            }
                            $('#ddlCategory').append(option);
                        }
                    }
                    if (categoryid >= 0) {

                        $("#ddlCategory").val(categoryid);
                        GetService()
                        //alert($("#ddlCategory").val());
                    }
                }
                catch (Error) {
                    alert(Error);
                }
            }

            function sample(ele, chk) {
                if ($(chk).attr('checked')) {
                    $('#' + ele).show();
                }
                else {
                    $('#' + ele).val(0);
                    $('#' + ele).hide();
                }
            }
            function LocationBlock(ele, le, idd) {

                var Updateid = idd.substring(0, (idd.length - 1));

                var value1 = le.substring(0, (le.length - 1));
                var lid = ele.substring(0, (ele.length - 1));
                var Ids = lid.split('|');
                var locationValue = value1.split('|');
                for (var i = 0; i < Ids.length; i++) {
                    var va = locationValue[i];
                    $('#' + Ids[i]).val(va);
                    $('#' + Ids[i]).show();

                }

            }

            function LocationNone(ele) {
                console.log(ele);
                $('#' + ele).hide();
            }

            function SelectGeneric(source, eventArgs) {
                var PColval = eventArgs.get_value().split('~');
                document.getElementById('hdnGenericID').value = PColval[0];
                //            document.getElementById('txtGenericName').value = PColval[1];

            }
            function SelectManufacturer(source, eventArgs) {
                var SelectedValue = JSON.parse(eventArgs._value);
                $('#txtMfgCode').val(SelectedValue.MfgCode);
                $('#txtMfgName').val(SelectedValue.MfgName);
            }
            function onMfgKeyDown() {
                if ($('#hdnIsMfgFeeText').val() != "Y") {
                    $('#txtMfgCode').val("");
                    $('#txtMfgName').val("");
                }
            }
            function SelectLocation(source, eventArgs) {
                var PColval = eventArgs.get_value().split('~');
                document.getElementById('hdnLocationID').value = PColval[0];
                document.getElementById('hdnLocationName').value = PColval[1];
                //            document.getElementById('txtLocationName').value = PColval[1];

            }
            function SelectIndentLocation(source, eventArgs) {
                var PColval = eventArgs.get_value().split('~');
                document.getElementById('hdnIndentLocationID').value = PColval[0];
                return false;

            }
            function SelectOrganization(source, eventArgs) {
                var PColval = eventArgs.get_value().split('~');
                document.getElementById('hdnOrgId').value = PColval[0];

            }


            function checkLocation() {

                if (document.getElementById('hdnOrgId').value == "0" || document.getElementById('txtOrgName').value.trim() == "") {
                    var userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_13') == null ? "Provide the Organization" : SListForAppMsg.Get('InventoryMaster_Products_aspx_13');
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtOrgName').focus();
                    return false;
                }
                if (document.getElementById('txtLocationName').value.trim() == "") {
                    userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_08') == null ? "Provide the LocationName" : SListForAppMsg.Get('InventoryMaster_Products_aspx_08');
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtLocationName').focus();
                    return false;
                }

                if ($.trim($("#txtDefaultIntendLocation").val()) != "") {

                    if ($.trim($("#hdnIndentLocationID").val()) == $.trim($("#hdnLocationID").val())) {

                        userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_20') == null ? "Location and Intendlocation are same. Provide different intend Location " : SListForAppMsg.Get('InventoryMaster_Products_aspx_20');
                        ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtDefaultIntendLocation').focus();
                        return false;

                    }
                }

                if (document.getElementById('btnAddLocation').value != 'Update') {
                    var x = document.getElementById('hdnLocationList').value.split("^");
                    var pLocID = document.getElementById('hdnLocationID').value;
                    var pLocationName = document.getElementById('txtLocationName').value;
                    var y; var i;
                    for (i = 0; i < x.length; i++) {
                        if (x[i] != "") {
                            y = x[i].split('~');
                            if (y[0] == pLocID) {
                                var userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_14') == null ? "This Location already exist" : SListForAppMsg.Get('InventoryMaster_Products_aspx_14');
                                ValidationWindow(userMsg, errorMsg);
                                document.getElementById('txtLocationName').value = '';
                                document.getElementById('txtLocationName').focus();
                                return false;
                            }
                        }
                    }
                }
                BindLocationList();
                return false;
            }


            function BindLocationList() {
                var Update = SListForAppDisplay.Get('InventoryMaster_Products_aspx_01') == null ? "Update" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_01');
                if (document.getElementById('btnAddLocation').value == Update) {
                    DeleterowsLoc();
                }
                else {
                    var POrgId = document.getElementById('hdnOrgId').value;
                    var pOrgName = document.getElementById('txtOrgName').value;
                    var pLocationID = document.getElementById('hdnLocationID').value;
                    var pLocationName = document.getElementById('txtLocationName').value;
                    var pReOrderLevelQuantity = document.getElementById('txtReOrderLevel').value;
                    var pMaxQTY = document.getElementById('txtMaxQTY').value;

                    var PIndDefaultLocationName = $("#txtDefaultIntendLocation").val();
                    var PIndDefaultLocationID = $("#hdnIndentLocationID").val();


                    var PStockTakingFrequency = $("label[for='" + $("#rblStockTakingFrequency").find(":checked").attr('id') + "']").text();
                    //$("#rblSTF").find(":checked").val();
                    document.getElementById('hdnLocationList').value += pLocationID + "~" + pLocationName + "~" + pReOrderLevelQuantity + "~" + POrgId + "~" + pOrgName + "~" + pMaxQTY + "~" + PStockTakingFrequency + "~" + PIndDefaultLocationName + "~" + PIndDefaultLocationID + "^";
                    tableLocationList();

                }
                var Add = SListForAppDisplay.Get('InventoryMaster_Products_aspx_02') == null ? "Add" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_02');
                document.getElementById('btnAddLocation').value = Add;
                if ($('#btnAddLocation').text() == Update) {
                    $('#btnAddLocation').text(Add);
                }
                document.getElementById('txtLocationName').value = '';
                document.getElementById('txtReOrderLevel').value = '0';
                document.getElementById('txtMaxQTY').value = '0';
                document.getElementById('txtLocationName').focus();
                $("#txtDefaultIntendLocation").val('');
                $("#hdnIndentLocationID").val('');

            }

            function tableLocationList() {
                var SNo = SListForAppDisplay.Get('InventoryMaster_Products_aspx_03') == null ? "S.No" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_03');
                var OrganizationName = SListForAppDisplay.Get('InventoryMaster_Products_aspx_04') == null ? "Organization Name" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_04');
                var LocationName = SListForAppDisplay.Get('InventoryMaster_Products_aspx_05') == null ? "Location Name" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_05');
                var ReOrderLevelQuantity = SListForAppDisplay.Get('InventoryMaster_Products_aspx_06') == null ? "Re-Order Level Quantity" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_06');
                var Action = SListForAppDisplay.Get('InventoryMaster_Products_aspx_07') == null ? "Action" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_07');
                var Edit = SListForAppDisplay.Get('InventoryMaster_Products_aspx_08') == null ? "Edit" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_08');
                var Delete = SListForAppDisplay.Get('InventoryMaster_Products_aspx_09') == null ? "Delete" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_09');
                var MaxQTY = SListForAppDisplay.Get('InventoryMaster_Products_aspx_26') == null ? "Maximum Quantity" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_26');
                var IndDefaultLocation = SListForAppDisplay.Get('InventoryMaster_Products_aspx_27') == null ? "DefaultIntendLocation" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_27');

                var StockTakingFrequency = SListForAppDisplay.Get('InventoryMaster_Products_aspx_28') == null ? "StockTakingFrequency" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_28');

                while (count = document.getElementById('tblLocationlist').rows.length) {

                    for (var j = 0; j < document.getElementById('tblLocationlist').rows.length; j++) {
                        document.getElementById('tblLocationlist').deleteRow(j);
                    }
                }

                var Headrow = document.getElementById('tblLocationlist').insertRow(0);
                Headrow.id = "HeadID";
                Headrow.style.backgroundColor = "#2c88b1";
                Headrow.style.fontWeight = "bold";
                //Headrow.addClass("bold");
                Headrow.style.color = "#FFFFFF";
                Headrow.className = "responstableHeader  w-100p"
                var cell1 = Headrow.insertCell(0);
                var cell2 = Headrow.insertCell(1);
                var cell3 = Headrow.insertCell(2);
                var cell4 = Headrow.insertCell(3);
                var cell5 = Headrow.insertCell(4);
                var cell6 = Headrow.insertCell(5);
                var cell7 = Headrow.insertCell(6);
                var cell8 = Headrow.insertCell(7);

                cell1.innerHTML = SNo;
                cell2.innerHTML = OrganizationName;
                cell3.innerHTML = LocationName;
                cell4.innerHTML = ReOrderLevelQuantity;
                cell5.innerHTML = MaxQTY;
                cell6.innerHTML = StockTakingFrequency;
                cell7.innerHTML = IndDefaultLocation;
                cell8.innerHTML = Action;

                var x = document.getElementById('hdnLocationList').value.split("^");
                var pCount = x.length;
                pCount = pCount - 1;

                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        y = x[i].split('~');

                        var row = document.getElementById('tblLocationlist').insertRow(1);
                        row.style.height = "13px";
                        //row.addClass("h-13");
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        var cell5 = row.insertCell(4);
                        var cell6 = row.insertCell(5);
                        var cell7 = row.insertCell(6);
                        var cell8 = row.insertCell(7);


                        cell1.innerHTML = pCount;
                        cell2.innerHTML = y[4];
                        cell3.innerHTML = y[1];
                        cell4.innerHTML = y[2];
                        cell5.innerHTML = y[5];
                        cell6.innerHTML = y[6];
                        cell7.innerHTML = y[7];

                        var pAction = "";

                        pAction = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "' onclick='btnLocEdit_OnClick(name);' value = '" + Edit + "' type='button' class='ui-icon ui-icon-pencil b-none pointer pull-left'  />" +
                            "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "' onclick='btnLocDelete(name);' value = '" + Delete + "' type='button' class='ui-icon ui-icon-trash pointer marginL2 pull-left'  />"
                        cell8.innerHTML = pAction;

                    }
                    pCount = pCount - 1;
                }
                document.getElementById('hdnScheduledrugValue').value = "";
            }

            function btnLocEdit_OnClick(sEditedData) {
                var Update = SListForAppDisplay.Get('InventoryMaster_Products_aspx_01') == null ? "Update" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_01');
                $('#btnAddLocation').text(Update);
                var y = sEditedData.split('~');
                document.getElementById('hdnOrgId').value = y[3];
                document.getElementById('txtOrgName').value = y[4];
                document.getElementById('hdnLocationID').value = y[0];
                document.getElementById('txtLocationName').value = y[1];
                document.getElementById('hdnLocationName').value = y[1];
                document.getElementById('txtReOrderLevel').value = y[2];
                document.getElementById('txtMaxQTY').value = y[5];
                document.getElementById('hdnLocRowEdit').value = sEditedData;
                document.getElementById('btnAddLocation').value = 'Update';
                $("#txtDefaultIntendLocation").val(y[7]);
                $("#hdnIndentLocationID").val(y[8]);

                var radio = $("[id*=rblStockTakingFrequency] label:contains('" + y[6] + "')").closest("td").find("input");
                radio.prop("checked", "checked");
            }

            function btnLocDelete(sEditedData) {

                var i;
                var x = document.getElementById('hdnLocationList').value.split("^");
                document.getElementById('hdnLocationList').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != sEditedData) {
                            document.getElementById('hdnLocationList').value += x[i] + "^";
                        }
                    }
                }
                tableLocationList();
            }


            function DeleterowsLoc() {

                var RowEdit = document.getElementById('hdnLocRowEdit').value;
                var x = document.getElementById('hdnLocationList').value.split("^");
                if (RowEdit != "") {
                    var POrgId = document.getElementById('hdnOrgId').value;
                    var pOrgName = document.getElementById('txtOrgName').value;
                    var pLocationId = document.getElementById('hdnLocationID').value;
                    var pLocationName = document.getElementById('hdnLocationName').value;
                    var pReOrderLevelQTY = document.getElementById('txtReOrderLevel').value;
                    var pMaxQTY = document.getElementById('txtMaxQTY').value;

                    var PIndDefaultLocationName = $("#txtDefaultIntendLocation").val();
                    var PIndDefaultLocationID = $("#hdnIndentLocationID").val();

                    var PStockTakingFrequency = $("label[for='" + $("#rblStockTakingFrequency").find(":checked").attr('id') + "']").text();

                    document.getElementById('hdnLocationList').value = pLocationId + "~" + pLocationName + "~" + pReOrderLevelQTY + "~" + POrgId + "~" + pOrgName + "~" + pMaxQTY + "~" + PStockTakingFrequency + "~" + PIndDefaultLocationName + "~" + PIndDefaultLocationID + "^";


                    for (i = 0; i < x.length; i++) {
                        if (x[i] != "") {
                            if (x[i] != RowEdit) {
                                document.getElementById('hdnLocationList').value += x[i] + "^";
                            }
                        }
                    }
                    document.getElementById('hdnLocRowEdit').value = "";
                    tableLocationList();

                    document.getElementById('txtLocationName').readOnly = false;

                }
            }

            function setcontextKey() {
                var chk = document.getElementById('ChkIsConsign');
                if (chk.checked == true) {
                    $find("AutoCompleteExtenderLocation").set_contextKey("Y");
                }
                else
                    $find("AutoCompleteExtenderLocation").set_contextKey("N");
            }

        </script>

        <script type="text/javascript">
            var ProductCategories = JSON.parse('<%=StrProductCategories %> ');
            var OrderedUnitList = JSON.parse('<%=StrLoadOrderedUnit %>');
        </script>

        <script type="text/javascript" language="javascript">
            //sathish--validating splchar--start
            function ValidateSplChar(txt) {
                txt.value = txt.value.replace(/[^a-zA-Z 0-9\n\r]+/g, '');
            }
            //sathish--validating splchar--end
            var XMLdata = "";
            var ArrayData = new Array();
            var ProductID;

            function ChangeTxtBoxWidthDynamic() {
                var completionList = $find("AutoOrgName").get_completionList().childNodes;
                for (var i = 0; i < completionList.length; i++) {
                    var temp = completionList[i].innerHTML;
                    if ($('#AutoOrgName_completionListElem').length > 0 && temp.length != '') {
                        if (temp.length > 0 && temp.length < 10) {
                            $('#AutoOrgName_completionListElem').css('width', '150px');
                            $("#AutoOrgName_completionListElem li").each(function (n) {
                                $(this).css('width', '200px');
                            });
                        }
                        else if (temp.length > 10 && temp.length < 25) {
                            $('#AutoOrgName_completionListElem').css('width', '200px');
                            $("#AutoOrgName_completionListElem li").each(function (n) {
                                $(this).css('width', '200px');
                            });
                        }
                        else if (temp.length > 25 && temp.length < 30) {
                            $('#AutoOrgName_completionListElem').css('width', '250px');
                            $("#AutoOrgName_completionListElem li").each(function (n) {
                                $(this).css('width', '250px');
                            });
                        }
                        else if (temp.length > 30 && temp.length < 35) {
                            $('#AutoOrgName_completionListElem').css('width', '300px');
                            $("#AutoOrgName_completionListElem li").each(function (n) {
                                $(this).css('width', '300px');
                            });
                        }
                        else if (temp.length > 35 && temp.length < 40) {
                            $('#AutoOrgName_completionListElem').css('width', '320px');
                            $("#AutoOrgName_completionListElem li").each(function (n) {
                                $(this).css('width', '320px');
                            });
                        }
                        else if (temp.length > 40 && temp.length < 45) {
                            $('#AutoOrgName_completionListElem').css('width', '340px');
                            $("#AutoOrgName_completionListElem li").each(function (n) {
                                $(this).css('width', '340px');
                            });
                        }
                        else if (temp.length > 45 && temp.length < 50) {
                            $('#AutoOrgName_completionListElem').css('width', '370px');
                            $("#AutoOrgName_completionListElem li").each(function (n) {
                                $(this).css('width', '370px');
                            });
                        }
                        else if (temp.length > 50 && temp.length < 55) {
                            $('#AutoOrgName_completionListElem').css('width', '400px');
                            $("#AutoOrgName_completionListElem li").each(function (n) {
                                $(this).css('width', '400px');
                            });
                        }
                        else if (temp.length > 55 && temp.length < 60) {
                            $('#AutoOrgName_completionListElem').css('width', '450px');
                            $("#AutoOrgName_completionListElem li").each(function (n) {
                                $(this).css('width', '450px');
                            });
                        }
                        else if (temp.length > 60 && temp.length < 65) {
                            $('#AutoOrgName_completionListElem').css('width', '500px');
                            $("#AutoOrgName_completionListElem li").each(function (n) {
                                $(this).css('width', '500px');
                            });
                        }
                    }
                }
            }
            function ChangeTxtBoxWidthDynamiclocat() {
                var completionList = $find("AutoCompleteExtenderLocation").get_completionList().childNodes;
                for (var i = 0; i < completionList.length; i++) {
                    var temp = completionList[i].innerHTML;
                    if ($('#AutoCompleteExtenderLocation_completionListElem').length > 0 && temp.length != '') {
                        if (temp.length > 0 && temp.length < 10) {
                            $('#AutoCompleteExtenderLocation_completionListElem').css('width', '150px');
                            $("#AutoCompleteExtenderLocation_completionListElem li").each(function (n) {
                                $(this).css('width', '200px');
                            });
                        }
                        else if (temp.length > 10 && temp.length < 25) {
                            $('#AutoCompleteExtenderLocation_completionListElem').css('width', '200px');
                            $("#AutoCompleteExtenderLocation_completionListElem li").each(function (n) {
                                $(this).css('width', '200px');
                            });
                        }
                        else if (temp.length > 25 && temp.length < 30) {
                            $('#AutoCompleteExtenderLocation_completionListElem').css('width', '250px');
                            $("#AutoCompleteExtenderLocation_completionListElem li").each(function (n) {
                                $(this).css('width', '250px');
                            });
                        }
                        else if (temp.length > 30 && temp.length < 35) {
                            $('#AutoCompleteExtenderLocation_completionListElem').css('width', '300px');
                            $("#AutoCompleteExtenderLocation_completionListElem li").each(function (n) {
                                $(this).css('width', '300px');
                            });
                        }
                        else if (temp.length > 35 && temp.length < 40) {
                            $('#AutoCompleteExtenderLocation_completionListElem').css('width', '320px');
                            $("#AutoCompleteExtenderLocation_completionListElem li").each(function (n) {
                                $(this).css('width', '320px');
                            });
                        }
                        else if (temp.length > 40 && temp.length < 45) {
                            $('#AutoCompleteExtenderLocation_completionListElem').css('width', '340px');
                            $("#AutoCompleteExtenderLocation_completionListElem li").each(function (n) {
                                $(this).css('width', '340px');
                            });
                        }
                        else if (temp.length > 45 && temp.length < 50) {
                            $('#AutoCompleteExtenderLocation_completionListElem').css('width', '370px');
                            $("#AutoCompleteExtenderLocation_completionListElem li").each(function (n) {
                                $(this).css('width', '370px');
                            });
                        }
                        else if (temp.length > 50 && temp.length < 55) {
                            $('#AutoCompleteExtenderLocation_completionListElem').css('width', '400px');
                            $("#AutoCompleteExtenderLocation_completionListElem li").each(function (n) {
                                $(this).css('width', '400px');
                            });
                        }
                        else if (temp.length > 55 && temp.length < 60) {
                            $('#AutoCompleteExtenderLocation_completionListElem').css('width', '450px');
                            $("#AutoCompleteExtenderLocation_completionListElem li").each(function (n) {
                                $(this).css('width', '450px');
                            });
                        }
                        else if (temp.length > 60 && temp.length < 65) {
                            $('#AutoCompleteExtenderLocation_completionListElem').css('width', '500px');
                            $("#AutoCompleteExtenderLocation_completionListElem li").each(function (n) {
                                $(this).css('width', '500px');
                            });
                        }
                    }
                }
            }


            function Checkorgtext() {

                var OrgId = $("#<%=hdnOrgId.ClientID%>").val();
            var ContextInfodetails = 'Org' + '~' + OrgId
            $find('AutoOrgName').set_contextKey(ContextInfodetails);

        }
        function CheckorgLocationtext() {
            var chk = document.getElementById('ChkIsConsign');
            var OrgId = $("#<%=hdnOrgId.ClientID%>").val();
            var ContextInfodetails = 'Location' + '~' + OrgId
            if (chk.checked) {
                ContextInfodetails = 'Location' + '~' + OrgId + '~' + 'Y'
            }
            else {
                ContextInfodetails = 'Location' + '~' + OrgId + '~' + 'N'
            }
            if (OrgId != "" && OrgId != "0") {
                $find('AutoCompleteExtenderLocation').set_contextKey(ContextInfodetails);
                $find('acetxtDefaultIntendLocation').set_contextKey(ContextInfodetails);
            }

            else {
                $find('AutoCompleteExtenderLocation').set_contextKey("");
                $find('acetxtDefaultIntendLocation').set_contextKey("");
            }

        }


        function validateattribute() {
            if (document.getelementbyid('txtattributename').value.trim() == "") {
                var userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_15') == null ? "provide product attribute" : SListForAppMsg.Get('InventoryMaster_Products_aspx_15');
                ValidationWindow(userMsg, errorMsg);
                document.getelementbyid('txtattributename').focus();
                return false;
            }
        }
        function validategridattribute(obj) {
            if (document.getelementbyid(obj).value == "") {
                var userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_15') == null ? "provide product attribute" : SListForAppMsg.Get('InventoryMaster_Products_aspx_15');
                ValidationWindow(userMsg, errorMsg);
                document.getelementbyid(obj).focus();
                return false;
            }
        }

        function onusagecount(obj) {
            if (obj.checked) {
                $('#divusagecount').removeClass().addClass('show');
            }
            else {
                $('#divusagecount').removeClass().addClass('hide');
            }
        }

        function GetProductsAttributes() {
            var GetValue = '';
            $("#divProductAttributes table tr").each(function () {
                var tr = $(this).closest("tr");
                $(tr).children('td').each(function (i) {
                    var td = $(this).closest("td");
                    if ($(this).children().attr('type') == 'checkbox') {
                        var id = $(this).children().attr('id');
                        var chk = document.getElementById(id).checked == true ? "Y" : "N";
                        GetValue += id + '~' + chk + '#';
                    }
                    else if ($(this).children().attr('type') == 'text') {
                        var id = $(this).children().attr('id');
                        var value = document.getElementById(id).value;
                        GetValue += id + '~' + value + '#';
                    }
                    else if ($(this).children().attr('type') == 'dropdownlist') {
                        var id = $(this).children().attr('id');
                        var value = document.getElementById(id).value;
                        GetValue += id + '~' + value + '#';
                    }
                });

            });

            $('#hdnProductList').val(GetValue);

        }

        function SetProductsAttributes() {
            var GetValue = $('#hdnProductList').val().split('#');

            for (var i = 0; i < GetValue.length; i++) {
                if (GetValue[i] != "") {
                    var ArrayValue = GetValue[i].split('~');
                    var id = ArrayValue[0] + '~' + ArrayValue[1];
                    if (document.getElementById(id) != undefined) {
                        if (document.getElementById(id).type == 'checkbox') {
                            document.getElementById(id).checked = ArrayValue[2] == "Y" ? true : false;
                        }
                        else if (document.getElementById(id).type == 'text') {
                            document.getElementById(id).value = ArrayValue[2];
                        }
                        else if (document.getElementById(id).type == 'dropdownlist') {
                            document.getElementById(id).value = ArrayValue[2];
                        }
                    }
                }
            }
        }

        function SetTax() {
            var GetValue = $('#hdnCatTax').val().split('#');
            for (var i = 0; i < GetValue.length; i++) {
                if (GetValue[i] != "") {
                    var ArrayValue = GetValue[i].split('~');
                    if ($('#<%= ddlCategory.ClientID %>').val() == ArrayValue[0]) {
                        $('#<%= TxtTax.ClientID %>').val(parseFloat(ArrayValue[1]).toFixed(2));
                        $('#hdnGetTax').val(parseFloat(ArrayValue[1]).toFixed(2));

                        break;
                    }
                }
            }

        }
        function doValidatePercent(obj) {
            if (Number(obj.value) > 100) {
                var userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_16') == null ? "percentage must between 0 to 100" : SListForAppMsg.Get('InventoryMaster_Products_aspx_16');
                ValidationWindow(userMsg, errorMsg);
                obj.value = "0.00";
                obj.select();
            }
            $('#hdnGetTax').val(Number(obj.value));
            return false;
        }

        function ProductsItemSelected(source, eventArgs) {

            var Product = eventArgs.get_text().split('^^');

            document.getElementById('txtProductName').value = Product[0];
            var ProductDetails = new Array();
            ProductDetails = eventArgs.get_value().split('~');
            ProductID = ProductDetails[0];
            ProductItemSelected(source, eventArgs);

        }
        function showaddframes() {
            $('#Bck-black').show();
            $('#Framediv').show();
        }

        function Closeclick() {
            $('#Framediv').hide();
            $('#Bck-black').hide();
            $('#hdnProductIspopUP').val('1');
        }





        function Attributes(ArrayDataColumnIndex, AttributeName, controlvalue) {
            var xml = "";
            xml = ArrayData[ArrayDataColumnIndex].AttributeName == AttributeName ? ArrayData[ArrayDataColumnIndex]._XMLTAG.replace('<AttributeValue></AttributeValue>', '<AttributeValue>' + controlvalue + '</AttributeValue>') : ArrayData[ArrayDataColumnIndex]._XMLTAG;
            return xml;
        }

        function btnSaveclick() {

            var Expression = $("#ddlCategory option:selected").text();
            switch (Expression) {
                case "Frames":
                    FrameNameSave();
                    break;
                case "Lens":
                    LensSave();
                    break;
                case "Sunglass":
                    SunglassSave();
                    break;
                case "Accessories":
                    AccessoriesSetupSave();
                    break;
            }
            $("#txtProductName").focus();
            var ddlCatSelVal = $("#ddlCategory option:selected").val();
            $("#hdnCategoryClear").val(ddlCatSelVal);
            Closeclick();


        }


        function FrameNameSave() {
            XMLdata = Attributes(2, 'FrameName', $("#txtFrameName").val());
            XMLdata = XMLdata + Attributes(3, 'ProductCode', $("#txtProCode").val());
            XMLdata = XMLdata + Attributes(4, 'Model', $("#txtModel").val());
            XMLdata = XMLdata + Attributes(5, 'Size', $("#txtSize").val());
            XMLdata = XMLdata + Attributes(6, 'Colour', $("#txtColour").val());
            XMLdata = XMLdata + Attributes(7, 'TempleColour', $("#txtTempleColour").val());
            XMLdata = XMLdata + Attributes(8, 'Type', $("#drpType option:selected").text());
            XMLdata = XMLdata + Attributes(9, 'MOC', $("#drpMOC option:selected").text());
            XMLdata = XMLdata + Attributes(10, 'Brand', $("#drpBrand option:selected").text());
            XMLdata = XMLdata + Attributes(11, 'TempleMoc', $("#drpTempleMoc option:selected").text());
            XMLdata = XMLdata + Attributes(12, 'TempleSize', $("#drpTempleSize option:selected").text());
            XMLdata = XMLdata + Attributes(13, 'Description', $("#txtareaDescription").val());
            XMLdata = '<Products>' + XMLdata + '</Products>';
            $("#hdnAttributes").val(XMLdata);
            var ProductName = '';
            var ProductCode = $("#txtProCode").val();
            var BrandName = $("#drpBrand").val() == "0" ? "" : $("#drpBrand option:selected").text();
            var Type = $("#drpType").val() == "0" ? "" : $("#drpType option:selected").text();
            ProductName = BrandName
                      + "  "
                      + Type
                      + "  "
                      + $("#txtModel").val()
                      + "  "
                      + $("#txtColour").val()
                      + "  "
                      + $("#txtSize").val();
            $("#txtProductName").val(ProductName == null ? "" : ProductName);
            $("#txtProductCode").val(ProductCode == null ? "" : ProductCode);
            $("#txtMake").val(BrandName == null ? "" : BrandName);

        }


        function AccessoriesSetupSave() {
            XMLdata = Attributes(0, 'ProductCode', $("#txtProCode").val());
            XMLdata = XMLdata + Attributes(1, 'Type', $("#drpType option:selected").text());
            XMLdata = XMLdata + Attributes(4, 'AddtionalServices', $("#drpAddtionalServices option:selected").text());
            XMLdata = XMLdata + Attributes(2, 'Description', $("#txtareaDescription").val());
            XMLdata = '<Products>' + XMLdata + '</Products>';
            $("#hdnAttributes").val(XMLdata);
            var ProductName = '';
            var ProductCode = $("#txtProCode").val();
            var AddtionalServices = $("#drpAddtionalServices").val() == "0" ? "" : $("#drpAddtionalServices option:selected").text();
            var Type = $("#drpType").val() == "0" ? "" : $("#drpType option:selected").text();
            ProductName = AddtionalServices
                      + "  "
                      + Type;

            $("#txtProductName").val(ProductName == null ? "" : ProductName);
            $("#txtProductCode").val(ProductCode == null ? "" : ProductCode);
            //$("#txtMake").val(BrandName == null ? "" : BrandName);

        }


        function LensSave() {
            XMLdata = Attributes(1, 'ProductCode', $("#txtProCode").val());
            XMLdata = XMLdata + Attributes(2, 'Power Range', $("#txtPowerRange").val());
            XMLdata = XMLdata + Attributes(3, 'Fitting Height', $("#txtFittingHeight").val());
            XMLdata = XMLdata + Attributes(4, 'Addition', $("#txtAddition").val());
            XMLdata = XMLdata + Attributes(5, 'Type', $("#drpType option:selected").text());
            XMLdata = XMLdata + Attributes(6, 'MOC', $("#drpMOC option:selected").text());
            XMLdata = XMLdata + Attributes(7, 'Brand', $("#drpBrand option:selected").text());
            XMLdata = XMLdata + Attributes(8, 'Vision', $("#drpVision option:selected").text());
            XMLdata = XMLdata + Attributes(9, 'Index', $("#drpIndex option:selected").text());
            XMLdata = XMLdata + Attributes(10, 'Coating', $("#drpCoating option:selected").text());
            XMLdata = XMLdata + Attributes(11, 'Description', $("#txtareaDescription").val());
            XMLdata = '<Products>' + XMLdata + '</Products>';
            $("#hdnAttributes").val(XMLdata);
            var ProductName = '';
            var ProductCode = $("#txtProCode").val();
            var Brand = $("#drpBrand").val() == "0" ? "" : $("#drpBrand option:selected").text();
            var Type = $("#drpType").val() == "0" ? "" : $("#drpType option:selected").text();

            ProductName = Brand + " " + Type;

            $("#txtProductName").val(ProductName == null ? "" : ProductName);
            $("#txtProductCode").val(ProductCode == null ? "" : ProductCode);
            $("#txtMake").val(Brand == null ? "" : Brand);
        }

        function SunglassSave() {

            XMLdata = Attributes(2, 'ProductCode', $("#txtProCode").val());
            XMLdata = XMLdata + Attributes(3, 'Model', $("#txtModel").val());
            XMLdata = XMLdata + Attributes(4, 'Size', $("#txtSize").val());
            XMLdata = XMLdata + Attributes(5, 'TempleColour', $("#txtTempleColour").val());
            XMLdata = XMLdata + Attributes(6, 'Colour Generic', $("#txtColourGeneric").val());
            XMLdata = XMLdata + Attributes(7, 'Colour Code', $("#txtColourCode").val());
            XMLdata = XMLdata + Attributes(8, 'Type', $("#drpType option:selected").text());
            XMLdata = XMLdata + Attributes(9, 'MOC', $("#drpMOC option:selected").text());
            XMLdata = XMLdata + Attributes(10, 'Brand', $("#drpBrand option:selected").text());
            XMLdata = XMLdata + Attributes(11, 'TempleMoc', $("#drpTempleMoc option:selected").text());
            XMLdata = XMLdata + Attributes(12, 'TempleSize', $("#drpTempleSize option:selected").text());
            XMLdata = XMLdata + Attributes(13, 'Description', $("#txtareaDescription").val());
            XMLdata = '<Products>' + XMLdata + '</Products>';
            $("#hdnAttributes").val(XMLdata);
            var ProductName = '';
            var ProductCode = $("#txtProCode").val();
            var BrandName = $("#drpBrand").val() == "0" ? "" : $("#drpBrand option:selected").text();
            var Type = $("#drpType").val() == "0" ? "" : $("#drpType option:selected").text();

            ProductName = BrandName
                      + " "
                      + Type
                      + " "
                      + $("#txtModel").val()
                      + " "
                      + $("#txtColourGeneric").val()
                      + " "
                      + $("#txtSize").val();

            $("#txtProductName").val(ProductName == null ? "" : ProductName);
            $("#txtProductCode").val(ProductCode == null ? "" : ProductCode);
            $("#txtMake").val(BrandName == null ? "" : BrandName);
        }

        function SaveAttributesDetail(XMLVal) {
            $.ajax({
                type: "POST",
                url: "../InventoryMaster/Webservice/InventoryMaster.asmx/pSaveOpticals_AttributeDetails",
                data: "{'strProductdtls' : '" + XMLVal + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    if (data.d > 0) {
                        if (data.d == 1001) {
                            var userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_17') == null ? "Error: Server Error while saving Optical records." : SListForAppMsg.Get('InventoryMaster_Products_aspx_17');
                            ValidationWindow(userMsg, errorMsg);
                        }
                        else {
                            var userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_18') == null ? "Saved Sucessfully." : SListForAppMsg.Get('InventoryMaster_Products_aspx_18');
                            ValidationWindow(userMsg, errorMsg);
                            Closeclick();
                        }
                    }
                    else {
                        var userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_19') == null ? "Optical Records not saved." : SListForAppMsg.Get('InventoryMaster_Products_aspx_19');
                        ValidationWindow(userMsg, errorMsg);
                    }
                }

            });
        }



        function CategoryClear() {
            try {
                if ($("#hdnCategoryClear").val() != $("#ddlCategory").val()) {

                    document.getElementById('txtMake').value = '';
                    document.getElementById('txtProductCode').value = '';
                    document.getElementById('TxtTax').value = 0;
                    $("#ddlTaxtype").val("0");//Vijayaraja
                    document.getElementById('hdnGetTax').value = 0;
                    document.getElementById('hdnId').value = 0;
                    document.getElementById('txtProductName').value = '';
                    $("#ddlCategory option:selected").text();
                    document.getElementById('bUnits').value = 0;
                    document.getElementById('txtDescription').value = '';
                    document.getElementById('txtHsnCode').value = '';//Vijayaraja
                    document.getElementById('txtMfgName').value = '';
                    document.getElementById('txtMfgCode').value = '';
                    document.getElementById('btnFinish').value = 'Save';
                    document.getElementById('lblmsg').innerText = '';
                    document.getElementById('hdnStatus').value = 'Save';
                    $("#ddlType option:selected").text();
                    document.getElementById('txtProductModel').value = '';
                    document.getElementById('txtLTofProduct').value = '';
                    document.getElementById('txtGenericName').value = '';
                    document.getElementById('hdnGenericID').value = '0';
                    //document.getElementById('tdTransblock').style.display = 'none';
                    $('#tdTransblock').removeClass().addClass('hide');
                    //document.getElementById('tddelete').style.display = 'none';
                    $('#tddelete').removeClass().addClass('hide');
                    document.getElementById('hdnLocationList').value = '';
                    document.getElementById('hdnLocationName').value = '';
                }
            }
            catch (Error) {
                alert(Error);
            }
        }
        function GetService(popvalue) {
            var GetValue = $('#hdnProductList').val().split('#');
            var ddlCategory = $("#ddlCategory option:selected").text();
            $.ajax({
                type: "POST",
                url: "../InventoryMaster/Webservice/InventoryMaster.asmx/GetOptical_FramesControls",
                data: "{'ProductType' : '" + $("#ddlCategory option:selected").text() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        FramesTableDataOptical(data, popvalue);
                        if (popvalue != 'True') {
                            for (var i = 0; i < GetValue.length; i++) {
                                if (GetValue[i] != "") {
                                    var ArrayValue = GetValue[i].split('~');
                                    if (ddlCategory.toLowerCase() == "frames") {
                                        Edit_FrameSetUp(ArrayValue[0], ArrayValue[2]);
                                    }
                                    else if (ddlCategory.toLowerCase() == "lens") {
                                        Edit_LensSetUp(ArrayValue[0], ArrayValue[2]);
                                    }
                                    else if (ddlCategory.toLowerCase() == "sunglass") {
                                        Edit_SunGlassSetUp(ArrayValue[0], ArrayValue[2]);
                                    }
                                    else if (ddlCategory.toLowerCase() == "accessories") {
                                        Edit_AccessoriesSetUp(ArrayValue[0], ArrayValue[2]);
                                    }

                                }
                            }
                        }
                        $('#Bck-black').show();
                        $('#Framediv').show();

                    }
                }

            });

        }
        function Edit_FrameSetUp(Attribute, Values) {

            if (Attribute == "FrameName") {
                $("#txtFrameName").val(Values);
            }
            else if (Attribute == "ProductCode") {
                var prcode = $("#txtProductCode").val();
                $("#txtProCode").val(prcode);
            }
            else if (Attribute == "Model") {
                $("#txtModel").val(Values);
            }

            else if (Attribute == "Size") {
                $("#txtSize").val(Values);
            }

            else if (Attribute == "Colour") {
                $("#txtColour").val(Values);
            }

            else if (Attribute == "TempleColour") {
                $("#txtTempleColour").val(Values);
            }

            else if (Attribute == "Type") {
                $("#drpType").val(Values);
            }
            else if (Attribute == "MOC") {
                $("#drpMOC").val(Values);

            }
            else if (Attribute == "Brand") {
                $("#drpBrand").val(Values);

            }
            else if (Attribute == "TempleMoc") {
                $("#drpTempleMoc").val(Values);

            }
            else if (Attribute == "TempleSize") {
                $("#drpTempleSize").val(Values);

            }
            else if (Attribute == "Description") {
                $("#txtareaDescription").val(Values);
            }

        }


        function Edit_AccessoriesSetUp(Attribute, Values) {

            if (Attribute == "ProductCode") {
                var prcode = $("#txtProductCode").val();
                $("#txtProCode").val(prcode);
            }

            else if (Attribute == "Type") {
                $("#drpType").val(Values);
            }
            else if (Attribute == "AddtionalServices") {
                $("#drpAddtionalServices").val(Values);

            }
            else if (Attribute == "Description") {
                $("#txtareaDescription").val(Values);
            }

        }


        function Edit_LensSetUp(Attribute, Values) {
            if (Attribute == "ProductCode") {
                var prcode = $("#txtProductCode").val();
                $("#txtProCode").val(prcode);
            }
            else if (Attribute == "Power Range") {
                $("#txtPowerRange").val(Values);
            }
            else if (Attribute == "Fitting Height") {
                $("#txtFittingHeight").val(Values);
            }
            else if (Attribute == "Addition") {
                $("#txtAddition").val(Values);
            }
            else if (Attribute == "Type") {
                $("#drpType").val(Values);
            }
            else if (Attribute == "MOC") {
                $("#drpMOC").val(Values);
            }
            else if (Attribute == "Brand") {
                $("#drpBrand").val(Values);
            }
            else if (Attribute == "Vision") {
                $("#drpVision").val(Values);
            }

            else if (Attribute == "Index") {
                $("#drpIndex").val(Values);
            }
            else if (Attribute == "Coating") {
                $("#drpCoating").val(Values);
            }
            else if (Attribute == "Description") {
                $("#txtareaDescription").val(Values);
            }
        }

        function Edit_SunGlassSetUp(Attribute, Values) {
            if (Attribute == "ProductCode") {
                var prcode = $("#txtProductCode").val();
                $("#txtProCode").val(prcode);
            }
            else if (Attribute == "Model") {
                $("#txtModel").val(Values);
            }
            else if (Attribute == "Size") {
                $("#txtSize").val(Values);
            }

            else if (Attribute == "TempleColour") {
                $("#txtTempleColour").val(Values);
            }

            else if (Attribute == "Colour Generic") {
                $("#txtColourGeneric").val(Values);
            }
            else if (Attribute == "Colour Code") {
                $("#txtColourCode").val(Values);
            }
            else if (Attribute == "Type") {
                $("#drpType").val(Values);
            }
            else if (Attribute == "MOC") {
                $("#drpMOC").val(Values);
            }
            else if (Attribute == "Brand") {
                $("#drpBrand").val(Values);
            }
            else if (Attribute == "TempleMoc") {
                $("#drpTempleMoc").val(Values);
            }
            else if (Attribute == "TempleSize") {
                $("#drpTempleSize").val(Values);
            }
            else if (Attribute == "Description") {
                $("#txtareaDescription").val(Values);
            }
        }
        function FramesTableData(data) {
            $("#tbl1").empty();
            $("#tbl2").empty();
            var A = new Array();
            ArrayData = data.d;
            var TableSt = "<table class='w-99p'>";
            var TableEnd = "</table>";
            var TRowSt = "<tr class='lh35'>";
            var TRowEnd = "</tr>";
            var TDSt = "<td class='w-20p'>";
            var TDEnd = "</td>";
            var FramesHead = "";
            var FramesSchema = "";
            if ($("#ddlType option:selected").text().toUpperCase() == "FRAMES") {

                A["FrameName"] = data.d[2];
                A["ProductCode"] = data.d[3];
                A["Model"] = data.d[4];
                A["Size"] = data.d[5];
                A["Colour"] = data.d[6];
                A["TempleColour"] = data.d[7];
                A["Type"] = data.d[8];
                A["MOC"] = data.d[9];
                A["Brand"] = data.d[10];
                A["TempleMoc"] = data.d[11];
                A["TempleSize"] = data.d[12];
                A["Frames Setup"] = data.d[0];
                A["Temple Details"] = data.d[1];
                A["SAVE"] = data.d[14];
                A["Description"] = data.d[13];

                FramesHead = "<table class='w-100p paddingT2'>"
                                + "<td class='a-left font14 bold paddingL1 w-60p'>"
                                + "<span>" + A["Frames Setup"].AttributeName + "</span>"
                                + "</td>"
                                + "<td class='a-right marginR10'>"
                                + "<input type='button' id='Button1' onclick='Closeclick()' value='X' class='btn bold borderstyle3' />"
                                + "</td>"
                                + "</table>"

                $("#tbl1").append(FramesHead);

                FramesSchema =
              TableSt
               + TRowSt
                    + TDSt + A["FrameName"].AttributeName + TDEnd
                    + TDSt + A["FrameName"]._HTMLTAG + TDEnd
                    + TDSt + A["ProductCode"].AttributeName + TDEnd
                    + TDSt + A["ProductCode"]._HTMLTAG + TDEnd
               + TRowEnd

               + TRowSt
                    + TDSt
                        + A["MOC"].AttributeName
                    + TDEnd
                    + TDSt + A["MOC"]._HTMLTAG
                    + TDEnd
                    + TDSt
                       + A["Type"].AttributeName
                    + TDEnd
                    + TDSt + A["Type"]._HTMLTAG
                    + TDEnd
                + TRowEnd

                + TRowSt
                    + TDSt +
                         A["Model"].AttributeName
                     + TDEnd
                  + TDSt +
                        A["Model"]._HTMLTAG
                    + TDEnd
                        + TDSt +
                           A["Brand"].AttributeName
                       + TDEnd
                       + TDSt +
                            A["Brand"]._HTMLTAG
                       + TDEnd
                 + TRowEnd

                   + TRowSt
                         + TDSt +
                           A["Size"].AttributeName
                        + TDEnd
                        + TDSt +
                           A["Size"]._HTMLTAG
                        + TDEnd
                       + TDSt +
                           A["Colour"].AttributeName
                        + TDEnd
                        + TDSt +
                            A["Colour"]._HTMLTAG
                        + TDEnd
                  + TRowEnd

                    + "<tr class='lh30'>"
                        + "<td colspan='4' class='bg-white bold'>"
                            + "<span>" + A["Temple Details"].AttributeName + "</span>"
                        + TDEnd
                    + TRowEnd

                    + TRowSt
                        + TDSt +
                             A["TempleMoc"].AttributeName
                        + TDEnd
                        + TDSt +
                             A["TempleMoc"]._HTMLTAG
                         + TDEnd
                         + TDSt +
                           A["TempleColour"].AttributeName
                         + TDEnd
                        + TDSt +
                            A["TempleColour"]._HTMLTAG
                        + TDEnd
                   + TRowEnd

                   + TRowSt
                        + TDSt +
                            A["TempleSize"].AttributeName
                          + TDEnd
                     + TDSt +
                            A["TempleSize"]._HTMLTAG
                    + TDEnd
                        + "<td colspan='2'>"
                            + "&nbsp;"
                        + "</td>"
                  + TRowEnd

                   + TRowSt
                       + TDSt +
                           A["Description"].AttributeName
                     + TDEnd
                          + TDSt +
                             A["Description"]._HTMLTAG
                            + TDEnd
                        + "<td colspan='2'>"
                         + TDEnd
                  + TRowEnd

                    + "<tr class='lh40'>"
                        + "<td colspan='4' class='a-center'>"
                            + A["SAVE"]._HTMLTAG
                         + TDEnd
                    + TRowEnd
                TableEnd
                $("#tbl2").append(FramesSchema);
            }
            else if ($("#ddlType option:selected").text().toUpperCase() == "LENS") {

                A["ProductCode"] = data.d[1];
                A["Power Range"] = data.d[2];
                A["Fitting Height"] = data.d[3];
                A["Addition"] = data.d[4];
                A["Type"] = data.d[5];
                A["MOC"] = data.d[6];
                A["Brand"] = data.d[7];
                A["Vision"] = data.d[8];
                A["Index"] = data.d[9];
                A["Coating"] = data.d[10];
                A["Lens Setup"] = data.d[0];
                A["SAVE"] = data.d[12];
                A["Description"] = data.d[11];

                FramesHead = "<table class='w-100p paddingT2'>"
                                + "<td class='a-left font14 bold paddingL1 w-60p'>"
                                + "<span>" + A["Lens Setup"].AttributeName + "</span>"
                                + "</td>"
                                + "<td class='a-right marginR10'>"
                                + "<input type='button' id='Button1' onclick='Closeclick()' value='X' class='btn bold borderstyle3' />"
                                + "</td>"
                                + "</table>"
                $("#tbl1").append(FramesHead);
                FramesSchema =
              TableSt
               + TRowSt
                    + TDSt + A["Type"].AttributeName + TDEnd
                    + TDSt + A["Type"]._HTMLTAG + TDEnd
                    + TDSt + A["ProductCode"].AttributeName + TDEnd
                    + TDSt + A["ProductCode"]._HTMLTAG + TDEnd
               + TRowEnd

               + TRowSt
                    + TDSt
                        + A["Vision"].AttributeName
                    + TDEnd
                    + TDSt + A["Vision"]._HTMLTAG
                    + TDEnd
                    + TDSt
                       + A["MOC"].AttributeName
                    + TDEnd
                    + TDSt + A["MOC"]._HTMLTAG
                    + TDEnd
                + TRowEnd

                + TRowSt
                    + TDSt +
                         A["Index"].AttributeName
                     + TDEnd
                  + TDSt +
                        A["Index"]._HTMLTAG
                    + TDEnd
                        + TDSt +
                           A["Coating"].AttributeName
                       + TDEnd
                       + TDSt +
                          A["Coating"]._HTMLTAG
                       + TDEnd
                 + TRowEnd

                   + TRowSt
                         + TDSt +
                           A["Power Range"].AttributeName
                        + TDEnd
                        + TDSt +
                           A["Power Range"]._HTMLTAG
                        + TDEnd
                       + TDSt +
                           A["Addition"].AttributeName
                        + TDEnd
                        + TDSt +
                            A["Addition"]._HTMLTAG
                        + TDEnd
                  + TRowEnd

        + TRowSt
                + TDSt +
                        A["Fitting Height"].AttributeName
                 + TDEnd
                + TDSt +
                        A["Fitting Height"]._HTMLTAG
                 + TDEnd
                + TDSt +
                      A["Brand"].AttributeName
                  + TDEnd
               + TDSt +
                     A["Brand"]._HTMLTAG
                + TDEnd
     + TRowEnd

                    + "<tr class='lh30'>"
                        + "<td colspan='4' class='bg-white bold'>"
                        + TDEnd
                    + TRowEnd

                   + TRowSt
                       + TDSt +
                           A["Description"].AttributeName
                     + TDEnd
                          + TDSt +
                             A["Description"]._HTMLTAG
                            + TDEnd
                        + "<td colspan='2'>"
                         + TDEnd
                  + TRowEnd

                    + "<tr class='lh40'>"
                        + "<td colspan='4' class='a-center'>"
                            + A["SAVE"]._HTMLTAG
                         + TDEnd
                    + TRowEnd
                TableEnd
                $("#tbl2").append(FramesSchema);
            }
            else if ($("#ddlType option:selected").text().toUpperCase() == "SUNGLASS") {

                A["ProductCode"] = data.d[2];
                A["Model"] = data.d[3];
                A["Size"] = data.d[4];
                A["TempleColour"] = data.d[5];
                A["Colour Generic"] = data.d[6];
                A["Colour Code"] = data.d[7];
                A["Type"] = data.d[8];
                A["MOC"] = data.d[9];
                A["Brand"] = data.d[10];
                A["TempleMoc"] = data.d[11];
                A["TempleSize"] = data.d[12];
                A["Temple Details"] = data.d[0];
                A["Sunglass Setup"] = data.d[1];
                A["SAVE"] = data.d[14];
                A["Description"] = data.d[13];

                FramesHead = "<table class='w-100p paddingT2'>"
                                + "<td class='a-left font14 bold paddingL1 w-60p'>"
                                + "<span>" + A["Sunglass Setup"].AttributeName + "</span>"
                                + "</td>"
                                + "<td class='a-right marginR10'>"
                                + "<input type='button' id='Button1' onclick='Closeclick()' value='X' class='btn bold borderstyle3'/>"
                                + "</td>"
                                + "</table>"
                $("#tbl1").append(FramesHead);
                FramesSchema =
              TableSt
               + TRowSt
                    + TDSt + A["ProductCode"].AttributeName + TDEnd
                    + TDSt + A["ProductCode"]._HTMLTAG + TDEnd
               + TRowEnd

               + TRowSt
                    + TDSt
                        + A["Brand"].AttributeName
                    + TDEnd
                    + TDSt + A["Brand"]._HTMLTAG
                    + TDEnd
                    + TDSt
                       + A["Model"].AttributeName
                    + TDEnd
                    + TDSt + A["Model"]._HTMLTAG
                    + TDEnd
                + TRowEnd

                + TRowSt
                    + TDSt +
                         A["MOC"].AttributeName
                     + TDEnd
                  + TDSt +
                        A["MOC"]._HTMLTAG
                    + TDEnd
                        + TDSt +
                           A["Type"].AttributeName
                       + TDEnd
                       + TDSt +
                          A["Type"]._HTMLTAG
                       + TDEnd
                 + TRowEnd

                   + TRowSt
                         + TDSt +
                           A["Colour Generic"].AttributeName
                        + TDEnd
                        + TDSt +
                           A["Colour Generic"]._HTMLTAG
                        + TDEnd
                       + TDSt +
                           A["Colour Code"].AttributeName
                        + TDEnd
                        + TDSt +
                            A["Colour Code"]._HTMLTAG
                        + TDEnd
                  + TRowEnd

        + TRowSt
                + TDSt +
                        A["Size"].AttributeName
                 + TDEnd
                + TDSt +
                        A["Size"]._HTMLTAG
                 + TDEnd

                + TDEnd
     + TRowEnd

                    + "<tr class='lh30'>"
                        + "<td colspan='4' class='bg-white bold'>"
                         + "<span>" + A["Temple Details"].AttributeName + "</span>"
                        + TDEnd
                    + TRowEnd

                    + TRowSt
                        + TDSt +
                             A["TempleMoc"].AttributeName
                        + TDEnd
                        + TDSt +
                             A["TempleMoc"]._HTMLTAG
                         + TDEnd
                         + TDSt +
                           A["TempleColour"].AttributeName
                         + TDEnd
                        + TDSt +
                            A["TempleColour"]._HTMLTAG
                        + TDEnd
                   + TRowEnd

                   + TRowSt
                        + TDSt +
                            A["TempleSize"].AttributeName
                          + TDEnd
                     + TDSt +
                            A["TempleSize"]._HTMLTAG
                    + TDEnd
                        + "<td colspan='2'>"
                            + "&nbsp;"
                        + "</td>"
                  + TRowEnd

                   + TRowSt
                       + TDSt +
                           A["Description"].AttributeName
                     + TDEnd
                          + TDSt +
                             A["Description"]._HTMLTAG
                            + TDEnd
                        + "<td colspan='2'>"
                         + TDEnd
                  + TRowEnd


                    + "<tr class='lh40'>"
                        + "<td colspan='4' class='a-center'>"
                            + A["SAVE"]._HTMLTAG
                         + TDEnd
                    + TRowEnd
                TableEnd
                $("#tbl2").append(FramesSchema);

            }
        }

        function FramesTableDataOptical(data, popvalue) {
            $("#tbl1").empty();
            $("#tbl2").empty();
            var A = new Array();
            ArrayData = data.d;
            var TableSt = "<table class='w-99p'>";
            var TableEnd = "</table>";
            var TRowSt = "<tr class='lh35'>";
            var TRowEnd = "</tr>";
            var TDSt = "<td class='w-20p'>";
            var TDEnd = "</td>";
            var FramesHead = "";
            var FramesSchema = "";
            if ($("#ddlCategory option:selected").text().toUpperCase() == "FRAMES") {

                A["FrameName"] = data.d[2];
                A["ProductCode"] = data.d[3];
                A["Model"] = data.d[4];
                A["Size"] = data.d[5];
                A["Colour"] = data.d[6];
                A["TempleColour"] = data.d[7];
                A["Type"] = data.d[8];
                A["MOC"] = data.d[9];
                A["Brand"] = data.d[10];
                A["TempleMoc"] = data.d[11];
                A["TempleSize"] = data.d[12];
                A["Frames Setup"] = data.d[0];
                A["Temple Details"] = data.d[1];
                A["SAVE"] = data.d[14];
                A["Description"] = data.d[13];

                FramesHead = "<table class='w-100p paddingT2'>"
                                + "<td class='a-left font14 bold paddingL1 w-60p'>"
                                + "<span>" + A["Frames Setup"].AttributeName + "</span>"
                                + "</td>"
                                + "<td class='a-right marginR10'>"
                                + "<input type='button' id='Button1' onclick='Closeclick()' value='X' class='btn bold borderstyle3'/>"
                                + "</td>"
                                + "</table>"

                $("#tbl1").append(FramesHead);
                var DisplayTxtFrameName = A["FrameName"]._DisplayText == "" ? A["FrameName"].AttributeName : A["FrameName"]._DisplayText;
                var DisplayTxtFrameProductCode = A["ProductCode"]._DisplayText == "" ? A["ProductCode"].AttributeName : A["ProductCode"]._DisplayText;
                var DisplayTxtFrameTempleMoc = A["TempleMoc"]._DisplayText == "" ? A["TempleMoc"].AttributeName : A["TempleMoc"]._DisplayText;
                var DisplayTxtFrameTempleSize = A["TempleSize"]._DisplayText == "" ? A["TempleSize"].AttributeName : A["TempleSize"]._DisplayText;
                var DisplayTxtFrameTempleColor = A["TempleColour"]._DisplayText == "" ? A["TempleColour"].AttributeName : A["TempleColour"]._DisplayText;
                FramesSchema =
              TableSt
               + TRowSt
                //+ TDSt + A["FrameName"].AttributeName + TDEnd
                    + TDSt + DisplayTxtFrameName + TDEnd
                    + TDSt + A["FrameName"]._HTMLTAG + TDEnd
                // + TDSt + A["ProductCode"].AttributeName + TDEnd
                   + TDSt + DisplayTxtFrameProductCode + TDEnd
                    + TDSt + A["ProductCode"]._HTMLTAG + TDEnd
               + TRowEnd

               + TRowSt
                    + TDSt
                        + A["MOC"].AttributeName
                    + TDEnd
                    + TDSt + A["MOC"]._HTMLTAG
                    + TDEnd
                    + TDSt
                       + A["Type"].AttributeName
                    + TDEnd
                    + TDSt + A["Type"]._HTMLTAG
                    + TDEnd
                + TRowEnd

                + TRowSt
                    + TDSt +
                         A["Model"].AttributeName
                     + TDEnd
                  + TDSt +
                        A["Model"]._HTMLTAG
                    + TDEnd
                        + TDSt +
                           A["Brand"].AttributeName
                       + TDEnd
                       + TDSt +
                            A["Brand"]._HTMLTAG
                       + TDEnd
                 + TRowEnd

                   + TRowSt
                         + TDSt +
                           A["Size"].AttributeName
                        + TDEnd
                        + TDSt +
                           A["Size"]._HTMLTAG
                        + TDEnd
                       + TDSt +
                           A["Colour"].AttributeName
                        + TDEnd
                        + TDSt +
                            A["Colour"]._HTMLTAG
                        + TDEnd
                  + TRowEnd

                    + "<tr class='lh30'>"
                        + "<td colspan='4' class='bg-white bold'>"
                            + "<span>" + A["Temple Details"].AttributeName + "</span>"
                        + TDEnd
                    + TRowEnd

                    + TRowSt
                        + TDSt +
                //A["TempleMoc"].AttributeName
                             DisplayTxtFrameTempleMoc
                        + TDEnd
                        + TDSt +
                             A["TempleMoc"]._HTMLTAG
                         + TDEnd
                         + TDSt +
                //A["TempleColour"].AttributeName
                           DisplayTxtFrameTempleColor
                         + TDEnd
                        + TDSt +
                            A["TempleColour"]._HTMLTAG
                        + TDEnd
                   + TRowEnd

                   + TRowSt
                        + TDSt +
                // A["TempleSize"].AttributeName
                           DisplayTxtFrameTempleSize
                          + TDEnd
                     + TDSt +
                            A["TempleSize"]._HTMLTAG
                    + TDEnd
                        + "<td colspan='2'>"
                            + "&nbsp;"
                        + "</td>"
                  + TRowEnd

                   + TRowSt
                       + TDSt +
                           A["Description"].AttributeName
                     + TDEnd
                          + TDSt +
                             A["Description"]._HTMLTAG
                            + TDEnd
                        + "<td colspan='2'>"
                         + TDEnd
                  + TRowEnd

                    + "<tr class='lh40'>"
                        + "<td colspan='4' class='a-center'>"
                            + A["SAVE"]._HTMLTAG
                         + TDEnd
                    + TRowEnd
                TableEnd
                $("#tbl2").append(FramesSchema);
            }
            if ($("#ddlCategory option:selected").text().toUpperCase() == "ACCESSORIES") {
                A["AddtionalServices"] = data.d[4];
                A["ProductCode"] = data.d[0];
                A["Type"] = data.d[1];
                A["Accessories Setup"] = data.d[5];
                A["SAVE"] = data.d[3];
                A["Description"] = data.d[2];

                FramesHead = "<table class='w-100p paddingT2'>"
                                + "<td class='a-left font14 bold paddingL1 w-60p'>"
                                + "<span>" + A["Accessories Setup"].AttributeName + "</span>"
                                + "</td>"
                                + "<td class='a-right marginR10'>"
                                + "<input type='button' id='Button1' onclick='Closeclick()' value='X' class='btn bold borderstyle3'/>"
                                + "</td>"
                                + "</table>"

                $("#tbl1").append(FramesHead);
                var DisplayTxtAccProductCode = A["ProductCode"]._DisplayText == "" ? A["ProductCode"].AttributeName : A["ProductCode"]._DisplayText;
                var DisplayTxtAccAdditionalService = A["AddtionalServices"]._DisplayText == "" ? A["AddtionalServices"].AttributeName : A["AddtionalServices"]._DisplayText;
                FramesSchema =
              TableSt
               + TRowSt
                //+ TDSt + A["ProductCode"].AttributeName + TDEnd
                    + TDSt + DisplayTxtAccProductCode + TDEnd
                    + TDSt + A["ProductCode"]._HTMLTAG + TDEnd
               + TRowEnd

               + TRowSt

                    + TDSt
                       + A["Type"].AttributeName
                    + TDEnd
                    + TDSt + A["Type"]._HTMLTAG
                    + TDEnd
                       + TDSt
                //+ A["AddtionalServices"].AttributeName
            + DisplayTxtAccAdditionalService
                    + TDEnd
                    + TDSt + A["AddtionalServices"]._HTMLTAG
                    + TDEnd
                + TRowEnd


                   + TRowSt
                       + TDSt +
                           A["Description"].AttributeName
                     + TDEnd
                          + TDSt +
                             A["Description"]._HTMLTAG
                            + TDEnd
                        + "<td colspan='2'>"
                         + TDEnd
                  + TRowEnd

                    + "<tr class='lh40'>"
                        + "<td colspan='4' class='a-center'>"
                            + A["SAVE"]._HTMLTAG
                         + TDEnd
                    + TRowEnd
                TableEnd
                $("#tbl2").append(FramesSchema);
            }
            else if ($("#ddlCategory option:selected").text().toUpperCase() == "LENS") {

                A["ProductCode"] = data.d[1];
                A["Power Range"] = data.d[2];
                A["Fitting Height"] = data.d[3];
                A["Addition"] = data.d[4];
                A["Type"] = data.d[5];
                A["MOC"] = data.d[6];
                A["Brand"] = data.d[7];
                A["Vision"] = data.d[8];
                A["Index"] = data.d[9];
                A["Coating"] = data.d[10];
                A["Lens Setup"] = data.d[0];
                A["SAVE"] = data.d[12];
                A["Description"] = data.d[11];

                FramesHead = "<table class='w-100p paddingT2'>"
                                + "<td class='a-left font14 bold paddingL1 w-60p'>"
                                + "<span>" + A["Lens Setup"].AttributeName + "</span>"
                                + "</td>"
                                + "<td class='a-right marginR10'>"
                                + "<input type='button' id='Button1' onclick='Closeclick()' value='X' class='btn bold borderstyle3'/>"
                                + "</td>"
                                + "</table>"
                $("#tbl1").append(FramesHead);
                var DisplayTxtLensProCode = A["ProductCode"]._DisplayText == "" ? A["ProductCode"].AttributeName : A["ProductCode"]._DisplayText;
                FramesSchema =
              TableSt
               + TRowSt
                    + TDSt + A["Type"].AttributeName + TDEnd
                    + TDSt + A["Type"]._HTMLTAG + TDEnd
                //+ TDSt + A["ProductCode"].AttributeName + TDEnd
                    + TDSt + DisplayTxtLensProCode + TDEnd
                    + TDSt + A["ProductCode"]._HTMLTAG + TDEnd
               + TRowEnd

               + TRowSt
                    + TDSt
                        + A["Vision"].AttributeName
                    + TDEnd
                    + TDSt + A["Vision"]._HTMLTAG
                    + TDEnd
                    + TDSt
                       + A["MOC"].AttributeName
                    + TDEnd
                    + TDSt + A["MOC"]._HTMLTAG
                    + TDEnd
                + TRowEnd

                + TRowSt
                    + TDSt +
                         A["Index"].AttributeName
                     + TDEnd
                  + TDSt +
                        A["Index"]._HTMLTAG
                    + TDEnd
                        + TDSt +
                           A["Coating"].AttributeName
                       + TDEnd
                       + TDSt +
                          A["Coating"]._HTMLTAG
                       + TDEnd
                 + TRowEnd

                   + TRowSt
                         + TDSt +
                           A["Power Range"].AttributeName
                        + TDEnd
                        + TDSt +
                           A["Power Range"]._HTMLTAG
                        + TDEnd
                       + TDSt +
                           A["Addition"].AttributeName
                        + TDEnd
                        + TDSt +
                            A["Addition"]._HTMLTAG
                        + TDEnd
                  + TRowEnd

        + TRowSt
                + TDSt +
                        A["Fitting Height"].AttributeName
                 + TDEnd
                + TDSt +
                        A["Fitting Height"]._HTMLTAG
                 + TDEnd
                + TDSt +
                      A["Brand"].AttributeName
                  + TDEnd
               + TDSt +
                     A["Brand"]._HTMLTAG
                + TDEnd
     + TRowEnd

                    + "<tr class='lh30'>"
                        + "<td colspan='4' class='bg-white bold'>"
                        + TDEnd
                    + TRowEnd

                   + TRowSt
                       + TDSt +
                           A["Description"].AttributeName
                     + TDEnd
                          + TDSt +
                             A["Description"]._HTMLTAG
                            + TDEnd
                        + "<td colspan='2'>"
                         + TDEnd
                  + TRowEnd

                    + "<tr class='lh40'>"
                        + "<td colspan='4' class='a-center'>"
                            + A["SAVE"]._HTMLTAG
                         + TDEnd
                    + TRowEnd
                TableEnd
                $("#tbl2").append(FramesSchema);
            }
            else if ($("#ddlCategory option:selected").text().toUpperCase() == "SUNGLASS") {

                A["ProductCode"] = data.d[2];
                A["Model"] = data.d[3];
                A["Size"] = data.d[4];
                A["TempleColour"] = data.d[5];
                A["Colour Generic"] = data.d[6];
                A["Colour Code"] = data.d[7];
                A["Type"] = data.d[8];
                A["MOC"] = data.d[9];
                A["Brand"] = data.d[10];
                A["TempleMoc"] = data.d[11];
                A["TempleSize"] = data.d[12];
                A["Temple Details"] = data.d[0];
                A["Sunglass Setup"] = data.d[1];
                A["SAVE"] = data.d[14];
                A["Description"] = data.d[13];

                FramesHead = "<table class='w-100p paddingT2'>"
                                + "<td class='a-left font14 bold paddingL1 w-60p'>"
                                + "<span>" + A["Sunglass Setup"].AttributeName + "</span>"
                                + "</td>"
                                + "<td class='a-right marginR10'>"
                                + "<input type='button' id='Button1' onclick='Closeclick()' value='X' class='btn bold borderstyle3' />"
                                + "</td>"
                                + "</table>"
                $("#tbl1").append(FramesHead);
                var DisplayTxtSunGlasProcode = A["ProductCode"]._DisplayText == "" ? A["ProductCode"].AttributeName : A["ProductCode"]._DisplayText;
                var DisplayTxtSunGlasTempleMoc = A["TempleMoc"]._DisplayText == "" ? A["TempleMoc"].AttributeName : A["TempleMoc"]._DisplayText;
                var DisplayTxtSunGlasFrameTempleSize = A["TempleSize"]._DisplayText == "" ? A["TempleSize"].AttributeName : A["TempleSize"]._DisplayText;
                var DisplayTxtSunGlasFrameTempleColor = A["TempleColour"]._DisplayText == "" ? A["TempleColour"].AttributeName : A["TempleColour"]._DisplayText;
                FramesSchema =
              TableSt
               + TRowSt
                // + TDSt + A["ProductCode"].AttributeName + TDEnd
                    + TDSt + DisplayTxtSunGlasProcode + TDEnd
                    + TDSt + A["ProductCode"]._HTMLTAG + TDEnd
               + TRowEnd

               + TRowSt
                    + TDSt
                        + A["Brand"].AttributeName
                    + TDEnd
                    + TDSt + A["Brand"]._HTMLTAG
                    + TDEnd
                    + TDSt
                       + A["Model"].AttributeName
                    + TDEnd
                    + TDSt + A["Model"]._HTMLTAG
                    + TDEnd
                + TRowEnd

                + TRowSt
                    + TDSt +
                         A["MOC"].AttributeName
                     + TDEnd
                  + TDSt +
                        A["MOC"]._HTMLTAG
                    + TDEnd
                        + TDSt +
                           A["Type"].AttributeName
                       + TDEnd
                       + TDSt +
                          A["Type"]._HTMLTAG
                       + TDEnd
                 + TRowEnd

                   + TRowSt
                         + TDSt +
                           A["Colour Generic"].AttributeName
                        + TDEnd
                        + TDSt +
                           A["Colour Generic"]._HTMLTAG
                        + TDEnd
                       + TDSt +
                           A["Colour Code"].AttributeName
                        + TDEnd
                        + TDSt +
                            A["Colour Code"]._HTMLTAG
                        + TDEnd
                  + TRowEnd

        + TRowSt
                + TDSt +
                        A["Size"].AttributeName
                 + TDEnd
                + TDSt +
                        A["Size"]._HTMLTAG
                 + TDEnd

                + TDEnd
     + TRowEnd

                    + "<tr class='lh30'>"
                        + "<td colspan='4' class='bg-white bold'>"
                         + "<span>" + A["Temple Details"].AttributeName + "</span>"
                        + TDEnd
                    + TRowEnd

                    + TRowSt
                        + TDSt +
                // A["TempleMoc"].AttributeName
                            DisplayTxtSunGlasTempleMoc
                        + TDEnd
                        + TDSt +
                             A["TempleMoc"]._HTMLTAG
                         + TDEnd
                         + TDSt +
                //A["TempleColour"].AttributeName

            DisplayTxtSunGlasFrameTempleColor

                         + TDEnd
                        + TDSt +
                            A["TempleColour"]._HTMLTAG
                        + TDEnd
                   + TRowEnd

                   + TRowSt
                        + TDSt +
                //A["TempleSize"].AttributeName
                            DisplayTxtSunGlasFrameTempleSize
                          + TDEnd
                     + TDSt +
                            A["TempleSize"]._HTMLTAG
                    + TDEnd
                        + "<td colspan='2'>"
                            + "&nbsp;"
                        + "</td>"
                  + TRowEnd

                   + TRowSt
                       + TDSt +
                           A["Description"].AttributeName
                     + TDEnd
                          + TDSt +
                             A["Description"]._HTMLTAG
                            + TDEnd
                        + "<td colspan='2'>"
                         + TDEnd
                  + TRowEnd


                    + "<tr class='lh40'>"
                        + "<td colspan='4' class='a-center'>"
                            + A["SAVE"]._HTMLTAG
                         + TDEnd
                    + TRowEnd
                TableEnd
                $("#tbl2").append(FramesSchema);

            }

            if (popvalue == 'True') {
                CategoryPopUp();
            }
        }
        function DepartmentGroupBasedHideShow() {

            var ddlDeptValue = $("#ddlDeptGroup option:selected").val();

            switch (ddlDeptValue) {
                case "HIS":

                    $("#tdPackSize").removeClass("displaytd").addClass("hide");
                    $("#tdPackSize01").removeClass("displaytd").addClass("hide");
                    $("#tdShelfLifel").removeClass("displaytd").addClass("hide");
                    $("#tdShelfLifel01").removeClass("displaytd").addClass("hide");

                    $("#tdConsign").removeClass("hide").addClass("displaytd");
                    $("#tdSTF").removeClass("hide").addClass("displaytd");
                    $("#tdSTF01").removeClass("hide").addClass("displaytd");
                    $("#tdConReOrderLeveltxt").removeClass("displaytd").addClass("hide");
                    $("#tdConReOrderLevel").removeClass("displaytd").addClass("hide");


                    break;
                case "LIS":

                    $("#tdPackSize").removeClass("hide").addClass("displaytd");
                    $("#tdPackSize01").removeClass("hide").addClass("displaytd");
                    $("#tdShelfLifel").removeClass("hide").addClass("displaytd");
                    $("#tdShelfLifel01").removeClass("hide").addClass("displaytd");
                    $("#tdConReOrderLeveltxt").removeClass("hide").addClass("displaytd");
                    $("#tdConReOrderLevel").removeClass("hide").addClass("displaytd");

                    $("#tdConsign").removeClass("displaytd").addClass("hide");
                    $("#tdSTF").removeClass("displaytd").addClass("hide");
                    $("#tdSTF01").removeClass("displaytd").addClass("hide");

                    break;
                case "BOTH":

                    $("#tdPackSize").removeClass("hide").addClass("displaytd");
                    $("#tdPackSize01").removeClass("hide").addClass("displaytd");
                    $("#tdShelfLifel").removeClass("hide").addClass("displaytd");
                    $("#tdShelfLifel01").removeClass("hide").addClass("displaytd");
                    $("#tdConReOrderLeveltxt").removeClass("hide").addClass("displaytd");
                    $("#tdConReOrderLevel").removeClass("hide").addClass("displaytd");

                    $("#tdConsign").removeClass("hide").addClass("displaytd");
                    $("#tdSTF01").removeClass("hide").addClass("displaytd");
                    $("#tdSTF").removeClass("hide").addClass("displaytd");

                    break;
                default:
                    return false;

            }
            return false;
        }

        </script>

        <div class="contentdata">
            <div class="ionTabs w-98p marginauto" id="tabs_1" data-name="Tabs_Group_name">
                <ul class="ionTabs__head">
                    <li id="li1" class="ionTabs__tab bold active" data-target="Products"><span>
                        <asp:Label ID="Label2" runat="server" Text="Products" meta:resourcekey="lblProducts"></asp:Label>
                    </span></li>
                    <li id="li2" class="ionTabs__tab bold" data-target="GenericName"><span>
                        <asp:Label ID="Label3" runat="server" Text="Generic Name" meta:resourcekey="lblGeneric"></asp:Label>
                    </span></li>
                    <li id="li3" class="ionTabs__tab bold" data-target="Manufacturer"><span>
                        <asp:Label ID="Label4" runat="server" Text="Manufacturer" meta:resourcekey="lblManufacturer"></asp:Label>
                    </span></li>
                </ul>

                <%--<div id='TabsMenu1' class="w-100p hide">
            <ul>
                <li id="li1" class="active" onclick="DisplayTab('dvHead_1')"><a href='#'><span>
                    <asp:Label ID="lblProducts" runat="server" Text="Products" meta:resourcekey="lblProducts"></asp:Label></span></a></li>
                <li id="li2" onclick="DisplayTab('dvHead_2')"><a href='#'><span>
                    <asp:Label ID="lblGeneric" runat="server" Text="Generic Name" meta:resourcekey="lblGeneric"></asp:Label></span></a></li>
                <li id="li3" onclick="DisplayTab('dvHead_3')"><a href='#'><span>
                    <asp:Label ID="lblManufacturer" runat="server" Text="Manufacturer" meta:resourcekey="lblManufacturer"></asp:Label></span></a></li>
            </ul>
        </div>--%>
                <div class="ionTabs__body">
                    <div id="dvBody_1" data-name="Products" runat="server" class="ionTabs__item" style="padding: 3px 10px;">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel2" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter">
                                        </div>
                                        <div class="a-center" id="processMessage">
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                            <br />
                                            <br />
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/PlatForm/Images/working.gif"
                                                meta:resourcekey="imgProgressbarResource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <table class="clearLeft w-100p">
                                    <tr>
                                        <td>
                                            <div id="divProductSearch" runat="server">
                                                <table class="w-100p searchPanel">
                                                    <tr class="panelHeader">
                                                        <td class="a-left lh20">
                                                            <div id="ACX2OPPmt" runat="server">
                                                                <img src="../PlatForm/Images/ShowBids.gif" alt="Show" class="v-top pointer pull-right"
                                                                    onclick="showResponsesRow('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);" />
                                                                <span class="pointer" onclick="showResponsesRow('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);">
                                                                    <asp:Label ID="Rs_ProductSearch" Text="Product Search" runat="server" meta:resourcekey="Rs_ProductSearchResource1"></asp:Label></span>
                                                            </div>
                                                            <div id="ACX2minusOPPmt" runat="server" class="hide">
                                                                <img src="../PlatForm/Images/HideBids.gif" alt="hide" class="v-top pointer pull-right"
                                                                    onclick="showResponsesRow('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);" />
                                                                <span class="pointer" onclick="showResponsesRow('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);">
                                                                    <asp:Label ID="Rs_ProductSearch1" Text="Product Search" runat="server" meta:resourcekey="Rs_ProductSearch1Resource1"></asp:Label>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr class="hide lh25" id="ACX2responsesOPPmt" runat="server">
                                                        <td id="Td1" runat="server">
                                                            <uc1:ProductSearch ID="ProductSearch1" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:GridView ID="gvProduct" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductID,InHandQuantity"
                                                OnRowCommand="gvProduct_RowCommand" CssClass="searchPanel responstable w-100p" AllowPaging="True"
                                                OnPageIndexChanging="gvProduct_PageIndexChanging" OnRowDataBound="gvProduct_RowDataBound"
                                                meta:resourcekey="gvProductResource1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No." meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="ParentProductKey" HeaderText="Product Code" meta:resourcekey="BoundFieldResource8" />
                                                    <asp:BoundField DataField="ProductName" HeaderText="Product" meta:resourcekey="BoundFieldResource1" />
                                                    <asp:BoundField DataField="CategoryName" HeaderText="Category" meta:resourcekey="BoundFieldResource2" />
                                                    <asp:BoundField DataField="Description" HeaderText="Description" meta:resourcekey="BoundFieldResource3" />
                                                    <asp:BoundField DataField="PrescriptionNO" HeaderText="Make" meta:resourcekey="BoundFieldResource4" />
                                                    <asp:BoundField DataField="IsScheduleHDrug" Visible="False" HeaderText="ScheduleH Drug"
                                                        meta:resourcekey="BoundFieldResource5" />
                                                    <asp:BoundField DataField="FeeType" HeaderText="Product Type" meta:resourcekey="BoundFieldResource6" />
                                                    <asp:BoundField DataField="ReferenceNo" HeaderText="Generic Name" meta:resourcekey="BoundFieldResource7" />
                                                    <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnEdit" CommandName="productEdit" CommandArgument='<%# Container.DataItemIndex %>'
                                                                runat="server" Text="Edit" CssClass="ui-icon ui-icon-pencil marginL5 b-none pointer pull-left"
                                                                meta:resourcekey="btnEditResource1" />
                                                            <asp:LinkButton ID="btnDelete" CommandName="productDelete" CommandArgument='<%# Container.DataItemIndex %>'
                                                                runat="server" Text="Delete" class=" pointer pull-left" meta:resourcekey="btnDeleteResource1" />
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="a-left" />
                                                        <ItemStyle CssClass="a-left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="History" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="btnHistory" CssClass="ui-icon ui-icon-info b-none pointer pull-left"
                                                                runat="server" Text="H" CommandArgument='<%# Container.DataItemIndex %>' CommandName="History"
                                                                meta:resourcekey="btnHistoryResource1" />
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="a-center" />
                                                        <ItemStyle CssClass="a-center" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle CssClass="gridPager a-center" />
                                                <HeaderStyle CssClass="gridHeader" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                                <table class="w-100p searchPanel lh25" id="tblEditcolumn" runat="server">
                                    <tr class="panelContent">
                                        <td id="tdMsg" colspan="4" class="a-center" runat="server">
                                            <asp:Label ID="lblmsg" runat="server" CssClass="bold" meta:resourcekey="lblmsgResource1"></asp:Label>
                                            <asp:HiddenField ID="hdnInHandQty" runat="server" />
                                            <input type="hidden" id="hdnStatus" runat="server" />
                                            <input id="hdnCatid" runat="server" type="hidden" />
                                            <input id="hdnpName" runat="server" type="hidden" />
                                            <input id="hndCatName" runat="server" type="hidden" />
                                            <input id="hdnPrname" runat="server" type="hidden" />
                                            <input id="hdnattrip" runat="server" type="hidden" value="N" />
                                            <input id="hdnGenericID" runat="server" type="hidden" value="0" />
                                        </td>
                                    </tr>
                                    <tr class="panelContent">
                                        <td class="w-13p">
                                            <asp:Label ID="lblDeptGroup" runat="server" Text="Department Group" meta:resourcekey="lblDeptGroupResource1"> </asp:Label>
                                        </td>
                                        <td class="w-20p">
                                            <asp:DropDownList ID="ddlDeptGroup" runat="server" onchange="return DepartmentGroupBasedHideShow();"
                                                CssClass="medium" meta:resourcekey="ddlDeptGroupResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td class="a-left w-13p">
                                            <asp:Label ID="lblGenericName" Text="Generic Name" runat="server" meta:resourcekey="lblGenericNameResource1"></asp:Label>
                                        </td>
                                        <td class="w-20p">
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtGenericName"
                                                runat="server" MaxLength="50" CssClass="medium bg-searchimage" meta:resourcekey="txtGenericNameResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtenderGeneric" runat="server" TargetControlID="txtGenericName"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                OnClientItemSelected="SelectGeneric" MinimumPrefixLength="1" CompletionInterval="1"
                                                FirstRowSelected="True" ServiceMethod="GetSearchGenericList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                DelimiterCharacters="" Enabled="True">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                        <td class="a-left w-13p">
                                            <asp:Label ID="Rs_ProductName" Text="Product Name" runat="server" meta:resourcekey="Rs_ProductNameResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtProductName"
                                                runat="server" MaxLength="255" CssClass="medium bg-searchimage" meta:resourcekey="txtProductNameResource1"
                                                onBlur="return ConverttoUpperCase(this.id);"></asp:TextBox>
                                            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                            <ajc:AutoCompleteExtender ID="AutoCompleteProduct1" runat="server" CompletionInterval="1"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                CompletionListItemCssClass="wordWheel itemsMain" EnableCaching="False" FirstRowSelected="True"
                                                MinimumPrefixLength="2" ServiceMethod="GetSearchProductList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                TargetControlID="txtProductName" DelimiterCharacters="" Enabled="True" OnClientItemSelected="ProductsItemSelected"
                                                BehaviorID="AutoCompleteProduct1">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr class="panelContent">
                                        <td class="a-left">
                                            <asp:Label ID="lblProductCode" runat="server" Text="Product Code" meta:resourcekey="lblProductCodeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtProductCode"
                                                runat="server" CssClass="medium" meta:resourcekey="txtProductCodeResource1"></asp:TextBox>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="Rs_Type" Text="Type" runat="server" meta:resourcekey="Rs_TypeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlType" runat="server" CssClass="medium" meta:resourcekey="ddlTypeResource1">
                                            </asp:DropDownList>
                                            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="Rs_CategoryName" runat="server" meta:resourcekey="Rs_CategoryNameResource1"
                                                Text="Category Name"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="medium" meta:resourcekey="ddlCategoryResource1"
                                                onblur="javascript:return SetTax();">
                                            </asp:DropDownList>
                                            <img class="a-center" alt="" src="../PlatForm/Images/starbutton.png" />
                                        </td>
                                        <td>
                                            <input type="button" id="btnpopupClick" class="btn" runat="server" value="Edit Attributes"
                                                onclick="javascript: CategoryPopUpValue();" />
                                        </td>
                                    </tr>
                                    <tr class="panelContent">
                                        <td class="a-left">
                                            <asp:Label ID="lblMake" runat="server" Text="Make / Brand" meta:resourcekey="lblMakeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtMake" runat="server"
                                                CssClass="medium" meta:resourcekey="txtMakeResource1"></asp:TextBox>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="Rs_ManufactureName" Text="Manufacturer Name" runat="server" meta:resourcekey="Rs_ManufactureNameResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtMfgName" runat="server"
                                                CssClass="medium bg-searchimage" meta:resourcekey="txtMfgNameResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteProduct2" runat="server" CompletionInterval="1"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                CompletionListItemCssClass="wordWheel itemsMain" EnableCaching="False" FirstRowSelected="True"
                                                OnClientItemSelected="SelectManufacturer" MinimumPrefixLength="2" ServiceMethod="GetManufacturer"
                                                ServicePath="~/InventoryMaster/Webservice/InventoryMaster.asmx" TargetControlID="txtMfgName"
                                                DelimiterCharacters="" Enabled="True">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="Rs_ManufactureCode" Text="Manufacturer Code" runat="server" meta:resourcekey="Rs_ManufactureCodeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtMfgCode" runat="server"
                                                CssClass="medium" meta:resourcekey="txtMfgCodeResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr class="panelContent">
                                        <td class="a-left">
                                            <asp:Label ID="lblUnit" runat="server" Text="Least Sellable Unit" meta:resourcekey="lblUnitResource1"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:DropDownList ID="bUnits" runat="server" CssClass="medium" meta:resourcekey="bUnitsResource1" />
                                            <img class="a-center" alt="" src="../PlatForm/Images/starbutton.png" />
                                        </td>
                                        <td class="a-left v-top" id="tdlbltax" runat="server">
                                            <asp:Label ID="lblTax" runat="server" Text="GST Percentage" meta:resourcekey="lblTaxResource1"></asp:Label>
                                            <asp:Label class="hide" ID="lblTaxPercentage" runat="server" Text="Tax Percentage" meta:resourcekey="lblTaxPercentageResource1"></asp:Label>
                                        </td>
                                        <td class="v-top" id="tdtxttax" runat="server">
                                            <asp:DropDownList ID="ddlTaxtype" runat="server" CssClass="medium pull-left" meta:resourcekey="bUnitsResource1" />
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="TxtTax" runat="server"
                                                CssClass="smaller pull-left hide" onkeydown="return validatenumber(event);" OnBlur="return doValidatePercent(this);"
                                                meta:resourcekey="TxtTaxResource1">0</asp:TextBox>
                                            %
                                           <img id="imgMandatory" src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                        </td>

                                        <td class="a-left v-top">
                                            <asp:Label ID="Rs_Description" CssClass="paddingL3" runat="server" meta:resourcekey="Rs_DescriptionResource1"
                                                Text="Description"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtDescription"
                                                runat="server" meta:resourcekey="txtDescriptionResource1" TextMode="MultiLine"
                                                class="medium h-21-imp"></asp:TextBox>
                                        </td>
                                    </tr>

                                    <tr class="panelContent">
                                        <td>
                                            <asp:Label ID="lblScheduleDrug" CssClass="paddingL3" Text="Is ScheduledDrug" runat="server"
                                                meta:resourcekey="lblScheduleDrugResource1" />
                                        </td>
                                        <td>
                                            <div id="divScheduledrug" runat="server">
                                                <asp:DropDownList ID="ddlScheduleDrug" runat="server" CssClass="medium" meta:resourcekey="ddlScheduleDrugResource1">
                                                </asp:DropDownList>
                                            </div>
                                        </td>
                                        <%--vijayaraja--%>
                                        <td>
                                            <asp:Label ID="Label5" CssClass="paddingL3" Text="HSN Code" runat="server" meta:resourcekey="txtHsnCodeResource1"/>
                                        </td>
                                        <td>
                                             <asp:TextBox ID="txtHsnCode" runat="server" CssClass="small" MaxLength="8" placeholder="Max Length 8 Char"></asp:TextBox>
                                        </td>
                                        <%--end--%>
                                    </tr>
                                    <tr class= "panelContent" >
                                        <td class="a-left hide" id="tdPackSize" >
                                            <asp:Label runat="server" ID="lblPackSize" Text="Test/Pack Count" meta:resourcekey="lblPackSizeResource1"></asp:Label>
                                        </td>
                                        <td class="a-left hide" id="tdPackSize01" >
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtPackSize" MaxLength="3"
                                                runat="server" Text="0" onblur="checkGreaterThanZero(this);" onKeyDown="return  isNumeric(event,this.id)"
                                                CssClass="medium" meta:resourcekey="txtPackSizeResource1"></asp:TextBox>
                                            <img class="hide" id="imgrange" runat="server" src="../PlatForm/Images/starbutton.png" />
                                        </td>
                                        <td id="tdShelfLifel" class="hide">
                                            <asp:Label ID="lblShelfLife" runat="server" Text="Shelf Life" meta:resourcekey="lblShelfLifeResource1"></asp:Label>
                                        </td>
                                        <td id="tdShelfLifel01" class="hide"> 
                                            <asp:TextBox ID="txtshelfLife" onkeydown="return validatenumber(event);" runat="server"
                                                MaxLength="4" class="mini" meta:resourcekey="txtshelfLifeResource1"></asp:TextBox>
                                            <asp:DropDownList ID="ddlShelfLife" runat="server" CssClass="w-145" meta:resourcekey="ddlShelfLifeResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td id="tdConReOrderLevel" class="hide">
                                          <asp:Label ID="lblConReOrderLevel" runat="server" Text="Reorder Consumption level" meta:resourcekey="lblConReOrderLevel"></asp:Label>
                                        </td>
                                        <td id="tdConReOrderLeveltxt" class="hide">
                                          <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtConReOrderLevel" MaxLength="3"
                                                runat="server" Text="0" onblur="checkGreaterThanZero(this);" onKeyDown="return  isNumeric(event,this.id)"
                                                CssClass="medium" meta:resourcekey="txtConReOrderLevel"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="trAsset1" class="hide panelContent">
                                        <td class="a-left">
                                            <asp:Label ID="lblProductModel" CssClass="paddingL3" Text="Product Model" runat="server"
                                                meta:resourcekey="lblProductModelResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtProductModel"
                                                runat="server" CssClass="medium" meta:resourcekey="txtProductModelResource1"></asp:TextBox>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="lblLTofProduct" CssClass="paddingL3" Text="Life Time of Product" runat="server"
                                                meta:resourcekey="lblLTofProductResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtLTofProduct"
                                                MaxLength="3" runat="server" onKeyDown="return  isNumeric(event,this.id)" CssClass="tiny"
                                                meta:resourcekey="txtLTofProductResource1"></asp:TextBox>
                                            <asp:Label ID="lblLFYears" Text="Years" runat="server" meta:resourcekey="lblLFYearsResource1"></asp:Label>
                                        </td>
                                        <td colspan="2"></td>
                                    </tr>
                                    <tr class="panelContent">
                                        <td colspan="6">
                                            <div id="dvBody_4" runat="server" class="hide">
                                                <uc9:AddProductAttributes ID="ucProductAttributes" runat="server"></uc9:AddProductAttributes>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="panelContent">
                                        <%--<td class="a-left" id="tdSTF">
                                <asp:Label runat="server" ID="lblSTF" Text="Stock Taking Frequency" meta:resourcekey="lblSTFResource1"></asp:Label>
                            </td>
                            <td id="tdSTF01">
                                <asp:RadioButtonList ID="rblStockTakingFrequency" runat="server" RepeatDirection="Horizontal"
                                    meta:resourcekey="rblStockTakingFrequencyResource1">
                                </asp:RadioButtonList>
                            </td>--%>
                                        <td align="left" id="tdConsign">
                                            <div id="divConsign" runat="server" class="hide">
                                                <asp:CheckBox ID="ChkIsConsign" CssClass="marginL0" runat="server" Text="Is Consignment"
                                                    meta:resourcekey="ChkIsConsignResource1" />
                                            </div>
                                        </td>

                                        <td id="tdNorcotic">
                                            <asp:CheckBox ID="cheIsNorcotic" runat="server" Text="IsNarcotic" meta:resourcekey="cheIsNorcoticResource1" />
                                        </td>

                                        <td class="hide" id="tddelete" runat="server">
                                            <asp:CheckBox ID="chkisactive" runat="server" Text="IsActive" Checked="true" meta:resourcekey="chkisdeleteResource1" />
                                        </td>
                                        <td id="tdTransblock" runat="server" class="hide">
                                            <asp:CheckBox ID="ChkTransblock" runat="server" Text="Is Banned Item " meta:resourcekey="ChkTransblockResource1" />
                                        </td>
                                    </tr>

                                    <tr class="panelContent">
                                        <td colspan="6">
                                            <fieldset class="scheduler-border">
                                                <legend class="scheduler-border">
                                                    <asp:Label ID="lblProductUOM" runat="server" Text="Product UOM" meta:resourcekey="lblProductUOMResource1">
                                                    </asp:Label>
                                                </legend>
                                                <table class="w-100p">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblOrdUnit" runat="server" Text="Ordered Unit" meta:resourcekey="lblOrdUnitResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlOrdUnit" runat="server" CssClass="medium" meta:resourcekey="ddlOrdUnitResource1" />
                                                            <img class="a-center" alt="" src="../PlatForm/Images/starbutton.png" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblcontainer" runat="server" Text="Conversion Qty" meta:resourcekey="lblcontainerResource1">
                                                            </asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtContainer" runat="server" MaxLength="4" CssClass="medium" onkeydown="return validatenumber(event);"
                                                                meta:resourcekey="txtContainerResource1"></asp:TextBox>
                                                            <img class="a-center" alt="" src="../PlatForm/Images/starbutton.png" />
                                                        </td>

                                                        <td>
                                                            <button id="btnAddUom" class="btn" value="Add" onclick="return BindProductUOMList();" meta:resourcekey="btnAddLocation">
                                                                <%=(Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_02==null?"Add":Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_02) %>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </table>

                                                <table id="tblProductUOM" class="responstable w-100p font11 a-left">
                                                </table>


                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr class="panelContent">
                                        <td colspan="6">
                                            <fieldset class="scheduler-border">
                                                <legend class="scheduler-border">
                                                    <asp:Label ID="lblAttributes" runat="server" Text="Attributes" meta:resourcekey="lblAttributesResource1"></asp:Label>
                                                </legend>
                                                <div id="divProductAttributes" runat="server" class="w-100p">
                                                </div>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr class="panelContent">
                                        <td colspan="6">
                                            <fieldset class="scheduler-border">
                                                <legend class="scheduler-border">
                                                    <asp:Label ID="Label1" runat="server" Text="Mapping Location" meta:resourcekey="Label1Resource1"></asp:Label>
                                                </legend>
                                                <div id="divLocation" class="marginB10" runat="server">
                                                    <table id="tblLocation" class="w-100p">
                                                        <tr>
                                                            <td>
                                                                <div id="divLocationItem" runat="server">
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblOrgName" runat="server" Text="Organization" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtOrgName" onkeydown="javascript:return Checkorgtext();"
                                                                                    CssClass="medium bg-searchimage" runat="server" meta:resourcekey="txtOrgNameResource1"></asp:TextBox>
                                                                                <ajc:AutoCompleteExtender ID="AutoOrgName" runat="server" TargetControlID="txtOrgName"
                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                    OnClientItemSelected="SelectOrganization" MinimumPrefixLength="1" CompletionInterval="1"
                                                                                    FirstRowSelected="True" ServiceMethod="GetSearchLocationList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                                                    DelimiterCharacters="" Enabled="True" OnClientPopulated="ChangeTxtBoxWidthDynamic">
                                                                                </ajc:AutoCompleteExtender>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblLocationName" runat="server" Text="Location" meta:resourcekey="lblLocationNameResource1"></asp:Label>
                                                                            </td>
                                                                            <td>

                                                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtLocationName"
                                                                                    CssClass="medium" onkeydown="javascript:return CheckorgLocationtext();" runat="server"
                                                                                    meta:resourcekey="txtLocationNameResource1"></asp:TextBox><img id="img1" src="../PlatForm/Images/starbutton.png"
                                                                                        alt="" />


                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderLocation" runat="server" TargetControlID="txtLocationName"
                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                    OnClientItemSelected="SelectLocation" MinimumPrefixLength="1" CompletionInterval="1"
                                                                                    FirstRowSelected="True" ServiceMethod="GetSearchLocationList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                                                    DelimiterCharacters="" Enabled="True" OnClientPopulated="ChangeTxtBoxWidthDynamiclocat">
                                                                                </ajc:AutoCompleteExtender>


                                                                            </td>

                                                                            <td>
                                                                                <asp:Label ID="lblDefaultIntendLocation" runat="server" Text="DefaultIntendLocation" meta:resourcekey="lblDefaultIntendLocationResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="a-left">

                                                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtDefaultIntendLocation"
                                                                                    CssClass="medium" onkeydown="javascript:return CheckorgLocationtext();" onchange="return onChangeDefaultIntendLocation();" runat="server"
                                                                                    meta:resourcekey="txtDefaultIntendLocationResource1"></asp:TextBox>

                                                                                <ajc:AutoCompleteExtender ID="acetxtDefaultIntendLocation" runat="server" TargetControlID="txtDefaultIntendLocation"
                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                    OnClientItemSelected="SelectIndentLocation" MinimumPrefixLength="1" CompletionInterval="1"
                                                                                    FirstRowSelected="True" ServiceMethod="GetSearchLocationList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                                                    DelimiterCharacters="" Enabled="True">
                                                                                </ajc:AutoCompleteExtender>


                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblReOrderLevel" runat="server" Text="Re-Order Level(LSU)" meta:resourcekey="lblReOrderLevelResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtReOrderLevel"
                                                                                    runat="server" CssClass="mini" MaxLength="4" onKeyDown="return validatenumber(event);"
                                                                                    Text="0" meta:resourcekey="txtReOrderLevelResource1"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblMaxQTY" runat="server" Text="Max.Qty(LSU)"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtMaxQTY" runat="server"
                                                                                    CssClass="mini" MaxLength="4" onKeyDown="return validatenumber(event);" Text="0"> </asp:TextBox>
                                                                            </td>
                                                                            <td class="a-left" id="tdSTF">
                                                                                <asp:Label runat="server" ID="lblSTF" Text="Stock Taking Frequency" meta:resourcekey="lblSTFResource1"></asp:Label>
                                                                            </td>
                                                                            <td id="tdSTF01">
                                                                                <asp:RadioButtonList ID="rblStockTakingFrequency" runat="server" RepeatDirection="Horizontal"
                                                                                    meta:resourcekey="rblStockTakingFrequencyResource1">
                                                                                </asp:RadioButtonList>
                                                                            </td>
                                                                            <td>
                                                                                <button runat="server" id="btnAddLocation" class="btn" value="Add" tabindex="90"
                                                                                    meta:resourcekey="btnAddLocation" onclick="return checkLocation();">
                                                                                    <%=(Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_02==null?"Add":Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_02) %>
                                                                                </button>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Table CssClass="w-100p responstable lh20" runat="server" ID="tblLocationlist" meta:resourcekey="tblLocationlistResource1">
                                                                </asp:Table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <input type="hidden" id="hdnLocationID" value="0" runat="server" />
                                                    <input type="hidden" id="hdnIndentLocationID" value="0" runat="server" />
                                                    <input type="hidden" id="hdnLocationName" runat="server" />
                                                    <input type="hidden" id="hdnProductUomList" runat="server" />
                                                    <input id="hdnLocationList" runat="server" type="hidden" />
                                                    <input id="hdnLocRowEdit" runat="server" type="hidden" />
                                                </div>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr class="">
                                        <td colspan="6" class="a-center paddingB10">
                                            <asp:Button ID="btnFinish" Text="Save" runat="server" CssClass="btn" OnClientClick="javascript:return checkDetails();"
                                                OnClick="btnFinish_Click" meta:resourcekey="btnFinishResource1" />
                                            <asp:Button ID="btnCancel" OnClientClick="javascript:return FnClear();" runat="server"
                                                Text="Clear" CssClass="cancel-btn" OnClick="btnClear_Click" meta:resourcekey="btnCancelResource1" />
                                            <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                </table>
                                <asp:Panel ID="pnlAddAttribute" runat="server" CssClass="modalPopup dataheaderPopup hide"
                                    meta:resourcekey="pnlAddAttributeResource1">
                                    <div>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="ackliteral">
                                                    <asp:Literal ID="ltrAckMessage" runat="server" Visible="False" meta:resourcekey="ltrAckMessageResource1"></asp:Literal>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="auto">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td class="a-center">
                                                    <asp:Button ID="btnAttributeOk" runat="server" Text="OK" CssClass="btn" meta:resourcekey="btnAttributeOkResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                                <div id="DivEditWindow" runat="server">
                                    <table id="Table1" runat="server" class="w-100p modalPopup dataheaderPopup">
                                        <tr>
                                            <td>
                                                <adh1:Audit_History ID="audit_History" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-center">
                                                <asp:Button ID="btnOk" runat="server" Text="OK" CssClass="btn" meta:resourcekey="btnOkResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <ajc:ModalPopupExtender ID="ModelPopProductSearch" runat="server" TargetControlID="btnR"
                                    PopupControlID="DivEditWindow" BackgroundCssClass="modalBackground" CancelControlID="btnOk"
                                    DynamicServicePath="" Enabled="True" />
                                <input type="button" id="btnR" runat="server" class="hide" />
                                <ajc:ModalPopupExtender ID="mpeAddAttribute" runat="server" TargetControlID="btnDummy"
                                    PopupControlID="pnlAddAttribute" BackgroundCssClass="modalBackground" CancelControlID="btnAttributeOk"
                                    DynamicServicePath="" Enabled="True" />
                                <input type="button" id="btnDummy" runat="server" class="hide" />
                                <asp:HiddenField ID="hdnProductList" runat="server" Value="" />
                                <asp:HiddenField ID="hdnCatTax" runat="server" Value="" />
                                <asp:HiddenField ID="hdnGetTax" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnAttributes" runat="server" Value="" />
                                <asp:HiddenField ID="hdnPackSize" runat="server" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div id="dvBody_2" data-name="GenericName" class="ionTabs__item" runat="server">
                        <div>
                        </div>
                        <uc2:AddGenericName ID="AddGenericName1" runat="server" />
                    </div>
                    <div id="dvBody_3" data-name="Manufacturer" class="ionTabs__item" runat="server">
                        <div>
                        </div>
                        <uc7:AddManufacturer ID="AddManufacturer1" runat="server"></uc7:AddManufacturer>
                    </div>
                    <div id="Framediv" class="hide bg-f5">
                        <div id="tbl1" class="w-100p h-30 bg-white">
                            <%--<table class="w-100p paddingT2">
                    <tr>
                        <td class="a-left font14 bold paddingL1 w-60p">
                            <span>Frames Setup</span>
                        </td>
                        <td class="a-right" style="margin-right: 10px;">                           
                            <input type="button" id="Button1" onclick="Closeclick()" value="X" class="btn" style="font-weight: bold;
                                border: 1px solid #fff;" />
                        </td>
                    </tr>
                </table>--%>
                        </div>
                        <div id="tbl2" class="w-100p">
                            <%-- <table class="w-99p">
                    <tr>
                        <td class="w-20p">
                            <asp:Label ID="lblFramesource" runat="server" Text="FrameName : "></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtFrameName" runat="server" CssClass="small" ToolTip="Enter Frame Name"
                                placeholder="Enter Frame Name"></asp:TextBox>
                        </td>
                        <td class="w-20p">
                            <asp:Label ID="Label4" runat="server" Text="ProdutCode : "></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="TextBox1" runat="server" CssClass="small" ToolTip="Enter ProdutCode" placeholder="Enter ProdutCode"></asp:TextBox>
                                
                        </td>
                    </tr>
                    <tr class="lh35">
                        <td>
                            <asp:Label ID="lblBlkSTime" runat="server" Text="MOC : "></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList1" CssClass="small" runat="server">
                                <asp:ListItem Value="1">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="Label5" runat="server" Text="Type : "></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList2" CssClass="small" runat="server">
                                <asp:ListItem Value="1">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="lh35">
                        <td>
                            <asp:Label ID="Label6" runat="server" Text="Model : "></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="TextBox2" runat="server" CssClass="small" ToolTip="Enter ModelName"
                                placeholder="Enter ModelName"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="Label8" runat="server" Text="Brand : "></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList4" CssClass="small" runat="server">
                                <asp:ListItem Value="1">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="lh35">
                        <td class="w-20p">
                            <asp:Label ID="Label9" runat="server" Text="Size : "></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="TextBox3" runat="server" CssClass="small" ToolTip="Enter Frame Name"
                                placeholder="Enter Frame Name"></asp:TextBox>
                        </td>
                        <td class="w-20p">
                            <asp:Label ID="Label10" runat="server" Text="Colour : "></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="TextBox4" runat="server" CssClass="small" ToolTip="Enter Color"
                                placeholder="Enter Color"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="lh30">
                        <td colspan="4" class="bg-white bold">
                            <span>Temple Details</span>
                        </td>
                    </tr>
                    <tr class="lh35">
                        <td class="w-20p">
                            <asp:Label ID="Label12" runat="server" Text="TempleMoc : "></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList5" CssClass="small" runat="server">
                                <asp:ListItem Value="1">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="w-20p">
                            <asp:Label ID="Label13" runat="server" Text="TempleColour : "></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="TextBox7" runat="server" CssClass="small" ToolTip="Enter TempleColour"
                                placeholder="Enter TempleColour"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="lh35">
                        <td>
                            <asp:Label ID="Label14" runat="server" Text="TempleSize : "></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList3" CssClass="small" runat="server">
                                <asp:ListItem Value="1">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr class="lh35">
                        <td class="w-20p">
                            <asp:Label ID="Label11" runat="server" Text="Description : "></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="TextBox5" runat="server" CssClass="large" TextMode="MultiLine" ToolTip="Enter Remarks"
                                placeholder="Remarks"></asp:TextBox>
                        </td>
                        <td colspan="2">
                        </td>
                    </tr>
                    <tr class="lh40">
                        <td colspan="4" class="a-center">
                            <input type="button" id="Button2" value="Save" class="btn" />
                        </td>
                    </tr>
                </table>--%>
                        </div>
                    </div>
                    <div id="Bck-black" class="hide">
                    </div>
                    <div class="ionTabs__preloader">
                    </div>
                </div>
            </div>
        </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnvalue" runat="server" />
        <asp:HiddenField ID="hdnLocationValue" runat="server" />
        <asp:HiddenField ID="hdnUpdateID" runat="server" Value="0" />
        <asp:HiddenField ID="hdnUpdateValue" runat="server" Value="0" />
        <asp:HiddenField ID="HiddenUpdateValue" runat="server" Value="0" />
        <asp:HiddenField ID="hdnOrgId" runat="server" Value="0" />
        <asp:HiddenField ID="hdnIsMfgFeeText" runat="server" Value="N" />
        <asp:HiddenField ID="hdnProductMand" runat="server" Value="N" />
        <asp:HiddenField ID="hdnOrdUnitConfig" runat="server" Value="N" />
        <asp:HiddenField ID="hdnCategoryClear" runat="server" />
        <asp:HiddenField ID="hdnProductIspopUP" runat="server" Value="0" />
        <asp:HiddenField ID="hdnScheduledrugValue" runat="server" Value="" />
        <input id="hdnProductID" type="hidden" value="0" />
        <input id="hdnProductUOMID" type="hidden" value="0" />

    </form>
    <%--Schedule H Drug with types added for WHC by JeniferLeo--%>
    <script src="../PlatForm/Scripts/ion.tabs.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var lstProducUOMList = [];
        var UpdateRowValue;
        var ProdctUOMReturnStatus;

        function chkScheduleDrug() {
            var schduleDrugType = '';
            $("#divScheduledrug table tr").each(function () {
                var tr = $(this).closest("tr");
                $(tr).children('td').each(function (i) {
                    var td = $(this).closest("td");
                    if ($(this).children().attr('type') == 'radio') {
                        var id = $(this).children().attr('id');
                        var chk = document.getElementById(id).checked == true ? "Y" : "N";
                        if (chk == "Y") {
                            schduleDrugType += document.getElementById(id).value;
                            $('#hdnScheduledrugValue').val(schduleDrugType);
                        }
                    }
                });
            });


        }
        function onChangeDefaultIntendLocation() {
            if ($.trim($('#txtDefaultIntendLocation').val()) == "") {
                $('#hdnIndentLocationID').val('0');
            }
        }

        function BindTblProductUOM() {
            $("#tblProductUOM tr").remove();
            var Headrow = document.getElementById('tblProductUOM').insertRow(0);
            Headrow.id = "HeadID";
            Headrow.className = "responstableHeader  w-100p"

            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            var cell4 = Headrow.insertCell(3);



            var sno = SListForAppDisplay.Get("InventoryMaster_Products_aspx_32") == null ? "Sno" : SListForAppDisplay.Get("InventoryMaster_Products_aspx_32");
            var OrderedUnit = SListForAppDisplay.Get("InventoryMaster_Products_aspx_29") == null ? "Ordered Unit" : SListForAppDisplay.Get("InventoryMaster_Products_aspx_29");
            var ConQty = SListForAppDisplay.Get("InventoryMaster_Products_aspx_30") == null ? "Conversion Qty" : SListForAppDisplay.Get("InventoryMaster_Products_aspx_30");
            var LSUnit = SListForAppDisplay.Get("InventoryMaster_Products_aspx_31") == null ? "Least Sellable Unit" : SListForAppDisplay.Get("InventoryMaster_Products_aspx_31");
            var Action = SListForAppDisplay.Get('InventoryMaster_Products_aspx_07') == null ? "Action" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_07');

            cell1.innerHTML = sno;
            cell2.innerHTML = OrderedUnit;
            cell3.innerHTML = ConQty;
            cell4.innerHTML = Action;

            var GloSno = lstProducUOMList.length;

            $.each(lstProducUOMList, function (obj, value) {
                var row = document.getElementById('tblProductUOM').insertRow(1);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);


                cell1.innerHTML = GloSno - obj;
                cell2.innerHTML = value.UOMCode;
                cell3.innerHTML = value.ConvesionQty;

                $('[name=ddlOrdUnit] option').filter(function () {
                    return ($(this).val() == value.UOMID); //To select Blue
                }).prop('selected', true);
                if (value.Action == "M") {
                    cell4.innerHTML = "<input name='Edit' onclick='btnEdit_OnClick(" + JSON.stringify(value) + ");' value = '' type='button' class='ui-icon ui-icon-pencil pull-left'  /> " +
                        "<input name='Delete' onclick='btnDelete(" + JSON.stringify(value) + ");' value = '' type='button' class='ui-icon ui-icon-trash pull-left' />";
                }
                else if (value.Action == "A") {
                    cell4.innerHTML = "<input name='Edit' onclick='btnEdit_OnClick(" + JSON.stringify(value) + ");' value = '' type='button' class='ui-icon ui-icon-pencil pull-left'  /> " +
                        "<img class='ui-icon ui-icon-circle-check marginL10 pointer pull-left' onclick='CallActiveDeActiveProductUOM(" + JSON.stringify(value) + ");'/>";
                }
                else if (value.Action == "DA") {


                    cell4.innerHTML = "<img class='ui-icon ui-icon-circle-close marginL10  pull-left' onclick='ActiveProductUOM(" + JSON.stringify(value) + ");'/>";

                }

            });

            $("#hdnProductID").val('0');
            $("#hdnProductUOMID").val('0');

            return false;
        }

        function btnEdit_OnClick(lstRow) {

            var Update = SListForAppDisplay.Get('InventoryMaster_Products_aspx_01') == null ? "Update" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_01');

            UpdateRowValue = lstRow;
            $("#btnAddUom").text(Update);
            $("#ddlOrdUnit").val(lstRow.UOMID);
            $("#txtContainer").val(lstRow.ConvesionQty);
            $("#hdnProductID").val(lstRow.ProductID);
            $("#hdnProductUOMID").val(lstRow.ProductUOMID);
            $("#ddlOrdUnit").prop("disabled", true);
            // $("#bUnits").val(lstRow.LSU);
            return false;
        }

        function btnDelete(lstRow) {

            var arrF = $.grep(lstProducUOMList, function (n, i) {
                return n.UOMID != lstRow.UOMID;
            });
            lstProducUOMList = [];
            lstProducUOMList = arrF;
            BindTblProductUOM();
            return false;
        }

        function BindProductUOMList() {
            if ($("#btnAddUom").text() == "Update") {
                $("#ddlOrdUnit").prop("disabled", false);
            }
            if (document.getElementById('bUnits').value == "0") {

                userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_04') == null ? "Select Least Sellable Unit" : SListForAppMsg.Get('InventoryMaster_Products_aspx_04');
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('bUnits').focus();
                return false;
            }

            if ($('#ddlOrdUnit').val() == "0") {
                userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_05') == null ? "Select Ordered Unit" : SListForAppMsg.Get('InventoryMaster_Products_aspx_05');
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlOrdUnit').focus();
                return false;
            }


            if ($("#txtContainer").val() == "") {
                userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_21') == null ? "Please check conversion Qty empty" : SListForAppMsg.Get('InventoryMaster_Products_aspx_21');
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtContainer').focus();
                return false;

            }

            if (Number($("#txtContainer").val()) == 0) {

                userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_22') == null ? "Please provide conversion qty is greater than zero" : SListForAppMsg.Get('InventoryMaster_Products_aspx_22');
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtContainer').focus();
                return false;

            }
            var checkExistsOrderUnit = "N"; var checkMultipleOrderUnit = "N"; var CheckDeActive = "N";

            if ($.trim($("#btnAddUom").text()) == "Add") {

                $.each(lstProducUOMList, function (n, obj) {

                    if ($.trim(obj.UOMID) == $.trim($("#ddlOrdUnit option:selected").val()) && $.trim(obj.Action) == "M") {
                        checkExistsOrderUnit = "Y";
                    }

                    if ($.trim(obj.UOMID) == $.trim($("#ddlOrdUnit option:selected").val()) && $.trim(obj.Action) == "A") {
                        CheckDeActive = "Y";
                    }

                    if ($.trim(obj.UOMID) == $.trim($("#ddlOrdUnit option:selected").val()) && $.trim(obj.Action) == "DA" ) {
                        //&& Number(obj.ConvesionQty) == Number($("#txtContainer").val())
                        checkMultipleOrderUnit = "Y";
                    }

                });
            }

            if (checkExistsOrderUnit == "Y") {
                userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_23') == null ? "Please check orderunit already exists." : SListForAppMsg.Get('InventoryMaster_Products_aspx_23');
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlOrdUnit').focus();
                return false;
            }



            if (CheckDeActive == "Y") {

                userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_24') == null ? "Please check this order unit already active." : SListForAppMsg.Get('InventoryMaster_Products_aspx_24');
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlOrdUnit').focus();
                return false;

            }

            if (checkMultipleOrderUnit == "Y") {

                userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_25') == null ? "Combination of Order unit and Quantity already exists. Please activate." : SListForAppMsg.Get('InventoryMaster_Products_aspx_25');

                ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlOrdUnit').focus();
                return false;

            }

            if ($.trim($("#btnAddUom").text()) == "Update") {

                var arrF = $.grep(lstProducUOMList, function (n, i) {
                    return n.UOMID != UpdateRowValue.UOMID;
                });
                lstProducUOMList = [];
                lstProducUOMList = arrF;
                UpdateRowValue = "";
            }


            var objProduct = new Object();
            objProduct.ProductUOMID = $("#hdnProductUOMID").val();
            objProduct.ProductID = $("#hdnProductID").val();
            objProduct.UOMCode = $("#ddlOrdUnit option:selected").text();
            objProduct.UOMID = $("#ddlOrdUnit option:selected").val();
            objProduct.ConvesionQty = $("#txtContainer").val();

            if ($.trim($("#ddlOrdUnit option:selected").text()) == $.trim($("#bUnits option:selected").text())) {
                objProduct.IsBaseunit = "true";
            }
            else { objProduct.IsBaseunit = "false"; }
            objProduct.Action = "M";
            lstProducUOMList.push(objProduct);
            BindTblProductUOM();
            $("#btnAddUom").text("Add");
            $("#txtContainer").val('');
            $('#ddlOrdUnit').val('0');
            return false;
        }
        function AssignProductUOM() {
            lstProducUOMList = [];
            lstProducUOMList = $.parseJSON($("#hdnProductUomList").val());
            BindTblProductUOM();
            return false;
        }
        function CallActiveDeActiveProductUOM(RowData) {

            CSSDItemCheck(RowData.ProductUOMID, 'ProductUOM');

            if (ProdctUOMReturnStatus == "DA" || ProdctUOMReturnStatus == "A") {

                var objProduct = new Object();
                objProduct.ProductUOMID = RowData.ProductUOMID;
                objProduct.ProductID = RowData.ProductID;
                objProduct.UOMCode = RowData.UOMCode;
                objProduct.UOMID = RowData.UOMID;
                objProduct.ConvesionQty = RowData.ConvesionQty;
                objProduct.IsBaseunit = RowData.IsBaseunit;
                objProduct.Action = ProdctUOMReturnStatus;

                var arrF = $.grep(lstProducUOMList, function (n, i) {
                    return n.ProductUOMID != RowData.ProductUOMID;
                });
                lstProducUOMList = [];
                lstProducUOMList = arrF;
                lstProducUOMList.push(objProduct);
                BindTblProductUOM();

            }
            return false;
        }

        function ActiveProductUOM(RowData) {
            var checkOrderUnit;
            $.each(lstProducUOMList, function (n, obj) {
                if ($.trim(obj.UOMID) == $.trim(RowData.UOMID) && $.trim(obj.Action) == "A") {
                    checkOrderUnit = "Y";
                }
            });

            if (checkOrderUnit == "Y") {
                userMsg = SListForAppMsg.Get('InventoryMaster_Products_aspx_26') == null ? "Please deactive the current active order unit." : SListForAppMsg.Get('InventoryMaster_Products_aspx_26');
                ValidationWindow(userMsg, errorMsg);
                return false;
            }

            CallActiveDeActiveProductUOM(RowData);
            return false;

        }



    </script>
</body>
</html>
