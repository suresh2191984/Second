function fnclear() {

    document.getElementById('txtsQuantity').value = '';

    document.getElementById('txtProduct').value = "";
    document.getElementById('drpLocation').selectedIndex = 0;
    document.getElementById('ddlTrustedOrg').selectedIndex = 0;
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


    var ddlunits = document.getElementById('txtUnits');
    var intTotalItems = ddlunits.options.length;

    for (var intCounter = intTotalItems; intCounter >= 1; intCounter--) {

        ddlunits.remove(intCounter);
    }
    ddlunits.options.length = 0;
    var optn1 = document.createElement("option");
    ddlunits.options.add(optn1);
    optn1.text = "-Select-";
    optn1.value = "0";

    var ddloc = document.getElementById('drpLocation');
    var intItems = ddlunits.options.length;

    for (var Counter = intItems; Counter >= 1; Counter--) {

        ddloc.remove(intCounter);
    }

    ddloc.options.length = 0;
    var optn1 = document.createElement("option");
    ddloc.options.add(optn1);
    optn1.text = "-----Select-----";
    optn1.value = "0";


}
function assignvalue(Action) {
    var drpunits = document.getElementById('txtUnits').options[document.getElementById('txtUnits').selectedIndex].text;
    var drpunitsval = document.getElementById('txtUnits').value;
    var Locname = document.getElementById('drpLocation').options[document.getElementById('drpLocation').selectedIndex].text;
    var suppliername = document.getElementById('SupName').value;
    var Locid = document.getElementById('drpLocation').options[document.getElementById('drpLocation').selectedIndex].value;
    var TrustOrg = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].text;
    var TrustOrgID = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;

    var ProductName = document.getElementById('txtProduct').value;
    var CompQty = document.getElementById('txtcompqty').value.trim() == "" ? "0" : document.getElementById('txtcompqty').value.trim();
    var Discount =parseFloat(document.getElementById('txtDiscount').value.trim() == "" ? "0" : document.getElementById('txtDiscount').value.trim()).toFixed(2);
    var Vat =parseFloat(document.getElementById('txtvat').value.trim() == "" ? "0" : document.getElementById('txtvat').value.trim()).toFixed(2);
    var Amount =parseFloat(document.getElementById('txtAmount').value).toFixed(2);
    var comments = document.getElementById('txtComment').value.trim() == "" ? " " : document.getElementById('txtComment').value.trim(); ;
    var pdate = document.getElementById('txtFDate').value;
    var quantity = parseFloat( document.getElementById('txtsQuantity').value.trim() == "" ? "0" : document.getElementById('txtsQuantity').value.trim()).toFixed(2);
    var Productid = document.getElementById('hdnprodsID').value;
    var available = document.getElementById('txtavailableqty').value;
    var qtyml = document.getElementById('txtqtyml').value;
    var supplierid = document.getElementById('hdnSupliersID').value;
    var porderid = document.getElementById('hdnPurchaseOrderID').value;
    var porderdetid = document.getElementById('hdnPurOrderDetailsID').value;
    var rate =parseFloat(document.getElementById('hdnrate').value).toFixed(2);
    var MappingId = document.getElementById('hdnID').value;
    var Totalamt = (quantity * rate);
    var pototalqtys = document.getElementById('pototalqty').value;

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
                                                             comments + "~" + porderid + "~" + porderdetid + "~" + Locid + "~" + TrustOrgID + "~" + drpunitsval +
                                                            "~" + pototalqtys + "~" + MappingId + // "~" +// rate + 
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
                                                            comments + "~" + porderid + "~" + porderdetid + "~" + Locid + "~" + TrustOrgID + "~" + drpunitsval
                                                             + "~" + pototalqtys + "~" + MappingId +// "~" + //rate +
                                                             document.getElementById('hdneditunit').value + '#' + "^";
        //  qtyml + "~" + Totalamt + "^";
        calcqty();
        fnclear();


    }

}







function Bindlist() {
    if (document.getElementById('btnaddo').value == 'Update') {

        Deleterows();
    }
    else {

        var Action = "Add";
        if (assignvalue(Action)) {
            Tblist();
            fnclear();
        }
    }
}
function btnDelete(sEditedData) {

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
    document.getElementById('btnaddo').value = 'Add';
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
                    alert("Repeated Values Check the Table List");
                    return false;

                }
                return true;
            }
        }
    }

}
function Deleterows() {
    var RowEdit = document.getElementById('hdnRowEdit').value;
    var x = document.getElementById('hdnproductlocmap').value.split("^");

    if (RowEdit != "") {
        var Action = "Update";
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
        alert("Repeated Values Check the Table List");
        return false;
    }
    else {
        return true;
    }
}
function purchaseordertab() {
    if (document.getElementById('hdnprodsID').value <= 0 && document.getElementById('hdnprodsID').value != '') {
        alert('Enter the Product Name');
        document.getElementById('txtProduct').focus();
        return false;
    }
    if (document.getElementById('txtProduct').value.trim() == "") {
        alert('Enter the ProductName');
        document.getElementById('txtProduct').focus();
        return false;
    }
    
    if (document.getElementById('txtavailableqty').value == "" && document.getElementById('txtavailableqty').value <= 0) {
        alert('Enter the ProductName');
        document.getElementById('txtProduct').focus();
        return false;
    }
    if (document.getElementById('txtsQuantity').value == "" || document.getElementById('txtsQuantity').value <= "0") {
        alert('Enter the Quantity');
        document.getElementById('txtsQuantity').focus();
        return false;
    } 
    if (document.getElementById('txtUnits').value == '0' || document.getElementById('txtUnits').value == "" || document.getElementById('txtUnits').value == "-Select-") {
        alert('Select the Units');
        document.getElementById('txtUnits').focus();
        return false;
    } 
    if (document.getElementById('txtAmount').value <= 0 || document.getElementById('txtAmount').value == "") {
        alert('Rates are not mapped');
        document.getElementById('txtAmount').focus();
        return false;
    }
    if (document.getElementById('ddlTrustedOrg').value == '0') { 
        alert('Select the issue to location ');
        document.getElementById('drpLocation').focus();
        return false;
    }
    if (document.getElementById('drpLocation').value == '0') {
        alert('Select the issue to location ');
        document.getElementById('drpLocation').focus();
        return false;
    }
    if (document.getElementById('drpLocation').text == "") {
        alert('Select the issue to location ');
        document.getElementById('drpLocation').focus();
        return false;
    }
    if (document.getElementById('txtFDate').value == "") {
        alert('Select the Delivery date');
        document.getElementById('txtFDate').focus();
        return false;
    }
    if (document.getElementById('txtunitcost').value = "") {
        alert('Select the units amount is not given');
        document.getElementById('txtunitcost').focus();
        return false;
    }
    if (Number(document.getElementById('txtavailableqty').value) <= Number(document.getElementById('txtsQuantity')).value) {
        alert('Ensure items added/quantity are provided properly');
        document.getElementById('txtsQuantity').value = '';
        document.getElementById('txtsQuantity').focus();
        return false;
    }

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
    document.getElementById('txtsQuantity').value =y[4];

    document.getElementById('ddlTrustedOrg').value = y[18];
    GetLocationlist();
    document.getElementById('drpLocation').value = y[17];
    document.getElementById('txtcompqty').value = parseFloat(y[9]).toFixed(2);
    document.getElementById('txtDiscount').value = parseFloat(y[10]).toFixed(2);
    document.getElementById('txtvat').value =parseFloat(y[11]).toFixed(2);
    document.getElementById('txtAmount').value =parseFloat(y[12]).toFixed(2);
    document.getElementById('hdnID').value = y[21];
    document.getElementById('hdnPurchaseOrderID').value = y[15];
    document.getElementById('hdnPurOrderDetailsID').value = y[16];
    document.getElementById('pototalqty').value =parseFloat(y[20]).toFixed(2);
    //    document.getElementById('txtUnits').options[document.getElementById('txtUnits').selectedIndex].innertext = y[19];
    document.getElementById('hdnConversionamt').value = sEditedData;
    drpunits();
    var unis = y[5];
    document.getElementById('txtUnits').value = y[19];
    document.getElementById('btnaddo').value = 'Update';
    var qtylsu = document.getElementById('txtqtyml').value;
    if (qtylsu == '') {
        qtylsu = '0';
    }
    if (y[20] != '') {
        document.getElementById('txtqtyml').value = parseInt(qtylsu) + parseInt(y[4] * y[19].split('|')[3].trim());

    }
    else {
        document.getElementById('txtqtyml').value = parseInt(y[4] * y[19].split('|')[3].trim());
    }



    var x = document.getElementById('hdnproductlocmap').value.split("^");


    var temps = (y[20]);
    var TotalQTY = 0;
    var qts;
    var count = 0;
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            var z = x[i].split('~');
            if (z[8] == document.getElementById('hdnprodsID').value) {
                TotalQTY = TotalQTY + (z[4] * z[19].split('|')[3].trim());
                count++;
                qts = parseInt(parseInt(temps) - parseInt(TotalQTY)); 
            }
        } 
    }
    if (count != 0) {
        document.getElementById('txtqtyml').value = parseInt(document.getElementById('txtqtyml').value) + parseInt(qts);

    }
    else {
        document.getElementById('txtqtyml').value = parseInt(y[4] * y[19].split('|')[3].trim());  
    }
    AvailableQty();



}

function Tblist() {
    var gtotal = "0";
    var table = '';
    var tr = '';
    var end = '</table>';
    var y = '';
    var pRowId = document.getElementById('hdnRowId').value;
    document.getElementById('lblTable').innerHTML = '';
    table = "<table cellpadding='0' class='dataheaderInvCtrl' cellspacing='0' border='1'"
                           + "style='width: 100%'><thead  align='center' class='dataheader1' style='padding: 3 3 3 3; font-size:12px'>"
                           + "<th style='width:160px;'>Product Name</th>"
                           + "<th style='width:80px;'>Delivery Org</th>"
                           + "<th style='width:120px;'>Delivery Location</th>"
                           + "<th style='width:50px;'>Delivery Date</th>"
                           + "<th style='width:50px;'>Quantity</th>"
                           + "<th style='width:50px;'>Units</th>"

                           + "<th style='width:60px;'>Comp Qty</th>"
                           + "<th style='width:50px;'>Discount</th>"
                           + "<th style='width:50px;'>Vat(%)</th>"
                           + "<th style='width:50px;'>Amount</th>"
                           + "<th style='width:80px;'>Action</th></thead>";
    document.getElementById('txtGrandTotal').value = "0.00";
    document.getElementById('txtNetTotal').value = "0.00";
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
                tr += "<tr align='center'><td style='width:115px;'>"
                        + y[0] + "</td><td style='width:180px;'>"
                        + y[6] + "</td><td style='width:100px;'>"
                        + y[1] + "</td><td style='width:90px;'>"
                        + y[3] + "</td><td style='width:60px;'>"
                        + y[4] + "</td><td style='width:50px;'>"
                        + y[5] + "</td><td style='width:50px;'>"
                        + y[9] + "</td><td style='width:50px;'>"
                        + y[10] + "</td><td style='width:50px;'>"
                        + y[11] + "</td><td style='width:50px;'>"
                        + y[12] + "</td>"
                        + "<td style='width:110px;'><input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] +
                                                 "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] +
                                                 "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + units +
                                                 "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
                         + "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] +
                                                 "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] +
                                                 "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + units +
                                                  "'onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></td></tr>";
                var temp = table + tr + end;

                document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(document.getElementById('txtGrandTotal').value) + parseFloat(y[12])).toFixed(2);
                document.getElementById('txtNetTotal').value = parseFloat(parseFloat(document.getElementById('txtNetTotal').value) + parseFloat(y[12])).toFixed(2);

            }
        }
       
        document.getElementById('btnaddo').value = 'Add';
        document.getElementById('lblTable').innerHTML = temp;
        gtotal = "0";
    }
   
    checkAddToTotal();
}
function IAmSelectedItems(source, eventArgs) {
    
    fnclear();
    document.getElementById('hdnID').value = 0;
    var pounit = "";
    document.getElementById('hdneditunit').value = '';
    document.getElementById('btnaddo').value = 'Add';
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
                    TotalQTY = TotalQTY + (z[4] * z[19].split('|')[3].trim());
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
        alert("The entire quantity of the selected product has been mapped.");
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

    if (drpunits == "-Select-") {
        alert('select the units');
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
                    alert('Issued qty is greater than ordered qty ');
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
        alert("Select the Units Correctly");
        document.getElementById('txtUnits').focus;
        return false;
    }
    if (totqty > 0) {
        if (drpunitsval.split("|")[3].trim() > totqty) {
            alert('Issued qty higher than Available qty  ' + totqty + ' Qty ' + drpunitsval);
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
            alert('Issued qty higher than Available qty  ' + totqty + ' ' + drpunits + ' Qty ' + drpunitsval);
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
        alert('Remaining Quantity is available Map it all ')
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
        alert('Select the units');

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
            alert("Before Mapping Products To Edit the Purchase Order");
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

    document.getElementById('divEditPurchaseorder').style.display = "block";
    document.getElementById('gvPurchaseorder').style.display = "none";
    var ddlunits = document.getElementById('dpUnits');
    ddlunits.options.length = 0;
    var optn1 = document.createElement("option");
    ddlunits.options.add(optn1);
    optn1.text = "-Select-";
    optn1.value = "0";
    var t = x[9].split('#');
    for (i = 1; i < t.length; i++) {
        if (t[i] != "") {
            var res = t[i].split('^');
            if (res != "^") {
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
    document.getElementById('ACX2responses5').style.display = "block";


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
            alert('Less than quantity is not possible');
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
    var discount = document.getElementById('txtTotalDiscount').value.trim() == "" ? 0 : document.getElementById('txtTotalDiscount').value.trim();
    var FreightCouriercharges = document.getElementById('txtCharges').value.trim() == "" ? 0 : document.getElementById('txtCharges').value.trim();
    var GrossAmount = document.getElementById('txtGrandTotal').value;
    var calc = (GrossAmount * discount) / 100;
    document.getElementById('txtNetTotal').value = parseFloat(parseFloat(document.getElementById('txtGrandTotal').value) - parseFloat(calc) + parseFloat(FreightCouriercharges)).toFixed(2);
}
function checkqty() {
    if (document.getElementById('txtsQuantity').value == '') {
        alert('Enter issued quantity');
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
        alert("Products are not available");
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
                        count = count + s[4] * s[19].split('|')[3].trim();
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
        alert('Ordered Quantities are not matched to available quantity !');
        //        document.getElementById('txtProductName').focus();
        return false;
    }
}

function purchasevalid() {

    if (document.getElementById('hdnproductlocmap').value == "") {
        alert("Products are not mapped");
        //        document.getElementById('txtProductName').focus();
        return false;

    }

}