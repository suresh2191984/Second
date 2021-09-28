<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SuplierPurchaseOrder.aspx.cs"
    Inherits="PurchaseOrder_SuplierPurchaseOrder" meta:resourcekey="PageResource1" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>



</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <asp:HiddenField runat="server" ID="hdnProductList" />
                        <asp:HiddenField runat="server" ID="hdnOrgID" />
                        <asp:HiddenField runat="server" ID="hdnInventoryLocaionID" />
                          <asp:HiddenField runat="server" ID="hdnILocationID" />
                          <asp:HiddenField runat="server" ID="hdnLID" />
                          <input type="hidden" runat="server" id="hdnProductId" />
                        <table id="tblProducts" class="gridView w-100p">
                            <thead class="dataheader1">
                                <tr>
                                    <th>
                                        <input name="chkAll" type="checkbox" checked="checked" onchange="checkAll(this);" />
                                    </th>
                                    <th>
                                        <asp:Label ID="lblProduct" Text="Product" runat="server" 
                                            meta:resourcekey="lblProductResource1"></asp:Label>
                                    </th>
                                    <th>
                                        <asp:Label ID="lblSupplier" Text="Supplier" runat="server" 
                                            meta:resourcekey="lblSupplierResource1"></asp:Label>
                                    </th>
                                    <th>
                                        <asp:Label ID="lblUnit" Text="Unit" runat="server" 
                                            meta:resourcekey="lblUnitResource1"></asp:Label>
                                    </th>
                    				<th id="thCostPrice">
                                        <asp:Label ID="lblCostPrice" Text="Cost Price" runat="server" 
                                            meta:resourcekey="lblCostPriceResource1"></asp:Label>
                                    </th>
                    				<th id="thSellingPrice">
                                        <asp:Label ID="lblSellingPrice" Text="Selling Price" runat="server" 
                                            meta:resourcekey="lblSellingPriceResource1"></asp:Label>
                                    </th>
                    				<th id="thDiscount">
                                        <asp:Label ID="lblDiscount" Text="Discount" runat="server" 
                                            meta:resourcekey="lblDiscountResource1"></asp:Label>
                                    </th>
                    				<th id="thTax">
                                        <asp:Label ID="lblTax" Text="Tax" runat="server" 
                                            meta:resourcekey="lblTaxResource1"></asp:Label>
                                    </th>
                    				<th id="thInverseQty">
                                        <asp:Label ID="lblInverseQty" Text="Inverse Qty" runat="server" 
                                             meta:resourcekey="lblInverseQtyResource1"></asp:Label>
                                    </th>
                    				<th id="thStockinhand">
                                        <asp:Label ID="lblStocckInHand" Text="Stocck In Hand" runat="server" 
                                              meta:resourcekey="lblStocckInHandResource1"></asp:Label>
                                    </th>
                                    <th>
                                        <asp:Label ID="lblQuantity" Text="Quantity" runat="server" 
                                            meta:resourcekey="lblQuantityResource1"></asp:Label>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <div class="a-center">
                        <br />
                        <br />
            			<input type="button" value="Save" onclick="saveOrderDetails();" id="btnSave" class="btn" />
            				<%--<asp:Button runat="server" ID="btnSubmit" Text="Submit" class="hide"
                            OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" sathish />--%>
                            </div>
                    </div>
          
        
        <asp:HiddenField runat="server" ID="hdnProductsupplier" />
        <asp:HiddenField runat="server" ID="hdnMessages" />
    	<asp:HiddenField runat="server" ID="hdnQuotationConfig" />
       	<Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>

<script src="../PlatForm/Scripts/linq.min.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
    var supplierArray;
    
    //$("#btnSubmit").hide();
    $(document).ready(function() {
        var quotationConfig = document.getElementById('hdnQuotationConfig').value;
        if (quotationConfig == "Y")
            loadSupplierListQuotation();
//        else
//            loadSupplierList(prdID);
        loadProducts();
    });


    function loadSupplierList(prdID) {
        $.ajax({
            type: "POST",
            url: "../InventoryCommon/WebService/InventoryWebService.asmx/GetSupplierList",
                   data: '{prefixText:"",count:0}',
           // data: '{}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                supplierArray = response.d;
            	loadDropDownList("ddlsupplier" + prdID, supplierArray);
                $("#btnSubmit").show();
            },
            failure: function(response) {
                //alert("failure to Load Supplier details");

            }
        });
    }


    function loadDropDownList(ddlName, arrayvalues) {

        var dropDownList = $("#" + ddlName);
        dropDownList.append($("<option></option>").val("-1").html("---Select Supplier--"));
        $.each(arrayvalues, function(key, value) {
            value = JSON.parse(value);
            dropDownList.append($("<option></option>").val(value.Second).html(value.First));
		//	            dropDownList.append($("<option></option>").val(value.SupplierID).html(value.SupplierName));
        });
    }

    function loadProducts() {
        var productlist = $("#hdnProductList").val();

        var arrayProducts = productlist.split('^');
        $.each(arrayProducts, function(key, value) {

            if (value != "") {
                var arrSubProducts = value.split('~');
                if (arrSubProducts[1] != "") {
                    if (document.getElementById('hdnQuotationConfig').value != 'Y')
                        addProductToTableWithoutQuotation(arrSubProducts[0], arrSubProducts[1],arrSubProducts[2]);
                    else
                    addProductToTable(arrSubProducts[0], arrSubProducts[1]);
                }
            }
        });

    }

    function addProductToTableWithoutQuotation(prdID, ProductName, unit) {
        var productID = prdID, productName = ProductName, rate = "0.00", sellingPrice = "0.00", discount = "0.00", tax = "0.00", quotationID = "", inverseQty = "", handInQty = "0.00", row = "";
        row = rowCreation(productName, productID, unit, rate, sellingPrice, discount, tax, quotationID, inverseQty, handInQty);
        $("#tblProducts tbody").append(row);
        loadSupplierList(prdID);
        

    }

    function addProductToTable(prdID, ProductName) {
        $.ajax({
            type: "POST",
            url: "../InventoryCommon/WebService/InventoryWebService.asmx/GetProductWithSupplierList",
            data: '{productName:"' + ProductName + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                var productID, productName, supplierID = "-1",
                    description, subDescription, row = "",
                    quotationID = "";
                var unit = "",
                    rate = "0.00",
                    handInQty = "0.00",
                    isDefault, inverseQty, sellingPrice = "0.00",
                    discount = "0.00",
                    tax = "0.00";
                productID = prdID;
                productName = ProductName;

                if (response.d.length > 0) {
                    var lstproducts = Enumerable.From(response.d).Where("$.ProductID==" + prdID).ToArray();
                    if (lstproducts.length > 0) {


                        description = lstproducts[0].Description.split('#');
                        subDescription0 = description[0].split('~');
                        supplierID = subDescription0[2];
                        quotationID = subDescription0[7];
                        handInQty = subDescription0[8];

                        subDescription1 = description[1].split('~');
                        isDefault = subDescription1[2];
                        inverseQty = subDescription1[3];
                        unit = isDefault == "Y" ? subDescription1[0] : "-";
                        rate = isDefault == "Y" ? subDescription1[1] : "0.00";

                        sellingPrice = isDefault == "Y" ? subDescription1[5] : "0.00";
                        discount = isDefault == "Y" ? subDescription1[7] : "0.00";
                        tax = isDefault == "Y" ? subDescription1[6] : "0.00";


                        row = rowCreation(productName, productID, unit, rate, sellingPrice, discount, tax, quotationID, inverseQty, handInQty);
                        $("#tblProducts tbody").append(row);
                        loadDropDownList("ddlsupplier" + productID, supplierArray)
                        $("#ddlsupplier" + productID).val(supplierID);
                      //  $("#ddlsupplier").val(supplierID);
                        //$("#ddlsupplier" + productID).attr("disabled", "true")

                    }
                }
                //            else {
                //                 row = rowCreation(productName, productID, unit, rate, sellingPrice, discount, tax);
                //            }




            },
            failure: function(response) {
                //alert("failure to Load Supplier details");

            }
        });

    }

    function rowCreation(productName, productID, unit, rate, sellingPrice, discount, tax, quotationID, inverseQty, handInQty) {
        var c = "displaytd";
        if ($('#hdnQuotationConfig').val() != "Y") {
            $('#thCostPrice').hide();
            $('#thSellingPrice').hide();
            $('#thDiscount').hide();
            $('#thTax').hide();
            $('#thInverseQty').hide();
            $('#thStockinhand').hide();             
            c = "hide";
        }
        var str = "<tr>";
        var chkbox = "<input name='chkBox' type='checkbox' checked='checked' onchange='checkAll(this);'/>";
        str = str + "<td>" + chkbox + "</td>";
        var hdnProductID = "<input type='hidden' name='hdnProductID' value='" + productID + "'>";
        var productName = "<span name='spnproductName'>" + productName + "</span>";
        str = str + "<td>" + productName + hdnProductID + "</td>";

        var quotationID = "<input type='hidden' name='hdnquotationID' value='" + quotationID + "'>";

        var ddlsupplier = "<select name='ddlsupplier' id='ddlsupplier" + productID + "' onchange='GetSupplierdetails(this);'></select>";
        str = str + "<td>" + ddlsupplier + quotationID + "</td>";
        var spnUnit = "<span name='spnUnit'>" + unit + "</span>";
        str = str + "<td>" + spnUnit + "</td>";
        var spnrate = "<span name='spnrate'>" + rate + "</span>";
        str = str + "<td class='" + c + "'>" + spnrate + "</td>";
        var spnsellingPrice = "<span name='spnsellingPrice'>" + sellingPrice + "</span>";
        str = str + "<td class='" + c + "'>" + spnsellingPrice + "</td>";
        var spndiscount = "<span name='spndiscount'>" + discount + "</span>";
        str = str + "<td class='" + c + "'>" + spndiscount + "</td>";
        var spntax = "<span name='spntax'>" + tax + "</span>";
        str = str + "<td class='" + c + "'>" + spntax + "</td>";
        var spninverseQty = "<span name='spninverseQty'>" + inverseQty + "</span>";
        str = str + "<td class='" + c + "'>" + spninverseQty + "</td>";

        var spnHandInQty = "<span name='spninverseQty'>" + handInQty + "</span>";
        str = str + "<td class='" + c + "'>" + spnHandInQty + "</td>";


        str = str + "<td><input type='text' name='spnquantity' onkeypress='return isNumberKey(event);'  maxlength='10'></td>";
        str = str + "</tr>";
        return str;
    }

    function GetSupplierdetails(obj) {
        var orgID = 0,
            SupID = 0,
            QuotationID = 0,
            QuotationNo = "0",
            LocationID = 0,
            productID;
        var unit = "",
            rate = "0.00",
            sellingPrice = "0.00",
            discount = "0.00",
            tax = "0.00";
        SupID = $(obj).val();
        var row = $(obj).parent().parent();
        productID = row.find('input[name=ProductID]').val();


        if (SupID != "-1") {
            orgID = $("#hdnOrgID").val();
            LocationID = $("#hdnInventoryLocaionID").val();
            $.ajax({
                type: "POST",
                url: "../InventoryCommon/WebService/InventoryWebService.asmx/GetSupplierMappedWithProducts",
                //        data: '{prefixText:"",count:0}',
                data: '{orgID:"' + orgID + '",SupID:"' + SupID + '",QuotationID:"' + QuotationID + '",QuotationNo:"' + QuotationNo + '",LocationID:"' + LocationID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {

                    var lstproducts = Enumerable.From(response.d).Where("$.ProductID==" + productID).ToArray();
                    if (lstproducts.length > 0) {


                        var productdetails = lstproducts[0].Description.split("^");
                        var subProductdetails = productdetails[1].split("~");
                        unit = subProductdetails[0];
                        rate = subProductdetails[1];
                        sellingPrice = subProductdetails[5];

                        tax = subProductdetails[7];
                        discount = subProductdetails[8].split('#')[0];
                        row.find('span[name=spnUnit]').text(unit);
                        row.find('span[name=spnrate]').text(rate);
                        row.find('span[name=spnsellingPrice]').text(sellingPrice);
                        row.find('span[name=spndiscount]').text(discount);
                        row.find('span[name=spntax]').text(tax);
                    } else {

                        alert("Supplier does not supply this product. Please choose some other supplier");
                        $(obj).val("-1");
                    }
                },
                failure: function(response) {
                   // alert("failure to Load Supplier details");

                }
            });
        } 
        else {
            row.find('span[name=spnUnit]').text(unit);
            row.find('span[name=spnrate]').text(rate);
            row.find('span[name=spnsellingPrice]').text(sellingPrice);
            row.find('span[name=spndiscount]').text(discount);
            row.find('span[name=spntax]').text(tax);
        }

    }

    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }

    function checkAll(obj) {

        var status = $(obj).is(":checked");

        if ($(obj).attr("name") == "chkAll") {
            if (status == true) {

                $('[name=chkBox]').attr("checked", "checked");
            } else {
                $('[name=chkBox]').removeAttr("checked");
            }
        } else {

            var i = 0;

            var tblproducts = $("#tblProducts tbody");
            var noOfRows = $(tblproducts).find("tr").length

            $(tblproducts).find('tr').each(function() {
                if ($(this).find('[name=chkBox]').is(":checked") == true) {
                    i = i + 1;
                }

            });
            if (noOfRows == i) {
                $('[name=chkAll]').attr("checked", "checked");
            } else {
                $('[name=chkAll]').removeAttr("checked");
            }
        }
    }

    function saveOrderDetails() {
        var tblproducts = $("#tblProducts tbody");

        var msg = "Please select Items to save";
        var IsSupplierMsg = "";
        $(tblproducts).find('tr').each(function() {
            if ($(this).find('[name=chkBox]').is(":checked") == true) {
                msg = "";
            }
            if ($(this).find('[name=chkBox]').is(":checked") == true && $(this).find('[name=spnquantity]').val() == "") {
                msg = "Please enter quantity for selected items";
            }
            if ($(this).find('[name=ddlsupplier]').val() == "-1") {
                IsSupplierMsg = "Please Select the Supplier";
            }


        });
        if (msg != "") {
            alert(msg);
            return false;
        }
        else if (IsSupplierMsg != "") {
            alert(IsSupplierMsg);
            return false;
        }
        else {
            var sno = 0;

            var strProductlist = "";
            $(tblproducts).find('tr').each(function() {
                if ($(this).find('[name=chkBox]').is(":checked") == true) {
                    sno = sno + 1;


                    var ProductName = $(this).find("[name=spnproductName]").text();
                    var Productid = $(this).find("[name=hdnProductID]").val();
                    var suppliername = $(this).find('[name=ddlsupplier] option:selected').text();
                    var supplierid = $(this).find('[name=ddlsupplier]').val();
                    var comments = "";
                    
                    var pdate = getDate();
                    var quantity = $(this).find("[name=spnquantity]").val();
                    var drpunits = $(this).find("[name=spnUnit]").text();

                    var parentproductid = Productid;
                    var lsu = $(this).find("[name=spnUnit]").text();

                    var InvQty = $(this).find("[name=spninverseQty]").text();
                    var QuotationId = $(this).find('[name=hdnquotationID]').val();
                    var StockinhandQty = "0.00";
                    var tolQty = quantity * InvQty;
                    strProductlist = strProductlist + sno + "~" + ProductName + "~" + suppliername + "~" + pdate + "~" + quantity + "~" + drpunits + "~" + supplierid + "~" + Productid + "~" + comments + "~" + tolQty + "~" + parentproductid + "~" + lsu + "~" + InvQty + "~" + QuotationId + "~" + StockinhandQty + "^";
                }
            });
        
            saveSupplierList(strProductlist);
        }
    }


    function saveSupplierList(strProductlist) {
        var OrgID = $("#hdnOrgID").val();
        var InventoryLocationID = $("#hdnInventoryLocaionID").val();

        var LID = $("#hdnInventoryLocaionID").val();
        var ILocationID = $("#hdnILocationID").val();
        var purchaseOrderDate = "16/05/2015";
        $.ajax({
            type: "POST",
            url: "../InventoryCommon/WebService/InventoryWebService.asmx/SaveSupplierProductPurchaseOrder",
            data: '{OrgID:"' + OrgID + '",ILocationID:"' + ILocationID + '",LID:"' + LID + '",InventoryLocationID:"' + InventoryLocationID + '",strLstProduts:"' + strProductlist + '",purchaseOrderDate:"' + purchaseOrderDate + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                if (response.d == 1) {
                    alert("Purchase orders raised successfully");
                    window.location.href = '../StockManagement/Reorderlevel.aspx';

                }
            },
            failure: function(response) {
                alert("failure to Load Supplier details");

            }
        });
    }
    function getDate() {
        var today = GetServerDate();
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!

        var yyyy = today.getFullYear();
        if (dd < 10) {
            dd = '0' + dd
        }
        if (mm < 10) {
            mm = '0' + mm
        }
        var today = dd + '/' + mm + '/' + yyyy;
        return today;
    }
    function loadSupplierListQuotation() {
        $.ajax({
            type: "POST",
            url: "../InventoryCommon/WebService/InventoryWebService.asmx/GetSupplierList",
            data: '{prefixText:"",count:0}',
            // data: '{}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                supplierArray = response.d;
            },
            failure: function(response) {
                //alert("failure to Load Supplier details");

            }
        });
    }

</script>
