var OrderedUnitValues;

 var errorMsg = SListForAppMsg.Get("CentralPurchasing_Error") != null ? SListForAppMsg.Get("CentralPurchasing_Error") : "Alert";
 var InformationMsg = SListForAppMsg.Get("CentralPurchasing_Information") != null ? SListForAppMsg.Get("CentralPurchasing_Information") : "Information";
 var okMsg = SListForAppMsg.Get("CentralPurchasing_Ok") != null ? SListForAppMsg.Get("CentralPurchasing_Ok") : "Ok";
 var CancelMsg = SListForAppMsg.Get("CentralPurchasing_Cancel") != null ? SListForAppMsg.Get("CentralPurchasing_Cancel") : "Cancel";

 var QM_ProductID;
 var QM_Discount;
function fnclear() {

    document.getElementById('txtsQuantity').value = '';

    document.getElementById('txtProduct').value = "";
    /// *** Command for  dropdown with auto textbox  ******//   

    //document.getElementById('drpLocation').selectedIndex = 0;
    //document.getElementById('ddlTrustedOrg').selectedIndex = 0;
    document.getElementById('hdnSelectedOrg').value = "0";
    document.getElementById('txtTrustedOrg').value = "";
    document.getElementById('hdnSelectedLocation').value = "0";
    document.getElementById('txtLocationorg').value = "";

    //// *********** End **************///
    document.getElementById('txtcompqty').value = "0.00";
    document.getElementById('txtDiscount').value = "0.00";
    document.getElementById('txtvat').value = "0.00";
    document.getElementById('txtAmount').value = "0.00";

    document.getElementById('txtUnits').SelectedIndex = 0;
    document.getElementById('txtunitcost').value = "0.00";
    document.getElementById('hdnID').value = 0;
    document.getElementById('txtavailableqty').value = '';

    document.getElementById('txtProduct').focus();
    document.getElementById('hdnrate').value = '';
    document.getElementById('pototalqty').value = '';
    document.getElementById('txtqty').value = '';
    document.getElementById('txtqtyml').value = '';
    document.getElementById('hdnSellingPrice').value = '0.00';
    $('#txtPD').val('');
    
    var ddlunits = document.getElementById('txtUnits');
    var intTotalItems = ddlunits.options.length;

    for (var intCounter = intTotalItems; intCounter >= 1; intCounter--) {

        ddlunits.remove(intCounter);
    }
    ddlunits.options.length = 0;
    var optn1 = document.createElement("option");
    ddlunits.options.add(optn1);
    var strSelect=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_01")== null ?"Select":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_01");
    optn1.text = strSelect;
    optn1.value = "0";

    // var ddloc = document.getElementById('drpLocation');
    var intItems = ddlunits.options.length;

    //    for (var Counter = intItems; Counter >= 1; Counter--) {

    //        ddloc.remove(intCounter);
    //    }

    //    ddloc.options.length = 0;
    //    var optn1 = document.createElement("option");
    //    ddloc.options.add(optn1);
    //    optn1.text = "-----Select-----";
    //    optn1.value = "0";


}
function assignvalue(Action) {
    var drpunits = document.getElementById('txtUnits').options[document.getElementById('txtUnits').selectedIndex].text;
    var drpunitsval = document.getElementById('txtUnits').value;
    // var Locname = document.getElementById('drpLocation').options[document.getElementById('drpLocation').selectedIndex].text;
    var suppliername = document.getElementById('SupName').innerHTML;
    // var Locid = document.getElementById('drpLocation').options[document.getElementById('drpLocation').selectedIndex].value;
    // var TrustOrg = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].text;
    //  var TrustOrgID = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
    var TrustOrg = document.getElementById('txtTrustedOrg').value;
    var TrustOrgID = document.getElementById('hdnSelectedOrg').value;
    var Locid = document.getElementById('hdnSelectedLocation').value;
    var Locname = document.getElementById('txtLocationorg').value;

    var ProductName = document.getElementById('txtProduct').value;
    var CompQty = document.getElementById('txtcompqty').value.trim() == "" ? "0" : document.getElementById('txtcompqty').value.trim();
    var Discount = parseFloat(document.getElementById('txtDiscount').value.trim() == "" ? "0" : document.getElementById('txtDiscount').value.trim()).toFixed(2);
    var Vat = parseFloat(document.getElementById('txtvat').value.trim() == "" ? "0" : document.getElementById('txtvat').value.trim()).toFixed(2);
    var Amount = parseFloat(document.getElementById('txtAmount').value).toFixed(2);
    var comments = document.getElementById('txtComment').value.trim() == "" ? " " : document.getElementById('txtComment').value.trim(); ;
    var pdate = document.getElementById('txtFDate').value;
    var quantity = parseFloat(document.getElementById('txtsQuantity').value.trim() == "" ? "0" : document.getElementById('txtsQuantity').value.trim()).toFixed(2);
    var Productid = document.getElementById('hdnprodsID').value;
    var available = document.getElementById('txtavailableqty').value;
    var qtyml = document.getElementById('txtqtyml').value;
    var supplierid = document.getElementById('hdnSupliersID').value;
    var porderid = document.getElementById('hdnPurchaseOrderID').value;
    var porderdetid = document.getElementById('hdnPurOrderDetailsID').value;
    var rate = parseFloat(document.getElementById('hdnrate').value).toFixed(2);
    var MappingId = document.getElementById('hdnID').value;
    var Totalamt = (quantity * rate);
    var pototalqtys = document.getElementById('pototalqty').value;
    var psellingPrice = document.getElementById('hdnSellingPrice').value;
    var ProductDescription = $('#txtPD').val();
    //To check Duplicate validation & Add op

    //End For Duplicate Validation


    //        var HidValue = document.getElementById('hdnproductlocmap').value;
    //        var AddStatus = 0;
    //        var list = HidValue.split('^');
    //        if (document.getElementById('hdnproductlocmap').value != "") {
    //            for (var count = 0; count < list.length; count++) {
    //                var ProductList = list[count].split('~');
    //                if (ProductList != '') {
    //                    if (ProductName != '') {
    //                        if (ProductList[0] == ProductName && ProductList[1] == Locname && ProductList[3] == pdate) {
    //                            alert("Repeated Values Check the Table List");
    //                            return false;
    //                            //                         
    //                        }
    //                    }

    //                }
    //            }
    //        }
    if ("Add" == Action) {
        if (valid()) {//Repeated value checking function 
            document.getElementById('hdnproductlocmap').value = ProductName + "~" + Locname + "~" + suppliername + "~" + pdate + "~" +
                                                            quantity + "~" + drpunits + "~" + TrustOrg + "~" + supplierid + "~" +
                                                            Productid + "~" + CompQty + "~" + Discount + "~" + Vat + "~" + Amount + "~" + rate + "~" +
                                                             comments + "~" + porderid + "~" + porderdetid + "~" + Locid + "~" + TrustOrgID + "~" + psellingPrice + "~" + drpunitsval +
                                                            "~" + pototalqtys + "~" + MappingId + "~" + ProductDescription + 
                                                            document.getElementById('hdneditunit').value + "^" +
                                                            document.getElementById('hdnproductlocmap').value;
            calcqty();
            fnclear();
            return true;
        }
        else {
            return false;
        }

    }
    else {

        document.getElementById('hdnproductlocmap').value = ProductName + "~" + Locname + "~" + suppliername + "~" + pdate + "~" +
                                                            quantity + "~" + drpunits + "~" + TrustOrg + "~" + supplierid + "~" +
                                                            Productid + "~" + CompQty + "~" + Discount + "~" + Vat + "~" + Amount + "~" + rate + "~" +
                                                            comments + "~" + porderid + "~" + porderdetid + "~" + Locid + "~" + TrustOrgID + "~" + psellingPrice + "~" + drpunitsval
                                                             + "~" + pototalqtys + "~" + MappingId + "~" + ProductDescription +
                                                             document.getElementById('hdneditunit').value + '#' + "^";
        //  qtyml + "~" + Totalamt + "^";
        calcqty();
        fnclear();


    }

}







function Bindlist() {
var strUpdate=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_02")== null ?"Update":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_02");
var strAdd=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_03")== null ?"Add":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_03");
    if (document.getElementById('btnaddo').value == strUpdate) {

        Deleterows();
    }
    else {

        var Action =strAdd;//'Add'
        if (assignvalue(Action)) {
            Tblist();
            fnclear();
        }
    }
}
function btnDelete(sEditedData) {
var strAdd=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_03")== null ?"Add":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_03");
    var i;
    var x = document.getElementById('hdnproductlocmap').value.split("^");
    document.getElementById('hdnproductlocmap').value = '';
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            if (x[i] != sEditedData + "#") {
                document.getElementById('hdnproductlocmap').value += x[i] + "^";
            }

        }
    }
    document.getElementById('btnaddo').value = strAdd;
    btnEdit_OnClick(sEditedData);
    Tblist();

}
function validupdate(editdata) {
    var ProductName = document.getElementById('txtProduct').value;
    var Locname = document.getElementById('drpLocation').options[document.getElementById('drpLocation').selectedIndex].text;
    var pdate = document.getElementById('txtFDate').value;
    var list = document.getElementById('hdnproductlocmap').value.split('^');

    for (var count = 0; count < list.length; count++) {
        if (list[count] != editdata + "#") {
            var ProductList = list[count].split('~');

            if (ProductName != '') {
                if (ProductList[0] == ProductName && ProductList[1] == Locname && ProductList[3] == pdate) {
            var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_01") == null ? "Repeated Values Check the Table List" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_01");
             ValidationWindow(userMsg, errorMsg);
                    return false;

                }
                return true;
            }
        }
    }

}
function Deleterows() {
var strUpdate=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_02")== null ?"Update":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_02");
    var RowEdit = document.getElementById('hdnRowEdit').value;
    var x = document.getElementById('hdnproductlocmap').value.split("^");

    if (RowEdit != "") {
        var Action = strUpdate;
        if (validupdate(RowEdit)) {
            assignvalue(Action)

            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != RowEdit + '#') {
                        document.getElementById('hdnproductlocmap').value += x[i] + "^";
                    }
                }
            }
        }


    }

    document.getElementById('txtavailableqty').value = "";
    document.getElementById('txtqtyml').value = "";
    document.getElementById('txtProductName').value = "";
    document.getElementById('hdnConversionamt').value = "";
    document.getElementById('hdnRowEdit').value = "";
    Tblist();
}
function valid() {
    var ProductName = document.getElementById('txtProduct').value;
    var Locname = document.getElementById('drpLocation').options[document.getElementById('drpLocation').selectedIndex].text;
    var pdate = document.getElementById('txtFDate').value;
    var HidValue = document.getElementById('hdnproductlocmap').value;
    var AddStatus = 0;
    var list = HidValue.split('^');
    if (document.getElementById('hdnproductlocmap').value != "") {
        for (var count = 0; count < list.length; count++) {
            var ProductList = list[count].split('~');
            if (ProductList != '') {
                if (ProductName != '') {
                    if (ProductList[0] == ProductName && ProductList[1] == Locname && ProductList[3] == pdate) {
                        AddStatus = 1;
                        //
                    }

                }

            }
        }
    }
    if (AddStatus == 1) {
            var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_01") == null ? "Repeated Values Check the Table List" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_01");
             ValidationWindow(userMsg, errorMsg);
        return false;
    }
    else {
        return true;
    }
}
function purchaseordertab() {
    if (document.getElementById('hdnprodsID').value <= 0 && document.getElementById('hdnprodsID').value != '') {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_02") == null ? "Enter the Product Name" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_02");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtProduct').focus();
        return false;
     }
    if (document.getElementById('txtProduct').value.trim() == "") {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_03") == null ? "Enter the ProductName" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_03");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtProduct').focus();
        return false;
    }

    if (document.getElementById('txtavailableqty').value == "" && document.getElementById('txtavailableqty').value <= 0) {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_03") == null ? "Enter the ProductName" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_03");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtProduct').focus();
        return false;
    }
    if (document.getElementById('txtsQuantity').value == "" || document.getElementById('txtsQuantity').value <= "0") {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_04") == null ? "Enter the Quantity" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_04");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtsQuantity').focus();
        return false;
    }
    if (document.getElementById('txtUnits').value == '0' || document.getElementById('txtUnits').value == "" || document.getElementById('txtUnits').value == "-Select-") {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_05") == null ? "Select the Units" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_05");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtUnits').focus();
        return false;
    }
    if (document.getElementById('txtAmount').value <= 0 || document.getElementById('txtAmount').value == "") {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_06") == null ? "Rates are not mapped" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_06");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtAmount').focus();
        return false;
    }
    // if (document.getElementById('ddlTrustedOrg').value == '0') {
//    if (document.getElementById('hdnSelectedOrg').value == '0') {
//var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_07") == null ? "Select the issue to location" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_07");
// ValidationWindow(userMsg, errorMsg);
//        // document.getElementById('drpLocation').focus();
//        document.getElementById('txtTrustedOrg').focus();
//        return false;
//    }
    //if (document.getElementById('drpLocation').value == '0') {
    if (document.getElementById('hdnSelectedLocation').value == '0') {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_07") == null ? "Select the issue to location" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_07");
 ValidationWindow(userMsg, errorMsg);
        //document.getElementById('drpLocation').focus();
        document.getElementById('txtLocationorg').focus();
        return false;
    }
    if (document.getElementById('txtTrustedOrg').value.trim() == "") {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_08") == null ? "Select the issue to Organization" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_08");
 ValidationWindow(userMsg, errorMsg);
        // document.getElementById('drpLocation').focus();
        document.getElementById('txtTrustedOrg').focus();
        return false;
    }
    //  if (document.getElementById('drpLocation').text == "") {
    if (document.getElementById('txtLocationorg').value.trim() == "") {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_07") == null ? "Select the issue to location" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_07");
 ValidationWindow(userMsg, errorMsg);
        // document.getElementById('drpLocation').focus();
        document.getElementById('txtLocationorg').focus();
        return false;
    }

    if (document.getElementById('txtFDate').value == "") {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_09") == null ? "Select the Delivery date" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_09");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtFDate').focus();
        return false;
    }
    if (document.getElementById('txtunitcost').value = "") {
        var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_10") == null ? "Select the units amount is not given" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_10");
         ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtunitcost').focus();
        return false;
    }
    if (Number(document.getElementById('txtavailableqty').value) <= Number(document.getElementById('txtsQuantity')).value) {
        var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_11") == null ? "Ensure items added/quantity are provided properly" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_11");
         ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtsQuantity').value = '';
        document.getElementById('txtsQuantity').focus();
        return false;
    }

    //Added by Qutation Discount Alert
    if ($('#hdn_ValidateQutationDiscountInPOconfig').val() == "Y") {

        var checkDiscount = ValidateQutationDiscountInPO(QM_ProductID, $('#txtDiscount').val(), "Validate");
        if (checkDiscount == false) {
            ValidationWindow("PO discount can not be grater than the quotation discount (" + QM_Discount + ") allocated!..", errorMsg);
                   $('#txtDiscount').focus();            
                   return false;
        }     
     
    }
//   
    
    //    var x = document.getElementById('hdnproductlocmap').value.split("^"); ;
    //    var tempQ = document.getElementById('hdnPorderQty').value;
    //    var pProductId = document.getElementById('hdnprodsID').value;
    //    var qty = Number(document.getElementById('txtsQuantity').value)
    //    var TotalQTY = 0;
    //    for (i = 0; i < x.length; i++) {
    //        if (x[i] != "") {
    //            y = x[i].split('~');
    //            if (y[8] == pProductId) {
    //                TotalQTY = Number(TotalQTY) + Number(y[4]);


    //            }
    //        }

    //    }

    //    if (Number(TotalQTY) + parseInt(qty) < Number(tempQ)) {
    //        alert('Provide received quantity less than or equal to ordered qty');
    //        return false;
    //    }
    //    
    document.getElementById('tbTotalCost').style.display = 'block';
    var j = 1;
    Bindlist();

}
function btnEdit_OnClick(sEditedData) {

    fnclear();
var strUpdate=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_02")== null ?"Update":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_02");
    document.getElementById('txtUnits').value == '0';
    document.getElementById('txtavailableqty').value = "";
    document.getElementById('txtqtyml').value = "";
    document.getElementById('hdnRowEdit').value = "";
    document.getElementById('hdnID').value = "";
    document.getElementById('hdnPurchaseOrderID').value = "";
    document.getElementById('hdnPurOrderDetailsID').value = "";
    document.getElementById('hdnConversionamt').value = "";
    document.getElementById('hdneditunit').value = "";
    var x = sEditedData.split('#');
    var y = x[0].split('~');
    document.getElementById('hdnRowEdit').value = sEditedData;
    document.getElementById('txtProduct').value = y[0];
    document.getElementById('txtunitcost').value = parseFloat(y[13]).toFixed(2);
    document.getElementById('hdnrate').value = parseFloat(y[13]).toFixed(2);
    document.getElementById('txtFDate').value = y[3];
    document.getElementById('hdnprodsID').value = y[8];
    document.getElementById('txtsQuantity').value = y[4];

    //document.getElementById('ddlTrustedOrg').value = y[18];
    document.getElementById('txtTrustedOrg').value = y[6];
    document.getElementById('hdnSelectedOrg').value = y[18];
    //    GetLocationlist();
    // document.getElementById('drpLocation').value = y[17];
    document.getElementById('txtLocationorg').value = y[1];
    document.getElementById('hdnSelectedLocation').value = y[17];
    document.getElementById('txtcompqty').value = parseFloat(y[9]).toFixed(2);
    document.getElementById('txtDiscount').value = parseFloat(y[10]).toFixed(2);
    //Added by Qutation Discount Alert
    $('#txtPD').val(y[23]);
    QM_ProductID = y[8];
    ValidateQutationDiscountInPO(y[8], x[1], "BtnEdit");
    document.getElementById('txtvat').value = parseFloat(y[11]).toFixed(2);
    document.getElementById('txtAmount').value = parseFloat(y[12]).toFixed(2);
    document.getElementById('hdnID').value = y[22];
    document.getElementById('hdnPurchaseOrderID').value = y[15];
    document.getElementById('hdnPurOrderDetailsID').value = y[16];
    document.getElementById('pototalqty').value = parseFloat(y[21]).toFixed(2);
    document.getElementById('hdnSellingPrice').value = y[19];

    //    document.getElementById('txtUnits').options[document.getElementById('txtUnits').selectedIndex].innertext = y[19];
    document.getElementById('hdnConversionamt').value = sEditedData;
    drpunits();
    var unis = y[5];
    document.getElementById('txtUnits').value = y[20];
    document.getElementById('btnaddo').value = strUpdate;
    var qtylsu = document.getElementById('txtqtyml').value;
    if (qtylsu == '') {
        qtylsu = '0';
    }
    if (y[20] != '') {
        document.getElementById('txtqtyml').value = parseInt(qtylsu) + parseInt(y[4] * y[20].split('|')[3].trim());

    }
    else {
        document.getElementById('txtqtyml').value = parseInt(y[4] * y[20].split('|')[3].trim());
    }



    var x = document.getElementById('hdnproductlocmap').value.split("^");


    var temps = (y[21]);
    var TotalQTY = 0;
    var qts;
    var count = 0;
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            var z = x[i].split('~');
            if (z[8] == document.getElementById('hdnprodsID').value) {
                TotalQTY = TotalQTY + (z[4] * z[20].split('|')[3].trim());
                count++;
                qts = parseInt(parseInt(temps) - parseInt(TotalQTY));
            }
        }
    }
    if (count != 0) {
        document.getElementById('txtqtyml').value = parseInt(document.getElementById('txtqtyml').value) + parseInt(qts);

    }
    else {
        document.getElementById('txtqtyml').value = parseInt(y[4] * y[20].split('|')[3].trim());
    }
    AvailableQty();



}

function Tblist() {
    var gtotal = "0";
    var table = '';
    var tr = '';
    var end = '</table>';
    var y = '';
    var strProductName=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_04")== null ?"Product Name":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_04");
    var strDeliveryOrg=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_05")== null ?"Delivery Org":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_05");
    var strDeliveryLocation=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_06")== null ?"Delivery Location":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_06");
    var strDeliveryDate=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_07")== null ?"Delivery Date":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_07");
    var strQuantity=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_08")== null ?"Quantity":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_08");
    var strUnits=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_09")== null ?"Units":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_09");
    var strCompQty=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_10")== null ?"Comp Qty":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_10");
    var strDiscount=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_11")== null ?"Discount":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_11");
    var strVat=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_12")== null ?"GST":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_12");
    var strTotalAmt=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_13")== null ?"Total Amount":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_13");
    var strSellingPrice=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_14")== null ?"Selling Price":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_14");
    var strNetAmount=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_15")== null ?"Net Amount":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_15");
    var strAction=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_16")== null ?"Action":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_16");
    var strProductDescription = "ProductDescription";
    
    var pRowId = document.getElementById('hdnRowId').value;
    document.getElementById('lblTable').innerHTML = '';
    table = "<table class='w-100p gridView'"
                           + "><thead  align='center' class='gridHeader' >"
                           + "<th>" + strProductName + "</th>"
                           + "<th>" + strProductDescription + "</th>"
                           + "<th >" + strDeliveryOrg + "</th>"
                           + "<th >" + strDeliveryLocation + "</th>"
                           + "<th >"+strDeliveryDate+"</th>"
                           + "<th >"+strQuantity+"</th>"
                           + "<th >"+strUnits+"</th>"

                           + "<th>"+strCompQty+"</th>"
                           + "<th >"+strDiscount+"</th>"
                           + "<th>"+strVat+"(%)</th>"
                           + "<th >"+strTotalAmt+"</th>"
                           + "<th style='display:none;' >"+strSellingPrice+"</th>"
                           + "<th >"+strNetAmount+"</th>"
                           + "<th >"+strAction+"</th></thead>";
    document.getElementById('txtGrandTotal').value = "0.00";
    document.getElementById('txtNetTotal').value = "0.00";
    document.getElementById('txtProductdiscount').value = "0.00";
    document.getElementById('txtProductVat').value = "0.00";
    var x = document.getElementById('hdnproductlocmap').value.split("^");
    if (x != "") {
        for (i = 0; i < x.length; i++) {
            var units = "";
            if (x[i] != "") {
                var z = x[i].split('#');
                y = z[0].split('~');
                for (j = 1; j < z.length; j++) {
                    if (z[j] != "") {
                        units += "#" + z[j];
                    }
                }
                var ItemDiscount = parseFloat(y[12]) * parseFloat(y[10]) / 100;

                var ItemTax = (parseFloat(y[12]) - parseFloat(ItemDiscount)) * parseFloat(y[11]) / 100;

                var NetAmount = parseFloat(parseFloat(y[12]) - parseFloat(ItemDiscount) + parseFloat(ItemTax)).toFixed(2);

                tr += "<tr align='left'><td >"
                        + y[0] + "</td><td  >"
                        + y[23] + "</td><td  >"
                        + y[6] + "</td><td  >"
                        + y[1] + "</td><td >"
                        + y[3] + "</td><td align='right' >"
                        + y[4] + "</td><td  >"
                        + y[5] + "</td><td align='right' >"
                        + y[9] + "</td><td  align='right' >"
                        +"<input id='" + "QMdis_" + y[8] + "' type='hidden' value='" + y[10] + "' />"
                        + y[10] + "</td><td align='right' >"
                        + y[11] + "</td><td align='right' >"
                        + y[12] + "</td><td style='display:none;'>"
                        + y[19] + "</td><td align='right' >"
                        + NetAmount + "</td>"
                        + "<td class='w-60 a-center'><input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] +
                                                 "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] +
                                                 "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "~" + y[23] + units +
                                                 "' onclick='btnEdit_OnClick(name);' value = 'edit' type='button' class='ui-icon ui-icon-pencil b-none pointer pull-left marginL5'  />"
                         + "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] +
                                                 "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] +
                                                 "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "~" + y[23] + units +
                                                  "'onclick='btnDelete(name);' value = 'delete' type='button' class='ui-icon ui-icon-trash b-none pointer pull-left marginL5'  /></td></tr>";
                var temp = table + tr + end;
                document.getElementById('txtProductdiscount').value = parseFloat(parseFloat(document.getElementById('txtProductdiscount').value) + parseFloat(ItemDiscount)).toFixed(2);
                document.getElementById('txtProductVat').value = parseFloat(parseFloat(document.getElementById('txtProductVat').value) + parseFloat(ItemTax)).toFixed(2);

                document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(document.getElementById('txtGrandTotal').value) + parseFloat(y[12])).toFixed(2);
                document.getElementById('txtNetTotal').value = parseFloat(parseFloat(document.getElementById('txtNetTotal').value) + parseFloat(NetAmount)).toFixed(2);
                //pavithra
                document.getElementById('txtTotal').value = parseFloat(parseFloat(document.getElementById('txtNetTotal').value)).toFixed(2);

            }
        }
var strAdd=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_03")== null ?"Add":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_03");
        document.getElementById('btnaddo').value = strAdd;
        document.getElementById('lblTable').innerHTML = temp;
        gtotal = "0";
    }
    document.getElementById('tbTotalCost').style.display = 'block';
    checkAddToTotal();
}
function IAmSelectedItems(source, eventArgs) {
var strAdd=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_03")== null ?"Add":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_03");
    fnclear();
    document.getElementById('hdnID').value = 0;
    var pounit = "";
    document.getElementById('hdneditunit').value = '';
    document.getElementById('btnaddo').value = strAdd;
    document.getElementById('hdnConversionamt').value = eventArgs.get_value();
    drpunits();
    var lis = eventArgs.get_value().split('#');
    for (i = 0; i < lis.length; i++) {
        if (lis[i] != "") {
            var res = lis[0].split('~');
            var s = lis[i].split('|');
            if (res != "^") {
                document.getElementById('txtProduct').value = eventArgs.get_text();
                document.getElementById('txtavailableqty').value = res[2];
                document.getElementById('hdnprodsID').value = res[0];
                document.getElementById('hdnSupliersID').value = res[1];
                document.getElementById('hdnPurchaseOrderID').value = res[3];
                document.getElementById('hdnPurOrderDetailsID').value = res[4];
                document.getElementById('pnoquantity').value = res[8];
                document.getElementById('pototalqty').value = res[5];
                document.getElementById('hdnPorderQty').value = res[2];
                if (s[0].trim() == res[7].trim()) {
                    document.getElementById('txtqtyml').value = res[2] * s[3];
                    document.getElementById('txtDiscount').value = s[4];
                    document.getElementById('txtvat').value = s[5];
                    document.getElementById('hdnSellingPrice').value = s[6];
                    document.getElementById('txtUnits').value = lis[i];
                }
            }


        }
    }
    if (document.getElementById('txtavailableqty').value <= 0) {
        document.getElementById('txtqtyml').value = '0';
    }
    if (document.getElementById('hdnproductlocmap').value != "") {
        var x = document.getElementById('hdnproductlocmap').value.split("^");
        var temps = (res[5]); //Total qty
        var TotalQTY = 0;
        var qts = 0;
        var count = 0;
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                var z = x[i].split('~');
                if (z[8] == res[0]) {
                    count++;
                    TotalQTY = TotalQTY + (z[4] * z[20].split('|')[3].trim());
                    qts = parseInt(parseInt(temps) - parseInt(TotalQTY));
                }
            }
        }
        if (count != 0) {

            document.getElementById('txtqtyml').value = parseInt(qts);
        }
        else {
            document.getElementById('txtqtyml').value = res[5];

        }
    }
    if (document.getElementById('txtqtyml').value == "0") {
        var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_12") == null ? "The entire quantity of the selected product has been mapped." : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_12");
         ValidationWindow(userMsg, errorMsg);
        fnclear();

    }


}
function drpunits() {
    var dup = document.getElementById('hdnunitss').value;
    var ddlunits = document.getElementById('txtUnits');
    //    ddlunits.options.length = 0;
    //    var optn1 = document.createElement("option");
    //    ddlunits.options.add(optn1);
    //    optn1.text = "-Select-";
    //    optn1.value = "0";
    var splt = document.getElementById('hdnConversionamt').value;
    var qtyml = document.getElementById('txtqtyml').value;
    var t = splt.split('#');
    for (i = 1; i < t.length; i++) {

        if (t[i] != "") {
            document.getElementById('hdneditunit').value += '#' + t[i];
            var res = t[i].split('|');
            if (res != "^") {
                if (dup != res[0]) {

                    var optn = document.createElement("option");
                    ddlunits.options.add(optn);
                    optn.text = res[0];
                    optn.value = t[i].trim();
                }
            }
        }
    }
}
function calcqty() {
    AvailableQty();
    var qtyml = Number(document.getElementById('txtqtyml').value);
    var drpvalue = document.getElementById('txtUnits').value.split("|")[3].trim();
    var calc = Number(drpvalue * document.getElementById('txtsQuantity').value);
    var changeval = Number(document.getElementById('txtqtyml').value - calc);
    document.getElementById('txtqtyml').value = changeval;

    if (changeval == 0) {
        document.getElementById('txtProduct').readOnly = false;
    }
    else {
        document.getElementById('txtProduct').readOnly = false;
    }
}
function ConversionUnits() {

    var drpunits = document.getElementById('txtUnits').options[document.getElementById('txtUnits').selectedIndex].innerHTML;
var strSelect=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_01")== null ?"Select":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_01");
    if (drpunits == strSelect) {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_13") == null ? "select the units" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_13");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtUnits').focus();
        return false;
    }
    document.getElementById('hdnrate').value = "";
    var pid = document.getElementById('hdnprodsID').value
    var splt = document.getElementById('hdnConversionamt').value;
    var qtyml = Number(document.getElementById('txtqtyml').value);
    var drpvalue = document.getElementById('txtUnits').value.split("|")[3].trim();
    var t = splt.split('#');
    for (i = 1; i < t.length; i++) {
        if (t[i] != "") {
            var res = t[i].split('|')
            if (res[0] == drpunits) {
                var calc = Number(res[3] * document.getElementById('txtsQuantity').value);
                if (qtyml < calc) {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_14") == null ? "Issued qty is greater than ordered qty" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_14");
 ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtsQuantity').value = "";
                    document.getElementById('txtUnits').focus();
                    return false;
                }
            }
            if (res[1] != "0.00") {
            }
            if (res[0] == drpunits) {
                document.getElementById('hdnrate').value = res[1];
                document.getElementById('txtunitcost').value = res[1].trim();
            }
        }
    }
    Amountbind();
}


function AvailableQty() {
    var totqty = Number(document.getElementById('txtqtyml').value);

    var drpunitsval = document.getElementById('txtUnits').value;
    if (drpunitsval == "0") {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_15") == null ? "Select the Units Correctly" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_15");
 ValidationWindow(userMsg, errorMsg);
        document.getElementById('txtUnits').focus;
        return false;
    }
    if (totqty > 0) {
        if (drpunitsval.split("|")[3].trim() > totqty) {
            var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_16") == null ? "Issued qty higher than Available qty" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_16");
            var userMsg1 = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_27") == null ? "Qty" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_27");
            ValidationWindow(userMsg + totqty + userMsg1 + drpunitsval, errorMsg);
            document.getElementById('txtUnits').focus;
            document.getElementById('txtUnits').value = "0";
            return false;
        }

        var aqty = totqty / drpunitsval.split("|")[3].trim();
        document.getElementById('txtavailableqty').value = aqty;
        if (drpunitsval.split("|")[3].trim() == 0) {
            document.getElementById('txtavailableqty').value = "0";
            return false;
        }
        else {
            return true;
        }
    }

}
function scase(drpunits, totqty, drpunitsval) {
    if (totqty > 0) {
        if (drpunitsval > totqty) {
        var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_17") == null ? "Issued qty higher than Available qty" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_17");
        var userMsg1 = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_27") == null ? "Qty" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_27");
         ValidationWindow(userMsg  + totqty + ' ' + drpunits + userMsg1 + drpunitsval, errorMsg);
            document.getElementById('txtUnits').focus;
            document.getElementById('txtUnits').value = "0";
            return false;
        }
    }
    var aqty = totqty / drpunitsval;
    document.getElementById('txtavailableqty').value = aqty;
}

function quantity() {

    if (document.getElementById('hdnvalues').value == 0) {
        document.getElementById('txtProductName').value = '';

    }
    if (document.getElementById('hdnvalues').value > 0) {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_18") == null ? "Remaining Quantity is available Map it all" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_18");
 ValidationWindow(userMsg, errorMsg);
        return false;
    }
}
function clearfun() {

    document.getElementById('txtGrandTotal').value = "0.00";
    document.getElementById('txtNetTotal').value = "0.00";
    document.getElementById('txtTotalDiscount').value = "0.00"
    document.getElementById('txtCharges').value = "0.00"
}
/*
Purchase order Functioins  to edit data
*/
function CalculateQty() {
    var pqty = document.getElementById('txtqty').value;
    var pinvqty = document.getElementById('dpUnits').value;
    document.getElementById('txttotalquantity').value = Number(pqty) * Number(pinvqty);
}
function NewUpdateData() {
    if (document.getElementById('dpUnits').value == '0') {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_19") == null ? "Select the units" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_19");
 ValidationWindow(userMsg, errorMsg);

        return false;
    }
    var Purchaseorderid = document.getElementById('lblpurchaseorderid').value;
    var Podetailsid = document.getElementById('lblpodetailsid').value;

    var supplierid = document.getElementById('lblsuppliersid').value;
    var productid = document.getElementById('lblproductid').value;
    var units = document.getElementById('dpUnits').options[document.getElementById('dpUnits').selectedIndex].innerHTML;
    var quantity = document.getElementById('txtqty').value;
    var totalqty = document.getElementById('txttotalquantity').value;

    document.getElementById('hdnpodetails').value = Purchaseorderid + '~' + Podetailsid + '~' + supplierid + '~' + productid + '~' +
                                                    units + '~' + quantity + '~' + totalqty;
}

function UpdatePurchaseDetail(EditOrder) {
    var val = document.getElementById('hdnproductlocmap').value.split("^");
    for (k = 0; k < val.length; k++) {
        if (val[k] != "") {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_20") == null ? "Before Mapping Products To Edit the Purchase Order" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_20");
 ValidationWindow(userMsg, errorMsg);
            return;
        }
    }


    var x = EditOrder.split('~');
    document.getElementById('txtprodname').innerHTML = x[5];
    document.getElementById('txtqty').value = x[4];
    document.getElementById('hdnoriginalqty').value = x[4];
    document.getElementById('txttotalquantity').value = x[6];
    document.getElementById('lblpurchaseorderid').value = x[0];
    document.getElementById('lblpodetailsid').value = x[7];

    document.getElementById('lblsuppliersid').value = x[2];
    document.getElementById('lblproductid').value = x[3];

    $('#divEditPurchaseorder').attr("class", "show");
    $('#gvPurchaseorder').attr("class", "hide");
    
    //document.getElementById('gvPurchaseorder').style.display = "none";
    var ddlunits = document.getElementById('dpUnits');
    ddlunits.options.length = 0;
    var optn1 = document.createElement("option");
    ddlunits.options.add(optn1);
    optn1.text = "-Select-";
    optn1.value = "0";
    var t = x[31].split('#');
    for (i = 1; i < t.length; i++) {
        if (t[i] != "") {
            var res = t[i].split('|');
            if (res != "|") {
                var optn = document.createElement("option");
                ddlunits.options.add(optn);
                optn.text = res[0];
                optn.value = res[1];
            }
        }
    }
}

function UpdateProductDetail() {
    showResponses('ACX2OPPmt1', 'ACX2minusOPPmt1', 'ACX2responses4', 0);
    document.getElementById('ACX2responses5').style.display = "table-row";


}
function updatechangesqty() {
    var temp = 0;
    var pid = document.getElementById('lblproductid').value;
    var HidValue = document.getElementById('hdnproductlocmap').value;
    var list = HidValue.split('^');
    if (document.getElementById('hdnproductlocmap').value != "") {
        for (var count = 0; count < list.length; count++) {
            var ProductSupplierList = list[count].split('~');
            if (ProductSupplierList[8] == document.getElementById('lblproductid').value) {
                temp = parseInt(temp) + parseInt(ProductSupplierList[4]);
            }
        }

        //        if (document.getElementById('hdnoriginalqty').value.trim() > document.getElementById('txtqty').value.trim()) {
        if (document.getElementById('txtqty').value.trim() < temp) {
var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_21") == null ? "Less than quantity is not possible" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_21");
 ValidationWindow(userMsg, errorMsg);
            document.getElementById('txtqty').focus();
            return false;
        }
    }
}
/*
END Purchase order Functioins  to edit data
*/
function Amountbind() {
    document.getElementById('hdnrates').value = "0";
    //    document.getElementById('txtvat').value = "0.00";
    //    document.getElementById('txtDiscount').value = "0.00";

    var qty = document.getElementById('txtsQuantity').value;
    var rate = document.getElementById('hdnrate').value;
    var Totalamt = (qty * rate);
    document.getElementById('hdnrates').value = parseFloat(Totalamt).toFixed(2);
    document.getElementById('txtAmount').value = parseFloat(Totalamt).toFixed(2);
}
function TotalCalculation() {
    document.getElementById('hdnTotaldiscount').value = '';
    var qty = document.getElementById('txtsQuantity').value;
    var rate = document.getElementById('hdnrate').value
    var Discount = document.getElementById('txtDiscount').value;
    //    document.getElementById('txtvat').value;

    var Totalamt = (qty * rate)
    var discamt = (Totalamt * Discount) / 100;
    document.getElementById('hdnTotaldiscount').value = parseFloat(parseFloat(Totalamt) - parseFloat(discamt)).toFixed(2);
    document.getElementById('txtAmount').value = parseFloat(parseFloat(Totalamt) - parseFloat(discamt)).toFixed(2);
    document.getElementById('hdnrates').value = document.getElementById('txtAmount').value;
    var temp = 0.00;
    var Netamt = 0.00;

    var amt = document.getElementById('hdnrates').value;
    var Vat = document.getElementById('txtvat').value;
    Netamt = ((amt * Vat) / 100);
    temp = parseFloat(amt) + parseFloat(Netamt);
    if (amt > 0) {
        document.getElementById('txtAmount').value = "";
        document.getElementById('txtAmount').value = temp.toFixed(2);
    }
}
function ProductItemSelected(sender, args) {


    var ProductCategory = document.forms[0][sender.get_element().name].value; //$("#" + sender.get_element().name).val(); //document.getElementById(sender.get_element().name).value;  //
    var Product = '';
    var result = '';

    if (ProductCategory == '' || ProductCategory == undefined) {

        Product = ProductCategory;
        document.forms[0][sender.get_element().name].value = Product;

    }
    else {

        result = ProductCategory.match(/[^[\]]+(?=])/g)
        if (result != null) {
            Product = ProductCategory.replace(/\s*\[.*?\]\s*/g, '');
            document.forms[0][sender.get_element().name].value = Product;
            // $('#' + sender.get_element().name).val(Product);
        }
        else {

            Product = ProductCategory;
            document.forms[0][sender.get_element().name].value = Product;

        }
    }
}

function IsSelected(source, eventArgs) {
   
    // alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
    var categoryID;
    var AddStatus = 0;
    var quantity = parseFloat(0).toFixed(2);
    var val = eventArgs.get_value().split('~');
    var desc = val[4];
    var unit = "";
    var lsunit = "";
    var amount = parseFloat(0).toFixed(2);
    var rate = parseFloat(0).toFixed(2);
    var CategoryName = val[2]
    var ProductName = eventArgs.get_text().split('--');
    // var InHandQty = 0;
    var ID = 0;
    var BatchNo = val[3];
    var InHandQty = val[4];
    categoryID = val[1];
    $('#txt_PO_Quantity_Stockinhand').val(val[4]);
    $('#hdnparentprodutid').val(val[6]);
    $('#hdnProductId').val(val[0]);
    $('#hdnStockinhandQty').val(val[4]);
    
    //If OrdereUnit is not zero
//    if (val[12].trim() != '0') {
//        $('#ddlPOUnits').val(val[12]);
//        $('#ddlPOUnits').prop("readonly", "true");

//        document.getElementById('ddlPOUnits').disabled = true;
//    }
//    else {
//        $('#ddlPOUnits').val(val[13]);
//    }

    $('#ddlPOUnits').val(val[13]);
    //document.getElementById('ddlPOUnits').disabled = true;
    
    document.getElementById('txt_PO_Qty_LastDayQtyValue').value = val[8];
    document.getElementById('txt_PO_Qty_LastMonthValue').value = val[9];
    document.getElementById('txt_PO_Qty_LastQuaterValue').value = val[10];
    document.getElementById('lbl_PO_Qty_NewValue').innerHTML = val[11];

    document.getElementById('hdnPO_Quantity_Day').value = val[8];
    document.getElementById('hdnPO_Quantity_Month').value = val[9];
    document.getElementById('hdnPO_Quantity_Quater').value = val[10];
    document.getElementById('hdnPO_Quantity_New').value = val[11];
    ProductItemSelected(source, eventArgs);
    OrderedUnitValues = eventArgs.get_value().split('~')[14].trim();
    ConvertOrderUnitList(OrderedUnitValues, "");

}


function Discountcalc() {
    document.getElementById('hdnTotaldiscount').value = '';
    var qty = document.getElementById('txtsQuantity').value;
    var rate = document.getElementById('hdnrate').value
    var Discount = document.getElementById('txtDiscount').value;
    //    document.getElementById('txtvat').value;

    var Totalamt = (qty * rate)
    var Netamt = (Totalamt * Discount) / 100;
    document.getElementById('hdnTotaldiscount').value = parseFloat(parseFloat(Totalamt) - parseFloat(Netamt)).toFixed(2);
    document.getElementById('txtAmount').value = parseFloat(parseFloat(Totalamt) - parseFloat(Netamt)).toFixed(2);
    document.getElementById('hdnrates').value = document.getElementById('txtAmount').value;

}
function Vatcalc() {
    //    var amt = document.getElementById('txtAmount').value;
    var temp = 0.00;
    var Netamt = 0.00;

    var amt = document.getElementById('hdnrates').value;
    var Vat = document.getElementById('txtvat').value;
    Netamt = ((amt * Vat) / 100);
    temp = parseFloat(amt) + parseFloat(Netamt);
    if (amt > 0) {
        document.getElementById('txtAmount').value = "";
        document.getElementById('txtAmount').value = temp.toFixed(2);


    }

}
function checkAddToTotal() {
    if ($('#txtTotalDiscount').val() == '') {
        document.getElementById('txtTotalDiscount').value = '0.00';
    }
    if ($('#txtCharges').val() == '') {
        document.getElementById('txtCharges').value = '0.00';
    }
    var discount = document.getElementById('txtTotalDiscount').value.trim() == "" ? 0 : document.getElementById('txtTotalDiscount').value.trim();
    var FreightCouriercharges = document.getElementById('txtCharges').value.trim() == "" ? 0 : document.getElementById('txtCharges').value.trim();
    var GrossAmount = document.getElementById('txtGrandTotal').value;
    var Prodiscount = document.getElementById('txtProductdiscount').value;
    var ProVat = document.getElementById('txtProductVat').value;
    var Netvalue = parseFloat(GrossAmount) - parseFloat(Prodiscount) + parseFloat(ProVat);
    var calc = (Netvalue * discount) / 100;
    document.getElementById('txtNetTotal').value = parseFloat(parseFloat(document.getElementById('txtGrandTotal').value) - parseFloat(calc) + parseFloat(FreightCouriercharges) - parseFloat(Prodiscount) + parseFloat(ProVat)).toFixed(2);
    //pavithra
    document.getElementById('txtTotal').value = parseFloat(document.getElementById('txtNetTotal').value).toFixed(2);
    TaxTypeCalculation();
}
function checkqty() {
    if (document.getElementById('txtsQuantity').value == '') {
    var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_22") == null ? "Enter issued quantity" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_22");
     ValidationWindow(userMsg, errorMsg);
        //        document.getElementById('txtsQuantity').disabled = false;
        document.getElementById('txtsQuantity').focus();
        return false;
    }
}
function hide() {
    document.getElementById('divEditPurchaseorder').style.display = "none";
    document.getElementById('gvPurchaseorder').style.display = "block";
}
function approvestep() {
    if (document.getElementById('hdnproductlocmap').value == "") {
    var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_23") == null ? "Products are not available" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_23");
     ValidationWindow(userMsg, errorMsg);
        return false;
    }

    var x = document.getElementById('hdnallproducts').value.split("^");
    var y = document.getElementById('hdnproductlocmap').value.split("^");
    var flag = 0;
    var count = 0;
    for (i = 0; i < x.length; i++) {
        for (j = 0; j < y.length; j++) {
            if (x[i] != "") {
                if (y[j] != "") {
                    var s = y[j].split('~');
                    var z = x[i].split('~');
                    if (z[3] == s[8]) {
                        count = count + s[4] * s[20].split('|')[3].trim();
                    }
                }
            }
        }
        if (z != "") {
            if (count != z[6]) {
                flag = 1;
            }
        }
        else {
            //            return false;
        }
        count = 0;
        s = "";
        z = "";

    }
    if (flag == 1) {
    var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_24") == null ? "Ordered Quantities are not matched to available quantity !" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_24");
     ValidationWindow(userMsg, errorMsg);
        //        document.getElementById('txtProductName').focus();
        return false;
    }
}

function purchasevalid() {

    if (document.getElementById('hdnproductlocmap').value == "") {
    var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_25") == null ? "Products are not mapped" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_25");
     ValidationWindow(userMsg, errorMsg);
        //        document.getElementById('txtProductName').focus();
        return false;

    }

    $("#txtGrandTotal").attr("disabled", false);
    $("#txtProductdiscount").attr("disabled", false);
    $("#txtProductVat").attr("disabled", false);
    $("#txtNetTotal").attr("disabled", false);    
    

}

var NetTotal;
var PackingSale;
var ExciseDuty;
var EduCess;
var SecCess;
var CST;

function TaxTypeCalculation() {
    NetTotal = $('#txtNetTotal').val();
    PackingSale = $('#txtPackingSale').val();
    ExciseDuty = $('#txtExciseDuty').val();
    EduCess = $('#txtEduCess').val();
    SecCess = $('#txtSecCess').val();
    CST = $('#txtCST').val();
    if (getParameterByName('tid') != null && getParameterByName('tid') != '') {
        if ($.trim($('#txtPackingSale').val()) != '' && Number($('#txtPackingSale').val()) > 0) {
            $('#chkPackingSale').attr('checked', true);
        }
        if ($.trim($('#txtExciseDuty').val()) != '' && Number($('#txtExciseDuty').val()) > 0) {
            $('#chkExciseDuty').attr('checked', true);
        }
    }
}

//Get QueryString Value
function getParameterByName(name) {
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}

function CalculatePackingSale(ele) {
    if ($(ele).attr('checked')) {
        $('#txtPackingSale').val(PackingSaleCalculation(NetTotal, $('#txtPackingSale').attr('Tax')));
        $('#txtTotal').val(TotalCalculation(NetTotal, $('#txtPackingSale').val(), $('#txtExciseDuty').val(), $('#txtEduCess').val(), $('#txtSecCess').val()));
    }
    else {
        $('#txtPackingSale').val(0);
        // $('#txtCST').val(0);
        $('#txtTotal').val(TotalCalculation(NetTotal, $('#txtPackingSale').val(), $('#txtExciseDuty').val(), $('#txtEduCess').val(), $('#txtSecCess').val()));
    }
}

function CalculateExciseDuty(ele) {
    if ($(ele).attr('checked')) {
        $('#txtExciseDuty').val(ExciseDutyCalculation(NetTotal, PackingSale, $('#txtExciseDuty').attr('Tax')));
        $('#txtEduCess').val(EduAndSecCalculation($('#txtExciseDuty').val(), $('#txtEduCess').attr('Tax')));
        $('#txtSecCess').val(EduAndSecCalculation($('#txtExciseDuty').val(), $('#txtSecCess').attr('Tax')));
        $('#txtCST').val(CSTCalculation(NetTotal, $('#txtPackingSale').val(), $('#txtExciseDuty').val(), $('#txtEduCess').val(), $('#txtSecCess').val(), $('#txtCST').attr('Tax')));
        $('#txtTotal').val(TotalCalculation(NetTotal, $('#txtPackingSale').val(), $('#txtExciseDuty').val(), $('#txtEduCess').val(), $('#txtSecCess').val()));
    }
    else {
        $('#txtExciseDuty').val(0);
        $('#txtEduCess').val(0);
        $('#txtSecCess').val(0);
        $('#txtCST').val(0);
        $('#txtTotal').val(TotalCalculation(NetTotal, $('#txtPackingSale').val(), $('#txtExciseDuty').val(), $('#txtEduCess').val(), $('#txtSecCess').val()));
    }
}


function PackingSaleCalculation(NetTotal, Percentage) {
    if (Percentage == undefined) {
        Percentage = 0;
    }
    var PackingSale = parseFloat(parseFloat(parseFloat(NetTotal) / parseFloat(100)) * parseFloat(Percentage)).toFixed(2);
    return PackingSale;
}


function ExciseDutyCalculation(NetTotal, PackingSale, Percentage) {
    if (Percentage == undefined) {
        Percentage = 0;
    }
    var Duty = parseFloat(parseFloat(NetTotal) + parseFloat(PackingSale)).toFixed(2);
    var ExciseDuty = parseFloat(parseFloat(parseFloat(Duty) / parseFloat(100)) * parseFloat(Percentage)).toFixed(2);
    return ExciseDuty;
}

function EduAndSecCalculation(ExciseDuty, Percentage) {
    if (Percentage == undefined) {
        Percentage = 0;
    }
    var EduCess = parseFloat(parseFloat(parseFloat(ExciseDuty) / parseFloat(100)) * parseFloat(Percentage)).toFixed(2);
    return EduCess;
}

function CSTCalculation(NetTotal, PackingSale, ExciseDuty, EduCess, SecCess, Percentage) {
    if (Percentage == undefined) {
        Percentage = 0;
    }
    var CSTSum = parseFloat(NetTotal) + parseFloat(PackingSale) + parseFloat(ExciseDuty) + parseFloat(EduCess) + parseFloat(SecCess);
    var CST = parseFloat(parseFloat(parseFloat(CSTSum) / parseFloat(100)) * parseFloat(Percentage)).toFixed(2);
    return CST;
}

function TotalCalculation(NetTotal, PackingSale, ExciseDuty, EduCess, SecCess) {
    var TotalSum = parseFloat(NetTotal) + parseFloat(PackingSale) + parseFloat(ExciseDuty) + parseFloat(EduCess) + parseFloat(SecCess);
    var Total = parseFloat(TotalSum).toFixed(2);
    return Total;
}
function SetOrganizationDetails(source, eventArgs) {
    var OrgIDlist = eventArgs.get_value().split('~');
 $("#hdnSelectedOrg").val(OrgIDlist[0]);
 //   $("#<%=hdnSelectedOrg.ClientID%>").val(OrgIDlist[0]);
}

function SetLocationDetails(source, eventArgs) {
    var OrgIDlist = eventArgs.get_value().split('~');
   // $("#<%=hdnSelectedLocation.ClientID%>").val(OrgIDlist[0]);
  $("#hdnSelectedLocation").val(OrgIDlist[0]);
}

function IAmSelected(source, eventArgs) {
    if (document.getElementById('txtProductName').value.trim() == '') {
    var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_26") == null ? "Enter the product name" : SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_26");
     ValidationWindow(userMsg, errorMsg);
            return false;
    }
    document.getElementById('hdnconvesrsiondata').value = eventArgs.get_value();
    var list = eventArgs.get_value().split('^');
//    var ddlSupplierList = document.getElementById('<%= ddlSupplierList.ClientID %>');
    //    ddlSupplierList.options.length = 0;
    $("#ddlSupplierList").empty();
    var strSelect=SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_01")== null ?"Select":SListForAppDisplay.Get("CentralPurchasing_Scripts_PurchaseOrder_js_01");
    var optn1 = document.createElement("option");
    ddlSupplierList.options.add(optn1);
    optn1.text = strSelect;
    optn1.value = "0";
    for (s = 0; s < list.length; s++) {
        var list1 = list[s].split('#');
        if (list[s] != "") {
            var res = list1[0].split('~');

            document.getElementById('supnames').style.display = 'table-cell';
            document.getElementById('drpssupnames').style.display = 'table-cell';
            document.getElementById('secrow').style.display = 'table-row';
            document.getElementById('hdquantity').style.display = 'table-cell';
            document.getElementById('hdunits').style.display = 'table-cell';
            document.getElementById('hdunits').style.display = 'table-cell';
            document.getElementById('txquan').style.display = 'table-cell';
            document.getElementById('drpulist').style.display = 'table-cell';
            document.getElementById('hdtotalQty').style.display = 'table-cell';
            document.getElementById('TotalQty').style.display = 'table-cell';
            document.getElementById('tdtxtInvQty').style.display = 'table-cell';
            document.getElementById('hdInverseQty').style.display = 'table-cell';
            var userMsg = SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_28") != null ? SListForAppMsg.Get("CentralPurchasing_Scripts_PurchaseOrder_js_28") : "Selected product has been marked as Banned. Do you still wish to use this?";
            if (res[6] == 'Y') {
                if (ConfirmWindow(userMsg, InformationMsg, OkMsg, CancelMsg)) {

                }
                else {
                    document.getElementById('txtProductName').value = '';
                    return false;
                }
            }

      
           
        //    document.getElementById('<%=hdnProductId.ClientID %>').value = res[0];
//            document.getElementById('<%=hdnsupplierID.ClientID %>').value = res[2];
//            document.getElementById('<%=hdnparentprodutid.ClientID %>').value = res[5];
//            document.getElementById('<%=hdnLSU.ClientID %>').value = res[4];
//            document.getElementById('<%=hdnQuotationId.ClientID %>').value = res[7];
            //            document.getElementById('<%=hdnStockinhandQty.ClientID %>').value = res[8];



            $("#hdnProductId").val(res[0]);
            $("#hdnsupplierID").val(res[2]);
            $("#hdnparentprodutid").val(res[5]);
            $("#hdnLSU").val(res[4]);
            $("#hdnQuotationId").val(res[7]);
            $("#hdnStockinhandQty").val(res[8]);
            
            var optn = document.createElement("option");                       
            ddlSupplierList.options.add(optn);
            optn.text = res[3];
            optn.value = res[2];

            for (k = 1; k < list1.length; k++) {
                var res1 = list1[k].split('~');
                if (list1[k] != "") {
                    if (res1[2].trim() == "Y") {
                        document.getElementById('ddlSupplierList').value = res[2];
                        supbasedunits();
                    }
                    if (res1[0].trim() == "SQ") {
                        $('#hdnLstDayQty').val(res1[1]);
                        $('#hdnLstMonthQty').val(res1[2]);
                        $('#hdnLstQtrQty').val(res1[3]);
                        $('#hdnProductIs').val(res1[4]);
                    }

                }
                else {

                }
            }

        }


    }
    ProductItemSelected(source, eventArgs);
}


function ValidateQutationDiscountInPO(ProductID, Discount, strType) {
    
    var hdnEditDiscountValue = $('#hdn_QMdiscount').val();
    var splitDiscountvalue = $('#hdn_QMdiscount').val().split("#");


    if (splitDiscountvalue.length > 1 && strType == "BtnEdit") {

        for (var i = 0; i < splitDiscountvalue.length; i++) {

            var splititem = splitDiscountvalue[i] != "0" ? splitDiscountvalue[i].split("~") : "0";
            var checkItem = splititem[0].indexOf(ProductID)

            if (parseInt(splititem[0]) > 0 && parseInt(splititem[0]) != parseInt(ProductID) && strType == "BtnEdit" && checkItem == -1) {

                var splitDiscount = Discount.split("|");
                var QMitemvalue = $('#hdn_QMdiscount').val() + "#" + ProductID + "~" + splitDiscount[4];
                $('#hdn_QMdiscount').val(QMitemvalue);
            }

        }

    }
    else if (splitDiscountvalue.length == 1 && strType == "BtnEdit") {
        var splitDiscount = Discount.split("|");
        $('#hdn_QMdiscount').val($('#hdn_QMdiscount').val() + "#" + ProductID + "~" + splitDiscount[4]);
    }

    else if (splitDiscountvalue.length > 1 && strType == "Validate") {

    for (var i = 0; i < splitDiscountvalue.length; i++) {
    
            var splititem = splitDiscountvalue[i] != "0" ? splitDiscountvalue[i].split("~") : "0";
            var checkItem = splititem[0].indexOf(ProductID)
  
        if (parseInt(splititem[0]) > 0 && parseInt(splititem[0]) == parseInt(ProductID) && strType == "Validate" && checkItem == 0) {
         
                    if (parseFloat(Discount) <= parseFloat(splititem[1])) {
                        return true;
                    }
                    else {
                        QM_Discount = splititem[1];
                        return false;
                    }
        }
      }  
   }

}

/*OrderUnitList DropDown Bind*/

var OrderUnitList = [];
var ddlvalue;


function ConvertOrderUnitList(value, ddlSelectedVal) {
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
    var dropdown = $('#ddlPOUnits');
    dropdown.empty();

    $.each(lstOrderUnit, function(index, item) {
        var $option = $("<option />");
        $option.attr("value", item.UOMCode + "~" + item.ConvesionQty).text(item.UOMCode);
        $(dropdown).append($option);

    });


    if ($.trim(SelectedValue) != "") {
        $("#ddlPOUnits option:contains(" + $.trim(SelectedValue) + ")").attr('selected', true);
    }
    var ddlRecUnitval = "";
    if ($('#ddlPOUnits').val() != null)
        ddlRecUnitval = $('#ddlPOUnits').val().split('~');
    //$("#txtInverseQuantity").val($.trim(ddlRecUnitval[1]));
    //document.getElementById('txtInverseQuantity').disabled = true;
}


function ChangeConvesionQty() {
    var ddlRecUnitval = "";
    if ($('#ddlPOUnits').val() != null)
        ddlRecUnitval = $('#ddlPOUnits').val().split('~');
    var ConQty = $.trim(ddlRecUnitval[1]);
    // var RecQty = $("#txtRECQuantity").val();
    //    if ($.trim(RecQty) == "") {
    //        RecQty = "0";
    //        $("#txtRcvdLSUQty").val("0");
    //      }
    //$("#txtInverseQuantity").val(ConQty);
    // $("#txtRcvdLSUQty").val(Number(RecQty) * Number(ConQty));
    //document.getElementById('txtRcvdLSUQty').disabled = true;
    // document.getElementById('txtInvoiceQty').disabled = true;
    return false;
}



function AddRecUnitDefault() {
    // $("#drpUnit").empty();
    var ddlval = SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_06") == null ? "Select" : SListForAppMsg.Get("StockReceived_ReceiveStock_aspx_06");
    var $option = $("<option />");
    $option.attr("value", $.trim("0")).text($.trim(ddlval));
    $("#drpUnit").append($option);
}
