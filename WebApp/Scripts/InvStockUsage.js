
function GetLocationlist() {


    var drpOrgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
    var options = document.getElementById('hdnlocation').value;
    var ddlLocation = document.getElementById('ddlLocation');
    var ddlUser = document.getElementById('ddlUser');
    var userList = document.getElementById('hdnUserlist').value;

    ddlUser.options.length = 0;
    ddlLocation.options.length = 0;
    var optn1 = document.createElement("option");
    ddlUser.options.add(optn1);
    optn1.text = "-----Select-----";
    optn1.value = "0";

    var list = options.split('^');
    for (i = 0; i < list.length; i++) {
        if (list[i] != "") {
            var res = list[i].split('~');

        

            if (drpOrgid == res[0]) {
                var optn = document.createElement("option");
                ddlLocation.options.add(optn);
                optn.text = res[2];
                optn.value = res[1];
            }
          
        }
    }
    Getuserlist();

//    var uselist = userList.split('^');
//    for (i = 0; i < uselist.length; i++) {
//        if (uselist[i] != "") {
//            var res1 = uselist[i].split('~');

//            if (drpOrgid == res1[2]) {
//                var optnuserlist = document.createElement("option");
//                ddlUser.options.add(optnuserlist);
//                optnuserlist.text = res1[0];
//                optnuserlist.value = res1[1];
//            }
//        }



//    }

}
function Getuserlist() {
   
    var drpOrgid1 = document.getElementById('ddlTrustedOrg').value;
    var ddlUser = document.getElementById('ddlUser');
    var userList = document.getElementById('hdnUserlist').value;
    var uselist = userList.split('^');
    for (i = 0; i < uselist.length; i++) {
        if (uselist[i] != "") {
            if (uselist[i].split('~')[2] == Number(drpOrgid1)) {
                res1 = uselist[i].split('~');
                if (drpOrgid1 == res1[2]) {
                    var optnuserlist = document.createElement("option");
                    ddlUser.options.add(optnuserlist);
                    optnuserlist.text = res1[0];
                    optnuserlist.value = res1[1];
                }
            }
        }



    }


}



function CheckProdDetails() {
    if (!CheckProductList()) {
        alert('Provide the product list');
        document.getElementById('txtProduct').focus();
        return false;
    }
}
function CheckProductList() {
    var restTrue = true;
    if (document.getElementById("hdnProductList").value.length < 1) {
        restTrue = false;
    }
    return restTrue;

}

function IAmSelected(source, eventArgs) {

    if (document.getElementById('txtProduct').value.trim() == '') {
        while (count = document.getElementById('tbllist').rows.length) {
            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        } 
    }
    document.getElementById('hdnBatchList').value = '';
    document.getElementById('hdnProductId').value = '';
    var lis = eventArgs.get_value().split('^');
    var banned = lis[0].split('~')[16];
    var AvilableQty = lis[0].split('~')[3];
    var ReorderQty = lis[0].split('~')[17];

    var isTrue = false;
    if (banned == 'Y') {
        if (confirm('Selected product has been marked as Banned. Do you still wish to use this?')) {
        }
        else {
            document.getElementById('txtProduct').value = '';
            document.getElementById('txtProduct').focus();
            while (count = document.getElementById('tbllist').rows.length) {
                for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                    document.getElementById('tbllist').deleteRow(j);
                }
            }
            document.getElementById('divProductDetails').style.display = 'none';
            return false;
        }
    }


    
    if ((parseInt(ReorderQty) >= parseInt(AvilableQty)) ||(parseInt(ReorderQty) > parseInt(AvilableQty))) {
    
        isTrue = true;
        
        }
  
    else {
        isTrue = false ;
    }
    

    if (isTrue == true) {

        if (confirm('Selected product has been reach as reorder level. Do you still wish to use this?')) {

        }
        else {

            while (count = document.getElementById('tbllist').rows.length) {
                for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                    document.getElementById('tbllist').deleteRow(j);
                }
            }
            document.getElementById('divProductDetails').style.display = 'none';
            document.getElementById('txtProduct').value = '';
            document.getElementById('txtProduct').focus();
            return false;
        }
    }
    
    
//    if ((AvilableQty <= ReorderQty )) {

//        if (confirm('Selected product has been reach as reorder level. Do you still wish to use this?')) {

//        }
//        else {
//           
//            while (count = document.getElementById('tbllist').rows.length) {
//                for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
//                    document.getElementById('tbllist').deleteRow(j);
//                }
//            }
//            document.getElementById('divProductDetails').style.display = 'none';
//            document.getElementById('txtProduct').value = '';
//            document.getElementById('txtProduct').focus();
//           return false;
//        }
//    }
    
    var pMainX = document.getElementById('hdnProductList').value.split("^");
    var isTrue = true;
    for (i = 0; i < lis.length; i++) {
        if (lis[i] != "") {
            var isTrue = true;
            for (xY = 0; xY < pMainX.length; xY++) {
                if (pMainX[xY] != "") {
                    xTempP = pMainX[xY].split('~');
                    if (lis[i].split('|')[1].split('~')[2] == xTempP[0] && lis[i].split('|')[0] == xTempP[6]) {
                        isTrue = false;
                        break;
                    }
                }
            }

            if (isTrue) {
                document.getElementById('hdnBatchList').value += lis[i].split('|')[1] + '^';
                document.getElementById('hdnProductId').value = lis[i].split('|')[0];
            }
        }

    }

    var pid = document.getElementById('hdnProductId').value;
    document.getElementById('hdnProBatchNo').value = '';
    document.getElementById('txtQuantity').value = '';
    document.getElementById('txtBatchQuantity').value = '';
    ToTargetFormat($('#txtBatchQuantity'));
    
    document.getElementById('txtUnit').value = '';
    document.getElementById('txtBatchNo').value = '';
    document.getElementById('hdnReceivedID').value = 0;
    document.getElementById('txtBatchNo').disabled = false;
    var x = document.getElementById('hdnBatchList').value.split('^');
    var isAddItem = 0;
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');
            if (CheckTaskItems(pid + "~" + y[0] + "~" + y[2])) {
                document.getElementById('hdnProBatchNo').value += y[0] + "@#$" + y[2] + "|";
                document.getElementById('divProductDetails').style.display = 'block';
                if (lis.length > 1) {
                    if (isAddItem == 0) {
                        document.getElementById('hdnReceivedID').value = y[2];
                         BindQuantity();
                        isAddItem = 1;
                    }
                }
            }

        }

    }
    AutoCompBacthNo();
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


function pSetFocus(obj) {
    var lis = document.getElementById('hdnBatchList').value.split('^');
    if (lis.length > 2) {
        document.getElementById('txtBatchNo').focus();
    }
}

function KeyPress1(e) {

    var ddlaction = document.getElementById('ddlUser');
    if (ddlaction.options[ddlaction.selectedIndex].text == '--Select--') {
        alert('Select The Issued Location And  Received By');
        return false;
    }
}
            

function pSetAddFocus() {
    var qty = document.getElementById('txtQuantity').value.trim();
}


function BindQuantity() {
    var blnExists = false;
    if (document.getElementById('hdnReceivedID').value>0) {
        var BatchNoList = document.getElementById('hdnBatchList').value.split("^");
        for (i = 0; i < BatchNoList.length; i++) {
            if (BatchNoList[i] != "") {
                var val = BatchNoList[i].split("~");


              
                
                if (val[2].trim() == (document.getElementById('hdnReceivedID').value.trim())) {
                    document.getElementById('txtBatchNo').value= val[0];
                    document.getElementById('hdnProductName').value = val[1];
                    document.getElementById('hdnReceivedID').value = val[2];

                    document.getElementById('txtBatchQuantity').value = val[3];
                    // ToTargetFormat(document.getElementById('txtBatchQuantity'));
                    ToTargetFormat($('#txtBatchQuantity'));

                    document.getElementById('txtUnit').value = val[4];
                    ToTargetFormat($('#txtUnit'));

                    document.getElementById('hdnSellingPrice').value = val[5];
                    ToTargetFormat($('#hdnSellingPrice'));

                    document.getElementById('hdnTax').value = val[6];
                    ToTargetFormat($('#hdnTax'));
                    
                    document.getElementById('hdnExpiryDate').value = val[8];
                    document.getElementById('hdnHasExpiryDate').value = val[13];
                    
                    document.getElementById('hdnUnitPrice').value = val[14];
                    ToTargetFormat($('#hdnUnitPrice'));
                    
                    document.getElementById('hdnParentProductID').value = val[15];
                                   
                    
                   // document.getElementById('txtQuantity').focus();
                   
                    var pCell = document.getElementById('hdnReceivedID').value;

                    for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                        document.getElementById('tbllist').rows[j].style.backgroundColor = "";
                        if ("tr_par" + pCell == document.getElementById('tbllist').rows[j].id) {
                            document.getElementById('tbllist').rows[j].style.backgroundColor = '#DCFC5C';
                        }

                    }
                    blnExists = true; break;
                }
            }
        }
    }
    if (blnExists == false) {
        document.getElementById('txtUnit').value = '';
        document.getElementById('txtBatchQuantity').value = '';
        ToTargetFormat($('#txtBatchQuantity'));
        document.getElementById('txtBatchNo').value = '';
        return false;
    }
}
function checkIsEmpty() {
    if (document.getElementById('txtBatchNo').value.trim() == "") {
        alert('Provide the batch number');
        document.getElementById('txtBatchNo').focus();
        return false;
    }

    if (document.getElementById('txtQuantity').value == "") {
        alert('Provide issue quantity');
        document.getElementById('txtQuantity').focus();
        return false;
    }
   // if (Number(document.getElementById('txtBatchQuantity').value) < Number(document.getElementById('txtQuantity').value)) {
    if (Number(ToInternalFormat($('#txtBatchQuantity'))) < Number(ToInternalFormat($('#txtQuantity')))) {
   
        alert('Ensure the items added/quantity are provided properly');
        document.getElementById('txtQuantity').focus();
        return false;
    }

    if (Number(document.getElementById('txtQuantity').value) < 1) {
        alert('Ensure the items added/quantity are provided properly');
        document.getElementById('txtQuantity').focus();
        return false;
    }
   
    if (document.getElementById('add').value != 'Update') {
        var x = document.getElementById('hdnProductList').value.split("^");
        var pId = document.getElementById('hdnReceivedID').value;
        var pName = document.getElementById('hdnProductName').value;
        
        var y; var i;
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
                if (y[0] == pId) {
                    alert('Product number and batch number combination already exist');
                    document.getElementById('txtProduct').value = '';
                    document.getElementById('txtProduct').focus();
                    return false;
                }
            }
        }
    }
    return BindProductList();
}

function BindProductList() {
    
    if (document.getElementById('add').value == 'Update') {
        Deleterows();
    }
    else {

        var pId = document.getElementById('hdnReceivedID').value;
        var pName = document.getElementById('hdnProductName').value;
        var pProductId = document.getElementById('hdnProductId').value;
        var pQTY = document.getElementById('txtBatchQuantity').value;
        var pBatchNo = document.getElementById('txtBatchNo').value;
        var pQuantity = document.getElementById('txtQuantity').value;
        var pUnit = document.getElementById('txtUnit').value;
        var pSellingPrice = document.getElementById('hdnSellingPrice').value;
        var pTax = document.getElementById('hdnTax').value;
        var pExp = document.getElementById('hdnExpiryDate').value;
        var pProBatchNo = document.getElementById('hdnProBatchNo').value;
        var pHasExpiryDate = document.getElementById('hdnHasExpiryDate').value;
        var pUnitPrice = document.getElementById('hdnUnitPrice').value;
        var pParentProductID = document.getElementById('hdnParentProductID').value;
        if (pHasExpiryDate == "Y") {
            var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
            if (expirylevel != '' && expirylevel != null) {
                if (expirylevel > 0) {
                    var isExpired = findExpiryItem(pExp, expirylevel);
                    if (isExpired == 2) {
                        var Replay = confirm("The drug above Expired with in " + expirylevel + " Months. Do you want to continue!Click 'OK'");
                        if (Replay == true) {
                        }
                        else {
                            document.getElementById('txtProduct').value = "";
                            document.getElementById('divProductDetails').style.display = 'none';
                            while (count = document.getElementById('tbllist').rows.length) {

                                for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                                    document.getElementById('tbllist').deleteRow(j);
                                }
                            }
                            return false;
                        }
                    }
                }
            }
        }

            document.getElementById('hdnProductList').value += pId + "~" + pName + "~" +
                        pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" +
                        pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" + pProBatchNo + "~" + pHasExpiryDate + "~" +pUnitPrice + '~' + pParentProductID + "^";
            Tblist();
            document.getElementById('txtQuantity').value = '';
            document.getElementById('txtUnit').value = '';

        }
        document.getElementById('add').value = 'Add';
        document.getElementById('txtProduct').value = '';
        while (count = document.getElementById('tbllist').rows.length) {

            for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                document.getElementById('tbllist').deleteRow(j);
            }
        }
        return false;
        
    }
    function Tblist() {
        while (count = document.getElementById('tblOrederedItems').rows.length) {

            for (var j = 0; j < document.getElementById('tblOrederedItems').rows.length; j++) {
                document.getElementById('tblOrederedItems').deleteRow(j);
            }
        }


        var Headrow = document.getElementById('tblOrederedItems').insertRow(0);
        Headrow.id = "HeadID";
        //    Headrow.style.backgroundColor = "#2c88b1";
        Headrow.style.fontWeight = "bold";
        //    Headrow.style.color = "#FFFFFF";
        Headrow.className = "dataheader1"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);
        var cell5 = Headrow.insertCell(4);
        var cell6 = Headrow.insertCell(5);
        var cell7 = Headrow.insertCell(6);


        cell1.innerHTML = "Product Name";
        cell2.innerHTML = "Batch No";
        cell3.innerHTML = "Issued Qty";
        cell4.innerHTML = "Unit";
        cell5.innerHTML = "Selling Price";
        cell6.innerHTML = "Amount";
        cell7.innerHTML = "Action";

        var x = document.getElementById('hdnProductList').value.split("^");
        if (document.getElementById('lblNonMedicalAmt') != null)
            document.getElementById('lblNonMedicalAmt').innerHTML = "0.00";
        var tGrandTotal = 0.00;
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');

                var row = document.getElementById('tblOrederedItems').insertRow(1);
                row.style.height = "13px";
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var cell7 = row.insertCell(6);


                cell1.innerHTML = y[1];
                cell2.innerHTML = y[2];
                cell3.innerHTML = y[3];
                cell4.innerHTML = y[4];
                cell5.innerHTML = y[7];
                document.getElementById('hdnDisplaydata').value = y[3];
                var sp = ToInternalFormat($('#hdnDisplaydata'));

                document.getElementById('hdnDisplaydata').value = y[7];
                var ap = ToInternalFormat($('#hdnDisplaydata'));

                document.getElementById('hdnDisplaydata').value = parseFloat(ap * sp).toFixed(2);

                var tol = ToTargetFormat($('#hdnDisplaydata'));
                cell6.innerHTML = tol;

                tGrandTotal = parseFloat(parseFloat(tGrandTotal) + parseFloat(ap * sp));
                var expirylevel = Number(document.getElementById('hdnExpiryDateLevel').value);
                if (y[11] == "Y") {
                    if (expirylevel != '' && expirylevel != null) {
                        if (expirylevel > 0) {
                            var isExpired = findExpiryItem(y[9], expirylevel);
                            if (isExpired == 2) {
                                row.style.backgroundColor = "Orange";
                            }
                        }
                    }
                }
                cell7.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
            }
        }
        document.getElementById('hdnProBatchNo').value = '';
        document.getElementById('txtBatchNo').value = '';
        document.getElementById('txtBatchQuantity').value = '';
        document.getElementById('hdnBatchList').value = '';
        document.getElementById('hdnHasExpiryDate').value = '';
        document.getElementById('divProductDetails').style.display = 'none';
        document.getElementById('txtProduct').focus();
        document.getElementById('hdnProductName').value = '';
        document.getElementById('txtBatchNo').disabled = false;
        document.getElementById('hdnParentProductID').value = '';

    }


    function findExpiryItem(Expiredate, ConfigExpiryDateLevel) {
        var today = new Date();
        var Expdate = new Date(Expiredate);

        var monthdiff = monthDiff(today, Expdate);
        if (monthdiff >= 0) {
            if (monthdiff > ConfigExpiryDateLevel) {
            }
            else {
                return 2; //Expired with in ConfigExpiryDateLevel
            }
        }
//        else {
//            return 1; //Alredy Expired
//        }
    }
    function monthDiff(d1, d2) {
        var months;
        months = (d2.getFullYear() - d1.getFullYear()) * 12;
        months -= d1.getMonth();
        months += d2.getMonth();
        return months;
    }

    function Deleterows() {
        
        var RowEdit = document.getElementById('hdnRowEdit').value;
        var x = document.getElementById('hdnProductList').value.split("^");
        if (RowEdit != "") {
            var pId = document.getElementById('hdnReceivedID').value;
            var pProductId = document.getElementById('hdnProductId').value;
            var pName = document.getElementById('hdnProductName').value;
            var pQTY = document.getElementById('txtBatchQuantity').value;
            var pBatchNo = document.getElementById('txtBatchNo').value;
            var pQuantity = document.getElementById('txtQuantity').value;
            var pUnit = document.getElementById('txtUnit').value;
            var pSellingPrice = document.getElementById('hdnSellingPrice').value;
            var pTax = document.getElementById('hdnTax').value;
            var pExp = document.getElementById('hdnExpiryDate').value;
            var pProBatchNo = document.getElementById('hdnProBatchNo').value;
            var pHasExpiryDate = document.getElementById('hdnHasExpiryDate').value;
            var pUnitPrice = document.getElementById('hdnUnitPrice').value;
            var pParentProductID = document.getElementById('hdnParentProductID').value;
            document.getElementById('hdnProductList').value = pId + "~" + pName + "~" +
                            pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" +
                            pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pExp + "~" + pProBatchNo + "~" + pHasExpiryDate + "~" + pUnitPrice + '~' + pParentProductID + "^";


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
       
        var y = sEditedData.split('~');

        document.getElementById('hdnReceivedID').value = y[0];
        document.getElementById('hdnProductName').value = y[1];
        document.getElementById('txtProduct').value = y[1];
        document.getElementById('txtBatchNo').disabled = true;
        document.getElementById('txtBatchNo').value = y[2];
        document.getElementById('txtQuantity').value = y[3];
        document.getElementById('txtUnit').value = y[4];
        document.getElementById('txtBatchQuantity').value = y[5];
        document.getElementById('hdnProductId').value = y[6];
        document.getElementById('hdnRowEdit').value = sEditedData;
        document.getElementById('add').value = 'Update';
        document.getElementById('divProductDetails').style.display = 'block';
        document.getElementById('hdnSellingPrice').value = y[7];
        document.getElementById('hdnTax').value = y[8];
        document.getElementById('hdnExpiryDate').value = y[9];
        document.getElementById('hdnProBatchNo').value = y[10];
        document.getElementById('hdnHasExpiryDate').value = y[11];
        document.getElementById('hdnUnitPrice').value = y[12];
        document.getElementById('hdnParentProductID').value = y[13];
        

        AutoCompBacthNo();
    }

    function btnDelete(sEditedData) {
         
        var i;
        var x = document.getElementById('hdnProductList').value.split("^");
        document.getElementById('hdnProductList').value = '';
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                if (x[i] != sEditedData) {
                    document.getElementById('hdnProductList').value += x[i] + "^";
                }
            }
        }
        Tblist();
       
//        
    }

///////////////Auto/////////
    function AutoCompBacthNo() {
        var customarray = document.getElementById('hdnProBatchNo').value.split("|");
        actb(document.getElementById('txtBatchNo'), customarray);
    }
    //////////////////////////////////
//==============jayamoorthi=====================
    function locationdetails() {
        var Trustedorgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
        if (Trustedorgid > 0) {

            document.getElementById('hdnProBatchNo').value = Trustedorgid;
        }
        else{
      //  alert('select an organization');
        return false;
        }
        var SelectUserID = document.getElementById('ddlUser').options[document.getElementById('ddlUser').selectedIndex].value;

        if (SelectUserID > 0) {

            document.getElementById('hdnUserID').value = SelectUserID;
        }
else{
     //  alert('select the received by');
       return false ;
       }
        var Fromlocationid = document.getElementById('ddlLocation').options[document.getElementById('ddlLocation').selectedIndex].value;

        if (Fromlocationid > 0) {

            document.getElementById('hdnFromLocationID').value = Fromlocationid;
        }
        else{
        alert('select the location');
        return false ;
        }
    
    }
    
    //=================================

    function checkDetails(objFile) {

        locationdetails();


        if (objFile == "StockIssued") {

            if (document.getElementById('ddlTrustedOrg').value == '0') {
                alert('Select the Organization ');
                document.getElementById('ddlTrustedOrg').focus();
                return false;
            }
            if (document.getElementById('ddlLocation').value == '0') {
                alert('Select the issue to location ');
                document.getElementById('ddlLocation').focus();
                return false;
            }
            if (document.getElementById('ddlUser').value == '0') {
                alert('Select the received by ');
                document.getElementById('ddlUser').focus();
                return false;
            }
            document.getElementById('btnSubmit').style.display = "none";
        }
        if (objFile == "StockDamage") {
            if (document.getElementById('txtStockDamageDate').value == '') {
                alert('Select stock damage date');
                document.getElementById('txtStockDamageDate').focus();
                return false;
            }

            if (document.getElementById('INVStockUsage1_hdnProductList').value == '') {
                alert('Select the product');
                document.getElementById('INVStockUsage1_txtProduct').focus();
                return false;
            }

            document.getElementById('btnReturnStock').style.display = "none";
            
        
        }

        
        if (document.getElementById('hdnProductList').value == '') {
            
                alert('Select the product');
                document.getElementById('txtProduct').focus();
                return false;
            
        }




       
        return true;
    }

   
   

     

     
    

   
    
