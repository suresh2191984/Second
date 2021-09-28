        
        /*Sathish--SupplierInfo in PurchaseOrderQty*/
      
var arrModalDiag = ["mymodaldiag1"];
var arrModalDiagClass = ["myModalclass1"];
var LsuCostPrise;  
function openModalJQ(modalId, modalClassID) {
    var modaldiag = modalId;
    var modalClassdiag = modalClassID;
    $('#' + modalClassdiag).removeClass("modalDiag-content1");
    $('#' + modalClassdiag).addClass("modalDiag-content");
    $('#' + modaldiag).removeClass("hide").addClass("modalDiag show");
}
function closeModdalDialog(modalId, modalClassID) {
    var modaldiag = modalId;
    var modalClassdiag = modalClassID;
    $('#' + modalClassdiag).addClass("modalDiag-content1");
    setTimeout(function () {
        $('#' + modaldiag).removeClass("show").addClass("hide");
    }, 700);
}
document.addEventListener('click', function (e) {
    //alert(e.target.id);
    for (i = 0; i < arrModalDiag.length; i++) {
        if (e.target.id == arrModalDiag[i]) {
            modalPopupHide(i);
        }
    }
});
$('body').keydown(function (evt) {
    if (evt.keyCode === 27) {
        for (i = 0; i < arrModalDiagClass.length; i++) {
            if ($('#' + arrModalDiagClass[i]).hasClass("modalDiag-content")) {
                modalPopupHide(i);
            }
        }
    }
});
function modalPopupHide(i) {
    var temp = i;
    $('#' + arrModalDiagClass[i]).removeClass("modalDiag-content").addClass("modalDiag-content1");
    setTimeout(function () {
        $('#' + arrModalDiag[i]).removeClass("show").addClass("hide");
    }, 700);
    //alert();
    //sleep(700);
}
var CheckState = 'N';
     function GetSuppInfo(SupId) {
         try {
             if (SupId != 0) {
                 $.each(a, function (obj, value) {
                     if (a[obj].SupplierID == SupId) {
                         $('#divSupplier').show();
                         $('#lblsupplierName').text(a[obj].SupplierName);
                         $('#lblsupplierName').prop('title', a[obj].SupplierName);
                         $('#lblVendorAddress').text(a[obj].Address1);
                         $('#lblVendorAddress').prop('title', a[obj].Address1);
                         $('#lblVendorCity').text(a[obj].City);
                         $('#lblVendorPhone').text(a[obj].Phone);
                         $('#lblEmailID').text(a[obj].EmailID);
                         $('#hdnSName').val(a[obj].SupplierID);
                        // Tblist();
                         if($('#CheckState').val()==a[obj].StateId)
                         {
                             CheckState = 'Y';
                         }
						 else
						 {
							  CheckState = 'N';
						 }
                     }
                 });
             }
             else {
                 $('#lblsupplierName').text('');
                 $('#lblsupplierName').prop('title', '');
                 $('#lblVendorAddress').text('');
                 $('#lblVendorAddress').prop('title', '');
                 $('#lblVendorCity').text('');
                 $('#lblVendorPhone').text('');
                 $('#lblEmailID').text('');
                 $('#divSupplier').hide();
                 
             }
         }
         catch (e) {
             var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_084") == null ? "Problem while choosing the Supplier.!" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
             ValidationWindow(userMsg, errorMsg);
             return false;
         }

     }
     /*Sathish--SupplierList in PurchaseOrderQty*/
     function SupplierListPopUp(obj) {
         try {
             var SupplierList = "../InventoryMaster/SupplierList.aspx?pID=" + obj + "&sID=" + $('#ddlSupplierList').val() + "&IsPopup=Y";
             newwindow = window.open(SupplierList, 'Supplier_List', 'height=450 width=800 scrollbars=yes');
             newwindow.focus();
             return false;
         }
         catch (e) {
             var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_0833") == null ? "Problem while Checking SupplierList" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");

             ValidationWindow(userMsg, errorMsg);
         }
     }
     
    function checkIsEmpty(id) {
        if (document.getElementById(id).value == '') {
            document.getElementById(id).value = parseFloat(0).toFixed(2);
            ToTargetFormat(($('#' + id)));

        }
        else {
            document.getElementById(id).value = parseFloat(document.getElementById(id).value).toFixed(2);
            ToTargetFormat(($('#' + id)));
        }

    }
    function collectValues() {
        var id;
        $('#btnGeneratePO').hide();
        if ($('#ddlSupplierList').val() == 0) {
            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_084") == null ? "Please select the supplier" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
            $('#ddlSupplierList').focus();
            $('#btnGeneratePO').show();
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        if (document.getElementById('hdnPurchaseOrderItems').value != "") {
            var x = JSON.parse($('#hdnPurchaseOrderItems').val());
        }
        else {
            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_084") == null ? "Please add any one product" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
            ValidationWindow(userMsg, errorMsg);
            $('#btnGeneratePO').show();
            return false;
        }
        document.getElementById('hdnCollectedItems').value = '';
        var lstPurchaselst = [];

        var lblFlag = true;
        $.each(x, function (obj, value) {
            id = x[obj].ID;
            var val;
            if (id == null) {
                val = 0;
            }
            else {
                val = id;
            }

            var Select = SListForAppDisplay.Get('PurchaseOrder_PurchaseOrderQuantity_aspx_01');
            if (Select == null) {
                Select = "--Select--";
            }

            value.Quantity = x[obj].Quantity;
            value.Unit = x[obj].Unit;

            if (value.ID == 0) {

                value.ID = 0;
            }
            else {
                value.ID = val;
            }


            value.ProductID = x[obj].ProductID;
            value.Discount = x[obj].Discount;
            value.Amount = x[obj].UnitCostPrice;
            value.Tax = x[obj].Tax;
            value.ComplimentQTY = x[obj].ComplimentQTY;
            value.PurchaseTax = x[obj].PurchaseTax;
            value.UnitSellingPrice = x[obj].Rate;
            value.Rate = x[obj].Total;
            value.Description = x[obj].Description;
            lstPurchaselst.push(value);

            // }
        });
        if (lblFlag == false) {
            return false;
        }
        $('#hdnCollectedItems').val(JSON.stringify(lstPurchaselst));

        if (document.getElementById('hdnCollectedItems').value == "") {

            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrderQuantity_aspx_02") == null ? "Check that the items added or quantity is provided properly" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrderQuantity_aspx_02");

            ValidationWindow(userMsg, errorMsg);
            $('#btnGeneratePO').show();
            return false;

        }
        //$('#btnGeneratePO').show();
        document.getElementById('hdnPurchaseOrderItems').value = document.getElementById('hdnCollectedItems').value;
        return true;

    }

    var dynamicColumns;
    var dynamicColumnFrames;
    var rowDataSet;
    var dynamicColumnsnumber;

    function showLocationdetails(ProductId, ProductName) {
        try {
            openModalJQ('mymodaldiag1', 'myModalclass1');
            if (ProductId != "" && ProductName != "") {
                $('#lblPNameinPopup').text('Product Name:' + ' ' + unescape(ProductName));
            }
            else {
                $('#lblPNameinPopup').text('');
            }
            $("#dvlocationDetailsTab").show();
            $("#locationDetailsTab").show();
            $("#locationDetailsTab > tbody > tr").remove();
            $("#locationDetailsTab > thead > tr").remove();
            var _OrgId = $('#hdnOrgId').val();
            var _OrgAddressId = $('#hdnOrgAddressID').val();;
            var _LocationID = $('#hdnLocationId').val();
            var Parameter = {
                ProductId: ProductId, OrgID: _OrgId, OrgAddressID: _OrgAddressId, LocationId: _LocationID
            };
            $.ajax({
                type: "POST",
                url: "../InventoryCommon/WebService/InventoryWebService.asmx/ProductwithLocationAvilableQty",
                data: JSON.stringify(Parameter),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {
                    var Items = data.d;
                    var dtDayWCR = Items;
                    if (dtDayWCR.length > 0 && dtDayWCR != "[]") {
                        // fun_BindValues(dtDayWCR);
                        var parseJSONResult = JSON.parse(dtDayWCR);
                        //Get dynmmic column.
                        dynamicColumns = [];
                        var i = 0;
                        $.each(parseJSONResult[0], function (key, value) {
                            var obj = { sTitle: key };
                            dynamicColumns[i] = obj;
                            i++;
                        });
                        //fetch all records from JSON result and make row data set.
                        rowDataSet = [];
                        var i = 0;
                        $.each(parseJSONResult, function (key, value) {
                            var rowData = [];
                            var j = 0;
                            $.each(parseJSONResult[i], function (key, value) {
                                rowData[j] = value;
                                j++;
                            });
                            rowDataSet[i] = rowData;
                            i++;
                        });
                        BindlocationDetailsTab();

                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
            return false;
        }
        catch (e) {
            alert('Problem while showing Product locations information');
        }
    }
    function BindlocationDetailsTab() {
        try {
            if (rowDataSet != null && rowDataSet.length > 0) {

                $("#locationDetailsTab> tbody > tr").remove();
                $("#locationDetailsTab > thead > tr").remove();
                $('#locationDetailsTab').dataTable({
                    "bDestroy": true,
                    // "bProcessing": true,
                    "bPaginate": false,
                    "bDeferRender": true,
                    // "bSortable": false,
                    "bJQueryUI": true,
                    "aaData": rowDataSet,
                    'bSort': false,
                    'bFilter': false,
                    "bScrollCollapse": true,
                    "bInfo": false,
                    "aoColumns": dynamicColumns,
                    'sPaginationType': 'full_numbers'
                    //"sDom": '<"H"Tfr>t<"F"ip>'
                });
            }
            return false;
        }
        catch (e) {
            alert('TEST', e);
        }
    }




    /*Sathish--PO Development In a single Screen--Start*/
    var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error') == null ? "Alert" : SListForAppMsg.Get('PurchaseOrder_Error');
    var informMsg = SListForAppMsg.Get('PurchaseOrder_Information') == null ? "Information" : SListForAppMsg.Get('PurchaseOrder_Information');
    var okMsg = SListForAppMsg.Get('PurchaseOrder_Ok') == null ? "Ok" : SListForAppMsg.Get('PurchaseOrder_Ok')
    var cancelMsg = SListForAppMsg.Get('PurchaseOrder_Cancel') == null ? "Cancel" : SListForAppMsg.Get('PurchaseOrder_Cancel');

    var datadiv_tooltip = false;
    var datadiv_tooltipShadow = false;
    var datadiv_shadowSize = 4;
    var datadiv_tooltipMaxWidth = 200;
    var datadiv_tooltipMinWidth = 100;
    var datadiv_iframe = false;
    var tooltip_is_msie = (navigator.userAgent.indexOf('MSIE') >= 0 && navigator.userAgent.indexOf('opera') == -1 && document.all) ? true : false;

    var lstPurcharseOrder = [];
    var lstProductList = [];
    var tGrandTotal = 0.00;
    var AppInterval = $("input[id$=hdnshowintervel]").val();

    function IsSelected(source, eventArgs) {

        var categoryID;
        var AddStatus = 0;
        var quantity = parseFloat(0).toFixed(2);
        var PurchaseTax = "0.00";
        var val = JSON.parse(eventArgs.get_value());
        var desc = val.StockInHand;
        var unit = val.Units;
        var lsunit = "";
        var amount = parseFloat(0).toFixed(2);
        var rate = parseFloat(0).toFixed(2);
        var CategoryName = val.CatName;
        var Product = '';
        var result = eventArgs.get_text().match(/[^[\]]+(?=])/g)
        if (result != null) {

    } else {
        Product = eventArgs.get_text();
    }
    var ProductName = Product;
    var InHandQty = 0;
    var ID = 0;
    var BatchNo = val.IsStockReceived;
    categoryID = val.CategoryID;
    $('#hdnProductId').val(val.ProductID);
    $('#hdnPdtRcvdDtlsID').val(val.ProductReceivedDetailsID);
    $('#txtTax').val(val.TaxPercent);
    ToTargetFormat($('#txtTax'));
    $("#ddlUnits").val(val.OrderedUnit);
    $('#ddlUnits option:not(:selected)').prop('disabled', true);
    LsuCostPrise = val.MaintenanceCost;
    //$('#txtUnitCost').val(val.MaintenanceCost); //UnitPrice
    ToTargetFormat($('#txtUnitCost'));
    
    var Tax = 0;
    var Discount = 0;
    var CompQty = 0;
    var ObjProduct = new Object();
    ObjProduct.ProductID = val.ProductID;
    ObjProduct.ProductName = ProductName;
    ObjProduct.CategoryID = val.CategoryID;
    ObjProduct.Unit = val.Units;
    ObjProduct.CategoryName = val.CatName;
    ObjProduct.Quantity = 0;
    ObjProduct.Description = val.StockInHand;
    $('#hdnDesc').val(ObjProduct.Description);
    ObjProduct.ID = 0;
    ObjProduct.BatchNo = "";
    ObjProduct.IsStockReceived = val.IsStockReceived;
    ObjProduct.Amount = 0;
    ObjProduct.Tax = val.TaxPercent;
    //-------------------------------------Gst
    var pTax = val.TaxPercent;
    if (CheckState == "Y") {
        CGST = pTax / 2;
        SGST = pTax / 2;
        IGST = 0

        }
        else {
            IGST = pTax;
            CGST = 0;
            SGST = 0;
        }
        $('.ww-300').html('<table class="gsttbl" border="1" rules="all"><tr><td>CGST(%)</td><td>SGST(%)</td><td>IGST(%)</td></tr><tr><td>' + CGST + '</td><td>' + SGST + '</td><td>' + IGST + '</td></tr></table>');
        //----------------------------------END
        ObjProduct.ComplimentQTY = 0;
        ObjProduct.PurchaseTax = 0;
        
        ConvertOrderUnitList(val.OrderedUnitValues, "");
        ddluintChange();
        if (lstProductList.length > 0) {

            $.each(lstProductList, function (obj, value) {
                if (val.ProductID == value.ProductID) {
                    AddStatus = 1;
                    return;
                }
            });
        }
        else {

            if (val.IsPurchaseOrder == 'Y') {

                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_07") == null ? "An order for this product has already been placed in PO. \n Do you still wish to continue?" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_07");
                if (ConfirmWindow(userMsg, informMsg, okMsg, errorMsg)) {
                }
                else {
                    return;
                }
            }
            /* var _tempList = [];
             if ($('#iconHid').val() != '') {
                 _tempList = [];
                 _tempList = JSON.parse($('#iconHid').val());
                 //lstPurcharseOrder.push( );
             }
             _tempList.push(ObjProduct);
             $('#iconHid').val(JSON.stringify(_tempList));*/
            AddStatus = 2;
        }

        if (AddStatus == 0) {

            // if (val[5] == 'Y') {
            if (val.IsPurchaseOrder == 'Y') {

                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_07") == null ? "An order for this product has already been placed in PO. \n Do you still wish to continue?" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_07");
                if (ConfirmWindow(userMsg, informMsg, okMsg, errorMsg)) {
                }
                else {
                    return;
                }
            }

            lstPurcharseOrder.push(ObjProduct);
            $('#iconHid').val(JSON.stringify(lstPurcharseOrder));
            //document.getElementById('iconHid').value += val[0] + "~" + ProductName[0] + "~" + categoryID + "~" + quantity + "~" + desc + "~" + unit + "~" + BatchNo + "~" + CategoryName + "~" + InHandQty + "~" + amount + "~" + rate + "~" + ID + "^";
        }
        else if (AddStatus == 1) {

            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08") == null ? "Product already added" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");

            ValidationWindow(userMsg, errorMsg);


            document.getElementById('txtProduct').value = '';
            document.getElementById('txtProduct').focus();
            return false;
        }

    }
    function Calcul() {
        try {

            var TotalCost;
            var Qty;
            var Price;
            var Disc;
            var Discount;
            var Discount1;
            var PurchaseTax;
            var POTax;
            var UnitCost;
            if ($('#txtQuantity').val() == "") {
                $('#txtQuantity').val('0');
                ToTargetFormat($('#txtQuantity'));
            }
            if ($('#txtUnitCost').val() == "") {
                $('#txtUnitCost').val('0.00');
                ToTargetFormat($('#txtUnitCost'));
            }
            if ($('#txtDiscount').val() == "") {
                $('#txtDiscount').val('0.00');
                ToTargetFormat($('#txtDiscount'));
            }
            if ($('#txtCompQty').val() == "") {
                $('#txtCompQty').val('0.00');
                ToTargetFormat($('#txtCompQty'));
            }
            if ($('#txtPurchaseTax').val() == "") {
                $('#txtPurchaseTax').val('0.00');
                ToTargetFormat($('#txtPurchaseTax'));
            }
            if ($('#txtTax').val() == "") {
                $('#txtTax').val('0.00');
                ToTargetFormat($('#txtTax'));
            }
                //|| $('#txtUnitCost').val() == "" ||
                //$('#txtDiscount').val() == "" ||
                //$('#txtCompQty').val() == ""
                //|| $('#txtPurchaseTax').val() == "" ||
                //$('#txtTax').val() == "") {
                
            
            PurchaseTax = ToInternalFormat($('#txtPurchaseTax'));
            if (PurchaseTax > 100) {
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_084") == null ? "Purchase tax should be equal or less than 100" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
                ValidationWindow(userMsg, errorMsg);
                $('#txtPurchaseTax').focus();
                $('#txtPurchaseTax').val('0.00');
                ToTargetFormat($('#txtPurchaseTax'));
                return false;

            }
            Disc = ToInternalFormat($('#txtDiscount'));
            if (Disc > 100) {
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_084") == null ? "Discount should be equal or less than 100" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
                ValidationWindow(userMsg, errorMsg);
                $('#txtDiscount').focus();
                ToTargetFormat($('#txtDiscount'));
                return false;

            }
            Salestax =ToInternalFormat($('#txtTax'));
            if (Salestax > 100) {
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_084") == null ? "Sales tax should be equal or less than 100" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
                ValidationWindow(userMsg, errorMsg);
                $('#txtTax').focus();
                ToTargetFormat($('#txtTax'));
                return false;

            }

            Qty = ToInternalFormat($('#txtQuantity'));
            UnitCost = ToInternalFormat($('#txtUnitCost'));
            // $('#lblTotalCost').text(Qty * UnitCost);
            parseFloat($('#lblTotalCost').text(Qty * UnitCost)).toFixed(2)
            var TotVl = parseFloat($('#lblTotalCost').text()).toFixed(2)
             ToTargetFormat($('#lblTotalCost').text(TotVl));
            Totalcost =ToInternalFormat($('#lblTotalCost'));
            Discount = ((Totalcost * Disc) / 100);
            Discount1 = Totalcost - Discount;
            if (Salestax != undefined)/* not = eqa*/ {
                POTax = ((Discount1 * Salestax)) / 100;
            }
            else {

                POTax = 0;
            }
            Totalamount = Discount1 + POTax;
            var TotV2 = Totalamount.toFixed(2);
            ToTargetFormat($('#lblTotVal').text(TotV2));
        }
        catch (e) {
            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_0833") == null ? "Problem while Calculating the TotalCost" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
            ValidationWindow(userMsg, errorMsg);
        }
    }
    function BindProductList() {
        try {

            if ($('#ddlSupplierList').val() == 0) {
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_084") == null ? "Please select the supplier" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
                $('#ddlSupplierList').focus();
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            if ($('#txtProduct').val() == "") {
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_084") == null ? "Please enter the product first" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
                ValidationWindow(userMsg, errorMsg);
                $('#txtProduct').focus();
                return false;
            }
            if ($('#txtQuantity').val() <= 0) {
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_084") == null ? "Please enter the quantity" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
                ValidationWindow(userMsg, errorMsg);
                $('#txtQuantity').focus();
                return false;
            }
            if ($('#ddlUnits').val() == "0") {
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_084") == null ? "Please enter the selling unit" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
                $('#ddlUnits').focus();
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            if ($('#txtUnitCost').val() <= 0) {
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_084") == null ? "Please enter the unit cost" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
                $('#txtUnitCost').focus();
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            var AddStatus = 0;
            var Updatebtn = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_01") == null ? "Update" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_01");
            if (document.getElementById('add').value == Updatebtn) {
                var editData = JSON.parse($('#hdnRowEdit').val());
                if (editData != "") {
                    var arrF = $.grep(lstProductList, function (n, i) {
                        return n.ProductID != editData.ProductID;
                    });
                    lstProductList = [];
                    lstProductList = arrF;
                }

            }

            var pId = document.getElementById('hdnReceivedID').value;
            var pName = $('#txtProduct').val();// document.getElementById('hdnProductName').value;
            var pProductId = $('#hdnProductId').val();

            var pQuantity = ToInternalFormat($('#txtQuantity'));
            var pUnit = document.getElementById('ddlUnits').options[document.getElementById('ddlUnits').selectedIndex].text;

            var pUnitCost = ToInternalFormat($('#txtUnitCost'));
            var pTotal = ToInternalFormat($('#lblTotalCost')); //ToTargetFormat($('#lblTotalCost'));

            var pdisCount = ToInternalFormat($('#txtDiscount'));
            var pTotalVal = ToInternalFormat($('#lblTotVal'));  //ToTargetFormat($('#lblTotVal'));

            var pCompQty = ToInternalFormat($('#txtCompQty'));
            var pPurchasTax = ToInternalFormat($('#txtPurchaseTax'));

            var Desc = $('#hdnDesc').val();
            //var pTax = ToTargetFormat($('#txtTax'));
            var pTax = ToInternalFormat($('#txtTax'));
            var objProduct = new Object();
            objProduct.ID = pId;
            objProduct.ProductName =escape(pName);
            objProduct.Quantity = pQuantity;
            objProduct.Unit = pUnit;
            objProduct.UnitCostPrice = pUnitCost;
            objProduct.Total = pTotal;
            objProduct.ProductID = pProductId;
            objProduct.Discount = pdisCount;
            objProduct.Rate = pTotalVal;
            objProduct.ComplimentQTY = pCompQty;
            objProduct.PurchaseTax = pPurchasTax;
            objProduct.Tax = pTax;
            objProduct.ProductReceivedDetailsID = $('#hdnPdtRcvdDtlsID').val();
            objProduct.Description = Desc;
            objProduct.OrderedUnitValues = ddlvalue;
            lstProductList.push(objProduct);
            $('#hdnProductList').val(JSON.stringify(lstProductList));

            Tblist();
            clearAll();
        }
        catch (e) {
            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_0833") == null ? "Problem while Adding the Product" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");

            ValidationWindow(userMsg, errorMsg);
        }
    }
    function clearAll() {
        try {
            $('#txtQuantity').val('0');
            $('#txtProduct').val('');
           
            $('#txtUnitCost').val('0');
            $('#lblTotalCost').text('0');
            $('#txtDiscount').val('0');
            $('#lblTotVal').text('0');
            $('#txtCompQty').val('0');
            $('#txtPurchaseTax').val('0');
            $('#txtTax').val('0');
            ToTargetFormat($('#txtQuantity'));
            ToTargetFormat($('#txtProduct'));
            ToTargetFormat($('#txtUnitCost'));
            ToTargetFormat($('#lblTotalCost'));
            ToTargetFormat($('#txtDiscount'));
            ToTargetFormat($('#lblTotVal'));
            ToTargetFormat($('#txtCompQty'));
            $('#add').val('Add');
            $('#txtProduct').attr('readonly', false);
            $('#ddlUnits option:not(:selected)').prop('disabled', false);
            AddRecUnitDefault();
                    
        }
        catch (e) {
            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_0833") == null ? "Problem while Clearing the Function" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");

            ValidationWindow(userMsg, errorMsg);
        }
    }
    var CGST = 0;
    var SGST = 0;
    var IGST = 0;
    function Tblist() {
        try {


            $("#tblOrederedItems tr").remove();
            var Headrow = document.getElementById('tblOrederedItems').insertRow(0);
            var Headrow1 = document.getElementById('tblOrederedItems').insertRow(1);
            var Headrow2 = document.getElementById('tblOrederedItems').insertRow(2);
            var GrandTotalRow = document.getElementById('tblOrederedItems').insertRow(3);
           // var Cell_GrandTotal;
            Headrow.id = "HeadID";
            Headrow.className = "gridHeader";
            Headrow1.className = "gridHeader";
            Headrow2.className = "gridHeader";
            var ProductName = Headrow.insertCell(0);
            ProductName.setAttribute("rowspan", 3);
            var Quantity = Headrow.insertCell(1);
            Quantity.setAttribute("rowspan", 3);
            var SellingUnits = Headrow.insertCell(2);
            SellingUnits.setAttribute("rowspan", 3);
            var UnitCost = Headrow.insertCell(3);
            UnitCost.setAttribute("rowspan", 3);
            var Total = Headrow.insertCell(4);//total without any calc of discount and PurcTax
            Total.setAttribute("rowspan", 3);
            var Discount = Headrow.insertCell(5);
            Discount.setAttribute("rowspan", 3);
            var CompQty = Headrow.insertCell(6);
            CompQty.setAttribute("rowspan", 3);
            var PurchaseTax = Headrow.insertCell(7);
            PurchaseTax.setAttribute("colspan", 6);
            var SalTax = Headrow.insertCell(8);
            SalTax.setAttribute("colspan", 6);
            var TotalCost = Headrow.insertCell(9);//total with calc of discount or PurcTax
            TotalCost.setAttribute("rowspan", 3);
            var SupplierList = Headrow.insertCell(10);
            SupplierList.setAttribute("rowspan", 3);
            var Action = Headrow.insertCell(11);
            Action.setAttribute("rowspan", 3);
            var GrandTotalHead = GrandTotalRow.insertCell(0);
            var GrandNetTotal = GrandTotalRow.insertCell(1);
            var emptytd = GrandTotalRow.insertCell(2);
            emptytd.colSpan = 2;
            GrandNetTotal.className = "nobdrright a-right";
            var CGST = Headrow1.insertCell(0);
            CGST.innerHTML = "CGST";
            CGST.setAttribute("colspan", 2);
            //Cgst.setAttribute("colspan", 2);
            var SGST = Headrow1.insertCell(1);
            SGST.innerHTML = "SGST";
            SGST.setAttribute("colspan", 2);
            //Sgst.setAttribute("colspan", 2);
            var IGST = Headrow1.insertCell(2);
            IGST.innerHTML = "IGST";
            IGST.setAttribute("colspan", 2);
            //Igst.setAttribute("colspan", 2);
            Headrow2.insertCell(0).innerHTML = "%";
            Headrow2.insertCell(1).innerHTML = "Amt";
            Headrow2.insertCell(2).innerHTML = "%";
            Headrow2.insertCell(3).innerHTML = "Amt";
            Headrow2.insertCell(4).innerHTML = "%";
            Headrow2.insertCell(5).innerHTML = "Amt";

            var ProName = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_03ww") == null ? "Product Name" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_03");
            var Qty = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_04ww") == null ? "Quantity" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_04");
            var SellUnits = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_05sss") == null ? "Selling Units" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_05");
            var UCost = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_06ss") == null ? "Unit Cost" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_06");
            var Tot = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_07ss") == null ? "Total" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_07");
            var Dis = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_08ss") == null ? "Discount(%)" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_08");
            var TotCost = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_09ss") == null ? "Total Cost" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_09");
            var CompliQty = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_03ww") == null ? "Comp.Qty" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_03");
            var PurTax = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_04ww") == null ? "Purchase Tax(%)" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_04");
            var Tax = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_04www") == null ? "Tax(%)" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_004");
            var SupplierLis = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_05sss") == null ? "Supplier List" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_05");
            var Act = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_06ss") == null ? "Action" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_06");
            var GrandTot = SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_06ss") == null ? "Grand Total" : SListForAppDisplay.Get("StockOutFlow_Scripts_StockUsage_js_06");

            ProductName.innerHTML = ProName;
           // ProductName.attr("class", "hide");
            Quantity.innerHTML = Qty;
            SellingUnits.innerHTML = SellUnits;
            UnitCost.innerHTML = UCost;
            Total.innerHTML = Tot;
            Discount.innerHTML = Dis;
            TotalCost.innerHTML = TotCost;

            CompQty.innerHTML = CompliQty;
            PurchaseTax.innerHTML = PurTax;
            PurchaseTax.className = "hide";
            SalTax.innerHTML = Tax;
            SupplierList.innerHTML = SupplierLis;
            Action.innerHTML = Act;
            GrandTotalHead.innerHTML = GrandTot;
            GrandTotalHead.colSpan = 13;
            GrandTotalHead.className = "a-right";
            
            tGrandTotal = 0;
            $.each(lstProductList, function (obj, value) {
                var row = document.getElementById('tblOrederedItems').insertRow(3);
                row.style.height = "13px";
                
                
                var Cell_ProductName = row.insertCell(0);
                var Cell_Qty = row.insertCell(1);
                var Cell_SellingUnits = row.insertCell(2);
                var Cell_UnitCost = row.insertCell(3);
                var Cell_Total = row.insertCell(4);
                var Cell_Discount = row.insertCell(5);
                var Cell_ComQty = row.insertCell(6);
                var Cell_PurchaseTax = row.insertCell(7);
                var Cell_Tax = row.insertCell(8);
                var Cell_CGSTper = row.insertCell(9);
                var Cell_CGSTamt = row.insertCell(10);
                var Cell_SGSTper = row.insertCell(11);
                var Cell_SGSTamt = row.insertCell(12);
                var Cell_IGSTper = row.insertCell(13);
                var Cell_IGSTamt = row.insertCell(14);
                var Cell_TotalVal = row.insertCell(15);
                var Cell_SupplierList = row.insertCell(16);
                var Cell_Action = row.insertCell(17);
                
                
                var objProduct = new Object();

                //Cell_ProductName.innerHTML = value.ProductName;
                // Cell_ProductName.innerHTML = "<a onmouseout='hideshowLocationdetails();' name='lnkViews' class='lnkBtn pointer' title='Click to view' href=''  >" + value.ProductName + "</a>";
                Cell_ProductName.innerHTML = '<a  id="tdProDiv"  class="lnkBtn pointer" title="Click to view" href="" onclick="return showLocationdetails(' + value.ProductID + ",'" + value.ProductName + "');\" >" +  unescape(value.ProductName) + "</a>";
                Cell_Qty.innerHTML = value.Quantity;
                Cell_Qty.id = "Cell_Qty";
                ToTargetFormat($('#Cell_Qty'));
                Cell_SellingUnits.innerHTML = value.Unit
                Cell_SellingUnits.id = "Cell_SellingUnits";
                //ToTargetFormat($('#Cell_SellingUnits'));
                Cell_UnitCost.innerHTML = value.UnitCostPrice;
                Cell_UnitCost.id = "Cell_UnitCost";
                ToTargetFormat($('#Cell_UnitCost'));
                Cell_UnitCost.className = "a-right";

                Cell_Total.innerHTML =parseFloat(value.Total).toFixed(2);
                Cell_Total.id = "Cell_Total";
                ToTargetFormat($('#Cell_Total'));
                Cell_Total.className = "a-right";

                Cell_Discount.innerHTML =parseFloat(value.Discount).toFixed(2);
                Cell_Discount.id = "Cell_Discount";
                ToTargetFormat($('#Cell_Discount'));
                Cell_Discount.className = "a-right";

                Cell_TotalVal.innerHTML =parseFloat(value.Rate).toFixed(2);
                Cell_TotalVal.id = "Cell_TotalVal";
                ToTargetFormat($('#Cell_TotalVal'));
                tGrandTotal = tGrandTotal + parseFloat(value.Rate);
                Cell_TotalVal.className = "a-right";

                Cell_ComQty.innerHTML =parseFloat(value.ComplimentQTY).toFixed(2);
                Cell_ComQty.id = "Cell_ComQty";
                ToTargetFormat($('#Cell_ComQty'));
                Cell_ComQty.className = "a-right";


                Cell_SupplierList.innerHTML = "<a class='lnkBtn pointer' href='' onclick='return SupplierListPopUp(" + value.ProductID + ");' >" + 'Supplierlist' + "</a>";
                Cell_SupplierList.className = "a-center";

                Cell_PurchaseTax.innerHTML = parseFloat(value.PurchaseTax).toFixed(2);
                Cell_PurchaseTax.id = "Cell_PurchaseTax";
                ToTargetFormat($('#Cell_PurchaseTax'));
                Cell_PurchaseTax.className = "a-right hide";

                Cell_Tax.innerHTML = parseFloat(value.Tax).toFixed(2);
                Cell_Tax.id = "Cell_Tax";
                ToTargetFormat($('#Cell_Tax'));
                Cell_Tax.className = "a-right hide";
                //Cell_Tax.attr("nowrap", "nowrap");
                //------------------------------Tax Calculation Part
                var GSTtaxamount = 0.00;
                var IGSTtaxamount = 0.00;
                var GSTTax = 0.00;
                if ($('#ddlSupplierList').val() != 0) {
                    $.each(a, function (obj, value) {
                        if (a[obj].SupplierID == $('#ddlSupplierList').val()) {
                            if ($('#CheckState').val() == a[obj].StateId) {
                                CheckState = 'Y';
                            }
                        }
                    });
                }
                if (CheckState== "Y") {
                    if (value.Tax > 0) {
                        GSTtaxamount = (parseFloat((((value.UnitCostPrice - (value.UnitCostPrice * value.Discount / 100)) * value.Tax / 100)) * value.Quantity) / 2).toFixed(2);
                        GSTTax = (parseFloat(value.Tax) / 2).toFixed(2);
                        Cell_CGSTper.innerHTML = GSTTax;
                        Cell_CGSTper.id = "Cell_CGSTper";
                        ToTargetFormat($('#Cell_CGSTper'));
                        Cell_CGSTper.className = "a-right";
                        Cell_CGSTamt.innerHTML = GSTtaxamount;
                        Cell_CGSTamt.id = "Cell_CGSTamt";
                        ToTargetFormat($('#Cell_CGSTamt'));
                        Cell_CGSTamt.className = "a-right";
                        Cell_SGSTper.innerHTML = GSTTax;
                        Cell_SGSTper.id = "Cell_SGSTper";
                        ToTargetFormat($('#Cell_SGSTper'));
                        Cell_SGSTper.className = "a-right";
                        Cell_SGSTamt.innerHTML = GSTtaxamount;
                        Cell_SGSTamt.id = "Cell_SGSTamt";
                        ToTargetFormat($('#Cell_SGSTamt'));
                        Cell_SGSTamt.className = "a-right";
                        Cell_IGSTper.innerHTML = '0.00';
                        Cell_IGSTper.id = "Cell_IGSTper";
                        ToTargetFormat($('#Cell_IGSTper'));
                        Cell_IGSTper.className = "a-right";
                        Cell_IGSTamt.innerHTML = '0.00';
                        Cell_IGSTamt.id = "Cell_IGSTamt";
                        ToTargetFormat($('#Cell_IGSTamt'));
                        Cell_IGSTamt.className = "a-right";
                    }
                }
                else {
                    IGSTtaxamount = (parseFloat((((value.UnitCostPrice - (value.UnitCostPrice * value.Discount / 100)) * value.Tax / 100)) * value.Quantity)).toFixed(2);
                    GSTTax = (parseFloat(value.Tax)).toFixed(2);
                    Cell_CGSTper.innerHTML = '0.00';
                    Cell_CGSTper.className = "a-right";
                    Cell_CGSTamt.innerHTML = '0.00';
                    Cell_CGSTamt.className = "a-right";
                    Cell_SGSTper.innerHTML = '0.00';
                    Cell_SGSTper.className = "a-right";
                    Cell_SGSTamt.innerHTML = '0.00';
                    Cell_SGSTamt.className = "a-right";
                    Cell_IGSTper.innerHTML = GSTTax;
                    Cell_IGSTper.className = "a-right";
                    Cell_IGSTamt.innerHTML = IGSTtaxamount;
                    Cell_IGSTamt.className = "a-right";
                }
                $('.ww-300').html('<table class="gsttbl" border="1" rules="all"><tr><td>CGST(%)</td><td>SGST(%)</td><td>IGST(%)</td></tr><tr><td>0</td><td>0</td><td>0</td></tr></table>');
                //-------------------------------END
                Cell_Action.innerHTML = "<input name='Edit' onclick='btnEdit_OnClick(" + JSON.stringify(value) + ");' value = '' type='button' class='ui-icon ui-icon-pencil pull-left'  /> " +
                                "<input name='Delete' onclick='btnDelete(" + JSON.stringify(value) + ");' value = '' type='button' class='ui-icon ui-icon-trash pull-left' />"
            });
            // GrandNetTotal = GrandTotalRow.insertCell(1);
           var nettot= parseFloat(tGrandTotal).toFixed(2)
           GrandNetTotal.innerHTML = "<span class='marginL62 bold'>"+nettot+"</span>" ;
            
            $('#hdnCollectedItems').val(JSON.stringify(lstProductList));

            if ($('#hdnCollectedItems').val() == "") {
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrderQuantity_aspx_02") == null ? "Check that the items added or quantity is provided properly" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrderQuantity_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            $('#hdnPurchaseOrderItems').val($('#hdnCollectedItems').val());
            //return true;
        }
        catch (e) {
            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_0833") == null ? "Problem while Adding the table" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");

            ValidationWindow(userMsg, errorMsg);
        }

    }
    function btnEdit_OnClick(sEditedData) {
        try {

            $('#divProductDetails').removeClass().addClass('show');
            $('#hdnRowEdit').val(JSON.stringify(sEditedData));
            $('#add').val('Update');
            $('#hdnReceivedID').val(sEditedData.ID);
            $('#hdnProductName').val(sEditedData.ProductName);
            $('#txtProduct').val(unescape(sEditedData.ProductName));
            $('#txtProduct').attr('readonly', true);

            $('#txtQuantity').val(sEditedData.Quantity);

            $('#ddlUnits option:not(:selected)').prop('disabled', true);
            $('#txtUnitCost').val(sEditedData.UnitCostPrice);
            $('#lblTotalCost').text(sEditedData.Total);
            $('#txtDiscount').val(sEditedData.Discount);

            $('#lblTotVal').text(sEditedData.Rate);
            $('#txtPurchaseTax').val(sEditedData.PurchaseTax);
            $('#txtTax').val(sEditedData.Tax);
            $('#txtCompQty').val(sEditedData.ComplimentQTY);
            $('#hdnProductId').val(sEditedData.ProductID);
            $('#hdnPdtRcvdDtlsID').val(sEditedData.ProductReceivedDetailsID);
            ConvertOrderUnitList(sEditedData.OrderedUnitValues, sEditedData.Unit);
            $('#ddlUnits').val(sEditedData.Unit);
            //-------------------------------------Gst
            var pTax = sEditedData.Tax;
            if (CheckState == "Y") {
                CGST = pTax / 2;
                SGST = pTax / 2;
                IGST = 0

            }
            else {
                IGST = pTax;
                CGST = 0;
                SGST = 0;
            }
            $('.ww-300').html('<table class="gsttbl" border="1" rules="all"><tr><td>CGST(%)</td><td>SGST(%)</td><td>IGST(%)</td></tr><tr><td>' + CGST + '</td><td>' + SGST + '</td><td>' + IGST + '</td></tr></table>');
            //----------------------------------END


        }
        catch (e) {
            var userMsg = SListForAppMsg.Get("StockIntend_IssueStock_aspx_0944") != null ? SListForAppMsg.Get("StockIntend_IssueStock_aspx_09") : "Problem while editing the product.!";
            var informMsg = SListForAppMsg.Get("StockIntend_Information") == null ? "Information" : SListForAppMsg.Get("StockIntend_Information");

            ValidationWindow(userMsg, informMsg)
        }

    }
    function btnDelete(sEditedData) {
        try {
            var arrF = $.grep(lstProductList, function (n, i) {
                return n.ProductID != sEditedData.ProductID;
            });
            if (arrF.length > 0) {
                lstProductList = [];
                lstProductList = arrF;
                $('#hdnProductList').val(JSON.stringify(lstProductList));
                Tblist();
            }
            else {
                lstProductList = [];
                $("#tblOrederedItems tr").remove();
                $('#hdnPurchaseOrderItems').val('');

            }

        }
        catch (e) {
            var userMsg = SListForAppMsg.Get("StockIntend_IssueStock_aspx_0944") != null ? SListForAppMsg.Get("StockIntend_IssueStock_aspx_09") : "Problem while deleting the product.!";
            var informMsg = SListForAppMsg.Get("StockIntend_Information") == null ? "Information" : SListForAppMsg.Get("StockIntend_Information");

            ValidationWindow(userMsg, informMsg)
        }
    }

    function fnSaveAsDrafts(SaveMetod) {
        try {


            $('#hdnDaftMethod').val(SaveMetod);
            if (SaveMetod == 'ManualSave') {
                //fnShowProgress();
            }
            var draftValue = $('#ddlSupplierList').val();
            if (draftValue == 0) {
                var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_084") == null ? "Please select the supplier" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
                $('#ddlSupplierList').focus();
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            var OrgID = $('#hdnOrgId').val();
            var LID = $('#hdnLoginid').val();
            var ILocationID = $('#hdnLocationId').val();
            var PageID=$('#hndPageId').val();
            var draftData = $("#hdnPurchaseOrderItems").val();

            if (draftData != "") {
                $.ajax({
                    type: "POST",
                    url: "../InventoryCommon/WebService/InventoryWebService.asmx/SaveASDraft",
                    data: "{ 'OrgID':" + OrgID + ",'LocationID':" + ILocationID + ",'PageID':" + PageID + ",'LoginID':" + LID + ",'DraftType':'PurchaseOrder','DraftValue':" + draftValue + ",'DraftData':'" + draftData + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess,
                    failure: function (response) {
                        alert(response.d);

                    }
                });

            }
            else if (SaveMetod != 'ManualSave') {
                var AppInterval = $("input[id$=hdnshowintervel]").val();
                setTimeout(fnSaveAsDrafts, AppInterval);
            }
            else {
                var userMsg = SListForAppMsg.Get("StockIntend_IssueStock_aspx_09") != null ? SListForAppMsg.Get("StockIntend_IssueStock_aspx_09") : "Add Product";
                var informMsg = SListForAppMsg.Get("StockIntend_Information") == null ? "Information" : SListForAppMsg.Get("StockIntend_Information");

                ValidationWindow(userMsg, informMsg)
            }
        }
        catch (e) {
            var userMsg = SListForAppMsg.Get("StockIntend_IssueStock_aspx_0944") != null ? SListForAppMsg.Get("StockIntend_IssueStock_aspx_09") : "Problem while saving the draft";
            var informMsg = SListForAppMsg.Get("StockIntend_Information") == null ? "Information" : SListForAppMsg.Get("StockIntend_Information");

            ValidationWindow(userMsg, informMsg)
        }
    }
    function OnSuccess(response) {

        try {
            if ($('#hdnDaftMethod').val() == 'ManualSave') {
                var infromMsg = SListForAppMsg.Get("StockIntend_Information") == null ? "Information" : SListForAppMsg.Get("StockIntend_Information");
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_01") == null ? "Saved Successfully!!!" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_01");
                ValidationWindow(userMsg, infromMsg);
            }

            $('#hdnDaftMethod').val('');
        }
        catch (e) {
            var userMsg = SListForAppMsg.Get("StockIntend_IssueStock_aspx_09ssss") != null ? SListForAppMsg.Get("StockIntend_IssueStock_aspx_09") : "Problem while saving PO draft";
            var informMsg = SListForAppMsg.Get("StockIntend_Information") == null ? "Information" : SListForAppMsg.Get("StockIntend_Information");

            ValidationWindow(userMsg, informMsg)
        }
    }

    function fnGetDrafts() {
        try {
            var OrgID = $('#hdnOrgId').val();
            var LID = $('#hdnLoginid').val();
            var ILocationID = $('#hdnLocationId').val();
            var PageID = $('#hndPageId').val();
                       
            
            $("#hdnPurchaseOrderItems").val('');
            var DraftValue = $('#ddlSupplierList').val();
            if (DraftValue > 0) {
                $.ajax({
                    type: "POST",
                    url: "../InventoryCommon/WebService/InventoryWebService.asmx/GetDraftDtls",
                    data: '{OrgID:"' + OrgID + '",LocationID:"' + ILocationID + '",PageID:"' + PageID + '",LoginID:"' + LID + '",DraftType:"PurchaseOrder",DraftValue:"' + DraftValue + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetDraftSuccess,
                    failure: function (response) {
                        alert(response.d);
                        //                    fnHideProgress();
                    }
                });
            }
        }
        catch (e) {
            var userMsg = SListForAppMsg.Get("StockIntend_IssueStock_aspx_09ssss") != null ? SListForAppMsg.Get("StockIntend_IssueStock_aspx_09") : "Problem while getting PO draft";
            var informMsg = SListForAppMsg.Get("StockIntend_Information") == null ? "Information" : SListForAppMsg.Get("StockIntend_Information");
            ValidationWindow(userMsg, informMsg)
        }
    }
    function OnGetDraftSuccess(response) {
        try {


            if (response != null && response.d != null && response.d.length > 0) {
                $("#hdnPurchaseOrderItems").val(response.d[0].Data);
                lstProductList = JSON.parse($('#hdnPurchaseOrderItems').val());
                if (lstProductList != "") {
                    Tblist();
                }
            }
            else {
                $("#hdnPurchaseOrderItems").val('');
            }
        }
        catch (e) {
            var userMsg = SListForAppMsg.Get("StockIntend_IssueStock_aspx_09ssss") != null ? SListForAppMsg.Get("StockIntend_IssueStock_aspx_09") : "Problem while getting PO draft";
            var informMsg = SListForAppMsg.Get("StockIntend_Information") == null ? "Information" : SListForAppMsg.Get("StockIntend_Information");
            ValidationWindow(userMsg, informMsg)
        }
    }
    function pSetfocus() {
        try {

            document.getElementById('txtProduct').value = '';
            document.getElementById('txtProduct').focus();
            return;
        }
        catch (e)
        {
        }
    }
    function AutoCompleteProduct_callback(result, context) {
        try
        {
            if (result == "") {
                // ValidationWindow("Free text not allowed", informMsg);
                pSetfocus();
            }
        }
        catch (e)
        {
        }
    }
    function pageLoad() {
        try
        {
            if ($find('AutoCompleteProduct') != null) {
                $find('AutoCompleteProduct')._onMethodComplete = function (result, context) {
                    $find('AutoCompleteProduct')._update(context, result, /* cacheResults */false);
                    AutoCompleteProduct_callback(result, context);
                };
            }
        }
        catch (e)
        {

        }
        
    }
    /*Sathish--PO Development In a single Screen--End*/



function SetContextKey() {
    if($('#hdnNeedReqSuppBaseCostprice').val() == 'Y'){
        if ($('#ddlSupplierList').val() == 0) {
            var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_084") == null ? "Please select the supplier"
                                     : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_08");
            $('#ddlSupplierList').focus();
            ValidationWindow(userMsg, errorMsg);
            clearAll();
            return false;
        }
    }
    $find('AutoCompleteProduct').set_contextKey($('#hdnSName').val());
}

/*OrderUnitList DropDown Bind*/

var OrderUnitList = [];
var ddlvalue;

    function ConvertOrderUnitList(value,ddlSelectedVal) {
        OrderUnitList = [];
        ddlvalue = value;
                
        var SplitVal = value.split('#');
        
        $.each(SplitVal, function(index, item) {
            
            var objProduct = new Object();
            var supSplit = item.split(',');
            
            $.each(supSplit, function(i, val) {
            
                            var FiledSplit = val.split(':');

                            if ($.trim(FiledSplit[0]) == "UOMCode") {
                                objProduct.UOMCode = FiledSplit[1];
                            }
                            
                            if ($.trim(FiledSplit[0]) == "ConvesionQty") {
                                objProduct.ConvesionQty = FiledSplit[1];
                            }
                
            });

            OrderUnitList.push(objProduct);
        });

        BindOrderUnitddl(OrderUnitList, ddlSelectedVal);

    }

    function BindOrderUnitddl(lstOrderUnit, SelectedValue) {           
        var dropdown = $('#ddlUnits');
        dropdown.empty();

        $.each(lstOrderUnit, function(index, item) {
            var $option = $("<option />");
            $option.attr("value", item.UOMCode).text(item.UOMCode);
            $(dropdown).append($option);

        });

    }


    function AddRecUnitDefault() {
        $("#ddlUnits").empty();
        var ddlval = SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_06") == null ? "Select" : SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_06");
        var $option = $("<option />");
        $option.attr("value", $.trim("0")).text($.trim(ddlval));
        $("#ddlUnits").append($option);
    }
    
   function ddluintChange()
   {     
   
         $.each(OrderUnitList, function(index, item) {
          if (item.UOMCode==$('#ddlUnits :selected').val())
          {
            $('#txtUnitCost').val((LsuCostPrise* item.ConvesionQty));
          }
        });

   }
       
   function ClearSupplier()
   { 
           if($("#hdnNeedReqSuppBaseCostprice").val()=='Y')
            {
               if ($("#tblOrederedItems tr").length>0)
               {
                  
                   var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_177") == null ? "Are sure you want to change the suppller?" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrder_aspx_177");
                   if (ConfirmWindow(userMsg, informMsg, okMsg, errorMsg)) {
                  
                     lstProductList = [];
                     $("#tblOrederedItems tr").remove();
                   }
                }
                 
                             
                 clearAll();  
                 return;       
              }
   }
    
    