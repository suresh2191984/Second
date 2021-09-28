<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UpdateStockReceived.aspx.cs"
    Inherits="StockReceived_UpdateStockReceived" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/InventoryCommon/Controls/INVAttributes.ascx" TagName="INVAttributes"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Stock Received Update</title>

    <style>
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
        </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <script language="javascript" type="text/javascript">
            var ErrorMsg = SListForAppMsg.Get("StockReceived_Error") == null ? "Alert" : SListForAppMsg.Get("StockReceived_Error");
            var infromMsg = SListForAppMsg.Get("StockReceived_Information") == null ? "Information" : SListForAppMsg.Get("StockReceived_Information");
            var OkMsg = SListForAppMsg.Get("StockReceived_Ok") == null ? "Ok" : SListForAppMsg.Get("StockReceived_Ok");
            var CancelMsg = SListForAppMsg.Get("StockReceived_Cancel") == null ? "Cancel" : SListForAppMsg.Get("StockReceived_Cancel");
        </script>
        <script language="javascript" type="text/javascript">
            var userMsg;
            var CGST = 0;
            var SGST = 0;
            var IGST = 0;
            function onGridViewRowSelected(pqty, pqu, rqu, rqty, up, tax, dis, tc, Nominal, schedisc) {

                if ($("#hdnRecdProducts").val() == "Y" && rqty.value == "0.00") {
                    rqty.value = (parseFloat(ToInternalFormat($('#' + pqty.id))).toFixed(2)).toString();
                    ToTargetFormat($('#' + rqty.id));
                    document.getElementById('ckbdeleteProd').checked = false;
                    document.getElementById('hdnDeleteprod').value = "N";
                    ValidationWindow("Only one product delete option not allowed. please do the process from CANCEL PO.", ErrorMsg);
                    return false;
                }
                
                calculateCastPerUnit();
                var v9 = document.getElementById('lblGrandTotal');
                //var v9 = ToInternalFormat($('#lblGrandTotal'));
                var tempTC = ToInternalFormat($('#' + tc.id));
                var pDiscount, pschDiscount;
                Nominal.value = (rqty.value == "") ? (parseFloat("0").toFixed(2)).toString() : (parseFloat(ToInternalFormat($('#' + Nominal.id))).toFixed(2)).toString();
                ToTargetFormat($('#' + Nominal.id));
                rqty.value = (rqty.value == "") ? (parseFloat("0").toFixed(2)).toString() : (parseFloat(ToInternalFormat($('#' + rqty.id))).toFixed(2)).toString();
                ToTargetFormat($('#' + rqty.id));
                //up.value = (up.value == "") ? (parseFloat("0").toFixed(2)).toString() : (parseFloat(up.value).toFixed(2)).toString();
                up.value = (up.value == "") ? (parseFloat("0").toFixed(2)).toString() : (parseFloat(ToInternalFormat($('#' + up.id))).toFixed(2)).toString();
                ToTargetFormat($('#' + up.id));
                //tax.value = (tax.value == "") ? (parseFloat("0").toFixed(2)).toString() : (parseFloat(tax.value).toFixed(2)).toString();
                tax.value = (tax.value == "") ? (parseFloat("0").toFixed(2)).toString() : (parseFloat(ToInternalFormat($('#' + tax.id))).toFixed(2)).toString();
                ToTargetFormat($('#' + tax.id));
                //dis.value = (dis.value == "") ? (parseFloat("0").toFixed(2)).toString() : (parseFloat(dis.value).toFixed(2)).toString();
                dis.value = (dis.value == "") ? (parseFloat("0").toFixed(2)).toString() : (parseFloat(ToInternalFormat($('#' + dis.id))).toFixed(2)).toString();
                ToTargetFormat($('#' + dis.id));
                
                schedisc.value =(schedisc.value == "") ? (parseFloat("0").toFixed(2)).toString() : (parseFloat(ToInternalFormat($('#' + schedisc.id))).toFixed(2)).toString();
                

                if ((parseFloat(ToInternalFormat($('#' + rqty.id))) != 0) && (parseFloat(ToInternalFormat($('#' + up.id))) != 0)) {

                    //  var total = (parseFloat(ToInternalFormat($('#' + rqty.id))) * parseFloat(ToInternalFormat($('#' + up.id)))).toFixed(2);
                    //Nominal Discount Calculation 
                    var total = (parseFloat(ToInternalFormat($('#' + rqty.id))) * (parseFloat(ToInternalFormat($('#' + up.id))) - parseFloat(ToInternalFormat($('#' + Nominal.id))))).toFixed(2);
                    
                    var SchemeInValue = $('#<%=ddlSchemetype.ClientID %> option:selected').val();
                    var DiscInValue = $('#<%=ddlDisctype.ClientID %> option:selected').val();
                    
                    if($('#hdnIsSchemeDiscount').val()== "Y") {
                        if(SchemeInValue == 0){
                          pschDiscount = parseFloat(parseFloat(parseFloat(total) / parseFloat(100)) * parseFloat(ToInternalFormat($('#' + schedisc.id)))).toFixed(2);
                        }
                        else{
                          pschDiscount = parseFloat(schedisc.value).toFixed(2);
                        }
            
                        total = parseFloat(parseFloat(total) - parseFloat(pschDiscount)).toFixed(2);
                    }
                    else {
                        total = parseFloat(total).toFixed(2);
                    }
        
                    if(DiscInValue == 0){
                       pDiscount = parseFloat(parseFloat(parseFloat(total) / parseFloat(100)) * parseFloat(ToInternalFormat($('#' + dis.id)))).toFixed(2);
                    }
                    else {
                       pDiscount = parseFloat(dis.value).toFixed(2);
                    }
                            
                    //Total = parseFloat(parseFloat(total) - parseFloat(pDiscount)).toFixed(2);
                    
                    //pDiscount = parseFloat(parseFloat(parseFloat(total) / parseFloat(100)) * parseFloat(ToInternalFormat($('#' + dis.id)))).toFixed(2);

                    var subtotal = (parseFloat(total) - parseFloat(pDiscount)).toFixed(2);

                    var tempTaxAmt = parseFloat(parseFloat(parseFloat(subtotal) / parseFloat(100)) * parseFloat(tax.value)).toFixed(2);

                    tc.value = parseFloat(parseFloat(subtotal) + parseFloat(tempTaxAmt)).toFixed(2);
                    ToTargetFormat($('#' + tc.id));
                }
                else {
                    tc.value = "0.00";
                    ToTargetFormat($('#' + tc.id));
                    dis.value = "0.00";
                    ToTargetFormat($('#' + dis.id));
                    schedisc.value = "0.00";
                    ToTargetFormat($('#' + schedisc.id));
                    var userMsg = SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_01") == null ? "Check quantity and unit price" : SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_01");
                    ValidationWindow(userMsg, ErrorMsg);
                    return false;
                }

                v9.innerHTML = (((parseFloat(ToInternalFormat($('#' + v9.id))) - parseFloat(ToInternalFormat($('#' + tempTC.id)))) + parseFloat(ToInternalFormat($('#' + tc.id)))).toFixed(2)).toString();
                ToTargetFormat($('#' + v9.id));
                btnCalcSellingPrice();
                //            document.getElementById('hdnGrandPOTotal').value = parseFloat(v9.innerText);
                //            checkAddToTotal();

            }

            function calculateCastPerUnit() {

                var IsRecd = document.getElementById('hdnIsResdCalc').value;
                var NominalDiscount = document.getElementById('txtNominal').value == "" ? 0 : document.getElementById('txtNominal').value;
                NominalDiscount = ToInternalFormat($('#txtNominal')) == 0.00 ? 0 : ToInternalFormat($('#txtNominal'));
                var UnitCostPrice = ToInternalFormat($('#txtCostPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtCostPrice'));
                if (IsRecd == 'SUnit') {

                    // var UnitPrice = document.getElementById('txtCostPrice').value == 0.00 ? 0 : document.getElementById('txtCostPrice').value;
                    var UnitPrice = ToInternalFormat($('#txtCostPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtCostPrice'));
                    //var Inverse = document.getElementById('txtInvQty').value == 0.00 ? 0 : document.getElementById('txtInvQty').value;
                    var Inverse = ToInternalFormat($('#txtInvQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvQty'));
                    document.getElementById('hdnUnitCostPrice').value = parseFloat(UnitPrice).toFixed(6);
                    //ToTargetFormat($('#hdnUnitCostPrice'));
                }
                if (IsRecd == 'PoUnit') {

                    // var UnitPrice = ToInternalFormat($('#txtCostPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtCostPrice'));
                    var UnitPrice = NominalDiscount > 0 ? (parseFloat(UnitCostPrice) - parseFloat(NominalDiscount)).toFixed(6) : UnitCostPrice;

                    var Inverse = ToInternalFormat($('#txtInvQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvQty'));
                    document.getElementById('hdnUnitCostPrice').value = (parseFloat(UnitPrice) / parseFloat(Inverse)).toFixed(6);
                    //ToTargetFormat($('#hdnUnitCostPrice'));
                }

                if (IsRecd == 'RPoUnit') {

                    //var UnitPrice = document.getElementById('txtCostPrice').value == 0.00 ? 0 : document.getElementById('txtCostPrice').value;
                    var UnitPrice = ToInternalFormat($('#txtCostPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtCostPrice'));
                    //var RecdQty = document.getElementById('txtRecdQty').value == 0.00 ? 0 : document.getElementById('txtRecdQty').value;
                    var RecdQty = ToInternalFormat($('#txtRecdQty')) == 0.00 ? 0 : ToInternalFormat($('#txtRecdQty'));
                    var perUnit = (parseFloat(UnitPrice) / parseFloat(RecdQty)).toFixed(6);
                    //var Inverse = document.getElementById('txtInvQty').value;
                    var Inverse = ToInternalFormat($('#txtInvQty'));
                    document.getElementById('hdnUnitCostPrice').value = (parseFloat(perUnit) / parseFloat(Inverse)).toFixed(6);
                    // ToTargetFormat($('#hdnUnitCostPrice'));
                }
                if (IsRecd == 'RLsuSell') {
                    //var UnitPrice = document.getElementById('txtCostPrice').value == 0.00 ? 0 : document.getElementById('txtCostPrice').value;
                    var UnitPrice = ToInternalFormat($('#txtCostPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtCostPrice'));
                    //var Inverse = document.getElementById('txtInvQty').value == 0.00 ? 0 : document.getElementById('txtInvQty').value;
                    var Inverse = ToInternalFormat($('#txtInvQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvQty'));
                    //var RecdQtylsu = document.getElementById('txtRecLSUQty').value == 0.00 ? 0 : document.getElementById('txtRecLSUQty').value;
                    var RecdQtylsu = ToInternalFormat($('#txtRecLSUQty')) == 0.00 ? 0 : ToInternalFormat($('#txtRecLSUQty'));
                    var perUnitLsu = (parseFloat(UnitPrice) / parseFloat(RecdQtylsu)).toFixed(6);
                    document.getElementById('hdnUnitCostPrice').value = parseFloat(perUnitLsu).toFixed(6);
                    // ToTargetFormat($('#hdnUnitCostPrice'));

                }
            }
            function btnCalcSellingPrice() {
                var IsRecd = document.getElementById('hdnIsResdCalc').value;
                if (IsRecd == 'SUnit') {
                    //var pSellingPrice = document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
                    var pSellingPrice = ToInternalFormat($('#txtSellingPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtSellingPrice'));
                    //var Inverse = document.getElementById('txtInvQty').value == 0.00 ? 0 : document.getElementById('txtInvQty').value;
                    var Inverse = ToInternalFormat($('#txtInvQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvQty'));
                    document.getElementById('hdnUnitSellingPrice').value = parseFloat(pSellingPrice).toFixed(6);
                    ToTargetFormat($('#hdnUnitSellingPrice'));
                }
                if (IsRecd == 'PoUnit') {
                    //var pSellingPrice = document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
                    var pSellingPrice = ToInternalFormat($('#txtSellingPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtSellingPrice'));
                    // var Inverse = document.getElementById('txtInvQty').value == 0.00 ? 0 : document.getElementById('txtInvQty').value;
                    var Inverse = ToInternalFormat($('#txtInvQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvQty'));
                    document.getElementById('hdnUnitSellingPrice').value = (parseFloat(pSellingPrice) / parseFloat(Inverse)).toFixed(6);
                    ToTargetFormat($('#hdnUnitSellingPrice'));

                }

                if (IsRecd == 'RPoUnit') {

                    //var pSellingPrice = document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
                    var pSellingPrice = ToInternalFormat($('#txtSellingPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtSellingPrice'));
                    //var RecdQty = document.getElementById('txtRecdQty').value == 0.00 ? 0 : document.getElementById('txtRecdQty').value;
                    var RecdQty = ToInternalFormat($('#txtRecdQty')) == 0.00 ? 0 : ToInternalFormat($('#txtRecdQty'));
                    var perUnit = (parseFloat(pSellingPrice) / parseFloat(RecdQty)).toFixed(6);
                    // var Inverse = document.getElementById('txtInvQty').value;
                    var Inverse = ToInternalFormat($('#txtInvQty'));
                    document.getElementById('hdnUnitSellingPrice').value = (parseFloat(perUnit) / parseFloat(Inverse)).toFixed(6);
                    ToTargetFormat($('#hdnUnitSellingPrice'));
                }
                if (IsRecd == 'RLsuSell') {
                    //var pSellingPrice = document.getElementById('txtSellingPrice').value == 0.00 ? 0 : document.getElementById('txtSellingPrice').value;
                    var pSellingPrice = ToInternalFormat($('#txtSellingPrice')) == 0.00 ? 0 : ToInternalFormat($('#txtSellingPrice'));
                    //var Inverse = document.getElementById('txtInvQty').value == 0.00 ? 0 : document.getElementById('txtInvQty').value;
                    var Inverse = ToInternalFormat($('#txtInvQty')) == 0.00 ? 0 : ToInternalFormat($('#txtInvQty'));
                    //var RecdQtylsu = document.getElementById('txtRecLSUQty').value == 0.00 ? 0 : document.getElementById('txtRecLSUQty').value;
                    var RecdQtylsu = ToInternalFormat($('#txtRecLSUQty')) == 0.00 ? 0 : ToInternalFormat($('#txtRecLSUQty'));
                    var perUnitLsu = (parseFloat(pSellingPrice) / parseFloat(RecdQtylsu)).toFixed(6);
                    document.getElementById('hdnUnitSellingPrice').value = parseFloat(perUnitLsu).toFixed(6);
                    ToTargetFormat($('#hdnUnitSellingPrice'));
                }

            }


            function calculateLSU(rcvdQty, invQty, lsu) {
                var v1 = ToInternalFormat($('#' + rcvdQty)); //document.getElementById(rcvdQty);
                var v2 = ToInternalFormat($('#' + invQty)); //document.getElementById(invQty);
                var v3 = ToInternalFormat($('#' + lsu)); // document.getElementById(lsu);
                if (parseFloat(v2) == 0 || isNaN(v2) || v2 == "") {

                    document.getElementById(invQty).value = 1;
                    ToTargetFormat($('#' + invQty));
                }
                document.getElementById(lsu).value = ((parseFloat(v1) * parseFloat(v2)).toFixed(2)).toString();
                ToTargetFormat($('#' + invQty));
                if (document.getElementById('txtRecdQtyUnit').value == 'Nos') {
                    // document.getElementById('ddlSellingUnit').options[document.getElementById('ddlSellingUnit').selectedIndex].text = 'Nos';
                    $('[name=ddlSellingUnit] option').filter(function () {
                        return ($(this).text() == 'Nos'); //To select Blue
                    }).prop('selected', true);
                    document.getElementById('txtInvQty').value = '1.00';
                    ToTargetFormat($('#txtInvQty'));
                    document.getElementById('txtInvQty').disabled = true;
                }
            }
            function CheckUnit() {
                // $("ddlSellingUnit :selected").val()
                if (document.getElementById('ddlSellingUnit').options[document.getElementById('ddlSellingUnit').selectedIndex].value == '0') {
                    var userMsg = SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_02") == null ? "Select the selling unit" : SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_02");
                    ValidationWindow(userMsg, ErrorMsg);
                    return false;
                    //}
                }
                onGridViewRowSelected(document.getElementById('txtPOQty'), document.getElementById('txtPOQtyUnit'), document.getElementById('txtRecdQtyUnit'),
                        document.getElementById('txtRecdQty'), document.getElementById('txtCostPrice'), document.getElementById('txtTax'), document.getElementById('txtDiscount'), document.getElementById('txtProdTotalCost'), document.getElementById('txtNominal'), document.getElementById('txtSchemeDisc'));
                return true;
            }

            function hidePopup() {

                $('#divProductEdit').removeClass().addClass('hide');
                showResponses('ACX2OPPmt', 'ACX2minusOPPmt', 'ACX2responsesOPPmt', 1);
                return false;

            }

            function setRecQuantity(rqty, poqty) {
                var v1 = ToInternalFormat($('#' + rqty)); // document.getElementById(rqty);
                var v2 = ToInternalFormat($('#' + poqty));
                if (parseFloat(v1) > parseFloat(v2)) {
                    var userMsg = SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_03") == null ? "Received quantity exceeds ordered quantity" : SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_03");
                    ValidationWindow(userMsg, ErrorMsg);
                    return false;

                    document.getElementById(rqty).value = (parseFloat(v2).toFixed(2)).toString();
                    ToTargetFormat($('#' + rqty));
                }

                var RecdQty = ToInternalFormat($('#' + rqty));
                if (RecdQty == 0) {
                    if ($("#hdnRecdProducts").val() == "Y") {
                        document.getElementById(rqty).value = (parseFloat(v1).toFixed(2)).toString();
                        document.getElementById('ckbdeleteProd').checked = false;
                        document.getElementById('hdnDeleteprod').value = "N";
                    }
                    else {
                        document.getElementById('ckbdeleteProd').checked = true;
                        document.getElementById('hdnDeleteprod').value = "Y";
                        
                        document.getElementById('txtCompQty').value = "0.00";
                        ToTargetFormat($('#txtCompQty'));
                        document.getElementById('txtCostPrice').value = "0.00";
                        ToTargetFormat($('#txtCostPrice'));
                        document.getElementById('txtSellingPrice').value = "0.00";
                        ToTargetFormat($('#txtSellingPrice'));
                        document.getElementById('txtMRP').value = "0.00";
                        ToTargetFormat($('#txtMRP'));
                    }
                }
                else {
                    document.getElementById('ckbdeleteProd').checked = false;
                    document.getElementById('hdnDeleteprod').value = "N";
                }

            }

            function CheckBatch(batch) {
                //var batch = document.getElementById('txtBatchNo');
                if (batch.value == '') {
                    var userMsg = SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_04") == null ? "Provide the batch number" : SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_04");
                    ValidationWindow(userMsg, ErrorMsg);
                    return false;
                    batch.focus();
                }
            }

            function CheckFields(sp, cqty) {

                var v1 = ToInternalFormat($('#' + sp)); //document.getElementById(sp);
                var v2 = ToInternalFormat($('#' + cqty)); // document.getElementById(cqty);
                var tempSP = ToInternalFormat($('#' + sp)); // document.getElementById(sp);

                if (v1 == "" || parseFloat(v1) == 0) {
                    var userMsg = SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_05") == null ? "Selling price should not be zero" : SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_05");
                    ValidationWindow(userMsg, ErrorMsg);
                    return false;

                    //v1.value = v1.defaultValue;
                    // document.getElementById(sp).value
                    document.getElementById(sp).value = (parseFloat("0").toFixed(2)).toString();
                    ToTargetFormat($('#' + sp));
                }
                else {
                    // v1.value = (parseFloat(v1.value).toFixed(2)).toString();
                    document.getElementById(sp).value = (parseFloat(v1).toFixed(2)).toString();
                    ToTargetFormat($('#' + sp));
                }
                //v2.value = (v2.value == "" || parseFloat(v2.value) == 0) ? (parseFloat("0").toFixed(2)).toString() : (parseFloat(v2.value).toFixed(2)).toString();
                btnCalcSellingPrice();

            }


            function ValidateDate(mfg, exp) {

                if (mfg.value == '') {

                    var userMsg = SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_06") == null ? "Select manufacture date" : SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_06");
                    ValidationWindow(userMsg, ErrorMsg);
                    return false;
                    mfg.focus();
                    return false;
                }
                else if (exp.value == '') {
                    var userMsg = SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_07") == null ? "Select expiry date" : SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_07");
                    ValidationWindow(userMsg, ErrorMsg);
                    exp.focus();
                    return false;
                }
                //            else {
                //                return checkFromDateToDate(mftDate,expDate);
                //            }
            }

            function UpdateProductDetail(selProduct) {

                var product = selProduct.split('~');
                showResponses('ACX2OPPmt', 'ACX2minusOPPmt', 'ACX2responsesOPPmt', 0);
                //document.getElementById('divProductEdit').style.display = "block";
                $('#divProductEdit').removeClass().addClass('show');


                document.getElementById('hdnproductId').value = product[0];

                document.getElementById('txtProduct').value = product[1];
                document.getElementById('txtProduct').disabled = true;
                document.getElementById('txtPOQty').value = product[2];
                document.getElementById('txtPOQty').disabled = true;
                document.getElementById('txtBatchNo').value = product[3]; //
                document.getElementById('txtMFT').value = product[4];
                document.getElementById('txtEXP').value = product[5];
                document.getElementById('txtRecdQty').value = product[6];
                // document.getElementById('txtEXP').disabled = true;
                // document.getElementById('txtMFT').disabled = true;
                document.getElementById('txtCompQty').value = product[7];
                document.getElementById('txtCostPrice').value = parseFloat(product[24]).toFixed(2);
                ToTargetFormat($('#txtCostPrice'));
//                document.getElementById('txtDiscount').value = product[10];
//                ToTargetFormat($('#txtDiscount'));
                
                document.getElementById('txtTax').value = product[11];
                ToTargetFormat($('#txtTax'));

                /* Start*/
                if (document.getElementById("CheckState").value == "Y") {
                    CGST = product[11] / 2;
                    SGST = product[11] / 2;
                    IGST = 0

                }
                else {
                    IGST = product[11];
                    CGST = 0;
                    SGST = 0;
                }
                $('.ww-300').html('<table class="gsttbl" border="1" rules="all"><tr><td>CGST(%)</td><td>SGST(%)</td><td>IGST(%)</td></tr><tr><td>' + CGST + '</td><td>' + SGST + '</td><td>' + IGST + '</td></tr></table>');
                /* END*/


                document.getElementById('txtProdTotalCost').value = product[12];
                ToTargetFormat($('#txtProdTotalCost'));
                document.getElementById('txtProdTotalCost').disabled = true;
                document.getElementById('hdnSellingUnit').value = product[13];
                ToTargetFormat($('#hdnSellingUnit'));
                $('[name=ddlSellingUnit] option').filter(function () {
                    return ($(this).text() == product[13]); //To select Blue
                }).prop('selected', true);

                $('#ddlSellingUnit option:not(:selected)').prop('disabled', true);

                //document.getElementById('ddlSellingUnit').options[document.getElementById('ddlSellingUnit').selectedIndex].text = product[13];
                document.getElementById('hdnRidItem').value = product[14];
                document.getElementById('txtPOQtyUnit').value = product[15];
                document.getElementById('txtPOQtyUnit').disabled = true;
                document.getElementById('txtRecdQtyUnit').value = product[16];
                document.getElementById('txtRecdQtyUnit').disabled = true;
                document.getElementById('txtInvQty').value = product[17];
                document.getElementById('txtRecLSUQty').value = product[18]; //


                document.getElementById('txtRecLSUQty').disabled = true;
                document.getElementById('txtSellingPrice').value = parseFloat(product[25]).toFixed(2);
                ToTargetFormat($('#txtSellingPrice'));
                document.getElementById('hdnAttributes').value = product[20];
                document.getElementById('hdnAttributeDetail').value = product[21];
                if (product[20] != "N") {

                    $('#tdAttrip').removeClass().addClass('show');
                }
                if (product[20] == "N") {

                    $('#tdAttrip').removeClass().addClass('hide');

                }
                if (product[26] != "N") {
                    document.getElementById('hdnUsageLimit').value = product[27];
                }
                document.getElementById('txtRakNo').value = product[28];
                document.getElementById('txtMRP').value = product[29];
                document.getElementById('txtNominal').value = product[30];
                document.getElementById('txtpurchasetax').value = product[31];
                document.getElementById('hdnstockreceiveno').value = product[32];
                //calcTotalCost(product[19], product[12], product[11], product[10], product[18], product[6], product[17]);
                document.getElementById('hdnHsncode').value = product[33];

                if(product[34] == 0) {
                  document.getElementById('ddlSchemetype').value = 1;
                  document.getElementById('txtSchemeDisc').value = product[35];
                }
                else {
                   document.getElementById('ddlSchemetype').value = 0;
                   document.getElementById('txtSchemeDisc').value = product[34];
                }
                
                
                if(product[36] == 0){
                  document.getElementById('ddlDisctype').value = 1;
                  document.getElementById('txtDiscount').value = product[10];
                }
                else {
                   document.getElementById('ddlDisctype').value = 0;
                   document.getElementById('txtDiscount').value = product[36];
                }

                document.getElementById('hdnDeleteprod').value = product[37];
                if (product[37] == "Y") {
                    document.getElementById('ckbdeleteProd').checked = true;
                }
                else {
                    document.getElementById('ckbdeleteProd').checked = false;
                }
            }

            function calcTotalCost(SellingPrice, TotalCost, Tax, Discount, LsuQty, Qty, InvocQty) {
                var IsRecd = document.getElementById('hdnIsResdCalc').value;
                if (IsRecd == 'SUnit') {
                    document.getElementById('txtSellingPrice').value = parseFloat(SellingPrice).toFixed(2);
                    ToTargetFormat($('#txtSellingPrice'));
                    document.getElementById('txtCostPrice').value = parseFloat(((parseFloat(TotalCost) * 100) / (100 + parseFloat(Tax))) + parseFloat(Discount)) / (parseFloat(LsuQty)).toFixed(2);
                    ToTargetFormat($('#txtCostPrice'));
                }
                if (IsRecd == 'PoUnit') {
                    document.getElementById('txtSellingPrice').value = parseFloat(parseFloat(SellingPrice)) * (parseFloat(InvocQty)).toFixed(2);
                    ToTargetFormat($('#txtSellingPrice'));
                    document.getElementById('txtCostPrice').value = parseFloat((((parseFloat(TotalCost) * 100) / (100 + parseFloat(Tax))) + parseFloat(Discount)) / parseFloat(LsuQty)) * (parseFloat(InvocQty)).toFixed(2);
                    ToTargetFormat($('#txtCostPrice'));
                }

                if (IsRecd == 'RPoUnit') {

                    document.getElementById('txtSellingPrice').value = parseFloat(parseFloat(SellingPrice) * parseFloat(Qty)).toFixed(2);
                    ToTargetFormat($('#txtSellingPrice'));
                    document.getElementById('txtCostPrice').value = parseFloat((((parseFloat(TotalCost) * 100) / (100 + parseFloat(Tax))) + parseFloat(Discount)) / parseFloat(Qty)) * (parseFloat(Qty)).toFixed(2);
                    ToTargetFormat($('#txtCostPrice'));
                }
                if (IsRecd == 'RLsuSell') {
                    document.getElementById('txtSellingPrice').value = parseFloat(parseFloat(SellingPrice) * parseFloat(LsuQty)).toFixed(2);
                    ToTargetFormat($('#txtSellingPrice'));
                    document.getElementById('txtCostPrice').value = parseFloat(((((parseFloat(TotalCost) * 100) / (100 + parseFloat(Tax))) + parseFloat(Discount)) / parseFloat(LsuQty)) * (parseFloat(LsuQty))).toFixed(2);
                    ToTargetFormat($('#txtCostPrice'));

                }

            }

            function checkSellingUnit() {
                if (document.getElementById('ddlSellingUnit').options[document.getElementById('ddlSellingUnit').selectedIndex].value == '0') {
                    var userMsg = SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_02") == null ? "Select the selling unit" : SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_02");
                    ValidationWindow(userMsg, ErrorMsg);
                    document.getElementById('ddlSellingUnit').focus();
                    return false;
                }
                if (document.getElementById('ddlSellingUnit').options[document.getElementById('ddlSellingUnit').selectedIndex].text == document.getElementById('txtRecdQtyUnit').value) {
                    document.getElementById('txtInvQty').value = '1.00';
                    ToTargetFormat($('#txtInvQty'));
                    document.getElementById('txtInvQty').disabled = true;
                }
                document.getElementById('hdnSellingUnit').value = document.getElementById('ddlSellingUnit').options[document.getElementById('ddlSellingUnit').selectedIndex].text;


            }
            function onShowOnClick() {
                showResponses('ACX2OPPmt', 'ACX2minusOPPmt', 'ACX2responsesOPPmt', 1);
                // document.getElementById('divProductEdit').style.display = "none";
                $('#divProductEdit').removeClass().addClass('hide');
            }

            function onHideOnClick() {
                showResponses('ACX2OPPmt', 'ACX2minusOPPmt', 'ACX2responsesOPPmt', 0);
            }
            function AppendMRP() {
                document.getElementById('txtMRP').value = document.getElementById('txtSellingPrice').value;
                ToTargetFormat($('#txtSellingPrice'));
            }
            
            function Changedropdowntype() {
                onGridViewRowSelected(document.getElementById('txtPOQty'), document.getElementById('txtPOQtyUnit'), document.getElementById('txtRecdQtyUnit'),
                        document.getElementById('txtRecdQty'), document.getElementById('txtCostPrice'), document.getElementById('txtTax'), document.getElementById('txtDiscount'), document.getElementById('txtProdTotalCost'), document.getElementById('txtNominal'), document.getElementById('txtSchemeDisc'));
            };
            
            function CollectedItem() {

                var pRid = document.getElementById('hdnRidItem').value;

                var pProId = document.getElementById('hdnproductId').value;
                var pProName = document.getElementById('txtProduct').value;
                var pPoQty = document.getElementById('txtPOQty').value;
                var pBatchNo = document.getElementById('txtBatchNo').value;
                var pRecdQty = document.getElementById('txtRecdQty').value;
                var pMftDate = document.getElementById('txtMFT').value;
                var pExpDate = document.getElementById('txtEXP').value;
                var pSellingUnit = document.getElementById('ddlSellingUnit').options[document.getElementById('ddlSellingUnit').selectedIndex].text;
                var pCompQty = document.getElementById('txtCompQty').value;
                var pCostPrice = document.getElementById('txtCostPrice').value;
                //var pDisc = document.getElementById('txtDiscount').value;
                var pTax = document.getElementById('txtTax').value;
                var pTotalCost = document.getElementById('txtProdTotalCost').value;
                var pPoUnit = document.getElementById('txtPOQtyUnit').value;
                var pRecdUnit = document.getElementById('txtRecdQtyUnit').value;
                var pInvQty = document.getElementById('txtInvQty').value;
                var pRecdLsuQty = document.getElementById('txtRecLSUQty').value;
                var pSellingPrice = document.getElementById('txtSellingPrice').value;
                var pAttrip = document.getElementById('hdnAttributes').value;
                var pAttripValue = document.getElementById('hdnAttributeDetail').value;
                var perunitSellingPrice = document.getElementById('hdnUnitSellingPrice').value;
                var perunitCostPrice = document.getElementById('hdnUnitCostPrice').value;
                var pRakNo = document.getElementById('txtRakNo').value;
                var pMRP = document.getElementById('txtMRP').value;
                var pNominal = document.getElementById('txtNominal').value;
                var purchasetax = document.getElementById("txtpurchasetax").value;
                var receiveduniqno = document.getElementById("hdnstockreceiveno").value;
                var hdnHsncode = document.getElementById('hdnHsncode').value;
                var pSchemeType = document.getElementById('ddlSchemetype').value;
                var pSchemeDisc = document.getElementById('txtSchemeDisc').value;
                var pDiscType = document.getElementById('ddlDisctype').value;
                
                var pschemeDcount, pDcount, pSType, pDType;
                var IsNeedSchemeInValue = $('#<%=ddlSchemetype.ClientID %> option:selected').val();
                var IsNeedDiscInValue = $('#<%=ddlDisctype.ClientID %> option:selected').val();
                
                var Discount = ToInternalFormat($("#txtDiscount")) == 0.00 ? 0 : ToInternalFormat($("#txtDiscount"));
                var SchemeDiscount = ToInternalFormat($("#txtSchemeDisc")) == 0.00 ? 0 : ToInternalFormat($("#txtSchemeDisc"));
                
                var TotalCost = (parseFloat(pRecdLsuQty) * parseFloat(perunitCostPrice)).toFixed(2);

                //value of Delete Product (CheckBox)
                var hdnDeleteprod = "N"
                if (pRecdLsuQty == "0.00" && document.getElementById('ckbdeleteProd').checked == true) {
                    document.getElementById('hdnDeleteprod').value = "Y";
                }

                if ($('#hdnIsSchemeDiscount').val() == "Y") {
                    if(IsNeedSchemeInValue == 0){
                      pschemeDcount = parseFloat(parseFloat(parseFloat(TotalCost) / parseFloat(100)) * parseFloat(SchemeDiscount)).toFixed(2);
                      pSType = SchemeDiscount;
                    }
                    else{
                      pschemeDcount = parseFloat(SchemeDiscount).toFixed(2);
                      pSType = 0;
                    }
                    
                    TotalCost = parseFloat(parseFloat(TotalCost) - parseFloat(pschemeDcount)).toFixed(2);
                }
                else {
                    TotalCost = parseFloat(TotalCost).toFixed(2);
                    pschemeDcount = 0;
                    pSType = 0;
                }
        
                if(IsNeedDiscInValue == 0){
                   pDcount = parseFloat(parseFloat(parseFloat(TotalCost) / parseFloat(100)) * parseFloat(Discount)).toFixed(2);
                   pDType = Discount;
                }
                else {
                   pDcount = parseFloat(Discount).toFixed(2);
                   pDType = 0;
                }
                
                document.getElementById('hdnProductsList').value = pProId + '~' +
                                pProName + '~' + pPoQty + '~' + pBatchNo + '~' +
                                pMftDate + '~' + pExpDate + '~' + pRecdQty + '~' +
                                pCompQty + '~' + '' + '~' + pCostPrice + '~' + pDcount + '~' + pTax + '~' +
                                pTotalCost + '~' + pSellingUnit + '~' + pRid + '~' + pPoUnit + '~' + pRecdUnit + '~' +
                                pInvQty + '~' + pRecdLsuQty + '~' + pSellingPrice + '~' + pAttrip + '~' + pAttripValue + '~' + 
                                perunitCostPrice + '~' + perunitSellingPrice + '~' + pRakNo + '~' + pMRP + '~' + 
                                pNominal + '~' + purchasetax + '~' + receiveduniqno + '~' + hdnHsncode  + '~' +
                                pSType + '~' + pschemeDcount + '~' + pDType + '~' + hdnDeleteprod

            }

            function ckbdeleteProduct() {
                var RecdQty = ToInternalFormat($('#txtRecdQty')) == 0.00 ? 0 : ToInternalFormat($('#txtRecdQty'));

                if (RecdQty > 0) {
                    ValidationWindow("Received Quantity should be zero.", ErrorMsg);
                    document.getElementById('ckbdeleteProd').checked = false;
                    document.getElementById('hdnDeleteprod').value = "N";
                    return false;
                }
                else if (document.getElementById('ckbdeleteProd').checked == false && RecdQty == 0) {
                    ValidationWindow("Enter the Received Quantity to Uncheck it.", ErrorMsg);
                    document.getElementById('ckbdeleteProd').checked = true;
                    document.getElementById('hdnDeleteprod').value = "Y";
                    return false;
                }
                else {
                    document.getElementById('ckbdeleteProd').checked = true;
                    document.getElementById('hdnDeleteprod').value = "Y";
                    
                    document.getElementById('txtCompQty').value = "0.00";
                    ToTargetFormat($('#txtCompQty'));
                    document.getElementById('txtCostPrice').value = "0.00";
                    ToTargetFormat($('#txtCostPrice'));
                    document.getElementById('txtSellingPrice').value = "0.00";
                    ToTargetFormat($('#txtSellingPrice'));
                    document.getElementById('txtMRP').value = "0.00";
                    ToTargetFormat($('#txtMRP'));
                }
            }

            function checkAddToTotal() {
                if (document.getElementById('txtTotalDiscount').value == '') {
                    // document.getElementById('txtTotalDiscount').value = 0;
                    ToTargetFormat($('#txtTotalDiscount'));
                }
                if (document.getElementById('txtTotaltax').value == '') {
                    //document.getElementById('txtTotaltax').value = 0;
                    ToTargetFormat($('#txtTotaltax'));
                }

                // var Total = parseFloat(parseFloat(document.getElementById('hdnGrandPOTotal').value) - parseFloat(document.getElementById('txtTotalDiscount').value)).toFixed(2);
                var Total = parseFloat(parseFloat(ToInternalFormat($('#hdnGrandPOTotal'))) - parseFloat(ToInternalFormat($('#txtTotalDiscount')))).toFixed(2);

                //tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(document.getElementById('txtTotaltax').value)).toFixed(2);
                tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(ToInternalFormat($('#txtTotaltax')))).toFixed(2);

                var finAmount = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
                document.getElementById('lblGrandTotal').innerHTML = parseFloat(finAmount).toFixed(2);

                ToTargetFormat($('#lblGrandTotal'));
                document.getElementById('txtGrandTotal').value = parseFloat(finAmount).toFixed(2);
                ToTargetFormat($('#txtGrandTotal'));
                $('#txtGrandwithRoundof').val(ToInternalFormat($("#txtGrandTotal")));
                //document.getElementById('txtGrandwithRoundof').value = ToInternalFormat($("#txtGrandTotal"));
                ToTargetFormat($('#txtGrandwithRoundof'));

               //TcsTotalCalculation
               if($("#hdnIsSupplierTCS").val()=="Y" && $("#hdnNeedTcsTax").val()=="Y")
               {                                      
                 var TTP= parseFloat($("#hdnTcsTaxPer").val());            
                 var TTPAmount =  (((parseFloat(finAmount)+ parseFloat($("#txtTotalDiscount").val())) *TTP)/100);
                 $("#txtTCS").val(TTPAmount.toFixed(2));
                 var TCSoverAllTotal = (parseFloat(finAmount) + TTPAmount).toFixed(2)
                 document.getElementById('txtGrandTotal').value =TCSoverAllTotal;
                 $('#txtGrandwithRoundof').val(TCSoverAllTotal);                     
               }

                return false;
            }
            function CalRounfOff() {
                ////debugger;
                var GrandwithRoundof = ToInternalFormat($('#txtGrandwithRoundof'));  //document.getElementById('txtGrandwithRoundof').value;
                var NetTotal = ToInternalFormat($('#txtGrandTotal')); // document.getElementById('txtGrandTotal').value;
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
                    if (isNaN(document.getElementById('txtRoundOffValue').value)) {
                        document.getElementById('txtRoundOffValue').value = 0;
                    }
                    ToTargetFormat($('#txtRoundOffValue'));

                    return true;
                }
                else if (GrandwithRoundof > 0) {
                    var userMsg = SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_10") == null ? "Provide Correct Rounded-Off Net Total" : SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_10");
                    ValidationWindow(userMsg, ErrorMsg, 'txtGrandwithRoundof');
                    document.getElementById('txtGrandwithRoundof').value = 0.00;
                    ToTargetFormat($('#txtGrandwithRoundof'));
                    document.getElementById('txtGrandwithRoundof').focus();
                    return false;
                }
            }

            function ClearRoundoff() {
                //            document.getElementById('txtGrandwithRoundof').value = 0.00;
                //            ToTargetFormat($('#txtGrandwithRoundof'));
                document.getElementById('txtRoundOffValue').value = 0.00;
                ToTargetFormat($('#txtRoundOffValue'));

            }

            function onDisplay() {
                var deleteCount = 0;
                var rowCount = $("[id*=grdResult] td").closest("tr").length;

                $("[id$='grdResult'] tbody tr").each(function(i, n) {
                    var currentRow = $(n);
                    if (i > 0) {
                        var RecdQty = currentRow.find('span[id*="lblRecQty"]').text();
                        if (RecdQty == 0.00) {
                            deleteCount = deleteCount + 1;
                        }
                    }
                });

                if (deleteCount == rowCount) {
                    document.getElementById('ckbdeleteProd').checked = false;
                    document.getElementById('hdnDeleteprod').value = "N";
                    ValidationWindow("Looks like all product's Received Quantity are '0' in GRN. Proceed with CANCEL PO.", ErrorMsg);
                    return false;
                }
                
                var CheckAleart = "N";
                var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_06') != null ? SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_06') : "Please generate barcode for ";
                var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";

                var PendingBarcodeProduct = '';

                if ($("#hdnNeedProductBarcode").val() == "Y") {

                    $("[id$='grdResult'] tbody tr").each(function(i, n) {
                        var currentRow = $(n);
                        
                        if (i > 0) {
                            var barcodeStauts = currentRow.find("input[id$='hdnBarcodeStatus']").val();
                            var ProductName = currentRow.find('span[id*="lblProductName"]').text();

                            if (barcodeStauts == "Pending") {
                                CheckAleart = "Y";
                                PendingBarcodeProduct += ProductName + '  ';

                            }
                        }

                    });

                }

                if (CheckAleart == "Y") {
                    ValidationWindow(userMsg + PendingBarcodeProduct, errorMsg);
                    return false;
                }
                else {
                    $('#btnUpdate').removeClass().addClass('hide');
                    $('#btnCancelPO').removeClass().addClass('hide');
                    return true;
                }
            }

            function fnGetConfirm() {
                var userMsg = SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_09") == null ? "Are you sure you want to cancel the PO?" : SListForAppMsg.Get("StockReceived_UpdateStockReceived_aspx_09");
                if (ConfirmWindow(userMsg, infromMsg, OkMsg, CancelMsg)) {
                    return true;
                }
                else {

                    return false;
                }
            }


        </script>
        <div class="contentdata">
            <div class="w-100p a-right">
                <asp:LinkButton ID="lnkHome" runat="server" Text="Home" CssClass="details_label_age hide"
                    OnClick="lnkHome_Click" meta:resourcekey="lnkHomeResource1"></asp:LinkButton>
                <asp:HiddenField ID="hdnIsResdCalc" runat="server" />
            </div>
            <asp:UpdatePanel ID="upnlGrid" runat="server">
                <ContentTemplate>
                    <div id="divReceived">
                        <table class="w-100p a-left searchPanel paddingL2">
                            <tr>
                                <td class="w-100p bold a-center" colspan="2">
                                    <asp:Label ID="lblStockReceived" CssClass="font16" runat="server" Text="Stock Received" meta:resourcekey="lblStockReceivedResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="w-100p bold a-left" colspan="2">
                                    <asp:Label ID="lblOrgName" runat="server" meta:resourcekey="lblOrgNameResource1"
                                        class="bold"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="w-70p">
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblStreetAddress" runat="server" meta:resourcekey="lblStreetAddressResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource1" class="bold"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblPhone" runat="server" meta:resourcekey="lblPhoneResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblVendorName" runat="server" meta:resourcekey="lblVendorNameResource1"
                                                    class="bold"></asp:Label>
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
                                                <asp:Label ID="lblVendorPhone" runat="server" meta:resourcekey="lblVendorPhoneResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table class="w-100p a-left">
                                        <tr>
                                            <td class="w-21p a-left">
                                                <asp:Label ID="lblDate" runat="server" Text="Date" meta:resourcekey="lblDateResource2"
                                                    class="bold"></asp:Label>
                                            </td>
                                            <td class="a-left w-2p">:
                                            </td>
                                            <td class="a-left">
                                                <asp:Label ID="lblSRDate" runat="server" meta:resourcekey="lblSRDateResource1" class="a-left"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trPoNo" runat="server">
                                            <td>
                                                <asp:Label ID="lblPONo" runat="server" Text="PONo" meta:resourcekey="lblPONoResource2"
                                                    class="bold"></asp:Label>
                                            </td>
                                            <td class="a-left w-2p">:
                                            </td>
                                            <td>
                                                <asp:Label ID="lblPOID" runat="server" meta:resourcekey="lblPOIDResource1" class="a-left"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trRNo" runat="server">
                                            <td>
                                                <asp:Label ID="lblReceivedNo" runat="server" Text="GRN" meta:resourcekey="lblReceivedNoResource2"
                                                    class="bold"></asp:Label>
                                            </td>
                                            <td class="a-left w-2p">:
                                            </td>
                                            <td>
                                                <asp:Label ID="lblReceivedID" runat="server" meta:resourcekey="lblReceivedIDResource1"
                                                    class="a-left"></asp:Label>
                                            </td>
                                        </tr>

                                        <tr id="trConNo" runat="server">
                                            <td>
                                                <asp:Label ID="lblConsignMentNo" runat="server" Text="ConsignMentNo" class="bold" meta:resourcekey="lblConsignMentNoResource2"></asp:Label>
                                            </td>
                                            <td class="a-left w-2p">:
                                            </td>
                                            <td>
                                                <asp:Label ID="lblConsignMentId" runat="server" class="a-left" meta:resourcekey="lblReceivedIDResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblStatus1" runat="server" Text="Status" meta:resourcekey="lblStatus1Resource2"
                                                    class="bold"></asp:Label>
                                            </td>
                                            <td class="a-left w-2p">:
                                            </td>
                                            <td>
                                                <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1" class="a-left"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left" colspan="2">
                                    <table>
                                        <tr>
                                            <td class="v-top">
                                                <asp:Label ID="lblNote" runat="server" Text="Note" meta:resourcekey="lblNoteResource2"
                                                    class="bold"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="v-bottom">
                                                <asp:Label ID="lblNoBatchNo" runat="server" Text="*No Batch No" meta:resourcekey="lblNoBatchNoResource2"></asp:Label>
                                                <br />
                                                <asp:Label ID="lblNoExporMftDate" runat="server" Text="**No Exp. & Mft. Date" meta:resourcekey="lblNoExporMftDateResource2"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table class="w-100p searchPanel">
                            <tr class="panelHeader">
                                <td width="w-100p a-left">
                                    <div id="ACX2OPPmt" class="show" runat="server">
                                        &nbsp;<img src="../PlatForm/Images/showBids.gif" alt="Show" class="v-top w-15 h-18 pointer"
                                            onclick="onShowOnClick();" />
                                        <span class="pointer" onclick="onShowOnClick();">&nbsp;
                                        <asp:Label ID="lblReceivedStockDetails" runat="server" Text="Received Stock Details"
                                            meta:resourcekey="lblReceivedStockDetailsResource2"></asp:Label></span>
                                    </div>
                                    <div id="ACX2minusOPPmt" class="hide" runat="server">
                                        &nbsp;<img src="../PlatForm/Images/hideBids.gif" alt="hide" class="v-top w-15 h-18 pointer"
                                            onclick="onHideOnClick();" />
                                        <span class="pointer" onclick="onHideOnClick();">&nbsp;
                                        <asp:Label ID="lblReceivedStockDetails1" runat="server" Text="ReceivedStockDetails"
                                            meta:resourcekey="lblReceivedStockDetails1Resource2"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                            <tr id="ACX2responsesOPPmt" class="hide" runat="server">
                                <td id="Td1" runat="server" class="w-100p">
                                    <table class="w-100p">
                                        <tr>
                                            <td id="GrandTotalTD" class="a-right">
                                                <asp:Label ID="lblGrandTotal1" runat="server" Text="GrandTotal" class="bold" meta:resourcekey="lblGrandTotal1Resource1"></asp:Label>
                                                :
                                            <asp:Label ID="lblGrandTotal" runat="server"
                                                meta:resourcekey="lblGrandTotalResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="w-100p">
                                                <asp:GridView CellSpacing="2" EmptyDataText="No matching records found " ID="grdResult"
                                                    runat="server" AutoGenerateColumns="False" HeaderStyle-CssClass="gridHeader"
                                                    FooterStyle-CssClass="grdFooter" CssClass="gridView w-100p" OnRowDataBound="grdResult_RowDataBound"
                                                    OnSelectedIndexChanging="grdResult_SelectedIndexChanging"
                                                    meta:resourcekey="grdResultResource1">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Product Name"
                                                            meta:resourcekey="TemplateFieldResource1">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblProductName" Text='<%# Eval("ProductName") %>' runat="server"
                                                                    meta:resourcekey="lblProductNameResource1"></asp:Label>
                                                                <asp:HiddenField ID="hdnProductAttribute" Value='<%# Eval("Attributes") %>' runat="server" />
                                                                <asp:HiddenField ID="hdnProductAttributeDetail" Value='<%# Eval("AttributeDetail") %>'
                                                                    runat="server" />
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="HSN Code">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblHsncode" Text='<%# Eval("Remarks") %>' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PO Qty"
                                                            meta:resourcekey="TemplateFieldResource2">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPOQuantity" Text='<%# Eval("POQuantity") %>' runat="server"
                                                                    meta:resourcekey="lblPOQuantityResource1"></asp:Label>(<%#Eval("POUnit") %>)
                                                            <asp:HiddenField ID="hdnPOUnit" Value='<%# Eval("POUnit") %>' runat="server" />
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Batch No"
                                                            meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblBatchNo" Text='<%# Eval("BatchNo") %>' runat="server"></asp:Label>
                                                                <asp:Label ID="lblMFT" Visible="False" Text='<%#(GetDate(Eval("Manufacture", "{0:yyyy}")) == "1753" || GetDate(Eval("Manufacture", "{0:yyyy}")) == "9999" ||GetDate(Eval("Manufacture", "{0:yyyy}")) == "0001" ) ? "**" : GetDate(Eval("Manufacture", "{0:MMM-yyyy}")) %>'
                                                                    runat="server" meta:resourcekey="lblMFTResource1"></asp:Label><br />
                                                                <asp:Label ID="lblEXP" Visible="False" Text='<%# GetDate(Eval("ExpiryDate", "{0:MMM-yyyy}")) %>'
                                                                    runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                                                            meta:resourcekey="TemplateFieldResource4">
                                                            <ItemTemplate>
                                                                MFT :<%# ((Eval("Manufacture", "{0:yyyy}")) == "1753" || (Eval("Manufacture", "{0:yyyy}")) == "9999" ||(Eval("Manufacture", "{0:yyyy}")) == "0001" ) ? "**" : GetDate(Eval("Manufacture", "{0:MMM-yyyy}"))%><br />
                                                                EXP :<%# ((Eval("ExpiryDate", "{0:yyyy}")) == "1753" || (Eval("ExpiryDate", "{0:yyyy}")) == "9999" || (Eval("ExpiryDate", "{0:yyyy}")) == "0001") ? "**" : GetDate(Eval("ExpiryDate", "{0:MMM-yyyy}"))%>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Rcvd Qty"
                                                            meta:resourcekey="TemplateFieldResource5">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRecQty" Text='<%# Eval("RECQuantity","{0:N}") %>' runat="server"
                                                                    meta:resourcekey="lblRecQtyResource1"></asp:Label>(<%# Eval("RECUnit")%>)
                                                            <asp:HiddenField ID="hdnRecQtyUnit" runat="server"
                                                                Value='<%# Eval("RECUnit") %>' />
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Inverse Qty"
                                                            meta:resourcekey="TemplateFieldResource6">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblInvQty" Text='<%# Eval("InvoiceQty","{0:N}") %>' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Rcvd lsu Qty"
                                                            meta:resourcekey="TemplateFieldResource7">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRecLSUQty" Text='<%# Eval("RcvdLSUQty","{0:N}") %>' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Selling Unit"
                                                            meta:resourcekey="TemplateFieldResource8">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSellingUnit" Text='<%# Eval("SellingUnit") %>' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Cost Price"
                                                            meta:resourcekey="TemplateFieldResource9">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblUnitPrice" Text='<%# Eval("UnitCostPrice","{0:N}") %>' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Nominal"
                                                            meta:resourcekey="TemplateFieldResource10">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblNominal" Text='<%# Eval("ActualAmount","{0:N}") %>' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center hide" />
                                                            <ItemStyle CssClass="a-right hide" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Selling Price"
                                                            meta:resourcekey="TemplateFieldResource11">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSellingPrice" Text='<%# Eval("UnitSellingPrice","{0:N}") %>'
                                                                    runat="server"></asp:Label>
                                                                <asp:HiddenField ID="hdnRid" Value='<%# Eval("ID") %>' runat="server" />
                                                                <asp:HiddenField ID="hdnBatchNo" Value='<%# Eval("BatchNo") %>' runat="server" />
                                                                <asp:HiddenField ID="hdnProductId" Value='<%# Eval("ProductId") %>' runat="server" />
                                                                <asp:HiddenField ID="hdnPdtRcvdDtlsID" runat="server" Value='<%# Eval("ProductReceivedDetailsID") %>' />
                                                                <asp:HiddenField ID="hdnRcvdUniqNo" runat="server" Value='<%# Eval("ReceivedUniqueNumber") %>' />
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="MRP" meta:resourcekey="TemplateFieldResource12">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblMRP" Text='<%# Eval("MRP","{0:N}") %>' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Comp Qty(lsu)"
                                                            meta:resourcekey="TemplateFieldResource13">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCompQty" Text='<%# Eval("ComplimentQTY") %>' runat="server"></asp:Label>
                                                                (<%# Eval("SellingUnit")%>)
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText ="Scheme (%)"
                                                                  meta:resourcekey="TemplateFieldResource19">
                                                             <ItemTemplate>
                                                                 <asp:Label ID="lblSchemeType" Text='<%# Eval("SchemeType","{0:N}") %>'
                                                                    runat="server"></asp:Label>
                                                             </ItemTemplate>
                                                             <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText ="Scheme Amt" 
                                                              meta:resourcekey="TemplateFieldResource20">
                                                          <ItemTemplate>
                                                                 <asp:Label ID="lblSchemeDisc" Text='<%# Eval("SchemeDisc","{0:N}") %>'
                                                                    runat="server"></asp:Label>
                                                             </ItemTemplate>
                                                             <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Discount (%)"
                                                            meta:resourcekey="TemplateFieldResource21">
                                                            <ItemTemplate>
                                                               <asp:Label ID="lblDiscountType" Text='<%# Eval("DiscountType","{0:N}") %>'
                                                                    runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Discount Amt"
                                                            meta:resourcekey="TemplateFieldResource14">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDiscount" Text='<%# Eval("Discount","{0:N}") %>'
                                                                    runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Tax (%)"
                                                            meta:resourcekey="TemplateFieldResource15">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTax" Text='<%# Eval("Tax","{0:N}") %>' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center " />
                                                            <ItemStyle CssClass="a-right " />
                                                        </asp:TemplateField>
                                                        
                                                        <%--16--%>
                                                        <asp:TemplateField HeaderText="CGST (%)">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTax01" Text='' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Left" Width="40px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="CGST (Amt)">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTax02" Text='' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center"/>
                                                            <ItemStyle HorizontalAlign="Left" Width="40px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="SGST (%)">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTax03" Text='' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Left" Width="40px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="SGST (Amt)">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTax04" Text='' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center"/>
                                                            <ItemStyle HorizontalAlign="Left" Width="40px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="IGST (%)">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTax05" Text='' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center"/>
                                                            <ItemStyle HorizontalAlign="Left" Width="40px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="IGST (Amt)">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTax06" Text='' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center"/>
                                                            <ItemStyle HorizontalAlign="Left" Width="40px" />
                                                        </asp:TemplateField>
                                                        <%--22--%>

                                                        <asp:TemplateField HeaderText="Purchase Tax(%)" meta:resourcekey="TemplateFieldResource18">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPurchaseTax" Text='<%# Eval("PurchaseTax")%>' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center hide" />
                                                            <ItemStyle CssClass="a-right hide" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Rak No"
                                                            meta:resourcekey="TemplateFieldResource16">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRakNo" Text='<%# Eval("RakNo","{0:N}") %>' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Total Cost"
                                                            meta:resourcekey="TemplateFieldResource17">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTotalCost" Text='<%# Eval("TotalCost","{0:N}") %>'
                                                                    runat="server"></asp:Label>
                                                                <asp:HiddenField ID="hdnTotalCost" runat="server"
                                                                    Value='<%# GetTotalCost(decimal.Parse(Eval("TotalCost").ToString())).ToString("N2") %>' />
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="a-center" />
                                                            <ItemStyle CssClass="a-right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:HiddenField runat="server" ID="hdnUnitPrice" Value='<%#Eval("UnitPrice") %>' />
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="hide" />
                                                            <ItemStyle CssClass="hide" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:HiddenField runat="server" ID="hdnRate" Value='<%#Eval("Rate") %>' />
                                                                <asp:HiddenField runat="server" ID="hdnBarcodeStatus" Value='<%#Eval("Barcode") %>' />
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="hide" />
                                                            <ItemStyle CssClass="hide" />
                                                        </asp:TemplateField>
                                                        <%--27--%>
                                                    </Columns>
                                                </asp:GridView>
                                                <input id="hdnCollectedItems" runat="server" type="hidden" />
                                                <input id="hdnConsumableItems" runat="server" type="hidden" />
                                                <input id="hdnStatus" runat="server" type="hidden" />
                                                <input id="hdnHasExpiryDate" runat="server" type="hidden" value="Y" />
                                                <input id="hdnHasBatchNo" runat="server" type="hidden" value="Y" />
                                                <asp:HiddenField ID="hdnGrandPOTotal" runat="server" Value="0" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <br />
                                                <table id="tbTotalCost" class="w-100p searchPanel">
                                                    <tr>
                                                        <td class="a-right">
                                                            <asp:Label ID="lblTotalSales" runat="server" Text="Total Sales:"
                                                                class="bold" meta:resourcekey="lblTotalSalesResource1"></asp:Label>
                                                            <asp:TextBox ID="txtTotalSales" Enabled="False" onkeypress="return ValidateMultiLangChar(this);"
                                                                runat="server" Text="0.00" CssClass="a-right" meta:resourcekey="txtTotaltaxResource1"></asp:TextBox>&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-right hide" id="lblSupplierTax" runat="server">
                                                            <asp:Label ID="lblSupplierServiceTax" runat="server" Text="Supplier Service Tax(%)"
                                                                class="bold" meta:resourcekey="lblSupplierServiceTaxResource1"></asp:Label>
                                                            <asp:TextBox ID="txtTotaltax" onblur="checkAddToTotal();ClearRoundoff();" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                                runat="server" Text="0.00" CssClass="a-right" meta:resourcekey="txtTotaltaxResource1"></asp:TextBox>&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-right">
                                                            <asp:Label ID="lblPODiscount" runat="server" Text="PODiscount" class="bold"
                                                                meta:resourcekey="lblPODiscountResource1"></asp:Label>
                                                            <asp:TextBox ID="txtTotalDiscount" onkeypress="return ValidateSpecialAndNumeric(this);" runat="server"
                                                                Text="0.00" onblur="checkAddToTotal();ClearRoundoff();" CssClass="a-right"
                                                                meta:resourcekey="txtTotalDiscountResource1"></asp:TextBox>&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-right">
                                                            <asp:Label ID="Label1" runat="server" Text="Total Discount Amount" class="bold"
                                                                meta:resourcekey="Label1Resource1"></asp:Label>
                                                            <asp:TextBox ID="txtTotaldiscountAmt" runat="server" Enabled="False" Text="0.00" onkeypress="return ValidateMultiLangChar(this);"
                                                                onblur="checkAddToTotal();" CssClass="a-right"
                                                                meta:resourcekey="txtTotaldiscountAmtResource1"></asp:TextBox>&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr id="trcgst" runat="server">
                                                        <td class="a-right">
                                                            <asp:Label ID="lbltotcgst" runat="server" class="bold" Text="Total CGST" meta:resourcekey="lbltotcgstResource1"></asp:Label>&nbsp;&nbsp;
                                                            <asp:TextBox ID="lbltotcgstamt" Enabled="False" CssClass="a-right" runat="server" Text="0.00"></asp:TextBox>&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr id="trsgst" runat="server">
                                                        <td class="a-right">
                                                            <asp:Label ID="lbltotsgst" runat="server" class="bold" Text="Total SGST" meta:resourcekey="lbltotsgstResource1"></asp:Label>&nbsp;&nbsp;
                                                            <asp:TextBox ID="lbltotsgstamt" Enabled="False" CssClass="a-right" runat="server" Text="0.00"></asp:TextBox>&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr id="trigst" runat="server">
                                                        <td class="a-right">
                                                            <asp:Label ID="lbltotigst" runat="server" class="bold" Text="Total IGST" meta:resourcekey="lbltotigstResource1"></asp:Label>&nbsp;&nbsp;
                                                            <asp:TextBox ID="lbltotigstamt" Enabled="False" CssClass="a-right" runat="server" Text="0.00"></asp:TextBox>&nbsp;
                                                        </td>
                                                    </tr>

                                                    <tr id="trTAXamt" runat="server">
                                                        <td class="a-right">
                                                            <asp:Label ID="lblTotalTaxAmount" runat="server" Text="Total GST Amount"
                                                                class="bold" meta:resourcekey="lblTotalTaxAmountResource11"></asp:Label>
                                                            <asp:TextBox ID="txtTotaltaxAmt" Enabled="False" runat="server" CssClass="a-right" onkeypress="return ValidateMultiLangChar(this);"
                                                                meta:resourcekey="txtTotaltaxAmtResource1"></asp:TextBox>&nbsp;
                                                        </td>
                                                    </tr>
                                                       <tr id="tr1Tcs" runat="server" class="hide">
                                                        <td class="a-right">
                                                            <asp:Label ID="lblTcs" runat="server" Text="Total TCS Amount"
                                                                class="bold" meta:resourcekey="lblTcsResource11"></asp:Label>
                                                            <asp:TextBox ID="txtTCS" Enabled="False" runat="server" CssClass="a-right"  meta:resourcekey="txtTCSResource1"></asp:TextBox>&nbsp;
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr>
                                                        <td class="a-right">
                                                            <asp:Label ID="lblTotal" runat="server" Text="Total" class="bold"
                                                                meta:resourcekey="lblTotalResource1"></asp:Label>
                                                            <asp:TextBox ID="txtGrandTotal" Enabled="False" runat="server" Text="0.00" CssClass="a-right" onkeypress="return ValidateMultiLangChar(this);"
                                                                meta:resourcekey="txtGrandTotalResource1"></asp:TextBox>&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-right">
                                                            <asp:Label ID="lblCreditAmnt" runat="server" Text="User Credit Amount"
                                                                class="bold" meta:resourcekey="lblCreditAmntResource1"></asp:Label>
                                                            <asp:TextBox ID="txtCreditAmnt" Enabled="False" runat="server" Text="0.00" CssClass="a-right" onkeypress="return ValidateMultiLangChar(this);"
                                                                meta:resourcekey="txtCreditAmntResource1"></asp:TextBox>&nbsp;
                                                        </td>
                                                    </tr>


                                                    <tr id="trStampFee" runat="server">

                                                        <td class="a-right">
                                                            <asp:Label ID="lblStampFee" class="bold" runat="server" Text="Stamp Fee :" meta:resourcekey="lblStampFeeResource1"></asp:Label>
                                                            <asp:TextBox ID="txtStampFee" CssClass="a-right" Enabled="false" runat="server" Text="0.00"
                                                                meta:resourcekey="txtStampFeeResource1" onkeypress="return ValidateSpecialAndNumeric(this);" onblur="checkAddToTotal();"></asp:TextBox>&nbsp;
                                                        </td>
                                                    </tr>



                                                    <tr id="trDeliveryCharges" runat="server">
                                                        <td class="a-right">
                                                            <asp:Label ID="lblDeliveryCharges" class="bold" runat="server" Text="Delivery Charges :" meta:resourcekey="lblDeliveryChargesResource1"></asp:Label>

                                                            <asp:TextBox ID="txtDeliveryCharges" CssClass="a-right" Enabled="false" runat="server" Text="0.00"
                                                                meta:resourcekey="txtDeliveryChargeResource1" onkeypress="return ValidateSpecialAndNumeric(this);" onblur="checkAddToTotal();"></asp:TextBox>&nbsp;
                                                        </td>
                                                    </tr>


                                                    <tr>
                                                        <td class="a-right">
                                                            <asp:Label ID="lblRoundOffValue" runat="server" Text="RoundOffValue"
                                                                class="bold" meta:resourcekey="lblRoundOffValueResource1"></asp:Label>
                                                            <asp:TextBox ID="txtRoundOffValue" onblur="CheckRoundOffvalue();" onkeypress="return ValidateMultiLangChar(this);" runat="server" CssClass="a-right"
                                                                Text="0.00" Enabled="False" meta:resourcekey="txtRoundOffValueResource1"></asp:TextBox>&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-right">
                                                            <asp:Label ID="lblRoundedOffNetTotal" runat="server" Text="Rounded Off Net Total"
                                                                class="bold" meta:resourcekey="lblRoundedOffNetTotalResource1"></asp:Label>
                                                            <asp:TextBox ID="txtGrandwithRoundof" runat="server" Text="0.00" CssClass="a-right" onkeypress="return ValidateMultiLangChar(this);"
                                                                onblur="return CalRounfOff(); " meta:resourcekey="txtGrandwithRoundofResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="commentsTD" runat="server"></td>
                                        </tr>
                                        <tr>
                                            <td class="a-right">
                                                <asp:Label ID="lblMessage" runat="server"
                                                    meta:resourcekey="lblMessageResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-center">
                                                <span class="bold">
                                                    <asp:LinkButton ForeColor="Blue" Visible="False" OnClick="lnkAddMore_click" ID="lnkAddMore"
                                                        runat="server" meta:resourcekey="lnkAddMoreResource1">
                                                        <u>
                                                            <asp:Label ID="lblAddMore" runat="server" Text="AddMore" class="bold" meta:resourcekey="lblAddMoreResource1"></asp:Label>
                                                        </u>
                                                    </asp:LinkButton></span>
                                                <input type="hidden" id="hdnApproveStockReceived" runat="server" />
                                                <asp:Button ID="btnBack" runat="server" CssClass="cancel-btn" OnClick="btnBack_Click"
                                                    Text="Back" meta:resourcekey="btnBackResource1" />
                                                <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" OnClientClick="return onDisplay();"
                                                    Text="Approve &amp; Update" CssClass="btn" meta:resourcekey="btnUpdateResource1" />
                                                <asp:Button ID="btnCancelPO" runat="server" CssClass="cancel-btn" OnClientClick="javascript:return fnGetConfirm();" OnClick="btnCancelPO_Click"
                                                    Text="Cancel PO" meta:resourcekey="btnCancelPOResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <div id="divProductEdit" class="hide" runat="server">
                            <table class="a-center">
                                <tr class="a-left">
                                    <td>
                                        <asp:Label ID="lblProduct" runat="server" Text="Product" meta:resourcekey="lblProductResource2"
                                            class="bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtProduct" onkeypress="return ValidateMultiLangChar(this);" runat="server"
                                            meta:resourcekey="txtProductResource1"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblPOQuantity" runat="server" Text="POQuantity" meta:resourcekey="lblPOQuantityResource2"
                                            class="bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPOQty" onkeypress="return ValidateMultiLangChar(this);" runat="server"
                                            meta:resourcekey="txtPOQtyResource1"></asp:TextBox>
                                        <asp:TextBox ID="txtPOQtyUnit" onkeypress="return ValidateMultiLangChar(this);" runat="server"
                                            meta:resourcekey="txtPOQtyUnitResource1"></asp:TextBox>
                                        <asp:CheckBox ID="ckbdeleteProd" runat="server" Text="Delete Product" OnClick="ckbdeleteProduct();"/>
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td>
                                        <asp:Label ID="lblBatchNo" runat="server" Text="BatchNo" meta:resourcekey="lblBatchNoResource2"
                                            class="bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtBatchNo" runat="server" onkeypress="return ValidateMultiLangChar(this);"
                                            onblur="javascript:CheckBatch(this);" Width="80px" meta:resourcekey="txtBatchNoResource1"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblRcvdQty" runat="server" Text="RcvdQty" meta:resourcekey="lblRcvdQtyResource2"
                                            class="bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtRecdQty" runat="server" onkeypress="return ValidateMultiLangChar(this);"
                                            onblur="javascript:onGridViewRowSelected(getElementById('txtPOQty'),getElementById('lblPOQtyUnit'),getElementById('lblRecdQtyUnit'),getElementById('txtRecdQty'),getElementById('txtCostPrice'),getElementById('txtTax'),getElementById('txtDiscount'),getElementById('txtProdTotalCost'),getElementById('txtNominal'),getElementById('txtSchemeDisc'));calculateLSU('txtRecdQty','txtInvQty','txtRecLSUQty');"
                                            onchange="javascript:setRecQuantity('txtRecdQty','txtPOQty');" meta:resourcekey="txtRecdQtyResource1"></asp:TextBox>
                                        <asp:TextBox ID="txtRecdQtyUnit" runat="server" onkeypress="return ValidateMultiLangChar(this);"
                                            meta:resourcekey="txtRecdQtyUnitResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td>
                                        <asp:Label ID="lblMFGDate" runat="server" Text="MFGDate" meta:resourcekey="lblMFGDateResource2"
                                            class="bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMFT" runat="server" onkeypress="return ValidateSpecialAndNumeric(this);" onchange="javascript:ValidateDate(getElementById('txtMFT'),getElementById('txtEXP'));"
                                            meta:resourcekey="txtMFTResource1"></asp:TextBox>
                                        <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="MMM/yyyy" PopupButtonID="txtMFT"
                                            TargetControlID="txtMFT" Enabled="True" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblExpDate" runat="server" Text="ExpDate" meta:resourcekey="lblExpDateResource2"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtEXP" runat="server" onkeypress="return ValidateSpecialAndNumeric(this);" onchange="javascript:ValidateDate(getElementById('txtMFT'),getElementById('txtEXP'));"
                                            meta:resourcekey="txtEXPResource1"></asp:TextBox>
                                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="MMM/yyyy" PopupButtonID="txtEXP"
                                            TargetControlID="txtEXP" Enabled="True" />
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td>
                                        <asp:Label ID="lblInverseQty" runat="server" Text="InverseQty" meta:resourcekey="lblInverseQtyResource2"
                                            class="bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtInvQty" runat="server" onkeypress="return ValidateSpecialAndNumeric(this);"
                                            onblur="javascript:calculateLSU('txtRecdQty','txtInvQty','txtRecLSUQty');" meta:resourcekey="txtInvQtyResource1"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblRecdLSUQty" runat="server" Text="RecdLSUQty" meta:resourcekey="lblRecdLSUQtyResource2"
                                            class="bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtRecLSUQty" runat="server" onkeypress="return ValidateSpecialAndNumeric(this);"
                                            onblur="javascript:calculateLSU('txtRecdQty','txtInvQty','txtRecLSUQty');" meta:resourcekey="txtRecLSUQtyResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td>
                                        <asp:Label ID="lblSellingUnit" runat="server" Text="SellingUnit" meta:resourcekey="lblSellingUnitResource2"
                                            class="bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSellingUnit" onchange="checkSellingUnit()" runat="server"
                                            CssClass="ddlTheme" meta:resourcekey="ddlSellingUnitResource1">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCompQty" runat="server" Text="CompQty" meta:resourcekey="lblCompQtyResource2"
                                            class="bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCompQty" runat="server" onblur="AppendMRP()" onkeypress="return ValidateSpecialAndNumeric(this);"
                                            onchange="javascript:CheckFields('txtSellingPrice','txtCompQty');" meta:resourcekey="txtCompQtyResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td>
                                        <asp:Label ID="lblCostPrice" runat="server" class="bold" Text="CostPrice" meta:resourcekey="lblCostPriceResource2"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCostPrice" onkeypress="return ValidateSpecialAndNumeric(this);" runat="server"
                                            onblur="javascript:onGridViewRowSelected(getElementById('txtPOQty'),getElementById('lblPOQtyUnit'),getElementById('lblRecdQtyUnit'),getElementById('txtRecdQty'),getElementById('txtCostPrice'),getElementById('txtTax'),getElementById('txtDiscount'),getElementById('txtProdTotalCost'),getElementById('txtNominal'),getElementById('txtSchemeDisc'));"
                                            meta:resourcekey="txtCostPriceResource1"></asp:TextBox>
                                    </td>
                                    <td class="hide">
                                        <asp:Label ID="lblNominal" runat="server" Text="Nominal" class="bold"
                                            meta:resourcekey="lblNominalResource2"></asp:Label>
                                    </td>
                                    <td class="hide">
                                        <asp:TextBox ID="txtNominal" onkeypress="return ValidateSpecialAndNumeric(this);"
                                            runat="server" meta:resourcekey="txtNominalResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="trScheme" runat="server" class="a-left">
                                   <td>
                                     <asp:Label ID="lblSchemeType" runat="server" Text ="Scheme Type" meta="lblSchemeTypeResource1" class="a-bold">
                                     </asp:Label>
                                   </td>
                                   <td>
                                      <asp:DropDownList ID="ddlSchemetype" runat="server" onchange ="Changedropdowntype();">
                                            <asp:ListItem Text="Percentage" Value="0" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Value" Value="1"></asp:ListItem>
                                        </asp:DropDownList>
                                   </td>
                                   <td>
                                     <asp:Label ID="lblSchemeDiscount" runat="server" Text="Scheme Discount" meta:resourcekey="lblSchemeDiscResource1">
                                     </asp:Label>
                                   </td>
                                   <td>
                                      <asp:TextBox ID="txtSchemeDisc" onkeypress="return ValidateSpecialAndNumeric(this);" runat="server" 
                                            onblur="javascript:onGridViewRowSelected(getElementById('txtPOQty'),getElementById('lblPOQtyUnit'),getElementById('lblRecdQtyUnit'),getElementById('txtRecdQty'),getElementById('txtCostPrice'),getElementById('txtTax'),getElementById('txtDiscount'),getElementById('txtProdTotalCost'),getElementById('txtNominal'),getElementById('txtSchemeDisc'));">
                                       </asp:TextBox>
                                   </td>
                                </tr>
                                <tr class="a-left">
                                    <td>
                                       <asp:Label ID="lblDiscType" runat ="server" Text ="Discount Type" meta:resoucekey="lblDiscTypeResource1" class="a-bold">
                                       </asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDisctype" runat="server" onchange ="Changedropdowntype();">
                                            <asp:ListItem Text="Percentage" Value="0" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Value" Value="1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblDiscount" runat="server" Text="Discount" meta:resourcekey="lblDiscountResource2"
                                            class="a-bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDiscount" onkeypress="return ValidateSpecialAndNumeric(this);"
                                            runat="server" onblur="javascript:onGridViewRowSelected(getElementById('txtPOQty'),getElementById('lblPOQtyUnit'),getElementById('lblRecdQtyUnit'),getElementById('txtRecdQty'),getElementById('txtCostPrice'),getElementById('txtTax'),getElementById('txtDiscount'),getElementById('txtProdTotalCost'),getElementById('txtNominal'),getElementById('txtSchemeDisc'));"
                                            meta:resourcekey="txtDiscountResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td id="lblTaxClc" class="pos-absolute" runat="server">
                                        <asp:Label ID="lblTax" runat="server" Text="GST(%)" class="a-bold" meta:resourcekey="lblTaxResource2"></asp:Label>
                                    </td>
                                    <td id="txtTaxAmt"  runat="server">
                                        <asp:TextBox ID="txtTax" runat="server" Enabled="false" onkeypress="return ValidateSpecialAndNumeric(this);"
                                            onblur="javascript:onGridViewRowSelected(getElementById('txtPOQty'),getElementById('lblPOQtyUnit'),getElementById('lblRecdQtyUnit'),getElementById('txtRecdQty'),getElementById('txtCostPrice'),getElementById('txtpurchasetax'),getElementById('txtDiscount'),getElementById('txtProdTotalCost'),getElementById('txtNominal'),getElementById('txtSchemeDisc'));"
                                            meta:resourcekey="txtTaxResource1"></asp:TextBox>
                                        <span id="popTaxTrigger" class="ui-icon ui-icon-info inline-block"></span>
                                        <div id="divTaxDetails" runat="server" class="pos-relative right0 ww-300 p-ab card-md card-md-default padding10  hide">
                                        </div>
                                        <asp:HiddenField ID="CheckState" runat="server" />
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td class="hide">
                                        <asp:Label ID="lblpurchasetax" runat="server" CssClass="a-bold" Text="Purchase tax(%)" meta:resourcekey="lblpurchasetaxResource1"></asp:Label>
                                    </td>
                                    <td class="hide">
                                        <asp:TextBox runat="server" ID="txtpurchasetax" onblur="javascript:onGridViewRowSelected(getElementById('txtPOQty'),getElementById('lblPOQtyUnit'),getElementById('lblRecdQtyUnit'),getElementById('txtRecdQty'),getElementById('txtCostPrice'),getElementById('txtpurchasetax'),getElementById('txtDiscount'),getElementById('txtProdTotalCost'),getElementById('txtNominal'),getElementById('txtSchemeDisc'));">
                                        </asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSellingPrice" runat="server" class="a-bold" Text="SellingPrice"
                                            meta:resourcekey="lblSellingPriceResource2"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSellingPrice" onkeypress="return ValidateSpecialAndNumeric(this);" runat="server"
                                            onchange="javascript:CheckFields('txtSellingPrice','txtCompQty');" onblur="AppendMRP()"
                                            meta:resourcekey="txtSellingPriceResource1"></asp:TextBox>
                                    </td>

                                </tr>
                                <tr class="a-left">
                                    <td>
                                        <asp:Label ID="lblRakNo" runat="server" Text="RakNo" class="a-bold" meta:resourcekey="lblRakNoResource2"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtRakNo" runat="server" Width="40px" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtRakNoResource1"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblMRP" runat="server" Text="MRP" class="a-bold" meta:resourcekey="lblMRPResource2"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMRP" onkeypress="return ValidateSpecialAndNumeric(this);" runat="server"
                                            meta:resourcekey="txtMRPResource1"></asp:TextBox>
                                    </td>

                                </tr>
                                <tr class="a-left">
                                    <td>
                                        <asp:Label ID="lblTotalCost" runat="server" class="a-bold" Text="TotalCost" meta:resourcekey="lblTotalCostResource2"></asp:Label>
                                    </td>
                                    <td>                                     
                                        <asp:HiddenField ID="hdnIsSupplierTCS" runat="server"  Value="N"/>
                                        <asp:HiddenField ID="hdnNeedTcsTax" runat="server"  Value="N"/>
                                        <asp:HiddenField ID="hdnTcsTaxPer" runat="server" Value="0.00" />
                                        <asp:TextBox ID="txtProdTotalCost" onkeypress="return ValidateSpecialAndNumeric(this);" runat="server"
                                            meta:resourcekey="txtProdTotalCostResource1"></asp:TextBox>
                                        <asp:HiddenField ID="hdnGrandTotal" runat="server" />
                                        <asp:HiddenField ID="hdnRidItem" runat="server" />
                                        <asp:HiddenField ID="hdnBatchNoItem" runat="server" />
                                        <asp:HiddenField ID="hdnGridPopCount" runat="server" />
                                        <asp:HiddenField ID="hdnSellingUnit" runat="server" />
                                        <asp:HiddenField ID="hdnAttributeDetail" runat="server" />
                                        <asp:HiddenField ID="hdnAttributes" runat="server" />
                                        <asp:HiddenField ID="hdnproductId" runat="server" />
                                        <asp:HiddenField ID="hdnProductsList" runat="server" />
                                        <asp:HiddenField ID="hdnUsageLimit" Value="0" runat="server" />
                                        <asp:HiddenField ID="hdndisplaydate" Value="" runat="server" />
                                        <asp:HiddenField ID="hdnHsncode" Value="" runat="server" />
                                        <asp:HiddenField ID="hdnIsSchemeDiscount" runat="server" Value="N" />
                                        <asp:HiddenField ID="hdnSchemeType" runat="server" />
                                        <asp:HiddenField ID="hdnDisctype" runat="server" />
                                        <asp:HiddenField ID="hdnDeleteprod" Value="N" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" class="a-center">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnAdd" runat="server" CssClass="btn" OnClick="btnAdd_Click" OnClientClick="javascript:if(CheckUnit()) CollectedItem();"
                                                        Text="Add" meta:resourcekey="btnAddResource1" />
                                                </td>
                                                <td id="tdAttrip" class="hide" runat="server">
                                                    <asp:Button Visible="False" ID="btnAttribute" OnClientClick="javascript:if(CheckUnit()) CollectedItem();"
                                                        runat="server" CssClass="btn" OnClick="btnAttribute_Click" Text="Attribute" meta:resourcekey="btnAttributeResource1" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnCancel" runat="server" CssClass="cancel-btn" OnClientClick="javascript:return hidePopup();"
                                                        Text="Cancel" meta:resourcekey="btnCancelResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                        <uc2:INVAttributes ID="INVAttributes1" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnstockreceiveno" Value="0" runat="server" />
        <asp:HiddenField ID="hdnIsSellingPriceTypeRuleApply" runat="server" Value="N" />
        <asp:HiddenField ID="hdnRoundofType" Value="0.00" runat="server" />
        <input type="hidden" id="hdnUnitSellingPrice" value="0" runat="server" />
        <input type="hidden" id="hdnUnitCostPrice" value="0" runat="server" />
        <input type="hidden" id="hdnCostValue" value="0" runat="server" />
        <input type="hidden" id="hdnsellingValue" value="0" runat="server" />
        <asp:HiddenField ID="hdnTaxcalcType" Value="" runat="server" />
        <asp:HiddenField ID="hdnREQCalcCompQTY" runat="server" Value="N" />
        <asp:HiddenField ID="hdnNeedProductBarcode" runat="server" Value="N" />
        <asp:HiddenField ID="hdnRecdProducts" runat="server" />
    </form>
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
</body>
</html>
