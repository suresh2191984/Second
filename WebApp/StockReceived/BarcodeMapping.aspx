<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BarcodeMapping.aspx.cs" Inherits="StockReceived_BarcodeMapping"
    meta:resourcekey="PageResource2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Stock Received</title>
    <%--<link href="../PlatForm/StyleSheets/style.css" rel="stylesheet" type="text/css" />

    <script src="../PlatForm/Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>--%>
     
   

    <script language="javascript" type="text/javascript">

        function CallPrint() {
            var prtContent = document.getElementById('divReceived');
            var WinPrint =
                        window.open('', '', 'letf=0,top=0,right=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
        function AutoBarcode() {
            var strRecdQty = SListForAppDisplay.Get("StockReceived_BarcodeMapping_aspx_16") != null ? SListForAppDisplay.Get("StockReceived_BarcodeMapping_aspx_16") : "Received Quantity:";
            if ($("#chkAutoBarcode").is(':checked')) {
                var strBarcode = SListForAppDisplay.Get("StockReceived_BarcodeMapping_aspx_15") != null ? SListForAppDisplay.Get("StockReceived_BarcodeMapping_aspx_15") : "Barcode:";
                $("#lblReceivedQty").text(strBarcode);
                $("#txtStartNo").val('');
                $("#txtEndNo").val('');
                $("#txtReceivedQty").val('');
                $("#tdStartNo").css('visibility', 'hidden');
                $("#tdEndNo").css('visibility', 'hidden');
                $("#tdGenerateBarcode").css('visibility', 'hidden');
                $("#txtReceivedQty").focus();

            }
            else {
                $("#lblReceivedQty").text(strRecdQty);
                $("#tdStartNo").css('visibility', 'visible');
                $("#tdEndNo").css('visibility', 'visible');
                $("#tdGenerateBarcode").css('visibility', 'visible');
                onChangeProductList();
            } 
        }
        function GenerateBarcode() 
        {
            var StockReceivedDetailsId = document.getElementById('ddlProductList').value;
            var ddlProductList = document.getElementById("ddlProductList");
            var ddlProductName = ddlProductList.options[ddlProductList.selectedIndex].text;
            var txtReceivedQty = document.getElementById('txtReceivedQty').value;
            var txtStartNo = document.getElementById('txtStartNo').value;
            var txtEndNo = document.getElementById('txtEndNo').value;
            var productDetails = document.getElementById('hdnProductDet').value;
            var prdDet = productDetails.split(',');
            var ProductId = prdDet[0];
            var ProductKey = prdDet[1];
            var UnitSize = prdDet[2];
            var Unit = prdDet[3];
            var Barcode = $("#txtReceivedQty").val();            
            
            if ($("#chkAutoBarcode").is(':checked')) 
            {
                if ($("#ddlProductList").val() == "0") 
                {
                    var UserMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_01") == null ? "Please select Product Name" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_01");
                    ValidationWindow(UserMsg, ErrorMsg);
                    return false;
                }
                

                if (txtReceivedQty == "") {
                    var UserMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_13") == null ? "Please Scan the Barcode" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_13");
                    ValidationWindow(UserMsg, ErrorMsg);                    
                    return false;

                }
                for (var i = 0; i <= $("#tblBarcodeMapping tbody tr").length; i++) 
                {
                    var ExistBarcode = $($("#tblBarcodeMapping tbody tr")[i]).find("[name='spnBarcode']").html();                   
                    if (Barcode == ExistBarcode) 
                   {
                     var UserMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_08") == null ? "Barcode Range already exists" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_08");
                     ValidationWindow(UserMsg, ErrorMsg);
                     return false;
                 }
             }
               var id = $("#tblBarcodeMapping tbody tr").length + 1;             
                var str = "";
                str = str + "<tr id=row" + id + ">";
                    str = str + "<td class='hide'>" + createspan("spnProductId", ProductId) + "</td>";
                str = str + "<td>" + createspan("spnProductName", ddlProductName) + "</td>";
                str = str + "<td onclick='editCell(this);' >" + createspan("spnBarcode", Barcode) + "</td>";
                    str = str + "<td  class='hide'>" + createspan("spnProductKey", ProductKey) + "</td>";
                    str = str + "<td class='hide'>" + createspan("spnUnitSize", UnitSize) + "</td>";
                    str = str + "<td>" + createspan("spnUnit", Unit) + "</td>";
                    str = str + "<td class='hide'>" + createspan("spnStockReceivedDetailsId", StockReceivedDetailsId) + "</td>";
                    str = str + "<td> <input id=row" + id + " onclick='fndelete(id);' type='button' class='ui-icon ui-icon-trash b-none pointerm pull-left'  /></td>";
                    str = str + "</tr>";
                    $("#tblBarcodeMapping tbody").append(str);
                    $('#txtReceivedQty').val("");
                    $('#txtStartNo').val("");
                    $('#txtEndNo').val("");
                    $('#txtReceivedQty').focus();
                    return false;
                }
            }
    </script>

    <script language="javascript" type="text/javascript">



function checkEists(rowindex, newBarcode) {
	var barcode = $("#tblBarcodeMapping tbody tr");
	var Exists=false;
	for (var i = 0; i < barcode.length; i++) {
		if (i !== rowindex) {
		    var ExistingBarcode = $(barcode).eq(i).find("[name=spnBarcode]").text();
			if (ExistingBarcode == newBarcode) {
				Exists=true;
				break;
			}
		}
	}
	return Exists;
}

        function editCell(obj) {
            $(obj).removeAttr('onclick');
            var barcode = $(obj).parent().find("[name=spnBarcode]").text();
            $(obj).html("<input type='text' class='xsmaller'  id='txtBarcode' value=" + barcode + " onblur='clearEdit(this);'/>")
            

        }


        function clearEdit(obj) {
            var txtval = $(obj).val();
            var rowIndex = $(obj).parent().parent().index();
            var userMsg = SListForAppDisplay.Get("StockReceived_BarcodeMapping_aspx_16") == null ? "Barcode Already Exists. Please Enter Valid barcode" : SListForAppDisplay.Get("StockReceived_BarcodeMapping_aspx_16");
            if (checkEists(rowIndex, txtval) == true) {
                ValidationWindow(userMsg, ErrorMsg);
            }
            
            else
            {
            
            var barcode = txtval == "" ? "0" : txtval;
            //            $(obj).parent().empty();
            $(obj).parent().attr("onclick", "editCell(this);");
            $(obj).parent().html(createspan("spnBarcode", barcode));
           }
            
        }

        function ItemBarcodeCreateTable(obj) {
        
            var StockReceivedDetailsId = document.getElementById('ddlProductList').value;
             var ddlProductList = document.getElementById("ddlProductList");
             var ddlProductName = ddlProductList.options[ddlProductList.selectedIndex].text;
             var txtReceivedQty = document.getElementById('txtReceivedQty').value;
             var txtStartNo = document.getElementById('txtStartNo').value;
             var txtEndNo = document.getElementById('txtEndNo').value;
             var productDetails = document.getElementById('hdnProductDet').value;

             var prdDet = productDetails.split(',');
             var ProductId = prdDet[0];
             var ProductKey = prdDet[1];
             var UnitSize = prdDet[2];
             var Unit = prdDet[3];
           //  var StockReceivedDetailsId = 5;
           

             if (ddlProductName == "0") {
                 var userMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_01") == null ? "Please select Product Name" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_01");
                 ValidationWindow(userMsg, ErrorMsg);
                
                return false;
            }
            if (txtReceivedQty == "") {
                var userMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_02") == null ? "Please Enter Received Quantity" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_02");
                ValidationWindow(userMsg, ErrorMsg);
                return false;
            }
            if (txtStartNo == "") {
                var userMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_03") == null ? "Please Enter Start No" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_03");
                ValidationWindow(userMsg, ErrorMsg);
                return false;
            }
            if (txtEndNo == "") {
                var userMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_04") == null ? "Please Enter End No" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_04");
                ValidationWindow(userMsg, ErrorMsg);
              
                return false;
            }

            if (ddlProductName != "0") {
                if (txtReceivedQty != "" && txtStartNo != "" && txtEndNo != "") {

                    if (parseInt(txtStartNo) > parseInt(txtEndNo)) {
                        var userMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_05") == null ? "Entered Barcode startno cannot be more than end no" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_05");
                        ValidationWindow(userMsg, ErrorMsg);
                        
                        return false;
                    }

                    if (txtStartNo == "1") {
                        if (txtReceivedQty != txtEndNo) {
                            var userMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_06") == null ? "Entered Barcode endno is not in range" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_06");
                            ValidationWindow(userMsg, ErrorMsg);
                            return false;
                        }
                    }

                    if (txtStartNo != "1") {
                        var count = 0;
                        for (var i = parseInt(txtStartNo); i <= parseInt(txtEndNo); i++) {
                            count = count +1;
                        }
                          // var BarcodeRange = txtEndNo - txtStartNo;
                        if ( parseInt(txtReceivedQty) != count) {
                            var userMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_07") == null ? "Entered Barcode startno and endno is not in range" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_07");
                            ValidationWindow(userMsg, ErrorMsg);
                            return false;
                        }
                    }        
                    
                   
                }
            }


            var firstNumber = document.getElementById('txtStartNo').value;
            var secondNumer = document.getElementById('txtEndNo').value;
            var rows = $("#tblBarcodeMapping tbody tr");
            var rowcount = rows.length;
            var chekexist = 0;
            for (i = 0; i < rowcount; i++) {

                var currentrowvalue = $(rows).find("td").eq(2).text();
                if (currentrowvalue >= firstNumber && currentrowvalue <= secondNumer) {
                    var userMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_08") == null ? "Barcode Range already exists" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_08");
                    ValidationWindow(userMsg, ErrorMsg);
                    break;

                }

            }


            $.ajax({
                type: "POST",
                url: '../StockReceived/WebService/StockReceivedService.asmx/CheckbarcodeDuplicate',
                contentType: "application/json",
                data: '{"StartId": ' + firstNumber + ',"EndId": ' + secondNumer + ' }',
                dataType: "json",
                success: function(result) {
                    // if ((result.d).length > 0) {
                    if (result.d == 1) {
                    var userMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_09") == null ? "Barcode is not in range" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_09");
                    ValidationWindow(userMsg, ErrorMsg);
                    }
                    else {
                        var chDuplicate = false;
                        chDuplicate = checkDuplicate(ddlProductName);

                        if (chDuplicate == true) {
                var userMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_10") == null ? "Product already exists" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_10");
                ValidationWindow(userMsg, ErrorMsg);
                        }
                        else {
                            var str = "";
                            for (i = parseInt(txtStartNo); i <= parseInt(txtEndNo); i++) {
                                str = str + "<tr id=row" + i + ">";
                                str = str + "<td class='hide'>" + createspan("spnProductId", ProductId) + "</td>";
                                str = str + "<td>" + createspan("spnProductName", ddlProductName) + "</td>";
                                str = str + "<td onclick='editCell(this);' >" + createspan("spnBarcode", i) + "</td>";
                                str = str + "<td  class='hide'>" + createspan("spnProductKey", ProductKey) + "</td>";
                                str = str + "<td class='hide'>" + createspan("spnUnitSize", UnitSize) + "</td>";
                                str = str + "<td>" + createspan("spnUnit", Unit) + "</td>";
                                str = str + "<td class='hide'>" + createspan("spnStockReceivedDetailsId", StockReceivedDetailsId) + "</td>";
                                str = str + "<td> <input id=row" + i + " onclick='fndelete(id);' type='button' class='ui-icon ui-icon-trash b-none pointerm pull-left'  /></td>";
                                str = str + "</tr>";
                            }
                            $("#tblBarcodeMapping tbody").append(str);
                            clearItemGeneration();
                        }
                    }

                }
            });
            return false;


        }

       
        function checkDuplicate(newProduct) {

            var i = 0;
            $("#tblBarcodeMapping tbody tr").each(function() {

                var proudctName = $(this).find("[name='spnProductName']").text();
                if (proudctName == newProduct) {
                    i++;
                }
            });
            if (i == 0) {
                return false;
            }
            else {
                return true;
            }

        }
        
        

        function createspan(controlName, value) {
            return "<span name='" + controlName + "'>" + value + "</span>";

        }

        function UploadData(obj) {
       
            var ReceivedProductList = $("#tblBarcodeMapping tbody tr");
            var RecrowCount = ReceivedProductList.length;
            if (RecrowCount > 0) {
                var BarcodeMapping = new Array();
                //start
                var rowcount = $("#tblBarcodeMapping")[0].rows.length;
                if ($("#tblBarcodeMapping")[0].rows.length > 1) {
                    var lstItmes = [];
                    $("#tblBarcodeMapping tbody tr").each(function() {

                        var ProductId = $(this).find("[name='spnProductId']").text();
                        var ProductKey = $(this).find("[name='spnProductKey']").text();
                        var Barcode = $(this).find("[name='spnBarcode']").text();
                        var UnitSize = $(this).find("[name='spnUnitSize']").text();
                        var Unit = $(this).find("[name='spnUnit']").text();
                        var StockReceivedDetailsId = $(this).find("[name='spnStockReceivedDetailsId']").text();

                    BarcodeMapping.push(getObject(ProductId, ProductKey, Barcode, UnitSize, Unit, StockReceivedDetailsId))

                });

            }
            var jdata = {};
            jdata.lstBarcodeMapping = BarcodeMapping;
                if (taskForApproval() == true) {
                    jdata.PurchaseOrderTask = "1";
                }
                else {
                    jdata.PurchaseOrderTask = "0";
                }
                jdata.StockReceivedNo = $("#lblReceivedID").html()==""?"0":$("#lblReceivedID").html();
                jdata.SupplierName = $("#lblVendorName").html() == "" ? "0" : $("#lblVendorName").html();
                jdata.CurrrentTaskID = $("#hdnCurrrentTaskID").val() == "" ? "0" : $("#hdnCurrrentTaskID").val();
                jdata.StockReceivedID = $("#hdnStockReceivedID").val() == "" ? "0" : $("#hdnStockReceivedID").val();

            $.ajax({
                type: "POST",
                url: '../StockReceived/WebService/StockReceivedService.asmx/InsertBarcodeMapping',
                contentType: "application/json",
                data: JSON.stringify(jdata),
                dataType: "json",
                success: function(result) {
                        var userMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_11") == null ? "Barcode Inserted Successfully" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_11");
                        ValidationWindow(userMsg, ErrorMsg);
                    if ((result.d).length > 0) {
                        $.each(result.d, function(key, value) {
                            alert(result.d);
                            
                        });
                    }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError);
                }
            });

                

            return false;
            }
            else {
                var userMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_17") == null ? "There is no item to generate Barcode" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_17");
                ValidationWindow(userMsg, ErrorMsg);
                return false;
            }
   }

 function getObject(ProductId, ProductKey, Barcode, UnitSize, Unit,StockReceivedDetailsId)
{
    var objProduct = new Object();
    objProduct["ProductId"]=ProductId;
    objProduct["ProductKey"]=ProductKey;
    objProduct["Barcode"]=Barcode;
    objProduct["UnitSize"]=UnitSize;
    objProduct["Unit"] = Unit;
    objProduct["StockReceivedDetailsId"] = StockReceivedDetailsId;
    return objProduct;
}

function onChangeProductList() {

    var stockReceiveid = $('#ddlProductList').val();
    if (stockReceiveid != "0") {
    $('#txtReceivedQty').focus();  
        if ($("#ddlProductList").val() != "0") {
        if ($("#hdnddlPro").val() != "" && !$("#chkAutoBarcode").is(':checked')) {
            var ddlList = $("#hdnddlPro").val().split("#");
            for (var i = 0; i < ddlList.length; i++) {
                if (ddlList[i].split('~')[0] == $("#ddlProductList option:selected").text()) {
                    $("#txtReceivedQty").val(ddlList[i].split('~')[1]);
                    getLastBarcode();
                    GenerateBarcode();
                }
            }
        }
    }
    else {
        $("#txtReceivedQty").val('');
    }
    if (stockReceiveid != "0") {
        //
        var ProductDetails = document.getElementById('hdnProductDet');
        $.ajax({
            type: "POST",
            url: '../StockReceived/WebService/StockReceivedService.asmx/GetproductDetailsById',
            contentType: "application/json",
            data: '{"stockReceivedid": ' + stockReceiveid + ' }',
            dataType: "json",
            success: function(result) {
               // if ((result.d).length > 0) {
                    ProductDetails.value = result.d;
                   // alert(ProductDetails.value);
               // }
            }
        });
    }
    }
    else {
        document.getElementById('txtStartNo').value = "";
        document.getElementById('txtEndNo').value = "";
        document.getElementById('txtReceivedQty').value = "0";
    }
}

function getLastBarcode() 
{

    if ($("#chkAutoBarcode").is(':checked') == false) {
        var ReceiveQty = document.getElementById('txtReceivedQty').value;
        if ($("#tblBarcodeMapping tbody tr").length > 0) {
            var StartBarcode = getMaxBarCode();
            document.getElementById('txtStartNo').value = parseInt(StartBarcode) + 1;
            document.getElementById('txtEndNo').value = parseInt(StartBarcode) + parseInt(ReceiveQty);

        }
        else {

        
        var StartBarcode;
        var EndBarcode;
        if (ReceiveQty.length > 0) {

            $.ajax({
                type: "POST",
                url: "../StockReceived/WebService/StockReceivedService.asmx/getLastBarcode",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {
                    StartBarcode = data.d;

                    document.getElementById('txtStartNo').value = parseInt(StartBarcode) + 1;
                    document.getElementById('txtEndNo').value = parseInt(StartBarcode) + parseInt(ReceiveQty);

                },
                error: function(xhr, ajaxOptions, thrownError) {

                    return false;
                }
            });
        }

        }
    }
}


function getMaxBarCode() {

    var barCodeList = [];
    var barcode = $("#tblBarcodeMapping tbody tr");
    var Exists = false;
    for (var i = 0; i < barcode.length; i++) {
        var ExistingBarcode = $(barcode).eq(i).find("[name=spnBarcode]").text();
        barCodeList.push(ExistingBarcode);
    }
    var maxValue = Math.max.apply(Math, barCodeList);
    return maxValue;
}

function clearItemGeneration() {
    $('#txtReceivedQty').val("");
    $('#txtStartNo').val("");
    $('#txtEndNo').val("");
    $('#ddlProductList').val("0")
}

function taskForApproval() {
    var ReturnApproveState = false;
    var orderedProductList = $("#grdResult tbody tr");
    var rowCount = orderedProductList.length;
    var Orderedproducts = [];
    for (var i = 0; i < rowCount; i++) {
        if (i != 0) {
            var productid = $(orderedProductList).eq(i).find("[id$=hdnProductID]").val();
            var Qty = $(orderedProductList).eq(i).find("[id$=hdnRecQuantity]").val();
            var productExists = false;
            var listLength = Orderedproducts.length;
            if (listLength > 0) {
                for (j = 0; j < listLength; j++) {
                    if (Orderedproducts[j].productid == productid) {
                        productExists == true;
                        Orderedproducts[j].Qty = Orderedproducts[j].Qty + Qty;
                    }
                }
            }
            if (productExists == false) {

                Orderedproducts.push({ "productid": productid, "Qty": Qty });
            }
        }
    }
    var ReceivedProductList = $("#tblBarcodeMapping tbody tr");
    var RecrowCount = ReceivedProductList.length;
    var BarCodeGeneratedproducts = [];
    for (var i = 0; i < RecrowCount; i++) {
        var productid = $(ReceivedProductList).eq(i).find("[name=spnProductId]").html()
        var listLength = BarCodeGeneratedproducts.length;
        var productExists = false;
        if (listLength > 0) {
            for (j = 0; j < listLength; j++) {
                if (BarCodeGeneratedproducts[j].productid == productid) {
                    productExists = true;
                    BarCodeGeneratedproducts[j].Qty = BarCodeGeneratedproducts[j].Qty + 1;
                }
            }
        }
        if (productExists == false) {
            BarCodeGeneratedproducts.push({ "productid": productid, "Qty": 1 });
        }
    }
    var OrderedproductsLength = Orderedproducts.length;
    var BarCodeProductLength = BarCodeGeneratedproducts.length;
    var ApprovalTask = true;
    if (OrderedproductsLength == BarCodeProductLength) {
        for (i = 0; i < OrderedproductsLength; i++) {
            var CheckQuantity = true;
            var productExists = false;
            for (j = 0; j < BarCodeProductLength; j++) {
                if (Orderedproducts[i].productid = BarCodeGeneratedproducts[j].productid) {
                    productExists = true;
                    if (Orderedproducts[i].Qty = BarCodeGeneratedproducts[j].Qty) {
                        CheckQuantity == true;                        
                    }
                    else {
                        CheckQuantity = false;
                        break;
                    }
                }
            }
            if (CheckQuantity == false || productExists == false) {
                ApprovalTask = false;
                break;
            }
        }
        if (ApprovalTask == true) {
            //Task Code
            ReturnApproveState = true;
        }
    }
   return ReturnApproveState;
}

function fndelete(id) {
    $("#" + id).remove();
}
    </script>

    <style type="text/css">
        #tblAmountDetails td
        {
            padding: 3px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
       <script language="javascript" type="text/javascript">
           var ErrorMsg = SListForAppMsg.Get("StockReceived_Error") == null ? "Error" : SListForAppMsg.Get("StockReceived_Error");
           var infromMsg = SListForAppMsg.Get("StockReceived_Information") == null ? "Information" : SListForAppMsg.Get("StockReceived_Information");
           var OkMsg = SListForAppMsg.Get("StockReceived_Ok") == null ? "Ok" : SListForAppMsg.Get("StockReceived_Ok");
           var CancelMsg = SListForAppMsg.Get("StockReceived_Cancel") == null ? "Cancel" : SListForAppMsg.Get("StockReceived_Cancel");
    </script>
    <div class="contentdata">
        <div id="divReceived">
            <table class="w-100p">
                <tr>
                    <td class="a-center bold" colspan="2">
                        <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_StockReceived%> --%>
                        <asp:Label ID="lblStockReceived" runat="server" Text="StockReceived" meta:resourcekey="lblStockReceivedResource2"></asp:Label>
                    </td>
                </tr>
              
            </table>
            <table class="w-100p">
                <tr>
                    <td class="w-15">
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <asp:HiddenField ID="hdnIsResdCalc" runat="server" />
                                    <table>
                                          <tr>
                                                <td>
                                                <%=Resources.StockReceived_ClientDisplay.StockReceived_BarcodeMapping_aspx_01%>
                                                    <asp:Label ID="lblVendorName" CssClass="bold font11" 
                                                        runat="server" meta:resourcekey="lblVendorNameResource2"></asp:Label>
                                                </td>
                                            </tr>                                       
                                           <tr>
                                                <td class="a-left w-40p">
                                                    <asp:Label ID="lblDate" runat="server" Text="Date" 
                                                        meta:resourcekey="lblDateResource2"></asp:Label>
                                                 </td>
                                                <td class="w-1p">:</td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblSRDate" runat="server" meta:resourcekey="lblSRDateResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblPONo" runat="server" Text="P.O No" 
                                                        meta:resourcekey="lblPONoResource2"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblPOID" runat="server" meta:resourcekey="lblPOIDResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblReceivedNo" runat="server" Text="Received No" 
                                                        meta:resourcekey="lblReceivedNoResource2"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblReceivedID" runat="server" 
                                                        meta:resourcekey="lblReceivedIDResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblInvoiceNotxt" Text="Invoice No" runat="server" 
                                                        meta:resourcekey="lblInvoiceNotxtResource2"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblInvoiceNo" runat="server" 
                                                        meta:resourcekey="lblInvoiceNoResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="Label1" Text="DC No" runat="server" 
                                                        meta:resourcekey="Label1Resource2"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblDCNo" runat="server" 
                                                        meta:resourcekey="lblDCNoResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblStatustxt" runat="server" Text="Status" 
                                                        meta:resourcekey="lblStatustxtResource2"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td class="a-left">
                                                    <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource2"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="w-20">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                    </table>
                                </td>
                                <td class="w-50p">
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:GridView EmptyDataText="No matching records found " ID="grdResult" runat="server"
                                                    AutoGenerateColumns="False" OnRowDataBound="grdResult_RowDataBound" class="gridView w-100p"
                                                    meta:resourcekey="grdResultResource2">
                                                    <Columns>
                                                        <asp:BoundField HeaderText="Product" DataField="ProductName" meta:resourcekey="BoundFieldResource10" />
                                                        <asp:BoundField HeaderText="Batch No" DataField="BatchNo" meta:resourcekey="BoundFieldResource11" />
														 <asp:TemplateField HeaderText="Rcvd Qty" >
                                                            <ItemTemplate>
                          <asp:HiddenField ID="hdnProductID" runat="server" Value='<%# Eval("ProductID") %>' />
                          <asp:HiddenField ID="hdnRecQuantity" runat="server" Value='<%# Eval("RECQuantity") %>' />
                                                                <%# Eval("RECQuantity")%>
                                                                (<%# Eval("RECUnit")%>)
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Rcvd Qty(lsu)" meta:resourcekey="TemplateFieldResource7">
                                                            <ItemTemplate>
                                                                <%# Eval("RcvdLSUQty")%>
                                                                (<%# Eval("SellingUnit")%>)
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField HeaderText="Total Cost" DataField="TotalCost" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundFieldResource18" />
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <input id="hdnCollectedItems" runat="server" type="hidden" />
                        <input id="hdnConsumableItems" runat="server" type="hidden" />
                        <input id="hdnStatus" runat="server" type="hidden" />
                    </td>
                </tr>
                <tr>
                    <td class="a-center" colspan="3">
                        <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource2"></asp:Label>
                    </td>
                </tr>
            </table>      
        </div>
        <br />
        <div id="divGenerate">
            <table class="w-100p">
                <tr>
                    <td>
                         <%=Resources.StockReceived_ClientDisplay.StockReceived_BarcodeMapping_aspx_02%>
                        <asp:DropDownList ID="ddlProductList" CssClass="ddl"  
                            onchange="onChangeProductList();" runat="server" 
                            meta:resourcekey="ddlProductListResource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                     <asp:CheckBox ID="chkAutoBarcode" runat="server" onclick="AutoBarcode();" />
                        <asp:Label ID="lblAutoBarcode" runat="server" Text="AutoGenerateBarcode"></asp:Label>                    
                     
                    </td>
                    <td>
                          <%--<%=Resources.StockReceived_ClientDisplay.StockReceived_BarcodeMapping_aspx_03%>--%>
                          <asp:Label ID="lblReceivedQty" runat="server" Text="Received Quantity:"></asp:Label>
                        <asp:TextBox ID="txtReceivedQty" CssClass="small" runat="server" onkeypress="return ValidateMultiLangChar(this);"  Onblur="javascript:return getLastBarcode();" onchange="GenerateBarcode();" style="width:90px;" 
                            meta:resourcekey="txtReceivedQtyResource1"></asp:TextBox>
                    </td>                    
                    <td id="tdStartNo">
                          <%=Resources.StockReceived_ClientDisplay.StockReceived_BarcodeMapping_aspx_04%>
                        <asp:TextBox ID="txtStartNo" CssClass="small" runat="server" onkeypress="return ValidateMultiLangChar(this);" 
                            meta:resourcekey="txtStartNoResource1"></asp:TextBox>
                    </td>
                    <td id="tdEndNo">
                          <%=Resources.StockReceived_ClientDisplay.StockReceived_BarcodeMapping_aspx_05%>
                        <asp:TextBox ID="txtEndNo" CssClass="small" runat="server" onkeypress="return ValidateMultiLangChar(this);"
                            meta:resourcekey="txtEndNoResource1"></asp:TextBox>
                    </td>
                    <td id="tdGenerateBarcode">
                        <asp:Button ID="btGenerateBarcode" CssClass="btn" OnClientClick="javascript:return ItemBarcodeCreateTable(this);"
                            runat="server" Text="Generate" 
                            meta:resourcekey="btGenerateBarcodeResource1" />
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <asp:Panel ID="pnlTable" runat="server" meta:resourcekey="pnlTableResource1">
                            <table id="tblBarcodeMapping" class="w-100p gridView marginB10">
                                <thead class="gridTDHeader">
                                    <tr>
                                        <th class="hide">
                                             <%=Resources.StockReceived_ClientDisplay.StockReceived_BarcodeMapping_aspx_06%>
                                        </th>
                                        <th>
                                              <%=Resources.StockReceived_ClientDisplay.StockReceived_BarcodeMapping_aspx_07%>
                                        </th>
                                        <th>
                                              <%=Resources.StockReceived_ClientDisplay.StockReceived_BarcodeMapping_aspx_08%>
                                        </th>
                                        <th class="hide">
                                             <%=Resources.StockReceived_ClientDisplay.StockReceived_BarcodeMapping_aspx_09%>
                                        </th>
                                        <th class="hide">
                                              <%=Resources.StockReceived_ClientDisplay.StockReceived_BarcodeMapping_aspx_10%>
                                        </th>
                                        <th>
                                           <%=Resources.StockReceived_ClientDisplay.StockReceived_BarcodeMapping_aspx_11%>
                                        </th>
                                        <th class="hide">
                                              <%=Resources.StockReceived_ClientDisplay.StockReceived_BarcodeMapping_aspx_12%>
                                        </th>
                                         <th class="w-80">
                                              <%=Resources.StockReceived_ClientDisplay.StockReceived_BarcodeMapping_aspx_14%>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                   <asp:Label ID="lblTbody" runat="server"></asp:Label>                
                                </tbody>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                <%--<td>
                 <asp:Button ID="btnSave" Text="Save" runat="server" onmouseover="this.className='btn btnhov'"
                                    CssClass="btn" onmouseout="this.className='btn'" 
                        OnClientClick="javascript:return UploadData(this);" 
                        meta:resourcekey="btnSaveResource1" />
                </td>--%>
                </tr>
            </table>
        </div>
        <table class="w-100p">
            <tr>
                <td class="a-right w-45p">
                    <table id="trApproveBlock" class="hide w-100p" runat="server">
                        <tr>
                            <td>
                                <input type="hidden" id="hdnApproveStockReceived" runat="server" />
                                <asp:Button ID="btnApprove" Text="Approve" runat="server"
                                    CssClass="btn" OnClick="btnApprove_Click" meta:resourcekey="btnApproveResource2" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="w-55p">
                    <asp:Button ID="btnBack" Text="Back" runat="server" CssClass="cancel-btn" OnClick="btnBack_Click"
                        meta:resourcekey="btnBackResource2" />
                    <asp:Button ID="btnPrint" Text="Print" OnClientClick="CallPrint();return false;"
                        runat="server" CssClass="btn w-40" meta:resourcekey="btnPrintResource2" />
                    <asp:Button ID="btnInvoice" Text="MatchingInvoice" runat="server" CssClass="btn"
                        OnClick="btnInvoice_Click" meta:resourcekey="btnInvoiceResource2" />
                         <asp:Button ID="btnSave" Text="Save" runat="server"
                                    CssClass="btn"
                        OnClientClick="javascript:return UploadData(this);" 
                        meta:resourcekey="btnSaveResource1" />
                        
                </td>
            </tr>
        </table>
    </div>
       <asp:HiddenField ID="hdnCurrrentTaskID" runat="server" />
       <asp:HiddenField ID="hdnStockReceivedID" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnTaxcalcType" Value="" runat="server" />
    <asp:HiddenField ID="hdnREQCalcCompQTY" runat="server" Value="N" />
    <asp:HiddenField ID="hdnProductDet" runat="server" /> 
    <asp:HiddenField ID="hdnddlPro"   runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
    

    
</body>
</html>
