<%@ Control Language="C#" AutoEventWireup="true" CodeFile="INVStockUsage.ascx.cs"
    Inherits="InventoryCommon_Controls_INVStockUsage" %>

<%@ Register Src="~/InventoryCommon/Controls/INVAttributeUsage.ascx" TagName="INVAttributeUsage"
    TagPrefix="uc2" %>

<script type="text/javascript" language="javascript">
    
    var slist;

    var Productlist = SListForAppDisplay.Get('InventoryCommon_Controls_INVStockUsage_ascx_15');
    if (Productlist == null) {
        Productlist = "Product List (Double click the list to select the Batch No.)";
    }

    var Issuedqty = SListForAppDisplay.Get('InventoryCommon_Controls_INVStockUsage_ascx_16');
    if (Issuedqty == null) {
        Issuedqty = "Issued Qty";
    }
    var ProductName = SListForAppDisplay.Get('InventoryCommon_Controls_INVStockUsage_ascx_17');
    if (ProductName == null) {
        ProductName = "Product Name:";
    }
    var Update = SListForAppDisplay.Get('InventoryCommon_Controls_INVStockUsage_ascx_18');
    if (Update == null) {
        Update = "Update";
    }
    if (Productlist != null && Issuedqty != null && ProductName != null && Update != null) {
         slist = (Productlist, Issuedqty, ProductName, Update);
    }
    else {
        slist = ("Product List (Double click the list to select the Batch No.)", "Issued Qty", "Product Name:", "Update");
    }
</script>

<script language="javascript" type="text/javascript">
//    function ShowAlertMsg(key) {
//        var userMsg = SListForApplicationMessages.Get(key);
//        if (userMsg != null) {
//            alert(userMsg);
//        }
//        else if (key == "CommonControls\\INVStockUsage.ascx.cs_1") {
//            alert('Product quantity has been exceeded');
//        }
//        else if (key == "CommonControls\\INVStockUsage.ascx.cs_2") {
//            alert('Cannot be added multiple times');
//        }
//        else if (key == "CommonControls\\INVStockUsage.ascx.cs_3") {
//            alert('Product Detail Does not Exist');
//        }
//        return true;
   // }
    function BindQuantity() {
        var blnExists = false;

        if (document.getElementById('<%=txtBatchNo.ClientID %>').value.trim() != "") {
            var BatchNoList = document.getElementById('<%=hdnBatchList.ClientID %>').value.split("^");
            //debugger;
            for (i = 0; i < BatchNoList.length; i++) {
                if (BatchNoList[i] != "") {
                    var val = BatchNoList[i].split("~");
                    if (val[0].toUpperCase() == (document.getElementById('<%=txtBatchNo.ClientID %>').value.trim()).toUpperCase()) {
                        document.getElementById('<%=txtBatchQuantity.ClientID %>').value = val[3];
                        document.getElementById('<%=hdnTotalqty.ClientID %>').value = val[3];
                        document.getElementById('<%=hdnProductName.ClientID %>').value = val[1];
                        document.getElementById('<%=hdnReceivedID.ClientID%>').value = val[2];
                        document.getElementById('<%=txtUnit.ClientID %>').value = val[4];
                        document.getElementById('<%=hdnSellingPrice.ClientID %>').value = val[5];
                        document.getElementById('<%=hdnTax.ClientID %>').value = val[6];
                        document.getElementById('<%=hdnCategoryID.ClientID %>').value = val[7];
                        document.getElementById('<%=hdnExpiryDate.ClientID %>').value = val[8];
                        document.getElementById('<%= hdnAttributes.ClientID %>').value = val[9];
                        document.getElementById('<%= hdnAttributeDetailTmp.ClientID %>').value = val[10];
                        document.getElementById('<%= hdnAttributeDetail.ClientID %>').value = 'N';
                        if (val[9] != "N" && val[10] != "N") {
                            //document.getElementById('<%= trAttribute.ClientID%>').style.display = "block";
                            $('#<%= trAttribute.ClientID %>').removeClass().addClass('show');
                        } else {
                        //document.getElementById('<%= trAttribute.ClientID%>').style.display = "none";
                        $('#<%= trAttribute.ClientID %>').removeClass().addClass('hide');
                        }
                        document.getElementById('<%=hdnUnitPrice.ClientID %>').value = val[14];

                        document.getElementById('<%= hdnAction.ClientID %>').value = 'Add';
                        blnExists = true;

                        document.getElementById('<%= txtQuantity.ClientID %>').focus(); break;
                        ToTargetFormat($('#<%=txtBatchQuantity.ClientID %>'));
                        ToTargetFormat($('#<%=hdnSellingPrice.ClientID %>'));
                        ToTargetFormat($('#<%=hdnTax.ClientID %>'));
                        ToTargetFormat($('#<%=hdnUnitPrice.ClientID %>'));
                        ToTargetFormat($('#<%=hdnTotalqty.ClientID %>'));
                        
                    }
                }
            }
        }
        if (blnExists == false) {
            //            alert("Enter the correct BatchNo");
            document.getElementById('<%=txtUnit.ClientID %>').value = '';
            document.getElementById('<%=txtBatchQuantity.ClientID %>').value = '';
            //            document.getElementById('<%=txtBatchNo.ClientID %>').focus();
            document.getElementById('<%=txtBatchNo.ClientID %>').value = '';
            return false;
        }
        document.getElementById('<%=txtUnit.ClientID %>').readOnly = true;
    }

    function checkIsEmpty() {
        if (document.getElementById('<%=txtBatchNo.ClientID %>').value.trim() == "") {

            var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_04') != null ? SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_04') : "Please Enter the Batch No.";
            var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('<%=txtBatchNo.ClientID %>').focus();
            return false;
        }

        if (document.getElementById('<%=txtQuantity.ClientID %>').value == "") {
            var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_05') != null ? SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_05') : "Please Enter Issue Quantity.";
            var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('<%=txtQuantity.ClientID %>').focus();
            return false;
        }
        //if (Number(document.getElementById('<%=txtBatchQuantity.ClientID %>').value) < Number(document.getElementById('<%=txtQuantity.ClientID %>').value)) {
        if (Number(ToInternalFormat($('#<%=txtBatchQuantity.ClientID %>'))) < Number(ToInternalFormat($('#<%=txtQuantity.ClientID %>')))) {
            var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_06') != null ? SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_06') : "Please Check Items Added/Quantity entered properly.";
            var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('<%=txtQuantity.ClientID %>').focus();
            return false;
        }

        // if (Number(document.getElementById('<%=txtQuantity.ClientID %>').value) == 0) {
        if (Number(ToInternalFormat($('#<%=txtQuantity.ClientID %>'))) == 0) {
            var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_07') != null ? SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_07') : "Please Check Items Added/Quantity entered properly.";
            var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('<%=txtQuantity.ClientID %>').focus();
            return false;
        }

        //        if (document.getElementById('<%= hdnAttributeDetailTmp.ClientID %>').value != "N") {
        //            if (document.getElementById('<%= hdnAttributeDetail.ClientID %>').value == "N") {
        //                alert('Please Add Attribute Details.');
        //                //document.getElementById('<%= hdnAttributeDetail.ClientID %>').focus();
        //                return false;
        //            }
        //        }


        if (document.getElementById('add').value != 'Update') {
            var x = document.getElementById('<%=hdnProductList.ClientID %>').value.split("^");
            var pProductId = document.getElementById('<%=hdnProductId.ClientID %>').value;
            var pName = document.getElementById('<%=hdnProductName.ClientID %>').value;
            var pBatchNo = document.getElementById('<%=txtBatchNo.ClientID %>').value;
            var y; var i;
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    if (y[6] == pProductId && y[2] == pBatchNo) {
                        var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_08') != null ? SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_08') : "ProductName and BatchNo is Already exists .";
                        var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
                        ValidationWindow(userMsg, errorMsg);
                        document.getElementById('<%=txtProduct.ClientID %>').value = '';
                        document.getElementById('<%=txtProduct.ClientID %>').focus();
                        return false;
                    }
                }
            }
        }
        return true;
    }

    function BindProductList() {
        //debugger;
        //  document.getElementById('add').value = document.getElementById('<%= hdnAction.ClientID %>').value;
        if (document.getElementById('add').value == 'Update') {
            if (document.getElementById('<%= hdnAttributes.ClientID %>').value != 'N') {
               // if (Number(document.getElementById('<%= hdnQuantity.ClientID %>').value) < Number(document.getElementById('<%= txtQuantity.ClientID %>').value)) {
                if (Number(ToInternalFormat($('#<%=hdnQuantity.ClientID %>'))) < Number(ToInternalFormat($('#<%=txtQuantity.ClientID %>')))) {
                    var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_09') != null ? SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_09') : "Attribute Detail Missing For Some Products";
                    var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
            }
            else {
                Deleterows();
            }
        }
        else {
            var pId = document.getElementById('<%=hdnReceivedID.ClientID %>').value;
            var pName = document.getElementById('<%=hdnProductName.ClientID %>').value;
            var pProductId = document.getElementById('<%=hdnProductId.ClientID %>').value;
            var pQTY = document.getElementById('<%=hdnTotalqty.ClientID %>').value;
            var pBatchNo = document.getElementById('<%=txtBatchNo.ClientID %>').value;
            var pQuantity = document.getElementById('<%=txtQuantity.ClientID %>').value;
            var pUnit = document.getElementById('<%=txtUnit.ClientID %>').value;
            var pSellingPrice = document.getElementById('<%=hdnSellingPrice.ClientID %>').value;
            var pTax = document.getElementById('<%=hdnTax.ClientID %>').value;
            var pCat = document.getElementById('<%=hdnCategoryID.ClientID %>').value;
            var pExp = document.getElementById('<%=hdnExpiryDate.ClientID %>').value;
            var pAttributes = document.getElementById('<%= hdnAttributes.ClientID %>').value;
            var pAttributeDetail = document.getElementById('<%= hdnAttributeDetail.ClientID %>').value;
            var pTemAttrip = document.getElementById('<%= hdnAttributeDetailTmp.ClientID %>').value;
            var pProBatchNo = document.getElementById('<%= hdnProBatchNo.ClientID %>').value;
            var pUnitPrice = document.getElementById('<%=hdnUnitPrice.ClientID %>').value;
            document.getElementById('<%=hdnProductList.ClientID %>').value += pId + "~" + pName + "~" + pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" + pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pCat + "~" + pExp + "~" + pAttributes + "~" + pAttributeDetail + "~" + pTemAttrip + "~" + pProBatchNo + "~" + pUnitPrice + "^";
            Tblist();
            document.getElementById('<%=txtQuantity.ClientID %>').value = '';
            document.getElementById('<%=txtUnit.ClientID %>').value = '';
        }
        document.getElementById('add').value = 'Add';
        document.getElementById('<%= hdnAction.ClientID %>').value = 'Add';
        //document.getElementById('<%=divProductDetails.ClientID %>').style.display = 'none';
        $('#<%=divProductDetails.ClientID %>').removeClass().addClass('hide');
        document.getElementById('<%=lblProductName.ClientID %>').innerHTML = '';
        document.getElementById('<%=txtProduct.ClientID %>').value = '';
        //        document.getElementById('<%=txtProduct.ClientID %>').focus();



    }

    function Tblist() {
        var table = '';
        var tr = '';
        
        var TotalAmount=SListForAppDisplay.Get('InventoryCommon_Controls_INVStockUsage_ascx_19');
        if(TotalAmount==null)
        {
          TotalAmount="Total Amount";
        }
        
        var ProductName=SListForAppDisplay.Get('InventoryCommon_Controls_INVStockUsage_ascx_20');
        if(ProductName==null)
        {
          ProductName="Product Name";
        }
        var BatchNo=SListForAppDisplay.Get('InventoryCommon_Controls_INVStockUsage_ascx_21');
        if(BatchNo==null)
        {
          BatchNo="Batch No";
        }
        var IssuedQty=SListForAppDisplay.Get('InventoryCommon_Controls_INVStockUsage_ascx_16');
        if(IssuedQty==null)
        {
          IssuedQty="Issued Qty";
        }
        var Unit=SListForAppDisplay.Get('InventoryCommon_Controls_INVStockUsage_ascx_22');
        if(Unit==null)
        {
          Unit="Unit";
        }
        var SellingPrice=SListForAppDisplay.Get('InventoryCommon_Controls_INVStockUsage_ascx_23');
        if(SellingPrice==null)
        {
          SellingPrice="Selling Price";
        }
        var Amount=SListForAppDisplay.Get('InventoryCommon_Controls_INVStockUsage_ascx_24');
        if(Amount==null)
        {
          Amount="Amount";
        }
        var ReturnQty=SListForAppDisplay.Get('InventoryCommon_Controls_INVStockUsage_ascx_25');
        if(ReturnQty==null)
        {
          ReturnQty="Return Qty";
        }
        if (document.getElementById('<%=lblType.ClientID %>').hdnProBatchNo == 'Issued Qty') {
            document.getElementById('<%=hdnTotal.ClientID %>').value = 0;
            var Totaltd = "'<tr><td class='h-15'></td></tr><tr class='bold paddingT5 paddingL5 paddingR5 paddingB5'><td class='a-right' colspan='5'>" + TotalAmount  + "</td>"
                + "<td id='totalId'>";
            var y = '';
            document.getElementById('<%=lblTable.ClientID %>').innerHTML = '';
            table = "<table cellpadding='2' cellspacing='0' border='1' "
                           + "class='w-100p'><tr class='bold paddingT5 paddingL5 paddingR5 paddingB5'><td >" + ProductName + "</td>"
                           + "<td>" + BatchNo + "</td><td>" + IssuedQty + " </td>"
                           + "<td>" + Unit + "</td><td>" + SellingPrice + "</td><td>" + Amount + "</td></tr>";
            var x = document.getElementById('<%=hdnProductList.ClientID %>').value.split("^");
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    Total(y[3], y[7]);
                    var amount = document.getElementById('<%=hdnAmount.ClientID %>').value;
                    tr += "<tr><td class='w-135'>" + y[1] + "</td><td class='w-75'>"
                        + y[2] + "</td><td class='w-85'>" + y[3] + "</td><td class='w-75'>"
                        + y[4] + "</td><td class='w-90'>" + y[7] + "</td><td class='w-75'>"
                        + Number(amount).toFixed(2) + "</td>"
                        + "<td class='w-102'><input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "' onclick='btnEdit_OnClick(name);' value = '<%=Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_26 %>' type='button' class='view underline pointer'  /> &nbsp;&nbsp;" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "' onclick='btnDelete(name);' value = '<%=Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_27 %>' type='button' class='view underline pointer'  /></td></tr>";
                }
            }
            var temp = table + tr;  // +Totaltd + Number(document.getElementById('<%=hdnTotal.ClientID %>').value).toFixed(2) + "</td></tr></table>'"; ;
            document.getElementById('<%=tempTable.ClientID %>').value = temp;
            document.getElementById('<%=lblTable.ClientID %>').innerHTML = temp;
            document.getElementById('<%= hdnProBatchNo.ClientID %>').value = '';

//            var amt1 = Number(document.getElementById('<%=hdnTotal.ClientID %>').value).toFixed(2);
//            var amt2 = Number(document.getElementById('<%=hdnGrandTotal.ClientID %>').value).toFixed(2);

            var amt1 = Number(ToInternalFormat($('#<%=hdnTotal.ClientID %>'))).toFixed(2);
            var amt2 = Number(ToInternalFormat($('#<%=hdnGrandTotal.ClientID %>'))).toFixed(2);
            document.getElementById('<%=txtGrandTotal.ClientID %>').value = Number(Number(amt1) + Number(amt2)).toFixed(2);
            ToTargetFormat($('#<%=txtGrandTotal.ClientID %>'));


        }
        else {
            var end = '</table>';
            var y = '';
            document.getElementById('<%=lblTable.ClientID %>').innerHTML = '';
            table = "<table cellpadding='2' cellspacing='0' border='1' "
                           + "class=w-100p'><tr class='bold paddingT5 paddingL5 paddingR5 paddingB5'><td >" + ProductName + "</td>"
                           + "<td>" + BatchNo + "</td><td>" + ReturnQty + "</td>"
                           + "<td>" + Unit + "</td>";
            var x = document.getElementById('<%=hdnProductList.ClientID %>').value.split("^");
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    tr += "<tr><td class='w-135'>" + y[1] + "</td><td class='w-75'>"
                        + y[2] + "</td><td class='w-85'>" + y[3] + "</td><td class='w-75'>"
                        + y[4] + "</td>"
                    var tr = '';
                    var end = '</table>';
                    var y = '';
                    document.getElementById('<%=lblTable.ClientID %>').innerHTML = '';
                    table = "<table cellpadding='2' cellspacing='0' border='1' "
                           + "class='w-100p'><tr class='bold paddingT5 paddingL5 paddingR5 paddingB5'><td >" + "<%=Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_28 %>" + "</td>"
                           + "<td>" + "<%=Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_29 %>" + "</td><td>" + "<%=Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_30 %>" + " </td>"
                           + "<td>" + "<%=Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_31 %>" + "</td>";
                    var x = document.getElementById('<%=hdnProductList.ClientID %>').value.split("^");
                    for (i = 0; i < x.length; i++) {
                        if (x[i] != "") {
                            y = x[i].split('~');
                            tr += "<tr><td class='w-135'>" + y[1] + "</td><td class='w-75'>"
                        + y[2] + "</td><td class='w-85'>" + y[3] + "</td><td class='w-75'>"
                        + y[4] + "</td>"
                        + "<td><input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "' onclick='btnEdit_OnClick(name);' value = '<%=Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_26 %>' type='button' class='view underline pointer'  /> &nbsp;&nbsp;" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "' onclick='btnDelete(name);' value = '<%=Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_27 %>' type='button' class='view underline pointer' /></td></tr>";
                        }
                    }
                    var temp = table + tr + end;
                    document.getElementById('<%=tempTable.ClientID %>').value = temp;
                    document.getElementById('<%=lblTable.ClientID %>').innerHTML = temp;
                }
            }
            var temp = table + tr + end;
            document.getElementById('<%=tempTable.ClientID %>').value = temp;
            document.getElementById('<%=lblTable.ClientID %>').innerHTML = temp;


        }
    }
    function Total(qty, Selling) {
        var total;
        document.getElementById('<%=hdnAmount.ClientID %>').value = Number(qty) * Number(Selling)
       // document.getElementById('<%=hdnTotal.ClientID %>').value = format_number(Number(document.getElementById('<%=hdnAmount.ClientID %>').value) + Number(document.getElementById('<%=hdnTotal.ClientID %>').value), 2);
        document.getElementById('<%=hdnTotal.ClientID %>').value = format_number(Number(ToInternalFormat($('#<%=hdnAmount.ClientID %>'))) + Number(ToInternalFormat($('#<%=hdnTotal.ClientID %>'))), 2);

        ToTargetFormat($('#<%=hdnAmount.ClientID %>'));
        ToTargetFormat($('#<%=hdnTotal.ClientID %>'));
    }

    function Deleterows() {
        var RowEdit = document.getElementById('<%=hdnRowEdit.ClientID %>').value;
        var x = document.getElementById('<%=hdnProductList.ClientID %>').value.split("^");
        if (RowEdit != "") {
            var pId = document.getElementById('<%=hdnReceivedID.ClientID %>').value;
            var pProductId = document.getElementById('<%=hdnProductId.ClientID %>').value;
            var pName = document.getElementById('<%=hdnProductName.ClientID %>').value;
            var pQTY = document.getElementById('<%=hdnTotalqty.ClientID %>').value;
            var pBatchNo = document.getElementById('<%=txtBatchNo.ClientID %>').value;
            var pQuantity = document.getElementById('<%=txtQuantity.ClientID %>').value;
            var pUnit = document.getElementById('<%=txtUnit.ClientID %>').value;
            var pSellingPrice = document.getElementById('<%=hdnSellingPrice.ClientID %>').value;
            var pTax = document.getElementById('<%=hdnTax.ClientID %>').value;
            var pCat = document.getElementById('<%=hdnCategoryID.ClientID %>').value;
            var pExp = document.getElementById('<%=hdnExpiryDate.ClientID %>').value;
            var pAttributes = document.getElementById('<%= hdnAttributes.ClientID %>').value;
            var pAttributeDetail = document.getElementById('<%= hdnAttributeDetail.ClientID %>').value;
            var pTemAttrip = document.getElementById('<%= hdnAttributeDetailTmp.ClientID %>').value;
            if (pAttributeDetail != "N") {
                //document.getElementById('<%= trAttribute.ClientID%>').style.display = "block";
                $('#<%= trAttribute.ClientID%>').removeClass().addClass('show');
            } else {
            //document.getElementById('<%= trAttribute.ClientID%>').style.display = "none";
            $('#<%= trAttribute.ClientID%>').removeClass().addClass('hide');
            }
            var pProBatchNo = document.getElementById('<%= hdnProBatchNo.ClientID %>').value;
            var pUnitPrice = document.getElementById('<%=hdnUnitPrice.ClientID %>').value;

            document.getElementById('<%=hdnProductList.ClientID %>').value = pId + "~" + pName + "~" + pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" + pProductId + "~" + pSellingPrice + "~" + pTax + "~" + pCat + "~" + pExp + "~" + pAttributes + "~" + pAttributeDetail + "~" + pTemAttrip + "~" + pProBatchNo + "~" + pUnitPrice + "^";


            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != RowEdit) {
                        document.getElementById('<%=hdnProductList.ClientID %>').value += x[i] + "^";
                    }
                }
            }
            Tblist();
            document.getElementById('<%=txtQuantity.ClientID %>').value = '';
            document.getElementById('<%= hdnQuantity.ClientID %>').value = '';
            document.getElementById('<%=txtUnit.ClientID %>').value = '';
            document.getElementById('<%= hdnAttributeDetailTmp.ClientID %>').value = '';
            document.getElementById('<%= hdnAttributeDetail.ClientID %>').value = '';
            document.getElementById('<%=hdnUnitPrice.ClientID %>').value = '';
        }
    }

    function btnEdit_OnClick(sEditedData) {
        var y = sEditedData.split('~');

        document.getElementById('<%=hdnReceivedID.ClientID %>').value = y[0];
        document.getElementById('<%=hdnProductName.ClientID %>').value = y[1];
        if (y[2] == "*") {
            document.getElementById('<%=txtBatchNo.ClientID %>').disabled = true;
        }
        else {
            document.getElementById('<%=txtBatchNo.ClientID %>').disabled = false;

        }
        document.getElementById('<%=txtBatchNo.ClientID %>').value = y[2];
        document.getElementById('<%=txtQuantity.ClientID %>').value = y[3];
        document.getElementById('<%=hdnQuantity.ClientID %>').value = y[3];
        document.getElementById('<%=txtUnit.ClientID %>').value = y[4];
        document.getElementById('<%=hdnTotalqty.ClientID %>').value = y[5];
        document.getElementById('<%=txtBatchQuantity.ClientID %>').value = y[5];
        document.getElementById('<%=hdnProductId.ClientID %>').value = y[6];
        document.getElementById('<%=hdnRowEdit.ClientID %>').value = sEditedData;
        document.getElementById('add').value = 'Update';
        document.getElementById('<%= hdnAction.ClientID %>').value = slist.Update;
        document.getElementById('<%=listProducts.ClientID %>').value = y[6];
        //document.getElementById('<%=divProductDetails.ClientID %>').style.display = 'block';
        $('#<%=divProductDetails.ClientID %>').removeClass().addClass('show');
        document.getElementById('<%=lblProductName.ClientID %>').innerHTML = slist.ProductName + y[1];

        if (document.getElementById('<%=lblType.ClientID %>').innerHTML == slist.Issuedqty) {
            document.getElementById('<%=hdnSellingPrice.ClientID %>').value = y[7];
            document.getElementById('<%=hdnTax.ClientID %>').value = y[8];
            document.getElementById('<%=hdnCategoryID.ClientID %>').value = y[9];
            document.getElementById('<%=hdnExpiryDate.ClientID %>').value = y[10];
            document.getElementById('<%= hdnAttributes.ClientID %>').value = y[11];
            document.getElementById('<%= hdnAttributeDetail.ClientID %>').value = y[12];
            document.getElementById('<%= hdnAttributeDetailTmp.ClientID %>').value = y[13];


        }
        else {
            document.getElementById('<%= hdnAttributes.ClientID %>').value = y[11];
            document.getElementById('<%= hdnAttributeDetail.ClientID %>').value = y[12];
            document.getElementById('<%= hdnAttributeDetailTmp.ClientID %>').value = y[13];
            // document.getElementById('<%= divProductDetails.ClientID %>').style.display = 'block';
            //  document.getElementById('<%= lblProductName.ClientID %>').innerHTML = 'Product Name: ' + y[1];

        }
        if (document.getElementById('<%= hdnAttributeDetail.ClientID %>').value != "N") {
            //document.getElementById('<%= trAttribute.ClientID%>').style.display = "block";
            $('#<%= trAttribute.ClientID%>').removeClass().addClass('show');
        } else {
        //document.getElementById('<%= trAttribute.ClientID%>').style.display = "none";
        $('#<%= trAttribute.ClientID%>').removeClass().addClass('hide');
        }
        document.getElementById('<%= hdnProBatchNo.ClientID %>').value = y[14];
        document.getElementById('<%=hdnUnitPrice.ClientID %>').value = y[11];
        AutoCompBacthNo();

    }

    function btnDelete(sEditedData) {
        var i;
        var x = document.getElementById('<%=hdnProductList.ClientID %>').value.split("^");
        document.getElementById('<%=hdnProductList.ClientID %>').value = '';
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                if (x[i] != sEditedData) {
                    document.getElementById('<%=hdnProductList.ClientID %>').value += x[i] + "^";
                }
            }
        }
        Tblist();
    }

    function SearchText() {
        if (document.getElementById('<%=txtProduct.ClientID %>').value.trim() == '') {
            var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_10') != null ? SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_10') : "Please Enter the Product Name";
            var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
            ValidationWindow(userMsg, errorMsg);
            document.getElementById('<%=txtProduct.ClientID %>').value = '';
            document.getElementById('<%=txtProduct.ClientID %>').focus();
            return false;
        }

    }

        
</script>

<script type="text/javascript">
    function addEvent(obj, event_name, func_name) {
        if (obj.attachEvent) {
            obj.attachEvent("on" + event_name, func_name);
        } else if (obj.addEventListener) {
            obj.addEventListener(event_name, func_name, true);
        } else {
            obj["on" + event_name] = func_name;
        }
    }
    function removeEvent(obj, event_name, func_name) {
        if (obj.detachEvent) {
            obj.detachEvent("on" + event_name, func_name);
        } else if (obj.removeEventListener) {
            obj.removeEventListener(event_name, func_name, true);
        } else {
            obj["on" + event_name] = null;
        }
    }
    function stopEvent(evt) {
        evt || window.event;
        if (evt.stopPropagation) {
            evt.stopPropagation();
            evt.preventDefault();
        } else if (typeof evt.cancelBubble != "undefined") {
            evt.cancelBubble = true;
            evt.returnValue = false;
        }
        return false;
    }
    function getElement(evt) {
        if (window.event) {
            return window.event.srcElement;
        } else {
            return evt.currentTarget;
        }
    }
    function getTargetElement(evt) {
        if (window.event) {
            return window.event.srcElement;
        } else {
            return evt.target;
        }
    }
    function stopSelect(obj) {
        if (typeof obj.onselectstart != 'undefined') {
            addEvent(obj, "selectstart", function() { return false; });
        }
    }
    function getCaretEnd(obj) {
        if (typeof obj.selectionEnd != "undefined") {
            return obj.selectionEnd;
        } else if (document.selection && document.selection.createRange) {
            var M = document.selection.createRange();
            try {
                var Lp = M.duplicate();
                Lp.moveToElementText(obj);
            } catch (e) {
                var Lp = obj.createTextRange();
            }
            Lp.setEndPoint("EndToEnd", M);
            var rb = Lp.text.length;
            if (rb > obj.value.length) {
                return -1;
            }
            return rb;
        }
    }
    function getCaretStart(obj) {
        if (typeof obj.selectionStart != "undefined") {
            return obj.selectionStart;
        } else if (document.selection && document.selection.createRange) {
            var M = document.selection.createRange();
            try {
                var Lp = M.duplicate();
                Lp.moveToElementText(obj);
            } catch (e) {
                var Lp = obj.createTextRange();
            }
            Lp.setEndPoint("EndToStart", M);
            var rb = Lp.text.length;
            if (rb > obj.value.length) {
                return -1;
            }
            return rb;
        }
    }
    function setCaret(obj, l) {
        obj.focus();
        if (obj.setSelectionRange) {
            obj.setSelectionRange(l, l);
        } else if (obj.createTextRange) {
            m = obj.createTextRange();
            m.moveStart('character', l);
            m.collapse();
            m.select();
        }
    }
    function setSelection(obj, s, e) {
        obj.focus();
        if (obj.setSelectionRange) {
            obj.setSelectionRange(s, e);
        } else if (obj.createTextRange) {
            m = obj.createTextRange();
            m.moveStart('character', s);
            m.moveEnd('character', e);
            m.select();
        }
    }
    String.prototype.addslashes = function() {
        return this.replace(/(["\\\.\|\[\]\^\*\+\?\$\(\)])/g, '\\$1');
    }
    String.prototype.trim = function() {
        return this.replace(/^\s*(\S*(\s+\S+)*)\s*$/, "$1");
    };
    function curTop(obj) {
        toreturn = 0;
        while (obj) {
            toreturn += obj.offsetTop;
            obj = obj.offsetParent;
        }
        return toreturn;
    }
    function curLeft(obj) {
        toreturn = 0;
        while (obj) {
            toreturn += obj.offsetLeft;
            obj = obj.offsetParent;
        }
        return toreturn;
    }
    function isNumber(a) {
        return typeof a == 'number' && isFinite(a);
    }
    function replaceHTML(obj, text) {
        while (el = obj.childNodes[0]) {
            obj.removeChild(el);
        };
        obj.appendChild(document.createTextNode(text));
    }

    function actb(obj, ca) {
        /* ---- Public Variables ---- */
        this.actb_timeOut = -1; // Autocomplete Timeout in ms (-1: autocomplete never time out)
        this.actb_lim = 4;    // Number of elements autocomplete can show (-1: no limit)
        this.actb_firstText = false; // should the auto complete be limited to the beginning of keyword?
        this.actb_mouse = true; // Enable Mouse Support
        this.actb_delimiter = new Array(';', ',');  // Delimiter for multiple autocomplete. Set it to empty array for single autocomplete
        this.actb_startcheck = 1; // Show widget only after this number of characters is typed in.
        /* ---- Public Variables ---- */

        /* --- Styles --- */
        this.actb_bgColor = '#888888';
        this.actb_fwidth = '93px';
        this.actb_textColor = '#FFFFFF';
        this.actb_hColor = '#000000';
        this.actb_fFamily = 'Verdana';
        this.actb_fSize = '11px';
        this.actb_hStyle = 'text-decoration:underline;font-weight="bold"';
        /* --- Styles --- */

        /* ---- Private Variables ---- */
        var actb_delimwords = new Array();
        var actb_cdelimword = 0;
        var actb_delimchar = new Array();
        var actb_display = false;
        var actb_pos = 0;
        var actb_total = 0;
        var actb_curr = null;
        var actb_rangeu = 0;
        var actb_ranged = 0;
        var actb_bool = new Array();
        var actb_pre = 0;
        var actb_toid;
        var actb_tomake = false;
        var actb_getpre = "";
        var actb_mouse_on_list = 1;
        var actb_kwcount = 0;
        var actb_caretmove = false;
        this.actb_keywords = new Array();
        /* ---- Private Variables---- */

        this.actb_keywords = ca;
        var actb_self = this;

        actb_curr = obj;

        addEvent(actb_curr, "focus", actb_setup);
        function actb_setup() {
            addEvent(document, "keydown", actb_checkkey);
            addEvent(actb_curr, "blur", actb_clear);
            addEvent(document, "keypress", actb_keypress);
        }

        function actb_clear(evt) {
            if (!evt) evt = event;
            removeEvent(document, "keydown", actb_checkkey);
            removeEvent(actb_curr, "blur", actb_clear);
            removeEvent(document, "keypress", actb_keypress);
            actb_removedisp();
        }
        function actb_parse(n) {
            if (actb_self.actb_delimiter.length > 0) {
                var t = actb_delimwords[actb_cdelimword].trim().addslashes();
                var plen = actb_delimwords[actb_cdelimword].trim().length;
            } else {
                var t = actb_curr.value.addslashes();
                var plen = actb_curr.value.length;
            }
            var tobuild = '';
            var i;

            if (actb_self.actb_firstText) {
                var re = new RegExp("^" + t, "i");
            } else {
                var re = new RegExp(t, "i");
            }
            var p = n.search(re);

            for (i = 0; i < p; i++) {
                tobuild += n.substr(i, 1);
            }
            tobuild += "<font style='" + (actb_self.actb_hStyle) + "'>"
            for (i = p; i < plen + p; i++) {
                tobuild += n.substr(i, 1);
            }
            tobuild += "</font>";
            for (i = plen + p; i < n.length; i++) {
                tobuild += n.substr(i, 1);
            }
            return tobuild;
        }
        function actb_generate() {

            if (document.getElementById('tat_table')) { actb_display = false; document.body.removeChild(document.getElementById('tat_table')); }
            if (actb_kwcount == 0) {
                actb_display = false;
                return;
            }
            a = document.createElement('table');
            a.cellSpacing = '1px';
            a.cellPadding = '2px';
            //a.style.position = 'absolute';
            a.addClass('absolutePos');
            a.style.top = eval(curTop(actb_curr) + actb_curr.offsetHeight) + "px";
            a.style.left = curLeft(actb_curr) + "px";
            a.style.backgroundColor = actb_self.actb_bgColor;
            a.style.width = actb_self.actb_fwidth;
            a.id = 'tat_table';
            document.body.appendChild(a);
            if (actb_curr.value.length > 2) {
                //document.getElementById('tat_table').style.display = 'block';
                $('#tat_table').removeClass().addClass('show');
            }
            if (actb_curr.value.length < 2) {
                //document.getElementById('tat_table').style.display = 'none';
                $('#tat_table').removeClass().addClass('hide');
                return;
            }


            var i;
            var first = true;
            var j = 1;
            if (actb_self.actb_mouse) {
                a.onmouseout = actb_table_unfocus;
                a.onmouseover = actb_table_focus;
            }
            var counter = 0;
            for (i = 0; i < actb_self.actb_keywords.length; i++) {
                if (actb_bool[i]) {
                    counter++;
                    r = a.insertRow(-1);
                    if (first && !actb_tomake) {
                        r.style.backgroundColor = actb_self.actb_hColor;
                        first = false;
                        actb_pos = counter;
                    } else if (actb_pre == i) {
                        r.style.backgroundColor = actb_self.actb_hColor;
                        first = false;
                        actb_pos = counter;
                    } else {
                        r.style.backgroundColor = actb_self.actb_bgColor;
                        r.style.width = actb_self.actb_fwidth;
                    }
                    r.id = 'tat_tr' + (j);
                    c = r.insertCell(-1);
                    c.style.color = actb_self.actb_textColor;
                    c.style.fontFamily = actb_self.actb_fFamily;
                    c.style.fontSize = actb_self.actb_fSize;
                    c.innerHTML = actb_parse(actb_self.actb_keywords[i]);
                    c.id = 'tat_td' + (j);
                    c.setAttribute('pos', j);
                    if (actb_self.actb_mouse) {
                        //c.style.cursor = 'pointer';
                        c.addClass('pointer');
                        c.onclick = actb_mouseclick;
                        c.onmouseover = actb_table_highlight;
                    }
                    j++;
                }
                if (j - 1 == actb_self.actb_lim && j < actb_total) {
                    r = a.insertRow(-1);
                    r.style.backgroundColor = actb_self.actb_bgColor;
                    r.style.width = actb_self.actb_fwidth;
                    c = r.insertCell(-1);
                    c.style.color = actb_self.actb_textColor;
                    //c.style.fontFamily = 'arial narrow';
                    c.addClass('fontstyle1');
                    c.style.fontSize = actb_self.actb_fSize;
                    //c.align = 'center';
                    c.addClass('a-center');
                    replaceHTML(c, '\\/');
                    if (actb_self.actb_mouse) {
                        //c.style.cursor = 'pointer';
                        c.addClass('pointer');
                        c.onclick = actb_mouse_down;
                    }
                    break;
                }
            }
            actb_rangeu = 1;
            actb_ranged = j - 1;
            actb_display = true;
            if (actb_pos <= 0) actb_pos = 1;
        }
        function actb_remake() {
            document.body.removeChild(document.getElementById('tat_table'));
            a = document.createElement('table');
            a.cellSpacing = '1px';
            a.cellPadding = '2px';
            //a.style.position = 'absolute';
            a.addClass('absolutePos');
            a.style.top = eval(curTop(actb_curr) + actb_curr.offsetHeight) + "px";
            a.style.left = curLeft(actb_curr) + "px";
            a.style.backgroundColor = actb_self.actb_bgColor;
            a.style.width = actb_self.actb_fwidth;
            a.id = 'tat_table';
            if (actb_self.actb_mouse) {
                a.onmouseout = actb_table_unfocus;
                a.onmouseover = actb_table_focus;
            }
            document.body.appendChild(a);
            var i;
            var first = true;
            var j = 1;
            if (actb_rangeu > 1) {
                r = a.insertRow(-1);
                r.style.backgroundColor = actb_self.actb_bgColor;
                r.style.width = actb_self.actb_fwidth;
                c = r.insertCell(-1);
                c.style.color = actb_self.actb_textColor;
                //c.style.fontFamily = 'arial narrow';
                c.addClass('fontstyle1');
                c.style.fontSize = actb_self.actb_fSize;
                //c.align = 'center';
                c.addClass('a-center');
                replaceHTML(c, '/\\');
                if (actb_self.actb_mouse) {
                    //c.style.cursor = 'pointer';
                    c.addClass('pointer');
                    c.onclick = actb_mouse_up;
                }
            }
            for (i = 0; i < actb_self.actb_keywords.length; i++) {
                if (actb_bool[i]) {
                    if (j >= actb_rangeu && j <= actb_ranged) {
                        r = a.insertRow(-1);
                        r.style.backgroundColor = actb_self.actb_bgColor;
                        r.style.width = actb_self.actb_fwidth;
                        r.id = 'tat_tr' + (j);
                        c = r.insertCell(-1);
                        c.style.color = actb_self.actb_textColor;
                        c.style.fontFamily = actb_self.actb_fFamily;
                        c.style.fontSize = actb_self.actb_fSize;
                        c.innerHTML = actb_parse(actb_self.actb_keywords[i]);
                        c.id = 'tat_td' + (j);
                        c.setAttribute('pos', j);
                        if (actb_self.actb_mouse) {
                            //c.style.cursor = 'pointer';
                            c.addClass('pointer');
                            c.onclick = actb_mouseclick;
                            c.onmouseover = actb_table_highlight;
                        }
                        j++;
                    } else {
                        j++;
                    }
                }
                if (j > actb_ranged) break;
            }
            if (j - 1 < actb_total) {
                r = a.insertRow(-1);
                r.style.backgroundColor = actb_self.actb_bgColor;
                r.style.width = actb_self.actb_fwidth;
                c = r.insertCell(-1);
                c.style.color = actb_self.actb_textColor;
                //c.style.fontFamily = 'arial narrow';
                c.addClass('fontstyle1');
                c.style.fontSize = actb_self.actb_fSize;
                //c.align = 'center';
                c.addClass('a-center');
                replaceHTML(c, '\\/');
                if (actb_self.actb_mouse) {
                    //c.style.cursor = 'pointer';
                    c.addClass('pointer');
                    c.onclick = actb_mouse_down;
                }
            }
        }
        function actb_goup() {
            if (!actb_display) return;
            if (actb_pos == 1) return;
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
            document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;
            actb_pos--;
            if (actb_pos < actb_rangeu) actb_moveup();
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
            if (actb_toid) clearTimeout(actb_toid);
            if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
        }
        function actb_godown() {
            if (!actb_display) return;
            if (actb_pos == actb_total) return;
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
            document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;

            actb_pos++;
            if (actb_pos > actb_ranged) actb_movedown();
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
            if (actb_toid) clearTimeout(actb_toid);
            if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
        }
        function actb_movedown() {
            actb_rangeu++;
            actb_ranged++;
            actb_remake();
        }
        function actb_moveup() {
            actb_rangeu--;
            actb_ranged--;
            actb_remake();
        }

        /* Mouse */
        function actb_mouse_down() {
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
            document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;

            actb_pos++;
            actb_movedown();
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
            actb_curr.focus();
            actb_mouse_on_list = 0;
            if (actb_toid) clearTimeout(actb_toid);
            if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
        }
        function actb_mouse_up(evt) {
            if (!evt) evt = event;
            if (evt.stopPropagation) {
                evt.stopPropagation();
            } else {
                evt.cancelBubble = true;
            }
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
            document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;

            actb_pos--;
            actb_moveup();
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
            actb_curr.focus();
            actb_mouse_on_list = 0;
            if (actb_toid) clearTimeout(actb_toid);
            if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
        }
        function actb_mouseclick(evt) {
            if (!evt) evt = event;
            if (!actb_display) return;
            actb_mouse_on_list = 0;
            actb_pos = this.getAttribute('pos');
            actb_penter();
        }
        function actb_table_focus() {
            actb_mouse_on_list = 1;
        }
        function actb_table_unfocus() {
            actb_mouse_on_list = 0;
            if (actb_toid) clearTimeout(actb_toid);
            if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
        }
        function actb_table_highlight() {
            actb_mouse_on_list = 1;
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_bgColor;
            document.getElementById('tat_tr' + actb_pos).style.width = actb_self.actb_fwidth;

            actb_pos = this.getAttribute('pos');
            while (actb_pos < actb_rangeu) actb_moveup();
            while (actb_pos > actb_ranged) actb_movedown();
            document.getElementById('tat_tr' + actb_pos).style.backgroundColor = actb_self.actb_hColor;
            if (actb_toid) clearTimeout(actb_toid);
            if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
        }
        /* ---- */

        function actb_insertword(a) {
            if (actb_self.actb_delimiter.length > 0) {
                str = '';
                l = 0;
                for (i = 0; i < actb_delimwords.length; i++) {
                    if (actb_cdelimword == i) {
                        prespace = postspace = '';
                        gotbreak = false;
                        for (j = 0; j < actb_delimwords[i].length; ++j) {
                            if (actb_delimwords[i].charAt(j) != ' ') {
                                gotbreak = true;
                                break;
                            }
                            prespace += ' ';
                        }
                        for (j = actb_delimwords[i].length - 1; j >= 0; --j) {
                            if (actb_delimwords[i].charAt(j) != ' ') break;
                            postspace += ' ';
                        }
                        str += prespace;
                        str += a;
                        l = str.length;
                        if (gotbreak) str += postspace;
                    } else {
                        str += actb_delimwords[i];
                    }
                    if (i != actb_delimwords.length - 1) {
                        str += actb_delimchar[i];
                    }
                }
                actb_curr.value = str;
                setCaret(actb_curr, l);
            } else {
                actb_curr.value = a;
            }
            actb_mouse_on_list = 0;
            actb_removedisp();
        }
        function actb_penter() {
            if (!actb_display) return;
            actb_display = false;
            var word = '';
            var c = 0;
            for (var i = 0; i <= actb_self.actb_keywords.length; i++) {
                if (actb_bool[i]) c++;
                if (c == actb_pos) {
                    word = actb_self.actb_keywords[i];
                    break;
                }
            }
            actb_insertword(word);
            l = getCaretStart(actb_curr);
        }
        function actb_removedisp() {
            if (actb_mouse_on_list == 0) {
                actb_display = 0;
                if (document.getElementById('tat_table')) { document.body.removeChild(document.getElementById('tat_table')); }
                if (actb_toid) clearTimeout(actb_toid);
            }
        }
        function actb_keypress(e) {
            if (actb_caretmove) stopEvent(e);
            return !actb_caretmove;
        }
        function actb_checkkey(evt) {


            if (!evt) evt = event;
            a = evt.keyCode;
            caret_pos_start = getCaretStart(actb_curr);
            actb_caretmove = 0;
            switch (a) {
                case 38:
                    actb_goup();
                    actb_caretmove = 1;
                    return false;
                    break;
                case 40:
                    actb_godown();
                    actb_caretmove = 1;
                    return false;
                    break;
                case 13: case 9:
                    if (actb_display) {
                        actb_caretmove = 1;
                        actb_penter();
                        return false;
                    } else {
                        return true;
                    }
                    break;
                default:
                    setTimeout(function() { actb_tocomplete(a) }, 50);
                    break;
            }
        }

        function actb_tocomplete(kc) {

            if (kc == 38 || kc == 40 || kc == 13) return;
            var i;
            if (actb_display) {
                var word = 0;
                var c = 0;
                for (var i = 0; i <= actb_self.actb_keywords.length; i++) {
                    if (actb_bool[i]) c++;
                    if (c == actb_pos) {
                        word = i;
                        break;
                    }
                }
                actb_pre = word;
            } else { actb_pre = -1 };

            if (actb_curr.value == '') {
                actb_mouse_on_list = 0;
                actb_removedisp();
                return;
            }
            if (actb_self.actb_delimiter.length > 0) {
                caret_pos_start = getCaretStart(actb_curr);
                caret_pos_end = getCaretEnd(actb_curr);

                delim_split = '';
                for (i = 0; i < actb_self.actb_delimiter.length; i++) {
                    delim_split += actb_self.actb_delimiter[i];
                }
                delim_split = delim_split.addslashes();
                delim_split_rx = new RegExp("([" + delim_split + "])");
                c = 0;
                actb_delimwords = new Array();
                actb_delimwords[0] = '';

                for (i = 0, j = actb_curr.value.length; i < actb_curr.value.length; i++, j--) {
                    if (actb_curr.value.substr(i, j).search(delim_split_rx) == 0) {
                        ma = actb_curr.value.substr(i, j).match(delim_split_rx);
                        actb_delimchar[c] = ma[1];
                        c++;
                        actb_delimwords[c] = '';
                    } else {
                        actb_delimwords[c] += actb_curr.value.charAt(i);
                    }
                }

                var l = 0;
                actb_cdelimword = -1;
                for (i = 0; i < actb_delimwords.length; i++) {
                    if (caret_pos_end >= l && caret_pos_end <= l + actb_delimwords[i].length) {
                        actb_cdelimword = i;
                    }
                    l += actb_delimwords[i].length + 1;
                }
                var ot = actb_delimwords[actb_cdelimword].trim();
                var t = actb_delimwords[actb_cdelimword].addslashes().trim();
            } else {
                var ot = actb_curr.value;
                var t = actb_curr.value.addslashes();
            }
            if (ot.length == 0) {
                actb_mouse_on_list = 0;
                actb_removedisp();
            }
            if (ot.length < actb_self.actb_startcheck) return this;
            if (actb_self.actb_firstText) {
                var re = new RegExp("^" + t, "i");
            } else {
                var re = new RegExp(t, "i");
            }

            actb_total = 0;
            actb_tomake = false;
            actb_kwcount = 0;
            for (i = 0; i < actb_self.actb_keywords.length; i++) {
                actb_bool[i] = false;
                if (re.test(actb_self.actb_keywords[i])) {
                    actb_total++;
                    actb_bool[i] = true;
                    actb_kwcount++;
                    if (actb_pre == i) actb_tomake = true;
                }
            }

            if (actb_toid) clearTimeout(actb_toid);
            if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function() { actb_mouse_on_list = 0; actb_removedisp(); }, actb_self.actb_timeOut);
            actb_generate();
        }
        return this;
    }
</script>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table class="w-100p searchPanel">
            <tr>
                <td id="tdSearch" runat="server" colspan="1">
                    <asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
                    <br />
                    <asp:Panel ID="pnSearch" runat="server" DefaultButton="btnSearch" meta:resourcekey="pnSearchResource1">
                        &nbsp;
                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtProduct" runat="server" onblur="pSetFocus('pro');" TabIndex="8"
                            meta:resourcekey="txtProductResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                            CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            UseContextKey="True" CompletionListItemCssClass="listitemtwo" EnableCaching="False"
                            FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemSelected="IAmSelected"
                            ServiceMethod="getSearchProductBatchList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                            TargetControlID="txtProduct" DelimiterCharacters="" Enabled="True">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnsearchProid" runat="server" Value="0" />
                        &nbsp;<asp:Button ID="btnSearch" runat="server" CssClass="btn" OnClick="btnSearch_Click"
                            OnClientClick="return SearchText()"
                            TabIndex="10" Text="Search" meta:resourcekey="btnSearchResource1" />
                    </asp:Panel>
                </td>
                <td id="tdGrandTotal" runat="server" class="hide">
                    <span class="paddingR2">
                        <asp:Label ID="Lbgrndtot" runat="server" Text="Grand Total" meta:resourcekey="LbgrndtotResource1"></asp:Label></span>
                    <br />
                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtGrandTotal" runat="server" ReadOnly="True" Text="0.00" CssClass="small"
                        meta:resourcekey="txtGrandTotalResource1"></asp:TextBox>
                    <asp:HiddenField ID="hdnGrandTotal" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnTotalqty" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMsgpro" runat="server" meta:resourcekey="lblMsgproResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblProductName" runat="server" meta:resourcekey="lblProductNameResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divlistProducts" runat="server">
                        <asp:ListBox ID="listProducts" runat="server" CssClass="small" TabIndex="11" meta:resourcekey="listProductsResource1">
                        </asp:ListBox>
                    </div>
                </td>
                <td>
                    <div id="divProductDetails" runat="server" class="hide">
                        <table id="TableProductDetails" runat="server" class="w-100p">
                            <tr class="bold a-center" runat="server">
                                <td runat="server">
                                    <asp:Label ID="Lbbtchno" runat="server" Text="Batch No" meta:resourcekey="LbbtchnoResource1"></asp:Label>&nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lbavalqty" runat="server" Text="Available Qty" meta:resourcekey="lbavalqtyResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblType" runat="server" meta:resourcekey="lblTypeResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbunt" runat="server" Text="Unit" meta:resourcekey="lbuntResource1"></asp:Label>&nbsp;
                                </td>
                                <td class="hide">
                                </td>
                                <td class="hide">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtBatchNo" runat="server" onblur="return BindQuantity();" CssClass="small"
                                        meta:resourcekey="txtBatchNoResource1"></asp:TextBox>
                                </td>
                                <td class ="a-center">
                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtBatchQuantity" runat="server" ReadOnly="True" CssClass="small"
                                        meta:resourcekey="txtBatchQuantityResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtQuantity" runat="server" onblur="pSetFocus('Qty');" onKeyDown="return validatenumber(event);"
                                        TabIndex="12" CssClass="small" meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtUnit" runat="server" CssClass="small" meta:resourcekey="txtUnitResource1"></asp:TextBox>
                                </td>
                                <td id="trAttribute" runat="server" colspan="2" class="hide">
                                    <asp:Button ID="btnAttribute" runat="server" CssClass="btn" OnClick="btnAttribute_Click"
                                        TabIndex="14"
                                        Text="Details" meta:resourcekey="btnAttributeResource1" />
                                </td>
                                <td>
                                    <%--<input id="add" class="btn" name="add" onclick="javascript:if(checkIsEmpty()) return BindProductList();"
                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" type="button"
                                        value="<%=Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_01 %>" />--%>
                                        <a id="add" class="btn" name="add" onclick="javascript:if(checkIsEmpty()) return BindProductList();>
                                        <%=Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_01 %></a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:HiddenField ID="hdnReceivedID" runat="server" />
                                    <asp:HiddenField ID="hdnProductId" runat="server" />
                                    <asp:HiddenField ID="tempTable" runat="server" />
                                    <asp:HiddenField ID="hdnProductList" runat="server" />
                                    <asp:HiddenField ID="hdnProductName" runat="server" />
                                    <asp:HiddenField ID="hdnRowEdit" runat="server" />
                                    <asp:HiddenField ID="hdnBatchList" runat="server" />
                                    <asp:HiddenField ID="hdnSellingPrice" runat="server" />
                                    <asp:HiddenField ID="hdnTax" runat="server" />
                                    <asp:HiddenField ID="hdnCategoryID" runat="server" />
                                    <asp:HiddenField ID="hdnExpiryDate" runat="server" />
                                    <asp:HiddenField ID="hdnAmount" runat="server" />
                                    <asp:HiddenField ID="hdnTotal" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdnTaskProducts" runat="server" />
                                    <asp:HiddenField ID="hdnAttributes" runat="server" />
                                    <asp:HiddenField ID="hdnAttributeDetail" runat="server" />
                                    <asp:HiddenField ID="hdnAttributeDetailTmp" runat="server" />
                                    <asp:HiddenField ID="hdnQuantity" runat="server" />
                                    <asp:HiddenField ID="hdnAction" runat="server" />
                                    <asp:HiddenField ID="hdnUnitPrice" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
        <table class="w-100p">
            <tr>
                <td>
                    <asp:Label ID="lblTable" runat="server" meta:resourcekey="lblTableResource1"></asp:Label>
                </td>
            </tr>
        </table>
        <asp:Panel ID="Panel1" runat="server" CssClass="hide"
            Width="50%" meta:resourcekey="Panel1Resource1">
            <div>
                <table class="w-100p">
                    <tr>
                        <td class="a-center">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblTest" runat="server" meta:resourcekey="lblTestResource1"></asp:Label>
                                    </td>
                                    <td class="a-right">
                                        <asp:Label ID="lbprodqty" runat="server" Text="Product Quantity" meta:resourcekey="lbprodqtyResource1"></asp:Label>:
                                        <asp:Label ID="lblReceivedQty" runat="server" meta:resourcekey="lblReceivedQtyResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <div class="auto">
                                <asp:GridView ID="gvAttributes" runat="server" AutoGenerateColumns="False"
                                    CssClass="gridView w-100p" OnRowDataBound="gvAttributes_RowDataBound"
                                    meta:resourcekey="gvAttributesResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Attribute" meta:resourcekey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnIsMandatory" runat="server" Value='<%# Eval("IsMandatory") %>' />
                                                <asp:Label ID="lblAttributes" runat="server" Text='<%# Eval("AttributeName") %>'
                                                    ></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtAttributeValues" runat="server" Text='<%# Eval("AttributeValue") %>'
                                                    ></asp:TextBox>
                                                <asp:Image ID="imgIsMandatory" runat="server" ImageUrl="../PlatForm/Images/starbutton.png"
                                                    Visible="False" meta:resourcekey="imgIsMandatoryResource1" />
                                                <asp:HiddenField ID="hdnValues" runat="server" Value='<%# Eval("AttributeID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="gridHeader" />
                                </asp:GridView>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <asp:Button ID="btnSave" runat="server" CssClass="btn" OnClick="BtnAdd_Click" OnClientClick="javascript:return CheckAttributes();"
                                Text="Add"
                                meta:resourcekey="btnSaveResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>
                                <asp:GridView ID="gvAttributeValues" runat="server"
                                    CssClass="gridView w-100p" OnRowCommand="gvAttributeValues_RowCommand" OnRowDataBound="gvAttributeValues_RowDataBound"
                                    meta:resourcekey="gvAttributeValuesResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdn" runat="server" Value='<%# Eval("UnitNo") %>' />
                                                <asp:LinkButton ID="lbtnDelete" runat="server" CommandArgument='<%# Eval("UnitNo") %>'
                                                    CommandName="rDelete" Text="Delete" meta:resourcekey="lbtnDeleteResource1"></asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle Width="60px" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="gridHeader" />
                                </asp:GridView>
                            </div>
                            <asp:Table ID="tabAttributes" runat="server" CssClass="w-100p" meta:resourcekey="tabAttributesResource1">
                            </asp:Table>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <asp:Button ID="btnOK" runat="server" CssClass="btn" OnClick="btnOK_Click" Text="OK" meta:resourcekey="btnOKResource1" />
                            &nbsp;&nbsp;
                            <asp:Button ID="btnClose" runat="server" CssClass="cancel-btn" OnClick="btnClose_Click"
                                Text="Close"
                                Width="50px" meta:resourcekey="btnCloseResource1" />
                        </td>
                    </tr>
                </table>
            </div>
        </asp:Panel>
        <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
            PopupControlID="Panel1" TargetControlID="btn" DynamicServicePath="" Enabled="True" />
        <input id="btn" class="hide" type="button" />
        <asp:HiddenField ID="hdnMandatoryFields" runat="server" />
        <asp:HiddenField ID="hdnAttValue" runat="server" Value="N" />
        <asp:HiddenField ID="hdnActionFlag" runat="server" />
        <asp:HiddenField ID="hdnQty" runat="server" Value="0" />
        <asp:HiddenField ID="hdnRcvdQty" runat="server" />
        <asp:HiddenField ID="hdnExAttrip" runat="server" />
        <input id="hdnProBatchNo" runat="server" type="hidden"  value="" />
<asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
            <script language="javascript" type="text/javascript">




            function IAmSelected(source, eventArgs) {

                //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());

                //document.getElementById('<%= lblProductName.ClientID %>').style.display = 'block';
                //document.getElementById('<%= divlistProducts.ClientID %>').style.display = 'block';
                //document.getElementById('<%= lblProductName.ClientID %>').style.fontWeight = 'bold';
                $('#<%= lblProductName.ClientID %>').removeClass().addClass('show');
                $('#<%= divlistProducts.ClientID %>').removeClass().addClass('show');
                $('#<%= lblProductName.ClientID %>').addClass('bold');
                document.getElementById('<%=lblMsgpro.ClientID %>').innerHTML = "Product List (Double click the below list to select the Bacth No.)";
                document.getElementById('<%=lblProductName.ClientID %>').innerHTML = "Product Name: " + eventArgs.get_text();
                document.getElementById('<%= hdnBatchList.ClientID %>').value = '';
                document.getElementById('<%= hdnProductId.ClientID %>').value = '';



                var lis = eventArgs.get_value().split('^');
                for (i = 0; i < lis.length; i++) {
                    if (lis[i] != "") {
                        document.getElementById('<%= hdnBatchList.ClientID %>').value += lis[i].split('|')[1] + '^';
                        document.getElementById('<%= hdnProductId.ClientID %>').value = lis[i].split('|')[0];
                    }
                }

                document.getElementById('<%= hdnProBatchNo.ClientID %>').value = '';
                document.getElementById('<%= txtQuantity.ClientID %>').value = '';
                document.getElementById('<%= txtBatchQuantity.ClientID %>').value = '';
                document.getElementById('<%= txtUnit.ClientID %>').value = '';
                document.getElementById('<%= txtBatchNo.ClientID %>').value = '';
                //document.getElementById('<%= trAttribute.ClientID %>').style.display = 'none';
                $('#<%= trAttribute.ClientID %>').removeClass().addClass('hide');
                var x = document.getElementById('INVStockUsage1_hdnBatchList').value.split('^'); ;
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        y = x[i].split('~');
                        document.getElementById('<%= hdnProBatchNo.ClientID %>').value += y[0] + "|";
                        //document.getElementById('<%= divProductDetails.ClientID %>').style.display = 'block';
                        $('#<%= divProductDetails.ClientID %>').removeClass().addClass('show');
                        if (lis.length == 2) {
                            if (document.getElementById('<%=lblType.ClientID %>').innerHTML == 'Issued Qty') {
                                //document.getElementById('<%= tdGrandTotal.ClientID %>').style.display = 'block';
                                $('#<%= tdGrandTotal.ClientID %>').removeClass().addClass('show');
                            }
                            //document.getElementById('<%= divProductDetails.ClientID %>').style.display = 'block';
                            $('#<%= divProductDetails.ClientID %>').removeClass().addClass('show');
                            document.getElementById('<%= txtBatchNo.ClientID %>').value += y[0];
                            BindQuantity();
                        }

                    }

                }
                AutoCompBacthNo();
            }
            function pSetFocus(obj) {
                if (obj != 'Qty') {
                    var lis = document.getElementById('<%= hdnBatchList.ClientID %>').value.split('^');
                    if (lis.length > 2) {
                        document.getElementById('<%= txtBatchNo.ClientID %>').focus();
                    }
                    if (lis.length == 2) {
                        if (document.getElementById('<%= txtQuantity.ClientID %>').value == '') {
                            document.getElementById('<%= txtQuantity.ClientID %>').focus();
                            return;
                        }
                    }
                }
                else {
                    if (document.getElementById('<%= txtQuantity.ClientID %>').value == '') {
                        document.getElementById('<%= txtQuantity.ClientID %>').focus();
                        return;
                    }



                    //                    document.getElementById('add').focus();
                }
            }
            function CheckAttributes() {
                var controls = document.getElementById('<%= hdnMandatoryFields.ClientID %>').value.split('~');
                for (i = 0; i < controls.length; i++) {
                    if (controls[i] != "") {
                        if (document.getElementById(controls[i]).value == "") {
                            var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_11') != null ? SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_11') : "Enter the Values";
                            var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
                            ValidationWindow(userMsg, errorMsg);
                            document.getElementById(controls[i]).focus();
                            return false;
                        }
                    }
                } return true;
            }
            function SetAttrib() {
                if (document.getElementById('<%= hdnAttValue.ClientID %>').value != "N") {
                    document.getElementById('<%= hdnAttributeDetail.ClientID %>').value = document.getElementById('<%= hdnAttValue.ClientID %>').value;
                    document.getElementById('<%= hdnAttValue.ClientID %>').value = "N";
                }
                if (document.getElementById('<%= hdnTotalqty.ClientID %>') != null) {
                    if (document.getElementById('<%= hdnTotalqty.ClientID %>').value != "") {
                        //document.getElementById('<%= trAttribute.ClientID %>').style.display = "block";
                        $('#<%= trAttribute.ClientID %>').removeClass().addClass('show');
                        //document.getElementById('<%= txtBatchQuantity.ClientID %>').value = document.getElementById('<%= hdnTotalqty.ClientID %>').value;
                        document.getElementById('<%= txtBatchQuantity.ClientID %>').value = ToInternalFormat($('#<%= hdnTotalqty.ClientID %>'));
                        ToTargetFormat($('#<%= txtBatchQuantity.ClientID %>'));
                    }
                }
                document.getElementById('<%= hdnAttributeDetailTmp.ClientID %>').value = document.getElementById('<%= hdnExAttrip.ClientID %>').value;

                document.getElementById('add').value = document.getElementById('<%= hdnActionFlag.ClientID %>').value;

            }

            var productName;
            function GetText(pBrandName) {
                document.getElementById('<%=hdnsearchProid.ClientID %>').value = "0";
                if (pBrandName != "") {
                    var Temp = pBrandName.split('^');
                    if (Temp.length > 1) {
                        document.getElementById('<%=txtProduct.ClientID %>').value = Temp[0];
                        document.getElementById('<%=hdnsearchProid.ClientID %>').value = Temp[1];
                        if (document.getElementById('<%=txtProduct.ClientID %>').value == "undefined") {
                            document.getElementById('<%=txtProduct.ClientID %>').focus();
                            var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_12') != null ? SListForAppMsg.Get('InventoryCommon_Controls_INVStockUsage_ascx_12') : "Entered Product Doesn't Exist";
                            var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
                            ValidationWindow(userMsg, errorMsg);
                            return false;
                        }

                    }

                }
            }
           
  
        </script>

            <script language="javascript" type="text/javascript">

            function AutoCompBacthNo() {
                var customarray = document.getElementById('<%=hdnProBatchNo.ClientID %>').value.split("|");
                actb(document.getElementById('<%=txtBatchNo.ClientID %>'), customarray);
            }   
        </script>

    </ContentTemplate>
</asp:UpdatePanel>
