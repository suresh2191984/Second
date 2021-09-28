<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CustomerStockReturn.aspx.cs"   
    Inherits="InventorySales_CustomerStockReturn" EnableEventValidation="false" meta:resourcekey="PageResource1"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Stock Return</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../PlatForm/Scripts/Common.js" language="javascript" type="text/javascript"></script>
    
    <link href="../PlatForm/StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    
    <script language="javascript" type="text/javascript">
        var userMsg;
        function GetCustomerLocatiion() {
            if (document.getElementById('ddlCustomerLocation').value > 0) {
                LocationList = document.getElementById('hdnLocation').value = document.getElementById('ddlCustomerLocation').value;
            }

        }
        function GetCustomerLocationlist() {
            var selectOption = SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_07") == null ? "Select" : SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_07");
            var CustomerID = document.getElementById('drpCustomerName').value;
            var ddllocation = document.getElementById('ddlCustomerLocation');
            var LocationList = document.getElementById('hdnCustomerLocation').value;

            var locationlist = "";

            if (CustomerID > 0) {
                locationlist = LocationList.split('^');

            }
            else {
                locationlist = "";

            }

            ddllocation.options.length = 0;
            var optn1 = document.createElement("option");
            ddllocation.options.add(optn1);
            optn1.text = selectOption;
            optn1.value = "0";


            if (CustomerID > 0) {
                for (i = 0; i < locationlist.length; i++) {
                    if ((locationlist[i] != "")) {
                        if (locationlist[i].split('~')[0] == Number(CustomerID)) {
                            res1 = locationlist[i].split('~');
                            if (res1 != "") {
                                var optnuserlist = document.createElement("option");
                                ddllocation.options.add(optnuserlist);
                                optnuserlist.text = res1[2];
                                optnuserlist.value = res1[1];
                            }
                        }
                        else { }

                    }


                }
            }
            else {

                ddllocation.options.length = 0;
                optn1 = document.createElement("option");
                ddllocation.options.add(optn1);
                optn1.text = selectOption;
                optn1.value = "0";
            }




        }
        function checkDetails() {

            if (document.getElementById('hdnProductList').value == '') {
                userMsg = SListForApplicationMessages.Get('');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    userMsg = SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_01") == null ? "Check that the items added or quantity is provided properly" : SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_01");
                    ValidationWindow(userMsg, errorMsg);
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
                        userMsg = SListForApplicationMessages.Get('');
                        if (userMsg != null) {
                            alert(userMsg);
                        }
                        else {
                            userMsg = SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_01") == null ? "Check that the items added or quantity is provided properly" : SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_01");
                            ValidationWindow(userMsg, errorMsg);
                        }
                        document.getElementById('txtProduct').focus();
                        return false;

                    }

                }
            }


            //document.getElementById('btnReturnStock').style.display = "none";
            $('#btnReturnStock').removeClass().addClass('hide');
            return true;
        }
        //        function BindQuantity() {
        //            //            if (document.getElementById('ddlBatchNo').value != 0) {
        //            //                var val = document.getElementById('ddlBatchNo').value.split("~");
        //            document.getElementById('txtBatchQuantity').value = val[2];
        //            document.getElementById('hdnTotalqty').value = val[2];
        //            document.getElementById('hdnProductName').value = val[0];
        //            document.getElementById('hdnReceivedID').value = val[1];
        //            document.getElementById('txtUnit').value = val[3];
        //            document.getElementById('txtUnit').readOnly = true;

        //            //}

        //        }
        function checkIsEmpty() {

            //            if (document.getElementById('ddlBatchNo').value == 0) {
            //                alert('Select batch number');
            //                document.getElementById('ddlBatchNo').focus();
            //                return false;
            //            }

            if (document.getElementById('txtQuantity').value == "") {
                userMsg = SListForApplicationMessages.Get('');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    userMsg = SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_02") == null ? "Provide return quantity" : SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_02");
                    ValidationWindow(userMsg, errorMsg);
                }
                document.getElementById('txtQuantity').focus();
                return false;
            }
            if (Number(document.getElementById('txtBatchQuantity').value) < Number(document.getElementById('txtQuantity').value)) {
                userMsg = SListForApplicationMessages.Get('');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    userMsg = SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_01") == null ? "Check that the items added or quantity is provided properly" : SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_01");
                    ValidationWindow(userMsg, errorMsg);
                }
                document.getElementById('txtQuantity').focus();
                return false;
            }


            if (Number(document.getElementById('txtQuantity').value) == 0) {
                userMsg = SListForApplicationMessages.Get('');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {

                    userMsg = SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_01") == null ? "Check that the items added or quantity is provided properly" : SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_01");
                    ValidationWindow(userMsg, errorMsg);
                }
                document.getElementById('txtQuantity').focus();
                return false;
            }


            if (document.getElementById('add').value != 'Update') {
                var x = document.getElementById('hdnProductList').value.split("^");
                var pProductId = document.getElementById('hdnProductId').value;
                var pName = document.getElementById('hdnProductName').value;
                var pInvoiceNo = document.getElementById('txtSellingPrice').value;

                //                var pBatchNo = document.getElementById('ddlBatchNo').options[document.getElementById('ddlBatchNo').selectedIndex].text;
                var pBatchNo = document.getElementById('txtBatchNo').value;
                var y; var i;
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        y = x[i].split('~');
                        if (y[6] == pProductId && y[2] == pBatchNo && y[10] == pInvoiceNo) {

                            userMsg = SListForApplicationMessages.Get('');
                            if (userMsg != null) {
                                alert(userMsg);
                            }
                            else {
                                userMsg = SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_03") == null ? "Product name and batch number combination already exist" : SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_03");
                                ValidationWindow(userMsg, errorMsg);
                            }
                            document.getElementById('txtQuantity').focus();
                            return false;

                        }

                    }
                }
            }



            return true;
        }


        function BindProductList() {


            if (document.getElementById('add').value == 'Update') {
                Deleterows();
            }
            else {

                var pId = document.getElementById('hdnReceivedID').value;
                var pName = document.getElementById('hdnProductName').value;
                var pDcNo = document.getElementById('hdnDC').value;
                var pInvoiceNo = document.getElementById('txtinvoiceno').value;

                var pProductId = document.getElementById('hdnProductId').value;
                var pQTY = document.getElementById('hdnTotalqty').value;
                //                var pBatchNo = document.getElementById('ddlBatchNo').options[document.getElementById('ddlBatchNo').selectedIndex].text;
                var pBatchNo = document.getElementById('txtBatchNo').value;
                var pQuantity = document.getElementById('txtQuantity').value;
                var pUnit = document.getElementById('txtUnit').value;
                var pUnitPrice = document.getElementById('txtUnitPrice').value;
                var pStockReceivedID = document.getElementById('lblStockReceivedID').value;
                var pPrice = document.getElementById('txtPrice').value;
                var pTax = document.getElementById('hdnTax').value;
                var outflowdetid=document.getElementById('hdnOutFlowDetailsID').value ;
                var pExpiryDate =ToInternalDate(document.getElementById('hdnExpiryDate').value);
                var pSellingPrice = document.getElementById('hdnSellingPrice').value;
                var pProductKey = document.getElementById('hdnProductKey').value;
                var pParentProductID = document.getElementById('hdnParentProductID').value;
                var Sellingprice = document.getElementById('txtSellingPrice').value;
                var dcnos=document.getElementById('hdnDCNO').value;

                document.getElementById('hdnProductList').value += pId + "~" + pName + "~" + pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" + pProductId + "~" + pUnitPrice + "~" + pStockReceivedID + "~" + pPrice + "~" + pInvoiceNo + "~" + pTax + "~" + pExpiryDate + "~" + pSellingPrice + "~" + pProductKey + "~" + pParentProductID + "~"+outflowdetid+"~"+dcnos+"^";
                Tblist();
                // document.getElementById('txtSellingPrice').value = '';
                document.getElementById('txtQuantity').value = '';
                document.getElementById('txtUnit').value = '';
                //document.getElementById('hdnProductList').value = '';
                document.getElementById("lblProdDesc").innerHTML = "";
                document.getElementById('txtProduct').value = '';
                document.getElementById('txtProduct').focus();
            }

            document.getElementById('add').value = 'Add';
            //document.getElementById('divProductDetails').style.display = 'none';
            $('#divProductDetails').removeClass().addClass('hide');
            //document.getElementById('lblProductName').innerHTML = '';

        }

        function Tblist() {
            var table = '';
            var tr = '';
            var end = '</table>';
            var y = '';
            document.getElementById('lblTable').innerHTML = '';
            table = "<table class='border2 w-100p'"
                           + "class='dataheaderInvCtrl w-90p'><tr class='bold custpadding1'><td class='dataheader1'>Product Name</td>"
                           + " <td class='dataheader1'>InvoiceNo</td><td class='dataheader1'>SellingPrice</td><td  class='dataheader1'>Batch No</td><td  class='dataheader1'>Return QTY </td>"
                           + "<td class='dataheader1'>Unit</td><td  class='dataheader1'>Action</td>";
            var x = document.getElementById('hdnProductList').value.split("^");

            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    tr += "<tr><td >" + y[1] + "</td><td >"
                        + y[10] + "</td><td >"
                        + y[13] + "</td><td >"
                        + y[2] + "</td><td >" + y[3] + "</td><td >"
                        + y[4] + "</td>"
                        + "<td><input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "' onclick='btnEdit_OnClick(name);invoicefocus();' value = 'Edit' type='button' class='cust1backcolor2 cust1red borderstyle1 txtdecoration1 pointer'  /> &nbsp;&nbsp;" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "' onclick='btnDelete(name);' value = 'Delete' type='button' class='cust1backcolor2 cust1red borderstyle1 txtdecoration1 pointer'  /></td></tr>";
                }
            }
            var temp = table + tr + end;

            document.getElementById('tempTable').value = temp;
            document.getElementById('lblTable').innerHTML = temp;
//            document.getElementById('ddlSupplierList').disabled = false;
            document.getElementById('txtStockReturnDate').disabled = false;
            //            document.getElementById('ddlSupplierList').disabled = true;
            //            document.getElementById('txtStockReturnDate').disabled = true;
        }
        function Deleterows() {


            var RowEdit = document.getElementById('hdnRowEdit').value;
            var x = document.getElementById('hdnProductList').value.split("^");
            if (RowEdit != "") {

                var pId = document.getElementById('hdnReceivedID').value;
                var pProductId = document.getElementById('hdnProductId').value;
                var pName = document.getElementById('hdnProductName').value;
                var pInvoiceNo = document.getElementById('txtinvoiceno').value
                //document.getElementById('txtSellingPrice').value;
                var pQTY = document.getElementById('hdnTotalqty').value;
                //                var pBatchNo = document.getElementById('ddlBatchNo').options[document.getElementById('ddlBatchNo').selectedIndex].text;
                var pBatchNo = document.getElementById('txtBatchNo').value;
                var pQuantity = document.getElementById('txtQuantity').value;
                var pUnit = document.getElementById('txtUnit').value;
                var pUnitPrice = document.getElementById('txtUnitPrice').value;
                var pPrice = document.getElementById('txtPrice').value;
                var pTax = document.getElementById('hdnTax').value;
                var pStockReceivedID = document.getElementById('lblStockReceivedID').value;
                var pSellingPrice = document.getElementById('hdnSellingPrice').value;
                var pExpiryDate = document.getElementById('hdnExpiryDate').value;
                var pProductKey = document.getElementById('hdnProductKey').value;
                var pParentProductID = document.getElementById('hdnParentProductID').value;
                var outflowdetid = document.getElementById('hdnOutFlowDetailsID').value 
                 var dcnos=document.getElementById('hdnDCNO').value;


                document.getElementById('hdnProductList').value = pId + "~" + pName + "~" + pBatchNo + "~" + pQuantity + "~" + pUnit + "~" + pQTY + "~" + pProductId +
                                                                         "~" + pUnitPrice + "~" + pStockReceivedID + "~" + pPrice + "~" + pInvoiceNo + "~" + pTax + "~"
                                                                          + pExpiryDate + "~" + pSellingPrice + "~" + pProductKey + "~" + pParentProductID + "~" + outflowdetid + "~" +dcnos+ "^";
                                                                          

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
                //                document.getElementById('txtUnitPrice').value = '';
                //                document.getElementById('txtPrice').value = '';
                //                document.getElementById('lblStockReceivedID').value = '';
            }
        }
        function btnEdit_OnClick(sEditedData) {

            var y = sEditedData.split('~');

            document.getElementById('hdnReceivedID').value = y[0];
            document.getElementById('hdnProductName').value = y[1];
            //            document.getElementById('ddlBatchNo').options[document.getElementById('ddlBatchNo').selectedIndex].text = y[2];

            // document.getElementById('txtSellingPrice').value = y[2];
            document.getElementById('txtBatchNo').value = y[2];
            document.getElementById('txtBatchNo').readOnly = true;
            //document.getElementById('ddlBatchNo').value = y[1] + '~' + y[0] + '~' + y[5];
            document.getElementById('txtQuantity').value = y[3];
            document.getElementById('txtUnit').value = y[4];
            document.getElementById('hdnTotalqty').value = y[5];
            document.getElementById('txtBatchQuantity').value = y[5];
            document.getElementById('hdnProductId').value = y[6];
            document.getElementById('txtUnitPrice').value = y[7];
            document.getElementById('lblStockReceivedID').value = y[8];
            document.getElementById('txtPrice').value = y[9];
            document.getElementById('hdnTax').value = y[13];
            document.getElementById('hdnSellingPrice').value = y[13];
            document.getElementById('hdnExpiryDate').value = y[12];
            document.getElementById('txtSellingPrice').value = y[13];
            document.getElementById('txtinvoiceno').value = y[10]; 
            document.getElementById('hdnProductKey').value = y[14];
            document.getElementById('hdnParentProductID').value = y[15];

            document.getElementById('hdnOutFlowDetailsID').value = y[16];
            document.getElementById('hdnDCNO').value = y[17];
            document.getElementById('hdnRowEdit').value = sEditedData;
            document.getElementById('add').value = 'Update';
            //document.getElementById('listProducts').value = y[6];
            //document.getElementById('divProductDetails').style.display = 'block';
            $('#divProductDetails').removeClass().addClass('show');
            //document.getElementById('lblProductName').innerHTML = 'Product Name: ' + y[1];

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

            document.getElementById('hdnProductName').value = '';
            document.getElementById('txtSellingPrice').value = '';
            document.getElementById('txtBatchNo').value = '';
            document.getElementById('txtQuantity').value = '';
            document.getElementById('txtUnit').value = '';


        }
        function ChangeHeightCol() {

            //document.getElementById('listProducts').style.height = '100px';

        }
        function ChangeHeightExp() {

            //document.getElementById('listProducts').style.height = '200px';
        }
        function checkSupplier1() {
            if (document.getElementById('drpCustomerName').value == 0) {
                userMsg = SListForApplicationMessages.Get('');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    userMsg = SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_04") == null ? "Select customer" : SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_04");
                    ValidationWindow(userMsg, errorMsg);
                }
                document.getElementById('drpCustomerName').focus();
                return false;
                if (document.getElementById('ddlCustomerLocation').value == 0) {
                    userMsg = SListForApplicationMessages.Get('');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        userMsg = SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_05") == null ? "Select customer Location" : SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_05");
                        ValidationWindow(userMsg, errorMsg);
                    }
                    document.getElementById('ddlCustomerLocation').focus();
                    return false;
                }
                else
                    $find('AutoCompleteProduct').set_contextKey(document.getElementById('drpCustomerName').value + '~' + document.getElementById('ddlCustomerLocation').value);
                //                document.getElementById('AutoCompleteProduct.ContextKey').value = ddlSupplierList.SelectedValue;
            }
            function checkSupplier() {
                if (document.getElementById('drpCustomerName').value == 0) {
                    userMsg = SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_04") == null ? "Select customer" : SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_04");
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('drpCustomerName').focus();
                    return false;
                }
                if (document.getElementById('txtProduct').value.trim() == '') {
                    userMsg = SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_06") == null ? "Provide the product name" : SListForAppMsg.Get("InventorySales_CustomerStockReturn_aspx_06");
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtProduct').value = '';
                    document.getElementById('txtProduct').focus();
                    return false;
                }
                return true;
            }
        }
        function doGetProductTotalQuantity(source, eventArgs) {
            // alert(eventArgs.get_value());
            if (document.getElementById('txtProduct').value.length < 2) {
                document.getElementById("lblProdDesc").innerHTML = "";
            } else {
                var tblString = new Array();
                tblString[0] = "<table border ='1px' Width='100%' class='dataheaderInvCtrl'>";
                tblString[1] = "<tr align='center'><td class='dataheader1' >Product</td><td  class='dataheader1'>Invoice No</td><td  class='dataheader1'>Batch No.</td><td  class='dataheader1'>Exp.Date</td>"
                                + "<td  class='dataheader1'>Selling Price</td><td  class='dataheader1'>Cost Price</td><td  class='dataheader1'>Available Qty</td></tr>";
                tblString[2] = "";
                tblString[3] = "</table>";


                var lis = eventArgs.get_value().split('^');
                var sum = 0;
                var unit = "";
                for (i = 0; i < lis.length; i++) {
                    if (lis[i] != "") {
                        var tblData = lis[i].split('~');



                        var pdate = GetServerDate();
                        pdate = new Date(tblData[6]);

                        //var d = pdate.getDate() + "/" + pdate.getMonth() + "/" + pdate.getFullYear();
                        //                    tblString[2] += "<tr><td>" + tblData[1] + "</td><td>" + tblData[0].split('|')[1] + "</td><td align='left'>" + tblData[8].trim().split(' ')[1] + "/" + tblData[8].trim().split(' ')[2] + "</td><td align='right'>" + tblData[3] + "(" + tblData[4] + ")" + "</td></tr>";
                        //tblString[2] += "<tr><td>" + tblData[1] + "</td><td>" + tblData[18] + "</td><td>" + tblData[3] + "</td><td align='left'>" + d + "</td><td>" + tblData[10] + "</td><td>" + tblData[9] + "</td><td align='right'>" + tblData[15] + "(" + tblData[4] + ")" + "</td></tr>";
                        tblString[2] += "<tr><td>" + tblData[1] + "</td><td>" + tblData[18] + "</td><td>" + tblData[3] + "</td><td align='left'>" + ToInternalDate(pdate) + "</td><td>" + tblData[10] + "</td><td>" + tblData[9] + "</td><td align='right'>" + tblData[15] + "(" + tblData[4] + ")" + "</td></tr>";
                        sum += parseFloat(tblData[15]);
                        unit = "(" + tblData[4] + ")";
                    }
                }
                tblString[2] += "<tr><td colspan='6' align='right'>Total</td><td align='right'>" + sum.toFixed(2) + unit + "</td></tr>";
                document.getElementById("lblProdDesc").innerHTML = tblString[0] + tblString[1] + tblString[2] + tblString[3];
            }
        }

        function doClearTable() {
            if (document.getElementById('txtProduct').value.length < 2) {
                document.getElementById("lblProdDesc").innerHTML = "";
            }
        }



        function invoicefocus() {
            document.getElementById('txtSellingPrice').focus();
        }
        function pSetFocus(obj) {
            var lis = document.getElementById('hdnBatchList').value.split('^');
            //            if (lis.length > 2) {
            //  document.getElementById('txtBatchNo').focus();
            // document.getElementById('txtSellingPrice').focus();

            // txtSellingPrice

            //}

            //document.getElementById('chkisCreditTransaction').checked = false;
        }
        function IAmSelected(source, eventArgs) {

            if (document.getElementById('txtProduct').value.trim() == '') {
                document.getElementById('lblProdDesc').innerHTML = '';
            }
            document.getElementById('hdnBatchList').value = '';
            document.getElementById('hdnProductId').value = '';
            var lis = eventArgs.get_value().split('^');
            if (source.get_id() == 'AutoCompleteProduct') {
                $find('AutoCompleteBatchNo').set_contextKey(eventArgs.get_value());
                $find('AutoCompleteInvoiceno').set_contextKey(eventArgs.get_value());
            }
            var pMainX = document.getElementById('hdnProductList').value.split("^");
            var isTrue = true;
            for (i = 0; i < lis.length; i++) {
                if (lis[i] != "") {
                    isTrue = true;
                    for (xY = 0; xY < pMainX.length; xY++) {
                        if (pMainX[xY] != "") {
                            xTempP = pMainX[xY].split('~');
                            //alert(lis[i].split('|')[1].split('~')[0]);
                            if (lis[i].split('|')[1].split('~')[0] == xTempP[2] && lis[i].split('~')[2] == xTempP[0] && lis[i].split('~')[14] == xTempP[8]) {

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
            document.getElementById('txtUnit').value = '';
            document.getElementById('txtBatchNo').value = '';
            document.getElementById('txtPrice').value = '';
            document.getElementById('hdnProductKey').value = '';
            document.getElementById('hdnParentProductID').value = '';
            document.getElementById('txtinvoiceno').value = '';
            document.getElementById('hdnSellingPrice').value = '';
            document.getElementById('hdnOutFlowDetailsID').value = '';
            document.getElementById('hdnDCNO').value = '';

            var x = document.getElementById('hdnBatchList').value.split('^');
            var isAddItem = 0;
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    if (CheckTaskItems(pid + "~" + y[0] + "~" + y[2] + "~" + y[14] + "~" + y[17])) {
                        document.getElementById('hdnProBatchNo').value += y[0] + "|";
//                        document.getElementById('divProductDetails').style.display = 'block';
                        $('#divProductDetails').removeClass().addClass('show');
                        if (lis.length > 1) {
                            if (isAddItem == 0) {
                                document.getElementById('txtBatchNo').value += y[0];
                                document.getElementById('txtinvoiceno').value += y[18];
                                BindQuantity();
                                isAddItem = 1;
                            }
                        }
                    }

                }

            }
            if (lis.length != pMainX.length) {
                AutoCompBacthNo();
                invoicefocus();
            }
            else {
                document.getElementById("lblProdDesc").innerHTML = "";
                document.getElementById('txtProduct').value = '';
                document.getElementById('txtProduct').focus();
            }

        }
        function AutoCompBacthNo() {
            var customarray = document.getElementById('hdnProBatchNo').value.split("|");
            //actb(document.getElementById('txtBatchNo'), customarray);
        }
        function Calctotal() {
            if (document.getElementById('txtQuantity').value == "")
                document.getElementById('txtPrice').value = "0.00";
            else
                document.getElementById('txtPrice').value = parseFloat(parseFloat(document.getElementById('txtSellingPrice').value) * parseFloat(document.getElementById('txtQuantity').value)).toFixed(2);
        }

        function Calctotal1() {
            if (document.getElementById('txtQuantity').value == "")
                document.getElementById('txtPrice').value = "0.00";
            else
                document.getElementById('txtPrice').value = parseFloat(parseFloat(document.getElementById('txtSellingPrice').value) * parseFloat(document.getElementById('txtQuantity').value)).toFixed(2);
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
        function BindQuantity() {
            var blnExists = false;
            if (document.getElementById('txtBatchNo').value.trim() != "") {
                var BatchNoList = document.getElementById('hdnBatchList').value.split("^");
                for (i = 0; i < BatchNoList.length; i++) {
                    if (BatchNoList[i] != "") {
                        var val = BatchNoList[i].split("~");
                        if (val[0].toUpperCase() == (document.getElementById('txtBatchNo').value.trim()).toUpperCase()) {
                            document.getElementById('hdnProductName').value = val[1];
                            document.getElementById('hdnReceivedID').value = val[2];
                            document.getElementById('txtBatchQuantity').value = val[15];
                            document.getElementById('hdnTotalqty').value = val[15];
                            document.getElementById('txtUnit').value = val[4];
                            document.getElementById('txtUnitPrice').value = val[9];
                            document.getElementById('lblStockReceivedID').value = val[14];
                            document.getElementById('txtSellingPrice').value = val[10];
                            document.getElementById('hdnTax').value = val[6];
                            document.getElementById('hdnSellingPrice').value = val[10];
                            document.getElementById('hdnOutFlowDetailsID').value = val[19];
                            document.getElementById('hdnDCNO').value = val[17];
                            //document.getElementById('hdnTax').value = val[6];
                            document.getElementById('hdnExpiryDate').value = val[6];
                            document.getElementById('hdnProductKey').value = val[16];
                            document.getElementById('hdnParentProductID').value = val[20];
                            document.getElementById('txtinvoiceno').value = val[18];
                            document.getElementById('txtQuantity').readOnly = false;
                            document.getElementById('txtBatchQuantity').focus();
                            blnExists = true; break;
                        }
                    }
                }
            }
            if (blnExists == false) {
                document.getElementById('txtUnit').value = '';
                document.getElementById('txtBatchQuantity').value = '';
                document.getElementById('txtBatchNo').value = '';
                return false;
            }
        }
    </script>

</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server"  >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
  <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        
                        <table class="w-100p"  class="defaultfontcolor" border="0" cellpadding="2" cellspacing="2">
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="DivSupplier" runat="server">
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                            <ContentTemplate>
                                                <table class="w-100p" class="dataheader2 defaultfontcolor" border="0" cellpadding="2"
                                                    cellspacing="0">
                                                    <tr>
                                                        <td class="a-left">
                                            
                                            <asp:Label ID="lblStockReturnDate" runat="server" Text="Stock Return Date" meta:resourcekey="lblStockReturnDateResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtStockReturnDate" runat="server" TabIndex="1" CssClass="datePicker"  meta:resourcekey="txtStockReturnDateResource1"></asp:TextBox>
                                                            
                                                            &nbsp;<img src="../PlatForm/images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                        <td>
                                           
                                            <asp:Label ID="lblCustomerName" runat="server" Text="Customer Name" meta:resourcekey="lblCustomerNameResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="drpCustomerName" runat="server" onchange="GetCustomerLocationlist();"
                                                                Width="150px" CssClass="small" meta:resourcekey="drpCustomerNameResource1">
                                                            </asp:DropDownList>
                                                            <img src="../PlatForm/images/starbutton.png" alt="" align="middle" />
                                                            <asp:HiddenField ID="hdnIsSupplier" runat="server" Value="Y" />
                                                            &nbsp;<img src="../PlatForm/images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                            
                                            <asp:Label ID="lblReasonForStockOutFlow" runat="server" Text="Reason For StockOutFlow" meta:resourcekey="lblReasonForStockOutFlowResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlStockReturnType" TabIndex="2" runat="server" CssClass="small" meta:resourcekey="ddlStockReturnTypeResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label runat="server" ID="Label5" Text="Deliver Location"  meta:resourcekey="Label5Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlCustomerLocation" onchange="GetCustomerLocatiion();" runat="server" CssClass="small"
                                                                Width="150px" meta:resourcekey="ddlCustomerLocationResource1">
                                                            </asp:DropDownList>
                                                            <img src="../PlatForm/images/starbutton.png" alt="" class="a-middle" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-left">
                                            
                                             <asp:Label ID="lblComments" runat="server" Text="Comments" meta:resourcekey="lblCommentsResource1" />
                                                        </td>
                                                        <td colspan="3">
                                                            <asp:TextBox onKeyPress="return ValidateMultiLangChar(this);" ID="txtComments" TextMode="MultiLine" TabIndex="4" runat="server" Columns="25"
                                                                Rows="2" meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4" class="a-center h-5">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <table class="dataheader2 defaultfontcolor custcellspacing2 w-100p custcellpadding3 border1" >
                                                    <tr>
                                                        <td id="tdSearch" class="a-left a-center" runat="server" colspan="1">
                                                            &nbsp;<asp:Label ID="lblmsg" runat="server"></asp:Label>
                                                            <asp:Panel ID="pnSearch" runat="server" meta:resourcekey="pnSearchResource1">
                                                                &nbsp;
                                                                <asp:TextBox onKeyPress="return ValidateMultiLangChar(this);" ID="txtProduct" TabIndex="5" Width="225px" onkeyup="doClearTable();"
                                                                    onfocus="checkSupplier1();" runat="server" onblur="pSetFocus('pro');" CssClass="Txtboxmedium"  meta:resourcekey="txtProductResource1"></asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                                    CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                    CompletionListItemCssClass="listitemtwo" EnableCaching="false" FirstRowSelected="true"
                                                                    MinimumPrefixLength="1" OnClientItemSelected="IAmSelected" ServiceMethod="getSalesStockDetails"
                                                                    OnClientItemOver="doGetProductTotalQuantity" ServicePath="~/InventorySales/WebService/InventorySalesService.asmx"
                                                                    TargetControlID="txtProduct">
                                                                </ajc:AutoCompleteExtender>
                                                                &nbsp;<asp:Button Visible="false" ID="btnSearch" TabIndex="6" runat="server" CssClass="btn"
                                                                    OnClick="btnSearch_Click" OnClientClick="return SearchText()" onmouseout="this.className='btn'"
                                                                    onmouseover="this.className='btn btnhov'" Text="Search" meta:resourcekey="btnSearchResource1"/>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-left">
                                                            <asp:Label ID="lblMsgpro" runat="server" meta:resourcekey="lblMsgproResource1"></asp:Label>
                                                            &nbsp;&nbsp;<asp:Label ID="lblProductName" Visible="false" runat="server" meta:resourcekey="lblProductNameResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="hidden" id="hdnReceivedID" runat="server" />
                                                            <input type="hidden" id="hdnProductId" runat="server" />
                                                            <input type="hidden" id="tempTable" runat="server" />
                                                            <input type="hidden" id="hdnProductList" runat="server" />
                                                            <input type="hidden" id="hdnProductName" runat="server" />
                                                            <input type="hidden" id="hdnTotalqty" runat="server" />
                                                            <input type="hidden" id="hdnRowEdit" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-right">
                                                            <asp:Label ID="lblProdDesc" runat="server" Text="" meta:resourcekey="lblProdDescResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <%-- <td>
                                                            <asp:ListBox ID="listProducts" Width="229px" runat="server" Height="150px"></asp:ListBox>
                                                        </td>--%>
                                                        <td valign="top" class="a-left" >
                                                            <div id="divProductDetails" runat="server" class="hide" >
                                                                <table cellpadding="2" cellspacing="0" border="0" runat="server" id="TableProductDetails"
                                                                    class="w-95p" >
                                                    <tr class="bold a-center" runat="server">
                                                        <td class="w-80" runat="server">
                                                             
                                                            <asp:Label ID="lblInvoiceNo" runat="server" Text="Invoice No" meta:resourcekey="lblInvoiceNoResource1" />
                                                            &nbsp;
                                                        </td>
                                                        <td class="w-80" runat="server">
                                                             
                                                            <asp:Label ID="lblBatchNo" runat="server" Text="Batch No" meta:resourcekey="lblBatchNoResource1" />
                                                            &nbsp;
                                                        </td>
                                                        <td class="w-100" runat="server">
                                                        <asp:Label ID="lblAvailableQty" runat="server" Text="Available Qty" meta:resourcekey="lblAvailableQtyResource1" />
                                                            
                                                        </td>
                                                        <td class="w-70" runat="server">
                                                            
                                                            <asp:Label ID="lblReturnQty" runat="server" Text="Return Qty" meta:resourcekey="lblReturnQtyResource1" />
                                                        </td>
                                                        <td class="w-70" runat="server">
                                                           
                                                            <asp:Label ID="lblUnit" runat="server" Text="Unit" meta:resourcekey="lblUnitResource1" />
                                                            &nbsp;
                                                        </td>
                                                        <td class="w-70" runat="server">
                                                            
                                                            <asp:Label ID="lblUnitPrice" runat="server" Text="Unit Price" meta:resourcekey="lblUnitPriceResource1" />
                                                            &nbsp;
                                                        </td>
                                                        <td class="w-70" runat="server">
                                                             
                                                            <asp:Label ID="lblSellingPrice" runat="server" Text="Selling Price" meta:resourcekey="lblSellingPriceResource1" />
                                                            &nbsp;
                                                        </td>
                                                        <td class="w-70" runat="server">
                                                            
                                                            <asp:Label ID="lblTotalAmount" runat="server" Text="Total Amount" meta:resourcekey="lblTotalAmountResource1" />
                                                            &nbsp;
                                                        </td>
                                                        <td class="w-70 hide" runat="server">
                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                        <asp:TextBox onKeyPress="return ValidateMultiLangCharacter(this) && return ValidateOnlyNumeric(this)" ID="txtinvoiceno" runat="server" />
                                                                         <ajc:AutoCompleteExtender ID="AutoCompleteInvoiceno" runat="server" CompletionInterval="1"
                                                                                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                CompletionListItemCssClass="listitemtwo" EnableCaching="false" FirstRowSelected="true"
                                                                                MinimumPrefixLength="1" OnClientItemSelected="IAmSelected" ServiceMethod="getInvoiceOfProducts"
                                                                                ServicePath="~/InventorySales/WebService/InventorySalesService.asmx" TargetControlID="txtinvoiceno"/>
                                                                        </td>
                                                                        <td class="w-80">
                                                                            <%--<asp:DropDownList onchange="javascript:BindQuantity();" ID="ddlBatchNo" runat="server">
                                                                            </asp:DropDownList>--%>
                                                                            <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" Width="70px" ID="txtBatchNo" TabIndex="8" ReadOnly="false" runat="server"
                                                                                onblur="pSetFocus('pro');"></asp:TextBox>
                                                                            <ajc:AutoCompleteExtender ID="AutoCompleteBatchNo" runat="server" CompletionInterval="1"
                                                                                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                CompletionListItemCssClass="listitemtwo" EnableCaching="false" FirstRowSelected="true"
                                                                                MinimumPrefixLength="1" OnClientItemSelected="IAmSelected" ServiceMethod="getBatchOfProducts"
                                                                                ServicePath="~/InventoryWebService.asmx" TargetControlID="txtBatchNo">
                                                                            </ajc:AutoCompleteExtender>
                                                                        </td>
                                                                        <td class="w-100 a-center">
                                                                            <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" CssClass="w-70p" ID="txtBatchQuantity" TabIndex="9" ReadOnly="true" runat="server"></asp:TextBox>
                                                                        </td>
                                                                        <td class="w-70">
                                                                            <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtQuantity" TabIndex="10" 
                                                                                OnBlur="Calctotal();" runat="server" Width="70px"></asp:TextBox>
                                                                        </td>
                                                                        <td class="w-70">
                                                                            <asp:TextBox onKeyPress="return ValidateMultiLangChar(this);" ID="txtUnit" TabIndex="11" runat="server" ReadOnly="true" Width="70px"></asp:TextBox>
                                                                        </td>
                                                                        <td class="w-70">
                                                                            <%-- onKeyDown="return validatenumber(event);"--%>
                                                                            <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtUnitPrice" TabIndex="12"  ReadOnly="true"
                                                                                  runat="server" Width="70px"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtSellingPrice" Width="70px" TabIndex="7" ReadOnly="true" runat="server"
                                                                               OnBlur="Calctotal1();"></asp:TextBox>
                                                                        </td>
                                                                        <td class="w-70">
                                                                            <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtPrice" runat="server" ReadOnly="true" Width="70px" Text="0.00"></asp:TextBox>
                                                                        </td>
                                                                        <td class="w-70">
                                                                            <asp:Label ID="lblStockReceivedID" runat="server" class="hide w-70"></asp:Label>
                                                                        </td>
                                                                        <td class="w-70">
                                                                            <input id="add" type="button" tabindex="13" onmouseover="this.className='btn btnhov'"
                                                                                class="btn w-60" onmouseout="this.className='btn'" onclick="javascript:if(checkIsEmpty()) return BindProductList();"
                                                                                name="add" value="Add" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <br />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table class="w-100p border1 custcellpadding3 custcellspacing2" >
                                                    <tr>
                                                        <td >
                                            <asp:Label ID="lblTable" runat="server" meta:resourcekey="lblTableResource1"></asp:Label>
                                                        </td>
                                                       
                                                    </tr>
                                                    <tr>
                                                        <td class="a-center" >
                                                            <br />
                                                            <asp:Button ID="btnReturnStock" Text="Submit" TabIndex="14" runat="server" onmouseover="this.className='btn btnhov'"
                                                                CssClass="btn" OnClientClick="javascript:if(!checkDetails()) return false;" onmouseout="this.className='btn'"
                                                                OnClick="btnReturnStock_Click" meta:resourcekey="btnReturnStockResource1"/>
                                                            &nbsp;
                                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" TabIndex="15" CssClass="btn"
                                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btncancelResource1"/>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>  
             
        <input type="hidden" id="hdnFID" runat="server" />
        <input id="hdnBatchList" runat="server" type="hidden" value="" />
        <input id="hdnProBatchNo" runat="server" type="hidden" value="" />
        <input id="hdnStockReceivedID" runat="server" type="hidden" value="" />
        <input id="hdnUnitPrice" runat="server" type="hidden" value="" />
        <input id="hdnAddedTaskList" runat="server" type="hidden" value="" />
        <input id="hdnList" runat="server" type="hidden" value="" />
        <input id="hdnDC" runat="server" type="hidden" value="" />
        <input id="hdnDCNO" runat="server" type="hidden" value="" />
        <input type="hidden" id="hdnTax" runat="server" />
        <input type="Hidden" id="hdnOutFlowDetailsID" runat="server" />
        <input type="hidden" id="hdnSellingPrice" runat="server" />
        <input type="hidden" id="hdnExpiryDate" runat="server" />
        <input type="hidden" id="hdnProductKey" runat="server" />
        <input type="hidden" id="hdnParentProductID" runat="server" />
        <input type="hidden" id="hdnShowCostPrice" runat="server" value="Y" />
        <input type="hidden" id="hdnLocation" runat="server" value="0" />
        <asp:HiddenField ID="hdnCustomerLocation" runat="server" />
     <Attune:Attunefooter ID="Attunefooter" runat="server" />
 
    </form>
</body>
</html>
