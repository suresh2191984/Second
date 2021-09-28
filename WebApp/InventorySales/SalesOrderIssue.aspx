<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SalesOrderIssue.aspx.cs"
    Inherits="InventorySales_SalesOrderIssue" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sales</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../PlatForm/StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />
    <link href="../PlatForm/StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../PlatForm/Scripts/bid.js" type="text/javascript"></script>

    <script src="../PlatForm/Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
//        function KeyPress1(e) {
//            var ddlaction = document.getElementById('ddlSupplier');
//            if (ddlaction.options[ddlaction.selectedIndex].text == '--Select--') {
//                alert('Select a Supplier');
//                return false;
//            }
//               
//            var Type = 'DC';
//            var s1val = ddlaction.options[ddlaction.selectedIndex].value + '~' + Type;
//            $find('AutoCompleteDcNumber').set_contextKey(s1val);
//        }
//        function KeyPress2(e) {
//            var ddlaction = document.getElementById('ddlSupplier');
//            if (ddlaction.options[ddlaction.selectedIndex].text == '--Select--') {
//                alert('Select a Supplier');
//                return false;
//            }

//            var Type = 'INVOICE';
//            var s1val = ddlaction.options[ddlaction.selectedIndex].value + '~' + Type;
//            $find('AutoCompleteExtender1').set_contextKey(s1val);
//        }
    </script>

    <script type="text/javascript" language="javascript">
        var exp = new RegExp("'");

        function sortObj(arr) {

            var sortedKeys = new Array();
            var sortedObj = {};
            for (var i in arr) {
                sortedKeys.push(i);
            }
            sortedKeys.sort();
            for (var i in sortedKeys) {
                      sortedObj[sortedKeys[i]] = arr[sortedKeys[i]];
            }
            return sortedObj;
        }




        function Tblist() {
            var MFDate = GetServerDate();
            var EXDate = GetServerDate();
            while (count = document.getElementById('TableCollectedItems').rows.length) {

                for (var j = 0; j < document.getElementById('TableCollectedItems').rows.length; j++) {
                    document.getElementById('TableCollectedItems').deleteRow(j);

                }
            }
            var Headrow = document.getElementById('TableCollectedItems').insertRow(0);
            Headrow.id = "HeadID";
            Headrow.addClass('bold');
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
            var cell19 = Headrow.insertCell(18);

            cell1.innerHTML = "S.No";
            cell2.innerHTML = "Product Name";
            cell3.innerHTML = "Batch No";
            cell4.innerHTML = "Date";
            cell5.innerHTML = "MFG Code";
            cell6.innerHTML = "Quantity";
            cell6.innerHTML = "Selling Unit";
            cell7.innerHTML = "Rate";
            cell8.innerHTML = "Value";
            cell9.innerHTML = "Discount(%)";
            cell10.innerHTML = "Discount Value";
            cell11.innerHTML = "Excise Duty";
            cell12.innerHTML = "VAT Rate(%)";
            cell13.innerHTML = "VAT Value";
            cell14.innerHTML = "CST Rate(%)";
            cell15.innerHTML = "CST Value";
            cell16.innerHTML = "M.R.P";
            cell17.innerHTML = "M.R.P Value";
            cell18.innerHTML = "Total Cost";
            cell19.innerHTML = "Action";


            var ArrSize = 0;

            var x = document.getElementById('hdnProductList').value.split("^");
            var n = x.length;
            var temp = "";
            for (i = 1; i < n; i++) {
                for (j = 0; j < n - i; j++) {
                    if (x[i] != "") {
                        if (Number(x[j].split("~")[0]) > Number(x[j + 1].split("~")[0])) {
                            temp = x[j];
                            x[j] = x[j + 1];
                            x[j + 1] = temp;
                        }
                    }
                    else {
                        if ((x[j].split("~")[0]) > (x[j + 1].split("~")[0])) {
                            temp = x[j];
                            x[j] = x[j + 1];
                            x[j + 1] = temp;
                        }
                    }
                }
            }

            aRRlist = x;


            document.getElementById('txtAddCST').value = '0.00';
            document.getElementById('txtGrandTotal').value = '0.00';
            document.getElementById('txtNetTotal').value = '0.00';
            document.getElementById('txtGrandwithRoundof').value = '0.00';
            document.getElementById('txtRoundOffValue').value = '0.00';
            document.getElementById('txtTotalSales').value = '0.00';
            document.getElementById('txtTotalDiscountAmt').value = '0.00';
            document.getElementById('txtTotalTaxAmt').value = '0.00';
            document.getElementById('hdnTotalCost').value = '0';
          
           
            for (i = aRRlist.length - 1; 0 < i; i--) {
                    if (aRRlist[i] != "") {
                        y = aRRlist[i].split('~');
                        var row = document.getElementById('TableCollectedItems').insertRow(1);
                        row.addClass('h-13');
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
                        var cell19 = row.insertCell(18);
                        if (y[4] == '**') {
                            MFDate = '**';
                        }
                        else {
                            MFDate =ToInternalDate(new Date(y[4]));
                        }

                        if (y[5] == '**') {
                            EXDate = '**';
                                                }
                        else {
                            EXDate =ToInternalDate(new Date(y[5]));
                        }
                     
                        
                        cell1.innerHTML = i;
                        cell2.innerHTML = y[2];
                        cell3.innerHTML = y[3];
                        cell4.innerHTML = "<table><tr><td>MFT :" + MFDate + "</td></tr><tr><td>EXP :" + EXDate + "</td></tr></table>";
                        cell5.innerHTML = y[6];
                        cell6.innerHTML = y[9]+"("+y[10]+")";
                        cell7.innerHTML = y[11];
                        cell8.innerHTML = y[12];
                        cell9.innerHTML = y[13];
                        cell10.innerHTML = y[14];
                        cell11.innerHTML = y[15];
                        cell12.innerHTML = y[16];
                        cell13.innerHTML = y[17];
                        cell14.innerHTML = y[18];
                        cell15.innerHTML = y[19];
                        cell16.innerHTML = y[20];
                        cell17.innerHTML = y[21];
                        cell18.innerHTML = y[22];
                        cell19.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "~" + y[23] + "~" + y[24] + "~" + y[25] + "~" + y[26] + "~" + y[27] + "~" + y[28] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' class='pointer cust1backcolor2 cust1red borderstyle1 txtdecoration1' /> &nbsp;&nbsp;" +
                        "<br><input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "~" + y[23] + "~" + y[24] + "~" + y[25] + "~" + y[26] + "~" + y[27] + "~" + y[28] + "' onclick='btnDelete(name);' value = 'Delete' type='button' class='pointer cust1backcolor2 cust1red borderstyle1 txtdecoration1'  />";


                        document.getElementById('txtTotalSales').value = parseFloat(parseFloat(y[12]) + parseFloat(document.getElementById('txtTotalSales').value)).toFixed(2);
                      
                        var discount = parseFloat(parseFloat(parseFloat(y[13]) / 100) * (parseFloat(y[9]) * parseFloat(y[11]))).toFixed(2);
                        var CstAmt = parseFloat(parseFloat(parseFloat(parseFloat(parseFloat(y[9]) * parseFloat(y[11])) - parseFloat(discount)) / 100) * parseFloat(y[18])).toFixed(2);
                       
                        document.getElementById('txtTotalDiscountAmt').value = parseFloat(parseFloat(document.getElementById('txtTotalDiscountAmt').value) + parseFloat(y[14])).toFixed(2);

                        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(document.getElementById('txtTotalTaxAmt').value) + parseFloat(y[17])).toFixed(2);

                        document.getElementById('txtAddCST').value = parseFloat(parseFloat(document.getElementById('txtAddCST').value) + parseFloat(y[19])).toFixed(2);
                        document.getElementById('hdnTotalCost').value = parseFloat(parseFloat(y[12]) + parseFloat(document.getElementById('hdnTotalCost').value) + parseFloat(document.getElementById('txtTotalTaxAmt').value)+ parseFloat(document.getElementById('txtAddCST').value) - parseFloat(document.getElementById('txtTotalDiscountAmt').value)).toFixed(2);
                        document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(y[22]) + parseFloat(document.getElementById('txtGrandTotal').value)).toFixed(2);
                        document.getElementById('txtNetTotal').value = parseFloat(document.getElementById('txtGrandTotal').value).toFixed(2);
                        document.getElementById('txtGrandwithRoundof').value = document.getElementById('txtNetTotal').value;
                                        
                        



//==============================================================
//                        document.getElementById('txtTotalSales').value = parseFloat(parseFloat(y[12]) + parseFloat(document.getElementById('txtTotalSales').value)).toFixed(2);
//                        var discount = parseFloat(parseFloat(parseFloat(y[13]) / 100) * (parseFloat(y[9]) * parseFloat(y[11]))).toFixed(2);
//                        document.getElementById('txtTotalDiscountAmt').value = parseFloat(parseFloat(document.getElementById('txtTotalDiscountAmt').value) + parseFloat(parseFloat(parseFloat(y[13]) / 100) * (parseFloat(y[9]) * parseFloat(y[11])))).toFixed(2);

//                        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(document.getElementById('txtTotalTaxAmt').value) + parseFloat(parseFloat(parseFloat(parseFloat(y[16]) / 100) * (parseFloat(discount))))).toFixed(2);
//                        var tax = parseFloat(parseFloat(document.getElementById('txtTotalTaxAmt').value) + parseFloat(parseFloat(parseFloat(parseFloat(y[16]) / 100) * (parseFloat(discount))))).toFixed(2);

////                        document.getElementById('txtTotalTaxAmt').value
//                        document.getElementById('hdnTotalCost').value = parseFloat(parseFloat(y[12]) + parseFloat(document.getElementById('hdnTotalCost').value) + parseFloat(document.getElementById('txtTotalTaxAmt').value) - parseFloat(document.getElementById('txtTotalDiscountAmt').value)).toFixed(2);
//                        document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(y[12]) + parseFloat(document.getElementById('txtGrandTotal').value) + parseFloat(document.getElementById('txtTotalTaxAmt').value) - parseFloat(document.getElementById('txtTotalDiscountAmt').value)).toFixed(2);
//                        document.getElementById('txtNetTotal').value = parseFloat(document.getElementById('txtGrandTotal').value).toFixed(2);
//                        document.getElementById('txtGrandwithRoundof').value = document.getElementById('txtNetTotal').value;
//                      //  var SubDiscount = parseFloat(parseFloat(parseFloat(y[14]) / 100) * parseFloat(parseFloat(y[9]) * parseFloat(y[11]))).toFixed(2);
//                        
//                       
//                      var s=  parseFloat(parseFloat(parseFloat(y[9]) * parseFloat(y[11])) - parseFloat(parseFloat(parseFloat(y[16]) / 100) * parseFloat(parseFloat(y[9]) * parseFloat(y[11])))).toFixed(2);
                        
                    }
                }

                if (aRRlist.length == 0) {
                    //document.getElementById('submitTab').style.display = "none";
                    $('#submitTab').removeClass().addClass('hide');
                }
                else {
                    //document.getElementById('submitTab').style.display = "block";
                    $('#submitTab').removeClass().addClass('show');
                }
                //document.getElementById('tblPODetail').style.display = "block";
                $('#tblPODetail').removeClass().addClass('show');
                //document.getElementById('TableCollectedItems').style.display = "block";
                $('#TableCollectedItems').removeClass().addClass('show');
              //  CSTCalculation();
            
        }


        function CSTCalculation() {
            document.getElementById('txtCST').value = 0.00;
            var x = document.getElementById('hdnProductList').value.split("^");
            var TotalSales = 0;
            var TotalExcise = 0;
            var CstCalSales = 0

            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    TotalSales = TotalSales + (y[12] * y[6]);
                    if (y[25] > 0) {
                        CstCalSales = CstCalSales + (y[12] * y[6]);
                        TotalExcise = TotalExcise + (((y[12] * y[6]) * y[25]) / 100)
                    }
                }
            }
            document.getElementById('txtTotalSales').value = parseFloat(TotalSales).toFixed(2);
            document.getElementById('txtTotalExcise').value = parseFloat(TotalExcise).toFixed(2);

            document.getElementById('txtCessOnExcise').value = parseFloat((TotalExcise * 2) / 100).toFixed(2);
            document.getElementById('txtHighterEdCess').value = parseFloat((TotalExcise * 1) / 100).toFixed(2);
            if (TotalExcise > 0 && TotalSales > 0) {
                document.getElementById('txtCST').value = parseFloat(((CstCalSales + TotalExcise + ((TotalExcise * 2) / 100) + ((TotalExcise * 1) / 100)) * 5) / 100).toFixed(2);
            }


        } 
        
        
        


//        document.onkeydown = checkShortcut;
//        function checkShortcut() {
//            if (typeof window.event != 'undefined')
//                document.onkeydown = function() {
//                    if (event.srcElement.tagName.toUpperCase() != 'INPUT')
//                        return (event.keyCode != 8);
//                }
//            else
//                document.onkeypress = function(e) {
//                    if (e.target.nodeName.toUpperCase() != 'INPUT')
//                        return (e.keyCode != 8);
//                }
//            }
            

    
    </script>

</head>
<body>
    <form id="prFrm" defaultbutton="btnFinish" runat="server">

    <script language="javascript" type="text/javascript">
        function ChkDcSupplierCombination(source, eventArgs) {
            var supplierid = eventArgs.get_value();
            var ddl=document.getElementById('ddlSupplier');
            if (supplierid == ddl.options[ddl.selectedIndex].value) {
               
            }
        }
        function ChkInvoiceSupplierCombination(source, eventArgs) {
            var supplierid = eventArgs.get_value();
            var ddl = document.getElementById('ddlSupplier');
            if (supplierid == ddl.options[ddl.selectedIndex].value) {
                InvoiceAlert();
            }
        }
        
       
     
        function IAmSelected(source, eventArgs) {
            // alert(eventArgs.get_text() + "=>" + eventArgs.get_value());
            
            var arrDBVal = eventArgs.get_value().split('~');
            var MFDate = GetServerDate();
            var EXDate = GetServerDate();

            MFDate =ToInternalDate(new Date(arrDBVal[3]));
            EXDate =ToInternalDate(new Date(arrDBVal[4]));
            var pProductID = arrDBVal[0];
            var pProductName = arrDBVal[1];
            var pBatchno = arrDBVal[2];
            var pManufacture = MFDate;
            var pExpDate = EXDate;
            var pInHandQty = arrDBVal[5];
            var pQuantity = arrDBVal[6];
            var pUnit = arrDBVal[7];
            var pUnitPrice = arrDBVal[8];
            var pSellingPrice = arrDBVal[9];
            var pMRP = arrDBVal[10];
            var pTax = arrDBVal[11];
            var pMFCode = arrDBVal[12];
            var pProductCode = arrDBVal[13];
            var pMake = arrDBVal[14];
            var pSalesOrderID = arrDBVal[15];
            var pSalesOrderDetailsID = arrDBVal[16];
            var pStockInHandID = arrDBVal[17];
            var ProductKey = arrDBVal[18];
            var pParentProductID = arrDBVal[19];
            var pHasBatch = arrDBVal[20];
            var pHasExpiry = arrDBVal[21];
            var pRakNo = "";
            




            if (pBatchno != "") {
                document.getElementById('hdnproductId').value = pProductID;
                document.getElementById('hdnProductName').value = pProductName.replace(exp, "");
                document.getElementById('txtBatchNo').value = "";
                document.getElementById('txtMFTDate').value = "";
                document.getElementById('txtEXPDate').value = "";
            }
            if (pHasBatch != "N") {
                document.getElementById('txtBatchNo').value = pBatchno;
            }
            if (pHasExpiry != "N") {
                document.getElementById('txtEXPDate').value = pExpDate;
                document.getElementById('txtMFTDate').value = pManufacture;
            }
            if (pMFCode != "0") {
                document.getElementById('txtMFCode').value = pMFCode;

            }
            document.getElementById('txtInhandQuantity').value = pInHandQty;
            document.getElementById('txtQuantity').value = pQuantity;
            document.getElementById('txtIssueQty').value = "0";
            document.getElementById('ddlSelling').value = pUnit;
            document.getElementById('txtRate').value = parseFloat(pUnitPrice).toFixed(2);
            document.getElementById('txtMRP').value = pMRP;
            document.getElementById('txtTaxRate').value = pTax;
            document.getElementById('txtBatchNo').focus();
            document.getElementById('txtTotValues').value = "0.00";
            document.getElementById('txtTaxValue').value = "0.00";
            document.getElementById('txtExciesDuty').value = "0.00";
            document.getElementById('txtDiscount').value = "0.00";
            document.getElementById('txtDiscountVal').value = "0.00";
            document.getElementById('txtCSTValue').value = "0.00";
            document.getElementById('txtCST').value = "0.00";
            document.getElementById('txtMRPValue').value = "0.00";
            document.getElementById('txtTotalCost').value = "0.00";
            document.getElementById('txtTotalCost').readOnly = true
            document.getElementById('add').value = 'Add';
            document.getElementById('hdnUnitCostPrice').value = pUnitPrice;
            document.getElementById('hdnUnitSellingPrice').value = pSellingPrice;
            document.getElementById('hdnAdd').value = 'Add';
            document.getElementById('txtQuantity').readOnly = true;
            document.getElementById('ddlSelling').disabled = true;
            document.getElementById('hdnHasBatchNo').value = pHasBatch;
            document.getElementById('hdnHasExpiryDate').value = pHasExpiry;
            document.getElementById('hdnParentProductID').value = pParentProductID;
            document.getElementById('hdnSalesOrderID').value = pSalesOrderID;
            document.getElementById('hdnSalesOrderDetailsID').value = pSalesOrderDetailsID;
            document.getElementById('hdnStockinHandID').value = pStockInHandID;
            document.getElementById('hdnproductkey').value = ProductKey;
          //  TotalCalculation();

          }


        function CheckSalesQty() {
            var userMsg;
            var InHandQty = parseFloat(document.getElementById('txtInhandQuantity').value).toFixed(2);
            var Qty = parseFloat(document.getElementById('txtQuantity').value).toFixed(2);
            var IssueQty = parseFloat(document.getElementById('txtIssueQty').value).toFixed(2);

            if (Number(IssueQty) <= Number(0)) {
              userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_01") == null ? "Provide sales Quantity" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtIssueQty').focus();
                return false;
            }
            if (Number(IssueQty) > Number(Qty)) {
                 userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_02") == null ? "Provide Issue Quantity Should not Greater than Order Quantity" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtIssueQty').focus();
                return false;
            }

            if (Number(InHandQty) > Number(Qty)) {
                if (Number(InHandQty) < Number(IssueQty)) {
                   userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_03") == null ? "Provide Issue Quantity Should not Greater than Order /Avilable Quantity" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtIssueQty').focus();
                    return false;
                }
            }
            return true;

        }
        function CalTotal() {
            var TotalAmount = 0.00;
            var TaxAmount = 0.00;
             var CSTTaxAmount = 0.00;
            var pTax = 0.00;
            var pIssueQty = document.getElementById('txtIssueQty').value == 0 ? 0 : document.getElementById('txtIssueQty').value;
            var pUnitPrice = document.getElementById('txtRate').value == 0.00 ? 0 : document.getElementById('txtRate').value;
            var pMRP = document.getElementById('txtMRP').value == 0.00 ? 0 : document.getElementById('txtMRP').value;
            var pTax1 = document.getElementById('txtTaxRate').value == "" ? 0 : document.getElementById('txtTaxRate').value;
            var pExciesDuty = document.getElementById('txtExciesDuty').value == 0.00 ? 0 : document.getElementById('txtExciesDuty').value;
            if (pExciesDuty > 0) {
                pTax = pTax1 + pExciesDuty;
            }
            else {
                pTax = pTax1;
                }

                var Discount = document.getElementById('txtDiscount').value == 0.00 ? 0 : document.getElementById('txtDiscount').value;
                var Cstax = document.getElementById('txtCST').value == 0.00 ? 0 : document.getElementById('txtCST').value;
          
            var TotalCost = parseFloat(parseFloat(pIssueQty) * parseFloat(pUnitPrice)).toFixed(2);
           
           var pDiscount = parseFloat(parseFloat(parseFloat(TotalCost) / parseFloat(100)) * parseFloat(Discount)).toFixed(2);
           var Total = parseFloat(parseFloat(TotalCost) - parseFloat(pDiscount)).toFixed(2);
             document.getElementById('txtTotValues').value = parseFloat(parseFloat(pIssueQty) * parseFloat(pUnitPrice)).toFixed(2);
            
            TaxAmount = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(pTax)).toFixed(2);
            TotalAmount = parseFloat(parseFloat(Total) + parseFloat(TaxAmount)).toFixed(2);
            document.getElementById('txtTaxValue').value = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(pTax)).toFixed(2);
            document.getElementById('txtMRPValue').value = parseFloat(parseFloat(pIssueQty) * parseFloat(pMRP)).toFixed(2);
            document.getElementById('txtDiscountVal').value = parseFloat(parseFloat(parseFloat(parseFloat(pIssueQty) * parseFloat(pUnitPrice)) / parseFloat(100)) * parseFloat(Discount)).toFixed(2);
            CSTTaxAmount = parseFloat(parseFloat(parseFloat(TotalAmount) / parseFloat(100)) * parseFloat(Cstax)).toFixed(2);
            document.getElementById('txtCSTValue').value = parseFloat(parseFloat(parseFloat(TotalAmount) / parseFloat(100)) * parseFloat(Cstax)).toFixed(2);

            document.getElementById('txtTotalCost').value = parseFloat(parseFloat(parseFloat(TotalCost) + parseFloat(TaxAmount) + parseFloat(CSTTaxAmount)) - parseFloat(pDiscount)).toFixed(2);
            
        }



        function TotalCalculation() {
            var TotalValue;
            var pTax;
            var pTotalTaxValue;
            var pTotalMRPValue;
            var Total;
            var pDiscount;

//            document.getElementById('txtRate').value = parseFloat(pUnitPrice).toFixed(2);
//            document.getElementById('txtMRP').value = pMRP;
//            document.getElementById('txtTaxRate').value = pTax;
//            document.getElementById('txtBatchNo').focus();
//            document.getElementById('txtTotValues').value = "0.00";
//            document.getElementById('txtTaxValue').value = "0.00";
//            document.getElementById('txtExciesDuty').value = "0.00";
//            document.getElementById('txtDiscount').value = "0.00";
//            document.getElementById('txtDiscountVal').value = "0.00";
//            document.getElementById('txtMRPValue').value = "0.00";
//            document.getElementById('txtTotalCost').value = "0.00";
            //            document.getElementById('txtTotalCost').readOnly = true
//            document.getElementById('txtCSTValue').value = "0.00";
//            document.getElementById('txtCST').value = "0.00";

            var pIssueQty = document.getElementById('txtIssueQty').value == 0.00 ? 0 : document.getElementById('txtIssueQty').value;
            var pUnitPrice = document.getElementById('txtRate').value == 0.00 ? 0 : document.getElementById('txtRate').value;
            var pMRP= document.getElementById('txtMRP').value == 0.00 ? 0 : document.getElementById('txtMRP').value;
                pTax = document.getElementById('txtTaxRate').value == "" ? 0 : document.getElementById('txtTaxRate').value;
            var pExciesDuty = document.getElementById('txtExciesDuty').value == 0.00 ? 0 : document.getElementById('txtExciesDuty').value;
            var Discount = document.getElementById('txtDiscount').value == 0.00 ? 0 : document.getElementById('txtDiscount').value;

            var TotalCost = parseFloat(parseFloat(pIssueQty) * parseFloat(pUnitPrice)).toFixed(2);
           
           
            
//            calculateCastPerUnit();
//            var pExTax = document.getElementById('txtExTax').value =="" ? 0 : document.getElementById('txtExTax').value;
//            var tax = 0;
//            if (pExTax != 0) {
//              tax = pExTax;
//                document.getElementById('txtTax').disabled = true;
//            }
//            else {
//                  tax = document.getElementById('txtTax').value == 0.00 ? 0 : document.getElementById('txtTax').value;
//                document.getElementById('txtTax').disabled = false;
//            }
//            var Discount = document.getElementById('txtDiscount').value == 0.00 ? 0 : document.getElementById('txtDiscount').value;
//            var UnitPrice1 = document.getElementById('txtUnitPrice').value == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
//            var RECQuantity = document.getElementById('txtRcvdLSUQty').value == 0.00 ? 0 : document.getElementById('txtRcvdLSUQty').value;
//            var UnitPrice = document.getElementById('hdnUnitCostPrice').value == 0.00 ? 0 : document.getElementById('hdnUnitCostPrice').value;

//            var TotalCost = (parseFloat(RECQuantity) * parseFloat(UnitPrice)).toFixed(6);

//            pDiscount = parseFloat(parseFloat(parseFloat(TotalCost) / parseFloat(100)) * parseFloat(Discount)).toFixed(6);

//            Total = parseFloat(parseFloat(TotalCost) - parseFloat(pDiscount)).toFixed(6);



//            tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(6);

//            document.getElementById('txtTotalCost').value = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(6);
//            if (isNaN(document.getElementById('txtTotalCost').value)) {
//                document.getElementById('txtTotalCost').value = '0.00'
//            }
        }
       
       
   
        function getPrecision(id) {
            if (document.getElementById(id).value.trim() != "")
                return parseFloat(document.getElementById(id).value).toFixed(2);
            else
                return "0.00";
        }

        function getvalidation(evt) {
            var userMsg;
            var keycode = 0;
            if (evt) {
                keycode = evt.keyCode || evt.which;
            }
            else {
                keycode = window.event.keyCode
            }
            if (keycode != 9) {
                var ddlSupplier = document.getElementById('ddlSupplier');
                if (ddlSupplier.options[ddlSupplier.selectedIndex].text == '--Select--') {
                    userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_04") == null ? "Select a Supplier Name" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_04");
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtProductName').value = "";
                    return false;
                }
                if (document.getElementById('txtDCNumber').value == "" && document.getElementById('txtInvoiceNo').value == "") {
                    userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_05") == null ? "Enter DC Number/InvoiceNo" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_05");
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtDCNumber').focus();
                    document.getElementById('txtProductName').value = "";
                    return false;
                }
                //document.getElementById('txtBatchNo').focus();
                return true;
            }
        }
     



        function checkDetails() {
            var userMsg;

            //            if (document.getElementById('txtPODate').value == '') {
            //                alert('Select stock received date');
            //                document.getElementById('txtPODate').focus();
            //                return false;
            //            }

            //            if (document.getElementById('ddlSupplier').options[document.getElementById('ddlSupplier').selectedIndex].text == '--Select--') {
            //                alert('Select the supplier name');
            //                document.getElementById('ddlSupplier').focus();
            //                return false;
            //            }

            if (document.getElementById('txtDCNumber').value.trim() == '' && document.getElementById('txtInvoiceNo').value.trim() == '') {
                 userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_06") == null ? "Provide invoice details" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_06");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtDCNumber').focus();
                return false;
            }

            if (document.getElementById('hdnProductList').value == '') {
            userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_07") == null ? "Check the product list" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_07");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
//            var pType = document.getElementById('ddlStockReceivedType').options[document.getElementById('ddlStockReceivedType').selectedIndex].text;
//            if (pType != 'FreeProduct') {
//                if (document.getElementById('txtGrandTotal').value != 0.00) {
//                    document.getElementById('hdnGrandTotal').value = document.getElementById('txtGrandTotal').value;
//                }
//                else {
//                    alert('Check the product list');
//                    return false;
//                }
//            }
            var pBill = confirm("Please confirm if this Invoice has been Completed");
            if (pBill != true) {
                return false;
            }


            return true;
        }
        
        function checkIsEmpty(id) {
            var userMsg;
            document.getElementById('txtBatchNo').focus();

            if (document.getElementById('txtProductName').value.trim() == '' && document.getElementById('hdnAdd').value != 'Update') {
                 userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_08") == null ? "Provide product name" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_08");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtProductName').focus();
                return false;
            }

           
            if (document.getElementById('hdnHasBatchNo').value != 'N') {
                if (document.getElementById('txtBatchNo').value == '') {
                   userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_09") == null ? "Provide batch number" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_09");
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtBatchNo').focus();
                    return false;
                }

            }

            if (document.getElementById('txtMFTDate').value == '') {
                userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_10") == null ? "Provide ManuFacture date" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_10");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtMFTDate').focus();
                return false;
            }

            //            if (document.getElementById('hdnHasExpiryDate').value != 'N') {
            //                if (document.getElementById('txtEXPDate').value == '') {
            //                    alert('Provide expiry date');
            //                    document.getElementById('txtEXPDate').focus();
            //                    return false;
            //                }
            //            }

            if (document.getElementById('txtIssueQty').value == 0.00) {
                 userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_11") == null ? "Provide Sales quantity" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_11");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtIssueQty').focus();
                return false;
            }

            if (document.getElementById('ddlSelling').value == 0) {
                 userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_12") == null ? "Select selling unit" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_12");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlSelling').focus();
                return false;
            }
          


            if (document.getElementById('txtRate').value == 0.00) {
                 userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_13") == null ? "Provide Selling Price" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_13");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtRate').focus();
                return false;
            }
            if (document.getElementById('txtMRP').value == 0.00) {
                userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_14") == null ? "Provide MRP" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_14");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtMRP').focus();
                return false;
            }

            if (Number(document.getElementById('txtMRP').value) < Number(document.getElementById('txtRate').value)) {
              userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_15") == null ? "Provide MRP greater than Cost Price" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_15");
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
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        y = x[i].split('~');

                        if (y[1] == pProductId && y[3] == pBatchNo) {
                            var userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_16") == null ? "Product name and batch number combination already exist" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_16");
                            ValidationWindow(userMsg, errorMsg);
                            document.getElementById('txtBatchNo').focus();
                            return false;
                        }
                    }
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
            }

            //document.getElementById('tbTotalCost').style.display = "block";
            $('#tbTotalCost').removeClass().addClass('show');
            if (document.getElementById('hdnHasBatchNo').value != 'N') {
                return CheckDatesMfg(' ', document.getElementById('txtMFTDate'), 'MFG') == true ? CheckDatesExp(' ', document.getElementById('txtEXPDate'), 'EXP') : false;
            }
            return true;
        }

    
        function BindProductList() {
          
            if (document.getElementById('add').value == 'Update') {
                Deleterows();
            }
            else {
              
                var pProductID = document.getElementById('hdnproductId').value;
                var pProductNamefull = document.getElementById('txtProductName').value;
                var pProductNamesplit = pProductNamefull.split('[');
                var pProductName = pProductNamesplit[0];
                var pBatchno = document.getElementById('txtBatchNo').value;
                var pManufacture = "";
                var pExpDate = "";
                var pMFCode = document.getElementById('txtMFCode').value == "" ? "" : document.getElementById('txtMFCode').value;
                var pInhandQuantity = document.getElementById('txtInhandQuantity').value == "" ? 0 : document.getElementById('txtInhandQuantity').value;
                var pQuantity = document.getElementById('txtQuantity').value == "" ? 0 : document.getElementById('txtQuantity').value;
                var pIssueQty = document.getElementById('txtIssueQty').value == "" ? 0 : document.getElementById('txtIssueQty').value;
                var pSellingUnit = document.getElementById('ddlSelling').value;
                var pRate = document.getElementById('txtRate').value == "" ? 0 : document.getElementById('txtRate').value;
                var pTotValues = document.getElementById('txtTotValues').value == "" ? 0 : document.getElementById('txtTotValues').value;
                var pTax = document.getElementById('txtTaxRate').value == "" ? 0 : document.getElementById('txtTaxRate').value;
                var pTaxValue = document.getElementById('txtTaxValue').value == "" ? 0 : document.getElementById('txtTaxValue').value;
                var pExciesDuty = document.getElementById('txtExciesDuty').value == "" ? 0 : document.getElementById('txtExciesDuty').value;
                var pDiscount = document.getElementById('txtDiscount').value == "" ? 0 : document.getElementById('txtDiscount').value;
                var pDiscountValue = document.getElementById('txtDiscountVal').value == "" ? 0 : document.getElementById('txtDiscountVal').value;
                var pMRP = document.getElementById('txtMRP').value == "" ? 0 : document.getElementById('txtMRP').value;
                var pMRPValue = document.getElementById('txtMRPValue').value == "" ? 0 : document.getElementById('txtMRPValue').value;
                var pTotalCost = document.getElementById('txtTotalCost').value == "" ? 0 : document.getElementById('txtTotalCost').value;
                var pID = document.getElementById('hdnID').value == "" ? 0 : document.getElementById('hdnID').value;
                var productKey = document.getElementById('hdnproductkey').value;
                var pSno = document.getElementById('hdnSno').value;
                if (pBatchno == '') {
                    pBatchno = '*';
                }

                if (document.getElementById('txtEXPDate').value == '') {
                    pExpDate = '**';
                }
                else {
                    pExpDate =ToInternalDate(document.getElementById('txtEXPDate').value);
                }

                if ((document.getElementById('txtMFTDate').value == '')) {
                    pManufacture = '**';
                }
                else {
                    pManufacture =ToInternalDate(document.getElementById('txtMFTDate').value);
                }
                if (pDiscount == "") {
                    pDiscount = '0.00';
                } else {
                    pDiscount = (parseFloat(pDiscount)).toFixed(2);
                }

                if (pTax == "") {
                    pTax = '0.00';
                } else {
                    pTax = (parseFloat(pTax)).toFixed(2);
                }

                var pCst = document.getElementById('txtCST').value == "" ? 0 : document.getElementById('txtCST').value;
                var pCstValue = document.getElementById('txtCSTValue').value == "" ? 0 : document.getElementById('txtCSTValue').value;
                    
                
                var pSalesOrderID = document.getElementById('hdnSalesOrderID').value == "0" ? 0 : document.getElementById('hdnSalesOrderID').value;
                var pSalesOrderDetailsID = document.getElementById('hdnSalesOrderDetailsID').value == "0" ? 0 : document.getElementById('hdnSalesOrderDetailsID').value;
                var pStockinHandID = document.getElementById('hdnStockinHandID').value == "0" ? 0 : document.getElementById('hdnStockinHandID').value;
                var pParentProductID = document.getElementById('hdnParentProductID').value == "0" ? 0 : document.getElementById('hdnParentProductID').value;
                var pSellingPrice = document.getElementById('hdnUnitSellingPrice').value =="0" ? 0 : document.getElementById('hdnUnitSellingPrice').value;
                document.getElementById('hdnProductList').value += pSno + "~" +
                                                                    pProductID + "~" +
                                                                    pProductName.replace(exp, "") + "~" +
                                                                    pBatchno + "~" +
                                                                    pManufacture + "~" +
                                                                    pExpDate + "~" +
                                                                    pMFCode + "~" +
                                                                    pInhandQuantity + "~" +
                                                                    pQuantity + "~" +
                                                                    pIssueQty + "~" +
                                                                    pSellingUnit + "~" +
                                                                    pRate + "~" +
                                                                    pTotValues + "~" +
                                                                    pDiscount + "~" +
                                                                    pDiscountValue + "~" +
                                                                    pExciesDuty + "~" +
                                                                    pTax + "~" +
                                                                    pTaxValue + "~" +
                                                                    pCst + "~" +
                                                                    pCstValue + "~" +
                                                                    pMRP + "~" +
                                                                    pMRPValue + "~" +
                                                                    pTotalCost + "~" +
                                                                    pSalesOrderID + "~" +
                                                                    pSalesOrderDetailsID + "~" +
                                                                    pStockinHandID + "~" +
                                                                    pParentProductID + "~" +
                                                                    pSellingPrice + "~" +
                                                                    productKey+"^";
                                                                   
                Tblist();
                var pNo = Number(document.getElementById('hdnSno').value);
                document.getElementById('hdnSno').value = pNo + 1;


            }
            document.getElementById('add').value = 'Add';
            document.getElementById('hdnAdd').value = 'Add';

            document.getElementById('txtProductName').value = '';
            while (count = document.getElementById('tbllist').rows.length) {

                for (var j = 0; j < document.getElementById('tbllist').rows.length; j++) {
                    document.getElementById('tbllist').deleteRow(j);
                }
            }
            clearFields();
            document.getElementById('txtProductName').focus();

        }

        function clearFields() {
            document.getElementById('txtProductName').value = '';
            document.getElementById('hdnproductId').value = 0;
            document.getElementById('hdnProductName').value = '';
            //document.getElementById('TableProductDetails').style.display = "block";
            $('#TableProductDetails').removeClass().addClass('show');
            document.getElementById('ddlSelling').selectedIndex = 0;
            document.getElementById('ddlSelling').value = 0;
            document.getElementById('txtBatchNo').value = '';
            document.getElementById('txtEXPDate').value = '';
            document.getElementById('txtMFTDate').value = '';
            document.getElementById('txtMFCode').value = "";
            document.getElementById('txtInhandQuantity').value = "";
            document.getElementById('txtQuantity').value = "";
            document.getElementById('txtIssueQty').value = "";
            document.getElementById('txtRate').value = "";
            document.getElementById('txtTotValues').value = "";
            document.getElementById('txtTaxRate').value = "";
            document.getElementById('txtTaxValue').value = "";
            document.getElementById('txtExciesDuty').value = "";
            document.getElementById('txtDiscount').value = "";
            document.getElementById('txtDiscountVal').value = "";
            document.getElementById('txtMRP').value = "";
            document.getElementById('txtMRPValue').value = "";
            document.getElementById('txtRoundOffValue').value = 0.00;
            document.getElementById('hdnParentProductID').value = '0';
            document.getElementById('txtTotalCost').value = "";
            document.getElementById('hdnSalesOrderID').value = '0';
            document.getElementById('hdnSalesOrderDetailsID').value = '0';
            document.getElementById('hdnStockinHandID').value = '0';
            document.getElementById('hdnUnitSellingPrice').value = '0';
            document.getElementById('txtCSTValue').value = "";
            document.getElementById('txtCST').value = "";
            document.getElementById('hdnproductkey').value="";
        
          
            
        }



        function btnDelete(sEditedData) {

            var i;
            var x = document.getElementById('hdnProductList').value.split("^");
            document.getElementById('hdnProductList').value = '';
            
            document.getElementById('txtGrandTotal').value = '0.00';
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {

                    if (x[i] != sEditedData) {
                        y = x[i].split('~');
                        document.getElementById('hdnProductList').value += x[i] + "^";
                        document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(x[i].split('~')[16]) + parseFloat(document.getElementById('txtGrandTotal').value)).toFixed(2);
                    }

                }
            }
         
            document.getElementById('add').value = 'Add';
            document.getElementById('hdnAdd').value = 'Add';

          //  btnEdit_OnClick(sEditedData);
            Tblist();
        }
        
      

        function Deleterows() {
            var RowEdit = document.getElementById('hdnRowEdit').value;
            var x = document.getElementById('hdnProductList').value.split("^");
            if (RowEdit != "") {
                var pProductID = document.getElementById('hdnproductId').value;
                var pProductNamefull = document.getElementById('txtProductName').value;
                var pProductNamesplit = pProductNamefull.split('[');
                var pProductName = pProductNamesplit[0];
                var pBatchno = document.getElementById('txtBatchNo').value;
                var pManufacture = "";
                var pExpDate = "";
                var pMFCode = document.getElementById('txtMFCode').value == "" ? "" : document.getElementById('txtMFCode').value;
                var pInhandQuantity = document.getElementById('txtInhandQuantity').value == "" ? 0 : document.getElementById('txtInhandQuantity').value;
                var pQuantity = document.getElementById('txtQuantity').value == "" ? 0 : document.getElementById('txtQuantity').value;
                var pIssueQty = document.getElementById('txtIssueQty').value == "" ? 0 : document.getElementById('txtIssueQty').value;
                var pSellingUnit = document.getElementById('ddlSelling').value;
                var pRate = document.getElementById('txtRate').value == "" ? 0 : document.getElementById('txtRate').value;
                var pTotValues = document.getElementById('txtTotValues').value == "" ? 0 : document.getElementById('txtTotValues').value;
                var pTax = document.getElementById('txtTaxRate').value == "" ? 0 : document.getElementById('txtTaxRate').value;
                var pTaxValue = document.getElementById('txtTaxValue').value == "" ? 0 : document.getElementById('txtTaxValue').value;
                var pExciesDuty = document.getElementById('txtExciesDuty').value == "" ? 0 : document.getElementById('txtExciesDuty').value;
                var pDiscount = document.getElementById('txtDiscount').value == "" ? 0 : document.getElementById('txtDiscount').value;
                var pDiscountValue = document.getElementById('txtDiscountVal').value == "" ? 0 : document.getElementById('txtDiscountVal').value;
                var pMRP = document.getElementById('txtMRP').value == "" ? 0 : document.getElementById('txtMRP').value;
                var pMRPValue = document.getElementById('txtMRPValue').value == "" ? 0 : document.getElementById('txtMRPValue').value;
                var pTotalCost = document.getElementById('txtTotalCost').value == "" ? 0 : document.getElementById('txtTotalCost').value;
                var pID = document.getElementById('hdnID').value == "" ? 0 : document.getElementById('hdnID').value;
                var pSno = document.getElementById('hdnSno').value
                var productKey=document.getElementById('hdnproductkey').value;
                if (pBatchno == '') {
                    pBatchno = '*';
                }

                if (document.getElementById('txtEXPDate').value == '') {
                    pExpDate = '**';
                }
                else {
                    pExpDate = document.getElementById('txtEXPDate').value;
                }

                if ((document.getElementById('txtMFTDate').value == '')) {
                    pManufacture = '**';
                }
                else {
                    pManufacture = document.getElementById('txtMFTDate').value;
                }
                if (pDiscount == "") {
                    pDiscount = '0.00';
                } else {
                    pDiscount = (parseFloat(pDiscount)).toFixed(2);
                }

                if (pTax == "") {
                    pTax = '0.00';
                } else {
                    pTax = (parseFloat(pTax)).toFixed(2);

                }
                var pCst = document.getElementById('txtCST').value == "" ? 0 : document.getElementById('txtCST').value;
                var pCstValue = document.getElementById('txtCSTValue').value == "" ? 0 : document.getElementById('txtCSTValue').value;
                var pSalesOrderID = document.getElementById('hdnSalesOrderID').value == "0" ? 0 : document.getElementById('hdnSalesOrderID').value;
                var pSalesOrderDetailsID = document.getElementById('hdnSalesOrderDetailsID').value == "0" ? 0 : document.getElementById('hdnSalesOrderDetailsID').value;
                var pStockinHandID = document.getElementById('hdnStockinHandID').value == "0" ? 0 : document.getElementById('hdnStockinHandID').value;
                var pParentProductID = document.getElementById('hdnParentProductID').value == "0" ? 0 : document.getElementById('hdnParentProductID').value;
                var pSellingPrice = document.getElementById('hdnUnitSellingPrice').value == "0" ? 0 : document.getElementById('hdnUnitSellingPrice').value;
                document.getElementById('hdnProductList').value = pSno + "~" +
                                                                    pProductID + "~" +
                                                                    pProductName.replace(exp, "") + "~" +
                                                                    pBatchno + "~" +
                                                                    pManufacture + "~" +
                                                                    pExpDate + "~" +
                                                                    pMFCode + "~" +
                                                                    pInhandQuantity + "~" +
                                                                    pQuantity + "~" +
                                                                    pIssueQty + "~" +
                                                                    pSellingUnit + "~" +
                                                                    pRate + "~" +
                                                                    pTotValues + "~" +
                                                                    pDiscount + "~" +
                                                                    pDiscountValue + "~" +
                                                                    pExciesDuty + "~" +
                                                                    pTax + "~" +
                                                                    pTaxValue + "~" +
                                                                    pCst + "~" +
                                                                    pCstValue + "~" +                                                      
                                                                    pMRP + "~" +
                                                                    pMRPValue + "~" +
                                                                    pTotalCost + "~" +
                                                                    pSalesOrderID + "~" +
                                                                    pSalesOrderDetailsID + "~" +
                                                                    pStockinHandID + "~" +
                                                                    pParentProductID + "~" +
                                                                    pSellingPrice + "~" +
                                                                    productKey+"^";
              for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {

                        if (x[i] != RowEdit) {
                            document.getElementById('hdnProductList').value += x[i] + "^";
                        }
                    }
                }
                document.getElementById('hdnRowEdit').value = "";
                Tblist();
                var pNo = Number(document.getElementById('hdnSno').value);
                document.getElementById('hdnSno').value = pNo + 1;
                document.getElementById('add').value = 'Add';
                document.getElementById('hdnAdd').value = 'Add';
                clearFields();
                document.getElementById('txtProductName').focus();
            }
                
        }
        function AppendMRP() {
            document.getElementById('txtMRP').value = document.getElementById('txtSellingPrice').value;
        }
        function btnEdit_OnClick(sEditedData) {

            var y = sEditedData.split('~');

          
            document.getElementById('hdnSno').value = y[0];
            document.getElementById('hdnproductId').value = y[1];
            document.getElementById('hdnProductName').value = y[2];
            document.getElementById('txtProductName').value = y[2];
            document.getElementById('txtBatchNo').value = y[3];
         
            document.getElementById('txtMFTDate').value = y[4] == "**"  ? "" : y[4];
            document.getElementById('txtEXPDate').value = y[5] == "**" ? "" : y[5];
            document.getElementById('txtMFCode').value =y[6];
            document.getElementById('txtInhandQuantity').value = y[7];
            document.getElementById('txtQuantity').value = y[8];
            document.getElementById('txtIssueQty').value = y[9];
             document.getElementById('ddlSelling').value = y[10];
             document.getElementById('txtRate').value =y[11];
             document.getElementById('txtTotValues').value = y[12];
             document.getElementById('txtDiscount').value = y[13];
             document.getElementById('txtDiscountVal').value = y[14];
             document.getElementById('txtExciesDuty').value = y[15];
             document.getElementById('txtTaxRate').value = y[16];
             document.getElementById('txtTaxValue').value = y[17];

             document.getElementById('txtCST').value = y[18];
             document.getElementById('txtCSTValue').value = y[19];
             document.getElementById('txtMRP').value =y[20];
             document.getElementById('txtMRPValue').value =y[21];
             document.getElementById('txtTotalCost').value = y[22];
            
             document.getElementById('hdnSalesOrderID').value = y[23];
             document.getElementById('hdnSalesOrderDetailsID').value = y[24];
             document.getElementById('hdnStockinHandID').value = y[25];
             document.getElementById('hdnParentProductID').value = y[26];
             document.getElementById('hdnUnitSellingPrice').value = y[27];
             document.getElementById('hdnproductkey').value = y[28];
             document.getElementById('hdnRowEdit').value = sEditedData;
             document.getElementById('add').value = 'Update';
             document.getElementById('hdnAdd').value = 'Update';
             //document.getElementById('TableProductDetails').style.display = "block";
             $('#TableProductDetails').removeClass().addClass('show');
             
        }

        function btnOnFocus() {
            document.getElementById('add').focus();
            if (checkIsEmpty())
            { BindProductList(); }
        }
           
   
        function getMonthValue(source) {
            //  var month_names = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            var month_names = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
            for (var i = 0; i < month_names.length; i++) {
                if (month_names[i] == source) {
                    return i;
                }
            }
        }

        function CheckDatesMfg(splitChar, ObjDate, flag) {
          
            var today = GetServerDate();

            if ((ObjDate.value.trim() == '')) {
                document.getElementById('txtMFTDate').value == '';
                return true;

            }
            else {

                if (ObjDate.value.trim() == '') {
                    alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
                    ObjDate.select();
                    return true;
                }
                else {
                    //Assign From And To Date from Controls
                    //splitChar = ObjDate.value.split(' ').length > 1 ? splitChar : '/';
                    //var DateFrom = new Array(2);
                    //var DateNow = new Array(2);
                    //DateFrom[0] = ObjDate.value.split(splitChar)[0];
                    //DateFrom[1] = (getMonthValue(ObjDate.value.split(splitChar)[1]) + 1);
                    //DateFrom[2] = ObjDate.value.split(splitChar)[2];
                    // DateTo = ("01" + splitChar + (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1) + splitChar + ObjDate.value.split(splitChar)[1]).split(splitChar);
                    //DateNow[0] = today.getDay();
                    //DateNow[1] = today.getMonth() + 1;
                    //DateNow[2] = today.getFullYear();
                    
                    //Argument Value 0 for validating Current Date And To Date 
                    //Argument Value 1 for validating Current From And To Date
                    if (CheckFromToDate(ObjDate, today)) {
                        //       alert("Validation Succeeded");
                        return true;
                    }
                    else {
                        //ObjDate.select();
                        return false;
                    }
                }
            }

        }
        function CheckDatesExp(splitChar, ObjDate, flag) {

            var today = GetServerDate();
            if ((ObjDate.value.trim() == '')) {
                document.getElementById('txtEXPDate').value == '';
                  return true;
            }
            else {

                if ((ObjDate.value.trim() == '')) {
                    alert(flag == "EXP" ? 'Provide Expiry Date!' : 'Provide Manufactured Date!');
                    ObjDate.select();
                    return true;
                }
                else {
                    //Assign From And To Date from Controls
                    //splitChar = ObjDate.value.split(' ').length > 1 ? splitChar : '/';
                    //var DateFrom = new Array(2);
                    //var DateNow = new Array(2);
                    //DateFrom[0] = ObjDate.value.split(splitChar)[0];
                    //DateFrom[1] = (getMonthValue(ObjDate.value.split(splitChar)[1]) + 1);
                    //DateFrom[2] = ObjDate.value.split(splitChar)[2];
                    //// DateTo = ("01" + splitChar + (getMonthValue(ObjDate.value.split(splitChar)[0]) + 1) + splitChar + ObjDate.value.split(splitChar)[1]).split(splitChar);
                    //DateNow[0] = today.getDay();
                    //DateNow[1] = today.getMonth() + 1;
                    //DateNow[2] = today.getFullYear();
                    //Argument Value 0 for validating Current Date And To Date 
                    //Argument Value 1 for validating Current From And To Date
                    if (CheckFromToDate(today, ObjDate)) {
                        //       alert("Validation Succeeded");
                        return true;
                    }
                    else {
                        ObjDate.select();
                        return false;
                    }

                }
                return true;

            }
        }

        //function doDateValidation(from, to, bit) {
        //    var monthFlag = true;
        //    var i = from.length - 1;
        //    if (Number(to[i]) >= Number(from[i])) {
        //        if (Number(to[i]) == Number(from[i])) {
        //            monthFlag = false;
        //        }
        //        i--;
        //        if (Number(to[i]) >= Number(from[i])) {
        //            return true;
        //        }
        //        else if (monthFlag) {
        //            return true;
        //        }
        //        else {
        //            if (bit == 0) {
        //                var userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_17") == null ? "Mismatch Month Between Current & Mfg Date" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_17");
        //                ValidationWindow(userMsg, errorMsg);
        //            }
        //            else {
        //                var userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_18") == null ? "Mismatch Month Between Current & Exp Date" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_18");
        //                ValidationWindow(userMsg, errorMsg);
        //            }
        //            return false;
        //        }
        //    }
        //    else {
        //        if (bit == 0) {
        //            var userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_19") == null ? "Mismatch Year Between Current & Mfg Date" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_19");
        //            ValidationWindow(userMsg, errorMsg);
        //        }
        //        else {
        //            var userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_20") == null ? "Mismatch Year Between Current & Exp Date" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_20");
        //            ValidationWindow(userMsg, errorMsg);
        //        }
        //        return false;
        //    }
        //}

  



        function InvoiceCheck(eventArgs) {

            document.getElementById('hdninvoice').value = '';
            document.getElementById('hdnDC').value = '';
            var y = '';
            var HidValue = document.getElementById('hdninvoicelist').value;
            var list = HidValue.split('^');
            var NewHealthCheckupList = '';
            if (document.getElementById('hdninvoicelist').value != "") {
                for (var count = 0; count < list.length; count++) {

                    if (list[count] != '') {
                        y = list[i].split("~");
                        NewHealthCheckupList += list[count] + '^';
                    }
                }
            }
        }

        function checkDate1(obj) {

            var myValStr = document.getElementById(obj).value;

            if (myValStr != "__/__/____" && myValStr != "") {
                var Mon = myValStr.split('/')[0];
                var pyyyy = myValStr.split('/')[1];
                var isTrue = false;
                var myMonth = new Array('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12');
                for (i = 0; i < myMonth.length; i++) {
                    if (myMonth[i] != "" && Mon != "" && Mon == myMonth[i] && Mon.length == 2) {
                        isTrue = true;
                    }
                }
                if (!isTrue) {
                    document.getElementById(obj).focus();
                    var userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_21") == null ? "Provide valid date" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_21");
                    ValidationWindow(userMsg, errorMsg);
                    return isTrue;
                }
                var pdate = Mon + pyyyy;
                var pdatelen = pdate.length;
                for (j = 0; j < pdatelen; j++) {
                    if (pdate.charAt(j) == "_") {
                        document.getElementById(obj).focus();
                        var userMsg = SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_21") == null ? "Provide valid date" : SListForAppMsg.Get("InventorySales_SalesOrderIssue_aspx_21");
                        ValidationWindow(userMsg, errorMsg);
                        return false;
                    }
                }
            }
        }
       
        
        
        function setFocus(obj, pType) {
            if (pType == "F") {
                if ($('#tblPODetail').hasClass('hide') || $('#tblPODetail').hasClass('')) {
                    document.getElementById('txtPODate').focus();
                }
            }

        }

        function displaydetail() {

            var ddl = document.getElementById('ddlSupplier');
          var supplierid = ddl.options[ddl.selectedIndex].value; 
          
            if(supplierid ==0){

                //document.getElementById('divProduct').style.display == 'none';
                $('#divProduct').removeClass().addClass('hide');
            }
            else {

                //document.getElementById('divProduct').style.display = 'block';
                $('#divProduct').removeClass().addClass('show');
            }
        
        }
    </script>

    <asp:ScriptManager ID="ScriptManager2" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventorySales/WebService/InventorySalesService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table class="w-100p">
                    <tr>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="w-100p table" id="tabRecd" runat="server">
                                <tr>
                                    <td class="w-45p v-top">
                                        <table id="Table1" runat="server" class="dataheaderInvCtrl w-100p border1 custcellpadding custcellspacing1" >
                                            <tr>
                                                <td class="h-10">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left w-20p">
                                                    <asp:Label ID="lblSalesOrderNo" runat="server" Text="Sales Order No" meta:resourcekey="lblSalesOrderNoResource1" />
                                                </td>
                                                <td class=" w-25p">
                                                    <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtSalesOrderNo" runat="server" MaxLength="255" CssClass="Txtboxsmall"
                                                        meta:resourcekey="txtSalesOrderNoResource1"></asp:TextBox>
                                                    &nbsp;<img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left w-15p">
                                                    <asp:Label ID="lblSalesDate" runat="server" Text="Sales Date" meta:resourcekey="lblSalesDateResource1" />
                                                </td>
                                                <td class="w-50p">
                                                    <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtSalesDate" runat="server" CssClass="datePicker" meta:resourcekey="txtSalesDateResource1"></asp:TextBox>
                                                    
                                                    &nbsp;<img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left w-20p">
                                                    <asp:Label ID="lblCustomerName" runat="server" Text="Customer Name" meta:resourcekey="lblCustomerNameResource1" />
                                                </td>
                                                <td class="w-10p">
                                                    <asp:DropDownList ID="ddlCustomer" runat="server" CssClass="ddlsmall w-120"
                                                        meta:resourcekey="ddlCustomerResource1">
                                                    </asp:DropDownList>
                                                    &nbsp;<img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left w-20p">
                                                    <asp:Label ID="lblShipToLocationName" runat="server" Text="Ship To LocationName"
                                                        meta:resourcekey="lblShipToLocationNameResource1" />
                                                </td>
                                                <td class="w-10p">
                                                    <div id="divsup1" runat="server" class="hide">
                                                        <asp:DropDownList ID="ddlSupplier" runat="server" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlSupplier_SelectedIndexChanged" TabIndex="3" CssClass="ddlmedium w-250"
                                                            meta:resourcekey="ddlSupplierResource1">
                                                        </asp:DropDownList>
                                                        &nbsp;<img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left w-20p">
                                                    <asp:Label ID="lblDCNumber" runat="server" Text="DC Number" meta:resourcekey="lblDCNumberResource1" />
                                                </td>
                                                <td class="w-10p">
                                                    <asp:TextBox onKeyPress="return ValidateMultiLangChar(this);" ID="txtDCNumber" runat="server" MaxLength="50" CssClass="Txtboxsmall" TabIndex="4"></asp:TextBox><%--onkeypress="KeyPress(event);"--%><%--onblur="supplierdcno_chk();"--%>
                                                    <%-- <ajc:AutoCompleteExtender ID="AutoCompleteDcNumber" runat="server" CompletionInterval="1"
                                                                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                CompletionListItemCssClass="listitemtwo" EnableCaching="false" FirstRowSelected="true"
                                                                MinimumPrefixLength="1" OnClientItemSelected="ChkDcSupplierCombination"  ServiceMethod="GetSuppliernumcombination"
                                                                ServicePath="~/InventoryWebService.asmx" TargetControlID="txtDCNumber">
                                                            </ajc:AutoCompleteExtender>--%>
                                                    &nbsp;<img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                                    <img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left w-20p">
                                                    <asp:Label ID="lblInvoiceNo" runat="server" Text="Invoice No" meta:resourcekey="lblInvoiceNoResource1" />
                                                </td>
                                                <td class="w-10p">
                                                    <asp:TextBox onKeyPress="return ValidateMultiLangChar(this);" ID="txtInvoiceNo" runat="server" MaxLength="50" CssClass="Txtboxsmall"
                                                        meta:resourcekey="txtInvoiceNoResource1"></asp:TextBox>
                                                    <%--<ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" CompletionInterval="1"
                                                                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                CompletionListItemCssClass="listitemtwo" EnableCaching="false" FirstRowSelected="true"
                                                                MinimumPrefixLength="1" OnClientItemSelected="ChkInvoiceSupplierCombination"  ServiceMethod="GetSuppliernumcombination"
                                                                ServicePath="~/InventoryWebService.asmx" TargetControlID="txtInvoiceNo">
                                                            </ajc:AutoCompleteExtender>--%>
                                                    &nbsp;<img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left w-20p">
                                                    <asp:Label ID="lblComments" runat="server" Text="Comments" meta:resourcekey="lblCommentsResource1" />
                                                </td>
                                                <td class="w-10p">
                                                    <asp:TextBox onKeyPress="return ValidateMultiLangChar(this);" ID="txtComments" onblur="setFocus(this.id,'F')" TextMode="MultiLine"
                                                        runat="server" Columns="25" Rows="2" CssClass="txtboxps" TabIndex="7" meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="a-center h-5">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td class="v-top paddingL10 w-55p">
                                        <table class="w-100p table dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <div class="auto h-213">
                                                        <asp:Table CssClass="colorforcontentborder custcellpadding3 custcellspacing1 border1 w-100p"
                                                            runat="server" ID="SalesOrderDetailsTab" meta:resourcekey="SalesOrderDetailsTabResource1">
                                                        </asp:Table>
                                                        <%--    OnPageIndexChanging="gvReceivedDetails_PageIndexChanging"
                                                        OnRowDataBound="gvReceivedDetails_RowDataBound"--%>
                                                        <asp:GridView ID="gvReceivedDetails" EmptyDataText="No Matching Records Found!" CssClass="w-100p custcellpadding3 custcellspacing3"
                                                            runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                            PageSize="100" meta:resourcekey="gvReceivedDetailsResource1">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <Columns>
                                                                <asp:BoundField DataField="ProductName" HeaderText="Product Name" meta:resourcekey="BoundFieldResource1" />
                                                                <asp:BoundField DataField="Quantity" HeaderText="Ordered Qty" meta:resourcekey="BoundFieldResource2" />
                                                                <%--<asp:BoundField DataField="IssuedQty" HeaderText="Ordered Qty" />--%>
                                                                <asp:BoundField DataField="Unit" HeaderText="Unit" meta:resourcekey="BoundFieldResource3" />
                                                                <asp:BoundField DataField="IssuedQty" HeaderText="SalesQuantity" meta:resourcekey="BoundFieldResource4" />
                                                                <%--<asp:TemplateField HeaderText="Action" Visible="false">
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnAction" runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>--%>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="divProduct" runat="server">
                                <table id="tblPODetail" class="w-100p hide dataheader2 defaultfontcolor border1 custcellpadding3 custcellspacing2"
                                    >
                                    <tr class="a-left">
                                        <td>
                                            <asp:Label ID="lblProductName" runat="server" Text="Product Name" meta:resourcekey="lblProductName" />
                                        </td>
                                        <td class="bold font14">
                                        </td>
                                    </tr>
                                    <tr class="a-left">
                                        <td>
                                            <asp:TextBox onKeyPress="return ValidateMultiLangChar(this);" ID="txtProductName" CssClass="w-325" runat="server" onkeydown="return getvalidation(event);"
                                                TabIndex="8" meta:resourcekey="txtProductNameResource1"></asp:TextBox>
                                            <%-- <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                CompletionListItemCssClass="listitemtwo" EnableCaching="false" FirstRowSelected="true"
                                                                MinimumPrefixLength="2" OnClientItemSelected="IAmSelected" ServiceMethod="GetSalesOrderProductList"
                                                                ServicePath="~/InventoryWebService.asmx" TargetControlID="txtProductName"  OnClientItemOver="SalesGetProductTotalQuantity">
                                                            </ajc:AutoCompleteExtender>--%>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                                MinimumPrefixLength="2" OnClientItemSelected="IAmSelected" ServiceMethod="GetSalesOrderProductList"
                                                OnClientItemOver="SalesGetProductTotalQuantity" ServicePath="~/InventorySales/WebService/InventorySalesService.asmx"
                                                TargetControlID="txtProductName" DelimiterCharacters="" Enabled="True">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                        <td class="font11">
                                            <asp:Table CssClass="dataheaderInvCtrl w-100p custcellpadding2 borderwidth1 custcellspacing2"
                                                runat="server" ID="tbllist" meta:resourcekey="tbllistResource1">
                                            </asp:Table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center" colspan="2">
                                            <table id="TableProductDetails" runat="server" class="w-100p custcellpadding3 custcellspacing2">
                                                <tr class="bold custpadding1">
                                                    <td>
                                                        <asp:Label ID="lblBatchNo" runat="server" Text="Batch No" meta:resourcekey="lblBatchNoResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblMFTDate" runat="server" Text="MFT Date" meta:resourcekey="lblMFTDateResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblEXPDate" runat="server" Text="EXP Date" meta:resourcekey="lblEXPDateResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblMFGCode" runat="server" Text="MFG Code" meta:resourcekey="lblMFGCodeResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblInHandQty" runat="server" Text="InHandQty" meta:resourcekey="lblInHandQtyResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblOrderQty" runat="server" Text="OrderQty" meta:resourcekey="lblOrderQtyResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblSalesQty" runat="server" Text="SalesQty" meta:resourcekey="lblSalesQtyResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblSellingUnit" runat="server" Text="Selling Unit(lsu)" meta:resourcekey="lblSellingUnitResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblRate" runat="server" Text="Rate" meta:resourcekey="lblRateResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblValue" runat="server" Text="Value" meta:resourcekey="lblValueResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDiscount" runat="server" Text="Discount(%)" meta:resourcekey="lblDiscountResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDiscountValue" runat="server" Text="Discount Value" meta:resourcekey="lblDiscountValueResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblExciseDuty" runat="server" Text="Excise Duty" meta:resourcekey="lblExciseDutyResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblVATRate" runat="server" Text="VAT Rate %" meta:resourcekey="lblVATRateResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblVATvalue" runat="server" Text="VAT value" meta:resourcekey="lblVATvalueResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblCSTRate" runat="server" Text="CST Rate %" meta:resourcekey="lblCSTRateResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblCSTvalue" runat="server" Text="CST value" meta:resourcekey="lblCSTvalueResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblMRP" runat="server" Text="MRP" meta:resourcekey="lblMRPResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblMRPValue" runat="server" Text="MRP Value" meta:resourcekey="lblMRPValueResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblTotalCost" runat="server" Text="Total Cost" meta:resourcekey="lblTotalCostResource1" />
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateMultiLangChar(this);" ID="txtBatchNo" runat="server"  CssClass="w-60" TabIndex="10" meta:resourcekey="txtBatchNoResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtMFTDate" onblur="return checkDate1(this.id);" runat="server"
                                                           CssClass="datePicker w-70"  TabIndex="11" meta:resourcekey="txtMFTDateResource1"></asp:TextBox>
                                                        
                                                    </td>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtEXPDate" ReadOnly="true" onblur="return checkDate1(this.id);" CssClass="w-70" runat="server"
                                                            TabIndex="12" meta:resourcekey="txtEXPDateResource1"></asp:TextBox>
                                                        
                                                    </td>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateMultiLangChar(this);" ID="txtMFCode" runat="server"
                                                            CssClass="w-50" TabIndex="13" meta:resourcekey="txtMFCodeResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtInhandQuantity" runat="server"
                                                            CssClass="w-50" TabIndex="14" meta:resourcekey="txtInhandQuantityResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtQuantity"  runat="server"
                                                            CssClass="w-50" TabIndex="15" meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtIssueQty" onblur=" CheckSalesQty(); CalTotal();" 
                                                            runat="server" CssClass="w-50" TabIndex="16" meta:resourcekey="txtIssueQtyResource1"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlSelling" CssClass="w-70" runat="server" TabIndex="17" meta:resourcekey="ddlSellingResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtRate" onblur="CalTotal()"
                                                            runat="server" CssClass="w-50" TabIndex="18" meta:resourcekey="txtRateResource1"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtTotValues" runat="server"
                                                            CssClass="w-50" TabIndex="19" meta:resourcekey="txtTotValuesResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtDiscount" onblur="CalTotal()"
                                                            runat="server" CssClass="w-50" TabIndex="20" meta:resourcekey="txtDiscountResource1"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtDiscountVal" onblur="CalTotal()" 
                                                            runat="server" CssClass="w-50" TabIndex="21" meta:resourcekey="txtDiscountValResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateMultiLangChar(this);" ID="txtExciesDuty" onblur="CalTotal()" Enabled="False" 
                                                            runat="server" CssClass="w-50" TabIndex="22" meta:resourcekey="txtExciesDutyResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtTaxRate" runat="server"
                                                            onblur="CalTotal()" CssClass="w-50" TabIndex="23" meta:resourcekey="txtTaxRateResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtTaxValue" onblur="CalTotal()" 
                                                            runat="server" CssClass="w-50" TabIndex="24" meta:resourcekey="txtTaxValueResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtCST" runat="server"
                                                            onblur="CalTotal()" CssClass="w-50" TabIndex="25" meta:resourcekey="txtCSTResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtCSTValue" onblur="CalTotal()" 
                                                            runat="server" CssClass="w-50" TabIndex="26" meta:resourcekey="txtCSTValueResource1"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtMRP" onblur="CalTotal()" 
                                                            runat="server" CssClass="w-50" TabIndex="27" meta:resourcekey="txtMRPResource1"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtMRPValue" runat="server"
                                                            CssClass="w-50" TabIndex="28" meta:resourcekey="txtMRPValueResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-center">
                                                        <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtTotalCost" runat="server"
                                                            CssClass="w-60" TabIndex="29" meta:resourcekey="txtTotalCostResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-right">
                                                        <input id="add" type="button" tabindex="30" onmouseover="this.className='btn btnhov'"
                                                            class="btn w-60" onmouseout="this.className='btn'" onclick="javascript:if(checkIsEmpty()) return BindProductList();"
                                                            name="add" value="Add" />
                                                        <asp:HiddenField ID="hdnAdd" runat="server" Value="Add" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center" colspan="2">
                                            <table class="dataheaderInvCtrl a-left border2 custcellpadding2 custcellspacing1 font11 w-100p " 
                                                 id="TableCollectedItems" runat="server">
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <table class="w-100p show" id="tbTotalCost">
                                                <tr>
                                                    <td class="a-right v-top">
                                                    </td>
                                                    <td class="a-right">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblTotalSales" runat="server" Text="Total Sales :" meta:resourcekey="lblTotalSalesResource1" />
                                                                    <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtTotalSales" CssClass="Align w-70" Enabled="False" TabIndex="31"
                                                                         runat="server" Text="0.00" meta:resourcekey="txtTotalSalesResource1"></asp:TextBox>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblTotalDiscountAmount" runat="server" Text="Total Discount Amount :"
                                                                        meta:resourcekey="lblTotalDiscountAmountResource1" />
                                                                    <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtTotalDiscountAmt" CssClass="Align w-70" Enabled="False" 
                                                                        TabIndex="32" runat="server" Text="0.00" meta:resourcekey="txtTotalDiscountAmtResource1"></asp:TextBox>&nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblTotalTaxVATAmount" runat="server" Text="Total Tax/VAT Amount :"
                                                                        meta:resourcekey="lblTotalTaxVATAmountResource1" />
                                                                    <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtTotalTaxAmt" CssClass="Align w-70" Enabled="False" TabIndex="33"
                                                                        runat="server" Text="0.00" meta:resourcekey="txtTotalTaxAmtResource1"></asp:TextBox>&nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblAdditionalCST" runat="server" Text="Additional CST(if applicable) :"
                                                                        meta:resourcekey="lblAdditionalCSTResource1" /> 
                                                                    <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtAddCST" CssClass="Align w-70" Enabled="False" TabIndex="34"
                                                                         runat="server" Text="0.00" meta:resourcekey="txtAddCSTResource1"></asp:TextBox>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblSurcharge" runat="server" Text="Surcharge/Cess(if applicable):"
                                                                        meta:resourcekey="lblSurchargeResource1" />
                                                                    <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtSurcharge" onblur="CalSurcharge();" CssClass="Align w-70"
                                                                        TabIndex="35" runat="server" Text="0.00"
                                                                        meta:resourcekey="txtSurchargeResource1"></asp:TextBox>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblOctroi" runat="server" Text="Octroi (lf applicable):" meta:resourcekey="lblOctroiResource1" />
                                                                    <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtOctroi" CssClass="Align w-70" Enabled="False" TabIndex="36"
                                                                        runat="server" Text="0.00" meta:resourcekey="txtOctroiResource1"></asp:TextBox>&nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblGrandTotal" runat="server" Text="Grand Total :" meta:resourcekey="lblGrandTotalResource1" />
                                                                    <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtGrandTotal" Enabled="False" CssClass="Align w-70" runat="server"
                                                                        TabIndex="37" Text="0.00" meta:resourcekey="txtGrandTotalResource1"></asp:TextBox>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblTotal" runat="server" Text="Total :" meta:resourcekey="lblTotalResource1" />
                                                                    <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtNetTotal" CssClass="Align w-70" Enabled="False" TabIndex="38"
                                                                        runat="server" Text="0.00" meta:resourcekey="txtNetTotalResource1"></asp:TextBox>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblRoundOffValue" runat="server" Text="RoundOff Value :" meta:resourcekey="lblRoundOffValueResource1" />
                                                                    <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtRoundOffValue" runat="server" CssClass="Align w-70" Text="0.00"
                                                                        Enabled="False" meta:resourcekey="txtRoundOffValueResource1"></asp:TextBox>&nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblRounded" runat="server" Text="Rounded-Off Net Total :" meta:resourcekey="lblRoundedResource1" />
                                                                    <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtGrandwithRoundof"
                                                                        CssClass="Align w-70" runat="server" Text="0.00" onblur="return CalRounfOff();" TabIndex="39"
                                                                        meta:resourcekey="txtGrandwithRoundofResource1"></asp:TextBox>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="a-center">
                                            <table id="submitTab" runat="server" class="hide table">
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnFinish" AccessKey="E" TabIndex="40" OnClientClick="javascript:return checkDetails();"
                                                            runat="server" OnClick="btnFinish_Click" Text="Finish" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" meta:resourcekey="btnFinishResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnCancel" TabIndex="41" runat="server" Text="Home" OnClick="btnCancel_Click"
                                                            OnClientClick="javascript:return Validate();" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdnIsResdCalc" runat="server" />
                <input type="hidden" id="hdnTempTable" runat="server" />
                <input type="hidden" id="hdnRowEdit" runat="server" />
                <input type="hidden" id="hdnProductList" runat="server" />
                <input type="hidden" id="hdnproductkey" runat="server" />
                <input type="hidden" id="hdnRowId" value="0" runat="server" />
                <input type="hidden" id="hdnProductName" runat="server" />
                <input type="hidden" id="hdnUnitCostPrice" value="0" runat="server" />
                <input type="hidden" id="hdnHasExpiryDate" value="Y" runat="server" />
                <input type="hidden" id="hdnHasBatchNo" value="Y" runat="server" />
                <asp:HiddenField ID="hdnproductId" runat="server" />
                <input type="hidden" id="hdnTotalCost" value="0" runat="server" />
                <input type="hidden" id="hdnUnitSellingPrice" value="0" runat="server" />
                <input id="hdnOnDeleteReset" type="hidden" value="" runat="server" />
                <input id="hdnID" type="hidden" value="0" runat="server" />
                <input id="hdnSno" type="hidden" value="1" runat="server" />
                <asp:HiddenField ID="hdnGrandTotal" Value="0.00" runat="server" />
                <asp:HiddenField ID="hdninvoicelist" runat="server" />
                <asp:HiddenField ID="hdninvoice" runat="server" />
                <asp:HiddenField ID="hdnDC" runat="server" />
                <asp:HiddenField ID="hdnRoundofType" Value="0.00" runat="server" />
                <input type="hidden" id="hdnParentProductID" value="0" runat="server" />
                <input type="hidden" id="hdnShowCostPrice" value="Y" runat="server" />
                <input type="hidden" id="hdnSalesOrderID" value="0" runat="server" />
                <input type="hidden" id="hdnSalesOrderDetailsID" value="0" runat="server" />
                <input type="hidden" id="hdnStockinHandID" value="0" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>

<script type="text/javascript" language="javascript">
    function OnUsageCount(obj) {
        if (obj.checked) {
            //document.getElementById('divUsageCount').style.display = 'block';
            $('#divUsageCount').removeClass().addClass('show');
        }
        else {
            //document.getElementById('divUsageCount').style.display = 'none';
            $('#divUsageCount').removeClass().addClass('hide');
        }
    }

    function CalSurcharge() {
      
        var GrandTotal = 0.00;
        var totSurcharge = 0.00;
        var totAmount = 0.00;
        var CstAmount = 0.00;

        var CstAmount = document.getElementById('txtAddCST').value;
        var taxAmount = document.getElementById('txtTotalTaxAmt').value;
        var Surcharge = document.getElementById('txtSurcharge').value;
        var totAmount = parseFloat(parseFloat(parseFloat(document.getElementById('txtTotalSales').value) + parseFloat(document.getElementById('txtTotalTaxAmt').value) + parseFloat(document.getElementById('txtAddCST').value)) - parseFloat(document.getElementById('txtTotalDiscountAmt').value)).toFixed(2);
        if (Surcharge > 0) {
            totSurcharge = parseFloat(parseFloat(parseFloat(taxAmount) / parseFloat(100)) * parseFloat(Surcharge)).toFixed(2);
            GrandTotal = parseFloat(parseFloat(totAmount) + parseFloat(totSurcharge)).toFixed(2);
            document.getElementById('txtGrandTotal').value = parseFloat(GrandTotal).toFixed(2);
            document.getElementById('txtGrandwithRoundof').value = parseFloat(GrandTotal).toFixed(2);
            document.getElementById('txtNetTotal').value = parseFloat(GrandTotal).toFixed(2);
        }
        else {
            GrandTotal = parseFloat(totAmount).toFixed(2);
            document.getElementById('txtGrandTotal').value = parseFloat(GrandTotal).toFixed(2);
            document.getElementById('txtGrandwithRoundof').value = parseFloat(GrandTotal).toFixed(2);
            document.getElementById('txtNetTotal').value = parseFloat(GrandTotal).toFixed(2);
        
        
        }
    
    }

    function CalRounfOff() {
        // //debugger;
        var GrandwithRoundof = document.getElementById('txtGrandwithRoundof').value;
        var NetTotal = document.getElementById('txtNetTotal').value;

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
            return true;
        }
        else {
            document.getElementById('txtGrandwithRoundof').value = NetTotal;
            document.getElementById('txtRoundOffValue').value = 0.00;
            return true
        }

    }
       
    

//    function CalRounfOff() {
//        var GrandwithRoundof = document.getElementById('txtGrandwithRoundof').value;
//        var NetTotal = document.getElementById('txtNetTotal').value;
//        var RoundOfValue;
//        UPresult = Math.ceil(Number(NetTotal));
//        LOresult = Math.floor(Number(NetTotal));
//        if (UPresult >= GrandwithRoundof && LOresult <= GrandwithRoundof) {

//            if (GrandwithRoundof > NetTotal) {
//                RoundOfValue = Number(GrandwithRoundof) - Number(NetTotal);
//                document.getElementById('hdnRoundofType').value = 'UL';
//            }
//            if (GrandwithRoundof < NetTotal) {
//                RoundOfValue =Number(NetTotal)- Number(GrandwithRoundof);
//                document.getElementById('hdnRoundofType').value = 'LL';
//            }
//            document.getElementById('txtRoundOffValue').value = parseFloat(RoundOfValue).toFixed(2);
//            return true;
//        }
//        else {
//            alert('Provide Correct Rounded-Off Net Total');
//            document.getElementById('txtGrandwithRoundof').value = 0.00;
//            document.getElementById('txtGrandwithRoundof').focus();
//            return false;
//        }
//    }

</script>

