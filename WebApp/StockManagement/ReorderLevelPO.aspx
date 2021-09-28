<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReorderLevelPO.aspx.cs" Inherits="StockManagement_ReorderLevelPO" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>   
</head>
<body>

    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryCommon/WebService/InventoryWebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:HiddenField ID="hdnlocation" runat="server" />
        <asp:HiddenField ID="CtConfig" runat="server" />
        <asp:HiddenField ID="hdnInventoryLocationID" runat="server" />
        <asp:HiddenField ID="hdnToLocationID" runat="server" />
        <asp:HiddenField ID="hdnToOrgID" runat="server" />
        <asp:HiddenField ID="hdnSelectOrgid" runat="server" />
        <asp:HiddenField ID="hdnProductList" runat="server" />
        <asp:HiddenField ID="hdnSelectLocation" runat="server" />
          <asp:HiddenField ID="henExpectedDeliveryDate" runat="server" />
           <asp:HiddenField ID="hdnPOorIndent" runat="server" />
        
        
      
        <div id="raiseIndentDiv" runat="server">
          <table class="w-100p displaytb" runat="server" id="tblProjection">
            <tr>
                <td id="Td1" class="w-20p" runat="server">
                    <asp:Label ID="lablTrusted" Text="Raise Indent To Organization" runat="server" meta:resourcekey="lablTrustedResource1"></asp:Label>
                </td>
                <td>
                    <div>
                        <asp:DropDownList ID="ddlTrustedOrg" CssClass="medium" TabIndex="1" runat="server"
                            OnChange="GetLocationlist();">
                        </asp:DropDownList>
                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblIntentToLoc" Text="Raise Indent To Store" runat="server" meta:resourcekey="lblIntentToLocResource1"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="small" OnChange="locationdetails();">
                    </asp:DropDownList>
                    &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                </td>
            </tr>
            
            <tr>
              <td id="Td9" runat="server">
                                <asp:Label ID="lblExpectedDeliveryDate" runat="server" Text="Expected Delivery Date"
                                    meta:resourcekey="lblExpectedDeliveryDateResource1"></asp:Label>
                            </td>
                            <td id="Td10" runat="server">
                                <asp:TextBox ID="txtDate" runat="server" CssClass="small datePicker" onkeypress="return ValidateSpecialAndNumeric(this);"
                                    meta:resourcekey="txtDateResource1"></asp:TextBox>
                                <%--<ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDate"
                                    Format="dd/MM/yyyy" PopupButtonID="txtDate" Enabled="True" />--%>
                                    <%--end--%>
                            </td>
            </tr>
        </table>
        </div>
        <div id="reOrderLevelDiv">
            <asp:Label ID="lblProductName" Text="ProductName" CssClass="lh30" runat="server"
                meta:resourcekey="lblProductNameResource1"></asp:Label>
            <asp:TextBox ID="txtProductName" onkeypress="return ValidateMultiLangChar(this);" runat="server" CssClass="medium" onkeyup="checkCodes();"
                meta:resourcekey="txtProductNameResource1"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search"
                CssClass="btn pointer" OnClientClick="getReOrderProducts();return false;" meta:resourcekey="btnSearchResource1" />
            <div>
                <table id="tblReOrderLevel" class="w-100p gridView marginB10">
                    <thead class="dataheader1">
                        <tr>
                            <th>
                                <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_01%>
                            </th>
                            <th>
                                <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_02%>
                            </th>
                            <th>
                                <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_03%>
                            </th>
                            <th>
                                <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_04%>
                            </th>
                            <th>
                                <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_05%>
                            </th>
                            <th class="hide">
                                <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_06%>
                            </th>
                            <th>
                                <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_07%>
                            </th>
                            <th>
                                <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_08%>
                            </th>
                            <th>
                                <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_09%>
                            </th>
                            <th>
                                <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_10%>
                            </th>
                            <th class="hide">
                                <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_11%>
                            </th>
                            <th>
                                <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_12%>
                            </th>
                            <th>
                                <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_13%>
                            </th>
                            <th class="w-9p">
                                <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_14%>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div class="a-center">
            <a id="btnClient" runat="server" class="btn hide"  onclick="saveOrderDetails();"><%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevelPO_aspx_16%></a>
                <%--<input type="button" id="btnClient" runat="server" onclick="saveOrderDetails();" value="Save" class="btn hide" />--%>
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="BtnSave_ButtonClick"
                    CssClass="btn pointer hide" meta:resourcekey="btnSaveResource1" />
                    
                    <asp:Button ID="btnRaiseIntend" runat="server" Text="Save Indent" OnClick="btnRaiseIntend_Click"
                    CssClass="btn pointer hide" OnClientClick="return SaveIndent();" meta:resourcekey="btnRaiseIntendResource1" />
            </div>
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hdnOrgID" />
    ;
    <asp:HiddenField runat="server" ID="hdnOrgAddressID" />
    <asp:HiddenField runat="server" ID="hdnLocationID" />
    <asp:HiddenField runat="server" ID="hdnLoginID" />
    <asp:HiddenField runat="server" ID="hdnPurchaseOrderIDS" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>



<script language="javascript" type="text/javascript">
    var ErrorMsg = SListForAppMsg.Get("StockManagement_Error") == null ? "Alert" : SListForAppMsg.Get("StockManagement_Error");
    var infromMsg = SListForAppMsg.Get("StockManagement_Information") == null ? "Information" : SListForAppMsg.Get("StockManagement_Information");
    var OkMsg = SListForAppMsg.Get("StockManagement_Ok") == null ? "Ok" : SListForAppMsg.Get("StockManagement_Ok");
    var CancelMsg = SListForAppMsg.Get("StockManagement_Cancel") == null ? "Cancel" : SListForAppMsg.Get("StockManagement_Cancel");
    </script>
<script type="text/javascript" language="javascript">

    $(document).ready(function() {

        getReOrderProducts();
        var ilocation = "";
    });

    function LoadReOrderTale(reOrderList) {

      
        var rowCount = reOrderList.length;
        if (rowCount > 0) {
            var str = ""
            //            var table = document.getElementById("tblReOrderLevel").getElementsByTagName('tbody')[0];
            var table = document.getElementById("tblReOrderLevel").getElementsByTagName('tbody')[0];
            for (i = 0; i < rowCount; i++) {

                for (i = 0; i < rowCount; i++) {
                    var row = table.insertRow(i);

                    var Description = reOrderList[i]["Description"].split('~');
                    var hdnsuplierID = "<hidden tye='hidden' name='hdnsuplierID' value='" + reOrderList[i]["SupplierId"] + "'>";
                    var hdnQuotationID = "<hidden tye='hidden' name='hdnQuotationID' value='" + Description[1] + "'>";
                    var hdnProductID = "<hidden tye='hidden' name='hdnProductID' value='" + reOrderList[i]["ProductID"] + "'/>";


                    var hdnParentProductID = "<hidden tye='hidden' name='hdnParentProductID' value='" + reOrderList[i]["ParentProductID"] + "'>";
                    var hdnSellingUnit = "<hidden tye='hidden' name='hdnSellingUnit' value='" + reOrderList[i]["Unit"] + "'>";
                    var hdnProductName = "<hidden tye='hidden' name='hdnProductName' value='" + reOrderList[i]["ProductName"] + "'>";

                    var hdnOrderedQuantity = "<hidden tye='hidden' name='hdnOrderedQuantity' value='0'>";

                    

                    //                    cellAdding(row, 0, reOrderList[i]["SupplierName"] + hdnsuplierID + hdnQuotationID, 0);

                    cellAdding(row, 0, reOrderList[i]["SupplierName"], 0);
                    $(row).find("td").eq(0).append(hdnsuplierID);
                    $(row).find("td").eq(0).append(hdnQuotationID);

                    $(row).find("td").eq(0).append(hdnProductID);
                    $(row).find("td").eq(0).append(hdnParentProductID);
                    $(row).find("td").eq(0).append(hdnSellingUnit);
                    $(row).find("td").eq(0).append(hdnProductName);
                    $(row).find("td").eq(0).append(hdnOrderedQuantity);
                    
                    cellAdding(row, 1, reOrderList[i]["CategoryName"], 0);
                    cellAdding(row, 2, reOrderList[i]["ProductName"], 0);
                    cellAdding(row, 3, reOrderList[i]["ProductCode"], 0);
                    cellAdding(row, 4, reOrderList[i]["ReOrderLevel"], 0);
                    cellAdding(row, 5, reOrderList[i]["UsageCount"], 0);
                    $(row).find("td").eq(5).attr("class", "hide");
                    cellAdding(row, 6, reOrderList[i]["InHandQuantity"], 0);
                    cellAdding(row, 7, reOrderList[i]["Unit"], 0);
                    cellAdding(row, 8, reOrderList[i]["Rate"], 0);

                    cellAdding(row, 9, Description[0], 0);

                    cellAdding(row, 10, reOrderList[i]["SellingPrice"], 0);
                    $(row).find("td").eq(10).attr("class", "hide");
                    cellAdding(row, 11, reOrderList[i]["Discount"], 0);
                    cellAdding(row, 12, "0", 1);
                    cellAdding(row, 13, "<input type='checkbox'  id='checkRow' onclick='unSelectRow(this);' />",0);
                }
            }

        }


    }

    function cellAdding(row, cellindex, cellvalue,isAction) {
        var tmpcell = row.insertCell(cellindex);
        tmpcell.innerHTML = cellvalue;
        if (cellindex == 10) {
            //tmpcell.style = "display:none";
            $(tmpcell).removeClass().addClass("class", "hide");
        }
        if (isAction == 1) {
            tmpcell.onclick = function() { editQuantity(this); };
            
        }

    }
    function hideSaveButton() {
       

      var rows = $("#tblReOrderLevel tbody tr")
        var rowsCount = rows.length;

        for (i = 0; i < rowsCount; i++) {
            var check = $(rows).find("[id^='checkRow']").is(":checked");

            if (check == true) {

                if ($("#hdnPOorIndent").val() == "PO") {
                    $("#btnClient").show()
                }
                else {
                    $("#btnRaiseIntend").show()
                }
                break;
            }
            else {
                

                if ($("#hdnPOorIndent").val() == "PO") {
                    $("#btnClient").hide();
                }
                else {
                    $("#btnRaiseIntend").hide();
                }
            }
        }
        return false;
    
    }

    function unSelectRow(obj) {
        var row = $(obj).parent().parent();
        if ($(obj).is(":checked") == false) {
           
            $(row).find("td").eq(12).text("0");
            hideSaveButton();
        }
        else {
//            var userMsg = SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_01") == null ? "Please add quantity" : SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_01");
//            ValidationWindow(userMsg,ErrorMsg)
            //alert("Please add quantity");
            var input = "<input type='text' class='xsmaller' id='txtQty' value='0'  onkeypress='return ValidateOnlyNumeric(this)' onblur='clearEdit(this);'/>";
            $(row).find("td").eq(12).attr("onclick","");
            $(row).find("td").eq(12).html(input);
            $(row).find("[id^='txtQty']").focus();           
          
        }
    }
    function editQuantity(obj) {
        $(obj).removeAttr('onclick');
        var Qty = $(obj).html();
        $(obj).html("<input type='text' class='xsmaller' id='txtQty' value=" + Qty + "  onkeypress='return ValidateOnlyNumeric(this)' onblur='clearEdit(this);'/>")
//        if ($("#hdnPOorIndent").val() == "PO") {
//            $("#btnClient").show();
//        }
//        else {
//            $("#btnRaiseIntend").show();
//        }
        
    }
    function clearEdit(obj) {
        var txtval = $(obj).val();
        var Qty = txtval == "" ? "0" : txtval;
        //        $(obj).parent().html("");

        if (Qty > 0) {
            $(obj).parent().parent().find("[type=checkbox]").prop("checked", "checked")
            $(obj).parent().parent().find("[name=hdnOrderedQuantity]").attr("value", Qty);
        }
        else {
            $(obj).parent().parent().find("[type=checkbox]").prop("checked", "")
            hideSaveButton();
        }
        $(obj).parent().attr("onclick", "editQuantity(this);");
        $(obj).parent().html(Qty);
        hideSaveButton();
    }

    function checkCodes() {
        var tbl = $("#tblReOrderLevel tbody");
        var searchText = $("#txtProductName").val().toLowerCase();
        var isTrue = 1;

        tbl.find("tr").each(function() {
            var tdproductName = $(this).find('td')[1];
            var tdproductCode = $(this).find('td')[2];
            var productName = $(tdproductName).html().toLowerCase();v
            var productCode = $(tdproductCode).html().toLowerCase();

            //            if (productName.toLowerCase().indexOf(searchText.toLowerCase()) > 0 || productCode.toLowerCase().indexOf(searchText.toLowerCase()) > 0) {
            if (productName.indexOf(searchText) !=-1 || productCode.indexOf(searchText)!=-1) {
                $(this).show();
            }            
            else {
                $(this).hide();
            }
        });

    }
    function getReOrderProducts() {
//        var pOrgID = 75, ProductName = $("#txtProductName").val(), OrgAddressID = 255, LocationID = 1;
        var pOrgID = $("#hdnOrgID").val(), ProductName = $("#txtProductName").val(), OrgAddressID = $("#hdnOrgAddressID").val(), LocationID = $("#hdnLocationID").val();
        var dataParameters = '{OrgId:' + pOrgID + ',ProductName:"' + ProductName + '",OrgAddressID:' + OrgAddressID + ',LocationID:' + LocationID + '}';
        $("#tblReOrderLevel tbody").html("");

        $.ajax({
            type: "POST",
            url: "WebService/StockManagement.asmx/GetReorderLevelPurchaseOrder",
            data: dataParameters,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {

                if (response.d.length > 0) {
                    LoadReOrderTale(response.d)
                }
                
            },
            failure: function(response) {
            var userMsg = SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_02") == null ? "failure to Load Supplier details" : SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_02");
                ValidationWindow(userMsg, ErrorMsg);
                //alert("failure to Load Supplier details");

            }
        });

    }

    function saveOrderDetails() {

        var sno = 0;

        var strProductlist = "";
        $('#tblReOrderLevel tbody').find('tr').each(function() {
            if ($(this).find('[type=checkBox]').is(":checked") == true) {
                sno = sno + 1;

                var tempArray = $(this).find("td");
                var supplierName = tempArray.eq(0).text();
                var ProductName = tempArray.eq(2).text();
                var Productid = $(this).find("[name=hdnProductID]").attr("value");

                var supplierid = $(this).find('[name=hdnsuplierID]').attr("value");
                var comments = "";

                var pdate = getDate();
                var quantity = tempArray.eq(12).text();
                var drpunits = tempArray.eq(7).text();

                var Rate = tempArray.eq(8).text();
                var parentproductid = Productid;
                var lsu = drpunits;

                var InvQty = tempArray.eq(9).text();
                var QuotationId = $(this).find('[name=hdnQuotationID]').attr("value");
                var StockinhandQty = "0.00";
                var tolQty = quantity * InvQty;

                strProductlist = strProductlist + sno + "~" + ProductName + "~" + supplierName + "~" + pdate + "~" + quantity + "~" + drpunits + "~" + supplierid + "~" + Productid + "~" + comments + "~" + tolQty + "~" + parentproductid + "~" + lsu + "~" + InvQty + "~" + QuotationId + "~" + StockinhandQty + "~" + Rate + "^";
            }
        });


         saveSupplierList(strProductlist);
    

    }


    function saveSupplierList(strProductlist) {
        var OrgID = $("#hdnOrgID").val();
        var InventoryLocationID = $("#hdnLocationID").val();

        var LID = $("#hdnLoginID").val();
        var ILocationID = $("#hdnOrgAddressID").val();
        var purchaseOrderDate = getDate();
        $.ajax({
            type: "POST",
            url: "WebService/StockManagement.asmx/SaveSupplierProductPurchaseOrder",
            data: '{"OrgID":"' + OrgID + '","ILocationID":"' + ILocationID + '","LID":"' + LID + '","InventoryLocationID":"' + InventoryLocationID + '","strLstProduts":"' + strProductlist + '","purchaseOrderDate":"' + purchaseOrderDate + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                if (response.d != "") {
                    $("#hdnPurchaseOrderIDS").val(response.d);
                    var userMsg = SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_03") == null ? "Purchase orders raised successfully" : SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_03");
                    ValidationWindow(userMsg, ErrorMsg);
                  //  alert("Purchase orders raised successfully");
                    $("#btnSave").click();
                }
            },
            failure: function(response) {
            var userMsg = SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_04") == null ? "Please add quantity" : SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_04");
                ValidationWindow(userMsg, ErrorMsg);
             //   alert("failure to Load Supplier details");

                return false;
            }
        });
    }
    function getDate() {
        var today = new Date();
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

    function isNumber(evt) {
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }



    function GetLocationlist() {
        var drpOrgid = document.getElementById('ddlTrustedOrg').value; //.options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
        document.getElementById('hdnSelectOrgid').value = drpOrgid;
        var options = document.getElementById('hdnlocation').value;
        var ddlLocation = document.getElementById('ddlLocation');
        ddlLocation.options.length = 0;
        var optn1 = document.createElement("option");
        ddlLocation.options.add(optn1);
        var select = SListForAppDisplay.Get("StockManagement_ReorderLevelPO_aspx_15") == null ? "Select" : SListForAppDisplay.Get("StockManagement_ReorderLevelPO_aspx_15")
        optn1.text = select;
        optn1.value = "0";

        var IsDefaultValue = 0;

        var list = options.split('^');
        for (i = 0; i < list.length; i++) {
            if (list[i] != "") {
                var res = list[i].split('~');
                if (drpOrgid == res[0]) {
                    var optn = document.createElement("option");
                    ddlLocation.options.add(optn);
                    optn.text = res[2];
                    optn.value = res[1];
                    if (res[3] == "True") {
                        IsDefaultValue = res[1];
                    }
                }

            }
        }
        ddlLocation.value = IsDefaultValue;


    }

    function locationdetails() {

        var Trustedorgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
        if (Trustedorgid > 0) {

            document.getElementById('hdnSelectOrgid').value = Trustedorgid;
        }

        var Fromlocationid = document.getElementById('ddlLocation').options[document.getElementById('ddlLocation').selectedIndex].value;
        if (Fromlocationid > 0) {
            document.getElementById('hdnSelectLocation').value = Fromlocationid;
        }

//        if (document.getElementById('hdnSelectOrgid').value == document.getElementById('hdnSelectBehalfOfOrgid').value) {
//            if (document.getElementById('hdnSelectLocation').value = document.getElementById('hdnBehalfOfSelectLocation').value) {
//                var userMsg = SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_11') == null ? "Select Different Location name for Raise Indent and On BehalfOf" : SListForAppMsg.Get('StockIntend_RaiseIntend_aspx_11');
//                ValidationWindow(userMsg, ErrMsg);
//                document.getElementById('ddlLocation').focus();
//                return false;
//            }
//        }
//        if (Trustedorgid > 0 && Fromlocationid > 0) {
//            //            var mini = document.getElementById('txtMinimunlife').value == '' ? '0' : document.getElementById('txtMinimunlife').value;
//            var mini = '0'

//            var sval = 'RAC' + '~' + Fromlocationid + '~' + Trustedorgid + '~' + mini;
//            $find('AutoCompleteProduct1').set_contextKey(sval);
//            // $find('AutoCompleteProduct1').set_contextKey(sval);
//        }

    }

    function SaveIndent() {
        if ($("#ddlTrustedOrg").val() == 0) {
            var userMsg = SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_05") == null ? "Please select organization" : SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_05");
            ValidationWindow(userMsg, ErrorMsg);
            //alert("Please select organization");
            return false;
        }
        else if ($("#ddlLocation").val() == "0") {
        var userMsg = SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_06") == null ? "Please select stored" : SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_06");
        ValidationWindow(userMsg, ErrorMsg);
        // alert("Please select stored");
        return false;
        }
        else if ($("#txtDate").val() == "") {
        var userMsg = SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_07") == null ? "Please enter expected delivery date" : SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_07");
        ValidationWindow(userMsg, ErrorMsg);
        // alert("Please enter expected delivery date");
        return false;
        }

else
{
     var hdnProductID;
     var hdnSellingUnit;
     var hdnProductName;
     var hdnOrderedQuantity;
     var hdnParentProductID;
     var tblList = $("#tblReOrderLevel tbody tr");
     var tblstCount = tblList.length;
     var AllProducts = "";
     for (var i = 0; i < tblstCount; i++) {
         if ($(tblList).eq(i).find('[type=checkBox]').is(":checked") == true) {
             hdnProductID = $(tblList).eq(i).find("[name=hdnProductID]").attr("value");

             hdnSellingUnit = $(tblList).eq(i).find("[name=hdnSellingUnit]").attr("value");
             hdnProductName = $(tblList).eq(i).find("[name=hdnProductName]").attr("value");
             hdnOrderedQuantity = $(tblList).eq(i).find("[name=hdnOrderedQuantity]").attr("value");
             hdnParentProductID = $(tblList).eq(i).find("[name=hdnParentProductID]").attr("value");


             AllProducts = AllProducts + hdnProductID + "~" + hdnSellingUnit + "~" + hdnProductName + "~" + hdnOrderedQuantity + "~" + hdnParentProductID + "^";

         }

     }

     if (AllProducts != "") {
         $("#henExpectedDeliveryDate").val($("#txtDate").val());
         $("#hdnProductList").val(AllProducts);
         return true;
     }
     else {
         var userMsg = SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_08") == null ? "Please Select Product" : SListForAppMsg.Get("StockManagement_ReorderLevelPO_aspx_08");
         ValidationWindow(userMsg, ErrorMsg);
         // alert("Please Select Product");
         return false;
     }
 }
    }

</script>


</body>
</html>

