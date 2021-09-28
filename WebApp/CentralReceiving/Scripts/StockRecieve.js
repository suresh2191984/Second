var JsonProductList = {};
var EditProductList = [];
var DynamicProductList = [];
//var errormsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Alert" : SListForAppMsg.Get("CentralReceiving_Error");
//var Information = SListForAppMsg.Get("CentralReceiving_Information") == null ? "Error" : SListForAppMsg.Get("CentralReceiving_Information");
//var Ok = SListForAppMsg.Get("CentralReceiving_OK") == null ? "Error" : SListForAppMsg.Get("CentralReceiving_OK");
//var Cancel = SListForAppMsg.Get("CentralReceiving_Cancel") == null ? "Error" : SListForAppMsg.Get("CentralReceiving_Cancel");
var Add = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_19") == null ? "Add" : SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_19");
var Update = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_20") == null ? "Update" : SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_20");

function DynamicTable() {
    //  debugger;

    var ProductList;

    if ($("#hdnProductList").val() != '') {
        ProductList = $("#hdnProductList").val();
    }
    var Result = JSON.parse(ProductList);
    $.each(Result, function(i, Obj) {
        DynamicProductList.push({
            ProductID: Obj.ProductID,
            ProductName: Obj.ProductName,
            CategoryID: Obj.CategoryID,
            CategoryName: Obj.CategoryName,
            BatchNo: Obj.BatchNo,
            POQuantity: Obj.POQuantity,
            POUnit: Obj.POUnit,
            RECQuantity: Obj.StockReceived == 0 ? Obj.RECQuantity : Obj.RECQuantity - Obj.StockReceived,
            RECUnit: Obj.RECUnit,
            Attributes: Obj.Attributes,
            HasExpiryDate: Obj.HasExpiryDate,
            HasBatchNo: Obj.HasBatchNo,
            HasUsage: Obj.HasUsage,
            Manufacture: JSONDateWithTime(Obj.Manufacture),
            ExpiryDate: JSONDateWithTime(Obj.ExpiryDate),
            InvoiceQty: Number(Obj.InvoiceQty == 0 ? 1 : Obj.InvoiceQty),
            SellingUnit: Obj.SellingUnit,
            RcvdLSUQty: Dynamic_RcvdLSUQty(Obj.POQuantity, Number(Obj.InvoiceQty == 0 ? 1 : Obj.InvoiceQty), Obj.StockReceived == 0 ? Obj.RECQuantity : Obj.RECQuantity - Obj.StockReceived),
            ComplimentQTY: parseFloat(Obj.ComplimentQTY).toFixed(2),
            UnitSellingPrice: parseFloat(Obj.UnitSellingPrice).toFixed(2),
            UnitCostPrice: parseFloat(Obj.UnitCostPrice).toFixed(2),
            Tax: parseFloat(Obj.Tax).toFixed(2),
            //  SellingPrice: parseFloat(Obj.SellingPrice).toFixed(2),
            SellingPrice: Dynamic_btnCalcSellingPrice(Number(Obj.InvoiceQty == 0 ? 1 : Obj.InvoiceQty), Obj.UnitSellingPrice, Obj.RECQuantity, 0),
            UnitPrice: Dynamic_calculateCastPerUnit(Number(Obj.InvoiceQty == 0 ? 1 : Obj.InvoiceQty), Obj.UnitPrice, Obj.RECQuantity, 0),
            //UnitPrice: parseFloat(Obj.UnitPrice).toFixed(2),
            RakNo: Obj.RakNo,
            MRP: parseFloat(Obj.MRP).toFixed(2),
            Discount: parseFloat(Obj.Discount).toFixed(2),
            Amount: Dynamic_TotalCalculation(Obj.POQuantity, Obj.StockReceived == 0 ? Obj.RECQuantity : Obj.RECQuantity - Obj.StockReceived, Number(Obj.InvoiceQty == 0 ? 1 : Obj.InvoiceQty), 0, Obj.UnitCostPrice, Obj.UnitSellingPrice, Obj.Tax, Obj.Discount),
            TotalCost: Dynamic_TotalCalculation(Obj.POQuantity, Obj.StockReceived == 0 ? Obj.RECQuantity : Obj.RECQuantity - Obj.StockReceived, Number(Obj.InvoiceQty == 0 ? 1 : Obj.InvoiceQty), 0, Obj.UnitCostPrice, Obj.UnitSellingPrice, Obj.Tax, Obj.Discount),
            Name: Obj.Name,
            Description: Obj.ProductID + "_" + Obj.BatchNo,
            ID: i,
            // Rate: parseFloat(Obj.SellingPrice == 0 ? Obj.Rate : Obj.SellingPrice).toFixed(2),
            Rate: Dynamic_btnCalcSellingPrice(Number(Obj.InvoiceQty == 0 ? 1 : Obj.InvoiceQty), Obj.UnitSellingPrice, Obj.RECQuantity, 0),
            IsScheduleHDrug: CheckDatesMfgValue(' ', JSONDateWithTime(Obj.Manufacture), 'MFG') == true ? CheckDatesExpValue(' ', JSONDateWithTime(Obj.ExpiryDate), 'EXP') : false,
            UsageCount: Obj.UsageCount,
            StockReceived: Obj.StockReceived
        });
    });


    ItemTableCreation(DynamicProductList);

}





function ItemTableCreation(DataTable) {

    document.getElementById('hdnProductList').value = '';
    while (count = document.getElementById('tblDynamic').rows.length) {

        for (var j = 0; j < document.getElementById('tblDynamic').rows.length; j++) {
            document.getElementById('tblDynamic').deleteRow(j);
        }
    }


    var tbleDynamic = $("#tblDynamic");

    var Headrow = document.getElementById('tblDynamic').insertRow(0);
    Headrow.id = "HeadID1";
    Headrow.style.fontWeight = "bold";
    Headrow.className = "dataheader1"
    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    var cell5 = Headrow.insertCell(4);
    var cell6 = Headrow.insertCell(5);
    var cell7 = Headrow.insertCell(6);
    var cell8 = Headrow.insertCell(7);
    var cell9 = Headrow.insertCell(8);
    var cell10 = Headrow.insertCell(9);
    var cell11 = Headrow.insertCell(10);
    var cell12 = Headrow.insertCell(11);
    var cell13 = Headrow.insertCell(12);
    var cell14 = Headrow.insertCell(13);
    var cell15 = Headrow.insertCell(14);
    var cell16 = Headrow.insertCell(15);
    var cell17 = Headrow.insertCell(16);
    var cell18 = Headrow.insertCell(17);


    cell1.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_01") == null ? "Product" : SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_01");
    cell2.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_02") == null?"Batch No":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_02");
    cell3.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_03") == null?"MFD Date":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_03");
    cell4.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_04") == null?"EXP Date":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_04");
    cell5.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_05") == null?"PO Qty/Unit":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_05");
    cell6.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_06") == null?"Rec Qty/Unit":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_06");
    cell7.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_07") == null?"Selling Unit":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_07");
    cell8.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_08") == null?"Inverse Qty":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_08");
    cell9.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_09") == null?"Rcvd LSU Qty":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_09");
    cell10.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_10") == null?"Comp Qty(LSU)":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_10");
    cell11.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_11") == null?"Cost Price":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_11");
    cell12.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_12") == null?"Discount(%)":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_12");
    cell13.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_13") == null?"Tax(%)":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_13");
    cell14.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_14") == null?"Selling Price":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_14");
    cell15.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_15") == null?"MRP":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_15");
    cell16.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_16") == null?"RakNo":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_16");
    cell17.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_17") == null?"Total Cost":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_17");
    cell18.innerHTML = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_18") == null?"Action":SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_18");

    document.getElementById('lblTotalCostAmount').innerHTML = '0.00';
    document.getElementById('txtDiscountAmt').value = '0.00'
    document.getElementById('txtGrandTotal').value = '0.00';
    document.getElementById('txtGrandwithRoundof').value = '0.00';
    document.getElementById('txtNetTotal').value = '0.00';
    document.getElementById('txtRoundOffValue').value = '0.00';

    document.getElementById('txtTaxAmt').value = '0.00';
    document.getElementById('hdnTotalCost').value = '0';

    $.each(DataTable, function(k, Res) {

        var row = document.getElementById('tblDynamic').insertRow(1);
        row.style.height = "13px";
        row.id = Res.Description;
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var cell5 = row.insertCell(4);
        var cell6 = row.insertCell(5);
        var cell7 = row.insertCell(6);
        var cell8 = row.insertCell(7);
        var cell9 = row.insertCell(8);
        var cell10 = row.insertCell(9);
        var cell11 = row.insertCell(10);
        var cell12 = row.insertCell(11);
        var cell13 = row.insertCell(12);
        var cell14 = row.insertCell(13);
        var cell15 = row.insertCell(14);
        var cell16 = row.insertCell(15);
        var cell17 = row.insertCell(16);
        var cell18 = row.insertCell(17);

        cell1.innerHTML = Res.ProductName;
        cell2.innerHTML = Res.BatchNo;
        cell2.onclick = fn_EditRowCell;
        $(cell2).attr("dt", "String");
        $(cell2).attr("vType", "BatchNo");
        cell3.innerHTML = Res.Manufacture;
        cell3.onclick = fn_EditRowCell;
        $(cell3).attr("dt", "Date");
        $(cell3).attr("vType", "MFG");
        cell4.innerHTML = Res.ExpiryDate;
        cell4.onclick = fn_EditRowCell;
        $(cell4).attr("dt", "Date");
        $(cell4).attr("vType", "EXP");
        cell5.innerHTML = Res.POQuantity + "(" + Res.POUnit + ")";
        cell6.innerHTML = Res.RECQuantity + "(" + Res.RECUnit + ")";
        cell7.innerHTML = Res.SellingUnit;
        cell8.innerHTML = Res.InvoiceQty;
        cell9.innerHTML = Res.RcvdLSUQty;
        cell10.innerHTML = Res.ComplimentQTY;
        cell11.innerHTML = Res.UnitCostPrice;
        cell12.innerHTML = Res.Discount;
        cell13.innerHTML = Res.Tax;
        cell14.innerHTML = Res.UnitSellingPrice;
        cell15.innerHTML = Res.MRP;
        cell16.innerHTML = Res.RakNo;
        cell17.innerHTML = Res.Amount;
        Res.IsScheduleHDrug = CheckDatesMfgValue(' ', Res.Manufacture, 'MFG') == true ? CheckDatesExpValue(' ', Res.ExpiryDate, 'EXP') : false;
        cell18.innerHTML =
            "<input name='" + Res.Description + "' onclick='Dyn_btnEdit_OnClick(this,name);' value = 'Edit' type='button'"
                     + " style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /><br>"
                     + "<input name='" + Res.Description + "' onclick='Dyn_btnDelete(this,name);' value = 'Delete' type='button' "
                     + "style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />";

        document.getElementById('tbTotalCost').style.display = "block";
        document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(Res.Amount) + parseFloat(document.getElementById('lblTotalCostAmount').innerHTML)).toFixed(2);
        document.getElementById('hdnTotalCost').value = parseFloat(parseFloat(Res.Amount) + parseFloat(document.getElementById('hdnTotalCost').value)).toFixed(2);
        document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(Res.Amount) + parseFloat(document.getElementById('txtGrandTotal').value)).toFixed(2);
        document.getElementById('txtNetTotal').value = (parseFloat(document.getElementById('txtGrandTotal').value)).toFixed(2);
        document.getElementById('txtDiscountAmt').value = parseFloat(parseFloat(document.getElementById('txtDiscountAmt').value) + parseFloat(parseFloat(parseFloat(Res.Discount) / 100) * (parseFloat(Res.UnitCostPrice) * parseFloat(Res.RECQuantity)))).toFixed(2);
        document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(document.getElementById('txtTaxAmt').value) + parseFloat(parseFloat(parseFloat(Res.Tax) / 100) * (parseFloat(parseFloat(Res.UnitCostPrice) * parseFloat(Res.RECQuantity))))).toFixed(2);

        if (document.getElementById('hdnAvailableCreditAmount').value != null) {
            document.getElementById('txtAvailCreditAmount').value = parseFloat(document.getElementById('hdnAvailableCreditAmount').value).toFixed(2);
        }
        else document.getElementById('txtAvailCreditAmount').value = 0.00;
        document.getElementById('txtUseCreditAmount').value = 0.00;
        if (parseFloat(document.getElementById('hdnAvailableCreditAmount').value) > 0)
            document.getElementById('txtUseCreditAmount').diabled = false;
        else
            document.getElementById('txtUseCreditAmount').disabled = true;


    });


    if (DynamicProductList.length == 0) {
        document.getElementById('submitTab').style.display = "none";
    }
    else {
        document.getElementById('submitTab').style.display = "block";
    }

    $('[id$="hdnProductList"]').val(JSON.stringify(DynamicProductList));

}

function Dynamic_Total(DataTable) {
    document.getElementById('lblTotalCostAmount').innerHTML = '0.00';
    document.getElementById('txtDiscountAmt').value = '0.00'
    document.getElementById('txtGrandTotal').value = '0.00';
    document.getElementById('txtGrandwithRoundof').value = '0.00';
    document.getElementById('txtNetTotal').value = '0.00';
    document.getElementById('txtRoundOffValue').value = '0.00';

    document.getElementById('txtTaxAmt').value = '0.00';
    document.getElementById('hdnTotalCost').value = '0';
    document.getElementById('tbTotalCost').style.display = "block";

    $.each(DataTable, function(k, Res) {
        document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(Res.Amount) + parseFloat(document.getElementById('lblTotalCostAmount').innerHTML)).toFixed(2);
        document.getElementById('hdnTotalCost').value = parseFloat(parseFloat(Res.Amount) + parseFloat(document.getElementById('hdnTotalCost').value)).toFixed(2);
        document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(Res.Amount) + parseFloat(document.getElementById('txtGrandTotal').value)).toFixed(2);
        document.getElementById('txtNetTotal').value = (parseFloat(document.getElementById('txtGrandTotal').value)).toFixed(2);
        document.getElementById('txtDiscountAmt').value = parseFloat(parseFloat(document.getElementById('txtDiscountAmt').value) + parseFloat(parseFloat(parseFloat(Res.Discount) / 100) * (parseFloat(Res.UnitCostPrice) * parseFloat(Res.RECQuantity)))).toFixed(2);
        document.getElementById('txtTaxAmt').value = parseFloat(parseFloat(document.getElementById('txtTaxAmt').value) + parseFloat(parseFloat(parseFloat(Res.Tax) / 100) * (parseFloat(parseFloat(Res.UnitCostPrice) * parseFloat(Res.RECQuantity))))).toFixed(2);
    });

}


function Dyn_btnEdit_OnClick(ele, sEditedData) {
    $(ele).parent('td').parent('tr').remove();
    var temp_DynamicProductList = [];

    for (var i = 0; i < DynamicProductList.length; i++) {

        if (DynamicProductList[i].Description == sEditedData) {
            EditProductList.push(DynamicProductList[i]);
            var y = DynamicProductList[i];
            document.getElementById('hdnproductId').value = y.ProductID;
            document.getElementById('hdnProductName').value = y.ProductName;
            document.getElementById('txtProductName').value = y.ProductName;
            document.getElementById('ddlCategory').value = y.CategoryID;
            document.getElementById('txtBatchNo').value = y.BatchNo;
            document.getElementById('txtMFTDate').value = y.Manufacture;
            document.getElementById('txtEXPDate').value = y.ExpiryDate;
            document.getElementById('txtPoQuantity').value = y.POQuantity;
            document.getElementById('txtPoUnit').value = y.POUnit;
            document.getElementById('txtRECQuantity').value = y.RECQuantity;
            document.getElementById('txtRcvdUnit').value = y.RECUnit;
            document.getElementById('txtCompQuantity').value = y.ComplimentQTY;
            document.getElementById('txtUnitPrice').value = y.UnitCostPrice;
            document.getElementById('txtDiscount').value = y.Discount;
            document.getElementById('txtTax').value = y.Tax;

            document.getElementById('txtTotalCost').value = y.Amount;
            document.getElementById('hdnRowEdit').value = sEditedData;

            document.getElementById('add').value = 'Update';

            document.getElementById('hdnAdd').value = 'Update';

            document.getElementById('txtSellingPrice').value = y.UnitSellingPrice;
            document.getElementById('ddlSelling').value = y.SellingUnit;
            document.getElementById('txtInvoiceQty').value = y.InvoiceQty == 0 ? 1 : y.InvoiceQty;
            document.getElementById('txtRcvdLSUQty').value = y.RcvdLSUQty;
            document.getElementById('hdnUnitCostPrice').value = y.UnitPrice;
            document.getElementById('hdnUnitSellingPrice').value = y.SellingPrice;
            document.getElementById('hdnAttributes').value = y.Attributes;
            document.getElementById('hdnAttributeDetail').value = y.AttributeDetail;
            document.getElementById('hdnHasExpiryDate').value = y.HasExpiryDate;
            document.getElementById('hdnHasBatchNo').value = y.HasBatchNo;
            document.getElementById('hdnGridPopCount').value = (y.RECQuantity * (y.InvoiceQty == 0 ? 1 : y.InvoiceQty)) + y.ComplimentQTY;
            document.getElementById('txtRakNo').value = y.RakNo;
            document.getElementById('txtMRP').value = y.MRP;
            document.getElementById('TableProductDetails').style.display = "block";
            document.getElementById('ddlCategory').disabled = true;
            document.getElementById('txtRcvdUnit').readOnly = true;
            document.getElementById('txtPoQuantity').readOnly = true;
            document.getElementById('txtPoUnit').readOnly = true;
            document.getElementById('txtTotalCost').readOnly = true;
            document.getElementById('txtRcvdLSUQty').readOnly = true;
            document.getElementById('hdnReceivedQty').value = y.StockReceived;


            if (y.Attributes != 'N') {
                document.getElementById('lbtnAttribute').style.display = "block"
            }
            else {
                document.getElementById('lbtnAttribute').style.display = "none"
                document.getElementById('hdnAttributes').value = "N";
            }
        }
        else {
            temp_DynamicProductList.push(DynamicProductList[i]);
        }

    }
    DynamicProductList = temp_DynamicProductList;
    Dynamic_Total(DynamicProductList);
}


function Dynamic_BindProductList() {

    if (document.getElementById('hdnAttributes').value == 'N') {
        document.getElementById('hdnGridPopCount').value = (Number(document.getElementById('txtRcvdLSUQty').value) + Number(document.getElementById('txtCompQuantity').value))
    }

    if (document.getElementById('hdnAttributes').value != 'N' && Number(document.getElementById('hdnGridPopCount').value) != (Number(document.getElementById('txtRcvdLSUQty').value) + Number(document.getElementById('txtCompQuantity').value))) {
        if (document.getElementById('hdnAttributeDetail').value == '') {
            var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_01") == null ? "Provide the attributes" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_01");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('lbtnAttribute').focus();
            return false;
        } else {
            var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_02") == null ? "The number of product and detail does not match" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_02");
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
    }


    var pMFTDate = '';
    var pEXPDate = '';
    var pProductNamefull = document.getElementById('txtProductName').value;
    var pProductNamesplit = pProductNamefull.split('[');
    var pName = pProductNamesplit[0];

    var pId = document.getElementById('hdnproductId').value;
    var pCategory = document.getElementById('ddlCategory').options[document.getElementById('ddlCategory').selectedIndex].text;
    var pCategoryId = document.getElementById('ddlCategory').value;
    var pBatchNo = document.getElementById('txtBatchNo').value;
    if (pBatchNo == '') {
        pBatchNo = '*';
    }


    if (document.getElementById('txtEXPDate').value == '' || document.getElementById('txtEXPDate').value == '__/____') {
        pEXPDate = '**';
    }
    else {
        pEXPDate = document.getElementById('txtEXPDate').value;
    }


    if ((document.getElementById('txtMFTDate').value == '') || (document.getElementById('txtMFTDate').value == "__/____")) {
        pMFTDate = '**';
    }
    else {
        pMFTDate = document.getElementById('txtMFTDate').value;
    }

    var pPoQuantity = document.getElementById('txtPoQuantity').value;
    var pPoUnit = document.getElementById('txtPoUnit').value;

    var pRECQuantity = document.getElementById('txtRECQuantity').value;
    var pRECUnit = document.getElementById('txtRcvdUnit').value;

    var pCompQTY = document.getElementById('txtCompQuantity').value;
    var pTax = document.getElementById('txtTax').value;
    var pDiscount = document.getElementById('txtDiscount').value;

    var pUnitCostPrice = document.getElementById('txtUnitPrice').value;
    var pTotalCost = document.getElementById('txtTotalCost').value;
    var pTQty = document.getElementById('hdnType').value;
    var pUnitSellingPrice = document.getElementById('txtSellingPrice').value;
    var pMRP = document.getElementById('txtMRP').value;
    var pRcvdLSUQty = document.getElementById('txtRcvdLSUQty').value;
    var pInvoiceQty = document.getElementById('txtInvoiceQty').value;
    var pSellingUnit = document.getElementById('ddlSelling').value;
    var pUnitPrice = document.getElementById('hdnUnitCostPrice').value; //single unit

    var pSellingPrice = document.getElementById('hdnUnitSellingPrice').value; //single unit
    var pAttrib = document.getElementById('hdnAttributes').value;
    var pAttribDetail = document.getElementById('hdnAttributeDetail').value;
    var pHasExpDate = document.getElementById('hdnHasExpiryDate').value;
    var pHasBatchNo = document.getElementById('hdnHasBatchNo').value;

    var pAttCount = document.getElementById('hdnGridPopCount').value;
    var pRakNo = document.getElementById('txtRakNo').value;
    var pStockReceived = document.getElementById('hdnReceivedQty').value;



    DynamicProductList.push({
        ProductID: pId,
        ProductName: pName,
        CategoryID: pCategoryId,
        CategoryName: pCategory,
        BatchNo: pBatchNo,
        POQuantity: pPoQuantity,
        POUnit: pPoUnit,
        Attributes: pAttrib,
        HasExpiryDate: pHasExpDate,
        HasBatchNo: pHasBatchNo,
        HasUsage: 'N',
        Manufacture: pMFTDate,
        ExpiryDate: pEXPDate,
        ComplimentQTY: pCompQTY,
        RECUnit: pRECUnit,
        UnitSellingPrice: pUnitSellingPrice,
        UnitCostPrice: pUnitCostPrice,
        Tax: pTax,
        SellingPrice: pSellingPrice,
        UnitPrice: pUnitPrice,
        RakNo: pRakNo,
        MRP: pMRP,
        Discount: pDiscount,
        InvoiceQty: pInvoiceQty,
        RcvdLSUQty: pRcvdLSUQty,
        SellingUnit: pSellingUnit,
        RECQuantity: pRECQuantity,
        TotalCost: pTotalCost,
        Amount: pTotalCost,
        Rate: pSellingPrice,
        Description: pId + "_" + pBatchNo,
        IsScheduleHDrug: CheckDatesMfgValue(' ', pMFTDate, 'MFG') == true ? CheckDatesExpValue(' ', pEXPDate, 'EXP') : false,
        UsageCount: pAttCount,
        StockReceived: pStockReceived


    });


    ItemTableCreation(DynamicProductList);

    document.getElementById('add').value = 'Add';
    document.getElementById('hdnAdd').value = 'Add';
    document.getElementById('hdnGridPopCount').value = '';
    document.getElementById('hdnAttributeDetail').value = 'N';
    fnClear();

}




function Dyn_btnDelete(ele, sEditedData) {
    $(ele).parent('td').parent('tr').remove();
    //debugger;
    var i;
    var x = document.getElementById('hdnProductList').value.split("^");
    document.getElementById('hdnProductList').value = '';
    document.getElementById('lblTotalCostAmount').innerHTML = '0.00';
    document.getElementById('txtGrandTotal').value = '0.00';
    var Delete_DynamicProductList = [];

    for (var i = 0; i < DynamicProductList.length; i++) {

        if (DynamicProductList[i].Description != sEditedData) {
            Delete_DynamicProductList.push(DynamicProductList[i]);
            var x = DynamicProductList[i];
            document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(x.Amount) + parseFloat(document.getElementById('lblTotalCostAmount').innerHTML)).toFixed(2);
            document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(x.Amount) + parseFloat(document.getElementById('txtGrandTotal').value)).toFixed(2);

        }
    }


    //    
    //    for (i = 0; i < x.length; i++) {
    //        if (x[i] != "") {

    //            if (x[i] != sEditedData) {
    //                document.getElementById('hdnProductList').value += x[i] + "^";
    //                document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(x[i].split('~')[15]) + parseFloat(document.getElementById('lblTotalCostAmount').innerHTML)).toFixed(2);
    //                document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(x[i].split('~')[15]) + parseFloat(document.getElementById('txtGrandTotal').value)).toFixed(2);
    //            }

    //        }
    //    }
    document.getElementById('hdnType').value = "";
    document.getElementById('add').value = 'Add';
    document.getElementById('hdnAdd').value = 'Add';

    document.getElementById('hdnAttributeDetail').value = 'N';
    document.getElementById('hdnGridPopCount').value = '';
    document.getElementById('INVAttributes1_hdnAttValue').value = 'N';
    document.getElementById('INVAttributes1_hdnGridCount').value = '0';
    Dyn_btnEdit_OnClick(sEditedData, sEditedData);
    ItemTableCreation(DynamicProductList);
}
function fnSelectedProducts(source, eventArgs) {
    var lis = eventArgs.get_value();
    AddProductDetails(lis);
}

function fnClear(obj) {
    if (obj != "Pro") {

        document.getElementById('hdnProductName').value = "";
        document.getElementById('txtProductName').value = "";
    }

    document.getElementById('hdnproductId').value = "";
    document.getElementById('ddlCategory').value = "0";
    document.getElementById('txtBatchNo').value = "";
    document.getElementById('txtMFTDate').value = "";
    document.getElementById('txtEXPDate').value = "";
    document.getElementById('txtPoQuantity').value = "";
    document.getElementById('txtPoUnit').value = "";
    document.getElementById('txtRECQuantity').value = "";
    document.getElementById('txtRcvdUnit').value = "";

    document.getElementById('txtCompQuantity').value = "";
    document.getElementById('txtUnitPrice').value = "";

    document.getElementById('txtDiscount').value = "";
    document.getElementById('txtTax').value = "";

    document.getElementById('txtTotalCost').value = "";
    document.getElementById('hdnType').value = "";
    document.getElementById('add').value = 'Add';

    document.getElementById('hdnAdd').value = 'Add';

    document.getElementById('txtSellingPrice').value = "";
    document.getElementById('ddlSelling').value = "0";
    document.getElementById('txtInvoiceQty').value = "";
    document.getElementById('txtRcvdLSUQty').value = "";
    document.getElementById('hdnUnitCostPrice').value = 0;
    document.getElementById('hdnUnitSellingPrice').value = 0;
    document.getElementById('hdnAttributes').value = "N";
    document.getElementById('hdnAttributeDetail').value = "N"; ;
    document.getElementById('hdnHasExpiryDate').value = "N"; ;
    document.getElementById('hdnHasBatchNo').value = "N"; ;
    document.getElementById('hdnGridPopCount').value = 0;
    document.getElementById('txtRakNo').value = "";
    document.getElementById('txtMRP').value = "";
    document.getElementById('ddlSelling').disabled = false;
    document.getElementById('txtGrandwithRoundof').value = '0.00';
    document.getElementById('txtRoundOffValue').value = '0.00';
    document.getElementById('hdnReceivedQty').value = '0';


    document.getElementById('TableProductDetails').style.display = "block";


}

function INVRowCommon(rid, patid, SupID, PONO, Orderdate) {
    chosen = "";

    var len = document.forms[0].elements.length;
    for (var i = 0; i < len; i++) {
        if (document.forms[0].elements[i].type == "radio") {
            document.forms[0].elements[i].checked = false;
        }
    }
    document.getElementById(rid).checked = true;
    document.getElementById("poNoid").value = patid;
    document.getElementById("SupID").value = SupID;
    document.getElementById("HdnPOno").value = PONO;
    document.getElementById("tdgo").style.display = 'block';
    document.getElementById("hdnorderdate").value = Orderdate;


}
function CheckPoNo() {

    if (document.getElementById('hdnHideDetails').value == "1") {
        showResponses('ACX2OPPmt1', 'ACX2minusOPPmt1', 'ACX2responsesOPPmt1', 0);
        document.getElementById('ACX2responsesOPPmt1').style.display = "none";
    }
}
function funcChangeType() {
    if (document.getElementById('ddlSupplier').value != 0) {
        document.getElementById("hdnSupplierID").value = document.getElementById('ddlSupplier').value;
    }

}
function CheckRcvdLSUQty() {
    var pInvoiceQty = document.getElementById('txtInvoiceQty').value;
    var pRECQuantity = document.getElementById('txtRECQuantity').value;

    var AllowedQty = document.getElementById('hdnAllowedQty').value;

    document.getElementById('txtRcvdLSUQty').value = parseFloat(pInvoiceQty).toFixed(2) * parseFloat(pRECQuantity).toFixed(2);
    if (Number(pRECQuantity) > Number(document.getElementById('txtPoQuantity').value)) {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_03") == null ? "Provide received quantity less than or equal to ordered qty" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_03");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtRECQuantity').focus();
        return false;
    }


    CheckCompQty();
    TotalCalculation();


}
function CheckCompQty() {
    if (document.getElementById('hdnAttributes').value == "N") {
        document.getElementById('hdnGridPopCount').value = (Number(document.getElementById('txtRcvdLSUQty').value) + Number(document.getElementById('txtCompQuantity').value));
    }

}
function TotalCalculation() {
    var tempTaxAmt;
    var Total;
    var pDiscount;
    calculateCastPerUnit();
    btnCalcSellingPrice();
    var tax = document.getElementById('txtTax').value == 0.00 ? 0 : document.getElementById('txtTax').value;
    var Discount = document.getElementById('txtDiscount').value == 0.00 ? 0 : document.getElementById('txtDiscount').value;
    var UnitPrice = document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
    var RECQuantity = document.getElementById('txtRcvdLSUQty').value == 0.00 ? 0 : document.getElementById('txtRcvdLSUQty').value;
    //var UnitPrice = document.getElementById('hdnUnitCostPrice').value == 0.00 ? 0 : document.getElementById('hdnUnitCostPrice').value;
    var Inverse = document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
    RECQuantity = Number(RECQuantity) / Number(Inverse);
    var TotalCost = (parseFloat(RECQuantity) * parseFloat(UnitPrice)).toFixed(6);

    pDiscount = parseFloat(parseFloat(parseFloat(TotalCost) / parseFloat(100)) * parseFloat(Discount)).toFixed(6);


    Total = parseFloat(parseFloat(TotalCost) - parseFloat(pDiscount)).toFixed(6);

    tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(6);

    document.getElementById('txtTotalCost').value = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
    if (document.getElementById('txtTotalCost').value == NaN) {
        document.getElementById('txtTotalCost').value = 0.00;
    }
}

function calculateCastPerUnit() {

    var IsRecd = document.getElementById('hdnIsResdCalc').value;
    if (IsRecd == 'SUnit') {
        var UnitPrice = document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
        var Inverse = document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitCostPrice').value = parseFloat(UnitPrice).toFixed(6);
    }
    if (IsRecd == 'PoUnit') {
        var UnitPrice = document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
        var Inverse = document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitCostPrice').value = (parseFloat(UnitPrice) / parseFloat(Inverse)).toFixed(6);
    }

    if (IsRecd == 'RPoUnit') {


        var UnitPrice = document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
        var RecdQty = document.getElementById('txtRECQuantity').value == 0.00 ? 0 : document.getElementById('txtRECQuantity').value;
        var perUnit = (parseFloat(UnitPrice) / parseFloat(RecdQty)).toFixed(6);

        var Inverse = document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitCostPrice').value = (parseFloat(perUnit) / parseFloat(Inverse)).toFixed(6);
    }
    if (IsRecd == 'RLsuSell') {
        var UnitPrice = document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
        var Inverse = document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        var RecdQtylsu = document.getElementById('txtRcvdLSUQty').value == 0.00 ? 0 : document.getElementById('txtRcvdLSUQty').value;
        var perUnitLsu = (parseFloat(UnitPrice) / parseFloat(RecdQtylsu)).toFixed(6);
        document.getElementById('hdnUnitCostPrice').value = parseFloat(perUnitLsu).toFixed(6);
    }

}

function btnCalcSellingPrice() {
    var IsRecd = document.getElementById('hdnIsResdCalc').value;
    if (IsRecd == 'SUnit') {
        var pSellingPrice = document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
        var Inverse = document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitSellingPrice').value = parseFloat(pSellingPrice).toFixed(6);
    }
    if (IsRecd == 'PoUnit') {
        var pSellingPrice = document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
        var Inverse = document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitSellingPrice').value = (parseFloat(pSellingPrice) / parseFloat(Inverse)).toFixed(6);
    }

    if (IsRecd == 'RPoUnit') {

        var pSellingPrice = document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
        var RecdQty = document.getElementById('txtRECQuantity').value == 0.00 ? 0 : document.getElementById('txtRECQuantity').value;
        var perUnit = (parseFloat(pSellingPrice) / parseFloat(RecdQty)).toFixed(6);

        var Inverse = document.getElementById('txtInvoiceQty').value;
        document.getElementById('hdnUnitSellingPrice').value = (parseFloat(perUnit) / parseFloat(Inverse)).toFixed(6);
    }
    if (IsRecd == 'RLsuSell') {
        var pSellingPrice = document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
        var Inverse = document.getElementById('txtInvoiceQty').value == 0.00 ? 0 : document.getElementById('txtInvoiceQty').value;
        var RecdQtylsu = document.getElementById('txtRcvdLSUQty').value == 0.00 ? 0 : document.getElementById('txtRcvdLSUQty').value;
        var perUnitLsu = (parseFloat(pSellingPrice) / parseFloat(RecdQtylsu)).toFixed(6);
        document.getElementById('hdnUnitSellingPrice').value = parseFloat(perUnitLsu).toFixed(6);
    }

}



function Dynamic_RcvdLSUQty(POQuantity, pInvoiceQty, pRECQuantity) {

    if (Number(pRECQuantity) > Number(POQuantity)) {
        pRECQuantity = POQuantity;
    }
    var RvdLSUQty = parseFloat(pInvoiceQty == 0 ? 1 : pInvoiceQty).toFixed(2) * parseFloat(pRECQuantity).toFixed(2);
    return RvdLSUQty;

    //    CheckCompQty();
    //    TotalCalculation();


}

function Dynamic_CheckCompQty(Attributes, POQuantity, pInvoiceQty, pRECQuantity, RcvdLSUQty, CompQty) {

    var LSUQty = parseFloat(pInvoiceQty).toFixed(2) * parseFloat(pRECQuantity).toFixed(2);
    var TotalQty = 0;
    if (Attributes == "N") {
        TotalQty = (Number(LSUQty) + Number(CompQty));
    }
    return parseFloat(TotalQty).toFixed(2);
}


function Dynamic_TotalCalculation(POQuantity, ReceivedQty, InvoiceQty, RcvdLSUQty, UnitPrice, SellingPrice, Tax, Discount) {
    // debugger;
    var Rate = 0;
    var TotalCost = 0;
    var tempTaxAmt;
    var Total;
    var pDiscount;
    //  RcvdLSUQty = Dynamic_RcvdLSUQty(POQuantity, InvoiceQty, ReceivedQty)
    //  Rate = Dynamic_btnCalcSellingPrice(InvoiceQty, SellingPrice, ReceivedQty, RcvdLSUQty);
    //  var UnitPrice = Dynamic_calculateCastPerUnit(InvoiceQty, UnitPrice, ReceivedQty, RcvdLSUQty);
    //    var UnitPrice1 = UnitPrice;
    //    var RECQuantity = RcvdLSUQty;
    //    RECQuantity = Number(RECQuantity) / Number(InvoiceQty);

    var TotalCost = (parseFloat(ReceivedQty) * parseFloat(UnitPrice)).toFixed(6);
    pDiscount = parseFloat(parseFloat(parseFloat(TotalCost) / parseFloat(100)) * parseFloat(Discount)).toFixed(6);
    Total = parseFloat(parseFloat(TotalCost) - parseFloat(pDiscount)).toFixed(6);
    tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(Tax)).toFixed(6);
    TotalCost = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
    return TotalCost;
}


function Dynamic_calculateCastPerUnit(InvoiceQty, CostPrice, ReceivedQty, RecvdLSUQty) {

    var UnitCostPrice = 0;

    var IsRecd = document.getElementById('hdnIsResdCalc').value;
    if (IsRecd == 'SUnit') {
        UnitCostPrice = parseFloat(CostPrice).toFixed(6);
    }
    if (IsRecd == 'PoUnit') {
        UnitCostPrice = (parseFloat(CostPrice) / parseFloat(InvoiceQty)).toFixed(6);
    }

    if (IsRecd == 'RPoUnit') {
        var UnitPrice = CostPrice;
        var RecdQty = ReceivedQty;
        var perUnit = (parseFloat(UnitPrice) / parseFloat(RecdQty)).toFixed(6);
        var Inverse = InvoiceQty == 0 ? 1 : InvoiceQty;
        UnitCostPrice = (parseFloat(perUnit) / parseFloat(Inverse)).toFixed(6);
    }
    if (IsRecd == 'RLsuSell') {
        var UnitPrice = CostPrice;
        var Inverse = InvoiceQty;
        var RecdQtylsu = RecvdLSUQty;
        var perUnitLsu = (parseFloat(UnitPrice) / parseFloat(RecdQtylsu)).toFixed(6);
        UnitCostPrice = parseFloat(perUnitLsu).toFixed(6);
    }
    return UnitCostPrice;
}



function Dynamic_btnCalcSellingPrice(InvoiceQty, SellingPrice, ReceivedQty, RecvdLSUQty) {
    var UnitSellingPrice = 0;
    var IsRecd = document.getElementById('hdnIsResdCalc').value;
    if (IsRecd == 'SUnit') {
        var pSellingPrice = SellingPrice;
        var Inverse = InvoiceQty;
        UnitSellingPrice = parseFloat(pSellingPrice).toFixed(6);
    }
    if (IsRecd == 'PoUnit') {
        var pSellingPrice = SellingPrice;
        var Inverse = InvoiceQty;
        UnitSellingPrice = (parseFloat(pSellingPrice) / parseFloat(Inverse)).toFixed(6);
    }

    if (IsRecd == 'RPoUnit') {

        var pSellingPrice = SellingPrice;
        var RecdQty = ReceivedQty;
        var perUnit = (parseFloat(pSellingPrice) / parseFloat(RecdQty)).toFixed(6);
        var Inverse = InvoiceQty;
        UnitSellingPrice = (parseFloat(perUnit) / parseFloat(Inverse)).toFixed(6);
    }
    if (IsRecd == 'RLsuSell') {
        var pSellingPrice = SellingPrice;
        var Inverse = InvoiceQty;
        var RecdQtylsu = RecvdLSUQty;
        var perUnitLsu = (parseFloat(pSellingPrice) / parseFloat(RecdQtylsu)).toFixed(6);
        UnitSellingPrice = parseFloat(perUnitLsu).toFixed(6);
    }
    return UnitSellingPrice;
}




function checkAddToTotal() {
    var Total = parseFloat(parseFloat(document.getElementById('hdnTotalCost').value) - parseFloat(document.getElementById('txtTotalDiscount').value == '' ? 0 : document.getElementById('txtTotalDiscount').value)).toFixed(2);

    tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(document.getElementById('txtTotaltax').value)).toFixed(2);

    document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
    document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
    document.getElementById('txtNetTotal').value = parseFloat((parseFloat(document.getElementById('txtGrandTotal').value)) - parseFloat(document.getElementById('txtUseCreditAmount').value)).toFixed(2);
    if (parseFloat(document.getElementById('txtUseCreditAmount').value) > parseFloat(document.getElementById('txtAvailCreditAmount').value)) {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_04") == null ? "Use within available credit amount" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_04");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtUseCreditAmount').value = 0;
        document.getElementById('txtUseCreditAmount').focus();
    }
    if (parseFloat(document.getElementById('txtUseCreditAmount').value) > parseFloat(document.getElementById('txtGrandTotal').value)) {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_05") == null ? "Use credit amount lessthan or equal to GrandTotal" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_05");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtUseCreditAmount').value = 0;
        document.getElementById('txtUseCreditAmount').focus();
    }
    return false;
}



function checkIsEmpty(id) {

    if (document.getElementById('txtReceivedDate').value == '') {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_06") == null ? "Select stock received date" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_06");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtReceivedDate').focus();
        //document.getElementById('btnFinish').style.display = 'block';
        return false;
    }

    if (document.getElementById('txtDCNumber').value.trim() == "") {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_07") == null ? "Enter DCNumber" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_07");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtDCNumber').focus();
        return false;

    }
    if (document.getElementById('txtInvoiceNo').value.trim() == "") {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_08") == null ? "Enter  Invoice No" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_08");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtInvoiceNo').focus();
        return false;

    }
    if (document.getElementById('txtProductName').value.trim() == "") {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_09") == null ? "Enter the ProductName" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_09");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtProductName').focus();
        return false;

    }


    if (document.getElementById('hdnHasExpiryDate').value != 'N') {
        if (document.getElementById('txtBatchNo').value == '') {
            var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_10") == null ? "Provide batch number" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_10");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtBatchNo').focus();
            return false;
        }

    }

    //    if (document.getElementById('ddlCategory').value == 0) {
    //        alert('Select category');
    //        document.getElementById('ddlCategory').focus();
    //        return false;
    //    }


    //    if (document.getElementById('txtMFTDate').value == '') {
    //        alert('Provide Manufacture date');
    //        document.getElementById('txtMFTDate').focus();
    //        return false;
    //    }


    if (document.getElementById('hdnHasBatchNo').value != 'N') {
        if (document.getElementById('txtEXPDate').value == '') {
            var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_11") == null ? "Provide expiry date" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_11");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtEXPDate').focus();
            return false;
        }
    }
    if (document.getElementById('txtPoQuantity').value == '') {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_12") == null ? "Provide purchase order quantity" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_12");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtQuantity').focus();
        return false;
    }
    if (document.getElementById('txtPoUnit').value == '') {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_13") == null ? "Provide purchase order unit" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_13");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtPoUnit').focus();
        return false;
    }

    if (document.getElementById('txtRECQuantity').value == 0.00) {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_14") == null ? "Provide received quantity" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_14");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtRECQuantity').focus();
        return false;
    }
    if (document.getElementById('txtRcvdUnit').value == '') {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_15") == null ? "Provide the received unit" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_15");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtRcvdUnit').focus();
        return false;
    }
    if (document.getElementById('ddlSelling').value == '0') {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_16") == null ? "Select selling unit" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_16");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('ddlSelling').focus();
        return false;
    }

    if (document.getElementById('txtUnitPrice').value == 0.00) {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_17") == null ? "Provide cost price" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_17");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtUnitPrice').focus();
        return false;
    }

    if (document.getElementById('txtInvoiceQty').value == 0.00) {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_18") == null ? "Provide invoice qty" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_18");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtInvoiceQty').focus();
        return false;
    }

    if (document.getElementById('txtRcvdLSUQty').value == 0.00) {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_19") == null ? "Provide received LSU qty" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_19");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtRcvdLSUQty').focus();
        return false;
    }
    if (document.getElementById('txtSellingPrice').value == 0.00) {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_20") == null ? "Provide Selling Price" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_20");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtSellingPrice').focus();
        return false;
    }
    if (document.getElementById('txtMRP').value == 0.00) {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_21") == null ? "Provide MRP" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_21");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtMRP').focus();
        return false;
    }


    if (document.getElementById('hdnAttributeDetail').value == '') {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_01") == null ? "Provide the attributes" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_01");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('lbtnAttribute').focus();
        return false;
    }

    if (Number(document.getElementById('txtSellingPrice').value) < Number(document.getElementById('txtUnitPrice').value)) {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_22") == null ? "Provide Selling Price greater than Cost Price" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_22");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtSellingPrice').select();
        return false;
    }

    if (Number(document.getElementById('txtMRP').value) < Number(document.getElementById('txtUnitPrice').value)) {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_23") == null ? "Provide MRP greater than Cost Price" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_23");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtMRP').select();
        return false;
    }

    if (document.getElementById('add').value != 'Update') {


        var x = document.getElementById('hdnProductList').value.split("^");
        var pProductId = document.getElementById('hdnproductId').value;
        var pName = document.getElementById('hdnProductName').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        if (pBatchNo == '') {
            pBatchNo = '*';
        }
        var y; var i;
        var tempQ = document.getElementById('txtPoQuantity').value;
        var AllowedQty = document.getElementById('hdnAllowedQty').value;
        if (Number(tempQ) > 0) {
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');

                    if (y[0] == pProductId && y[4] == pBatchNo) {
                        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_24") == null ? "Product name and batch number combination already exist" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_24");
                        ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtBatchNo').focus();
                        return false;
                    }

                }
            }
        } else {
            var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_25") == null ? "Ensure items added/quantity are provided properly" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_25");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtPoQuantity').focus();
            return false;
        }
    }
    if (document.getElementById('add').value != 'Update') {

        var x = document.getElementById('hdnProductList').value.split("^");
        var pProductId = document.getElementById('hdnproductId').value;
        var pName = document.getElementById('hdnProductName').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        if (pBatchNo == '') {
            pBatchNo = '*';
        }

        var y; var i;
        var tempQ = document.getElementById('hdnAllowedQty').value;
        var q = Number(document.getElementById('txtRECQuantity').value)
        var TotalQTY = q;
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
                if (y[0] == pProductId) {
                    TotalQTY = Number(TotalQTY) + Number(y[9]);
                    if (Number(TotalQTY) > Number(tempQ)) {
                        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_03") == null ? "Provide received quantity less than or equal to ordered qty" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_03");
                        ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtPoQuantity').focus();
                        return false;
                    }



                }

            }

        }
    }
    document.getElementById('tbTotalCost').style.display = "block";
    if (document.getElementById('hdnHasBatchNo').value != 'N') {
        //  return CheckDatesMfg(' ', document.getElementById('txtMFTDate'), 'MFG') == true ? CheckDatesExp(' ', document.getElementById('txtEXPDate'), 'EXP') : false;
        return CheckDatesExp(' ', document.getElementById('txtEXPDate'), 'EXP') == true ? true : false;
    }
    return true;
}



function btnOnFocus() {
    document.getElementById('add').focus();
    if (checkIsEmpty()) {
        // BindProductList();
        Dynamic_BindProductList();
    }
}

function CheckDatesExp(splitChar, ObjDate, flag) {

    var today = new Date();
    var errormsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Alert" : SListForAppMsg.Get("CentralReceiving_Error");
    if (ObjDate.value.trim() == '') 
    {
        //alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
        if (flag == "MFG") {
            var UserMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_35") == null ? "Provide Manufactured Date!" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_35")
            ValidationWindow(UserMsg, errormsg);
        }
        else {
            var UserMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_36") == null ? "Provide Expiry Date!" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_36")
            ValidationWindow(UserMsg, errormsg);
        }
        ObjDate.select();        
        return false;
    }
    else {
        //Assign From And To Date from Controls
        splitChar = ObjDate.value.split(' ').length > 1 ? splitChar : '/';
        var DateFrom = new Array(2);
        var DateNow = new Array(2);
        DateFrom[0] = (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1);
        DateFrom[1] = ObjDate.value.split(splitChar)[1];
        // DateTo = ("01" + splitChar + (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1) + splitChar + ObjDate.value.split(splitChar)[1]).split(splitChar);
        var Ystring = DateFrom[1];
        DateNow[0] = today.getMonth() + 1;
        DateNow[1] = today.getFullYear();
        //Argument Value 0 for validating Current Date And To Date
        //Argument Value 1 for validating Current From And To Date
        if (DateNow[0] != "" && DateNow[1] != "" && Ystring.length == 4) {
            if (doDateValidation(DateNow, DateFrom, 1)) {
                //       alert("Validation Succeeded");
                return true;
            } 
            else 
            {
                //alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
                if (flag == "MFG") {
                    var UserMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_35") == null ? "Provide Manufactured Date!" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_35")
                    ValidationWindow(UserMsg, errormsg);
                }
                else {
                    var UserMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_36") == null ? "Provide Expiry Date!" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_36")
                    ValidationWindow(UserMsg, errormsg);
                }
                ObjDate.select();
                return false;
            }
        }
        else {
            // alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
            ObjDate.select();
            return false;
        }

    }
    return true;

}


function doDateValidation(from, to, bit) {
    var monthFlag = true;
    var i = from.length - 1;
    if (Number(to[i]) >= Number(from[i])) {
        if (Number(to[i]) == Number(from[i])) {
            monthFlag = false;
        }
        i--;
        if (Number(to[i]) >= Number(from[i])) {
            return true;
        }
        else if (monthFlag) {
            return true;
        }
        else {
            if (bit == 0) {
                var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_26") == null ? "Mismatch Month Between Current & Mfg Date" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_26");
                ValidationWindow(userMsg, errorMsg);
            } else {
                var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_27") == null ? "Mismatch Month Between Current & Exp Date" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_27");
                ValidationWindow(userMsg, errorMsg);
            }
            return false;
        }
    }
    else {
        if (from[0] != "____") {
            if (bit == 0) {
                var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_28") == null ? "Mismatch Year Between Current & Mfg Date" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_28");
                ValidationWindow(userMsg, errorMsg);
            } else {
                var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_29") == null ? "Mismatch Year Between Current & Exp Date" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_29");
                ValidationWindow(userMsg, errorMsg);
            }
            return false;
        }
    }
}

function getMonthValue(source) {
    // var month_names = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    var month_names = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
    for (var i = 0; i < month_names.length; i++) {
        if (month_names[i] == source) {
            return i;
        }
    }
}
var isTrue = true;
function fn_EditRowCell(obj) {

    if (isTrue) {
        isTrue = false;
        var OriginalContent = $(this).text();
        var parentid = $(this).parent('tr').attr('id');
        var dt = $(this).attr("dt");
        var vType = $(this).attr("vType");
        $(this).addClass("cellEditing");
        if (vType == "EXP" || vType == "MFG") {
            $(this).html("<input type='text' style='width:80px;' MaxLength='7' onKeyDown=return validateNaN(event); value='" + OriginalContent + "' />");
        }
        else {
            $(this).html("<input type='text' style='width:80px;' value='" + OriginalContent + "' />");
        }
        $(this).children().first().focus();

        $(this).children().first().keypress(function(e) {

            if (e.which == 13) {
                var newContent = $(this).val();
                $(this).parent().text(newContent);
                $(this).parent().removeClass("cellEditing");
                update_dyn(newContent, parentid, dt, vType);
                isTrue = true;
            }
        });

        $(this).children().first().blur(function(e) {

            if (vType == "EXP" || vType == "MFG") {
                if (vType == "EXP") {
                    if (CheckDatesExp(' ', this, 'EXP')) {
                        var newContent = $(this).val();
                        $(this).parent().text(newContent);
                        $(this).parent().removeClass("cellEditing");
                        update_dyn(newContent, parentid, dt, vType);
                        isTrue = true;
                    }
                }
                else if (vType == "MFG") {
                    if (CheckDatesMfg(' ', this, 'MFG')) {
                        var newContent = $(this).val();
                        $(this).parent().text(newContent);
                        $(this).parent().removeClass("cellEditing");
                        update_dyn(newContent, parentid, dt, vType);
                        isTrue = true;
                    }

                }


            }
            else {
                var newContent = $(this).val();
                $(this).parent().text(newContent);
                $(this).parent().removeClass("cellEditing");
                update_dyn(newContent, parentid, dt, vType);
                isTrue = true;
            }


        });



    }

}

function update_dyn(ele, pid, dt, vType) {

    for (var i = 0; i < DynamicProductList.length; i++) {

        if (DynamicProductList[i].Description == pid) {
            if (vType == "BatchNo") {
                DynamicProductList[i].BatchNo = ele;
            }
            else if (vType == "EXP") {
                DynamicProductList[i].ExpiryDate = ele;
            }
            else if (vType == "MFG") {
                DynamicProductList[i].Manufacture = ele;
            }
            DynamicProductList[i].IsScheduleHDrug = CheckDatesMfgValue(' ', DynamicProductList[i].Manufacture, 'MFG') == true ? CheckDatesExpValue(' ', DynamicProductList[i].ExpiryDate, 'EXP') : false;

        }
    }
    ItemTableCreation(DynamicProductList);
}





function AddProductDetails(obj) {

    var p = obj.split('~');
    var UserMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_37") == null ? "Selected product has been marked as Banned. Do you still wish to use this?" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_37");
    var Information = SListForAppMsg.Get("CentralReceiving_Information") == null ? "Information" : SListForAppMsg.Get("CentralReceiving_Information");
    var Ok = SListForAppMsg.Get("CentralReceiving_OK") == null ? "Ok" : SListForAppMsg.Get("CentralReceiving_OK");
    var Cancel = SListForAppMsg.Get("CentralReceiving_Cancel") == null ? "Cancel" : SListForAppMsg.Get("CentralReceiving_Cancel");
    if (p[15] == 'Y') {
        if (ConfirmWindow(UserMsg,Information,Ok,Cancel)) {
        } 
        else 
        {
            document.getElementById('txtProductName').value = '';
            return false;
        }
    }

    var pDetails = p[9].split('|');
    document.getElementById('hdnOnDeleteReset').value = obj;
    var pBac = pDetails[0];
    var pMaf = pDetails[1];
    var pExp = pDetails[2];
    var pInQty = pDetails[3];
    //var pSellUn = pDetails[4];
    var pSellUn = p[14];
    var pCostPr = Number(pDetails[5]).toFixed(6);
    var pSellPr = pDetails[6];
    var pTax = pDetails[14];
    var pUniCostPr = pCostPr;
    var pUnitSellPr = pDetails[9];
    var pMRP = pDetails[9];
    var pDiscount = pDetails[13];
    var pCompQty = pDetails[12];

    // var pVatTax = pDetails[14];


    document.getElementById('hdnproductId').value = p[0];
    document.getElementById('hdnProductName').value = p[1];
    document.getElementById('txtProductName').value = document.getElementById('hdnProductName').value;
    document.getElementById('TableProductDetails').style.display = "block";
    document.getElementById('ddlCategory').value = p[2];
    document.getElementById('ddlCategory').disabled = true;
    //            document.getElementById('txtProductName').disabled = true;
    document.getElementById('txtPoQuantity').value = p[3];
    document.getElementById('txtPoUnit').value = p[4];
    document.getElementById('txtRcvdUnit').value = p[4];
    document.getElementById('txtRcvdUnit').readOnly = true;
    document.getElementById('txtPoQuantity').readOnly = true;
    document.getElementById('hdbTempQut').value = p[2];
    document.getElementById('txtBatchNo').value = '';
    //            
    document.getElementById('txtEXPDate').value = '';
    document.getElementById('txtMFTDate').value = '';
    document.getElementById('txtRECQuantity').value = parseFloat(parseFloat(p[3]).toFixed(2) - parseFloat(p[5]).toFixed(2)).toFixed(2);
    document.getElementById('hdnAllowedQty').value = parseFloat(parseFloat(p[3]).toFixed(2) - parseFloat(p[5]).toFixed(2)).toFixed(2);
    document.getElementById('ddlSelling').value = pSellUn.trim();

    //document.getElementById('ddlSelling').value = pSellUn;
    // document.getElementById('ddlSelling').disabled = true;

    document.getElementById('txtPoUnit').readOnly = true;

    document.getElementById('txtUnitPrice').value = parseFloat(pUniCostPr).toFixed(2);
    document.getElementById('txtTotalCost').value = 0.00;
    document.getElementById('txtTotalCost').readOnly = true;
    document.getElementById('txtCompQuantity').value = pCompQty;
    document.getElementById('txtTax').value = pTax;
    document.getElementById('txtDiscount').value = pDiscount;
    document.getElementById('add').value = 'Add';
    document.getElementById('hdnUnitCostPrice').value = parseFloat(pUniCostPr).toFixed(2);
    document.getElementById('hdnUnitSellingPrice').value = parseFloat(pUnitSellPr).toFixed(2);
    document.getElementById('hdnAdd').value = 'Add';
    //     document.getElementById('hdnAttributeDetail').value = '';

    document.getElementById('hdnType').value = '';
    document.getElementById('txtSellingPrice').value = parseFloat(pUnitSellPr).toFixed(2);
    document.getElementById('txtMRP').value = parseFloat(pMRP).toFixed(2);
    document.getElementById('txtRcvdLSUQty').value = '0.00';
    document.getElementById('txtInvoiceQty').value = pInQty;
    document.getElementById('txtRcvdLSUQty').readOnly = true;
    if (p[4] == 'Nos') {
        document.getElementById('ddlSelling').value = 'Nos';
        document.getElementById('txtInvoiceQty').value = 1;

        document.getElementById('txtInvoiceQty').disabled = true;
        //        document.getElementById('ddlSelling').disabled = true;
    }
    else {
        document.getElementById('txtInvoiceQty').value = pInQty;
        document.getElementById('txtInvoiceQty').disabled = false;
        //        document.getElementById('ddlSelling').disabled = false;
    }
    if (p[6] != 'N') {
        document.getElementById('hdnAttributes').value = p[6];
        document.getElementById('lbtnAttribute').style.display = "block"
    }
    else {
        document.getElementById('hdnAttributeDetail').value = p[6];
        document.getElementById('lbtnAttribute').style.display = "none"
        document.getElementById('hdnAttributes').value = "N";
    }
    CheckRcvdLSUQty();

    document.getElementById('hdnHasExpiryDate').value = p[7];
    document.getElementById('hdnHasBatchNo').value = p[8];
    if (p[10] != 'N') {
        document.getElementById('hdnUsageLimit').value = p[11];
    }



}

function checkDate1(obj) {

    var myValStr = document.getElementById(obj).value;
    if (myValStr != "__/____" && myValStr != "") {
        var Mon = myValStr.split('/')[0];
        var isTrue = false;

        var myMonth = new Array('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12');

        for (i = 0; i < myMonth.length; i++) {
            if (myMonth[i] != "" && Mon != "" && Mon == myMonth[i] && Mon.length == 2) {
                isTrue = true;
            }
        }

        if (!isTrue) {
            document.getElementById(obj).focus();
            var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_30") == null ? "Provide valid date" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_30");
            ValidationWindow(userMsg, errorMsg);
        }
        return isTrue;
    }


}


function AppendMRP() {
    //            if (document.getElementById('txtUnitPrice').value == 0.00 || document.getElementById('txtUnitPrice').value.trim() == "") {
    //                alert('Provide cost price');
    //                document.getElementById('txtUnitPrice').focus();
    //                return false;
    //            }
    //            if (document.getElementById('txtSellingPrice').value == 0.00 || document.getElementById('txtSellingPrice').value.trim() == "") {
    //                alert('Provide Selling Price');
    //                document.getElementById('txtSellingPrice').focus();
    //                return false;
    //            }
    //            if (Number(document.getElementById('txtSellingPrice').value) < Number(document.getElementById('txtUnitPrice').value)) {
    //                alert('Selling Price is less than Cost Price');
    //                document.getElementById('txtSellingPrice').select();
    //                return false;
    //            }
    getPrecision(document.getElementById('txtSellingPrice'));
    document.getElementById('txtMRP').value = document.getElementById('txtSellingPrice').value;
}


function CheckDatesMfg(splitChar, ObjDate, flag) {

    var today = new Date();
    var errormsg = SListForAppMsg.Get("CentralReceiving_Error") == null ? "Alert" : SListForAppMsg.Get("CentralReceiving_Error");
    if (ObjDate.value.trim() == "__/____") {
        document.getElementById('txtMFTDate').value == '';
        return true;
    } else {
    if (ObjDate.value.trim() == '') 
        {
            //alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
            if (flag == "MFG") {
                var UserMsg = SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_35") == null ? "Provide Manufactured Date!" : SListForAppDisplay.Get("CentralReceiving_Scripts_StockRecieve_js_35")
                ValidationWindow(UserMsg, errormsg);
            }
            else {
                var UserMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_36") == null ? "Provide Expiry Date!" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_36")
                ValidationWindow(UserMsg, errormsg);
            }
            ObjDate.select();
            return false;
        }
        else {
            //Assign From And To Date from Controls
            splitChar = ObjDate.value.split(' ').length > 1 ? splitChar : '/';
            var DateFrom = new Array(2);
            var DateNow = new Array(2);
            DateFrom[0] = (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1);
            DateFrom[1] = ObjDate.value.split(splitChar)[1];
            // DateTo = ("01" + splitChar + (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1) + splitChar + ObjDate.value.split(splitChar)[1]).split(splitChar);
            DateNow[0] = today.getMonth() + 1;
            DateNow[1] = today.getFullYear();
            var Ystring = DateFrom[1];
            //Argument Value 0 for validating Current Date And To Date
            //Argument Value 1 for validating Current From And To Date
            if (DateFrom[0] != "" && DateFrom[1] != "" && Ystring.length == 4) {
                if (doDateValidation(DateFrom, DateNow, 0)) {
                    //       alert("Validation Succeeded");
                    return true;
                }
                else {
                    ObjDate.select();
                    // alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
                    return false;
                }
            } else {
                ObjDate.select();
                //alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
                if (flag == "MFG") {
                    var UserMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_35") == null ? "Provide Manufactured Date!" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_35")
                    ValidationWindow(UserMsg, errormsg);
                }
                else {
                    var UserMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_36") == null ? "Provide Expiry Date!" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_36")
                    ValidationWindow(UserMsg, errormsg);
                }
                return false;
            }
        }
    }

}



function checkDetails() {
    //            alert("jkhjkh");
    if (DynamicProductList.length > 0 && $("#hdnProductList").val() == "") {
        $('[id$="hdnProductList"]').val(JSON.stringify(DynamicProductList));
        alert(DynamicProductList);
    }
    // debugger;
    for (var i = 0; i < DynamicProductList.length; i++) {
        if (DynamicProductList[i].IsScheduleHDrug == false) {
            var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_31") == null ? "Invalid Expiry/Manufacture Date Products in the Stock Receive table" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_31");
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
    }

    document.getElementById('btnFinish').style.display = 'none';
    if (document.getElementById('txtPurchaseOrderNo').value == '') {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_32") == null ? "Provide purchase order number" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_32");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtPurchaseOrderNo').focus();
        return false;
    }
    if (document.getElementById('txtReceivedDate').value == '') {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_06") == null ? "Select stock received date" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_06");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtReceivedDate').focus();
        document.getElementById('btnFinish').style.display = 'block';
        return false;
    }
    if (document.getElementById('ddlSupplier').value != null) {
        if (document.getElementById('ddlSupplier').value == '0') {
            var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_33") == null ? "Select the supplier name" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_33");
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('ddlSupplier').focus();
            return false;
        }
    }

    if (document.getElementById('hdnProductList').value == '') {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_34") == null ? "Check the product list" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_34");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('btnFinish').style.display = 'block';
        return false;
    }

    // if (document.getElementById('txtGrandTotal').value == 0.00 || document.getElementById('txtGrandTotal').value == '' || document.getElementById('hdnGrandTotal').value == 0 || document.getElementById('hdnGrandTotal').value == '') {
    // document.getElementById('hdnGrandTotal').value = document.getElementById('txtGrandTotal').value;
    // document.getElementById('hdnGrandTotal').value = document.getElementById('txtRoundOffValue').value;
    // alert('jayam');
    //alert(document.getElementById('hdnGrandTotal').value);
    // alert(document.getElementById('txtGrandTotal').value);
    // document.getElementById('btnFinish').style.display = 'block';
    // return false ;
    // }
    //else {
    // alert('Check the product list');
    //  document.getElementById('btnFinish').style.display = 'block';
    //  return false;
    // }

    if (document.getElementById('txtGrandTotal').value != 0.00) {
        document.getElementById('hdnGrandTotal').value = document.getElementById('txtGrandTotal').value;
        // document.getElementById('hdnGrandTotal').value = document.getElementById('txtRoundOffValue').value;
    } else {
        var userMsg = SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_34") == null ? "Check the product list" : SListForAppMsg.Get("CentralReceiving_Scripts_StockRecieve_js_34");
        ValidationWindow(userMsg, errorMsg);
        document.getElementById('btnFinish').style.display = 'block';
        return false;
    }

    return true;
}



function CheckInverseQty() {
    var productID = document.getElementById('hdnproductId').value;
    var pRECUnit = document.getElementById('txtRcvdUnit').value;
    var InvoiceQty = 0;
    //alert(productID);
    for (var i = 0; i < EditProductList.length; i++) {

        if (EditProductList[i].ProductID == productID) {
            InvoiceQty = EditProductList[i].InvoiceQty;
            break;
            //alert(EditProductList[i]);
            //alert(productID);
        }
    }

    var pSellingUnit = document.getElementById('ddlSelling').value; // document.getElementById('ddlSelling').value
    if (pRECUnit == pSellingUnit) {
        document.getElementById('txtInvoiceQty').value = 1;
        document.getElementById('txtInvoiceQty').disabled = true;
    }
    else {
        if (Number(InvoiceQty) == 0) {
            document.getElementById('txtInvoiceQty').value = '0.00';
        }
        else {
            document.getElementById('txtInvoiceQty').value = InvoiceQty;
        }

        document.getElementById('txtInvoiceQty').disabled = false;

    }
    CheckRcvdLSUQty();



}


function CheckDatesExpValue(splitChar, ObjDate, flag) {

    var today = new Date();

    if (ObjDate.trim() == '') {
        //        alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
        //        ObjDate.select();
        return false;
    }
    else {
        //Assign From And To Date from Controls
        splitChar = ObjDate.split(' ').length > 1 ? splitChar : '/';
        var DateFrom = new Array(2);
        var DateNow = new Array(2);
        DateFrom[0] = (getMonthValue(ObjDate.split(splitChar)[0]) + 1);
        DateFrom[1] = ObjDate.split(splitChar)[1];
        // DateTo = ("01" + splitChar + (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1) + splitChar + ObjDate.value.split(splitChar)[1]).split(splitChar);
        var Ystring = DateFrom[1];
        DateNow[0] = today.getMonth() + 1;
        DateNow[1] = today.getFullYear();
        //Argument Value 0 for validating Current Date And To Date
        //Argument Value 1 for validating Current From And To Date
        if (DateNow[0] != "" && DateNow[1] != "" && Ystring.length == 4) {
            if (doDateValidationValue(DateNow, DateFrom, 1)) {
                //       alert("Validation Succeeded");
                return true;
            }
            else {
                //                alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
                //                ObjDate.select();
                return false;
            }
        }
        else {
            //            alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
            //            ObjDate.select();
            return false;
        }

    }
    return true;

}


function CheckDatesMfgValue(splitChar, ObjDate, flag) {

    var today = new Date();

    if (ObjDate.trim() == "__/____" || ObjDate.trim() == "") {
        // document.getElementById('txtMFTDate').value == '';
        return false;
    }
    else {
        if (ObjDate.trim() == '') {
            //                 alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
            //                 ObjDate.select();
            return false;
        }
        else {
            //Assign From And To Date from Controls
            splitChar = ObjDate.split(' ').length > 1 ? splitChar : '/';
            var DateFrom = new Array(2);
            var DateNow = new Array(2);
            DateFrom[0] = (getMonthValue(ObjDate.split(splitChar)[0]) + 1);
            DateFrom[1] = ObjDate.split(splitChar)[1];
            // DateTo = ("01" + splitChar + (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1) + splitChar + ObjDate.value.split(splitChar)[1]).split(splitChar);
            DateNow[0] = today.getMonth() + 1;
            DateNow[1] = today.getFullYear();
            var Ystring = DateFrom[1];
            //Argument Value 0 for validating Current Date And To Date
            //Argument Value 1 for validating Current From And To Date
            if (DateFrom[0] != "" && DateFrom[1] != "" && Ystring.length == 4) {
                if (doDateValidationValue(DateFrom, DateNow, 0)) {
                    //       alert("Validation Succeeded");
                    return true;
                }
                else {
                    //                         ObjDate.select();
                    //                         alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
                    return false;
                }
            }
            else {
                //                     ObjDate.select();
                //                     alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
                return false;
            }
        }
    }

}



function doDateValidationValue(from, to, bit) {
    var monthFlag = true;
    var i = from.length - 1;
    if (Number(to[i]) >= Number(from[i])) {
        if (Number(to[i]) == Number(from[i])) {
            monthFlag = false;
        }
        i--;
        if (Number(to[i]) >= Number(from[i])) {
            return true;
        }
        else if (monthFlag) {
            return true;
        }
        else {

            return false;
        }
    }
    else {
        if (from[0] != "____") {

            return false;
        }
    }
}

